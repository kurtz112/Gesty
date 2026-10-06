unit DevExtreme.Data.JS;
{$MODE objfpc}
{$MODESWITCH externalclass}

interface

uses
  System.SysUtils,
  System.Classes,
  DevExtreme.Types,
  JS;

type
  TdxArrayStore = class
    external name 'DevExpress.data.ArrayStore'(TJSObject)public
    function byKey(key: JSValue): TJSPromise;
    procedure clear;
    function createQuery(): TJSObject;
    function insert(values: TJSObject): TJSPromise;
    function key(key: JSValue): JSValue;
    function keyOf(obj: TJSObject): JSValue;
    function load(): TJSPromise;
    function load(options: TJSObject): TJSPromise;
    // function push(changes)Pushes data changes to the store and notifies the DataSource.
    function remove(key: JSValue): TJSPromise;
    function totalCount(options: TJSObject): TJSPromise;
    function update(key: JSValue; values: TJSObject): TJSPromise;
  end;

  TdxCustomStore = class
    external name 'DevExpress.data.CustomStore'(TJSObject)public
    function byKey(key: JSValue): TJSPromise;
    procedure clearRawDataCache();
    function insert(values: TJSObject): TJSPromise;
    function key(key: JSValue): JSValue;
    function keyOf(obj: TJSObject): JSValue;
    function load(): TJSPromise;
    function load(options: TJSObject): TJSPromise;
    // function push(changes)Pushes data changes to the store and notifies the DataSource.
    function remove(key: JSValue): TJSPromise;
    function totalCount(options: TJSObject): TJSPromise;
    function update(key: JSValue; values: TJSObject): TJSPromise;
  end;

  TdxDataSource = class
    external name 'DevExpress.data.DataSource'(TJSObject)public
    procedure option(name: string; optionValue: JSValue);
    function items: TJSArray;
    function load(): TJSPromise;
    function load(options: TJSObject): TJSPromise;
    function loadOptions: TJSObject;
    function store(): TdxCustomStore; // occhio!
    function reload(): TJSPromise;
    function totalCount(): integer;

    function pageIndex(): integer;
    procedure pageIndex(newIndex: integer);
  end;

implementation

end.
