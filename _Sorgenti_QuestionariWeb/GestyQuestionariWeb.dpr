// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program GestyQuestionariWeb;

uses
  Vcl.Forms,
  WEBLib.Forms,
  mainFrm in 'mainFrm.pas' {Main: TWebForm} {*.html},
  images in 'images.pas',
  zz.web.DataRequest in 'lib\zz.web.DataRequest.pas',
  zz.web.html in 'lib\zz.web.html.pas',
  zz.web.JS in 'lib\zz.web.JS.pas',
  zz.web.JSClasses in 'lib\zz.web.JSClasses.pas',
  zz.web.JsonResponse in 'lib\zz.web.JsonResponse.pas',
  zz.web.lib in 'lib\zz.web.lib.pas',
  zz.web.LZX in 'lib\zz.web.LZX.pas',
  zz.web.url in 'lib\zz.web.url.pas',
  zz.web.user in 'lib\zz.web.user.pas',
  common in 'common.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
