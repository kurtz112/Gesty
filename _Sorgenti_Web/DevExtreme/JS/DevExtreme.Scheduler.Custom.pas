unit DevExtreme.Scheduler.Custom;

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
  DevExtreme.Scheduler.JS,
  DevExtreme.Types;

type
  TjdxCustomScheduler = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FadaptivityEnabled: boolean;
    FallDayExpr: string;
    FallDayPanelMode: TdxAllDayPanelMode;
    FappointmentCollectorTemplate: JSValue;
    FappointmentDragging: TJSObject;
    FappointmentPopupTemplate: JSValue;
    FappointmentTemplate: JSValue;
    FappointmentTooltipTemplate: JSValue;
    FcellDuration: integer;
    FcrossScrollingEnabled: boolean;
    FcurrentDate: JSValue;
    FcurrentView: TdxViewType;
    FcustomizeDateNavigatorText: TJSFunction;
    FdataCellTemplate: JSValue;
    FdataSource: JSValue;
    FdateCellTemplate: JSValue;
    FdateSerializationFormat: string;
    FdescriptionExpr: string;
    Fdisabled: boolean;
    Fediting: TJSObject;
    FelementAttr: TJSObject;
    FendDateExpr: string;
    FendDateTimeZoneExpr: string;
    FendDayHour: integer;
    FfirstDayOfWeek: TdxFirstDayOfWeek;
    FfocusStateEnabled: boolean;
    FgroupByDate: boolean;
    Fgroups: TJSArray;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FindicatorTime: TDateTime;
    FindicatorUpdateInterval: integer;
    Fmax: JSValue;
    FmaxAppointmentsPerCell: JSValue;
    Fmin: JSValue;
    FnoDataText: string;
    FrecurrenceEditMode: TdxRecurrenceEditMode;
    FrecurrenceExceptionExpr: string;
    FrecurrenceRuleExpr: string;
    FremoteFiltering: boolean;
    FresourceCellTemplate: JSValue;
    Fresources: TJSArray;
    FrtlEnabled: boolean;
    Fscrolling: JSValue;
    FselectedCellData: TJSArray;
    FshadeUntilCurrentTime: boolean;
    FshowAllDayPanel: boolean;
    FshowCurrentTimeIndicator: boolean;
    FstartDateExpr: string;
    FstartDateTimeZoneExpr: string;
    FstartDayHour: integer;
    FtabIndex: integer;
    FtextExpr: string;
    FtimeCellTemplate: JSValue;
    FtimeZone: string;
    FuseDropDownViewSwitcher: boolean;
    Fviews: TJSArray;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonAppointmentAdded: TdxEventHandler;
    FonAppointmentAdding: TdxEventHandler;
    FonAppointmentClick: TdxEventHandler;
    FonAppointmentContextMenu: TdxEventHandler;
    FonAppointmentDblClick: TdxEventHandler;
    FonAppointmentDeleted: TdxEventHandler;
    FonAppointmentDeleting: TdxEventHandler;
    FonAppointmentFormOpening: TdxEventHandler;
    FonAppointmentRendered: TdxEventHandler;
    FonAppointmentTooltipShowing: TdxEventHandler;
    FonAppointmentUpdated: TdxEventHandler;
    FonAppointmentUpdating: TdxEventHandler;
    FonCellClick: TdxEventHandler;
    FonCellContextMenu: TdxEventHandler;
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_adaptivityEnabled(const value: boolean);
    procedure Set_allDayExpr(const value: string);
    procedure Set_allDayPanelMode(const value: TdxAllDayPanelMode);
    procedure Set_appointmentCollectorTemplate(const value: JSValue);
    procedure Set_appointmentDragging(const value: TJSObject);
    procedure Set_appointmentPopupTemplate(const value: JSValue);
    procedure Set_appointmentTemplate(const value: JSValue);
    procedure Set_appointmentTooltipTemplate(const value: JSValue);
    procedure Set_cellDuration(const value: integer);
    procedure Set_crossScrollingEnabled(const value: boolean);
    procedure Set_currentDate(const value: JSValue);
    procedure Set_currentView(const value: TdxViewType);
    procedure Set_customizeDateNavigatorText(const value: TJSFunction);
    procedure Set_dataCellTemplate(const value: JSValue);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_dateCellTemplate(const value: JSValue);
    procedure Set_dateSerializationFormat(const value: string);
    procedure Set_descriptionExpr(const value: string);
    procedure Set_disabled(const value: boolean);
    procedure Set_editing(const value: TJSObject);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_endDateExpr(const value: string);
    procedure Set_endDateTimeZoneExpr(const value: string);
    procedure Set_endDayHour(const value: integer);
    procedure Set_firstDayOfWeek(const value: TdxFirstDayOfWeek);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_groupByDate(const value: boolean);
    procedure Set_groups(const value: TJSArray);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_indicatorTime(const value: TDateTime);
    procedure Set_indicatorUpdateInterval(const value: integer);
    procedure Set_max(const value: JSValue);
    procedure Set_maxAppointmentsPerCell(const value: JSValue);
    procedure Set_min(const value: JSValue);
    procedure Set_noDataText(const value: string);
    procedure Set_recurrenceEditMode(const value: TdxRecurrenceEditMode);
    procedure Set_recurrenceExceptionExpr(const value: string);
    procedure Set_recurrenceRuleExpr(const value: string);
    procedure Set_remoteFiltering(const value: boolean);
    procedure Set_resourceCellTemplate(const value: JSValue);
    procedure Set_resources(const value: TJSArray);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scrolling(const value: JSValue);
    procedure Set_shadeUntilCurrentTime(const value: boolean);
    procedure Set_showAllDayPanel(const value: boolean);
    procedure Set_showCurrentTimeIndicator(const value: boolean);
    procedure Set_startDateExpr(const value: string);
    procedure Set_startDateTimeZoneExpr(const value: string);
    procedure Set_startDayHour(const value: integer);
    procedure Set_tabIndex(const value: integer);
    procedure Set_textExpr(const value: string);
    procedure Set_timeCellTemplate(const value: JSValue);
    procedure Set_timeZone(const value: string);
    procedure Set_useDropDownViewSwitcher(const value: boolean);
    procedure Set_views(const value: TJSArray);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onAppointmentAdded(const value: TdxEventHandler);
    procedure Set_onAppointmentAdding(const value: TdxEventHandler);
    procedure Set_onAppointmentClick(const value: TdxEventHandler);
    procedure Set_onAppointmentContextMenu(const value: TdxEventHandler);
    procedure Set_onAppointmentDblClick(const value: TdxEventHandler);
    procedure Set_onAppointmentDeleted(const value: TdxEventHandler);
    procedure Set_onAppointmentDeleting(const value: TdxEventHandler);
    procedure Set_onAppointmentFormOpening(const value: TdxEventHandler);
    procedure Set_onAppointmentRendered(const value: TdxEventHandler);
    procedure Set_onAppointmentTooltipShowing(const value: TdxEventHandler);
    procedure Set_onAppointmentUpdated(const value: TdxEventHandler);
    procedure Set_onAppointmentUpdating(const value: TdxEventHandler);
    procedure Set_onCellClick(const value: TdxEventHandler);
    procedure Set_onCellContextMenu(const value: TdxEventHandler);
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxScheduler; assembler;
    function instance: TdxScheduler; assembler;
  public
    procedure addAppointment(appointment: JSValue); assembler;
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure deleteAppointment(appointment: JSValue); assembler;
    procedure deleteRecurrence(appointmentData: JSValue; date: JSValue; recurrenceEditMode: JSValue); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler;
    function getDataSource(): TJSObject; assembler;
    function getEndViewDate(): TDateTime; assembler;
    function getStartViewDate(): TDateTime; assembler;
    procedure hideAppointmentPopup(saveChanges: JSValue); assembler;
    procedure hideAppointmentTooltip(); assembler;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler; overload;
    procedure registerKeyHandler(); assembler; overload;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure scrollTo(date: TDateTime; group: JSValue; allDay: JSValue); assembler;
    procedure scrollToTime(hours: integer; minutes: integer; date: JSValue); assembler;
    procedure showAppointmentPopup(appointmentData: JSValue; createNewAppointment: JSValue; currentAppointmentData: JSValue); assembler;
    procedure showAppointmentTooltip(appointmentData: JSValue; target: JSValue; currentAppointmentData: JSValue); assembler;
    procedure updateAppointment(target: JSValue; appointment: JSValue); assembler;
  public
    property appointmentCollectorTemplate: JSValue read FappointmentCollectorTemplate write Set_appointmentCollectorTemplate;
    property appointmentDragging: TJSObject read FappointmentDragging write Set_appointmentDragging;
    property appointmentPopupTemplate: JSValue read FappointmentPopupTemplate write Set_appointmentPopupTemplate;
    property appointmentTemplate: JSValue read FappointmentTemplate write Set_appointmentTemplate;
    property appointmentTooltipTemplate: JSValue read FappointmentTooltipTemplate write Set_appointmentTooltipTemplate;
    property currentDate: JSValue read FcurrentDate write Set_currentDate;
    property customizeDateNavigatorText: TJSFunction read FcustomizeDateNavigatorText write Set_customizeDateNavigatorText;
    property dataCellTemplate: JSValue read FdataCellTemplate write Set_dataCellTemplate;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property dateCellTemplate: JSValue read FdateCellTemplate write Set_dateCellTemplate;
    property editing: TJSObject read Fediting write Set_editing;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property groups: TJSArray read Fgroups write Set_groups;
    property height_: JSValue read Fheight_ write Set_height_;
    property max: JSValue read Fmax write Set_max;
    property maxAppointmentsPerCell: JSValue read FmaxAppointmentsPerCell write Set_maxAppointmentsPerCell;
    property min: JSValue read Fmin write Set_min;
    property resourceCellTemplate: JSValue read FresourceCellTemplate write Set_resourceCellTemplate;
    property resources: TJSArray read Fresources write Set_resources;
    property scrolling: JSValue read Fscrolling write Set_scrolling;
    property selectedCellData: TJSArray read FselectedCellData;
    property timeCellTemplate: JSValue read FtimeCellTemplate write Set_timeCellTemplate;
    property views: TJSArray read Fviews write Set_views;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property adaptivityEnabled: boolean read FadaptivityEnabled write Set_adaptivityEnabled default false;
    property allDayExpr: string read FallDayExpr write Set_allDayExpr;
    property allDayPanelMode: TdxAllDayPanelMode read FallDayPanelMode write Set_allDayPanelMode default adpmAll;
    property cellDuration: integer read FcellDuration write Set_cellDuration;
    property crossScrollingEnabled: boolean read FcrossScrollingEnabled write Set_crossScrollingEnabled default false;
    property currentView: TdxViewType read FcurrentView write Set_currentView default vtDay;
    property dateSerializationFormat: string read FdateSerializationFormat write Set_dateSerializationFormat;
    property descriptionExpr: string read FdescriptionExpr write Set_descriptionExpr;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property endDateExpr: string read FendDateExpr write Set_endDateExpr;
    property endDateTimeZoneExpr: string read FendDateTimeZoneExpr write Set_endDateTimeZoneExpr;
    property endDayHour: integer read FendDayHour write Set_endDayHour;
    property firstDayOfWeek: TdxFirstDayOfWeek read FfirstDayOfWeek write Set_firstDayOfWeek default fdow0;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property groupByDate: boolean read FgroupByDate write Set_groupByDate default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property indicatorTime: TDateTime read FindicatorTime write Set_indicatorTime;
    property indicatorUpdateInterval: integer read FindicatorUpdateInterval write Set_indicatorUpdateInterval;
    property noDataText: string read FnoDataText write Set_noDataText;
    property recurrenceEditMode: TdxRecurrenceEditMode read FrecurrenceEditMode write Set_recurrenceEditMode default remDialog;
    property recurrenceExceptionExpr: string read FrecurrenceExceptionExpr write Set_recurrenceExceptionExpr;
    property recurrenceRuleExpr: string read FrecurrenceRuleExpr write Set_recurrenceRuleExpr;
    property remoteFiltering: boolean read FremoteFiltering write Set_remoteFiltering default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property shadeUntilCurrentTime: boolean read FshadeUntilCurrentTime write Set_shadeUntilCurrentTime default false;
    property showAllDayPanel: boolean read FshowAllDayPanel write Set_showAllDayPanel default true;
    property showCurrentTimeIndicator: boolean read FshowCurrentTimeIndicator write Set_showCurrentTimeIndicator default true;
    property startDateExpr: string read FstartDateExpr write Set_startDateExpr;
    property startDateTimeZoneExpr: string read FstartDateTimeZoneExpr write Set_startDateTimeZoneExpr;
    property startDayHour: integer read FstartDayHour write Set_startDayHour;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property textExpr: string read FtextExpr write Set_textExpr;
    property timeZone: string read FtimeZone write Set_timeZone;
    property useDropDownViewSwitcher: boolean read FuseDropDownViewSwitcher write Set_useDropDownViewSwitcher;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onAppointmentAdded: TdxEventHandler read FonAppointmentAdded write Set_onAppointmentAdded;
    property onAppointmentAdding: TdxEventHandler read FonAppointmentAdding write Set_onAppointmentAdding;
    property onAppointmentClick: TdxEventHandler read FonAppointmentClick write Set_onAppointmentClick;
    property onAppointmentContextMenu: TdxEventHandler read FonAppointmentContextMenu write Set_onAppointmentContextMenu;
    property onAppointmentDblClick: TdxEventHandler read FonAppointmentDblClick write Set_onAppointmentDblClick;
    property onAppointmentDeleted: TdxEventHandler read FonAppointmentDeleted write Set_onAppointmentDeleted;
    property onAppointmentDeleting: TdxEventHandler read FonAppointmentDeleting write Set_onAppointmentDeleting;
    property onAppointmentFormOpening: TdxEventHandler read FonAppointmentFormOpening write Set_onAppointmentFormOpening;
    property onAppointmentRendered: TdxEventHandler read FonAppointmentRendered write Set_onAppointmentRendered;
    property onAppointmentTooltipShowing: TdxEventHandler read FonAppointmentTooltipShowing write Set_onAppointmentTooltipShowing;
    property onAppointmentUpdated: TdxEventHandler read FonAppointmentUpdated write Set_onAppointmentUpdated;
    property onAppointmentUpdating: TdxEventHandler read FonAppointmentUpdating write Set_onAppointmentUpdating;
    property onCellClick: TdxEventHandler read FonCellClick write Set_onCellClick;
    property onCellContextMenu: TdxEventHandler read FonCellContextMenu write Set_onCellContextMenu;
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
  end;

