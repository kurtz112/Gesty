unit DevExtreme.Resizable;

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
  TjdxResizable = class(TjdxCustomControl)
  private
    Farea: JSValue;
    FelementAttr: TJSObject;
    Fhandles: JSValue;
    Fheight_: JSValue;
    FkeepAspectRatio: boolean;
    FmaxHeight: integer;
    FmaxWidth: integer;
    FminHeight: integer;
    FminWidth: integer;
    FrtlEnabled: boolean;
    FstepPrecision: TdxResizableStepPrecision;
    Fwidth_: JSValue;
  private
    FonDisposing: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonResize: TdxEventHandler;
    FonResizeEnd: TdxEventHandler;
    FonResizeStart: TdxEventHandler;
  private
    procedure Set_area(const value: JSValue);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_handles(const value: JSValue);
    procedure Set_height_(const value: JSValue);
    procedure Set_keepAspectRatio(const value: boolean);
    procedure Set_maxHeight(const value: integer);
    procedure Set_maxWidth(const value: integer);
    procedure Set_minHeight(const value: integer);
    procedure Set_minWidth(const value: integer);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_stepPrecision(const value: TdxResizableStepPrecision);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onResize(const value: TdxEventHandler);
    procedure Set_onResizeEnd(const value: TdxEventHandler);
    procedure Set_onResizeStart(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property area: JSValue read Farea write Set_area;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property handles: JSValue read Fhandles write Set_handles;
    property height_: JSValue read Fheight_ write Set_height_;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property keepAspectRatio: boolean read FkeepAspectRatio write Set_keepAspectRatio default true;
    property maxHeight: integer read FmaxHeight write Set_maxHeight;
    property maxWidth: integer read FmaxWidth write Set_maxWidth;
    property minHeight: integer read FminHeight write Set_minHeight;
    property minWidth: integer read FminWidth write Set_minWidth;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property stepPrecision: TdxResizableStepPrecision read FstepPrecision write Set_stepPrecision default rspSimple;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onResize: TdxEventHandler read FonResize write Set_onResize;
    property onResizeEnd: TdxEventHandler read FonResizeEnd write Set_onResizeEnd;
    property onResizeStart: TdxEventHandler read FonResizeStart write Set_onResizeStart;
  end;

implementation


constructor TjdxResizable.Create(aOwner: TComponent);
begin
  inherited;
  Farea := nil;
  FelementAttr := TJSObject.new;
  Fhandles := nil;
  Fheight_ := nil;
  FkeepAspectRatio := true;
  FmaxHeight := 0;
  FmaxWidth := 0;
  FminHeight := 0;
  FminWidth := 0;
  FrtlEnabled := false;
  FstepPrecision := rspSimple;
  Fwidth_ := nil;

  FonDisposing := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonResize := nil;
  FonResizeEnd := nil;
  FonResizeStart := nil;
end;

procedure TjdxResizable.Set_area(const Value: JSValue);
begin
  Farea := Value;
end;

procedure TjdxResizable.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxResizable.Set_handles(const Value: JSValue);
begin
  Fhandles := Value;
end;

procedure TjdxResizable.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxResizable.Set_keepAspectRatio(const Value: boolean);
begin
  FkeepAspectRatio := Value;
end;

procedure TjdxResizable.Set_maxHeight(const Value: integer);
begin
  FmaxHeight := Value;
end;

procedure TjdxResizable.Set_maxWidth(const Value: integer);
begin
  FmaxWidth := Value;
end;

procedure TjdxResizable.Set_minHeight(const Value: integer);
begin
  FminHeight := Value;
end;

procedure TjdxResizable.Set_minWidth(const Value: integer);
begin
  FminWidth := Value;
end;

procedure TjdxResizable.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxResizable.Set_stepPrecision(const Value: TdxResizableStepPrecision);
begin
  FstepPrecision := Value;
end;

procedure TjdxResizable.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxResizable.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxResizable.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxResizable.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxResizable.Set_onResize(const Value: TdxEventHandler);
begin
  FonResize := Value;
end;

procedure TjdxResizable.Set_onResizeEnd(const Value: TdxEventHandler);
begin
  FonResizeEnd := Value;
end;

procedure TjdxResizable.Set_onResizeStart(const Value: TdxEventHandler);
begin
  FonResizeStart := Value;
end;

end.
