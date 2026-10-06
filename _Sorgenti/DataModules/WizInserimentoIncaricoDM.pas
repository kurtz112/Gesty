unit WizInserimentoIncaricoDM;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Dialogs,
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
  frxClass,
  frxDBSet,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdExplicitTLSClientServerBase,
  IdMessageClient,
  IdSMTPBase,
  IdSMTP,
  dbMaster,
  Base_DataModule,
  zFbDataSet,
  zDbViewDlg,
   zProgressBox,
  zDbCardDlg,
  zBaseLib,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

type
  TWizInserimentoIncarico = class(TBaseDataModule)
    IncaricoSrc: TDataSource;
    Incarico: TzFbDataSet;
    PianiSrc: TDataSource;
    Piani: TzFbDataSet;
    ServiziSrc: TDataSource;
    Servizi: TzFbDataSet;
    lkStudentiDlg: TzDbViewDlg;
    lkStudenti: TzFbDataSet;
    lkServizi: TzFbDataSet;
    lkServiziDlg: TzDbViewDlg;
    RiepilogoSrc: TDataSource;
    Riepilogo: TzFbDataSet;
    CorsiSrc: TDataSource;
    Corsi: TzFbDataSet;
    cardNuovoCorso: TzDbCardDlg;
    lkProgettiCorsi: TzFbDataSet;
    cardNuovoProgetto: TzDbCardDlg;
    NuovoProgetto: TzFbDataSet;
    procedure IncaricoAfterCreateFields(DataSet: TDataSet);
    procedure IncaricoAfterPost(DataSet: TDataSet);
    procedure IncaricoBeforeOpen(DataSet: TDataSet);
    procedure AggiornaRiepilogo(DataSet: TDataSet);
    procedure CorsiNewRecord(DataSet: TDataSet);
    procedure IncaricoAfterInsert(DataSet: TDataSet);
    procedure IncaricoAfterOpen(DataSet: TDataSet);
    procedure IncaricoBeforePost(DataSet: TDataSet);
    procedure NuovoProgettoNewRecord(DataSet: TDataSet);
  private
    FDataFine: TDateTime;
    FDataInizio: TDateTime;
    FIdIncarico: integer;
    FIdOrario: integer;
    FIdPersonale: integer;
    FIdProgetto: integer;
    FIdCorso: integer;
    FMateria: string;
    FTipoIncarico: String;
    FTotaleOreAttribuite: double;
  private
    function GetCorsiVisible: boolean;
    function GetPipVisible: boolean;
  private
    procedure DataChange(Sender: TField);
    procedure CollaboratoreChange(Sender: TField);
    procedure RicalcolaImporti(Sender: TField);
  private
    function SuperamentoLimiteOccasionali: boolean;
  private
    function GetCostoEnte: currency;
  protected
    procedure CalcolaInquadramento;
  public
    constructor Create(aOwner: TComponent); override;

    procedure InsertIncarico(const aIdPersonale: integer = -1; const IdProgetto: integer = -1; const DataInizio: TDateTime = 0; const DataFine: TDateTime = 0; const TipoIncarico: string = ''; const Materia: string = '';
      const TotaleOreAttribuite: double = 0);

    procedure InsertIncaricoDaOrario(const aIdOrario: integer); //
    procedure InserimentoDaASR(const IdProgetto: integer = -1; const IdCorso: integer = -1; const TotaleOreAttribuite: double = 0);

    procedure RettificaIncarico(const aIdIncarico: integer); //
    procedure DuplicaIncarico(const aIdIncarico: integer);
    function ConfermaAnnulla: boolean;
    function ConfermaChiusura: boolean;
    function GetRiepilogo: string;

    procedure StampaIncarico;
    procedure InviaMailOccasionali;
    procedure InviaMailNotifica;
    function CreaNuovoCorso: integer;
  public
    procedure AggiungiStudenti;
    procedure AggiungiServizi;
    procedure AggiungiPIP(const IdPianoPersonalizzato: integer; const Identificativo: string);
  public
    procedure VerificaIncarico(const VerificaCorsi: boolean);
    function VerificaCV: boolean;

    procedure InitLookupCorso(DataSet: TzFbDataSet);
    procedure LookupCorsoBeforeOpen(DataSet: TDataSet);

    function InserisciNuovoProgetto: integer;
  public
    property IdIncarico: integer read FIdIncarico;
    property IdPersonale: integer read FIdPersonale;
    property IdProgetto: integer read FIdProgetto;
    property IdCorso: integer read FIdCorso;
    property DataInizio: TDateTime read FDataInizio;
    property DataFine: TDateTime read FDataFine;
    property TipoIncarico: String read FTipoIncarico write FTipoIncarico;
    property Materia: string read FMateria write FMateria;
    property TotaleOreAttribuite: double read FTotaleOreAttribuite write FTotaleOreAttribuite;
    property IdOrario: integer read FIdOrario;
    property PipVisible: boolean read GetPipVisible;
    property CorsiVisible: boolean read GetCorsiVisible;
  end;

