unit MainFrm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ShlObj,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  System.ImageList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  System.Net.HttpClient,
  cxImageList,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  dxCustomWizardControl,
  dxWizardControl,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  dxDateRanges,
  dxScrollbarAnnotations,
  Data.DB,
  cxDBData,
  dxBar,
  cxClasses,
  cxGridLevel,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  cxShellCommon,
  dxListView,
  dxShellControls,
  cxContainer,
  cxLabel,
  cxListView,
  cxShellListView,
  dxBreadcrumbEdit,
  dxShellBreadcrumbEdit,
  dxSkinsCore,
  dxCore,
  dxSkinsForm,
  dxSkinMoneyTwins,
  dxUIAClasses,
  FireDAC.Comp.Client,
  FireDAC.Comp.Script,
  zFbScriptRunner,
  Frame_Editor_SQL,
  ExplorerDrop, System.Net.URLClient, System.Net.HttpClientComponent;

type
  TMainForm = class(TForm)
    ActionList: TActionList;
    image16: TcxImageList;
    CartelleCondivise: TAction;
    Shutdown: TAction;
    ApplicaAggiornamento: TAction;
    Backup: TAction;
    CopiaFisicaDB: TAction;
    Wizard: TdxWizardControl;
    pageUtenti: TdxWizardControlPage;
    gridUtentiAttiviDBTableView: TcxGridDBTableView;
    gridUtentiAttiviLevel: TcxGridLevel;
    gridUtentiAttivi: TcxGrid;
    dxBarManager: TdxBarManager;
    image32: TcxImageList;
    barDockUtenti: TdxBarDockControl;
    barUtenti: TdxBar;
    AggiornaUtenti: TAction;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    RinominaExe: TAction;
    pageRinominaExe: TdxWizardControlPage;
    shellBin: TcxShellListView;
    barDockRinominaExe: TdxBarDockControl;
    barRinominaExe: TdxBar;
    dxBarButton4: TdxBarButton;
    pageBackupDB: TdxWizardControlPage;
    barDockBackup: TdxBarDockControl;
    barBackup: TdxBar;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    shellDB: TcxShellListView;
    pageAggiornamentoEXE: TdxWizardControlPage;
    shellAggiornamenti: TcxShellListView;
    barDockAggiornamento: TdxBarDockControl;
    barAggiornamento: TdxBar;
    DownloadAggiornamento: TAction;
    dxBarButton7: TdxBarButton;
    dxBarButton8: TdxBarButton;
    pageAggiornamentoDB: TdxWizardControlPage;
    cxLabel1: TcxLabel;
    gridUtentiAttiviDBTableViewDATA_ORA_CONNESSIONE: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewGIORNI_CONNESSIONE: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewDB_USER: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewUSER_ID: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewUSER_NAME: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewNOMINATIVO: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewATTIVO: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewADMIN_USER: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewID_SESSIONE: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewATTACHMENT_ID: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewSTATO_SESSIONE: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewDESC_STATO_SESSIONE: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewREMOTE_PROCESS_NAME: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewREMOTE_PROCESS: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewCLIENT_ADDRESS: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewREMOTE_ADDRESS: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewREMOTE_PID: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewSERVER_PID: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewCOMPUTER_NAME: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewNON_INDEXED_READS: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewINDEXED_READS: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewRECORDS_INSERTED: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewRECORDS_UPDATED: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewRECORDS_DELETED: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewRECORDS_BACKED_OUT: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewRECORDS_PURGED: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewRECORDS_EXPUNGED: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewPAGE_READS: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewPAGE_WRITES: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewPAGE_FETCHES: TcxGridDBColumn;
    gridUtentiAttiviDBTableViewPAGE_MARKS: TcxGridDBColumn;
    Gesty: TAction;
    dxBarButton9: TdxBarButton;
    shellBreadcrumbBin: TdxShellBreadcrumbEdit;
    shellBreadcrumbDB: TdxShellBreadcrumbEdit;
    shellBreadcrumbAggiornamenti: TdxShellBreadcrumbEdit;
    UploadDB: TAction;
    DownloadDB: TAction;
    dxBarButton10: TdxBarButton;
    dxBarButton11: TdxBarButton;
    dxBarButton12: TdxBarButton;
    IbExpert: TAction;
    dxBarButton13: TdxBarButton;
    dxBarButton14: TdxBarButton;
    dxSkinController: TdxSkinController;
    dxBarButton15: TdxBarButton;
    Cron: TAction;
    Script: TAction;
    dxBarButton16: TdxBarButton;
    UtentiAttiviSrc: TDataSource;
    FrameEditor_Sql: TFrameEditor_Sql;
    VerificaUsoExe: TAction;
    ChiudiProcessiExe: TAction;
    ShutdownDatabase: TAction;
    OnlineDatabase: TAction;
    dxBarButton17: TdxBarButton;
    dxBarButton18: TdxBarButton;
    dxBarButton19: TdxBarButton;
    dxBarButton20: TdxBarButton;
    dxBarButton21: TdxBarButton;
    ExplorerDrop: TExplorerDrop;
    dxBarSubItemAltriStrumenti: TdxBarSubItem;
    procedure FormDestroy(Sender: TObject);
    procedure AggiornaUtentiExecute(Sender: TObject);
    procedure ApplicaAggiornamentoExecute(Sender: TObject);
    procedure BackupExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure CartelleCondiviseExecute(Sender: TObject);
    procedure CopiaFisicaDBExecute(Sender: TObject);
    procedure CronExecute(Sender: TObject);
    procedure DownloadAggiornamentoExecute(Sender: TObject);
    procedure DownloadDBExecute(Sender: TObject);
    procedure ExplorerDropDropped(Sender: TObject; Files: TStrings; FileCount, x, y: Integer);
    procedure FormShow(Sender: TObject);
    procedure GestyExecute(Sender: TObject);
    procedure IbExpertExecute(Sender: TObject);
    procedure RinominaExeExecute(Sender: TObject);
    procedure ScriptExecute(Sender: TObject);
    procedure ShutdownExecute(Sender: TObject);
    procedure UploadDBExecute(Sender: TObject);
    procedure WizardButtonClick(Sender: TObject; AKind: TdxWizardControlButtonKind; var AHandled: Boolean);
    procedure WizardPageChanged(Sender: TObject);
    procedure WizardTdxWizardControlButtonsTdxWizardControlCustomButtonsButtons0Click(Sender: TObject);
    procedure VerificaUsoExeExecute(Sender: TObject);
    procedure ChiudiProcessiExeExecute(Sender: TObject);
    procedure ShutdownDatabaseExecute(Sender: TObject);
    procedure OnlineDatabaseExecute(Sender: TObject);
  private
    // esecuzione dello script di aggiornamento db
    ScriptRunner: TzFbScriptRunner;
    ScriptFireDac: TFDScript;
    procedure CreaScriptRunner;
    procedure CaricaScriptAggiornamento;
    function ConfermaPassaggioPagina: Boolean;
    procedure EseguiScriptAggiornamento(Sender: TObject);
    procedure ScriptRunnerMessage(Sender: TObject; Kind: TzScriptMessageKind; const Text: string);
  public
  end;

