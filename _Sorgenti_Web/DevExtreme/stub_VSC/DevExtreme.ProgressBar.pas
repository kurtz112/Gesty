unit DevExtreme.ProgressBar;

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
  TjdxProgressBar = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FisValid: boolean;
    Fmax: integer;
    Fmin: integer;
    Fname_: string;
    FreadOnly: boolean;
    FrtlEnabled: boolean;
    FshowStatus: boolean;
    FstatusFormat: JSValue;
    FstylingMode: TdxEditorStyle;
    FtabIndex: integer;
    FvalidationError: JSValue;
    FvalidationErrors: TJSArray;
    FvalidationMessageMode: TdxValidationMessageMode;
    FvalidationMessagePosition: TdxPosition;
    FvalidationStatus: TdxValidationStatus;
    Fvalue: JSValue;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonComplete: TdxEventHandler;
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonValueChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_isValid(const value: boolean);
    procedure Set_max(const value: integer);
    procedure Set_min(const value: integer);
    procedure Set_name_(const value: string);
    procedure Set_readOnly(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_showStatus(const value: boolean);
    procedure Set_statusFormat(const value: JSValue);
    procedure Set_stylingMode(const value: TdxEditorStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_validationError(const value: JSValue);
    procedure Set_validationErrors(const value: TJSArray);
    procedure Set_validationMessageMode(const value: TdxValidationMessageMode);
    procedure Set_validationMessagePosition(const value: TdxPosition);
    procedure Set_validationStatus(const value: TdxValidationStatus);
    procedure Set_value(const value: JSValue);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onComplete(const value: TdxEventHandler);
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onValueChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property statusFormat: JSValue read FstatusFormat write Set_statusFormat;
    property validationError: JSValue read FvalidationError write Set_validationError;
    property validationErrors: TJSArray read FvalidationErrors write Set_validationErrors;
    property value: JSValue read Fvalue write Set_value;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property isValid: boolean read FisValid write Set_isValid default true;
    property max: integer read Fmax write Set_max;
    property min: integer read Fmin write Set_min;
    property name_: string read Fname_ write Set_name_;
    property readOnly: boolean read FreadOnly write Set_readOnly default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showStatus: boolean read FshowStatus write Set_showStatus default true;
    property stylingMode: TdxEditorStyle read FstylingMode write Set_stylingMode default esOutlined;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property validationMessageMode: TdxValidationMessageMode read FvalidationMessageMode write Set_validationMessageMode default vmmAuto;
    property validationMessagePosition: TdxPosition read FvalidationMessagePosition write Set_validationMessagePosition default pBottom;
    property validationStatus: TdxValidationStatus read FvalidationStatus write Set_validationStatus default vsValid;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onComplete: TdxEventHandler read FonComplete write Set_onComplete;
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onValueChanged: TdxEventHandler read FonValueChanged write Set_onValueChanged;
  end;

implementation


constructor TjdxProgressBar.Create(aOwner: TComponent);
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
  FisValid := true;
  Fmax := 0;
  Fmin := 0;
  Fname_ := '';
  FreadOnly := false;
  FrtlEnabled := false;
  FshowStatus := true;
  FstatusFormat := nil;
  FstylingMode := esOutlined;
  FtabIndex := 0;
  FvalidationError := nil;
  FvalidationErrors := TJSArray.new;
  FvalidationMessageMode := vmmAuto;
  FvalidationMessagePosition := pBottom;
  FvalidationStatus := vsValid;
  Fvalue := nil;
  Fvisible := true;
  Fwidth_ := nil;

  FonComplete := nil;
  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonValueChanged := nil;
end;

procedure TjdxProgressBar.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxProgressBar.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxProgressBar.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxProgressBar.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxProgressBar.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxProgressBar.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxProgressBar.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxProgressBar.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxProgressBar.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
end;

procedure TjdxProgressBar.Set_max(const Value: integer);
begin
  Fmax := Value;
end;

procedure TjdxProgressBar.Set_min(const Value: integer);
begin
  Fmin := Value;
end;

procedure TjdxProgressBar.Set_name_(const Value: string);
begin
  Fname_ := Value;
end;

procedure TjdxProgressBar.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
end;

procedure TjdxProgressBar.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxProgressBar.Set_showStatus(const Value: boolean);
begin
  FshowStatus := Value;
end;

procedure TjdxProgressBar.Set_statusFormat(const Value: JSValue);
begin
  FstatusFormat := Value;
end;

procedure TjdxProgressBar.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
end;

procedure TjdxProgressBar.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxProgressBar.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
end;

procedure TjdxProgressBar.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
end;

procedure TjdxProgressBar.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
end;

procedure TjdxProgressBar.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
end;

procedure TjdxProgressBar.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
end;

procedure TjdxProgressBar.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
end;

procedure TjdxProgressBar.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxProgressBar.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxProgressBar.Set_onComplete(const Value: TdxEventHandler);
begin
  FonComplete := Value;
end;

procedure TjdxProgressBar.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxProgressBar.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxProgressBar.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxProgressBar.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxProgressBar.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxProgressBar.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxProgressBar.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
end;

end.
