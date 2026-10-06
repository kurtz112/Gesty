unit frmOrario;

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
  cxExportSchedulerLink,
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
  dxPScxEditorProducers,
  dxPScxExtEditorProducers,
  dxPSCore,
  dxPScxSchedulerLnk,
  dxPScxCommon,
  dxPScxTLLnk,
  dxPSdxSpreadSheetLnk,
  dxPSRichEditControlLnk,
  Base_Frame,
  zDbScheduler,
  dmScheduler.Tools,
  cxDBExtLookupComboBox,
  cxCheckBox,
  dxUIAClasses;

type
  TFormOrario = class(TBaseForm)
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
    ImportaFileUntis: TdxFileOpen;
    ElaboraFileUntis: TAction;
    layoutControlViewsGroup_Root: TdxLayoutGroup;
    layoutControlViews: TdxLayoutControl;
    viewMaterie: TzDbView;
    dxLayoutItemMaterie: TdxLayoutItem;
    viewDocenti: TzDbView;
    viewAule: TzDbView;
    dxLayoutItemDocenti: TdxLayoutItem;
    dxLayoutItemAule: TdxLayoutItem;
    layoutControlViewsSplitterItem1: TdxLayoutSplitterItem;
    layoutControlViewsSplitterItem2: TdxLayoutSplitterItem;
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
    ImportaFileStandard: TdxFileOpen;
    edProgetto: TcxExtLookupComboBox;
    edCorso: TcxExtLookupComboBox;
    FrameScheduler: TzDbScheduler;
    ApriGeneraCalendario: TAction;
    layoutGenerazione: TdxLayoutControl;
    edDalGiorno: TcxDateEdit;
    edAlGiorno: TcxDateEdit;
    tnOk: TcxButton;
    checkLunedi: TcxCheckBox;
    checkMartedi: TcxCheckBox;
    checkMercoledi: TcxCheckBox;
    checkGiovedi: TcxCheckBox;
    checkVenerdi: TcxCheckBox;
    checkSabato: TcxCheckBox;
    checkDomenica: TcxCheckBox;
    layoutGenerazioneGroup_Root: TdxLayoutGroup;
    dxLayoutItemDataInizio: TdxLayoutItem;
    dxLayoutItemDataFine: TdxLayoutItem;
    dxLayoutItemLabelLunedi: TdxLayoutItem;
    dxLayoutItemLabelMartedi: TdxLayoutItem;
    dxLayoutItemLabelMercoledi: TdxLayoutItem;
    dxLayoutItemLabelDomenica: TdxLayoutItem;
    dxLayoutItemLabelSabato: TdxLayoutItem;
    dxLayoutItemLabelVenerdi: TdxLayoutItem;
    dxLayoutItemLabelGiovedi: TdxLayoutItem;
    dxLayoutItemOk: TdxLayoutItem;
    layoutGenerazioneEmptySpaceItem2: TdxLayoutEmptySpaceItem;
    layoutGenerazioneGroup1: TdxLayoutGroup;
    layoutGenerazioneGroup2: TdxLayoutGroup;
    layoutGenerazioneGroup3: TdxLayoutGroup;
    layoutGenerazioneGroup4: TdxLayoutGroup;
    GeneraCalendario: TAction;
    layoutGenerazioneEmptySpaceItem1: TdxLayoutEmptySpaceItem;
    dxLayoutGroupGenerazione: TdxLayoutGroup;
    AzzeraTmpOrario: TAction;
    RegistroStudenti: TAction;
    edEnte: TcxExtLookupComboBox;
    edProgettoCodReg: TcxExtLookupComboBox;
    EliminaCalendario: TAction;
    btnEliminaCalendario: TcxButton;
    dxLayoutItemEliminaCalendario: TdxLayoutItem;
    dxLayoutGenerazionePulsanti: TdxLayoutGroup;
    dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem;
    procedure edProgettoPropertiesEditValueChanged(Sender: TObject);
    procedure AutoDropDown(Sender: TObject);
    procedure ElaboraFileUntisExecute(Sender: TObject);
    procedure ImportaFileUntisAccept(Sender: TObject);
    procedure edCorsoPropertiesEditValueChanged(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FrameSchedulerSchedulerClick(Sender: TObject);
    procedure FrameSchedulerSchedulerDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure ApriGeneraCalendarioExecute(Sender: TObject);
    procedure AzzeraTmpOrarioExecute(Sender: TObject);
    procedure GeneraCalendarioExecute(Sender: TObject);
    procedure ImportaFileStandardAccept(Sender: TObject);
    procedure edDalGiornoPropertiesEditValueChanged(Sender: TObject);
    procedure edAlGiornoPropertiesEditValueChanged(Sender: TObject);
    procedure edGeneraCalendarioEditValueChanged(Sender: TObject);
    procedure RegistroStudentiExecute(Sender: TObject);
    procedure edEntePropertiesEditValueChanged(Sender: TObject);
    procedure edProgettoCodRegPropertiesEditValueChanged(Sender: TObject);
    procedure EliminaCalendarioExecute(Sender: TObject);
    procedure FrameSchedulerSchedulerDragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: Boolean);
  private
    DisabilitaCalendario: Boolean;
  private
    procedure SetGeneraCalendarioVisible(const Visible: Boolean);
    procedure SyncGeneraCalendarioParams;
  private
    procedure AggiornaCalendario;
    function GetDataSelezionata: TDateTime;
    function GetDragView(const Source: TObject): TzDbView;
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure AfterCreateControls; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure Aggiorna; override;

    procedure OpenCalendarioCorsi(aDataLezione: TDateTime; const aIdProgetto, aIdCorso: integer);
  end;

