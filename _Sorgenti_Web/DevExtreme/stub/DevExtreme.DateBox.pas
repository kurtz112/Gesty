unit DevExtreme.DateBox;

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
  DevExtreme.Types;

type
  [ComponentPlatforms(TMSWebPlatform)]
  TjdxDateBox = class(TjdxCustomControl)
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
  public
    constructor Create(aOwner: TComponent); override;
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


constructor TjdxDateBox.Create(aOwner: TComponent);
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

procedure TjdxDateBox.Set_acceptCustomValue(const Value: boolean);
begin
  FacceptCustomValue := Value;
end;

procedure TjdxDateBox.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxDateBox.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxDateBox.Set_adaptivityEnabled(const Value: boolean);
begin
  FadaptivityEnabled := Value;
end;

procedure TjdxDateBox.Set_applyButtonText(const Value: string);
begin
  FapplyButtonText := Value;
end;

procedure TjdxDateBox.Set_applyValueMode(const Value: TdxApplyValueMode);
begin
  FapplyValueMode := Value;
end;

procedure TjdxDateBox.Set_buttons(const Value: TJSArray);
begin
  Fbuttons := Value;
end;

procedure TjdxDateBox.Set_calendarOptions(const Value: JSValue);
begin
  FcalendarOptions := Value;
end;

procedure TjdxDateBox.Set_cancelButtonText(const Value: string);
begin
  FcancelButtonText := Value;
end;

procedure TjdxDateBox.Set_dateOutOfRangeMessage(const Value: string);
begin
  FdateOutOfRangeMessage := Value;
end;

procedure TjdxDateBox.Set_dateSerializationFormat(const Value: string);
begin
  FdateSerializationFormat := Value;
end;

procedure TjdxDateBox.Set_deferRendering(const Value: boolean);
begin
  FdeferRendering := Value;
end;

procedure TjdxDateBox.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxDateBox.Set_disabledDates(const Value: JSValue);
begin
  FdisabledDates := Value;
end;

procedure TjdxDateBox.Set_displayFormat(const Value: JSValue);
begin
  FdisplayFormat := Value;
end;

procedure TjdxDateBox.Set_dropDownButtonTemplate(const Value: JSValue);
begin
  FdropDownButtonTemplate := Value;
end;

procedure TjdxDateBox.Set_dropDownOptions(const Value: JSValue);
begin
  FdropDownOptions := Value;
end;

procedure TjdxDateBox.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxDateBox.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxDateBox.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxDateBox.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxDateBox.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxDateBox.Set_inputAttr(const Value: JSValue);
begin
  FinputAttr := Value;
end;

procedure TjdxDateBox.Set_interval(const Value: integer);
begin
  Finterval := Value;
end;

procedure TjdxDateBox.Set_invalidDateMessage(const Value: string);
begin
  FinvalidDateMessage := Value;
end;

procedure TjdxDateBox.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
end;

procedure TjdxDateBox.Set_label_(const Value: string);
begin
  Flabel_ := Value;
end;

procedure TjdxDateBox.Set_labelMode(const Value: TdxLabelMode);
begin
  FlabelMode := Value;
end;

procedure TjdxDateBox.Set_mask(const Value: string);
begin
  Fmask := Value;
end;

procedure TjdxDateBox.Set_maskChar(const Value: string);
begin
  FmaskChar := Value;
end;

procedure TjdxDateBox.Set_maskInvalidMessage(const Value: string);
begin
  FmaskInvalidMessage := Value;
end;

procedure TjdxDateBox.Set_maskRules(const Value: JSValue);
begin
  FmaskRules := Value;
end;

procedure TjdxDateBox.Set_max(const Value: JSValue);
begin
  Fmax := Value;
end;

procedure TjdxDateBox.Set_maxLength(const Value: JSValue);
begin
  FmaxLength := Value;
end;

procedure TjdxDateBox.Set_min(const Value: JSValue);
begin
  Fmin := Value;
