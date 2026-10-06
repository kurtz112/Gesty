unit DevExtreme.Calendar.Custom;

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
  DevExtreme.Calendar.JS,
  DevExtreme.Types;

type
  TjdxCustomCalendar = class(TjdxCustomControl)
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
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxCalendar; assembler;
    function instance: TdxCalendar; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure repaint(); assembler;
    procedure reset(); assembler;
    procedure resetOption(optionName: string); assembler;
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


procedure TjdxCustomCalendar.CreateInitialize;
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
procedure TjdxCustomCalendar.InitJQuery;
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
      $(id).dxCalendar(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomCalendar.getInstance(element: TJSObject): TdxCalendar;
asm
  return DevExpress.viz.dxCalendar.getInstance(element);
end;

function TjdxCustomCalendar.instance: TdxCalendar;
asm
  return $(this.GetJQID()).dxCalendar("instance");
end;
procedure TjdxCustomCalendar.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('cellTemplate', cellTemplate);
    SetOption('currentDate', currentDate);
    SetOption('dateSerializationFormat', dateSerializationFormat);
    SetOption('disabled', disabled);
    SetOption('disabledDates', disabledDates);
    SetOption('elementAttr', elementAttr);
    SetOption('firstDayOfWeek', firstDayOfWeek.ToString());
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('isValid', isValid);
    SetOption('max', max);
    SetOption('maxZoomLevel', maxZoomLevel.ToString());
    SetOption('min', min);
    SetOption('minZoomLevel', minZoomLevel.ToString());
    SetOption('name', name_);
    SetOption('readOnly', readOnly);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('showTodayButton', showTodayButton);
    SetOption('showWeekNumbers', showWeekNumbers);
    SetOption('stylingMode', stylingMode.ToString());
    SetOption('tabIndex', tabIndex);
    SetOption('validationError', validationError);
    SetOption('validationErrors', validationErrors);
    SetOption('validationMessageMode', validationMessageMode.ToString());
    SetOption('validationMessagePosition', validationMessagePosition.ToString());
    SetOption('validationStatus', validationStatus.ToString());
    SetOption('value', value);
    SetOption('visible', visible);
    SetOption('weekNumberRule', weekNumberRule.ToString());
    SetOption('width', width_);
    SetOption('zoomLevel', zoomLevel.ToString());

    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('valueChanged', onValueChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomCalendar.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomCalendar.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomCalendar.Set_cellTemplate(const Value: JSValue);
begin
  FcellTemplate := Value;
  SetOption('cellTemplate', cellTemplate);
end;

procedure TjdxCustomCalendar.Set_currentDate(const Value: TDateTime);
begin
  FcurrentDate := Value;
  SetOption('currentDate', currentDate);
end;

procedure TjdxCustomCalendar.Set_dateSerializationFormat(const Value: string);
begin
  FdateSerializationFormat := Value;
  SetOption('dateSerializationFormat', dateSerializationFormat);
end;

procedure TjdxCustomCalendar.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomCalendar.Set_disabledDates(const Value: JSValue);
begin
  FdisabledDates := Value;
  SetOption('disabledDates', disabledDates);
end;

procedure TjdxCustomCalendar.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomCalendar.Set_firstDayOfWeek(const Value: TdxFirstDayOfWeek);
begin
  FfirstDayOfWeek := Value;
  SetOption('firstDayOfWeek', firstDayOfWeek.ToString());
end;

procedure TjdxCustomCalendar.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomCalendar.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomCalendar.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomCalendar.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomCalendar.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
  SetOption('isValid', isValid);
end;

procedure TjdxCustomCalendar.Set_max(const Value: JSValue);
begin
  Fmax := Value;
  SetOption('max', max);
end;

procedure TjdxCustomCalendar.Set_maxZoomLevel(const Value: TdxCalendarZoomLevel);
begin
  FmaxZoomLevel := Value;
  SetOption('maxZoomLevel', maxZoomLevel.ToString());
end;

procedure TjdxCustomCalendar.Set_min(const Value: JSValue);
begin
  Fmin := Value;
  SetOption('min', min);
end;

procedure TjdxCustomCalendar.Set_minZoomLevel(const Value: TdxCalendarZoomLevel);
begin
  FminZoomLevel := Value;
  SetOption('minZoomLevel', minZoomLevel.ToString());
end;

procedure TjdxCustomCalendar.Set_name_(const Value: string);
begin
  Fname_ := Value;
  SetOption('name', name_);
end;

procedure TjdxCustomCalendar.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
  SetOption('readOnly', readOnly);
end;

procedure TjdxCustomCalendar.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomCalendar.Set_showTodayButton(const Value: boolean);
begin
  FshowTodayButton := Value;
  SetOption('showTodayButton', showTodayButton);
end;

procedure TjdxCustomCalendar.Set_showWeekNumbers(const Value: boolean);
begin
  FshowWeekNumbers := Value;
  SetOption('showWeekNumbers', showWeekNumbers);
end;

procedure TjdxCustomCalendar.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
  SetOption('stylingMode', stylingMode.ToString());
end;

procedure TjdxCustomCalendar.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomCalendar.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
  SetOption('validationError', validationError);
end;

procedure TjdxCustomCalendar.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
  SetOption('validationErrors', validationErrors);
end;

procedure TjdxCustomCalendar.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
  SetOption('validationMessageMode', validationMessageMode.ToString());
end;

procedure TjdxCustomCalendar.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
  SetOption('validationMessagePosition', validationMessagePosition.ToString());
end;

procedure TjdxCustomCalendar.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
  SetOption('validationStatus', validationStatus.ToString());
end;

procedure TjdxCustomCalendar.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
  SetOption('value', value);
end;

procedure TjdxCustomCalendar.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomCalendar.Set_weekNumberRule(const Value: TdxWeekNumberRule);
begin
  FweekNumberRule := Value;
  SetOption('weekNumberRule', weekNumberRule.ToString());
end;

procedure TjdxCustomCalendar.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomCalendar.Set_zoomLevel(const Value: TdxCalendarZoomLevel);
begin
  FzoomLevel := Value;
  SetOption('zoomLevel', zoomLevel.ToString());
end;

procedure TjdxCustomCalendar.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomCalendar.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomCalendar.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomCalendar.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomCalendar.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomCalendar.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomCalendar.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
  SetEvent('valueChanged', onValueChanged);
end;

procedure TjdxCustomCalendar.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomCalendar.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomCalendar.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomCalendar.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomCalendar.dispose();
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  _instance.dispose();
end;

function TjdxCustomCalendar.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  return _instance.element();
end;

procedure TjdxCustomCalendar.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomCalendar.focus();
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  _instance.focus();
end;

function TjdxCustomCalendar.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  return _instance.off(eventName);
end;

function TjdxCustomCalendar.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomCalendar.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomCalendar.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  return _instance.on(events);
end;

function TjdxCustomCalendar.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  return _instance.option(optionName);
end;

function TjdxCustomCalendar.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  return _instance.option();
end;

procedure TjdxCustomCalendar.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomCalendar.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  _instance.option(options);
end;

procedure TjdxCustomCalendar.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomCalendar.repaint();
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  _instance.repaint();
end;

procedure TjdxCustomCalendar.reset();
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  _instance.reset();
end;

procedure TjdxCustomCalendar.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxCalendar("instance");
  _instance.resetOption(optionName);
end;

end.
