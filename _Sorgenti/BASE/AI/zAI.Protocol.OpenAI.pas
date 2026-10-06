// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-14
// ---------------------------------------------------------------------------

unit zAI.Protocol.OpenAI;

// Protocollo di conversazione di OpenAI (API chat/completions).
//
// E' anche il dialetto "di fatto" dei servizi compatibili (Azure OpenAI,
// LM Studio, vLLM, Groq, l'adattatore OpenAI di Ollama): basta cambiare
// BaseURL nella configurazione. Per questo si resta sui campi che tutti
// capiscono: "max_tokens" e non il piu' recente "max_completion_tokens",
// niente "parallel_tool_calls", niente "store".
//
// Forma della richiesta:
//
//   {
//     "model": "gpt-4.1",
//     "messages": [
//       { "role": "system",    "content": "..." },
//       { "role": "user",      "content": "domanda" },
//       { "role": "assistant", "content": null,
//         "tool_calls": [ { "id": "call_1", "type": "function",
//                           "function": { "name": "f", "arguments": "{...}" } } ] },
//       { "role": "tool", "tool_call_id": "call_1", "content": "{...}" }
//     ],
//     "tools": [ { "type": "function", "function": { "name", "description", "parameters" } } ],
//     "temperature": 0.2, "max_tokens": 2048
//   }
//
// Forma della risposta: choices[0].message e' il turno del modello, con
// content (testo, o null) e tool_calls; finish_reason vale "stop",
// "tool_calls", "length" o "content_filter". Gli argomenti delle funzioni
// arrivano come TESTO JSON dentro una stringa, non come oggetto: vanno
// interpretati.
//
// Il turno del modello si riaccoda ricostruito coi soli campi role, content e
// tool_calls: la risposta porta anche campi come "refusal" e "annotations",
// che alcuni servizi rifiutano se li rivedono in ingresso.
//
// zAI.Protocol.Ollama deriva da questa classe: il dialetto di Ollama e' lo
// stesso a meno della radice della richiesta e della risposta.

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  zAI.Tools,
  zAI.Protocol;

type
  TzAIOpenAIProtocol = class(TzAIProtocol)
  private
    FSystemInstruction: string;
    FMessages: TJSONArray;
  protected
    property Messages: TJSONArray read FMessages;
    property SystemInstruction: string read FSystemInstruction;

    // Elenco "tools" nella forma {"type":"function","function":{...}},
    // comune a OpenAI e Ollama. Nuovo, di proprieta' del chiamante
    function ToolsDeclaration(ATools: TzAIToolSet): TJSONArray;

    // Turno dell'assistente ricostruito coi soli campi role, content e
    // tool_calls. Nuovo, di proprieta' del chiamante
    function SanitizedAssistantTurn(const AMessage: TJSONObject): TJSONObject;

    // Gli argomenti di una chiamata: stringa JSON (OpenAI) o oggetto
    // (Ollama). Nuovo, di proprieta' del chiamante; mai nil
    function ArgumentsToObject(const AArguments: TJSONValue): TJSONObject;

    // Legge message.tool_calls e li aggiunge ad ACalls
    procedure ParseToolCalls(const AMessage: TJSONObject; ACalls: TzAIFunctionCalls);

    // Messaggio con ruolo e testo
    procedure AddTextMessage(const ARole, AText: string);
  public
    constructor Create; override;
    destructor Destroy; override;

    class function DriverName: string; override;
    function Endpoint: string; override;

    procedure Reset; override;
    procedure SetSystemInstruction(const AText: string); override;
    procedure AddUserText(const AText: string); override;
    procedure AddModelTurn(const ATurn: TJSONObject); override;
    procedure AddFunctionResults(AResults: TzAIFunctionResults); override;
    function BuildRequest(ATools: TzAIToolSet; const ASettings: TzAIGenerationSettings): string; override;
    function ParseResponse(const AJson: string; out AText: string;
      ACalls: TzAIFunctionCalls; out AModelTurn: TJSONObject;
      out AError: string): Boolean; override;
  end;

implementation

const
  OpenAIDriverName = 'OpenAI';
  // Stesso valore di cOpenAI_ChatEndpoint in SmartCoreAI.Consts: il driver
  // lo accoda a BaseURL ('https://api.openai.com/v1' se non configurato)
  ChatCompletionsEndpoint = '/chat/completions';
  RoleSystem = 'system';
  RoleUser = 'user';
  RoleAssistant = 'assistant';
  RoleTool = 'tool';
  FinishReasonStop = 'stop';

