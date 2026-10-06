unit frmFbProfiler;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  System.Generics.Collections,
  System.Actions,
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
  Vcl.ActnList,
  dxBar,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  Frame_Editor_SQL,
  Vcl.Menus,
  cxStyles,
  cxDBData,
  dxLayoutControlAdapters,
  dxLayoutcxEditAdapters,
  dxLayoutContainer,
  dxBarBuiltInMenu,
  cxGridCustomPopupMenu,
  cxGridPopupMenu,
  Vcl.ImgList,
  cxImageList,
  cxGridLevel,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  cxProgressBar,
  Vcl.StdCtrls,
  cxButtons,
  dxLayoutControl;

type
  TFormFbProfiler = class(TBaseForm)
    editorSQL: TFrameEditor_Sql;
    dxLayoutControl: TdxLayoutControl;
    btnExecuteQuery: TcxButton;
    btnCancelQuery: TcxButton;
    progressExec: TcxProgressBar;
    viewSessions: TzDbView;
    viewResults: TzDbView;
    lblStatus: TcxLabel;
    dxLayoutControlGroup_Root: TdxLayoutGroup;
    dxLayoutItemBtnStart: TdxLayoutItem;
    dxLayoutItemBtnAnnulla: TdxLayoutItem;
    dxLayoutItemProgress: TdxLayoutItem;
    dxLayoutItemeditorSQL: TdxLayoutItem;
    dxLayoutGroupSessioni: TdxLayoutGroup;
    dxLayoutItemSessioni: TdxLayoutItem;
    dxLayoutSplitterItem2: TdxLayoutSplitterItem;
    dxLayoutGroupResult: TdxLayoutGroup;
    dxLayoutItemResult: TdxLayoutItem;
    dxLayoutItemStatus: TdxLayoutItem;
    dxLayoutGroupProgress: TdxLayoutGroup;
    dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem;
    ActionList: TActionList;
    actExecuteQuery: TAction;
    actCancelQuery: TAction;
    cxImageList: TcxImageList;
    cxGridPopupMenuSessions: TcxGridPopupMenu;
    cxGridPopupMenuResult: TcxGridPopupMenu;
    dxLayoutGroupBottom: TdxLayoutGroup;
    dxLayoutGroupTop: TdxLayoutGroup;
    dxLayoutGroupMain: TdxLayoutGroup;
    dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem;
    dxBarLargeButton1: TdxBarLargeButton;
    dxBarButton1: TdxBarButton;
    dxLayoutSplitterItem1: TdxLayoutSplitterItem;
    procedure actCancelQueryExecute(Sender: TObject);
    procedure actExecuteQueryExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure editorSQLPrepare(Sender: TObject);
    procedure viewSessionsDataSetDelete(Sender: TObject);
    procedure dxBarLargeButton1Click(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  private
    procedure HandleQueryComplete(ADuration: Double; ARecords: Int64);
    procedure HandleStatusChange(const AMessage: string; AColor: TColor);
    procedure SetupUI;

  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormFbProfiler: TFormFbProfiler;

implementation

uses
  zDm_Images,
  dmFbProfiler,
  zSystem,
  zMsg,
  zBaseLib;

{$R *.dfm}

procedure TFormFbProfiler.CreateDataModule;
begin
  inherited;
  CreateDM(TFbProfiler, FbProfiler);
  FbProfiler.OnStatusChange := HandleStatusChange;
  FbProfiler.OnQueryComplete := HandleQueryComplete;
end;

procedure TFormFbProfiler.DestroyDataModule;
begin
  inherited;
  FreeAndNil(FbProfiler);
end;

constructor TFormFbProfiler.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'FbProfiler';
  Caption := 'FbProfiler';

  EnterAsTab := false;

  SetupUI;

  viewSessions.zDataSet := FbProfiler.Sessions;
  viewResults.zDataSet := FbProfiler.Results;
end;

procedure TFormFbProfiler.SetupUI;
begin
  editorSQL.Metadata := base.Metadata;
  editorSQL.SQL := 'SELECT * FROM RDB$RELATIONS WHERE RDB$SYSTEM_FLAG = 0';

  // Setup iniziale
  progressExec.Visible := false;
end;

procedure TFormFbProfiler.HandleQueryComplete(ADuration: Double; ARecords: Int64);
begin
  progressExec.Visible := false;
  progressExec.Properties.Marquee := false;
end;

procedure TFormFbProfiler.HandleStatusChange(const AMessage: string; AColor: TColor);
begin
  lblStatus.Caption := AMessage;
  lblStatus.Style.TextColor := AColor;
  Application.ProcessMessages;
end;

procedure TFormFbProfiler.ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
var
  HasSessions: Boolean;
begin
  inherited;
  HasSessions := not FbProfiler.Sessions.IsEmpty;

  actExecuteQuery.Enabled := True; // Sempre abilitato
  actCancelQuery.Enabled := FbProfiler.Running;

  Handled := True;
end;

procedure TFormFbProfiler.actExecuteQueryExecute(Sender: TObject);
var
  DescSessione: string;
  SQL: string;
begin
  inherited;
  if FbProfiler.Running then
    Exit;

  SQL := editorSQL.SQL.Trim;

  if SQL = '' then
  begin
    ConfirmOk('Inserire una query SQL da eseguire');
    editorSQL.SetFocus;
    Exit;
  end;

  DescSessione := 'Sessione - ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', Now);

  if not InputQuery('Sessione', 'Sessione', DescSessione) then
    Exit;

  if FbProfiler.ExecuteQuery(DescSessione, SQL, True) then
  begin
    progressExec.Visible := True;
    progressExec.Properties.Marquee := True;
  end;
