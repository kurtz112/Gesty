unit dmScheduler.Tools;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Actions,
  Vcl.Dialogs,
  Vcl.ActnList,
  Vcl.Forms,
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
  cxSchedulerDBStorage,
  cxSchedulerStorage,
  cxClasses,
  cxScheduler,
  cxSchedulerHolidays,
  dxShellDialogs,
  cxSchedulerCustomControls,
  Base_DataModule,
  dbMaster,
  zFbDataSet,
  zDbCardDlg,
  Gesty.Types,
  zDbViewDlg,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

type
  TEventoParams = record
    procedure Init;
  private
    FAula: string;
    FData: TDate;
    FDurata: integer;
    Fid: integer;
    FOraFine: TTime;
    FOraInizio: TTime;
    FReadOnly: boolean;
    FResourceID: variant;
    FTipoEvento: TSchedulerTipoEvento;
    FFieldName1: string;
    FValue1: variant;
    FFieldName2: string;
    FFieldName3: string;
    FFieldName4: string;
    FFieldName5: string;
    FValue2: variant;
    FValue3: variant;
    FValue4: variant;
    FValue5: variant;
    procedure SetDurata(const Value: integer);
    procedure SetOraFine(const Value: TTime);
  public
    property TipoEvento: TSchedulerTipoEvento read FTipoEvento write FTipoEvento;
    property ReadOnly: boolean read FReadOnly write FReadOnly;
    property id: integer read Fid write Fid;
    property Data: TDate read FData write FData;
    property OraInizio: TTime read FOraInizio write FOraInizio;
    property OraFine: TTime read FOraFine write SetOraFine;
    property Durata: integer read FDurata write SetDurata;
    property Aula: string read FAula write FAula;
    property ResourceID: variant read FResourceID write FResourceID;

    property FieldName1: string read FFieldName1 write FFieldName1;
    property Value1: variant read FValue1 write FValue1;
    property FieldName2: string read FFieldName2 write FFieldName2;
    property Value2: variant read FValue2 write FValue2;
    property FieldName3: string read FFieldName3 write FFieldName3;
    property Value3: variant read FValue3 write FValue3;
    property FieldName4: string read FFieldName4 write FFieldName4;
    property Value4: variant read FValue4 write FValue4;
    property FieldName5: string read FFieldName5 write FFieldName5;
    property Value5: variant read FValue5 write FValue5;
  end;

  TSchedulerTools = class(TBaseDataModule)
    Orario: TzFbDataSet;
    cardOrario: TzDbCardDlg;
    RilevamentoOre: TzFbDataSet;
    cardRilevamento: TzDbCardDlg;
    Riunioni: TzFbDataSet;
    cardRiunioni: TzDbCardDlg;
    Agenda: TzFbDataSet;
    cardAgenda: TzDbCardDlg;
    PrenotazioneAule: TzFbDataSet;
    cardPrenotazioneAule: TzDbCardDlg;
    ElencoAule: TzFbDataSet;
    dlgElencoAule: TzDbViewDlg;
    Scadenze: TzFbDataSet;
    cardScadenze: TzDbCardDlg;
    cxSchedulerHolidays: TcxSchedulerHolidays;
    ActionList: TActionList;
    InviaMailAutorizzazioneAula: TAction;
    dxSaveFileDialog: TdxSaveFileDialog;
    FuoriSede: TzFbDataSet;
    cardFuoriSede: TzDbCardDlg;
    procedure cardPrenotazioneAuleInitDialog(Dialog: TzDbCardForm);
    procedure DataModuleCreate(Sender: TObject);
    procedure InviaMailAutorizzazioneAulaExecute(Sender: TObject);
    procedure RilevamentoOreAfterCreateFields(DataSet: TDataSet);
    procedure RilevamentoOreBeforeClose(DataSet: TDataSet);
    procedure RilevamentoOreBeforeOpen(DataSet: TDataSet);
    procedure RilevamentoOreBeforePost(DataSet: TDataSet);
    procedure RilevamentoOreCalcFields(DataSet: TDataSet);
    procedure RilevamentoOreNewRecord(DataSet: TDataSet);
  private
    DisableRilevamentoFieldChanged: boolean;
    procedure RilevamentoOreGetDettagliPresenza(DataSet: TDataSet);
    procedure RilevamentoDataChanged(Sender: TField);
    procedure RilevamentoNumeroOreChanged(Sender: TField);
    procedure RilevamentoFieldChanged(Sender: TField);
  private
    procedure OpenDataSet(DataSet: TzFbDataSet; params: TEventoParams);
  private
    function ApriAgenda(params: TEventoParams): boolean;
    function ApriOrario(params: TEventoParams): boolean;
    function ApriPrenotazioneAula(params: TEventoParams): boolean;
    function ApriRilevamento(params: TEventoParams): boolean;
    function ApriRiunione(params: TEventoParams): boolean;
    function ApriInagibilita(params: TEventoParams): boolean;
    function ApriChiusuraSede(params: TEventoParams): boolean;
    function ApriPresenzaPersonale(params: TEventoParams): boolean;
    function ApriScadenza(params: TEventoParams): boolean;
    function ApriFuoriSede(params: TEventoParams): boolean;
  private
    function UpdateOrario(params: TEventoParams): boolean;
  private
    function SpostaOrario(params: TEventoParams): boolean;
    function SpostaPrenotazioneAula(params: TEventoParams): boolean;
    function SpostaAgenda(params: TEventoParams): boolean;
    function SpostaFuoriSede(params: TEventoParams): boolean;
  private
    function EliminaAgenda(params: TEventoParams): boolean;
    function EliminaOrario(params: TEventoParams): boolean;
    function EliminaPrenotazioneAula(params: TEventoParams): boolean;
    function EliminaRilevamento(params: TEventoParams): boolean;
    function EliminaRiunione(params: TEventoParams): boolean;
    function EliminaInagibilita(params: TEventoParams): boolean;
    function EliminaChiusuraSede(params: TEventoParams): boolean;
    function EliminaPresenzaPersonale(params: TEventoParams): boolean;
    function EliminaScadenza(params: TEventoParams): boolean;
    function EliminaFuoriSede(params: TEventoParams): boolean;
  public
    function ApriEvento(params: TEventoParams): boolean;

    function UpdateEvento(params: TEventoParams): boolean;

    function SpostaEvento(params: TEventoParams): boolean;

    function EliminaEvento(params: TEventoParams): boolean;
  private
    procedure InitStorageFields(cxSchedulerDBStorage: TcxSchedulerDBStorage);
    procedure cxSchedulerDBStorageEventHandled(Sender: TObject; AEvent: TcxSchedulerEvent; var AHandled: boolean);
    procedure cxSchedulerDBStorageEventModified(Sender: TObject; AEvent: TcxSchedulerEvent; var AHandled: boolean);
    procedure cxSchedulerDBStorageEventIntersect(Sender: TcxCustomSchedulerStorage; AEvent1, AEvent2: TcxSchedulerEvent; var Allow: boolean);
  public
    procedure InitStorage(cxSchedulerDBStorage: TcxSchedulerDBStorage);

  private
    procedure ExportScheduler(Scheduler: TcxScheduler; const FileName: string; const header: string; exportEventFunc: TFunc<TcxSchedulerEvent, string>);
    procedure ExportToGoogleCalendar(Scheduler: TcxScheduler; const FileName: string);
    procedure ExportToOutlook(Scheduler: TcxScheduler; const FileName: string);
  public
    procedure ExportEvents(Scheduler: TcxScheduler);
  end;

