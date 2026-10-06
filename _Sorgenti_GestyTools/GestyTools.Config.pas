unit GestyTools.Config;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Forms;

type
  TConfig = class(TPersistent)
  private
    FClientId: string;
    FClientSecret: string;
    FAccessToken: string;
    FAnonimizzazioneChiaveDerivazione: string;
    FAnonimizzazioneParolaOrdine: string;
    FBackupNoTrigger: boolean;
    FDB: string;
    FdbPassword: string;
    FdbUserName: string;
    FEmbedded: boolean;
    FEnte: string;
    FFileNameBat: string;
    FFolderBackupDB: string;
    FFolderBackupExe: string;
    FFolderBin: string;
    FFolderUpdate: string;
    FFtpDefaultFolder: string;
    FFtpHost: string;
    FFtpPassword: string;
    FFtpPort: integer;
    FFtpUsername: string;
    FPort: integer;
    FProtocol: string;
    FRefreshToken: string;
    FRemote_BackupFolder: string;
    FRemote_UpdateZip: string;
    FServer: string;
    FTlsProvider: string;
    FTokenType: string;
    FVendorLib: string;
  private
    function CommandLineConfigFileName: string;
    function ConfigFileName: string;
    procedure Init;
  private
    function GetDBFileName: string;
    function GetDBFolder: string;
  public
    constructor Create;
    procedure Load;
    procedure Save;
  public
    procedure LoadProps(StringList: TStringList);
    procedure SaveProps(StringList: TStringList);
  published // Ente
    property Ente: string read FEnte write FEnte;
  published // GDrive
    property ClientId: string read FClientId write FClientId;
    property ClientSecret: string read FClientSecret write FClientSecret;
    property AccessToken: string read FAccessToken write FAccessToken;
    property RefreshToken: string read FRefreshToken write FRefreshToken;
    property TokenType: string read FTokenType write FTokenType;
  published // GDrive Folders
    property Remote_UpdateZip: string read FRemote_UpdateZip write FRemote_UpdateZip;
    property Remote_BackupFolder: string read FRemote_BackupFolder write FRemote_BackupFolder;
  published // User
    property dbUserName: string read FdbUserName write FdbUserName;
    property dbPassword: string read FdbPassword write FdbPassword;
  published // DB
    property Server: string read FServer write FServer;
    property Port: integer read FPort write FPort;
    property Protocol: string read FProtocol write FProtocol;
    property DB: string read FDB write FDB;
    property DBFolder: string read GetDBFolder;
    property DBFileName: string read GetDBFileName;
    property BackupNoTrigger: boolean read FBackupNoTrigger write FBackupNoTrigger;

    property Embedded: boolean read FEmbedded write FEmbedded;
    property VendorLib: string read FVendorLib write FVendorLib;
  published // Folder
    property FolderBin: string read FFolderBin write FFolderBin;
    property FolderUpdate: string read FFolderUpdate write FFolderUpdate;
    property FolderBackupDB: string read FFolderBackupDB write FFolderBackupDB;
    property FolderBackupExe: string read FFolderBackupExe write FFolderBackupExe;
    property FileNameBat: string read FFileNameBat write FFileNameBat;
  published
    // FTP
    property FtpHost: string read FFtpHost write FFtpHost;
    property FtpPort: integer read FFtpPort write FFtpPort;
    property FtpUsername: string read FFtpUsername write FFtpUsername;
    property FtpPassword: string read FFtpPassword write FFtpPassword;
    property FtpDefaultFolder: string read FFtpDefaultFolder write FFtpDefaultFolder;
  published
    // Anonimizzazione
    //
    // I due segreti del ciclo di anonimizzazione. Stanno qui, dentro il file
    // .lz, e non nello script .pas, che sul server del cliente e' un file di
    // testo in chiaro leggibile da chiunque apra la cartella.
    //
    // ParolaOrdine: la stessa passata a ANONYMIZER_GESTY.INIZIALIZZA quando il
    // motore e' stato configurato in produzione. Nel database ne resta solo
    // l'impronta SHA256: se qui viene scritta una parola diversa, il ciclo si
    // rifiuta di partire. Non protegge da una connessione sbagliata, protegge
    // dall'esecuzione accidentale.
    //
    // ChiaveDerivazione: il seme con cui il motore genera i valori finti. A
    // parita' di chiave lo stesso dato di partenza produce sempre lo stesso
    // valore anonimo, e questo tiene allineate fra loro copie diverse. Il
    // motore la cancella dal proprio registro a fine ciclo: l'unica copia
    // che resta e' questa.
    property AnonimizzazioneParolaOrdine: string read FAnonimizzazioneParolaOrdine write FAnonimizzazioneParolaOrdine;
    property AnonimizzazioneChiaveDerivazione: string read FAnonimizzazioneChiaveDerivazione write FAnonimizzazioneChiaveDerivazione;
  published
    // SMTP
  published
    // TLS: motore da passare a zNet.Tls.SelezionaProviderTls all'avvio
    // (GestyTools.dpr, subito dopo Config.load). Valori accettati oggi:
    // 'OPENSSL', 'SCHANNEL'. Predefinito 'OPENSSL', cosi' un file .lz
    // salvato prima di questa modifica mantiene il comportamento di oggi.
    property TlsProvider: string read FTlsProvider write FTlsProvider;
  end;

