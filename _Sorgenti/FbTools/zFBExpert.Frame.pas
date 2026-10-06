unit zFBExpert.Frame;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  System.StrUtils,
  System.Variants,
  System.ImageList,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.ImgList,
  Vcl.ComCtrls,
  Vcl.ToolWin,
  Vcl.ActnList,
  Vcl.Menus,
  Vcl.StdActns,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Comp.Script,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Controls,
  FireDAC.VCLUI.Memo,
  FireDAC.VCLUI.Error,
  FireDAC.VCLUI.Login,
  FireDAC.VCLUI.Async,
  FireDAC.VCLUI.Wait,
  FireDAC.VCLUI.Script,
  FireDAC.Stan.Error,
  dxFileActions,
  cxImageList,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxTextEdit,
  cxMemo,
  dxStatusBar,
  dxBar,
  cxClasses,
  dxBarBuiltInMenu,
  cxPC,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxNavigator,
  dxDateRanges,
  dxScrollbarAnnotations,
  cxDBData,
  cxSplitter,
  cxGridLevel,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  dxLayoutContainer,
  cxInplaceContainer,
  cxVGrid,
  cxOI,
  dxLayoutControl,
  cxGridCustomPopupMenu,
  cxGridPopupMenu,
  dxCoreGraphics,
  cxMaskEdit,
  cxButtonEdit,
  cxTreeView,
  acQBBase,
  acSQLBuilderPlainText,
  acAST,
  acFBSynProvider,
  dxUIAClasses,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  Frame_Editor_SQL,
  zMetadata,
  zFBExpert.Engine,
  zFbDataSet,
  zDbView,
  zSystem,
  zDbCard;

type
  TzFBExpertFrame = class(TFrame)
    ActionList: TActionList;
    cxImageList: TcxImageList;
    dxBarManager: TdxBarManager;
    cxPageControl: TcxPageControl;
    tabEditor: TcxTabSheet;
    tabGrid: TcxTabSheet;
    editor: TFrameEditor_Sql;
    tabConfig: TcxTabSheet;
    layoutConfigGroup_Root: TdxLayoutGroup;
    layoutConfig: TdxLayoutControl;
    inspScript: TcxRTTIInspector;
    dxLayoutItemInspScript: TdxLayoutItem;
    cxGridPopupMenu: TcxGridPopupMenu;
    inspGrid: TcxRTTIInspector;
    dxLayoutItemInspGrid: TdxLayoutItem;
    dxLayoutSplitterItem1: TdxLayoutSplitterItem;
    pnlMetadata: TPanel;
    MetaTree: TcxTreeView;
    edSearch: TcxButtonEdit;
    cxSplitter: TcxSplitter;
    MetaTimer: TTimer;
    dxBarDockControl: TdxBarDockControl;
    barMetadata: TdxBar;
    dxBarButton1: TdxBarButton;
    Aggiungi: TAction;
    Modifica: TAction;
    Elimina: TAction;
    Aggiorna: TAction;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    metaImages: TcxImageList;
    dragDropPopup: TdxBarPopupMenu;
    dropSelect: TAction;
    dxBarButton5: TdxBarButton;
    dropExecProc: TAction;
    dropDrop: TAction;
    dropAlter: TAction;
    dxBarButton6: TdxBarButton;
    dxBarButton7: TdxBarButton;
    dxBarButton8: TdxBarButton;
    tabQueryBuilder: TcxTabSheet;
    acFirebirdSyntaxProvider: TacFirebirdSyntaxProvider;
    acSQLBuilderPlainText: TacSQLBuilderPlainText;
    queryBuilder16Images: TcxImageList;
    queryBuilder32Images: TcxImageList;
    acQueryBuilder: TacQueryBuilder;
    view: TzDbView;
    procedure acHelpExecute(Sender: TObject);
    procedure AggiornaExecute(Sender: TObject);
    procedure AggiungiExecute(Sender: TObject);
    procedure dropAlterExecute(Sender: TObject);
    procedure dropDropExecute(Sender: TObject);
    procedure dropExecProcExecute(Sender: TObject);
    procedure dropSelectExecute(Sender: TObject);
    procedure editorChange(Sender: TObject);
    procedure editorDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure editorDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure editorExecute(Sender: TObject);
    procedure editorPrepare(Sender: TObject);
    procedure edSearchPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure edSearchPropertiesEditValueChanged(Sender: TObject);
    procedure EliminaExecute(Sender: TObject);
    procedure MetaTimerTimer(Sender: TObject);
    procedure MetaTreeDblClick(Sender: TObject);
    procedure MetaTreeKeyPress(Sender: TObject; var Key: Char);
    procedure ModificaExecute(Sender: TObject);

    procedure acQueryBuilderValidatePopupMenu(Sender: TacQueryBuilder; AControlOwner: TacQueryBuilderControlOwner; AForControl: TControl; APopupMenu: TPopupMenu);
    procedure editorFormatSQL(Sender: TObject);
    procedure tabQueryBuilderEnter(Sender: TObject);
    procedure tabQueryBuilderHide(Sender: TObject);
    procedure tabQueryBuilderShow(Sender: TObject);
    procedure viewCardBeforeCreateControls(Sender: TObject);
    procedure viewCustomLoadProps(Sender: TObject);
    procedure viewCustomSaveProps(Sender: TObject);
  private
    dropPoint: TPoint;
    procedure MetaTreeDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure AssegnaMetadata;

    function GetSelectedNode(out elementName: string; out MetadataElement: TMetadataElement): Boolean;
    procedure AddSelectedMetadataObject;
    procedure CreateElement;
    procedure UpdateElement;
    procedure DropElement;
  private
    zFBExpertEngine: TzFBExpertEngine;
    procedure CreateFBExpertEngine;
  private
    zSystem: TzSystem;
    procedure ClearView;
    procedure InitView;
  private
    MasterQry: TacDatasource;
    procedure CheckQueryBuilderMetadata;
    procedure FillQueryBuilderMetadata;
    procedure RelationsMenuClick(Sender: TObject);
  public
    constructor Create(aOwner: TComponent); override;
  public
    procedure Init(azSystem: TzSystem; aConnection: TFDConnection; aReadTrans, aWriteTrans: TFDTransaction; aDataSet: TzFbDataSet; aMetadata: TzMetadata);
  end;

