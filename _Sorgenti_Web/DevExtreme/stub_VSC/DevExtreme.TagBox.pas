unit DevExtreme.TagBox;

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
  TjdxTagBox = class(TjdxCustomControl)
  private
    FacceptCustomValue: boolean;
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FallowClearing: boolean;
    FapplyValueMode: TdxApplyValueMode;
    Fbuttons: TJSArray;
    FcloseAction: JSValue;
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
    FhiddenAction: JSValue;
    FhideSelectedItems: boolean;
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
    FmaxDisplayedTags: integer;
    FmaxFilterQueryLength: integer;
    FmaxLength: JSValue;
    FminSearchLength: integer;
    Fmode: TdxTextBoxType;
    Fmultiline: boolean;
    Fname_: string;
    FnoDataText: string;
    FopenAction: JSValue;
    Fopened: boolean;
    FopenOnFieldClick: boolean;
    Fplaceholder: string;
    FreadOnly: boolean;
    FrtlEnabled: boolean;
    FsearchEnabled: boolean;
    FsearchExpr: JSValue;
    FsearchMode: TdxSimplifiedSearchMode;
    FsearchTimeout: integer;
    FselectAllMode: TdxSelectAllMode;
    FselectAllText: string;
    FselectedItem: JSValue;
    FselectedItems: TJSArray;
    FshowClearButton: boolean;
    FshowDataBeforeSearch: boolean;
    FshowDropDownButton: boolean;
    FshowMaskMode: TdxMaskMode;
    FshowMultiTagOnly: boolean;
    FshownAction: JSValue;
    FshowSelectionControls: boolean;
    Fspellcheck: boolean;
    FstylingMode: TdxEditorStyle;
    FtabIndex: integer;
    FtagTemplate: JSValue;
    Ftext: string;
    FuseItemTextAsTitle: boolean;
    FuseMaskedValue: boolean;
    FuseSubmitBehavior: boolean;
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
    FonMultiTagPreparing: TdxEventHandler;
    FonOpened: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonPaste: TdxEventHandler;
    FonSelectAllValueChanged: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
    FonValueChanged: TdxEventHandler;
  private
    procedure Set_acceptCustomValue(const value: boolean);
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_allowClearing(const value: boolean);
    procedure Set_applyValueMode(const value: TdxApplyValueMode);
    procedure Set_buttons(const value: TJSArray);
    procedure Set_closeAction(const value: JSValue);
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
    procedure Set_hiddenAction(const value: JSValue);
    procedure Set_hideSelectedItems(const value: boolean);
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
    procedure Set_maxDisplayedTags(const value: integer);
    procedure Set_maxFilterQueryLength(const value: integer);
    procedure Set_maxLength(const value: JSValue);
    procedure Set_minSearchLength(const value: integer);
    procedure Set_mode(const value: TdxTextBoxType);
    procedure Set_multiline(const value: boolean);
    procedure Set_name_(const value: string);
    procedure Set_noDataText(const value: string);
    procedure Set_openAction(const value: JSValue);
    procedure Set_opened(const value: boolean);
    procedure Set_openOnFieldClick(const value: boolean);
    procedure Set_placeholder(const value: string);
    procedure Set_readOnly(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_searchEnabled(const value: boolean);
    procedure Set_searchExpr(const value: JSValue);
    procedure Set_searchMode(const value: TdxSimplifiedSearchMode);
    procedure Set_searchTimeout(const value: integer);
    procedure Set_selectAllMode(const value: TdxSelectAllMode);
    procedure Set_selectAllText(const value: string);
    procedure Set_showClearButton(const value: boolean);
    procedure Set_showDataBeforeSearch(const value: boolean);
    procedure Set_showDropDownButton(const value: boolean);
    procedure Set_showMaskMode(const value: TdxMaskMode);
    procedure Set_showMultiTagOnly(const value: boolean);
    procedure Set_shownAction(const value: JSValue);
    procedure Set_showSelectionControls(const value: boolean);
    procedure Set_spellcheck(const value: boolean);
    procedure Set_stylingMode(const value: TdxEditorStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_tagTemplate(const value: JSValue);
    procedure Set_useItemTextAsTitle(const value: boolean);
    procedure Set_useMaskedValue(const value: boolean);
    procedure Set_useSubmitBehavior(const value: boolean);
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
    procedure Set_onMultiTagPreparing(const value: TdxEventHandler);
    procedure Set_onOpened(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onPaste(const value: TdxEventHandler);
    procedure Set_onSelectAllValueChanged(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
    procedure Set_onValueChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property buttons: TJSArray read Fbuttons write Set_buttons;
    property closeAction: JSValue read FcloseAction write Set_closeAction;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property displayExpr: JSValue read FdisplayExpr write Set_displayExpr;
    property dropDownButtonTemplate: JSValue read FdropDownButtonTemplate write Set_dropDownButtonTemplate;
    property dropDownOptions: JSValue read FdropDownOptions write Set_dropDownOptions;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property fieldTemplate: JSValue read FfieldTemplate write Set_fieldTemplate;
    property groupTemplate: JSValue read FgroupTemplate write Set_groupTemplate;
    property height_: JSValue read Fheight_ write Set_height_;
    property hiddenAction: JSValue read FhiddenAction write Set_hiddenAction;
    property inputAttr: JSValue read FinputAttr write Set_inputAttr;
    property items: TJSArray read Fitems write Set_items;
    property itemTemplate: JSValue read FitemTemplate write Set_itemTemplate;
    property maskRules: JSValue read FmaskRules write Set_maskRules;
    property maxLength: JSValue read FmaxLength write Set_maxLength;
    property openAction: JSValue read FopenAction write Set_openAction;
    property searchExpr: JSValue read FsearchExpr write Set_searchExpr;
    property selectedItem: JSValue read FselectedItem;
    property selectedItems: TJSArray read FselectedItems;
    property shownAction: JSValue read FshownAction write Set_shownAction;
    property tagTemplate: JSValue read FtagTemplate write Set_tagTemplate;
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
    property hideSelectedItems: boolean read FhideSelectedItems write Set_hideSelectedItems default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property isValid: boolean read FisValid write Set_isValid default true;
    property label_: string read Flabel_ write Set_label_;
    property labelMode: TdxLabelMode read FlabelMode write Set_labelMode default lmFloating;
    property mask: string read Fmask write Set_mask;
    property maskChar: string read FmaskChar write Set_maskChar;
    property maskInvalidMessage: string read FmaskInvalidMessage write Set_maskInvalidMessage;
    property maxDisplayedTags: integer read FmaxDisplayedTags write Set_maxDisplayedTags;
    property maxFilterQueryLength: integer read FmaxFilterQueryLength write Set_maxFilterQueryLength;
    property minSearchLength: integer read FminSearchLength write Set_minSearchLength;
    property mode: TdxTextBoxType read Fmode write Set_mode default tbtText;
    property multiline: boolean read Fmultiline write Set_multiline default true;
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
    property selectAllMode: TdxSelectAllMode read FselectAllMode write Set_selectAllMode default samPage;
    property selectAllText: string read FselectAllText write Set_selectAllText;
    property showClearButton: boolean read FshowClearButton write Set_showClearButton default false;
    property showDataBeforeSearch: boolean read FshowDataBeforeSearch write Set_showDataBeforeSearch default false;
    property showDropDownButton: boolean read FshowDropDownButton write Set_showDropDownButton default true;
    property showMaskMode: TdxMaskMode read FshowMaskMode write Set_showMaskMode default mmAlways;
    property showMultiTagOnly: boolean read FshowMultiTagOnly write Set_showMultiTagOnly default true;
    property showSelectionControls: boolean read FshowSelectionControls write Set_showSelectionControls default false;
    property spellcheck: boolean read Fspellcheck write Set_spellcheck default false;
    property stylingMode: TdxEditorStyle read FstylingMode write Set_stylingMode default esOutlined;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property text: string read Ftext;
    property useItemTextAsTitle: boolean read FuseItemTextAsTitle write Set_useItemTextAsTitle default false;
    property useMaskedValue: boolean read FuseMaskedValue write Set_useMaskedValue default false;
    property useSubmitBehavior: boolean read FuseSubmitBehavior write Set_useSubmitBehavior default true;
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
    property onMultiTagPreparing: TdxEventHandler read FonMultiTagPreparing write Set_onMultiTagPreparing;
    property onOpened: TdxEventHandler read FonOpened write Set_onOpened;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onPaste: TdxEventHandler read FonPaste write Set_onPaste;
    property onSelectAllValueChanged: TdxEventHandler read FonSelectAllValueChanged write Set_onSelectAllValueChanged;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
    property onValueChanged: TdxEventHandler read FonValueChanged write Set_onValueChanged;
  end;

implementation


constructor TjdxTagBox.Create(aOwner: TComponent);
begin
  inherited;
  FacceptCustomValue := true;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FallowClearing := true;
  FapplyValueMode := avmInstantly;
  Fbuttons := TJSArray.new;
  FcloseAction := nil;
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
  FhiddenAction := nil;
  FhideSelectedItems := false;
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
  FmaxDisplayedTags := 0;
  FmaxFilterQueryLength := 0;
  FmaxLength := nil;
  FminSearchLength := 0;
  Fmode := tbtText;
  Fmultiline := true;
  Fname_ := '';
  FnoDataText := '';
  FopenAction := nil;
  Fopened := false;
  FopenOnFieldClick := false;
  Fplaceholder := '';
  FreadOnly := false;
  FrtlEnabled := false;
  FsearchEnabled := false;
  FsearchExpr := nil;
  FsearchMode := ssmContains;
  FsearchTimeout := 0;
  FselectAllMode := samPage;
  FselectAllText := '';
  FselectedItem := nil;
  FselectedItems := TJSArray.new;
  FshowClearButton := false;
  FshowDataBeforeSearch := false;
  FshowDropDownButton := true;
  FshowMaskMode := mmAlways;
  FshowMultiTagOnly := true;
  FshownAction := nil;
  FshowSelectionControls := false;
  Fspellcheck := false;
  FstylingMode := esOutlined;
  FtabIndex := 0;
  FtagTemplate := nil;
  Ftext := '';
  FuseItemTextAsTitle := false;
  FuseMaskedValue := false;
  FuseSubmitBehavior := true;
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
  FonMultiTagPreparing := nil;
  FonOpened := nil;
  FonOptionChanged := nil;
  FonPaste := nil;
  FonSelectAllValueChanged := nil;
  FonSelectionChanged := nil;
  FonValueChanged := nil;
end;

procedure TjdxTagBox.Set_acceptCustomValue(const Value: boolean);
begin
  FacceptCustomValue := Value;
end;

procedure TjdxTagBox.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxTagBox.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxTagBox.Set_allowClearing(const Value: boolean);
begin
  FallowClearing := Value;
end;

procedure TjdxTagBox.Set_applyValueMode(const Value: TdxApplyValueMode);
begin
  FapplyValueMode := Value;
end;

procedure TjdxTagBox.Set_buttons(const Value: TJSArray);
begin
  Fbuttons := Value;
end;

procedure TjdxTagBox.Set_closeAction(const Value: JSValue);
begin
  FcloseAction := Value;
end;

procedure TjdxTagBox.Set_customItemCreateEvent(const Value: string);
begin
  FcustomItemCreateEvent := Value;
end;

procedure TjdxTagBox.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxTagBox.Set_deferRendering(const Value: boolean);
begin
  FdeferRendering := Value;
end;

procedure TjdxTagBox.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxTagBox.Set_displayExpr(const Value: JSValue);
begin
  FdisplayExpr := Value;
end;

procedure TjdxTagBox.Set_dropDownButtonTemplate(const Value: JSValue);
begin
  FdropDownButtonTemplate := Value;
end;

procedure TjdxTagBox.Set_dropDownOptions(const Value: JSValue);
begin
  FdropDownOptions := Value;
end;

procedure TjdxTagBox.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxTagBox.Set_fieldTemplate(const Value: JSValue);
begin
  FfieldTemplate := Value;
end;

procedure TjdxTagBox.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxTagBox.Set_grouped(const Value: boolean);
begin
  Fgrouped := Value;
end;

procedure TjdxTagBox.Set_groupTemplate(const Value: JSValue);
begin
  FgroupTemplate := Value;
end;

procedure TjdxTagBox.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxTagBox.Set_hiddenAction(const Value: JSValue);
begin
  FhiddenAction := Value;
end;

procedure TjdxTagBox.Set_hideSelectedItems(const Value: boolean);
begin
  FhideSelectedItems := Value;
end;

procedure TjdxTagBox.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxTagBox.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxTagBox.Set_inputAttr(const Value: JSValue);
begin
  FinputAttr := Value;
end;

procedure TjdxTagBox.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
end;

procedure TjdxTagBox.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
end;

procedure TjdxTagBox.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
end;

procedure TjdxTagBox.Set_label_(const Value: string);
begin
  Flabel_ := Value;
end;

procedure TjdxTagBox.Set_labelMode(const Value: TdxLabelMode);
begin
  FlabelMode := Value;
end;

procedure TjdxTagBox.Set_mask(const Value: string);
begin
  Fmask := Value;
end;

procedure TjdxTagBox.Set_maskChar(const Value: string);
begin
  FmaskChar := Value;
end;

procedure TjdxTagBox.Set_maskInvalidMessage(const Value: string);
begin
  FmaskInvalidMessage := Value;
end;

procedure TjdxTagBox.Set_maskRules(const Value: JSValue);
begin
  FmaskRules := Value;
end;

procedure TjdxTagBox.Set_maxDisplayedTags(const Value: integer);
begin
  FmaxDisplayedTags := Value;
end;

procedure TjdxTagBox.Set_maxFilterQueryLength(const Value: integer);
begin
  FmaxFilterQueryLength := Value;
end;

procedure TjdxTagBox.Set_maxLength(const Value: JSValue);
begin
  FmaxLength := Value;
end;

procedure TjdxTagBox.Set_minSearchLength(const Value: integer);
begin
  FminSearchLength := Value;
end;

procedure TjdxTagBox.Set_mode(const Value: TdxTextBoxType);
begin
  Fmode := Value;
end;

procedure TjdxTagBox.Set_multiline(const Value: boolean);
begin
  Fmultiline := Value;
end;

procedure TjdxTagBox.Set_name_(const Value: string);
begin
  Fname_ := Value;
end;

procedure TjdxTagBox.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
end;

procedure TjdxTagBox.Set_openAction(const Value: JSValue);
begin
  FopenAction := Value;
end;

procedure TjdxTagBox.Set_opened(const Value: boolean);
begin
  Fopened := Value;
end;

procedure TjdxTagBox.Set_openOnFieldClick(const Value: boolean);
begin
  FopenOnFieldClick := Value;
end;

procedure TjdxTagBox.Set_placeholder(const Value: string);
begin
  Fplaceholder := Value;
end;

procedure TjdxTagBox.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
end;

procedure TjdxTagBox.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxTagBox.Set_searchEnabled(const Value: boolean);
begin
  FsearchEnabled := Value;
end;

procedure TjdxTagBox.Set_searchExpr(const Value: JSValue);
begin
  FsearchExpr := Value;
end;

procedure TjdxTagBox.Set_searchMode(const Value: TdxSimplifiedSearchMode);
begin
  FsearchMode := Value;
end;

procedure TjdxTagBox.Set_searchTimeout(const Value: integer);
begin
  FsearchTimeout := Value;
end;

procedure TjdxTagBox.Set_selectAllMode(const Value: TdxSelectAllMode);
begin
  FselectAllMode := Value;
end;

procedure TjdxTagBox.Set_selectAllText(const Value: string);
begin
  FselectAllText := Value;
end;

procedure TjdxTagBox.Set_showClearButton(const Value: boolean);
begin
  FshowClearButton := Value;
end;

procedure TjdxTagBox.Set_showDataBeforeSearch(const Value: boolean);
begin
  FshowDataBeforeSearch := Value;
end;

procedure TjdxTagBox.Set_showDropDownButton(const Value: boolean);
begin
  FshowDropDownButton := Value;
end;

procedure TjdxTagBox.Set_showMaskMode(const Value: TdxMaskMode);
begin
  FshowMaskMode := Value;
end;

procedure TjdxTagBox.Set_showMultiTagOnly(const Value: boolean);
begin
  FshowMultiTagOnly := Value;
end;

procedure TjdxTagBox.Set_shownAction(const Value: JSValue);
begin
  FshownAction := Value;
end;

procedure TjdxTagBox.Set_showSelectionControls(const Value: boolean);
begin
  FshowSelectionControls := Value;
end;

procedure TjdxTagBox.Set_spellcheck(const Value: boolean);
begin
  Fspellcheck := Value;
end;

procedure TjdxTagBox.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
end;

procedure TjdxTagBox.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxTagBox.Set_tagTemplate(const Value: JSValue);
begin
  FtagTemplate := Value;
end;

procedure TjdxTagBox.Set_useItemTextAsTitle(const Value: boolean);
begin
  FuseItemTextAsTitle := Value;
end;

procedure TjdxTagBox.Set_useMaskedValue(const Value: boolean);
begin
  FuseMaskedValue := Value;
end;

procedure TjdxTagBox.Set_useSubmitBehavior(const Value: boolean);
begin
  FuseSubmitBehavior := Value;
end;

procedure TjdxTagBox.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
end;

procedure TjdxTagBox.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
end;

procedure TjdxTagBox.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
end;

procedure TjdxTagBox.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
end;

procedure TjdxTagBox.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
end;

procedure TjdxTagBox.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
end;

procedure TjdxTagBox.Set_valueChangeEvent(const Value: string);
begin
  FvalueChangeEvent := Value;
end;

procedure TjdxTagBox.Set_valueExpr(const Value: JSValue);
begin
  FvalueExpr := Value;
end;

procedure TjdxTagBox.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxTagBox.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxTagBox.Set_wrapItemText(const Value: boolean);
begin
  FwrapItemText := Value;
end;

procedure TjdxTagBox.Set_onChange(const Value: TdxEventHandler);
begin
  FonChange := Value;
end;

procedure TjdxTagBox.Set_onClosed(const Value: TdxEventHandler);
begin
  FonClosed := Value;
end;

procedure TjdxTagBox.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxTagBox.Set_onCopy(const Value: TdxEventHandler);
begin
  FonCopy := Value;
end;

procedure TjdxTagBox.Set_onCustomItemCreating(const Value: TdxEventHandler);
begin
  FonCustomItemCreating := Value;
end;

procedure TjdxTagBox.Set_onCut(const Value: TdxEventHandler);
begin
  FonCut := Value;
end;

procedure TjdxTagBox.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxTagBox.Set_onEnterKey(const Value: TdxEventHandler);
begin
  FonEnterKey := Value;
end;

procedure TjdxTagBox.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxTagBox.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxTagBox.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxTagBox.Set_onInput(const Value: TdxEventHandler);
begin
  FonInput := Value;
end;

procedure TjdxTagBox.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
end;

procedure TjdxTagBox.Set_onKeyDown(const Value: TdxEventHandler);
begin
  FonKeyDown := Value;
end;

procedure TjdxTagBox.Set_onKeyUp(const Value: TdxEventHandler);
begin
  FonKeyUp := Value;
end;

procedure TjdxTagBox.Set_onMultiTagPreparing(const Value: TdxEventHandler);
begin
  FonMultiTagPreparing := Value;
end;

procedure TjdxTagBox.Set_onOpened(const Value: TdxEventHandler);
begin
  FonOpened := Value;
end;

procedure TjdxTagBox.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxTagBox.Set_onPaste(const Value: TdxEventHandler);
begin
  FonPaste := Value;
end;

procedure TjdxTagBox.Set_onSelectAllValueChanged(const Value: TdxEventHandler);
begin
  FonSelectAllValueChanged := Value;
end;

procedure TjdxTagBox.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
end;

procedure TjdxTagBox.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
end;

end.