implementation

uses
  Gesty.Scheduler,
  System.DateUtils,
  cxSchedulerDialogs,
  cxSchedulerOutlookExchange,
  cxLookupDBGrid,
  dmOrario,
  zDm_Images,
  zDX,
  zBaseLib,
  Gesty.Types,
  zFbDataSet,
  MDI_Lib,
  frmRegistroStudenti,
  zMsg;

{$R *.dfm}
{ TFormOrario }

var
  FormOrario: TFormOrario;

procedure TFormOrario.CreateDataModule;
begin
  inherited;
  CreateDM(TOrario, Orario);
  // il modulo dati resta quello di sempre: il ponte Gesty.Scheduler lo adatta
  // al calendario di zPack
  FrameScheduler.Init(TGestyScheduler.Storage(Orario), TGestyScheduler.CopiaIncolla(Orario));
end;

procedure TFormOrario.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Orario);
end;

constructor TFormOrario.Create(aOwner: TComponent);
begin
  inherited;
  FormController.SkipSelectFirstNode := True;

  edEnte.Visible := False;
  edEnte.Parent := Self;
  edProgetto.Visible := False;
  edProgetto.Parent := Self;
  edProgettoCodReg.Visible := False;
  edProgettoCodReg.Parent := Self;
  edCorso.Visible := False;
  edCorso.Parent := Self;

  FrameScheduler.Visible := False;
  FrameScheduler.Parent := Self;
  // Mantis #203 - 2026-10-02: il calendario di zPack sta nel .dfm come componente semplice,
  // come TzDbView: le personalizzazioni del calendario si impostano qui e non nel .dfm
  FrameScheduler.Scheduler.DateNavigator.ColCount := 1;
  FrameScheduler.Scheduler.OnClick := FrameSchedulerSchedulerClick;
  FrameScheduler.Scheduler.OnDragDrop := FrameSchedulerSchedulerDragDrop;
  FrameScheduler.Scheduler.OnDragOver := FrameSchedulerSchedulerDragOver;
  FrameScheduler.AddToolbarButton(ApriGeneraCalendario).ButtonStyle := bsChecked;
  FrameScheduler.AddToolbarButton(RegistroStudenti);

  layoutControlViews.Visible := False;
  layoutControlViews.Parent := Self;

  layoutGenerazione.Visible := False;
  layoutGenerazione.Parent := Self;
  ApriGeneraCalendario.Checked := False;

  // edProgetto.Style.StyleController := dx.LargeStyleController;
  // edProgetto.Style.Font.Size := 11;
  // edCorso.Style.StyleController := dx.LargeStyleController;
  // edCorso.Style.Font.Size := 11;

  dx.InitLayoutControl(layoutControlViews);
  dx.InitLayoutControl(layoutGenerazione);

  viewMaterie.zDataSet := Orario.lkMaterie;
  viewMaterie.cxGridDBTableView.DragMode := dmAutomatic;

  viewDocenti.zDataSet := Orario.lkDocenti;
  viewDocenti.cxGridDBTableView.DragMode := dmAutomatic;

  viewAule.zDataSet := Orario.lkAule;
  viewAule.cxGridDBTableView.DragMode := dmAutomatic;

  DisabilitaCalendario := True;
  try
    dx.InitLookup('', edEnte, Orario.lkEnti, Orario.lkEntiSrc, 'ID_ENTE', 'ID_ENTE');

    dx.InitLookup('', edProgetto, Orario.lkProgetti, Orario.lkProgettiSrc, 'ID_PROGETTO', 'DENOMINAZIONE_PROGETTO;CODICE_REGIONALE;ANNO_FORMATIVO');
    edProgetto.EditValue := Orario.IdProgetto;

    dx.InitLookup('', edProgettoCodReg, Orario.lkProgettiCodReg, Orario.lkProgettiCodRegSrc, 'ID_PROGETTO', 'CODICE_REGIONALE;DENOMINAZIONE_PROGETTO;ANNO_FORMATIVO');
    edProgettoCodReg.EditValue := Orario.IdProgetto;

    dx.InitLookup('', edCorso, Orario.lkCorsi, Orario.lkCorsiSrc, 'ID_CORSO', 'DESC_CORSO_COMPLETA;ID_CORSO');
    edCorso.EditValue := Orario.IdCorso;
  finally
    DisabilitaCalendario := False;
  end;