implementation

uses
  System.Types, System.IniFiles, FireDAC.Stan.Consts, FireDAC.Stan.Util,
  FireDAC.VCLUI.About, FireDAC.Comp.ScriptCommands, acQBLocalizer, zWaitFrm,
  zMsg;

{$R *.dfm}

constructor TzFBExpertFrame.Create(aOwner: TComponent);
var
  i: Integer;
begin
  inherited;
  zSystem := nil;
  dropPoint := point(-1, -1);

  cxPageControl.ActivePageIndex := 0;

  CreateFBExpertEngine;

  zFBExpertEngine.logProc := procedure(s: string)
    begin
      editor.Log.Lines.add(s);
    end;

  /// //////////////////////////////////////////////////////////

  editor.editor.OnDragDrop := editorDragDrop;
  editor.editor.OnDragOver := editorDragOver;

  for i := 0 to acQBLanguageManager.LanguagesCount - 1 do
    if sametext('italian', acQBLanguageManager.Language[i].LanguageName) then
    begin
      acQBLanguageManager.CurrentLanguageIndex := i;
      break;
    end;
end;

procedure TzFBExpertFrame.CreateFBExpertEngine;
begin
  zFBExpertEngine := TzFBExpertEngine.Create(self);
  inspScript.InspectedObject := zFBExpertEngine.FDScript;
end;

procedure TzFBExpertFrame.acHelpExecute(Sender: TObject);
var
  oCmdClass: TFDScriptCommandClass;
  oCmd: TFDScriptCommand;
begin
  FDScriptCommandRegistry().LookupCommand('HELP', oCmdClass);

  if oCmdClass = nil then
    Exit;

  oCmd := oCmdClass.Create(nil, zFBExpertEngine.FDScript);
  try
    oCmd.Execute;
  finally
    oCmd.Free;
  end;
