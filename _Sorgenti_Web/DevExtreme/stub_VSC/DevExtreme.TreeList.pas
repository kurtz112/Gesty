unit DevExtreme.TreeList;

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
  TjdxTreeList = class(TjdxCustomControl)
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
  public
    constructor Create(aOwner: TComponent); override;
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


constructor TjdxTreeList.Create(aOwner: TComponent);
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

procedure TjdxTreeList.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxTreeList.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxTreeList.Set_allowColumnReordering(const Value: boolean);
begin
  FallowColumnReordering := Value;
end;

procedure TjdxTreeList.Set_allowColumnResizing(const Value: boolean);
begin
  FallowColumnResizing := Value;
end;

procedure TjdxTreeList.Set_autoExpandAll(const Value: boolean);
begin
  FautoExpandAll := Value;
end;

procedure TjdxTreeList.Set_autoNavigateToFocusedRow(const Value: boolean);
begin
  FautoNavigateToFocusedRow := Value;
end;

procedure TjdxTreeList.Set_cacheEnabled(const Value: boolean);
begin
  FcacheEnabled := Value;
end;

procedure TjdxTreeList.Set_cellHintEnabled(const Value: boolean);
begin
  FcellHintEnabled := Value;
end;

procedure TjdxTreeList.Set_columnAutoWidth(const Value: boolean);
begin
  FcolumnAutoWidth := Value;
end;

procedure TjdxTreeList.Set_columnChooser(const Value: TJSObject);
begin
  FcolumnChooser := Value;
end;

procedure TjdxTreeList.Set_columnFixing(const Value: TJSObject);
begin
  FcolumnFixing := Value;
end;

procedure TjdxTreeList.Set_columnHidingEnabled(const Value: boolean);
begin
  FcolumnHidingEnabled := Value;
end;

procedure TjdxTreeList.Set_columnMinWidth(const Value: integer);
begin
  FcolumnMinWidth := Value;
end;

procedure TjdxTreeList.Set_columnResizingMode(const Value: JSValue);
begin
  FcolumnResizingMode := Value;
end;

procedure TjdxTreeList.Set_columns(const Value: TJSArray);
begin
  Fcolumns := Value;
end;

procedure TjdxTreeList.Set_columnWidth(const Value: JSValue);
begin
  FcolumnWidth := Value;
end;

procedure TjdxTreeList.Set_customizeColumns(const Value: TJSFunction);
begin
  FcustomizeColumns := Value;
end;

procedure TjdxTreeList.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxTreeList.Set_dataStructure(const Value: TdxDataStructure);
begin
  FdataStructure := Value;
end;

procedure TjdxTreeList.Set_dateSerializationFormat(const Value: string);
begin
  FdateSerializationFormat := Value;
end;

procedure TjdxTreeList.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxTreeList.Set_editing(const Value: TJSObject);
begin
  Fediting := Value;
end;

procedure TjdxTreeList.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxTreeList.Set_errorRowEnabled(const Value: boolean);
begin
  FerrorRowEnabled := Value;
end;

procedure TjdxTreeList.Set_expandedRowKeys(const Value: TJSArray);
begin
  FexpandedRowKeys := Value;
end;

procedure TjdxTreeList.Set_expandNodesOnFiltering(const Value: boolean);
begin
  FexpandNodesOnFiltering := Value;
end;

procedure TjdxTreeList.Set_filterBuilder(const Value: JSValue);
begin
  FfilterBuilder := Value;
end;

procedure TjdxTreeList.Set_filterBuilderPopup(const Value: JSValue);
begin
  FfilterBuilderPopup := Value;
end;

procedure TjdxTreeList.Set_filterMode(const Value: TdxTreeListFilterMode);
begin
  FfilterMode := Value;
end;

procedure TjdxTreeList.Set_filterPanel(const Value: TJSObject);
begin
  FfilterPanel := Value;
end;

procedure TjdxTreeList.Set_filterRow(const Value: TJSObject);
begin
  FfilterRow := Value;
end;

procedure TjdxTreeList.Set_filterSyncEnabled(const Value: JSValue);
begin
  FfilterSyncEnabled := Value;
end;

procedure TjdxTreeList.Set_filterValue(const Value: JSValue);
begin
  FfilterValue := Value;
end;

procedure TjdxTreeList.Set_focusedColumnIndex(const Value: integer);
begin
  FfocusedColumnIndex := Value;
end;

procedure TjdxTreeList.Set_focusedRowEnabled(const Value: boolean);
begin
  FfocusedRowEnabled := Value;
end;

procedure TjdxTreeList.Set_focusedRowIndex(const Value: integer);
begin
  FfocusedRowIndex := Value;
end;

procedure TjdxTreeList.Set_focusedRowKey(const Value: JSValue);
begin
  FfocusedRowKey := Value;
