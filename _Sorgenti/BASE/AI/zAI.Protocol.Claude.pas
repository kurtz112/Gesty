// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-14
// ---------------------------------------------------------------------------

unit zAI.Protocol.Claude;

// Protocollo di conversazione di Anthropic Claude (API Messages).
//
// Forma della richiesta:
//
//   {
//     "model": "claude-sonnet-4-5",
//     "max_tokens": 4096,                       <- OBBLIGATORIO
//     "system": "...",
//     "messages": [
//       { "role": "user",      "content": "domanda" },
//       { "role": "assistant", "content": [ { "type": "text", "text": "..." },
//                                           { "type": "tool_use", "id": "toolu_1",
//                                             "name": "f", "input": {...} } ] },
//       { "role": "user",      "content": [ { "type": "tool_result",
//                                             "tool_use_id": "toolu_1",
//                                             "content": "{...}" } ] }
//     ],
//     "tools": [ { "name", "description", "input_schema": {...} } ],
//     "temperature": 0.2
//   }
//
// Forma della risposta: la radice e' il messaggio dell'assistente, con
// content[] fatto di blocchi "text" e "tool_use"; stop_reason vale
// "end_turn", "tool_use", "max_tokens" o "refusal". Un errore ha
// type = "error" e error.message.
//
// Il turno del modello si riaccoda con il content[] COSI' COME RICEVUTO:
// coi modelli che ragionano contiene blocchi "thinking" con una firma che
// il servizio vuole rivedere nel turno successivo.
//
// Due vincoli propri di questo dialetto: max_tokens e' obbligatorio (se la
// configurazione non lo indica si manda un valore prudente), e ogni
// strumento deve avere input_schema anche senza parametri.

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  zAI.Tools,
  zAI.Protocol;

type
  TzAIClaudeProtocol = class(TzAIProtocol)
  private
    FSystemInstruction: string;
    FMessages: TJSONArray;
    function ToolsDeclaration(ATools: TzAIToolSet): TJSONArray;
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
  ClaudeDriverName = 'Claude';
  // Stesso valore di cClaude_MessagesEndpoint in SmartCoreAI.Consts: il driver
  // lo accoda a BaseURL ('https://api.anthropic.com/v1' se non configurato)
  MessagesEndpoint = '/messages';
  RoleUser = 'user';
  RoleAssistant = 'assistant';
  BlockText = 'text';
  BlockToolUse = 'tool_use';
  BlockToolResult = 'tool_result';
  StopReasonEndTurn = 'end_turn';
  // max_tokens quando la configurazione non lo indica. Il servizio lo esige;
  // 4096 basta a una risposta di chat e non e' un limite di spesa
  DefaultMaxTokens = 4096;
  // Chiave con cui TzAITool.Errore marca un risultato fallito: Claude
  // permette di segnalarlo esplicitamente con is_error
  ChiaveErrore = 'errore';

resourcestring
  MsgRispostaNonInterpretabile = 'Risposta del fornitore non interpretabile.';
  MsgRispostaVuota = 'Risposta vuota dal fornitore (motivo di arresto: %s).';

{ TzAIClaudeProtocol }

constructor TzAIClaudeProtocol.Create;
begin
  inherited Create;
  FMessages := TJSONArray.Create;
end;

destructor TzAIClaudeProtocol.Destroy;
begin
  FMessages.Free;
  inherited Destroy;
end;

class function TzAIClaudeProtocol.DriverName: string;
begin
  Result := ClaudeDriverName;
end;

function TzAIClaudeProtocol.Endpoint: string;
begin
  Result := MessagesEndpoint;
end;

procedure TzAIClaudeProtocol.Reset;
begin
  FMessages.Free;
  FMessages := TJSONArray.Create;
  FSystemInstruction := '';
end;

procedure TzAIClaudeProtocol.SetSystemInstruction(const AText: string);
begin
  FSystemInstruction := Trim(AText);
end;

procedure TzAIClaudeProtocol.AddUserText(const AText: string);
var
  Message: TJSONObject;
begin
  Message := TJSONObject.Create;
  Message.AddPair('role', RoleUser);
  Message.AddPair('content', AText);
  FMessages.Add(Message);
end;

procedure TzAIClaudeProtocol.AddModelTurn(const ATurn: TJSONObject);
var
  Turno: TJSONObject;
begin
  if ATurn = nil then
    Exit;

  Turno := ATurn.Clone as TJSONObject;

  if Turno.GetValue('role') = nil then
    Turno.AddPair('role', RoleAssistant);

  FMessages.Add(Turno);
end;

procedure TzAIClaudeProtocol.AddFunctionResults(AResults: TzAIFunctionResults);
var
  Message: TJSONObject;
  Blocks: TJSONArray;
  Risultato: TzAIFunctionResult;
  Block: TJSONObject;
