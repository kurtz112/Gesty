unit DevExtreme;
{$MODE objfpc}
{$MODESWITCH externalclass}

interface

uses
  System.SysUtils,
  System.classes,
  JS,
  Web,
  libjquery,
  DevExtreme.types,
  DevExtreme.validation,
  DevExtreme.utils,
  DevExtreme.themes;

type

  // jqwidget

  // Prefissare come TDevExtreme
  // oppure suffisso JS

  /// //////////////////////////////////////////////////////////////////////////
  /// ArrayStore

  TdxArrayStore = class
    external name 'DevExpress.data.ArrayStore'(TJSObject)public

    function byKey(key: JSValue): TJSPromise;
    procedure clear;
    function createQuery(): TJSObject;
    function insert(values: TJSObject): TJSPromise;
    function key(key: JSValue): JSValue;
    function keyOf(obj: TJSObject): JSValue;
    function load(): TJSPromise;
    function load(options: TJSObject): TJSPromise;
    // function push(changes)Pushes data changes to the store and notifies the DataSource.
    function remove(key: JSValue): TJSPromise;
    function totalCount(options: TJSObject): TJSPromise;
    function update(key: JSValue; values: TJSObject): TJSPromise;
  end;

  TdxCustomStore = class
    external name 'DevExpress.data.CustomStore'(TJSObject)public
    function byKey(key: JSValue): TJSPromise;
    procedure clearRawDataCache();
    function insert(values: TJSObject): TJSPromise;
    function key(key: JSValue): JSValue;
    function keyOf(obj: TJSObject): JSValue;
    function load(): TJSPromise;
    function load(options: TJSObject): TJSPromise;
    // function push(changes)Pushes data changes to the store and notifies the DataSource.
    function remove(key: JSValue): TJSPromise;
    function totalCount(options: TJSObject): TJSPromise;
    function update(key: JSValue; values: TJSObject): TJSPromise;
  end;

  TdxDataSource = class
    external name 'DevExpress.data.DataSource'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
    function items: TJSArray;
    function load(): TJSPromise;
    function load(options: TJSObject): TJSPromise;
    function loadOptions: TJSObject;
    function store(): TdxCustomStore; // occhio!
    procedure reload;
    function totalCount(): integer;

    function pageIndex(): integer;
    procedure pageIndex(newIndex: integer);
  end;

  /// //////////////////////////////////////////////////////////////////////////

  TdxAccordion = class
    external name 'dxAccordion'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxActionSheet = class
    external name 'dxActionSheet'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxAutocomplete = class
    external name 'dxAutocomplete'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxBarGauge = class
    external name 'dxBarGauge'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxBox = class
    external name 'dxBox'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxBullet = class
    external name 'dxBullet'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxButton = class
    external name 'dxButton'(TJSObject)public
    function element(): TJSElement;
    procedure click();
    procedure focus();

    function option(): TJSObject; // Gets all widget options.
    function option(name: string): JSValue; // Gets the value of a single option.
    procedure option(name: string; optionValue: JSValue); // Updates the value of a single option.
    procedure option(options: TJSObject); // Updates the values of several options.

    procedure on(eventName: string; eventHandler: JSValue);
    procedure on(events: JSValue);
  end;

  TdxButtonGroup = class
    external name 'dxButtonGroup'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxCalendar = class
    external name 'dxCalendar'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxChart = class
    external name 'dxChart'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxCheckBox = class
    external name 'dxCheckBox'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxCircularGauge = class
    external name 'dxCircularGauge'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxColorBox = class
    external name 'dxColorBox'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxContextMenu = class
    external name 'dxContextMenu'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxDataGrid = class
    external name 'dxDataGrid'(TJSObject)public constructor new(options: TJSObject); //
    function addColumn(columnOptions: JSValue): boolean; // Adds a new column.
    function addRow: boolean; // Adds an empty data row.
    function beginCustomLoading(messageText: string): boolean; // Shows the load panel.
    function beginUpdate: boolean; // Prevents the widget from refreshing until the endUpdate() method is called.
    function byKey(key: JSValue): boolean; // Gets a data object with a specific key.
    function cancelEditData: boolean; // Discards changes that a user made to data.
    function cellValue(rowIndex: integer; dataField: string): boolean; overload; // Gets the value of a cell with a specific row index and a data field, column caption or name.
    function cellValue(rowIndex: integer; dataField: string; value: JSValue): boolean; overload; // Sets a new value to a cell with a specific row index and a data field, column caption or name.
    function cellValue(rowIndex: integer; visibleColumnIndex: integer): boolean; overload; // Gets the value of a cell with specific row and column indexes.
    function cellValue(rowIndex: integer; visibleColumnIndex: integer; value: JSValue): boolean; overload; // Sets a new value to a cell with specific row and column indexes.
    function clearFilter: boolean; overload; // Clears all filters applied to widget rows.
    function clearFilter(filterName: string): boolean; overload; // Clears all row filters of a specific type.
    function clearGrouping: boolean; // Ungroups grid records.
    function clearSelection: boolean; // Clears selection of all rows on all pages.
    function clearSorting: boolean; // Clears sorting settings of all columns at once.
    function closeEditCell: boolean; // Switches the cell being edited back to the normal state. Takes effect only if editing.mode is batch and showEditorAlways is false.
    function collapseAdaptiveDetailRow: boolean; // Collapses the currently expanded adaptive detail row (if there is one).
    function collapseAll(groupIndex: integer): boolean; // Collapses master rows or groups of a specific level.
    function collapseRow(key: JSValue): boolean; // Collapses a group or a master row with a specific key.
    function columnCount: integer; // Gets the data column count. Includes visible and hidden columns, excludes command columns.
    function columnOption(id: JSValue): boolean; overload; // Gets all options of a column with a specific identifier.
    function columnOption(id: JSValue; optionName: string): boolean; overload; // Gets the value of a single column option.
    function columnOption(id: JSValue; optionName: string; optionValue: JSValue): boolean; overload; // Updates the value of a single column option.
    function columnOption(id: JSValue; options: TJSObject): boolean; overload; // Updates the values of several column options.
    function defaultOptions(rule: TJSObject): boolean; // Specifies the device-dependent default configuration options for this component.
    function deleteColumn(id: JSValue): boolean; // Removes a column.
    function deleteRow(rowIndex: integer): boolean; // Removes a row with a specific index.
    function deselectAll: TJSPromise; // Clears the selection of all rows on all pages or the currently rendered page only.
    function deselectRows(keys: TJSArray): boolean; // Cancels the selection of rows with specific keys.
    function dispose: boolean; // Disposes of all the resources allocated to the DataGrid instance.
    function editCell(rowIndex: integer; dataField: string): boolean; overload;
    // Switches a cell with a specific row index and a data field to the editing state. Takes effect only if the editing mode is "batch" or "cell".
    function editCell(rowIndex: integer; visibleColumnIndex: integer): boolean; overload;
    // Switches a cell with specific row and column indexes to the editing state. Takes effect only if the editing mode is "batch" or "cell".
    function editRow(rowIndex: integer): boolean; // Switches a row with a specific index to the editing state. Takes effect only if the editing mode is "row", "popup" or "form".
    function element: TJSElement; // Gets the root widget element.
    function endCustomLoading: boolean; // Hides the load panel.
    function endUpdate: boolean; // Refreshes the widget after a call of the beginUpdate() method.
    function expandAdaptiveDetailRow(key: JSValue): boolean; // Expands an adaptive detail row.
    function expandAll(groupIndex: integer): boolean; // Expands master rows or groups of a specific level. Does not apply if data is remote.
    function expandRow(key: JSValue): boolean; // Expands a group or a master row with a specific key.
    function exportToExcel(selectionOnly: boolean): boolean; // Exports grid data to Excel.
    function filter: boolean; overload; // Gets a filter expression applied to the widget's data source using the filter(filterExpr) method and the DataSource's filter option.
    function filter(filterExpr: JSValue): boolean; overload; // Applies a filter to the widget's data source.
    function focus: boolean; overload; // Sets focus on the widget.
    function focus(element: JSValue): boolean; overload; // Sets focus on a specific cell.
    function getCellElement(rowIndex: integer; dataField: string): boolean; overload; // Gets a cell with a specific row index and a data field, column caption or name.
    function getCellElement(rowIndex: integer; visibleColumnIndex: integer): boolean; overload; // Gets a cell with specific row and column indexes.
    function getCombinedFilter: boolean; overload; // Gets the total filter that combines all the filters applied.
    function getCombinedFilter(returnDataField: boolean): boolean; overload; // Gets the total filter that combines all the filters applied.
    function getDataSource: TdxDataSource; // Gets the DataSource instance.
    function getInstance(element: JSValue): boolean; // Gets the instance of a widget found using its DOM node.
    function getKeyByRowIndex(rowIndex: integer): boolean; // Gets the key of a row with a specific index.
    function getRowElement(rowIndex: integer): boolean; // Gets the container of a row with a specific index.
    function getRowIndexByKey(key: JSValue): boolean; // Gets the index of a row with a specific key.
    function getScrollable: TJSObject; // Gets the instance of the widget's scrollable part.
    function getSelectedRowKeys: TJSArray; // Gets the currently selected rows' keys.
    function getSelectedRowsData: TJSArray; // Gets the selected rows' data objects.
    function getTotalSummaryValue(summaryItemName: string): boolean; // Gets the value of a total summary item.
    function getVisibleColumns: TJSArray; overload; // Gets all visible columns.
    function getVisibleColumns(headerLevel: integer): boolean; overload; // Gets all visible columns at a specific hierarchical level of column headers. Use it to access banded columns.
    function getVisibleRows: TJSArray; // Gets currently rendered rows.
    function hasEditData: boolean; // Checks whether the widget has unsaved changes.
    function hideColumnChooser: boolean; // Hides the column chooser.
    function insertRow: boolean; // Use the addRow() method instead.
    function instance: TdxDataGrid; // Gets the widget's instance. Use it to access other methods of the widget.
    function isAdaptiveDetailRowExpanded(key: JSValue): boolean; // Checks whether an adaptive detail row is expanded or collapsed.
    function isRowExpanded(key: JSValue): boolean; // Checks whether a specific group or master row is expanded or collapsed.
    function isRowFocused(key: JSValue): boolean; // Checks whether a row with a specific key is focused.
    function isRowSelected(data: JSValue): boolean; overload; // Checks whether a row found using its data object is selected. Takes effect only if selection.deferred is true.
    // function isRowSelected(key: JSValue): boolean; overload; // Checks whether a row with a specific key is selected. Takes effect only if selection.deferred is false.
    function keyOf(obj: TJSObject): boolean; // Gets a data object's key.
    function navigateToRow(key: JSValue): boolean; // Scrolls the grid to the row with the specified key.
    function off(eventName: string): boolean; overload; // Detaches all event handlers from a single event.
    function off(eventName: string; eventHandler: TdxEventHandler): boolean; overload; // Detaches a particular event handler from a single event.
    function on(eventName: string; eventHandler: TdxEventHandler): boolean; overload; // Subscribes to an event.
    function on(events: TJSObject): boolean; overload; // Subscribes to events.
    function option(): TJSObject; // Gets all widget options.
    function option(name: string): JSValue; // Gets the value of a single option.
    procedure option(name: string; optionValue: JSValue); // Updates the value of a single option.
    procedure option(options: TJSObject); // Updates the values of several options.
    function pageCount: integer; // Gets the total page count.
    function pageIndex: integer; overload; // Gets the current page index.
    function pageIndex(newIndex: integer): boolean; overload; // Switches the widget to a specific page using a zero-based index.
    function pageSize: integer; overload; // Gets the current page size.
    function pageSize(value: integer): boolean; overload; // Sets the page size.
    function refresh: TJSPromise; overload; // Reloads data and repaints the widget.
    function refresh(changesOnly: boolean): boolean; overload; // Reloads data and repaints the widget or elements whose data changed.
    function removeRow(rowIndex: integer): boolean; // Use the deleteRow(rowIndex) method instead.
    function repaint: boolean; // Repaints the widget without reloading data. Call it to update the widget's markup.
    function repaintRows(rowIndexes: TJSArray): boolean; // Repaints specific rows.
    function saveEditData: TJSPromise; // Saves changes that a user made to data.
    function searchByText(text: string): boolean; // Seeks a search string in the columns whose allowSearch option is true.
    function selectAll: TJSPromise; // Selects all rows.
    function selectRows(keys: TJSArray; preserve: boolean): boolean; // Selects rows with specific keys.
    function selectRowsByIndexes(indexes: TJSArray): boolean; // Selects rows with specific indexes.
    function showColumnChooser: boolean; // Shows the column chooser.
    function state: TJSObject; overload; // Gets the current widget state.
    function state(state: TJSObject): boolean; overload; // Sets the widget state.
    function totalCount: integer; // Gets the total row count.
    function undeleteRow(rowIndex: integer): boolean; // Recovers a row deleted in batch editing mode.
    function updateDimensions: boolean; // Updates the widget's content after resizing.
  end;

  TdxDateBox = class
    external name 'dxDateBox'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxDiagram = class
    external name 'dxDiagram'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxDrawer = class
    external name 'dxDrawer'(TJSObject)public
    function beginUpdate: boolean; // Prevents the widget from refreshing until the endUpdate() method is called.
    function content: TJSElement; // Gets the drawer's content.
    function defaultOptions(rule: TJSObject): boolean; // Specifies the device-dependent default configuration options for this component.
    function dispose: boolean; // Disposes of all the resources allocated to the Drawer instance.
    function _element: TJSElement; // Gets the root widget element.
    function endUpdate: boolean; // Refreshes the widget after a call of the beginUpdate() method.
    function getInstance(element: JSValue): boolean; // Gets the instance of a widget found using its DOM node.
    function hide: TJSPromise; // Closes the drawer.
    function instance: TdxDrawer; // Gets the widget's instance. Use it to access other methods of the widget.
    function off(eventName: string): boolean; overload; // Detaches all event handlers from a single event.
    function off(eventName: string; eventHandler: TdxEventHandler): boolean; overload; // Detaches a particular event handler from a single event.
    function on(eventName: string; eventHandler: TdxEventHandler): boolean; overload; // Subscribes to an event.
    function on(events: TJSObject): boolean; overload; // Subscribes to events.
    function option: TJSObject; overload; // Gets all widget options.
    function option(optionName: string): boolean; overload; // Gets the value of a single option.
    function option(optionName: string; optionValue: JSValue): boolean; overload; // Updates the value of a single option.
    function option(options: TJSObject): boolean; overload; // Updates the values of several options.
    function repaint: boolean; // Repaints the widget without reloading data. Call it to update the widget's markup.
    function show: TJSPromise; // Opens the drawer.
    function toggle: TJSPromise; // Opens or closes the drawer, reversing the current state.
  end;

  TdxDropDownBox = class
    external name 'dxDropDownBox'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxDropDownButton = class
    external name 'dxDropDownButton'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxFileManager = class
    external name 'dxFileManager'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxFileUploader = class
    external name 'dxFileUploader'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxFilterBuilder = class
    external name 'dxFilterBuilder'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxSpeedDialAction = class
    external name 'dxSpeedDialAction'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxForm = class
    external name 'dxForm'(TJSObject)public
    function beginUpdate: boolean; // Prevents the widget from refreshing until the endUpdate() method is called.
    function defaultOptions(rule: TJSObject): boolean; // Specifies the device-dependent default configuration options for this component.
    function dispose: boolean; // Disposes of all the resources allocated to the Form instance.
    function element: TJSElement; // Gets the root widget element.
    function endUpdate: boolean; // Refreshes the widget after a call of the beginUpdate() method.
    function focus: boolean; // Sets focus on the widget.
    function getButton(name: string): TdxButton; // Gets a button's instance.
    function getEditor(dataField: string): TJSObject; // Gets an editor instance. Takes effect only if the form item is visible.
    function getInstance(element: JSValue): boolean; // Gets the instance of a widget found using its DOM node.
    function instance: TdxForm; // Gets the widget's instance. Use it to access other methods of the widget.

    function itemOption(dataField: string): TJSObject; // Gets a form item's configuration.
    function itemOption(dataField: string; const option: string): JSValue; // Updates the value of a single item option.
    procedure itemOption(dataField: string; const option: string; value: JSValue); // Updates the values of several item options.

    function off(eventName: string): JSValue; overload; // Detaches all event handlers from a single event.
    function off(eventName: string; eventHandler: TdxEventHandler): JSValue; overload; // Detaches a particular event handler from a single event.
    function on(eventName: string; eventHandler: TdxEventHandler): JSValue; overload; // Subscribes to an event.
    // function on(events: TJSObject): JSValue; overload; // Subscribes to events.

    function option(): TJSObject; // Gets all widget options.
    function option(name: string): JSValue; // Gets the value of a single option.
    procedure option(name: string; optionValue: JSValue); // Updates the value of a single option.
    procedure option(options: TJSObject); // Updates the values of several options.

    function registerKeyHandler(key: string; handler: TdxEventHandler): boolean; // Registers a handler to be executed when a user presses a specific key.
    procedure repaint; // Repaints the widget without reloading data. Call it to update the widget's markup.
    procedure resetValues; // Resets the editor's value to undefined.
    procedure updateData(data: JSValue); // Updates formData fields and the corresponding editors.
    procedure updateData(dataField: string; value: JSValue); // Updates a formData field and the corresponding editor.
    function updateDimensions: TJSPromise; // Updates the dimensions of the widget contents.
    function validate: JSValue; // Validates the values of all editors on the form against the list of the validation rules specified for each form item.
  end;

  TdxFunnel = class
    external name 'dxFunnel'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxGallery = class
    external name 'dxGallery'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxGantt = class
    external name 'dxGantt'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxHtmlEditor = class
    external name 'dxHtmlEditor'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxLinearGauge = class
    external name 'dxLinearGauge'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxList = class
    external name 'dxList'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
    function element: JSValue;
  end;

  TdxLoadIndicator = class
    external name 'dxLoadIndicator'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxLoadPanel = class
    external name 'dxLoadPanel'(TJSObject)public
    function beginUpdate: boolean; // Prevents the widget from refreshing until the endUpdate() method is called.
    function content: TJSElement; // Gets the widget's content.
    function defaultOptions(rule: TJSObject): boolean; // Specifies the device-dependent default configuration options for this component.
    function dispose: boolean; // Disposes of all the resources allocated to the LoadPanel instance.
    function element: TJSElement; // Gets the root widget element.
    function endUpdate: boolean; // Refreshes the widget after a call of the beginUpdate() method.
    function getInstance(element: JSValue): boolean; // Gets the instance of a widget found using its DOM node.
    function hide: TJSPromise; // Hides the widget.
    function instance: TdxLoadPanel; // Gets the widget's instance. Use it to access other methods of the widget.
    function off(eventName: string): boolean; overload; // Detaches all event handlers from a single event.
    function off(eventName: string; eventHandler: TdxEventHandler): boolean; overload; // Detaches a particular event handler from a single event.
    function on(eventName: string; eventHandler: TdxEventHandler): boolean; overload; // Subscribes to an event.
    function on(events: TJSObject): boolean; overload; // Subscribes to events.
    function option: TJSObject; overload; // Gets all widget options.
    function option(optionName: string): boolean; overload; // Gets the value of a single option.
    function option(optionName: string; optionValue: JSValue): boolean; overload; // Updates the value of a single option.
    function option(options: TJSObject): boolean; overload; // Updates the values of several options.
    function repaint: boolean; // Recalculates the widget's size and position without rerendering.
    function show: TJSPromise; // Shows the widget.
    function toggle(showing: boolean): boolean; // Shows or hides the widget depending on the argument.
  end;

  TdxLookup = class
    external name 'dxLookup'(TJSObject)public
    function option(): TJSObject;
    function option(name: string): JSValue;
    procedure option(name: string; optionValue: JSValue);
    procedure option(options: TJSObject);
  end;

  TdxMap = class
    external name 'dxMap'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxMenu = class
    external name 'dxMenu'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxMultiView = class
    external name 'dxMultiView'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxNumberBox = class
    external name 'dxNumberBox'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxPieChart = class
    external name 'dxPieChart'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxPivotGrid = class
    external name 'dxPivotGrid'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxPolarChart = class
    external name 'dxPolarChart'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxPopover = class
    external name 'dxPopover'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxPopup = class
    external name 'dxPopup'(TJSObject)public
    procedure beginUpdate();
    function content(): JSValue;
    procedure defaultOptions(rule: JSValue);
    function element(): JSValue;
    procedure endUpdate();
    procedure dispose;
    procedure focus();
    function getInstance(element: JSValue): TJSObject;
    procedure hide();
    function instance(): JSValue;
    procedure off(eventName: string);
    procedure off(eventName: string; eventHandler: JSValue);
    procedure on(eventName: string; eventHandler: JSValue);
    procedure on(events: JSValue);
    function option(): TJSObject;
    function option(name: string): JSValue;
    procedure option(name: string; optionValue: JSValue);
    procedure option(options: TJSObject);
    procedure registerKeyHandler(key: string; handler: JSValue);
    procedure repaint();
    procedure resetOption(optionName: string);
    procedure show();
    function toggle(showing: boolean): JSValue;
  end;

  TdxProgressBar = class
    external name 'dxProgressBar'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxRadioGroup = class
    external name 'dxRadioGroup'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxRangeSelector = class
    external name 'dxRangeSelector'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxRangeSlider = class
    external name 'dxRangeSlider'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxResizable = class
    external name 'dxResizable'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxResponsiveBox = class
    external name 'dxResponsiveBox'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxSankey = class
    external name 'dxSankey'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxScheduler = class
    external name 'dxScheduler'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
    function getStartViewDate(): TJSDate;
    function getEndViewDate(): TJSDate;
    function getDataSource(): TdxDataSource;
  end;

  TdxScrollView = class
    external name 'dxScrollView'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxSelectBox = class
    external name 'dxSelectBox'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxSlider = class
    external name 'dxSlider'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxSparkline = class
    external name 'dxSparkline'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxSwitch = class
    external name 'dxSwitch'(TJSObject)public
    function option(): TJSObject; // Gets all widget options.
    function option(name: string): JSValue; // Gets the value of a single option.
    procedure option(name: string; optionValue: JSValue); // Updates the value of a single option.
    procedure option(options: TJSObject); // Updates the values of several options.
  end;

  TdxTabPanel = class
    external name 'dxTabPanel'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxTabs = class
    external name 'dxTabs'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxTagBox = class
    external name 'dxTagBox'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxTextArea = class
    external name 'dxTextArea'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxTextBox = class
    external name 'dxTextBox'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxTileView = class
    external name 'dxTileView'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxToast = class
    external name 'dxToast'(TJSObject)public
    function beginUpdate: boolean; // Prevents the widget from refreshing until the endUpdate() method is called.
    function content: TJSElement; // Gets the widget's content.
    function defaultOptions(rule: TJSObject): boolean; // Specifies the device-dependent default configuration options for this component.
    function dispose: boolean; // Disposes of all the resources allocated to the Toast instance.
    function element: TJSElement; // Gets the root widget element.
    function endUpdate: boolean; // Refreshes the widget after a call of the beginUpdate() method.
    function focus: boolean; // Sets focus on the widget.
    function getInstance(element: JSValue): boolean; // Gets the instance of a widget found using its DOM node.
    function hide: TJSPromise; // Hides the widget.
    function instance: TdxToast; // Gets the widget's instance. Use it to access other methods of the widget.
    function off(eventName: string): boolean; overload; // Detaches all event handlers from a single event.
    function off(eventName: string; eventHandler: TdxEventHandler): boolean; overload; // Detaches a particular event handler from a single event.
    function on(eventName: string; eventHandler: TdxEventHandler): boolean; overload; // Subscribes to an event.
    function on(events: TJSObject): boolean; overload; // Subscribes to events.
    function option: TJSObject; overload; // Gets all widget options.
    function option(optionName: string): boolean; overload; // Gets the value of a single option.
    function option(optionName: string; optionValue: JSValue): boolean; overload; // Updates the value of a single option.
    function option(options: TJSObject): boolean; overload; // Updates the values of several options.
    function registerKeyHandler(key: string; handler: TdxEventHandler): boolean; // Registers a handler to be executed when a user presses a specific key.
    function repaint: boolean; // Recalculates the widget's size and position without rerendering.
    function show: TJSPromise; // Shows the widget.
    function toggle(showing: boolean): boolean; // Shows or hides the widget depending on the argument.
  end;

  TdxToolbar = class
    external name 'dxToolbar'(TJSObject)public
    function beginUpdate: boolean; // Prevents the widget from refreshing until the endUpdate() method is called.
    function defaultOptions(rule: TJSObject): boolean; // Specifies the device-dependent default configuration options for this component.
    function dispose: boolean; // Disposes of all the resources allocated to the Toolbar instance.
    function element: TJSElement; // Gets the root widget element.
    function endUpdate: boolean; // Refreshes the widget after a call of the beginUpdate() method.
    function getDataSource: TJSObject; // Gets the DataSource instance.
    function getInstance(element: JSValue): boolean; // Gets the instance of a widget found using its DOM node.
    function instance: TdxToolbar; // Gets the widget's instance. Use it to access other methods of the widget.
    function off(eventName: string): boolean; overload; // Detaches all event handlers from a single event.
    function off(eventName: string; eventHandler: TdxEventHandler): boolean; overload; // Detaches a particular event handler from a single event.
    function on(eventName: string; eventHandler: TdxEventHandler): boolean; overload; // Subscribes to an event.
    function on(events: TJSObject): boolean; overload; // Subscribes to events.
    function option: TJSObject; overload; // Gets all widget options.
    function option(optionName: string): JSValue; overload; // Gets the value of a single option.
    function option(optionName: string; optionValue: JSValue): JSValue; overload; // Updates the value of a single option.
    function option(options: TJSObject): JSValue; overload; // Updates the values of several options.
    function repaint: boolean; // Repaints the widget without reloading data. Call it to update the widget's markup.
  end;

  TdxTooltip = class
    external name 'dxTooltip'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxTreeList = class
    external name 'dxTreeList'(TJSObject)public

    function getVisibleRows(): TJSArray;

    function option(): TJSObject; // Gets all widget options.
    function option(name: string): JSValue; // Gets the value of a single option.
    procedure option(name: string; optionValue: JSValue); // Updates the value of a single option.
    procedure option(options: TJSObject); // Updates the values of several options.

    function getSelectedRowKeys: TJSArray; overload;
    function getSelectedRowKeys(mode: string): TJSArray; overload;

    function getSelectedRowsData: TJSArray; overload;
    function getSelectedRowsData(mode: string): TJSArray; overload;

    function addRow: TJSPromise; overload;
    function addRow(parentId: JSValue): TJSPromise; overload;

    procedure navigateToRow(key: JSValue);

    procedure selectAll;
    procedure deselectAll;

    procedure refresh;
  end;

  TdxTreeView = class
    external name 'dxTreeView'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  TdxVectorMap = class
    external name 'dxVectorMap'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
  end;

  /// //////////////////////////////////////////////////////////////////////

  TdxFactory = class(TComponent) // non compila come record, probabilmente causato da MODE objfpc
  public
    class function Accordion(const id: string; options: TJSObject): TdxAccordion; assembler; static;
    class function ActionSheet(const id: string; options: TJSObject): TdxActionSheet; assembler; static;
    class function Autocomplete(const id: string; options: TJSObject): TdxAutocomplete; assembler; static;
    class function BarGauge(const id: string; options: TJSObject): TdxBarGauge; assembler; static;
    class function Box(const id: string; options: TJSObject): TdxBox; assembler; static;
    class function Bullet(const id: string; options: TJSObject): TdxBullet; assembler; static;

    class function Button(const id: string; options: TJSObject): TdxButton; assembler; overload; static;
    class function Button(const id, name: string; btnText: string; btnType: TdxButtonType; btnStyle: TdxButtonStylingMode; HorizontalAlignment: TdxHorizontalAlignment; onClick: TdxEventHandler)
      : TdxButton; overload; static;

    class function ButtonGroup(const id: string; options: TJSObject): TdxButtonGroup; assembler; static;
    class function Calendar(const id: string; options: TJSObject): TdxCalendar; assembler; static;
    class function Chart(const id: string; options: TJSObject): TdxChart; assembler; static;
    class function CheckBox(const id: string; options: TJSObject): TdxCheckBox; assembler; static;
    class function CircularGauge(const id: string; options: TJSObject): TdxCircularGauge; assembler; static;
    class function ColorBox(const id: string; options: TJSObject): TdxColorBox; assembler; static;
    class function ContextMenu(const id: string; options: TJSObject): TdxContextMenu; assembler; static;

    class function DataGrid(const id: string; options: TJSObject): TdxDataGrid; overload; assembler; static;
    class function DateBox(const id: string; options: TJSObject): TdxDateBox; assembler; static;
    class function Diagram(const id: string; options: TJSObject): TdxDiagram; assembler; static;
    class function Drawer(const id: string; options: TJSObject): TdxDrawer; assembler; static;
    class function DropDownBox(const id: string; options: TJSObject): TdxDropDownBox; assembler; static;
    class function DropDownButton(const id: string; options: TJSObject): TdxDropDownButton; assembler; static;
    class function FileManager(const id: string; options: TJSObject): TdxFileManager; assembler; static;
    class function FileUploader(const id: string; options: TJSObject): TdxFileUploader; assembler; static;
    class function FilterBuilder(const id: string; options: TJSObject): TdxFilterBuilder; assembler; static;
    class function SpeedDialAction(const id: string; options: TJSObject): TdxSpeedDialAction; assembler; static;

    class function Form(const id: string; options: TJSObject): TdxForm; overload; assembler; static;
    class function Funnel(const id: string; options: TJSObject): TdxFunnel; assembler; static;
    class function Gallery(const id: string; options: TJSObject): TdxGallery; assembler; static;
    class function Gantt(const id: string; options: TJSObject): TdxGantt; assembler; static;
    class function HtmlEditor(const id: string; options: TJSObject): TdxHtmlEditor; assembler; static;
    class function LinearGauge(const id: string; options: TJSObject): TdxLinearGauge; assembler; static;
    class function List(const id: string; options: TJSObject): TdxList; assembler; static;
    class function LoadIndicator(const id: string; options: TJSObject): TdxLoadIndicator; assembler; static;
    class function LoadPanel(const id: string; options: TJSObject): TdxLoadPanel; assembler; static;
    class function Lookup(const id: string; options: TJSObject): TdxLookup; assembler; static;
    class function Map(const id: string; options: TJSObject): TdxMap; assembler; static;
    class function Menu(const id: string; options: TJSObject): TdxMenu; assembler; static;
    class function MultiView(const id: string; options: TJSObject): TdxMultiView; assembler; static;
    class function NumberBox(const id: string; options: TJSObject): TdxNumberBox; assembler; static;
    class function PieChart(const id: string; options: TJSObject): TdxPieChart; assembler; static;
    class function PivotGrid(const id: string; options: TJSObject): TdxPivotGrid; assembler; static;
    class function PolarChart(const id: string; options: TJSObject): TdxPolarChart; assembler; static;
    class function Popover(const id: string; options: TJSObject): TdxPopover; assembler; static;
    class function Popup(const id: string; options: TJSObject): TdxPopup; assembler; static;
    class function ProgressBar(const id: string; options: TJSObject): TdxProgressBar; assembler; static;
    class function RadioGroup(const id: string; options: TJSObject): TdxRadioGroup; assembler; static;
    class function RangeSelector(const id: string; options: TJSObject): TdxRangeSelector; assembler; static;
    class function RangeSlider(const id: string; options: TJSObject): TdxRangeSlider; assembler; static;
    class function Resizable(const id: string; options: TJSObject): TdxResizable; assembler; static;
    class function ResponsiveBox(const id: string; options: TJSObject): TdxResponsiveBox; assembler; static;
    class function Sankey(const id: string; options: TJSObject): TdxSankey; assembler; static;
    class function Scheduler(const id: string; options: TJSObject): TdxScheduler; assembler; static;
    class function ScrollView(const id: string; options: TJSObject): TdxScrollView; assembler; static;
    class function SelectBox(const id: string; options: TJSObject): TdxSelectBox; assembler; static;
    class function Slider(const id: string; options: TJSObject): TdxSlider; assembler; static;
    class function Sparkline(const id: string; options: TJSObject): TdxSparkline; assembler; static;
    class function Switch(const id: string; options: TJSObject): TdxSwitch; assembler; static;
    class function TabPanel(const id: string; options: TJSObject): TdxTabPanel; assembler; static;
    class function Tabs(const id: string; options: TJSObject): TdxTabs; assembler; static;
    class function TagBox(const id: string; options: TJSObject): TdxTagBox; assembler; static;
    class function TextArea(const id: string; options: TJSObject): TdxTextArea; assembler; static;
    class function TextBox(const id: string; options: TJSObject): TdxTextBox; assembler; static;
    class function TileView(const id: string; options: TJSObject): TdxTileView; assembler; static;
    class function Toast(const id: string; options: TJSObject): TdxToast; assembler; static;
    class function Toolbar(const id: string; options: TJSObject): TdxToolbar; assembler; static;
    class function Tooltip(const id: string; options: TJSObject): TdxTooltip; assembler; static;
    class function TreeList(const id: string; options: TJSObject): TdxTreeList; assembler; static;
    class function TreeView(const id: string; options: TJSObject): TdxTreeView; assembler; static;
    class function VectorMap(const id: string; options: TJSObject): TdxVectorMap; assembler; static;
  end;

  TDX = class(TComponent)
  private
    ffactory: TdxFactory;
    Futils: TdxUtils;
    fthemes: TdxThemes;
    Fvalidation: TdxValidation;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  public
    property factory: TdxFactory read ffactory;
    property themes: TdxThemes read fthemes;
    property utils: TdxUtils read Futils;
    property validation: TdxValidation read Fvalidation;
  end;

