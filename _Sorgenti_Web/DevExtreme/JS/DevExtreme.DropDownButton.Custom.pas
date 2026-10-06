unit DevExtreme.DropDownButton.Custom;

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
  DevExtreme.DropDownButton.JS,
  DevExtreme.Types;

type
  TjdxCustomDropDownButton = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FdataSource: JSValue;
    FdeferRendering: boolean;
    Fdisabled: boolean;
    FdisplayExpr: JSValue;
    FdropDownContentTemplate: JSValue;
    FdropDownOptions: JSValue;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    Ficon: string;
    Fitems: TJSArray;
    FitemTemplate: JSValue;
    FkeyExpr: string;
    FnoDataText: string;
    Fopened: boolean;
    FrtlEnabled: boolean;
    FselectedItem: JSValue;
    FselectedItemKey: JSValue;
    FshowArrowIcon: boolean;
    FsplitButton: boolean;
    FstylingMode: TdxButtonStyle;
    FtabIndex: integer;
    Ftext: string;
    FuseItemTextAsTitle: boolean;
    FuseSelectMode: boolean;
    Fvisible: boolean;
    Fwidth_: JSValue;
    FwrapItemText: boolean;
  private
    FonButtonClick: TdxEventHandler;
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonItemClick: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_deferRendering(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_displayExpr(const value: JSValue);
    procedure Set_dropDownContentTemplate(const value: JSValue);
    procedure Set_dropDownOptions(const value: JSValue);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_icon(const value: string);
    procedure Set_items(const value: TJSArray);
    procedure Set_itemTemplate(const value: JSValue);
    procedure Set_keyExpr(const value: string);
    procedure Set_noDataText(const value: string);
    procedure Set_opened(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_selectedItemKey(const value: JSValue);
    procedure Set_showArrowIcon(const value: boolean);
    procedure Set_splitButton(const value: boolean);
    procedure Set_stylingMode(const value: TdxButtonStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_text(const value: string);
    procedure Set_useItemTextAsTitle(const value: boolean);
    procedure Set_useSelectMode(const value: boolean);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
    procedure Set_wrapItemText(const value: boolean);
  private
    procedure Set_onButtonClick(const value: TdxEventHandler);
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onItemClick(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxDropDownButton; assembler;
    function instance: TdxDropDownButton; assembler;
  public
    procedure beginUpdate(); assembler;
    function close(): TJSPromise; assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler;
    function getDataSource(): TJSObject; assembler;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function open(): TJSPromise; assembler;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
    function toggle(visibility: boolean): TJSPromise; assembler; overload;
    function toggle(): TJSPromise; assembler; overload;
  public
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property displayExpr: JSValue read FdisplayExpr write Set_displayExpr;
    property dropDownContentTemplate: JSValue read FdropDownContentTemplate write Set_dropDownContentTemplate;
    property dropDownOptions: JSValue read FdropDownOptions write Set_dropDownOptions;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property items: TJSArray read Fitems write Set_items;
    property itemTemplate: JSValue read FitemTemplate write Set_itemTemplate;
    property selectedItem: JSValue read FselectedItem;
    property selectedItemKey: JSValue read FselectedItemKey write Set_selectedItemKey;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property deferRendering: boolean read FdeferRendering write Set_deferRendering default true;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property icon: string read Ficon write Set_icon;
    property keyExpr: string read FkeyExpr write Set_keyExpr;
    property noDataText: string read FnoDataText write Set_noDataText;
    property opened: boolean read Fopened write Set_opened default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showArrowIcon: boolean read FshowArrowIcon write Set_showArrowIcon default true;
    property splitButton: boolean read FsplitButton write Set_splitButton default false;
    property stylingMode: TdxButtonStyle read FstylingMode write Set_stylingMode default bsOutlined;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property text: string read Ftext write Set_text;
    property useItemTextAsTitle: boolean read FuseItemTextAsTitle write Set_useItemTextAsTitle default true;
    property useSelectMode: boolean read FuseSelectMode write Set_useSelectMode default false;
    property visible: boolean read Fvisible write Set_visible default true;
    property wrapItemText: boolean read FwrapItemText write Set_wrapItemText default false;
  published
    property onButtonClick: TdxEventHandler read FonButtonClick write Set_onButtonClick;
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onItemClick: TdxEventHandler read FonItemClick write Set_onItemClick;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
  end;

implementation


procedure TjdxCustomDropDownButton.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FdataSource := nil;
  FdeferRendering := true;
  Fdisabled := false;
  FdisplayExpr := nil;
  FdropDownContentTemplate := nil;
  FdropDownOptions := nil;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  Ficon := '';
  Fitems := TJSArray.new;
  FitemTemplate := nil;
  FkeyExpr := '';
  FnoDataText := '';
  Fopened := false;
  FrtlEnabled := false;
  FselectedItem := nil;
  FselectedItemKey := nil;
  FshowArrowIcon := true;
  FsplitButton := false;
  FstylingMode := bsOutlined;
  FtabIndex := 0;
  Ftext := '';
  FuseItemTextAsTitle := true;
  FuseSelectMode := false;
  Fvisible := true;
  Fwidth_ := nil;
  FwrapItemText := false;

  FonButtonClick := nil;
  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonItemClick := nil;
  FonOptionChanged := nil;
  FonSelectionChanged := nil;
end;
procedure TjdxCustomDropDownButton.InitJQuery;
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
      $(id).dxDropDownButton(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomDropDownButton.getInstance(element: TJSObject): TdxDropDownButton;
asm
  return DevExpress.viz.dxDropDownButton.getInstance(element);
end;

function TjdxCustomDropDownButton.instance: TdxDropDownButton;
asm
  return $(this.GetJQID()).dxDropDownButton("instance");
end;
procedure TjdxCustomDropDownButton.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('dataSource', dataSource);
    SetOption('deferRendering', deferRendering);
    SetOption('disabled', disabled);
    SetOption('displayExpr', displayExpr);
    SetOption('dropDownContentTemplate', dropDownContentTemplate);
    SetOption('dropDownOptions', dropDownOptions);
    SetOption('elementAttr', elementAttr);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('icon', icon);
    SetOption('items', items);
    SetOption('itemTemplate', itemTemplate);
    SetOption('keyExpr', keyExpr);
    SetOption('noDataText', noDataText);
    SetOption('opened', opened);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('selectedItem', selectedItem);
    SetOption('selectedItemKey', selectedItemKey);
    SetOption('showArrowIcon', showArrowIcon);
    SetOption('splitButton', splitButton);
    SetOption('stylingMode', stylingMode.ToString());
    SetOption('tabIndex', tabIndex);
    SetOption('text', text);
    SetOption('useItemTextAsTitle', useItemTextAsTitle);
    SetOption('useSelectMode', useSelectMode);
    SetOption('visible', visible);
    SetOption('width', width_);
    SetOption('wrapItemText', wrapItemText);

    SetEvent('buttonClick', onButtonClick);
    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('itemClick', onItemClick);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('selectionChanged', onSelectionChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomDropDownButton.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomDropDownButton.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomDropDownButton.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomDropDownButton.Set_deferRendering(const Value: boolean);
begin
  FdeferRendering := Value;
  SetOption('deferRendering', deferRendering);
end;

procedure TjdxCustomDropDownButton.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomDropDownButton.Set_displayExpr(const Value: JSValue);
begin
  FdisplayExpr := Value;
  SetOption('displayExpr', displayExpr);
end;

procedure TjdxCustomDropDownButton.Set_dropDownContentTemplate(const Value: JSValue);
begin
  FdropDownContentTemplate := Value;
  SetOption('dropDownContentTemplate', dropDownContentTemplate);
end;

procedure TjdxCustomDropDownButton.Set_dropDownOptions(const Value: JSValue);
begin
  FdropDownOptions := Value;
  SetOption('dropDownOptions', dropDownOptions);
end;

procedure TjdxCustomDropDownButton.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomDropDownButton.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomDropDownButton.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomDropDownButton.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomDropDownButton.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomDropDownButton.Set_icon(const Value: string);
begin
  Ficon := Value;
  SetOption('icon', icon);
end;

procedure TjdxCustomDropDownButton.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
  SetOption('items', items);
end;

procedure TjdxCustomDropDownButton.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
  SetOption('itemTemplate', itemTemplate);
end;

procedure TjdxCustomDropDownButton.Set_keyExpr(const Value: string);
begin
  FkeyExpr := Value;
  SetOption('keyExpr', keyExpr);
end;

procedure TjdxCustomDropDownButton.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
  SetOption('noDataText', noDataText);
end;

procedure TjdxCustomDropDownButton.Set_opened(const Value: boolean);
begin
  Fopened := Value;
  SetOption('opened', opened);
end;

procedure TjdxCustomDropDownButton.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomDropDownButton.Set_selectedItemKey(const Value: JSValue);
begin
  FselectedItemKey := Value;
  SetOption('selectedItemKey', selectedItemKey);
end;

procedure TjdxCustomDropDownButton.Set_showArrowIcon(const Value: boolean);
begin
  FshowArrowIcon := Value;
  SetOption('showArrowIcon', showArrowIcon);
end;

procedure TjdxCustomDropDownButton.Set_splitButton(const Value: boolean);
begin
  FsplitButton := Value;
  SetOption('splitButton', splitButton);
end;

procedure TjdxCustomDropDownButton.Set_stylingMode(const Value: TdxButtonStyle);
begin
  FstylingMode := Value;
  SetOption('stylingMode', stylingMode.ToString());
end;

procedure TjdxCustomDropDownButton.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomDropDownButton.Set_text(const Value: string);
begin
  Ftext := Value;
  SetOption('text', text);
end;

procedure TjdxCustomDropDownButton.Set_useItemTextAsTitle(const Value: boolean);
begin
  FuseItemTextAsTitle := Value;
  SetOption('useItemTextAsTitle', useItemTextAsTitle);
end;

procedure TjdxCustomDropDownButton.Set_useSelectMode(const Value: boolean);
begin
  FuseSelectMode := Value;
  SetOption('useSelectMode', useSelectMode);
end;

procedure TjdxCustomDropDownButton.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomDropDownButton.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomDropDownButton.Set_wrapItemText(const Value: boolean);
begin
  FwrapItemText := Value;
  SetOption('wrapItemText', wrapItemText);
end;

procedure TjdxCustomDropDownButton.Set_onButtonClick(const Value: TdxEventHandler);
begin
  FonButtonClick := Value;
  SetEvent('buttonClick', onButtonClick);
end;

procedure TjdxCustomDropDownButton.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomDropDownButton.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomDropDownButton.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomDropDownButton.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomDropDownButton.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomDropDownButton.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
  SetEvent('itemClick', onItemClick);
end;

procedure TjdxCustomDropDownButton.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomDropDownButton.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomDropDownButton.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  _instance.beginUpdate();
end;

function TjdxCustomDropDownButton.close(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  return _instance.close();
end;

procedure TjdxCustomDropDownButton.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomDropDownButton.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomDropDownButton.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomDropDownButton.dispose();
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  _instance.dispose();
end;

function TjdxCustomDropDownButton.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  return _instance.element();
end;

procedure TjdxCustomDropDownButton.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomDropDownButton.focus();
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  _instance.focus();
end;

function TjdxCustomDropDownButton.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  return _instance.getDataSource();
end;

function TjdxCustomDropDownButton.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  return _instance.off(eventName);
end;

function TjdxCustomDropDownButton.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomDropDownButton.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomDropDownButton.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  return _instance.on(events);
end;

function TjdxCustomDropDownButton.open(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  return _instance.open();
end;

procedure TjdxCustomDropDownButton.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomDropDownButton.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  return _instance.option(optionName);
end;

function TjdxCustomDropDownButton.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  return _instance.option();
end;

procedure TjdxCustomDropDownButton.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  _instance.option(options);
end;

procedure TjdxCustomDropDownButton.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomDropDownButton.repaint();
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  _instance.repaint();
end;

procedure TjdxCustomDropDownButton.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  _instance.resetOption(optionName);
end;

function TjdxCustomDropDownButton.toggle(visibility: boolean): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  return _instance.toggle(visibility);
end;

function TjdxCustomDropDownButton.toggle(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDropDownButton("instance");
  return _instance.toggle();
end;

end.
