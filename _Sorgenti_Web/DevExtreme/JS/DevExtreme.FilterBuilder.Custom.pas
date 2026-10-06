unit DevExtreme.FilterBuilder.Custom;

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
  DevExtreme.FilterBuilder.JS,
  DevExtreme.Types;

type
  TjdxCustomFilterBuilder = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FallowHierarchicalFields: boolean;
    FcustomOperations: TJSArray;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Ffields: TJSArray;
    FfilterOperationDescriptions: TJSObject;
    FfocusStateEnabled: boolean;
    FgroupOperationDescriptions: TJSObject;
    FgroupOperations: TJSArray;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FmaxGroupLevel: integer;
    FrtlEnabled: boolean;
    FtabIndex: integer;
    Fvalue: JSValue;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonEditorPrepared: TdxEventHandler;
    FonEditorPreparing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonValueChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_allowHierarchicalFields(const value: boolean);
    procedure Set_customOperations(const value: TJSArray);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_fields(const value: TJSArray);
    procedure Set_filterOperationDescriptions(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_groupOperationDescriptions(const value: TJSObject);
    procedure Set_groupOperations(const value: TJSArray);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_maxGroupLevel(const value: integer);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_value(const value: JSValue);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onEditorPrepared(const value: TdxEventHandler);
    procedure Set_onEditorPreparing(const value: TdxEventHandler);
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
    function getInstance(element: TJSObject): TdxFilterBuilder; assembler;
    function instance: TdxFilterBuilder; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler;
    function getFilterExpression(): JSValue; assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
  public
    property customOperations: TJSArray read FcustomOperations write Set_customOperations;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property fields: TJSArray read Ffields write Set_fields;
    property filterOperationDescriptions: TJSObject read FfilterOperationDescriptions write Set_filterOperationDescriptions;
    property groupOperationDescriptions: TJSObject read FgroupOperationDescriptions write Set_groupOperationDescriptions;
    property groupOperations: TJSArray read FgroupOperations write Set_groupOperations;
    property height_: JSValue read Fheight_ write Set_height_;
    property value: JSValue read Fvalue write Set_value;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property allowHierarchicalFields: boolean read FallowHierarchicalFields write Set_allowHierarchicalFields default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property maxGroupLevel: integer read FmaxGroupLevel write Set_maxGroupLevel;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onEditorPrepared: TdxEventHandler read FonEditorPrepared write Set_onEditorPrepared;
    property onEditorPreparing: TdxEventHandler read FonEditorPreparing write Set_onEditorPreparing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onValueChanged: TdxEventHandler read FonValueChanged write Set_onValueChanged;
  end;

implementation


procedure TjdxCustomFilterBuilder.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FallowHierarchicalFields := false;
  FcustomOperations := TJSArray.new;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Ffields := TJSArray.new;
  FfilterOperationDescriptions := TJSObject.new;
  FfocusStateEnabled := false;
  FgroupOperationDescriptions := TJSObject.new;
  FgroupOperations := TJSArray.new;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FmaxGroupLevel := 0;
  FrtlEnabled := false;
  FtabIndex := 0;
  Fvalue := nil;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonEditorPrepared := nil;
  FonEditorPreparing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonValueChanged := nil;
end;
procedure TjdxCustomFilterBuilder.InitJQuery;
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
      $(id).dxFilterBuilder(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomFilterBuilder.getInstance(element: TJSObject): TdxFilterBuilder;
asm
  return DevExpress.viz.dxFilterBuilder.getInstance(element);
end;

function TjdxCustomFilterBuilder.instance: TdxFilterBuilder;
asm
  return $(this.GetJQID()).dxFilterBuilder("instance");
end;
procedure TjdxCustomFilterBuilder.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('allowHierarchicalFields', allowHierarchicalFields);
    SetOption('customOperations', customOperations);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('fields', fields);
    SetOption('filterOperationDescriptions', filterOperationDescriptions);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('groupOperationDescriptions', groupOperationDescriptions);
    SetOption('groupOperations', groupOperations);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('maxGroupLevel', maxGroupLevel);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('tabIndex', tabIndex);
    SetOption('value', value);
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('editorPrepared', onEditorPrepared);
    SetEvent('editorPreparing', onEditorPreparing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('valueChanged', onValueChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomFilterBuilder.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomFilterBuilder.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomFilterBuilder.Set_allowHierarchicalFields(const Value: boolean);
begin
  FallowHierarchicalFields := Value;
  SetOption('allowHierarchicalFields', allowHierarchicalFields);
end;

procedure TjdxCustomFilterBuilder.Set_customOperations(const Value: TJSArray);
begin
  FcustomOperations := Value;
  SetOption('customOperations', customOperations);
end;

procedure TjdxCustomFilterBuilder.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomFilterBuilder.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomFilterBuilder.Set_fields(const Value: TJSArray);
begin
  Ffields := Value;
  SetOption('fields', fields);
end;

procedure TjdxCustomFilterBuilder.Set_filterOperationDescriptions(const Value: TJSObject);
begin
  FfilterOperationDescriptions := Value;
  SetOption('filterOperationDescriptions', filterOperationDescriptions);
end;

procedure TjdxCustomFilterBuilder.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomFilterBuilder.Set_groupOperationDescriptions(const Value: TJSObject);
begin
  FgroupOperationDescriptions := Value;
  SetOption('groupOperationDescriptions', groupOperationDescriptions);
end;

procedure TjdxCustomFilterBuilder.Set_groupOperations(const Value: TJSArray);
begin
  FgroupOperations := Value;
  SetOption('groupOperations', groupOperations);
end;

procedure TjdxCustomFilterBuilder.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomFilterBuilder.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomFilterBuilder.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomFilterBuilder.Set_maxGroupLevel(const Value: integer);
begin
  FmaxGroupLevel := Value;
  SetOption('maxGroupLevel', maxGroupLevel);
end;

procedure TjdxCustomFilterBuilder.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomFilterBuilder.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomFilterBuilder.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
  SetOption('value', value);
end;

procedure TjdxCustomFilterBuilder.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomFilterBuilder.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomFilterBuilder.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomFilterBuilder.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomFilterBuilder.Set_onEditorPrepared(const Value: TdxEventHandler);
begin
  FonEditorPrepared := Value;
  SetEvent('editorPrepared', onEditorPrepared);
end;

procedure TjdxCustomFilterBuilder.Set_onEditorPreparing(const Value: TdxEventHandler);
begin
  FonEditorPreparing := Value;
  SetEvent('editorPreparing', onEditorPreparing);
end;

procedure TjdxCustomFilterBuilder.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomFilterBuilder.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomFilterBuilder.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomFilterBuilder.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomFilterBuilder.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
  SetEvent('valueChanged', onValueChanged);
end;

procedure TjdxCustomFilterBuilder.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomFilterBuilder.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomFilterBuilder.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomFilterBuilder.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomFilterBuilder.dispose();
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  _instance.dispose();
end;

function TjdxCustomFilterBuilder.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  return _instance.element();
end;

procedure TjdxCustomFilterBuilder.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomFilterBuilder.focus();
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  _instance.focus();
end;

function TjdxCustomFilterBuilder.getFilterExpression(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  return _instance.getFilterExpression();
end;

function TjdxCustomFilterBuilder.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomFilterBuilder.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  return _instance.off(eventName);
end;

function TjdxCustomFilterBuilder.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomFilterBuilder.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  return _instance.on(events);
end;

function TjdxCustomFilterBuilder.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  return _instance.option(optionName);
end;

function TjdxCustomFilterBuilder.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  return _instance.option();
end;

procedure TjdxCustomFilterBuilder.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomFilterBuilder.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  _instance.option(options);
end;

procedure TjdxCustomFilterBuilder.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomFilterBuilder.repaint();
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  _instance.repaint();
end;

procedure TjdxCustomFilterBuilder.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxFilterBuilder("instance");
  _instance.resetOption(optionName);
end;

end.