var
  dx: TDX;

implementation

uses
  WEBLib.Forms,
  DevExtreme.DataGrid,
  DevExtreme.Form;

class function TdxFactory.Accordion(const id: string; options: TJSObject): TdxAccordion; assembler;
asm
  return $(id).dxAccordion(options).dxAccordion("instance");
end;

class function TdxFactory.ActionSheet(const id: string; options: TJSObject): TdxActionSheet; assembler;
asm
  return $(id).dxActionSheet(options).dxActionSheet("instance");
end;

class function TdxFactory.Autocomplete(const id: string; options: TJSObject): TdxAutocomplete; assembler;
asm
  return $(id).dxAutocomplete(options).dxAutocomplete("instance");
end;

class function TdxFactory.BarGauge(const id: string; options: TJSObject): TdxBarGauge; assembler;
asm
  return $(id).dxBarGauge(options).dxBarGauge("instance");
end;

class function TdxFactory.Box(const id: string; options: TJSObject): TdxBox; assembler;
asm
  return $(id).dxBox(options).dxBox("instance");
end;

class function TdxFactory.Bullet(const id: string; options: TJSObject): TdxBullet; assembler;
asm
  return $(id).dxBullet(options).dxBullet("instance");
end;

class function TdxFactory.Button(const id: string; options: TJSObject): TdxButton; assembler;
asm
  return $(id).dxButton(options || {}).dxButton("instance");
