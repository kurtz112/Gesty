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

function JSOptions(const propertyName: string; propertyValue: JSValue): TJSObject;

function JSStringToArray(const s: string; const sep: string): TJSArray; assembler;
function JSValueToString(j: JSValue): string;
function JSObjectToString(o: TJSObject): String;
function JSObjectEntries(o: TJSObject): TJSArray; assembler;

function JSArray(items: array of JSValue): TJSArray; overload;
function JSArray(strings: TStrings): TJSArray; overload;

// ajax
function AjaxPost(const url, PostData: string; const parseResponse: boolean = true; const propertyName: string = ''): TJSPromise;
procedure AjaxSetup(JWT: string);

procedure DownloadPdf(const url, PostData: String);

function px(const value: integer): string;

implementation

uses
  zz.web.JsonResponse,
  zz.web.url,
  zz.web.JSClasses;

function JSOptions(const propertyName: string; propertyValue: JSValue): TJSObject;
begin
  result := TJSObject.new;
  result[propertyName] := propertyValue;
end;

function JSObjectEntries(o: TJSObject): TJSArray; assembler;
asm
 return Object.entries(o);
end;

function JSValueToString(j: JSValue): string;
begin
  if JS.isString(j) then
    result := JS.ToString(j)
  else
    if JS.isInteger(j) then
      result := trunc(JS.toNumber(j)).ToString
    else
      if JS.isNumber(j) then
        result := JS.toNumber(j).ToString
      else
        if JS.isBoolean(j) then
        begin
          if JS.toBoolean(j) then
            result := 'true'
          else
            result := 'false';
        end;
end;

function JSObjectToString(o: TJSObject): String;
var
  map: TJSMap;
  s: String;
begin
  result := '';

  map := TJSMap.new(JSObjectEntries(o));
  map.forEach(
    procedure(value: JSValue; key: JSValue)
    begin
      result := result + JS.ToString(key) + '=' + JSValueToString(value) + slineBreak;
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
/// ////////////////////////////////////////

procedure AjaxSetup(JWT: string);
var
  aSettings: TJSAjaxSettings;
  Headers: TJSObject;
begin
  Headers := TJSObject.new;
  Headers['Content-Type'] := 'application/json;charset=UTF-8'; // per postData
  Headers['Access-Control-Expose-Headers'] := '__JWT';
  Headers['__JWT'] := JWT;

  aSettings := TJSAjaxSettings.new;
  aSettings.method := 'POST';
  aSettings.Headers := Headers;

  // aSettings.Headers['Content-Type'] := 'application/json;charset=UTF-8'; // per postData
  // aSettings.Headers['Access-Control-Expose-Headers'] := '__JWT';
  // aSettings.Headers['__JWT'] := JWT;
  TJQuery.AjaxSetup(aSettings);
end;

function AjaxPost(const url, PostData: string; const parseResponse: boolean = true; const propertyName: string = ''): TJSPromise;
var
  d: TDeferred;
begin
  d := deferred();

  TJQuery.post(url, PostData).done(
    function(aData: JSValue; textStatus: string; aJQXHR: TJQXHR): boolean
    var
      JsonResponse: TJsonResponse;
      Data: TJSArray;
    begin

      // aJQXHR.getResponseHeader('__JWT');

      if not parseResponse then
        d.resolve(aData, aJQXHR)
      else
      begin
        JsonResponse := TJsonResponse.Create;
        try
          // JsonResponse.Parse(aData, true);
          JsonResponse.Parse(aData, false); // se true non permette il reject

          if JsonResponse.result then
          begin
            if propertyName.IsEmpty then
              d.resolve(JsonResponse.JSONObject, aJQXHR)
            else
              d.resolve(JsonResponse.JSONObject[propertyName], aJQXHR)
          end
          else
            d.reject(JsonResponse.ErrorMsg);
        finally
          freeAndNil(JsonResponse);
        end;
      end;
    end);

  result := d.promise();
end;

procedure DownloadPdf(const url, PostData: String);
var
  s: String;
begin
  s := url + '?' + PostData + '&__JWT=' + TUrl.JWT;
  // s := 'http://docs.google.com/gview?embedded=true&url=' + s;
  // s := 'https://drive.google.com/viewerng/viewer?embedded=true&url=' + s;
  // s := 'http://192.168.1.4/WtWebTest/test_download.pdf';

  window.open('web/viewer.html?file=' + encodeURIComponent(s));
end;

function px(const value: integer): string;
begin
  result := value.ToString + 'px';
end;

end.
