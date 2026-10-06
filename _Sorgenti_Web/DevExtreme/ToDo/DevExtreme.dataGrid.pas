unit DevExtreme.DataGrid;
{$mode objfpc}
{$modeswitch externalclass}

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  Data.DB,
  WEBLib.DB,
  WEBLib.JSON,
  WEBLib.REST,
  js,
  web,
  libjquery,
  DevExtreme.Types,
  DevExtreme.Data,
  DevExtreme.Form,
  DevExtreme.popup,
  DevExtreme,
  zz.web.types;

type
  TdxInitDataGridProc = Reference to Procedure(DataGrid: TdxDataGrid);

  TdxDataGridInitParams = class(TJSObject)
  private
    FCustomFieldChanged: TdxCustomFieldChangedProc;
    FInitDataGrid: TdxInitDataGridProc;
    FInitDataGridOptions: TdxInitOptionsProc;
    FInitFormOptions: TdxInitOptionsProc;
    FMeta: TJSObject;
    FParams: TJSObject;
    procedure SetParams(const Value: TJSObject);
  public
    constructor New;

    class function GetFormInitParams(InitParams: TdxDataGridInitParams): TdxFormInitParams;

    class procedure AddParam(InitParams: TdxDataGridInitParams; key: string; Value: JSValue);

    property Params: TJSObject read FParams write SetParams;

    property InitFormOptions: TdxInitOptionsProc read FInitFormOptions write FInitFormOptions;
    property CustomFieldChanged: TdxCustomFieldChangedProc read FCustomFieldChanged write FCustomFieldChanged;

    property InitDataGridOptions: TdxInitOptionsProc read FInitDataGridOptions write FInitDataGridOptions;
    property InitDataGrid: TdxInitDataGridProc read FInitDataGrid write FInitDataGrid;

    property Meta: TJSObject read FMeta write FMeta;
  end;

  TdxDataGridHelper = class helper for TdxDataGrid
  private
    function doShowRecord(e: TJSObject; rec: TJSObject; readOnly: boolean; OkProc: TCallbackProc): boolean;
  public
    function FocusedRowIndex: integer;
    function FocusedRowKey: JSValue;
  public
    function CanInsert: boolean;
    function CanUpdate: boolean;
    function CanDelete: boolean;
  public
    function UpdateClick(e: TJSObject): JSValue;
    function AppendClick(e: TJSObject): JSValue;
    function DeleteClick(e: TJSObject): JSValue;
    function PropertiesClick(e: TJSObject): JSValue;
  public
    function IsEmpty: boolean;
    procedure UpdateRecord(rec: TJSObject; proc: TProc = nil);
    procedure AppendRecord(rec: TJSObject; proc: TProc = nil);
    procedure DeleteRecord(rec: TJSObject; proc: TProc = nil);
  public
    function GetItems: TJSArray;
    function GetRecord(idx: integer): TJSObject;
    property Items: TJSArray read GetItems;
  end;

  // factory
function dxDataGrid(id: string; options: TJSObject; InitParams: TdxDataGridInitParams = nil): TdxDataGrid; overload;
procedure dxDataGrid(id, dm, name: string; InitParams: TdxDataGridInitParams = nil); overload;
// varie

function dxDataGridOptions(InitParams: TdxDataGridInitParams = nil): TJSObject; overload;
function dxDataGridOptions(const gridId: string; DataSource: TdxDataSource = nil; InitParams: TdxDataGridInitParams = nil): TJSObject; overload;

type
  TdxDataGridEditOptionsEvent = Reference to procedure(options: TJSObject; OkProc: TProc; CancelProc: TProc);

var
  dxDataGridEditOptions: TdxDataGridEditOptionsEvent = nil;

implementation

uses
  zz.web.js,
  zz.web.user,
  DevExtreme.images,
  DevExtreme.utils,
  DevExtreme.DataGrid.popup;

constructor TdxDataGridInitParams.New;
begin
end;

class procedure TdxDataGridInitParams.AddParam(InitParams: TdxDataGridInitParams; key: string; Value: JSValue);
begin

  if not assigned(InitParams.FParams) then
    InitParams.FParams := TJSObject.New;

  InitParams.Params[key] := Value;
end;

