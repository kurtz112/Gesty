unit FileInUse;

// Individuazione e chiusura degli utilizzatori di un file:
//  - processi LOCALI che tengono aperto il file (API Restart Manager)
//  - sessioni di RETE che tengono aperto il file su una condivisione SMB
//    (API NetFileEnum / NetFileClose: da eseguire sul server della condivisione
//     oppure con credenziali amministrative verso il server)
//
// Unit autonoma: le API sono dichiarate direttamente qui per non dipendere
// dalla presenza di Winapi.RestartManager nelle varie versioni di Delphi.

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  System.Generics.Collections;

type
  // origine del blocco sul file
  TFileLockOrigin = (loProcessoLocale, loSessioneCondivisione);

  TFileLockInfo = record
    Origin: TFileLockOrigin;
    // pid del processo locale oppure id della sessione di rete
    LockId: Cardinal;
    // nome applicazione (locale) oppure percorso aperto (condivisione)
    ApplicationName: string;
    // utente della sessione di rete; vuoto per i processi locali
    UserName: string;
    function Descrizione: string;
  end;

  TFileLockList = TList<TFileLockInfo>;

// True se il file esiste e l'apertura esclusiva fallisce (file in uso)
function FileIsLocked(const FileName: string): Boolean;

// Aggiunge alla lista i processi locali che tengono aperto il file.
// Restituisce il numero di processi individuati.
function EnumLocalLockers(const FileName: string; LockList: TFileLockList): Integer;

// Chiude (forzatamente) i processi locali che tengono aperto il file.
// True se la chiamata a RmShutdown e' andata a buon fine.
function CloseLocalLockers(const FileName: string): Boolean;

// Aggiunge alla lista le sessioni di rete che tengono aperto FileName
// (confronto sul solo nome file) sulle condivisioni di ServerName.
// ServerName vuoto = computer locale. Restituisce il numero di sessioni.
function EnumShareLockers(const ServerName, FileName: string; LockList: TFileLockList): Integer;

// Forza la chiusura delle sessioni di rete sul file. Restituisce quante ne ha chiuse.
// ATTENZIONE: il client remoto perde l'handle senza preavviso.
function CloseShareLockers(const ServerName, FileName: string): Integer;

// Estrae il nome server da un percorso UNC (\\server\condivisione\... -> server).
// Restituisce stringa vuota se il percorso non e' UNC.
function ServerFromUncPath(const Path: string): string;

implementation

// ---------------------------------------------------------------------------
// Restart Manager (rstrtmgr.dll)
// ---------------------------------------------------------------------------

const
  RestartManagerDll = 'rstrtmgr.dll';

  CCH_RM_SESSION_KEY = 32;
  CCH_RM_MAX_APP_NAME = 255;
  CCH_RM_MAX_SVC_NAME = 63;

  RmForceShutdownFlag = $00000001;

type
  RM_UNIQUE_PROCESS = record
    dwProcessId: DWORD;
    ProcessStartTime: TFileTime;
  end;
  PRM_UNIQUE_PROCESS = ^RM_UNIQUE_PROCESS;

  RM_PROCESS_INFO = record
    Process: RM_UNIQUE_PROCESS;
    strAppName: array [0 .. CCH_RM_MAX_APP_NAME] of WideChar;
    strServiceShortName: array [0 .. CCH_RM_MAX_SVC_NAME] of WideChar;
    ApplicationType: DWORD;
    AppStatus: ULONG;
    TSSessionId: DWORD;
    bRestartable: BOOL;
  end;
  PRM_PROCESS_INFO = ^RM_PROCESS_INFO;

function RmStartSession(var pSessionHandle: DWORD; dwSessionFlags: DWORD; strSessionKey: PWideChar): DWORD; stdcall; external RestartManagerDll;
function RmEndSession(dwSessionHandle: DWORD): DWORD; stdcall; external RestartManagerDll;
function RmRegisterResources(dwSessionHandle: DWORD; nFiles: UINT; rgsFileNames: PPWideChar; nApplications: UINT; rgApplications: PRM_UNIQUE_PROCESS; nServices: UINT; rgsServiceNames: PPWideChar): DWORD; stdcall; external RestartManagerDll;
function RmGetList(dwSessionHandle: DWORD; var pnProcInfoNeeded: UINT; var pnProcInfo: UINT; rgAffectedApps: PRM_PROCESS_INFO; var lpdwRebootReasons: DWORD): DWORD; stdcall; external RestartManagerDll;
function RmShutdown(dwSessionHandle: DWORD; lActionFlags: ULONG; fnStatus: Pointer): DWORD; stdcall; external RestartManagerDll;

