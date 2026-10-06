unit DevExtreme.Draggable;

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
  TjdxDraggable = class(TjdxCustomControl)
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


constructor TjdxDraggable.Create(aOwner: TComponent);
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

procedure TjdxDraggable.Set_autoScroll(const Value: boolean);
begin
  FautoScroll := Value;
end;

procedure TjdxDraggable.Set_boundary(const Value: JSValue);
begin
  Fboundary := Value;
end;

procedure TjdxDraggable.Set_clone(const Value: boolean);
begin
  Fclone := Value;
end;

procedure TjdxDraggable.Set_container(const Value: JSValue);
begin
  Fcontainer := Value;
end;

procedure TjdxDraggable.Set_contentTemplate(const Value: JSValue);
begin
  FcontentTemplate := Value;
end;

procedure TjdxDraggable.Set_cursorOffset(const Value: TJSObject);
begin
  FcursorOffset := Value;
end;

procedure TjdxDraggable.Set_data(const Value: JSValue);
begin
  Fdata := Value;
end;

procedure TjdxDraggable.Set_dragDirection(const Value: TdxDragDirection);
begin
  FdragDirection := Value;
end;

procedure TjdxDraggable.Set_dragTemplate(const Value: JSValue);
begin
  FdragTemplate := Value;
end;

procedure TjdxDraggable.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxDraggable.Set_filter(const Value: string);
begin
  Ffilter := Value;
end;

procedure TjdxDraggable.Set_group(const Value: string);
begin
  Fgroup := Value;
end;

procedure TjdxDraggable.Set_handle(const Value: string);
begin
  Fhandle := Value;
end;

procedure TjdxDraggable.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxDraggable.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxDraggable.Set_scrollSensitivity(const Value: integer);
begin
  FscrollSensitivity := Value;
end;

procedure TjdxDraggable.Set_scrollSpeed(const Value: integer);
begin
  FscrollSpeed := Value;
end;

procedure TjdxDraggable.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxDraggable.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxDraggable.Set_onDragEnd(const Value: TdxEventHandler);
begin
  FonDragEnd := Value;
end;

procedure TjdxDraggable.Set_onDragMove(const Value: TdxEventHandler);
begin
  FonDragMove := Value;
end;

procedure TjdxDraggable.Set_onDragStart(const Value: TdxEventHandler);
begin
  FonDragStart := Value;
end;

procedure TjdxDraggable.Set_onDrop(const Value: TdxEventHandler);
begin
  FonDrop := Value;
end;

procedure TjdxDraggable.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxDraggable.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

end.
