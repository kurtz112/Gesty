unit DevExtreme.Gallery.Custom;

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
  DevExtreme.Gallery.JS,
  DevExtreme.Types;

type
  TjdxCustomGallery = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FanimationDuration: integer;
    FanimationEnabled: boolean;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusedElement: TJSElement;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FindicatorEnabled: boolean;
    FinitialItemWidth: integer;
    FitemHoldTimeout: integer;
    Fitems: TJSArray;
    FitemTemplate: JSValue;
    FkeyExpr: JSValue;
    Floop: boolean;
    FloopItemFocus: boolean;
    FnoDataText: string;
    FrtlEnabled: boolean;
    FselectedIndex: integer;
    FselectedItem: JSValue;
    FselectedItemKeys: TJSArray;
    FselectedItems: TJSArray;
    FselectionByClick: boolean;
    FselectionMode: TCollectionWidgetSelectionMode;
    FselectionRequired: boolean;
    FselectOnFocus: boolean;
    FshowIndicator: boolean;
    FshowNavButtons: boolean;
    FslideshowDelay: integer;
    FstretchImages: boolean;
    FswipeEnabled: boolean;
    FtabIndex: integer;
    Fvisible: boolean;
    Fwidth_: JSValue;
    FwrapAround: boolean;
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
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_animationDuration(const value: integer);
    procedure Set_animationEnabled(const value: boolean);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusedElement(const value: TJSElement);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_indicatorEnabled(const value: boolean);
    procedure Set_initialItemWidth(const value: integer);
    procedure Set_itemHoldTimeout(const value: integer);
    procedure Set_items(const value: TJSArray);
    procedure Set_itemTemplate(const value: JSValue);
    procedure Set_keyExpr(const value: JSValue);
    procedure Set_loop(const value: boolean);
    procedure Set_loopItemFocus(const value: boolean);
    procedure Set_noDataText(const value: string);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_selectedIndex(const value: integer);
    procedure Set_selectedItem(const value: JSValue);
    procedure Set_selectedItemKeys(const value: TJSArray);
    procedure Set_selectedItems(const value: TJSArray);
    procedure Set_selectionByClick(const value: boolean);
    procedure Set_selectionMode(const value: TCollectionWidgetSelectionMode);
    procedure Set_selectionRequired(const value: boolean);
    procedure Set_selectOnFocus(const value: boolean);
    procedure Set_showIndicator(const value: boolean);
    procedure Set_showNavButtons(const value: boolean);
    procedure Set_slideshowDelay(const value: integer);
    procedure Set_stretchImages(const value: boolean);
    procedure Set_swipeEnabled(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
    procedure Set_wrapAround(const value: boolean);
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
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxGallery; assembler;
    function instance: TdxGallery; assembler;
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
    function goToItem(itemIndex: integer; animation: boolean): TJSPromise; assembler;
    function isItemSelected(itemElement: TJSElement): boolean; assembler;
    function itemElements(): TJSArray; assembler;
    function itemsContainer(): TJSElement; assembler;
    function nextItem(animation: boolean): TJSPromise; assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    function prevItem(animation: boolean): TJSPromise; assembler;
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
    property keyExpr: JSValue read FkeyExpr write Set_keyExpr;
    property selectedItem: JSValue read FselectedItem write Set_selectedItem;
    property selectedItemKeys: TJSArray read FselectedItemKeys write Set_selectedItemKeys;
    property selectedItems: TJSArray read FselectedItems write Set_selectedItems;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property animationDuration: integer read FanimationDuration write Set_animationDuration;
    property animationEnabled: boolean read FanimationEnabled write Set_animationEnabled default true;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property indicatorEnabled: boolean read FindicatorEnabled write Set_indicatorEnabled default true;
    property initialItemWidth: integer read FinitialItemWidth write Set_initialItemWidth;
    property itemHoldTimeout: integer read FitemHoldTimeout write Set_itemHoldTimeout;
    property loop: boolean read Floop write Set_loop default false;
    property loopItemFocus: boolean read FloopItemFocus write Set_loopItemFocus;
    property noDataText: string read FnoDataText write Set_noDataText;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property selectedIndex: integer read FselectedIndex write Set_selectedIndex;
    property selectionByClick: boolean read FselectionByClick write Set_selectionByClick default true;
    property selectionMode: TCollectionWidgetSelectionMode read FselectionMode write Set_selectionMode default cwsmNone;
    property selectionRequired: boolean read FselectionRequired write Set_selectionRequired default false;
    property selectOnFocus: boolean read FselectOnFocus write Set_selectOnFocus;
    property showIndicator: boolean read FshowIndicator write Set_showIndicator default true;
    property showNavButtons: boolean read FshowNavButtons write Set_showNavButtons default false;
    property slideshowDelay: integer read FslideshowDelay write Set_slideshowDelay;
    property stretchImages: boolean read FstretchImages write Set_stretchImages default false;
    property swipeEnabled: boolean read FswipeEnabled write Set_swipeEnabled default true;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
    property wrapAround: boolean read FwrapAround write Set_wrapAround default false;
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
  end;

implementation


procedure TjdxCustomGallery.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FanimationDuration := 0;
  FanimationEnabled := true;
  FdataSource := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusedElement := nil;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FindicatorEnabled := true;
  FinitialItemWidth := 0;
  FitemHoldTimeout := 0;
  Fitems := TJSArray.new;
  FitemTemplate := nil;
  FkeyExpr := nil;
  Floop := false;
  FloopItemFocus := false;
  FnoDataText := '';
  FrtlEnabled := false;
  FselectedIndex := 0;
  FselectedItem := nil;
  FselectedItemKeys := TJSArray.new;
  FselectedItems := TJSArray.new;
  FselectionByClick := true;
  FselectionMode := cwsmNone;
  FselectionRequired := false;
  FselectOnFocus := false;
  FshowIndicator := true;
  FshowNavButtons := false;
  FslideshowDelay := 0;
  FstretchImages := false;
  FswipeEnabled := true;
  FtabIndex := 0;
  Fvisible := true;
  Fwidth_ := nil;
  FwrapAround := false;

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
end;
procedure TjdxCustomGallery.InitJQuery;
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
      $(id).dxGallery(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomGallery.getInstance(element: TJSObject): TdxGallery;
asm
  return DevExpress.viz.dxGallery.getInstance(element);
end;

function TjdxCustomGallery.instance: TdxGallery;
asm
  return $(this.GetJQID()).dxGallery("instance");
end;
procedure TjdxCustomGallery.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('animationDuration', animationDuration);
    SetOption('animationEnabled', animationEnabled);
    SetOption('dataSource', dataSource);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('focusedElement', focusedElement);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('indicatorEnabled', indicatorEnabled);
    SetOption('initialItemWidth', initialItemWidth);
    SetOption('itemHoldTimeout', itemHoldTimeout);
    SetOption('items', items);
    SetOption('itemTemplate', itemTemplate);
    SetOption('keyExpr', keyExpr);
    SetOption('loop', loop);
    SetOption('loopItemFocus', loopItemFocus);
    SetOption('noDataText', noDataText);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('selectedIndex', selectedIndex);
    SetOption('selectedItem', selectedItem);
    SetOption('selectedItemKeys', selectedItemKeys);
    SetOption('selectedItems', selectedItems);
    SetOption('selectionByClick', selectionByClick);
    SetOption('selectionMode', selectionMode.ToString());
    SetOption('selectionRequired', selectionRequired);
    SetOption('selectOnFocus', selectOnFocus);
    SetOption('showIndicator', showIndicator);
    SetOption('showNavButtons', showNavButtons);
    SetOption('slideshowDelay', slideshowDelay);
    SetOption('stretchImages', stretchImages);
    SetOption('swipeEnabled', swipeEnabled);
    SetOption('tabIndex', tabIndex);
    SetOption('visible', visible);
    SetOption('width', width_);
    SetOption('wrapAround', wrapAround);

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
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomGallery.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomGallery.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomGallery.Set_animationDuration(const Value: integer);
begin
  FanimationDuration := Value;
  SetOption('animationDuration', animationDuration);
end;

procedure TjdxCustomGallery.Set_animationEnabled(const Value: boolean);
begin
  FanimationEnabled := Value;
  SetOption('animationEnabled', animationEnabled);
end;

procedure TjdxCustomGallery.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomGallery.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomGallery.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomGallery.Set_focusedElement(const Value: TJSElement);
begin
  FfocusedElement := Value;
  SetOption('focusedElement', focusedElement);
end;

procedure TjdxCustomGallery.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomGallery.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomGallery.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomGallery.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomGallery.Set_indicatorEnabled(const Value: boolean);
begin
  FindicatorEnabled := Value;
  SetOption('indicatorEnabled', indicatorEnabled);
end;

procedure TjdxCustomGallery.Set_initialItemWidth(const Value: integer);
begin
  FinitialItemWidth := Value;
  SetOption('initialItemWidth', initialItemWidth);
end;

procedure TjdxCustomGallery.Set_itemHoldTimeout(const Value: integer);
begin
  FitemHoldTimeout := Value;
  SetOption('itemHoldTimeout', itemHoldTimeout);
end;

procedure TjdxCustomGallery.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
  SetOption('items', items);
end;

procedure TjdxCustomGallery.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
  SetOption('itemTemplate', itemTemplate);
end;

procedure TjdxCustomGallery.Set_keyExpr(const Value: JSValue);
begin
  FkeyExpr := Value;
  SetOption('keyExpr', keyExpr);
end;

procedure TjdxCustomGallery.Set_loop(const Value: boolean);
begin
  Floop := Value;
  SetOption('loop', loop);
end;

procedure TjdxCustomGallery.Set_loopItemFocus(const Value: boolean);
begin
  FloopItemFocus := Value;
  SetOption('loopItemFocus', loopItemFocus);
end;

procedure TjdxCustomGallery.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
  SetOption('noDataText', noDataText);
end;

procedure TjdxCustomGallery.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomGallery.Set_selectedIndex(const Value: integer);
begin
  FselectedIndex := Value;
  SetOption('selectedIndex', selectedIndex);
end;

procedure TjdxCustomGallery.Set_selectedItem(const Value: JSValue);
begin
  FselectedItem := Value;
  SetOption('selectedItem', selectedItem);
end;

procedure TjdxCustomGallery.Set_selectedItemKeys(const Value: TJSArray);
begin
  FselectedItemKeys := Value;
  SetOption('selectedItemKeys', selectedItemKeys);
end;

procedure TjdxCustomGallery.Set_selectedItems(const Value: TJSArray);
begin
  FselectedItems := Value;
  SetOption('selectedItems', selectedItems);
end;

procedure TjdxCustomGallery.Set_selectionByClick(const Value: boolean);
begin
  FselectionByClick := Value;
  SetOption('selectionByClick', selectionByClick);
end;

procedure TjdxCustomGallery.Set_selectionMode(const Value: TCollectionWidgetSelectionMode);
begin
  FselectionMode := Value;
  SetOption('selectionMode', selectionMode.ToString());
end;

procedure TjdxCustomGallery.Set_selectionRequired(const Value: boolean);
begin
  FselectionRequired := Value;
  SetOption('selectionRequired', selectionRequired);
end;

procedure TjdxCustomGallery.Set_selectOnFocus(const Value: boolean);
begin
  FselectOnFocus := Value;
  SetOption('selectOnFocus', selectOnFocus);
end;

procedure TjdxCustomGallery.Set_showIndicator(const Value: boolean);
begin
  FshowIndicator := Value;
  SetOption('showIndicator', showIndicator);
end;

procedure TjdxCustomGallery.Set_showNavButtons(const Value: boolean);
begin
  FshowNavButtons := Value;
  SetOption('showNavButtons', showNavButtons);
end;

procedure TjdxCustomGallery.Set_slideshowDelay(const Value: integer);
begin
  FslideshowDelay := Value;
  SetOption('slideshowDelay', slideshowDelay);
end;

procedure TjdxCustomGallery.Set_stretchImages(const Value: boolean);
begin
  FstretchImages := Value;
  SetOption('stretchImages', stretchImages);
end;

procedure TjdxCustomGallery.Set_swipeEnabled(const Value: boolean);
begin
  FswipeEnabled := Value;
  SetOption('swipeEnabled', swipeEnabled);
end;

procedure TjdxCustomGallery.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomGallery.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomGallery.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomGallery.Set_wrapAround(const Value: boolean);
begin
  FwrapAround := Value;
  SetOption('wrapAround', wrapAround);
end;

procedure TjdxCustomGallery.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomGallery.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomGallery.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomGallery.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomGallery.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomGallery.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
  SetEvent('itemClick', onItemClick);
end;

procedure TjdxCustomGallery.Set_onItemContextMenu(const Value: TdxEventHandler);
begin
  FonItemContextMenu := Value;
  SetEvent('itemContextMenu', onItemContextMenu);
end;

procedure TjdxCustomGallery.Set_onItemDeleted(const Value: TdxEventHandler);
begin
  FonItemDeleted := Value;
  SetEvent('itemDeleted', onItemDeleted);
end;

procedure TjdxCustomGallery.Set_onItemDeleting(const Value: TdxEventHandler);
begin
  FonItemDeleting := Value;
  SetEvent('itemDeleting', onItemDeleting);
end;

procedure TjdxCustomGallery.Set_onItemHold(const Value: TdxEventHandler);
begin
  FonItemHold := Value;
  SetEvent('itemHold', onItemHold);
end;

procedure TjdxCustomGallery.Set_onItemRendered(const Value: TdxEventHandler);
begin
  FonItemRendered := Value;
  SetEvent('itemRendered', onItemRendered);
end;

procedure TjdxCustomGallery.Set_onItemReordered(const Value: TdxEventHandler);
begin
  FonItemReordered := Value;
  SetEvent('itemReordered', onItemReordered);
end;

procedure TjdxCustomGallery.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomGallery.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomGallery.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomGallery.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomGallery.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomGallery.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  _instance.defaultOptions(rule);
end;

function TjdxCustomGallery.deleteItem(itemElement: TJSElement): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.deleteItem(itemElement);
end;

procedure TjdxCustomGallery.dispose();
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  _instance.dispose();
end;

function TjdxCustomGallery.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.element();
end;

procedure TjdxCustomGallery.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomGallery.focus();
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  _instance.focus();
end;

function TjdxCustomGallery.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.getDataSource();
end;

function TjdxCustomGallery.getFocusedItemId(): string;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.getFocusedItemId();
end;

function TjdxCustomGallery.goToItem(itemIndex: integer; animation: boolean): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.goToItem(itemIndex, animation);
end;

function TjdxCustomGallery.isItemSelected(itemElement: TJSElement): boolean;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.isItemSelected(itemElement);
end;

function TjdxCustomGallery.itemElements(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.itemElements();
end;

function TjdxCustomGallery.itemsContainer(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.itemsContainer();
end;

function TjdxCustomGallery.nextItem(animation: boolean): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.nextItem(animation);
end;

function TjdxCustomGallery.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomGallery.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.off(eventName);
end;

function TjdxCustomGallery.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.on(events);
end;

function TjdxCustomGallery.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomGallery.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.option(optionName);
end;

function TjdxCustomGallery.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.option();
end;

procedure TjdxCustomGallery.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomGallery.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  _instance.option(options);
end;

function TjdxCustomGallery.prevItem(animation: boolean): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.prevItem(animation);
end;

procedure TjdxCustomGallery.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  _instance.registerKeyHandler(key, handler);
end;

function TjdxCustomGallery.reorderItem(itemElement: TJSElement; toItemElement: TJSElement): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  return _instance.reorderItem(itemElement, toItemElement);
end;

procedure TjdxCustomGallery.repaint();
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  _instance.repaint();
end;

procedure TjdxCustomGallery.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomGallery.selectItem(itemElement: TJSElement);
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  _instance.selectItem(itemElement);
end;

procedure TjdxCustomGallery.unselectItem(itemElement: TJSElement);
asm
  const _instance = $(this.GetJQID()).dxGallery("instance");
  _instance.unselectItem(itemElement);
end;

end.
