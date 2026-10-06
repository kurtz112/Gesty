unit Documentazione.Bridge.Messaggi;

// Ponte applicativo dell'invio PEC multi-fornitore (Gesty).
// Gemello di Documentazione.Bridge.Firma: qui e SOLO qui vivono database, stored
// procedure e transazioni; il provider (zDocumentale.Messaggi.Smtp, ...) riceve
// configurazione e callback di log e non tocca mai il DB.
//
// Flusso: InviaMessaggio (spedizione 'P' + destinatari + file, PRIMA della
// chiamata al gestore: idempotenza) -> provider.Invia -> 'I' (in attesa
// delle ricevute) o 'E' (ritentabile). Poi AggiornaStatoPerCatena (polling):
// provider.LeggiRicevute -> per ogni ricevuta nuova crea la versione RIC
// nella catena (l'.eml firmato dal gestore) e registra la ricevuta con gli
// effetti di stato (OBJ_FILES_MAIL_E_MESSAGGI_RICEVUTA_ADD: accettazione->'A',
// consegna->'C' quando tutti i principali sono consegnati, N/E->'E').
//
// A differenza della firma, e' il PONTE (non il provider) a creare le
// versioni RIC: il provider restituisce l'.eml in un file temporaneo.
//
// I wrapper TSP_* vengono da Gesty_StoredProcs (generata dal tool):
// rigenerarla dopo aver eseguito lo script 08_pec_gesty.sql.

interface

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  Base_DataModule,
  zDocumentale.Messaggi.Types,
  zDocumentale.Messaggi.Intf,
  zDocumentale.Messaggi.ProviderBase,
  zDocumentale.Messaggi.Factory,
  Gesty_StoredProcs,
  dbMaster;

type
  TDocumentazioneBridgeMessaggi = class(TBaseDataModule)
  private
    FIdTenant: Int64;
    FConfigurazione: TzMessaggioConfigurazione;
    FConfigurazioneCaricata: Boolean;

    procedure CaricaConfigurazione;
    function CreaProvider(IdMessaggio: Int64): IzMessaggioProvider;
    procedure RegistraErrore(IdMessaggio: Int64; E: Exception);

    function FullFileName(IdObjectFile: Int64): string;
    function FilePrincipale(IdMessaggio: Int64): Int64;
    function RicevutaEsiste(IdMessaggio: Int64; const Ricevuta: TzMessaggioRicevuta): Boolean;
    function CreaVersioneRicevuta(IdObjectFilePadre: Int64; const Ricevuta: TzMessaggioRicevuta): Int64;
    procedure AggiornaStatoSpedizione(IdMessaggio: Int64);
  public
    destructor Destroy; override;

    // il fornitore attivo del tenant ('' = PEC non configurata:
    // il bottone Invia PEC non compare)
    function FornitoreAttivo: string;

    // crea la spedizione (destinatari + il documento come allegato
    // principale) e la invia subito. Ritorna ID_MESSAGGIO.
    function InviaMessaggio(const Oid, IdObjectFile: Int64; const Oggetto, Corpo: string; const Destinatari: TArray<TzMessaggioDestinatario>): Int64;

    // ------------------------------------------------------------------
    // Servizi per il controller delle azioni documentali
    // ------------------------------------------------------------------

    // i TIPO_VERSIONE presenti (non annullati/eliminati) nella catena.
    // E' generico (legge OBJ_FILES_VERSIONI): serve al gate 3 (req) quando
    // un controller ha solo il ponte PEC e non quello della firma.
    function TipiVersioneInCatena(IdObjectFile: Int64): TArray<string>;

    // polling della spedizione trovata sulla catena (se in attesa di ricevute)
    procedure AggiornaStatoPerCatena(IdObjectFile: Int64);

    // stato dell'ultima spedizione sulla CATENA del file (gate 4 della UI:
    // da passare a StatoAzioneDaRegistrazione); '' = mai spedito
    function StatoMessaggioPerCatena(IdObjectFile: Int64): string;

    // estremi leggibili dell'ultima spedizione sulla catena
    function EstremiMessaggioPerCatena(IdObjectFile: Int64): string;

    function VerificaRicevutePendenti: Integer;

    property IdTenant: Int64 read FIdTenant write FIdTenant;
  end;

