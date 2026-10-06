unit Documentazione.Bridge.Protocollo;

// Ponte applicativo della protocollazione multi-fornitore (Gesty).
// Gemello di Documentazione.Bridge.Firma / Documentazione.Bridge.Messaggi: qui e SOLO qui
// vivono database, stored procedure e transazioni; il provider
// (zDocumentale.Protocollo.<X>, oggi solo NESSUNO) riceve configurazione,
// corrispondenze e callback di log e non tocca mai il DB.
//
// Flusso sincrono: ProtocollaDocumento registra 'P' (soggetti + file, PRIMA
// della chiamata al fornitore: idempotenza) -> provider.Protocolla ->
// _PROTOCOLLATA ('K', numero/anno/data assegnati) oppure, se il fornitore
// numera in differita (InAttesaDiNumero), _INVIATA ('A'). Il polling
// (AggiornaStatoPerCatena / VerificaPendenti) porta poi le 'A' a 'K' con
// provider.AggiornaEstremi.
//
// NOTA Gesty: non esiste una numerazione di protocollo INTERNA, quindi il
// fornitore 'NESSUNO' non e' operativo (FornitoreAttivo lo tratta come vuoto:
// l'azione non compare). La protocollazione si attiva quando l'ente configura
// un fornitore concreto (un provider a parte).
//
// I wrapper TSP_* vengono da Gesty_StoredProcs (generata dal tool):
// rigenerarla dopo aver eseguito lo script 10_protocollo_gesty.sql.

interface

uses
  System.SysUtils,
  System.Classes,
  Base_DataModule,
  zDocumentale.Protocollo.Types,
  zDocumentale.Protocollo.Intf,
  zDocumentale.Protocollo.ProviderBase,
  zDocumentale.Protocollo.Factory,
  Gesty_StoredProcs;

type
  TDocumentazioneBridgeProtocollo = class(TBaseDataModule)
  private
    FIdTenant: Int64;
    FConfigurazione: TzProtocolloConfigurazione;
    FConfigurazioneCaricata: Boolean;

    procedure CaricaConfigurazione;
    function CreaProvider(IdRegistrazione: Int64): IzProtocolloProvider;
    procedure RegistraErrore(IdRegistrazione: Int64; E: Exception);

    function FullFileName(IdObjectFile: Int64): string;
    procedure AggiornaStatoRegistrazione(IdRegistrazione: Int64);
  public
    destructor Destroy; override;

    // il fornitore attivo del tenant ('' = protocollo non configurato/non
    // operativo: l'azione "Protocolla" non compare)
    function FornitoreAttivo: string;

    // registra e protocolla il documento (una versione come allegato
    // principale + i soggetti). Ritorna ID_PROTOCOLLO_REGISTRAZIONE.
    function ProtocollaDocumento(const Oid, IdObjectFile: Int64;
      Direzione: TzProtocolloDirezione; const Oggetto: string;
      const Soggetti: TArray<TzProtocolloSoggetto>): Int64;

    // ------------------------------------------------------------------
    // Servizi per il controller delle azioni documentali
    // ------------------------------------------------------------------

    // i TIPO_VERSIONE presenti (non annullati/eliminati) nella catena.
    // E' generico (legge OBJ_FILES_VERSIONI): serve al gate 3.
    function TipiVersioneInCatena(IdObjectFile: Int64): TArray<string>;

    // polling della registrazione trovata sulla catena (se in attesa 'A')
    procedure AggiornaStatoPerCatena(IdObjectFile: Int64);

    // porta a 'K' tutte le registrazioni del tenant ancora in attesa ('A')
    procedure VerificaPendenti;

    // stato dell'ultima registrazione sulla CATENA del file (gate 4 della UI:
    // da passare a StatoAzioneDaRegistrazione); '' = mai protocollato
    function StatoProtocolloPerCatena(IdObjectFile: Int64): string;

    // estremi leggibili ('1234/2026 del 15/07/2026') dell'ultima
    // registrazione sulla catena
    function EstremiProtocolloPerCatena(IdObjectFile: Int64): string;

    property IdTenant: Int64 read FIdTenant write FIdTenant;
  end;

var
  DocumentazioneBridgeProtocollo: TDocumentazioneBridgeProtocollo;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

function DirezioneChar(Direzione: TzProtocolloDirezione): string;
begin
  case Direzione of
    pdEntrata:
      result := 'E';
    pdUscita:
      result := 'U';
    pdInterno:
      result := 'I';
  else
    result := 'U';
  end;
