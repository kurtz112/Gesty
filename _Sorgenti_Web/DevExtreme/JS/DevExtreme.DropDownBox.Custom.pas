unit DevExtreme.DropDownBox.Custom;

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
  DevExtreme.DropDownBox.JS,
  DevExtreme.Types;

type
  TjdxCustomDropDownBox = class(TjdxCustomControl)
  private
    FacceptCustomValue: boolean;
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FapplyValueMode: TdxApplyValueMode;
    Fattr: JSValue;
    Fbuttons: TJSArray;
    FcontentTemplate: JSValue;
    FdataSource: JSValue;
    FdeferRendering: boolean;
    Fdisabled: boolean;
    FdisplayExpr: JSValue;
    FdisplayValueFormatter: TJSFunction;
    FdropDownButtonTemplate: JSValue;
    FdropDownOptions: JSValue;
    FelementAttr: TJSObject;
    FfieldTemplate: JSValue;
    FfocusStateEnabled: boolean;
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
    FvalueExpr: JSValue;
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
    procedure Set_applyValueMode(const value: TdxApplyValueMode);
    procedure Set_attr(const value: JSValue);
    procedure Set_buttons(const value: TJSArray);
    procedure Set_contentTemplate(const value: JSValue);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_deferRendering(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_displayExpr(const value: JSValue);
    procedure Set_displayValueFormatter(const value: TJSFunction);
    procedure Set_dropDownButtonTemplate(const value: JSValue);
    procedure Set_dropDownOptions(const value: JSValue);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_fieldTemplate(const value: JSValue);
    procedure Set_focusStateEnabled(const value: boolean);
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
    procedure Set_valueExpr(const value: JSValue);
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
    function getInstance(element: TJSObject): TdxDropDownBox; assembler;
    function instance: TdxDropDownBox; assembler;
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
    function getButton(name_: string): JSValue; assembler;
    function getDataSource(): TJSObject; assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    procedure open(); assembler;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(): TJSObject; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure repaint(); assembler;
    procedure reset(); assembler;
    procedure resetOption(optionName: string); assembler;
  public
    property attr: JSValue read Fattr write Set_attr;
    property buttons: TJSArray read Fbuttons write Set_buttons;
    property contentTemplate: JSValue read FcontentTemplate write Set_contentTemplate;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property displayExpr: JSValue read FdisplayExpr write Set_displayExpr;
    property displayValueFormatter: TJSFunction read FdisplayValueFormatter write Set_displayValueFormatter;
    property dropDownButtonTemplate: JSValue read FdropDownButtonTemplate write Set_dropDownButtonTemplate;
    property dropDownOptions: JSValue read FdropDownOptions write Set_dropDownOptions;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property fieldTemplate: JSValue read FfieldTemplate write Set_fieldTemplate;
    property height_: JSValue read Fheight_ write Set_height_;
    property inputAttr: JSValue read FinputAttr write Set_inputAttr;
    property items: TJSArray read Fitems write Set_items;
    property itemTemplate: JSValue read FitemTemplate write Set_itemTemplate;
    property maskRules: JSValue read FmaskRules write Set_maskRules;
    property maxLength: JSValue read FmaxLength write Set_maxLength;
    property validationError: JSValue read FvalidationError write Set_validationError;
    property validationErrors: TJSArray read FvalidationErrors write Set_validationErrors;
    property value: JSValue read Fvalue write Set_value;
    property valueExpr: JSValue read FvalueExpr write Set_valueExpr;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property acceptCustomValue: boolean read FacceptCustomValue write Set_acceptCustomValue default true;
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property applyValueMode: TdxApplyValueMode read FapplyValueMode write Set_applyValueMode default avmInstantly;
    property deferRendering: boolean read FdeferRendering write Set_deferRendering default true;
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


procedure TjdxCustomDropDownBox.CreateInitialize;
begin
  inherited;
  FacceptCustomValue := true;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FapplyValueMode := avmInstantly;
  Fattr := nil;
  Fbuttons := TJSArray.new;
  FcontentTemplate := nil;
  FdataSource := nil;
  FdeferRendering := true;
  Fdisabled := false;
  FdisplayExpr := nil;
  FdisplayValueFormatter := nil;
  FdropDownButtonTemplate := nil;
  FdropDownOptions := nil;
  FelementAttr := TJSObject.new;
  FfieldTemplate := nil;
  FfocusStateEnabled := false;
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
  FvalueExpr := nil;
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
procedure TjdxCustomDropDownBox.InitJQuery;
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
      $(id).dxDropDownBox(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomDropDownBox.getInstance(element: TJSObject): TdxDropDownBox;
asm
  return DevExpress.viz.dxDropDownBox.getInstance(element);
end;

function TjdxCustomDropDownBox.instance: TdxDropDownBox;
asm
  return $(this.GetJQID()).dxDropDownBox("instance");
end;
procedure TjdxCustomDropDownBox.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('acceptCustomValue', acceptCustomValue);
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('applyValueMode', applyValueMode.ToString());
    SetOption('attr', attr);
    SetOption('buttons', buttons);
    SetOption('contentTemplate', contentTemplate);
    SetOption('dataSource', dataSource);
    SetOption('deferRendering', deferRendering);
    SetOption('disabled', disabled);
    SetOption('displayExpr', displayExpr);
    SetOption('displayValueFormatter', displayValueFormatter);
    SetOption('dropDownButtonTemplate', dropDownButtonTemplate);
    SetOption('dropDownOptions', dropDownOptions);
    SetOption('elementAttr', elementAttr);
    SetOption('fieldTemplate', fieldTemplate);
    SetOption('focusStateEnabled', focusStateEnabled);
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
    SetOption('mode', mode.ToString());
    SetOption('name', name_);
    SetOption('opened', opened);
    SetOption('openOnFieldClick', openOnFieldClick);
    SetOption('placeholder', placeholder);
    SetOption('readOnly', readOnly);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('showClearButton', showClearButton);
    SetOption('showDropDownButton', showDropDownButton);
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
    SetOption('valueExpr', valueExpr);
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

procedure TjdxCustomDropDownBox.Set_acceptCustomValue(const Value: boolean);
begin
  FacceptCustomValue := Value;
  SetOption('acceptCustomValue', acceptCustomValue);
end;

procedure TjdxCustomDropDownBox.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomDropDownBox.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomDropDownBox.Set_applyValueMode(const Value: TdxApplyValueMode);
begin
  FapplyValueMode := Value;
  SetOption('applyValueMode', applyValueMode.ToString());
end;

procedure TjdxCustomDropDownBox.Set_attr(const Value: JSValue);
begin
  Fattr := Value;
  SetOption('attr', attr);
end;

procedure TjdxCustomDropDownBox.Set_buttons(const Value: TJSArray);
begin
  Fbuttons := Value;
  SetOption('buttons', buttons);
end;

procedure TjdxCustomDropDownBox.Set_contentTemplate(const Value: JSValue);
begin
  FcontentTemplate := Value;
  SetOption('contentTemplate', contentTemplate);
end;

procedure TjdxCustomDropDownBox.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomDropDownBox.Set_deferRendering(const Value: boolean);
begin
  FdeferRendering := Value;
  SetOption('deferRendering', deferRendering);
end;

procedure TjdxCustomDropDownBox.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomDropDownBox.Set_displayExpr(const Value: JSValue);
begin
  FdisplayExpr := Value;
  SetOption('displayExpr', displayExpr);
end;

procedure TjdxCustomDropDownBox.Set_displayValueFormatter(const Value: TJSFunction);
begin
  FdisplayValueFormatter := Value;
  SetOption('displayValueFormatter', displayValueFormatter);
end;

procedure TjdxCustomDropDownBox.Set_dropDownButtonTemplate(const Value: JSValue);
begin
  FdropDownButtonTemplate := Value;
  SetOption('dropDownButtonTemplate', dropDownButtonTemplate);
end;

procedure TjdxCustomDropDownBox.Set_dropDownOptions(const Value: JSValue);
begin
  FdropDownOptions := Value;
  SetOption('dropDownOptions', dropDownOptions);
end;

procedure TjdxCustomDropDownBox.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomDropDownBox.Set_fieldTemplate(const Value: JSValue);
begin
  FfieldTemplate := Value;
  SetOption('fieldTemplate', fieldTemplate);
end;

procedure TjdxCustomDropDownBox.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomDropDownBox.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomDropDownBox.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomDropDownBox.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomDropDownBox.Set_inputAttr(const Value: JSValue);
begin
  FinputAttr := Value;
  SetOption('inputAttr', inputAttr);
end;

procedure TjdxCustomDropDownBox.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
  SetOption('isValid', isValid);
end;

procedure TjdxCustomDropDownBox.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
  SetOption('items', items);
end;

procedure TjdxCustomDropDownBox.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
  SetOption('itemTemplate', itemTemplate);
end;

procedure TjdxCustomDropDownBox.Set_label_(const Value: string);
begin
  Flabel_ := Value;
  SetOption('label', label_);
end;

procedure TjdxCustomDropDownBox.Set_labelMode(const Value: TdxLabelMode);
begin
  FlabelMode := Value;
  SetOption('labelMode', labelMode.ToString());
end;

procedure TjdxCustomDropDownBox.Set_mask(const Value: string);
begin
  Fmask := Value;
  SetOption('mask', mask);
end;

procedure TjdxCustomDropDownBox.Set_maskChar(const Value: string);
begin
  FmaskChar := Value;
  SetOption('maskChar', maskChar);
end;

procedure TjdxCustomDropDownBox.Set_maskInvalidMessage(const Value: string);
begin
  FmaskInvalidMessage := Value;
  SetOption('maskInvalidMessage', maskInvalidMessage);
end;

procedure TjdxCustomDropDownBox.Set_maskRules(const Value: JSValue);
begin
  FmaskRules := Value;
  SetOption('maskRules', maskRules);
end;

procedure TjdxCustomDropDownBox.Set_maxLength(const Value: JSValue);
begin
  FmaxLength := Value;
  SetOption('maxLength', maxLength);
end;

procedure TjdxCustomDropDownBox.Set_mode(const Value: TdxTextBoxType);
begin
  Fmode := Value;
  SetOption('mode', mode.ToString());
end;

procedure TjdxCustomDropDownBox.Set_name_(const Value: string);
begin
  Fname_ := Value;
  SetOption('name', name_);
end;

procedure TjdxCustomDropDownBox.Set_opened(const Value: boolean);
begin
  Fopened := Value;
  SetOption('opened', opened);
end;

procedure TjdxCustomDropDownBox.Set_openOnFieldClick(const Value: boolean);
begin
  FopenOnFieldClick := Value;
  SetOption('openOnFieldClick', openOnFieldClick);
end;

procedure TjdxCustomDropDownBox.Set_placeholder(const Value: string);
begin
  Fplaceholder := Value;
  SetOption('placeholder', placeholder);
end;

procedure TjdxCustomDropDownBox.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
  SetOption('readOnly', readOnly);
end;

procedure TjdxCustomDropDownBox.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomDropDownBox.Set_showClearButton(const Value: boolean);
begin
  FshowClearButton := Value;
  SetOption('showClearButton', showClearButton);
end;

procedure TjdxCustomDropDownBox.Set_showDropDownButton(const Value: boolean);
begin
  FshowDropDownButton := Value;
  SetOption('showDropDownButton', showDropDownButton);
end;

procedure TjdxCustomDropDownBox.Set_showMaskMode(const Value: TdxMaskMode);
begin
  FshowMaskMode := Value;
  SetOption('showMaskMode', showMaskMode.ToString());
end;

procedure TjdxCustomDropDownBox.Set_spellcheck(const Value: boolean);
begin
  Fspellcheck := Value;
  SetOption('spellcheck', spellcheck);
end;

procedure TjdxCustomDropDownBox.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
  SetOption('stylingMode', stylingMode.ToString());
end;

procedure TjdxCustomDropDownBox.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomDropDownBox.Set_useMaskedValue(const Value: boolean);
begin
  FuseMaskedValue := Value;
  SetOption('useMaskedValue', useMaskedValue);
end;

procedure TjdxCustomDropDownBox.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
  SetOption('validationError', validationError);
end;

procedure TjdxCustomDropDownBox.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
  SetOption('validationErrors', validationErrors);
end;

procedure TjdxCustomDropDownBox.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
  SetOption('validationMessageMode', validationMessageMode.ToString());
end;

procedure TjdxCustomDropDownBox.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
  SetOption('validationMessagePosition', validationMessagePosition.ToString());
end;

procedure TjdxCustomDropDownBox.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
  SetOption('validationStatus', validationStatus.ToString());
end;

procedure TjdxCustomDropDownBox.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
  SetOption('value', value);
end;

procedure TjdxCustomDropDownBox.Set_valueChangeEvent(const Value: string);
begin
  FvalueChangeEvent := Value;
  SetOption('valueChangeEvent', valueChangeEvent);
end;

procedure TjdxCustomDropDownBox.Set_valueExpr(const Value: JSValue);
begin
  FvalueExpr := Value;
  SetOption('valueExpr', valueExpr);
end;

procedure TjdxCustomDropDownBox.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomDropDownBox.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomDropDownBox.Set_onChange(const Value: TdxEventHandler);
begin
  FonChange := Value;
  SetEvent('change', onChange);
end;

procedure TjdxCustomDropDownBox.Set_onClosed(const Value: TdxEventHandler);
begin
  FonClosed := Value;
  SetEvent('closed', onClosed);
end;

procedure TjdxCustomDropDownBox.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomDropDownBox.Set_onCopy(const Value: TdxEventHandler);
begin
  FonCopy := Value;
  SetEvent('copy', onCopy);
end;

procedure TjdxCustomDropDownBox.Set_onCut(const Value: TdxEventHandler);
begin
  FonCut := Value;
  SetEvent('cut', onCut);
end;

procedure TjdxCustomDropDownBox.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomDropDownBox.Set_onEnterKey(const Value: TdxEventHandler);
begin
  FonEnterKey := Value;
  SetEvent('enterKey', onEnterKey);
end;

procedure TjdxCustomDropDownBox.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomDropDownBox.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomDropDownBox.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomDropDownBox.Set_onInput(const Value: TdxEventHandler);
begin
  FonInput := Value;
  SetEvent('input', onInput);
end;

procedure TjdxCustomDropDownBox.Set_onKeyDown(const Value: TdxEventHandler);
begin
  FonKeyDown := Value;
  SetEvent('keyDown', onKeyDown);
end;

procedure TjdxCustomDropDownBox.Set_onKeyUp(const Value: TdxEventHandler);
begin
  FonKeyUp := Value;
  SetEvent('keyUp', onKeyUp);
end;

procedure TjdxCustomDropDownBox.Set_onOpened(const Value: TdxEventHandler);
begin
  FonOpened := Value;
  SetEvent('opened', onOpened);
end;

procedure TjdxCustomDropDownBox.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomDropDownBox.Set_onPaste(const Value: TdxEventHandler);
begin
  FonPaste := Value;
  SetEvent('paste', onPaste);
end;

procedure TjdxCustomDropDownBox.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
  SetEvent('valueChanged', onValueChanged);
end;

procedure TjdxCustomDropDownBox.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomDropDownBox.blur();
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  _instance.blur();
end;

procedure TjdxCustomDropDownBox.close();
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  _instance.close();
end;

function TjdxCustomDropDownBox.content(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  return _instance.content();
end;

procedure TjdxCustomDropDownBox.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomDropDownBox.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomDropDownBox.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomDropDownBox.dispose();
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  _instance.dispose();
end;

function TjdxCustomDropDownBox.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  return _instance.element();
end;

procedure TjdxCustomDropDownBox.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  _instance.endUpdate();
end;

function TjdxCustomDropDownBox.field(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  return _instance.field();
end;

procedure TjdxCustomDropDownBox.focus();
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  _instance.focus();
end;

function TjdxCustomDropDownBox.getButton(name_: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  return _instance.getButton(name_);
end;

function TjdxCustomDropDownBox.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  return _instance.getDataSource();
end;

function TjdxCustomDropDownBox.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomDropDownBox.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  return _instance.off(eventName);
end;

function TjdxCustomDropDownBox.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomDropDownBox.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  return _instance.on(events);
end;

procedure TjdxCustomDropDownBox.open();
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  _instance.open();
end;

procedure TjdxCustomDropDownBox.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomDropDownBox.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  return _instance.option();
end;

function TjdxCustomDropDownBox.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomDropDownBox.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  _instance.option(options);
end;

procedure TjdxCustomDropDownBox.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomDropDownBox.repaint();
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  _instance.repaint();
end;

procedure TjdxCustomDropDownBox.reset();
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  _instance.reset();
end;

procedure TjdxCustomDropDownBox.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxDropDownBox("instance");
  _instance.resetOption(optionName);
end;

end.
