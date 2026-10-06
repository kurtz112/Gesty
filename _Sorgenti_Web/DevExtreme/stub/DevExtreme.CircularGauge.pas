unit DevExtreme.CircularGauge;

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
  TjdxCircularGauge = class(TjdxCustomControl)
  private
    Fanimation: TJSObject;
    FcenterTemplate: JSValue;
    FcontainerBackgroundColor: string;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    Fgeometry: TJSObject;
    Fheight_: JSValue;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    FpathModified: boolean;
    FrangeContainer: TJSObject;
    FredrawOnResize: boolean;
    FrtlEnabled: boolean;
    Fscale: TJSObject;
    Fsize: TJSObject;
    FsubvalueIndicator: TJSObject;
    Fsubvalues: TJSArray;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    Fvalue: integer;
    FvalueIndicator: TJSObject;
    Fwidth_: JSValue;
  private
    FonDisposing: TdxEventHandler;
    FonDrawn: TdxEventHandler;
    FonExported: TdxEventHandler;
    FonExporting: TdxEventHandler;
    FonFileSaving: TdxEventHandler;
    FonIncidentOccurred: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonTooltipHidden: TdxEventHandler;
    FonTooltipShown: TdxEventHandler;
  private
    procedure Set_animation(const value: TJSObject);
    procedure Set_centerTemplate(const value: JSValue);
    procedure Set_containerBackgroundColor(const value: string);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_geometry(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_pathModified(const value: boolean);
    procedure Set_rangeContainer(const value: TJSObject);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scale(const value: TJSObject);
    procedure Set_size(const value: TJSObject);
    procedure Set_subvalueIndicator(const value: TJSObject);
    procedure Set_subvalues(const value: TJSArray);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_value(const value: integer);
    procedure Set_valueIndicator(const value: TJSObject);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onDrawn(const value: TdxEventHandler);
    procedure Set_onExported(const value: TdxEventHandler);
    procedure Set_onExporting(const value: TdxEventHandler);
    procedure Set_onFileSaving(const value: TdxEventHandler);
    procedure Set_onIncidentOccurred(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onTooltipHidden(const value: TdxEventHandler);
    procedure Set_onTooltipShown(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property animation: TJSObject read Fanimation write Set_animation;
    property centerTemplate: JSValue read FcenterTemplate write Set_centerTemplate;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property geometry: TJSObject read Fgeometry write Set_geometry;
    property height_: JSValue read Fheight_ write Set_height_;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property rangeContainer: TJSObject read FrangeContainer write Set_rangeContainer;
    property scale: TJSObject read Fscale write Set_scale;
    property size: TJSObject read Fsize write Set_size;
    property subvalueIndicator: TJSObject read FsubvalueIndicator write Set_subvalueIndicator;
    property subvalues: TJSArray read Fsubvalues write Set_subvalues;
    property theme: JSValue read Ftheme write Set_theme;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property valueIndicator: TJSObject read FvalueIndicator write Set_valueIndicator;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property containerBackgroundColor: string read FcontainerBackgroundColor write Set_containerBackgroundColor;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property value: integer read Fvalue write Set_value;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onDrawn: TdxEventHandler read FonDrawn write Set_onDrawn;
    property onExported: TdxEventHandler read FonExported write Set_onExported;
    property onExporting: TdxEventHandler read FonExporting write Set_onExporting;
    property onFileSaving: TdxEventHandler read FonFileSaving write Set_onFileSaving;
    property onIncidentOccurred: TdxEventHandler read FonIncidentOccurred write Set_onIncidentOccurred;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onTooltipHidden: TdxEventHandler read FonTooltipHidden write Set_onTooltipHidden;
    property onTooltipShown: TdxEventHandler read FonTooltipShown write Set_onTooltipShown;
  end;

implementation


constructor TjdxCircularGauge.Create(aOwner: TComponent);
begin
  inherited;
  Fanimation := TJSObject.new;
  FcenterTemplate := nil;
  FcontainerBackgroundColor := '';
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  Fgeometry := TJSObject.new;
  Fheight_ := nil;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  FpathModified := false;
  FrangeContainer := TJSObject.new;
  FredrawOnResize := true;
  FrtlEnabled := false;
  Fscale := TJSObject.new;
  Fsize := TJSObject.new;
  FsubvalueIndicator := TJSObject.new;
  Fsubvalues := TJSArray.new;
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  Fvalue := 0;
  FvalueIndicator := TJSObject.new;
  Fwidth_ := nil;

  FonDisposing := nil;
  FonDrawn := nil;
  FonExported := nil;
  FonExporting := nil;
  FonFileSaving := nil;
  FonIncidentOccurred := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonTooltipHidden := nil;
  FonTooltipShown := nil;
end;

procedure TjdxCircularGauge.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
end;

procedure TjdxCircularGauge.Set_centerTemplate(const Value: JSValue);
begin
  FcenterTemplate := Value;
end;

procedure TjdxCircularGauge.Set_containerBackgroundColor(const Value: string);
begin
  FcontainerBackgroundColor := Value;
end;

procedure TjdxCircularGauge.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxCircularGauge.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxCircularGauge.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
end;

procedure TjdxCircularGauge.Set_geometry(const Value: TJSObject);
begin
  Fgeometry := Value;
end;

procedure TjdxCircularGauge.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxCircularGauge.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
end;

procedure TjdxCircularGauge.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
end;

procedure TjdxCircularGauge.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
end;

procedure TjdxCircularGauge.Set_rangeContainer(const Value: TJSObject);
begin
  FrangeContainer := Value;
end;

procedure TjdxCircularGauge.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
end;

procedure TjdxCircularGauge.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxCircularGauge.Set_scale(const Value: TJSObject);
begin
  Fscale := Value;
end;

procedure TjdxCircularGauge.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
end;

procedure TjdxCircularGauge.Set_subvalueIndicator(const Value: TJSObject);
begin
  FsubvalueIndicator := Value;
end;

procedure TjdxCircularGauge.Set_subvalues(const Value: TJSArray);
begin
  Fsubvalues := Value;
end;

procedure TjdxCircularGauge.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
end;

procedure TjdxCircularGauge.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
end;

procedure TjdxCircularGauge.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
end;

procedure TjdxCircularGauge.Set_value(const Value: integer);
begin
  Fvalue := Value;
end;

procedure TjdxCircularGauge.Set_valueIndicator(const Value: TJSObject);
begin
  FvalueIndicator := Value;
end;

procedure TjdxCircularGauge.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxCircularGauge.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxCircularGauge.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
end;

procedure TjdxCircularGauge.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
end;

procedure TjdxCircularGauge.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
end;

procedure TjdxCircularGauge.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
end;

procedure TjdxCircularGauge.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
end;

procedure TjdxCircularGauge.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxCircularGauge.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxCircularGauge.Set_onTooltipHidden(const Value: TdxEventHandler);
begin
  FonTooltipHidden := Value;
end;

procedure TjdxCircularGauge.Set_onTooltipShown(const Value: TdxEventHandler);
begin
  FonTooltipShown := Value;
end;

end.
