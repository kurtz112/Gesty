unit DevExtreme.DataGrid;

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
  TjdxDataGrid = class(TjdxCustomControl)
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
  public
    constructor Create(aOwner: TComponent); override;
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


constructor TjdxDataGrid.Create(aOwner: TComponent);
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

procedure TjdxDataGrid.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxDataGrid.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxDataGrid.Set_allowColumnReordering(const Value: boolean);
begin
  FallowColumnReordering := Value;
end;

procedure TjdxDataGrid.Set_allowColumnResizing(const Value: boolean);
begin
  FallowColumnResizing := Value;
end;

procedure TjdxDataGrid.Set_autoNavigateToFocusedRow(const Value: boolean);
begin
  FautoNavigateToFocusedRow := Value;
end;

procedure TjdxDataGrid.Set_cacheEnabled(const Value: boolean);
begin
  FcacheEnabled := Value;
end;

procedure TjdxDataGrid.Set_cellHintEnabled(const Value: boolean);
begin
  FcellHintEnabled := Value;
end;

procedure TjdxDataGrid.Set_columnAutoWidth(const Value: boolean);
begin
  FcolumnAutoWidth := Value;
end;

procedure TjdxDataGrid.Set_columnChooser(const Value: TJSObject);
begin
  FcolumnChooser := Value;
end;

procedure TjdxDataGrid.Set_columnFixing(const Value: TJSObject);
begin
  FcolumnFixing := Value;
end;

procedure TjdxDataGrid.Set_columnHidingEnabled(const Value: boolean);
begin
  FcolumnHidingEnabled := Value;
end;

procedure TjdxDataGrid.Set_columnMinWidth(const Value: integer);
begin
  FcolumnMinWidth := Value;
end;

procedure TjdxDataGrid.Set_columnResizingMode(const Value: JSValue);
begin
  FcolumnResizingMode := Value;
end;

procedure TjdxDataGrid.Set_columns(const Value: TJSArray);
begin
  Fcolumns := Value;
end;

procedure TjdxDataGrid.Set_columnWidth(const Value: JSValue);
begin
  FcolumnWidth := Value;
end;

procedure TjdxDataGrid.Set_customizeColumns(const Value: TJSFunction);
begin
  FcustomizeColumns := Value;
end;

procedure TjdxDataGrid.Set_dataRowTemplate(const Value: JSValue);
begin
  FdataRowTemplate := Value;
end;

procedure TjdxDataGrid.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxDataGrid.Set_dateSerializationFormat(const Value: string);
begin
  FdateSerializationFormat := Value;
end;

procedure TjdxDataGrid.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxDataGrid.Set_editing(const Value: TJSObject);
begin
  Fediting := Value;
end;

procedure TjdxDataGrid.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxDataGrid.Set_errorRowEnabled(const Value: boolean);
begin
  FerrorRowEnabled := Value;
end;

procedure TjdxDataGrid.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
end;

procedure TjdxDataGrid.Set_filterBuilder(const Value: JSValue);
begin
  FfilterBuilder := Value;
end;

procedure TjdxDataGrid.Set_filterBuilderPopup(const Value: JSValue);
begin
  FfilterBuilderPopup := Value;
end;

procedure TjdxDataGrid.Set_filterPanel(const Value: TJSObject);
begin
  FfilterPanel := Value;
end;

procedure TjdxDataGrid.Set_filterRow(const Value: TJSObject);
begin
  FfilterRow := Value;
end;

procedure TjdxDataGrid.Set_filterSyncEnabled(const Value: JSValue);
begin
  FfilterSyncEnabled := Value;
end;

procedure TjdxDataGrid.Set_filterValue(const Value: JSValue);
begin
  FfilterValue := Value;
end;

procedure TjdxDataGrid.Set_focusedColumnIndex(const Value: integer);
begin
  FfocusedColumnIndex := Value;
end;

procedure TjdxDataGrid.Set_focusedRowEnabled(const Value: boolean);
begin
  FfocusedRowEnabled := Value;
end;

procedure TjdxDataGrid.Set_focusedRowIndex(const Value: integer);
begin
  FfocusedRowIndex := Value;
end;

procedure TjdxDataGrid.Set_focusedRowKey(const Value: JSValue);
begin
  FfocusedRowKey := Value;
end;

procedure TjdxDataGrid.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxDataGrid.Set_grouping(const Value: TJSObject);
begin
  Fgrouping := Value;
end;

procedure TjdxDataGrid.Set_groupPanel(const Value: TJSObject);
begin
  FgroupPanel := Value;
end;

procedure TjdxDataGrid.Set_headerFilter(const Value: TJSObject);
begin
  FheaderFilter := Value;
end;

procedure TjdxDataGrid.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxDataGrid.Set_highlightChanges(const Value: boolean);
begin
  FhighlightChanges := Value;