// ---------------------------------------------------------------------------
// NetApi (netapi32.dll)
// ---------------------------------------------------------------------------

const
  NetApiDll = 'netapi32.dll';

  NERR_Success = 0;
  ERROR_MORE_DATA_CODE = 234;
  MAX_PREFERRED_LENGTH = DWORD(-1);

type
  PFileInfo3 = ^TFileInfo3;
  TFileInfo3 = record
    fi3_id: DWORD;
    fi3_permissions: DWORD;
    fi3_num_locks: DWORD;
    fi3_pathname: PWideChar;
    fi3_username: PWideChar;
  end;

function NetFileEnum(servername, basepath, username: PWideChar; level: DWORD; var bufptr: Pointer; prefmaxlen: DWORD; var entriesread, totalentries: DWORD; resume_handle: PDWORD): DWORD; stdcall; external NetApiDll;
function NetFileClose(servername: PWideChar; fileid: DWORD): DWORD; stdcall; external NetApiDll;
function NetApiBufferFree(Buffer: Pointer): DWORD; stdcall; external NetApiDll;

// ---------------------------------------------------------------------------
// TFileLockInfo
// ---------------------------------------------------------------------------

function TFileLockInfo.Descrizione: string;
begin

  case Origin of
    loProcessoLocale:
      result := Format('processo locale %s (pid %d)', [ApplicationName, LockId]);
    loSessioneCondivisione:
      result := Format('sessione di rete di %s su %s', [UserName, ApplicationName]);
  end;
end;

// ---------------------------------------------------------------------------
// Funzioni pubbliche
// ---------------------------------------------------------------------------

function FileIsLocked(const FileName: string): Boolean;
var
  fileHandle: THandle;
begin
  result := false;

  if not FileExists(FileName) then
    Exit;

  // apertura esclusiva in scrittura: fallisce se il file e' aperto altrove
  fileHandle := CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);

  if fileHandle = INVALID_HANDLE_VALUE then
    result := GetLastError = ERROR_SHARING_VIOLATION
  else
    CloseHandle(fileHandle);
end;

// apre una sessione Restart Manager registrando il file; 0 = errore
function StartResourceSession(const FileName: string; var SessionHandle: DWORD): Boolean;
var
  sessionKey: array [0 .. CCH_RM_SESSION_KEY] of WideChar;
  filePath: PWideChar;
begin
  FillChar(sessionKey, SizeOf(sessionKey), 0);

  result := RmStartSession(SessionHandle, 0, sessionKey) = ERROR_SUCCESS;
  if not result then
    Exit;

  filePath := PWideChar(FileName);
  result := RmRegisterResources(SessionHandle, 1, @filePath, 0, nil, 0, nil) = ERROR_SUCCESS;

  if not result then
    RmEndSession(SessionHandle);
end;

function EnumLocalLockers(const FileName: string; LockList: TFileLockList): Integer;
var
  sessionHandle: DWORD;
  neededCount, processCount: UINT;
  rebootReasons: DWORD;
  processList: array of RM_PROCESS_INFO;
  lockInfo: TFileLockInfo;
  callResult: DWORD;
  i: Integer;
begin
  result := 0;

  if not StartResourceSession(FileName, sessionHandle) then
    Exit;
  try
    // prima chiamata per conoscere la dimensione necessaria
    neededCount := 0;
    processCount := 0;
    rebootReasons := 0;
    callResult := RmGetList(sessionHandle, neededCount, processCount, nil, rebootReasons);

    if (callResult = ERROR_MORE_DATA_CODE) and (neededCount > 0) then
    begin
      SetLength(processList, neededCount);
      processCount := neededCount;
      callResult := RmGetList(sessionHandle, neededCount, processCount, @processList[0], rebootReasons);
    end;

    if callResult <> ERROR_SUCCESS then
      Exit;

    // il cast evita l'overflow del ciclo quando il conteggio unsigned vale 0
    for i := 0 to Integer(processCount) - 1 do
    begin
      lockInfo.Origin := loProcessoLocale;
      lockInfo.LockId := processList[i].Process.dwProcessId;
      lockInfo.ApplicationName := processList[i].strAppName;
      lockInfo.UserName := '';
      LockList.Add(lockInfo);
      inc(result);
    end;
  finally
    RmEndSession(sessionHandle);
  end;
