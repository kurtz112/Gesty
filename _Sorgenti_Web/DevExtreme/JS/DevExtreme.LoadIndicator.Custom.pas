unit DevExtreme.LoadIndicator.Custom;

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
  DevExtreme.LoadIndicator.JS,
  DevExtreme.Types;

type
  TjdxCustomLoadIndicator = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FindicatorSrc: string;
    FrtlEnabled: boolean;
    FtabIndex: integer;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
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
    procedure Set_indicatorSrc(const value: string);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
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
    function getInstance(element: TJSObject): TdxLoadIndicator; assembler;
    function instance: TdxLoadIndicator; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure registerKeyHandler(); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler; overload;
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
    property indicatorSrc: string read FindicatorSrc write Set_indicatorSrc;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
  end;

implementation


procedure TjdxCustomLoadIndicator.CreateInitialize;
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
  FindicatorSrc := '';
  FrtlEnabled := false;
  FtabIndex := 0;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
end;
procedure TjdxCustomLoadIndicator.InitJQuery;
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
      $(id).dxLoadIndicator(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomLoadIndicator.getInstance(element: TJSObject): TdxLoadIndicator;
asm
  return DevExpress.viz.dxLoadIndicator.getInstance(element);
end;

function TjdxCustomLoadIndicator.instance: TdxLoadIndicator;
asm
  return $(this.GetJQID()).dxLoadIndicator("instance");
end;
procedure TjdxCustomLoadIndicator.UpdateElement;
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
    SetOption('indicatorSrc', indicatorSrc);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('tabIndex', tabIndex);
    SetOption('visible', visible);
    SetOption('width', width_);

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

procedure TjdxCustomLoadIndicator.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomLoadIndicator.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomLoadIndicator.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomLoadIndicator.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomLoadIndicator.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomLoadIndicator.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomLoadIndicator.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomLoadIndicator.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomLoadIndicator.Set_indicatorSrc(const Value: string);
begin
  FindicatorSrc := Value;
  SetOption('indicatorSrc', indicatorSrc);
end;

procedure TjdxCustomLoadIndicator.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomLoadIndicator.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomLoadIndicator.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomLoadIndicator.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomLoadIndicator.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomLoadIndicator.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomLoadIndicator.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomLoadIndicator.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomLoadIndicator.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomLoadIndicator.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomLoadIndicator.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomLoadIndicator.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomLoadIndicator.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomLoadIndicator.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomLoadIndicator.dispose();
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  _instance.dispose();
end;

function TjdxCustomLoadIndicator.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  return _instance.element();
end;

procedure TjdxCustomLoadIndicator.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomLoadIndicator.focus();
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  _instance.focus();
end;

function TjdxCustomLoadIndicator.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomLoadIndicator.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  return _instance.off(eventName);
end;

function TjdxCustomLoadIndicator.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomLoadIndicator.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  return _instance.on(events);
end;

function TjdxCustomLoadIndicator.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  return _instance.option(optionName);
end;

function TjdxCustomLoadIndicator.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  return _instance.option();
end;

procedure TjdxCustomLoadIndicator.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomLoadIndicator.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  _instance.option(options);
end;

procedure TjdxCustomLoadIndicator.registerKeyHandler();
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  _instance.registerKeyHandler();
end;

procedure TjdxCustomLoadIndicator.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomLoadIndicator.repaint();
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  _instance.repaint();
end;

procedure TjdxCustomLoadIndicator.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxLoadIndicator("instance");
  _instance.resetOption(optionName);
end;

end.