var
  DocumentazioneBridgeMessaggi: TDocumentazioneBridgeMessaggi;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

function TipoRicevutaChar(Tipo: TzMessaggioTipoRicevuta): string;
begin
  case Tipo of
    prAccettazione:
      result := 'A';
    prConsegna:
      result := 'C';
    prNonAccettazione:
      result := 'N';
    prMancataConsegna:
      result := 'E';
  else
    result := '';
  end;
end;

destructor TDocumentazioneBridgeMessaggi.Destroy;
begin
  if FConfigurazioneCaricata then
    FConfigurazione.Finalizza;
  inherited;
end;

procedure TDocumentazioneBridgeMessaggi.CaricaConfigurazione;
var
  spConfigurazione: TSP_OBJ_FILES_MAIL_E_MESSAGGI_CONFIGURAZIONE_GET;
  spParametri: TSP_OBJ_FILES_MAIL_E_MESSAGGI_CONFIG_PARAMETRI_GET;
begin
  if FConfigurazioneCaricata then
    FConfigurazione.Finalizza;

  FConfigurazione.Inizializza;
  FConfigurazioneCaricata := True;

  spConfigurazione := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_CONFIGURAZIONE_GET>();
  try
    spConfigurazione.Id_Tenant := FIdTenant;
    spConfigurazione.ExecuteWithoutCommit;

    FConfigurazione.Fornitore := spConfigurazione.Fornitore;
    FConfigurazione.IdTenant := FIdTenant;
    FConfigurazione.IndirizzoMittente := spConfigurazione.Indirizzo_Mittente;
    FConfigurazione.Utente := spConfigurazione.Utente;
    FConfigurazione.Password := spConfigurazione.Password_;

    if not spConfigurazione.Attivo.value then
      FConfigurazione.Fornitore := '';
  finally
    FreeAndNil(spConfigurazione);
  end;

  if FConfigurazione.Fornitore.IsEmpty then
    exit;

  spParametri := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_CONFIG_PARAMETRI_GET>();
  try
    spParametri.Id_Tenant := FIdTenant;
    spParametri.Fornitore := FConfigurazione.Fornitore;
    // Mantis #61 - 2026-08-31: procedura selezionabile, va aperta con Open
    spParametri.Open;

    while not spParametri.EOF do
    begin
      FConfigurazione.Parametri.AddOrSetValue(spParametri.Chiave.value.ToUpper, spParametri.Valore);
      spParametri.Next;
    end;
  finally
    spParametri.Close;
    FreeAndNil(spParametri);
  end;
end;

function TDocumentazioneBridgeMessaggi.FornitoreAttivo: string;
begin
  CaricaConfigurazione;
  result := FConfigurazione.Fornitore;
end;

function TDocumentazioneBridgeMessaggi.CreaProvider(IdMessaggio: Int64): IzMessaggioProvider;
var
  ProviderBase: TzMessaggioProviderBase;
