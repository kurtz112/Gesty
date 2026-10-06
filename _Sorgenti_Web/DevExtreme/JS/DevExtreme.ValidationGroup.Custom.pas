unit DevExtreme.ValidationGroup.Custom;

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
  DevExtreme.ValidationGroup.JS,
  DevExtreme.Types;

type
  TjdxCustomValidationGroup = class(TjdxCustomControl)
  private
    FelementAttr: TJSObject;
    Fheight_: JSValue;
    FrtlEnabled: boolean;
    Fwidth_: JSValue;
  private
    FonDisposing: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
  private
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxValidationGroup; assembler;
    function instance: TdxValidationGroup; assembler;
  public
    procedure beginUpdate(); assembler; overload;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler; overload;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure reset(); assembler;
    procedure resetOption(optionName: string); assembler;
    function validate(): JSValue; assembler;
  public
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
  end;

implementation


procedure TjdxCustomValidationGroup.CreateInitialize;
begin
  inherited;
  FelementAttr := TJSObject.new;
  Fheight_ := nil;
  FrtlEnabled := false;
  Fwidth_ := nil;

  FonDisposing := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
end;
procedure TjdxCustomValidationGroup.InitJQuery;
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
      $(id).dxValidationGroup(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomValidationGroup.getInstance(element: TJSObject): TdxValidationGroup;
asm
  return DevExpress.viz.dxValidationGroup.getInstance(element);
end;

function TjdxCustomValidationGroup.instance: TdxValidationGroup;
asm
  return $(this.GetJQID()).dxValidationGroup("instance");
end;
procedure TjdxCustomValidationGroup.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('elementAttr', elementAttr);
    SetOption('height', height_);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('width', width_);

    SetEvent('disposing', onDisposing);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomValidationGroup.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomValidationGroup.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomValidationGroup.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomValidationGroup.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomValidationGroup.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomValidationGroup.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomValidationGroup.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomValidationGroup.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomValidationGroup.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomValidationGroup.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomValidationGroup.defaultOptions();
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  _instance.defaultOptions();
end;

procedure TjdxCustomValidationGroup.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomValidationGroup.dispose();
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  _instance.dispose();
end;

function TjdxCustomValidationGroup.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  return _instance.element();
end;

procedure TjdxCustomValidationGroup.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  _instance.endUpdate();
end;

function TjdxCustomValidationGroup.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomValidationGroup.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  return _instance.off(eventName);
end;

function TjdxCustomValidationGroup.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomValidationGroup.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  return _instance.on(events);
end;

function TjdxCustomValidationGroup.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  return _instance.option(optionName);
end;

function TjdxCustomValidationGroup.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  return _instance.option();
end;

procedure TjdxCustomValidationGroup.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomValidationGroup.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  _instance.option(options);
end;

procedure TjdxCustomValidationGroup.reset();
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  _instance.reset();
end;

procedure TjdxCustomValidationGroup.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  _instance.resetOption(optionName);
end;

function TjdxCustomValidationGroup.validate(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxValidationGroup("instance");
  return _instance.validate();
end;

end.