var
  WizInserimentoIncarico: TWizInserimentoIncarico;

implementation

uses
  System.Math,
  Vcl.Forms,
  ConfigModule,
  Gesty_StoredProcs,
  zOffice,
  zOffice.types,
  zOffice.Mail.Utils,
   
  dmCommon,
  zMsg,
  Vcl.Clipbrd;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

constructor TWizInserimentoIncarico.Create(aOwner: TComponent);
begin
  inherited;
  FIdIncarico := -1;
  FIdPersonale := -1;
  FIdOrario := -1;
  FIdProgetto := -1;
  FIdCorso := -1;
  FDataInizio := nulldate;
  FDataFine := nulldate;
  FTipoIncarico := '';
  FMateria := '';
  FTotaleOreAttribuite := 0;

  SetAutoCommit(false);
end;

function TWizInserimentoIncarico.ConfermaAnnulla: boolean;
begin
  // Rollback(false, true); No, lo fa già BaseDataModule
  result := true;
end;

function TWizInserimentoIncarico.ConfermaChiusura: boolean;
begin
  result := false;

  if SuperamentoLimiteOccasionali then
    if not ConfirmYesNo('Superato il limite annuo per incarichi occasionali.' + sLineBreak + 'Si desidera inserire ugualmente l''incarico?', mtConfirmation) then
      exit;

  VerificaIncarico(true);
  VerificaCV;

  // generare il collegato?

  Commit;
  result := true;
end;

function TWizInserimentoIncarico.GetCostoEnte: currency;
var
  sp: TSP_risorse_Calcola_Costo_Ente;
  Id_Personale, DataInizioIncarico, Compenso_Orario_Lordo: TField;
begin
  result := 0;

  Id_Personale := Incarico.FieldByName('ID_RISORSA');
  DataInizioIncarico := Incarico.FieldByName('DATA_INIZIO_INCARICO');
  Compenso_Orario_Lordo := Incarico.FieldByName('COMPENSO_ORARIO_LORDO');

  if Id_Personale.Isnull or DataInizioIncarico.Isnull or Compenso_Orario_Lordo.Isnull then
    exit;

  try
    sp := TSP_risorse_Calcola_Costo_Ente.Create(WriteTrans);
    try
      sp.Id_Risorsa := Id_Personale.asLargeInt;
      sp.Data_Inizio_Incarico := DataInizioIncarico.AsDateTime;
      sp.Compenso_Orario_Lordo := Compenso_Orario_Lordo.AsCurrency;
      sp.ExecuteWithoutCommit;

      if sp.Costo_Orario_Ente.Isnull then
        result := 0
      else
        result := sp.Costo_Orario_Ente;
    finally
      FreeAndNil(sp);
    end;
  except
    on e: exception do
    begin
      ConfirmOk(e.Message);
    end;
  end;
end;

procedure TWizInserimentoIncarico.IncaricoAfterPost(DataSet: TDataSet);
begin
  inherited;
  if IdIncarico = -1 then
    FIdIncarico := Incarico.FieldByName('ID_INCARICO').asLargeInt;

  AggiornaRiepilogo(nil);
end;

procedure TWizInserimentoIncarico.IncaricoBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if Incarico.ParamExists('ID_INCARICO') then
    Incarico.ParamByName('ID_INCARICO').asLargeInt := IdIncarico;
end;

