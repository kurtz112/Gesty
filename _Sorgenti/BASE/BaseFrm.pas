unit BaseFrm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  System.Variants,
  System.Diagnostics,
  System.Generics.Collections,
  System.Actions,
  System.ImageList,
  System.JSON,
  Vcl.Graphics,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.ActnList,
  Vcl.ExtCtrls,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.Menus,
  Vcl.Mask,
  Vcl.StdCtrls,
  Vcl.ImgList,
  Data.DB,
  dxBar,
  dxBarExtItems,
  dxSkinsCore,
  dxSkinsdxBarPainter,
  dxRibbonForm,
  dxLayoutContainer,
  dxLayoutControl,
  dxDateRanges,
  dxScrollbarAnnotations,
  cxPC,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxClasses,
  cxLabel,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxNavigator,
  cxDBData,
  cxGridLevel,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  cxImageList,
  dxUIAClasses,
  Base_DataModule,
  zDbCard,
  ActionListController,
  zDbView,
  PageControlController,
  Base_Frame,
  zFormController,
  zSystem,
  zRestrictions,
  zFbDataSet,
  zDbPivot,
  zDbRecordView,
  zDbTree,
  zDbChart,
  zDbScheduler,
  zFileViewer,
  HelpGen.types,
  zOffice.Reports.BatchController,
  SmartInspect.Vcl,
  SmartInspect.Vcl.SiAuto,
  zOffice.MultiViewer;

