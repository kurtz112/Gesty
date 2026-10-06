// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-14
// ---------------------------------------------------------------------------

unit dmAI;

// Datamodule dei servizi AI del pannello di chat.
//
// Non parla piu' col fornitore: quello lo fa TzAIEngine (zAI.Engine), che tiene
// driver, parametri, tempi di attesa, annullamento ed errori. Qui resta il solo
// pezzo che e' proprio della CHAT e che il motore non puo' conoscere:
//
//   - la trascrizione dello storico in turni utente / assistente, con la
//     finestra scorrevole sugli ultimi messaggi e l'eventuale contesto operativo;
//   - l'anagrafica di facciata (nome dell'assistente, messaggio di benvenuto,
//     elenco dei modelli nella tendina);
//   - la registrazione del motore presso i componenti DevExpress;
//   - la registrazione degli STRUMENTI che il modello puo' chiamare
//     (AI.Strumenti), con la traccia nel registro SmartInspect di ogni
//     chiamata.
//
// Il contratto verso zChatAIPane e' rimasto quello della versione con le
// risposte finte: AssistantName, WelcomeMessage, ListModels, RequestResponse,
// CancelRequest, ResponseInProgress, OnProcessingStart, OnResponse. Il pannello
// non va toccato.
//
// La configurazione e' quella CONDIVISA (AIConfiguration): la chat e' il
// consumatore principale dell'applicazione. La generazione della guida usa
// invece un esemplare tutto suo, cosi' chi cambia modello nella tendina della
// chat non tocca la documentazione.
//
// Da dove arriva la configurazione: prima il DATABASE (AI_UTILIZZI, utilizzo
// 'CHAT', tramite AI.Bridge), poi il file .ini come ripiego. Il ripiego non e'
// una precauzione teorica: serve a far girare la chat sul banco di prova,
// fuori da un ente.

// Togliere il punto dalla direttiva qui sotto per far servire dallo stesso
// motore anche le funzioni AI dei componenti DevExpress (dxRichEdit,
// dxSpreadSheet). Richiede nel progetto l'adattatore dxSmartCoreAI.pas, che
// sta in D:\AI\SRC\dxAI: senza quella unit il progetto non compila.
{.$DEFINE AI_DEVEXPRESS}

// Togliere il punto per NON offrire strumenti al modello: la chat torna alla
// sola via testuale, esattamente come prima del function calling.
{.$DEFINE AI_SENZA_STRUMENTI}

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  zChatTypes,
  zAI.Configuration,
  zAI.Tools,
  zAI.Engine;

const
  // File di configurazione della chat, cercato accanto all'eseguibile. Se non
  // esiste viene creato coi predefiniti e la chiave vuota. Serve solo quando
  // il database non ha la riga: vedi DataModuleCreate
  ChatAIConfigFileName = 'ChatAI.ini';

  // Utilizzo corrispondente in AI_UTILIZZI
  ChatAIUtilizzo = 'CHAT';

