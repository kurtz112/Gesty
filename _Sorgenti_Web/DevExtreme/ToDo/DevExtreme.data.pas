unit DevExtreme.data;

interface

uses
  System.SysUtils,
  System.Classes,
  JS,
  Web,
  libjquery,
  DevExtreme.types,
  DevExtreme.validation,
  DevExtreme.utils,
  DevExtreme;

type
  TdxCustomStoreHelper = class helper for TdxCustomStore
  private
    function Getparams: TJSObject;
    procedure Setparams(const Value: TJSObject);
  public
    procedure AddParam(const field: string; Value: JSValue);
    procedure SetParam(const field: string; Value: JSValue);
    function GetParam(const field: string): JSValue;
    property params: TJSObject read Getparams write Setparams;
  end;

  TdxDataSourceHelper = class helper for TdxDataSource
  private
    function Getparams: TJSObject;
    procedure Setparams(const Value: TJSObject);
  public
    procedure AddParam(const field: string; Value: JSValue);
    procedure SetParam(const field: string; Value: JSValue);
    function GetParam(const field: string): JSValue;
    property params: TJSObject read Getparams write Setparams;
  end;

function dxStore(const dm, name, key: string; params: TJSObject; initStore: TdxInitOptionsProc): TdxCustomStore;

function dxDataSource(options: TJSObject): TdxDataSource; assembler; overload;
function dxDataSource(store: TdxCustomStore; initDataSource: TdxInitOptionsProc): TdxDataSource; overload;
function dxDataSource(const dm, name, key: string; initDataSource: TdxInitOptionsProc; initStore: TdxInitOptionsProc): TdxDataSource; overload;
function dxDataSource(const dm, name, key: string; paramKey: string; paramValue: JSValue; initDataSource: TdxInitOptionsProc; initStore: TdxInitOptionsProc): TdxDataSource; overload;
function dxDataSource(const dm, name, key: string; params: TJSObject; initDataSource: TdxInitOptionsProc; initStore: TdxInitOptionsProc): TdxDataSource; overload;

function dxKeyName(const key: string): JSValue;
function dxIsCompositeKey(const key: string): boolean;
function dxKeyValueStr(key: string; Value: JSValue): string;

procedure dxMeta(const dm, name: string; callback: TdxInitOptionsProc);
function dxMetaGetPK(meta: TJSObject): string;

implementation

uses
  zz.Web.DataRequest,
  zz.Web.JsonResponse,
  zz.Web.JS,
  zz.Web.url,
  DevExtreme.consts,
  zz.Web.ajax;

function dxIsCompositeKey(const key: string): boolean;
begin
  result := key.contains(',');
end;

function dxKeyName(const key: string): JSValue;
begin

  if dxIsCompositeKey(key) then
    result := JSStringToArray(key, ',')
  else
    result := key;
end;

function dxKeyValueStr(key: string; Value: JSValue): string;
begin

  if dxIsCompositeKey(key) then
    result := JSObjectToString(JS.ToObject(Value))
  else
    result := key + '=' + JSValueToString(Value);
end;

function dxDataSource(options: TJSObject): TdxDataSource; assembler; overload;
asm
  return  new DevExpress.data.DataSource(options);
end;

function dxDataSource(store: TdxCustomStore; initDataSource: TdxInitOptionsProc): TdxDataSource;
var
  options: TJSObject;
begin
  options := TJSObject.new;
  options['store'] := store;

  if assigned(initDataSource) then
    initDataSource(options);

  result := dxDataSource(options);
end;

function dxDataSource(const dm, name, key: string; params: TJSObject; initDataSource: TdxInitOptionsProc; initStore: TdxInitOptionsProc): TdxDataSource;
var
  store: TdxCustomStore;
begin
  store := dxStore(dm, name, key, params, initStore);
  result := dxDataSource(store, initDataSource);

  result['dm'] := dm;
  result['name'] := name;
end;

function dxDataSource(const dm, name, key: string; paramKey: string; paramValue: JSValue; initDataSource: TdxInitOptionsProc; initStore: TdxInitOptionsProc): TdxDataSource;
var
  params: TJSObject;
begin
  params := TJSObject.new;
  params[paramKey] := paramValue;
  result := dxDataSource(dm, name, key, params, initDataSource, initStore);
end;

function dxDataSource(const dm, name, key: string; initDataSource: TdxInitOptionsProc; initStore: TdxInitOptionsProc): TdxDataSource;
begin
  result := dxDataSource(dm, name, key, nil, initDataSource, initStore);
end;

function FetchDataRequest(const RequestType: TDataRequestType; const dm, name, KeyValues, params: string; loadOptions: TJSObject = nil): TJSPromise;
var
  PostData: string;
begin
  PostData := GetDataRequest(RequestType, dm, name, KeyValues, params, loadOptions);
  result := AjaxPost(TUrl.DataRequest, PostData, true, 'data');
end;

