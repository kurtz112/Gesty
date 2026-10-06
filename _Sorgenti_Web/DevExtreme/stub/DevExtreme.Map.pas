unit DevExtreme.Map;

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
  DevExtreme.Types;

type
  [ComponentPlatforms(TMSWebPlatform)]
  TjdxMap = class(TjdxCustomControl)
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
  public
    constructor Create(aOwner: TComponent); override;
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


constructor TjdxMap.Create(aOwner: TComponent);
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

procedure TjdxMap.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxMap.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxMap.Set_apiKey(const Value: TJSObject);
begin
  FapiKey := Value;
end;

procedure TjdxMap.Set_autoAdjust(const Value: boolean);
begin
  FautoAdjust := Value;
end;

procedure TjdxMap.Set_bounds(const Value: TJSObject);
begin
  Fbounds := Value;
end;

procedure TjdxMap.Set_center(const Value: TJSObject);
begin
  Fcenter := Value;
end;

procedure TjdxMap.Set_controls(const Value: boolean);
begin
  Fcontrols := Value;
end;

procedure TjdxMap.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxMap.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxMap.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxMap.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxMap.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxMap.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxMap.Set_markerIconSrc(const Value: string);
begin
  FmarkerIconSrc := Value;
end;

procedure TjdxMap.Set_markers(const Value: TJSArray);
begin
  Fmarkers := Value;
end;

procedure TjdxMap.Set_provider(const Value: TdxMapProvider);
begin
  Fprovider := Value;
end;

procedure TjdxMap.Set_routes(const Value: TJSArray);
begin
  Froutes := Value;
end;

procedure TjdxMap.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxMap.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxMap.Set_type_(const Value: TdxMapType);
begin
  Ftype_ := Value;
end;

procedure TjdxMap.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxMap.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxMap.Set_zoom(const Value: integer);
begin
  Fzoom := Value;
end;

procedure TjdxMap.Set_onClick(const Value: TdxEventHandler);
begin
  FonClick := Value;
end;

procedure TjdxMap.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxMap.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxMap.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxMap.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxMap.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxMap.Set_onMarkerAdded(const Value: TdxEventHandler);
begin
  FonMarkerAdded := Value;
end;

procedure TjdxMap.Set_onMarkerRemoved(const Value: TdxEventHandler);
begin
  FonMarkerRemoved := Value;
end;

procedure TjdxMap.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxMap.Set_onReady(const Value: TdxEventHandler);
begin
  FonReady := Value;
end;

procedure TjdxMap.Set_onRouteAdded(const Value: TdxEventHandler);
begin
  FonRouteAdded := Value;
end;

procedure TjdxMap.Set_onRouteRemoved(const Value: TdxEventHandler);
begin
  FonRouteRemoved := Value;
end;

end.
