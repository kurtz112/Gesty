unit DevExtreme.PolarChart;

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
  TjdxPolarChart = class(TjdxCustomControl)
  private
    FadaptiveLayout: TJSObject;
    Fanimation: TJSObject;
    Fannotations: TJSArray;
    FargumentAxis: TJSObject;
    FbarGroupPadding: integer;
    FbarGroupWidth: integer;
    FcommonAnnotationSettings: TJSObject;
    FcommonAxisSettings: TJSObject;
    FcommonSeriesSettings: TJSObject;
    FcontainerBackgroundColor: string;
    FcustomizeAnnotation: TJSFunction;
    FcustomizeLabel: TJSFunction;
    FcustomizePoint: TJSFunction;
    FdataPrepareSettings: TJSObject;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    Fheight_: JSValue;
    Flegend: TJSObject;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    FnegativesAsZeroes: boolean;
    Fpalette: JSValue;
    FpaletteExtensionMode: JSValue;
    FpathModified: boolean;
    FpointSelectionMode: TdxSingleOrMultiple;
    FredrawOnResize: boolean;
    FresolveLabelOverlapping: JSValue;
    FrtlEnabled: boolean;
    Fseries: JSValue;
    FseriesSelectionMode: TdxSingleOrMultiple;
    FseriesTemplate: TJSObject;
    Fsize: TJSObject;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    FuseSpiderWeb: boolean;
    FvalueAxis: TJSObject;
    Fwidth_: JSValue;
  private
    FonArgumentAxisClick: TdxEventHandler;
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
    FonSeriesClick: TdxEventHandler;
    FonSeriesHoverChanged: TdxEventHandler;
    FonSeriesSelectionChanged: TdxEventHandler;
    FonTooltipHidden: TdxEventHandler;
    FonTooltipShown: TdxEventHandler;
    FonZoomEnd: TdxEventHandler;
    FonZoomStart: TdxEventHandler;
  private
    procedure Set_adaptiveLayout(const value: TJSObject);
    procedure Set_animation(const value: TJSObject);
    procedure Set_annotations(const value: TJSArray);
    procedure Set_argumentAxis(const value: TJSObject);
    procedure Set_barGroupPadding(const value: integer);
    procedure Set_barGroupWidth(const value: integer);
    procedure Set_commonAnnotationSettings(const value: TJSObject);
    procedure Set_commonAxisSettings(const value: TJSObject);
    procedure Set_commonSeriesSettings(const value: TJSObject);
    procedure Set_containerBackgroundColor(const value: string);
    procedure Set_customizeAnnotation(const value: TJSFunction);
    procedure Set_customizeLabel(const value: TJSFunction);
    procedure Set_customizePoint(const value: TJSFunction);
    procedure Set_dataPrepareSettings(const value: TJSObject);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_legend(const value: TJSObject);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_negativesAsZeroes(const value: boolean);
    procedure Set_palette(const value: JSValue);
    procedure Set_paletteExtensionMode(const value: JSValue);
    procedure Set_pathModified(const value: boolean);
    procedure Set_pointSelectionMode(const value: TdxSingleOrMultiple);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_resolveLabelOverlapping(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_series(const value: JSValue);
    procedure Set_seriesSelectionMode(const value: TdxSingleOrMultiple);
    procedure Set_seriesTemplate(const value: TJSObject);
    procedure Set_size(const value: TJSObject);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_useSpiderWeb(const value: boolean);
    procedure Set_valueAxis(const value: TJSObject);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onArgumentAxisClick(const value: TdxEventHandler);
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
    procedure Set_onSeriesClick(const value: TdxEventHandler);
    procedure Set_onSeriesHoverChanged(const value: TdxEventHandler);
    procedure Set_onSeriesSelectionChanged(const value: TdxEventHandler);
    procedure Set_onTooltipHidden(const value: TdxEventHandler);
    procedure Set_onTooltipShown(const value: TdxEventHandler);
    procedure Set_onZoomEnd(const value: TdxEventHandler);
    procedure Set_onZoomStart(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property adaptiveLayout: TJSObject read FadaptiveLayout write Set_adaptiveLayout;
    property animation: TJSObject read Fanimation write Set_animation;
    property annotations: TJSArray read Fannotations write Set_annotations;
    property argumentAxis: TJSObject read FargumentAxis write Set_argumentAxis;
    property commonAnnotationSettings: TJSObject read FcommonAnnotationSettings write Set_commonAnnotationSettings;
    property commonAxisSettings: TJSObject read FcommonAxisSettings write Set_commonAxisSettings;
    property commonSeriesSettings: TJSObject read FcommonSeriesSettings write Set_commonSeriesSettings;
    property customizeAnnotation: TJSFunction read FcustomizeAnnotation write Set_customizeAnnotation;
    property customizeLabel: TJSFunction read FcustomizeLabel write Set_customizeLabel;
    property customizePoint: TJSFunction read FcustomizePoint write Set_customizePoint;
    property dataPrepareSettings: TJSObject read FdataPrepareSettings write Set_dataPrepareSettings;
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
    property valueAxis: TJSObject read FvalueAxis write Set_valueAxis;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property barGroupPadding: integer read FbarGroupPadding write Set_barGroupPadding;
    property barGroupWidth: integer read FbarGroupWidth write Set_barGroupWidth;
    property containerBackgroundColor: string read FcontainerBackgroundColor write Set_containerBackgroundColor;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property negativesAsZeroes: boolean read FnegativesAsZeroes write Set_negativesAsZeroes default false;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property pointSelectionMode: TdxSingleOrMultiple read FpointSelectionMode write Set_pointSelectionMode default somSingle;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property seriesSelectionMode: TdxSingleOrMultiple read FseriesSelectionMode write Set_seriesSelectionMode default somSingle;
    property useSpiderWeb: boolean read FuseSpiderWeb write Set_useSpiderWeb default false;
  published
    property onArgumentAxisClick: TdxEventHandler read FonArgumentAxisClick write Set_onArgumentAxisClick;
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
    property onSeriesClick: TdxEventHandler read FonSeriesClick write Set_onSeriesClick;
    property onSeriesHoverChanged: TdxEventHandler read FonSeriesHoverChanged write Set_onSeriesHoverChanged;
    property onSeriesSelectionChanged: TdxEventHandler read FonSeriesSelectionChanged write Set_onSeriesSelectionChanged;
    property onTooltipHidden: TdxEventHandler read FonTooltipHidden write Set_onTooltipHidden;
    property onTooltipShown: TdxEventHandler read FonTooltipShown write Set_onTooltipShown;
    property onZoomEnd: TdxEventHandler read FonZoomEnd write Set_onZoomEnd;
    property onZoomStart: TdxEventHandler read FonZoomStart write Set_onZoomStart;
  end;

implementation


constructor TjdxPolarChart.Create(aOwner: TComponent);
begin
  inherited;
  FadaptiveLayout := TJSObject.new;
  Fanimation := TJSObject.new;
  Fannotations := TJSArray.new;
  FargumentAxis := TJSObject.new;
  FbarGroupPadding := 0;
  FbarGroupWidth := 0;
  FcommonAnnotationSettings := TJSObject.new;
  FcommonAxisSettings := TJSObject.new;
  FcommonSeriesSettings := TJSObject.new;
  FcontainerBackgroundColor := '';
  FcustomizeAnnotation := nil;
  FcustomizeLabel := nil;
  FcustomizePoint := nil;
  FdataPrepareSettings := TJSObject.new;
  FdataSource := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  Fheight_ := nil;
  Flegend := TJSObject.new;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  FnegativesAsZeroes := false;
  Fpalette := nil;
  FpaletteExtensionMode := nil;
  FpathModified := false;
  FpointSelectionMode := somSingle;
  FredrawOnResize := true;
  FresolveLabelOverlapping := nil;
  FrtlEnabled := false;
  Fseries := nil;
  FseriesSelectionMode := somSingle;
  FseriesTemplate := TJSObject.new;
  Fsize := TJSObject.new;
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  FuseSpiderWeb := false;
  FvalueAxis := TJSObject.new;
  Fwidth_ := nil;

  FonArgumentAxisClick := nil;
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
  FonSeriesClick := nil;
  FonSeriesHoverChanged := nil;
  FonSeriesSelectionChanged := nil;
  FonTooltipHidden := nil;
  FonTooltipShown := nil;
  FonZoomEnd := nil;
  FonZoomStart := nil;
end;

procedure TjdxPolarChart.Set_adaptiveLayout(const Value: TJSObject);
begin
  FadaptiveLayout := Value;
end;

procedure TjdxPolarChart.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
end;

procedure TjdxPolarChart.Set_annotations(const Value: TJSArray);
begin
  Fannotations := Value;
end;

procedure TjdxPolarChart.Set_argumentAxis(const Value: TJSObject);
begin
  FargumentAxis := Value;
end;

procedure TjdxPolarChart.Set_barGroupPadding(const Value: integer);
begin
  FbarGroupPadding := Value;
end;

procedure TjdxPolarChart.Set_barGroupWidth(const Value: integer);
begin
  FbarGroupWidth := Value;
end;

procedure TjdxPolarChart.Set_commonAnnotationSettings(const Value: TJSObject);
begin
  FcommonAnnotationSettings := Value;
end;

procedure TjdxPolarChart.Set_commonAxisSettings(const Value: TJSObject);
begin
  FcommonAxisSettings := Value;
end;

procedure TjdxPolarChart.Set_commonSeriesSettings(const Value: TJSObject);
begin
  FcommonSeriesSettings := Value;
end;

procedure TjdxPolarChart.Set_containerBackgroundColor(const Value: string);
begin
  FcontainerBackgroundColor := Value;
end;

procedure TjdxPolarChart.Set_customizeAnnotation(const Value: TJSFunction);
begin
  FcustomizeAnnotation := Value;
end;

procedure TjdxPolarChart.Set_customizeLabel(const Value: TJSFunction);
begin
  FcustomizeLabel := Value;
end;

procedure TjdxPolarChart.Set_customizePoint(const Value: TJSFunction);
begin
  FcustomizePoint := Value;
end;

procedure TjdxPolarChart.Set_dataPrepareSettings(const Value: TJSObject);
begin
  FdataPrepareSettings := Value;
end;

procedure TjdxPolarChart.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxPolarChart.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxPolarChart.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxPolarChart.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
end;

procedure TjdxPolarChart.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxPolarChart.Set_legend(const Value: TJSObject);
begin
  Flegend := Value;
end;

procedure TjdxPolarChart.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
end;

procedure TjdxPolarChart.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
end;

procedure TjdxPolarChart.Set_negativesAsZeroes(const Value: boolean);
begin
  FnegativesAsZeroes := Value;
end;

procedure TjdxPolarChart.Set_palette(const Value: JSValue);
begin
  Fpalette := Value;
end;

procedure TjdxPolarChart.Set_paletteExtensionMode(const Value: JSValue);
begin
  FpaletteExtensionMode := Value;
end;

procedure TjdxPolarChart.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
end;

procedure TjdxPolarChart.Set_pointSelectionMode(const Value: TdxSingleOrMultiple);
begin
  FpointSelectionMode := Value;
end;

procedure TjdxPolarChart.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
end;

procedure TjdxPolarChart.Set_resolveLabelOverlapping(const Value: JSValue);
begin
  FresolveLabelOverlapping := Value;
end;

procedure TjdxPolarChart.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxPolarChart.Set_series(const Value: JSValue);
begin
  Fseries := Value;
end;

procedure TjdxPolarChart.Set_seriesSelectionMode(const Value: TdxSingleOrMultiple);
begin
  FseriesSelectionMode := Value;
end;

procedure TjdxPolarChart.Set_seriesTemplate(const Value: TJSObject);
begin
  FseriesTemplate := Value;
end;

procedure TjdxPolarChart.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
end;

procedure TjdxPolarChart.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
end;

procedure TjdxPolarChart.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
end;

procedure TjdxPolarChart.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
end;

procedure TjdxPolarChart.Set_useSpiderWeb(const Value: boolean);
begin
  FuseSpiderWeb := Value;
end;

procedure TjdxPolarChart.Set_valueAxis(const Value: TJSObject);
begin
  FvalueAxis := Value;
end;

procedure TjdxPolarChart.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxPolarChart.Set_onArgumentAxisClick(const Value: TdxEventHandler);
begin
  FonArgumentAxisClick := Value;
end;

procedure TjdxPolarChart.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxPolarChart.Set_onDone(const Value: TdxEventHandler);
begin
  FonDone := Value;
end;

procedure TjdxPolarChart.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
end;

procedure TjdxPolarChart.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
end;

procedure TjdxPolarChart.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
end;

procedure TjdxPolarChart.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
end;

procedure TjdxPolarChart.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
end;

procedure TjdxPolarChart.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxPolarChart.Set_onLegendClick(const Value: TdxEventHandler);
begin
  FonLegendClick := Value;
end;

procedure TjdxPolarChart.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxPolarChart.Set_onPointClick(const Value: TdxEventHandler);
begin
  FonPointClick := Value;
end;

procedure TjdxPolarChart.Set_onPointHoverChanged(const Value: TdxEventHandler);
begin
  FonPointHoverChanged := Value;
end;

procedure TjdxPolarChart.Set_onPointSelectionChanged(const Value: TdxEventHandler);
begin
  FonPointSelectionChanged := Value;
end;

procedure TjdxPolarChart.Set_onSeriesClick(const Value: TdxEventHandler);
begin
  FonSeriesClick := Value;
end;

procedure TjdxPolarChart.Set_onSeriesHoverChanged(const Value: TdxEventHandler);
begin
  FonSeriesHoverChanged := Value;
end;

procedure TjdxPolarChart.Set_onSeriesSelectionChanged(const Value: TdxEventHandler);
begin
  FonSeriesSelectionChanged := Value;
end;

procedure TjdxPolarChart.Set_onTooltipHidden(const Value: TdxEventHandler);
begin
  FonTooltipHidden := Value;
end;

procedure TjdxPolarChart.Set_onTooltipShown(const Value: TdxEventHandler);
begin
  FonTooltipShown := Value;
end;

procedure TjdxPolarChart.Set_onZoomEnd(const Value: TdxEventHandler);
begin
  FonZoomEnd := Value;
end;

procedure TjdxPolarChart.Set_onZoomStart(const Value: TdxEventHandler);
begin
  FonZoomStart := Value;
end;

end.
