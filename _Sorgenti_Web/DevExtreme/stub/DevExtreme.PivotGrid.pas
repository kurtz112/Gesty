unit DevExtreme.PivotGrid;

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
  TjdxPivotGrid = class(TjdxCustomControl)
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
  public
    constructor Create(aOwner: TComponent); override;
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


constructor TjdxPivotGrid.Create(aOwner: TComponent);
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

procedure TjdxPivotGrid.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxPivotGrid.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxPivotGrid.Set_allowExpandAll(const Value: boolean);
begin
  FallowExpandAll := Value;
end;

procedure TjdxPivotGrid.Set_allowFiltering(const Value: boolean);
begin
  FallowFiltering := Value;
end;

procedure TjdxPivotGrid.Set_allowSorting(const Value: boolean);
begin
  FallowSorting := Value;
end;

procedure TjdxPivotGrid.Set_allowSortingBySummary(const Value: boolean);
begin
  FallowSortingBySummary := Value;
end;

procedure TjdxPivotGrid.Set_dataFieldArea(const Value: TdxPivotGridDataFieldArea);
begin
  FdataFieldArea := Value;
end;

procedure TjdxPivotGrid.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxPivotGrid.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxPivotGrid.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxPivotGrid.Set_encodeHtml(const Value: boolean);
begin
  FencodeHtml := Value;
end;

procedure TjdxPivotGrid.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
end;

procedure TjdxPivotGrid.Set_fieldChooser(const Value: TJSObject);
begin
  FfieldChooser := Value;
end;

procedure TjdxPivotGrid.Set_fieldPanel(const Value: TJSObject);
begin
  FfieldPanel := Value;
end;

procedure TjdxPivotGrid.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxPivotGrid.Set_headerFilter(const Value: TJSObject);
begin
  FheaderFilter := Value;
end;

procedure TjdxPivotGrid.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxPivotGrid.Set_hideEmptySummaryCells(const Value: boolean);
begin
  FhideEmptySummaryCells := Value;
end;

procedure TjdxPivotGrid.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxPivotGrid.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxPivotGrid.Set_loadPanel(const Value: TJSObject);
begin
  FloadPanel := Value;
end;

procedure TjdxPivotGrid.Set_rowHeaderLayout(const Value: TdxPivotGridRowHeaderLayout);
begin
  FrowHeaderLayout := Value;
end;

procedure TjdxPivotGrid.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxPivotGrid.Set_scrolling(const Value: TJSObject);
begin
  Fscrolling := Value;
end;

procedure TjdxPivotGrid.Set_showBorders(const Value: boolean);
begin
  FshowBorders := Value;
end;

procedure TjdxPivotGrid.Set_showColumnGrandTotals(const Value: boolean);
begin
  FshowColumnGrandTotals := Value;
end;

procedure TjdxPivotGrid.Set_showColumnTotals(const Value: boolean);
begin
  FshowColumnTotals := Value;
end;

procedure TjdxPivotGrid.Set_showRowGrandTotals(const Value: boolean);
begin
  FshowRowGrandTotals := Value;
end;

procedure TjdxPivotGrid.Set_showRowTotals(const Value: boolean);
begin
  FshowRowTotals := Value;
end;

procedure TjdxPivotGrid.Set_showTotalsPrior(const Value: TdxPivotGridTotalDisplayMode);
begin
  FshowTotalsPrior := Value;
end;

procedure TjdxPivotGrid.Set_stateStoring(const Value: TJSObject);
begin
  FstateStoring := Value;
end;

procedure TjdxPivotGrid.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxPivotGrid.Set_texts(const Value: TJSObject);
begin
  Ftexts := Value;
end;

procedure TjdxPivotGrid.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxPivotGrid.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxPivotGrid.Set_wordWrapEnabled(const Value: boolean);
begin
  FwordWrapEnabled := Value;
end;

procedure TjdxPivotGrid.Set_onCellClick(const Value: TdxEventHandler);
begin
  FonCellClick := Value;
end;

procedure TjdxPivotGrid.Set_onCellPrepared(const Value: TdxEventHandler);
begin
  FonCellPrepared := Value;
end;

procedure TjdxPivotGrid.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxPivotGrid.Set_onContextMenuPreparing(const Value: TdxEventHandler);
begin
  FonContextMenuPreparing := Value;
end;

procedure TjdxPivotGrid.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxPivotGrid.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
end;

procedure TjdxPivotGrid.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxPivotGrid.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxPivotGrid.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxPivotGrid.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

end.
