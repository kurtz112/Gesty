unit DevExtreme.RangeSlider.Custom;

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
  DevExtreme.RangeSlider.JS,
  DevExtreme.Types;

type
  TjdxCustomRangeSlider = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fend_: integer;
    FendName: string;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FisValid: boolean;
    FkeyStep: integer;
    Flabel_: TJSObject;
    Fmax: integer;
    Fmin: integer;
    Fname_: string;
    FreadOnly: boolean;
    FrtlEnabled: boolean;
    FshowRange: boolean;
    Fstart: integer;
    FstartName: string;
    Fstep: integer;
    FstylingMode: TdxEditorStyle;
    FtabIndex: integer;
    Ftooltip: TJSObject;
    FvalidationError: JSValue;
    FvalidationErrors: TJSArray;
    FvalidationMessageMode: TdxValidationMessageMode;
    FvalidationMessagePosition: TdxPosition;
    FvalidationStatus: TdxValidationStatus;
    Fvalue: JSValue;
    FvalueChangeMode: TdxSliderValueChangeMode;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonValueChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_end_(const value: integer);
    procedure Set_endName(const value: string);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_isValid(const value: boolean);
    procedure Set_keyStep(const value: integer);
    procedure Set_label_(const value: TJSObject);
    procedure Set_max(const value: integer);
    procedure Set_min(const value: integer);
    procedure Set_name_(const value: string);
    procedure Set_readOnly(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_showRange(const value: boolean);
    procedure Set_start(const value: integer);
    procedure Set_startName(const value: string);
    procedure Set_step(const value: integer);
    procedure Set_stylingMode(const value: TdxEditorStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_validationError(const value: JSValue);
    procedure Set_validationErrors(const value: TJSArray);
    procedure Set_validationMessageMode(const value: TdxValidationMessageMode);
    procedure Set_validationMessagePosition(const value: TdxPosition);
    procedure Set_validationStatus(const value: TdxValidationStatus);
    procedure Set_value(const value: JSValue);
    procedure Set_valueChangeMode(const value: TdxSliderValueChangeMode);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onValueChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxRangeSlider; assembler;
    function instance: TdxRangeSlider; assembler;
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
    procedure reset(); assembler;
    procedure resetOption(optionName: string); assembler;
  public
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property label_: TJSObject read Flabel_ write Set_label_;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property validationError: JSValue read FvalidationError write Set_validationError;
    property validationErrors: TJSArray read FvalidationErrors write Set_validationErrors;
    property value: JSValue read Fvalue write Set_value;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property end_: integer read Fend_ write Set_end_;
    property endName: string read FendName write Set_endName;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property isValid: boolean read FisValid write Set_isValid default true;
    property keyStep: integer read FkeyStep write Set_keyStep;
    property max: integer read Fmax write Set_max;
    property min: integer read Fmin write Set_min;
    property name_: string read Fname_ write Set_name_;
    property readOnly: boolean read FreadOnly write Set_readOnly default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showRange: boolean read FshowRange write Set_showRange default true;
    property start: integer read Fstart write Set_start;
    property startName: string read FstartName write Set_startName;
    property step: integer read Fstep write Set_step;
    property stylingMode: TdxEditorStyle read FstylingMode write Set_stylingMode default esOutlined;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property validationMessageMode: TdxValidationMessageMode read FvalidationMessageMode write Set_validationMessageMode default vmmAuto;
    property validationMessagePosition: TdxPosition read FvalidationMessagePosition write Set_validationMessagePosition default pBottom;
    property validationStatus: TdxValidationStatus read FvalidationStatus write Set_validationStatus default vsValid;
    property valueChangeMode: TdxSliderValueChangeMode read FvalueChangeMode write Set_valueChangeMode default svcmOnHandleMove;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onValueChanged: TdxEventHandler read FonValueChanged write Set_onValueChanged;
  end;

implementation


procedure TjdxCustomRangeSlider.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fend_ := 0;
  FendName := '';
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FisValid := true;
  FkeyStep := 0;
  Flabel_ := TJSObject.new;
  Fmax := 0;
  Fmin := 0;
  Fname_ := '';
  FreadOnly := false;
  FrtlEnabled := false;
  FshowRange := true;
  Fstart := 0;
  FstartName := '';
  Fstep := 0;
  FstylingMode := esOutlined;
  FtabIndex := 0;
  Ftooltip := TJSObject.new;
  FvalidationError := nil;
  FvalidationErrors := TJSArray.new;
  FvalidationMessageMode := vmmAuto;
  FvalidationMessagePosition := pBottom;
  FvalidationStatus := vsValid;
  Fvalue := nil;
  FvalueChangeMode := svcmOnHandleMove;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonValueChanged := nil;
end;
procedure TjdxCustomRangeSlider.InitJQuery;
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
      $(id).dxRangeSlider(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomRangeSlider.getInstance(element: TJSObject): TdxRangeSlider;
asm
  return DevExpress.viz.dxRangeSlider.getInstance(element);
end;

function TjdxCustomRangeSlider.instance: TdxRangeSlider;
asm
  return $(this.GetJQID()).dxRangeSlider("instance");
end;
procedure TjdxCustomRangeSlider.UpdateElement;
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
    SetOption('end', end_);
    SetOption('endName', endName);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('isValid', isValid);
    SetOption('keyStep', keyStep);
    SetOption('label', label_);
    SetOption('max', max);
    SetOption('min', min);
    SetOption('name', name_);
    SetOption('readOnly', readOnly);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('showRange', showRange);
    SetOption('start', start);
    SetOption('startName', startName);
    SetOption('step', step);
    SetOption('stylingMode', stylingMode.ToString());
    SetOption('tabIndex', tabIndex);
    SetOption('tooltip', tooltip);
    SetOption('validationError', validationError);
    SetOption('validationErrors', validationErrors);
    SetOption('validationMessageMode', validationMessageMode.ToString());
    SetOption('validationMessagePosition', validationMessagePosition.ToString());
    SetOption('validationStatus', validationStatus.ToString());
    SetOption('value', value);
    SetOption('valueChangeMode', valueChangeMode.ToString());
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('valueChanged', onValueChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomRangeSlider.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomRangeSlider.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomRangeSlider.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomRangeSlider.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomRangeSlider.Set_end_(const Value: integer);
begin
  Fend_ := Value;
  SetOption('end', end_);
end;

procedure TjdxCustomRangeSlider.Set_endName(const Value: string);
begin
  FendName := Value;
  SetOption('endName', endName);
end;

procedure TjdxCustomRangeSlider.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomRangeSlider.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomRangeSlider.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomRangeSlider.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomRangeSlider.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
  SetOption('isValid', isValid);
end;

procedure TjdxCustomRangeSlider.Set_keyStep(const Value: integer);
begin
  FkeyStep := Value;
  SetOption('keyStep', keyStep);
end;

procedure TjdxCustomRangeSlider.Set_label_(const Value: TJSObject);
begin
  Flabel_ := Value;
  SetOption('label', label_);
end;

procedure TjdxCustomRangeSlider.Set_max(const Value: integer);
begin
  Fmax := Value;
  SetOption('max', max);
end;

procedure TjdxCustomRangeSlider.Set_min(const Value: integer);
begin
  Fmin := Value;
  SetOption('min', min);
end;

procedure TjdxCustomRangeSlider.Set_name_(const Value: string);
begin
  Fname_ := Value;
  SetOption('name', name_);
end;

procedure TjdxCustomRangeSlider.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
  SetOption('readOnly', readOnly);
end;

procedure TjdxCustomRangeSlider.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomRangeSlider.Set_showRange(const Value: boolean);
begin
  FshowRange := Value;
  SetOption('showRange', showRange);
end;

procedure TjdxCustomRangeSlider.Set_start(const Value: integer);
begin
  Fstart := Value;
  SetOption('start', start);
end;

procedure TjdxCustomRangeSlider.Set_startName(const Value: string);
begin
  FstartName := Value;
  SetOption('startName', startName);
end;

procedure TjdxCustomRangeSlider.Set_step(const Value: integer);
begin
  Fstep := Value;
  SetOption('step', step);
end;

procedure TjdxCustomRangeSlider.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
  SetOption('stylingMode', stylingMode.ToString());
end;

procedure TjdxCustomRangeSlider.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomRangeSlider.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
  SetOption('tooltip', tooltip);
end;

procedure TjdxCustomRangeSlider.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
  SetOption('validationError', validationError);
end;

procedure TjdxCustomRangeSlider.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
  SetOption('validationErrors', validationErrors);
end;

procedure TjdxCustomRangeSlider.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
  SetOption('validationMessageMode', validationMessageMode.ToString());
end;

procedure TjdxCustomRangeSlider.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
  SetOption('validationMessagePosition', validationMessagePosition.ToString());
end;

procedure TjdxCustomRangeSlider.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
  SetOption('validationStatus', validationStatus.ToString());
end;

procedure TjdxCustomRangeSlider.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
  SetOption('value', value);
end;

procedure TjdxCustomRangeSlider.Set_valueChangeMode(const Value: TdxSliderValueChangeMode);
begin
  FvalueChangeMode := Value;
  SetOption('valueChangeMode', valueChangeMode.ToString());
end;

procedure TjdxCustomRangeSlider.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomRangeSlider.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomRangeSlider.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomRangeSlider.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomRangeSlider.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomRangeSlider.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomRangeSlider.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomRangeSlider.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomRangeSlider.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
  SetEvent('valueChanged', onValueChanged);
end;

procedure TjdxCustomRangeSlider.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomRangeSlider.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomRangeSlider.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomRangeSlider.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomRangeSlider.dispose();
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  _instance.dispose();
end;

function TjdxCustomRangeSlider.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  return _instance.element();
end;

procedure TjdxCustomRangeSlider.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomRangeSlider.focus();
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  _instance.focus();
end;

function TjdxCustomRangeSlider.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  return _instance.off(eventName);
end;

function TjdxCustomRangeSlider.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomRangeSlider.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomRangeSlider.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  return _instance.on(events);
end;

function TjdxCustomRangeSlider.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  return _instance.option(optionName);
end;

function TjdxCustomRangeSlider.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  return _instance.option();
end;

procedure TjdxCustomRangeSlider.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomRangeSlider.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  _instance.option(options);
end;

procedure TjdxCustomRangeSlider.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomRangeSlider.repaint();
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  _instance.repaint();
end;

procedure TjdxCustomRangeSlider.reset();
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  _instance.reset();
end;

procedure TjdxCustomRangeSlider.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxRangeSlider("instance");
  _instance.resetOption(optionName);
end;

end.
