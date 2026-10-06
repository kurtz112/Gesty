unit Documentazione.Bridge.Firma;

// Ponte applicativo della firma elettronica multi-fornitore (Gesty).
// Qui e SOLO qui vivono database, stored procedure e transazioni: i
// provider (Documentazione.Firma.ESignAnyWhere, ...) ricevono configurazione e
// callback e non toccano mai il DB.
//
// Flusso: FirmaVersione (registrazione 'I' o 'A' + firmatari) ->
// InviaRegistrazione (provider.Firma -> 'D', PRIMA della chiamata la
// registrazione esiste gia': idempotenza) -> AggiornaStatoRegistrazione
// (polling: 'F' con versioni FIR/RIC create dal provider via callback,
// 'S' scaduta, 'R' rifiutata dal firmatario).
//
// NOTA: la registrazione degli errori di chiamata NON cambia lo stato
// (REGISTRAZIONE_ERRORE: messaggio + tentativi, ritentabile).
//
// I wrapper TSP_* vengono da Gesty_StoredProcs (generata dal tool):
// rigenerarla dopo aver eseguito gli script 02/03 sul database, cosi' da
// includere le famiglie OBJ_FILES_VERSIONE_* e OBJ_FILES_FIRMA_*.

interface

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  Base_DataModule,
  zDocumentale.Firma.Types,
  zDocumentale.Firma.Intf,
  zDocumentale.Firma.ProviderBase,
  zDocumentale.Firma.Factory,
  zOffice.Reports.Azioni,
  Gesty_StoredProcs,
  dbMaster;

type
  TDocumentazioneBridgeFirma = class(TBaseDataModule)
  private
    FIdTenant: Int64;
    FConfigurazione: TzFirmaConfigurazione;
    FConfigurazioneCaricata: Boolean;
    // Mantis #210 - 2026-10-05: quando la configurazione e' stata letta
    // (0 = non valida). Serve solo a FornitoreAttivo, che il controller delle
    // azioni chiede a ogni idle: le operazioni vere (CreaProvider, invio)
    // rileggono sempre.
    FConfigurazioneLettaIl: TDateTime;

    procedure CaricaConfigurazione;
    function ConfigurazioneRecente: Boolean;
    function CreaProvider(IdFirmaRegistrazione: Int64): IzFirmaProvider;
    procedure RegistraErrore(IdFirmaRegistrazione: Int64; E: Exception);
  public
    destructor Destroy; override;

    // il fornitore attivo del tenant ('' = firma non configurata:
    // il bottone Firma non compare)
    function FornitoreAttivo: string;

    // prova di connettivita' col fornitore attivo (pulsante Test della
    // schermata di configurazione); solleva EzFirmaErrore se non configurato,
    // o l'eccezione del provider in caso di errore di comunicazione
    procedure TestConnessione;

    // crea la registrazione (con eventuali firmatari) e, se il flusso non
    // prevede l'approvazione interna, invia subito la busta.
    // Ritorna ID_FIRMA_REGISTRAZIONE.
    function FirmaVersione(const Oid: Int64; const IdObjectFile: Int64; const TipoDocumento: string; const Firmatari: TArray<TzFirmaFirmatario>; const ConApprovazioneInterna: Boolean): Int64;

    // approvazione interna
    procedure ApprovaRegistrazione(IdFirmaRegistrazione: Int64; const UserId: string);
    procedure RespingiRegistrazione(IdFirmaRegistrazione: Int64; const UserId: string; const Motivo: string);

    // invia la busta al fornitore (stato 'A' -> 'D'); in caso di errore la
    // registrazione resta ritentabile. La variante con i firmatari serve ai
    // flussi che portano placeholder e identificativi di firma remota
    // (non persistiti): es. i contratti.
    procedure InviaRegistrazione(IdFirmaRegistrazione: Int64);
    procedure InviaRegistrazioneConFirmatari(IdFirmaRegistrazione: Int64; const Firmatari: TArray<TzFirmaFirmatario>);

    // polling dello stato: aggiorna la registrazione e, a busta completata,
    // fa creare al provider le versioni FIR/RIC nella catena
    procedure AggiornaStatoRegistrazione(IdFirmaRegistrazione: Int64);

    // stato dell'ultima registrazione sulla CATENA del file (gate 4 della
    // UI: da passare a StatoAzioneDaRegistrazione); '' = mai richiesta
    function StatoFirmaPerCatena(IdObjectFile: Int64): string;

    // ------------------------------------------------------------------
    // Servizi per il controller delle azioni documentali
    // ------------------------------------------------------------------

    // azioni ammesse dal profilo documentale (gate 1 del controller)
    function AzioniDelProfilo(const Profilo: string): TzJsonAzioniConfig;

    // azioni ammesse dal profilo del documento persistito (gate 1 per viewer
    // e registri): risolve la radice della catena
    function AzioniDelDocumento(const IdObjectFile: Int64): TzJsonAzioniConfig;

    // i TIPO_VERSIONE presenti (non annullati/eliminati) nella catena
    function TipiVersioneInCatena(IdObjectFile: Int64): TArray<string>;

    // polling della registrazione trovata sulla catena (se in firma)
    procedure AggiornaStatoPerCatena(IdObjectFile: Int64);

    // estremi leggibili dell'ultima registrazione sulla catena
    function EstremiFirmaPerCatena(IdObjectFile: Int64): string;

    // firmatari standard di un oggetto qualunque, dal dispatcher per
    // OBJ_CLASS (OBJ_FILES_FIRMA_FIRMATARI_GET, script 05): Direttore +
    // Legale Rappresentante dell'ente piu' gli eventuali firmatari extra
    // dell'oggetto; vuoto = firma non disponibile per quell'oggetto.
    // I moduli applicativi lo usano in OnRichiediFirmatari senza scrivere
    // query proprie (dmContratti vi aggiunge il docente in OTP via SP).
    function FirmatariStandard(const Oid: Int64): TArray<TzFirmaFirmatario>;

    // persistenza del documento generato da un report: versione ORI via
    // OBJ_FILES_ADD (l'OID e' l'entita' della pratica), copia del PDF nella
    // posizione calcolata dal DB, riga OBJ_FILES_GENERAZIONI
    function PersistiDocumentoReport(const Oid: Int64; const TipoAllegato, TempFileName, TemplateNomeFile: string; const TipologiaDocumentale: string = ''; const ProfiloDocumentale: string = ''): Int64;

    property IdTenant: Int64 read FIdTenant write FIdTenant;
  end;

