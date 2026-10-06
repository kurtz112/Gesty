unit DevExtreme.TreeMap;

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
  TjdxTreeMap = class(TjdxCustomControl)
  private
    FchildrenField: string;
    FcolorField: string;
    Fcolorizer: TJSObject;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    Fgroup: TJSObject;
    Fheight_: JSValue;
    FhoverEnabled: boolean;
    FidField: string;
    FinteractWithGroup: boolean;
    FlabelField: string;
    FlayoutAlgorithm: JSValue;
    FlayoutDirection: TdxTreeMapLayoutDirection;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    FmaxDepth: integer;
    FparentField: string;
    FpathModified: boolean;
    FredrawOnResize: boolean;
    FrtlEnabled: boolean;
    FselectionMode: TdxSingleMultipleOrNone;
    Fsize: TJSObject;
    Ftheme: JSValue;
    Ftile: TJSObject;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    FvalueField: string;
    Fwidth_: JSValue;
  private
    FonClick: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonDrawn: TdxEventHandler;
    FonDrill: TdxEventHandler;
    FonExported: TdxEventHandler;
    FonExporting: TdxEventHandler;
    FonFileSaving: TdxEventHandler;
    FonHoverChanged: TdxEventHandler;
    FonIncidentOccurred: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonNodesInitialized: TdxEventHandler;
    FonNodesRendering: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
  private
    procedure Set_childrenField(const value: string);
    procedure Set_colorField(const value: string);
    procedure Set_colorizer(const value: TJSObject);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_group(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_hoverEnabled(const value: boolean);
    procedure Set_idField(const value: string);
    procedure Set_interactWithGroup(const value: boolean);
    procedure Set_labelField(const value: string);
    procedure Set_layoutAlgorithm(const value: JSValue);
    procedure Set_layoutDirection(const value: TdxTreeMapLayoutDirection);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_maxDepth(const value: integer);
    procedure Set_parentField(const value: string);
    procedure Set_pathModified(const value: boolean);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_selectionMode(const value: TdxSingleMultipleOrNone);
    procedure Set_size(const value: TJSObject);
    procedure Set_theme(const value: JSValue);
    procedure Set_tile(const value: TJSObject);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_valueField(const value: string);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onClick(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onDrawn(const value: TdxEventHandler);
    procedure Set_onDrill(const value: TdxEventHandler);
    procedure Set_onExported(const value: TdxEventHandler);
    procedure Set_onExporting(const value: TdxEventHandler);
    procedure Set_onFileSaving(const value: TdxEventHandler);
    procedure Set_onHoverChanged(const value: TdxEventHandler);
    procedure Set_onIncidentOccurred(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onNodesInitialized(const value: TdxEventHandler);
    procedure Set_onNodesRendering(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property colorizer: TJSObject read Fcolorizer write Set_colorizer;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property group: TJSObject read Fgroup write Set_group;
    property height_: JSValue read Fheight_ write Set_height_;
    property layoutAlgorithm: JSValue read FlayoutAlgorithm write Set_layoutAlgorithm;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property size: TJSObject read Fsize write Set_size;
    property theme: JSValue read Ftheme write Set_theme;
    property tile: TJSObject read Ftile write Set_tile;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property childrenField: string read FchildrenField write Set_childrenField;
    property colorField: string read FcolorField write Set_colorField;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property hoverEnabled: boolean read FhoverEnabled write Set_hoverEnabled;
    property idField: string read FidField write Set_idField;
    property interactWithGroup: boolean read FinteractWithGroup write Set_interactWithGroup default false;
    property labelField: string read FlabelField write Set_labelField;
    property layoutDirection: TdxTreeMapLayoutDirection read FlayoutDirection write Set_layoutDirection default tmldLeftTopRightBottom;
    property maxDepth: integer read FmaxDepth write Set_maxDepth;
    property parentField: string read FparentField write Set_parentField;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property selectionMode: TdxSingleMultipleOrNone read FselectionMode write Set_selectionMode default smonMultiple;
    property valueField: string read FvalueField write Set_valueField;
  published
    property onClick: TdxEventHandler read FonClick write Set_onClick;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onDrawn: TdxEventHandler read FonDrawn write Set_onDrawn;
    property onDrill: TdxEventHandler read FonDrill write Set_onDrill;
    property onExported: TdxEventHandler read FonExported write Set_onExported;
    property onExporting: TdxEventHandler read FonExporting write Set_onExporting;
    property onFileSaving: TdxEventHandler read FonFileSaving write Set_onFileSaving;
    property onHoverChanged: TdxEventHandler read FonHoverChanged write Set_onHoverChanged;
    property onIncidentOccurred: TdxEventHandler read FonIncidentOccurred write Set_onIncidentOccurred;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onNodesInitialized: TdxEventHandler read FonNodesInitialized write Set_onNodesInitialized;
    property onNodesRendering: TdxEventHandler read FonNodesRendering write Set_onNodesRendering;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
  end;

implementation


constructor TjdxTreeMap.Create(aOwner: TComponent);
begin
  inherited;
  FchildrenField := '';
  FcolorField := '';
  Fcolorizer := TJSObject.new;
  FdataSource := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  Fgroup := TJSObject.new;
  Fheight_ := nil;
  FhoverEnabled := false;
  FidField := '';
  FinteractWithGroup := false;
  FlabelField := '';
  FlayoutAlgorithm := nil;
  FlayoutDirection := tmldLeftTopRightBottom;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  FmaxDepth := 0;
  FparentField := '';
  FpathModified := false;
  FredrawOnResize := true;
  FrtlEnabled := false;
  FselectionMode := smonMultiple;
  Fsize := TJSObject.new;
  Ftheme := nil;
  Ftile := TJSObject.new;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  FvalueField := '';
  Fwidth_ := nil;

  FonClick := nil;
  FonDisposing := nil;
  FonDrawn := nil;
  FonDrill := nil;
  FonExported := nil;
  FonExporting := nil;
  FonFileSaving := nil;
  FonHoverChanged := nil;
  FonIncidentOccurred := nil;
  FonInitialized := nil;
  FonNodesInitialized := nil;
  FonNodesRendering := nil;
  FonOptionChanged := nil;
  FonSelectionChanged := nil;
end;

procedure TjdxTreeMap.Set_childrenField(const Value: string);
begin
  FchildrenField := Value;
end;

procedure TjdxTreeMap.Set_colorField(const Value: string);
begin
  FcolorField := Value;
end;

procedure TjdxTreeMap.Set_colorizer(const Value: TJSObject);
begin
  Fcolorizer := Value;
end;

procedure TjdxTreeMap.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxTreeMap.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxTreeMap.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxTreeMap.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
end;

procedure TjdxTreeMap.Set_group(const Value: TJSObject);
begin
  Fgroup := Value;
end;

procedure TjdxTreeMap.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxTreeMap.Set_hoverEnabled(const Value: boolean);
begin
  FhoverEnabled := Value;
end;

procedure TjdxTreeMap.Set_idField(const Value: string);
begin
  FidField := Value;
end;

procedure TjdxTreeMap.Set_interactWithGroup(const Value: boolean);
begin
  FinteractWithGroup := Value;
end;

procedure TjdxTreeMap.Set_labelField(const Value: string);
begin
  FlabelField := Value;
end;

procedure TjdxTreeMap.Set_layoutAlgorithm(const Value: JSValue);
begin
  FlayoutAlgorithm := Value;
end;

procedure TjdxTreeMap.Set_layoutDirection(const Value: TdxTreeMapLayoutDirection);
begin
  FlayoutDirection := Value;
end;

procedure TjdxTreeMap.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
end;

procedure TjdxTreeMap.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
end;

procedure TjdxTreeMap.Set_maxDepth(const Value: integer);
begin
  FmaxDepth := Value;
end;

procedure TjdxTreeMap.Set_parentField(const Value: string);
begin
  FparentField := Value;
end;

procedure TjdxTreeMap.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
end;

procedure TjdxTreeMap.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
end;

procedure TjdxTreeMap.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxTreeMap.Set_selectionMode(const Value: TdxSingleMultipleOrNone);
begin
  FselectionMode := Value;
end;

procedure TjdxTreeMap.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
end;

procedure TjdxTreeMap.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
end;

procedure TjdxTreeMap.Set_tile(const Value: TJSObject);
begin
  Ftile := Value;
end;

procedure TjdxTreeMap.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
end;

procedure TjdxTreeMap.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
end;

procedure TjdxTreeMap.Set_valueField(const Value: string);
begin
  FvalueField := Value;
end;

procedure TjdxTreeMap.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxTreeMap.Set_onClick(const Value: TdxEventHandler);
begin
  FonClick := Value;
end;

procedure TjdxTreeMap.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxTreeMap.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
end;

procedure TjdxTreeMap.Set_onDrill(const Value: TdxEventHandler);
begin
  FonDrill := Value;
end;

procedure TjdxTreeMap.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
end;

procedure TjdxTreeMap.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
end;

procedure TjdxTreeMap.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
end;

procedure TjdxTreeMap.Set_onHoverChanged(const Value: TdxEventHandler);
begin
  FonHoverChanged := Value;
end;

procedure TjdxTreeMap.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
end;

procedure TjdxTreeMap.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxTreeMap.Set_onNodesInitialized(const Value: TdxEventHandler);
begin
  FonNodesInitialized := Value;
end;

procedure TjdxTreeMap.Set_onNodesRendering(const Value: TdxEventHandler);
begin
  FonNodesRendering := Value;
end;

procedure TjdxTreeMap.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxTreeMap.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
end;

end.
