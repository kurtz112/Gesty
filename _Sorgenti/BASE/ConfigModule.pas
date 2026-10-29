unit ConfigModule;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  System.Variants,
  System.Generics.Collections,
  System.Win.TaskbarCore,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.AppEvnts,
  Vcl.ActnList,
  Vcl.ExtCtrls,
  Vcl.Taskbar,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Phys.FBDef,
  FireDAC.Phys.FB,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Phys.IBWrapper,
  FireDAC.Phys.IBBase,
  dxLayoutLookAndFeels,
  dxAlertWindow,
  cxClasses,
  cxLookAndFeelPainters,
  cxGraphics,
  frxClass,
  IdBaseComponent,
  IdAntiFreezeBase,
  IdAntiFreeze,
  Base_DataModule,
  zFormController,
  zFbDataSet,
  zStoredProc,
  zSystem,
  zProgressBox,
  dbMaster,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl,
  FireDAC.Moni.Base,
  FireDAC.Moni.Custom,
  zModuli,
  dxShellDialogs,
  FireDAC.VCLUI.Async,
  FireDAC.Comp.UI,
  FireDAC.Moni.FlatFile,
  FireDAC.Moni.RemoteClient,
  zSecurity.FasceOrarie,
  zCustomerPreferences,
  Mantis.Segnalazioni.Types;

