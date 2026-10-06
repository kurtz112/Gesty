unit Documentazione.Bridge.Conservazione;

// Ponte applicativo della conservazione sostitutiva multi-fornitore (Gesty).
// Gemello di Documentazione.Bridge.Firma / Messaggi / Protocollo: qui e SOLO qui
// vivono database, stored procedure e transazioni; il provider
// (zDocumentale.Conservazione.<X>, oggi solo NESSUNO) riceve configurazione,
// corrispondenze e callback di log e non tocca mai il DB.
//
// La conservazione lavora a PACCHETTI (SIP) ed e' ASINCRONA:
//   ConservaDocumento  -> crea un pacchetto 'INS' con la versione da conservare
//                         (hash SHA-256 congelato) = accodamento.
//   VersaPacchetto     -> 'GEN' (SIP) + provider.Versa -> 'INV' (attesa esito).
//   AggiornaStatoPerCatena / VerificaPendenti -> polling: provider.VerificaEsito
//                         -> esiti per documento + 'ACC'/'RIF'/'CON'; il
//                         Rapporto di Versamento diventa versione 'RIC'.
//
// NOTA: il fornitore 'NESSUNO' e' un no-op (Funzionalita = []): la conservazione
// a norma la eroga solo un conservatore accreditato. Finche' l'ente non ne
// configura uno, FornitoreAttivo torna '' e l'azione "Conserva" non compare.
// Batching: questa versione crea UN pacchetto per documento; un driver
// schedulato / un provider concreto puo' raggruppare per classe documentale.
//
// Wrapper TSP_* da Gesty_StoredProcs (Nullable<T> -> .Value, MEMO -> .Text).
// Rigenerare dopo lo script 11_conservazione_gesty.sql.

interface

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  System.Hash,
  Base_DataModule,
  zDocumentale.Conservazione.Types,
  zDocumentale.Conservazione.Intf,
  zDocumentale.Conservazione.ProviderBase,
  zDocumentale.Conservazione.Factory,
  Gesty_StoredProcs;

type
  TDocumentazioneBridgeConservazione = class(TBaseDataModule)
  private
    FIdTenant: Int64;
    FConfigurazione: TzConservazioneConfigurazione;
    FConfigurazioneCaricata: Boolean;
    // Mantis #210 - 2026-10-05: quando la configurazione e' stata letta
    // (0 = non valida). Serve solo a FornitoreAttivo, che il controller delle
    // azioni chiede a ogni idle: le operazioni vere (CreaProvider, versamento)
    // rileggono sempre.
    FConfigurazioneLettaIl: TDateTime;

    procedure CaricaConfigurazione;
    function ConfigurazioneRecente: Boolean;
    function CreaProvider(IdPacchetto: Int64): IzConservazioneProvider;
    procedure RegistraErrore(IdPacchetto: Int64; E: Exception);

    function FullFileName(IdObjectFile: Int64): string;
    function HashFile(const NomeFile: string): string;
    function CaricaPacchetto(IdPacchetto: Int64): TzConservazionePacchetto;
    function CreaVersioneRapporto(IdObjectFilePadre: Int64;
      const FileRapporto: string): Int64;
    procedure AggiornaStatoPacchetto(IdPacchetto: Int64);
  public
    destructor Destroy; override;

    // il conservatore attivo del tenant ('' = conservazione non configurata/
    // non operativa: l'azione "Conserva" non compare)
    function FornitoreAttivo: string;

    // accoda la versione del documento in un nuovo pacchetto 'INS'
    // (hash congelato). Ritorna ID_CONSERVAZIONE_PACCHETTO.
    function ConservaDocumento(const Oid, IdObjectFile: Int64;
      const ClasseDocumentale: string): Int64;

    // genera il SIP e lo versa al conservatore (INS/RIF -> GEN -> INV).
    procedure VersaPacchetto(IdPacchetto: Int64);

    // ------------------------------------------------------------------
    // Servizi per il controller delle azioni documentali
    // ------------------------------------------------------------------

    // i TIPO_VERSIONE presenti (non annullati/eliminati) nella catena.
    function TipiVersioneInCatena(IdObjectFile: Int64): TArray<string>;

    // polling del pacchetto trovato sulla catena (se inviato, in attesa esito)
    procedure AggiornaStatoPerCatena(IdObjectFile: Int64);

    // porta avanti tutti i pacchetti del tenant ancora in attesa ('INV')
    procedure VerificaPendenti;

    // stato dell'ultimo pacchetto sulla CATENA del file (gate 4 della UI:
    // da passare a StatoAzioneDaRegistrazione); '' = mai conservato
    function StatoConservazionePerCatena(IdObjectFile: Int64): string;

    // estremi leggibili dell'ultimo pacchetto sulla catena
    function EstremiConservazionePerCatena(IdObjectFile: Int64): string;

    property IdTenant: Int64 read FIdTenant write FIdTenant;
  end;

