unit DevExtreme.RadioGroup;

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
  TjdxRadioGroup = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FdisplayExpr: JSValue;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FisValid: boolean;
    Fitems: TJSArray;
    FitemTemplate: JSValue;
    Flayout: TdxOrientation;
    Fname_: string;
    FreadOnly: boolean;
    FrtlEnabled: boolean;
    FstylingMode: TdxEditorStyle;
    FtabIndex: integer;
    FvalidationError: JSValue;
    FvalidationErrors: TJSArray;
    FvalidationMessageMode: TdxValidationMessageMode;
    FvalidationMessagePosition: TdxPosition;
    FvalidationStatus: TdxValidationStatus;
    Fvalue: JSValue;
    FvalueExpr: JSValue;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
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
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_displayExpr(const value: JSValue);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_isValid(const value: boolean);
    procedure Set_items(const value: TJSArray);
    procedure Set_itemTemplate(const value: JSValue);
    procedure Set_layout(const value: TdxOrientation);
    procedure Set_name_(const value: string);
    procedure Set_readOnly(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_stylingMode(const value: TdxEditorStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_validationError(const value: JSValue);
    procedure Set_validationErrors(const value: TJSArray);
    procedure Set_validationMessageMode(const value: TdxValidationMessageMode);
    procedure Set_validationMessagePosition(const value: TdxPosition);
    procedure Set_validationStatus(const value: TdxValidationStatus);
    procedure Set_value(const value: JSValue);
    procedure Set_valueExpr(const value: JSValue);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
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
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property displayExpr: JSValue read FdisplayExpr write Set_displayExpr;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property items: TJSArray read Fitems write Set_items;
    property itemTemplate: JSValue read FitemTemplate write Set_itemTemplate;
    property validationError: JSValue read FvalidationError write Set_validationError;
    property validationErrors: TJSArray read FvalidationErrors write Set_validationErrors;
    property value: JSValue read Fvalue write Set_value;
    property valueExpr: JSValue read FvalueExpr write Set_valueExpr;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property isValid: boolean read FisValid write Set_isValid default true;
    property layout: TdxOrientation read Flayout write Set_layout default oHorizontal;
    property name_: string read Fname_ write Set_name_;
    property readOnly: boolean read FreadOnly write Set_readOnly default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property stylingMode: TdxEditorStyle read FstylingMode write Set_stylingMode default esOutlined;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property validationMessageMode: TdxValidationMessageMode read FvalidationMessageMode write Set_validationMessageMode default vmmAuto;
    property validationMessagePosition: TdxPosition read FvalidationMessagePosition write Set_validationMessagePosition default pBottom;
    property validationStatus: TdxValidationStatus read FvalidationStatus write Set_validationStatus default vsValid;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onValueChanged: TdxEventHandler read FonValueChanged write Set_onValueChanged;
  end;

implementation


constructor TjdxRadioGroup.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FdataSource := nil;
  Fdisabled := false;
  FdisplayExpr := nil;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FisValid := true;
  Fitems := TJSArray.new;
  FitemTemplate := nil;
  Flayout := oHorizontal;
  Fname_ := '';
  FreadOnly := false;
  FrtlEnabled := false;
  FstylingMode := esOutlined;
  FtabIndex := 0;
  FvalidationError := nil;
  FvalidationErrors := TJSArray.new;
  FvalidationMessageMode := vmmAuto;
  FvalidationMessagePosition := pBottom;
  FvalidationStatus := vsValid;
  Fvalue := nil;
  FvalueExpr := nil;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonValueChanged := nil;
end;

procedure TjdxRadioGroup.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxRadioGroup.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxRadioGroup.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxRadioGroup.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxRadioGroup.Set_displayExpr(const Value: JSValue);
begin
  FdisplayExpr := Value;
end;

procedure TjdxRadioGroup.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxRadioGroup.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxRadioGroup.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxRadioGroup.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxRadioGroup.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxRadioGroup.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
end;

procedure TjdxRadioGroup.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
end;

procedure TjdxRadioGroup.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
end;

procedure TjdxRadioGroup.Set_layout(const Value: TdxOrientation);
begin
  Flayout := Value;
end;

procedure TjdxRadioGroup.Set_name_(const Value: string);
begin
  Fname_ := Value;
end;

procedure TjdxRadioGroup.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
end;

procedure TjdxRadioGroup.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxRadioGroup.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
end;

procedure TjdxRadioGroup.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxRadioGroup.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
end;

procedure TjdxRadioGroup.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
end;

procedure TjdxRadioGroup.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
end;

procedure TjdxRadioGroup.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
end;

procedure TjdxRadioGroup.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
end;

procedure TjdxRadioGroup.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
end;

procedure TjdxRadioGroup.Set_valueExpr(const Value: JSValue);
begin
  FvalueExpr := Value;
end;

procedure TjdxRadioGroup.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxRadioGroup.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxRadioGroup.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxRadioGroup.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxRadioGroup.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxRadioGroup.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxRadioGroup.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxRadioGroup.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxRadioGroup.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
end;

end.
