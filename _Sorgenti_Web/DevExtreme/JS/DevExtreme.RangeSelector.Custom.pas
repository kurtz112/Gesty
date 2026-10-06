unit DevExtreme.RangeSelector.Custom;

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
  DevExtreme.RangeSelector.JS,
  DevExtreme.Types;

type
  TjdxCustomRangeSelector = class(TjdxCustomControl)
  private
    Fbackground: TJSObject;
    Fbehavior: TJSObject;
    Fchart: TJSObject;
    FcontainerBackgroundColor: string;
    FdataSource: JSValue;
    FdataSourceField: string;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    Fheight_: JSValue;
    Findent: TJSObject;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    FpathModified: boolean;
    FredrawOnResize: boolean;
    FrtlEnabled: boolean;
    Fscale: TJSObject;
    FselectedRangeColor: string;
    FselectedRangeUpdateMode: JSValue;
    Fshutter: TJSObject;
    Fsize: TJSObject;
    FsliderHandle: TJSObject;
    FsliderMarker: TJSObject;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    Fvalue: TJSArray;
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
    FonValueChanged: TdxEventHandler;
  private
    procedure Set_background(const value: TJSObject);
    procedure Set_behavior(const value: TJSObject);
    procedure Set_chart(const value: TJSObject);
    procedure Set_containerBackgroundColor(const value: string);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_dataSourceField(const value: string);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_indent(const value: TJSObject);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_pathModified(const value: boolean);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scale(const value: TJSObject);
    procedure Set_selectedRangeColor(const value: string);
    procedure Set_selectedRangeUpdateMode(const value: JSValue);
    procedure Set_shutter(const value: TJSObject);
    procedure Set_size(const value: TJSObject);
    procedure Set_sliderHandle(const value: TJSObject);
    procedure Set_sliderMarker(const value: TJSObject);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_value(const value: TJSArray);
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
    procedure Set_onValueChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxRangeSelector; assembler;
    function instance: TdxRangeSelector; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler; overload;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure exportTo(fileName: string; format: string); assembler;
    function getDataSource(): TJSObject; assembler;
    function getSize(): JSValue; assembler;
    function getValue(): TJSArray; assembler;
    procedure hideLoadingIndicator(); assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure print(); assembler;
    procedure render(skipChartAnimation: boolean); assembler; overload;
    procedure render(); assembler; overload;
    procedure resetOption(optionName: string); assembler;
    procedure setValue(value: JSValue); assembler;
    procedure showLoadingIndicator(); assembler;
    function svg(): string; assembler;
  public
    property background: TJSObject read Fbackground write Set_background;
    property behavior: TJSObject read Fbehavior write Set_behavior;
    property chart: TJSObject read Fchart write Set_chart;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property height_: JSValue read Fheight_ write Set_height_;
    property indent: TJSObject read Findent write Set_indent;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property scale: TJSObject read Fscale write Set_scale;
    property selectedRangeUpdateMode: JSValue read FselectedRangeUpdateMode write Set_selectedRangeUpdateMode;
    property shutter: TJSObject read Fshutter write Set_shutter;
    property size: TJSObject read Fsize write Set_size;
    property sliderHandle: TJSObject read FsliderHandle write Set_sliderHandle;
    property sliderMarker: TJSObject read FsliderMarker write Set_sliderMarker;
    property theme: JSValue read Ftheme write Set_theme;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property value: TJSArray read Fvalue write Set_value;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property containerBackgroundColor: string read FcontainerBackgroundColor write Set_containerBackgroundColor;
    property dataSourceField: string read FdataSourceField write Set_dataSourceField;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property selectedRangeColor: string read FselectedRangeColor write Set_selectedRangeColor;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onDrawn: TdxEventHandler read FonDrawn write Set_onDrawn;
    property onExported: TdxEventHandler read FonExported write Set_onExported;
    property onExporting: TdxEventHandler read FonExporting write Set_onExporting;
    property onFileSaving: TdxEventHandler read FonFileSaving write Set_onFileSaving;
    property onIncidentOccurred: TdxEventHandler read FonIncidentOccurred write Set_onIncidentOccurred;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onValueChanged: TdxEventHandler read FonValueChanged write Set_onValueChanged;
  end;

implementation


