// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program GestyServerApp;
{$APPTYPE GUI}

uses
  System.SysUtils,
  zNet.Tls.OpenSsl,
  zNet.Tls.SChannel,
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  MainFrm in 'core\MainFrm.pas' {MainForm},
  lib.Config in 'lib\lib.Config.pas',
  lib.ExceptionLogger in 'lib\lib.ExceptionLogger.pas',
  lib.Consts in 'lib\lib.Consts.pas',
  lib.Context in 'lib\lib.Context.pas',
  lib.JWT in 'lib\lib.JWT.pas',
  lib.JsonRest in 'lib\lib.JsonRest.pas',
  lib.mail in 'lib\lib.mail.pas',
  lib.DateISO in 'lib\lib.DateISO.pas',
  lib.http in 'lib\lib.http.pas',
  lib.DataRequest in 'lib\lib.DataRequest.pas',
  lib.datasetProps in 'lib\lib.datasetProps.pas',
  lib.widgetOptions in 'lib\lib.widgetOptions.pas',
  zz.Folders,
  fib.StrUtil in 'lib\fib.StrUtil.pas',
  fib.SqlTxtRtns in 'lib\fib.SqlTxtRtns.pas',
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
  Server_Module in 'core\Server_Module.pas' {ServerModule: TWebModule},
  DataSetFieldProps in 'lib\DataSetFieldProps.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;

  ForceDirectories(TFolders.ModuleFolder + 'log');
  // CurrentEurekaLogOptions.OutputPath := TFolders.ModuleFolder + 'log';

  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;

  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.



// dm Folder
// -- dataset folder
// ----- datasetName.json // contiene: (TableName, PrimaryKeyFields, CanInsert, CanUpdate, CanDelete)
// ----- datasetName.insert.sql
// ----- datasetName.update.sql
// ----- datasetName.delete.sql
// ----- datasetName.count.sql
// ----- cards folder
// -------- datasetName.card.json
// -------- cardId.card.json
// ----- views folder
// -------- datasetName.view.json
// -------- viewId.view.json
// ----- folder altri oggetti
