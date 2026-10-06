unit DevExtreme.Calendar;

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
  TjdxCalendar = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FcellTemplate: JSValue;
    FcurrentDate: TDateTime;
    FdateSerializationFormat: string;
    Fdisabled: boolean;
    FdisabledDates: JSValue;
    FelementAttr: TJSObject;
    FfirstDayOfWeek: TdxFirstDayOfWeek;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FisValid: boolean;
    Fmax: JSValue;
    FmaxZoomLevel: TdxCalendarZoomLevel;
    Fmin: JSValue;
    FminZoomLevel: TdxCalendarZoomLevel;
    Fname_: string;
    FreadOnly: boolean;
    FrtlEnabled: boolean;
    FshowTodayButton: boolean;
    FshowWeekNumbers: boolean;
    FstylingMode: TdxEditorStyle;
    FtabIndex: integer;
    FvalidationError: JSValue;
    FvalidationErrors: TJSArray;
    FvalidationMessageMode: TdxValidationMessageMode;
    FvalidationMessagePosition: TdxPosition;
    FvalidationStatus: TdxValidationStatus;
    Fvalue: JSValue;
    Fvisible: boolean;
    FweekNumberRule: TdxWeekNumberRule;
    Fwidth_: JSValue;
    FzoomLevel: TdxCalendarZoomLevel;
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
    procedure Set_cellTemplate(const value: JSValue);
    procedure Set_currentDate(const value: TDateTime);
    procedure Set_dateSerializationFormat(const value: string);
    procedure Set_disabled(const value: boolean);
    procedure Set_disabledDates(const value: JSValue);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_firstDayOfWeek(const value: TdxFirstDayOfWeek);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_isValid(const value: boolean);
    procedure Set_max(const value: JSValue);
    procedure Set_maxZoomLevel(const value: TdxCalendarZoomLevel);
    procedure Set_min(const value: JSValue);
    procedure Set_minZoomLevel(const value: TdxCalendarZoomLevel);
    procedure Set_name_(const value: string);
    procedure Set_readOnly(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_showTodayButton(const value: boolean);
    procedure Set_showWeekNumbers(const value: boolean);
    procedure Set_stylingMode(const value: TdxEditorStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_validationError(const value: JSValue);
    procedure Set_validationErrors(const value: TJSArray);
    procedure Set_validationMessageMode(const value: TdxValidationMessageMode);
    procedure Set_validationMessagePosition(const value: TdxPosition);
    procedure Set_validationStatus(const value: TdxValidationStatus);
    procedure Set_value(const value: JSValue);
    procedure Set_visible(const value: boolean);
    procedure Set_weekNumberRule(const value: TdxWeekNumberRule);
    procedure Set_width_(const value: JSValue);
    procedure Set_zoomLevel(const value: TdxCalendarZoomLevel);
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
    property cellTemplate: JSValue read FcellTemplate write Set_cellTemplate;
    property disabledDates: JSValue read FdisabledDates write Set_disabledDates;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property max: JSValue read Fmax write Set_max;
    property min: JSValue read Fmin write Set_min;
    property validationError: JSValue read FvalidationError write Set_validationError;
    property validationErrors: TJSArray read FvalidationErrors write Set_validationErrors;
    property value: JSValue read Fvalue write Set_value;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property currentDate: TDateTime read FcurrentDate write Set_currentDate;
    property dateSerializationFormat: string read FdateSerializationFormat write Set_dateSerializationFormat;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property firstDayOfWeek: TdxFirstDayOfWeek read FfirstDayOfWeek write Set_firstDayOfWeek default fdow0;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property isValid: boolean read FisValid write Set_isValid default true;
    property maxZoomLevel: TdxCalendarZoomLevel read FmaxZoomLevel write Set_maxZoomLevel default czlMonth;
    property minZoomLevel: TdxCalendarZoomLevel read FminZoomLevel write Set_minZoomLevel default czlCentury;
    property name_: string read Fname_ write Set_name_;
    property readOnly: boolean read FreadOnly write Set_readOnly default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showTodayButton: boolean read FshowTodayButton write Set_showTodayButton default false;
    property showWeekNumbers: boolean read FshowWeekNumbers write Set_showWeekNumbers default false;
    property stylingMode: TdxEditorStyle read FstylingMode write Set_stylingMode default esOutlined;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property validationMessageMode: TdxValidationMessageMode read FvalidationMessageMode write Set_validationMessageMode default vmmAuto;
    property validationMessagePosition: TdxPosition read FvalidationMessagePosition write Set_validationMessagePosition default pBottom;
    property validationStatus: TdxValidationStatus read FvalidationStatus write Set_validationStatus default vsValid;
    property visible: boolean read Fvisible write Set_visible default true;
    property weekNumberRule: TdxWeekNumberRule read FweekNumberRule write Set_weekNumberRule default wnrAuto;
    property zoomLevel: TdxCalendarZoomLevel read FzoomLevel write Set_zoomLevel default czlMonth;
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


constructor TjdxCalendar.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FcellTemplate := nil;
  FcurrentDate := 0;
  FdateSerializationFormat := '';
  Fdisabled := false;
  FdisabledDates := nil;
  FelementAttr := TJSObject.new;
  FfirstDayOfWeek := fdow0;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FisValid := true;
  Fmax := nil;
  FmaxZoomLevel := czlMonth;
  Fmin := nil;
  FminZoomLevel := czlCentury;
  Fname_ := '';
  FreadOnly := false;
  FrtlEnabled := false;
  FshowTodayButton := false;
  FshowWeekNumbers := false;
  FstylingMode := esOutlined;
  FtabIndex := 0;
  FvalidationError := nil;
  FvalidationErrors := TJSArray.new;
  FvalidationMessageMode := vmmAuto;
  FvalidationMessagePosition := pBottom;
  FvalidationStatus := vsValid;
  Fvalue := nil;
  Fvisible := true;
  FweekNumberRule := wnrAuto;
  Fwidth_ := nil;
  FzoomLevel := czlMonth;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonValueChanged := nil;
end;

procedure TjdxCalendar.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxCalendar.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxCalendar.Set_cellTemplate(const Value: JSValue);
begin
  FcellTemplate := Value;
end;

procedure TjdxCalendar.Set_currentDate(const Value: TDateTime);
begin
  FcurrentDate := Value;
end;

procedure TjdxCalendar.Set_dateSerializationFormat(const Value: string);
begin
  FdateSerializationFormat := Value;
end;

procedure TjdxCalendar.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxCalendar.Set_disabledDates(const Value: JSValue);
begin
  FdisabledDates := Value;
end;

procedure TjdxCalendar.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxCalendar.Set_firstDayOfWeek(const Value: TdxFirstDayOfWeek);
begin
  FfirstDayOfWeek := Value;
end;

procedure TjdxCalendar.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxCalendar.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxCalendar.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxCalendar.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxCalendar.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
end;

procedure TjdxCalendar.Set_max(const Value: JSValue);
begin
  Fmax := Value;
end;

procedure TjdxCalendar.Set_maxZoomLevel(const Value: TdxCalendarZoomLevel);
begin
  FmaxZoomLevel := Value;
end;

procedure TjdxCalendar.Set_min(const Value: JSValue);
begin
  Fmin := Value;
end;

procedure TjdxCalendar.Set_minZoomLevel(const Value: TdxCalendarZoomLevel);
begin
  FminZoomLevel := Value;
end;

procedure TjdxCalendar.Set_name_(const Value: string);
begin
  Fname_ := Value;
end;

procedure TjdxCalendar.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
end;

procedure TjdxCalendar.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxCalendar.Set_showTodayButton(const Value: boolean);
begin
  FshowTodayButton := Value;
end;

procedure TjdxCalendar.Set_showWeekNumbers(const Value: boolean);
begin
  FshowWeekNumbers := Value;
end;

procedure TjdxCalendar.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
end;

procedure TjdxCalendar.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxCalendar.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
end;

procedure TjdxCalendar.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
end;

procedure TjdxCalendar.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
end;

procedure TjdxCalendar.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
end;

procedure TjdxCalendar.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
end;

procedure TjdxCalendar.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
end;

procedure TjdxCalendar.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxCalendar.Set_weekNumberRule(const Value: TdxWeekNumberRule);
begin
  FweekNumberRule := Value;
end;

procedure TjdxCalendar.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxCalendar.Set_zoomLevel(const Value: TdxCalendarZoomLevel);
begin
  FzoomLevel := Value;
end;

procedure TjdxCalendar.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxCalendar.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxCalendar.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxCalendar.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxCalendar.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxCalendar.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxCalendar.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
end;

end.
