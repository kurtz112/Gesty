unit DevExtreme.Drawer;

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
  TjdxDrawer = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FanimationDuration: integer;
    FanimationEnabled: boolean;
    FcloseOnOutsideClick: JSValue;
    FcontentTemplate: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FmaxSize: integer;
    FminSize: integer;
    Fopened: boolean;
    FopenedStateMode: TdxOpenedStateMode;
    Fposition: TdxPanelLocation;
    FrevealMode: TdxRevealMode;
    FrtlEnabled: boolean;
    Fshading: boolean;
    FtabIndex: integer;
    Ftemplate: JSValue;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_animationDuration(const value: integer);
    procedure Set_animationEnabled(const value: boolean);
    procedure Set_closeOnOutsideClick(const value: JSValue);
    procedure Set_contentTemplate(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_maxSize(const value: integer);
    procedure Set_minSize(const value: integer);
    procedure Set_opened(const value: boolean);
    procedure Set_openedStateMode(const value: TdxOpenedStateMode);
    procedure Set_position(const value: TdxPanelLocation);
    procedure Set_revealMode(const value: TdxRevealMode);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_shading(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_template(const value: JSValue);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property closeOnOutsideClick: JSValue read FcloseOnOutsideClick write Set_closeOnOutsideClick;
    property contentTemplate: JSValue read FcontentTemplate write Set_contentTemplate;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property template: JSValue read Ftemplate write Set_template;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property animationDuration: integer read FanimationDuration write Set_animationDuration;
    property animationEnabled: boolean read FanimationEnabled write Set_animationEnabled default true;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property maxSize: integer read FmaxSize write Set_maxSize;
    property minSize: integer read FminSize write Set_minSize;
    property opened: boolean read Fopened write Set_opened default false;
    property openedStateMode: TdxOpenedStateMode read FopenedStateMode write Set_openedStateMode default osmShrink;
    property position: TdxPanelLocation read Fposition write Set_position default plLeft;
    property revealMode: TdxRevealMode read FrevealMode write Set_revealMode default rmSlide;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property shading: boolean read Fshading write Set_shading default false;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
  end;

implementation


constructor TjdxDrawer.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FanimationDuration := 0;
  FanimationEnabled := true;
  FcloseOnOutsideClick := nil;
  FcontentTemplate := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FmaxSize := 0;
  FminSize := 0;
  Fopened := false;
  FopenedStateMode := osmShrink;
  Fposition := plLeft;
  FrevealMode := rmSlide;
  FrtlEnabled := false;
  Fshading := false;
  FtabIndex := 0;
  Ftemplate := nil;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
end;

procedure TjdxDrawer.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxDrawer.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxDrawer.Set_animationDuration(const Value: integer);
begin
  FanimationDuration := Value;
end;

procedure TjdxDrawer.Set_animationEnabled(const Value: boolean);
begin
  FanimationEnabled := Value;
end;

procedure TjdxDrawer.Set_closeOnOutsideClick(const Value: JSValue);
begin
  FcloseOnOutsideClick := Value;
end;

procedure TjdxDrawer.Set_contentTemplate(const Value: JSValue);
begin
  FcontentTemplate := Value;
end;

procedure TjdxDrawer.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxDrawer.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxDrawer.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxDrawer.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxDrawer.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxDrawer.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxDrawer.Set_maxSize(const Value: integer);
begin
  FmaxSize := Value;
end;

procedure TjdxDrawer.Set_minSize(const Value: integer);
begin
  FminSize := Value;
end;

procedure TjdxDrawer.Set_opened(const Value: boolean);
begin
  Fopened := Value;
end;

procedure TjdxDrawer.Set_openedStateMode(const Value: TdxOpenedStateMode);
begin
  FopenedStateMode := Value;
end;

procedure TjdxDrawer.Set_position(const Value: TdxPanelLocation);
begin
  Fposition := Value;
end;

procedure TjdxDrawer.Set_revealMode(const Value: TdxRevealMode);
begin
  FrevealMode := Value;
end;

procedure TjdxDrawer.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxDrawer.Set_shading(const Value: boolean);
begin
  Fshading := Value;
end;

procedure TjdxDrawer.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxDrawer.Set_template(const Value: JSValue);
begin
  Ftemplate := Value;
end;

procedure TjdxDrawer.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxDrawer.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxDrawer.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxDrawer.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxDrawer.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxDrawer.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxDrawer.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxDrawer.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

end.
