unit DevExtreme.Bullet.Custom;

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
  DevExtreme.Bullet.JS,
  DevExtreme.Types;

type
  TjdxCustomBullet = class(TjdxCustomControl)
  private
    Fcolor: string;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FendScaleValue: integer;
    Fexport: TJSObject;
    Fheight_: JSValue;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    FpathModified: boolean;
    FredrawOnResize: boolean;
    FrtlEnabled: boolean;
    FshowTarget: boolean;
    FshowZeroLevel: boolean;
    Fsize: TJSObject;
    FstartScaleValue: integer;
    Ftarget: integer;
    FtargetColor: string;
    FtargetWidth: integer;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    Fvalue: integer;
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
    procedure Set_color(const value: string);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_endScaleValue(const value: integer);
    procedure Set_export(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_pathModified(const value: boolean);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_showTarget(const value: boolean);
    procedure Set_showZeroLevel(const value: boolean);
    procedure Set_size(const value: TJSObject);
    procedure Set_startScaleValue(const value: integer);
    procedure Set_target(const value: integer);
    procedure Set_targetColor(const value: string);
    procedure Set_targetWidth(const value: integer);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_value(const value: integer);
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
    function getInstance(element: TJSObject): TdxBullet; assembler;
    function instance: TdxBullet; assembler;
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
    function getSize(): JSValue; assembler;
    procedure hideLoadingIndicator(); assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function option(): TJSObject; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure print(); assembler;
    procedure render(); assembler; overload;
    procedure resetOption(optionName: string); assembler;
    procedure showLoadingIndicator(); assembler; overload;
    function svg(): string; assembler;
  public
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property height_: JSValue read Fheight_ write Set_height_;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property size: TJSObject read Fsize write Set_size;
    property theme: JSValue read Ftheme write Set_theme;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property color: string read Fcolor write Set_color;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property endScaleValue: integer read FendScaleValue write Set_endScaleValue;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showTarget: boolean read FshowTarget write Set_showTarget default true;
    property showZeroLevel: boolean read FshowZeroLevel write Set_showZeroLevel default true;
    property startScaleValue: integer read FstartScaleValue write Set_startScaleValue;
    property target: integer read Ftarget write Set_target;
    property targetColor: string read FtargetColor write Set_targetColor;
    property targetWidth: integer read FtargetWidth write Set_targetWidth;
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


procedure TjdxCustomBullet.CreateInitialize;
begin
  inherited;
  Fcolor := '';
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FendScaleValue := 0;
  Fexport := TJSObject.new;
  Fheight_ := nil;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  FpathModified := false;
  FredrawOnResize := true;
  FrtlEnabled := false;
  FshowTarget := true;
  FshowZeroLevel := true;
  Fsize := TJSObject.new;
  FstartScaleValue := 0;
  Ftarget := 0;
  FtargetColor := '';
  FtargetWidth := 0;
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  Fvalue := 0;
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
procedure TjdxCustomBullet.InitJQuery;
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
      $(id).dxBullet(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomBullet.getInstance(element: TJSObject): TdxBullet;
asm
  return DevExpress.viz.dxBullet.getInstance(element);
end;

function TjdxCustomBullet.instance: TdxBullet;
asm
  return $(this.GetJQID()).dxBullet("instance");
end;
procedure TjdxCustomBullet.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('color', color);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('endScaleValue', endScaleValue);
    SetOption('export', export);
    SetOption('height', height_);
    SetOption('loadingIndicator', loadingIndicator);
    SetOption('margin', margin);
    SetOption('pathModified', pathModified);
    SetOption('redrawOnResize', redrawOnResize);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('showTarget', showTarget);
    SetOption('showZeroLevel', showZeroLevel);
    SetOption('size', size);
    SetOption('startScaleValue', startScaleValue);
    SetOption('target', target);
    SetOption('targetColor', targetColor);
    SetOption('targetWidth', targetWidth);
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
    SetEvent('tooltipHidden', onTooltipHidden);
    SetEvent('tooltipShown', onTooltipShown);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomBullet.Set_color(const Value: string);
begin
  Fcolor := Value;
  SetOption('color', color);
end;

procedure TjdxCustomBullet.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomBullet.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomBullet.Set_endScaleValue(const Value: integer);
begin
  FendScaleValue := Value;
  SetOption('endScaleValue', endScaleValue);
end;

procedure TjdxCustomBullet.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
  SetOption('export', export);
end;

procedure TjdxCustomBullet.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomBullet.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
  SetOption('loadingIndicator', loadingIndicator);
end;

procedure TjdxCustomBullet.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
  SetOption('margin', margin);
end;

procedure TjdxCustomBullet.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
  SetOption('pathModified', pathModified);
end;

procedure TjdxCustomBullet.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
  SetOption('redrawOnResize', redrawOnResize);
end;

procedure TjdxCustomBullet.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomBullet.Set_showTarget(const Value: boolean);
begin
  FshowTarget := Value;
  SetOption('showTarget', showTarget);
end;

procedure TjdxCustomBullet.Set_showZeroLevel(const Value: boolean);
begin
  FshowZeroLevel := Value;
  SetOption('showZeroLevel', showZeroLevel);
end;

procedure TjdxCustomBullet.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
  SetOption('size', size);
end;

procedure TjdxCustomBullet.Set_startScaleValue(const Value: integer);
begin
  FstartScaleValue := Value;
  SetOption('startScaleValue', startScaleValue);
end;

procedure TjdxCustomBullet.Set_target(const Value: integer);
begin
  Ftarget := Value;
  SetOption('target', target);
end;

procedure TjdxCustomBullet.Set_targetColor(const Value: string);
begin
  FtargetColor := Value;
  SetOption('targetColor', targetColor);
end;

procedure TjdxCustomBullet.Set_targetWidth(const Value: integer);
begin
  FtargetWidth := Value;
  SetOption('targetWidth', targetWidth);
end;

procedure TjdxCustomBullet.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
  SetOption('theme', theme);
end;

procedure TjdxCustomBullet.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
  SetOption('title', title);
end;

procedure TjdxCustomBullet.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
  SetOption('tooltip', tooltip);
end;

procedure TjdxCustomBullet.Set_value(const Value: integer);
begin
  Fvalue := Value;
  SetOption('value', value);
end;

procedure TjdxCustomBullet.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomBullet.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomBullet.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
  SetEvent('drawn', onDrawn);
end;

procedure TjdxCustomBullet.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
  SetEvent('exported', onExported);
end;

procedure TjdxCustomBullet.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
  SetEvent('exporting', onExporting);
end;

procedure TjdxCustomBullet.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
  SetEvent('fileSaving', onFileSaving);
end;

procedure TjdxCustomBullet.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
  SetEvent('incidentOccurred', onIncidentOccurred);
end;

procedure TjdxCustomBullet.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomBullet.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomBullet.Set_onTooltipHidden(const Value: TdxEventHandler);
begin
  FonTooltipHidden := Value;
  SetEvent('tooltipHidden', onTooltipHidden);
end;

procedure TjdxCustomBullet.Set_onTooltipShown(const Value: TdxEventHandler);
begin
  FonTooltipShown := Value;
  SetEvent('tooltipShown', onTooltipShown);
end;

procedure TjdxCustomBullet.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomBullet.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomBullet.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomBullet.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomBullet.dispose();
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  _instance.dispose();
end;

function TjdxCustomBullet.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  return _instance.element();
end;

procedure TjdxCustomBullet.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomBullet.exportTo(fileName: string; format: string);
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  _instance.exportTo(fileName, format);
end;

procedure TjdxCustomBullet.exportTo();
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  _instance.exportTo();
end;

function TjdxCustomBullet.getSize(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  return _instance.getSize();
end;

procedure TjdxCustomBullet.hideLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  _instance.hideLoadingIndicator();
end;

function TjdxCustomBullet.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomBullet.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  return _instance.off(eventName);
end;

function TjdxCustomBullet.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomBullet.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  return _instance.on(events);
end;

function TjdxCustomBullet.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  return _instance.option();
end;

function TjdxCustomBullet.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomBullet.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomBullet.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  _instance.option(options);
end;

procedure TjdxCustomBullet.print();
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  _instance.print();
end;

procedure TjdxCustomBullet.render();
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  _instance.render();
end;

procedure TjdxCustomBullet.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomBullet.showLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  _instance.showLoadingIndicator();
end;

function TjdxCustomBullet.svg(): string;
asm
  const _instance = $(this.GetJQID()).dxBullet("instance");
  return _instance.svg();
end;

end.