var
  DocumentazioneBridgeFirma: TDocumentazioneBridgeFirma;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

destructor TDocumentazioneBridgeFirma.Destroy;
begin
  if FConfigurazioneCaricata then
    FConfigurazione.Finalizza;
  inherited;
end;

procedure TDocumentazioneBridgeFirma.CaricaConfigurazione;
var
  spConfigurazione: TSP_OBJ_FILES_FIRMA_CONFIGURAZIONE_GET;
  spParametri: TSP_OBJ_FILES_FIRMA_CONFIG_PARAMETRI_GET;
begin
  if FConfigurazioneCaricata then
    FConfigurazione.Finalizza;

  FConfigurazione.Inizializza;
  FConfigurazioneCaricata := True;
  // finche' la lettura non e' finita la configurazione non e' affidabile
  FConfigurazioneLettaIl := 0;

  spConfigurazione := GetSP<TSP_OBJ_FILES_FIRMA_CONFIGURAZIONE_GET>();
  try
    spConfigurazione.Id_Tenant := FIdTenant;
    spConfigurazione.ExecuteWithoutCommit;

    FConfigurazione.Fornitore := spConfigurazione.Fornitore;
    FConfigurazione.IdTenant := FIdTenant;
    FConfigurazione.UrlBase := spConfigurazione.Url_Base;
    FConfigurazione.Utente := spConfigurazione.Utente;
    FConfigurazione.Password := spConfigurazione.Password_;

    if not spConfigurazione.Attivo.value then
      FConfigurazione.Fornitore := '';
  finally
    FreeAndNil(spConfigurazione);
  end;

  if FConfigurazione.Fornitore.IsEmpty then
  begin
    FConfigurazioneLettaIl := Now;
    exit;
  end;

  spParametri := GetSP<TSP_OBJ_FILES_FIRMA_CONFIG_PARAMETRI_GET>();
  try
    spParametri.Id_Tenant := FIdTenant;
    spParametri.Fornitore := FConfigurazione.Fornitore;
    // Mantis #61 - 2026-08-31: procedura selezionabile, va aperta con Open;
    // con Execute il cursore non nasce e il ciclo non veniva mai eseguito,
    // lasciando la configurazione senza AUTH_TOKEN
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

  FConfigurazioneLettaIl := Now;