end;

procedure TjdxDataGrid.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxDataGrid.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxDataGrid.Set_keyboardNavigation(const Value: TJSObject);
begin
  FkeyboardNavigation := Value;
end;

procedure TjdxDataGrid.Set_keyExpr(const Value: JSValue);
begin
  FkeyExpr := Value;
end;

procedure TjdxDataGrid.Set_loadPanel(const Value: TJSObject);
begin
  FloadPanel := Value;
end;

procedure TjdxDataGrid.Set_masterDetail(const Value: TJSObject);
begin
  FmasterDetail := Value;
end;

procedure TjdxDataGrid.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
end;

procedure TjdxDataGrid.Set_pager(const Value: TJSObject);
begin
  Fpager := Value;
end;

procedure TjdxDataGrid.Set_paging(const Value: TJSObject);
begin
  Fpaging := Value;
end;

procedure TjdxDataGrid.Set_regenerateColumnsByVisibleItems(const Value: boolean);
begin
  FregenerateColumnsByVisibleItems := Value;
end;

procedure TjdxDataGrid.Set_remoteOperations(const Value: TJSObject);
begin
  FremoteOperations := Value;
end;

procedure TjdxDataGrid.Set_renderAsync(const Value: boolean);
begin
  FrenderAsync := Value;
end;

procedure TjdxDataGrid.Set_repaintChangesOnly(const Value: boolean);
begin
  FrepaintChangesOnly := Value;
end;

procedure TjdxDataGrid.Set_rowAlternationEnabled(const Value: boolean);
begin
  FrowAlternationEnabled := Value;
end;

procedure TjdxDataGrid.Set_rowDragging(const Value: TJSObject);
begin
  FrowDragging := Value;
end;

procedure TjdxDataGrid.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxDataGrid.Set_scrolling(const Value: TJSObject);
begin
  Fscrolling := Value;
end;

procedure TjdxDataGrid.Set_searchPanel(const Value: TJSObject);
begin
  FsearchPanel := Value;
end;

procedure TjdxDataGrid.Set_selectedRowKeys(const Value: TJSArray);
begin
  FselectedRowKeys := Value;
end;

procedure TjdxDataGrid.Set_selection(const Value: TJSObject);
begin
  Fselection := Value;
end;

procedure TjdxDataGrid.Set_selectionFilter(const Value: JSValue);
begin
  FselectionFilter := Value;
end;

procedure TjdxDataGrid.Set_showBorders(const Value: boolean);
begin
  FshowBorders := Value;
end;

procedure TjdxDataGrid.Set_showColumnHeaders(const Value: boolean);
begin
  FshowColumnHeaders := Value;
end;

procedure TjdxDataGrid.Set_showColumnLines(const Value: boolean);
begin
  FshowColumnLines := Value;
end;

procedure TjdxDataGrid.Set_showRowLines(const Value: boolean);
begin
  FshowRowLines := Value;
end;

procedure TjdxDataGrid.Set_sortByGroupSummaryInfo(const Value: TJSArray);
begin
  FsortByGroupSummaryInfo := Value;
end;

procedure TjdxDataGrid.Set_sorting(const Value: TJSObject);
begin
  Fsorting := Value;
end;

procedure TjdxDataGrid.Set_stateStoring(const Value: TJSObject);
begin
  FstateStoring := Value;
end;

procedure TjdxDataGrid.Set_summary(const Value: TJSObject);
begin
  Fsummary := Value;
end;

procedure TjdxDataGrid.Set_syncLookupFilterValues(const Value: boolean);
begin
  FsyncLookupFilterValues := Value;
end;

procedure TjdxDataGrid.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxDataGrid.Set_toolbar(const Value: JSValue);
begin
  Ftoolbar := Value;
end;

procedure TjdxDataGrid.Set_twoWayBindingEnabled(const Value: boolean);
begin
  FtwoWayBindingEnabled := Value;
end;

procedure TjdxDataGrid.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxDataGrid.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxDataGrid.Set_wordWrapEnabled(const Value: boolean);
begin
  FwordWrapEnabled := Value;
end;

procedure TjdxDataGrid.Set_onAdaptiveDetailRowPreparing(const Value: TdxEventHandler);
begin
  FonAdaptiveDetailRowPreparing := Value;
end;

procedure TjdxDataGrid.Set_onCellClick(const Value: TdxEventHandler);
begin
  FonCellClick := Value;
end;

procedure TjdxDataGrid.Set_onCellDblClick(const Value: TdxEventHandler);
begin
  FonCellDblClick := Value;
end;

procedure TjdxDataGrid.Set_onCellHoverChanged(const Value: TdxEventHandler);
begin
  FonCellHoverChanged := Value;
end;

