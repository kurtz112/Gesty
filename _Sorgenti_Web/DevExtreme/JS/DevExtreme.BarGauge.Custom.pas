unit DevExtreme.BarGauge.Custom;

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
  DevExtreme.BarGauge.JS,
  DevExtreme.Types;

type
  TjdxCustomBarGauge = class(TjdxCustomControl)
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
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxBarGauge; assembler;
    function instance: TdxBarGauge; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler; overload;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure exportTo(fileName: string; format: string); assembler;
    function getSize(): JSValue; assembler;
    procedure hideLoadingIndicator(); assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure print(); assembler;
    procedure render(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure showLoadingIndicator(); assembler;
    function svg(): string; assembler;
    procedure values_(values: TJSArray); assembler; overload;
    function values_(): TJSArray; assembler; overload;
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


procedure TjdxCustomBarGauge.CreateInitialize;
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
procedure TjdxCustomBarGauge.InitJQuery;
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
      $(id).dxBarGauge(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomBarGauge.getInstance(element: TJSObject): TdxBarGauge;
asm
  return DevExpress.viz.dxBarGauge.getInstance(element);
end;

function TjdxCustomBarGauge.instance: TdxBarGauge;
asm
  return $(this.GetJQID()).dxBarGauge("instance");
end;
procedure TjdxCustomBarGauge.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('animation', animation);
    SetOption('backgroundColor', backgroundColor);
    SetOption('barSpacing', barSpacing);
    SetOption('baseValue', baseValue);
    SetOption('centerTemplate', centerTemplate);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('endValue', endValue);
    SetOption('export', export);
    SetOption('geometry', geometry);
    SetOption('height', height_);
    SetOption('label', label_);
    SetOption('legend', legend);
    SetOption('loadingIndicator', loadingIndicator);
    SetOption('margin', margin);
    SetOption('palette', palette);
    SetOption('paletteExtensionMode', paletteExtensionMode);
    SetOption('pathModified', pathModified);
    SetOption('redrawOnResize', redrawOnResize);
    SetOption('relativeInnerRadius', relativeInnerRadius);
    SetOption('resolveLabelOverlapping', resolveLabelOverlapping);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('size', size);
    SetOption('startValue', startValue);
    SetOption('theme', theme);
    SetOption('title', title);
    SetOption('tooltip', tooltip);
    SetOption('values', values);
    SetOption('width', width_);

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

procedure TjdxCustomBarGauge.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
  SetOption('animation', animation);
end;

procedure TjdxCustomBarGauge.Set_backgroundColor(const Value: string);
begin
  FbackgroundColor := Value;
  SetOption('backgroundColor', backgroundColor);
end;

procedure TjdxCustomBarGauge.Set_barSpacing(const Value: integer);
begin
  FbarSpacing := Value;
  SetOption('barSpacing', barSpacing);
end;

procedure TjdxCustomBarGauge.Set_baseValue(const Value: integer);
begin
  FbaseValue := Value;
  SetOption('baseValue', baseValue);
end;

procedure TjdxCustomBarGauge.Set_centerTemplate(const Value: JSValue);
begin
  FcenterTemplate := Value;
  SetOption('centerTemplate', centerTemplate);
end;

procedure TjdxCustomBarGauge.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomBarGauge.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomBarGauge.Set_endValue(const Value: integer);
begin
  FendValue := Value;
  SetOption('endValue', endValue);
end;

procedure TjdxCustomBarGauge.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
  SetOption('export', export);
end;

procedure TjdxCustomBarGauge.Set_geometry(const Value: TJSObject);
begin
  Fgeometry := Value;
  SetOption('geometry', geometry);
end;

procedure TjdxCustomBarGauge.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomBarGauge.Set_label_(const Value: TJSObject);
begin
  Flabel_ := Value;
  SetOption('label', label_);
end;

procedure TjdxCustomBarGauge.Set_legend(const Value: TJSObject);
begin
  Flegend := Value;
  SetOption('legend', legend);
end;

procedure TjdxCustomBarGauge.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
  SetOption('loadingIndicator', loadingIndicator);
end;

procedure TjdxCustomBarGauge.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
  SetOption('margin', margin);
end;

procedure TjdxCustomBarGauge.Set_palette(const Value: JSValue);
begin
  Fpalette := Value;
  SetOption('palette', palette);
end;

procedure TjdxCustomBarGauge.Set_paletteExtensionMode(const Value: JSValue);
begin
  FpaletteExtensionMode := Value;
  SetOption('paletteExtensionMode', paletteExtensionMode);
end;

procedure TjdxCustomBarGauge.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
  SetOption('pathModified', pathModified);
end;

procedure TjdxCustomBarGauge.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
  SetOption('redrawOnResize', redrawOnResize);
end;

procedure TjdxCustomBarGauge.Set_relativeInnerRadius(const Value: integer);
begin
  FrelativeInnerRadius := Value;
  SetOption('relativeInnerRadius', relativeInnerRadius);
end;

procedure TjdxCustomBarGauge.Set_resolveLabelOverlapping(const Value: JSValue);
begin
  FresolveLabelOverlapping := Value;
  SetOption('resolveLabelOverlapping', resolveLabelOverlapping);
end;

procedure TjdxCustomBarGauge.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomBarGauge.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
  SetOption('size', size);
end;

procedure TjdxCustomBarGauge.Set_startValue(const Value: integer);
begin
  FstartValue := Value;
  SetOption('startValue', startValue);
end;

procedure TjdxCustomBarGauge.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
  SetOption('theme', theme);
end;

procedure TjdxCustomBarGauge.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
  SetOption('title', title);
end;

procedure TjdxCustomBarGauge.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
  SetOption('tooltip', tooltip);
end;

procedure TjdxCustomBarGauge.Set_values(const Value: TJSArray);
begin
  Fvalues := Value;
  SetOption('values', values);
end;

procedure TjdxCustomBarGauge.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomBarGauge.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomBarGauge.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
  SetEvent('drawn', onDrawn);
end;

procedure TjdxCustomBarGauge.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
  SetEvent('exported', onExported);
end;

procedure TjdxCustomBarGauge.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
  SetEvent('exporting', onExporting);
end;

procedure TjdxCustomBarGauge.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
  SetEvent('fileSaving', onFileSaving);
end;

procedure TjdxCustomBarGauge.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
  SetEvent('incidentOccurred', onIncidentOccurred);
end;

procedure TjdxCustomBarGauge.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomBarGauge.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomBarGauge.Set_onTooltipHidden(const Value: TdxEventHandler);
begin
  FonTooltipHidden := Value;
  SetEvent('tooltipHidden', onTooltipHidden);
end;

procedure TjdxCustomBarGauge.Set_onTooltipShown(const Value: TdxEventHandler);
begin
  FonTooltipShown := Value;
  SetEvent('tooltipShown', onTooltipShown);
end;

procedure TjdxCustomBarGauge.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomBarGauge.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomBarGauge.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomBarGauge.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomBarGauge.dispose();
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  _instance.dispose();
end;

function TjdxCustomBarGauge.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  return _instance.element();
end;

procedure TjdxCustomBarGauge.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomBarGauge.exportTo(fileName: string; format: string);
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  _instance.exportTo(fileName, format);
end;

function TjdxCustomBarGauge.getSize(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  return _instance.getSize();
end;

procedure TjdxCustomBarGauge.hideLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  _instance.hideLoadingIndicator();
end;

function TjdxCustomBarGauge.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomBarGauge.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  return _instance.off(eventName);
end;

function TjdxCustomBarGauge.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  return _instance.on(events);
end;

function TjdxCustomBarGauge.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomBarGauge.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  return _instance.option();
end;

procedure TjdxCustomBarGauge.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomBarGauge.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomBarGauge.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  _instance.option(options);
end;

procedure TjdxCustomBarGauge.print();
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  _instance.print();
end;

procedure TjdxCustomBarGauge.render();
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  _instance.render();
end;

procedure TjdxCustomBarGauge.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomBarGauge.showLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  _instance.showLoadingIndicator();
end;

function TjdxCustomBarGauge.svg(): string;
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  return _instance.svg();
end;

procedure TjdxCustomBarGauge.values_(values: TJSArray);
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  _instance.values(values);
end;

function TjdxCustomBarGauge.values_(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxBarGauge("instance");
  return _instance.values();
end;

end.