begin
  if (AResults = nil) or (AResults.Count = 0) then
    Exit;

  // Tutti i risultati in un messaggio "user" solo: il servizio esige che
  // ogni tool_use del turno precedente trovi il proprio tool_result nel
  // messaggio immediatamente successivo
  Blocks := TJSONArray.Create;

  for Risultato in AResults do
  begin
    Block := TJSONObject.Create;
    Block.AddPair('type', BlockToolResult);
    Block.AddPair('tool_use_id', Risultato.Id);
    Block.AddPair('content', Risultato.Value.ToJSON);

    // Un risultato che porta la chiave dell'errore di TzAITool viene marcato:
    // il modello lo tratta come fallimento e non come dato
    if Risultato.Value.GetValue(ChiaveErrore) <> nil then
      Block.AddPair('is_error', TJSONBool.Create(True));

    Blocks.Add(Block);
  end;

  Message := TJSONObject.Create;
  Message.AddPair('role', RoleUser);
  Message.AddPair('content', Blocks);
  FMessages.Add(Message);
end;

function TzAIClaudeProtocol.ToolsDeclaration(ATools: TzAIToolSet): TJSONArray;
var
  Index: Integer;
  Declaration: TJSONObject;
  Parameters: TJSONPair;
  Tool: TJSONObject;
begin
  Result := TJSONArray.Create;

  for Index := 0 to ATools.Count - 1 do
  begin
    // La dichiarazione neutra usa "parameters"; qui si chiama "input_schema"
    // ed e' obbligatoria anche vuota
    Declaration := ATools[Index].Declaration(True);
    try
      Tool := TJSONObject.Create;
      Tool.AddPair('name', Declaration.GetValue<string>('name', ''));
      Tool.AddPair('description', Declaration.GetValue<string>('description', ''));

      Parameters := Declaration.RemovePair('parameters');

      if Assigned(Parameters) then
      begin
        Tool.AddPair('input_schema', Parameters.JsonValue.Clone as TJSONObject);
        Parameters.Free;
      end;

      Result.Add(Tool);
    finally
      Declaration.Free;
    end;
  end;
end;

function TzAIClaudeProtocol.BuildRequest(ATools: TzAIToolSet;
  const ASettings: TzAIGenerationSettings): string;
var
  Request: TJSONObject;
  MaxTokens: Integer;
begin
  Request := TJSONObject.Create;
  try
    Request.AddPair('model', ASettings.Model);

    if ASettings.MaxToken > 0 then
      MaxTokens := ASettings.MaxToken
    else
      MaxTokens := DefaultMaxTokens;

    Request.AddPair('max_tokens', TJSONNumber.Create(MaxTokens));

    if FSystemInstruction <> '' then
      Request.AddPair('system', FSystemInstruction);

    Request.AddPair('messages', FMessages.Clone as TJSONArray);

    if Assigned(ATools) and (ATools.Count > 0) then
      Request.AddPair('tools', ToolsDeclaration(ATools));

    if ASettings.Temperature > 0 then
      Request.AddPair('temperature', TJSONNumber.Create(ASettings.Temperature));

    Result := Request.ToJSON;
  finally
    Request.Free;
  end;
end;

function TzAIClaudeProtocol.ParseResponse(const AJson: string; out AText: string;
  ACalls: TzAIFunctionCalls; out AModelTurn: TJSONObject; out AError: string): Boolean;
var
  Root: TJSONValue;
  RootObject: TJSONObject;
  Content: TJSONArray;
  Item: TJSONValue;
  Block: TJSONObject;
  BlockType: string;
  Input: TJSONValue;
  InputClone: TJSONObject;
  StopReason: string;
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

    StopReason := RootObject.GetValue<string>('stop_reason', StopReasonEndTurn);
    Content := RootObject.GetValue('content') as TJSONArray;

    if (Content = nil) or (Content.Count = 0) then
    begin
      AError := Format(MsgRispostaVuota, [StopReason]);
      Exit;
    end;

    for Item in Content do
    begin
      if not (Item is TJSONObject) then
        Continue;

      Block := TJSONObject(Item);
      BlockType := Block.GetValue<string>('type', '');

      if BlockType = BlockText then
        AText := AText + Block.GetValue<string>('text', '')
      else
        if BlockType = BlockToolUse then
        begin
          Input := Block.GetValue('input');

          if Input is TJSONObject then
            InputClone := Input.Clone as TJSONObject
          else
            InputClone := nil;

          ACalls.Add(TzAIFunctionCall.Create(
            Block.GetValue<string>('name', ''),
            Block.GetValue<string>('id', ''),
            InputClone));
        end;
      // I blocchi "thinking" non si mostrano: restano nel turno riaccodato
    end;

    if (AText = '') and (ACalls.Count = 0) then
    begin
      AError := Format(MsgRispostaVuota, [StopReason]);
      Exit;
    end;

    // Il turno da riaccodare: ruolo assistant e il content[] intero
    AModelTurn := TJSONObject.Create;
    AModelTurn.AddPair('role', RoleAssistant);
    AModelTurn.AddPair('content', Content.Clone as TJSONArray);
    Result := True;
  finally
    Root.Free;
  end;
end;

initialization
  RegisterProtocol(TzAIClaudeProtocol);

end.