end;

procedure TzFBExpertFrame.AssegnaMetadata;

  function AddNode(MetadataElement: TMetadataElement; Parent: TTreeNode; const ObjName: string): TTreeNode;
  begin
    result := MetaTree.Items.AddChild(Parent, ObjName);
    result.ImageIndex := ord(MetadataElement);
    result.SelectedIndex := ord(MetadataElement);
    result.Data := TCustomData(MetadataElement);
  end;

  function FilterOk(const MetaName, Filter: String): Boolean;
  begin
    result := (Filter = '') or (Ansipos(UpperCase(Filter), UpperCase(MetaName)) > 0);
  end;

  procedure FillTreeView;
  var
    Filter: string;

    nodeDomain, nodeTable, nodeView, nodeStoredProc, nodeFunc, nodePackage, nodeTrigger, nodeSequence: TTreeNode;

    i: Integer;
  begin
    Filter := edSearch.Text;

    MetaTree.Items.BeginUpdate;
    try
      MetaTree.Items.Clear;
      nodeDomain := AddNode(meDomain, nil, 'Domains');
      nodeTable := AddNode(meTable, nil, 'Tables');
      nodeView := AddNode(meView, nil, 'Views');
      nodeStoredProc := AddNode(meStoredProc, nil, 'Procedures');
      nodeFunc := AddNode(meFunc, nil, 'Functions');
      nodePackage := AddNode(mePackage, nil, 'Packages');
      nodeTrigger := AddNode(meTrigger, nil, 'Triggers');
      nodeSequence := AddNode(meSequence, nil, 'Sequences');

      for i := 0 to zFBExpertEngine.Metadata.Domains.count - 1 do
        if FilterOk(zFBExpertEngine.Metadata.Domains[i].name, Filter) then
          AddNode(meDomain, nodeDomain, zFBExpertEngine.Metadata.Domains[i].name);

      for i := 0 to zFBExpertEngine.Metadata.Tables.count - 1 do
        if FilterOk(zFBExpertEngine.Metadata.Tables[i].name, Filter) then
          AddNode(meTable, nodeTable, zFBExpertEngine.Metadata.Tables[i].name);

      for i := 0 to zFBExpertEngine.Metadata.Views.count - 1 do
        if FilterOk(zFBExpertEngine.Metadata.Views[i].name, Filter) then
          AddNode(meView, nodeView, zFBExpertEngine.Metadata.Views[i].name);

      for i := 0 to zFBExpertEngine.Metadata.Procedures.count - 1 do
        // if zFBExpertEngine.Metadata.Procedures[I].ParamsOutput.count > 0 then
        if FilterOk(zFBExpertEngine.Metadata.Procedures[i].name, Filter) then
          AddNode(meStoredProc, nodeStoredProc, zFBExpertEngine.Metadata.Procedures[i].name);

      for i := 0 to zFBExpertEngine.Metadata.Functions.count - 1 do
        if FilterOk(zFBExpertEngine.Metadata.Functions[i].name, Filter) then
          AddNode(meFunc, nodeFunc, zFBExpertEngine.Metadata.Functions[i].name);

      // for I := 0 to zFBExpertEngine.Metadata.Package.count - 1 do
      // if FilterOk(zFBExpertEngine.Metadata.Package[I].name, Filter) then
      // AddNode(mePackage, nodePackage, zFBExpertEngine.Metadata.Package[I].name);

      for i := 0 to zFBExpertEngine.Metadata.Triggers.count - 1 do
        if FilterOk(zFBExpertEngine.Metadata.Triggers[i].name, Filter) then
          AddNode(meTrigger, nodeTrigger, zFBExpertEngine.Metadata.Triggers[i].name);

      for i := 0 to zFBExpertEngine.Metadata.Generators.count - 1 do
        if FilterOk(zFBExpertEngine.Metadata.Generators[i].name, Filter) then
          AddNode(meSequence, nodeSequence, zFBExpertEngine.Metadata.Generators[i].name);

      nodeDomain.Text := Format('Domains (%d)', [nodeDomain.count]);
      nodeTable.Text := Format('Tables (%d)', [nodeTable.count]);
      nodeView.Text := Format('Views (%d)', [nodeView.count]);
      nodeStoredProc.Text := Format('Procedures (%d)', [nodeStoredProc.count]);
      nodeFunc.Text := Format('Functions (%d)', [nodeFunc.count]);
      nodePackage.Text := Format('Packages (%d)', [nodePackage.count]);
      nodeTrigger.Text := Format('Triggers (%d)', [nodeTrigger.count]);
      nodeSequence.Text := Format('Sequences (%d)', [nodeSequence.count]);

      nodeTable.Expanded := true;
      nodeView.Expanded := Filter <> '';
      nodeStoredProc.Expanded := Filter <> '';
    finally
      MetaTree.Items.EndUpdate;
    end;
  end;