end;

destructor TDocumentazioneBridgeProtocollo.Destroy;
begin
  if FConfigurazioneCaricata then
    FConfigurazione.Finalizza;
  inherited;
end;

procedure TDocumentazioneBridgeProtocollo.CaricaConfigurazione;
var
  spConfigurazione: TSP_OBJ_FILES_PROTOCOLLO_CONFIGURAZIONE_GET;
  spParametri: TSP_OBJ_FILES_PROTOCOLLO_CONFIG_PARAMETRI_GET;
begin
  if FConfigurazioneCaricata then
    FConfigurazione.Finalizza;

  FConfigurazione.Inizializza;
  FConfigurazioneCaricata := True;

  spConfigurazione := GetSP<TSP_OBJ_FILES_PROTOCOLLO_CONFIGURAZIONE_GET>();
  try
    spConfigurazione.Id_Tenant := FIdTenant;
    spConfigurazione.ExecuteWithoutCommit;

    FConfigurazione.Fornitore := spConfigurazione.Fornitore.Value;
    FConfigurazione.IdTenant := FIdTenant;
    FConfigurazione.UrlBase := spConfigurazione.Url_Base.Value;
    FConfigurazione.Utente := spConfigurazione.Utente.Value;
    FConfigurazione.Password := spConfigurazione.Password_.Value;

    // valori logici di default della registrazione (il provider li traduce
    // con le corrispondenze): li trasporto tra i parametri di configurazione
    FConfigurazione.Parametri.AddOrSetValue('TIPO_DOCUMENTO', spConfigurazione.Tipo_Documento.Value);
    FConfigurazione.Parametri.AddOrSetValue('CLASSIFICA', spConfigurazione.Classifica.Value);
    FConfigurazione.Parametri.AddOrSetValue('UFFICIO', spConfigurazione.Ufficio.Value);
    FConfigurazione.Parametri.AddOrSetValue('AREA_ORGANIZZATIVA', spConfigurazione.Area_Organizzativa.Value);
    FConfigurazione.Parametri.AddOrSetValue('CANALE_INVIO', spConfigurazione.Canale_Invio.Value);
  finally
    FreeAndNil(spConfigurazione);
  end;

  if FConfigurazione.Fornitore.IsEmpty then
    exit;

  spParametri := GetSP<TSP_OBJ_FILES_PROTOCOLLO_CONFIG_PARAMETRI_GET>();
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
end;

function TDocumentazioneBridgeProtocollo.FornitoreAttivo: string;
begin
  CaricaConfigurazione;
  result := FConfigurazione.Fornitore;

  // Gesty non ha una numerazione di protocollo interna: il fornitore
  // 'NESSUNO' non e' operativo -> azione nascosta
  if SameText(result, PROTOCOLLO_FORNITORE_NESSUNO) then
    result := '';
end;

function TDocumentazioneBridgeProtocollo.CreaProvider(IdRegistrazione: Int64): IzProtocolloProvider;
var
  providerBase: TzProtocolloProviderBase;
begin
  CaricaConfigurazione;

  if FConfigurazione.Fornitore.IsEmpty then
    raise EzProtocolloErrore.Create('Nessun fornitore di protocollo configurato per l''ente');

  result := TzProtocolloFactory.Crea(FConfigurazione.Fornitore);
  result.Configura(FConfigurazione);

  providerBase := result as TzProtocolloProviderBase;

  providerBase.OnLogRequest := function(const Operazione, Endpoint, Richiesta: string): Int64
    var
      sp: TSP_OBJ_FILES_PROTOCOLLO_LOG_REQUEST_ADD;
    begin
      sp := GetSP<TSP_OBJ_FILES_PROTOCOLLO_LOG_REQUEST_ADD>();
      try
        sp.Id_Protocollo_Registrazione := IdRegistrazione;
        sp.Id_Tenant := FIdTenant;
        sp.Fornitore := FConfigurazione.Fornitore;
        sp.Operazione := Operazione;
        sp.Endpoint := Endpoint;
        sp.Richiesta.Text := Richiesta;
        sp.ExecuteAndCommit;
        result := sp.Id_Protocollo_Log_Request.Value;
      finally
        FreeAndNil(sp);
      end;
    end;

  providerBase.OnLogResponse := procedure(IdLogRequest: Int64; HttpStatus: Integer;
      const Risposta, Errore: string)
    var
      sp: TSP_OBJ_FILES_PROTOCOLLO_LOG_RESPONSE_ADD;
    begin
      sp := GetSP<TSP_OBJ_FILES_PROTOCOLLO_LOG_RESPONSE_ADD>();
      try
        sp.Id_Protocollo_Log_Request := IdLogRequest;
        sp.Http_Status := HttpStatus;
        sp.Risposta.Text := Risposta;
        sp.Errore.Text := Errore;
        sp.ExecuteAndCommit;
      finally
        FreeAndNil(sp);
      end;
    end;
