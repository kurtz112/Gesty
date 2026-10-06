// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-14
// ---------------------------------------------------------------------------

unit zAI.Engine;

// Motore delle richieste AI: l'unico punto che "parla" con SmartCoreAI.
//
// Tiene il driver (fornitore), la connessione e la richiesta di conversazione,
// e li allinea da solo alla configurazione (TzAIConfiguration). Chi lo usa
// vede solo: assegna gli eventi, chiama Ask, riceve OnResponse o OnError.
//
// Nasce estraendo da dmAI (pannello di chat) la parte che non ha nulla a che
// vedere con la chat: creazione del driver, parametri, timeout, annullamento,
// elenco dei modelli, prova di connessione. Serve percio' entrambi i
// consumatori senza duplicare nulla:
//
//   - la generazione della guida (HelpGen.AI): una richiesta sola, lunga, con
//     risposta attesa in JSON;
//   - il pannello di chat (dmAI): molte richieste brevi, con storico.
//
// Il motore NON costruisce il prompt: lo riceve gia' fatto.
//
// Due vie per la stessa domanda:
//
//   VIA CHAT (predefinita, senza strumenti)
//     La chiamata Chat del driver SmartCoreAI, con un testo unico. I driver
//     non hanno il ruolo "system", quindi le istruzioni della configurazione
//     vengono anteposte al testo. E' la via di sempre, che HelpGen e la chat
//     usano da settembre.
//
//   VIA PROTOCOLLO (con strumenti registrati, o con UseNativeProtocol)
//     Il motore costruisce da se' il JSON della richiesta con un TzAIProtocol
//     (zAI.Protocol.*) e lo spedisce con ExecuteJSONRequest del driver, che
//     e' l'invio grezzo di SmartCoreAI: stesso indirizzo, stessa chiave,
//     stessi tempi di attesa, stessa cancellazione. In cambio si ottengono le
//     istruzioni nel ruolo di sistema vero e il FUNCTION CALLING: il modello
//     puo' chiedere di eseguire uno degli strumenti in Tools, il motore lo
//     esegue sul thread principale, rispedisce il risultato e ripete finche'
//     il modello non risponde col testo. OnToolCall e OnToolResult avvisano
//     chi ospita a ogni passaggio; MaxToolRounds ferma i giri senza fine.
//
// Fornitori serviti: Gemini, OpenAI (e i servizi compatibili, cambiando
// BaseURL), Claude, Ollama. Per Ollama il driver e' TzAIOllamaDriver
// (zAI.Driver.Ollama): quello di SmartCoreAI non implementa l'invio grezzo.
//
// Per aggiungere un fornitore: mettere la sua unit SmartCoreAI.Driver.* in
// uses e aggiungere la riga corrispondente in DriverClassOf e in
// HookDriverEvents. Per il function calling serve anche il protocollo
// (una unit zAI.Protocol.<Fornitore> che si registra da sola).

interface

uses
  System.SysUtils, System.Classes, System.JSON, SmartCoreAI.Types,
  SmartCoreAI.Comp.Connection, SmartCoreAI.Comp.Chat, zAI.Configuration,
  zAI.Tools, zAI.Protocol, System.Diagnostics;

