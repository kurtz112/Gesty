unit DevExtreme.Scrollable;

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
  [ComponentPlatforms(TMSWebPlatform)]
  TjdxScrollable = class(TjdxCustomControl)
  private
    FbounceEnabled: boolean;
    Fdirection: TdxScrollDirection;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fheight_: JSValue;
    FrtlEnabled: boolean;
    FscrollByContent: boolean;
    FscrollByThumb: boolean;
    FshowScrollbar: TdxScrollableShowScrollbar;
    FuseNative: boolean;
    Fwidth_: JSValue;
  private
    FonDisposing: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonScroll: TdxEventHandler;
    FonUpdated: TdxEventHandler;
  private
    procedure Set_bounceEnabled(const value: boolean);
    procedure Set_direction(const value: TdxScrollDirection);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scrollByContent(const value: boolean);
    procedure Set_scrollByThumb(const value: boolean);
    procedure Set_showScrollbar(const value: TdxScrollableShowScrollbar);
    procedure Set_useNative(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onScroll(const value: TdxEventHandler);
    procedure Set_onUpdated(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property bounceEnabled: boolean read FbounceEnabled write Set_bounceEnabled;
    property direction: TdxScrollDirection read Fdirection write Set_direction default sdVertical;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property scrollByContent: boolean read FscrollByContent write Set_scrollByContent;
    property scrollByThumb: boolean read FscrollByThumb write Set_scrollByThumb;
    property showScrollbar: TdxScrollableShowScrollbar read FshowScrollbar write Set_showScrollbar default sssAlways;
    property useNative: boolean read FuseNative write Set_useNative;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onScroll: TdxEventHandler read FonScroll write Set_onScroll;
    property onUpdated: TdxEventHandler read FonUpdated write Set_onUpdated;
  end;

implementation


constructor TjdxScrollable.Create(aOwner: TComponent);
begin
  inherited;
  FbounceEnabled := false;
  Fdirection := sdVertical;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fheight_ := nil;
  FrtlEnabled := false;
  FscrollByContent := false;
  FscrollByThumb := false;
  FshowScrollbar := sssAlways;
  FuseNative := false;
  Fwidth_ := nil;

  FonDisposing := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonScroll := nil;
  FonUpdated := nil;
end;

procedure TjdxScrollable.Set_bounceEnabled(const Value: boolean);
begin
  FbounceEnabled := Value;
end;

procedure TjdxScrollable.Set_direction(const Value: TdxScrollDirection);
begin
  Fdirection := Value;
end;

procedure TjdxScrollable.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxScrollable.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxScrollable.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxScrollable.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxScrollable.Set_scrollByContent(const Value: boolean);
begin
  FscrollByContent := Value;
end;

procedure TjdxScrollable.Set_scrollByThumb(const Value: boolean);
begin
  FscrollByThumb := Value;
end;

procedure TjdxScrollable.Set_showScrollbar(const Value: TdxScrollableShowScrollbar);
begin
  FshowScrollbar := Value;
end;

procedure TjdxScrollable.Set_useNative(const Value: boolean);
begin
  FuseNative := Value;
end;

procedure TjdxScrollable.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxScrollable.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxScrollable.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxScrollable.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxScrollable.Set_onScroll(const Value: TdxEventHandler);
begin
  FonScroll := Value;
end;

procedure TjdxScrollable.Set_onUpdated(const Value: TdxEventHandler);
begin
  FonUpdated := Value;
end;

end.