begin
  CaricaConfigurazione;

  if FConfigurazione.Fornitore.IsEmpty then
    raise EzMessaggioErrore.Create('Nessun fornitore PEC configurato per l''ente');

  result := TzMessaggioFactory.Crea(FConfigurazione.Fornitore);
  result.Configura(FConfigurazione);

  ProviderBase := result as TzMessaggioProviderBase;

  ProviderBase.OnLogRequest := function(const Operazione, Endpoint, Richiesta: string): Int64
    var
      sp: TSP_OBJ_FILES_MAIL_E_MESSAGGI_LOG_REQUEST_ADD;
    begin
      sp := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_LOG_REQUEST_ADD>();
      try
        sp.Id_Messaggio := IdMessaggio;
        sp.Id_Tenant := FIdTenant;
        sp.Fornitore := FConfigurazione.Fornitore;
        sp.Operazione := Operazione;
        sp.Endpoint := Endpoint;
        sp.Richiesta.text := Richiesta;
        sp.ExecuteAndCommit;
        result := sp.Id_Log_Request;
      finally
        FreeAndNil(sp);
      end;
    end;

  ProviderBase.OnLogResponse := procedure(IdLogRequest: Int64; HttpStatus: Integer; const Risposta, Errore: string)
    var
      sp: TSP_OBJ_FILES_MAIL_E_MESSAGGI_LOG_RESPONSE_ADD;
    begin
      sp := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_LOG_RESPONSE_ADD>();
      try
        sp.Id_Log_Request := IdLogRequest;
        sp.Http_Status := HttpStatus;
        sp.Risposta.text := Risposta;
        sp.Errore.text := Errore;
        sp.ExecuteAndCommit;
      finally
        FreeAndNil(sp);
      end;
    end;
end;

procedure TDocumentazioneBridgeMessaggi.RegistraErrore(IdMessaggio: Int64; E: Exception);
var
  sp: TSP_OBJ_FILES_MAIL_E_MESSAGGI_ERRORE;
begin
  sp := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_ERRORE>();
  try
    sp.Id_Messaggio := IdMessaggio;
    sp.Messaggio.text := E.Message;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;
end;

function TDocumentazioneBridgeMessaggi.FullFileName(IdObjectFile: Int64): string;
var
  sp: TSP_GET_FULL_FILE_NAME;
begin
  sp := GetSP<TSP_GET_FULL_FILE_NAME>();
  try
    sp.Id_Object_File := IdObjectFile;
    sp.ExecuteWithoutCommit;
    result := sp.Full_File_Name;
  finally
    FreeAndNil(sp);
  end;
end;

function TDocumentazioneBridgeMessaggi.FilePrincipale(IdMessaggio: Int64): Int64;
var
  sp: TSP_OBJ_FILES_MAIL_E_MESSAGGI_FILES_GET;
  primo: Int64;
begin
  result := 0;
  primo := 0;

  sp := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_FILES_GET>();
  try
    sp.Id_Messaggio := IdMessaggio;
    // Mantis #61 - 2026-08-31: procedura selezionabile, va aperta con Open.
    // Il break lascia il cursore aperto: la chiusura sta nel finally
    sp.Open;
    while not sp.EOF do
    begin
      if primo = 0 then
        primo := sp.Id_Object_File;
      if sp.Principale then
      begin
        result := sp.Id_Object_File;
        break;
      end;
      sp.Next;
    end;
  finally
    sp.Close;
    FreeAndNil(sp);
  end;

  if result = 0 then
    result := primo;
end;

function TDocumentazioneBridgeMessaggi.RicevutaEsiste(IdMessaggio: Int64; const Ricevuta: TzMessaggioRicevuta): Boolean;
var
  sp: TSP_OBJ_FILES_MAIL_E_MESSAGGI_RICEVUTA_ESISTE;
begin
  sp := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_RICEVUTA_ESISTE>();
  try
    sp.Id_Messaggio := IdMessaggio;
    sp.Tipo_Ricevuta := TipoRicevutaChar(Ricevuta.Tipo);
    sp.Indirizzo_Destinatario := Ricevuta.IndirizzoDestinatario;
    sp.Message_Id := Ricevuta.MessageId;
    sp.ExecuteWithoutCommit;
    result := sp.Esiste;
  finally
    FreeAndNil(sp);
  end;
end;

function TDocumentazioneBridgeMessaggi.CreaVersioneRicevuta(IdObjectFilePadre: Int64; const Ricevuta: TzMessaggioRicevuta): Int64;
var
  sp: TSP_OBJ_FILES_VERSIONE_ADD;
  suffisso: string;
  percorsoDefinitivo: string;
