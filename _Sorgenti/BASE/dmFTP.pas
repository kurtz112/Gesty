unit dmFTP;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  IdSSL,
  zNet.Tls,
  IdComponent,
  IdExplicitTLSClientServerBase,
  IdFTP,
  IdFTPList,
  IdFTPCommon,
  Vcl.Dialogs,
   zProgressBox, IdBaseComponent, IdTCPConnection, IdTCPClient;

type
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
    ProgressBox: TProgressBox;
    procedure IdFTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure IdFTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure IdFTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
  private
    SocketTls: TIdSSLIOHandlerSocketBase;
    procedure LoadParams(const FtpName: string; var params: TFtpParams);
  public
    procedure Connect(const FtpName: string);
    procedure Disconnect;

    function RemoteFileExists(const FileName: string): boolean;
    procedure ChangeDir(folder: string);
    procedure ListFiles(Files: TStrings);
    procedure Download(const SrcFileName, DestFileName: string);
    procedure Upload(const SrcFileName, DestFileName: string);
  end;

function FTP: TFTP;

implementation

uses
  zBaseLib,
  zSystem,
  Gesty_StoredProcs;

var
  __FTP: TFTP = nil;

function FTP: TFTP;
begin
  if not assigned(__FTP) then
    __FTP := TFTP.Create(Application);

  result := __FTP;
end;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TFtpParams }

procedure TFtpParams.Init;
begin
  FHost := '';
  FHost := '';
  FPort := 21;
  FUsername := '';
  FPassword := '';
  FDefaultFolder := '';
  FPassivo := true;
  FUseTLS := utUseExplicitTLS; // non variare
  FTransferType := ftBinary;
end;

procedure TFTP.LoadParams(const FtpName: string; var params: TFtpParams);
var
  sp: TSP_ftp_Get_Config;
begin
  params.Init;

  sp := TSP_ftp_Get_Config.Create(base.zFbTransaction);
  try
    sp.FTP := FtpName;
    sp.executeAndCommit;

    params.FHost := sp.Host;
    params.FPort := sp.Port;
    params.FUsername := sp.Username;
    params.FPassword := sp.password_;
    params.FDefaultFolder := sp.folder;
    params.FPassivo := sp.Passivo;

    if sp.Tls_Esplicito then
      params.FUseTLS := utUseExplicitTLS
    else
      params.FUseTLS := utUseImplicitTLS;

    if sp.Binario then
      params.FTransferType := ftBinary
    else
      params.FTransferType := ftASCII;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TFTP.Connect(const FtpName: string);
var
  params: TFtpParams;
begin
  if IdFTP.Connected then
    exit;

  StartWait('Attendere...', true);
  try
    LoadParams(FtpName, params);

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
  Str := TStringList.Create;
  try
    IdFTP.ExtListItem(Str, ExtractFileName(FileName));
    result := Str.Count = 1;
  finally
    FreeAndNil(Str);
  end;
end;

procedure TFTP.ChangeDir(folder: string);
begin
  IdFTP.ChangeDir(folder);
end;

procedure TFTP.ListFiles(Files: TStrings);
var
  item: TIdFTPListItem;
  i: integer;
begin
  assert(assigned(Files));

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

procedure TFTP.Download(const SrcFileName, DestFileName: string);
begin
  StartWait('Scaricamento del file...', true);
  try
    ProgressBox.Caption := 'Download';
    ProgressBox.FirstLabel := 'Download';
    ProgressBox.SecondLabel := SrcFileName;
    IdFTP.Get(SrcFileName, DestFileName, true, false);
  finally
    StopWait;
  end;
end;

procedure TFTP.Upload(const SrcFileName, DestFileName: string);
begin
  StartWait('Invio del file...', true);
  try
    IdFTP.Put(SrcFileName, DestFileName, false);
  finally
    StopWait;
  end;
end;

procedure TFTP.IdFTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  ProgressBox.Progress := 0;
  ProgressBox.MaxValue := AWorkCountMax;
  ProgressBox.Show;
end;

procedure TFTP.IdFTPWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  ProgressBox.Progress := AWorkCount;
end;

procedure TFTP.IdFTPWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  ProgressBox.Close;
end;

end.