var
  SchedulerTools: TSchedulerTools;

implementation

uses
  System.DateUtils, System.Variants, System.IOUtils, cxExportSchedulerLink,
    zDm_Images, zOffice, zOffice.types, Gesty_StoredProcs,
  WizInserimentoIncaricoFrm, dmCommon, ConfigModule, zMsg;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

type
  TcxDateNavigatorAccess = class(TcxSchedulerCustomDateNavigator);

procedure TEventoParams.Init;
begin
  FTipoEvento := teNull;
  FReadOnly := False;
  Fid := -1;
  FData := 0;
  FOraInizio := 0;
  FOraFine := 0;
  FAula := '';
  FResourceID := null;
  FFieldName1 := '';
  FValue1 := null;
  FFieldName2 := '';
  FValue2 := null;
  FFieldName3 := '';
  FValue3 := null;
  FFieldName4 := '';
  FValue4 := null;
  FFieldName5 := '';
  FValue5 := null;
end;

procedure TEventoParams.SetDurata(const Value: integer);
begin
  FDurata := Value;

  // la mezzanotte (OraInizio = 0) e' un'ora vera: prima OraFine restava 0
  FOraFine := IncMinute(OraInizio, FDurata);
end;

procedure TEventoParams.SetOraFine(const Value: TTime);
begin
  FOraFine := Value;

  // stessa regola di SetDurata: anche da mezzanotte la durata si calcola
  FDurata := MinutesBetween(OraInizio, FOraFine);
end;

procedure TSchedulerTools.DataModuleCreate(Sender: TObject);
begin
  inherited;
  DisableRilevamentoFieldChanged := False;
  ActionList.Images := zDmImages.ImageList24;
  dxSaveFileDialog.InitialDir := Config.CartellaPersonaleUtenteCorrente;
  // dxSaveFileDialog.FilterIndex :=
end;

/// ///////////////////////////////////////////////////////////////

procedure TSchedulerTools.OpenDataSet(DataSet: TzFbDataSet; params: TEventoParams);
begin
  DataSet.RevertSql(False);
  DataSet.ParamByName(params.TipoEvento.IdFieldName).AsInteger := params.id;
  DataSet.Active := true;
end;

function TSchedulerTools.ApriEvento(params: TEventoParams): boolean;
begin
  result := False;

  case params.TipoEvento of
    teOrarioLezione:
      result := ApriOrario(params);
    teOreRilevamento:
      result := ApriRilevamento(params);
    teRiunione:
      result := ApriRiunione(params);
    teAgendaPersonale:
      result := ApriAgenda(params);
    tePrenotazioneAule:
      result := ApriPrenotazioneAula(params);
    teInagibilitaAula:
      result := ApriInagibilita(params);
    teChiusuraSede:
      result := ApriChiusuraSede(params);
    tePresenzaPersonale:
      result := ApriPresenzaPersonale(params);
    teScadenza:
      result := ApriScadenza(params);
    teAttivitaFuoriSede:
      result := ApriFuoriSede(params);
  end;
end;

function TSchedulerTools.ApriFuoriSede(params: TEventoParams): boolean;
begin
  result := False;

  FuoriSede.RevertSql(False);
  FuoriSede.ParamByName('ID_ATTIVITA_FUORI_SEDE').AsInteger := params.id;
  FuoriSede.Active := true;
  try

    if not params.ReadOnly then
      if params.id = -1 then
      begin
        FuoriSede.Append;
        FuoriSede.FieldByName('ID_RISORSA').AsInteger := Common.CurrentIdRisorsa;
        FuoriSede.FieldByName('DATA_ATTIVITA').AsDateTime := params.Data;
        FuoriSede.FieldByName('DALLE_ORE').AsDateTime := params.OraInizio;
        FuoriSede.FieldByName('ALLE_ORE').AsDateTime := params.OraFine;
      end;

    if params.ReadOnly then
      // Mantis #197 - 2026-09-30: era cardScadenze, la scheda sbagliata
      cardFuoriSede.ReadOnly := true;

    result := cardFuoriSede.Execute;
  finally
    // Mantis #197 - 2026-09-30: vedi ApriPrenotazioneAula
    FuoriSede.Cancel;
    FuoriSede.Active := False;
  end;
end;

function TSchedulerTools.ApriAgenda(params: TEventoParams): boolean;
begin
  result := False;

  Agenda.RevertSql(False);
  Agenda.ParamByName('ID_AGENDA').AsInteger := params.id;
  Agenda.Active := true;
  try

    if not params.ReadOnly then
      if params.id = -1 then
      begin
        Agenda.Append;
        Agenda.FieldByName('ID_RISORSA').AsInteger := Common.CurrentIdRisorsa;
        Agenda.FieldByName('DATA_EVENTO').AsDateTime := params.Data;
        Agenda.FieldByName('ORA_INIZIO').AsDateTime := params.OraInizio;
        Agenda.FieldByName('ORA_FINE').AsDateTime := params.OraFine;
      end;

    if params.ReadOnly then
      cardAgenda.ReadOnly := true;

    result := cardAgenda.Execute;
  finally
    // Mantis #197 - 2026-09-30: vedi ApriPrenotazioneAula
    Agenda.Cancel;
    Agenda.Active := False;
  end;
end;

