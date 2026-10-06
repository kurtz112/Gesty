unit DevExtreme.Funnel.Custom;

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
  DevExtreme.Funnel.JS,
  DevExtreme.Types;

type
  TjdxCustomFunnel = class(TjdxCustomControl)
  private
    FadaptiveLayout: TJSObject;
    Falgorithm: TdxFunnelAlgorithm;
    FargumentField: string;
    FcolorField: string;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    Fheight_: JSValue;
    FhoverEnabled: boolean;
    Finverted: boolean;
    Fitem: TJSObject;
    Flabel_: TJSObject;
    Flegend: TJSObject;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    FneckHeight: integer;
    FneckWidth: integer;
    Fpalette: JSValue;
    FpaletteExtensionMode: JSValue;
    FpathModified: boolean;
    FredrawOnResize: boolean;
    FresolveLabelOverlapping: JSValue;
    FrtlEnabled: boolean;
    FselectionMode: TdxSingleMultipleOrNone;
    Fsize: TJSObject;
    FsortData: boolean;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    FvalueField: string;
    Fwidth_: JSValue;
  private
    FonDisposing: TdxEventHandler;
    FonDrawn: TdxEventHandler;
    FonExported: TdxEventHandler;
    FonExporting: TdxEventHandler;
    FonFileSaving: TdxEventHandler;
    FonHoverChanged: TdxEventHandler;
    FonIncidentOccurred: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonItemClick: TdxEventHandler;
    FonLegendClick: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
  private
    procedure Set_adaptiveLayout(const value: TJSObject);
    procedure Set_algorithm(const value: TdxFunnelAlgorithm);
    procedure Set_argumentField(const value: string);
    procedure Set_colorField(const value: string);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_hoverEnabled(const value: boolean);
    procedure Set_inverted(const value: boolean);
    procedure Set_item(const value: TJSObject);
    procedure Set_label_(const value: TJSObject);
    procedure Set_legend(const value: TJSObject);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_neckHeight(const value: integer);
    procedure Set_neckWidth(const value: integer);
    procedure Set_palette(const value: JSValue);
    procedure Set_paletteExtensionMode(const value: JSValue);
    procedure Set_pathModified(const value: boolean);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_resolveLabelOverlapping(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_selectionMode(const value: TdxSingleMultipleOrNone);
    procedure Set_size(const value: TJSObject);
    procedure Set_sortData(const value: boolean);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_valueField(const value: string);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onDrawn(const value: TdxEventHandler);
    procedure Set_onExported(const value: TdxEventHandler);
    procedure Set_onExporting(const value: TdxEventHandler);
    procedure Set_onFileSaving(const value: TdxEventHandler);
    procedure Set_onHoverChanged(const value: TdxEventHandler);
    procedure Set_onIncidentOccurred(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onItemClick(const value: TdxEventHandler);
    procedure Set_onLegendClick(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxFunnel; assembler;
    function instance: TdxFunnel; assembler;
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
    function getAllItems(): TJSArray; assembler;
    function getDataSource(): TJSObject; assembler;
    function getSize(): JSValue; assembler;
    procedure hideLoadingIndicator(); assembler;
    procedure hideTooltip(); assembler;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure print(); assembler;
    procedure render(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure showLoadingIndicator(); assembler;
    function svg(): string; assembler;
  public
    property adaptiveLayout: TJSObject read FadaptiveLayout write Set_adaptiveLayout;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property height_: JSValue read Fheight_ write Set_height_;
    property item: TJSObject read Fitem write Set_item;
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
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property algorithm: TdxFunnelAlgorithm read Falgorithm write Set_algorithm default faDynamicSlope;
    property argumentField: string read FargumentField write Set_argumentField;
    property colorField: string read FcolorField write Set_colorField;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property hoverEnabled: boolean read FhoverEnabled write Set_hoverEnabled default true;
    property inverted: boolean read Finverted write Set_inverted default false;
    property neckHeight: integer read FneckHeight write Set_neckHeight;
    property neckWidth: integer read FneckWidth write Set_neckWidth;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property selectionMode: TdxSingleMultipleOrNone read FselectionMode write Set_selectionMode default smonSingle;
    property sortData: boolean read FsortData write Set_sortData default true;
    property valueField: string read FvalueField write Set_valueField;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onDrawn: TdxEventHandler read FonDrawn write Set_onDrawn;
    property onExported: TdxEventHandler read FonExported write Set_onExported;
    property onExporting: TdxEventHandler read FonExporting write Set_onExporting;
    property onFileSaving: TdxEventHandler read FonFileSaving write Set_onFileSaving;
    property onHoverChanged: TdxEventHandler read FonHoverChanged write Set_onHoverChanged;
    property onIncidentOccurred: TdxEventHandler read FonIncidentOccurred write Set_onIncidentOccurred;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onItemClick: TdxEventHandler read FonItemClick write Set_onItemClick;
    property onLegendClick: TdxEventHandler read FonLegendClick write Set_onLegendClick;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
  end;

implementation


procedure TjdxCustomFunnel.CreateInitialize;
begin
  inherited;
  FadaptiveLayout := TJSObject.new;
  Falgorithm := faDynamicSlope;
  FargumentField := '';
  FcolorField := '';
  FdataSource := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  Fheight_ := nil;
  FhoverEnabled := true;
  Finverted := false;
  Fitem := TJSObject.new;
  Flabel_ := TJSObject.new;
  Flegend := TJSObject.new;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  FneckHeight := 0;
  FneckWidth := 0;
  Fpalette := nil;
  FpaletteExtensionMode := nil;
  FpathModified := false;
  FredrawOnResize := true;
  FresolveLabelOverlapping := nil;
  FrtlEnabled := false;
  FselectionMode := smonSingle;
  Fsize := TJSObject.new;
  FsortData := true;
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  FvalueField := '';
  Fwidth_ := nil;

  FonDisposing := nil;
  FonDrawn := nil;
  FonExported := nil;
  FonExporting := nil;
  FonFileSaving := nil;
  FonHoverChanged := nil;
  FonIncidentOccurred := nil;
  FonInitialized := nil;
  FonItemClick := nil;
  FonLegendClick := nil;
  FonOptionChanged := nil;
  FonSelectionChanged := nil;
end;
procedure TjdxCustomFunnel.InitJQuery;
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
      $(id).dxFunnel(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomFunnel.getInstance(element: TJSObject): TdxFunnel;
asm
  return DevExpress.viz.dxFunnel.getInstance(element);
end;

function TjdxCustomFunnel.instance: TdxFunnel;
asm
  return $(this.GetJQID()).dxFunnel("instance");
end;
procedure TjdxCustomFunnel.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('adaptiveLayout', adaptiveLayout);
    SetOption('algorithm', algorithm.ToString());
    SetOption('argumentField', argumentField);
    SetOption('colorField', colorField);
    SetOption('dataSource', dataSource);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('export', export);
    SetOption('height', height_);
    SetOption('hoverEnabled', hoverEnabled);
    SetOption('inverted', inverted);
    SetOption('item', item);
    SetOption('label', label_);
    SetOption('legend', legend);
    SetOption('loadingIndicator', loadingIndicator);
    SetOption('margin', margin);
    SetOption('neckHeight', neckHeight);
    SetOption('neckWidth', neckWidth);
    SetOption('palette', palette);
    SetOption('paletteExtensionMode', paletteExtensionMode);
    SetOption('pathModified', pathModified);
    SetOption('redrawOnResize', redrawOnResize);
    SetOption('resolveLabelOverlapping', resolveLabelOverlapping);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('selectionMode', selectionMode.ToString());
    SetOption('size', size);
    SetOption('sortData', sortData);
    SetOption('theme', theme);
    SetOption('title', title);
    SetOption('tooltip', tooltip);
    SetOption('valueField', valueField);
    SetOption('width', width_);

    SetEvent('disposing', onDisposing);
    SetEvent('drawn', onDrawn);
    SetEvent('exported', onExported);
    SetEvent('exporting', onExporting);
    SetEvent('fileSaving', onFileSaving);
    SetEvent('hoverChanged', onHoverChanged);
    SetEvent('incidentOccurred', onIncidentOccurred);
    SetEvent('initialized', onInitialized);
    SetEvent('itemClick', onItemClick);
    SetEvent('legendClick', onLegendClick);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('selectionChanged', onSelectionChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomFunnel.Set_adaptiveLayout(const Value: TJSObject);
begin
  FadaptiveLayout := Value;
  SetOption('adaptiveLayout', adaptiveLayout);
end;

procedure TjdxCustomFunnel.Set_algorithm(const Value: TdxFunnelAlgorithm);
begin
  Falgorithm := Value;
  SetOption('algorithm', algorithm.ToString());
end;

procedure TjdxCustomFunnel.Set_argumentField(const Value: string);
begin
  FargumentField := Value;
  SetOption('argumentField', argumentField);
end;

procedure TjdxCustomFunnel.Set_colorField(const Value: string);
begin
  FcolorField := Value;
  SetOption('colorField', colorField);
end;

procedure TjdxCustomFunnel.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomFunnel.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomFunnel.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomFunnel.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
  SetOption('export', export);
end;

procedure TjdxCustomFunnel.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomFunnel.Set_hoverEnabled(const Value: boolean);
begin
  FhoverEnabled := Value;
  SetOption('hoverEnabled', hoverEnabled);
end;

procedure TjdxCustomFunnel.Set_inverted(const Value: boolean);
begin
  Finverted := Value;
  SetOption('inverted', inverted);
end;

procedure TjdxCustomFunnel.Set_item(const Value: TJSObject);
begin
  Fitem := Value;
  SetOption('item', item);
end;

procedure TjdxCustomFunnel.Set_label_(const Value: TJSObject);
begin
  Flabel_ := Value;
  SetOption('label', label_);
end;

procedure TjdxCustomFunnel.Set_legend(const Value: TJSObject);
begin
  Flegend := Value;
  SetOption('legend', legend);
end;

procedure TjdxCustomFunnel.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
  SetOption('loadingIndicator', loadingIndicator);
end;

procedure TjdxCustomFunnel.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
  SetOption('margin', margin);
end;

procedure TjdxCustomFunnel.Set_neckHeight(const Value: integer);
begin
  FneckHeight := Value;
  SetOption('neckHeight', neckHeight);
end;

procedure TjdxCustomFunnel.Set_neckWidth(const Value: integer);
begin
  FneckWidth := Value;
  SetOption('neckWidth', neckWidth);
end;

procedure TjdxCustomFunnel.Set_palette(const Value: JSValue);
begin
  Fpalette := Value;
  SetOption('palette', palette);
end;

procedure TjdxCustomFunnel.Set_paletteExtensionMode(const Value: JSValue);
begin
  FpaletteExtensionMode := Value;
  SetOption('paletteExtensionMode', paletteExtensionMode);
end;

procedure TjdxCustomFunnel.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
  SetOption('pathModified', pathModified);
end;

procedure TjdxCustomFunnel.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
  SetOption('redrawOnResize', redrawOnResize);
end;

procedure TjdxCustomFunnel.Set_resolveLabelOverlapping(const Value: JSValue);
begin
  FresolveLabelOverlapping := Value;
  SetOption('resolveLabelOverlapping', resolveLabelOverlapping);
end;

procedure TjdxCustomFunnel.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomFunnel.Set_selectionMode(const Value: TdxSingleMultipleOrNone);
begin
  FselectionMode := Value;
  SetOption('selectionMode', selectionMode.ToString());
end;

procedure TjdxCustomFunnel.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
  SetOption('size', size);
end;

procedure TjdxCustomFunnel.Set_sortData(const Value: boolean);
begin
  FsortData := Value;
  SetOption('sortData', sortData);
end;

procedure TjdxCustomFunnel.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
  SetOption('theme', theme);
end;

procedure TjdxCustomFunnel.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
  SetOption('title', title);
end;

procedure TjdxCustomFunnel.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
  SetOption('tooltip', tooltip);
end;

procedure TjdxCustomFunnel.Set_valueField(const Value: string);
begin
  FvalueField := Value;
  SetOption('valueField', valueField);
end;

procedure TjdxCustomFunnel.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomFunnel.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomFunnel.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
  SetEvent('drawn', onDrawn);
end;

procedure TjdxCustomFunnel.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
  SetEvent('exported', onExported);
end;

procedure TjdxCustomFunnel.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
  SetEvent('exporting', onExporting);
end;

procedure TjdxCustomFunnel.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
  SetEvent('fileSaving', onFileSaving);
end;

procedure TjdxCustomFunnel.Set_onHoverChanged(const Value: TdxEventHandler);
begin
  FonHoverChanged := Value;
  SetEvent('hoverChanged', onHoverChanged);
end;

procedure TjdxCustomFunnel.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
  SetEvent('incidentOccurred', onIncidentOccurred);
end;

procedure TjdxCustomFunnel.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomFunnel.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
  SetEvent('itemClick', onItemClick);
end;

procedure TjdxCustomFunnel.Set_onLegendClick(const Value: TdxEventHandler);
begin
  FonLegendClick := Value;
  SetEvent('legendClick', onLegendClick);
end;

procedure TjdxCustomFunnel.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomFunnel.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomFunnel.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomFunnel.clearSelection();
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  _instance.clearSelection();
end;

procedure TjdxCustomFunnel.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomFunnel.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomFunnel.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomFunnel.dispose();
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  _instance.dispose();
end;

function TjdxCustomFunnel.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  return _instance.element();
end;

procedure TjdxCustomFunnel.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomFunnel.exportTo(fileName: string; format: string);
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  _instance.exportTo(fileName, format);
end;

function TjdxCustomFunnel.getAllItems(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  return _instance.getAllItems();
end;

function TjdxCustomFunnel.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  return _instance.getDataSource();
end;

function TjdxCustomFunnel.getSize(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  return _instance.getSize();
end;

procedure TjdxCustomFunnel.hideLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  _instance.hideLoadingIndicator();
end;

procedure TjdxCustomFunnel.hideTooltip();
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  _instance.hideTooltip();
end;

function TjdxCustomFunnel.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  return _instance.off(eventName);
end;

function TjdxCustomFunnel.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomFunnel.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomFunnel.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  return _instance.on(events);
end;

procedure TjdxCustomFunnel.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomFunnel.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  _instance.option(options);
end;

function TjdxCustomFunnel.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  return _instance.option(optionName);
end;

function TjdxCustomFunnel.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  return _instance.option();
end;

procedure TjdxCustomFunnel.print();
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  _instance.print();
end;

procedure TjdxCustomFunnel.render();
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  _instance.render();
end;

procedure TjdxCustomFunnel.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomFunnel.showLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  _instance.showLoadingIndicator();
end;

function TjdxCustomFunnel.svg(): string;
asm
  const _instance = $(this.GetJQID()).dxFunnel("instance");
  return _instance.svg();
end;

end.
