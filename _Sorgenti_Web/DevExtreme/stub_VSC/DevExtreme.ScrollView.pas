unit DevExtreme.ScrollView;

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
  TjdxScrollView = class(TjdxCustomControl)
  private
    FbounceEnabled: boolean;
    Fdirection: TdxScrollDirection;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fheight_: JSValue;
    FpulledDownText: string;
    FpullingDownText: string;
    FreachBottomText: string;
    FrefreshingText: string;
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
    FonPullDown: TdxEventHandler;
    FonReachBottom: TdxEventHandler;
    FonScroll: TdxEventHandler;
    FonUpdated: TdxEventHandler;
  private
    procedure Set_bounceEnabled(const value: boolean);
    procedure Set_direction(const value: TdxScrollDirection);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_pulledDownText(const value: string);
    procedure Set_pullingDownText(const value: string);
    procedure Set_reachBottomText(const value: string);
    procedure Set_refreshingText(const value: string);
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
    procedure Set_onPullDown(const value: TdxEventHandler);
    procedure Set_onReachBottom(const value: TdxEventHandler);
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
    property pulledDownText: string read FpulledDownText write Set_pulledDownText;
    property pullingDownText: string read FpullingDownText write Set_pullingDownText;
    property reachBottomText: string read FreachBottomText write Set_reachBottomText;
    property refreshingText: string read FrefreshingText write Set_refreshingText;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property scrollByContent: boolean read FscrollByContent write Set_scrollByContent;
    property scrollByThumb: boolean read FscrollByThumb write Set_scrollByThumb;
    property showScrollbar: TdxScrollableShowScrollbar read FshowScrollbar write Set_showScrollbar default sssAlways;
    property useNative: boolean read FuseNative write Set_useNative;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onPullDown: TdxEventHandler read FonPullDown write Set_onPullDown;
    property onReachBottom: TdxEventHandler read FonReachBottom write Set_onReachBottom;
    property onScroll: TdxEventHandler read FonScroll write Set_onScroll;
    property onUpdated: TdxEventHandler read FonUpdated write Set_onUpdated;
  end;

implementation


constructor TjdxScrollView.Create(aOwner: TComponent);
begin
  inherited;
  FbounceEnabled := false;
  Fdirection := sdVertical;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fheight_ := nil;
  FpulledDownText := '';
  FpullingDownText := '';
  FreachBottomText := '';
  FrefreshingText := '';
  FrtlEnabled := false;
  FscrollByContent := false;
  FscrollByThumb := false;
  FshowScrollbar := sssAlways;
  FuseNative := false;
  Fwidth_ := nil;

  FonDisposing := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonPullDown := nil;
  FonReachBottom := nil;
  FonScroll := nil;
  FonUpdated := nil;
end;

procedure TjdxScrollView.Set_bounceEnabled(const Value: boolean);
begin
  FbounceEnabled := Value;
end;

procedure TjdxScrollView.Set_direction(const Value: TdxScrollDirection);
begin
  Fdirection := Value;
end;

procedure TjdxScrollView.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxScrollView.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxScrollView.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxScrollView.Set_pulledDownText(const Value: string);
begin
  FpulledDownText := Value;
end;

procedure TjdxScrollView.Set_pullingDownText(const Value: string);
begin
  FpullingDownText := Value;
end;

procedure TjdxScrollView.Set_reachBottomText(const Value: string);
begin
  FreachBottomText := Value;
end;

procedure TjdxScrollView.Set_refreshingText(const Value: string);
begin
  FrefreshingText := Value;
end;

procedure TjdxScrollView.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxScrollView.Set_scrollByContent(const Value: boolean);
begin
  FscrollByContent := Value;
end;

procedure TjdxScrollView.Set_scrollByThumb(const Value: boolean);
begin
  FscrollByThumb := Value;
end;

procedure TjdxScrollView.Set_showScrollbar(const Value: TdxScrollableShowScrollbar);
begin
  FshowScrollbar := Value;
end;

procedure TjdxScrollView.Set_useNative(const Value: boolean);
begin
  FuseNative := Value;
end;

procedure TjdxScrollView.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxScrollView.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxScrollView.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxScrollView.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxScrollView.Set_onPullDown(const Value: TdxEventHandler);
begin
  FonPullDown := Value;
end;

procedure TjdxScrollView.Set_onReachBottom(const Value: TdxEventHandler);
begin
  FonReachBottom := Value;
end;

procedure TjdxScrollView.Set_onScroll(const Value: TdxEventHandler);
begin
  FonScroll := Value;
end;

procedure TjdxScrollView.Set_onUpdated(const Value: TdxEventHandler);
begin
  FonUpdated := Value;
end;

end.
