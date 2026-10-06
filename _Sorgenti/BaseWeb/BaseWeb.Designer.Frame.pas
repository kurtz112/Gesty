unit BaseWeb.Designer.Frame;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.Actions,
  System.ImageList,
  Data.DB,
  Vcl.ImgList,
  Vcl.ActnList,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  cxControls,
  cxStyles,
  cxCustomData,
  dxBar,
  cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxFilter,
  dxScrollbarAnnotations,
  cxTL,
  cxTextEdit,
  cxTLdxBarBuiltInMenu,
  cxEdit,
  cxVGrid,
  cxOI,
  cxInplaceContainer,
  cxImageList,
  cxGeometry,
  dxFramedControl,
  dxPanel,
  dxBarBuiltInMenu,
  cxPC,
  cxClasses,
  cxDBData,
  cxGridLevel,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridBandedTableView,
  cxGridDBTableView,
  cxGrid,
  cxGridCustomPopupMenu,
  cxGridPopupMenu,
  cxData,
  cxDataStorage,
  cxNavigator,
  dxDateRanges,
  dxLayoutControl,
  dxLayoutContainer,
  dxLayoutLookAndFeels,
  BaseWeb.Models,
  BaseWeb.Types,
  BaseWeb.FormPreviewBuilder;

const
  WM_SelectFieldNode = WM_USER + 1317;

