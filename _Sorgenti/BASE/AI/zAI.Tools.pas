// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-08
// ---------------------------------------------------------------------------

unit zAI.Tools;

// Strumenti (funzioni) che il modello AI puo' chiedere di eseguire.
//
// Il "function calling" funziona cosi': insieme alla domanda si manda al
// modello l'elenco delle funzioni disponibili, ognuna col nome, una
// descrizione in linguaggio naturale e lo schema dei parametri. Il modello,
// se ritiene di averne bisogno, invece di rispondere col testo risponde con
// "chiama la funzione X con questi argomenti". L'applicazione la esegue,
// rispedisce il risultato, e il modello prosegue fino alla risposta finale.
//
// Questa unit contiene la sola parte NEUTRA rispetto al fornitore: che cosa
// e' uno strumento, come si dichiarano i parametri, come si esegue. Non sa
// nulla di Gemini, OpenAI o HTTP: la traduzione nel dialetto del fornitore
// sta in zAI.Protocol.*, e il giro di chiamate lo fa TzAIEngine.
//
// Chi scrive uno strumento fa tre cose:
//
//   Strumento := Tools.Add('cerca_progetti',
//     'Cerca i progetti formativi dell''ente per denominazione', CercaProgetti);
//   Strumento.AddParameter('testo', ptString, 'Parte della denominazione');
//   Strumento.AddParameter('solo_in_corso', ptBoolean, 'Solo progetti attivi oggi', False);
//
// e il gestore CercaProgetti riceve gli argomenti come TJSONObject e
// restituisce un TJSONObject col risultato (vedi TzAITool.Risultato e Errore
// per i casi semplici). Il gestore gira sul thread principale: puo' toccare
// database e interfaccia senza precauzioni.
//
// Regola di riservatezza: il risultato di uno strumento VIENE INVIATO AL
// FORNITORE AI, perche' e' il modello a doverlo leggere. Uno strumento che
// restituisce dati personali li manda fuori esattamente come farebbe
// l'utente scrivendoli nella chat. Chi lo registra ne risponde.

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.Generics.Collections;