type
  TConfig = class(TBaseDataModule)
    ApplicationEvents: TApplicationEvents;
    Database: TzFbDatabase;
    ProgressBox: TProgressBox;
    zSystem: TzSystem;
    DefaultReadTrans: TzFbTransaction;
    DefaultWriteTrans: TzFbTransaction;
    dxAlertWindowManager: TdxAlertWindowManager;
    TimerShutdown: TTimer;
    TimerAFK: TTimer;
    TimerKill: TTimer;
    FDEventAlerter: TFDEventAlerter;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    IdAntiFreeze: TIdAntiFreeze;
    dxSaveFileDialog: TdxSaveFileDialog;
    FDMoniRemoteClientLink: TFDMoniRemoteClientLink;
    FDMoniFlatFileClientLink: TFDMoniFlatFileClientLink;
    FDMoniCustomClientLink: TFDMoniCustomClientLink;
    FDGUIxAsyncExecuteDialog: TFDGUIxAsyncExecuteDialog;
    procedure TimerAFKTimer(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure ApplicationEventsShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure DatabaseAfterConnect(Sender: TObject);
    procedure DatabaseError(ASender, AInitiator: TObject; var AException: Exception);
    procedure DatabaseRecover(ASender, AInitiator: TObject; AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
    procedure dxAlertWindowManagerClose(Sender: TObject; AAlertWindow: TdxAlertWindow);
    procedure dxAlertWindowManagerCustomDrawBackground(Sender: TObject; AAlertWindow: TdxAlertWindow; ACanvas: TcxCanvas; AViewInfo: TdxAlertWindowViewInfo; var ADone: Boolean);
    procedure dxAlertWindowManagerMouseDown(Sender: TObject; AAlertWindow: TdxAlertWindow; AButton: TMouseButton; AShift: TShiftState; X, Y: Integer);
    procedure FDEventAlerterAlert(ASender: TFDCustomEventAlerter; const AEventName: string; const AArgument: Variant);
    procedure FDGUIxAsyncExecuteDialogShow(Sender: TObject);
    procedure FDMoniCustomClientLinkOutput(ASender: TFDMoniClientLinkBase; const AClassName, AObjName, AMessage: string);
    procedure TimerKillTimer(Sender: TObject);
    procedure TimerShutdownTimer(Sender: TObject);
    procedure zSystemAssignDataSetEvent(DataSet: TzFbDataSet; DataSetEventKind: TDataSetEventKind; const EventName: string);
    procedure zSystemAssignFieldOnChangeEvent(Field: TField; const EventName: string);
    procedure zSystemHyperLink(Sender: TObject; FieldName: string; Value: Variant);
  private
    // Mantis #183 - 2026-10-08: stato del monitor FireDAC prima che la
    // registrazione per l'assistenza lo accendesse, da rimettere alla chiusura.
    FMonitorRegistrazioneAttivo: Boolean;
    FMonitorByPrecedente: TFDMonitorBy;
    FEventKindsPrecedenti: TFDMoniEventKinds;
    FFileMonitorPrecedente: string;
    FAppendMonitorPrecedente: Boolean;
    FTracingMonitorPrecedente: Boolean;
    FDisabilitaEventiDB: Boolean;
    // Fasce orarie 2026-09-18: conta i secondi restituiti dal login e
    // si ripresenta al server solo allo scadere.
    FControlloFasciaOraria: TzControlloFasciaOraria;
    FShuttingDown: Boolean;
  private
    procedure LZ_RenameDatamodule(const aOldName, aNewName: string);
    procedure LZ_RenameDataSet(const OldName, NewName: string; const ShouldSave: Boolean = false);
    procedure LZ_ChangeTableName(const OldTableName, NewTableName: string; const ShouldSave: Boolean = false);
    procedure LZ_ChangeSqlToken(const OldToken, NewToken: string; const ShouldSave: Boolean = false);
    property DisabilitaEventiDB: Boolean read FDisabilitaEventiDB;
  private
    FMaxMinutiInattivita: Integer;
    procedure InitAFK;
    Procedure CloseApplication;

    procedure InitMantis;
    procedure InitSMTPServerAssistenza;
    procedure InitSMTPServerDefault;
    procedure InitTls;
  private type
    TNotificaInfo = class
      AlertWindow: TdxAlertWindow; // riferimento, non owned (lo gestisce dxAlertWindowManager)
      IdNotifica: Integer; // = ID_NOTIFICA (oggi era il solo AlertWindow.Tag)
      TagId: Integer; // da NOTIFICHE.TAG_ID
      TagStr: string; // da NOTIFICHE.TAG_STR
      UserClicked: Boolean; // distingue click reale da chiusura di massa (NotificheLette)
    end;
  private
    ListaNotifiche: TObjectList<TNotificaInfo>;
    function NotificaGiaMostrata(const AIdNotifica: Integer): Boolean;
    function IndexOfAlertWindow(const AAlertWindow: TdxAlertWindow): Integer;
    procedure MostraNotifiche;
  private
    procedure InitTaskbar;
  protected
    function SorgentiPath: string;
    procedure UserLog(const Msg: string);
    function GetCartella(const FolderName: string): string;
    procedure ImportaLZ;
    procedure AfterLogin;
    procedure SetLoginInfo;
    procedure Load_GMAPS_API_KEY;
    procedure AvviaControlloFasciaOraria;
    procedure ControlloFasciaOrariaAvviso(Sender: TObject; SecondiResidui: Integer);
    procedure ControlloFasciaOrariaScaduto(Sender: TObject);
  private
    FWireCompression: Boolean;
    Moduli: TModuli;
    procedure LoadModuli;
  private
    // Registro locale dei ticket di assistenza aperti dall'utente corrente
    // (form "Le mie segnalazioni"): esiste solo se Mantis e' configurato.
    FMantisSegnalazioni: IMantisSegnalazioniStore;
    procedure RegistraTicketAssistenza(AIdTicket: Integer; AOggetto: string);
    procedure AvvisaNovitaTicketAssistenza;
  public
    // Form "Le mie segnalazioni": stato e risposte dei ticket aperti dall'utente.
    function TicketAssistenzaDisponibile: Boolean;
    procedure MostraTicketAssistenza;
  public
    destructor Destroy; override;
  public
    function CartellaPersonaleUtenteCorrente: string;
    function CurrentUser: string;
    function CurrentUserDisplayName: string;
    function CurrentUserID: Integer;
    function dbCurrentUser: string;
    /// ////////////////////
    /// //////////////////
    procedure HelpSommario;
    function LoggedIn: Boolean;
    procedure Login;
    procedure CambiaPassword;
    procedure ResetAdmin;
    /// //////////////////
    procedure Log(Msg: string);
    //
    function ReadBoolFromIni(Section, Ident: string; Default: Boolean): Boolean;
    function ReadDoubleFromIni(Section, Ident: string; Default: double): double;
    function ReadIntegerFromIni(Section, Ident: string; Default: Integer): Integer;
    function ReadStringFromIni(Section, Ident, Default: string): string;
    procedure WriteBoolToIni(Section, Ident: string; Value: Boolean);
    procedure WriteDoubleToIni(Section, Ident: string; Value: double);
    procedure WriteIntegerToIni(Section, Ident: string; Value: Integer);
    procedure WriteStringToIni(Section, Ident, Value: string);
    function StorageFileName: String;

    function Authorizhed(const Authorization: string; const TrueIfAdmin: Boolean = true): Boolean;
    procedure Autorun(Actions: TActionList);

    function IsAdmin: Boolean;
  public
    procedure CheckVersioneEseguibile;
  public
    function ExecBooleanFunc(const FunctionName: string): Boolean;
    function ExecIntFunc(const FunctionName: string): Integer;
  public
    procedure Shutdown;
    procedure BroadcastMessage;

    property ShuttingDown: Boolean read FShuttingDown;
  public
    procedure pippo;
  public
    property MaxMinutiInattivita: Integer read FMaxMinutiInattivita;
    procedure MostraBadgeNotifiche;
    procedure NotificheLette;
  public
    procedure Startup;
  public
    procedure RegisterModuli(ModuliActions: TActionList);
    function GetStatoAttivazione(const Modulo: string): TStatoAttivazione;
    function ModificaStatoAttivazioneModulo(const Modulo: string): Boolean;
    function CheckModulo(const Modulo, Titolo: string): Boolean;
  public
    procedure RicaricaImpostazioni;
  public
    procedure DownloadAggiornamento;
    function EditMonitorProps: Boolean;
    // Mantis #183 - 2026-10-08: accende (AAttiva) o spegne il monitor FireDAC
    // su file per la registrazione per l'assistenza (SessioneLog.OnMonitorFireDAC).
    procedure MonitorFireDACPerRegistrazione(AAttiva: Boolean; const AFile: string);
  public
    procedure SaveDataSets;
  public
    procedure Reconnect;
  public
    property WireCompression: Boolean read FWireCompression;
  end;

var
  Config: TConfig;

implementation

uses
  Winapi.ShellAPI,
  Winapi.UrlMon,
  Winapi.SHFolder,
  Winapi.ShlObj,
  System.IniFiles,
  System.StrUtils,
  System.IOUtils,
  Vcl.Clipbrd,
  FireDAC.Phys.IBDef,
  cxImageComboBox,
  FrmApplicationInspector,
  zBaseLib,
  zCollection,
  zDm_Images,
  zMsg,
  zz.files,
  zSystemTools,
  zOffice,
  zHyperLinks,
  MainForm,
  MDI_Lib,
  zExceptions,
  zDX,
  Gesty_StoredProcs,
  zNet.Tls,
  zz.SplashWait,
  dmDataSetEvents,
  zOffice.Types,
  zOffice.Mail.Utils,
  dmEventHandler,
  zz.Taskbar,
  zMap,
  dmFTP,
  zFbMonitor,
  zExceptions.Utils,
  zMetadata,
  zMetadata.Loader,
  Gesty.Authorizations,
  BaseFrm,
  dmCommon,
  HelpGen.Config,
  zOffice.Reports.Types,
  zz.Folders,
  zz.Vcl,
  zExceptions.FireDAC,
  zSanificazione.Clipboard,
  zDiagnostica.Log,
  System.Threading,
  zExceptions.Mantis,
  Mantis.Api,
  Mantis.Segnalazioni.Store,
  zMantis.TicketAssistenza.form;

const
  //
  Ext_Settings = '.Settings';
  Ext_Forms = '.Forms';
  Ext_Columns = '.Columns'; // RiDefinita in zDbView

const
  ALERT_TAG_SHUTDOWN = -999;

{$R *.DFM}

procedure InitStoredProc(zStoredProc: zStoredProc.TzStoredProc);
begin
  Assert(Assigned(Config));
  Assert(Assigned(zStoredProc));

  zStoredProc.zSystem := Config.zSystem;
  zStoredProc.Database := Config.Database;
end;

destructor TConfig.Destroy;
begin
  if Assigned(FControlloFasciaOraria) then
    FControlloFasciaOraria.Ferma;

  if TerminalServer then
    UserLog('Logout');

  if Database.Connected then
    Database.Connected := false;

  FreeAndNil(ListaNotifiche);
  FreeAndNil(Moduli);
  inherited;
end;

procedure TConfig.DataModuleCreate(Sender: TObject);
var
  Count: Integer;
  DataSet: TzDataSet;
  i: Integer;
  idx: Integer;
  j: Integer;
  MapRule: TFDMapRule;
  SQL: string;
  Str: TStringList;
  trovato: Boolean;
begin
  Si.Enabled := true;

  FWireCompression := false;
  FMaxMinutiInattivita := -1;

  FDisabilitaEventiDB := false;
  FShuttingDown := false;

  FiltroClipboard.Attivo := true; // Attiva il filtro dei caratteri spuri nel paste da clipboard

  Moduli := TModuli.Create(TModulo);
  ListaNotifiche := TObjectList<TNotificaInfo>.Create(true);

  InitTaskbar;

  Database.FormatOptions.OwnMapRules := true;
  MapRule := Database.FormatOptions.MapRules.Add;
  MapRule.SourceDataType := dtFmtBCD;
  // MapRule.TargetDataType := dtExtended; per TQExport4XLSX
  MapRule.TargetDataType := dtDouble;
  MapRule := Database.FormatOptions.MapRules.Add;
  MapRule.SourceDataType := dtBCD;
  // MapRule.TargetDataType := dtExtended; per TQExport4XLSX
  MapRule.TargetDataType := dtDouble;

  DefaultReadTrans.Options.Isolation := xiReadCommitted;
  DefaultWriteTrans.Options.Isolation := xiReadCommitted;

  FDMoniRemoteClientLink.EventKinds := [ekError, ekConnConnect, ekConnTransact, ekCmdPrepare, ekCmdExecute, ekComponent, ekSQL];
  FDMoniFlatFileClientLink.EventKinds := [ekError, ekConnConnect, ekConnTransact, ekCmdPrepare, ekCmdExecute, ekComponent, ekSQL];
  FDMoniCustomClientLink.EventKinds := [ekError, ekConnConnect, ekConnTransact, ekCmdPrepare, ekCmdExecute, ekComponent, ekSQL];

  FDMoniFlatFileClientLink.FileName := ChangeFileExt(Application.ExeName, '.monitor_trace');

  // Mantis #183 - 2026-10-08: la registrazione per l'assistenza puo' chiedere
  // la traccia FireDAC su file. Il collegamento al monitor sta qui, e per
  // cambiare MonitorBy serve la riconnessione, come in EditMonitorProps.
  SessioneLog.OnMonitorFireDAC := MonitorFireDACPerRegistrazione;

  zStoredProc.InitStoredProc := InitStoredProc;
  //
  TzExceptionManager.MailAddress := 'assistenza@zebro.it';

  //
  zSystem.ImageList16 := dx.Immagini;
  zSystem.ImageList24 := dx.Immagini;
  zSystem.AppName := 'Gesty';
  zSystem.FDPhysFBDriverLink := FDPhysFBDriverLink;

  // La schermata di avvio non si nasconde qui: la nasconde e la rimette
  // zPack (zSecurityLoginFrm) solo se la finestra di accesso si apre davvero,
  // e dalla sua posizione ricava il monitor su cui aprirla. Nascosta prima,
  // zPack non sapeva piu' dove stava e la finestra di accesso finiva sul
  // monitor scelto da Windows. Stesso comportamento di WinTarif e zTicser.
  zSystem.Login(true, false,
    procedure
    begin
      // Qui la finestra di accesso e' gia' chiusa e resta da caricare il
      // dizionario LZ: la schermata torna a coprire la parte lenta. Di norma
      // l'ha gia' rimessa zSecurityLoginFrm, e allora questa chiamata non fa
      // niente.
      TSmartSplashForm.Show;
    end);

  if not LoggedIn then
    Exit;

  AfterLogin;

  if TerminalServer then
    UserLog('Login');

  inherited;

  CheckVersioneEseguibile;

  // zSystem.SwitchLookupCtrlType(ctLookup, ctLookupExt);
  pippo;
end;

procedure TConfig.AfterLogin;
var
  v: Variant;
begin
  if LoggedIn then
  begin
    // TODO BaseNew
    // zSystem.CustomerPreferences.CanEditCaptions := zSystem.Authorizhed(Gesty_Authorizations.CUSTOMIZZA_CAPTION);

    // TzFiles.AppRoot := zSystem.Root_Files;

    zReportConfig.ReportRoot := zSystem.Root_Files;
    // cartella proposta dalle finestre di salvataggio di zPack (zOffice, esportazioni)
    TFolders.UserDocumentsFolder := CartellaPersonaleUtenteCorrente;

    zHelpConfig.HelpFolder := Config.zSystem.rootFolder('DOCUMENTAZIONE', 'Documentazione');
    zHelpConfig.HelpGenWorkingFolder := Config.zSystem.rootFolder('HelpGenWorkingFolder', 'HelpGenWorkingFolder');
    zHelpConfig.TemplateFolder := zHelpConfig.HelpFolder + '__Template\';
    zHelpConfig.TemplateFileName := zHelpConfig.TemplateFolder + 'Template Documentazione.docx';

    InitTls;
    InitSMTPServerAssistenza;
    InitSMTPServerDefault;
    InitMantis;
    SetLoginInfo;
    AvviaControlloFasciaOraria;

    dx.InitSpellChecker(CartellaPersonaleUtenteCorrente);

    LoadModuli;
    Load_GMAPS_API_KEY;

    InitAFK;

    /// /////////////////////////////////

    v := Database.ExecSQLScalar('SELECT MON$WIRE_COMPRESSED FROM MON$ATTACHMENTS WHERE MON$ATTACHMENT_ID = CURRENT_CONNECTION');

    if VarIsNull(v) then
      FWireCompression := false
    else
      FWireCompression := v;
  end;
end;

procedure TConfig.Log(Msg: string);
var
  FileHandle: TextFile;
  IoRes: Integer;
  LogFileName: string;
  s: string;
begin
  siMain.LogString('Config.Log', Msg);

  s := DateTimeToStr(Now) + ';' + CurrentUser + ';' + Msg;

  LogFileName := ChangeFileExt(Application.ExeName, '.log');
{$I-}
  AssignFile(FileHandle, LogFileName);

  if FileExists(LogFileName) then
    Append(FileHandle)
  else
    Rewrite(FileHandle);

  WriteLn(FileHandle, s);

  CloseFile(FileHandle);
{$I+} IoRes := IOResult;
end;

function TConfig.LoggedIn: Boolean;
begin
  Result := Database.Connected;
end;

procedure TConfig.ApplicationEvents1Activate(Sender: TObject);
begin
  inherited;

  if Assigned(Screen.ActiveCustomForm) then
    Screen.ActiveCustomForm.BringToFront;
end;

procedure TConfig.ApplicationEventsShortCut(var Msg: TWMKey; var Handled: Boolean);

  procedure SendCharacter(AHandle: HWnd; aChar: Word);
  const
    WM_UNICHAR: Word = $109;
    INPUT_KEYBOARD = 1; // wrong??? in Borland def
    KEYEVENTF_UNICODE = 4; // not defined in Borland def
  var
    Inputs: array [0 .. 2] of TInput;
    Key: tagKEYBDInput; // TKeyboardInput;
    ANSIString: array [0 .. 1] of Char;
    UniString: array [0 .. 1] of WideChar;
  begin
    ANSIString[0] := Chr(aChar);
    ANSIString[1] := Chr(0);
    MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, @ANSIString, 1, @UniString, 2);
    Key.wVk := 0;
    Key.wScan := Ord(UniString[0]);
    Key.dwFlags := KEYEVENTF_UNICODE;
    Key.time := 0;
    Key.dwExtraInfo := GetMessageExtraInfo();
    Inputs[0].Itype := INPUT_KEYBOARD;
    Inputs[0].ki := Key;
    SendInput(1, Inputs[0], SizeOf(TInput));
  end;

var
  ShiftState: TShiftState;
begin
  inherited;

  case Msg.CharCode of
    VK_DECIMAL:
      begin
        Handled := true;
        SendCharacter(Application.Handle, Ord(','));
      end;
    Vk_F10:
      begin
        ShiftState := KeyDataToShiftState(Msg.KeyData);
        if (ssCtrl in ShiftState) then
          if Screen.ActiveForm <> nil then
          begin
            Handled := true;
            Screen.ActiveForm.Top := 3;
            Screen.ActiveForm.Left := 3;
            Screen.ActiveForm.WindowState := wsNormal;
            Screen.ActiveForm.BringToFront;
          end;
      end;

    Vk_F11:
      begin
        ShiftState := KeyDataToShiftState(Msg.KeyData);
        if (ssCtrl in ShiftState) then
          if zSystem.IsAdmin then
          begin
            Handled := true;
            ShowApplicationInspector;
          end;
      end;
    Vk_F12:
      begin
        ShiftState := KeyDataToShiftState(Msg.KeyData);
        if (ssCtrl in ShiftState) then
        begin
          Handled := true;

          // se già in ctrl+F12 mostra la form ed esce
          if (ssShift in ShiftState) and zSystem.IsAdmin then
          begin
            zSystem.ShowSystemForm;
            Exit;
          end;

          if zSystem.IsAdmin then
            zSystem.ResetAdmin
          else
            zSystem.CheckAdmin;

          if (ssShift in ShiftState) then
            if zSystem.IsAdmin then
              zSystem.ShowSystemForm;

          FormCollection.UpdatePolicies;
        end;
      end;

    Ord('L'):
      begin
        ShiftState := KeyDataToShiftState(Msg.KeyData);
        if (ssCtrl in ShiftState) and (ssShift in ShiftState) then
        begin
          Handled := true;
          // Commuta la registrazione da qualunque punto: la finestra di avviso
          // dice cosa e' appena successo senza fermare il lavoro.
          SessioneLog.Commuta(ocScorciatoia);
        end;
      end;

    Ord('S'):
      begin
        ShiftState := KeyDataToShiftState(Msg.KeyData);
        if (ssCtrl in ShiftState) and (ssShift in ShiftState) then
        begin
          Handled := true;
          SessioneLog.InserisciSegnalibro('', ocScorciatoia);
        end;
      end;
  end;
end;

procedure TConfig.CambiaPassword;
begin
  zSystem.zSecurity.ChangePassword;
end;

function TConfig.GetCartella(const FolderName: string): string;
begin
  Result := zSystem.Folder(FolderName, Path + FolderName);
  Result := CalcPath(Result);

  if not DirectoryExists(Result) then
  begin
    try
      ForceDirectories(Result);
    except
    end;
  end;
end;

procedure TConfig.CloseApplication;
var
  i: Integer;
begin
  FShuttingDown := true;

  TimerAFK.Enabled := false;
  TimerKill.Enabled := false;
  TimerShutdown.Enabled := false;

  for i := 0 to Screen.FormCount - 1 do
    if Screen.Forms[i] <> Application.MainForm then
      Screen.Forms[i].Close;

  for i := dxAlertWindowManager.Count - 1 downto 0 do
    dxAlertWindowManager.Close(dxAlertWindowManager.Items[i]);

  Application.MainForm.Close;
end;

function TConfig.SorgentiPath: string;
begin
  // Result := 'C:\Documents and Settings\Luca\Desktop\Gesty\Sorgenti\';
  Result := Path + 'RenderSorgenti';
  ForceDirectories(Result);
end;

procedure TConfig.HelpSommario;
begin
  Application.HelpCommand(HELP_CONTENTS, 0);

  // HELP_INDEX
end;

procedure TConfig.UserLog(const Msg: string);
var
  FileHandle: TextFile;
  IoRes: Integer;
  LogFileName: string;
  s: string;
begin

  if not LoggedIn then
    Exit;

  s := DateTimeToStr(Now) + ';' + CurrentUser + ';' + Msg;

  LogFileName := Path + 'UserLogs.csv';
{$I-}
  AssignFile(FileHandle, LogFileName);

  if FileExists(LogFileName) then
    Append(FileHandle)
  else
    Rewrite(FileHandle);

  WriteLn(FileHandle, s);
  CloseFile(FileHandle);
{$I+} IoRes := IOResult;
end;

function TConfig.ReadBoolFromIni(Section, Ident: string; Default: Boolean): Boolean;
var
  INI: TIniFile;
begin
  Result := default;
  INI := TIniFile.Create(zSystem.ConfigFileName('.Settings'));
  try
    Result := INI.ReadBool(Section, Ident, Default);
  finally
    FreeAndNil(INI);
  end;
  WriteBoolToIni(Section, Ident, Result);
end;

function TConfig.ReadDoubleFromIni(Section, Ident: string; Default: double): double;
var
  INI: TIniFile;
begin
  Result := Default;
  INI := TIniFile.Create(zSystem.ConfigFileName('.Settings'));
  try
    Result := INI.ReadFloat(Section, Ident, Default);
  finally
    FreeAndNil(INI);
  end;
  WriteDoubleToIni(Section, Ident, Result);
end;

function TConfig.ReadIntegerFromIni(Section, Ident: string; Default: Integer): Integer;
var
  INI: TIniFile;
begin
  Result := Default;
  INI := TIniFile.Create(zSystem.ConfigFileName('.Settings'));
  try
    Result := INI.ReadInteger(Section, Ident, Default);
  finally
    FreeAndNil(INI);
  end;
  WriteIntegerToIni(Section, Ident, Result);
end;

function TConfig.ReadStringFromIni(Section, Ident, Default: string): string;
var
  INI: TIniFile;
begin
  Result := Default;

  INI := TIniFile.Create(zSystem.ConfigFileName('.Settings'));
  try
    Result := INI.ReadString(Section, Ident, Default);
  finally
    FreeAndNil(INI);
  end;
  WriteStringToIni(Section, Ident, Result);
end;

procedure TConfig.ResetAdmin;
begin
  if zSystem.IsAdmin then
    zSystem.ResetAdmin
end;

procedure TConfig.WriteBoolToIni(Section, Ident: string; Value: Boolean);
var
  INI: TIniFile;
begin
  INI := TIniFile.Create(zSystem.ConfigFileName(Ext_Settings));
  try
    INI.WriteBool(Section, Ident, Value);
  finally
    FreeAndNil(INI);
  end;
end;

procedure TConfig.WriteDoubleToIni(Section, Ident: string; Value: double);
var
  INI: TIniFile;
begin
  INI := TIniFile.Create(zSystem.ConfigFileName(Ext_Settings));
  try
    INI.WriteFloat(Section, Ident, Value);
  finally
    FreeAndNil(INI);
  end;
end;

procedure TConfig.WriteIntegerToIni(Section, Ident: string; Value: Integer);
var
  INI: TIniFile;
begin
  INI := TIniFile.Create(zSystem.ConfigFileName(Ext_Settings));
  try
    INI.WriteInteger(Section, Ident, Value);
  finally
    FreeAndNil(INI);
  end;
end;

procedure TConfig.WriteStringToIni(Section, Ident, Value: string);
var
  INI: TIniFile;
begin
  INI := TIniFile.Create(zSystem.ConfigFileName(Ext_Settings));
  try
    INI.WriteString(Section, Ident, Value);
  finally
    FreeAndNil(INI);
  end;
end;

procedure TConfig.Login;
begin
  zSystem.Login(false);
  AfterLogin;
end;

procedure TConfig.ImportaLZ;
var
  i: Integer;
  idx: Integer;
  src: TzSystem;
  DataSet: TzDataSet;
  Card: TzDbCardProps;
  j: Integer;
  View: TzDbViewProps;
begin
  Exit;
  src := TzSystem.Create(nil);
  try
    src.FileName := 'C:\WinTarif3\EXE\Ver3092\wintarif3.lz';
    src.LoadZip;

    for i := 0 to src.zDataSets.Count - 1 do
      if StartingWith(src.zDataSets[i].Name, 'BonificaImmobili') or StartingWith(src.zDataSets[i].Name, 'AnalisiTerritorio') or StartingWith(src.zDataSets[i].Name, 'Accertamenti') or StartingWith(src.zDataSets[i].Name, 'Planimetria') or
        StartingWith(src.zDataSets[i].Name, 'Emissioni') or StartingWith(src.zDataSets[i].Name, 'Immobili') or StartingWith(src.zDataSets[i].Name, 'Intestatari.Accertamenti') or StartingWith(src.zDataSets[i].Name, 'Intestatari.InvitiIntestatari')
      then
      begin

        idx := zSystem.zDataSets.IndexOf(src.zDataSets[i].Name);
        if idx = -1 then
          DataSet := zSystem.zDataSets.Add
        else
          DataSet := zSystem.zDataSets[idx];

        // if not sametext(src.zDataSets[i].SQL_Select.Text, DataSet.SQL_Select.Text) then
        // outputdebugstring(pchar(src.zDataSets[i].Name));
        // Continue;

        DataSet.Assign(src.zDataSets[i]);

        for j := 0 to src.zDbViews.Count - 1 do
          if SameText(src.zDbViews[j].DataSet, DataSet.Name) then
          begin
            idx := zSystem.zDbViews.IndexOf(src.zDbViews[j].Name);
            if idx = -1 then
              View := zSystem.zDbViews.Add
            else
              View := zSystem.zDbViews[idx];

            View.Assign(src.zDbViews[j]);
          end;

        for j := 0 to src.zDbCards.Count - 1 do
          if SameText(src.zDbCards[j].DataSet, DataSet.Name) then
          begin
            idx := zSystem.zDbCards.IndexOf(src.zDbCards[j].Name);
            if idx = -1 then
              Card := zSystem.zDbCards.Add
            else
              Card := zSystem.zDbCards[idx];

            Card.Assign(src.zDbCards[j]);
          end;

      end;

    zSystem.SaveZip(csAll, '');
  finally
    FreeAndNil(src);
  end;
end;

procedure TConfig.InitAFK;
var
  sp: TSP_USR_GET_MAX_MINUTI_INATTIVITA;
begin
  TimerAFK.Enabled := false;
  FMaxMinutiInattivita := -1;

  sp := TSP_USR_GET_MAX_MINUTI_INATTIVITA.Create(WriteTrans);
  try
    sp.ExecuteAndCommit;
    FMaxMinutiInattivita := sp.Minuti;
  finally
    FreeAndNil(sp);
  end;

  if FMaxMinutiInattivita > 0 then
  begin
    TimerAFK.Interval := FMaxMinutiInattivita * 60 * 1000;
    TimerAFK.Enabled := true;
  end;
end;

function TConfig.IsAdmin: Boolean;
begin
  Result := zSystem.IsAdmin;
end;

function TConfig.CartellaPersonaleUtenteCorrente: string;
begin
  Result := zSystem.PersonalFolder;
end;

function TConfig.CurrentUser: string;
begin
  Result := zSystem.zSecurity.LoginParams.UserName;
end;

function TConfig.CurrentUserDisplayName: string;
begin
  Result := zSystem.zSecurity.LoginParams.UserDisplayName;
end;

function TConfig.dbCurrentUser: string;
begin
  Result := Database.Params.UserName;
end;

procedure TConfig.LZ_ChangeSqlToken(const OldToken, NewToken: string; const ShouldSave: Boolean);
var
  zDataSet: TzDataSet;
begin
  for zDataSet in zSystem.zDataSets do
  begin
    zDataSet.SQL_Select.Text := StringReplace(zDataSet.SQL_Select.Text, OldToken, NewToken, [rfReplaceAll, rfIgnoreCase]);
    zDataSet.SQL_Insert.Text := StringReplace(zDataSet.SQL_Insert.Text, OldToken, NewToken, [rfReplaceAll, rfIgnoreCase]);
    zDataSet.SQL_Update.Text := StringReplace(zDataSet.SQL_Update.Text, OldToken, NewToken, [rfReplaceAll, rfIgnoreCase]);
    zDataSet.SQL_Delete.Text := StringReplace(zDataSet.SQL_Delete.Text, OldToken, NewToken, [rfReplaceAll, rfIgnoreCase]);
    zDataSet.SQL_Refresh.Text := StringReplace(zDataSet.SQL_Refresh.Text, OldToken, NewToken, [rfReplaceAll, rfIgnoreCase]);
  end;

  if ShouldSave then
    zSystem.SaveZip(csAll, '');
end;

procedure TConfig.LZ_ChangeTableName(const OldTableName, NewTableName: string; const ShouldSave: Boolean);
var
  i: Integer;
begin
  for i := 0 to zSystem.zDataSets.Count - 1 do
    if SameText(zSystem.zDataSets[i].TableName, OldTableName) then
      zSystem.zDataSets[i].TableName := NewTableName;

  if ShouldSave then
    zSystem.SaveZip(csAll, '');
end;

procedure TConfig.LZ_RenameDatamodule(const aOldName, aNewName: string);
var
  i: Integer;

  OldName, NewName: string;
begin
  OldName := aOldName + '.';
  NewName := aNewName + '.';

  for i := 0 to zSystem.zDataSets.Count - 1 do
    if StartingWith(zSystem.zDataSets[i].Name, OldName) then
      zSystem.zDataSets[i].Name := StringReplace(zSystem.zDataSets[i].Name, OldName, NewName, []);

  for i := 0 to zSystem.zDbCards.Count - 1 do
  begin
    if StartingWith(zSystem.zDbCards[i].Name, OldName) then
      zSystem.zDbCards[i].Name := StringReplace(zSystem.zDbCards[i].Name, OldName, NewName, []);

    if StartingWith(zSystem.zDbCards[i].DataSet, OldName) then
      zSystem.zDbCards[i].DataSet := StringReplace(zSystem.zDbCards[i].DataSet, OldName, NewName, []);
  end;

  for i := 0 to zSystem.zDbViews.Count - 1 do
  begin
    if StartingWith(zSystem.zDbViews[i].Name, OldName) then
      zSystem.zDbViews[i].Name := StringReplace(zSystem.zDbViews[i].Name, OldName, NewName, []);

    if StartingWith(zSystem.zDbViews[i].DataSet, OldName) then
      zSystem.zDbViews[i].DataSet := StringReplace(zSystem.zDbViews[i].DataSet, OldName, NewName, []);
  end;

  zSystem.SaveZip(csAll, '');
end;

procedure TConfig.LZ_RenameDataSet(const OldName, NewName: string; const ShouldSave: Boolean = false);
var
  i: Integer;
begin
  for i := 0 to zSystem.zDataSets.Count - 1 do
    if SameText(zSystem.zDataSets[i].Name, OldName) then
      zSystem.zDataSets[i].Name := NewName;

  for i := 0 to zSystem.zDbCards.Count - 1 do
    if SameText(zSystem.zDbCards[i].Name, OldName) then
    begin
      zSystem.zDbCards[i].Name := NewName;
      zSystem.zDbCards[i].DataSet := NewName;
    end;

  for i := 0 to zSystem.zDbViews.Count - 1 do
    if SameText(zSystem.zDbViews[i].Name, OldName) then
    begin
      zSystem.zDbViews[i].Name := NewName;
      zSystem.zDbViews[i].DataSet := NewName;
    end;

  if ShouldSave then
    zSystem.SaveZip(csAll, '');
end;

procedure TConfig.zSystemHyperLink(Sender: TObject; FieldName: string; Value: Variant);
begin
  inherited;
  HyperLinks.doHyperLink(Sender, FieldName, Value);
end;

procedure TConfig.Startup;
var
  oldCursor: TCursor;
begin
  oldCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    MostraNotifiche;
    MostraBadgeNotifiche;
  finally
    Screen.Cursor := oldCursor;
  end;
end;

function TConfig.StorageFileName: String;
var
  tmp: string;
begin
  Result := '';

  tmp := zSystem.ConfigFileName(Ext_Forms);

  if DirectoryExists(ExtractFilePath(tmp)) then // problemi su merlino
    Result := tmp;
end;

procedure TConfig.DatabaseAfterConnect(Sender: TObject);
var
  s: string;
begin
  inherited;
  // registrare gli eventi
  FDEventAlerter.Names.Clear;
  s := Database.ExecSQLScalar('SELECT USR_GET_EVENT_NAME() FROM RDB$DATABASE');
  FDEventAlerter.Names.Add(s);
  FDEventAlerter.Names.Add('SHUTDOWN');
  FDEventAlerter.Names.Add('SHUTDOWN_' + CurrentUser);
  // Fasce orarie 2026-09-18: annuncio di chi e' rimasto fuori fascia dopo
  // una modifica alla configurazione.
  FDEventAlerter.Names.Add(EventoFasciaOraria + CurrentUser);

  FDEventAlerter.Names.Add('NOTIFICA');
  FDEventAlerter.Names.Add('REFRESH_SCHEDULER');

  // TFDPhysFBConnectionDefParams(Database.Params).IbAdvanced := 'no_db_triggers=1';
  // try
  FDEventAlerter.Register;
  // finally
  // TFDPhysFBConnectionDefParams(Database.Params).IbAdvanced := 'no_db_triggers=0';
  // end;
end;

function TConfig.Authorizhed(const Authorization: string; const TrueIfAdmin: Boolean = true): Boolean;
begin
  Result := zSystem.Authorizhed(Authorization, TrueIfAdmin);
end;

procedure TConfig.Autorun(Actions: TActionList);
begin
  zSystem.Autorun(Actions);
end;

function TConfig.CurrentUserID: Integer;
begin
  Result := zSystem.zSecurity.LoginParams.UserID;
end;

procedure TConfig.pippo;
const
  Risorse = 'Risorse.';
  Aziende = 'Aziende.';
  Personale = 'PersonaleElenco.';
var
  Card: TzDbCardProps;
  View: TzDbViewProps;
  DataSet: TzDataSet;
  DiagramDataSet: TzDiagramDataSet;
  DiagramDataSetDest: TzDiagramDataSet;
  dmRisorse: TzDataModule;
  dm: TzDataModule;
  src: TzDomain;
  item: TzDomain;
  stringList: TStringList;

  procedure Exp(const Name: string; imageIndex: Integer);
  var
    bmp: TBitmap;
  begin
    // 16
    bmp := TBitmap.Create;
    try
      bmp.Height := 16;
      bmp.Width := 16;
      bmp.PixelFormat := pf32bit;
      bmp.AlphaFormat := afIgnored;
      zDmImages.ImageList16.GetBitmap(imageIndex, bmp);
      bmp.SaveToFile('C:\Users\Luca\Desktop\Nuova cartella\16\' + Name.trim + '.bmp');
    finally
      FreeAndNil(bmp);
    end;

    // 24
    bmp := TBitmap.Create;
    try
      bmp.Height := 24;
      bmp.Width := 24;
      bmp.PixelFormat := pf32bit;
      bmp.AlphaFormat := afIgnored;
      zDmImages.ImageList24.GetBitmap(imageIndex, bmp);
      bmp.SaveToFile('C:\Users\Luca\Desktop\Nuova cartella\24\' + Name.trim + '.bmp');
    finally
      FreeAndNil(bmp);
    end;
  end;

begin
  Exit;
  Exp('Risorse                  ', 552);
  Exp('Oggi                     ', 533);
  Exp('Seleziona Giorno         ', 534);
  Exp('Precedente               ', 531);
  Exp('Successivo               ', 532);
  Exp('Elimina                  ', 38);
  Exp('Modifica                 ', 41);
  Exp('Taglia                   ', 35);
  Exp('Copia                    ', 36);
  Exp('Incolla                  ', 37);
  Exp('Giorno                   ', 536);
  Exp('Settimana                ', 538);
  Exp('Mese                     ', 539);
  Exp('Nuova Prenotazione       ', 566);
  Exp('Nuovo                    ', 529);
  Exp('Esporta                  ', 82);
  Exp('Anteprima                ', 554);
  Exp('Nuova Ricorrenza         ', 530);
  Exp('Oggi                     ', 533);
  Exp('Seleziona Giorno         ', 534);
  Exp('Settimana Successiva     ', 535);
  Exp('agenda                   ', 543);
  Exp('Giorno                   ', 536);
  Exp('Settimana Lavorativa     ', 537);
  Exp('Settimana                ', 538);
  Exp('Mese                     ', 539);
  Exp('Timeline                 ', 540);
  Exp('Anno                     ', 541);
  Exp('Gantt                    ', 542);
  Exp('Nessun Raggruppamento    ', 544);
  Exp('Raggruppa Per Data       ', 545);
  Exp('Raggruppa Per Risorsa    ', 546);
  Exp('Comprimi Fine Settimana  ', 548);
  Exp('Solo Orario Lavorativo   ', 549);
  Exp('Adatta Eventi            ', 550);
  Exp('Mostra Calendario        ', 551);

  Exit;

  for item in zSystem.zDataDictionary do
  begin
    if item.FieldName.Contains('CODICE_FISCALE') then
      item.OnChange := 'CodiceFiscale'
    else
      if item.FieldName.Contains('PARTITA_IVA') then
        item.OnChange := 'PartitaIva';
  end;

  zSystem.SaveZip(csAll, '');

  Exit;

  for item in zSystem.zDataDictionary do
    if AnsiIndexText(item.FieldName, ['ORE_ASSEGNATE_ANNO_PRECEDENTE', 'ORE_ASSEGNATE_ANNO_CORRENTE', 'COSTO_ORARIO', 'MONTE_ORE_SET_DIC', 'COSTO_PREVENTIVO_SET_DIC', 'ORE_RENDICONTATE_SET_DIC', 'COSTO_CONSUNTIVO_SET_DIC', 'MONTE_ORE_GEN_AGO',
      'COSTO_PREVENTIVO_GEN_AGO', 'ORE_RENDICONTATE_GEN_AGO', 'COSTO_CONSUNTIVO_GEN_AGO', 'MONTE_ORE_TOTALI', 'COSTO_PREVENTIVO_TOTALI', 'ORE_USUFRUITE_TOTALI', 'RESIDUO_ORE_DA_RENDICONTARE', 'COSTO_CONSUNTIVO_TOTALI', 'RESIDUO_COSTO_PREVENTIVO',
      'SETTEMBRE_ORE_DIRETTE', 'SETTEMBRE_ORE_INDIRETTE', 'SETTEMBRE_ORE_FORMAZIONE', 'SETTEMBRE_ORE_TOTALI', 'SETTEMBRE_IMPORTO', 'OTTOBRE_ORE_DIRETTE', 'OTTOBRE_ORE_INDIRETTE', 'OTTOBRE_ORE_FORMAZIONE', 'OTTOBRE_ORE_TOTALI', 'OTTOBRE_IMPORTO',
      'NOVEMBRE_ORE_DIRETTE', 'NOVEMBRE_ORE_INDIRETTE', 'NOVEMBRE_ORE_FORMAZIONE', 'NOVEMBRE_ORE_TOTALI', 'NOVEMBRE_IMPORTO', 'DICEMBRE_ORE_DIRETTE', 'DICEMBRE_ORE_INDIRETTE', 'DICEMBRE_ORE_FORMAZIONE', 'DICEMBRE_ORE_TOTALI', 'DICEMBRE_IMPORTO',
      'GENNAIO_ORE_DIRETTE', 'GENNAIO_ORE_INDIRETTE', 'GENNAIO_ORE_FORMAZIONE', 'GENNAIO_ORE_TOTALI', 'GENNAIO_IMPORTO', 'FEBBRAIO_ORE_DIRETTE', 'FEBBRAIO_ORE_INDIRETTE', 'FEBBRAIO_ORE_FORMAZIONE', 'FEBBRAIO_ORE_TOTALI', 'FEBBRAIO_IMPORTO',
      'MARZO_ORE_DIRETTE', 'MARZO_ORE_INDIRETTE', 'MARZO_ORE_FORMAZIONE', 'MARZO_ORE_TOTALI', 'MARZO_IMPORTO', 'APRILE_ORE_DIRETTE', 'APRILE_ORE_INDIRETTE', 'APRILE_ORE_FORMAZIONE', 'APRILE_ORE_TOTALI', 'APRILE_IMPORTO', 'MAGGIO_ORE_DIRETTE',
      'MAGGIO_ORE_INDIRETTE', 'MAGGIO_ORE_FORMAZIONE', 'MAGGIO_ORE_TOTALI', 'MAGGIO_IMPORTO', 'GIUGNO_ORE_DIRETTE', 'GIUGNO_ORE_INDIRETTE', 'GIUGNO_ORE_FORMAZIONE', 'GIUGNO_ORE_TOTALI', 'GIUGNO_IMPORTO', 'LUGLIO_ORE_DIRETTE', 'LUGLIO_ORE_INDIRETTE',
      'LUGLIO_ORE_FORMAZIONE', 'LUGLIO_ORE_TOTALI', 'LUGLIO_IMPORTO', 'AGOSTO_ORE_DIRETTE', 'AGOSTO_ORE_INDIRETTE', 'AGOSTO_ORE_FORMAZIONE', 'AGOSTO_ORE_TOTALI', 'AGOSTO_IMPORTO', 'TOTALE_ORE_DIRETTE', 'TOTALE_ORE_INDIRETTE', 'TOTALE_ORE_FORMAZIONE',
      'TOTALE_ORE', 'TOTALE_IMPORTO']) <> -1 then
      item.DisplayFormat := '###,##0.00';
  //
  zSystem.SaveZip(csAll, '');

  /// ///////////////////////////////
  Exit;
  /// ///////////////////////////////

  stringList := TStringList.Create;
  try
    for dm in zSystem.zDataModules do
      stringList.Add(dm.Name + '=' + dm.FormOptions.HelpKeyword);

    stringList.SaveToFile('C:\Users\Luca\Desktop\help.txt');
  finally
    FreeAndNil(stringList);
  end;

  ///
  for item in zSystem.zDataDictionary do
    if item.TableName = 'RICHIESTE_ATTIVAZIONE_ELENCO' then
    begin
      src := zSystem.zDataDictionary.get('RICHIESTE_ATTIVAZIONE.' + item.FieldName, false);

      if Assigned(src) then
      begin

        item.Identity := src.Identity;
        item.ReadOnly := src.ReadOnly;
        item.Exists := src.Exists;
        item.Calculated := src.Calculated;
        item.Required := src.Required;
        item.Size := src.Size;
        item.Lookup := src.Lookup;
        item.PickList := src.PickList;
        item.DefaultExpression := src.DefaultExpression;
        item.EditMask := src.EditMask;
        item.DisplayLabel := src.DisplayLabel;
        item.DisplayFormat := src.DisplayFormat;
        // item.Hint := src.Hint;
        item.Alignment := src.Alignment;
        item.CharCase := src.CharCase;
        item.zCtrlType := src.zCtrlType;
        item.EditFormat := src.EditFormat;
        item.Currency := src.Currency;
        item.Precision := src.Precision;
        item.MinValue := src.MinValue;
        item.MaxValue := src.MaxValue;
        item.BlobType := src.BlobType;
        item.PasswordChar := src.PasswordChar;
        item.FieldsToClear := src.FieldsToClear;
      end;
    end;

  zSystem.SaveZip(csAll, '');
  Exit;
  /// ///////////////////////////////
  for DataSet in zSystem.zDataSets do
    if DataSet.Name.StartsWith(Aziende) then
      DataSet.Name := DataSet.Name.Replace(Aziende, Risorse)
    else
      if DataSet.Name.StartsWith(Personale) then
        DataSet.Name := DataSet.Name.Replace(Personale, Risorse);
  /// ////////////////////////////////////////
  for Card in zSystem.zDbCards do
    if Card.Name.StartsWith(Aziende) then
    begin
      Card.Name := Card.Name.Replace(Aziende, Risorse);
      Card.DataSet := Card.DataSet.Replace(Aziende, Risorse);
    end
    else
      if Card.Name.StartsWith(Personale) then
      begin
        Card.Name := Card.Name.Replace(Personale, Risorse);
        Card.DataSet := Card.DataSet.Replace(Personale, Risorse);
      end;
  /// ////////////////////////////////////////
  for View in zSystem.zDbViews do
    if View.Name.StartsWith(Aziende) then
    begin
      View.Name := View.Name.Replace(Aziende, Risorse);
      View.DataSet := View.DataSet.Replace(Aziende, Risorse);
    end
    else
      if View.Name.StartsWith(Personale) then
      begin
        View.Name := View.Name.Replace(Personale, Risorse);
        View.DataSet := View.DataSet.Replace(Personale, Risorse);
      end;
  /// ////////////////////////////////////////
  /// ////////////////////////////////////////
  /// ////////////////////////////////////////
  dmRisorse := zSystem.zDataModules.get('Risorse', false);

  dm := zSystem.zDataModules.get('PersonaleElenco', false);
  for DiagramDataSet in dm.DataSets do
    dmRisorse.DataSets.Add.Assign(DiagramDataSet);

  dm := zSystem.zDataModules.get('Aziende', false);
  for DiagramDataSet in dm.DataSets do
    dmRisorse.DataSets.Add.Assign(DiagramDataSet);

  zSystem.Modified := true;
  zSystem.SaveChanges;
end;

procedure TConfig.TimerShutdownTimer(Sender: TObject);
begin
  inherited;
  CloseApplication;
end;

procedure TConfig.AvviaControlloFasciaOraria;
begin
  if not Assigned(FControlloFasciaOraria) then
  begin
    FControlloFasciaOraria := TzControlloFasciaOraria.Create(self, Database, ReadTrans);
    FControlloFasciaOraria.OnAvviso := ControlloFasciaOrariaAvviso;
    FControlloFasciaOraria.OnAccessoScaduto := ControlloFasciaOrariaScaduto;
  end;

  // Il controllo chiede al server se l'utente e' dentro la sua fascia e
  // fra quanti secondi il verdetto puo' cambiare. Se il database non
  // conosce le fasce orarie, o l'utente non ne ha, resta spento da solo.
  FControlloFasciaOraria.Avvia(zSystem.AppName, CurrentUserID);
end;

procedure TConfig.ControlloFasciaOrariaAvviso(Sender: TObject; SecondiResidui: Integer);
begin
  dxAlertWindowManager.Show('Fascia oraria di accesso', Format('L''accesso termina fra %d minuti: salvare il lavoro in corso.', [(SecondiResidui + 59) div 60]));
end;

procedure TConfig.ControlloFasciaOrariaScaduto(Sender: TObject);
begin
  ConfirmOk('L''accesso non è più consentito in questa fascia oraria.' + sLineBreak + sLineBreak + 'L''applicazione verrà chiusa.', mtWarning);
  // In Gesty TConfig.Shutdown manda l'avviso a TUTTI gli utenti: la
  // chiusura della sola postazione e' CloseApplication.
  CloseApplication;
end;

procedure TConfig.Shutdown;
var
  sp: TSP_ZZ_SHUTDOWN;
begin

  if not ConfirmYesNo('Inviare il messaggio di shutdown a tuttti gli utenti?') then
    Exit;

  if not ConfirmYesNo('Attenzione! Si sta forzando la chiusura dell''applicazione per tutti gli utenti. Continuare?', mtWarning) then
    Exit;

  FDisabilitaEventiDB := true;

  sp := TSP_ZZ_SHUTDOWN.Create(WriteTrans);
  try
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TConfig.BroadcastMessage;
begin
  ConfirmOk('Implementare');

  // FDisabilitaEventiDB := false;
end;

procedure TConfig.ApplicationEventsException(Sender: TObject; E: Exception);
var
  zExceptionManager: TzExceptionManager;
begin
  StopWait;

  // if false then
  if true then
  begin
    zExceptionManager := TzExceptionManager.Create(E);
    try
      zExceptionManager.LogException('');
      zExceptionManager.ShowException;
    finally
      FreeAndNil(zExceptionManager);
    end;
  end
  else
  begin
    Log('Eccezione: ' + '__' + E.className + '__ ' + E.message);
    siMain.LogException(E);
    ConfirmOk(E.message);
  end;
end;

procedure TConfig.TimerAFKTimer(Sender: TObject);
var
  afk: Integer;
  i: Integer;
  plii: TLastInputInfo;
  secs: Integer;
begin
  TimerKill.Enabled := false;

  if MaxMinutiInattivita <= 0 then
  begin
    TimerAFK.Enabled := false;
    Exit;
  end;

  // if OnMessage:
  // Handled := False;
  // case Msg.message of
  // WM_KEYFIRST .. WM_KEYLAST, WM_MOUSEFIRST .. WM_MOUSELAST:
  // FIdleCounter := 0;
  // end;

  plii.cbSize := SizeOf(plii);
  GetLastInputInfo(plii);
  afk := (GetTickCount - plii.dwTime) DIV 1000; // in secondi

  // if afk >= (MaxMinutiInattivita * 60) then
  // CloseApplication
  // else
  if afk >= ((MaxMinutiInattivita - 1) * 60) then
  begin
    for i := dxAlertWindowManager.Count - 1 downto 0 do
      dxAlertWindowManager.Close(dxAlertWindowManager.Items[i]);

    dxAlertWindowManager.OptionsBehavior.DisplayTime := TimerAFK.Interval;
    dxAlertWindowManager.WindowPosition := awpTopLeft;

    secs := TimerKill.Interval div 1000;

    dxAlertWindowManager.Show('Disconnessione', 'Attenzione: l''applicazione verrà terminata tra ' + secs.ToString + ' secondi.').tag := -100;

    TimerKill.Enabled := false;
    TimerKill.Enabled := true;
  end;
end;

procedure TConfig.TimerKillTimer(Sender: TObject);
begin
  inherited;
  CloseApplication;
end;

procedure TConfig.zSystemAssignDataSetEvent(DataSet: TzFbDataSet; DataSetEventKind: TDataSetEventKind; const EventName: string);
begin
  inherited;

  if Assigned(DataSetEvents) then
    DataSetEvents.AssignDataSetEvent(DataSet, DataSetEventKind, EventName);
end;

procedure TConfig.CheckVersioneEseguibile;
var
  sp: TSP_VER_VERIFICA_VERSIONE_EXE;
  major, minor, release, build: Integer;
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(Application.ExeName), Dummy);
  if VerInfoSize = 0 then
    Exit;

  GetMem(VerInfo, VerInfoSize);
  try
    GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
    VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);

    major := VerValue^.dwFileVersionMS shr 16;
    minor := VerValue^.dwFileVersionMS and $FFFF;
    release := VerValue^.dwFileVersionLS shr 16;
    build := VerValue^.dwFileVersionLS and $FFFF;
  finally
    FreeMem(VerInfo, VerInfoSize);
  end;

  /// ////////////////////////////////////////////////////

  sp := TSP_VER_VERIFICA_VERSIONE_EXE.Create(WriteTrans);
  try
    sp.EXE_VER_1_MAJOR := major;
    sp.EXE_VER_2_MINOR := minor;
    sp.EXE_VER_3_RELEASE := release;
    sp.EXE_VER_4_BUILD := build;

    sp.ExecuteAndCommit;

    if sp.VERSIONE_ERRATA then
      ConfirmOk('Versione eseguibile non valida, si consiglia di aggiornare.');
  finally
    FreeAndNil(sp);
  end;
end;

procedure TConfig.DatabaseError(ASender, AInitiator: TObject; var AException: Exception);
begin
  inherited;
  zExceptions.FireDAC.CaptureFailedDataSet(ASender, AInitiator);
  raise AException;
end;

procedure TConfig.DatabaseRecover(ASender, AInitiator: TObject; AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
begin
  inherited;
  ConfirmOk('Disconnesione dal server.' + sLineBreak + sLineBreak + 'L''applicazione verrà chiusa.', mtError);
  AAction := faFail;
  CloseApplication;
end;

procedure TConfig.InitTls;
var
  sp: TSP_config_Tls_Get;
  Motore: string;
  CartellaDll: string;
begin
  // Motore TLS (posta, PEC, FTP) scelto dall'installazione tramite la riga
  // singola di CONFIG (TLS_ENGINE), uguale per tutte le postazioni collegate
  // a questo database. Entrambi i provider (zNet.Tls.OpenSsl, zNet.Tls.SChannel)
  // sono sempre inclusi nel .dpr: da qui in avanti CreaIOHandlerTls usa quello
  // scelto qui. Va eseguita prima del primo invio di posta o collegamento FTP.
  // Se la lettura fallisce (database non ancora aggiornato) si resta su
  // OPENSSL, il comportamento di oggi: l'errore viene comunque mostrato.
  Motore := 'OPENSSL';
  CartellaDll := '';
  try
    sp := TSP_config_Tls_Get.Create(WriteTrans);
    try
      sp.ExecuteAndCommit;
      Motore := trim(sp.Tls_Engine.GetValueOrDefault('OPENSSL'));
      CartellaDll := trim(sp.Tls_Dll_Path.GetValueOrDefault(''));
    finally
      FreeAndNil(sp);
    end;
  except
    on E: Exception do
      Application.ShowException(E);
  end;

  try
    zNet.Tls.SelezionaProviderTls(Motore);
    // Cartella di libeay32.dll/ssleay32.dll (TLS_DLL_PATH): solo se indicata,
    // altrimenti resta il default del provider (la cartella dell'eseguibile).
    // Non ha effetto se il motore scelto e' SCHANNEL, che non usa DLL.
    if CartellaDll <> '' then
      zNet.Tls.ImpostaCartellaLibrerieTLS(CartellaDll);
    Log('Motore TLS: ' + zNet.Tls.ProviderTlsSelezionatoDescrizione);
  except
    on E: Exception do
      Application.ShowException(E);
  end;
end;

procedure TConfig.InitSMTPServerAssistenza;
var
  sp: TSP_smtp_Params_Assistenza;
begin
  TzExceptionManager.SMTPServerParams.Init;
  try
    sp := TSP_smtp_Params_Assistenza.Create(WriteTrans);
    try
      sp.ExecuteAndCommit;
      TzExceptionManager.MailAddress := sp.EMAIL_ASSISTENZA;
      TzExceptionManager.SMTPServerParams.From := sp.NOMINATIVO_RISORSA;
      TzExceptionManager.SMTPServerParams.FromAddress := sp.EMAIL_FROM_ADDRESS;
      TzExceptionManager.SMTPServerParams.ReplyTo := sp.EMAIL_REPLAY_TO;
      TzExceptionManager.SMTPServerParams.ReceiptRecipient := sp.EMAIL_CONFERMA_LETTURA;
      TzExceptionManager.SMTPServerParams.Host := sp.Smtp_Host;
      TzExceptionManager.SMTPServerParams.Port := sp.Smtp_Port;
      TzExceptionManager.SMTPServerParams.UserName := sp.Smtp_UserName;
      TzExceptionManager.SMTPServerParams.Password := sp.Smtp_Password;
      TzExceptionManager.SMTPServerParams.AuthenticationType := sp.Authentication_Type;
      TzExceptionManager.SMTPServerParams.ssl := sp.ssl;
      TzExceptionManager.SMTPServerParams.ssl_ver := sp.ssl_ver;
    finally
      FreeAndNil(sp);
    end;
  except
    on E: Exception do
      Application.ShowException(E);
  end;
end;

procedure TConfig.InitSMTPServerDefault;
var
  sp: TSP_SMTP_PARAMS_DEFAULT;
begin
  SMTPServerParams.Init;
  try
    sp := TSP_SMTP_PARAMS_DEFAULT.Create(WriteTrans);
    try
      sp.ExecuteAndCommit;
      SMTPServerParams.From := sp.NOMINATIVO_RISORSA;
      SMTPServerParams.FromAddress := sp.EMAIL_FROM_ADDRESS;
      SMTPServerParams.ReplyTo := sp.EMAIL_REPLAY_TO;
      SMTPServerParams.ReceiptRecipient := sp.EMAIL_CONFERMA_LETTURA;
      SMTPServerParams.Host := sp.Smtp_Host;
      SMTPServerParams.Port := sp.Smtp_Port;
      SMTPServerParams.UserName := sp.Smtp_UserName;
      SMTPServerParams.Password := sp.Smtp_Password;
      SMTPServerParams.AuthenticationType := sp.Authentication_Type;
      SMTPServerParams.ssl := sp.ssl;
      SMTPServerParams.ssl_ver := sp.ssl_ver;
    finally
      FreeAndNil(sp);
    end;
  except
    on E: Exception do
      Application.ShowException(E);
  end;
end;

procedure TConfig.zSystemAssignFieldOnChangeEvent(Field: TField; const EventName: string);
begin
  inherited;

  if Assigned(EventHandler) then
    EventHandler.AssignFieldOnChangeEvent(Field, EventName);
end;

procedure TConfig.Load_GMAPS_API_KEY;
var
  sp: TSP_get_Gmaps_Api_Key;
  Key: string;
begin
  sp := TSP_get_Gmaps_Api_Key.Create(WriteTrans);
  try
    sp.ExecuteAndCommit;
    Key := sp.Gmaps_Api_Key;
    zMap.SetGoogleAPI(Key);
  finally
    FreeAndNil(sp);
  end;
end;

procedure TConfig.InitTaskbar;
begin

  OnStartWait := procedure
    begin
      TaskbarManager.StartWait;
    end;

  OnStopWait := procedure
    begin
      TaskbarManager.StopWait;
    end;

  OnProgressBox_Show := procedure(MaxValue: Integer)
    begin
      TaskbarManager.ProgressBox_Start(MaxValue);
    end;

  OnProgressBox_Progress := procedure(Progress: Integer)
    begin
      TaskbarManager.ProgressBox_Progress(Progress);
    end;

  OnProgressBox_Paused := procedure
    begin
      TaskbarManager.ProgressBox_Paused
    end;

  OnProgressBox_Close := procedure
    begin
      TaskbarManager.ProgressBox_Stop;
    end;

  OnBeforeException := procedure
    begin
      TaskbarManager.BeforeException;
    end;

  OnAfterException := procedure
    begin
      TaskbarManager.AfterException;
    end;
end;

function TConfig.ExecBooleanFunc(const FunctionName: string): Boolean;
var
  v: Variant;
begin
  Result := false;

  v := Database.ExecSQLScalar('SELECT ' + FunctionName + '() FROM RDB$DATABASE');

  if not VarIsNull(v) then
    Result := v;
end;

function TConfig.ExecIntFunc(const FunctionName: string): Integer;
var
  v: Variant;
begin
  Result := -1;

  v := Database.ExecSQLScalar('SELECT ' + FunctionName + '() FROM RDB$DATABASE');

  if not VarIsNull(v) then
    Result := v;
end;

procedure TConfig.MostraNotifiche;
var
  DataSet: TzFbDataSet;
  sp: TSP_NOTIFICHE_VISUALIZZATA;
  dxAlertWindow: TdxAlertWindow;
  i: Integer;
  id: Integer;
  Messaggio: string;
  TagId: Integer;
  TagStr: string;
  Titolo: string;
  Info: TNotificaInfo;
begin
  DataSet := CreateFbDataSet(nil, Database, DefaultReadTrans, DefaultWriteTrans, true);
  try
    sp := TSP_NOTIFICHE_VISUALIZZATA.Create(WriteTrans);
    try
      DataSet.FetchOptions.UniDirectional := true;
      DataSet.SelectSQL.Text := 'SELECT * FROM NOTIFICHE_DA_VISUALIZZARE';
      DataSet.Active := true;

      i := 0;
      while not DataSet.Eof do
      begin

        // ID_NOTIFICA
        // NOTIFICA
        // USER_ID_MITTENTE
        // NOMINATIVO_MITTENTE
        // USER_ID_DESTINATARIO
        // NOMINATIVO_DESTINATARIO
        // OGGETTO
        // MESSAGGIO
        // DATA_ORA_NOTIFICA
        // DATA_ORA_VISUALIZZAZIONE
        // DATA_ORA_LETTURA
        // TAG_ID
        // TAG_STR

        id := DataSet.FieldByName('ID_NOTIFICA').AsInteger;

        // Punto 3 (Ticket #14): evita il doppio pop-up se la notifica e' gia'
        // visibile (es. Startup + evento NOTIFICA ravvicinati sulla stessa
        // notifica). La marchiamo comunque come visualizzata per non farla
        // ripresentare in futuro, ma senza aprire un secondo alert.
        if NotificaGiaMostrata(id) then
        begin
          sp.Id_Notifica := id;
          sp.ExecuteAndCommit;
          DataSet.Next;
          Continue;
        end;

        Titolo := DataSet.FieldByName('OGGETTO').AsString;
        Messaggio := DataSet.FieldByName('MESSAGGIO').AsString;
        TagId := DataSet.FieldByName('TAG_ID').AsInteger;
        TagStr := DataSet.FieldByName('TAG_STR').AsString;

        dxAlertWindow := dxAlertWindowManager.Show(Titolo, Messaggio);
        dxAlertWindow.tag := id;
        dxAlertWindow.Pinned := true;

        Info := TNotificaInfo.Create;
        Info.AlertWindow := dxAlertWindow;
        Info.IdNotifica := id;
        Info.TagId := TagId;
        Info.TagStr := TagStr;
        ListaNotifiche.Add(Info);

        sp.Id_Notifica := id;
        sp.ExecuteAndCommit;

        inc(i);

        if i >= dxAlertWindowManager.WindowMaxCount then
          Break;

        DataSet.Next;
      end;
    finally
      FreeAndNil(sp);
    end;
  finally
    FreeAndNil(DataSet);
  end;
end;

procedure TConfig.NotificheLette;
var
  i: Integer;
begin
  for i := dxAlertWindowManager.Count - 1 downto 0 do
    if dxAlertWindowManager.Items[i].tag > 0 then
      dxAlertWindowManager.Close(dxAlertWindowManager.Items[i]);

  MostraBadgeNotifiche;
end;

procedure TConfig.MostraBadgeNotifiche;

  function getNumeroNotificheNonLette: Integer;
  var
    sp: TSP_NOTIFICHE_NUMERO_NOTIFICHE_DA_LEGGERE;
  begin
    sp := TSP_NOTIFICHE_NUMERO_NOTIFICHE_DA_LEGGERE.Create(WriteTrans);
    try
      sp.ExecuteAndCommit;
      Result := sp.NUMERO_NOTIFICHE_DA_LEGGERE;
    finally
      FreeAndNil(sp);
    end;
  end;

  procedure setTaskbarManagerIcon(const emptyIcon: Boolean);
  var
    Icon: TIcon;
  begin

    if emptyIcon then
      TaskbarManager.Icon := nil
    else
    begin
      Icon := TIcon.Create;
      try
        dx.TaskbarImages.GetIcon(0, Icon);
        TaskbarManager.Icon := Icon;
      finally
        FreeAndNil(Icon);
      end;
    end;
  end;

var
  NumeroNotificheNonLette: Integer;
begin
  NumeroNotificheNonLette := getNumeroNotificheNonLette;
  Main.MostraBadgeNotifiche(NumeroNotificheNonLette);
  setTaskbarManagerIcon(NumeroNotificheNonLette <= 0);
end;

procedure TConfig.LoadModuli;
var
  DataSet: TzFbDataSet;
begin
  DataSet := CreateFbDataSet(nil, Database, DefaultReadTrans, DefaultWriteTrans, true);
  try
    DataSet.FetchOptions.UniDirectional := true;
    DataSet.SelectSQL.Text := 'SELECT * FROM USR_MODULI';
    DataSet.Active := true;

    Moduli.LoadModuli(DataSet);
  finally
    FreeAndNil(DataSet);
  end;
end;

procedure TConfig.RegisterModuli(ModuliActions: TActionList);
begin
  Moduli.AddActionList(ModuliActions,
    procedure(Modulo: TModulo)
    var
      sp: TSP_usr_Moduli_Add;
    begin
      sp := TSP_usr_Moduli_Add.Create(WriteTrans);
      try
        sp.Modulo := Modulo.Modulo;
        sp.Titolo := Modulo.Titolo;
        sp.Stato_Attivazione := Modulo.StatoAttivazione.ToString;
        sp.ExecuteAndCommit;
      finally
        FreeAndNil(sp);
      end;
    end);
end;

function TConfig.GetStatoAttivazione(const Modulo: string): TStatoAttivazione;
begin
  Result := Moduli.GetStatoAttivazione(Modulo);
end;

function TConfig.CheckModulo(const Modulo, Titolo: string): Boolean;
var
  StatoAttivazione: TStatoAttivazione;
  sp: TSP_usr_Moduli_Add;
begin
  StatoAttivazione := GetStatoAttivazione(Modulo);

  // se non esiste aggiungerlo alla tabella
  if StatoAttivazione = saUnknown then
  begin
    sp := TSP_usr_Moduli_Add.Create(WriteTrans);
    try
      sp.Modulo := Modulo;
      sp.Titolo := Titolo;
      sp.Stato_Attivazione := saValutazione.ToString;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;
  end;

  /// ///

  case StatoAttivazione of
    saUnknown:
      Result := true;
    saAttivo:
      Result := true;
    saValutazione:
      begin
        Result := true;
        ConfirmOk('Modulo in valutazione.');
      end;
    saNonAttivo:
      begin
        Result := false;
        ConfirmOk('Modulo non registrato.');
      end;
    saSviluppo:
      begin
        Result := true;
        ConfirmOk('Attenzione: modulo in fase di sviluppo.');
      end;
  end;
end;

procedure TConfig.RicaricaImpostazioni;
var
  sp: TSP_usr_Fill_Tabelle_Tmp;
begin
  StartWait('Attendere...', true);
  try
    sp := TSP_usr_Fill_Tabelle_Tmp.Create(WriteTrans);
    try
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    AfterLogin;

    zSystem.LoadZip;
  finally
    StopWait;
  end;

  ConfirmOk('Impostazioni aggiornate.');
end;

function TConfig.ModificaStatoAttivazioneModulo(const Modulo: string): Boolean;
var
  item: TModulo;
  s: string;
  sp: TSP_usr_Moduli_Add;
begin
  Result := false;

  item := Moduli.GetModulo(Modulo);

  if not Assigned(item) then
    Exit;

  s := item.StatoAttivazione.ToString;

  if not InputCombo(item.Titolo, 'Stato Attivazione', s, nil, nil, true, true,
    procedure(dlg: TInputDialog)
    begin
      dx.InitPickList((dlg.cxCustomEdit as TcxImageComboBox).Properties, 'USR_MODULO_STATO_ATTIVAZIONE');
    end) then
    Exit;

  item.StatoAttivazione := TStatoAttivazione.FromString(s);

  sp := TSP_usr_Moduli_Add.Create(WriteTrans);
  try
    sp.Modulo := item.Modulo;
    sp.Titolo := item.Titolo;
    sp.Stato_Attivazione := item.StatoAttivazione.ToString;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TConfig.DownloadAggiornamento;

  function Desktop: string;
  var
    LStr: array [0 .. MAX_PATH] of Char;
  begin
    SetLastError(ERROR_SUCCESS);
    if SHGetFolderPath(0, CSIDL_DESKTOP, 0, 0, @LStr) = S_OK then
      Result := LStr;
  end;

begin
  // dxSaveFileDialog.InitialDir := TPath.GetDesktopPath; delphi 12
  dxSaveFileDialog.InitialDir := Desktop;
  dxSaveFileDialog.FileName := IncludeTrailingPathDelimiter(dxSaveFileDialog.InitialDir) + 'Aggiornamento_Gesty.zip';

  if dxSaveFileDialog.Execute then
  begin
    StartWait('Attendere...', true);
    try
      ftp.Connect('Aggiornamento');
      try
        ftp.ChangeDir('File_Aggiornamento_Gesty');
        ftp.Download('Aggiornamento_Gesty.zip', dxSaveFileDialog.FileName);
      finally
        ftp.Disconnect;
      end;
    finally
      StopWait;
    end;
  end;
end;

function TConfig.EditMonitorProps: Boolean;
var
  MonitorBy: TFDMonitorBy;
begin
  MonitorBy := Database.Params.MonitorBy;

  if EditFbMonitor(MonitorBy, FDMoniRemoteClientLink, FDMoniFlatFileClientLink, FDMoniCustomClientLink) then
  begin
    Database.Params.MonitorBy := MonitorBy;
    Login;
  end;
end;

// Mantis #183 - 2026-10-08: traccia FireDAC su file per la registrazione per
// l'assistenza. Rispetto a EditMonitorProps: file nella cartella della
// sessione, non in append, e in piu' ekVendor (chiamate al client Firebird) ed
// ekCmdDataIn (righe e tempi dei fetch), che sono i due generi che servono a
// vedere dove passa il tempo fra l'esecuzione e l'arrivo dei record. MonitorBy
// si legge all'apertura della connessione: serve la riconnessione, in
// accensione e in spegnimento. Con Reconnect (chiude le transazioni, chiude e
// riapre la connessione), non con Login, che ripresenta la finestra di accesso:
// nel rilascio 003 era Login e l'utente si ritrovava a riaccedere.
//
// FileName, FileAppend e FileEncoding si cambiano solo a Tracing spento: il
// tracciatore FireDAC (TFDTracer.CheckInactive) solleva un'eccezione se e'
// attivo, ed e' Tracing := False che chiude il file. Lo spegnimento lasciava
// Tracing acceso: l'assegnazione di FileName falliva, il Reconnect non
// partiva e il file -firedac.txt restava aperto, cosi' lo zip della
// registrazione non si creava. Per lo stesso motivo una seconda registrazione
// nella stessa sessione di Gesty non riusciva piu' ad accendere il monitor.
procedure TConfig.MonitorFireDACPerRegistrazione(AAttiva: Boolean; const AFile: string);
begin
  if AAttiva then
  begin
    if FMonitorRegistrazioneAttivo then
      Exit;
    FMonitorByPrecedente := Database.Params.MonitorBy;
    FEventKindsPrecedenti := FDMoniFlatFileClientLink.EventKinds;
    FFileMonitorPrecedente := FDMoniFlatFileClientLink.FileName;
    FAppendMonitorPrecedente := FDMoniFlatFileClientLink.FileAppend;
    FTracingMonitorPrecedente := FDMoniFlatFileClientLink.Tracing;

    FDMoniFlatFileClientLink.Tracing := False;
    FDMoniFlatFileClientLink.FileName := AFile;
    FDMoniFlatFileClientLink.FileAppend := False;
    FDMoniFlatFileClientLink.EventKinds := FEventKindsPrecedenti + [ekVendor, ekCmdDataIn];
    FDMoniFlatFileClientLink.Tracing := True;
    Database.Params.MonitorBy := mbFlatFile;
    FMonitorRegistrazioneAttivo := True;
    Reconnect;
  end
  else
  begin
    if not FMonitorRegistrazioneAttivo then
      Exit;
    FMonitorRegistrazioneAttivo := False;
    Database.Params.MonitorBy := FMonitorByPrecedente;
    // Prima la riconnessione, cosi' la chiusura della connessione resta nella
    // traccia; poi Tracing spento chiude il file, anche se Reconnect fallisce.
    try
      Reconnect;
    finally
      FDMoniFlatFileClientLink.Tracing := False;
      FDMoniFlatFileClientLink.EventKinds := FEventKindsPrecedenti;
      FDMoniFlatFileClientLink.FileName := FFileMonitorPrecedente;
      FDMoniFlatFileClientLink.FileAppend := FAppendMonitorPrecedente;
      FDMoniFlatFileClientLink.Tracing := FTracingMonitorPrecedente;
    end;
  end;
end;

procedure TConfig.FDGUIxAsyncExecuteDialogShow(Sender: TObject);
begin
  inherited;
  frmFDGUIxFormsAsyncExecute.Image2.visible := false;
  frmFDGUIxFormsAsyncExecute.Bevel2.visible := false;
  frmFDGUIxFormsAsyncExecute.Bevel3.visible := false;
  frmFDGUIxFormsAsyncExecute.lblPrompt.Top := 15;
  frmFDGUIxFormsAsyncExecute.lblPrompt.Left := 20;
end;

procedure TConfig.FDMoniCustomClientLinkOutput(ASender: TFDMoniClientLinkBase; const AClassName, AObjName, AMessage: string);
begin
  inherited;
  siMain.LogString('FireDac - [' + AClassName + ']' + ' ' + AObjName, AMessage);
end;

function TConfig.IndexOfAlertWindow(const AAlertWindow: TdxAlertWindow): Integer;
var
  j: Integer;
begin
  Result := -1;
  for j := 0 to ListaNotifiche.Count - 1 do
    if ListaNotifiche[j].AlertWindow = AAlertWindow then
      Exit(j);
end;

procedure TConfig.InitMantis;
var
  sp: TSP_MANTIS_GET_PARAMS;
begin
  TzExceptionManager.MantisServerParams.Init;
  try
    sp := TSP_MANTIS_GET_PARAMS.Create(WriteTrans);
    try
      sp.ExecuteAndCommit;
      TzExceptionManager.MantisServerParams.BaseUrl := sp.Mantis_Url;
      TzExceptionManager.MantisServerParams.ApiToken := sp.Mantis_Token;
      TzExceptionManager.MantisServerParams.DefaultCategory := sp.Mantis_Categoria;
      zExceptions.Utils.SetClientName(sp.DB);
    finally
      FreeAndNil(sp);
    end;
  except
    on E: Exception do
      Application.ShowException(E);
  end;

  // Registro locale dei ticket: si aggancia all'apertura del ticket in
  // zExceptions e alimenta la form "Le mie segnalazioni". Senza Mantis
  // configurato resta spento e la voce di menu non compare.
  FMantisSegnalazioni := nil;
  TzExceptionManager.OnTicketAperto := nil;
  if TzExceptionManager.MantisServerParams.IsValid then
  begin
    FMantisSegnalazioni := TMantisSegnalazioniStoreFirebird.Create(Database, DefaultReadTrans, DefaultWriteTrans, CurrentUserID, CurrentUser);
    TzExceptionManager.OnTicketAperto := RegistraTicketAssistenza;
    AvvisaNovitaTicketAssistenza;
  end;
end;

procedure TConfig.RegistraTicketAssistenza(AIdTicket: Integer; AOggetto: string);
begin
  if Assigned(FMantisSegnalazioni) then
    FMantisSegnalazioni.Registra(AIdTicket, AOggetto);
end;

function TConfig.TicketAssistenzaDisponibile: Boolean;
begin
  Result := Assigned(FMantisSegnalazioni);
end;

procedure TConfig.MostraTicketAssistenza;
begin
  if not TicketAssistenzaDisponibile then
    Exit;
  zMantis.TicketAssistenza.form.MostraTicketAssistenza(TzExceptionManager.MantisServerParams, FMantisSegnalazioni);
end;

procedure TConfig.AvvisaNovitaTicketAssistenza;
var
  Aperti: TArray<TMantisSegnalazioneLocale>;
  Locale: TMantisSegnalazioneLocale;
  Parametri: TMantisServerParams;
  Store: IMantisSegnalazioniStore;
begin
  // Il segnalatore non riceve le mail di Mantis (il reporter del ticket e'
  // l'utente di servizio): l'avviso all'avvio e' il suo unico modo di sapere
  // che l'assistenza ha risposto. Le chiamate REST girano in un thread di
  // sfondo senza toccare il database; l'aggiornamento della copia locale e
  // l'avviso tornano sul thread principale.
  Aperti := [];
  try
    for Locale in FMantisSegnalazioni.Elenco do
      if not Locale.Chiuso then
        Aperti := Aperti + [Locale];
  except
    on E: Exception do
    begin
      // Tabella non ancora installata o non leggibile: nessun avviso.
      siMain.LogException(E);
      Exit;
    end;
  end;

  if Length(Aperti) = 0 then
    Exit;

  Parametri := TzExceptionManager.MantisServerParams;
  Store := FMantisSegnalazioni;

  TTask.Run(
    procedure
    var
      Api: TMantisApi;
      Letti: TArray<TMantisIssue>;
      Indice: Integer;
    begin
      Letti := [];
      Api := TMantisApi.Create(Parametri.BaseUrl, Parametri.ApiToken, Parametri.TimeoutMs);
      try
        for Indice := 0 to High(Aperti) do
          try
            Letti := Letti + [Api.Issue(Aperti[Indice].IdTicket)];
          except
            // un ticket non raggiungibile non ferma gli altri
          end;
      finally
        Api.Free;
      end;

      TThread.Queue(nil,
        procedure
        var
          IndiceLetto: Integer;
          IndiceAperto: Integer;
          Novita: Integer;
        begin
          if Application.Terminated or (Length(Letti) = 0) then
            Exit;

          Novita := 0;
          for IndiceLetto := 0 to High(Letti) do
          begin
            try
              Store.Aggiorna(Letti[IndiceLetto].id, Letti[IndiceLetto].Stato, Letti[IndiceLetto].AssegnatarioVisibile, Letti[IndiceLetto].AggiornatoIl);
            except
              on E: Exception do
                siMain.LogException(E);
            end;
            for IndiceAperto := 0 to High(Aperti) do
              if (Aperti[IndiceAperto].IdTicket = Letti[IndiceLetto].id) and (Letti[IndiceLetto].AggiornatoIl > Aperti[IndiceAperto].UltimoAggiornamentoVisto) then
                inc(Novita);
          end;

          if Novita > 0 then
            dxAlertWindowManager.Show('Richieste di assistenza', Format('Ci sono aggiornamenti su %d richieste di assistenza: apri "Le mie segnalazioni" dal menu.', [Novita]));
        end);
    end);
end;

function TConfig.NotificaGiaMostrata(const AIdNotifica: Integer): Boolean;
var
  j: Integer;
begin
  Result := false;
  for j := 0 to ListaNotifiche.Count - 1 do
    if ListaNotifiche[j].IdNotifica = AIdNotifica then
      Exit(true);
end;

procedure TConfig.SetLoginInfo;
var
  sp: TSP_USR_GET_LOGIN_INFO;
begin
  sp := TSP_USR_GET_LOGIN_INFO.Create(WriteTrans);
  try
    sp.ExecuteAndCommit;

    zExceptions.Utils.SetLoginInfo(sp.Db_Name, sp.User_Name, sp.User_Email);
  finally
    FreeAndNil(sp);
  end;
end;

procedure TConfig.SaveDataSets;
var
  DataSet: TzDataSet;
  sp: TSP_zz_datasets_add;
begin
  Exit;
  // sp := getsp<TSP_zz_datasets_add>;
  // try
  // for DataSet in zSystem.zDataSets do
  // if not DataSet.Name.IsEmpty then
  // if not DataSet.SQL_Select.Text.IsEmpty then
  // begin
  //
  // if DataSet.Name.Contains('.') then
  // begin
  // sp.DATAMODULE := DataSet.Name.Substring(0, DataSet.Name.IndexOf('.'));
  // sp.DataSet := DataSet.Name.Substring(DataSet.Name.IndexOf('.') + 1);
  // end
  // else
  // sp.DataSet := DataSet.Name;
  //
  // sp.SQL_Select.Text := DataSet.SQL_Select.Text;
  // sp.PK_FIELDS := DataSet.PrimaryKeyFields;
  // sp.RELATION_NAME := DataSet.TableName;
  // sp.SEQUENCE_NAME := DataSet.Generator;
  // // sp.MASTER_RELATION := DataSet.masMASTERRELATION;
  // // sp.MASTER_DETAIL_MAPINGS := DataSet.MASTERDETAILMAPINGS;
  // // sp.SQL_COUNT.Text := DataSet.sqSQL_COUNT.Text;
  // sp.SQL_REFRESH_AUTO := DataSet.AutoSQL_Refresh;
  // sp.SQL_Refresh.Text := DataSet.SQL_Refresh.Text;
  // sp.SQL_INSERT_AUTO := DataSet.AutoSQL_Insert;
  // sp.SQL_Insert.Text := DataSet.SQL_Insert.Text;
  // sp.SQL_UPDATE_AUTO := DataSet.AutoSQL_Update;
  // sp.SQL_Update.Text := DataSet.SQL_Update.Text;
  // sp.SQL_DELETE_AUTO := DataSet.AutoSQL_Delete;
  // sp.SQL_Delete.Text := DataSet.SQL_Delete.Text;
  // sp.ExecuteAndCommit;
  // end;
  // finally
  // FreeAndNil(sp);
  // end;
end;

procedure TConfig.Reconnect;
var
  i: Integer;
  procTransaction: TProc<string, TFDTransaction>;
begin

  StartWait('Riconnessione');
  try

    /// //////////////////////////////////////////////////////////////

    procTransaction := Procedure(Name: String; trans: TFDTransaction)
      begin
        siMain.LogString('Chiusura Transazione', name + '.' + trans.Name);

        UpdateWait(name + '.' + trans.Name);

        try
          if trans.Active then
            trans.Commit;
        except
          on E: Exception do
            siMain.LogException(E);
        end;
      end;

    for i := 0 to Screen.DataModuleCount - 1 do
      Screen.DataModules[i].ForEach<TFDTransaction>(
        procedure(trans: TFDTransaction)
        begin
          procTransaction('DM ' + Screen.DataModules[i].Name, trans);
        end);

    for i := 0 to Screen.FormCount - 1 do
      Screen.Forms[i].ForEach<TFDTransaction>(
        procedure(trans: TFDTransaction)
        begin
          procTransaction('Form ' + Screen.Forms[i].Name, trans);
        end);

    /// //////////////////////////////////////////////////////////////

    UpdateWait('Chiusura connessione');
    Database.Connected := false;

    UpdateWait('Apertura connessione');
    Database.Connected := true;

  finally
    StopWait;
  end;
end;

procedure TConfig.dxAlertWindowManagerClose(Sender: TObject; AAlertWindow: TdxAlertWindow);
var
  sp: TSP_NOTIFICHE_LETTA;
  idx: Integer;
  Info: TNotificaInfo;
begin
  inherited;

  if AAlertWindow.tag > 0 then
  begin
    idx := IndexOfAlertWindow(AAlertWindow);
    if idx >= 0 then
    begin
      Info := ListaNotifiche[idx];

      sp := TSP_NOTIFICHE_LETTA.Create(WriteTrans);
      try
        sp.Id_Notifica := Info.IdNotifica;
        sp.ExecuteAndCommit;
      finally
        FreeAndNil(sp);
      end;

      if Info.UserClicked and SameText(Info.TagStr, 'TICKET') and (Info.TagId > 0) then
        HyperLinks.doHyperLink(self, 'TICKET', Info.TagId);

      ListaNotifiche.Delete(idx); // OwnsObjects=true -> libera anche Info

      MostraBadgeNotifiche;
    end;
  end;
end;

procedure TConfig.dxAlertWindowManagerMouseDown(Sender: TObject; AAlertWindow: TdxAlertWindow; AButton: TMouseButton; AShift: TShiftState; X, Y: Integer);
var
  idx: Integer;
begin
  inherited;
  TimerKill.Enabled := false;

  if AAlertWindow.tag = -100 then
  begin
    AAlertWindow.Close;
    Exit;
  end;

  idx := IndexOfAlertWindow(AAlertWindow);
  if idx >= 0 then
  begin
    ListaNotifiche[idx].UserClicked := true;
    AAlertWindow.Close; // forza la chiusura: i pop-up sono Pinned, potrebbero non chiudersi da soli al click
  end;
end;

procedure TConfig.FDEventAlerterAlert(ASender: TFDCustomEventAlerter; const AEventName: string; const AArgument: Variant);
var
  id: Integer;
  DataOra: TDateTime;
  DataSet: TzFbDataSet;
  i: Integer;
  Messaggio: string;
  s: string;
  TagStr: string;
  Titolo: string;
  isShutDown: Boolean;
  isFasciaOraria: Boolean;

  procedure ShowShutdownAlertWindow;
  var
    dxAlertWindow: TdxAlertWindow;
  begin
    dxAlertWindowManager.OptionsAnimate.ShowingAnimation := awaFade;
    try
      if isFasciaOraria then
        dxAlertWindow := dxAlertWindowManager.Show('Fascia oraria di accesso', 'L''accesso non è più consentito in questa fascia oraria: l''applicazione verrà terminata tra 30 secondi.')
      else
        dxAlertWindow := dxAlertWindowManager.Show('Termine applicazione', 'Attenzione: l''applicazione verrà terminata tra 30 secondi.' + sLineBreak + sLineBreak + 'Attendere almeno 20 minuti prima di ricollegarsi.');
    finally
      dxAlertWindowManager.OptionsAnimate.ShowingAnimation := awaSlide;
    end;

    dxAlertWindow.tag := ALERT_TAG_SHUTDOWN;
    dxAlertWindow.OptionsBehavior.DisplayTime := TimerShutdown.Interval;

    dxAlertWindow.OptionsAnimate.HotTrack := false;
    dxAlertWindow.OptionsAnimate.AlphaBlendValue := dxAlertWindow.OptionsAnimate.HotTrackAlphaBlendValue;

    // font
    dxAlertWindow.OptionsMessage.Caption.Font.Color := clWhite;
    dxAlertWindow.OptionsMessage.Caption.Font.Style := [fsBold];
    dxAlertWindow.OptionsMessage.Caption.Font.Size := 12;
    dxAlertWindow.OptionsMessage.Text.Font.Color := clWhite;
    dxAlertWindow.OptionsMessage.Text.Font.Style := [fsBold];
    dxAlertWindow.OptionsMessage.Text.Font.Size := 11;

    // pos
    dxAlertWindow.Left := (Screen.Width - dxAlertWindow.Width) div 2;
    dxAlertWindow.Top := (Screen.Height - dxAlertWindow.Height) div 2;
  end;

begin
  inherited;
  // collection
  // eventi di sistema condivisi tra tutti i client

  if DisabilitaEventiDB then
  begin
    FDisabilitaEventiDB := false;
    Exit;
  end;

  isShutDown := SameText(AEventName, 'SHUTDOWN') or SameText(AEventName, 'SHUTDOWN_' + CurrentUser);
  // Fasce orarie 2026-09-18
  isFasciaOraria := SameText(AEventName, EventoFasciaOraria + CurrentUser);

  if isShutDown or isFasciaOraria then
  begin
    ShowShutdownAlertWindow;

    TimerShutdown.Enabled := false;
    TimerShutdown.Enabled := true;
    Exit;
  end;

  if SameText(AEventName, 'NOTIFICA') then
  begin
    MostraNotifiche;
    MostraBadgeNotifiche;
    Exit;
  end;

  /// ////////////////////

  id := -1;
  DataSet := CreateFbDataSet(nil, Database, DefaultReadTrans, DefaultWriteTrans, true);
  try
    DataSet.FetchOptions.UniDirectional := true;
    DataSet.SelectSQL.Text := 'SELECT * FROM USR_TMP_EVENTS_GET';
    DataSet.Active := true;

    while not DataSet.Eof do
    begin
      id := DataSet.FieldByName('ID_USR_EVENT').AsInteger;
      DataOra := DataSet.FieldByName('DATA_ORA').AsDateTime;
      Titolo := DataSet.FieldByName('TITOLO').AsString;
      Messaggio := DataSet.FieldByName('MESSAGGIO').AsString;
      TagStr := DataSet.FieldByName('TAG_STR').AsString;

      dxAlertWindowManager.Show(Titolo, Messaggio);
      DataSet.Next;
    end;
  finally
    FreeAndNil(DataSet);
  end;

  if id <> -1 then
    Database.ExecSQL('EXECUTE PROCEDURE USR_TMP_EVENTS_CLEAR(' + id.ToString + ')');
end;

procedure TConfig.dxAlertWindowManagerCustomDrawBackground(Sender: TObject; AAlertWindow: TdxAlertWindow; ACanvas: TcxCanvas; AViewInfo: TdxAlertWindowViewInfo; var ADone: Boolean);
var
  R: TRect;
begin

  if AAlertWindow.tag <> ALERT_TAG_SHUTDOWN then
  begin
    ADone := false;
    Exit;
  end;

  R := AViewInfo.Bounds;

  ACanvas.FillRect(R, clRed);
  ACanvas.Pen.Color := clYellow;
  ACanvas.Pen.Width := 3;
  ACanvas.Brush.Style := bsClear;
  ACanvas.Rectangle(R);

  // niente ulteriore disegno di sfondo da parte del manager;
  // testo/icona/bottoni vengono comunque disegnati sopra normalmente
  ADone := true;
end;

end.
