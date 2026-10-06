unit DevExtreme.ButtonGroup;

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
  TjdxButtonGroup = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FbuttonTemplate: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    Fitems: TJSArray;
    FkeyExpr: JSValue;
    FrtlEnabled: boolean;
    FselectedItemKeys: TJSArray;
    FselectedItems: TJSArray;
    FselectionMode: TdxSingleMultipleOrNone;
    FstylingMode: TdxButtonStyle;
    FtabIndex: integer;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
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
    procedure Set_buttonTemplate(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_items(const value: TJSArray);
    procedure Set_keyExpr(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_selectedItemKeys(const value: TJSArray);
    procedure Set_selectedItems(const value: TJSArray);
    procedure Set_selectionMode(const value: TdxSingleMultipleOrNone);
    procedure Set_stylingMode(const value: TdxButtonStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
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
    property buttonTemplate: JSValue read FbuttonTemplate write Set_buttonTemplate;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property items: TJSArray read Fitems write Set_items;
    property keyExpr: JSValue read FkeyExpr write Set_keyExpr;
    property selectedItemKeys: TJSArray read FselectedItemKeys write Set_selectedItemKeys;
    property selectedItems: TJSArray read FselectedItems write Set_selectedItems;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property selectionMode: TdxSingleMultipleOrNone read FselectionMode write Set_selectionMode default smonSingle;
    property stylingMode: TdxButtonStyle read FstylingMode write Set_stylingMode default bsContained;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
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


constructor TjdxButtonGroup.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FbuttonTemplate := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  Fitems := TJSArray.new;
  FkeyExpr := nil;
  FrtlEnabled := false;
  FselectedItemKeys := TJSArray.new;
  FselectedItems := TJSArray.new;
  FselectionMode := smonSingle;
  FstylingMode := bsContained;
  FtabIndex := 0;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonItemClick := nil;
  FonOptionChanged := nil;
  FonSelectionChanged := nil;
end;

procedure TjdxButtonGroup.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxButtonGroup.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxButtonGroup.Set_buttonTemplate(const Value: JSValue);
begin
  FbuttonTemplate := Value;
end;

procedure TjdxButtonGroup.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxButtonGroup.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxButtonGroup.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxButtonGroup.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxButtonGroup.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxButtonGroup.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxButtonGroup.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
end;

procedure TjdxButtonGroup.Set_keyExpr(const Value: JSValue);
begin
  FkeyExpr := Value;
end;

procedure TjdxButtonGroup.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxButtonGroup.Set_selectedItemKeys(const Value: TJSArray);
begin
  FselectedItemKeys := Value;
end;

procedure TjdxButtonGroup.Set_selectedItems(const Value: TJSArray);
begin
  FselectedItems := Value;
end;

procedure TjdxButtonGroup.Set_selectionMode(const Value: TdxSingleMultipleOrNone);
begin
  FselectionMode := Value;
end;

procedure TjdxButtonGroup.Set_stylingMode(const Value: TdxButtonStyle);
begin
  FstylingMode := Value;
end;

procedure TjdxButtonGroup.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxButtonGroup.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxButtonGroup.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxButtonGroup.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxButtonGroup.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxButtonGroup.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxButtonGroup.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxButtonGroup.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxButtonGroup.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
end;

procedure TjdxButtonGroup.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxButtonGroup.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
end;

end.