end;

class function TdxFactory.Button(const id, name: string; btnText: string; btnType: TdxButtonType; btnStyle: TdxButtonStylingMode; HorizontalAlignment: TdxHorizontalAlignment; onClick: TdxEventHandler)
  : TdxButton;
var
  options: TJSObject;
begin
  options := TdxFormUtils.Button(name, btnText, '', btnType, btnStyle, HorizontalAlignment, onClick);
  result := TdxFactory.Button(id, options);
end;

class function TdxFactory.ButtonGroup(const id: string; options: TJSObject): TdxButtonGroup; assembler;
asm
  return $(id).dxButtonGroup(options).dxButtonGroup("instance");
end;

class function TdxFactory.Calendar(const id: string; options: TJSObject): TdxCalendar; assembler;
asm
  return $(id).dxCalendar(options).dxCalendar("instance");
end;

class function TdxFactory.Chart(const id: string; options: TJSObject): TdxChart; assembler;
asm
  return $(id).dxChart(options).dxChart("instance");
end;

class function TdxFactory.CheckBox(const id: string; options: TJSObject): TdxCheckBox; assembler;
asm
  return $(id).dxCheckBox(options).dxCheckBox("instance");
end;

class function TdxFactory.CircularGauge(const id: string; options: TJSObject): TdxCircularGauge; assembler;
asm
  return $(id).dxCircularGauge(options).dxCircularGauge("instance");