type
  // TBaseForm = class(TdxRibbonForm, IRestriction)
  TBaseForm = class(TForm, IRestriction, IHelpSubject)
    barFree: TdxBar;
    barSistema: TdxBar;
    barTitolo: TdxBar;
    btnAggiorna: TdxBarButton;
    btnEsci: TdxBarButton;
    btnStampa: TdxBarButton;
    dxBarButtonControllerBuildGui: TdxBarButton;
    dxBarButtonControllerEditDatamodule: TdxBarButton;
    dxBarButtonControllerEditLayout: TdxBarButton;
    dxBarButtonControllerLoadFromIni: TdxBarButton;
    dxBarButtonControllerResetToDefault: TdxBarButton;
    dxBarButtonControllerSaveToIni: TdxBarButton;
    dxBarButtonPoliticheAccessi: TdxBarButton;
    dxBarButtonRicaricaPolitiche: TdxBarButton;
    dxBarButtonSistema: TdxBarButton;
    dxBarControlContainerTitolo: TdxBarControlContainerItem;
    dxBarLargeButtonAggiorna: TdxBarLargeButton;
    dxBarLargeButtonEsci: TdxBarLargeButton;
    dxBarLargeButtonStampa: TdxBarLargeButton;
    dxBarManager: TdxBarManager;
    dxBarSubItemController: TdxBarSubItem;
    dxBarSubItemPoliticheAccessi: TdxBarSubItem;
    dxBarSubItemSistema: TdxBarSubItem;
    lblTitolo: TcxLabel;
    dxBarButtonControllerMostraDimensioni: TdxBarButton;
    dxBarButtonControllerResetDimensioni: TdxBarButton;
    btnHelp: TdxBarButton;
    dxBarButton2: TdxBarButton;
    btnScreenshot: TdxBarButton;
    barBtnPermessiAzione: TdxBarButton;
    BaseActions: TActionList;
    actAggiorna: TAction;
    actStampa: TAction;
    actVisualizzaGuida: TAction;
    actEsci: TAction;
    actSistema: TAction;
    actPoliticheAccessi: TAction;
    actRicaricaPolitiche: TAction;
    ControllerEditDatamodule: TAction;
    ControllerEditLayout: TAction;
    ControllerResetToDefault: TAction;
    ControllerLoadFromIni: TAction;
    ControllerSaveToIni: TAction;
    ControllerBuildGui: TAction;
    ControllerMostraDimensioni: TAction;
    ControllerResetDimensioni: TAction;
    Help: TAction;
    actScreenshot: TAction;
    actPermessiAzione: TAction;
    popActions: TdxBarPopupMenu;
    actProprietaAzione: TAction;
    dxBarButtonProprietaAzione: TdxBarButton;
    dxBarButtonNovita: TdxBarButton;
    actSalvaComponenti: TAction;
    dxBarButtonSalvaComponenti: TdxBarButton;
    Guide: TAction;
    dxBarSubItemGuide: TdxBarButton;
    dxBarButtonAI: TdxBarButton;
    AI: TAction;
    procedure ActAggiornaExecute(Sender: TObject);
    procedure ActEsciExecute(Sender: TObject);
    procedure ActionUpdateAdmin(Sender: TObject);
    procedure actPermessiAzioneExecute(Sender: TObject);
    procedure ActPoliticheAccessiExecute(Sender: TObject);
    procedure actProprietaAzioneExecute(Sender: TObject);
    procedure ActRicaricaPoliticheExecute(Sender: TObject);
    procedure actSalvaComponentiExecute(Sender: TObject);
    procedure actSistemaExecute(Sender: TObject);
    procedure ActStampaExecute(Sender: TObject);
    procedure BaseActionsUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure ControllerBuildGuiExecute(Sender: TObject);
    procedure ControllerEditDatamoduleExecute(Sender: TObject);
    procedure ControllerEditLayoutExecute(Sender: TObject);
    procedure ControllerLoadFromIniExecute(Sender: TObject);
    procedure ControllerMostraDimensioniExecute(Sender: TObject);
    procedure ControllerResetDimensioniExecute(Sender: TObject);
    procedure ControllerResetToDefaultExecute(Sender: TObject);
    procedure ControllerSaveToIniExecute(Sender: TObject);
    procedure dxBarManagerBarVisibleChange(Sender: TdxBarManager; ABar: TdxBar);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HelpExecute(Sender: TObject);
    procedure lblTitoloDblClick(Sender: TObject);
    procedure actScreenshotExecute(Sender: TObject);
    procedure AIExecute(Sender: TObject);
    procedure GuideExecute(Sender: TObject);
    procedure TitoloDblClick(Sender: TObject);
    procedure popActionsPopup(Sender: TObject);
  private
    procedure ApplyRestrictions;
    function GetRestrictionManager: TRestrictionManager;
  private
    FAutoOpenDataSets: Boolean;
    FBusy: Boolean;
    FDM: TBaseDataModule;
    FEnterAsTab: Boolean;
    FLoading: Boolean;
    FPK: Variant;
    FPkField: string;
    FReportGroup: string;
    FTitolo: String;
    FzFormController: TzFormController;
    ShouldSaveController: Boolean;
    TimerGui: TTimer;
    TimerToolbars: TTimer;
    procedure doCreateDataModule;
    //
    procedure LoadFormOptions;
    procedure SetBusy(const Value: Boolean);
    procedure SetTitolo(const Value: String);
    procedure TimerGuiTimer(Sender: TObject);
    procedure TimerToolbarsTimer(Sender: TObject);
    procedure TreeSelect(Sender: TObject);
    procedure WMSize(var M: TWMSIZE); message WM_Size;
  protected
    ActionListController: TActionListController;
    PageControlController: TPageControlController;
    RestrictionManager: TRestrictionManager;
    procedure Activate; override;
    procedure ApplyPK; virtual;
    procedure BuildGui; virtual;
    procedure BuildGuiDelayed; virtual;
    procedure CreateDataModule; virtual;
    procedure CreateDM(InstanceClass: TBaseDataModuleClass; var Reference);
    procedure DestroyDataModule; virtual;
    procedure DoClose(var Action: TCloseAction); override;
    procedure ExpandButtonActivated(Sender: TObject);
    function GetCard(const DataSetName: string; const CardID: string = ''): TzDbCard;
    function GetView(const DataSetName: string; const ViewID: string = ''): TzDbView;
    function GetPivot(const DataSetName: string; const PivotID: string = ''): TzDbPivot;
    function GetRecordView(const DataSetName: string; const RecordViewID: string = ''): TzDbRecordView;
    function GetTree(const DataSetName: string; const TreeID: string = ''): TzDbTree;
    function GetChart(const DataSetName: string; const ChartID: string = ''): TzDbChart;
    // Calendario del dizionario LZ (non i frame TzDbScheduler messi nel .dfm)
    function GetScheduler(const DataSetName: string; const SchedulerID: string = ''): TzDbScheduler;

    function FindAction(const ActionName: string): TCustomAction;

    procedure HideToolbars;
    procedure InitFrame(Frame: TBaseFrame; aParent: TWinControl);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure LoadFromIni; virtual;
    function PkMode: Boolean;
    procedure RealignToolbars;
    procedure RealignToolbarsDelayed;
    procedure SaveToIni; virtual;
    procedure SetIdCard(Card: TzDbCard);
    procedure SetPK(const Value: Variant); virtual;
    property Busy: Boolean read FBusy write SetBusy;
    property EnterAsTab: Boolean read FEnterAsTab write FEnterAsTab;
    property Loading: Boolean read FLoading write FLoading;
    procedure DatasetSelected(DiagramDataSet: TzDiagramDataSet); virtual;
  private
    procedure OnAfterCreateControls(Sender: TObject);
    procedure OnAfterCreateComponent(zFormController: TzFormController; LayoutController: TLayoutController; const DataSetName: String; Component: TComponent);
    procedure OnAfterLayoutControlLoadProps(Sender: TObject);

    procedure OnDatasetAssigned(zFormController: TzFormController; const DataSetName: String; Component: TComponent);
  protected
    procedure AfterCreateControls; virtual;
    procedure AfterLayoutControlLoadProps; virtual; { TODO : Trasformare in AfterLayoutControlLoaded }
    procedure AfterCreateComponent(const DataSetName: String; Component: TComponent); // virtual;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); virtual;

    procedure SetupComponent(const DataSetName: String; Component: TComponent); virtual;

    // procedure AfterCreateView(const DataSetName: String; Component: TComponent); virtual;
    // procedure AfterCreateCard(const DataSetName: String; Component: TComponent); virtual;
    // procedure AfterCreateFileViewer(const DataSetName: String; Component: TComponent); virtual;
    // function GetDataSet(Const DataSetName: string; DataSet: TzFbDataSet): TzFbDataSet;
    function GetDataSet(Const DataSetName: string): TzFbDataSet;
    procedure DatasetAssigned(const DataSetName: String; Component: TComponent); virtual;
    function AddLayoutItem(Control: TControl; Caption: string; const CaptionVisible: Boolean = True): TdxLayoutItem;

  protected
    procedure ConfiguraAzioniDocumentali(zMultiViewer: TzMultiViewer); virtual;
    procedure OnImportFile(Sender: TzFileViewer; const FileName: string);
    procedure OnImportFileMulti(Sender: TzMultiViewer; const FileName: string);

    procedure doImportFile(zFileViewer: TzFileViewer; const FileName: string); virtual;
    procedure doImportFileMulti(zMultiViewer: TzMultiViewer; const FileName: string); virtual;
  protected
    procedure BeforeShow; virtual;
    procedure AfterShowForm(const Modal: Boolean); virtual;
  protected
    FSelectedDataSetName: String;
    procedure SetSelectedDataSetName(const Value: string); virtual;
    function GetSelectedDataSetName: string; virtual;
  public
    function HelpFolder: string; // IHelpSubject
    function IHelpSubject.HelpFolder = HelpFolder;
    //
    function HelpFilename: string; // IHelpSubject
    function IHelpSubject.HelpFilename = HelpFilename;
    //
    procedure HelpInitGen;
    procedure IHelpSubject.HelpInitGen = HelpInitGen;
    //
    procedure HelpDoneGen;
    procedure IHelpSubject.HelpDoneGen = HelpDoneGen;
    //
    function HelpCaption: string;
    function IHelpSubject.HelpCaption = HelpCaption;
    //
    function HelpModuleName: string;
    function IHelpSubject.HelpModuleName = HelpModuleName;
    //
    function HelpScreenShot: TBitmap;
    function IHelpSubject.HelpScreenShot = HelpScreenShot;
    //
    function HelpMenuItems: string;
    function IHelpSubject.HelpMenuItems = HelpMenuItems;
    //
    procedure HelpEnumActions(Actions: TList<TContainedAction>); virtual;
    procedure IHelpSubject.HelpEnumActions = HelpEnumActions;

    function HelpGetAction(const ActionName: string): TCustomAction;
    function IHelpSubject.HelpGetAction = HelpGetAction;

    function HelpDescribeForm: string;
    function IHelpSubject.HelpDescribeForm = HelpDescribeForm;
    function HelpDescribeContext: string;
    function IHelpSubject.HelpDescribeContext = HelpDescribeContext;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AfterConstruction; override;
    procedure Aggiorna; virtual;
    procedure Annulla(const ReopenDataSets: Boolean; const Verbose: Boolean); virtual;
    procedure CloseDataSets; virtual;
    function CloseQuery: Boolean; override;
    function Modificato: Boolean; virtual;
    procedure OpenDataSets(const silent: Boolean = false); virtual;
    function Salva: Boolean; virtual;
    function IsShortCut(var Message: TWMKey): Boolean; override;
    procedure Stampa; virtual;
    procedure Print(ReportGroup: string; SelectedDataSetName: string); virtual;
    procedure UpdatePolicies;
    procedure ParamChanged(params: array of string); virtual;

    function ShowForm(const Modal: Boolean): Boolean; virtual;
  public
    property DM: TBaseDataModule read FDM;
    property AutoOpenDataSets: Boolean read FAutoOpenDataSets write FAutoOpenDataSets;
    property FormController: TzFormController read FzFormController;

    property SelectedDataSetName: string read GetSelectedDataSetName write SetSelectedDataSetName;

    property PK: Variant read FPK write SetPK;
    property PkField: string read FPkField write FPkField;
    property ReportGroup: string read FReportGroup write FReportGroup;
    property Titolo: String read FTitolo write SetTitolo;
  end;

implementation

uses
  Vcl.DBGrids,
  Vcl.Clipbrd,
  cxDropDownEdit,
  MDI_Lib,
  Init_Controls,
  zDm_Images,
  zBaseLib,
  ConfigModule,
  zFrmInspector,
  zMsg,
  zDX,
  zStorage,
  MainForm,
  zRestrictions.types,
  zz.Vcl,
  Files.Lib,
  zz.Files,
  zHelp.form,
  HelpGen.descriptor,
  zMemoDialog,
  zToolActions,
  zToolFilter,
  zAI.types,
  zAI.Context.SmokeTest,
  Gesty.AI.Resolvers,
  dmCommon;

