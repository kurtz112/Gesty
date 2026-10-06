unit DevExtreme.DeferRendering.Custom;

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
  DevExtreme.DeferRendering.JS,
  DevExtreme.Types;

type
  TjdxCustomDeferRendering = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fanimation: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FrenderWhen: JSValue;
    FrtlEnabled: boolean;
    FshowLoadIndicator: boolean;
    FstaggerItemSelector: string;
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
    FonRendered: TdxEventHandler;
    FonShown: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_animation(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_renderWhen(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_showLoadIndicator(const value: boolean);
    procedure Set_staggerItemSelector(const value: string);
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
    procedure Set_onRendered(const value: TdxEventHandler);
    procedure Set_onShown(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxDeferRendering; assembler;
    function instance: TdxDeferRendering; assembler;
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
    property animation: JSValue read Fanimation write Set_animation;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property renderWhen: JSValue read FrenderWhen write Set_renderWhen;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showLoadIndicator: boolean read FshowLoadIndicator write Set_showLoadIndicator default false;
    property staggerItemSelector: string read FstaggerItemSelector write Set_staggerItemSelector;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onRendered: TdxEventHandler read FonRendered write Set_onRendered;
    property onShown: TdxEventHandler read FonShown write Set_onShown;
  end;

implementation


procedure TjdxCustomDeferRendering.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  Fanimation := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FrenderWhen := nil;
  FrtlEnabled := false;
  FshowLoadIndicator := false;
  FstaggerItemSelector := '';
  FtabIndex := 0;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonRendered := nil;
  FonShown := nil;
end;
procedure TjdxCustomDeferRendering.InitJQuery;
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
      $(id).dxDeferRendering(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomDeferRendering.getInstance(element: TJSObject): TdxDeferRendering;
asm
  return DevExpress.viz.dxDeferRendering.getInstance(element);
end;

function TjdxCustomDeferRendering.instance: TdxDeferRendering;
asm
  return $(this.GetJQID()).dxDeferRendering("instance");
end;
procedure TjdxCustomDeferRendering.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('animation', animation);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('renderWhen', renderWhen);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('showLoadIndicator', showLoadIndicator);
    SetOption('staggerItemSelector', staggerItemSelector);
    SetOption('tabIndex', tabIndex);
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('rendered', onRendered);
    SetEvent('shown', onShown);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomDeferRendering.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomDeferRendering.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomDeferRendering.Set_animation(const Value: JSValue);
begin
  Fanimation := Value;
  SetOption('animation', animation);
end;

procedure TjdxCustomDeferRendering.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomDeferRendering.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomDeferRendering.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomDeferRendering.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomDeferRendering.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomDeferRendering.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomDeferRendering.Set_renderWhen(const Value: JSValue);
begin
  FrenderWhen := Value;
  SetOption('renderWhen', renderWhen);
end;

procedure TjdxCustomDeferRendering.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomDeferRendering.Set_showLoadIndicator(const Value: boolean);
begin
  FshowLoadIndicator := Value;
  SetOption('showLoadIndicator', showLoadIndicator);
end;

procedure TjdxCustomDeferRendering.Set_staggerItemSelector(const Value: string);
begin
  FstaggerItemSelector := Value;
  SetOption('staggerItemSelector', staggerItemSelector);
end;

procedure TjdxCustomDeferRendering.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomDeferRendering.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomDeferRendering.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomDeferRendering.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomDeferRendering.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomDeferRendering.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomDeferRendering.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomDeferRendering.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomDeferRendering.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomDeferRendering.Set_onRendered(const Value: TdxEventHandler);
begin
  FonRendered := Value;
  SetEvent('rendered', onRendered);
end;

procedure TjdxCustomDeferRendering.Set_onShown(const Value: TdxEventHandler);
begin
  FonShown := Value;
  SetEvent('shown', onShown);
end;

procedure TjdxCustomDeferRendering.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomDeferRendering.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomDeferRendering.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomDeferRendering.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomDeferRendering.dispose();
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  _instance.dispose();
end;

function TjdxCustomDeferRendering.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  return _instance.element();
end;

procedure TjdxCustomDeferRendering.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomDeferRendering.focus();
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  _instance.focus();
end;

function TjdxCustomDeferRendering.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  return _instance.off(eventName);
end;

function TjdxCustomDeferRendering.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomDeferRendering.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomDeferRendering.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  return _instance.on(events);
end;

function TjdxCustomDeferRendering.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  return _instance.option(optionName);
end;

function TjdxCustomDeferRendering.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  return _instance.option();
end;

procedure TjdxCustomDeferRendering.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomDeferRendering.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  _instance.option(options);
end;

procedure TjdxCustomDeferRendering.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomDeferRendering.repaint();
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  _instance.repaint();
end;

procedure TjdxCustomDeferRendering.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxDeferRendering("instance");
  _instance.resetOption(optionName);
end;

end.