class function TdxDataGridInitParams.GetFormInitParams(InitParams: TdxDataGridInitParams): TdxFormInitParams;
begin
  Result := TdxFormInitParams.New;

  Result.Params := InitParams.Params;

  Result.InitFormOptions := InitParams.InitFormOptions;
  Result.CustomFieldChanged := InitParams.CustomFieldChanged;
  Result.FormData := nil;
  Result.Meta := InitParams.Meta;
end;

procedure TdxDataGridInitParams.SetParams(const Value: TJSObject);
begin

  if assigned(Value) then
  begin
    if not assigned(FParams) then
      FParams := TJSObject.New;

    TJSObject.Assign(Params, Value)
  end
  else
    FreeAndNil(FParams); // verificare
end;

/// ///////////////////////////////

function TdxDataGridHelper.GetRecord(idx: integer): TJSObject;
var
  Data: TJSArray;
begin
  Result := nil;

  Data := Items;

  if assigned(Data) then
    if idx < Data.length then
      Result := js.ToObject(Data[idx]);
end;

function TdxDataGridHelper.IsEmpty: boolean;
begin
  Result := Items.length = 0;
end;

function TdxDataGridHelper.PropertiesClick(e: TJSObject): JSValue;
var
  o: TJSObject;
begin

  if assigned(dxDataGridEditOptions) then
  begin
    o := option;

    dxDataGridEditOptions(o,
      procedure
      begin
        option(o);
        refresh;
      end, nil);
  end;
end;

procedure TdxDataGridHelper.AppendRecord(rec: TJSObject; proc: TProc = nil);
var
  store: TdxCustomStore;
begin
  if not CanInsert then
    Exit;

  store := getDataSource.store;
  store.insert(rec)._then(
    function(Value: JSValue): JSValue
    begin
      if assigned(proc) then
        proc;

      refresh;
    end);
end;

function TdxDataGridHelper.CanInsert: boolean;
begin
  Result := js.ToBoolean(option('CanInsert'));
end;

function TdxDataGridHelper.CanUpdate: boolean;
begin
  Result := js.ToBoolean(option('CanUpdate'));
end;

function TdxDataGridHelper.CanDelete: boolean;
begin
  Result := js.ToBoolean(option('CanDelete'));
end;

procedure TdxDataGridHelper.UpdateRecord(rec: TJSObject; proc: TProc = nil);
var
  store: TdxCustomStore;
  key: JSValue;
begin
  if not CanUpdate then
    Exit;

  store := getDataSource.store;
  key := store.keyOf(rec);
  store.update(key, rec)._then(
    function(Value: JSValue): JSValue
    begin
      if assigned(proc) then
        proc;

      refresh;
    end);
end;

procedure TdxDataGridHelper.DeleteRecord(rec: TJSObject; proc: TProc = nil);
var
  store: TdxCustomStore;
  key: JSValue;
begin
  if not CanDelete then
    Exit;

  store := getDataSource.store;
  key := store.keyOf(rec);
  store.remove(key)._then(
    function(Value: JSValue): JSValue
    begin
      if assigned(proc) then
        proc;

      refresh;
    end);
end;

function TdxDataGridHelper.AppendClick(e: TJSObject): JSValue;
var
  rec: TJSObject;
begin
  Result := true;

  rec := TJSObject.New;
  doShowRecord(e, rec, not CanInsert,
    procedure(closeProc: TProc)
    begin
      if CanInsert then
        AppendRecord(rec, closeProc);
    end);
end;

function TdxDataGridHelper.UpdateClick(e: TJSObject): JSValue;
var
  idx: integer;
  rec: TJSObject;
  old: TJSObject;
begin
  Result := true;

  if IsEmpty then
    Exit;

  idx := FocusedRowIndex;

  if idx <> -1 then
  begin
    rec := GetRecord(idx);

    old := TJSObject.New;
    TJSObject.Assign(old, rec);

    doShowRecord(e, rec, not CanUpdate,
      procedure(closeProc: TProc)
      begin
        if CompareObjects(old, rec) then // nessuna modifica
          closeProc
        else
          if CanUpdate then
            UpdateRecord(rec, closeProc);
      end);
  end;
end;

function TdxDataGridHelper.DeleteClick(e: TJSObject): JSValue;
var
  idx: integer;
  rec: TJSObject;
begin
  if not CanDelete then
    Exit;

  idx := FocusedRowIndex;

  if idx <> -1 then
    if not IsEmpty then
    begin
      rec := GetRecord(idx);

      dx.utils.confirm('Elimina record', 'Si desidera eliminare il record corrente?',
        procedure
        begin
          DeleteRecord(rec);
        end, nil);
    end;
