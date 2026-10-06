unit DevExtreme.List.Custom;

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
  DevExtreme.List.JS,
  DevExtreme.Types;

type
  TjdxCustomList = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FallowItemDeleting: boolean;
    FbounceEnabled: boolean;
    FcollapsibleGroups: boolean;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FdisplayExpr: JSValue;
    FelementAttr: TJSObject;
    FfocusedElement: TJSElement;
    FfocusStateEnabled: boolean;
    Fgrouped: boolean;
    FgroupTemplate: JSValue;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FindicateLoading: boolean;
    FitemDeleteMode: TdxItemDeleteMode;
    FitemDragging: JSValue;
    FitemHoldTimeout: integer;
    Fitems: TJSArray;
    FitemTemplate: JSValue;
    FkeyExpr: JSValue;
    FloopItemFocus: boolean;
    FmenuItems: TJSArray;
    FmenuMode: TdxListMenuMode;
    FnextButtonText: string;
    FnoDataText: string;
    FpageLoadingText: string;
    FpageLoadMode: TdxPageLoadMode;
    FpulledDownText: string;
    FpullingDownText: string;
    FpullRefreshEnabled: boolean;
    FrefreshingText: string;
    FrepaintChangesOnly: boolean;
    FrtlEnabled: boolean;
    FscrollByContent: boolean;
    FscrollByThumb: boolean;
    FscrollingEnabled: boolean;
    FsearchEditorOptions: JSValue;
    FsearchEnabled: boolean;
    FsearchExpr: JSValue;
    FsearchMode: TdxSearchMode;
    FsearchTimeout: integer;
    FsearchValue: string;
    FselectAllMode: TdxSelectAllMode;
    FselectAllText: string;
    FselectByClick: boolean;
    FselectedIndex: integer;
    FselectedItem: JSValue;
    FselectedItemKeys: TJSArray;
    FselectedItems: TJSArray;
    FselectionByClick: boolean;
    FselectionMode: TCollectionWidgetSelectionMode;
    FselectionRequired: boolean;
    FselectOnFocus: boolean;
    FshowScrollbar: TdxScrollbarMode;
    FshowSelectionControls: boolean;
    FtabIndex: integer;
    FuseNativeScrolling: boolean;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonGroupRendered: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonItemClick: TdxEventHandler;
    FonItemContextMenu: TdxEventHandler;
    FonItemDeleted: TdxEventHandler;
    FonItemDeleting: TdxEventHandler;
    FonItemHold: TdxEventHandler;
    FonItemRendered: TdxEventHandler;
    FonItemReordered: TdxEventHandler;
    FonItemSwipe: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonPageLoading: TdxEventHandler;
    FonPullRefresh: TdxEventHandler;
    FonScroll: TdxEventHandler;
    FonSelectAllValueChanged: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_allowItemDeleting(const value: boolean);
    procedure Set_bounceEnabled(const value: boolean);
    procedure Set_collapsibleGroups(const value: boolean);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_displayExpr(const value: JSValue);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusedElement(const value: TJSElement);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_grouped(const value: boolean);
    procedure Set_groupTemplate(const value: JSValue);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_indicateLoading(const value: boolean);
    procedure Set_itemDeleteMode(const value: TdxItemDeleteMode);
    procedure Set_itemDragging(const value: JSValue);
    procedure Set_itemHoldTimeout(const value: integer);
    procedure Set_items(const value: TJSArray);
    procedure Set_itemTemplate(const value: JSValue);
    procedure Set_keyExpr(const value: JSValue);
    procedure Set_loopItemFocus(const value: boolean);
    procedure Set_menuItems(const value: TJSArray);
    procedure Set_menuMode(const value: TdxListMenuMode);
    procedure Set_nextButtonText(const value: string);
    procedure Set_noDataText(const value: string);
    procedure Set_pageLoadingText(const value: string);
    procedure Set_pageLoadMode(const value: TdxPageLoadMode);
    procedure Set_pulledDownText(const value: string);
    procedure Set_pullingDownText(const value: string);
    procedure Set_pullRefreshEnabled(const value: boolean);
    procedure Set_refreshingText(const value: string);
    procedure Set_repaintChangesOnly(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scrollByContent(const value: boolean);
    procedure Set_scrollByThumb(const value: boolean);
    procedure Set_scrollingEnabled(const value: boolean);
    procedure Set_searchEditorOptions(const value: JSValue);
    procedure Set_searchEnabled(const value: boolean);
    procedure Set_searchExpr(const value: JSValue);
    procedure Set_searchMode(const value: TdxSearchMode);
    procedure Set_searchTimeout(const value: integer);
    procedure Set_searchValue(const value: string);
    procedure Set_selectAllMode(const value: TdxSelectAllMode);
    procedure Set_selectAllText(const value: string);
    procedure Set_selectByClick(const value: boolean);
    procedure Set_selectedIndex(const value: integer);
    procedure Set_selectedItem(const value: JSValue);
    procedure Set_selectedItemKeys(const value: TJSArray);
    procedure Set_selectedItems(const value: TJSArray);
    procedure Set_selectionByClick(const value: boolean);
    procedure Set_selectionMode(const value: TCollectionWidgetSelectionMode);
    procedure Set_selectionRequired(const value: boolean);
    procedure Set_selectOnFocus(const value: boolean);
    procedure Set_showScrollbar(const value: TdxScrollbarMode);
    procedure Set_showSelectionControls(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_useNativeScrolling(const value: boolean);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onGroupRendered(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onItemClick(const value: TdxEventHandler);
    procedure Set_onItemContextMenu(const value: TdxEventHandler);
    procedure Set_onItemDeleted(const value: TdxEventHandler);
    procedure Set_onItemDeleting(const value: TdxEventHandler);
    procedure Set_onItemHold(const value: TdxEventHandler);
    procedure Set_onItemRendered(const value: TdxEventHandler);
    procedure Set_onItemReordered(const value: TdxEventHandler);
    procedure Set_onItemSwipe(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onPageLoading(const value: TdxEventHandler);
    procedure Set_onPullRefresh(const value: TdxEventHandler);
    procedure Set_onScroll(const value: TdxEventHandler);
    procedure Set_onSelectAllValueChanged(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxList; assembler;
    function instance: TdxList; assembler;
  public
    procedure beginUpdate(); assembler;
    function clientHeight(): integer; assembler;
    function collapseGroup(groupIndex: integer): TJSPromise; assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    function deleteItem(itemIndex: JSValue): TJSPromise; assembler; overload;
    function deleteItem(itemElement: TJSElement): TJSPromise; assembler; overload;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    function expandGroup(groupIndex: integer): TJSPromise; assembler;
    procedure focus(); assembler;
    function getDataSource(): TJSObject; assembler;
    function getFlatIndexByItemElement(itemElement: TJSElement): TJSObject; assembler;
    function getFocusedItemId(): string; assembler;
    function getItemByIndex(index: integer): TJSObject; assembler;
    function getItemElementByFlatIndex(flatIndex: integer): TJSElement; assembler;
    function isItemSelected(itemIndex: JSValue): boolean; assembler; overload;
    function isItemSelected(itemElement: TJSElement): boolean; assembler; overload;
    function itemElements(): TJSArray; assembler;
    function itemsContainer(): TJSElement; assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure reload(); assembler;
    function reorderItem(itemElement: TJSElement; toItemElement: TJSElement): TJSPromise; assembler; overload;
    function reorderItem(itemIndex: JSValue; toItemIndex: JSValue): TJSPromise; assembler; overload;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure scrollBy(distance: integer); assembler;
    function scrollHeight(): integer; assembler;
    procedure scrollTo(location: integer); assembler;
    procedure scrollToItem(itemElement: TJSElement); assembler; overload;
    procedure scrollToItem(itemIndex: JSValue); assembler; overload;
    function scrollTop(): integer; assembler;
    procedure selectAll(); assembler;
    procedure selectItem(itemIndex: JSValue); assembler; overload;
    procedure selectItem(itemElement: TJSElement); assembler; overload;
    procedure unselectAll(); assembler;
    procedure unselectItem(itemIndex: JSValue); assembler; overload;
    procedure unselectItem(itemElement: TJSElement); assembler; overload;
    function updateDimensions(): TJSPromise; assembler;
  public
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property displayExpr: JSValue read FdisplayExpr write Set_displayExpr;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property focusedElement: TJSElement read FfocusedElement write Set_focusedElement;
    property groupTemplate: JSValue read FgroupTemplate write Set_groupTemplate;
    property height_: JSValue read Fheight_ write Set_height_;
    property itemDragging: JSValue read FitemDragging write Set_itemDragging;
    property items: TJSArray read Fitems write Set_items;
    property itemTemplate: JSValue read FitemTemplate write Set_itemTemplate;
    property keyExpr: JSValue read FkeyExpr write Set_keyExpr;
    property menuItems: TJSArray read FmenuItems write Set_menuItems;
    property searchEditorOptions: JSValue read FsearchEditorOptions write Set_searchEditorOptions;
    property searchExpr: JSValue read FsearchExpr write Set_searchExpr;
    property selectedItem: JSValue read FselectedItem write Set_selectedItem;
    property selectedItemKeys: TJSArray read FselectedItemKeys write Set_selectedItemKeys;
    property selectedItems: TJSArray read FselectedItems write Set_selectedItems;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property allowItemDeleting: boolean read FallowItemDeleting write Set_allowItemDeleting default false;
    property bounceEnabled: boolean read FbounceEnabled write Set_bounceEnabled;
    property collapsibleGroups: boolean read FcollapsibleGroups write Set_collapsibleGroups default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property grouped: boolean read Fgrouped write Set_grouped default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property indicateLoading: boolean read FindicateLoading write Set_indicateLoading default true;
    property itemDeleteMode: TdxItemDeleteMode read FitemDeleteMode write Set_itemDeleteMode default idmContext;
    property itemHoldTimeout: integer read FitemHoldTimeout write Set_itemHoldTimeout;
    property loopItemFocus: boolean read FloopItemFocus write Set_loopItemFocus;
    property menuMode: TdxListMenuMode read FmenuMode write Set_menuMode default lmmContext;
    property nextButtonText: string read FnextButtonText write Set_nextButtonText;
    property noDataText: string read FnoDataText write Set_noDataText;
    property pageLoadingText: string read FpageLoadingText write Set_pageLoadingText;
    property pageLoadMode: TdxPageLoadMode read FpageLoadMode write Set_pageLoadMode default plmNextButton;
    property pulledDownText: string read FpulledDownText write Set_pulledDownText;
    property pullingDownText: string read FpullingDownText write Set_pullingDownText;
    property pullRefreshEnabled: boolean read FpullRefreshEnabled write Set_pullRefreshEnabled default false;
    property refreshingText: string read FrefreshingText write Set_refreshingText;
    property repaintChangesOnly: boolean read FrepaintChangesOnly write Set_repaintChangesOnly default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property scrollByContent: boolean read FscrollByContent write Set_scrollByContent;
    property scrollByThumb: boolean read FscrollByThumb write Set_scrollByThumb;
    property scrollingEnabled: boolean read FscrollingEnabled write Set_scrollingEnabled default true;
    property searchEnabled: boolean read FsearchEnabled write Set_searchEnabled default false;
    property searchMode: TdxSearchMode read FsearchMode write Set_searchMode default smContains;
    property searchTimeout: integer read FsearchTimeout write Set_searchTimeout;
    property searchValue: string read FsearchValue write Set_searchValue;
    property selectAllMode: TdxSelectAllMode read FselectAllMode write Set_selectAllMode default samPage;
    property selectAllText: string read FselectAllText write Set_selectAllText;
    property selectByClick: boolean read FselectByClick write Set_selectByClick default true;
    property selectedIndex: integer read FselectedIndex write Set_selectedIndex;
    property selectionByClick: boolean read FselectionByClick write Set_selectionByClick default true;
    property selectionMode: TCollectionWidgetSelectionMode read FselectionMode write Set_selectionMode default cwsmNone;
    property selectionRequired: boolean read FselectionRequired write Set_selectionRequired default false;
    property selectOnFocus: boolean read FselectOnFocus write Set_selectOnFocus;
    property showScrollbar: TdxScrollbarMode read FshowScrollbar write Set_showScrollbar default smAlways;
    property showSelectionControls: boolean read FshowSelectionControls write Set_showSelectionControls default false;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property useNativeScrolling: boolean read FuseNativeScrolling write Set_useNativeScrolling;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onGroupRendered: TdxEventHandler read FonGroupRendered write Set_onGroupRendered;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onItemClick: TdxEventHandler read FonItemClick write Set_onItemClick;
    property onItemContextMenu: TdxEventHandler read FonItemContextMenu write Set_onItemContextMenu;
    property onItemDeleted: TdxEventHandler read FonItemDeleted write Set_onItemDeleted;
    property onItemDeleting: TdxEventHandler read FonItemDeleting write Set_onItemDeleting;
    property onItemHold: TdxEventHandler read FonItemHold write Set_onItemHold;
    property onItemRendered: TdxEventHandler read FonItemRendered write Set_onItemRendered;
    property onItemReordered: TdxEventHandler read FonItemReordered write Set_onItemReordered;
    property onItemSwipe: TdxEventHandler read FonItemSwipe write Set_onItemSwipe;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onPageLoading: TdxEventHandler read FonPageLoading write Set_onPageLoading;
    property onPullRefresh: TdxEventHandler read FonPullRefresh write Set_onPullRefresh;
    property onScroll: TdxEventHandler read FonScroll write Set_onScroll;
    property onSelectAllValueChanged: TdxEventHandler read FonSelectAllValueChanged write Set_onSelectAllValueChanged;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
  end;

implementation


procedure TjdxCustomList.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FallowItemDeleting := false;
  FbounceEnabled := false;
  FcollapsibleGroups := false;
  FdataSource := nil;
  Fdisabled := false;
  FdisplayExpr := nil;
  FelementAttr := TJSObject.new;
  FfocusedElement := nil;
  FfocusStateEnabled := false;
  Fgrouped := false;
  FgroupTemplate := nil;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FindicateLoading := true;
  FitemDeleteMode := idmContext;
  FitemDragging := nil;
  FitemHoldTimeout := 0;
  Fitems := TJSArray.new;
  FitemTemplate := nil;
  FkeyExpr := nil;
  FloopItemFocus := false;
  FmenuItems := TJSArray.new;
  FmenuMode := lmmContext;
  FnextButtonText := '';
  FnoDataText := '';
  FpageLoadingText := '';
  FpageLoadMode := plmNextButton;
  FpulledDownText := '';
  FpullingDownText := '';
  FpullRefreshEnabled := false;
  FrefreshingText := '';
  FrepaintChangesOnly := false;
  FrtlEnabled := false;
  FscrollByContent := false;
  FscrollByThumb := false;
  FscrollingEnabled := true;
  FsearchEditorOptions := nil;
  FsearchEnabled := false;
  FsearchExpr := nil;
  FsearchMode := smContains;
  FsearchTimeout := 0;
  FsearchValue := '';
  FselectAllMode := samPage;
  FselectAllText := '';
  FselectByClick := true;
  FselectedIndex := 0;
  FselectedItem := nil;
  FselectedItemKeys := TJSArray.new;
  FselectedItems := TJSArray.new;
  FselectionByClick := true;
  FselectionMode := cwsmNone;
  FselectionRequired := false;
  FselectOnFocus := false;
  FshowScrollbar := smAlways;
  FshowSelectionControls := false;
  FtabIndex := 0;
  FuseNativeScrolling := false;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonGroupRendered := nil;
  FonInitialized := nil;
  FonItemClick := nil;
  FonItemContextMenu := nil;
  FonItemDeleted := nil;
  FonItemDeleting := nil;
  FonItemHold := nil;
  FonItemRendered := nil;
  FonItemReordered := nil;
  FonItemSwipe := nil;
  FonOptionChanged := nil;
  FonPageLoading := nil;
  FonPullRefresh := nil;
  FonScroll := nil;
  FonSelectAllValueChanged := nil;
  FonSelectionChanged := nil;
end;
procedure TjdxCustomList.InitJQuery;
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
      $(id).dxList(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomList.getInstance(element: TJSObject): TdxList;
asm
  return DevExpress.viz.dxList.getInstance(element);
end;

function TjdxCustomList.instance: TdxList;
asm
  return $(this.GetJQID()).dxList("instance");
end;
procedure TjdxCustomList.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('allowItemDeleting', allowItemDeleting);
    SetOption('bounceEnabled', bounceEnabled);
    SetOption('collapsibleGroups', collapsibleGroups);
    SetOption('dataSource', dataSource);
    SetOption('disabled', disabled);
    SetOption('displayExpr', displayExpr);
    SetOption('elementAttr', elementAttr);
    SetOption('focusedElement', focusedElement);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('grouped', grouped);
    SetOption('groupTemplate', groupTemplate);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('indicateLoading', indicateLoading);
    SetOption('itemDeleteMode', itemDeleteMode.ToString());
    SetOption('itemDragging', itemDragging);
    SetOption('itemHoldTimeout', itemHoldTimeout);
    SetOption('items', items);
    SetOption('itemTemplate', itemTemplate);
    SetOption('keyExpr', keyExpr);
    SetOption('loopItemFocus', loopItemFocus);
    SetOption('menuItems', menuItems);
    SetOption('menuMode', menuMode.ToString());
    SetOption('nextButtonText', nextButtonText);
    SetOption('noDataText', noDataText);
    SetOption('pageLoadingText', pageLoadingText);
    SetOption('pageLoadMode', pageLoadMode.ToString());
    SetOption('pulledDownText', pulledDownText);
    SetOption('pullingDownText', pullingDownText);
    SetOption('pullRefreshEnabled', pullRefreshEnabled);
    SetOption('refreshingText', refreshingText);
    SetOption('repaintChangesOnly', repaintChangesOnly);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('scrollByContent', scrollByContent);
    SetOption('scrollByThumb', scrollByThumb);
    SetOption('scrollingEnabled', scrollingEnabled);
    SetOption('searchEditorOptions', searchEditorOptions);
    SetOption('searchEnabled', searchEnabled);
    SetOption('searchExpr', searchExpr);
    SetOption('searchMode', searchMode.ToString());
    SetOption('searchTimeout', searchTimeout);
    SetOption('searchValue', searchValue);
    SetOption('selectAllMode', selectAllMode.ToString());
    SetOption('selectAllText', selectAllText);
    SetOption('selectByClick', selectByClick);
    SetOption('selectedIndex', selectedIndex);
    SetOption('selectedItem', selectedItem);
    SetOption('selectedItemKeys', selectedItemKeys);
    SetOption('selectedItems', selectedItems);
    SetOption('selectionByClick', selectionByClick);
    SetOption('selectionMode', selectionMode.ToString());
    SetOption('selectionRequired', selectionRequired);
    SetOption('selectOnFocus', selectOnFocus);
    SetOption('showScrollbar', showScrollbar.ToString());
    SetOption('showSelectionControls', showSelectionControls);
    SetOption('tabIndex', tabIndex);
    SetOption('useNativeScrolling', useNativeScrolling);
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('groupRendered', onGroupRendered);
    SetEvent('initialized', onInitialized);
    SetEvent('itemClick', onItemClick);
    SetEvent('itemContextMenu', onItemContextMenu);
    SetEvent('itemDeleted', onItemDeleted);
    SetEvent('itemDeleting', onItemDeleting);
    SetEvent('itemHold', onItemHold);
    SetEvent('itemRendered', onItemRendered);
    SetEvent('itemReordered', onItemReordered);
    SetEvent('itemSwipe', onItemSwipe);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('pageLoading', onPageLoading);
    SetEvent('pullRefresh', onPullRefresh);
    SetEvent('scroll', onScroll);
    SetEvent('selectAllValueChanged', onSelectAllValueChanged);
    SetEvent('selectionChanged', onSelectionChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomList.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomList.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomList.Set_allowItemDeleting(const Value: boolean);
begin
  FallowItemDeleting := Value;
  SetOption('allowItemDeleting', allowItemDeleting);
end;

procedure TjdxCustomList.Set_bounceEnabled(const Value: boolean);
begin
  FbounceEnabled := Value;
  SetOption('bounceEnabled', bounceEnabled);
end;

procedure TjdxCustomList.Set_collapsibleGroups(const Value: boolean);
begin
  FcollapsibleGroups := Value;
  SetOption('collapsibleGroups', collapsibleGroups);
end;

procedure TjdxCustomList.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomList.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomList.Set_displayExpr(const Value: JSValue);
begin
  FdisplayExpr := Value;
  SetOption('displayExpr', displayExpr);
end;

procedure TjdxCustomList.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomList.Set_focusedElement(const Value: TJSElement);
begin
  FfocusedElement := Value;
  SetOption('focusedElement', focusedElement);
end;

procedure TjdxCustomList.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomList.Set_grouped(const Value: boolean);
begin
  Fgrouped := Value;
  SetOption('grouped', grouped);
end;

procedure TjdxCustomList.Set_groupTemplate(const Value: JSValue);
begin
  FgroupTemplate := Value;
  SetOption('groupTemplate', groupTemplate);
end;

procedure TjdxCustomList.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomList.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomList.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomList.Set_indicateLoading(const Value: boolean);
begin
  FindicateLoading := Value;
  SetOption('indicateLoading', indicateLoading);
end;

procedure TjdxCustomList.Set_itemDeleteMode(const Value: TdxItemDeleteMode);
begin
  FitemDeleteMode := Value;
  SetOption('itemDeleteMode', itemDeleteMode.ToString());
end;

procedure TjdxCustomList.Set_itemDragging(const Value: JSValue);
begin
  FitemDragging := Value;
  SetOption('itemDragging', itemDragging);
end;

procedure TjdxCustomList.Set_itemHoldTimeout(const Value: integer);
begin
  FitemHoldTimeout := Value;
  SetOption('itemHoldTimeout', itemHoldTimeout);
end;

procedure TjdxCustomList.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
  SetOption('items', items);
end;

procedure TjdxCustomList.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
  SetOption('itemTemplate', itemTemplate);
end;

procedure TjdxCustomList.Set_keyExpr(const Value: JSValue);
begin
  FkeyExpr := Value;
  SetOption('keyExpr', keyExpr);
end;

procedure TjdxCustomList.Set_loopItemFocus(const Value: boolean);
begin
  FloopItemFocus := Value;
  SetOption('loopItemFocus', loopItemFocus);
end;

procedure TjdxCustomList.Set_menuItems(const Value: TJSArray);
begin
  FmenuItems := Value;
  SetOption('menuItems', menuItems);
end;

procedure TjdxCustomList.Set_menuMode(const Value: TdxListMenuMode);
begin
  FmenuMode := Value;
  SetOption('menuMode', menuMode.ToString());
end;

procedure TjdxCustomList.Set_nextButtonText(const Value: string);
begin
  FnextButtonText := Value;
  SetOption('nextButtonText', nextButtonText);
end;

procedure TjdxCustomList.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
  SetOption('noDataText', noDataText);
end;

procedure TjdxCustomList.Set_pageLoadingText(const Value: string);
begin
  FpageLoadingText := Value;
  SetOption('pageLoadingText', pageLoadingText);
end;

procedure TjdxCustomList.Set_pageLoadMode(const Value: TdxPageLoadMode);
begin
  FpageLoadMode := Value;
  SetOption('pageLoadMode', pageLoadMode.ToString());
end;

procedure TjdxCustomList.Set_pulledDownText(const Value: string);
begin
  FpulledDownText := Value;
  SetOption('pulledDownText', pulledDownText);
end;

procedure TjdxCustomList.Set_pullingDownText(const Value: string);
begin
  FpullingDownText := Value;
  SetOption('pullingDownText', pullingDownText);
end;

procedure TjdxCustomList.Set_pullRefreshEnabled(const Value: boolean);
begin
  FpullRefreshEnabled := Value;
  SetOption('pullRefreshEnabled', pullRefreshEnabled);
end;

procedure TjdxCustomList.Set_refreshingText(const Value: string);
begin
  FrefreshingText := Value;
  SetOption('refreshingText', refreshingText);
end;

procedure TjdxCustomList.Set_repaintChangesOnly(const Value: boolean);
begin
  FrepaintChangesOnly := Value;
  SetOption('repaintChangesOnly', repaintChangesOnly);
end;

procedure TjdxCustomList.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomList.Set_scrollByContent(const Value: boolean);
begin
  FscrollByContent := Value;
  SetOption('scrollByContent', scrollByContent);
end;

procedure TjdxCustomList.Set_scrollByThumb(const Value: boolean);
begin
  FscrollByThumb := Value;
  SetOption('scrollByThumb', scrollByThumb);
end;

procedure TjdxCustomList.Set_scrollingEnabled(const Value: boolean);
begin
  FscrollingEnabled := Value;
  SetOption('scrollingEnabled', scrollingEnabled);
end;

procedure TjdxCustomList.Set_searchEditorOptions(const Value: JSValue);
begin
  FsearchEditorOptions := Value;
  SetOption('searchEditorOptions', searchEditorOptions);
end;

procedure TjdxCustomList.Set_searchEnabled(const Value: boolean);
begin
  FsearchEnabled := Value;
  SetOption('searchEnabled', searchEnabled);
end;

procedure TjdxCustomList.Set_searchExpr(const Value: JSValue);
begin
  FsearchExpr := Value;
  SetOption('searchExpr', searchExpr);
end;

procedure TjdxCustomList.Set_searchMode(const Value: TdxSearchMode);
begin
  FsearchMode := Value;
  SetOption('searchMode', searchMode.ToString());
end;

procedure TjdxCustomList.Set_searchTimeout(const Value: integer);
begin
  FsearchTimeout := Value;
  SetOption('searchTimeout', searchTimeout);
end;

procedure TjdxCustomList.Set_searchValue(const Value: string);
begin
  FsearchValue := Value;
  SetOption('searchValue', searchValue);
end;

procedure TjdxCustomList.Set_selectAllMode(const Value: TdxSelectAllMode);
begin
  FselectAllMode := Value;
  SetOption('selectAllMode', selectAllMode.ToString());
end;

procedure TjdxCustomList.Set_selectAllText(const Value: string);
begin
  FselectAllText := Value;
  SetOption('selectAllText', selectAllText);
end;

procedure TjdxCustomList.Set_selectByClick(const Value: boolean);
begin
  FselectByClick := Value;
  SetOption('selectByClick', selectByClick);
end;

procedure TjdxCustomList.Set_selectedIndex(const Value: integer);
begin
  FselectedIndex := Value;
  SetOption('selectedIndex', selectedIndex);
end;

procedure TjdxCustomList.Set_selectedItem(const Value: JSValue);
begin
  FselectedItem := Value;
  SetOption('selectedItem', selectedItem);
end;

procedure TjdxCustomList.Set_selectedItemKeys(const Value: TJSArray);
begin
  FselectedItemKeys := Value;
  SetOption('selectedItemKeys', selectedItemKeys);
end;

procedure TjdxCustomList.Set_selectedItems(const Value: TJSArray);
begin
  FselectedItems := Value;
  SetOption('selectedItems', selectedItems);
end;

procedure TjdxCustomList.Set_selectionByClick(const Value: boolean);
begin
  FselectionByClick := Value;
  SetOption('selectionByClick', selectionByClick);
end;

procedure TjdxCustomList.Set_selectionMode(const Value: TCollectionWidgetSelectionMode);
begin
  FselectionMode := Value;
  SetOption('selectionMode', selectionMode.ToString());
end;

procedure TjdxCustomList.Set_selectionRequired(const Value: boolean);
begin
  FselectionRequired := Value;
  SetOption('selectionRequired', selectionRequired);
end;

procedure TjdxCustomList.Set_selectOnFocus(const Value: boolean);
begin
  FselectOnFocus := Value;
  SetOption('selectOnFocus', selectOnFocus);
end;

procedure TjdxCustomList.Set_showScrollbar(const Value: TdxScrollbarMode);
begin
  FshowScrollbar := Value;
  SetOption('showScrollbar', showScrollbar.ToString());
end;

procedure TjdxCustomList.Set_showSelectionControls(const Value: boolean);
begin
  FshowSelectionControls := Value;
  SetOption('showSelectionControls', showSelectionControls);
end;

procedure TjdxCustomList.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomList.Set_useNativeScrolling(const Value: boolean);
begin
  FuseNativeScrolling := Value;
  SetOption('useNativeScrolling', useNativeScrolling);
end;

procedure TjdxCustomList.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomList.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomList.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomList.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomList.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomList.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomList.Set_onGroupRendered(const Value: TdxEventHandler);
begin
  FonGroupRendered := Value;
  SetEvent('groupRendered', onGroupRendered);
end;

procedure TjdxCustomList.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomList.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
  SetEvent('itemClick', onItemClick);
end;

procedure TjdxCustomList.Set_onItemContextMenu(const Value: TdxEventHandler);
begin
  FonItemContextMenu := Value;
  SetEvent('itemContextMenu', onItemContextMenu);
end;

procedure TjdxCustomList.Set_onItemDeleted(const Value: TdxEventHandler);
begin
  FonItemDeleted := Value;
  SetEvent('itemDeleted', onItemDeleted);
end;

procedure TjdxCustomList.Set_onItemDeleting(const Value: TdxEventHandler);
begin
  FonItemDeleting := Value;
  SetEvent('itemDeleting', onItemDeleting);
end;

procedure TjdxCustomList.Set_onItemHold(const Value: TdxEventHandler);
begin
  FonItemHold := Value;
  SetEvent('itemHold', onItemHold);
end;

procedure TjdxCustomList.Set_onItemRendered(const Value: TdxEventHandler);
begin
  FonItemRendered := Value;
  SetEvent('itemRendered', onItemRendered);
end;

procedure TjdxCustomList.Set_onItemReordered(const Value: TdxEventHandler);
begin
  FonItemReordered := Value;
  SetEvent('itemReordered', onItemReordered);
end;

procedure TjdxCustomList.Set_onItemSwipe(const Value: TdxEventHandler);
begin
  FonItemSwipe := Value;
  SetEvent('itemSwipe', onItemSwipe);
end;

procedure TjdxCustomList.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomList.Set_onPageLoading(const Value: TdxEventHandler);
begin
  FonPageLoading := Value;
  SetEvent('pageLoading', onPageLoading);
end;

procedure TjdxCustomList.Set_onPullRefresh(const Value: TdxEventHandler);
begin
  FonPullRefresh := Value;
  SetEvent('pullRefresh', onPullRefresh);
end;

procedure TjdxCustomList.Set_onScroll(const Value: TdxEventHandler);
begin
  FonScroll := Value;
  SetEvent('scroll', onScroll);
end;

procedure TjdxCustomList.Set_onSelectAllValueChanged(const Value: TdxEventHandler);
begin
  FonSelectAllValueChanged := Value;
  SetEvent('selectAllValueChanged', onSelectAllValueChanged);
end;

procedure TjdxCustomList.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomList.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.beginUpdate();
end;

function TjdxCustomList.clientHeight(): integer;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.clientHeight();
end;

function TjdxCustomList.collapseGroup(groupIndex: integer): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.collapseGroup(groupIndex);
end;

procedure TjdxCustomList.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomList.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomList.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.defaultOptions(rule);
end;

function TjdxCustomList.deleteItem(itemIndex: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.deleteItem(itemIndex);
end;

function TjdxCustomList.deleteItem(itemElement: TJSElement): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.deleteItem(itemElement);
end;

procedure TjdxCustomList.dispose();
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.dispose();
end;

function TjdxCustomList.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.element();
end;

procedure TjdxCustomList.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.endUpdate();
end;

function TjdxCustomList.expandGroup(groupIndex: integer): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.expandGroup(groupIndex);
end;

procedure TjdxCustomList.focus();
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.focus();
end;

function TjdxCustomList.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.getDataSource();
end;

function TjdxCustomList.getFlatIndexByItemElement(itemElement: TJSElement): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.getFlatIndexByItemElement(itemElement);
end;

function TjdxCustomList.getFocusedItemId(): string;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.getFocusedItemId();
end;

function TjdxCustomList.getItemByIndex(index: integer): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.getItemByIndex(index);
end;

function TjdxCustomList.getItemElementByFlatIndex(flatIndex: integer): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.getItemElementByFlatIndex(flatIndex);
end;

function TjdxCustomList.isItemSelected(itemIndex: JSValue): boolean;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.isItemSelected(itemIndex);
end;

function TjdxCustomList.isItemSelected(itemElement: TJSElement): boolean;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.isItemSelected(itemElement);
end;

function TjdxCustomList.itemElements(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.itemElements();
end;

function TjdxCustomList.itemsContainer(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.itemsContainer();
end;

function TjdxCustomList.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomList.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.off(eventName);
end;

function TjdxCustomList.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.on(events);
end;

function TjdxCustomList.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.on(eventName, eventHandler);
end;

procedure TjdxCustomList.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomList.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.option(optionName);
end;

function TjdxCustomList.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.option();
end;

procedure TjdxCustomList.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.option(options);
end;

procedure TjdxCustomList.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomList.reload();
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.reload();
end;

function TjdxCustomList.reorderItem(itemElement: TJSElement; toItemElement: TJSElement): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.reorderItem(itemElement, toItemElement);
end;

function TjdxCustomList.reorderItem(itemIndex: JSValue; toItemIndex: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.reorderItem(itemIndex, toItemIndex);
end;

procedure TjdxCustomList.repaint();
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.repaint();
end;

procedure TjdxCustomList.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomList.scrollBy(distance: integer);
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.scrollBy(distance);
end;

function TjdxCustomList.scrollHeight(): integer;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.scrollHeight();
end;

procedure TjdxCustomList.scrollTo(location: integer);
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.scrollTo(location);
end;

procedure TjdxCustomList.scrollToItem(itemElement: TJSElement);
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.scrollToItem(itemElement);
end;

procedure TjdxCustomList.scrollToItem(itemIndex: JSValue);
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.scrollToItem(itemIndex);
end;

function TjdxCustomList.scrollTop(): integer;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.scrollTop();
end;

procedure TjdxCustomList.selectAll();
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.selectAll();
end;

procedure TjdxCustomList.selectItem(itemIndex: JSValue);
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.selectItem(itemIndex);
end;

procedure TjdxCustomList.selectItem(itemElement: TJSElement);
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.selectItem(itemElement);
end;

procedure TjdxCustomList.unselectAll();
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.unselectAll();
end;

procedure TjdxCustomList.unselectItem(itemIndex: JSValue);
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.unselectItem(itemIndex);
end;

procedure TjdxCustomList.unselectItem(itemElement: TJSElement);
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  _instance.unselectItem(itemElement);
end;

function TjdxCustomList.updateDimensions(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxList("instance");
  return _instance.updateDimensions();
end;

end.
