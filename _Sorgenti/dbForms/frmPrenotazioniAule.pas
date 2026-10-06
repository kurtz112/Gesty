unit frmPrenotazioniAule;

interface

uses
  Windows,
  Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  fs_iinterpreter,
  dxBarExtItems,
  dxBar,
  cxClasses,
  ActnList,
  cxNavigator,
  cxDBNavigator,
  dxLayoutControl,
  cxControls,
  ExtCtrls,
  Menus,
  cxStyles,
  cxGraphics,
  cxEdit,
  cxScheduler,
  cxSchedulerStorage,
  cxSchedulerCustomControls,
  cxSchedulerCustomResourceView,
  cxSchedulerDayView,
  cxSchedulerDateNavigator,
  cxSchedulerHolidays,
  cxSchedulerTimeGridView,
  cxSchedulerUtils,
  cxSchedulerWeekView,
  cxSchedulerYearView,
  cxSchedulerGanttView,
  dxStatusBar,
  cxLookAndFeelPainters,
  StdCtrls,
  cxButtons,
  cxLookAndFeels,
  Buttons,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  DB,
  cxDBData,
  cxGridLevel,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  cxSchedulercxGridConnection,
  StdActns,
  BaseFrm,
  cxContainer,
  cxLabel,
  zDbView,
  dxLayoutLookAndFeels,
  cxPC,
  ImgList,
  dxSkinsCore,
  dxSkinsdxBarPainter,
  cxSchedulerTreeListBrowser,
  dxSkinscxSchedulerPainter,
  dxSkinscxPCPainter,
  cxPCdxBarPopupMenu,
  dxRibbonSkins,
  dxRibbonCustomizationForm,
  cxSchedulerAgendaView,
  cxSchedulerRecurrence,
  cxSchedulerRibbonStyleEventEditor,
  dxBarBuiltInMenu,
  System.ImageList,
  System.Actions,
  dxRibbon,
  Base_DataModule,
  zFormController,
  dxLayoutcxEditAdapters,
  dxLayoutContainer,
  cxSpinEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  Vcl.ComCtrls,
  dxCore,
  cxDateUtils,
  cxCalendar,
  dxLayoutControlAdapters,
  cxImageList,
  dxShellDialogs,
  dxFileActions,
  dxPrinting,
  cxSchedulerActions,
  dxActions,
  cxCheckBox,
  dxPSGlbl,
  dxPSUtl,
  dxPSEngn,
  dxPrnPg,
  dxBkgnd,
  dxWrap,
  dxPrnDev,
  dxPSCompsProvider,
  dxPSFillPatterns,
  dxPSEdgePatterns,
  dxPSPDFExportCore,
  dxPSPDFExport,
  cxDrawTextUtils,
  dxPSPrVwStd,
  dxPSPrVwAdv,
  dxPSPrVwRibbon,
  dxPScxPageControlProducer,
  dxPScxSchedulerLnk,
  dxPScxEditorProducers,
  dxPScxExtEditorProducers,
  dxPSCore,
  dxPScxCommon,
  cxBarEditItem,
  dxPScxTLLnk,
  dxPSdxSpreadSheetLnk,
  Base_Frame,
  zDbScheduler,
  cxTimeEdit,
  cxDBExtLookupComboBox,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl,
  dxUIAClasses;

