unit lib.web;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  web.HTTPApp;

//function RequestParamCount(Request: TWebRequest): integer;
//function GetRequestParam(Request: TWebRequest; const ParamName: String): string; overload;
//function GetRequestParam(Request: TWebRequest; const idx: integer): string; overload;
//function GetRequestParamInt(Request: TWebRequest; const ParamName: String): integer;
//
//procedure Response_JSON(Response: TWebResponse; JSON: TJSONValue);
//procedure Response_Url(Response: TWebResponse; const url: string);
//procedure Response_Html(Response: TWebResponse; const html: string);
//procedure Response_File(Response: TWebResponse; const FileName: string; const ViewInBrowser: boolean = False; BrowserFileName: string = '');
//
//function GetContentType(FileName: String): string;

function CheckIP(Request: TWebRequest; const IP_FileName: string): boolean;

implementation

uses
  zz.SmartInspect,
  zz.Folders;

// uses
// IdGlobalProtocols;

//function RequestParamCount(Request: TWebRequest): integer;
//begin
//  result := Request.QueryFields.Count + Request.ContentFields.Count;
//end;
//
//function GetRequestParam(Request: TWebRequest; const idx: integer): string;
//begin
//  result := '';
//
//  if Request.MethodType = mtPost then
//  begin
//
//    if idx < Request.ContentFields.Count then
//      result := Request.ContentFields.ValueFromIndex[idx]
//    else
//      result := Request.QueryFields.ValueFromIndex[idx - Request.ContentFields.Count];
//  end
//  else
//  begin
//
//    if idx < Request.QueryFields.Count then
//      result := Request.QueryFields.ValueFromIndex[idx]
//    else
//      result := Request.ContentFields.ValueFromIndex[idx - Request.QueryFields.Count];
//  end;
//
//  SiMain.LogString('Param ' + idx.ToString, result);
//end;
//
//function GetRequestParam(Request: TWebRequest; const ParamName: String): string;
//begin
//  result := '';
//
//  if Request.MethodType = mtPost then
//  begin
//    result := Request.ContentFields.Values[ParamName];
//
//    if result = '' then
//      result := Request.QueryFields.Values[ParamName];
//  end
//  else
//  begin
//    result := Request.QueryFields.Values[ParamName];
//
//    if result = '' then
//      result := Request.ContentFields.Values[ParamName];
//  end;
//
//  SiMain.LogString(ParamName, result);
//end;
//
//function GetRequestParamInt(Request: TWebRequest; const ParamName: String): integer;
//var
//  s: String;
//begin
//  result := -1;
//  s := GetRequestParam(Request, ParamName);
//  TryStrToInt(s, result);
//end;
//
//procedure Response_JSON(Response: TWebResponse; JSON: TJSONValue);
//begin
//  Response.StatusCode := 200;
//  Response.ContentType := 'application/json';
//  Response.ContentEncoding := 'utf-8';
//  Response.Content := JSON.ToString;
//end;
//
//procedure Response_Url(Response: TWebResponse; const url: string);
//begin
//  Response.StatusCode := 200;
//  Response.ContentType := 'text/html';
//  Response.ContentEncoding := 'utf-8';
//  Response.Content := url;
//end;
//
//procedure Response_Html(Response: TWebResponse; const html: string);
//begin
//  Response.StatusCode := 200;
//  Response.ContentType := 'text/html';
//  Response.ContentEncoding := 'utf-8';
//  Response.Content := html;
//end;
//
//procedure Response_File(Response: TWebResponse; const FileName: string; const ViewInBrowser: boolean = False; BrowserFileName: string = '');
//var
//  FileStream: TFileStream;
//  MemStream: TMemoryStream;
//begin
//  FileStream := TFileStream.Create(FileName, fmOpenRead);
//  try
//    MemStream := TMemoryStream.Create; // distrutto da Response
//    MemStream.CopyFrom(FileStream, 0);
//    MemStream.Position := 0;
//  finally
//    FreeAndNil(FileStream);
//  end;
//
//  if ViewInBrowser then
//    Response.CustomHeaders.Values['content-disposition'] := 'inline'
//  else
//  begin
//    if BrowserFileName <> '' then
//      Response.CustomHeaders.Values['content-disposition'] := 'attachment;filename="' + ExtractFileName(BrowserFileName) + '"'
//    else
//      Response.CustomHeaders.Values['content-disposition'] := 'attachment;filename="' + ExtractFileName(FileName) + '"';
//
//    Response.CustomHeaders.Values['Content-Length'] := MemStream.Size.ToString;
//  end;
//
//  Response.StatusCode := 200;
//  Response.ContentType := GetContentType(FileName);
//  Response.ContentStream := MemStream;
//  Response.SendResponse;
//end;
//
//function GetContentType(FileName: String): string;
//// var
//// mime: TIdMimeTable;
//// begin
//// mime := TIdMimeTable.Create(true);
//// try
//// Result := mime.GetFileMIMEType(FileName);
//// finally
//// FreeAndNil(mime);
//// end;
//// end;
//var
//  mime: TStringList;
//begin
//  mime := TStringList.Create;
//  try
//    mime.Add('.bmp=image/bmp');
//    mime.Add('.gif=image/gif');
//    mime.Add('.ico=image/x-icon');
//    mime.Add('.jpg=image/jpeg');
//    mime.Add('.jpeg=image/jpeg');
//    mime.Add('.jpe=image/jpeg');
//    mime.Add('.png=image/png');
//    mime.Add('.txt=text/plain');
//    mime.Add('.avi=video/x-msvideo');
//    mime.Add('.mp3=video/mpeg');
//    mime.Add('.mp4=video/mpeg');
//    mime.Add('.mpeg=video/x-mpeg2a');
//    mime.Add('.7z=application/x-7z-compressed');
//    mime.Add('.gzip=application/x-gzip');
//    mime.Add('.gz=application/x-gzip');
//    mime.Add('.iso=application/x-iso9660-image');
//    mime.Add('.pdf=application/pdf');
//    mime.Add('.zip=application/x-zip-compressed');
//    mime.Add('.css=text/css');
//    mime.Add('.js=text/javascript');
//    mime.Add('.htm=text/html');
//    mime.Add('.html=text/html');
//    mime.Add('.xhtml=application/xhtml+xml');
//    mime.Add('.xht=application/xhtml+xml');
//    mime.Add('.rdf=application/rdf+xml');
//    mime.Add('.rss=application/rss+xml');
//    mime.Add('.xml=text/xml');
//
//    result := mime.Values[LowerCase(ExtractFileExt(FileName))];
//  finally
//    FreeAndNil(mime);
//  end;
//
//  if result = '' then
//    result := 'application/octet-stream';
//end;

function CheckIP(Request: TWebRequest; const IP_FileName: string): boolean;
var
  IP: TStringList;
  FileName: String;
  s: string;
begin
  result := True;

  FileName := TFolders.ModuleFolder + IP_FileName;

  if not FileExists(FileName) then
    Exit;

  IP := TStringList.Create;
  try
    IP.LoadFromFile(FileName);
    for s in IP do
      if s = Request.RemoteIP then // vedere quale algoritmo usare
        Exit(True);
  finally
    FreeAndNil(IP);
  end;
end;

end.
