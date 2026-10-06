unit DevExtreme.Chart;

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
  TjdxChart = class(TjdxCustomControl)
  private
    FadaptiveLayout: TJSObject;
    FadjustOnZoom: boolean;
    Fanimation: TJSObject;
    Fannotations: TJSArray;
    FargumentAxis: TJSObject;
    FautoHidePointMarkers: boolean;
    FbarGroupPadding: integer;
    FbarGroupWidth: integer;
    FcommonAnnotationSettings: TJSObject;
    FcommonAxisSettings: TJSObject;
    FcommonPaneSettings: TJSObject;
    FcommonSeriesSettings: TJSObject;
    FcontainerBackgroundColor: string;
    Fcrosshair: TJSObject;
    FcustomizeAnnotation: TJSFunction;
    FcustomizeLabel: TJSFunction;
    FcustomizePoint: TJSFunction;
    FdataPrepareSettings: TJSObject;
    FdataSource: JSValue;
    FdefaultPane: string;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    Fheight_: JSValue;
    Flegend: TJSObject;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    FmaxBubbleSize: integer;
    FminBubbleSize: integer;
    FnegativesAsZeroes: boolean;
    Fpalette: JSValue;
    FpaletteExtensionMode: JSValue;
    Fpanes: TJSArray;
    FpathModified: boolean;
    FpointSelectionMode: TdxSingleOrMultiple;
    FredrawOnResize: boolean;
    FresizePanesOnZoom: boolean;
    FresolveLabelOverlapping: JSValue;
    Frotated: boolean;
    FrtlEnabled: boolean;
    FscrollBar: TJSObject;
    Fseries: JSValue;
    FseriesSelectionMode: TdxSingleOrMultiple;
    FseriesTemplate: TJSObject;
    Fsize: TJSObject;
    FstickyHovering: boolean;
    FsynchronizeMultiAxes: boolean;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    FvalueAxis: TJSArray;
    Fwidth_: JSValue;
    FzoomAndPan: TJSObject;
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
    procedure Set_adjustOnZoom(const value: boolean);
    procedure Set_animation(const value: TJSObject);
    procedure Set_annotations(const value: TJSArray);
    procedure Set_argumentAxis(const value: TJSObject);
    procedure Set_autoHidePointMarkers(const value: boolean);
    procedure Set_barGroupPadding(const value: integer);
    procedure Set_barGroupWidth(const value: integer);
    procedure Set_commonAnnotationSettings(const value: TJSObject);
    procedure Set_commonAxisSettings(const value: TJSObject);
    procedure Set_commonPaneSettings(const value: TJSObject);
    procedure Set_commonSeriesSettings(const value: TJSObject);
    procedure Set_containerBackgroundColor(const value: string);
    procedure Set_crosshair(const value: TJSObject);
    procedure Set_customizeAnnotation(const value: TJSFunction);
    procedure Set_customizeLabel(const value: TJSFunction);
    procedure Set_customizePoint(const value: TJSFunction);
    procedure Set_dataPrepareSettings(const value: TJSObject);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_defaultPane(const value: string);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_legend(const value: TJSObject);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_maxBubbleSize(const value: integer);
    procedure Set_minBubbleSize(const value: integer);
    procedure Set_negativesAsZeroes(const value: boolean);
    procedure Set_palette(const value: JSValue);
    procedure Set_paletteExtensionMode(const value: JSValue);
    procedure Set_panes(const value: TJSArray);
    procedure Set_pathModified(const value: boolean);
    procedure Set_pointSelectionMode(const value: TdxSingleOrMultiple);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_resizePanesOnZoom(const value: boolean);
    procedure Set_resolveLabelOverlapping(const value: JSValue);
    procedure Set_rotated(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scrollBar(const value: TJSObject);
    procedure Set_series(const value: JSValue);
    procedure Set_seriesSelectionMode(const value: TdxSingleOrMultiple);
    procedure Set_seriesTemplate(const value: TJSObject);
    procedure Set_size(const value: TJSObject);
    procedure Set_stickyHovering(const value: boolean);
    procedure Set_synchronizeMultiAxes(const value: boolean);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_valueAxis(const value: TJSArray);
    procedure Set_width_(const value: JSValue);
    procedure Set_zoomAndPan(const value: TJSObject);
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
    property commonPaneSettings: TJSObject read FcommonPaneSettings write Set_commonPaneSettings;
    property commonSeriesSettings: TJSObject read FcommonSeriesSettings write Set_commonSeriesSettings;
    property crosshair: TJSObject read Fcrosshair write Set_crosshair;
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
    property panes: TJSArray read Fpanes write Set_panes;
    property resolveLabelOverlapping: JSValue read FresolveLabelOverlapping write Set_resolveLabelOverlapping;
    property scrollBar: TJSObject read FscrollBar write Set_scrollBar;
    property series: JSValue read Fseries write Set_series;
    property seriesTemplate: TJSObject read FseriesTemplate write Set_seriesTemplate;
    property size: TJSObject read Fsize write Set_size;
    property theme: JSValue read Ftheme write Set_theme;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property valueAxis: TJSArray read FvalueAxis write Set_valueAxis;
    property width_: JSValue read Fwidth_ write Set_width_;
    property zoomAndPan: TJSObject read FzoomAndPan write Set_zoomAndPan;
  published
    property adjustOnZoom: boolean read FadjustOnZoom write Set_adjustOnZoom default true;
    property autoHidePointMarkers: boolean read FautoHidePointMarkers write Set_autoHidePointMarkers default true;
    property barGroupPadding: integer read FbarGroupPadding write Set_barGroupPadding;
    property barGroupWidth: integer read FbarGroupWidth write Set_barGroupWidth;
    property containerBackgroundColor: string read FcontainerBackgroundColor write Set_containerBackgroundColor;
    property defaultPane: string read FdefaultPane write Set_defaultPane;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property maxBubbleSize: integer read FmaxBubbleSize write Set_maxBubbleSize;
    property minBubbleSize: integer read FminBubbleSize write Set_minBubbleSize;
    property negativesAsZeroes: boolean read FnegativesAsZeroes write Set_negativesAsZeroes default false;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property pointSelectionMode: TdxSingleOrMultiple read FpointSelectionMode write Set_pointSelectionMode default somSingle;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property resizePanesOnZoom: boolean read FresizePanesOnZoom write Set_resizePanesOnZoom default false;
    property rotated: boolean read Frotated write Set_rotated default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property seriesSelectionMode: TdxSingleOrMultiple read FseriesSelectionMode write Set_seriesSelectionMode default somSingle;
    property stickyHovering: boolean read FstickyHovering write Set_stickyHovering default true;
    property synchronizeMultiAxes: boolean read FsynchronizeMultiAxes write Set_synchronizeMultiAxes default true;
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


constructor TjdxChart.Create(aOwner: TComponent);
begin
  inherited;
  FadaptiveLayout := TJSObject.new;
  FadjustOnZoom := true;
  Fanimation := TJSObject.new;
  Fannotations := TJSArray.new;
  FargumentAxis := TJSObject.new;
  FautoHidePointMarkers := true;
  FbarGroupPadding := 0;
  FbarGroupWidth := 0;
  FcommonAnnotationSettings := TJSObject.new;
  FcommonAxisSettings := TJSObject.new;
  FcommonPaneSettings := TJSObject.new;
  FcommonSeriesSettings := TJSObject.new;
  FcontainerBackgroundColor := '';
  Fcrosshair := TJSObject.new;
  FcustomizeAnnotation := nil;
  FcustomizeLabel := nil;
  FcustomizePoint := nil;
  FdataPrepareSettings := TJSObject.new;
  FdataSource := nil;
  FdefaultPane := '';
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  Fheight_ := nil;
  Flegend := TJSObject.new;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  FmaxBubbleSize := 0;
  FminBubbleSize := 0;
  FnegativesAsZeroes := false;
  Fpalette := nil;
  FpaletteExtensionMode := nil;
  Fpanes := TJSArray.new;
  FpathModified := false;
  FpointSelectionMode := somSingle;
  FredrawOnResize := true;
  FresizePanesOnZoom := false;
  FresolveLabelOverlapping := nil;
  Frotated := false;
  FrtlEnabled := false;
  FscrollBar := TJSObject.new;
  Fseries := nil;
  FseriesSelectionMode := somSingle;
  FseriesTemplate := TJSObject.new;
  Fsize := TJSObject.new;
  FstickyHovering := true;
  FsynchronizeMultiAxes := true;
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  FvalueAxis := TJSArray.new;
  Fwidth_ := nil;
  FzoomAndPan := TJSObject.new;

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

procedure TjdxChart.Set_adaptiveLayout(const Value: TJSObject);
begin
  FadaptiveLayout := Value;
end;

procedure TjdxChart.Set_adjustOnZoom(const Value: boolean);
begin
  FadjustOnZoom := Value;
end;

procedure TjdxChart.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
end;

procedure TjdxChart.Set_annotations(const Value: TJSArray);
begin
  Fannotations := Value;
end;

procedure TjdxChart.Set_argumentAxis(const Value: TJSObject);
begin
  FargumentAxis := Value;
end;

procedure TjdxChart.Set_autoHidePointMarkers(const Value: boolean);
begin
  FautoHidePointMarkers := Value;
end;

procedure TjdxChart.Set_barGroupPadding(const Value: integer);
begin
  FbarGroupPadding := Value;
end;

procedure TjdxChart.Set_barGroupWidth(const Value: integer);
begin
  FbarGroupWidth := Value;
end;

procedure TjdxChart.Set_commonAnnotationSettings(const Value: TJSObject);
begin
  FcommonAnnotationSettings := Value;
end;

procedure TjdxChart.Set_commonAxisSettings(const Value: TJSObject);
begin
  FcommonAxisSettings := Value;
end;

procedure TjdxChart.Set_commonPaneSettings(const Value: TJSObject);
begin
  FcommonPaneSettings := Value;
end;

procedure TjdxChart.Set_commonSeriesSettings(const Value: TJSObject);
begin
  FcommonSeriesSettings := Value;
end;

procedure TjdxChart.Set_containerBackgroundColor(const Value: string);
begin
  FcontainerBackgroundColor := Value;
end;

procedure TjdxChart.Set_crosshair(const Value: TJSObject);
begin
  Fcrosshair := Value;
end;

procedure TjdxChart.Set_customizeAnnotation(const Value: TJSFunction);
begin
  FcustomizeAnnotation := Value;
end;

procedure TjdxChart.Set_customizeLabel(const Value: TJSFunction);
begin
  FcustomizeLabel := Value;
end;

procedure TjdxChart.Set_customizePoint(const Value: TJSFunction);
begin
  FcustomizePoint := Value;
end;

procedure TjdxChart.Set_dataPrepareSettings(const Value: TJSObject);
begin
  FdataPrepareSettings := Value;
end;

procedure TjdxChart.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxChart.Set_defaultPane(const Value: string);
begin
  FdefaultPane := Value;
end;

procedure TjdxChart.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxChart.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxChart.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
end;

procedure TjdxChart.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxChart.Set_legend(const Value: TJSObject);
begin
  Flegend := Value;
end;

procedure TjdxChart.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
end;

procedure TjdxChart.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
end;

procedure TjdxChart.Set_maxBubbleSize(const Value: integer);
begin
  FmaxBubbleSize := Value;
end;

procedure TjdxChart.Set_minBubbleSize(const Value: integer);
begin
  FminBubbleSize := Value;
end;

procedure TjdxChart.Set_negativesAsZeroes(const Value: boolean);
begin
  FnegativesAsZeroes := Value;
end;

procedure TjdxChart.Set_palette(const Value: JSValue);
begin
  Fpalette := Value;
end;

procedure TjdxChart.Set_paletteExtensionMode(const Value: JSValue);
begin
  FpaletteExtensionMode := Value;
end;

procedure TjdxChart.Set_panes(const Value: TJSArray);
begin
  Fpanes := Value;
end;

procedure TjdxChart.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
end;

procedure TjdxChart.Set_pointSelectionMode(const Value: TdxSingleOrMultiple);
begin
  FpointSelectionMode := Value;
end;

procedure TjdxChart.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
end;

procedure TjdxChart.Set_resizePanesOnZoom(const Value: boolean);
begin
  FresizePanesOnZoom := Value;
end;

procedure TjdxChart.Set_resolveLabelOverlapping(const Value: JSValue);
begin
  FresolveLabelOverlapping := Value;
end;

procedure TjdxChart.Set_rotated(const Value: boolean);
begin
  Frotated := Value;
end;

procedure TjdxChart.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxChart.Set_scrollBar(const Value: TJSObject);
begin
  FscrollBar := Value;
end;

procedure TjdxChart.Set_series(const Value: JSValue);
begin
  Fseries := Value;
end;

procedure TjdxChart.Set_seriesSelectionMode(const Value: TdxSingleOrMultiple);
begin
  FseriesSelectionMode := Value;
end;

procedure TjdxChart.Set_seriesTemplate(const Value: TJSObject);
begin
  FseriesTemplate := Value;
end;

procedure TjdxChart.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
end;

procedure TjdxChart.Set_stickyHovering(const Value: boolean);
begin
  FstickyHovering := Value;
end;

procedure TjdxChart.Set_synchronizeMultiAxes(const Value: boolean);
begin
  FsynchronizeMultiAxes := Value;
end;

procedure TjdxChart.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
end;

procedure TjdxChart.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
end;

procedure TjdxChart.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
end;

procedure TjdxChart.Set_valueAxis(const Value: TJSArray);
begin
  FvalueAxis := Value;
end;

procedure TjdxChart.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxChart.Set_zoomAndPan(const Value: TJSObject);
begin
  FzoomAndPan := Value;
end;

procedure TjdxChart.Set_onArgumentAxisClick(const Value: TdxEventHandler);
begin
  FonArgumentAxisClick := Value;
end;

procedure TjdxChart.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxChart.Set_onDone(const Value: TdxEventHandler);
begin
  FonDone := Value;
end;

procedure TjdxChart.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
end;

procedure TjdxChart.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
end;

procedure TjdxChart.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
end;

procedure TjdxChart.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
end;

procedure TjdxChart.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
end;

procedure TjdxChart.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxChart.Set_onLegendClick(const Value: TdxEventHandler);
begin
  FonLegendClick := Value;
end;

procedure TjdxChart.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxChart.Set_onPointClick(const Value: TdxEventHandler);
begin
  FonPointClick := Value;
end;

procedure TjdxChart.Set_onPointHoverChanged(const Value: TdxEventHandler);
begin
  FonPointHoverChanged := Value;
end;

procedure TjdxChart.Set_onPointSelectionChanged(const Value: TdxEventHandler);
begin
  FonPointSelectionChanged := Value;
end;

procedure TjdxChart.Set_onSeriesClick(const Value: TdxEventHandler);
begin
  FonSeriesClick := Value;
end;

procedure TjdxChart.Set_onSeriesHoverChanged(const Value: TdxEventHandler);
begin
  FonSeriesHoverChanged := Value;
end;

procedure TjdxChart.Set_onSeriesSelectionChanged(const Value: TdxEventHandler);
begin
  FonSeriesSelectionChanged := Value;
end;

procedure TjdxChart.Set_onTooltipHidden(const Value: TdxEventHandler);
begin
  FonTooltipHidden := Value;
end;

procedure TjdxChart.Set_onTooltipShown(const Value: TdxEventHandler);
begin
  FonTooltipShown := Value;
end;

procedure TjdxChart.Set_onZoomEnd(const Value: TdxEventHandler);
begin
  FonZoomEnd := Value;
end;

procedure TjdxChart.Set_onZoomStart(const Value: TdxEventHandler);
begin
  FonZoomStart := Value;
end;

end.
