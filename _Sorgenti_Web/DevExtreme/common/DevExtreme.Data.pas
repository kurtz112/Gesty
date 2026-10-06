unit DevExtreme.Data;

interface

uses
  System.SysUtils,
  System.Classes,
  DevExtreme.Data.JS,
  DevExtreme.types,
  DevExtreme.Base,
  JS,
  Web;

type
  TjdxDataSource = class(TComponent)
  private
    Fdataset: string;
    Fdm: string;
    Fkey: string;
    FDataSource: TdxDataSource;
    Fparams: TStringList;
    FInitOptionsProc: TdxInitOptionsProc;
    function GetStore: TdxCustomStore;
    function GetDataSource: TdxDataSource;
    function Getparams: TStringList;
    procedure Setparams(const Value: TStringList);
  private
    function GetParamsObj: TJSObject;
  private
    function CreateDataSource: TdxDataSource;
    function CreateStore: TdxCustomStore;
  public
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;

    function Load: TJSPromise;
    function Reload: TJSPromise;

    function DefaultOptions: TJSObject;
    property InitOptionsProc: TdxInitOptionsProc read FInitOptionsProc write FInitOptionsProc;
    property DataSource: TdxDataSource read GetDataSource;
    property Store: TdxCustomStore read GetStore;
  public
    function GetFields: TJSPromise; overload;
    procedure ApplyParams;
    procedure SetParam(const ParamName: string; const Value: string);
  published
    property dm: string read Fdm write Fdm;
    property dataset: string read Fdataset write Fdataset;
    property key: string read Fkey write Fkey;
    property params: TStringList read Getparams write Setparams;
  end;

  TdxCustomStoreHelper = class helper for TdxCustomStore
  private
    function Getparams: TJSObject;
    procedure Setparams(const Value: TJSObject);
  public
    procedure AddParam(const field: string; Value: JSValue);
    procedure SetParam(const field: string; Value: JSValue);
    function GetParam(const field: string): JSValue;
    property params: TJSObject read Getparams write Setparams;
  public
    function GetFields(const dm, dataset: string): TJSPromise;
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
function dxDataSource(options: TJSObject): TdxDataSource; assembler;
function dxLookupDataSource(const name, key: string; params: TJSObject; columns: TJSArray): TdxDataSource;

const
  dmLookup = '__Lookups';

implementation

uses
  DevExtreme.Lib,
  DevExtreme.utils;

function dxDataSource(options: TJSObject): TdxDataSource; assembler;
asm
  return  new DevExpress.data.DataSource(options);
end;

function dxLookupDataSource(const name, key: string; params: TJSObject; columns: TJSArray): TdxDataSource;
var
  DataSource: TdxDataSource;
  options: TJSObject;
  Store: TdxCustomStore;
begin
  Store := dxStore(dmLookup, name, key, params,
    procedure(options: TJSObject)
    begin

      options['postProcess'] := function(Data: TJSArray): JSValue
        var
          h: JSValue;
          HeaderAggiunti: boolean;
          header: TJSObject;
        begin
          /// //////////////////////////////////////////////////////////
          // in pratica: se arriva il campo DISABLED lo rende lowercase
          if Data.length > 1 then
            if JS.ToObject(Data[1]).hasOwnProperty('DISABLED') then
              Data.forEach(
                function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
                var
                  item: TJSObject;
                begin

                  if index > 0 then
                  begin
                    item := JS.ToObject(element);
                    item['disabled'] := item['DISABLED'];
                    // verificare dopo la conversione alla nuova gestione
                    // JSDelete(item, 'DISABLED');
                  end;
                end);

          /// //////////////////////////////////////////////////////////
          /// Header delle colonne
          HeaderAggiunti := JS.ToBoolean(DataSource['headerAggiunti']);
          DataSource['headerAggiunti'] := true;

          if not HeaderAggiunti then
          begin
            header := TJSObject.new;

            columns.forEach(
              function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
              var
                col: TJSObject;
              begin
                col := JS.ToObject(element);

                if dxColumnVisible(col) then
                  header[JS.ToString(col['dataField'])] := JS.ToString(col['caption']);
              end);

            // data.unshift({ orderID: "OrderID", customerName: "CustomerName", shipCountry: "ShipCountry", shipCity: "ShipCity", disabled: true });

            header['disabled'] := true;
            Data.unshift(header);
          end;

          result := Data;
        end;
    end);

  options := TJSObject.new;
  options['store'] := Store;

  DataSource := dxDataSource(options);
  DataSource['dm'] := dmLookup;
  DataSource['name'] := name;
  result := DataSource; // DataSource viene usata all'interno di postProcess
end;