end;

function TDocumentazioneBridgeFirma.ConfigurazioneRecente: Boolean;
const
  SecondiValidita = 60;
begin
  result := FConfigurazioneCaricata and (FConfigurazioneLettaIl <> 0) and (FConfigurazione.IdTenant = FIdTenant) and (Now - FConfigurazioneLettaIl < SecondiValidita / SecsPerDay);
end;

function TDocumentazioneBridgeFirma.FornitoreAttivo: string;
begin
  // Mantis #210 - 2026-10-05: il controller delle azioni lo chiede a ogni
  // cambio di documento; riletta ogni volta, la configurazione (identica)
  // costava 3 procedure per chiamata. Una lettura al minuto basta per sapere
  // se il bottone Firma compare
  if not ConfigurazioneRecente then
    CaricaConfigurazione;
  result := FConfigurazione.Fornitore;
end;

procedure TDocumentazioneBridgeFirma.TestConnessione;
var
  provider: IzFirmaProvider;
begin
  // CreaProvider carica la configurazione e solleva se il fornitore manca;
  // 0 = operazione fuori pratica (nessun log legato a una registrazione)
  provider := CreaProvider(0);
  provider.TestConnessione;
end;

function TDocumentazioneBridgeFirma.CreaProvider(IdFirmaRegistrazione: Int64): IzFirmaProvider;
var
  ProviderBase: TzFirmaProviderBase;
begin
  CaricaConfigurazione;

  if FConfigurazione.Fornitore.IsEmpty then
    raise EzFirmaErrore.Create('Nessun fornitore di firma configurato per l''ente');

  result := TzFirmaFactory.Crea(FConfigurazione.Fornitore);
  result.Configura(FConfigurazione);

  // callback: log tecnico e creazione versioni — l'unico punto in cui il
  // provider "parla" col database, sempre per interposta persona
  ProviderBase := result as TzFirmaProviderBase;

  ProviderBase.OnLogRequest := function(const Operazione, Endpoint, Richiesta: string): Int64
    var
      sp: TSP_OBJ_FILES_FIRMA_LOG_REQUEST_ADD;
    begin
      sp := GetSP<TSP_OBJ_FILES_FIRMA_LOG_REQUEST_ADD>();
      try
        // 0 = operazione fuori pratica (es. test di connessione):
        // la colonna resta NULL
        if IdFirmaRegistrazione <> 0 then
          sp.Id_Firma_Registrazione := IdFirmaRegistrazione;
        sp.Id_Tenant := FIdTenant;
        sp.Fornitore := FConfigurazione.Fornitore;
        sp.Operazione := Operazione;
        sp.Endpoint := Endpoint;
        sp.Richiesta.text := Richiesta;
        sp.ExecuteAndCommit;
        result := sp.Id_Firma_Log_Request;
      finally
        FreeAndNil(sp);
      end;
    end;

  ProviderBase.OnLogResponse := procedure(IdLogRequest: Int64; HttpStatus: Integer; const Risposta, Errore: string)
    var
      sp: TSP_OBJ_FILES_FIRMA_LOG_RESPONSE_ADD;
    begin
      sp := GetSP<TSP_OBJ_FILES_FIRMA_LOG_RESPONSE_ADD>();
      try
        sp.Id_Firma_Log_Request := IdLogRequest;
        sp.Http_Status := HttpStatus;
        sp.Risposta.text := Risposta;
        sp.Errore.text := Errore;
        sp.ExecuteAndCommit;
      finally
        FreeAndNil(sp);
      end;
    end;

  ProviderBase.OnCreaVersione := function(IdObjectFilePadre: Int64; const TipoVersione, NomeFileOriginale, FileSuffix: string): TzFirmaVersioneCreata
    var
      sp: TSP_OBJ_FILES_VERSIONE_ADD;
    begin
      result.Clear;
      sp := GetSP<TSP_OBJ_FILES_VERSIONE_ADD>();
      try
        sp.Id_Object_File_Padre := IdObjectFilePadre;
        sp.Tipo_Versione := TipoVersione;
        sp.Nome_File_Originale := NomeFileOriginale;
        sp.File_Suffix := FileSuffix;
        sp.File_Size := 0;
        sp.ExecuteAndCommit;
        result.IdObjectFile := sp.Id_Object_File;
        result.FullFileName := sp.Full_File_Name;
        // Mantis #87 - 2026-09-04: la cartella della nuova versione FIR/RIC non
        // esiste ancora su disco al primo utilizzo dell'ID_OBJECT_FILE; senza
        // crearla qui, TFileStream.Create in eSignAnyWhereEngine.DownloadFiles
        // fallisce con "Impossibile trovare il percorso specificato" (stesso
        // pattern gia' presente in CreaVersioneRapporto e CreaVersioneRicevuta).
        ForceDirectories(ExtractFilePath(result.FullFileName));
      finally
        FreeAndNil(sp);
      end;
    end;