end;

procedure TjdxTreeList.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxTreeList.Set_hasItemsExpr(const Value: JSValue);
begin
  FhasItemsExpr := Value;
end;

procedure TjdxTreeList.Set_headerFilter(const Value: TJSObject);
begin
  FheaderFilter := Value;
end;

procedure TjdxTreeList.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxTreeList.Set_highlightChanges(const Value: boolean);
begin
  FhighlightChanges := Value;
end;

procedure TjdxTreeList.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxTreeList.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxTreeList.Set_itemsExpr(const Value: JSValue);
begin
  FitemsExpr := Value;
end;

procedure TjdxTreeList.Set_keyboardNavigation(const Value: TJSObject);
begin
  FkeyboardNavigation := Value;
end;

procedure TjdxTreeList.Set_keyExpr(const Value: JSValue);
begin
  FkeyExpr := Value;
end;

procedure TjdxTreeList.Set_loadPanel(const Value: TJSObject);
begin
  FloadPanel := Value;
end;

procedure TjdxTreeList.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
end;

procedure TjdxTreeList.Set_pager(const Value: TJSObject);
begin
  Fpager := Value;
end;

procedure TjdxTreeList.Set_paging(const Value: TJSObject);
begin
  Fpaging := Value;
end;

procedure TjdxTreeList.Set_parentIdExpr(const Value: JSValue);
begin
  FparentIdExpr := Value;
end;

procedure TjdxTreeList.Set_remoteOperations(const Value: TJSObject);
begin
  FremoteOperations := Value;
end;

procedure TjdxTreeList.Set_renderAsync(const Value: boolean);
begin
  FrenderAsync := Value;
end;

procedure TjdxTreeList.Set_repaintChangesOnly(const Value: boolean);
begin
  FrepaintChangesOnly := Value;
end;

procedure TjdxTreeList.Set_rootValue(const Value: JSValue);
begin
  FrootValue := Value;
end;

procedure TjdxTreeList.Set_rowAlternationEnabled(const Value: boolean);
begin
  FrowAlternationEnabled := Value;
end;

procedure TjdxTreeList.Set_rowDragging(const Value: TJSObject);
begin
  FrowDragging := Value;
end;

procedure TjdxTreeList.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxTreeList.Set_scrolling(const Value: TJSObject);
begin
  Fscrolling := Value;
end;

procedure TjdxTreeList.Set_searchPanel(const Value: TJSObject);
begin
  FsearchPanel := Value;
end;

procedure TjdxTreeList.Set_selectedRowKeys(const Value: TJSArray);
begin
  FselectedRowKeys := Value;
end;

procedure TjdxTreeList.Set_selection(const Value: TJSObject);
begin
  Fselection := Value;
end;

procedure TjdxTreeList.Set_showBorders(const Value: boolean);
begin
  FshowBorders := Value;
end;

procedure TjdxTreeList.Set_showColumnHeaders(const Value: boolean);
begin
  FshowColumnHeaders := Value;
end;

procedure TjdxTreeList.Set_showColumnLines(const Value: boolean);
begin
  FshowColumnLines := Value;
end;

procedure TjdxTreeList.Set_showRowLines(const Value: boolean);
begin
  FshowRowLines := Value;
end;

procedure TjdxTreeList.Set_sorting(const Value: TJSObject);
begin
  Fsorting := Value;
end;

procedure TjdxTreeList.Set_stateStoring(const Value: TJSObject);
begin
  FstateStoring := Value;
end;

procedure TjdxTreeList.Set_syncLookupFilterValues(const Value: boolean);
begin
  FsyncLookupFilterValues := Value;
end;

procedure TjdxTreeList.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxTreeList.Set_toolbar(const Value: JSValue);
begin
  Ftoolbar := Value;
end;

procedure TjdxTreeList.Set_twoWayBindingEnabled(const Value: boolean);
begin
  FtwoWayBindingEnabled := Value;
end;

procedure TjdxTreeList.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxTreeList.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxTreeList.Set_wordWrapEnabled(const Value: boolean);
begin
  FwordWrapEnabled := Value;
end;

procedure TjdxTreeList.Set_onAdaptiveDetailRowPreparing(const Value: TdxEventHandler);
begin
  FonAdaptiveDetailRowPreparing := Value;
end;

procedure TjdxTreeList.Set_onCellClick(const Value: TdxEventHandler);
begin
  FonCellClick := Value;
end;

procedure TjdxTreeList.Set_onCellDblClick(const Value: TdxEventHandler);
begin
  FonCellDblClick := Value;
end;

procedure TjdxTreeList.Set_onCellHoverChanged(const Value: TdxEventHandler);
begin
  FonCellHoverChanged := Value;
end;