end;

class function TdxFactory.ColorBox(const id: string; options: TJSObject): TdxColorBox; assembler;
asm
  return $(id).dxColorBox(options).dxColorBox("instance");
end;

class function TdxFactory.ContextMenu(const id: string; options: TJSObject): TdxContextMenu; assembler;
asm
  return $(id).dxContextMenu(options).dxContextMenu("instance");
end;

class function TdxFactory.DataGrid(const id: string; options: TJSObject): TdxDataGrid; assembler;
asm
  return $(id).dxDataGrid(options || {}).dxDataGrid("instance");
end;

class function TdxFactory.DateBox(const id: string; options: TJSObject): TdxDateBox; assembler;
asm
  return $(id).dxDateBox(options).dxDateBox("instance");
end;

class function TdxFactory.Diagram(const id: string; options: TJSObject): TdxDiagram; assembler;
asm
  return $(id).dxDiagram(options).dxDiagram("instance");
end;

class function TdxFactory.Drawer(const id: string; options: TJSObject): TdxDrawer; assembler;
asm
  return $(id).dxDrawer(options).dxDrawer("instance");
end;

class function TdxFactory.DropDownBox(const id: string; options: TJSObject): TdxDropDownBox; assembler;
asm
  return $(id).dxDropDownBox(options).dxDropDownBox("instance");