var
  MainForm: TMainForm;

implementation

uses
  Winapi.ShellAPI,
  System.IOUtils,
  System.Types,
  zz.Vcl,
  IdSSLOpenSSLHeaders,
  IdGlobal,
  zWaitFrm,
  GestyTools.Config,
  GestyTools.Update,
  GestyTools.Script.Editor,
  GestyTools.Config.Editor,
  GestyTools.Connection,
  zMsg;

{$R *.dfm}

function zzCapFirst(Value: string; ReplaceUnderScore: Boolean): string;
var
  i: Integer;
  s: string;
begin
  Result := '';
  if trim(Value) = '' then
    Exit;
  s := uppercase(Value[1]);
  for i := 2 to length(Value) do
  begin
    if (Value[i - 1] in [' ', '_']) then
      s := s + uppercase(Value[i])
    else
      s := s + lowercase(Value[i]);
  end;

  if ReplaceUnderScore then
    s := StringReplace(s, '_', ' ', [rfReplaceAll]);
  Result := s;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  ExplorerDrop.Enabled := False;
  ExplorerDrop.DestinationControl := nil;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  IdOpenSSLSetLibPath(ExtractFilePath(ParamStr(0)));

  dxSkinController.SkinName := 'MoneyTwins';
  dxSkinController.UseSkins := True;

  Wizard.ActivePageIndex := 0;

  gridUtentiAttiviDBTableView.OptionsView.GroupByBox := False;
  gridUtentiAttiviDBTableView.OptionsSelection.MultiSelect := False;
  gridUtentiAttiviDBTableView.OptionsView.Indicator := True;

  ForEach<TcxGridDBColumn>(
    procedure(col: TcxGridDBColumn)
    begin
      col.Caption := zzCapFirst(col.Caption, True);
    end);

  ForEach<TdxBar>(
    procedure(bar: TdxBar)
    begin
      bar.AllowClose := False;
      bar.AllowCustomizing := False;
      bar.AllowQuickCustomizing := False;
      bar.AllowReset := False;
      bar.OneOnRow := True;
      bar.ShowMark := False;
      bar.UseRestSpace := True;
      bar.WholeRow := True;
    end);

  // la pagina Aggiornamento DB usa l'editor sql, la label segnaposto va nascosta
  cxLabel1.Visible := False;

  // il bottone Esegui dell'editor diventa visibile assegnando OnExecute
  FrameEditor_Sql.OnExecute := EseguiScriptAggiornamento;

  CreaScriptRunner;

  ExplorerDrop.DestinationControl := FrameEditor_Sql.Editor;
  ExplorerDrop.Enabled := True;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  UtentiAttiviSrc.DataSet := Connection.UtentiAttivi;
  gridUtentiAttiviDBTableView.DataController.DataSource := UtentiAttiviSrc;

  UpdateEngine.Connect;

  gridUtentiAttiviDBTableView.ApplyBestFit();

  shellBreadcrumbBin.Properties.ShellOptions.Root.CustomPath := Config.FolderBin;
  shellBreadcrumbDB.Properties.ShellOptions.Root.CustomPath := Config.DBFolder;
  shellBreadcrumbAggiornamenti.Properties.ShellOptions.Root.CustomPath := Config.FolderUpdate;