type
  TFormPrenotazioniAule = class(TBaseForm)
    dxBarButton11: TdxBarButton;
    dxBarButton12: TdxBarButton;

    dxBarButtonNewEvent: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton60Minutes: TdxBarButton;
    dxBarButton30Minutes: TdxBarButton;
    dxBarButton15Minutes: TdxBarButton;
    dxBarButton10Minutes: TdxBarButton;
    dxBarButton6Minutes: TdxBarButton;
    dxBarButton5Minutes: TdxBarButton;
    Actions: TActionList;
    dxBarManagerBarAgenda: TdxBar;
    dxBarLargeButton6: TdxBarLargeButton;
    dxBarButton1: TdxBarButton;
    dxBarButton8: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    dxBarButton7: TdxBarButton;
    dxBarButton9: TdxBarButton;
    dxBarButton10: TdxBarButton;
    dxBarButton13: TdxBarButton;
    dxBarButton14: TdxBarButton;
    dxBarButton17: TdxBarButton;
    dxBarButton18: TdxBarButton;
    dxBarButton19: TdxBarButton;
    dxBarButton20: TdxBarButton;
    dxBarButton21: TdxBarButton;
    dxBarButton26: TdxBarButton;
    dxBarButton27: TdxBarButton;
    dxBarButton28: TdxBarButton;
    dxBarButton29: TdxBarButton;
    cxBarEditItem1: TcxBarEditItem;
    dxBarButton30: TdxBarButton;
    FrameScheduler: TzDbScheduler;
    layout: TdxLayoutControl;
    viewSlotLiberi: TzDbView;
    layoutGroup_Root: TdxLayoutGroup;
    dxLayoutItemGiorniLiberiPerAula: TdxLayoutItem;
    edDalGiorno: TcxDateEdit;
    edAlGiorno: TcxDateEdit;
    edDurata: TcxSpinEdit;
    edMinutiIncremento: TcxSpinEdit;
    edDalleOre: TcxTimeEdit;
    edAlleOre: TcxTimeEdit;
    dxLayoutGroupGiorniLiberiPerAulaTab: TdxLayoutGroup;
    btnGiorniLiberi: TcxButton;
    CercaSlotLiberi: TAction;
    dxLayoutItemDalGiorno: TdxLayoutItem;
    dxLayoutItemAlGiorno: TdxLayoutItem;
    dxLayoutItemDalleOre: TdxLayoutItem;
    dxLayoutItemAlleOre: TdxLayoutItem;
    dxLayoutItemDurata: TdxLayoutItem;
    dxLayoutItemMinutiIncremento: TdxLayoutItem;
    dxLayoutItemBtnCerca: TdxLayoutItem;
    dxLayoutGroupFiltriGiorniLiberiPerAula: TdxLayoutGroup;
    dxLayoutGroupFiltriGiorniLiberiPerAulaDate: TdxLayoutGroup;
    dxLayoutGroupFiltriGiorniLiberiPerAulaOre: TdxLayoutGroup;
    dxLayoutGroupFiltriGiorniLiberiPerAulaCerca: TdxLayoutGroup;
    edAula: TcxExtLookupComboBox;
    dxLayoutItemAula: TdxLayoutItem;
    PrenotaAula: TAction;
    dxLayoutGroupAula: TdxLayoutGroup;
    viewSelezionaAule: TzDbView;
    dxLayoutItemSelezionaAule: TdxLayoutItem;
    TimerSelezione: TTimer;
    viewRiepilogoOccupazioni: TzDbView;
    dxLayoutItemRiepilogoOccupazioni: TdxLayoutItem;
    PrenotazionePeriodo: TAction;
    edSede: TcxExtLookupComboBox;
    dxLayoutItemSede: TdxLayoutItem;
    procedure CalendarioDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure CercaSlotLiberiExecute(Sender: TObject);
    procedure dxBarButton22Click(Sender: TObject);
    procedure edAulaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edSedeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FrameSchedulerSchedulerClick(Sender: TObject);
    procedure PrenotaAulaExecute(Sender: TObject);
    procedure PrenotazionePeriodoExecute(Sender: TObject);
    procedure TimerSelezioneTimer(Sender: TObject);
    procedure viewSelezionaAuleSelectionChanged(Sender: TObject);
    procedure viewSlotLiberiDblClick(Sender: TObject);
  private
    DisabilitaSelezioneAule: boolean;
  private
    procedure AggiornaCalendario;
    procedure RiSelezionaAule;
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure AfterCreateControls; override;
    procedure HelpEnumActions(Actions: TList<TContainedAction>); override;
  public
    constructor Create(aOwner: TComponent); override;

    procedure Aggiorna; override;
    procedure Stampa; override;
  end;

implementation

uses
  Gesty.Scheduler,
  System.DateUtils,
  cxSchedulerDialogs,
  cxSchedulerOutlookExchange,
  cxLookupDBGrid,
  cxExportSchedulerLink,
  dmPrenotazioniAule,
  zDm_Images,
  zDX,
  zBaseLib,
  Gesty.Types,
  zFrmParams,
  ConfigModule,
  zMsg;