procedure TWizInserimentoIncarico.InitLookupCorso(DataSet: TzFbDataSet);
begin
  // chiamato dalla form in cardCorsiAfterCreateControls

  DataSet.BeforeOpen := LookupCorsoBeforeOpen;
  SetAutoCommit(DataSet, false);
end;

procedure TWizInserimentoIncarico.InsertIncarico(const aIdPersonale: integer = -1; const IdProgetto: integer = -1; const DataInizio: TDateTime = 0; const DataFine: TDateTime = 0; const TipoIncarico: string = ''; const Materia: string = '';
  const TotaleOreAttribuite: double = 0);
begin
  FIdPersonale := aIdPersonale;
  FIdProgetto := IdProgetto;
  FDataInizio := DataInizio;
  FDataFine := DataFine;
  FTipoIncarico := TipoIncarico;
  FMateria := Materia;
  FTotaleOreAttribuite := TotaleOreAttribuite;
  OpenDataSets;
  Incarico.Insert;
end;

procedure TWizInserimentoIncarico.InsertIncaricoDaOrario(const aIdOrario: integer);
begin
  FIdOrario := aIdOrario;
  OpenDataSets;
  Incarico.Insert;
end;

function TWizInserimentoIncarico.GetCorsiVisible: boolean;
var
  field: TField;
begin
  result := false;

  field := Incarico.FindField('CORSI_MULTIPLI');

  if Assigned(field) then
    result := field.asBoolean;
end;

function TWizInserimentoIncarico.GetPipVisible: boolean;
var
  field: TField;
begin
  result := false;

  field := Incarico.FindField('PIANI_PERSONALIZZATI');

  if Assigned(field) then
    result := field.asBoolean;
end;

procedure TWizInserimentoIncarico.IncaricoAfterCreateFields(DataSet: TDataSet);
begin
  inherited;
  Incarico.FieldByName('TOTALE_ORE_ATTRIBUITE').onChange := RicalcolaImporti;
  Incarico.FieldByName('COMPENSO_ORARIO_LORDO').onChange := RicalcolaImporti;
  Incarico.FieldByName('ID_RISORSA').onChange := CollaboratoreChange;
  Incarico.FieldByName('DATA_INIZIO_INCARICO').onChange := DataChange;
  Incarico.FieldByName('DATA_FINE_INCARICO').onChange := DataChange;
end;

procedure TWizInserimentoIncarico.DataChange(Sender: TField);
begin
  if not Incarico.FieldByName('DATA_INIZIO_INCARICO').Isnull then
    if not Incarico.FieldByName('DATA_FINE_INCARICO').Isnull then
    begin
      if Incarico.FieldByName('DATA_INIZIO_INCARICO').Value > Incarico.FieldByName('DATA_FINE_INCARICO').Value then
        raise exception.Create('Intervallo date non valido.');

      RicalcolaImporti(nil);
      CalcolaInquadramento;
    end;
end;

procedure TWizInserimentoIncarico.CollaboratoreChange(Sender: TField);
begin
  RicalcolaImporti(nil);
end;

procedure TWizInserimentoIncarico.DuplicaIncarico(const aIdIncarico: integer);
  procedure ClearIdIncarico;
  var
    field: TField;
  begin
    // DoOnNewRecord assegna il parametro al campo
    field := Incarico.FieldByName('ID_INCARICO');
    field.ReadOnly := false;
    field.Value := -1;
    field.ReadOnly := true;
  end;

begin
  FIdPersonale := -1;
  FIdIncarico := aIdIncarico;
  OpenDataSets;
  Incarico.DuplicateRecord(false, 'ID_INCARICO;ID_ESTENSORE_RICHIESTA;TIPO_VERIFICA;DATA_VERIFICA;DATA_AUTORIZZAZIONE;DATA_PROTOCOLLO;NUMERO_PROTOCOLLO');
  ClearIdIncarico;
  FIdIncarico := -1;
end;

procedure TWizInserimentoIncarico.RicalcolaImporti(Sender: TField);
begin
  Incarico.FieldByName('COSTO_ORARIO_ENTE').Value := GetCostoEnte;
end;

function TWizInserimentoIncarico.GetRiepilogo: string;
var
  StringList: TStringList;
