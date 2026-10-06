unit Base_DataModule;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.TimeSpan,
  System.Classes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,

  frxClass,
  frxDBSet,

  FireDAC.Stan.Intf,
  FireDAC.Comp.Client,
  FireDAC.Stan.Option,
  zFbDataSet,

  dbMaster,
  zStoredProc,
  zSystem,
  zOffice.Reports,
  SmartInspect.Vcl,
  SmartInspect.Vcl.SiAuto;

type
  TBaseDataModule = class(TDataModule, IzDataModule)
    dbMaster: TdbMaster;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure dbMasterOpenProgress(Sender: TObject; ItemName: string; ItemNo: Integer);
  private
    FActive: Boolean;
    FDisableGetDataSet: Boolean;
    FModified: Boolean;
    FReadTrans: TzFbTransaction;
    FReportsManager: TzReportsManager;
    FVisibleDataSets: TList<TzFbDataSet>;
    FWriteTrans: TzFbTransaction;
    FzDataModule: TzDataModule;

    function GetReadTrans: TzFbTransaction;
    function GetWriteTrans: TzFbTransaction;
    procedure OnSlowDataSet(Sender: TObject; ItemName: string; DataSet: TDataSet; TimeSpan: TTimeSpan);
    procedure SetActive(const Value: Boolean);
    procedure SetzDataModule(const Value: TzDataModule);
  protected
    function GetModified: Boolean; virtual;
  protected
    function GetSP<T: zStoredProc.TzStoredProc, constructor>: T;
  protected
    DynamicDbComponents: TList<TComponent>;
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); virtual;
    procedure AggiornaAutoOpen;
    procedure CreateDataSets; virtual;
    function DataModuleID: string; virtual;

    procedure DataSetInitProps(const DataSet: TzFbDataSet);
    procedure DataSetLoadProps(const DataSet: TzFbDataSet);
    procedure DestroyDataSets;
    function GetReadTransaction: TzFbTransaction;
    function GetWriteTransaction: TzFbTransaction;
    procedure InitComponents; virtual;
    function isTableModified(DataSet: TzFbDataSet): Boolean;
    procedure SetAutoCommit(const AutoCommit: Boolean = false); overload;
    procedure SetAutoCommit(DataSet: TzFbDataSet; const AutoCommit: Boolean = false); overload;
    procedure SetDataSetTransactions(DataSet: TzFbDataSet);
    procedure TogliAutoOpen(DataSet: TDataSet);
    procedure AddSharedReports(SharedReports: TStrings);
    procedure AddReportDatasets; virtual;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure IzDataModule.ActivateDataSet = ActivateDataSet;
    function IzDataModule.GetDataSet = GetDataSet;
    function IzDataModule.GetDataSource = GetDataSource;

    procedure ActivateDataSet(const DataSetName: string);
    procedure OpenDataSets(const silent: Boolean = false); virtual;
    procedure CloseDataSets(const Verbose: Boolean = True); virtual;
    procedure RefreshDataSets; virtual;
    function CloseQuery: Boolean; virtual;

    procedure StartTransaction;
    function Commit(const Verbose: Boolean = True): Boolean; virtual;
    procedure Rollback(const ReopenDataSets: Boolean; const Verbose: Boolean = True); virtual;

    procedure DatasetSelected(DiagramDataSet: TzDiagramDataSet);
    function EditDatamodule: Boolean;
    function FindDataSet(const DataSetName: String): TzFbDataSet;
    function DataSetExists(const DataSetName: String): Boolean;
    function GetDataSet(const DataSetName: string): TzFbDataSet;
    procedure RefreshDataSet(Const DataSetName: string);
    procedure RefreshRecord(Const DataSetName: string; AClearRow: Boolean = True);
    function IsDataSetVisible(const DataSetName: string): Boolean;
    function GetDataSource(zFbDataSet: TzFbDataSet): TDataSource;
    function GetElencoDataSet: string;
    procedure LoadDataModuleProps; virtual;
    procedure ParamChanged(params: array of string);
    procedure Print(ReportGroup: string; SelectedDataSetName: string); virtual;
    procedure ReopenDataSet(const DataSetName: string);
  public
    property VisibleDataSets: TList<TzFbDataSet> read FVisibleDataSets;
  public
    property Active: Boolean read FActive write SetActive;
    property Modified: Boolean read GetModified write FModified;
    property ReadTrans: TzFbTransaction read GetReadTrans;
    property ReportsManager: TzReportsManager read FReportsManager;
    property WriteTrans: TzFbTransaction read GetWriteTrans;
    property zDataModule: TzDataModule read FzDataModule write SetzDataModule;
  public
    // per HelpGen
    property DisableGetDataSet: Boolean read FDisableGetDataSet write FDisableGetDataSet;
  end;

  TBaseDataModuleClass = class of TBaseDataModule;