var
  Config: TConfig = nil;

implementation

uses
  System.IOUtils,
  System.IniFiles,
  System.Zip;

{ TConfig }

constructor TConfig.Create;
begin
  inherited;
  Init;
end;

function TConfig.CommandLineConfigFileName: string;
var
  parameterIndex: integer;
  parameterValue: string;
begin
  result := '';

  // primo parametro con estensione .lz = file di configurazione alternativo
  for parameterIndex := 1 to ParamCount do
  begin
    parameterValue := ParamStr(parameterIndex);

    if SameText(ExtractFileExt(parameterValue), '.lz_cfg') then
      Exit(ExpandFileName(parameterValue));
  end;
end;

function TConfig.ConfigFileName: string;
var
  Folder: string;
begin

  // configurazione da riga di comando: GestyTools.exe <percorso>\Cliente.lz
  result := CommandLineConfigFileName;
  if not result.IsEmpty then
    Exit;

  // in assenza del parametro usa il file di default accanto all'eseguibile
  Folder := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
  result := Folder + 'GestyTools.lz_cfg';
end;

function TConfig.GetDBFileName: string;
begin
  result := ExtractFileName(DB);
end;

procedure TConfig.Load;
var
  StringList: TStringList;
  stream: TStream;
  Zip: TZipFile;
  ZipHeader: TZipHeader;
begin

  if not TFile.exists(ConfigFileName) then
  begin
    // un file richiesto esplicitamente da riga di comando deve esistere:
    // proseguire con i default significherebbe lavorare sul database sbagliato
    if not CommandLineConfigFileName.IsEmpty then
      raise Exception.Create('File di configurazione non trovato: ' + ConfigFileName);

    Exit;
  end;

  Zip := TZipFile.Create;
  try
    Zip.Open(ConfigFileName, zmRead);

    Zip.Read('config.ini', stream, ZipHeader);
    try

      StringList := TStringList.Create;
      try
        stream.Position := 0;
        StringList.LoadFromStream(stream);
        LoadProps(StringList);
      finally
        FreeAndNil(StringList);
      end;
    finally
      FreeAndNil(stream);
    end;
  finally
    FreeAndNil(Zip);
  end;
end;

procedure TConfig.Save;
var
  StringList: TStringList;
  stream: TMemoryStream;
  Zip: TZipFile;
begin

  stream := TMemoryStream.Create;
  try
    StringList := TStringList.Create;
    try
      SaveProps(StringList);
      StringList.SaveToStream(stream);
      stream.Position := 0;
    finally
      FreeAndNil(StringList);
    end;

    /// /////////////////////////////

    Zip := TZipFile.Create;
    try
      Zip.Open(ConfigFileName, zmWrite);
      Zip.Add(stream, 'config.ini');
    finally
      FreeAndNil(Zip);
    end;
  finally
    FreeAndNil(stream);
  end;