begin
  editor.Metadata := zFBExpertEngine.Metadata;

  FillTreeView;
end;

procedure TzFBExpertFrame.editorChange(Sender: TObject);
begin;
  tabGrid.TabVisible := editor.IsSelect;
end;

procedure TzFBExpertFrame.editorPrepare(Sender: TObject);
begin
  zFBExpertEngine.Prepare(editor.SQL);
end;

procedure TzFBExpertFrame.editorExecute(Sender: TObject);
begin
  ClearView;

  editor.ClearLog;

  if editor.IsSelect then
  begin
    zFBExpertEngine.OpenQuery(editor.SQL);

    cxPageControl.ActivePageIndex := 1;

    InitView;
  end
  else
    zFBExpertEngine.ExecuteScript(editor.SQL);
end;

procedure TzFBExpertFrame.edSearchPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  edSearch.Clear;
end;

procedure TzFBExpertFrame.edSearchPropertiesEditValueChanged(Sender: TObject);
begin
  MetaTimer.Enabled := False;
  MetaTimer.Enabled := true;
end;

procedure TzFBExpertFrame.MetaTimerTimer(Sender: TObject);
begin
  MetaTimer.Enabled := False;
  AssegnaMetadata;
  try
    MetaTree.SetFocus;
  except
  end;
end;

procedure TzFBExpertFrame.MetaTreeKeyPress(Sender: TObject; var Key: Char);
begin

  if Key = #13 then
  begin
    AddSelectedMetadataObject;
    editor.editor.SetFocus;
  end;
end;

procedure TzFBExpertFrame.MetaTreeDblClick(Sender: TObject);
begin
  AddSelectedMetadataObject;
end;

procedure TzFBExpertFrame.MetaTreeDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  i: Integer;
  TreeNode: TTreeNode;
  // Node: TcxTreeListNode;
  TableName: string;
begin

  // // if (Source is TcxDragControlObject) and ((Source as TcxDragControlObject).Control = TreeView) then
  // if (Source is TcxTreeView) or ((Source is TDragControlObject) and (TDragControlObject(Source).Control = MetaTree)) then
  // begin
  // Node := tree.GetNodeAt(X, Y);
  //
  // if not Assigned(Node) then
  // // Exit;
  // Node := tree.Root;
  //
  // for I := 0 to MetaTree.SelectionCount - 1 do
  // begin
  // TreeNode := MetaTree.Selections[I];
  // if not((TreeNode = nil) or (TreeNode.Level <> 1)) then
  // CreateDataSet(Node, TreeNode.Text);
  // end;
  // end
  // else
  // if Source = tree then
  // begin
  // tree.OnDragDrop := nil;
  // tree.DragDrop(tree, X, Y);
  // tree.OnDragDrop := treeDragDrop;
  // CancelDrag;
  // Abort;
  // end;
end;