{$R *.dfm}

var
  siBaseForm: TSiSession;

function GetActiveMDIWindowState: TWindowState;
begin
  Result := WsNormal;
  if Assigned(Application) then
    if Assigned(Application.MainForm) then
      if Assigned(Application.MainForm.ActiveMDIChild) then
        Result := Application.MainForm.ActiveMDIChild.WindowState;
end;

constructor TBaseForm.Create(AOwner: TComponent);
begin
  siBaseForm.EnterMethod(Self, 'Create');
  FLoading := True;
  inherited;
  siBaseForm.LogVerbose('AfterCreate');

  FSelectedDataSetName := '';
  FAutoOpenDataSets := True;
  // { TODO : Ripristinare dopo correzioni a dxRibbonForm } DisableAero := True;
  FTitolo := Name;
  FDM := nil;

  FBusy := false;
  ShouldSaveController := false;
  Self.Name := System.Copy(ClassName, 1, Length(ClassName));
  FEnterAsTab := True;
  FReportGroup := '';

  FPK := Null;
  FPkField := '';

  ShowHint := True;
  KeyPreview := True;
  Position := PoMainFormCenter;

  HelpType := HtContext;
  HelpContext := Config.zSystem.GetHelpContext(Self);

  GlassFrame.Enabled := false;

  siBaseForm.LogVerbose('Pre TzFormController.Create');

  FzFormController := TzFormController.Create(Self);
  FormController.zSystem := Config.zSystem;
  FormController.CtrlOwner := Self;
  FormController.CtrlParent := Self;
  FormController.onSelect := TreeSelect;
  FormController.OnDatasetAssigned := OnDatasetAssigned;
  FormController.OnAfterCreateControls := OnAfterCreateControls;
  FormController.OnAfterCreateComponent := OnAfterCreateComponent;
  FormController.OnAfterLayoutControlLoadProps := OnAfterLayoutControlLoadProps;

  dxBarSubItemSistema.Visible := dx.Visible(Config.zSystem.IsAdmin);

  dxBarManager.ImageOptions.Images := dx.Immagini;
  dxBarManager.ImageOptions.LargeImages := dx.Immagini;

  BaseActions.Images := dx.Immagini;

  // Le form derivate hanno ActionList proprie legate a dx.Immagini nel DFM: se la unit
  // si salva con zDX chiuso l'IDE toglie il legame, quindi lo si ripristina da codice.
  // Solo le liste senza immagini, per non toccare quelle legate ad altri elenchi
  AssegnaImmaginiActionList(Self);

  Init_Ctrls(Self);

  doCreateDataModule;
  // LoadFormOptions rivisto e corretto
  LoadFormOptions;

  if not CtrlKey then
    LoadFromIni;

  ActionListController := TActionListController.Create;
  ActionListController.InitActions(Self);
  PageControlController := TPageControlController.Create(Self);
  PageControlController.InitForm(Self);

  RestrictionManager := TRestrictionManager.Create(Self, Config.zSystem, Self, DM.zDataModule);
  RestrictionManager.AddDefaultLevel(actAggiorna, 'Base', TAccessLevel.alFull);
  RestrictionManager.AddDefaultLevel(actStampa, 'Base', TAccessLevel.alFull);
  RestrictionManager.AddDefaultLevel(actVisualizzaGuida, 'Base', TAccessLevel.alFull);
  RestrictionManager.AddDefaultLevel(actEsci, 'Base', TAccessLevel.alFull);
  RestrictionManager.AddDefaultLevel(actSistema, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(actPoliticheAccessi, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(actRicaricaPolitiche, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(ControllerEditDatamodule, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(ControllerEditLayout, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(ControllerResetToDefault, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(ControllerLoadFromIni, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(ControllerSaveToIni, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(ControllerBuildGui, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(ControllerMostraDimensioni, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(ControllerResetDimensioni, 'Base', TAccessLevel.alNone);

  TimerToolbars := TTimer.Create(Self);
  TimerToolbars.Enabled := false;
  TimerToolbars.Interval := 250;
  TimerToolbars.OnTimer := TimerToolbarsTimer;

  TimerGui := TTimer.Create(Self);
  TimerGui.Enabled := false;
  TimerGui.Interval := 100;
  TimerGui.OnTimer := TimerGuiTimer;

  dx.InitTitle(lblTitolo);

  siBaseForm.LeaveMethod(Self, 'Create');
end;

destructor TBaseForm.Destroy;
begin
  RootLookAndFeel.RemoveChangeListener(Self);

  SaveToIni;

  FormCollection.Remove(Self);

  FreeAndNil(TimerToolbars);
  FreeAndNil(TimerGui);

  FreeAndNil(FzFormController);
  FreeAndNil(ActionListController);
  FreeAndNil(PageControlController);
  FreeAndNil(RestrictionManager);

  // ZZ 28.10.2016: spostato dopo la distruzione di formController: in alcuni casi AV in chiusura
  if not Application.Terminated then
    DestroyDataModule;

  inherited;
end;

procedure TBaseForm.ActAggiornaExecute(Sender: TObject);
begin
  inherited;
  Aggiorna;
end;

procedure TBaseForm.ActEsciExecute(Sender: TObject);
begin
  inherited;

  try
    ActiveControl := nil; // 04.06.2024: Paolo, AV in chiusura
  except
  end;

  // actEsci.Enabled := False;
  // try
  Close;
  // finally
  // actEsci.Enabled := True;
  // end;
end;

procedure TBaseForm.ActionUpdateAdmin(Sender: TObject);
begin
  if Sender is TAction then
    if Assigned(Config) then
      if Config.zSystem.zSecurity.LoggedIn then
      begin
        TAction(Sender).Enabled := Config.zSystem.IsAdmin;
        TAction(Sender).Visible := Config.zSystem.IsAdmin;
      end;
end;

procedure TBaseForm.ActPoliticheAccessiExecute(Sender: TObject);
begin
  RestrictionManager.EditRestrictions;
  BuildGuiDelayed; // 08.10.2022
  RealignToolbarsDelayed;
end;

procedure TBaseForm.ActRicaricaPoliticheExecute(Sender: TObject);
begin
  BuildGuiDelayed; // 08.10.2022 ApplyRestrictions;
end;

procedure TBaseForm.actSistemaExecute(Sender: TObject);
var
  I: Integer;
begin
  if not Config.zSystem.IsAdmin then
    Config.zSystem.CheckAdmin; // chiede l password

  if not Config.zSystem.IsAdmin then
    Exit;

  Config.zSystem.ShowSystemForm;
end;

procedure TBaseForm.ActStampaExecute(Sender: TObject);
begin
  inherited;
  Stampa;
end;

function TBaseForm.AddLayoutItem(Control: TControl; Caption: string;

  const CaptionVisible: Boolean = True): TdxLayoutItem;
begin
  Result := nil;

  if Assigned(FormController.LayoutController) then
  begin
    Result := FormController.LayoutController.AddControl(Control, Caption);
    Result.CaptionOptions.Visible := CaptionVisible;
  end;
end;

procedure TBaseForm.AfterConstruction;
begin
  Exclude(FFormState, FsVisible);
  inherited;
end;

procedure TBaseForm.AfterShowForm(const Modal: Boolean);
begin
  siBaseForm.EnterMethod(Self, 'AfterShowForm');

  if Modal then
  begin
    if ModalResult = MrCancel then
      Annulla(false, false); // annulla gli stati di insert all'apertura dei wizard vari

    CloseDataSets;
  end
  else
  begin
    PageControlController.ActivateDataSets;
    // Realign;
  end;

  siBaseForm.LeaveMethod(Self, 'AfterShowForm');
end;

procedure TBaseForm.Aggiorna;
var
  I: Integer;
begin
  siBaseForm.EnterMethod(Self, 'Aggiorna');

  if Assigned(DM) then
    DM.RefreshDataSets;

  PageControlController.ActivateDataSets;
  siBaseForm.LeaveMethod(Self, 'Aggiorna');
end;

procedure TBaseForm.Annulla(const ReopenDataSets: Boolean; const Verbose: Boolean);
begin
  if Assigned(DM) then
    DM.Rollback(ReopenDataSets, Verbose);
end;

procedure TBaseForm.ApplyPK;
begin
  // se BuildGUI la pk viene settata quando ancora non sono stati create le view
  PK := PK;
end;

procedure TBaseForm.ApplyRestrictions;
begin
  siBaseForm.EnterMethod(Self, 'ApplyRestrictions');

  DisableAlign;
  try
    RestrictionManager.ApplyRestrictions;
    // LoadTreeMenu rimosso: il tree è caricato da CreateControls dopo CreateLayoutStructure.
    // Aggiornare solo il tree senza ricostruire dictMenu causa incoerenza (click morto).
  finally
    EnableAlign;
  end;

  siBaseForm.LeaveMethod(Self, 'ApplyRestrictions');
end;

procedure TBaseForm.BaseActionsUpdate(Action: TBasicAction;

  var Handled: Boolean);
var
  Isvisible: Boolean;
begin
  Isvisible := dxBarSubItemSistema.Visible = ivAlways;

  if Isvisible <> Config.zSystem.IsAdmin then
  begin
    dxBarSubItemSistema.Visible := dx.Visible(Config.zSystem.IsAdmin);
    RealignToolbarsDelayed;
  end;
end;

procedure TBaseForm.BeforeShow;
begin
  SiMain.EnterMethod(Self, 'BeforeShow');

  if AutoOpenDataSets then
    OpenDataSets(True);

  SiMain.LeaveMethod(Self, 'BeforeShow');
end;

procedure TBaseForm.BuildGui;
begin
  siBaseForm.EnterMethod(Self, 'BuildGui');

  if not Assigned(DM) then
  begin
    SiMain.LogColored(clRed, 'Datamodule non assegnato: ' + Self.Name);
    Exit;
  end;

  Application.ProcessMessages;

  dxBarManager.BeginUpdate;
  try
    FormController.DestroyControls;

    if DM.zDataModule.BuildGui then
    begin
      DM.LoadDataModuleProps;

      ApplyRestrictions; // 08.10.2022

      FormController.CreateControls;

      if ShouldSaveController then
        FormController.SaveProps;

      ShouldSaveController := false;

      if PkMode then
        ApplyPK;
    end;
  finally
    dxBarManager.EndUpdate;
  end;

  siBaseForm.LeaveMethod(Self, 'BuildGui');
end;

procedure TBaseForm.BuildGuiDelayed;
begin
  TimerGui.Enabled := false;
  TimerGui.Enabled := True;
end;

procedure TBaseForm.CloseDataSets;
begin
  if Assigned(DM) then
    DM.CloseDataSets;
end;

function TBaseForm.CloseQuery: Boolean;
begin
  SiMain.EnterMethod(Self, 'CloseQuery');

  if Config.ShuttingDown then
    Exit(True);

  if Busy then
    Exit(false);

  Result := inherited CloseQuery;

  // se da evento rispondono picche
  if not Result then
    Exit;

  if Assigned(DM) then
    Result := DM.CloseQuery;

  SiMain.LeaveMethod(Self, 'CloseQuery');
end;

procedure TBaseForm.ControllerBuildGuiExecute(Sender: TObject);
begin
  BuildGuiDelayed;
end;

procedure TBaseForm.ControllerEditDatamoduleExecute(Sender: TObject);
begin
  if Config.zSystem.IsAdmin then
    if Assigned(DM) then
      if DM.EditDatamodule then
      begin
        ShouldSaveController := True;
        LoadFormOptions;
        BuildGuiDelayed;
      end;
end;

procedure TBaseForm.ControllerEditLayoutExecute(Sender: TObject);
begin
  if Config.zSystem.IsAdmin then
    FormController.CustomizeLayout;
end;

procedure TBaseForm.ControllerLoadFromIniExecute(Sender: TObject);
begin
  FormController.LoadFromIni;
end;

procedure TBaseForm.ControllerResetToDefaultExecute(Sender: TObject);
begin
  if ConfirmYesNo('Annullare tutte le personalizzazioni ai layout?') then
    FormController.ResetLayout;
end;

procedure TBaseForm.ControllerSaveToIniExecute(Sender: TObject);
begin
  StartWait('Attendere...', True);
  try
    FormController.SaveToIni;
  finally
    StopWait;
  end;
end;

procedure TBaseForm.CreateDataModule;
begin

end;

procedure TBaseForm.CreateDM(InstanceClass: TBaseDataModuleClass;

  var Reference);
begin
  Application.CreateForm(InstanceClass, Reference);

  FDM := TBaseDataModule(Reference);

  if Assigned(DM) then
  begin
    FormController.DataModule := DM;
    FormController.zDataModule := DM.zDataModule;
  end;
end;

procedure TBaseForm.DatasetAssigned(const DataSetName: String; Component: TComponent);
begin

end;

procedure TBaseForm.DatasetSelected(DiagramDataSet: TzDiagramDataSet);
begin
  // abstract
end;

procedure TBaseForm.DestroyDataModule;
begin
  // 21.04.2010: altrimenti non funzionerebbero gli 'if assigned(dm) then'
  FDM := nil;
end;

procedure TBaseForm.DoClose(var Action: TCloseAction);
begin
  inherited;

  try
    ActiveControl := nil; // AV in chiusura sui componenti Tcx*
  except
  end;

  if FormStyle = fsMDIChild then
    Action := CaFree;
end;

procedure TBaseForm.doCreateDataModule;
begin
  siBaseForm.EnterMethod(Self, 'doCreateDataModule');
  // usato al posto della chiamata diretta per smart inspect
  CreateDataModule;
  siBaseForm.LeaveMethod(Self, 'doCreateDataModule');
end;

procedure TBaseForm.ExpandButtonActivated(Sender: TObject);
begin
  PageControlController.ResetActivePages;
  PageControlController.ActivateDataSets;
  PageControlController.AutoSizePageControls;
end;

function TBaseForm.GetCard(const DataSetName: string; const CardID: string = ''): TzDbCard;
var
  Comp: TComponent;
  Card: TzDbCard;
begin
  Result := nil;

  for Comp in Self do
    if Comp is TzDbCard then
    begin
      Card := TzDbCard(Comp);

      if Assigned(Card.zDataSet) then
        if SameText(Card.zDataSet.Name, DataSetName) then
          if (CardID.IsEmpty) or SameText(Card.CardID, CardID) then
            Exit(Card);
    end;
end;

function TBaseForm.GetRestrictionManager: TRestrictionManager;
begin
  Result := RestrictionManager;
end;

function TBaseForm.GetView(

  const DataSetName: string;

  const ViewID: string = ''): TzDbView;
var
  Comp: TComponent;
  view: TzDbView;
begin
  Result := nil;

  for Comp in Self do
    if Comp is TzDbView then
    begin
      view := TzDbView(Comp);

      if Assigned(view.zDataSet) then
        if SameText(view.zDataSet.Name, DataSetName) then
          if (ViewID.IsEmpty) or SameText(view.ViewID, ViewID) then
            Exit(view);
    end;
end;

procedure TBaseForm.HideToolbars;
var
  I: Integer;
begin
  barTitolo.Visible := false;
  barFree.Visible := false;
  barSistema.Visible := false;
  lblTitolo.Visible := false;

  // 08.10.2018: manda in palla cxSplitter
  for I := 0 to dxBarManager.DockControlCount - 1 do
    dxBarManager.DockControls[I].Visible := false;
end;

procedure TBaseForm.InitFrame(Frame: TBaseFrame; aParent: TWinControl);
begin
  // riapplicare le policy
  ApplyRestrictions;
  Frame.Align := alClient;
  Frame.Parent := aParent;
  Frame.Visible := True;
  Frame.Init;
end;

function TBaseForm.IsShortCut(

  var Message: TWMKey): Boolean;
var
  Ctrl: TWinControl;
  Comp: TComponent;
  I: Integer;
begin
  Ctrl := ActiveControl;
  if Ctrl <> nil then
  begin
    repeat
      Ctrl := Ctrl.Parent
    until (Ctrl = nil) or (Ctrl is TCustomFrame);
    if Ctrl <> nil then
    begin
      for I := 0 to Ctrl.ComponentCount - 1 do
      begin
        Comp := Ctrl.Components[I];
        if Comp is TCustomActionList then
        begin
          Result := TCustomActionList(Comp).IsShortCut(Message);
          if Result then
            Exit;
        end;
      end;
    end;
  end;
  Result := inherited IsShortCut(Message);
end;

{ TBaseForm }

procedure TBaseForm.KeyDown(var Key: Word; Shift: TShiftState);
var
  Skip: Boolean;
begin
  // inherited;

  case Key of
    Vk_Return:
      begin
        Skip := false;

        if Assigned(ActiveControl) then
        begin
          if ActiveControl is TCustomMemo then
            Skip := True;

          if not Skip then
            if dx.GridEditable(dx.ActiveGrid) then
              Skip := True;

          if not Skip then
            if dx.ActiveControl is TcxCustomDropDownEdit then
              if (dx.ActiveControl as TcxCustomDropDownEdit).DroppedDown then
                Skip := True;
        end;

        if EnterAsTab then
          if not Skip then
          begin
            Key := 0;
            if SsShift in Shift then
              Perform(Wm_NextDlgCtl, 1, 0)
            else
              Perform(Wm_NextDlgCtl, 0, 0);
          end;
      end;
    Vk_F12:
      begin
        //
        if SsCtrl in Shift then
        begin
          // Ripensare
          // Config.GestioneDiritti(Self);
          // Key := 0;
        end;
      end;
  end;

  inherited KeyDown(Key, Shift);
end;

procedure TBaseForm.lblTitoloDblClick(Sender: TObject);
begin
  if CtrlKey then
    ControllerEditLayout.Execute
  else
    ControllerEditDatamodule.Execute;
end;

procedure TBaseForm.Loaded;
begin
  inherited;
  FormStyle := FsNormal;
  Visible := false;
end;

procedure TBaseForm.LoadFromIni;
var
  MaxWidth, MaxHeight: Integer;
begin
  MaxWidth := ClientWidth;
  MaxHeight := ClientHeight;

  if barTitolo.Visible then
    if Assigned(barTitolo.Control) then
      MaxHeight := MaxHeight - barTitolo.Control.Height;

  TzStorage.LoadControlFromIni(Config.StorageFileName, Self, MaxWidth, MaxHeight);
end;

procedure TBaseForm.LoadFormOptions;
var
  Idx: Integer;
  Item: TzForm;
  S: string;
begin

  if Assigned(DM) then
    if Assigned(DM.zDataModule) then
    begin
      Caption := DM.zDataModule.FormOptions.Caption;
      HelpType := DM.zDataModule.FormOptions.HelpType;
      HelpContext := DM.zDataModule.FormOptions.HelpContext;
      HelpKeyword := DM.zDataModule.FormOptions.HelpKeyword;
      ReportGroup := DM.zDataModule.FormOptions.ReportGroup;
      //
      Titolo := DM.zDataModule.FormOptions.Caption;
    end;
end;

function TBaseForm.Modificato: Boolean;
var
  I: Integer;
begin
  Result := false;
  if Assigned(DM) then
    Result := DM.Modified;
end;

procedure TBaseForm.OpenDataSets(const silent: Boolean = false);
begin
  siBaseForm.EnterMethod(Self, 'OpenDataSets');
  if Assigned(DM) then
    DM.OpenDataSets(silent);
  siBaseForm.LeaveMethod(Self, 'OpenDataSets');
end;

procedure TBaseForm.ParamChanged(params: array of string);
begin
  if Assigned(DM) then
    DM.ParamChanged(params);
end;

function TBaseForm.PkMode: Boolean;
begin
  Result := not IsNull(PK);
end;

procedure TBaseForm.Print(ReportGroup, SelectedDataSetName: string);
begin
  if Busy then
    Exit;

  Busy := True;
  try
    actStampa.Enabled := false;
    try
      DM.Print(ReportGroup, SelectedDataSetName);
    finally
      actStampa.Enabled := True;
    end;
  finally
    Busy := false;
  end;
end;

function TBaseForm.Salva: Boolean;
begin
  Result := True;
  if Assigned(DM) then
    Result := DM.Commit;
end;

procedure TBaseForm.SaveToIni;
begin
  TzStorage.SaveControlToIni(Config.StorageFileName, Self);

  if Assigned(DM) then
    if DM.zDataModule.BuildGui then
      FormController.SaveToIni;
end;

procedure TBaseForm.SetBusy(const Value: Boolean);
begin
  FBusy := Value;

  ActionListController.Busy := Busy;

  // if Busy then
  // StartWait('Attendere...', True)
  // else
  // StopWait;

  actEsci.Enabled := not Busy;
  actStampa.Enabled := not Busy;
end;

procedure TBaseForm.SetIdCard(Card: TzDbCard);
begin
  if Assigned(Card) then
    Card.CardID := Self.Name + '.' + Card.Name;
end;

procedure TBaseForm.SetPK(const Value: Variant);
begin
  if FPK <> Value then
  begin
    FPK := Value;
  end;
end;

procedure TBaseForm.SetTitolo(const Value: String);
begin
  FTitolo := Value;
  Caption := Titolo;
  lblTitolo.Caption := Titolo;
end;

procedure TBaseForm.Stampa;
begin
  Print(ReportGroup, SelectedDataSetName);
end;

procedure TBaseForm.TimerGuiTimer(Sender: TObject);
begin
  TimerGui.Enabled := false;
  // ApplyRestrictions; // 08.10.2022
  BuildGui;
  RealignToolbarsDelayed;
end;

procedure TBaseForm.TitoloDblClick(Sender: TObject);
begin
  if not Config.zSystem.IsAdmin then
    Exit;

  if CtrlKey then
    ControllerEditLayout.Execute
  else
    ControllerEditDatamodule.Execute;

  RealignToolbarsDelayed;
end;

procedure TBaseForm.TreeSelect(Sender: TObject);
var
  DiagramDataSet: TzDiagramDataSet;
begin
  DiagramDataSet := FormController.SelectedDataSet;
  if Assigned(DiagramDataSet) then
    DM.DatasetSelected(DiagramDataSet);

  Self.DatasetSelected(DiagramDataSet);
end;

procedure TBaseForm.UpdatePolicies;
begin
  BuildGuiDelayed; // 08.10.2022 ApplyRestrictions;
end;

procedure TBaseForm.WMSize(var M: TWMSIZE);
begin

  if M.SizeType = SIZE_RESTORED then
  begin
    if Width < 240 then
    begin
      Width := 640;
      Height := 480;
    end;
  end;

  inherited;
end;

function TBaseForm.ShowForm(const Modal: Boolean): Boolean;
  function GetWindowState: TWindowState;
  begin
    if Modal then
      Result := WsNormal
    else
      Result := wsMaximized;
  end;

  function GetFormStyle: TFormStyle;
  begin
    if Modal then
      Result := FsNormal
    else
      Result := fsMDIChild;
  end;

begin
  siBaseForm.EnterMethod(Self, 'ShowForm');
  Result := True;

  // ZZ 30.03.2017: se già visibile inutile ricreare il tutto,
  // specialmente perchè resetta pk e altro
  if Visible then
  begin
    if WindowState = WsMinimized then
      WindowState := GetWindowState;

    BringToFront;
    Exit;
  end;

  StartWait('Attendere...', True);
  try
    LoadFormOptions;

    DisableAlign;
    try
      WindowState := GetWindowState;

      UpdateWait('Creazione GUI');

      BuildGui;

      UpdateWait('Apertura Datasets');
      BeforeShow;

      if not PkMode then
        PageControlController.ResetActivePages;

      UpdateWait('Applicazione Permessi');

      // se non sono state applicate da buildGui
      if not(Assigned(DM) and (DM.zDataModule.BuildGui)) then
        ApplyRestrictions;

      UpdateWait('Attendere...');

      // senza le card disposte sulle form danno eListError.
      // in particolare Aziende, Emissioni e PianoDeiConti
      Application.ProcessMessages;

      FormStyle := GetFormStyle;
    finally
      EnableAlign;
    end;

    FLoading := false;
  finally
    StopWait;
  end;

  if Modal then
    Result := ShowModal = MrOk
  else
    Show;

  AfterShowForm(Modal);

  siBaseForm.LeaveMethod(Self, 'ShowForm');
end;

procedure TBaseForm.TimerToolbarsTimer(Sender: TObject);
begin
  siBaseForm.LogVerbose('TimerToolbarsTimer');

  TimerToolbars.Enabled := false;

  if Assigned(PageControlController) then
    PageControlController.AutoSizePageControls;

  RealignToolbars;
end;

procedure TBaseForm.RealignToolbars;
begin
  if AlignDisabled then
    Exit;

  siBaseForm.LogVerbose('RealignToolbars');

  if barTitolo.Visible then
    dxBarControlContainerTitolo.Visible := ivAlways
  else
    dxBarControlContainerTitolo.Visible := ivNever;

  if Assigned(barTitolo.Control) then
  begin
    barTitolo.Control.Top := 0;
    barTitolo.Control.Left := 0;
  end;

  if Assigned(barFree.Control) then
  begin
    barFree.Control.Top := 0;
    barFree.Control.Left := barTitolo.Control.Width + 1;
  end;

  if Assigned(barSistema.Control) then
  begin
    barSistema.Control.Top := 0;
    barSistema.Control.Left := ClientWidth - barSistema.Control.Width;
  end;
end;

procedure TBaseForm.FormResize(Sender: TObject);
begin
  // siBaseForm.LogVerbose('FormResize');
  RealignToolbarsDelayed;

  // AV
  // if DM.zDataModule.BuildGui then
  // FormController.AfterResize;
end;

procedure TBaseForm.FormShow(Sender: TObject);
begin
  // siBaseForm.LogVerbose('FormShow');
  RealignToolbarsDelayed;

  if DM.zDataModule.BuildGui then
    FormController.AfterShow;
end;

procedure TBaseForm.Activate;
begin
  inherited;
  // siBaseForm.LogVerbose('Activate');

  // viene chiamata anche da stopWait..
  if FormCollection.ActiveForm <> Self then
  begin
    FormCollection.ActiveForm := Self;
    PageControlController.ActivateDataSets;
  end;
end;

procedure TBaseForm.actPermessiAzioneExecute(Sender: TObject);
var
  Action: TCustomAction;
begin
  Action := TCustomAction(popActions.Tag);

  if Assigned(Action) then
    RestrictionManager.EditComponentRestrictions(ClassName, ccAction, Action.Name);
end;

procedure TBaseForm.actProprietaAzioneExecute(Sender: TObject);
var
  Action: TCustomAction;
begin
  Action := TCustomAction(popActions.Tag);

  if Assigned(Action) then
    ConfirmOk('Recuperare zDiagramDataSet per ' + Action.Name);
end;

procedure TBaseForm.RealignToolbarsDelayed;
begin
  if Assigned(TimerToolbars) then
  begin
    TimerToolbars.Enabled := false;
    TimerToolbars.Enabled := True;
  end;
end;

procedure TBaseForm.OnAfterCreateControls(Sender: TObject);
begin
  AfterCreateControls;
end;

procedure TBaseForm.OnDatasetAssigned(zFormController: TzFormController;

  const DataSetName: String; Component: TComponent);
begin
  DatasetAssigned(DataSetName, Component);
end;

procedure TBaseForm.OnAfterLayoutControlLoadProps(Sender: TObject);
begin
  AfterLayoutControlLoadProps;
end;

procedure TBaseForm.AfterCreateControls;
begin

end;

procedure TBaseForm.AfterLayoutControlLoadProps;
begin

end;

procedure TBaseForm.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
begin
  { TODO : Eliminare OLD_AfterCreateComponent }
end;

procedure TBaseForm.OnAfterCreateComponent(zFormController: TzFormController; LayoutController: TLayoutController;

  const DataSetName: String; Component: TComponent);
begin
  AfterCreateComponent(DataSetName, Component);
end;

procedure TBaseForm.ControllerMostraDimensioniExecute(Sender: TObject);
var
  S: String;
begin
  S := FormController.DumpItemSize(ClientWidth, ClientHeight);
  Clipboard.AsText := S;
  ConfirmOk(S);
end;

procedure TBaseForm.ControllerResetDimensioniExecute(Sender: TObject);
begin

  if ConfirmYesNo('Si desidera resettare le dimensioni dei controlli?') then
    FormController.ResetItemSize;
end;

procedure TBaseForm.dxBarManagerBarVisibleChange(Sender: TdxBarManager; ABar: TdxBar);
begin
  dx.dxBarAssignPopupMenu(ABar, popActions);
end;

function TBaseForm.GetSelectedDataSetName: string;
begin
  Result := FSelectedDataSetName;

  if Assigned(FormController.LayoutController.TreeMenu) then
    Result := FormController.SelectedDataSetName;
end;

procedure TBaseForm.HelpExecute(Sender: TObject);
begin
  if HelpType = HtContext then
    Application.HelpContext(HelpContext)
  else
    Application.HelpKeyword(HelpKeyword);
end;

procedure TBaseForm.actScreenshotExecute(Sender: TObject);
var
  bmp: TBitmap;
begin
  bmp := HelpScreenShot;
  try
    Clipboard.Assign(bmp);
  finally
    FreeAndNil(bmp);
  end;

  ConfirmOk('Immagine copiata nella clipboard.');
end;

function TBaseForm.HelpScreenShot: TBitmap;
  function GetFormBitmap: TBitmap;
  var
    Canvas: TCanvas;
    r, t: TRect;
    h: THandle;
  begin
    Canvas := TCanvas.Create;
    try
      Canvas.Handle := GetWindowDC(GetDesktopWindow);

      if fsModal in FormState then
        // h := Screen.ActiveForm.Handle; // GetForeGroundWindow;
        h := Self.Handle // GetForeGroundWindow;
      else
        h := Application.MainForm.Handle;

      GetWindowRect(h, t);
      try
        r := Rect(0, 0, t.Right - t.Left, t.Bottom - t.Top);

        Result := TBitmap.Create;
        Result.Width := t.Right - t.Left;
        Result.Height := t.Bottom - t.Top;
        Result.Canvas.CopyRect(r, Canvas, t);
      finally
        ReleaseDC(0, Canvas.Handle);
      end;
    finally
      Canvas.Free;
    end;
  end;

  function getScreenCapture(FullWindow: Boolean): TBitmap;
  var
    Win: HWND;
    DC: HDC;

    WinRect: TRect;
    Width: Integer;
    Height: Integer;

  begin
    Result := TBitmap.Create;

    // Application.ProcessMessages; // Was Sleep(500);
    Win := GetForegroundWindow;

    if FullWindow then
    begin
      GetWindowRect(Win, WinRect);
      DC := GetWindowDC(Win);
    end
    else
    begin
      Winapi.Windows.GetClientRect(Win, WinRect);
      DC := GetDC(Win);
    end;
    try
      Width := WinRect.Right - WinRect.Left;
      Height := WinRect.Bottom - WinRect.Top;

      Result.Height := Height;
      Result.Width := Width;
      BitBlt(Result.Canvas.Handle, 0, 0, Width, Height, DC, 0, 0, SRCCOPY);
    finally
      ReleaseDC(Win, DC);
    end;
  end;

  function GetScreenShot: TBitmap;
  var
    DC: HDC;
    r: TRect;
  begin
    Result := TBitmap.Create;
    try
      r := Self.ClientRect;
      Result.Width := Self.Width;
      Result.Height := Self.Height;
      DC := GetDC(Self.Handle);
      try
        BitBlt(Result.Canvas.Handle, 0, 0, r.Width, r.Height, DC, r.Left, r.Top, SRCCOPY);
      finally
        ReleaseDC(Self.Handle, DC);
      end;
    except
      Result.Free;
      raise;
    end;
  end;

begin
  Config.zSystem.ForceAdmin(false);
  try
    UpdateActions;
    Application.ProcessMessages;
    RealignToolbars;
    Application.ProcessMessages;

    // Result := GetFormBitmap;
    // Result := getScreenCapture(False);
    Result := GetScreenShot;
  finally
    Config.zSystem.ForceAdmin(True);
  end;
end;

procedure TBaseForm.SetSelectedDataSetName(const Value: string);
begin
  FSelectedDataSetName := Value;
  FormController.SelectedDataSetName := Value;
end;

procedure TBaseForm.popActionsPopup(Sender: TObject);
begin
  if not Config.zSystem.CanEditRestrictions then
    System.SysUtils.Abort;
end;

// function TBaseForm.GetDataSet(Const DataSetName: string; DataSet: TzFbDataSet): TzFbDataSet;
function TBaseForm.GetDataSet(Const DataSetName: string): TzFbDataSet;
begin
  Result := nil;

  if Assigned(DM) then
    Result := DM.GetDataSet(DataSetName);
end;

function TBaseForm.GetPivot(const DataSetName, PivotID: string): TzDbPivot;
var
  Comp: TComponent;
  pivot: TzDbPivot;
begin
  Result := nil;

  for Comp in Self do
    if Comp is TzDbPivot then
    begin
      pivot := TzDbPivot(Comp);

      if Assigned(pivot.zDataSet) then
        if SameText(pivot.zDataSet.Name, DataSetName) then
          if (PivotID.IsEmpty) or SameText(pivot.PivotID, PivotID) then
            Exit(pivot);
    end;
end;

function TBaseForm.GetRecordView(const DataSetName, RecordViewID: string): TzDbRecordView;
var
  Comp: TComponent;
  RecordView: TzDbRecordView;
begin
  Result := nil;

  for Comp in Self do
    if Comp is TzDbRecordView then
    begin
      RecordView := TzDbRecordView(Comp);

      if Assigned(RecordView.zDataSet) then
        if SameText(RecordView.zDataSet.Name, DataSetName) then
          if (RecordViewID.IsEmpty) or SameText(RecordView.RecordViewID, RecordViewID) then
            Exit(RecordView);
    end;
end;

function TBaseForm.GetTree(const DataSetName, TreeID: string): TzDbTree;
var
  Comp: TComponent;
  Tree: TzDbTree;
begin
  Result := nil;

  for Comp in Self do
    if Comp is TzDbTree then
    begin
      Tree := TzDbTree(Comp);

      if Assigned(Tree.zDataSet) then
        if SameText(Tree.zDataSet.Name, DataSetName) then
          if (TreeID.IsEmpty) or SameText(Tree.TreeID, TreeID) then
            Exit(Tree);
    end;
end;

function TBaseForm.GetChart(const DataSetName, ChartID: string): TzDbChart;
var
  Comp: TComponent;
  Chart: TzDbChart;
begin
  Result := nil;

  for Comp in Self do
    if Comp is TzDbChart then
    begin
      Chart := TzDbChart(Comp);

      if Assigned(Chart.zDataSet) then
        if SameText(Chart.zDataSet.Name, DataSetName) then
          if (ChartID.IsEmpty) or SameText(Chart.ChartID, ChartID) then
            Exit(Chart);
    end;
end;

function TBaseForm.GetScheduler(const DataSetName, SchedulerID: string): TzDbScheduler;
var
  Comp: TComponent;
  Scheduler: TzDbScheduler;
begin
  Result := nil;

  for Comp in Self do
    if Comp is TzDbScheduler then
    begin
      Scheduler := TzDbScheduler(Comp);

      if Assigned(Scheduler.zDataSet) then
        if SameText(Scheduler.zDataSet.Name, DataSetName) then
          if (SchedulerID.IsEmpty) or SameText(Scheduler.SchedulerID, SchedulerID) then
            Exit(Scheduler);
    end;
end;

procedure TBaseForm.actSalvaComponentiExecute(Sender: TObject);
begin
  RestrictionManager.SaveFormComponents(Self, DM.zDataModule);
end;

procedure TBaseForm.OnImportFile(Sender: TzFileViewer; const FileName: string);
begin
  doImportFile(Sender, FileName);
end;

procedure TBaseForm.doImportFile(zFileViewer: TzFileViewer; const FileName: string);
var
  idFile: Integer;
  view: TzDbView;
  id: string;
  oid: Integer;
begin
  oid := GetOid(zFileViewer.DataSet, zFileViewer.FieldNameOID);
  idFile := ImportObjFile(oid, zFileViewer.DataSet, FileName, nil, True);

  view := nil;
  if Assigned(zFileViewer.DataSet) then
    view := GetView(zFileViewer.DataSet.Name);

  if Assigned(view) then
  begin
    view.ClearFilter(false);
    view.AddFilterCondition('ID_OBJECT_FILE', foEqual, idFile);
    view.ShowRecord(false);
  end;
end;

procedure TBaseForm.OnImportFileMulti(Sender: TzMultiViewer; const FileName: string);
begin
  doImportFileMulti(Sender, FileName);
end;

procedure TBaseForm.doImportFileMulti(zMultiViewer: TzMultiViewer; const FileName: string);
var
  idFile: Integer;
  view: TzDbView;
  id: string;
  oid: Integer;
begin
  oid := GetOid(zMultiViewer.DataSet, zMultiViewer.FieldNameOID);
  idFile := ImportObjFile(oid, zMultiViewer.DataSet, FileName, nil, True);

  view := nil;
  if Assigned(zMultiViewer.DataSet) then
    view := GetView(zMultiViewer.DataSet.Name);

  if Assigned(view) then
  begin
    view.ClearFilter(false);

    // mantis 112 + mail Giada: Filtro sostituito da LocateNonSQL
    // view.AddFilterCondition('ID_OBJECT_FILE', foEqual, idFile);
    view.zDataSet.LocateNonSQL('ID_OBJECT_FILE', idFile, []);
    view.ShowRecord(false);
  end;
end;

function TBaseForm.FindAction(const ActionName: string): TCustomAction;
var
  Comp: TComponent;
begin
  Result := nil;

  for Comp in Self do
    if (Comp is TCustomAction) and SameText(Comp.Name, ActionName) then
      Exit(TCustomAction(Comp));
end;

procedure TBaseForm.GuideExecute(Sender: TObject);
var
  zHelpForm: TzHelpForm;
begin
  zHelpForm := TzHelpForm.Create(nil);
  try
    zHelpForm.ShowHelpForm(Self);
  finally
    FreeAndNil(zHelpForm);
  end;
end;

function TBaseForm.HelpCaption: string;
begin
  Result := Caption;
end;

function TBaseForm.HelpFilename: string;
begin
  // Result := DM.zDataModule.FormOptions.HelpFileName;
  //
  // if Result.IsEmpty then
  // Result := Name;
  Result := HelpModuleName;
end;

function TBaseForm.HelpFolder: string;
begin
  // Result := DM.zDataModule.FormOptions.HelpFileName;
  //
  // if Result.IsEmpty then
  // Result := Name;
  Result := HelpModuleName;
end;

procedure TBaseForm.HelpEnumActions(Actions: TList<TContainedAction>);
begin
  assert(Assigned(Actions));

  Actions.Clear;

  ForEach<TContainedAction>(
    procedure(Action: TContainedAction)
    begin

      if Action.ActionList <> BaseActions then
        Actions.add(Action);
    end);
end;

procedure TBaseForm.HelpInitGen;
begin
  base.IsAdminDisabled := True;
  // aggiornare le action
  // si può valudare base.zSecurity.IsAdmin per vedere se occorre ricreare
  // ricreare la gui se era admin?
end;

procedure TBaseForm.HelpDoneGen;
begin
  base.IsAdminDisabled := false;

  // aggiornare le action
  // si può valudare base.zSecurity.IsAdmin per vedere se occorre ricreare
  // ricreare la gui se era admin?
end;

function TBaseForm.HelpModuleName: string;
begin
  Result := StringReplace(Name, 'TForm', '', [rfIgnoreCase]);
end;

function TBaseForm.HelpMenuItems: string;
begin
  Result := '';

  if Assigned(FormController.LayoutController.TreeMenu) then
    Result := FormController.LayoutController.TreeMenu.GetMenuItems;
end;

function TBaseForm.HelpDescribeForm: string;
var
  BaseFormDescriptor: TBaseFormDescriptor;
begin
  HelpInitGen;
  try
    Result := BaseFormDescriptor.GeneraRequest(Self);
  finally
    HelpDoneGen;
  end;
end;

function TBaseForm.HelpDescribeContext: string;
var
  BaseFormDescriptor: TBaseFormDescriptor;
begin
  { Il solo descrittore: niente modello di prompt. Vedi HelpDescribeForm, che
    invece la richiesta della guida la costruisce per intero. }
  HelpInitGen;
  try
    Result := BaseFormDescriptor.DescriviContesto(Self);
  finally
    HelpDoneGen;
  end;
end;

function TBaseForm.HelpGetAction(const ActionName: string): TCustomAction;
begin
  Result := GetComponent<TCustomAction>(ActionName);
end;

procedure TBaseForm.AfterCreateComponent(const DataSetName: String; Component: TComponent);
begin

  if Component is TzFileViewer then
    TzFileViewer(Component).OnImportFile := OnImportFile
  else
    if Component is TzMultiViewer then
    begin
      TzMultiViewer(Component).OnImportFile := OnImportFileMulti;
      ConfiguraAzioniDocumentali(TzMultiViewer(Component));
    end;

  // Azioni e filtri dei componenti stanno solo nel dizionario LZ
  // (ToolActions/ToolFilters delle props): il registro da codice
  // TzComponentSetup (zToolFilterSetup) e' stato eliminato.

  // Chiama il nuovo hook per il codice residuo non-configurabile
  SetupComponent(DataSetName, Component);
end;

procedure TBaseForm.SetupComponent(const DataSetName: String; Component: TComponent);
begin
  //
end;

procedure TBaseForm.AIExecute(Sender: TObject);
var
  formMin: TAISensitivity;
  S: string;
begin
  formMin := slNone;
  if Assigned(DM) and Assigned(DM.zDataModule) then
    formMin := DM.zDataModule.FormOptions.AIDefaultSensitivity;

  S := zAI.Context.SmokeTest.RunSmokeTest(Self, GestyAISetup(formMin));
  zExecuteMemoDialog(S, 'Smoke Test');
end;

procedure TBaseForm.ConfiguraAzioniDocumentali(zMultiViewer: TzMultiViewer);
begin
  // Azioni documentali sui documenti gia' in archivio: le fornisce il
  // profilo della riga (gate 1 dal database). Senza controller assegnato il
  // viewer si comporta come prima: nessun pulsante.
  if zMultiViewer.FieldNameIdObjectFile.IsEmpty then
    zMultiViewer.FieldNameIdObjectFile := 'ID_OBJECT_FILE';

  zMultiViewer.ActionsController := Common.DocumentAzioniController;
end;

initialization

siBaseForm := Si.AddSession('s seForm', True);
siBaseForm.Color := clInfoBk;

end.

  zSystem

  zFormController

  zDX zRestrictions

  zOffice.Reports

  property ReportsBatchController: TzBatchController read FStampaMultiplaController write FStampaMultiplaController; zDbCard zDbView zDbCard

  zSystem