end;

procedure TDocumentazioneBridgeProtocollo.RegistraErrore(IdRegistrazione: Int64; E: Exception);
var
  sp: TSP_OBJ_FILES_PROTOCOLLO_REGISTRAZIONE_ERRORE;
begin
  sp := GetSP<TSP_OBJ_FILES_PROTOCOLLO_REGISTRAZIONE_ERRORE>();
  try
    sp.Id_Protocollo_Registrazione := IdRegistrazione;
    sp.Messaggio.Text := E.Message;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;
end;

function TDocumentazioneBridgeProtocollo.FullFileName(IdObjectFile: Int64): string;
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

function TDocumentazioneBridgeProtocollo.ProtocollaDocumento(const Oid, IdObjectFile: Int64;
  Direzione: TzProtocolloDirezione; const Oggetto: string;
  const Soggetti: TArray<TzProtocolloSoggetto>): Int64;
var
  spRegistrazione: TSP_OBJ_FILES_PROTOCOLLO_REGISTRAZIONE_ADD;
  spSoggetto: TSP_OBJ_FILES_PROTOCOLLO_SOGGETTO_ADD;
  spFile: TSP_OBJ_FILES_PROTOCOLLO_FILE_ADD;
  spInviata: TSP_OBJ_FILES_PROTOCOLLO_REGISTRAZIONE_INVIATA;
  spProtocollata: TSP_OBJ_FILES_PROTOCOLLO_REGISTRAZIONE_PROTOCOLLATA;
  soggetto: TzProtocolloSoggetto;
  provider: IzProtocolloProvider;
  documento: TzProtocolloDocumento;
  allegato: TzProtocolloAllegato;
  esito: TzProtocolloEsito;