end;

procedure TMainForm.CreaScriptRunner;
begin
  ScriptFireDac := TFDScript.Create(Self);

  ScriptRunner := TzFbScriptRunner.Create(Self);
  ScriptRunner.Script := ScriptFireDac;
  ScriptRunner.TransactionMode := tmScriptControlled;
  ScriptRunner.StopOnError := True;
  ScriptRunner.Messages := [mkFeedback, mkSkipped, mkError];
  ScriptRunner.OnMessage := ScriptRunnerMessage;
end;

procedure TMainForm.WizardButtonClick(Sender: TObject; AKind: TdxWizardControlButtonKind; var AHandled: Boolean);
begin
  case AKind of
    // wcbkBack
    wcbkNext:
      // blocca l'avanzamento se i controlli della pagina corrente falliscono
      AHandled := not ConfermaPassaggioPagina;

    wcbkCancel:

      if ConfirmOkCancel('Si desidera terminare l''aggiornamento?') then
      begin
        AHandled := True;
        close;
      end;

    // wcbkHelp,
    wcbkFinish:
      begin
        AHandled := True;

        // aggiornamento scaricato ma non applicato: propone l'estrazione nella cartella di Gesty
        if TFile.Exists(UpdateEngine.DownloadFileName) then
          if ConfirmOkCancel('E'' presente un aggiornamento scaricato ma non ancora applicato.' + sLineBreak + 'Decomprimerlo ora nella cartella di Gesty?') then
            UpdateEngine.ApplicaAggiornamento;

        // se il database e' rimasto in shutdown propone la riattivazione
        if UpdateEngine.DatabaseInShutdown then
          if ConfirmOkCancel('Il database e'' ancora in shutdown.' + sLineBreak + 'Riattivarlo prima di terminare?') then
            UpdateEngine.OnlineDatabase;

        close;
      end;
  end;
end;

function TMainForm.ConfermaPassaggioPagina: Boolean;
var
  utilizzatori: string;
