// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-14
// ---------------------------------------------------------------------------

unit zAI.Protocol;

// Protocollo di conversazione con un fornitore AI: contratto astratto.
//
// I driver SmartCoreAI espongono una sola chiamata di chat, Chat(Prompt), che
// manda un testo e legge il primo pezzo di testo della risposta. Per il
// function calling non basta: bisogna mandare l'elenco degli strumenti,
// riconoscere nella risposta la richiesta "chiama la funzione X", rispedire
// il risultato dentro la stessa conversazione e ripetere. Tutto questo e'
// scritto nel dialetto JSON di ciascun fornitore.
//
// Un TzAIProtocol e' l'oggetto che conosce quel dialetto. Tiene la
// conversazione in corso (turni utente, turni del modello, risultati delle
// funzioni) e sa fare due cose: costruire il JSON della richiesta e
// interpretare il JSON della risposta. Il trasporto HTTP resta al driver
// SmartCoreAI (ExecuteJSONRequest), che gia' conosce indirizzo, chiave,
// modello e tempi di attesa: il protocollo non apre connessioni.
//
// Un protocollo per fornitore, registrato col nome del driver SmartCoreAI
// (RegisterProtocol nella sezione initialization della sua unit). Il motore
// chiede ProtocolClassOf(Configuration.DriverName): nil vuol dire che per
// quel fornitore il function calling non e' ancora stato scritto.

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.Generics.Collections,
  zAI.Tools;

type
  // Una funzione che il modello chiede di eseguire. Id e' l'identificativo
  // della chiamata quando il fornitore lo assegna (OpenAI sempre, Gemini
  // solo in alcune modalita'): va restituito tale e quale col risultato.
  TzAIFunctionCall = class
  private
    FName: string;
    FId: string;
    FArgs: TJSONObject;
  public
    // AArgs passa di proprieta'; nil diventa un oggetto vuoto
    constructor Create(const AName, AId: string; AArgs: TJSONObject);
    destructor Destroy; override;

    property Name: string read FName;
    property Id: string read FId;
    property Args: TJSONObject read FArgs;
  end;

  TzAIFunctionCalls = class(TObjectList<TzAIFunctionCall>);

  // Il risultato di una funzione eseguita, da rispedire al modello
  TzAIFunctionResult = class
  private
    FName: string;
    FId: string;
    FValue: TJSONObject;
  public
    // AValue passa di proprieta'; nil diventa un oggetto vuoto
    constructor Create(const AName, AId: string; AValue: TJSONObject);
    destructor Destroy; override;

    property Name: string read FName;
    property Id: string read FId;
    property Value: TJSONObject read FValue;
  end;

  TzAIFunctionResults = class(TObjectList<TzAIFunctionResult>);

  // Parametri di generazione. Zero o vuoto = non trasmesso, decide il
  // fornitore. Model serve ai dialetti che lo vogliono nel corpo della
  // richiesta (OpenAI, Claude, Ollama); Gemini lo ha nell'indirizzo
  TzAIGenerationSettings = record
    Model: string;
    Temperature: Double;
    MaxToken: Integer;
  end;

  TzAIProtocol = class abstract
  public
    constructor Create; virtual;

    // Nome del driver SmartCoreAI servito ('Gemini', 'OpenAI', ...)
    class function DriverName: string; virtual; abstract;

    // Endpoint da passare a ExecuteJSONRequest del driver, relativo al suo
    // BaseURL ('/chat/completions', '/messages', '/chat'). Vuoto = il driver
    // usa il proprio predefinito (Gemini ignora il parametro)
    function Endpoint: string; virtual;

    // Svuota la conversazione. Si chiama all'inizio di ogni domanda: la
    // memoria fra una domanda e l'altra la fornisce chi chiama, nel testo
    procedure Reset; virtual; abstract;

    // Istruzioni permanenti, nel ruolo di sistema del fornitore (non piu'
    // anteposte al testo dell'utente)
    procedure SetSystemInstruction(const AText: string); virtual; abstract;

    // Turno dell'utente
    procedure AddUserText(const AText: string); virtual; abstract;

    // Turno del modello COSI' COME RICEVUTO, nel JSON del fornitore (e' il
    // ModelTurn restituito da ParseResponse). Si riaccoda tale e quale perche'
    // puo' contenere campi opachi che il fornitore vuole rivedere: Gemini,
    // per esempio, con i modelli che ragionano allega una "firma del
    // pensiero" alla richiesta di funzione, e se manca rifiuta il turno
    // successivo. L'oggetto viene clonato: resta del chiamante
    procedure AddModelTurn(const ATurn: TJSONObject); virtual; abstract;

    // Risultati delle funzioni eseguite, un turno solo per tutte
    procedure AddFunctionResults(AResults: TzAIFunctionResults); virtual; abstract;

    // JSON completo della richiesta: istruzioni, conversazione, strumenti
    // (se ATools ha elementi), parametri di generazione
    function BuildRequest(ATools: TzAIToolSet; const ASettings: TzAIGenerationSettings): string; virtual; abstract;

    // Interpreta la risposta del fornitore.
    //   AText       testo della risposta (vuoto se il modello ha solo chiesto funzioni)
    //   ACalls      funzioni richieste, aggiunte alla lista passata (che il chiamante possiede)
    //   AModelTurn  il turno del modello da riaccodare con AddModelTurn; nuovo,
    //               di proprieta' del chiamante, nil se la risposta non ne ha
    //   AError      motivo del fallimento quando il risultato e' Falso
    // Falso = il fornitore ha rifiutato, bloccato o non ha risposto: niente
    // testo e niente funzioni, il motore riporta AError
    function ParseResponse(const AJson: string; out AText: string;
      ACalls: TzAIFunctionCalls; out AModelTurn: TJSONObject;
      out AError: string): Boolean; virtual; abstract;
  end;

  TzAIProtocolClass = class of TzAIProtocol;

