unit DevExtreme.Sankey;

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
  TjdxSankey = class(TjdxCustomControl)
  private
    FadaptiveLayout: TJSObject;
    Falignment: JSValue;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    Fheight_: JSValue;
    FhoverEnabled: boolean;
    Flabel_: TJSObject;
    Flink: TJSObject;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    Fnode: TJSObject;
    Fpalette: JSValue;
    FpaletteExtensionMode: JSValue;
    FpathModified: boolean;
    FredrawOnResize: boolean;
    FrtlEnabled: boolean;
    Fsize: TJSObject;
    FsortData: JSValue;
    FsourceField: string;
    FtargetField: string;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    FweightField: string;
    Fwidth_: JSValue;
  private
    FonDisposing: TdxEventHandler;
    FonDrawn: TdxEventHandler;
    FonExported: TdxEventHandler;
    FonExporting: TdxEventHandler;
    FonFileSaving: TdxEventHandler;
    FonIncidentOccurred: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonLinkClick: TdxEventHandler;
    FonLinkHoverChanged: TdxEventHandler;
    FonNodeClick: TdxEventHandler;
    FonNodeHoverChanged: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
  private
    procedure Set_adaptiveLayout(const value: TJSObject);
    procedure Set_alignment(const value: JSValue);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_hoverEnabled(const value: boolean);
    procedure Set_label_(const value: TJSObject);
    procedure Set_link(const value: TJSObject);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_node(const value: TJSObject);
    procedure Set_palette(const value: JSValue);
    procedure Set_paletteExtensionMode(const value: JSValue);
    procedure Set_pathModified(const value: boolean);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_size(const value: TJSObject);
    procedure Set_sortData(const value: JSValue);
    procedure Set_sourceField(const value: string);
    procedure Set_targetField(const value: string);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_weightField(const value: string);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onDrawn(const value: TdxEventHandler);
    procedure Set_onExported(const value: TdxEventHandler);
    procedure Set_onExporting(const value: TdxEventHandler);
    procedure Set_onFileSaving(const value: TdxEventHandler);
    procedure Set_onIncidentOccurred(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onLinkClick(const value: TdxEventHandler);
    procedure Set_onLinkHoverChanged(const value: TdxEventHandler);
    procedure Set_onNodeClick(const value: TdxEventHandler);
    procedure Set_onNodeHoverChanged(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property adaptiveLayout: TJSObject read FadaptiveLayout write Set_adaptiveLayout;
    property alignment: JSValue read Falignment write Set_alignment;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property height_: JSValue read Fheight_ write Set_height_;
    property label_: TJSObject read Flabel_ write Set_label_;
    property link: TJSObject read Flink write Set_link;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property node: TJSObject read Fnode write Set_node;
    property palette: JSValue read Fpalette write Set_palette;
    property paletteExtensionMode: JSValue read FpaletteExtensionMode write Set_paletteExtensionMode;
    property size: TJSObject read Fsize write Set_size;
    property sortData: JSValue read FsortData write Set_sortData;
    property theme: JSValue read Ftheme write Set_theme;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property hoverEnabled: boolean read FhoverEnabled write Set_hoverEnabled default true;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property sourceField: string read FsourceField write Set_sourceField;
    property targetField: string read FtargetField write Set_targetField;
    property weightField: string read FweightField write Set_weightField;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onDrawn: TdxEventHandler read FonDrawn write Set_onDrawn;
    property onExported: TdxEventHandler read FonExported write Set_onExported;
    property onExporting: TdxEventHandler read FonExporting write Set_onExporting;
    property onFileSaving: TdxEventHandler read FonFileSaving write Set_onFileSaving;
    property onIncidentOccurred: TdxEventHandler read FonIncidentOccurred write Set_onIncidentOccurred;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onLinkClick: TdxEventHandler read FonLinkClick write Set_onLinkClick;
    property onLinkHoverChanged: TdxEventHandler read FonLinkHoverChanged write Set_onLinkHoverChanged;
    property onNodeClick: TdxEventHandler read FonNodeClick write Set_onNodeClick;
    property onNodeHoverChanged: TdxEventHandler read FonNodeHoverChanged write Set_onNodeHoverChanged;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
  end;

implementation


constructor TjdxSankey.Create(aOwner: TComponent);
begin
  inherited;
  FadaptiveLayout := TJSObject.new;
  Falignment := nil;
  FdataSource := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  Fheight_ := nil;
  FhoverEnabled := true;
  Flabel_ := TJSObject.new;
  Flink := TJSObject.new;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  Fnode := TJSObject.new;
  Fpalette := nil;
  FpaletteExtensionMode := nil;
  FpathModified := false;
  FredrawOnResize := true;
  FrtlEnabled := false;
  Fsize := TJSObject.new;
  FsortData := nil;
  FsourceField := '';
  FtargetField := '';
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  FweightField := '';
  Fwidth_ := nil;

  FonDisposing := nil;
  FonDrawn := nil;
  FonExported := nil;
  FonExporting := nil;
  FonFileSaving := nil;
  FonIncidentOccurred := nil;
  FonInitialized := nil;
  FonLinkClick := nil;
  FonLinkHoverChanged := nil;
  FonNodeClick := nil;
  FonNodeHoverChanged := nil;
  FonOptionChanged := nil;
end;

procedure TjdxSankey.Set_adaptiveLayout(const Value: TJSObject);
begin
  FadaptiveLayout := Value;
end;

procedure TjdxSankey.Set_alignment(const Value: JSValue);
begin
  Falignment := Value;
end;

procedure TjdxSankey.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxSankey.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxSankey.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxSankey.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
end;

procedure TjdxSankey.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxSankey.Set_hoverEnabled(const Value: boolean);
begin
  FhoverEnabled := Value;
end;

procedure TjdxSankey.Set_label_(const Value: TJSObject);
begin
  Flabel_ := Value;
end;

procedure TjdxSankey.Set_link(const Value: TJSObject);
begin
  Flink := Value;
end;

procedure TjdxSankey.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
end;

procedure TjdxSankey.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
end;

procedure TjdxSankey.Set_node(const Value: TJSObject);
begin
  Fnode := Value;
end;

procedure TjdxSankey.Set_palette(const Value: JSValue);
begin
  Fpalette := Value;
end;

procedure TjdxSankey.Set_paletteExtensionMode(const Value: JSValue);
begin
  FpaletteExtensionMode := Value;
end;

procedure TjdxSankey.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
end;

procedure TjdxSankey.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
end;

procedure TjdxSankey.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxSankey.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
end;

procedure TjdxSankey.Set_sortData(const Value: JSValue);
begin
  FsortData := Value;
end;

procedure TjdxSankey.Set_sourceField(const Value: string);
begin
  FsourceField := Value;
end;

procedure TjdxSankey.Set_targetField(const Value: string);
begin
  FtargetField := Value;
end;

procedure TjdxSankey.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
end;

procedure TjdxSankey.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
end;

procedure TjdxSankey.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
end;

procedure TjdxSankey.Set_weightField(const Value: string);
begin
  FweightField := Value;
end;

procedure TjdxSankey.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxSankey.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxSankey.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
end;

procedure TjdxSankey.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
end;

procedure TjdxSankey.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
end;

procedure TjdxSankey.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
end;

procedure TjdxSankey.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
end;

procedure TjdxSankey.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxSankey.Set_onLinkClick(const Value: TdxEventHandler);
begin
  FonLinkClick := Value;
end;

procedure TjdxSankey.Set_onLinkHoverChanged(const Value: TdxEventHandler);
begin
  FonLinkHoverChanged := Value;
end;

procedure TjdxSankey.Set_onNodeClick(const Value: TdxEventHandler);
begin
  FonNodeClick := Value;
end;

procedure TjdxSankey.Set_onNodeHoverChanged(const Value: TdxEventHandler);
begin
  FonNodeHoverChanged := Value;
end;

procedure TjdxSankey.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

end.
