unit DevExtreme.Validator.Custom;

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
  DevExtreme.Validator.JS,
  DevExtreme.Types;

type
  TjdxCustomValidator = class(TjdxCustomControl)
  private
    Fadapter: TJSObject;
    FelementAttr: TJSObject;
    Fheight_: JSValue;
    Fname_: string;
    FrtlEnabled: boolean;
    FvalidationGroup: string;
    FvalidationRules: TJSArray;
    Fwidth_: JSValue;
  private
    FonDisposing: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonValidated: TdxEventHandler;
  private
    procedure Set_adapter(const value: TJSObject);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_name_(const value: string);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_validationGroup(const value: string);
    procedure Set_validationRules(const value: TJSArray);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onValidated(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxValidator; assembler;
    function instance: TdxValidator; assembler;
  public
    procedure beginUpdate(); assembler; overload;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler; overload;
    procedure dispose(); assembler; overload;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler; overload;
    procedure focus(); assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure reset(); assembler;
    procedure resetOption(optionName: string); assembler;
    function validate(): JSValue; assembler;
  public
    property adapter: TJSObject read Fadapter write Set_adapter;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property validationRules: TJSArray read FvalidationRules write Set_validationRules;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property name_: string read Fname_ write Set_name_;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property validationGroup: string read FvalidationGroup write Set_validationGroup;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onValidated: TdxEventHandler read FonValidated write Set_onValidated;
  end;

implementation


procedure TjdxCustomValidator.CreateInitialize;
begin
  inherited;
  Fadapter := TJSObject.new;
  FelementAttr := TJSObject.new;
  Fheight_ := nil;
  Fname_ := '';
  FrtlEnabled := false;
  FvalidationGroup := '';
  FvalidationRules := TJSArray.new;
  Fwidth_ := nil;

  FonDisposing := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonValidated := nil;
end;
procedure TjdxCustomValidator.InitJQuery;
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
      $(id).dxValidator(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomValidator.getInstance(element: TJSObject): TdxValidator;
asm
  return DevExpress.viz.dxValidator.getInstance(element);
end;

function TjdxCustomValidator.instance: TdxValidator;
asm
  return $(this.GetJQID()).dxValidator("instance");
end;
procedure TjdxCustomValidator.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('adapter', adapter);
    SetOption('elementAttr', elementAttr);
    SetOption('height', height_);
    SetOption('name', name_);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('validationGroup', validationGroup);
    SetOption('validationRules', validationRules);
    SetOption('width', width_);

    SetEvent('disposing', onDisposing);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('validated', onValidated);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomValidator.Set_adapter(const Value: TJSObject);
begin
  Fadapter := Value;
  SetOption('adapter', adapter);
end;

procedure TjdxCustomValidator.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomValidator.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomValidator.Set_name_(const Value: string);
begin
  Fname_ := Value;
  SetOption('name', name_);
end;

procedure TjdxCustomValidator.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomValidator.Set_validationGroup(const Value: string);
begin
  FvalidationGroup := Value;
  SetOption('validationGroup', validationGroup);
end;

procedure TjdxCustomValidator.Set_validationRules(const Value: TJSArray);
begin
  FvalidationRules := Value;
  SetOption('validationRules', validationRules);
end;

procedure TjdxCustomValidator.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomValidator.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomValidator.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomValidator.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomValidator.Set_onValidated(const Value: TdxEventHandler);
begin
  FonValidated := Value;
  SetEvent('validated', onValidated);
end;

procedure TjdxCustomValidator.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomValidator.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomValidator.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomValidator.defaultOptions();
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  _instance.defaultOptions();
end;

procedure TjdxCustomValidator.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomValidator.dispose();
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  _instance.dispose();
end;

function TjdxCustomValidator.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  return _instance.element();
end;

procedure TjdxCustomValidator.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomValidator.focus();
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  _instance.focus();
end;

function TjdxCustomValidator.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomValidator.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  return _instance.off(eventName);
end;

function TjdxCustomValidator.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  return _instance.on(events);
end;

function TjdxCustomValidator.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomValidator.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  return _instance.option(optionName);
end;

function TjdxCustomValidator.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  return _instance.option();
end;

procedure TjdxCustomValidator.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomValidator.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  _instance.option(options);
end;

procedure TjdxCustomValidator.reset();
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  _instance.reset();
end;

procedure TjdxCustomValidator.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  _instance.resetOption(optionName);
end;

function TjdxCustomValidator.validate(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxValidator("instance");
  return _instance.validate();
end;

end.