end;

procedure TjdxDateBox.Set_mode(const Value: TdxTextBoxType);
begin
  Fmode := Value;
end;

procedure TjdxDateBox.Set_name_(const Value: string);
begin
  Fname_ := Value;
end;

procedure TjdxDateBox.Set_opened(const Value: boolean);
begin
  Fopened := Value;
end;

procedure TjdxDateBox.Set_openOnFieldClick(const Value: boolean);
begin
  FopenOnFieldClick := Value;
end;

procedure TjdxDateBox.Set_pickerType(const Value: TdxDatePickerType);
begin
  FpickerType := Value;
end;

procedure TjdxDateBox.Set_placeholder(const Value: string);
begin
  Fplaceholder := Value;
end;

procedure TjdxDateBox.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
end;

procedure TjdxDateBox.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxDateBox.Set_showAnalogClock(const Value: boolean);
begin
  FshowAnalogClock := Value;
end;

procedure TjdxDateBox.Set_showClearButton(const Value: boolean);
begin
  FshowClearButton := Value;
end;

procedure TjdxDateBox.Set_showDropDownButton(const Value: boolean);
begin
  FshowDropDownButton := Value;
end;

procedure TjdxDateBox.Set_showMaskMode(const Value: TdxMaskMode);
begin
  FshowMaskMode := Value;
end;

procedure TjdxDateBox.Set_spellcheck(const Value: boolean);
begin
  Fspellcheck := Value;
end;

procedure TjdxDateBox.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
end;

procedure TjdxDateBox.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxDateBox.Set_todayButtonText(const Value: string);
begin
  FtodayButtonText := Value;
end;

procedure TjdxDateBox.Set_type_(const Value: TdxDateType);
begin
  Ftype_ := Value;
end;

procedure TjdxDateBox.Set_useMaskBehavior(const Value: boolean);
begin
  FuseMaskBehavior := Value;
end;

procedure TjdxDateBox.Set_useMaskedValue(const Value: boolean);
begin
  FuseMaskedValue := Value;
end;

procedure TjdxDateBox.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
end;

procedure TjdxDateBox.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
end;

procedure TjdxDateBox.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
end;

procedure TjdxDateBox.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
end;

procedure TjdxDateBox.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
end;

procedure TjdxDateBox.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
end;

procedure TjdxDateBox.Set_valueChangeEvent(const Value: string);
begin
  FvalueChangeEvent := Value;
end;

procedure TjdxDateBox.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxDateBox.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxDateBox.Set_onChange(const Value: TdxEventHandler);
begin
  FonChange := Value;
end;

procedure TjdxDateBox.Set_onClosed(const Value: TdxEventHandler);
begin
  FonClosed := Value;
end;

procedure TjdxDateBox.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxDateBox.Set_onCopy(const Value: TdxEventHandler);
begin
  FonCopy := Value;
end;

procedure TjdxDateBox.Set_onCut(const Value: TdxEventHandler);
begin
  FonCut := Value;
end;

procedure TjdxDateBox.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxDateBox.Set_onEnterKey(const Value: TdxEventHandler);
begin
  FonEnterKey := Value;
end;

procedure TjdxDateBox.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxDateBox.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxDateBox.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxDateBox.Set_onInput(const Value: TdxEventHandler);
begin
  FonInput := Value;
end;

procedure TjdxDateBox.Set_onKeyDown(const Value: TdxEventHandler);
begin
  FonKeyDown := Value;
end;

procedure TjdxDateBox.Set_onKeyUp(const Value: TdxEventHandler);
begin
  FonKeyUp := Value;
end;

procedure TjdxDateBox.Set_onOpened(const Value: TdxEventHandler);
begin
  FonOpened := Value;
end;

procedure TjdxDateBox.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxDateBox.Set_onPaste(const Value: TdxEventHandler);
begin
  FonPaste := Value;
end;

procedure TjdxDateBox.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
end;

end.