end;

function TdxDataGridHelper.doShowRecord(e: TJSObject; rec: TJSObject; readOnly: boolean; OkProc: TCallbackProc): boolean;
var
  showRecord: JSValue;
  Meta: TJSObject;
  Caption: string;
  InitParams: TdxDataGridInitParams;
  InitFormParams: TdxFormInitParams;
begin
  Result := true;

  Meta := js.ToObject(option('meta'));

  InitParams := TdxDataGridInitParams(js.ToObject(option('InitParams')));

  if not assigned(InitParams) then
    InitParams := TdxDataGridInitParams.New;

  InitFormParams := TdxDataGridInitParams.GetFormInitParams(InitParams);
  InitFormParams.Meta := Meta;
  InitFormParams.FormData := rec;

  e['meta'] := Meta;
  e['data'] := rec;
  e['InitFormParams'] := InitFormParams;

  showRecord := option('showRecord');

  if assigned(showRecord) then
  begin
    asm
      showRecord(e);
    end;
  end
  else
  begin
    Caption := js.ToString(TJSObject(TJSArray(Meta['Cards'])[0])['Caption']);
    DevExtreme.DataGrid.popup.showRecord(Caption, readOnly, OkProc, InitFormParams);
  end;
end;

function TdxDataGridHelper.FocusedRowIndex: integer;
var
  j: JSValue;
begin
  j := option('focusedRowIndex');

  if assigned(j) then
    Result := js.ToInteger(j)
  else
    Result := -1;
end;

function TdxDataGridHelper.FocusedRowKey: JSValue;
begin
  Result := option('focusedRowKey');
end;

function TdxDataGridHelper.GetItems: TJSArray;
var
  DataSource: TdxDataSource;
begin
  DataSource := getDataSource;
  Result := DataSource.Items;
end;

/// /////////////////////////////////////////////////////////////////////
// factory

function dxDataGrid(id: string; options: TJSObject; InitParams: TdxDataGridInitParams = nil): TdxDataGrid;
begin

  if assigned(options) then
    Result := dx.factory.DataGrid(id, options)
  else
    Result := dx.factory.DataGrid(id, dxDataGridOptions(InitParams));
end;

procedure dxDataGrid(id, dm, name: string; InitParams: TdxDataGridInitParams = nil);

  procedure CreaDataSource(Meta: TJSObject);
  var
    DataGrid: TdxDataGrid;
    keyExpr: string;
    DataSource: TdxDataSource;
    Params: TJSObject;
    realInitParams: TdxDataGridInitParams;
    options: TJSObject;
  begin
    keyExpr := dxMetaGetPK(Meta);

    if assigned(InitParams) then
      realInitParams := InitParams
    else
      realInitParams := TdxDataGridInitParams.New;

    Params := realInitParams.Params;
    realInitParams.Meta := Meta;

    DataSource := dxDataSource(dm, name, keyExpr, Params, nil, nil);

    options := dxDataGridOptions(id, DataSource, realInitParams);
    options['_dm'] := dm;
    options['_dataset'] := name;

    DataGrid := dx.factory.DataGrid(id, options);

    if assigned(InitParams) then
      if assigned(InitParams.InitDataGrid) then
        InitParams.InitDataGrid(DataGrid);
  end;

begin

  if assigned(InitParams) and assigned(InitParams.Meta) then
    CreaDataSource(InitParams.Meta)
  else
    dxMeta(dm, name,
      procedure(Meta: TJSObject)
      begin
        CreaDataSource(Meta);
      end);
end;

