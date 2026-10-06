unit DevExtreme.Diagram;

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
  TjdxDiagram = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FautoZoomMode: TdxDiagramAutoZoomMode;
    FcontextMenu: TJSObject;
    FcontextToolbox: TJSObject;
    FcustomShapes: TJSArray;
    FcustomShapeTemplate: JSValue;
    FcustomShapeToolboxTemplate: JSValue;
    FdefaultItemProperties: TJSObject;
    Fdisabled: boolean;
    Fedges: TJSObject;
    Fediting: TJSObject;
    FelementAttr: TJSObject;
    Fexport: TJSObject;
    FfocusStateEnabled: boolean;
    FfullScreen: boolean;
    FgridSize: TJSObject;
    FhasChanges: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhistoryToolbar: TJSObject;
    FhoverStateEnabled: boolean;
    FmainToolbar: TJSObject;
    Fnodes: TJSObject;
    FpageColor: string;
    FpageOrientation: TdxPageOrientation;
    FpageSize: TJSObject;
    FpropertiesPanel: TJSObject;
    FreadOnly: boolean;
    FrtlEnabled: boolean;
    FshowGrid: boolean;
    FsimpleView: boolean;
    FsnapToGrid: boolean;
    FtabIndex: integer;
    Ftoolbox: TJSObject;
    Funits: TdxDiagramUnits;
    FuseNativeScrolling: boolean;
    FviewToolbar: TJSObject;
    FviewUnits: TdxDiagramUnits;
    Fvisible: boolean;
    Fwidth_: JSValue;
    FzoomLevel: TJSObject;
  private
    FonContentReady: TdxEventHandler;
    FonCustomCommand: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonItemClick: TdxEventHandler;
    FonItemDblClick: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonRequestEditOperation: TdxEventHandler;
    FonRequestLayoutUpdate: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_autoZoomMode(const value: TdxDiagramAutoZoomMode);
    procedure Set_contextMenu(const value: TJSObject);
    procedure Set_contextToolbox(const value: TJSObject);
    procedure Set_customShapes(const value: TJSArray);
    procedure Set_customShapeTemplate(const value: JSValue);
    procedure Set_customShapeToolboxTemplate(const value: JSValue);
    procedure Set_defaultItemProperties(const value: TJSObject);
    procedure Set_disabled(const value: boolean);
    procedure Set_edges(const value: TJSObject);
    procedure Set_editing(const value: TJSObject);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_export(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_fullScreen(const value: boolean);
    procedure Set_gridSize(const value: TJSObject);
    procedure Set_hasChanges(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_historyToolbar(const value: TJSObject);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_mainToolbar(const value: TJSObject);
    procedure Set_nodes(const value: TJSObject);
    procedure Set_pageColor(const value: string);
    procedure Set_pageOrientation(const value: TdxPageOrientation);
    procedure Set_pageSize(const value: TJSObject);
    procedure Set_propertiesPanel(const value: TJSObject);
    procedure Set_readOnly(const value: boolean);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_showGrid(const value: boolean);
    procedure Set_simpleView(const value: boolean);
    procedure Set_snapToGrid(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_toolbox(const value: TJSObject);
    procedure Set_units(const value: TdxDiagramUnits);
    procedure Set_useNativeScrolling(const value: boolean);
    procedure Set_viewToolbar(const value: TJSObject);
    procedure Set_viewUnits(const value: TdxDiagramUnits);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
    procedure Set_zoomLevel(const value: TJSObject);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onCustomCommand(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onItemClick(const value: TdxEventHandler);
    procedure Set_onItemDblClick(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onRequestEditOperation(const value: TdxEventHandler);
    procedure Set_onRequestLayoutUpdate(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property contextMenu: TJSObject read FcontextMenu write Set_contextMenu;
    property contextToolbox: TJSObject read FcontextToolbox write Set_contextToolbox;
    property customShapes: TJSArray read FcustomShapes write Set_customShapes;
    property customShapeTemplate: JSValue read FcustomShapeTemplate write Set_customShapeTemplate;
    property customShapeToolboxTemplate: JSValue read FcustomShapeToolboxTemplate write Set_customShapeToolboxTemplate;
    property defaultItemProperties: TJSObject read FdefaultItemProperties write Set_defaultItemProperties;
    property edges: TJSObject read Fedges write Set_edges;
    property editing: TJSObject read Fediting write Set_editing;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property export: TJSObject read Fexport write Set_export;
    property gridSize: TJSObject read FgridSize write Set_gridSize;
    property height_: JSValue read Fheight_ write Set_height_;
    property historyToolbar: TJSObject read FhistoryToolbar write Set_historyToolbar;
    property mainToolbar: TJSObject read FmainToolbar write Set_mainToolbar;
    property nodes: TJSObject read Fnodes write Set_nodes;
    property pageSize: TJSObject read FpageSize write Set_pageSize;
    property propertiesPanel: TJSObject read FpropertiesPanel write Set_propertiesPanel;
    property toolbox: TJSObject read Ftoolbox write Set_toolbox;
    property viewToolbar: TJSObject read FviewToolbar write Set_viewToolbar;
    property width_: JSValue read Fwidth_ write Set_width_;
    property zoomLevel: TJSObject read FzoomLevel write Set_zoomLevel;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property autoZoomMode: TdxDiagramAutoZoomMode read FautoZoomMode write Set_autoZoomMode default dazmDisabled;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property fullScreen: boolean read FfullScreen write Set_fullScreen default false;
    property hasChanges: boolean read FhasChanges write Set_hasChanges default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property pageColor: string read FpageColor write Set_pageColor;
    property pageOrientation: TdxPageOrientation read FpageOrientation write Set_pageOrientation default poPortrait;
    property readOnly: boolean read FreadOnly write Set_readOnly default false;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property showGrid: boolean read FshowGrid write Set_showGrid default true;
    property simpleView: boolean read FsimpleView write Set_simpleView default false;
    property snapToGrid: boolean read FsnapToGrid write Set_snapToGrid default true;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property units: TdxDiagramUnits read Funits write Set_units default duIn;
    property useNativeScrolling: boolean read FuseNativeScrolling write Set_useNativeScrolling;
    property viewUnits: TdxDiagramUnits read FviewUnits write Set_viewUnits default duIn;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onCustomCommand: TdxEventHandler read FonCustomCommand write Set_onCustomCommand;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onItemClick: TdxEventHandler read FonItemClick write Set_onItemClick;
    property onItemDblClick: TdxEventHandler read FonItemDblClick write Set_onItemDblClick;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onRequestEditOperation: TdxEventHandler read FonRequestEditOperation write Set_onRequestEditOperation;
    property onRequestLayoutUpdate: TdxEventHandler read FonRequestLayoutUpdate write Set_onRequestLayoutUpdate;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
  end;

implementation


constructor TjdxDiagram.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FautoZoomMode := dazmDisabled;
  FcontextMenu := TJSObject.new;
  FcontextToolbox := TJSObject.new;
  FcustomShapes := TJSArray.new;
  FcustomShapeTemplate := nil;
  FcustomShapeToolboxTemplate := nil;
  FdefaultItemProperties := TJSObject.new;
  Fdisabled := false;
  Fedges := TJSObject.new;
  Fediting := TJSObject.new;
  FelementAttr := TJSObject.new;
  Fexport := TJSObject.new;
  FfocusStateEnabled := false;
  FfullScreen := false;
  FgridSize := TJSObject.new;
  FhasChanges := false;
  Fheight_ := nil;
  Fhint := '';
  FhistoryToolbar := TJSObject.new;
  FhoverStateEnabled := false;
  FmainToolbar := TJSObject.new;
  Fnodes := TJSObject.new;
  FpageColor := '';
  FpageOrientation := poPortrait;
  FpageSize := TJSObject.new;
  FpropertiesPanel := TJSObject.new;
  FreadOnly := false;
  FrtlEnabled := false;
  FshowGrid := true;
  FsimpleView := false;
  FsnapToGrid := true;
  FtabIndex := 0;
  Ftoolbox := TJSObject.new;
  Funits := duIn;
  FuseNativeScrolling := false;
  FviewToolbar := TJSObject.new;
  FviewUnits := duIn;
  Fvisible := true;
  Fwidth_ := nil;
  FzoomLevel := TJSObject.new;

  FonContentReady := nil;
  FonCustomCommand := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonItemClick := nil;
  FonItemDblClick := nil;
  FonOptionChanged := nil;
  FonRequestEditOperation := nil;
  FonRequestLayoutUpdate := nil;
  FonSelectionChanged := nil;
end;

procedure TjdxDiagram.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxDiagram.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxDiagram.Set_autoZoomMode(const Value: TdxDiagramAutoZoomMode);
begin
  FautoZoomMode := Value;
end;

procedure TjdxDiagram.Set_contextMenu(const Value: TJSObject);
begin
  FcontextMenu := Value;
end;

procedure TjdxDiagram.Set_contextToolbox(const Value: TJSObject);
begin
  FcontextToolbox := Value;
end;

procedure TjdxDiagram.Set_customShapes(const Value: TJSArray);
begin
  FcustomShapes := Value;
end;

procedure TjdxDiagram.Set_customShapeTemplate(const Value: JSValue);
begin
  FcustomShapeTemplate := Value;
end;

procedure TjdxDiagram.Set_customShapeToolboxTemplate(const Value: JSValue);
begin
  FcustomShapeToolboxTemplate := Value;
end;

procedure TjdxDiagram.Set_defaultItemProperties(const Value: TJSObject);
begin
  FdefaultItemProperties := Value;
end;

procedure TjdxDiagram.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxDiagram.Set_edges(const Value: TJSObject);
begin
  Fedges := Value;
end;

procedure TjdxDiagram.Set_editing(const Value: TJSObject);
begin
  Fediting := Value;
end;

procedure TjdxDiagram.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxDiagram.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
end;

procedure TjdxDiagram.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxDiagram.Set_fullScreen(const Value: boolean);
begin
  FfullScreen := Value;
end;

procedure TjdxDiagram.Set_gridSize(const Value: TJSObject);
begin
  FgridSize := Value;
end;

procedure TjdxDiagram.Set_hasChanges(const Value: boolean);
begin
  FhasChanges := Value;
end;

procedure TjdxDiagram.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxDiagram.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxDiagram.Set_historyToolbar(const Value: TJSObject);
begin
  FhistoryToolbar := Value;
end;

procedure TjdxDiagram.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxDiagram.Set_mainToolbar(const Value: TJSObject);
begin
  FmainToolbar := Value;
end;

procedure TjdxDiagram.Set_nodes(const Value: TJSObject);
begin
  Fnodes := Value;
end;

procedure TjdxDiagram.Set_pageColor(const Value: string);
begin
  FpageColor := Value;
end;

procedure TjdxDiagram.Set_pageOrientation(const Value: TdxPageOrientation);
begin
  FpageOrientation := Value;
end;

procedure TjdxDiagram.Set_pageSize(const Value: TJSObject);
begin
  FpageSize := Value;
end;

procedure TjdxDiagram.Set_propertiesPanel(const Value: TJSObject);
begin
  FpropertiesPanel := Value;
end;

procedure TjdxDiagram.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
end;

procedure TjdxDiagram.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxDiagram.Set_showGrid(const Value: boolean);
begin
  FshowGrid := Value;
end;

procedure TjdxDiagram.Set_simpleView(const Value: boolean);
begin
  FsimpleView := Value;
end;

procedure TjdxDiagram.Set_snapToGrid(const Value: boolean);
begin
  FsnapToGrid := Value;
end;

procedure TjdxDiagram.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxDiagram.Set_toolbox(const Value: TJSObject);
begin
  Ftoolbox := Value;
end;

procedure TjdxDiagram.Set_units(const Value: TdxDiagramUnits);
begin
  Funits := Value;
end;

procedure TjdxDiagram.Set_useNativeScrolling(const Value: boolean);
begin
  FuseNativeScrolling := Value;
end;

procedure TjdxDiagram.Set_viewToolbar(const Value: TJSObject);
begin
  FviewToolbar := Value;
end;

procedure TjdxDiagram.Set_viewUnits(const Value: TdxDiagramUnits);
begin
  FviewUnits := Value;
end;

procedure TjdxDiagram.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxDiagram.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxDiagram.Set_zoomLevel(const Value: TJSObject);
begin
  FzoomLevel := Value;
end;

procedure TjdxDiagram.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxDiagram.Set_onCustomCommand(const Value: TdxEventHandler);
begin
  FonCustomCommand := Value;
end;

procedure TjdxDiagram.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxDiagram.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxDiagram.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxDiagram.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxDiagram.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
end;

procedure TjdxDiagram.Set_onItemDblClick(const Value: TdxEventHandler);
begin
  FonItemDblClick := Value;
end;

procedure TjdxDiagram.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxDiagram.Set_onRequestEditOperation(const Value: TdxEventHandler);
begin
  FonRequestEditOperation := Value;
end;

procedure TjdxDiagram.Set_onRequestLayoutUpdate(const Value: TdxEventHandler);
begin
  FonRequestLayoutUpdate := Value;
end;

procedure TjdxDiagram.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
end;

end.
