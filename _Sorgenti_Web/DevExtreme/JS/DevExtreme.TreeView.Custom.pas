unit DevExtreme.TreeView.Custom;

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
  DevExtreme.TreeView.JS,
  DevExtreme.Types;

type
  TjdxCustomTreeView = class(TjdxCustomControl)
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
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxTreeView; assembler;
    function instance: TdxTreeView; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure collapseAll(); assembler;
    function collapseItem(key: JSValue): TJSPromise; assembler; overload;
    function collapseItem(itemElement: TJSElement): TJSPromise; assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    function deleteItem(itemElement: TJSElement): TJSPromise; assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure expandAll(); assembler;
    function expandItem(itemElement: TJSElement): TJSPromise; assembler; overload;
    function expandItem(itemData: JSValue): TJSPromise; assembler; overload;
    procedure focus(); assembler;
    function getDataSource(): TJSObject; assembler;
    function getFocusedItemId(): string; assembler;
    function getNodes(): TJSArray; assembler;
    function getScrollable(): JSValue; assembler;
    function getSelectedNodeKeys(): TJSArray; assembler;
    function getSelectedNodes(): TJSArray; assembler;
    function isItemSelected(itemElement: TJSElement): boolean; assembler;
    function itemElements(): TJSArray; assembler;
    function itemsContainer(): TJSElement; assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    function option(): TJSObject; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    function reorderItem(itemElement: TJSElement; toItemElement: TJSElement): TJSPromise; assembler;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
    function scrollToItem(itemData: JSValue): TJSPromise; assembler; overload;
    function scrollToItem(itemElement: TJSElement): TJSPromise; assembler; overload;
    procedure selectAll(); assembler;
    function selectItem(itemElement: TJSElement): boolean; assembler; overload;
    function selectItem(key: JSValue): boolean; assembler; overload;
    procedure unselectAll(); assembler;
    function unselectItem(itemElement: TJSElement): boolean; assembler; overload;
    function unselectItem(key: JSValue): boolean; assembler; overload;
    function updateDimensions(): TJSPromise; assembler;
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


procedure TjdxCustomTreeView.CreateInitialize;
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
procedure TjdxCustomTreeView.InitJQuery;
var
  id: string;
  options: TJSObject;
