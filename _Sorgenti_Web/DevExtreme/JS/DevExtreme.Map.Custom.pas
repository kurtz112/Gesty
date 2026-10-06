unit DevExtreme.Map.Custom;

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
  DevExtreme.Map.JS,
  DevExtreme.Types;

type
  TjdxCustomMap = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FapiKey: TJSObject;
    FautoAdjust: boolean;
    Fbounds: TJSObject;
    Fcenter: TJSObject;
    Fcontrols: boolean;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FmarkerIconSrc: string;
    Fmarkers: TJSArray;
    Fprovider: TdxMapProvider;
    Froutes: TJSArray;
    FrtlEnabled: boolean;
    FtabIndex: integer;
    Ftype_: TdxMapType;
    Fvisible: boolean;
    Fwidth_: JSValue;
    Fzoom: integer;
  private
    FonClick: TdxEventHandler;
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonMarkerAdded: TdxEventHandler;
    FonMarkerRemoved: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonReady: TdxEventHandler;
    FonRouteAdded: TdxEventHandler;
    FonRouteRemoved: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_apiKey(const value: TJSObject);
    procedure Set_autoAdjust(const value: boolean);
    procedure Set_bounds(const value: TJSObject);
    procedure Set_center(const value: TJSObject);
    procedure Set_controls(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_markerIconSrc(const value: string);
    procedure Set_markers(const value: TJSArray);
    procedure Set_provider(const value: TdxMapProvider);
    procedure Set_routes(const value: TJSArray);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_type_(const value: TdxMapType);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
    procedure Set_zoom(const value: integer);
  private
    procedure Set_onClick(const value: TdxEventHandler);
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onMarkerAdded(const value: TdxEventHandler);
    procedure Set_onMarkerRemoved(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onReady(const value: TdxEventHandler);
    procedure Set_onRouteAdded(const value: TdxEventHandler);
    procedure Set_onRouteRemoved(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxMap; assembler;
    function instance: TdxMap; assembler;
  public
    function addMarker(markerOptions: JSValue): TJSPromise; assembler;
    function addRoute(options: JSValue): TJSPromise; assembler;
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    function removeMarker(marker: JSValue): TJSPromise; assembler;
    function removeRoute(route: JSValue): TJSPromise; assembler;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
  public
    property apiKey: TJSObject read FapiKey write Set_apiKey;
    property bounds: TJSObject read Fbounds write Set_bounds;
    property center: TJSObject read Fcenter write Set_center;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property markers: TJSArray read Fmarkers write Set_markers;
    property routes: TJSArray read Froutes write Set_routes;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property autoAdjust: boolean read FautoAdjust write Set_autoAdjust default true;
    property controls: boolean read Fcontrols write Set_controls default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property markerIconSrc: string read FmarkerIconSrc write Set_markerIconSrc;
    property provider: TdxMapProvider read Fprovider write Set_provider default mpGoogle;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property type_: TdxMapType read Ftype_ write Set_type_ default mtRoadmap;
    property visible: boolean read Fvisible write Set_visible default true;
    property zoom: integer read Fzoom write Set_zoom;
  published
    property onClick: TdxEventHandler read FonClick write Set_onClick;
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onMarkerAdded: TdxEventHandler read FonMarkerAdded write Set_onMarkerAdded;
    property onMarkerRemoved: TdxEventHandler read FonMarkerRemoved write Set_onMarkerRemoved;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onReady: TdxEventHandler read FonReady write Set_onReady;
    property onRouteAdded: TdxEventHandler read FonRouteAdded write Set_onRouteAdded;
    property onRouteRemoved: TdxEventHandler read FonRouteRemoved write Set_onRouteRemoved;
  end;

implementation


procedure TjdxCustomMap.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FapiKey := TJSObject.new;
  FautoAdjust := true;
  Fbounds := TJSObject.new;
  Fcenter := TJSObject.new;
  Fcontrols := false;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FmarkerIconSrc := '';
  Fmarkers := TJSArray.new;
  Fprovider := mpGoogle;
  Froutes := TJSArray.new;
  FrtlEnabled := false;
  FtabIndex := 0;
  Ftype_ := mtRoadmap;
  Fvisible := true;
  Fwidth_ := nil;
  Fzoom := 0;

  FonClick := nil;
  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonMarkerAdded := nil;
  FonMarkerRemoved := nil;
  FonOptionChanged := nil;
  FonReady := nil;
  FonRouteAdded := nil;
  FonRouteRemoved := nil;
end;
procedure TjdxCustomMap.InitJQuery;
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
      $(id).dxMap(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomMap.getInstance(element: TJSObject): TdxMap;
asm
  return DevExpress.viz.dxMap.getInstance(element);
end;

function TjdxCustomMap.instance: TdxMap;
asm
  return $(this.GetJQID()).dxMap("instance");
end;
procedure TjdxCustomMap.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('apiKey', apiKey);
    SetOption('autoAdjust', autoAdjust);
    SetOption('bounds', bounds);
    SetOption('center', center);
    SetOption('controls', controls);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('markerIconSrc', markerIconSrc);
    SetOption('markers', markers);
    SetOption('provider', provider.ToString());
    SetOption('routes', routes);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('tabIndex', tabIndex);
    SetOption('type', type_.ToString());
    SetOption('visible', visible);
    SetOption('width', width_);
    SetOption('zoom', zoom);

    SetEvent('click', onClick);
    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('markerAdded', onMarkerAdded);
    SetEvent('markerRemoved', onMarkerRemoved);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('ready', onReady);
    SetEvent('routeAdded', onRouteAdded);
    SetEvent('routeRemoved', onRouteRemoved);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomMap.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomMap.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomMap.Set_apiKey(const Value: TJSObject);
begin
  FapiKey := Value;
  SetOption('apiKey', apiKey);
end;

procedure TjdxCustomMap.Set_autoAdjust(const Value: boolean);
begin
  FautoAdjust := Value;
  SetOption('autoAdjust', autoAdjust);
end;

procedure TjdxCustomMap.Set_bounds(const Value: TJSObject);
begin
  Fbounds := Value;
  SetOption('bounds', bounds);
end;

procedure TjdxCustomMap.Set_center(const Value: TJSObject);
begin
  Fcenter := Value;
  SetOption('center', center);
end;

procedure TjdxCustomMap.Set_controls(const Value: boolean);
begin
  Fcontrols := Value;
  SetOption('controls', controls);
end;

procedure TjdxCustomMap.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomMap.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomMap.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomMap.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomMap.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomMap.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomMap.Set_markerIconSrc(const Value: string);
begin
  FmarkerIconSrc := Value;
  SetOption('markerIconSrc', markerIconSrc);
end;

procedure TjdxCustomMap.Set_markers(const Value: TJSArray);
begin
  Fmarkers := Value;
  SetOption('markers', markers);
end;

procedure TjdxCustomMap.Set_provider(const Value: TdxMapProvider);
begin
  Fprovider := Value;
  SetOption('provider', provider.ToString());
end;

procedure TjdxCustomMap.Set_routes(const Value: TJSArray);
begin
  Froutes := Value;
  SetOption('routes', routes);
end;

procedure TjdxCustomMap.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomMap.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomMap.Set_type_(const Value: TdxMapType);
begin
  Ftype_ := Value;
  SetOption('type', type_.ToString());
end;

procedure TjdxCustomMap.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomMap.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomMap.Set_zoom(const Value: integer);
begin
  Fzoom := Value;
  SetOption('zoom', zoom);
end;

procedure TjdxCustomMap.Set_onClick(const Value: TdxEventHandler);
begin
  FonClick := Value;
  SetEvent('click', onClick);
end;

procedure TjdxCustomMap.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomMap.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomMap.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomMap.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomMap.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomMap.Set_onMarkerAdded(const Value: TdxEventHandler);
begin
  FonMarkerAdded := Value;
  SetEvent('markerAdded', onMarkerAdded);
end;

procedure TjdxCustomMap.Set_onMarkerRemoved(const Value: TdxEventHandler);
begin
  FonMarkerRemoved := Value;
  SetEvent('markerRemoved', onMarkerRemoved);
end;

procedure TjdxCustomMap.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomMap.Set_onReady(const Value: TdxEventHandler);
begin
  FonReady := Value;
  SetEvent('ready', onReady);
end;

procedure TjdxCustomMap.Set_onRouteAdded(const Value: TdxEventHandler);
begin
  FonRouteAdded := Value;
  SetEvent('routeAdded', onRouteAdded);
end;

procedure TjdxCustomMap.Set_onRouteRemoved(const Value: TdxEventHandler);
begin
  FonRouteRemoved := Value;
  SetEvent('routeRemoved', onRouteRemoved);
end;

function TjdxCustomMap.addMarker(markerOptions: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  return _instance.addMarker(markerOptions);
end;

function TjdxCustomMap.addRoute(options: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  return _instance.addRoute(options);
end;

procedure TjdxCustomMap.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomMap.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomMap.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomMap.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomMap.dispose();
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  _instance.dispose();
end;

function TjdxCustomMap.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  return _instance.element();
end;

procedure TjdxCustomMap.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomMap.focus();
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  _instance.focus();
end;

function TjdxCustomMap.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomMap.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  return _instance.off(eventName);
end;

function TjdxCustomMap.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomMap.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  return _instance.on(events);
end;

procedure TjdxCustomMap.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomMap.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  return _instance.option(optionName);
end;

function TjdxCustomMap.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  return _instance.option();
end;

procedure TjdxCustomMap.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  _instance.option(options);
end;

procedure TjdxCustomMap.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  _instance.registerKeyHandler(key, handler);
end;

function TjdxCustomMap.removeMarker(marker: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  return _instance.removeMarker(marker);
end;

function TjdxCustomMap.removeRoute(route: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  return _instance.removeRoute(route);
end;

procedure TjdxCustomMap.repaint();
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  _instance.repaint();
end;

procedure TjdxCustomMap.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxMap("instance");
  _instance.resetOption(optionName);
end;

end.