end;

class function TdxFactory.DropDownButton(const id: string; options: TJSObject): TdxDropDownButton; assembler;
asm
  return $(id).dxDropDownButton(options).dxDropDownButton("instance");
end;

class function TdxFactory.FileManager(const id: string; options: TJSObject): TdxFileManager; assembler;
asm
  return $(id).dxFileManager(options).dxFileManager("instance");
end;

class function TdxFactory.FileUploader(const id: string; options: TJSObject): TdxFileUploader; assembler;
asm
  return $(id).dxFileUploader(options).dxFileUploader("instance");
end;

class function TdxFactory.FilterBuilder(const id: string; options: TJSObject): TdxFilterBuilder; assembler;
asm
  return $(id).dxFilterBuilder(options).dxFilterBuilder("instance");
end;

class function TdxFactory.SpeedDialAction(const id: string; options: TJSObject): TdxSpeedDialAction; assembler;
asm
  return $(id).dxSpeedDialAction(options).dxSpeedDialAction("instance");
end;

class function TdxFactory.Form(const id: string; options: TJSObject): TdxForm; assembler;
asm
  return $(id).dxForm(options).dxForm("instance");
end;

class function TdxFactory.Funnel(const id: string; options: TJSObject): TdxFunnel; assembler;
asm
  return $(id).dxFunnel(options).dxFunnel("instance");