var
  DocumentazioneBridgeConservazione: TDocumentazioneBridgeConservazione;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

// il provider dichiara l'esito documento con 'W' = in attesa (costante dei
// Types), ma il dominio DB usa 'P': qui si traduce.
function EsitoDocumentoDb(const Esito: string): string;
begin
  if SameText(Esito, CONSERVAZIONE_ESITO_ACCETTATO) then
    result := 'A'
  else
    if SameText(Esito, CONSERVAZIONE_ESITO_SCARTATO) then
      result := 'S'
    else
      result := 'P';
end;

destructor TDocumentazioneBridgeConservazione.Destroy;
begin
  if FConfigurazioneCaricata then
    FConfigurazione.Finalizza;
  inherited;
end;

procedure TDocumentazioneBridgeConservazione.CaricaConfigurazione;
var
  spConfigurazione: TSP_OBJ_FILES_CONSERVAZIONE_CONFIGURAZIONE_GET;
  spParametri: TSP_OBJ_FILES_CONSERVAZIONE_CONFIG_PARAMETRI_GET;
begin
  if FConfigurazioneCaricata then
    FConfigurazione.Finalizza;

  FConfigurazione.Inizializza;
  FConfigurazioneCaricata := True;
  // finche' la lettura non e' finita la configurazione non e' affidabile
  FConfigurazioneLettaIl := 0;

  spConfigurazione := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_CONFIGURAZIONE_GET>();
  try
    spConfigurazione.Id_Tenant := FIdTenant;
    spConfigurazione.ExecuteWithoutCommit;

    FConfigurazione.Fornitore := spConfigurazione.Fornitore.Value;
    FConfigurazione.IdTenant := FIdTenant;
    FConfigurazione.UrlBase := spConfigurazione.Url_Base.Value;
    FConfigurazione.Utente := spConfigurazione.Utente.Value;
    FConfigurazione.Password := spConfigurazione.Password_.Value;
    FConfigurazione.TipoVersioneDaConservare := spConfigurazione.Tipo_Versione_Da_Conservare.Value;
  finally
    FreeAndNil(spConfigurazione);
  end;

  if FConfigurazione.Fornitore.IsEmpty then
  begin
    FConfigurazioneLettaIl := Now;
    exit;
  end;

  spParametri := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_CONFIG_PARAMETRI_GET>();
  try
    spParametri.Id_Tenant := FIdTenant;
    spParametri.Fornitore := FConfigurazione.Fornitore;
    // Mantis #61 - 2026-08-31: procedura selezionabile, va aperta con Open
    spParametri.Open;

    while not spParametri.EOF do
    begin
      FConfigurazione.Parametri.AddOrSetValue(spParametri.Chiave.Value.ToUpper, spParametri.Valore.Value);
      spParametri.Next;
    end;
  finally
    spParametri.Close;
    FreeAndNil(spParametri);
  end;

  FConfigurazioneLettaIl := Now;
end;

function TDocumentazioneBridgeConservazione.ConfigurazioneRecente: Boolean;
const
  SecondiValidita = 60;
begin
  result := FConfigurazioneCaricata and (FConfigurazioneLettaIl <> 0) and (FConfigurazione.IdTenant = FIdTenant) and (Now - FConfigurazioneLettaIl < SecondiValidita / SecsPerDay);
end;

function TDocumentazioneBridgeConservazione.FornitoreAttivo: string;
begin
  // Mantis #210 - 2026-10-05: il controller delle azioni lo chiede a ogni
  // cambio di documento; riletta ogni volta, la configurazione (identica)
  // costava 2-3 procedure per chiamata. Una lettura al minuto basta per sapere
  // se il bottone Conserva compare
  if not ConfigurazioneRecente then
    CaricaConfigurazione;
  result := FConfigurazione.Fornitore;

  // NESSUNO e' un no-op: nessuna conservazione operativa -> azione nascosta
  if SameText(result, CONSERVAZIONE_FORNITORE_NESSUNO) then
    result := '';
