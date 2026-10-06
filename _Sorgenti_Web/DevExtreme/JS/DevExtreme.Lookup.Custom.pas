unit DevExtreme.Lookup.Custom;

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
  DevExtreme.Lookup.JS,
  DevExtreme.Types;

type
  TjdxCustomLookup = class(TjdxCustomControl)
  private
    FacceptCustomValue: boolean;
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FapplyButtonText: string;
    FapplyValueMode: TdxApplyValueMode;
    Fbuttons: TJSArray;
    FcancelButtonText: string;
    FcleanSearchOnOpening: boolean;
    FclearButtonText: string;
    FdataSource: JSValue;
    FdeferRendering: boolean;
    Fdisabled: boolean;
    FdisplayExpr: JSValue;
    FdisplayValue: string;
    FdropDownButtonTemplate: JSValue;
    FdropDownCentered: boolean;
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
    FnextButtonText: string;
    FnoDataText: string;
    Fopened: boolean;
    FopenOnFieldClick: boolean;
    FpageLoadingText: string;
    FpageLoadMode: TdxPageLoadMode;
    Fplaceholder: string;
    FpulledDownText: string;
    FpullingDownText: string;
    FpullRefreshEnabled: boolean;
    FreadOnly: boolean;
    FrefreshingText: string;
    FrtlEnabled: boolean;
    FsearchEnabled: boolean;
    FsearchExpr: JSValue;
    FsearchMode: TdxSimplifiedSearchMode;
    FsearchPlaceholder: string;
    FsearchStartEvent: string;
    FsearchTimeout: integer;
    FselectedItem: JSValue;
    FshowCancelButton: boolean;
    FshowClearButton: boolean;
    FshowDataBeforeSearch: boolean;
    FshowDropDownButton: boolean;
    FshowMaskMode: TdxMaskMode;
    Fspellcheck: boolean;
    FstylingMode: TdxEditorStyle;
    FtabIndex: integer;
    Ftext: string;
    FuseItemTextAsTitle: boolean;
    FuseMaskedValue: boolean;
    FuseNativeScrolling: boolean;
    FusePopover: boolean;
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
    FonPageLoading: TdxEventHandler;
    FonPaste: TdxEventHandler;
    FonPullRefresh: TdxEventHandler;
    FonScroll: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
    FonValueChanged: TdxEventHandler;
  private
    procedure Set_acceptCustomValue(const value: boolean);
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_applyButtonText(const value: string);
    procedure Set_applyValueMode(const value: TdxApplyValueMode);
    procedure Set_buttons(const value: TJSArray);
    procedure Set_cancelButtonText(const value: string);
    procedure Set_cleanSearchOnOpening(const value: boolean);
    procedure Set_clearButtonText(const value: string);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_deferRendering(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_displayExpr(const value: JSValue);
    procedure Set_dropDownButtonTemplate(const value: JSValue);
    procedure Set_dropDownCentered(const value: boolean);
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
    procedure Set_nextButtonText(const value: string);
    procedure Set_noDataText(const value: string);
    procedure Set_opened(const value: boolean);
    procedure Set_openOnFieldClick(const value: boolean);
    procedure Set_pageLoadingText(const value: string);
    procedure Set_pageLoadMode(const value: TdxPageLoadMode);
    procedure Set_placeholder(const value: string);
    procedure Set_pulledDownText(const value: string);
    procedure Set_pullingDownText(const value: string);
    procedure Set_pullRefreshEnabled(const value: boolean);
    procedure Set_readOnly(const value: boolean);
    procedure Set_refreshingText(const value: string);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_searchEnabled(const value: boolean);
    procedure Set_searchExpr(const value: JSValue);
    procedure Set_searchMode(const value: TdxSimplifiedSearchMode);
    procedure Set_searchPlaceholder(const value: string);
    procedure Set_searchStartEvent(const value: string);
    procedure Set_searchTimeout(const value: integer);
    procedure Set_showCancelButton(const value: boolean);
    procedure Set_showClearButton(const value: boolean);
    procedure Set_showDataBeforeSearch(const value: boolean);
    procedure Set_showDropDownButton(const value: boolean);
    procedure Set_showMaskMode(const value: TdxMaskMode);
    procedure Set_spellcheck(const value: boolean);
    procedure Set_stylingMode(const value: TdxEditorStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_useItemTextAsTitle(const value: boolean);
    procedure Set_useMaskedValue(const value: boolean);
    procedure Set_useNativeScrolling(const value: boolean);
    procedure Set_usePopover(const value: boolean);
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
    procedure Set_onPageLoading(const value: TdxEventHandler);
    procedure Set_onPaste(const value: TdxEventHandler);
    procedure Set_onPullRefresh(const value: TdxEventHandler);
    procedure Set_onScroll(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
    procedure Set_onValueChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxLookup; assembler;
    function instance: TdxLookup; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure blur(); assembler;
    procedure close(); assembler;
    function content(): TJSElement; assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    function field(): TJSElement; assembler;
    procedure focus(); assembler; overload;
    procedure getButton(); assembler; overload;
    function getButton(name_: string): JSValue; assembler; overload;
    function getDataSource(): TJSObject; assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    procedure open(); assembler;
    function option(): TJSObject; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure repaint(); assembler;
    procedure reset(); assembler;
    procedure resetOption(optionName: string); assembler;
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
    property applyButtonText: string read FapplyButtonText write Set_applyButtonText;
    property applyValueMode: TdxApplyValueMode read FapplyValueMode write Set_applyValueMode default avmInstantly;
    property cancelButtonText: string read FcancelButtonText write Set_cancelButtonText;
    property cleanSearchOnOpening: boolean read FcleanSearchOnOpening write Set_cleanSearchOnOpening default true;
    property clearButtonText: string read FclearButtonText write Set_clearButtonText;
    property deferRendering: boolean read FdeferRendering write Set_deferRendering default true;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property displayValue: string read FdisplayValue;
    property dropDownCentered: boolean read FdropDownCentered write Set_dropDownCentered;
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
    property nextButtonText: string read FnextButtonText write Set_nextButtonText;
    property noDataText: string read FnoDataText write Set_noDataText;
    property opened: boolean read Fopened write Set_opened default false;
    property openOnFieldClick: boolean read FopenOnFieldClick write Set_openOnFieldClick default false;
    property pageLoadingText: string read FpageLoadingText write Set_pageLoadingText;
    property pageLoadMode: TdxPageLoadMode read FpageLoadMode write Set_pageLoadMode default plmScrollBottom;
    property placeholder: string read Fplaceholder write Set_placeholder;
    property pulledDownText: string read FpulledDownText write Set_pulledDownText;
    property pullingDownText: string read FpullingDownText write Set_pullingDownText;
    property pullRefreshEnabled: boolean read FpullRefreshEnabled write Set_pullRefreshEnabled default false;
    property readOnly: boolean read FreadOnly write Set_readOnly default false;
    property refreshingText: string read FrefreshingText write Set_refreshingText;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property searchEnabled: boolean read FsearchEnabled write Set_searchEnabled default false;
    property searchMode: TdxSimplifiedSearchMode read FsearchMode write Set_searchMode default ssmContains;
    property searchPlaceholder: string read FsearchPlaceholder write Set_searchPlaceholder;
    property searchStartEvent: string read FsearchStartEvent write Set_searchStartEvent;
    property searchTimeout: integer read FsearchTimeout write Set_searchTimeout;
    property showCancelButton: boolean read FshowCancelButton write Set_showCancelButton;
    property showClearButton: boolean read FshowClearButton write Set_showClearButton default false;
    property showDataBeforeSearch: boolean read FshowDataBeforeSearch write Set_showDataBeforeSearch default false;
    property showDropDownButton: boolean read FshowDropDownButton write Set_showDropDownButton default true;
    property showMaskMode: TdxMaskMode read FshowMaskMode write Set_showMaskMode default mmAlways;
    property spellcheck: boolean read Fspellcheck write Set_spellcheck default false;
    property stylingMode: TdxEditorStyle read FstylingMode write Set_stylingMode default esOutlined;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property text: string read Ftext;
    property useItemTextAsTitle: boolean read FuseItemTextAsTitle write Set_useItemTextAsTitle default false;
    property useMaskedValue: boolean read FuseMaskedValue write Set_useMaskedValue default false;
    property useNativeScrolling: boolean read FuseNativeScrolling write Set_useNativeScrolling;
    property usePopover: boolean read FusePopover write Set_usePopover;
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
    property onPageLoading: TdxEventHandler read FonPageLoading write Set_onPageLoading;
    property onPaste: TdxEventHandler read FonPaste write Set_onPaste;
    property onPullRefresh: TdxEventHandler read FonPullRefresh write Set_onPullRefresh;
    property onScroll: TdxEventHandler read FonScroll write Set_onScroll;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
    property onValueChanged: TdxEventHandler read FonValueChanged write Set_onValueChanged;
  end;

implementation


procedure TjdxCustomLookup.CreateInitialize;
begin
  inherited;
  FacceptCustomValue := true;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FapplyButtonText := '';
  FapplyValueMode := avmInstantly;
  Fbuttons := TJSArray.new;
  FcancelButtonText := '';
  FcleanSearchOnOpening := true;
  FclearButtonText := '';
  FdataSource := nil;
  FdeferRendering := true;
  Fdisabled := false;
  FdisplayExpr := nil;
  FdisplayValue := '';
  FdropDownButtonTemplate := nil;
  FdropDownCentered := false;
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
  FnextButtonText := '';
  FnoDataText := '';
  Fopened := false;
  FopenOnFieldClick := false;
  FpageLoadingText := '';
  FpageLoadMode := plmScrollBottom;
  Fplaceholder := '';
  FpulledDownText := '';
  FpullingDownText := '';
  FpullRefreshEnabled := false;
  FreadOnly := false;
  FrefreshingText := '';
  FrtlEnabled := false;
  FsearchEnabled := false;
  FsearchExpr := nil;
  FsearchMode := ssmContains;
  FsearchPlaceholder := '';
  FsearchStartEvent := '';
  FsearchTimeout := 0;
  FselectedItem := nil;
  FshowCancelButton := false;
  FshowClearButton := false;
  FshowDataBeforeSearch := false;
  FshowDropDownButton := true;
  FshowMaskMode := mmAlways;
  Fspellcheck := false;
  FstylingMode := esOutlined;
  FtabIndex := 0;
  Ftext := '';
  FuseItemTextAsTitle := false;
  FuseMaskedValue := false;
  FuseNativeScrolling := false;
  FusePopover := false;
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
  FonPageLoading := nil;
  FonPaste := nil;
  FonPullRefresh := nil;
  FonScroll := nil;
  FonSelectionChanged := nil;
  FonValueChanged := nil;
end;
procedure TjdxCustomLookup.InitJQuery;
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
      $(id).dxLookup(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomLookup.getInstance(element: TJSObject): TdxLookup;
asm
  return DevExpress.viz.dxLookup.getInstance(element);
end;

function TjdxCustomLookup.instance: TdxLookup;
asm
  return $(this.GetJQID()).dxLookup("instance");
end;
procedure TjdxCustomLookup.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('acceptCustomValue', acceptCustomValue);
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('applyButtonText', applyButtonText);
    SetOption('applyValueMode', applyValueMode.ToString());
    SetOption('buttons', buttons);
    SetOption('cancelButtonText', cancelButtonText);
    SetOption('cleanSearchOnOpening', cleanSearchOnOpening);
    SetOption('clearButtonText', clearButtonText);
    SetOption('dataSource', dataSource);
    SetOption('deferRendering', deferRendering);
    SetOption('disabled', disabled);
    SetOption('displayExpr', displayExpr);
    SetOption('displayValue', displayValue);
    SetOption('dropDownButtonTemplate', dropDownButtonTemplate);
    SetOption('dropDownCentered', dropDownCentered);
    SetOption('dropDownOptions', dropDownOptions);
    SetOption('elementAttr', elementAttr);
    SetOption('fieldTemplate', fieldTemplate);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('grouped', grouped);
    SetOption('groupTemplate', groupTemplate);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('inputAttr', inputAttr);
    SetOption('isValid', isValid);
    SetOption('items', items);
    SetOption('itemTemplate', itemTemplate);
    SetOption('label', label_);
    SetOption('labelMode', labelMode.ToString());
    SetOption('mask', mask);
    SetOption('maskChar', maskChar);
    SetOption('maskInvalidMessage', maskInvalidMessage);
    SetOption('maskRules', maskRules);
    SetOption('maxLength', maxLength);
    SetOption('minSearchLength', minSearchLength);
    SetOption('mode', mode.ToString());
    SetOption('name', name_);
    SetOption('nextButtonText', nextButtonText);
    SetOption('noDataText', noDataText);
    SetOption('opened', opened);
    SetOption('openOnFieldClick', openOnFieldClick);
    SetOption('pageLoadingText', pageLoadingText);
    SetOption('pageLoadMode', pageLoadMode.ToString());
    SetOption('placeholder', placeholder);
    SetOption('pulledDownText', pulledDownText);
    SetOption('pullingDownText', pullingDownText);
    SetOption('pullRefreshEnabled', pullRefreshEnabled);
    SetOption('readOnly', readOnly);
    SetOption('refreshingText', refreshingText);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('searchEnabled', searchEnabled);
    SetOption('searchExpr', searchExpr);
    SetOption('searchMode', searchMode.ToString());
    SetOption('searchPlaceholder', searchPlaceholder);
    SetOption('searchStartEvent', searchStartEvent);
    SetOption('searchTimeout', searchTimeout);
    SetOption('selectedItem', selectedItem);
    SetOption('showCancelButton', showCancelButton);
    SetOption('showClearButton', showClearButton);
    SetOption('showDataBeforeSearch', showDataBeforeSearch);
    SetOption('showDropDownButton', showDropDownButton);
    SetOption('showMaskMode', showMaskMode.ToString());
    SetOption('spellcheck', spellcheck);
    SetOption('stylingMode', stylingMode.ToString());
    SetOption('tabIndex', tabIndex);
    SetOption('text', text);
    SetOption('useItemTextAsTitle', useItemTextAsTitle);
    SetOption('useMaskedValue', useMaskedValue);
    SetOption('useNativeScrolling', useNativeScrolling);
    SetOption('usePopover', usePopover);
    SetOption('validationError', validationError);
    SetOption('validationErrors', validationErrors);
    SetOption('validationMessageMode', validationMessageMode.ToString());
    SetOption('validationMessagePosition', validationMessagePosition.ToString());
    SetOption('validationStatus', validationStatus.ToString());
    SetOption('value', value);
    SetOption('valueChangeEvent', valueChangeEvent);
    SetOption('valueExpr', valueExpr);
    SetOption('visible', visible);
    SetOption('width', width_);
    SetOption('wrapItemText', wrapItemText);

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
    SetEvent('itemClick', onItemClick);
    SetEvent('keyDown', onKeyDown);
    SetEvent('keyUp', onKeyUp);
    SetEvent('opened', onOpened);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('pageLoading', onPageLoading);
    SetEvent('paste', onPaste);
    SetEvent('pullRefresh', onPullRefresh);
    SetEvent('scroll', onScroll);
    SetEvent('selectionChanged', onSelectionChanged);
    SetEvent('valueChanged', onValueChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomLookup.Set_acceptCustomValue(const Value: boolean);
begin
  FacceptCustomValue := Value;
  SetOption('acceptCustomValue', acceptCustomValue);
end;

procedure TjdxCustomLookup.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomLookup.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomLookup.Set_applyButtonText(const Value: string);
begin
  FapplyButtonText := Value;
  SetOption('applyButtonText', applyButtonText);
end;

procedure TjdxCustomLookup.Set_applyValueMode(const Value: TdxApplyValueMode);
begin
  FapplyValueMode := Value;
  SetOption('applyValueMode', applyValueMode.ToString());
end;

procedure TjdxCustomLookup.Set_buttons(const Value: TJSArray);
begin
  Fbuttons := Value;
  SetOption('buttons', buttons);
end;

procedure TjdxCustomLookup.Set_cancelButtonText(const Value: string);
begin
  FcancelButtonText := Value;
  SetOption('cancelButtonText', cancelButtonText);
end;

procedure TjdxCustomLookup.Set_cleanSearchOnOpening(const Value: boolean);
begin
  FcleanSearchOnOpening := Value;
  SetOption('cleanSearchOnOpening', cleanSearchOnOpening);
end;

procedure TjdxCustomLookup.Set_clearButtonText(const Value: string);
begin
  FclearButtonText := Value;
  SetOption('clearButtonText', clearButtonText);
end;

procedure TjdxCustomLookup.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomLookup.Set_deferRendering(const Value: boolean);
begin
  FdeferRendering := Value;
  SetOption('deferRendering', deferRendering);
end;

procedure TjdxCustomLookup.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomLookup.Set_displayExpr(const Value: JSValue);
begin
  FdisplayExpr := Value;
  SetOption('displayExpr', displayExpr);
end;

procedure TjdxCustomLookup.Set_dropDownButtonTemplate(const Value: JSValue);
begin
  FdropDownButtonTemplate := Value;
  SetOption('dropDownButtonTemplate', dropDownButtonTemplate);
end;

procedure TjdxCustomLookup.Set_dropDownCentered(const Value: boolean);
begin
  FdropDownCentered := Value;
  SetOption('dropDownCentered', dropDownCentered);
end;

procedure TjdxCustomLookup.Set_dropDownOptions(const Value: JSValue);
begin
  FdropDownOptions := Value;
  SetOption('dropDownOptions', dropDownOptions);
end;

procedure TjdxCustomLookup.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomLookup.Set_fieldTemplate(const Value: JSValue);
begin
  FfieldTemplate := Value;
  SetOption('fieldTemplate', fieldTemplate);
end;

procedure TjdxCustomLookup.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomLookup.Set_grouped(const Value: boolean);
begin
  Fgrouped := Value;
  SetOption('grouped', grouped);
end;

procedure TjdxCustomLookup.Set_groupTemplate(const Value: JSValue);
begin
  FgroupTemplate := Value;
  SetOption('groupTemplate', groupTemplate);
end;

procedure TjdxCustomLookup.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomLookup.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomLookup.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomLookup.Set_inputAttr(const Value: JSValue);
begin
  FinputAttr := Value;
  SetOption('inputAttr', inputAttr);
end;

procedure TjdxCustomLookup.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
  SetOption('isValid', isValid);
end;

procedure TjdxCustomLookup.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
  SetOption('items', items);
end;

procedure TjdxCustomLookup.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
  SetOption('itemTemplate', itemTemplate);
end;

procedure TjdxCustomLookup.Set_label_(const Value: string);
begin
  Flabel_ := Value;
  SetOption('label', label_);
end;

procedure TjdxCustomLookup.Set_labelMode(const Value: TdxLabelMode);
begin
  FlabelMode := Value;
  SetOption('labelMode', labelMode.ToString());
end;

procedure TjdxCustomLookup.Set_mask(const Value: string);
begin
  Fmask := Value;
  SetOption('mask', mask);
end;

procedure TjdxCustomLookup.Set_maskChar(const Value: string);
begin
  FmaskChar := Value;
  SetOption('maskChar', maskChar);
end;

procedure TjdxCustomLookup.Set_maskInvalidMessage(const Value: string);
begin
  FmaskInvalidMessage := Value;
  SetOption('maskInvalidMessage', maskInvalidMessage);
end;

procedure TjdxCustomLookup.Set_maskRules(const Value: JSValue);
begin
  FmaskRules := Value;
  SetOption('maskRules', maskRules);
end;

procedure TjdxCustomLookup.Set_maxLength(const Value: JSValue);
begin
  FmaxLength := Value;
  SetOption('maxLength', maxLength);
end;

procedure TjdxCustomLookup.Set_minSearchLength(const Value: integer);
begin
  FminSearchLength := Value;
  SetOption('minSearchLength', minSearchLength);
end;

procedure TjdxCustomLookup.Set_mode(const Value: TdxTextBoxType);
begin
  Fmode := Value;
  SetOption('mode', mode.ToString());
end;

procedure TjdxCustomLookup.Set_name_(const Value: string);
begin
  Fname_ := Value;
  SetOption('name', name_);
end;

procedure TjdxCustomLookup.Set_nextButtonText(const Value: string);
begin
  FnextButtonText := Value;
  SetOption('nextButtonText', nextButtonText);
end;

procedure TjdxCustomLookup.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
  SetOption('noDataText', noDataText);
end;

procedure TjdxCustomLookup.Set_opened(const Value: boolean);
begin
  Fopened := Value;
  SetOption('opened', opened);
end;

procedure TjdxCustomLookup.Set_openOnFieldClick(const Value: boolean);
begin
  FopenOnFieldClick := Value;
  SetOption('openOnFieldClick', openOnFieldClick);
end;

procedure TjdxCustomLookup.Set_pageLoadingText(const Value: string);
begin
  FpageLoadingText := Value;
  SetOption('pageLoadingText', pageLoadingText);
end;

procedure TjdxCustomLookup.Set_pageLoadMode(const Value: TdxPageLoadMode);
begin
  FpageLoadMode := Value;
  SetOption('pageLoadMode', pageLoadMode.ToString());
end;

procedure TjdxCustomLookup.Set_placeholder(const Value: string);
begin
  Fplaceholder := Value;
  SetOption('placeholder', placeholder);
end;

procedure TjdxCustomLookup.Set_pulledDownText(const Value: string);
begin
  FpulledDownText := Value;
  SetOption('pulledDownText', pulledDownText);
end;

procedure TjdxCustomLookup.Set_pullingDownText(const Value: string);
begin
  FpullingDownText := Value;
  SetOption('pullingDownText', pullingDownText);
end;

procedure TjdxCustomLookup.Set_pullRefreshEnabled(const Value: boolean);
begin
  FpullRefreshEnabled := Value;
  SetOption('pullRefreshEnabled', pullRefreshEnabled);
end;

procedure TjdxCustomLookup.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
  SetOption('readOnly', readOnly);
end;

procedure TjdxCustomLookup.Set_refreshingText(const Value: string);
begin
  FrefreshingText := Value;
  SetOption('refreshingText', refreshingText);
end;

procedure TjdxCustomLookup.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomLookup.Set_searchEnabled(const Value: boolean);
begin
  FsearchEnabled := Value;
  SetOption('searchEnabled', searchEnabled);
end;

procedure TjdxCustomLookup.Set_searchExpr(const Value: JSValue);
begin
  FsearchExpr := Value;
  SetOption('searchExpr', searchExpr);
end;

procedure TjdxCustomLookup.Set_searchMode(const Value: TdxSimplifiedSearchMode);
begin
  FsearchMode := Value;
  SetOption('searchMode', searchMode.ToString());
end;

procedure TjdxCustomLookup.Set_searchPlaceholder(const Value: string);
begin
  FsearchPlaceholder := Value;
  SetOption('searchPlaceholder', searchPlaceholder);
end;

procedure TjdxCustomLookup.Set_searchStartEvent(const Value: string);
begin
  FsearchStartEvent := Value;
  SetOption('searchStartEvent', searchStartEvent);
end;

procedure TjdxCustomLookup.Set_searchTimeout(const Value: integer);
begin
  FsearchTimeout := Value;
  SetOption('searchTimeout', searchTimeout);
end;

procedure TjdxCustomLookup.Set_showCancelButton(const Value: boolean);
begin
  FshowCancelButton := Value;
  SetOption('showCancelButton', showCancelButton);
end;

procedure TjdxCustomLookup.Set_showClearButton(const Value: boolean);
begin
  FshowClearButton := Value;
  SetOption('showClearButton', showClearButton);
end;

procedure TjdxCustomLookup.Set_showDataBeforeSearch(const Value: boolean);
begin
  FshowDataBeforeSearch := Value;
  SetOption('showDataBeforeSearch', showDataBeforeSearch);
end;

procedure TjdxCustomLookup.Set_showDropDownButton(const Value: boolean);
begin
  FshowDropDownButton := Value;
  SetOption('showDropDownButton', showDropDownButton);
end;

procedure TjdxCustomLookup.Set_showMaskMode(const Value: TdxMaskMode);
begin
  FshowMaskMode := Value;
  SetOption('showMaskMode', showMaskMode.ToString());
end;

procedure TjdxCustomLookup.Set_spellcheck(const Value: boolean);
begin
  Fspellcheck := Value;
  SetOption('spellcheck', spellcheck);
end;

procedure TjdxCustomLookup.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
  SetOption('stylingMode', stylingMode.ToString());
end;

procedure TjdxCustomLookup.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomLookup.Set_useItemTextAsTitle(const Value: boolean);
begin
  FuseItemTextAsTitle := Value;
  SetOption('useItemTextAsTitle', useItemTextAsTitle);
end;

procedure TjdxCustomLookup.Set_useMaskedValue(const Value: boolean);
begin
  FuseMaskedValue := Value;
  SetOption('useMaskedValue', useMaskedValue);
end;

procedure TjdxCustomLookup.Set_useNativeScrolling(const Value: boolean);
begin
  FuseNativeScrolling := Value;
  SetOption('useNativeScrolling', useNativeScrolling);
end;

procedure TjdxCustomLookup.Set_usePopover(const Value: boolean);
begin
  FusePopover := Value;
  SetOption('usePopover', usePopover);
end;

procedure TjdxCustomLookup.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
  SetOption('validationError', validationError);
end;

procedure TjdxCustomLookup.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
  SetOption('validationErrors', validationErrors);
end;

procedure TjdxCustomLookup.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
  SetOption('validationMessageMode', validationMessageMode.ToString());
end;

procedure TjdxCustomLookup.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
  SetOption('validationMessagePosition', validationMessagePosition.ToString());
end;

procedure TjdxCustomLookup.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
  SetOption('validationStatus', validationStatus.ToString());
end;

procedure TjdxCustomLookup.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
  SetOption('value', value);
end;

procedure TjdxCustomLookup.Set_valueChangeEvent(const Value: string);
begin
  FvalueChangeEvent := Value;
  SetOption('valueChangeEvent', valueChangeEvent);
end;

procedure TjdxCustomLookup.Set_valueExpr(const Value: JSValue);
begin
  FvalueExpr := Value;
  SetOption('valueExpr', valueExpr);
end;

procedure TjdxCustomLookup.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomLookup.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomLookup.Set_wrapItemText(const Value: boolean);
begin
  FwrapItemText := Value;
  SetOption('wrapItemText', wrapItemText);
end;

procedure TjdxCustomLookup.Set_onChange(const Value: TdxEventHandler);
begin
  FonChange := Value;
  SetEvent('change', onChange);
end;

procedure TjdxCustomLookup.Set_onClosed(const Value: TdxEventHandler);
begin
  FonClosed := Value;
  SetEvent('closed', onClosed);
end;

procedure TjdxCustomLookup.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomLookup.Set_onCopy(const Value: TdxEventHandler);
begin
  FonCopy := Value;
  SetEvent('copy', onCopy);
end;

procedure TjdxCustomLookup.Set_onCut(const Value: TdxEventHandler);
begin
  FonCut := Value;
  SetEvent('cut', onCut);
end;

procedure TjdxCustomLookup.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomLookup.Set_onEnterKey(const Value: TdxEventHandler);
begin
  FonEnterKey := Value;
  SetEvent('enterKey', onEnterKey);
end;

procedure TjdxCustomLookup.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomLookup.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomLookup.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomLookup.Set_onInput(const Value: TdxEventHandler);
begin
  FonInput := Value;
  SetEvent('input', onInput);
end;

procedure TjdxCustomLookup.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
  SetEvent('itemClick', onItemClick);
end;

procedure TjdxCustomLookup.Set_onKeyDown(const Value: TdxEventHandler);
begin
  FonKeyDown := Value;
  SetEvent('keyDown', onKeyDown);
end;

procedure TjdxCustomLookup.Set_onKeyUp(const Value: TdxEventHandler);
begin
  FonKeyUp := Value;
  SetEvent('keyUp', onKeyUp);
end;

procedure TjdxCustomLookup.Set_onOpened(const Value: TdxEventHandler);
begin
  FonOpened := Value;
  SetEvent('opened', onOpened);
end;

procedure TjdxCustomLookup.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomLookup.Set_onPageLoading(const Value: TdxEventHandler);
begin
  FonPageLoading := Value;
  SetEvent('pageLoading', onPageLoading);
end;

procedure TjdxCustomLookup.Set_onPaste(const Value: TdxEventHandler);
begin
  FonPaste := Value;
  SetEvent('paste', onPaste);
end;

procedure TjdxCustomLookup.Set_onPullRefresh(const Value: TdxEventHandler);
begin
  FonPullRefresh := Value;
  SetEvent('pullRefresh', onPullRefresh);
end;

procedure TjdxCustomLookup.Set_onScroll(const Value: TdxEventHandler);
begin
  FonScroll := Value;
  SetEvent('scroll', onScroll);
end;

procedure TjdxCustomLookup.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomLookup.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
  SetEvent('valueChanged', onValueChanged);
end;

procedure TjdxCustomLookup.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomLookup.blur();
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.blur();
end;

procedure TjdxCustomLookup.close();
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.close();
end;

function TjdxCustomLookup.content(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  return _instance.content();
end;

procedure TjdxCustomLookup.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomLookup.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomLookup.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomLookup.dispose();
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.dispose();
end;

function TjdxCustomLookup.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  return _instance.element();
end;

procedure TjdxCustomLookup.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.endUpdate();
end;

function TjdxCustomLookup.field(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  return _instance.field();
end;

procedure TjdxCustomLookup.focus();
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.focus();
end;

procedure TjdxCustomLookup.getButton();
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.getButton();
end;

function TjdxCustomLookup.getButton(name_: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  return _instance.getButton(name_);
end;

function TjdxCustomLookup.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  return _instance.getDataSource();
end;

function TjdxCustomLookup.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomLookup.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  return _instance.off(eventName);
end;

function TjdxCustomLookup.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomLookup.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  return _instance.on(events);
end;

procedure TjdxCustomLookup.open();
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.open();
end;

function TjdxCustomLookup.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  return _instance.option();
end;

procedure TjdxCustomLookup.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomLookup.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.option(options);
end;

function TjdxCustomLookup.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomLookup.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomLookup.repaint();
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.repaint();
end;

procedure TjdxCustomLookup.reset();
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.reset();
end;

procedure TjdxCustomLookup.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxLookup("instance");
  _instance.resetOption(optionName);
end;

end.