type
  TBaseWebDesignerFrame = class(TFrame)
    PanelMain: TPanel;
    SplitterLeft: TSplitter;
    PanelTree: TPanel;
    PanelInspector: TPanel;
    TreeList: TcxTreeList;
    TreeListColName: TcxTreeListColumn;
    TreeListColInfo: TcxTreeListColumn;
    ImageList: TcxImageList;
    Inspector: TcxRTTIInspector;
    pnlDesigner: TdxPanel;
    SplitterRight: TSplitter;
    cxPageControl: TcxPageControl;
    abForm: TcxTabSheet;
    tabDataGrid: TcxTabSheet;
    ActionList: TActionList;
    dxBarManager: TdxBarManager;
    popTree: TdxBarPopupMenu;
    dxBarButton1: TdxBarButton;
    popForm: TdxBarPopupMenu;
    pnlForm: TdxPanel;
    dxBarButton2: TdxBarButton;
    cxGridLevel: TcxGridLevel;
    cxGrid: TcxGrid;
    popGrid: TdxBarPopupMenu;
    dxBarButton3: TdxBarButton;
    cxGridBandedTableView: TcxGridBandedTableView;
    dxBarDockControl: TdxBarDockControl;
    dxBarManagerBar: TdxBar;

    // Azioni popTree — Fields
    actTreeFieldGoTo: TAction;
    // Azioni popTree — Form (Field)
    actTreeFormGoTo: TAction;
    actTreeFormMoveItem: TAction;
    actTreeFormToggleRequired: TAction;
    actTreeFormToggleReadOnly: TAction;
    actTreeFormChangeEditorType: TAction;
    // Azioni popTree — Grid (Column)
    actTreeGridAddToBand: TAction;
    actTreeGridMoveColumn: TAction;
    actTreeGridToggleVisible: TAction;
    actTreeGridToggleFixed: TAction;
    // Azioni popTree — Dataset
    actTreeDatasetRefresh: TAction;
    actTreeFormAddTabbed: TAction;
    actTreeFormAddTab: TAction;
    actTreeFormAddGroup: TAction;
    actTreeFormRenameContainer: TAction;
    actTreeFormDeleteContainer: TAction;
    // Azioni popForm
    actFormHighlightField: TAction;
    actFormMoveItem: TAction;
    actFormToggleRequired: TAction;
    actFormToggleReadOnly: TAction;
    actFormChangeEditorType: TAction;
    actFormCustomize: TAction;
    actFormAddTabbed: TAction;
    actFormAddTab: TAction;
    actFormAddGroup: TAction;
    actFormRenameContainer: TAction;
    actFormDeleteContainer: TAction;
    // Azioni popGrid
    actGridAddToBand: TAction;
    actGridMoveColumn: TAction;
    actGridToggleVisible: TAction;
    actGridToggleFixed: TAction;
    actGridCustomize: TAction;
    // Pulsanti dxBar per popTree
    btnTreeFieldGoTo: TdxBarButton;
    btnTreeFormGoTo: TdxBarButton;
    btnTreeFormMoveItem: TdxBarButton;
    btnTreeFormToggleRequired: TdxBarButton;
    btnTreeFormToggleReadOnly: TdxBarButton;
    btnTreeFormChangeEditorType: TdxBarButton;
    btnTreeGridAddToBand: TdxBarButton;
    btnTreeGridMoveColumn: TdxBarButton;
    btnTreeGridToggleVisible: TdxBarButton;
    btnTreeGridToggleFixed: TdxBarButton;
    btnTreeDatasetRefresh: TdxBarButton;
    btnTreeFormAddTabbed: TdxBarButton;
    btnTreeFormAddTab: TdxBarButton;
    btnTreeFormAddGroup: TdxBarButton;
    btnTreeFormRenameContainer: TdxBarButton;
    btnTreeFormDeleteContainer: TdxBarButton;
    // Pulsanti dxBar per popForm
    btnFormHighlightField: TdxBarButton;
    btnFormMoveItem: TdxBarButton;
    btnFormToggleRequired: TdxBarButton;
    btnFormToggleReadOnly: TdxBarButton;
    btnFormChangeEditorType: TdxBarButton;
    btnFormCustomize: TdxBarButton;
    btnFormAddTabbed: TdxBarButton;
    btnFormAddTab: TdxBarButton;
    btnFormAddGroup: TdxBarButton;
    btnFormRenameContainer: TdxBarButton;
    btnFormDeleteContainer: TdxBarButton;
    // Pulsanti dxBar per popGrid
    btnGridAddToBand: TdxBarButton;
    btnGridMoveColumn: TdxBarButton;
    btnGridToggleVisible: TdxBarButton;
    btnGridToggleFixed: TdxBarButton;
    btnGridCustomize: TdxBarButton;
    cxGridPopupMenu: TcxGridPopupMenu;
    LayoutControlFormGroup_Root: TdxLayoutGroup;
    LayoutControlForm: TdxLayoutControl;
    dxLayoutLookAndFeelList: TdxLayoutLookAndFeelList;
    dxLayoutSkinLookAndFeelBold: TdxLayoutSkinLookAndFeel;
    procedure TreeListSelectionChanged(Sender: TObject);
    procedure TreeListDblClick(Sender: TObject);
    procedure TreeListGetNodeImageIndex(Sender: TcxCustomTreeList; ANode: TcxTreeListNode; AIndexType: TcxTreeListImageIndexType; var AIndex: TcxImageIndex);
    procedure TreeListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeListDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    // Eventi grid banded
    procedure GridColumnPosChanged(Sender: TcxGridTableView; AColumn: TcxGridColumn);
    procedure GridColumnSizeChanged(Sender: TcxGridTableView; AColumn: TcxGridColumn);
    procedure GridBandPosChanged(Sender: TcxGridBandedTableView; ABand: TcxGridBand);
    // Azioni

    // Handler azioni Form
    procedure actFormHighlightFieldExecute(Sender: TObject);
    procedure actFormHighlightFieldUpdate(Sender: TObject);
    procedure actFormMoveItemExecute(Sender: TObject);
    procedure actFormMoveItemUpdate(Sender: TObject);
    procedure actFormToggleRequiredExecute(Sender: TObject);
    procedure actFormToggleRequiredUpdate(Sender: TObject);
    procedure actFormToggleReadOnlyExecute(Sender: TObject);
    procedure actFormToggleReadOnlyUpdate(Sender: TObject);
    procedure actFormChangeEditorTypeExecute(Sender: TObject);
    procedure actFormChangeEditorTypeUpdate(Sender: TObject);
    procedure actFormCustomizeExecute(Sender: TObject);
    // Handler azioni Grid
    procedure actGridAddToBandExecute(Sender: TObject);
    procedure actGridMoveColumnExecute(Sender: TObject);
    procedure actGridToggleVisibleExecute(Sender: TObject);
    procedure actGridToggleFixedExecute(Sender: TObject);
    procedure actGridCustomizeExecute(Sender: TObject);
    procedure actGridAddToBandUpdate(Sender: TObject);
    procedure actGridMoveColumnUpdate(Sender: TObject);
    procedure actGridToggleVisibleUpdate(Sender: TObject);
    procedure actGridToggleFixedUpdate(Sender: TObject);
    procedure popTreePopup(Sender: TObject);
    // Handler azioni Tree
    procedure actTreeFieldGoToExecute(Sender: TObject);
    procedure actTreeFieldGoToUpdate(Sender: TObject);
    procedure actTreeFormGoToExecute(Sender: TObject);
    procedure actTreeFormGoToUpdate(Sender: TObject);
    procedure actTreeFormMoveItemExecute(Sender: TObject);
    procedure actTreeFormMoveItemUpdate(Sender: TObject);
    procedure actTreeFormToggleRequiredExecute(Sender: TObject);
    procedure actTreeFormToggleRequiredUpdate(Sender: TObject);
    procedure actTreeFormToggleReadOnlyExecute(Sender: TObject);
    procedure actTreeFormToggleReadOnlyUpdate(Sender: TObject);
    procedure actTreeFormChangeEditorTypeExecute(Sender: TObject);
    procedure actTreeFormChangeEditorTypeUpdate(Sender: TObject);
    procedure actTreeGridAddToBandExecute(Sender: TObject);
    procedure actTreeGridAddToBandUpdate(Sender: TObject);
    procedure actTreeGridMoveColumnExecute(Sender: TObject);
    procedure actTreeGridMoveColumnUpdate(Sender: TObject);
    procedure actTreeGridToggleVisibleExecute(Sender: TObject);
    procedure actTreeGridToggleVisibleUpdate(Sender: TObject);
    procedure actTreeGridToggleFixedExecute(Sender: TObject);
    procedure actTreeGridToggleFixedUpdate(Sender: TObject);
    procedure actTreeDatasetRefreshExecute(Sender: TObject);
    procedure actTreeDatasetRefreshUpdate(Sender: TObject);
    { ---- Handler azioni Form struttura ---- }
    procedure actFormAddTabbedExecute(Sender: TObject);
    procedure actFormAddTabbedUpdate(Sender: TObject);
    procedure actFormAddTabExecute(Sender: TObject);
    procedure actFormAddTabUpdate(Sender: TObject);
    procedure actFormAddGroupExecute(Sender: TObject);
    procedure actFormAddGroupUpdate(Sender: TObject);
    procedure actFormRenameContainerExecute(Sender: TObject);
    procedure actFormRenameContainerUpdate(Sender: TObject);
    procedure actFormDeleteContainerExecute(Sender: TObject);
    procedure actFormDeleteContainerUpdate(Sender: TObject);
    procedure actTreeFormAddGroupExecute(Sender: TObject);

    { ---- Handler azioni Tree struttura Form ---- }
    procedure actTreeFormAddTabbedUpdate(Sender: TObject);
    procedure actTreeFormAddTabUpdate(Sender: TObject);
    procedure actTreeFormAddGroupUpdate(Sender: TObject);
    procedure actTreeFormRenameContainerUpdate(Sender: TObject);
    procedure actTreeFormDeleteContainerUpdate(Sender: TObject);
    procedure InspectorEdited(Sender: TObject; ARowProperties: TcxCustomEditorRowProperties);
    procedure LayoutControlFormCustomization(Sender: TObject);
    procedure LayoutControlFormContainerChanged(Sender: TObject);

    procedure LayoutControlFormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    FFocusedFieldForSelection: string;
    procedure WMSelectFieldNode(var Msg: TMessage); message WM_SelectFieldNode;
  private
    function CanDropOn(DragKind, TargetKind: TBaseWebNodeKind): Boolean;
    procedure ApplyDrop(DroppedNode, TargetNode: TcxTreeListNode);
    procedure RenumberSortOrder(ParentNode: TcxTreeListNode);
  private
    FFocusedFormField: string;
    FFormPreviewBuilder: TFormPreviewBuilder;
    procedure SyncFormFromModel;
    procedure FormFieldSelected(Sender: TObject; const AFieldName: string);
    procedure FormFieldContext(Sender: TObject; const AFieldName: string; X, Y: Integer);
    procedure FormContainerSelected(Sender: TObject; AContainerKind: TBaseWebNodeKind; AContainerObj: TComponent);
  private
    FSyncTimer: TTimer;
    procedure SyncTimerFired(Sender: TObject);
  private
    FNodeDataList: TObjectList<TBaseWebNodeData>;
    FSelectedObject: TComponent;
    // Struttura correntemente caricata (serve per sync grid↔modello)
    FStruct: TBaseWebDatasetStructure;
    FStructLoaded: Boolean;
    // True mentre SyncGridFromModel è in esecuzione: sopprime gli eventi
    // GridColumnPosChanged / GridBandPosChanged che aggiornano il modello
    FGridSyncing: Boolean;
    // Target validato in DragOver, consumato in DragDrop
    FDragTarget: TcxTreeListNode;
    FFormSyncing: Boolean; // True durante reverse-sync Layout→Modello
    FHighlighting: Boolean;

    procedure SyncModelFromLayout;
    function ResolveGroupName(ALayoutGroup: TdxLayoutGroup): string;
    procedure VisitGroupForSync(ALayoutGroup: TdxLayoutGroup; const AOwnerGroupName: string; var ASortOrderInGroup: Integer);

    procedure SetupTreeList;
    procedure SetupForm;
    procedure SetupGrid;
    procedure ClearTree;
    procedure FillGridWithDummyData;

    // Sincronizzazione bidirezionale Grid ↔ Modello
    procedure SyncGridFromModel;
    function FindModelColumn(const AField: string): TBaseWebGridColumn;
    function FindModelBand(const ABandName: string): TBaseWebGridBand;
    // Restituisce la colonna di modello associata alla colonna grid selezionata (nil se nessuna)
    function FocusedModelColumn: TBaseWebGridColumn;
    function FocusedModelBand: TBaseWebGridBand;

    // True  = riordino fratelli  → MoveTo(..., tlamInsert)
    // False = cambio contenitore → MoveTo(..., tlamAdd)
    function IsReorderDrop(DragKind, TargetKind: TBaseWebNodeKind): Boolean;

    function AddNode(ParentNode: TcxTreeListNode; Kind: TBaseWebNodeKind; const DisplayText, InfoText: string; ModelObj: TComponent): TcxTreeListNode;

    procedure BuildDatasetNode(const Struct: TBaseWebDatasetStructure);
    procedure BuildFormSubtree(FormNode: TcxTreeListNode; const Struct: TBaseWebDatasetStructure);
    procedure BuildGroupContent(GroupNode: TcxTreeListNode; const GroupName: string; const Struct: TBaseWebDatasetStructure);
    procedure BuildGridSubtree(GridNode: TcxTreeListNode; const Struct: TBaseWebDatasetStructure);

    function CreateTabbed(const TabbedName, TabsPos: string): TBaseWebFormTabbed;
    function CreateGroup(const GroupName, Caption: string; SortOrder: Integer): TBaseWebFormGroup;

    procedure SelectObject(Obj: TComponent);
    function NodeDataOf(Node: TcxTreeListNode): TBaseWebNodeData;
    function IconIndexForKind(Kind: TBaseWebNodeKind): Integer;
    procedure SelectTreeNodeByGroupName(const GroupName: string);

    procedure ClearFormHighlight;
    procedure HighlightFormField(const AFieldName: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadDataset(const Struct: TBaseWebDatasetStructure);
    procedure SaveDataset(out Struct: TBaseWebDatasetStructure);
    procedure Clear;

    property FocusedFormField: string read FFocusedFormField;
    property SelectedObject: TComponent read FSelectedObject;
  end;

implementation

uses
  System.StrUtils,
  System.Generics.Defaults,
  cxGridStdPopupMenu,
  Vcl.Menus,
  zDX;

{$R *.dfm}

const
  SECTION_FIELDS = '[Fields]';
  SECTION_FORM = '[Form]';
  SECTION_GRID = '[Grid]';

const
  ICON_DATASET = 0;
  ICON_CUSTOM = 1;
  ICON_SECTION = 2;
  ICON_FIELD = 3;
  ICON_TABBED = 4;
  ICON_TAB = 5;
  ICON_GROUP = 6;
  ICON_FORMFIELD = 7;
  ICON_BUTTON = 8;
  ICON_EMPTY = 9;
  ICON_BAND = 10;
  ICON_GRIDCOL = 11;
  ICON_LOOKUP = 12;
  ICON_PICKLIST = 13;

  { --------------------------------------------------------------------------- }
  { Frame lifecycle }
  { --------------------------------------------------------------------------- }

constructor TBaseWebDesignerFrame.Create(AOwner: TComponent);
begin
  inherited;
  FNodeDataList := TObjectList<TBaseWebNodeData>.Create(True);
  FSelectedObject := nil;
  FStructLoaded := False;
  FGridSyncing := False;
  FDragTarget := nil;
  cxPageControl.ActivePageIndex := 0;

  dx.InitTreeList(TreeList);
  dx.InitLayoutControl(LayoutControlForm);
  dx.InitBar(dxBarManagerBar);

  SetupTreeList;
  SetupForm;
  SetupGrid;
end;

destructor TBaseWebDesignerFrame.Destroy;
begin
  if Assigned(FSyncTimer) then
    FSyncTimer.Enabled := False;

  FNodeDataList.Free;
  inherited;
end;

procedure TBaseWebDesignerFrame.SetupTreeList;
begin
  TreeList.Images := ImageList;

  TreeList.OptionsBehavior.ExpandOnDblClick := False;
  TreeList.OptionsBehavior.FocusCellOnCycle := False;
  TreeList.OptionsBehavior.GoToNextCellOnEnter := False;

  TreeList.OptionsView.ShowRoot := False;
  TreeList.OptionsView.Headers := True;
  TreeList.OptionsView.GridLines := tlglNone;
  TreeList.OptionsView.TreeLineStyle := tllsDot;
  TreeList.OptionsView.ColumnAutoWidth := False;

  TreeList.OptionsSelection.HideSelection := False;
  TreeList.OptionsSelection.CellSelect := False;
  TreeList.OptionsSelection.MultiSelect := False;
  TreeList.OptionsSelection.InvertSelect := False;

  TreeListColName.Caption.Text := 'Struttura';
  TreeListColName.Width := 240;
  TreeListColName.MinWidth := 120;
  TreeListColName.Options.Sizing := True;
  TreeListColName.Options.Moving := False;
  TreeListColName.Options.Focusing := False;
  TreeListColName.DataBinding.ValueType := 'String';
  TreeListColName.PropertiesClassName := 'TcxTextEditProperties';

  TreeListColInfo.Caption.Text := 'Info';
  TreeListColInfo.Width := 140;
  TreeListColInfo.MinWidth := 60;
  TreeListColInfo.Options.Sizing := True;
  TreeListColInfo.Options.Moving := False;
  TreeListColInfo.Options.Focusing := False;
  TreeListColInfo.DataBinding.ValueType := 'String';
  TreeListColInfo.PropertiesClassName := 'TcxTextEditProperties';
end;

{ --------------------------------------------------------------------------- }
{ Utility }
{ --------------------------------------------------------------------------- }

function TBaseWebDesignerFrame.NodeDataOf(Node: TcxTreeListNode): TBaseWebNodeData;
begin
  if Assigned(Node) and Assigned(Node.Data) then
    Result := TBaseWebNodeData(Node.Data)
  else
    Result := nil;
end;

function TBaseWebDesignerFrame.IconIndexForKind(Kind: TBaseWebNodeKind): Integer;
begin
  case Kind of
    nkDataset:
      Result := ICON_DATASET;
    nkSectionFields, nkSectionForm, nkSectionGrid:
      Result := ICON_SECTION;
    nkField:
      Result := ICON_FIELD;
    nkFormTabbed:
      Result := ICON_TABBED;
    nkFormTab:
      Result := ICON_TAB;
    nkFormGroup:
      Result := ICON_GROUP;
    nkFormField:
      Result := ICON_FORMFIELD;
    nkFormButton:
      Result := ICON_BUTTON;
    nkFormEmpty:
      Result := ICON_EMPTY;
    nkGridBand:
      Result := ICON_BAND;
    nkGridColumn:
      Result := ICON_GRIDCOL;
    nkLookup, nkLookupColumn:
      Result := ICON_LOOKUP;
    nkPicklist, nkPicklistItem:
      Result := ICON_PICKLIST;
  else
    Result := -1;
  end;
end;

{ --------------------------------------------------------------------------- }
{ Gestione nodi }
{ --------------------------------------------------------------------------- }

procedure TBaseWebDesignerFrame.TreeListGetNodeImageIndex(Sender: TcxCustomTreeList; ANode: TcxTreeListNode; AIndexType: TcxTreeListImageIndexType; var AIndex: TcxImageIndex);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(ANode);

  if (AIndexType in [tlitImageIndex, tlitSelectedIndex]) and Assigned(NodeData) then
    AIndex := IconIndexForKind(NodeData.Kind)
  else
    AIndex := -1;
end;

function TBaseWebDesignerFrame.AddNode(ParentNode: TcxTreeListNode; Kind: TBaseWebNodeKind; const DisplayText, InfoText: string; ModelObj: TComponent): TcxTreeListNode;
var
  NodeData: TBaseWebNodeData;
begin
  if Assigned(ParentNode) then
    Result := ParentNode.AddChild
  else
    Result := TreeList.Root.AddChild;

  Result.Values[0] := DisplayText;
  Result.Values[1] := InfoText;

  NodeData := TBaseWebNodeData.Create;
  NodeData.Kind := Kind;
  NodeData.ModelObject := ModelObj;
  NodeData.DisplayText := DisplayText;
  Result.Data := NodeData;
  FNodeDataList.Add(NodeData);
end;

procedure TBaseWebDesignerFrame.ClearTree;
begin
  TreeList.BeginUpdate;
  try
    TreeList.Clear;
    FNodeDataList.Clear;
  finally
    TreeList.EndUpdate;
  end;
end;

procedure TBaseWebDesignerFrame.Clear;
begin
  ClearTree;
  SelectObject(nil);
end;

{ --------------------------------------------------------------------------- }
{ Costruzione albero }
{ --------------------------------------------------------------------------- }

procedure TBaseWebDesignerFrame.LoadDataset(const Struct: TBaseWebDatasetStructure);
begin
  FStruct := Struct;
  FStructLoaded := True;
  TreeList.BeginUpdate;
  try
    TreeList.Clear;
    BuildDatasetNode(Struct);
    LayoutControlForm.InvalidateWithChildren;
  finally
    TreeList.EndUpdate;
  end;

  SyncFormFromModel;
  SyncGridFromModel;
end;

{ --------------------------------------------------------------------------- }
{ Serializzazione — controparte di LoadDataset }
{ --------------------------------------------------------------------------- }

procedure TBaseWebDesignerFrame.SaveDataset(out Struct: TBaseWebDatasetStructure);
begin
  if not FStructLoaded then
    raise EInvalidOperation.Create('SaveDataset: nessun dataset caricato');

  // Assicura che il modello sia allineato con l'ultimo stato del layout form
  // e della grid prima di esportare. Le chiamate sono no-op se già sincronizzate
  // (i flag FFormSyncing / FGridSyncing proteggono da rientranza).
  SyncModelFromLayout;

  Struct.Dataset := FStruct.Dataset;
  Struct.Fields := FStruct.Fields;

  // Form
  Struct.FormTabbed := FStruct.FormTabbed;
  Struct.FormTabs := FStruct.FormTabs;
  Struct.FormGroups := FStruct.FormGroups;
  Struct.FormFields := FStruct.FormFields;
  Struct.FormButtons := FStruct.FormButtons;
  Struct.FormEmpty := FStruct.FormEmpty;

  // Grid — struttura base
  Struct.GridBands := FStruct.GridBands;
  Struct.GridColumns := FStruct.GridColumns;
end;

procedure TBaseWebDesignerFrame.BuildDatasetNode(const Struct: TBaseWebDatasetStructure);
var
  DatasetNode, FieldsNode, FormNode, GridNode: TcxTreeListNode;
  F: TBaseWebDatasetField;
begin
  // --- nodo radice Dataset ---
  DatasetNode := AddNode(nil, nkDataset, Struct.Dataset.Dataset, Struct.Dataset.RelationName, Struct.Dataset);

  // --- sezione Fields ---
  FieldsNode := AddNode(DatasetNode, nkSectionFields, SECTION_FIELDS, Format('%d fields', [Struct.Fields.Count]), nil);

  for F in Struct.Fields do
  begin
    var
    FieldNode := AddNode(FieldsNode, nkField, F.Field, F.EditorType, F);
  end;

  // --- sezione Form ---
  FormNode := AddNode(DatasetNode, nkSectionForm, SECTION_FORM, Struct.Dataset.FormLayout, nil);
  BuildFormSubtree(FormNode, Struct);

  // --- sezione Grid ---
  GridNode := AddNode(DatasetNode, nkSectionGrid, SECTION_GRID, Format('page %d', [Struct.Dataset.GridPageSize]), nil);
  BuildGridSubtree(GridNode, Struct);

  // Espande Dataset e le sezioni principali così la struttura è subito visibile
  DatasetNode.Expand(False);
  FormNode.Expand(False);
  GridNode.Expand(False);
end;

procedure TBaseWebDesignerFrame.BuildFormSubtree(FormNode: TcxTreeListNode; const Struct: TBaseWebDatasetStructure);
var
  TabbedNode: TcxTreeListNode;
  TabNode: TcxTreeListNode;
  GroupNode: TcxTreeListNode;
  Tabbed: TBaseWebFormTabbed;
  Tab: TBaseWebFormTab;
  Group: TBaseWebFormGroup;
begin
  // FormNode è già stato creato da BuildDatasetNode.

  // --- Pannelli Tabbed ---
  for Tabbed in Struct.FormTabbed do
  begin
    TabbedNode := AddNode(FormNode, nkFormTabbed, Tabbed.TabbedName, Tabbed.TabsPosition, Tabbed);

    for Tab in Struct.FormTabs do
    begin
      if not SameText(Tab.TabbedName, Tabbed.TabbedName) then
        Continue;

      TabNode := AddNode(TabbedNode, nkFormTab, Tab.TabName, Tab.Caption, Tab);

      for Group in Struct.FormGroups do
      begin
        if not SameText(Group.ParentContainerName, Tab.TabName) then
          Continue;

        GroupNode := AddNode(TabNode, nkFormGroup, Group.GroupName, Group.Caption, Group);

        BuildGroupContent(GroupNode, Group.GroupName, Struct);
      end;
    end;
  end;

  // --- Tab orfane (senza Tabbed associato) ---
  for Tab in Struct.FormTabs do
  begin
    var
    HasTabbed := False;
    for Tabbed in Struct.FormTabbed do
      if SameText(Tab.ParentContainerName, Tabbed.TabbedName) then
      begin
        HasTabbed := True;
        Break;
      end;
    if HasTabbed then
      Continue;

    TabNode := AddNode(FormNode, nkFormTab, Tab.TabName, Tab.Caption, Tab);

    for Group in Struct.FormGroups do
    begin
      if not SameText(Group.ParentContainerName, Tab.TabName) then
        Continue;

      GroupNode := AddNode(TabNode, nkFormGroup, Group.GroupName, Group.Caption, Group);

      BuildGroupContent(GroupNode, Group.GroupName, Struct);
    end;
  end;

  // --- Groups senza contenitore ---
  for Group in Struct.FormGroups do
  begin
    if not Group.ParentContainerName.IsEmpty then
      Continue;

    GroupNode := AddNode(FormNode, nkFormGroup, Group.GroupName, Group.Caption, Group);

    BuildGroupContent(GroupNode, Group.GroupName, Struct);
  end;

  // --- FormFields orfani (senza gruppo) ---
  for var FF in Struct.FormFields do
    if FF.ContainerName.IsEmpty then
      AddNode(FormNode, nkFormField, FF.Field, Format('col %d', [FF.ColSpan]), FF);

  // --- FormButtons orfani (senza gruppo) ---
  for var FB in Struct.FormButtons do
    if FB.ContainerName.IsEmpty then
      AddNode(FormNode, nkFormButton, FB.ButtonName, FB.BtnAction, FB);

  // --- FormEmpty orfani (senza gruppo) ---
  for var FE in Struct.FormEmpty do
    if FE.ContainerName.IsEmpty then
      AddNode(FormNode, nkFormEmpty, FE.EmptyName, Format('span %d', [FE.ColSpan]), FE);
end;

procedure TBaseWebDesignerFrame.BuildGroupContent(GroupNode: TcxTreeListNode; const GroupName: string; const Struct: TBaseWebDatasetStructure);
begin
  // --- Sottogruppi (gruppo dentro gruppo) ---
  for var SubGroup in Struct.FormGroups do
    if SameText(SubGroup.ParentContainerName, GroupName) then
    begin
      var
      SubGroupNode := AddNode(GroupNode, nkFormGroup, SubGroup.GroupName, SubGroup.Caption, SubGroup);
      BuildGroupContent(SubGroupNode, SubGroup.GroupName, Struct); // ricorsione
    end;

  // --- FormFields ---
  for var FF in Struct.FormFields do
    if SameText(FF.ContainerName, GroupName) then
    begin
      var
      FFNode := AddNode(GroupNode, nkFormField, FF.Field, Format('col %d', [FF.ColSpan]), FF);
    end;

  for var FB in Struct.FormButtons do
    if SameText(FB.ContainerName, GroupName) then
    begin
      var
      FBNode := AddNode(GroupNode, nkFormButton, FB.ButtonName, FB.BtnAction, FB);
    end;

  for var FE in Struct.FormEmpty do
    if SameText(FE.ContainerName, GroupName) then
    begin
      var
      FENode := AddNode(GroupNode, nkFormEmpty, FE.EmptyName, Format('span %d', [FE.ColSpan]), FE);
    end;
end;

procedure TBaseWebDesignerFrame.BuildGridSubtree(GridNode: TcxTreeListNode; const Struct: TBaseWebDatasetStructure);
var
  BandNode, SubBandNode: TcxTreeListNode;
  Band, SubBand: TBaseWebGridBand;
  Col: TBaseWebGridColumn;

  function ColWidth(C: TBaseWebGridColumn): string;
  begin
    if C.Width > 0 then
      Result := Format('%dpx', [C.Width])
    else
      Result := '';
  end;

  procedure AddColumn(ParentNode: TcxTreeListNode; C: TBaseWebGridColumn);
  var
    ColNode: TcxTreeListNode;
  begin
    ColNode := AddNode(ParentNode, nkGridColumn, C.Field, ColWidth(C), C);
  end;

begin
  // GridNode è già stato creato da BuildDatasetNode.

  for Band in Struct.GridBands do
  begin
    if not Band.ParentBand.IsEmpty then
      Continue;

    BandNode := AddNode(GridNode, nkGridBand, Band.BandName, Band.Caption, Band);

    for SubBand in Struct.GridBands do
    begin
      if SubBand.ParentBand.IsEmpty then
        Continue;

      if not SameText(SubBand.ParentBand, Band.BandName) then
        Continue;

      SubBandNode := AddNode(BandNode, nkGridBand, SubBand.BandName, SubBand.Caption, SubBand);

      for Col in Struct.GridColumns do
        if not Col.BandName.IsEmpty and SameText(Col.BandName, SubBand.BandName) then
          AddColumn(SubBandNode, Col);
    end;

    for Col in Struct.GridColumns do
      if not Col.BandName.IsEmpty and SameText(Col.BandName, Band.BandName) then
        AddColumn(BandNode, Col);
  end;

  for Col in Struct.GridColumns do
    if Col.BandName.IsEmpty or (Col.BandName = '') then
      AddColumn(GridNode, Col);
end;

{ --------------------------------------------------------------------------- }
{ Selezione e Inspector }
{ --------------------------------------------------------------------------- }

procedure TBaseWebDesignerFrame.SelectObject(Obj: TComponent);
begin
  FSelectedObject := Obj;
  if Assigned(Obj) then
    Inspector.InspectedObject := Obj
  else
    Inspector.InspectedObject := nil;
end;

{ ── Inspector: ogni modifica RTTI setta Modified sull'oggetto corrente ── }

procedure TBaseWebDesignerFrame.TreeListSelectionChanged(Sender: TObject);
var
  Node: TcxTreeListNode;
  NodeData: TBaseWebNodeData;
begin
  Node := TreeList.FocusedNode;
  NodeData := NodeDataOf(Node);

  if Assigned(NodeData) then
  begin
    if Assigned(NodeData.ModelObject) then
    begin
      SelectObject(NodeData.ModelObject);

      if NodeData.Kind in [nkFormField] then
      begin
        var
        FF := TBaseWebFormField(NodeData.ModelObject);
        FFocusedFormField := FF.Field;
        HighlightFormField(FF.Field);
      end
      else
      begin
        ClearFormHighlight;
      end;
    end
    else
      // Nodo strutturale senza oggetto (sezioni [Fields], [Form], [Grid]):
      // pulisce l'inspector
      SelectObject(nil);
  end;
  // NodeData = nil: FocusedNode momentaneamente nil durante refresh → ignora
end;

procedure TBaseWebDesignerFrame.TreeListDblClick(Sender: TObject);
var
  Node: TcxTreeListNode;
begin
  Node := TreeList.FocusedNode;
  if Assigned(Node) then
    Node.Expanded := not Node.Expanded;
end;

{ --------------------------------------------------------------------------- }
{ Drag & Drop }
{ --------------------------------------------------------------------------- }

procedure TBaseWebDesignerFrame.TreeListDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  DragNode, TargetNode: TcxTreeListNode;
begin
  Accept := False;
  FDragTarget := nil;

  if Source <> TreeList then
    Exit;
  if TreeList.SelectionCount = 0 then
    Exit;

  DragNode := TreeList.Selections[0];
  TargetNode := TreeList.HitTest.HitNode;

  if not Assigned(TargetNode) or not Assigned(DragNode) then
    Exit;
  if TargetNode = DragNode then
    Exit;
  if TargetNode.HasAsParent(DragNode) then
    Exit;

  Accept := CanDropOn(NodeDataOf(DragNode).Kind, NodeDataOf(TargetNode).Kind);
  if Accept then
    FDragTarget := TargetNode;
end;

function TBaseWebDesignerFrame.CanDropOn(DragKind, TargetKind: TBaseWebNodeKind): Boolean;
begin
  if DragKind in [nkDataset, nkSectionFields, nkSectionForm, nkSectionGrid, nkField] then
    Exit(False);

  Result := ((DragKind = nkFormTabbed) and (TargetKind in [nkSectionForm, nkFormTabbed])) or ((DragKind = nkFormTab) and (TargetKind in [nkFormTabbed, nkFormTab])) or
    ((DragKind = nkFormGroup) and (TargetKind in [nkSectionForm, nkFormTab, nkFormGroup])) or ((DragKind = nkFormField) and (TargetKind in [nkFormGroup, nkFormField, nkFormButton, nkFormEmpty])) or
    ((DragKind = nkFormButton) and (TargetKind in [nkFormGroup, nkFormField, nkFormButton, nkFormEmpty])) or ((DragKind = nkFormEmpty) and (TargetKind in [nkFormGroup, nkFormField, nkFormButton, nkFormEmpty])) or
    ((DragKind = nkGridBand) and (TargetKind in [nkSectionGrid, nkGridBand])) or ((DragKind = nkGridColumn) and (TargetKind in [nkGridBand, nkGridColumn]));
end;

function TBaseWebDesignerFrame.IsReorderDrop(DragKind, TargetKind: TBaseWebNodeKind): Boolean;
begin
  Result := (DragKind = TargetKind) or ((DragKind in [nkFormField, nkFormButton, nkFormEmpty]) and (TargetKind in [nkFormField, nkFormButton, nkFormEmpty])) or ((DragKind = nkGridColumn) and (TargetKind = nkGridColumn));
end;

procedure TBaseWebDesignerFrame.TreeListDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  DragNode, TargetNode: TcxTreeListNode;
  MoveMode: TcxTreeListNodeAttachMode;
begin
  if Source <> TreeList then
    Exit;
  if TreeList.SelectionCount = 0 then
    Exit;

  DragNode := TreeList.Selections[0];
  TargetNode := FDragTarget;
  FDragTarget := nil;

  if not Assigned(TargetNode) or not Assigned(DragNode) then
    Exit;
  if TargetNode = DragNode then
    Exit;

  if IsReorderDrop(NodeDataOf(DragNode).Kind, NodeDataOf(TargetNode).Kind) then
    MoveMode := tlamInsert
  else
    MoveMode := tlamAdd;

  TreeList.BeginUpdate;
  try
    DragNode.MoveTo(TargetNode, MoveMode);
    ApplyDrop(DragNode, TargetNode);
  finally
    TreeList.EndUpdate;
  end;
end;

procedure TBaseWebDesignerFrame.ApplyDrop(DroppedNode, TargetNode: TcxTreeListNode);
var
  DroppedData, NewParentData: TBaseWebNodeData;
  NeedsFormSync: Boolean;
begin
  DroppedData := NodeDataOf(DroppedNode);
  NewParentData := NodeDataOf(DroppedNode.Parent);
  NeedsFormSync := False;

  case DroppedData.Kind of

    nkFormTabbed:
      ;

    nkFormTab:
      begin
        var
        T := TBaseWebFormTab(DroppedData.ModelObject);
        if Assigned(NewParentData) and (NewParentData.Kind = nkFormTabbed) then
          T.TabbedName := TBaseWebFormTabbed(NewParentData.ModelObject).TabbedName
        else
          T.TabbedName := '';
        T.Modified := True;
        NeedsFormSync := True;
      end;

    nkFormGroup:
      begin
        var
        G := TBaseWebFormGroup(DroppedData.ModelObject);
        if Assigned(NewParentData) and (NewParentData.Kind = nkFormTab) then
        begin
          G.ParentContainerName := TBaseWebFormTab(NewParentData.ModelObject).TabName;
          G.ParentContainerType := 'tab';
        end
        else
        begin
          G.ParentContainerName := '';
          G.ParentContainerType := '';
        end;
        G.Modified := True;
        NeedsFormSync := True;
      end;

    nkFormField:
      begin
        var
        FF := TBaseWebFormField(DroppedData.ModelObject);
        if Assigned(NewParentData) and (NewParentData.Kind = nkFormGroup) then
        begin
          FF.ContainerName := TBaseWebFormGroup(NewParentData.ModelObject).GroupName;
          FF.ContainerType := 'group';
        end
        else
        begin
          FF.ContainerName := '';
          FF.ContainerType := '';
        end;
        FF.Modified := True;
        NeedsFormSync := True;
      end;

    nkFormButton:
      begin
        var
        FB := TBaseWebFormButton(DroppedData.ModelObject);
        if Assigned(NewParentData) and (NewParentData.Kind = nkFormGroup) then
        begin
          FB.ContainerName := TBaseWebFormGroup(NewParentData.ModelObject).GroupName;
          FB.ContainerType := 'group';
        end
        else
        begin
          FB.ContainerName := '';
          FB.ContainerType := '';
        end;
        FB.Modified := True;
        NeedsFormSync := True;
      end;

    nkFormEmpty:
      begin
        var
        FE := TBaseWebFormEmpty(DroppedData.ModelObject);
        if Assigned(NewParentData) and (NewParentData.Kind = nkFormGroup) then
        begin
          FE.ContainerName := TBaseWebFormGroup(NewParentData.ModelObject).GroupName;
          FE.ContainerType := 'group';
        end
        else
        begin
          FE.ContainerName := '';
          FE.ContainerType := '';
        end;
        FE.Modified := True;
        NeedsFormSync := True;
      end;

    nkGridBand:
      begin
        var
        B := TBaseWebGridBand(DroppedData.ModelObject);
        if Assigned(NewParentData) and (NewParentData.Kind = nkGridBand) then
          B.ParentBand := TBaseWebGridBand(NewParentData.ModelObject).BandName
        else
          B.ParentBand := '';
        B.Modified := True;
      end;

    nkGridColumn:
      begin
        var
        C := TBaseWebGridColumn(DroppedData.ModelObject);
        if Assigned(NewParentData) and (NewParentData.Kind = nkGridBand) then
          C.BandName := TBaseWebGridBand(NewParentData.ModelObject).BandName
        else
          C.BandName := '';
        C.Modified := True;
      end;
  end;

  RenumberSortOrder(DroppedNode.Parent);

  if FStructLoaded then
  begin
    if NeedsFormSync then
      SyncFormFromModel;
    SyncGridFromModel;
  end;
end;

procedure TBaseWebDesignerFrame.RenumberSortOrder(ParentNode: TcxTreeListNode);
var
  I: Integer;
  ChildData: TBaseWebNodeData;
begin
  for I := 0 to ParentNode.Count - 1 do
  begin
    ChildData := NodeDataOf(ParentNode.Items[I]);
    if not Assigned(ChildData) or not Assigned(ChildData.ModelObject) then
      Continue;

    case ChildData.Kind of
      // nodi [Custom]: figli fissi, non hanno SortOrder proprio
      nkFormTab:
        begin
          TBaseWebFormTab(ChildData.ModelObject).SortOrder := I * 10;
          TBaseWebFormTab(ChildData.ModelObject).Modified := True;
        end;
      nkFormGroup:
        begin
          TBaseWebFormGroup(ChildData.ModelObject).SortOrder := I * 10;
          TBaseWebFormGroup(ChildData.ModelObject).Modified := True;
        end;
      nkFormField:
        begin
          TBaseWebFormField(ChildData.ModelObject).SortOrder := I * 10;
          TBaseWebFormField(ChildData.ModelObject).Modified := True;
        end;
      nkFormButton:
        begin
          TBaseWebFormButton(ChildData.ModelObject).SortOrder := I * 10;
          TBaseWebFormButton(ChildData.ModelObject).Modified := True;
        end;
      nkFormEmpty:
        begin
          TBaseWebFormEmpty(ChildData.ModelObject).SortOrder := I * 10;
          TBaseWebFormEmpty(ChildData.ModelObject).Modified := True;
        end;
      nkGridBand:
        begin
          TBaseWebGridBand(ChildData.ModelObject).SortOrder := I * 10;
          TBaseWebGridBand(ChildData.ModelObject).Modified := True;
        end;
      nkGridColumn:
        begin
          TBaseWebGridColumn(ChildData.ModelObject).SortOrder := I * 10;
          TBaseWebGridColumn(ChildData.ModelObject).Modified := True;
        end;
    end;
  end;
end;

{ --------------------------------------------------------------------------- }
{ Setup cxGridBandedTableView }
{ --------------------------------------------------------------------------- }

procedure TBaseWebDesignerFrame.SetupGrid;
begin
  cxGridBandedTableView.OptionsView.BandHeaders := True;
  cxGridBandedTableView.OptionsView.ColumnAutoWidth := False;

  cxGridBandedTableView.OptionsCustomize.ColumnMoving := True;
  cxGridBandedTableView.OptionsCustomize.BandMoving := True;
  cxGridBandedTableView.OptionsCustomize.ColumnHorzSizing := True;

  cxGridBandedTableView.OnColumnPosChanged := GridColumnPosChanged;
  cxGridBandedTableView.OnColumnSizeChanged := GridColumnSizeChanged;
  cxGridBandedTableView.OnBandPosChanged := GridBandPosChanged;
end;

{ --------------------------------------------------------------------------- }
{ Sincronizzazione Modello → Grid }
{ --------------------------------------------------------------------------- }

procedure TBaseWebDesignerFrame.SyncGridFromModel;
var
  BandMap: TDictionary<string, TcxGridBand>;
  MB: TBaseWebGridBand;
  MC: TBaseWebGridColumn;
  GB: TcxGridBand;
  GC: TcxGridBandedColumn;
  DefaultBand: TcxGridBand; // banda di default per colonne senza banda nel modello
  SortedCols: TList<TBaseWebGridColumn>;
begin
  if not FStructLoaded then
    Exit;

  FGridSyncing := True;
  cxGridBandedTableView.BeginUpdate;
  BandMap := TDictionary<string, TcxGridBand>.Create;
  try
    // Svuota colonne prima, poi bande (le colonne referenziano le bande)
    cxGridBandedTableView.ClearItems;
    cxGridBandedTableView.Bands.Clear;

    DefaultBand := nil;

    // --- Bande radice (ParentBand null/vuoto) ---
    for MB in FStruct.GridBands do
      if MB.ParentBand.IsEmpty then
      begin
        GB := cxGridBandedTableView.Bands.Add;
        GB.Caption := MB.Caption;
        GB.Tag := NativeInt(MB);
        GB.Visible := MB.Visible;
        BandMap.AddOrSetValue(MB.BandName, GB);
      end;

    // --- Sub-band: crea tramite Bands.Add e assegna parent con Position.BandIndex ---
    for MB in FStruct.GridBands do
      if not MB.ParentBand.IsEmpty then
        if BandMap.TryGetValue(MB.ParentBand, GB) then
        begin
          var
          SubGB := cxGridBandedTableView.Bands.Add;
          SubGB.Caption := MB.Caption;
          SubGB.Tag := NativeInt(MB);
          SubGB.Visible := MB.Visible;
          SubGB.Position.BandIndex := GB.Index;
          BandMap.AddOrSetValue(MB.BandName, SubGB);
        end;

    // --- Colonne ordinate per SortOrder ---
    SortedCols := TList<TBaseWebGridColumn>.Create;
    try
      for MC in FStruct.GridColumns do
        SortedCols.Add(MC);
      SortedCols.Sort(TComparer<TBaseWebGridColumn>.Construct(
        function(const A, B: TBaseWebGridColumn): Integer
        begin
          Result := A.SortOrder - B.SortOrder;
        end));

      for MC in SortedCols do
      begin
        GC := cxGridBandedTableView.CreateColumn;
        GC.Caption := IfThen(MC.Caption.IsEmpty, MC.Field, MC.Caption);
        GC.Tag := NativeInt(MC);
        GC.Visible := MC.Visible;

        if MC.Width > 0 then
          GC.Width := MC.Width
        else
          GC.Width := 80;

        if MC.Fixed then
        begin
          if SameText(MC.FixedPosition, 'right') then
            GC.FixedKind := fkRight
          else
            GC.FixedKind := fkLeft;
        end
        else
          GC.FixedKind := fkNone;

        // Assegna la colonna alla banda del modello, se specificata
        if (not MC.BandName.IsEmpty) and BandMap.TryGetValue(MC.BandName, GB) then
          GC.Position.BandIndex := GB.Index
        else
        begin
          // Colonna senza banda: usa (o crea) la DefaultBand
          if DefaultBand = nil then
          begin
            DefaultBand := cxGridBandedTableView.Bands.Add;
            DefaultBand.Caption := '';
            DefaultBand.Tag := 0; // non ha corrispondenza nel modello
            DefaultBand.Visible := True;
          end;
          GC.Position.BandIndex := DefaultBand.Index;
        end;
      end;
    finally
      SortedCols.Free;
    end;

  finally
    BandMap.Free;
    cxGridBandedTableView.EndUpdate;
    FGridSyncing := False;
  end;

  FillGridWithDummyData;
end;

{ --------------------------------------------------------------------------- }
{ Helper: ricerca nel modello }
{ --------------------------------------------------------------------------- }

function TBaseWebDesignerFrame.FindModelColumn(const AField: string): TBaseWebGridColumn;
begin
  Result := nil;
  if not FStructLoaded then
    Exit;
  for var MC in FStruct.GridColumns do
    if SameText(MC.Field, AField) then
      Exit(MC);
end;

function TBaseWebDesignerFrame.FindModelBand(const ABandName: string): TBaseWebGridBand;
begin
  Result := nil;
  if not FStructLoaded then
    Exit;
  for var MB in FStruct.GridBands do
    if SameText(MB.BandName, ABandName) then
      Exit(MB);
end;

function TBaseWebDesignerFrame.FocusedModelColumn: TBaseWebGridColumn;
var
  GC: TcxGridBandedColumn;
begin
  Result := nil;
  if not FStructLoaded then
    Exit;
  if cxGridBandedTableView.Controller.FocusedItem = nil then
    Exit;
  GC := cxGridBandedTableView.Controller.FocusedItem as TcxGridBandedColumn;
  if GC <> nil then
    Result := TBaseWebGridColumn(Pointer(GC.Tag));
end;

function TBaseWebDesignerFrame.FocusedModelBand: TBaseWebGridBand;
var
  GC: TcxGridBandedColumn;
  GB: TcxGridBand;
begin
  Result := nil;
  if not FStructLoaded then
    Exit;
  // Non esiste FocusedBand sul Controller: la banda si ricava dalla colonna focalizzata
  if cxGridBandedTableView.Controller.FocusedItem = nil then
    Exit;
  GC := cxGridBandedTableView.Controller.FocusedItem as TcxGridBandedColumn;
  if GC = nil then
    Exit;
  GB := GC.Position.Band;
  if GB <> nil then
    Result := TBaseWebGridBand(Pointer(GB.Tag));
end;

{ --------------------------------------------------------------------------- }
{ Grid → Modello: eventi che aggiornano il modello quando l'utente interagisce
  direttamente con la cxGridBandedTableView }
{ --------------------------------------------------------------------------- }

procedure TBaseWebDesignerFrame.GridColumnPosChanged(Sender: TcxGridTableView; AColumn: TcxGridColumn);
var
  GC: TcxGridBandedColumn;
  MC: TBaseWebGridColumn;
  MB: TBaseWebGridBand;
  I: Integer;
begin
  if FGridSyncing or not FStructLoaded then
    Exit;

  // AColumn arriva come TcxGridColumn; in una BandedTableView è sempre TcxGridBandedColumn
  GC := AColumn as TcxGridBandedColumn;
  MC := TBaseWebGridColumn(Pointer(GC.Tag));
  if MC = nil then
    Exit;

  // Aggiorna BandName dalla banda corrente della colonna
  if (GC.Position <> nil) and (GC.Position.Band <> nil) then
  begin
    MB := TBaseWebGridBand(Pointer(GC.Position.Band.Tag));
    if MB <> nil then
      MC.BandName := MB.BandName
    else
      MC.BandName := '';
  end
  else
    MC.BandName := '';

  MC.Modified := True;

  // Rinumera SortOrder di tutte le colonne della banda corrente
  if (GC.Position <> nil) and (GC.Position.Band <> nil) then
    for I := 0 to GC.Position.Band.ColumnCount - 1 do
    begin
      var
      GCi := GC.Position.Band.Columns[I] as TcxGridBandedColumn;
      var
      MCi := TBaseWebGridColumn(Pointer(GCi.Tag));
      if MCi <> nil then
      begin
        MCi.SortOrder := I * 10;
        MCi.Modified := True;
      end;
    end;

  // Ricostruisce il TreeList con i dati aggiornati
  FGridSyncing := True;
  try
    ClearTree;
    BuildDatasetNode(FStruct);
  finally
    FGridSyncing := False;
  end;
end;

procedure TBaseWebDesignerFrame.GridColumnSizeChanged(Sender: TcxGridTableView; AColumn: TcxGridColumn);
var
  GC: TcxGridBandedColumn;
  MC: TBaseWebGridColumn;
begin
  if FGridSyncing or not FStructLoaded then
    Exit;
  GC := AColumn as TcxGridBandedColumn;
  MC := TBaseWebGridColumn(Pointer(GC.Tag));
  if MC <> nil then
  begin
    MC.Width := GC.Width;
    MC.Modified := True;
  end;
end;

procedure TBaseWebDesignerFrame.GridBandPosChanged(Sender: TcxGridBandedTableView; ABand: TcxGridBand);
var
  MB: TBaseWebGridBand;
  I: Integer;
begin
  if FGridSyncing or not FStructLoaded then
    Exit;

  MB := TBaseWebGridBand(Pointer(ABand.Tag));
  if MB = nil then
    Exit;

  // Ricava il nuovo ParentBand dalla struttura attuale della banda
  if ABand.ParentBand <> nil then
  begin
    var
    MParent := TBaseWebGridBand(Pointer(ABand.ParentBand.Tag));
    if MParent <> nil then
      MB.ParentBand := MParent.BandName
    else
      MB.ParentBand := '';
  end
  else
    MB.ParentBand := '';

  MB.Modified := True;

  // Rinumera SortOrder delle bande radice (livello 0)
  for I := 0 to cxGridBandedTableView.Bands.Count - 1 do
  begin
    var
    GBi := cxGridBandedTableView.Bands[I];
    if GBi.ParentBand = nil then // solo bande radice
    begin
      var
      MBi := TBaseWebGridBand(Pointer(GBi.Tag));
      if MBi <> nil then
      begin
        MBi.SortOrder := I * 10;
        MBi.Modified := True;
      end;
    end;
  end;

  // Ricostruisce il TreeList
  FGridSyncing := True;
  try
    ClearTree;
    BuildDatasetNode(FStruct);
  finally
    FGridSyncing := False;
  end;
end;

{ --------------------------------------------------------------------------- }
{ Azioni popGrid }
{ --------------------------------------------------------------------------- }

// --- Update handlers (abilitano/disabilitano le voci) ---

procedure TBaseWebDesignerFrame.actGridAddToBandUpdate(Sender: TObject);
begin
  // Abilitato se c'è una colonna focalizzata e almeno una banda
  (Sender as TAction).Enabled := FStructLoaded and (cxGridBandedTableView.Controller.FocusedItem <> nil) and (cxGridBandedTableView.Bands.Count > 0);
end;

procedure TBaseWebDesignerFrame.actGridMoveColumnUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := FStructLoaded and (cxGridBandedTableView.Controller.FocusedItem <> nil);
end;

procedure TBaseWebDesignerFrame.actGridToggleVisibleUpdate(Sender: TObject);
var
  MC: TBaseWebGridColumn;
begin
  MC := FocusedModelColumn;
  (Sender as TAction).Enabled := MC <> nil;
  if MC <> nil then
    (Sender as TAction).Caption := IfThen(MC.Visible, 'Nascondi colonna', 'Mostra colonna');
end;

procedure TBaseWebDesignerFrame.actGridToggleFixedUpdate(Sender: TObject);
var
  MC: TBaseWebGridColumn;
begin
  MC := FocusedModelColumn;
  (Sender as TAction).Enabled := MC <> nil;
  if MC <> nil then
    (Sender as TAction).Caption := IfThen(MC.Fixed, 'Sblocca colonna', 'Fissa colonna');
end;

// --- Execute handlers ---

procedure TBaseWebDesignerFrame.actGridAddToBandExecute(Sender: TObject);
var
  GC: TcxGridBandedColumn;
  MC: TBaseWebGridColumn;
  MB: TBaseWebGridBand;
  Items: TStringList;
  I: Integer;
  Choice: Integer;
  BandNames: TArray<string>;
begin
  if not FStructLoaded then
    Exit;
  GC := cxGridBandedTableView.Controller.FocusedItem as TcxGridBandedColumn;
  if GC = nil then
    Exit;
  MC := TBaseWebGridColumn(Pointer(GC.Tag));
  if MC = nil then
    Exit;

  // Costruisce lista nomi bande
  Items := TStringList.Create;
  try
    SetLength(BandNames, FStruct.GridBands.Count);
    for I := 0 to FStruct.GridBands.Count - 1 do
    begin
      BandNames[I] := FStruct.GridBands[I].BandName;
      Items.Add(FStruct.GridBands[I].BandName + ' (' + FStruct.GridBands[I].Caption + ')');
    end;

    Choice := -1;
    var
      BandName: string := MC.BandName;
    if not InputQuery('Assegna a banda', 'Nome banda (lasciar vuoto = nessuna banda):', BandName) then
      Exit;
    BandName := Trim(BandName);

    MB := FindModelBand(BandName);
    if (BandName <> '') and (MB = nil) then
    begin
      MessageDlg('Banda "' + BandName + '" non trovata.', mtWarning, [mbOK], 0);
      Exit;
    end;

    MC.BandName := BandName;
    MC.Modified := True;
    SyncGridFromModel;
    ClearTree;
    BuildDatasetNode(FStruct);
  finally
    Items.Free;
  end;
end;

procedure TBaseWebDesignerFrame.actGridMoveColumnExecute(Sender: TObject);
var
  GC: TcxGridBandedColumn;
  MC: TBaseWebGridColumn;
  SVal: string;
  NewPos: Integer;
begin
  if not FStructLoaded then
    Exit;
  GC := cxGridBandedTableView.Controller.FocusedItem as TcxGridBandedColumn;
  if GC = nil then
    Exit;
  MC := TBaseWebGridColumn(Pointer(GC.Tag));
  if MC = nil then
    Exit;

  SVal := IntToStr(MC.SortOrder div 10);
  if not InputQuery('Sposta colonna', 'Posizione (0 = prima):', SVal) then
    Exit;
  if not TryStrToInt(Trim(SVal), NewPos) then
    Exit;

  MC.SortOrder := NewPos * 10;
  MC.Modified := True;
  SyncGridFromModel;
  ClearTree;
  BuildDatasetNode(FStruct);
end;

procedure TBaseWebDesignerFrame.actGridToggleVisibleExecute(Sender: TObject);
var
  GC: TcxGridBandedColumn;
  MC: TBaseWebGridColumn;
begin
  if not FStructLoaded then
    Exit;
  GC := cxGridBandedTableView.Controller.FocusedItem as TcxGridBandedColumn;
  if GC = nil then
    Exit;
  MC := TBaseWebGridColumn(Pointer(GC.Tag));
  if MC = nil then
    Exit;

  MC.Visible := not MC.Visible;
  MC.Modified := True;
  GC.Visible := MC.Visible;
end;

procedure TBaseWebDesignerFrame.actGridToggleFixedExecute(Sender: TObject);
var
  GC: TcxGridBandedColumn;
  MC: TBaseWebGridColumn;
begin
  if not FStructLoaded then
    Exit;
  GC := cxGridBandedTableView.Controller.FocusedItem as TcxGridBandedColumn;
  if GC = nil then
    Exit;
  MC := TBaseWebGridColumn(Pointer(GC.Tag));
  if MC = nil then
    Exit;

  MC.Fixed := not MC.Fixed;
  MC.Modified := True;
  if MC.Fixed then
  begin
    if SameText(MC.FixedPosition, 'right') then
      GC.FixedKind := fkRight
    else
      GC.FixedKind := fkLeft;
  end
  else
    GC.FixedKind := fkNone;
end;

procedure TBaseWebDesignerFrame.actGridCustomizeExecute(Sender: TObject);
begin
  // Apre il customizer standard di DevExpress
  cxGridBandedTableView.Controller.Customization := True;
end;

{ --------------------------------------------------------------------------- }
{ Dati farlocchi per anteprima griglia }
{ --------------------------------------------------------------------------- }

procedure TBaseWebDesignerFrame.FillGridWithDummyData;
const
  DUMMY_ROWS = 100;
  WORDS: array [0 .. 19] of string = ('Alpha', 'Bravo', 'Charlie', 'Delta', 'Echo', 'Foxtrot', 'Golf', 'Hotel', 'India', 'Juliet', 'Kilo', 'Lima', 'Mike', 'November', 'Oscar', 'Papa', 'Quebec', 'Romeo', 'Sierra', 'Tango');
var
  DC: TcxCustomDataController;
  ColIdx: Integer;
  RowIdx: Integer;
  GC: TcxGridBandedColumn;
  MC: TBaseWebGridColumn;
  DataType: string;
  I: Integer;
begin
  if not FStructLoaded then
    Exit;
  if cxGridBandedTableView.ColumnCount = 0 then
    Exit;

  DC := cxGridBandedTableView.DataController;

  // Prima passata: imposta ValueTypeClass su ogni colonna (obbligatorio in unbound mode)
  for I := 0 to cxGridBandedTableView.ColumnCount - 1 do
  begin
    GC := cxGridBandedTableView.Columns[I];
    MC := TBaseWebGridColumn(Pointer(GC.Tag));

    DataType := '';
    if Assigned(MC) and not MC.DataType.IsEmpty then
      DataType := LowerCase(MC.DataType);

    if (DataType = 'integer') or (DataType = 'int') or (DataType = 'numeric') or (DataType = 'number') then
      GC.DataBinding.ValueTypeClass := TcxIntegerValueType
    else
      if (DataType = 'float') or (DataType = 'double') or (DataType = 'currency') or (DataType = 'decimal') then
        GC.DataBinding.ValueTypeClass := TcxCurrencyValueType
      else
        if (DataType = 'date') or (DataType = 'timestamp') then
          GC.DataBinding.ValueTypeClass := TcxDateTimeValueType
        else
          if (DataType = 'datetime') then
            GC.DataBinding.ValueTypeClass := TcxDateTimeValueType
          else
            if (DataType = 'boolean') or (DataType = 'bool') then
              GC.DataBinding.ValueTypeClass := TcxBooleanValueType
            else
              GC.DataBinding.ValueTypeClass := TcxStringValueType;
  end;

  // Seconda passata: alloca le righe e popola i valori
  cxGridBandedTableView.BeginUpdate;
  DC.BeginUpdate;
  try
    DC.RecordCount := DUMMY_ROWS;

    for RowIdx := 0 to DUMMY_ROWS - 1 do
      for ColIdx := 0 to cxGridBandedTableView.ColumnCount - 1 do
      begin
        GC := cxGridBandedTableView.Columns[ColIdx];
        MC := TBaseWebGridColumn(Pointer(GC.Tag));

        DataType := '';
        if Assigned(MC) and not MC.DataType.IsEmpty then
          DataType := LowerCase(MC.DataType);

        if (DataType = 'integer') or (DataType = 'int') or (DataType = 'numeric') or (DataType = 'number') then
          DC.Values[RowIdx, GC.Index] := (RowIdx + 1) * (ColIdx + 1)
        else
          if (DataType = 'float') or (DataType = 'double') or (DataType = 'currency') or (DataType = 'decimal') then
            DC.Values[RowIdx, GC.Index] := Round((RowIdx + 1) * (ColIdx + 1) * 1.5 * 100) / 100
          else
            if (DataType = 'date') or (DataType = 'timestamp') then
              DC.Values[RowIdx, GC.Index] := Date - RowIdx
            else
              if (DataType = 'datetime') then
                DC.Values[RowIdx, GC.Index] := Now - RowIdx
              else
                if (DataType = 'boolean') or (DataType = 'bool') then
                  DC.Values[RowIdx, GC.Index] := (RowIdx mod 2 = 0)
                else
                  DC.Values[RowIdx, GC.Index] := WORDS[(RowIdx + ColIdx) mod Length(WORDS)] + '_' + IntToStr(RowIdx + 1);
      end;
  finally
    DC.EndUpdate;
    cxGridBandedTableView.EndUpdate;
  end;
end;

procedure TBaseWebDesignerFrame.SetupForm;
begin

  { Costruisce il builder }
  FFormPreviewBuilder := TFormPreviewBuilder.Create(Self, LayoutControlForm);
  FFormPreviewBuilder.LookAndFeelHighlight := dxLayoutSkinLookAndFeelBold;
  FFormPreviewBuilder.PopupMenuField := popForm;
  FFormPreviewBuilder.OnFieldSelected := FormFieldSelected;
  FFormPreviewBuilder.OnFieldContext := FormFieldContext;
  FFormPreviewBuilder.OnContainerSelected := FormContainerSelected;
  LayoutControlForm.OnCustomization := LayoutControlFormCustomization;
  LayoutControlForm.Container.OnChanged := LayoutControlFormContainerChanged;

  // Timer debounce: la sync scatta solo dopo 300ms di quiete
  FSyncTimer := TTimer.Create(Self);
  FSyncTimer.Interval := 300;
  FSyncTimer.Enabled := False;
  FSyncTimer.OnTimer := SyncTimerFired;

  // Intercetta le modifiche RTTI per il tracking di Modified
  Inspector.OnEdited := InspectorEdited;

  FFocusedFormField := '';
  FFormSyncing := False;
end;

procedure TBaseWebDesignerFrame.FormFieldSelected(Sender: TObject; const AFieldName: string);
begin
  FFocusedFormField := AFieldName;
  FFocusedFieldForSelection := AFieldName;
  // Posticipa la selezione del nodo fuori dallo stack eventi del layout DX
  PostMessage(Handle, WM_SelectFieldNode, 0, 0);
end;

procedure TBaseWebDesignerFrame.FormFieldContext(Sender: TObject; const AFieldName: string; X, Y: Integer);
begin
  // Il popup viene aperto direttamente da TFormPreviewBuilder
  FFocusedFormField := AFieldName;

  // Seleziona nell'albero il nodo del GROUP che contiene il campo:
  // questo fa sì che le nuove azioni (AddGroup, AddTab, Delete) leggano
  // il contesto corretto dal FocusedNode.
  for var FF in FStruct.FormFields do
    if SameText(FF.Field, AFieldName) then
    begin
      var
      ContName := FF.ContainerName;
      if ContName <> '' then
        SelectTreeNodeByGroupName(ContName);
      Break;
    end;
end;

{ ---------------------------------------------------------------------------
  actFormHighlightField
  Evidenzia nell'anteprima il campo corrispondente al nodo albero selezionato.
  Disponibile solo se il nodo corrente è un nkFormField.
  --------------------------------------------------------------------------- }
procedure TBaseWebDesignerFrame.actFormHighlightFieldExecute(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if not Assigned(NodeData) then
    Exit;
  if NodeData.Kind in [nkFormField] then
  begin
    var
    FF := TBaseWebFormField(NodeData.ModelObject);
    FFocusedFormField := FF.Field;
    FFormPreviewBuilder.HighlightField(FF.Field);
    { Porta in primo piano il tab Form }
    cxPageControl.ActivePageIndex := 0; // tab "Form"
  end;
end;

procedure TBaseWebDesignerFrame.actFormHighlightFieldUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  TAction(Sender).Enabled := FStructLoaded and Assigned(NodeData) and (NodeData.Kind in [nkFormField]);
end;

{ ---------------------------------------------------------------------------
  actFormMoveItem
  Cambia il SortOrder del campo/button/empty selezionato nell'albero.
  Analogo a actGridMoveColumn.
  --------------------------------------------------------------------------- }
procedure TBaseWebDesignerFrame.actFormMoveItemExecute(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
  SVal: string;
  NewPos: Integer;
begin
  if not FStructLoaded then
    Exit;
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if not Assigned(NodeData) then
    Exit;

  case NodeData.Kind of

    nkFormField:
      begin
        var
        FF := TBaseWebFormField(NodeData.ModelObject);
        SVal := IntToStr(FF.SortOrder div 10);
        if not InputQuery('Sposta campo', 'Posizione (0 = prima):', SVal) then
          Exit;
        if not TryStrToInt(Trim(SVal), NewPos) then
          Exit;
        FF.SortOrder := NewPos * 10;
        FF.Modified := True;
      end;

    nkFormButton:
      begin
        var
        FB := TBaseWebFormButton(NodeData.ModelObject);
        SVal := IntToStr(FB.SortOrder div 10);
        if not InputQuery('Sposta pulsante', 'Posizione (0 = prima):', SVal) then
          Exit;
        if not TryStrToInt(Trim(SVal), NewPos) then
          Exit;
        FB.SortOrder := NewPos * 10;
        FB.Modified := True;
      end;

    nkFormEmpty:
      begin
        var
        FE := TBaseWebFormEmpty(NodeData.ModelObject);
        SVal := IntToStr(FE.SortOrder div 10);
        if not InputQuery('Sposta segnaposto', 'Posizione (0 = prima):', SVal) then
          Exit;
        if not TryStrToInt(Trim(SVal), NewPos) then
          Exit;
        FE.SortOrder := NewPos * 10;
        FE.Modified := True;
      end;

  else
    Exit;
  end;

  SyncFormFromModel;
  ClearTree;
  BuildDatasetNode(FStruct);
end;

procedure TBaseWebDesignerFrame.actFormMoveItemUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  TAction(Sender).Enabled := FStructLoaded and Assigned(NodeData) and (NodeData.Kind in [nkFormField, nkFormButton, nkFormEmpty]);
end;

{ ---------------------------------------------------------------------------
  actFormToggleRequired
  Inverte il flag Required del FormField selezionato.
  --------------------------------------------------------------------------- }
procedure TBaseWebDesignerFrame.actFormToggleRequiredExecute(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
  FF: TBaseWebFormField;
begin
  if not FStructLoaded then
    Exit;
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if not Assigned(NodeData) or (NodeData.Kind <> nkFormField) then
    Exit;
  FF := TBaseWebFormField(NodeData.ModelObject);
  FF.Required := not FF.Required;
  FF.Modified := True;
  SyncFormFromModel;
end;

procedure TBaseWebDesignerFrame.actFormToggleRequiredUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if FStructLoaded and Assigned(NodeData) and (NodeData.Kind = nkFormField) then
  begin
    TAction(Sender).Enabled := True;
    TAction(Sender).Checked := TBaseWebFormField(NodeData.ModelObject).Required;
  end
  else
    TAction(Sender).Enabled := False;
end;

{ ---------------------------------------------------------------------------
  actFormToggleReadOnly
  Inverte il flag ReadOnly del FormField selezionato.
  --------------------------------------------------------------------------- }
procedure TBaseWebDesignerFrame.actFormToggleReadOnlyExecute(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
  FF: TBaseWebFormField;
begin
  if not FStructLoaded then
    Exit;
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if not Assigned(NodeData) or (NodeData.Kind <> nkFormField) then
    Exit;
  FF := TBaseWebFormField(NodeData.ModelObject);
  // { TODO : Verificare } FF.ReadOnly := not FF.ReadOnly;
  // FF.Modified := True;  ← da abilitare quando il TODO sopra è risolto
  SyncFormFromModel;
end;

procedure TBaseWebDesignerFrame.actFormToggleReadOnlyUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if FStructLoaded and Assigned(NodeData) and (NodeData.Kind = nkFormField) then
  begin
    TAction(Sender).Enabled := True;
    // { TODO : Verificare } TAction(Sender).Checked := TBaseWebFormField(NodeData.ModelObject).ReadOnly;
  end
  else
    TAction(Sender).Enabled := False;
end;

{ ---------------------------------------------------------------------------
  actFormChangeEditorType
  Permette di impostare manualmente l'EditorType del campo selezionato
  (override nel modello Fields).
  --------------------------------------------------------------------------- }
procedure TBaseWebDesignerFrame.actFormChangeEditorTypeExecute(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
  FF: TBaseWebFormField;
  FD: TBaseWebDatasetField;
  SVal: string;
begin
  if not FStructLoaded then
    Exit;
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if not Assigned(NodeData) or (NodeData.Kind <> nkFormField) then
    Exit;
  FF := TBaseWebFormField(NodeData.ModelObject);

  { Legge il tipo corrente dalla definizione del campo }
  SVal := '';
  FD := nil;
  for var F in FStruct.Fields do
    if SameText(F.Field, FF.Field) then
    begin
      FD := F;
      SVal := F.EditorType;
      Break;
    end;

  if not InputQuery('Tipo editor', 'EditorType (text, number, date, lookup…):', SVal) then
    Exit;

  SVal := Trim(SVal);
  if SVal = '' then
    Exit;

  if Assigned(FD) then
  begin
    FD.EditorType := SVal;
    FD.Modified := True;
  end;

  SyncFormFromModel;
end;

procedure TBaseWebDesignerFrame.actFormChangeEditorTypeUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  TAction(Sender).Enabled := FStructLoaded and Assigned(NodeData) and (NodeData.Kind = nkFormField);
end;

{ ---------------------------------------------------------------------------
  actFormCustomize
  Attiva / disattiva la modalità customization del dxLayoutControl.
  --------------------------------------------------------------------------- }
procedure TBaseWebDesignerFrame.actFormCustomizeExecute(Sender: TObject);
begin
  if Assigned(FFormPreviewBuilder) then
    FFormPreviewBuilder.EnableCustomization(not LayoutControlForm.Customization);
end;

{ --------------------------------------------------------------------------- }
{ popTree — popup contestuale sull'albero }
{ --------------------------------------------------------------------------- }

procedure TBaseWebDesignerFrame.popTreePopup(Sender: TObject);
begin
  // Nulla da fare: la visibilità è gestita dagli OnUpdate delle azioni,
  // invocati automaticamente dal dxBarManager prima della visualizzazione.
  // Lasciare vuoto o aggiungere logica futura qui.
end;

{ ---- Fields ---- }

procedure TBaseWebDesignerFrame.actTreeFieldGoToExecute(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if not Assigned(NodeData) then
    Exit;
  SelectObject(NodeData.ModelObject);
  // Porta il focus sull'Inspector già aggiornato da SelectObject
  Inspector.SetFocus;
end;

procedure TBaseWebDesignerFrame.actTreeFieldGoToUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  TAction(Sender).Enabled := FStructLoaded and Assigned(NodeData) and (NodeData.Kind in [nkField]);
  TAction(Sender).Visible := TAction(Sender).Enabled;
end;

{ ---- Form / campo ---- }

procedure TBaseWebDesignerFrame.actTreeFormGoToExecute(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if not Assigned(NodeData) then
    Exit;
  if NodeData.Kind in [nkFormField] then
  begin
    FFocusedFormField := TBaseWebFormField(NodeData.ModelObject).Field;
    FFormPreviewBuilder.HighlightField(FFocusedFormField);
    cxPageControl.ActivePageIndex := 0;
  end;
end;

procedure TBaseWebDesignerFrame.actTreeFormGoToUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  TAction(Sender).Enabled := FStructLoaded and Assigned(NodeData) and (NodeData.Kind in [nkFormField]);
  TAction(Sender).Visible := TAction(Sender).Enabled;
end;

procedure TBaseWebDesignerFrame.actTreeFormMoveItemExecute(Sender: TObject);
begin
  // Delega all'azione analoga del tab Form (stessa logica)
  actFormMoveItemExecute(Sender);
end;

procedure TBaseWebDesignerFrame.actTreeFormMoveItemUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  TAction(Sender).Enabled := FStructLoaded and Assigned(NodeData) and (NodeData.Kind in [nkFormField, nkFormButton, nkFormEmpty]);
  TAction(Sender).Visible := TAction(Sender).Enabled;
end;

procedure TBaseWebDesignerFrame.actTreeFormToggleRequiredExecute(Sender: TObject);
begin
  actFormToggleRequiredExecute(Sender);
end;

procedure TBaseWebDesignerFrame.actTreeFormToggleRequiredUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if FStructLoaded and Assigned(NodeData) and (NodeData.Kind = nkFormField) then
  begin
    TAction(Sender).Enabled := True;
    TAction(Sender).Visible := True;
    TAction(Sender).Checked := TBaseWebFormField(NodeData.ModelObject).Required;
  end
  else
  begin
    TAction(Sender).Enabled := False;
    TAction(Sender).Visible := False;
  end;
end;

procedure TBaseWebDesignerFrame.actTreeFormToggleReadOnlyExecute(Sender: TObject);
begin
  actFormToggleReadOnlyExecute(Sender);
end;

procedure TBaseWebDesignerFrame.actTreeFormToggleReadOnlyUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if FStructLoaded and Assigned(NodeData) and (NodeData.Kind = nkFormField) then
  begin
    TAction(Sender).Enabled := True;
    TAction(Sender).Visible := True;
    // { TODO : Verificare }     TAction(Sender).Checked := TBaseWebFormField(NodeData.ModelObject).ReadOnly.GetValueOrDefault(False);
  end
  else
  begin
    TAction(Sender).Enabled := False;
    TAction(Sender).Visible := False;
  end;
end;

procedure TBaseWebDesignerFrame.actTreeFormChangeEditorTypeExecute(Sender: TObject);
begin
  actFormChangeEditorTypeExecute(Sender);
end;

procedure TBaseWebDesignerFrame.actTreeFormChangeEditorTypeUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  TAction(Sender).Enabled := FStructLoaded and Assigned(NodeData) and (NodeData.Kind = nkFormField);
  TAction(Sender).Visible := TAction(Sender).Enabled;
end;

{ ---- Grid / colonna ---- }

procedure TBaseWebDesignerFrame.actTreeGridAddToBandExecute(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
  MC: TBaseWebGridColumn;
  MB: TBaseWebGridBand;
  BandName: string;
begin
  if not FStructLoaded then
    Exit;
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if not Assigned(NodeData) or (NodeData.Kind <> nkGridColumn) then
    Exit;
  MC := TBaseWebGridColumn(NodeData.ModelObject);
  BandName := MC.BandName;
  if not InputQuery('Assegna a banda', 'Nome banda (vuoto = nessuna):', BandName) then
    Exit;
  BandName := Trim(BandName);
  MB := FindModelBand(BandName);
  if (BandName <> '') and (MB = nil) then
  begin
    MessageDlg('Banda "' + BandName + '" non trovata.', mtWarning, [mbOK], 0);
    Exit;
  end;
  MC.BandName := BandName;
  MC.Modified := True;
  SyncGridFromModel;
  ClearTree;
  BuildDatasetNode(FStruct);
end;

procedure TBaseWebDesignerFrame.actTreeGridAddToBandUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  TAction(Sender).Enabled := FStructLoaded and Assigned(NodeData) and (NodeData.Kind = nkGridColumn);
  TAction(Sender).Visible := TAction(Sender).Enabled;
end;

procedure TBaseWebDesignerFrame.actTreeGridMoveColumnExecute(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
  MC: TBaseWebGridColumn;
  SVal: string;
  NewPos: Integer;
begin
  if not FStructLoaded then
    Exit;
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if not Assigned(NodeData) or (NodeData.Kind <> nkGridColumn) then
    Exit;
  MC := TBaseWebGridColumn(NodeData.ModelObject);
  SVal := IntToStr(MC.SortOrder div 10);
  if not InputQuery('Sposta colonna', 'Posizione (0 = prima):', SVal) then
    Exit;
  if not TryStrToInt(Trim(SVal), NewPos) then
    Exit;
  MC.SortOrder := NewPos * 10;
  MC.Modified := True;
  SyncGridFromModel;
  ClearTree;
  BuildDatasetNode(FStruct);
end;

procedure TBaseWebDesignerFrame.actTreeGridMoveColumnUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  TAction(Sender).Enabled := FStructLoaded and Assigned(NodeData) and (NodeData.Kind = nkGridColumn);
  TAction(Sender).Visible := TAction(Sender).Enabled;
end;

procedure TBaseWebDesignerFrame.actTreeGridToggleVisibleExecute(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
  MC: TBaseWebGridColumn;
begin
  if not FStructLoaded then
    Exit;
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if not Assigned(NodeData) or (NodeData.Kind <> nkGridColumn) then
    Exit;
  MC := TBaseWebGridColumn(NodeData.ModelObject);
  MC.Visible := not MC.Visible;
  MC.Modified := True;
  SyncGridFromModel;
end;

procedure TBaseWebDesignerFrame.actTreeGridToggleVisibleUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if FStructLoaded and Assigned(NodeData) and (NodeData.Kind = nkGridColumn) then
  begin
    TAction(Sender).Enabled := True;
    TAction(Sender).Visible := True;
    TAction(Sender).Checked := not TBaseWebGridColumn(NodeData.ModelObject).Visible;
  end
  else
  begin
    TAction(Sender).Enabled := False;
    TAction(Sender).Visible := False;
  end;
end;

procedure TBaseWebDesignerFrame.actTreeGridToggleFixedExecute(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
  MC: TBaseWebGridColumn;
begin
  if not FStructLoaded then
    Exit;
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if not Assigned(NodeData) or (NodeData.Kind <> nkGridColumn) then
    Exit;
  MC := TBaseWebGridColumn(NodeData.ModelObject);
  MC.Fixed := not MC.Fixed;
  MC.Modified := True;
  SyncGridFromModel;
end;

procedure TBaseWebDesignerFrame.actTreeGridToggleFixedUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if FStructLoaded and Assigned(NodeData) and (NodeData.Kind = nkGridColumn) then
  begin
    TAction(Sender).Enabled := True;
    TAction(Sender).Visible := True;
    TAction(Sender).Checked := TBaseWebGridColumn(NodeData.ModelObject).Fixed;
  end
  else
  begin
    TAction(Sender).Enabled := False;
    TAction(Sender).Visible := False;
  end;
end;

{ ---- Dataset ---- }

procedure TBaseWebDesignerFrame.actTreeDatasetRefreshExecute(Sender: TObject);
begin
  if not FStructLoaded then
    Exit;
  ClearTree;
  BuildDatasetNode(FStruct);
  SyncGridFromModel;
  SyncFormFromModel;
end;

procedure TBaseWebDesignerFrame.actTreeDatasetRefreshUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := FStructLoaded;
  TAction(Sender).Visible := True;
end;

{ ---------------------------------------------------------------------------
  Helper: porta il focus del TreeList sul nodo nkFormGroup con quel GroupName.
  Usato da FormFieldContext per sincronizzare il tree quando l'utente clicca
  sul LayoutControlForm.
  --------------------------------------------------------------------------- }

procedure TBaseWebDesignerFrame.SelectTreeNodeByGroupName(const GroupName: string);
var
  Node: TcxTreeListNode;
  NodeData: TBaseWebNodeData;
begin
  for var I := 0 to TreeList.AbsoluteCount - 1 do
  begin
    Node := TreeList.AbsoluteItems[I];
    NodeData := NodeDataOf(Node);
    if Assigned(NodeData) and (NodeData.Kind = nkFormGroup) and Assigned(NodeData.ModelObject) and SameText(TBaseWebFormGroup(NodeData.ModelObject).GroupName, GroupName) then
    begin
      TreeList.FocusedNode := Node;
      Node.MakeVisible;
      Break;
    end;
  end;
end;

{ ===========================================================================
  actFormAddTabbed
  Aggiunge un nuovo TBaseWebFormTabbed alla struttura.
  Visibile su: nkSectionForm (tree) oppure sempre nel popForm (contesto group).
  =========================================================================== }
procedure TBaseWebDesignerFrame.actFormAddTabbedExecute(Sender: TObject);
var
  ContainerName, TabsPos: string;
  NewTabbed: TBaseWebFormTabbed;
begin
  if not FStructLoaded then
    Exit;

  ContainerName := 'TABS_' + FormatDateTime('hhnnss', Now);
  if not InputQuery('Nuovo pannello tab', 'Nome interno (univoco):', ContainerName) then
    Exit;
  ContainerName := Trim(ContainerName);
  if ContainerName = '' then
    Exit;

  for var TC in FStruct.FormTabbed do
    if SameText(TC.TabbedName, ContainerName) then
    begin
      MessageDlg('ContainerName "' + ContainerName + '" già esistente.', mtWarning, [mbOK], 0);
      Exit;
    end;

  TabsPos := 'top';
  InputQuery('Nuovo pannello tab', 'Posizione tab (top / bottom / left / right):', TabsPos);
  TabsPos := Trim(TabsPos);
  if TabsPos = '' then
    TabsPos := 'top';

  CreateTabbed(ContainerName, TabsPos);

  SyncFormFromModel;
  ClearTree;
  BuildDatasetNode(FStruct);
end;

procedure TBaseWebDesignerFrame.actFormAddTabbedUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  { Nel popForm il FocusedNode potrebbe essere nil (nessun nodo selezionato):
    in quel caso mostriamo comunque l'azione come disponibile, perché il click
    è arrivato dal LayoutControlForm e la struttura è caricata. }
  TAction(Sender).Enabled := FStructLoaded;
  TAction(Sender).Visible := FStructLoaded and (not Assigned(NodeData) or (NodeData.Kind in [nkSectionForm, nkFormTabbed, nkFormGroup]));
end;

procedure TBaseWebDesignerFrame.actTreeFormAddTabbedUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  TAction(Sender).Enabled := FStructLoaded and Assigned(NodeData) and (NodeData.Kind in [nkSectionForm, nkFormTabbed]);
  TAction(Sender).Visible := TAction(Sender).Enabled;
end;

{ ===========================================================================
  actFormAddTab
  Aggiunge un TBaseWebFormTab nel Tabbed attualmente selezionato.
  =========================================================================== }
procedure TBaseWebDesignerFrame.actFormAddTabExecute(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
  Tabbed: TBaseWebFormTabbed;
  TabName, Caption: string;
  NewTab: TBaseWebFormTab;
begin
  if not FStructLoaded then
    Exit;

  { Trova il Tabbed di riferimento }
  Tabbed := nil;
  NodeData := NodeDataOf(TreeList.FocusedNode);

  if Assigned(NodeData) then
  begin
    if NodeData.Kind = nkFormTabbed then
      Tabbed := TBaseWebFormTabbed(NodeData.ModelObject);
  end;

  { Fallback: se il focus è su un campo/group, risale al primo Tabbed trovato }
  if not Assigned(Tabbed) and (FStruct.FormTabbed.Count > 0) then
    Tabbed := FStruct.FormTabbed[0];

  if not Assigned(Tabbed) then
  begin
    MessageDlg('Nessun pannello tab trovato. Aggiungi prima un pannello tab.', mtWarning, [mbOK], 0);
    Exit;
  end;

  TabName := 'TAB_' + FormatDateTime('hhnnss', Now);
  if not InputQuery('Nuovo tab in "' + Tabbed.TabbedName + '"', 'Nome interno (univoco):', TabName) then
    Exit;
  TabName := Trim(TabName);
  if TabName = '' then
    Exit;

  for var T in FStruct.FormTabs do
    if SameText(T.TabName, TabName) then
    begin
      MessageDlg('TabName "' + TabName + '" già esistente.', mtWarning, [mbOK], 0);
      Exit;
    end;

  Caption := TabName;
  InputQuery('Nuovo tab', 'Caption (testo visibile):', Caption);

  NewTab := TBaseWebFormTab.Create;
  NewTab.TabName := TabName;
  NewTab.Caption := Trim(Caption);
  NewTab.TabbedName := Tabbed.TabbedName;
  NewTab.SortOrder := FStruct.FormTabs.Count * 10;
  NewTab.Dataset := FStruct.Dataset.Dataset;
  NewTab.Modified := True;

  FStruct.FormTabs.Add(NewTab);

  SyncFormFromModel;
  ClearTree;
  BuildDatasetNode(FStruct);
end;

procedure TBaseWebDesignerFrame.actFormAddTabUpdate(Sender: TObject);
begin
  { Nel popForm: abilitato se c'è almeno un Tabbed a cui aggiungere un tab }
  TAction(Sender).Enabled := FStructLoaded and (FStruct.FormTabbed.Count > 0);
  TAction(Sender).Visible := TAction(Sender).Enabled;
end;

procedure TBaseWebDesignerFrame.actTreeFormAddTabUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  TAction(Sender).Enabled := FStructLoaded and Assigned(NodeData) and (NodeData.Kind in [nkFormTabbed]);
  TAction(Sender).Visible := TAction(Sender).Enabled;
end;

{ ===========================================================================
  actFormAddGroup
  =========================================================================== }
procedure TBaseWebDesignerFrame.actFormAddGroupExecute(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
  GroupName, Caption: string;
  NewGroup: TBaseWebFormGroup;
begin
  if not FStructLoaded then
    Exit;

  GroupName := 'GRP_' + FormatDateTime('hhnnss', Now);
  if not InputQuery('Nuovo group', 'Nome interno (univoco):', GroupName) then
    Exit;
  GroupName := Trim(GroupName);
  if GroupName = '' then
    Exit;

  for var G in FStruct.FormGroups do
    if SameText(G.GroupName, GroupName) then
    begin
      MessageDlg('GroupName "' + GroupName + '" già esistente.', mtWarning, [mbOK], 0);
      Exit;
    end;

  Caption := GroupName;
  InputQuery('Nuovo group', 'Caption (testo visibile):', Caption);

  NewGroup := CreateGroup(GroupName, Caption, FStruct.FormGroups.Count * 10);

  { Imposta il contenitore in base al contesto del tree }
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if Assigned(NodeData) and (NodeData.Kind = nkFormTab) and Assigned(TreeList.FocusedNode.Parent) then
    NodeData := NodeDataOf(TreeList.FocusedNode.Parent);

  if Assigned(NodeData) and (NodeData.Kind = nkFormTab) then
  begin
    NewGroup.ParentContainerName := TBaseWebFormTab(NodeData.ModelObject).TabName;
    NewGroup.ParentContainerType := 'tab';
  end
  else
  begin
    NewGroup.ParentContainerName := '';
    NewGroup.ParentContainerType := '';
  end;

  NewGroup.Modified := True;
  FStruct.FormGroups.Add(NewGroup);

  SyncFormFromModel;
  ClearTree;
  BuildDatasetNode(FStruct);
end;

procedure TBaseWebDesignerFrame.actFormAddGroupUpdate(Sender: TObject);
begin
  { Nel popForm: sempre disponibile se la struttura è caricata }
  TAction(Sender).Enabled := FStructLoaded;
  TAction(Sender).Visible := FStructLoaded;
end;

procedure TBaseWebDesignerFrame.actTreeFormAddGroupUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  TAction(Sender).Enabled := FStructLoaded and Assigned(NodeData) and (NodeData.Kind in [nkSectionForm, nkFormTab, nkFormTabbed]);
  TAction(Sender).Visible := TAction(Sender).Enabled;
end;

{ ===========================================================================
  actFormRenameContainer
  =========================================================================== }
procedure TBaseWebDesignerFrame.actFormRenameContainerExecute(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
  NewCaption: string;
begin
  if not FStructLoaded then
    Exit;
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if not Assigned(NodeData) then
    Exit;

  case NodeData.Kind of

    nkFormGroup:
      begin
        var
        G := TBaseWebFormGroup(NodeData.ModelObject);
        NewCaption := IfThen(G.Caption.IsEmpty, G.GroupName, G.Caption);
        if not InputQuery('Rinomina group "' + G.GroupName + '"', 'Caption:', NewCaption) then
          Exit;
        G.Caption := Trim(NewCaption);
        G.Modified := True;
      end;

    nkFormTab:
      begin
        var
        T := TBaseWebFormTab(NodeData.ModelObject);
        NewCaption := IfThen(T.Caption.IsEmpty, T.TabName, T.Caption);
        if not InputQuery('Rinomina tab "' + T.TabName + '"', 'Caption:', NewCaption) then
          Exit;
        T.Caption := Trim(NewCaption);
        T.Modified := True;
      end;

    nkFormTabbed:
      begin
        { TBaseWebFormTabbed normalmente non ha Caption separata }
        MessageDlg('Il pannello tab non ha una caption modificabile separata.' + #13#10 + 'Il nome interno è "' + TBaseWebFormTabbed(NodeData.ModelObject).TabbedName + '".', mtInformation, [mbOK], 0);
        Exit;
      end;

  else
    Exit;
  end;

  SyncFormFromModel;
  ClearTree;
  BuildDatasetNode(FStruct);
end;

procedure TBaseWebDesignerFrame.actFormRenameContainerUpdate(Sender: TObject);
begin
  var
  NodeData := NodeDataOf(TreeList.FocusedNode);
  TAction(Sender).Enabled := FStructLoaded and Assigned(NodeData) and (NodeData.Kind in [nkFormGroup, nkFormTab, nkFormTabbed]);
  TAction(Sender).Visible := TAction(Sender).Enabled;
end;

procedure TBaseWebDesignerFrame.actTreeFormRenameContainerUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  TAction(Sender).Enabled := FStructLoaded and Assigned(NodeData) and (NodeData.Kind in [nkFormGroup, nkFormTab, nkFormTabbed]);
  TAction(Sender).Visible := TAction(Sender).Enabled;
end;

{ ===========================================================================
  actFormDeleteContainer
  =========================================================================== }
procedure TBaseWebDesignerFrame.actFormDeleteContainerExecute(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  if not FStructLoaded then
    Exit;
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if not Assigned(NodeData) then
    Exit;

  case NodeData.Kind of

    nkFormGroup:
      begin
        var
        G := TBaseWebFormGroup(NodeData.ModelObject);
        { Protezione: verifica che non ci siano campi/pulsanti/empty figli }
        for var FF in FStruct.FormFields do
          if SameText(FF.ContainerName, G.GroupName) then
          begin
            MessageDlg('Impossibile eliminare: il group "' + G.GroupName + '" contiene campi.', mtWarning, [mbOK], 0);
            Exit;
          end;
        for var FB in FStruct.FormButtons do
          if SameText(FB.ContainerName, G.GroupName) then
          begin
            MessageDlg('Impossibile eliminare: il group "' + G.GroupName + '" contiene pulsanti.', mtWarning, [mbOK], 0);
            Exit;
          end;
        for var FE in FStruct.FormEmpty do
          if SameText(FE.ContainerName, G.GroupName) then
          begin
            MessageDlg('Impossibile eliminare: il group "' + G.GroupName + '" contiene segnaposto.', mtWarning, [mbOK], 0);
            Exit;
          end;
        if MessageDlg('Eliminare il group "' + G.GroupName + '"?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
          Exit;
        FStruct.FormGroups.Remove(G);
      end;

    nkFormTab:
      begin
        var
        T := TBaseWebFormTab(NodeData.ModelObject);
        { Protezione: verifica che non ci siano group figli }
        for var G in FStruct.FormGroups do
          if SameText(G.ParentContainerName, T.TabName) then
          begin
            MessageDlg('Impossibile eliminare: il tab "' + T.TabName + '" contiene group.', mtWarning, [mbOK], 0);
            Exit;
          end;
        if MessageDlg('Eliminare il tab "' + T.TabName + '"?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
          Exit;
        FStruct.FormTabs.Remove(T);
      end;

    nkFormTabbed:
      begin
        var
        TC := TBaseWebFormTabbed(NodeData.ModelObject);
        { Protezione: verifica che non ci siano tab figli }
        for var T in FStruct.FormTabs do
          if SameText(T.TabbedName, TC.TabbedName) then
          begin
            MessageDlg('Impossibile eliminare: il pannello tab "' + TC.TabbedName + '" ha tab figli.', mtWarning, [mbOK], 0);
            Exit;
          end;
        if MessageDlg('Eliminare il pannello tab "' + TC.TabbedName + '"?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
          Exit;
        FStruct.FormTabbed.Remove(TC);
      end;

  else
    Exit;
  end;

  SyncFormFromModel;
  ClearTree;
  BuildDatasetNode(FStruct);
end;

procedure TBaseWebDesignerFrame.actFormDeleteContainerUpdate(Sender: TObject);
begin
  var
  NodeData := NodeDataOf(TreeList.FocusedNode);
  TAction(Sender).Enabled := FStructLoaded and Assigned(NodeData) and (NodeData.Kind in [nkFormGroup, nkFormTab, nkFormTabbed]);
  TAction(Sender).Visible := TAction(Sender).Enabled;
end;

procedure TBaseWebDesignerFrame.actTreeFormAddGroupExecute(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
  GroupName, Caption: string;
  NewGroup: TBaseWebFormGroup;
begin
  if not FStructLoaded then
    Exit;

  GroupName := 'GRP_' + FormatDateTime('hhnnss', Now);
  if not InputQuery('Nuovo group', 'Nome interno (univoco):', GroupName) then
    Exit;
  GroupName := Trim(GroupName);
  if GroupName = '' then
    Exit;

  for var G in FStruct.FormGroups do
    if SameText(G.GroupName, GroupName) then
    begin
      MessageDlg('GroupName "' + GroupName + '" già esistente.', mtWarning, [mbOK], 0);
      Exit;
    end;

  Caption := GroupName;
  InputQuery('Nuovo group', 'Caption (testo visibile):', Caption);

  NewGroup := CreateGroup(GroupName, Caption, FStruct.FormGroups.Count * 10);

  { Ricava il contenitore dal FocusedNode del tree }
  NodeData := NodeDataOf(TreeList.FocusedNode);
  if Assigned(NodeData) then
  begin
    { Risale al nkFormTab se siamo sul nodo [Custom] del tab }
    if (NodeData.Kind = nkFormTab) and Assigned(TreeList.FocusedNode.Parent) then
      NodeData := NodeDataOf(TreeList.FocusedNode.Parent);

    if NodeData.Kind = nkFormTab then
    begin
      NewGroup.ParentContainerName := TBaseWebFormTab(NodeData.ModelObject).TabName;
      NewGroup.ParentContainerType := 'tab';
    end
    else
    begin
      NewGroup.ParentContainerName := '';
      NewGroup.ParentContainerType := '';
    end;
  end
  else
  begin
    NewGroup.ParentContainerName := '';
    NewGroup.ParentContainerType := '';
  end;

  NewGroup.Modified := True;
  FStruct.FormGroups.Add(NewGroup);

  SyncFormFromModel;
  ClearTree;
  BuildDatasetNode(FStruct);
end;

procedure TBaseWebDesignerFrame.actTreeFormDeleteContainerUpdate(Sender: TObject);
var
  NodeData: TBaseWebNodeData;
begin
  NodeData := NodeDataOf(TreeList.FocusedNode);
  TAction(Sender).Enabled := FStructLoaded and Assigned(NodeData) and (NodeData.Kind in [nkFormGroup, nkFormTab, nkFormTabbed]);
  TAction(Sender).Visible := TAction(Sender).Enabled;
end;

function TBaseWebDesignerFrame.CreateGroup(const GroupName, Caption: string; SortOrder: Integer): TBaseWebFormGroup;
begin
  Result := TBaseWebFormGroup.Create;
  Result.GroupName := GroupName;
  Result.Caption := Caption.Trim;
  Result.Dataset := FStruct.Dataset.Dataset;
  Result.SortOrder := SortOrder;
  Result.Visible := True;
end;

function TBaseWebDesignerFrame.CreateTabbed(const TabbedName, TabsPos: string): TBaseWebFormTabbed;
begin
  Result := TBaseWebFormTabbed.Create;
  Result.TabbedName := TabbedName;
  Result.TabsPosition := TabsPos;
  Result.Dataset := FStruct.Dataset.Dataset;
  Result.Modified := True;
  FStruct.FormTabbed.Add(Result);
end;

procedure TBaseWebDesignerFrame.FormContainerSelected(Sender: TObject; AContainerKind: TBaseWebNodeKind; AContainerObj: TComponent);
var
  Node: TcxTreeListNode;
  NodeData: TBaseWebNodeData;
begin
  if not FStructLoaded or not Assigned(AContainerObj) then
    Exit;

  { 1 — Aggiorna l'Inspector }
  SelectObject(AContainerObj);

  { 2 — Sincronizza il TreeList }
  for var I := 0 to TreeList.AbsoluteCount - 1 do
  begin
    Node := TreeList.AbsoluteItems[I];
    NodeData := NodeDataOf(Node);
    if Assigned(NodeData) and (NodeData.Kind = AContainerKind) and (NodeData.ModelObject = AContainerObj) then
    begin
      TreeList.FocusedNode := Node;
      Node.MakeVisible;
      Break;
    end;
  end;
end;

procedure TBaseWebDesignerFrame.InspectorEdited(Sender: TObject; ARowProperties: TcxCustomEditorRowProperties);
var
  PropName: string;
  NeedFormRefresh: Boolean;
begin
  // OnEdited scatta dopo che il valore è già stato scritto sulla proprietà.
  // FSelectedObject è sempre l'oggetto sotto l'inspector in quel momento.
  if not Assigned(FSelectedObject) or not(FSelectedObject is TBaseWebComponent) then
    Exit;

  TBaseWebComponent(FSelectedObject).Modified := True;

  // Determina il nome della proprietà modificata
  NeedFormRefresh := False;
  PropName := '';
  if Assigned(ARowProperties) and Assigned(ARowProperties.Row) then
    PropName := ARowProperties.Row.Name;

  // Proprietà che impattano il layout della form preview
  if SameText(PropName, 'ColCount') or SameText(PropName, 'ColSpan') or SameText(PropName, 'FormColCount') or SameText(PropName, 'Visible') or SameText(PropName, 'LineBreak') or SameText(PropName, 'Caption') or SameText(PropName, 'FormLabelLoc') or
    SameText(PropName, 'FormLabelColon') then
    NeedFormRefresh := True;

  if NeedFormRefresh then
    SyncFormFromModel;
end;

procedure TBaseWebDesignerFrame.LayoutControlFormCustomization(Sender: TObject);
begin
  // Scatta ogni volta che l'editor DevExpress modifica la struttura del layout.
  // Ignora se siamo noi stessi a ricostruire il layout da modello.
  if FFormSyncing then
    Exit;

  if not FStructLoaded or not Assigned(FFormPreviewBuilder) then
    Exit;

  SyncModelFromLayout;
end;

procedure TBaseWebDesignerFrame.LayoutControlFormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  HT: TdxCustomLayoutHitTest;
  HitLayoutItem: TdxCustomLayoutItem;
  Candidate: TdxCustomLayoutItem;
  FieldName: string;
begin
  if Button <> mbLeft then
    Exit;

  if not FStructLoaded or not Assigned(FFormPreviewBuilder) then
    Exit;

  HT := LayoutControlForm.GetHitTest(X, Y);
  if not Assigned(HT) then
    Exit;

  HitLayoutItem := HT.Item;
  if not Assigned(HitLayoutItem) then
    Exit;

  { --- PRIORITÀ 1: se il click cade su un TdxLayoutItem registrato
    nell'ItemMap (= un campo del form), seleziona il campo --- }
  if HitLayoutItem is TdxLayoutItem then
  begin
    FieldName := FFormPreviewBuilder.GetFieldNameFromItem(TdxLayoutItem(HitLayoutItem));
    if FieldName <> '' then
    begin
      FormFieldSelected(Self, FieldName);
      Exit;
    end;
  end;

  { --- PRIORITÀ 2: risale la gerarchia cercando un gruppo/tab/tabbed --- }
  Candidate := HitLayoutItem;
  while Assigned(Candidate) do
  begin
    if Candidate is TdxLayoutGroup then
    begin
      { Cerca nelle FormGroups }
      for var Pair in FFormPreviewBuilder.GroupMap do
        if Pair.Value = TdxLayoutGroup(Candidate) then
        begin
          for var G in FStruct.FormGroups do
            if SameText(G.GroupName, Pair.Key) then
            begin
              FormContainerSelected(Self, nkFormGroup, G);
              Exit;
            end;
          { Non è un FormGroup: potrebbe essere un Tab nel TabMap }
          Break;
        end;

      { Cerca nel TabMap }
      for var T in FStruct.FormTabs do
        if FFormPreviewBuilder.TabMap.ContainsKey(T.TabName) and (FFormPreviewBuilder.TabMap[T.TabName] = TdxLayoutGroup(Candidate)) then
        begin
          FormContainerSelected(Self, nkFormTab, T);
          Exit;
        end;
    end;

    { Risale al parent }
    Candidate := Candidate.Parent;
  end;
end;

procedure TBaseWebDesignerFrame.SyncFormFromModel;
begin
  if not FStructLoaded then
    Exit;

  // Protezione: durante la rebuild del layout DX, OnCustomization
  // potrebbe scattare. Il flag impedisce il loop.
  FFormSyncing := True;
  try
    FFormPreviewBuilder.BuildFromStruct(FStruct);
  finally
    FFormSyncing := False;
  end;

  // HighlightField fuori da FFormSyncing ma protetto da FHighlighting
  if FFocusedFormField <> '' then
    HighlightFormField(FFocusedFormField);
end;

procedure TBaseWebDesignerFrame.SyncModelFromLayout;
begin
  FFormSyncing := True;
  try
    { ------------------------------------------------------------------
      FASE 1 — Azzera SortOrder, ContainerName e ContainerType di tutti
      gli elementi del modello che verranno ricalcolati dalla visita.
      ------------------------------------------------------------------ }
    for var FF in FStruct.FormFields do
    begin
      FF.ContainerName := '';
      FF.ContainerType := '';
      FF.SortOrder := 0;
      FF.Modified := True;
    end;
    for var FB in FStruct.FormButtons do
    begin
      FB.ContainerName := '';
      FB.ContainerType := '';
      FB.SortOrder := 0;
      FB.Modified := True;
    end;
    for var FE in FStruct.FormEmpty do
    begin
      FE.ContainerName := '';
      FE.ContainerType := '';
      FE.SortOrder := 0;
      FE.Modified := True;
    end;
    for var G in FStruct.FormGroups do
    begin
      G.ParentContainerName := '';
      G.ParentContainerType := '';
      G.SortOrder := 0;
      G.Modified := True;
    end;
    for var T in FStruct.FormTabs do
    begin
      T.TabbedName := '';
      T.ParentContainerName := '';
      T.ParentContainerType := '';
      T.SortOrder := 0;
      T.Modified := True;
    end;

    { ------------------------------------------------------------------
      FASE 2 — Visita ricorsiva della gerarchia live del LayoutControl.
      ------------------------------------------------------------------ }
    var
    RootSortOrder := 0;
    VisitGroupForSync(LayoutControlForm.Container.Root, '', RootSortOrder);

    { ------------------------------------------------------------------
      FASE 3 — Ricostruisce TreeList per rispecchiare il modello aggiornato.
      ------------------------------------------------------------------ }
    ClearTree;
    BuildDatasetNode(FStruct);

  finally
    FFormSyncing := False;
  end;
end;

function TBaseWebDesignerFrame.ResolveGroupName(ALayoutGroup: TdxLayoutGroup): string;
begin
  Result := '';

  // Cerca in FGroupMap (FormGroup del modello)
  for var Pair in FFormPreviewBuilder.GroupMap do
    if Pair.Value = ALayoutGroup then
      Exit(Pair.Key);

  // Cerca in FTabMap tramite Tag (TBaseWebFormTab → TabName)
  if (ALayoutGroup.Tag <> 0) then
  begin
    var
    ModelObj := TComponent(Pointer(ALayoutGroup.Tag));
    if ModelObj is TBaseWebFormTab then
      Exit(TBaseWebFormTab(ModelObj).TabName);
    if ModelObj is TBaseWebFormTabbed then
      Exit(TBaseWebFormTabbed(ModelObj).TabbedName);
    if ModelObj is TBaseWebFormGroup then
      Exit(TBaseWebFormGroup(ModelObj).GroupName);
  end;
end;

procedure TBaseWebDesignerFrame.VisitGroupForSync(ALayoutGroup: TdxLayoutGroup; const AOwnerGroupName: string; var ASortOrderInGroup: Integer);

{ ── helper: assegna ContainerName e ContainerType a un field/button/empty ── }
  procedure AssignItem(const AFieldName, AContainerName, AContainerType: string; var ASortOrder: Integer);
  begin
    for var FF in FStruct.FormFields do
      if SameText(FF.Field, AFieldName) then
      begin
        if AContainerName = '' then
        begin
          FF.ContainerName := '';
          FF.ContainerType := '';
        end
        else
        begin
          FF.ContainerName := AContainerName;
          FF.ContainerType := AContainerType;
        end;
        FF.SortOrder := ASortOrder * 10;
        FF.Modified := True;
        Inc(ASortOrder);
        Exit;
      end;
    for var FB in FStruct.FormButtons do
      if SameText(FB.ButtonName, AFieldName) then
      begin
        if AContainerName = '' then
        begin
          FB.ContainerName := '';
          FB.ContainerType := '';
        end
        else
        begin
          FB.ContainerName := AContainerName;
          FB.ContainerType := AContainerType;
        end;
        FB.SortOrder := ASortOrder * 10;
        FB.Modified := True;
        Inc(ASortOrder);
        Exit;
      end;
    for var FE in FStruct.FormEmpty do
      if SameText(FE.EmptyName, AFieldName) then
      begin
        if AContainerName = '' then
        begin
          FE.ContainerName := '';
          FE.ContainerType := '';
        end
        else
        begin
          FE.ContainerName := AContainerName;
          FE.ContainerType := AContainerType;
        end;
        FE.SortOrder := ASortOrder * 10;
        FE.Modified := True;
        Inc(ASortOrder);
        Exit;
      end;
  end;

{ ── helper: nome univoco tra una lista di stringhe ──────────────────── }
  function UniqueNameIn(const ABase: string; AExists: TFunc<string, Boolean>): string;
  var
    Counter: Integer;
  begin
    Result := ABase;
    Counter := 1;
    while AExists(Result) do
    begin
      Result := ABase + '_' + IntToStr(Counter);
      Inc(Counter);
    end;
  end;

{ ── helper: dato un ContainerName, determina il ContainerType ──────── }
  function ResolveContainerType(const AContainerName: string): string;
  begin
    // Ordine: cerca tra i gruppi, poi tra i tab, poi tra i tabbed
    if AContainerName = '' then
      Exit('');
    for var G in FStruct.FormGroups do
      if SameText(G.GroupName, AContainerName) then
        Exit('group');
    for var T in FStruct.FormTabs do
      if SameText(T.TabName, AContainerName) then
        Exit('tab');
    for var TB in FStruct.FormTabbed do
      if SameText(TB.TabbedName, AContainerName) then
        Exit('tabbed');
    Result := '';
  end;

{ ── helper: imposta ContainerName/ContainerType su un FormGroup ──────── }
  procedure SetGroupContainer(G: TBaseWebFormGroup; const AOwner: string);
  begin
    if AOwner = '' then
    begin
      G.ParentContainerName := '';
      G.ParentContainerType := '';
    end
    else
    begin
      G.ParentContainerName := AOwner;
      G.ParentContainerType := ResolveContainerType(AOwner);
    end;
  end;

{ ── CASO A — RowGroup anonimo oppure Root ────────────────────────────── }
  procedure HandleCaseA;
  var
    OwnerType: string;
  begin
    OwnerType := ResolveContainerType(AOwnerGroupName);
    for var I := 0 to ALayoutGroup.Count - 1 do
    begin
      var
      Child := ALayoutGroup.Items[I];
      if Child is TdxLayoutGroup then
      begin
        // Root e RowGroup: i figli gruppo vengono visitati con lo stesso
        // AOwnerGroupName (non crea un contenitore intermedio)
        VisitGroupForSync(TdxLayoutGroup(Child), AOwnerGroupName, ASortOrderInGroup);
        Continue;
      end;
      if Child is TdxLayoutItem then
      begin
        var
        FieldName := FFormPreviewBuilder.GetFieldNameFromItem(TdxLayoutItem(Child));
        if FieldName <> '' then
          AssignItem(FieldName, AOwnerGroupName, OwnerType, ASortOrderInGroup);
      end;
    end;
  end;

{ ── CASO B — FormGroup esistente ────────────────────────────────────── }
  procedure HandleCaseB(G: TBaseWebFormGroup);
  var
    ChildSortOrder: Integer;
  begin
    G.SortOrder := ASortOrderInGroup * 10;
    Inc(ASortOrderInGroup);
    SetGroupContainer(G, AOwnerGroupName);
    G.Modified := True;
    FFormPreviewBuilder.GroupMap.AddOrSetValue(G.GroupName, ALayoutGroup);

    ChildSortOrder := 0;
    for var I := 0 to ALayoutGroup.Count - 1 do
    begin
      var
      Child := ALayoutGroup.Items[I];
      if Child is TdxLayoutGroup then
        VisitGroupForSync(TdxLayoutGroup(Child), G.GroupName, ChildSortOrder)
      else
        if Child is TdxLayoutItem then
        begin
          var
          FieldName := FFormPreviewBuilder.GetFieldNameFromItem(TdxLayoutItem(Child));
          if FieldName <> '' then
            AssignItem(FieldName, G.GroupName, 'GROUP', ChildSortOrder);
        end;
    end;
  end;

{ ── CASO C — FormTab esistente ──────────────────────────────────────── }
  procedure HandleCaseC(T: TBaseWebFormTab);
  var
    ChildSortOrder: Integer;
  begin
    T.SortOrder := ASortOrderInGroup * 10;
    Inc(ASortOrderInGroup);
    if AOwnerGroupName = '' then
    begin
      T.TabbedName := '';
      T.ParentContainerName := '';
      T.ParentContainerType := '';
    end
    else
    begin
      T.TabbedName := AOwnerGroupName;
      T.ParentContainerName := AOwnerGroupName;
      T.ParentContainerType := 'tabbed';
    end;

    T.Modified := True;
    FFormPreviewBuilder.TabMap.AddOrSetValue(T.TabName, ALayoutGroup);

    ChildSortOrder := 0;
    for var I := 0 to ALayoutGroup.Count - 1 do
    begin
      var
      Child := ALayoutGroup.Items[I];
      if Child is TdxLayoutGroup then
        VisitGroupForSync(TdxLayoutGroup(Child), T.TabName, ChildSortOrder);
    end;
  end;

{ ── CASO D — FormTabbed esistente ───────────────────────────────────── }
  procedure HandleCaseD(TC: TBaseWebFormTabbed);
  var
    ChildSortOrder: Integer;
  begin
    Inc(ASortOrderInGroup);
    ChildSortOrder := 0;
    for var I := 0 to ALayoutGroup.Count - 1 do
    begin
      var
      Child := ALayoutGroup.Items[I];
      if Child is TdxLayoutGroup then
        VisitGroupForSync(TdxLayoutGroup(Child), TC.TabbedName, ChildSortOrder);
    end;
  end;

{ ── CASO E1 — nuovo Tabbed (ldTabbed, nessun Tag) ───────────────────── }
  procedure HandleCaseE1;
  var
    NewContainerName: string;
    NewTabbed: TBaseWebFormTabbed;
    TabSortOrder, ChildSortOrder: Integer;
  begin
    NewContainerName := Trim(ALayoutGroup.CaptionOptions.Text);
    if NewContainerName = '' then
      NewContainerName := 'TABS_' + FormatDateTime('hhnnsszzz', Now);
    NewContainerName := UniqueNameIn(NewContainerName,
      function(N: string): Boolean
      begin
        for var TC in FStruct.FormTabbed do
          if SameText(TC.TabbedName, N) then
            Exit(True);
        Result := False;
      end);

    NewTabbed := TBaseWebFormTabbed.Create;
    NewTabbed.Dataset := FStruct.Dataset.Dataset;
    NewTabbed.TabbedName := NewContainerName;
    NewTabbed.TabsPosition := 'top';
    NewTabbed.Modified := True;
    FStruct.FormTabbed.Add(NewTabbed);
    ALayoutGroup.Tag := NativeInt(NewTabbed);
    Inc(ASortOrderInGroup);

    TabSortOrder := 0;
    for var I := 0 to ALayoutGroup.Count - 1 do
    begin
      var
      Child := ALayoutGroup.Items[I];
      if not(Child is TdxLayoutGroup) then
        Continue;
      var
      ChildGroup := TdxLayoutGroup(Child);

      if ChildGroup.Tag <> 0 then
      begin
        // Tab preesistente: aggiorna tramite visita normale
        VisitGroupForSync(ChildGroup, NewContainerName, TabSortOrder);
        Continue;
      end;

      // Nuovo tab senza Tag
      var
      NewTabName := Trim(ChildGroup.CaptionOptions.Text);
      if NewTabName = '' then
        NewTabName := 'TAB_' + FormatDateTime('hhnnsszzz', Now);
      NewTabName := UniqueNameIn(NewTabName,
        function(N: string): Boolean
        begin
          for var T in FStruct.FormTabs do
            if SameText(T.TabName, N) then
              Exit(True);
          Result := False;
        end);

      var
      NewTab := TBaseWebFormTab.Create;
      NewTab.Dataset := FStruct.Dataset.Dataset;
      NewTab.TabName := NewTabName;
      NewTab.Caption := Trim(ChildGroup.CaptionOptions.Text);
      NewTab.TabbedName := NewContainerName;
      NewTab.ParentContainerName := NewContainerName;
      NewTab.ParentContainerType := 'tabbed';
      NewTab.SortOrder := TabSortOrder * 10;
      NewTab.Modified := True;
      FStruct.FormTabs.Add(NewTab);
      ChildGroup.Tag := NativeInt(NewTab);
      FFormPreviewBuilder.TabMap.AddOrSetValue(NewTabName, ChildGroup);
      Inc(TabSortOrder);

      ChildSortOrder := 0;
      for var J := 0 to ChildGroup.Count - 1 do
      begin
        var
        GrandChild := ChildGroup.Items[J];
        if GrandChild is TdxLayoutGroup then
          VisitGroupForSync(TdxLayoutGroup(GrandChild), NewTabName, ChildSortOrder);
      end;
    end;
  end;

{ ── CASO E2 — nuovo FormGroup (ldVertical o altro, nessun Tag) ──────── }
  procedure HandleCaseE2;
  var
    NewGroupName: string;
    NewGroup: TBaseWebFormGroup;
    ChildSortOrder: Integer;
  begin
    NewGroupName := Trim(ALayoutGroup.CaptionOptions.Text);
    if NewGroupName = '' then
      NewGroupName := 'GRP_' + FormatDateTime('hhnnsszzz', Now);
    NewGroupName := UniqueNameIn(NewGroupName,
      function(N: string): Boolean
      begin
        for var G in FStruct.FormGroups do
          if SameText(G.GroupName, N) then
            Exit(True);
        Result := False;
      end);

    NewGroup := CreateGroup(NewGroupName, Trim(ALayoutGroup.CaptionOptions.Text), ASortOrderInGroup * 10);
    Inc(ASortOrderInGroup);
    SetGroupContainer(NewGroup, AOwnerGroupName);
    NewGroup.Modified := True;
    FStruct.FormGroups.Add(NewGroup);
    ALayoutGroup.Tag := NativeInt(NewGroup);
    FFormPreviewBuilder.GroupMap.AddOrSetValue(NewGroupName, ALayoutGroup);

    ChildSortOrder := 0;
    for var I := 0 to ALayoutGroup.Count - 1 do
    begin
      var
      Child := ALayoutGroup.Items[I];
      if Child is TdxLayoutGroup then
        VisitGroupForSync(TdxLayoutGroup(Child), NewGroupName, ChildSortOrder)
      else
        if Child is TdxLayoutItem then
        begin
          var
          FieldName := FFormPreviewBuilder.GetFieldNameFromItem(TdxLayoutItem(Child));
          if FieldName <> '' then
            AssignItem(FieldName, NewGroupName, 'GROUP', ChildSortOrder);
        end;
    end;
  end;

{ ── corpo principale ─────────────────────────────────────────────────── }
var
  ModelObj: TComponent;
begin
  ModelObj := nil;
  if ALayoutGroup.Tag <> 0 then
    ModelObj := TComponent(Pointer(ALayoutGroup.Tag));

  // CASO A: Root, RowGroup anonimo (ldHorizontal senza bordo), o Tag=nil senza
  // direzione specifica → non crea un contenitore, propaga AOwnerGroupName
  if (ModelObj = nil) and (ALayoutGroup.IsRoot or ((ALayoutGroup.LayoutDirection = ldHorizontal) and not ALayoutGroup.ShowBorder)) then
  begin
    HandleCaseA;
    Exit;
  end;

  if (ModelObj <> nil) and (ModelObj is TBaseWebFormGroup) then
  begin
    HandleCaseB(TBaseWebFormGroup(ModelObj));
    Exit;
  end;
  if (ModelObj <> nil) and (ModelObj is TBaseWebFormTab) then
  begin
    HandleCaseC(TBaseWebFormTab(ModelObj));
    Exit;
  end;
  if (ModelObj <> nil) and (ModelObj is TBaseWebFormTabbed) then
  begin
    HandleCaseD(TBaseWebFormTabbed(ModelObj));
    Exit;
  end;

  // CASO E: nessun Tag — nuovo elemento creato dall'editor DX
  if ModelObj = nil then
  begin
    if ALayoutGroup.LayoutDirection = ldTabbed then
      HandleCaseE1
    else
      HandleCaseE2;
  end;
end;

procedure TBaseWebDesignerFrame.LayoutControlFormContainerChanged(Sender: TObject);
begin
  if FFormSyncing then
    Exit;

  if FHighlighting then
    Exit; // ← highlight in corso, non attivare il timer

  if not FStructLoaded or not Assigned(FFormPreviewBuilder) then
    Exit;

  if not Assigned(FSyncTimer) then
    Exit;

  if not LayoutControlForm.Customization then
    Exit;

  FSyncTimer.Enabled := False;
  FSyncTimer.Enabled := True;
end;

procedure TBaseWebDesignerFrame.SyncTimerFired(Sender: TObject);
begin
  FSyncTimer.Enabled := False; // one-shot: si ferma dopo il primo scatto
  SyncModelFromLayout;
end;

// Helper privato per chiamare HighlightField senza attivare il timer
procedure TBaseWebDesignerFrame.HighlightFormField(const AFieldName: string);
begin
  if not Assigned(FFormPreviewBuilder) then
    Exit;
  FHighlighting := True;
  try
    FFormPreviewBuilder.HighlightField(AFieldName);
    LayoutControlForm.InvalidateWithChildren;
  finally
    FHighlighting := False;
  end;
end;

procedure TBaseWebDesignerFrame.ClearFormHighlight;
begin
  if not Assigned(FFormPreviewBuilder) then
    Exit;
  FHighlighting := True;
  try
    FFormPreviewBuilder.ClearHighlight;
    LayoutControlForm.InvalidateWithChildren;
  finally
    FHighlighting := False;
  end;
end;

procedure TBaseWebDesignerFrame.WMSelectFieldNode(var Msg: TMessage);
var
  Node: TcxTreeListNode;
  NodeData: TBaseWebNodeData;
  NodeKey: string;
begin
  if FFocusedFieldForSelection = '' then
    Exit;

  for var I := 0 to TreeList.AbsoluteCount - 1 do
  begin
    Node := TreeList.AbsoluteItems[I];
    NodeData := NodeDataOf(Node);
    if not Assigned(NodeData) or not Assigned(NodeData.ModelObject) then
      Continue;

    NodeKey := '';
    case NodeData.Kind of
      nkFormField:  NodeKey := TBaseWebFormField(NodeData.ModelObject).Field;
      nkFormButton: NodeKey := TBaseWebFormButton(NodeData.ModelObject).ButtonName;
      nkFormEmpty:  NodeKey := TBaseWebFormEmpty(NodeData.ModelObject).EmptyName;
    end;

    if SameText(NodeKey, FFocusedFieldForSelection) then
    begin
      TreeList.FocusedNode := Node;
      Node.MakeVisible;
      Break;
    end;
  end;

  FFocusedFieldForSelection := '';
end;
end.

  actFormAddTab,