procedure TjdxCustomRangeSelector.CreateInitialize;
begin
  inherited;
  Fbackground := TJSObject.new;
  Fbehavior := TJSObject.new;
  Fchart := TJSObject.new;
  FcontainerBackgroundColor := '';
  FdataSource := nil;
  FdataSourceField := '';
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  Fheight_ := nil;
  Findent := TJSObject.new;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  FpathModified := false;
  FredrawOnResize := true;
  FrtlEnabled := false;
  Fscale := TJSObject.new;
  FselectedRangeColor := '';
  FselectedRangeUpdateMode := nil;
  Fshutter := TJSObject.new;
  Fsize := TJSObject.new;
  FsliderHandle := TJSObject.new;
  FsliderMarker := TJSObject.new;
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  Fvalue := TJSArray.new;
  Fwidth_ := nil;

  FonDisposing := nil;
  FonDrawn := nil;
  FonExported := nil;
  FonExporting := nil;
  FonFileSaving := nil;
  FonIncidentOccurred := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonValueChanged := nil;
end;
procedure TjdxCustomRangeSelector.InitJQuery;
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
      $(id).dxRangeSelector(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomRangeSelector.getInstance(element: TJSObject): TdxRangeSelector;
asm
  return DevExpress.viz.dxRangeSelector.getInstance(element);
end;

function TjdxCustomRangeSelector.instance: TdxRangeSelector;
asm
  return $(this.GetJQID()).dxRangeSelector("instance");
end;
procedure TjdxCustomRangeSelector.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('background', background);
    SetOption('behavior', behavior);
    SetOption('chart', chart);
    SetOption('containerBackgroundColor', containerBackgroundColor);
    SetOption('dataSource', dataSource);
    SetOption('dataSourceField', dataSourceField);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('export', export);
    SetOption('height', height_);
    SetOption('indent', indent);
    SetOption('loadingIndicator', loadingIndicator);
    SetOption('margin', margin);
    SetOption('pathModified', pathModified);
    SetOption('redrawOnResize', redrawOnResize);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('scale', scale);
    SetOption('selectedRangeColor', selectedRangeColor);
    SetOption('selectedRangeUpdateMode', selectedRangeUpdateMode);
    SetOption('shutter', shutter);
    SetOption('size', size);
    SetOption('sliderHandle', sliderHandle);
    SetOption('sliderMarker', sliderMarker);
    SetOption('theme', theme);
    SetOption('title', title);
    SetOption('tooltip', tooltip);
    SetOption('value', value);
    SetOption('width', width_);

    SetEvent('disposing', onDisposing);
    SetEvent('drawn', onDrawn);
    SetEvent('exported', onExported);
    SetEvent('exporting', onExporting);
    SetEvent('fileSaving', onFileSaving);
    SetEvent('incidentOccurred', onIncidentOccurred);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('valueChanged', onValueChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomRangeSelector.Set_background(const Value: TJSObject);
begin
  Fbackground := Value;
  SetOption('background', background);
end;

procedure TjdxCustomRangeSelector.Set_behavior(const Value: TJSObject);
begin
  Fbehavior := Value;
  SetOption('behavior', behavior);
end;

procedure TjdxCustomRangeSelector.Set_chart(const Value: TJSObject);
begin
  Fchart := Value;
  SetOption('chart', chart);
end;

procedure TjdxCustomRangeSelector.Set_containerBackgroundColor(const Value: string);
begin
  FcontainerBackgroundColor := Value;
  SetOption('containerBackgroundColor', containerBackgroundColor);
end;

procedure TjdxCustomRangeSelector.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomRangeSelector.Set_dataSourceField(const Value: string);
begin
  FdataSourceField := Value;
  SetOption('dataSourceField', dataSourceField);
end;

procedure TjdxCustomRangeSelector.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomRangeSelector.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomRangeSelector.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
  SetOption('export', export);
end;

procedure TjdxCustomRangeSelector.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomRangeSelector.Set_indent(const Value: TJSObject);
begin
  Findent := Value;
  SetOption('indent', indent);
end;

procedure TjdxCustomRangeSelector.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
  SetOption('loadingIndicator', loadingIndicator);
end;

procedure TjdxCustomRangeSelector.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
  SetOption('margin', margin);
end;

procedure TjdxCustomRangeSelector.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
  SetOption('pathModified', pathModified);
end;

procedure TjdxCustomRangeSelector.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
  SetOption('redrawOnResize', redrawOnResize);
end;

procedure TjdxCustomRangeSelector.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomRangeSelector.Set_scale(const Value: TJSObject);
begin
  Fscale := Value;
  SetOption('scale', scale);
end;

procedure TjdxCustomRangeSelector.Set_selectedRangeColor(const Value: string);
begin
  FselectedRangeColor := Value;
  SetOption('selectedRangeColor', selectedRangeColor);
end;

procedure TjdxCustomRangeSelector.Set_selectedRangeUpdateMode(const Value: JSValue);
begin
  FselectedRangeUpdateMode := Value;
  SetOption('selectedRangeUpdateMode', selectedRangeUpdateMode);
end;

procedure TjdxCustomRangeSelector.Set_shutter(const Value: TJSObject);
begin
  Fshutter := Value;
  SetOption('shutter', shutter);
end;

procedure TjdxCustomRangeSelector.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
  SetOption('size', size);
end;

procedure TjdxCustomRangeSelector.Set_sliderHandle(const Value: TJSObject);
begin
  FsliderHandle := Value;
  SetOption('sliderHandle', sliderHandle);
end;

procedure TjdxCustomRangeSelector.Set_sliderMarker(const Value: TJSObject);
begin
  FsliderMarker := Value;
  SetOption('sliderMarker', sliderMarker);
end;

procedure TjdxCustomRangeSelector.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
  SetOption('theme', theme);
end;

procedure TjdxCustomRangeSelector.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
  SetOption('title', title);
end;

procedure TjdxCustomRangeSelector.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
  SetOption('tooltip', tooltip);
end;

procedure TjdxCustomRangeSelector.Set_value(const Value: TJSArray);
begin
  Fvalue := Value;
  SetOption('value', value);
end;

procedure TjdxCustomRangeSelector.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomRangeSelector.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomRangeSelector.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
  SetEvent('drawn', onDrawn);
end;

procedure TjdxCustomRangeSelector.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
  SetEvent('exported', onExported);
end;

procedure TjdxCustomRangeSelector.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
  SetEvent('exporting', onExporting);
end;

procedure TjdxCustomRangeSelector.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
  SetEvent('fileSaving', onFileSaving);
end;

procedure TjdxCustomRangeSelector.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
  SetEvent('incidentOccurred', onIncidentOccurred);
end;

procedure TjdxCustomRangeSelector.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomRangeSelector.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomRangeSelector.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
  SetEvent('valueChanged', onValueChanged);
end;

procedure TjdxCustomRangeSelector.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomRangeSelector.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomRangeSelector.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomRangeSelector.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomRangeSelector.dispose();
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  _instance.dispose();
end;

function TjdxCustomRangeSelector.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  return _instance.element();
end;

procedure TjdxCustomRangeSelector.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomRangeSelector.exportTo(fileName: string; format: string);
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  _instance.exportTo(fileName, format);
end;

function TjdxCustomRangeSelector.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  return _instance.getDataSource();
end;

function TjdxCustomRangeSelector.getSize(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  return _instance.getSize();
end;

function TjdxCustomRangeSelector.getValue(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  return _instance.getValue();
end;

procedure TjdxCustomRangeSelector.hideLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  _instance.hideLoadingIndicator();
end;

function TjdxCustomRangeSelector.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomRangeSelector.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  return _instance.off(eventName);
end;

function TjdxCustomRangeSelector.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  return _instance.on(events);
end;

function TjdxCustomRangeSelector.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomRangeSelector.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  return _instance.option(optionName);
end;

function TjdxCustomRangeSelector.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  return _instance.option();
end;

procedure TjdxCustomRangeSelector.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomRangeSelector.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  _instance.option(options);
end;

procedure TjdxCustomRangeSelector.print();
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  _instance.print();
end;

procedure TjdxCustomRangeSelector.render(skipChartAnimation: boolean);
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  _instance.render(skipChartAnimation);
end;

procedure TjdxCustomRangeSelector.render();
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  _instance.render();
end;

procedure TjdxCustomRangeSelector.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomRangeSelector.setValue(value: JSValue);
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  _instance.setValue(value);
end;

procedure TjdxCustomRangeSelector.showLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  _instance.showLoadingIndicator();
end;

function TjdxCustomRangeSelector.svg(): string;
asm
  const _instance = $(this.GetJQID()).dxRangeSelector("instance");
  return _instance.svg();
end;

end.