function TzFBExpertFrame.GetSelectedNode(out elementName: string; out MetadataElement: TMetadataElement): Boolean;
begin
  result := False;

  if MetaTree.Selected = nil then
    Exit;

  if MetaTree.Selected.Level = 0 then
    Exit;

  result := true;

  elementName := MetaTree.Selected.Text;
  MetadataElement := TMetadataElement(MetaTree.Selected.Data);
end;

procedure TzFBExpertFrame.AddSelectedMetadataObject;
var
  elementName: string;
  MetadataElement: TMetadataElement;
begin

  if not GetSelectedNode(elementName, MetadataElement) then
    Exit;

  if editor.editor.SelLength > 0 then
    editor.editor.SelText := elementName
  else
    editor.InsertTextAtCaret(elementName);
end;

procedure TzFBExpertFrame.AggiungiExecute(Sender: TObject);
begin
  CreateElement;
end;

procedure TzFBExpertFrame.CreateElement;
var
  elementName: string;
  MetadataElement: TMetadataElement;
  Script: string;
begin

  if not GetSelectedNode(elementName, MetadataElement) then
    Exit;

  Script := zFBExpertEngine.CreateElement(elementName, MetadataElement);

  if editor.editor.SelLength > 0 then
    editor.editor.SelText := Script
  else
    editor.InsertTextAtCaret(Script);
end;

procedure TzFBExpertFrame.ModificaExecute(Sender: TObject);
begin
  UpdateElement;
end;

procedure TzFBExpertFrame.UpdateElement;
var
  elementName: string;
  MetadataElement: TMetadataElement;
  Script: string;
begin

  if not GetSelectedNode(elementName, MetadataElement) then
    Exit;

  Script := zFBExpertEngine.UpdateElement(elementName, MetadataElement);

  if editor.editor.SelLength > 0 then
    editor.editor.SelText := Script
  else
    editor.InsertTextAtCaret(Script);
end;

procedure TzFBExpertFrame.EliminaExecute(Sender: TObject);
begin
  DropElement;
end;

procedure TzFBExpertFrame.DropElement;
var
  elementName: string;
  MetadataElement: TMetadataElement;
  Script: string;
begin

  if not GetSelectedNode(elementName, MetadataElement) then
    Exit;

  Script := zFBExpertEngine.DropElement(elementName, MetadataElement);

  if editor.editor.SelLength > 0 then
    editor.editor.SelText := Script
  else
    editor.InsertTextAtCaret(Script);
end;

procedure TzFBExpertFrame.editorDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  elementName: string;
  MetadataElement: TMetadataElement;
begin
  Accept := GetSelectedNode(elementName, MetadataElement);
end;

procedure TzFBExpertFrame.editorDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  elementName: string;
  MetadataElement: TMetadataElement;
  pt: TPoint;
begin
  if not GetSelectedNode(elementName, MetadataElement) then
    Exit;

  dropPoint := point(X, Y);
  pt := editor.editor.ClientToScreen(dropPoint);

  dropAlter.Visible := true;
  dropDrop.Visible := true;

  dropSelect.Visible := MetadataElement in [meTable, meView, meStoredProc];
  dropExecProc.Visible := MetadataElement = meStoredProc;

  dragDropPopup.Popup(pt.X, pt.Y);
end;

procedure TzFBExpertFrame.dropSelectExecute(Sender: TObject);
var
  elementName: string;
  MetadataElement: TMetadataElement;
  Script: string;
begin
  if not GetSelectedNode(elementName, MetadataElement) then
    Exit;

  Script := zFBExpertEngine.dropSelect(elementName, MetadataElement);

  if editor.editor.SelLength > 0 then
    editor.editor.SelText := Script
  else
    editor.InsertTextAtPos(dropPoint.X, dropPoint.Y, Script);
end;

procedure TzFBExpertFrame.dropExecProcExecute(Sender: TObject);
var
  elementName: string;
  MetadataElement: TMetadataElement;
  Script: string;
begin
  if not GetSelectedNode(elementName, MetadataElement) then
    Exit;

  Script := zFBExpertEngine.dropExecProc(elementName, MetadataElement);

  if editor.editor.SelLength > 0 then
    editor.editor.SelText := Script
  else
    editor.InsertTextAtPos(dropPoint.X, dropPoint.Y, Script);