{$R *.dfm}

var
  FormPrenotazioniAule: TFormPrenotazioniAule;

  { TFormPrenotazioniAule }
procedure TFormPrenotazioniAule.CreateDataModule;
begin
  SiMain.EnterMethod(Self, 'CreateDataModule');

  inherited;
  CreateDM(TPrenotazioniAule, PrenotazioniAule);
  // il modulo dati resta quello di sempre: il ponte Gesty.Scheduler lo adatta
  // al calendario di zPack
  FrameScheduler.Init(TGestyScheduler.Storage(PrenotazioniAule), TGestyScheduler.CopiaIncolla(PrenotazioniAule));

  SiMain.LeaveMethod(Self, 'CreateDataModule');
end;

procedure TFormPrenotazioniAule.DestroyDataModule;
begin
  inherited;
  FreeAndNil(PrenotazioniAule);
end;

constructor TFormPrenotazioniAule.Create(aOwner: TComponent);
  function GetAutoRefreshIndex: integer;
  var
    s: String;
  begin
    result := 0;

    s := config.zSystem.Settings['PrenotazioniAule.AutoRefresh'];
    if (not s.IsEmpty) then
      TryStrToInt(s, result);
  end;

begin
  inherited;

  DisabilitaSelezioneAule := false;
  FrameScheduler.Visible := false;
  FrameScheduler.Parent := Self;

  layout.Visible := false;
  layout.Parent := Self;
  layoutGroup_Root.itemIndex := 0;

  FormController.SkipSelectFirstNode := True;

  dx.InitLayoutControl(layout);
  dx.InitLookup('', edAula, PrenotazioniAule.lkFiltroAule, PrenotazioniAule.lkFiltroAuleSrc, 'AULA', 'AULA');
  dx.InitLookup('', edSede, PrenotazioniAule.lkFiltroSedi, PrenotazioniAule.lkFiltroSediSrc, 'ID_SEDE', 'SEDE');

  viewSelezionaAule.zDataSet := PrenotazioniAule.ElencoAule;

  // Spostato in LZ
  // Tools.AddFiltroSede(viewSelezionaAule, PrenotazioniAule.ElencoAule);

  viewSlotLiberi.zDataSet := PrenotazioniAule.SlotLiberi;
  viewRiepilogoOccupazioni.zDataSet := PrenotazioniAule.RiepilogoOccupazioni;

  FrameScheduler.Scheduler.OptionsView.ShowEventsWithoutResource := True;
  FrameScheduler.Scheduler.ViewDay.AllDayAreaScrollBar := adsbDefault;
  FrameScheduler.Scheduler.ViewDay.HeaderContainer := True;
  // Mantis #203 - 2026-10-02: il calendario di zPack sta nel .dfm come componente semplice,
  // come TzDbView: le personalizzazioni del calendario si impostano qui e non nel .dfm
  FrameScheduler.Scheduler.DateNavigator.ColCount := 3;
  FrameScheduler.Scheduler.OnClick := FrameSchedulerSchedulerClick;
  FrameScheduler.AddToolbarButton(PrenotazionePeriodo);

  FrameScheduler.ShowAutoRefreshCombo := True;
  FrameScheduler.AutoRefreshIndex := GetAutoRefreshIndex;

  /// ////////////////////////////////////////////////////////////////////

  /// ////////////////////////////////////////////////////////////////////

  FrameScheduler.AutoRefreshIntervalChanged := procedure(value: integer)
    begin
      config.zSystem.Settings['PrenotazioniAule.AutoRefresh'] := value.ToString;
    end;

  edDalleOre.Time := FrameScheduler.Scheduler.OptionsView.WorkStart;
  edAlleOre.Time := FrameScheduler.Scheduler.OptionsView.WorkFinish;
  edMinutiIncremento.value := 60;
  // CAPAC 10.03.2025 FrameScheduler.Scheduler.ViewDay.TimeScale;
  edDurata.value := 60; // CAPAC 10.03.2025 FrameScheduler.Scheduler.ViewDay.TimeScale;

  // FrameScheduler.Scheduler.OnInitEventImages := nil; // CAPAC 10.03.2025
  FrameScheduler.Scheduler.ViewWeeks.ShowTimeAsClock := false; // CAPAC 10.03.2025

  /// ////////
  viewRiepilogoOccupazioni.BeforeShowParamsProc := procedure(zParamDialog: TzParamDialog)
    var
      edLookup: TcxExtLookupComboBox;
    begin
      zParamDialog.zDialog.Width := 350;
      PrenotazioniAule.lkAule.RevertSQL(True);
      edLookup := zParamDialog.zDialog.zFormBuilder.ChangeControlType(ctLookupExt, 'AULA', 'Aula', null) as TcxExtLookupComboBox;
      dx.InitLookup('', edLookup, PrenotazioniAule.lkAule, PrenotazioniAule.lkAuleSrc, 'AULA', 'AULA');
    end;

  SiMain.LeaveMethod(Self, 'Create');
