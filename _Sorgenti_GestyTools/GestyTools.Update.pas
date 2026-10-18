unit GestyTools.Update;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Actions,
  System.Zip,
  Vcl.ActnList,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Controls,
  Data.DB,
  zProgressBox;

type
  TUpdateEngine = class(TDataModule)
    ProgressBox: TProgressBox;
  private
    procedure doDeleteFile(const FileName: string);

    procedure ZipProgressEvent(Sender: TObject; FileName: string; Header: TZipHeader; Position: Int64);
    // processi locali e sessioni di rete che tengono aperto un file
    function DescriviUtilizzatori(const FileName: string): string;
    // da chiamare con GestyTools scollegato: True se il file del database si
    // apre in esclusiva, cioe' si puo' copiare e rinominare
    function FileDatabaseLibero(out Utilizzatori: string): boolean;
    // una riga per utente di Gesty collegato (nominativo e computer), dal
    // dataset gia' riletto da EsistonoUtentiCollegati
    function DescriviUtentiCollegati: string;
  public
    procedure Connect;
    procedure Disconnect;
  public
    procedure CartelleCondivise;
    procedure Cron;
    function RinominaExe: boolean;
  public
    // percorso completo dell'eseguibile in produzione
    function ExeFileName: string;
    // True se Gesty.exe esiste ed e' aperto da qualche processo o sessione
    function ExeInUso: boolean;
    // elenco leggibile di processi locali e sessioni di rete che usano l'exe
    function DescriviUtilizzatoriExe: string;
    // forza la chiusura di processi locali e sessioni di rete; True se l'exe si e' liberato
    function ChiudiUtilizzatoriExe: boolean;
  public
    // Utenti di Gesty collegati, altri collegamenti al database e prova di
    // apertura esclusiva del file. True se il file si puo' copiare e
    // rinominare; Rapporto e' il testo da mostrare.
    function VerificaDatabase(out Rapporto: string): boolean;
    function CopiaFisicaDB: boolean;
    procedure BackupBatch;
  public
    function DownloadFileName: string;
    procedure DownloadExe;
    function ApplicaAggiornamento: boolean;
    procedure Gesty;
  end;

var
  UpdateEngine: TUpdateEngine;

implementation

uses
  Winapi.Windows,
  Winapi.ShellAPI,
  System.IniFiles,
  System.IOUtils,
  zWaitFrm,
  FileInUse,
  GestyTools.Log,
  GestyTools.Config,
  GestyTools.FTP,
  GestyTools.Connection,
  zMsg;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TUpdateEngine.Connect;
begin
  Connection.Connect;
  Connection.UtentiAttiviActive := true;
end;

procedure TUpdateEngine.Disconnect;
begin
  Connection.UtentiAttiviActive := false;
  Connection.Disconnect;
end;

procedure TUpdateEngine.CartelleCondivise;
begin
  ShellExecute(Application.Handle, 'open', Pchar('fsmgmt.msc'), '', '', SW_SHOWNORMAL);
end;

procedure TUpdateEngine.Cron;
begin
  ShellExecute(Application.Handle, 'open', Pchar('taskschd.msc'), '', '', SW_SHOWNORMAL);
end;

function TUpdateEngine.ExeFileName: string;
begin
  result := Config.FolderBin + 'Gesty.exe';
end;

function TUpdateEngine.ExeInUso: boolean;
begin
  result := TFile.Exists(ExeFileName) and FileIsLocked(ExeFileName);
end;

function TUpdateEngine.DescriviUtilizzatori(const FileName: string): string;
var
  lockList: TFileLockList;
  lockInfo: TFileLockInfo;
  serverName: string;
begin
  result := '';

  lockList := TFileLockList.Create;
  try
    // processi locali che tengono aperto il file (Restart Manager)
    EnumLocalLockers(FileName, lockList);

    // sessioni sulla condivisione: server remoto se il percorso e' UNC,
    // altrimenti il computer locale (il tool di norma gira sul server)
    serverName := ServerFromUncPath(ExtractFilePath(FileName));
    EnumShareLockers(serverName, ExtractFileName(FileName), lockList);

    for lockInfo in lockList do
      result := result + lockInfo.Descrizione + sLineBreak;
  finally
    FreeAndNil(lockList);
  end;

  if result.IsEmpty then
    result := 'nessun processo individuato (il blocco potrebbe provenire da un altro computer).';