implementation

uses
  ConfigModule,
  zBaseLib,
  zMsg,
  zMetaData,
  zDbViewDlg,
  zDbCardDlg,
  zz.base.editor._form;

{$R *.dfm}

constructor TBaseDataModule.Create(aOwner: TComponent);
begin
  SiMain.EnterMethod(Self, 'DataModuleCreate');
  inherited;
  FDisableGetDataSet := false;
  DynamicDbComponents := TList<TComponent>.Create;
  FReportsManager := TzReportsManager.Create(Self);
  FReportsManager.DefaultDatabase := Config.Database;
  FReportsManager.CurrentUserDisplayName := Config.CurrentUserDisplayName;
  FReportsManager.zSystem := Config.zSystem;
  FzDataModule := TzDataModule.Create(nil);
  zDataModule.Name := Self.DataModuleID;
  FVisibleDataSets := TList<TzFbDataSet>.Create;

  InitComponents;
  LoadDataModuleProps;

  AggiornaAutoOpen;
  dbMaster.OnSlowDataSet := OnSlowDataSet;
  SiMain.LeaveMethod(Self, 'DataModuleCreate');
end;

destructor TBaseDataModule.Destroy;
  procedure CloseTransactions;
  var
    I: Integer;
    Transaction: TzFbTransaction;
  begin
    for I := 0 to ComponentCount - 1 do
      if Components[I] is TzFbTransaction then
      begin
        Transaction := Components[I] as TzFbTransaction;
        Transaction.CloseTransaction;
      end;
  end;

begin
  SiMain.EnterMethod(Self, Self.Name + '.DataModuleDestroy');
  try
    CloseTransactions;
    FreeAndNil(FVisibleDataSets);
    FreeAndNil(FzDataModule);
    FreeAndNil(DynamicDbComponents);
    inherited;
  finally
    SiMain.LeaveMethod(Self, Self.Name + '.DataModuleDestroy');
  end;
end;

procedure TBaseDataModule.ActivateDataSet(const DataSetName: string);
  procedure Activate(DataSet: TzFbDataSet);
  begin
    if not assigned(DataSet) then
      exit;

    if assigned(DataSet.DataSource) then
      Activate(DataSet.DataSource.DataSet as TzFbDataSet);

    if DataSet.ActivationMode <> amManual then // ZZ 26.05.2017
      if DataSet.SelectSQL.Text <> '' then
        try
          DataSet.Active := True;
        except
          on e: exception do
            Application.HandleException(e);
        end;
  end;

begin
  Activate(GetDataSet(DataSetName));
end;

procedure TBaseDataModule.AddReportDatasets;
var
  comp: TComponent;
begin
  // Aggiunge dataset già creati ma <> selecteddataset
  // Esempio: frmAccordoStatoRegioni
  for comp in Self do
    if comp is TzFbDataSet then
      ReportsManager.AddDataSet(TzFbDataSet(comp));
end;

procedure TBaseDataModule.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
begin
 //
end;

procedure TBaseDataModule.AggiornaAutoOpen;
var
  I: Integer;
  idx: Integer;
begin
  for I := 0 to dbMaster.DataSets.count - 1 do
    if dbMaster.DataSets[I].IncludeInOpen then
      if assigned(dbMaster.DataSets[I]) then
        if dbMaster.DataSets[I].DataSet is TzFbDataSet then
        begin
          idx := Config.zSystem.zDataSets.IndexOf(Config.zSystem.Get_IdDataSet(dbMaster.DataSets[I].DataSet as TzFbDataSet));
          if idx <> -1 then
            dbMaster.DataSets[I].IncludeInOpen := Config.zSystem.zDataSets[idx].ActivationMode = amAutomatic;
        end;
