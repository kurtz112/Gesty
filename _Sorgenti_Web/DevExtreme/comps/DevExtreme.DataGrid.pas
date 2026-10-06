unit DevExtreme.DataGrid;

interface

uses
  System.SysUtils,
  System.Classes,
  Types,
  WEBLib.Controls,
  jsdelphisystem,
  JS,
  Web,
  libjquery,
  DevExtreme.Base,
  DevExtreme.CustomControl,
  DevExtreme.DataGrid.Custom,
  DevExtreme.DataGrid.JS,
  DevExtreme.Form,
  DevExtreme.Form.JS,
  DevExtreme.Data.JS,
  DevExtreme.Data,
  DevExtreme.Types;

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

  TjdxDataGrid = class(TjdxCustomDataGrid)
  private
    FjdxDataSource: TjdxDataSource;
  public
    procedure CreateInitialize; override;

    property jdxDataSource: TjdxDataSource read FjdxDataSource;
  end;

  TdxDataGridHelper = class helper for TdxDataGrid
  private
    procedure internalShowRecord(const Caption: String; const readOnly: boolean; OkProc: TdxOkCancelProc; InitParams: TdxFormInitParams);
    function doShowRecord(e: TJSObject; rec: TJSObject; readOnly: boolean; OkProc: TdxOkCancelProc): boolean;
  private
    function GetAllowAdding: boolean;
    procedure SetAllowAdding(const Value: boolean);
    function GetAllowUpdating: boolean;
    procedure SetAllowUpdating(const Value: boolean);
    function GetAllowDeleting: boolean;
    procedure SetAllowDeleting(const Value: boolean);
    procedure SetHideEditButton(const Value: boolean);
    function GetHideEditButton: boolean;
  private
    function GetColumns: TJSArray;
    procedure SetColumns(const Value: TJSArray);
  public
    function FocusedRowIndex: integer;
    function FocusedRowKey: JSValue;
  public
    function CanInsert: boolean;
    function CanUpdate: boolean;
    function CanDelete: boolean;
  public
    property AllowAdding: boolean read GetAllowAdding write SetAllowAdding;
    property AllowUpdating: boolean read GetAllowUpdating write SetAllowUpdating;
    property AllowDeleting: boolean read GetAllowDeleting write SetAllowDeleting;
    property HideEditButton: boolean read GetHideEditButton write SetHideEditButton;
  public
    function UpdateClick(e: TJSObject): JSValue;
    function AppendClick(e: TJSObject): JSValue;
    function DeleteClick(e: TJSObject): JSValue;
  public
    function PropertiesClick(e: TJSObject): JSValue;
    procedure EditOptions;

    function SqlClick(e: TJSObject): JSValue;
    procedure EditSQL;
  public
    function IsEmpty: boolean;
    procedure AppendRecord(rec: TJSObject; proc: TProc = nil);
    procedure UpdateRecord(rec: TJSObject; proc: TProc = nil);
    procedure DeleteRecord(rec: TJSObject; proc: TProc = nil);
  public
    function GetItems: TJSArray;
    function GetRecord(idx: integer): TJSObject;
    property Items: TJSArray read GetItems;
  public
    property columns: TJSArray read GetColumns write SetColumns;
  end;

function CalcHidingPriority(cols: TJSArray): TJSArray;

implementation

uses
  zz.Web.JS,
  DevExtreme.utils,
  DevExtreme.Popup,
  DevExtreme.Popup.JS,
  DevExtreme.images,
  DevExtreme.factory,
  DevExtreme.Options;