end;

function TConfig.GetDBFolder: string;
begin
  result := IncludeTrailingPathDelimiter(ExtractFilePath(DB));
end;

procedure TConfig.Init;
begin
  Ente := '';
  // GDrive
  FClientId := '411091787928-g5e2gfb3rchvk68dmhl08cpvsi2pad93.apps.googleusercontent.com';
  FClientSecret := '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';

  FAccessToken := '';
  FRefreshToken := '';
  FTokenType := 'Bearer';

  // Percorsi remoti sull'ftp, relativi alla cartella di default
  FRemote_UpdateZip := 'File_Aggiornamento_Gesty/Aggiornamento_Gesty.zip';
  FRemote_BackupFolder := 'Backup Clienti\';

  // User
  FdbUserName := 'SYSDBA';
  FdbPassword := 'masterkey';

  // DB
  FServer := '';
  FPort := 3050;
  FProtocol := 'TCPIP';
  FDB := '';
  FEmbedded := false;
  FVendorLib := '';
  FBackupNoTrigger := false; // per FB5

  // Folder
  FolderBin := '';
  FolderUpdate := '';
  FolderBackupDB := '';
  FolderBackupExe := '';
  FileNameBat := '';

  // FTP
  FFtpHost := 'gesty.synology.me';
  FFtpPort := 21;
  FFtpUsername := 'GestyTools';
  FFtpPassword := '';
  FFtpDefaultFolder := 'FTP';

  // TLS
  FTlsProvider := 'OPENSSL';

  // Anonimizzazione: nessun valore predefinito di proposito. Un segreto
  // predefinito sarebbe lo stesso su tutti i clienti, e il ciclo deve
  // fermarsi finche' non e' stato scelto davvero.
  FAnonimizzazioneParolaOrdine := '';
  FAnonimizzazioneChiaveDerivazione := '';
end;

procedure TConfig.LoadProps(StringList: TStringList);
  procedure CheckFolder(Folder: string);
  begin

    if not TDirectory.exists(Folder) then
      TDirectory.CreateDirectory(Folder);
  end;

var
  tmp: string;
begin
  Init;

  FEnte := StringList.Values['Ente'];
  // GDrive
  FClientId := StringList.Values['ClientId'];
  FClientSecret := StringList.Values['ClientSecret'];
  FAccessToken := StringList.Values['AccessToken'];
  FRefreshToken := StringList.Values['RefreshToken'];
  FTokenType := StringList.Values['TokenType'];

  // Percorsi remoti sull'ftp
  FRemote_UpdateZip := StringList.Values['Remote_UpdateZip'];

  // migrazione: i config salvati ai tempi di GDrive puntano ancora al vecchio
  // percorso, che sull'ftp non esiste
  if FRemote_UpdateZip.IsEmpty or SameText(FRemote_UpdateZip, 'Aggiornamento/GestyExe.zip') then
    FRemote_UpdateZip := 'File_Aggiornamento_Gesty/Aggiornamento_Gesty.zip';

  FRemote_BackupFolder := StringList.Values['Remote_BackupFolder'];

  // User
  FdbUserName := StringList.Values['dbUserName'];
  if dbUserName.IsEmpty then
    FdbUserName := 'SYSDBA';

  FdbPassword := StringList.Values['dbPassword'];
  if dbPassword.IsEmpty then
    FdbPassword := 'masterkey';
  // DB
  FServer := StringList.Values['Server'];
  FPort := StringList.Values['Port'].ToInteger();
  FProtocol := StringList.Values['Protocol'];
  FDB := StringList.Values['DB'];
  FEmbedded := StringList.Values['Embedded'].ToLower.Equals('true');
  FVendorLib := StringList.Values['VendorLib'];
  FBackupNoTrigger := StringList.Values['BackupNoTrigger'] = 'True';

  // Folder
  FFolderBin := IncludeTrailingPathDelimiter(StringList.Values['Folder Bin']);
  FFolderUpdate := IncludeTrailingPathDelimiter(StringList.Values['Folder Update']);
  FFolderBackupDB := IncludeTrailingPathDelimiter(StringList.Values['Folder Backup DB']);
  FFolderBackupExe := IncludeTrailingPathDelimiter(StringList.Values['Folder Backup Exe']);
  FFileNameBat := StringList.Values['Backup Batch'];

  // FTP
  FFtpHost := StringList.Values['FtpHost'];

  if not StringList.Values['FtpPort'].IsEmpty then
    FFtpPort := StringList.Values['FtpPort'].ToInteger;

  FFtpUsername := StringList.Values['FtpUsername'];
  FFtpPassword := StringList.Values['FtpPassword'];
  FFtpDefaultFolder := StringList.Values['FtpDefaultFolder'];

  // TLS
  FTlsProvider := StringList.Values['TlsProvider'];
  if FTlsProvider.IsEmpty then
    FTlsProvider := 'OPENSSL';

  // Anonimizzazione
  FAnonimizzazioneParolaOrdine := StringList.Values['AnonimizzazioneParolaOrdine'];
  FAnonimizzazioneChiaveDerivazione := StringList.Values['AnonimizzazioneChiaveDerivazione'];

  //
  //
  //
  // Verifica delle cartelle
  CheckFolder(FolderBin);
  CheckFolder(FolderUpdate);
  CheckFolder(FolderBackupDB);
  CheckFolder(FolderBackupExe);