end;

function CloseLocalLockers(const FileName: string): Boolean;
var
  sessionHandle: DWORD;
begin
  result := false;

  if not StartResourceSession(FileName, sessionHandle) then
    Exit;
  try
    // chiude le applicazioni che bloccano il file; le app registrate al
    // Restart Manager vengono chiuse con garbo, le altre terminate
    result := RmShutdown(sessionHandle, RmForceShutdownFlag, nil) = ERROR_SUCCESS;
  finally
    RmEndSession(sessionHandle);
  end;
end;

// normalizza il nome server per le NetApi: nil = computer locale
function ServerNamePointer(const ServerName: string; var Buffer: string): PWideChar;
begin

  if ServerName.IsEmpty then
    Exit(nil);

  Buffer := ServerName;
  if not Buffer.StartsWith('\\') then
    Buffer := '\\' + Buffer;

  result := PWideChar(Buffer);
end;

function EnumShareLockers(const ServerName, FileName: string; LockList: TFileLockList): Integer;
var
  serverBuffer: string;
  serverPointer: PWideChar;
  buffer: Pointer;
  entriesRead, totalEntries, resumeHandle: DWORD;
  fileInfo: PFileInfo3;
  lockInfo: TFileLockInfo;
  callResult: DWORD;
  targetName: string;
  i: Integer;
begin
  result := 0;

  targetName := ExtractFileName(FileName);
  serverPointer := ServerNamePointer(ServerName, serverBuffer);
  resumeHandle := 0;

  repeat
    buffer := nil;
    callResult := NetFileEnum(serverPointer, nil, nil, 3, buffer, MAX_PREFERRED_LENGTH, entriesRead, totalEntries, @resumeHandle);

    if (callResult <> NERR_Success) and (callResult <> ERROR_MORE_DATA_CODE) then
      Exit; // accesso negato o server non raggiungibile: nessun risultato

    try
      fileInfo := buffer;
      // il cast evita l'overflow del ciclo quando il conteggio unsigned vale 0
      for i := 0 to Integer(entriesRead) - 1 do
      begin

        if SameText(ExtractFileName(fileInfo.fi3_pathname), targetName) then
        begin
          lockInfo.Origin := loSessioneCondivisione;
          lockInfo.LockId := fileInfo.fi3_id;
          lockInfo.ApplicationName := fileInfo.fi3_pathname;
          lockInfo.UserName := fileInfo.fi3_username;
          LockList.Add(lockInfo);
          inc(result);
        end;

        inc(fileInfo);
      end;
    finally
      if buffer <> nil then
        NetApiBufferFree(buffer);
    end;
  until callResult <> ERROR_MORE_DATA_CODE;
end;

function CloseShareLockers(const ServerName, FileName: string): Integer;
var
  serverBuffer: string;
  serverPointer: PWideChar;
  lockList: TFileLockList;
  lockInfo: TFileLockInfo;
begin
  result := 0;

  serverPointer := ServerNamePointer(ServerName, serverBuffer);

  lockList := TFileLockList.Create;
  try
    EnumShareLockers(ServerName, FileName, lockList);

    for lockInfo in lockList do
      if NetFileClose(serverPointer, lockInfo.LockId) = NERR_Success then
        inc(result);
  finally
    FreeAndNil(lockList);
  end;
end;

function ServerFromUncPath(const Path: string): string;
var
  separatorPosition: Integer;
begin
  result := '';

  if not Path.StartsWith('\\') then
    Exit;

  // \\server\condivisione\... -> server
  separatorPosition := Path.IndexOf('\', 2); // 0-based, salta le due barre iniziali
  if separatorPosition > 2 then
    result := Path.Substring(2, separatorPosition - 2)
  else
    result := Path.Substring(2);
end;

end.