end;

function TDocumentazioneBridgeConservazione.CreaProvider(IdPacchetto: Int64): IzConservazioneProvider;
var
  providerBase: TzConservazioneProviderBase;
begin
  CaricaConfigurazione;

  if FConfigurazione.Fornitore.IsEmpty then
    raise EzConservazioneErrore.Create('Nessun conservatore configurato per l''ente');

  result := TzConservazioneFactory.Crea(FConfigurazione.Fornitore);
  result.Configura(FConfigurazione);

  providerBase := result as TzConservazioneProviderBase;

  providerBase.OnLogRequest := function(const Operazione, Endpoint, Richiesta: string): Int64
    var
      sp: TSP_OBJ_FILES_CONSERVAZIONE_LOG_REQUEST_ADD;
    begin
      sp := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_LOG_REQUEST_ADD>();
      try
        sp.Id_Conservazione_Pacchetto := IdPacchetto;
        sp.Id_Tenant := FIdTenant;
        sp.Fornitore := FConfigurazione.Fornitore;
        sp.Operazione := Operazione;
        sp.Endpoint := Endpoint;
        sp.Richiesta.Text := Richiesta;
        sp.ExecuteAndCommit;
        result := sp.Id_Conservazione_Log_Request.Value;
      finally
        FreeAndNil(sp);
      end;
    end;

  providerBase.OnLogResponse := procedure(IdLogRequest: Int64; HttpStatus: Integer;
      const Risposta, Errore: string)
    var
      sp: TSP_OBJ_FILES_CONSERVAZIONE_LOG_RESPONSE_ADD;
    begin
      sp := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_LOG_RESPONSE_ADD>();
      try
        sp.Id_Conservazione_Log_Request := IdLogRequest;
        sp.Http_Status := HttpStatus;
        sp.Risposta.Text := Risposta;
        sp.Errore.Text := Errore;
        sp.ExecuteAndCommit;
      finally
        FreeAndNil(sp);
      end;
    end;
end;

procedure TDocumentazioneBridgeConservazione.RegistraErrore(IdPacchetto: Int64; E: Exception);
var
  sp: TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_ERRORE;
begin
  sp := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_ERRORE>();
  try
    sp.Id_Conservazione_Pacchetto := IdPacchetto;
    sp.Messaggio.Text := E.Message;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;
end;

function TDocumentazioneBridgeConservazione.FullFileName(IdObjectFile: Int64): string;
var
  sp: TSP_GET_FULL_FILE_NAME;
begin
  sp := GetSP<TSP_GET_FULL_FILE_NAME>();
  try
    sp.Id_Object_File := IdObjectFile;
    sp.ExecuteWithoutCommit;
    result := sp.Full_File_Name.Value;
  finally
    FreeAndNil(sp);
  end;
end;

function TDocumentazioneBridgeConservazione.HashFile(const NomeFile: string): string;
begin
  result := '';
  if NomeFile.IsEmpty then
    exit;
  if not TFile.Exists(NomeFile) then
    exit;
  // hash congelato: e' l'unico modo per accorgersi in seguito di file
  // cambiati o corrotti (SHA-256 = default di GetHashStringFromFile)
  result := THashSHA2.GetHashStringFromFile(NomeFile);
end;

function TDocumentazioneBridgeConservazione.ConservaDocumento(const Oid, IdObjectFile: Int64;
  const ClasseDocumentale: string): Int64;
var
  spPacchetto: TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_ADD;
  spFile: TSP_OBJ_FILES_CONSERVAZIONE_FILE_ADD;
  nomeFile: string;
begin
  CaricaConfigurazione;

  if FConfigurazione.Fornitore.IsEmpty then
    raise EzConservazioneErrore.Create('Nessun conservatore configurato per l''ente');

  // 1. nuovo pacchetto 'INS'
  spPacchetto := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_ADD>();
  try
    spPacchetto.Id_Tenant := FIdTenant;
    spPacchetto.Fornitore := FConfigurazione.Fornitore;
    spPacchetto.Cod_Classe_Documentale := ClasseDocumentale;
    spPacchetto.ExecuteAndCommit;
    result := spPacchetto.Id_Conservazione_Pacchetto.Value;
  finally
    FreeAndNil(spPacchetto);
  end;

  // 2. la versione da conservare, con hash congelato
  nomeFile := FullFileName(IdObjectFile);

  spFile := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_FILE_ADD>();
  try
    spFile.Id_Conservazione_Pacchetto := result;
    spFile.Id_Object_File := IdObjectFile;
    spFile.Sha256 := HashFile(nomeFile);
    spFile.ExecuteAndCommit;
  finally
    FreeAndNil(spFile);
  end;