begin
  Result := True;

  if Wizard.ActivePage = pageUtenti then
  begin
    // utenti ancora collegati: propone lo shutdown applicativo e resta sulla pagina
    if Connection.EsistonoUtentiCollegati then
    begin

      if ConfirmYesNo('Risultano utenti collegati al database.' + sLineBreak + 'Eseguire lo shutdown per scollegarli?', mtWarning) then
      begin
        StartWait('Attendere...', True);
        try
          Connection.Shutdown;
        finally
          StopWait;
        end;

        ConfirmOk('Shutdown in corso: attendere che gli utenti si scolleghino, poi aggiornare l''elenco.');
      end;

      Exit(False);
    end;

    // exe ancora in uso: mostra chi lo blocca e chiede conferma
    if UpdateEngine.ExeInUso then
    begin
      utilizzatori := UpdateEngine.DescriviUtilizzatoriExe;
      Exit(ConfirmYesNo('Gesty.exe risulta ancora in uso da:' + sLineBreak + utilizzatori + sLineBreak + 'Continuare comunque?', mtWarning));
    end;
  end

  else
    if Wizard.ActivePage = pageRinominaExe then
    begin
      // l'exe dovrebbe essere stato eliminato in questa pagina
      if TFile.Exists(UpdateEngine.ExeFileName) then
        Exit(ConfirmYesNo('Gesty.exe e'' ancora presente nella cartella bin.' + sLineBreak + 'Continuare comunque?', mtWarning));
    end
    else
      if Wizard.ActivePage = pageBackupDB then
      begin
        // senza shutdown del database restano possibili nuove connessioni durante l'aggiornamento
        if not UpdateEngine.DatabaseInShutdown then
          Exit(ConfirmYesNo('Il database non e'' in shutdown: durante l''aggiornamento sono possibili nuovi collegamenti.' + sLineBreak + 'Continuare senza shutdown?'));
      end;
end;

procedure TMainForm.WizardPageChanged(Sender: TObject);
begin
  Wizard.Buttons.Cancel.Enabled := Wizard.ActivePageIndex < Wizard.PageCount - 1;

  // all'ingresso nella pagina Aggiornamento DB carica lo script piu' recente
  if Wizard.ActivePage = pageAggiornamentoDB then
    CaricaScriptAggiornamento;
end;

procedure TMainForm.CaricaScriptAggiornamento;
var
  scriptFiles: TStringDynArray;
  fileName: string;
  newestFileName: string;
begin

  if not FrameEditor_Sql.Empty then
    Exit;

  if not TDirectory.Exists(Config.FolderUpdate) then
    Exit;

  scriptFiles := TDirectory.GetFiles(Config.FolderUpdate, '*.sql');
  if length(scriptFiles) = 0 then
    Exit;

  // sceglie lo script piu' recente presente nella cartella aggiornamenti
  newestFileName := scriptFiles[0];
  for fileName in scriptFiles do
    if TFile.GetLastWriteTime(fileName) > TFile.GetLastWriteTime(newestFileName) then
      newestFileName := fileName;

  FrameEditor_Sql.LoadFromFile(newestFileName);
end;

procedure TMainForm.EseguiScriptAggiornamento(Sender: TObject);
var
  esito: TzScriptResult;
begin

  if ConfirmOkCancel('Eseguire lo script di aggiornamento sul database?') then
    Exit;

  ScriptFireDac.Connection := Connection.FDConnection;
  ScriptRunner.Connection := Connection.FDConnection;

  esito := ScriptRunner.ExecuteText(FrameEditor_Sql.SQL);

  FrameEditor_Sql.Log.Lines.Add(Format('Comandi totali: %d - eseguiti: %d - ignorati: %d - falliti: %d (%d ms)', [esito.Total, esito.Executed, esito.Skipped, esito.Failed, esito.ElapsedMs]));

  if esito.Succeeded then
    ConfirmOk('Script di aggiornamento eseguito correttamente.')
  else
    ConfirmOk('Script interrotto (rollback eseguito): ' + sLineBreak + esito.LastError, mtError);
end;