implementation


procedure TjdxCustomScheduler.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FadaptivityEnabled := false;
  FallDayExpr := '';
  FallDayPanelMode := adpmAll;
  FappointmentCollectorTemplate := nil;
  FappointmentDragging := TJSObject.new;
  FappointmentPopupTemplate := nil;
  FappointmentTemplate := nil;
  FappointmentTooltipTemplate := nil;
  FcellDuration := 0;
  FcrossScrollingEnabled := false;
  FcurrentDate := nil;
  FcurrentView := vtDay;
  FcustomizeDateNavigatorText := nil;
  FdataCellTemplate := nil;
  FdataSource := nil;
  FdateCellTemplate := nil;
  FdateSerializationFormat := '';
  FdescriptionExpr := '';
  Fdisabled := false;
  Fediting := TJSObject.new;
  FelementAttr := TJSObject.new;
  FendDateExpr := '';
  FendDateTimeZoneExpr := '';
  FendDayHour := 0;
  FfirstDayOfWeek := fdow0;
  FfocusStateEnabled := false;
  FgroupByDate := false;
  Fgroups := TJSArray.new;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FindicatorTime := 0;
  FindicatorUpdateInterval := 0;
  Fmax := nil;
  FmaxAppointmentsPerCell := nil;
  Fmin := nil;
  FnoDataText := '';
  FrecurrenceEditMode := remDialog;
  FrecurrenceExceptionExpr := '';
  FrecurrenceRuleExpr := '';
  FremoteFiltering := false;
  FresourceCellTemplate := nil;
  Fresources := TJSArray.new;
  FrtlEnabled := false;
  Fscrolling := nil;
  FselectedCellData := TJSArray.new;
  FshadeUntilCurrentTime := false;
  FshowAllDayPanel := true;
  FshowCurrentTimeIndicator := true;
  FstartDateExpr := '';
  FstartDateTimeZoneExpr := '';
  FstartDayHour := 0;
  FtabIndex := 0;
  FtextExpr := '';
  FtimeCellTemplate := nil;
  FtimeZone := '';
  FuseDropDownViewSwitcher := false;
  Fviews := TJSArray.new;
  Fvisible := true;
  Fwidth_ := nil;

  FonAppointmentAdded := nil;
  FonAppointmentAdding := nil;
  FonAppointmentClick := nil;
  FonAppointmentContextMenu := nil;
  FonAppointmentDblClick := nil;
  FonAppointmentDeleted := nil;
  FonAppointmentDeleting := nil;
  FonAppointmentFormOpening := nil;
  FonAppointmentRendered := nil;
  FonAppointmentTooltipShowing := nil;
  FonAppointmentUpdated := nil;
  FonAppointmentUpdating := nil;
  FonCellClick := nil;
  FonCellContextMenu := nil;
  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