end;

procedure TzFBExpertFrame.dropAlterExecute(Sender: TObject);
var
  elementName: string;
  MetadataElement: TMetadataElement;
  Script: string;
begin
  if not GetSelectedNode(elementName, MetadataElement) then
    Exit;

  Script := zFBExpertEngine.UpdateElement(elementName, MetadataElement);

  if editor.editor.SelLength > 0 then
    editor.editor.SelText := Script
  else
    editor.InsertTextAtPos(dropPoint.X, dropPoint.Y, Script);
end;

procedure TzFBExpertFrame.dropDropExecute(Sender: TObject);
var
  elementName: string;
  MetadataElement: TMetadataElement;
  Script: string;
begin
  if not GetSelectedNode(elementName, MetadataElement) then
    Exit;

  Script := zFBExpertEngine.DropElement(elementName, MetadataElement);

  if editor.editor.SelLength > 0 then
    editor.editor.SelText := Script
  else
    editor.InsertTextAtPos(dropPoint.X, dropPoint.Y, Script);
end;

procedure TzFBExpertFrame.acQueryBuilderValidatePopupMenu(Sender: TacQueryBuilder; AControlOwner: TacQueryBuilderControlOwner; AForControl: TControl; APopupMenu: TPopupMenu);
var
  newds: TacDatasource; // TacDataSourceObject;
  tbl: TacMetadataTable;
  s: string;
  i: Integer;
  J: Integer;
  FKMenu, Menu: TMenuItem;
  MetaDataTbl: TacMetadataTable;
begin
  // if not(AControlOwner is TacDatasource) then
  // begin
  // FKMenu := TMenuItem.Create(Self);
  // FKMenu.caption := 'Where...';
  // FKMenu.OnClick := WhereMenuClick;
  // APopupMenu.Items.Add(FKMenu);
  // Exit;
  // end;

  MasterQry := AControlOwner as TacDatasource;

  if MasterQry.DatasourceType <> dtTable then
    Exit;

  tbl := MasterQry.MetadataObject as TacMetadataTable;

  if tbl.Relations.count = 0 then
    Exit;

  FKMenu := TMenuItem.Create(self);
  FKMenu.caption := 'Relations';
  APopupMenu.Items.add(FKMenu);

  for i := 0 to tbl.Relations.count - 1 do
  begin
    Menu := TMenuItem.Create(self);
    Menu.caption := tbl.Relations[i].ChildNameStr;
    Menu.OnClick := RelationsMenuClick;
    FKMenu.add(Menu);
  end;

  for i := 0 to acQueryBuilder.MetadataContainer.count - 1 do
    if acQueryBuilder.MetadataContainer.Items[i] is TacMetadataTable then
    begin
      MetaDataTbl := acQueryBuilder.MetadataContainer.Items[i] as TacMetadataTable;

      for J := 0 to MetaDataTbl.Relations.count - 1 do
        if sametext(tbl.NameStr, MetaDataTbl.Relations[J].ChildNameStr) then
        begin
          Menu := TMenuItem.Create(self);
          Menu.caption := MetaDataTbl.NameStr;
          Menu.OnClick := RelationsMenuClick;
          FKMenu.add(Menu);
        end;
    end;
end;

procedure TzFBExpertFrame.CheckQueryBuilderMetadata;
begin

  if acQueryBuilder.MetadataContainer.count = 0 then
    FillQueryBuilderMetadata;
end;