end;

procedure TBaseDataModule.CloseDataSets(const Verbose: Boolean = True);
begin
  SiMain.EnterMethod(Self, 'CloseDataSets');

  if not Config.Database.Connected then
    exit;

  if not assigned(dbMaster) then
    exit;

  if Verbose then
    StartWait;
  try
    dbMaster.CloseAll;

    if ReadTrans.Active then
      ReadTrans.CloseTransaction;

    if WriteTrans.Active then
      WriteTrans.CloseTransaction;
  finally
    if Verbose then
      StopWait;
  end;

  FActive := false;
  FModified := false;

  SiMain.LeaveMethod(Self, 'CloseDataSets');
end;

function TBaseDataModule.CloseQuery: Boolean;
begin
  SiMain.EnterMethod(Self, 'CloseQuery');
  result := True;

  if not Config.Database.Connected then
    exit;

  if Modified then
  begin
    StopWait;
    case ConfirmYesNoCancel('Salvo le modifiche?', mtInformation) of
      mrCancel:
        result := false;
      mrYes:
        result := Commit;
      mrNo:
        Rollback(false);
    end;
  end;
  SiMain.LeaveMethod(Self, 'CloseQuery');
end;

function TBaseDataModule.Commit(const Verbose: Boolean = True): Boolean;
begin
  SiMain.EnterMethod(Self, 'Commit');

  if Verbose then
    StartWait;
  try
    result := false;
    dbMaster.PostAll;

    // per i savepoints
    while WriteTrans.Active and not Application.Terminated do
      WriteTrans.Commit;

    FModified := false;

    result := True;
  finally
    if Verbose then
      StopWait;
  end;
  SiMain.LeaveMethod(Self, 'Commit');
end;

procedure TBaseDataModule.CreateDataSets;
  procedure DoIt(DiagramDataSets: TzDiagramDataSets);
  var
    zDiagramDataSet: TzDiagramDataSet;
    zDataSet: TzDataSet;
    I: Integer;
  begin

    for I := 0 to DiagramDataSets.count - 1 do
    begin
      zDiagramDataSet := DiagramDataSets[I];

      zDataSet := zDiagramDataSet.zDataSet(false);

      if assigned(zDataSet) then
        if not zDataSet.LazyCreate then
          GetDataSet(zDiagramDataSet.Name);

      if zDiagramDataSet.HasDetailDataSets then
        DoIt(zDiagramDataSet.DetailDatasets);
    end;
  end;

begin
  DestroyDataSets;
  DoIt(zDataModule.DataSets);
end;

procedure TBaseDataModule.DataModuleCreate(Sender: TObject);
begin;
end;

procedure TBaseDataModule.DataModuleDestroy(Sender: TObject);
begin;
end;

function TBaseDataModule.DataModuleID: string;
begin
  result := Self.Name;

  if assigned(zDataModule) and (zDataModule.Name <> '') then
    result := zDataModule.Name;
end;

function TBaseDataModule.DataSetExists(const DataSetName: String): Boolean;
begin
  result := assigned(FindDataSet(DataSetName));
end;

procedure TBaseDataModule.DataSetInitProps(const DataSet: TzFbDataSet);
begin
  assert(assigned(DataSet));
  SiMain.LogVerbose('InitDataSet: ' + DataSet.Name);
  DataSet.CachedUpdates := false;
  DataSet.Database := Config.Database;
  SetDataSetTransactions(DataSet);

  if trim(DataSet.idDataSet) = '' then
    DataSet.idDataSet := DataModuleID + '.' + DataSet.Name;
end;

procedure TBaseDataModule.DataSetLoadProps(const DataSet: TzFbDataSet);
begin
  assert(assigned(DataSet));
  SiMain.LogVerbose('DataSetLoadProps: ' + DataSet.Name);
  try
    Config.zSystem.DataSetLoadProps(DataSet);
    SiMain.LogVerbose('After DataSetLoadProps: ' + DataSet.Name);
  except
    on e: exception do
      if not(e is eAbort) then
        ApplicationShowException(e);
  end;
end;