type
  TAIResponseEvent = procedure(Sender: TObject; const Text: string) of object;

  TAI = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    FEngine: TzAIEngine;
    FAssistantAuthorId: string;
    FOnProcessingStart: TNotifyEvent;
    FOnResponse: TAIResponseEvent;
    FOnError: TAIResponseEvent;
    FOnPartialResponse: TAIResponseEvent;
    FOnToolCall: TzAIToolCallEvent;
    function BuildPrompt(const Question: string; History: TzChatMessageCollection;
      const ContextInfo: string = ''): string;
    function IsAssistantMessage(ChatMessage: TzChatMessage): Boolean;
    function ConfigFileName: string;
    procedure RegisterDevExpressChatClient;
    procedure RegistraStrumenti;
    procedure EngineProcessingStart(Sender: TObject);
    procedure EngineResponse(Sender: TObject; const Text: string);
    procedure EngineError(Sender: TObject; const ErrorMessage: string);
    procedure EnginePartialResponse(Sender: TObject; const PartialText: string);
    procedure EngineRegistraRichiesta(Sender: TObject;
      const AUtilizzo, AModello, APrompt: string; out AIdRegistrazione: Int64);
    procedure EngineRegistraRisposta(Sender: TObject; const AIdRegistrazione: Int64;
      const AEsito, ARisposta, AErrore: string; ADurataMs: Integer);
    procedure EngineToolCall(Sender: TObject; const AToolName: string; AArgs: TJSONObject);
    procedure EngineToolResult(Sender: TObject; const AToolName: string;
      AResult: TJSONObject; ADurataMs: Integer);
    procedure CaricaConfigurazione;
    function GetConfiguration: TzAIConfiguration;
    function GetResponseInProgress: Boolean;
    function GetLastError: string;
    function GetTools: TzAIToolSet;
  public
    // --- anagrafica del servizio ---
    function AssistantName: string;
    function WelcomeMessage: string;
    { Modelli selezionabili: quelli configurati, altrimenti l'elenco
      suggerito per il driver in uso. Non interroga il fornitore. }
    procedure ListModels(Target: TStrings);
    { Interroga il fornitore per l'elenco reale dei modelli e lo riporta anche
      nella configurazione. Bloccante: va innescata da un comando esplicito,
      mai in fase di creazione della UI. }
    function RefreshModels(Target: TStrings = nil): Boolean;
    { Verifica chiave e raggiungibilita' del fornitore. Bloccante. }
    function TestConnection(out Response: string): Boolean;

    // --- configurazione ---
    { Riallinea il motore alla configurazione. Non serve chiamarla dopo una
      modifica delle proprieta': la configurazione avvisa da sola. }
    procedure ApplyConfiguration;
    property Configuration: TzAIConfiguration read GetConfiguration;
    function DriverName: string;
    property LastError: string read GetLastError;
    { Il motore, per chi ha bisogno dell'oggetto vero (per esempio una finestra
      di impostazioni che vuole provare la connessione). }
    property Engine: TzAIEngine read FEngine;
    { Strumenti offerti al modello (quelli di AI.Strumenti piu' quelli che una
      form volesse aggiungere per la propria durata). }
    property Tools: TzAIToolSet read GetTools;

    // --- conversazione ---
    { Avvia la generazione di una risposta alla domanda col modello scelto.
      Asincrona: scatta prima OnProcessingStart, poi OnResponse (oppure
      OnError). History e' l'intera conversazione corrente (domanda inclusa):
      i motori AI sono senza memoria, quindi il contesto va ritrasmesso a OGNI
      richiesta. Viene serializzata in ruoli utente / assistente e troncata
      agli ultimi Configuration.HistoryDepth messaggi. Model vuoto = modello
      della configurazione. ContextInfo opzionale = contesto scheda attiva. }
    procedure RequestResponse(const Question, Model: string;
      History: TzChatMessageCollection = nil; const ContextInfo: string = '');
    procedure CancelRequest;
    { Id dell'autore che rappresenta l'assistente nella conversazione: serve a
      distinguere i ruoli nello storico. Predefinito 'assistente', quello usato
      da zChatAIPane. }
    property AssistantAuthorId: string read FAssistantAuthorId write FAssistantAuthorId;
    property ResponseInProgress: Boolean read GetResponseInProgress;

    property OnProcessingStart: TNotifyEvent read FOnProcessingStart write FOnProcessingStart;
    property OnResponse: TAIResponseEvent read FOnResponse write FOnResponse;
    { Errore del motore (chiave mancante, quota, rete). Se non e' assegnato il
      testo dell'errore viene consegnato a OnResponse, cosi' l'indicatore di
      scrittura non resta acceso. }
    property OnError: TAIResponseEvent read FOnError write FOnError;
    { Pezzo di risposta in arrivo, per i driver che trasmettono a flusso. }
    property OnPartialResponse: TAIResponseEvent read FOnPartialResponse write FOnPartialResponse;
    { Il modello ha chiesto uno strumento: chi vuole puo' mostrarlo
      ("sto consultando i progetti..."). Il registro SmartInspect lo annota
      comunque. }
    property OnToolCall: TzAIToolCallEvent read FOnToolCall write FOnToolCall;
  end;

var
  AI: TAI;

implementation

uses
  System.IOUtils,
  SmartInspect.Vcl.SiAuto,
  AI.Bridge,
  AI.Strumenti
{$IFDEF AI_DEVEXPRESS}
  , dxAI
  , dxSmartCoreAI
{$ENDIF}
  ;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

const
  // Etichette dei turni nella trascrizione inviata al motore
  UserTurnLabel = 'Utente:';
  AssistantTurnLabel = 'Assistente:';
  // Id dell'autore assistente usato da zChatAIPane
  DefaultAssistantAuthorId = 'assistente';

var
  // La registrazione del motore presso i componenti DevExpress e' globale e
  // vale per tutta l'applicazione: va fatta una volta sola, anche se i
  // pannelli di chat (e quindi i datamodule TAI) sono piu' di uno
  DevExpressChatClientRegistered: Boolean = False;

{ TAI }

procedure TAI.DataModuleCreate(Sender: TObject);
begin
  FAssistantAuthorId := DefaultAssistantAuthorId;

  CaricaConfigurazione;

  FEngine := TzAIEngine.Create(Self);
  FEngine.Utilizzo := ChatAIUtilizzo;
  FEngine.OnProcessingStart := EngineProcessingStart;
  FEngine.OnResponse := EngineResponse;
  FEngine.OnError := EngineError;
  FEngine.OnPartialResponse := EnginePartialResponse;
  FEngine.OnRegistraRichiesta := EngineRegistraRichiesta;
  FEngine.OnRegistraRisposta := EngineRegistraRisposta;
  FEngine.OnToolCall := EngineToolCall;
  FEngine.OnToolResult := EngineToolResult;

  RegistraStrumenti;
  RegisterDevExpressChatClient;
  // Non serve un OnDestroy: il motore e' di proprieta' del datamodule, lo
  // distrugge la catena degli owner, e nel proprio distruttore annulla da se'
  // le richieste in volo e si stacca dalla configurazione condivisa
end;

{ Database prima, file poi. Il database e' la configurazione vera: l'ini resta
  per il banco di prova e per l'installazione che non ha ancora la riga. }
procedure TAI.CaricaConfigurazione;
begin

  try

    if AIBridge.Carica(ChatAIUtilizzo, AIConfiguration) then
      Exit;

  except
    on E: Exception do
      // Database irraggiungibile o tabelle non ancora installate: si ripiega
      // sul file, che e' esattamente il caso per cui esiste
      SiMain.LogWarning('Configurazione AI dal database non riuscita: ' + E.Message);
  end;

  AIConfiguration.LoadFromIniFile(ConfigFileName);
end;

function TAI.ConfigFileName: string;
begin
  Result := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), ChatAIConfigFileName);
