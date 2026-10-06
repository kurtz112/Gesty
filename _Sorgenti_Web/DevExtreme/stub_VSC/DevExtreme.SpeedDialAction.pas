unit DevExtreme.SpeedDialAction;

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
  TjdxSpeedDialAction = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    Ficon: string;
    Findex: integer;
    Flabel_: string;
    FrtlEnabled: boolean;
    FtabIndex: integer;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonClick: TdxEventHandler;
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_icon(const value: string);
    procedure Set_index(const value: integer);
    procedure Set_label_(const value: string);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onClick(const value: TdxEventHandler);
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property icon: string read Ficon write Set_icon;
    property index: integer read Findex write Set_index;
    property label_: string read Flabel_ write Set_label_;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onClick: TdxEventHandler read FonClick write Set_onClick;
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
  end;

implementation


constructor TjdxSpeedDialAction.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  Ficon := '';
  Findex := 0;
  Flabel_ := '';
  FrtlEnabled := false;
  FtabIndex := 0;
  Fvisible := true;
  Fwidth_ := nil;

  FonClick := nil;
  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
end;

procedure TjdxSpeedDialAction.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxSpeedDialAction.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxSpeedDialAction.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxSpeedDialAction.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxSpeedDialAction.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxSpeedDialAction.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxSpeedDialAction.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxSpeedDialAction.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxSpeedDialAction.Set_icon(const Value: string);
begin
  Ficon := Value;
end;

procedure TjdxSpeedDialAction.Set_index(const Value: integer);
begin
  Findex := Value;
end;

procedure TjdxSpeedDialAction.Set_label_(const Value: string);
begin
  Flabel_ := Value;
end;

procedure TjdxSpeedDialAction.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxSpeedDialAction.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxSpeedDialAction.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxSpeedDialAction.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxSpeedDialAction.Set_onClick(const Value: TdxEventHandler);
begin
  FonClick := Value;
end;

procedure TjdxSpeedDialAction.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxSpeedDialAction.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxSpeedDialAction.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxSpeedDialAction.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxSpeedDialAction.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxSpeedDialAction.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

end.
