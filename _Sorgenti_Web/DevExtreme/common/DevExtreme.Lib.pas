unit DevExtreme.Lib;

interface

uses
  System.SysUtils,
  System.Classes,
  DevExtreme.types,
  JS;

type
  TdxUtils = record
  public // Date
    class function ISO8601ToDate(const s: string): TDateTime; static;
    class function TryISO8601ToDate(const s: string; out Value: TDateTime): boolean; static;
    class function DateToISO8601(const Value: TDateTime): string; static;

    class function ISOStrToDateTimeJS(const s: string): TJSDate; static;
    class function JSDateToStringISO(Value: TJSDate): string; static;
  public // JSValue
    class function JSValueToString(Value: JSValue): string; static;
    class function JSValueToDateTime(Value: JSValue): TDateTime; static;
    class function JSValueToInteger(Value: JSValue): Integer; static;
    class function JSValueToNumber(Value: JSValue): double; static;
  public // JSObject
    class function CompareObjects(obj1, obj2: TJSObject): boolean; static;
    class function GetObjectProp(obj: TJSObject; const propName: string): TJSObject; static;

    class function JSObjectToString(o: TJSObject): String; static;
    class function JSObjectEntries(o: TJSObject): TJSArray; static;

    class function StringsToJSObject(strings: TStrings): TJSObject; static;

    class function Stringify(o: TJSObject; viewFunc: boolean): string; static;
    class function Parse(s: string): TJSObject; static;
  end;

function newArray(items: array of JSValue): TJSArray; overload;
function newArray(strings: TStrings): TJSArray; overload;
function newArray(const s: string; const sep: string): TJSArray; assembler; overload;

var
  dxUtils: TdxUtils;

implementation

class function TdxUtils.GetObjectProp(obj: TJSObject; const propName: string): TJSObject;
begin
  if obj.hasOwnProperty(propName) then
    result := TJSObject(obj[propName])
  else
    result := TJSObject.new;
end;

class function TdxUtils.JSObjectEntries(o: TJSObject): TJSArray;
asm
  return Object.entries(o);
end;

class function TdxUtils.JSValueToString(Value: JSValue): string;
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

class function TdxUtils.JSObjectToString(o: TJSObject): String;
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
        s := TdxUtils.JSDateToStringISO(d);
        result := result + JS.ToString(key) + '=' + s + slineBreak
      end
      else
        result := result + JS.ToString(key) + '=' + TdxUtils.JSValueToString(Value) + slineBreak;
    end);
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

class function TdxUtils.JSValueToInteger(Value: JSValue): Integer;
begin
  result := -1;

  if JS.isInteger(Value) then
    result := JS.toInteger(Value);
end;

class function TdxUtils.JSValueToNumber(Value: JSValue): double;
begin
  result := 0;

  if JS.isNumber(Value) then
    result := JS.ToNumber(Value);
end;

class function TdxUtils.CompareObjects(obj1, obj2: TJSObject): boolean;
var
  s1, s2: string;
begin
  asm
    s1 = Object.entries(obj1).sort().toString();
    s2 = Object.entries(obj2).sort().toString();
  end;

  result := s1 = s2;
end;

class function TdxUtils.ISOStrToDateTimeJS(const s: string): TJSDate;
var
  d: TDateTime;
begin
  d := TdxUtils.ISO8601ToDate(s);
  result := DateTimeToJSDate(d);
end;

class function TdxUtils.ISO8601ToDate(const s: string): TDateTime;
var
  d: TDateTime;
begin

  if TdxUtils.TryISO8601ToDate(s, d) then
    result := d
  else
    raise Exception.Create('Data non valida: ' + s);
end;

class function TdxUtils.TryISO8601ToDate(const s: string; out Value: TDateTime): boolean;
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

class function TdxUtils.DateToISO8601(const Value: TDateTime): string;
begin
  // lasciare tra doppi apici
  result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', Value);
  // result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss"Z"', Value);
  // result := FormatDateTime('yyyy-mm-dd hh:nn:ss', Value);
end;

class function TdxUtils.JSDateToStringISO(Value: TJSDate): string;
begin
  result := TdxUtils.DateToISO8601(TdxUtils.JSValueToDateTime(Value));
end;

class function TdxUtils.JSValueToDateTime(Value: JSValue): TDateTime;
begin

  if JS.isDate(Value) then
    result := JSDateToDateTime(TJSDate(Value))
  else
    if JS.isString(Value) then
      result := JSDateToDateTime(TdxUtils.ISOStrToDateTimeJS(JS.ToString(Value)));
end;

class function TdxUtils.Stringify(o: TJSObject; viewFunc: boolean): string;
var
  converter: JSValue;
begin
  result := '';

  if viewFunc then
  begin
    converter := function(key, val: JSValue): string
      begin
        asm
          if (typeof val === 'function' || val && val.constructor === RegExp)
          return val.toString();
        else
          return val;
        end;
      end;
  end
  else
    converter := nil;

  result := TJSJSON.Stringify(o, converter, 2);

  if viewFunc then
  begin
    result := result.Replace('\r\n', slineBreak, [rfReplaceAll]);
    // Result := Result.Replace('\"', '"', [rfReplaceAll]);
  end;
end;

class function TdxUtils.Parse(s: string): TJSObject;
var
  reviver: JSValue;
  j: JSValue;
  tmp: string;
begin
  // https://stackoverflow.com/questions/18184626/parse-json-string-to-javascript-object-with-function-name

  tmp := s.Replace(slineBreak, ' ', [rfReplaceAll]);

  reviver := function(key, Value: JSValue): JSValue
    var
      s: String;
      startBody, endBody: Integer;
      startParams, endParams: Integer;
      body, params: string;
      f: TJSFunction;
    begin
      result := Value;

      if jsTypeOf(Value) = 'string' then
      begin
        s := JS.ToString(Value);

        if s.StartsWith('function') then
        begin
          startBody := s.IndexOf('{') + 1;
          endBody := s.LastIndexOf('}');
          startParams := s.IndexOf('(') + 1;
          endParams := s.IndexOf(')');

          body := s.Substring(startBody, endBody - startBody).Trim;
          body := body.Replace(slineBreak, '\r\n', [rfReplaceAll]).Trim;
          params := s.Substring(startParams, endParams - startParams).Trim;

          asm
            // f = new Function(value.substring(params, body));
            f = new Function(params, body);
          end;

          result := f;
        end;
      end;
    end; // \reviver

  asm
    j = JSON.parse(tmp, reviver);
  end;

  result := TJSObject(j);
end;

class function TdxUtils.StringsToJSObject(strings: TStrings): TJSObject;
var
  i: Integer;
begin
  result := new([]);

  for i := 0 to strings.Count - 1 do
    result[strings.Names[i]] := strings.ValueFromIndex[i];
end;

end.
