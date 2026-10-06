unit DevExtreme.Scheduler;

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
  TjdxScheduler = class(TjdxCustomControl)
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
  public
    constructor Create(aOwner: TComponent); override;
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


constructor TjdxScheduler.Create(aOwner: TComponent);
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

procedure TjdxScheduler.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxScheduler.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxScheduler.Set_adaptivityEnabled(const Value: boolean);
begin
  FadaptivityEnabled := Value;
end;

procedure TjdxScheduler.Set_allDayExpr(const Value: string);
begin
  FallDayExpr := Value;
end;

procedure TjdxScheduler.Set_allDayPanelMode(const Value: TdxAllDayPanelMode);
begin
  FallDayPanelMode := Value;
end;

procedure TjdxScheduler.Set_appointmentCollectorTemplate(const Value: JSValue);
begin
  FappointmentCollectorTemplate := Value;
end;

procedure TjdxScheduler.Set_appointmentDragging(const Value: TJSObject);
begin
  FappointmentDragging := Value;
end;

procedure TjdxScheduler.Set_appointmentPopupTemplate(const Value: JSValue);
begin
  FappointmentPopupTemplate := Value;
end;

procedure TjdxScheduler.Set_appointmentTemplate(const Value: JSValue);
begin
  FappointmentTemplate := Value;
end;

procedure TjdxScheduler.Set_appointmentTooltipTemplate(const Value: JSValue);
begin
  FappointmentTooltipTemplate := Value;
end;

procedure TjdxScheduler.Set_cellDuration(const Value: integer);
begin
  FcellDuration := Value;
end;

procedure TjdxScheduler.Set_crossScrollingEnabled(const Value: boolean);
begin
  FcrossScrollingEnabled := Value;
end;

procedure TjdxScheduler.Set_currentDate(const Value: JSValue);
begin
  FcurrentDate := Value;
end;

procedure TjdxScheduler.Set_currentView(const Value: TdxViewType);
begin
  FcurrentView := Value;
end;

procedure TjdxScheduler.Set_customizeDateNavigatorText(const Value: TJSFunction);
begin
  FcustomizeDateNavigatorText := Value;
end;

procedure TjdxScheduler.Set_dataCellTemplate(const Value: JSValue);
begin
  FdataCellTemplate := Value;
end;

procedure TjdxScheduler.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxScheduler.Set_dateCellTemplate(const Value: JSValue);
begin
  FdateCellTemplate := Value;
end;

procedure TjdxScheduler.Set_dateSerializationFormat(const Value: string);
begin
  FdateSerializationFormat := Value;
end;

procedure TjdxScheduler.Set_descriptionExpr(const Value: string);
begin
  FdescriptionExpr := Value;
end;

procedure TjdxScheduler.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxScheduler.Set_editing(const Value: TJSObject);
begin
  Fediting := Value;
end;

procedure TjdxScheduler.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxScheduler.Set_endDateExpr(const Value: string);
begin
  FendDateExpr := Value;
end;

procedure TjdxScheduler.Set_endDateTimeZoneExpr(const Value: string);
begin
  FendDateTimeZoneExpr := Value;
end;

procedure TjdxScheduler.Set_endDayHour(const Value: integer);
begin
  FendDayHour := Value;
end;

procedure TjdxScheduler.Set_firstDayOfWeek(const Value: TdxFirstDayOfWeek);
begin
  FfirstDayOfWeek := Value;
end;

procedure TjdxScheduler.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxScheduler.Set_groupByDate(const Value: boolean);
begin
  FgroupByDate := Value;
end;

procedure TjdxScheduler.Set_groups(const Value: TJSArray);
begin
  Fgroups := Value;
end;

procedure TjdxScheduler.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxScheduler.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxScheduler.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxScheduler.Set_indicatorTime(const Value: TDateTime);
begin
  FindicatorTime := Value;
end;

procedure TjdxScheduler.Set_indicatorUpdateInterval(const Value: integer);
begin
  FindicatorUpdateInterval := Value;
end;

procedure TjdxScheduler.Set_max(const Value: JSValue);
begin
  Fmax := Value;
end;

procedure TjdxScheduler.Set_maxAppointmentsPerCell(const Value: JSValue);
begin
  FmaxAppointmentsPerCell := Value;
end;

procedure TjdxScheduler.Set_min(const Value: JSValue);
begin
  Fmin := Value;
end;

procedure TjdxScheduler.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
end;

procedure TjdxScheduler.Set_recurrenceEditMode(const Value: TdxRecurrenceEditMode);
begin
  FrecurrenceEditMode := Value;
end;