procedure TjdxTreeList.Set_onCellPrepared(const Value: TdxEventHandler);
begin
  FonCellPrepared := Value;
end;

procedure TjdxTreeList.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxTreeList.Set_onContextMenuPreparing(const Value: TdxEventHandler);
begin
  FonContextMenuPreparing := Value;
end;

procedure TjdxTreeList.Set_onDataErrorOccurred(const Value: TdxEventHandler);
begin
  FonDataErrorOccurred := Value;
end;

procedure TjdxTreeList.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxTreeList.Set_onEditCanceled(const Value: TdxEventHandler);
begin
  FonEditCanceled := Value;
end;

procedure TjdxTreeList.Set_onEditCanceling(const Value: TdxEventHandler);
begin
  FonEditCanceling := Value;
end;

procedure TjdxTreeList.Set_onEditingStart(const Value: TdxEventHandler);
begin
  FonEditingStart := Value;
end;

procedure TjdxTreeList.Set_onEditorPrepared(const Value: TdxEventHandler);
begin
  FonEditorPrepared := Value;
end;

procedure TjdxTreeList.Set_onEditorPreparing(const Value: TdxEventHandler);
begin
  FonEditorPreparing := Value;
end;

procedure TjdxTreeList.Set_onFocusedCellChanged(const Value: TdxEventHandler);
begin
  FonFocusedCellChanged := Value;
end;

procedure TjdxTreeList.Set_onFocusedCellChanging(const Value: TdxEventHandler);
begin
  FonFocusedCellChanging := Value;
end;

procedure TjdxTreeList.Set_onFocusedRowChanged(const Value: TdxEventHandler);
begin
  FonFocusedRowChanged := Value;
end;

procedure TjdxTreeList.Set_onFocusedRowChanging(const Value: TdxEventHandler);
begin
  FonFocusedRowChanging := Value;
end;

procedure TjdxTreeList.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxTreeList.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxTreeList.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxTreeList.Set_onInitNewRow(const Value: TdxEventHandler);
begin
  FonInitNewRow := Value;
end;

procedure TjdxTreeList.Set_onKeyDown(const Value: TdxEventHandler);
begin
  FonKeyDown := Value;
end;

procedure TjdxTreeList.Set_onNodesInitialized(const Value: TdxEventHandler);
begin
  FonNodesInitialized := Value;
end;

procedure TjdxTreeList.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxTreeList.Set_onRowClick(const Value: TdxEventHandler);
begin
  FonRowClick := Value;
end;

procedure TjdxTreeList.Set_onRowCollapsed(const Value: TdxEventHandler);
begin
  FonRowCollapsed := Value;
end;

procedure TjdxTreeList.Set_onRowCollapsing(const Value: TdxEventHandler);
begin
  FonRowCollapsing := Value;
end;

procedure TjdxTreeList.Set_onRowDblClick(const Value: TdxEventHandler);
begin
  FonRowDblClick := Value;
end;

procedure TjdxTreeList.Set_onRowExpanded(const Value: TdxEventHandler);
begin
  FonRowExpanded := Value;
end;

procedure TjdxTreeList.Set_onRowExpanding(const Value: TdxEventHandler);
begin
  FonRowExpanding := Value;
end;

procedure TjdxTreeList.Set_onRowInserted(const Value: TdxEventHandler);
begin
  FonRowInserted := Value;
end;

procedure TjdxTreeList.Set_onRowInserting(const Value: TdxEventHandler);
begin
  FonRowInserting := Value;
end;

procedure TjdxTreeList.Set_onRowPrepared(const Value: TdxEventHandler);
begin
  FonRowPrepared := Value;
end;

procedure TjdxTreeList.Set_onRowRemoved(const Value: TdxEventHandler);
begin
  FonRowRemoved := Value;
end;

procedure TjdxTreeList.Set_onRowRemoving(const Value: TdxEventHandler);
begin
  FonRowRemoving := Value;
end;

procedure TjdxTreeList.Set_onRowUpdated(const Value: TdxEventHandler);
begin
  FonRowUpdated := Value;
end;

procedure TjdxTreeList.Set_onRowUpdating(const Value: TdxEventHandler);
begin
  FonRowUpdating := Value;
end;

procedure TjdxTreeList.Set_onRowValidating(const Value: TdxEventHandler);
begin
  FonRowValidating := Value;
end;

procedure TjdxTreeList.Set_onSaved(const Value: TdxEventHandler);
begin
  FonSaved := Value;
end;

procedure TjdxTreeList.Set_onSaving(const Value: TdxEventHandler);
begin
  FonSaving := Value;
end;

procedure TjdxTreeList.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
end;

procedure TjdxTreeList.Set_onToolbarPreparing(const Value: TdxEventHandler);
begin
  FonToolbarPreparing := Value;
end;

end.
