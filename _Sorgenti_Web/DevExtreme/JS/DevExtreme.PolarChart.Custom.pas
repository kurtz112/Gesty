unit DevExtreme.PolarChart.Custom;

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
  DevExtreme.PolarChart.JS,
  DevExtreme.Types;

type
  TjdxCustomPolarChart = class(TjdxCustomControl)
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
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxPolarChart; assembler;
    function instance: TdxPolarChart; assembler;
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
    function getSeriesByName(seriesName: JSValue): JSValue; assembler;
    function getSeriesByPos(seriesIndex: integer): JSValue; assembler;
    function getSize(): JSValue; assembler;
    function getValueAxis(): JSValue; assembler;
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
    procedure resetVisualRange(); assembler;
    procedure showLoadingIndicator(); assembler;
    function svg(): string; assembler;
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


procedure TjdxCustomPolarChart.CreateInitialize;
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
procedure TjdxCustomPolarChart.InitJQuery;
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
      $(id).dxPolarChart(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomPolarChart.getInstance(element: TJSObject): TdxPolarChart;
asm
  return DevExpress.viz.dxPolarChart.getInstance(element);
end;

function TjdxCustomPolarChart.instance: TdxPolarChart;
asm
  return $(this.GetJQID()).dxPolarChart("instance");
end;
procedure TjdxCustomPolarChart.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('adaptiveLayout', adaptiveLayout);
    SetOption('animation', animation);
    SetOption('annotations', annotations);
    SetOption('argumentAxis', argumentAxis);
    SetOption('barGroupPadding', barGroupPadding);
    SetOption('barGroupWidth', barGroupWidth);
    SetOption('commonAnnotationSettings', commonAnnotationSettings);
    SetOption('commonAxisSettings', commonAxisSettings);
    SetOption('commonSeriesSettings', commonSeriesSettings);
    SetOption('containerBackgroundColor', containerBackgroundColor);
    SetOption('customizeAnnotation', customizeAnnotation);
    SetOption('customizeLabel', customizeLabel);
    SetOption('customizePoint', customizePoint);
    SetOption('dataPrepareSettings', dataPrepareSettings);
    SetOption('dataSource', dataSource);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('export', export);
    SetOption('height', height_);
    SetOption('legend', legend);
    SetOption('loadingIndicator', loadingIndicator);
    SetOption('margin', margin);
    SetOption('negativesAsZeroes', negativesAsZeroes);
    SetOption('palette', palette);
    SetOption('paletteExtensionMode', paletteExtensionMode);
    SetOption('pathModified', pathModified);
    SetOption('pointSelectionMode', pointSelectionMode.ToString());
    SetOption('redrawOnResize', redrawOnResize);
    SetOption('resolveLabelOverlapping', resolveLabelOverlapping);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('series', series);
    SetOption('seriesSelectionMode', seriesSelectionMode.ToString());
    SetOption('seriesTemplate', seriesTemplate);
    SetOption('size', size);
    SetOption('theme', theme);
    SetOption('title', title);
    SetOption('tooltip', tooltip);
    SetOption('useSpiderWeb', useSpiderWeb);
    SetOption('valueAxis', valueAxis);
    SetOption('width', width_);

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

procedure TjdxCustomPolarChart.Set_adaptiveLayout(const Value: TJSObject);
begin
  FadaptiveLayout := Value;
  SetOption('adaptiveLayout', adaptiveLayout);
end;

procedure TjdxCustomPolarChart.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
  SetOption('animation', animation);
end;

procedure TjdxCustomPolarChart.Set_annotations(const Value: TJSArray);
begin
  Fannotations := Value;
  SetOption('annotations', annotations);
end;

procedure TjdxCustomPolarChart.Set_argumentAxis(const Value: TJSObject);
begin
  FargumentAxis := Value;
  SetOption('argumentAxis', argumentAxis);
end;

procedure TjdxCustomPolarChart.Set_barGroupPadding(const Value: integer);
begin
  FbarGroupPadding := Value;
  SetOption('barGroupPadding', barGroupPadding);
end;

procedure TjdxCustomPolarChart.Set_barGroupWidth(const Value: integer);
begin
  FbarGroupWidth := Value;
  SetOption('barGroupWidth', barGroupWidth);
end;

procedure TjdxCustomPolarChart.Set_commonAnnotationSettings(const Value: TJSObject);
begin
  FcommonAnnotationSettings := Value;
  SetOption('commonAnnotationSettings', commonAnnotationSettings);
end;

procedure TjdxCustomPolarChart.Set_commonAxisSettings(const Value: TJSObject);
begin
  FcommonAxisSettings := Value;
  SetOption('commonAxisSettings', commonAxisSettings);
end;

procedure TjdxCustomPolarChart.Set_commonSeriesSettings(const Value: TJSObject);
begin
  FcommonSeriesSettings := Value;
  SetOption('commonSeriesSettings', commonSeriesSettings);
end;

procedure TjdxCustomPolarChart.Set_containerBackgroundColor(const Value: string);
begin
  FcontainerBackgroundColor := Value;
  SetOption('containerBackgroundColor', containerBackgroundColor);
end;

procedure TjdxCustomPolarChart.Set_customizeAnnotation(const Value: TJSFunction);
begin
  FcustomizeAnnotation := Value;
  SetOption('customizeAnnotation', customizeAnnotation);
end;

procedure TjdxCustomPolarChart.Set_customizeLabel(const Value: TJSFunction);
begin
  FcustomizeLabel := Value;
  SetOption('customizeLabel', customizeLabel);
end;

procedure TjdxCustomPolarChart.Set_customizePoint(const Value: TJSFunction);
begin
  FcustomizePoint := Value;
  SetOption('customizePoint', customizePoint);
end;

procedure TjdxCustomPolarChart.Set_dataPrepareSettings(const Value: TJSObject);
begin
  FdataPrepareSettings := Value;
  SetOption('dataPrepareSettings', dataPrepareSettings);
end;

procedure TjdxCustomPolarChart.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomPolarChart.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomPolarChart.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomPolarChart.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
  SetOption('export', export);
end;

procedure TjdxCustomPolarChart.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomPolarChart.Set_legend(const Value: TJSObject);
begin
  Flegend := Value;
  SetOption('legend', legend);
end;

procedure TjdxCustomPolarChart.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
  SetOption('loadingIndicator', loadingIndicator);
end;

procedure TjdxCustomPolarChart.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
  SetOption('margin', margin);
end;

procedure TjdxCustomPolarChart.Set_negativesAsZeroes(const Value: boolean);
begin
  FnegativesAsZeroes := Value;
  SetOption('negativesAsZeroes', negativesAsZeroes);
end;

procedure TjdxCustomPolarChart.Set_palette(const Value: JSValue);
begin
  Fpalette := Value;
  SetOption('palette', palette);
end;

procedure TjdxCustomPolarChart.Set_paletteExtensionMode(const Value: JSValue);
begin
  FpaletteExtensionMode := Value;
  SetOption('paletteExtensionMode', paletteExtensionMode);
end;

procedure TjdxCustomPolarChart.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
  SetOption('pathModified', pathModified);
end;

procedure TjdxCustomPolarChart.Set_pointSelectionMode(const Value: TdxSingleOrMultiple);
begin
  FpointSelectionMode := Value;
  SetOption('pointSelectionMode', pointSelectionMode.ToString());
end;

procedure TjdxCustomPolarChart.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
  SetOption('redrawOnResize', redrawOnResize);
end;

procedure TjdxCustomPolarChart.Set_resolveLabelOverlapping(const Value: JSValue);
begin
  FresolveLabelOverlapping := Value;
  SetOption('resolveLabelOverlapping', resolveLabelOverlapping);
end;

procedure TjdxCustomPolarChart.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomPolarChart.Set_series(const Value: JSValue);
begin
  Fseries := Value;
  SetOption('series', series);
end;

procedure TjdxCustomPolarChart.Set_seriesSelectionMode(const Value: TdxSingleOrMultiple);
begin
  FseriesSelectionMode := Value;
  SetOption('seriesSelectionMode', seriesSelectionMode.ToString());
end;

procedure TjdxCustomPolarChart.Set_seriesTemplate(const Value: TJSObject);
begin
  FseriesTemplate := Value;
  SetOption('seriesTemplate', seriesTemplate);
end;

procedure TjdxCustomPolarChart.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
  SetOption('size', size);
end;

procedure TjdxCustomPolarChart.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
  SetOption('theme', theme);
end;

procedure TjdxCustomPolarChart.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
  SetOption('title', title);
end;

procedure TjdxCustomPolarChart.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
  SetOption('tooltip', tooltip);
end;

procedure TjdxCustomPolarChart.Set_useSpiderWeb(const Value: boolean);
begin
  FuseSpiderWeb := Value;
  SetOption('useSpiderWeb', useSpiderWeb);
end;

procedure TjdxCustomPolarChart.Set_valueAxis(const Value: TJSObject);
begin
  FvalueAxis := Value;
  SetOption('valueAxis', valueAxis);
end;

procedure TjdxCustomPolarChart.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomPolarChart.Set_onArgumentAxisClick(const Value: TdxEventHandler);
begin
  FonArgumentAxisClick := Value;
  SetEvent('argumentAxisClick', onArgumentAxisClick);
end;

procedure TjdxCustomPolarChart.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomPolarChart.Set_onDone(const Value: TdxEventHandler);
begin
  FonDone := Value;
  SetEvent('done', onDone);
end;

procedure TjdxCustomPolarChart.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
  SetEvent('drawn', onDrawn);
end;

procedure TjdxCustomPolarChart.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
  SetEvent('exported', onExported);
end;

procedure TjdxCustomPolarChart.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
  SetEvent('exporting', onExporting);
end;

procedure TjdxCustomPolarChart.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
  SetEvent('fileSaving', onFileSaving);
end;

procedure TjdxCustomPolarChart.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
  SetEvent('incidentOccurred', onIncidentOccurred);
end;

procedure TjdxCustomPolarChart.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomPolarChart.Set_onLegendClick(const Value: TdxEventHandler);
begin
  FonLegendClick := Value;
  SetEvent('legendClick', onLegendClick);
end;

procedure TjdxCustomPolarChart.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomPolarChart.Set_onPointClick(const Value: TdxEventHandler);
begin
  FonPointClick := Value;
  SetEvent('pointClick', onPointClick);
end;

procedure TjdxCustomPolarChart.Set_onPointHoverChanged(const Value: TdxEventHandler);
begin
  FonPointHoverChanged := Value;
  SetEvent('pointHoverChanged', onPointHoverChanged);
end;

procedure TjdxCustomPolarChart.Set_onPointSelectionChanged(const Value: TdxEventHandler);
begin
  FonPointSelectionChanged := Value;
  SetEvent('pointSelectionChanged', onPointSelectionChanged);
end;

procedure TjdxCustomPolarChart.Set_onSeriesClick(const Value: TdxEventHandler);
begin
  FonSeriesClick := Value;
  SetEvent('seriesClick', onSeriesClick);
end;

procedure TjdxCustomPolarChart.Set_onSeriesHoverChanged(const Value: TdxEventHandler);
begin
  FonSeriesHoverChanged := Value;
  SetEvent('seriesHoverChanged', onSeriesHoverChanged);
end;

procedure TjdxCustomPolarChart.Set_onSeriesSelectionChanged(const Value: TdxEventHandler);
begin
  FonSeriesSelectionChanged := Value;
  SetEvent('seriesSelectionChanged', onSeriesSelectionChanged);
end;

procedure TjdxCustomPolarChart.Set_onTooltipHidden(const Value: TdxEventHandler);
begin
  FonTooltipHidden := Value;
  SetEvent('tooltipHidden', onTooltipHidden);
end;

procedure TjdxCustomPolarChart.Set_onTooltipShown(const Value: TdxEventHandler);
begin
  FonTooltipShown := Value;
  SetEvent('tooltipShown', onTooltipShown);
end;

procedure TjdxCustomPolarChart.Set_onZoomEnd(const Value: TdxEventHandler);
begin
  FonZoomEnd := Value;
  SetEvent('zoomEnd', onZoomEnd);
end;

procedure TjdxCustomPolarChart.Set_onZoomStart(const Value: TdxEventHandler);
begin
  FonZoomStart := Value;
  SetEvent('zoomStart', onZoomStart);
end;

procedure TjdxCustomPolarChart.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomPolarChart.clearSelection();
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.clearSelection();
end;

procedure TjdxCustomPolarChart.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomPolarChart.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomPolarChart.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomPolarChart.dispose();
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.dispose();
end;

function TjdxCustomPolarChart.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  return _instance.element();
end;

procedure TjdxCustomPolarChart.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomPolarChart.exportTo(fileName: string; format: string);
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.exportTo(fileName, format);
end;

function TjdxCustomPolarChart.getAllSeries(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  return _instance.getAllSeries();
end;

function TjdxCustomPolarChart.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  return _instance.getDataSource();
end;

function TjdxCustomPolarChart.getSeriesByName(seriesName: JSValue): JSValue;
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  return _instance.getSeriesByName(seriesName);
end;

function TjdxCustomPolarChart.getSeriesByPos(seriesIndex: integer): JSValue;
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  return _instance.getSeriesByPos(seriesIndex);
end;

function TjdxCustomPolarChart.getSize(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  return _instance.getSize();
end;

function TjdxCustomPolarChart.getValueAxis(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  return _instance.getValueAxis();
end;

procedure TjdxCustomPolarChart.hideLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.hideLoadingIndicator();
end;

procedure TjdxCustomPolarChart.hideTooltip();
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.hideTooltip();
end;

function TjdxCustomPolarChart.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomPolarChart.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  return _instance.off(eventName);
end;

function TjdxCustomPolarChart.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  return _instance.on(events);
end;

function TjdxCustomPolarChart.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  return _instance.on(eventName, eventHandler);
end;

procedure TjdxCustomPolarChart.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.option(options);
end;

procedure TjdxCustomPolarChart.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomPolarChart.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  return _instance.option(optionName);
end;

function TjdxCustomPolarChart.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  return _instance.option();
end;

procedure TjdxCustomPolarChart.print();
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.print();
end;

procedure TjdxCustomPolarChart.refresh();
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.refresh();
end;

procedure TjdxCustomPolarChart.render(renderOptions: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.render(renderOptions);
end;

procedure TjdxCustomPolarChart.render();
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.render();
end;

procedure TjdxCustomPolarChart.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomPolarChart.resetVisualRange();
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.resetVisualRange();
end;

procedure TjdxCustomPolarChart.showLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  _instance.showLoadingIndicator();
end;

function TjdxCustomPolarChart.svg(): string;
asm
  const _instance = $(this.GetJQID()).dxPolarChart("instance");
  return _instance.svg();
end;

end.
