unit DevExtreme.PivotGrid.Custom;

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
  DevExtreme.PivotGrid.JS,
  DevExtreme.Types;

type
  TjdxCustomPivotGrid = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FallowExpandAll: boolean;
    FallowFiltering: boolean;
    FallowSorting: boolean;
    FallowSortingBySummary: boolean;
    FdataFieldArea: TdxPivotGridDataFieldArea;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FencodeHtml: boolean;
    Fexport: TJSObject;
    FfieldChooser: TJSObject;
    FfieldPanel: TJSObject;
    FfocusStateEnabled: boolean;
    FheaderFilter: TJSObject;
    Fheight_: JSValue;
    FhideEmptySummaryCells: boolean;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FloadPanel: TJSObject;
    FrowHeaderLayout: TdxPivotGridRowHeaderLayout;
    FrtlEnabled: boolean;
    Fscrolling: TJSObject;
    FshowBorders: boolean;
    FshowColumnGrandTotals: boolean;
    FshowColumnTotals: boolean;
    FshowRowGrandTotals: boolean;
    FshowRowTotals: boolean;
    FshowTotalsPrior: TdxPivotGridTotalDisplayMode;
    FstateStoring: TJSObject;
    FtabIndex: integer;
    Ftexts: TJSObject;
    Fvisible: boolean;
    Fwidth_: JSValue;
    FwordWrapEnabled: boolean;
  private
    FonCellClick: TdxEventHandler;
    FonCellPrepared: TdxEventHandler;
    FonContentReady: TdxEventHandler;
    FonContextMenuPreparing: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonExporting: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_allowExpandAll(const value: boolean);
    procedure Set_allowFiltering(const value: boolean);
    procedure Set_allowSorting(const value: boolean);
    procedure Set_allowSortingBySummary(const value: boolean);
    procedure Set_dataFieldArea(const value: TdxPivotGridDataFieldArea);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_encodeHtml(const value: boolean);
    procedure Set_export(const value: TJSObject);
    procedure Set_fieldChooser(const value: TJSObject);
    procedure Set_fieldPanel(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_headerFilter(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_hideEmptySummaryCells(const value: boolean);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_loadPanel(const value: TJSObject);
    procedure Set_rowHeaderLayout(const value: TdxPivotGridRowHeaderLayout);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scrolling(const value: TJSObject);
    procedure Set_showBorders(const value: boolean);
    procedure Set_showColumnGrandTotals(const value: boolean);
    procedure Set_showColumnTotals(const value: boolean);
    procedure Set_showRowGrandTotals(const value: boolean);
    procedure Set_showRowTotals(const value: boolean);
    procedure Set_showTotalsPrior(const value: TdxPivotGridTotalDisplayMode);
    procedure Set_stateStoring(const value: TJSObject);
    procedure Set_tabIndex(const value: integer);
    procedure Set_texts(const value: TJSObject);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
    procedure Set_wordWrapEnabled(const value: boolean);
  private
    procedure Set_onCellClick(const value: TdxEventHandler);
    procedure Set_onCellPrepared(const value: TdxEventHandler);
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onContextMenuPreparing(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onExporting(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxPivotGrid; assembler;
    function instance: TdxPivotGrid; assembler;
  public
    procedure beginUpdate(); assembler;
    function bindChart(chart: JSValue; integrationOptions: TJSObject): JSValue; assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler;
    function getDataSource(): JSValue; assembler;
    function getFieldChooserPopup(): JSValue; assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    function option(): TJSObject; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure registerKeyHandler(); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler; overload;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure updateDimensions(); assembler;
  public
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property fieldChooser: TJSObject read FfieldChooser write Set_fieldChooser;
    property fieldPanel: TJSObject read FfieldPanel write Set_fieldPanel;
    property headerFilter: TJSObject read FheaderFilter write Set_headerFilter;
    property height_: JSValue read Fheight_ write Set_height_;
    property loadPanel: TJSObject read FloadPanel write Set_loadPanel;
    property scrolling: TJSObject read Fscrolling write Set_scrolling;
    property stateStoring: TJSObject read FstateStoring write Set_stateStoring;
    property texts: TJSObject read Ftexts write Set_texts;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property allowExpandAll: boolean read FallowExpandAll write Set_allowExpandAll default false;
    property allowFiltering: boolean read FallowFiltering write Set_allowFiltering default false;
    property allowSorting: boolean read FallowSorting write Set_allowSorting default false;
    property allowSortingBySummary: boolean read FallowSortingBySummary write Set_allowSortingBySummary default false;
    property dataFieldArea: TdxPivotGridDataFieldArea read FdataFieldArea write Set_dataFieldArea default pgdfaColumn;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property encodeHtml: boolean read FencodeHtml write Set_encodeHtml default true;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hideEmptySummaryCells: boolean read FhideEmptySummaryCells write Set_hideEmptySummaryCells default true;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property rowHeaderLayout: TdxPivotGridRowHeaderLayout read FrowHeaderLayout write Set_rowHeaderLayout default pgrhlStandard;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showBorders: boolean read FshowBorders write Set_showBorders default false;
    property showColumnGrandTotals: boolean read FshowColumnGrandTotals write Set_showColumnGrandTotals default true;
    property showColumnTotals: boolean read FshowColumnTotals write Set_showColumnTotals default true;
    property showRowGrandTotals: boolean read FshowRowGrandTotals write Set_showRowGrandTotals default true;
    property showRowTotals: boolean read FshowRowTotals write Set_showRowTotals default true;
    property showTotalsPrior: TdxPivotGridTotalDisplayMode read FshowTotalsPrior write Set_showTotalsPrior default pgtdmNone;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
    property wordWrapEnabled: boolean read FwordWrapEnabled write Set_wordWrapEnabled default true;
  published
    property onCellClick: TdxEventHandler read FonCellClick write Set_onCellClick;
    property onCellPrepared: TdxEventHandler read FonCellPrepared write Set_onCellPrepared;
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onContextMenuPreparing: TdxEventHandler read FonContextMenuPreparing write Set_onContextMenuPreparing;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onExporting: TdxEventHandler read FonExporting write Set_onExporting;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
  end;

implementation


procedure TjdxCustomPivotGrid.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FallowExpandAll := false;
  FallowFiltering := false;
  FallowSorting := false;
  FallowSortingBySummary := false;
  FdataFieldArea := pgdfaColumn;
  FdataSource := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FencodeHtml := true;
  Fexport := TJSObject.new;
  FfieldChooser := TJSObject.new;
  FfieldPanel := TJSObject.new;
  FfocusStateEnabled := false;
  FheaderFilter := TJSObject.new;
  Fheight_ := nil;
  FhideEmptySummaryCells := true;
  Fhint := '';
  FhoverStateEnabled := false;
  FloadPanel := TJSObject.new;
  FrowHeaderLayout := pgrhlStandard;
  FrtlEnabled := false;
  Fscrolling := TJSObject.new;
  FshowBorders := false;
  FshowColumnGrandTotals := true;
  FshowColumnTotals := true;
  FshowRowGrandTotals := true;
  FshowRowTotals := true;
  FshowTotalsPrior := pgtdmNone;
  FstateStoring := TJSObject.new;
  FtabIndex := 0;
  Ftexts := TJSObject.new;
  Fvisible := true;
  Fwidth_ := nil;
  FwordWrapEnabled := true;

  FonCellClick := nil;
  FonCellPrepared := nil;
  FonContentReady := nil;
  FonContextMenuPreparing := nil;
  FonDisposing := nil;
  FonExporting := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
end;
procedure TjdxCustomPivotGrid.InitJQuery;
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
      $(id).dxPivotGrid(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomPivotGrid.getInstance(element: TJSObject): TdxPivotGrid;
asm
  return DevExpress.viz.dxPivotGrid.getInstance(element);
end;

function TjdxCustomPivotGrid.instance: TdxPivotGrid;
asm
  return $(this.GetJQID()).dxPivotGrid("instance");
end;
procedure TjdxCustomPivotGrid.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('allowExpandAll', allowExpandAll);
    SetOption('allowFiltering', allowFiltering);
    SetOption('allowSorting', allowSorting);
    SetOption('allowSortingBySummary', allowSortingBySummary);
    SetOption('dataFieldArea', dataFieldArea.ToString());
    SetOption('dataSource', dataSource);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('encodeHtml', encodeHtml);
    SetOption('export', export);
    SetOption('fieldChooser', fieldChooser);
    SetOption('fieldPanel', fieldPanel);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('headerFilter', headerFilter);
    SetOption('height', height_);
    SetOption('hideEmptySummaryCells', hideEmptySummaryCells);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('loadPanel', loadPanel);
    SetOption('rowHeaderLayout', rowHeaderLayout.ToString());
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('scrolling', scrolling);
    SetOption('showBorders', showBorders);
    SetOption('showColumnGrandTotals', showColumnGrandTotals);
    SetOption('showColumnTotals', showColumnTotals);
    SetOption('showRowGrandTotals', showRowGrandTotals);
    SetOption('showRowTotals', showRowTotals);
    SetOption('showTotalsPrior', showTotalsPrior.ToString());
    SetOption('stateStoring', stateStoring);
    SetOption('tabIndex', tabIndex);
    SetOption('texts', texts);
    SetOption('visible', visible);
    SetOption('width', width_);
    SetOption('wordWrapEnabled', wordWrapEnabled);

    SetEvent('cellClick', onCellClick);
    SetEvent('cellPrepared', onCellPrepared);
    SetEvent('contentReady', onContentReady);
    SetEvent('contextMenuPreparing', onContextMenuPreparing);
    SetEvent('disposing', onDisposing);
    SetEvent('exporting', onExporting);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomPivotGrid.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomPivotGrid.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomPivotGrid.Set_allowExpandAll(const Value: boolean);
begin
  FallowExpandAll := Value;
  SetOption('allowExpandAll', allowExpandAll);
end;

procedure TjdxCustomPivotGrid.Set_allowFiltering(const Value: boolean);
begin
  FallowFiltering := Value;
  SetOption('allowFiltering', allowFiltering);
end;

procedure TjdxCustomPivotGrid.Set_allowSorting(const Value: boolean);
begin
  FallowSorting := Value;
  SetOption('allowSorting', allowSorting);
end;

procedure TjdxCustomPivotGrid.Set_allowSortingBySummary(const Value: boolean);
begin
  FallowSortingBySummary := Value;
  SetOption('allowSortingBySummary', allowSortingBySummary);
end;

procedure TjdxCustomPivotGrid.Set_dataFieldArea(const Value: TdxPivotGridDataFieldArea);
begin
  FdataFieldArea := Value;
  SetOption('dataFieldArea', dataFieldArea.ToString());
end;

procedure TjdxCustomPivotGrid.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
  SetOption('dataSource', dataSource);
end;

procedure TjdxCustomPivotGrid.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomPivotGrid.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomPivotGrid.Set_encodeHtml(const Value: boolean);
begin
  FencodeHtml := Value;
  SetOption('encodeHtml', encodeHtml);
end;

procedure TjdxCustomPivotGrid.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
  SetOption('export', export);
end;

procedure TjdxCustomPivotGrid.Set_fieldChooser(const Value: TJSObject);
begin
  FfieldChooser := Value;
  SetOption('fieldChooser', fieldChooser);
end;

procedure TjdxCustomPivotGrid.Set_fieldPanel(const Value: TJSObject);
begin
  FfieldPanel := Value;
  SetOption('fieldPanel', fieldPanel);
end;

procedure TjdxCustomPivotGrid.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomPivotGrid.Set_headerFilter(const Value: TJSObject);
begin
  FheaderFilter := Value;
  SetOption('headerFilter', headerFilter);
end;

procedure TjdxCustomPivotGrid.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomPivotGrid.Set_hideEmptySummaryCells(const Value: boolean);
begin
  FhideEmptySummaryCells := Value;
  SetOption('hideEmptySummaryCells', hideEmptySummaryCells);
end;

procedure TjdxCustomPivotGrid.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomPivotGrid.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomPivotGrid.Set_loadPanel(const Value: TJSObject);
begin
  FloadPanel := Value;
  SetOption('loadPanel', loadPanel);
end;

procedure TjdxCustomPivotGrid.Set_rowHeaderLayout(const Value: TdxPivotGridRowHeaderLayout);
begin
  FrowHeaderLayout := Value;
  SetOption('rowHeaderLayout', rowHeaderLayout.ToString());
end;

procedure TjdxCustomPivotGrid.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomPivotGrid.Set_scrolling(const Value: TJSObject);
begin
  Fscrolling := Value;
  SetOption('scrolling', scrolling);
end;

procedure TjdxCustomPivotGrid.Set_showBorders(const Value: boolean);
begin
  FshowBorders := Value;
  SetOption('showBorders', showBorders);
end;

procedure TjdxCustomPivotGrid.Set_showColumnGrandTotals(const Value: boolean);
begin
  FshowColumnGrandTotals := Value;
  SetOption('showColumnGrandTotals', showColumnGrandTotals);
end;

procedure TjdxCustomPivotGrid.Set_showColumnTotals(const Value: boolean);
begin
  FshowColumnTotals := Value;
  SetOption('showColumnTotals', showColumnTotals);
end;

procedure TjdxCustomPivotGrid.Set_showRowGrandTotals(const Value: boolean);
begin
  FshowRowGrandTotals := Value;
  SetOption('showRowGrandTotals', showRowGrandTotals);
end;

procedure TjdxCustomPivotGrid.Set_showRowTotals(const Value: boolean);
begin
  FshowRowTotals := Value;
  SetOption('showRowTotals', showRowTotals);
end;

procedure TjdxCustomPivotGrid.Set_showTotalsPrior(const Value: TdxPivotGridTotalDisplayMode);
begin
  FshowTotalsPrior := Value;
  SetOption('showTotalsPrior', showTotalsPrior.ToString());
end;

procedure TjdxCustomPivotGrid.Set_stateStoring(const Value: TJSObject);
begin
  FstateStoring := Value;
  SetOption('stateStoring', stateStoring);
end;

procedure TjdxCustomPivotGrid.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomPivotGrid.Set_texts(const Value: TJSObject);
begin
  Ftexts := Value;
  SetOption('texts', texts);
end;

procedure TjdxCustomPivotGrid.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomPivotGrid.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomPivotGrid.Set_wordWrapEnabled(const Value: boolean);
begin
  FwordWrapEnabled := Value;
  SetOption('wordWrapEnabled', wordWrapEnabled);
end;

procedure TjdxCustomPivotGrid.Set_onCellClick(const Value: TdxEventHandler);
begin
  FonCellClick := Value;
  SetEvent('cellClick', onCellClick);
end;

procedure TjdxCustomPivotGrid.Set_onCellPrepared(const Value: TdxEventHandler);
begin
  FonCellPrepared := Value;
  SetEvent('cellPrepared', onCellPrepared);
end;

procedure TjdxCustomPivotGrid.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomPivotGrid.Set_onContextMenuPreparing(const Value: TdxEventHandler);
begin
  FonContextMenuPreparing := Value;
  SetEvent('contextMenuPreparing', onContextMenuPreparing);
end;

procedure TjdxCustomPivotGrid.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomPivotGrid.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
  SetEvent('exporting', onExporting);
end;

procedure TjdxCustomPivotGrid.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomPivotGrid.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomPivotGrid.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomPivotGrid.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomPivotGrid.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  _instance.beginUpdate();
end;

function TjdxCustomPivotGrid.bindChart(chart: JSValue; integrationOptions: TJSObject): JSValue;
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  return _instance.bindChart(chart, integrationOptions);
end;

procedure TjdxCustomPivotGrid.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomPivotGrid.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomPivotGrid.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomPivotGrid.dispose();
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  _instance.dispose();
end;

function TjdxCustomPivotGrid.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  return _instance.element();
end;

procedure TjdxCustomPivotGrid.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomPivotGrid.focus();
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  _instance.focus();
end;

function TjdxCustomPivotGrid.getDataSource(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  return _instance.getDataSource();
end;

function TjdxCustomPivotGrid.getFieldChooserPopup(): JSValue;
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  return _instance.getFieldChooserPopup();
end;

function TjdxCustomPivotGrid.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomPivotGrid.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  return _instance.off(eventName);
end;

function TjdxCustomPivotGrid.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  return _instance.on(events);
end;

function TjdxCustomPivotGrid.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  return _instance.on(eventName, eventHandler);
end;

procedure TjdxCustomPivotGrid.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  _instance.option(optionName, optionValue);
end;

function TjdxCustomPivotGrid.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  return _instance.option();
end;

function TjdxCustomPivotGrid.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomPivotGrid.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  _instance.option(options);
end;

procedure TjdxCustomPivotGrid.registerKeyHandler();
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  _instance.registerKeyHandler();
end;

procedure TjdxCustomPivotGrid.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomPivotGrid.repaint();
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  _instance.repaint();
end;

procedure TjdxCustomPivotGrid.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomPivotGrid.updateDimensions();
asm
  const _instance = $(this.GetJQID()).dxPivotGrid("instance");
  _instance.updateDimensions();
end;

end.