procedure TjdxScheduler.Set_recurrenceExceptionExpr(const Value: string);
begin
  FrecurrenceExceptionExpr := Value;
end;

procedure TjdxScheduler.Set_recurrenceRuleExpr(const Value: string);
begin
  FrecurrenceRuleExpr := Value;
end;

procedure TjdxScheduler.Set_remoteFiltering(const Value: boolean);
begin
  FremoteFiltering := Value;
end;

procedure TjdxScheduler.Set_resourceCellTemplate(const Value: JSValue);
begin
  FresourceCellTemplate := Value;
end;

procedure TjdxScheduler.Set_resources(const Value: TJSArray);
begin
  Fresources := Value;
end;

procedure TjdxScheduler.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxScheduler.Set_scrolling(const Value: JSValue);
begin
  Fscrolling := Value;
end;

procedure TjdxScheduler.Set_shadeUntilCurrentTime(const Value: boolean);
begin
  FshadeUntilCurrentTime := Value;
end;

procedure TjdxScheduler.Set_showAllDayPanel(const Value: boolean);
begin
  FshowAllDayPanel := Value;
end;

procedure TjdxScheduler.Set_showCurrentTimeIndicator(const Value: boolean);
begin
  FshowCurrentTimeIndicator := Value;
end;

procedure TjdxScheduler.Set_startDateExpr(const Value: string);
begin
  FstartDateExpr := Value;
end;

procedure TjdxScheduler.Set_startDateTimeZoneExpr(const Value: string);
begin
  FstartDateTimeZoneExpr := Value;
end;

procedure TjdxScheduler.Set_startDayHour(const Value: integer);
begin
  FstartDayHour := Value;
end;

procedure TjdxScheduler.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxScheduler.Set_textExpr(const Value: string);
begin
  FtextExpr := Value;
end;

procedure TjdxScheduler.Set_timeCellTemplate(const Value: JSValue);
begin
  FtimeCellTemplate := Value;
end;

procedure TjdxScheduler.Set_timeZone(const Value: string);
begin
  FtimeZone := Value;
end;

procedure TjdxScheduler.Set_useDropDownViewSwitcher(const Value: boolean);
begin
  FuseDropDownViewSwitcher := Value;
end;

procedure TjdxScheduler.Set_views(const Value: TJSArray);
begin
  Fviews := Value;
end;

procedure TjdxScheduler.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxScheduler.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxScheduler.Set_onAppointmentAdded(const Value: TdxEventHandler);
begin
  FonAppointmentAdded := Value;
end;

procedure TjdxScheduler.Set_onAppointmentAdding(const Value: TdxEventHandler);
begin
  FonAppointmentAdding := Value;
end;

procedure TjdxScheduler.Set_onAppointmentClick(const Value: TdxEventHandler);
begin
  FonAppointmentClick := Value;
end;

procedure TjdxScheduler.Set_onAppointmentContextMenu(const Value: TdxEventHandler);
begin
  FonAppointmentContextMenu := Value;
end;

procedure TjdxScheduler.Set_onAppointmentDblClick(const Value: TdxEventHandler);
begin
  FonAppointmentDblClick := Value;
end;

procedure TjdxScheduler.Set_onAppointmentDeleted(const Value: TdxEventHandler);
begin
  FonAppointmentDeleted := Value;
end;

procedure TjdxScheduler.Set_onAppointmentDeleting(const Value: TdxEventHandler);
begin
  FonAppointmentDeleting := Value;
end;

procedure TjdxScheduler.Set_onAppointmentFormOpening(const Value: TdxEventHandler);
begin
  FonAppointmentFormOpening := Value;
end;

procedure TjdxScheduler.Set_onAppointmentRendered(const Value: TdxEventHandler);
begin
  FonAppointmentRendered := Value;
end;

procedure TjdxScheduler.Set_onAppointmentTooltipShowing(const Value: TdxEventHandler);
begin
  FonAppointmentTooltipShowing := Value;
end;

procedure TjdxScheduler.Set_onAppointmentUpdated(const Value: TdxEventHandler);
begin
  FonAppointmentUpdated := Value;
end;

procedure TjdxScheduler.Set_onAppointmentUpdating(const Value: TdxEventHandler);
begin
  FonAppointmentUpdating := Value;
end;

procedure TjdxScheduler.Set_onCellClick(const Value: TdxEventHandler);
begin
  FonCellClick := Value;
end;

procedure TjdxScheduler.Set_onCellContextMenu(const Value: TdxEventHandler);
begin
  FonCellContextMenu := Value;
end;

procedure TjdxScheduler.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxScheduler.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxScheduler.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxScheduler.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxScheduler.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxScheduler.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

end.