begin
  result := '';

  StringList := TStringList.Create;
  try
    StringList.Add('Id Incarico: ' + Incarico.FieldByName('ID_INCARICO').AsString);
    StringList.Add('Collaboratore: ' + Incarico.FieldByName('NOMINATIVO_O_RAGIONE_SOCIALE').AsString);
    StringList.Add('Progetto: ' + Incarico.FieldByName('DENOMINAZIONE_PROGETTO').AsString);
    StringList.Add('Tipo Incarico: ' + Incarico.FieldByName('TIPO_INCARICO').AsString);
    StringList.Add('Totale Ore: ' + Incarico.FieldByName('TOTALE_ORE_ATTRIBUITE').AsString);
    result := StringList.Text;
  finally
    FreeAndNil(StringList);
  end;
end;

procedure TWizInserimentoIncarico.StampaIncarico;
var
  WasActive: boolean;
begin

  if Config.ExecBooleanFunc('CURRENT_USER_STAMPA_AUTOMATICA_INCARICO') then
  begin
    WasActive := Incarico.active;
    Incarico.Reopen(true);
    try
      ReportsManager.SharedReports.Add('Incarico');
      ReportsManager.Print('Incarico');
    finally
      Incarico.active := WasActive;
    end;
  end;
end;

function TWizInserimentoIncarico.VerificaCV: boolean;
var
  sp: TSP_ESISTE_CV;
  esiste: boolean;