end;

procedure TFormOrario.AfterCreateControls;
begin
  inherited;
  AddLayoutItem(edEnte, 'Ente', False);
  AddLayoutItem(edProgetto, 'Progetto', False);
  AddLayoutItem(edProgettoCodReg, 'ProgettoCodReg', False);
  AddLayoutItem(edCorso, 'Corso', False);
  AddLayoutItem(FrameScheduler, 'Calendario', False);
  AddLayoutItem(layoutControlViews, 'Viste', False);
  AddLayoutItem(layoutGenerazione, 'Generazione', False);
end;

procedure TFormOrario.ElaboraFileUntisExecute(Sender: TObject);
var
  files: TList<integer>;
  view: TzDbView;
begin
  inherited;

  view := GetView('Orario_Files');

  if view.SelectedCount = 0 then
    exit;

  if not ConfirmYesNo('Si desidera elaborare i files selezionati?') then
    exit;

  files := TList<integer>.Create;
  try
    view.GetSelectedRows('ID_ORARIO_IMPORT_FILE_UNTIS', files);
    Orario.ElaboraFileUntis(files);
  finally
    FreeAndNil(files);
  end;
end;

procedure TFormOrario.ImportaFileUntisAccept(Sender: TObject);
begin
  inherited;
  Orario.ImportaFileUntis(ImportaFileUntis.Dialog.files);
end;

procedure TFormOrario.Aggiorna;
begin
  inherited;
  Orario.RefreshScheduler;
end;

function TFormOrario.GetDragView(const Source: TObject): TzDbView;
var
  grid: TcxCustomGridView;
begin
  Result := nil;

  if Source is TcxDragControlObject then
    if (TcxDragControlObject(Source).Control is TcxGridSite) then
    begin
      grid := TcxGridSite(TcxDragControlObject(Source).Control).GridView;
      if grid.Controller.Site.Container IS TcxGrid then
        Result := TzDbView((grid.Controller.Site.Container aS TcxGrid).Parent);
    end;
end;

procedure TFormOrario.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'Orario_Files') then
    // begin
      // view.AddAction(ImportaFileUntis, zDmImages.ImageList16).HideInCard;
      // view.AddAction(ElaboraFileUntis, zDmImages.ImageList16);
      // view.InitToolActions;
    // end
    // else
      // if SameText(DataSetName, 'Orario_Import_Files') then
      // begin
        // view.AddAction(ImportaFileStandard, zDmImages.ImageList16).HideInCard;
        // view.InitToolActions;
      // end
      // else
        // if SameText(DataSetName, 'Tmp_Orario') then
        // begin
          // view.AddAction(AzzeraTmpOrario, zDmImages.ImageList16).HideInCard;
          // view.InitToolActions;
        // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormOrario.AggiornaCalendario;
