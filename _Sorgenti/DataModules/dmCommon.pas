unit dmCommon;

// PROPOSTA - Mantis #90 - 2026-09-05: versione modificata per la preanalisi.
// Base: Gesty/_Sorgenti/DataModules/dmCommon.pas
// Non sostituisce il file sorgente (di sola lettura): va confrontata e
// riportata a mano nel repository dopo revisione in RAD Studio.
//
// Modifica: FirmaElettronicaController.TipoDocumento/TipoAllegato restano
// il default fisso ('CON'/'Contratto'), usato quando il template caricato
// in anteprima non dichiara nulla di suo. Il controller e' condiviso da
// dmRisorse per le griglie Contratti E Incarichi_Di_Massima
// (FirmaElettronica_InitReportsManager e' chiamato una sola volta): con un
// valore fisso senza eccezioni, un Incarico di Massima veniva trattato come
// un Contratto, sia nel controllo di ammissibilita' (FirmaElettronicaAmmessa
// leggeva la riga sbagliata) sia nella registrazione di firma.
// Il riconoscimento del tipo NON e' piu' qui: il template dell'Incarico di
// Massima dichiara da solo "tipoDocumento"/"tipoAllegato" nel proprio
// '.json' sidecar (vedi Incarico di massima - Versione 4.json in questa
// stessa cartella), che arriva fino al controller tramite
// TDocumentazioneReportActionsController.TipoDocumentoRisolto/
// TipoAllegatoRisolto (Documentazione.ReportActionsController.pas) — vedi
// 90 - ANALISI.md, sezione "Codice proposto — versione 2026-09-05".
// Richiede le tre patch generiche a zPack descritte li'
// (zOffice.Reports.JsonConfig.pas, zOffice.Reports.pas,
// zOffice.Reports.Controller.pas): senza quelle, Contesto.TipoDocumento
// resta sempre vuoto e il controller usa solo il default 'CON'.

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.ImageList,
  Vcl.ImgList,
  Vcl.Controls,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  zFbDataSet,
  zMemoriaConScadenza,
  Base_DataModule,
  dbMaster,
  zOffice.Reports,
  Documentazione.ReportActionsController,
  Documentazione.Bridge.Messaggi,
  Documentazione.Bridge.Protocollo,
  Documentazione.Bridge.Conservazione;

type
  TCommon = class(TBaseDataModule)
    lkEmail: TzFbDataSet;
    lkAnniFormativi: TzFbDataSet;
    procedure DataModuleCreate(Sender: TObject);
  private
    // memoria del vincolo di firma: Stato() passa di qui a ogni idle della
    // form, il database si interroga solo quando cambia la pratica o scade
    // la memoria
    // Mantis #254 - 2026-10-26: memoria dell'esito con TzMemoriaConScadenza
    FMemoriaFirma: TzMemoriaConScadenza;
  private
    FFirmaElettronicaController: TDocumentazioneReportActionsController;
    FDocumentAzioniController: TDocumentazioneReportActionsController;

    // controller delle azioni documentali per i contratti (condiviso tra i
    // manager: lo stato di sessione vive nel manager, non qui)
    function FirmaElettronicaController: TDocumentazioneReportActionsController;

    // la risorsa della pratica accetta il contratto in forma elettronica?
    // Il valore letto resta in memoria per pochi secondi, per pratica e tipo
    // documento, poi viene riletto dal database.
    function FirmaElettronicaAmmessa(Oid: Int64; const TipoDocumento: string): Boolean;
  public
    destructor Destroy; override;

    function DocumentAzioniController: TDocumentazioneReportActionsController;
  public
    // ponte PEC unico dell'ente di lavoro (creato al primo uso): le feature
    // che abilitano l'azione "Invia PEC" sui report lo assegnano al proprio
    // controller (ActionsController.Pec := Common.PecBridge) insieme a
    // OnRichiediInvioPec (oggetto/corpo/destinatari)
    function PecBridge: TDocumentazioneBridgeMessaggi;
    // ponte protocollo unico dell'ente di lavoro (creato al primo uso). In
    // Gesty il fornitore 'NESSUNO' non e' operativo: l'azione "Protocolla"
    // compare solo se l'ente configura un fornitore concreto.
    function ProtocolloBridge: TDocumentazioneBridgeProtocollo;
    // ponte conservazione unico dell'ente di lavoro (creato al primo uso). In
    // Gesty il fornitore 'NESSUNO' e' un no-op: l'azione "Conserva" compare solo
    // se l'ente configura un conservatore accreditato.
    function ConservazioneBridge: TDocumentazioneBridgeConservazione;
  public
    function ClearUserName(const UserName: string): string;
    function CalcUserName(const Cognome, Nome: string): string;

    function CreaUtenteSistema(UserName: string; IdAnagrafe: integer; AskConfirmation: Boolean = true): Boolean;
    function CreaUtenteDominio(UserName: string; IdAnagrafe: integer; AskConfirmation: Boolean = true): Boolean;
  public
    function CurrentIdRisorsa: integer;
    function CurrentIdSessione: integer;
    function EnteDefault: integer;
    function SedeDefault: integer;
    procedure GetEnteAndSedeDefault(out Ente, Sede: integer; out Raggruppamento: string);
    function QuestionarioDefault: integer;
  public
    function AnnoFormativoCorrente: string;
    function GetAnniFormativi: string;
  public
    procedure CopiaFileRendicontazione(const FileName: string; const TipoFlusso: string);
    procedure FocusField(Field: TField);
    procedure CustomizeDataSet(const DatasetName: string; DataSet: TzFbDataSet);
    procedure GetMailRisorse(StringList: TStringList);

    function GetTirocinioFolder(const ReportGroup: string; DataSet: TDataSet): string;
  public
    procedure FirmaElettronica_InitReportsManager(ReportsManager: TzReportsManager);
  public
    procedure AssegnaVariabiliTimeReport(ReportsManager: TzReportsManager; IdRisorsa, IdIncarico: integer; DataSet: TzFbDataSet);
  end;