end;

class function TdxFactory.Gallery(const id: string; options: TJSObject): TdxGallery; assembler;
asm
  return $(id).dxGallery(options).dxGallery("instance");
end;

class function TdxFactory.Gantt(const id: string; options: TJSObject): TdxGantt; assembler;
asm
  return $(id).dxGantt(options).dxGantt("instance");
end;

class function TdxFactory.HtmlEditor(const id: string; options: TJSObject): TdxHtmlEditor; assembler;
asm
  return $(id).dxHtmlEditor(options).dxHtmlEditor("instance");
end;

class function TdxFactory.LinearGauge(const id: string; options: TJSObject): TdxLinearGauge; assembler;
asm
  return $(id).dxLinearGauge(options).dxLinearGauge("instance");
end;

class function TdxFactory.List(const id: string; options: TJSObject): TdxList; assembler;
asm
  return $(id).dxList(options).dxList("instance");
end;

class function TdxFactory.LoadIndicator(const id: string; options: TJSObject): TdxLoadIndicator; assembler;
asm
  return $(id).dxLoadIndicator(options).dxLoadIndicator("instance");
end;

class function TdxFactory.LoadPanel(const id: string; options: TJSObject): TdxLoadPanel; assembler;
asm
  return $(id).dxLoadPanel(options).dxLoadPanel("instance");