function dxStore(const dm, name, key: string; params: TJSObject; initStore: TdxInitOptionsProc): TdxCustomStore;

  function _byKey(KeyValues: JSValue): TJSPromise;
  begin
    asm
      // non esiste altro modo per far arrivare i parametri...
      params = this.params || { };
    end;

    result := Base.bykey(dm, name, key, KeyValues, params);
  end;

  function _load(loadOptions: TJSObject): TJSPromise;
  var
    params: TJSObject;
  begin
    asm
      // non esiste altro modo per far arrivare i parametri...
      params = this.params || { };
    end;

    result := Base.select(dm, name, params, loadOptions);
  end;

  function _insert(values: TJSObject): TJSPromise;
  begin
    result := Base.insert(dm, name, values);
  end;

  function _update(KeyValues: JSValue; values: TJSObject): TJSPromise;
  begin
    result := Base.update(dm, name, values);
  end;

  function _remove(KeyValues: JSValue): TJSPromise;
  begin
    result := Base.delete(dm, name, key, KeyValues);
  end;

  function _totalCount(loadOptions: TJSObject): TJSPromise;
  var
    params: TJSObject;
  begin
    asm
      // non esiste altro modo per far arrivare i parametri...
      params = this.params || { };
    end;

    result := Base.count(dm, name, params, loadOptions);
  end;

  function _errorHandler(error: JSValue): TJSFunction;
  var
    e: TJSObject;
    msg: string;
  begin
    console.log(error);

    e := JS.ToObject(error);

    msg := JS.ToString(e['message']);

    raise Exception.Create(msg);
  end;

var
  options: TJSObject;
  Store: TdxCustomStore;
begin
  options := TJSObject.new;

  if key.contains(',') then
    asm
      options['key']  = key.split(',');
    end
  else
    options['key'] := key;

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
    Store = new DevExpress.data.CustomStore(options);
  end;

  result := Store;

  if assigned(params) then
    result['params'] := params;
end;

{ TjdxDataSource }
constructor TjdxDataSource.Create(aOwner: TComponent);
begin
  inherited;
  Fdm := '';
  Fdataset := '';
  Fkey := '';
  FDataSource := nil;
  FInitOptionsProc := nil;
  Fparams := TStringList.Create;
end;

destructor TjdxDataSource.Destroy;
begin
  inherited;
  FreeAndNil(Fparams);
end;

function TjdxDataSource.GetDataSource: TdxDataSource;
begin
  if not assigned(FDataSource) then
    FDataSource := CreateDataSource;

  result := FDataSource;
end;

function TjdxDataSource.GetStore: TdxCustomStore;
begin
  result := DataSource.Store;
end;

function TjdxDataSource.Load: TJSPromise;
begin
  ApplyParams;
  result := DataSource.Load();
end;

function TjdxDataSource.Reload: TJSPromise;
begin
  ApplyParams;
  result := DataSource.Reload();
end;

function TjdxDataSource.GetParamsObj: TJSObject;
var
  i: integer;
  name: string;
  Value: string;
begin
  result := TJSObject.new;

  for i := 0 to params.count - 1 do
  begin
    name := params.Names[i];
    Value := params.ValueFromIndex[i];
    result[name] := Value;
  end;
end;

procedure TjdxDataSource.SetParam(const ParamName, Value: string);
begin
  if params.IndexOf(ParamName) <> -1 then
    params.AddPair(ParamName, Value)
  else
    params.values[ParamName] := Value;
end;

procedure TjdxDataSource.Setparams(const Value: TStringList);
begin
  Fparams.Assign(Value);
  ApplyParams;
end;

function TjdxDataSource.Getparams: TStringList;
var
  o: TJSObject;
  map: TJSMap;
  entries: TJSArray;
  d: TJSDate;
  s: string;
begin

  // if assigned(FDataSource) then
  // begin
  // Fparams.Clear;
  //
  // o := Store.params;
  //
  // asm
  // entries = Object.entries(o);
  // end;
  //
  // map := TJSMap.new(entries);
  // map.forEach(
  // procedure(Value: JSValue; key: JSValue)
  // begin
  //
  // if JS.isDate(Value) then
  // begin
  // d := TJSDate(Value);
  // // s := d.toISOString; restituisce data errata
  // s := dxUtils.JSDateToStringISO(d);
  // Fparams.AddPair(JS.ToString(key), s)
  // end
  // else
  // Fparams.AddPair(JS.ToString(key), dxUtils.JSValueToString(Value));
  // end);
  // end;

  result := Fparams;
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
  Store.AddParam(field, Value);
end;

function TdxDataSourceHelper.GetParam(const field: string): JSValue;
begin
  result := Store.GetParam(field);
end;

procedure TdxDataSourceHelper.SetParam(const field: string; Value: JSValue);
begin
  Store.SetParam(field, Value);
end;

function TdxDataSourceHelper.Getparams: TJSObject;
begin
  result := Store.params;
end;

procedure TdxDataSourceHelper.Setparams(const Value: TJSObject);
begin
  Store.params := Value;
end;

procedure TjdxDataSource.ApplyParams;
var
  obj: TJSObject;
begin
  // if assigned(FDataSource) then
  // begin
  obj := GetParamsObj;
  Store.params := obj;
  // end;
end;

function TjdxDataSource.DefaultOptions: TJSObject;
begin
  result := new([]);
  result['dm'] := dm;
  result['name'] := dataset;
  result['store'] := CreateStore;
  result['paginate'] := false;
end;

function TjdxDataSource.CreateDataSource: TdxDataSource;
begin
  result := dxDataSource(DefaultOptions);
end;

function TjdxDataSource.CreateStore: TdxCustomStore;
var
  i: integer;
  o: TJSObject;
begin
  o := new([]);

  for i := 0 to params.count - 1 do
    o[params.Names[i]] := params.ValueFromIndex[i];

  result := dxStore(dm, dataset, key, o, nil);
end;

function TjdxDataSource.GetFields: TJSPromise;
begin
  result := Store.GetFields(dm, dataset);
end;

function TdxCustomStoreHelper.GetFields(const dm, dataset: string): TJSPromise;
begin
  result := Base.fields(dm, dataset);
end;

end.