procedure TzFBExpertFrame.FillQueryBuilderMetadata;
  procedure AddTables;
  var
    t: TacMetadataTable;
    r: TacMetadataRelation;
    f: TacMetadataField;
    zTable: TzmdTable;
    fk: TzmdForeignKey;
    zField: TzmdField;
    FieldName: TzmdFieldName;
    i: Integer;
    J: Integer;
    jj: Integer;
  begin
    for i := 0 to zFBExpertEngine.Metadata.Tables.count - 1 do
    begin
      zTable := zFBExpertEngine.Metadata.Tables[i];
      t := acQueryBuilder.MetadataContainer.AddTable(zTable.name);

      for J := 0 to zTable.Fields.count - 1 do
      begin
        zField := zTable.Fields[J];

        f := t.Fields.add;
        f.NameStr := zField.name;
        f.FieldType := zField.DataType;
        f.Size := zField.Size;
        f.Nullable := not zField.NotNull;
        f.PrimaryKey := zTable.PrimaryKey.IndexOf(zField.name) <> -1;
      end;

      for J := 0 to zTable.ForeignKeys.count - 1 do
      begin
        fk := zTable.ForeignKeys[J];

        r := t.Relations.add;
        r.ChildNameStr := fk.FkTable;

        for jj := 0 to fk.Fields.count - 1 do
        begin
          FieldName := fk.Fields[jj];
          r.KeyFields.add(FieldName.name);
        end;

        for jj := 0 to fk.FkFields.count - 1 do
        begin
          FieldName := fk.FkFields[jj];
          r.ChildFields.add(FieldName.name);
        end;
      end;
    end;
  end;
  procedure AddViews;
  var
    t: TacMetadataView;
    f: TacMetadataField;
    zView: TzmdView;
    zField: TzmdField;
    i: Integer;
    ii: Integer;
  begin

    for i := 0 to zFBExpertEngine.Metadata.Views.count - 1 do
    begin
      zView := zFBExpertEngine.Metadata.Views[i];
      t := acQueryBuilder.MetadataContainer.AddView(zView.name);

      for ii := 0 to zView.Fields.count - 1 do
      begin
        zField := zView.Fields[ii];

        f := t.Fields.add;
        f.NameStr := zField.name;
        f.FieldType := zField.DataType;
        f.Size := zField.Size;
        f.Nullable := not zField.NotNull;
      end;
    end;
  end;

  procedure AddProcedures;
  var
    proc: TacMetadataProcedure;
    zProcedure: TzmdProcedure;
    zParam: TzmdParam;
    Param: TacMetadataParameter;
    f: TacMetadataField;
    i: Integer;
    ii: Integer;
  begin

    for i := 0 to zFBExpertEngine.Metadata.Procedures.count - 1 do
    begin
      zProcedure := zFBExpertEngine.Metadata.Procedures[i];

      if zProcedure.ParamsOutput.count > 0 then
      begin
        proc := acQueryBuilder.MetadataContainer.AddProcedure(zProcedure.name);
        proc.AltName := zProcedure.name;

        for ii := 0 to zProcedure.ParamsInput.count - 1 do
        begin
          zParam := zProcedure.ParamsInput[ii];
          Param := proc.Parameters.add;
          // param.NameStr := zParam.Name;
          Param.FieldType := zParam.DataType;
          Param.Size := zParam.Size;
          Param.ParamType := ptInput;
        end;

        for ii := 0 to zProcedure.ParamsOutput.count - 1 do
        begin
          zParam := zProcedure.ParamsOutput[ii];
          Param := proc.Parameters.add;
          // param.NameStr := zParam.Name;
          Param.FieldType := zParam.DataType;
          Param.Size := zParam.Size;
          Param.ParamType := ptOutput;
          //
          f := proc.Fields.add;
          f.NameStr := zParam.name;
          f.FieldType := zParam.DataType;
          f.Size := zParam.Size;
        end;

      end;
    end;
  end;

begin

  acQueryBuilder.TreeOptionsMetadata.ImageList := queryBuilder16Images;
  acQueryBuilder.AddObjectFormOptions.ImageListSmall := queryBuilder16Images;
  acQueryBuilder.AddObjectFormOptions.ImageListLarge := queryBuilder32Images;
  acQueryBuilder.AddObjectFormOptions.ListViewStyle := vsIcon;

  acQueryBuilder.WorkOffLine := true;
  acQueryBuilder.MetadataProvider := nil;

  acQueryBuilder.MetadataContainer.BeginUpdate;
  try
    acQueryBuilder.MetadataContainer.Clear;
    /// ////////

    AddTables;
    AddViews;
    AddProcedures;

  finally
    acQueryBuilder.MetadataContainer.EndUpdate;
  end;