end;

function TUpdateEngine.DescriviUtilizzatoriExe: string;
begin
  result := DescriviUtilizzatori(ExeFileName);
end;

function TUpdateEngine.ChiudiUtilizzatoriExe: boolean;
var
  serverName: string;
begin
  Log.ToFile('ChiudiUtilizzatoriExe');

  // chiude i processi locali tramite Restart Manager
  CloseLocalLockers(ExeFileName);

  // chiude le sessioni aperte sulla condivisione (i client perdono l'handle)
  serverName := ServerFromUncPath(Config.FolderBin);
  CloseShareLockers(serverName, 'Gesty.exe');

  result := not ExeInUso;
end;

function TUpdateEngine.FileDatabaseLibero(out Utilizzatori: string): boolean;
var
  tentativo: Integer;
begin
  Utilizzatori := '';

  // il server Firebird puo' chiudere il file qualche istante dopo l'ultimo
  // scollegamento (o piu' tardi, se il database ha un LINGER): pochi
  // tentativi prima di dichiararlo in uso
  for tentativo := 1 to 3 do
  begin
    if not FileIsLocked(Config.DB) then
      Exit(true);

    Sleep(1000);
  end;

  Utilizzatori := DescriviUtilizzatori(Config.DB);
  result := false;
end;

function TUpdateEngine.DescriviUtentiCollegati: string;
var
  elenco: TStringList;
  nominativo: string;
  computer: string;
  segnalibro: TBookmark;
begin
  elenco := TStringList.Create;
  try
    // il dataset e' quello della griglia della pagina Utenti: si lascia dove
    // era, e senza aggiornare la griglia a ogni riga
    Connection.UtentiAttivi.DisableControls;
    segnalibro := Connection.UtentiAttivi.GetBookmark;
    try
      Connection.UtentiAttivi.First;

      while not Connection.UtentiAttivi.Eof do
      begin
        nominativo := '';
        computer := '';

        if Connection.UtentiAttivi.FindField('NOMINATIVO') <> nil then
          nominativo := Connection.UtentiAttivi.FieldByName('NOMINATIVO').AsString;

        if nominativo.IsEmpty and (Connection.UtentiAttivi.FindField('USER_NAME') <> nil) then
          nominativo := Connection.UtentiAttivi.FieldByName('USER_NAME').AsString;

        if Connection.UtentiAttivi.FindField('COMPUTER_NAME') <> nil then
          computer := Connection.UtentiAttivi.FieldByName('COMPUTER_NAME').AsString;

        elenco.Add(Trim('- ' + nominativo + ' (' + computer + ')'));
        Connection.UtentiAttivi.Next;
      end;

      if Connection.UtentiAttivi.BookmarkValid(segnalibro) then
        Connection.UtentiAttivi.GotoBookmark(segnalibro);
    finally
      Connection.UtentiAttivi.FreeBookmark(segnalibro);
      Connection.UtentiAttivi.EnableControls;
    end;

    result := elenco.Text.TrimRight;
  finally
    FreeAndNil(elenco);
  end;
end;

function TUpdateEngine.VerificaDatabase(out Rapporto: string): boolean;
var
  collegamenti: TStringList;
  utentiGesty: Integer;
  utilizzatori: string;
