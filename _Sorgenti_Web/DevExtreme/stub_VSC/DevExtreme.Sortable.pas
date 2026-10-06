unit DevExtreme.Sortable;

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
  TjdxSortable = class(TjdxCustomControl)
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
  public
    constructor Create(aOwner: TComponent); override;
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


constructor TjdxSortable.Create(aOwner: TComponent);
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

procedure TjdxSortable.Set_allowDropInsideItem(const Value: boolean);
begin
  FallowDropInsideItem := Value;
end;

procedure TjdxSortable.Set_allowReordering(const Value: boolean);
begin
  FallowReordering := Value;
end;

procedure TjdxSortable.Set_autoScroll(const Value: boolean);
begin
  FautoScroll := Value;
end;

procedure TjdxSortable.Set_boundary(const Value: JSValue);
begin
  Fboundary := Value;
end;

procedure TjdxSortable.Set_container(const Value: JSValue);
begin
  Fcontainer := Value;
end;

procedure TjdxSortable.Set_contentTemplate(const Value: JSValue);
begin
  FcontentTemplate := Value;
end;

procedure TjdxSortable.Set_cursorOffset(const Value: TJSObject);
begin
  FcursorOffset := Value;
end;

procedure TjdxSortable.Set_data(const Value: JSValue);
begin
  Fdata := Value;
end;

procedure TjdxSortable.Set_dragDirection(const Value: TdxDragDirection);
begin
  FdragDirection := Value;
end;

procedure TjdxSortable.Set_dragTemplate(const Value: JSValue);
begin
  FdragTemplate := Value;
end;

procedure TjdxSortable.Set_dropFeedbackMode(const Value: TdxDragHighlight);
begin
  FdropFeedbackMode := Value;
end;

procedure TjdxSortable.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxSortable.Set_filter(const Value: string);
begin
  Ffilter := Value;
end;

procedure TjdxSortable.Set_group(const Value: string);
begin
  Fgroup := Value;
end;

procedure TjdxSortable.Set_handle(const Value: string);
begin
  Fhandle := Value;
end;

procedure TjdxSortable.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxSortable.Set_itemOrientation(const Value: TdxOrientation);
begin
  FitemOrientation := Value;
end;

procedure TjdxSortable.Set_moveItemOnDrop(const Value: boolean);
begin
  FmoveItemOnDrop := Value;
end;

procedure TjdxSortable.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxSortable.Set_scrollSensitivity(const Value: integer);
begin
  FscrollSensitivity := Value;
end;

procedure TjdxSortable.Set_scrollSpeed(const Value: integer);
begin
  FscrollSpeed := Value;
end;

procedure TjdxSortable.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxSortable.Set_onAdd(const Value: TdxEventHandler);
begin
  FonAdd := Value;
end;

procedure TjdxSortable.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxSortable.Set_onDragChange(const Value: TdxEventHandler);
begin
  FonDragChange := Value;
end;

procedure TjdxSortable.Set_onDragEnd(const Value: TdxEventHandler);
begin
  FonDragEnd := Value;
end;

procedure TjdxSortable.Set_onDragMove(const Value: TdxEventHandler);
begin
  FonDragMove := Value;
end;

procedure TjdxSortable.Set_onDragStart(const Value: TdxEventHandler);
begin
  FonDragStart := Value;
end;

procedure TjdxSortable.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxSortable.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxSortable.Set_onPlaceholderPrepared(const Value: TdxEventHandler);
begin
  FonPlaceholderPrepared := Value;
end;

procedure TjdxSortable.Set_onRemove(const Value: TdxEventHandler);
begin
  FonRemove := Value;
end;

procedure TjdxSortable.Set_onReorder(const Value: TdxEventHandler);
begin
  FonReorder := Value;
end;

end.