procedure TBaseDataModule.dbMasterOpenProgress(Sender: TObject; ItemName: string; ItemNo: Integer);
begin
  SiMain.LogString('Apertura DataSet', ItemName);

  if assigned(dbMaster.DataSets[ItemNo].DataSet) then
    SiMain.LogObject('Apertura DataSet', dbMaster.DataSets[ItemNo].DataSet);

  inherited;
  OutputDebugString(PChar(ItemName + ' ' + IntToStr(GetTickCount)));
end;

procedure TBaseDataModule.DestroyDataSets;
var
  I: Integer;
  Component: TComponent;
begin
  VisibleDataSets.Clear;
  ReportsManager.ClearDataSets;

  for I := DynamicDbComponents.count - 1 downto 0 do
  begin
    Component := DynamicDbComponents[I];
    DynamicDbComponents.Delete(I);
    FreeAndNil(Component);
  end;
end;

function TBaseDataModule.EditDatamodule: Boolean;
begin
  result := false;

  if Config.zSystem.IsAdmin then
    if Edit_CollectionItem(Config.zSystem, zDataModule) then
    begin
      zDataModule.SaveToBase(True);
      LoadDataModuleProps;
      OpenDataSets;
      result := True;
    end;
end;

function TBaseDataModule.FindDataSet(const DataSetName: String): TzFbDataSet;
var
  cmp: TComponent;
begin
  result := nil;

  cmp := FindComponent(DataSetName);

  if assigned(cmp) then
    if cmp is TzFbDataSet then
      result := TzFbDataSet(cmp);
end;

function TBaseDataModule.GetDataSet(const DataSetName: string): TzFbDataSet;
var
  idxGenerator: Integer;
  SalvaFileSLTutto: Boolean;
  zDiagramDataSet: TzDiagramDataSet;
  zDataSet: TzDataSet;
begin
  SiMain.EnterMethod(Self, 'GetDataSet: ' + DataSetName);

  if DataSetName = '' then
    exit(Nil);

  if DisableGetDataSet then
    exit(Nil);

  zDiagramDataSet := zDataModule.FindDataSet(DataSetName);
  if not assigned(zDiagramDataSet) then
    raise exception.Create('Dataset ' + DataSetName + ' non trovato nel datamodule.');

  result := FindDataSet(DataSetName);

  if assigned(result) then
  begin
    if zDiagramDataSet.HasMasterDataSet then
      result.DataSource := GetDataSource(GetDataSet(zDiagramDataSet.MasterDataSet.Name));
  end
  else
  begin
    result := TzFbDataSet.Create(Self);
    DynamicDbComponents.add(result);
    result.Name := zDiagramDataSet.Name;
    result.AutoCommit := True;
    GetDataSource(result);

    DataSetInitProps(result);
    DataSetLoadProps(result);

    // AddPipeline(result);
    zDataSet := zDiagramDataSet.zDataSet;
    if assigned(zDataSet) then
      dbMaster.AddDataSet(DataSetName, result).IncludeInOpen := zDataSet.ActivationMode = amAutomatic;

    AfterCreateDataSet(DataSetName, result);
  end;

  /// ////////////////////////////////////////////////////////

  ReportsManager.AddDataSet(result);
  VisibleDataSets.add(result);
  AddSharedReports(zDiagramDataSet.ReportProps.SharedReports);

  /// ////////////////////////////////////////
  SiMain.LeaveMethod(Self, 'GetDataSet: ' + DataSetName);
end;

procedure TBaseDataModule.AddSharedReports(SharedReports: TStrings);
var
  SharedReport: string;
begin
  for SharedReport in SharedReports do
    if ReportsManager.SharedReports.IndexOf(SharedReport) = -1 then
      ReportsManager.SharedReports.add(SharedReport);
end;

function TBaseDataModule.GetDataSource(zFbDataSet: TzFbDataSet): TDataSource;
  function FindDataSource(const DataSourceName: String): TDataSource;
  var
    cmp: TComponent;
  begin
    result := nil;

    cmp := FindComponent(DataSourceName);

    if assigned(cmp) then
      if cmp is TDataSource then
        result := TDataSource(cmp);
  end;

var
  DataSourceName: string;