var
  Common: TCommon;

implementation

uses
  Winapi.Windows,
  System.DateUtils,
  System.Variants,
  System.IOUtils,
  System.UITypes,
  Vcl.Dialogs,
  Vcl.Graphics,
  dxGDIPlusClasses,
  dxRichEdit.Utils.UriStreamService,
  zBaseLib,
  Gesty_StoredProcs,
  zCodiceFiscale,
  ConfigModule,
  Gesty.Types,
  zSystem,
  zDX,
  zOffice.Word.UriStreamProvider,
  zOffice.Reports.Controller,
  Documentazione.Bridge.Firma,
  frmDocumentazioneInvioMessaggio,
  SmartInspect.Vcl,
  SmartInspect.Vcl.SiAuto,
  UtentiDominio.Lib,
  zMsg;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

const
  // durata della memoria dell'esito di FirmaElettronicaAmmessa
  DurataMemoriaFirmaMillisecondi = 5000;

procedure TCommon.DataModuleCreate(Sender: TObject);
begin
  inherited;
  // Mantis #254 - 2026-10-26: memoria dell'esito con TzMemoriaConScadenza
  FMemoriaFirma := TzMemoriaConScadenza.Create(DurataMemoriaFirmaMillisecondi);
end;

destructor TCommon.Destroy;
begin
  FreeAndNil(FMemoriaFirma);
  inherited;
end;

function TCommon.AnnoFormativoCorrente: string;
begin
  result := Config.Database.ExecSQLScalar('SELECT CURRENT_ANNO_FORMATIVO_DESC() FROM RDB$DATABASE');
end;

function TCommon.CalcUserName(const Cognome, Nome: string): string;
begin
  result := copy(Nome, 1, 1) + Cognome;
  result := ClearUserName(result);
end;