end;

procedure TFormFbProfiler.actCancelQueryExecute(Sender: TObject);
begin
  inherited;
  FbProfiler.CancelQuery;
  progressExec.Visible := false;
end;

procedure TFormFbProfiler.editorSQLPrepare(Sender: TObject);
var
  SQL: string;
begin
  inherited;

  SQL := editorSQL.SQL.Trim;

  FbProfiler.PrepareSQL(SQL);
end;

procedure TFormFbProfiler.viewSessionsDataSetDelete(Sender: TObject);
var
  Sessions: TList<integer>;
begin
  inherited;

  Sessions := TList<integer>.Create;
  try
    viewSessions.GetSelectedRows('PROFILE_ID', Sessions);
    FbProfiler.DeleteAllSessions(Sessions);
    viewSessions.ApplyBestFit
  finally
    FreeAndNil(Sessions);
  end;
end;

procedure TFormFbProfiler.dxBarLargeButton1Click(Sender: TObject);

// procedure doIt(view: TzDbView);
// var
// i: integer;
// field: TField;
// Caption: string;
// domain: TzDomain;
// origin: string;
// zControl: TzControlProps;
// zColumn: TzColumn;
// begin
// for i := 0 to view.cxGridDBTableView.ColumnCount - 1 do
// begin
// field := TcxGridDBColumn(view.cxGridDBTableView.Columns[i]).DataBinding.field;
// Caption := view.cxGridDBTableView.Columns[i].Caption;
// Caption := zzCapFirst(Caption, True);
// //
// zColumn := view.GetDbViewProps.Columns.Get(field.FieldName, False);
// zColumn.Caption := Caption;
// //
// zControl := view.zDbCardDlg.zDbCardForm.zDbCard.zDbCardProps.Controls.Get(field.FieldName);
// zControl.DisplayLabel := Caption;
// //
// origin := view.DataController.GetFieldOrigin(field);
// domain := base.zDataDictionary.Get(origin, False);
// domain.DisplayLabel := Caption;
// end;
//
// view.GetDbViewProps.SaveToBase(True);
// view.zDbCardDlg.zDbCardForm.zDbCard.zDbCardProps.SaveToBase(True);
// end;

begin
  inherited;
  // doIt(viewSessions);
  // doIt(viewResults);
  // base.SaveZip(csDataDictionary, '');
end;

end.



zFileViewer .TzFileViewer.FileSaveAsAccept