procedure TjdxDataGrid.Set_onCellPrepared(const Value: TdxEventHandler);
begin
  FonCellPrepared := Value;
end;

procedure TjdxDataGrid.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxDataGrid.Set_onContextMenuPreparing(const Value: TdxEventHandler);
begin
  FonContextMenuPreparing := Value;
end;

procedure TjdxDataGrid.Set_onDataErrorOccurred(const Value: TdxEventHandler);
begin
  FonDataErrorOccurred := Value;
end;

procedure TjdxDataGrid.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxDataGrid.Set_onEditCanceled(const Value: TdxEventHandler);
begin
  FonEditCanceled := Value;
end;

procedure TjdxDataGrid.Set_onEditCanceling(const Value: TdxEventHandler);
begin
  FonEditCanceling := Value;
end;

procedure TjdxDataGrid.Set_onEditingStart(const Value: TdxEventHandler);
begin
  FonEditingStart := Value;
end;

procedure TjdxDataGrid.Set_onEditorPrepared(const Value: TdxEventHandler);
begin
  FonEditorPrepared := Value;
end;

procedure TjdxDataGrid.Set_onEditorPreparing(const Value: TdxEventHandler);
begin
  FonEditorPreparing := Value;
end;

procedure TjdxDataGrid.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
end;

procedure TjdxDataGrid.Set_onFocusedCellChanged(const Value: TdxEventHandler);
begin
  FonFocusedCellChanged := Value;
end;

procedure TjdxDataGrid.Set_onFocusedCellChanging(const Value: TdxEventHandler);
begin
  FonFocusedCellChanging := Value;
end;

procedure TjdxDataGrid.Set_onFocusedRowChanged(const Value: TdxEventHandler);
begin
  FonFocusedRowChanged := Value;
end;

procedure TjdxDataGrid.Set_onFocusedRowChanging(const Value: TdxEventHandler);
begin
  FonFocusedRowChanging := Value;
end;

procedure TjdxDataGrid.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxDataGrid.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxDataGrid.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxDataGrid.Set_onInitNewRow(const Value: TdxEventHandler);
begin
  FonInitNewRow := Value;
end;

procedure TjdxDataGrid.Set_onKeyDown(const Value: TdxEventHandler);
begin
  FonKeyDown := Value;
end;

procedure TjdxDataGrid.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxDataGrid.Set_onRowClick(const Value: TdxEventHandler);
begin
  FonRowClick := Value;
end;

procedure TjdxDataGrid.Set_onRowCollapsed(const Value: TdxEventHandler);
begin
  FonRowCollapsed := Value;
end;

procedure TjdxDataGrid.Set_onRowCollapsing(const Value: TdxEventHandler);
begin
  FonRowCollapsing := Value;
end;

procedure TjdxDataGrid.Set_onRowDblClick(const Value: TdxEventHandler);
begin
  FonRowDblClick := Value;
end;

procedure TjdxDataGrid.Set_onRowExpanded(const Value: TdxEventHandler);
begin
  FonRowExpanded := Value;
end;

procedure TjdxDataGrid.Set_onRowExpanding(const Value: TdxEventHandler);
begin
  FonRowExpanding := Value;
end;

procedure TjdxDataGrid.Set_onRowInserted(const Value: TdxEventHandler);
begin
  FonRowInserted := Value;
end;

procedure TjdxDataGrid.Set_onRowInserting(const Value: TdxEventHandler);
begin
  FonRowInserting := Value;
end;

procedure TjdxDataGrid.Set_onRowPrepared(const Value: TdxEventHandler);
begin
  FonRowPrepared := Value;
end;

procedure TjdxDataGrid.Set_onRowRemoved(const Value: TdxEventHandler);
begin
  FonRowRemoved := Value;
end;

procedure TjdxDataGrid.Set_onRowRemoving(const Value: TdxEventHandler);
begin
  FonRowRemoving := Value;
end;

procedure TjdxDataGrid.Set_onRowUpdated(const Value: TdxEventHandler);
begin
  FonRowUpdated := Value;
end;

procedure TjdxDataGrid.Set_onRowUpdating(const Value: TdxEventHandler);
begin
  FonRowUpdating := Value;
end;

procedure TjdxDataGrid.Set_onRowValidating(const Value: TdxEventHandler);
begin
  FonRowValidating := Value;
end;

procedure TjdxDataGrid.Set_onSaved(const Value: TdxEventHandler);
begin
  FonSaved := Value;
end;

procedure TjdxDataGrid.Set_onSaving(const Value: TdxEventHandler);
begin
  FonSaving := Value;
end;

procedure TjdxDataGrid.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
end;

procedure TjdxDataGrid.Set_onToolbarPreparing(const Value: TdxEventHandler);
begin
  FonToolbarPreparing := Value;
end;

end.
