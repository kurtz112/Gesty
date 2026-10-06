unit DevExtreme.ScrollView.Custom;

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
  DevExtreme.ScrollView.JS,
  DevExtreme.Types;

type
  TjdxCustomScrollView = class(TjdxCustomControl)
  private
    FbounceEnabled: boolean;
    Fdirection: TdxScrollDirection;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fheight_: JSValue;
    FpulledDownText: string;
    FpullingDownText: string;
    FreachBottomText: string;
    FrefreshingText: string;
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
    FonPullDown: TdxEventHandler;
    FonReachBottom: TdxEventHandler;
    FonScroll: TdxEventHandler;
    FonUpdated: TdxEventHandler;
  private
    procedure Set_bounceEnabled(const value: boolean);
    procedure Set_direction(const value: TdxScrollDirection);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_pulledDownText(const value: string);
    procedure Set_pullingDownText(const value: string);
    procedure Set_reachBottomText(const value: string);
    procedure Set_refreshingText(const value: string);
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
    procedure Set_onPullDown(const value: TdxEventHandler);
    procedure Set_onReachBottom(const value: TdxEventHandler);
    procedure Set_onScroll(const value: TdxEventHandler);
    procedure Set_onUpdated(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxScrollView; assembler;
    function instance: TdxScrollView; assembler;
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
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(): TJSObject; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure refresh(); assembler;
    function release(preventScrollBottom: boolean): TJSPromise; assembler;
    procedure resetOption(optionName: string); assembler;
    procedure scrollBy(distance: JSValue); assembler;
    function scrollHeight(): integer; assembler;
    function scrollLeft(): integer; assembler;
    function scrollOffset(): TJSObject; assembler;
    procedure scrollTo(targetLocation: JSValue); assembler;
    procedure scrollToElement(element: JSValue); assembler;
    function scrollTop(): integer; assembler;
    function scrollWidth(): integer; assembler;
    procedure toggleLoading(showOrHide: boolean); assembler;
    function update(): TJSPromise; assembler;
  public
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property bounceEnabled: boolean read FbounceEnabled write Set_bounceEnabled;
    property direction: TdxScrollDirection read Fdirection write Set_direction default sdVertical;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property pulledDownText: string read FpulledDownText write Set_pulledDownText;
    property pullingDownText: string read FpullingDownText write Set_pullingDownText;
    property reachBottomText: string read FreachBottomText write Set_reachBottomText;
    property refreshingText: string read FrefreshingText write Set_refreshingText;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property scrollByContent: boolean read FscrollByContent write Set_scrollByContent;
    property scrollByThumb: boolean read FscrollByThumb write Set_scrollByThumb;
    property showScrollbar: TdxScrollableShowScrollbar read FshowScrollbar write Set_showScrollbar default sssAlways;
    property useNative: boolean read FuseNative write Set_useNative;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onPullDown: TdxEventHandler read FonPullDown write Set_onPullDown;
    property onReachBottom: TdxEventHandler read FonReachBottom write Set_onReachBottom;
    property onScroll: TdxEventHandler read FonScroll write Set_onScroll;
    property onUpdated: TdxEventHandler read FonUpdated write Set_onUpdated;
  end;

implementation


procedure TjdxCustomScrollView.CreateInitialize;
begin
  inherited;
  FbounceEnabled := false;
  Fdirection := sdVertical;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fheight_ := nil;
  FpulledDownText := '';
  FpullingDownText := '';
  FreachBottomText := '';
  FrefreshingText := '';
  FrtlEnabled := false;
  FscrollByContent := false;
  FscrollByThumb := false;
  FshowScrollbar := sssAlways;
  FuseNative := false;
  Fwidth_ := nil;

  FonDisposing := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonPullDown := nil;
  FonReachBottom := nil;
  FonScroll := nil;
  FonUpdated := nil;
end;
procedure TjdxCustomScrollView.InitJQuery;
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
      $(id).dxScrollView(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomScrollView.getInstance(element: TJSObject): TdxScrollView;
asm
  return DevExpress.viz.dxScrollView.getInstance(element);
end;

function TjdxCustomScrollView.instance: TdxScrollView;
asm
  return $(this.GetJQID()).dxScrollView("instance");
end;
procedure TjdxCustomScrollView.UpdateElement;
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
    SetOption('pulledDownText', pulledDownText);
    SetOption('pullingDownText', pullingDownText);
    SetOption('reachBottomText', reachBottomText);
    SetOption('refreshingText', refreshingText);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('scrollByContent', scrollByContent);
    SetOption('scrollByThumb', scrollByThumb);
    SetOption('showScrollbar', showScrollbar.ToString());
    SetOption('useNative', useNative);
    SetOption('width', width_);

    SetEvent('disposing', onDisposing);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('pullDown', onPullDown);
    SetEvent('reachBottom', onReachBottom);
    SetEvent('scroll', onScroll);
    SetEvent('updated', onUpdated);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomScrollView.Set_bounceEnabled(const Value: boolean);
begin
  FbounceEnabled := Value;
  SetOption('bounceEnabled', bounceEnabled);
end;

procedure TjdxCustomScrollView.Set_direction(const Value: TdxScrollDirection);
begin
  Fdirection := Value;
  SetOption('direction', direction.ToString());
end;

procedure TjdxCustomScrollView.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomScrollView.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomScrollView.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomScrollView.Set_pulledDownText(const Value: string);
begin
  FpulledDownText := Value;
  SetOption('pulledDownText', pulledDownText);
end;

procedure TjdxCustomScrollView.Set_pullingDownText(const Value: string);
begin
  FpullingDownText := Value;
  SetOption('pullingDownText', pullingDownText);
end;

procedure TjdxCustomScrollView.Set_reachBottomText(const Value: string);
begin
  FreachBottomText := Value;
  SetOption('reachBottomText', reachBottomText);
end;

procedure TjdxCustomScrollView.Set_refreshingText(const Value: string);
begin
  FrefreshingText := Value;
  SetOption('refreshingText', refreshingText);
end;

procedure TjdxCustomScrollView.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomScrollView.Set_scrollByContent(const Value: boolean);
begin
  FscrollByContent := Value;
  SetOption('scrollByContent', scrollByContent);
end;

procedure TjdxCustomScrollView.Set_scrollByThumb(const Value: boolean);
begin
  FscrollByThumb := Value;
  SetOption('scrollByThumb', scrollByThumb);
end;

procedure TjdxCustomScrollView.Set_showScrollbar(const Value: TdxScrollableShowScrollbar);
begin
  FshowScrollbar := Value;
  SetOption('showScrollbar', showScrollbar.ToString());
end;

procedure TjdxCustomScrollView.Set_useNative(const Value: boolean);
begin
  FuseNative := Value;
  SetOption('useNative', useNative);
end;

procedure TjdxCustomScrollView.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomScrollView.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomScrollView.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomScrollView.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomScrollView.Set_onPullDown(const Value: TdxEventHandler);
begin
  FonPullDown := Value;
  SetEvent('pullDown', onPullDown);
end;

procedure TjdxCustomScrollView.Set_onReachBottom(const Value: TdxEventHandler);
begin
  FonReachBottom := Value;
  SetEvent('reachBottom', onReachBottom);
end;

procedure TjdxCustomScrollView.Set_onScroll(const Value: TdxEventHandler);
begin
  FonScroll := Value;
  SetEvent('scroll', onScroll);
end;

procedure TjdxCustomScrollView.Set_onUpdated(const Value: TdxEventHandler);
begin
  FonUpdated := Value;
  SetEvent('updated', onUpdated);
end;

procedure TjdxCustomScrollView.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  _instance.beginUpdate();
end;

function TjdxCustomScrollView.clientHeight(): integer;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.clientHeight();
end;

function TjdxCustomScrollView.clientWidth(): integer;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.clientWidth();
end;

function TjdxCustomScrollView.content(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.content();
end;

procedure TjdxCustomScrollView.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomScrollView.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomScrollView.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomScrollView.dispose();
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  _instance.dispose();
end;

function TjdxCustomScrollView.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.element();
end;

procedure TjdxCustomScrollView.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  _instance.endUpdate();
end;

function TjdxCustomScrollView.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomScrollView.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.off(eventName);
end;

function TjdxCustomScrollView.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.on(events);
end;

function TjdxCustomScrollView.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.on(eventName, eventHandler);
end;

procedure TjdxCustomScrollView.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  _instance.option(options);
end;

procedure TjdxCustomScrollView.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomScrollView.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.option();
end;

function TjdxCustomScrollView.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomScrollView.refresh();
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  _instance.refresh();
end;

function TjdxCustomScrollView.release(preventScrollBottom: boolean): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.release(preventScrollBottom);
end;

procedure TjdxCustomScrollView.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomScrollView.scrollBy(distance: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  _instance.scrollBy(distance);
end;

function TjdxCustomScrollView.scrollHeight(): integer;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.scrollHeight();
end;

function TjdxCustomScrollView.scrollLeft(): integer;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.scrollLeft();
end;

function TjdxCustomScrollView.scrollOffset(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.scrollOffset();
end;

procedure TjdxCustomScrollView.scrollTo(targetLocation: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  _instance.scrollTo(targetLocation);
end;

procedure TjdxCustomScrollView.scrollToElement(element: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  _instance.scrollToElement(element);
end;

function TjdxCustomScrollView.scrollTop(): integer;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.scrollTop();
end;

function TjdxCustomScrollView.scrollWidth(): integer;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.scrollWidth();
end;

procedure TjdxCustomScrollView.toggleLoading(showOrHide: boolean);
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  _instance.toggleLoading(showOrHide);
end;

function TjdxCustomScrollView.update(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxScrollView("instance");
  return _instance.update();
end;

end.