begin
  assert(assigned(zFbDataSet));
  // crea/cerca a partire dal dataset

  result := nil;

  if not assigned(zFbDataSet) then
    exit;

  DataSourceName := zFbDataSet.Name + 'Src';

  result := FindDataSource(DataSourceName);

  if not assigned(result) then
  begin
    result := TDataSource.Create(Self);
    DynamicDbComponents.add(result);
    result.Name := DataSourceName;
    result.DataSet := zFbDataSet;
  end;
end;

function TBaseDataModule.GetElencoDataSet: string;
var
  StringList: TStringList;
  comp: TComponent;
  DataSet: TDataSet;
begin
  result := '';

  StringList := TStringList.Create;
  try
    StringList.add('DM: ' + Name);
    StringList.add('');

    for comp in Self do
      if comp is TDataSet then
      begin
        DataSet := TDataSet(comp);

        if DataSet.Active then
          StringList.add(DataSet.Name + ' Aperto')
        else
          StringList.add(DataSet.Name + ' Chiuso');
      end;

    result := StringList.Text;
  finally
    FreeAndNil(StringList);
  end;
end;

function TBaseDataModule.GetModified: Boolean;
var
  I: Integer;
  S: string;
begin
  result := false;

  if not Config.Database.Connected then
    exit;

  if FModified then
  begin
    result := True;
    exit;
  end;

  for I := 0 to ComponentCount - 1 do
    if Components[I] is TzFbDataSet then
      if isTableModified(Components[I] as TzFbDataSet) then
      begin
        result := True;
        break;
      end;
end;

function TBaseDataModule.GetReadTrans: TzFbTransaction;
begin

  if not assigned(FReadTrans) then
  begin
    FReadTrans := TzFbTransaction.Create(Self);
    FReadTrans.Name := 'ReadTrans';

    FReadTrans.Options.Isolation := xiReadCommitted;
    FReadTrans.Connection := Config.Database;
  end;

  result := FReadTrans;
end;

function TBaseDataModule.GetReadTransaction: TzFbTransaction;
begin
  result := ReadTrans
end;

function TBaseDataModule.GetWriteTrans: TzFbTransaction;
begin

  if not assigned(FWriteTrans) then
  begin
    FWriteTrans := TzFbTransaction.Create(Self);
    FWriteTrans.Name := 'WriteTrans';

    FWriteTrans.Options.Isolation := xiReadCommitted;
    FWriteTrans.Connection := Config.Database;
  end;

  result := FWriteTrans;
end;

function TBaseDataModule.GetWriteTransaction: TzFbTransaction;
begin
  result := WriteTrans
end;

procedure TBaseDataModule.InitComponents;
var
  I: Integer;
  comp: TComponent;
  DataSet: TzFbDataSet;
  Transaction: TzFbTransaction;
  zDbViewDlg: TzDbViewDlg;
  zDbCardDlg: TzDbCardDlg;
begin
  SiMain.EnterMethod(Self, 'InitComponents');
  inherited;
  FActive := false;
  FModified := false;

  for I := 0 to ComponentCount - 1 do
  begin
    comp := Components[I];

    if comp is TDataSet then
    begin
      // AddPipeline(Comp as TDataSet);

      if comp is TzFbDataSet then
      begin
        DataSet := TzFbDataSet(comp);
        // Le transazioni vengono impostate da lodProps.
        // Se non si annullano rimangono impostate quelle di design time,
        // con il rischio di trovarsi la readTrans sulla transazione di update
        DataSet.AutoCommit := True;
        SetDataSetTransactions(DataSet);
      end;
    end
    else
      if comp is TFdCommand then
      begin
        TFdCommand(comp).Connection := Config.Database;
        TFdCommand(comp).Transaction := WriteTrans;
      end
      else
        if comp is TzFbTransaction then
        begin
          Transaction := comp as TzFbTransaction;
          if not Transaction.Active then
            Transaction.Connection := Config.Database;
        end
        else
          if comp is TzDbViewDlg then
          begin
            zDbViewDlg := comp as TzDbViewDlg;
            zDbViewDlg.zSystem := Config.zSystem;
          end
          else
            if comp is TzDbCardDlg then
            begin
              zDbCardDlg := comp as TzDbCardDlg;
              zDbCardDlg.zSystem := Config.zSystem;
            end;
  end;

  SiMain.LeaveMethod(Self, 'InitComponents');
