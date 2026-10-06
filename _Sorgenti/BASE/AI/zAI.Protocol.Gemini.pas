// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-14
// ---------------------------------------------------------------------------

unit zAI.Protocol.Gemini;

// Protocollo di conversazione di Google Gemini (API generateContent).
//
// Forma della richiesta:
//
//   {
//     "systemInstruction": { "parts": [ { "text": "..." } ] },
//     "contents": [
//       { "role": "user",  "parts": [ { "text": "domanda" } ] },
//       { "role": "model", "parts": [ { "functionCall": { "name": "f", "args": {...} } } ] },
//       { "role": "user",  "parts": [ { "functionResponse": { "name": "f", "response": {...} } } ] }
//     ],
//     "tools": [ { "functionDeclarations": [ { "name", "description", "parameters" } ] } ],
//     "generationConfig": { "temperature": 0.2, "maxOutputTokens": 2048 }
//   }
//
// Forma della risposta: candidates[0].content e' il turno del modello, con
// parti di testo e/o parti functionCall; finishReason dice perche' si e'
// fermato; promptFeedback.blockReason compare, senza candidati, quando la
// richiesta e' stata bloccata dai filtri.
//
// Il JSON si costruisce con System.JSON e non con le classi modello di
// SmartCoreAI (TAIGeminiFunctionDeclaration e compagne) per due motivi:
// la richiesta di SmartCoreAI (TAIGeminiGenerateContentRequest) non ha i campi
// tools e systemInstruction, e lo schema dei parametri che offre e' piatto
// (tipo e descrizione, niente enum). Il trasporto resta comunque quello del
// driver SmartCoreAI: questa unit produce e legge testo JSON, non apre
// connessioni.

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  zAI.Tools,
  zAI.Protocol;

type
  TzAIGeminiProtocol = class(TzAIProtocol)
  private
    FSystemInstruction: string;
    FContents: TJSONArray;
    function NewContent(const ARole: string): TJSONObject;
  public
    constructor Create; override;
    destructor Destroy; override;

    class function DriverName: string; override;

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
  GeminiDriverName = 'Gemini';
  RoleUser = 'user';
  RoleModel = 'model';
  // Motivi di arresto che indicano una risposta completa
  FinishReasonStop = 'STOP';

resourcestring
  MsgRispostaNonInterpretabile = 'Risposta del fornitore non interpretabile.';
  MsgRichiestaBloccata = 'Richiesta bloccata dal fornitore (motivo: %s).';
  MsgNessunCandidato = 'Il fornitore non ha prodotto nessuna risposta.';
  MsgRispostaInterrotta = 'Risposta interrotta dal fornitore (motivo: %s).';
  MsgRispostaVuota = 'Risposta vuota dal fornitore (motivo di arresto: %s).';

{ TzAIGeminiProtocol }

constructor TzAIGeminiProtocol.Create;
begin
  inherited Create;
  FContents := TJSONArray.Create;
end;

destructor TzAIGeminiProtocol.Destroy;
begin
  FContents.Free;
  inherited Destroy;
end;

class function TzAIGeminiProtocol.DriverName: string;
begin
  Result := GeminiDriverName;
end;

procedure TzAIGeminiProtocol.Reset;
begin
  FContents.Free;
  FContents := TJSONArray.Create;
  FSystemInstruction := '';
end;

procedure TzAIGeminiProtocol.SetSystemInstruction(const AText: string);
begin
  FSystemInstruction := Trim(AText);
end;

function TzAIGeminiProtocol.NewContent(const ARole: string): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('role', ARole);
  Result.AddPair('parts', TJSONArray.Create);
  FContents.Add(Result);
end;

procedure TzAIGeminiProtocol.AddUserText(const AText: string);
var
  Content: TJSONObject;
  Part: TJSONObject;
begin
  Content := NewContent(RoleUser);
  Part := TJSONObject.Create;
  Part.AddPair('text', AText);
  (Content.GetValue('parts') as TJSONArray).Add(Part);
end;

procedure TzAIGeminiProtocol.AddModelTurn(const ATurn: TJSONObject);
var
  Turno: TJSONObject;
begin
  if ATurn = nil then
    Exit;

  Turno := ATurn.Clone as TJSONObject;

  // Il ruolo a volte manca nella risposta: senza, il fornitore rifiuta la
  // conversazione rispedita
  if Turno.GetValue('role') = nil then
    Turno.AddPair('role', RoleModel);

  FContents.Add(Turno);
end;

procedure TzAIGeminiProtocol.AddFunctionResults(AResults: TzAIFunctionResults);
var
  Content: TJSONObject;
  Parts: TJSONArray;
  Risultato: TzAIFunctionResult;
  Part: TJSONObject;
  Response: TJSONObject;
begin
  if (AResults = nil) or (AResults.Count = 0) then
    Exit;

  // Tutti i risultati in un turno solo, con ruolo "user": e' la forma che la
  // documentazione REST di Gemini usa per functionResponse
  Content := NewContent(RoleUser);
  Parts := Content.GetValue('parts') as TJSONArray;

  for Risultato in AResults do
  begin
    Response := TJSONObject.Create;
    Response.AddPair('name', Risultato.Name);

    if Risultato.Id <> '' then
      Response.AddPair('id', Risultato.Id);

    // "response" deve essere un oggetto: il gestore dello strumento lo
    // garantisce (TzAITool.Execute non restituisce mai nil)
    Response.AddPair('response', Risultato.Value.Clone as TJSONObject);

    Part := TJSONObject.Create;
    Part.AddPair('functionResponse', Response);
    Parts.Add(Part);
  end;
