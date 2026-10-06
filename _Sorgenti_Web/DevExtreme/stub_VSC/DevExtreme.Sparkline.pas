unit DevExtreme.Sparkline;

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
  TjdxSparkline = class(TjdxCustomControl)
  private
    FargumentField: string;
    FbarNegativeColor: string;
    FbarPositiveColor: string;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    FfirstLastColor: string;
    Fheight_: JSValue;
    FignoreEmptyPoints: boolean;
    FlineColor: string;
    FlineWidth: integer;
    FloadingIndicator: TJSObject;
    FlossColor: string;
    Fmargin: TJSObject;
    FmaxColor: string;
    FmaxValue: integer;
    FminColor: string;
    FminValue: integer;
    FpathModified: boolean;
    FpointColor: string;
    FpointSize: integer;
    FpointSymbol: JSValue;
    FredrawOnResize: boolean;
    FrtlEnabled: boolean;
    FshowFirstLast: boolean;
    FshowMinMax: boolean;
    Fsize: TJSObject;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    Ftype_: TdxSparklineType;
    FvalueField: string;
    Fwidth_: JSValue;
    FwinColor: string;
    FwinlossThreshold: integer;
  private
    FonDisposing: TdxEventHandler;
    FonDrawn: TdxEventHandler;
    FonExported: TdxEventHandler;
    FonExporting: TdxEventHandler;
    FonFileSaving: TdxEventHandler;
    FonIncidentOccurred: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonTooltipHidden: TdxEventHandler;
    FonTooltipShown: TdxEventHandler;
  private
    procedure Set_argumentField(const value: string);
    procedure Set_barNegativeColor(const value: string);
    procedure Set_barPositiveColor(const value: string);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_firstLastColor(const value: string);
    procedure Set_height_(const value: JSValue);
    procedure Set_ignoreEmptyPoints(const value: boolean);
    procedure Set_lineColor(const value: string);
    procedure Set_lineWidth(const value: integer);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_lossColor(const value: string);
    procedure Set_margin(const value: TJSObject);
    procedure Set_maxColor(const value: string);
    procedure Set_maxValue(const value: integer);
    procedure Set_minColor(const value: string);
    procedure Set_minValue(const value: integer);
    procedure Set_pathModified(const value: boolean);
    procedure Set_pointColor(const value: string);
    procedure Set_pointSize(const value: integer);
    procedure Set_pointSymbol(const value: JSValue);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_showFirstLast(const value: boolean);
    procedure Set_showMinMax(const value: boolean);
    procedure Set_size(const value: TJSObject);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_type_(const value: TdxSparklineType);
    procedure Set_valueField(const value: string);
    procedure Set_width_(const value: JSValue);
    procedure Set_winColor(const value: string);
    procedure Set_winlossThreshold(const value: integer);
  private
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onDrawn(const value: TdxEventHandler);
    procedure Set_onExported(const value: TdxEventHandler);
    procedure Set_onExporting(const value: TdxEventHandler);
    procedure Set_onFileSaving(const value: TdxEventHandler);
    procedure Set_onIncidentOccurred(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onTooltipHidden(const value: TdxEventHandler);
    procedure Set_onTooltipShown(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property height_: JSValue read Fheight_ write Set_height_;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property pointSymbol: JSValue read FpointSymbol write Set_pointSymbol;
    property size: TJSObject read Fsize write Set_size;
    property theme: JSValue read Ftheme write Set_theme;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property argumentField: string read FargumentField write Set_argumentField;
    property barNegativeColor: string read FbarNegativeColor write Set_barNegativeColor;
    property barPositiveColor: string read FbarPositiveColor write Set_barPositiveColor;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property firstLastColor: string read FfirstLastColor write Set_firstLastColor;
    property ignoreEmptyPoints: boolean read FignoreEmptyPoints write Set_ignoreEmptyPoints default false;
    property lineColor: string read FlineColor write Set_lineColor;
    property lineWidth: integer read FlineWidth write Set_lineWidth;
    property lossColor: string read FlossColor write Set_lossColor;
    property maxColor: string read FmaxColor write Set_maxColor;
    property maxValue: integer read FmaxValue write Set_maxValue;
    property minColor: string read FminColor write Set_minColor;
    property minValue: integer read FminValue write Set_minValue;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property pointColor: string read FpointColor write Set_pointColor;
    property pointSize: integer read FpointSize write Set_pointSize;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showFirstLast: boolean read FshowFirstLast write Set_showFirstLast default true;
    property showMinMax: boolean read FshowMinMax write Set_showMinMax default false;
    property type_: TdxSparklineType read Ftype_ write Set_type_ default stLine;
    property valueField: string read FvalueField write Set_valueField;
    property winColor: string read FwinColor write Set_winColor;
    property winlossThreshold: integer read FwinlossThreshold write Set_winlossThreshold;
  published
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onDrawn: TdxEventHandler read FonDrawn write Set_onDrawn;
    property onExported: TdxEventHandler read FonExported write Set_onExported;
    property onExporting: TdxEventHandler read FonExporting write Set_onExporting;
    property onFileSaving: TdxEventHandler read FonFileSaving write Set_onFileSaving;
    property onIncidentOccurred: TdxEventHandler read FonIncidentOccurred write Set_onIncidentOccurred;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onTooltipHidden: TdxEventHandler read FonTooltipHidden write Set_onTooltipHidden;
    property onTooltipShown: TdxEventHandler read FonTooltipShown write Set_onTooltipShown;
  end;

implementation


constructor TjdxSparkline.Create(aOwner: TComponent);
begin
  inherited;
  FargumentField := '';
  FbarNegativeColor := '';
  FbarPositiveColor := '';
  FdataSource := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  FfirstLastColor := '';
  Fheight_ := nil;
  FignoreEmptyPoints := false;
  FlineColor := '';
  FlineWidth := 0;
  FloadingIndicator := TJSObject.new;
  FlossColor := '';
  Fmargin := TJSObject.new;
  FmaxColor := '';
  FmaxValue := 0;
  FminColor := '';
  FminValue := 0;
  FpathModified := false;
  FpointColor := '';
  FpointSize := 0;
  FpointSymbol := nil;
  FredrawOnResize := true;
  FrtlEnabled := false;
  FshowFirstLast := true;
  FshowMinMax := false;
  Fsize := TJSObject.new;
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  Ftype_ := stLine;
  FvalueField := '';
  Fwidth_ := nil;
  FwinColor := '';
  FwinlossThreshold := 0;

  FonDisposing := nil;
  FonDrawn := nil;
  FonExported := nil;
  FonExporting := nil;
  FonFileSaving := nil;
  FonIncidentOccurred := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonTooltipHidden := nil;
  FonTooltipShown := nil;
end;

procedure TjdxSparkline.Set_argumentField(const Value: string);
begin
  FargumentField := Value;
end;

procedure TjdxSparkline.Set_barNegativeColor(const Value: string);
begin
  FbarNegativeColor := Value;
end;

procedure TjdxSparkline.Set_barPositiveColor(const Value: string);
begin
  FbarPositiveColor := Value;
end;

procedure TjdxSparkline.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxSparkline.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxSparkline.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxSparkline.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
end;

procedure TjdxSparkline.Set_firstLastColor(const Value: string);
begin
  FfirstLastColor := Value;
end;

procedure TjdxSparkline.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxSparkline.Set_ignoreEmptyPoints(const Value: boolean);
begin
  FignoreEmptyPoints := Value;
end;

procedure TjdxSparkline.Set_lineColor(const Value: string);
begin
  FlineColor := Value;
end;

procedure TjdxSparkline.Set_lineWidth(const Value: integer);
begin
  FlineWidth := Value;
end;

procedure TjdxSparkline.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
end;

procedure TjdxSparkline.Set_lossColor(const Value: string);
begin
  FlossColor := Value;
end;

procedure TjdxSparkline.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
end;

procedure TjdxSparkline.Set_maxColor(const Value: string);
begin
  FmaxColor := Value;
end;

procedure TjdxSparkline.Set_maxValue(const Value: integer);
begin
  FmaxValue := Value;
end;

procedure TjdxSparkline.Set_minColor(const Value: string);
begin
  FminColor := Value;
end;

procedure TjdxSparkline.Set_minValue(const Value: integer);
begin
  FminValue := Value;
end;

procedure TjdxSparkline.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
end;

procedure TjdxSparkline.Set_pointColor(const Value: string);
begin
  FpointColor := Value;
end;

procedure TjdxSparkline.Set_pointSize(const Value: integer);
begin
  FpointSize := Value;
end;

procedure TjdxSparkline.Set_pointSymbol(const Value: JSValue);
begin
  FpointSymbol := Value;
end;

procedure TjdxSparkline.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
end;

procedure TjdxSparkline.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxSparkline.Set_showFirstLast(const Value: boolean);
begin
  FshowFirstLast := Value;
end;

procedure TjdxSparkline.Set_showMinMax(const Value: boolean);
begin
  FshowMinMax := Value;
end;

procedure TjdxSparkline.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
end;

procedure TjdxSparkline.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
end;

procedure TjdxSparkline.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
end;

procedure TjdxSparkline.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
end;

procedure TjdxSparkline.Set_type_(const Value: TdxSparklineType);
begin
  Ftype_ := Value;
end;

procedure TjdxSparkline.Set_valueField(const Value: string);
begin
  FvalueField := Value;
end;

procedure TjdxSparkline.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxSparkline.Set_winColor(const Value: string);
begin
  FwinColor := Value;
end;

procedure TjdxSparkline.Set_winlossThreshold(const Value: integer);
begin
  FwinlossThreshold := Value;
end;

procedure TjdxSparkline.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxSparkline.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
end;

procedure TjdxSparkline.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
end;

procedure TjdxSparkline.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
end;

procedure TjdxSparkline.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
end;

procedure TjdxSparkline.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
end;

procedure TjdxSparkline.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxSparkline.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxSparkline.Set_onTooltipHidden(const Value: TdxEventHandler);
begin
  FonTooltipHidden := Value;
end;

procedure TjdxSparkline.Set_onTooltipShown(const Value: TdxEventHandler);
begin
  FonTooltipShown := Value;
end;

end.