type
  TzAITextEvent = procedure(Sender: TObject; const Text: string) of object;

  { Registro delle chiamate. Il motore NON scrive da nessuna parte: e' l'unico
    punto che vede partire la richiesta e arrivare la risposta, quindi misura
    il tempo e consegna i dati, ma dove finiscano lo decide chi lo ospita.
    E' cosi' che questa unit resta di libreria: il database non lo conosce.

    Il gestore della richiesta restituisce un identificativo qualunque (per
    Gesty la chiave della riga di AI_LOG_REQUEST) che il motore ripassa tale e
    quale al gestore della risposta. Zero = non registrato. }
  TzAIRegistraRichiestaEvent = procedure(Sender: TObject;
    const AUtilizzo, AModello, APrompt: string;
    out AIdRegistrazione: Int64) of object;

  TzAIRegistraRispostaEvent = procedure(Sender: TObject;
    const AIdRegistrazione: Int64;
    const AEsito, ARisposta, AErrore: string;
    ADurataMs: Integer) of object;

  { Strumenti. Il modello ha chiesto di eseguire AToolName con AArgs; poi il
    motore consegna AResult (quello che verra' rispedito al modello) e quanto
    ci ha messo. Gli oggetti JSON restano del motore: non liberarli. }
  TzAIToolCallEvent = procedure(Sender: TObject; const AToolName: string;
    AArgs: TJSONObject) of object;

  TzAIToolResultEvent = procedure(Sender: TObject; const AToolName: string;
    AResult: TJSONObject; ADurataMs: Integer) of object;

const
  { Esiti, come il dominio AI_ESITO del database. Sono costanti e non un enum
    perche' viaggiano verso chi registra, che li scrive cosi' come sono. }
  EsitoOk = 'OK';
  EsitoErrore = 'ERR';
  EsitoAnnullata = 'ANN';

  { Quanti giri "funzione -> risultato -> nuova richiesta" si concedono al
    modello per una sola domanda prima di arrendersi. Otto bastano per
    qualunque uso ragionevole e fermano un modello che gira in tondo. }
  DefaultMaxToolRounds = 8;

type
  TzAIProtocolSink = class;

  TzAIEngine = class(TComponent)
  private
    FConfiguration: TzAIConfiguration;
    FOwnsConfiguration: Boolean;
    FConnection: TAIConnection;
    FChatRequest: TAIChatRequest;
    FDriver: TAIDriver;
    FRequestId: TGUID;
    FRequestInProgress: Boolean;
    FClosing: Boolean;
    FLastError: string;
    FOnProcessingStart: TNotifyEvent;
    FOnResponse: TzAITextEvent;
    FOnError: TzAITextEvent;
    FOnPartialResponse: TzAITextEvent;
    FUtilizzo: string;
    FIdRegistrazione: Int64;
    FCronometro: TStopwatch;
    FOnRegistraRichiesta: TzAIRegistraRichiestaEvent;
    FOnRegistraRisposta: TzAIRegistraRispostaEvent;
    // --- strumenti e protocollo ---
    FTools: TzAIToolSet;
    FProtocol: TzAIProtocol;
    FSink: TzAIProtocolSink;
    FSinkIntf: IAIJSONCallback;
    FToolRound: Integer;
    FMaxToolRounds: Integer;
    FUseNativeProtocol: Boolean;
    FWatchdogTicket: Integer;
    FOnToolCall: TzAIToolCallEvent;
    FOnToolResult: TzAIToolResultEvent;
    procedure ChatResponse(Sender: TObject; const Text: string);
    procedure ChatError(Sender: TObject; const ErrorMessage: string);
    procedure ChatPartialResponse(Sender: TObject; const PartialText: string);
    procedure DriverError(Sender: TObject; const ErrorMessage: string);
    procedure ConfigurationChanged(Sender: TObject);
    procedure ApplyParameters;
    procedure ApplyHttpTimeout;
    procedure HookDriverEvents;
    procedure CloseRequest;
    procedure ReportError(const ErrorMessage: string);
    function GetResponseInProgress: Boolean;
    function BuildPrompt(const APrompt: string): string;
    procedure ApriRegistrazione(const APrompt: string);
    procedure ChiudiRegistrazione(const AEsito, ARisposta, AErrore: string);
    // --- via protocollo ---
    function UsaProtocollo: Boolean;
    function EnsureProtocol: Boolean;
    function SendProtocolRequest: Boolean;
    procedure ProtocolResponse(const AJson: string);
    procedure ProtocolError(const AMessage: string);
    function ResponseTimeoutMs: Integer;
    procedure ArmWatchdog;
    procedure DisarmWatchdog;
  public
    // AConfiguration nil = configurazione condivisa (AIConfiguration).
    // AOwnsConfiguration vale solo per un esemplare dedicato: il motore lo
    // distrugge con se stesso.
    constructor Create(AOwner: TComponent; AConfiguration: TzAIConfiguration = nil;
      const AOwnsConfiguration: Boolean = False); reintroduce;
    destructor Destroy; override;

    // Allinea il driver alla configurazione: lo crea se manca, ne cambia la
    // classe se e' cambiato il fornitore, altrimenti aggiorna i soli
    // parametri. Parte da sola a ogni modifica della configurazione.
    procedure ApplyConfiguration;

    // Avvia una richiesta. Asincrona: scatta prima OnProcessingStart, poi
    // OnResponse oppure OnError. Ritorna Falso se la richiesta non e' nemmeno
    // partita (motore non configurato): in quel caso OnError e' gia' scattato.
    // AModel vuoto = modello della configurazione.
    function Ask(const APrompt: string; const AModel: string = ''): Boolean;
    procedure Cancel;

    // Elenco reale dei modelli del fornitore. BLOCCANTE (HTTP in linea): va
    // innescata da un comando esplicito, mai in fase di creazione della UI.
    function RefreshModels(Target: TStrings = nil): Boolean;
    // Verifica chiave e raggiungibilita' del fornitore. Bloccante.
    function TestConnection(out Response: string): Boolean;

    function DriverName: string;
    function IsReady: Boolean;
    // Vero se per il fornitore configurato esiste un protocollo, cioe' se
    // gli strumenti registrati verranno davvero offerti al modello
    function SupportsTools: Boolean;

    property Configuration: TzAIConfiguration read FConfiguration;
    { A quale impiego serve questo motore: 'CHAT', 'GUIDA', ... Finisce nel
      registro e serve a chi carica la configurazione dal database. }
    property Utilizzo: string read FUtilizzo write FUtilizzo;
    // Ultimo errore riportato dal motore. Utile per gli errori che scattano in
    // fase di creazione, quando i gestori non sono ancora assegnati.
    property LastError: string read FLastError;
    property ResponseInProgress: Boolean read GetResponseInProgress;
    // Il driver vivo, per i pochi casi che hanno bisogno dell'oggetto vero
    // (per esempio registrarlo come motore dei componenti DevExpress).
    property Driver: TAIDriver read FDriver;

    { Strumenti offerti al modello. Vuoto = nessun function calling, via chat
      di sempre. Si riempie una volta, all'avvio dell'applicazione. }
    property Tools: TzAIToolSet read FTools;
    property MaxToolRounds: Integer read FMaxToolRounds write FMaxToolRounds;
    { Vero = usa la via protocollo anche senza strumenti, per avere le
      istruzioni nel ruolo di sistema del fornitore invece che anteposte al
      testo. Predefinito Falso: la via chat resta quella collaudata. }
    property UseNativeProtocol: Boolean read FUseNativeProtocol write FUseNativeProtocol;

    property OnProcessingStart: TNotifyEvent read FOnProcessingStart write FOnProcessingStart;
    property OnResponse: TzAITextEvent read FOnResponse write FOnResponse;
    // Errore del motore (chiave mancante, quota, rete). Se non e' assegnato il
    // testo dell'errore viene consegnato a OnResponse, cosi' chi aspetta si
    // sblocca comunque.
    property OnError: TzAITextEvent read FOnError write FOnError;
    // Pezzo di risposta in arrivo, per i driver che trasmettono a flusso.
    property OnPartialResponse: TzAITextEvent read FOnPartialResponse write FOnPartialResponse;

    { Registro. Se non sono assegnati non si registra nulla e il motore si
      comporta esattamente come prima. }
    property OnRegistraRichiesta: TzAIRegistraRichiestaEvent
      read FOnRegistraRichiesta write FOnRegistraRichiesta;
    property OnRegistraRisposta: TzAIRegistraRispostaEvent
      read FOnRegistraRisposta write FOnRegistraRisposta;

    { Strumenti: il modello ne ha chiesto uno / il motore l'ha eseguito. Chi
      ospita puo' mostrare "sto consultando..." o annotare nel registro. }
    property OnToolCall: TzAIToolCallEvent read FOnToolCall write FOnToolCall;
    property OnToolResult: TzAIToolResultEvent read FOnToolResult write FOnToolResult;
  end;

  { Ricevitore della risposta grezza di ExecuteJSONRequest. E' un oggetto a
    parte, con interfaccia, perche' e' quello che il driver SmartCoreAI vuole:
    il motore e' un TComponent e non conta i riferimenti. Il driver puo'
    richiamarlo anche dopo che il motore e' morto: Detach lo rende inerte. }
  TzAIProtocolSink = class(TInterfacedObject, IAIJSONCallback)
  private
    FEngine: TzAIEngine;
    // Esegue sul thread principale. Il driver OpenAI richiama il ricevitore
    // dal thread di lavoro senza sincronizzarlo (Gemini e Claude lo fanno):
    // qui si uniforma, cosi' i gestori degli strumenti toccano database e
    // interfaccia sempre dal thread giusto
    procedure Deliver(const AProc: TProc);
  public
    constructor Create(AEngine: TzAIEngine);
    procedure Detach;
    // IAIJSONCallback
    procedure DoSuccess(const Response: string);
    procedure DoError(const ErrorMessage: string);
    function PopulateDataset(const JSONObject: TJSONObject): Boolean;
  end;

implementation

uses
  System.Net.HttpClient, System.Generics.Collections, SmartCoreAI.HttpClientConfig,
  SmartCoreAI.Driver.Registry, SmartCoreAI.Driver.Gemini, SmartCoreAI.Driver.OpenAI,
  SmartCoreAI.Driver.Claude, SmartCoreAI.Driver.Ollama, zAI.Driver.Ollama,
  // I protocolli si registrano da soli nella loro initialization: basta
  // che la unit sia collegata
  zAI.Protocol.Gemini, zAI.Protocol.OpenAI, zAI.Protocol.Claude, zAI.Protocol.Ollama;

const
  // Nomi dei parametri dei driver SmartCoreAI (identici per tutti)
  ParamAPIKey = 'APIKey';
  ParamModel = 'Model';
  ParamBaseURL = 'BaseURL';
  ParamTemperature = 'Temperature';
  ParamMaxToken = 'MaxToken';
  ParamTimeout = 'Timeout';
  // Solo Claude: versione dell'API, intestazione obbligatoria. Il driver
  // SmartCoreAI non ha un predefinito e manda l'intestazione vuota, che il
  // servizio rifiuta: qui si mette la versione stabile se manca
  ParamAnthropicVersion = 'AnthropicVersion';
  DefaultAnthropicVersion = '2023-06-01';
  // Prefisso con cui Gemini elenca i modelli ('models/gemini-2.5-flash')
  GeminiModelPrefix = 'models/';
  // Attesa della risposta quando la configurazione non dice altro. I valori
  // predefiniti di SmartCoreAI (120 secondi) bastano per una chat, non per la
  // generazione di un documento intero
  DefaultResponseTimeout = 600000; // 10 minuti
  DefaultConnectionTimeout = 60000;
  // Quanto oltre il tempo di attesa HTTP il cane da guardia aspetta prima di
  // dichiarare la richiesta persa. Serve per i casi in cui il driver non
  // richiama nessuno: ExecuteJSONRequest, con una risposta senza candidati
  // (richiesta bloccata dai filtri), esce in silenzio
  WatchdogMargin = 5000;

resourcestring
  MsgDriverNotAvailable = 'Fornitore AI "%s" non disponibile: la unit del driver non e'' inclusa nel progetto.';
  MsgNotConfigured = 'Servizio AI non configurato: manca la chiave di accesso del fornitore %s.';
  MsgNoDriver = 'Nessun driver AI attivo: verificare la configurazione del servizio AI.';
  MsgProtocolNotAvailable = 'Il fornitore AI "%s" non supporta gli strumenti in questa versione: nessun protocollo registrato.';
  MsgTroppiGiri = 'Il modello ha chiesto piu'' di %d chiamate di funzione consecutive senza rispondere: richiesta interrotta.';
  MsgNessunaRisposta = 'Nessuna risposta dal fornitore AI entro il tempo di attesa.';
  MsgModelloMancante = 'Nessun modello indicato per il fornitore AI "%s": verificare la configurazione.';

var
  // Motori vivi. Il cane da guardia e' una procedura accodata al thread
  // principale con ritardo, che non si puo' revocare: prima di toccare il
  // motore verifica che esista ancora. Si legge e si scrive solo dal thread
  // principale, quindi senza lucchetti
  EnginesVivi: TList<TzAIEngine> = nil;

function EngineVivo(AEngine: TzAIEngine): Boolean;
begin
  Result := Assigned(EnginesVivi) and (EnginesVivi.IndexOf(AEngine) >= 0);
end;

// Classe del driver corrispondente al nome configurato.
function DriverClassOf(const ADriverName: string): TAIDriverClass;
begin
  Result := nil;

  if SameText(ADriverName, DriverGemini) then
    Result := TAIGeminiDriver
  else if SameText(ADriverName, DriverOpenAI) then
    Result := TAIOpenAIDriver
  else if SameText(ADriverName, DriverClaude) then
    Result := TAIClaudeDriver
  else if SameText(ADriverName, DriverOllama) then
    // La sottoclasse con l'invio grezzo: TAIOllamaDriver di SmartCoreAI
    // non lo implementa
    Result := TzAIOllamaDriver;
end;

{ TzAIProtocolSink }

constructor TzAIProtocolSink.Create(AEngine: TzAIEngine);
begin
  inherited Create;
  FEngine := AEngine;
end;

procedure TzAIProtocolSink.Detach;
begin
  FEngine := nil;
end;

procedure TzAIProtocolSink.Deliver(const AProc: TProc);
var
  Keep: IAIJSONCallback;
begin
  if TThread.Current.ThreadID = MainThreadID then
  begin
    AProc();
    Exit;
  end;

  // Il riferimento all'interfaccia tiene vivo il ricevitore finche' la
  // procedura accodata non e' stata eseguita: il motore potrebbe aver
  // rilasciato il proprio nel frattempo
  Keep := Self;
  TThread.Queue(nil,
    procedure
    begin
      AProc();
      Keep := nil;
    end);
end;

procedure TzAIProtocolSink.DoSuccess(const Response: string);
begin
  Deliver(
    procedure
    begin
      if Assigned(FEngine) then
        FEngine.ProtocolResponse(Response);
    end);
end;

procedure TzAIProtocolSink.DoError(const ErrorMessage: string);
begin
  Deliver(
    procedure
    begin
      if Assigned(FEngine) then
        FEngine.ProtocolError(ErrorMessage);
    end);
end;

function TzAIProtocolSink.PopulateDataset(const JSONObject: TJSONObject): Boolean;
begin
  // Il driver chiama DoSuccess solo se questa risponde Vero: qui non c'e'
  // nessun dataset da riempire, la risposta si legge intera in DoSuccess
  Result := True;
end;

{ TzAIEngine }

constructor TzAIEngine.Create(AOwner: TComponent; AConfiguration: TzAIConfiguration;
  const AOwnsConfiguration: Boolean);
begin
  inherited Create(AOwner);

  if EnginesVivi = nil then
    EnginesVivi := TList<TzAIEngine>.Create;

  EnginesVivi.Add(Self);

  if Assigned(AConfiguration) then
  begin
    FConfiguration := AConfiguration;
    FOwnsConfiguration := AOwnsConfiguration;
  end
  else
  begin
    FConfiguration := AIConfiguration;
    FOwnsConfiguration := False;
  end;

  FTools := TzAIToolSet.Create;
  FMaxToolRounds := DefaultMaxToolRounds;
  FSink := TzAIProtocolSink.Create(Self);
  // L'interfaccia tiene in vita il ricevitore: lo libera l'ultimo riferimento,
  // che puo' essere quello trattenuto dal driver in un thread di lavoro
  FSinkIntf := FSink;

  FConnection := TAIConnection.Create(Self);
  FChatRequest := TAIChatRequest.Create(Self);
  FChatRequest.Connection := FConnection;
  FChatRequest.OnResponse := ChatResponse;
  FChatRequest.OnError := ChatError;
  FChatRequest.OnPartialResponse := ChatPartialResponse;

  FConfiguration.OnChange := ConfigurationChanged;
  ApplyConfiguration;
end;

destructor TzAIEngine.Destroy;
begin
  FClosing := True;

  // Annulla le richieste in volo: il driver interrompe la ricezione HTTP e non
  // richiama piu' la richiesta, che sta per essere distrutta
  Cancel;

  if Assigned(FDriver) then
    FDriver.CancelAll;

  // Il ricevitore puo' sopravvivere al motore (lo trattiene il driver): da
  // qui in poi non deve piu' toccarlo
  if Assigned(FSink) then
    FSink.Detach;

  FSinkIntf := nil;
  FSink := nil;

  if Assigned(FConfiguration) and (TMethod(FConfiguration.OnChange).Data = Self) then
    FConfiguration.OnChange := nil;

  if FOwnsConfiguration then
    FreeAndNil(FConfiguration);

  FreeAndNil(FProtocol);
  FreeAndNil(FTools);

  if Assigned(EnginesVivi) then
    EnginesVivi.Remove(Self);

  inherited Destroy;
end;

// --- configurazione -------------------------------------------------------

procedure TzAIEngine.ConfigurationChanged(Sender: TObject);
begin
  ApplyConfiguration;
end;

procedure TzAIEngine.ApplyConfiguration;
var
  RequiredClass: TAIDriverClass;
begin
  if FClosing or (FConfiguration = nil) then
    Exit;

  RequiredClass := DriverClassOf(FConfiguration.DriverName);

  if RequiredClass = nil then
  begin
    FConnection.Driver := nil;
    FreeAndNil(FDriver);
    ReportError(Format(MsgDriverNotAvailable, [FConfiguration.DriverName]));
    Exit;
  end;

  // Il driver si ricrea solo se cambia il fornitore: cambiare modello o chiave
  // e' un semplice aggiornamento dei parametri, e non invalida i riferimenti
  // gia' distribuiti (per esempio ai componenti DevExpress)
  if (FDriver = nil) or (FDriver.ClassType <> RequiredClass) then
  begin
    Cancel;
    FConnection.Driver := nil;
    FreeAndNil(FDriver);
    FDriver := RequiredClass.Create(Self);
    // Gli eventi arrivano sul thread principale: la UI si aggiorna diretta
    FDriver.SynchronizeEvents := True;
    HookDriverEvents;
    // Il tempo di attesa va assegnato PRIMA del driver: e' la connessione a
    // travasarlo nel driver quando le si assegna, e non lo rilegge piu'
    ApplyHttpTimeout;
    FConnection.Driver := FDriver;
    // Il protocollo segue il fornitore: si ricrea alla prossima richiesta
    FreeAndNil(FProtocol);
  end
  else
    ApplyHttpTimeout;

  ApplyParameters;
end;

procedure TzAIEngine.HookDriverEvents;
begin
  // Gli errori che il driver non consegna al ricevitore della richiesta
  // finiscono nel suo evento OnError: succede per i controlli preliminari
  // (modello o chiave mancanti) e per gli errori HTTP di ExecuteJSONRequest,
  // e per qualunque eccezione dentro il thread di lavoro (DoRequestError).
  // Senza questo aggancio quelle segnalazioni andavano perse e la richiesta
  // restava "in corso" per sempre. L'evento e' dichiarato dalla singola
  // classe di driver, non dalla base: una riga per fornitore
  if FDriver is TAIGeminiDriver then
    TAIGeminiDriver(FDriver).OnError := DriverError
  else if FDriver is TAIOpenAIDriver then
    TAIOpenAIDriver(FDriver).OnError := DriverError
  else if FDriver is TAIClaudeDriver then
    TAIClaudeDriver(FDriver).OnError := DriverError
  else if FDriver is TAIOllamaDriver then
    // Vale anche per la sottoclasse TzAIOllamaDriver
    TAIOllamaDriver(FDriver).OnError := DriverError;
end;

procedure TzAIEngine.ApplyParameters;
begin
  if FDriver = nil then
    Exit;

  FDriver.Params.Values[ParamAPIKey] := FConfiguration.APIKey;

  if FConfiguration.Model <> '' then
    FDriver.Params.Values[ParamModel] := FConfiguration.Model;

  if FConfiguration.BaseURL <> '' then
    FDriver.Params.Values[ParamBaseURL] := FConfiguration.BaseURL;

  // I valori a zero non si trasmettono: vale il predefinito del fornitore.
  // Temperature va scritta col separatore decimale locale, perche' i driver la
  // rileggono con StrToFloatDef
  if FConfiguration.Temperature > 0 then
    FDriver.Params.Values[ParamTemperature] := FloatToStr(FConfiguration.Temperature);

  if FConfiguration.MaxToken > 0 then
    FDriver.Params.Values[ParamMaxToken] := IntToStr(FConfiguration.MaxToken);

  if FConfiguration.Timeout > 0 then
    FDriver.Params.Values[ParamTimeout] := IntToStr(FConfiguration.Timeout);

  // Claude: senza la versione dell'API il servizio rifiuta ogni chiamata,
  // anche quelle della via chat
  if (FDriver is TAIClaudeDriver) and (Trim(FDriver.Params.Values[ParamAnthropicVersion]) = '') then
    FDriver.Params.Values[ParamAnthropicVersion] := DefaultAnthropicVersion;
end;

function TzAIEngine.ResponseTimeoutMs: Integer;
begin
  if FConfiguration.Timeout > 0 then
    Result := FConfiguration.Timeout
  else
    Result := DefaultResponseTimeout;
end;

procedure TzAIEngine.ApplyHttpTimeout;
var
  ResponseTimeout: Integer;
begin
  // Il parametro Timeout del driver Gemini e' dichiarato ma non usato: il
  // tempo di attesa vero e' quello del client HTTP, che si regola solo con
  // questo adattatore. Senza, una generazione lunga muore a 120 secondi
  ResponseTimeout := ResponseTimeoutMs;

  FConnection.HttpClientCustomizer :=
    procedure(const Client: THTTPClient)
    begin
      Client.ConnectionTimeout := DefaultConnectionTimeout;
      Client.ResponseTimeout := ResponseTimeout;
    end;
end;

function TzAIEngine.DriverName: string;
begin
  if Assigned(FDriver) then
    Result := FDriver.DriverName
  else
    Result := '';
end;

function TzAIEngine.IsReady: Boolean;
begin
  Result := Assigned(FDriver) and FConfiguration.IsConfigured;
end;

function TzAIEngine.SupportsTools: Boolean;
begin
  Result := ProtocolClassOf(FConfiguration.DriverName) <> nil;
end;

// --- modelli e diagnostica ------------------------------------------------

function TzAIEngine.RefreshModels(Target: TStrings): Boolean;
var
  Models: TArray<string>;
  Model: string;
  Names: TStringList;
begin
  Result := False;

  if FDriver = nil then
  begin
    ReportError(MsgNoDriver);
    Exit;
  end;

  try
    Models := FDriver.LoadModels;
  except
    on E: Exception do
    begin
      ReportError(E.Message);
      Exit;
    end;
  end;

  Names := TStringList.Create;
  try
    for Model in Models do
      // Gemini restituisce i nomi qualificati ('models/gemini-2.5-flash'):
      // nella tendina e nei parametri serve il solo identificativo
      if Model.StartsWith(GeminiModelPrefix, True) then
        Names.Add(Model.Substring(Length(GeminiModelPrefix)))
      else
        Names.Add(Model);

    FConfiguration.Models := Names;

    if Assigned(Target) then
      Target.Assign(Names);
  finally
    Names.Free;
  end;

  Result := True;
end;

function TzAIEngine.TestConnection(out Response: string): Boolean;
begin
  if FDriver = nil then
  begin
    Response := MsgNoDriver;
    Exit(False);
  end;

  Result := FDriver.TestConnection(Response);
end;

// --- registro -------------------------------------------------------------

{ Apre la riga di registro PRIMA di spedire: se la spedizione fallisce, resta
  comunque traccia del tentativo. E' la stessa scelta del ponte della firma. }
procedure TzAIEngine.ApriRegistrazione(const APrompt: string);
begin
  FIdRegistrazione := 0;
  FCronometro := TStopwatch.StartNew;

  if not Assigned(FOnRegistraRichiesta) then
    Exit;

  try
    FOnRegistraRichiesta(Self, FUtilizzo, FDriver.Params.Values[ParamModel],
      APrompt, FIdRegistrazione);
  except
    on E: Exception do
    begin
      // Un registro che non scrive non deve impedire la chiamata: si annota
      // l'inciampo e si prosegue
      FLastError := E.Message;
      FIdRegistrazione := 0;
    end;
  end;
end;

procedure TzAIEngine.ChiudiRegistrazione(const AEsito, ARisposta, AErrore: string);
begin
  if (FIdRegistrazione = 0) or (not Assigned(FOnRegistraRisposta)) then
    Exit;

  try
    FOnRegistraRisposta(Self, FIdRegistrazione, AEsito, ARisposta, AErrore,
      Integer(FCronometro.ElapsedMilliseconds));
  except
    on E: Exception do
      FLastError := E.Message;
  end;

  FIdRegistrazione := 0;
end;

// --- richiesta ------------------------------------------------------------

function TzAIEngine.GetResponseInProgress: Boolean;
begin
  Result := FRequestInProgress;
end;

function TzAIEngine.BuildPrompt(const APrompt: string): string;
begin
  // Sulla via chat i driver SmartCoreAI non hanno il ruolo "system": le
  // istruzioni permanenti si antepongono al testo della richiesta
  if Trim(FConfiguration.SystemInstruction) = '' then
    Result := APrompt
  else
    Result := FConfiguration.SystemInstruction + sLineBreak + sLineBreak + APrompt;
end;

function TzAIEngine.UsaProtocollo: Boolean;
begin
  Result := FUseNativeProtocol or (FTools.Count > 0);
end;

function TzAIEngine.Ask(const APrompt: string; const AModel: string): Boolean;
var
  Prompt: string;
begin
  Result := False;

  if FRequestInProgress then
    Cancel;

  if FDriver = nil then
  begin
    ReportError(MsgNoDriver);
    Exit;
  end;

  if not FConfiguration.IsConfigured then
  begin
    ReportError(Format(MsgNotConfigured, [FConfiguration.DriverName]));
    Exit;
  end;

  // Il modello scelto dal chiamante vale per questa richiesta e per le
  // successive, senza toccare la configurazione salvata
  if AModel <> '' then
    FDriver.Params.Values[ParamModel] := AModel;

  FRequestId := TGUID.Empty;
  FRequestInProgress := True;
  FToolRound := 0;

  if Assigned(FOnProcessingStart) then
    FOnProcessingStart(Self);

  if UsaProtocollo then
  begin
    if not EnsureProtocol then
      Exit;

    { Sulla via protocollo le istruzioni viaggiano nel ruolo di sistema, a
      parte: nel registro finisce il solo testo della domanda, che e' quello
      che cambia da una chiamata all'altra. }
    ApriRegistrazione(APrompt);

    FProtocol.Reset;
    FProtocol.SetSystemInstruction(FConfiguration.SystemInstruction);
    FProtocol.AddUserText(APrompt);
    Result := SendProtocolRequest;
    Exit;
  end;

  { Nel registro finisce il prompt COMPLETO, istruzioni di sistema comprese:
    e' quello che esce davvero verso il fornitore, ed e' quello che un domani
    si vuole poter rileggere. Se poi il testo si conservi o no lo decide chi
    registra, non il motore. }
  Prompt := BuildPrompt(APrompt);
  ApriRegistrazione(Prompt);

  try
    FRequestId := FChatRequest.Chat(Prompt);
    ArmWatchdog;
    Result := True;
  except
    on E: Exception do
      ReportError(E.Message);
  end;
end;

procedure TzAIEngine.Cancel;
begin
  if not FRequestInProgress then
    Exit;

  FRequestInProgress := False;
  DisarmWatchdog;

  if Assigned(FDriver) then
    FDriver.Cancel(FRequestId);

  ChiudiRegistrazione(EsitoAnnullata, '', '');
end;

procedure TzAIEngine.CloseRequest;
begin
  FRequestInProgress := False;
  FRequestId := TGUID.Empty;
  DisarmWatchdog;
end;

procedure TzAIEngine.ReportError(const ErrorMessage: string);
begin
  CloseRequest;
  FLastError := ErrorMessage;
  ChiudiRegistrazione(EsitoErrore, '', ErrorMessage);

  if FClosing then
    Exit;

  if Assigned(FOnError) then
    FOnError(Self, ErrorMessage)
  else
    if Assigned(FOnResponse) then
      // Senza un gestore dedicato l'errore diventa una risposta: altrimenti
      // chi aspetta resterebbe in attesa per sempre
      FOnResponse(Self, ErrorMessage);
end;

procedure TzAIEngine.ChatResponse(Sender: TObject; const Text: string);
begin
  // Una risposta che arriva dopo l'annullamento non va consegnata
  if FClosing or not FRequestInProgress then
    Exit;

  CloseRequest;
  ChiudiRegistrazione(EsitoOk, Text, '');

  if Assigned(FOnResponse) then
    FOnResponse(Self, Text);
end;

procedure TzAIEngine.ChatError(Sender: TObject; const ErrorMessage: string);
begin
  if FClosing or not FRequestInProgress then
    Exit;

  ReportError(ErrorMessage);
end;

procedure TzAIEngine.ChatPartialResponse(Sender: TObject; const PartialText: string);
begin
  if FClosing or not FRequestInProgress then
    Exit;

  if Assigned(FOnPartialResponse) then
    FOnPartialResponse(Self, PartialText);
end;

procedure TzAIEngine.DriverError(Sender: TObject; const ErrorMessage: string);
begin
  // Arriva solo per gli errori che il driver non ha potuto consegnare al
  // ricevitore della richiesta (vedi HookDriverEvents). Se non c'e' una
  // richiesta in corso e' rumore di una richiesta gia' chiusa
  if FClosing or not FRequestInProgress then
    Exit;

  ReportError(ErrorMessage);
end;

// --- via protocollo (function calling) -------------------------------------

function TzAIEngine.EnsureProtocol: Boolean;
var
  RequiredClass: TzAIProtocolClass;
begin
  RequiredClass := ProtocolClassOf(FConfiguration.DriverName);

  if RequiredClass = nil then
  begin
    FreeAndNil(FProtocol);
    ReportError(Format(MsgProtocolNotAvailable, [FConfiguration.DriverName]));
    Exit(False);
  end;

  if (FProtocol = nil) or (FProtocol.ClassType <> RequiredClass) then
  begin
    FreeAndNil(FProtocol);
    FProtocol := RequiredClass.Create;
  end;

  Result := True;
end;

function TzAIEngine.SendProtocolRequest: Boolean;
var
  Settings: TzAIGenerationSettings;
  RequestJson: string;
begin
  Result := False;
  Settings.Temperature := FConfiguration.Temperature;
  Settings.MaxToken := FConfiguration.MaxToken;
  // Il modello e' quello dei parametri del driver: comprende la scelta fatta
  // nella tendina della chat (Ask con AModel), che la configurazione non ha
  Settings.Model := Trim(FDriver.Params.Values[ParamModel]);

  if Settings.Model = '' then
    Settings.Model := Trim(FConfiguration.Model);

  if Settings.Model = '' then
  begin
    ReportError(Format(MsgModelloMancante, [FConfiguration.DriverName]));
    Exit;
  end;

  try
    RequestJson := FProtocol.BuildRequest(FTools, Settings);
    // L'endpoint e' del protocollo, relativo al BaseURL del driver
    // ('/chat/completions', '/messages', '/chat'). Gemini lo passa vuoto: il
    // suo driver ignora il parametro e usa sempre generateContent
    FRequestId := FDriver.ExecuteJSONRequest(FProtocol.Endpoint, RequestJson, FSinkIntf);
    ArmWatchdog;
    Result := True;
  except
    on E: Exception do
      ReportError(E.Message);
  end;
end;

procedure TzAIEngine.ProtocolError(const AMessage: string);
begin
  if FClosing or not FRequestInProgress then
    Exit;

  ReportError(AMessage);
end;

procedure TzAIEngine.ProtocolResponse(const AJson: string);
var
  Calls: TzAIFunctionCalls;
  Results: TzAIFunctionResults;
  ModelTurn: TJSONObject;
  Text: string;
  Error: string;
  Call: TzAIFunctionCall;
  Esito: TJSONObject;
  Cronometro: TStopwatch;
begin
  // Una risposta che arriva dopo l'annullamento non va consegnata
  if FClosing or not FRequestInProgress then
    Exit;

  DisarmWatchdog;

  Calls := TzAIFunctionCalls.Create(True);
  ModelTurn := nil;
  try
    if not FProtocol.ParseResponse(AJson, Text, Calls, ModelTurn, Error) then
    begin
      ReportError(Error);
      Exit;
    end;

    if Calls.Count = 0 then
    begin
      // Risposta finale: il giro e' chiuso
      CloseRequest;
      ChiudiRegistrazione(EsitoOk, Text, '');

      if Assigned(FOnResponse) then
        FOnResponse(Self, Text);

      Exit;
    end;

    Inc(FToolRound);

    if FToolRound > FMaxToolRounds then
    begin
      ReportError(Format(MsgTroppiGiri, [FMaxToolRounds]));
      Exit;
    end;

    // Il turno del modello si riaccoda cosi' com'e', prima dei risultati:
    // e' l'ordine che il fornitore pretende
    FProtocol.AddModelTurn(ModelTurn);

    Results := TzAIFunctionResults.Create(True);
    try
      for Call in Calls do
      begin
        if Assigned(FOnToolCall) then
          FOnToolCall(Self, Call.Name, Call.Args);

        Cronometro := TStopwatch.StartNew;
        // Siamo sul thread principale (SynchronizeEvents): il gestore dello
        // strumento puo' usare database e interfaccia. Non solleva mai
        Esito := FTools.Execute(Call.Name, Call.Args);

        if Assigned(FOnToolResult) then
          FOnToolResult(Self, Call.Name, Esito, Integer(Cronometro.ElapsedMilliseconds));

        Results.Add(TzAIFunctionResult.Create(Call.Name, Call.Id, Esito));

        // Dentro un gestore l'utente puo' aver premuto Annulla
        if not FRequestInProgress then
          Exit;
      end;

      FProtocol.AddFunctionResults(Results);
    finally
      Results.Free;
    end;

    SendProtocolRequest;
  finally
    ModelTurn.Free;
    Calls.Free;
  end;
end;

// --- cane da guardia --------------------------------------------------------

procedure TzAIEngine.ArmWatchdog;
var
  Ticket: Integer;
  Engine: TzAIEngine;
begin
  Inc(FWatchdogTicket);
  Ticket := FWatchdogTicket;
  Engine := Self;

  // Procedura accodata al thread principale con ritardo. Non si puo'
  // revocare: quando scatta verifica che il motore esista ancora e che la
  // richiesta sia la stessa (stesso biglietto) e sia ancora in corso
  TThread.ForceQueue(nil,
    procedure
    begin
      if not EngineVivo(Engine) then
        Exit;

      if Engine.FClosing or (Engine.FWatchdogTicket <> Ticket) or
         (not Engine.FRequestInProgress) then
        Exit;

      if Assigned(Engine.FDriver) then
        Engine.FDriver.Cancel(Engine.FRequestId);

      Engine.ReportError(MsgNessunaRisposta);
    end,
    ResponseTimeoutMs + WatchdogMargin);
end;

procedure TzAIEngine.DisarmWatchdog;
begin
  // Cambiare biglietto basta: la procedura gia' accodata, quando scatta,
  // trova un biglietto diverso e non fa nulla
  Inc(FWatchdogTicket);
end;

initialization

finalization
  FreeAndNil(EnginesVivi);

end.
