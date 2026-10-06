// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-14
// ---------------------------------------------------------------------------

unit zAI.Protocol.Ollama;

// Protocollo di conversazione di Ollama (API /api/chat, modelli locali).
//
// E' il dialetto di OpenAI con quattro differenze, e per questo deriva da
// TzAIOpenAIProtocol:
//
//   - la radice della richiesta: "stream": false obbligatorio (altrimenti
//     arrivano righe JSON una per pezzo), e i parametri di generazione stanno
//     in "options" ("temperature", "num_predict");
//   - la radice della risposta: il turno e' in "message", non in
//     "choices[0].message"; il motivo di arresto in "done_reason"; l'errore e'
//     una stringa in "error";
//   - gli argomenti delle funzioni arrivano gia' come oggetto, non come
//     stringa JSON (ArgumentsToObject della classe base li accetta entrambi);
//   - il risultato di una funzione porta "tool_name" al posto di
//     "tool_call_id": le versioni meno recenti non assegnano identificativi
//     alle chiamate, e "tool_name" e' quello che il modello rilegge.
//
// Il trasporto: il driver SmartCoreAI di Ollama NON implementa
// ExecuteJSONRequest (solleva "not supported") e parla solo con
// /api/generate. Per questo il motore, per Ollama, crea TzAIOllamaDriver
// (zAI.Driver.Ollama), una sottoclasse che sa spedire un JSON qualunque
// all'endpoint indicato. Endpoint qui vale '/chat', relativo a BaseURL
// ('http://localhost:11434/api' se non configurato).
//
// Avvertenza sui modelli: il function calling funziona solo coi modelli che
// lo dichiarano (Llama 3.1 e successivi, Qwen 2.5 e successivi, Mistral,
// Command-R). Con gli altri Ollama risponde con un errore esplicito
// ("does not support tools"), che arriva in chat come errore leggibile.

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  zAI.Tools,
  zAI.Protocol,
  zAI.Protocol.OpenAI;

type
  TzAIOllamaProtocol = class(TzAIOpenAIProtocol)
  public
    class function DriverName: string; override;
    function Endpoint: string; override;

    procedure AddFunctionResults(AResults: TzAIFunctionResults); override;
    function BuildRequest(ATools: TzAIToolSet; const ASettings: TzAIGenerationSettings): string; override;
    function ParseResponse(const AJson: string; out AText: string;
      ACalls: TzAIFunctionCalls; out AModelTurn: TJSONObject;
      out AError: string): Boolean; override;
  end;

implementation

const
  OllamaDriverName = 'Ollama';
  // Stesso valore di cOllama_ChatEndpoint in SmartCoreAI.Consts
  ChatEndpoint = '/chat';
  RoleSystem = 'system';
  RoleTool = 'tool';
  DoneReasonStop = 'stop';

resourcestring
  MsgRispostaNonInterpretabile = 'Risposta del fornitore non interpretabile.';
  MsgRispostaVuota = 'Risposta vuota dal modello locale (motivo di arresto: %s).';

{ TzAIOllamaProtocol }

class function TzAIOllamaProtocol.DriverName: string;
begin
  Result := OllamaDriverName;
end;

function TzAIOllamaProtocol.Endpoint: string;
begin
  Result := ChatEndpoint;
end;

procedure TzAIOllamaProtocol.AddFunctionResults(AResults: TzAIFunctionResults);
var
  Risultato: TzAIFunctionResult;
  Message: TJSONObject;
begin
  if (AResults = nil) or (AResults.Count = 0) then
    Exit;

  for Risultato in AResults do
  begin
    Message := TJSONObject.Create;
    Message.AddPair('role', RoleTool);
    Message.AddPair('tool_name', Risultato.Name);

    // Le versioni recenti assegnano un identificativo e lo rivogliono:
    // si manda solo se c'era
    if Risultato.Id <> '' then
      Message.AddPair('tool_call_id', Risultato.Id);

    Message.AddPair('content', Risultato.Value.ToJSON);
    Messages.Add(Message);
  end;
end;

function TzAIOllamaProtocol.BuildRequest(ATools: TzAIToolSet;
  const ASettings: TzAIGenerationSettings): string;
var
  Request: TJSONObject;
  MessageList: TJSONArray;
  Message: TJSONObject;
  Options: TJSONObject;
begin
  Request := TJSONObject.Create;
  try
    Request.AddPair('model', ASettings.Model);
    // Senza questo la risposta arriva a pezzi, una riga JSON per parola
    Request.AddPair('stream', TJSONBool.Create(False));

    MessageList := TJSONArray.Create;

    if SystemInstruction <> '' then
    begin
      Message := TJSONObject.Create;
      Message.AddPair('role', RoleSystem);
      Message.AddPair('content', SystemInstruction);
      MessageList.Add(Message);
    end;

    for var Item in Messages do
      MessageList.Add(Item.Clone as TJSONObject);

    Request.AddPair('messages', MessageList);

    if Assigned(ATools) and (ATools.Count > 0) then
      Request.AddPair('tools', ToolsDeclaration(ATools));

    Options := TJSONObject.Create;

    if ASettings.Temperature > 0 then
      Options.AddPair('temperature', TJSONNumber.Create(ASettings.Temperature));

    if ASettings.MaxToken > 0 then
      Options.AddPair('num_predict', TJSONNumber.Create(ASettings.MaxToken));

    if Options.Count > 0 then
      Request.AddPair('options', Options)
    else
      Options.Free;

    Result := Request.ToJSON;
  finally
    Request.Free;
  end;
end;

function TzAIOllamaProtocol.ParseResponse(const AJson: string; out AText: string;
  ACalls: TzAIFunctionCalls; out AModelTurn: TJSONObject; out AError: string): Boolean;
var
  Root: TJSONValue;
  RootObject: TJSONObject;
  Message: TJSONObject;
  Content: TJSONValue;
  DoneReason: string;
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

    // Qui l'errore e' una stringa alla radice, non un oggetto
    if RootObject.TryGetValue<string>('error', ErrorMessage) then
    begin
      AError := ErrorMessage;
      Exit;
    end;

    DoneReason := RootObject.GetValue<string>('done_reason', DoneReasonStop);
    Message := RootObject.GetValue('message') as TJSONObject;

    if Message = nil then
    begin
      AError := Format(MsgRispostaVuota, [DoneReason]);
      Exit;
    end;

    Content := Message.GetValue('content');

    if Content is TJSONString then
      AText := Content.Value;

    ParseToolCalls(Message, ACalls);

    if (AText = '') and (ACalls.Count = 0) then
    begin
      AError := Format(MsgRispostaVuota, [DoneReason]);
      Exit;
    end;

    // Ricostruito coi soli campi role, content e tool_calls: il campo
    // "thinking" dei modelli che ragionano non va rispedito
    AModelTurn := SanitizedAssistantTurn(Message);
    Result := True;
  finally
    Root.Free;
  end;
end;

initialization
  RegisterProtocol(TzAIOllamaProtocol);

end.
