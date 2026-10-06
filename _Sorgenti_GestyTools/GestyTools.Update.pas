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
    FDatabaseInShutdown: boolean;
    procedure doDeleteFile(const FileName: string);
    procedure doZip(const FileName, ZipFileName: string);
    procedure doUnzip(const FileName: string; const OutupFolder: string);

    procedure ZipProgressEvent(Sender: TObject; FileName: string; Header: TZipHeader; Position: Int64);
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
    // shutdown del database Firebird: impedisce nuove connessioni (solo SYSDBA/owner)
    procedure ShutdownDatabase;
    // riporta il database online
    procedure OnlineDatabase;
    property DatabaseInShutdown: boolean read FDatabaseInShutdown;
  public
    function CopiaFisicaDB: boolean;
    procedure BackupBatch;

    procedure UploadDB; { TODO : GDrive }
    procedure DownloadDB; { TODO : GDrive }
  public
    function DownloadFileName: string;
    procedure DownloadExe;
    function ApplicaAggiornamento: boolean;
    procedure Gesty;
    procedure IbExpert;
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

function TUpdateEngine.DescriviUtilizzatoriExe: string;
var
  lockList: TFileLockList;
  lockInfo: TFileLockInfo;
  serverName: string;
begin
  result := '';

  lockList := TFileLockList.Create;
  try
    // processi locali che tengono aperto il file (Restart Manager)
    EnumLocalLockers(ExeFileName, lockList);

    // sessioni sulla condivisione: server remoto se il percorso e' UNC,
    // altrimenti il computer locale (il tool di norma gira sul server)
    serverName := ServerFromUncPath(Config.FolderBin);
    EnumShareLockers(serverName, 'Gesty.exe', lockList);

    for lockInfo in lockList do
      result := result + lockInfo.Descrizione + sLineBreak;
  finally
    FreeAndNil(lockList);
  end;

  if result.IsEmpty then
    result := 'nessun processo individuato (il blocco potrebbe provenire da un altro computer).';
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

procedure TUpdateEngine.ShutdownDatabase;
begin
  Log.ToFile('ShutdownDatabase');

  StartWait('Attendere...', true);
  try
    Disconnect;
    Connection.DatabaseShutdown(0);
    // in shutdown solo SYSDBA/owner possono collegarsi: la connessione del tool resta valida
    Connect;
  finally
    StopWait;
  end;

  FDatabaseInShutdown := true;
end;

procedure TUpdateEngine.OnlineDatabase;
begin
  Log.ToFile('OnlineDatabase');

  StartWait('Attendere...', true);
  try
    Disconnect;
    Connection.DatabaseOnline;
    Connect;
  finally
    StopWait;
  end;

  FDatabaseInShutdown := false;
end;

function TUpdateEngine.CopiaFisicaDB: boolean;
var
  avvisi: string;
  dateStr: string;
  SrcFileName: string;
  DstFileName: string;
