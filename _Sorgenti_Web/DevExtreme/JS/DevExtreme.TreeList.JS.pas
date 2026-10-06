unit DevExtreme.TreeList.JS;

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
  TdxTreeList = class external name 'dxTreeList' (TJSObject)
  public
    procedure addColumn(columnOptions: JSValue);
    function addRow(parentId: JSValue): TJSPromise; overload;
    function addRow(): TJSPromise; overload;
    procedure beginCustomLoading(messageText: string);
    procedure beginUpdate();
    function byKey(key: JSValue): TJSPromise;
    procedure cancelEditData();
    function cellValue(rowIndex: integer; visibleColumnIndex: integer): JSValue; overload;
    procedure cellValue(rowIndex: integer; visibleColumnIndex: integer; value: JSValue); overload;
    function cellValue(rowIndex: integer; dataField: string): JSValue; overload;
    procedure cellValue(rowIndex: integer; dataField: string; value: JSValue); overload;
    procedure clearFilter(filterName: string); overload;
    procedure clearFilter(); overload;
    procedure clearSelection();
    procedure clearSorting();
    procedure closeEditCell();
    procedure collapseAdaptiveDetailRow();
    function collapseRow(key: JSValue): TJSPromise;
    function columnCount(): integer;
    procedure columnOption(id: JSValue; optionName: string; optionValue: JSValue); overload;
    procedure columnOption(id: JSValue; options: TJSObject); overload;
    function columnOption(id: JSValue): TJSObject; overload;
    function columnOption(id: JSValue; optionName: string): JSValue; overload;
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    procedure deleteColumn(id: JSValue);
    procedure deleteRow(rowIndex: integer);
    procedure deselectAll(); overload;
    function deselectRows(keys: TJSArray): TJSPromise;
    procedure dispose();
    procedure editCell(rowIndex: integer; dataField: string); overload;
    procedure editCell(rowIndex: integer; visibleColumnIndex: integer); overload;
    procedure editRow(rowIndex: integer);
    function element(): TJSElement;
    procedure endCustomLoading();
    procedure endUpdate();
    procedure expandAdaptiveDetailRow(); overload;
    procedure expandAdaptiveDetailRow(key: JSValue); overload;
    function expandRow(key: JSValue): TJSPromise;
    function filter(): JSValue; overload;
    procedure filter(filterExpr: JSValue); overload;
    procedure focus(); overload;
    procedure focus(element: JSValue); overload;
    procedure forEachNode(nodes: TJSArray; callback: TJSFunction); overload;
    procedure forEachNode(callback: TJSFunction); overload;
    function getCellElement(rowIndex: integer; visibleColumnIndex: integer): JSValue; overload;
    function getCellElement(rowIndex: integer; dataField: string): JSValue; overload;
    function getCombinedFilter(): JSValue; overload;
    function getCombinedFilter(returnDataField: boolean): JSValue; overload;
    function getDataSource(): TJSObject;
    function getKeyByRowIndex(rowIndex: integer): JSValue;
    function getNodeByKey(key: JSValue): JSValue;
    function getRootNode(): JSValue;
    function getRowElement(rowIndex: integer): JSValue;
    function getRowIndexByKey(key: JSValue): integer;
    function getScrollable(): JSValue;
    function getSelectedRowKeys(): TJSArray; overload;
    function getSelectedRowKeys(mode: string): TJSArray; overload;
    function getSelectedRowsData(): TJSArray; overload;
    function getSelectedRowsData(mode: string): TJSArray; overload;
    function getVisibleColumnIndex(id: JSValue): integer;
    function getVisibleColumns(headerLevel: integer): TJSArray; overload;
    function getVisibleColumns(): TJSArray; overload;
    function getVisibleRows(): TJSArray;
    function hasEditData(): boolean;
    procedure hideColumnChooser();
    function isAdaptiveDetailRowExpanded(key: JSValue): boolean; overload;
    procedure isAdaptiveDetailRowExpanded(); overload;
    function isRowExpanded(key: JSValue): boolean;
    function isRowFocused(key: JSValue): boolean;
    function isRowSelected(key: JSValue): boolean;
    function keyOf(obj: TJSObject): JSValue;
    function loadDescendants(keys: TJSArray; childrenOnly: boolean): TJSPromise; overload;
    function loadDescendants(): TJSPromise; overload;
    function loadDescendants(keys: TJSArray): TJSPromise; overload;
    procedure navigateToRow(); overload;
    function navigateToRow(key: JSValue): TJSPromise; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    procedure option(options: TJSObject); overload;
    function option(): TJSObject; overload;
    function option(optionName: string): JSValue; overload;
    procedure pageCount(); overload;
    function pageIndex(): integer; overload;
    function pageIndex(newIndex: integer): TJSPromise; overload;
    procedure pageSize(value: integer); overload;
    function pageSize(): integer; overload;
    function refresh(changesOnly: boolean): TJSPromise; overload;
    function refresh(): TJSPromise; overload;
    procedure registerKeyHandler(); overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); overload;
    procedure repaint();
    procedure repaintRows(rowIndexes: TJSArray);
    procedure resetOption(optionName: string);
    function saveEditData(): TJSPromise;
    procedure searchByText(text: string);
    procedure selectAll(); overload;
    function selectRows(keys: TJSArray; preserve: boolean): TJSPromise;
    function selectRowsByIndexes(indexes: TJSArray): TJSPromise;
    procedure showColumnChooser();
    function startSelectionWithCheckboxes(): boolean;
    function state(): TJSObject; overload;
    procedure state(state: TJSObject); overload;
    function stopSelectionWithCheckboxes(): boolean;
    procedure undeleteRow(rowIndex: integer);
    procedure updateDimensions();
  end;

implementation


end.