function dxDataGridOptions(InitParams: TdxDataGridInitParams = nil): TJSObject; overload;

  function columnChooser: TJSObject;
  begin
    Result := TJSObject.New;
    Result['enabled'] := true;
    Result['mode'] := 'select';
    Result['allowSearch'] := true;
  end;

  function export: TJSObject;
  begin
    Result := TJSObject.New;
    Result['enabled'] := false; // includere jsZip
    Result['fileName'] := 'export';
  end;

  function searchPanel: TJSObject;
  begin
    Result := TJSObject.New;
    Result['visible'] := false;
  end;

  function paging: TJSObject;
  begin
    Result := TJSObject.New;
    Result['pageSize'] := 10000;
  end;

  function scrolling: TJSObject;
  begin
    Result := TJSObject.New;
    Result['mode'] := 'standard';
    // result['rowRenderingMode'] := 'infinite';
    // result['renderAsync'] := false;
    Result['showScrollbar'] := 'always';
  end;

  function grouping: TJSObject;
  begin
    Result := TJSObject.New;
    Result['autoExpandAll'] := true;
  end;

  function groupPanel: TJSObject;
  begin
    Result := TJSObject.New;
    Result['visible'] := false;
  end;

  function selection: TJSObject;
  begin
    Result := TJSObject.New;
    Result['mode'] := 'single'; // 'multiple' | 'none' | 'single'
    // allowSelectAll
    // selectAllMode  'allPages' | 'page'
    // showCheckBoxesMode  'always' | 'none' | 'onClick' | 'onLongTap'
  end;

  function onContentReady(e: TJSObject): boolean; assembler;
  asm
    e.component.option("focusedRowIndex", 0);
    e.component.option("columnAutoWidth", false);
  end;

  begin
    Result := TJSObject.New;
    Result['rowAlternationEnabled'] := false;
    Result['rowAlternationEnabled'] := true; // PROVA
    Result['allowColumnReordering'] := true;
    Result['allowColumnResizing'] := true;
    Result['columnAutoWidth'] := true;
    Result['columnWidth'] := 'auto';
    // result['columnHidingEnabled'] := not TdxUtils.isDesktop;
    Result['columnHidingEnabled'] := false;
    Result['columnResizingMode'] := 'widget';
    Result['dateSerializationFormat'] := 'yyyy-MM-ddTHH:mm:ss';
    // Result['dateSerializationFormat'] := 'yyyy-MM-ddTHH:mm:ssZ';
    Result['wordWrapEnabled'] := true;
    Result['max-width'] := '97%';
    Result['max-height'] := '97%';
    Result['showBorders'] := true;
    Result['autoNavigateToFocusedRow'] := true;
    Result['focusStateEnabled'] := true;
    // result['focusedRowEnabled'] := not keyExpr.IsEmpty;
    Result['columnChooser'] := columnChooser;
    Result['export'] := export;
    Result['searchPanel'] := searchPanel;
    Result['paging'] := paging;
    Result['remoteOperations'] := true;
    Result['scrolling'] := scrolling;
    Result['grouping'] := grouping;
    Result['groupPanel'] := groupPanel;
    Result['selection'] := selection;
    // result['dateSerializationFormat'] := ;
    Result['onContentReady'] := @onContentReady;
    Result['InitParams'] := InitParams;

    if assigned(InitParams) then
      if assigned(InitParams.InitDataGridOptions) then
        InitParams.InitDataGridOptions(Result);
  end;