begin
  result := 0;

  if Ricevuta.FileRicevuta.IsEmpty or not TFile.Exists(Ricevuta.FileRicevuta) then
    exit;

  case Ricevuta.Tipo of
    prAccettazione:
      suffisso := '_accettazione';
    prConsegna:
      suffisso := '_consegna';
    prNonAccettazione:
      suffisso := '_non_accettazione';
    prMancataConsegna:
      suffisso := '_mancata_consegna';
  else
    suffisso := '_ricevuta';
  end;

  sp := GetSP<TSP_OBJ_FILES_VERSIONE_ADD>();
  try
    sp.Id_Object_File_Padre := IdObjectFilePadre;
    sp.Tipo_Versione := 'RIC';
    sp.Nome_File_Originale := 'ricevuta' + suffisso + '.eml';
    sp.File_Suffix := suffisso;
    sp.File_Size := 0;
    sp.ExecuteAndCommit;
    result := sp.Id_Object_File;
    percorsoDefinitivo := sp.Full_File_Name;
  finally
    FreeAndNil(sp);
  end;

  ForceDirectories(ExtractFilePath(percorsoDefinitivo));
  TFile.Copy(Ricevuta.FileRicevuta, percorsoDefinitivo, True);
end;

function TDocumentazioneBridgeMessaggi.InviaMessaggio(const Oid, IdObjectFile: Int64; const Oggetto, Corpo: string; const Destinatari: TArray<TzMessaggioDestinatario>): Int64;
var
  spSpedizione: TSP_OBJ_FILES_MAIL_E_MESSAGGI_ADD;
  spDestinatario: TSP_OBJ_FILES_MAIL_E_MESSAGGI_DESTINATARIO_ADD;
  spFile: TSP_OBJ_FILES_MAIL_E_MESSAGGI_FILE_ADD;
  spInviata: TSP_OBJ_FILES_MAIL_E_MESSAGGI_INVIATO;
  destinatario: TzMessaggioDestinatario;
  provider: IzMessaggioProvider;
  Messaggio: TzMessaggio;
  allegato: TzMessaggioAllegato;
  esito: TzMessaggioEsito;
begin
  CaricaConfigurazione;

  if FConfigurazione.Fornitore.IsEmpty then
    raise EzMessaggioErrore.Create('Nessun fornitore PEC configurato per l''ente');

  if Length(Destinatari) = 0 then
    raise EzMessaggioErrore.Create('Nessun destinatario indicato per la PEC');

  // 1. registrazione 'P' prima della chiamata al gestore (idempotenza)
  spSpedizione := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_ADD>();
  try
    spSpedizione.Id_Tenant := FIdTenant;
    spSpedizione.Fornitore := FConfigurazione.Fornitore;
    spSpedizione.Oid := Oid;
    spSpedizione.Oggetto := Oggetto;
    spSpedizione.Corpo.text := Corpo;
    spSpedizione.Indirizzo_Mittente := FConfigurazione.IndirizzoMittente;
    spSpedizione.ExecuteAndCommit;
    result := spSpedizione.Id_Messaggio;
  finally
    FreeAndNil(spSpedizione);
  end;

  // 2. destinatari
  for destinatario in Destinatari do
  begin
    spDestinatario := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_DESTINATARIO_ADD>();
    try
      spDestinatario.Id_Messaggio := result;
      spDestinatario.Indirizzo := destinatario.Indirizzo;
      if destinatario.Tipo = pdDestinatario then
        spDestinatario.Tipo := 'A'
      else
        spDestinatario.Tipo := 'C';
      spDestinatario.ExecuteAndCommit;
    finally
      FreeAndNil(spDestinatario);
    end;
  end;

  // 3. il documento come allegato principale (valorizza anche l'OID)
  spFile := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_FILE_ADD>();
  try
    spFile.Id_Messaggio := result;
    spFile.Id_Object_File := IdObjectFile;
    spFile.Principale := True;
    spFile.ExecuteAndCommit;
  finally
    FreeAndNil(spFile);
  end;

  // 4. messaggio per il provider (il path fisico lo risolve il ponte)
  Messaggio.Clear;
  Messaggio.Oid := Oid;
  Messaggio.Oggetto := Oggetto;
  Messaggio.Corpo := Corpo;
  Messaggio.Destinatari := Destinatari;

  allegato.Clear;
  allegato.IdObjectFile := IdObjectFile;
  allegato.FullFileName := FullFileName(IdObjectFile);
  allegato.Principale := True;
  Messaggio.Allegati := [allegato];

  provider := CreaProvider(result);

  // la spedizione esiste GIA' (idempotenza): la chiamata al gestore sta
  // fuori da ogni transazione locale
  try
    esito := provider.Invia(Messaggio);
  except
    on E: Exception do
    begin
      RegistraErrore(result, E);
      raise;
    end;
  end;

  spInviata := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_INVIATO>();
  try
    spInviata.Id_Messaggio := result;
    spInviata.Message_Id := esito.MessageId;
    spInviata.Stato_Esterno := esito.StatoEsterno;
    spInviata.ExecuteAndCommit;
  finally
    FreeAndNil(spInviata);
  end;