type
  // Gestore di uno strumento. Riceve gli argomenti scelti dal modello (di
  // proprieta' del chiamante: NON liberarli) e restituisce un oggetto JSON
  // che passa di proprieta' al motore. Un risultato nil equivale a un
  // oggetto vuoto. Un'eccezione viene tradotta in un risultato d'errore che
  // il modello legge e puo' spiegare all'utente.
  TzAIToolHandler = reference to function(const Args: TJSONObject): TJSONObject;

  // Tipi ammessi per i parametri. Sono quelli dello schema JSON che tutti i
  // fornitori capiscono; oggetti e liste annidati sono volutamente esclusi:
  // uno strumento con parametri complessi e' quasi sempre due strumenti.
  TzAIParameterType = (ptString, ptInteger, ptNumber, ptBoolean);

  TzAITool = class
  private
    FName: string;
    FDescription: string;
    // Schema completo: {"type":"object","properties":{...},"required":[...]}
    FParameters: TJSONObject;
    // Riferimenti dentro FParameters, per aggiungere senza rileggere
    FProperties: TJSONObject;
    FRequired: TJSONArray;
    FHandler: TzAIToolHandler;
  public
    constructor Create(const AName, ADescription: string; const AHandler: TzAIToolHandler);
    destructor Destroy; override;

    // Aggiunge un parametro e ritorna lo strumento stesso, per concatenare.
    // AEnumValues limita i valori ammessi (solo per ptString): il modello li
    // vede e sceglie fra quelli.
    function AddParameter(const AName: string; AType: TzAIParameterType;
      const ADescription: string; ARequired: Boolean = True;
      const AEnumValues: TArray<string> = nil): TzAITool;

    // Dichiarazione neutra {name, description, parameters}, quella che i
    // protocolli traducono. L'oggetto e' nuovo e di proprieta' del chiamante.
    // Senza parametri la chiave "parameters" manca del tutto, perche' Gemini
    // rifiuta uno schema "object" con "properties" vuoto; con
    // AEmptySchemaIfNone Vero si mette comunque lo schema vuoto, che
    // OpenAI e Ollama accettano e Claude pretende.
    function Declaration(const AEmptySchemaIfNone: Boolean = False): TJSONObject;

    // Esegue il gestore. Non solleva mai: un'eccezione diventa Errore(...).
    function Execute(const Args: TJSONObject): TJSONObject;

    // Risultati pronti per i casi piu' comuni
    class function Risultato(const ATesto: string): TJSONObject;
    class function Errore(const AMessaggio: string): TJSONObject;

    // Lettura tollerante degli argomenti: il modello a volte manda un numero
    // come testo o un intero come 12.0, e un argomento facoltativo puo'
    // mancare del tutto
    class function ArgString(const Args: TJSONObject; const AName: string;
      const ADefault: string = ''): string;
    class function ArgInteger(const Args: TJSONObject; const AName: string;
      ADefault: Integer = 0): Integer;
    class function ArgFloat(const Args: TJSONObject; const AName: string;
      ADefault: Double = 0): Double;
    class function ArgBoolean(const Args: TJSONObject; const AName: string;
      ADefault: Boolean = False): Boolean;

    property Name: string read FName;
    property Description: string read FDescription;
    property Parameters: TJSONObject read FParameters;
  end;

  // Insieme degli strumenti offerti al modello in una richiesta. Il motore ne
  // possiede uno (TzAIEngine.Tools); l'applicazione lo riempie all'avvio.
  TzAIToolSet = class
  private
    FItems: TObjectList<TzAITool>;
    function GetCount: Integer;
    function GetItem(Index: Integer): TzAITool;
  public
    constructor Create;
    destructor Destroy; override;

    // Solleva EArgumentException se il nome non e' valido o e' gia' usato:
    // meglio in fase di registrazione che un rifiuto del fornitore a caldo
    function Add(const AName, ADescription: string; const AHandler: TzAIToolHandler): TzAITool;
    function Find(const AName: string): TzAITool;
    procedure Remove(const AName: string);
    procedure Clear;

    // Esegue lo strumento col nome dato. Uno strumento sconosciuto (il
    // modello ogni tanto ne inventa uno) produce un Errore leggibile, non
    // un'eccezione: la conversazione deve continuare
    function Execute(const AName: string; const Args: TJSONObject): TJSONObject;

    // Dichiarazioni di tutti gli strumenti, nuova e di proprieta' del chiamante
    function Declarations(const AEmptySchemaIfNone: Boolean = False): TJSONArray;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TzAITool read GetItem; default;
  end;

// Vero se il nome rispetta le regole comuni ai fornitori: lettere, cifre,
// trattino basso e trattino, inizio con lettera o trattino basso, al massimo
// 64 caratteri.
function IsValidToolName(const AName: string): Boolean;

implementation

const
  MaxToolNameLength = 64;
  ChiaveRisultato = 'risultato';
  ChiaveErrore = 'errore';

resourcestring
  MsgNomeStrumentoNonValido = 'Nome di strumento non valido: "%s". Ammessi lettere non accentate, cifre, "_" e "-", inizio con lettera o "_", massimo 64 caratteri.';
  MsgStrumentoDuplicato = 'Strumento "%s" gia'' registrato.';
  MsgStrumentoSconosciuto = 'Strumento "%s" non disponibile.';
  MsgGestoreMancante = 'Strumento "%s" senza gestore.';

function IsValidToolName(const AName: string): Boolean;
var
  Index: Integer;
  Carattere: Char;
