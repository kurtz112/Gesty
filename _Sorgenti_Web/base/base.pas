unit base;

interface

uses
  System.SysUtils,
  System.Classes,
  Types,
  Data.DB,
  JS,
  web,
  // libserviceworkers,
  zz.web.DataRequest,
  DevExtreme.Types,
  DevExtreme.base;

type
  TBase = class(TComponent, IdxBaseInterface)
  private
    function IsCompositeKey(const key: string): boolean;
    function KeyName(const key: string): JSValue;
    function KeyValueStr(key: string; Value: JSValue): string;
  private
    function ParseRemoteFields(RemoteFields: TJSArray): TJSArray;
  private
    [async]
    function DownloadSQL(const dm, name: string; out TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: String): boolean;
    function UploadSQL(const dm, name, TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: String): boolean;
  public
    [async]
    function fields(const dm, name: string): TJSPromise; overload;
  public
    function byKey(const dm, name, Pk: string; KeyValues: JSValue; params: TJSObject): TJSPromise;
    function select(const dm, name: string; params: TJSObject; loadOptions: TJSObject = nil): TJSPromise;
    function insert(const dm, name: string; values: TJSObject): TJSPromise;
    function update(const dm, name: string; values: TJSObject): TJSPromise;
    function delete(const dm, name, Pk: string; KeyValues: JSValue): TJSPromise;
    function count(const dm, name: string; params: TJSObject; loadOptions: TJSObject = nil): TJSPromise;

    function sp(const dm, name: string; params: TJSObject; loadOptions: TJSObject = nil): TJSPromise;
  public
    [async]
    function DownloadOptions(const dm, name, className: string): TJSPromise; overload;
    function UploadOptions(const dm, name, className: string; Options: TJSObject): boolean;
  public
    function Onnipotente: boolean;
    procedure Inspect(title: string; obj: TJSObject; OkProc: TdxOkCancelProc; CancelProc: TdxOkCancelProc = nil);
    procedure EditOptions(Options: TJSObject; OkProc: TdxEventHandlerFunc; CancelProc: TProc = nil);
    procedure EditJSObject(const title: string; Options: TJSObject; ReturnProc: TEditOptionsReturnProc);
    [async]
    procedure EditSQL(const dm, dataset: string; callback: TProc);
  end;

implementation

uses
  Vcl.Forms,
  zz.web.JS,
  zz.web.fetch,
  zz.web.url,
  zz.web.JSClasses,
  zz.web.JsonResponse,
  baseInspector,
  baseMeta,
  baseEditorSql,
  baseEditorJson;

function TBase.IsCompositeKey(const key: string): boolean;
begin
  result := key.contains(',');
end;

function TBase.KeyName(const key: string): JSValue;
begin

  if IsCompositeKey(key) then
    result := newArray(key, ',')
  else
    result := key;
end;

function TBase.KeyValueStr(key: string; Value: JSValue): string;
begin

  if IsCompositeKey(key) then
    result := JSObjectToString(JS.ToObject(Value))
  else
    result := key + '=' + JSValueToString(Value);
end;

procedure TBase.Inspect(title: string; obj: TJSObject; OkProc, CancelProc: TdxOkCancelProc);
begin
  baseInspector.InspectObject(title, obj, OkProc, CancelProc);
end;

procedure TBase.EditOptions(Options: TJSObject; OkProc: TdxEventHandlerFunc; CancelProc: TProc = nil);
begin
  baseMeta.ShowMeta(Options, OkProc, CancelProc);
end;

procedure TBase.EditJSObject(const title: string; Options: TJSObject; ReturnProc: TEditOptionsReturnProc);
begin
  baseEditorJson.EditJSObject(title, Options, ReturnProc);
end;

function TBase.Onnipotente: boolean;
begin
  result := true; { TODO : Implementare: Onnipotente }
end;

function TBase.byKey(const dm, name, Pk: string; KeyValues: JSValue; params: TJSObject): TJSPromise;
var
  key: string;
begin
  key := KeyValueStr(Pk, KeyValues);

  result := fetch(rtSelect, dm, name, key, JSObjectToString(params), nil);
end;

function TBase.select(const dm, name: string; params: TJSObject; loadOptions: TJSObject = nil): TJSPromise;
begin
  result := fetch(rtSelect, dm, name, '', JSObjectToString(params), loadOptions);
end;

function TBase.sp(const dm, name: string; params, loadOptions: TJSObject): TJSPromise;
begin
  result := fetch(rtExecSP, dm, name, '', JSObjectToString(params), loadOptions);
end;

function TBase.insert(const dm, name: string; values: TJSObject): TJSPromise;
begin
  result := fetch(rtInsert, dm, name, '', JSObjectToString(values));
end;

function TBase.update(const dm, name: string; values: TJSObject): TJSPromise;
begin
  result := fetch(rtUpdate, dm, name, '', JSObjectToString(values));
end;

function TBase.delete(const dm, name, Pk: string; KeyValues: JSValue): TJSPromise;
begin
  result := fetch(rtDelete, dm, name, '', KeyValueStr(Pk, KeyValues));
end;

function TBase.count(const dm, name: string; params: TJSObject; loadOptions: TJSObject = nil): TJSPromise;
begin
  result := fetch(rtCount, dm, name, '', JSObjectToString(params), loadOptions);
