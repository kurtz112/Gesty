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
    FAnonimizzazioneChiaveDerivazione: string;
    FAnonimizzazioneParolaOrdine: string;
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
    FMantisAssegnatario: string;
    FMantisCategoria: string;
    FMantisProgetto: string;
    FMantisToken: string;
    FMantisUrl: string;
    FPort: integer;
    FRemote_BackupFolder: string;
    FRemote_UpdateZip: string;
    FServer: string;
    FSmtpDestinatario: string;
    FSmtpHost: string;
    FSmtpMittente: string;
    FSmtpPassword: string;
    FSmtpPorta: integer;
    FSmtpUtente: string;
    FTlsProvider: string;
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
  published // Percorsi remoti sull'ftp, relativi alla cartella di default
    property Remote_UpdateZip: string read FRemote_UpdateZip write FRemote_UpdateZip;
    property Remote_BackupFolder: string read FRemote_BackupFolder write FRemote_BackupFolder;
  published // User
    property dbUserName: string read FdbUserName write FdbUserName;
    property dbPassword: string read FdbPassword write FdbPassword;
  published // DB
    property Server: string read FServer write FServer;
    property Port: integer read FPort write FPort;
    property DB: string read FDB write FDB;
    property DBFolder: string read GetDBFolder;
    property DBFileName: string read GetDBFileName;

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
    // SMTP, per le mail di errore e per Notifica degli script
    //
    // Utente e password stavano scritti in TMail.SendMail, e quindi dentro
    // ogni eseguibile installato: chiunque li leggeva con un visualizzatore
    // di stringhe. Qui stanno nel file di configurazione del cliente, come
    // gli altri segreti. Host e porta hanno un predefinito, utente e
    // password no: senza, la mail non parte e lo dice il registro.
    property SmtpHost: string read FSmtpHost write FSmtpHost;
    property SmtpPorta: integer read FSmtpPorta write FSmtpPorta;
    property SmtpUtente: string read FSmtpUtente write FSmtpUtente;
    property SmtpPassword: string read FSmtpPassword write FSmtpPassword;
    property SmtpMittente: string read FSmtpMittente write FSmtpMittente;
    property SmtpDestinatario: string read FSmtpDestinatario write FSmtpDestinatario;
  published
    // Mantis: un ticket per ogni errore di GestyScript
    //
    // MantisToken vuoto = invio a Mantis spento, resta la sola mail. Il token
    // e' quello di un utente dedicato, con livello reporter sul solo progetto
    // del cliente: se viene letto dal server del cliente, da' accesso a quel
    // progetto e a nessun altro. MantisProgetto vuoto = Ente.
    // MantisAssegnatario: nome utente Mantis a cui assegnare il ticket, cosi'
    // compare fra quelli assegnati e parte la notifica di Mantis.
    property MantisUrl: string read FMantisUrl write FMantisUrl;
    property MantisToken: string read FMantisToken write FMantisToken;
    property MantisProgetto: string read FMantisProgetto write FMantisProgetto;
    property MantisCategoria: string read FMantisCategoria write FMantisCategoria;
    property MantisAssegnatario: string read FMantisAssegnatario write FMantisAssegnatario;
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

  // Percorsi remoti sull'ftp, relativi alla cartella di default
  FRemote_UpdateZip := 'File_Aggiornamento_Gesty/Aggiornamento_Gesty.zip';
  FRemote_BackupFolder := 'Backup Clienti\';

  // User
  FdbUserName := 'SYSDBA';
  FdbPassword := 'masterkey';

  // DB
  FServer := '';
  FPort := 3050;
  FDB := '';
  FEmbedded := false;
  FVendorLib := '';

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

  // SMTP: host e porta erano nel .dfm di TMail, destinatario in InitMessage
  FSmtpHost := 'mail.tophost.it';
  FSmtpPorta := 587;
  FSmtpUtente := '';
  FSmtpPassword := '';
  FSmtpMittente := '';
  FSmtpDestinatario := 'assistenza@zebro.it';

  // Mantis
  FMantisUrl := 'https://www.zebro.it/mantis';
  FMantisToken := '';
  FMantisProgetto := '';
  FMantisCategoria := 'Generica';
  FMantisAssegnatario := '';

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

  // valore letto, o il predefinito di Init se nel file manca: i file salvati
  // prima dell'aggiunta della voce non la contengono
  function Valore(const Nome, Predefinito: string): string;
  begin
    result := StringList.Values[Nome];
    if result.IsEmpty then
      result := Predefinito;
  end;

