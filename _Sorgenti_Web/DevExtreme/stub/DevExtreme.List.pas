unit DevExtreme.List;

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
  TjdxList = class(TjdxCustomControl)
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
  public
    constructor Create(aOwner: TComponent); override;
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


constructor TjdxList.Create(aOwner: TComponent);
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

procedure TjdxList.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxList.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxList.Set_allowItemDeleting(const Value: boolean);
begin
  FallowItemDeleting := Value;
end;

procedure TjdxList.Set_bounceEnabled(const Value: boolean);
begin
  FbounceEnabled := Value;
end;

procedure TjdxList.Set_collapsibleGroups(const Value: boolean);
begin
  FcollapsibleGroups := Value;
end;

procedure TjdxList.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxList.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxList.Set_displayExpr(const Value: JSValue);
begin
  FdisplayExpr := Value;
end;

procedure TjdxList.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxList.Set_focusedElement(const Value: TJSElement);
begin
  FfocusedElement := Value;
end;

procedure TjdxList.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxList.Set_grouped(const Value: boolean);
begin
  Fgrouped := Value;
end;

procedure TjdxList.Set_groupTemplate(const Value: JSValue);
begin
  FgroupTemplate := Value;
end;

procedure TjdxList.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxList.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxList.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxList.Set_indicateLoading(const Value: boolean);
begin
  FindicateLoading := Value;
end;

procedure TjdxList.Set_itemDeleteMode(const Value: TdxItemDeleteMode);
begin
  FitemDeleteMode := Value;
end;

procedure TjdxList.Set_itemDragging(const Value: JSValue);
begin
  FitemDragging := Value;
end;

procedure TjdxList.Set_itemHoldTimeout(const Value: integer);
begin
  FitemHoldTimeout := Value;
end;

procedure TjdxList.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
end;

procedure TjdxList.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
end;

procedure TjdxList.Set_keyExpr(const Value: JSValue);
begin
  FkeyExpr := Value;
end;

procedure TjdxList.Set_loopItemFocus(const Value: boolean);
begin
  FloopItemFocus := Value;
end;

procedure TjdxList.Set_menuItems(const Value: TJSArray);
begin
  FmenuItems := Value;
end;

procedure TjdxList.Set_menuMode(const Value: TdxListMenuMode);
begin
  FmenuMode := Value;
end;

procedure TjdxList.Set_nextButtonText(const Value: string);
begin
  FnextButtonText := Value;
end;

procedure TjdxList.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
end;

procedure TjdxList.Set_pageLoadingText(const Value: string);
begin
  FpageLoadingText := Value;
end;

procedure TjdxList.Set_pageLoadMode(const Value: TdxPageLoadMode);
begin
  FpageLoadMode := Value;
end;

procedure TjdxList.Set_pulledDownText(const Value: string);
begin
  FpulledDownText := Value;
end;

procedure TjdxList.Set_pullingDownText(const Value: string);
begin
  FpullingDownText := Value;
end;

procedure TjdxList.Set_pullRefreshEnabled(const Value: boolean);
begin
  FpullRefreshEnabled := Value;
end;

procedure TjdxList.Set_refreshingText(const Value: string);
begin
  FrefreshingText := Value;
end;

procedure TjdxList.Set_repaintChangesOnly(const Value: boolean);
begin
  FrepaintChangesOnly := Value;
end;

procedure TjdxList.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxList.Set_scrollByContent(const Value: boolean);
begin
  FscrollByContent := Value;
end;

procedure TjdxList.Set_scrollByThumb(const Value: boolean);
begin
  FscrollByThumb := Value;
end;

procedure TjdxList.Set_scrollingEnabled(const Value: boolean);
begin
  FscrollingEnabled := Value;
end;

procedure TjdxList.Set_searchEditorOptions(const Value: JSValue);
begin
  FsearchEditorOptions := Value;
end;

procedure TjdxList.Set_searchEnabled(const Value: boolean);
begin
  FsearchEnabled := Value;
end;

