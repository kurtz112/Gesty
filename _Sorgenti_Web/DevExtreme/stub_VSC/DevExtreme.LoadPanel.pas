unit DevExtreme.LoadPanel;

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
  TjdxLoadPanel = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fanimation: TJSObject;
    Fcontainer: JSValue;
    FcontentTemplate: JSValue;
    FcopyRootClassesToWrapper: JSValue;
    FdeferRendering: boolean;
    Fdelay: integer;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    FhideOnOutsideClick: JSValue;
    FhideOnParentScroll: boolean;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FindicatorSrc: string;
    FmaxHeight: JSValue;
    FmaxWidth: JSValue;
    Fmessage: string;
    FminHeight: JSValue;
    FminWidth: JSValue;
    Fposition: JSValue;
    FrtlEnabled: boolean;
    Fshading: boolean;
    FshadingColor: string;
    FshowIndicator: boolean;
    FshowPane: boolean;
    FtabIndex: integer;
    Fvisible: boolean;
    Fwidth_: JSValue;
    FwrapperAttr: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonHidden: TdxEventHandler;
    FonHiding: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonShowing: TdxEventHandler;
    FonShown: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_animation(const value: TJSObject);
    procedure Set_container(const value: JSValue);
    procedure Set_contentTemplate(const value: JSValue);
    procedure Set_copyRootClassesToWrapper(const value: JSValue);
    procedure Set_deferRendering(const value: boolean);
    procedure Set_delay(const value: integer);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hideOnOutsideClick(const value: JSValue);
    procedure Set_hideOnParentScroll(const value: boolean);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_indicatorSrc(const value: string);
    procedure Set_maxHeight(const value: JSValue);
    procedure Set_maxWidth(const value: JSValue);
    procedure Set_message(const value: string);
    procedure Set_minHeight(const value: JSValue);
    procedure Set_minWidth(const value: JSValue);
    procedure Set_position(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_shading(const value: boolean);
    procedure Set_shadingColor(const value: string);
    procedure Set_showIndicator(const value: boolean);
    procedure Set_showPane(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
    procedure Set_wrapperAttr(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onHidden(const value: TdxEventHandler);
    procedure Set_onHiding(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onShowing(const value: TdxEventHandler);
    procedure Set_onShown(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property animation: TJSObject read Fanimation write Set_animation;
    property container: JSValue read Fcontainer write Set_container;
    property contentTemplate: JSValue read FcontentTemplate write Set_contentTemplate;
    property copyRootClassesToWrapper: JSValue read FcopyRootClassesToWrapper write Set_copyRootClassesToWrapper;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property hideOnOutsideClick: JSValue read FhideOnOutsideClick write Set_hideOnOutsideClick;
    property maxHeight: JSValue read FmaxHeight write Set_maxHeight;
    property maxWidth: JSValue read FmaxWidth write Set_maxWidth;
    property minHeight: JSValue read FminHeight write Set_minHeight;
    property minWidth: JSValue read FminWidth write Set_minWidth;
    property position: JSValue read Fposition write Set_position;
    property width_: JSValue read Fwidth_ write Set_width_;
    property wrapperAttr: JSValue read FwrapperAttr write Set_wrapperAttr;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property deferRendering: boolean read FdeferRendering write Set_deferRendering default true;
    property delay: integer read Fdelay write Set_delay;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hideOnParentScroll: boolean read FhideOnParentScroll write Set_hideOnParentScroll default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property indicatorSrc: string read FindicatorSrc write Set_indicatorSrc;
    property message: string read Fmessage write Set_message;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property shading: boolean read Fshading write Set_shading default true;
    property shadingColor: string read FshadingColor write Set_shadingColor;
    property showIndicator: boolean read FshowIndicator write Set_showIndicator default true;
    property showPane: boolean read FshowPane write Set_showPane default true;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onHidden: TdxEventHandler read FonHidden write Set_onHidden;
    property onHiding: TdxEventHandler read FonHiding write Set_onHiding;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onShowing: TdxEventHandler read FonShowing write Set_onShowing;
    property onShown: TdxEventHandler read FonShown write Set_onShown;
  end;

implementation


constructor TjdxLoadPanel.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  Fanimation := TJSObject.new;
  Fcontainer := nil;
  FcontentTemplate := nil;
  FcopyRootClassesToWrapper := nil;
  FdeferRendering := true;
  Fdelay := 0;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  FhideOnOutsideClick := nil;
  FhideOnParentScroll := false;
  Fhint := '';
  FhoverStateEnabled := false;
  FindicatorSrc := '';
  FmaxHeight := nil;
  FmaxWidth := nil;
  Fmessage := '';
  FminHeight := nil;
  FminWidth := nil;
  Fposition := nil;
  FrtlEnabled := false;
  Fshading := true;
  FshadingColor := '';
  FshowIndicator := true;
  FshowPane := true;
  FtabIndex := 0;
  Fvisible := true;
  Fwidth_ := nil;
  FwrapperAttr := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonHidden := nil;
  FonHiding := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonShowing := nil;
  FonShown := nil;
end;

procedure TjdxLoadPanel.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxLoadPanel.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxLoadPanel.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
end;

procedure TjdxLoadPanel.Set_container(const Value: JSValue);
begin
  Fcontainer := Value;
end;

procedure TjdxLoadPanel.Set_contentTemplate(const Value: JSValue);
begin
  FcontentTemplate := Value;
end;

procedure TjdxLoadPanel.Set_copyRootClassesToWrapper(const Value: JSValue);
begin
  FcopyRootClassesToWrapper := Value;
end;

procedure TjdxLoadPanel.Set_deferRendering(const Value: boolean);
begin
  FdeferRendering := Value;
end;

procedure TjdxLoadPanel.Set_delay(const Value: integer);
begin
  Fdelay := Value;
end;

procedure TjdxLoadPanel.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxLoadPanel.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxLoadPanel.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxLoadPanel.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxLoadPanel.Set_hideOnOutsideClick(const Value: JSValue);
begin
  FhideOnOutsideClick := Value;
end;

procedure TjdxLoadPanel.Set_hideOnParentScroll(const Value: boolean);
begin
  FhideOnParentScroll := Value;
end;

procedure TjdxLoadPanel.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxLoadPanel.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxLoadPanel.Set_indicatorSrc(const Value: string);
begin
  FindicatorSrc := Value;
end;

procedure TjdxLoadPanel.Set_maxHeight(const Value: JSValue);
begin
  FmaxHeight := Value;
end;

procedure TjdxLoadPanel.Set_maxWidth(const Value: JSValue);
begin
  FmaxWidth := Value;
end;

procedure TjdxLoadPanel.Set_message(const Value: string);
begin
  Fmessage := Value;
end;

procedure TjdxLoadPanel.Set_minHeight(const Value: JSValue);
begin
  FminHeight := Value;
end;

procedure TjdxLoadPanel.Set_minWidth(const Value: JSValue);
begin
  FminWidth := Value;
end;

procedure TjdxLoadPanel.Set_position(const Value: JSValue);
begin
  Fposition := Value;
end;

procedure TjdxLoadPanel.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxLoadPanel.Set_shading(const Value: boolean);
begin
  Fshading := Value;
end;

procedure TjdxLoadPanel.Set_shadingColor(const Value: string);
begin
  FshadingColor := Value;
end;

procedure TjdxLoadPanel.Set_showIndicator(const Value: boolean);
begin
  FshowIndicator := Value;
end;

procedure TjdxLoadPanel.Set_showPane(const Value: boolean);
begin
  FshowPane := Value;
end;

procedure TjdxLoadPanel.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxLoadPanel.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxLoadPanel.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxLoadPanel.Set_wrapperAttr(const Value: JSValue);
begin
  FwrapperAttr := Value;
end;

procedure TjdxLoadPanel.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxLoadPanel.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxLoadPanel.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxLoadPanel.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxLoadPanel.Set_onHidden(const Value: TdxEventHandler);
begin
  FonHidden := Value;
end;

procedure TjdxLoadPanel.Set_onHiding(const Value: TdxEventHandler);
begin
  FonHiding := Value;
end;

procedure TjdxLoadPanel.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxLoadPanel.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxLoadPanel.Set_onShowing(const Value: TdxEventHandler);
begin
  FonShowing := Value;
end;

procedure TjdxLoadPanel.Set_onShown(const Value: TdxEventHandler);
begin
  FonShown := Value;
end;

end.