end;

function TDocumentazioneBridgeFirma.FirmaVersione(const Oid: Int64; const IdObjectFile: Int64; const TipoDocumento: string; const Firmatari: TArray<TzFirmaFirmatario>; const ConApprovazioneInterna: Boolean): Int64;
var
  spRegistrazione: TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_ADD;
  spFirmatario: TSP_OBJ_FILES_FIRMA_FIRMATARIO_ADD;
  firmatario: TzFirmaFirmatario;
begin
  CaricaConfigurazione;

  if FConfigurazione.Fornitore.IsEmpty then
    raise EzFirmaErrore.Create('Nessun fornitore di firma configurato per l''ente');

  spRegistrazione := GetSP<TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_ADD>();
  try
    spRegistrazione.Id_Tenant := FIdTenant;
    spRegistrazione.Fornitore := FConfigurazione.Fornitore;
    spRegistrazione.Oid := Oid;
    spRegistrazione.Id_Object_File := IdObjectFile;
    if ConApprovazioneInterna then
      spRegistrazione.Stato := FIRMA_STATO_INSERITA
    else
      spRegistrazione.Stato := FIRMA_STATO_APPROVATA;
    spRegistrazione.Tipo_Documento := TipoDocumento;
    spRegistrazione.ExecuteAndCommit;
    result := spRegistrazione.Id_Firma_Registrazione;
  finally
    FreeAndNil(spRegistrazione);
  end;

  for firmatario in Firmatari do
  begin
    spFirmatario := GetSP<TSP_OBJ_FILES_FIRMA_FIRMATARIO_ADD>();
    try
      spFirmatario.Id_Firma_Registrazione := result;
      spFirmatario.Ruolo := firmatario.Ruolo;
      spFirmatario.Cognome := firmatario.Cognome;
      spFirmatario.Nome := firmatario.Nome;
      spFirmatario.Email := firmatario.Email;
      spFirmatario.Telefono := firmatario.Telefono;
      spFirmatario.ExecuteAndCommit;
    finally
      FreeAndNil(spFirmatario);
    end;
  end;

  // Placeholder e identificativi di firma remota non hanno colonne
  // dedicate: viaggiano solo verso il provider al momento dell'invio
  // (InviaRegistrazione riceve i firmatari completi dal chiamante quando
  // il flusso e' immediato).
  if not ConApprovazioneInterna then
    InviaRegistrazioneConFirmatari(result, Firmatari);
end;

procedure TDocumentazioneBridgeFirma.ApprovaRegistrazione(IdFirmaRegistrazione: Int64; const UserId: string);
var
  sp: TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_APPROVA;
begin
  sp := GetSP<TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_APPROVA>();
  try
    sp.Id_Firma_Registrazione := IdFirmaRegistrazione;
    sp.User_Id := UserId.ToInt64;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TDocumentazioneBridgeFirma.RespingiRegistrazione(IdFirmaRegistrazione: Int64; const UserId: string; const Motivo: string);
var
  sp: TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_RESPINGI;
begin
  sp := GetSP<TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_RESPINGI>();
  try
    sp.Id_Firma_Registrazione := IdFirmaRegistrazione;
    sp.User_Id := UserId.ToInt64;
    sp.Motivo.text := Motivo;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TDocumentazioneBridgeFirma.RegistraErrore(IdFirmaRegistrazione: Int64; E: Exception);
var
  sp: TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_ERRORE;
