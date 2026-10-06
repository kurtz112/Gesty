unit DevExtreme.ColorBox;

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
  TjdxColorBox = class(TjdxCustomControl)
  private
    FacceptCustomValue: boolean;
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FapplyButtonText: string;
    FapplyValueMode: TdxApplyValueMode;
    Fbuttons: TJSArray;
    FcancelButtonText: string;
    FdeferRendering: boolean;
    Fdisabled: boolean;
    FdropDownButtonTemplate: JSValue;
    FdropDownOptions: JSValue;
    FeditAlphaChannel: boolean;
    FelementAttr: TJSObject;
    FfieldTemplate: JSValue;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FinputAttr: JSValue;
    FisValid: boolean;
    FkeyStep: integer;
    Flabel_: string;
    FlabelMode: TdxLabelMode;
    Fmask: string;
    FmaskChar: string;
    FmaskInvalidMessage: string;
    FmaskRules: JSValue;
    FmaxLength: JSValue;
    Fmode: TdxTextBoxType;
    Fname_: string;
    Fopened: boolean;
    FopenOnFieldClick: boolean;
    Fplaceholder: string;
    FreadOnly: boolean;
    FrtlEnabled: boolean;
    FshowClearButton: boolean;
    FshowDropDownButton: boolean;
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
    procedure Set_applyButtonText(const value: string);
    procedure Set_applyValueMode(const value: TdxApplyValueMode);
    procedure Set_buttons(const value: TJSArray);
    procedure Set_cancelButtonText(const value: string);
    procedure Set_deferRendering(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_dropDownButtonTemplate(const value: JSValue);
    procedure Set_dropDownOptions(const value: JSValue);
    procedure Set_editAlphaChannel(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_fieldTemplate(const value: JSValue);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_inputAttr(const value: JSValue);
    procedure Set_isValid(const value: boolean);
    procedure Set_keyStep(const value: integer);
    procedure Set_label_(const value: string);
    procedure Set_labelMode(const value: TdxLabelMode);
    procedure Set_mask(const value: string);
    procedure Set_maskChar(const value: string);
    procedure Set_maskInvalidMessage(const value: string);
    procedure Set_maskRules(const value: JSValue);
    procedure Set_maxLength(const value: JSValue);
    procedure Set_mode(const value: TdxTextBoxType);
    procedure Set_name_(const value: string);
    procedure Set_opened(const value: boolean);
    procedure Set_openOnFieldClick(const value: boolean);
    procedure Set_placeholder(const value: string);
    procedure Set_readOnly(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_showClearButton(const value: boolean);
    procedure Set_showDropDownButton(const value: boolean);
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
    property dropDownButtonTemplate: JSValue read FdropDownButtonTemplate write Set_dropDownButtonTemplate;
    property dropDownOptions: JSValue read FdropDownOptions write Set_dropDownOptions;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property fieldTemplate: JSValue read FfieldTemplate write Set_fieldTemplate;
    property height_: JSValue read Fheight_ write Set_height_;
    property inputAttr: JSValue read FinputAttr write Set_inputAttr;
    property maskRules: JSValue read FmaskRules write Set_maskRules;
    property maxLength: JSValue read FmaxLength write Set_maxLength;
    property validationError: JSValue read FvalidationError write Set_validationError;
    property validationErrors: TJSArray read FvalidationErrors write Set_validationErrors;
    property value: JSValue read Fvalue write Set_value;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property acceptCustomValue: boolean read FacceptCustomValue write Set_acceptCustomValue default true;
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property applyButtonText: string read FapplyButtonText write Set_applyButtonText;
    property applyValueMode: TdxApplyValueMode read FapplyValueMode write Set_applyValueMode default avmInstantly;
    property cancelButtonText: string read FcancelButtonText write Set_cancelButtonText;
    property deferRendering: boolean read FdeferRendering write Set_deferRendering default true;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property editAlphaChannel: boolean read FeditAlphaChannel write Set_editAlphaChannel default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property isValid: boolean read FisValid write Set_isValid default true;
    property keyStep: integer read FkeyStep write Set_keyStep;
    property label_: string read Flabel_ write Set_label_;
    property labelMode: TdxLabelMode read FlabelMode write Set_labelMode default lmFloating;
    property mask: string read Fmask write Set_mask;
    property maskChar: string read FmaskChar write Set_maskChar;
    property maskInvalidMessage: string read FmaskInvalidMessage write Set_maskInvalidMessage;
    property mode: TdxTextBoxType read Fmode write Set_mode default tbtText;
    property name_: string read Fname_ write Set_name_;
    property opened: boolean read Fopened write Set_opened default false;
    property openOnFieldClick: boolean read FopenOnFieldClick write Set_openOnFieldClick default false;
    property placeholder: string read Fplaceholder write Set_placeholder;
    property readOnly: boolean read FreadOnly write Set_readOnly default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showClearButton: boolean read FshowClearButton write Set_showClearButton default false;
    property showDropDownButton: boolean read FshowDropDownButton write Set_showDropDownButton default true;
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


constructor TjdxColorBox.Create(aOwner: TComponent);
begin
  inherited;
  FacceptCustomValue := true;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FapplyButtonText := '';
  FapplyValueMode := avmInstantly;
  Fbuttons := TJSArray.new;
  FcancelButtonText := '';
  FdeferRendering := true;
  Fdisabled := false;
  FdropDownButtonTemplate := nil;
  FdropDownOptions := nil;
  FeditAlphaChannel := false;
  FelementAttr := TJSObject.new;
  FfieldTemplate := nil;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FinputAttr := nil;
  FisValid := true;
  FkeyStep := 0;
  Flabel_ := '';
  FlabelMode := lmFloating;
  Fmask := '';
  FmaskChar := '';
  FmaskInvalidMessage := '';
  FmaskRules := nil;
  FmaxLength := nil;
  Fmode := tbtText;
  Fname_ := '';
  Fopened := false;
  FopenOnFieldClick := false;
  Fplaceholder := '';
  FreadOnly := false;
  FrtlEnabled := false;
  FshowClearButton := false;
  FshowDropDownButton := true;
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

procedure TjdxColorBox.Set_acceptCustomValue(const Value: boolean);
begin
  FacceptCustomValue := Value;
end;

procedure TjdxColorBox.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxColorBox.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxColorBox.Set_applyButtonText(const Value: string);
begin
  FapplyButtonText := Value;
end;

procedure TjdxColorBox.Set_applyValueMode(const Value: TdxApplyValueMode);
begin
  FapplyValueMode := Value;
end;

procedure TjdxColorBox.Set_buttons(const Value: TJSArray);
begin
  Fbuttons := Value;
end;

procedure TjdxColorBox.Set_cancelButtonText(const Value: string);
begin
  FcancelButtonText := Value;
end;

procedure TjdxColorBox.Set_deferRendering(const Value: boolean);
begin
  FdeferRendering := Value;
end;

procedure TjdxColorBox.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxColorBox.Set_dropDownButtonTemplate(const Value: JSValue);
begin
  FdropDownButtonTemplate := Value;
end;

procedure TjdxColorBox.Set_dropDownOptions(const Value: JSValue);
begin
  FdropDownOptions := Value;
end;

procedure TjdxColorBox.Set_editAlphaChannel(const Value: boolean);
begin
  FeditAlphaChannel := Value;
end;

procedure TjdxColorBox.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxColorBox.Set_fieldTemplate(const Value: JSValue);
begin
  FfieldTemplate := Value;
end;

procedure TjdxColorBox.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxColorBox.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxColorBox.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxColorBox.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxColorBox.Set_inputAttr(const Value: JSValue);
begin
  FinputAttr := Value;
end;

procedure TjdxColorBox.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
end;

procedure TjdxColorBox.Set_keyStep(const Value: integer);
begin
  FkeyStep := Value;
end;

procedure TjdxColorBox.Set_label_(const Value: string);
begin
  Flabel_ := Value;
end;

procedure TjdxColorBox.Set_labelMode(const Value: TdxLabelMode);
begin
  FlabelMode := Value;
end;

procedure TjdxColorBox.Set_mask(const Value: string);
begin
  Fmask := Value;
end;

procedure TjdxColorBox.Set_maskChar(const Value: string);
begin
  FmaskChar := Value;
end;

procedure TjdxColorBox.Set_maskInvalidMessage(const Value: string);
begin
  FmaskInvalidMessage := Value;
end;

procedure TjdxColorBox.Set_maskRules(const Value: JSValue);
begin
  FmaskRules := Value;
end;

procedure TjdxColorBox.Set_maxLength(const Value: JSValue);
begin
  FmaxLength := Value;
end;

procedure TjdxColorBox.Set_mode(const Value: TdxTextBoxType);
begin
  Fmode := Value;
end;

procedure TjdxColorBox.Set_name_(const Value: string);
begin
  Fname_ := Value;
end;

procedure TjdxColorBox.Set_opened(const Value: boolean);
begin
  Fopened := Value;
end;

procedure TjdxColorBox.Set_openOnFieldClick(const Value: boolean);
begin
  FopenOnFieldClick := Value;
end;

procedure TjdxColorBox.Set_placeholder(const Value: string);
begin
  Fplaceholder := Value;
end;

procedure TjdxColorBox.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
end;

procedure TjdxColorBox.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxColorBox.Set_showClearButton(const Value: boolean);
begin
  FshowClearButton := Value;
end;

procedure TjdxColorBox.Set_showDropDownButton(const Value: boolean);
begin
  FshowDropDownButton := Value;
end;

procedure TjdxColorBox.Set_showMaskMode(const Value: TdxMaskMode);
begin
  FshowMaskMode := Value;
end;

procedure TjdxColorBox.Set_spellcheck(const Value: boolean);
begin
  Fspellcheck := Value;
end;

procedure TjdxColorBox.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
end;

procedure TjdxColorBox.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxColorBox.Set_useMaskedValue(const Value: boolean);
begin
  FuseMaskedValue := Value;
end;

procedure TjdxColorBox.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
end;

procedure TjdxColorBox.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
end;

procedure TjdxColorBox.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
end;

procedure TjdxColorBox.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
end;

procedure TjdxColorBox.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
end;

procedure TjdxColorBox.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
end;

procedure TjdxColorBox.Set_valueChangeEvent(const Value: string);
begin
  FvalueChangeEvent := Value;
end;

procedure TjdxColorBox.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxColorBox.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxColorBox.Set_onChange(const Value: TdxEventHandler);
begin
  FonChange := Value;
end;

procedure TjdxColorBox.Set_onClosed(const Value: TdxEventHandler);
begin
  FonClosed := Value;
end;

procedure TjdxColorBox.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxColorBox.Set_onCopy(const Value: TdxEventHandler);
begin
  FonCopy := Value;
end;

procedure TjdxColorBox.Set_onCut(const Value: TdxEventHandler);
begin
  FonCut := Value;
end;

procedure TjdxColorBox.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxColorBox.Set_onEnterKey(const Value: TdxEventHandler);
begin
  FonEnterKey := Value;
end;

procedure TjdxColorBox.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxColorBox.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxColorBox.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxColorBox.Set_onInput(const Value: TdxEventHandler);
begin
  FonInput := Value;
end;

procedure TjdxColorBox.Set_onKeyDown(const Value: TdxEventHandler);
begin
  FonKeyDown := Value;
end;

procedure TjdxColorBox.Set_onKeyUp(const Value: TdxEventHandler);
begin
  FonKeyUp := Value;
end;

procedure TjdxColorBox.Set_onOpened(const Value: TdxEventHandler);
begin
  FonOpened := Value;
end;

procedure TjdxColorBox.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxColorBox.Set_onPaste(const Value: TdxEventHandler);
begin
  FonPaste := Value;
end;

procedure TjdxColorBox.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
end;

end.