begin
  FrameScheduler.RefreshScheduler;
end;

procedure TFormOrario.edAlGiornoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  SyncGeneraCalendarioParams
end;

procedure TFormOrario.FormShow(Sender: TObject);
begin
  inherited;
  AggiornaCalendario;
  SetGeneraCalendarioVisible(False);
end;

procedure TFormOrario.ImportaFileStandardAccept(Sender: TObject);
begin
  inherited;
  Orario.ImportaFiles(ImportaFileStandard.Dialog.files);
end;

procedure TFormOrario.FrameSchedulerSchedulerClick(Sender: TObject);
var
  Data: TDate;
  DalleOre, AlleOre: TTime;
begin
  inherited;

  Data := NullDate;

  if FrameScheduler.Scheduler.CurrentView.HitTest.HitAtEvent then
  begin
    Data := DateOf(FrameScheduler.Scheduler.CurrentView.HitTest.Event.Start);
    DalleOre := TimeOf(FrameScheduler.Scheduler.CurrentView.HitTest.Event.Start);
    AlleOre := TimeOf(FrameScheduler.Scheduler.CurrentView.HitTest.Event.Finish);
    Orario.SelezionaLezionePerViews(Data, DalleOre, AlleOre);
  end
  else
    if FrameScheduler.Scheduler.CurrentView.HitTest.HitAtTime then
    begin
      Data := DateOf(FrameScheduler.Scheduler.CurrentView.HitTest.Time);
      DalleOre := TimeOf(FrameScheduler.Scheduler.CurrentView.HitTest.Time);
      AlleOre := IncHour(TimeOf(FrameScheduler.Scheduler.CurrentView.HitTest.Time), 1);
      Orario.SelezionaLezionePerViews(Data, DalleOre, AlleOre);
    end;

  if ApriGeneraCalendario.Checked then
    if Data <> NullDate then
      if edDalGiorno.Date = edAlGiorno.Date then
        edDalGiorno.Date := Data;
end;

procedure TFormOrario.FrameSchedulerSchedulerDragDrop(Sender, Source: TObject; X, Y: integer);
var
  evento: TcxSchedulerEvent;
  FieldName3: string;
  FieldName4: string;
  view: TzDbView;
  idOrario: integer;
  value3, value4: variant;
  t: TDateTime;
  params: TEventoParams;
begin
  FrameScheduler.SchedulerDragDrop(Sender, Source, X, Y);

  if Orario.IdProgetto = -1 then
  begin
    ConfirmOk('Nessun progetto selezionato.');
    exit;
  end;

  params.Init;
  params.TipoEvento := teOrarioLezione;
  params.FieldName1 := 'ID_PROGETTO';
  params.Value1 := Orario.IdProgetto;

  view := GetDragView(Source);

  if Assigned(view) then
    if view.SelectedCount > 0 then
    begin

      if Orario.IdCorso <> -1 then
      begin
        params.FieldName2 := 'ID_CORSO';
        params.Value2 := Orario.IdCorso;
      end;

      FieldName3 := '';
      FieldName4 := '';

      if view = viewMaterie then
      begin
        FieldName3 := 'MATERIA';
        FieldName4 := 'ID_DOCENTE';
      end
      else
        if view = viewDocenti then
          FieldName3 := 'ID_DOCENTE'
        else
          if view = viewAule then
            FieldName3 := 'AULA';

      value3 := view.DataController.FieldValue(FieldName3);

      if not FieldName4.IsEmpty then
        value4 := view.DataController.FieldValue(FieldName4);

      if (view = viewAule) and (FrameScheduler.Scheduler.CurrentView.HitTest is TcxSchedulerDayViewHitTest) and (TcxSchedulerDayViewHitTest(FrameScheduler.Scheduler.CurrentView.HitTest).HitAtDayHeader)
      then
      begin
        // se selezionano l'header assegnano l'aula per tutto il giorno

        Orario.AssegnaAulaPerIlGiorno(DateOf(FrameScheduler.Scheduler.CurrentView.HitTest.Time), value3);
      end
      else
        if FrameScheduler.Scheduler.CurrentView.HitTest.HitAtEvent then // update
        begin
          params.id := FrameScheduler.HitTestIdEvento(FrameScheduler.Scheduler.CurrentView.HitTest.Event);
          params.FieldName3 := FieldName3;
          params.value3 := value3;
          params.FieldName4 := FieldName4;
          params.value4 := value4;

          if SchedulerTools.UpdateEvento(params) then
            AggiornaCalendario;
        end
        else
          if FrameScheduler.Scheduler.CurrentView.HitTest.HitAtTime then // insert
          begin
            params.id := -1;
            params.Data := DateOf(FrameScheduler.Scheduler.CurrentView.HitTest.Time);
            params.OraInizio := TimeOf(FrameScheduler.Scheduler.CurrentView.HitTest.Time);
            params.Durata := 60;

            params.FieldName3 := FieldName3;
            params.value3 := value3;
            params.FieldName4 := FieldName4;
            params.value4 := value4;

            if SchedulerTools.ApriEvento(params) then
              AggiornaCalendario;
          end;
    end;
