unit DevExtreme.Bullet;

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
  TjdxBullet = class(TjdxCustomControl)
  private
    Fcolor: string;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FendScaleValue: integer;
    Fexport: TJSObject;
    Fheight_: JSValue;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    FpathModified: boolean;
    FredrawOnResize: boolean;
    FrtlEnabled: boolean;
    FshowTarget: boolean;
    FshowZeroLevel: boolean;
    Fsize: TJSObject;
    FstartScaleValue: integer;
    Ftarget: integer;
    FtargetColor: string;
    FtargetWidth: integer;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    Fvalue: integer;
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
    FonTooltipHidden: TdxEventHandler;
    FonTooltipShown: TdxEventHandler;
  private
    procedure Set_color(const value: string);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_endScaleValue(const value: integer);
    procedure Set_export(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_pathModified(const value: boolean);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_showTarget(const value: boolean);
    procedure Set_showZeroLevel(const value: boolean);
    procedure Set_size(const value: TJSObject);
    procedure Set_startScaleValue(const value: integer);
    procedure Set_target(const value: integer);
    procedure Set_targetColor(const value: string);
    procedure Set_targetWidth(const value: integer);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_value(const value: integer);
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
    procedure Set_onTooltipHidden(const value: TdxEventHandler);
    procedure Set_onTooltipShown(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property height_: JSValue read Fheight_ write Set_height_;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property size: TJSObject read Fsize write Set_size;
    property theme: JSValue read Ftheme write Set_theme;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property color: string read Fcolor write Set_color;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property endScaleValue: integer read FendScaleValue write Set_endScaleValue;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showTarget: boolean read FshowTarget write Set_showTarget default true;
    property showZeroLevel: boolean read FshowZeroLevel write Set_showZeroLevel default true;
    property startScaleValue: integer read FstartScaleValue write Set_startScaleValue;
    property target: integer read Ftarget write Set_target;
    property targetColor: string read FtargetColor write Set_targetColor;
    property targetWidth: integer read FtargetWidth write Set_targetWidth;
    property value: integer read Fvalue write Set_value;
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


constructor TjdxBullet.Create(aOwner: TComponent);
begin
  inherited;
  Fcolor := '';
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FendScaleValue := 0;
  Fexport := TJSObject.new;
  Fheight_ := nil;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  FpathModified := false;
  FredrawOnResize := true;
  FrtlEnabled := false;
  FshowTarget := true;
  FshowZeroLevel := true;
  Fsize := TJSObject.new;
  FstartScaleValue := 0;
  Ftarget := 0;
  FtargetColor := '';
  FtargetWidth := 0;
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  Fvalue := 0;
  Fwidth_ := nil;

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

procedure TjdxBullet.Set_color(const Value: string);
begin
  Fcolor := Value;
end;

procedure TjdxBullet.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxBullet.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxBullet.Set_endScaleValue(const Value: integer);
begin
  FendScaleValue := Value;
end;

procedure TjdxBullet.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
end;

procedure TjdxBullet.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxBullet.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
end;

procedure TjdxBullet.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
end;

procedure TjdxBullet.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
end;

procedure TjdxBullet.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
end;

procedure TjdxBullet.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxBullet.Set_showTarget(const Value: boolean);
begin
  FshowTarget := Value;
end;

procedure TjdxBullet.Set_showZeroLevel(const Value: boolean);
begin
  FshowZeroLevel := Value;
end;

procedure TjdxBullet.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
end;

procedure TjdxBullet.Set_startScaleValue(const Value: integer);
begin
  FstartScaleValue := Value;
end;

procedure TjdxBullet.Set_target(const Value: integer);
begin
  Ftarget := Value;
end;

procedure TjdxBullet.Set_targetColor(const Value: string);
begin
  FtargetColor := Value;
end;

procedure TjdxBullet.Set_targetWidth(const Value: integer);
begin
  FtargetWidth := Value;
end;

procedure TjdxBullet.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
end;

procedure TjdxBullet.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
end;

procedure TjdxBullet.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
end;

procedure TjdxBullet.Set_value(const Value: integer);
begin
  Fvalue := Value;
end;

procedure TjdxBullet.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxBullet.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxBullet.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
end;

procedure TjdxBullet.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
end;

procedure TjdxBullet.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
end;

procedure TjdxBullet.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
end;

procedure TjdxBullet.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
end;

procedure TjdxBullet.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxBullet.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxBullet.Set_onTooltipHidden(const Value: TdxEventHandler);
begin
  FonTooltipHidden := Value;
end;

procedure TjdxBullet.Set_onTooltipShown(const Value: TdxEventHandler);
begin
  FonTooltipShown := Value;
end;

end.
