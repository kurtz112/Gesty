unit DevExtreme.Sparkline.Custom;

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
  DevExtreme.Sparkline.JS,
  DevExtreme.Types;

type
  TjdxCustomSparkline = class(TjdxCustomControl)
  private
    FargumentField: string;
    FbarNegativeColor: string;
    FbarPositiveColor: string;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    FfirstLastColor: string;
    Fheight_: JSValue;
    FignoreEmptyPoints: boolean;
    FlineColor: string;
    FlineWidth: integer;
    FloadingIndicator: TJSObject;
    FlossColor: string;
    Fmargin: TJSObject;
    FmaxColor: string;
    FmaxValue: integer;
    FminColor: string;
    FminValue: integer;
    FpathModified: boolean;
    FpointColor: string;
    FpointSize: integer;
    FpointSymbol: JSValue;
    FredrawOnResize: boolean;
    FrtlEnabled: boolean;
    FshowFirstLast: boolean;
    FshowMinMax: boolean;
    Fsize: TJSObject;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    Ftype_: TdxSparklineType;
    FvalueField: string;
    Fwidth_: JSValue;
    FwinColor: string;
    FwinlossThreshold: integer;
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
    procedure Set_argumentField(const value: string);
    procedure Set_barNegativeColor(const value: string);
    procedure Set_barPositiveColor(const value: string);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_firstLastColor(const value: string);
    procedure Set_height_(const value: JSValue);
    procedure Set_ignoreEmptyPoints(const value: boolean);
    procedure Set_lineColor(const value: string);
    procedure Set_lineWidth(const value: integer);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_lossColor(const value: string);
    procedure Set_margin(const value: TJSObject);
    procedure Set_maxColor(const value: string);
    procedure Set_maxValue(const value: integer);
    procedure Set_minColor(const value: string);
    procedure Set_minValue(const value: integer);
    procedure Set_pathModified(const value: boolean);
    procedure Set_pointColor(const value: string);
    procedure Set_pointSize(const value: integer);
    procedure Set_pointSymbol(const value: JSValue);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_showFirstLast(const value: boolean);
    procedure Set_showMinMax(const value: boolean);
    procedure Set_size(const value: TJSObject);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_type_(const value: TdxSparklineType);
    procedure Set_valueField(const value: string);
    procedure Set_width_(const value: JSValue);
    procedure Set_winColor(const value: string);
    procedure Set_winlossThreshold(const value: integer);
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
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxSparkline; assembler;
    function instance: TdxSparkline; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler; overload;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure exportTo(fileName: string; format: string); assembler; overload;
    procedure exportTo(); assembler; overload;
    function getDataSource(): TJSObject; assembler;
    function getSize(): JSValue; assembler;
    procedure hideLoadingIndicator(); assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure print(); assembler;
    procedure render(); assembler; overload;
    procedure resetOption(optionName: string); assembler;
    procedure showLoadingIndicator(); assembler; overload;
    function svg(): string; assembler;
  public
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property height_: JSValue read Fheight_ write Set_height_;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property pointSymbol: JSValue read FpointSymbol write Set_pointSymbol;
    property size: TJSObject read Fsize write Set_size;
    property theme: JSValue read Ftheme write Set_theme;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property argumentField: string read FargumentField write Set_argumentField;
    property barNegativeColor: string read FbarNegativeColor write Set_barNegativeColor;
    property barPositiveColor: string read FbarPositiveColor write Set_barPositiveColor;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property firstLastColor: string read FfirstLastColor write Set_firstLastColor;
    property ignoreEmptyPoints: boolean read FignoreEmptyPoints write Set_ignoreEmptyPoints default false;
    property lineColor: string read FlineColor write Set_lineColor;
    property lineWidth: integer read FlineWidth write Set_lineWidth;
    property lossColor: string read FlossColor write Set_lossColor;
    property maxColor: string read FmaxColor write Set_maxColor;
    property maxValue: integer read FmaxValue write Set_maxValue;
    property minColor: string read FminColor write Set_minColor;
    property minValue: integer read FminValue write Set_minValue;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property pointColor: string read FpointColor write Set_pointColor;
    property pointSize: integer read FpointSize write Set_pointSize;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showFirstLast: boolean read FshowFirstLast write Set_showFirstLast default true;
    property showMinMax: boolean read FshowMinMax write Set_showMinMax default false;
    property type_: TdxSparklineType read Ftype_ write Set_type_ default stLine;
    property valueField: string read FvalueField write Set_valueField;
    property winColor: string read FwinColor write Set_winColor;
    property winlossThreshold: integer read FwinlossThreshold write Set_winlossThreshold;
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


