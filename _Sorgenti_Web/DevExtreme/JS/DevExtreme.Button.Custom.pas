unit DevExtreme.Button.Custom;

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
  DevExtreme.Button.JS,
  DevExtreme.Types;

type
  TjdxCustomButton = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    Ficon: string;
    FrtlEnabled: boolean;
    FstylingMode: TdxButtonStyle;
    FtabIndex: integer;
    Ftemplate: JSValue;
    Ftext: string;
    Ftype_: TdxButtonType;
    FuseSubmitBehavior: boolean;
    FvalidationGroup: string;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonClick: TdxEventHandler;
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_icon(const value: string);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_stylingMode(const value: TdxButtonStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_template(const value: JSValue);
    procedure Set_text(const value: string);
    procedure Set_type_(const value: TdxButtonType);
    procedure Set_useSubmitBehavior(const value: boolean);
    procedure Set_validationGroup(const value: string);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onClick(const value: TdxEventHandler);
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxButton; assembler;
    function instance: TdxButton; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
  public
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property template: JSValue read Ftemplate write Set_template;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property icon: string read Ficon write Set_icon;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property stylingMode: TdxButtonStyle read FstylingMode write Set_stylingMode default bsContained;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property text: string read Ftext write Set_text;
    property type_: TdxButtonType read Ftype_ write Set_type_ default btNormal;
    property useSubmitBehavior: boolean read FuseSubmitBehavior write Set_useSubmitBehavior default false;
    property validationGroup: string read FvalidationGroup write Set_validationGroup;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onClick: TdxEventHandler read FonClick write Set_onClick;
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
  end;

implementation


procedure TjdxCustomButton.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  Ficon := '';
  FrtlEnabled := false;
  FstylingMode := bsContained;
  FtabIndex := 0;
  Ftemplate := nil;
  Ftext := '';
  Ftype_ := btNormal;
  FuseSubmitBehavior := false;
  FvalidationGroup := '';
  Fvisible := true;
  Fwidth_ := nil;

  FonClick := nil;
  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
end;
procedure TjdxCustomButton.InitJQuery;
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
      $(id).dxButton(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomButton.getInstance(element: TJSObject): TdxButton;
asm
  return DevExpress.viz.dxButton.getInstance(element);
end;

function TjdxCustomButton.instance: TdxButton;
asm
  return $(this.GetJQID()).dxButton("instance");
end;
procedure TjdxCustomButton.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('icon', icon);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('stylingMode', stylingMode.ToString());
    SetOption('tabIndex', tabIndex);
    SetOption('template', template);
    SetOption('text', text);
    SetOption('type', type_.ToString());
    SetOption('useSubmitBehavior', useSubmitBehavior);
    SetOption('validationGroup', validationGroup);
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('click', onClick);
    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomButton.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomButton.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomButton.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomButton.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomButton.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomButton.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomButton.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomButton.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomButton.Set_icon(const Value: string);
begin
  Ficon := Value;
  SetOption('icon', icon);
end;

procedure TjdxCustomButton.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomButton.Set_stylingMode(const Value: TdxButtonStyle);
begin
  FstylingMode := Value;
  SetOption('stylingMode', stylingMode.ToString());
end;

procedure TjdxCustomButton.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomButton.Set_template(const Value: JSValue);
begin
  Ftemplate := Value;
  SetOption('template', template);
end;

procedure TjdxCustomButton.Set_text(const Value: string);
begin
  Ftext := Value;
  SetOption('text', text);
end;

procedure TjdxCustomButton.Set_type_(const Value: TdxButtonType);
begin
  Ftype_ := Value;
  SetOption('type', type_.ToString());
end;

procedure TjdxCustomButton.Set_useSubmitBehavior(const Value: boolean);
begin
  FuseSubmitBehavior := Value;
  SetOption('useSubmitBehavior', useSubmitBehavior);
end;

procedure TjdxCustomButton.Set_validationGroup(const Value: string);
begin
  FvalidationGroup := Value;
  SetOption('validationGroup', validationGroup);
end;

procedure TjdxCustomButton.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomButton.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomButton.Set_onClick(const Value: TdxEventHandler);
begin
  FonClick := Value;
  SetEvent('click', onClick);
end;

procedure TjdxCustomButton.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomButton.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomButton.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomButton.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomButton.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomButton.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomButton.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomButton.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomButton.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomButton.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomButton.dispose();
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  _instance.dispose();
end;

function TjdxCustomButton.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  return _instance.element();
end;

procedure TjdxCustomButton.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomButton.focus();
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  _instance.focus();
end;

function TjdxCustomButton.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  return _instance.off(eventName);
end;

function TjdxCustomButton.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomButton.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomButton.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  return _instance.on(events);
end;

function TjdxCustomButton.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  return _instance.option(optionName);
end;

function TjdxCustomButton.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  return _instance.option();
end;

procedure TjdxCustomButton.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomButton.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  _instance.option(options);
end;

procedure TjdxCustomButton.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomButton.repaint();
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  _instance.repaint();
end;

procedure TjdxCustomButton.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxButton("instance");
  _instance.resetOption(optionName);
end;

end.