begin
  sp := GetSP<TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_ERRORE>();
  try
    sp.Id_Firma_Registrazione := IdFirmaRegistrazione;
    sp.Messaggio.text := E.Message;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TDocumentazioneBridgeFirma.InviaRegistrazione(IdFirmaRegistrazione: Int64);
var
  Firmatari: TArray<TzFirmaFirmatario>;
  spFirmatari: TSP_OBJ_FILES_FIRMA_FIRMATARI;
  firmatario: TzFirmaFirmatario;
begin
  // ricostruisce i firmatari dalla registrazione (placeholder e
  // identificativi remoti vanno reintegrati dal chiamante se necessari:
  // per il flusso contratti provvede dmContratti)
  Firmatari := nil;
  spFirmatari := GetSP<TSP_OBJ_FILES_FIRMA_FIRMATARI>();
  try
    spFirmatari.Id_Firma_Registrazione := IdFirmaRegistrazione;
    // Mantis #61 - 2026-08-31: procedura selezionabile, va aperta con Open
    spFirmatari.Open;
    while not spFirmatari.EOF do
    begin
      firmatario.Clear;
      firmatario.Ruolo := spFirmatari.Ruolo;
      firmatario.Cognome := spFirmatari.Cognome;
      firmatario.Nome := spFirmatari.Nome;
      firmatario.Email := spFirmatari.Email;
      firmatario.Telefono := spFirmatari.Telefono;
      Firmatari := Firmatari + [firmatario];
      spFirmatari.Next;
    end;
  finally
    spFirmatari.Close;
    FreeAndNil(spFirmatari);
  end;

  InviaRegistrazioneConFirmatari(IdFirmaRegistrazione, Firmatari);
end;

procedure TDocumentazioneBridgeFirma.InviaRegistrazioneConFirmatari(IdFirmaRegistrazione: Int64; const Firmatari: TArray<TzFirmaFirmatario>);
var
  spGet: TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_GET;
  spFullFileName: TSP_GET_FULL_FILE_NAME;
  spInviata: TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_INVIATA;
  provider: IzFirmaProvider;
  documento: TzFirmaDocumento;
  esito: TzFirmaEsito;
begin
  documento.Clear;

  spGet := GetSP<TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_GET>();
  try
    spGet.Id_Firma_Registrazione := IdFirmaRegistrazione;
    spGet.ExecuteWithoutCommit;

    documento.IdObjectFile := spGet.Id_Object_File;
    documento.Oid := spGet.Oid;
  finally
    FreeAndNil(spGet);
  end;

  spFullFileName := GetSP<TSP_GET_FULL_FILE_NAME>();
  try
    spFullFileName.Id_Object_File := documento.IdObjectFile;
    spFullFileName.ExecuteWithoutCommit;
    documento.FullFileName := spFullFileName.Full_File_Name;
  finally
    FreeAndNil(spFullFileName);
  end;

  documento.Firmatari := Firmatari;

  provider := CreaProvider(IdFirmaRegistrazione);

  // la registrazione esiste GIA' (idempotenza): la chiamata al fornitore
  // sta fuori da ogni transazione locale
  try
    esito := provider.Firma(documento);
  except
    on E: Exception do
    begin
      RegistraErrore(IdFirmaRegistrazione, E);
      raise;
    end;
  end;

  spInviata := GetSP<TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_INVIATA>();
  try
    spInviata.Id_Firma_Registrazione := IdFirmaRegistrazione;
    spInviata.Id_Documento_Esterno := esito.IdDocumentoEsterno;
    spInviata.Stato_Esterno := esito.StatoEsterno;
    spInviata.ExecuteAndCommit;
  finally
    FreeAndNil(spInviata);
  end;
end;

procedure TDocumentazioneBridgeFirma.AggiornaStatoRegistrazione(IdFirmaRegistrazione: Int64);
var
  spGet: TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_GET;
  spFullFileName: TSP_GET_FULL_FILE_NAME;
  spFirmata: TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_FIRMATA;
  spScaduta: TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_SCADUTA;
  spRespintaFornitore: TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_RESPINTA_FORNITORE;
  spStatoEsterno: TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_STATO_ESTERNO;
  provider: IzFirmaProvider;
  documento: TzFirmaDocumento;
  IdDocumentoEsterno: string;
  statoCorrente: string;
  esito: TzFirmaEsito;
