unit DevExtreme.Sankey.Custom;

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
  DevExtreme.Sankey.JS,
  DevExtreme.Types;

type
  TjdxCustomSankey = class(TjdxCustomControl)
  private
    FadaptiveLayout: TJSObject;
    Falignment: JSValue;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    Fheight_: JSValue;
    FhoverEnabled: boolean;
    Flabel_: TJSObject;
    Flink: TJSObject;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    Fnode: TJSObject;
    Fpalette: JSValue;
    FpaletteExtensionMode: JSValue;
    FpathModified: boolean;
    FredrawOnResize: boolean;
    FrtlEnabled: boolean;
    Fsize: TJSObject;
    FsortData: JSValue;
    FsourceField: string;
    FtargetField: string;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    FweightField: string;
    Fwidth_: JSValue;
  private
    FonDisposing: TdxEventHandler;
    FonDrawn: TdxEventHandler;
    FonExported: TdxEventHandler;
    FonExporting: TdxEventHandler;
    FonFileSaving: TdxEventHandler;
    FonIncidentOccurred: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonLinkClick: TdxEventHandler;
    FonLinkHoverChanged: TdxEventHandler;
    FonNodeClick: TdxEventHandler;
    FonNodeHoverChanged: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
  private
    procedure Set_adaptiveLayout(const value: TJSObject);
    procedure Set_alignment(const value: JSValue);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_hoverEnabled(const value: boolean);
    procedure Set_label_(const value: TJSObject);
    procedure Set_link(const value: TJSObject);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_node(const value: TJSObject);
    procedure Set_palette(const value: JSValue);
    procedure Set_paletteExtensionMode(const value: JSValue);
    procedure Set_pathModified(const value: boolean);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_size(const value: TJSObject);
    procedure Set_sortData(const value: JSValue);
    procedure Set_sourceField(const value: string);
    procedure Set_targetField(const value: string);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_weightField(const value: string);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onDrawn(const value: TdxEventHandler);
    procedure Set_onExported(const value: TdxEventHandler);
    procedure Set_onExporting(const value: TdxEventHandler);
    procedure Set_onFileSaving(const value: TdxEventHandler);
    procedure Set_onIncidentOccurred(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onLinkClick(const value: TdxEventHandler);
    procedure Set_onLinkHoverChanged(const value: TdxEventHandler);
    procedure Set_onNodeClick(const value: TdxEventHandler);
    procedure Set_onNodeHoverChanged(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxSankey; assembler;
    function instance: TdxSankey; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler; overload;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure exportTo(fileName: string; format: string); assembler;
    function getAllLinks(): TJSArray; assembler;
    function getAllNodes(): TJSArray; assembler;
    function getDataSource(): TJSObject; assembler;
    function getSize(): JSValue; assembler;
    procedure hideLoadingIndicator(); assembler;
    procedure hideTooltip(); assembler;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure print(); assembler;
    procedure render(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure showLoadingIndicator(); assembler;
    function svg(): string; assembler;
  public
    property adaptiveLayout: TJSObject read FadaptiveLayout write Set_adaptiveLayout;
    property alignment: JSValue read Falignment write Set_alignment;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property height_: JSValue read Fheight_ write Set_height_;
    property label_: TJSObject read Flabel_ write Set_label_;
    property link: TJSObject read Flink write Set_link;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property node: TJSObject read Fnode write Set_node;
    property palette: JSValue read Fpalette write Set_palette;
    property paletteExtensionMode: JSValue read FpaletteExtensionMode write Set_paletteExtensionMode;
    property size: TJSObject read Fsize write Set_size;
    property sortData: JSValue read FsortData write Set_sortData;
    property theme: JSValue read Ftheme write Set_theme;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property hoverEnabled: boolean read FhoverEnabled write Set_hoverEnabled default true;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property sourceField: string read FsourceField write Set_sourceField;
    property targetField: string read FtargetField write Set_targetField;
    property weightField: string read FweightField write Set_weightField;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onDrawn: TdxEventHandler read FonDrawn write Set_onDrawn;
    property onExported: TdxEventHandler read FonExported write Set_onExported;
    property onExporting: TdxEventHandler read FonExporting write Set_onExporting;
    property onFileSaving: TdxEventHandler read FonFileSaving write Set_onFileSaving;
    property onIncidentOccurred: TdxEventHandler read FonIncidentOccurred write Set_onIncidentOccurred;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onLinkClick: TdxEventHandler read FonLinkClick write Set_onLinkClick;
    property onLinkHoverChanged: TdxEventHandler read FonLinkHoverChanged write Set_onLinkHoverChanged;
    property onNodeClick: TdxEventHandler read FonNodeClick write Set_onNodeClick;
    property onNodeHoverChanged: TdxEventHandler read FonNodeHoverChanged write Set_onNodeHoverChanged;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
  end;

implementation


procedure TjdxCustomSankey.CreateInitialize;
begin
  inherited;
  FadaptiveLayout := TJSObject.new;
  Falignment := nil;
  FdataSource := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  Fheight_ := nil;
  FhoverEnabled := true;
  Flabel_ := TJSObject.new;
  Flink := TJSObject.new;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  Fnode := TJSObject.new;
  Fpalette := nil;
  FpaletteExtensionMode := nil;
  FpathModified := false;
  FredrawOnResize := true;
  FrtlEnabled := false;
  Fsize := TJSObject.new;
  FsortData := nil;
  FsourceField := '';
  FtargetField := '';
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  FweightField := '';
  Fwidth_ := nil;

  FonDisposing := nil;
  FonDrawn := nil;
  FonExported := nil;
  FonExporting := nil;
  FonFileSaving := nil;
  FonIncidentOccurred := nil;
  FonInitialized := nil;
  FonLinkClick := nil;
  FonLinkHoverChanged := nil;
  FonNodeClick := nil;
  FonNodeHoverChanged := nil;
  FonOptionChanged := nil;
end;
procedure TjdxCustomSankey.InitJQuery;
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
      $(id).dxSankey(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomSankey.getInstance(element: TJSObject): TdxSankey;
asm
  return DevExpress.viz.dxSankey.getInstance(element);
end;

function TjdxCustomSankey.instance: TdxSankey;
asm
  return $(this.GetJQID()).dxSankey("instance");
end;
procedure TjdxCustomSankey.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('adaptiveLayout', adaptiveLayout);
    SetOption('alignment', alignment);
    SetOption('dataSource', dataSource);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('export', export);
    SetOption('height', height_);
    SetOption('hoverEnabled', hoverEnabled);
    SetOption('label', label_);
    SetOption('link', link);
    SetOption('loadingIndicator', loadingIndicator);
    SetOption('margin', margin);
    SetOption('node', node);
    SetOption('palette', palette);
    SetOption('paletteExtensionMode', paletteExtensionMode);
    SetOption('pathModified', pathModified);
    SetOption('redrawOnResize', redrawOnResize);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('size', size);
    SetOption('sortData', sortData);
    SetOption('sourceField', sourceField);
    SetOption('targetField', targetField);
    SetOption('theme', theme);
    SetOption('title', title);
    SetOption('tooltip', tooltip);
    SetOption('weightField', weightField);
    SetOption('width', width_);

    SetEvent('disposing', onDisposing);
    SetEvent('drawn', onDrawn);
    SetEvent('exported', onExported);
    SetEvent('exporting', onExporting);
    SetEvent('fileSaving', onFileSaving);
    SetEvent('incidentOccurred', onIncidentOccurred);
    SetEvent('initialized', onInitialized);
    SetEvent('linkClick', onLinkClick);
    SetEvent('linkHoverChanged', onLinkHoverChanged);
    SetEvent('nodeClick', onNodeClick);
    SetEvent('nodeHoverChanged', onNodeHoverChanged);
    SetEvent('optionChanged', onOptionChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomSankey.Set_adaptiveLayout(const Value: TJSObject);
begin
  FadaptiveLayout := Value;
  SetOption('adaptiveLayout', adaptiveLayout);
end;

procedure TjdxCustomSankey.Set_alignment(const Value: JSValue);
begin
  Falignment := Value;
  SetOption('alignment', alignment);
end;

procedure TjdxCustomSankey.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomSankey.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomSankey.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomSankey.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
  SetOption('export', export);
end;

procedure TjdxCustomSankey.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomSankey.Set_hoverEnabled(const Value: boolean);
begin
  FhoverEnabled := Value;
  SetOption('hoverEnabled', hoverEnabled);
end;

procedure TjdxCustomSankey.Set_label_(const Value: TJSObject);
begin
  Flabel_ := Value;
  SetOption('label', label_);
end;

procedure TjdxCustomSankey.Set_link(const Value: TJSObject);
begin
  Flink := Value;
  SetOption('link', link);
end;

procedure TjdxCustomSankey.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
  SetOption('loadingIndicator', loadingIndicator);
end;

procedure TjdxCustomSankey.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
  SetOption('margin', margin);
end;

procedure TjdxCustomSankey.Set_node(const Value: TJSObject);
begin
  Fnode := Value;
  SetOption('node', node);
end;

procedure TjdxCustomSankey.Set_palette(const Value: JSValue);
begin
  Fpalette := Value;
  SetOption('palette', palette);
end;

procedure TjdxCustomSankey.Set_paletteExtensionMode(const Value: JSValue);
begin
  FpaletteExtensionMode := Value;
  SetOption('paletteExtensionMode', paletteExtensionMode);
end;

procedure TjdxCustomSankey.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
  SetOption('pathModified', pathModified);
end;

procedure TjdxCustomSankey.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
  SetOption('redrawOnResize', redrawOnResize);
end;

procedure TjdxCustomSankey.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomSankey.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
  SetOption('size', size);
end;

procedure TjdxCustomSankey.Set_sortData(const Value: JSValue);
begin
  FsortData := Value;
  SetOption('sortData', sortData);
end;

procedure TjdxCustomSankey.Set_sourceField(const Value: string);
begin
  FsourceField := Value;
  SetOption('sourceField', sourceField);
end;

procedure TjdxCustomSankey.Set_targetField(const Value: string);
begin
  FtargetField := Value;
  SetOption('targetField', targetField);
end;

procedure TjdxCustomSankey.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
  SetOption('theme', theme);
end;

procedure TjdxCustomSankey.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
  SetOption('title', title);
end;

procedure TjdxCustomSankey.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
  SetOption('tooltip', tooltip);
end;

procedure TjdxCustomSankey.Set_weightField(const Value: string);
begin
  FweightField := Value;
  SetOption('weightField', weightField);
end;

procedure TjdxCustomSankey.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomSankey.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomSankey.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
  SetEvent('drawn', onDrawn);
end;

procedure TjdxCustomSankey.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
  SetEvent('exported', onExported);
end;

procedure TjdxCustomSankey.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
  SetEvent('exporting', onExporting);
end;

procedure TjdxCustomSankey.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
  SetEvent('fileSaving', onFileSaving);
end;

procedure TjdxCustomSankey.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
  SetEvent('incidentOccurred', onIncidentOccurred);
end;

procedure TjdxCustomSankey.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomSankey.Set_onLinkClick(const Value: TdxEventHandler);
begin
  FonLinkClick := Value;
  SetEvent('linkClick', onLinkClick);
end;

procedure TjdxCustomSankey.Set_onLinkHoverChanged(const Value: TdxEventHandler);
begin
  FonLinkHoverChanged := Value;
  SetEvent('linkHoverChanged', onLinkHoverChanged);
end;

procedure TjdxCustomSankey.Set_onNodeClick(const Value: TdxEventHandler);
begin
  FonNodeClick := Value;
  SetEvent('nodeClick', onNodeClick);
end;

procedure TjdxCustomSankey.Set_onNodeHoverChanged(const Value: TdxEventHandler);
begin
  FonNodeHoverChanged := Value;
  SetEvent('nodeHoverChanged', onNodeHoverChanged);
end;

procedure TjdxCustomSankey.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomSankey.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomSankey.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomSankey.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomSankey.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomSankey.dispose();
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  _instance.dispose();
end;

function TjdxCustomSankey.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  return _instance.element();
end;

procedure TjdxCustomSankey.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomSankey.exportTo(fileName: string; format: string);
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  _instance.exportTo(fileName, format);
end;

function TjdxCustomSankey.getAllLinks(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  return _instance.getAllLinks();
end;

function TjdxCustomSankey.getAllNodes(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  return _instance.getAllNodes();
end;

function TjdxCustomSankey.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  return _instance.getDataSource();
end;

function TjdxCustomSankey.getSize(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  return _instance.getSize();
end;

procedure TjdxCustomSankey.hideLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  _instance.hideLoadingIndicator();
end;

procedure TjdxCustomSankey.hideTooltip();
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  _instance.hideTooltip();
end;

function TjdxCustomSankey.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  return _instance.off(eventName);
end;

function TjdxCustomSankey.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomSankey.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  return _instance.on(events);
end;

function TjdxCustomSankey.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomSankey.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomSankey.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomSankey.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  return _instance.option();
end;

procedure TjdxCustomSankey.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  _instance.option(options);
end;

procedure TjdxCustomSankey.print();
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  _instance.print();
end;

procedure TjdxCustomSankey.render();
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  _instance.render();
end;

procedure TjdxCustomSankey.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomSankey.showLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  _instance.showLoadingIndicator();
end;

function TjdxCustomSankey.svg(): string;
asm
  const _instance = $(this.GetJQID()).dxSankey("instance");
  return _instance.svg();
end;

end.