begin
  Result := False;

  if (AName = '') or (Length(AName) > MaxToolNameLength) then
    Exit;

  // Solo ASCII: OpenAI, Gemini e Claude ammettono [a-zA-Z0-9_-] e
  // rifiutano la richiesta intera se un nome contiene una lettera accentata
  if not CharInSet(AName[1], ['a'..'z', 'A'..'Z', '_']) then
    Exit;

  for Index := 2 to Length(AName) do
  begin
    Carattere := AName[Index];

    if not CharInSet(Carattere, ['a'..'z', 'A'..'Z', '0'..'9', '_', '-']) then
      Exit;
  end;

  Result := True;
end;

function TypeName(AType: TzAIParameterType): string;
begin
  case AType of
    ptString: Result := 'string';
    ptInteger: Result := 'integer';
    ptNumber: Result := 'number';
    ptBoolean: Result := 'boolean';
  else
    Result := 'string';
  end;
end;

{ TzAITool }

constructor TzAITool.Create(const AName, ADescription: string; const AHandler: TzAIToolHandler);
begin
  inherited Create;
  FName := AName;
  FDescription := ADescription;
  FHandler := AHandler;

  FProperties := TJSONObject.Create;
  FRequired := TJSONArray.Create;
  FParameters := TJSONObject.Create;
  FParameters.AddPair('type', 'object');
  FParameters.AddPair('properties', FProperties);
  FParameters.AddPair('required', FRequired);
end;

destructor TzAITool.Destroy;
begin
  // FProperties e FRequired sono figli di FParameters: li libera lui
  FParameters.Free;
  inherited Destroy;
end;

function TzAITool.AddParameter(const AName: string; AType: TzAIParameterType;
  const ADescription: string; ARequired: Boolean; const AEnumValues: TArray<string>): TzAITool;
var
  Schema: TJSONObject;
  Valori: TJSONArray;
  Valore: string;
  Indice: Integer;
begin
  Result := Self;

  Schema := TJSONObject.Create;
  Schema.AddPair('type', TypeName(AType));

  if ADescription <> '' then
    Schema.AddPair('description', ADescription);

  if Length(AEnumValues) > 0 then
  begin
    Valori := TJSONArray.Create;

    for Valore in AEnumValues do
      Valori.Add(Valore);

    Schema.AddPair('enum', Valori);
  end;

  // Un parametro ridefinito sostituisce il precedente
  FProperties.RemovePair(AName).Free;
  FProperties.AddPair(AName, Schema);

  // Anche in "required": un nome ripetuto rende lo schema JSON non valido,
  // e un parametro ridefinito come facoltativo non deve restare obbligatorio
  for Indice := FRequired.Count - 1 downto 0 do
    if FRequired.Items[Indice].Value = AName then
      FRequired.Remove(Indice).Free;

  if ARequired then
    FRequired.Add(AName);
end;

function TzAITool.Declaration(const AEmptySchemaIfNone: Boolean): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('name', FName);
  Result.AddPair('description', FDescription);

  if (FProperties.Count > 0) or AEmptySchemaIfNone then
    Result.AddPair('parameters', FParameters.Clone as TJSONObject);
end;

function TzAITool.Execute(const Args: TJSONObject): TJSONObject;
begin
  if not Assigned(FHandler) then
    Exit(Errore(Format(MsgGestoreMancante, [FName])));

  try
    Result := FHandler(Args);

    if Result = nil then
      Result := TJSONObject.Create;
  except
    on E: Exception do
      // Il modello riceve il testo dell'errore e di solito lo spiega
      // all'utente o riprova con argomenti diversi: molto meglio che far
      // saltare l'intera conversazione
      Result := Errore(E.Message);
  end;
end;

class function TzAITool.Risultato(const ATesto: string): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair(ChiaveRisultato, ATesto);
end;

class function TzAITool.Errore(const AMessaggio: string): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair(ChiaveErrore, AMessaggio);
end;

class function TzAITool.ArgString(const Args: TJSONObject; const AName: string;
  const ADefault: string): string;
var
  Valore: TJSONValue;
begin
  Result := ADefault;

  if Args = nil then
    Exit;

  Valore := Args.Values[AName];

  if (Valore = nil) or (Valore is TJSONNull) then
    Exit;

  Result := Valore.Value;