end;
procedure TjdxCustomScheduler.InitJQuery;
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
      $(id).dxScheduler(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomScheduler.getInstance(element: TJSObject): TdxScheduler;
asm
  return DevExpress.viz.dxScheduler.getInstance(element);
end;

function TjdxCustomScheduler.instance: TdxScheduler;
asm
  return $(this.GetJQID()).dxScheduler("instance");
end;
procedure TjdxCustomScheduler.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('adaptivityEnabled', adaptivityEnabled);
    SetOption('allDayExpr', allDayExpr);
    SetOption('allDayPanelMode', allDayPanelMode.ToString());
    SetOption('appointmentCollectorTemplate', appointmentCollectorTemplate);
    SetOption('appointmentDragging', appointmentDragging);
    SetOption('appointmentPopupTemplate', appointmentPopupTemplate);
    SetOption('appointmentTemplate', appointmentTemplate);
    SetOption('appointmentTooltipTemplate', appointmentTooltipTemplate);
    SetOption('cellDuration', cellDuration);
    SetOption('crossScrollingEnabled', crossScrollingEnabled);
    SetOption('currentDate', currentDate);
    SetOption('currentView', currentView.ToString());
    SetOption('customizeDateNavigatorText', customizeDateNavigatorText);
    SetOption('dataCellTemplate', dataCellTemplate);
    SetOption('dataSource', dataSource);
    SetOption('dateCellTemplate', dateCellTemplate);
    SetOption('dateSerializationFormat', dateSerializationFormat);
    SetOption('descriptionExpr', descriptionExpr);
    SetOption('disabled', disabled);
    SetOption('editing', editing);
    SetOption('elementAttr', elementAttr);
    SetOption('endDateExpr', endDateExpr);
    SetOption('endDateTimeZoneExpr', endDateTimeZoneExpr);
    SetOption('endDayHour', endDayHour);
    SetOption('firstDayOfWeek', firstDayOfWeek.ToString());
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('groupByDate', groupByDate);
    SetOption('groups', groups);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('indicatorTime', indicatorTime);
    SetOption('indicatorUpdateInterval', indicatorUpdateInterval);
    SetOption('max', max);
    SetOption('maxAppointmentsPerCell', maxAppointmentsPerCell);
    SetOption('min', min);
    SetOption('noDataText', noDataText);
    SetOption('recurrenceEditMode', recurrenceEditMode.ToString());
    SetOption('recurrenceExceptionExpr', recurrenceExceptionExpr);
    SetOption('recurrenceRuleExpr', recurrenceRuleExpr);
    SetOption('remoteFiltering', remoteFiltering);
    SetOption('resourceCellTemplate', resourceCellTemplate);
    SetOption('resources', resources);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('scrolling', scrolling);
    SetOption('selectedCellData', selectedCellData);
    SetOption('shadeUntilCurrentTime', shadeUntilCurrentTime);
    SetOption('showAllDayPanel', showAllDayPanel);
    SetOption('showCurrentTimeIndicator', showCurrentTimeIndicator);
    SetOption('startDateExpr', startDateExpr);
    SetOption('startDateTimeZoneExpr', startDateTimeZoneExpr);
    SetOption('startDayHour', startDayHour);
    SetOption('tabIndex', tabIndex);
    SetOption('textExpr', textExpr);
    SetOption('timeCellTemplate', timeCellTemplate);
    SetOption('timeZone', timeZone);
    SetOption('useDropDownViewSwitcher', useDropDownViewSwitcher);
    SetOption('views', views);
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('appointmentAdded', onAppointmentAdded);
    SetEvent('appointmentAdding', onAppointmentAdding);
    SetEvent('appointmentClick', onAppointmentClick);
    SetEvent('appointmentContextMenu', onAppointmentContextMenu);
    SetEvent('appointmentDblClick', onAppointmentDblClick);
    SetEvent('appointmentDeleted', onAppointmentDeleted);
    SetEvent('appointmentDeleting', onAppointmentDeleting);
    SetEvent('appointmentFormOpening', onAppointmentFormOpening);
    SetEvent('appointmentRendered', onAppointmentRendered);
    SetEvent('appointmentTooltipShowing', onAppointmentTooltipShowing);
    SetEvent('appointmentUpdated', onAppointmentUpdated);
    SetEvent('appointmentUpdating', onAppointmentUpdating);
    SetEvent('cellClick', onCellClick);
    SetEvent('cellContextMenu', onCellContextMenu);
    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomScheduler.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomScheduler.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomScheduler.Set_adaptivityEnabled(const Value: boolean);
begin
  FadaptivityEnabled := Value;
  SetOption('adaptivityEnabled', adaptivityEnabled);
end;

procedure TjdxCustomScheduler.Set_allDayExpr(const Value: string);
begin
  FallDayExpr := Value;
  SetOption('allDayExpr', allDayExpr);
end;

procedure TjdxCustomScheduler.Set_allDayPanelMode(const Value: TdxAllDayPanelMode);
begin
  FallDayPanelMode := Value;
  SetOption('allDayPanelMode', allDayPanelMode.ToString());
end;

procedure TjdxCustomScheduler.Set_appointmentCollectorTemplate(const Value: JSValue);
begin
  FappointmentCollectorTemplate := Value;
  SetOption('appointmentCollectorTemplate', appointmentCollectorTemplate);
end;

procedure TjdxCustomScheduler.Set_appointmentDragging(const Value: TJSObject);
begin
  FappointmentDragging := Value;
  SetOption('appointmentDragging', appointmentDragging);
end;

procedure TjdxCustomScheduler.Set_appointmentPopupTemplate(const Value: JSValue);
begin
  FappointmentPopupTemplate := Value;
  SetOption('appointmentPopupTemplate', appointmentPopupTemplate);
end;

procedure TjdxCustomScheduler.Set_appointmentTemplate(const Value: JSValue);
begin
  FappointmentTemplate := Value;
  SetOption('appointmentTemplate', appointmentTemplate);
end;

procedure TjdxCustomScheduler.Set_appointmentTooltipTemplate(const Value: JSValue);
begin
  FappointmentTooltipTemplate := Value;
  SetOption('appointmentTooltipTemplate', appointmentTooltipTemplate);
end;

procedure TjdxCustomScheduler.Set_cellDuration(const Value: integer);
begin
  FcellDuration := Value;
  SetOption('cellDuration', cellDuration);
end;

procedure TjdxCustomScheduler.Set_crossScrollingEnabled(const Value: boolean);
begin
  FcrossScrollingEnabled := Value;
  SetOption('crossScrollingEnabled', crossScrollingEnabled);
end;

procedure TjdxCustomScheduler.Set_currentDate(const Value: JSValue);
begin
  FcurrentDate := Value;
  SetOption('currentDate', currentDate);
end;

procedure TjdxCustomScheduler.Set_currentView(const Value: TdxViewType);
begin
  FcurrentView := Value;
  SetOption('currentView', currentView.ToString());
end;

procedure TjdxCustomScheduler.Set_customizeDateNavigatorText(const Value: TJSFunction);
begin
  FcustomizeDateNavigatorText := Value;
  SetOption('customizeDateNavigatorText', customizeDateNavigatorText);
end;

procedure TjdxCustomScheduler.Set_dataCellTemplate(const Value: JSValue);
begin
  FdataCellTemplate := Value;
  SetOption('dataCellTemplate', dataCellTemplate);
end;

procedure TjdxCustomScheduler.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomScheduler.Set_dateCellTemplate(const Value: JSValue);
begin
  FdateCellTemplate := Value;
  SetOption('dateCellTemplate', dateCellTemplate);
end;

procedure TjdxCustomScheduler.Set_dateSerializationFormat(const Value: string);
begin
  FdateSerializationFormat := Value;
  SetOption('dateSerializationFormat', dateSerializationFormat);
end;

procedure TjdxCustomScheduler.Set_descriptionExpr(const Value: string);
begin
  FdescriptionExpr := Value;
  SetOption('descriptionExpr', descriptionExpr);
end;

procedure TjdxCustomScheduler.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomScheduler.Set_editing(const Value: TJSObject);
begin
  Fediting := Value;
  SetOption('editing', editing);
end;

procedure TjdxCustomScheduler.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomScheduler.Set_endDateExpr(const Value: string);
begin
  FendDateExpr := Value;
  SetOption('endDateExpr', endDateExpr);
end;

procedure TjdxCustomScheduler.Set_endDateTimeZoneExpr(const Value: string);
begin
  FendDateTimeZoneExpr := Value;
  SetOption('endDateTimeZoneExpr', endDateTimeZoneExpr);
end;

procedure TjdxCustomScheduler.Set_endDayHour(const Value: integer);
begin
  FendDayHour := Value;
  SetOption('endDayHour', endDayHour);
end;

procedure TjdxCustomScheduler.Set_firstDayOfWeek(const Value: TdxFirstDayOfWeek);
begin
  FfirstDayOfWeek := Value;
  SetOption('firstDayOfWeek', firstDayOfWeek.ToString());
end;

procedure TjdxCustomScheduler.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomScheduler.Set_groupByDate(const Value: boolean);
begin
  FgroupByDate := Value;
  SetOption('groupByDate', groupByDate);
end;

procedure TjdxCustomScheduler.Set_groups(const Value: TJSArray);
begin
  Fgroups := Value;
  SetOption('groups', groups);
end;

procedure TjdxCustomScheduler.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomScheduler.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomScheduler.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomScheduler.Set_indicatorTime(const Value: TDateTime);
begin
  FindicatorTime := Value;
  SetOption('indicatorTime', indicatorTime);
end;

procedure TjdxCustomScheduler.Set_indicatorUpdateInterval(const Value: integer);
begin
  FindicatorUpdateInterval := Value;
  SetOption('indicatorUpdateInterval', indicatorUpdateInterval);
end;

procedure TjdxCustomScheduler.Set_max(const Value: JSValue);
begin
  Fmax := Value;
  SetOption('max', max);
end;

procedure TjdxCustomScheduler.Set_maxAppointmentsPerCell(const Value: JSValue);
begin
  FmaxAppointmentsPerCell := Value;
  SetOption('maxAppointmentsPerCell', maxAppointmentsPerCell);
end;

procedure TjdxCustomScheduler.Set_min(const Value: JSValue);
begin
  Fmin := Value;
  SetOption('min', min);
end;

procedure TjdxCustomScheduler.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
  SetOption('noDataText', noDataText);
end;

procedure TjdxCustomScheduler.Set_recurrenceEditMode(const Value: TdxRecurrenceEditMode);
begin
  FrecurrenceEditMode := Value;
  SetOption('recurrenceEditMode', recurrenceEditMode.ToString());
end;

procedure TjdxCustomScheduler.Set_recurrenceExceptionExpr(const Value: string);
begin
  FrecurrenceExceptionExpr := Value;
  SetOption('recurrenceExceptionExpr', recurrenceExceptionExpr);
end;

procedure TjdxCustomScheduler.Set_recurrenceRuleExpr(const Value: string);
begin
  FrecurrenceRuleExpr := Value;
  SetOption('recurrenceRuleExpr', recurrenceRuleExpr);
end;

procedure TjdxCustomScheduler.Set_remoteFiltering(const Value: boolean);
begin
  FremoteFiltering := Value;
  SetOption('remoteFiltering', remoteFiltering);
end;

procedure TjdxCustomScheduler.Set_resourceCellTemplate(const Value: JSValue);
begin
  FresourceCellTemplate := Value;
  SetOption('resourceCellTemplate', resourceCellTemplate);
end;

procedure TjdxCustomScheduler.Set_resources(const Value: TJSArray);
begin
  Fresources := Value;
  SetOption('resources', resources);
end;

procedure TjdxCustomScheduler.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomScheduler.Set_scrolling(const Value: JSValue);
begin
  Fscrolling := Value;
  SetOption('scrolling', scrolling);
end;

procedure TjdxCustomScheduler.Set_shadeUntilCurrentTime(const Value: boolean);
begin
  FshadeUntilCurrentTime := Value;
  SetOption('shadeUntilCurrentTime', shadeUntilCurrentTime);
end;

procedure TjdxCustomScheduler.Set_showAllDayPanel(const Value: boolean);
begin
  FshowAllDayPanel := Value;
  SetOption('showAllDayPanel', showAllDayPanel);
end;

procedure TjdxCustomScheduler.Set_showCurrentTimeIndicator(const Value: boolean);
begin
  FshowCurrentTimeIndicator := Value;
  SetOption('showCurrentTimeIndicator', showCurrentTimeIndicator);
end;

procedure TjdxCustomScheduler.Set_startDateExpr(const Value: string);
begin
  FstartDateExpr := Value;
  SetOption('startDateExpr', startDateExpr);
end;

procedure TjdxCustomScheduler.Set_startDateTimeZoneExpr(const Value: string);
begin
  FstartDateTimeZoneExpr := Value;
  SetOption('startDateTimeZoneExpr', startDateTimeZoneExpr);
end;

procedure TjdxCustomScheduler.Set_startDayHour(const Value: integer);
begin
  FstartDayHour := Value;
  SetOption('startDayHour', startDayHour);
end;

procedure TjdxCustomScheduler.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomScheduler.Set_textExpr(const Value: string);
begin
  FtextExpr := Value;
  SetOption('textExpr', textExpr);
end;

procedure TjdxCustomScheduler.Set_timeCellTemplate(const Value: JSValue);
begin
  FtimeCellTemplate := Value;
  SetOption('timeCellTemplate', timeCellTemplate);
end;

procedure TjdxCustomScheduler.Set_timeZone(const Value: string);
begin
  FtimeZone := Value;
  SetOption('timeZone', timeZone);
end;

procedure TjdxCustomScheduler.Set_useDropDownViewSwitcher(const Value: boolean);
begin
  FuseDropDownViewSwitcher := Value;
  SetOption('useDropDownViewSwitcher', useDropDownViewSwitcher);
end;

procedure TjdxCustomScheduler.Set_views(const Value: TJSArray);
begin
  Fviews := Value;
  SetOption('views', views);
end;

procedure TjdxCustomScheduler.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomScheduler.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomScheduler.Set_onAppointmentAdded(const Value: TdxEventHandler);
begin
  FonAppointmentAdded := Value;
  SetEvent('appointmentAdded', onAppointmentAdded);
end;

procedure TjdxCustomScheduler.Set_onAppointmentAdding(const Value: TdxEventHandler);
begin
  FonAppointmentAdding := Value;
  SetEvent('appointmentAdding', onAppointmentAdding);
end;

procedure TjdxCustomScheduler.Set_onAppointmentClick(const Value: TdxEventHandler);
begin
  FonAppointmentClick := Value;
  SetEvent('appointmentClick', onAppointmentClick);
end;

procedure TjdxCustomScheduler.Set_onAppointmentContextMenu(const Value: TdxEventHandler);
begin
  FonAppointmentContextMenu := Value;
  SetEvent('appointmentContextMenu', onAppointmentContextMenu);
end;

procedure TjdxCustomScheduler.Set_onAppointmentDblClick(const Value: TdxEventHandler);
begin
  FonAppointmentDblClick := Value;
  SetEvent('appointmentDblClick', onAppointmentDblClick);
end;

procedure TjdxCustomScheduler.Set_onAppointmentDeleted(const Value: TdxEventHandler);
begin
  FonAppointmentDeleted := Value;
  SetEvent('appointmentDeleted', onAppointmentDeleted);
end;

procedure TjdxCustomScheduler.Set_onAppointmentDeleting(const Value: TdxEventHandler);
begin
  FonAppointmentDeleting := Value;
  SetEvent('appointmentDeleting', onAppointmentDeleting);
end;

procedure TjdxCustomScheduler.Set_onAppointmentFormOpening(const Value: TdxEventHandler);
begin
  FonAppointmentFormOpening := Value;
  SetEvent('appointmentFormOpening', onAppointmentFormOpening);
end;

procedure TjdxCustomScheduler.Set_onAppointmentRendered(const Value: TdxEventHandler);
begin
  FonAppointmentRendered := Value;
  SetEvent('appointmentRendered', onAppointmentRendered);
end;

procedure TjdxCustomScheduler.Set_onAppointmentTooltipShowing(const Value: TdxEventHandler);
begin
  FonAppointmentTooltipShowing := Value;
  SetEvent('appointmentTooltipShowing', onAppointmentTooltipShowing);
end;

procedure TjdxCustomScheduler.Set_onAppointmentUpdated(const Value: TdxEventHandler);
begin
  FonAppointmentUpdated := Value;
  SetEvent('appointmentUpdated', onAppointmentUpdated);
end;

procedure TjdxCustomScheduler.Set_onAppointmentUpdating(const Value: TdxEventHandler);
begin
  FonAppointmentUpdating := Value;
  SetEvent('appointmentUpdating', onAppointmentUpdating);
end;

procedure TjdxCustomScheduler.Set_onCellClick(const Value: TdxEventHandler);
begin
  FonCellClick := Value;
  SetEvent('cellClick', onCellClick);
end;

procedure TjdxCustomScheduler.Set_onCellContextMenu(const Value: TdxEventHandler);
begin
  FonCellContextMenu := Value;
  SetEvent('cellContextMenu', onCellContextMenu);
end;

procedure TjdxCustomScheduler.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomScheduler.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomScheduler.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomScheduler.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomScheduler.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomScheduler.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomScheduler.addAppointment(appointment: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.addAppointment(appointment);
end;

procedure TjdxCustomScheduler.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomScheduler.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomScheduler.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomScheduler.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomScheduler.deleteAppointment(appointment: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.deleteAppointment(appointment);
end;

procedure TjdxCustomScheduler.deleteRecurrence(appointmentData: JSValue; date: JSValue; recurrenceEditMode: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.deleteRecurrence(appointmentData, date, recurrenceEditMode);
end;

procedure TjdxCustomScheduler.dispose();
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.dispose();
end;

function TjdxCustomScheduler.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  return _instance.element();
end;

procedure TjdxCustomScheduler.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomScheduler.focus();
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.focus();
end;

function TjdxCustomScheduler.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  return _instance.getDataSource();
end;

function TjdxCustomScheduler.getEndViewDate(): TDateTime;
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  return _instance.getEndViewDate();
end;

function TjdxCustomScheduler.getStartViewDate(): TDateTime;
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  return _instance.getStartViewDate();
end;

procedure TjdxCustomScheduler.hideAppointmentPopup(saveChanges: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.hideAppointmentPopup(saveChanges);
end;

procedure TjdxCustomScheduler.hideAppointmentTooltip();
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.hideAppointmentTooltip();
end;

function TjdxCustomScheduler.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  return _instance.off(eventName);
end;

function TjdxCustomScheduler.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomScheduler.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  return _instance.on(events);
end;

function TjdxCustomScheduler.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  return _instance.on(eventName, eventHandler);
end;

procedure TjdxCustomScheduler.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.option(options);
end;

function TjdxCustomScheduler.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomScheduler.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomScheduler.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  return _instance.option();
end;

procedure TjdxCustomScheduler.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomScheduler.registerKeyHandler();
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.registerKeyHandler();
end;

procedure TjdxCustomScheduler.repaint();
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.repaint();
end;

procedure TjdxCustomScheduler.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomScheduler.scrollTo(date: TDateTime; group: JSValue; allDay: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.scrollTo(date, group, allDay);
end;

procedure TjdxCustomScheduler.scrollToTime(hours: integer; minutes: integer; date: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.scrollToTime(hours, minutes, date);
end;

procedure TjdxCustomScheduler.showAppointmentPopup(appointmentData: JSValue; createNewAppointment: JSValue; currentAppointmentData: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.showAppointmentPopup(appointmentData, createNewAppointment, currentAppointmentData);
end;

procedure TjdxCustomScheduler.showAppointmentTooltip(appointmentData: JSValue; target: JSValue; currentAppointmentData: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.showAppointmentTooltip(appointmentData, target, currentAppointmentData);
end;

procedure TjdxCustomScheduler.updateAppointment(target: JSValue; appointment: JSValue);
asm
  const _instance = $(this.GetJQID()).dxScheduler("instance");
  _instance.updateAppointment(target, appointment);
end;

end.