end;

procedure TFormOrario.ApriGeneraCalendarioExecute(Sender: TObject);
begin
  SetGeneraCalendarioVisible(ApriGeneraCalendario.Checked);
end;

procedure TFormOrario.AzzeraTmpOrarioExecute(Sender: TObject);
begin
  inherited;
  Orario.ClearTmpOrario;
end;

procedure TFormOrario.SetGeneraCalendarioVisible(const Visible: Boolean);
var
  Data: TDateTime;
  item: TdxCustomLayoutItem;
  grp: TdxCustomLayoutGroup;
begin

  if Visible then
    if Orario.IdProgetto = -1 then
    begin
      ApriGeneraCalendario.Checked := False;
      ConfirmOk('Nessun progetto selezionato');
      exit;
    end;

  item := FormController.LayoutController.FindCustomItem('dxLayoutSplitterGenerazioneCalendario');

  if Assigned(item) then
    item.Visible := Visible;

  grp := FormController.LayoutController.FindGroup('dxLayoutGroupGenerazioneCalendario');

  if Assigned(grp) then
    grp.Visible := Visible;

  if Visible then
  begin
    Data := GetDataSelezionata();

    edDalGiorno.Date := Data;
    edAlGiorno.Date := Data;
  end;
end;

procedure TFormOrario.edDalGiornoPropertiesEditValueChanged(Sender: TObject);
var
  d: integer;
begin
  inherited;
  edAlGiorno.Date := edDalGiorno.Date;

  d := DayOfTheWeek(edAlGiorno.Date);
  checkLunedi.Checked := d = 1;
  checkMartedi.Checked := d = 2;
  checkMercoledi.Checked := d = 3;
  checkGiovedi.Checked := d = 4;
  checkVenerdi.Checked := d = 5;
  checkSabato.Checked := d = 6;
  checkDomenica.Checked := d = 7;
  //

  SyncGeneraCalendarioParams;
end;

procedure TFormOrario.edGeneraCalendarioEditValueChanged(Sender: TObject);
begin
  inherited;
  SyncGeneraCalendarioParams;
end;

procedure TFormOrario.GeneraCalendarioExecute(Sender: TObject);
begin
  inherited;

  if ConfirmYesNo('Si desidera generare il calendario corsi?') then
  begin
    SyncGeneraCalendarioParams;
    Orario.GeneraCalendario;
  end;
end;

procedure TFormOrario.SyncGeneraCalendarioParams;
begin
  Orario.GeneraCalendarioParams.DalGiorno := edDalGiorno.Date;
  Orario.GeneraCalendarioParams.AlGiorno := edAlGiorno.Date;
  Orario.GeneraCalendarioParams.lunedi := checkLunedi.Checked;
  Orario.GeneraCalendarioParams.martedi := checkMartedi.Checked;
  Orario.GeneraCalendarioParams.mercoledi := checkMercoledi.Checked;
  Orario.GeneraCalendarioParams.giovedi := checkGiovedi.Checked;
  Orario.GeneraCalendarioParams.venerdi := checkVenerdi.Checked;
  Orario.GeneraCalendarioParams.sabato := checkSabato.Checked;
  Orario.GeneraCalendarioParams.domenica := checkDomenica.Checked;