function TSchedulerTools.ApriOrario(params: TEventoParams): boolean;
begin
  result := False;

  // Mail Ornella Balsamo 18.01.2023
  if Orario.state in dsEditModes then
    Orario.Cancel;

  Orario.RevertSql(False);
  Orario.ParamByName('ID_ORARIO').AsInteger := params.id;
  Orario.Active := true;
  try

    if not params.ReadOnly then
      if params.id = -1 then
      begin
        Orario.Append;
        // Orario.FieldByName('ID_RISORSA').AsInteger := Tools.CurrentIdRisorsa;
        Orario.FieldByName('DATA_LEZIONE').AsDateTime := params.Data;
        Orario.FieldByName('ORA_INIZIO').AsDateTime := params.OraInizio;
        Orario.FieldByName('DURATA').AsInteger := params.Durata;

        if not params.Aula.IsEmpty then
          Orario.FieldByName('AULA').Value := params.Aula;

        if not params.FieldName1.IsEmpty then
          Orario.FieldByName(params.FieldName1).Value := params.Value1;

        if not params.FieldName2.IsEmpty then
          Orario.FieldByName(params.FieldName2).Value := params.Value2;

        if not params.FieldName3.IsEmpty then
          Orario.FieldByName(params.FieldName3).Value := params.Value3;

        if not params.FieldName4.IsEmpty then
          Orario.FieldByName(params.FieldName4).Value := params.Value4;

        if not params.FieldName5.IsEmpty then
          Orario.FieldByName(params.FieldName5).Value := params.Value5;
      end;

    if params.ReadOnly then
      cardOrario.ReadOnly := true;

    result := cardOrario.Execute;
  finally
    // Mantis #197 - 2026-09-30: vedi ApriPrenotazioneAula
    Orario.Cancel;
    Orario.Active := False;
  end;
end;

function TSchedulerTools.ApriPrenotazioneAula(params: TEventoParams): boolean;
begin
  result := False;

  PrenotazioneAule.RevertSql(False);
  PrenotazioneAule.ParamByName('ID_PRENOTAZIONE_AULA').AsInteger := params.id;
  PrenotazioneAule.Active := true;
  try

    if not params.ReadOnly then
      if params.id = -1 then
      begin
        PrenotazioneAule.Append;
        PrenotazioneAule.FieldByName('ID_RISORSA').AsInteger := Common.CurrentIdRisorsa;
        PrenotazioneAule.FieldByName('DATA_PRENOTAZIONE').AsDateTime := params.Data;
        PrenotazioneAule.FieldByName('ORA_INIZIO').AsDateTime := params.OraInizio;
        PrenotazioneAule.FieldByName('ORA_FINE').AsDateTime := params.OraFine;

        if not params.Aula.IsEmpty then
          PrenotazioneAule.FieldByName('AULA').Value := params.Aula;
      end;

    if params.ReadOnly then
      cardPrenotazioneAule.ReadOnly := true;

    result := cardPrenotazioneAule.Execute;
  finally
    // Mantis #197 - 2026-09-30: un record rimasto in inserimento dopo un errore
    // va annullato. Senza, la chiusura tenta di salvarlo (TzFbDataSet.DoBeforeClose),
    // fallisce, e il dataset resta aperto in inserimento per tutte le chiamate
    // successive: ogni nuova prenotazione falliva fino al riavvio. Dopo OK o
    // Annulla della scheda il dataset e' gia' in consultazione e Cancel non fa nulla.
    PrenotazioneAule.Cancel;
    PrenotazioneAule.Active := False;
  end;
end;

function TSchedulerTools.ApriRilevamento(params: TEventoParams): boolean;
begin
  result := False;

  RilevamentoOre.RevertSql(False);
  RilevamentoOre.ParamByName('ID_RILEVAMENTO_ORE').AsInteger := params.id;

  RilevamentoOre.Active := true;
  try
    if not params.ReadOnly then
      if params.id = -1 then
      begin
        RilevamentoOre.Append;
        RilevamentoOre.FieldByName('ID_RISORSA').AsInteger := Common.CurrentIdRisorsa;
        RilevamentoOre.FieldByName('DATA').AsDateTime := params.Data;
        RilevamentoOre.FieldByName('ORA_INIZIO').AsDateTime := params.OraInizio;
        RilevamentoOre.FieldByName('ORA_FINE').AsDateTime := params.OraFine;
      end;

    if params.ReadOnly then
      cardRilevamento.ReadOnly := true;

    result := cardRilevamento.Execute;
  finally
    RilevamentoOre.Cancel;
    RilevamentoOre.Active := False;
  end;
end;

function TSchedulerTools.ApriRiunione(params: TEventoParams): boolean;
begin
  result := False;

  Riunioni.RevertSql(False);
  Riunioni.ParamByName('ID_RIUNIONE').AsInteger := params.id;
  Riunioni.Active := true;
  try

    if not params.ReadOnly then
      if params.id = -1 then
      begin
        Riunioni.Append;
        Riunioni.FieldByName('ID_RESPONSABILE_RIUNIONE').AsInteger := Common.CurrentIdRisorsa;
        Riunioni.FieldByName('DATA_RIUNIONE').AsDateTime := params.Data;
        Riunioni.FieldByName('ORA_INIZIO').AsDateTime := params.OraInizio;
        Riunioni.FieldByName('ORA_FINE').AsDateTime := params.OraFine;

        if not params.Aula.IsEmpty then
          Riunioni.FieldByName('AULA').Value := params.Aula;
      end;

    if params.ReadOnly then
      cardRiunioni.ReadOnly := true;

    result := cardRiunioni.Execute;
  finally
    // Mantis #197 - 2026-09-30: vedi ApriPrenotazioneAula
    Riunioni.Cancel;
    Riunioni.Active := False;
  end;
end;

function TSchedulerTools.ApriPresenzaPersonale(params: TEventoParams): boolean;
begin
  result := False;
end;

function TSchedulerTools.ApriInagibilita(params: TEventoParams): boolean;
begin
  result := False;
end;

function TSchedulerTools.ApriChiusuraSede(params: TEventoParams): boolean;
begin
  result := False;
end;

function TSchedulerTools.ApriScadenza(params: TEventoParams): boolean;
begin
  result := False;

  Scadenze.RevertSql(False);
  Scadenze.ParamByName('ID_SCADENZA').AsInteger := params.id;
  Scadenze.Active := true;
  try

    if not params.ReadOnly then
      if params.id = -1 then
      begin
        Scadenze.Append;
        // Scadenze.FieldByName('ID_RESPONSABILE_RIUNIONE').AsInteger := Tools.CurrentIdRisorsa;
        Scadenze.FieldByName('DATA_SCADENZA').AsDateTime := params.Data;
      end;

    if params.ReadOnly then
      cardScadenze.ReadOnly := true;

    result := cardScadenze.Execute;
  finally
    // Mantis #197 - 2026-09-30: vedi ApriPrenotazioneAula
    Scadenze.Cancel;
    Scadenze.Active := False;
  end;
