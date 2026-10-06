unit DevExtreme.LoadPanel.Custom;

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
  DevExtreme.LoadPanel.JS,
  DevExtreme.Types;

type
  TjdxCustomLoadPanel = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fanimation: TJSObject;
    Fcontainer: JSValue;
    FcontentTemplate: JSValue;
    FcopyRootClassesToWrapper: JSValue;
    FdeferRendering: boolean;
    Fdelay: integer;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    FhideOnOutsideClick: JSValue;
    FhideOnParentScroll: boolean;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FindicatorSrc: string;
    FmaxHeight: JSValue;
    FmaxWidth: JSValue;
    Fmessage: string;
    FminHeight: JSValue;
    FminWidth: JSValue;
    Fposition: JSValue;
    FrtlEnabled: boolean;
    Fshading: boolean;
    FshadingColor: string;
    FshowIndicator: boolean;
    FshowPane: boolean;
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
    procedure Set_container(const value: JSValue);
    procedure Set_contentTemplate(const value: JSValue);
    procedure Set_copyRootClassesToWrapper(const value: JSValue);
    procedure Set_deferRendering(const value: boolean);
    procedure Set_delay(const value: integer);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hideOnOutsideClick(const value: JSValue);
    procedure Set_hideOnParentScroll(const value: boolean);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_indicatorSrc(const value: string);
    procedure Set_maxHeight(const value: JSValue);
    procedure Set_maxWidth(const value: JSValue);
    procedure Set_message(const value: string);
    procedure Set_minHeight(const value: JSValue);
    procedure Set_minWidth(const value: JSValue);
    procedure Set_position(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_shading(const value: boolean);
    procedure Set_shadingColor(const value: string);
    procedure Set_showIndicator(const value: boolean);
    procedure Set_showPane(const value: boolean);
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
    function getInstance(element: TJSObject): TdxLoadPanel; assembler;
    function instance: TdxLoadPanel; assembler;
  public
    procedure beginUpdate(); assembler;
    function content(): TJSElement; assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler; overload;
    function hide(): TJSPromise; assembler;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure registerKeyHandler(); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler; overload;
    procedure repaint(); assembler; overload;
    procedure resetOption(optionName: string); assembler;
    procedure show(); assembler; overload;
    procedure toggle(); assembler; overload;
    function toggle(showing: boolean): TJSPromise; assembler; overload;
  public
    property animation: TJSObject read Fanimation write Set_animation;
    property container: JSValue read Fcontainer write Set_container;
    property contentTemplate: JSValue read FcontentTemplate write Set_contentTemplate;
    property copyRootClassesToWrapper: JSValue read FcopyRootClassesToWrapper write Set_copyRootClassesToWrapper;
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
    property delay: integer read Fdelay write Set_delay;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hideOnParentScroll: boolean read FhideOnParentScroll write Set_hideOnParentScroll default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property indicatorSrc: string read FindicatorSrc write Set_indicatorSrc;
    property message: string read Fmessage write Set_message;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property shading: boolean read Fshading write Set_shading default true;
    property shadingColor: string read FshadingColor write Set_shadingColor;
    property showIndicator: boolean read FshowIndicator write Set_showIndicator default true;
    property showPane: boolean read FshowPane write Set_showPane default true;
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


procedure TjdxCustomLoadPanel.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  Fanimation := TJSObject.new;
  Fcontainer := nil;
  FcontentTemplate := nil;
  FcopyRootClassesToWrapper := nil;
  FdeferRendering := true;
  Fdelay := 0;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  FhideOnOutsideClick := nil;
  FhideOnParentScroll := false;
  Fhint := '';
  FhoverStateEnabled := false;
  FindicatorSrc := '';
  FmaxHeight := nil;
  FmaxWidth := nil;
  Fmessage := '';
  FminHeight := nil;
  FminWidth := nil;
  Fposition := nil;
  FrtlEnabled := false;
  Fshading := true;
  FshadingColor := '';
  FshowIndicator := true;
  FshowPane := true;
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
procedure TjdxCustomLoadPanel.InitJQuery;
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
      $(id).dxLoadPanel(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomLoadPanel.getInstance(element: TJSObject): TdxLoadPanel;
asm
  return DevExpress.viz.dxLoadPanel.getInstance(element);
end;

function TjdxCustomLoadPanel.instance: TdxLoadPanel;
asm
  return $(this.GetJQID()).dxLoadPanel("instance");
end;
procedure TjdxCustomLoadPanel.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('animation', animation);
    SetOption('container', container);
    SetOption('contentTemplate', contentTemplate);
    SetOption('copyRootClassesToWrapper', copyRootClassesToWrapper);
    SetOption('deferRendering', deferRendering);
    SetOption('delay', delay);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hideOnOutsideClick', hideOnOutsideClick);
    SetOption('hideOnParentScroll', hideOnParentScroll);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('indicatorSrc', indicatorSrc);
    SetOption('maxHeight', maxHeight);
    SetOption('maxWidth', maxWidth);
    SetOption('message', message);
    SetOption('minHeight', minHeight);
    SetOption('minWidth', minWidth);
    SetOption('position', position);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('shading', shading);
    SetOption('shadingColor', shadingColor);
    SetOption('showIndicator', showIndicator);
    SetOption('showPane', showPane);
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

procedure TjdxCustomLoadPanel.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomLoadPanel.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomLoadPanel.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
  SetOption('animation', animation);
end;

procedure TjdxCustomLoadPanel.Set_container(const Value: JSValue);
begin
  Fcontainer := Value;
  SetOption('container', container);
end;

procedure TjdxCustomLoadPanel.Set_contentTemplate(const Value: JSValue);
begin
  FcontentTemplate := Value;
  SetOption('contentTemplate', contentTemplate);
end;

procedure TjdxCustomLoadPanel.Set_copyRootClassesToWrapper(const Value: JSValue);
begin
  FcopyRootClassesToWrapper := Value;
  SetOption('copyRootClassesToWrapper', copyRootClassesToWrapper);
end;

procedure TjdxCustomLoadPanel.Set_deferRendering(const Value: boolean);
begin
  FdeferRendering := Value;
  SetOption('deferRendering', deferRendering);
end;

procedure TjdxCustomLoadPanel.Set_delay(const Value: integer);
begin
  Fdelay := Value;
  SetOption('delay', delay);
end;

procedure TjdxCustomLoadPanel.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomLoadPanel.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomLoadPanel.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomLoadPanel.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomLoadPanel.Set_hideOnOutsideClick(const Value: JSValue);
begin
  FhideOnOutsideClick := Value;
  SetOption('hideOnOutsideClick', hideOnOutsideClick);
end;

procedure TjdxCustomLoadPanel.Set_hideOnParentScroll(const Value: boolean);
begin
  FhideOnParentScroll := Value;
  SetOption('hideOnParentScroll', hideOnParentScroll);
end;

procedure TjdxCustomLoadPanel.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomLoadPanel.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomLoadPanel.Set_indicatorSrc(const Value: string);
begin
  FindicatorSrc := Value;
  SetOption('indicatorSrc', indicatorSrc);
end;

procedure TjdxCustomLoadPanel.Set_maxHeight(const Value: JSValue);
begin
  FmaxHeight := Value;
  SetOption('maxHeight', maxHeight);
end;

procedure TjdxCustomLoadPanel.Set_maxWidth(const Value: JSValue);
begin
  FmaxWidth := Value;
  SetOption('maxWidth', maxWidth);
end;

procedure TjdxCustomLoadPanel.Set_message(const Value: string);
begin
  Fmessage := Value;
  SetOption('message', message);
end;

procedure TjdxCustomLoadPanel.Set_minHeight(const Value: JSValue);
begin
  FminHeight := Value;
  SetOption('minHeight', minHeight);
end;

procedure TjdxCustomLoadPanel.Set_minWidth(const Value: JSValue);
begin
  FminWidth := Value;
  SetOption('minWidth', minWidth);
end;

procedure TjdxCustomLoadPanel.Set_position(const Value: JSValue);
begin
  Fposition := Value;
  SetOption('position', position);
end;

procedure TjdxCustomLoadPanel.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomLoadPanel.Set_shading(const Value: boolean);
begin
  Fshading := Value;
  SetOption('shading', shading);
end;

procedure TjdxCustomLoadPanel.Set_shadingColor(const Value: string);
begin
  FshadingColor := Value;
  SetOption('shadingColor', shadingColor);
end;

procedure TjdxCustomLoadPanel.Set_showIndicator(const Value: boolean);
begin
  FshowIndicator := Value;
  SetOption('showIndicator', showIndicator);
end;

procedure TjdxCustomLoadPanel.Set_showPane(const Value: boolean);
begin
  FshowPane := Value;
  SetOption('showPane', showPane);
end;

procedure TjdxCustomLoadPanel.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomLoadPanel.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomLoadPanel.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomLoadPanel.Set_wrapperAttr(const Value: JSValue);
begin
  FwrapperAttr := Value;
  SetOption('wrapperAttr', wrapperAttr);
end;

procedure TjdxCustomLoadPanel.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomLoadPanel.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomLoadPanel.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomLoadPanel.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomLoadPanel.Set_onHidden(const Value: TdxEventHandler);
begin
  FonHidden := Value;
  SetEvent('hidden', onHidden);
end;

procedure TjdxCustomLoadPanel.Set_onHiding(const Value: TdxEventHandler);
begin
  FonHiding := Value;
  SetEvent('hiding', onHiding);
end;

procedure TjdxCustomLoadPanel.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomLoadPanel.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomLoadPanel.Set_onShowing(const Value: TdxEventHandler);
begin
  FonShowing := Value;
  SetEvent('showing', onShowing);
end;

procedure TjdxCustomLoadPanel.Set_onShown(const Value: TdxEventHandler);
begin
  FonShown := Value;
  SetEvent('shown', onShown);
end;

procedure TjdxCustomLoadPanel.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  _instance.beginUpdate();
end;

function TjdxCustomLoadPanel.content(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  return _instance.content();
end;

procedure TjdxCustomLoadPanel.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomLoadPanel.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomLoadPanel.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomLoadPanel.dispose();
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  _instance.dispose();
end;

function TjdxCustomLoadPanel.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  return _instance.element();
end;

procedure TjdxCustomLoadPanel.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomLoadPanel.focus();
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  _instance.focus();
end;

function TjdxCustomLoadPanel.hide(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  return _instance.hide();
end;

function TjdxCustomLoadPanel.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  return _instance.off(eventName);
end;

function TjdxCustomLoadPanel.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomLoadPanel.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomLoadPanel.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  return _instance.on(events);
end;

function TjdxCustomLoadPanel.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  return _instance.option();
end;

procedure TjdxCustomLoadPanel.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomLoadPanel.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  _instance.option(options);
end;

function TjdxCustomLoadPanel.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomLoadPanel.registerKeyHandler();
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  _instance.registerKeyHandler();
end;

procedure TjdxCustomLoadPanel.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomLoadPanel.repaint();
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  _instance.repaint();
end;

procedure TjdxCustomLoadPanel.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomLoadPanel.show();
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  _instance.show();
end;

procedure TjdxCustomLoadPanel.toggle();
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  _instance.toggle();
end;

function TjdxCustomLoadPanel.toggle(showing: boolean): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxLoadPanel("instance");
  return _instance.toggle(showing);
end;

end.