procedure TjdxCustomSparkline.CreateInitialize;
begin
  inherited;
  FargumentField := '';
  FbarNegativeColor := '';
  FbarPositiveColor := '';
  FdataSource := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  FfirstLastColor := '';
  Fheight_ := nil;
  FignoreEmptyPoints := false;
  FlineColor := '';
  FlineWidth := 0;
  FloadingIndicator := TJSObject.new;
  FlossColor := '';
  Fmargin := TJSObject.new;
  FmaxColor := '';
  FmaxValue := 0;
  FminColor := '';
  FminValue := 0;
  FpathModified := false;
  FpointColor := '';
  FpointSize := 0;
  FpointSymbol := nil;
  FredrawOnResize := true;
  FrtlEnabled := false;
  FshowFirstLast := true;
  FshowMinMax := false;
  Fsize := TJSObject.new;
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  Ftype_ := stLine;
  FvalueField := '';
  Fwidth_ := nil;
  FwinColor := '';
  FwinlossThreshold := 0;

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
procedure TjdxCustomSparkline.InitJQuery;
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
      $(id).dxSparkline(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomSparkline.getInstance(element: TJSObject): TdxSparkline;
asm
  return DevExpress.viz.dxSparkline.getInstance(element);
end;

function TjdxCustomSparkline.instance: TdxSparkline;
asm
  return $(this.GetJQID()).dxSparkline("instance");
end;
procedure TjdxCustomSparkline.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('argumentField', argumentField);
    SetOption('barNegativeColor', barNegativeColor);
    SetOption('barPositiveColor', barPositiveColor);
    SetOption('dataSource', dataSource);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('export', export);
    SetOption('firstLastColor', firstLastColor);
    SetOption('height', height_);
    SetOption('ignoreEmptyPoints', ignoreEmptyPoints);
    SetOption('lineColor', lineColor);
    SetOption('lineWidth', lineWidth);
    SetOption('loadingIndicator', loadingIndicator);
    SetOption('lossColor', lossColor);
    SetOption('margin', margin);
    SetOption('maxColor', maxColor);
    SetOption('maxValue', maxValue);
    SetOption('minColor', minColor);
    SetOption('minValue', minValue);
    SetOption('pathModified', pathModified);
    SetOption('pointColor', pointColor);
    SetOption('pointSize', pointSize);
    SetOption('pointSymbol', pointSymbol);
    SetOption('redrawOnResize', redrawOnResize);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('showFirstLast', showFirstLast);
    SetOption('showMinMax', showMinMax);
    SetOption('size', size);
    SetOption('theme', theme);
    SetOption('title', title);
    SetOption('tooltip', tooltip);
    SetOption('type', type_.ToString());
    SetOption('valueField', valueField);
    SetOption('width', width_);
    SetOption('winColor', winColor);
    SetOption('winlossThreshold', winlossThreshold);

    SetEvent('disposing', onDisposing);
    SetEvent('drawn', onDrawn);
    SetEvent('exported', onExported);
    SetEvent('exporting', onExporting);
    SetEvent('fileSaving', onFileSaving);
    SetEvent('incidentOccurred', onIncidentOccurred);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('tooltipHidden', onTooltipHidden);
    SetEvent('tooltipShown', onTooltipShown);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomSparkline.Set_argumentField(const Value: string);
begin
  FargumentField := Value;
  SetOption('argumentField', argumentField);
end;

procedure TjdxCustomSparkline.Set_barNegativeColor(const Value: string);
begin
  FbarNegativeColor := Value;
  SetOption('barNegativeColor', barNegativeColor);
end;

procedure TjdxCustomSparkline.Set_barPositiveColor(const Value: string);
begin
  FbarPositiveColor := Value;
  SetOption('barPositiveColor', barPositiveColor);
end;

procedure TjdxCustomSparkline.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomSparkline.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomSparkline.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomSparkline.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
  SetOption('export', export);
end;

procedure TjdxCustomSparkline.Set_firstLastColor(const Value: string);
begin
  FfirstLastColor := Value;
  SetOption('firstLastColor', firstLastColor);
end;

procedure TjdxCustomSparkline.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomSparkline.Set_ignoreEmptyPoints(const Value: boolean);
begin
  FignoreEmptyPoints := Value;
  SetOption('ignoreEmptyPoints', ignoreEmptyPoints);
end;

procedure TjdxCustomSparkline.Set_lineColor(const Value: string);
begin
  FlineColor := Value;
  SetOption('lineColor', lineColor);
end;

procedure TjdxCustomSparkline.Set_lineWidth(const Value: integer);
begin
  FlineWidth := Value;
  SetOption('lineWidth', lineWidth);
end;

procedure TjdxCustomSparkline.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
  SetOption('loadingIndicator', loadingIndicator);
end;

procedure TjdxCustomSparkline.Set_lossColor(const Value: string);
begin
  FlossColor := Value;
  SetOption('lossColor', lossColor);
end;

procedure TjdxCustomSparkline.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
  SetOption('margin', margin);
end;

procedure TjdxCustomSparkline.Set_maxColor(const Value: string);
begin
  FmaxColor := Value;
  SetOption('maxColor', maxColor);
end;

procedure TjdxCustomSparkline.Set_maxValue(const Value: integer);
begin
  FmaxValue := Value;
  SetOption('maxValue', maxValue);
end;

procedure TjdxCustomSparkline.Set_minColor(const Value: string);
begin
  FminColor := Value;
  SetOption('minColor', minColor);
end;

procedure TjdxCustomSparkline.Set_minValue(const Value: integer);
begin
  FminValue := Value;
  SetOption('minValue', minValue);
end;

procedure TjdxCustomSparkline.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
  SetOption('pathModified', pathModified);
end;

procedure TjdxCustomSparkline.Set_pointColor(const Value: string);
begin
  FpointColor := Value;
  SetOption('pointColor', pointColor);
end;

procedure TjdxCustomSparkline.Set_pointSize(const Value: integer);
begin
  FpointSize := Value;
  SetOption('pointSize', pointSize);
end;

procedure TjdxCustomSparkline.Set_pointSymbol(const Value: JSValue);
begin
  FpointSymbol := Value;
  SetOption('pointSymbol', pointSymbol);
end;

procedure TjdxCustomSparkline.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
  SetOption('redrawOnResize', redrawOnResize);
end;

procedure TjdxCustomSparkline.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomSparkline.Set_showFirstLast(const Value: boolean);
begin
  FshowFirstLast := Value;
  SetOption('showFirstLast', showFirstLast);
end;

procedure TjdxCustomSparkline.Set_showMinMax(const Value: boolean);
begin
  FshowMinMax := Value;
  SetOption('showMinMax', showMinMax);
end;

procedure TjdxCustomSparkline.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
  SetOption('size', size);
end;

procedure TjdxCustomSparkline.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
  SetOption('theme', theme);
end;

procedure TjdxCustomSparkline.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
  SetOption('title', title);
end;

procedure TjdxCustomSparkline.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
  SetOption('tooltip', tooltip);
end;

procedure TjdxCustomSparkline.Set_type_(const Value: TdxSparklineType);
begin
  Ftype_ := Value;
  SetOption('type', type_.ToString());
end;

procedure TjdxCustomSparkline.Set_valueField(const Value: string);
begin
  FvalueField := Value;
  SetOption('valueField', valueField);
end;

procedure TjdxCustomSparkline.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomSparkline.Set_winColor(const Value: string);
begin
  FwinColor := Value;
  SetOption('winColor', winColor);
end;

procedure TjdxCustomSparkline.Set_winlossThreshold(const Value: integer);
begin
  FwinlossThreshold := Value;
  SetOption('winlossThreshold', winlossThreshold);
end;

procedure TjdxCustomSparkline.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomSparkline.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
  SetEvent('drawn', onDrawn);
end;

procedure TjdxCustomSparkline.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
  SetEvent('exported', onExported);
end;

procedure TjdxCustomSparkline.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
  SetEvent('exporting', onExporting);
end;

procedure TjdxCustomSparkline.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
  SetEvent('fileSaving', onFileSaving);
end;

procedure TjdxCustomSparkline.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
  SetEvent('incidentOccurred', onIncidentOccurred);
end;

procedure TjdxCustomSparkline.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomSparkline.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomSparkline.Set_onTooltipHidden(const Value: TdxEventHandler);
begin
  FonTooltipHidden := Value;
  SetEvent('tooltipHidden', onTooltipHidden);
end;

procedure TjdxCustomSparkline.Set_onTooltipShown(const Value: TdxEventHandler);
begin
  FonTooltipShown := Value;
  SetEvent('tooltipShown', onTooltipShown);
end;

procedure TjdxCustomSparkline.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomSparkline.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomSparkline.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomSparkline.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomSparkline.dispose();
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  _instance.dispose();
end;

function TjdxCustomSparkline.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  return _instance.element();
end;

procedure TjdxCustomSparkline.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomSparkline.exportTo(fileName: string; format: string);
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  _instance.exportTo(fileName, format);
end;

procedure TjdxCustomSparkline.exportTo();
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  _instance.exportTo();
end;

function TjdxCustomSparkline.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  return _instance.getDataSource();
end;

function TjdxCustomSparkline.getSize(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  return _instance.getSize();
end;

procedure TjdxCustomSparkline.hideLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  _instance.hideLoadingIndicator();
end;

function TjdxCustomSparkline.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomSparkline.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  return _instance.off(eventName);
end;

function TjdxCustomSparkline.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  return _instance.on(events);
end;

function TjdxCustomSparkline.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  return _instance.on(eventName, eventHandler);
end;

procedure TjdxCustomSparkline.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  _instance.option(options);
end;

procedure TjdxCustomSparkline.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomSparkline.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  return _instance.option(optionName);
end;

function TjdxCustomSparkline.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  return _instance.option();
end;

procedure TjdxCustomSparkline.print();
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  _instance.print();
end;

procedure TjdxCustomSparkline.render();
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  _instance.render();
end;

procedure TjdxCustomSparkline.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomSparkline.showLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  _instance.showLoadingIndicator();
end;

function TjdxCustomSparkline.svg(): string;
asm
  const _instance = $(this.GetJQID()).dxSparkline("instance");
  return _instance.svg();
end;

end.
