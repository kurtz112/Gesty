unit DevExtreme.Chart.Custom;

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
  DevExtreme.Chart.JS,
  DevExtreme.Types;

type
  TjdxCustomChart = class(TjdxCustomControl)
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
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxChart; assembler;
    function instance: TdxChart; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure clearSelection(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler; overload;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure exportTo(fileName: string; format: string); assembler;
    function getAllSeries(): TJSArray; assembler;
    function getArgumentAxis(): JSValue; assembler;
    function getDataSource(): TJSObject; assembler;
    function getSeriesByName(seriesName: JSValue): JSValue; assembler;
    function getSeriesByPos(seriesIndex: integer): JSValue; assembler;
    function getSize(): JSValue; assembler;
    function getValueAxis(): JSValue; assembler; overload;
    function getValueAxis(name_: string): JSValue; assembler; overload;
    procedure hideLoadingIndicator(); assembler;
    procedure hideTooltip(); assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(): TJSObject; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure print(); assembler;
    procedure refresh(); assembler;
    procedure render(renderOptions: TJSObject); assembler; overload;
    procedure render(); assembler; overload;
    procedure resetOption(optionName: string); assembler;
    procedure resetVisualRange(); assembler;
    procedure showLoadingIndicator(); assembler;
    function svg(): string; assembler;
    procedure zoomArgument(startValue: JSValue; endValue: JSValue); assembler;
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


procedure TjdxCustomChart.CreateInitialize;
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
procedure TjdxCustomChart.InitJQuery;
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
      $(id).dxChart(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomChart.getInstance(element: TJSObject): TdxChart;
asm
  return DevExpress.viz.dxChart.getInstance(element);
end;

function TjdxCustomChart.instance: TdxChart;
asm
  return $(this.GetJQID()).dxChart("instance");
end;
procedure TjdxCustomChart.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('adaptiveLayout', adaptiveLayout);
    SetOption('adjustOnZoom', adjustOnZoom);
    SetOption('animation', animation);
    SetOption('annotations', annotations);
    SetOption('argumentAxis', argumentAxis);
    SetOption('autoHidePointMarkers', autoHidePointMarkers);
    SetOption('barGroupPadding', barGroupPadding);
    SetOption('barGroupWidth', barGroupWidth);
    SetOption('commonAnnotationSettings', commonAnnotationSettings);
    SetOption('commonAxisSettings', commonAxisSettings);
    SetOption('commonPaneSettings', commonPaneSettings);
    SetOption('commonSeriesSettings', commonSeriesSettings);
    SetOption('containerBackgroundColor', containerBackgroundColor);
    SetOption('crosshair', crosshair);
    SetOption('customizeAnnotation', customizeAnnotation);
    SetOption('customizeLabel', customizeLabel);
    SetOption('customizePoint', customizePoint);
    SetOption('dataPrepareSettings', dataPrepareSettings);
    SetOption('dataSource', dataSource);
    SetOption('defaultPane', defaultPane);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('export', export);
    SetOption('height', height_);
    SetOption('legend', legend);
    SetOption('loadingIndicator', loadingIndicator);
    SetOption('margin', margin);
    SetOption('maxBubbleSize', maxBubbleSize);
    SetOption('minBubbleSize', minBubbleSize);
    SetOption('negativesAsZeroes', negativesAsZeroes);
    SetOption('palette', palette);
    SetOption('paletteExtensionMode', paletteExtensionMode);
    SetOption('panes', panes);
    SetOption('pathModified', pathModified);
    SetOption('pointSelectionMode', pointSelectionMode.ToString());
    SetOption('redrawOnResize', redrawOnResize);
    SetOption('resizePanesOnZoom', resizePanesOnZoom);
    SetOption('resolveLabelOverlapping', resolveLabelOverlapping);
    SetOption('rotated', rotated);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('scrollBar', scrollBar);
    SetOption('series', series);
    SetOption('seriesSelectionMode', seriesSelectionMode.ToString());
    SetOption('seriesTemplate', seriesTemplate);
    SetOption('size', size);
    SetOption('stickyHovering', stickyHovering);
    SetOption('synchronizeMultiAxes', synchronizeMultiAxes);
    SetOption('theme', theme);
    SetOption('title', title);
    SetOption('tooltip', tooltip);
    SetOption('valueAxis', valueAxis);
    SetOption('width', width_);
    SetOption('zoomAndPan', zoomAndPan);

    SetEvent('argumentAxisClick', onArgumentAxisClick);
    SetEvent('disposing', onDisposing);
    SetEvent('done', onDone);
    SetEvent('drawn', onDrawn);
    SetEvent('exported', onExported);
    SetEvent('exporting', onExporting);
    SetEvent('fileSaving', onFileSaving);
    SetEvent('incidentOccurred', onIncidentOccurred);
    SetEvent('initialized', onInitialized);
    SetEvent('legendClick', onLegendClick);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('pointClick', onPointClick);
    SetEvent('pointHoverChanged', onPointHoverChanged);
    SetEvent('pointSelectionChanged', onPointSelectionChanged);
    SetEvent('seriesClick', onSeriesClick);
    SetEvent('seriesHoverChanged', onSeriesHoverChanged);
    SetEvent('seriesSelectionChanged', onSeriesSelectionChanged);
    SetEvent('tooltipHidden', onTooltipHidden);
    SetEvent('tooltipShown', onTooltipShown);
    SetEvent('zoomEnd', onZoomEnd);
    SetEvent('zoomStart', onZoomStart);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomChart.Set_adaptiveLayout(const Value: TJSObject);
begin
  FadaptiveLayout := Value;
  SetOption('adaptiveLayout', adaptiveLayout);
end;

procedure TjdxCustomChart.Set_adjustOnZoom(const Value: boolean);
begin
  FadjustOnZoom := Value;
  SetOption('adjustOnZoom', adjustOnZoom);
end;

procedure TjdxCustomChart.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
  SetOption('animation', animation);
end;

procedure TjdxCustomChart.Set_annotations(const Value: TJSArray);
begin
  Fannotations := Value;
  SetOption('annotations', annotations);
end;

procedure TjdxCustomChart.Set_argumentAxis(const Value: TJSObject);
begin
  FargumentAxis := Value;
  SetOption('argumentAxis', argumentAxis);
end;

procedure TjdxCustomChart.Set_autoHidePointMarkers(const Value: boolean);
begin
  FautoHidePointMarkers := Value;
  SetOption('autoHidePointMarkers', autoHidePointMarkers);
end;

procedure TjdxCustomChart.Set_barGroupPadding(const Value: integer);
begin
  FbarGroupPadding := Value;
  SetOption('barGroupPadding', barGroupPadding);
end;

procedure TjdxCustomChart.Set_barGroupWidth(const Value: integer);
begin
  FbarGroupWidth := Value;
  SetOption('barGroupWidth', barGroupWidth);
end;

procedure TjdxCustomChart.Set_commonAnnotationSettings(const Value: TJSObject);
begin
  FcommonAnnotationSettings := Value;
  SetOption('commonAnnotationSettings', commonAnnotationSettings);
end;

procedure TjdxCustomChart.Set_commonAxisSettings(const Value: TJSObject);
begin
  FcommonAxisSettings := Value;
  SetOption('commonAxisSettings', commonAxisSettings);
end;

procedure TjdxCustomChart.Set_commonPaneSettings(const Value: TJSObject);
begin
  FcommonPaneSettings := Value;
  SetOption('commonPaneSettings', commonPaneSettings);
end;

procedure TjdxCustomChart.Set_commonSeriesSettings(const Value: TJSObject);
begin
  FcommonSeriesSettings := Value;
  SetOption('commonSeriesSettings', commonSeriesSettings);
end;

procedure TjdxCustomChart.Set_containerBackgroundColor(const Value: string);
begin
  FcontainerBackgroundColor := Value;
  SetOption('containerBackgroundColor', containerBackgroundColor);
end;

procedure TjdxCustomChart.Set_crosshair(const Value: TJSObject);
begin
  Fcrosshair := Value;
  SetOption('crosshair', crosshair);
end;

procedure TjdxCustomChart.Set_customizeAnnotation(const Value: TJSFunction);
begin
  FcustomizeAnnotation := Value;
  SetOption('customizeAnnotation', customizeAnnotation);
end;

procedure TjdxCustomChart.Set_customizeLabel(const Value: TJSFunction);
begin
  FcustomizeLabel := Value;
  SetOption('customizeLabel', customizeLabel);
end;

procedure TjdxCustomChart.Set_customizePoint(const Value: TJSFunction);
begin
  FcustomizePoint := Value;
  SetOption('customizePoint', customizePoint);
end;

procedure TjdxCustomChart.Set_dataPrepareSettings(const Value: TJSObject);
begin
  FdataPrepareSettings := Value;
  SetOption('dataPrepareSettings', dataPrepareSettings);
end;

procedure TjdxCustomChart.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomChart.Set_defaultPane(const Value: string);
begin
  FdefaultPane := Value;
  SetOption('defaultPane', defaultPane);
end;

procedure TjdxCustomChart.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomChart.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomChart.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
  SetOption('export', export);
end;

procedure TjdxCustomChart.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomChart.Set_legend(const Value: TJSObject);
begin
  Flegend := Value;
  SetOption('legend', legend);
end;

procedure TjdxCustomChart.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
  SetOption('loadingIndicator', loadingIndicator);
end;

procedure TjdxCustomChart.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
  SetOption('margin', margin);
end;

procedure TjdxCustomChart.Set_maxBubbleSize(const Value: integer);
begin
  FmaxBubbleSize := Value;
  SetOption('maxBubbleSize', maxBubbleSize);
end;

procedure TjdxCustomChart.Set_minBubbleSize(const Value: integer);
begin
  FminBubbleSize := Value;
  SetOption('minBubbleSize', minBubbleSize);
end;

procedure TjdxCustomChart.Set_negativesAsZeroes(const Value: boolean);
begin
  FnegativesAsZeroes := Value;
  SetOption('negativesAsZeroes', negativesAsZeroes);
end;

procedure TjdxCustomChart.Set_palette(const Value: JSValue);
begin
  Fpalette := Value;
  SetOption('palette', palette);
end;

procedure TjdxCustomChart.Set_paletteExtensionMode(const Value: JSValue);
begin
  FpaletteExtensionMode := Value;
  SetOption('paletteExtensionMode', paletteExtensionMode);
end;

procedure TjdxCustomChart.Set_panes(const Value: TJSArray);
begin
  Fpanes := Value;
  SetOption('panes', panes);
end;

procedure TjdxCustomChart.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
  SetOption('pathModified', pathModified);
end;

procedure TjdxCustomChart.Set_pointSelectionMode(const Value: TdxSingleOrMultiple);
begin
  FpointSelectionMode := Value;
  SetOption('pointSelectionMode', pointSelectionMode.ToString());
end;

procedure TjdxCustomChart.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
  SetOption('redrawOnResize', redrawOnResize);
end;

procedure TjdxCustomChart.Set_resizePanesOnZoom(const Value: boolean);
begin
  FresizePanesOnZoom := Value;
  SetOption('resizePanesOnZoom', resizePanesOnZoom);
end;

procedure TjdxCustomChart.Set_resolveLabelOverlapping(const Value: JSValue);
begin
  FresolveLabelOverlapping := Value;
  SetOption('resolveLabelOverlapping', resolveLabelOverlapping);
end;

procedure TjdxCustomChart.Set_rotated(const Value: boolean);
begin
  Frotated := Value;
  SetOption('rotated', rotated);
end;

procedure TjdxCustomChart.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomChart.Set_scrollBar(const Value: TJSObject);
begin
  FscrollBar := Value;
  SetOption('scrollBar', scrollBar);
end;

procedure TjdxCustomChart.Set_series(const Value: JSValue);
begin
  Fseries := Value;
  SetOption('series', series);
end;

procedure TjdxCustomChart.Set_seriesSelectionMode(const Value: TdxSingleOrMultiple);
begin
  FseriesSelectionMode := Value;
  SetOption('seriesSelectionMode', seriesSelectionMode.ToString());
end;

procedure TjdxCustomChart.Set_seriesTemplate(const Value: TJSObject);
begin
  FseriesTemplate := Value;
  SetOption('seriesTemplate', seriesTemplate);
end;

procedure TjdxCustomChart.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
  SetOption('size', size);
end;

procedure TjdxCustomChart.Set_stickyHovering(const Value: boolean);
begin
  FstickyHovering := Value;
  SetOption('stickyHovering', stickyHovering);
end;

procedure TjdxCustomChart.Set_synchronizeMultiAxes(const Value: boolean);
begin
  FsynchronizeMultiAxes := Value;
  SetOption('synchronizeMultiAxes', synchronizeMultiAxes);
end;

procedure TjdxCustomChart.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
  SetOption('theme', theme);
end;

procedure TjdxCustomChart.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
  SetOption('title', title);
end;

procedure TjdxCustomChart.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
  SetOption('tooltip', tooltip);
end;

procedure TjdxCustomChart.Set_valueAxis(const Value: TJSArray);
begin
  FvalueAxis := Value;
  SetOption('valueAxis', valueAxis);
end;

procedure TjdxCustomChart.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomChart.Set_zoomAndPan(const Value: TJSObject);
begin
  FzoomAndPan := Value;
  SetOption('zoomAndPan', zoomAndPan);
end;

procedure TjdxCustomChart.Set_onArgumentAxisClick(const Value: TdxEventHandler);
begin
  FonArgumentAxisClick := Value;
  SetEvent('argumentAxisClick', onArgumentAxisClick);
end;

procedure TjdxCustomChart.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomChart.Set_onDone(const Value: TdxEventHandler);
begin
  FonDone := Value;
  SetEvent('done', onDone);
end;

procedure TjdxCustomChart.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
  SetEvent('drawn', onDrawn);
end;

procedure TjdxCustomChart.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
  SetEvent('exported', onExported);
end;

procedure TjdxCustomChart.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
  SetEvent('exporting', onExporting);
end;

procedure TjdxCustomChart.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
  SetEvent('fileSaving', onFileSaving);
end;

procedure TjdxCustomChart.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
  SetEvent('incidentOccurred', onIncidentOccurred);
end;

procedure TjdxCustomChart.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomChart.Set_onLegendClick(const Value: TdxEventHandler);
begin
  FonLegendClick := Value;
  SetEvent('legendClick', onLegendClick);
end;

procedure TjdxCustomChart.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomChart.Set_onPointClick(const Value: TdxEventHandler);
begin
  FonPointClick := Value;
  SetEvent('pointClick', onPointClick);
end;

procedure TjdxCustomChart.Set_onPointHoverChanged(const Value: TdxEventHandler);
begin
  FonPointHoverChanged := Value;
  SetEvent('pointHoverChanged', onPointHoverChanged);
end;

procedure TjdxCustomChart.Set_onPointSelectionChanged(const Value: TdxEventHandler);
begin
  FonPointSelectionChanged := Value;
  SetEvent('pointSelectionChanged', onPointSelectionChanged);
end;

procedure TjdxCustomChart.Set_onSeriesClick(const Value: TdxEventHandler);
begin
  FonSeriesClick := Value;
  SetEvent('seriesClick', onSeriesClick);
end;

procedure TjdxCustomChart.Set_onSeriesHoverChanged(const Value: TdxEventHandler);
begin
  FonSeriesHoverChanged := Value;
  SetEvent('seriesHoverChanged', onSeriesHoverChanged);
end;

procedure TjdxCustomChart.Set_onSeriesSelectionChanged(const Value: TdxEventHandler);
begin
  FonSeriesSelectionChanged := Value;
  SetEvent('seriesSelectionChanged', onSeriesSelectionChanged);
end;

procedure TjdxCustomChart.Set_onTooltipHidden(const Value: TdxEventHandler);
begin
  FonTooltipHidden := Value;
  SetEvent('tooltipHidden', onTooltipHidden);
end;

procedure TjdxCustomChart.Set_onTooltipShown(const Value: TdxEventHandler);
begin
  FonTooltipShown := Value;
  SetEvent('tooltipShown', onTooltipShown);
end;

procedure TjdxCustomChart.Set_onZoomEnd(const Value: TdxEventHandler);
begin
  FonZoomEnd := Value;
  SetEvent('zoomEnd', onZoomEnd);
end;

procedure TjdxCustomChart.Set_onZoomStart(const Value: TdxEventHandler);
begin
  FonZoomStart := Value;
  SetEvent('zoomStart', onZoomStart);
end;

procedure TjdxCustomChart.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomChart.clearSelection();
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.clearSelection();
end;

procedure TjdxCustomChart.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomChart.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomChart.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomChart.dispose();
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.dispose();
end;

function TjdxCustomChart.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  return _instance.element();
end;

procedure TjdxCustomChart.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomChart.exportTo(fileName: string; format: string);
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.exportTo(fileName, format);
end;

function TjdxCustomChart.getAllSeries(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  return _instance.getAllSeries();
end;

function TjdxCustomChart.getArgumentAxis(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  return _instance.getArgumentAxis();
end;

function TjdxCustomChart.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  return _instance.getDataSource();
end;

function TjdxCustomChart.getSeriesByName(seriesName: JSValue): JSValue;
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  return _instance.getSeriesByName(seriesName);
end;

function TjdxCustomChart.getSeriesByPos(seriesIndex: integer): JSValue;
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  return _instance.getSeriesByPos(seriesIndex);
end;

function TjdxCustomChart.getSize(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  return _instance.getSize();
end;

function TjdxCustomChart.getValueAxis(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  return _instance.getValueAxis();
end;

function TjdxCustomChart.getValueAxis(name_: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  return _instance.getValueAxis(name_);
end;

procedure TjdxCustomChart.hideLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.hideLoadingIndicator();
end;

procedure TjdxCustomChart.hideTooltip();
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.hideTooltip();
end;

function TjdxCustomChart.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomChart.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  return _instance.off(eventName);
end;

function TjdxCustomChart.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  return _instance.on(events);
end;

function TjdxCustomChart.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  return _instance.on(eventName, eventHandler);
end;

procedure TjdxCustomChart.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.option(options);
end;

procedure TjdxCustomChart.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomChart.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  return _instance.option();
end;

function TjdxCustomChart.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomChart.print();
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.print();
end;

procedure TjdxCustomChart.refresh();
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.refresh();
end;

procedure TjdxCustomChart.render(renderOptions: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.render(renderOptions);
end;

procedure TjdxCustomChart.render();
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.render();
end;

procedure TjdxCustomChart.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomChart.resetVisualRange();
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.resetVisualRange();
end;

procedure TjdxCustomChart.showLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.showLoadingIndicator();
end;

function TjdxCustomChart.svg(): string;
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  return _instance.svg();
end;

procedure TjdxCustomChart.zoomArgument(startValue: JSValue; endValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxChart("instance");
  _instance.zoomArgument(startValue, endValue);
end;

end.
