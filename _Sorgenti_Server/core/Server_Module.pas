unit Server_Module;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Web.HTTPApp,
  Data.DB,
  FireDAC.Phys.FBDef,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Phys.IBBase,
  IPPeerServer,
  lib.Context,
  DbxCompressionFilter,
  System.UITypes,
  FireDAC.Stan.StorageJSON,
  FireDAC.ConsoleUI.Wait,
  FireDAC.Comp.UI,
  routes,
  lib.DataRequest;

type
  TRouteProc = Procedure(Context: TzContext; Request: TWebRequest; Response: TWebResponse) of object;

  TServerModule = class(TWebModule)
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDStanStorageJSONLink: TFDStanStorageJSONLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    procedure WebModuleCreate(Sender: TObject);
    procedure WebModuleDestroy(Sender: TObject);
    procedure WebModuleDefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleAfterDispatch(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleException(Sender: TObject; E: Exception; var Handled: Boolean);
  private
  public
    routes: TRoutes;
  end;

var
  WebModuleClass: TComponentClass = TServerModule;

type
  TLogProcedure = procedure(Request: TWebRequest; Response: TWebResponse) of Object;

var
  BeforeRequestLogProcedure: TLogProcedure = nil;
  AfterRequestLogProcedure: TLogProcedure = nil;

  OptionsDictionary: TDictionary<string, string>;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses
  System.Json,
  Winapi.ActiveX,
  dmAdmin,
  zz.Folders,
  zz.SmartInspect,
  lib.Config,
  lib.JsonRest,
  lib.Consts,
  lib.mail,
  lib.JWT,
  zz.Strings,
  IdHTTPWebBrokerBridge, // per Maggioli
  IdHTTPHeaderInfo, // per Maggioli
  zNet.Tls,
  lib.ExceptionLogger;

threadvar CurrentRequest: TWebRequest;

{$R *.dfm}

//
/// //// dump Header, solo da win32: non funziona per Apache
type
  TIdHTTPAppRequestHelper = class helper for TIdHTTPAppRequest
  public
    function GetRequestInfo: TIdEntityHeaderInfo;
  end;

function TIdHTTPAppRequestHelper.GetRequestInfo: TIdEntityHeaderInfo;
begin
  Result := FRequestInfo;
end;

procedure TServerModule.WebModuleCreate(Sender: TObject);
var
  Params: TStrings;

begin
  inherited;
  siMain.EnterMethod('Create', TColors.Darkcyan, true);
  // CoInitialize(nil);
  siMain.LogString('ModuleName', TFolders.ModuleName);
  siMain.LogString('ModuleFolder', TFolders.ModuleFolder);
  siMain.LogString('IniFileName', TFolders.IniFileName);
  siMain.LogBoolean('ModuleIsLib', ModuleIsLib);
  siMain.LogString('ParamStr(1)', ParamStr(1));
  siMain.LogString('VendorLib/ClientLibrary', ConfigProps.ClientLibrary);

  FDPhysFBDriverLink.VendorLib := ConfigProps.ClientLibrary;
  routes := TRoutes.Create;

  //
  // Motore TLS per tutte le comunicazioni Indy di questo processo (posta,
  // FTP): scelto dall'installazione tramite l'INI, non dal .dpr. Entrambi i
  // provider (zNet.Tls.OpenSsl, zNet.Tls.SChannel) sono sempre inclusi nel
  // progetto: da qui in avanti CreaIOHandlerTls usa quello scelto qui.
  siMain.LogString('TlsEngine', ConfigProps.TlsEngine);
  zNet.Tls.SelezionaProviderTls(ConfigProps.TlsEngine);

  //
  siMain.LogString('OpenSSLPath', ConfigProps.OpenSSLPath);
  if not ConfigProps.OpenSSLPath.IsEmpty then
  begin
    if DirectoryExists(ConfigProps.OpenSSLPath) then
    begin
      // Non fa nulla se il motore selezionato sopra non e' OPENSSL: vedi
      // zNet.Tls.ImpostaCartellaLibrerieTLS.
      zNet.Tls.ImpostaCartellaLibrerieTLS(ConfigProps.OpenSSLPath);
      siMain.LogVerbose('OpenSSLPath settato');
    end
    else
      siMain.LogVerbose('OpenSSLPath: cartella non trovata.');
  end;

  siMain.LeaveMethod('Create', true);
end;

procedure TServerModule.WebModuleDestroy(Sender: TObject);
begin
  siMain.EnterMethod('Destroy', TColors.Red, true);
  // CoUninitialize;

  FreeAndNil(routes);
  inherited;

  siMain.LeaveMethod('Destroy', true);
end;

procedure TServerModule.WebModuleBeforeDispatch(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  I: Integer;
  name: string;
  s: string;
  value: string;
begin
  siMain.EnterMethod('BeforeDispatch', TColors.Steelblue, true);
  try
    CurrentRequest := Request;

    siMain.LogString('Classname', Request.ClassName);
    siMain.LogString('Method', Request.Method);
    siMain.LogString('URL', Request.URL);
    siMain.LogString('Query', Request.Query);
    siMain.LogString('PathInfo', Request.PathInfo);
    siMain.LogString('RawPathInfo', Request.RawPathInfo);
    siMain.LogString('From', Request.From);
    siMain.LogString('RemoteAddr', Request.RemoteAddr);
    siMain.LogString('RemoteIP', Request.RemoteIP);
    siMain.LogString('Authorization', Request.Authorization);
    siMain.LogString('Accept', Request.Accept);
    siMain.LogString('ContentType', Request.ContentType);
    siMain.LogString('Content', Request.Content);
    siMain.LogString('ContentEncoding', Request.ContentEncoding);
    siMain.LogString('RawContent', TEncoding.UTF8.GetString(Request.RawContent));

    /// //// dump Header, solo da win32: non funziona per Apache
    if Request is TIdHTTPAppRequest then
    begin
      siMain.LogInteger('HeadersCount', TIdHTTPAppRequest(Request).GetRequestInfo.RawHeaders.Count);
      for I := 0 to TIdHTTPAppRequest(Request).GetRequestInfo.RawHeaders.Count - 1 do
      begin
        name := TIdHTTPAppRequest(Request).GetRequestInfo.RawHeaders.Names[I];
        value := TIdHTTPAppRequest(Request).GetRequestInfo.RawHeaders.Values[name];

        siMain.LogString(name, value);
      end;
    end;

    // siMain.LogStringList('CustomHeaders', Request.CustomHeaders);
    siMain.LogStringList('QueryFields', Request.QueryFields);

    if not Request.PathInfo.StartsWith('/upload') then
      siMain.LogStringList('ContentFields', Request.ContentFields);

    if Assigned(BeforeRequestLogProcedure) then
      BeforeRequestLogProcedure(Request, Response);

    /// ///////////////////////////////////////////////////
    /// CORS
    ///

    if Request.Method = 'OPTIONS' then
    begin
      // cassato da OWASP
      { TODO : rivedere }
      Response.SetCustomHeader('Access-Control-Allow-Origin', '*');

      s := Request.GetFieldByName('Access-Control-Request-Headers').Trim;

      if not s.IsEmpty then
      begin
        Response.SetCustomHeader('Access-Control-Allow-Headers', s);
        Handled := true;
      end;
    end;

    /// ///////////////////////////////////////////////////
  finally
    siMain.LeaveMethod('BeforeDispatch', true);
  end;
end;

procedure TServerModule.WebModuleDefaultHandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Handled := routes.HandleRequest(Request, Response);

  if not Handled then
    Response.SetContentHTML('<html>' + '<head><title>Gesty Server</title></head>' + '<body>Gesty Server: ' + Request.PathInfo + '</body>' + '</html>');
end;

procedure TServerModule.WebModuleAfterDispatch(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  siMain.EnterMethod('AfterDispatch', TColors.Palegreen, true);
  try
    siMain.LogString('Request.Method', Request.Method);
    siMain.LogString('Request.URL', Request.URL);
    siMain.LogString('Request.PathInfo', Request.PathInfo);
    siMain.LogString('Request.RawPathInfo', Request.RawPathInfo);

    siMain.LogStringList('Request.QueryFields', Request.QueryFields);

    if not Request.PathInfo.StartsWith('/upload') then
      siMain.LogStringList('Request.ContentFields', Request.ContentFields);

    siMain.LogBoolean('Handled', Handled);
    siMain.LogStringList('Response.CustomHeaders', Response.CustomHeaders);
    siMain.LogInteger('Response.StatusCode', Response.StatusCode);
    siMain.LogString('Response.Location', Response.Location);
    siMain.LogString('Response.Content', Response.Content);
    siMain.LogString('Response.ContentType', Response.ContentType);
    siMain.LogInteger('Response.ContentLength', Response.ContentLength);
    siMain.LogString('Response.ContentEncoding', Response.ContentEncoding);

    if Assigned(AfterRequestLogProcedure) then
      AfterRequestLogProcedure(Request, Response);
  finally
    CurrentRequest := nil;
    siMain.LeaveMethod('AfterDispatch', true);
  end;
end;

procedure TServerModule.WebModuleException(Sender: TObject; E: Exception; var Handled: Boolean);
begin
  Handled := False;
  siMain.LogSeparator;
  siMain.LogException(E);
  SaveExceptionLog(E, CurrentRequest);
  CurrentRequest := nil;
end;

initialization

OptionsDictionary := TDictionary<string, string>.Create;

finalization

FreeAndNil(OptionsDictionary);

end.