begin
  inherited;

  if Assigned(ElementHandle) then
  begin
    id := GetJQID;
    options := TJSObject.new;

    asm
      $(id).dxTreeView(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomTreeView.getInstance(element: TJSObject): TdxTreeView;
asm
  return DevExpress.viz.dxTreeView.getInstance(element);
end;

function TjdxCustomTreeView.instance: TdxTreeView;
asm
  return $(this.GetJQID()).dxTreeView("instance");
end;
procedure TjdxCustomTreeView.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('animationEnabled', animationEnabled);
    SetOption('collapseIcon', collapseIcon);
    SetOption('createChildren', createChildren);
    SetOption('dataSource', dataSource);
    SetOption('dataStructure', dataStructure.ToString());
    SetOption('disabled', disabled);
    SetOption('disabledExpr', disabledExpr);
    SetOption('displayExpr', displayExpr);
    SetOption('elementAttr', elementAttr);
    SetOption('expandAllEnabled', expandAllEnabled);
    SetOption('expandedExpr', expandedExpr);
    SetOption('expandEvent', expandEvent.ToString());
    SetOption('expandIcon', expandIcon);
    SetOption('expandNodesRecursive', expandNodesRecursive);
    SetOption('focusedElement', focusedElement);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('hasItemsExpr', hasItemsExpr);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('itemHoldTimeout', itemHoldTimeout);
    SetOption('items', items);
    SetOption('itemsExpr', itemsExpr);
    SetOption('itemTemplate', itemTemplate);
    SetOption('keyExpr', keyExpr);
    SetOption('loopItemFocus', loopItemFocus);
    SetOption('noDataText', noDataText);
    SetOption('parentIdExpr', parentIdExpr);
    SetOption('rootValue', rootValue);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('scrollDirection', scrollDirection.ToString());
    SetOption('searchEditorOptions', searchEditorOptions);
    SetOption('searchEnabled', searchEnabled);
    SetOption('searchExpr', searchExpr);
    SetOption('searchMode', searchMode.ToString());
    SetOption('searchTimeout', searchTimeout);
    SetOption('searchValue', searchValue);
    SetOption('selectAllText', selectAllText);
    SetOption('selectByClick', selectByClick);
    SetOption('selectedExpr', selectedExpr);
    SetOption('selectedIndex', selectedIndex);
    SetOption('selectedItem', selectedItem);
    SetOption('selectedItemKeys', selectedItemKeys);
    SetOption('selectedItems', selectedItems);
    SetOption('selectionByClick', selectionByClick);
    SetOption('selectionMode', selectionMode.ToString());
    SetOption('selectionRequired', selectionRequired);
    SetOption('selectNodesRecursive', selectNodesRecursive);
    SetOption('selectOnFocus', selectOnFocus);
    SetOption('showCheckBoxesMode', showCheckBoxesMode.ToString());
    SetOption('tabIndex', tabIndex);
    SetOption('useNativeScrolling', useNativeScrolling);
    SetOption('virtualModeEnabled', virtualModeEnabled);
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('itemClick', onItemClick);
    SetEvent('itemCollapsed', onItemCollapsed);
    SetEvent('itemContextMenu', onItemContextMenu);
    SetEvent('itemDeleted', onItemDeleted);
    SetEvent('itemDeleting', onItemDeleting);
    SetEvent('itemExpanded', onItemExpanded);
    SetEvent('itemHold', onItemHold);
    SetEvent('itemRendered', onItemRendered);
    SetEvent('itemReordered', onItemReordered);
    SetEvent('itemSelectionChanged', onItemSelectionChanged);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('selectAllValueChanged', onSelectAllValueChanged);
    SetEvent('selectionChanged', onSelectionChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomTreeView.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomTreeView.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomTreeView.Set_animationEnabled(const Value: boolean);
begin
  FanimationEnabled := Value;
  SetOption('animationEnabled', animationEnabled);
end;

procedure TjdxCustomTreeView.Set_collapseIcon(const Value: JSValue);
begin
  FcollapseIcon := Value;
  SetOption('collapseIcon', collapseIcon);
end;

procedure TjdxCustomTreeView.Set_createChildren(const Value: TJSFunction);
begin
  FcreateChildren := Value;
  SetOption('createChildren', createChildren);
end;

procedure TjdxCustomTreeView.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomTreeView.Set_dataStructure(const Value: TdxDataStructure);
begin
  FdataStructure := Value;
  SetOption('dataStructure', dataStructure.ToString());
end;

procedure TjdxCustomTreeView.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomTreeView.Set_disabledExpr(const Value: JSValue);
begin
  FdisabledExpr := Value;
  SetOption('disabledExpr', disabledExpr);
end;

procedure TjdxCustomTreeView.Set_displayExpr(const Value: JSValue);
begin
  FdisplayExpr := Value;
  SetOption('displayExpr', displayExpr);
end;

procedure TjdxCustomTreeView.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomTreeView.Set_expandAllEnabled(const Value: boolean);
begin
  FexpandAllEnabled := Value;
  SetOption('expandAllEnabled', expandAllEnabled);
end;

procedure TjdxCustomTreeView.Set_expandedExpr(const Value: JSValue);
begin
  FexpandedExpr := Value;
  SetOption('expandedExpr', expandedExpr);
end;

procedure TjdxCustomTreeView.Set_expandEvent(const Value: TdxTreeViewExpandEvent);
begin
  FexpandEvent := Value;
  SetOption('expandEvent', expandEvent.ToString());
end;

procedure TjdxCustomTreeView.Set_expandIcon(const Value: JSValue);
begin
  FexpandIcon := Value;
  SetOption('expandIcon', expandIcon);
end;

procedure TjdxCustomTreeView.Set_expandNodesRecursive(const Value: boolean);
begin
  FexpandNodesRecursive := Value;
  SetOption('expandNodesRecursive', expandNodesRecursive);
end;

procedure TjdxCustomTreeView.Set_focusedElement(const Value: TJSElement);
begin
  FfocusedElement := Value;
  SetOption('focusedElement', focusedElement);
end;

procedure TjdxCustomTreeView.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomTreeView.Set_hasItemsExpr(const Value: JSValue);
begin
  FhasItemsExpr := Value;
  SetOption('hasItemsExpr', hasItemsExpr);
end;

procedure TjdxCustomTreeView.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomTreeView.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomTreeView.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomTreeView.Set_itemHoldTimeout(const Value: integer);
begin
  FitemHoldTimeout := Value;
  SetOption('itemHoldTimeout', itemHoldTimeout);
end;

procedure TjdxCustomTreeView.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
  SetOption('items', items);
end;

procedure TjdxCustomTreeView.Set_itemsExpr(const Value: JSValue);
begin
  FitemsExpr := Value;
  SetOption('itemsExpr', itemsExpr);
end;

procedure TjdxCustomTreeView.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
  SetOption('itemTemplate', itemTemplate);
end;

procedure TjdxCustomTreeView.Set_keyExpr(const Value: JSValue);
begin
  FkeyExpr := Value;
  SetOption('keyExpr', keyExpr);
end;

procedure TjdxCustomTreeView.Set_loopItemFocus(const Value: boolean);
begin
  FloopItemFocus := Value;
  SetOption('loopItemFocus', loopItemFocus);
end;

procedure TjdxCustomTreeView.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
  SetOption('noDataText', noDataText);
end;

procedure TjdxCustomTreeView.Set_parentIdExpr(const Value: JSValue);
begin
  FparentIdExpr := Value;
  SetOption('parentIdExpr', parentIdExpr);
end;

procedure TjdxCustomTreeView.Set_rootValue(const Value: JSValue);
begin
  FrootValue := Value;
  SetOption('rootValue', rootValue);
end;

procedure TjdxCustomTreeView.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomTreeView.Set_scrollDirection(const Value: TdxScrollDirection);
begin
  FscrollDirection := Value;
  SetOption('scrollDirection', scrollDirection.ToString());
end;

procedure TjdxCustomTreeView.Set_searchEditorOptions(const Value: JSValue);
begin
  FsearchEditorOptions := Value;
  SetOption('searchEditorOptions', searchEditorOptions);
end;

procedure TjdxCustomTreeView.Set_searchEnabled(const Value: boolean);
begin
  FsearchEnabled := Value;
  SetOption('searchEnabled', searchEnabled);
end;

procedure TjdxCustomTreeView.Set_searchExpr(const Value: JSValue);
begin
  FsearchExpr := Value;
  SetOption('searchExpr', searchExpr);
end;

procedure TjdxCustomTreeView.Set_searchMode(const Value: TdxSearchMode);
begin
  FsearchMode := Value;
  SetOption('searchMode', searchMode.ToString());
end;

procedure TjdxCustomTreeView.Set_searchTimeout(const Value: integer);
begin
  FsearchTimeout := Value;
  SetOption('searchTimeout', searchTimeout);
end;

procedure TjdxCustomTreeView.Set_searchValue(const Value: string);
begin
  FsearchValue := Value;
  SetOption('searchValue', searchValue);
end;

procedure TjdxCustomTreeView.Set_selectAllText(const Value: string);
begin
  FselectAllText := Value;
  SetOption('selectAllText', selectAllText);
end;

procedure TjdxCustomTreeView.Set_selectByClick(const Value: boolean);
begin
  FselectByClick := Value;
  SetOption('selectByClick', selectByClick);
end;

procedure TjdxCustomTreeView.Set_selectedExpr(const Value: JSValue);
begin
  FselectedExpr := Value;
  SetOption('selectedExpr', selectedExpr);
end;

procedure TjdxCustomTreeView.Set_selectedIndex(const Value: integer);
begin
  FselectedIndex := Value;
  SetOption('selectedIndex', selectedIndex);
end;

procedure TjdxCustomTreeView.Set_selectedItem(const Value: JSValue);
begin
  FselectedItem := Value;
  SetOption('selectedItem', selectedItem);
end;

procedure TjdxCustomTreeView.Set_selectedItemKeys(const Value: TJSArray);
begin
  FselectedItemKeys := Value;
  SetOption('selectedItemKeys', selectedItemKeys);
end;

procedure TjdxCustomTreeView.Set_selectedItems(const Value: TJSArray);
begin
  FselectedItems := Value;
  SetOption('selectedItems', selectedItems);
end;

procedure TjdxCustomTreeView.Set_selectionByClick(const Value: boolean);
begin
  FselectionByClick := Value;
  SetOption('selectionByClick', selectionByClick);
end;

procedure TjdxCustomTreeView.Set_selectionMode(const Value: TCollectionWidgetSelectionMode);
begin
  FselectionMode := Value;
  SetOption('selectionMode', selectionMode.ToString());
end;

procedure TjdxCustomTreeView.Set_selectionRequired(const Value: boolean);
begin
  FselectionRequired := Value;
  SetOption('selectionRequired', selectionRequired);
end;

procedure TjdxCustomTreeView.Set_selectNodesRecursive(const Value: boolean);
begin
  FselectNodesRecursive := Value;
  SetOption('selectNodesRecursive', selectNodesRecursive);
end;

procedure TjdxCustomTreeView.Set_selectOnFocus(const Value: boolean);
begin
  FselectOnFocus := Value;
  SetOption('selectOnFocus', selectOnFocus);
end;

procedure TjdxCustomTreeView.Set_showCheckBoxesMode(const Value: TdxTreeViewCheckBoxMode);
begin
  FshowCheckBoxesMode := Value;
  SetOption('showCheckBoxesMode', showCheckBoxesMode.ToString());
end;

procedure TjdxCustomTreeView.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomTreeView.Set_useNativeScrolling(const Value: boolean);
begin
  FuseNativeScrolling := Value;
  SetOption('useNativeScrolling', useNativeScrolling);
end;

procedure TjdxCustomTreeView.Set_virtualModeEnabled(const Value: boolean);
begin
  FvirtualModeEnabled := Value;
  SetOption('virtualModeEnabled', virtualModeEnabled);
end;

procedure TjdxCustomTreeView.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomTreeView.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomTreeView.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomTreeView.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomTreeView.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomTreeView.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomTreeView.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomTreeView.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
  SetEvent('itemClick', onItemClick);
end;

procedure TjdxCustomTreeView.Set_onItemCollapsed(const Value: TdxEventHandler);
begin
  FonItemCollapsed := Value;
  SetEvent('itemCollapsed', onItemCollapsed);
end;

procedure TjdxCustomTreeView.Set_onItemContextMenu(const Value: TdxEventHandler);
begin
  FonItemContextMenu := Value;
  SetEvent('itemContextMenu', onItemContextMenu);
end;

procedure TjdxCustomTreeView.Set_onItemDeleted(const Value: TdxEventHandler);
begin
  FonItemDeleted := Value;
  SetEvent('itemDeleted', onItemDeleted);
end;

procedure TjdxCustomTreeView.Set_onItemDeleting(const Value: TdxEventHandler);
begin
  FonItemDeleting := Value;
  SetEvent('itemDeleting', onItemDeleting);
end;

procedure TjdxCustomTreeView.Set_onItemExpanded(const Value: TdxEventHandler);
begin
  FonItemExpanded := Value;
  SetEvent('itemExpanded', onItemExpanded);
end;

procedure TjdxCustomTreeView.Set_onItemHold(const Value: TdxEventHandler);
begin
  FonItemHold := Value;
  SetEvent('itemHold', onItemHold);
end;

procedure TjdxCustomTreeView.Set_onItemRendered(const Value: TdxEventHandler);
begin
  FonItemRendered := Value;
  SetEvent('itemRendered', onItemRendered);
end;

procedure TjdxCustomTreeView.Set_onItemReordered(const Value: TdxEventHandler);
begin
  FonItemReordered := Value;
  SetEvent('itemReordered', onItemReordered);
end;

procedure TjdxCustomTreeView.Set_onItemSelectionChanged(const Value: TdxEventHandler);
begin
  FonItemSelectionChanged := Value;
  SetEvent('itemSelectionChanged', onItemSelectionChanged);
end;

procedure TjdxCustomTreeView.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomTreeView.Set_onSelectAllValueChanged(const Value: TdxEventHandler);
begin
  FonSelectAllValueChanged := Value;
  SetEvent('selectAllValueChanged', onSelectAllValueChanged);
end;

procedure TjdxCustomTreeView.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomTreeView.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomTreeView.collapseAll();
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  _instance.collapseAll();
end;

function TjdxCustomTreeView.collapseItem(key: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.collapseItem(key);
end;

function TjdxCustomTreeView.collapseItem(itemElement: TJSElement): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.collapseItem(itemElement);
end;

procedure TjdxCustomTreeView.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomTreeView.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomTreeView.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  _instance.defaultOptions(rule);
end;

function TjdxCustomTreeView.deleteItem(itemElement: TJSElement): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.deleteItem(itemElement);
end;

procedure TjdxCustomTreeView.dispose();
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  _instance.dispose();
end;

function TjdxCustomTreeView.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.element();
end;

procedure TjdxCustomTreeView.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomTreeView.expandAll();
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  _instance.expandAll();
end;

function TjdxCustomTreeView.expandItem(itemElement: TJSElement): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.expandItem(itemElement);
end;

function TjdxCustomTreeView.expandItem(itemData: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.expandItem(itemData);
end;

procedure TjdxCustomTreeView.focus();
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  _instance.focus();
end;

function TjdxCustomTreeView.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.getDataSource();
end;

function TjdxCustomTreeView.getFocusedItemId(): string;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.getFocusedItemId();
end;

function TjdxCustomTreeView.getNodes(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.getNodes();
end;

function TjdxCustomTreeView.getScrollable(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.getScrollable();
end;

function TjdxCustomTreeView.getSelectedNodeKeys(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.getSelectedNodeKeys();
end;

function TjdxCustomTreeView.getSelectedNodes(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.getSelectedNodes();
end;

function TjdxCustomTreeView.isItemSelected(itemElement: TJSElement): boolean;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.isItemSelected(itemElement);
end;

function TjdxCustomTreeView.itemElements(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.itemElements();
end;

function TjdxCustomTreeView.itemsContainer(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.itemsContainer();
end;

function TjdxCustomTreeView.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomTreeView.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.off(eventName);
end;

function TjdxCustomTreeView.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.on(events);
end;

function TjdxCustomTreeView.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.on(eventName, eventHandler);
end;

procedure TjdxCustomTreeView.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomTreeView.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  _instance.option(options);
end;

function TjdxCustomTreeView.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.option();
end;

function TjdxCustomTreeView.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomTreeView.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  _instance.registerKeyHandler(key, handler);
end;

function TjdxCustomTreeView.reorderItem(itemElement: TJSElement; toItemElement: TJSElement): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.reorderItem(itemElement, toItemElement);
end;

procedure TjdxCustomTreeView.repaint();
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  _instance.repaint();
end;

procedure TjdxCustomTreeView.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  _instance.resetOption(optionName);
end;

function TjdxCustomTreeView.scrollToItem(itemData: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.scrollToItem(itemData);
end;

function TjdxCustomTreeView.scrollToItem(itemElement: TJSElement): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.scrollToItem(itemElement);
end;

procedure TjdxCustomTreeView.selectAll();
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  _instance.selectAll();
end;

function TjdxCustomTreeView.selectItem(itemElement: TJSElement): boolean;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.selectItem(itemElement);
end;

function TjdxCustomTreeView.selectItem(key: JSValue): boolean;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.selectItem(key);
end;

procedure TjdxCustomTreeView.unselectAll();
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  _instance.unselectAll();
end;

function TjdxCustomTreeView.unselectItem(itemElement: TJSElement): boolean;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.unselectItem(itemElement);
end;

function TjdxCustomTreeView.unselectItem(key: JSValue): boolean;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.unselectItem(key);
end;

function TjdxCustomTreeView.updateDimensions(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeView("instance");
  return _instance.updateDimensions();
end;

end.