begin
  CaricaConfigurazione;

  if FConfigurazione.Fornitore.IsEmpty then
    raise EzProtocolloErrore.Create('Nessun fornitore di protocollo configurato per l''ente');

  // 1. registrazione 'P' prima della chiamata al fornitore (idempotenza).
  //    I codici logici (tipo documento/classifica/ufficio/AOO/canale) sono i
  //    default dell'ente: il provider li traduce con le corrispondenze.
  spRegistrazione := GetSP<TSP_OBJ_FILES_PROTOCOLLO_REGISTRAZIONE_ADD>();
  try
    spRegistrazione.Id_Tenant := FIdTenant;
    spRegistrazione.Fornitore := FConfigurazione.Fornitore;
    spRegistrazione.Direzione := DirezioneChar(Direzione);
    spRegistrazione.Oid := Oid;
    spRegistrazione.Oggetto := Oggetto;
    spRegistrazione.Tipo_Documento := FConfigurazione.Parametro('TIPO_DOCUMENTO');
    spRegistrazione.Classifica := FConfigurazione.Parametro('CLASSIFICA');
    spRegistrazione.Ufficio := FConfigurazione.Parametro('UFFICIO');
    spRegistrazione.Area_Organizzativa := FConfigurazione.Parametro('AREA_ORGANIZZATIVA');
    spRegistrazione.Canale_Invio := FConfigurazione.Parametro('CANALE_INVIO');
    spRegistrazione.ExecuteAndCommit;
    result := spRegistrazione.Id_Protocollo_Registrazione.Value;
  finally
    FreeAndNil(spRegistrazione);
  end;

  // 2. soggetti (mittente 'M' / destinatario 'D')
  for soggetto in Soggetti do
  begin
    spSoggetto := GetSP<TSP_OBJ_FILES_PROTOCOLLO_SOGGETTO_ADD>();
    try
      spSoggetto.Id_Protocollo_Registrazione := result;
      spSoggetto.Tipo := soggetto.Tipo;
      spSoggetto.Nominativo := Trim(soggetto.Cognome + ' ' + soggetto.Nome);
      spSoggetto.Codice_Fiscale := soggetto.CodiceFiscale;
      spSoggetto.Partita_Iva := soggetto.PartitaIva;
      spSoggetto.ExecuteAndCommit;
    finally
      FreeAndNil(spSoggetto);
    end;
  end;

  // 3. il documento come allegato principale (valorizza anche l'OID)
  spFile := GetSP<TSP_OBJ_FILES_PROTOCOLLO_FILE_ADD>();
  try
    spFile.Id_Protocollo_Registrazione := result;
    spFile.Id_Object_File := IdObjectFile;
    spFile.Principale := True;
    spFile.ExecuteAndCommit;
  finally
    FreeAndNil(spFile);
  end;

  // 4. documento per il provider (il path fisico lo risolve il ponte)
  documento.Clear;
  documento.IdTenant := FIdTenant;
  documento.Direzione := Direzione;
  documento.Oggetto := Oggetto;
  documento.Oid := Oid;
  documento.Soggetti := Soggetti;
  documento.TipoDocumento := FConfigurazione.Parametro('TIPO_DOCUMENTO');
  documento.Classifica := FConfigurazione.Parametro('CLASSIFICA');
  documento.Ufficio := FConfigurazione.Parametro('UFFICIO');
  documento.AreaOrganizzativa := FConfigurazione.Parametro('AREA_ORGANIZZATIVA');
  documento.CanaleInvio := FConfigurazione.Parametro('CANALE_INVIO');

  allegato.Clear;
  allegato.IdObjectFile := IdObjectFile;
  allegato.FullFileName := FullFileName(IdObjectFile);
  allegato.Principale := True;
  documento.Allegati := [allegato];

  provider := CreaProvider(result);

  // la registrazione esiste GIA' (idempotenza): la chiamata al fornitore sta
  // fuori da ogni transazione locale
  try
    esito := provider.Protocolla(documento);
  except
    on E: Exception do
    begin
      RegistraErrore(result, E);
      raise;
    end;
  end;

  if esito.InAttesaDiNumero then
  begin
    // numerazione differita: resta 'A', il polling la completa
    spInviata := GetSP<TSP_OBJ_FILES_PROTOCOLLO_REGISTRAZIONE_INVIATA>();
    try
      spInviata.Id_Protocollo_Registrazione := result;
      spInviata.Id_Documento_Esterno := esito.IdDocumentoEsterno;
      spInviata.ExecuteAndCommit;
    finally
      FreeAndNil(spInviata);
    end;
  end
  else
  begin
    spProtocollata := GetSP<TSP_OBJ_FILES_PROTOCOLLO_REGISTRAZIONE_PROTOCOLLATA>();
    try
      spProtocollata.Id_Protocollo_Registrazione := result;
      spProtocollata.Anno_Protocollo := esito.Anno;
      spProtocollata.Numero_Protocollo := esito.Numero;
      spProtocollata.Data_Protocollo := esito.Data;
      spProtocollata.Registro := esito.Registro;
      spProtocollata.Id_Documento_Esterno := esito.IdDocumentoEsterno;
      spProtocollata.ExecuteAndCommit;
    finally
      FreeAndNil(spProtocollata);
    end;
  end;
end;

procedure TDocumentazioneBridgeProtocollo.AggiornaStatoRegistrazione(IdRegistrazione: Int64);
var
  spGet: TSP_OBJ_FILES_PROTOCOLLO_REGISTRAZIONE_GET;
  spProtocollata: TSP_OBJ_FILES_PROTOCOLLO_REGISTRAZIONE_PROTOCOLLATA;
  provider: IzProtocolloProvider;
  statoCorrente: string;
  idDocumentoEsterno: string;
  esito: TzProtocolloEsito;