end;

procedure TFormPrenotazioniAule.Aggiorna;
begin
  DisabilitaSelezioneAule := True;
  try
    inherited;
    PrenotazioniAule.AttivaCalendario;
  finally
    DisabilitaSelezioneAule := false;
  end;

  AggiornaCalendario;
end;

procedure TFormPrenotazioniAule.AfterCreateControls;
begin
  inherited;
  AddLayoutItem(FrameScheduler, 'Calendario', false);
  AddLayoutItem(layout, 'layout', false);
end;

procedure TFormPrenotazioniAule.Stampa;
begin
  // inherited; No!
  FrameScheduler.Preview;
end;

procedure TFormPrenotazioniAule.AggiornaCalendario;
begin
  SiMain.EnterMethod(Self, 'AggiornaCalendario');
  FrameScheduler.RefreshScheduler;
  RiSelezionaAule;
  SiMain.LeaveMethod(Self, 'AggiornaCalendario');
end;

procedure TFormPrenotazioniAule.CalendarioDragDrop(Sender, Source: TObject; X, Y: integer);

  function GetDragView(const Source: TObject): TzDbView;
  var
    grid: TcxCustomGridView;
  begin
    result := nil;

    if Source is TcxDragControlObject then
      if (TcxDragControlObject(Source).Control is TcxGridSite) then
      begin
        grid := TcxGridSite(TcxDragControlObject(Source).Control).GridView;

        if grid.Controller.Site.Container IS TcxGrid then
          result := TzDbView((grid.Controller.Site.Container aS TcxGrid).Parent);
      end;
  end;

var
  aula: string;
  FieldName: string;
  view: TzDbView;
  IdPrenotazione: integer;
  prenotazione: TcxSchedulerEvent;
  v: Variant;
begin
  inherited;

  view := GetDragView(Source);

  // if Assigned(view) then
  // begin
  // if view.SelectedCount > 0 then
  // begin
  // FieldName := '';
  //
  // if view = viewProgetti then
  // FieldName := 'ID_PROGETTO'
  // else
  // if view = viewRisorse then
  // FieldName := 'ID_RISORSA';
  //
  // v := view.DataController.FieldValue(FieldName);
  //
  // if HitTestIsPrenotazione then // update
  // PrenotazioniAule.UpdatePrenotazione(HitTestPrenotazione, FieldName, v)
  // else
  // if Calendario.CurrentView.HitTest.HitAtTime then // insert
  // begin
  // Aula := HitTestAula;
  // PrenotazioniAule.NuovaPrenotazione(Aula, DateOf(Calendario.CurrentView.HitTest.Time), TimeOf(Calendario.CurrentView.HitTest.Time), FieldName, v);
  // end;
  // end;
  // end
  // else
  // begin
  //
  // // spostamento dell'evento
  // if HitTestIsPrenotazione then
  // begin
  //
  // if PrenotazioniAule.SpostaPrenotazione(HitTestPrenotazione, HitTestAula, DateOf(Calendario.CurrentView.HitTest.Time), TimeOf(Calendario.CurrentView.HitTest.Time)) then
  // begin
  // // Spostato in frame prenotazione := GetEvento(tePrenotazioneAule, HitTestPrenotazione);
  // Calendario.SelectTime(prenotazione.Start, prenotazione.Finish, prenotazione.GetResourceItem);
  // end;
  // end;
  // end;
