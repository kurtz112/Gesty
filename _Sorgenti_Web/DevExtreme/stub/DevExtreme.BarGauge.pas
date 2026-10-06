unit DevExtreme.BarGauge;

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
  TjdxBarGauge = class(TjdxCustomControl)
  private
    Fanimation: TJSObject;
    FbackgroundColor: string;
    FbarSpacing: integer;
    FbaseValue: integer;
    FcenterTemplate: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FendValue: integer;
    Fexport: TJSObject;
    Fgeometry: TJSObject;
    Fheight_: JSValue;
    Flabel_: TJSObject;
    Flegend: TJSObject;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    Fpalette: JSValue;
    FpaletteExtensionMode: JSValue;
    FpathModified: boolean;
    FredrawOnResize: boolean;
    FrelativeInnerRadius: integer;
    FresolveLabelOverlapping: JSValue;
    FrtlEnabled: boolean;
    Fsize: TJSObject;
    FstartValue: integer;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    Fvalues: TJSArray;
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
    procedure Set_backgroundColor(const value: string);
    procedure Set_barSpacing(const value: integer);
    procedure Set_baseValue(const value: integer);
    procedure Set_centerTemplate(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_endValue(const value: integer);
    procedure Set_export(const value: TJSObject);
    procedure Set_geometry(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_label_(const value: TJSObject);
    procedure Set_legend(const value: TJSObject);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_palette(const value: JSValue);
    procedure Set_paletteExtensionMode(const value: JSValue);
    procedure Set_pathModified(const value: boolean);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_relativeInnerRadius(const value: integer);
    procedure Set_resolveLabelOverlapping(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_size(const value: TJSObject);
    procedure Set_startValue(const value: integer);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_values(const value: TJSArray);
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
    property label_: TJSObject read Flabel_ write Set_label_;
    property legend: TJSObject read Flegend write Set_legend;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property palette: JSValue read Fpalette write Set_palette;
    property paletteExtensionMode: JSValue read FpaletteExtensionMode write Set_paletteExtensionMode;
    property resolveLabelOverlapping: JSValue read FresolveLabelOverlapping write Set_resolveLabelOverlapping;
    property size: TJSObject read Fsize write Set_size;
    property theme: JSValue read Ftheme write Set_theme;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property values: TJSArray read Fvalues write Set_values;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property backgroundColor: string read FbackgroundColor write Set_backgroundColor;
    property barSpacing: integer read FbarSpacing write Set_barSpacing;
    property baseValue: integer read FbaseValue write Set_baseValue;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property endValue: integer read FendValue write Set_endValue;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property relativeInnerRadius: integer read FrelativeInnerRadius write Set_relativeInnerRadius;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property startValue: integer read FstartValue write Set_startValue;
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


constructor TjdxBarGauge.Create(aOwner: TComponent);
begin
  inherited;
  Fanimation := TJSObject.new;
  FbackgroundColor := '';
  FbarSpacing := 0;
  FbaseValue := 0;
  FcenterTemplate := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FendValue := 0;
  Fexport := TJSObject.new;
  Fgeometry := TJSObject.new;
  Fheight_ := nil;
  Flabel_ := TJSObject.new;
  Flegend := TJSObject.new;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  Fpalette := nil;
  FpaletteExtensionMode := nil;
  FpathModified := false;
  FredrawOnResize := true;
  FrelativeInnerRadius := 0;
  FresolveLabelOverlapping := nil;
  FrtlEnabled := false;
  Fsize := TJSObject.new;
  FstartValue := 0;
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  Fvalues := TJSArray.new;
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

procedure TjdxBarGauge.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
end;

procedure TjdxBarGauge.Set_backgroundColor(const Value: string);
begin
  FbackgroundColor := Value;
end;

procedure TjdxBarGauge.Set_barSpacing(const Value: integer);
begin
  FbarSpacing := Value;
end;

procedure TjdxBarGauge.Set_baseValue(const Value: integer);
begin
  FbaseValue := Value;
end;

procedure TjdxBarGauge.Set_centerTemplate(const Value: JSValue);
begin
  FcenterTemplate := Value;
end;

procedure TjdxBarGauge.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxBarGauge.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxBarGauge.Set_endValue(const Value: integer);
begin
  FendValue := Value;
end;

procedure TjdxBarGauge.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
end;

procedure TjdxBarGauge.Set_geometry(const Value: TJSObject);
begin
  Fgeometry := Value;
end;

procedure TjdxBarGauge.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxBarGauge.Set_label_(const Value: TJSObject);
begin
  Flabel_ := Value;
end;

procedure TjdxBarGauge.Set_legend(const Value: TJSObject);
begin
  Flegend := Value;
end;

procedure TjdxBarGauge.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
end;

procedure TjdxBarGauge.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
end;

procedure TjdxBarGauge.Set_palette(const Value: JSValue);
begin
  Fpalette := Value;
end;

procedure TjdxBarGauge.Set_paletteExtensionMode(const Value: JSValue);
begin
  FpaletteExtensionMode := Value;
end;

procedure TjdxBarGauge.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
end;

procedure TjdxBarGauge.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
end;

procedure TjdxBarGauge.Set_relativeInnerRadius(const Value: integer);
begin
  FrelativeInnerRadius := Value;
end;

procedure TjdxBarGauge.Set_resolveLabelOverlapping(const Value: JSValue);
begin
  FresolveLabelOverlapping := Value;
end;

procedure TjdxBarGauge.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxBarGauge.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
end;

procedure TjdxBarGauge.Set_startValue(const Value: integer);
begin
  FstartValue := Value;
end;

procedure TjdxBarGauge.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
end;

procedure TjdxBarGauge.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
end;

procedure TjdxBarGauge.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
end;

procedure TjdxBarGauge.Set_values(const Value: TJSArray);
begin
  Fvalues := Value;
end;

procedure TjdxBarGauge.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxBarGauge.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxBarGauge.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
end;

procedure TjdxBarGauge.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
end;

procedure TjdxBarGauge.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
end;

procedure TjdxBarGauge.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
end;

procedure TjdxBarGauge.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
end;

procedure TjdxBarGauge.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxBarGauge.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxBarGauge.Set_onTooltipHidden(const Value: TdxEventHandler);
begin
  FonTooltipHidden := Value;
end;

procedure TjdxBarGauge.Set_onTooltipShown(const Value: TdxEventHandler);
begin
  FonTooltipShown := Value;
end;

end.