function dxStore(const dm, name, key: string; params: TJSObject; initStore: TdxInitOptionsProc): TdxCustomStore;

  function _byKey(KeyValues: JSValue): TJSPromise;
  var
    params: TJSObject;
    key: string;
    s: string;
  begin
    asm
      // non esiste altro modo per far arrivare i parametri...
      params = this.params || { };
    end;

    key := dxKeyValueStr(key, KeyValues);
    s := name + ' _byKey: ' + 'key: ' + key + sLineBreak + JSObjectToString(params);
    DebugString(s);

    // PostData := GetDataRequest(rtSelect, dm, name, key, JSObjectToString(params), nil);
    // result := AjaxPost(TUrl.DataRequest, PostData, true, 'data');

    result := FetchDataRequest(rtSelect, dm, name, key, JSObjectToString(params), nil);
  end;

  function _load(loadOptions: TJSObject): TJSPromise;
  var
    PostData: string;
    params: TJSObject;
    s: String;
  begin
    asm
      // non esiste altro modo per far arrivare i parametri...
      params = this.params || { };
    end;

    s := name + ' _Load: ' + JSObjectToString(params);
    DebugString(s);

    // params := JS.ToObject(store.params);
    // PostData := GetDataRequest(rtSelect, dm, name, '', JSObjectToString(params), loadOptions);
    // result := AjaxPost(TUrl.DataRequest, PostData, true, 'data');

    result := FetchDataRequest(rtSelect, dm, name, '', JSObjectToString(params), loadOptions);
  end;

  function _insert(values: TJSObject): TJSPromise;
  begin
    result := FetchDataRequest(rtInsert, dm, name, '', JSObjectToString(values));
  end;

  function _update(KeyValues: JSValue; values: TJSObject): TJSPromise;
  begin
    result := FetchDataRequest(rtUpdate, dm, name, '', JSObjectToString(values));
  end;

  function _remove(KeyValues: JSValue): TJSPromise;
  begin
    result := FetchDataRequest(rtDelete, dm, name, '', dxKeyValueStr(key, KeyValues));
  end;

  function _totalCount(loadOptions: TJSObject): TJSPromise;
  var
    params: TJSObject;
  begin
    asm
      // non esiste altro modo per far arrivare i parametri...
      params = this.params || { };
    end;

    result := FetchDataRequest(rtCount, dm, name, '', JSObjectToString(params), loadOptions);
  end;

  function _errorHandler(error: JSValue): TJSFunction;
  var
    e: TJSObject;
  begin
    console.log(error);

    e := JS.ToObject(error);

    raise Exception.Create(JS.ToString(e['message']));
  end;

var
  options: TJSObject;
  store: TdxCustomStore;
begin
  options := TJSObject.new;
  options['key'] := dxKeyName(key);

  options['byKey'] := @_byKey;
  options['load'] := @_load;
  options['insert'] := @_insert;
  options['update'] := @_update;
  options['remove'] := @_remove;
  options['totalCount'] := @_totalCount;
  options['errorHandler'] := @_errorHandler;

  options['loadMode'] := 'raw';
  options['useDefaultSearch'] := true;

  options['dm'] := dm;
  options['name'] := name;

  if assigned(initStore) then
    initStore(options);

  asm
    store = new DevExpress.data.CustomStore(options);
  end;

  result := store;

  if assigned(params) then
    result.params := params;
end;

procedure dxMeta(const dm, name: string; callback: TdxInitOptionsProc);
var
  PostData: string;
  JQXHR: TJQXHR;
  meta: TJSObject;
begin
  PostData := GetDataRequest(rtMeta, dm, name, '', '');

  JQXHR := TJQuery.post(TUrl.DataRequest, PostData);
  JQXHR.done(
    function(aData: JSValue; textStatus: string; aJQXHR: TJQXHR): boolean
    var
      JsonResponse: TJsonResponse;
    begin
      JsonResponse := TJsonResponse.Create;
      try
        JsonResponse.Parse(aData, true);

        if JsonResponse.result then
        begin
          meta := JsonResponse.JSONObject;
          meta['dm'] := dm;
          meta['dataset'] := name;
          callback(meta);
        end
        else
          raise Exception.Create(JsonResponse.ErrorMsg);
      finally
        freeAndNil(JsonResponse);
      end;
    end);
end;

{ TdxCustomStoreHelper }

procedure TdxCustomStoreHelper.AddParam(const field: string; Value: JSValue);
begin
  params[field] := Value;
end;

procedure TdxCustomStoreHelper.SetParam(const field: string; Value: JSValue);
var
  o: TJSObject;
begin
  params := TJSObject.new; // resetta
  AddParam(field, Value);
end;

function TdxCustomStoreHelper.GetParam(const field: string): JSValue;
begin
  result := params[field];
end;

function TdxCustomStoreHelper.Getparams: TJSObject;
begin
  // se non esiste lo crea
  if not self.hasOwnProperty('params') then
    params := TJSObject.new;

  result := JS.ToObject(self['params'])
end;

procedure TdxCustomStoreHelper.Setparams(const Value: TJSObject);
begin
  self['params'] := Value;
end;

{ TdxDataSourceHelper }

procedure TdxDataSourceHelper.AddParam(const field: string; Value: JSValue);
begin
  store.AddParam(field, Value);
end;

function TdxDataSourceHelper.GetParam(const field: string): JSValue;
begin
  result := store.GetParam(field);
end;

procedure TdxDataSourceHelper.SetParam(const field: string; Value: JSValue);
begin
  store.SetParam(field, Value);
end;

function TdxDataSourceHelper.Getparams: TJSObject;
begin
  result := store.params;
end;

procedure TdxDataSourceHelper.Setparams(const Value: TJSObject);
begin
  store.params := Value;
end;

function dxMetaGetPK(meta: TJSObject): string;
begin
  result := '';

  if meta.hasOwnProperty('PK') then
    result := JS.ToString(meta['PK']);
end;

function dxValue(data: TJSObject; dataField: string): JSValue;
begin
  result := data[dataField];
end;

end.

  JS
