unit DevExtreme.TreeView;

interface

uses
  System.SysUtils,
  System.Classes,
  WEBLib.Controls,
  jsdelphisystem,
  JS,
  Web,
  libjquery,
  DevExtreme.CustomControl,
  DevExtreme.Types;

type
  [ComponentPlatforms(TMSWebPlatform)]
  TjdxTreeView = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FanimationEnabled: boolean;
    FcollapseIcon: JSValue;
    FcreateChildren: TJSFunction;
    FdataSource: JSValue;
    FdataStructure: TdxDataStructure;
    Fdisabled: boolean;
    FdisabledExpr: JSValue;
    FdisplayExpr: JSValue;
    FelementAttr: TJSObject;
    FexpandAllEnabled: boolean;
    FexpandedExpr: JSValue;
    FexpandEvent: TdxTreeViewExpandEvent;
    FexpandIcon: JSValue;
    FexpandNodesRecursive: boolean;
    FfocusedElement: TJSElement;
    FfocusStateEnabled: boolean;
    FhasItemsExpr: JSValue;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FitemHoldTimeout: integer;
    Fitems: TJSArray;
    FitemsExpr: JSValue;
    FitemTemplate: JSValue;
    FkeyExpr: JSValue;
    FloopItemFocus: boolean;
    FnoDataText: string;
    FparentIdExpr: JSValue;
    FrootValue: JSValue;
    FrtlEnabled: boolean;
    FscrollDirection: TdxScrollDirection;
    FsearchEditorOptions: JSValue;
    FsearchEnabled: boolean;
    FsearchExpr: JSValue;
    FsearchMode: TdxSearchMode;
    FsearchTimeout: integer;
    FsearchValue: string;
    FselectAllText: string;
    FselectByClick: boolean;
    FselectedExpr: JSValue;
    FselectedIndex: integer;
    FselectedItem: JSValue;
    FselectedItemKeys: TJSArray;
    FselectedItems: TJSArray;
    FselectionByClick: boolean;
    FselectionMode: TCollectionWidgetSelectionMode;
    FselectionRequired: boolean;
    FselectNodesRecursive: boolean;
    FselectOnFocus: boolean;
    FshowCheckBoxesMode: TdxTreeViewCheckBoxMode;
    FtabIndex: integer;
    FuseNativeScrolling: boolean;
    FvirtualModeEnabled: boolean;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonItemClick: TdxEventHandler;
    FonItemCollapsed: TdxEventHandler;
    FonItemContextMenu: TdxEventHandler;
    FonItemDeleted: TdxEventHandler;
    FonItemDeleting: TdxEventHandler;
    FonItemExpanded: TdxEventHandler;
    FonItemHold: TdxEventHandler;
    FonItemRendered: TdxEventHandler;
    FonItemReordered: TdxEventHandler;
    FonItemSelectionChanged: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonSelectAllValueChanged: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_animationEnabled(const value: boolean);
    procedure Set_collapseIcon(const value: JSValue);
    procedure Set_createChildren(const value: TJSFunction);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_dataStructure(const value: TdxDataStructure);
    procedure Set_disabled(const value: boolean);
    procedure Set_disabledExpr(const value: JSValue);
    procedure Set_displayExpr(const value: JSValue);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_expandAllEnabled(const value: boolean);
    procedure Set_expandedExpr(const value: JSValue);
    procedure Set_expandEvent(const value: TdxTreeViewExpandEvent);
    procedure Set_expandIcon(const value: JSValue);
    procedure Set_expandNodesRecursive(const value: boolean);
    procedure Set_focusedElement(const value: TJSElement);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_hasItemsExpr(const value: JSValue);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_itemHoldTimeout(const value: integer);
    procedure Set_items(const value: TJSArray);
    procedure Set_itemsExpr(const value: JSValue);
    procedure Set_itemTemplate(const value: JSValue);
    procedure Set_keyExpr(const value: JSValue);
    procedure Set_loopItemFocus(const value: boolean);
    procedure Set_noDataText(const value: string);
    procedure Set_parentIdExpr(const value: JSValue);
    procedure Set_rootValue(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scrollDirection(const value: TdxScrollDirection);
    procedure Set_searchEditorOptions(const value: JSValue);
    procedure Set_searchEnabled(const value: boolean);
    procedure Set_searchExpr(const value: JSValue);
    procedure Set_searchMode(const value: TdxSearchMode);
    procedure Set_searchTimeout(const value: integer);
    procedure Set_searchValue(const value: string);
    procedure Set_selectAllText(const value: string);
    procedure Set_selectByClick(const value: boolean);
    procedure Set_selectedExpr(const value: JSValue);
    procedure Set_selectedIndex(const value: integer);
    procedure Set_selectedItem(const value: JSValue);
    procedure Set_selectedItemKeys(const value: TJSArray);
    procedure Set_selectedItems(const value: TJSArray);
    procedure Set_selectionByClick(const value: boolean);
    procedure Set_selectionMode(const value: TCollectionWidgetSelectionMode);
    procedure Set_selectionRequired(const value: boolean);
    procedure Set_selectNodesRecursive(const value: boolean);
    procedure Set_selectOnFocus(const value: boolean);
    procedure Set_showCheckBoxesMode(const value: TdxTreeViewCheckBoxMode);
    procedure Set_tabIndex(const value: integer);
    procedure Set_useNativeScrolling(const value: boolean);
    procedure Set_virtualModeEnabled(const value: boolean);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onItemClick(const value: TdxEventHandler);
    procedure Set_onItemCollapsed(const value: TdxEventHandler);
    procedure Set_onItemContextMenu(const value: TdxEventHandler);
    procedure Set_onItemDeleted(const value: TdxEventHandler);
    procedure Set_onItemDeleting(const value: TdxEventHandler);
    procedure Set_onItemExpanded(const value: TdxEventHandler);
    procedure Set_onItemHold(const value: TdxEventHandler);
    procedure Set_onItemRendered(const value: TdxEventHandler);
    procedure Set_onItemReordered(const value: TdxEventHandler);
    procedure Set_onItemSelectionChanged(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onSelectAllValueChanged(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property collapseIcon: JSValue read FcollapseIcon write Set_collapseIcon;
    property createChildren: TJSFunction read FcreateChildren write Set_createChildren;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property disabledExpr: JSValue read FdisabledExpr write Set_disabledExpr;
    property displayExpr: JSValue read FdisplayExpr write Set_displayExpr;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property expandedExpr: JSValue read FexpandedExpr write Set_expandedExpr;
    property expandIcon: JSValue read FexpandIcon write Set_expandIcon;
    property focusedElement: TJSElement read FfocusedElement write Set_focusedElement;
    property hasItemsExpr: JSValue read FhasItemsExpr write Set_hasItemsExpr;
    property height_: JSValue read Fheight_ write Set_height_;
    property items: TJSArray read Fitems write Set_items;
    property itemsExpr: JSValue read FitemsExpr write Set_itemsExpr;
    property itemTemplate: JSValue read FitemTemplate write Set_itemTemplate;
    property keyExpr: JSValue read FkeyExpr write Set_keyExpr;
    property parentIdExpr: JSValue read FparentIdExpr write Set_parentIdExpr;
    property rootValue: JSValue read FrootValue write Set_rootValue;
    property searchEditorOptions: JSValue read FsearchEditorOptions write Set_searchEditorOptions;
    property searchExpr: JSValue read FsearchExpr write Set_searchExpr;
    property selectedExpr: JSValue read FselectedExpr write Set_selectedExpr;
    property selectedItem: JSValue read FselectedItem write Set_selectedItem;
    property selectedItemKeys: TJSArray read FselectedItemKeys write Set_selectedItemKeys;
    property selectedItems: TJSArray read FselectedItems write Set_selectedItems;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property animationEnabled: boolean read FanimationEnabled write Set_animationEnabled default true;
    property dataStructure: TdxDataStructure read FdataStructure write Set_dataStructure default dsTree;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property expandAllEnabled: boolean read FexpandAllEnabled write Set_expandAllEnabled default false;
    property expandEvent: TdxTreeViewExpandEvent read FexpandEvent write Set_expandEvent default tveeDblclick;
    property expandNodesRecursive: boolean read FexpandNodesRecursive write Set_expandNodesRecursive default true;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property itemHoldTimeout: integer read FitemHoldTimeout write Set_itemHoldTimeout;
    property loopItemFocus: boolean read FloopItemFocus write Set_loopItemFocus;
    property noDataText: string read FnoDataText write Set_noDataText;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property scrollDirection: TdxScrollDirection read FscrollDirection write Set_scrollDirection default sdVertical;
    property searchEnabled: boolean read FsearchEnabled write Set_searchEnabled default false;
    property searchMode: TdxSearchMode read FsearchMode write Set_searchMode default smContains;
    property searchTimeout: integer read FsearchTimeout write Set_searchTimeout;
    property searchValue: string read FsearchValue write Set_searchValue;
    property selectAllText: string read FselectAllText write Set_selectAllText;
    property selectByClick: boolean read FselectByClick write Set_selectByClick default false;
    property selectedIndex: integer read FselectedIndex write Set_selectedIndex;
    property selectionByClick: boolean read FselectionByClick write Set_selectionByClick default true;
    property selectionMode: TCollectionWidgetSelectionMode read FselectionMode write Set_selectionMode default cwsmNone;
    property selectionRequired: boolean read FselectionRequired write Set_selectionRequired default false;
    property selectNodesRecursive: boolean read FselectNodesRecursive write Set_selectNodesRecursive default true;
    property selectOnFocus: boolean read FselectOnFocus write Set_selectOnFocus;
    property showCheckBoxesMode: TdxTreeViewCheckBoxMode read FshowCheckBoxesMode write Set_showCheckBoxesMode default tvcbmNone;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property useNativeScrolling: boolean read FuseNativeScrolling write Set_useNativeScrolling;
    property virtualModeEnabled: boolean read FvirtualModeEnabled write Set_virtualModeEnabled default false;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onItemClick: TdxEventHandler read FonItemClick write Set_onItemClick;
    property onItemCollapsed: TdxEventHandler read FonItemCollapsed write Set_onItemCollapsed;
    property onItemContextMenu: TdxEventHandler read FonItemContextMenu write Set_onItemContextMenu;
    property onItemDeleted: TdxEventHandler read FonItemDeleted write Set_onItemDeleted;
    property onItemDeleting: TdxEventHandler read FonItemDeleting write Set_onItemDeleting;
    property onItemExpanded: TdxEventHandler read FonItemExpanded write Set_onItemExpanded;
    property onItemHold: TdxEventHandler read FonItemHold write Set_onItemHold;
    property onItemRendered: TdxEventHandler read FonItemRendered write Set_onItemRendered;
    property onItemReordered: TdxEventHandler read FonItemReordered write Set_onItemReordered;
    property onItemSelectionChanged: TdxEventHandler read FonItemSelectionChanged write Set_onItemSelectionChanged;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onSelectAllValueChanged: TdxEventHandler read FonSelectAllValueChanged write Set_onSelectAllValueChanged;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
  end;

implementation


constructor TjdxTreeView.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FanimationEnabled := true;
  FcollapseIcon := nil;
  FcreateChildren := nil;
  FdataSource := nil;
  FdataStructure := dsTree;
  Fdisabled := false;
  FdisabledExpr := nil;
  FdisplayExpr := nil;
  FelementAttr := TJSObject.new;
  FexpandAllEnabled := false;
  FexpandedExpr := nil;
  FexpandEvent := tveeDblclick;
  FexpandIcon := nil;
  FexpandNodesRecursive := true;
  FfocusedElement := nil;
  FfocusStateEnabled := false;
  FhasItemsExpr := nil;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FitemHoldTimeout := 0;
  Fitems := TJSArray.new;
  FitemsExpr := nil;
  FitemTemplate := nil;
  FkeyExpr := nil;
  FloopItemFocus := false;
  FnoDataText := '';
  FparentIdExpr := nil;
  FrootValue := nil;
  FrtlEnabled := false;
  FscrollDirection := sdVertical;
  FsearchEditorOptions := nil;
  FsearchEnabled := false;
  FsearchExpr := nil;
  FsearchMode := smContains;
  FsearchTimeout := 0;
  FsearchValue := '';
  FselectAllText := '';
  FselectByClick := false;
  FselectedExpr := nil;
  FselectedIndex := 0;
  FselectedItem := nil;
  FselectedItemKeys := TJSArray.new;
  FselectedItems := TJSArray.new;
  FselectionByClick := true;
  FselectionMode := cwsmNone;
  FselectionRequired := false;
  FselectNodesRecursive := true;
  FselectOnFocus := false;
  FshowCheckBoxesMode := tvcbmNone;
  FtabIndex := 0;
  FuseNativeScrolling := false;
  FvirtualModeEnabled := false;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonItemClick := nil;
  FonItemCollapsed := nil;
  FonItemContextMenu := nil;
  FonItemDeleted := nil;
  FonItemDeleting := nil;
  FonItemExpanded := nil;
  FonItemHold := nil;
  FonItemRendered := nil;
  FonItemReordered := nil;
  FonItemSelectionChanged := nil;
  FonOptionChanged := nil;
  FonSelectAllValueChanged := nil;
  FonSelectionChanged := nil;
end;

procedure TjdxTreeView.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxTreeView.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxTreeView.Set_animationEnabled(const Value: boolean);
begin
  FanimationEnabled := Value;
end;

procedure TjdxTreeView.Set_collapseIcon(const Value: JSValue);
begin
  FcollapseIcon := Value;
end;

procedure TjdxTreeView.Set_createChildren(const Value: TJSFunction);
begin
  FcreateChildren := Value;
end;

procedure TjdxTreeView.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxTreeView.Set_dataStructure(const Value: TdxDataStructure);
begin
  FdataStructure := Value;
end;

procedure TjdxTreeView.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxTreeView.Set_disabledExpr(const Value: JSValue);
begin
  FdisabledExpr := Value;
end;

procedure TjdxTreeView.Set_displayExpr(const Value: JSValue);
begin
  FdisplayExpr := Value;
end;

procedure TjdxTreeView.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxTreeView.Set_expandAllEnabled(const Value: boolean);
begin
  FexpandAllEnabled := Value;
end;

procedure TjdxTreeView.Set_expandedExpr(const Value: JSValue);
begin
  FexpandedExpr := Value;
end;

procedure TjdxTreeView.Set_expandEvent(const Value: TdxTreeViewExpandEvent);
begin
  FexpandEvent := Value;
end;

procedure TjdxTreeView.Set_expandIcon(const Value: JSValue);
begin
  FexpandIcon := Value;
end;

procedure TjdxTreeView.Set_expandNodesRecursive(const Value: boolean);
begin
  FexpandNodesRecursive := Value;
end;

procedure TjdxTreeView.Set_focusedElement(const Value: TJSElement);
begin
  FfocusedElement := Value;
end;

procedure TjdxTreeView.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxTreeView.Set_hasItemsExpr(const Value: JSValue);
begin
  FhasItemsExpr := Value;
end;

procedure TjdxTreeView.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxTreeView.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxTreeView.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxTreeView.Set_itemHoldTimeout(const Value: integer);
begin
  FitemHoldTimeout := Value;
end;

procedure TjdxTreeView.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
end;

procedure TjdxTreeView.Set_itemsExpr(const Value: JSValue);
begin
  FitemsExpr := Value;
end;

procedure TjdxTreeView.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
end;

procedure TjdxTreeView.Set_keyExpr(const Value: JSValue);
begin
  FkeyExpr := Value;
end;

procedure TjdxTreeView.Set_loopItemFocus(const Value: boolean);
begin
  FloopItemFocus := Value;
end;

procedure TjdxTreeView.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
end;

procedure TjdxTreeView.Set_parentIdExpr(const Value: JSValue);
begin
  FparentIdExpr := Value;
end;

procedure TjdxTreeView.Set_rootValue(const Value: JSValue);
begin
  FrootValue := Value;
end;

procedure TjdxTreeView.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxTreeView.Set_scrollDirection(const Value: TdxScrollDirection);
begin
  FscrollDirection := Value;
end;

procedure TjdxTreeView.Set_searchEditorOptions(const Value: JSValue);
begin
  FsearchEditorOptions := Value;
end;

procedure TjdxTreeView.Set_searchEnabled(const Value: boolean);
begin
  FsearchEnabled := Value;
end;

procedure TjdxTreeView.Set_searchExpr(const Value: JSValue);
begin
  FsearchExpr := Value;
end;

procedure TjdxTreeView.Set_searchMode(const Value: TdxSearchMode);
begin
  FsearchMode := Value;
end;

procedure TjdxTreeView.Set_searchTimeout(const Value: integer);
begin
  FsearchTimeout := Value;
end;

procedure TjdxTreeView.Set_searchValue(const Value: string);
begin
  FsearchValue := Value;
end;

procedure TjdxTreeView.Set_selectAllText(const Value: string);
begin
  FselectAllText := Value;
end;

procedure TjdxTreeView.Set_selectByClick(const Value: boolean);
begin
  FselectByClick := Value;
end;

procedure TjdxTreeView.Set_selectedExpr(const Value: JSValue);
begin
  FselectedExpr := Value;
end;

procedure TjdxTreeView.Set_selectedIndex(const Value: integer);
begin
  FselectedIndex := Value;
end;

procedure TjdxTreeView.Set_selectedItem(const Value: JSValue);
begin
  FselectedItem := Value;
end;

procedure TjdxTreeView.Set_selectedItemKeys(const Value: TJSArray);
begin
  FselectedItemKeys := Value;
end;

procedure TjdxTreeView.Set_selectedItems(const Value: TJSArray);
begin
  FselectedItems := Value;
end;

procedure TjdxTreeView.Set_selectionByClick(const Value: boolean);
begin
  FselectionByClick := Value;
end;

procedure TjdxTreeView.Set_selectionMode(const Value: TCollectionWidgetSelectionMode);
begin
  FselectionMode := Value;
end;

procedure TjdxTreeView.Set_selectionRequired(const Value: boolean);
begin
  FselectionRequired := Value;
end;

procedure TjdxTreeView.Set_selectNodesRecursive(const Value: boolean);
begin
  FselectNodesRecursive := Value;
end;

procedure TjdxTreeView.Set_selectOnFocus(const Value: boolean);
begin
  FselectOnFocus := Value;
end;

procedure TjdxTreeView.Set_showCheckBoxesMode(const Value: TdxTreeViewCheckBoxMode);
begin
  FshowCheckBoxesMode := Value;
end;

procedure TjdxTreeView.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxTreeView.Set_useNativeScrolling(const Value: boolean);
begin
  FuseNativeScrolling := Value;
end;

procedure TjdxTreeView.Set_virtualModeEnabled(const Value: boolean);
begin
  FvirtualModeEnabled := Value;
end;

procedure TjdxTreeView.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxTreeView.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxTreeView.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxTreeView.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxTreeView.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxTreeView.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxTreeView.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxTreeView.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
end;

procedure TjdxTreeView.Set_onItemCollapsed(const Value: TdxEventHandler);
begin
  FonItemCollapsed := Value;
end;

procedure TjdxTreeView.Set_onItemContextMenu(const Value: TdxEventHandler);
begin
  FonItemContextMenu := Value;
end;

procedure TjdxTreeView.Set_onItemDeleted(const Value: TdxEventHandler);
begin
  FonItemDeleted := Value;
end;

procedure TjdxTreeView.Set_onItemDeleting(const Value: TdxEventHandler);
begin
  FonItemDeleting := Value;
end;

procedure TjdxTreeView.Set_onItemExpanded(const Value: TdxEventHandler);
begin
  FonItemExpanded := Value;
end;

procedure TjdxTreeView.Set_onItemHold(const Value: TdxEventHandler);
begin
  FonItemHold := Value;
end;

procedure TjdxTreeView.Set_onItemRendered(const Value: TdxEventHandler);
begin
  FonItemRendered := Value;
end;

procedure TjdxTreeView.Set_onItemReordered(const Value: TdxEventHandler);
begin
  FonItemReordered := Value;
end;

procedure TjdxTreeView.Set_onItemSelectionChanged(const Value: TdxEventHandler);
begin
  FonItemSelectionChanged := Value;
end;

procedure TjdxTreeView.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxTreeView.Set_onSelectAllValueChanged(const Value: TdxEventHandler);
begin
  FonSelectAllValueChanged := Value;
end;

procedure TjdxTreeView.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
end;

end.