end;

{ Gli strumenti sono dell'applicazione (AI.Strumenti), il motore li offre al
  modello. Se il fornitore configurato non ha un protocollo per il function
  calling gli strumenti restano registrati ma inerti: il motore usa la via
  testuale e lo annota. Senza strumenti nulla cambia rispetto a prima. }
procedure TAI.RegistraStrumenti;
begin
{$IFNDEF AI_SENZA_STRUMENTI}
  try
    AIStrumenti.Registra(FEngine.Tools);

    if not FEngine.SupportsTools then
    begin
      SiMain.LogWarning(Format('Fornitore AI "%s" senza protocollo per gli strumenti: chat in sola modalita'' testo',
        [Configuration.DriverName]));
      FEngine.Tools.Clear;
    end
    else
      SiMain.LogMessage(Format('Strumenti AI registrati: %d', [FEngine.Tools.Count]));
  except
    on E: Exception do
    begin
      // Uno strumento mal dichiarato non deve spegnere la chat: si toglie
      // tutto e si prosegue in modalita' testo
      SiMain.LogWarning('Registrazione degli strumenti AI non riuscita: ' + E.Message);
      FEngine.Tools.Clear;
    end;
  end;
{$ENDIF}
end;

procedure TAI.RegisterDevExpressChatClient;
begin
{$IFDEF AI_DEVEXPRESS}
  if DevExpressChatClientRegistered or (FEngine.Driver = nil) then
    exit;

  if not Configuration.RegisterDevExpressChatClient then
    exit;

  // Lo stesso motore serve anche le funzioni AI dei componenti DevExpress
  // (dxRichEdit, dxSpreadSheet). Il client trattiene il driver: cambiare
  // fornitore in esecuzione non lo aggiorna, occorre riavviare
  TdxAIChatClients.AddChatClient(TdxSmartCoreAIChatClient.Create(FEngine.Driver));
  DevExpressChatClientRegistered := True;
  {$ENDIF}