begin
  spGet := GetSP<TSP_OBJ_FILES_PROTOCOLLO_REGISTRAZIONE_GET>();
  try
    spGet.Id_Protocollo_Registrazione := IdRegistrazione;
    spGet.ExecuteWithoutCommit;
    statoCorrente := spGet.Stato.Value;
    idDocumentoEsterno := spGet.Id_Documento_Esterno.Value;
  finally
    FreeAndNil(spGet);
  end;

  // solo le registrazioni in attesa del numero ('A') hanno qualcosa da chiedere
  if statoCorrente <> 'A' then
    exit;

  provider := CreaProvider(IdRegistrazione);

  try
    esito := provider.AggiornaEstremi(idDocumentoEsterno);
  except
    on E: Exception do
    begin
      RegistraErrore(IdRegistrazione, E);
      raise;
    end;
  end;

  // ancora senza numero: si riproverera' al prossimo polling
  if not esito.Ok then
    exit;
  if esito.InAttesaDiNumero then
    exit;

  spProtocollata := GetSP<TSP_OBJ_FILES_PROTOCOLLO_REGISTRAZIONE_PROTOCOLLATA>();
  try
    spProtocollata.Id_Protocollo_Registrazione := IdRegistrazione;
    spProtocollata.Anno_Protocollo := esito.Anno;
    spProtocollata.Numero_Protocollo := esito.Numero;
    spProtocollata.Data_Protocollo := esito.Data;
    spProtocollata.Registro := esito.Registro;
    spProtocollata.Id_Documento_Esterno := esito.IdDocumentoEsterno;
    spProtocollata.ExecuteAndCommit;
  finally
    FreeAndNil(spProtocollata);
  end;
end;

function TDocumentazioneBridgeProtocollo.TipiVersioneInCatena(IdObjectFile: Int64): TArray<string>;
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

procedure TDocumentazioneBridgeProtocollo.AggiornaStatoPerCatena(IdObjectFile: Int64);
var
  sp: TSP_OBJ_FILES_PROTOCOLLO_GET_BY_OBJ_FILE;
  idRegistrazione: Int64;
begin
  sp := GetSP<TSP_OBJ_FILES_PROTOCOLLO_GET_BY_OBJ_FILE>();
  try
    sp.Id_Object_File := IdObjectFile;
    sp.ExecuteWithoutCommit;
    idRegistrazione := sp.Id_Protocollo_Registrazione.Value;
  finally
    FreeAndNil(sp);
  end;

  if idRegistrazione <> 0 then
    AggiornaStatoRegistrazione(idRegistrazione);
end;

procedure TDocumentazioneBridgeProtocollo.VerificaPendenti;
var
  sp: TSP_OBJ_FILES_PROTOCOLLO_DA_VERIFICARE_GET;
  daVerificare: TArray<Int64>;
  idRegistrazione: Int64;
begin
  daVerificare := nil;

  sp := GetSP<TSP_OBJ_FILES_PROTOCOLLO_DA_VERIFICARE_GET>();
  try
    sp.Id_Tenant := FIdTenant;
    // Mantis #61 - 2026-08-31: procedura selezionabile, va aperta con Open
    sp.Open;
    while not sp.EOF do
    begin
      daVerificare := daVerificare + [sp.Id_Protocollo_Registrazione.Value];
      sp.Next;
    end;
  finally
    sp.Close;
    FreeAndNil(sp);
  end;

  // il provider si chiama fuori dal cursore selectable
  for idRegistrazione in daVerificare do
    AggiornaStatoRegistrazione(idRegistrazione);
end;

function TDocumentazioneBridgeProtocollo.StatoProtocolloPerCatena(IdObjectFile: Int64): string;
var
  sp: TSP_OBJ_FILES_PROTOCOLLO_GET_BY_OBJ_FILE;
begin
  sp := GetSP<TSP_OBJ_FILES_PROTOCOLLO_GET_BY_OBJ_FILE>();
  try
    sp.Id_Object_File := IdObjectFile;
    sp.ExecuteWithoutCommit;
    result := sp.Stato.Value;
  finally
    FreeAndNil(sp);
  end;
end;

function TDocumentazioneBridgeProtocollo.EstremiProtocolloPerCatena(IdObjectFile: Int64): string;
var
  sp: TSP_OBJ_FILES_PROTOCOLLO_GET_BY_OBJ_FILE;
  numero: Int64;
  anno: Integer;
  data: TDateTime;
begin
  result := '';

  sp := GetSP<TSP_OBJ_FILES_PROTOCOLLO_GET_BY_OBJ_FILE>();
  try
    sp.Id_Object_File := IdObjectFile;
    sp.ExecuteWithoutCommit;
    numero := sp.Numero_Protocollo.Value;
    anno := sp.Anno_Protocollo.Value;
    data := sp.Data_Protocollo.Value;
  finally
    FreeAndNil(sp);
  end;

  if (numero = 0) and (anno = 0) then
    exit;

  result := Format('%d/%d', [numero, anno]);
  if data <> 0 then
    result := result + ' del ' + FormatDateTime('dd/mm/yyyy', data);
end;

end.
