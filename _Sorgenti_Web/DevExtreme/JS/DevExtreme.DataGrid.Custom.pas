unit DevExtreme.DataGrid.Custom;

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
  DevExtreme.DataGrid.JS,
  DevExtreme.Types;

type
  TjdxCustomDataGrid = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FallowColumnReordering: boolean;
    FallowColumnResizing: boolean;
    FautoNavigateToFocusedRow: boolean;
    FcacheEnabled: boolean;
    FcellHintEnabled: boolean;
    FcolumnAutoWidth: boolean;
    FcolumnChooser: TJSObject;
    FcolumnFixing: TJSObject;
    FcolumnHidingEnabled: boolean;
    FcolumnMinWidth: integer;
    FcolumnResizingMode: JSValue;
    Fcolumns: TJSArray;
    FcolumnWidth: JSValue;
    FcustomizeColumns: TJSFunction;
    FdataRowTemplate: JSValue;
    FdataSource: JSValue;
    FdateSerializationFormat: string;
    Fdisabled: boolean;
    Fediting: TJSObject;
    FelementAttr: TJSObject;
    FerrorRowEnabled: boolean;
    Fexport: TJSObject;
    FfilterBuilder: JSValue;
    FfilterBuilderPopup: JSValue;
    FfilterPanel: TJSObject;
    FfilterRow: TJSObject;
    FfilterSyncEnabled: JSValue;
    FfilterValue: JSValue;
    FfocusedColumnIndex: integer;
    FfocusedRowEnabled: boolean;
    FfocusedRowIndex: integer;
    FfocusedRowKey: JSValue;
    FfocusStateEnabled: boolean;
    Fgrouping: TJSObject;
    FgroupPanel: TJSObject;
    FheaderFilter: TJSObject;
    Fheight_: JSValue;
    FhighlightChanges: boolean;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FkeyboardNavigation: TJSObject;
    FkeyExpr: JSValue;
    FloadPanel: TJSObject;
    FmasterDetail: TJSObject;
    FnoDataText: string;
    Fpager: TJSObject;
    Fpaging: TJSObject;
    FregenerateColumnsByVisibleItems: boolean;
    FremoteOperations: TJSObject;
    FrenderAsync: boolean;
    FrepaintChangesOnly: boolean;
    FrowAlternationEnabled: boolean;
    FrowDragging: TJSObject;
    FrtlEnabled: boolean;
    Fscrolling: TJSObject;
    FsearchPanel: TJSObject;
    FselectedRowKeys: TJSArray;
    Fselection: TJSObject;
    FselectionFilter: JSValue;
    FshowBorders: boolean;
    FshowColumnHeaders: boolean;
    FshowColumnLines: boolean;
    FshowRowLines: boolean;
    FsortByGroupSummaryInfo: TJSArray;
    Fsorting: TJSObject;
    FstateStoring: TJSObject;
    Fsummary: TJSObject;
    FsyncLookupFilterValues: boolean;
    FtabIndex: integer;
    Ftoolbar: JSValue;
    FtwoWayBindingEnabled: boolean;
    Fvisible: boolean;
    Fwidth_: JSValue;
    FwordWrapEnabled: boolean;
  private
    FonAdaptiveDetailRowPreparing: TdxEventHandler;
    FonCellClick: TdxEventHandler;
    FonCellDblClick: TdxEventHandler;
    FonCellHoverChanged: TdxEventHandler;
    FonCellPrepared: TdxEventHandler;
    FonContentReady: TdxEventHandler;
    FonContextMenuPreparing: TdxEventHandler;
    FonDataErrorOccurred: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonEditCanceled: TdxEventHandler;
    FonEditCanceling: TdxEventHandler;
    FonEditingStart: TdxEventHandler;
    FonEditorPrepared: TdxEventHandler;
    FonEditorPreparing: TdxEventHandler;
    FonExporting: TdxEventHandler;
    FonFocusedCellChanged: TdxEventHandler;
    FonFocusedCellChanging: TdxEventHandler;
    FonFocusedRowChanged: TdxEventHandler;
    FonFocusedRowChanging: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonInitNewRow: TdxEventHandler;
    FonKeyDown: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonRowClick: TdxEventHandler;
    FonRowCollapsed: TdxEventHandler;
    FonRowCollapsing: TdxEventHandler;
    FonRowDblClick: TdxEventHandler;
    FonRowExpanded: TdxEventHandler;
    FonRowExpanding: TdxEventHandler;
    FonRowInserted: TdxEventHandler;
    FonRowInserting: TdxEventHandler;
    FonRowPrepared: TdxEventHandler;
    FonRowRemoved: TdxEventHandler;
    FonRowRemoving: TdxEventHandler;
    FonRowUpdated: TdxEventHandler;
    FonRowUpdating: TdxEventHandler;
    FonRowValidating: TdxEventHandler;
    FonSaved: TdxEventHandler;
    FonSaving: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
    FonToolbarPreparing: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_allowColumnReordering(const value: boolean);
    procedure Set_allowColumnResizing(const value: boolean);
    procedure Set_autoNavigateToFocusedRow(const value: boolean);
    procedure Set_cacheEnabled(const value: boolean);
    procedure Set_cellHintEnabled(const value: boolean);
    procedure Set_columnAutoWidth(const value: boolean);
    procedure Set_columnChooser(const value: TJSObject);
    procedure Set_columnFixing(const value: TJSObject);
    procedure Set_columnHidingEnabled(const value: boolean);
    procedure Set_columnMinWidth(const value: integer);
    procedure Set_columnResizingMode(const value: JSValue);
    procedure Set_columns(const value: TJSArray);
    procedure Set_columnWidth(const value: JSValue);
    procedure Set_customizeColumns(const value: TJSFunction);
    procedure Set_dataRowTemplate(const value: JSValue);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_dateSerializationFormat(const value: string);
    procedure Set_disabled(const value: boolean);
    procedure Set_editing(const value: TJSObject);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_errorRowEnabled(const value: boolean);
    procedure Set_export(const value: TJSObject);
    procedure Set_filterBuilder(const value: JSValue);
    procedure Set_filterBuilderPopup(const value: JSValue);
    procedure Set_filterPanel(const value: TJSObject);
    procedure Set_filterRow(const value: TJSObject);
    procedure Set_filterSyncEnabled(const value: JSValue);
    procedure Set_filterValue(const value: JSValue);
    procedure Set_focusedColumnIndex(const value: integer);
    procedure Set_focusedRowEnabled(const value: boolean);
    procedure Set_focusedRowIndex(const value: integer);
    procedure Set_focusedRowKey(const value: JSValue);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_grouping(const value: TJSObject);
    procedure Set_groupPanel(const value: TJSObject);
    procedure Set_headerFilter(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_highlightChanges(const value: boolean);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_keyboardNavigation(const value: TJSObject);
    procedure Set_keyExpr(const value: JSValue);
    procedure Set_loadPanel(const value: TJSObject);
    procedure Set_masterDetail(const value: TJSObject);
    procedure Set_noDataText(const value: string);
    procedure Set_pager(const value: TJSObject);
    procedure Set_paging(const value: TJSObject);
    procedure Set_regenerateColumnsByVisibleItems(const value: boolean);
    procedure Set_remoteOperations(const value: TJSObject);
    procedure Set_renderAsync(const value: boolean);
    procedure Set_repaintChangesOnly(const value: boolean);
    procedure Set_rowAlternationEnabled(const value: boolean);
    procedure Set_rowDragging(const value: TJSObject);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scrolling(const value: TJSObject);
    procedure Set_searchPanel(const value: TJSObject);
    procedure Set_selectedRowKeys(const value: TJSArray);
    procedure Set_selection(const value: TJSObject);
    procedure Set_selectionFilter(const value: JSValue);
    procedure Set_showBorders(const value: boolean);
    procedure Set_showColumnHeaders(const value: boolean);
    procedure Set_showColumnLines(const value: boolean);
    procedure Set_showRowLines(const value: boolean);
    procedure Set_sortByGroupSummaryInfo(const value: TJSArray);
    procedure Set_sorting(const value: TJSObject);
    procedure Set_stateStoring(const value: TJSObject);
    procedure Set_summary(const value: TJSObject);
    procedure Set_syncLookupFilterValues(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_toolbar(const value: JSValue);
    procedure Set_twoWayBindingEnabled(const value: boolean);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
    procedure Set_wordWrapEnabled(const value: boolean);
  private
    procedure Set_onAdaptiveDetailRowPreparing(const value: TdxEventHandler);
    procedure Set_onCellClick(const value: TdxEventHandler);
    procedure Set_onCellDblClick(const value: TdxEventHandler);
    procedure Set_onCellHoverChanged(const value: TdxEventHandler);
    procedure Set_onCellPrepared(const value: TdxEventHandler);
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onContextMenuPreparing(const value: TdxEventHandler);
    procedure Set_onDataErrorOccurred(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onEditCanceled(const value: TdxEventHandler);
    procedure Set_onEditCanceling(const value: TdxEventHandler);
    procedure Set_onEditingStart(const value: TdxEventHandler);
    procedure Set_onEditorPrepared(const value: TdxEventHandler);
    procedure Set_onEditorPreparing(const value: TdxEventHandler);
    procedure Set_onExporting(const value: TdxEventHandler);
    procedure Set_onFocusedCellChanged(const value: TdxEventHandler);
    procedure Set_onFocusedCellChanging(const value: TdxEventHandler);
    procedure Set_onFocusedRowChanged(const value: TdxEventHandler);
    procedure Set_onFocusedRowChanging(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onInitNewRow(const value: TdxEventHandler);
    procedure Set_onKeyDown(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onRowClick(const value: TdxEventHandler);
    procedure Set_onRowCollapsed(const value: TdxEventHandler);
    procedure Set_onRowCollapsing(const value: TdxEventHandler);
    procedure Set_onRowDblClick(const value: TdxEventHandler);
    procedure Set_onRowExpanded(const value: TdxEventHandler);
    procedure Set_onRowExpanding(const value: TdxEventHandler);
    procedure Set_onRowInserted(const value: TdxEventHandler);
    procedure Set_onRowInserting(const value: TdxEventHandler);
    procedure Set_onRowPrepared(const value: TdxEventHandler);
    procedure Set_onRowRemoved(const value: TdxEventHandler);
    procedure Set_onRowRemoving(const value: TdxEventHandler);
    procedure Set_onRowUpdated(const value: TdxEventHandler);
    procedure Set_onRowUpdating(const value: TdxEventHandler);
    procedure Set_onRowValidating(const value: TdxEventHandler);
    procedure Set_onSaved(const value: TdxEventHandler);
    procedure Set_onSaving(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
    procedure Set_onToolbarPreparing(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxDataGrid; assembler;
    function instance: TdxDataGrid; assembler;
  public
    procedure addColumn(columnOptions: JSValue); assembler;
    function addRow(): TJSPromise; assembler;
    procedure beginCustomLoading(messageText: string); assembler;
    procedure beginUpdate(); assembler;
    function byKey(key: JSValue): TJSPromise; assembler;
    procedure cancelEditData(); assembler;
    function cellValue(rowIndex: integer; visibleColumnIndex: integer): JSValue; assembler; overload;
    procedure cellValue(rowIndex: integer; visibleColumnIndex: integer; value: JSValue); assembler; overload;
    function cellValue(rowIndex: integer; dataField: string): JSValue; assembler; overload;
    procedure cellValue(rowIndex: integer; dataField: string; value: JSValue); assembler; overload;
    procedure clearFilter(); assembler; overload;
    procedure clearFilter(filterName: string); assembler; overload;
    procedure clearGrouping(); assembler;
    procedure clearSelection(); assembler;
    procedure clearSorting(); assembler;
    procedure closeEditCell(); assembler;
    procedure collapseAdaptiveDetailRow(); assembler;
    procedure collapseAll(groupIndex: JSValue); assembler;
    function collapseRow(key: JSValue): TJSPromise; assembler;
    function columnCount(): integer; assembler;
    procedure columnOption(id: JSValue; optionName: string; optionValue: JSValue); assembler; overload;
    procedure columnOption(id: JSValue; options: TJSObject); assembler; overload;
    function columnOption(id: JSValue; optionName: string): JSValue; assembler; overload;
    function columnOption(id: JSValue): TJSObject; assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure deleteColumn(id: JSValue); assembler;
    procedure deleteRow(rowIndex: integer); assembler;
    function deselectAll(): TJSPromise; assembler;
    function deselectRows(keys: TJSArray): TJSPromise; assembler;
    procedure dispose(); assembler;
    procedure editCell(rowIndex: integer; visibleColumnIndex: integer); assembler; overload;
    procedure editCell(rowIndex: integer; dataField: string); assembler; overload;
    procedure editRow(rowIndex: integer); assembler;
    function element(): TJSElement; assembler;
    procedure endCustomLoading(); assembler;
    procedure endUpdate(); assembler;
    procedure expandAdaptiveDetailRow(key: JSValue); assembler;
    procedure expandAll(groupIndex: JSValue); assembler;
    function expandRow(key: JSValue): TJSPromise; assembler;
    procedure filter(filterExpr: JSValue); assembler; overload;
    function filter(): JSValue; assembler; overload;
    procedure focus(); assembler; overload;
    procedure focus(element: JSValue); assembler; overload;
    function getCellElement(rowIndex: integer; visibleColumnIndex: integer): JSValue; assembler; overload;
    function getCellElement(rowIndex: integer; dataField: string): JSValue; assembler; overload;
    function getCombinedFilter(): JSValue; assembler; overload;
    function getCombinedFilter(returnDataField: boolean): JSValue; assembler; overload;
    function getDataSource(): TJSObject; assembler;
    function getKeyByRowIndex(rowIndex: integer): JSValue; assembler;
    function getRowElement(rowIndex: integer): JSValue; assembler;
    function getRowIndexByKey(key: JSValue): integer; assembler;
    function getScrollable(): JSValue; assembler;
    function getSelectedRowKeys(): JSValue; assembler;
    function getSelectedRowsData(): JSValue; assembler;
    function getTotalSummaryValue(summaryItemName: string): JSValue; assembler;
    function getVisibleColumnIndex(id: JSValue): integer; assembler;
    function getVisibleColumns(headerLevel: integer): TJSArray; assembler; overload;
    function getVisibleColumns(): TJSArray; assembler; overload;
    function getVisibleRows(): TJSArray; assembler;
    function hasEditData(): boolean; assembler;
    procedure hideColumnChooser(); assembler;
    function isAdaptiveDetailRowExpanded(key: JSValue): boolean; assembler;
    function isRowExpanded(key: JSValue): boolean; assembler;
    function isRowFocused(key: JSValue): boolean; assembler;
    procedure isRowSelected(); assembler; overload;
    function isRowSelected(data: JSValue): boolean; assembler; overload;
    function keyOf(obj: TJSObject): JSValue; assembler;
    function navigateToRow(key: JSValue): TJSPromise; assembler;
    function off(eventName: string): TJSElement; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function pageCount(): integer; assembler;
    function pageIndex(newIndex: integer): TJSPromise; assembler; overload;
    function pageIndex(): integer; assembler; overload;
    procedure pageSize(value: integer); assembler; overload;
    function pageSize(): integer; assembler; overload;
    function refresh(changesOnly: boolean): TJSPromise; assembler; overload;
    function refresh(): TJSPromise; assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler; overload;
    procedure registerKeyHandler(); assembler; overload;
    procedure repaint(); assembler;
    procedure repaintRows(rowIndexes: TJSArray); assembler;
    procedure resetOption(optionName: string); assembler;
    function saveEditData(): TJSPromise; assembler;
    procedure searchByText(text: string); assembler;
    function selectAll(): TJSPromise; assembler;
    function selectRows(keys: TJSArray; preserve: boolean): TJSPromise; assembler;
    function selectRowsByIndexes(indexes: TJSArray): TJSPromise; assembler;
    procedure showColumnChooser(); assembler;
    function startSelectionWithCheckboxes(): boolean; assembler;
    procedure state(state: TJSObject); assembler; overload;
    function state(): TJSObject; assembler; overload;
    function stopSelectionWithCheckboxes(): boolean; assembler;
    function totalCount(): integer; assembler;
    procedure undeleteRow(rowIndex: integer); assembler;
    procedure updateDimensions(); assembler;
  public
    property columnChooser: TJSObject read FcolumnChooser write Set_columnChooser;
    property columnFixing: TJSObject read FcolumnFixing write Set_columnFixing;
    property columnResizingMode: JSValue read FcolumnResizingMode write Set_columnResizingMode;
    property columns: TJSArray read Fcolumns write Set_columns;
    property columnWidth: JSValue read FcolumnWidth write Set_columnWidth;
    property customizeColumns: TJSFunction read FcustomizeColumns write Set_customizeColumns;
    property dataRowTemplate: JSValue read FdataRowTemplate write Set_dataRowTemplate;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property editing: TJSObject read Fediting write Set_editing;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property filterBuilder: JSValue read FfilterBuilder write Set_filterBuilder;
    property filterBuilderPopup: JSValue read FfilterBuilderPopup write Set_filterBuilderPopup;
    property filterPanel: TJSObject read FfilterPanel write Set_filterPanel;
    property filterRow: TJSObject read FfilterRow write Set_filterRow;
    property filterSyncEnabled: JSValue read FfilterSyncEnabled write Set_filterSyncEnabled;
    property filterValue: JSValue read FfilterValue write Set_filterValue;
    property focusedRowKey: JSValue read FfocusedRowKey write Set_focusedRowKey;
    property grouping: TJSObject read Fgrouping write Set_grouping;
    property groupPanel: TJSObject read FgroupPanel write Set_groupPanel;
    property headerFilter: TJSObject read FheaderFilter write Set_headerFilter;
    property height_: JSValue read Fheight_ write Set_height_;
    property keyboardNavigation: TJSObject read FkeyboardNavigation write Set_keyboardNavigation;
    property keyExpr: JSValue read FkeyExpr write Set_keyExpr;
    property loadPanel: TJSObject read FloadPanel write Set_loadPanel;
    property masterDetail: TJSObject read FmasterDetail write Set_masterDetail;
    property pager: TJSObject read Fpager write Set_pager;
    property paging: TJSObject read Fpaging write Set_paging;
    property remoteOperations: TJSObject read FremoteOperations write Set_remoteOperations;
    property rowDragging: TJSObject read FrowDragging write Set_rowDragging;
    property scrolling: TJSObject read Fscrolling write Set_scrolling;
    property searchPanel: TJSObject read FsearchPanel write Set_searchPanel;
    property selectedRowKeys: TJSArray read FselectedRowKeys write Set_selectedRowKeys;
    property selection: TJSObject read Fselection write Set_selection;
    property selectionFilter: JSValue read FselectionFilter write Set_selectionFilter;
    property sortByGroupSummaryInfo: TJSArray read FsortByGroupSummaryInfo write Set_sortByGroupSummaryInfo;
    property sorting: TJSObject read Fsorting write Set_sorting;
    property stateStoring: TJSObject read FstateStoring write Set_stateStoring;
    property summary: TJSObject read Fsummary write Set_summary;
    property toolbar: JSValue read Ftoolbar write Set_toolbar;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property allowColumnReordering: boolean read FallowColumnReordering write Set_allowColumnReordering default false;
    property allowColumnResizing: boolean read FallowColumnResizing write Set_allowColumnResizing default false;
    property autoNavigateToFocusedRow: boolean read FautoNavigateToFocusedRow write Set_autoNavigateToFocusedRow default true;
    property cacheEnabled: boolean read FcacheEnabled write Set_cacheEnabled default true;
    property cellHintEnabled: boolean read FcellHintEnabled write Set_cellHintEnabled default true;
    property columnAutoWidth: boolean read FcolumnAutoWidth write Set_columnAutoWidth default false;
    property columnHidingEnabled: boolean read FcolumnHidingEnabled write Set_columnHidingEnabled default false;
    property columnMinWidth: integer read FcolumnMinWidth write Set_columnMinWidth;
    property dateSerializationFormat: string read FdateSerializationFormat write Set_dateSerializationFormat;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property errorRowEnabled: boolean read FerrorRowEnabled write Set_errorRowEnabled default true;
    property focusedColumnIndex: integer read FfocusedColumnIndex write Set_focusedColumnIndex;
    property focusedRowEnabled: boolean read FfocusedRowEnabled write Set_focusedRowEnabled default false;
    property focusedRowIndex: integer read FfocusedRowIndex write Set_focusedRowIndex;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property highlightChanges: boolean read FhighlightChanges write Set_highlightChanges default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property noDataText: string read FnoDataText write Set_noDataText;
    property regenerateColumnsByVisibleItems: boolean read FregenerateColumnsByVisibleItems write Set_regenerateColumnsByVisibleItems default false;
    property renderAsync: boolean read FrenderAsync write Set_renderAsync default false;
    property repaintChangesOnly: boolean read FrepaintChangesOnly write Set_repaintChangesOnly default false;
    property rowAlternationEnabled: boolean read FrowAlternationEnabled write Set_rowAlternationEnabled default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showBorders: boolean read FshowBorders write Set_showBorders default false;
    property showColumnHeaders: boolean read FshowColumnHeaders write Set_showColumnHeaders default true;
    property showColumnLines: boolean read FshowColumnLines write Set_showColumnLines;
    property showRowLines: boolean read FshowRowLines write Set_showRowLines;
    property syncLookupFilterValues: boolean read FsyncLookupFilterValues write Set_syncLookupFilterValues default true;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property twoWayBindingEnabled: boolean read FtwoWayBindingEnabled write Set_twoWayBindingEnabled default true;
    property visible: boolean read Fvisible write Set_visible default true;
    property wordWrapEnabled: boolean read FwordWrapEnabled write Set_wordWrapEnabled default false;
  published
    property onAdaptiveDetailRowPreparing: TdxEventHandler read FonAdaptiveDetailRowPreparing write Set_onAdaptiveDetailRowPreparing;
    property onCellClick: TdxEventHandler read FonCellClick write Set_onCellClick;
    property onCellDblClick: TdxEventHandler read FonCellDblClick write Set_onCellDblClick;
    property onCellHoverChanged: TdxEventHandler read FonCellHoverChanged write Set_onCellHoverChanged;
    property onCellPrepared: TdxEventHandler read FonCellPrepared write Set_onCellPrepared;
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onContextMenuPreparing: TdxEventHandler read FonContextMenuPreparing write Set_onContextMenuPreparing;
    property onDataErrorOccurred: TdxEventHandler read FonDataErrorOccurred write Set_onDataErrorOccurred;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onEditCanceled: TdxEventHandler read FonEditCanceled write Set_onEditCanceled;
    property onEditCanceling: TdxEventHandler read FonEditCanceling write Set_onEditCanceling;
    property onEditingStart: TdxEventHandler read FonEditingStart write Set_onEditingStart;
    property onEditorPrepared: TdxEventHandler read FonEditorPrepared write Set_onEditorPrepared;
    property onEditorPreparing: TdxEventHandler read FonEditorPreparing write Set_onEditorPreparing;
    property onExporting: TdxEventHandler read FonExporting write Set_onExporting;
    property onFocusedCellChanged: TdxEventHandler read FonFocusedCellChanged write Set_onFocusedCellChanged;
    property onFocusedCellChanging: TdxEventHandler read FonFocusedCellChanging write Set_onFocusedCellChanging;
    property onFocusedRowChanged: TdxEventHandler read FonFocusedRowChanged write Set_onFocusedRowChanged;
    property onFocusedRowChanging: TdxEventHandler read FonFocusedRowChanging write Set_onFocusedRowChanging;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onInitNewRow: TdxEventHandler read FonInitNewRow write Set_onInitNewRow;
    property onKeyDown: TdxEventHandler read FonKeyDown write Set_onKeyDown;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onRowClick: TdxEventHandler read FonRowClick write Set_onRowClick;
    property onRowCollapsed: TdxEventHandler read FonRowCollapsed write Set_onRowCollapsed;
    property onRowCollapsing: TdxEventHandler read FonRowCollapsing write Set_onRowCollapsing;
    property onRowDblClick: TdxEventHandler read FonRowDblClick write Set_onRowDblClick;
    property onRowExpanded: TdxEventHandler read FonRowExpanded write Set_onRowExpanded;
    property onRowExpanding: TdxEventHandler read FonRowExpanding write Set_onRowExpanding;
    property onRowInserted: TdxEventHandler read FonRowInserted write Set_onRowInserted;
    property onRowInserting: TdxEventHandler read FonRowInserting write Set_onRowInserting;
    property onRowPrepared: TdxEventHandler read FonRowPrepared write Set_onRowPrepared;
    property onRowRemoved: TdxEventHandler read FonRowRemoved write Set_onRowRemoved;
    property onRowRemoving: TdxEventHandler read FonRowRemoving write Set_onRowRemoving;
    property onRowUpdated: TdxEventHandler read FonRowUpdated write Set_onRowUpdated;
    property onRowUpdating: TdxEventHandler read FonRowUpdating write Set_onRowUpdating;
    property onRowValidating: TdxEventHandler read FonRowValidating write Set_onRowValidating;
    property onSaved: TdxEventHandler read FonSaved write Set_onSaved;
    property onSaving: TdxEventHandler read FonSaving write Set_onSaving;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
    property onToolbarPreparing: TdxEventHandler read FonToolbarPreparing write Set_onToolbarPreparing;
  end;

implementation


procedure TjdxCustomDataGrid.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FallowColumnReordering := false;
  FallowColumnResizing := false;
  FautoNavigateToFocusedRow := true;
  FcacheEnabled := true;
  FcellHintEnabled := true;
  FcolumnAutoWidth := false;
  FcolumnChooser := TJSObject.new;
  FcolumnFixing := TJSObject.new;
  FcolumnHidingEnabled := false;
  FcolumnMinWidth := 0;
  FcolumnResizingMode := nil;
  Fcolumns := TJSArray.new;
  FcolumnWidth := nil;
  FcustomizeColumns := nil;
  FdataRowTemplate := nil;
  FdataSource := nil;
  FdateSerializationFormat := '';
  Fdisabled := false;
  Fediting := TJSObject.new;
  FelementAttr := TJSObject.new;
  FerrorRowEnabled := true;
  Fexport := TJSObject.new;
  FfilterBuilder := nil;
  FfilterBuilderPopup := nil;
  FfilterPanel := TJSObject.new;
  FfilterRow := TJSObject.new;
  FfilterSyncEnabled := nil;
  FfilterValue := nil;
  FfocusedColumnIndex := 0;
  FfocusedRowEnabled := false;
  FfocusedRowIndex := 0;
  FfocusedRowKey := nil;
  FfocusStateEnabled := false;
  Fgrouping := TJSObject.new;
  FgroupPanel := TJSObject.new;
  FheaderFilter := TJSObject.new;
  Fheight_ := nil;
  FhighlightChanges := false;
  Fhint := '';
  FhoverStateEnabled := false;
  FkeyboardNavigation := TJSObject.new;
  FkeyExpr := nil;
  FloadPanel := TJSObject.new;
  FmasterDetail := TJSObject.new;
  FnoDataText := '';
  Fpager := TJSObject.new;
  Fpaging := TJSObject.new;
  FregenerateColumnsByVisibleItems := false;
  FremoteOperations := TJSObject.new;
  FrenderAsync := false;
  FrepaintChangesOnly := false;
  FrowAlternationEnabled := false;
  FrowDragging := TJSObject.new;
  FrtlEnabled := false;
  Fscrolling := TJSObject.new;
  FsearchPanel := TJSObject.new;
  FselectedRowKeys := TJSArray.new;
  Fselection := TJSObject.new;
  FselectionFilter := nil;
  FshowBorders := false;
  FshowColumnHeaders := true;
  FshowColumnLines := false;
  FshowRowLines := false;
  FsortByGroupSummaryInfo := TJSArray.new;
  Fsorting := TJSObject.new;
  FstateStoring := TJSObject.new;
  Fsummary := TJSObject.new;
  FsyncLookupFilterValues := true;
  FtabIndex := 0;
  Ftoolbar := nil;
  FtwoWayBindingEnabled := true;
  Fvisible := true;
  Fwidth_ := nil;
  FwordWrapEnabled := false;

  FonAdaptiveDetailRowPreparing := nil;
  FonCellClick := nil;
  FonCellDblClick := nil;
  FonCellHoverChanged := nil;
  FonCellPrepared := nil;
  FonContentReady := nil;
  FonContextMenuPreparing := nil;
  FonDataErrorOccurred := nil;
  FonDisposing := nil;
  FonEditCanceled := nil;
  FonEditCanceling := nil;
  FonEditingStart := nil;
  FonEditorPrepared := nil;
  FonEditorPreparing := nil;
  FonExporting := nil;
  FonFocusedCellChanged := nil;
  FonFocusedCellChanging := nil;
  FonFocusedRowChanged := nil;
  FonFocusedRowChanging := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonInitNewRow := nil;
  FonKeyDown := nil;
  FonOptionChanged := nil;
  FonRowClick := nil;
  FonRowCollapsed := nil;
  FonRowCollapsing := nil;
  FonRowDblClick := nil;
  FonRowExpanded := nil;
  FonRowExpanding := nil;
  FonRowInserted := nil;
  FonRowInserting := nil;
  FonRowPrepared := nil;
  FonRowRemoved := nil;
  FonRowRemoving := nil;
  FonRowUpdated := nil;
  FonRowUpdating := nil;
  FonRowValidating := nil;
  FonSaved := nil;
  FonSaving := nil;
  FonSelectionChanged := nil;
  FonToolbarPreparing := nil;
end;
procedure TjdxCustomDataGrid.InitJQuery;
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
      $(id).dxDataGrid(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomDataGrid.getInstance(element: TJSObject): TdxDataGrid;
asm
  return DevExpress.viz.dxDataGrid.getInstance(element);
end;

function TjdxCustomDataGrid.instance: TdxDataGrid;
asm
  return $(this.GetJQID()).dxDataGrid("instance");
end;
procedure TjdxCustomDataGrid.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('allowColumnReordering', allowColumnReordering);
    SetOption('allowColumnResizing', allowColumnResizing);
    SetOption('autoNavigateToFocusedRow', autoNavigateToFocusedRow);
    SetOption('cacheEnabled', cacheEnabled);
    SetOption('cellHintEnabled', cellHintEnabled);
    SetOption('columnAutoWidth', columnAutoWidth);
    SetOption('columnChooser', columnChooser);
    SetOption('columnFixing', columnFixing);
    SetOption('columnHidingEnabled', columnHidingEnabled);
    SetOption('columnMinWidth', columnMinWidth);
    SetOption('columnResizingMode', columnResizingMode);
    SetOption('columns', columns);
    SetOption('columnWidth', columnWidth);
    SetOption('customizeColumns', customizeColumns);
    SetOption('dataRowTemplate', dataRowTemplate);
    SetOption('dataSource', dataSource);
    SetOption('dateSerializationFormat', dateSerializationFormat);
    SetOption('disabled', disabled);
    SetOption('editing', editing);
    SetOption('elementAttr', elementAttr);
    SetOption('errorRowEnabled', errorRowEnabled);
    SetOption('export', export);
    SetOption('filterBuilder', filterBuilder);
    SetOption('filterBuilderPopup', filterBuilderPopup);
    SetOption('filterPanel', filterPanel);
    SetOption('filterRow', filterRow);
    SetOption('filterSyncEnabled', filterSyncEnabled);
    SetOption('filterValue', filterValue);
    SetOption('focusedColumnIndex', focusedColumnIndex);
    SetOption('focusedRowEnabled', focusedRowEnabled);
    SetOption('focusedRowIndex', focusedRowIndex);
    SetOption('focusedRowKey', focusedRowKey);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('grouping', grouping);
    SetOption('groupPanel', groupPanel);
    SetOption('headerFilter', headerFilter);
    SetOption('height', height_);
    SetOption('highlightChanges', highlightChanges);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('keyboardNavigation', keyboardNavigation);
    SetOption('keyExpr', keyExpr);
    SetOption('loadPanel', loadPanel);
    SetOption('masterDetail', masterDetail);
    SetOption('noDataText', noDataText);
    SetOption('pager', pager);
    SetOption('paging', paging);
    SetOption('regenerateColumnsByVisibleItems', regenerateColumnsByVisibleItems);
    SetOption('remoteOperations', remoteOperations);
    SetOption('renderAsync', renderAsync);
    SetOption('repaintChangesOnly', repaintChangesOnly);
    SetOption('rowAlternationEnabled', rowAlternationEnabled);
    SetOption('rowDragging', rowDragging);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('scrolling', scrolling);
    SetOption('searchPanel', searchPanel);
    SetOption('selectedRowKeys', selectedRowKeys);
    SetOption('selection', selection);
    SetOption('selectionFilter', selectionFilter);
    SetOption('showBorders', showBorders);
    SetOption('showColumnHeaders', showColumnHeaders);
    SetOption('showColumnLines', showColumnLines);
    SetOption('showRowLines', showRowLines);
    SetOption('sortByGroupSummaryInfo', sortByGroupSummaryInfo);
    SetOption('sorting', sorting);
    SetOption('stateStoring', stateStoring);
    SetOption('summary', summary);
    SetOption('syncLookupFilterValues', syncLookupFilterValues);
    SetOption('tabIndex', tabIndex);
    SetOption('toolbar', toolbar);
    SetOption('twoWayBindingEnabled', twoWayBindingEnabled);
    SetOption('visible', visible);
    SetOption('width', width_);
    SetOption('wordWrapEnabled', wordWrapEnabled);

    SetEvent('adaptiveDetailRowPreparing', onAdaptiveDetailRowPreparing);
    SetEvent('cellClick', onCellClick);
    SetEvent('cellDblClick', onCellDblClick);
    SetEvent('cellHoverChanged', onCellHoverChanged);
    SetEvent('cellPrepared', onCellPrepared);
    SetEvent('contentReady', onContentReady);
    SetEvent('contextMenuPreparing', onContextMenuPreparing);
    SetEvent('dataErrorOccurred', onDataErrorOccurred);
    SetEvent('disposing', onDisposing);
    SetEvent('editCanceled', onEditCanceled);
    SetEvent('editCanceling', onEditCanceling);
    SetEvent('editingStart', onEditingStart);
    SetEvent('editorPrepared', onEditorPrepared);
    SetEvent('editorPreparing', onEditorPreparing);
    SetEvent('exporting', onExporting);
    SetEvent('focusedCellChanged', onFocusedCellChanged);
    SetEvent('focusedCellChanging', onFocusedCellChanging);
    SetEvent('focusedRowChanged', onFocusedRowChanged);
    SetEvent('focusedRowChanging', onFocusedRowChanging);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('initNewRow', onInitNewRow);
    SetEvent('keyDown', onKeyDown);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('rowClick', onRowClick);
    SetEvent('rowCollapsed', onRowCollapsed);
    SetEvent('rowCollapsing', onRowCollapsing);
    SetEvent('rowDblClick', onRowDblClick);
    SetEvent('rowExpanded', onRowExpanded);
    SetEvent('rowExpanding', onRowExpanding);
    SetEvent('rowInserted', onRowInserted);
    SetEvent('rowInserting', onRowInserting);
    SetEvent('rowPrepared', onRowPrepared);
    SetEvent('rowRemoved', onRowRemoved);
    SetEvent('rowRemoving', onRowRemoving);
    SetEvent('rowUpdated', onRowUpdated);
    SetEvent('rowUpdating', onRowUpdating);
    SetEvent('rowValidating', onRowValidating);
    SetEvent('saved', onSaved);
    SetEvent('saving', onSaving);
    SetEvent('selectionChanged', onSelectionChanged);
    SetEvent('toolbarPreparing', onToolbarPreparing);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomDataGrid.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomDataGrid.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomDataGrid.Set_allowColumnReordering(const Value: boolean);
begin
  FallowColumnReordering := Value;
  SetOption('allowColumnReordering', allowColumnReordering);
end;

procedure TjdxCustomDataGrid.Set_allowColumnResizing(const Value: boolean);
begin
  FallowColumnResizing := Value;
  SetOption('allowColumnResizing', allowColumnResizing);
end;

procedure TjdxCustomDataGrid.Set_autoNavigateToFocusedRow(const Value: boolean);
begin
  FautoNavigateToFocusedRow := Value;
  SetOption('autoNavigateToFocusedRow', autoNavigateToFocusedRow);
end;

procedure TjdxCustomDataGrid.Set_cacheEnabled(const Value: boolean);
begin
  FcacheEnabled := Value;
  SetOption('cacheEnabled', cacheEnabled);
end;

procedure TjdxCustomDataGrid.Set_cellHintEnabled(const Value: boolean);
begin
  FcellHintEnabled := Value;
  SetOption('cellHintEnabled', cellHintEnabled);
end;

procedure TjdxCustomDataGrid.Set_columnAutoWidth(const Value: boolean);
begin
  FcolumnAutoWidth := Value;
  SetOption('columnAutoWidth', columnAutoWidth);
end;

procedure TjdxCustomDataGrid.Set_columnChooser(const Value: TJSObject);
begin
  FcolumnChooser := Value;
  SetOption('columnChooser', columnChooser);
end;

procedure TjdxCustomDataGrid.Set_columnFixing(const Value: TJSObject);
begin
  FcolumnFixing := Value;
  SetOption('columnFixing', columnFixing);
end;

procedure TjdxCustomDataGrid.Set_columnHidingEnabled(const Value: boolean);
begin
  FcolumnHidingEnabled := Value;
  SetOption('columnHidingEnabled', columnHidingEnabled);
end;

procedure TjdxCustomDataGrid.Set_columnMinWidth(const Value: integer);
begin
  FcolumnMinWidth := Value;
  SetOption('columnMinWidth', columnMinWidth);
end;

procedure TjdxCustomDataGrid.Set_columnResizingMode(const Value: JSValue);
begin
  FcolumnResizingMode := Value;
  SetOption('columnResizingMode', columnResizingMode);
end;

procedure TjdxCustomDataGrid.Set_columns(const Value: TJSArray);
begin
  Fcolumns := Value;
  SetOption('columns', columns);
end;

procedure TjdxCustomDataGrid.Set_columnWidth(const Value: JSValue);
begin
  FcolumnWidth := Value;
  SetOption('columnWidth', columnWidth);
end;

procedure TjdxCustomDataGrid.Set_customizeColumns(const Value: TJSFunction);
begin
  FcustomizeColumns := Value;
  SetOption('customizeColumns', customizeColumns);
end;

procedure TjdxCustomDataGrid.Set_dataRowTemplate(const Value: JSValue);
begin
  FdataRowTemplate := Value;
  SetOption('dataRowTemplate', dataRowTemplate);
end;

procedure TjdxCustomDataGrid.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomDataGrid.Set_dateSerializationFormat(const Value: string);
begin
  FdateSerializationFormat := Value;
  SetOption('dateSerializationFormat', dateSerializationFormat);
end;

procedure TjdxCustomDataGrid.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomDataGrid.Set_editing(const Value: TJSObject);
begin
  Fediting := Value;
  SetOption('editing', editing);
end;

procedure TjdxCustomDataGrid.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomDataGrid.Set_errorRowEnabled(const Value: boolean);
begin
  FerrorRowEnabled := Value;
  SetOption('errorRowEnabled', errorRowEnabled);
end;

procedure TjdxCustomDataGrid.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
  SetOption('export', export);
end;

procedure TjdxCustomDataGrid.Set_filterBuilder(const Value: JSValue);
begin
  FfilterBuilder := Value;
  SetOption('filterBuilder', filterBuilder);
end;

procedure TjdxCustomDataGrid.Set_filterBuilderPopup(const Value: JSValue);
begin
  FfilterBuilderPopup := Value;
  SetOption('filterBuilderPopup', filterBuilderPopup);
end;

procedure TjdxCustomDataGrid.Set_filterPanel(const Value: TJSObject);
begin
  FfilterPanel := Value;
  SetOption('filterPanel', filterPanel);
end;

procedure TjdxCustomDataGrid.Set_filterRow(const Value: TJSObject);
begin
  FfilterRow := Value;
  SetOption('filterRow', filterRow);
end;

procedure TjdxCustomDataGrid.Set_filterSyncEnabled(const Value: JSValue);
begin
  FfilterSyncEnabled := Value;
  SetOption('filterSyncEnabled', filterSyncEnabled);
end;

procedure TjdxCustomDataGrid.Set_filterValue(const Value: JSValue);
begin
  FfilterValue := Value;
  SetOption('filterValue', filterValue);
end;

procedure TjdxCustomDataGrid.Set_focusedColumnIndex(const Value: integer);
begin
  FfocusedColumnIndex := Value;
  SetOption('focusedColumnIndex', focusedColumnIndex);
end;

procedure TjdxCustomDataGrid.Set_focusedRowEnabled(const Value: boolean);
begin
  FfocusedRowEnabled := Value;
  SetOption('focusedRowEnabled', focusedRowEnabled);
end;

procedure TjdxCustomDataGrid.Set_focusedRowIndex(const Value: integer);
begin
  FfocusedRowIndex := Value;
  SetOption('focusedRowIndex', focusedRowIndex);
end;

procedure TjdxCustomDataGrid.Set_focusedRowKey(const Value: JSValue);
begin
  FfocusedRowKey := Value;
  SetOption('focusedRowKey', focusedRowKey);
end;

procedure TjdxCustomDataGrid.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomDataGrid.Set_grouping(const Value: TJSObject);
begin
  Fgrouping := Value;
  SetOption('grouping', grouping);
end;

procedure TjdxCustomDataGrid.Set_groupPanel(const Value: TJSObject);
begin
  FgroupPanel := Value;
  SetOption('groupPanel', groupPanel);
end;

procedure TjdxCustomDataGrid.Set_headerFilter(const Value: TJSObject);
begin
  FheaderFilter := Value;
  SetOption('headerFilter', headerFilter);
end;

procedure TjdxCustomDataGrid.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomDataGrid.Set_highlightChanges(const Value: boolean);
begin
  FhighlightChanges := Value;
  SetOption('highlightChanges', highlightChanges);
end;

procedure TjdxCustomDataGrid.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomDataGrid.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomDataGrid.Set_keyboardNavigation(const Value: TJSObject);
begin
  FkeyboardNavigation := Value;
  SetOption('keyboardNavigation', keyboardNavigation);
end;

procedure TjdxCustomDataGrid.Set_keyExpr(const Value: JSValue);
begin
  FkeyExpr := Value;
  SetOption('keyExpr', keyExpr);
end;

procedure TjdxCustomDataGrid.Set_loadPanel(const Value: TJSObject);
begin
  FloadPanel := Value;
  SetOption('loadPanel', loadPanel);
end;

procedure TjdxCustomDataGrid.Set_masterDetail(const Value: TJSObject);
begin
  FmasterDetail := Value;
  SetOption('masterDetail', masterDetail);
end;

procedure TjdxCustomDataGrid.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
  SetOption('noDataText', noDataText);
end;

procedure TjdxCustomDataGrid.Set_pager(const Value: TJSObject);
begin
  Fpager := Value;
  SetOption('pager', pager);
end;

procedure TjdxCustomDataGrid.Set_paging(const Value: TJSObject);
begin
  Fpaging := Value;
  SetOption('paging', paging);
end;

procedure TjdxCustomDataGrid.Set_regenerateColumnsByVisibleItems(const Value: boolean);
begin
  FregenerateColumnsByVisibleItems := Value;
  SetOption('regenerateColumnsByVisibleItems', regenerateColumnsByVisibleItems);
end;

procedure TjdxCustomDataGrid.Set_remoteOperations(const Value: TJSObject);
begin
  FremoteOperations := Value;
  SetOption('remoteOperations', remoteOperations);
end;

procedure TjdxCustomDataGrid.Set_renderAsync(const Value: boolean);
begin
  FrenderAsync := Value;
  SetOption('renderAsync', renderAsync);
end;

procedure TjdxCustomDataGrid.Set_repaintChangesOnly(const Value: boolean);
begin
  FrepaintChangesOnly := Value;
  SetOption('repaintChangesOnly', repaintChangesOnly);
end;

procedure TjdxCustomDataGrid.Set_rowAlternationEnabled(const Value: boolean);
begin
  FrowAlternationEnabled := Value;
  SetOption('rowAlternationEnabled', rowAlternationEnabled);
end;

procedure TjdxCustomDataGrid.Set_rowDragging(const Value: TJSObject);
begin
  FrowDragging := Value;
  SetOption('rowDragging', rowDragging);
end;

procedure TjdxCustomDataGrid.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomDataGrid.Set_scrolling(const Value: TJSObject);
begin
  Fscrolling := Value;
  SetOption('scrolling', scrolling);
end;

procedure TjdxCustomDataGrid.Set_searchPanel(const Value: TJSObject);
begin
  FsearchPanel := Value;
  SetOption('searchPanel', searchPanel);
end;

procedure TjdxCustomDataGrid.Set_selectedRowKeys(const Value: TJSArray);
begin
  FselectedRowKeys := Value;
  SetOption('selectedRowKeys', selectedRowKeys);
end;

procedure TjdxCustomDataGrid.Set_selection(const Value: TJSObject);
begin
  Fselection := Value;
  SetOption('selection', selection);
end;

procedure TjdxCustomDataGrid.Set_selectionFilter(const Value: JSValue);
begin
  FselectionFilter := Value;
  SetOption('selectionFilter', selectionFilter);
end;

procedure TjdxCustomDataGrid.Set_showBorders(const Value: boolean);
begin
  FshowBorders := Value;
  SetOption('showBorders', showBorders);
end;

procedure TjdxCustomDataGrid.Set_showColumnHeaders(const Value: boolean);
begin
  FshowColumnHeaders := Value;
  SetOption('showColumnHeaders', showColumnHeaders);
end;

procedure TjdxCustomDataGrid.Set_showColumnLines(const Value: boolean);
begin
  FshowColumnLines := Value;
  SetOption('showColumnLines', showColumnLines);
end;

procedure TjdxCustomDataGrid.Set_showRowLines(const Value: boolean);
begin
  FshowRowLines := Value;
  SetOption('showRowLines', showRowLines);
end;

procedure TjdxCustomDataGrid.Set_sortByGroupSummaryInfo(const Value: TJSArray);
begin
  FsortByGroupSummaryInfo := Value;
  SetOption('sortByGroupSummaryInfo', sortByGroupSummaryInfo);
end;

procedure TjdxCustomDataGrid.Set_sorting(const Value: TJSObject);
begin
  Fsorting := Value;
  SetOption('sorting', sorting);
end;

procedure TjdxCustomDataGrid.Set_stateStoring(const Value: TJSObject);
begin
  FstateStoring := Value;
  SetOption('stateStoring', stateStoring);
end;

procedure TjdxCustomDataGrid.Set_summary(const Value: TJSObject);
begin
  Fsummary := Value;
  SetOption('summary', summary);
end;

procedure TjdxCustomDataGrid.Set_syncLookupFilterValues(const Value: boolean);
begin
  FsyncLookupFilterValues := Value;
  SetOption('syncLookupFilterValues', syncLookupFilterValues);
end;

procedure TjdxCustomDataGrid.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomDataGrid.Set_toolbar(const Value: JSValue);
begin
  Ftoolbar := Value;
  SetOption('toolbar', toolbar);
end;

procedure TjdxCustomDataGrid.Set_twoWayBindingEnabled(const Value: boolean);
begin
  FtwoWayBindingEnabled := Value;
  SetOption('twoWayBindingEnabled', twoWayBindingEnabled);
end;

procedure TjdxCustomDataGrid.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomDataGrid.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomDataGrid.Set_wordWrapEnabled(const Value: boolean);
begin
  FwordWrapEnabled := Value;
  SetOption('wordWrapEnabled', wordWrapEnabled);
end;

procedure TjdxCustomDataGrid.Set_onAdaptiveDetailRowPreparing(const Value: TdxEventHandler);
begin
  FonAdaptiveDetailRowPreparing := Value;
  SetEvent('adaptiveDetailRowPreparing', onAdaptiveDetailRowPreparing);
end;

procedure TjdxCustomDataGrid.Set_onCellClick(const Value: TdxEventHandler);
begin
  FonCellClick := Value;
  SetEvent('cellClick', onCellClick);
end;

procedure TjdxCustomDataGrid.Set_onCellDblClick(const Value: TdxEventHandler);
begin
  FonCellDblClick := Value;
  SetEvent('cellDblClick', onCellDblClick);
end;

procedure TjdxCustomDataGrid.Set_onCellHoverChanged(const Value: TdxEventHandler);
begin
  FonCellHoverChanged := Value;
  SetEvent('cellHoverChanged', onCellHoverChanged);
end;

procedure TjdxCustomDataGrid.Set_onCellPrepared(const Value: TdxEventHandler);
begin
  FonCellPrepared := Value;
  SetEvent('cellPrepared', onCellPrepared);
end;

procedure TjdxCustomDataGrid.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomDataGrid.Set_onContextMenuPreparing(const Value: TdxEventHandler);
begin
  FonContextMenuPreparing := Value;
  SetEvent('contextMenuPreparing', onContextMenuPreparing);
end;

procedure TjdxCustomDataGrid.Set_onDataErrorOccurred(const Value: TdxEventHandler);
begin
  FonDataErrorOccurred := Value;
  SetEvent('dataErrorOccurred', onDataErrorOccurred);
end;

procedure TjdxCustomDataGrid.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomDataGrid.Set_onEditCanceled(const Value: TdxEventHandler);
begin
  FonEditCanceled := Value;
  SetEvent('editCanceled', onEditCanceled);
end;

procedure TjdxCustomDataGrid.Set_onEditCanceling(const Value: TdxEventHandler);
begin
  FonEditCanceling := Value;
  SetEvent('editCanceling', onEditCanceling);
end;

procedure TjdxCustomDataGrid.Set_onEditingStart(const Value: TdxEventHandler);
begin
  FonEditingStart := Value;
  SetEvent('editingStart', onEditingStart);
end;

procedure TjdxCustomDataGrid.Set_onEditorPrepared(const Value: TdxEventHandler);
begin
  FonEditorPrepared := Value;
  SetEvent('editorPrepared', onEditorPrepared);
end;

procedure TjdxCustomDataGrid.Set_onEditorPreparing(const Value: TdxEventHandler);
begin
  FonEditorPreparing := Value;
  SetEvent('editorPreparing', onEditorPreparing);
end;

procedure TjdxCustomDataGrid.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
  SetEvent('exporting', onExporting);
end;

procedure TjdxCustomDataGrid.Set_onFocusedCellChanged(const Value: TdxEventHandler);
begin
  FonFocusedCellChanged := Value;
  SetEvent('focusedCellChanged', onFocusedCellChanged);
end;

procedure TjdxCustomDataGrid.Set_onFocusedCellChanging(const Value: TdxEventHandler);
begin
  FonFocusedCellChanging := Value;
  SetEvent('focusedCellChanging', onFocusedCellChanging);
end;

procedure TjdxCustomDataGrid.Set_onFocusedRowChanged(const Value: TdxEventHandler);
begin
  FonFocusedRowChanged := Value;
  SetEvent('focusedRowChanged', onFocusedRowChanged);
end;

procedure TjdxCustomDataGrid.Set_onFocusedRowChanging(const Value: TdxEventHandler);
begin
  FonFocusedRowChanging := Value;
  SetEvent('focusedRowChanging', onFocusedRowChanging);
end;

procedure TjdxCustomDataGrid.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomDataGrid.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomDataGrid.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomDataGrid.Set_onInitNewRow(const Value: TdxEventHandler);
begin
  FonInitNewRow := Value;
  SetEvent('initNewRow', onInitNewRow);
end;

procedure TjdxCustomDataGrid.Set_onKeyDown(const Value: TdxEventHandler);
begin
  FonKeyDown := Value;
  SetEvent('keyDown', onKeyDown);
end;

procedure TjdxCustomDataGrid.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomDataGrid.Set_onRowClick(const Value: TdxEventHandler);
begin
  FonRowClick := Value;
  SetEvent('rowClick', onRowClick);
end;

procedure TjdxCustomDataGrid.Set_onRowCollapsed(const Value: TdxEventHandler);
begin
  FonRowCollapsed := Value;
  SetEvent('rowCollapsed', onRowCollapsed);
end;

procedure TjdxCustomDataGrid.Set_onRowCollapsing(const Value: TdxEventHandler);
begin
  FonRowCollapsing := Value;
  SetEvent('rowCollapsing', onRowCollapsing);
end;

procedure TjdxCustomDataGrid.Set_onRowDblClick(const Value: TdxEventHandler);
begin
  FonRowDblClick := Value;
  SetEvent('rowDblClick', onRowDblClick);
end;

procedure TjdxCustomDataGrid.Set_onRowExpanded(const Value: TdxEventHandler);
begin
  FonRowExpanded := Value;
  SetEvent('rowExpanded', onRowExpanded);
end;

procedure TjdxCustomDataGrid.Set_onRowExpanding(const Value: TdxEventHandler);
begin
  FonRowExpanding := Value;
  SetEvent('rowExpanding', onRowExpanding);
end;

procedure TjdxCustomDataGrid.Set_onRowInserted(const Value: TdxEventHandler);
begin
  FonRowInserted := Value;
  SetEvent('rowInserted', onRowInserted);
end;

procedure TjdxCustomDataGrid.Set_onRowInserting(const Value: TdxEventHandler);
begin
  FonRowInserting := Value;
  SetEvent('rowInserting', onRowInserting);
end;

procedure TjdxCustomDataGrid.Set_onRowPrepared(const Value: TdxEventHandler);
begin
  FonRowPrepared := Value;
  SetEvent('rowPrepared', onRowPrepared);
end;

procedure TjdxCustomDataGrid.Set_onRowRemoved(const Value: TdxEventHandler);
begin
  FonRowRemoved := Value;
  SetEvent('rowRemoved', onRowRemoved);
end;

procedure TjdxCustomDataGrid.Set_onRowRemoving(const Value: TdxEventHandler);
begin
  FonRowRemoving := Value;
  SetEvent('rowRemoving', onRowRemoving);
end;

procedure TjdxCustomDataGrid.Set_onRowUpdated(const Value: TdxEventHandler);
begin
  FonRowUpdated := Value;
  SetEvent('rowUpdated', onRowUpdated);
end;

procedure TjdxCustomDataGrid.Set_onRowUpdating(const Value: TdxEventHandler);
begin
  FonRowUpdating := Value;
  SetEvent('rowUpdating', onRowUpdating);
end;

procedure TjdxCustomDataGrid.Set_onRowValidating(const Value: TdxEventHandler);
begin
  FonRowValidating := Value;
  SetEvent('rowValidating', onRowValidating);
end;

procedure TjdxCustomDataGrid.Set_onSaved(const Value: TdxEventHandler);
begin
  FonSaved := Value;
  SetEvent('saved', onSaved);
end;

procedure TjdxCustomDataGrid.Set_onSaving(const Value: TdxEventHandler);
begin
  FonSaving := Value;
  SetEvent('saving', onSaving);
end;

procedure TjdxCustomDataGrid.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomDataGrid.Set_onToolbarPreparing(const Value: TdxEventHandler);
begin
  FonToolbarPreparing := Value;
  SetEvent('toolbarPreparing', onToolbarPreparing);
end;

procedure TjdxCustomDataGrid.addColumn(columnOptions: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.addColumn(columnOptions);
end;

function TjdxCustomDataGrid.addRow(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.addRow();
end;

procedure TjdxCustomDataGrid.beginCustomLoading(messageText: string);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.beginCustomLoading(messageText);
end;

procedure TjdxCustomDataGrid.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.beginUpdate();
end;

function TjdxCustomDataGrid.byKey(key: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.byKey(key);
end;

procedure TjdxCustomDataGrid.cancelEditData();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.cancelEditData();
end;

function TjdxCustomDataGrid.cellValue(rowIndex: integer; visibleColumnIndex: integer): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.cellValue(rowIndex, visibleColumnIndex);
end;

procedure TjdxCustomDataGrid.cellValue(rowIndex: integer; visibleColumnIndex: integer; value: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.cellValue(rowIndex, visibleColumnIndex, value);
end;

function TjdxCustomDataGrid.cellValue(rowIndex: integer; dataField: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.cellValue(rowIndex, dataField);
end;

procedure TjdxCustomDataGrid.cellValue(rowIndex: integer; dataField: string; value: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.cellValue(rowIndex, dataField, value);
end;

procedure TjdxCustomDataGrid.clearFilter();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.clearFilter();
end;

procedure TjdxCustomDataGrid.clearFilter(filterName: string);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.clearFilter(filterName);
end;

procedure TjdxCustomDataGrid.clearGrouping();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.clearGrouping();
end;

procedure TjdxCustomDataGrid.clearSelection();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.clearSelection();
end;

procedure TjdxCustomDataGrid.clearSorting();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.clearSorting();
end;

procedure TjdxCustomDataGrid.closeEditCell();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.closeEditCell();
end;

procedure TjdxCustomDataGrid.collapseAdaptiveDetailRow();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.collapseAdaptiveDetailRow();
end;

procedure TjdxCustomDataGrid.collapseAll(groupIndex: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.collapseAll(groupIndex);
end;

function TjdxCustomDataGrid.collapseRow(key: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.collapseRow(key);
end;

function TjdxCustomDataGrid.columnCount(): integer;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.columnCount();
end;

procedure TjdxCustomDataGrid.columnOption(id: JSValue; optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.columnOption(id, optionName, optionValue);
end;

procedure TjdxCustomDataGrid.columnOption(id: JSValue; options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.columnOption(id, options);
end;

function TjdxCustomDataGrid.columnOption(id: JSValue; optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.columnOption(id, optionName);
end;

function TjdxCustomDataGrid.columnOption(id: JSValue): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.columnOption(id);
end;

procedure TjdxCustomDataGrid.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomDataGrid.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomDataGrid.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomDataGrid.deleteColumn(id: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.deleteColumn(id);
end;

procedure TjdxCustomDataGrid.deleteRow(rowIndex: integer);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.deleteRow(rowIndex);
end;

function TjdxCustomDataGrid.deselectAll(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.deselectAll();
end;

function TjdxCustomDataGrid.deselectRows(keys: TJSArray): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.deselectRows(keys);
end;

procedure TjdxCustomDataGrid.dispose();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.dispose();
end;

procedure TjdxCustomDataGrid.editCell(rowIndex: integer; visibleColumnIndex: integer);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.editCell(rowIndex, visibleColumnIndex);
end;

procedure TjdxCustomDataGrid.editCell(rowIndex: integer; dataField: string);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.editCell(rowIndex, dataField);
end;

procedure TjdxCustomDataGrid.editRow(rowIndex: integer);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.editRow(rowIndex);
end;

function TjdxCustomDataGrid.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.element();
end;

procedure TjdxCustomDataGrid.endCustomLoading();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.endCustomLoading();
end;

procedure TjdxCustomDataGrid.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomDataGrid.expandAdaptiveDetailRow(key: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.expandAdaptiveDetailRow(key);
end;

procedure TjdxCustomDataGrid.expandAll(groupIndex: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.expandAll(groupIndex);
end;

function TjdxCustomDataGrid.expandRow(key: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.expandRow(key);
end;

procedure TjdxCustomDataGrid.filter(filterExpr: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.filter(filterExpr);
end;

function TjdxCustomDataGrid.filter(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.filter();
end;

procedure TjdxCustomDataGrid.focus();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.focus();
end;

procedure TjdxCustomDataGrid.focus(element: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.focus(element);
end;

function TjdxCustomDataGrid.getCellElement(rowIndex: integer; visibleColumnIndex: integer): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.getCellElement(rowIndex, visibleColumnIndex);
end;

function TjdxCustomDataGrid.getCellElement(rowIndex: integer; dataField: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.getCellElement(rowIndex, dataField);
end;

function TjdxCustomDataGrid.getCombinedFilter(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.getCombinedFilter();
end;

function TjdxCustomDataGrid.getCombinedFilter(returnDataField: boolean): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.getCombinedFilter(returnDataField);
end;

function TjdxCustomDataGrid.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.getDataSource();
end;

function TjdxCustomDataGrid.getKeyByRowIndex(rowIndex: integer): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.getKeyByRowIndex(rowIndex);
end;

function TjdxCustomDataGrid.getRowElement(rowIndex: integer): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.getRowElement(rowIndex);
end;

function TjdxCustomDataGrid.getRowIndexByKey(key: JSValue): integer;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.getRowIndexByKey(key);
end;

function TjdxCustomDataGrid.getScrollable(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.getScrollable();
end;

function TjdxCustomDataGrid.getSelectedRowKeys(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.getSelectedRowKeys();
end;

function TjdxCustomDataGrid.getSelectedRowsData(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.getSelectedRowsData();
end;

function TjdxCustomDataGrid.getTotalSummaryValue(summaryItemName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.getTotalSummaryValue(summaryItemName);
end;

function TjdxCustomDataGrid.getVisibleColumnIndex(id: JSValue): integer;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.getVisibleColumnIndex(id);
end;

function TjdxCustomDataGrid.getVisibleColumns(headerLevel: integer): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.getVisibleColumns(headerLevel);
end;

function TjdxCustomDataGrid.getVisibleColumns(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.getVisibleColumns();
end;

function TjdxCustomDataGrid.getVisibleRows(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.getVisibleRows();
end;

function TjdxCustomDataGrid.hasEditData(): boolean;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.hasEditData();
end;

procedure TjdxCustomDataGrid.hideColumnChooser();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.hideColumnChooser();
end;

function TjdxCustomDataGrid.isAdaptiveDetailRowExpanded(key: JSValue): boolean;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.isAdaptiveDetailRowExpanded(key);
end;

function TjdxCustomDataGrid.isRowExpanded(key: JSValue): boolean;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.isRowExpanded(key);
end;

function TjdxCustomDataGrid.isRowFocused(key: JSValue): boolean;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.isRowFocused(key);
end;

procedure TjdxCustomDataGrid.isRowSelected();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.isRowSelected();
end;

function TjdxCustomDataGrid.isRowSelected(data: JSValue): boolean;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.isRowSelected(data);
end;

function TjdxCustomDataGrid.keyOf(obj: TJSObject): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.keyOf(obj);
end;

function TjdxCustomDataGrid.navigateToRow(key: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.navigateToRow(key);
end;

function TjdxCustomDataGrid.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.off(eventName);
end;

function TjdxCustomDataGrid.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomDataGrid.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.on(events);
end;

function TjdxCustomDataGrid.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomDataGrid.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.option();
end;

procedure TjdxCustomDataGrid.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.option(options);
end;

function TjdxCustomDataGrid.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomDataGrid.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomDataGrid.pageCount(): integer;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.pageCount();
end;

function TjdxCustomDataGrid.pageIndex(newIndex: integer): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.pageIndex(newIndex);
end;

function TjdxCustomDataGrid.pageIndex(): integer;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.pageIndex();
end;

procedure TjdxCustomDataGrid.pageSize(value: integer);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.pageSize(value);
end;

function TjdxCustomDataGrid.pageSize(): integer;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.pageSize();
end;

function TjdxCustomDataGrid.refresh(changesOnly: boolean): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.refresh(changesOnly);
end;

function TjdxCustomDataGrid.refresh(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.refresh();
end;

procedure TjdxCustomDataGrid.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomDataGrid.registerKeyHandler();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.registerKeyHandler();
end;

procedure TjdxCustomDataGrid.repaint();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.repaint();
end;

procedure TjdxCustomDataGrid.repaintRows(rowIndexes: TJSArray);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.repaintRows(rowIndexes);
end;

procedure TjdxCustomDataGrid.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.resetOption(optionName);
end;

function TjdxCustomDataGrid.saveEditData(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.saveEditData();
end;

procedure TjdxCustomDataGrid.searchByText(text: string);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.searchByText(text);
end;

function TjdxCustomDataGrid.selectAll(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.selectAll();
end;

function TjdxCustomDataGrid.selectRows(keys: TJSArray; preserve: boolean): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.selectRows(keys, preserve);
end;

function TjdxCustomDataGrid.selectRowsByIndexes(indexes: TJSArray): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.selectRowsByIndexes(indexes);
end;

procedure TjdxCustomDataGrid.showColumnChooser();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.showColumnChooser();
end;

function TjdxCustomDataGrid.startSelectionWithCheckboxes(): boolean;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.startSelectionWithCheckboxes();
end;

procedure TjdxCustomDataGrid.state(state: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.state(state);
end;

function TjdxCustomDataGrid.state(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.state();
end;

function TjdxCustomDataGrid.stopSelectionWithCheckboxes(): boolean;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.stopSelectionWithCheckboxes();
end;

function TjdxCustomDataGrid.totalCount(): integer;
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  return _instance.totalCount();
end;

procedure TjdxCustomDataGrid.undeleteRow(rowIndex: integer);
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.undeleteRow(rowIndex);
end;

procedure TjdxCustomDataGrid.updateDimensions();
asm
  const _instance = $(this.GetJQID()).dxDataGrid("instance");
  _instance.updateDimensions();
end;

end.