end;

function TBaseDataModule.IsDataSetVisible(const DataSetName: string): Boolean;
var
  DataSet: TzFbDataSet;
begin
  result := false;

  for DataSet in VisibleDataSets do
    if SameText(DataSet.Name, DataSetName) then
      exit(True);
end;

function TBaseDataModule.isTableModified(DataSet: TzFbDataSet): Boolean;
begin
  result := false;
  try
    if DataSet.State in dsEditModes then
      DataSet.UpdateRecord;
  except
  end;

  if (DataSet.Modified) or (DataSet.State = dsInsert) then
    result := True;
end;

procedure TBaseDataModule.OnSlowDataSet(Sender: TObject; ItemName: string; DataSet: TDataSet; TimeSpan: TTimeSpan);
var
  FileHandle: TextFile;
  I: Integer;
  IoRes: Integer;
  LogFileName: string;
  S: string;
  zFbDataSet: TzFbDataSet;
begin
  if not(DataSet is TzFbDataSet) then
    exit;

  zFbDataSet := TzFbDataSet(DataSet);
  /// //////////////////////////////////////////

  LogFileName := Path + 'QueryLente.Log';
{$I-}
  AssignFile(FileHandle, LogFileName);

  if FileExists(LogFileName) then
    Append(FileHandle)
  else
    Rewrite(FileHandle);

  WriteLn(FileHandle, '------------------------------------------------------------------');
  WriteLn(FileHandle, 'Data: ' + DateTimeToStr(now) + ' - Utente: ' + Config.CurrentUser);
  WriteLn(FileHandle, 'DataModule: ' + DataModuleID);
  WriteLn(FileHandle, 'DataSet: ' + zFbDataSet.Name);
  WriteLn(FileHandle, 'Tempo di apertura: ' + Format(' min. %d sec. %d', [TimeSpan.Minutes, TimeSpan.Seconds]));
  WriteLn(FileHandle, '------------------------------');

  if zFbDataSet.ParamCount > 0 then
  begin
    WriteLn(FileHandle, 'Parametri: ');
    WriteLn(FileHandle, '');
    for I := 0 to zFbDataSet.ParamCount - 1 do
      WriteLn(FileHandle, zFbDataSet.params[I].Name + '=' + zFbDataSet.params[I].asString);
    WriteLn(FileHandle, '------------------------------');
  end;
  WriteLn(FileHandle, '');

  if DataSet is TzFbDataSet then
  begin
    WriteLn(FileHandle, TzFbDataSet(DataSet).SelectSQL.Text);
    WriteLn(FileHandle, '');
  end;

  CloseFile(FileHandle);
{$I+} IoRes := IOResult;
end;

procedure TBaseDataModule.OpenDataSets(const silent: Boolean = false);
begin
  SiMain.EnterMethod(Self, 'OpenDataSets');

  if csDestroying in ComponentState then
    exit;

  if not silent then
    StartWait('Attendere...', not Active);
  try
    try
      if assigned(dbMaster) then
        dbMaster.OpenAll;

      Active := True;
    except
      on e: exception do
        if not(e is eAbort) then
          ApplicationShowException(e);
    end;
  finally
    if not silent then
      StopWait;
  end;
  SiMain.LeaveMethod(Self, 'OpenDataSets');
end;

procedure TBaseDataModule.ParamChanged(params: array of string);
var
  I: Integer;
  DataSet: TzFbDataSet;
  ParamName: string;
begin
  // chiamato al variare di belfiore/anno di lavoro
  StartWait;
  try
    for I := 0 to dbMaster.DataSets.count - 1 do
      if assigned(dbMaster.DataSets[I].DataSet) then
        if dbMaster.DataSets[I].DataSet.Active then
          if dbMaster.DataSets[I].DataSet is TzFbDataSet then
          begin
            DataSet := TzFbDataSet(dbMaster.DataSets[I].DataSet);

            for ParamName in params do
              if DataSet.ParamExists(ParamName) then
              begin
                DataSet.ReOpen(True);
                break;
              end;
          end;
  finally
    StopWait;
  end;
end;

procedure TBaseDataModule.RefreshDataSets;
var
  I: Integer;
