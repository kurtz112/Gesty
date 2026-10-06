unit DevExtreme.Funnel;

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
  TjdxFunnel = class(TjdxCustomControl)
  private
    FadaptiveLayout: TJSObject;
    Falgorithm: TdxFunnelAlgorithm;
    FargumentField: string;
    FcolorField: string;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    Fheight_: JSValue;
    FhoverEnabled: boolean;
    Finverted: boolean;
    Fitem: TJSObject;
    Flabel_: TJSObject;
    Flegend: TJSObject;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    FneckHeight: integer;
    FneckWidth: integer;
    Fpalette: JSValue;
    FpaletteExtensionMode: JSValue;
    FpathModified: boolean;
    FredrawOnResize: boolean;
    FresolveLabelOverlapping: JSValue;
    FrtlEnabled: boolean;
    FselectionMode: TdxSingleMultipleOrNone;
    Fsize: TJSObject;
    FsortData: boolean;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    FvalueField: string;
    Fwidth_: JSValue;
  private
    FonDisposing: TdxEventHandler;
    FonDrawn: TdxEventHandler;
    FonExported: TdxEventHandler;
    FonExporting: TdxEventHandler;
    FonFileSaving: TdxEventHandler;
    FonHoverChanged: TdxEventHandler;
    FonIncidentOccurred: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonItemClick: TdxEventHandler;
    FonLegendClick: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
  private
    procedure Set_adaptiveLayout(const value: TJSObject);
    procedure Set_algorithm(const value: TdxFunnelAlgorithm);
    procedure Set_argumentField(const value: string);
    procedure Set_colorField(const value: string);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_hoverEnabled(const value: boolean);
    procedure Set_inverted(const value: boolean);
    procedure Set_item(const value: TJSObject);
    procedure Set_label_(const value: TJSObject);
    procedure Set_legend(const value: TJSObject);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_neckHeight(const value: integer);
    procedure Set_neckWidth(const value: integer);
    procedure Set_palette(const value: JSValue);
    procedure Set_paletteExtensionMode(const value: JSValue);
    procedure Set_pathModified(const value: boolean);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_resolveLabelOverlapping(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_selectionMode(const value: TdxSingleMultipleOrNone);
    procedure Set_size(const value: TJSObject);
    procedure Set_sortData(const value: boolean);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_valueField(const value: string);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onDrawn(const value: TdxEventHandler);
    procedure Set_onExported(const value: TdxEventHandler);
    procedure Set_onExporting(const value: TdxEventHandler);
    procedure Set_onFileSaving(const value: TdxEventHandler);
    procedure Set_onHoverChanged(const value: TdxEventHandler);
    procedure Set_onIncidentOccurred(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onItemClick(const value: TdxEventHandler);
    procedure Set_onLegendClick(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property adaptiveLayout: TJSObject read FadaptiveLayout write Set_adaptiveLayout;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property height_: JSValue read Fheight_ write Set_height_;
    property item: TJSObject read Fitem write Set_item;
    property label_: TJSObject read Flabel_ write Set_label_;
    property legend: TJSObject read Flegend write Set_legend;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property palette: JSValue read Fpalette write Set_palette;
    property paletteExtensionMode: JSValue read FpaletteExtensionMode write Set_paletteExtensionMode;
    property resolveLabelOverlapping: JSValue read FresolveLabelOverlapping write Set_resolveLabelOverlapping;
    property size: TJSObject read Fsize write Set_size;
    property theme: JSValue read Ftheme write Set_theme;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property algorithm: TdxFunnelAlgorithm read Falgorithm write Set_algorithm default faDynamicSlope;
    property argumentField: string read FargumentField write Set_argumentField;
    property colorField: string read FcolorField write Set_colorField;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property hoverEnabled: boolean read FhoverEnabled write Set_hoverEnabled default true;
    property inverted: boolean read Finverted write Set_inverted default false;
    property neckHeight: integer read FneckHeight write Set_neckHeight;
    property neckWidth: integer read FneckWidth write Set_neckWidth;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property selectionMode: TdxSingleMultipleOrNone read FselectionMode write Set_selectionMode default smonSingle;
    property sortData: boolean read FsortData write Set_sortData default true;
    property valueField: string read FvalueField write Set_valueField;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onDrawn: TdxEventHandler read FonDrawn write Set_onDrawn;
    property onExported: TdxEventHandler read FonExported write Set_onExported;
    property onExporting: TdxEventHandler read FonExporting write Set_onExporting;
    property onFileSaving: TdxEventHandler read FonFileSaving write Set_onFileSaving;
    property onHoverChanged: TdxEventHandler read FonHoverChanged write Set_onHoverChanged;
    property onIncidentOccurred: TdxEventHandler read FonIncidentOccurred write Set_onIncidentOccurred;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onItemClick: TdxEventHandler read FonItemClick write Set_onItemClick;
    property onLegendClick: TdxEventHandler read FonLegendClick write Set_onLegendClick;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
  end;

implementation


constructor TjdxFunnel.Create(aOwner: TComponent);
begin
  inherited;
  FadaptiveLayout := TJSObject.new;
  Falgorithm := faDynamicSlope;
  FargumentField := '';
  FcolorField := '';
  FdataSource := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  Fheight_ := nil;
  FhoverEnabled := true;
  Finverted := false;
  Fitem := TJSObject.new;
  Flabel_ := TJSObject.new;
  Flegend := TJSObject.new;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  FneckHeight := 0;
  FneckWidth := 0;
  Fpalette := nil;
  FpaletteExtensionMode := nil;
  FpathModified := false;
  FredrawOnResize := true;
  FresolveLabelOverlapping := nil;
  FrtlEnabled := false;
  FselectionMode := smonSingle;
  Fsize := TJSObject.new;
  FsortData := true;
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  FvalueField := '';
  Fwidth_ := nil;

  FonDisposing := nil;
  FonDrawn := nil;
  FonExported := nil;
  FonExporting := nil;
  FonFileSaving := nil;
  FonHoverChanged := nil;
  FonIncidentOccurred := nil;
  FonInitialized := nil;
  FonItemClick := nil;
  FonLegendClick := nil;
  FonOptionChanged := nil;
  FonSelectionChanged := nil;
end;

procedure TjdxFunnel.Set_adaptiveLayout(const Value: TJSObject);
begin
  FadaptiveLayout := Value;
end;

procedure TjdxFunnel.Set_algorithm(const Value: TdxFunnelAlgorithm);
begin
  Falgorithm := Value;
end;

procedure TjdxFunnel.Set_argumentField(const Value: string);
begin
  FargumentField := Value;
end;

procedure TjdxFunnel.Set_colorField(const Value: string);
begin
  FcolorField := Value;
end;

procedure TjdxFunnel.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxFunnel.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxFunnel.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxFunnel.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
end;

procedure TjdxFunnel.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxFunnel.Set_hoverEnabled(const Value: boolean);
begin
  FhoverEnabled := Value;
end;

procedure TjdxFunnel.Set_inverted(const Value: boolean);
begin
  Finverted := Value;
end;

procedure TjdxFunnel.Set_item(const Value: TJSObject);
begin
  Fitem := Value;
end;

procedure TjdxFunnel.Set_label_(const Value: TJSObject);
begin
  Flabel_ := Value;
end;

procedure TjdxFunnel.Set_legend(const Value: TJSObject);
begin
  Flegend := Value;
end;

procedure TjdxFunnel.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
end;

procedure TjdxFunnel.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
end;

procedure TjdxFunnel.Set_neckHeight(const Value: integer);
begin
  FneckHeight := Value;
end;

procedure TjdxFunnel.Set_neckWidth(const Value: integer);
begin
  FneckWidth := Value;
end;

procedure TjdxFunnel.Set_palette(const Value: JSValue);
begin
  Fpalette := Value;
end;

procedure TjdxFunnel.Set_paletteExtensionMode(const Value: JSValue);
begin
  FpaletteExtensionMode := Value;
end;

procedure TjdxFunnel.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
end;

procedure TjdxFunnel.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
end;

procedure TjdxFunnel.Set_resolveLabelOverlapping(const Value: JSValue);
begin
  FresolveLabelOverlapping := Value;
end;

procedure TjdxFunnel.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxFunnel.Set_selectionMode(const Value: TdxSingleMultipleOrNone);
begin
  FselectionMode := Value;
end;

procedure TjdxFunnel.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
end;

procedure TjdxFunnel.Set_sortData(const Value: boolean);
begin
  FsortData := Value;
end;

procedure TjdxFunnel.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
end;

procedure TjdxFunnel.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
end;

procedure TjdxFunnel.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
end;

procedure TjdxFunnel.Set_valueField(const Value: string);
begin
  FvalueField := Value;
end;

procedure TjdxFunnel.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxFunnel.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxFunnel.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
end;

procedure TjdxFunnel.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
end;

procedure TjdxFunnel.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
end;

procedure TjdxFunnel.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
end;

procedure TjdxFunnel.Set_onHoverChanged(const Value: TdxEventHandler);
begin
  FonHoverChanged := Value;
end;

procedure TjdxFunnel.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
end;

procedure TjdxFunnel.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxFunnel.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
end;

procedure TjdxFunnel.Set_onLegendClick(const Value: TdxEventHandler);
begin
  FonLegendClick := Value;
end;

procedure TjdxFunnel.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxFunnel.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
end;

end.
