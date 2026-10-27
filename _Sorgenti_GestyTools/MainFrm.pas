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
  GestyTools.Sql.Esecutore,
  GestyTools.Sql.Pagina,
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
    dxBarButton12: TdxBarButton;
    dxSkinController: TdxSkinController;
    dxBarButton15: TdxBarButton;
    Cron: TAction;
    Script: TAction;
    dxBarButton16: TdxBarButton;
    UtentiAttiviSrc: TDataSource;
    FrameEditor_Sql: TFrameEditor_Sql;
    VerificaUsoExe: TAction;
    ChiudiProcessiExe: TAction;
    dxBarButton17: TdxBarButton;
    dxBarButton18: TdxBarButton;
    dxBarButton19: TdxBarButton;
    ExplorerDrop: TExplorerDrop;
    dxBarSubItemAltriStrumenti: TdxBarSubItem;
    VerificaDB: TAction;
    dxBarButtonVerificaDB: TdxBarButton;
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
    procedure ExplorerDropDropped(Sender: TObject; Files: TStrings; FileCount, x, y: Integer);
    procedure FormShow(Sender: TObject);
    procedure GestyExecute(Sender: TObject);
    procedure RinominaExeExecute(Sender: TObject);
    procedure ScriptExecute(Sender: TObject);
    procedure ShutdownExecute(Sender: TObject);
    procedure WizardButtonClick(Sender: TObject; AKind: TdxWizardControlButtonKind; var AHandled: Boolean);
    procedure WizardPageChanged(Sender: TObject);
    procedure WizardTdxWizardControlButtonsTdxWizardControlCustomButtonsButtons0Click(Sender: TObject);
    procedure VerificaUsoExeExecute(Sender: TObject);
    procedure ChiudiProcessiExeExecute(Sender: TObject);
    procedure VerificaDBExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    // motore di esecuzione degli script, con le regole di zFbScript
    Esecutore: TEsecutore;
    // interfaccia della pagina Aggiornamento DB (barra comandi, opzioni,
    // messaggi e risultati), costruita da codice
    PaginaSql: TPaginaSql;
    // "Blocca avvio": un solo pulsante collegato alle barre delle pagine, piu'
    // quello della barra della pagina Aggiornamento DB, che ha un gestore
    // di barre suo. Lo stato premuto e' l'esistenza del file Gesty.blocco
    PulsanteBlocco: TdxBarButton;
    PulsanteBloccoSql: TdxBarLargeButton;
    AggiornamentoPulsantiBlocco: Boolean;
    procedure CaricaScriptAggiornamento;
    function ConfermaPassaggioPagina: Boolean;
    procedure CreaPulsantiBlocco;
    procedure PulsanteBloccoClick(Sender: TObject);
    procedure AggiornaPulsantiBlocco;
    // Lo shutdown scollega gli utenti; il blocco impedisce che rientrino
    // mentre si aggiorna. Restituisce il testo da accodare al messaggio
    function BloccaDopoShutdown: string;
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
  GestyTools.Sql.Icone,
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

  // la pagina prima di tutto, a controlli ancora vivi: i suoi fogli di
  // risultati sono figli di controlli che la form sta per distruggere. Poi
  // l'esecutore, prima del DataModule Connection che possiede la connessione
  FreeAndNil(PaginaSql);
  FreeAndNil(Esecutore);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // chiudere con uno script a meta' lascerebbe una transazione aperta e
  // distruggerebbe le griglie su cui l'esecuzione sta scrivendo
  if Assigned(PaginaSql) and PaginaSql.InEsecuzione then
  begin
    ConfirmOk('Uno script e'' in esecuzione: interromperlo prima di chiudere.', mtWarning);
    CanClose := False;
    Exit;
  end;

  // un blocco dimenticato lascia tutti fuori da Gesty finche' qualcuno non
  // riapre GestyTools o cancella il file a mano
  if Assigned(UpdateEngine) and UpdateEngine.BloccoAttivo then
  begin
    case ConfirmYesNoCancel('L''avvio di Gesty e'' ancora bloccato: finche'' il blocco resta, nessuno puo'' aprirlo.' + sLineBreak +
      'Togliere il blocco prima di uscire?', mtWarning) of
      mrYes:
        CanClose := UpdateEngine.DisattivaBlocco;
      mrNo:
        CanClose := True;
    else
      CanClose := False;
    end;

    AggiornaPulsantiBlocco;
  end;
