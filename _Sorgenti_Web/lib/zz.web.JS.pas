unit zz.web.JS;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  WEBLib.Forms,
  JS,
  web,
  libjquery;

function ISO8601ToDate(const s: string): TDateTime;
function TryISO8601ToDate(const s: string; out Value: TDateTime): boolean;
function DateToISO8601(const Value: TDateTime): string;

function JSOptions(const PropertyName: string; propertyValue: JSValue): TJSObject;

function CompareObjects(obj1, obj2: TJSObject): boolean;

function GetObjectProp(obj: TJSObject; const propName: string): TJSObject;

function ISOStrToDateTimeJS(const s: String): TJSDate;
function JSDateToStringISO(Value: TJSDate): string;

function JSStringToArray(const s: string; const sep: string): TJSArray; assembler;
function JSObjectToString(o: TJSObject): String;
function JSObjectEntries(o: TJSObject): TJSArray; assembler;
function JSArray(items: array of JSValue): TJSArray; overload;
function JSArray(strings: TStrings): TJSArray; overload;

function JSValueToString(Value: JSValue): string;

function JSValueToDateTime(Value: JSValue): TDateTime;
function JSValueToInteger(Value: JSValue): integer;
function JSValueToNumber(Value: JSValue): double;

function jsonArray(items: array of JSValue): TJSArray;

procedure sleep(const milliseconds: integer);
procedure DebugString(const s: String);

function newArray(items: array of JSValue): TJSArray; overload;
function newArray(strings: TStrings): TJSArray; overload;
function newArray(const s: string; const sep: string): TJSArray; assembler; overload;

function isElement(el: JSValue): boolean; assembler;
function isJQuery(el: JSValue): boolean; assembler;

function JSArrayToString(a: TJSArray): string;

implementation

function JSOptions(const PropertyName: string; propertyValue: JSValue): TJSObject;
begin
  result := TJSObject.new;
  result[PropertyName] := propertyValue;
end;

function GetObjectProp(obj: TJSObject; const propName: string): TJSObject;
begin
  if obj.hasOwnProperty(propName) then
    result := TJSObject(obj[propName])
  else
    result := TJSObject.new;
end;

function JSObjectEntries(o: TJSObject): TJSArray; assembler;
asm
  return Object.entries(o);
end;

function JSValueToString(Value: JSValue): string;
begin

  if JS.isString(Value) then
    result := JS.ToString(Value)
  else
    if JS.isDate(Value) then
      result := TJSDate(Value).toDateString
    else
      if JS.isInteger(Value) then
        result := JS.toInteger(Value).ToString
      else
        if JS.isNumber(Value) then
          result := JS.ToNumber(Value).ToString
        else
          if JS.isBoolean(Value) then
          begin
            if JS.ToBoolean(Value) then
              result := 'Si'
            else
              result := 'No';
          end
          else
            result := '(?)';
end;

function JSObjectToString(o: TJSObject): String;
var
  map: TJSMap;
  s: String;
  d: TJSDate;
begin
  result := '';

  map := TJSMap.new(JSObjectEntries(o));
  map.forEach(
    procedure(Value: JSValue; key: JSValue)

    begin

      if JS.isDate(Value) then
      begin
        d := TJSDate(Value);
        // s := d.toISOString; restituisce data errata
        s := JSDateToStringISO(d);
        result := result + JS.ToString(key) + '=' + s + slineBreak
      end
      else
        if JS.isBoolean(Value) then
        begin

          if JS.ToBoolean(Value) then
            result := result + JS.ToString(key) + '=true' + slineBreak
          else
            result := result + JS.ToString(key) + '=false' + slineBreak;
        end
        else
          result := result + JS.ToString(key) + '=' + JSValueToString(Value) + slineBreak;
    end);
end;

function JSStringToArray(const s: string; const sep: string): TJSArray;
asm
  return s.split(sep);
end;

function JSArray(items: array of JSValue): TJSArray;
var
  v: JSValue;
begin
  result := TJSArray.new;

  for v in items do
    result.push(v);
end;

function JSArray(strings: TStrings): TJSArray; overload;
var
  s: string;
begin
  result := TJSArray.new;
  for s in strings do
    result.push(s);
end;