end;

function TFormOrario.GetDataSelezionata: TDateTime;
begin
  Result := Orario.DataSelezionata;

  if DateOf(Result) = NullDate then
    Result := FrameScheduler.FirstVisibleDate;

  if DateOf(Result) = NullDate then
    Result := StartOfTheWeek(Date);
end;

procedure TFormOrario.AutoDropDown(Sender: TObject);
begin
  inherited;

  if Sender is TcxExtLookupComboBox then
    TcxExtLookupComboBox(Sender).DroppedDown := True;
end;

procedure TFormOrario.OpenCalendarioCorsi(aDataLezione: TDateTime; const aIdProgetto, aIdCorso: integer);
begin
  FrameScheduler.SelezionaData(aDataLezione);

  edEnte.Clear;

  edProgetto.EditValue := aIdProgetto;
  edProgettoCodReg.EditValue := aIdProgetto;

  if aIdCorso = -1 then
    edCorso.Clear
  else
    edCorso.EditValue := aIdCorso;

  // Orario.IdProgetto := aIdProgetto;
  // Orario.IdCorso := aIdCorso;
end;

procedure TFormOrario.edEntePropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if DisabilitaCalendario then
    exit;

  if varIsNull(edEnte.EditValue) then
    Orario.FiltroEnte := -1
  else
    Orario.FiltroEnte := edEnte.EditValue;

  edEnte.SelStart := 0;

  edProgetto.Clear;
  edProgettoCodReg.Clear;
  edCorso.Clear;
end;

procedure TFormOrario.edProgettoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  if DisabilitaCalendario then
    exit;

  edProgettoCodReg.Properties.OnEditValueChanged := nil;
  try
    edProgettoCodReg.EditValue := edProgetto.EditValue;
  finally
    edProgettoCodReg.Properties.OnEditValueChanged := edProgettoCodRegPropertiesEditValueChanged;
  end;

  edProgetto.SelStart := 0;

  if varIsNull(edProgetto.EditValue) then
    Orario.IdProgetto := -1
  else
    Orario.IdProgetto := edProgetto.EditValue;

  edCorso.Clear;
end;

procedure TFormOrario.edProgettoCodRegPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if DisabilitaCalendario then
    exit;

  edProgetto.Properties.OnEditValueChanged := nil;
  try
    edProgetto.EditValue := edProgettoCodReg.EditValue;
  finally
    edProgetto.Properties.OnEditValueChanged := edProgettoPropertiesEditValueChanged;
  end;

  edProgettoCodReg.SelStart := 0;

  if varIsNull(edProgettoCodReg.EditValue) then
    Orario.IdProgetto := -1
  else
    Orario.IdProgetto := edProgettoCodReg.EditValue;

  edCorso.Clear;
end;

procedure TFormOrario.edCorsoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  if DisabilitaCalendario then
    exit;

  if varIsNull(edCorso.EditValue) then
    Orario.IdCorso := -1
  else
    Orario.IdCorso := edCorso.EditValue;
end;

procedure TFormOrario.FrameSchedulerSchedulerDragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: Boolean);
begin
  inherited;
  FrameScheduler.SchedulerDragOver(Sender, Source, X, Y, State, Accept);
end;

procedure TFormOrario.RegistroStudentiExecute(Sender: TObject);
var
  FormRegistroStudenti: TFormRegistroStudenti;
begin
  inherited;

  if FormCollection.FormExists(TFormRegistroStudenti) then
    FormRegistroStudenti := FormCollection.GetForm(TFormRegistroStudenti) as TFormRegistroStudenti
  else
    FormRegistroStudenti := FormCollection.CreateForm(TFormRegistroStudenti) as TFormRegistroStudenti;

  FormRegistroStudenti.ShowForm(False);

  FormRegistroStudenti.OpenRegistro(GetDataSelezionata, Orario.IdProgetto, Orario.IdCorso);
end;

procedure TFormOrario.EliminaCalendarioExecute(Sender: TObject);
begin
  inherited;

  if ConfirmYesNo('Si desidera eliminare il calendario corsi?') then
  begin
    SyncGeneraCalendarioParams;
    Orario.EliminaCalendario;
  end;
end;

end.

  Data progetto corso zDbView