begin
  result := false;

  Log.ToFile('VerificaDatabase');

  collegamenti := TStringList.Create;
  try
    StartWait('Attendere...', true);
    try
      Connection.UtentiAttiviActive := false;
      Connection.UtentiAttiviActive := true;
      utentiGesty := Connection.UtentiAttivi.RecordCount;

      Connection.AltriCollegamenti(collegamenti);

      // il collegamento di GestyTools tiene aperto il file come gli altri:
      // la prova di apertura esclusiva si fa scollegati
      if TFile.Exists(Config.DB) then
      begin
        Disconnect;
        try
          result := FileDatabaseLibero(utilizzatori);
        finally
          Connect;
        end;
      end;
    finally
      StopWait;
    end;

    if utentiGesty = 0 then
      Rapporto := 'Utenti di Gesty collegati: nessuno.'
    else
      Rapporto := Format('Utenti di Gesty collegati: %d (elenco nella pagina Utenti).', [utentiGesty]);

    if collegamenti.Count = 0 then
      Rapporto := Rapporto + sLineBreak + 'Altri collegamenti al database: nessuno.'
    else
      Rapporto := Rapporto + sLineBreak + 'Collegamenti al database (Gesty compreso):' + sLineBreak + collegamenti.Text.TrimRight;

    Rapporto := Rapporto + sLineBreak + sLineBreak;

    if not TFile.Exists(Config.DB) then
      Rapporto := Rapporto + 'Il file ' + Config.DB + ' non e'' raggiungibile da questo computer: ' +
        'copia e rinomina si possono verificare solo sul server del database.'
    else
      if result then
        Rapporto := Rapporto + 'Il file del database non e'' aperto da nessuno: si puo'' copiare e rinominare.'
      else
        Rapporto := Rapporto + 'Il file del database e'' ancora aperto: non si puo'' copiare ne'' rinominare.' + sLineBreak + 'Lo tiene aperto:' +
          sLineBreak + utilizzatori;
  finally
    FreeAndNil(collegamenti);
  end;
end;

function TUpdateEngine.CopiaFisicaDB: boolean;
var
  collegamenti: TStringList;
  utilizzatori: string;
  utentiCollegati: string;
  libero: boolean;
  dateStr: string;
  SrcFileName: string;
  DstFileName: string;
begin
  result := false;
  libero := false;
  utentiCollegati := '';

  if TFile.Exists(ExeFileName) then
    if not ConfirmOkCancel('Gesty.exe non risulta disabilitato: gli utenti possono ancora avviarlo.' + sLineBreak + 'Continuare comunque?', mtWarning) then
      Exit;

  Log.ToFile('CopiaFisicaDB');

  dateStr := FormatDateTime('yyyymmdd hh nn - ', now);
  SrcFileName := Config.DB;
  DstFileName := Config.FolderBackupDB + dateStr + Config.DBFileName;

  collegamenti := TStringList.Create;
  try
    StartWait('Attendere...', true);
    try
      // letti prima di scollegarsi: servono a spiegare un file ancora aperto
      Connection.AltriCollegamenti(collegamenti);

      // Subito prima della copia l'elenco degli utenti si rilegge dal
      // database: chi si e' collegato dopo l'ultima verifica (pagina Utenti,
      // Verifica DB) non risulterebbe, e la copia partirebbe con Gesty in uso
      if Connection.EsistonoUtentiCollegati then
        utentiCollegati := DescriviUtentiCollegati
      else
      begin
        Disconnect;
        try
          // la copia di un database aperto dal server puo' risultare
          // danneggiata senza che niente lo segnali: si copia solo un file
          // che si apre in esclusiva
          libero := FileDatabaseLibero(utilizzatori);

          if libero then
            TFile.Copy(SrcFileName, DstFileName);
        finally
          Connect;
        end;
      end;
    finally
      StopWait;
    end;

    if utentiCollegati <> '' then
    begin
      ConfirmOk('Copia non eseguita: risultano utenti di Gesty collegati al database.' + sLineBreak + utentiCollegati + sLineBreak +
          'Scollegarli (pagina Utenti, Shutdown) e ripetere la copia.', mtWarning);
      Exit;
    end;

    if not libero then
    begin
      if collegamenti.Count > 0 then
        utilizzatori := utilizzatori + sLineBreak + 'Collegamenti al database:' + sLineBreak + collegamenti.Text.TrimRight;

      ConfirmOk('Copia non eseguita: il file del database e'' ancora aperto, e la copia potrebbe risultare danneggiata.' + sLineBreak +
          'Lo tiene aperto:' + sLineBreak + utilizzatori, mtWarning);
      Exit;
    end;
  finally
    FreeAndNil(collegamenti);
  end;

  result := TFile.Exists(DstFileName);

  // l'esito positivo e' visibile nella lista file (la pagina passa alla cartella backup)
  if not result then
    ConfirmOk('Impossibile effettuare una copia fisica del database.', mtError);