end;

procedure TzFBExpertFrame.tabQueryBuilderEnter(Sender: TObject);
begin
  CheckQueryBuilderMetadata;
  /// ///////////
  try
    acQueryBuilder.SQL := editor.SQL;
  except
    on e: exception do
      ConfirmOk(e.message);
  end;
end;

procedure TzFBExpertFrame.tabQueryBuilderHide(Sender: TObject);
begin
  try
    editor.SQL := acSQLBuilderPlainText.SQL;
  except
    on e: exception do
      ApplicationShowException(e);
  end;
end;

procedure TzFBExpertFrame.tabQueryBuilderShow(Sender: TObject);
begin
  CheckQueryBuilderMetadata;
end;

procedure TzFBExpertFrame.RelationsMenuClick(Sender: TObject);
var
  DetailTblName: string;
  DetailQry: TacDatasource;
  pt: TPoint;
begin
  DetailTblName := (Sender as TMenuItem).caption;
  pt := point(MasterQry.Left + MasterQry.Width + 50, MasterQry.Top);
  DetailQry := acQueryBuilder.Query.ActiveUnionSubquery.AddObjectWithFKAt(DetailTblName, pt, '');
end;

procedure TzFBExpertFrame.editorFormatSQL(Sender: TObject);
begin
  CheckQueryBuilderMetadata;

  if acQueryBuilder.SQL <> editor.SQL then
    acQueryBuilder.SQL := editor.SQL;

  editor.SQL := acSQLBuilderPlainText.SQL;
end;

procedure TzFBExpertFrame.Init(azSystem: TzSystem; aConnection: TFDConnection; aReadTrans, aWriteTrans: TFDTransaction; aDataSet: TzFbDataSet; aMetadata: TzMetadata);
begin
  zSystem := azSystem;
  zFBExpertEngine.Init(aConnection, aReadTrans, aWriteTrans, aDataSet, aMetadata);
  AssegnaMetadata;
end;

procedure TzFBExpertFrame.AggiornaExecute(Sender: TObject);
begin

  StartWait('Attendere...', true);
  try
    zFBExpertEngine.LoadMetadata(true);
    AssegnaMetadata;
  finally
    StopWait;
  end;
end;

procedure TzFBExpertFrame.ClearView;
begin
  view.zDataSet := nil;
  view.GetDbViewProps.Columns.Clear;
  view.zDbCardDlg.DestroyControls;
end;

procedure TzFBExpertFrame.InitView;
begin
  view.zSystem := zSystem;
  view.zDataSet := zFBExpertEngine.DataSet;
end;

procedure TzFBExpertFrame.viewCustomLoadProps(Sender: TObject);
var
  column: TzColumn;
  props: TzDbViewProps;
begin;
  props := view.GetDbViewProps;
  props.Title := 'Risultato';
  props.ButtonInsert.Visible := zFBExpertEngine.DataSet.CanInsert;
  props.ButtonEdit.Visible := zFBExpertEngine.DataSet.CanUpdate;
  props.ButtonDelete.Visible := zFBExpertEngine.DataSet.CanDelete;
  props.ButtonDuplica.Visible := props.ButtonInsert.Visible;

  for column in props.Columns do
  begin
    column.Visible := true;

    if column.caption.IsEmpty then
      column.caption := CapFirst(column.name);
  end;
end;

procedure TzFBExpertFrame.viewCustomSaveProps(Sender: TObject);
begin; // non deve salvare nulla
end;

procedure TzFBExpertFrame.viewCardBeforeCreateControls(Sender: TObject);
var
  card: TzDbCard;
  ctrl: TzControl;
begin
  card := TzDbCard(Sender);

  for ctrl in card.zControls do
    if ctrl.DisplayLabel.IsEmpty then
      ctrl.DisplayLabel := CapFirst(ctrl.name);
end;

end.
