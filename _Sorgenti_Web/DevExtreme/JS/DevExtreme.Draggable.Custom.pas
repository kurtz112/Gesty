unit DevExtreme.Draggable.Custom;

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
  DevExtreme.Draggable.JS,
  DevExtreme.Types;

type
  TjdxCustomDraggable = class(TjdxCustomControl)
  private
    FautoScroll: boolean;
    Fboundary: JSValue;
    Fclone: boolean;
    Fcontainer: JSValue;
    FcontentTemplate: JSValue;
    FcursorOffset: TJSObject;
    Fdata: JSValue;
    FdragDirection: TdxDragDirection;
    FdragTemplate: JSValue;
    FelementAttr: TJSObject;
    Ffilter: string;
    Fgroup: string;
    Fhandle: string;
    Fheight_: JSValue;
    FrtlEnabled: boolean;
    FscrollSensitivity: integer;
    FscrollSpeed: integer;
    Fwidth_: JSValue;
  private
    FonDisposing: TdxEventHandler;
    FonDragEnd: TdxEventHandler;
    FonDragMove: TdxEventHandler;
    FonDragStart: TdxEventHandler;
    FonDrop: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
  private
    procedure Set_autoScroll(const value: boolean);
    procedure Set_boundary(const value: JSValue);
    procedure Set_clone(const value: boolean);
    procedure Set_container(const value: JSValue);
    procedure Set_contentTemplate(const value: JSValue);
    procedure Set_cursorOffset(const value: TJSObject);
    procedure Set_data(const value: JSValue);
    procedure Set_dragDirection(const value: TdxDragDirection);
    procedure Set_dragTemplate(const value: JSValue);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_filter(const value: string);
    procedure Set_group(const value: string);
    procedure Set_handle(const value: string);
    procedure Set_height_(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scrollSensitivity(const value: integer);
    procedure Set_scrollSpeed(const value: integer);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onDragEnd(const value: TdxEventHandler);
    procedure Set_onDragMove(const value: TdxEventHandler);
    procedure Set_onDragStart(const value: TdxEventHandler);
    procedure Set_onDrop(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxDraggable; assembler;
    function instance: TdxDraggable; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure resetOption(optionName: string); assembler;
  public
    property boundary: JSValue read Fboundary write Set_boundary;
    property container: JSValue read Fcontainer write Set_container;
    property contentTemplate: JSValue read FcontentTemplate write Set_contentTemplate;
    property cursorOffset: TJSObject read FcursorOffset write Set_cursorOffset;
    property data: JSValue read Fdata write Set_data;
    property dragTemplate: JSValue read FdragTemplate write Set_dragTemplate;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property autoScroll: boolean read FautoScroll write Set_autoScroll default true;
    property clone: boolean read Fclone write Set_clone default false;
    property dragDirection: TdxDragDirection read FdragDirection write Set_dragDirection default ddBoth;
    property filter: string read Ffilter write Set_filter;
    property group: string read Fgroup write Set_group;
    property handle: string read Fhandle write Set_handle;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property scrollSensitivity: integer read FscrollSensitivity write Set_scrollSensitivity;
    property scrollSpeed: integer read FscrollSpeed write Set_scrollSpeed;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onDragEnd: TdxEventHandler read FonDragEnd write Set_onDragEnd;
    property onDragMove: TdxEventHandler read FonDragMove write Set_onDragMove;
    property onDragStart: TdxEventHandler read FonDragStart write Set_onDragStart;
    property onDrop: TdxEventHandler read FonDrop write Set_onDrop;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
  end;

implementation


procedure TjdxCustomDraggable.CreateInitialize;
begin
  inherited;
  FautoScroll := true;
  Fboundary := nil;
  Fclone := false;
  Fcontainer := nil;
  FcontentTemplate := nil;
  FcursorOffset := TJSObject.new;
  Fdata := nil;
  FdragDirection := ddBoth;
  FdragTemplate := nil;
  FelementAttr := TJSObject.new;
  Ffilter := '';
  Fgroup := '';
  Fhandle := '';
  Fheight_ := nil;
  FrtlEnabled := false;
  FscrollSensitivity := 0;
  FscrollSpeed := 0;
  Fwidth_ := nil;

  FonDisposing := nil;
  FonDragEnd := nil;
  FonDragMove := nil;
  FonDragStart := nil;
  FonDrop := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
end;
procedure TjdxCustomDraggable.InitJQuery;
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
      $(id).dxDraggable(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomDraggable.getInstance(element: TJSObject): TdxDraggable;
asm
  return DevExpress.viz.dxDraggable.getInstance(element);
end;

function TjdxCustomDraggable.instance: TdxDraggable;
asm
  return $(this.GetJQID()).dxDraggable("instance");
end;
procedure TjdxCustomDraggable.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('autoScroll', autoScroll);
    SetOption('boundary', boundary);
    SetOption('clone', clone);
    SetOption('container', container);
    SetOption('contentTemplate', contentTemplate);
    SetOption('cursorOffset', cursorOffset);
    SetOption('data', data);
    SetOption('dragDirection', dragDirection.ToString());
    SetOption('dragTemplate', dragTemplate);
    SetOption('elementAttr', elementAttr);
    SetOption('filter', filter);
    SetOption('group', group);
    SetOption('handle', handle);
    SetOption('height', height_);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('scrollSensitivity', scrollSensitivity);
    SetOption('scrollSpeed', scrollSpeed);
    SetOption('width', width_);

    SetEvent('disposing', onDisposing);
    SetEvent('dragEnd', onDragEnd);
    SetEvent('dragMove', onDragMove);
    SetEvent('dragStart', onDragStart);
    SetEvent('drop', onDrop);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomDraggable.Set_autoScroll(const Value: boolean);
begin
  FautoScroll := Value;
  SetOption('autoScroll', autoScroll);
end;

procedure TjdxCustomDraggable.Set_boundary(const Value: JSValue);
begin
  Fboundary := Value;
  SetOption('boundary', boundary);
end;

procedure TjdxCustomDraggable.Set_clone(const Value: boolean);
begin
  Fclone := Value;
  SetOption('clone', clone);
end;

procedure TjdxCustomDraggable.Set_container(const Value: JSValue);
begin
  Fcontainer := Value;
  SetOption('container', container);
end;

procedure TjdxCustomDraggable.Set_contentTemplate(const Value: JSValue);
begin
  FcontentTemplate := Value;
  SetOption('contentTemplate', contentTemplate);
end;

procedure TjdxCustomDraggable.Set_cursorOffset(const Value: TJSObject);
begin
  FcursorOffset := Value;
  SetOption('cursorOffset', cursorOffset);
end;

procedure TjdxCustomDraggable.Set_data(const Value: JSValue);
begin
  Fdata := Value;
  SetOption('data', data);
end;

procedure TjdxCustomDraggable.Set_dragDirection(const Value: TdxDragDirection);
begin
  FdragDirection := Value;
  SetOption('dragDirection', dragDirection.ToString());
end;

procedure TjdxCustomDraggable.Set_dragTemplate(const Value: JSValue);
begin
  FdragTemplate := Value;
  SetOption('dragTemplate', dragTemplate);
end;

procedure TjdxCustomDraggable.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomDraggable.Set_filter(const Value: string);
begin
  Ffilter := Value;
  SetOption('filter', filter);
end;

procedure TjdxCustomDraggable.Set_group(const Value: string);
begin
  Fgroup := Value;
  SetOption('group', group);
end;

procedure TjdxCustomDraggable.Set_handle(const Value: string);
begin
  Fhandle := Value;
  SetOption('handle', handle);
end;

procedure TjdxCustomDraggable.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomDraggable.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomDraggable.Set_scrollSensitivity(const Value: integer);
begin
  FscrollSensitivity := Value;
  SetOption('scrollSensitivity', scrollSensitivity);
end;

procedure TjdxCustomDraggable.Set_scrollSpeed(const Value: integer);
begin
  FscrollSpeed := Value;
  SetOption('scrollSpeed', scrollSpeed);
end;

procedure TjdxCustomDraggable.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomDraggable.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomDraggable.Set_onDragEnd(const Value: TdxEventHandler);
begin
  FonDragEnd := Value;
  SetEvent('dragEnd', onDragEnd);
end;

procedure TjdxCustomDraggable.Set_onDragMove(const Value: TdxEventHandler);
begin
  FonDragMove := Value;
  SetEvent('dragMove', onDragMove);
end;

procedure TjdxCustomDraggable.Set_onDragStart(const Value: TdxEventHandler);
begin
  FonDragStart := Value;
  SetEvent('dragStart', onDragStart);
end;

procedure TjdxCustomDraggable.Set_onDrop(const Value: TdxEventHandler);
begin
  FonDrop := Value;
  SetEvent('drop', onDrop);
end;

procedure TjdxCustomDraggable.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomDraggable.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomDraggable.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxDraggable("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomDraggable.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDraggable("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomDraggable.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDraggable("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomDraggable.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDraggable("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomDraggable.dispose();
asm
  const _instance = $(this.GetJQID()).dxDraggable("instance");
  _instance.dispose();
end;

function TjdxCustomDraggable.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDraggable("instance");
  return _instance.element();
end;

procedure TjdxCustomDraggable.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxDraggable("instance");
  _instance.endUpdate();
end;

function TjdxCustomDraggable.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDraggable("instance");
  return _instance.off(eventName);
end;

function TjdxCustomDraggable.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDraggable("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomDraggable.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDraggable("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomDraggable.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDraggable("instance");
  return _instance.on(events);
end;

function TjdxCustomDraggable.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDraggable("instance");
  return _instance.option(optionName);
end;

function TjdxCustomDraggable.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxDraggable("instance");
  return _instance.option();
end;

procedure TjdxCustomDraggable.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDraggable("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomDraggable.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDraggable("instance");
  _instance.option(options);
end;

procedure TjdxCustomDraggable.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxDraggable("instance");
  _instance.resetOption(optionName);
end;

end.
