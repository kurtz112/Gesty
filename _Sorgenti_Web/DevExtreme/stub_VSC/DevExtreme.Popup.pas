unit DevExtreme.Popup;

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
  TjdxPopup = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fanimation: TJSObject;
    Fcontainer: JSValue;
    FcontentTemplate: JSValue;
    FcopyRootClassesToWrapper: JSValue;
    FdeferRendering: boolean;
    Fdisabled: boolean;
    FdragAndResizeArea: JSValue;
    FdragEnabled: boolean;
    FdragOutsideBoundary: boolean;
    FelementAttr: TJSObject;
    FenableBodyScroll: boolean;
    FfocusStateEnabled: boolean;
    FfullScreen: boolean;
    Fheight_: JSValue;
    FhideOnOutsideClick: JSValue;
    FhideOnParentScroll: boolean;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FmaxHeight: JSValue;
    FmaxWidth: JSValue;
    FminHeight: JSValue;
    FminWidth: JSValue;
    Fposition: JSValue;
    FresizeEnabled: boolean;
    FrestorePosition: boolean;
    FrtlEnabled: boolean;
    Fshading: boolean;
    FshadingColor: string;
    FshowCloseButton: boolean;
    FshowTitle: boolean;
    FtabIndex: integer;
    Ftitle: string;
    FtitleTemplate: JSValue;
    FtoolbarItems: TJSArray;
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
    FonResize: TdxEventHandler;
    FonResizeEnd: TdxEventHandler;
    FonResizeStart: TdxEventHandler;
    FonShowing: TdxEventHandler;
    FonShown: TdxEventHandler;
    FonTitleRendered: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_animation(const value: TJSObject);
    procedure Set_container(const value: JSValue);
    procedure Set_contentTemplate(const value: JSValue);
    procedure Set_copyRootClassesToWrapper(const value: JSValue);
    procedure Set_deferRendering(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_dragAndResizeArea(const value: JSValue);
    procedure Set_dragEnabled(const value: boolean);
    procedure Set_dragOutsideBoundary(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_enableBodyScroll(const value: boolean);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_fullScreen(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hideOnOutsideClick(const value: JSValue);
    procedure Set_hideOnParentScroll(const value: boolean);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_maxHeight(const value: JSValue);
    procedure Set_maxWidth(const value: JSValue);
    procedure Set_minHeight(const value: JSValue);
    procedure Set_minWidth(const value: JSValue);
    procedure Set_position(const value: JSValue);
    procedure Set_resizeEnabled(const value: boolean);
    procedure Set_restorePosition(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_shading(const value: boolean);
    procedure Set_shadingColor(const value: string);
    procedure Set_showCloseButton(const value: boolean);
    procedure Set_showTitle(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_title(const value: string);
    procedure Set_titleTemplate(const value: JSValue);
    procedure Set_toolbarItems(const value: TJSArray);
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
    procedure Set_onResize(const value: TdxEventHandler);
    procedure Set_onResizeEnd(const value: TdxEventHandler);
    procedure Set_onResizeStart(const value: TdxEventHandler);
    procedure Set_onShowing(const value: TdxEventHandler);
    procedure Set_onShown(const value: TdxEventHandler);
    procedure Set_onTitleRendered(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property animation: TJSObject read Fanimation write Set_animation;
    property container: JSValue read Fcontainer write Set_container;
    property contentTemplate: JSValue read FcontentTemplate write Set_contentTemplate;
    property copyRootClassesToWrapper: JSValue read FcopyRootClassesToWrapper write Set_copyRootClassesToWrapper;
    property dragAndResizeArea: JSValue read FdragAndResizeArea write Set_dragAndResizeArea;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property hideOnOutsideClick: JSValue read FhideOnOutsideClick write Set_hideOnOutsideClick;
    property maxHeight: JSValue read FmaxHeight write Set_maxHeight;
    property maxWidth: JSValue read FmaxWidth write Set_maxWidth;
    property minHeight: JSValue read FminHeight write Set_minHeight;
    property minWidth: JSValue read FminWidth write Set_minWidth;
    property position: JSValue read Fposition write Set_position;
    property titleTemplate: JSValue read FtitleTemplate write Set_titleTemplate;
    property toolbarItems: TJSArray read FtoolbarItems write Set_toolbarItems;
    property width_: JSValue read Fwidth_ write Set_width_;
    property wrapperAttr: JSValue read FwrapperAttr write Set_wrapperAttr;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property deferRendering: boolean read FdeferRendering write Set_deferRendering default true;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property dragEnabled: boolean read FdragEnabled write Set_dragEnabled;
    property dragOutsideBoundary: boolean read FdragOutsideBoundary write Set_dragOutsideBoundary default false;
    property enableBodyScroll: boolean read FenableBodyScroll write Set_enableBodyScroll default true;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property fullScreen: boolean read FfullScreen write Set_fullScreen default false;
    property hideOnParentScroll: boolean read FhideOnParentScroll write Set_hideOnParentScroll default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property resizeEnabled: boolean read FresizeEnabled write Set_resizeEnabled default false;
    property restorePosition: boolean read FrestorePosition write Set_restorePosition default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property shading: boolean read Fshading write Set_shading default true;
    property shadingColor: string read FshadingColor write Set_shadingColor;
    property showCloseButton: boolean read FshowCloseButton write Set_showCloseButton;
    property showTitle: boolean read FshowTitle write Set_showTitle default true;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property title: string read Ftitle write Set_title;
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
    property onResize: TdxEventHandler read FonResize write Set_onResize;
    property onResizeEnd: TdxEventHandler read FonResizeEnd write Set_onResizeEnd;
    property onResizeStart: TdxEventHandler read FonResizeStart write Set_onResizeStart;
    property onShowing: TdxEventHandler read FonShowing write Set_onShowing;
    property onShown: TdxEventHandler read FonShown write Set_onShown;
    property onTitleRendered: TdxEventHandler read FonTitleRendered write Set_onTitleRendered;
  end;

implementation


constructor TjdxPopup.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  Fanimation := TJSObject.new;
  Fcontainer := nil;
  FcontentTemplate := nil;
  FcopyRootClassesToWrapper := nil;
  FdeferRendering := true;
  Fdisabled := false;
  FdragAndResizeArea := nil;
  FdragEnabled := false;
  FdragOutsideBoundary := false;
  FelementAttr := TJSObject.new;
  FenableBodyScroll := true;
  FfocusStateEnabled := false;
  FfullScreen := false;
  Fheight_ := nil;
  FhideOnOutsideClick := nil;
  FhideOnParentScroll := false;
  Fhint := '';
  FhoverStateEnabled := false;
  FmaxHeight := nil;
  FmaxWidth := nil;
  FminHeight := nil;
  FminWidth := nil;
  Fposition := nil;
  FresizeEnabled := false;
  FrestorePosition := true;
  FrtlEnabled := false;
  Fshading := true;
  FshadingColor := '';
  FshowCloseButton := false;
  FshowTitle := true;
  FtabIndex := 0;
  Ftitle := '';
  FtitleTemplate := nil;
  FtoolbarItems := TJSArray.new;
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
  FonResize := nil;
  FonResizeEnd := nil;
  FonResizeStart := nil;
  FonShowing := nil;
  FonShown := nil;
  FonTitleRendered := nil;
end;

procedure TjdxPopup.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxPopup.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxPopup.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
end;

procedure TjdxPopup.Set_container(const Value: JSValue);
begin
  Fcontainer := Value;
end;

procedure TjdxPopup.Set_contentTemplate(const Value: JSValue);
begin
  FcontentTemplate := Value;
end;

procedure TjdxPopup.Set_copyRootClassesToWrapper(const Value: JSValue);
begin
  FcopyRootClassesToWrapper := Value;
end;

procedure TjdxPopup.Set_deferRendering(const Value: boolean);
begin
  FdeferRendering := Value;
end;

procedure TjdxPopup.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxPopup.Set_dragAndResizeArea(const Value: JSValue);
begin
  FdragAndResizeArea := Value;
end;

procedure TjdxPopup.Set_dragEnabled(const Value: boolean);
begin
  FdragEnabled := Value;
end;

procedure TjdxPopup.Set_dragOutsideBoundary(const Value: boolean);
begin
  FdragOutsideBoundary := Value;
end;

procedure TjdxPopup.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxPopup.Set_enableBodyScroll(const Value: boolean);
begin
  FenableBodyScroll := Value;
end;

procedure TjdxPopup.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxPopup.Set_fullScreen(const Value: boolean);
begin
  FfullScreen := Value;
end;

procedure TjdxPopup.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxPopup.Set_hideOnOutsideClick(const Value: JSValue);
begin
  FhideOnOutsideClick := Value;
end;

procedure TjdxPopup.Set_hideOnParentScroll(const Value: boolean);
begin
  FhideOnParentScroll := Value;
end;

procedure TjdxPopup.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxPopup.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxPopup.Set_maxHeight(const Value: JSValue);
begin
  FmaxHeight := Value;
end;

procedure TjdxPopup.Set_maxWidth(const Value: JSValue);
begin
  FmaxWidth := Value;
end;

procedure TjdxPopup.Set_minHeight(const Value: JSValue);
begin
  FminHeight := Value;
end;

procedure TjdxPopup.Set_minWidth(const Value: JSValue);
begin
  FminWidth := Value;
end;

procedure TjdxPopup.Set_position(const Value: JSValue);
begin
  Fposition := Value;
end;

procedure TjdxPopup.Set_resizeEnabled(const Value: boolean);
begin
  FresizeEnabled := Value;
end;

procedure TjdxPopup.Set_restorePosition(const Value: boolean);
begin
  FrestorePosition := Value;
end;

procedure TjdxPopup.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxPopup.Set_shading(const Value: boolean);
begin
  Fshading := Value;
end;

procedure TjdxPopup.Set_shadingColor(const Value: string);
begin
  FshadingColor := Value;
end;

procedure TjdxPopup.Set_showCloseButton(const Value: boolean);
begin
  FshowCloseButton := Value;
end;

procedure TjdxPopup.Set_showTitle(const Value: boolean);
begin
  FshowTitle := Value;
end;

procedure TjdxPopup.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxPopup.Set_title(const Value: string);
begin
  Ftitle := Value;
end;

procedure TjdxPopup.Set_titleTemplate(const Value: JSValue);
begin
  FtitleTemplate := Value;
end;

procedure TjdxPopup.Set_toolbarItems(const Value: TJSArray);
begin
  FtoolbarItems := Value;
end;

procedure TjdxPopup.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxPopup.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxPopup.Set_wrapperAttr(const Value: JSValue);
begin
  FwrapperAttr := Value;
end;

procedure TjdxPopup.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxPopup.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxPopup.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxPopup.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxPopup.Set_onHidden(const Value: TdxEventHandler);
begin
  FonHidden := Value;
end;

procedure TjdxPopup.Set_onHiding(const Value: TdxEventHandler);
begin
  FonHiding := Value;
end;

procedure TjdxPopup.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxPopup.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxPopup.Set_onResize(const Value: TdxEventHandler);
begin
  FonResize := Value;
end;

procedure TjdxPopup.Set_onResizeEnd(const Value: TdxEventHandler);
begin
  FonResizeEnd := Value;
end;

procedure TjdxPopup.Set_onResizeStart(const Value: TdxEventHandler);
begin
  FonResizeStart := Value;
end;

procedure TjdxPopup.Set_onShowing(const Value: TdxEventHandler);
begin
  FonShowing := Value;
end;

procedure TjdxPopup.Set_onShown(const Value: TdxEventHandler);
begin
  FonShown := Value;
end;

procedure TjdxPopup.Set_onTitleRendered(const Value: TdxEventHandler);
begin
  FonTitleRendered := Value;
end;

end.
