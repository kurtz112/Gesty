unit DevExtreme.DataGrid.JS;

{$MODE objfpc}
{$MODESWITCH externalclass}

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
  TdxDataGrid = class external name 'dxDataGrid' (TJSObject)
  public
    procedure addColumn(columnOptions: JSValue);
    function addRow(): TJSPromise;
    procedure beginCustomLoading(messageText: string);
    procedure beginUpdate();
    function byKey(key: JSValue): TJSPromise;
    procedure cancelEditData();
    function cellValue(rowIndex: integer; visibleColumnIndex: integer): JSValue; overload;
    procedure cellValue(rowIndex: integer; visibleColumnIndex: integer; value: JSValue); overload;
    function cellValue(rowIndex: integer; dataField: string): JSValue; overload;
    procedure cellValue(rowIndex: integer; dataField: string; value: JSValue); overload;
    procedure clearFilter(); overload;
    procedure clearFilter(filterName: string); overload;
    procedure clearGrouping();
    procedure clearSelection();
    procedure clearSorting();
    procedure closeEditCell();
    procedure collapseAdaptiveDetailRow();
    procedure collapseAll(groupIndex: JSValue);
    function collapseRow(key: JSValue): TJSPromise;
    function columnCount(): integer;
    procedure columnOption(id: JSValue; optionName: string; optionValue: JSValue); overload;
    procedure columnOption(id: JSValue; options: TJSObject); overload;
    function columnOption(id: JSValue; optionName: string): JSValue; overload;
    function columnOption(id: JSValue): TJSObject; overload;
    procedure ctor(options: JSValue); overload;
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    procedure deleteColumn(id: JSValue);
    procedure deleteRow(rowIndex: integer);
    function deselectAll(): TJSPromise;
    function deselectRows(keys: TJSArray): TJSPromise;
    procedure dispose();
    procedure editCell(rowIndex: integer; visibleColumnIndex: integer); overload;
    procedure editCell(rowIndex: integer; dataField: string); overload;
    procedure editRow(rowIndex: integer);
    function element(): TJSElement;
    procedure endCustomLoading();
    procedure endUpdate();
    procedure expandAdaptiveDetailRow(key: JSValue);
    procedure expandAll(groupIndex: JSValue);
    function expandRow(key: JSValue): TJSPromise;
    procedure filter(filterExpr: JSValue); overload;
    function filter(): JSValue; overload;
    procedure focus(); overload;
    procedure focus(element: JSValue); overload;
    function getCellElement(rowIndex: integer; visibleColumnIndex: integer): JSValue; overload;
    function getCellElement(rowIndex: integer; dataField: string): JSValue; overload;
    function getCombinedFilter(): JSValue; overload;
    function getCombinedFilter(returnDataField: boolean): JSValue; overload;
    function getDataSource(): TJSObject;
    function getKeyByRowIndex(rowIndex: integer): JSValue;
    function getRowElement(rowIndex: integer): JSValue;
    function getRowIndexByKey(key: JSValue): integer;
    function getScrollable(): JSValue;
    function getSelectedRowKeys(): JSValue;
    function getSelectedRowsData(): JSValue;
    function getTotalSummaryValue(summaryItemName: string): JSValue;
    function getVisibleColumnIndex(id: JSValue): integer;
    function getVisibleColumns(headerLevel: integer): TJSArray; overload;
    function getVisibleColumns(): TJSArray; overload;
    function getVisibleRows(): TJSArray;
    function hasEditData(): boolean;
    procedure hideColumnChooser();
    function isAdaptiveDetailRowExpanded(key: JSValue): boolean;
    function isRowExpanded(key: JSValue): boolean;
    function isRowFocused(key: JSValue): boolean;
    procedure isRowSelected(); overload;
    function isRowSelected(data: JSValue): boolean; overload;
    function keyOf(obj: TJSObject): JSValue;
    function navigateToRow(key: JSValue): TJSPromise;
    function off(eventName: string): TJSElement; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function option(): TJSObject; overload;
    procedure option(options: TJSObject); overload;
    function option(optionName: string): JSValue; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    function pageCount(): integer;
    function pageIndex(newIndex: integer): TJSPromise; overload;
    function pageIndex(): integer; overload;
    procedure pageSize(value: integer); overload;
    function pageSize(): integer; overload;
    function refresh(changesOnly: boolean): TJSPromise; overload;
    function refresh(): TJSPromise; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); overload;
    procedure registerKeyHandler(); overload;
    procedure repaint();
    procedure repaintRows(rowIndexes: TJSArray);
    procedure resetOption(optionName: string);
    function saveEditData(): TJSPromise;
    procedure searchByText(text: string);
    function selectAll(): TJSPromise;
    function selectRows(keys: TJSArray; preserve: boolean): TJSPromise;
    function selectRowsByIndexes(indexes: TJSArray): TJSPromise;
    procedure showColumnChooser();
    function startSelectionWithCheckboxes(): boolean;
    procedure state(state: TJSObject); overload;
    function state(): TJSObject; overload;
    function stopSelectionWithCheckboxes(): boolean;
    function totalCount(): integer;
    procedure undeleteRow(rowIndex: integer);
    procedure updateDimensions();
  end;

implementation


end.