end;

class function TzAITool.ArgFloat(const Args: TJSONObject; const AName: string;
  ADefault: Double): Double;
var
  Valore: TJSONValue;
begin
  Result := ADefault;

  if Args = nil then
    Exit;

  Valore := Args.Values[AName];

  if Valore is TJSONNumber then
    Result := TJSONNumber(Valore).AsDouble
  else
    if Valore is TJSONString then
      // Il JSON usa sempre il punto decimale, qualunque sia la lingua di Windows
      Result := StrToFloatDef(Valore.Value, ADefault, TFormatSettings.Invariant);
end;

class function TzAITool.ArgInteger(const Args: TJSONObject; const AName: string;
  ADefault: Integer): Integer;
var
  Valore: TJSONValue;
begin
  Result := ADefault;

  if Args = nil then
    Exit;

  Valore := Args.Values[AName];

  // Un intero puo' arrivare come 12, come 12.0 o come "12": si passa dal
  // valore in virgola mobile, che li accetta tutti
  if (Valore is TJSONNumber) or (Valore is TJSONString) then
    Result := Round(ArgFloat(Args, AName, ADefault));
end;

class function TzAITool.ArgBoolean(const Args: TJSONObject; const AName: string;
  ADefault: Boolean): Boolean;
var
  Valore: TJSONValue;
begin
  Result := ADefault;

  if Args = nil then
    Exit;

  Valore := Args.Values[AName];

  if Valore is TJSONBool then
    Result := TJSONBool(Valore).AsBoolean
  else
    if Valore is TJSONString then
      Result := SameText(Valore.Value, 'true') or (Valore.Value = '1') or SameText(Valore.Value, 'si')
    else
      if Valore is TJSONNumber then
        Result := TJSONNumber(Valore).AsDouble <> 0;
end;

{ TzAIToolSet }

constructor TzAIToolSet.Create;
begin
  inherited Create;
  FItems := TObjectList<TzAITool>.Create(True);
end;

destructor TzAIToolSet.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

function TzAIToolSet.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TzAIToolSet.GetItem(Index: Integer): TzAITool;
begin
  Result := FItems[Index];
end;

function TzAIToolSet.Add(const AName, ADescription: string; const AHandler: TzAIToolHandler): TzAITool;
begin
  if not IsValidToolName(AName) then
    raise EArgumentException.CreateFmt(MsgNomeStrumentoNonValido, [AName]);

  if Find(AName) <> nil then
    raise EArgumentException.CreateFmt(MsgStrumentoDuplicato, [AName]);

  Result := TzAITool.Create(AName, ADescription, AHandler);
  FItems.Add(Result);
end;

function TzAIToolSet.Find(const AName: string): TzAITool;
var
  Strumento: TzAITool;
begin
  Result := nil;

  for Strumento in FItems do
    if SameText(Strumento.Name, AName) then
      Exit(Strumento);
end;

procedure TzAIToolSet.Remove(const AName: string);
var
  Strumento: TzAITool;
begin
  Strumento := Find(AName);

  if Assigned(Strumento) then
    FItems.Remove(Strumento);
end;

procedure TzAIToolSet.Clear;
begin
  FItems.Clear;
end;

function TzAIToolSet.Execute(const AName: string; const Args: TJSONObject): TJSONObject;
var
  Strumento: TzAITool;
begin
  Strumento := Find(AName);

  if Strumento = nil then
    Exit(TzAITool.Errore(Format(MsgStrumentoSconosciuto, [AName])));

  Result := Strumento.Execute(Args);
end;

function TzAIToolSet.Declarations(const AEmptySchemaIfNone: Boolean): TJSONArray;
var
  Strumento: TzAITool;
begin
  Result := TJSONArray.Create;

  for Strumento in FItems do
    Result.Add(Strumento.Declaration(AEmptySchemaIfNone));
end;

end.
