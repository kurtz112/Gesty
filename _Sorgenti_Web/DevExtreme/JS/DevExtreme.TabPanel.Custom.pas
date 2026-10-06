unit DevExtreme.TabPanel.Custom;

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
  DevExtreme.TabPanel.JS,
  DevExtreme.Types;

type
  TjdxCustomTabPanel = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FanimationEnabled: boolean;
    FdataSource: JSValue;
    FdeferRendering: boolean;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusedElement: TJSElement;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FitemHoldTimeout: integer;
    Fitems: TJSArray;
    FitemTemplate: JSValue;
    FitemTitleTemplate: JSValue;
    FkeyExpr: JSValue;
    Floop: boolean;
    FloopItemFocus: boolean;
    FnoDataText: string;
    FrepaintChangesOnly: boolean;
    FrtlEnabled: boolean;
    FscrollByContent: boolean;
    FscrollingEnabled: boolean;
    FselectedIndex: integer;
    FselectedItem: JSValue;
    FselectedItemKeys: TJSArray;
    FselectedItems: TJSArray;
    FselectionByClick: boolean;
    FselectionMode: TCollectionWidgetSelectionMode;
    FselectionRequired: boolean;
    FselectOnFocus: boolean;
    FshowNavButtons: boolean;
    FswipeEnabled: boolean;
    FtabIndex: integer;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonItemClick: TdxEventHandler;
    FonItemContextMenu: TdxEventHandler;
    FonItemDeleted: TdxEventHandler;
    FonItemDeleting: TdxEventHandler;
    FonItemHold: TdxEventHandler;
    FonItemRendered: TdxEventHandler;
    FonItemReordered: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
    FonTitleClick: TdxEventHandler;
    FonTitleHold: TdxEventHandler;
    FonTitleRendered: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_animationEnabled(const value: boolean);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_deferRendering(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusedElement(const value: TJSElement);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_itemHoldTimeout(const value: integer);
    procedure Set_items(const value: TJSArray);
    procedure Set_itemTemplate(const value: JSValue);
    procedure Set_itemTitleTemplate(const value: JSValue);
    procedure Set_keyExpr(const value: JSValue);
    procedure Set_loop(const value: boolean);
    procedure Set_loopItemFocus(const value: boolean);
    procedure Set_noDataText(const value: string);
    procedure Set_repaintChangesOnly(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scrollByContent(const value: boolean);
    procedure Set_scrollingEnabled(const value: boolean);
    procedure Set_selectedIndex(const value: integer);
    procedure Set_selectedItem(const value: JSValue);
    procedure Set_selectedItemKeys(const value: TJSArray);
    procedure Set_selectedItems(const value: TJSArray);
    procedure Set_selectionByClick(const value: boolean);
    procedure Set_selectionMode(const value: TCollectionWidgetSelectionMode);
    procedure Set_selectionRequired(const value: boolean);
    procedure Set_selectOnFocus(const value: boolean);
    procedure Set_showNavButtons(const value: boolean);
    procedure Set_swipeEnabled(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onItemClick(const value: TdxEventHandler);
    procedure Set_onItemContextMenu(const value: TdxEventHandler);
    procedure Set_onItemDeleted(const value: TdxEventHandler);
    procedure Set_onItemDeleting(const value: TdxEventHandler);
    procedure Set_onItemHold(const value: TdxEventHandler);
    procedure Set_onItemRendered(const value: TdxEventHandler);
    procedure Set_onItemReordered(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
    procedure Set_onTitleClick(const value: TdxEventHandler);
    procedure Set_onTitleHold(const value: TdxEventHandler);
    procedure Set_onTitleRendered(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxTabPanel; assembler;
    function instance: TdxTabPanel; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    function deleteItem(itemElement: TJSElement): TJSPromise; assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler;
    function getDataSource(): TJSObject; assembler;
    function getFocusedItemId(): string; assembler;
    function isItemSelected(itemElement: TJSElement): boolean; assembler;
    function itemElements(): TJSArray; assembler;
    function itemsContainer(): TJSElement; assembler;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    function reorderItem(itemElement: TJSElement; toItemElement: TJSElement): TJSPromise; assembler;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure selectItem(itemElement: TJSElement); assembler;
    procedure unselectItem(itemElement: TJSElement); assembler;
  public
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property focusedElement: TJSElement read FfocusedElement write Set_focusedElement;
    property height_: JSValue read Fheight_ write Set_height_;
    property items: TJSArray read Fitems write Set_items;
    property itemTemplate: JSValue read FitemTemplate write Set_itemTemplate;
    property itemTitleTemplate: JSValue read FitemTitleTemplate write Set_itemTitleTemplate;
    property keyExpr: JSValue read FkeyExpr write Set_keyExpr;
    property selectedItem: JSValue read FselectedItem write Set_selectedItem;
    property selectedItemKeys: TJSArray read FselectedItemKeys write Set_selectedItemKeys;
    property selectedItems: TJSArray read FselectedItems write Set_selectedItems;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property animationEnabled: boolean read FanimationEnabled write Set_animationEnabled default true;
    property deferRendering: boolean read FdeferRendering write Set_deferRendering default true;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property itemHoldTimeout: integer read FitemHoldTimeout write Set_itemHoldTimeout;
    property loop: boolean read Floop write Set_loop default false;
    property loopItemFocus: boolean read FloopItemFocus write Set_loopItemFocus;
    property noDataText: string read FnoDataText write Set_noDataText;
    property repaintChangesOnly: boolean read FrepaintChangesOnly write Set_repaintChangesOnly default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property scrollByContent: boolean read FscrollByContent write Set_scrollByContent default true;
    property scrollingEnabled: boolean read FscrollingEnabled write Set_scrollingEnabled default true;
    property selectedIndex: integer read FselectedIndex write Set_selectedIndex;
    property selectionByClick: boolean read FselectionByClick write Set_selectionByClick default true;
    property selectionMode: TCollectionWidgetSelectionMode read FselectionMode write Set_selectionMode default cwsmNone;
    property selectionRequired: boolean read FselectionRequired write Set_selectionRequired default false;
    property selectOnFocus: boolean read FselectOnFocus write Set_selectOnFocus;
    property showNavButtons: boolean read FshowNavButtons write Set_showNavButtons default false;
    property swipeEnabled: boolean read FswipeEnabled write Set_swipeEnabled default true;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onItemClick: TdxEventHandler read FonItemClick write Set_onItemClick;
    property onItemContextMenu: TdxEventHandler read FonItemContextMenu write Set_onItemContextMenu;
    property onItemDeleted: TdxEventHandler read FonItemDeleted write Set_onItemDeleted;
    property onItemDeleting: TdxEventHandler read FonItemDeleting write Set_onItemDeleting;
    property onItemHold: TdxEventHandler read FonItemHold write Set_onItemHold;
    property onItemRendered: TdxEventHandler read FonItemRendered write Set_onItemRendered;
    property onItemReordered: TdxEventHandler read FonItemReordered write Set_onItemReordered;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
    property onTitleClick: TdxEventHandler read FonTitleClick write Set_onTitleClick;
    property onTitleHold: TdxEventHandler read FonTitleHold write Set_onTitleHold;
    property onTitleRendered: TdxEventHandler read FonTitleRendered write Set_onTitleRendered;
  end;

implementation


procedure TjdxCustomTabPanel.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FanimationEnabled := true;
  FdataSource := nil;
  FdeferRendering := true;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusedElement := nil;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FitemHoldTimeout := 0;
  Fitems := TJSArray.new;
  FitemTemplate := nil;
  FitemTitleTemplate := nil;
  FkeyExpr := nil;
  Floop := false;
  FloopItemFocus := false;
  FnoDataText := '';
  FrepaintChangesOnly := false;
  FrtlEnabled := false;
  FscrollByContent := true;
  FscrollingEnabled := true;
  FselectedIndex := 0;
  FselectedItem := nil;
  FselectedItemKeys := TJSArray.new;
  FselectedItems := TJSArray.new;
  FselectionByClick := true;
  FselectionMode := cwsmNone;
  FselectionRequired := false;
  FselectOnFocus := false;
  FshowNavButtons := false;
  FswipeEnabled := true;
  FtabIndex := 0;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonItemClick := nil;
  FonItemContextMenu := nil;
  FonItemDeleted := nil;
  FonItemDeleting := nil;
  FonItemHold := nil;
  FonItemRendered := nil;
  FonItemReordered := nil;
  FonOptionChanged := nil;
  FonSelectionChanged := nil;
  FonTitleClick := nil;
  FonTitleHold := nil;
  FonTitleRendered := nil;
end;
procedure TjdxCustomTabPanel.InitJQuery;
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
      $(id).dxTabPanel(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomTabPanel.getInstance(element: TJSObject): TdxTabPanel;
asm
  return DevExpress.viz.dxTabPanel.getInstance(element);
end;

function TjdxCustomTabPanel.instance: TdxTabPanel;
asm
  return $(this.GetJQID()).dxTabPanel("instance");
end;
procedure TjdxCustomTabPanel.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('animationEnabled', animationEnabled);
    SetOption('dataSource', dataSource);
    SetOption('deferRendering', deferRendering);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('focusedElement', focusedElement);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('itemHoldTimeout', itemHoldTimeout);
    SetOption('items', items);
    SetOption('itemTemplate', itemTemplate);
    SetOption('itemTitleTemplate', itemTitleTemplate);
    SetOption('keyExpr', keyExpr);
    SetOption('loop', loop);
    SetOption('loopItemFocus', loopItemFocus);
    SetOption('noDataText', noDataText);
    SetOption('repaintChangesOnly', repaintChangesOnly);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('scrollByContent', scrollByContent);
    SetOption('scrollingEnabled', scrollingEnabled);
    SetOption('selectedIndex', selectedIndex);
    SetOption('selectedItem', selectedItem);
    SetOption('selectedItemKeys', selectedItemKeys);
    SetOption('selectedItems', selectedItems);
    SetOption('selectionByClick', selectionByClick);
    SetOption('selectionMode', selectionMode.ToString());
    SetOption('selectionRequired', selectionRequired);
    SetOption('selectOnFocus', selectOnFocus);
    SetOption('showNavButtons', showNavButtons);
    SetOption('swipeEnabled', swipeEnabled);
    SetOption('tabIndex', tabIndex);
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('itemClick', onItemClick);
    SetEvent('itemContextMenu', onItemContextMenu);
    SetEvent('itemDeleted', onItemDeleted);
    SetEvent('itemDeleting', onItemDeleting);
    SetEvent('itemHold', onItemHold);
    SetEvent('itemRendered', onItemRendered);
    SetEvent('itemReordered', onItemReordered);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('selectionChanged', onSelectionChanged);
    SetEvent('titleClick', onTitleClick);
    SetEvent('titleHold', onTitleHold);
    SetEvent('titleRendered', onTitleRendered);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomTabPanel.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomTabPanel.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomTabPanel.Set_animationEnabled(const Value: boolean);
begin
  FanimationEnabled := Value;
  SetOption('animationEnabled', animationEnabled);
end;

procedure TjdxCustomTabPanel.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomTabPanel.Set_deferRendering(const Value: boolean);
begin
  FdeferRendering := Value;
  SetOption('deferRendering', deferRendering);
end;

procedure TjdxCustomTabPanel.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomTabPanel.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomTabPanel.Set_focusedElement(const Value: TJSElement);
begin
  FfocusedElement := Value;
  SetOption('focusedElement', focusedElement);
end;

procedure TjdxCustomTabPanel.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomTabPanel.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomTabPanel.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomTabPanel.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomTabPanel.Set_itemHoldTimeout(const Value: integer);
begin
  FitemHoldTimeout := Value;
  SetOption('itemHoldTimeout', itemHoldTimeout);
end;

procedure TjdxCustomTabPanel.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
  SetOption('items', items);
end;

procedure TjdxCustomTabPanel.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
  SetOption('itemTemplate', itemTemplate);
end;

procedure TjdxCustomTabPanel.Set_itemTitleTemplate(const Value: JSValue);
begin
  FitemTitleTemplate := Value;
  SetOption('itemTitleTemplate', itemTitleTemplate);
end;

procedure TjdxCustomTabPanel.Set_keyExpr(const Value: JSValue);
begin
  FkeyExpr := Value;
  SetOption('keyExpr', keyExpr);
end;

procedure TjdxCustomTabPanel.Set_loop(const Value: boolean);
begin
  Floop := Value;
  SetOption('loop', loop);
end;

procedure TjdxCustomTabPanel.Set_loopItemFocus(const Value: boolean);
begin
  FloopItemFocus := Value;
  SetOption('loopItemFocus', loopItemFocus);
end;

procedure TjdxCustomTabPanel.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
  SetOption('noDataText', noDataText);
end;

procedure TjdxCustomTabPanel.Set_repaintChangesOnly(const Value: boolean);
begin
  FrepaintChangesOnly := Value;
  SetOption('repaintChangesOnly', repaintChangesOnly);
end;

procedure TjdxCustomTabPanel.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomTabPanel.Set_scrollByContent(const Value: boolean);
begin
  FscrollByContent := Value;
  SetOption('scrollByContent', scrollByContent);
end;

procedure TjdxCustomTabPanel.Set_scrollingEnabled(const Value: boolean);
begin
  FscrollingEnabled := Value;
  SetOption('scrollingEnabled', scrollingEnabled);
end;

procedure TjdxCustomTabPanel.Set_selectedIndex(const Value: integer);
begin
  FselectedIndex := Value;
  SetOption('selectedIndex', selectedIndex);
end;

procedure TjdxCustomTabPanel.Set_selectedItem(const Value: JSValue);
begin
  FselectedItem := Value;
  SetOption('selectedItem', selectedItem);
end;

procedure TjdxCustomTabPanel.Set_selectedItemKeys(const Value: TJSArray);
begin
  FselectedItemKeys := Value;
  SetOption('selectedItemKeys', selectedItemKeys);
end;

procedure TjdxCustomTabPanel.Set_selectedItems(const Value: TJSArray);
begin
  FselectedItems := Value;
  SetOption('selectedItems', selectedItems);
end;

procedure TjdxCustomTabPanel.Set_selectionByClick(const Value: boolean);
begin
  FselectionByClick := Value;
  SetOption('selectionByClick', selectionByClick);
end;

procedure TjdxCustomTabPanel.Set_selectionMode(const Value: TCollectionWidgetSelectionMode);
begin
  FselectionMode := Value;
  SetOption('selectionMode', selectionMode.ToString());
end;

procedure TjdxCustomTabPanel.Set_selectionRequired(const Value: boolean);
begin
  FselectionRequired := Value;
  SetOption('selectionRequired', selectionRequired);
end;

procedure TjdxCustomTabPanel.Set_selectOnFocus(const Value: boolean);
begin
  FselectOnFocus := Value;
  SetOption('selectOnFocus', selectOnFocus);
end;

procedure TjdxCustomTabPanel.Set_showNavButtons(const Value: boolean);
begin
  FshowNavButtons := Value;
  SetOption('showNavButtons', showNavButtons);
end;

procedure TjdxCustomTabPanel.Set_swipeEnabled(const Value: boolean);
begin
  FswipeEnabled := Value;
  SetOption('swipeEnabled', swipeEnabled);
end;

procedure TjdxCustomTabPanel.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomTabPanel.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomTabPanel.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomTabPanel.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomTabPanel.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomTabPanel.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomTabPanel.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomTabPanel.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomTabPanel.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
  SetEvent('itemClick', onItemClick);
end;

procedure TjdxCustomTabPanel.Set_onItemContextMenu(const Value: TdxEventHandler);
begin
  FonItemContextMenu := Value;
  SetEvent('itemContextMenu', onItemContextMenu);
end;

procedure TjdxCustomTabPanel.Set_onItemDeleted(const Value: TdxEventHandler);
begin
  FonItemDeleted := Value;
  SetEvent('itemDeleted', onItemDeleted);
end;

procedure TjdxCustomTabPanel.Set_onItemDeleting(const Value: TdxEventHandler);
begin
  FonItemDeleting := Value;
  SetEvent('itemDeleting', onItemDeleting);
end;

procedure TjdxCustomTabPanel.Set_onItemHold(const Value: TdxEventHandler);
begin
  FonItemHold := Value;
  SetEvent('itemHold', onItemHold);
end;

procedure TjdxCustomTabPanel.Set_onItemRendered(const Value: TdxEventHandler);
begin
  FonItemRendered := Value;
  SetEvent('itemRendered', onItemRendered);
end;

procedure TjdxCustomTabPanel.Set_onItemReordered(const Value: TdxEventHandler);
begin
  FonItemReordered := Value;
  SetEvent('itemReordered', onItemReordered);
end;

procedure TjdxCustomTabPanel.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomTabPanel.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomTabPanel.Set_onTitleClick(const Value: TdxEventHandler);
begin
  FonTitleClick := Value;
  SetEvent('titleClick', onTitleClick);
end;

procedure TjdxCustomTabPanel.Set_onTitleHold(const Value: TdxEventHandler);
begin
  FonTitleHold := Value;
  SetEvent('titleHold', onTitleHold);
end;

procedure TjdxCustomTabPanel.Set_onTitleRendered(const Value: TdxEventHandler);
begin
  FonTitleRendered := Value;
  SetEvent('titleRendered', onTitleRendered);
end;

procedure TjdxCustomTabPanel.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomTabPanel.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomTabPanel.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomTabPanel.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  _instance.defaultOptions(rule);
end;

function TjdxCustomTabPanel.deleteItem(itemElement: TJSElement): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  return _instance.deleteItem(itemElement);
end;

procedure TjdxCustomTabPanel.dispose();
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  _instance.dispose();
end;

function TjdxCustomTabPanel.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  return _instance.element();
end;

procedure TjdxCustomTabPanel.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomTabPanel.focus();
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  _instance.focus();
end;

function TjdxCustomTabPanel.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  return _instance.getDataSource();
end;

function TjdxCustomTabPanel.getFocusedItemId(): string;
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  return _instance.getFocusedItemId();
end;

function TjdxCustomTabPanel.isItemSelected(itemElement: TJSElement): boolean;
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  return _instance.isItemSelected(itemElement);
end;

function TjdxCustomTabPanel.itemElements(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  return _instance.itemElements();
end;

function TjdxCustomTabPanel.itemsContainer(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  return _instance.itemsContainer();
end;

function TjdxCustomTabPanel.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  return _instance.off(eventName);
end;

function TjdxCustomTabPanel.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomTabPanel.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  return _instance.on(events);
end;

function TjdxCustomTabPanel.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomTabPanel.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomTabPanel.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomTabPanel.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  return _instance.option();
end;

procedure TjdxCustomTabPanel.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  _instance.option(options);
end;

procedure TjdxCustomTabPanel.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  _instance.registerKeyHandler(key, handler);
end;

function TjdxCustomTabPanel.reorderItem(itemElement: TJSElement; toItemElement: TJSElement): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  return _instance.reorderItem(itemElement, toItemElement);
end;

procedure TjdxCustomTabPanel.repaint();
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  _instance.repaint();
end;

procedure TjdxCustomTabPanel.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomTabPanel.selectItem(itemElement: TJSElement);
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  _instance.selectItem(itemElement);
end;

procedure TjdxCustomTabPanel.unselectItem(itemElement: TJSElement);
asm
  const _instance = $(this.GetJQID()).dxTabPanel("instance");
  _instance.unselectItem(itemElement);
end;

end.
