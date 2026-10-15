unit GestyTools.FTP;

interface

uses
  System.SysUtils,
  System.Classes,
  IdSSL,
  zNet.Tls,
  IdComponent,
  IdExplicitTLSClientServerBase,
  IdFTP,
  IdFTPList,
  IdFTPCommon, IdBaseComponent, IdTCPConnection, IdTCPClient;

type
  // posizione e dimensione totale in byte
  // (Size = 0 se il server non fornisce la dimensione)
  TFtpProgressCallback = reference to procedure(const Position: Int64; const Size: Int64);

  TFtpParams = record

  private
    FDefaultFolder: string;
    FHost: string;
    FPassivo: boolean;
    FPassword: string;
    FPort: integer;
    FTransferType: TIdFTPTransferType;
    FUsername: string;
    FUseTLS: TIdUseTLS;
  public
    procedure Init;
  public
    property Host: string read FHost;
    property Port: integer read FPort;
    property Username: string read FUsername;
    property Password: string read FPassword;
    property DefaultFolder: string read FDefaultFolder;
    property Passivo: boolean read FPassivo;
    property UseTLS: TIdUseTLS read FUseTLS;
    property TransferType: TIdFTPTransferType read FTransferType;
  end;

  TFTP = class(TDataModule)
    IdFTP: TIdFTP;
  private
    // creato in Connect dalla fabbrica registrata in zNet.Tls
    SocketTls: TIdSSLIOHandlerSocketBase;
    FProgressCallback: TFtpProgressCallback;
    FWorkCountMax: Int64;
    procedure FtpWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure FtpWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
  public
    procedure Connect;
    procedure Disconnect;

    function RemoteFileExists(const FileName: string): boolean;
    procedure ChangeDir(folder: string);
    // entra nella cartella contenuta in RemotePath (separatori / o \) e
    // restituisce il solo nome del file: molti server (Synology incluso)
    // non accettano RETR/SIZE con il percorso nel comando
    function ChangeDirForFile(const RemotePath: string): string;
    procedure ListFiles(Files: TStrings);
    // nome relativo alla cartella corrente, come per RemoteFileExists
    procedure Delete(const FileName: string);
    procedure Download(const SrcFileName, DestFileName: string; ProgressCallback: TFtpProgressCallback = nil);
    procedure Upload(const SrcFileName, DestFileName: string; ProgressCallback: TFtpProgressCallback = nil);
  end;

var
  FTP: TFTP;

implementation

uses
  IdReplyRFC,
  zWaitFrm,
  GestyTools.Config;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TFtpParams }

procedure TFtpParams.Init;
const
  DefaultUsr = 'GestyTools';
  DefaultPwd = 'Mika++71';
begin
  FHost := '192.168.1.21';
  FHost := 'gesty.sytes.net'; // non va
  FHost := 'gesty.synology.me';
  FPort := 21;
  FUsername := DefaultUsr;
  FPassword := DefaultPwd + DefaultPwd; // doppia
  FDefaultFolder := 'FTP';
  FPassivo := true;
  FUseTLS := utUseExplicitTLS; // non variare
  FTransferType := ftBinary;

  if not Config.FtpHost.IsEmpty then
  begin
    FHost := Config.FtpHost;
    FPort := Config.FtpPort;
    FUsername := Config.FtpUsername;
    FPassword := Config.FtpPassword;
    FDefaultFolder := Config.FtpDefaultFolder;

    if FUsername.IsEmpty then
      FUsername := DefaultUsr;

    if FPassword.IsEmpty then
      FPassword := DefaultPwd + DefaultPwd; // doppia
  end;
end;

procedure TFTP.Connect;
var
  params: TFtpParams;
begin
  if IdFTP.Connected then
    exit;

  StartWait('Attendere...', true);
  try
    params.Init;

    if params.Host.IsEmpty then
      raise exception.Create('FTP non configurato.');

    IdFTP.Host := params.Host;
    IdFTP.Port := params.Port;
    IdFTP.Username := params.Username;
    IdFTP.Password := params.Password;
    IdFTP.Passive := params.Passivo;
    IdFTP.TransferType := params.TransferType;

    // handler creato dalla fabbrica registrata in zNet.Tls: oggi OpenSSL,
    // domani SChannel, senza toccare questa unit
    FreeAndNil(SocketTls);
    SocketTls := CreaIOHandlerTls(Self);
    IdFTP.IOHandler := SocketTls;
    IdFTP.UseTLS := params.UseTLS;
    IdFTP.DataPortProtection := ftpdpsPrivate; // https://codeverge.com/embarcadero.delphi.tools/indy-10-ftp-over-tls/2031297

    IdFTP.Connect;

    if not params.DefaultFolder.IsEmpty then
      ChangeDir(params.DefaultFolder);
  finally
    StopWait;
  end;