end;

function TDocumentazioneBridgeConservazione.CaricaPacchetto(IdPacchetto: Int64): TzConservazionePacchetto;
var
  spPacchetto: TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_GET;
  spFiles: TSP_OBJ_FILES_CONSERVAZIONE_FILES_GET;
  documento: TzConservazioneDocumento;
begin
  result.Clear;
  result.IdPacchetto := IdPacchetto;
  result.IdTenant := FIdTenant;

  spPacchetto := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_GET>();
  try
    spPacchetto.Id_Conservazione_Pacchetto := IdPacchetto;
    spPacchetto.ExecuteWithoutCommit;
    result.ClasseDocumentale := spPacchetto.Cod_Classe_Documentale.Value;
  finally
    FreeAndNil(spPacchetto);
  end;

  spFiles := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_FILES_GET>();
  try
    spFiles.Id_Conservazione_Pacchetto := IdPacchetto;
    // Mantis #61 - 2026-08-31: procedura selezionabile, va aperta con Open
    spFiles.Open;
    while not spFiles.EOF do
    begin
      documento.Clear;
      documento.IdObjectFile := spFiles.Id_Object_File.Value;
      documento.HashSha256 := spFiles.Sha256.Value;
      documento.FullFileName := FullFileName(documento.IdObjectFile);
      result.Documenti := result.Documenti + [documento];
      spFiles.Next;
    end;
  finally
    spFiles.Close;
    FreeAndNil(spFiles);
  end;
end;

procedure TDocumentazioneBridgeConservazione.VersaPacchetto(IdPacchetto: Int64);
var
  spGenerato: TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_GENERATO;
  spInviato: TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_INVIATO;
  provider: IzConservazioneProvider;
  pacchetto: TzConservazionePacchetto;
  esito: TzConservazioneEsito;
begin
  pacchetto := CaricaPacchetto(IdPacchetto);

  // 1. SIP generato (il file archivio lo produce il provider concreto; per il
  //    motore si marca solo lo stato con il conteggio documenti)
  spGenerato := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_GENERATO>();
  try
    spGenerato.Id_Conservazione_Pacchetto := IdPacchetto;
    spGenerato.Numero_Documenti := Length(pacchetto.Documenti);
    spGenerato.ExecuteAndCommit;
  finally
    FreeAndNil(spGenerato);
  end;

  provider := CreaProvider(IdPacchetto);

  try
    esito := provider.Versa(pacchetto);
  except
    on E: Exception do
    begin
      RegistraErrore(IdPacchetto, E);
      raise;
    end;
  end;

  // 2. inviato (attesa esito): il polling lo portera' ad ACC/RIF/CON
  spInviato := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_INVIATO>();
  try
    spInviato.Id_Conservazione_Pacchetto := IdPacchetto;
    spInviato.Id_Pacchetto_Esterno := esito.IdPacchettoEsterno;
    spInviato.Stato_Esterno := esito.StatoEsterno;
    spInviato.ExecuteAndCommit;
  finally
    FreeAndNil(spInviato);
  end;
end;

function TDocumentazioneBridgeConservazione.CreaVersioneRapporto(IdObjectFilePadre: Int64;
  const FileRapporto: string): Int64;
var
  sp: TSP_OBJ_FILES_VERSIONE_ADD;
  percorsoDefinitivo: string;
begin
  result := 0;

  if IdObjectFilePadre = 0 then
    exit;
  if FileRapporto.IsEmpty or not TFile.Exists(FileRapporto) then
    exit;

  sp := GetSP<TSP_OBJ_FILES_VERSIONE_ADD>();
  try
    sp.Id_Object_File_Padre := IdObjectFilePadre;
    sp.Tipo_Versione := 'RIC';
    sp.Nome_File_Originale := 'rapporto_di_versamento.xml';
    sp.File_Suffix := '_rdv';
    sp.File_Size := 0;
    sp.ExecuteAndCommit;
    result := sp.Id_Object_File.Value;
    percorsoDefinitivo := sp.Full_File_Name.Value;
  finally
    FreeAndNil(sp);
  end;

  ForceDirectories(ExtractFilePath(percorsoDefinitivo));
  TFile.Copy(FileRapporto, percorsoDefinitivo, True);