function TCommon.ClearUserName(const UserName: string): string;
begin
  result := UserName.ToUpper.Replace(' ', '').Replace('''', '');
  result := copy(result, 1, 50);
end;

procedure TCommon.CopiaFileRendicontazione(const FileName, TipoFlusso: string);
  function CartellaRendicontazione(const TipoFlusso: string): string;
  begin
    result := '';
    result := Config.zSystem.Folder('CARTELLA_FLUSSI_RENDICONTAZIONE', path + 'Flussi');
    result := CalcPath(CalcPath(result) + 'Rendicontazioni' + '\' + TipoFlusso);
    ForceDirectories(result);
  end;

var
  Folder: string;
begin
  Folder := CartellaRendicontazione(TipoFlusso);

  if not DirectoryExists(Folder) then
    ForceDirectories(Folder);

  if not DirectoryExists(Folder) then
    ConfirmOk('Impossibile copiare il file di rendicontazione nella cartella ' + #13 + Folder)
  else
    TFile.copy(FileName, Folder + ExtractFileName(FileName), true);
end;

function TCommon.CreaUtenteSistema(UserName: string; IdAnagrafe: integer; AskConfirmation: Boolean = true): Boolean;
var
  sp: TSP_anagrafe_Crea_User;
begin
  result := false;

  UserName := ClearUserName(UserName);

  if AskConfirmation then
    if not InputQuery('Nuovo utente sistema', 'Nome utente', UserName) then
      exit;

  sp := TSP_anagrafe_Crea_User.Create(WriteTrans);
  try
    sp.Id_Anagrafica := IdAnagrafe;
    sp.User_Name := UserName;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  result := true;
end;

function TCommon.CreaUtenteDominio(UserName: string; IdAnagrafe: integer; AskConfirmation: Boolean): Boolean;
var
  sp: TSP_CONFIG_GET_DOMAIN;
  server, password: string;
begin
  result := false;

  UserName := ClearUserName(UserName);

  if AskConfirmation then
    if not InputQuery('Nuovo utente dominio', 'Nome utente', UserName) then
      exit;

  sp := GetSP<TSP_CONFIG_GET_DOMAIN>;
  try
    sp.ExecuteAndCommit;
    server := sp.Host_Ldap;
    password := sp.Password_Default;
  finally
    FreeAndNil(sp);
  end;

  result := UtentiDominio.Lib.CreaUtenteDominio(server, UserName, password);
end;

function TCommon.CurrentIdRisorsa: integer;
var
  v: variant;
begin
  result := -1;

  v := Config.Database.ExecSQLScalar('SELECT CURRENT_ID_RISORSA() FROM RDB$DATABASE');

  if not VarIsNull(v) then
    if not VarIsEmpty(v) then
      result := v;
end;

function TCommon.CurrentIdSessione: integer;
var
  v: variant;
begin
  result := -1;

  v := Config.Database.ExecSQLScalar('SELECT CURRENT_ID_SESSIONE() FROM RDB$DATABASE');

  if not VarIsNull(v) then
    if not VarIsEmpty(v) then
      result := v;
end;

procedure TCommon.CustomizeDataSet(const DatasetName: string; DataSet: TzFbDataSet);
var
  sp: TSP_ZZ_CUSTOM_DATASET_GET;
  requiredFields: string;
  removeDefaults: string;
  FieldName: string;
  Field: TField;
begin
  Assert(Assigned(DataSet));

  sp := TSP_ZZ_CUSTOM_DATASET_GET.Create(WriteTrans);
  try
    sp.DataSet := DatasetName;
    sp.ExecuteAndCommit;
    requiredFields := sp.REQUIRED_FIELDS;
    removeDefaults := sp.REMOVE_DEFAULT_EXPRESSION;
  finally
    FreeAndNil(sp);
  end;

  /// ////////////////////

  DataSet.DisableControls;
  try

    requiredFields := requiredFields.Replace(',', ';', [rfReplaceAll]);

    for FieldName in requiredFields.Split([';']) do
    begin
      Field := DataSet.FindField(FieldName);

      if Assigned(Field) then
        Field.Required := true;
    end;

    /// ////////////////////

    removeDefaults := removeDefaults.Replace(',', ';', [rfReplaceAll]);

    for FieldName in removeDefaults.Split([';']) do
    begin
      Field := DataSet.FindField(FieldName);

      if Assigned(Field) then
        Field.DefaultExpression := '';
    end;
  finally
    DataSet.EnableControls;
  end;
end;

function TCommon.DocumentAzioniController: TDocumentazioneReportActionsController;
begin

  if not Assigned(FDocumentAzioniController) then
  begin
    // stesso ponte Firma dei contratti (pigro, condiviso: nessun conflitto,
    // e' solo l'accesso al database): qui l'istanza del CONTROLLER e'
    // diversa apposta, per non mescolare la cache di sessione dei contratti
    // con quella dei viewer generici
    if not Assigned(DocumentazioneBridgeFirma) then
    begin
      DocumentazioneBridgeFirma := TDocumentazioneBridgeFirma.Create(Self);
      DocumentazioneBridgeFirma.IdTenant := EnteDefault;
    end;

    FDocumentAzioniController := TDocumentazioneReportActionsController.Create(Self);
    FDocumentAzioniController.zSystem := Config.zSystem;
    FDocumentAzioniController.Firma := DocumentazioneBridgeFirma;
    FDocumentAzioniController.Pec := PecBridge;
    FDocumentAzioniController.OnRichiediInvioPec := RichiediInvioMessaggio;
    FDocumentAzioniController.Protocollo := ProtocolloBridge;
    FDocumentAzioniController.Conservazione := ConservazioneBridge;
    // nessun TipoAllegato / TipoDocumento / FirmaConApprovazioneInterna:
    // istanza neutra, non tarata sui contratti
  end;

  result := FDocumentAzioniController;
end;

function TCommon.EnteDefault: integer;
var
  Sede: integer;
  Raggruppamento: string;
begin
  GetEnteAndSedeDefault(result, Sede, Raggruppamento);
end;

procedure TCommon.FocusField(Field: TField);
begin
  TThread.ForceQueue(nil,
    procedure
    begin
      try
        if Assigned(Field) then
          Field.FocusControl;
      except
      end;
    end);
end;

function TCommon.GetAnniFormativi: string;
var
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    lkAnniFormativi.RevertSQL(false);
    lkAnniFormativi.OrderBy := 'ANNO_FORMATIVO DESC';
    lkAnniFormativi.Active := true;
    try

      while not lkAnniFormativi.Eof do
      begin
        StringList.Add(lkAnniFormativi.FieldByName('ANNO_FORMATIVO').asString);
        lkAnniFormativi.Next;
      end;
    finally
      lkAnniFormativi.Active := false
    end;
    StringList.Add('Tutti');
    result := StringList.Text;
  finally
    FreeAndNil(StringList);
  end;
end;

procedure TCommon.GetEnteAndSedeDefault(out Ente, Sede: integer; out Raggruppamento: string);
var
  sp: TSP_config_Get_Ente_Default;
begin
  sp := TSP_config_Get_Ente_Default.Create(WriteTrans);
  try
    sp.ExecuteAndCommit;

    if sp.Ente_Default.IsNull then
      Ente := -1
    else
      Ente := sp.Ente_Default;

    if sp.Sede_Default.IsNull then
      Sede := -1
    else
      Sede := sp.Sede_Default;

    Raggruppamento := sp.Raggruppamento;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TCommon.GetMailRisorse(StringList: TStringList);
begin
  Assert(Assigned(StringList));

  StringList.BeginUpdate;
  try
    StringList.Clear;

    lkEmail.RevertSQL(false);
    lkEmail.FetchOptions.Unidirectional := true;
    lkEmail.Active := true;
    try
      while not lkEmail.Eof do
      begin
        // StringList.AddPair('alfa@alfa.com', 'Alfa');
        StringList.AddPair(lkEmail.FieldByName('E_MAIL').asString, lkEmail.FieldByName('NOMINATIVO_O_RAGIONE_SOCIALE').asString);
        lkEmail.Next;
      end;
    finally
      lkEmail.Active := false;
    end;
  finally
    StringList.EndUpdate;
  end;
end;

function TCommon.GetTirocinioFolder(const ReportGroup: string; DataSet: TDataSet): string;
var
  TipoTirocinio: TTipoTirocinio;
begin
  Assert(Assigned(DataSet));

  result := '';

  if DataSet.IsEmpty then
    exit;

  TipoTirocinio := TTipoTirocinio.FromString(DataSet.FieldByName('TIPO_TIROCINIO').asString);
  result := ReportGroup + '\' + TipoTirocinio.Description;
end;

function TCommon.QuestionarioDefault: integer;
var
  v: variant;
begin
  result := -1;

  v := Config.Database.ExecSQLScalar('SELECT QUESTIONARIO_GENERALE_ATTIVO() FROM RDB$DATABASE');

  if not VarIsNull(v) then
    if not VarIsEmpty(v) then
      result := v;
end;

function TCommon.SedeDefault: integer;
var
  Ente: integer;
  Raggruppamento: string;
begin
  GetEnteAndSedeDefault(Ente, result, Raggruppamento);
end;

function TCommon.FirmaElettronicaController: TDocumentazioneReportActionsController;
begin
  if not Assigned(FFirmaElettronicaController) then
  begin
    // il ponte della firma nasce al primo utilizzo, sull'ente di lavoro
    if not Assigned(DocumentazioneBridgeFirma) then
    begin
      DocumentazioneBridgeFirma := TDocumentazioneBridgeFirma.Create(Self);
      DocumentazioneBridgeFirma.IdTenant := EnteDefault;
    end;

    FFirmaElettronicaController := TDocumentazioneReportActionsController.Create(Self);
    FFirmaElettronicaController.zSystem := Config.zSystem;
    FFirmaElettronicaController.Firma := DocumentazioneBridgeFirma;
    // azione "Invia PEC": ponte messaggi (fornitore attivo dell'ente) +
    // dialogo di composizione (oggetto/corpo/destinatari)
    FFirmaElettronicaController.Pec := PecBridge;
    // FFirmaElettronicaController.OnRichiediInvioPec := RichiediInvioMessaggio;
    // azione "Protocolla": ponte protocollo (fornitore operativo dell'ente).
    // OnRichiediProtocollazione (direzione/oggetto/soggetti) va assegnato
    // quando si attivera' un fornitore concreto e il relativo dialogo di
    // composizione: finche' il fornitore non e' operativo l'azione resta nascosta.
    FFirmaElettronicaController.Protocollo := ProtocolloBridge;
    // azione "Conserva": ponte conservazione (conservatore operativo dell'ente).
    // OnRichiediConservazione (classe documentale) e' opzionale: senza, si usa
    // il nome del report; l'azione resta comunque nascosta finche' il fornitore
    // non e' operativo.
    FFirmaElettronicaController.Conservazione := ConservazioneBridge;

    // Mantis #90 - 2026-09-05: valori di default, usati quando il template
    // caricato in anteprima non dichiara nulla di suo nel proprio '.json'
    // ("tipoDocumento"/"tipoAllegato"). Restano quelli dei Contratti, unico
    // caso oggi esistente: e' il controller (TipoDocumentoRisolto/
    // TipoAllegatoRisolto) a dare la precedenza al template quando lo
    // dichiara — l'Incarico di Massima lo fa nel proprio '.json' sidecar,
    // qui non serve alcun riconoscimento esplicito.
    FFirmaElettronicaController.TipoAllegato := 'Contratto';
    FFirmaElettronicaController.TipoDocumento := TFirmaTipoDoc.ftContratto.ToString; // 'CON'

    // flusso contratti: la pratica nasce in approvazione interna ('I');
    // approvazione e invio avvengono poi da dmContratti (coi firmatari
    // risolti dai dati vivi al momento dell'invio)
    FFirmaElettronicaController.FirmaConApprovazioneInterna := true;

    // alcune risorse vogliono il contratto su carta: e' scritto nella loro
    // anagrafica (RISORSE.FIRMA_ELETTRONICA). Non e' una caratteristica del
    // documento, quindi il motore documentale non la conosce e la chiede qui.
    // Su quelle risorse il bottone Firma resta visibile ma disabilitato, con
    // il motivo scritto accanto.
    FFirmaElettronicaController.OnAzioneAmmessa := function(Azione: TzAzioneDocumento; const Contesto: TzDocumentoContesto; out Motivo: string): Boolean
      begin
        result := true;

        if Azione <> adFirma then
          exit;

        if not FirmaElettronicaAmmessa(Contesto.Oid, FFirmaElettronicaController.TipoDocumentoRisolto(Contesto)) then
        begin
          Motivo := 'Questa risorsa richiede il contratto cartaceo';
          result := false;
        end;
      end;
  end;

  result := FFirmaElettronicaController;
end;

function TCommon.FirmaElettronicaAmmessa(Oid: Int64; const TipoDocumento: string): Boolean;
begin
  // il controller interroga questo metodo a ogni aggiornamento delle azioni
  // della barra, cioe' molte volte al secondo: senza memoria del valore
  // sarebbe una lettura sul database a ogni giro
  // Mantis #254 - 2026-10-18: la memoria dell'esito scade e distingue il tipo documento, il flag Firma elettronica della risorsa si recepisce senza riavviare
  // Mantis #254 - 2026-10-26: memoria dell'esito con TzMemoriaConScadenza
  // (se la lettura solleva un'eccezione non si memorizza niente)
  result := FMemoriaFirma.Ottieni(Oid, TipoDocumento,
    function: Boolean
    var
      sp: TSP_OBJ_FILES_FIRMA_CONTRATTI_AMMESSA;
    begin
      sp := GetSP<TSP_OBJ_FILES_FIRMA_CONTRATTI_AMMESSA>();
      try
        sp.Oid := Oid;
        sp.Tipo_Documento := TipoDocumento;
        sp.ExecuteWithoutCommit;
        result := sp.Firma_Elettronica.Value;
      finally
        FreeAndNil(sp);
      end;
    end);
end;

function TCommon.PecBridge: TDocumentazioneBridgeMessaggi;
begin
  if not Assigned(DocumentazioneBridgeMessaggi) then
  begin
    DocumentazioneBridgeMessaggi := TDocumentazioneBridgeMessaggi.Create(Self);
    DocumentazioneBridgeMessaggi.IdTenant := EnteDefault;
  end;

  result := DocumentazioneBridgeMessaggi;
end;

function TCommon.ProtocolloBridge: TDocumentazioneBridgeProtocollo;
begin
  if not Assigned(DocumentazioneBridgeProtocollo) then
  begin
    DocumentazioneBridgeProtocollo := TDocumentazioneBridgeProtocollo.Create(Self);
    DocumentazioneBridgeProtocollo.IdTenant := EnteDefault;
  end;

  result := DocumentazioneBridgeProtocollo;
end;

function TCommon.ConservazioneBridge: TDocumentazioneBridgeConservazione;
begin
  if not Assigned(DocumentazioneBridgeConservazione) then
  begin
    DocumentazioneBridgeConservazione := TDocumentazioneBridgeConservazione.Create(Self);
    DocumentazioneBridgeConservazione.IdTenant := EnteDefault;
  end;

  result := DocumentazioneBridgeConservazione;
end;

procedure TCommon.FirmaElettronica_InitReportsManager(ReportsManager: TzReportsManager);
begin
  ReportsManager.ActionsController := FirmaElettronicaController;

  // l'OID (l'incarico) si risolve al momento dell'azione, dalla riga
  // selezionata: stesso comportamento del meccanismo storico
  // ReportsManager.OnGetOid := function: Int64
  // var
  // DataSet: TzFbDataSet;
  // begin
  // result := 0;
  // DataSet := ReportsManager.SelectedDataSet;
  // if Assigned(DataSet) then
  // if not DataSet.IsEmpty then
  // result := DataSet.FieldByName('ID_INCARICO').AsInteger;
  // end;

  ReportsManager.OnGetVariable := function(VariableName: string): variant
    var
      varName: string;
    begin
      result := null;

      varName := VariableName.Replace('@hidden', '', [rfIgnoreCase]);

      if varName.StartsWith('Direttore_', true) then
        result := '[[!' + varName + ':signer1:signature(sigType="AutomaticRemoteSignature "):label("Firma"):size(width=150,height=60)]]'
      else
        if varName.StartsWith('LegaleRappr_', true) then
          result := '[[!' + varName + ':signer2:signature(sigType="AutomaticRemoteSignature "):label("Firma"):size(width=150,height=60)]]'
        else
          if varName.StartsWith('Docente_', true) then
            result := '{{sig req=1,fd=Il collaboratore per accettazione, fna=' + varName + '}}';
    end;
end;

procedure TCommon.AssegnaVariabiliTimeReport(ReportsManager: TzReportsManager; IdRisorsa, IdIncarico: integer; DataSet: TzFbDataSet);
begin
  ReportsManager.AddVariable('TimeReport_ID_Personale', IdRisorsa);
  ReportsManager.AddVariable('TimeReport_ID_Incarico', IdIncarico);

  if Assigned(DataSet) and not DataSet.IsEmpty then
  begin
    ReportsManager.AddVariable('TimeReport_ID_Progetto', DataSet.FieldByName('ID_PROGETTO').AsInteger);

    if DataSet.FieldExists('DATA_INIZIO_INCARICO') then
    begin
      ReportsManager.AddVariable('TimeReport_Dal_Giorno', DataSet.FieldByName('DATA_INIZIO_INCARICO').Value);
      ReportsManager.AddVariable('TimeReport_Al_Giorno', DataSet.FieldByName('DATA_FINE_INCARICO').Value);
    end
    else
      if DataSet.FieldExists('DATA_INIZIO_PROGETTO') then
      begin
        ReportsManager.AddVariable('TimeReport_Dal_Giorno', DataSet.FieldByName('DATA_INIZIO_PROGETTO').Value);
        ReportsManager.AddVariable('TimeReport_Al_Giorno', DataSet.FieldByName('DATA_FINE_PROGETTO').Value);
      end
      else
      begin
        ReportsManager.AddVariable('TimeReport_Dal_Giorno', null);
        ReportsManager.AddVariable('TimeReport_Al_Giorno', null);
      end;
  end
  else
  begin
    ReportsManager.AddVariable('TimeReport_ID_Progetto', -1);
    ReportsManager.AddVariable('TimeReport_Dal_Giorno', null);
    ReportsManager.AddVariable('TimeReport_Al_Giorno', null);
  end;
end;

end.