function dxDataGridOptions(const gridId: string; DataSource: TdxDataSource = nil; InitParams: TdxDataGridInitParams = nil): TJSObject;

  function stateStoring: TJSObject;
  begin
    Result := TJSObject.New;
    /// /////////////////////////////////
    // result['enabled'] := true;
    Result['enabled'] := false;
    /// /////////////////////////////////
    Result['type'] := 'localStorage';
    Result['storageKey'] := 'view' + gridId;
  end;

  function button(const hint, icon, location: string; onClick: TdxEventHandler): TJSObject;
  var
    options: TJSObject;
  begin
    options := TJSObject.New;
    options['hint'] := hint;
    options['icon'] := icon;
    options['width'] := 25;
    options['onClick'] := onClick;

    Result := TJSObject.New;
    Result['location'] := location;
    Result['widget'] := 'dxButton';
    Result['options'] := options;
  end;

  function toolCaption(const Caption: string): TJSObject;
  begin
    Result := TJSObject.New;
    Result['location'] := 'before';
    Result['template'] := function(): JSValue
      begin
        Result := JQuery('<div class="zz-dataGrid-toolbar">' + Caption + '</div>');
      end;
  end;

  function CalcHidingPriority(cols: TJSArray): TJSArray;
  var
    tmp: TJSArray;
  begin
    Result := nil;

    tmp := cols.map(
      function(element: JSValue; index: NativeInt; anArray: TJSArray): JSValue
      var
        o: TJSObject;
        col: TJSObject;
      begin
        col := js.ToObject(element);
        o := TJSObject.New;
        o['index'] := index;
        o['value'] := js.ToNumber(col['hidingPriority']).ToString.PadLeft(20, '0') + index.ToString.PadLeft(20, '0');
        Result := o;
      end);

    tmp.sort(
      function(a, b: JSValue): NativeInt
      var
        sa, sb: string;
      begin
        sa := js.ToString(a);
        sb := js.ToString(b);

        if sa = sb then
          Result := 0
        else
          if sa > sb then
            Result := 1
          else
            if sa < sb then
              Result := -1;
      end);

    Result := tmp.map(
      function(element: JSValue; index: NativeInt; anArray: TJSArray): JSValue
      begin
        Result := cols[index];
      end);
  end;

  function toolbar(DataGrid: TdxDataGrid): TJSObject;
  var
    Items: TJSArray;
  begin
    Items := TJSArray.New;
    Items.Push(toolCaption(js.ToString(DataGrid.option('caption'))));

    // if js.ToBoolean(store['canUpdate']) then
    Items.Push(button('apri record corrente', imageEdit, 'before', @DataGrid.UpdateClick));

    if DataGrid.CanInsert then
      Items.Push(button('aggiungi un nuovo record', imageAdd, 'before', @DataGrid.AppendClick));

    if DataGrid.CanDelete then
      Items.Push(button('elimina il record selezionato', imageRemove, 'before', @DataGrid.DeleteClick));

    if user.Onnipotente then
      if assigned(dxDataGridEditOptions) then
        Items.Push(button('Personalizza', imageProperties, 'after', @DataGrid.PropertiesClick));

    Items.find(
      function(item: JSValue; index: NativeInt; a: TJSArray): boolean
      var
        btn, options: TJSObject;
      begin
        btn := js.ToObject(item);

        Result := sameText(js.ToString(btn['name']), 'columnChooserButton');

        if Result then
        begin
          options := js.ToObject(btn['options']);
          options['icon'] := imageColumnChooser;
        end;
      end);

    Result := TJSObject.New;
    Result['items'] := Items;
  end;

var
  keyExpr: string;
  Meta: TJSObject;
  grid: TJSObject;
begin
  if assigned(InitParams) and assigned(InitParams.Meta) then
    Meta := InitParams.Meta
  else
    Meta := TJSObject.New;

  { TODO :
    Possibilità di definire QUALE griglia utilizzare.
    L'id è indice delle griglie? }
  grid := TJSObject(TJSArray(Meta['Views'])[0]);

  Result := dxDataGridOptions(nil); // InitDataGridOptions chiamata alla fine
  Result['meta'] := Meta;

  keyExpr := dxMetaGetPK(Meta);
  Result['PK'] := keyExpr;

  if Meta.hasOwnProperty('CanInsert') then
    Result['CanInsert'] := Meta['CanInsert'];

  if Meta.hasOwnProperty('CanUpdate') then
    Result['CanUpdate'] := Meta['CanUpdate'];

  if Meta.hasOwnProperty('CanDelete') then
    Result['CanDelete'] := Meta['CanDelete'];

  Result['caption'] := grid['caption'];
  Result['focusedRowEnabled'] := not keyExpr.IsEmpty;

  Result['stateStoring'] := stateStoring;

  // result['onToolbarPreparing'] := @onToolbarPreparing;

  Result['onInitialized'] := function(e: TJSObject): JSValue
    var
      DataGrid: TdxDataGrid;
    begin
      DataGrid := TdxDataGrid(e['component']);
      DataGrid.option('toolbar', toolbar(DataGrid));
    end;

  Result['onCellDblClick'] := function(e: TJSObject): JSValue
    var
      DataGrid: TdxDataGrid;
    begin
      DataGrid := TdxDataGrid(e['component']);
      DataGrid.UpdateClick(e);
    end;

  // columns
  if js.IsArray(grid['columns']) then
    Result['columns'] := CalcHidingPriority(js.ToArray(grid['columns']));

  // data
  if assigned(DataSource) then
  begin
    Result['remoteOperations'] := true;
    Result['dataSource'] := DataSource;
  end
  else
  begin
    Result['dataSource'] := TJSArray.New;
    Result['keyExpr'] := keyExpr;
  end;

  Result['InitParams'] := InitParams;

  if assigned(InitParams) then
    if assigned(InitParams.InitDataGridOptions) then
      InitParams.InitDataGridOptions(Result);
end;

end.