end;

// --- configurazione -------------------------------------------------------

procedure TAI.ApplyConfiguration;
begin
  FEngine.ApplyConfiguration;
end;

function TAI.GetConfiguration: TzAIConfiguration;
begin
  Result := FEngine.Configuration;
end;

function TAI.GetTools: TzAIToolSet;
begin
  Result := FEngine.Tools;
end;

function TAI.DriverName: string;
begin
  Result := FEngine.DriverName;
end;

function TAI.GetLastError: string;
begin
  Result := FEngine.LastError;
end;

// --- anagrafica del servizio ----------------------------------------------

function TAI.AssistantName: string;
begin
  Result := Configuration.AssistantName;
end;

function TAI.WelcomeMessage: string;
begin
  Result := Configuration.WelcomeMessage;
end;

procedure TAI.ListModels(Target: TStrings);
var
  Model: string;
begin
  Target.BeginUpdate;
  try
    Target.Clear;

    if Configuration.Models.Count > 0 then
      Target.AddStrings(Configuration.Models)
    else
      for Model in TzAIConfiguration.SuggestedModels(Configuration.DriverName) do
        Target.Add(Model);

  finally
    Target.EndUpdate;
  end;
end;

function TAI.RefreshModels(Target: TStrings): Boolean;
begin
  Result := FEngine.RefreshModels(Target);
end;

function TAI.TestConnection(out Response: string): Boolean;
begin
  Result := FEngine.TestConnection(Response);
end;

// --- conversazione --------------------------------------------------------

function TAI.GetResponseInProgress: Boolean;
begin
  Result := FEngine.ResponseInProgress;
end;

function TAI.IsAssistantMessage(ChatMessage: TzChatMessage): Boolean;
begin
  Result := Assigned(ChatMessage.Author) and SameText(ChatMessage.Author.Id, FAssistantAuthorId);
end;

function TAI.BuildPrompt(const Question: string; History: TzChatMessageCollection;
  const ContextInfo: string): string;
var
  Lines: TStringList;
  FirstIndex: Integer;
  Index: Integer;
  ChatMessage: TzChatMessage;
  QuestionIncluded: Boolean;
begin
  Lines := TStringList.Create;
  try
    QuestionIncluded := False;

    // Se fornito, il contesto operativo della scheda attiva viene posto in testa
    if Trim(ContextInfo) <> '' then
      Lines.Add(ContextInfo + sLineBreak);

    if Assigned(History) and (History.Count > 0) then
    begin
      // Finestra scorrevole sugli ultimi messaggi: oltre un certo punto il
      // contesto costa e supera il limite del modello
      FirstIndex := 0;

      if (Configuration.HistoryDepth > 0) and (History.Count > Configuration.HistoryDepth) then
        FirstIndex := History.Count - Configuration.HistoryDepth;

      for Index := FirstIndex to History.Count - 1 do
      begin
        ChatMessage := History[Index];

        if Trim(ChatMessage.Text) = '' then
          Continue;

        // I messaggi di benvenuto o di errore non entrano nella conversazione
        if SameText(ChatMessage.Text, Configuration.WelcomeMessage) or
           (ChatMessage.Status = msError) then
          Continue;

        if IsAssistantMessage(ChatMessage) then
          Lines.Add(AssistantTurnLabel + ' ' + ChatMessage.Text)
        else
        begin
          Lines.Add(UserTurnLabel + ' ' + ChatMessage.Text);

          if SameText(ChatMessage.Text, Question) then
            QuestionIncluded := True;
        end;
      end;
    end;

    // La domanda corrente e' gia' in vista quando arriva dal pannello: si
    // aggiunge solo se lo storico non la contiene (o non e' stato passato)
    if not QuestionIncluded then
      Lines.Add(UserTurnLabel + ' ' + Question);

    Result := Trim(Lines.Text);
  finally
    Lines.Free;
  end;