// Registro dei protocolli, per nome del driver (confronto senza maiuscole)
procedure RegisterProtocol(AClass: TzAIProtocolClass);
function ProtocolClassOf(const ADriverName: string): TzAIProtocolClass;

implementation

var
  Registro: TDictionary<string, TzAIProtocolClass> = nil;

procedure RegisterProtocol(AClass: TzAIProtocolClass);
begin
  if Registro = nil then
    Registro := TDictionary<string, TzAIProtocolClass>.Create;

  Registro.AddOrSetValue(AClass.DriverName.ToUpper, AClass);
end;

function ProtocolClassOf(const ADriverName: string): TzAIProtocolClass;
begin
  Result := nil;

  if Registro = nil then
    Exit;

  Registro.TryGetValue(ADriverName.ToUpper, Result);
end;

{ TzAIFunctionCall }

constructor TzAIFunctionCall.Create(const AName, AId: string; AArgs: TJSONObject);
begin
  inherited Create;
  FName := AName;
  FId := AId;

  if Assigned(AArgs) then
    FArgs := AArgs
  else
    FArgs := TJSONObject.Create;
end;

destructor TzAIFunctionCall.Destroy;
begin
  FArgs.Free;
  inherited Destroy;
end;

{ TzAIFunctionResult }

constructor TzAIFunctionResult.Create(const AName, AId: string; AValue: TJSONObject);
begin
  inherited Create;
  FName := AName;
  FId := AId;

  if Assigned(AValue) then
    FValue := AValue
  else
    FValue := TJSONObject.Create;
end;

destructor TzAIFunctionResult.Destroy;
begin
  FValue.Free;
  inherited Destroy;
end;

{ TzAIProtocol }

constructor TzAIProtocol.Create;
begin
  inherited Create;
end;

function TzAIProtocol.Endpoint: string;
begin
  Result := '';
end;

initialization

finalization
  FreeAndNil(Registro);

end.
