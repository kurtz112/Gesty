// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-13
// ---------------------------------------------------------------------------

unit AI.Bridge;

// Ponte applicativo dei servizi AI.
//
// Qui e SOLO qui vivono database, stored procedure e transazioni: il motore
// (zAI.Engine) e la configurazione (zAI.Configuration) sono unit di libreria
// e di Firebird non sanno nulla. E' la stessa divisione del ponte della firma
// (Documentazione.Bridge.Firma), da cui questa unit prende la forma.
//
// Fa due cose:
//
//   Carica            riempie una TzAIConfiguration leggendo AI_UTILIZZI (e i
//                     parametri liberi del fornitore) per l'utilizzo chiesto.
//                     Falso se per quell'utilizzo non c'e' riga o e' spenta:
//                     chi chiama ricade sul file .ini.
//
//   ApriRegistro /    scrivono il registro delle chiamate. Si agganciano agli
//   ChiudiRegistro    eventi OnRegistraRichiesta / OnRegistraRisposta del
//                     motore, che misura il tempo e passa i testi.
//
// La regola di riservatezza NON e' applicata qui: e' AI_UTILIZZI.REGISTRAZIONE
// a dire se i testi si conservano, e a farla rispettare sono le procedure
// AI_LOG_REQUEST_ADD e AI_LOG_RESPONSE_ADD, che svuotano il testo quando non
// e' consentito. Questa unit il testo lo passa e basta: la decisione sta in un
// punto solo, nel database, e vale anche per un chiamante distratto.
//
// I wrapper TSP_ai_* vengono da Gesty_StoredProcs (generata dal tool):
// rigenerarla dopo aver eseguito lo script 05 sul database.

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Base_DataModule,
  Gesty_StoredProcs,
  zAI.Configuration, dbMaster;