begin
  result := true;

  if not Config.ExecBooleanFunc('CURRENT_USER_VERIFICA_PRESENZA_CURRICULUM') then
    exit;

  sp := TSP_ESISTE_CV.Create(WriteTrans);
  try
    sp.Id_Risorsa := Incarico.FieldByName('ID_RISORSA').asLargeInt;
    sp.Data_Inizio_Incarico := Incarico.FieldByName('DATA_INIZIO_INCARICO').AsDateTime;
    sp.ExecuteWithoutCommit;
    esiste := sp.esiste.Value;
  finally
    FreeAndNil(sp);
  end;

  if not esiste then
    result := ConfirmYesNo('Curriculum vitae non trovato per l''anno formativo. ' + #13#10 + 'Si desidera continuare? ', mtWarning);
end;

procedure TWizInserimentoIncarico.VerificaIncarico(const VerificaCorsi: boolean);
var
  sp: TSP_INCARICO_VERIFICA;
begin
  if IdIncarico = -1 then
    exit;

  Incarico.CheckBrowseMode;
  Corsi.CheckBrowseMode;

  sp := TSP_INCARICO_VERIFICA.Create(WriteTrans);
  try
    sp.ID_INCARICO := IdIncarico;
    sp.Verifica_Corsi := VerificaCorsi;
    sp.ExecuteWithoutCommit;
  finally
    FreeAndNil(sp);
  end;
end;

function TWizInserimentoIncarico.SuperamentoLimiteOccasionali: boolean;
var
  sp: TSP_INCARICHI_SUPERATO_LIMITE_X_OCCASIONALI;
begin
  result := false;

  Incarico.CheckBrowseMode;

  sp := GetSP<TSP_INCARICHI_SUPERATO_LIMITE_X_OCCASIONALI>;
  try
    sp.ID_INCARICO := IdIncarico;
    sp.ExecuteWithoutCommit;
    result := sp.Limite_Superato;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TWizInserimentoIncarico.AggiornaRiepilogo(DataSet: TDataSet);
begin
  inherited;
  Riepilogo.Reopen(true);
end;

procedure TWizInserimentoIncarico.IncaricoBeforePost(DataSet: TDataSet);
begin
  inherited;

  if Incarico.FieldByName('SUPPLENZA').asBoolean = true then
    Incarico.FieldByName('QUESTIONARIO_SODDISFAZ_UTENTI').asBoolean := false;

  // se l'utente non è abilitato a vedere i parametri di budget arriverà come null
  if Incarico.FieldByName('PARAMETRO_RICAVO_SPECIFICO').Isnull = true then
    Incarico.FieldByName('PARAMETRO_RICAVO_SPECIFICO').Value := 0;
end;

procedure TWizInserimentoIncarico.RettificaIncarico(const aIdIncarico: integer);
begin
  FIdPersonale := -1;
  FIdIncarico := aIdIncarico;
  OpenDataSets;
  Incarico.Edit;
end;

procedure TWizInserimentoIncarico.InviaMailNotifica;
begin
  { TODO : Implementare: Invio Mail Notifica }
end;

procedure TWizInserimentoIncarico.InviaMailOccasionali;
var
  sp: TSP_GET_MAIL_INCARICHI_OCCASIONALI;
  Mail: TMail;
  zViewerMailWriter: TzOfficeMailWriter;
  SMTPServerParams: TSMTPServerParams;
begin
  // if not Config.zSystem.SettingExists('EVITA_INVIO_MAIL_OCCASIONALI') then

  SMTPServerParams.Init;
  Mail.Init;

  sp := TSP_GET_MAIL_INCARICHI_OCCASIONALI.Create(WriteTrans);
  try
    sp.ID_INCARICO := IdIncarico;
    sp.ExecuteWithoutCommit;

    if sp.Is_Occasionale.Value = false then
      exit;

    Mail.A := sp.EMail_Incarichi_Occasionali.Value;
    Mail.oggetto := sp.oggetto;
    Mail.CorpoTxt := sp.body.Text;

    SMTPServerParams.From := sp.FROM_RISORSA;
    SMTPServerParams.FromAddress := sp.EMAIL_FROM_ADDRESS;
    SMTPServerParams.ReplyTo := sp.EMAIL_REPLAY_TO;
    SMTPServerParams.ReceiptRecipient := sp.EMAIL_CONFERMA_LETTURA;
    SMTPServerParams.Host := sp.Smtp_Host;
    SMTPServerParams.Port := sp.Smtp_Port;
    SMTPServerParams.UserName := sp.Smtp_UserName;
    SMTPServerParams.Password := sp.Smtp_Password;
    SMTPServerParams.AuthenticationType := sp.Authentication_Type;
    SMTPServerParams.ssl := sp.ssl;
    SMTPServerParams.ssl_ver := sp.ssl_ver;
  finally
    FreeAndNil(sp);
  end;

  /// !!!!!!!!!!!!!!!!!!!!!!!
  if not SMTPServerParams.IsValid then
  begin
    ConfirmOk('Parametri SMTP non configurati.');
    exit;
  end;

  zViewerMailWriter := TzOfficeMailWriter.Create(Self);
  try
    zViewerMailWriter.SendMail(Mail, SMTPServerParams);
  finally
    FreeAndNil(zViewerMailWriter);
  end;
end;

procedure TWizInserimentoIncarico.CorsiNewRecord(DataSet: TDataSet);
begin
  inherited;

  if IdCorso <> -1 then
    Corsi.FieldByName('ID_CORSO').Value := IdCorso;

  Corsi.FieldByName('ID_INCARICO').Value := Incarico.FieldByName('ID_INCARICO').Value;
  Corsi.FieldByName('ID_PROGETTO').Value := Incarico.FieldByName('ID_PROGETTO').Value;
  Corsi.FieldByName('DATA_INIZIO_CORSO').Value := Incarico.FieldByName('DATA_INIZIO_INCARICO').Value;
  Corsi.FieldByName('DATA_FINE_CORSO').Value := Incarico.FieldByName('DATA_FINE_INCARICO').Value;
  Corsi.FieldByName('ORE_ATTRIBUITE_CORSO').Value := Incarico.FieldByName('TOTALE_ORE_ATTRIBUITE').Value;
end;

procedure TWizInserimentoIncarico.LookupCorsoBeforeOpen(DataSet: TDataSet);
var
  zDbDataSet: TzFbDataSet;
begin

  // chiamato dal Wizard
  if Incarico.FieldExists('ID_PROGETTO') then // in chiusura dei dataset vengono distrutti
  begin
    zDbDataSet := TzFbDataSet(DataSet);
    zDbDataSet.ParamByName('ID_PROGETTO').asLargeInt := Incarico.FieldByName('ID_PROGETTO').asLargeInt;
  end;
end;

function TWizInserimentoIncarico.CreaNuovoCorso: integer;
begin
  result := -1;

  if Incarico.FieldByName('ID_PROGETTO').Isnull then
  begin
    ConfirmOk('Nessun progetto selezionato.');
    exit;
  end;

  cardNuovoCorso.DataSet := lkProgettiCorsi;

  lkProgettiCorsi.RevertSQL(false);
  lkProgettiCorsi.ParamByName('ID_PROGETTO').asLargeInt := Incarico.FieldByName('ID_PROGETTO').asLargeInt;
  lkProgettiCorsi.active := true;
  try
    lkProgettiCorsi.Append;
    lkProgettiCorsi.FieldByName('ID_PROGETTO').asLargeInt := Incarico.FieldByName('ID_PROGETTO').asLargeInt;
    lkProgettiCorsi.FieldByName('DATA_INIZIO_CORSO').Value := Incarico.FieldByName('DATA_INIZIO_INCARICO').Value;
    lkProgettiCorsi.FieldByName('DATA_FINE_CORSO').Value := Incarico.FieldByName('DATA_FINE_INCARICO').Value;

    if cardNuovoCorso.Execute then
    begin
      result := lkProgettiCorsi.FieldByName('ID_CORSO').asLargeInt;

      Corsi.CheckEditMode;
      Corsi.FieldByName('ID_CORSO').asLargeInt := lkProgettiCorsi.FieldByName('ID_CORSO').asLargeInt;
    end;
  finally
    lkProgettiCorsi.active := false;
  end;
end;

procedure TWizInserimentoIncarico.IncaricoAfterInsert(DataSet: TDataSet);
var
  IdInquadramento: integer;
  TipoContratto: string;
  sp: TSP_ORARIO_GET_PARAMS_PER_INCARICO;
begin
  inherited;
  Incarico.FieldByName('ID_ESTENSORE_RICHIESTA').asLargeInt := -1;

  if IdPersonale <> -1 then
    Incarico.FieldByName('ID_RISORSA').asLargeInt := IdPersonale;

  // pasasto a default per codebri
  // Incarico.FieldByName('DATA_RICHIESTA').AsDateTime := date;

  if IdProgetto <> -1 then
    Incarico.FieldByName('ID_PROGETTO').asLargeInt := IdProgetto;

  if DataInizio <> nulldate then
    Incarico.FieldByName('DATA_INIZIO_INCARICO').AsDateTime := DataInizio;

  if DataFine <> nulldate then
    Incarico.FieldByName('DATA_FINE_INCARICO').AsDateTime := DataFine;

  if not TipoIncarico.isempty then
    Incarico.FieldByName('TIPO_INCARICO').AsString := TipoIncarico;

  if not Materia.isempty then
    Incarico.FieldByName('MATERIA').AsString := Materia;

  if TotaleOreAttribuite > 0 then
    Incarico.FieldByName('TOTALE_ORE_ATTRIBUITE').Value := TotaleOreAttribuite;

  if IdOrario <> -1 then
  begin
    sp := TSP_ORARIO_GET_PARAMS_PER_INCARICO.Create(WriteTrans);
    try
      sp.Id_Orario := IdOrario;
      sp.ExecuteWithoutCommit;

      Incarico.FieldByName('ID_PROGETTO').Value := sp.Id_Progetto;
      Incarico.FieldByName('DENOMINAZIONE_PROGETTO').Value := sp.Denominazione_Progetto;
      Incarico.FieldByName('CODICE_REGIONALE').Value := sp.Codice_Regionale;
      Incarico.FieldByName('PIANI_PERSONALIZZATI').Value := sp.Piani_Personalizzati;
      Incarico.FieldByName('ID_RISORSA').Value := sp.Id_Docente;

      if sp.Materia.HasValue then
        Incarico.FieldByName('MATERIA').Value := sp.Materia
      else
        Incarico.FieldByName('MATERIA').Clear;

      Incarico.FieldByName('DATA_INIZIO_INCARICO').Value := sp.Data_Lezione;
      Incarico.FieldByName('DATA_FINE_INCARICO').Value := sp.Data_Lezione;
      Incarico.FieldByName('TOTALE_ORE_ATTRIBUITE').Value := sp.TOTALE_ORE_ATTRIBUITE;

      Incarico.FieldByName('SUPPLENZA').Value := sp.Supplenza;
      { TODO : CORSI Gestire il parametro ID_CORSO }
    finally
      FreeAndNil(sp);
    end
  end;

  /// //
  CalcolaInquadramento;
end;

procedure TWizInserimentoIncarico.IncaricoAfterOpen(DataSet: TDataSet);
begin
  inherited;

  // codebri
  Common.CustomizeDataSet('Incarico', Incarico);
end;

function TWizInserimentoIncarico.InserisciNuovoProgetto: integer;
begin
  result := -1;

  NuovoProgetto.active := true;
  try
    cardNuovoProgetto.DataSet := NuovoProgetto;

    NuovoProgetto.Append;

    if cardNuovoProgetto.Execute then
    begin
      NuovoProgetto.CheckBrowseMode;
      result := NuovoProgetto.FieldByName('ID_PROGETTO').AsInteger;
    end;

  finally
    NuovoProgetto.active := false;
  end;
end;

procedure TWizInserimentoIncarico.NuovoProgettoNewRecord(DataSet: TDataSet);
var
  Ente, Sede: integer;
  Raggruppamento: string;
begin
  inherited;
  Common.GetEnteAndSedeDefault(Ente, Sede, Raggruppamento);
  DataSet.FieldByName('ID_ENTE').Value := Ente;
  DataSet.FieldByName('ID_SEDE').Value := Sede;
  DataSet.FieldByName('QUESTIONARI_RAGGRUPPAMENTI').Value := Raggruppamento;
  DataSet.FieldByName('ANNO_FORMATIVO').Value := Common.AnnoFormativoCorrente;
end;

procedure TWizInserimentoIncarico.CalcolaInquadramento;
var
  sp: TSP_risorse_Get_Inquadramento;
  idRisorsa: integer;
  DataInizioIncarico: TDateTime;
  idInquadramentoAttuale: integer;
begin

  if Incarico.FieldByName('ID_RISORSA').Isnull then
    exit;

  if Incarico.FieldByName('DATA_INIZIO_INCARICO').Isnull then
    exit;

  idRisorsa := Incarico.FieldByName('ID_RISORSA').AsInteger;
  if idRisorsa = -1 then
    exit;

  DataInizioIncarico := Incarico.FieldByName('DATA_INIZIO_INCARICO').AsDateTime;

  idInquadramentoAttuale := -1;
  if not Incarico.FieldByName('ID_INQUADRAMENTO').Isnull then
    idInquadramentoAttuale := Incarico.FieldByName('ID_INQUADRAMENTO').Value;

  /// //

  sp := TSP_risorse_Get_Inquadramento.Create(WriteTrans);
  try
    sp.Id_Risorsa := idRisorsa;
    sp.Data_Inizio_Incarico := DataInizioIncarico;
    sp.Id_Inquadramento_Attuale := idInquadramentoAttuale;

    sp.ExecuteWithoutCommit;

    if (not sp.Id_Inquadramento.Isnull) and (sp.Id_Inquadramento.Value <> -1) then
    begin
      Incarico.FieldByName('ID_INQUADRAMENTO').Value := sp.Id_Inquadramento;
      Incarico.FieldByName('TIPO_CONTRATTO').AsString := sp.Tipo_Contratto;
    end
    else
    begin
      Incarico.FieldByName('ID_INQUADRAMENTO').Clear;
      Incarico.FieldByName('TIPO_CONTRATTO').Clear;
    end;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TWizInserimentoIncarico.AggiungiStudenti;
var
  sp: TSP_INCARICHI_PIANI_PERSONALIZZATI_ADD;
begin
  lkStudenti.RevertSQL(false);
  lkStudenti.ParamByName('ID_PROGETTO').asLargeInt := Incarico.FieldByName('ID_PROGETTO').asLargeInt;
  lkStudenti.ParamByName('DATA_INIZIO').AsDateTime := Incarico.FieldByName('DATA_INIZIO_INCARICO').AsDateTime;
  lkStudenti.ParamByName('DATA_FINE').AsDateTime := Incarico.FieldByName('DATA_FINE_INCARICO').AsDateTime;
  lkStudenti.ParamByName('ID_INCARICO').asLargeInt := Incarico.FieldByName('ID_INCARICO').asLargeInt;
  lkStudenti.active := true;
  try
    sp := GetSP<TSP_INCARICHI_PIANI_PERSONALIZZATI_ADD>;
    try
      if lkStudentiDlg.Execute(
        procedure
        begin
          sp.ID_INCARICO := Incarico.FieldByName('ID_INCARICO').asLargeInt;
          sp.Id_Piano_Personalizzato := lkStudenti.FieldByName('ID_PIANO_PERSONALIZZATO').asLargeInt;
          sp.Id_Progetto := Incarico.FieldByName('ID_PROGETTO').asLargeInt;

          if lkStudenti.FieldByName('ID_CORSO').Isnull then
            sp.Id_Corso := -1
          else
            sp.Id_Corso := lkStudenti.FieldByName('ID_CORSO').asLargeInt;

          sp.ExecuteWithoutCommit;
        end) then
      begin
        Piani.Reopen;
        AggiornaRiepilogo(nil);
      end;
    finally
      FreeAndNil(sp);
    end;

  finally
    lkStudenti.active := false;
  end;
end;

procedure TWizInserimentoIncarico.AggiungiServizi;
begin

  if Piani.isempty then
    exit;

  lkServizi.RevertSQL(false);
  lkServizi.ParamByName('ID_PIANO_PERSONALIZZATO').asLargeInt := Piani.FieldByName('ID_PIANO_PERSONALIZZATO').asLargeInt;
  lkServizi.ParamByName('ID_PROGETTO').asLargeInt := Piani.FieldByName('ID_PROGETTO').asLargeInt;
  lkServizi.ParamByName('DATA_INIZIO').AsDateTime := Incarico.FieldByName('DATA_INIZIO_INCARICO').AsDateTime;
  lkServizi.ParamByName('DATA_FINE').AsDateTime := Incarico.FieldByName('DATA_FINE_INCARICO').AsDateTime;
  lkServizi.ParamByName('ID_INCARICO').asLargeInt := Incarico.FieldByName('ID_INCARICO').asLargeInt;

  lkServizi.active := true;
  try
    lkServiziDlg.Execute(
      procedure
      begin
        Servizi.Append;
        Servizi.FieldByName('ID_INCARICO').asLargeInt := Piani.FieldByName('ID_INCARICO').asLargeInt;
        Servizi.FieldByName('ID_PIANO_PERSONALIZZATO').asLargeInt := Piani.FieldByName('ID_PIANO_PERSONALIZZATO').asLargeInt;
        Servizi.FieldByName('SERVIZIO_EROGATO').AsString := lkServizi.FieldByName('SERVIZIO_EROGATO').AsString;
        Servizi.FieldByName('ORE_PIP').AsFloat := 1;
        Servizi.Post;
      end);
  finally
    lkServizi.active := false;
  end;
end;

procedure TWizInserimentoIncarico.AggiungiPIP(const IdPianoPersonalizzato: integer; const Identificativo: string);
var
  sp: TSP_INCARICHI_PIANI_PERSONALIZZATI_ADD;
begin

  if IdPianoPersonalizzato = -1 then
    exit;

  sp := GetSP<TSP_INCARICHI_PIANI_PERSONALIZZATI_ADD>;
  try
    sp.ID_INCARICO := Incarico.FieldByName('ID_INCARICO').asLargeInt;
    sp.Id_Piano_Personalizzato := IdPianoPersonalizzato;
    sp.Id_Progetto := Incarico.FieldByName('ID_PROGETTO').asLargeInt;
    sp.Id_Corso := -1;
    sp.ExecuteWithoutCommit;
    Piani.Reopen;
    AggiornaRiepilogo(nil);
  finally
    FreeAndNil(sp);
  end;
end;

procedure TWizInserimentoIncarico.InserimentoDaASR(const IdProgetto: integer = -1; const IdCorso: integer = -1; const TotaleOreAttribuite: double = 0);
begin
  FIdProgetto := IdProgetto;
  FIdCorso := IdCorso;
  FTotaleOreAttribuite := TotaleOreAttribuite;
  OpenDataSets;
  Incarico.Insert;
end;

end.zdbcard zFbDataSet
