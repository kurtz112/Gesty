unit DevExtreme.Diagram.Custom;

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
  DevExtreme.Diagram.JS,
  DevExtreme.Types;

type
  TjdxCustomDiagram = class(TjdxCustomControl)
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
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxDiagram; assembler;
    function instance: TdxDiagram; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    function export_(): string; assembler;
    procedure exportTo(format: JSValue; callback: TJSFunction); assembler;
    procedure fitToContent(); assembler;
    procedure fitToWidth(); assembler;
    procedure focus(); assembler;
    function getEdgeDataSource(): TJSObject; assembler;
    function getItemById(id: string): JSValue; assembler;
    function getItemByKey(key: TJSObject): JSValue; assembler;
    function getItems(): TJSArray; assembler;
    function getNodeDataSource(): TJSObject; assembler;
    function getSelectedItems(): TJSArray; assembler;
    procedure import(data: string; updateExistingItemsOnly: boolean); assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure registerKeyHandler(); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler; overload;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure scrollToItem(item: JSValue); assembler;
    procedure setSelectedItems(items: TJSArray); assembler;
    procedure updateToolbox(); assembler;
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


procedure TjdxCustomDiagram.CreateInitialize;
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
procedure TjdxCustomDiagram.InitJQuery;
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
      $(id).dxDiagram(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomDiagram.getInstance(element: TJSObject): TdxDiagram;
asm
  return DevExpress.viz.dxDiagram.getInstance(element);
end;

function TjdxCustomDiagram.instance: TdxDiagram;
asm
  return $(this.GetJQID()).dxDiagram("instance");
end;
procedure TjdxCustomDiagram.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('autoZoomMode', autoZoomMode.ToString());
    SetOption('contextMenu', contextMenu);
    SetOption('contextToolbox', contextToolbox);
    SetOption('customShapes', customShapes);
    SetOption('customShapeTemplate', customShapeTemplate);
    SetOption('customShapeToolboxTemplate', customShapeToolboxTemplate);
    SetOption('defaultItemProperties', defaultItemProperties);
    SetOption('disabled', disabled);
    SetOption('edges', edges);
    SetOption('editing', editing);
    SetOption('elementAttr', elementAttr);
    SetOption('export', export);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('fullScreen', fullScreen);
    SetOption('gridSize', gridSize);
    SetOption('hasChanges', hasChanges);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('historyToolbar', historyToolbar);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('mainToolbar', mainToolbar);
    SetOption('nodes', nodes);
    SetOption('pageColor', pageColor);
    SetOption('pageOrientation', pageOrientation.ToString());
    SetOption('pageSize', pageSize);
    SetOption('propertiesPanel', propertiesPanel);
    SetOption('readOnly', readOnly);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('showGrid', showGrid);
    SetOption('simpleView', simpleView);
    SetOption('snapToGrid', snapToGrid);
    SetOption('tabIndex', tabIndex);
    SetOption('toolbox', toolbox);
    SetOption('units', units.ToString());
    SetOption('useNativeScrolling', useNativeScrolling);
    SetOption('viewToolbar', viewToolbar);
    SetOption('viewUnits', viewUnits.ToString());
    SetOption('visible', visible);
    SetOption('width', width_);
    SetOption('zoomLevel', zoomLevel);

    SetEvent('contentReady', onContentReady);
    SetEvent('customCommand', onCustomCommand);
    SetEvent('disposing', onDisposing);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('itemClick', onItemClick);
    SetEvent('itemDblClick', onItemDblClick);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('requestEditOperation', onRequestEditOperation);
    SetEvent('requestLayoutUpdate', onRequestLayoutUpdate);
    SetEvent('selectionChanged', onSelectionChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomDiagram.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomDiagram.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomDiagram.Set_autoZoomMode(const Value: TdxDiagramAutoZoomMode);
begin
  FautoZoomMode := Value;
  SetOption('autoZoomMode', autoZoomMode.ToString());
end;

procedure TjdxCustomDiagram.Set_contextMenu(const Value: TJSObject);
begin
  FcontextMenu := Value;
  SetOption('contextMenu', contextMenu);
end;

procedure TjdxCustomDiagram.Set_contextToolbox(const Value: TJSObject);
begin
  FcontextToolbox := Value;
  SetOption('contextToolbox', contextToolbox);
end;

procedure TjdxCustomDiagram.Set_customShapes(const Value: TJSArray);
begin
  FcustomShapes := Value;
  SetOption('customShapes', customShapes);
end;

procedure TjdxCustomDiagram.Set_customShapeTemplate(const Value: JSValue);
begin
  FcustomShapeTemplate := Value;
  SetOption('customShapeTemplate', customShapeTemplate);
end;

procedure TjdxCustomDiagram.Set_customShapeToolboxTemplate(const Value: JSValue);
begin
  FcustomShapeToolboxTemplate := Value;
  SetOption('customShapeToolboxTemplate', customShapeToolboxTemplate);
end;

procedure TjdxCustomDiagram.Set_defaultItemProperties(const Value: TJSObject);
begin
  FdefaultItemProperties := Value;
  SetOption('defaultItemProperties', defaultItemProperties);
end;

procedure TjdxCustomDiagram.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomDiagram.Set_edges(const Value: TJSObject);
begin
  Fedges := Value;
  SetOption('edges', edges);
end;

procedure TjdxCustomDiagram.Set_editing(const Value: TJSObject);
begin
  Fediting := Value;
  SetOption('editing', editing);
end;

procedure TjdxCustomDiagram.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomDiagram.Set_export(const Value: TJSObject);
begin
  Fexport := Value;
  SetOption('export', export);
end;

procedure TjdxCustomDiagram.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomDiagram.Set_fullScreen(const Value: boolean);
begin
  FfullScreen := Value;
  SetOption('fullScreen', fullScreen);
end;

procedure TjdxCustomDiagram.Set_gridSize(const Value: TJSObject);
begin
  FgridSize := Value;
  SetOption('gridSize', gridSize);
end;

procedure TjdxCustomDiagram.Set_hasChanges(const Value: boolean);
begin
  FhasChanges := Value;
  SetOption('hasChanges', hasChanges);
end;

procedure TjdxCustomDiagram.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomDiagram.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomDiagram.Set_historyToolbar(const Value: TJSObject);
begin
  FhistoryToolbar := Value;
  SetOption('historyToolbar', historyToolbar);
end;

procedure TjdxCustomDiagram.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomDiagram.Set_mainToolbar(const Value: TJSObject);
begin
  FmainToolbar := Value;
  SetOption('mainToolbar', mainToolbar);
end;

procedure TjdxCustomDiagram.Set_nodes(const Value: TJSObject);
begin
  Fnodes := Value;
  SetOption('nodes', nodes);
end;

procedure TjdxCustomDiagram.Set_pageColor(const Value: string);
begin
  FpageColor := Value;
  SetOption('pageColor', pageColor);
end;

procedure TjdxCustomDiagram.Set_pageOrientation(const Value: TdxPageOrientation);
begin
  FpageOrientation := Value;
  SetOption('pageOrientation', pageOrientation.ToString());
end;

procedure TjdxCustomDiagram.Set_pageSize(const Value: TJSObject);
begin
  FpageSize := Value;
  SetOption('pageSize', pageSize);
end;

procedure TjdxCustomDiagram.Set_propertiesPanel(const Value: TJSObject);
begin
  FpropertiesPanel := Value;
  SetOption('propertiesPanel', propertiesPanel);
end;

procedure TjdxCustomDiagram.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
  SetOption('readOnly', readOnly);
end;

procedure TjdxCustomDiagram.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomDiagram.Set_showGrid(const Value: boolean);
begin
  FshowGrid := Value;
  SetOption('showGrid', showGrid);
end;

procedure TjdxCustomDiagram.Set_simpleView(const Value: boolean);
begin
  FsimpleView := Value;
  SetOption('simpleView', simpleView);
end;

procedure TjdxCustomDiagram.Set_snapToGrid(const Value: boolean);
begin
  FsnapToGrid := Value;
  SetOption('snapToGrid', snapToGrid);
end;

procedure TjdxCustomDiagram.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomDiagram.Set_toolbox(const Value: TJSObject);
begin
  Ftoolbox := Value;
  SetOption('toolbox', toolbox);
end;

procedure TjdxCustomDiagram.Set_units(const Value: TdxDiagramUnits);
begin
  Funits := Value;
  SetOption('units', units.ToString());
end;

procedure TjdxCustomDiagram.Set_useNativeScrolling(const Value: boolean);
begin
  FuseNativeScrolling := Value;
  SetOption('useNativeScrolling', useNativeScrolling);
end;

procedure TjdxCustomDiagram.Set_viewToolbar(const Value: TJSObject);
begin
  FviewToolbar := Value;
  SetOption('viewToolbar', viewToolbar);
end;

procedure TjdxCustomDiagram.Set_viewUnits(const Value: TdxDiagramUnits);
begin
  FviewUnits := Value;
  SetOption('viewUnits', viewUnits.ToString());
end;

procedure TjdxCustomDiagram.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomDiagram.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomDiagram.Set_zoomLevel(const Value: TJSObject);
begin
  FzoomLevel := Value;
  SetOption('zoomLevel', zoomLevel);
end;

procedure TjdxCustomDiagram.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomDiagram.Set_onCustomCommand(const Value: TdxEventHandler);
begin
  FonCustomCommand := Value;
  SetEvent('customCommand', onCustomCommand);
end;

procedure TjdxCustomDiagram.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomDiagram.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomDiagram.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomDiagram.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomDiagram.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
  SetEvent('itemClick', onItemClick);
end;

procedure TjdxCustomDiagram.Set_onItemDblClick(const Value: TdxEventHandler);
begin
  FonItemDblClick := Value;
  SetEvent('itemDblClick', onItemDblClick);
end;

procedure TjdxCustomDiagram.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomDiagram.Set_onRequestEditOperation(const Value: TdxEventHandler);
begin
  FonRequestEditOperation := Value;
  SetEvent('requestEditOperation', onRequestEditOperation);
end;

procedure TjdxCustomDiagram.Set_onRequestLayoutUpdate(const Value: TdxEventHandler);
begin
  FonRequestLayoutUpdate := Value;
  SetEvent('requestLayoutUpdate', onRequestLayoutUpdate);
end;

procedure TjdxCustomDiagram.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomDiagram.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomDiagram.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomDiagram.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomDiagram.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomDiagram.dispose();
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.dispose();
end;

function TjdxCustomDiagram.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  return _instance.element();
end;

procedure TjdxCustomDiagram.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.endUpdate();
end;

function TjdxCustomDiagram.export_(): string;
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  return _instance.export();
end;

procedure TjdxCustomDiagram.exportTo(format: JSValue; callback: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.exportTo(format, callback);
end;

procedure TjdxCustomDiagram.fitToContent();
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.fitToContent();
end;

procedure TjdxCustomDiagram.fitToWidth();
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.fitToWidth();
end;

procedure TjdxCustomDiagram.focus();
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.focus();
end;

function TjdxCustomDiagram.getEdgeDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  return _instance.getEdgeDataSource();
end;

function TjdxCustomDiagram.getItemById(id: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  return _instance.getItemById(id);
end;

function TjdxCustomDiagram.getItemByKey(key: TJSObject): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  return _instance.getItemByKey(key);
end;

function TjdxCustomDiagram.getItems(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  return _instance.getItems();
end;

function TjdxCustomDiagram.getNodeDataSource(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  return _instance.getNodeDataSource();
end;

function TjdxCustomDiagram.getSelectedItems(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  return _instance.getSelectedItems();
end;

procedure TjdxCustomDiagram.import(data: string; updateExistingItemsOnly: boolean);
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.import(data, updateExistingItemsOnly);
end;

function TjdxCustomDiagram.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomDiagram.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  return _instance.off(eventName);
end;

function TjdxCustomDiagram.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  return _instance.on(events);
end;

function TjdxCustomDiagram.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomDiagram.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomDiagram.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomDiagram.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.option(options);
end;

function TjdxCustomDiagram.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  return _instance.option();
end;

procedure TjdxCustomDiagram.registerKeyHandler();
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.registerKeyHandler();
end;

procedure TjdxCustomDiagram.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomDiagram.repaint();
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.repaint();
end;

procedure TjdxCustomDiagram.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomDiagram.scrollToItem(item: JSValue);
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.scrollToItem(item);
end;

procedure TjdxCustomDiagram.setSelectedItems(items: TJSArray);
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.setSelectedItems(items);
end;

procedure TjdxCustomDiagram.updateToolbox();
asm
  const _instance = $(this.GetJQID()).dxDiagram("instance");
  _instance.updateToolbox();
end;

end.
