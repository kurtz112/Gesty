unit DevExtreme.PivotGridFieldChooser;

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
  TjdxPivotGridFieldChooser = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FallowSearch: boolean;
    FapplyChangesMode: JSValue;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FencodeHtml: boolean;
    FfocusStateEnabled: boolean;
    FheaderFilter: TJSObject;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    Flayout: TdxFieldChooserLayout;
    FrtlEnabled: boolean;
    FsearchTimeout: integer;
    Fstate: JSValue;
    FtabIndex: integer;
    Ftexts: TJSObject;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonContextMenuPreparing: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_allowSearch(const value: boolean);
    procedure Set_applyChangesMode(const value: JSValue);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_encodeHtml(const value: boolean);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_headerFilter(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_layout(const value: TdxFieldChooserLayout);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_searchTimeout(const value: integer);
    procedure Set_state(const value: JSValue);
    procedure Set_tabIndex(const value: integer);
    procedure Set_texts(const value: TJSObject);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onContextMenuPreparing(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property applyChangesMode: JSValue read FapplyChangesMode write Set_applyChangesMode;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property headerFilter: TJSObject read FheaderFilter write Set_headerFilter;
    property height_: JSValue read Fheight_ write Set_height_;
    property state: JSValue read Fstate write Set_state;
    property texts: TJSObject read Ftexts write Set_texts;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property allowSearch: boolean read FallowSearch write Set_allowSearch default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property encodeHtml: boolean read FencodeHtml write Set_encodeHtml default true;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property layout: TdxFieldChooserLayout read Flayout write Set_layout default fcl0;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property searchTimeout: integer read FsearchTimeout write Set_searchTimeout;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onContextMenuPreparing: TdxEventHandler read FonContextMenuPreparing write Set_onContextMenuPreparing;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
  end;

implementation


constructor TjdxPivotGridFieldChooser.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FallowSearch := false;
  FapplyChangesMode := nil;
  FdataSource := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FencodeHtml := true;
  FfocusStateEnabled := false;
  FheaderFilter := TJSObject.new;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  Flayout := fcl0;
  FrtlEnabled := false;
  FsearchTimeout := 0;
  Fstate := nil;
  FtabIndex := 0;
  Ftexts := TJSObject.new;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonContextMenuPreparing := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
end;

procedure TjdxPivotGridFieldChooser.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_allowSearch(const Value: boolean);
begin
  FallowSearch := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_applyChangesMode(const Value: JSValue);
begin
  FapplyChangesMode := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_encodeHtml(const Value: boolean);
begin
  FencodeHtml := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_headerFilter(const Value: TJSObject);
begin
  FheaderFilter := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_layout(const Value: TdxFieldChooserLayout);
begin
  Flayout := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_searchTimeout(const Value: integer);
begin
  FsearchTimeout := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_state(const Value: JSValue);
begin
  Fstate := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_texts(const Value: TJSObject);
begin
  Ftexts := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_onContextMenuPreparing(const Value: TdxEventHandler);
begin
  FonContextMenuPreparing := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxPivotGridFieldChooser.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

end.
