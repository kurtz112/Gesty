unit DevExtreme.PivotGridFieldChooser.Custom;

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
  DevExtreme.PivotGridFieldChooser.JS,
  DevExtreme.Types;

type
  TjdxCustomPivotGridFieldChooser = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FallowSearch: boolean;
    FapplyChangesMode: JSValue;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FencodeHtml: boolean;
    FfocusStateEnabled: boolean;
    FheaderFilter: TJSObject;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    Flayout: TdxFieldChooserLayout;
    FrtlEnabled: boolean;
    FsearchTimeout: integer;
    Fstate: JSValue;
    FtabIndex: integer;
    Ftexts: TJSObject;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonContextMenuPreparing: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_allowSearch(const value: boolean);
    procedure Set_applyChangesMode(const value: JSValue);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_encodeHtml(const value: boolean);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_headerFilter(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_layout(const value: TdxFieldChooserLayout);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_searchTimeout(const value: integer);
    procedure Set_state(const value: JSValue);
    procedure Set_tabIndex(const value: integer);
    procedure Set_texts(const value: TJSObject);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onContextMenuPreparing(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxPivotGridFieldChooser; assembler;
    function instance: TdxPivotGridFieldChooser; assembler;
  public
    procedure applyChanges(); assembler;
    procedure beginUpdate(); assembler;
    procedure cancelChanges(); assembler;
    procedure ctor(options: JSValue); assembler; overload;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler;
    function getDataSource(): JSValue; assembler;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function option(): TJSObject; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure updateDimensions(); assembler;
  public
    property applyChangesMode: JSValue read FapplyChangesMode write Set_applyChangesMode;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property headerFilter: TJSObject read FheaderFilter write Set_headerFilter;
    property height_: JSValue read Fheight_ write Set_height_;
    property state: JSValue read Fstate write Set_state;
    property texts: TJSObject read Ftexts write Set_texts;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property allowSearch: boolean read FallowSearch write Set_allowSearch default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property encodeHtml: boolean read FencodeHtml write Set_encodeHtml default true;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property layout: TdxFieldChooserLayout read Flayout write Set_layout default fcl0;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property searchTimeout: integer read FsearchTimeout write Set_searchTimeout;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onContextMenuPreparing: TdxEventHandler read FonContextMenuPreparing write Set_onContextMenuPreparing;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
  end;

implementation


procedure TjdxCustomPivotGridFieldChooser.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FallowSearch := false;
  FapplyChangesMode := nil;
  FdataSource := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FencodeHtml := true;
  FfocusStateEnabled := false;
  FheaderFilter := TJSObject.new;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  Flayout := fcl0;
  FrtlEnabled := false;
  FsearchTimeout := 0;
  Fstate := nil;
  FtabIndex := 0;
  Ftexts := TJSObject.new;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonContextMenuPreparing := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
end;
procedure TjdxCustomPivotGridFieldChooser.InitJQuery;
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
      $(id).dxPivotGridFieldChooser(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomPivotGridFieldChooser.getInstance(element: TJSObject): TdxPivotGridFieldChooser;
asm
  return DevExpress.viz.dxPivotGridFieldChooser.getInstance(element);
end;

function TjdxCustomPivotGridFieldChooser.instance: TdxPivotGridFieldChooser;
asm
  return $(this.GetJQID()).dxPivotGridFieldChooser("instance");
end;
procedure TjdxCustomPivotGridFieldChooser.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('allowSearch', allowSearch);
    SetOption('applyChangesMode', applyChangesMode);
    SetOption('dataSource', dataSource);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('encodeHtml', encodeHtml);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('headerFilter', headerFilter);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('layout', layout.ToString());
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('searchTimeout', searchTimeout);
    SetOption('state', state);
    SetOption('tabIndex', tabIndex);
    SetOption('texts', texts);
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('contentReady', onContentReady);
    SetEvent('contextMenuPreparing', onContextMenuPreparing);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomPivotGridFieldChooser.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_allowSearch(const Value: boolean);
begin
  FallowSearch := Value;
  SetOption('allowSearch', allowSearch);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_applyChangesMode(const Value: JSValue);
begin
  FapplyChangesMode := Value;
  SetOption('applyChangesMode', applyChangesMode);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_encodeHtml(const Value: boolean);
begin
  FencodeHtml := Value;
  SetOption('encodeHtml', encodeHtml);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_headerFilter(const Value: TJSObject);
begin
  FheaderFilter := Value;
  SetOption('headerFilter', headerFilter);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_layout(const Value: TdxFieldChooserLayout);
begin
  Flayout := Value;
  SetOption('layout', layout.ToString());
end;

procedure TjdxCustomPivotGridFieldChooser.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_searchTimeout(const Value: integer);
begin
  FsearchTimeout := Value;
  SetOption('searchTimeout', searchTimeout);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_state(const Value: JSValue);
begin
  Fstate := Value;
  SetOption('state', state);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_texts(const Value: TJSObject);
begin
  Ftexts := Value;
  SetOption('texts', texts);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_onContextMenuPreparing(const Value: TdxEventHandler);
begin
  FonContextMenuPreparing := Value;
  SetEvent('contextMenuPreparing', onContextMenuPreparing);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomPivotGridFieldChooser.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomPivotGridFieldChooser.applyChanges();
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  _instance.applyChanges();
end;

procedure TjdxCustomPivotGridFieldChooser.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomPivotGridFieldChooser.cancelChanges();
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  _instance.cancelChanges();
end;

procedure TjdxCustomPivotGridFieldChooser.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomPivotGridFieldChooser.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomPivotGridFieldChooser.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomPivotGridFieldChooser.dispose();
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  _instance.dispose();
end;

function TjdxCustomPivotGridFieldChooser.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  return _instance.element();
end;

procedure TjdxCustomPivotGridFieldChooser.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomPivotGridFieldChooser.focus();
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  _instance.focus();
end;

function TjdxCustomPivotGridFieldChooser.getDataSource(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  return _instance.getDataSource();
end;

function TjdxCustomPivotGridFieldChooser.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  return _instance.off(eventName);
end;

function TjdxCustomPivotGridFieldChooser.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomPivotGridFieldChooser.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomPivotGridFieldChooser.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  return _instance.on(events);
end;

function TjdxCustomPivotGridFieldChooser.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  return _instance.option();
end;

function TjdxCustomPivotGridFieldChooser.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomPivotGridFieldChooser.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  _instance.option(options);
end;

procedure TjdxCustomPivotGridFieldChooser.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomPivotGridFieldChooser.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomPivotGridFieldChooser.repaint();
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  _instance.repaint();
end;

procedure TjdxCustomPivotGridFieldChooser.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomPivotGridFieldChooser.updateDimensions();
asm
  const _instance = $(this.GetJQID()).dxPivotGridFieldChooser("instance");
  _instance.updateDimensions();
end;

end.
