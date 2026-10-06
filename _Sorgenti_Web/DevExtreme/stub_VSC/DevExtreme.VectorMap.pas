unit DevExtreme.VectorMap;

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
  TjdxVectorMap = class(TjdxCustomControl)
  private
    Fannotations: TJSArray;
    Fbackground: TJSObject;
    Fbounds: TJSArray;
    Fcenter: TJSArray;
    FcommonAnnotationSettings: TJSObject;
    FcontrolBar: TJSObject;
    FcustomizeAnnotation: TJSFunction;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    Fheight_: JSValue;
    Flayers: TJSArray;
    Flegends: TJSArray;
    FloadingIndicator: TJSObject;
    Fmargin: TJSObject;
    FmaxZoomFactor: integer;
    FpanningEnabled: boolean;
    FpathModified: boolean;
    Fprojection: TJSObject;
    FredrawOnResize: boolean;
    FrtlEnabled: boolean;
    Fsize: TJSObject;
    Ftheme: JSValue;
    Ftitle: TJSObject;
    Ftooltip: TJSObject;
    FtouchEnabled: boolean;
    FwheelEnabled: boolean;
    Fwidth_: JSValue;
    FzoomFactor: integer;
    FzoomingEnabled: boolean;
  private
    FonCenterChanged: TdxEventHandler;
    FonClick: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonDrawn: TdxEventHandler;
    FonExported: TdxEventHandler;
    FonExporting: TdxEventHandler;
    FonFileSaving: TdxEventHandler;
    FonIncidentOccurred: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
    FonTooltipHidden: TdxEventHandler;
    FonTooltipShown: TdxEventHandler;
    FonZoomFactorChanged: TdxEventHandler;
  private
    procedure Set_annotations(const value: TJSArray);
    procedure Set_background(const value: TJSObject);
    procedure Set_bounds(const value: TJSArray);
    procedure Set_center(const value: TJSArray);
    procedure Set_commonAnnotationSettings(const value: TJSObject);
    procedure Set_controlBar(const value: TJSObject);
    procedure Set_customizeAnnotation(const value: TJSFunction);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_height_(const value: JSValue);
    procedure Set_layers(const value: TJSArray);
    procedure Set_legends(const value: TJSArray);
    procedure Set_loadingIndicator(const value: TJSObject);
    procedure Set_margin(const value: TJSObject);
    procedure Set_maxZoomFactor(const value: integer);
    procedure Set_panningEnabled(const value: boolean);
    procedure Set_pathModified(const value: boolean);
    procedure Set_projection(const value: TJSObject);
    procedure Set_redrawOnResize(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_size(const value: TJSObject);
    procedure Set_theme(const value: JSValue);
    procedure Set_title(const value: TJSObject);
    procedure Set_tooltip(const value: TJSObject);
    procedure Set_touchEnabled(const value: boolean);
    procedure Set_wheelEnabled(const value: boolean);
    procedure Set_width_(const value: JSValue);
    procedure Set_zoomFactor(const value: integer);
    procedure Set_zoomingEnabled(const value: boolean);
  private
    procedure Set_onCenterChanged(const value: TdxEventHandler);
    procedure Set_onClick(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onDrawn(const value: TdxEventHandler);
    procedure Set_onExported(const value: TdxEventHandler);
    procedure Set_onExporting(const value: TdxEventHandler);
    procedure Set_onFileSaving(const value: TdxEventHandler);
    procedure Set_onIncidentOccurred(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
    procedure Set_onTooltipHidden(const value: TdxEventHandler);
    procedure Set_onTooltipShown(const value: TdxEventHandler);
    procedure Set_onZoomFactorChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property annotations: TJSArray read Fannotations write Set_annotations;
    property background: TJSObject read Fbackground write Set_background;
    property bounds: TJSArray read Fbounds write Set_bounds;
    property center: TJSArray read Fcenter write Set_center;
    property commonAnnotationSettings: TJSObject read FcommonAnnotationSettings write Set_commonAnnotationSettings;
    property controlBar: TJSObject read FcontrolBar write Set_controlBar;
    property customizeAnnotation: TJSFunction read FcustomizeAnnotation write Set_customizeAnnotation;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property height_: JSValue read Fheight_ write Set_height_;
    property layers: TJSArray read Flayers write Set_layers;
    property legends: TJSArray read Flegends write Set_legends;
    property loadingIndicator: TJSObject read FloadingIndicator write Set_loadingIndicator;
    property margin: TJSObject read Fmargin write Set_margin;
    property projection: TJSObject read Fprojection write Set_projection;
    property size: TJSObject read Fsize write Set_size;
    property theme: JSValue read Ftheme write Set_theme;
    property title: TJSObject read Ftitle write Set_title;
    property tooltip: TJSObject read Ftooltip write Set_tooltip;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property maxZoomFactor: integer read FmaxZoomFactor write Set_maxZoomFactor;
    property panningEnabled: boolean read FpanningEnabled write Set_panningEnabled default true;
    property pathModified: boolean read FpathModified write Set_pathModified default false;
    property redrawOnResize: boolean read FredrawOnResize write Set_redrawOnResize default true;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property touchEnabled: boolean read FtouchEnabled write Set_touchEnabled default true;
    property wheelEnabled: boolean read FwheelEnabled write Set_wheelEnabled default true;
    property zoomFactor: integer read FzoomFactor write Set_zoomFactor;
    property zoomingEnabled: boolean read FzoomingEnabled write Set_zoomingEnabled default true;
  published
    property onCenterChanged: TdxEventHandler read FonCenterChanged write Set_onCenterChanged;
    property onClick: TdxEventHandler read FonClick write Set_onClick;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onDrawn: TdxEventHandler read FonDrawn write Set_onDrawn;
    property onExported: TdxEventHandler read FonExported write Set_onExported;
    property onExporting: TdxEventHandler read FonExporting write Set_onExporting;
    property onFileSaving: TdxEventHandler read FonFileSaving write Set_onFileSaving;
    property onIncidentOccurred: TdxEventHandler read FonIncidentOccurred write Set_onIncidentOccurred;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
    property onTooltipHidden: TdxEventHandler read FonTooltipHidden write Set_onTooltipHidden;
    property onTooltipShown: TdxEventHandler read FonTooltipShown write Set_onTooltipShown;
    property onZoomFactorChanged: TdxEventHandler read FonZoomFactorChanged write Set_onZoomFactorChanged;
  end;

implementation


constructor TjdxVectorMap.Create(aOwner: TComponent);
begin
  inherited;
  Fannotations := TJSArray.new;
  Fbackground := TJSObject.new;
  Fbounds := TJSArray.new;
  Fcenter := TJSArray.new;
  FcommonAnnotationSettings := TJSObject.new;
  FcontrolBar := TJSObject.new;
  FcustomizeAnnotation := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  Fheight_ := nil;
  Flayers := TJSArray.new;
  Flegends := TJSArray.new;
  FloadingIndicator := TJSObject.new;
  Fmargin := TJSObject.new;
  FmaxZoomFactor := 0;
  FpanningEnabled := true;
  FpathModified := false;
  Fprojection := TJSObject.new;
  FredrawOnResize := true;
  FrtlEnabled := false;
  Fsize := TJSObject.new;
  Ftheme := nil;
  Ftitle := TJSObject.new;
  Ftooltip := TJSObject.new;
  FtouchEnabled := true;
  FwheelEnabled := true;
  Fwidth_ := nil;
  FzoomFactor := 0;
  FzoomingEnabled := true;

  FonCenterChanged := nil;
  FonClick := nil;
  FonDisposing := nil;
  FonDrawn := nil;
  FonExported := nil;
  FonExporting := nil;
  FonFileSaving := nil;
  FonIncidentOccurred := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonSelectionChanged := nil;
  FonTooltipHidden := nil;
  FonTooltipShown := nil;
  FonZoomFactorChanged := nil;
end;

procedure TjdxVectorMap.Set_annotations(const Value: TJSArray);
begin
  Fannotations := Value;
end;

procedure TjdxVectorMap.Set_background(const Value: TJSObject);
begin
  Fbackground := Value;
end;

procedure TjdxVectorMap.Set_bounds(const Value: TJSArray);
begin
  Fbounds := Value;
end;

procedure TjdxVectorMap.Set_center(const Value: TJSArray);
begin
  Fcenter := Value;
end;

procedure TjdxVectorMap.Set_commonAnnotationSettings(const Value: TJSObject);
begin
  FcommonAnnotationSettings := Value;
end;

procedure TjdxVectorMap.Set_controlBar(const Value: TJSObject);
begin
  FcontrolBar := Value;
end;

procedure TjdxVectorMap.Set_customizeAnnotation(const Value: TJSFunction);
begin
  FcustomizeAnnotation := Value;
end;

procedure TjdxVectorMap.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxVectorMap.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxVectorMap.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
end;

procedure TjdxVectorMap.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxVectorMap.Set_layers(const Value: TJSArray);
begin
  Flayers := Value;
end;

procedure TjdxVectorMap.Set_legends(const Value: TJSArray);
begin
  Flegends := Value;
end;

procedure TjdxVectorMap.Set_loadingIndicator(const Value: TJSObject);
begin
  FloadingIndicator := Value;
end;

procedure TjdxVectorMap.Set_margin(const Value: TJSObject);
begin
  Fmargin := Value;
end;

procedure TjdxVectorMap.Set_maxZoomFactor(const Value: integer);
begin
  FmaxZoomFactor := Value;
end;

procedure TjdxVectorMap.Set_panningEnabled(const Value: boolean);
begin
  FpanningEnabled := Value;
end;

procedure TjdxVectorMap.Set_pathModified(const Value: boolean);
begin
  FpathModified := Value;
end;

procedure TjdxVectorMap.Set_projection(const Value: TJSObject);
begin
  Fprojection := Value;
end;

procedure TjdxVectorMap.Set_redrawOnResize(const Value: boolean);
begin
  FredrawOnResize := Value;
end;

procedure TjdxVectorMap.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxVectorMap.Set_size(const Value: TJSObject);
begin
  Fsize := Value;
end;

procedure TjdxVectorMap.Set_theme(const Value: JSValue);
begin
  Ftheme := Value;
end;

procedure TjdxVectorMap.Set_title(const Value: TJSObject);
begin
  Ftitle := Value;
end;

procedure TjdxVectorMap.Set_tooltip(const Value: TJSObject);
begin
  Ftooltip := Value;
end;

procedure TjdxVectorMap.Set_touchEnabled(const Value: boolean);
begin
  FtouchEnabled := Value;
end;

procedure TjdxVectorMap.Set_wheelEnabled(const Value: boolean);
begin
  FwheelEnabled := Value;
end;

procedure TjdxVectorMap.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxVectorMap.Set_zoomFactor(const Value: integer);
begin
  FzoomFactor := Value;
end;

procedure TjdxVectorMap.Set_zoomingEnabled(const Value: boolean);
begin
  FzoomingEnabled := Value;
end;

procedure TjdxVectorMap.Set_onCenterChanged(const Value: TdxEventHandler);
begin
  FonCenterChanged := Value;
end;

procedure TjdxVectorMap.Set_onClick(const Value: TdxEventHandler);
begin
  FonClick := Value;
end;

procedure TjdxVectorMap.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxVectorMap.Set_onDrawn(const Value: TdxEventHandler);
begin
  FonDrawn := Value;
end;

procedure TjdxVectorMap.Set_onExported(const Value: TdxEventHandler);
begin
  FonExported := Value;
end;

procedure TjdxVectorMap.Set_onExporting(const Value: TdxEventHandler);
begin
  FonExporting := Value;
end;

procedure TjdxVectorMap.Set_onFileSaving(const Value: TdxEventHandler);
begin
  FonFileSaving := Value;
end;

procedure TjdxVectorMap.Set_onIncidentOccurred(const Value: TdxEventHandler);
begin
  FonIncidentOccurred := Value;
end;

procedure TjdxVectorMap.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxVectorMap.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxVectorMap.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
end;

procedure TjdxVectorMap.Set_onTooltipHidden(const Value: TdxEventHandler);
begin
  FonTooltipHidden := Value;
end;

procedure TjdxVectorMap.Set_onTooltipShown(const Value: TdxEventHandler);
begin
  FonTooltipShown := Value;
end;

procedure TjdxVectorMap.Set_onZoomFactorChanged(const Value: TdxEventHandler);
begin
  FonZoomFactorChanged := Value;
end;

end.