function JSValueToDateTime(Value: JSValue): TDateTime;
begin

  if JS.isDate(Value) then
    result := JSDateToDateTime(TJSDate(Value))
  else
    if JS.isString(Value) then
      result := JSDateToDateTime(ISOStrToDateTimeJS(JS.ToString(Value)));
end;

function JSValueToInteger(Value: JSValue): integer;
begin
  result := -1;

  if JS.isInteger(Value) then
    result := JS.toInteger(Value);
end;

function JSValueToNumber(Value: JSValue): double;
begin
  result := 0;

  if JS.isNumber(Value) then
    result := JS.ToNumber(Value);
end;

procedure sleep(const milliseconds: integer);
begin
  asm
    const date = Date.now();
    let currentDate = null;
    do {
    currentDate = Date.now();
     } while (currentDate - date < milliseconds);
  end;
end;

function CompareObjects(obj1, obj2: TJSObject): boolean;
var
  s1, s2: string;
begin
  asm
    s1 = Object.entries(obj1).sort().toString();
    s2 = Object.entries(obj2).sort().toString();
  end;

  result := s1 = s2;
end;

function JSDateToStringISO(Value: TJSDate): string;
begin
  result := DateToISO8601(JSValueToDateTime(Value));
end;

procedure DebugString(const s: String);
begin
  console.log(s);
end;

function ISOStrToDateTimeJS(const s: String): TJSDate;
var
  d: TDateTime;
begin
  d := ISO8601ToDate(s);
  result := DateTimeToJSDate(d);
end;

function ISO8601ToDate(const s: string): TDateTime;
var
  d: TDateTime;
begin

  if TryISO8601ToDate(s, d) then
    result := d
  else
    raise Exception.Create('Data non valida: ' + s);
end;

function TryISO8601ToDate(const s: string; out Value: TDateTime): boolean;
var
  fs: TFormatSettings;
  tmp: string;
begin
  // 2022-01-08T00:00:00.000Z
  result := False;
  fs := TFormatSettings.Create;
  fs.ShortDateFormat := 'YYYY-MM-DDTHH:mm:ss:zzzZ';
  fs.ShortDateFormat := 'YYYY-MM-DD';
  fs.DateSeparator := '-';
  fs.TimeSeparator := ':';

  tmp := s.Replace('T', ' ').Replace('Z', '').Replace('/', '-');
  result := TryStrToDateTime(tmp, Value, fs);
end;

function DateToISO8601(const Value: TDateTime): string;
begin
  // lasciare tra doppi apici
  result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', Value);
  // result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss"Z"', Value);
  // result := FormatDateTime('yyyy-mm-dd hh:nn:ss', Value);
end;

function jsonArray(items: array of JSValue): TJSArray;
var
  v: JSValue;
begin
  result := TJSArray.new;

  for v in items do
    result.push(v);
end;

function removeCircular(obj: TJSObject): TJSObject; assembler;
asm
  const seen = new Map();
  const recurse = obj => {
  seen.set(obj,true);
  for( let [k, v] of Object.entries(obj)) {
  if( typeof v !== "object") continue;
  if(seen.has(v)) delete obj[k];
  else
  if (v)
  recurse(v);
   }
  }
  recurse(obj);
end;

function isCyclic(obj: TJSObject): boolean; assembler;
asm
  var seenObjects = [];

  function detect (obj) {
  if (obj && typeof obj === 'object') {
  if (seenObjects.indexOf(obj) !== -1) {
  return true;
   }
  seenObjects.push(obj);
  for (var key in obj) {
  if (obj.hasOwnProperty(key) && detect(obj[key])) {
  console.log(obj, 'cycle at ' + key);
  return true;
   }
  }
  }
  return false;
  }

  return detect(obj);
end;

function newArray(const s: string; const sep: string): TJSArray;
asm
  return s.split(sep);
end;

function newArray(items: array of JSValue): TJSArray;
var
  v: JSValue;
begin
  result := TJSArray.new;

  for v in items do
    result.push(v);
end;

function newArray(strings: TStrings): TJSArray; overload;
var
  s: string;
begin
  result := TJSArray.new;
  for s in strings do
    result.push(s);
end;

function isElement(el: JSValue): boolean;
asm
  return el instanceof Element || el instanceof HTMLDocument;
end;

function isJQuery(el: JSValue): boolean;
asm
  return el instanceof JQuery;
end;

function JSArrayToString(a: TJSArray): string;
begin
  result := a.join(slineBreak);
end;

end.