end;

function TBase.DownloadSQL(const dm, name: string; out TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: String): boolean;
var
  response: TJSResponse;
  o: TJSObject;
  req: TJSRequest;
  Data: String;
  res: TJSObject;

  function ExtractSQL(o: TJSObject; name: string): String;
  var
    a: TJSArray;
  begin
    result := '';

    if o.hasOwnProperty(name) then
      if JS.isArray(o[name]) then
      begin
        a := JS.toArray(o[name]);
        result := JSArrayToString(a);
      end;
  end;

begin
  Data := TSqlRequest.GetSqlRequest(dm, name, '', '', '', '', '', '', '', '');

  o := RequestOptions(TUrl.getSql, 'POST', 'application/json', nil, '', Data);
  req := Request(TUrl.getSql, o);
  response := await(TJSResponse(fetch(req)));

  result := response.ok;

  if result then
  begin
    asm
      res = await response.json();
    end;

    res := JS.ToObject(res['result']);
    console.log(res);

    TableName := JS.toString(res['TableName']);
    Pk := JS.toString(res['PK']);
    fields := ExtractSQL(res, 'Fields');
    SelectSql := ExtractSQL(res, 'SelectSql');
    InsertSql := ExtractSQL(res, 'InsertSql');
    UpdateSql := ExtractSQL(res, 'UpdateSql');
    DeleteSql := ExtractSQL(res, 'DeleteSql');
    CountSql := ExtractSQL(res, 'CountSql');
  end
  else
    raise Exception.create('HTTP error! status: ' + str(response.status));
end;

function TBase.UploadSQL(const dm, name, TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: String): boolean;
var
  o: TJSObject;
  req: TJSRequest;
  Data: String;
begin
  Data := TSqlRequest.GetSqlRequest(dm, name, TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql);
  o := RequestOptions(TUrl.setSql, 'POST', 'application/json', nil, '', Data);
  req := Request(TUrl.setSql, o);
  fetch(req);
end;

function TBase.UploadOptions(const dm, name, className: string; Options: TJSObject): boolean;
var
  o: TJSObject;
  req: TJSRequest;
  Data: String;
begin
  Data := TOptionsRequest.GetOptionRequest(dm, name, className, Options);

  // o := RequestOptions(TUrl.SetOptions, 'PUT', 'application/json', nil, '', data);
  o := RequestOptions(TUrl.SetOptions, 'POST', 'application/json', nil, '', Data);
  req := Request(TUrl.SetOptions, o);

  // req.headers.add();

  console.log(req);

  fetch(req);
end;

procedure TBase.EditSQL(const dm, dataset: string; callback: TProc);
var
  ok: boolean;
  TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: string;
begin
  ok := await(DownloadSQL(dm, dataset, TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql));

  baseEditorSql.EditSQL(dm + '.' + dataset, TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql,
    procedure(TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: string; callback: TProc)
    begin
      UploadSQL(dm, dataset, TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql);

      if assigned(callback) then
        callback;
    end);
end;

function TBase.ParseRemoteFields(RemoteFields: TJSArray): TJSArray;
var
  resultArray: TJSArray;
begin
  resultArray := TJSArray.new;

  RemoteFields.forEach(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      s: string;
      field: TJSObject;
      newField: TJSObject;
    begin
      field := JS.ToObject(element);

      newField := TJSObject.new();
      newField['dataField'] := field['FieldName'];
      newField['dataType'] := field['dxType'];
      newField['caption'] := field['DisplayLabel'];
      newField['size'] := field['Size'];
      newField['required'] := field['Required'];

      // result.AddPair('DisplayWidth', TJSONNumber.Create(field.DisplayWidth));

      /// ////////////////////////////////////////////////////////////
      // 'center' | 'left' | 'right'
      //
      // 'number' =>	'right'
      // 'boolean' =>	'center'
      // 'string' =>	'left'
      // 'date' =>	'left'
      // 'datetime' =>	'left'

      s := JS.toString(field['Alignment']);

      if sameText(s, 'taLeftJustify') then
        newField['alignment'] := 'left'
      else
        if sameText(s, 'taRightJustify') then
          newField['alignment'] := 'right'
        else
          if sameText(s, 'taCenter') then
            newField['alignment'] := 'center';

      resultArray.push(newField);
    end);

  result := resultArray;
end;

function TBase.fields(const dm, name: string): TJSPromise;
begin
  result := TJSPromise.new(
    procedure(resolve, reject: TJSPromiseResolver)
    begin
      fetch(rtMeta, dm, name, '', '', nil, '')._then(
        function(Value: JSValue): JSValue
        var
          fields: TJSArray;
        begin
          fields := JS.toArray(Value);
          fields := ParseRemoteFields(fields);
          resolve(fields);
        end);
    end);
end;

function TBase.DownloadOptions(const dm, name, className: string): TJSPromise;
var
  Data: string;
begin
  Data := TOptionsRequest.GetOptionRequest(dm, name, className, nil);
  result := fetch(TUrl.GetOptions, Data, true, 'Options');
end;

initialization

base := TBase.create(Application);

end.


// Note
// dxLookupDataSource: Meta punta a Views
