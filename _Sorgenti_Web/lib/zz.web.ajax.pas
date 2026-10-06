unit zz.web.ajax;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  WEBLib.Forms,
  JS,
  web,
  libjquery;

function AjaxPost(const url, PostData: string; const parseResponse: boolean = true; const propertyName: string = ''): TJSPromise; overload;
procedure AjaxPost(const url, PostData: string; proc: TJQXHRDoneHandler); overload;

procedure AjaxSetup(JWT: string);

procedure DownloadPdf(const url, PostData: String);

implementation

uses
  WEBLib.utils,
  zz.web.JsonResponse,
  zz.web.url,
  zz.web.JSClasses;

procedure AjaxSetup(JWT: string);
var
  aSettings: TJSAjaxSettings;
  Headers: TJSObject;
begin
  Headers := TJSObject.new;
  Headers['Content-Type'] := 'application/json;charset=UTF-8'; // per postData
  // Headers['Authorization'] := 'Bearer ' + JWT;

  // Headers['Access-Control-Expose-Headers'] := '__JWT';
  // Headers['__JWT'] := JWT;

  aSettings := TJSAjaxSettings.new;
  aSettings.method := 'POST';
  aSettings.Headers := Headers;
  aSettings.beforeSend := function(aHXR: TJQXHR; aOptions: TJSAjaxSettings): boolean
    begin
      result := true;

      if not JWT.IsEmpty then
        aHXR.setRequestHeader('Authorization', 'Bearer ' + JWT);
    end;

  TJQuery.AjaxSetup(aSettings);
end;

procedure AjaxPost(const url, PostData: string; proc: TJQXHRDoneHandler);
begin
  TJQuery.post(url, PostData).done(proc);
end;

function AjaxPost(const url, PostData: string; const parseResponse: boolean = true; const propertyName: string = ''): TJSPromise;
var
  JQXHR: TJQXHR;
  d: TDeferred;
begin
  d := deferred();

  JQXHR := TJQuery.post(url, PostData);

  JQXHR.done(
    function(aData: JSValue; textStatus: string; aJQXHR: TJQXHR): boolean
    var
      JsonResponse: TJsonResponse;
      Data: TJSArray;
    begin

      if not parseResponse then
        d.resolve(aData, aJQXHR)
      else
      begin
        JsonResponse := TJsonResponse.Create;
        try
          JsonResponse.Parse(aData, false);

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

  JQXHR.fail(
    function(aJQXHR: TJQXHR; textStatus: string; AErrorThrown: JSValue): boolean
    begin
      d.reject(textStatus);
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

end.
