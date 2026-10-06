unit frmFbMonitor;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  zDbView,
  BaseFrm,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  System.Actions,
  Vcl.ActnList,
  dxBar,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  System.ImageList,
  Vcl.ImgList,
  cxImageList,
  dxLayoutContainer,
  dxLayoutControl,
  dxLayoutcxEditAdapters,
  cxDBLabel;

type
  TFormFbMonitor = class(TBaseForm)
    ActionList: TActionList;
    KillConnection: TAction;
    CancelStatement: TAction;
    layoutDB: TdxLayoutControl;
    layoutDBGroup_Root1: TdxLayoutGroup;
    cxImageList: TcxImageList;
    dxLayoutGroupDatabase: TdxLayoutGroup;
    dxLayoutGroupDimensioni: TdxLayoutGroup;
    dxLayoutGroupBufferCache: TdxLayoutGroup;
    dxLayoutGroupCreazione: TdxLayoutGroup;
    lblDatabaseName: TcxDBLabel;
    lblODS: TcxDBLabel;
    styleTytle: TcxEditStyleController;
    lblPagine: TcxDBLabel;
    lblDimensione: TcxDBLabel;
    lblBufferCount: TcxDBLabel;
    lblBufferCache: TcxDBLabel;
    lblCreationTime: TcxDBLabel;
    lblCreationDate: TcxDBLabel;
    dxLayoutItemDatabaseName: TdxLayoutItem;
    dxLayoutItemODS: TdxLayoutItem;
    dxLayoutItemDimensione: TdxLayoutItem;
    dxLayoutItemPagine: TdxLayoutItem;
    dxLayoutItemBufferCache: TdxLayoutItem;
    dxLayoutItemBufferCount: TdxLayoutItem;
    dxLayoutItemCreationDate: TdxLayoutItem;
    dxLayoutItemCreationTime: TdxLayoutItem;
    AlignmentConstraint1: TdxLayoutAlignmentConstraint;
    CancelConnectionStatement: TAction;
    procedure CancelConnectionStatementExecute(Sender: TObject);
    procedure CancelStatementExecute(Sender: TObject);
    procedure KillConnectionExecute(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure AfterCreateControls; override;
    procedure SetPK(const Value: Variant); override;
  private
    procedure InitLabels;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormFbMonitor: TFormFbMonitor;

implementation

uses
  zDm_Images,
  dmFbMonitor,
  zDX,
  System.Math,
  zHyperLinks,

  cxFilter;

{$R *.dfm}

procedure TFormFbMonitor.CreateDataModule;
begin
  inherited;
  CreateDM(TFbMonitor, FbMonitor);
end;

procedure TFormFbMonitor.DestroyDataModule;
begin
  inherited;
  FreeAndNil(FbMonitor);
end;

constructor TFormFbMonitor.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'FbMonitor';
  Caption := 'FbMonitor';

  styleTytle.Style.Font.Assign(dx.NormalStyleController.Style.Font);
  styleTytle.Style.Font.Size := 14;
  styleTytle.Style.Font.Style := styleTytle.Style.Font.Style + [fsBold];

  dx.InitLayoutControl(layoutDB);
  layoutDB.Visible := False;
  layoutDB.Parent := Self;
  layoutDB.OptionsImage.Images := cxImageList;
  layoutDB.Height := dx.LayoutControlHeigth(layoutDB);

  InitLabels;
end;

procedure TFormFbMonitor.AfterCreateControls;
begin
  inherited;
  AddLayoutItem(layoutDB, 'layoutDB', False);
end;

procedure TFormFbMonitor.CancelConnectionStatementExecute(Sender: TObject);
begin
  inherited;
  FbMonitor.CancelConnectionStatement;
end;

procedure TFormFbMonitor.CancelStatementExecute(Sender: TObject);
begin
  inherited;
  FbMonitor.CancelStatement;
end;

procedure TFormFbMonitor.KillConnectionExecute(Sender: TObject);
begin
  inherited;
  FbMonitor.KillConnection;
end;

procedure TFormFbMonitor.InitLabels;
  procedure InitLabel(cxDBLabel: TcxDBLabel; const fieldName: string; styleTitle: boolean);
  begin
    cxDBLabel.DataBinding.DataSource := FbMonitor.DataBaseSrc;
    cxDBLabel.DataBinding.DataField := fieldName;

    if styleTitle then
      cxDBLabel.Style.StyleController := styleTytle
    else
      cxDBLabel.Style.StyleController := dx.NormalStyleController;
  end;

begin
  InitLabel(lblDatabaseName, 'DATABASE_FILE_NAME', true);
  InitLabel(lblODS, 'ODS_VERSION', False);

  InitLabel(lblDimensione, 'SIZE_MB', true);
  InitLabel(lblPagine, 'PAGE_SIZE_', False);

  InitLabel(lblBufferCache, 'BUFFER_CACHE', true);
  InitLabel(lblBufferCount, 'PAGE_BUFFERS', False);

  InitLabel(lblCreationDate, 'CREATED_AT_DATE', true);
  InitLabel(lblCreationTime, 'CREATED_AT_TIME', False);
end;

procedure TFormFbMonitor.SetPK(const Value: Variant);
var
  view: TzDbView;
  id: integer;
  grp: TdxLayoutGroup;
begin
  inherited;

  grp := FormController.LayoutController.dxLayoutControl.FindItem('dxLayoutGroupDataModule_FbMonitor') as TdxLayoutGroup;

  if SameText(PkField, 'ATTACHMENT_ID') then
  begin
    // no, funziona solo con treemenu SelectedDataSetName := 'Monitor_Attachments';
    grp.itemIndex := 0;
    view := getView('Monitor_Attachments')
  end
  else
    if SameText(PkField, 'STATEMENT_ID') then
    begin
      // SelectedDataSetName := 'Monitor_Statements';
      grp.itemIndex := 1;
      view := getView('Monitor_Statements');
    end
    else
      exit;

  if Assigned(view) then
  begin
    view.ClearFilter(False);
    view.AddFilterCondition(PkField, foEqual, Value);
  end;
end;

initialization

HyperLinks.RegisterHandler('ATTACHMENT_ID', TFormFbMonitor);
HyperLinks.RegisterHandler('STATEMENT_ID', TFormFbMonitor);

end.

  FbMonitor.Monitor_Attachments zDX
