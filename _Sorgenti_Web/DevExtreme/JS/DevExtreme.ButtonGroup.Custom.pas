unit DevExtreme.ButtonGroup.Custom;

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
  DevExtreme.ButtonGroup.JS,
  DevExtreme.Types;

type
  TjdxCustomButtonGroup = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FbuttonTemplate: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    Fitems: TJSArray;
    FkeyExpr: JSValue;
    FrtlEnabled: boolean;
    FselectedItemKeys: TJSArray;
    FselectedItems: TJSArray;
    FselectionMode: TdxSingleMultipleOrNone;
    FstylingMode: TdxButtonStyle;
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
    FonOptionChanged: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_buttonTemplate(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_items(const value: TJSArray);
    procedure Set_keyExpr(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_selectedItemKeys(const value: TJSArray);
    procedure Set_selectedItems(const value: TJSArray);
    procedure Set_selectionMode(const value: TdxSingleMultipleOrNone);
    procedure Set_stylingMode(const value: TdxButtonStyle);
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
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxButtonGroup; assembler;
    function instance: TdxButtonGroup; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
  public
    property buttonTemplate: JSValue read FbuttonTemplate write Set_buttonTemplate;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property items: TJSArray read Fitems write Set_items;
    property keyExpr: JSValue read FkeyExpr write Set_keyExpr;
    property selectedItemKeys: TJSArray read FselectedItemKeys write Set_selectedItemKeys;
    property selectedItems: TJSArray read FselectedItems write Set_selectedItems;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property selectionMode: TdxSingleMultipleOrNone read FselectionMode write Set_selectionMode default smonSingle;
    property stylingMode: TdxButtonStyle read FstylingMode write Set_stylingMode default bsContained;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
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


procedure TjdxCustomButtonGroup.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FbuttonTemplate := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  Fitems := TJSArray.new;
  FkeyExpr := nil;
  FrtlEnabled := false;
  FselectedItemKeys := TJSArray.new;
  FselectedItems := TJSArray.new;
  FselectionMode := smonSingle;
  FstylingMode := bsContained;
  FtabIndex := 0;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonItemClick := nil;
  FonOptionChanged := nil;
  FonSelectionChanged := nil;
end;
procedure TjdxCustomButtonGroup.InitJQuery;
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
      $(id).dxButtonGroup(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomButtonGroup.getInstance(element: TJSObject): TdxButtonGroup;
asm
  return DevExpress.viz.dxButtonGroup.getInstance(element);
end;

function TjdxCustomButtonGroup.instance: TdxButtonGroup;
asm
  return $(this.GetJQID()).dxButtonGroup("instance");
end;
procedure TjdxCustomButtonGroup.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('buttonTemplate', buttonTemplate);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('items', items);
    SetOption('keyExpr', keyExpr);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('selectedItemKeys', selectedItemKeys);
    SetOption('selectedItems', selectedItems);
    SetOption('selectionMode', selectionMode.ToString());
    SetOption('stylingMode', stylingMode.ToString());
    SetOption('tabIndex', tabIndex);
    SetOption('visible', visible);
    SetOption('width', width_);

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

procedure TjdxCustomButtonGroup.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomButtonGroup.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomButtonGroup.Set_buttonTemplate(const Value: JSValue);
begin
  FbuttonTemplate := Value;
  SetOption('buttonTemplate', buttonTemplate);
end;

procedure TjdxCustomButtonGroup.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomButtonGroup.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomButtonGroup.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomButtonGroup.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomButtonGroup.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomButtonGroup.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomButtonGroup.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
  SetOption('items', items);
end;

procedure TjdxCustomButtonGroup.Set_keyExpr(const Value: JSValue);
begin
  FkeyExpr := Value;
  SetOption('keyExpr', keyExpr);
end;

procedure TjdxCustomButtonGroup.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomButtonGroup.Set_selectedItemKeys(const Value: TJSArray);
begin
  FselectedItemKeys := Value;
  SetOption('selectedItemKeys', selectedItemKeys);
end;

procedure TjdxCustomButtonGroup.Set_selectedItems(const Value: TJSArray);
begin
  FselectedItems := Value;
  SetOption('selectedItems', selectedItems);
end;

procedure TjdxCustomButtonGroup.Set_selectionMode(const Value: TdxSingleMultipleOrNone);
begin
  FselectionMode := Value;
  SetOption('selectionMode', selectionMode.ToString());
end;

procedure TjdxCustomButtonGroup.Set_stylingMode(const Value: TdxButtonStyle);
begin
  FstylingMode := Value;
  SetOption('stylingMode', stylingMode.ToString());
end;

procedure TjdxCustomButtonGroup.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomButtonGroup.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomButtonGroup.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomButtonGroup.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomButtonGroup.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomButtonGroup.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomButtonGroup.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomButtonGroup.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomButtonGroup.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
  SetEvent('itemClick', onItemClick);
end;

procedure TjdxCustomButtonGroup.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomButtonGroup.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomButtonGroup.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomButtonGroup.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomButtonGroup.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomButtonGroup.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomButtonGroup.dispose();
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  _instance.dispose();
end;

function TjdxCustomButtonGroup.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  return _instance.element();
end;

procedure TjdxCustomButtonGroup.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomButtonGroup.focus();
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  _instance.focus();
end;

function TjdxCustomButtonGroup.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  return _instance.off(eventName);
end;

function TjdxCustomButtonGroup.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomButtonGroup.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomButtonGroup.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  return _instance.on(events);
end;

function TjdxCustomButtonGroup.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  return _instance.option(optionName);
end;

function TjdxCustomButtonGroup.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  return _instance.option();
end;

procedure TjdxCustomButtonGroup.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomButtonGroup.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  _instance.option(options);
end;

procedure TjdxCustomButtonGroup.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomButtonGroup.repaint();
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  _instance.repaint();
end;

procedure TjdxCustomButtonGroup.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxButtonGroup("instance");
  _instance.resetOption(optionName);
end;

end.
