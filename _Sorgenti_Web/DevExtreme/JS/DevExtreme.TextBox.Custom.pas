unit DevExtreme.TextBox.Custom;

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
  DevExtreme.TextBox.JS,
  DevExtreme.Types;

type
  TjdxCustomTextBox = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fbuttons: TJSArray;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FinputAttr: JSValue;
    FisValid: boolean;
    Flabel_: string;
    FlabelMode: TdxLabelMode;
    Fmask: string;
    FmaskChar: string;
    FmaskInvalidMessage: string;
    FmaskRules: JSValue;
    FmaxLength: JSValue;
    Fmode: TdxTextBoxType;
    Fname_: string;
    Fplaceholder: string;
    FreadOnly: boolean;
    FrtlEnabled: boolean;
    FshowClearButton: boolean;
    FshowMaskMode: TdxMaskMode;
    Fspellcheck: boolean;
    FstylingMode: TdxEditorStyle;
    FtabIndex: integer;
    Ftext: string;
    FuseMaskedValue: boolean;
    FvalidationError: JSValue;
    FvalidationErrors: TJSArray;
    FvalidationMessageMode: TdxValidationMessageMode;
    FvalidationMessagePosition: TdxPosition;
    FvalidationStatus: TdxValidationStatus;
    Fvalue: JSValue;
    FvalueChangeEvent: string;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonChange: TdxEventHandler;
    FonContentReady: TdxEventHandler;
    FonCopy: TdxEventHandler;
    FonCut: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonEnterKey: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonInput: TdxEventHandler;
    FonKeyDown: TdxEventHandler;
    FonKeyUp: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonPaste: TdxEventHandler;
    FonValueChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_buttons(const value: TJSArray);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_inputAttr(const value: JSValue);
    procedure Set_isValid(const value: boolean);
    procedure Set_label_(const value: string);
    procedure Set_labelMode(const value: TdxLabelMode);
    procedure Set_mask(const value: string);
    procedure Set_maskChar(const value: string);
    procedure Set_maskInvalidMessage(const value: string);
    procedure Set_maskRules(const value: JSValue);
    procedure Set_maxLength(const value: JSValue);
    procedure Set_mode(const value: TdxTextBoxType);
    procedure Set_name_(const value: string);
    procedure Set_placeholder(const value: string);
    procedure Set_readOnly(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_showClearButton(const value: boolean);
    procedure Set_showMaskMode(const value: TdxMaskMode);
    procedure Set_spellcheck(const value: boolean);
    procedure Set_stylingMode(const value: TdxEditorStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_useMaskedValue(const value: boolean);
    procedure Set_validationError(const value: JSValue);
    procedure Set_validationErrors(const value: TJSArray);
    procedure Set_validationMessageMode(const value: TdxValidationMessageMode);
    procedure Set_validationMessagePosition(const value: TdxPosition);
    procedure Set_validationStatus(const value: TdxValidationStatus);
    procedure Set_value(const value: JSValue);
    procedure Set_valueChangeEvent(const value: string);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onChange(const value: TdxEventHandler);
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onCopy(const value: TdxEventHandler);
    procedure Set_onCut(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onEnterKey(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onInput(const value: TdxEventHandler);
    procedure Set_onKeyDown(const value: TdxEventHandler);
    procedure Set_onKeyUp(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onPaste(const value: TdxEventHandler);
    procedure Set_onValueChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxTextBox; assembler;
    function instance: TdxTextBox; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure blur(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler; overload;
    function getButton(name_: string): JSValue; assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure repaint(); assembler;
    procedure reset(); assembler;
    procedure resetOption(optionName: string); assembler;
  public
    property buttons: TJSArray read Fbuttons write Set_buttons;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property inputAttr: JSValue read FinputAttr write Set_inputAttr;
    property maskRules: JSValue read FmaskRules write Set_maskRules;
    property maxLength: JSValue read FmaxLength write Set_maxLength;
    property validationError: JSValue read FvalidationError write Set_validationError;
    property validationErrors: TJSArray read FvalidationErrors write Set_validationErrors;
    property value: JSValue read Fvalue write Set_value;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property isValid: boolean read FisValid write Set_isValid default true;
    property label_: string read Flabel_ write Set_label_;
    property labelMode: TdxLabelMode read FlabelMode write Set_labelMode default lmFloating;
    property mask: string read Fmask write Set_mask;
    property maskChar: string read FmaskChar write Set_maskChar;
    property maskInvalidMessage: string read FmaskInvalidMessage write Set_maskInvalidMessage;
    property mode: TdxTextBoxType read Fmode write Set_mode default tbtText;
    property name_: string read Fname_ write Set_name_;
    property placeholder: string read Fplaceholder write Set_placeholder;
    property readOnly: boolean read FreadOnly write Set_readOnly default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showClearButton: boolean read FshowClearButton write Set_showClearButton default false;
    property showMaskMode: TdxMaskMode read FshowMaskMode write Set_showMaskMode default mmAlways;
    property spellcheck: boolean read Fspellcheck write Set_spellcheck default false;
    property stylingMode: TdxEditorStyle read FstylingMode write Set_stylingMode default esOutlined;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property text: string read Ftext;
    property useMaskedValue: boolean read FuseMaskedValue write Set_useMaskedValue default false;
    property validationMessageMode: TdxValidationMessageMode read FvalidationMessageMode write Set_validationMessageMode default vmmAuto;
    property validationMessagePosition: TdxPosition read FvalidationMessagePosition write Set_validationMessagePosition default pBottom;
    property validationStatus: TdxValidationStatus read FvalidationStatus write Set_validationStatus default vsValid;
    property valueChangeEvent: string read FvalueChangeEvent write Set_valueChangeEvent;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onChange: TdxEventHandler read FonChange write Set_onChange;
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onCopy: TdxEventHandler read FonCopy write Set_onCopy;
    property onCut: TdxEventHandler read FonCut write Set_onCut;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onEnterKey: TdxEventHandler read FonEnterKey write Set_onEnterKey;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onInput: TdxEventHandler read FonInput write Set_onInput;
    property onKeyDown: TdxEventHandler read FonKeyDown write Set_onKeyDown;
    property onKeyUp: TdxEventHandler read FonKeyUp write Set_onKeyUp;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onPaste: TdxEventHandler read FonPaste write Set_onPaste;
    property onValueChanged: TdxEventHandler read FonValueChanged write Set_onValueChanged;
  end;

implementation


procedure TjdxCustomTextBox.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  Fbuttons := TJSArray.new;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FinputAttr := nil;
  FisValid := true;
  Flabel_ := '';
  FlabelMode := lmFloating;
  Fmask := '';
  FmaskChar := '';
  FmaskInvalidMessage := '';
  FmaskRules := nil;
  FmaxLength := nil;
  Fmode := tbtText;
  Fname_ := '';
  Fplaceholder := '';
  FreadOnly := false;
  FrtlEnabled := false;
  FshowClearButton := false;
  FshowMaskMode := mmAlways;
  Fspellcheck := false;
  FstylingMode := esOutlined;
  FtabIndex := 0;
  Ftext := '';
  FuseMaskedValue := false;
  FvalidationError := nil;
  FvalidationErrors := TJSArray.new;
  FvalidationMessageMode := vmmAuto;
  FvalidationMessagePosition := pBottom;
  FvalidationStatus := vsValid;
  Fvalue := nil;
  FvalueChangeEvent := '';
  Fvisible := true;
  Fwidth_ := nil;

  FonChange := nil;
  FonContentReady := nil;
  FonCopy := nil;
  FonCut := nil;
  FonDisposing := nil;
  FonEnterKey := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonInput := nil;
  FonKeyDown := nil;
  FonKeyUp := nil;
  FonOptionChanged := nil;
  FonPaste := nil;
  FonValueChanged := nil;
end;
procedure TjdxCustomTextBox.InitJQuery;
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
      $(id).dxTextBox(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomTextBox.getInstance(element: TJSObject): TdxTextBox;
asm
  return DevExpress.viz.dxTextBox.getInstance(element);
end;

function TjdxCustomTextBox.instance: TdxTextBox;
asm
  return $(this.GetJQID()).dxTextBox("instance");
end;
procedure TjdxCustomTextBox.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('buttons', buttons);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('inputAttr', inputAttr);
    SetOption('isValid', isValid);
    SetOption('label', label_);
    SetOption('labelMode', labelMode.ToString());
    SetOption('mask', mask);
    SetOption('maskChar', maskChar);
    SetOption('maskInvalidMessage', maskInvalidMessage);
    SetOption('maskRules', maskRules);
    SetOption('maxLength', maxLength);
    SetOption('mode', mode.ToString());
    SetOption('name', name_);
    SetOption('placeholder', placeholder);
    SetOption('readOnly', readOnly);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('showClearButton', showClearButton);
    SetOption('showMaskMode', showMaskMode.ToString());
    SetOption('spellcheck', spellcheck);
    SetOption('stylingMode', stylingMode.ToString());
    SetOption('tabIndex', tabIndex);
    SetOption('text', text);
    SetOption('useMaskedValue', useMaskedValue);
    SetOption('validationError', validationError);
    SetOption('validationErrors', validationErrors);
    SetOption('validationMessageMode', validationMessageMode.ToString());
    SetOption('validationMessagePosition', validationMessagePosition.ToString());
    SetOption('validationStatus', validationStatus.ToString());
    SetOption('value', value);
    SetOption('valueChangeEvent', valueChangeEvent);
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('change', onChange);
    SetEvent('contentReady', onContentReady);
    SetEvent('copy', onCopy);
    SetEvent('cut', onCut);
    SetEvent('disposing', onDisposing);
    SetEvent('enterKey', onEnterKey);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('input', onInput);
    SetEvent('keyDown', onKeyDown);
    SetEvent('keyUp', onKeyUp);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('paste', onPaste);
    SetEvent('valueChanged', onValueChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomTextBox.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomTextBox.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomTextBox.Set_buttons(const Value: TJSArray);
begin
  Fbuttons := Value;
  SetOption('buttons', buttons);
end;

procedure TjdxCustomTextBox.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomTextBox.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomTextBox.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomTextBox.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomTextBox.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomTextBox.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomTextBox.Set_inputAttr(const Value: JSValue);
begin
  FinputAttr := Value;
  SetOption('inputAttr', inputAttr);
end;

procedure TjdxCustomTextBox.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
  SetOption('isValid', isValid);
end;

procedure TjdxCustomTextBox.Set_label_(const Value: string);
begin
  Flabel_ := Value;
  SetOption('label', label_);
end;

procedure TjdxCustomTextBox.Set_labelMode(const Value: TdxLabelMode);
begin
  FlabelMode := Value;
  SetOption('labelMode', labelMode.ToString());
end;

procedure TjdxCustomTextBox.Set_mask(const Value: string);
begin
  Fmask := Value;
  SetOption('mask', mask);
end;

procedure TjdxCustomTextBox.Set_maskChar(const Value: string);
begin
  FmaskChar := Value;
  SetOption('maskChar', maskChar);
end;

procedure TjdxCustomTextBox.Set_maskInvalidMessage(const Value: string);
begin
  FmaskInvalidMessage := Value;
  SetOption('maskInvalidMessage', maskInvalidMessage);
end;

procedure TjdxCustomTextBox.Set_maskRules(const Value: JSValue);
begin
  FmaskRules := Value;
  SetOption('maskRules', maskRules);
end;

procedure TjdxCustomTextBox.Set_maxLength(const Value: JSValue);
begin
  FmaxLength := Value;
  SetOption('maxLength', maxLength);
end;

procedure TjdxCustomTextBox.Set_mode(const Value: TdxTextBoxType);
begin
  Fmode := Value;
  SetOption('mode', mode.ToString());
end;

procedure TjdxCustomTextBox.Set_name_(const Value: string);
begin
  Fname_ := Value;
  SetOption('name', name_);
end;

procedure TjdxCustomTextBox.Set_placeholder(const Value: string);
begin
  Fplaceholder := Value;
  SetOption('placeholder', placeholder);
end;

procedure TjdxCustomTextBox.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
  SetOption('readOnly', readOnly);
end;

procedure TjdxCustomTextBox.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomTextBox.Set_showClearButton(const Value: boolean);
begin
  FshowClearButton := Value;
  SetOption('showClearButton', showClearButton);
end;

procedure TjdxCustomTextBox.Set_showMaskMode(const Value: TdxMaskMode);
begin
  FshowMaskMode := Value;
  SetOption('showMaskMode', showMaskMode.ToString());
end;

procedure TjdxCustomTextBox.Set_spellcheck(const Value: boolean);
begin
  Fspellcheck := Value;
  SetOption('spellcheck', spellcheck);
end;

procedure TjdxCustomTextBox.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
  SetOption('stylingMode', stylingMode.ToString());
end;

procedure TjdxCustomTextBox.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomTextBox.Set_useMaskedValue(const Value: boolean);
begin
  FuseMaskedValue := Value;
  SetOption('useMaskedValue', useMaskedValue);
end;

procedure TjdxCustomTextBox.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
  SetOption('validationError', validationError);
end;

procedure TjdxCustomTextBox.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
  SetOption('validationErrors', validationErrors);
end;

procedure TjdxCustomTextBox.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
  SetOption('validationMessageMode', validationMessageMode.ToString());
end;

procedure TjdxCustomTextBox.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
  SetOption('validationMessagePosition', validationMessagePosition.ToString());
end;

procedure TjdxCustomTextBox.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
  SetOption('validationStatus', validationStatus.ToString());
end;

procedure TjdxCustomTextBox.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
  SetOption('value', value);
end;

procedure TjdxCustomTextBox.Set_valueChangeEvent(const Value: string);
begin
  FvalueChangeEvent := Value;
  SetOption('valueChangeEvent', valueChangeEvent);
end;

procedure TjdxCustomTextBox.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomTextBox.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomTextBox.Set_onChange(const Value: TdxEventHandler);
begin
  FonChange := Value;
  SetEvent('change', onChange);
end;

procedure TjdxCustomTextBox.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomTextBox.Set_onCopy(const Value: TdxEventHandler);
begin
  FonCopy := Value;
  SetEvent('copy', onCopy);
end;

procedure TjdxCustomTextBox.Set_onCut(const Value: TdxEventHandler);
begin
  FonCut := Value;
  SetEvent('cut', onCut);
end;

procedure TjdxCustomTextBox.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomTextBox.Set_onEnterKey(const Value: TdxEventHandler);
begin
  FonEnterKey := Value;
  SetEvent('enterKey', onEnterKey);
end;

procedure TjdxCustomTextBox.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomTextBox.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomTextBox.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomTextBox.Set_onInput(const Value: TdxEventHandler);
begin
  FonInput := Value;
  SetEvent('input', onInput);
end;

procedure TjdxCustomTextBox.Set_onKeyDown(const Value: TdxEventHandler);
begin
  FonKeyDown := Value;
  SetEvent('keyDown', onKeyDown);
end;

procedure TjdxCustomTextBox.Set_onKeyUp(const Value: TdxEventHandler);
begin
  FonKeyUp := Value;
  SetEvent('keyUp', onKeyUp);
end;

procedure TjdxCustomTextBox.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomTextBox.Set_onPaste(const Value: TdxEventHandler);
begin
  FonPaste := Value;
  SetEvent('paste', onPaste);
end;

procedure TjdxCustomTextBox.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
  SetEvent('valueChanged', onValueChanged);
end;

procedure TjdxCustomTextBox.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomTextBox.blur();
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  _instance.blur();
end;

procedure TjdxCustomTextBox.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomTextBox.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomTextBox.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomTextBox.dispose();
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  _instance.dispose();
end;

function TjdxCustomTextBox.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  return _instance.element();
end;

procedure TjdxCustomTextBox.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomTextBox.focus();
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  _instance.focus();
end;

function TjdxCustomTextBox.getButton(name_: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  return _instance.getButton(name_);
end;

function TjdxCustomTextBox.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomTextBox.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  return _instance.off(eventName);
end;

function TjdxCustomTextBox.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  return _instance.on(events);
end;

function TjdxCustomTextBox.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomTextBox.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  return _instance.option(optionName);
end;

function TjdxCustomTextBox.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  return _instance.option();
end;

procedure TjdxCustomTextBox.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  _instance.option(options);
end;

procedure TjdxCustomTextBox.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomTextBox.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomTextBox.repaint();
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  _instance.repaint();
end;

procedure TjdxCustomTextBox.reset();
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  _instance.reset();
end;

procedure TjdxCustomTextBox.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxTextBox("instance");
  _instance.resetOption(optionName);
end;

end.
