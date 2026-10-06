unit DevExtreme.DropDownButton;

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
  TjdxDropDownButton = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FdataSource: JSValue;
    FdeferRendering: boolean;
    Fdisabled: boolean;
    FdisplayExpr: JSValue;
    FdropDownContentTemplate: JSValue;
    FdropDownOptions: JSValue;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    Ficon: string;
    Fitems: TJSArray;
    FitemTemplate: JSValue;
    FkeyExpr: string;
    FnoDataText: string;
    Fopened: boolean;
    FrtlEnabled: boolean;
    FselectedItem: JSValue;
    FselectedItemKey: JSValue;
    FshowArrowIcon: boolean;
    FsplitButton: boolean;
    FstylingMode: TdxButtonStyle;
    FtabIndex: integer;
    Ftext: string;
    FuseItemTextAsTitle: boolean;
    FuseSelectMode: boolean;
    Fvisible: boolean;
    Fwidth_: JSValue;
    FwrapItemText: boolean;
  private
    FonButtonClick: TdxEventHandler;
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonItemClick: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_deferRendering(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_displayExpr(const value: JSValue);
    procedure Set_dropDownContentTemplate(const value: JSValue);
    procedure Set_dropDownOptions(const value: JSValue);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_icon(const value: string);
    procedure Set_items(const value: TJSArray);
    procedure Set_itemTemplate(const value: JSValue);
    procedure Set_keyExpr(const value: string);
    procedure Set_noDataText(const value: string);
    procedure Set_opened(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_selectedItemKey(const value: JSValue);
    procedure Set_showArrowIcon(const value: boolean);
    procedure Set_splitButton(const value: boolean);
    procedure Set_stylingMode(const value: TdxButtonStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_text(const value: string);
    procedure Set_useItemTextAsTitle(const value: boolean);
    procedure Set_useSelectMode(const value: boolean);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
    procedure Set_wrapItemText(const value: boolean);
  private
    procedure Set_onButtonClick(const value: TdxEventHandler);
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onItemClick(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property displayExpr: JSValue read FdisplayExpr write Set_displayExpr;
    property dropDownContentTemplate: JSValue read FdropDownContentTemplate write Set_dropDownContentTemplate;
    property dropDownOptions: JSValue read FdropDownOptions write Set_dropDownOptions;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property items: TJSArray read Fitems write Set_items;
    property itemTemplate: JSValue read FitemTemplate write Set_itemTemplate;
    property selectedItem: JSValue read FselectedItem;
    property selectedItemKey: JSValue read FselectedItemKey write Set_selectedItemKey;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property deferRendering: boolean read FdeferRendering write Set_deferRendering default true;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property icon: string read Ficon write Set_icon;
    property keyExpr: string read FkeyExpr write Set_keyExpr;
    property noDataText: string read FnoDataText write Set_noDataText;
    property opened: boolean read Fopened write Set_opened default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showArrowIcon: boolean read FshowArrowIcon write Set_showArrowIcon default true;
    property splitButton: boolean read FsplitButton write Set_splitButton default false;
    property stylingMode: TdxButtonStyle read FstylingMode write Set_stylingMode default bsOutlined;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property text: string read Ftext write Set_text;
    property useItemTextAsTitle: boolean read FuseItemTextAsTitle write Set_useItemTextAsTitle default true;
    property useSelectMode: boolean read FuseSelectMode write Set_useSelectMode default false;
    property visible: boolean read Fvisible write Set_visible default true;
    property wrapItemText: boolean read FwrapItemText write Set_wrapItemText default false;
  published
    property onButtonClick: TdxEventHandler read FonButtonClick write Set_onButtonClick;
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onItemClick: TdxEventHandler read FonItemClick write Set_onItemClick;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
  end;

implementation


constructor TjdxDropDownButton.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FdataSource := nil;
  FdeferRendering := true;
  Fdisabled := false;
  FdisplayExpr := nil;
  FdropDownContentTemplate := nil;
  FdropDownOptions := nil;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  Ficon := '';
  Fitems := TJSArray.new;
  FitemTemplate := nil;
  FkeyExpr := '';
  FnoDataText := '';
  Fopened := false;
  FrtlEnabled := false;
  FselectedItem := nil;
  FselectedItemKey := nil;
  FshowArrowIcon := true;
  FsplitButton := false;
  FstylingMode := bsOutlined;
  FtabIndex := 0;
  Ftext := '';
  FuseItemTextAsTitle := true;
  FuseSelectMode := false;
  Fvisible := true;
  Fwidth_ := nil;
  FwrapItemText := false;

  FonButtonClick := nil;
  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonItemClick := nil;
  FonOptionChanged := nil;
  FonSelectionChanged := nil;
end;

procedure TjdxDropDownButton.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxDropDownButton.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxDropDownButton.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxDropDownButton.Set_deferRendering(const Value: boolean);
begin
  FdeferRendering := Value;
end;

procedure TjdxDropDownButton.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxDropDownButton.Set_displayExpr(const Value: JSValue);
begin
  FdisplayExpr := Value;
end;

procedure TjdxDropDownButton.Set_dropDownContentTemplate(const Value: JSValue);
begin
  FdropDownContentTemplate := Value;
end;

procedure TjdxDropDownButton.Set_dropDownOptions(const Value: JSValue);
begin
  FdropDownOptions := Value;
end;

procedure TjdxDropDownButton.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxDropDownButton.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxDropDownButton.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxDropDownButton.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxDropDownButton.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxDropDownButton.Set_icon(const Value: string);
begin
  Ficon := Value;
end;

procedure TjdxDropDownButton.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
end;

procedure TjdxDropDownButton.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
end;

procedure TjdxDropDownButton.Set_keyExpr(const Value: string);
begin
  FkeyExpr := Value;
end;

procedure TjdxDropDownButton.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
end;

procedure TjdxDropDownButton.Set_opened(const Value: boolean);
begin
  Fopened := Value;
end;

procedure TjdxDropDownButton.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxDropDownButton.Set_selectedItemKey(const Value: JSValue);
begin
  FselectedItemKey := Value;
end;

procedure TjdxDropDownButton.Set_showArrowIcon(const Value: boolean);
begin
  FshowArrowIcon := Value;
end;

procedure TjdxDropDownButton.Set_splitButton(const Value: boolean);
begin
  FsplitButton := Value;
end;

procedure TjdxDropDownButton.Set_stylingMode(const Value: TdxButtonStyle);
begin
  FstylingMode := Value;
end;

procedure TjdxDropDownButton.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxDropDownButton.Set_text(const Value: string);
begin
  Ftext := Value;
end;

procedure TjdxDropDownButton.Set_useItemTextAsTitle(const Value: boolean);
begin
  FuseItemTextAsTitle := Value;
end;

procedure TjdxDropDownButton.Set_useSelectMode(const Value: boolean);
begin
  FuseSelectMode := Value;
end;

procedure TjdxDropDownButton.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxDropDownButton.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxDropDownButton.Set_wrapItemText(const Value: boolean);
begin
  FwrapItemText := Value;
end;

procedure TjdxDropDownButton.Set_onButtonClick(const Value: TdxEventHandler);
begin
  FonButtonClick := Value;
end;

procedure TjdxDropDownButton.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxDropDownButton.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxDropDownButton.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxDropDownButton.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxDropDownButton.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxDropDownButton.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
end;

procedure TjdxDropDownButton.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxDropDownButton.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
end;

end.