end;

procedure TDocumentazioneBridgeConservazione.AggiornaStatoPacchetto(IdPacchetto: Int64);
var
  spGet: TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_GET;
  spFileEsito: TSP_OBJ_FILES_CONSERVAZIONE_FILE_ESITO_SET;
  spAccettato: TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_ACCETTATO;
  spConservato: TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_CONSERVATO;
  spRifiutato: TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_RIFIUTATO;
  provider: IzConservazioneProvider;
  statoCorrente: string;
  idPacchettoEsterno: string;
  idArchivio: Int64;
  esito: TzConservazioneEsito;
  esitoDoc: TzConservazioneEsitoDocumento;
  fileRapporto: string;
  idRapporto: Int64;
begin
  spGet := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_GET>();
  try
    spGet.Id_Conservazione_Pacchetto := IdPacchetto;
    spGet.ExecuteWithoutCommit;
    statoCorrente := spGet.Stato.Value;
    idPacchettoEsterno := spGet.Id_Pacchetto_Esterno.Value;
    idArchivio := spGet.Id_Object_File_Pacchetto.Value;
  finally
    FreeAndNil(spGet);
  end;

  // solo i pacchetti inviati e in attesa ('INV') hanno un esito da chiedere
  if statoCorrente <> CONSERVAZIONE_STATO_INVIATO then
    exit;

  provider := CreaProvider(IdPacchetto);

  try
    esito := provider.VerificaEsito(idPacchettoEsterno);
  except
    on E: Exception do
    begin
      RegistraErrore(IdPacchetto, E);
      raise;
    end;
  end;

  if not esito.Ok then
    exit;

  // esito per singolo documento
  for esitoDoc in esito.EsitiDocumenti do
  begin
    spFileEsito := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_FILE_ESITO_SET>();
    try
      spFileEsito.Id_Conservazione_Pacchetto := IdPacchetto;
      spFileEsito.Id_Object_File := esitoDoc.IdObjectFile;
      spFileEsito.Esito := EsitoDocumentoDb(esitoDoc.Esito);
      spFileEsito.Motivo_Scarto.Text := esitoDoc.MotivoScarto;
      spFileEsito.Id_Documento_Esterno := esitoDoc.IdDocumentoEsterno;
      spFileEsito.ExecuteAndCommit;
    finally
      FreeAndNil(spFileEsito);
    end;
  end;

  // esito del pacchetto
  if SameText(esito.Stato, CONSERVAZIONE_STATO_CONSERVATO) then
  begin
    // il Rapporto di Versamento e' esso stesso da conservare: lo registro
    // come versione 'RIC' del file archivio del pacchetto
    idRapporto := 0;
    fileRapporto := '';
    try
      fileRapporto := provider.ScaricaRapportoDiVersamento(idPacchettoEsterno,
        TPath.GetTempPath);
    except
      // il RdV si potra' riscaricare a un polling successivo: non blocca la
      // registrazione dello stato conservato
    end;
    if not fileRapporto.IsEmpty then
      idRapporto := CreaVersioneRapporto(idArchivio, fileRapporto);

    spConservato := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_CONSERVATO>();
    try
      spConservato.Id_Conservazione_Pacchetto := IdPacchetto;
      if idRapporto <> 0 then
        spConservato.Id_Object_File_Rapporto := idRapporto;
      spConservato.Stato_Esterno := esito.StatoEsterno;
      spConservato.ExecuteAndCommit;
    finally
      FreeAndNil(spConservato);
    end;
  end
  else
    if SameText(esito.Stato, CONSERVAZIONE_STATO_RIFIUTATO) then
    begin
      spRifiutato := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_RIFIUTATO>();
      try
        spRifiutato.Id_Conservazione_Pacchetto := IdPacchetto;
        spRifiutato.Stato_Esterno := esito.StatoEsterno;
        spRifiutato.Messaggio.Text := esito.Messaggio;
        spRifiutato.ExecuteAndCommit;
      finally
        FreeAndNil(spRifiutato);
      end;
    end
    else
      if SameText(esito.Stato, CONSERVAZIONE_STATO_ACCETTATO) then
      begin
        spAccettato := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_PACCHETTO_ACCETTATO>();
        try
          spAccettato.Id_Conservazione_Pacchetto := IdPacchetto;
          spAccettato.Stato_Esterno := esito.StatoEsterno;
          spAccettato.ExecuteAndCommit;
        finally
          FreeAndNil(spAccettato);
        end;
      end;
      // qualsiasi altro stato: resta 'INV', si riprovera' al prossimo polling
