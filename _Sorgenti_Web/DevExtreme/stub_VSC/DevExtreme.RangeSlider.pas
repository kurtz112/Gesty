unit DevExtreme.RangeSlider;

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
  TjdxRangeSlider = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fend_: integer;
    FendName: string;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FisValid: boolean;
    FkeyStep: integer;
    Flabel_: TJSObject;
    Fmax: integer;
    Fmin: integer;
    Fname_: string;
    FreadOnly: boolean;
    FrtlEnabled: boolean;
    FshowRange: boolean;
    Fstart: integer;
    FstartName: string;
    Fstep: integer;
    FstylingMode: TdxEditorStyle;
    FtabIndex: integer;
    Ftooltip: TJSObject;
    FvalidationError: JSValue;
    FvalidationErrors: TJSArray;
    FvalidationMessageMode: TdxValidationMessageMode;
    FvalidationMessagePosition: TdxPosition;
    FvalidationStatus: TdxValidationStatus;
    Fvalue: JSValue;
    FvalueChangeMode: TdxSliderValueChangeMode;
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
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_end_(const value: integer);
    procedure Set_endName(const value: string);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_isValid(const value: boolean);
    procedure Set_keyStep(const value: integer);
    procedure Set_label_(const value: TJSObject);
    procedure Set_max(const value: integer);
    procedure Set_min(const value: integer);
    procedure Set_name_(const value: string);
    procedure Set_readOnly(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_showRange(const value: boolean);
    procedure Set_start(const value: integer);
    procedure Set_startName(const value: string);
    procedure Set_step(const value: integer);
    procedure Set_stylingMode(const value: TdxEditorStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_validationError(const value: JSValue);
    procedure Set_validationErrors(const value: TJSArray);
    procedure Set_validationMessageMode(const value: TdxValidationMessageMode);
    procedure Set_validationMessagePosition(const value: TdxPosition);
    procedure Set_validationStatus(const value: TdxValidationStatus);
    procedure Set_value(const value: JSValue);
    procedure Set_valueChangeMode(const value: TdxSliderValueChangeMode);
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
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property label_: TJSObject read Flabel_ write Set_label_;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property validationError: JSValue read FvalidationError write Set_validationError;
    property validationErrors: TJSArray read FvalidationErrors write Set_validationErrors;
    property value: JSValue read Fvalue write Set_value;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property end_: integer read Fend_ write Set_end_;
    property endName: string read FendName write Set_endName;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property isValid: boolean read FisValid write Set_isValid default true;
    property keyStep: integer read FkeyStep write Set_keyStep;
    property max: integer read Fmax write Set_max;
    property min: integer read Fmin write Set_min;
    property name_: string read Fname_ write Set_name_;
    property readOnly: boolean read FreadOnly write Set_readOnly default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showRange: boolean read FshowRange write Set_showRange default true;
    property start: integer read Fstart write Set_start;
    property startName: string read FstartName write Set_startName;
    property step: integer read Fstep write Set_step;
    property stylingMode: TdxEditorStyle read FstylingMode write Set_stylingMode default esOutlined;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property validationMessageMode: TdxValidationMessageMode read FvalidationMessageMode write Set_validationMessageMode default vmmAuto;
    property validationMessagePosition: TdxPosition read FvalidationMessagePosition write Set_validationMessagePosition default pBottom;
    property validationStatus: TdxValidationStatus read FvalidationStatus write Set_validationStatus default vsValid;
    property valueChangeMode: TdxSliderValueChangeMode read FvalueChangeMode write Set_valueChangeMode default svcmOnHandleMove;
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


constructor TjdxRangeSlider.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fend_ := 0;
  FendName := '';
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FisValid := true;
  FkeyStep := 0;
  Flabel_ := TJSObject.new;
  Fmax := 0;
  Fmin := 0;
  Fname_ := '';
  FreadOnly := false;
  FrtlEnabled := false;
  FshowRange := true;
  Fstart := 0;
  FstartName := '';
  Fstep := 0;
  FstylingMode := esOutlined;
  FtabIndex := 0;
  Ftooltip := TJSObject.new;
  FvalidationError := nil;
  FvalidationErrors := TJSArray.new;
  FvalidationMessageMode := vmmAuto;
  FvalidationMessagePosition := pBottom;
  FvalidationStatus := vsValid;
  Fvalue := nil;
  FvalueChangeMode := svcmOnHandleMove;
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

procedure TjdxRangeSlider.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxRangeSlider.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxRangeSlider.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxRangeSlider.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxRangeSlider.Set_end_(const Value: integer);
begin
  Fend_ := Value;
end;

procedure TjdxRangeSlider.Set_endName(const Value: string);
begin
  FendName := Value;
end;

procedure TjdxRangeSlider.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxRangeSlider.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxRangeSlider.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxRangeSlider.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxRangeSlider.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
end;

procedure TjdxRangeSlider.Set_keyStep(const Value: integer);
begin
  FkeyStep := Value;
end;

procedure TjdxRangeSlider.Set_label_(const Value: TJSObject);
begin
  Flabel_ := Value;
end;

procedure TjdxRangeSlider.Set_max(const Value: integer);
begin
  Fmax := Value;
end;

procedure TjdxRangeSlider.Set_min(const Value: integer);
begin
  Fmin := Value;
end;

procedure TjdxRangeSlider.Set_name_(const Value: string);
begin
  Fname_ := Value;
end;

procedure TjdxRangeSlider.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
end;

procedure TjdxRangeSlider.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxRangeSlider.Set_showRange(const Value: boolean);
begin
  FshowRange := Value;
end;

procedure TjdxRangeSlider.Set_start(const Value: integer);
begin
  Fstart := Value;
end;

procedure TjdxRangeSlider.Set_startName(const Value: string);
begin
  FstartName := Value;
end;

procedure TjdxRangeSlider.Set_step(const Value: integer);
begin
  Fstep := Value;
end;

procedure TjdxRangeSlider.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
end;

procedure TjdxRangeSlider.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxRangeSlider.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
end;

procedure TjdxRangeSlider.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
end;

procedure TjdxRangeSlider.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
end;

procedure TjdxRangeSlider.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
end;

procedure TjdxRangeSlider.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
end;

procedure TjdxRangeSlider.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
end;

procedure TjdxRangeSlider.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
end;

procedure TjdxRangeSlider.Set_valueChangeMode(const Value: TdxSliderValueChangeMode);
begin
  FvalueChangeMode := Value;
end;

procedure TjdxRangeSlider.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxRangeSlider.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxRangeSlider.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxRangeSlider.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxRangeSlider.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxRangeSlider.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxRangeSlider.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxRangeSlider.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxRangeSlider.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
end;

end.
