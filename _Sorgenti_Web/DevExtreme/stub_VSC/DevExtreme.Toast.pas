unit DevExtreme.Toast;

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
  TjdxToast = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fanimation: TJSObject;
    FcloseOnClick: boolean;
    FcloseOnSwipe: boolean;
    FcontentTemplate: JSValue;
    FcopyRootClassesToWrapper: JSValue;
    FdeferRendering: boolean;
    Fdisabled: boolean;
    FdisplayTime: integer;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    FhideOnOutsideClick: JSValue;
    FhideOnParentScroll: boolean;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FmaxHeight: JSValue;
    FmaxWidth: JSValue;
    Fmessage: string;
    FminHeight: JSValue;
    FminWidth: JSValue;
    Fposition: JSValue;
    FrtlEnabled: boolean;
    Fshading: boolean;
    FshadingColor: string;
    FtabIndex: integer;
    Ftype_: TdxToastType;
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
    procedure Set_closeOnClick(const value: boolean);
    procedure Set_closeOnSwipe(const value: boolean);
    procedure Set_contentTemplate(const value: JSValue);
    procedure Set_copyRootClassesToWrapper(const value: JSValue);
    procedure Set_deferRendering(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_displayTime(const value: integer);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hideOnOutsideClick(const value: JSValue);
    procedure Set_hideOnParentScroll(const value: boolean);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_maxHeight(const value: JSValue);
    procedure Set_maxWidth(const value: JSValue);
    procedure Set_message(const value: string);
    procedure Set_minHeight(const value: JSValue);
    procedure Set_minWidth(const value: JSValue);
    procedure Set_position(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_shading(const value: boolean);
    procedure Set_shadingColor(const value: string);
    procedure Set_tabIndex(const value: integer);
    procedure Set_type_(const value: TdxToastType);
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
    property closeOnClick: boolean read FcloseOnClick write Set_closeOnClick default false;
    property closeOnSwipe: boolean read FcloseOnSwipe write Set_closeOnSwipe default true;
    property deferRendering: boolean read FdeferRendering write Set_deferRendering default true;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property displayTime: integer read FdisplayTime write Set_displayTime;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hideOnParentScroll: boolean read FhideOnParentScroll write Set_hideOnParentScroll default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property message: string read Fmessage write Set_message;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property shading: boolean read Fshading write Set_shading default true;
    property shadingColor: string read FshadingColor write Set_shadingColor;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property type_: TdxToastType read Ftype_ write Set_type_ default ttInfo;
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


constructor TjdxToast.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  Fanimation := TJSObject.new;
  FcloseOnClick := false;
  FcloseOnSwipe := true;
  FcontentTemplate := nil;
  FcopyRootClassesToWrapper := nil;
  FdeferRendering := true;
  Fdisabled := false;
  FdisplayTime := 0;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  FhideOnOutsideClick := nil;
  FhideOnParentScroll := false;
  Fhint := '';
  FhoverStateEnabled := false;
  FmaxHeight := nil;
  FmaxWidth := nil;
  Fmessage := '';
  FminHeight := nil;
  FminWidth := nil;
  Fposition := nil;
  FrtlEnabled := false;
  Fshading := true;
  FshadingColor := '';
  FtabIndex := 0;
  Ftype_ := ttInfo;
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

procedure TjdxToast.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxToast.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxToast.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
end;

procedure TjdxToast.Set_closeOnClick(const Value: boolean);
begin
  FcloseOnClick := Value;
end;

procedure TjdxToast.Set_closeOnSwipe(const Value: boolean);
begin
  FcloseOnSwipe := Value;
end;

procedure TjdxToast.Set_contentTemplate(const Value: JSValue);
begin
  FcontentTemplate := Value;
end;

procedure TjdxToast.Set_copyRootClassesToWrapper(const Value: JSValue);
begin
  FcopyRootClassesToWrapper := Value;
end;

procedure TjdxToast.Set_deferRendering(const Value: boolean);
begin
  FdeferRendering := Value;
end;

procedure TjdxToast.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxToast.Set_displayTime(const Value: integer);
begin
  FdisplayTime := Value;
end;

procedure TjdxToast.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxToast.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxToast.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxToast.Set_hideOnOutsideClick(const Value: JSValue);
begin
  FhideOnOutsideClick := Value;
end;

procedure TjdxToast.Set_hideOnParentScroll(const Value: boolean);
begin
  FhideOnParentScroll := Value;
end;

procedure TjdxToast.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxToast.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxToast.Set_maxHeight(const Value: JSValue);
begin
  FmaxHeight := Value;
end;

procedure TjdxToast.Set_maxWidth(const Value: JSValue);
begin
  FmaxWidth := Value;
end;

procedure TjdxToast.Set_message(const Value: string);
begin
  Fmessage := Value;
end;

procedure TjdxToast.Set_minHeight(const Value: JSValue);
begin
  FminHeight := Value;
end;

procedure TjdxToast.Set_minWidth(const Value: JSValue);
begin
  FminWidth := Value;
end;

procedure TjdxToast.Set_position(const Value: JSValue);
begin
  Fposition := Value;
end;

procedure TjdxToast.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxToast.Set_shading(const Value: boolean);
begin
  Fshading := Value;
end;

procedure TjdxToast.Set_shadingColor(const Value: string);
begin
  FshadingColor := Value;
end;

procedure TjdxToast.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxToast.Set_type_(const Value: TdxToastType);
begin
  Ftype_ := Value;
end;

procedure TjdxToast.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxToast.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxToast.Set_wrapperAttr(const Value: JSValue);
begin
  FwrapperAttr := Value;
end;

procedure TjdxToast.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxToast.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxToast.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxToast.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxToast.Set_onHidden(const Value: TdxEventHandler);
begin
  FonHidden := Value;
end;

procedure TjdxToast.Set_onHiding(const Value: TdxEventHandler);
begin
  FonHiding := Value;
end;

procedure TjdxToast.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxToast.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxToast.Set_onShowing(const Value: TdxEventHandler);
begin
  FonShowing := Value;
end;

procedure TjdxToast.Set_onShown(const Value: TdxEventHandler);
begin
  FonShown := Value;
end;

end.
