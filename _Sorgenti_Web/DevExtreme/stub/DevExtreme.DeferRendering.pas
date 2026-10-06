unit DevExtreme.DeferRendering;

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
  TjdxDeferRendering = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fanimation: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FrenderWhen: JSValue;
    FrtlEnabled: boolean;
    FshowLoadIndicator: boolean;
    FstaggerItemSelector: string;
    FtabIndex: integer;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonRendered: TdxEventHandler;
    FonShown: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_animation(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_renderWhen(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_showLoadIndicator(const value: boolean);
    procedure Set_staggerItemSelector(const value: string);
    procedure Set_tabIndex(const value: integer);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onRendered(const value: TdxEventHandler);
    procedure Set_onShown(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property animation: JSValue read Fanimation write Set_animation;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property renderWhen: JSValue read FrenderWhen write Set_renderWhen;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showLoadIndicator: boolean read FshowLoadIndicator write Set_showLoadIndicator default false;
    property staggerItemSelector: string read FstaggerItemSelector write Set_staggerItemSelector;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onRendered: TdxEventHandler read FonRendered write Set_onRendered;
    property onShown: TdxEventHandler read FonShown write Set_onShown;
  end;

implementation


constructor TjdxDeferRendering.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  Fanimation := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FrenderWhen := nil;
  FrtlEnabled := false;
  FshowLoadIndicator := false;
  FstaggerItemSelector := '';
  FtabIndex := 0;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonRendered := nil;
  FonShown := nil;
end;

procedure TjdxDeferRendering.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxDeferRendering.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxDeferRendering.Set_animation(const Value: JSValue);
begin
  Fanimation := Value;
end;

procedure TjdxDeferRendering.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxDeferRendering.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxDeferRendering.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxDeferRendering.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxDeferRendering.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxDeferRendering.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxDeferRendering.Set_renderWhen(const Value: JSValue);
begin
  FrenderWhen := Value;
end;

procedure TjdxDeferRendering.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxDeferRendering.Set_showLoadIndicator(const Value: boolean);
begin
  FshowLoadIndicator := Value;
end;

procedure TjdxDeferRendering.Set_staggerItemSelector(const Value: string);
begin
  FstaggerItemSelector := Value;
end;

procedure TjdxDeferRendering.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxDeferRendering.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxDeferRendering.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxDeferRendering.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxDeferRendering.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxDeferRendering.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxDeferRendering.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxDeferRendering.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxDeferRendering.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxDeferRendering.Set_onRendered(const Value: TdxEventHandler);
begin
  FonRendered := Value;
end;

procedure TjdxDeferRendering.Set_onShown(const Value: TdxEventHandler);
begin
  FonShown := Value;
end;

end.
