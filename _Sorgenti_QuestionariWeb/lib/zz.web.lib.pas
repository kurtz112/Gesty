unit zz.web.lib;

interface

uses
  SysUtils,
  Classes,
  js,
  web;

function jsonArray(items: array of JSValue): TJSArray;

implementation

/// ///////////////////////////////////////////

function jsonArray(items: array of JSValue): TJSArray;
var
  v: JSValue;
begin
  Result := TJSArray.new;

  for v in items do
    Result.push(v);
end;

end.
