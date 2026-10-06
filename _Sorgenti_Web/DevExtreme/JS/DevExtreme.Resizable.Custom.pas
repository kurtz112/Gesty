unit DevExtreme.Resizable.Custom;

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
  DevExtreme.Resizable.JS,
  DevExtreme.Types;

type
  TjdxCustomResizable = class(TjdxCustomControl)
  private
    Farea: JSValue;
    FelementAttr: TJSObject;
    Fhandles: JSValue;
    Fheight_: JSValue;
    FkeepAspectRatio: boolean;
    FmaxHeight: integer;
    FmaxWidth: integer;
    FminHeight: integer;
    FminWidth: integer;
    FrtlEnabled: boolean;
    FstepPrecision: TdxResizableStepPrecision;
    Fwidth_: JSValue;
  private
    FonDisposing: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonResize: TdxEventHandler;
    FonResizeEnd: TdxEventHandler;
    FonResizeStart: TdxEventHandler;
  private
    procedure Set_area(const value: JSValue);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_handles(const value: JSValue);
    procedure Set_height_(const value: JSValue);
    procedure Set_keepAspectRatio(const value: boolean);
    procedure Set_maxHeight(const value: integer);
    procedure Set_maxWidth(const value: integer);
    procedure Set_minHeight(const value: integer);
    procedure Set_minWidth(const value: integer);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_stepPrecision(const value: TdxResizableStepPrecision);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onResize(const value: TdxEventHandler);
    procedure Set_onResizeEnd(const value: TdxEventHandler);
    procedure Set_onResizeStart(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxResizable; assembler;
    function instance: TdxResizable; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure resetOption(optionName: string); assembler;
  public
    property area: JSValue read Farea write Set_area;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property handles: JSValue read Fhandles write Set_handles;
    property height_: JSValue read Fheight_ write Set_height_;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property keepAspectRatio: boolean read FkeepAspectRatio write Set_keepAspectRatio default true;
    property maxHeight: integer read FmaxHeight write Set_maxHeight;
    property maxWidth: integer read FmaxWidth write Set_maxWidth;
    property minHeight: integer read FminHeight write Set_minHeight;
    property minWidth: integer read FminWidth write Set_minWidth;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property stepPrecision: TdxResizableStepPrecision read FstepPrecision write Set_stepPrecision default rspSimple;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onResize: TdxEventHandler read FonResize write Set_onResize;
    property onResizeEnd: TdxEventHandler read FonResizeEnd write Set_onResizeEnd;
    property onResizeStart: TdxEventHandler read FonResizeStart write Set_onResizeStart;
  end;

implementation


procedure TjdxCustomResizable.CreateInitialize;
begin
  inherited;
  Farea := nil;
  FelementAttr := TJSObject.new;
  Fhandles := nil;
  Fheight_ := nil;
  FkeepAspectRatio := true;
  FmaxHeight := 0;
  FmaxWidth := 0;
  FminHeight := 0;
  FminWidth := 0;
  FrtlEnabled := false;
  FstepPrecision := rspSimple;
  Fwidth_ := nil;

  FonDisposing := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonResize := nil;
  FonResizeEnd := nil;
  FonResizeStart := nil;
end;
procedure TjdxCustomResizable.InitJQuery;
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
      $(id).dxResizable(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomResizable.getInstance(element: TJSObject): TdxResizable;
asm
  return DevExpress.viz.dxResizable.getInstance(element);
end;

function TjdxCustomResizable.instance: TdxResizable;
asm
  return $(this.GetJQID()).dxResizable("instance");
end;
procedure TjdxCustomResizable.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('area', area);
    SetOption('elementAttr', elementAttr);
    SetOption('handles', handles);
    SetOption('height', height_);
    SetOption('keepAspectRatio', keepAspectRatio);
    SetOption('maxHeight', maxHeight);
    SetOption('maxWidth', maxWidth);
    SetOption('minHeight', minHeight);
    SetOption('minWidth', minWidth);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('stepPrecision', stepPrecision.ToString());
    SetOption('width', width_);

    SetEvent('disposing', onDisposing);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('resize', onResize);
    SetEvent('resizeEnd', onResizeEnd);
    SetEvent('resizeStart', onResizeStart);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomResizable.Set_area(const Value: JSValue);
begin
  Farea := Value;
  SetOption('area', area);
end;

procedure TjdxCustomResizable.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomResizable.Set_handles(const Value: JSValue);
begin
  Fhandles := Value;
  SetOption('handles', handles);
end;

procedure TjdxCustomResizable.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomResizable.Set_keepAspectRatio(const Value: boolean);
begin
  FkeepAspectRatio := Value;
  SetOption('keepAspectRatio', keepAspectRatio);
end;

procedure TjdxCustomResizable.Set_maxHeight(const Value: integer);
begin
  FmaxHeight := Value;
  SetOption('maxHeight', maxHeight);
end;

procedure TjdxCustomResizable.Set_maxWidth(const Value: integer);
begin
  FmaxWidth := Value;
  SetOption('maxWidth', maxWidth);
end;

procedure TjdxCustomResizable.Set_minHeight(const Value: integer);
begin
  FminHeight := Value;
  SetOption('minHeight', minHeight);
end;

procedure TjdxCustomResizable.Set_minWidth(const Value: integer);
begin
  FminWidth := Value;
  SetOption('minWidth', minWidth);
end;

procedure TjdxCustomResizable.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomResizable.Set_stepPrecision(const Value: TdxResizableStepPrecision);
begin
  FstepPrecision := Value;
  SetOption('stepPrecision', stepPrecision.ToString());
end;

procedure TjdxCustomResizable.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomResizable.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomResizable.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomResizable.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomResizable.Set_onResize(const Value: TdxEventHandler);
begin
  FonResize := Value;
  SetEvent('resize', onResize);
end;

procedure TjdxCustomResizable.Set_onResizeEnd(const Value: TdxEventHandler);
begin
  FonResizeEnd := Value;
  SetEvent('resizeEnd', onResizeEnd);
end;

procedure TjdxCustomResizable.Set_onResizeStart(const Value: TdxEventHandler);
begin
  FonResizeStart := Value;
  SetEvent('resizeStart', onResizeStart);
end;

procedure TjdxCustomResizable.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxResizable("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomResizable.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxResizable("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomResizable.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxResizable("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomResizable.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxResizable("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomResizable.dispose();
asm
  const _instance = $(this.GetJQID()).dxResizable("instance");
  _instance.dispose();
end;

function TjdxCustomResizable.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxResizable("instance");
  return _instance.element();
end;

procedure TjdxCustomResizable.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxResizable("instance");
  _instance.endUpdate();
end;

function TjdxCustomResizable.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxResizable("instance");
  return _instance.off(eventName);
end;

function TjdxCustomResizable.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxResizable("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomResizable.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxResizable("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomResizable.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxResizable("instance");
  return _instance.on(events);
end;

function TjdxCustomResizable.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxResizable("instance");
  return _instance.option(optionName);
end;

function TjdxCustomResizable.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxResizable("instance");
  return _instance.option();
end;

procedure TjdxCustomResizable.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxResizable("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomResizable.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxResizable("instance");
  _instance.option(options);
end;

procedure TjdxCustomResizable.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxResizable("instance");
  _instance.resetOption(optionName);
end;

end.