end;

procedure TSchedulerTools.cardPrenotazioneAuleInitDialog(Dialog: TzDbCardForm);
begin
  inherited;
  Dialog.zDbCard.ToolActions.Clear;
  Dialog.zDbCard.AddAction(InviaMailAutorizzazioneAula, zDmImages.ImageList16);
  Dialog.zDbCard.InitToolActions;
end;

function TSchedulerTools.EliminaAgenda(params: TEventoParams): boolean;
begin
  result := False;

  Agenda.RevertSql(False);
  Agenda.ParamByName('ID_AGENDA').AsInteger := params.id;
  Agenda.Active := true;
  try
    Agenda.Delete;
  finally
    Agenda.Active := False;
  end;

  result := true;
end;

function TSchedulerTools.EliminaChiusuraSede(params: TEventoParams): boolean;
begin
  result := False;
end;

function TSchedulerTools.EliminaEvento(params: TEventoParams): boolean;
begin
  result := False;

  case params.TipoEvento of
    teOrarioLezione:
      result := EliminaOrario(params);
    teOreRilevamento:
      result := EliminaRilevamento(params);
    teRiunione:
      result := EliminaRiunione(params);
    teAgendaPersonale:
      result := EliminaAgenda(params);
    tePrenotazioneAule:
      result := EliminaPrenotazioneAula(params);
    teInagibilitaAula:
      result := EliminaInagibilita(params);
    teChiusuraSede:
      result := EliminaChiusuraSede(params);
    tePresenzaPersonale:
      result := EliminaPresenzaPersonale(params);
    teScadenza:
      result := EliminaScadenza(params);
    teAttivitaFuoriSede:
      result := EliminaFuoriSede(params);
  end;
end;

function TSchedulerTools.EliminaFuoriSede(params: TEventoParams): boolean;
begin
  result := False;

  FuoriSede.RevertSql(False);
  FuoriSede.ParamByName('ID_ATTIVITA_FUORI_SEDE').AsInteger := params.id;
  FuoriSede.Active := true;
  try
    FuoriSede.Delete;
  finally
    FuoriSede.Active := False;
  end;

  result := true;
end;

function TSchedulerTools.EliminaInagibilita(params: TEventoParams): boolean;
begin
  result := False;
end;

function TSchedulerTools.EliminaOrario(params: TEventoParams): boolean;
var
  sp: TSP_Orario_Elimina;
begin
  result := False;

  sp := TSP_Orario_Elimina.Create(WriteTrans);
  try
    sp.id_orario := params.id;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  // Orario.RevertSql(False);
  // Orario.ParamByName('ID_ORARIO').AsInteger := params.id;
  // Orario.Active := true;
  // try
  // Orario.Delete;
  // finally
  // Orario.Active := False;
  // end;

  result := true;
end;

function TSchedulerTools.EliminaPrenotazioneAula(params: TEventoParams): boolean;
begin
  result := False;

  PrenotazioneAule.RevertSql(False);
  PrenotazioneAule.ParamByName('ID_PRENOTAZIONE_AULA').AsInteger := params.id;
  PrenotazioneAule.Active := true;
  try
    PrenotazioneAule.Delete;
  finally
    PrenotazioneAule.Active := False;
  end;
  result := true;
end;

function TSchedulerTools.EliminaPresenzaPersonale(params: TEventoParams): boolean;
begin
  result := False;
end;

function TSchedulerTools.EliminaRilevamento(params: TEventoParams): boolean;
begin
  result := False;

  RilevamentoOre.RevertSql(False);
  RilevamentoOre.ParamByName('ID_RILEVAMENTO_ORE').AsInteger := params.id;
  RilevamentoOre.Active := true;
  try
    RilevamentoOre.Delete;
  finally
    RilevamentoOre.Active := False;
  end;

  result := true;
end;

function TSchedulerTools.EliminaRiunione(params: TEventoParams): boolean;
begin
  result := False;

  Riunioni.RevertSql(False);
  Riunioni.ParamByName('ID_RIUNIONE').AsInteger := params.id;
  Riunioni.Active := true;
  try
    Riunioni.Delete;
  finally
    Riunioni.Active := False;
  end;

  result := true;
end;

function TSchedulerTools.EliminaScadenza(params: TEventoParams): boolean;
begin
  result := False;

  Scadenze.RevertSql(False);
  Scadenze.ParamByName('ID_SCADENZA').AsInteger := params.id;
  Scadenze.Active := true;
  try
    Scadenze.Delete;
  finally
    Scadenze.Active := False;
  end;

  result := true;
end;

procedure TSchedulerTools.InitStorageFields(cxSchedulerDBStorage: TcxSchedulerDBStorage);
begin
  cxSchedulerDBStorage.FieldNames.id := 'ID';
  cxSchedulerDBStorage.FieldNames.EventType := 'TIPO_EVENTO'; // 0
  cxSchedulerDBStorage.FieldNames.Start := 'INIZIO'; // data + ora
  cxSchedulerDBStorage.FieldNames.Finish := 'FINE'; // data + ora
  cxSchedulerDBStorage.FieldNames.Options := 'OPZIONI'; // 0
  cxSchedulerDBStorage.FieldNames.Caption := 'TITOLO_EVENTO'; //
  cxSchedulerDBStorage.FieldNames.Message := 'CORPO_EVENTO'; // vedere

  cxSchedulerDBStorage.CUSTOMFIELDS.Clear;
  cxSchedulerDBStorage.CUSTOMFIELDS.Add.FieldName := 'TITOLO_EVENTO';
  cxSchedulerDBStorage.CUSTOMFIELDS.Add.FieldName := 'CORPO_EVENTO';
  cxSchedulerDBStorage.CUSTOMFIELDS.Add.FieldName := 'SCHEDULER_TIPO_EVENTO';
  cxSchedulerDBStorage.CUSTOMFIELDS.Add.FieldName := 'MODIFICABILE';
  cxSchedulerDBStorage.CUSTOMFIELDS.Add.FieldName := 'ID_ORARIO';
  cxSchedulerDBStorage.CUSTOMFIELDS.Add.FieldName := 'ID_RILEVAMENTO_ORE';
  cxSchedulerDBStorage.CUSTOMFIELDS.Add.FieldName := 'ID_RIUNIONE';
  cxSchedulerDBStorage.CUSTOMFIELDS.Add.FieldName := 'ID_AGENDA';
  cxSchedulerDBStorage.CUSTOMFIELDS.Add.FieldName := 'ID_PRENOTAZIONE_AULA';
  cxSchedulerDBStorage.CUSTOMFIELDS.Add.FieldName := 'ID_SCADENZA';
  cxSchedulerDBStorage.CUSTOMFIELDS.Add.FieldName := 'ID_ATTIVITA_FUORI_SEDE';
  cxSchedulerDBStorage.CUSTOMFIELDS.Add.FieldName := 'COLORE'; // vedere
