unit DevExtreme.Form.Custom;

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
  DevExtreme.Form.JS,
  DevExtreme.Types;

type
  TjdxCustomForm = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FalignItemLabels: boolean;
    FalignItemLabelsInAllGroups: boolean;
    FcolCount: JSValue;
    FcolCountByScreen: TJSObject;
    FcustomizeItem: TJSFunction;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    FformData: JSValue;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    Fitems: TJSArray;
    FlabelLocation: TdxLabelLocation;
    FlabelMode: TdxFormLabelMode;
    FminColWidth: integer;
    FoptionalMark: string;
    FreadOnly: boolean;
    FrequiredMark: string;
    FrequiredMessage: string;
    FrtlEnabled: boolean;
    FscreenByWidth: TJSFunction;
    FscrollingEnabled: boolean;
    FshowColonAfterLabel: boolean;
    FshowOptionalMark: boolean;
    FshowRequiredMark: boolean;
    FshowValidationSummary: boolean;
    FtabIndex: integer;
    FvalidationGroup: string;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonEditorEnterKey: TdxEventHandler;
    FonFieldDataChanged: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_alignItemLabels(const value: boolean);
    procedure Set_alignItemLabelsInAllGroups(const value: boolean);
    procedure Set_colCount(const value: JSValue);
    procedure Set_colCountByScreen(const value: TJSObject);
    procedure Set_customizeItem(const value: TJSFunction);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_formData(const value: JSValue);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_items(const value: TJSArray);
    procedure Set_labelLocation(const value: TdxLabelLocation);
    procedure Set_labelMode(const value: TdxFormLabelMode);
    procedure Set_minColWidth(const value: integer);
    procedure Set_optionalMark(const value: string);
    procedure Set_readOnly(const value: boolean);
    procedure Set_requiredMark(const value: string);
    procedure Set_requiredMessage(const value: string);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_screenByWidth(const value: TJSFunction);
    procedure Set_scrollingEnabled(const value: boolean);
    procedure Set_showColonAfterLabel(const value: boolean);
    procedure Set_showOptionalMark(const value: boolean);
    procedure Set_showRequiredMark(const value: boolean);
    procedure Set_showValidationSummary(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_validationGroup(const value: string);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onEditorEnterKey(const value: TdxEventHandler);
    procedure Set_onFieldDataChanged(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxForm; assembler;
    function instance: TdxForm; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler;
    function getButton(name_: string): JSValue; assembler;
    function getEditor(dataField: string): JSValue; assembler;
    procedure itemOption(id: string; options: TJSObject); assembler; overload;
    procedure itemOption(id: string; option: string; value: JSValue); assembler; overload;
    function itemOption(id: string): JSValue; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure resetValues(); assembler;
    procedure updateData(dataField: string; value: TJSObject); assembler; overload;
    procedure updateData(data: TJSObject); assembler; overload;
    function updateDimensions(): TJSPromise; assembler;
    function validate(): JSValue; assembler;
  public
    property colCount: JSValue read FcolCount write Set_colCount;
    property colCountByScreen: TJSObject read FcolCountByScreen write Set_colCountByScreen;
    property customizeItem: TJSFunction read FcustomizeItem write Set_customizeItem;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property formData: JSValue read FformData write Set_formData;
    property height_: JSValue read Fheight_ write Set_height_;
    property items: TJSArray read Fitems write Set_items;
    property screenByWidth: TJSFunction read FscreenByWidth write Set_screenByWidth;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property alignItemLabels: boolean read FalignItemLabels write Set_alignItemLabels default true;
    property alignItemLabelsInAllGroups: boolean read FalignItemLabelsInAllGroups write Set_alignItemLabelsInAllGroups default true;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property labelLocation: TdxLabelLocation read FlabelLocation write Set_labelLocation default llLeft;
    property labelMode: TdxFormLabelMode read FlabelMode write Set_labelMode default flmOutside;
    property minColWidth: integer read FminColWidth write Set_minColWidth;
    property optionalMark: string read FoptionalMark write Set_optionalMark;
    property readOnly: boolean read FreadOnly write Set_readOnly default false;
    property requiredMark: string read FrequiredMark write Set_requiredMark;
    property requiredMessage: string read FrequiredMessage write Set_requiredMessage;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property scrollingEnabled: boolean read FscrollingEnabled write Set_scrollingEnabled default false;
    property showColonAfterLabel: boolean read FshowColonAfterLabel write Set_showColonAfterLabel;
    property showOptionalMark: boolean read FshowOptionalMark write Set_showOptionalMark default false;
    property showRequiredMark: boolean read FshowRequiredMark write Set_showRequiredMark default true;
    property showValidationSummary: boolean read FshowValidationSummary write Set_showValidationSummary default false;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property validationGroup: string read FvalidationGroup write Set_validationGroup;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onEditorEnterKey: TdxEventHandler read FonEditorEnterKey write Set_onEditorEnterKey;
    property onFieldDataChanged: TdxEventHandler read FonFieldDataChanged write Set_onFieldDataChanged;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
  end;

implementation


procedure TjdxCustomForm.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FalignItemLabels := true;
  FalignItemLabelsInAllGroups := true;
  FcolCount := nil;
  FcolCountByScreen := TJSObject.new;
  FcustomizeItem := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  FformData := nil;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  Fitems := TJSArray.new;
  FlabelLocation := llLeft;
  FlabelMode := flmOutside;
  FminColWidth := 0;
  FoptionalMark := '';
  FreadOnly := false;
  FrequiredMark := '';
  FrequiredMessage := '';
  FrtlEnabled := false;
  FscreenByWidth := nil;
  FscrollingEnabled := false;
  FshowColonAfterLabel := false;
  FshowOptionalMark := false;
  FshowRequiredMark := true;
  FshowValidationSummary := false;
  FtabIndex := 0;
  FvalidationGroup := '';
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonEditorEnterKey := nil;
  FonFieldDataChanged := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
end;
procedure TjdxCustomForm.InitJQuery;
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
      $(id).dxForm(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomForm.getInstance(element: TJSObject): TdxForm;
asm
  return DevExpress.viz.dxForm.getInstance(element);
end;

function TjdxCustomForm.instance: TdxForm;
asm
  return $(this.GetJQID()).dxForm("instance");
end;
procedure TjdxCustomForm.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('alignItemLabels', alignItemLabels);
    SetOption('alignItemLabelsInAllGroups', alignItemLabelsInAllGroups);
    SetOption('colCount', colCount);
    SetOption('colCountByScreen', colCountByScreen);
    SetOption('customizeItem', customizeItem);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('formData', formData);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('items', items);
    SetOption('labelLocation', labelLocation.ToString());
    SetOption('labelMode', labelMode.ToString());
    SetOption('minColWidth', minColWidth);
    SetOption('optionalMark', optionalMark);
    SetOption('readOnly', readOnly);
    SetOption('requiredMark', requiredMark);
    SetOption('requiredMessage', requiredMessage);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('screenByWidth', screenByWidth);
    SetOption('scrollingEnabled', scrollingEnabled);
    SetOption('showColonAfterLabel', showColonAfterLabel);
    SetOption('showOptionalMark', showOptionalMark);
    SetOption('showRequiredMark', showRequiredMark);
    SetOption('showValidationSummary', showValidationSummary);
    SetOption('tabIndex', tabIndex);
    SetOption('validationGroup', validationGroup);
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('editorEnterKey', onEditorEnterKey);
    SetEvent('fieldDataChanged', onFieldDataChanged);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomForm.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomForm.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomForm.Set_alignItemLabels(const Value: boolean);
begin
  FalignItemLabels := Value;
  SetOption('alignItemLabels', alignItemLabels);
end;

procedure TjdxCustomForm.Set_alignItemLabelsInAllGroups(const Value: boolean);
begin
  FalignItemLabelsInAllGroups := Value;
  SetOption('alignItemLabelsInAllGroups', alignItemLabelsInAllGroups);
end;

procedure TjdxCustomForm.Set_colCount(const Value: JSValue);
begin
  FcolCount := Value;
  SetOption('colCount', colCount);
end;

procedure TjdxCustomForm.Set_colCountByScreen(const Value: TJSObject);
begin
  FcolCountByScreen := Value;
  SetOption('colCountByScreen', colCountByScreen);
end;

procedure TjdxCustomForm.Set_customizeItem(const Value: TJSFunction);
begin
  FcustomizeItem := Value;
  SetOption('customizeItem', customizeItem);
end;

procedure TjdxCustomForm.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomForm.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomForm.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomForm.Set_formData(const Value: JSValue);
begin
  FformData := Value;
  SetOption('formData', formData);
end;

procedure TjdxCustomForm.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomForm.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomForm.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomForm.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
  SetOption('items', items);
end;

procedure TjdxCustomForm.Set_labelLocation(const Value: TdxLabelLocation);
begin
  FlabelLocation := Value;
  SetOption('labelLocation', labelLocation.ToString());
end;

procedure TjdxCustomForm.Set_labelMode(const Value: TdxFormLabelMode);
begin
  FlabelMode := Value;
  SetOption('labelMode', labelMode.ToString());
end;

procedure TjdxCustomForm.Set_minColWidth(const Value: integer);
begin
  FminColWidth := Value;
  SetOption('minColWidth', minColWidth);
end;

procedure TjdxCustomForm.Set_optionalMark(const Value: string);
begin
  FoptionalMark := Value;
  SetOption('optionalMark', optionalMark);
end;

procedure TjdxCustomForm.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
  SetOption('readOnly', readOnly);
end;

procedure TjdxCustomForm.Set_requiredMark(const Value: string);
begin
  FrequiredMark := Value;
  SetOption('requiredMark', requiredMark);
end;

procedure TjdxCustomForm.Set_requiredMessage(const Value: string);
begin
  FrequiredMessage := Value;
  SetOption('requiredMessage', requiredMessage);
end;

procedure TjdxCustomForm.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomForm.Set_screenByWidth(const Value: TJSFunction);
begin
  FscreenByWidth := Value;
  SetOption('screenByWidth', screenByWidth);
end;

procedure TjdxCustomForm.Set_scrollingEnabled(const Value: boolean);
begin
  FscrollingEnabled := Value;
  SetOption('scrollingEnabled', scrollingEnabled);
end;

procedure TjdxCustomForm.Set_showColonAfterLabel(const Value: boolean);
begin
  FshowColonAfterLabel := Value;
  SetOption('showColonAfterLabel', showColonAfterLabel);
end;

procedure TjdxCustomForm.Set_showOptionalMark(const Value: boolean);
begin
  FshowOptionalMark := Value;
  SetOption('showOptionalMark', showOptionalMark);
end;

procedure TjdxCustomForm.Set_showRequiredMark(const Value: boolean);
begin
  FshowRequiredMark := Value;
  SetOption('showRequiredMark', showRequiredMark);
end;

procedure TjdxCustomForm.Set_showValidationSummary(const Value: boolean);
begin
  FshowValidationSummary := Value;
  SetOption('showValidationSummary', showValidationSummary);
end;

procedure TjdxCustomForm.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomForm.Set_validationGroup(const Value: string);
begin
  FvalidationGroup := Value;
  SetOption('validationGroup', validationGroup);
end;

procedure TjdxCustomForm.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomForm.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomForm.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomForm.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomForm.Set_onEditorEnterKey(const Value: TdxEventHandler);
begin
  FonEditorEnterKey := Value;
  SetEvent('editorEnterKey', onEditorEnterKey);
end;

procedure TjdxCustomForm.Set_onFieldDataChanged(const Value: TdxEventHandler);
begin
  FonFieldDataChanged := Value;
  SetEvent('fieldDataChanged', onFieldDataChanged);
end;

procedure TjdxCustomForm.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomForm.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomForm.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomForm.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomForm.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomForm.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomForm.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomForm.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomForm.dispose();
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.dispose();
end;

function TjdxCustomForm.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  return _instance.element();
end;

procedure TjdxCustomForm.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomForm.focus();
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.focus();
end;

function TjdxCustomForm.getButton(name_: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  return _instance.getButton(name_);
end;

function TjdxCustomForm.getEditor(dataField: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  return _instance.getEditor(dataField);
end;

procedure TjdxCustomForm.itemOption(id: string; options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.itemOption(id, options);
end;

procedure TjdxCustomForm.itemOption(id: string; option: string; value: JSValue);
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.itemOption(id, option, value);
end;

function TjdxCustomForm.itemOption(id: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  return _instance.itemOption(id);
end;

function TjdxCustomForm.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  return _instance.off(eventName);
end;

function TjdxCustomForm.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomForm.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomForm.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  return _instance.on(events);
end;

procedure TjdxCustomForm.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomForm.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomForm.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.option(options);
end;

function TjdxCustomForm.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  return _instance.option();
end;

procedure TjdxCustomForm.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomForm.repaint();
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.repaint();
end;

procedure TjdxCustomForm.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomForm.resetValues();
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.resetValues();
end;

procedure TjdxCustomForm.updateData(dataField: string; value: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.updateData(dataField, value);
end;

procedure TjdxCustomForm.updateData(data: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  _instance.updateData(data);
end;

function TjdxCustomForm.updateDimensions(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  return _instance.updateDimensions();
end;

function TjdxCustomForm.validate(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxForm("instance");
  return _instance.validate();
end;

end.
