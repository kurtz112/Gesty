// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program GestyTools;

uses
  Vcl.Forms,
  zTranslate.Apply,
  zNet.Tls,
  zNet.Tls.OpenSsl,
  zNet.Tls.SChannel,
  MainFrm in 'MainFrm.pas' {MainForm} ,
  GestyTools.Config in 'GestyTools.Config.pas',
  GestyTools.Update in 'GestyTools.Update.pas' {UpdateEngine: TDataModule} ,
  GestyTools.FTP in 'GestyTools.FTP.pas' {FTP: TDataModule} ,
  GestyTools.Script in 'GestyTools.Script.pas' {ScriptModule: TDataModule} ,
  GestyTools.Script.Editor in 'GestyTools.Script.Editor.pas' {ScriptEditor: TForm} ,
  GestyTools.Script.Editor.Evalute in 'GestyTools.Script.Editor.Evalute.pas' {ScriptEditorEvalute} ,
  GestyTools.Script.Editor.ColorDialog in 'GestyTools.Script.Editor.ColorDialog.pas' {ScriptEditorColorDialog} ,
  GestyTools.Config.Editor in 'GestyTools.Config.Editor.pas' {FormConfig} ,
  GestyTools.Connection in 'GestyTools.Connection.pas' {Connection: TDataModule} ,
  GestyTools.Log in 'GestyTools.Log.pas',
  GestyTools.Mail in 'GestyTools.Mail.pas' {Mail: TDataModule} ,
  GestyTools.Candidature in 'GestyTools.Candidature.pas' {ImportCandidature: TDataModule} ,
  Mantis.Client in 'Mantis.Client.pas',
  GestyTools.Mantis in 'GestyTools.Mantis.pas';

{$R *.res}

begin

  Config.load;

  // Motore TLS per tutte le comunicazioni Indy di questo processo (posta,
  // FTP): scelto dalla configurazione (GestyTools.lz), non dal .dpr.
  // Prima di qualunque form/DataModule, come IdOpenSSLSetLibPath faceva
  // in MainFrm.pas.
  zNet.Tls.SelezionaProviderTls(Config.TlsProvider);

  Application.Initialize;

  // Pulsanti dei dialoghi e menu incorporati di DevExpress e Delphi in
  // italiano: zTranslate non traduce da solo quando entra nella uses, e va
  // chiamato prima di creare le form
  zTranslate.Apply.Translate;

  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TConnection, Connection);
  Application.CreateForm(TMail, Mail);
  Application.CreateForm(TScriptModule, ScriptModule);
  Application.CreateForm(TFTP, FTP);
  Application.CreateForm(TImportCandidature, ImportCandidature);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TScriptEditor, ScriptEditor);
  Application.CreateForm(TScriptEditorEvalute, ScriptEditorEvalute);
  Application.CreateForm(TUpdateEngine, UpdateEngine);

  Application.Run;

end.
