unit DevExtreme.VectorMap.Custom;

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
  DevExtreme.VectorMap.JS,
  DevExtreme.Types;

type
  TjdxCustomVectorMap = class(TjdxCustomControl)
  private
    Fannotations: TJSArray;
    Fbackground: TJSObject;
    Fbounds: TJSArray;
    Fcenter: TJSArray;
    FcommonAnnotationSettings: TJSObject;
    FcontrolBar: TJSObject;
    FcustomizeAnnotation: TJSFunction;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    Fheight_: JSValue;
    Flayers: TJSArray;
    Flegends: TJSArray;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    FmaxZoomFactor: integer;
    FpanningEnabled: boolean;
    FpathModified: boolean;
    Fprojection: TJSObject;
    FredrawOnResize: boolean;
    FrtlEnabled: boolean;
    Fsize: TJSObject;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    FtouchEnabled: boolean;
    FwheelEnabled: boolean;
    Fwidth_: JSValue;
    FzoomFactor: integer;
    FzoomingEnabled: boolean;
  private
    FonCenterChanged: TdxEventHandler;
    FonClick: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonDrawn: TdxEventHandler;
    FonExported: TdxEventHandler;
    FonExporting: TdxEventHandler;
    FonFileSaving: TdxEventHandler;
    FonIncidentOccurred: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
    FonTooltipHidden: TdxEventHandler;
    FonTooltipShown: TdxEventHandler;
    FonZoomFactorChanged: TdxEventHandler;
  private
    procedure Set_annotations(const value: TJSArray);
    procedure Set_background(const value: TJSObject);
    procedure Set_bounds(const value: TJSArray);
    procedure Set_center(const value: TJSArray);
    procedure Set_commonAnnotationSettings(const value: TJSObject);
    procedure Set_controlBar(const value: TJSObject);
    procedure Set_customizeAnnotation(const value: TJSFunction);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_layers(const value: TJSArray);
    procedure Set_legends(const value: TJSArray);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_maxZoomFactor(const value: integer);
    procedure Set_panningEnabled(const value: boolean);
    procedure Set_pathModified(const value: boolean);
    procedure Set_projection(const value: TJSObject);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_size(const value: TJSObject);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_touchEnabled(const value: boolean);
    procedure Set_wheelEnabled(const value: boolean);
    procedure Set_width_(const value: JSValue);
    procedure Set_zoomFactor(const value: integer);
    procedure Set_zoomingEnabled(const value: boolean);
  private
    procedure Set_onCenterChanged(const value: TdxEventHandler);
    procedure Set_onClick(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onDrawn(const value: TdxEventHandler);
    procedure Set_onExported(const value: TdxEventHandler);
    procedure Set_onExporting(const value: TdxEventHandler);
    procedure Set_onFileSaving(const value: TdxEventHandler);
    procedure Set_onIncidentOccurred(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
    procedure Set_onTooltipHidden(const value: TdxEventHandler);
    procedure Set_onTooltipShown(const value: TdxEventHandler);
    procedure Set_onZoomFactorChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxVectorMap; assembler;
    function instance: TdxVectorMap; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure center_(centerCoordinates: TJSArray); assembler; overload;
    function center_(): TJSArray; assembler; overload;
    procedure clearSelection(); assembler;
    function convertCoordinates(x: integer; y: integer): TJSArray; assembler;
    function convertToGeo(x: integer; y: integer): TJSArray; assembler;
    function convertToXY(longitude: integer; latitude: integer): TJSArray; assembler;
    procedure ctor(options: JSValue); assembler; overload;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler; overload;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure exportTo(fileName: string; format: string); assembler;
    function getLayerByIndex(index: integer): JSValue; assembler;
    function getLayerByName(name_: string): JSValue; assembler;
    function getLayers(): TJSArray; assembler;
    function getSize(): JSValue; assembler;
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
    procedure render(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure showLoadingIndicator(); assembler;
    function svg(): string; assembler;
    procedure viewport(viewportCoordinates: TJSArray); assembler; overload;
    function viewport(): TJSArray; assembler; overload;
    procedure zoomFactor_(zoomFactor: integer); assembler; overload;
    function zoomFactor_(): integer; assembler; overload;
  public
    property annotations: TJSArray read Fannotations write Set_annotations;
    property background: TJSObject read Fbackground write Set_background;
    property bounds: TJSArray read Fbounds write Set_bounds;
    property center: TJSArray read Fcenter write Set_center;
    property commonAnnotationSettings: TJSObject read FcommonAnnotationSettings write Set_commonAnnotationSettings;
    property controlBar: TJSObject read FcontrolBar write Set_controlBar;
    property customizeAnnotation: TJSFunction read FcustomizeAnnotation write Set_customizeAnnotation;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property height_: JSValue read Fheight_ write Set_height_;
    property layers: TJSArray read Flayers write Set_layers;
    property legends: TJSArray read Flegends write Set_legends;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property projection: TJSObject read Fprojection write Set_projection;
    property size: TJSObject read Fsize write Set_size;
    property theme: JSValue read Ftheme write Set_theme;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property maxZoomFactor: integer read FmaxZoomFactor write Set_maxZoomFactor;
    property panningEnabled: boolean read FpanningEnabled write Set_panningEnabled default true;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property touchEnabled: boolean read FtouchEnabled write Set_touchEnabled default true;
    property wheelEnabled: boolean read FwheelEnabled write Set_wheelEnabled default true;
    property zoomFactor: integer read FzoomFactor write Set_zoomFactor;
    property zoomingEnabled: boolean read FzoomingEnabled write Set_zoomingEnabled default true;
  published
    property onCenterChanged: TdxEventHandler read FonCenterChanged write Set_onCenterChanged;
    property onClick: TdxEventHandler read FonClick write Set_onClick;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onDrawn: TdxEventHandler read FonDrawn write Set_onDrawn;
    property onExported: TdxEventHandler read FonExported write Set_onExported;
    property onExporting: TdxEventHandler read FonExporting write Set_onExporting;
    property onFileSaving: TdxEventHandler read FonFileSaving write Set_onFileSaving;
    property onIncidentOccurred: TdxEventHandler read FonIncidentOccurred write Set_onIncidentOccurred;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
    property onTooltipHidden: TdxEventHandler read FonTooltipHidden write Set_onTooltipHidden;
    property onTooltipShown: TdxEventHandler read FonTooltipShown write Set_onTooltipShown;
    property onZoomFactorChanged: TdxEventHandler read FonZoomFactorChanged write Set_onZoomFactorChanged;
  end;

implementation


procedure TjdxCustomVectorMap.CreateInitialize;
begin
  inherited;
  Fannotations := TJSArray.new;
  Fbackground := TJSObject.new;
  Fbounds := TJSArray.new;
  Fcenter := TJSArray.new;
  FcommonAnnotationSettings := TJSObject.new;
  FcontrolBar := TJSObject.new;
  FcustomizeAnnotation := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  Fheight_ := nil;
  Flayers := TJSArray.new;
  Flegends := TJSArray.new;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  FmaxZoomFactor := 0;
  FpanningEnabled := true;
  FpathModified := false;
  Fprojection := TJSObject.new;
  FredrawOnResize := true;
  FrtlEnabled := false;
  Fsize := TJSObject.new;
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  FtouchEnabled := true;
  FwheelEnabled := true;
  Fwidth_ := nil;
  FzoomFactor := 0;
  FzoomingEnabled := true;

  FonCenterChanged := nil;
  FonClick := nil;
  FonDisposing := nil;
  FonDrawn := nil;
  FonExported := nil;
  FonExporting := nil;
  FonFileSaving := nil;
  FonIncidentOccurred := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonSelectionChanged := nil;
  FonTooltipHidden := nil;
  FonTooltipShown := nil;
  FonZoomFactorChanged := nil;
end;
procedure TjdxCustomVectorMap.InitJQuery;
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
      $(id).dxVectorMap(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomVectorMap.getInstance(element: TJSObject): TdxVectorMap;
asm
  return DevExpress.viz.dxVectorMap.getInstance(element);
end;

function TjdxCustomVectorMap.instance: TdxVectorMap;
asm
  return $(this.GetJQID()).dxVectorMap("instance");
end;
procedure TjdxCustomVectorMap.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('annotations', annotations);
    SetOption('background', background);
    SetOption('bounds', bounds);
    SetOption('center', center);
    SetOption('commonAnnotationSettings', commonAnnotationSettings);
    SetOption('controlBar', controlBar);
    SetOption('customizeAnnotation', customizeAnnotation);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('export', export);
    SetOption('height', height_);
    SetOption('layers', layers);
    SetOption('legends', legends);
    SetOption('loadingIndicator', loadingIndicator);
    SetOption('margin', margin);
    SetOption('maxZoomFactor', maxZoomFactor);
    SetOption('panningEnabled', panningEnabled);
    SetOption('pathModified', pathModified);
    SetOption('projection', projection);
    SetOption('redrawOnResize', redrawOnResize);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('size', size);
    SetOption('theme', theme);
    SetOption('title', title);
    SetOption('tooltip', tooltip);
    SetOption('touchEnabled', touchEnabled);
    SetOption('wheelEnabled', wheelEnabled);
    SetOption('width', width_);
    SetOption('zoomFactor', zoomFactor);
    SetOption('zoomingEnabled', zoomingEnabled);

    SetEvent('centerChanged', onCenterChanged);
    SetEvent('click', onClick);
    SetEvent('disposing', onDisposing);
    SetEvent('drawn', onDrawn);
    SetEvent('exported', onExported);
    SetEvent('exporting', onExporting);
    SetEvent('fileSaving', onFileSaving);
    SetEvent('incidentOccurred', onIncidentOccurred);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('selectionChanged', onSelectionChanged);
    SetEvent('tooltipHidden', onTooltipHidden);
    SetEvent('tooltipShown', onTooltipShown);
    SetEvent('zoomFactorChanged', onZoomFactorChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomVectorMap.Set_annotations(const Value: TJSArray);
begin
  Fannotations := Value;
  SetOption('annotations', annotations);
end;

procedure TjdxCustomVectorMap.Set_background(const Value: TJSObject);
begin
  Fbackground := Value;
  SetOption('background', background);
end;

procedure TjdxCustomVectorMap.Set_bounds(const Value: TJSArray);
begin
  Fbounds := Value;
  SetOption('bounds', bounds);
end;

procedure TjdxCustomVectorMap.Set_center(const Value: TJSArray);
begin
  Fcenter := Value;
  SetOption('center', center);
end;

procedure TjdxCustomVectorMap.Set_commonAnnotationSettings(const Value: TJSObject);
begin
  FcommonAnnotationSettings := Value;
  SetOption('commonAnnotationSettings', commonAnnotationSettings);
end;

procedure TjdxCustomVectorMap.Set_controlBar(const Value: TJSObject);
begin
  FcontrolBar := Value;
  SetOption('controlBar', controlBar);
end;

procedure TjdxCustomVectorMap.Set_customizeAnnotation(const Value: TJSFunction);
begin
  FcustomizeAnnotation := Value;
  SetOption('customizeAnnotation', customizeAnnotation);
end;

procedure TjdxCustomVectorMap.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomVectorMap.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomVectorMap.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
  SetOption('export', export);
end;

procedure TjdxCustomVectorMap.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomVectorMap.Set_layers(const Value: TJSArray);
begin
  Flayers := Value;
  SetOption('layers', layers);
end;

procedure TjdxCustomVectorMap.Set_legends(const Value: TJSArray);
begin
  Flegends := Value;
  SetOption('legends', legends);
end;

procedure TjdxCustomVectorMap.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
  SetOption('loadingIndicator', loadingIndicator);
end;

procedure TjdxCustomVectorMap.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
  SetOption('margin', margin);
end;

procedure TjdxCustomVectorMap.Set_maxZoomFactor(const Value: integer);
begin
  FmaxZoomFactor := Value;
  SetOption('maxZoomFactor', maxZoomFactor);
end;

procedure TjdxCustomVectorMap.Set_panningEnabled(const Value: boolean);
begin
  FpanningEnabled := Value;
  SetOption('panningEnabled', panningEnabled);
end;

procedure TjdxCustomVectorMap.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
  SetOption('pathModified', pathModified);
end;

procedure TjdxCustomVectorMap.Set_projection(const Value: TJSObject);
begin
  Fprojection := Value;
  SetOption('projection', projection);
end;

procedure TjdxCustomVectorMap.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
  SetOption('redrawOnResize', redrawOnResize);
end;

procedure TjdxCustomVectorMap.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomVectorMap.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
  SetOption('size', size);
end;

procedure TjdxCustomVectorMap.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
  SetOption('theme', theme);
end;

procedure TjdxCustomVectorMap.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
  SetOption('title', title);
end;

procedure TjdxCustomVectorMap.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
  SetOption('tooltip', tooltip);
end;

procedure TjdxCustomVectorMap.Set_touchEnabled(const Value: boolean);
begin
  FtouchEnabled := Value;
  SetOption('touchEnabled', touchEnabled);
end;

procedure TjdxCustomVectorMap.Set_wheelEnabled(const Value: boolean);
begin
  FwheelEnabled := Value;
  SetOption('wheelEnabled', wheelEnabled);
end;

procedure TjdxCustomVectorMap.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomVectorMap.Set_zoomFactor(const Value: integer);
begin
  FzoomFactor := Value;
  SetOption('zoomFactor', zoomFactor);
end;

procedure TjdxCustomVectorMap.Set_zoomingEnabled(const Value: boolean);
begin
  FzoomingEnabled := Value;
  SetOption('zoomingEnabled', zoomingEnabled);
end;

procedure TjdxCustomVectorMap.Set_onCenterChanged(const Value: TdxEventHandler);
begin
  FonCenterChanged := Value;
  SetEvent('centerChanged', onCenterChanged);
end;

procedure TjdxCustomVectorMap.Set_onClick(const Value: TdxEventHandler);
begin
  FonClick := Value;
  SetEvent('click', onClick);
end;

procedure TjdxCustomVectorMap.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomVectorMap.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
  SetEvent('drawn', onDrawn);
end;

procedure TjdxCustomVectorMap.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
  SetEvent('exported', onExported);
end;

procedure TjdxCustomVectorMap.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
  SetEvent('exporting', onExporting);
end;

procedure TjdxCustomVectorMap.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
  SetEvent('fileSaving', onFileSaving);
end;

procedure TjdxCustomVectorMap.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
  SetEvent('incidentOccurred', onIncidentOccurred);
end;

procedure TjdxCustomVectorMap.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomVectorMap.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomVectorMap.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomVectorMap.Set_onTooltipHidden(const Value: TdxEventHandler);
begin
  FonTooltipHidden := Value;
  SetEvent('tooltipHidden', onTooltipHidden);
end;

procedure TjdxCustomVectorMap.Set_onTooltipShown(const Value: TdxEventHandler);
begin
  FonTooltipShown := Value;
  SetEvent('tooltipShown', onTooltipShown);
end;

procedure TjdxCustomVectorMap.Set_onZoomFactorChanged(const Value: TdxEventHandler);
begin
  FonZoomFactorChanged := Value;
  SetEvent('zoomFactorChanged', onZoomFactorChanged);
end;

procedure TjdxCustomVectorMap.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomVectorMap.center_(centerCoordinates: TJSArray);
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.center(centerCoordinates);
end;

function TjdxCustomVectorMap.center_(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.center();
end;

procedure TjdxCustomVectorMap.clearSelection();
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.clearSelection();
end;

function TjdxCustomVectorMap.convertCoordinates(x: integer; y: integer): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.convertCoordinates(x, y);
end;

function TjdxCustomVectorMap.convertToGeo(x: integer; y: integer): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.convertToGeo(x, y);
end;

function TjdxCustomVectorMap.convertToXY(longitude: integer; latitude: integer): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.convertToXY(longitude, latitude);
end;

procedure TjdxCustomVectorMap.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomVectorMap.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomVectorMap.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomVectorMap.dispose();
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.dispose();
end;

function TjdxCustomVectorMap.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.element();
end;

procedure TjdxCustomVectorMap.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomVectorMap.exportTo(fileName: string; format: string);
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.exportTo(fileName, format);
end;

function TjdxCustomVectorMap.getLayerByIndex(index: integer): JSValue;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.getLayerByIndex(index);
end;

function TjdxCustomVectorMap.getLayerByName(name_: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.getLayerByName(name_);
end;

function TjdxCustomVectorMap.getLayers(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.getLayers();
end;

function TjdxCustomVectorMap.getSize(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.getSize();
end;

procedure TjdxCustomVectorMap.hideLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.hideLoadingIndicator();
end;

function TjdxCustomVectorMap.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomVectorMap.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.off(eventName);
end;

function TjdxCustomVectorMap.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.on(events);
end;

function TjdxCustomVectorMap.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomVectorMap.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.option(optionName);
end;

function TjdxCustomVectorMap.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.option();
end;

procedure TjdxCustomVectorMap.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomVectorMap.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.option(options);
end;

procedure TjdxCustomVectorMap.print();
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.print();
end;

procedure TjdxCustomVectorMap.render();
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.render();
end;

procedure TjdxCustomVectorMap.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomVectorMap.showLoadingIndicator();
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.showLoadingIndicator();
end;

function TjdxCustomVectorMap.svg(): string;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.svg();
end;

procedure TjdxCustomVectorMap.viewport(viewportCoordinates: TJSArray);
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.viewport(viewportCoordinates);
end;

function TjdxCustomVectorMap.viewport(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.viewport();
end;

procedure TjdxCustomVectorMap.zoomFactor_(zoomFactor: integer);
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  _instance.zoomFactor(zoomFactor);
end;

function TjdxCustomVectorMap.zoomFactor_(): integer;
asm
  const _instance = $(this.GetJQID()).dxVectorMap("instance");
  return _instance.zoomFactor();
end;

end.