begin
  documento.Clear;

  spGet := GetSP<TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_GET>();
  try
    spGet.Id_Firma_Registrazione := IdFirmaRegistrazione;
    spGet.ExecuteWithoutCommit;

    statoCorrente := spGet.Stato;
    IdDocumentoEsterno := spGet.Id_Documento_Esterno;
    documento.IdObjectFile := spGet.Id_Object_File;
    documento.Oid := spGet.Oid;
  finally
    FreeAndNil(spGet);
  end;

  // solo le buste in firma hanno qualcosa da chiedere al fornitore
  if statoCorrente <> FIRMA_STATO_IN_FIRMA then
    exit;

  spFullFileName := GetSP<TSP_GET_FULL_FILE_NAME>();
  try
    spFullFileName.Id_Object_File := documento.IdObjectFile;
    spFullFileName.ExecuteWithoutCommit;
    documento.FullFileName := spFullFileName.Full_File_Name;
  finally
    FreeAndNil(spFullFileName);
  end;

  provider := CreaProvider(IdFirmaRegistrazione);

  try
    esito := provider.AggiornaEstremi(documento, IdDocumentoEsterno);
  except
    on E: Exception do
    begin
      RegistraErrore(IdFirmaRegistrazione, E);
      raise;
    end;
  end;

  if esito.Stato = FIRMA_STATO_FIRMATA then
  begin
    spFirmata := GetSP<TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_FIRMATA>();
    try
      spFirmata.Id_Firma_Registrazione := IdFirmaRegistrazione;
      spFirmata.Id_Object_File_Firmato := esito.IdObjectFileFirmato;
      spFirmata.Id_Object_File_Audit := esito.IdObjectFileAudit;
      spFirmata.Stato_Esterno := esito.StatoEsterno;
      spFirmata.ExecuteAndCommit;
    finally
      FreeAndNil(spFirmata);
    end;
  end
  else
    if esito.Stato = FIRMA_STATO_SCADUTA then
    begin
      spScaduta := GetSP<TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_SCADUTA>();
      try
        spScaduta.Id_Firma_Registrazione := IdFirmaRegistrazione;
        spScaduta.Stato_Esterno := esito.StatoEsterno;
        spScaduta.ExecuteAndCommit;
      finally
        FreeAndNil(spScaduta);
      end;
    end
    else
      if esito.Stato = FIRMA_STATO_RESPINTA then
      begin
        // Mantis #66 - 2026-09-02: respinta rilevata dal polling = rifiuto del
        // firmatario presso il fornitore, nessun utente interno. Non passa da
        // RespingiRegistrazione (che pretende USER_ID intero): SP dedicata,
        // USER_ID_APPROVAZIONE resta NULL. Gemella del ramo SCADUTA.
        spRespintaFornitore := GetSP<TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_RESPINTA_FORNITORE>();
        try
          spRespintaFornitore.Id_Firma_Registrazione := IdFirmaRegistrazione;
          spRespintaFornitore.Stato_Esterno := esito.StatoEsterno;
          spRespintaFornitore.ExecuteAndCommit;
        finally
          FreeAndNil(spRespintaFornitore);
        end;
      end
      else
      begin
        // ancora in firma: si aggiorna il solo stato grezzo
        spStatoEsterno := GetSP<TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_STATO_ESTERNO>();
        try
          spStatoEsterno.Id_Firma_Registrazione := IdFirmaRegistrazione;
          spStatoEsterno.Stato_Esterno := esito.StatoEsterno;
          spStatoEsterno.ExecuteAndCommit;
        finally
          FreeAndNil(spStatoEsterno);
        end;
      end;
end;

function TDocumentazioneBridgeFirma.StatoFirmaPerCatena(IdObjectFile: Int64): string;
var
  sp: TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_GET_BY_OBJ_FILE;
begin
  sp := GetSP<TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_GET_BY_OBJ_FILE>();
  try
    sp.Id_Object_File := IdObjectFile;
    sp.ExecuteWithoutCommit;
    result := sp.Stato;
  finally
    FreeAndNil(sp);
  end;
end;

// ------------------------------------------------------------------
// Servizi per il controller delle azioni documentali
// ------------------------------------------------------------------