end;

procedure TSchedulerTools.cxSchedulerDBStorageEventHandled(Sender: TObject; AEvent: TcxSchedulerEvent; var AHandled: boolean);
begin
  inherited;
  AHandled := true;
end;

procedure TSchedulerTools.cxSchedulerDBStorageEventModified(Sender: TObject; AEvent: TcxSchedulerEvent; var AHandled: boolean);
begin
  AHandled := true;
end;

procedure TSchedulerTools.cxSchedulerDBStorageEventIntersect(Sender: TcxCustomSchedulerStorage; AEvent1, AEvent2: TcxSchedulerEvent; var Allow: boolean);
var
  SchedulerTipoEvento1: TSchedulerTipoEvento;
  SchedulerTipoEvento2: TSchedulerTipoEvento;
begin
  inherited;
  SchedulerTipoEvento1 := TSchedulerTipoEvento.FromString(AEvent1.GetCustomFieldValueByName('SCHEDULER_TIPO_EVENTO'));
  SchedulerTipoEvento2 := TSchedulerTipoEvento.FromString(AEvent2.GetCustomFieldValueByName('SCHEDULER_TIPO_EVENTO'));

  Allow := SchedulerTipoEvento1.CanIntersect(SchedulerTipoEvento2);
end;

procedure TSchedulerTools.InitStorage(cxSchedulerDBStorage: TcxSchedulerDBStorage);
begin
  cxSchedulerDBStorage.OnEventInserted := cxSchedulerDBStorageEventHandled;
  cxSchedulerDBStorage.OnEventDeleted := cxSchedulerDBStorageEventHandled;
  cxSchedulerDBStorage.OnEventModified := cxSchedulerDBStorageEventModified;
  cxSchedulerDBStorage.OnEventIntersect := cxSchedulerDBStorageEventIntersect;

  InitStorageFields(cxSchedulerDBStorage);

  cxSchedulerDBStorage.Holidays := cxSchedulerHolidays;
end;

function TSchedulerTools.SpostaEvento(params: TEventoParams): boolean;
begin
  result := False;

  case params.TipoEvento of
    teOrarioLezione:
      result := SpostaOrario(params);
    teOreRilevamento:
      result := False;
    teRiunione:
      result := False;
    teAgendaPersonale:
      result := SpostaAgenda(params);
    tePrenotazioneAule:
      result := SpostaPrenotazioneAula(params);
    teInagibilitaAula:
      result := False;
    teChiusuraSede:
      result := False;
    tePresenzaPersonale:
      result := False;
    teScadenza:
      result := False;
    teAttivitaFuoriSede:
      result := SpostaFuoriSede(params);
  end;
end;

// Spostamento con il trascinamento sul calendario: cambiano solo data e orario,
// la risorsa (la persona a cui appartiene l'evento) resta quella di prima.
// Prima l'agenda e le attivita' fuori sede restituivano False e l'evento
// trascinato tornava al suo posto.
function TSchedulerTools.SpostaAgenda(params: TEventoParams): boolean;
begin
  result := False;

  Agenda.RevertSql(False);
  Agenda.ParamByName('ID_AGENDA').AsInteger := params.id;
  Agenda.Active := true;
  try
    if not Agenda.IsEmpty then
    begin
      Agenda.Edit;
      Agenda.FieldByName('DATA_EVENTO').AsDateTime := params.Data;
      Agenda.FieldByName('ORA_INIZIO').AsDateTime := params.OraInizio;
      Agenda.FieldByName('ORA_FINE').AsDateTime := params.OraFine;
      try
        Agenda.Post;
      except
        on e: exception do
        begin
          Agenda.Cancel;
          raise;
        end;
      end;

      result := true;
    end;
  finally
    Agenda.Active := False;
  end;
end;

function TSchedulerTools.SpostaFuoriSede(params: TEventoParams): boolean;
begin
  result := False;

  FuoriSede.RevertSql(False);
  FuoriSede.ParamByName('ID_ATTIVITA_FUORI_SEDE').AsInteger := params.id;
  FuoriSede.Active := true;
  try
    if not FuoriSede.IsEmpty then
    begin
      FuoriSede.Edit;
      FuoriSede.FieldByName('DATA_ATTIVITA').AsDateTime := params.Data;
      FuoriSede.FieldByName('DALLE_ORE').AsDateTime := params.OraInizio;
      FuoriSede.FieldByName('ALLE_ORE').AsDateTime := params.OraFine;
      try
        FuoriSede.Post;
      except
        on e: exception do
        begin
          FuoriSede.Cancel;
          raise;
        end;
      end;

      result := true;
    end;
  finally
    FuoriSede.Active := False;
  end;
end;

function TSchedulerTools.SpostaOrario(params: TEventoParams): boolean;
var
  minuti: integer;
begin
  result := False;

  Orario.Active := False;
  Orario.ParamByName('ID_ORARIO').AsInteger := params.id;
  Orario.Active := true;
  try

    if not Orario.IsEmpty then
    begin
      Orario.Edit;
      Orario.FieldByName('DATA_LEZIONE').Value := params.Data;
      Orario.FieldByName('ORA_INIZIO').Value := params.OraInizio;
      Orario.FieldByName('DURATA').Value := params.Durata;
      try
        Orario.Post;
      except
        on e: exception do
        begin
          Orario.Cancel;
          Application.HandleException(e);
        end;
      end;
    end;
  finally
    Orario.Active := False;
  end;

  result := true;
end;

