unit zz.web.json;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  JS,
  web,
  libjquery;

function Stringify(obj: TJSObject; viewFunc: boolean): string;
function Parse(s: string): TJSObject;

implementation

function newStringify(o: TJSObject; viewFunc: boolean): string;
begin

  asm
    return Flatted.stringify(o, null, 2);
  end;
end;

function KillFunc(o: TJSObject): TJSObject;
var
  key: string;
begin
  result := TJSObject.Assign(TJSObject.new, o);

  for key in TJSObject.keys(result) do
  begin
    if sameText(key, 'onContentReady') then
    begin
      console.log(jsTypeOf(result[key]));
      console.log(result[key]);
    end;

    if JS.isFunction(result[key]) then
      JSDelete(result, key)
    else
      if JS.isObject(result[key]) then
        KillFunc(JS.toObject(result[key]));
  end;
end;

function Stringify(obj: TJSObject; viewFunc: boolean): string;
var
  converter: JSValue;
  o: TJSObject;
begin
  result := '';

  o := TJSObject.Assign(TJSObject.new, obj);

  if assigned(o) then
  begin
    if o.hasOwnProperty('dataSource') then
      o['dataSource'] := nil;

    if not viewFunc then
      o := KillFunc(o);
  end;

  converter := function(key, val: JSValue): string
    begin

      asm
        if (key.startsWith("_")) {
        return undefined;
         }
      else
        if (val instanceof Element || val instanceof HTMLDocument) {
        return undefined;
         }
      else
        if (key == "__rawData") {
        return undefined;
         }
      else
        if (key == "_eventsStrategy") {
        return undefined;
         }
      else
        if (key == "integrationOptions") {
        return undefined;
         }
      else
        if (typeof val === 'function' || val && val.constructor === RegExp) {
        if (viewFunc) {
        return val.toString();
         }
        }
      else
        return val;
      end;
    end;

  result := TJSJSON.Stringify(o, converter, 2);

  if viewFunc then
    result := result.Replace('\r\n', slineBreak, [rfReplaceAll]);
end;

function cacheStringify(o: TJSObject; viewFunc: boolean): string;
var
  converter: JSValue;
begin
  result := '';

  if viewFunc then
  begin
    JSDelete(o, 'integrationOptions');
    JSDelete(o, 'dataSource');

    converter := function(key, val: JSValue): string
      begin
        asm
          let cache = [];

          if (typeof value === "object" && value !== null) {
          if (cache.indexOf(value) !== -1) {
          // Circular reference found, discard key
          return undefined;
           }
          // Store value in our collection
          cache.push(value);
          }

          if (key.startsWith("_")) {
          return undefined;
           }
        else
          if (val instanceof Element || val instanceof HTMLDocument) {
          return undefined;
           }
        else
          if (key == "__rawData") {
          return undefined;
           }
        else
          if (key == "_eventsStrategy") {
          return undefined;
           }
        else
          if (key == "integrationOptions") {
          return undefined;
           }
        else
          if (typeof val === 'function' || val && val.constructor === RegExp) {
          return val.toString();
           }
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

/// ///////////////////////////////////////

function newParse(s: string): TJSObject;
var
  tmp: string;
  j: JSValue;
begin
  tmp := s.Replace(slineBreak, ' ', [rfReplaceAll]);

  asm
    j = Flatted.parse(tmp);
  end;

  result := TJSObject(j);
end;

function Parse(s: string): TJSObject;
var
  reviver: JSValue;
  j: JSValue;
  tmp: string;
begin
  // https://stackoverflow.com/questions/18184626/parse-json-string-to-javascript-object-with-function-name

  tmp := s.Replace(slineBreak, ' ', [rfReplaceAll]);

  reviver := function(key, value: JSValue): JSValue
    var
      s: String;
      startBody, endBody: integer;
      startParams, endParams: integer;
      body, params: string;
      f: TJSFunction;
    begin
      result := value;

      if jsTypeOf(value) = 'string' then
      begin
        s := JS.ToString(value);

        if s.startsWith('function') then
          result := nil;

        // if s.startsWith('function') then
        // begin
        // startBody := s.IndexOf('{') + 1;
        // endBody := s.LastIndexOf('}');
        // startParams := s.IndexOf('(') + 1;
        // endParams := s.IndexOf(')');
        //
        // body := s.Substring(startBody, endBody - startBody).Trim;
        // body := body.Replace(slineBreak, '\r\n', [rfReplaceAll]).Trim;
        // params := s.Substring(startParams, endParams - startParams).Trim;
        //
        // console.log(body);
        //
        // asm
        // // f = new Function(value.substring(params, body));
        // f = new Function(params, body);
        // end;
        //
        // result := f;
        // end;
      end;
    end; // \reviver

  asm
    j = JSON.parse(tmp, reviver);
  end;

  result := TJSObject(j);
end;

end.