end;

function TDocumentazioneBridgeConservazione.TipiVersioneInCatena(IdObjectFile: Int64): TArray<string>;
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
      if not sp.Annullato.Value then
        if not sp.Eliminato.Value then
          result := result + [sp.Tipo_Versione.Value];
      sp.Next;
    end;
  finally
    sp.Close;
    FreeAndNil(sp);
  end;
end;

procedure TDocumentazioneBridgeConservazione.AggiornaStatoPerCatena(IdObjectFile: Int64);
var
  sp: TSP_OBJ_FILES_CONSERVAZIONE_GET_BY_OBJ_FILE;
  idPacchetto: Int64;
begin
  sp := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_GET_BY_OBJ_FILE>();
  try
    sp.Id_Object_File := IdObjectFile;
    sp.ExecuteWithoutCommit;
    idPacchetto := sp.Id_Conservazione_Pacchetto.Value;
  finally
    FreeAndNil(sp);
  end;

  if idPacchetto <> 0 then
    AggiornaStatoPacchetto(idPacchetto);
end;

procedure TDocumentazioneBridgeConservazione.VerificaPendenti;
var
  sp: TSP_OBJ_FILES_CONSERVAZIONE_DA_VERIFICARE_GET;
  daVerificare: TArray<Int64>;
  idPacchetto: Int64;
begin
  daVerificare := nil;

  sp := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_DA_VERIFICARE_GET>();
  try
    sp.Id_Tenant := FIdTenant;
    // Mantis #61 - 2026-08-31: procedura selezionabile, va aperta con Open
    sp.Open;
    while not sp.EOF do
    begin
      daVerificare := daVerificare + [sp.Id_Conservazione_Pacchetto.Value];
      sp.Next;
    end;
  finally
    sp.Close;
    FreeAndNil(sp);
  end;

  // il provider si chiama fuori dal cursore selectable
  for idPacchetto in daVerificare do
    AggiornaStatoPacchetto(idPacchetto);
end;

function TDocumentazioneBridgeConservazione.StatoConservazionePerCatena(IdObjectFile: Int64): string;
var
  sp: TSP_OBJ_FILES_CONSERVAZIONE_GET_BY_OBJ_FILE;
begin
  sp := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_GET_BY_OBJ_FILE>();
  try
    sp.Id_Object_File := IdObjectFile;
    sp.ExecuteWithoutCommit;
    result := sp.Stato.Value;
  finally
    FreeAndNil(sp);
  end;
end;

function TDocumentazioneBridgeConservazione.EstremiConservazionePerCatena(IdObjectFile: Int64): string;
var
  sp: TSP_OBJ_FILES_CONSERVAZIONE_GET_BY_OBJ_FILE;
  stato: string;
  idDocumentoEsterno: string;
begin
  result := '';

  sp := GetSP<TSP_OBJ_FILES_CONSERVAZIONE_GET_BY_OBJ_FILE>();
  try
    sp.Id_Object_File := IdObjectFile;
    sp.ExecuteWithoutCommit;
    if sp.Id_Conservazione_Pacchetto.Value = 0 then
      exit;
    stato := sp.Stato.Value;
    idDocumentoEsterno := sp.Id_Documento_Esterno.Value;
  finally
    FreeAndNil(sp);
  end;

  if SameText(stato, CONSERVAZIONE_STATO_CONSERVATO) then
  begin
    result := 'Conservato';
    if not idDocumentoEsterno.IsEmpty then
      result := result + ' (' + idDocumentoEsterno + ')';
  end
  else
    if SameText(stato, CONSERVAZIONE_STATO_ACCETTATO) then
      result := 'Accettato in conservazione'
    else
      if SameText(stato, CONSERVAZIONE_STATO_INVIATO) then
        result := 'Versato, in attesa di esito'
      else
        if SameText(stato, CONSERVAZIONE_STATO_GENERATO) then
          result := 'Pacchetto generato'
        else
          if SameText(stato, CONSERVAZIONE_STATO_INSERITO) then
            result := 'In coda per la conservazione'
          else
            if SameText(stato, CONSERVAZIONE_STATO_RIFIUTATO) then
              result := 'Rifiutato dal conservatore';
end;

end.