end;

procedure TUpdateEngine.BackupBatch;
begin

  if not Config.FileNameBat.IsEmpty then
  begin
    Log.ToFile('Backup');

    ShellExecute(Application.Handle, 'open', Pchar(Config.FileNameBat), '', '', SW_SHOWNORMAL);
  end;
end;

function TUpdateEngine.DownloadFileName: string;
begin
  result := Config.FolderUpdate + 'GestyExe.zip';
end;

procedure TUpdateEngine.doDeleteFile(const FileName: string);
begin

  if TFile.Exists(FileName) then
    TFile.Delete(FileName);
end;

procedure TUpdateEngine.DownloadExe;
var
  remoteName: string;
  remoteFileName: string;
begin
  Log.ToFile('DownloadAggiornamento');

  // percorso remoto dell'archivio di aggiornamento dalla configurazione
  remoteName := Config.Remote_UpdateZip;
  if remoteName.IsEmpty then
    remoteName := 'File_Aggiornamento_Gesty/Aggiornamento_Gesty.zip';

  // elimina residui di download e decompressioni precedenti
  doDeleteFile(Config.FolderUpdate + 'Gesty.exe');
  doDeleteFile(Config.FolderUpdate + 'Gesty.lz');
  doDeleteFile(Config.FolderUpdate + 'Gesty.skinres');
  doDeleteFile(DownloadFileName);

  // connessione e posizionamento nella cartella remota PRIMA della ProgressBox:
  // la form di attesa della connessione non deve sovrapporsi al progresso.
  // ChangeDirForFile scarica poi il solo nome file: RETR/SIZE con il percorso
  // nel comando su molti server danno "permission denied"
  try
    remoteFileName := FTP.ChangeDirForFile(remoteName);
  except
    FTP.Disconnect;
    raise;
  end;

  ProgressBox.Show(100, 'Aggiornamento Exe', 'Download di ' + remoteName, 'Attendere...');
  try
    try
      FTP.Download(remoteFileName, DownloadFileName,
        procedure(const Position, Size: Int64)
        begin

          if Size > 0 then
          begin
            ProgressBox.Progress := Round(Position / Size * 100);
            ProgressBox.SecondLabel := FormatFloat('#,##0 KB', Position / 1024) + ' di ' + FormatFloat('#,##0 KB', Size / 1024);
          end
          else
            ProgressBox.SecondLabel := FormatFloat('#,##0 KB', Position / 1024);

          Application.ProcessMessages;

          if ProgressBox.Cancelled then
            Abort;
        end);
    except
      on EAbort do
      begin
        // annullato dall'utente: si elimina il file parziale, senza ulteriori avvisi
        doDeleteFile(DownloadFileName);
        Exit;
      end;
    end;
  finally
    // la disconnessione annulla anche il ChangeDir nella sottocartella
    FTP.Disconnect;
    ProgressBox.Close;
  end;

  // l'esito positivo e' visibile nella lista file della pagina
  if not TFile.Exists(DownloadFileName) then
    ConfirmOk('Download non riuscito.', mtError);
end;

function TUpdateEngine.ApplicaAggiornamento: boolean;

