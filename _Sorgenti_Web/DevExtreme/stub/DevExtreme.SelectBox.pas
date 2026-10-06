unit DevExtreme.SelectBox;

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
  TjdxSelectBox = class(TjdxCustomControl)
  private
    FacceptCustomValue: boolean;
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FallowClearing: boolean;
    FapplyValueMode: TdxApplyValueMode;
    Fbuttons: TJSArray;
    FcustomItemCreateEvent: string;
    FdataSource: JSValue;
    FdeferRendering: boolean;
    Fdisabled: boolean;
    FdisplayExpr: JSValue;
    FdisplayValue: string;
    FdropDownButtonTemplate: JSValue;
    FdropDownOptions: JSValue;
    FelementAttr: TJSObject;
    FfieldTemplate: JSValue;
    FfocusStateEnabled: boolean;
    Fgrouped: boolean;
    FgroupTemplate: JSValue;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FinputAttr: JSValue;
    FisValid: boolean;
    Fitems: TJSArray;
    FitemTemplate: JSValue;
    Flabel_: string;
    FlabelMode: TdxLabelMode;
    Fmask: string;
    FmaskChar: string;
    FmaskInvalidMessage: string;
    FmaskRules: JSValue;
    FmaxLength: JSValue;
    FminSearchLength: integer;
    Fmode: TdxTextBoxType;
    Fname_: string;
    FnoDataText: string;
    Fopened: boolean;
    FopenOnFieldClick: boolean;
    Fplaceholder: string;
    FreadOnly: boolean;
    FrtlEnabled: boolean;
    FsearchEnabled: boolean;
    FsearchExpr: JSValue;
    FsearchMode: TdxSimplifiedSearchMode;
    FsearchTimeout: integer;
    FselectedItem: JSValue;
    FshowClearButton: boolean;
    FshowDataBeforeSearch: boolean;
    FshowDropDownButton: boolean;
    FshowMaskMode: TdxMaskMode;
    FshowSelectionControls: boolean;
    Fspellcheck: boolean;
    FstylingMode: TdxEditorStyle;
    FtabIndex: integer;
    Ftext: string;
    FuseItemTextAsTitle: boolean;
    FuseMaskedValue: boolean;
    FvalidationError: JSValue;
    FvalidationErrors: TJSArray;
    FvalidationMessageMode: TdxValidationMessageMode;
    FvalidationMessagePosition: TdxPosition;
    FvalidationStatus: TdxValidationStatus;
    Fvalue: JSValue;
    FvalueChangeEvent: string;
    FvalueExpr: JSValue;
    Fvisible: boolean;
    Fwidth_: JSValue;
    FwrapItemText: boolean;
  private
    FonChange: TdxEventHandler;
    FonClosed: TdxEventHandler;
    FonContentReady: TdxEventHandler;
    FonCopy: TdxEventHandler;
    FonCustomItemCreating: TdxEventHandler;
    FonCut: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonEnterKey: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonInput: TdxEventHandler;
    FonItemClick: TdxEventHandler;
    FonKeyDown: TdxEventHandler;
    FonKeyUp: TdxEventHandler;
    FonOpened: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonPaste: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
    FonValueChanged: TdxEventHandler;
  private
    procedure Set_acceptCustomValue(const value: boolean);
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_allowClearing(const value: boolean);
    procedure Set_applyValueMode(const value: TdxApplyValueMode);
    procedure Set_buttons(const value: TJSArray);
    procedure Set_customItemCreateEvent(const value: string);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_deferRendering(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_displayExpr(const value: JSValue);
    procedure Set_dropDownButtonTemplate(const value: JSValue);
    procedure Set_dropDownOptions(const value: JSValue);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_fieldTemplate(const value: JSValue);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_grouped(const value: boolean);
    procedure Set_groupTemplate(const value: JSValue);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_inputAttr(const value: JSValue);
    procedure Set_isValid(const value: boolean);
    procedure Set_items(const value: TJSArray);
    procedure Set_itemTemplate(const value: JSValue);
    procedure Set_label_(const value: string);
    procedure Set_labelMode(const value: TdxLabelMode);
    procedure Set_mask(const value: string);
    procedure Set_maskChar(const value: string);
    procedure Set_maskInvalidMessage(const value: string);
    procedure Set_maskRules(const value: JSValue);
    procedure Set_maxLength(const value: JSValue);
    procedure Set_minSearchLength(const value: integer);
    procedure Set_mode(const value: TdxTextBoxType);
    procedure Set_name_(const value: string);
    procedure Set_noDataText(const value: string);
    procedure Set_opened(const value: boolean);
    procedure Set_openOnFieldClick(const value: boolean);
    procedure Set_placeholder(const value: string);
    procedure Set_readOnly(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_searchEnabled(const value: boolean);
    procedure Set_searchExpr(const value: JSValue);
    procedure Set_searchMode(const value: TdxSimplifiedSearchMode);
    procedure Set_searchTimeout(const value: integer);
    procedure Set_showClearButton(const value: boolean);
    procedure Set_showDataBeforeSearch(const value: boolean);
    procedure Set_showDropDownButton(const value: boolean);
    procedure Set_showMaskMode(const value: TdxMaskMode);
    procedure Set_showSelectionControls(const value: boolean);
    procedure Set_spellcheck(const value: boolean);
    procedure Set_stylingMode(const value: TdxEditorStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_useItemTextAsTitle(const value: boolean);
    procedure Set_useMaskedValue(const value: boolean);
    procedure Set_validationError(const value: JSValue);
    procedure Set_validationErrors(const value: TJSArray);
    procedure Set_validationMessageMode(const value: TdxValidationMessageMode);
    procedure Set_validationMessagePosition(const value: TdxPosition);
    procedure Set_validationStatus(const value: TdxValidationStatus);
    procedure Set_value(const value: JSValue);
    procedure Set_valueChangeEvent(const value: string);
    procedure Set_valueExpr(const value: JSValue);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
    procedure Set_wrapItemText(const value: boolean);
  private
    procedure Set_onChange(const value: TdxEventHandler);
    procedure Set_onClosed(const value: TdxEventHandler);
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onCopy(const value: TdxEventHandler);
    procedure Set_onCustomItemCreating(const value: TdxEventHandler);
    procedure Set_onCut(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onEnterKey(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onInput(const value: TdxEventHandler);
    procedure Set_onItemClick(const value: TdxEventHandler);
    procedure Set_onKeyDown(const value: TdxEventHandler);
    procedure Set_onKeyUp(const value: TdxEventHandler);
    procedure Set_onOpened(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onPaste(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
    procedure Set_onValueChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property buttons: TJSArray read Fbuttons write Set_buttons;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property displayExpr: JSValue read FdisplayExpr write Set_displayExpr;
    property dropDownButtonTemplate: JSValue read FdropDownButtonTemplate write Set_dropDownButtonTemplate;
    property dropDownOptions: JSValue read FdropDownOptions write Set_dropDownOptions;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property fieldTemplate: JSValue read FfieldTemplate write Set_fieldTemplate;
    property groupTemplate: JSValue read FgroupTemplate write Set_groupTemplate;
    property height_: JSValue read Fheight_ write Set_height_;
    property inputAttr: JSValue read FinputAttr write Set_inputAttr;
    property items: TJSArray read Fitems write Set_items;
    property itemTemplate: JSValue read FitemTemplate write Set_itemTemplate;
    property maskRules: JSValue read FmaskRules write Set_maskRules;
    property maxLength: JSValue read FmaxLength write Set_maxLength;
    property searchExpr: JSValue read FsearchExpr write Set_searchExpr;
    property selectedItem: JSValue read FselectedItem;
    property validationError: JSValue read FvalidationError write Set_validationError;
    property validationErrors: TJSArray read FvalidationErrors write Set_validationErrors;
    property value: JSValue read Fvalue write Set_value;
    property valueExpr: JSValue read FvalueExpr write Set_valueExpr;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property acceptCustomValue: boolean read FacceptCustomValue write Set_acceptCustomValue default true;
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property allowClearing: boolean read FallowClearing write Set_allowClearing default true;
    property applyValueMode: TdxApplyValueMode read FapplyValueMode write Set_applyValueMode default avmInstantly;
    property customItemCreateEvent: string read FcustomItemCreateEvent write Set_customItemCreateEvent;
    property deferRendering: boolean read FdeferRendering write Set_deferRendering default true;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property displayValue: string read FdisplayValue;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property grouped: boolean read Fgrouped write Set_grouped default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property isValid: boolean read FisValid write Set_isValid default true;
    property label_: string read Flabel_ write Set_label_;
    property labelMode: TdxLabelMode read FlabelMode write Set_labelMode default lmFloating;
    property mask: string read Fmask write Set_mask;
    property maskChar: string read FmaskChar write Set_maskChar;
    property maskInvalidMessage: string read FmaskInvalidMessage write Set_maskInvalidMessage;
    property minSearchLength: integer read FminSearchLength write Set_minSearchLength;
    property mode: TdxTextBoxType read Fmode write Set_mode default tbtText;
    property name_: string read Fname_ write Set_name_;
    property noDataText: string read FnoDataText write Set_noDataText;
    property opened: boolean read Fopened write Set_opened default false;
    property openOnFieldClick: boolean read FopenOnFieldClick write Set_openOnFieldClick default false;
    property placeholder: string read Fplaceholder write Set_placeholder;
    property readOnly: boolean read FreadOnly write Set_readOnly default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property searchEnabled: boolean read FsearchEnabled write Set_searchEnabled default false;
    property searchMode: TdxSimplifiedSearchMode read FsearchMode write Set_searchMode default ssmContains;
    property searchTimeout: integer read FsearchTimeout write Set_searchTimeout;
    property showClearButton: boolean read FshowClearButton write Set_showClearButton default false;
    property showDataBeforeSearch: boolean read FshowDataBeforeSearch write Set_showDataBeforeSearch default false;
    property showDropDownButton: boolean read FshowDropDownButton write Set_showDropDownButton default true;
    property showMaskMode: TdxMaskMode read FshowMaskMode write Set_showMaskMode default mmAlways;
    property showSelectionControls: boolean read FshowSelectionControls write Set_showSelectionControls default false;
    property spellcheck: boolean read Fspellcheck write Set_spellcheck default false;
    property stylingMode: TdxEditorStyle read FstylingMode write Set_stylingMode default esOutlined;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property text: string read Ftext;
    property useItemTextAsTitle: boolean read FuseItemTextAsTitle write Set_useItemTextAsTitle default false;
    property useMaskedValue: boolean read FuseMaskedValue write Set_useMaskedValue default false;
    property validationMessageMode: TdxValidationMessageMode read FvalidationMessageMode write Set_validationMessageMode default vmmAuto;
    property validationMessagePosition: TdxPosition read FvalidationMessagePosition write Set_validationMessagePosition default pBottom;
    property validationStatus: TdxValidationStatus read FvalidationStatus write Set_validationStatus default vsValid;
    property valueChangeEvent: string read FvalueChangeEvent write Set_valueChangeEvent;
    property visible: boolean read Fvisible write Set_visible default true;
    property wrapItemText: boolean read FwrapItemText write Set_wrapItemText default false;
  published
    property onChange: TdxEventHandler read FonChange write Set_onChange;
    property onClosed: TdxEventHandler read FonClosed write Set_onClosed;
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onCopy: TdxEventHandler read FonCopy write Set_onCopy;
    property onCustomItemCreating: TdxEventHandler read FonCustomItemCreating write Set_onCustomItemCreating;
    property onCut: TdxEventHandler read FonCut write Set_onCut;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onEnterKey: TdxEventHandler read FonEnterKey write Set_onEnterKey;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onInput: TdxEventHandler read FonInput write Set_onInput;
    property onItemClick: TdxEventHandler read FonItemClick write Set_onItemClick;
    property onKeyDown: TdxEventHandler read FonKeyDown write Set_onKeyDown;
    property onKeyUp: TdxEventHandler read FonKeyUp write Set_onKeyUp;
    property onOpened: TdxEventHandler read FonOpened write Set_onOpened;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onPaste: TdxEventHandler read FonPaste write Set_onPaste;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
    property onValueChanged: TdxEventHandler read FonValueChanged write Set_onValueChanged;
  end;

implementation


constructor TjdxSelectBox.Create(aOwner: TComponent);
begin
  inherited;
  FacceptCustomValue := true;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FallowClearing := true;
  FapplyValueMode := avmInstantly;
  Fbuttons := TJSArray.new;
  FcustomItemCreateEvent := '';
  FdataSource := nil;
  FdeferRendering := true;
  Fdisabled := false;
  FdisplayExpr := nil;
  FdisplayValue := '';
  FdropDownButtonTemplate := nil;
  FdropDownOptions := nil;
  FelementAttr := TJSObject.new;
  FfieldTemplate := nil;
  FfocusStateEnabled := false;
  Fgrouped := false;
  FgroupTemplate := nil;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FinputAttr := nil;
  FisValid := true;
  Fitems := TJSArray.new;
  FitemTemplate := nil;
  Flabel_ := '';
  FlabelMode := lmFloating;
  Fmask := '';
  FmaskChar := '';
  FmaskInvalidMessage := '';
  FmaskRules := nil;
  FmaxLength := nil;
  FminSearchLength := 0;
  Fmode := tbtText;
  Fname_ := '';
  FnoDataText := '';
  Fopened := false;
  FopenOnFieldClick := false;
  Fplaceholder := '';
  FreadOnly := false;
  FrtlEnabled := false;
  FsearchEnabled := false;
  FsearchExpr := nil;
  FsearchMode := ssmContains;
  FsearchTimeout := 0;
  FselectedItem := nil;
  FshowClearButton := false;
  FshowDataBeforeSearch := false;
  FshowDropDownButton := true;
  FshowMaskMode := mmAlways;
  FshowSelectionControls := false;
  Fspellcheck := false;
  FstylingMode := esOutlined;
  FtabIndex := 0;
  Ftext := '';
  FuseItemTextAsTitle := false;
  FuseMaskedValue := false;
  FvalidationError := nil;
  FvalidationErrors := TJSArray.new;
  FvalidationMessageMode := vmmAuto;
  FvalidationMessagePosition := pBottom;
  FvalidationStatus := vsValid;
  Fvalue := nil;
  FvalueChangeEvent := '';
  FvalueExpr := nil;
  Fvisible := true;
  Fwidth_ := nil;
  FwrapItemText := false;

  FonChange := nil;
  FonClosed := nil;
  FonContentReady := nil;
  FonCopy := nil;
  FonCustomItemCreating := nil;
  FonCut := nil;
  FonDisposing := nil;
  FonEnterKey := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonInput := nil;
  FonItemClick := nil;
  FonKeyDown := nil;
  FonKeyUp := nil;
  FonOpened := nil;
  FonOptionChanged := nil;
  FonPaste := nil;
  FonSelectionChanged := nil;
  FonValueChanged := nil;
end;

procedure TjdxSelectBox.Set_acceptCustomValue(const Value: boolean);
begin
  FacceptCustomValue := Value;
end;

procedure TjdxSelectBox.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxSelectBox.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxSelectBox.Set_allowClearing(const Value: boolean);
begin
  FallowClearing := Value;
end;

procedure TjdxSelectBox.Set_applyValueMode(const Value: TdxApplyValueMode);
begin
  FapplyValueMode := Value;
end;

procedure TjdxSelectBox.Set_buttons(const Value: TJSArray);
begin
  Fbuttons := Value;
end;

procedure TjdxSelectBox.Set_customItemCreateEvent(const Value: string);
begin
  FcustomItemCreateEvent := Value;
end;

procedure TjdxSelectBox.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxSelectBox.Set_deferRendering(const Value: boolean);
begin
  FdeferRendering := Value;
end;

procedure TjdxSelectBox.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxSelectBox.Set_displayExpr(const Value: JSValue);
begin
  FdisplayExpr := Value;
end;

procedure TjdxSelectBox.Set_dropDownButtonTemplate(const Value: JSValue);
begin
  FdropDownButtonTemplate := Value;
end;

procedure TjdxSelectBox.Set_dropDownOptions(const Value: JSValue);
begin
  FdropDownOptions := Value;
end;

procedure TjdxSelectBox.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxSelectBox.Set_fieldTemplate(const Value: JSValue);
begin
  FfieldTemplate := Value;
end;

procedure TjdxSelectBox.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxSelectBox.Set_grouped(const Value: boolean);
begin
  Fgrouped := Value;
end;

procedure TjdxSelectBox.Set_groupTemplate(const Value: JSValue);
begin
  FgroupTemplate := Value;
end;

procedure TjdxSelectBox.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxSelectBox.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxSelectBox.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxSelectBox.Set_inputAttr(const Value: JSValue);
begin
  FinputAttr := Value;
end;

procedure TjdxSelectBox.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
end;

procedure TjdxSelectBox.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
end;

procedure TjdxSelectBox.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
end;

procedure TjdxSelectBox.Set_label_(const Value: string);
begin
  Flabel_ := Value;
end;

procedure TjdxSelectBox.Set_labelMode(const Value: TdxLabelMode);
begin
  FlabelMode := Value;
end;

procedure TjdxSelectBox.Set_mask(const Value: string);
begin
  Fmask := Value;
end;

procedure TjdxSelectBox.Set_maskChar(const Value: string);
begin
  FmaskChar := Value;
end;

procedure TjdxSelectBox.Set_maskInvalidMessage(const Value: string);
begin
  FmaskInvalidMessage := Value;
end;

procedure TjdxSelectBox.Set_maskRules(const Value: JSValue);
begin
  FmaskRules := Value;
end;

procedure TjdxSelectBox.Set_maxLength(const Value: JSValue);
begin
  FmaxLength := Value;
end;

procedure TjdxSelectBox.Set_minSearchLength(const Value: integer);
begin
  FminSearchLength := Value;
end;

procedure TjdxSelectBox.Set_mode(const Value: TdxTextBoxType);
begin
  Fmode := Value;
end;

procedure TjdxSelectBox.Set_name_(const Value: string);
begin
  Fname_ := Value;
end;

procedure TjdxSelectBox.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
end;

procedure TjdxSelectBox.Set_opened(const Value: boolean);
begin
  Fopened := Value;
end;

procedure TjdxSelectBox.Set_openOnFieldClick(const Value: boolean);
begin
  FopenOnFieldClick := Value;
end;

procedure TjdxSelectBox.Set_placeholder(const Value: string);
begin
  Fplaceholder := Value;
end;

procedure TjdxSelectBox.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
end;

procedure TjdxSelectBox.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxSelectBox.Set_searchEnabled(const Value: boolean);
begin
  FsearchEnabled := Value;
end;

procedure TjdxSelectBox.Set_searchExpr(const Value: JSValue);
begin
  FsearchExpr := Value;
end;

procedure TjdxSelectBox.Set_searchMode(const Value: TdxSimplifiedSearchMode);
begin
  FsearchMode := Value;
end;

procedure TjdxSelectBox.Set_searchTimeout(const Value: integer);
begin
  FsearchTimeout := Value;
end;

procedure TjdxSelectBox.Set_showClearButton(const Value: boolean);
begin
  FshowClearButton := Value;
end;

procedure TjdxSelectBox.Set_showDataBeforeSearch(const Value: boolean);
begin
  FshowDataBeforeSearch := Value;
end;

procedure TjdxSelectBox.Set_showDropDownButton(const Value: boolean);
begin
  FshowDropDownButton := Value;
end;

procedure TjdxSelectBox.Set_showMaskMode(const Value: TdxMaskMode);
begin
  FshowMaskMode := Value;
end;

procedure TjdxSelectBox.Set_showSelectionControls(const Value: boolean);
begin
  FshowSelectionControls := Value;
end;

procedure TjdxSelectBox.Set_spellcheck(const Value: boolean);
begin
  Fspellcheck := Value;
end;

procedure TjdxSelectBox.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
end;

procedure TjdxSelectBox.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxSelectBox.Set_useItemTextAsTitle(const Value: boolean);
begin
  FuseItemTextAsTitle := Value;
end;

procedure TjdxSelectBox.Set_useMaskedValue(const Value: boolean);
begin
  FuseMaskedValue := Value;
end;

procedure TjdxSelectBox.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
end;

procedure TjdxSelectBox.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
end;

procedure TjdxSelectBox.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
end;

procedure TjdxSelectBox.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
end;

procedure TjdxSelectBox.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
end;

procedure TjdxSelectBox.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
end;

procedure TjdxSelectBox.Set_valueChangeEvent(const Value: string);
begin
  FvalueChangeEvent := Value;
end;

procedure TjdxSelectBox.Set_valueExpr(const Value: JSValue);
begin
  FvalueExpr := Value;
end;

procedure TjdxSelectBox.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxSelectBox.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxSelectBox.Set_wrapItemText(const Value: boolean);
begin
  FwrapItemText := Value;
end;

procedure TjdxSelectBox.Set_onChange(const Value: TdxEventHandler);
begin
  FonChange := Value;
end;

procedure TjdxSelectBox.Set_onClosed(const Value: TdxEventHandler);
begin
  FonClosed := Value;
end;

procedure TjdxSelectBox.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxSelectBox.Set_onCopy(const Value: TdxEventHandler);
begin
  FonCopy := Value;
end;

procedure TjdxSelectBox.Set_onCustomItemCreating(const Value: TdxEventHandler);
begin
  FonCustomItemCreating := Value;
end;

procedure TjdxSelectBox.Set_onCut(const Value: TdxEventHandler);
begin
  FonCut := Value;
end;

procedure TjdxSelectBox.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxSelectBox.Set_onEnterKey(const Value: TdxEventHandler);
begin
  FonEnterKey := Value;
end;

procedure TjdxSelectBox.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxSelectBox.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxSelectBox.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxSelectBox.Set_onInput(const Value: TdxEventHandler);
begin
  FonInput := Value;
end;

procedure TjdxSelectBox.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
end;

procedure TjdxSelectBox.Set_onKeyDown(const Value: TdxEventHandler);
begin
  FonKeyDown := Value;
end;

procedure TjdxSelectBox.Set_onKeyUp(const Value: TdxEventHandler);
begin
  FonKeyUp := Value;
end;

procedure TjdxSelectBox.Set_onOpened(const Value: TdxEventHandler);
begin
  FonOpened := Value;
end;

procedure TjdxSelectBox.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxSelectBox.Set_onPaste(const Value: TdxEventHandler);
begin
  FonPaste := Value;
end;

procedure TjdxSelectBox.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
end;

procedure TjdxSelectBox.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
end;

end.