end;

procedure TFTP.Disconnect;
begin
  if IdFTP.Connected then
    IdFTP.Disconnect;
end;

function TFTP.RemoteFileExists(const FileName: string): boolean;
var
  Str: TStringList;
begin
  // come Download e Upload: chiamata anche prima di un FtpConnect esplicito
  Connect;

  Str := TStringList.Create;
  try
    try
      IdFTP.ExtListItem(Str, ExtractFileName(FileName));
    except
      // il file assente non e' un errore: MLST risponde 550 (il Synology con
      // "can't be listed") e Indy solleva, invece di restituire l'elenco vuoto
      on E: EIdReplyRFCError do
        if E.ErrorCode = 550 then
          Exit(false)
        else
          raise;
    end;
    Result := Str.Count > 0;
  finally
    FreeAndNil(Str);
  end;
end;

procedure TFTP.ChangeDir(folder: string);
begin
  IdFTP.ChangeDir(folder);
end;

procedure TFTP.Delete(const FileName: string);
begin
  Connect;
  IdFTP.Delete(FileName);
end;

function TFTP.ChangeDirForFile(const RemotePath: string): string;
var
  normalized: string;
  folder: string;
  separatorPosition: integer;
begin
  Connect;

  normalized := RemotePath.Replace('\', '/');

  separatorPosition := normalized.LastIndexOf('/');
  if separatorPosition >= 0 then
  begin
    folder := normalized.Substring(0, separatorPosition).Trim(['/']);
    if not folder.IsEmpty then
      ChangeDir(folder);

    result := normalized.Substring(separatorPosition + 1);
  end
  else
    result := normalized;
end;

procedure TFTP.ListFiles(Files: TStrings);
var
  item: TIdFTPListItem;
  i: integer;
begin
  assert(assigned(Files));

  // come Download e Upload: chiamata anche prima di un FtpConnect esplicito
  Connect;

  Files.Clear;

  StartWait('Lettura dei file sul server FTP...', true);
  try
    IdFTP.List();
  finally
    StopWait;
  end;

  for i := 0 to IdFTP.DirectoryListing.Count - 1 do
  begin
    item := IdFTP.DirectoryListing[i];

    if item.ItemType = ditFile then
      Files.add(item.FileName)
    else
      if item.ItemType = ditDirectory then
        Files.add('-- ' + item.FileName)
  end;
end;

procedure TFTP.FtpWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin

  if AWorkCountMax > 0 then
    FWorkCountMax := AWorkCountMax;
end;

procedure TFTP.FtpWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin

  if Assigned(FProgressCallback) then
    FProgressCallback(AWorkCount, FWorkCountMax);
end;

procedure TFTP.Download(const SrcFileName, DestFileName: string; ProgressCallback: TFtpProgressCallback);
var
  remoteSize: Int64;
begin
  Connect;

  if Assigned(ProgressCallback) then
  begin
    FProgressCallback := ProgressCallback;

    // dimensione remota come fallback se OnWorkBegin non la fornisce
    FWorkCountMax := 0;
    try
      remoteSize := IdFTP.Size(SrcFileName);
      if remoteSize > 0 then
        FWorkCountMax := remoteSize;
    except
      // SIZE non supportato dal server: si prosegue senza totale
    end;

    IdFTP.OnWorkBegin := FtpWorkBegin;
    IdFTP.OnWork := FtpWork;
    try
      IdFTP.Get(SrcFileName, DestFileName, true, false);
    finally
      IdFTP.OnWorkBegin := nil;
      IdFTP.OnWork := nil;
      FProgressCallback := nil;
    end;
  end
  else
  begin
    StartWait('Attendere...', true);
    try
      IdFTP.Get(SrcFileName, DestFileName, true, false);
    finally
      StopWait;
    end;
  end;
end;

procedure TFTP.Upload(const SrcFileName, DestFileName: string; ProgressCallback: TFtpProgressCallback);
begin
  Connect;

  if Assigned(ProgressCallback) then
  begin
    FProgressCallback := ProgressCallback;
    FWorkCountMax := 0; // per l'upload OnWorkBegin fornisce la dimensione del file locale

    IdFTP.OnWorkBegin := FtpWorkBegin;
    IdFTP.OnWork := FtpWork;
    try
      IdFTP.Put(SrcFileName, DestFileName, false);
    finally
      IdFTP.OnWorkBegin := nil;
      IdFTP.OnWork := nil;
      FProgressCallback := nil;
    end;
  end
  else
  begin
    StartWait('Invio del file...', true);
    try
      IdFTP.Put(SrcFileName, DestFileName, false);
    finally
      StopWait;
    end;
  end;
end;

end.