end;

procedure TAI.RequestResponse(const Question, Model: string;
  History: TzChatMessageCollection; const ContextInfo: string);
begin
  // Le istruzioni di sistema le gestisce il motore (anteposte sulla via chat,
  // nel ruolo di sistema sulla via protocollo): qui si passa la trascrizione
  // della conversazione ed eventuale contesto
  FEngine.Ask(BuildPrompt(Question, History, ContextInfo), Model);
end;

procedure TAI.CancelRequest;
begin
  FEngine.Cancel;
end;

procedure TAI.EngineProcessingStart(Sender: TObject);
begin
  if Assigned(FOnProcessingStart) then
    FOnProcessingStart(Self);
end;

procedure TAI.EngineResponse(Sender: TObject; const Text: string);
begin
  if Assigned(FOnResponse) then
    FOnResponse(Self, Text);
end;

procedure TAI.EngineError(Sender: TObject; const ErrorMessage: string);
begin
  if Assigned(FOnError) then
    FOnError(Self, ErrorMessage)
  else
    if Assigned(FOnResponse) then
      // Senza un gestore dedicato l'errore diventa una risposta: altrimenti la
      // chat resterebbe con l'indicatore di scrittura acceso
      FOnResponse(Self, ErrorMessage);
end;

procedure TAI.EnginePartialResponse(Sender: TObject; const PartialText: string);
begin
  if Assigned(FOnPartialResponse) then
    FOnPartialResponse(Self, PartialText);
end;

{ Strumenti: traccia completa nel registro SmartInspect (nome, argomenti,
  risultato, durata). Non nel registro AI del database: quello descrive la
  chiamata al fornitore, e i risultati degli strumenti finiranno comunque
  dentro la richiesta successiva. }
procedure TAI.EngineToolCall(Sender: TObject; const AToolName: string; AArgs: TJSONObject);
begin
  SiMain.LogMessage(Format('Strumento AI richiesto: %s %s', [AToolName, AArgs.ToJSON]));

  if Assigned(FOnToolCall) then
    FOnToolCall(Self, AToolName, AArgs);
end;

procedure TAI.EngineToolResult(Sender: TObject; const AToolName: string;
  AResult: TJSONObject; ADurataMs: Integer);
begin
  SiMain.LogMessage(Format('Strumento AI eseguito: %s in %d ms, %d caratteri di risultato',
    [AToolName, ADurataMs, Length(AResult.ToJSON)]));
end;

{ Registro delle chiamate: il motore misura e consegna, il ponte scrive. Se il
  database non risponde la chat non deve fermarsi, quindi l'errore si annota e
  si tira dritto. }
procedure TAI.EngineRegistraRichiesta(Sender: TObject;
  const AUtilizzo, AModello, APrompt: string; out AIdRegistrazione: Int64);
begin
  AIdRegistrazione := 0;

  try
    AIdRegistrazione := AIBridge.ApriRegistro(AUtilizzo, AModello, APrompt);
  except
    on E: Exception do
      SiMain.LogWarning('Registro AI non scritto: ' + E.Message);
  end;
end;

procedure TAI.EngineRegistraRisposta(Sender: TObject; const AIdRegistrazione: Int64;
  const AEsito, ARisposta, AErrore: string; ADurataMs: Integer);
begin

  try
    AIBridge.ChiudiRegistro(AIdRegistrazione, AEsito, ARisposta, AErrore, ADurataMs);
  except
    on E: Exception do
      SiMain.LogWarning('Registro AI non chiuso: ' + E.Message);
  end;
end;

end.