procedure TMainForm.ScriptRunnerMessage(Sender: TObject; Kind: TzScriptMessageKind; const Text: string);
const
  KindDescription: array [TzScriptMessageKind] of string = ('', '', 'Ignorato: ', '', 'ERRORE: ');
begin
  FrameEditor_Sql.Log.Lines.Add(KindDescription[Kind] + Text);
  Application.ProcessMessages;
end;

procedure TMainForm.VerificaUsoExeExecute(Sender: TObject);
begin

  if not TFile.Exists(UpdateEngine.ExeFileName) then
    ConfirmOk('Gesty.exe non e'' presente nella cartella bin.')
  else
    if not UpdateEngine.ExeInUso then
      ConfirmOk('Gesty.exe non risulta in uso: puo'' essere sostituito.')
    else
      ConfirmOk('Gesty.exe risulta in uso da:' + sLineBreak + UpdateEngine.DescriviUtilizzatoriExe);
end;

procedure TMainForm.ChiudiProcessiExeExecute(Sender: TObject);
var
  utilizzatori: string;
begin

  if not UpdateEngine.ExeInUso then
  begin
    ConfirmOk('Gesty.exe non risulta in uso.');
    Exit;
  end;

  utilizzatori := UpdateEngine.DescriviUtilizzatoriExe;

  if not ConfirmOkCancel('Gesty.exe risulta in uso da:' + sLineBreak + utilizzatori + sLineBreak + 'Forzare la chiusura?', mtWarning) then
    Exit;

  StartWait('Attendere...', True);
  try
    UpdateEngine.ChiudiUtilizzatoriExe;
  finally
    StopWait;
  end;

  if UpdateEngine.ExeInUso then
    ConfirmOk('Gesty.exe risulta ancora in uso:' + sLineBreak + UpdateEngine.DescriviUtilizzatoriExe)
  else
    ConfirmOk('Processi chiusi: Gesty.exe non e'' piu'' in uso.');
end;

procedure TMainForm.ShutdownDatabaseExecute(Sender: TObject);
begin

  if ConfirmOkCancel('Portare il database in shutdown?' + sLineBreak + 'Solo SYSDBA potra'' collegarsi fino alla riattivazione.', mtWarning) then
  begin
    UpdateEngine.ShutdownDatabase;
    ConfirmOk('Database in shutdown: nuovi collegamenti bloccati.');
  end;
end;

procedure TMainForm.OnlineDatabaseExecute(Sender: TObject);
begin
  UpdateEngine.OnlineDatabase;
  ConfirmOk('Database riattivato.');
end;

procedure TMainForm.AggiornaUtentiExecute(Sender: TObject);
begin

  StartWait('Attendere...', True);
  try
    Connection.UtentiAttiviActive := False;
    Connection.UtentiAttiviActive := True;
  finally
    StopWait;
  end;

  gridUtentiAttiviDBTableView.ApplyBestFit();
end;

procedure TMainForm.ApplicaAggiornamentoExecute(Sender: TObject);
begin
  if UpdateEngine.ApplicaAggiornamento then
    shellBreadcrumbAggiornamenti.Properties.ShellOptions.Root.CustomPath := Config.FolderBin;
end;

procedure TMainForm.BackupExecute(Sender: TObject);
begin
  UpdateEngine.BackupBatch;
end;

procedure TMainForm.CartelleCondiviseExecute(Sender: TObject);
begin
  UpdateEngine.CartelleCondivise;
end;

procedure TMainForm.DownloadAggiornamentoExecute(Sender: TObject);
begin
  UpdateEngine.DownloadExe;
end;

procedure TMainForm.ShutdownExecute(Sender: TObject);
begin

  if ConfirmOkCancel('Effettuare il shutdown degli utenti connessi?') then
  begin
    StartWait('Attendere...', True);
    try
      Connection.Shutdown;
    finally
      StopWait;
    end;

    ConfirmOk('Shutdown in corso.');
  end;
end;