begin
  SiMain.EnterMethod(Self, 'RefreshDataSets');

  StartWait;
  try
    if not Active then
      exit;

    if CloseQuery then
    begin
      CloseDataSets;

      if CtrlKey then
      begin
        for I := 0 to ComponentCount - 1 do
          if Components[I] is TzFbDataSet then
            TzFbDataSet(Components[I]).UnPrepare;
      end;

      OpenDataSets(True);
    end;
  finally
    StopWait;
  end;
  SiMain.LeaveMethod(Self, 'RefreshDataSets');
end;

procedure TBaseDataModule.ReopenDataSet(const DataSetName: string);
var
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet(DataSetName);
  if assigned(DataSet) then
    DataSet.ReOpen(True);
end;

procedure TBaseDataModule.Rollback(const ReopenDataSets: Boolean; const Verbose: Boolean = True);
var
  I: Integer;
begin
  SiMain.EnterMethod(Self, 'Rollback');
  if Verbose then
    StartWait;
  try
    dbMaster.CancelAll;

    // per i savepoints
    while WriteTrans.Active and not Application.Terminated do
      WriteTrans.Rollback;

    FModified := false;

    if ReopenDataSets then
      for I := 0 to dbMaster.DataSets.count - 1 do
        if assigned(dbMaster.DataSets[I].DataSet) then
          if dbMaster.DataSets[I].DataSet is TzFbDataSet then
            TzFbDataSet(dbMaster.DataSets[I].DataSet).ReOpen(True);
  finally
    if Verbose then
      StopWait;
  end;
  SiMain.LeaveMethod(Self, 'Rollback');
end;

procedure TBaseDataModule.SetActive(const Value: Boolean);
begin
  FActive := Value;
end;

procedure TBaseDataModule.SetAutoCommit(const AutoCommit: Boolean = false);
var
  I: Integer;
  comp: TComponent;
begin
  inherited;
  //
  // WriteTrans.TPBMode := tpbDefault;
  // WriteTrans.TRParams.Clear;
  // WriteTrans.TRParams.Add('isc_tpb_read');
  // WriteTrans.TRParams.Add('isc_tpb_write');
  // WriteTrans.TRParams.Add('isc_tpb_read_committed');
  // WriteTrans.TRParams.Add('isc_tpb_rec_version');
  // WriteTrans.TRParams.Add('isc_tpb_nowait');

  for I := 0 to ComponentCount - 1 do
  begin
    comp := Components[I];

    if comp is TzFbDataSet then
      SetAutoCommit(comp as TzFbDataSet, AutoCommit);
  end;
end;

procedure TBaseDataModule.SetAutoCommit(DataSet: TzFbDataSet; const AutoCommit: Boolean);
begin
  DataSet.AutoCommit := AutoCommit;
  SetDataSetTransactions(DataSet);
end;

procedure TBaseDataModule.SetDataSetTransactions(DataSet: TzFbDataSet);
var
  WasActive: Boolean;
begin
  if not assigned(DataSet) then
    exit;

  WasActive := DataSet.Active;
  DataSet.Active := false;
  try
    DataSet.UpdateTransaction := GetWriteTransaction;
    if DataSet.AutoCommit then
      DataSet.Transaction := GetReadTransaction
    else
      DataSet.Transaction := GetWriteTransaction;
  finally
    DataSet.Active := WasActive;
  end;
end;

procedure TBaseDataModule.SetzDataModule(const Value: TzDataModule);
begin
  FzDataModule.assign(Value);
end;

procedure TBaseDataModule.StartTransaction;
begin

  if not WriteTrans.Active then
    WriteTrans.StartTransaction;
end;

procedure TBaseDataModule.TogliAutoOpen(DataSet: TDataSet);
var
  I: Integer;
begin
  for I := 0 to dbMaster.DataSets.count - 1 do
    if dbMaster.DataSets[I].DataSet = DataSet then
      dbMaster.DataSets[I].IncludeInOpen := false;
end;

procedure TBaseDataModule.LoadDataModuleProps;

  procedure EnumMaster(DiagramDataSet: TzDiagramDataSet);
  begin
    if assigned(DiagramDataSet) then
    begin
      ReportsManager.SharedReports.AddStrings(DiagramDataSet.ReportProps.SharedReports);
      EnumMaster(DiagramDataSet.MasterDataSet);
    end;
  end;

