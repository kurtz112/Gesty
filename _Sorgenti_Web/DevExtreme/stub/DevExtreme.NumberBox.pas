unit DevExtreme.NumberBox;

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
  TjdxNumberBox = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fbuttons: TJSArray;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fformat: JSValue;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FinputAttr: JSValue;
    FinvalidValueMessage: string;
    FisValid: boolean;
    Flabel_: string;
    FlabelMode: TdxLabelMode;
    Fmask: string;
    FmaskChar: string;
    FmaskInvalidMessage: string;
    FmaskRules: JSValue;
    Fmax: integer;
    Fmin: integer;
    Fmode: TdxNumberBoxType;
    Fname_: string;
    Fplaceholder: string;
    FreadOnly: boolean;
    FrtlEnabled: boolean;
    FshowClearButton: boolean;
    FshowMaskMode: TdxMaskMode;
    FshowSpinButtons: boolean;
    Fspellcheck: boolean;
    Fstep: integer;
    FstylingMode: TdxEditorStyle;
    FtabIndex: integer;
    Ftext: string;
    FuseLargeSpinButtons: boolean;
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
    procedure Set_format(const value: JSValue);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_inputAttr(const value: JSValue);
    procedure Set_invalidValueMessage(const value: string);
    procedure Set_isValid(const value: boolean);
    procedure Set_label_(const value: string);
    procedure Set_labelMode(const value: TdxLabelMode);
    procedure Set_mask(const value: string);
    procedure Set_maskChar(const value: string);
    procedure Set_maskInvalidMessage(const value: string);
    procedure Set_maskRules(const value: JSValue);
    procedure Set_max(const value: integer);
    procedure Set_min(const value: integer);
    procedure Set_mode(const value: TdxNumberBoxType);
    procedure Set_name_(const value: string);
    procedure Set_placeholder(const value: string);
    procedure Set_readOnly(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_showClearButton(const value: boolean);
    procedure Set_showMaskMode(const value: TdxMaskMode);
    procedure Set_showSpinButtons(const value: boolean);
    procedure Set_spellcheck(const value: boolean);
    procedure Set_step(const value: integer);
    procedure Set_stylingMode(const value: TdxEditorStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_useLargeSpinButtons(const value: boolean);
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
  public
    constructor Create(aOwner: TComponent); override;
  public
    property buttons: TJSArray read Fbuttons write Set_buttons;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property format: JSValue read Fformat write Set_format;
    property height_: JSValue read Fheight_ write Set_height_;
    property inputAttr: JSValue read FinputAttr write Set_inputAttr;
    property maskRules: JSValue read FmaskRules write Set_maskRules;
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
    property invalidValueMessage: string read FinvalidValueMessage write Set_invalidValueMessage;
    property isValid: boolean read FisValid write Set_isValid default true;
    property label_: string read Flabel_ write Set_label_;
    property labelMode: TdxLabelMode read FlabelMode write Set_labelMode default lmFloating;
    property mask: string read Fmask write Set_mask;
    property maskChar: string read FmaskChar write Set_maskChar;
    property maskInvalidMessage: string read FmaskInvalidMessage write Set_maskInvalidMessage;
    property max: integer read Fmax write Set_max;
    property min: integer read Fmin write Set_min;
    property mode: TdxNumberBoxType read Fmode write Set_mode default nbtNumber;
    property name_: string read Fname_ write Set_name_;
    property placeholder: string read Fplaceholder write Set_placeholder;
    property readOnly: boolean read FreadOnly write Set_readOnly default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showClearButton: boolean read FshowClearButton write Set_showClearButton default false;
    property showMaskMode: TdxMaskMode read FshowMaskMode write Set_showMaskMode default mmAlways;
    property showSpinButtons: boolean read FshowSpinButtons write Set_showSpinButtons default false;
    property spellcheck: boolean read Fspellcheck write Set_spellcheck default false;
    property step: integer read Fstep write Set_step;
    property stylingMode: TdxEditorStyle read FstylingMode write Set_stylingMode default esOutlined;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property text: string read Ftext;
    property useLargeSpinButtons: boolean read FuseLargeSpinButtons write Set_useLargeSpinButtons;
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


constructor TjdxNumberBox.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  Fbuttons := TJSArray.new;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fformat := nil;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FinputAttr := nil;
  FinvalidValueMessage := '';
  FisValid := true;
  Flabel_ := '';
  FlabelMode := lmFloating;
  Fmask := '';
  FmaskChar := '';
  FmaskInvalidMessage := '';
  FmaskRules := nil;
  Fmax := 0;
  Fmin := 0;
  Fmode := nbtNumber;
  Fname_ := '';
  Fplaceholder := '';
  FreadOnly := false;
  FrtlEnabled := false;
  FshowClearButton := false;
  FshowMaskMode := mmAlways;
  FshowSpinButtons := false;
  Fspellcheck := false;
  Fstep := 0;
  FstylingMode := esOutlined;
  FtabIndex := 0;
  Ftext := '';
  FuseLargeSpinButtons := false;
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

procedure TjdxNumberBox.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxNumberBox.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxNumberBox.Set_buttons(const Value: TJSArray);
begin
  Fbuttons := Value;
end;

procedure TjdxNumberBox.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxNumberBox.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxNumberBox.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxNumberBox.Set_format(const Value: JSValue);
begin
  Fformat := Value;
end;

procedure TjdxNumberBox.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxNumberBox.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxNumberBox.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxNumberBox.Set_inputAttr(const Value: JSValue);
begin
  FinputAttr := Value;
end;

procedure TjdxNumberBox.Set_invalidValueMessage(const Value: string);
begin
  FinvalidValueMessage := Value;
end;

procedure TjdxNumberBox.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
end;

procedure TjdxNumberBox.Set_label_(const Value: string);
begin
  Flabel_ := Value;
end;

procedure TjdxNumberBox.Set_labelMode(const Value: TdxLabelMode);
begin
  FlabelMode := Value;
end;

procedure TjdxNumberBox.Set_mask(const Value: string);
begin
  Fmask := Value;
end;

procedure TjdxNumberBox.Set_maskChar(const Value: string);
begin
  FmaskChar := Value;
end;

procedure TjdxNumberBox.Set_maskInvalidMessage(const Value: string);
begin
  FmaskInvalidMessage := Value;
end;

procedure TjdxNumberBox.Set_maskRules(const Value: JSValue);
begin
  FmaskRules := Value;
end;

procedure TjdxNumberBox.Set_max(const Value: integer);
begin
  Fmax := Value;
end;

procedure TjdxNumberBox.Set_min(const Value: integer);
begin
  Fmin := Value;
end;

procedure TjdxNumberBox.Set_mode(const Value: TdxNumberBoxType);
begin
  Fmode := Value;
end;

procedure TjdxNumberBox.Set_name_(const Value: string);
begin
  Fname_ := Value;
end;

procedure TjdxNumberBox.Set_placeholder(const Value: string);
begin
  Fplaceholder := Value;
end;

procedure TjdxNumberBox.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
end;

procedure TjdxNumberBox.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxNumberBox.Set_showClearButton(const Value: boolean);
begin
  FshowClearButton := Value;
end;

procedure TjdxNumberBox.Set_showMaskMode(const Value: TdxMaskMode);
begin
  FshowMaskMode := Value;
end;

procedure TjdxNumberBox.Set_showSpinButtons(const Value: boolean);
begin
  FshowSpinButtons := Value;
end;

procedure TjdxNumberBox.Set_spellcheck(const Value: boolean);
begin
  Fspellcheck := Value;
end;

procedure TjdxNumberBox.Set_step(const Value: integer);
begin
  Fstep := Value;
end;

procedure TjdxNumberBox.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
end;

procedure TjdxNumberBox.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxNumberBox.Set_useLargeSpinButtons(const Value: boolean);
begin
  FuseLargeSpinButtons := Value;
end;

procedure TjdxNumberBox.Set_useMaskedValue(const Value: boolean);
begin
  FuseMaskedValue := Value;
end;

procedure TjdxNumberBox.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
end;

procedure TjdxNumberBox.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
end;

procedure TjdxNumberBox.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
end;

procedure TjdxNumberBox.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
end;

procedure TjdxNumberBox.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
end;

procedure TjdxNumberBox.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
end;

procedure TjdxNumberBox.Set_valueChangeEvent(const Value: string);
begin
  FvalueChangeEvent := Value;
end;

procedure TjdxNumberBox.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxNumberBox.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxNumberBox.Set_onChange(const Value: TdxEventHandler);
begin
  FonChange := Value;
end;

procedure TjdxNumberBox.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxNumberBox.Set_onCopy(const Value: TdxEventHandler);
begin
  FonCopy := Value;
end;

procedure TjdxNumberBox.Set_onCut(const Value: TdxEventHandler);
begin
  FonCut := Value;
end;

procedure TjdxNumberBox.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxNumberBox.Set_onEnterKey(const Value: TdxEventHandler);
begin
  FonEnterKey := Value;
end;

procedure TjdxNumberBox.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxNumberBox.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxNumberBox.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxNumberBox.Set_onInput(const Value: TdxEventHandler);
begin
  FonInput := Value;
end;

procedure TjdxNumberBox.Set_onKeyDown(const Value: TdxEventHandler);
begin
  FonKeyDown := Value;
end;

procedure TjdxNumberBox.Set_onKeyUp(const Value: TdxEventHandler);
begin
  FonKeyUp := Value;
end;

procedure TjdxNumberBox.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxNumberBox.Set_onPaste(const Value: TdxEventHandler);
begin
  FonPaste := Value;
end;

procedure TjdxNumberBox.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
end;

end.
