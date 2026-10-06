unit DevExtreme.Sortable.Custom;

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
  DevExtreme.Sortable.JS,
  DevExtreme.Types;

type
  TjdxCustomSortable = class(TjdxCustomControl)
  private
    FallowDropInsideItem: boolean;
    FallowReordering: boolean;
    FautoScroll: boolean;
    Fboundary: JSValue;
    Fcontainer: JSValue;
    FcontentTemplate: JSValue;
    FcursorOffset: TJSObject;
    Fdata: JSValue;
    FdragDirection: TdxDragDirection;
    FdragTemplate: JSValue;
    FdropFeedbackMode: TdxDragHighlight;
    FelementAttr: TJSObject;
    Ffilter: string;
    Fgroup: string;
    Fhandle: string;
    Fheight_: JSValue;
    FitemOrientation: TdxOrientation;
    FmoveItemOnDrop: boolean;
    FrtlEnabled: boolean;
    FscrollSensitivity: integer;
    FscrollSpeed: integer;
    Fwidth_: JSValue;
  private
    FonAdd: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonDragChange: TdxEventHandler;
    FonDragEnd: TdxEventHandler;
    FonDragMove: TdxEventHandler;
    FonDragStart: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonPlaceholderPrepared: TdxEventHandler;
    FonRemove: TdxEventHandler;
    FonReorder: TdxEventHandler;
  private
    procedure Set_allowDropInsideItem(const value: boolean);
    procedure Set_allowReordering(const value: boolean);
    procedure Set_autoScroll(const value: boolean);
    procedure Set_boundary(const value: JSValue);
    procedure Set_container(const value: JSValue);
    procedure Set_contentTemplate(const value: JSValue);
    procedure Set_cursorOffset(const value: TJSObject);
    procedure Set_data(const value: JSValue);
    procedure Set_dragDirection(const value: TdxDragDirection);
    procedure Set_dragTemplate(const value: JSValue);
    procedure Set_dropFeedbackMode(const value: TdxDragHighlight);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_filter(const value: string);
    procedure Set_group(const value: string);
    procedure Set_handle(const value: string);
    procedure Set_height_(const value: JSValue);
    procedure Set_itemOrientation(const value: TdxOrientation);
    procedure Set_moveItemOnDrop(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scrollSensitivity(const value: integer);
    procedure Set_scrollSpeed(const value: integer);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onAdd(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onDragChange(const value: TdxEventHandler);
    procedure Set_onDragEnd(const value: TdxEventHandler);
    procedure Set_onDragMove(const value: TdxEventHandler);
    procedure Set_onDragStart(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onPlaceholderPrepared(const value: TdxEventHandler);
    procedure Set_onRemove(const value: TdxEventHandler);
    procedure Set_onReorder(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxSortable; assembler;
    function instance: TdxSortable; assembler;
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
    procedure update(); assembler;
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
    property allowDropInsideItem: boolean read FallowDropInsideItem write Set_allowDropInsideItem default false;
    property allowReordering: boolean read FallowReordering write Set_allowReordering default true;
    property autoScroll: boolean read FautoScroll write Set_autoScroll default true;
    property dragDirection: TdxDragDirection read FdragDirection write Set_dragDirection default ddBoth;
    property dropFeedbackMode: TdxDragHighlight read FdropFeedbackMode write Set_dropFeedbackMode default dhPush;
    property filter: string read Ffilter write Set_filter;
    property group: string read Fgroup write Set_group;
    property handle: string read Fhandle write Set_handle;
    property itemOrientation: TdxOrientation read FitemOrientation write Set_itemOrientation default oVertical;
    property moveItemOnDrop: boolean read FmoveItemOnDrop write Set_moveItemOnDrop default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property scrollSensitivity: integer read FscrollSensitivity write Set_scrollSensitivity;
    property scrollSpeed: integer read FscrollSpeed write Set_scrollSpeed;
  published
    property onAdd: TdxEventHandler read FonAdd write Set_onAdd;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onDragChange: TdxEventHandler read FonDragChange write Set_onDragChange;
    property onDragEnd: TdxEventHandler read FonDragEnd write Set_onDragEnd;
    property onDragMove: TdxEventHandler read FonDragMove write Set_onDragMove;
    property onDragStart: TdxEventHandler read FonDragStart write Set_onDragStart;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onPlaceholderPrepared: TdxEventHandler read FonPlaceholderPrepared write Set_onPlaceholderPrepared;
    property onRemove: TdxEventHandler read FonRemove write Set_onRemove;
    property onReorder: TdxEventHandler read FonReorder write Set_onReorder;
  end;

implementation


procedure TjdxCustomSortable.CreateInitialize;
begin
  inherited;
  FallowDropInsideItem := false;
  FallowReordering := true;
  FautoScroll := true;
  Fboundary := nil;
  Fcontainer := nil;
  FcontentTemplate := nil;
  FcursorOffset := TJSObject.new;
  Fdata := nil;
  FdragDirection := ddBoth;
  FdragTemplate := nil;
  FdropFeedbackMode := dhPush;
  FelementAttr := TJSObject.new;
  Ffilter := '';
  Fgroup := '';
  Fhandle := '';
  Fheight_ := nil;
  FitemOrientation := oVertical;
  FmoveItemOnDrop := false;
  FrtlEnabled := false;
  FscrollSensitivity := 0;
  FscrollSpeed := 0;
  Fwidth_ := nil;

  FonAdd := nil;
  FonDisposing := nil;
  FonDragChange := nil;
  FonDragEnd := nil;
  FonDragMove := nil;
  FonDragStart := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonPlaceholderPrepared := nil;
  FonRemove := nil;
  FonReorder := nil;
end;
procedure TjdxCustomSortable.InitJQuery;
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
      $(id).dxSortable(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomSortable.getInstance(element: TJSObject): TdxSortable;
asm
  return DevExpress.viz.dxSortable.getInstance(element);
end;

function TjdxCustomSortable.instance: TdxSortable;
asm
  return $(this.GetJQID()).dxSortable("instance");
end;
procedure TjdxCustomSortable.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('allowDropInsideItem', allowDropInsideItem);
    SetOption('allowReordering', allowReordering);
    SetOption('autoScroll', autoScroll);
    SetOption('boundary', boundary);
    SetOption('container', container);
    SetOption('contentTemplate', contentTemplate);
    SetOption('cursorOffset', cursorOffset);
    SetOption('data', data);
    SetOption('dragDirection', dragDirection.ToString());
    SetOption('dragTemplate', dragTemplate);
    SetOption('dropFeedbackMode', dropFeedbackMode.ToString());
    SetOption('elementAttr', elementAttr);
    SetOption('filter', filter);
    SetOption('group', group);
    SetOption('handle', handle);
    SetOption('height', height_);
    SetOption('itemOrientation', itemOrientation.ToString());
    SetOption('moveItemOnDrop', moveItemOnDrop);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('scrollSensitivity', scrollSensitivity);
    SetOption('scrollSpeed', scrollSpeed);
    SetOption('width', width_);

    SetEvent('add', onAdd);
    SetEvent('disposing', onDisposing);
    SetEvent('dragChange', onDragChange);
    SetEvent('dragEnd', onDragEnd);
    SetEvent('dragMove', onDragMove);
    SetEvent('dragStart', onDragStart);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('placeholderPrepared', onPlaceholderPrepared);
    SetEvent('remove', onRemove);
    SetEvent('reorder', onReorder);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomSortable.Set_allowDropInsideItem(const Value: boolean);
begin
  FallowDropInsideItem := Value;
  SetOption('allowDropInsideItem', allowDropInsideItem);
end;

procedure TjdxCustomSortable.Set_allowReordering(const Value: boolean);
begin
  FallowReordering := Value;
  SetOption('allowReordering', allowReordering);
end;

procedure TjdxCustomSortable.Set_autoScroll(const Value: boolean);
begin
  FautoScroll := Value;
  SetOption('autoScroll', autoScroll);
end;

procedure TjdxCustomSortable.Set_boundary(const Value: JSValue);
begin
  Fboundary := Value;
  SetOption('boundary', boundary);
end;

procedure TjdxCustomSortable.Set_container(const Value: JSValue);
begin
  Fcontainer := Value;
  SetOption('container', container);
end;

procedure TjdxCustomSortable.Set_contentTemplate(const Value: JSValue);
begin
  FcontentTemplate := Value;
  SetOption('contentTemplate', contentTemplate);
end;

procedure TjdxCustomSortable.Set_cursorOffset(const Value: TJSObject);
begin
  FcursorOffset := Value;
  SetOption('cursorOffset', cursorOffset);
end;

procedure TjdxCustomSortable.Set_data(const Value: JSValue);
begin
  Fdata := Value;
  SetOption('data', data);
end;

procedure TjdxCustomSortable.Set_dragDirection(const Value: TdxDragDirection);
begin
  FdragDirection := Value;
  SetOption('dragDirection', dragDirection.ToString());
end;

procedure TjdxCustomSortable.Set_dragTemplate(const Value: JSValue);
begin
  FdragTemplate := Value;
  SetOption('dragTemplate', dragTemplate);
end;

procedure TjdxCustomSortable.Set_dropFeedbackMode(const Value: TdxDragHighlight);
begin
  FdropFeedbackMode := Value;
  SetOption('dropFeedbackMode', dropFeedbackMode.ToString());
end;

procedure TjdxCustomSortable.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomSortable.Set_filter(const Value: string);
begin
  Ffilter := Value;
  SetOption('filter', filter);
end;

procedure TjdxCustomSortable.Set_group(const Value: string);
begin
  Fgroup := Value;
  SetOption('group', group);
end;

procedure TjdxCustomSortable.Set_handle(const Value: string);
begin
  Fhandle := Value;
  SetOption('handle', handle);
end;

procedure TjdxCustomSortable.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomSortable.Set_itemOrientation(const Value: TdxOrientation);
begin
  FitemOrientation := Value;
  SetOption('itemOrientation', itemOrientation.ToString());
end;

procedure TjdxCustomSortable.Set_moveItemOnDrop(const Value: boolean);
begin
  FmoveItemOnDrop := Value;
  SetOption('moveItemOnDrop', moveItemOnDrop);
end;

procedure TjdxCustomSortable.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomSortable.Set_scrollSensitivity(const Value: integer);
begin
  FscrollSensitivity := Value;
  SetOption('scrollSensitivity', scrollSensitivity);
end;

procedure TjdxCustomSortable.Set_scrollSpeed(const Value: integer);
begin
  FscrollSpeed := Value;
  SetOption('scrollSpeed', scrollSpeed);
end;

procedure TjdxCustomSortable.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomSortable.Set_onAdd(const Value: TdxEventHandler);
begin
  FonAdd := Value;
  SetEvent('add', onAdd);
end;

procedure TjdxCustomSortable.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomSortable.Set_onDragChange(const Value: TdxEventHandler);
begin
  FonDragChange := Value;
  SetEvent('dragChange', onDragChange);
end;

procedure TjdxCustomSortable.Set_onDragEnd(const Value: TdxEventHandler);
begin
  FonDragEnd := Value;
  SetEvent('dragEnd', onDragEnd);
end;

procedure TjdxCustomSortable.Set_onDragMove(const Value: TdxEventHandler);
begin
  FonDragMove := Value;
  SetEvent('dragMove', onDragMove);
end;

procedure TjdxCustomSortable.Set_onDragStart(const Value: TdxEventHandler);
begin
  FonDragStart := Value;
  SetEvent('dragStart', onDragStart);
end;

procedure TjdxCustomSortable.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomSortable.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomSortable.Set_onPlaceholderPrepared(const Value: TdxEventHandler);
begin
  FonPlaceholderPrepared := Value;
  SetEvent('placeholderPrepared', onPlaceholderPrepared);
end;

procedure TjdxCustomSortable.Set_onRemove(const Value: TdxEventHandler);
begin
  FonRemove := Value;
  SetEvent('remove', onRemove);
end;

procedure TjdxCustomSortable.Set_onReorder(const Value: TdxEventHandler);
begin
  FonReorder := Value;
  SetEvent('reorder', onReorder);
end;

procedure TjdxCustomSortable.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomSortable.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomSortable.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomSortable.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomSortable.dispose();
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  _instance.dispose();
end;

function TjdxCustomSortable.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  return _instance.element();
end;

procedure TjdxCustomSortable.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  _instance.endUpdate();
end;

function TjdxCustomSortable.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  return _instance.off(eventName);
end;

function TjdxCustomSortable.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomSortable.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomSortable.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  return _instance.on(events);
end;

function TjdxCustomSortable.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  return _instance.option(optionName);
end;

function TjdxCustomSortable.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  return _instance.option();
end;

procedure TjdxCustomSortable.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomSortable.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  _instance.option(options);
end;

procedure TjdxCustomSortable.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomSortable.update();
asm
  const _instance = $(this.GetJQID()).dxSortable("instance");
  _instance.update();
end;

end.
