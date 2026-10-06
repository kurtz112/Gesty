// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
library mod_gesty_server_24;

uses
  Web.WebBroker,
  zNet.Tls.OpenSsl,
  zNet.Tls.SChannel,
  Web.ApacheApp,
  Web.HTTPD24Impl,
  lib.Config in 'lib\lib.Config.pas',
  lib.ExceptionLogger in 'lib\lib.ExceptionLogger.pas',
  lib.Consts in 'lib\lib.Consts.pas',
  lib.Context in 'lib\lib.Context.pas',
  lib.JWT in 'lib\lib.JWT.pas',
  lib.JsonRest in 'lib\lib.JsonRest.pas',
  lib.mail in 'lib\lib.mail.pas',
  lib.DateISO in 'lib\lib.DateISO.pas',
  lib.DataRequest in 'lib\lib.DataRequest.pas',
  lib.datasetProps in 'lib\lib.datasetProps.pas',
  lib.widgetOptions in 'lib\lib.widgetOptions.pas',
  fib.StrUtil in 'lib\fib.StrUtil.pas',
  fib.SqlTxtRtns in 'lib\fib.SqlTxtRtns.pas',
  zz.Folders,
  {$IFNDEF LINUX}
  Winapi.ActiveX,
  System.Win.ComObj,
  {$ENDIF }
  routes in 'core\routes.pas',
  routes.attributes in 'core\routes.attributes.pas',
  route in 'core\route.pas' {Route: TDataModule},
  dmAdmin in 'dm\dmAdmin.pas' {Admin: TDataModule},
  dmRequests in 'dm\dmRequests.pas' {Requests},
  dmQuestionari in 'dm\dmQuestionari.pas' {Questionari: TDataModule},
  dmCAPAC in 'dm\dmCAPAC.pas' {CAPAC: TDataModule},
  dmCodebri in 'dm\dmCodebri.pas' {Codebri: TDataModule},
  dmMeta in 'dm\dmMeta.pas' {Meta: TDataModule},
  dmData in 'dm\dmData.pas' {Data: TDataModule},
  dmBase in 'dm\dmBase.pas' {Base: TDataModule},
  Server_Module in 'core\Server_Module.pas' {ServerModule: TWebModule};

{$R *.res}
// httpd.conf entries:
//
(*
  LoadModule gesty_server_24_module modules/mod_gesty_server_24.dll

  <Location /xyz>
  SetHandler mod_festy_server_24-handler
  </Location>
*)
//
// These entries assume that the output directory for this project is the apache/modules directory.
//
// httpd.conf entries should be different if the project is changed in these ways:
// 1. The TApacheModuleData variable name is changed
// 2. The project is renamed.
// 3. The output directory is not the apache/modules directory
//

// Declare exported variable so that Apache can access this module.
var
  GModuleData: TApacheModuleData;

exports
  GModuleData name 'gesty_server_24_module';

begin
{$IFNDEF LINUX}
  CoInitFlags := COINIT_MULTITHREADED;
{$ENDIF}
  Web.ApacheApp.InitApplication(@GModuleData);
  Application.Initialize;
  Application.WebModuleClass := WebModuleClass;
  Application.MaxConnections := 200;
  Application.Run;

end.