resourcestring
  MsgRispostaNonInterpretabile = 'Risposta del fornitore non interpretabile.';
  MsgNessunaScelta = 'Il fornitore non ha prodotto nessuna risposta.';
  MsgRispostaVuota = 'Risposta vuota dal fornitore (motivo di arresto: %s).';

{ TzAIOpenAIProtocol }

constructor TzAIOpenAIProtocol.Create;
begin
  inherited Create;
  FMessages := TJSONArray.Create;
end;

destructor TzAIOpenAIProtocol.Destroy;
begin
  FMessages.Free;
  inherited Destroy;
end;

class function TzAIOpenAIProtocol.DriverName: string;
begin
  Result := OpenAIDriverName;
end;

function TzAIOpenAIProtocol.Endpoint: string;
begin
  Result := ChatCompletionsEndpoint;
end;

procedure TzAIOpenAIProtocol.Reset;
begin
  FMessages.Free;
  FMessages := TJSONArray.Create;
  FSystemInstruction := '';
end;

procedure TzAIOpenAIProtocol.SetSystemInstruction(const AText: string);
begin
  FSystemInstruction := Trim(AText);
end;

procedure TzAIOpenAIProtocol.AddTextMessage(const ARole, AText: string);
var
  Message: TJSONObject;
begin
  Message := TJSONObject.Create;
  Message.AddPair('role', ARole);
  Message.AddPair('content', AText);
  FMessages.Add(Message);
end;

procedure TzAIOpenAIProtocol.AddUserText(const AText: string);
begin
  AddTextMessage(RoleUser, AText);
end;

function TzAIOpenAIProtocol.SanitizedAssistantTurn(const AMessage: TJSONObject): TJSONObject;
var
  Content: TJSONValue;
  ToolCalls: TJSONValue;
begin
  Result := TJSONObject.Create;
  Result.AddPair('role', RoleAssistant);

  Content := AMessage.GetValue('content');

  // Con le sole chiamate di funzione il testo e' null: si rispedisce null,
  // non una stringa vuota, perche' e' cosi' che il fornitore lo ha mandato
  if (Content = nil) or (Content is TJSONNull) then
    Result.AddPair('content', TJSONNull.Create)
  else
    Result.AddPair('content', Content.Clone as TJSONValue);

  ToolCalls := AMessage.GetValue('tool_calls');

  if ToolCalls is TJSONArray then
    Result.AddPair('tool_calls', ToolCalls.Clone as TJSONArray);
end;

procedure TzAIOpenAIProtocol.AddModelTurn(const ATurn: TJSONObject);
begin
  if ATurn = nil then
    Exit;

  FMessages.Add(SanitizedAssistantTurn(ATurn));
end;

procedure TzAIOpenAIProtocol.AddFunctionResults(AResults: TzAIFunctionResults);
var
  Risultato: TzAIFunctionResult;
  Message: TJSONObject;
begin
  if (AResults = nil) or (AResults.Count = 0) then
    Exit;

  // Un messaggio per risultato, con l'identificativo della chiamata: e' cosi'
  // che il fornitore ricollega risultato e richiesta quando sono piu' d'una.
  // Il contenuto e' testo: il JSON del risultato reso stringa
  for Risultato in AResults do
  begin
    Message := TJSONObject.Create;
    Message.AddPair('role', RoleTool);
    Message.AddPair('tool_call_id', Risultato.Id);
    Message.AddPair('content', Risultato.Value.ToJSON);
    FMessages.Add(Message);
  end;
end;

function TzAIOpenAIProtocol.ToolsDeclaration(ATools: TzAIToolSet): TJSONArray;
var
  Index: Integer;
  Tool: TJSONObject;
begin
  Result := TJSONArray.Create;

  for Index := 0 to ATools.Count - 1 do
  begin
    Tool := TJSONObject.Create;
    Tool.AddPair('type', 'function');
    // Con lo schema vuoto quando non ci sono parametri: qui e' ammesso, e
    // alcuni servizi compatibili lo pretendono
    Tool.AddPair('function', ATools[Index].Declaration(True));
    Result.Add(Tool);
  end;
end;

function TzAIOpenAIProtocol.BuildRequest(ATools: TzAIToolSet;
  const ASettings: TzAIGenerationSettings): string;
var
  Request: TJSONObject;
  Messages: TJSONArray;
  Message: TJSONObject;
