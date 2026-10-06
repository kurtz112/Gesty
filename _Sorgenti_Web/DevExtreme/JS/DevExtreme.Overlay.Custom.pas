unit DevExtreme.Overlay.Custom;

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
  DevExtreme.Overlay.JS,
  DevExtreme.Types;

type
  TjdxCustomOverlay = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fanimation: TJSObject;
    FcontentTemplate: JSValue;
    FdeferRendering: boolean;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    FhideOnOutsideClick: JSValue;
    FhideOnParentScroll: boolean;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FmaxHeight: JSValue;
    FmaxWidth: JSValue;
    FminHeight: JSValue;
    FminWidth: JSValue;
    Fposition: JSValue;
    FrtlEnabled: boolean;
    Fshading: boolean;
    FshadingColor: string;
    FtabIndex: integer;
    Fvisible: boolean;
    Fwidth_: JSValue;
    FwrapperAttr: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonHidden: TdxEventHandler;
    FonHiding: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonShowing: TdxEventHandler;
    FonShown: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_animation(const value: TJSObject);
    procedure Set_contentTemplate(const value: JSValue);
    procedure Set_deferRendering(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hideOnOutsideClick(const value: JSValue);
    procedure Set_hideOnParentScroll(const value: boolean);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_maxHeight(const value: JSValue);
    procedure Set_maxWidth(const value: JSValue);
    procedure Set_minHeight(const value: JSValue);
    procedure Set_minWidth(const value: JSValue);
    procedure Set_position(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_shading(const value: boolean);
    procedure Set_shadingColor(const value: string);
    procedure Set_tabIndex(const value: integer);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
    procedure Set_wrapperAttr(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onHidden(const value: TdxEventHandler);
    procedure Set_onHiding(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onShowing(const value: TdxEventHandler);
    procedure Set_onShown(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxOverlay; assembler;
    function instance: TdxOverlay; assembler;
  public
    procedure beginUpdate(); assembler;
    function content(): TJSElement; assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler;
    function hide(): TJSPromise; assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure repaint(); assembler; overload;
    procedure resetOption(optionName: string); assembler;
    function show(): TJSPromise; assembler;
    function toggle(showing: boolean): TJSPromise; assembler;
  public
    property animation: TJSObject read Fanimation write Set_animation;
    property contentTemplate: JSValue read FcontentTemplate write Set_contentTemplate;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property hideOnOutsideClick: JSValue read FhideOnOutsideClick write Set_hideOnOutsideClick;
    property maxHeight: JSValue read FmaxHeight write Set_maxHeight;
    property maxWidth: JSValue read FmaxWidth write Set_maxWidth;
    property minHeight: JSValue read FminHeight write Set_minHeight;
    property minWidth: JSValue read FminWidth write Set_minWidth;
    property position: JSValue read Fposition write Set_position;
    property width_: JSValue read Fwidth_ write Set_width_;
    property wrapperAttr: JSValue read FwrapperAttr write Set_wrapperAttr;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property deferRendering: boolean read FdeferRendering write Set_deferRendering default true;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hideOnParentScroll: boolean read FhideOnParentScroll write Set_hideOnParentScroll default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property shading: boolean read Fshading write Set_shading default true;
    property shadingColor: string read FshadingColor write Set_shadingColor;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onHidden: TdxEventHandler read FonHidden write Set_onHidden;
    property onHiding: TdxEventHandler read FonHiding write Set_onHiding;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onShowing: TdxEventHandler read FonShowing write Set_onShowing;
    property onShown: TdxEventHandler read FonShown write Set_onShown;
  end;

implementation


procedure TjdxCustomOverlay.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  Fanimation := TJSObject.new;
  FcontentTemplate := nil;
  FdeferRendering := true;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  FhideOnOutsideClick := nil;
  FhideOnParentScroll := false;
  Fhint := '';
  FhoverStateEnabled := false;
  FmaxHeight := nil;
  FmaxWidth := nil;
  FminHeight := nil;
  FminWidth := nil;
  Fposition := nil;
  FrtlEnabled := false;
  Fshading := true;
  FshadingColor := '';
  FtabIndex := 0;
  Fvisible := true;
  Fwidth_ := nil;
  FwrapperAttr := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonHidden := nil;
  FonHiding := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonShowing := nil;
  FonShown := nil;
end;
procedure TjdxCustomOverlay.InitJQuery;
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
      $(id).dxOverlay(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomOverlay.getInstance(element: TJSObject): TdxOverlay;
asm
  return DevExpress.viz.dxOverlay.getInstance(element);
end;

function TjdxCustomOverlay.instance: TdxOverlay;
asm
  return $(this.GetJQID()).dxOverlay("instance");
end;
procedure TjdxCustomOverlay.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('animation', animation);
    SetOption('contentTemplate', contentTemplate);
    SetOption('deferRendering', deferRendering);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hideOnOutsideClick', hideOnOutsideClick);
    SetOption('hideOnParentScroll', hideOnParentScroll);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('maxHeight', maxHeight);
    SetOption('maxWidth', maxWidth);
    SetOption('minHeight', minHeight);
    SetOption('minWidth', minWidth);
    SetOption('position', position);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('shading', shading);
    SetOption('shadingColor', shadingColor);
    SetOption('tabIndex', tabIndex);
    SetOption('visible', visible);
    SetOption('width', width_);
    SetOption('wrapperAttr', wrapperAttr);

    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('hidden', onHidden);
    SetEvent('hiding', onHiding);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('showing', onShowing);
    SetEvent('shown', onShown);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomOverlay.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomOverlay.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomOverlay.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
  SetOption('animation', animation);
end;

procedure TjdxCustomOverlay.Set_contentTemplate(const Value: JSValue);
begin
  FcontentTemplate := Value;
  SetOption('contentTemplate', contentTemplate);
end;

procedure TjdxCustomOverlay.Set_deferRendering(const Value: boolean);
begin
  FdeferRendering := Value;
  SetOption('deferRendering', deferRendering);
end;

procedure TjdxCustomOverlay.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomOverlay.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomOverlay.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomOverlay.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomOverlay.Set_hideOnOutsideClick(const Value: JSValue);
begin
  FhideOnOutsideClick := Value;
  SetOption('hideOnOutsideClick', hideOnOutsideClick);
end;

procedure TjdxCustomOverlay.Set_hideOnParentScroll(const Value: boolean);
begin
  FhideOnParentScroll := Value;
  SetOption('hideOnParentScroll', hideOnParentScroll);
end;

procedure TjdxCustomOverlay.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomOverlay.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomOverlay.Set_maxHeight(const Value: JSValue);
begin
  FmaxHeight := Value;
  SetOption('maxHeight', maxHeight);
end;

procedure TjdxCustomOverlay.Set_maxWidth(const Value: JSValue);
begin
  FmaxWidth := Value;
  SetOption('maxWidth', maxWidth);
end;

procedure TjdxCustomOverlay.Set_minHeight(const Value: JSValue);
begin
  FminHeight := Value;
  SetOption('minHeight', minHeight);
end;

procedure TjdxCustomOverlay.Set_minWidth(const Value: JSValue);
begin
  FminWidth := Value;
  SetOption('minWidth', minWidth);
end;

procedure TjdxCustomOverlay.Set_position(const Value: JSValue);
begin
  Fposition := Value;
  SetOption('position', position);
end;

procedure TjdxCustomOverlay.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomOverlay.Set_shading(const Value: boolean);
begin
  Fshading := Value;
  SetOption('shading', shading);
end;

procedure TjdxCustomOverlay.Set_shadingColor(const Value: string);
begin
  FshadingColor := Value;
  SetOption('shadingColor', shadingColor);
end;

procedure TjdxCustomOverlay.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomOverlay.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomOverlay.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomOverlay.Set_wrapperAttr(const Value: JSValue);
begin
  FwrapperAttr := Value;
  SetOption('wrapperAttr', wrapperAttr);
end;

procedure TjdxCustomOverlay.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomOverlay.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomOverlay.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomOverlay.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomOverlay.Set_onHidden(const Value: TdxEventHandler);
begin
  FonHidden := Value;
  SetEvent('hidden', onHidden);
end;

procedure TjdxCustomOverlay.Set_onHiding(const Value: TdxEventHandler);
begin
  FonHiding := Value;
  SetEvent('hiding', onHiding);
end;

procedure TjdxCustomOverlay.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomOverlay.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomOverlay.Set_onShowing(const Value: TdxEventHandler);
begin
  FonShowing := Value;
  SetEvent('showing', onShowing);
end;

procedure TjdxCustomOverlay.Set_onShown(const Value: TdxEventHandler);
begin
  FonShown := Value;
  SetEvent('shown', onShown);
end;

procedure TjdxCustomOverlay.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  _instance.beginUpdate();
end;

function TjdxCustomOverlay.content(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  return _instance.content();
end;

procedure TjdxCustomOverlay.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomOverlay.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomOverlay.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomOverlay.dispose();
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  _instance.dispose();
end;

function TjdxCustomOverlay.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  return _instance.element();
end;

procedure TjdxCustomOverlay.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomOverlay.focus();
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  _instance.focus();
end;

function TjdxCustomOverlay.hide(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  return _instance.hide();
end;

function TjdxCustomOverlay.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomOverlay.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  return _instance.off(eventName);
end;

function TjdxCustomOverlay.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomOverlay.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  return _instance.on(events);
end;

procedure TjdxCustomOverlay.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomOverlay.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  return _instance.option(optionName);
end;

function TjdxCustomOverlay.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  return _instance.option();
end;

procedure TjdxCustomOverlay.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  _instance.option(options);
end;

procedure TjdxCustomOverlay.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomOverlay.repaint();
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  _instance.repaint();
end;

procedure TjdxCustomOverlay.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  _instance.resetOption(optionName);
end;

function TjdxCustomOverlay.show(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  return _instance.show();
end;

function TjdxCustomOverlay.toggle(showing: boolean): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxOverlay("instance");
  return _instance.toggle(showing);
end;

end.
