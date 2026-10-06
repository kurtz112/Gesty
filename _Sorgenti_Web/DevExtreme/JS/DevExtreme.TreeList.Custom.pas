unit DevExtreme.TreeList.Custom;

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
  DevExtreme.TreeList.JS,
  DevExtreme.Types;

type
  TjdxCustomTreeList = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FallowColumnReordering: boolean;
    FallowColumnResizing: boolean;
    FautoExpandAll: boolean;
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
    FdataSource: JSValue;
    FdataStructure: TdxDataStructure;
    FdateSerializationFormat: string;
    Fdisabled: boolean;
    Fediting: TJSObject;
    FelementAttr: TJSObject;
    FerrorRowEnabled: boolean;
    FexpandedRowKeys: TJSArray;
    FexpandNodesOnFiltering: boolean;
    FfilterBuilder: JSValue;
    FfilterBuilderPopup: JSValue;
    FfilterMode: TdxTreeListFilterMode;
    FfilterPanel: TJSObject;
    FfilterRow: TJSObject;
    FfilterSyncEnabled: JSValue;
    FfilterValue: JSValue;
    FfocusedColumnIndex: integer;
    FfocusedRowEnabled: boolean;
    FfocusedRowIndex: integer;
    FfocusedRowKey: JSValue;
    FfocusStateEnabled: boolean;
    FhasItemsExpr: JSValue;
    FheaderFilter: TJSObject;
    Fheight_: JSValue;
    FhighlightChanges: boolean;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FitemsExpr: JSValue;
    FkeyboardNavigation: TJSObject;
    FkeyExpr: JSValue;
    FloadPanel: TJSObject;
    FnoDataText: string;
    Fpager: TJSObject;
    Fpaging: TJSObject;
    FparentIdExpr: JSValue;
    FremoteOperations: TJSObject;
    FrenderAsync: boolean;
    FrepaintChangesOnly: boolean;
    FrootValue: JSValue;
    FrowAlternationEnabled: boolean;
    FrowDragging: TJSObject;
    FrtlEnabled: boolean;
    Fscrolling: TJSObject;
    FsearchPanel: TJSObject;
    FselectedRowKeys: TJSArray;
    Fselection: TJSObject;
    FshowBorders: boolean;
    FshowColumnHeaders: boolean;
    FshowColumnLines: boolean;
    FshowRowLines: boolean;
    Fsorting: TJSObject;
    FstateStoring: TJSObject;
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
    FonFocusedCellChanged: TdxEventHandler;
    FonFocusedCellChanging: TdxEventHandler;
    FonFocusedRowChanged: TdxEventHandler;
    FonFocusedRowChanging: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonInitNewRow: TdxEventHandler;
    FonKeyDown: TdxEventHandler;
    FonNodesInitialized: TdxEventHandler;
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
    procedure Set_autoExpandAll(const value: boolean);
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
    procedure Set_dataSource(const value: JSValue);
    procedure Set_dataStructure(const value: TdxDataStructure);
    procedure Set_dateSerializationFormat(const value: string);
    procedure Set_disabled(const value: boolean);
    procedure Set_editing(const value: TJSObject);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_errorRowEnabled(const value: boolean);
    procedure Set_expandedRowKeys(const value: TJSArray);
    procedure Set_expandNodesOnFiltering(const value: boolean);
    procedure Set_filterBuilder(const value: JSValue);
    procedure Set_filterBuilderPopup(const value: JSValue);
    procedure Set_filterMode(const value: TdxTreeListFilterMode);
    procedure Set_filterPanel(const value: TJSObject);
    procedure Set_filterRow(const value: TJSObject);
    procedure Set_filterSyncEnabled(const value: JSValue);
    procedure Set_filterValue(const value: JSValue);
    procedure Set_focusedColumnIndex(const value: integer);
    procedure Set_focusedRowEnabled(const value: boolean);
    procedure Set_focusedRowIndex(const value: integer);
    procedure Set_focusedRowKey(const value: JSValue);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_hasItemsExpr(const value: JSValue);
    procedure Set_headerFilter(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_highlightChanges(const value: boolean);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_itemsExpr(const value: JSValue);
    procedure Set_keyboardNavigation(const value: TJSObject);
    procedure Set_keyExpr(const value: JSValue);
    procedure Set_loadPanel(const value: TJSObject);
    procedure Set_noDataText(const value: string);
    procedure Set_pager(const value: TJSObject);
    procedure Set_paging(const value: TJSObject);
    procedure Set_parentIdExpr(const value: JSValue);
    procedure Set_remoteOperations(const value: TJSObject);
    procedure Set_renderAsync(const value: boolean);
    procedure Set_repaintChangesOnly(const value: boolean);
    procedure Set_rootValue(const value: JSValue);
    procedure Set_rowAlternationEnabled(const value: boolean);
    procedure Set_rowDragging(const value: TJSObject);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scrolling(const value: TJSObject);
    procedure Set_searchPanel(const value: TJSObject);
    procedure Set_selectedRowKeys(const value: TJSArray);
    procedure Set_selection(const value: TJSObject);
    procedure Set_showBorders(const value: boolean);
    procedure Set_showColumnHeaders(const value: boolean);
    procedure Set_showColumnLines(const value: boolean);
    procedure Set_showRowLines(const value: boolean);
    procedure Set_sorting(const value: TJSObject);
    procedure Set_stateStoring(const value: TJSObject);
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
    procedure Set_onFocusedCellChanged(const value: TdxEventHandler);
    procedure Set_onFocusedCellChanging(const value: TdxEventHandler);
    procedure Set_onFocusedRowChanged(const value: TdxEventHandler);
    procedure Set_onFocusedRowChanging(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onInitNewRow(const value: TdxEventHandler);
    procedure Set_onKeyDown(const value: TdxEventHandler);
    procedure Set_onNodesInitialized(const value: TdxEventHandler);
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
    function getInstance(element: TJSObject): TdxTreeList; assembler;
    function instance: TdxTreeList; assembler;
  public
    procedure addColumn(columnOptions: JSValue); assembler;
    function addRow(parentId: JSValue): TJSPromise; assembler; overload;
    function addRow(): TJSPromise; assembler; overload;
    procedure beginCustomLoading(messageText: string); assembler;
    procedure beginUpdate(); assembler;
    function byKey(key: JSValue): TJSPromise; assembler;
    procedure cancelEditData(); assembler;
    function cellValue(rowIndex: integer; visibleColumnIndex: integer): JSValue; assembler; overload;
    procedure cellValue(rowIndex: integer; visibleColumnIndex: integer; value: JSValue); assembler; overload;
    function cellValue(rowIndex: integer; dataField: string): JSValue; assembler; overload;
    procedure cellValue(rowIndex: integer; dataField: string; value: JSValue); assembler; overload;
    procedure clearFilter(filterName: string); assembler; overload;
    procedure clearFilter(); assembler; overload;
    procedure clearSelection(); assembler;
    procedure clearSorting(); assembler;
    procedure closeEditCell(); assembler;
    procedure collapseAdaptiveDetailRow(); assembler;
    function collapseRow(key: JSValue): TJSPromise; assembler;
    function columnCount(): integer; assembler;
    procedure columnOption(id: JSValue; optionName: string; optionValue: JSValue); assembler; overload;
    procedure columnOption(id: JSValue; options: TJSObject); assembler; overload;
    function columnOption(id: JSValue): TJSObject; assembler; overload;
    function columnOption(id: JSValue; optionName: string): JSValue; assembler; overload;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure deleteColumn(id: JSValue); assembler;
    procedure deleteRow(rowIndex: integer); assembler;
    procedure deselectAll(); assembler; overload;
    function deselectRows(keys: TJSArray): TJSPromise; assembler;
    procedure dispose(); assembler;
    procedure editCell(rowIndex: integer; dataField: string); assembler; overload;
    procedure editCell(rowIndex: integer; visibleColumnIndex: integer); assembler; overload;
    procedure editRow(rowIndex: integer); assembler;
    function element(): TJSElement; assembler;
    procedure endCustomLoading(); assembler;
    procedure endUpdate(); assembler;
    procedure expandAdaptiveDetailRow(); assembler; overload;
    procedure expandAdaptiveDetailRow(key: JSValue); assembler; overload;
    function expandRow(key: JSValue): TJSPromise; assembler;
    function filter(): JSValue; assembler; overload;
    procedure filter(filterExpr: JSValue); assembler; overload;
    procedure focus(); assembler; overload;
    procedure focus(element: JSValue); assembler; overload;
    procedure forEachNode(nodes: TJSArray; callback: TJSFunction); assembler; overload;
    procedure forEachNode(callback: TJSFunction); assembler; overload;
    function getCellElement(rowIndex: integer; visibleColumnIndex: integer): JSValue; assembler; overload;
    function getCellElement(rowIndex: integer; dataField: string): JSValue; assembler; overload;
    function getCombinedFilter(): JSValue; assembler; overload;
    function getCombinedFilter(returnDataField: boolean): JSValue; assembler; overload;
    function getDataSource(): TJSObject; assembler;
    function getKeyByRowIndex(rowIndex: integer): JSValue; assembler;
    function getNodeByKey(key: JSValue): JSValue; assembler;
    function getRootNode(): JSValue; assembler;
    function getRowElement(rowIndex: integer): JSValue; assembler;
    function getRowIndexByKey(key: JSValue): integer; assembler;
    function getScrollable(): JSValue; assembler;
    function getSelectedRowKeys(): TJSArray; assembler; overload;
    function getSelectedRowKeys(mode: string): TJSArray; assembler; overload;
    function getSelectedRowsData(): TJSArray; assembler; overload;
    function getSelectedRowsData(mode: string): TJSArray; assembler; overload;
    function getVisibleColumnIndex(id: JSValue): integer; assembler;
    function getVisibleColumns(headerLevel: integer): TJSArray; assembler; overload;
    function getVisibleColumns(): TJSArray; assembler; overload;
    function getVisibleRows(): TJSArray; assembler;
    function hasEditData(): boolean; assembler;
    procedure hideColumnChooser(); assembler;
    function isAdaptiveDetailRowExpanded(key: JSValue): boolean; assembler; overload;
    procedure isAdaptiveDetailRowExpanded(); assembler; overload;
    function isRowExpanded(key: JSValue): boolean; assembler;
    function isRowFocused(key: JSValue): boolean; assembler;
    function isRowSelected(key: JSValue): boolean; assembler;
    function keyOf(obj: TJSObject): JSValue; assembler;
    function loadDescendants(keys: TJSArray; childrenOnly: boolean): TJSPromise; assembler; overload;
    function loadDescendants(): TJSPromise; assembler; overload;
    function loadDescendants(keys: TJSArray): TJSPromise; assembler; overload;
    procedure navigateToRow(); assembler; overload;
    function navigateToRow(key: JSValue): TJSPromise; assembler; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    function option(): TJSObject; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure pageCount(); assembler; overload;
    function pageIndex(): integer; assembler; overload;
    function pageIndex(newIndex: integer): TJSPromise; assembler; overload;
    procedure pageSize(value: integer); assembler; overload;
    function pageSize(): integer; assembler; overload;
    function refresh(changesOnly: boolean): TJSPromise; assembler; overload;
    function refresh(): TJSPromise; assembler; overload;
    procedure registerKeyHandler(); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler; overload;
    procedure repaint(); assembler;
    procedure repaintRows(rowIndexes: TJSArray); assembler;
    procedure resetOption(optionName: string); assembler;
    function saveEditData(): TJSPromise; assembler;
    procedure searchByText(text: string); assembler;
    procedure selectAll(); assembler; overload;
    function selectRows(keys: TJSArray; preserve: boolean): TJSPromise; assembler;
    function selectRowsByIndexes(indexes: TJSArray): TJSPromise; assembler;
    procedure showColumnChooser(); assembler;
    function startSelectionWithCheckboxes(): boolean; assembler;
    function state(): TJSObject; assembler; overload;
    procedure state(state: TJSObject); assembler; overload;
    function stopSelectionWithCheckboxes(): boolean; assembler;
    procedure undeleteRow(rowIndex: integer); assembler;
    procedure updateDimensions(); assembler;
  public
    property columnChooser: TJSObject read FcolumnChooser write Set_columnChooser;
    property columnFixing: TJSObject read FcolumnFixing write Set_columnFixing;
    property columnResizingMode: JSValue read FcolumnResizingMode write Set_columnResizingMode;
    property columns: TJSArray read Fcolumns write Set_columns;
    property columnWidth: JSValue read FcolumnWidth write Set_columnWidth;
    property customizeColumns: TJSFunction read FcustomizeColumns write Set_customizeColumns;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property editing: TJSObject read Fediting write Set_editing;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property expandedRowKeys: TJSArray read FexpandedRowKeys write Set_expandedRowKeys;
    property filterBuilder: JSValue read FfilterBuilder write Set_filterBuilder;
    property filterBuilderPopup: JSValue read FfilterBuilderPopup write Set_filterBuilderPopup;
    property filterPanel: TJSObject read FfilterPanel write Set_filterPanel;
    property filterRow: TJSObject read FfilterRow write Set_filterRow;
    property filterSyncEnabled: JSValue read FfilterSyncEnabled write Set_filterSyncEnabled;
    property filterValue: JSValue read FfilterValue write Set_filterValue;
    property focusedRowKey: JSValue read FfocusedRowKey write Set_focusedRowKey;
    property hasItemsExpr: JSValue read FhasItemsExpr write Set_hasItemsExpr;
    property headerFilter: TJSObject read FheaderFilter write Set_headerFilter;
    property height_: JSValue read Fheight_ write Set_height_;
    property itemsExpr: JSValue read FitemsExpr write Set_itemsExpr;
    property keyboardNavigation: TJSObject read FkeyboardNavigation write Set_keyboardNavigation;
    property keyExpr: JSValue read FkeyExpr write Set_keyExpr;
    property loadPanel: TJSObject read FloadPanel write Set_loadPanel;
    property pager: TJSObject read Fpager write Set_pager;
    property paging: TJSObject read Fpaging write Set_paging;
    property parentIdExpr: JSValue read FparentIdExpr write Set_parentIdExpr;
    property remoteOperations: TJSObject read FremoteOperations write Set_remoteOperations;
    property rootValue: JSValue read FrootValue write Set_rootValue;
    property rowDragging: TJSObject read FrowDragging write Set_rowDragging;
    property scrolling: TJSObject read Fscrolling write Set_scrolling;
    property searchPanel: TJSObject read FsearchPanel write Set_searchPanel;
    property selectedRowKeys: TJSArray read FselectedRowKeys write Set_selectedRowKeys;
    property selection: TJSObject read Fselection write Set_selection;
    property sorting: TJSObject read Fsorting write Set_sorting;
    property stateStoring: TJSObject read FstateStoring write Set_stateStoring;
    property toolbar: JSValue read Ftoolbar write Set_toolbar;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property allowColumnReordering: boolean read FallowColumnReordering write Set_allowColumnReordering default false;
    property allowColumnResizing: boolean read FallowColumnResizing write Set_allowColumnResizing default false;
    property autoExpandAll: boolean read FautoExpandAll write Set_autoExpandAll default false;
    property autoNavigateToFocusedRow: boolean read FautoNavigateToFocusedRow write Set_autoNavigateToFocusedRow default true;
    property cacheEnabled: boolean read FcacheEnabled write Set_cacheEnabled default true;
    property cellHintEnabled: boolean read FcellHintEnabled write Set_cellHintEnabled default true;
    property columnAutoWidth: boolean read FcolumnAutoWidth write Set_columnAutoWidth default false;
    property columnHidingEnabled: boolean read FcolumnHidingEnabled write Set_columnHidingEnabled default false;
    property columnMinWidth: integer read FcolumnMinWidth write Set_columnMinWidth;
    property dataStructure: TdxDataStructure read FdataStructure write Set_dataStructure default dsPlain;
    property dateSerializationFormat: string read FdateSerializationFormat write Set_dateSerializationFormat;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property errorRowEnabled: boolean read FerrorRowEnabled write Set_errorRowEnabled default true;
    property expandNodesOnFiltering: boolean read FexpandNodesOnFiltering write Set_expandNodesOnFiltering default true;
    property filterMode: TdxTreeListFilterMode read FfilterMode write Set_filterMode default tlfmWithAncestors;
    property focusedColumnIndex: integer read FfocusedColumnIndex write Set_focusedColumnIndex;
    property focusedRowEnabled: boolean read FfocusedRowEnabled write Set_focusedRowEnabled default false;
    property focusedRowIndex: integer read FfocusedRowIndex write Set_focusedRowIndex;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property highlightChanges: boolean read FhighlightChanges write Set_highlightChanges default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property noDataText: string read FnoDataText write Set_noDataText;
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
    property onFocusedCellChanged: TdxEventHandler read FonFocusedCellChanged write Set_onFocusedCellChanged;
    property onFocusedCellChanging: TdxEventHandler read FonFocusedCellChanging write Set_onFocusedCellChanging;
    property onFocusedRowChanged: TdxEventHandler read FonFocusedRowChanged write Set_onFocusedRowChanged;
    property onFocusedRowChanging: TdxEventHandler read FonFocusedRowChanging write Set_onFocusedRowChanging;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onInitNewRow: TdxEventHandler read FonInitNewRow write Set_onInitNewRow;
    property onKeyDown: TdxEventHandler read FonKeyDown write Set_onKeyDown;
    property onNodesInitialized: TdxEventHandler read FonNodesInitialized write Set_onNodesInitialized;
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


procedure TjdxCustomTreeList.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FallowColumnReordering := false;
  FallowColumnResizing := false;
  FautoExpandAll := false;
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
  FdataSource := nil;
  FdataStructure := dsPlain;
  FdateSerializationFormat := '';
  Fdisabled := false;
  Fediting := TJSObject.new;
  FelementAttr := TJSObject.new;
  FerrorRowEnabled := true;
  FexpandedRowKeys := TJSArray.new;
  FexpandNodesOnFiltering := true;
  FfilterBuilder := nil;
  FfilterBuilderPopup := nil;
  FfilterMode := tlfmWithAncestors;
  FfilterPanel := TJSObject.new;
  FfilterRow := TJSObject.new;
  FfilterSyncEnabled := nil;
  FfilterValue := nil;
  FfocusedColumnIndex := 0;
  FfocusedRowEnabled := false;
  FfocusedRowIndex := 0;
  FfocusedRowKey := nil;
  FfocusStateEnabled := false;
  FhasItemsExpr := nil;
  FheaderFilter := TJSObject.new;
  Fheight_ := nil;
  FhighlightChanges := false;
  Fhint := '';
  FhoverStateEnabled := false;
  FitemsExpr := nil;
  FkeyboardNavigation := TJSObject.new;
  FkeyExpr := nil;
  FloadPanel := TJSObject.new;
  FnoDataText := '';
  Fpager := TJSObject.new;
  Fpaging := TJSObject.new;
  FparentIdExpr := nil;
  FremoteOperations := TJSObject.new;
  FrenderAsync := false;
  FrepaintChangesOnly := false;
  FrootValue := nil;
  FrowAlternationEnabled := false;
  FrowDragging := TJSObject.new;
  FrtlEnabled := false;
  Fscrolling := TJSObject.new;
  FsearchPanel := TJSObject.new;
  FselectedRowKeys := TJSArray.new;
  Fselection := TJSObject.new;
  FshowBorders := false;
  FshowColumnHeaders := true;
  FshowColumnLines := false;
  FshowRowLines := false;
  Fsorting := TJSObject.new;
  FstateStoring := TJSObject.new;
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
  FonFocusedCellChanged := nil;
  FonFocusedCellChanging := nil;
  FonFocusedRowChanged := nil;
  FonFocusedRowChanging := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonInitNewRow := nil;
  FonKeyDown := nil;
  FonNodesInitialized := nil;
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
procedure TjdxCustomTreeList.InitJQuery;
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
      $(id).dxTreeList(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomTreeList.getInstance(element: TJSObject): TdxTreeList;
asm
  return DevExpress.viz.dxTreeList.getInstance(element);
end;

function TjdxCustomTreeList.instance: TdxTreeList;
asm
  return $(this.GetJQID()).dxTreeList("instance");
end;
procedure TjdxCustomTreeList.UpdateElement;
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
    SetOption('autoExpandAll', autoExpandAll);
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
    SetOption('dataSource', dataSource);
    SetOption('dataStructure', dataStructure.ToString());
    SetOption('dateSerializationFormat', dateSerializationFormat);
    SetOption('disabled', disabled);
    SetOption('editing', editing);
    SetOption('elementAttr', elementAttr);
    SetOption('errorRowEnabled', errorRowEnabled);
    SetOption('expandedRowKeys', expandedRowKeys);
    SetOption('expandNodesOnFiltering', expandNodesOnFiltering);
    SetOption('filterBuilder', filterBuilder);
    SetOption('filterBuilderPopup', filterBuilderPopup);
    SetOption('filterMode', filterMode.ToString());
    SetOption('filterPanel', filterPanel);
    SetOption('filterRow', filterRow);
    SetOption('filterSyncEnabled', filterSyncEnabled);
    SetOption('filterValue', filterValue);
    SetOption('focusedColumnIndex', focusedColumnIndex);
    SetOption('focusedRowEnabled', focusedRowEnabled);
    SetOption('focusedRowIndex', focusedRowIndex);
    SetOption('focusedRowKey', focusedRowKey);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('hasItemsExpr', hasItemsExpr);
    SetOption('headerFilter', headerFilter);
    SetOption('height', height_);
    SetOption('highlightChanges', highlightChanges);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('itemsExpr', itemsExpr);
    SetOption('keyboardNavigation', keyboardNavigation);
    SetOption('keyExpr', keyExpr);
    SetOption('loadPanel', loadPanel);
    SetOption('noDataText', noDataText);
    SetOption('pager', pager);
    SetOption('paging', paging);
    SetOption('parentIdExpr', parentIdExpr);
    SetOption('remoteOperations', remoteOperations);
    SetOption('renderAsync', renderAsync);
    SetOption('repaintChangesOnly', repaintChangesOnly);
    SetOption('rootValue', rootValue);
    SetOption('rowAlternationEnabled', rowAlternationEnabled);
    SetOption('rowDragging', rowDragging);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('scrolling', scrolling);
    SetOption('searchPanel', searchPanel);
    SetOption('selectedRowKeys', selectedRowKeys);
    SetOption('selection', selection);
    SetOption('showBorders', showBorders);
    SetOption('showColumnHeaders', showColumnHeaders);
    SetOption('showColumnLines', showColumnLines);
    SetOption('showRowLines', showRowLines);
    SetOption('sorting', sorting);
    SetOption('stateStoring', stateStoring);
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
    SetEvent('focusedCellChanged', onFocusedCellChanged);
    SetEvent('focusedCellChanging', onFocusedCellChanging);
    SetEvent('focusedRowChanged', onFocusedRowChanged);
    SetEvent('focusedRowChanging', onFocusedRowChanging);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('initNewRow', onInitNewRow);
    SetEvent('keyDown', onKeyDown);
    SetEvent('nodesInitialized', onNodesInitialized);
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

procedure TjdxCustomTreeList.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomTreeList.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomTreeList.Set_allowColumnReordering(const Value: boolean);
begin
  FallowColumnReordering := Value;
  SetOption('allowColumnReordering', allowColumnReordering);
end;

procedure TjdxCustomTreeList.Set_allowColumnResizing(const Value: boolean);
begin
  FallowColumnResizing := Value;
  SetOption('allowColumnResizing', allowColumnResizing);
end;

procedure TjdxCustomTreeList.Set_autoExpandAll(const Value: boolean);
begin
  FautoExpandAll := Value;
  SetOption('autoExpandAll', autoExpandAll);
end;

procedure TjdxCustomTreeList.Set_autoNavigateToFocusedRow(const Value: boolean);
begin
  FautoNavigateToFocusedRow := Value;
  SetOption('autoNavigateToFocusedRow', autoNavigateToFocusedRow);
end;

procedure TjdxCustomTreeList.Set_cacheEnabled(const Value: boolean);
begin
  FcacheEnabled := Value;
  SetOption('cacheEnabled', cacheEnabled);
end;

procedure TjdxCustomTreeList.Set_cellHintEnabled(const Value: boolean);
begin
  FcellHintEnabled := Value;
  SetOption('cellHintEnabled', cellHintEnabled);
end;

procedure TjdxCustomTreeList.Set_columnAutoWidth(const Value: boolean);
begin
  FcolumnAutoWidth := Value;
  SetOption('columnAutoWidth', columnAutoWidth);
end;

procedure TjdxCustomTreeList.Set_columnChooser(const Value: TJSObject);
begin
  FcolumnChooser := Value;
  SetOption('columnChooser', columnChooser);
end;

procedure TjdxCustomTreeList.Set_columnFixing(const Value: TJSObject);
begin
  FcolumnFixing := Value;
  SetOption('columnFixing', columnFixing);
end;

procedure TjdxCustomTreeList.Set_columnHidingEnabled(const Value: boolean);
begin
  FcolumnHidingEnabled := Value;
  SetOption('columnHidingEnabled', columnHidingEnabled);
end;

procedure TjdxCustomTreeList.Set_columnMinWidth(const Value: integer);
begin
  FcolumnMinWidth := Value;
  SetOption('columnMinWidth', columnMinWidth);
end;

procedure TjdxCustomTreeList.Set_columnResizingMode(const Value: JSValue);
begin
  FcolumnResizingMode := Value;
  SetOption('columnResizingMode', columnResizingMode);
end;

procedure TjdxCustomTreeList.Set_columns(const Value: TJSArray);
begin
  Fcolumns := Value;
  SetOption('columns', columns);
end;

procedure TjdxCustomTreeList.Set_columnWidth(const Value: JSValue);
begin
  FcolumnWidth := Value;
  SetOption('columnWidth', columnWidth);
end;

procedure TjdxCustomTreeList.Set_customizeColumns(const Value: TJSFunction);
begin
  FcustomizeColumns := Value;
  SetOption('customizeColumns', customizeColumns);
end;

procedure TjdxCustomTreeList.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomTreeList.Set_dataStructure(const Value: TdxDataStructure);
begin
  FdataStructure := Value;
  SetOption('dataStructure', dataStructure.ToString());
end;

procedure TjdxCustomTreeList.Set_dateSerializationFormat(const Value: string);
begin
  FdateSerializationFormat := Value;
  SetOption('dateSerializationFormat', dateSerializationFormat);
end;

procedure TjdxCustomTreeList.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomTreeList.Set_editing(const Value: TJSObject);
begin
  Fediting := Value;
  SetOption('editing', editing);
end;

procedure TjdxCustomTreeList.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomTreeList.Set_errorRowEnabled(const Value: boolean);
begin
  FerrorRowEnabled := Value;
  SetOption('errorRowEnabled', errorRowEnabled);
end;

procedure TjdxCustomTreeList.Set_expandedRowKeys(const Value: TJSArray);
begin
  FexpandedRowKeys := Value;
  SetOption('expandedRowKeys', expandedRowKeys);
end;

procedure TjdxCustomTreeList.Set_expandNodesOnFiltering(const Value: boolean);
begin
  FexpandNodesOnFiltering := Value;
  SetOption('expandNodesOnFiltering', expandNodesOnFiltering);
end;

procedure TjdxCustomTreeList.Set_filterBuilder(const Value: JSValue);
begin
  FfilterBuilder := Value;
  SetOption('filterBuilder', filterBuilder);
end;

procedure TjdxCustomTreeList.Set_filterBuilderPopup(const Value: JSValue);
begin
  FfilterBuilderPopup := Value;
  SetOption('filterBuilderPopup', filterBuilderPopup);
end;

procedure TjdxCustomTreeList.Set_filterMode(const Value: TdxTreeListFilterMode);
begin
  FfilterMode := Value;
  SetOption('filterMode', filterMode.ToString());
end;

procedure TjdxCustomTreeList.Set_filterPanel(const Value: TJSObject);
begin
  FfilterPanel := Value;
  SetOption('filterPanel', filterPanel);
end;

procedure TjdxCustomTreeList.Set_filterRow(const Value: TJSObject);
begin
  FfilterRow := Value;
  SetOption('filterRow', filterRow);
end;

procedure TjdxCustomTreeList.Set_filterSyncEnabled(const Value: JSValue);
begin
  FfilterSyncEnabled := Value;
  SetOption('filterSyncEnabled', filterSyncEnabled);
end;

procedure TjdxCustomTreeList.Set_filterValue(const Value: JSValue);
begin
  FfilterValue := Value;
  SetOption('filterValue', filterValue);
end;

procedure TjdxCustomTreeList.Set_focusedColumnIndex(const Value: integer);
begin
  FfocusedColumnIndex := Value;
  SetOption('focusedColumnIndex', focusedColumnIndex);
end;

procedure TjdxCustomTreeList.Set_focusedRowEnabled(const Value: boolean);
begin
  FfocusedRowEnabled := Value;
  SetOption('focusedRowEnabled', focusedRowEnabled);
end;

procedure TjdxCustomTreeList.Set_focusedRowIndex(const Value: integer);
begin
  FfocusedRowIndex := Value;
  SetOption('focusedRowIndex', focusedRowIndex);
end;

procedure TjdxCustomTreeList.Set_focusedRowKey(const Value: JSValue);
begin
  FfocusedRowKey := Value;
  SetOption('focusedRowKey', focusedRowKey);
end;

procedure TjdxCustomTreeList.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomTreeList.Set_hasItemsExpr(const Value: JSValue);
begin
  FhasItemsExpr := Value;
  SetOption('hasItemsExpr', hasItemsExpr);
end;

procedure TjdxCustomTreeList.Set_headerFilter(const Value: TJSObject);
begin
  FheaderFilter := Value;
  SetOption('headerFilter', headerFilter);
end;

procedure TjdxCustomTreeList.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomTreeList.Set_highlightChanges(const Value: boolean);
begin
  FhighlightChanges := Value;
  SetOption('highlightChanges', highlightChanges);
end;

procedure TjdxCustomTreeList.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomTreeList.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomTreeList.Set_itemsExpr(const Value: JSValue);
begin
  FitemsExpr := Value;
  SetOption('itemsExpr', itemsExpr);
end;

procedure TjdxCustomTreeList.Set_keyboardNavigation(const Value: TJSObject);
begin
  FkeyboardNavigation := Value;
  SetOption('keyboardNavigation', keyboardNavigation);
end;

procedure TjdxCustomTreeList.Set_keyExpr(const Value: JSValue);
begin
  FkeyExpr := Value;
  SetOption('keyExpr', keyExpr);
end;

procedure TjdxCustomTreeList.Set_loadPanel(const Value: TJSObject);
begin
  FloadPanel := Value;
  SetOption('loadPanel', loadPanel);
end;

procedure TjdxCustomTreeList.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
  SetOption('noDataText', noDataText);
end;

procedure TjdxCustomTreeList.Set_pager(const Value: TJSObject);
begin
  Fpager := Value;
  SetOption('pager', pager);
end;

procedure TjdxCustomTreeList.Set_paging(const Value: TJSObject);
begin
  Fpaging := Value;
  SetOption('paging', paging);
end;

procedure TjdxCustomTreeList.Set_parentIdExpr(const Value: JSValue);
begin
  FparentIdExpr := Value;
  SetOption('parentIdExpr', parentIdExpr);
end;

procedure TjdxCustomTreeList.Set_remoteOperations(const Value: TJSObject);
begin
  FremoteOperations := Value;
  SetOption('remoteOperations', remoteOperations);
end;

procedure TjdxCustomTreeList.Set_renderAsync(const Value: boolean);
begin
  FrenderAsync := Value;
  SetOption('renderAsync', renderAsync);
end;

procedure TjdxCustomTreeList.Set_repaintChangesOnly(const Value: boolean);
begin
  FrepaintChangesOnly := Value;
  SetOption('repaintChangesOnly', repaintChangesOnly);
end;

procedure TjdxCustomTreeList.Set_rootValue(const Value: JSValue);
begin
  FrootValue := Value;
  SetOption('rootValue', rootValue);
end;

procedure TjdxCustomTreeList.Set_rowAlternationEnabled(const Value: boolean);
begin
  FrowAlternationEnabled := Value;
  SetOption('rowAlternationEnabled', rowAlternationEnabled);
end;

procedure TjdxCustomTreeList.Set_rowDragging(const Value: TJSObject);
begin
  FrowDragging := Value;
  SetOption('rowDragging', rowDragging);
end;

procedure TjdxCustomTreeList.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomTreeList.Set_scrolling(const Value: TJSObject);
begin
  Fscrolling := Value;
  SetOption('scrolling', scrolling);
end;

procedure TjdxCustomTreeList.Set_searchPanel(const Value: TJSObject);
begin
  FsearchPanel := Value;
  SetOption('searchPanel', searchPanel);
end;

procedure TjdxCustomTreeList.Set_selectedRowKeys(const Value: TJSArray);
begin
  FselectedRowKeys := Value;
  SetOption('selectedRowKeys', selectedRowKeys);
end;

procedure TjdxCustomTreeList.Set_selection(const Value: TJSObject);
begin
  Fselection := Value;
  SetOption('selection', selection);
end;

procedure TjdxCustomTreeList.Set_showBorders(const Value: boolean);
begin
  FshowBorders := Value;
  SetOption('showBorders', showBorders);
end;

procedure TjdxCustomTreeList.Set_showColumnHeaders(const Value: boolean);
begin
  FshowColumnHeaders := Value;
  SetOption('showColumnHeaders', showColumnHeaders);
end;

procedure TjdxCustomTreeList.Set_showColumnLines(const Value: boolean);
begin
  FshowColumnLines := Value;
  SetOption('showColumnLines', showColumnLines);
end;

procedure TjdxCustomTreeList.Set_showRowLines(const Value: boolean);
begin
  FshowRowLines := Value;
  SetOption('showRowLines', showRowLines);
end;

procedure TjdxCustomTreeList.Set_sorting(const Value: TJSObject);
begin
  Fsorting := Value;
  SetOption('sorting', sorting);
end;

procedure TjdxCustomTreeList.Set_stateStoring(const Value: TJSObject);
begin
  FstateStoring := Value;
  SetOption('stateStoring', stateStoring);
end;

procedure TjdxCustomTreeList.Set_syncLookupFilterValues(const Value: boolean);
begin
  FsyncLookupFilterValues := Value;
  SetOption('syncLookupFilterValues', syncLookupFilterValues);
end;

procedure TjdxCustomTreeList.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomTreeList.Set_toolbar(const Value: JSValue);
begin
  Ftoolbar := Value;
  SetOption('toolbar', toolbar);
end;

procedure TjdxCustomTreeList.Set_twoWayBindingEnabled(const Value: boolean);
begin
  FtwoWayBindingEnabled := Value;
  SetOption('twoWayBindingEnabled', twoWayBindingEnabled);
end;

procedure TjdxCustomTreeList.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomTreeList.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomTreeList.Set_wordWrapEnabled(const Value: boolean);
begin
  FwordWrapEnabled := Value;
  SetOption('wordWrapEnabled', wordWrapEnabled);
end;

procedure TjdxCustomTreeList.Set_onAdaptiveDetailRowPreparing(const Value: TdxEventHandler);
begin
  FonAdaptiveDetailRowPreparing := Value;
  SetEvent('adaptiveDetailRowPreparing', onAdaptiveDetailRowPreparing);
end;

procedure TjdxCustomTreeList.Set_onCellClick(const Value: TdxEventHandler);
begin
  FonCellClick := Value;
  SetEvent('cellClick', onCellClick);
end;

procedure TjdxCustomTreeList.Set_onCellDblClick(const Value: TdxEventHandler);
begin
  FonCellDblClick := Value;
  SetEvent('cellDblClick', onCellDblClick);
end;

procedure TjdxCustomTreeList.Set_onCellHoverChanged(const Value: TdxEventHandler);
begin
  FonCellHoverChanged := Value;
  SetEvent('cellHoverChanged', onCellHoverChanged);
end;

procedure TjdxCustomTreeList.Set_onCellPrepared(const Value: TdxEventHandler);
begin
  FonCellPrepared := Value;
  SetEvent('cellPrepared', onCellPrepared);
end;

procedure TjdxCustomTreeList.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomTreeList.Set_onContextMenuPreparing(const Value: TdxEventHandler);
begin
  FonContextMenuPreparing := Value;
  SetEvent('contextMenuPreparing', onContextMenuPreparing);
end;

procedure TjdxCustomTreeList.Set_onDataErrorOccurred(const Value: TdxEventHandler);
begin
  FonDataErrorOccurred := Value;
  SetEvent('dataErrorOccurred', onDataErrorOccurred);
end;

procedure TjdxCustomTreeList.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomTreeList.Set_onEditCanceled(const Value: TdxEventHandler);
begin
  FonEditCanceled := Value;
  SetEvent('editCanceled', onEditCanceled);
end;

procedure TjdxCustomTreeList.Set_onEditCanceling(const Value: TdxEventHandler);
begin
  FonEditCanceling := Value;
  SetEvent('editCanceling', onEditCanceling);
end;

procedure TjdxCustomTreeList.Set_onEditingStart(const Value: TdxEventHandler);
begin
  FonEditingStart := Value;
  SetEvent('editingStart', onEditingStart);
end;

procedure TjdxCustomTreeList.Set_onEditorPrepared(const Value: TdxEventHandler);
begin
  FonEditorPrepared := Value;
  SetEvent('editorPrepared', onEditorPrepared);
end;

procedure TjdxCustomTreeList.Set_onEditorPreparing(const Value: TdxEventHandler);
begin
  FonEditorPreparing := Value;
  SetEvent('editorPreparing', onEditorPreparing);
end;

procedure TjdxCustomTreeList.Set_onFocusedCellChanged(const Value: TdxEventHandler);
begin
  FonFocusedCellChanged := Value;
  SetEvent('focusedCellChanged', onFocusedCellChanged);
end;

procedure TjdxCustomTreeList.Set_onFocusedCellChanging(const Value: TdxEventHandler);
begin
  FonFocusedCellChanging := Value;
  SetEvent('focusedCellChanging', onFocusedCellChanging);
end;

procedure TjdxCustomTreeList.Set_onFocusedRowChanged(const Value: TdxEventHandler);
begin
  FonFocusedRowChanged := Value;
  SetEvent('focusedRowChanged', onFocusedRowChanged);
end;

procedure TjdxCustomTreeList.Set_onFocusedRowChanging(const Value: TdxEventHandler);
begin
  FonFocusedRowChanging := Value;
  SetEvent('focusedRowChanging', onFocusedRowChanging);
end;

procedure TjdxCustomTreeList.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomTreeList.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomTreeList.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomTreeList.Set_onInitNewRow(const Value: TdxEventHandler);
begin
  FonInitNewRow := Value;
  SetEvent('initNewRow', onInitNewRow);
end;

procedure TjdxCustomTreeList.Set_onKeyDown(const Value: TdxEventHandler);
begin
  FonKeyDown := Value;
  SetEvent('keyDown', onKeyDown);
end;

procedure TjdxCustomTreeList.Set_onNodesInitialized(const Value: TdxEventHandler);
begin
  FonNodesInitialized := Value;
  SetEvent('nodesInitialized', onNodesInitialized);
end;

procedure TjdxCustomTreeList.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomTreeList.Set_onRowClick(const Value: TdxEventHandler);
begin
  FonRowClick := Value;
  SetEvent('rowClick', onRowClick);
end;

procedure TjdxCustomTreeList.Set_onRowCollapsed(const Value: TdxEventHandler);
begin
  FonRowCollapsed := Value;
  SetEvent('rowCollapsed', onRowCollapsed);
end;

procedure TjdxCustomTreeList.Set_onRowCollapsing(const Value: TdxEventHandler);
begin
  FonRowCollapsing := Value;
  SetEvent('rowCollapsing', onRowCollapsing);
end;

procedure TjdxCustomTreeList.Set_onRowDblClick(const Value: TdxEventHandler);
begin
  FonRowDblClick := Value;
  SetEvent('rowDblClick', onRowDblClick);
end;

procedure TjdxCustomTreeList.Set_onRowExpanded(const Value: TdxEventHandler);
begin
  FonRowExpanded := Value;
  SetEvent('rowExpanded', onRowExpanded);
end;

procedure TjdxCustomTreeList.Set_onRowExpanding(const Value: TdxEventHandler);
begin
  FonRowExpanding := Value;
  SetEvent('rowExpanding', onRowExpanding);
end;

procedure TjdxCustomTreeList.Set_onRowInserted(const Value: TdxEventHandler);
begin
  FonRowInserted := Value;
  SetEvent('rowInserted', onRowInserted);
end;

procedure TjdxCustomTreeList.Set_onRowInserting(const Value: TdxEventHandler);
begin
  FonRowInserting := Value;
  SetEvent('rowInserting', onRowInserting);
end;

procedure TjdxCustomTreeList.Set_onRowPrepared(const Value: TdxEventHandler);
begin
  FonRowPrepared := Value;
  SetEvent('rowPrepared', onRowPrepared);
end;

procedure TjdxCustomTreeList.Set_onRowRemoved(const Value: TdxEventHandler);
begin
  FonRowRemoved := Value;
  SetEvent('rowRemoved', onRowRemoved);
end;

procedure TjdxCustomTreeList.Set_onRowRemoving(const Value: TdxEventHandler);
begin
  FonRowRemoving := Value;
  SetEvent('rowRemoving', onRowRemoving);
end;

procedure TjdxCustomTreeList.Set_onRowUpdated(const Value: TdxEventHandler);
begin
  FonRowUpdated := Value;
  SetEvent('rowUpdated', onRowUpdated);
end;

procedure TjdxCustomTreeList.Set_onRowUpdating(const Value: TdxEventHandler);
begin
  FonRowUpdating := Value;
  SetEvent('rowUpdating', onRowUpdating);
end;

procedure TjdxCustomTreeList.Set_onRowValidating(const Value: TdxEventHandler);
begin
  FonRowValidating := Value;
  SetEvent('rowValidating', onRowValidating);
end;

procedure TjdxCustomTreeList.Set_onSaved(const Value: TdxEventHandler);
begin
  FonSaved := Value;
  SetEvent('saved', onSaved);
end;

procedure TjdxCustomTreeList.Set_onSaving(const Value: TdxEventHandler);
begin
  FonSaving := Value;
  SetEvent('saving', onSaving);
end;

procedure TjdxCustomTreeList.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomTreeList.Set_onToolbarPreparing(const Value: TdxEventHandler);
begin
  FonToolbarPreparing := Value;
  SetEvent('toolbarPreparing', onToolbarPreparing);
end;

procedure TjdxCustomTreeList.addColumn(columnOptions: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.addColumn(columnOptions);
end;

function TjdxCustomTreeList.addRow(parentId: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.addRow(parentId);
end;

function TjdxCustomTreeList.addRow(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.addRow();
end;

procedure TjdxCustomTreeList.beginCustomLoading(messageText: string);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.beginCustomLoading(messageText);
end;

procedure TjdxCustomTreeList.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.beginUpdate();
end;

function TjdxCustomTreeList.byKey(key: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.byKey(key);
end;

procedure TjdxCustomTreeList.cancelEditData();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.cancelEditData();
end;

function TjdxCustomTreeList.cellValue(rowIndex: integer; visibleColumnIndex: integer): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.cellValue(rowIndex, visibleColumnIndex);
end;

procedure TjdxCustomTreeList.cellValue(rowIndex: integer; visibleColumnIndex: integer; value: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.cellValue(rowIndex, visibleColumnIndex, value);
end;

function TjdxCustomTreeList.cellValue(rowIndex: integer; dataField: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.cellValue(rowIndex, dataField);
end;

procedure TjdxCustomTreeList.cellValue(rowIndex: integer; dataField: string; value: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.cellValue(rowIndex, dataField, value);
end;

procedure TjdxCustomTreeList.clearFilter(filterName: string);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.clearFilter(filterName);
end;

procedure TjdxCustomTreeList.clearFilter();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.clearFilter();
end;

procedure TjdxCustomTreeList.clearSelection();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.clearSelection();
end;

procedure TjdxCustomTreeList.clearSorting();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.clearSorting();
end;

procedure TjdxCustomTreeList.closeEditCell();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.closeEditCell();
end;

procedure TjdxCustomTreeList.collapseAdaptiveDetailRow();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.collapseAdaptiveDetailRow();
end;

function TjdxCustomTreeList.collapseRow(key: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.collapseRow(key);
end;

function TjdxCustomTreeList.columnCount(): integer;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.columnCount();
end;

procedure TjdxCustomTreeList.columnOption(id: JSValue; optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.columnOption(id, optionName, optionValue);
end;

procedure TjdxCustomTreeList.columnOption(id: JSValue; options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.columnOption(id, options);
end;

function TjdxCustomTreeList.columnOption(id: JSValue): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.columnOption(id);
end;

function TjdxCustomTreeList.columnOption(id: JSValue; optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.columnOption(id, optionName);
end;

procedure TjdxCustomTreeList.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomTreeList.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomTreeList.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomTreeList.deleteColumn(id: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.deleteColumn(id);
end;

procedure TjdxCustomTreeList.deleteRow(rowIndex: integer);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.deleteRow(rowIndex);
end;

procedure TjdxCustomTreeList.deselectAll();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.deselectAll();
end;

function TjdxCustomTreeList.deselectRows(keys: TJSArray): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.deselectRows(keys);
end;

procedure TjdxCustomTreeList.dispose();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.dispose();
end;

procedure TjdxCustomTreeList.editCell(rowIndex: integer; dataField: string);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.editCell(rowIndex, dataField);
end;

procedure TjdxCustomTreeList.editCell(rowIndex: integer; visibleColumnIndex: integer);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.editCell(rowIndex, visibleColumnIndex);
end;

procedure TjdxCustomTreeList.editRow(rowIndex: integer);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.editRow(rowIndex);
end;

function TjdxCustomTreeList.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.element();
end;

procedure TjdxCustomTreeList.endCustomLoading();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.endCustomLoading();
end;

procedure TjdxCustomTreeList.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomTreeList.expandAdaptiveDetailRow();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.expandAdaptiveDetailRow();
end;

procedure TjdxCustomTreeList.expandAdaptiveDetailRow(key: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.expandAdaptiveDetailRow(key);
end;

function TjdxCustomTreeList.expandRow(key: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.expandRow(key);
end;

function TjdxCustomTreeList.filter(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.filter();
end;

procedure TjdxCustomTreeList.filter(filterExpr: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.filter(filterExpr);
end;

procedure TjdxCustomTreeList.focus();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.focus();
end;

procedure TjdxCustomTreeList.focus(element: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.focus(element);
end;

procedure TjdxCustomTreeList.forEachNode(nodes: TJSArray; callback: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.forEachNode(nodes, callback);
end;

procedure TjdxCustomTreeList.forEachNode(callback: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.forEachNode(callback);
end;

function TjdxCustomTreeList.getCellElement(rowIndex: integer; visibleColumnIndex: integer): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getCellElement(rowIndex, visibleColumnIndex);
end;

function TjdxCustomTreeList.getCellElement(rowIndex: integer; dataField: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getCellElement(rowIndex, dataField);
end;

function TjdxCustomTreeList.getCombinedFilter(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getCombinedFilter();
end;

function TjdxCustomTreeList.getCombinedFilter(returnDataField: boolean): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getCombinedFilter(returnDataField);
end;

function TjdxCustomTreeList.getDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getDataSource();
end;

function TjdxCustomTreeList.getKeyByRowIndex(rowIndex: integer): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getKeyByRowIndex(rowIndex);
end;

function TjdxCustomTreeList.getNodeByKey(key: JSValue): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getNodeByKey(key);
end;

function TjdxCustomTreeList.getRootNode(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getRootNode();
end;

function TjdxCustomTreeList.getRowElement(rowIndex: integer): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getRowElement(rowIndex);
end;

function TjdxCustomTreeList.getRowIndexByKey(key: JSValue): integer;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getRowIndexByKey(key);
end;

function TjdxCustomTreeList.getScrollable(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getScrollable();
end;

function TjdxCustomTreeList.getSelectedRowKeys(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getSelectedRowKeys();
end;

function TjdxCustomTreeList.getSelectedRowKeys(mode: string): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getSelectedRowKeys(mode);
end;

function TjdxCustomTreeList.getSelectedRowsData(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getSelectedRowsData();
end;

function TjdxCustomTreeList.getSelectedRowsData(mode: string): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getSelectedRowsData(mode);
end;

function TjdxCustomTreeList.getVisibleColumnIndex(id: JSValue): integer;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getVisibleColumnIndex(id);
end;

function TjdxCustomTreeList.getVisibleColumns(headerLevel: integer): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getVisibleColumns(headerLevel);
end;

function TjdxCustomTreeList.getVisibleColumns(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getVisibleColumns();
end;

function TjdxCustomTreeList.getVisibleRows(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.getVisibleRows();
end;

function TjdxCustomTreeList.hasEditData(): boolean;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.hasEditData();
end;

procedure TjdxCustomTreeList.hideColumnChooser();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.hideColumnChooser();
end;

function TjdxCustomTreeList.isAdaptiveDetailRowExpanded(key: JSValue): boolean;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.isAdaptiveDetailRowExpanded(key);
end;

procedure TjdxCustomTreeList.isAdaptiveDetailRowExpanded();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.isAdaptiveDetailRowExpanded();
end;

function TjdxCustomTreeList.isRowExpanded(key: JSValue): boolean;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.isRowExpanded(key);
end;

function TjdxCustomTreeList.isRowFocused(key: JSValue): boolean;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.isRowFocused(key);
end;

function TjdxCustomTreeList.isRowSelected(key: JSValue): boolean;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.isRowSelected(key);
end;

function TjdxCustomTreeList.keyOf(obj: TJSObject): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.keyOf(obj);
end;

function TjdxCustomTreeList.loadDescendants(keys: TJSArray; childrenOnly: boolean): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.loadDescendants(keys, childrenOnly);
end;

function TjdxCustomTreeList.loadDescendants(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.loadDescendants();
end;

function TjdxCustomTreeList.loadDescendants(keys: TJSArray): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.loadDescendants(keys);
end;

procedure TjdxCustomTreeList.navigateToRow();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.navigateToRow();
end;

function TjdxCustomTreeList.navigateToRow(key: JSValue): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.navigateToRow(key);
end;

function TjdxCustomTreeList.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomTreeList.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.off(eventName);
end;

function TjdxCustomTreeList.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.on(events);
end;

function TjdxCustomTreeList.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.on(eventName, eventHandler);
end;

procedure TjdxCustomTreeList.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomTreeList.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.option(options);
end;

function TjdxCustomTreeList.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.option();
end;

function TjdxCustomTreeList.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomTreeList.pageCount();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.pageCount();
end;

function TjdxCustomTreeList.pageIndex(): integer;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.pageIndex();
end;

function TjdxCustomTreeList.pageIndex(newIndex: integer): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.pageIndex(newIndex);
end;

procedure TjdxCustomTreeList.pageSize(value: integer);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.pageSize(value);
end;

function TjdxCustomTreeList.pageSize(): integer;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.pageSize();
end;

function TjdxCustomTreeList.refresh(changesOnly: boolean): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.refresh(changesOnly);
end;

function TjdxCustomTreeList.refresh(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.refresh();
end;

procedure TjdxCustomTreeList.registerKeyHandler();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.registerKeyHandler();
end;

procedure TjdxCustomTreeList.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomTreeList.repaint();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.repaint();
end;

procedure TjdxCustomTreeList.repaintRows(rowIndexes: TJSArray);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.repaintRows(rowIndexes);
end;

procedure TjdxCustomTreeList.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.resetOption(optionName);
end;

function TjdxCustomTreeList.saveEditData(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.saveEditData();
end;

procedure TjdxCustomTreeList.searchByText(text: string);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.searchByText(text);
end;

procedure TjdxCustomTreeList.selectAll();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.selectAll();
end;

function TjdxCustomTreeList.selectRows(keys: TJSArray; preserve: boolean): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.selectRows(keys, preserve);
end;

function TjdxCustomTreeList.selectRowsByIndexes(indexes: TJSArray): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.selectRowsByIndexes(indexes);
end;

procedure TjdxCustomTreeList.showColumnChooser();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.showColumnChooser();
end;

function TjdxCustomTreeList.startSelectionWithCheckboxes(): boolean;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.startSelectionWithCheckboxes();
end;

function TjdxCustomTreeList.state(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.state();
end;

procedure TjdxCustomTreeList.state(state: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.state(state);
end;

function TjdxCustomTreeList.stopSelectionWithCheckboxes(): boolean;
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  return _instance.stopSelectionWithCheckboxes();
end;

procedure TjdxCustomTreeList.undeleteRow(rowIndex: integer);
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.undeleteRow(rowIndex);
end;

procedure TjdxCustomTreeList.updateDimensions();
asm
  const _instance = $(this.GetJQID()).dxTreeList("instance");
  _instance.updateDimensions();
end;

end.
