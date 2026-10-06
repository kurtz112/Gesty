unit DevExtreme.Scrollable.Custom;

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
  DevExtreme.Scrollable.JS,
  DevExtreme.Types;

type
  TjdxCustomScrollable = class(TjdxCustomControl)
  private
    FbounceEnabled: boolean;
    Fdirection: TdxScrollDirection;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fheight_: JSValue;
    FrtlEnabled: boolean;
    FscrollByContent: boolean;
    FscrollByThumb: boolean;
    FshowScrollbar: TdxScrollableShowScrollbar;
    FuseNative: boolean;
    Fwidth_: JSValue;
  private
    FonDisposing: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonScroll: TdxEventHandler;
    FonUpdated: TdxEventHandler;
  private
    procedure Set_bounceEnabled(const value: boolean);
    procedure Set_direction(const value: TdxScrollDirection);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scrollByContent(const value: boolean);
    procedure Set_scrollByThumb(const value: boolean);
    procedure Set_showScrollbar(const value: TdxScrollableShowScrollbar);
    procedure Set_useNative(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onScroll(const value: TdxEventHandler);
    procedure Set_onUpdated(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxScrollable; assembler;
    function instance: TdxScrollable; assembler;
  public
    procedure beginUpdate(); assembler;
    function clientHeight(): integer; assembler;
    function clientWidth(): integer; assembler;
    function content(): TJSElement; assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure resetOption(optionName: string); assembler;
    procedure scrollBy(distance: JSValue); assembler;
    function scrollHeight(): integer; assembler;
    function scrollLeft(): integer; assembler;
    function scrollOffset(): TJSObject; assembler;
    procedure scrollTo(targetLocation: JSValue); assembler;
    procedure scrollToElement(element: JSValue); assembler;
    function scrollTop(): integer; assembler;
    function scrollWidth(): integer; assembler;
    function update(): TJSPromise; assembler;
  public
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property bounceEnabled: boolean read FbounceEnabled write Set_bounceEnabled;
    property direction: TdxScrollDirection read Fdirection write Set_direction default sdVertical;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property scrollByContent: boolean read FscrollByContent write Set_scrollByContent;
    property scrollByThumb: boolean read FscrollByThumb write Set_scrollByThumb;
    property showScrollbar: TdxScrollableShowScrollbar read FshowScrollbar write Set_showScrollbar default sssAlways;
    property useNative: boolean read FuseNative write Set_useNative;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onScroll: TdxEventHandler read FonScroll write Set_onScroll;
    property onUpdated: TdxEventHandler read FonUpdated write Set_onUpdated;
  end;

implementation


procedure TjdxCustomScrollable.CreateInitialize;
begin
  inherited;
  FbounceEnabled := false;
  Fdirection := sdVertical;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fheight_ := nil;
  FrtlEnabled := false;
  FscrollByContent := false;
  FscrollByThumb := false;
  FshowScrollbar := sssAlways;
  FuseNative := false;
  Fwidth_ := nil;

  FonDisposing := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonScroll := nil;
  FonUpdated := nil;
end;
procedure TjdxCustomScrollable.InitJQuery;
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
      $(id).dxScrollable(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomScrollable.getInstance(element: TJSObject): TdxScrollable;
asm
  return DevExpress.viz.dxScrollable.getInstance(element);
end;

function TjdxCustomScrollable.instance: TdxScrollable;
asm
  return $(this.GetJQID()).dxScrollable("instance");
end;
procedure TjdxCustomScrollable.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('bounceEnabled', bounceEnabled);
    SetOption('direction', direction.ToString());
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('height', height_);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('scrollByContent', scrollByContent);
    SetOption('scrollByThumb', scrollByThumb);
    SetOption('showScrollbar', showScrollbar.ToString());
    SetOption('useNative', useNative);
    SetOption('width', width_);

    SetEvent('disposing', onDisposing);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('scroll', onScroll);
    SetEvent('updated', onUpdated);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomScrollable.Set_bounceEnabled(const Value: boolean);
begin
  FbounceEnabled := Value;
  SetOption('bounceEnabled', bounceEnabled);
end;

procedure TjdxCustomScrollable.Set_direction(const Value: TdxScrollDirection);
begin
  Fdirection := Value;
  SetOption('direction', direction.ToString());
end;

procedure TjdxCustomScrollable.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomScrollable.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomScrollable.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomScrollable.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomScrollable.Set_scrollByContent(const Value: boolean);
begin
  FscrollByContent := Value;
  SetOption('scrollByContent', scrollByContent);
end;

procedure TjdxCustomScrollable.Set_scrollByThumb(const Value: boolean);
begin
  FscrollByThumb := Value;
  SetOption('scrollByThumb', scrollByThumb);
end;

procedure TjdxCustomScrollable.Set_showScrollbar(const Value: TdxScrollableShowScrollbar);
begin
  FshowScrollbar := Value;
  SetOption('showScrollbar', showScrollbar.ToString());
end;

procedure TjdxCustomScrollable.Set_useNative(const Value: boolean);
begin
  FuseNative := Value;
  SetOption('useNative', useNative);
end;

procedure TjdxCustomScrollable.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomScrollable.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomScrollable.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomScrollable.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomScrollable.Set_onScroll(const Value: TdxEventHandler);
begin
  FonScroll := Value;
  SetEvent('scroll', onScroll);
end;

procedure TjdxCustomScrollable.Set_onUpdated(const Value: TdxEventHandler);
begin
  FonUpdated := Value;
  SetEvent('updated', onUpdated);
end;

procedure TjdxCustomScrollable.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  _instance.beginUpdate();
end;

function TjdxCustomScrollable.clientHeight(): integer;
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  return _instance.clientHeight();
end;

function TjdxCustomScrollable.clientWidth(): integer;
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  return _instance.clientWidth();
end;

function TjdxCustomScrollable.content(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  return _instance.content();
end;

procedure TjdxCustomScrollable.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomScrollable.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomScrollable.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomScrollable.dispose();
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  _instance.dispose();
end;

function TjdxCustomScrollable.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  return _instance.element();
end;

procedure TjdxCustomScrollable.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  _instance.endUpdate();
end;

function TjdxCustomScrollable.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  return _instance.off(eventName);
end;

function TjdxCustomScrollable.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomScrollable.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomScrollable.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  return _instance.on(events);
end;

function TjdxCustomScrollable.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  return _instance.option(optionName);
end;

function TjdxCustomScrollable.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  return _instance.option();
end;

procedure TjdxCustomScrollable.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomScrollable.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  _instance.option(options);
end;

procedure TjdxCustomScrollable.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomScrollable.scrollBy(distance: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  _instance.scrollBy(distance);
end;

function TjdxCustomScrollable.scrollHeight(): integer;
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  return _instance.scrollHeight();
end;

function TjdxCustomScrollable.scrollLeft(): integer;
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  return _instance.scrollLeft();
end;

function TjdxCustomScrollable.scrollOffset(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  return _instance.scrollOffset();
end;

procedure TjdxCustomScrollable.scrollTo(targetLocation: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  _instance.scrollTo(targetLocation);
end;

procedure TjdxCustomScrollable.scrollToElement(element: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  _instance.scrollToElement(element);
end;

function TjdxCustomScrollable.scrollTop(): integer;
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  return _instance.scrollTop();
end;

function TjdxCustomScrollable.scrollWidth(): integer;
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  return _instance.scrollWidth();
end;

function TjdxCustomScrollable.update(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxScrollable("instance");
  return _instance.update();
end;

end.