end;

function TzAIGeminiProtocol.BuildRequest(ATools: TzAIToolSet;
  const ASettings: TzAIGenerationSettings): string;
var
  Request: TJSONObject;
  Instruction: TJSONObject;
  InstructionPart: TJSONObject;
  Tool: TJSONObject;
  GenerationConfig: TJSONObject;
begin
  Request := TJSONObject.Create;
  try
    if FSystemInstruction <> '' then
    begin
      InstructionPart := TJSONObject.Create;
      InstructionPart.AddPair('text', FSystemInstruction);
      Instruction := TJSONObject.Create;
      Instruction.AddPair('parts', TJSONArray.Create.Add(InstructionPart));
      Request.AddPair('systemInstruction', Instruction);
    end;

    Request.AddPair('contents', FContents.Clone as TJSONArray);

    if Assigned(ATools) and (ATools.Count > 0) then
    begin
      Tool := TJSONObject.Create;
      Tool.AddPair('functionDeclarations', ATools.Declarations);
      Request.AddPair('tools', TJSONArray.Create.Add(Tool));
    end;

    GenerationConfig := TJSONObject.Create;

    if ASettings.Temperature > 0 then
      GenerationConfig.AddPair('temperature', TJSONNumber.Create(ASettings.Temperature));

    if ASettings.MaxToken > 0 then
      GenerationConfig.AddPair('maxOutputTokens', TJSONNumber.Create(ASettings.MaxToken));

    if GenerationConfig.Count > 0 then
      Request.AddPair('generationConfig', GenerationConfig)
    else
      GenerationConfig.Free;

    Result := Request.ToJSON;
  finally
    Request.Free;
  end;
end;

function TzAIGeminiProtocol.ParseResponse(const AJson: string; out AText: string;
  ACalls: TzAIFunctionCalls; out AModelTurn: TJSONObject; out AError: string): Boolean;
var
  Root: TJSONValue;
  RootObject: TJSONObject;
  Candidates: TJSONArray;
  Candidate: TJSONObject;
  Content: TJSONObject;
  Parts: TJSONArray;
  Part: TJSONValue;
  PartObject: TJSONObject;
  FunctionCall: TJSONObject;
  Args: TJSONValue;
  ArgsClone: TJSONObject;
  Testo: string;
  FinishReason: string;
  BlockReason: string;
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

    // Errore dichiarato dal fornitore nel corpo (di norma arriva con un
    // codice HTTP di errore, ma non si da' per scontato)
    if RootObject.TryGetValue<string>('error.message', ErrorMessage) then
    begin
      AError := ErrorMessage;
      Exit;
    end;

    Candidates := RootObject.GetValue('candidates') as TJSONArray;

    if (Candidates = nil) or (Candidates.Count = 0) then
    begin
      if RootObject.TryGetValue<string>('promptFeedback.blockReason', BlockReason) then
        AError := Format(MsgRichiestaBloccata, [BlockReason])
      else
        AError := MsgNessunCandidato;

      Exit;
    end;

    Candidate := Candidates.Items[0] as TJSONObject;
    FinishReason := Candidate.GetValue<string>('finishReason', FinishReasonStop);
    Content := Candidate.GetValue('content') as TJSONObject;

    if Content = nil then
    begin
      // Capita coi filtri di sicurezza in uscita: il candidato c'e' ma senza
      // contenuto, e finishReason spiega
      AError := Format(MsgRispostaInterrotta, [FinishReason]);
      Exit;
    end;

    AModelTurn := Content.Clone as TJSONObject;
    Parts := Content.GetValue('parts') as TJSONArray;

    if Assigned(Parts) then
      for Part in Parts do
      begin
        if not (Part is TJSONObject) then
          Continue;

        PartObject := TJSONObject(Part);

        // Le parti marcate "thought" sono il ragionamento del modello, non
        // la risposta: si tengono nel turno riaccodato ma non si mostrano
        if PartObject.TryGetValue<string>('text', Testo) and
           not PartObject.GetValue<Boolean>('thought', False) then
          AText := AText + Testo;

        FunctionCall := PartObject.GetValue('functionCall') as TJSONObject;

        if Assigned(FunctionCall) then
        begin
          Args := FunctionCall.GetValue('args');

          if Args is TJSONObject then
            ArgsClone := Args.Clone as TJSONObject
          else
            ArgsClone := nil;

          ACalls.Add(TzAIFunctionCall.Create(
            FunctionCall.GetValue<string>('name', ''),
            FunctionCall.GetValue<string>('id', ''),
            ArgsClone));
        end;
      end;

    if (AText = '') and (ACalls.Count = 0) then
    begin
      // Un candidato senza testo e senza funzioni non ha nulla da consegnare:
      // di solito e' un arresto per limite di token o per sicurezza
      FreeAndNil(AModelTurn);
      AError := Format(MsgRispostaVuota, [FinishReason]);
      Exit;
    end;

    Result := True;
  finally
    Root.Free;
  end;
end;

initialization
  RegisterProtocol(TzAIGeminiProtocol);

end.
