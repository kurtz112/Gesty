unit DevExtreme.Drawer.Custom;

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
  DevExtreme.Drawer.JS,
  DevExtreme.Types;

type
  TjdxCustomDrawer = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FanimationDuration: integer;
    FanimationEnabled: boolean;
    FcloseOnOutsideClick: JSValue;
    FcontentTemplate: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FmaxSize: integer;
    FminSize: integer;
    Fopened: boolean;
    FopenedStateMode: TdxOpenedStateMode;
    Fposition: TdxPanelLocation;
    FrevealMode: TdxRevealMode;
    FrtlEnabled: boolean;
    Fshading: boolean;
    FtabIndex: integer;
    Ftemplate: JSValue;
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
    procedure Set_animationDuration(const value: integer);
    procedure Set_animationEnabled(const value: boolean);
    procedure Set_closeOnOutsideClick(const value: JSValue);
    procedure Set_contentTemplate(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_maxSize(const value: integer);
    procedure Set_minSize(const value: integer);
    procedure Set_opened(const value: boolean);
    procedure Set_openedStateMode(const value: TdxOpenedStateMode);
    procedure Set_position(const value: TdxPanelLocation);
    procedure Set_revealMode(const value: TdxRevealMode);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_shading(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_template(const value: JSValue);
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
    function getInstance(element: TJSObject): TdxDrawer; assembler;
    function instance: TdxDrawer; assembler;
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
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure registerKeyHandler(); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler; overload;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
    function show(): TJSPromise; assembler;
    function toggle(): TJSPromise; assembler;
    function viewContent(): TJSElement; assembler;
  public
    property closeOnOutsideClick: JSValue read FcloseOnOutsideClick write Set_closeOnOutsideClick;
    property contentTemplate: JSValue read FcontentTemplate write Set_contentTemplate;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property template: JSValue read Ftemplate write Set_template;
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
    property maxSize: integer read FmaxSize write Set_maxSize;
    property minSize: integer read FminSize write Set_minSize;
    property opened: boolean read Fopened write Set_opened default false;
    property openedStateMode: TdxOpenedStateMode read FopenedStateMode write Set_openedStateMode default osmShrink;
    property position: TdxPanelLocation read Fposition write Set_position default plLeft;
    property revealMode: TdxRevealMode read FrevealMode write Set_revealMode default rmSlide;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property shading: boolean read Fshading write Set_shading default false;
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


procedure TjdxCustomDrawer.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FanimationDuration := 0;
  FanimationEnabled := true;
  FcloseOnOutsideClick := nil;
  FcontentTemplate := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FmaxSize := 0;
  FminSize := 0;
  Fopened := false;
  FopenedStateMode := osmShrink;
  Fposition := plLeft;
  FrevealMode := rmSlide;
  FrtlEnabled := false;
  Fshading := false;
  FtabIndex := 0;
  Ftemplate := nil;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
end;
procedure TjdxCustomDrawer.InitJQuery;
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
      $(id).dxDrawer(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomDrawer.getInstance(element: TJSObject): TdxDrawer;
asm
  return DevExpress.viz.dxDrawer.getInstance(element);
end;

function TjdxCustomDrawer.instance: TdxDrawer;
asm
  return $(this.GetJQID()).dxDrawer("instance");
end;
procedure TjdxCustomDrawer.UpdateElement;
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
    SetOption('closeOnOutsideClick', closeOnOutsideClick);
    SetOption('contentTemplate', contentTemplate);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('maxSize', maxSize);
    SetOption('minSize', minSize);
    SetOption('opened', opened);
    SetOption('openedStateMode', openedStateMode.ToString());
    SetOption('position', position.ToString());
    SetOption('revealMode', revealMode.ToString());
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('shading', shading);
    SetOption('tabIndex', tabIndex);
    SetOption('template', template);
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

procedure TjdxCustomDrawer.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomDrawer.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomDrawer.Set_animationDuration(const Value: integer);
begin
  FanimationDuration := Value;
  SetOption('animationDuration', animationDuration);
end;

procedure TjdxCustomDrawer.Set_animationEnabled(const Value: boolean);
begin
  FanimationEnabled := Value;
  SetOption('animationEnabled', animationEnabled);
end;

procedure TjdxCustomDrawer.Set_closeOnOutsideClick(const Value: JSValue);
begin
  FcloseOnOutsideClick := Value;
  SetOption('closeOnOutsideClick', closeOnOutsideClick);
end;

procedure TjdxCustomDrawer.Set_contentTemplate(const Value: JSValue);
begin
  FcontentTemplate := Value;
  SetOption('contentTemplate', contentTemplate);
end;

procedure TjdxCustomDrawer.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomDrawer.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomDrawer.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomDrawer.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomDrawer.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomDrawer.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomDrawer.Set_maxSize(const Value: integer);
begin
  FmaxSize := Value;
  SetOption('maxSize', maxSize);
end;

procedure TjdxCustomDrawer.Set_minSize(const Value: integer);
begin
  FminSize := Value;
  SetOption('minSize', minSize);
end;

procedure TjdxCustomDrawer.Set_opened(const Value: boolean);
begin
  Fopened := Value;
  SetOption('opened', opened);
end;

procedure TjdxCustomDrawer.Set_openedStateMode(const Value: TdxOpenedStateMode);
begin
  FopenedStateMode := Value;
  SetOption('openedStateMode', openedStateMode.ToString());
end;

procedure TjdxCustomDrawer.Set_position(const Value: TdxPanelLocation);
begin
  Fposition := Value;
  SetOption('position', position.ToString());
end;

procedure TjdxCustomDrawer.Set_revealMode(const Value: TdxRevealMode);
begin
  FrevealMode := Value;
  SetOption('revealMode', revealMode.ToString());
end;

procedure TjdxCustomDrawer.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomDrawer.Set_shading(const Value: boolean);
begin
  Fshading := Value;
  SetOption('shading', shading);
end;

procedure TjdxCustomDrawer.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomDrawer.Set_template(const Value: JSValue);
begin
  Ftemplate := Value;
  SetOption('template', template);
end;

procedure TjdxCustomDrawer.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomDrawer.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomDrawer.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomDrawer.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomDrawer.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomDrawer.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomDrawer.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomDrawer.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomDrawer.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  _instance.beginUpdate();
end;

function TjdxCustomDrawer.content(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  return _instance.content();
end;

procedure TjdxCustomDrawer.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomDrawer.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomDrawer.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomDrawer.dispose();
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  _instance.dispose();
end;

function TjdxCustomDrawer.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  return _instance.element();
end;

procedure TjdxCustomDrawer.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomDrawer.focus();
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  _instance.focus();
end;

function TjdxCustomDrawer.hide(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  return _instance.hide();
end;

function TjdxCustomDrawer.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomDrawer.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  return _instance.off(eventName);
end;

function TjdxCustomDrawer.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  return _instance.on(events);
end;

function TjdxCustomDrawer.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomDrawer.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  return _instance.option();
end;

procedure TjdxCustomDrawer.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  _instance.option(options);
end;

procedure TjdxCustomDrawer.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomDrawer.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomDrawer.registerKeyHandler();
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  _instance.registerKeyHandler();
end;

procedure TjdxCustomDrawer.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomDrawer.repaint();
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  _instance.repaint();
end;

procedure TjdxCustomDrawer.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  _instance.resetOption(optionName);
end;

function TjdxCustomDrawer.show(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  return _instance.show();
end;

function TjdxCustomDrawer.toggle(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  return _instance.toggle();
end;

function TjdxCustomDrawer.viewContent(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDrawer("instance");
  return _instance.viewContent();
end;

end.
