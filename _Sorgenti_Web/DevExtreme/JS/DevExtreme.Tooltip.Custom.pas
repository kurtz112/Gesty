unit DevExtreme.Tooltip.Custom;

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
  DevExtreme.Tooltip.JS,
  DevExtreme.Types;

type
  TjdxCustomTooltip = class(TjdxCustomControl)
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
    FhideEvent: TJSObject;
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
    FshowEvent: TJSObject;
    FshowTitle: boolean;
    FtabIndex: integer;
    Ftarget: JSValue;
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
    procedure Set_hideEvent(const value: TJSObject);
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
    procedure Set_showEvent(const value: TJSObject);
    procedure Set_showTitle(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_target(const value: JSValue);
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
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxTooltip; assembler;
    function instance: TdxTooltip; assembler;
  public
    procedure beginUpdate(); assembler;
    function content(): TJSElement; assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler; overload;
    function hide(): TJSPromise; assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure registerKeyHandler(); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler; overload;
    procedure repaint(); assembler; overload;
    procedure resetOption(optionName: string); assembler;
    function show(target: JSValue): TJSPromise; assembler; overload;
    function show(): TJSPromise; assembler; overload;
    function toggle(showing: boolean): TJSPromise; assembler;
  public
    property animation: TJSObject read Fanimation write Set_animation;
    property container: JSValue read Fcontainer write Set_container;
    property contentTemplate: JSValue read FcontentTemplate write Set_contentTemplate;
    property copyRootClassesToWrapper: JSValue read FcopyRootClassesToWrapper write Set_copyRootClassesToWrapper;
    property dragAndResizeArea: JSValue read FdragAndResizeArea write Set_dragAndResizeArea;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property hideEvent: TJSObject read FhideEvent write Set_hideEvent;
    property hideOnOutsideClick: JSValue read FhideOnOutsideClick write Set_hideOnOutsideClick;
    property maxHeight: JSValue read FmaxHeight write Set_maxHeight;
    property maxWidth: JSValue read FmaxWidth write Set_maxWidth;
    property minHeight: JSValue read FminHeight write Set_minHeight;
    property minWidth: JSValue read FminWidth write Set_minWidth;
    property position: JSValue read Fposition write Set_position;
    property showEvent: TJSObject read FshowEvent write Set_showEvent;
    property target: JSValue read Ftarget write Set_target;
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


procedure TjdxCustomTooltip.CreateInitialize;
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
  FhideEvent := TJSObject.new;
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
  FshowEvent := TJSObject.new;
  FshowTitle := true;
  FtabIndex := 0;
  Ftarget := nil;
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
procedure TjdxCustomTooltip.InitJQuery;
var
  id: string;
  options: TJSObject;
begin
  inherited;

  if Assigned(ElementHandle) then
  begin
    id := GetJQID;
    options := TJSObject.new;

    asm
      $(id).dxTooltip(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomTooltip.getInstance(element: TJSObject): TdxTooltip;
asm
  return DevExpress.viz.dxTooltip.getInstance(element);
end;

function TjdxCustomTooltip.instance: TdxTooltip;
asm
  return $(this.GetJQID()).dxTooltip("instance");
end;
procedure TjdxCustomTooltip.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('animation', animation);
    SetOption('container', container);
    SetOption('contentTemplate', contentTemplate);
    SetOption('copyRootClassesToWrapper', copyRootClassesToWrapper);
    SetOption('deferRendering', deferRendering);
    SetOption('disabled', disabled);
    SetOption('dragAndResizeArea', dragAndResizeArea);
    SetOption('dragEnabled', dragEnabled);
    SetOption('dragOutsideBoundary', dragOutsideBoundary);
    SetOption('elementAttr', elementAttr);
    SetOption('enableBodyScroll', enableBodyScroll);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('fullScreen', fullScreen);
    SetOption('height', height_);
    SetOption('hideEvent', hideEvent);
    SetOption('hideOnOutsideClick', hideOnOutsideClick);
    SetOption('hideOnParentScroll', hideOnParentScroll);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('maxHeight', maxHeight);
    SetOption('maxWidth', maxWidth);
    SetOption('minHeight', minHeight);
    SetOption('minWidth', minWidth);
    SetOption('position', position);
    SetOption('resizeEnabled', resizeEnabled);
    SetOption('restorePosition', restorePosition);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('shading', shading);
    SetOption('shadingColor', shadingColor);
    SetOption('showCloseButton', showCloseButton);
    SetOption('showEvent', showEvent);
    SetOption('showTitle', showTitle);
    SetOption('tabIndex', tabIndex);
    SetOption('target', target);
    SetOption('title', title);
    SetOption('titleTemplate', titleTemplate);
    SetOption('toolbarItems', toolbarItems);
    SetOption('visible', visible);
    SetOption('width', width_);
    SetOption('wrapperAttr', wrapperAttr);

    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('hidden', onHidden);
    SetEvent('hiding', onHiding);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('resize', onResize);
    SetEvent('resizeEnd', onResizeEnd);
    SetEvent('resizeStart', onResizeStart);
    SetEvent('showing', onShowing);
    SetEvent('shown', onShown);
    SetEvent('titleRendered', onTitleRendered);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomTooltip.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomTooltip.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomTooltip.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
  SetOption('animation', animation);
end;

procedure TjdxCustomTooltip.Set_container(const Value: JSValue);
begin
  Fcontainer := Value;
  SetOption('container', container);
end;

procedure TjdxCustomTooltip.Set_contentTemplate(const Value: JSValue);
begin
  FcontentTemplate := Value;
  SetOption('contentTemplate', contentTemplate);
end;

procedure TjdxCustomTooltip.Set_copyRootClassesToWrapper(const Value: JSValue);
begin
  FcopyRootClassesToWrapper := Value;
  SetOption('copyRootClassesToWrapper', copyRootClassesToWrapper);
end;

procedure TjdxCustomTooltip.Set_deferRendering(const Value: boolean);
begin
  FdeferRendering := Value;
  SetOption('deferRendering', deferRendering);
end;

procedure TjdxCustomTooltip.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomTooltip.Set_dragAndResizeArea(const Value: JSValue);
begin
  FdragAndResizeArea := Value;
  SetOption('dragAndResizeArea', dragAndResizeArea);
end;

procedure TjdxCustomTooltip.Set_dragEnabled(const Value: boolean);
begin
  FdragEnabled := Value;
  SetOption('dragEnabled', dragEnabled);
end;

procedure TjdxCustomTooltip.Set_dragOutsideBoundary(const Value: boolean);
begin
  FdragOutsideBoundary := Value;
  SetOption('dragOutsideBoundary', dragOutsideBoundary);
end;

procedure TjdxCustomTooltip.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomTooltip.Set_enableBodyScroll(const Value: boolean);
begin
  FenableBodyScroll := Value;
  SetOption('enableBodyScroll', enableBodyScroll);
end;

procedure TjdxCustomTooltip.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomTooltip.Set_fullScreen(const Value: boolean);
begin
  FfullScreen := Value;
  SetOption('fullScreen', fullScreen);
end;

procedure TjdxCustomTooltip.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomTooltip.Set_hideEvent(const Value: TJSObject);
begin
  FhideEvent := Value;
  SetOption('hideEvent', hideEvent);
end;

procedure TjdxCustomTooltip.Set_hideOnOutsideClick(const Value: JSValue);
begin
  FhideOnOutsideClick := Value;
  SetOption('hideOnOutsideClick', hideOnOutsideClick);
end;

procedure TjdxCustomTooltip.Set_hideOnParentScroll(const Value: boolean);
begin
  FhideOnParentScroll := Value;
  SetOption('hideOnParentScroll', hideOnParentScroll);
end;

procedure TjdxCustomTooltip.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomTooltip.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomTooltip.Set_maxHeight(const Value: JSValue);
begin
  FmaxHeight := Value;
  SetOption('maxHeight', maxHeight);
end;

procedure TjdxCustomTooltip.Set_maxWidth(const Value: JSValue);
begin
  FmaxWidth := Value;
  SetOption('maxWidth', maxWidth);
end;

procedure TjdxCustomTooltip.Set_minHeight(const Value: JSValue);
begin
  FminHeight := Value;
  SetOption('minHeight', minHeight);
end;

procedure TjdxCustomTooltip.Set_minWidth(const Value: JSValue);
begin
  FminWidth := Value;
  SetOption('minWidth', minWidth);
end;

procedure TjdxCustomTooltip.Set_position(const Value: JSValue);
begin
  Fposition := Value;
  SetOption('position', position);
end;

procedure TjdxCustomTooltip.Set_resizeEnabled(const Value: boolean);
begin
  FresizeEnabled := Value;
  SetOption('resizeEnabled', resizeEnabled);
end;

procedure TjdxCustomTooltip.Set_restorePosition(const Value: boolean);
begin
  FrestorePosition := Value;
  SetOption('restorePosition', restorePosition);
end;

procedure TjdxCustomTooltip.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomTooltip.Set_shading(const Value: boolean);
begin
  Fshading := Value;
  SetOption('shading', shading);
end;

procedure TjdxCustomTooltip.Set_shadingColor(const Value: string);
begin
  FshadingColor := Value;
  SetOption('shadingColor', shadingColor);
end;

procedure TjdxCustomTooltip.Set_showCloseButton(const Value: boolean);
begin
  FshowCloseButton := Value;
  SetOption('showCloseButton', showCloseButton);
end;

procedure TjdxCustomTooltip.Set_showEvent(const Value: TJSObject);
begin
  FshowEvent := Value;
  SetOption('showEvent', showEvent);
end;

procedure TjdxCustomTooltip.Set_showTitle(const Value: boolean);
begin
  FshowTitle := Value;
  SetOption('showTitle', showTitle);
end;

procedure TjdxCustomTooltip.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomTooltip.Set_target(const Value: JSValue);
begin
  Ftarget := Value;
  SetOption('target', target);
end;

procedure TjdxCustomTooltip.Set_title(const Value: string);
begin
  Ftitle := Value;
  SetOption('title', title);
end;

procedure TjdxCustomTooltip.Set_titleTemplate(const Value: JSValue);
begin
  FtitleTemplate := Value;
  SetOption('titleTemplate', titleTemplate);
end;

procedure TjdxCustomTooltip.Set_toolbarItems(const Value: TJSArray);
begin
  FtoolbarItems := Value;
  SetOption('toolbarItems', toolbarItems);
end;

procedure TjdxCustomTooltip.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomTooltip.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomTooltip.Set_wrapperAttr(const Value: JSValue);
begin
  FwrapperAttr := Value;
  SetOption('wrapperAttr', wrapperAttr);
end;

procedure TjdxCustomTooltip.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomTooltip.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomTooltip.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomTooltip.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomTooltip.Set_onHidden(const Value: TdxEventHandler);
begin
  FonHidden := Value;
  SetEvent('hidden', onHidden);
end;

procedure TjdxCustomTooltip.Set_onHiding(const Value: TdxEventHandler);
begin
  FonHiding := Value;
  SetEvent('hiding', onHiding);
end;

procedure TjdxCustomTooltip.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomTooltip.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomTooltip.Set_onResize(const Value: TdxEventHandler);
begin
  FonResize := Value;
  SetEvent('resize', onResize);
end;

procedure TjdxCustomTooltip.Set_onResizeEnd(const Value: TdxEventHandler);
begin
  FonResizeEnd := Value;
  SetEvent('resizeEnd', onResizeEnd);
end;

procedure TjdxCustomTooltip.Set_onResizeStart(const Value: TdxEventHandler);
begin
  FonResizeStart := Value;
  SetEvent('resizeStart', onResizeStart);
end;

procedure TjdxCustomTooltip.Set_onShowing(const Value: TdxEventHandler);
begin
  FonShowing := Value;
  SetEvent('showing', onShowing);
end;

procedure TjdxCustomTooltip.Set_onShown(const Value: TdxEventHandler);
begin
  FonShown := Value;
  SetEvent('shown', onShown);
end;

procedure TjdxCustomTooltip.Set_onTitleRendered(const Value: TdxEventHandler);
begin
  FonTitleRendered := Value;
  SetEvent('titleRendered', onTitleRendered);
end;

procedure TjdxCustomTooltip.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  _instance.beginUpdate();
end;

function TjdxCustomTooltip.content(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  return _instance.content();
end;

procedure TjdxCustomTooltip.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomTooltip.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomTooltip.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomTooltip.dispose();
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  _instance.dispose();
end;

function TjdxCustomTooltip.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  return _instance.element();
end;

procedure TjdxCustomTooltip.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomTooltip.focus();
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  _instance.focus();
end;

function TjdxCustomTooltip.hide(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  return _instance.hide();
end;

function TjdxCustomTooltip.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomTooltip.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  return _instance.off(eventName);
end;

function TjdxCustomTooltip.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomTooltip.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  return _instance.on(events);
end;

function TjdxCustomTooltip.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  return _instance.option(optionName);
end;

function TjdxCustomTooltip.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  return _instance.option();
end;

procedure TjdxCustomTooltip.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  _instance.option(options);
end;

procedure TjdxCustomTooltip.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomTooltip.registerKeyHandler();
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  _instance.registerKeyHandler();
end;

procedure TjdxCustomTooltip.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomTooltip.repaint();
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  _instance.repaint();
end;

procedure TjdxCustomTooltip.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  _instance.resetOption(optionName);
end;

function TjdxCustomTooltip.show(target: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  return _instance.show(target);
end;

function TjdxCustomTooltip.show(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  return _instance.show();
end;

function TjdxCustomTooltip.toggle(showing: boolean): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTooltip("instance");
  return _instance.toggle(showing);
end;

end.