end;

procedure TDocumentazioneBridgeMessaggi.AggiornaStatoSpedizione(IdMessaggio: Int64);
var
  spGet: TSP_OBJ_FILES_MAIL_E_MESSAGGI_GET;
  spRicevuta: TSP_OBJ_FILES_MAIL_E_MESSAGGI_RICEVUTA_ADD;
  provider: IzMessaggioProvider;
  statoCorrente: string;
  MessageId: string;
  idPrincipale: Int64;
  ricevute: TArray<TzMessaggioRicevuta>;
  Ricevuta: TzMessaggioRicevuta;
  idVersioneRicevuta: Int64;
begin
  spGet := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_GET>();
  try
    spGet.Id_Messaggio := IdMessaggio;
    spGet.ExecuteWithoutCommit;
    statoCorrente := spGet.Stato;
    MessageId := spGet.Message_Id;
  finally
    FreeAndNil(spGet);
  end;

  // solo le spedizioni in attesa di ricevute (I/A) hanno qualcosa da chiedere
  if (statoCorrente <> MESSAGGIO_STATO_INVIATA) and (statoCorrente <> MESSAGGIO_STATO_ACCETTATA) then
    exit;

  idPrincipale := FilePrincipale(IdMessaggio);

  provider := CreaProvider(IdMessaggio);

  try
    ricevute := provider.LeggiRicevute([MessageId]);
  except
    on E: Exception do
    begin
      RegistraErrore(IdMessaggio, E);
      raise;
    end;
  end;

  for Ricevuta in ricevute do
  begin
    // il re-poll rilegge tutta la casella: le ricevute gia' registrate si
    // saltano (niente versione RIC orfana). Il temporaneo si elimina comunque.
    if RicevutaEsiste(IdMessaggio, Ricevuta) then
    begin
      try
        if not Ricevuta.FileRicevuta.IsEmpty then
          if TFile.Exists(Ricevuta.FileRicevuta) then
            TFile.Delete(Ricevuta.FileRicevuta);
      except
      end;
      continue;
    end;

    idVersioneRicevuta := CreaVersioneRicevuta(idPrincipale, Ricevuta);

    try
      if not Ricevuta.FileRicevuta.IsEmpty then
        if TFile.Exists(Ricevuta.FileRicevuta) then
          TFile.Delete(Ricevuta.FileRicevuta);
    except
    end;

    spRicevuta := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_RICEVUTA_ADD>();
    try
      spRicevuta.Id_Messaggio := IdMessaggio;
      spRicevuta.Tipo_Ricevuta := TipoRicevutaChar(Ricevuta.Tipo);
      spRicevuta.Indirizzo_Destinatario := Ricevuta.IndirizzoDestinatario;
      spRicevuta.Data_Ora_Ricevuta := Ricevuta.DataOra;
      spRicevuta.Message_Id := Ricevuta.MessageId;
      if idVersioneRicevuta <> 0 then
        spRicevuta.Id_Object_File_Ricevuta := idVersioneRicevuta;
      spRicevuta.ExecuteAndCommit;
    finally
      FreeAndNil(spRicevuta);
    end;
  end;