begin
  Request := TJSONObject.Create;
  try
    Request.AddPair('model', ASettings.Model);

    Messages := TJSONArray.Create;

    if FSystemInstruction <> '' then
    begin
      Message := TJSONObject.Create;
      Message.AddPair('role', RoleSystem);
      Message.AddPair('content', FSystemInstruction);
      Messages.Add(Message);
    end;

    for var Item in FMessages do
      Messages.Add(Item.Clone as TJSONObject);

    Request.AddPair('messages', Messages);

    if Assigned(ATools) and (ATools.Count > 0) then
      Request.AddPair('tools', ToolsDeclaration(ATools));

    if ASettings.Temperature > 0 then
      Request.AddPair('temperature', TJSONNumber.Create(ASettings.Temperature));

    if ASettings.MaxToken > 0 then
      Request.AddPair('max_tokens', TJSONNumber.Create(ASettings.MaxToken));

    Result := Request.ToJSON;
  finally
    Request.Free;
  end;
end;

function TzAIOpenAIProtocol.ArgumentsToObject(const AArguments: TJSONValue): TJSONObject;
var
  Parsed: TJSONValue;
begin
  Result := nil;

  if AArguments is TJSONObject then
    Exit(AArguments.Clone as TJSONObject);

  if AArguments is TJSONString then
  begin
    Parsed := TJSONObject.ParseJSONValue(AArguments.Value);

    if Parsed is TJSONObject then
      Exit(TJSONObject(Parsed));

    Parsed.Free;

    // Testo che non e' un oggetto JSON: si consegna grezzo, cosi' lo
    // strumento (o il modello, leggendo l'errore) capisce cosa e' successo
    Result := TJSONObject.Create;
    Result.AddPair('raw', AArguments.Value);
    Exit;
  end;

  Result := TJSONObject.Create;
end;

procedure TzAIOpenAIProtocol.ParseToolCalls(const AMessage: TJSONObject; ACalls: TzAIFunctionCalls);
var
  ToolCalls: TJSONArray;
  Item: TJSONValue;
  Call: TJSONObject;
  FunctionObject: TJSONObject;
begin
  ToolCalls := AMessage.GetValue('tool_calls') as TJSONArray;

  if ToolCalls = nil then
    Exit;

  for Item in ToolCalls do
  begin
    if not (Item is TJSONObject) then
      Continue;

    Call := TJSONObject(Item);
    FunctionObject := Call.GetValue('function') as TJSONObject;

    if FunctionObject = nil then
      Continue;

    ACalls.Add(TzAIFunctionCall.Create(
      FunctionObject.GetValue<string>('name', ''),
      Call.GetValue<string>('id', ''),
      ArgumentsToObject(FunctionObject.GetValue('arguments'))));
  end;
end;

function TzAIOpenAIProtocol.ParseResponse(const AJson: string; out AText: string;
  ACalls: TzAIFunctionCalls; out AModelTurn: TJSONObject; out AError: string): Boolean;
var
  Root: TJSONValue;
  RootObject: TJSONObject;
  Choices: TJSONArray;
  Choice: TJSONObject;
  Message: TJSONObject;
  Content: TJSONValue;
  FinishReason: string;
  ErrorMessage: string;
begin
  Result := False;
  AText := '';
  AError := '';
  AModelTurn := nil;

  Root := TJSONObject.ParseJSONValue(AJson);
  try
    if not (Root is TJSONObject) then
    begin
      AError := MsgRispostaNonInterpretabile;
      Exit;
    end;

    RootObject := TJSONObject(Root);

    if RootObject.TryGetValue<string>('error.message', ErrorMessage) then
    begin
      AError := ErrorMessage;
      Exit;
    end;

    Choices := RootObject.GetValue('choices') as TJSONArray;

    if (Choices = nil) or (Choices.Count = 0) then
    begin
      AError := MsgNessunaScelta;
      Exit;
    end;

    Choice := Choices.Items[0] as TJSONObject;
    FinishReason := Choice.GetValue<string>('finish_reason', FinishReasonStop);
    Message := Choice.GetValue('message') as TJSONObject;

    if Message = nil then
    begin
      AError := Format(MsgRispostaVuota, [FinishReason]);
      Exit;
    end;

    Content := Message.GetValue('content');

    if Content is TJSONString then
      AText := Content.Value;

    ParseToolCalls(Message, ACalls);

    if (AText = '') and (ACalls.Count = 0) then
    begin
      AError := Format(MsgRispostaVuota, [FinishReason]);
      Exit;
    end;

    AModelTurn := SanitizedAssistantTurn(Message);
    Result := True;
  finally
    Root.Free;
  end;
end;

initialization
  RegisterProtocol(TzAIOpenAIProtocol);

end.