end;

class function TdxFactory.Lookup(const id: string; options: TJSObject): TdxLookup; assembler;
asm
  return $(id).dxLookup(options).dxLookup("instance");
end;

class function TdxFactory.Map(const id: string; options: TJSObject): TdxMap; assembler;
asm
  return $(id).dxMap(options).dxMap("instance");
end;

class function TdxFactory.Menu(const id: string; options: TJSObject): TdxMenu; assembler;
asm
  return $(id).dxMenu(options).dxMenu("instance");
end;

class function TdxFactory.MultiView(const id: string; options: TJSObject): TdxMultiView; assembler;
asm
  return $(id).dxMultiView(options).dxMultiView("instance");
end;

class function TdxFactory.NumberBox(const id: string; options: TJSObject): TdxNumberBox; assembler;
asm
  return $(id).dxNumberBox(options).dxNumberBox("instance");
end;

class function TdxFactory.PieChart(const id: string; options: TJSObject): TdxPieChart; assembler;
asm
  return $(id).dxPieChart(options).dxPieChart("instance");
end;

class function TdxFactory.PivotGrid(const id: string; options: TJSObject): TdxPivotGrid; assembler;
asm
  return $(id).dxPivotGrid(options).dxPivotGrid("instance");
end;

class function TdxFactory.PolarChart(const id: string; options: TJSObject): TdxPolarChart; assembler;
asm
  return $(id).dxPolarChart(options).dxPolarChart("instance");
