unit DevExtreme.LinearGauge.Custom;

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
  DevExtreme.LinearGauge.JS,
  DevExtreme.Types;

type
  TjdxCustomLinearGauge = class(TjdxCustomControl)
  private
    Fanimation: TJSObject;
    FcontainerBackgroundColor: string;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    Fgeometry: TJSObject;
    Fheight_: JSValue;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    FpathModified: boolean;
    FrangeContainer: TJSObject;
    FredrawOnResize: boolean;
    FrtlEnabled: boolean;
    Fscale: TJSObject;
    Fsize: TJSObject;
    FsubvalueIndicator: TJSObject;
    Fsubvalues: TJSArray;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    Fvalue: integer;
    FvalueIndicator: TJSObject;
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
    procedure Set_containerBackgroundColor(const value: string);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_geometry(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_pathModified(const value: boolean);
    procedure Set_rangeContainer(const value: TJSObject);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scale(const value: TJSObject);
    procedure Set_size(const value: TJSObject);
    procedure Set_subvalueIndicator(const value: TJSObject);
    procedure Set_subvalues(const value: TJSArray);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_value(const value: integer);
    procedure Set_valueIndicator(const value: TJSObject);
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
    function getInstance(element: TJSObject): TdxLinearGauge; assembler;
    function instance: TdxLinearGauge; assembler;
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
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure print(); assembler;
    procedure render(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure showLoadingIndicator(); assembler;
    procedure subvalues_(subvalues: TJSArray); assembler; overload;
    function subvalues_(): TJSArray; assembler; overload;
    function svg(): string; assembler;
    procedure value_(value: integer); assembler; overload;
    function value_(): integer; assembler; overload;
  public
    property animation: TJSObject read Fanimation write Set_animation;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property geometry: TJSObject read Fgeometry write Set_geometry;
    property height_: JSValue read Fheight_ write Set_height_;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property rangeContainer: TJSObject read FrangeContainer write Set_rangeContainer;
    property scale: TJSObject read Fscale write Set_scale;
    property size: TJSObject read Fsize write Set_size;
    property subvalueIndicator: TJSObject read FsubvalueIndicator write Set_subvalueIndicator;
    property subvalues: TJSArray read Fsubvalues write Set_subvalues;
    property theme: JSValue read Ftheme write Set_theme;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property valueIndicator: TJSObject read FvalueIndicator write Set_valueIndicator;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property containerBackgroundColor: string read FcontainerBackgroundColor write Set_containerBackgroundColor;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property value: integer read Fvalue write Set_value;
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


procedure TjdxCustomLinearGauge.CreateInitialize;
begin
  inherited;
  Fanimation := TJSObject.new;
  FcontainerBackgroundColor := '';
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  Fgeometry := TJSObject.new;
  Fheight_ := nil;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  FpathModified := false;
  FrangeContainer := TJSObject.new;
  FredrawOnResize := true;
  FrtlEnabled := false;
  Fscale := TJSObject.new;
  Fsize := TJSObject.new;
  FsubvalueIndicator := TJSObject.new;
  Fsubvalues := TJSArray.new;
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  Fvalue := 0;
  FvalueIndicator := TJSObject.new;
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
procedure TjdxCustomLinearGauge.InitJQuery;
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
      $(id).dxLinearGauge(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomLinearGauge.getInstance(element: TJSObject): TdxLinearGauge;
asm
  return DevExpress.viz.dxLinearGauge.getInstance(element);
end;

function TjdxCustomLinearGauge.instance: TdxLinearGauge;
asm
  return $(this.GetJQID()).dxLinearGauge("instance");
end;
procedure TjdxCustomLinearGauge.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('animation', animation);
    SetOption('containerBackgroundColor', containerBackgroundColor);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('export', export);
    SetOption('geometry', geometry);
    SetOption('height', height_);
    SetOption('loadingIndicator', loadingIndicator);
    SetOption('margin', margin);
    SetOption('pathModified', pathModified);
    SetOption('rangeContainer', rangeContainer);
    SetOption('redrawOnResize', redrawOnResize);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('scale', scale);
    SetOption('size', size);
    SetOption('subvalueIndicator', subvalueIndicator);
    SetOption('subvalues', subvalues);
    SetOption('theme', theme);
    SetOption('title', title);
    SetOption('tooltip', tooltip);
    SetOption('value', value);
    SetOption('valueIndicator', valueIndicator);
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

procedure TjdxCustomLinearGauge.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
  SetOption('animation', animation);
end;

procedure TjdxCustomLinearGauge.Set_containerBackgroundColor(const Value: string);
begin
  FcontainerBackgroundColor := Value;
  SetOption('containerBackgroundColor', containerBackgroundColor);
end;

procedure TjdxCustomLinearGauge.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomLinearGauge.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomLinearGauge.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
  SetOption('export', export);
end;

procedure TjdxCustomLinearGauge.Set_geometry(const Value: TJSObject);
begin
  Fgeometry := Value;
  SetOption('geometry', geometry);
end;

procedure TjdxCustomLinearGauge.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomLinearGauge.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
  SetOption('loadingIndicator', loadingIndicator);
end;

procedure TjdxCustomLinearGauge.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
  SetOption('margin', margin);
end;

procedure TjdxCustomLinearGauge.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
  SetOption('pathModified', pathModified);
end;

procedure TjdxCustomLinearGauge.Set_rangeContainer(const Value: TJSObject);
begin
  FrangeContainer := Value;
  SetOption('rangeContainer', rangeContainer);
end;

procedure TjdxCustomLinearGauge.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
  SetOption('redrawOnResize', redrawOnResize);
end;

procedure TjdxCustomLinearGauge.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomLinearGauge.Set_scale(const Value: TJSObject);
begin
  Fscale := Value;
  SetOption('scale', scale);
end;

procedure TjdxCustomLinearGauge.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
  SetOption('size', size);
end;

procedure TjdxCustomLinearGauge.Set_subvalueIndicator(const Value: TJSObject);
begin
  FsubvalueIndicator := Value;
  SetOption('subvalueIndicator', subvalueIndicator);
end;

procedure TjdxCustomLinearGauge.Set_subvalues(const Value: TJSArray);
begin
  Fsubvalues := Value;
  SetOption('subvalues', subvalues);
end;

procedure TjdxCustomLinearGauge.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
  SetOption('theme', theme);
end;

procedure TjdxCustomLinearGauge.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
  SetOption('title', title);
end;

procedure TjdxCustomLinearGauge.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
  SetOption('tooltip', tooltip);
end;

procedure TjdxCustomLinearGauge.Set_value(const Value: integer);
begin
  Fvalue := Value;
  SetOption('value', value);
end;

procedure TjdxCustomLinearGauge.Set_valueIndicator(const Value: TJSObject);
begin
  FvalueIndicator := Value;
  SetOption('valueIndicator', valueIndicator);
end;

procedure TjdxCustomLinearGauge.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomLinearGauge.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomLinearGauge.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
  SetEvent('drawn', onDrawn);
end;

procedure TjdxCustomLinearGauge.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
  SetEvent('exported', onExported);
end;

procedure TjdxCustomLinearGauge.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
  SetEvent('exporting', onExporting);
end;

procedure TjdxCustomLinearGauge.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
  SetEvent('fileSaving', onFileSaving);
end;

procedure TjdxCustomLinearGauge.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
  SetEvent('incidentOccurred', onIncidentOccurred);
end;

procedure TjdxCustomLinearGauge.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomLinearGauge.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomLinearGauge.Set_onTooltipHidden(const Value: TdxEventHandler);
begin
  FonTooltipHidden := Value;
  SetEvent('tooltipHidden', onTooltipHidden);
end;

procedure TjdxCustomLinearGauge.Set_onTooltipShown(const Value: TdxEventHandler);
begin
  FonTooltipShown := Value;
  SetEvent('tooltipShown', onTooltipShown);
end;

procedure TjdxCustomLinearGauge.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomLinearGauge.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomLinearGauge.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomLinearGauge.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomLinearGauge.dispose();
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  _instance.dispose();
end;

function TjdxCustomLinearGauge.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  return _instance.element();
end;

procedure TjdxCustomLinearGauge.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomLinearGauge.exportTo(fileName: string; format: string);
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  _instance.exportTo(fileName, format);
end;

function TjdxCustomLinearGauge.getSize(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  return _instance.getSize();
end;

procedure TjdxCustomLinearGauge.hideLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  _instance.hideLoadingIndicator();
end;

function TjdxCustomLinearGauge.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  return _instance.off(eventName);
end;

function TjdxCustomLinearGauge.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomLinearGauge.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  return _instance.on(events);
end;

function TjdxCustomLinearGauge.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  return _instance.on(eventName, eventHandler);
end;

procedure TjdxCustomLinearGauge.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomLinearGauge.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomLinearGauge.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  _instance.option(options);
end;

function TjdxCustomLinearGauge.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  return _instance.option();
end;

procedure TjdxCustomLinearGauge.print();
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  _instance.print();
end;

procedure TjdxCustomLinearGauge.render();
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  _instance.render();
end;

procedure TjdxCustomLinearGauge.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomLinearGauge.showLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  _instance.showLoadingIndicator();
end;

procedure TjdxCustomLinearGauge.subvalues_(subvalues: TJSArray);
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  _instance.subvalues(subvalues);
end;

function TjdxCustomLinearGauge.subvalues_(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  return _instance.subvalues();
end;

function TjdxCustomLinearGauge.svg(): string;
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  return _instance.svg();
end;

procedure TjdxCustomLinearGauge.value_(value: integer);
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  _instance.value(value);
end;

function TjdxCustomLinearGauge.value_(): integer;
asm
  const _instance = $(this.GetJQID()).dxLinearGauge("instance");
  return _instance.value();
end;

end.