begin
  Init;

  // Le voci di Google Drive (ClientId, ClientSecret, AccessToken,
  // RefreshToken, TokenType), Protocol e BackupNoTrigger non si leggono
  // piu': nessuno le usava. Un file vecchio che le contiene si apre lo
  // stesso, e al primo salvataggio spariscono.

  FEnte := StringList.Values['Ente'];

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
  FDB := StringList.Values['DB'];
  FEmbedded := StringList.Values['Embedded'].ToLower.Equals('true');
  FVendorLib := StringList.Values['VendorLib'];

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

  // SMTP
  FSmtpHost := Valore('SmtpHost', FSmtpHost);
  FSmtpPorta := StrToIntDef(StringList.Values['SmtpPorta'], FSmtpPorta);
  FSmtpUtente := StringList.Values['SmtpUtente'];
  FSmtpPassword := StringList.Values['SmtpPassword'];
  FSmtpMittente := StringList.Values['SmtpMittente'];
  FSmtpDestinatario := Valore('SmtpDestinatario', FSmtpDestinatario);

  // Mantis
  FMantisUrl := Valore('MantisUrl', FMantisUrl);
  FMantisToken := StringList.Values['MantisToken'];
  FMantisProgetto := StringList.Values['MantisProgetto'];
  FMantisCategoria := Valore('MantisCategoria', FMantisCategoria);
  FMantisAssegnatario := StringList.Values['MantisAssegnatario'];

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

  // Percorsi remoti sull'ftp
  StringList.AddPair('Remote_UpdateZip', Remote_UpdateZip);
  StringList.AddPair('Remote_BackupFolder', Remote_BackupFolder);

  // User
  StringList.AddPair('dbUserName', dbUserName);
  StringList.AddPair('dbPassword', dbPassword);

  // DB
  StringList.AddPair('Server', Server);
  StringList.AddPair('Port', Port.ToString);
  StringList.AddPair('DB', DB);
  StringList.AddPair('Embedded', Embedded.ToString(True));
  StringList.AddPair('VendorLib', VendorLib);

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

  // SMTP
  StringList.AddPair('SmtpHost', SmtpHost);
  StringList.AddPair('SmtpPorta', SmtpPorta.ToString);
  StringList.AddPair('SmtpUtente', SmtpUtente);
  StringList.AddPair('SmtpPassword', SmtpPassword);
  StringList.AddPair('SmtpMittente', SmtpMittente);
  StringList.AddPair('SmtpDestinatario', SmtpDestinatario);

  // Mantis
  StringList.AddPair('MantisUrl', MantisUrl);
  StringList.AddPair('MantisToken', MantisToken);
  StringList.AddPair('MantisProgetto', MantisProgetto);
  StringList.AddPair('MantisCategoria', MantisCategoria);
  StringList.AddPair('MantisAssegnatario', MantisAssegnatario);

  // TLS
  StringList.AddPair('TlsProvider', TlsProvider);

  // Anonimizzazione
  StringList.AddPair('AnonimizzazioneParolaOrdine', AnonimizzazioneParolaOrdine);
  StringList.AddPair('AnonimizzazioneChiaveDerivazione', AnonimizzazioneChiaveDerivazione);
end;

initialization

Config := TConfig.Create;

end.