end;

procedure TFormPrenotazioniAule.dxBarButton22Click(Sender: TObject);
begin
  inherited;
  // cxExportSchedulerToHTML('C:\Users\Luca\Desktop\agenda.html', Calendario, False, True);
  // cxExportSchedulerToXLSX('C:\Users\Luca\Desktop\agenda.xslx', Calendario, False, True);
end;

procedure TFormPrenotazioniAule.FrameSchedulerSchedulerClick(Sender: TObject);
var
  Data: TDate;
  DalleOre, AlleOre: TTime;
  aula: string;
begin
  inherited;

  aula := '';

  if FrameScheduler.Scheduler.CurrentView.HitTest.HitAtEvent then
  begin
    Data := DateOf(FrameScheduler.Scheduler.CurrentView.HitTest.Event.Start);
    DalleOre := TimeOf(FrameScheduler.Scheduler.CurrentView.HitTest.Event.Start);
    AlleOre := TimeOf(FrameScheduler.Scheduler.CurrentView.HitTest.Event.Finish);

    if not varIsNull(FrameScheduler.Scheduler.CurrentView.HitTest.Event.ResourceID) then
      aula := FrameScheduler.Scheduler.CurrentView.HitTest.Event.ResourceID;
  end
  else
    if FrameScheduler.Scheduler.CurrentView.HitTest.HitAtTime then
    begin
      Data := DateOf(FrameScheduler.Scheduler.CurrentView.HitTest.Time);
      DalleOre := TimeOf(FrameScheduler.Scheduler.CurrentView.HitTest.Time);
      AlleOre := IncHour(TimeOf(FrameScheduler.Scheduler.CurrentView.HitTest.Time), 1);

      if assigned(FrameScheduler.Scheduler.CurrentView.HitTest.Resource) then
        if not varIsNull(FrameScheduler.Scheduler.CurrentView.HitTest.Resource.ResourceID) then
          aula := FrameScheduler.Scheduler.CurrentView.HitTest.Resource.ResourceID;
    end;

  if not aula.IsEmpty then
    edAula.EditValue := aula;

  edDalGiorno.Date := Data;
  edAlGiorno.Date := IncDay(Data, 30);
end;

procedure TFormPrenotazioniAule.CercaSlotLiberiExecute(Sender: TObject);
var
  aula: string;
  idSede: integer;
  dalGiorno, alGiorno: TDate;
  DalleOre, AlleOre: TTime;
  DurataEvento: integer;
  Granularita: integer;
begin
  inherited;

  if varIsNull(edAula.EditValue) then
    aula := ''
  else
    aula := edAula.EditValue;

  if varIsNull(edSede.EditValue) then
    idSede := -1
  else
    idSede := edSede.EditValue;

  if DateNull(edDalGiorno.Date) or DateNull(edAlGiorno.Date) then
  begin
    ConfirmOk('Intervallo date non specificato.');
    exit;
  end;

  dalGiorno := edDalGiorno.Date;
  alGiorno := edAlGiorno.Date;
  DalleOre := edDalleOre.Time;
  AlleOre := edAlleOre.Time;
  DurataEvento := edDurata.value;
  Granularita := edMinutiIncremento.value;

  PrenotazioniAule.CercaSlotLiberi(aula, idSede, dalGiorno, alGiorno, DalleOre, AlleOre, DurataEvento, Granularita);
end;

procedure TFormPrenotazioniAule.PrenotaAulaExecute(Sender: TObject);
begin
  inherited;

  // se edAula è vuoto non si può inserire massivamente
  // CercaSlotLiberi potrebbe decidere se viewSlotLiberi può andare in multiselect o meno

  if PrenotazioniAule.PrenotaAulaDaGiorniLiberi then
    FrameScheduler.SelezionaData(PrenotazioniAule.SlotLiberi.FieldByName('DATA').value);
end;