end;

class function TdxFactory.Popover(const id: string; options: TJSObject): TdxPopover; assembler;
asm
  return $(id).dxPopover(options).dxPopover("instance");
end;

class function TdxFactory.Popup(const id: string; options: TJSObject): TdxPopup; assembler;
asm
  return $(id).dxPopup(options).dxPopup("instance");
end;

class function TdxFactory.ProgressBar(const id: string; options: TJSObject): TdxProgressBar; assembler;
asm
  return $(id).dxProgressBar(options).dxProgressBar("instance");
end;

class function TdxFactory.RadioGroup(const id: string; options: TJSObject): TdxRadioGroup; assembler;
asm
  return $(id).dxRadioGroup(options).dxRadioGroup("instance");
end;

class function TdxFactory.RangeSelector(const id: string; options: TJSObject): TdxRangeSelector; assembler;
asm
  return $(id).dxRangeSelector(options).dxRangeSelector("instance");
end;

class function TdxFactory.RangeSlider(const id: string; options: TJSObject): TdxRangeSlider; assembler;
asm
  return $(id).dxRangeSlider(options).dxRangeSlider("instance");
end;

class function TdxFactory.Resizable(const id: string; options: TJSObject): TdxResizable; assembler;
asm
  return $(id).dxResizable(options).dxResizable("instance");
end;

class function TdxFactory.ResponsiveBox(const id: string; options: TJSObject): TdxResponsiveBox; assembler;
asm
  return $(id).dxResponsiveBox(options).dxResponsiveBox("instance");
end;

class function TdxFactory.Sankey(const id: string; options: TJSObject): TdxSankey; assembler;
asm
  return $(id).dxSankey(options).dxSankey("instance");
end;

class function TdxFactory.Scheduler(const id: string; options: TJSObject): TdxScheduler; assembler;
asm
  return $(id).dxScheduler(options).dxScheduler("instance");
end;

class function TdxFactory.ScrollView(const id: string; options: TJSObject): TdxScrollView; assembler;
asm
  return $(id).dxScrollView(options).dxScrollView("instance");
end;

class function TdxFactory.SelectBox(const id: string; options: TJSObject): TdxSelectBox; assembler;
asm
  return $(id).dxSelectBox(options).dxSelectBox("instance");
end;

class function TdxFactory.Slider(const id: string; options: TJSObject): TdxSlider; assembler;
asm
  return $(id).dxSlider(options).dxSlider("instance");
end;

class function TdxFactory.Sparkline(const id: string; options: TJSObject): TdxSparkline; assembler;
asm
  return $(id).dxSparkline(options).dxSparkline("instance");
end;

class function TdxFactory.Switch(const id: string; options: TJSObject): TdxSwitch; assembler;
asm
  return $(id).dxSwitch(options).dxSwitch("instance");
end;

class function TdxFactory.TabPanel(const id: string; options: TJSObject): TdxTabPanel; assembler;
asm
  return $(id).dxTabPanel(options).dxTabPanel("instance");
end;

class function TdxFactory.Tabs(const id: string; options: TJSObject): TdxTabs; assembler;
asm
  return $(id).dxTabs(options).dxTabs("instance");
end;

class function TdxFactory.TagBox(const id: string; options: TJSObject): TdxTagBox; assembler;
asm
  return $(id).dxTagBox(options).dxTagBox("instance");
end;

class function TdxFactory.TextArea(const id: string; options: TJSObject): TdxTextArea; assembler;
asm
  return $(id).dxTextArea(options).dxTextArea("instance");
end;

class function TdxFactory.TextBox(const id: string; options: TJSObject): TdxTextBox; assembler;
asm
  return $(id).dxTextBox(options).dxTextBox("instance");
end;

class function TdxFactory.TileView(const id: string; options: TJSObject): TdxTileView; assembler;
asm
  return $(id).dxTileView(options).dxTileView("instance");
end;

class function TdxFactory.Toast(const id: string; options: TJSObject): TdxToast; assembler;
asm
  return $(id).dxToast(options).dxToast("instance");
end;

class function TdxFactory.Toolbar(const id: string; options: TJSObject): TdxToolbar; assembler;
asm
  return $(id).dxToolbar(options).dxToolbar("instance");
end;

class function TdxFactory.Tooltip(const id: string; options: TJSObject): TdxTooltip; assembler;
asm
  return $(id).dxTooltip(options).dxTooltip("instance");
end;

class function TdxFactory.TreeList(const id: string; options: TJSObject): TdxTreeList; assembler;
asm
  return $(id).dxTreeList(options).dxTreeList("instance");
end;

class function TdxFactory.TreeView(const id: string; options: TJSObject): TdxTreeView; assembler;
asm
  return $(id).dxTreeView(options).dxTreeView("instance");
end;

class function TdxFactory.VectorMap(const id: string; options: TJSObject): TdxVectorMap; assembler;
asm
  return $(id).dxVectorMap(options).dxVectorMap("instance");
end;

/// ///////////////////////////////////////////////////////////////

constructor TDX.Create(aOwner: TComponent);
begin
  inherited;
  ffactory := TdxFactory.Create(self);
end;

destructor TDX.Destroy;
begin
  FreeAndNil(ffactory);
  inherited;
end;

initialization

dx := TDX.Create(Application);

end.