// decomprime l'archivio scaricato direttamente nella cartella di Gesty
  procedure EstraiArchivio;
  var
    Zip: TZipFile;
    entryName: string;
    DstFileName: string;
  begin
    Zip := TZipFile.Create;
    try
      Zip.Open(DownloadFileName, zmRead);

      ProgressBox.Show(Length(Zip.FileNames), 'Aggiornamento Exe', 'Estrazione in ' + Config.FolderBin);
      try
        for entryName in Zip.FileNames do
        begin
          ProgressBox.IncProgress(entryName);

          // elimina il file precedente ed estrae nella cartella di Gesty
          DstFileName := Config.FolderBin + entryName.Replace('/', '\');
          doDeleteFile(DstFileName);
          Zip.Extract(entryName, Config.FolderBin);

          if ProgressBox.Cancelled then
            Break;
        end;
      finally
        ProgressBox.Close;
      end;
    finally
      FreeAndNil(Zip);
    end;
  end;

// compatibilita': file gia' decompressi manualmente nella cartella aggiornamenti
  procedure SpostaFilePreDecompressi;

    procedure Update(const ext: string);
    var
      SrcFileName: string;
      DstFileName: string;
    begin
      SrcFileName := Config.FolderUpdate + 'Gesty.' + ext;
      DstFileName := Config.FolderBin + 'Gesty.' + ext;

      doDeleteFile(DstFileName);
      TFile.Move(SrcFileName, DstFileName);
    end;

  begin
    StartWait('Attendere...', true);
    try
      Update('exe');
      Update('lz');
      Update('skinres');
    finally
      StopWait;
    end;
  end;

begin
  result := false;

  Log.ToFile('ApplicaAggiornamento');

  if TFile.Exists(DownloadFileName) then
    EstraiArchivio
  else
    if TFile.Exists(Config.FolderUpdate + 'Gesty.exe') then
      SpostaFilePreDecompressi
    else
    begin
      ConfirmOk('Nessun aggiornamento trovato in ' + Config.FolderUpdate + sLineBreak + 'Eseguire prima il download.');
      Exit;
    end;

  result := TFile.Exists(Config.FolderBin + 'Gesty.exe');

  if result then
  begin
    // archivio applicato: puo' essere eliminato; l'esito e' visibile nella
    // lista file, che passa alla cartella di Gesty
    doDeleteFile(DownloadFileName);
  end
  else
    ConfirmOk('Impossibile aggiornare Gesty.exe.', mtError)
end;

procedure TUpdateEngine.ZipProgressEvent(Sender: TObject; FileName: string; Header: TZipHeader; Position: Int64);
begin
  Application.ProcessMessages;

  // ProgressBox.SecondLabel := 'Write: ' + AWorkCount.ToString;

  if ProgressBox.Cancelled then
    Abort;
end;

procedure TUpdateEngine.Gesty;
begin
  ShellExecute(Application.Handle, 'open', Pchar(Config.FolderBin + 'Gesty.exe'), '', '', SW_SHOWNORMAL);
end;

function TUpdateEngine.RinominaExe: boolean;
var
  dateStr: string;
  Zip: TZipFile;
  FileName: string;
  ZipFileName: string;
  utilizzatori: string;
begin
  result := false;

  Log.ToFile('RinominaExe');

  dateStr := FormatDateTime('yyyymmdd hh nn - ', now);

  FileName := ExeFileName;
  ZipFileName := Config.FolderBackupExe + dateStr + 'Gesty.zip';

  StartWait('Attendere...', true);
  try

    Zip := TZipFile.Create;
    try
      Zip.OnProgress := ZipProgressEvent;
      Zip.Open(ZipFileName, zmWrite);

      Zip.Add(FileName, ExtractFileName(FileName), zcDeflate);
      Zip.Add(ChangeFileExt(FileName, '.lz'), ChangeFileExt(ExtractFileName(FileName), '.lz'), zcDeflate);
    finally
      FreeAndNil(Zip);
    end;
  finally
    StopWait;
  end;

  // se l'exe risulta in uso individua chi lo blocca e propone la chiusura forzata
  if ExeInUso then
  begin
    utilizzatori := DescriviUtilizzatoriExe;

    if not ConfirmOkCancel('Gesty.exe risulta in uso da:' + sLineBreak + utilizzatori + sLineBreak + 'Forzare la chiusura e continuare?', mtWarning) then
      Exit;

    StartWait('Attendere...', true);
    try
      ChiudiUtilizzatoriExe;
    finally
      StopWait;
    end;

    if ExeInUso then
    begin
      ConfirmOk('Gesty.exe risulta ancora in uso:' + sLineBreak + DescriviUtilizzatoriExe);
      Exit;
    end;
  end;

  try

    StartWait('Attendere...', true);
    try
      TFile.Delete(ExeFileName);
    finally
      StopWait;
    end;
    // l'esito positivo e' visibile nella lista file (l'exe sparisce dalla cartella bin)
    result := true;
  except
    ConfirmOk('Impossibile rinominare Gesty.exe.', mtError);
  end;
end;

end.
