unit DevExtreme.MenuBase.Custom;

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
  DevExtreme.MenuBase.JS,
  DevExtreme.Types;

type
  TjdxCustomMenuBase = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fanimation: TJSObject;
    FcssClass: string;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FdisabledExpr: JSValue;
    FdisplayExpr: JSValue;
    FelementAttr: TJSObject;
    FexpandedExpr: JSValue;
    FfocusedElement: TJSElement;
    FfocusStateEnabled: boolean;
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
    FrtlEnabled: boolean;
    FselectByClick: boolean;
    FselectedExpr: JSValue;
    FselectedIndex: integer;
    FselectedItem: JSValue;
    FselectedItemKeys: TJSArray;
    FselectedItems: TJSArray;
    FselectionByClick: boolean;
    FselectionMode: TCollectionWidgetSelectionMode;
    FselectionRequired: boolean;
    FselectOnFocus: boolean;
    FshowSubmenuMode: TJSObject;
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
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_animation(const value: TJSObject);
    procedure Set_cssClass(const value: string);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_disabledExpr(const value: JSValue);
    procedure Set_displayExpr(const value: JSValue);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_expandedExpr(const value: JSValue);
    procedure Set_focusedElement(const value: TJSElement);
    procedure Set_focusStateEnabled(const value: boolean);
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
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_selectByClick(const value: boolean);
    procedure Set_selectedExpr(const value: JSValue);
    procedure Set_selectedIndex(const value: integer);
    procedure Set_selectedItem(const value: JSValue);
    procedure Set_selectedItemKeys(const value: TJSArray);
    procedure Set_selectedItems(const value: TJSArray);
    procedure Set_selectionByClick(const value: boolean);
    procedure Set_selectionMode(const value: TCollectionWidgetSelectionMode);
    procedure Set_selectionRequired(const value: boolean);
    procedure Set_selectOnFocus(const value: boolean);
    procedure Set_showSubmenuMode(const value: TJSObject);
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
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxMenuBase; assembler;
    function instance: TdxMenuBase; assembler;
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
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(): TJSObject; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    function reorderItem(itemElement: TJSElement; toItemElement: TJSElement): TJSPromise; assembler;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure selectItem(itemElement: TJSElement); assembler; overload;
    procedure unselectItem(itemElement: TJSElement); assembler; overload;
  public
    property animation: TJSObject read Fanimation write Set_animation;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property disabledExpr: JSValue read FdisabledExpr write Set_disabledExpr;
    property displayExpr: JSValue read FdisplayExpr write Set_displayExpr;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property expandedExpr: JSValue read FexpandedExpr write Set_expandedExpr;
    property focusedElement: TJSElement read FfocusedElement write Set_focusedElement;
    property height_: JSValue read Fheight_ write Set_height_;
    property items: TJSArray read Fitems write Set_items;
    property itemsExpr: JSValue read FitemsExpr write Set_itemsExpr;
    property itemTemplate: JSValue read FitemTemplate write Set_itemTemplate;
    property keyExpr: JSValue read FkeyExpr write Set_keyExpr;
    property parentIdExpr: JSValue read FparentIdExpr write Set_parentIdExpr;
    property selectedExpr: JSValue read FselectedExpr write Set_selectedExpr;
    property selectedItem: JSValue read FselectedItem write Set_selectedItem;
    property selectedItemKeys: TJSArray read FselectedItemKeys write Set_selectedItemKeys;
    property selectedItems: TJSArray read FselectedItems write Set_selectedItems;
    property showSubmenuMode: TJSObject read FshowSubmenuMode write Set_showSubmenuMode;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property cssClass: string read FcssClass write Set_cssClass;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property itemHoldTimeout: integer read FitemHoldTimeout write Set_itemHoldTimeout;
    property loopItemFocus: boolean read FloopItemFocus write Set_loopItemFocus;
    property noDataText: string read FnoDataText write Set_noDataText;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property selectByClick: boolean read FselectByClick write Set_selectByClick default false;
    property selectedIndex: integer read FselectedIndex write Set_selectedIndex;
    property selectionByClick: boolean read FselectionByClick write Set_selectionByClick default true;
    property selectionMode: TCollectionWidgetSelectionMode read FselectionMode write Set_selectionMode default cwsmNone;
    property selectionRequired: boolean read FselectionRequired write Set_selectionRequired default false;
    property selectOnFocus: boolean read FselectOnFocus write Set_selectOnFocus;
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
  end;

implementation


