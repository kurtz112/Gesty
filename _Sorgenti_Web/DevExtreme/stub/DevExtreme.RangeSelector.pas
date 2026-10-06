unit DevExtreme.RangeSelector;

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
  TjdxRangeSelector = class(TjdxCustomControl)
  private
    Fbackground: TJSObject;
    Fbehavior: TJSObject;
    Fchart: TJSObject;
    FcontainerBackgroundColor: string;
    FdataSource: JSValue;
    FdataSourceField: string;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    Fheight_: JSValue;
    Findent: TJSObject;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    FpathModified: boolean;
    FredrawOnResize: boolean;
    FrtlEnabled: boolean;
    Fscale: TJSObject;
    FselectedRangeColor: string;
    FselectedRangeUpdateMode: JSValue;
    Fshutter: TJSObject;
    Fsize: TJSObject;
    FsliderHandle: TJSObject;
    FsliderMarker: TJSObject;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    Fvalue: TJSArray;
    Fwidth_: JSValue;
  private
    FonDisposing: TdxEventHandler;
    FonDrawn: TdxEventHandler;
    FonExported: TdxEventHandler;
    FonExporting: TdxEventHandler;
    FonFileSaving: TdxEventHandler;
    FonIncidentOccurred: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonValueChanged: TdxEventHandler;
  private
    procedure Set_background(const value: TJSObject);
    procedure Set_behavior(const value: TJSObject);
    procedure Set_chart(const value: TJSObject);
    procedure Set_containerBackgroundColor(const value: string);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_dataSourceField(const value: string);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_indent(const value: TJSObject);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_pathModified(const value: boolean);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_scale(const value: TJSObject);
    procedure Set_selectedRangeColor(const value: string);
    procedure Set_selectedRangeUpdateMode(const value: JSValue);
    procedure Set_shutter(const value: TJSObject);
    procedure Set_size(const value: TJSObject);
    procedure Set_sliderHandle(const value: TJSObject);
    procedure Set_sliderMarker(const value: TJSObject);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_value(const value: TJSArray);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onDrawn(const value: TdxEventHandler);
    procedure Set_onExported(const value: TdxEventHandler);
    procedure Set_onExporting(const value: TdxEventHandler);
    procedure Set_onFileSaving(const value: TdxEventHandler);
    procedure Set_onIncidentOccurred(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onValueChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property background: TJSObject read Fbackground write Set_background;
    property behavior: TJSObject read Fbehavior write Set_behavior;
    property chart: TJSObject read Fchart write Set_chart;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property height_: JSValue read Fheight_ write Set_height_;
    property indent: TJSObject read Findent write Set_indent;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property scale: TJSObject read Fscale write Set_scale;
    property selectedRangeUpdateMode: JSValue read FselectedRangeUpdateMode write Set_selectedRangeUpdateMode;
    property shutter: TJSObject read Fshutter write Set_shutter;
    property size: TJSObject read Fsize write Set_size;
    property sliderHandle: TJSObject read FsliderHandle write Set_sliderHandle;
    property sliderMarker: TJSObject read FsliderMarker write Set_sliderMarker;
    property theme: JSValue read Ftheme write Set_theme;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property value: TJSArray read Fvalue write Set_value;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property containerBackgroundColor: string read FcontainerBackgroundColor write Set_containerBackgroundColor;
    property dataSourceField: string read FdataSourceField write Set_dataSourceField;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property selectedRangeColor: string read FselectedRangeColor write Set_selectedRangeColor;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onDrawn: TdxEventHandler read FonDrawn write Set_onDrawn;
    property onExported: TdxEventHandler read FonExported write Set_onExported;
    property onExporting: TdxEventHandler read FonExporting write Set_onExporting;
    property onFileSaving: TdxEventHandler read FonFileSaving write Set_onFileSaving;
    property onIncidentOccurred: TdxEventHandler read FonIncidentOccurred write Set_onIncidentOccurred;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onValueChanged: TdxEventHandler read FonValueChanged write Set_onValueChanged;
  end;

implementation


constructor TjdxRangeSelector.Create(aOwner: TComponent);
begin
  inherited;
  Fbackground := TJSObject.new;
  Fbehavior := TJSObject.new;
  Fchart := TJSObject.new;
  FcontainerBackgroundColor := '';
  FdataSource := nil;
  FdataSourceField := '';
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  Fheight_ := nil;
  Findent := TJSObject.new;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  FpathModified := false;
  FredrawOnResize := true;
  FrtlEnabled := false;
  Fscale := TJSObject.new;
  FselectedRangeColor := '';
  FselectedRangeUpdateMode := nil;
  Fshutter := TJSObject.new;
  Fsize := TJSObject.new;
  FsliderHandle := TJSObject.new;
  FsliderMarker := TJSObject.new;
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  Fvalue := TJSArray.new;
  Fwidth_ := nil;

  FonDisposing := nil;
  FonDrawn := nil;
  FonExported := nil;
  FonExporting := nil;
  FonFileSaving := nil;
  FonIncidentOccurred := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonValueChanged := nil;
end;

procedure TjdxRangeSelector.Set_background(const Value: TJSObject);
begin
  Fbackground := Value;
end;

procedure TjdxRangeSelector.Set_behavior(const Value: TJSObject);
begin
  Fbehavior := Value;
end;

procedure TjdxRangeSelector.Set_chart(const Value: TJSObject);
begin
  Fchart := Value;
end;

procedure TjdxRangeSelector.Set_containerBackgroundColor(const Value: string);
begin
  FcontainerBackgroundColor := Value;
end;

procedure TjdxRangeSelector.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxRangeSelector.Set_dataSourceField(const Value: string);
begin
  FdataSourceField := Value;
end;

procedure TjdxRangeSelector.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxRangeSelector.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxRangeSelector.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
end;

procedure TjdxRangeSelector.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxRangeSelector.Set_indent(const Value: TJSObject);
begin
  Findent := Value;
end;

procedure TjdxRangeSelector.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
end;

procedure TjdxRangeSelector.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
end;

procedure TjdxRangeSelector.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
end;

procedure TjdxRangeSelector.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
end;

procedure TjdxRangeSelector.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxRangeSelector.Set_scale(const Value: TJSObject);
begin
  Fscale := Value;
end;

procedure TjdxRangeSelector.Set_selectedRangeColor(const Value: string);
begin
  FselectedRangeColor := Value;
end;

procedure TjdxRangeSelector.Set_selectedRangeUpdateMode(const Value: JSValue);
begin
  FselectedRangeUpdateMode := Value;
end;

procedure TjdxRangeSelector.Set_shutter(const Value: TJSObject);
begin
  Fshutter := Value;
end;

procedure TjdxRangeSelector.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
end;

procedure TjdxRangeSelector.Set_sliderHandle(const Value: TJSObject);
begin
  FsliderHandle := Value;
end;

procedure TjdxRangeSelector.Set_sliderMarker(const Value: TJSObject);
begin
  FsliderMarker := Value;
end;

procedure TjdxRangeSelector.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
end;

procedure TjdxRangeSelector.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
end;

procedure TjdxRangeSelector.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
end;

procedure TjdxRangeSelector.Set_value(const Value: TJSArray);
begin
  Fvalue := Value;
end;

procedure TjdxRangeSelector.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxRangeSelector.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxRangeSelector.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
end;

procedure TjdxRangeSelector.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
end;

procedure TjdxRangeSelector.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
end;

procedure TjdxRangeSelector.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
end;

procedure TjdxRangeSelector.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
end;

procedure TjdxRangeSelector.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxRangeSelector.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxRangeSelector.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
end;

end.