end;

function TDocumentazioneBridgeMessaggi.TipiVersioneInCatena(IdObjectFile: Int64): TArray<string>;
var
  sp: TSP_OBJ_FILES_VERSIONI;
begin
  result := nil;

  sp := GetSP<TSP_OBJ_FILES_VERSIONI>();
  try
    sp.Id_Object_File := IdObjectFile;
    // Mantis #61 - 2026-08-31: procedura selezionabile, va aperta con Open
    sp.Open;
    while not sp.EOF do
    begin
      if not sp.Annullato.value then
        if not sp.Eliminato.value then
          result := result + [sp.Tipo_Versione];
      sp.Next;
    end;
  finally
    sp.Close;
    FreeAndNil(sp);
  end;
end;

function TDocumentazioneBridgeMessaggi.VerificaRicevutePendenti: Integer;
var
  sp: TSP_OBJ_FILES_MAIL_E_MESSAGGI_DA_VERIFICARE_GET;
  daVerificare: TArray<Int64>;
  IdMessaggio: Int64;
begin
  result := 0;
  daVerificare := nil;
  sp := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_DA_VERIFICARE_GET>();
  try
    sp.Id_Tenant := FIdTenant;
    // Mantis #61 - 2026-08-31: procedura selezionabile, va aperta con Open
    sp.Open;
    while not sp.EOF do
    begin
      daVerificare := daVerificare + [sp.Id_Messaggio.value];
      sp.Next;
    end;
  finally
    sp.Close;
    FreeAndNil(sp);
  end;

  for IdMessaggio in daVerificare do
  begin
    AggiornaStatoSpedizione(IdMessaggio);
    Inc(result);
  end;
end;

procedure TDocumentazioneBridgeMessaggi.AggiornaStatoPerCatena(IdObjectFile: Int64);
var
  sp: TSP_OBJ_FILES_MAIL_E_MESSAGGI_GET_BY_OBJ_FILE;
  idPecSpedizione: Int64;
begin
  sp := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_GET_BY_OBJ_FILE>();
  try
    sp.Id_Object_File := IdObjectFile;
    sp.ExecuteWithoutCommit;
    idPecSpedizione := sp.Id_Messaggio;
  finally
    FreeAndNil(sp);
  end;

  if idPecSpedizione <> 0 then
    AggiornaStatoSpedizione(idPecSpedizione);
end;

function TDocumentazioneBridgeMessaggi.StatoMessaggioPerCatena(IdObjectFile: Int64): string;
var
  sp: TSP_OBJ_FILES_MAIL_E_MESSAGGI_GET_BY_OBJ_FILE;
begin
  sp := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_GET_BY_OBJ_FILE>();
  try
    sp.Id_Object_File := IdObjectFile;
    sp.ExecuteWithoutCommit;
    result := sp.Stato;
  finally
    FreeAndNil(sp);
  end;
end;

function TDocumentazioneBridgeMessaggi.EstremiMessaggioPerCatena(IdObjectFile: Int64): string;
var
  sp: TSP_OBJ_FILES_MAIL_E_MESSAGGI_GET_BY_OBJ_FILE;
begin
  result := '';

  sp := GetSP<TSP_OBJ_FILES_MAIL_E_MESSAGGI_GET_BY_OBJ_FILE>();
  try
    sp.Id_Object_File := IdObjectFile;
    sp.ExecuteWithoutCommit;
    if sp.Id_Messaggio.value <> 0 then
      result := Format('PEC %s - %s', [sp.Message_Id.value, sp.Stato_Esterno.value]);
  finally
    FreeAndNil(sp);
  end;
end;

end.
