unit zz.web.fetch;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  WEBLib.Forms,
  libserviceworkers,
  JS,
  web,
  libjquery,
  zz.web.DataRequest;

// classi in libserviceworkers

function defaultHeaders: TJSHeaders; assembler;

function Request(const url: string; options: TJSObject): TJSRequest; assembler;
function RequestOptions(const url, method, ContentType: string; headers: TJSHeaders; const credentials: string; body: string): TJSObject;

[async]
function fetch(Request: TJSRequest): TJSResponse; overload;

[async]
function fetch(const url, PostData: string; const parseResponse: boolean = true; const propertyName: string = ''): TJSPromise; overload;

[async]
function fetch(const RequestType: TDataRequestType; const dm, name, KeyValues, params: string; loadOptions: TJSObject = nil; const propertyName: string = 'data'): TJSPromise; overload;

/// /////////////////////////////////////////////////////////////////

procedure DownloadPdf(const url, PostData: String);

implementation

uses
  WEBLib.utils,
  zz.web.JsonResponse,
  zz.web.url,
  zz.web.JSClasses;

function defaultHeaders: TJSHeaders;
asm
  return new Headers;
end;

function Request(const url: string; options: TJSObject): TJSRequest;
asm
  return new Request(url, options);
end;

function RequestOptions(const url, method, ContentType: string; headers: TJSHeaders; const credentials: string; body: string): TJSObject;
  function getHeaders: TJSHeaders;
  begin
    result := headers;

    if not assigned(result) then
      result := defaultHeaders;

    if result.has('Content-Type') then
      result.set_('Content-Type', ContentType)
    else
      result.append('Content-Type', ContentType);

    if not TUrl.JWT.IsEmpty then
    begin

      if result.has('Authorization') then
        result.set_('Authorization', 'Bearer ' + TUrl.JWT)
      else
        result.append('Authorization', 'Bearer ' + TUrl.JWT);
    end;
  end;

begin
  result := TJSObject.new;

  result['method'] := method;
  result['url'] := url;
  result['headers'] := getHeaders;
  //

  if not credentials.IsEmpty then
    result['credentials'] := credentials;

  if not body.IsEmpty then
    result['body'] := body;
end;

function fetch(Request: TJSRequest): TJSResponse;
begin
  result := TJSResponse(window.fetch(Request));
end;

function fetch(const url, PostData: string; const parseResponse: boolean = true; const propertyName: string = ''): TJSPromise; overload;
begin
  result := TJSPromise.new(
    procedure(resolve, reject: TJSPromiseResolver)
    var
      ReqOptions: TJSObject;
      req: TJSRequest;
    begin
      ReqOptions := RequestOptions(url, 'POST', 'application/json', nil, '', PostData);
      req := Request(url, ReqOptions);

      fetch(req)._then(
        function(aValue: JSValue): JSValue
        begin
          TJSResponse(aValue).json()._then(
            function(aValue: JSValue): JSValue
            var
              JsonResponse: TJsonResponse;
            begin

              if not parseResponse then
                resolve(aValue)
              else
              begin
                JsonResponse := TJsonResponse.create;
                try
                  JsonResponse.Parse(aValue, false);

                  if JsonResponse.result then
                  begin
                    if JsonResponse.JSONObject <> nil then
                    begin
                      if propertyName.IsEmpty then
                        resolve(JsonResponse.JSONObject)
                      else
                        resolve(JsonResponse.JSONObject[propertyName]);
                    end
                    else
                      resolve(JsonResponse.JSONValue);
                  end
                  else
                    reject(JsonResponse.ErrorMsg);
                finally
                  FreeAndNil(JsonResponse);
                end;
              end;
            end);
        end);
    end);
end;

function fetch(const RequestType: TDataRequestType; const dm, name, KeyValues, params: string; loadOptions: TJSObject = nil; const propertyName: string = 'data'): TJSPromise;
var
  Data: string;
begin
  Data := TDataRequest.GetDataRequest(RequestType, dm, name, KeyValues, params, loadOptions);
  result := fetch(TUrl.DataRequest, Data, true, propertyName);
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

end.