var
  DataSet: TzFbDataSet;
  I: Integer;
  DiagramDataSet: TzDiagramDataSet;
begin
  SiMain.EnterMethod(Self, 'LoadDatamoduleProps');
  CloseDataSets(false);
  DestroyDataSets; // altrimenti verranno caricati come facenti parte del datamodule
  zDataModule.LoadFromBase;

  if zDataModule.LoadFromDataModule(Self) then
    zDataModule.SaveToBase(false); // ZZ 11.12.2025 Era true, causando continui salvataggi: esiste qualche motivo?

  CreateDataSets;

  for I := 0 to ComponentCount - 1 do
    if Components[I] is TzFbDataSet then
    begin
      DataSet := Components[I] as TzFbDataSet;

      if not DynamicDbComponents.Contains(Components[I]) then // 15.01.2026: quelli dinamici sono settati in GetDataSet
      begin
        DataSetInitProps(DataSet);
        DataSetLoadProps(DataSet);
        ReportsManager.AddDataSet(DataSet);
      end;

      VisibleDataSets.add(DataSet);
    end;

  ReportsManager.SharedReports.Clear;
  for DiagramDataSet in zDataModule.DataSets do
    EnumMaster(DiagramDataSet);

  SiMain.LeaveMethod(Self, 'LoadDatamoduleProps');
end;

procedure TBaseDataModule.DatasetSelected(DiagramDataSet: TzDiagramDataSet);
  procedure EnumMaster(DiagramDataSet: TzDiagramDataSet);
  var
    DataSet: TzFbDataSet;
  begin
    if assigned(DiagramDataSet) then
    begin
      DataSet := GetDataSet(DiagramDataSet.Name);
      // spostato in getDataSet VisibleDataSets.add(DataSet);
      // spostato in getDataSet ReportsManager.SharedReports.AddStrings(DiagramDataSet.ReportProps.SharedReports);
      // spostato in ReportsManager.AddDataSet(DataSet);
      EnumMaster(DiagramDataSet.MasterDataSet);
    end;
  end;

  procedure EnumDetails(DiagramDataSet: TzDiagramDataSet);
  var
    child: TzDiagramDataSet;
    DataSet: TzFbDataSet;
  begin
    if assigned(DiagramDataSet) then
      for child in DiagramDataSet.DetailDatasets do
      begin
        DataSet := GetDataSet(child.Name);
        // spostato in VisibleDataSets.add(DataSet);
        // spostato in ReportsManager.AddDataSet(DataSet);
        EnumDetails(child);
      end;
  end;

begin
  VisibleDataSets.Clear;
  ReportsManager.ClearDataSets;

  ReportsManager.Folder := DiagramDataSet.ReportProps.ReportGroup;
  // ReportsManager.Folder := DiagramDataSet.ReportProps.PipeName;

  ReportsManager.SharedReports.Clear;
  EnumMaster(DiagramDataSet);
  EnumDetails(DiagramDataSet);
end;

procedure TBaseDataModule.Print(ReportGroup: string; SelectedDataSetName: string);
begin
  AddReportDatasets;
  ReportsManager.Folder := ReportGroup;
  ReportsManager.ShowReportForm(GetDataSet(SelectedDataSetName));
end;

procedure TBaseDataModule.RefreshDataSet(Const DataSetName: string);
var
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet(DataSetName);
  DataSet.ReOpen();
end;

procedure TBaseDataModule.RefreshRecord(Const DataSetName: string; AClearRow: Boolean = True);
var
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet(DataSetName);
  DataSet.RefreshRecord(AClearRow);
end;

function TBaseDataModule.GetSP<T>: T;
var
  GetSP: zStoredProc.TzStoredProc;
begin
  result := T.Create;

  SiMain.LogVerbose(result.StoredProcName);

  result.zSystem := Config.zSystem;
  result.Database := Config.Database;
  result.Transaction := WriteTrans;
end;

end.

  ReportsManager.SharedReports.AddStrings
(DiagramDataSet.ReportProps.SharedReports); zFbDataSet
zsystem