function TDocumentazioneBridgeFirma.TipiVersioneInCatena(IdObjectFile: Int64): TArray<string>;
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

procedure TDocumentazioneBridgeFirma.AggiornaStatoPerCatena(IdObjectFile: Int64);
var
  sp: TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_GET_BY_OBJ_FILE;
  IdFirmaRegistrazione: Int64;
begin
  sp := GetSP<TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_GET_BY_OBJ_FILE>();
  try
    sp.Id_Object_File := IdObjectFile;
    sp.ExecuteWithoutCommit;
    IdFirmaRegistrazione := sp.Id_Firma_Registrazione;
  finally
    FreeAndNil(sp);
  end;

  if IdFirmaRegistrazione <> 0 then
    AggiornaStatoRegistrazione(IdFirmaRegistrazione);
end;

function TDocumentazioneBridgeFirma.EstremiFirmaPerCatena(IdObjectFile: Int64): string;
var
  sp: TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_GET_BY_OBJ_FILE;
begin
  result := '';

  sp := GetSP<TSP_OBJ_FILES_FIRMA_REGISTRAZIONE_GET_BY_OBJ_FILE>();
  try
    sp.Id_Object_File := IdObjectFile;
    sp.ExecuteWithoutCommit;
    if sp.Id_Firma_Registrazione <> 0 then
      result := Format('Busta %s - %s', [sp.Id_Documento_Esterno.value, sp.Stato_Esterno.value]);
  finally
    FreeAndNil(sp);
  end;
end;

function TDocumentazioneBridgeFirma.FirmatariStandard(const Oid: Int64): TArray<TzFirmaFirmatario>;
var
  sp: TSP_OBJ_FILES_FIRMA_FIRMATARI_GET;
  firmatario: TzFirmaFirmatario;
begin
  result := nil;

  sp := GetSP<TSP_OBJ_FILES_FIRMA_FIRMATARI_GET>();
  try
    sp.Oid := Oid;
    // Mantis #61 - 2026-08-31: procedura selezionabile, va aperta con Open
    sp.Open;
    while not sp.EOF do
    begin
      firmatario.Clear;
      firmatario.Ruolo := sp.Ruolo;
      firmatario.Placeholder := sp.Placeholder;
      firmatario.Cognome := sp.Cognome;
      firmatario.Nome := sp.Nome;
      firmatario.Email := sp.Email;
      firmatario.Telefono := sp.Telefono;
      firmatario.IdentificativoFirmaRemota := sp.Identificativo_Esterno;
      result := result + [firmatario];
      sp.Next;
    end;
  finally
    sp.Close;
    FreeAndNil(sp);
  end;
end;

function TDocumentazioneBridgeFirma.PersistiDocumentoReport(const Oid: Int64; const TipoAllegato, TempFileName, TemplateNomeFile: string; const TipologiaDocumentale: string = ''; const ProfiloDocumentale: string = ''): Int64;
var
  spObjFile: TSP_OBJ_FILES_ADD;
  spGenerazione: TSP_OBJ_FILES_GENERAZIONE_ADD;
  percorsoDefinitivo: string;
begin
  if TempFileName.IsEmpty or not TFile.Exists(TempFileName) then
    raise EzFirmaErrore.CreateFmt('Documento da persistere non trovato: "%s"', [TempFileName]);

  // i parametri non impostati (TESTO, SHA256, STATO, OID_REF_*) restano
  // ai default della stored procedure
  spObjFile := GetSP<TSP_OBJ_FILES_ADD>();
  try
    spObjFile.Oid := Oid;
    spObjFile.Tipo_Allegato := TipoAllegato;
    spObjFile.File_Type := 'P'; // pdf
    spObjFile.Nome_File_Originale := TemplateNomeFile + '.pdf';
    spObjFile.File_Size := TFile.GetSize(TempFileName);

    if not TipologiaDocumentale.IsEmpty then
      spObjFile.Tipologia_Documentale := TipologiaDocumentale;
    if not ProfiloDocumentale.IsEmpty then
      spObjFile.Profilo_Documentale := ProfiloDocumentale;

    spObjFile.ExecuteAndCommit;

    result := spObjFile.Id_Object_File;
    percorsoDefinitivo := spObjFile.Full_File_Name;
  finally
    FreeAndNil(spObjFile);
  end;

  ForceDirectories(ExtractFilePath(percorsoDefinitivo));
  TFile.Copy(TempFileName, percorsoDefinitivo, True);

  spGenerazione := GetSP<TSP_OBJ_FILES_GENERAZIONE_ADD>();
  try
    spGenerazione.Id_Object_File := result;
    spGenerazione.Template_Nome_File := TemplateNomeFile;
    spGenerazione.ExecuteAndCommit;
  finally
    FreeAndNil(spGenerazione);
  end;
