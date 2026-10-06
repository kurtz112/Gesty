unit DevExtreme.PieChart.Custom;

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
  DevExtreme.PieChart.JS,
  DevExtreme.Types;

type
  TjdxCustomPieChart = class(TjdxCustomControl)
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
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxPieChart; assembler;
    function instance: TdxPieChart; assembler;
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
    function getDataSource(): TJSObject; assembler;
    function getInnerRadius(): integer; assembler;
    function getSeriesByName(seriesName: JSValue): JSValue; assembler;
    function getSeriesByPos(seriesIndex: integer): JSValue; assembler;
    function getSize(): JSValue; assembler;
    procedure hideLoadingIndicator(); assembler;
    procedure hideTooltip(); assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure print(); assembler;
    procedure refresh(); assembler;
    procedure render(renderOptions: TJSObject); assembler; overload;
    procedure render(); assembler; overload;
    procedure resetOption(optionName: string); assembler;
    procedure showLoadingIndicator(); assembler;
    function svg(): string; assembler;
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


procedure TjdxCustomPieChart.CreateInitialize;
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
procedure TjdxCustomPieChart.InitJQuery;
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
      $(id).dxPieChart(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomPieChart.getInstance(element: TJSObject): TdxPieChart;
asm
  return DevExpress.viz.dxPieChart.getInstance(element);
end;

function TjdxCustomPieChart.instance: TdxPieChart;
asm
  return $(this.GetJQID()).dxPieChart("instance");
end;
procedure TjdxCustomPieChart.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('adaptiveLayout', adaptiveLayout);
    SetOption('animation', animation);
    SetOption('annotations', annotations);
    SetOption('centerTemplate', centerTemplate);
    SetOption('commonAnnotationSettings', commonAnnotationSettings);
    SetOption('commonSeriesSettings', commonSeriesSettings);
    SetOption('customizeAnnotation', customizeAnnotation);
    SetOption('customizeLabel', customizeLabel);
    SetOption('customizePoint', customizePoint);
    SetOption('dataSource', dataSource);
    SetOption('diameter', diameter);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('export', export);
    SetOption('height', height_);
    SetOption('innerRadius', innerRadius);
    SetOption('legend', legend);
    SetOption('loadingIndicator', loadingIndicator);
    SetOption('margin', margin);
    SetOption('minDiameter', minDiameter);
    SetOption('palette', palette);
    SetOption('paletteExtensionMode', paletteExtensionMode);
    SetOption('pathModified', pathModified);
    SetOption('pointSelectionMode', pointSelectionMode.ToString());
    SetOption('redrawOnResize', redrawOnResize);
    SetOption('resolveLabelOverlapping', resolveLabelOverlapping);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('segmentsDirection', segmentsDirection.ToString());
    SetOption('series', series);
    SetOption('seriesTemplate', seriesTemplate);
    SetOption('size', size);
    SetOption('sizeGroup', sizeGroup);
    SetOption('startAngle', startAngle);
    SetOption('theme', theme);
    SetOption('title', title);
    SetOption('tooltip', tooltip);
    SetOption('type', type_.ToString());
    SetOption('width', width_);

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
    SetEvent('tooltipHidden', onTooltipHidden);
    SetEvent('tooltipShown', onTooltipShown);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomPieChart.Set_adaptiveLayout(const Value: TJSObject);
begin
  FadaptiveLayout := Value;
  SetOption('adaptiveLayout', adaptiveLayout);
end;

procedure TjdxCustomPieChart.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
  SetOption('animation', animation);
end;

procedure TjdxCustomPieChart.Set_annotations(const Value: TJSArray);
begin
  Fannotations := Value;
  SetOption('annotations', annotations);
end;

procedure TjdxCustomPieChart.Set_centerTemplate(const Value: JSValue);
begin
  FcenterTemplate := Value;
  SetOption('centerTemplate', centerTemplate);
end;

procedure TjdxCustomPieChart.Set_commonAnnotationSettings(const Value: TJSObject);
begin
  FcommonAnnotationSettings := Value;
  SetOption('commonAnnotationSettings', commonAnnotationSettings);
end;

procedure TjdxCustomPieChart.Set_commonSeriesSettings(const Value: TJSObject);
begin
  FcommonSeriesSettings := Value;
  SetOption('commonSeriesSettings', commonSeriesSettings);
end;

procedure TjdxCustomPieChart.Set_customizeAnnotation(const Value: TJSFunction);
begin
  FcustomizeAnnotation := Value;
  SetOption('customizeAnnotation', customizeAnnotation);
end;

procedure TjdxCustomPieChart.Set_customizeLabel(const Value: TJSFunction);
begin
  FcustomizeLabel := Value;
  SetOption('customizeLabel', customizeLabel);
end;

procedure TjdxCustomPieChart.Set_customizePoint(const Value: TJSFunction);
begin
  FcustomizePoint := Value;
  SetOption('customizePoint', customizePoint);
end;

procedure TjdxCustomPieChart.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomPieChart.Set_diameter(const Value: integer);
begin
  Fdiameter := Value;
  SetOption('diameter', diameter);
end;

procedure TjdxCustomPieChart.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomPieChart.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomPieChart.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
  SetOption('export', export);
end;

procedure TjdxCustomPieChart.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomPieChart.Set_innerRadius(const Value: integer);
begin
  FinnerRadius := Value;
  SetOption('innerRadius', innerRadius);
end;

procedure TjdxCustomPieChart.Set_legend(const Value: TJSObject);
begin
  Flegend := Value;
  SetOption('legend', legend);
end;

procedure TjdxCustomPieChart.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
  SetOption('loadingIndicator', loadingIndicator);
end;

procedure TjdxCustomPieChart.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
  SetOption('margin', margin);
end;

procedure TjdxCustomPieChart.Set_minDiameter(const Value: integer);
begin
  FminDiameter := Value;
  SetOption('minDiameter', minDiameter);
end;

procedure TjdxCustomPieChart.Set_palette(const Value: JSValue);
begin
  Fpalette := Value;
  SetOption('palette', palette);
end;

procedure TjdxCustomPieChart.Set_paletteExtensionMode(const Value: JSValue);
begin
  FpaletteExtensionMode := Value;
  SetOption('paletteExtensionMode', paletteExtensionMode);
end;

procedure TjdxCustomPieChart.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
  SetOption('pathModified', pathModified);
end;

procedure TjdxCustomPieChart.Set_pointSelectionMode(const Value: TdxSingleOrMultiple);
begin
  FpointSelectionMode := Value;
  SetOption('pointSelectionMode', pointSelectionMode.ToString());
end;

procedure TjdxCustomPieChart.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
  SetOption('redrawOnResize', redrawOnResize);
end;

procedure TjdxCustomPieChart.Set_resolveLabelOverlapping(const Value: JSValue);
begin
  FresolveLabelOverlapping := Value;
  SetOption('resolveLabelOverlapping', resolveLabelOverlapping);
end;

procedure TjdxCustomPieChart.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomPieChart.Set_segmentsDirection(const Value: TdxPieChartSegmentDirection);
begin
  FsegmentsDirection := Value;
  SetOption('segmentsDirection', segmentsDirection.ToString());
end;

procedure TjdxCustomPieChart.Set_series(const Value: JSValue);
begin
  Fseries := Value;
  SetOption('series', series);
end;

procedure TjdxCustomPieChart.Set_seriesTemplate(const Value: TJSObject);
begin
  FseriesTemplate := Value;
  SetOption('seriesTemplate', seriesTemplate);
end;

procedure TjdxCustomPieChart.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
  SetOption('size', size);
end;

procedure TjdxCustomPieChart.Set_sizeGroup(const Value: string);
begin
  FsizeGroup := Value;
  SetOption('sizeGroup', sizeGroup);
end;

procedure TjdxCustomPieChart.Set_startAngle(const Value: integer);
begin
  FstartAngle := Value;
  SetOption('startAngle', startAngle);
end;

procedure TjdxCustomPieChart.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
  SetOption('theme', theme);
end;

procedure TjdxCustomPieChart.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
  SetOption('title', title);
end;

procedure TjdxCustomPieChart.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
  SetOption('tooltip', tooltip);
end;

procedure TjdxCustomPieChart.Set_type_(const Value: TdxPieChartType);
begin
  Ftype_ := Value;
  SetOption('type', type_.ToString());
end;

procedure TjdxCustomPieChart.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomPieChart.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomPieChart.Set_onDone(const Value: TdxEventHandler);
begin
  FonDone := Value;
  SetEvent('done', onDone);
end;

procedure TjdxCustomPieChart.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
  SetEvent('drawn', onDrawn);
end;

procedure TjdxCustomPieChart.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
  SetEvent('exported', onExported);
end;

procedure TjdxCustomPieChart.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
  SetEvent('exporting', onExporting);
end;

procedure TjdxCustomPieChart.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
  SetEvent('fileSaving', onFileSaving);
end;

procedure TjdxCustomPieChart.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
  SetEvent('incidentOccurred', onIncidentOccurred);
end;

procedure TjdxCustomPieChart.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomPieChart.Set_onLegendClick(const Value: TdxEventHandler);
begin
  FonLegendClick := Value;
  SetEvent('legendClick', onLegendClick);
end;

procedure TjdxCustomPieChart.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomPieChart.Set_onPointClick(const Value: TdxEventHandler);
begin
  FonPointClick := Value;
  SetEvent('pointClick', onPointClick);
end;

procedure TjdxCustomPieChart.Set_onPointHoverChanged(const Value: TdxEventHandler);
begin
  FonPointHoverChanged := Value;
  SetEvent('pointHoverChanged', onPointHoverChanged);
end;

procedure TjdxCustomPieChart.Set_onPointSelectionChanged(const Value: TdxEventHandler);
begin
  FonPointSelectionChanged := Value;
  SetEvent('pointSelectionChanged', onPointSelectionChanged);
end;

procedure TjdxCustomPieChart.Set_onTooltipHidden(const Value: TdxEventHandler);
begin
  FonTooltipHidden := Value;
  SetEvent('tooltipHidden', onTooltipHidden);
end;

procedure TjdxCustomPieChart.Set_onTooltipShown(const Value: TdxEventHandler);
begin
  FonTooltipShown := Value;
  SetEvent('tooltipShown', onTooltipShown);
end;

procedure TjdxCustomPieChart.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomPieChart.clearSelection();
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.clearSelection();
end;

procedure TjdxCustomPieChart.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomPieChart.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomPieChart.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomPieChart.dispose();
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.dispose();
end;

function TjdxCustomPieChart.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  return _instance.element();
end;

procedure TjdxCustomPieChart.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomPieChart.exportTo(fileName: string; format: string);
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.exportTo(fileName, format);
end;

function TjdxCustomPieChart.getAllSeries(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  return _instance.getAllSeries();
end;

function TjdxCustomPieChart.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  return _instance.getDataSource();
end;

function TjdxCustomPieChart.getInnerRadius(): integer;
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  return _instance.getInnerRadius();
end;

function TjdxCustomPieChart.getSeriesByName(seriesName: JSValue): JSValue;
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  return _instance.getSeriesByName(seriesName);
end;

function TjdxCustomPieChart.getSeriesByPos(seriesIndex: integer): JSValue;
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  return _instance.getSeriesByPos(seriesIndex);
end;

function TjdxCustomPieChart.getSize(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  return _instance.getSize();
end;

procedure TjdxCustomPieChart.hideLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.hideLoadingIndicator();
end;

procedure TjdxCustomPieChart.hideTooltip();
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.hideTooltip();
end;

function TjdxCustomPieChart.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomPieChart.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  return _instance.off(eventName);
end;

function TjdxCustomPieChart.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  return _instance.on(events);
end;

function TjdxCustomPieChart.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  return _instance.on(eventName, eventHandler);
end;

procedure TjdxCustomPieChart.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.option(options);
end;

procedure TjdxCustomPieChart.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomPieChart.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  return _instance.option(optionName);
end;

function TjdxCustomPieChart.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  return _instance.option();
end;

procedure TjdxCustomPieChart.print();
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.print();
end;

procedure TjdxCustomPieChart.refresh();
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.refresh();
end;

procedure TjdxCustomPieChart.render(renderOptions: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.render(renderOptions);
end;

procedure TjdxCustomPieChart.render();
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.render();
end;

procedure TjdxCustomPieChart.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomPieChart.showLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  _instance.showLoadingIndicator();
end;

function TjdxCustomPieChart.svg(): string;
asm
  const _instance = $(this.GetJQID()).dxPieChart("instance");
  return _instance.svg();
end;

end.
