unit DevExtreme.DateBox.Custom;

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
  DevExtreme.DateBox.JS,
  DevExtreme.Types;

type
  TjdxCustomDateBox = class(TjdxCustomControl)
  private
    FacceptCustomValue: boolean;
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FadaptivityEnabled: boolean;
    FapplyButtonText: string;
    FapplyValueMode: TdxApplyValueMode;
    Fbuttons: TJSArray;
    FcalendarOptions: JSValue;
    FcancelButtonText: string;
    FdateOutOfRangeMessage: string;
    FdateSerializationFormat: string;
    FdeferRendering: boolean;
    Fdisabled: boolean;
    FdisabledDates: JSValue;
    FdisplayFormat: JSValue;
    FdropDownButtonTemplate: JSValue;
    FdropDownOptions: JSValue;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FinputAttr: JSValue;
    Finterval: integer;
    FinvalidDateMessage: string;
    FisValid: boolean;
    Flabel_: string;
    FlabelMode: TdxLabelMode;
    Fmask: string;
    FmaskChar: string;
    FmaskInvalidMessage: string;
    FmaskRules: JSValue;
    Fmax: JSValue;
    FmaxLength: JSValue;
    Fmin: JSValue;
    Fmode: TdxTextBoxType;
    Fname_: string;
    Fopened: boolean;
    FopenOnFieldClick: boolean;
    FpickerType: TdxDatePickerType;
    Fplaceholder: string;
    FreadOnly: boolean;
    FrtlEnabled: boolean;
    FshowAnalogClock: boolean;
    FshowClearButton: boolean;
    FshowDropDownButton: boolean;
    FshowMaskMode: TdxMaskMode;
    Fspellcheck: boolean;
    FstylingMode: TdxEditorStyle;
    FtabIndex: integer;
    Ftext: string;
    FtodayButtonText: string;
    Ftype_: TdxDateType;
    FuseMaskBehavior: boolean;
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
    FonClosed: TdxEventHandler;
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
    FonOpened: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonPaste: TdxEventHandler;
    FonValueChanged: TdxEventHandler;
  private
    procedure Set_acceptCustomValue(const value: boolean);
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_adaptivityEnabled(const value: boolean);
    procedure Set_applyButtonText(const value: string);
    procedure Set_applyValueMode(const value: TdxApplyValueMode);
    procedure Set_buttons(const value: TJSArray);
    procedure Set_calendarOptions(const value: JSValue);
    procedure Set_cancelButtonText(const value: string);
    procedure Set_dateOutOfRangeMessage(const value: string);
    procedure Set_dateSerializationFormat(const value: string);
    procedure Set_deferRendering(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_disabledDates(const value: JSValue);
    procedure Set_displayFormat(const value: JSValue);
    procedure Set_dropDownButtonTemplate(const value: JSValue);
    procedure Set_dropDownOptions(const value: JSValue);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_inputAttr(const value: JSValue);
    procedure Set_interval(const value: integer);
    procedure Set_invalidDateMessage(const value: string);
    procedure Set_isValid(const value: boolean);
    procedure Set_label_(const value: string);
    procedure Set_labelMode(const value: TdxLabelMode);
    procedure Set_mask(const value: string);
    procedure Set_maskChar(const value: string);
    procedure Set_maskInvalidMessage(const value: string);
    procedure Set_maskRules(const value: JSValue);
    procedure Set_max(const value: JSValue);
    procedure Set_maxLength(const value: JSValue);
    procedure Set_min(const value: JSValue);
    procedure Set_mode(const value: TdxTextBoxType);
    procedure Set_name_(const value: string);
    procedure Set_opened(const value: boolean);
    procedure Set_openOnFieldClick(const value: boolean);
    procedure Set_pickerType(const value: TdxDatePickerType);
    procedure Set_placeholder(const value: string);
    procedure Set_readOnly(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_showAnalogClock(const value: boolean);
    procedure Set_showClearButton(const value: boolean);
    procedure Set_showDropDownButton(const value: boolean);
    procedure Set_showMaskMode(const value: TdxMaskMode);
    procedure Set_spellcheck(const value: boolean);
    procedure Set_stylingMode(const value: TdxEditorStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_todayButtonText(const value: string);
    procedure Set_type_(const value: TdxDateType);
    procedure Set_useMaskBehavior(const value: boolean);
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
    procedure Set_onClosed(const value: TdxEventHandler);
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
    procedure Set_onOpened(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onPaste(const value: TdxEventHandler);
    procedure Set_onValueChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxDateBox; assembler;
    function instance: TdxDateBox; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure blur(); assembler;
    procedure close(); assembler; overload;
    function content(): TJSElement; assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    function field(): TJSElement; assembler;
    procedure focus(); assembler; overload;
    function getButton(name_: string): JSValue; assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    procedure open(); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure repaint(); assembler;
    procedure reset(); assembler;
    procedure resetOption(optionName: string); assembler;
  public
    property buttons: TJSArray read Fbuttons write Set_buttons;
    property calendarOptions: JSValue read FcalendarOptions write Set_calendarOptions;
    property disabledDates: JSValue read FdisabledDates write Set_disabledDates;
    property displayFormat: JSValue read FdisplayFormat write Set_displayFormat;
    property dropDownButtonTemplate: JSValue read FdropDownButtonTemplate write Set_dropDownButtonTemplate;
    property dropDownOptions: JSValue read FdropDownOptions write Set_dropDownOptions;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property inputAttr: JSValue read FinputAttr write Set_inputAttr;
    property maskRules: JSValue read FmaskRules write Set_maskRules;
    property max: JSValue read Fmax write Set_max;
    property maxLength: JSValue read FmaxLength write Set_maxLength;
    property min: JSValue read Fmin write Set_min;
    property validationError: JSValue read FvalidationError write Set_validationError;
    property validationErrors: TJSArray read FvalidationErrors write Set_validationErrors;
    property value: JSValue read Fvalue write Set_value;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property acceptCustomValue: boolean read FacceptCustomValue write Set_acceptCustomValue default true;
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property adaptivityEnabled: boolean read FadaptivityEnabled write Set_adaptivityEnabled default false;
    property applyButtonText: string read FapplyButtonText write Set_applyButtonText;
    property applyValueMode: TdxApplyValueMode read FapplyValueMode write Set_applyValueMode default avmInstantly;
    property cancelButtonText: string read FcancelButtonText write Set_cancelButtonText;
    property dateOutOfRangeMessage: string read FdateOutOfRangeMessage write Set_dateOutOfRangeMessage;
    property dateSerializationFormat: string read FdateSerializationFormat write Set_dateSerializationFormat;
    property deferRendering: boolean read FdeferRendering write Set_deferRendering default true;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property interval: integer read Finterval write Set_interval;
    property invalidDateMessage: string read FinvalidDateMessage write Set_invalidDateMessage;
    property isValid: boolean read FisValid write Set_isValid default true;
    property label_: string read Flabel_ write Set_label_;
    property labelMode: TdxLabelMode read FlabelMode write Set_labelMode default lmFloating;
    property mask: string read Fmask write Set_mask;
    property maskChar: string read FmaskChar write Set_maskChar;
    property maskInvalidMessage: string read FmaskInvalidMessage write Set_maskInvalidMessage;
    property mode: TdxTextBoxType read Fmode write Set_mode default tbtText;
    property name_: string read Fname_ write Set_name_;
    property opened: boolean read Fopened write Set_opened default false;
    property openOnFieldClick: boolean read FopenOnFieldClick write Set_openOnFieldClick default false;
    property pickerType: TdxDatePickerType read FpickerType write Set_pickerType default dptCalendar;
    property placeholder: string read Fplaceholder write Set_placeholder;
    property readOnly: boolean read FreadOnly write Set_readOnly default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showAnalogClock: boolean read FshowAnalogClock write Set_showAnalogClock default true;
    property showClearButton: boolean read FshowClearButton write Set_showClearButton default false;
    property showDropDownButton: boolean read FshowDropDownButton write Set_showDropDownButton default true;
    property showMaskMode: TdxMaskMode read FshowMaskMode write Set_showMaskMode default mmAlways;
    property spellcheck: boolean read Fspellcheck write Set_spellcheck default false;
    property stylingMode: TdxEditorStyle read FstylingMode write Set_stylingMode default esOutlined;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property text: string read Ftext;
    property todayButtonText: string read FtodayButtonText write Set_todayButtonText;
    property type_: TdxDateType read Ftype_ write Set_type_ default dttDate;
    property useMaskBehavior: boolean read FuseMaskBehavior write Set_useMaskBehavior default false;
    property useMaskedValue: boolean read FuseMaskedValue write Set_useMaskedValue default false;
    property validationMessageMode: TdxValidationMessageMode read FvalidationMessageMode write Set_validationMessageMode default vmmAuto;
    property validationMessagePosition: TdxPosition read FvalidationMessagePosition write Set_validationMessagePosition default pBottom;
    property validationStatus: TdxValidationStatus read FvalidationStatus write Set_validationStatus default vsValid;
    property valueChangeEvent: string read FvalueChangeEvent write Set_valueChangeEvent;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onChange: TdxEventHandler read FonChange write Set_onChange;
    property onClosed: TdxEventHandler read FonClosed write Set_onClosed;
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
    property onOpened: TdxEventHandler read FonOpened write Set_onOpened;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onPaste: TdxEventHandler read FonPaste write Set_onPaste;
    property onValueChanged: TdxEventHandler read FonValueChanged write Set_onValueChanged;
  end;

implementation


procedure TjdxCustomDateBox.CreateInitialize;
begin
  inherited;
  FacceptCustomValue := true;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FadaptivityEnabled := false;
  FapplyButtonText := '';
  FapplyValueMode := avmInstantly;
  Fbuttons := TJSArray.new;
  FcalendarOptions := nil;
  FcancelButtonText := '';
  FdateOutOfRangeMessage := '';
  FdateSerializationFormat := '';
  FdeferRendering := true;
  Fdisabled := false;
  FdisabledDates := nil;
  FdisplayFormat := nil;
  FdropDownButtonTemplate := nil;
  FdropDownOptions := nil;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FinputAttr := nil;
  Finterval := 0;
  FinvalidDateMessage := '';
  FisValid := true;
  Flabel_ := '';
  FlabelMode := lmFloating;
  Fmask := '';
  FmaskChar := '';
  FmaskInvalidMessage := '';
  FmaskRules := nil;
  Fmax := nil;
  FmaxLength := nil;
  Fmin := nil;
  Fmode := tbtText;
  Fname_ := '';
  Fopened := false;
  FopenOnFieldClick := false;
  FpickerType := dptCalendar;
  Fplaceholder := '';
  FreadOnly := false;
  FrtlEnabled := false;
  FshowAnalogClock := true;
  FshowClearButton := false;
  FshowDropDownButton := true;
  FshowMaskMode := mmAlways;
  Fspellcheck := false;
  FstylingMode := esOutlined;
  FtabIndex := 0;
  Ftext := '';
  FtodayButtonText := '';
  Ftype_ := dttDate;
  FuseMaskBehavior := false;
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
  FonClosed := nil;
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
  FonOpened := nil;
  FonOptionChanged := nil;
  FonPaste := nil;
  FonValueChanged := nil;
end;
procedure TjdxCustomDateBox.InitJQuery;
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
      $(id).dxDateBox(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomDateBox.getInstance(element: TJSObject): TdxDateBox;
asm
  return DevExpress.viz.dxDateBox.getInstance(element);
end;

function TjdxCustomDateBox.instance: TdxDateBox;
asm
  return $(this.GetJQID()).dxDateBox("instance");
end;
procedure TjdxCustomDateBox.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('acceptCustomValue', acceptCustomValue);
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('adaptivityEnabled', adaptivityEnabled);
    SetOption('applyButtonText', applyButtonText);
    SetOption('applyValueMode', applyValueMode.ToString());
    SetOption('buttons', buttons);
    SetOption('calendarOptions', calendarOptions);
    SetOption('cancelButtonText', cancelButtonText);
    SetOption('dateOutOfRangeMessage', dateOutOfRangeMessage);
    SetOption('dateSerializationFormat', dateSerializationFormat);
    SetOption('deferRendering', deferRendering);
    SetOption('disabled', disabled);
    SetOption('disabledDates', disabledDates);
    SetOption('displayFormat', displayFormat);
    SetOption('dropDownButtonTemplate', dropDownButtonTemplate);
    SetOption('dropDownOptions', dropDownOptions);
    SetOption('elementAttr', elementAttr);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('inputAttr', inputAttr);
    SetOption('interval', interval);
    SetOption('invalidDateMessage', invalidDateMessage);
    SetOption('isValid', isValid);
    SetOption('label', label_);
    SetOption('labelMode', labelMode.ToString());
    SetOption('mask', mask);
    SetOption('maskChar', maskChar);
    SetOption('maskInvalidMessage', maskInvalidMessage);
    SetOption('maskRules', maskRules);
    SetOption('max', max);
    SetOption('maxLength', maxLength);
    SetOption('min', min);
    SetOption('mode', mode.ToString());
    SetOption('name', name_);
    SetOption('opened', opened);
    SetOption('openOnFieldClick', openOnFieldClick);
    SetOption('pickerType', pickerType.ToString());
    SetOption('placeholder', placeholder);
    SetOption('readOnly', readOnly);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('showAnalogClock', showAnalogClock);
    SetOption('showClearButton', showClearButton);
    SetOption('showDropDownButton', showDropDownButton);
    SetOption('showMaskMode', showMaskMode.ToString());
    SetOption('spellcheck', spellcheck);
    SetOption('stylingMode', stylingMode.ToString());
    SetOption('tabIndex', tabIndex);
    SetOption('text', text);
    SetOption('todayButtonText', todayButtonText);
    SetOption('type', type_.ToString());
    SetOption('useMaskBehavior', useMaskBehavior);
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
    SetEvent('closed', onClosed);
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
    SetEvent('opened', onOpened);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('paste', onPaste);
    SetEvent('valueChanged', onValueChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomDateBox.Set_acceptCustomValue(const Value: boolean);
begin
  FacceptCustomValue := Value;
  SetOption('acceptCustomValue', acceptCustomValue);
end;

procedure TjdxCustomDateBox.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomDateBox.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomDateBox.Set_adaptivityEnabled(const Value: boolean);
begin
  FadaptivityEnabled := Value;
  SetOption('adaptivityEnabled', adaptivityEnabled);
end;

procedure TjdxCustomDateBox.Set_applyButtonText(const Value: string);
begin
  FapplyButtonText := Value;
  SetOption('applyButtonText', applyButtonText);
end;

procedure TjdxCustomDateBox.Set_applyValueMode(const Value: TdxApplyValueMode);
begin
  FapplyValueMode := Value;
  SetOption('applyValueMode', applyValueMode.ToString());
end;

procedure TjdxCustomDateBox.Set_buttons(const Value: TJSArray);
begin
  Fbuttons := Value;
  SetOption('buttons', buttons);
end;

procedure TjdxCustomDateBox.Set_calendarOptions(const Value: JSValue);
begin
  FcalendarOptions := Value;
  SetOption('calendarOptions', calendarOptions);
end;

procedure TjdxCustomDateBox.Set_cancelButtonText(const Value: string);
begin
  FcancelButtonText := Value;
  SetOption('cancelButtonText', cancelButtonText);
end;

procedure TjdxCustomDateBox.Set_dateOutOfRangeMessage(const Value: string);
begin
  FdateOutOfRangeMessage := Value;
  SetOption('dateOutOfRangeMessage', dateOutOfRangeMessage);
end;

procedure TjdxCustomDateBox.Set_dateSerializationFormat(const Value: string);
begin
  FdateSerializationFormat := Value;
  SetOption('dateSerializationFormat', dateSerializationFormat);
end;

procedure TjdxCustomDateBox.Set_deferRendering(const Value: boolean);
begin
  FdeferRendering := Value;
  SetOption('deferRendering', deferRendering);
end;

procedure TjdxCustomDateBox.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomDateBox.Set_disabledDates(const Value: JSValue);
begin
  FdisabledDates := Value;
  SetOption('disabledDates', disabledDates);
end;

procedure TjdxCustomDateBox.Set_displayFormat(const Value: JSValue);
begin
  FdisplayFormat := Value;
  SetOption('displayFormat', displayFormat);
end;

procedure TjdxCustomDateBox.Set_dropDownButtonTemplate(const Value: JSValue);
begin
  FdropDownButtonTemplate := Value;
  SetOption('dropDownButtonTemplate', dropDownButtonTemplate);
end;

procedure TjdxCustomDateBox.Set_dropDownOptions(const Value: JSValue);
begin
  FdropDownOptions := Value;
  SetOption('dropDownOptions', dropDownOptions);
end;

procedure TjdxCustomDateBox.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomDateBox.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomDateBox.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomDateBox.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomDateBox.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomDateBox.Set_inputAttr(const Value: JSValue);
begin
  FinputAttr := Value;
  SetOption('inputAttr', inputAttr);
end;

procedure TjdxCustomDateBox.Set_interval(const Value: integer);
begin
  Finterval := Value;
  SetOption('interval', interval);
end;

procedure TjdxCustomDateBox.Set_invalidDateMessage(const Value: string);
begin
  FinvalidDateMessage := Value;
  SetOption('invalidDateMessage', invalidDateMessage);
end;

procedure TjdxCustomDateBox.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
  SetOption('isValid', isValid);
end;

procedure TjdxCustomDateBox.Set_label_(const Value: string);
begin
  Flabel_ := Value;
  SetOption('label', label_);
end;

procedure TjdxCustomDateBox.Set_labelMode(const Value: TdxLabelMode);
begin
  FlabelMode := Value;
  SetOption('labelMode', labelMode.ToString());
end;

procedure TjdxCustomDateBox.Set_mask(const Value: string);
begin
  Fmask := Value;
  SetOption('mask', mask);
end;

procedure TjdxCustomDateBox.Set_maskChar(const Value: string);
begin
  FmaskChar := Value;
  SetOption('maskChar', maskChar);
end;

procedure TjdxCustomDateBox.Set_maskInvalidMessage(const Value: string);
begin
  FmaskInvalidMessage := Value;
  SetOption('maskInvalidMessage', maskInvalidMessage);
end;

procedure TjdxCustomDateBox.Set_maskRules(const Value: JSValue);
begin
  FmaskRules := Value;
  SetOption('maskRules', maskRules);
end;

procedure TjdxCustomDateBox.Set_max(const Value: JSValue);
begin
  Fmax := Value;
  SetOption('max', max);
end;

procedure TjdxCustomDateBox.Set_maxLength(const Value: JSValue);
begin
  FmaxLength := Value;
  SetOption('maxLength', maxLength);
end;

procedure TjdxCustomDateBox.Set_min(const Value: JSValue);
begin
  Fmin := Value;
  SetOption('min', min);
end;

procedure TjdxCustomDateBox.Set_mode(const Value: TdxTextBoxType);
begin
  Fmode := Value;
  SetOption('mode', mode.ToString());
end;

procedure TjdxCustomDateBox.Set_name_(const Value: string);
begin
  Fname_ := Value;
  SetOption('name', name_);
end;

procedure TjdxCustomDateBox.Set_opened(const Value: boolean);
begin
  Fopened := Value;
  SetOption('opened', opened);
end;

procedure TjdxCustomDateBox.Set_openOnFieldClick(const Value: boolean);
begin
  FopenOnFieldClick := Value;
  SetOption('openOnFieldClick', openOnFieldClick);
end;

procedure TjdxCustomDateBox.Set_pickerType(const Value: TdxDatePickerType);
begin
  FpickerType := Value;
  SetOption('pickerType', pickerType.ToString());
end;

procedure TjdxCustomDateBox.Set_placeholder(const Value: string);
begin
  Fplaceholder := Value;
  SetOption('placeholder', placeholder);
end;

procedure TjdxCustomDateBox.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
  SetOption('readOnly', readOnly);
end;

procedure TjdxCustomDateBox.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomDateBox.Set_showAnalogClock(const Value: boolean);
begin
  FshowAnalogClock := Value;
  SetOption('showAnalogClock', showAnalogClock);
end;

procedure TjdxCustomDateBox.Set_showClearButton(const Value: boolean);
begin
  FshowClearButton := Value;
  SetOption('showClearButton', showClearButton);
end;

procedure TjdxCustomDateBox.Set_showDropDownButton(const Value: boolean);
begin
  FshowDropDownButton := Value;
  SetOption('showDropDownButton', showDropDownButton);
end;

procedure TjdxCustomDateBox.Set_showMaskMode(const Value: TdxMaskMode);
begin
  FshowMaskMode := Value;
  SetOption('showMaskMode', showMaskMode.ToString());
end;

procedure TjdxCustomDateBox.Set_spellcheck(const Value: boolean);
begin
  Fspellcheck := Value;
  SetOption('spellcheck', spellcheck);
end;

procedure TjdxCustomDateBox.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
  SetOption('stylingMode', stylingMode.ToString());
end;

procedure TjdxCustomDateBox.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomDateBox.Set_todayButtonText(const Value: string);
begin
  FtodayButtonText := Value;
  SetOption('todayButtonText', todayButtonText);
end;

procedure TjdxCustomDateBox.Set_type_(const Value: TdxDateType);
begin
  Ftype_ := Value;
  SetOption('type', type_.ToString());
end;

procedure TjdxCustomDateBox.Set_useMaskBehavior(const Value: boolean);
begin
  FuseMaskBehavior := Value;
  SetOption('useMaskBehavior', useMaskBehavior);
end;

procedure TjdxCustomDateBox.Set_useMaskedValue(const Value: boolean);
begin
  FuseMaskedValue := Value;
  SetOption('useMaskedValue', useMaskedValue);
end;

procedure TjdxCustomDateBox.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
  SetOption('validationError', validationError);
end;

procedure TjdxCustomDateBox.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
  SetOption('validationErrors', validationErrors);
end;

procedure TjdxCustomDateBox.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
  SetOption('validationMessageMode', validationMessageMode.ToString());
end;

procedure TjdxCustomDateBox.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
  SetOption('validationMessagePosition', validationMessagePosition.ToString());
end;

procedure TjdxCustomDateBox.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
  SetOption('validationStatus', validationStatus.ToString());
end;

procedure TjdxCustomDateBox.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
  SetOption('value', value);
end;

procedure TjdxCustomDateBox.Set_valueChangeEvent(const Value: string);
begin
  FvalueChangeEvent := Value;
  SetOption('valueChangeEvent', valueChangeEvent);
end;

procedure TjdxCustomDateBox.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomDateBox.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomDateBox.Set_onChange(const Value: TdxEventHandler);
begin
  FonChange := Value;
  SetEvent('change', onChange);
end;

procedure TjdxCustomDateBox.Set_onClosed(const Value: TdxEventHandler);
begin
  FonClosed := Value;
  SetEvent('closed', onClosed);
end;

procedure TjdxCustomDateBox.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomDateBox.Set_onCopy(const Value: TdxEventHandler);
begin
  FonCopy := Value;
  SetEvent('copy', onCopy);
end;

procedure TjdxCustomDateBox.Set_onCut(const Value: TdxEventHandler);
begin
  FonCut := Value;
  SetEvent('cut', onCut);
end;

procedure TjdxCustomDateBox.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomDateBox.Set_onEnterKey(const Value: TdxEventHandler);
begin
  FonEnterKey := Value;
  SetEvent('enterKey', onEnterKey);
end;

procedure TjdxCustomDateBox.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomDateBox.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomDateBox.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomDateBox.Set_onInput(const Value: TdxEventHandler);
begin
  FonInput := Value;
  SetEvent('input', onInput);
end;

procedure TjdxCustomDateBox.Set_onKeyDown(const Value: TdxEventHandler);
begin
  FonKeyDown := Value;
  SetEvent('keyDown', onKeyDown);
end;

procedure TjdxCustomDateBox.Set_onKeyUp(const Value: TdxEventHandler);
begin
  FonKeyUp := Value;
  SetEvent('keyUp', onKeyUp);
end;

procedure TjdxCustomDateBox.Set_onOpened(const Value: TdxEventHandler);
begin
  FonOpened := Value;
  SetEvent('opened', onOpened);
end;

procedure TjdxCustomDateBox.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomDateBox.Set_onPaste(const Value: TdxEventHandler);
begin
  FonPaste := Value;
  SetEvent('paste', onPaste);
end;

procedure TjdxCustomDateBox.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
  SetEvent('valueChanged', onValueChanged);
end;

procedure TjdxCustomDateBox.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomDateBox.blur();
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  _instance.blur();
end;

procedure TjdxCustomDateBox.close();
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  _instance.close();
end;

function TjdxCustomDateBox.content(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  return _instance.content();
end;

procedure TjdxCustomDateBox.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomDateBox.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomDateBox.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomDateBox.dispose();
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  _instance.dispose();
end;

function TjdxCustomDateBox.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  return _instance.element();
end;

procedure TjdxCustomDateBox.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  _instance.endUpdate();
end;

function TjdxCustomDateBox.field(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  return _instance.field();
end;

procedure TjdxCustomDateBox.focus();
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  _instance.focus();
end;

function TjdxCustomDateBox.getButton(name_: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  return _instance.getButton(name_);
end;

function TjdxCustomDateBox.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomDateBox.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  return _instance.off(eventName);
end;

function TjdxCustomDateBox.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomDateBox.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  return _instance.on(events);
end;

procedure TjdxCustomDateBox.open();
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  _instance.open();
end;

function TjdxCustomDateBox.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  return _instance.option(optionName);
end;

function TjdxCustomDateBox.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  return _instance.option();
end;

procedure TjdxCustomDateBox.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomDateBox.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  _instance.option(options);
end;

procedure TjdxCustomDateBox.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomDateBox.repaint();
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  _instance.repaint();
end;

procedure TjdxCustomDateBox.reset();
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  _instance.reset();
end;

procedure TjdxCustomDateBox.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxDateBox("instance");
  _instance.resetOption(optionName);
end;

end.