procedure TMainForm.Button7Click(Sender: TObject);
const
  // Mantis: nessuno - pulizia OpenSSL. Token Dropbox di prova gia' presente
  // nel sorgente originale: da revocare/ruotare, non e' compito di questa modifica.
  FDropBoxAppAccessToken = 'sl.BHzyZvqrtLu5Odbs5FG0kb_Kx0SDJHEH-kQbSVZ2BETjeIHwNoH98U7slS7_2KZZwzDp0m3-Lr-6_JFSu5PV_NGMMXOB7q4hnCC9RtkS61rGVcHPypG5G5fm1IKFf-nj4nC9O18';
  FHTTPRequestURL = 'https://content.dropboxapi.com/2/files/upload';
  FDropBoxBaseAppPath = 'zUpdate';
  Timeout = 5000;
var
  http: TNetHTTPClient;
  Risposta: IHTTPResponse;
  FStream: TFileStream;
  FHTTPResponse: String;
  SourceFileName: String;
  DropBoxFileName: String;

begin
  SourceFileName := 'C:\Users\Luca\Desktop\Getting started with pCloud.pdf';
  DropBoxFileName := 'test.pdf';

  try
    FStream := TFileStream.Create(SourceFileName, fmOpenRead or fmShareDenyWrite);
    try
      http := TNetHTTPClient.Create(nil);
      try
        http.ConnectionTimeout := Timeout;
        http.CustomHeaders['Authorization'] := 'Bearer ' + FDropBoxAppAccessToken;
        http.CustomHeaders['Dropbox-API-Arg'] := '{"path": "' + FDropBoxBaseAppPath + DropBoxFileName + '"}';
        http.CustomHeaders['Content-Type'] := 'application/octet-stream';
        Risposta := http.Post(FHTTPRequestURL, FStream);
        FHTTPResponse := Risposta.ContentAsString;
      finally
        http.Free;
      end;
    finally
      FStream.Free;
    end;
  except
    on E: Exception do
    begin
    end;
  end;
end;

procedure TMainForm.RinominaExeExecute(Sender: TObject);
begin
  if UpdateEngine.RinominaExe then
    shellBreadcrumbBin.Properties.ShellOptions.Root.CustomPath := Config.FolderBackupExe;
end;

procedure TMainForm.CopiaFisicaDBExecute(Sender: TObject);
begin
  if UpdateEngine.CopiaFisicaDB then
    shellBreadcrumbDB.Properties.ShellOptions.Root.CustomPath := Config.FolderBackupDB;
end;

procedure TMainForm.CronExecute(Sender: TObject);
begin
  UpdateEngine.Cron;
end;

procedure TMainForm.GestyExecute(Sender: TObject);
begin

  // avviare Gesty con il database in shutdown fallirebbe al login
  if UpdateEngine.DatabaseInShutdown then
    if ConfirmOkCancel('Il database e'' in shutdown: Gesty non riuscira'' a collegarsi.' + sLineBreak + 'Riattivarlo prima di avviare?') then
      UpdateEngine.OnlineDatabase;

  UpdateEngine.Gesty;
end;

procedure TMainForm.UploadDBExecute(Sender: TObject);
begin

  if ConfirmOkCancel('Si desidera caricare il db sull''ftp?') then
    UpdateEngine.UploadDB;
end;

procedure TMainForm.DownloadDBExecute(Sender: TObject);
begin

  if ConfirmOkCancel('Si desidera scaricare il db dall''ftp?') then
    UpdateEngine.DownloadDB;
end;

procedure TMainForm.ExplorerDropDropped(Sender: TObject; Files: TStrings; FileCount, x, y: Integer);
begin

  if Files.count > 0 then
    FrameEditor_Sql.LoadFromFile(Files[0]);
end;

procedure TMainForm.IbExpertExecute(Sender: TObject);
begin
  UpdateEngine.IbExpert;
end;

procedure TMainForm.ScriptExecute(Sender: TObject);
begin
  ScriptEditor.ShowModal;
end;

procedure TMainForm.WizardTdxWizardControlButtonsTdxWizardControlCustomButtonsButtons0Click(Sender: TObject);
const
  AdminPwd = 10299;
var
  Password: string;
  StringList: TStringList;
begin
  Password := '';

  if zMsg.InputPassword('Password', 'Password', Password) then
    if Password.Equals(AdminPwd.ToString) then
      if EditConfig then
        Connection.LoadConfig;
end;

end.

  zFbScriptRunner
