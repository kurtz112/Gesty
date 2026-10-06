unit DevExtreme.SpeedDialAction.Custom;

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
  DevExtreme.SpeedDialAction.JS,
  DevExtreme.Types;

type
  TjdxCustomSpeedDialAction = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    Ficon: string;
    Findex: integer;
    Flabel_: string;
    FrtlEnabled: boolean;
    FtabIndex: integer;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonClick: TdxEventHandler;
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_icon(const value: string);
    procedure Set_index(const value: integer);
    procedure Set_label_(const value: string);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onClick(const value: TdxEventHandler);
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxSpeedDialAction; assembler;
    function instance: TdxSpeedDialAction; assembler;
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
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property icon: string read Ficon write Set_icon;
    property index: integer read Findex write Set_index;
    property label_: string read Flabel_ write Set_label_;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onClick: TdxEventHandler read FonClick write Set_onClick;
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
  end;

implementation


procedure TjdxCustomSpeedDialAction.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  Ficon := '';
  Findex := 0;
  Flabel_ := '';
  FrtlEnabled := false;
  FtabIndex := 0;
  Fvisible := true;
  Fwidth_ := nil;

  FonClick := nil;
  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
end;
procedure TjdxCustomSpeedDialAction.InitJQuery;
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
      $(id).dxSpeedDialAction(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomSpeedDialAction.getInstance(element: TJSObject): TdxSpeedDialAction;
asm
  return DevExpress.viz.dxSpeedDialAction.getInstance(element);
end;

function TjdxCustomSpeedDialAction.instance: TdxSpeedDialAction;
asm
  return $(this.GetJQID()).dxSpeedDialAction("instance");
end;
procedure TjdxCustomSpeedDialAction.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('icon', icon);
    SetOption('index', index);
    SetOption('label', label_);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('tabIndex', tabIndex);
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('click', onClick);
    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomSpeedDialAction.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomSpeedDialAction.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomSpeedDialAction.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomSpeedDialAction.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomSpeedDialAction.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomSpeedDialAction.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomSpeedDialAction.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomSpeedDialAction.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomSpeedDialAction.Set_icon(const Value: string);
begin
  Ficon := Value;
  SetOption('icon', icon);
end;

procedure TjdxCustomSpeedDialAction.Set_index(const Value: integer);
begin
  Findex := Value;
  SetOption('index', index);
end;

procedure TjdxCustomSpeedDialAction.Set_label_(const Value: string);
begin
  Flabel_ := Value;
  SetOption('label', label_);
end;

procedure TjdxCustomSpeedDialAction.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomSpeedDialAction.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomSpeedDialAction.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomSpeedDialAction.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomSpeedDialAction.Set_onClick(const Value: TdxEventHandler);
begin
  FonClick := Value;
  SetEvent('click', onClick);
end;

procedure TjdxCustomSpeedDialAction.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomSpeedDialAction.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomSpeedDialAction.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomSpeedDialAction.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomSpeedDialAction.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomSpeedDialAction.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomSpeedDialAction.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomSpeedDialAction.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomSpeedDialAction.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomSpeedDialAction.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomSpeedDialAction.dispose();
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  _instance.dispose();
end;

function TjdxCustomSpeedDialAction.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  return _instance.element();
end;

procedure TjdxCustomSpeedDialAction.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomSpeedDialAction.focus();
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  _instance.focus();
end;

function TjdxCustomSpeedDialAction.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  return _instance.off(eventName);
end;

function TjdxCustomSpeedDialAction.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomSpeedDialAction.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomSpeedDialAction.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  return _instance.on(events);
end;

function TjdxCustomSpeedDialAction.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  return _instance.option(optionName);
end;

function TjdxCustomSpeedDialAction.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  return _instance.option();
end;

procedure TjdxCustomSpeedDialAction.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomSpeedDialAction.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  _instance.option(options);
end;

procedure TjdxCustomSpeedDialAction.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomSpeedDialAction.repaint();
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  _instance.repaint();
end;

procedure TjdxCustomSpeedDialAction.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxSpeedDialAction("instance");
  _instance.resetOption(optionName);
end;

end.
