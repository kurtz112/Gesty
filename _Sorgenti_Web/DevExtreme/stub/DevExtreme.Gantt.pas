unit DevExtreme.Gantt;

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
  TjdxGantt = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FallowSelection: boolean;
    Fcolumns: TJSArray;
    FcontextMenu: TJSObject;
    Fdependencies: TJSObject;
    Fdisabled: boolean;
    Fediting: TJSObject;
    FelementAttr: TJSObject;
    FendDateRange: TDateTime;
    FfilterRow: JSValue;
    FfirstDayOfWeek: TdxFirstDayOfWeek;
    FfocusStateEnabled: boolean;
    FheaderFilter: JSValue;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FresourceAssignments: TJSObject;
    Fresources: TJSObject;
    FrootValue: JSValue;
    FrtlEnabled: boolean;
    FscaleType: TdxGanttScaleType;
    FscaleTypeRange: TJSObject;
    FselectedRowKey: JSValue;
    FshowDependencies: boolean;
    FshowResources: boolean;
    FshowRowLines: boolean;
    Fsorting: JSValue;
    FstartDateRange: TDateTime;
    FstripLines: TJSArray;
    FtabIndex: integer;
    FtaskContentTemplate: JSValue;
    FtaskListWidth: integer;
    FtaskProgressTooltipContentTemplate: JSValue;
    Ftasks: TJSObject;
    FtaskTimeTooltipContentTemplate: JSValue;
    FtaskTitlePosition: TdxGanttTaskTitlePosition;
    FtaskTooltipContentTemplate: JSValue;
    Ftoolbar: JSValue;
    Fvalidation: TJSObject;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonContextMenuPreparing: TdxEventHandler;
    FonCustomCommand: TdxEventHandler;
    FonDependencyDeleted: TdxEventHandler;
    FonDependencyDeleting: TdxEventHandler;
    FonDependencyInserted: TdxEventHandler;
    FonDependencyInserting: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonResourceAssigned: TdxEventHandler;
    FonResourceAssigning: TdxEventHandler;
    FonResourceDeleted: TdxEventHandler;
    FonResourceDeleting: TdxEventHandler;
    FonResourceInserted: TdxEventHandler;
    FonResourceInserting: TdxEventHandler;
    FonResourceManagerDialogShowing: TdxEventHandler;
    FonResourceUnassigned: TdxEventHandler;
    FonResourceUnassigning: TdxEventHandler;
    FonScaleCellPrepared: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
    FonTaskClick: TdxEventHandler;
    FonTaskDblClick: TdxEventHandler;
    FonTaskDeleted: TdxEventHandler;
    FonTaskDeleting: TdxEventHandler;
    FonTaskEditDialogShowing: TdxEventHandler;
    FonTaskInserted: TdxEventHandler;
    FonTaskInserting: TdxEventHandler;
    FonTaskMoving: TdxEventHandler;
    FonTaskUpdated: TdxEventHandler;
    FonTaskUpdating: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_allowSelection(const value: boolean);
    procedure Set_columns(const value: TJSArray);
    procedure Set_contextMenu(const value: TJSObject);
    procedure Set_dependencies(const value: TJSObject);
    procedure Set_disabled(const value: boolean);
    procedure Set_editing(const value: TJSObject);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_endDateRange(const value: TDateTime);
    procedure Set_filterRow(const value: JSValue);
    procedure Set_firstDayOfWeek(const value: TdxFirstDayOfWeek);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_headerFilter(const value: JSValue);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_resourceAssignments(const value: TJSObject);
    procedure Set_resources(const value: TJSObject);
    procedure Set_rootValue(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scaleType(const value: TdxGanttScaleType);
    procedure Set_scaleTypeRange(const value: TJSObject);
    procedure Set_selectedRowKey(const value: JSValue);
    procedure Set_showDependencies(const value: boolean);
    procedure Set_showResources(const value: boolean);
    procedure Set_showRowLines(const value: boolean);
    procedure Set_sorting(const value: JSValue);
    procedure Set_startDateRange(const value: TDateTime);
    procedure Set_stripLines(const value: TJSArray);
    procedure Set_tabIndex(const value: integer);
    procedure Set_taskContentTemplate(const value: JSValue);
    procedure Set_taskListWidth(const value: integer);
    procedure Set_taskProgressTooltipContentTemplate(const value: JSValue);
    procedure Set_tasks(const value: TJSObject);
    procedure Set_taskTimeTooltipContentTemplate(const value: JSValue);
    procedure Set_taskTitlePosition(const value: TdxGanttTaskTitlePosition);
    procedure Set_taskTooltipContentTemplate(const value: JSValue);
    procedure Set_toolbar(const value: JSValue);
    procedure Set_validation(const value: TJSObject);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onContextMenuPreparing(const value: TdxEventHandler);
    procedure Set_onCustomCommand(const value: TdxEventHandler);
    procedure Set_onDependencyDeleted(const value: TdxEventHandler);
    procedure Set_onDependencyDeleting(const value: TdxEventHandler);
    procedure Set_onDependencyInserted(const value: TdxEventHandler);
    procedure Set_onDependencyInserting(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onResourceAssigned(const value: TdxEventHandler);
    procedure Set_onResourceAssigning(const value: TdxEventHandler);
    procedure Set_onResourceDeleted(const value: TdxEventHandler);
    procedure Set_onResourceDeleting(const value: TdxEventHandler);
    procedure Set_onResourceInserted(const value: TdxEventHandler);
    procedure Set_onResourceInserting(const value: TdxEventHandler);
    procedure Set_onResourceManagerDialogShowing(const value: TdxEventHandler);
    procedure Set_onResourceUnassigned(const value: TdxEventHandler);
    procedure Set_onResourceUnassigning(const value: TdxEventHandler);
    procedure Set_onScaleCellPrepared(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
    procedure Set_onTaskClick(const value: TdxEventHandler);
    procedure Set_onTaskDblClick(const value: TdxEventHandler);
    procedure Set_onTaskDeleted(const value: TdxEventHandler);
    procedure Set_onTaskDeleting(const value: TdxEventHandler);
    procedure Set_onTaskEditDialogShowing(const value: TdxEventHandler);
    procedure Set_onTaskInserted(const value: TdxEventHandler);
    procedure Set_onTaskInserting(const value: TdxEventHandler);
    procedure Set_onTaskMoving(const value: TdxEventHandler);
    procedure Set_onTaskUpdated(const value: TdxEventHandler);
    procedure Set_onTaskUpdating(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property columns: TJSArray read Fcolumns write Set_columns;
    property contextMenu: TJSObject read FcontextMenu write Set_contextMenu;
    property dependencies: TJSObject read Fdependencies write Set_dependencies;
    property editing: TJSObject read Fediting write Set_editing;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property filterRow: JSValue read FfilterRow write Set_filterRow;
    property headerFilter: JSValue read FheaderFilter write Set_headerFilter;
    property height_: JSValue read Fheight_ write Set_height_;
    property resourceAssignments: TJSObject read FresourceAssignments write Set_resourceAssignments;
    property resources: TJSObject read Fresources write Set_resources;
    property rootValue: JSValue read FrootValue write Set_rootValue;
    property scaleTypeRange: TJSObject read FscaleTypeRange write Set_scaleTypeRange;
    property selectedRowKey: JSValue read FselectedRowKey write Set_selectedRowKey;
    property sorting: JSValue read Fsorting write Set_sorting;
    property stripLines: TJSArray read FstripLines write Set_stripLines;
    property taskContentTemplate: JSValue read FtaskContentTemplate write Set_taskContentTemplate;
    property taskProgressTooltipContentTemplate: JSValue read FtaskProgressTooltipContentTemplate write Set_taskProgressTooltipContentTemplate;
    property tasks: TJSObject read Ftasks write Set_tasks;
    property taskTimeTooltipContentTemplate: JSValue read FtaskTimeTooltipContentTemplate write Set_taskTimeTooltipContentTemplate;
    property taskTooltipContentTemplate: JSValue read FtaskTooltipContentTemplate write Set_taskTooltipContentTemplate;
    property toolbar: JSValue read Ftoolbar write Set_toolbar;
    property validation: TJSObject read Fvalidation write Set_validation;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property allowSelection: boolean read FallowSelection write Set_allowSelection default true;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property endDateRange: TDateTime read FendDateRange write Set_endDateRange;
    property firstDayOfWeek: TdxFirstDayOfWeek read FfirstDayOfWeek write Set_firstDayOfWeek default fdow0;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property scaleType: TdxGanttScaleType read FscaleType write Set_scaleType default gstAuto;
    property showDependencies: boolean read FshowDependencies write Set_showDependencies default true;
    property showResources: boolean read FshowResources write Set_showResources default true;
    property showRowLines: boolean read FshowRowLines write Set_showRowLines default true;
    property startDateRange: TDateTime read FstartDateRange write Set_startDateRange;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property taskListWidth: integer read FtaskListWidth write Set_taskListWidth;
    property taskTitlePosition: TdxGanttTaskTitlePosition read FtaskTitlePosition write Set_taskTitlePosition default gttpInside;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onContextMenuPreparing: TdxEventHandler read FonContextMenuPreparing write Set_onContextMenuPreparing;
    property onCustomCommand: TdxEventHandler read FonCustomCommand write Set_onCustomCommand;
    property onDependencyDeleted: TdxEventHandler read FonDependencyDeleted write Set_onDependencyDeleted;
    property onDependencyDeleting: TdxEventHandler read FonDependencyDeleting write Set_onDependencyDeleting;
    property onDependencyInserted: TdxEventHandler read FonDependencyInserted write Set_onDependencyInserted;
    property onDependencyInserting: TdxEventHandler read FonDependencyInserting write Set_onDependencyInserting;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onResourceAssigned: TdxEventHandler read FonResourceAssigned write Set_onResourceAssigned;
    property onResourceAssigning: TdxEventHandler read FonResourceAssigning write Set_onResourceAssigning;
    property onResourceDeleted: TdxEventHandler read FonResourceDeleted write Set_onResourceDeleted;
    property onResourceDeleting: TdxEventHandler read FonResourceDeleting write Set_onResourceDeleting;
    property onResourceInserted: TdxEventHandler read FonResourceInserted write Set_onResourceInserted;
    property onResourceInserting: TdxEventHandler read FonResourceInserting write Set_onResourceInserting;
    property onResourceManagerDialogShowing: TdxEventHandler read FonResourceManagerDialogShowing write Set_onResourceManagerDialogShowing;
    property onResourceUnassigned: TdxEventHandler read FonResourceUnassigned write Set_onResourceUnassigned;
    property onResourceUnassigning: TdxEventHandler read FonResourceUnassigning write Set_onResourceUnassigning;
    property onScaleCellPrepared: TdxEventHandler read FonScaleCellPrepared write Set_onScaleCellPrepared;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
    property onTaskClick: TdxEventHandler read FonTaskClick write Set_onTaskClick;
    property onTaskDblClick: TdxEventHandler read FonTaskDblClick write Set_onTaskDblClick;
    property onTaskDeleted: TdxEventHandler read FonTaskDeleted write Set_onTaskDeleted;
    property onTaskDeleting: TdxEventHandler read FonTaskDeleting write Set_onTaskDeleting;
    property onTaskEditDialogShowing: TdxEventHandler read FonTaskEditDialogShowing write Set_onTaskEditDialogShowing;
    property onTaskInserted: TdxEventHandler read FonTaskInserted write Set_onTaskInserted;
    property onTaskInserting: TdxEventHandler read FonTaskInserting write Set_onTaskInserting;
    property onTaskMoving: TdxEventHandler read FonTaskMoving write Set_onTaskMoving;
    property onTaskUpdated: TdxEventHandler read FonTaskUpdated write Set_onTaskUpdated;
    property onTaskUpdating: TdxEventHandler read FonTaskUpdating write Set_onTaskUpdating;
  end;

implementation


constructor TjdxGantt.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FallowSelection := true;
  Fcolumns := TJSArray.new;
  FcontextMenu := TJSObject.new;
  Fdependencies := TJSObject.new;
  Fdisabled := false;
  Fediting := TJSObject.new;
  FelementAttr := TJSObject.new;
  FendDateRange := 0;
  FfilterRow := nil;
  FfirstDayOfWeek := fdow0;
  FfocusStateEnabled := false;
  FheaderFilter := nil;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FresourceAssignments := TJSObject.new;
  Fresources := TJSObject.new;
  FrootValue := nil;
  FrtlEnabled := false;
  FscaleType := gstAuto;
  FscaleTypeRange := TJSObject.new;
  FselectedRowKey := nil;
  FshowDependencies := true;
  FshowResources := true;
  FshowRowLines := true;
  Fsorting := nil;
  FstartDateRange := 0;
  FstripLines := TJSArray.new;
  FtabIndex := 0;
  FtaskContentTemplate := nil;
  FtaskListWidth := 0;
  FtaskProgressTooltipContentTemplate := nil;
  Ftasks := TJSObject.new;
  FtaskTimeTooltipContentTemplate := nil;
  FtaskTitlePosition := gttpInside;
  FtaskTooltipContentTemplate := nil;
  Ftoolbar := nil;
  Fvalidation := TJSObject.new;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonContextMenuPreparing := nil;
  FonCustomCommand := nil;
  FonDependencyDeleted := nil;
  FonDependencyDeleting := nil;
  FonDependencyInserted := nil;
  FonDependencyInserting := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonResourceAssigned := nil;
  FonResourceAssigning := nil;
  FonResourceDeleted := nil;
  FonResourceDeleting := nil;
  FonResourceInserted := nil;
  FonResourceInserting := nil;
  FonResourceManagerDialogShowing := nil;
  FonResourceUnassigned := nil;
  FonResourceUnassigning := nil;
  FonScaleCellPrepared := nil;
  FonSelectionChanged := nil;
  FonTaskClick := nil;
  FonTaskDblClick := nil;
  FonTaskDeleted := nil;
  FonTaskDeleting := nil;
  FonTaskEditDialogShowing := nil;
  FonTaskInserted := nil;
  FonTaskInserting := nil;
  FonTaskMoving := nil;
  FonTaskUpdated := nil;
  FonTaskUpdating := nil;
end;

procedure TjdxGantt.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxGantt.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxGantt.Set_allowSelection(const Value: boolean);
begin
  FallowSelection := Value;
end;

procedure TjdxGantt.Set_columns(const Value: TJSArray);
begin
  Fcolumns := Value;
end;

procedure TjdxGantt.Set_contextMenu(const Value: TJSObject);
begin
  FcontextMenu := Value;
end;

procedure TjdxGantt.Set_dependencies(const Value: TJSObject);
begin
  Fdependencies := Value;
end;

procedure TjdxGantt.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxGantt.Set_editing(const Value: TJSObject);
begin
  Fediting := Value;
end;

procedure TjdxGantt.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxGantt.Set_endDateRange(const Value: TDateTime);
begin
  FendDateRange := Value;
end;

procedure TjdxGantt.Set_filterRow(const Value: JSValue);
begin
  FfilterRow := Value;
end;

procedure TjdxGantt.Set_firstDayOfWeek(const Value: TdxFirstDayOfWeek);
begin
  FfirstDayOfWeek := Value;
end;

procedure TjdxGantt.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxGantt.Set_headerFilter(const Value: JSValue);
begin
  FheaderFilter := Value;
end;

procedure TjdxGantt.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxGantt.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxGantt.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxGantt.Set_resourceAssignments(const Value: TJSObject);
begin
  FresourceAssignments := Value;
end;

procedure TjdxGantt.Set_resources(const Value: TJSObject);
begin
  Fresources := Value;
end;

procedure TjdxGantt.Set_rootValue(const Value: JSValue);
begin
  FrootValue := Value;
end;

procedure TjdxGantt.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxGantt.Set_scaleType(const Value: TdxGanttScaleType);
begin
  FscaleType := Value;
end;

procedure TjdxGantt.Set_scaleTypeRange(const Value: TJSObject);
begin
  FscaleTypeRange := Value;
end;

procedure TjdxGantt.Set_selectedRowKey(const Value: JSValue);
begin
  FselectedRowKey := Value;
end;

procedure TjdxGantt.Set_showDependencies(const Value: boolean);
begin
  FshowDependencies := Value;
end;

procedure TjdxGantt.Set_showResources(const Value: boolean);
begin
  FshowResources := Value;
end;

procedure TjdxGantt.Set_showRowLines(const Value: boolean);
begin
  FshowRowLines := Value;
end;

procedure TjdxGantt.Set_sorting(const Value: JSValue);
begin
  Fsorting := Value;
end;

procedure TjdxGantt.Set_startDateRange(const Value: TDateTime);
begin
  FstartDateRange := Value;
end;

procedure TjdxGantt.Set_stripLines(const Value: TJSArray);
begin
  FstripLines := Value;
end;

procedure TjdxGantt.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxGantt.Set_taskContentTemplate(const Value: JSValue);
begin
  FtaskContentTemplate := Value;
end;

procedure TjdxGantt.Set_taskListWidth(const Value: integer);
begin
  FtaskListWidth := Value;
end;

procedure TjdxGantt.Set_taskProgressTooltipContentTemplate(const Value: JSValue);
begin
  FtaskProgressTooltipContentTemplate := Value;
end;

procedure TjdxGantt.Set_tasks(const Value: TJSObject);
begin
  Ftasks := Value;
end;

procedure TjdxGantt.Set_taskTimeTooltipContentTemplate(const Value: JSValue);
begin
  FtaskTimeTooltipContentTemplate := Value;
end;

procedure TjdxGantt.Set_taskTitlePosition(const Value: TdxGanttTaskTitlePosition);
begin
  FtaskTitlePosition := Value;
end;

procedure TjdxGantt.Set_taskTooltipContentTemplate(const Value: JSValue);
begin
  FtaskTooltipContentTemplate := Value;
end;

procedure TjdxGantt.Set_toolbar(const Value: JSValue);
begin
  Ftoolbar := Value;
end;

procedure TjdxGantt.Set_validation(const Value: TJSObject);
begin
  Fvalidation := Value;
end;

procedure TjdxGantt.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxGantt.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxGantt.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxGantt.Set_onContextMenuPreparing(const Value: TdxEventHandler);
begin
  FonContextMenuPreparing := Value;
end;

procedure TjdxGantt.Set_onCustomCommand(const Value: TdxEventHandler);
begin
  FonCustomCommand := Value;
end;

procedure TjdxGantt.Set_onDependencyDeleted(const Value: TdxEventHandler);
begin
  FonDependencyDeleted := Value;
end;

procedure TjdxGantt.Set_onDependencyDeleting(const Value: TdxEventHandler);
begin
  FonDependencyDeleting := Value;
end;

procedure TjdxGantt.Set_onDependencyInserted(const Value: TdxEventHandler);
begin
  FonDependencyInserted := Value;
end;

procedure TjdxGantt.Set_onDependencyInserting(const Value: TdxEventHandler);
begin
  FonDependencyInserting := Value;
end;

procedure TjdxGantt.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxGantt.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxGantt.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxGantt.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxGantt.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxGantt.Set_onResourceAssigned(const Value: TdxEventHandler);
begin
  FonResourceAssigned := Value;
end;

procedure TjdxGantt.Set_onResourceAssigning(const Value: TdxEventHandler);
begin
  FonResourceAssigning := Value;
end;

procedure TjdxGantt.Set_onResourceDeleted(const Value: TdxEventHandler);
begin
  FonResourceDeleted := Value;
end;

procedure TjdxGantt.Set_onResourceDeleting(const Value: TdxEventHandler);
begin
  FonResourceDeleting := Value;
end;

procedure TjdxGantt.Set_onResourceInserted(const Value: TdxEventHandler);
begin
  FonResourceInserted := Value;
end;

procedure TjdxGantt.Set_onResourceInserting(const Value: TdxEventHandler);
begin
  FonResourceInserting := Value;
end;

procedure TjdxGantt.Set_onResourceManagerDialogShowing(const Value: TdxEventHandler);
begin
  FonResourceManagerDialogShowing := Value;
end;

procedure TjdxGantt.Set_onResourceUnassigned(const Value: TdxEventHandler);
begin
  FonResourceUnassigned := Value;
end;

procedure TjdxGantt.Set_onResourceUnassigning(const Value: TdxEventHandler);
begin
  FonResourceUnassigning := Value;
end;

procedure TjdxGantt.Set_onScaleCellPrepared(const Value: TdxEventHandler);
begin
  FonScaleCellPrepared := Value;
end;

procedure TjdxGantt.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
end;

procedure TjdxGantt.Set_onTaskClick(const Value: TdxEventHandler);
begin
  FonTaskClick := Value;
end;

procedure TjdxGantt.Set_onTaskDblClick(const Value: TdxEventHandler);
begin
  FonTaskDblClick := Value;
end;

procedure TjdxGantt.Set_onTaskDeleted(const Value: TdxEventHandler);
begin
  FonTaskDeleted := Value;
end;

procedure TjdxGantt.Set_onTaskDeleting(const Value: TdxEventHandler);
begin
  FonTaskDeleting := Value;
end;

procedure TjdxGantt.Set_onTaskEditDialogShowing(const Value: TdxEventHandler);
begin
  FonTaskEditDialogShowing := Value;
end;

procedure TjdxGantt.Set_onTaskInserted(const Value: TdxEventHandler);
begin
  FonTaskInserted := Value;
end;

procedure TjdxGantt.Set_onTaskInserting(const Value: TdxEventHandler);
begin
  FonTaskInserting := Value;
end;

procedure TjdxGantt.Set_onTaskMoving(const Value: TdxEventHandler);
begin
  FonTaskMoving := Value;
end;

procedure TjdxGantt.Set_onTaskUpdated(const Value: TdxEventHandler);
begin
  FonTaskUpdated := Value;
end;

procedure TjdxGantt.Set_onTaskUpdating(const Value: TdxEventHandler);
begin
  FonTaskUpdating := Value;
end;

end.
