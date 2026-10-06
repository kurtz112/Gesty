unit DevExtreme.Gantt.Custom;

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
  DevExtreme.Gantt.JS,
  DevExtreme.Types;

type
  TjdxCustomGantt = class(TjdxCustomControl)
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
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxGantt; assembler;
    function instance: TdxGantt; assembler;
  public
    procedure assignResourceToTask(resourceKey: TJSObject; taskKey: TJSObject); assembler;
    procedure beginUpdate(); assembler;
    procedure collapseAll(); assembler;
    procedure collapseTask(key: TJSObject); assembler;
    procedure ctor(options: JSValue); assembler; overload;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure deleteDependency(key: TJSObject); assembler;
    procedure deleteResource(key: TJSObject); assembler;
    procedure deleteTask(key: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure expandAll(); assembler;
    procedure expandAllToLevel(level: integer); assembler;
    procedure expandTask(key: TJSObject); assembler;
    procedure expandToTask(key: TJSObject); assembler;
    procedure focus(); assembler;
    function getDependencyData(key: TJSObject): TJSObject; assembler;
    function getResourceAssignmentData(key: TJSObject): TJSObject; assembler;
    function getResourceData(key: TJSObject): TJSObject; assembler;
    function getTaskData(key: TJSObject): TJSObject; assembler;
    function getTaskResources(key: TJSObject): TJSArray; assembler;
    function getVisibleDependencyKeys(): TJSArray; assembler;
    function getVisibleResourceAssignmentKeys(): TJSArray; assembler;
    function getVisibleResourceKeys(): TJSArray; assembler;
    function getVisibleTaskKeys(): TJSArray; assembler;
    procedure insertDependency(data: TJSObject); assembler;
    procedure insertResource(data: TJSObject; taskKeys: TJSArray); assembler;
    procedure insertTask(data: TJSObject); assembler;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(): TJSObject; assembler; overload;
    function refresh(): TJSPromise; assembler;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure scrollToDate(date: JSValue); assembler;
    procedure showDependencies_(value: boolean); assembler;
    procedure showResourceManagerDialog(); assembler;
    procedure showResources_(value: boolean); assembler;
    procedure showTaskDetailsDialog(taskKey: TJSObject); assembler;
    procedure unassignAllResourcesFromTask(taskKey: TJSObject); assembler;
    procedure unassignResourceFromTask(resourceKey: TJSObject; taskKey: TJSObject); assembler;
    procedure updateDimensions(); assembler;
    procedure updateTask(key: TJSObject; data: TJSObject); assembler;
    procedure zoomIn(); assembler;
    procedure zoomOut(); assembler;
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


procedure TjdxCustomGantt.CreateInitialize;
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
procedure TjdxCustomGantt.InitJQuery;
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
      $(id).dxGantt(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomGantt.getInstance(element: TJSObject): TdxGantt;
asm
  return DevExpress.viz.dxGantt.getInstance(element);
end;

function TjdxCustomGantt.instance: TdxGantt;
asm
  return $(this.GetJQID()).dxGantt("instance");
end;
procedure TjdxCustomGantt.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('allowSelection', allowSelection);
    SetOption('columns', columns);
    SetOption('contextMenu', contextMenu);
    SetOption('dependencies', dependencies);
    SetOption('disabled', disabled);
    SetOption('editing', editing);
    SetOption('elementAttr', elementAttr);
    SetOption('endDateRange', endDateRange);
    SetOption('filterRow', filterRow);
    SetOption('firstDayOfWeek', firstDayOfWeek.ToString());
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('headerFilter', headerFilter);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('resourceAssignments', resourceAssignments);
    SetOption('resources', resources);
    SetOption('rootValue', rootValue);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('scaleType', scaleType.ToString());
    SetOption('scaleTypeRange', scaleTypeRange);
    SetOption('selectedRowKey', selectedRowKey);
    SetOption('showDependencies', showDependencies);
    SetOption('showResources', showResources);
    SetOption('showRowLines', showRowLines);
    SetOption('sorting', sorting);
    SetOption('startDateRange', startDateRange);
    SetOption('stripLines', stripLines);
    SetOption('tabIndex', tabIndex);
    SetOption('taskContentTemplate', taskContentTemplate);
    SetOption('taskListWidth', taskListWidth);
    SetOption('taskProgressTooltipContentTemplate', taskProgressTooltipContentTemplate);
    SetOption('tasks', tasks);
    SetOption('taskTimeTooltipContentTemplate', taskTimeTooltipContentTemplate);
    SetOption('taskTitlePosition', taskTitlePosition.ToString());
    SetOption('taskTooltipContentTemplate', taskTooltipContentTemplate);
    SetOption('toolbar', toolbar);
    SetOption('validation', validation);
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('contentReady', onContentReady);
    SetEvent('contextMenuPreparing', onContextMenuPreparing);
    SetEvent('customCommand', onCustomCommand);
    SetEvent('dependencyDeleted', onDependencyDeleted);
    SetEvent('dependencyDeleting', onDependencyDeleting);
    SetEvent('dependencyInserted', onDependencyInserted);
    SetEvent('dependencyInserting', onDependencyInserting);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('resourceAssigned', onResourceAssigned);
    SetEvent('resourceAssigning', onResourceAssigning);
    SetEvent('resourceDeleted', onResourceDeleted);
    SetEvent('resourceDeleting', onResourceDeleting);
    SetEvent('resourceInserted', onResourceInserted);
    SetEvent('resourceInserting', onResourceInserting);
    SetEvent('resourceManagerDialogShowing', onResourceManagerDialogShowing);
    SetEvent('resourceUnassigned', onResourceUnassigned);
    SetEvent('resourceUnassigning', onResourceUnassigning);
    SetEvent('scaleCellPrepared', onScaleCellPrepared);
    SetEvent('selectionChanged', onSelectionChanged);
    SetEvent('taskClick', onTaskClick);
    SetEvent('taskDblClick', onTaskDblClick);
    SetEvent('taskDeleted', onTaskDeleted);
    SetEvent('taskDeleting', onTaskDeleting);
    SetEvent('taskEditDialogShowing', onTaskEditDialogShowing);
    SetEvent('taskInserted', onTaskInserted);
    SetEvent('taskInserting', onTaskInserting);
    SetEvent('taskMoving', onTaskMoving);
    SetEvent('taskUpdated', onTaskUpdated);
    SetEvent('taskUpdating', onTaskUpdating);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomGantt.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomGantt.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomGantt.Set_allowSelection(const Value: boolean);
begin
  FallowSelection := Value;
  SetOption('allowSelection', allowSelection);
end;

procedure TjdxCustomGantt.Set_columns(const Value: TJSArray);
begin
  Fcolumns := Value;
  SetOption('columns', columns);
end;

procedure TjdxCustomGantt.Set_contextMenu(const Value: TJSObject);
begin
  FcontextMenu := Value;
  SetOption('contextMenu', contextMenu);
end;

procedure TjdxCustomGantt.Set_dependencies(const Value: TJSObject);
begin
  Fdependencies := Value;
  SetOption('dependencies', dependencies);
end;

procedure TjdxCustomGantt.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomGantt.Set_editing(const Value: TJSObject);
begin
  Fediting := Value;
  SetOption('editing', editing);
end;

procedure TjdxCustomGantt.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomGantt.Set_endDateRange(const Value: TDateTime);
begin
  FendDateRange := Value;
  SetOption('endDateRange', endDateRange);
end;

procedure TjdxCustomGantt.Set_filterRow(const Value: JSValue);
begin
  FfilterRow := Value;
  SetOption('filterRow', filterRow);
end;

procedure TjdxCustomGantt.Set_firstDayOfWeek(const Value: TdxFirstDayOfWeek);
begin
  FfirstDayOfWeek := Value;
  SetOption('firstDayOfWeek', firstDayOfWeek.ToString());
end;

procedure TjdxCustomGantt.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomGantt.Set_headerFilter(const Value: JSValue);
begin
  FheaderFilter := Value;
  SetOption('headerFilter', headerFilter);
end;

procedure TjdxCustomGantt.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomGantt.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomGantt.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomGantt.Set_resourceAssignments(const Value: TJSObject);
begin
  FresourceAssignments := Value;
  SetOption('resourceAssignments', resourceAssignments);
end;

procedure TjdxCustomGantt.Set_resources(const Value: TJSObject);
begin
  Fresources := Value;
  SetOption('resources', resources);
end;

procedure TjdxCustomGantt.Set_rootValue(const Value: JSValue);
begin
  FrootValue := Value;
  SetOption('rootValue', rootValue);
end;

procedure TjdxCustomGantt.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomGantt.Set_scaleType(const Value: TdxGanttScaleType);
begin
  FscaleType := Value;
  SetOption('scaleType', scaleType.ToString());
end;

procedure TjdxCustomGantt.Set_scaleTypeRange(const Value: TJSObject);
begin
  FscaleTypeRange := Value;
  SetOption('scaleTypeRange', scaleTypeRange);
end;

procedure TjdxCustomGantt.Set_selectedRowKey(const Value: JSValue);
begin
  FselectedRowKey := Value;
  SetOption('selectedRowKey', selectedRowKey);
end;

procedure TjdxCustomGantt.Set_showDependencies(const Value: boolean);
begin
  FshowDependencies := Value;
  SetOption('showDependencies', showDependencies);
end;

procedure TjdxCustomGantt.Set_showResources(const Value: boolean);
begin
  FshowResources := Value;
  SetOption('showResources', showResources);
end;

procedure TjdxCustomGantt.Set_showRowLines(const Value: boolean);
begin
  FshowRowLines := Value;
  SetOption('showRowLines', showRowLines);
end;

procedure TjdxCustomGantt.Set_sorting(const Value: JSValue);
begin
  Fsorting := Value;
  SetOption('sorting', sorting);
end;

procedure TjdxCustomGantt.Set_startDateRange(const Value: TDateTime);
begin
  FstartDateRange := Value;
  SetOption('startDateRange', startDateRange);
end;

procedure TjdxCustomGantt.Set_stripLines(const Value: TJSArray);
begin
  FstripLines := Value;
  SetOption('stripLines', stripLines);
end;

procedure TjdxCustomGantt.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomGantt.Set_taskContentTemplate(const Value: JSValue);
begin
  FtaskContentTemplate := Value;
  SetOption('taskContentTemplate', taskContentTemplate);
end;

procedure TjdxCustomGantt.Set_taskListWidth(const Value: integer);
begin
  FtaskListWidth := Value;
  SetOption('taskListWidth', taskListWidth);
end;

procedure TjdxCustomGantt.Set_taskProgressTooltipContentTemplate(const Value: JSValue);
begin
  FtaskProgressTooltipContentTemplate := Value;
  SetOption('taskProgressTooltipContentTemplate', taskProgressTooltipContentTemplate);
end;

procedure TjdxCustomGantt.Set_tasks(const Value: TJSObject);
begin
  Ftasks := Value;
  SetOption('tasks', tasks);
end;

procedure TjdxCustomGantt.Set_taskTimeTooltipContentTemplate(const Value: JSValue);
begin
  FtaskTimeTooltipContentTemplate := Value;
  SetOption('taskTimeTooltipContentTemplate', taskTimeTooltipContentTemplate);
end;

procedure TjdxCustomGantt.Set_taskTitlePosition(const Value: TdxGanttTaskTitlePosition);
begin
  FtaskTitlePosition := Value;
  SetOption('taskTitlePosition', taskTitlePosition.ToString());
end;

procedure TjdxCustomGantt.Set_taskTooltipContentTemplate(const Value: JSValue);
begin
  FtaskTooltipContentTemplate := Value;
  SetOption('taskTooltipContentTemplate', taskTooltipContentTemplate);
end;

procedure TjdxCustomGantt.Set_toolbar(const Value: JSValue);
begin
  Ftoolbar := Value;
  SetOption('toolbar', toolbar);
end;

procedure TjdxCustomGantt.Set_validation(const Value: TJSObject);
begin
  Fvalidation := Value;
  SetOption('validation', validation);
end;

procedure TjdxCustomGantt.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomGantt.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomGantt.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomGantt.Set_onContextMenuPreparing(const Value: TdxEventHandler);
begin
  FonContextMenuPreparing := Value;
  SetEvent('contextMenuPreparing', onContextMenuPreparing);
end;

procedure TjdxCustomGantt.Set_onCustomCommand(const Value: TdxEventHandler);
begin
  FonCustomCommand := Value;
  SetEvent('customCommand', onCustomCommand);
end;

procedure TjdxCustomGantt.Set_onDependencyDeleted(const Value: TdxEventHandler);
begin
  FonDependencyDeleted := Value;
  SetEvent('dependencyDeleted', onDependencyDeleted);
end;

procedure TjdxCustomGantt.Set_onDependencyDeleting(const Value: TdxEventHandler);
begin
  FonDependencyDeleting := Value;
  SetEvent('dependencyDeleting', onDependencyDeleting);
end;

procedure TjdxCustomGantt.Set_onDependencyInserted(const Value: TdxEventHandler);
begin
  FonDependencyInserted := Value;
  SetEvent('dependencyInserted', onDependencyInserted);
end;

procedure TjdxCustomGantt.Set_onDependencyInserting(const Value: TdxEventHandler);
begin
  FonDependencyInserting := Value;
  SetEvent('dependencyInserting', onDependencyInserting);
end;

procedure TjdxCustomGantt.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomGantt.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomGantt.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomGantt.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomGantt.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomGantt.Set_onResourceAssigned(const Value: TdxEventHandler);
begin
  FonResourceAssigned := Value;
  SetEvent('resourceAssigned', onResourceAssigned);
end;

procedure TjdxCustomGantt.Set_onResourceAssigning(const Value: TdxEventHandler);
begin
  FonResourceAssigning := Value;
  SetEvent('resourceAssigning', onResourceAssigning);
end;

procedure TjdxCustomGantt.Set_onResourceDeleted(const Value: TdxEventHandler);
begin
  FonResourceDeleted := Value;
  SetEvent('resourceDeleted', onResourceDeleted);
end;

procedure TjdxCustomGantt.Set_onResourceDeleting(const Value: TdxEventHandler);
begin
  FonResourceDeleting := Value;
  SetEvent('resourceDeleting', onResourceDeleting);
end;

procedure TjdxCustomGantt.Set_onResourceInserted(const Value: TdxEventHandler);
begin
  FonResourceInserted := Value;
  SetEvent('resourceInserted', onResourceInserted);
end;

procedure TjdxCustomGantt.Set_onResourceInserting(const Value: TdxEventHandler);
begin
  FonResourceInserting := Value;
  SetEvent('resourceInserting', onResourceInserting);
end;

procedure TjdxCustomGantt.Set_onResourceManagerDialogShowing(const Value: TdxEventHandler);
begin
  FonResourceManagerDialogShowing := Value;
  SetEvent('resourceManagerDialogShowing', onResourceManagerDialogShowing);
end;

procedure TjdxCustomGantt.Set_onResourceUnassigned(const Value: TdxEventHandler);
begin
  FonResourceUnassigned := Value;
  SetEvent('resourceUnassigned', onResourceUnassigned);
end;

procedure TjdxCustomGantt.Set_onResourceUnassigning(const Value: TdxEventHandler);
begin
  FonResourceUnassigning := Value;
  SetEvent('resourceUnassigning', onResourceUnassigning);
end;

procedure TjdxCustomGantt.Set_onScaleCellPrepared(const Value: TdxEventHandler);
begin
  FonScaleCellPrepared := Value;
  SetEvent('scaleCellPrepared', onScaleCellPrepared);
end;

procedure TjdxCustomGantt.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomGantt.Set_onTaskClick(const Value: TdxEventHandler);
begin
  FonTaskClick := Value;
  SetEvent('taskClick', onTaskClick);
end;

procedure TjdxCustomGantt.Set_onTaskDblClick(const Value: TdxEventHandler);
begin
  FonTaskDblClick := Value;
  SetEvent('taskDblClick', onTaskDblClick);
end;

procedure TjdxCustomGantt.Set_onTaskDeleted(const Value: TdxEventHandler);
begin
  FonTaskDeleted := Value;
  SetEvent('taskDeleted', onTaskDeleted);
end;

procedure TjdxCustomGantt.Set_onTaskDeleting(const Value: TdxEventHandler);
begin
  FonTaskDeleting := Value;
  SetEvent('taskDeleting', onTaskDeleting);
end;

procedure TjdxCustomGantt.Set_onTaskEditDialogShowing(const Value: TdxEventHandler);
begin
  FonTaskEditDialogShowing := Value;
  SetEvent('taskEditDialogShowing', onTaskEditDialogShowing);
end;

procedure TjdxCustomGantt.Set_onTaskInserted(const Value: TdxEventHandler);
begin
  FonTaskInserted := Value;
  SetEvent('taskInserted', onTaskInserted);
end;

procedure TjdxCustomGantt.Set_onTaskInserting(const Value: TdxEventHandler);
begin
  FonTaskInserting := Value;
  SetEvent('taskInserting', onTaskInserting);
end;

procedure TjdxCustomGantt.Set_onTaskMoving(const Value: TdxEventHandler);
begin
  FonTaskMoving := Value;
  SetEvent('taskMoving', onTaskMoving);
end;

procedure TjdxCustomGantt.Set_onTaskUpdated(const Value: TdxEventHandler);
begin
  FonTaskUpdated := Value;
  SetEvent('taskUpdated', onTaskUpdated);
end;

procedure TjdxCustomGantt.Set_onTaskUpdating(const Value: TdxEventHandler);
begin
  FonTaskUpdating := Value;
  SetEvent('taskUpdating', onTaskUpdating);
end;

procedure TjdxCustomGantt.assignResourceToTask(resourceKey: TJSObject; taskKey: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.assignResourceToTask(resourceKey, taskKey);
end;

procedure TjdxCustomGantt.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomGantt.collapseAll();
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.collapseAll();
end;

procedure TjdxCustomGantt.collapseTask(key: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.collapseTask(key);
end;

procedure TjdxCustomGantt.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomGantt.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomGantt.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomGantt.deleteDependency(key: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.deleteDependency(key);
end;

procedure TjdxCustomGantt.deleteResource(key: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.deleteResource(key);
end;

procedure TjdxCustomGantt.deleteTask(key: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.deleteTask(key);
end;

procedure TjdxCustomGantt.dispose();
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.dispose();
end;

function TjdxCustomGantt.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.element();
end;

procedure TjdxCustomGantt.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomGantt.expandAll();
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.expandAll();
end;

procedure TjdxCustomGantt.expandAllToLevel(level: integer);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.expandAllToLevel(level);
end;

procedure TjdxCustomGantt.expandTask(key: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.expandTask(key);
end;

procedure TjdxCustomGantt.expandToTask(key: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.expandToTask(key);
end;

procedure TjdxCustomGantt.focus();
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.focus();
end;

function TjdxCustomGantt.getDependencyData(key: TJSObject): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.getDependencyData(key);
end;

function TjdxCustomGantt.getResourceAssignmentData(key: TJSObject): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.getResourceAssignmentData(key);
end;

function TjdxCustomGantt.getResourceData(key: TJSObject): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.getResourceData(key);
end;

function TjdxCustomGantt.getTaskData(key: TJSObject): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.getTaskData(key);
end;

function TjdxCustomGantt.getTaskResources(key: TJSObject): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.getTaskResources(key);
end;

function TjdxCustomGantt.getVisibleDependencyKeys(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.getVisibleDependencyKeys();
end;

function TjdxCustomGantt.getVisibleResourceAssignmentKeys(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.getVisibleResourceAssignmentKeys();
end;

function TjdxCustomGantt.getVisibleResourceKeys(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.getVisibleResourceKeys();
end;

function TjdxCustomGantt.getVisibleTaskKeys(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.getVisibleTaskKeys();
end;

procedure TjdxCustomGantt.insertDependency(data: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.insertDependency(data);
end;

procedure TjdxCustomGantt.insertResource(data: TJSObject; taskKeys: TJSArray);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.insertResource(data, taskKeys);
end;

procedure TjdxCustomGantt.insertTask(data: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.insertTask(data);
end;

function TjdxCustomGantt.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.off(eventName);
end;

function TjdxCustomGantt.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomGantt.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomGantt.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.on(events);
end;

function TjdxCustomGantt.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomGantt.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.option(options);
end;

procedure TjdxCustomGantt.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomGantt.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.option();
end;

function TjdxCustomGantt.refresh(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  return _instance.refresh();
end;

procedure TjdxCustomGantt.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomGantt.repaint();
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.repaint();
end;

procedure TjdxCustomGantt.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomGantt.scrollToDate(date: JSValue);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.scrollToDate(date);
end;

procedure TjdxCustomGantt.showDependencies_(value: boolean);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.showDependencies(value);
end;

procedure TjdxCustomGantt.showResourceManagerDialog();
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.showResourceManagerDialog();
end;

procedure TjdxCustomGantt.showResources_(value: boolean);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.showResources(value);
end;

procedure TjdxCustomGantt.showTaskDetailsDialog(taskKey: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.showTaskDetailsDialog(taskKey);
end;

procedure TjdxCustomGantt.unassignAllResourcesFromTask(taskKey: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.unassignAllResourcesFromTask(taskKey);
end;

procedure TjdxCustomGantt.unassignResourceFromTask(resourceKey: TJSObject; taskKey: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.unassignResourceFromTask(resourceKey, taskKey);
end;

procedure TjdxCustomGantt.updateDimensions();
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.updateDimensions();
end;

procedure TjdxCustomGantt.updateTask(key: TJSObject; data: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.updateTask(key, data);
end;

procedure TjdxCustomGantt.zoomIn();
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.zoomIn();
end;

procedure TjdxCustomGantt.zoomOut();
asm
  const _instance = $(this.GetJQID()).dxGantt("instance");
  _instance.zoomOut();
end;

end.
