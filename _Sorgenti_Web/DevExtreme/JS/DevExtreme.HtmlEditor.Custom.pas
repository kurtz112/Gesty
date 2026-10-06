unit DevExtreme.HtmlEditor.Custom;

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
  DevExtreme.HtmlEditor.JS,
  DevExtreme.Types;

type
  TjdxCustomHtmlEditor = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FallowSoftLineBreak: boolean;
    FcustomizeModules: TJSFunction;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FimageUpload: TJSObject;
    FisValid: boolean;
    FmediaResizing: TJSObject;
    Fmentions: TJSArray;
    Fname_: string;
    Fplaceholder: string;
    FreadOnly: boolean;
    FrtlEnabled: boolean;
    FstylingMode: TdxEditorStyle;
    FtabIndex: integer;
    FtableContextMenu: JSValue;
    FtableResizing: JSValue;
    Ftoolbar: TJSObject;
    FvalidationError: JSValue;
    FvalidationErrors: TJSArray;
    FvalidationMessageMode: TdxValidationMessageMode;
    FvalidationMessagePosition: TdxPosition;
    FvalidationStatus: TdxValidationStatus;
    Fvalue: JSValue;
    FvalueType: TdxMarkupType;
    Fvariables: TJSObject;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonValueChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_allowSoftLineBreak(const value: boolean);
    procedure Set_customizeModules(const value: TJSFunction);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_imageUpload(const value: TJSObject);
    procedure Set_isValid(const value: boolean);
    procedure Set_mediaResizing(const value: TJSObject);
    procedure Set_mentions(const value: TJSArray);
    procedure Set_name_(const value: string);
    procedure Set_placeholder(const value: string);
    procedure Set_readOnly(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_stylingMode(const value: TdxEditorStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_tableContextMenu(const value: JSValue);
    procedure Set_tableResizing(const value: JSValue);
    procedure Set_toolbar(const value: TJSObject);
    procedure Set_validationError(const value: JSValue);
    procedure Set_validationErrors(const value: TJSArray);
    procedure Set_validationMessageMode(const value: TdxValidationMessageMode);
    procedure Set_validationMessagePosition(const value: TdxPosition);
    procedure Set_validationStatus(const value: TdxValidationStatus);
    procedure Set_value(const value: JSValue);
    procedure Set_valueType(const value: TdxMarkupType);
    procedure Set_variables(const value: TJSObject);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onValueChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxHtmlEditor; assembler;
    function instance: TdxHtmlEditor; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure blur(); assembler;
    procedure clearHistory(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure delete(index: integer; length: integer); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler; overload;
    procedure format(formatName: JSValue; formatValue: JSValue); assembler;
    procedure formatLine(index: integer; length: integer; formats: TJSObject); assembler; overload;
    procedure formatLine(index: integer; length: integer; formatName: JSValue; formatValue: JSValue); assembler; overload;
    procedure formatText(index: integer; length: integer; formats: TJSObject); assembler; overload;
    procedure formatText(index: integer; length: integer; formatName: JSValue; formatValue: JSValue); assembler; overload;
    function get(componentPath: string): TJSObject; assembler;
    function getBounds(index: integer; length: integer): TJSObject; assembler;
    function getFormat(): TJSObject; assembler; overload;
    function getFormat(index: integer; length: integer): TJSObject; assembler; overload;
    function getLength(): integer; assembler;
    function getModule(moduleName: string): TJSObject; assembler;
    function getQuillInstance(): TJSObject; assembler;
    function getSelection(focus: JSValue): TJSObject; assembler;
    function getText(index: integer; length: integer): string; assembler;
    procedure insertEmbed(index: integer; type_: string; config: JSValue); assembler;
    procedure insertText(index: integer; text: string; formats: TJSObject); assembler; overload;
    procedure insertText(index: integer; text: string; formatName: JSValue; formatValue: JSValue); assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure redo(); assembler;
    procedure register(modules: TJSObject); assembler;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure removeFormat(index: integer; length: integer); assembler;
    procedure repaint(); assembler;
    procedure reset(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure setSelection(index: integer; length: integer); assembler;
    procedure undo(); assembler;
  public
    property customizeModules: TJSFunction read FcustomizeModules write Set_customizeModules;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property imageUpload: TJSObject read FimageUpload write Set_imageUpload;
    property mediaResizing: TJSObject read FmediaResizing write Set_mediaResizing;
    property mentions: TJSArray read Fmentions write Set_mentions;
    property tableContextMenu: JSValue read FtableContextMenu write Set_tableContextMenu;
    property tableResizing: JSValue read FtableResizing write Set_tableResizing;
    property toolbar: TJSObject read Ftoolbar write Set_toolbar;
    property validationError: JSValue read FvalidationError write Set_validationError;
    property validationErrors: TJSArray read FvalidationErrors write Set_validationErrors;
    property value: JSValue read Fvalue write Set_value;
    property variables: TJSObject read Fvariables write Set_variables;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property allowSoftLineBreak: boolean read FallowSoftLineBreak write Set_allowSoftLineBreak default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property isValid: boolean read FisValid write Set_isValid default true;
    property name_: string read Fname_ write Set_name_;
    property placeholder: string read Fplaceholder write Set_placeholder;
    property readOnly: boolean read FreadOnly write Set_readOnly default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property stylingMode: TdxEditorStyle read FstylingMode write Set_stylingMode default esOutlined;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property validationMessageMode: TdxValidationMessageMode read FvalidationMessageMode write Set_validationMessageMode default vmmAuto;
    property validationMessagePosition: TdxPosition read FvalidationMessagePosition write Set_validationMessagePosition default pBottom;
    property validationStatus: TdxValidationStatus read FvalidationStatus write Set_validationStatus default vsValid;
    property valueType: TdxMarkupType read FvalueType write Set_valueType default mtHtml;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onValueChanged: TdxEventHandler read FonValueChanged write Set_onValueChanged;
  end;

implementation


procedure TjdxCustomHtmlEditor.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FallowSoftLineBreak := false;
  FcustomizeModules := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FimageUpload := TJSObject.new;
  FisValid := true;
  FmediaResizing := TJSObject.new;
  Fmentions := TJSArray.new;
  Fname_ := '';
  Fplaceholder := '';
  FreadOnly := false;
  FrtlEnabled := false;
  FstylingMode := esOutlined;
  FtabIndex := 0;
  FtableContextMenu := nil;
  FtableResizing := nil;
  Ftoolbar := TJSObject.new;
  FvalidationError := nil;
  FvalidationErrors := TJSArray.new;
  FvalidationMessageMode := vmmAuto;
  FvalidationMessagePosition := pBottom;
  FvalidationStatus := vsValid;
  Fvalue := nil;
  FvalueType := mtHtml;
  Fvariables := TJSObject.new;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonValueChanged := nil;
end;
procedure TjdxCustomHtmlEditor.InitJQuery;
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
      $(id).dxHtmlEditor(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomHtmlEditor.getInstance(element: TJSObject): TdxHtmlEditor;
asm
  return DevExpress.viz.dxHtmlEditor.getInstance(element);
end;

function TjdxCustomHtmlEditor.instance: TdxHtmlEditor;
asm
  return $(this.GetJQID()).dxHtmlEditor("instance");
end;
procedure TjdxCustomHtmlEditor.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('allowSoftLineBreak', allowSoftLineBreak);
    SetOption('customizeModules', customizeModules);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('imageUpload', imageUpload);
    SetOption('isValid', isValid);
    SetOption('mediaResizing', mediaResizing);
    SetOption('mentions', mentions);
    SetOption('name', name_);
    SetOption('placeholder', placeholder);
    SetOption('readOnly', readOnly);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('stylingMode', stylingMode.ToString());
    SetOption('tabIndex', tabIndex);
    SetOption('tableContextMenu', tableContextMenu);
    SetOption('tableResizing', tableResizing);
    SetOption('toolbar', toolbar);
    SetOption('validationError', validationError);
    SetOption('validationErrors', validationErrors);
    SetOption('validationMessageMode', validationMessageMode.ToString());
    SetOption('validationMessagePosition', validationMessagePosition.ToString());
    SetOption('validationStatus', validationStatus.ToString());
    SetOption('value', value);
    SetOption('valueType', valueType.ToString());
    SetOption('variables', variables);
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('valueChanged', onValueChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomHtmlEditor.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomHtmlEditor.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomHtmlEditor.Set_allowSoftLineBreak(const Value: boolean);
begin
  FallowSoftLineBreak := Value;
  SetOption('allowSoftLineBreak', allowSoftLineBreak);
end;

procedure TjdxCustomHtmlEditor.Set_customizeModules(const Value: TJSFunction);
begin
  FcustomizeModules := Value;
  SetOption('customizeModules', customizeModules);
end;

procedure TjdxCustomHtmlEditor.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomHtmlEditor.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomHtmlEditor.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomHtmlEditor.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomHtmlEditor.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomHtmlEditor.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomHtmlEditor.Set_imageUpload(const Value: TJSObject);
begin
  FimageUpload := Value;
  SetOption('imageUpload', imageUpload);
end;

procedure TjdxCustomHtmlEditor.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
  SetOption('isValid', isValid);
end;

procedure TjdxCustomHtmlEditor.Set_mediaResizing(const Value: TJSObject);
begin
  FmediaResizing := Value;
  SetOption('mediaResizing', mediaResizing);
end;

procedure TjdxCustomHtmlEditor.Set_mentions(const Value: TJSArray);
begin
  Fmentions := Value;
  SetOption('mentions', mentions);
end;

procedure TjdxCustomHtmlEditor.Set_name_(const Value: string);
begin
  Fname_ := Value;
  SetOption('name', name_);
end;

procedure TjdxCustomHtmlEditor.Set_placeholder(const Value: string);
begin
  Fplaceholder := Value;
  SetOption('placeholder', placeholder);
end;

procedure TjdxCustomHtmlEditor.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
  SetOption('readOnly', readOnly);
end;

procedure TjdxCustomHtmlEditor.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomHtmlEditor.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
  SetOption('stylingMode', stylingMode.ToString());
end;

procedure TjdxCustomHtmlEditor.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomHtmlEditor.Set_tableContextMenu(const Value: JSValue);
begin
  FtableContextMenu := Value;
  SetOption('tableContextMenu', tableContextMenu);
end;

procedure TjdxCustomHtmlEditor.Set_tableResizing(const Value: JSValue);
begin
  FtableResizing := Value;
  SetOption('tableResizing', tableResizing);
end;

procedure TjdxCustomHtmlEditor.Set_toolbar(const Value: TJSObject);
begin
  Ftoolbar := Value;
  SetOption('toolbar', toolbar);
end;

procedure TjdxCustomHtmlEditor.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
  SetOption('validationError', validationError);
end;

procedure TjdxCustomHtmlEditor.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
  SetOption('validationErrors', validationErrors);
end;

procedure TjdxCustomHtmlEditor.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
  SetOption('validationMessageMode', validationMessageMode.ToString());
end;

procedure TjdxCustomHtmlEditor.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
  SetOption('validationMessagePosition', validationMessagePosition.ToString());
end;

procedure TjdxCustomHtmlEditor.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
  SetOption('validationStatus', validationStatus.ToString());
end;

procedure TjdxCustomHtmlEditor.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
  SetOption('value', value);
end;

procedure TjdxCustomHtmlEditor.Set_valueType(const Value: TdxMarkupType);
begin
  FvalueType := Value;
  SetOption('valueType', valueType.ToString());
end;

procedure TjdxCustomHtmlEditor.Set_variables(const Value: TJSObject);
begin
  Fvariables := Value;
  SetOption('variables', variables);
end;

procedure TjdxCustomHtmlEditor.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomHtmlEditor.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomHtmlEditor.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomHtmlEditor.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomHtmlEditor.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomHtmlEditor.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomHtmlEditor.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomHtmlEditor.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomHtmlEditor.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
  SetEvent('valueChanged', onValueChanged);
end;

procedure TjdxCustomHtmlEditor.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomHtmlEditor.blur();
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.blur();
end;

procedure TjdxCustomHtmlEditor.clearHistory();
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.clearHistory();
end;

procedure TjdxCustomHtmlEditor.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomHtmlEditor.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomHtmlEditor.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomHtmlEditor.delete(index: integer; length: integer);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.delete(index, length);
end;

procedure TjdxCustomHtmlEditor.dispose();
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.dispose();
end;

function TjdxCustomHtmlEditor.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  return _instance.element();
end;

procedure TjdxCustomHtmlEditor.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomHtmlEditor.focus();
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.focus();
end;

procedure TjdxCustomHtmlEditor.format(formatName: JSValue; formatValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.format(formatName, formatValue);
end;

procedure TjdxCustomHtmlEditor.formatLine(index: integer; length: integer; formats: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.formatLine(index, length, formats);
end;

procedure TjdxCustomHtmlEditor.formatLine(index: integer; length: integer; formatName: JSValue; formatValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.formatLine(index, length, formatName, formatValue);
end;

procedure TjdxCustomHtmlEditor.formatText(index: integer; length: integer; formats: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.formatText(index, length, formats);
end;

procedure TjdxCustomHtmlEditor.formatText(index: integer; length: integer; formatName: JSValue; formatValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.formatText(index, length, formatName, formatValue);
end;

function TjdxCustomHtmlEditor.get(componentPath: string): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  return _instance.get(componentPath);
end;

function TjdxCustomHtmlEditor.getBounds(index: integer; length: integer): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  return _instance.getBounds(index, length);
end;

function TjdxCustomHtmlEditor.getFormat(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  return _instance.getFormat();
end;

function TjdxCustomHtmlEditor.getFormat(index: integer; length: integer): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  return _instance.getFormat(index, length);
end;

function TjdxCustomHtmlEditor.getLength(): integer;
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  return _instance.getLength();
end;

function TjdxCustomHtmlEditor.getModule(moduleName: string): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  return _instance.getModule(moduleName);
end;

function TjdxCustomHtmlEditor.getQuillInstance(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  return _instance.getQuillInstance();
end;

function TjdxCustomHtmlEditor.getSelection(focus: JSValue): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  return _instance.getSelection(focus);
end;

function TjdxCustomHtmlEditor.getText(index: integer; length: integer): string;
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  return _instance.getText(index, length);
end;

procedure TjdxCustomHtmlEditor.insertEmbed(index: integer; type_: string; config: JSValue);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.insertEmbed(index, type_, config);
end;

procedure TjdxCustomHtmlEditor.insertText(index: integer; text: string; formats: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.insertText(index, text, formats);
end;

procedure TjdxCustomHtmlEditor.insertText(index: integer; text: string; formatName: JSValue; formatValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.insertText(index, text, formatName, formatValue);
end;

function TjdxCustomHtmlEditor.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomHtmlEditor.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  return _instance.off(eventName);
end;

function TjdxCustomHtmlEditor.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  return _instance.on(events);
end;

function TjdxCustomHtmlEditor.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomHtmlEditor.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomHtmlEditor.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomHtmlEditor.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.option(options);
end;

function TjdxCustomHtmlEditor.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  return _instance.option();
end;

procedure TjdxCustomHtmlEditor.redo();
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.redo();
end;

procedure TjdxCustomHtmlEditor.register(modules: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.register(modules);
end;

procedure TjdxCustomHtmlEditor.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomHtmlEditor.removeFormat(index: integer; length: integer);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.removeFormat(index, length);
end;

procedure TjdxCustomHtmlEditor.repaint();
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.repaint();
end;

procedure TjdxCustomHtmlEditor.reset();
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.reset();
end;

procedure TjdxCustomHtmlEditor.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomHtmlEditor.setSelection(index: integer; length: integer);
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.setSelection(index, length);
end;

procedure TjdxCustomHtmlEditor.undo();
asm
  const _instance = $(this.GetJQID()).dxHtmlEditor("instance");
  _instance.undo();
end;

end.
