unit DevExtreme.PieChart;

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
  TjdxPieChart = class(TjdxCustomControl)
  private
    FadaptiveLayout: TJSObject;
    Fanimation: TJSObject;
    Fannotations: TJSArray;
    FcenterTemplate: JSValue;
    FcommonAnnotationSettings: TJSObject;
    FcommonSeriesSettings: TJSObject;
    FcustomizeAnnotation: TJSFunction;
    FcustomizeLabel: TJSFunction;
    FcustomizePoint: TJSFunction;
    FdataSource: JSValue;
    Fdiameter: integer;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    Fheight_: JSValue;
    FinnerRadius: integer;
    Flegend: TJSObject;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    FminDiameter: integer;
    Fpalette: JSValue;
    FpaletteExtensionMode: JSValue;
    FpathModified: boolean;
    FpointSelectionMode: TdxSingleOrMultiple;
    FredrawOnResize: boolean;
    FresolveLabelOverlapping: JSValue;
    FrtlEnabled: boolean;
    FsegmentsDirection: TdxPieChartSegmentDirection;
    Fseries: JSValue;
    FseriesTemplate: TJSObject;
    Fsize: TJSObject;
    FsizeGroup: string;
    FstartAngle: integer;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    Ftype_: TdxPieChartType;
    Fwidth_: JSValue;
  private
    FonDisposing: TdxEventHandler;
    FonDone: TdxEventHandler;
    FonDrawn: TdxEventHandler;
    FonExported: TdxEventHandler;
    FonExporting: TdxEventHandler;
    FonFileSaving: TdxEventHandler;
    FonIncidentOccurred: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonLegendClick: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonPointClick: TdxEventHandler;
    FonPointHoverChanged: TdxEventHandler;
    FonPointSelectionChanged: TdxEventHandler;
    FonTooltipHidden: TdxEventHandler;
    FonTooltipShown: TdxEventHandler;
  private
    procedure Set_adaptiveLayout(const value: TJSObject);
    procedure Set_animation(const value: TJSObject);
    procedure Set_annotations(const value: TJSArray);
    procedure Set_centerTemplate(const value: JSValue);
    procedure Set_commonAnnotationSettings(const value: TJSObject);
    procedure Set_commonSeriesSettings(const value: TJSObject);
    procedure Set_customizeAnnotation(const value: TJSFunction);
    procedure Set_customizeLabel(const value: TJSFunction);
    procedure Set_customizePoint(const value: TJSFunction);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_diameter(const value: integer);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_innerRadius(const value: integer);
    procedure Set_legend(const value: TJSObject);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_minDiameter(const value: integer);
    procedure Set_palette(const value: JSValue);
    procedure Set_paletteExtensionMode(const value: JSValue);
    procedure Set_pathModified(const value: boolean);
    procedure Set_pointSelectionMode(const value: TdxSingleOrMultiple);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_resolveLabelOverlapping(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_segmentsDirection(const value: TdxPieChartSegmentDirection);
    procedure Set_series(const value: JSValue);
    procedure Set_seriesTemplate(const value: TJSObject);
    procedure Set_size(const value: TJSObject);
    procedure Set_sizeGroup(const value: string);
    procedure Set_startAngle(const value: integer);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_type_(const value: TdxPieChartType);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onDone(const value: TdxEventHandler);
    procedure Set_onDrawn(const value: TdxEventHandler);
    procedure Set_onExported(const value: TdxEventHandler);
    procedure Set_onExporting(const value: TdxEventHandler);
    procedure Set_onFileSaving(const value: TdxEventHandler);
    procedure Set_onIncidentOccurred(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onLegendClick(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onPointClick(const value: TdxEventHandler);
    procedure Set_onPointHoverChanged(const value: TdxEventHandler);
    procedure Set_onPointSelectionChanged(const value: TdxEventHandler);
    procedure Set_onTooltipHidden(const value: TdxEventHandler);
    procedure Set_onTooltipShown(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property adaptiveLayout: TJSObject read FadaptiveLayout write Set_adaptiveLayout;
    property animation: TJSObject read Fanimation write Set_animation;
    property annotations: TJSArray read Fannotations write Set_annotations;
    property centerTemplate: JSValue read FcenterTemplate write Set_centerTemplate;
    property commonAnnotationSettings: TJSObject read FcommonAnnotationSettings write Set_commonAnnotationSettings;
    property commonSeriesSettings: TJSObject read FcommonSeriesSettings write Set_commonSeriesSettings;
    property customizeAnnotation: TJSFunction read FcustomizeAnnotation write Set_customizeAnnotation;
    property customizeLabel: TJSFunction read FcustomizeLabel write Set_customizeLabel;
    property customizePoint: TJSFunction read FcustomizePoint write Set_customizePoint;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property height_: JSValue read Fheight_ write Set_height_;
    property legend: TJSObject read Flegend write Set_legend;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property palette: JSValue read Fpalette write Set_palette;
    property paletteExtensionMode: JSValue read FpaletteExtensionMode write Set_paletteExtensionMode;
    property resolveLabelOverlapping: JSValue read FresolveLabelOverlapping write Set_resolveLabelOverlapping;
    property series: JSValue read Fseries write Set_series;
    property seriesTemplate: TJSObject read FseriesTemplate write Set_seriesTemplate;
    property size: TJSObject read Fsize write Set_size;
    property theme: JSValue read Ftheme write Set_theme;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property diameter: integer read Fdiameter write Set_diameter;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property innerRadius: integer read FinnerRadius write Set_innerRadius;
    property minDiameter: integer read FminDiameter write Set_minDiameter;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property pointSelectionMode: TdxSingleOrMultiple read FpointSelectionMode write Set_pointSelectionMode default somSingle;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property segmentsDirection: TdxPieChartSegmentDirection read FsegmentsDirection write Set_segmentsDirection default pcsdClockwise;
    property sizeGroup: string read FsizeGroup write Set_sizeGroup;
    property startAngle: integer read FstartAngle write Set_startAngle;
    property type_: TdxPieChartType read Ftype_ write Set_type_ default pctPie;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onDone: TdxEventHandler read FonDone write Set_onDone;
    property onDrawn: TdxEventHandler read FonDrawn write Set_onDrawn;
    property onExported: TdxEventHandler read FonExported write Set_onExported;
    property onExporting: TdxEventHandler read FonExporting write Set_onExporting;
    property onFileSaving: TdxEventHandler read FonFileSaving write Set_onFileSaving;
    property onIncidentOccurred: TdxEventHandler read FonIncidentOccurred write Set_onIncidentOccurred;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onLegendClick: TdxEventHandler read FonLegendClick write Set_onLegendClick;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onPointClick: TdxEventHandler read FonPointClick write Set_onPointClick;
    property onPointHoverChanged: TdxEventHandler read FonPointHoverChanged write Set_onPointHoverChanged;
    property onPointSelectionChanged: TdxEventHandler read FonPointSelectionChanged write Set_onPointSelectionChanged;
    property onTooltipHidden: TdxEventHandler read FonTooltipHidden write Set_onTooltipHidden;
    property onTooltipShown: TdxEventHandler read FonTooltipShown write Set_onTooltipShown;
  end;

implementation


constructor TjdxPieChart.Create(aOwner: TComponent);
begin
  inherited;
  FadaptiveLayout := TJSObject.new;
  Fanimation := TJSObject.new;
  Fannotations := TJSArray.new;
  FcenterTemplate := nil;
  FcommonAnnotationSettings := TJSObject.new;
  FcommonSeriesSettings := TJSObject.new;
  FcustomizeAnnotation := nil;
  FcustomizeLabel := nil;
  FcustomizePoint := nil;
  FdataSource := nil;
  Fdiameter := 0;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  Fheight_ := nil;
  FinnerRadius := 0;
  Flegend := TJSObject.new;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  FminDiameter := 0;
  Fpalette := nil;
  FpaletteExtensionMode := nil;
  FpathModified := false;
  FpointSelectionMode := somSingle;
  FredrawOnResize := true;
  FresolveLabelOverlapping := nil;
  FrtlEnabled := false;
  FsegmentsDirection := pcsdClockwise;
  Fseries := nil;
  FseriesTemplate := TJSObject.new;
  Fsize := TJSObject.new;
  FsizeGroup := '';
  FstartAngle := 0;
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  Ftype_ := pctPie;
  Fwidth_ := nil;

  FonDisposing := nil;
  FonDone := nil;
  FonDrawn := nil;
  FonExported := nil;
  FonExporting := nil;
  FonFileSaving := nil;
  FonIncidentOccurred := nil;
  FonInitialized := nil;
  FonLegendClick := nil;
  FonOptionChanged := nil;
  FonPointClick := nil;
  FonPointHoverChanged := nil;
  FonPointSelectionChanged := nil;
  FonTooltipHidden := nil;
  FonTooltipShown := nil;
end;

procedure TjdxPieChart.Set_adaptiveLayout(const Value: TJSObject);
begin
  FadaptiveLayout := Value;
end;

procedure TjdxPieChart.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
end;

procedure TjdxPieChart.Set_annotations(const Value: TJSArray);
begin
  Fannotations := Value;
end;

procedure TjdxPieChart.Set_centerTemplate(const Value: JSValue);
begin
  FcenterTemplate := Value;
end;

procedure TjdxPieChart.Set_commonAnnotationSettings(const Value: TJSObject);
begin
  FcommonAnnotationSettings := Value;
end;

procedure TjdxPieChart.Set_commonSeriesSettings(const Value: TJSObject);
begin
  FcommonSeriesSettings := Value;
end;

procedure TjdxPieChart.Set_customizeAnnotation(const Value: TJSFunction);
begin
  FcustomizeAnnotation := Value;
end;

procedure TjdxPieChart.Set_customizeLabel(const Value: TJSFunction);
begin
  FcustomizeLabel := Value;
end;

procedure TjdxPieChart.Set_customizePoint(const Value: TJSFunction);
begin
  FcustomizePoint := Value;
end;

procedure TjdxPieChart.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxPieChart.Set_diameter(const Value: integer);
begin
  Fdiameter := Value;
end;

procedure TjdxPieChart.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxPieChart.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxPieChart.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
end;

procedure TjdxPieChart.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxPieChart.Set_innerRadius(const Value: integer);
begin
  FinnerRadius := Value;
end;

procedure TjdxPieChart.Set_legend(const Value: TJSObject);
begin
  Flegend := Value;
end;

procedure TjdxPieChart.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
end;

procedure TjdxPieChart.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
end;

procedure TjdxPieChart.Set_minDiameter(const Value: integer);
begin
  FminDiameter := Value;
end;

procedure TjdxPieChart.Set_palette(const Value: JSValue);
begin
  Fpalette := Value;
end;

procedure TjdxPieChart.Set_paletteExtensionMode(const Value: JSValue);
begin
  FpaletteExtensionMode := Value;
end;

procedure TjdxPieChart.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
end;

procedure TjdxPieChart.Set_pointSelectionMode(const Value: TdxSingleOrMultiple);
begin
  FpointSelectionMode := Value;
end;

procedure TjdxPieChart.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
end;

procedure TjdxPieChart.Set_resolveLabelOverlapping(const Value: JSValue);
begin
  FresolveLabelOverlapping := Value;
end;

procedure TjdxPieChart.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxPieChart.Set_segmentsDirection(const Value: TdxPieChartSegmentDirection);
begin
  FsegmentsDirection := Value;
end;

procedure TjdxPieChart.Set_series(const Value: JSValue);
begin
  Fseries := Value;
end;

procedure TjdxPieChart.Set_seriesTemplate(const Value: TJSObject);
begin
  FseriesTemplate := Value;
end;

procedure TjdxPieChart.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
end;

procedure TjdxPieChart.Set_sizeGroup(const Value: string);
begin
  FsizeGroup := Value;
end;

procedure TjdxPieChart.Set_startAngle(const Value: integer);
begin
  FstartAngle := Value;
end;

procedure TjdxPieChart.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
end;

procedure TjdxPieChart.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
end;

procedure TjdxPieChart.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
end;

procedure TjdxPieChart.Set_type_(const Value: TdxPieChartType);
begin
  Ftype_ := Value;
end;

procedure TjdxPieChart.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxPieChart.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxPieChart.Set_onDone(const Value: TdxEventHandler);
begin
  FonDone := Value;
end;

procedure TjdxPieChart.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
end;

procedure TjdxPieChart.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
end;

procedure TjdxPieChart.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
end;

procedure TjdxPieChart.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
end;

procedure TjdxPieChart.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
end;

procedure TjdxPieChart.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxPieChart.Set_onLegendClick(const Value: TdxEventHandler);
begin
  FonLegendClick := Value;
end;

procedure TjdxPieChart.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxPieChart.Set_onPointClick(const Value: TdxEventHandler);
begin
  FonPointClick := Value;
end;

procedure TjdxPieChart.Set_onPointHoverChanged(const Value: TdxEventHandler);
begin
  FonPointHoverChanged := Value;
end;

procedure TjdxPieChart.Set_onPointSelectionChanged(const Value: TdxEventHandler);
begin
  FonPointSelectionChanged := Value;
end;

procedure TjdxPieChart.Set_onTooltipHidden(const Value: TdxEventHandler);
begin
  FonTooltipHidden := Value;
end;

procedure TjdxPieChart.Set_onTooltipShown(const Value: TdxEventHandler);
begin
  FonTooltipShown := Value;
end;

end.
