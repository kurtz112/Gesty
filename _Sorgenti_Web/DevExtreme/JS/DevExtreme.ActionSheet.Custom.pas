unit DevExtreme.ActionSheet.Custom;

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
  DevExtreme.ActionSheet.JS,
  DevExtreme.Types;

type
  TjdxCustomActionSheet = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FcancelText: string;
    FdataSource: JSValue;
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
    FkeyExpr: JSValue;
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
    FshowCancelButton: boolean;
    FshowTitle: boolean;
    FtabIndex: integer;
    Ftarget: JSValue;
    Ftitle: string;
    FusePopover: boolean;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonCancelClick: TdxEventHandler;
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
    procedure Set_cancelText(const value: string);
    procedure Set_dataSource(const value: JSValue);
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
    procedure Set_keyExpr(const value: JSValue);
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
    procedure Set_showCancelButton(const value: boolean);
    procedure Set_showTitle(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_target(const value: JSValue);
    procedure Set_title(const value: string);
    procedure Set_usePopover(const value: boolean);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onCancelClick(const value: TdxEventHandler);
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
    function getInstance(element: TJSObject): TdxActionSheet; assembler;
    function instance: TdxActionSheet; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    function deleteItem(itemElement: TJSElement): TJSPromise; assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler; overload;
    function getDataSource(): TJSObject; assembler;
    function getFocusedItemId(): string; assembler;
    function hide(): TJSPromise; assembler;
    function isItemSelected(itemElement: TJSElement): boolean; assembler;
    function itemElements(): TJSArray; assembler;
    function itemsContainer(): TJSElement; assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure registerKeyHandler(); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler; overload;
    function reorderItem(itemElement: TJSElement; toItemElement: TJSElement): TJSPromise; assembler;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure selectItem(itemElement: TJSElement); assembler;
    function show(): TJSPromise; assembler;
    function toggle(showing: boolean): TJSPromise; assembler;
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
    property target: JSValue read Ftarget write Set_target;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property cancelText: string read FcancelText write Set_cancelText;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property itemHoldTimeout: integer read FitemHoldTimeout write Set_itemHoldTimeout;
    property loopItemFocus: boolean read FloopItemFocus write Set_loopItemFocus;
    property noDataText: string read FnoDataText write Set_noDataText;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property selectedIndex: integer read FselectedIndex write Set_selectedIndex;
    property selectionByClick: boolean read FselectionByClick write Set_selectionByClick default true;
    property selectionMode: TCollectionWidgetSelectionMode read FselectionMode write Set_selectionMode default cwsmNone;
    property selectionRequired: boolean read FselectionRequired write Set_selectionRequired default false;
    property selectOnFocus: boolean read FselectOnFocus write Set_selectOnFocus;
    property showCancelButton: boolean read FshowCancelButton write Set_showCancelButton default true;
    property showTitle: boolean read FshowTitle write Set_showTitle default true;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property title: string read Ftitle write Set_title;
    property usePopover: boolean read FusePopover write Set_usePopover;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onCancelClick: TdxEventHandler read FonCancelClick write Set_onCancelClick;
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


procedure TjdxCustomActionSheet.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FcancelText := '';
  FdataSource := nil;
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
  FkeyExpr := nil;
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
  FshowCancelButton := true;
  FshowTitle := true;
  FtabIndex := 0;
  Ftarget := nil;
  Ftitle := '';
  FusePopover := false;
  Fvisible := true;
  Fwidth_ := nil;

  FonCancelClick := nil;
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
procedure TjdxCustomActionSheet.InitJQuery;
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
      $(id).dxActionSheet(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomActionSheet.getInstance(element: TJSObject): TdxActionSheet;
asm
  return DevExpress.viz.dxActionSheet.getInstance(element);
end;

function TjdxCustomActionSheet.instance: TdxActionSheet;
asm
  return $(this.GetJQID()).dxActionSheet("instance");
end;
procedure TjdxCustomActionSheet.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('cancelText', cancelText);
    SetOption('dataSource', dataSource);
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
    SetOption('keyExpr', keyExpr);
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
    SetOption('showCancelButton', showCancelButton);
    SetOption('showTitle', showTitle);
    SetOption('tabIndex', tabIndex);
    SetOption('target', target);
    SetOption('title', title);
    SetOption('usePopover', usePopover);
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('cancelClick', onCancelClick);
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

procedure TjdxCustomActionSheet.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomActionSheet.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomActionSheet.Set_cancelText(const Value: string);
begin
  FcancelText := Value;
  SetOption('cancelText', cancelText);
end;

procedure TjdxCustomActionSheet.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomActionSheet.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomActionSheet.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomActionSheet.Set_focusedElement(const Value: TJSElement);
begin
  FfocusedElement := Value;
  SetOption('focusedElement', focusedElement);
end;

procedure TjdxCustomActionSheet.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomActionSheet.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomActionSheet.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomActionSheet.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomActionSheet.Set_itemHoldTimeout(const Value: integer);
begin
  FitemHoldTimeout := Value;
  SetOption('itemHoldTimeout', itemHoldTimeout);
end;

procedure TjdxCustomActionSheet.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
  SetOption('items', items);
end;

procedure TjdxCustomActionSheet.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
  SetOption('itemTemplate', itemTemplate);
end;

procedure TjdxCustomActionSheet.Set_keyExpr(const Value: JSValue);
begin
  FkeyExpr := Value;
  SetOption('keyExpr', keyExpr);
end;

procedure TjdxCustomActionSheet.Set_loopItemFocus(const Value: boolean);
begin
  FloopItemFocus := Value;
  SetOption('loopItemFocus', loopItemFocus);
end;

procedure TjdxCustomActionSheet.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
  SetOption('noDataText', noDataText);
end;

procedure TjdxCustomActionSheet.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomActionSheet.Set_selectedIndex(const Value: integer);
begin
  FselectedIndex := Value;
  SetOption('selectedIndex', selectedIndex);
end;

procedure TjdxCustomActionSheet.Set_selectedItem(const Value: JSValue);
begin
  FselectedItem := Value;
  SetOption('selectedItem', selectedItem);
end;

procedure TjdxCustomActionSheet.Set_selectedItemKeys(const Value: TJSArray);
begin
  FselectedItemKeys := Value;
  SetOption('selectedItemKeys', selectedItemKeys);
end;

procedure TjdxCustomActionSheet.Set_selectedItems(const Value: TJSArray);
begin
  FselectedItems := Value;
  SetOption('selectedItems', selectedItems);
end;

procedure TjdxCustomActionSheet.Set_selectionByClick(const Value: boolean);
begin
  FselectionByClick := Value;
  SetOption('selectionByClick', selectionByClick);
end;

procedure TjdxCustomActionSheet.Set_selectionMode(const Value: TCollectionWidgetSelectionMode);
begin
  FselectionMode := Value;
  SetOption('selectionMode', selectionMode.ToString());
end;

procedure TjdxCustomActionSheet.Set_selectionRequired(const Value: boolean);
begin
  FselectionRequired := Value;
  SetOption('selectionRequired', selectionRequired);
end;

procedure TjdxCustomActionSheet.Set_selectOnFocus(const Value: boolean);
begin
  FselectOnFocus := Value;
  SetOption('selectOnFocus', selectOnFocus);
end;

procedure TjdxCustomActionSheet.Set_showCancelButton(const Value: boolean);
begin
  FshowCancelButton := Value;
  SetOption('showCancelButton', showCancelButton);
end;

procedure TjdxCustomActionSheet.Set_showTitle(const Value: boolean);
begin
  FshowTitle := Value;
  SetOption('showTitle', showTitle);
end;

procedure TjdxCustomActionSheet.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomActionSheet.Set_target(const Value: JSValue);
begin
  Ftarget := Value;
  SetOption('target', target);
end;

procedure TjdxCustomActionSheet.Set_title(const Value: string);
begin
  Ftitle := Value;
  SetOption('title', title);
end;

procedure TjdxCustomActionSheet.Set_usePopover(const Value: boolean);
begin
  FusePopover := Value;
  SetOption('usePopover', usePopover);
end;

procedure TjdxCustomActionSheet.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomActionSheet.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomActionSheet.Set_onCancelClick(const Value: TdxEventHandler);
begin
  FonCancelClick := Value;
  SetEvent('cancelClick', onCancelClick);
end;

procedure TjdxCustomActionSheet.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomActionSheet.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomActionSheet.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomActionSheet.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomActionSheet.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomActionSheet.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
  SetEvent('itemClick', onItemClick);
end;

procedure TjdxCustomActionSheet.Set_onItemContextMenu(const Value: TdxEventHandler);
begin
  FonItemContextMenu := Value;
  SetEvent('itemContextMenu', onItemContextMenu);
end;

procedure TjdxCustomActionSheet.Set_onItemDeleted(const Value: TdxEventHandler);
begin
  FonItemDeleted := Value;
  SetEvent('itemDeleted', onItemDeleted);
end;

procedure TjdxCustomActionSheet.Set_onItemDeleting(const Value: TdxEventHandler);
begin
  FonItemDeleting := Value;
  SetEvent('itemDeleting', onItemDeleting);
end;

procedure TjdxCustomActionSheet.Set_onItemHold(const Value: TdxEventHandler);
begin
  FonItemHold := Value;
  SetEvent('itemHold', onItemHold);
end;

procedure TjdxCustomActionSheet.Set_onItemRendered(const Value: TdxEventHandler);
begin
  FonItemRendered := Value;
  SetEvent('itemRendered', onItemRendered);
end;

procedure TjdxCustomActionSheet.Set_onItemReordered(const Value: TdxEventHandler);
begin
  FonItemReordered := Value;
  SetEvent('itemReordered', onItemReordered);
end;

procedure TjdxCustomActionSheet.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomActionSheet.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomActionSheet.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomActionSheet.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomActionSheet.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomActionSheet.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  _instance.defaultOptions(rule);
end;

function TjdxCustomActionSheet.deleteItem(itemElement: TJSElement): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.deleteItem(itemElement);
end;

procedure TjdxCustomActionSheet.dispose();
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  _instance.dispose();
end;

function TjdxCustomActionSheet.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.element();
end;

procedure TjdxCustomActionSheet.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomActionSheet.focus();
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  _instance.focus();
end;

function TjdxCustomActionSheet.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.getDataSource();
end;

function TjdxCustomActionSheet.getFocusedItemId(): string;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.getFocusedItemId();
end;

function TjdxCustomActionSheet.hide(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.hide();
end;

function TjdxCustomActionSheet.isItemSelected(itemElement: TJSElement): boolean;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.isItemSelected(itemElement);
end;

function TjdxCustomActionSheet.itemElements(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.itemElements();
end;

function TjdxCustomActionSheet.itemsContainer(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.itemsContainer();
end;

function TjdxCustomActionSheet.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomActionSheet.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.off(eventName);
end;

function TjdxCustomActionSheet.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomActionSheet.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.on(events);
end;

procedure TjdxCustomActionSheet.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  _instance.option(options);
end;

procedure TjdxCustomActionSheet.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomActionSheet.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.option(optionName);
end;

function TjdxCustomActionSheet.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.option();
end;

procedure TjdxCustomActionSheet.registerKeyHandler();
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  _instance.registerKeyHandler();
end;

procedure TjdxCustomActionSheet.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  _instance.registerKeyHandler(key, handler);
end;

function TjdxCustomActionSheet.reorderItem(itemElement: TJSElement; toItemElement: TJSElement): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.reorderItem(itemElement, toItemElement);
end;

procedure TjdxCustomActionSheet.repaint();
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  _instance.repaint();
end;

procedure TjdxCustomActionSheet.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomActionSheet.selectItem(itemElement: TJSElement);
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  _instance.selectItem(itemElement);
end;

function TjdxCustomActionSheet.show(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.show();
end;

function TjdxCustomActionSheet.toggle(showing: boolean): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  return _instance.toggle(showing);
end;

procedure TjdxCustomActionSheet.unselectItem(itemElement: TJSElement);
asm
  const _instance = $(this.GetJQID()).dxActionSheet("instance");
  _instance.unselectItem(itemElement);
end;

end.