function TSchedulerTools.SpostaPrenotazioneAula(params: TEventoParams): boolean;
begin
  inherited;
  PrenotazioneAule.Active := False;
  PrenotazioneAule.ParamByName('ID_PRENOTAZIONE_AULA').AsInteger := params.id;
  PrenotazioneAule.Active := true;
  try
    if not PrenotazioneAule.IsEmpty then
    begin
      PrenotazioneAule.Edit;
      PrenotazioneAule.FieldByName('DATA_PRENOTAZIONE').Value := params.Data;
      PrenotazioneAule.FieldByName('ORA_INIZIO').Value := params.OraInizio;
      PrenotazioneAule.FieldByName('ORA_FINE').Value := params.OraFine;
      PrenotazioneAule.FieldByName('AULA').Value := params.Aula;
      try
        PrenotazioneAule.Post;
      except
        on e: exception do
        begin
          PrenotazioneAule.Cancel;
          raise;
        end;
      end;
    end;
  finally
    PrenotazioneAule.Active := False;
  end;

  result := true;
end;

function TSchedulerTools.UpdateEvento(params: TEventoParams): boolean;
begin
  result := False;

  case params.TipoEvento of
    teOrarioLezione:
      result := UpdateOrario(params);
    teOreRilevamento:
      result := False;
    teRiunione:
      result := False;
    teAgendaPersonale:
      result := False;
    tePrenotazioneAule:
      result := False;
    teInagibilitaAula:
      result := False;
    teChiusuraSede:
      result := False;
    tePresenzaPersonale:
      result := False;
    teScadenza:
      result := False;
    teAttivitaFuoriSede:
      result := False;
  end;
end;

function TSchedulerTools.UpdateOrario(params: TEventoParams): boolean;
begin
  Orario.Active := False;
  Orario.ParamByName('ID_ORARIO').AsInteger := params.id;
  Orario.Active := true;
  try
    Orario.Edit;

    if not params.FieldName1.IsEmpty then
      Orario.FieldByName(params.FieldName1).Value := params.Value1;

    if not params.FieldName2.IsEmpty then
      Orario.FieldByName(params.FieldName2).Value := params.Value2;

    if not params.FieldName3.IsEmpty then
      Orario.FieldByName(params.FieldName3).Value := params.Value3;

    if not params.FieldName4.IsEmpty then
      Orario.FieldByName(params.FieldName4).Value := params.Value4;

    if not params.FieldName5.IsEmpty then
      Orario.FieldByName(params.FieldName5).Value := params.Value5;

    // se varia il docente azzera l'incarico
    if SameText(params.FieldName1, 'ID_DOCENTE') or SameText(params.FieldName2, 'ID_DOCENTE') or SameText(params.FieldName3, 'ID_DOCENTE') or SameText(params.FieldName4, 'ID_DOCENTE') or SameText(params.FieldName5, 'ID_DOCENTE') then
      Orario.FieldByName('ID_INCARICO').Clear;

    Orario.Post;
  finally
    Orario.Active := False;
  end;

  result := true;
end;

procedure TSchedulerTools.InviaMailAutorizzazioneAulaExecute(Sender: TObject);
var
  sp: TSP_GET_MAIL_PRENOTAZIONE_AULA;
  Mail: TMail;
  SMTPServerParams: TSMTPServerParams;
  IdPrenotazione: integer;
begin
  inherited;

  PrenotazioneAule.CheckBrowseMode;

  if PrenotazioneAule.IsEmpty then
    exit;

  if not PrenotazioneAule.FieldByName('DATA_ORA_AUTORIZZAZIONE').IsNull then
  begin
    ConfirmOk('La prenotazione risulta autorizzata.');
    exit;
  end;

  if PrenotazioneAule.FieldByName('RICHIEDE_AUTORIZZAZIONE').asBoolean = False then
  begin
    ConfirmOk('La prenotazione non richiede autorizzazione.');
    exit;
  end;

  if PrenotazioneAule.FieldByName('ANNULLATA').asBoolean = true then
  begin
    ConfirmOk('La prenotazione risulta annullata.');
    exit;
  end;

  IdPrenotazione := PrenotazioneAule.FieldByName('ID_PRENOTAZIONE_AULA').AsInteger;

  SMTPServerParams.Init;
  Mail.Init;

  sp := TSP_GET_MAIL_PRENOTAZIONE_AULA.Create(WriteTrans);
  try
    sp.ID_PRENOTAZIONE_AULA := IdPrenotazione;
    sp.ExecuteWithoutCommit;

    Mail.A := sp.EMAIL_AUTORIZZAZIONE_AULE.Value;
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

  WriteMail(Mail, SMTPServerParams, Common.GetMailRisorse); //
end;

procedure TSchedulerTools.RilevamentoOreNewRecord(DataSet: TDataSet);
begin
  inherited;
  // DataSet.FieldByName('ID_RISORSA').AsInteger := Master.FieldByName('ID_PERSONALE').AsInteger;
  // DataSet.FieldByName('ID_RILEVATORE').AsInteger := Master.FieldByName('ID_PERSONALE').AsInteger;
  // Tools.FocusField(DataSet.FieldByName('DATA'));
end;

procedure TSchedulerTools.RilevamentoOreAfterCreateFields(DataSet: TDataSet);
var
  Field: TField;
begin
  DataSet.CreateCalculatedField(TBooleanField, 'RILEVAMENTO_ORE_EXTRA_REGISTRO');

  Field := DataSet.FindField('ID_PROGETTO');
  if Assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;

  Field := DataSet.FindField('DATA');
  if Assigned(Field) then
    Field.OnChange := RilevamentoDataChanged;

  Field := DataSet.FindField('ORA_INIZIO');
  if Assigned(Field) then
    Field.OnChange := RilevamentoNumeroOreChanged;

  Field := DataSet.FindField('ORA_FINE');
  if Assigned(Field) then
    Field.OnChange := RilevamentoNumeroOreChanged;

  Field := DataSet.FindField('TIPO_INCARICO');
  if Assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;

  Field := DataSet.FindField('ID_PIANO_PERSONALIZZATO');
  if Assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;

  Field := DataSet.FindField('SERVIZIO_EROGATO');
  if Assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;

  Field := DataSet.FindField('MATERIA');
  if Assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;

  Field := DataSet.FindField('ID_INCARICO');
  if Assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;
end;