end;

procedure TMainForm.CreaPulsantiBlocco;
const
  Didascalia = 'Blocca avvio';
  Suggerimento = 'Premuto: Gesty non si apre (file Gesty.blocco accanto a Gesty.exe). Rialzato: Gesty si apre di nuovo';

  procedure Collega(Barra: TdxBar);
  var
    Collegamento: TdxBarItemLink;
  begin
    Collegamento := Barra.ItemLinks.Add;
    Collegamento.Item := PulsanteBlocco;
    Collegamento.BeginGroup := True;
    Collegamento.UserDefine := [udPaintStyle];
    Collegamento.UserPaintStyle := psCaptionGlyph;
  end;

begin
  // un item solo con un collegamento per barra: lo stato premuto e' dell'item,
  // quindi le pagine lo vedono uguale senza doverle allineare
  PulsanteBlocco := TdxBarButton(dxBarManager.AddItem(TdxBarButton));
  PulsanteBlocco.ButtonStyle := bsChecked;
  PulsanteBlocco.Caption := Didascalia;
  PulsanteBlocco.Hint := Suggerimento;
  CaricaIconaBlocco(PulsanteBlocco.Glyph, PulsanteBlocco.LargeGlyph);
  PulsanteBlocco.OnClick := PulsanteBloccoClick;

  Collega(barUtenti);
  Collega(barRinominaExe);
  Collega(barBackup);
  Collega(barAggiornamento);

  PulsanteBloccoSql := PaginaSql.NuovoPulsante;
  PulsanteBloccoSql.ButtonStyle := bsChecked;
  PulsanteBloccoSql.Caption := Didascalia;
  PulsanteBloccoSql.Hint := Suggerimento;
  CaricaIconaBlocco(PulsanteBloccoSql.Glyph, PulsanteBloccoSql.LargeGlyph);
  PulsanteBloccoSql.OnClick := PulsanteBloccoClick;
end;

procedure TMainForm.PulsanteBloccoClick(Sender: TObject);
begin
  // il clic ha gia' cambiato lo stato del pulsante, ma fa fede il file: se
  // scriverlo o cancellarlo non riesce, AggiornaPulsantiBlocco riporta il
  // pulsante com'era
  if AggiornamentoPulsantiBlocco then
    Exit;

  if UpdateEngine.BloccoAttivo then
    UpdateEngine.DisattivaBlocco
  else
    UpdateEngine.AttivaBlocco;

  AggiornaPulsantiBlocco;
end;

procedure TMainForm.AggiornaPulsantiBlocco;
var
  Attivo: Boolean;
begin
  if not Assigned(PulsanteBlocco) or not Assigned(UpdateEngine) then
    Exit;

  Attivo := UpdateEngine.BloccoAttivo;

  // cambiare Down da codice non deve rientrare in PulsanteBloccoClick
  AggiornamentoPulsantiBlocco := True;
  try
    PulsanteBlocco.Down := Attivo;
    PulsanteBloccoSql.Down := Attivo;
  finally
    AggiornamentoPulsantiBlocco := False;
  end;
end;