end;

function TDocumentazioneBridgeFirma.AzioniDelProfilo(const Profilo: string): TzJsonAzioniConfig;
var
  sp: TSP_obj_Files_Profilo_Azioni_Get;

  procedure Applica(var Azione: TzJsonAzioneConfig);
  var
    precondizioni: string;
    codici: TArray<string>;
    i: Integer;
  begin
    Azione.IsPresent := True;
    Azione.Enabled := True;

    precondizioni := sp.Richiede.value.Trim;
    if not precondizioni.IsEmpty then
    begin
      codici := precondizioni.Split([',']);
      for i := Low(codici) to High(codici) do
        codici[i] := codici[i].Trim.ToUpper;
      Azione.Richiede := codici;
    end;

    Azione.VersioneOperativa := sp.Agisce_Su.value.Trim.ToUpper;
    Azione.Engine := sp.Fornitore.value.Trim.ToUpper;
  end;

var
  Azione: string;
begin
  result.Clear;

  if Profilo.Trim.IsEmpty then
    exit;

  sp := GetSP<TSP_obj_Files_Profilo_Azioni_Get>();
  try
    sp.Profilo := Profilo;
    // Mantis #61 - 2026-08-31: procedura selezionabile, va aperta con Open
    sp.Open;
    while not sp.EOF do
    begin
      result.IsPresent := True;
      Azione := sp.Azione.value.Trim.ToUpper;

      if Azione = 'FIR' then
        Applica(result.Firma)
      else
        if Azione = 'PRO' then
          Applica(result.Protocollo)
        else
          if Azione = 'CON' then
            Applica(result.Conservazione)
          else
            if Azione = 'PEC' then
              Applica(result.InviaPec)
            else
              if Azione = 'MAIL' then
                Applica(result.InviaMail);

      sp.Next;
    end;
  finally
    sp.Close;
    FreeAndNil(sp);
  end;
end;

function TDocumentazioneBridgeFirma.AzioniDelDocumento(const IdObjectFile: Int64): TzJsonAzioniConfig;
var
  sp: TSP_obj_Files_Documento_Azioni_Get;

  procedure Applica(var Azione: TzJsonAzioneConfig);
  var
    precondizioni: string;
    codici: TArray<string>;
    i: Integer;
  begin
    Azione.IsPresent := True;
    Azione.Enabled := True;

    precondizioni := sp.Richiede.value.Trim;
    if not precondizioni.IsEmpty then
    begin
      codici := precondizioni.Split([',']);
      for i := Low(codici) to High(codici) do
        codici[i] := codici[i].Trim.ToUpper;
      Azione.Richiede := codici;
    end;

    Azione.VersioneOperativa := sp.Agisce_Su.value.Trim.ToUpper;
    Azione.Engine := sp.Fornitore.value.Trim.ToUpper;
  end;

var
  Azione: string;
begin
  result.Clear;

  if IdObjectFile = 0 then
    exit;

  sp := GetSP<TSP_obj_Files_Documento_Azioni_Get>();
  try
    sp.Id_Object_File := IdObjectFile;
    // Mantis #61 - 2026-08-31: procedura selezionabile, va aperta con Open
    sp.Open;
    while not sp.EOF do
    begin
      result.IsPresent := True;
      Azione := sp.Azione.value.Trim.ToUpper;

      if Azione = 'FIR' then
        Applica(result.Firma)
      else
        if Azione = 'PRO' then
          Applica(result.Protocollo)
        else
          if Azione = 'CON' then
            Applica(result.Conservazione)
          else
            if Azione = 'PEC' then
              Applica(result.InviaPec)
            else
              if Azione = 'MAIL' then
                Applica(result.InviaMail);

      sp.Next;
    end;
  finally
    sp.Close;
    FreeAndNil(sp);
  end;
end;

end.