procedure TFormPrenotazioniAule.viewSlotLiberiDblClick(Sender: TObject);
begin
  inherited;
  PrenotaAula.Execute;
end;

procedure TFormPrenotazioniAule.edAulaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if edAula.EditingText = '' then
  begin
    edAula.clear;
    edAula.PostEditValue;
    PrenotazioniAule.lkFiltroAule.RevertSQL(True);
  end;
end;

procedure TFormPrenotazioniAule.edSedeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if edSede.EditingText = '' then
  begin
    edSede.clear;
    edSede.PostEditValue;
    PrenotazioniAule.lkFiltroSedi.RevertSQL(True);
  end;
end;

procedure TFormPrenotazioniAule.HelpEnumActions(Actions: TList<TContainedAction>);
begin
  inherited HelpEnumActions(Actions);

  Actions.add(FrameScheduler.Oggi);
  Actions.add(FrameScheduler.VaiAlGiorno);
  Actions.add(FrameScheduler.Precedente);
  Actions.add(FrameScheduler.Successivo);
  Actions.add(FrameScheduler.Giorno);
  Actions.add(FrameScheduler.Settimana);
  Actions.add(FrameScheduler.Mese);

  Actions.add(FrameScheduler.ExportXLS);
  Actions.add(FrameScheduler.Anteprima);
end;

procedure TFormPrenotazioniAule.FormShow(Sender: TObject);
var
  idx: integer;
  s: string;
begin
  SiMain.EnterMethod(Self, 'FormShow');
  inherited;

  // seleziona il primo, fa partire la selezione delle aule
  viewSelezionaAule.SelectRecord;

  SiMain.LeaveMethod(Self, 'FormShow');
end;

procedure TFormPrenotazioniAule.viewSelezionaAuleSelectionChanged(Sender: TObject);
begin
  inherited;

  TimerSelezione.Enabled := false;

  if not DisabilitaSelezioneAule then
    if Visible then
      TimerSelezione.Enabled := True;
end;

procedure TFormPrenotazioniAule.TimerSelezioneTimer(Sender: TObject);
var
  Aule: TList<String>;
begin
  SiMain.EnterMethod(Self, 'TimerSelezioneTimer');
  inherited;
  TimerSelezione.Enabled := false;

  DisabilitaSelezioneAule := True;
  try
    Aule := TList<String>.Create;
    try
      viewSelezionaAule.GetSelectedRows('AULA', Aule);
      PrenotazioniAule.SelezionaAule(Aule);
    finally
      FreeAndNil(Aule);
    end;
  finally
    DisabilitaSelezioneAule := false;
  end;
  SiMain.LeaveMethod(Self, 'TimerSelezioneTimer');
end;

procedure TFormPrenotazioniAule.RiSelezionaAule;
var
  aula: string;
begin
  SiMain.EnterMethod(Self, 'RiSelezionaAule');

  TimerSelezione.Enabled := false;

  DisabilitaSelezioneAule := True;
  try
    PrenotazioniAule.ElencoAule.UseSqlLocate := false;

    for aula in PrenotazioniAule.AuleSelezionate do
    begin
      if PrenotazioniAule.ElencoAule.Locate('Aula', aula, []) then
        viewSelezionaAule.SelectRecord;
    end;
  finally
    DisabilitaSelezioneAule := false;
  end;
  SiMain.LeaveMethod(Self, 'RiSelezionaAule');
end;

procedure TFormPrenotazioniAule.PrenotazionePeriodoExecute(Sender: TObject);
var
  aula: String;
begin
  inherited;

  aula := '';

  if assigned(FrameScheduler.Scheduler.SelResource) then
    if not varIsNull(FrameScheduler.Scheduler.SelResource.ResourceID) then
      aula := VarToStr(FrameScheduler.Scheduler.SelResource.ResourceID);

  if aula.IsEmpty then
    if PrenotazioniAule.AuleSelezionate.Count > 0 then
      aula := PrenotazioniAule.AuleSelezionate[0];

  PrenotazioniAule.GeneraPrenotazioniAule(aula);
end;

end.

  zDbView FrameScheduler

  zapplicationinspector