function TMainForm.BloccaDopoShutdown: string;
begin
  if UpdateEngine.BloccoAttivo or UpdateEngine.AttivaBlocco then
    Result := sLineBreak + 'L''avvio di Gesty e'' bloccato: per riaprirlo rialzare il pulsante "Blocca avvio".'
  else
    Result := sLineBreak + 'Attenzione: l''avvio di Gesty NON e'' bloccato, gli utenti possono ricollegarsi.';

  AggiornaPulsantiBlocco;
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

  OnCloseQuery := FormCloseQuery;

  // stessa connessione del resto di GestyTools, con una transazione propria
  Esecutore := TEsecutore.Create(Connection.FDConnection);

  // barra comandi, opzioni, messaggi e risultati della pagina Aggiornamento
  // DB; l'editor e' il frame gia' presente nella pagina
  PaginaSql := TPaginaSql.Create(Self, pageAggiornamentoDB, FrameEditor_Sql, Esecutore);

  // lo stato lo legge FormShow: UpdateEngine e la configurazione nascono
  // dopo la form
  CreaPulsantiBlocco;

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

  // un blocco rimasto da una sessione precedente si vede subito premuto
  AggiornaPulsantiBlocco;
end;

procedure TMainForm.WizardButtonClick(Sender: TObject; AKind: TdxWizardControlButtonKind; var AHandled: Boolean);
begin
  // durante uno script l'esecuzione cede il passo alla form fra
  // un'istruzione e l'altra: un clic su Avanti, Indietro o Annulla
  // cambierebbe pagina o chiuderebbe la form a meta' transazione
  if Assigned(PaginaSql) and PaginaSql.InEsecuzione then
  begin
    AHandled := True;
    ConfirmOk('Uno script e'' in esecuzione: interromperlo prima di proseguire.', mtWarning);
    Exit;
  end;

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

        ConfirmOk('Shutdown in corso: attendere che gli utenti si scolleghino, poi aggiornare l''elenco.' + BloccaDopoShutdown);
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
        // chi e' collegato durante lo script di aggiornamento puo' bloccarlo
        // (oggetti in uso) o lavorare su una struttura che sta cambiando
        if Connection.EsistonoUtentiCollegati then
          Exit(ConfirmYesNo('Risultano utenti di Gesty collegati al database: potrebbero bloccare lo script di aggiornamento.' + sLineBreak +
              'Continuare comunque?', mtWarning));
      end;
end;

procedure TMainForm.WizardPageChanged(Sender: TObject);
begin
  Wizard.Buttons.Cancel.Enabled := Wizard.ActivePageIndex < Wizard.PageCount - 1;

  // il file puo' essere stato creato o cancellato da fuori
  AggiornaPulsantiBlocco;

  // all'ingresso nella pagina Aggiornamento DB carica lo script piu' recente
  if Wizard.ActivePage = pageAggiornamentoDB then
  begin
    PaginaSql.CartellaPredefinita := Config.FolderUpdate;
    if Config.Server <> '' then
      PaginaSql.Database := Config.Server + ':' + Config.DB
    else
      PaginaSql.Database := Config.DB;
    CaricaScriptAggiornamento;
  end;
end;

procedure TMainForm.CaricaScriptAggiornamento;
var
  scriptFiles: TStringDynArray;
  fileName: string;
  newestFileName: string;
begin

  if not PaginaSql.Vuota then
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

  PaginaSql.Carica(newestFileName, False);
end;

procedure TMainForm.VerificaDBExecute(Sender: TObject);
var
  rapporto: string;
begin

  if UpdateEngine.VerificaDatabase(rapporto) then
    ConfirmOk(rapporto)
  else
    ConfirmOk(rapporto, mtWarning);

  // l'elenco della pagina Utenti e' stato riletto dalla verifica
  gridUtentiAttiviDBTableView.ApplyBestFit();
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

    ConfirmOk('Shutdown in corso.' + BloccaDopoShutdown);
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
  UpdateEngine.Gesty;
end;

procedure TMainForm.ExplorerDropDropped(Sender: TObject; Files: TStrings; FileCount, x, y: Integer);
begin

  if Files.count > 0 then
    PaginaSql.Carica(Files[0], True);
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
      begin
        Connection.LoadConfig;
        // la cartella di Gesty puo' essere cambiata
        AggiornaPulsantiBlocco;
      end;
end;

end.