begin
  result := false;

  // eventuali anomalie raggruppate in un'unica conferma
  avvisi := '';

  if Connection.EsistonoUtentiCollegati then
    avvisi := avvisi + '- risultano utenti collegati al database' + sLineBreak;

  if TFile.Exists(ExeFileName) then
    avvisi := avvisi + '- Gesty.exe non risulta disabilitato' + sLineBreak;

  if not avvisi.IsEmpty then
    if not ConfirmOkCancel('Attenzione:' + sLineBreak + avvisi + 'Continuare comunque?', mtWarning) then
      Exit;

  // shutdown del database per impedire nuove connessioni durante la copia
  // e per tutta la durata dell'aggiornamento
  if not FDatabaseInShutdown then
    if ConfirmOkCancel('Portare il database in shutdown per impedire ulteriori collegamenti?' + #13#10 + 'Solo SYSDBA potra'' collegarsi fino alla riattivazione.') then
      ShutdownDatabase;

  /// /////////////////////////////

  Log.ToFile('CopiaFisicaDB');

  StartWait('Attendere...', true);
  try
    Disconnect;
    try
      dateStr := FormatDateTime('yyyymmdd hh nn - ', now);

      SrcFileName := Config.DB;
      DstFileName := Config.FolderBackupDB + dateStr + Config.DBFileName;

      TFile.Copy(SrcFileName, DstFileName);
    finally
      Connect;
    end;
  finally
    StopWait;
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

procedure TUpdateEngine.doZip(const FileName, ZipFileName: string);
var
  Zip: TZipFile;
begin
  Zip := TZipFile.Create;
  try
    Zip.OnProgress := ZipProgressEvent;
    Zip.Open(ZipFileName, zmWrite);

    Zip.Add(FileName, ExtractFileName(FileName), zcDeflate);
  finally
    FreeAndNil(Zip);
  end;
end;

procedure TUpdateEngine.doUnzip(const FileName, OutupFolder: string);
var
  Zip: TZipFile;
begin
  Zip := TZipFile.Create;
  try
    Zip.OnProgress := ZipProgressEvent;
    Zip.Open(FileName, zmRead);

    Zip.ExtractAll(OutupFolder);
  finally
    FreeAndNil(Zip);
  end;
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

procedure TUpdateEngine.UploadDB;
var
  fbk, fdb, Zip: string;

  procedure DeleteTempFiles;
  begin
    doDeleteFile(fbk);
    doDeleteFile(fdb);
    doDeleteFile(Zip);
  end;

  procedure Backup;
  begin
    Disconnect;
    try
      Connection.Backup(fbk);
    finally
      Connect;
    end;
  end;

  procedure Restore;
  begin
    Disconnect;
    try
      Connection.Restore(fbk, fdb);
    finally
      Connect;
    end;
  end;

  procedure Compress;
  begin
    doZip(fdb, Zip);
  end;

  procedure ConnettiFtp;
  var
    remoteFolder: string;
  begin
    FTP.Connect;

    // cartella remota dei backup (se configurata), relativa alla cartella ftp di default
    remoteFolder := Config.Remote_BackupFolder.Replace('\', '/').Trim(['/']);
    if not remoteFolder.IsEmpty then
      FTP.ChangeDir(remoteFolder);
  end;

  procedure Upload;
  begin
    FTP.Upload(Zip, ExtractFileName(Zip),
      procedure(const Position, Size: Int64)
      begin

        if Size > 0 then
          ProgressBox.SecondLabel := FormatFloat('#,##0 KB', Position / 1024) + ' di ' + FormatFloat('#,##0 KB', Size / 1024)
        else
          ProgressBox.SecondLabel := FormatFloat('#,##0 KB', Position / 1024);

        Application.ProcessMessages;

        if ProgressBox.Cancelled then
          Abort;
      end);
  end;

begin
  Log.ToFile('UploadDB');

  fbk := Config.FolderUpdate + ChangeFileExt(Config.DBFileName, '.fbk');
  fdb := Config.FolderUpdate + ChangeFileExt(Config.DBFileName, '.fdb');
  Zip := Config.FolderUpdate + FormatDateTime('yyyymmdd hh nn - ', now) + ChangeFileExt(Config.DBFileName, '.zip');

  // connessione PRIMA della ProgressBox: la form di attesa non deve
  // sovrapporsi al progresso; la connessione resta aperta durante
  // backup/restore/compressione (occhio ai timeout di inattivita' del server
  // con database molto grandi)
  try
    ConnettiFtp;
  except
    FTP.Disconnect;
    raise;
  end;

  ProgressBox.Show(5, 'Upload DB', 'Upload', 'Attendere...');
  try
    DeleteTempFiles;
    ProgressBox.IncProgress('Backup');
    Backup;

    ProgressBox.IncProgress('Restore');
    Restore;

    ProgressBox.IncProgress('Compressione');
    Compress;

    ProgressBox.IncProgress('Upload');
    Upload;

    // DeleteTempFiles;
  finally
    FTP.Disconnect;
    ProgressBox.Close;
  end;
end;

procedure TUpdateEngine.DownloadDB;
var
  Remote: string;
  Zip: string;
  RemoteBackupName: string;

  procedure DeleteTempFiles;
  begin
    doDeleteFile(Zip);
  end;

  procedure Unzip;
  begin
    doUnzip(Zip, Config.FolderUpdate);
  end;

// backup piu' recente nella cartella remota: il prefisso data yyyymmdd
// rende l'ordine alfabetico uguale a quello cronologico
  function CercaBackupPiuRecente: string;
  var
    remoteFolder: string;
    remoteFiles: TStringList;
    FileName: string;
  begin
    result := '';

    FTP.Connect;

    remoteFolder := Config.Remote_BackupFolder.Replace('\', '/').Trim(['/']);
    if not remoteFolder.IsEmpty then
      FTP.ChangeDir(remoteFolder);

    remoteFiles := TStringList.Create;
    try
      FTP.ListFiles(remoteFiles);

      for FileName in remoteFiles do
        if FileName.ToLower.EndsWith(Remote.ToLower) then
          if result.IsEmpty or (CompareText(FileName, result) > 0) then
            result := FileName;
    finally
      FreeAndNil(remoteFiles);
    end;
  end;

  procedure Download;
  begin
    FTP.Download(RemoteBackupName, Zip,
      procedure(const Position, Size: Int64)
      begin

        if Size > 0 then
        begin
          ProgressBox.SecondLabel := FormatFloat('#,##0 KB', Position / 1024) + ' di ' + FormatFloat('#,##0 KB', Size / 1024);
        end
        else
          ProgressBox.SecondLabel := FormatFloat('#,##0 KB', Position / 1024);

        Application.ProcessMessages;

        if ProgressBox.Cancelled then
          Abort;
      end);
  end;

begin
  Log.ToFile('DownloadDB');

  Remote := ChangeFileExt(Config.DBFileName, '.zip');
  Zip := Config.FolderUpdate + FormatDateTime('yyyymmdd hh nn - ', now) + ChangeFileExt(Config.DBFileName, '.zip');

  // connessione e ricerca del backup PRIMA della ProgressBox: la form di
  // attesa della connessione non deve sovrapporsi al progresso
  try
    RemoteBackupName := CercaBackupPiuRecente;
  except
    FTP.Disconnect;
    raise;
  end;

  if RemoteBackupName.IsEmpty then
  begin
    FTP.Disconnect;
    ConfirmOk('Nessun backup "' + Remote + '" trovato sull''ftp in "' + Config.Remote_BackupFolder + '".', mtWarning);
    Exit;
  end;

  ProgressBox.Show(2, 'Download DB', 'Download', 'Attendere...');
  try
    DeleteTempFiles;

    ProgressBox.IncProgress('Download');
    try
      Download;
    except
      on EAbort do
      begin
        // annullato dall'utente: si elimina il file parziale, senza ulteriori avvisi
        DeleteTempFiles;
        Exit;
      end;
    end;

    ProgressBox.IncProgress('Decompressione');
    Unzip;

    DeleteTempFiles;

    ConfirmOk('Scaricato e decompresso ' + RemoteBackupName + ' in ' + Config.FolderUpdate);
  finally
    FTP.Disconnect;
    ProgressBox.Close;
  end;
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

procedure TUpdateEngine.IbExpert;
begin
  ShellExecute(Application.Handle, 'open', Pchar('IbExpert.exe'), '', '', SW_SHOWNORMAL);
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