/// ///////////////////////////////

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
      col := JS.ToObject(element);
      o := TJSObject.New;
      o['index'] := index;
      o['value'] := JS.ToNumber(col['hidingPriority']).ToString.PadLeft(20, '0') + index.ToString.PadLeft(20, '0');
      Result := o;
    end);

  tmp.sort(
    function(a, b: JSValue): NativeInt
    var
      sa, sb: string;
    begin
      sa := JS.ToString(a);
      sb := JS.ToString(b);

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
/// ///////////////////////////////

function TdxDataGridHelper.GetRecord(idx: integer): TJSObject;
var
  Data: TJSArray;
begin
  Result := nil;

  Data := Items;

  if assigned(Data) then
    if idx < Data.length then
      Result := JS.ToObject(Data[idx]);
end;

function TdxDataGridHelper.IsEmpty: boolean;
begin
  Result := Items.length = 0;
end;

function TdxDataGridHelper.CanInsert: boolean;
begin
  Result := JS.ToBoolean(option('CanInsert'));
end;

function TdxDataGridHelper.CanUpdate: boolean;
begin
  Result := JS.ToBoolean(option('CanUpdate'));
end;

function TdxDataGridHelper.CanDelete: boolean;
begin
  Result := JS.ToBoolean(option('CanDelete'));
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

    old := TJSObject.Assign(TJSObject.New, rec);

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

      TdxUtils.confirm('Elimina record', 'Si desidera eliminare il record corrente?',
        procedure
        begin
          DeleteRecord(rec);
        end, nil);
    end;
end;

function TdxDataGridHelper.FocusedRowIndex: integer;
var
  j: JSValue;
begin
  j := option('focusedRowIndex');

  if assigned(j) then
    Result := JS.ToInteger(j)
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
  DataSource := TdxDataSource(getDataSource);
  Result := DataSource.Items;
end;

procedure TdxDataGridHelper.AppendRecord(rec: TJSObject; proc: TProc = nil);
var
  store: TdxCustomStore;
begin
  if not CanInsert then
    Exit;

  store := TdxDataSource(getDataSource).store;
  store.insert(rec)._then(
    function(Value: JSValue): JSValue
    begin
      if assigned(proc) then
        proc;

      refresh;
    end);
end;

procedure TdxDataGridHelper.UpdateRecord(rec: TJSObject; proc: TProc = nil);
var
  store: TdxCustomStore;
  key: JSValue;
begin
  if not CanUpdate then
    Exit;

  store := TdxDataSource(getDataSource).store;
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

  store := TdxDataSource(getDataSource).store;
  key := store.keyOf(rec);
  store.remove(key)._then(
    function(Value: JSValue): JSValue
    begin
      if assigned(proc) then
        proc;

      refresh;
    end);
end;

procedure TdxDataGridHelper.internalShowRecord(const Caption: String; const readOnly: boolean; OkProc: TdxOkCancelProc; InitParams: TdxFormInitParams);
var
  formOptions: TJSObject;
  Form: TdxForm;
  popOptions: TJSObject;
  pop: TdxPopup;
  popContentId: string;
begin
  formOptions := dxOptions.Form('');
  formOptions['readOnly'] := readOnly;
  formOptions['items'] := columns;

  if assigned(InitParams) then
  begin
    if assigned(InitParams.FormData) then
      formOptions['formData'] := InitParams.FormData;

    formOptions['customFieldChanged'] := InitParams.CustomFieldChanged;

    if assigned(InitParams.InitFormOptions) then
      InitParams.InitFormOptions(formOptions);
  end;

  formOptions['oldValues'] := formOptions['formData'];

  // if not assigned(formOptions['onFieldDataChanged']) then
  // begin
  // formOptions['onFieldDataChanged'] := function(e: TJSObject): JSValue
  // var
  // j: JSValue;
  // dxForm: TdxForm;
  // begin
  // dxForm := TdxForm(e['component']);
  //
  // j := dxForm.validate;
  //
  // if dx.validation.isValid(j) then
  // dxPopupEnableButton(pop, 'Conferma', true)
  // else
  // dxPopupEnableButton(pop, 'Conferma', false);
  // end;
  // end;

  popOptions := dxOptions.Popup(Caption);
  popContentId := TjdxPopup.ContentId(popOptions);
  popOptions['onShowing'] := function(e: TJSObject): JSValue
    var
      w, h: integer;
    begin
      pop := TdxPopup(e['component']);
      Form := dxFactory.Form('#' + popContentId, formOptions);

      if TdxUtils.ScreenSize >= ssMedium then
        pop.option('width', 'auto')
      else
        pop.option('width', '90%');

      pop.option('height', 'auto');
    end;

  popOptions['onShown'] := function(e: TJSObject): JSValue
    var
      w: integer;
    begin

      asm
        e.component.content().find('input').first().focus();
      end;
    end;

  TjdxPopup.ShowPopupModal(popOptions, OkProc);
end;

procedure TdxDataGridHelper.EditOptions;
var
  id: string;
  o: TJSObject;
begin
  o := option();
  // caption
  // Base.EditJSObject('Opzioni DataGrid', o,
  // procedure(Options: TJSObject; callBack: TProc)
  // begin
  // option(o);
  // refresh;
  // aa
  // callBack();
  // end);
  Base.EditOptions(o,
    function(e: TJSObject): JSValue
    var
      dm, dataset: string;
    begin
      o := JS.ToObject(e);
      option(o);
      refresh;

      dm := JS.ToString(o['dm']);
      dataset := JS.ToString(o['dataset']);

      if not((dm.IsEmpty) or (dataset.IsEmpty)) then
        Base.UploadOptions(dm, dataset, 'TdxDataGrid', o);
    end, nil);
end;

function TdxDataGridHelper.PropertiesClick(e: TJSObject): JSValue;
begin
  EditOptions;
end;

procedure TdxDataGridHelper.EditSQL;
var
  id: string;
  o: TJSObject;
  dm, dataset: string;
begin
  o := option();
  dm := JS.ToString(o['dm']);
  dataset := JS.ToString(o['dataset']);

  Base.EditSQL(dm, dataset,
    procedure
    begin
    end);
end;

function TdxDataGridHelper.SqlClick(e: TJSObject): JSValue;
begin
  EditSQL;
end;

function TdxDataGridHelper.doShowRecord(e: TJSObject; rec: TJSObject; readOnly: boolean; OkProc: TdxOkCancelProc): boolean;
var
  showRecord: JSValue;
  Meta: TJSObject;
  Caption: string;
  InitParams: TdxDataGridInitParams;
  InitFormParams: TdxFormInitParams;
begin
  Result := true;

  Meta := JS.ToObject(option('meta'));

  InitParams := TdxDataGridInitParams(JS.ToObject(option('InitParams')));

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
    // Caption := JS.ToString(TJSObject(TJSArray(Meta['Cards'])[0])['Caption']);
    Caption := 'Scheda';
    internalShowRecord(Caption, readOnly, OkProc, InitFormParams);
  end;
end;

function TdxDataGridHelper.GetColumns: TJSArray;
begin
  Result := JS.toArray(option('columns'));
end;

procedure TdxDataGridHelper.SetColumns(const Value: TJSArray);
begin
  option('columns', CalcHidingPriority(Value));
end;

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

procedure TdxDataGridInitParams.SetParams(

  const Value: TJSObject);
begin

  if assigned(Value) then
  begin
    if not assigned(FParams) then
      FParams := TJSObject.New;

    Params := TJSObject.Assign(Params, Value)
  end
  else
    FreeAndNil(FParams); // verificare
end;

{ TjdxDataGrid }

procedure TjdxDataGrid.CreateInitialize;
begin
  inherited;
  FjdxDataSource := nil;
end;

function TdxDataGridHelper.GetAllowAdding: boolean;
var
  Editing: TJSObject;
begin
  Result := false;

  Editing := JS.ToObject(option('editing'));
  Result := JS.ToBoolean(Editing['allowAdding']);
end;

procedure TdxDataGridHelper.SetAllowUpdating(const Value: boolean);
var
  Editing: TJSObject;
begin
  Editing := JS.ToObject(option('editing'));
  Editing['allowAdding'] := Value;
  option('editing', Editing);
end;

function TdxDataGridHelper.GetAllowUpdating: boolean;
var
  Editing: TJSObject;
begin
  Result := false;

  Editing := JS.ToObject(option('editing'));
  Result := JS.ToBoolean(Editing['allowUpdating']);
end;

procedure TdxDataGridHelper.SetAllowAdding(const Value: boolean);
var
  Editing: TJSObject;
begin
  Editing := JS.ToObject(option('editing'));
  Editing['allowUpdating'] := Value;
  option('editing', Editing);
end;

function TdxDataGridHelper.GetAllowDeleting: boolean;
var
  Editing: TJSObject;
begin
  Result := false;

  Editing := JS.ToObject(option('editing'));
  Result := JS.ToBoolean(Editing['allowDeleting']);
end;

function TdxDataGridHelper.GetHideEditButton: boolean;
begin
  Result := JS.ToBoolean(option('HideEdit'));
end;

procedure TdxDataGridHelper.SetAllowDeleting(const Value: boolean);
var
  Editing: TJSObject;
begin
  Editing := JS.ToObject(option('editing'));
  Editing['allowDeleting'] := Value;
  option('editing', Editing);
end;

procedure TdxDataGridHelper.SetHideEditButton(const Value: boolean);
begin
  option('HideEdit', Value);
end;

end.