procedure TjdxList.Set_searchExpr(const Value: JSValue);
begin
  FsearchExpr := Value;
end;

procedure TjdxList.Set_searchMode(const Value: TdxSearchMode);
begin
  FsearchMode := Value;
end;

procedure TjdxList.Set_searchTimeout(const Value: integer);
begin
  FsearchTimeout := Value;
end;

procedure TjdxList.Set_searchValue(const Value: string);
begin
  FsearchValue := Value;
end;

procedure TjdxList.Set_selectAllMode(const Value: TdxSelectAllMode);
begin
  FselectAllMode := Value;
end;

procedure TjdxList.Set_selectAllText(const Value: string);
begin
  FselectAllText := Value;
end;

procedure TjdxList.Set_selectByClick(const Value: boolean);
begin
  FselectByClick := Value;
end;

procedure TjdxList.Set_selectedIndex(const Value: integer);
begin
  FselectedIndex := Value;
end;

procedure TjdxList.Set_selectedItem(const Value: JSValue);
begin
  FselectedItem := Value;
end;

procedure TjdxList.Set_selectedItemKeys(const Value: TJSArray);
begin
  FselectedItemKeys := Value;
end;

procedure TjdxList.Set_selectedItems(const Value: TJSArray);
begin
  FselectedItems := Value;
end;

procedure TjdxList.Set_selectionByClick(const Value: boolean);
begin
  FselectionByClick := Value;
end;

procedure TjdxList.Set_selectionMode(const Value: TCollectionWidgetSelectionMode);
begin
  FselectionMode := Value;
end;

procedure TjdxList.Set_selectionRequired(const Value: boolean);
begin
  FselectionRequired := Value;
end;

procedure TjdxList.Set_selectOnFocus(const Value: boolean);
begin
  FselectOnFocus := Value;
end;

procedure TjdxList.Set_showScrollbar(const Value: TdxScrollbarMode);
begin
  FshowScrollbar := Value;
end;

procedure TjdxList.Set_showSelectionControls(const Value: boolean);
begin
  FshowSelectionControls := Value;
end;

procedure TjdxList.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxList.Set_useNativeScrolling(const Value: boolean);
begin
  FuseNativeScrolling := Value;
end;

procedure TjdxList.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxList.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxList.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxList.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxList.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxList.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxList.Set_onGroupRendered(const Value: TdxEventHandler);
begin
  FonGroupRendered := Value;
end;

procedure TjdxList.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxList.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
end;

procedure TjdxList.Set_onItemContextMenu(const Value: TdxEventHandler);
begin
  FonItemContextMenu := Value;
end;

procedure TjdxList.Set_onItemDeleted(const Value: TdxEventHandler);
begin
  FonItemDeleted := Value;
end;

procedure TjdxList.Set_onItemDeleting(const Value: TdxEventHandler);
begin
  FonItemDeleting := Value;
end;

procedure TjdxList.Set_onItemHold(const Value: TdxEventHandler);
begin
  FonItemHold := Value;
end;

procedure TjdxList.Set_onItemRendered(const Value: TdxEventHandler);
begin
  FonItemRendered := Value;
end;

procedure TjdxList.Set_onItemReordered(const Value: TdxEventHandler);
begin
  FonItemReordered := Value;
end;

procedure TjdxList.Set_onItemSwipe(const Value: TdxEventHandler);
begin
  FonItemSwipe := Value;
end;

procedure TjdxList.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxList.Set_onPageLoading(const Value: TdxEventHandler);
begin
  FonPageLoading := Value;
end;

procedure TjdxList.Set_onPullRefresh(const Value: TdxEventHandler);
begin
  FonPullRefresh := Value;
end;

procedure TjdxList.Set_onScroll(const Value: TdxEventHandler);
begin
  FonScroll := Value;
end;

procedure TjdxList.Set_onSelectAllValueChanged(const Value: TdxEventHandler);
begin
  FonSelectAllValueChanged := Value;
end;

procedure TjdxList.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
end;

end.