type
  { Quello che serve al registro e che non sta nella configurazione del
    motore: chi e' il fornitore, quanto dato gli e' concesso, cosa si puo'
    scrivere. Si riempie al momento della Carica e si rilegge a ogni chiamata,
    senza tornare sul database. }
  TAIDatiUtilizzo = record
    Fornitore: string;
    LivelloDati: string;
    Registrazione: string;
  end;

  TAIBridge = class(TBaseDataModule)
  private
    FIdTenant: Int64;
    FUtilizzi: TDictionary<string, TAIDatiUtilizzo>;
    function Impronta(const ATesto: string): string;
    function DatiUtilizzo(const AUtilizzo: string): TAIDatiUtilizzo;
    procedure CaricaParametri(const AFornitore: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    { Riempie la configurazione dall'utilizzo indicato ('CHAT', 'GUIDA', ...).
      Falso = nessuna riga, o riga spenta, o fornitore spento: la
      configurazione non viene toccata e chi chiama decide come ripiegare. }
    function Carica(const AUtilizzo: string; ATarget: TzAIConfiguration): Boolean;

    { Apre la riga di registro e ne ritorna la chiave. Zero se non si e'
      potuto scrivere: il motore prosegue lo stesso. }
    function ApriRegistro(const AUtilizzo, AModello, APrompt: string): Int64;

    { Chiude la riga con l'esito ('OK', 'ERR', 'TIM', 'ANN'). }
    procedure ChiudiRegistro(AIdRichiesta: Int64;
      const AEsito, ARisposta, AErrore: string; ADurataMs: Integer);

    { Ente su cui si legge e si scrive. }
    property IdTenant: Int64 read FIdTenant write FIdTenant;
  end;

{ Esemplare condiviso, creato al primo uso sull'ente di lavoro. Stessa scelta
  del ponte della firma: nasce quando serve, non all'avvio. }
function AIBridge: TAIBridge;

implementation

uses
  System.Hash,
  dmCommon;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

const
  { Predefiniti prudenti per quando il database non dice nulla: nessun dato di
    record al fornitore, e nel registro i soli metadati. }
  LivelloDatiMinimo = 'NES';
  RegistrazioneMinima = 'MET';
  { Nome dell'operazione nel registro. Oggi la chiamata e' una sola per tutti
    gli utilizzi; il giorno che ce ne fossero altre (immagini, incorporamenti)
    questo campo le distingue. }
  OperazioneChat = 'CHAT';

var
  BridgeCondiviso: TAIBridge = nil;

function AIBridge: TAIBridge;
begin

  if BridgeCondiviso = nil then
  begin
    BridgeCondiviso := TAIBridge.Create(Common);
    BridgeCondiviso.IdTenant := Common.EnteDefault;
  end;

  Result := BridgeCondiviso;
end;

{ TAIBridge }

constructor TAIBridge.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FUtilizzi := TDictionary<string, TAIDatiUtilizzo>.Create;
end;

destructor TAIBridge.Destroy;
begin
  FreeAndNil(FUtilizzi);
  inherited Destroy;
end;

function TAIBridge.Impronta(const ATesto: string): string;
begin
  { Riconosce due chiamate identiche. NON e' anonimizzazione: l'impronta di un
    dato personale resta un dato personale, e su un testo breve si ricostruisce
    per tentativi. Vive sotto le stesse regole di conservazione del testo. }
  if ATesto = '' then
    Result := ''
  else
    Result := THashSHA2.GetHashString(ATesto, THashSHA2.TSHA2Version.SHA256);
end;

function TAIBridge.DatiUtilizzo(const AUtilizzo: string): TAIDatiUtilizzo;
begin

  if not FUtilizzi.TryGetValue(AUtilizzo.ToUpper, Result) then
  begin
    { Utilizzo mai caricato: si registra lo stesso, col grado piu' chiuso.
      Meglio una riga prudente che nessuna riga. }
    Result.Fornitore := '';
    Result.LivelloDati := LivelloDatiMinimo;
    Result.Registrazione := RegistrazioneMinima;
  end;
end;

procedure TAIBridge.CaricaParametri(const AFornitore: string);
var
  spParametri: TSP_ai_Config_Parametri_Get;
begin
  { Parametri liberi del fornitore. Oggi nessuno di essi ha un corrispondente
    in TzAIConfiguration: si leggono comunque, perche' e' qui che andranno
    quando serviranno (TopK, TopP, versione dell'API). }
  spParametri := GetSP<TSP_ai_Config_Parametri_Get>();
  try
    spParametri.Id_Tenant := FIdTenant;
    spParametri.Fornitore := AFornitore;

    { Procedura SELEZIONABILE: va aperta con Open. Con Execute il cursore non
      nasce e il ciclo non parte — e' l'inciampo del Mantis #61 sul ponte
      della firma, che qui si evita in partenza. }
    spParametri.Open;

    while not spParametri.EOF do
    begin
      // Posto dove travasarli quando serviranno:
      // ATarget.Parametri.AddOrSetValue(spParametri.Chiave.Value.ToUpper,
      //                                 spParametri.Valore.Value);
      spParametri.Next;
    end;

  finally
    spParametri.Close;
    FreeAndNil(spParametri);
  end;
end;

function TAIBridge.Carica(const AUtilizzo: string; ATarget: TzAIConfiguration): Boolean;
var
  spUtilizzo: TSP_ai_Utilizzo_Get;
  Dati: TAIDatiUtilizzo;
begin
  Result := False;

  if not Assigned(ATarget) then
    Exit;

  spUtilizzo := GetSP<TSP_ai_Utilizzo_Get>();
  try
    spUtilizzo.Id_Tenant := FIdTenant;
    spUtilizzo.Utilizzo := AUtilizzo;
    spUtilizzo.ExecuteWithoutCommit;

    { Nessuna riga, impiego spento o fornitore spento: la procedura risponde
      ATTIVO falso in tutti e tre i casi, cosi' qui il controllo e' uno solo. }
    if spUtilizzo.Fornitore.IsNull or (not spUtilizzo.Attivo.Value) then
      Exit;

    Dati.Fornitore := spUtilizzo.Fornitore.Value;
    Dati.LivelloDati := spUtilizzo.Livello_Dati_Effettivo.Value;
    Dati.Registrazione := spUtilizzo.Registrazione.Value;

    if Dati.LivelloDati.IsEmpty then
      Dati.LivelloDati := LivelloDatiMinimo;

    if Dati.Registrazione.IsEmpty then
      Dati.Registrazione := RegistrazioneMinima;

    FUtilizzi.AddOrSetValue(AUtilizzo.ToUpper, Dati);

    ATarget.DriverName := Dati.Fornitore;
    ATarget.APIKey := spUtilizzo.Api_Key.Value;

    { I valori nulli NON si travasano: lasciano in piedi il predefinito scritto
      nel codice, che e' il terzo gradino della precedenza (utilizzo, poi
      parametro del fornitore, poi codice). Assegnare zero direbbe un'altra
      cosa — "nessun limite" — e non e' quello che una casella vuota vuol dire. }
    if not spUtilizzo.Modello.IsNull then
      ATarget.Model := spUtilizzo.Modello.Value;

    if not spUtilizzo.Url_Base.IsNull then
      ATarget.BaseURL := spUtilizzo.Url_Base.Value;

    if not spUtilizzo.Max_Token.IsNull then
      ATarget.MaxToken := spUtilizzo.Max_Token.Value;

    if not spUtilizzo.Temperatura.IsNull then
      ATarget.Temperature := spUtilizzo.Temperatura.Value;

    if not spUtilizzo.Timeout_Ms.IsNull then
      ATarget.Timeout := spUtilizzo.Timeout_Ms.Value;

    if not spUtilizzo.Profondita_Storico.IsNull then
      ATarget.HistoryDepth := spUtilizzo.Profondita_Storico.Value;

    // Parametro MEMO: si legge col testo, non col valore
    ATarget.SystemInstruction := spUtilizzo.Istruzioni_Sistema.Text;
  finally
    FreeAndNil(spUtilizzo);
  end;

  CaricaParametri(Dati.Fornitore);
  Result := True;
end;

function TAIBridge.ApriRegistro(const AUtilizzo, AModello, APrompt: string): Int64;
var
  spLog: TSP_ai_Log_Request_Add;
  Dati: TAIDatiUtilizzo;
begin
  Result := 0;
  Dati := DatiUtilizzo(AUtilizzo);

  spLog := GetSP<TSP_ai_Log_Request_Add>();
  try
    spLog.Id_Tenant := FIdTenant;
    spLog.Utilizzo := AUtilizzo;
    spLog.Fornitore := Dati.Fornitore;
    spLog.Modello := AModello;
    spLog.Operazione := OperazioneChat;

    { Livello dei dati EFFETTIVAMENTE applicato e regola di registrazione:
      vengono dalla stessa lettura che ha configurato il motore, non da una
      seconda interrogazione. Sono la prova, a mesi di distanza, di cosa era
      consentito uscire quel giorno. }
    spLog.Livello_Dati := Dati.LivelloDati;
    spLog.Registrazione := Dati.Registrazione;

    spLog.Richiesta_Impronta := Impronta(APrompt);
    spLog.Richiesta_Caratteri := Length(APrompt);
    // Parametro MEMO: si scrive col testo. Se la regola non consente i testi
    // e' la procedura a svuotarlo
    spLog.Richiesta.Text := APrompt;

    spLog.ExecuteAndCommit;
    Result := spLog.Id_Ai_Log_Request.Value;
  finally
    FreeAndNil(spLog);
  end;
end;

procedure TAIBridge.ChiudiRegistro(AIdRichiesta: Int64;
  const AEsito, ARisposta, AErrore: string; ADurataMs: Integer);
var
  spLog: TSP_ai_Log_Response_Add;
begin

  if AIdRichiesta = 0 then
    Exit;

  spLog := GetSP<TSP_ai_Log_Response_Add>();
  try
    spLog.Id_Ai_Log_Request := AIdRichiesta;
    spLog.Esito := AEsito;
    spLog.Durata_Ms := ADurataMs;
    spLog.Risposta_Impronta := Impronta(ARisposta);
    spLog.Risposta_Caratteri := Length(ARisposta);
    spLog.Risposta.Text := ARisposta;

    { L'errore si registra SEMPRE, anche a testi disattivati: descrive il
      guasto, non il contenuto. }
    spLog.Errore.Text := AErrore;

    spLog.ExecuteAndCommit;
  finally
    FreeAndNil(spLog);
  end;
end;


initialization

finalization

// L'esemplare condiviso ha Common come proprietario: lo distrugge la catena
// degli owner. Qui si azzera solo il riferimento.
BridgeCondiviso := nil;

end.