procedure TjdxCustomMenuBase.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  Fanimation := TJSObject.new;
  FcssClass := '';
  FdataSource := nil;
  Fdisabled := false;
  FdisabledExpr := nil;
  FdisplayExpr := nil;
  FelementAttr := TJSObject.new;
  FexpandedExpr := nil;
  FfocusedElement := nil;
  FfocusStateEnabled := false;
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
  FrtlEnabled := false;
  FselectByClick := false;
  FselectedExpr := nil;
  FselectedIndex := 0;
  FselectedItem := nil;
  FselectedItemKeys := TJSArray.new;
  FselectedItems := TJSArray.new;
  FselectionByClick := true;
  FselectionMode := cwsmNone;
  FselectionRequired := false;
  FselectOnFocus := false;
  FshowSubmenuMode := TJSObject.new;
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
end;
procedure TjdxCustomMenuBase.InitJQuery;
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
      $(id).dxMenuBase(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomMenuBase.getInstance(element: TJSObject): TdxMenuBase;
asm
  return DevExpress.viz.dxMenuBase.getInstance(element);
end;

function TjdxCustomMenuBase.instance: TdxMenuBase;
asm
  return $(this.GetJQID()).dxMenuBase("instance");
end;
procedure TjdxCustomMenuBase.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('animation', animation);
    SetOption('cssClass', cssClass);
    SetOption('dataSource', dataSource);
    SetOption('disabled', disabled);
    SetOption('disabledExpr', disabledExpr);
    SetOption('displayExpr', displayExpr);
    SetOption('elementAttr', elementAttr);
    SetOption('expandedExpr', expandedExpr);
    SetOption('focusedElement', focusedElement);
    SetOption('focusStateEnabled', focusStateEnabled);
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
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('selectByClick', selectByClick);
    SetOption('selectedExpr', selectedExpr);
    SetOption('selectedIndex', selectedIndex);
    SetOption('selectedItem', selectedItem);
    SetOption('selectedItemKeys', selectedItemKeys);
    SetOption('selectedItems', selectedItems);
    SetOption('selectionByClick', selectionByClick);
    SetOption('selectionMode', selectionMode.ToString());
    SetOption('selectionRequired', selectionRequired);
    SetOption('selectOnFocus', selectOnFocus);
    SetOption('showSubmenuMode', showSubmenuMode);
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
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomMenuBase.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomMenuBase.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomMenuBase.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
  SetOption('animation', animation);
end;

procedure TjdxCustomMenuBase.Set_cssClass(const Value: string);
begin
  FcssClass := Value;
  SetOption('cssClass', cssClass);
end;

procedure TjdxCustomMenuBase.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomMenuBase.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomMenuBase.Set_disabledExpr(const Value: JSValue);
begin
  FdisabledExpr := Value;
  SetOption('disabledExpr', disabledExpr);
end;

procedure TjdxCustomMenuBase.Set_displayExpr(const Value: JSValue);
begin
  FdisplayExpr := Value;
  SetOption('displayExpr', displayExpr);
end;

procedure TjdxCustomMenuBase.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomMenuBase.Set_expandedExpr(const Value: JSValue);
begin
  FexpandedExpr := Value;
  SetOption('expandedExpr', expandedExpr);
end;

procedure TjdxCustomMenuBase.Set_focusedElement(const Value: TJSElement);
begin
  FfocusedElement := Value;
  SetOption('focusedElement', focusedElement);
end;

procedure TjdxCustomMenuBase.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomMenuBase.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomMenuBase.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomMenuBase.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomMenuBase.Set_itemHoldTimeout(const Value: integer);
begin
  FitemHoldTimeout := Value;
  SetOption('itemHoldTimeout', itemHoldTimeout);
end;

procedure TjdxCustomMenuBase.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
  SetOption('items', items);
end;

procedure TjdxCustomMenuBase.Set_itemsExpr(const Value: JSValue);
begin
  FitemsExpr := Value;
  SetOption('itemsExpr', itemsExpr);
end;

procedure TjdxCustomMenuBase.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
  SetOption('itemTemplate', itemTemplate);
end;

procedure TjdxCustomMenuBase.Set_keyExpr(const Value: JSValue);
begin
  FkeyExpr := Value;
  SetOption('keyExpr', keyExpr);
end;

procedure TjdxCustomMenuBase.Set_loopItemFocus(const Value: boolean);
begin
  FloopItemFocus := Value;
  SetOption('loopItemFocus', loopItemFocus);
end;

procedure TjdxCustomMenuBase.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
  SetOption('noDataText', noDataText);
end;

procedure TjdxCustomMenuBase.Set_parentIdExpr(const Value: JSValue);
begin
  FparentIdExpr := Value;
  SetOption('parentIdExpr', parentIdExpr);
end;

procedure TjdxCustomMenuBase.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomMenuBase.Set_selectByClick(const Value: boolean);
begin
  FselectByClick := Value;
  SetOption('selectByClick', selectByClick);
end;

procedure TjdxCustomMenuBase.Set_selectedExpr(const Value: JSValue);
begin
  FselectedExpr := Value;
  SetOption('selectedExpr', selectedExpr);
end;

procedure TjdxCustomMenuBase.Set_selectedIndex(const Value: integer);
begin
  FselectedIndex := Value;
  SetOption('selectedIndex', selectedIndex);
end;

procedure TjdxCustomMenuBase.Set_selectedItem(const Value: JSValue);
begin
  FselectedItem := Value;
  SetOption('selectedItem', selectedItem);
end;

procedure TjdxCustomMenuBase.Set_selectedItemKeys(const Value: TJSArray);
begin
  FselectedItemKeys := Value;
  SetOption('selectedItemKeys', selectedItemKeys);
end;

procedure TjdxCustomMenuBase.Set_selectedItems(const Value: TJSArray);
begin
  FselectedItems := Value;
  SetOption('selectedItems', selectedItems);
end;

procedure TjdxCustomMenuBase.Set_selectionByClick(const Value: boolean);
begin
  FselectionByClick := Value;
  SetOption('selectionByClick', selectionByClick);
end;

procedure TjdxCustomMenuBase.Set_selectionMode(const Value: TCollectionWidgetSelectionMode);
begin
  FselectionMode := Value;
  SetOption('selectionMode', selectionMode.ToString());
end;

procedure TjdxCustomMenuBase.Set_selectionRequired(const Value: boolean);
begin
  FselectionRequired := Value;
  SetOption('selectionRequired', selectionRequired);
end;

procedure TjdxCustomMenuBase.Set_selectOnFocus(const Value: boolean);
begin
  FselectOnFocus := Value;
  SetOption('selectOnFocus', selectOnFocus);
end;

procedure TjdxCustomMenuBase.Set_showSubmenuMode(const Value: TJSObject);
begin
  FshowSubmenuMode := Value;
  SetOption('showSubmenuMode', showSubmenuMode);
end;

procedure TjdxCustomMenuBase.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomMenuBase.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomMenuBase.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomMenuBase.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomMenuBase.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomMenuBase.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomMenuBase.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomMenuBase.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomMenuBase.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
  SetEvent('itemClick', onItemClick);
end;

procedure TjdxCustomMenuBase.Set_onItemContextMenu(const Value: TdxEventHandler);
begin
  FonItemContextMenu := Value;
  SetEvent('itemContextMenu', onItemContextMenu);
end;

procedure TjdxCustomMenuBase.Set_onItemDeleted(const Value: TdxEventHandler);
begin
  FonItemDeleted := Value;
  SetEvent('itemDeleted', onItemDeleted);
end;

procedure TjdxCustomMenuBase.Set_onItemDeleting(const Value: TdxEventHandler);
begin
  FonItemDeleting := Value;
  SetEvent('itemDeleting', onItemDeleting);
end;

procedure TjdxCustomMenuBase.Set_onItemHold(const Value: TdxEventHandler);
begin
  FonItemHold := Value;
  SetEvent('itemHold', onItemHold);
end;

procedure TjdxCustomMenuBase.Set_onItemRendered(const Value: TdxEventHandler);
begin
  FonItemRendered := Value;
  SetEvent('itemRendered', onItemRendered);
end;

procedure TjdxCustomMenuBase.Set_onItemReordered(const Value: TdxEventHandler);
begin
  FonItemReordered := Value;
  SetEvent('itemReordered', onItemReordered);
end;

procedure TjdxCustomMenuBase.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomMenuBase.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomMenuBase.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomMenuBase.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomMenuBase.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomMenuBase.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  _instance.defaultOptions(rule);
end;

function TjdxCustomMenuBase.deleteItem(itemElement: TJSElement): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  return _instance.deleteItem(itemElement);
end;

procedure TjdxCustomMenuBase.dispose();
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  _instance.dispose();
end;

function TjdxCustomMenuBase.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  return _instance.element();
end;

procedure TjdxCustomMenuBase.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomMenuBase.focus();
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  _instance.focus();
end;

function TjdxCustomMenuBase.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  return _instance.getDataSource();
end;

function TjdxCustomMenuBase.getFocusedItemId(): string;
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  return _instance.getFocusedItemId();
end;

function TjdxCustomMenuBase.isItemSelected(itemElement: TJSElement): boolean;
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  return _instance.isItemSelected(itemElement);
end;

function TjdxCustomMenuBase.itemElements(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  return _instance.itemElements();
end;

function TjdxCustomMenuBase.itemsContainer(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  return _instance.itemsContainer();
end;

function TjdxCustomMenuBase.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomMenuBase.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  return _instance.off(eventName);
end;

function TjdxCustomMenuBase.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  return _instance.on(events);
end;

function TjdxCustomMenuBase.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  return _instance.on(eventName, eventHandler);
end;

procedure TjdxCustomMenuBase.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  _instance.option(options);
end;

procedure TjdxCustomMenuBase.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomMenuBase.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  return _instance.option();
end;

function TjdxCustomMenuBase.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomMenuBase.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  _instance.registerKeyHandler(key, handler);
end;

function TjdxCustomMenuBase.reorderItem(itemElement: TJSElement; toItemElement: TJSElement): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  return _instance.reorderItem(itemElement, toItemElement);
end;

procedure TjdxCustomMenuBase.repaint();
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  _instance.repaint();
end;

procedure TjdxCustomMenuBase.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomMenuBase.selectItem(itemElement: TJSElement);
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  _instance.selectItem(itemElement);
end;

procedure TjdxCustomMenuBase.unselectItem(itemElement: TJSElement);
asm
  const _instance = $(this.GetJQID()).dxMenuBase("instance");
  _instance.unselectItem(itemElement);
end;

end.
