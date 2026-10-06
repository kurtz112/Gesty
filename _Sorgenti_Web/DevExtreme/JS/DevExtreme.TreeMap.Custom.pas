unit DevExtreme.TreeMap.Custom;

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
  DevExtreme.TreeMap.JS,
  DevExtreme.Types;

type
  TjdxCustomTreeMap = class(TjdxCustomControl)
  private
    FchildrenField: string;
    FcolorField: string;
    Fcolorizer: TJSObject;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    Fgroup: TJSObject;
    Fheight_: JSValue;
    FhoverEnabled: boolean;
    FidField: string;
    FinteractWithGroup: boolean;
    FlabelField: string;
    FlayoutAlgorithm: JSValue;
    FlayoutDirection: TdxTreeMapLayoutDirection;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    FmaxDepth: integer;
    FparentField: string;
    FpathModified: boolean;
    FredrawOnResize: boolean;
    FrtlEnabled: boolean;
    FselectionMode: TdxSingleMultipleOrNone;
    Fsize: TJSObject;
    Ftheme: JSValue;
    Ftile: TJSObject;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    FvalueField: string;
    Fwidth_: JSValue;
  private
    FonClick: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonDrawn: TdxEventHandler;
    FonDrill: TdxEventHandler;
    FonExported: TdxEventHandler;
    FonExporting: TdxEventHandler;
    FonFileSaving: TdxEventHandler;
    FonHoverChanged: TdxEventHandler;
    FonIncidentOccurred: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonNodesInitialized: TdxEventHandler;
    FonNodesRendering: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
  private
    procedure Set_childrenField(const value: string);
    procedure Set_colorField(const value: string);
    procedure Set_colorizer(const value: TJSObject);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_group(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_hoverEnabled(const value: boolean);
    procedure Set_idField(const value: string);
    procedure Set_interactWithGroup(const value: boolean);
    procedure Set_labelField(const value: string);
    procedure Set_layoutAlgorithm(const value: JSValue);
    procedure Set_layoutDirection(const value: TdxTreeMapLayoutDirection);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_maxDepth(const value: integer);
    procedure Set_parentField(const value: string);
    procedure Set_pathModified(const value: boolean);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_selectionMode(const value: TdxSingleMultipleOrNone);
    procedure Set_size(const value: TJSObject);
    procedure Set_theme(const value: JSValue);
    procedure Set_tile(const value: TJSObject);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_valueField(const value: string);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onClick(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onDrawn(const value: TdxEventHandler);
    procedure Set_onDrill(const value: TdxEventHandler);
    procedure Set_onExported(const value: TdxEventHandler);
    procedure Set_onExporting(const value: TdxEventHandler);
    procedure Set_onFileSaving(const value: TdxEventHandler);
    procedure Set_onHoverChanged(const value: TdxEventHandler);
    procedure Set_onIncidentOccurred(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onNodesInitialized(const value: TdxEventHandler);
    procedure Set_onNodesRendering(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxTreeMap; assembler;
    function instance: TdxTreeMap; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure clearSelection(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler; overload;
    procedure dispose(); assembler;
    procedure drillUp(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure exportTo(fileName: string; format: string); assembler;
    function getCurrentNode(): JSValue; assembler;
    function getDataSource(): TJSObject; assembler;
    function getRootNode(): JSValue; assembler;
    function getSize(): JSValue; assembler;
    procedure hideLoadingIndicator(); assembler;
    procedure hideTooltip(); assembler;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    function option(): TJSObject; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure print(); assembler;
    procedure render(); assembler;
    procedure resetDrillDown(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure showLoadingIndicator(); assembler;
    function svg(): string; assembler;
  public
    property colorizer: TJSObject read Fcolorizer write Set_colorizer;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property group: TJSObject read Fgroup write Set_group;
    property height_: JSValue read Fheight_ write Set_height_;
    property layoutAlgorithm: JSValue read FlayoutAlgorithm write Set_layoutAlgorithm;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property size: TJSObject read Fsize write Set_size;
    property theme: JSValue read Ftheme write Set_theme;
    property tile: TJSObject read Ftile write Set_tile;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property childrenField: string read FchildrenField write Set_childrenField;
    property colorField: string read FcolorField write Set_colorField;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property hoverEnabled: boolean read FhoverEnabled write Set_hoverEnabled;
    property idField: string read FidField write Set_idField;
    property interactWithGroup: boolean read FinteractWithGroup write Set_interactWithGroup default false;
    property labelField: string read FlabelField write Set_labelField;
    property layoutDirection: TdxTreeMapLayoutDirection read FlayoutDirection write Set_layoutDirection default tmldLeftTopRightBottom;
    property maxDepth: integer read FmaxDepth write Set_maxDepth;
    property parentField: string read FparentField write Set_parentField;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property selectionMode: TdxSingleMultipleOrNone read FselectionMode write Set_selectionMode default smonMultiple;
    property valueField: string read FvalueField write Set_valueField;
  published
    property onClick: TdxEventHandler read FonClick write Set_onClick;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onDrawn: TdxEventHandler read FonDrawn write Set_onDrawn;
    property onDrill: TdxEventHandler read FonDrill write Set_onDrill;
    property onExported: TdxEventHandler read FonExported write Set_onExported;
    property onExporting: TdxEventHandler read FonExporting write Set_onExporting;
    property onFileSaving: TdxEventHandler read FonFileSaving write Set_onFileSaving;
    property onHoverChanged: TdxEventHandler read FonHoverChanged write Set_onHoverChanged;
    property onIncidentOccurred: TdxEventHandler read FonIncidentOccurred write Set_onIncidentOccurred;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onNodesInitialized: TdxEventHandler read FonNodesInitialized write Set_onNodesInitialized;
    property onNodesRendering: TdxEventHandler read FonNodesRendering write Set_onNodesRendering;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
  end;

implementation


procedure TjdxCustomTreeMap.CreateInitialize;
begin
  inherited;
  FchildrenField := '';
  FcolorField := '';
  Fcolorizer := TJSObject.new;
  FdataSource := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  Fgroup := TJSObject.new;
  Fheight_ := nil;
  FhoverEnabled := false;
  FidField := '';
  FinteractWithGroup := false;
  FlabelField := '';
  FlayoutAlgorithm := nil;
  FlayoutDirection := tmldLeftTopRightBottom;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  FmaxDepth := 0;
  FparentField := '';
  FpathModified := false;
  FredrawOnResize := true;
  FrtlEnabled := false;
  FselectionMode := smonMultiple;
  Fsize := TJSObject.new;
  Ftheme := nil;
  Ftile := TJSObject.new;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  FvalueField := '';
  Fwidth_ := nil;

  FonClick := nil;
  FonDisposing := nil;
  FonDrawn := nil;
  FonDrill := nil;
  FonExported := nil;
  FonExporting := nil;
  FonFileSaving := nil;
  FonHoverChanged := nil;
  FonIncidentOccurred := nil;
  FonInitialized := nil;
  FonNodesInitialized := nil;
  FonNodesRendering := nil;
  FonOptionChanged := nil;
  FonSelectionChanged := nil;
end;
procedure TjdxCustomTreeMap.InitJQuery;
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
      $(id).dxTreeMap(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomTreeMap.getInstance(element: TJSObject): TdxTreeMap;
asm
  return DevExpress.viz.dxTreeMap.getInstance(element);
end;

function TjdxCustomTreeMap.instance: TdxTreeMap;
asm
  return $(this.GetJQID()).dxTreeMap("instance");
end;
procedure TjdxCustomTreeMap.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('childrenField', childrenField);
    SetOption('colorField', colorField);
    SetOption('colorizer', colorizer);
    SetOption('dataSource', dataSource);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('export', export);
    SetOption('group', group);
    SetOption('height', height_);
    SetOption('hoverEnabled', hoverEnabled);
    SetOption('idField', idField);
    SetOption('interactWithGroup', interactWithGroup);
    SetOption('labelField', labelField);
    SetOption('layoutAlgorithm', layoutAlgorithm);
    SetOption('layoutDirection', layoutDirection.ToString());
    SetOption('loadingIndicator', loadingIndicator);
    SetOption('margin', margin);
    SetOption('maxDepth', maxDepth);
    SetOption('parentField', parentField);
    SetOption('pathModified', pathModified);
    SetOption('redrawOnResize', redrawOnResize);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('selectionMode', selectionMode.ToString());
    SetOption('size', size);
    SetOption('theme', theme);
    SetOption('tile', tile);
    SetOption('title', title);
    SetOption('tooltip', tooltip);
    SetOption('valueField', valueField);
    SetOption('width', width_);

    SetEvent('click', onClick);
    SetEvent('disposing', onDisposing);
    SetEvent('drawn', onDrawn);
    SetEvent('drill', onDrill);
    SetEvent('exported', onExported);
    SetEvent('exporting', onExporting);
    SetEvent('fileSaving', onFileSaving);
    SetEvent('hoverChanged', onHoverChanged);
    SetEvent('incidentOccurred', onIncidentOccurred);
    SetEvent('initialized', onInitialized);
    SetEvent('nodesInitialized', onNodesInitialized);
    SetEvent('nodesRendering', onNodesRendering);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('selectionChanged', onSelectionChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomTreeMap.Set_childrenField(const Value: string);
begin
  FchildrenField := Value;
  SetOption('childrenField', childrenField);
end;

procedure TjdxCustomTreeMap.Set_colorField(const Value: string);
begin
  FcolorField := Value;
  SetOption('colorField', colorField);
end;

procedure TjdxCustomTreeMap.Set_colorizer(const Value: TJSObject);
begin
  Fcolorizer := Value;
  SetOption('colorizer', colorizer);
end;

procedure TjdxCustomTreeMap.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomTreeMap.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomTreeMap.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomTreeMap.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
  SetOption('export', export);
end;

procedure TjdxCustomTreeMap.Set_group(const Value: TJSObject);
begin
  Fgroup := Value;
  SetOption('group', group);
end;

procedure TjdxCustomTreeMap.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomTreeMap.Set_hoverEnabled(const Value: boolean);
begin
  FhoverEnabled := Value;
  SetOption('hoverEnabled', hoverEnabled);
end;

procedure TjdxCustomTreeMap.Set_idField(const Value: string);
begin
  FidField := Value;
  SetOption('idField', idField);
end;

procedure TjdxCustomTreeMap.Set_interactWithGroup(const Value: boolean);
begin
  FinteractWithGroup := Value;
  SetOption('interactWithGroup', interactWithGroup);
end;

procedure TjdxCustomTreeMap.Set_labelField(const Value: string);
begin
  FlabelField := Value;
  SetOption('labelField', labelField);
end;

procedure TjdxCustomTreeMap.Set_layoutAlgorithm(const Value: JSValue);
begin
  FlayoutAlgorithm := Value;
  SetOption('layoutAlgorithm', layoutAlgorithm);
end;

procedure TjdxCustomTreeMap.Set_layoutDirection(const Value: TdxTreeMapLayoutDirection);
begin
  FlayoutDirection := Value;
  SetOption('layoutDirection', layoutDirection.ToString());
end;

procedure TjdxCustomTreeMap.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
  SetOption('loadingIndicator', loadingIndicator);
end;

procedure TjdxCustomTreeMap.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
  SetOption('margin', margin);
end;

procedure TjdxCustomTreeMap.Set_maxDepth(const Value: integer);
begin
  FmaxDepth := Value;
  SetOption('maxDepth', maxDepth);
end;

procedure TjdxCustomTreeMap.Set_parentField(const Value: string);
begin
  FparentField := Value;
  SetOption('parentField', parentField);
end;

procedure TjdxCustomTreeMap.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
  SetOption('pathModified', pathModified);
end;

procedure TjdxCustomTreeMap.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
  SetOption('redrawOnResize', redrawOnResize);
end;

procedure TjdxCustomTreeMap.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomTreeMap.Set_selectionMode(const Value: TdxSingleMultipleOrNone);
begin
  FselectionMode := Value;
  SetOption('selectionMode', selectionMode.ToString());
end;

procedure TjdxCustomTreeMap.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
  SetOption('size', size);
end;

procedure TjdxCustomTreeMap.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
  SetOption('theme', theme);
end;

procedure TjdxCustomTreeMap.Set_tile(const Value: TJSObject);
begin
  Ftile := Value;
  SetOption('tile', tile);
end;

procedure TjdxCustomTreeMap.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
  SetOption('title', title);
end;

procedure TjdxCustomTreeMap.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
  SetOption('tooltip', tooltip);
end;

procedure TjdxCustomTreeMap.Set_valueField(const Value: string);
begin
  FvalueField := Value;
  SetOption('valueField', valueField);
end;

procedure TjdxCustomTreeMap.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomTreeMap.Set_onClick(const Value: TdxEventHandler);
begin
  FonClick := Value;
  SetEvent('click', onClick);
end;

procedure TjdxCustomTreeMap.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomTreeMap.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
  SetEvent('drawn', onDrawn);
end;

procedure TjdxCustomTreeMap.Set_onDrill(const Value: TdxEventHandler);
begin
  FonDrill := Value;
  SetEvent('drill', onDrill);
end;

procedure TjdxCustomTreeMap.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
  SetEvent('exported', onExported);
end;

procedure TjdxCustomTreeMap.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
  SetEvent('exporting', onExporting);
end;

procedure TjdxCustomTreeMap.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
  SetEvent('fileSaving', onFileSaving);
end;

procedure TjdxCustomTreeMap.Set_onHoverChanged(const Value: TdxEventHandler);
begin
  FonHoverChanged := Value;
  SetEvent('hoverChanged', onHoverChanged);
end;

procedure TjdxCustomTreeMap.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
  SetEvent('incidentOccurred', onIncidentOccurred);
end;

procedure TjdxCustomTreeMap.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomTreeMap.Set_onNodesInitialized(const Value: TdxEventHandler);
begin
  FonNodesInitialized := Value;
  SetEvent('nodesInitialized', onNodesInitialized);
end;

procedure TjdxCustomTreeMap.Set_onNodesRendering(const Value: TdxEventHandler);
begin
  FonNodesRendering := Value;
  SetEvent('nodesRendering', onNodesRendering);
end;

procedure TjdxCustomTreeMap.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomTreeMap.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomTreeMap.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomTreeMap.clearSelection();
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.clearSelection();
end;

procedure TjdxCustomTreeMap.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomTreeMap.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomTreeMap.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomTreeMap.dispose();
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.dispose();
end;

procedure TjdxCustomTreeMap.drillUp();
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.drillUp();
end;

function TjdxCustomTreeMap.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  return _instance.element();
end;

procedure TjdxCustomTreeMap.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomTreeMap.exportTo(fileName: string; format: string);
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.exportTo(fileName, format);
end;

function TjdxCustomTreeMap.getCurrentNode(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  return _instance.getCurrentNode();
end;

function TjdxCustomTreeMap.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  return _instance.getDataSource();
end;

function TjdxCustomTreeMap.getRootNode(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  return _instance.getRootNode();
end;

function TjdxCustomTreeMap.getSize(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  return _instance.getSize();
end;

procedure TjdxCustomTreeMap.hideLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.hideLoadingIndicator();
end;

procedure TjdxCustomTreeMap.hideTooltip();
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.hideTooltip();
end;

function TjdxCustomTreeMap.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  return _instance.off(eventName);
end;

function TjdxCustomTreeMap.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomTreeMap.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  return _instance.on(events);
end;

function TjdxCustomTreeMap.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  return _instance.on(eventName, eventHandler);
end;

procedure TjdxCustomTreeMap.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomTreeMap.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.option(options);
end;

function TjdxCustomTreeMap.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  return _instance.option();
end;

function TjdxCustomTreeMap.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomTreeMap.print();
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.print();
end;

procedure TjdxCustomTreeMap.render();
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.render();
end;

procedure TjdxCustomTreeMap.resetDrillDown();
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.resetDrillDown();
end;

procedure TjdxCustomTreeMap.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomTreeMap.showLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  _instance.showLoadingIndicator();
end;

function TjdxCustomTreeMap.svg(): string;
asm
  const _instance = $(this.GetJQID()).dxTreeMap("instance");
  return _instance.svg();
end;

end.