end;

procedure TConfig.SaveProps(StringList: TStringList);
begin
  StringList.AddPair('Ente', Ente);
  // GDrive
  StringList.AddPair('ClientId', ClientId);
  StringList.AddPair('ClientSecret', ClientSecret);
  StringList.AddPair('AccessToken', AccessToken);
  StringList.AddPair('RefreshToken', RefreshToken);
  StringList.AddPair('TokenType', TokenType);

  // GDrive Folders
  StringList.AddPair('Remote_UpdateZip', Remote_UpdateZip);
  StringList.AddPair('Remote_BackupFolder', Remote_BackupFolder);

  // User
  StringList.AddPair('dbUserName', dbUserName);
  StringList.AddPair('dbPassword', dbPassword);

  // DB
  StringList.AddPair('Server', Server);
  StringList.AddPair('Port', Port.ToString);
  StringList.AddPair('Protocol', Protocol);
  StringList.AddPair('DB', DB);
  StringList.AddPair('Embedded', Embedded.ToString(True));
  StringList.AddPair('VendorLib', VendorLib);

  if BackupNoTrigger then
    StringList.AddPair('BackupNoTrigger', 'True')
  else
    StringList.AddPair('BackupNoTrigger', 'False');

  // Folder
  StringList.AddPair('Backup Batch', FileNameBat);
  StringList.AddPair('Folder Bin', FolderBin);
  StringList.AddPair('Folder Update', FolderUpdate);
  StringList.AddPair('Folder Backup DB', FolderBackupDB);
  StringList.AddPair('Folder Backup Exe', FolderBackupExe);

  // FTP
  StringList.AddPair('FtpHost', FtpHost);
  StringList.AddPair('FtpPort', FtpPort.ToString);
  StringList.AddPair('FtpUsername', FtpUsername);
  StringList.AddPair('FtpPassword', FtpPassword);
  StringList.AddPair('FtpDefaultFolder', FtpDefaultFolder);

  // TLS
  StringList.AddPair('TlsProvider', TlsProvider);

  // Anonimizzazione
  StringList.AddPair('AnonimizzazioneParolaOrdine', AnonimizzazioneParolaOrdine);
  StringList.AddPair('AnonimizzazioneChiaveDerivazione', AnonimizzazioneChiaveDerivazione);
end;

initialization

Config := TConfig.Create;

end.