procedure TSchedulerTools.RilevamentoOreCalcFields(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('RILEVAMENTO_ORE_EXTRA_REGISTRO').Value := true;
end;

procedure TSchedulerTools.RilevamentoDataChanged(Sender: TField);
begin
  if DateOf(Sender.AsDateTime) > Date then
    raise exception.Create('Data rilevamento maggiore della data odierna.');

  RilevamentoOreGetDettagliPresenza(Sender.DataSet);
end;

procedure TSchedulerTools.RilevamentoFieldChanged(Sender: TField);
begin
  if DisableRilevamentoFieldChanged then
    exit;

  DisableRilevamentoFieldChanged := true;
  try
    if SameText(Sender.FieldName, 'ID_PROGETTO') then
    begin
      Sender.DataSet.FieldByName('TIPO_INCARICO').Clear;
      Sender.DataSet.FieldByName('ID_INCARICO').Clear;
    end
    else
      if SameText(Sender.FieldName, 'TIPO_INCARICO') then
      begin
        Sender.DataSet.FieldByName('ID_INCARICO').Clear;
      end;

    RilevamentoOreGetDettagliPresenza(Sender.DataSet);
  finally
    DisableRilevamentoFieldChanged := False;
  end;
end;

procedure TSchedulerTools.RilevamentoNumeroOreChanged(Sender: TField);
var
  OraInizio, OraFine, Ore: TField;
  m: integer;
begin
  OraInizio := Sender.DataSet.FindField('ORA_INIZIO');
  OraFine := Sender.DataSet.FindField('ORA_FINE');
  Ore := Sender.DataSet.FindField('ORE');

  if Assigned(OraInizio) then
    if Assigned(OraFine) then
      if Assigned(Ore) then
      begin
        if not(OraInizio.IsNull or OraFine.IsNull) then
          if OraInizio.Value >= OraFine.Value then
            raise exception.Create('Intevallo orario non valido.');

        if OraInizio.IsNull or OraFine.IsNull then
          Ore.Clear
        else
        begin
          m := MinutesBetween(OraInizio.AsDateTime, OraFine.AsDateTime);
          Ore.Value := trunc((m / 60) * 100) / 100;
        end;
      end;

  RilevamentoOreGetDettagliPresenza(Sender.DataSet);
end;

procedure TSchedulerTools.RilevamentoOreGetDettagliPresenza(DataSet: TDataSet);
var
  sp: TSP_INCARICHI_GET_PRESENZE;
  // DataSet: TzFbDataSet;
  idPersonale, idProgetto, idCorso, Tipo_Incarico, idPianoPersonalizzato, ServizioErogato, Materia, IdIncarico, Data, OraInizio, OraFine: TField;
begin
  // Personale_Rilevamento_Ore := getDataSet('Personale_Rilevamento_Ore');

  idPersonale := DataSet.FindField('ID_RISORSA'); // l'originale incaricato
  idProgetto := DataSet.FindField('ID_PROGETTO');
  idCorso := DataSet.FindField('ID_CORSO');
  Tipo_Incarico := DataSet.FindField('TIPO_INCARICO');
  idPianoPersonalizzato := DataSet.FindField('ID_PIANO_PERSONALIZZATO');
  ServizioErogato := DataSet.FindField('SERVIZIO_EROGATO');
  Materia := DataSet.FindField('MATERIA');
  IdIncarico := DataSet.FindField('ID_INCARICO');
  Data := DataSet.FindField('DATA');
  OraInizio := DataSet.FindField('ORA_INIZIO');
  OraFine := DataSet.FindField('ORA_FINE');

  if not idPersonale.IsNull then
    if not idProgetto.IsNull then
      if not Tipo_Incarico.IsNull then
        if not Data.IsNull then
          if not OraInizio.IsNull then
            if not OraFine.IsNull then
            begin

              sp := TSP_INCARICHI_GET_PRESENZE.Create(WriteTrans);
              try
                sp.Id_Personale := idPersonale.Value;
                sp.Id_Progetto := idProgetto.Value;
                sp.Tipo_Incarico := Tipo_Incarico.Value;

                if idCorso.IsNull then
                  sp.Id_Corso.Clear
                else
                  sp.Id_Corso := idCorso.Value;

                if idPianoPersonalizzato.IsNull then
                  sp.Id_Piano_Personalizzato.Clear
                else
                  sp.Id_Piano_Personalizzato := idPianoPersonalizzato.Value;

                if ServizioErogato.IsNull then
                  sp.Servizio_Erogato.Clear
                else
                  sp.Servizio_Erogato := ServizioErogato.Value;

                if Materia.IsNull then
                  sp.Materia.Clear
                else
                  sp.Materia := Materia.Value;

                if IdIncarico.IsNull then
                  sp.Id_Incarico_Current.Clear
                else
                  sp.Id_Incarico_Current := IdIncarico.AsInteger;

                sp.Data := Data.Value;
                sp.Ora_Inizio := OraInizio.Value;
                sp.Ora_Fine := OraFine.Value;
                sp.ExecuteAndCommit;

                TzFbDataSet(DataSet).CheckEditMode;
                DataSet.FieldByName('ID_PRESENZA_PERSONALE').Value := sp.Id_Presenza_Personale;
                DataSet.FieldByName('DATA_PRESENZA').Value := sp.Data_Presenza;
                DataSet.FieldByName('ORA_ENTRATA').Value := sp.Ora_Entrata;
                DataSet.FieldByName('ORA_USCITA').Value := sp.Ora_Uscita;
                DataSet.FieldByName('TIPO_RILEVAMENTO').Value := sp.Tipo_Rilevamento;
                DataSet.FieldByName('ID_INCARICO').Value := sp.Id_Incarico;
                DataSet.FieldByName('TOTALE_ORE_ATTRIBUITE').Value := sp.Totale_Ore_Attribuite;
                DataSet.FieldByName('TOTALE_ORE_RESIDUE').Value := sp.Totale_Ore_Residue;
                DataSet.FieldByName('DATA_INIZIO_INCARICO').Value := sp.Data_Inizio_Incarico;
                DataSet.FieldByName('DATA_FINE_INCARICO').Value := sp.Data_Fine_Incarico;
              finally
                FreeAndNil(sp);
              end;
            end;
end;

procedure TSchedulerTools.RilevamentoOreBeforePost(DataSet: TDataSet);
begin
  SiMain.EnterMethod(Self, 'RilevamentoOreBeforePost');
  inherited;
  SiMain.LeaveMethod(Self, 'RilevamentoOreBeforePost');
end;

procedure TSchedulerTools.RilevamentoOreBeforeOpen(DataSet: TDataSet);
begin
  SiMain.EnterMethod(Self, 'RilevamentoOreBeforeOpen');
  inherited;
  SiMain.LeaveMethod(Self, 'RilevamentoOreBeforeOpen');
end;

procedure TSchedulerTools.RilevamentoOreBeforeClose(DataSet: TDataSet);
begin
  SiMain.EnterMethod(Self, 'RilevamentoOreBeforeClose');
  inherited;
  SiMain.LeaveMethod(Self, 'RilevamentoOreBeforeClose');
end;

procedure TSchedulerTools.ExportEvents(Scheduler: TcxScheduler);
const
  Setting = 'SCHEDULER_EXPORT_KIND';

  procedure InitDialog;
  var
    s: String;
  begin
    dxSaveFileDialog.FilterIndex := 0;

    s := Config.zSystem.Settings[Setting];

    if not s.trim.IsEmpty then
      dxSaveFileDialog.FilterIndex := s.trim.ToInteger();
  end;

begin

  InitDialog;

  if not dxSaveFileDialog.Execute then
    exit;

  Config.zSystem.Settings[Setting] := dxSaveFileDialog.FilterIndex.ToString;

  if dxSaveFileDialog.FilterIndex = 1 then
    cxExportSchedulerToExcel(dxSaveFileDialog.FileName, Scheduler, true)
  else
    if dxSaveFileDialog.FilterIndex = 2 then
      ExportToGoogleCalendar(Scheduler, dxSaveFileDialog.FileName)
    else
      if dxSaveFileDialog.FilterIndex = 3 then
        ExportToOutlook(Scheduler, dxSaveFileDialog.FileName)
      else
        cxExportSchedulerToExcel(dxSaveFileDialog.FileName, Scheduler, true);
end;

procedure TSchedulerTools.ExportToGoogleCalendar(Scheduler: TcxScheduler; const FileName: string);
const
  header = 'Subject,Start Date,Start Time,End Date,End Time,All Day Event,Description,Location,Private';
var
  exportFunc: TFunc<TcxSchedulerEvent, string>;
begin

  exportFunc := function(event: TcxSchedulerEvent): string
    begin
      result := '';
      result := result + AnsiQuotedStr(event.Caption, '"') + ',';
      result := result + FormatDateTime('dd/mm/yyyy', event.Start) + ',';
      result := result + FormatDateTime('hh:nn', event.Start) + ',';
      result := result + FormatDateTime('dd/mm/yyyy', event.Finish) + ',';
      result := result + FormatDateTime('hh:nn', event.Finish) + ',';
      result := result + 'false' + ','; // AllDayEvent
      result := result + AnsiQuotedStr(event.Message, '"') + ',';
      result := result + AnsiQuotedStr(varTostr(event.ResourceID), '"') + ',';
      result := result + 'false' + sLineBreak; // Private
    end;

  ExportScheduler(Scheduler, FileName, header, exportFunc);
end;

procedure TSchedulerTools.ExportToOutlook(Scheduler: TcxScheduler; const FileName: string);
const
  header = '"Oggetto","Data inizio","Ora inizio","Data fine","Ora fine","Giornata intera","Promemoria attivato/disattivato","Data promemoria","Ora promemoria","Organizzatore riunione","Partecipanti necessari","Partecipanti facoltativi","Risorse riunione","Categorie","Dati fatturazione","Descrizione","Indennit� trasferta","Luogo","Mostra ora come","Priorit�","Privato","Riservatezza"';
var
  exportFunc: TFunc<TcxSchedulerEvent, string>;

begin

  exportFunc := function(event: TcxSchedulerEvent): string
    begin
      // "Oggetto" = "aaaaaaaaa"
      // "Data inizio" = "16/9/2025"
      // "Ora inizio" = "09:30:00"
      // "Data fine" = "16/9/2025"
      // "Ora fine" = "10:00:00"
      // "Giornata intera" = "Falso"
      // "Promemoria attivato/disattivato" =
      // "Data promemoria" = "Vero"
      // "Ora promemoria" = "16/9/2025"
      // "Organizzatore riunione" = "09:15:00"
      // "Partecipanti necessari" = "Luca Zebro"
      // "Partecipanti facoltativi" =
      // "Risorse riunione" =
      // "Categorie" =
      // "Dati fatturazione" =
      // "Descrizione" = ""
      // "Indennit� trasferta" =
      // "Luogo" = ""
      // "Mostra ora come" = "2"
      // "Priorit�" = "Normale"
      // "Privato" = "Falso"
      // "Riservatezza" = "Normale"

      result := '';
      result := result + AnsiQuotedStr(event.Caption, '"') + ',';
      result := result + FormatDateTime('dd/mm/yyyy', event.Start) + ',';
      result := result + FormatDateTime('hh:nn', event.Start) + ',';
      result := result + FormatDateTime('dd/mm/yyyy', event.Finish) + ',';
      result := result + FormatDateTime('hh:nn', event.Finish) + ',';
      result := result + 'false' + ','; // AllDayEvent
      result := result + AnsiQuotedStr(event.Message, '"') + ',';
      result := result + AnsiQuotedStr(varTostr(event.ResourceID), '"') + ',';
      result := result + 'false' + sLineBreak; // Private
    end;

  ExportScheduler(Scheduler, FileName, header, exportFunc);
end;

procedure TSchedulerTools.ExportScheduler(Scheduler: TcxScheduler; const FileName, header: string; exportEventFunc: TFunc<TcxSchedulerEvent, string>);
var
  Events: TcxSchedulerFilteredEventList;
  event: TcxSchedulerEvent;
  resource: TcxSchedulerStorageResourceItem;
  Start, Finish: TDateTime;
  i: integer;
  s: string;
begin
  Start := TcxDateNavigatorAccess(Scheduler.DateNavigator).GetRealFirstDate;
  Finish := TcxDateNavigatorAccess(Scheduler.DateNavigator).GetRealLastDate;

  Events := TcxSchedulerFilteredEventList.Create;
  try
    Scheduler.Storage.GetEvents(Events, Start, Finish);

    TFile.WriteAllText(FileName, header + sLineBreak, TEncoding.UTF8);

    for i := 0 to Events.Count - 1 do
    begin
      event := Events[i];
      resource := event.GetResourceItem;

      if Assigned(resource) then
        if not resource.Visible then
          continue;

      s := exportEventFunc(event);

      TFile.AppendAllText(FileName, s, TEncoding.UTF8);
    end;
  finally
    FreeAndNil(Events);
  end;
end;

end.zSystem

  zSystem zFbDataSet
