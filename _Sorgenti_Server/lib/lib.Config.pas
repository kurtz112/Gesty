unit lib.Config;

interface

uses
  SysUtils,
  Classes;

type
  TConfig = class(TObject)
  private
    FAllowedMethods: string;
    FAllowMetaRequest: boolean;
    FCartellaFiles: string;
    FClientLibrary: string;
    FDataBaseName: string;
    FCharacterSet: string;
    FCmd_Enabled: boolean;
    FCors: string;
    FSP_Whitelist: string;
    FDbPassword: string;
    FDbUserName: string;
    FDbServer: string;
    FDominio: string;
    FDominioPwd: string;
    FLogoutUrl: string;
    FMetadata: boolean;
    FServicePortHTTP: Integer;
    FSMTPServer_Host: string;
    FSMTPServer_Password: string;
    FSMTPServer_Port: Integer;
    FSMTPServer_ReplayAddress: string;
    FSMTPServer_SSL: boolean;
    FSMTPServer_UserName: string;
    FOpenSSLPath: string;
    FTlsEngine: string;
    FSkipVerifyToken: boolean;
    FVer: string;
  protected
    constructor CreateInstance;
    class function AccessInstance(Request: Integer): TConfig;
    // Versione, da mostrare in risposta a Ver
  public
    class function Instance: TConfig;
    class procedure ReleaseInstance;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Load;
  published
    property Ver: string read FVer;
    // varie
    property AllowedMethods: string read FAllowedMethods write FAllowedMethods;
    property CartellaFiles: string read FCartellaFiles;
    property Cmd_Enabled: boolean read FCmd_Enabled;
    property Cors: string read FCors write FCors;
    property Dominio: string read FDominio;
    property DominioPwd: string read FDominioPwd;
    property LogoutUrl: string read FLogoutUrl;
    property Metadata: boolean read FMetadata;
    property SP_Whitelist: string read FSP_Whitelist;
    // admin
    property AllowMetaRequest: boolean read FAllowMetaRequest;
    property SkipVerifyToken: boolean read FSkipVerifyToken write FSkipVerifyToken; // modificabile da main
    // db
    property DbServer: string read FDbServer;
    property DataBaseName: string read FDataBaseName;
    property DbUserName: string read FDbUserName;
    property DbPassword: string read FDbPassword;
    property CharacterSet: string read FCharacterSet;
    property ClientLibrary: string read FClientLibrary;
    // SMPTP
    property SMTPServer_SSL: boolean read FSMTPServer_SSL;
    property SMTPServer_Host: string read FSMTPServer_Host;
    property SMTPServer_Port: Integer read FSMTPServer_Port;
    property SMTPServer_UserName: string read FSMTPServer_UserName;
    property SMTPServer_Password: string read FSMTPServer_Password;
    property SMTPServer_ReplayAddress: string read FSMTPServer_ReplayAddress;

    // OpenSSL
    property OpenSSLPath: string read FOpenSSLPath;
    // TLS: motore da usare per tutte le comunicazioni Indy del processo
    // (zNet.Tls.SelezionaProviderTls). Valori accettati oggi: 'OPENSSL',
    // 'SCHANNEL'. Predefinito 'OPENSSL', cosi' un'installazione che
    // aggiorna l'eseguibile senza toccare l'INI mantiene il comportamento
    // di oggi invece di rompersi al primo invio di posta.
    property TlsEngine: string read FTlsEngine;
  end;

function ConfigProps: TConfig;

implementation

uses
  IniFiles,
  zz.INI,
  zz.Folders;

constructor TConfig.Create;
begin
  inherited Create;
  raise Exception.CreateFmt('Access class %s through Instance only', [ClassName]);
end;

constructor TConfig.CreateInstance;
begin
  inherited Create;
  Load;
end;

destructor TConfig.Destroy;
begin
  if AccessInstance(0) = Self then
    AccessInstance(2);
  inherited Destroy;
end;

class function TConfig.AccessInstance(Request: Integer): TConfig;
{$J+}
const
  FInstance: TConfig = nil;
{$J-}
begin
  case Request of
    0:
      ;
    1:
      if not Assigned(FInstance) then
        FInstance := CreateInstance;
    2:
      FInstance := nil;
  else
    raise Exception.CreateFmt('Illegal request %d in AccessInstance', [Request]);
  end;
  Result := FInstance;
end;

class function TConfig.Instance: TConfig;
begin
  Result := AccessInstance(1);
end;

procedure TConfig.Load;
var
  INI: TIniFile;
begin
  INI := TIniFile.Create(TFolders.IniFileName);
  try
    FVer := ReadStringFromIni(INI, 'Application', 'Ver', 'Versione');
    // varie
    FAllowedMethods := ReadStringFromIni(INI, 'Application', 'AllowedMethods', 'GET, POST, PUT');
    FCors := ReadStringFromIni(INI, 'Application', 'Cors', '*');
    FLogoutUrl := ReadStringFromIni(INI, 'Application', 'LogoutUrl', '/login');
    FDominio := ReadStringFromIni(INI, 'Application', 'Dominio', '');
    FDominioPwd := ReadStringFromIni(INI, 'Application', 'DominioPwd', '');
    FMetadata := ReadBoolFromIni(INI, 'Application', 'Metadata', True);
    FCmd_Enabled := ReadBoolFromIni(INI, 'Application', 'Cmd_Enabled', False);
    FSP_Whitelist := ReadStringFromIni(INI, 'Application', 'SP_Whitelist', '');
    FCartellaFiles := ReadStringFromIni(INI, 'Application', 'CartellaFiles', TFolders.WorkingSubFolder(''));
    // Admin
    FAllowMetaRequest := ReadBoolFromIni(INI, 'Admin', 'AllowMetaRequest', False);
    FSkipVerifyToken := ReadBoolFromIni(INI, 'Admin', 'SkipVerifyToken', False);
    // Database
    FDbServer := ReadStringFromIni(INI, 'DataBase', 'dbServer', 'poldo/3053');
    FDataBaseName := ReadStringFromIni(INI, 'DataBase', 'DataBaseName', 's:\Master.fdb');
    FDbUserName := ReadStringFromIni(INI, 'DataBase', 'dbUserName', 'SYSDBA');
    FDbPassword := ReadStringFromIni(INI, 'DataBase', 'dbPassword', 'masterkey');
    FClientLibrary := ReadStringFromIni(INI, 'DataBase', 'ClientLibrary', 'C:\FB_3_64\WOW64\FbClient.dll');
    FCharacterSet := ReadStringFromIni(INI, 'DataBase', 'CharacterSet', 'UTF8');
    // SMTP
    FSMTPServer_SSL := ReadBoolFromIni(INI, 'SMTP', 'SMTP_SSL', False);
    FSMTPServer_Host := ReadStringFromIni(INI, 'SMTP', 'SMTP_Host', 'mail.wintarif.it');
    FSMTPServer_Port := ReadIntegerFromIni(INI, 'SMTP', 'SMTP_Port', 25);
    FSMTPServer_UserName := ReadStringFromIni(INI, 'SMTP', 'SMTP_User', '');
    FSMTPServer_Password := ReadStringFromIni(INI, 'SMTP', 'SMTP_Password', '');
    FSMTPServer_ReplayAddress := ReadStringFromIni(INI, 'SMTP', 'ReplayAddress', 'noreplay@noplay.com');
    // OpenSSL
    FOpenSSLPath := ReadStringFromIni(INI, 'OpenSSL', 'OpenSSLPath', '');
    // TLS
    FTlsEngine := ReadStringFromIni(INI, 'TLS', 'Engine', 'OPENSSL');
  finally
    FreeAndNil(INI);
  end;
end;

class procedure TConfig.ReleaseInstance;
begin
  AccessInstance(0).Free;
end;

function ConfigProps: TConfig;
begin
  Result := TConfig.Instance;
end;

initialization

finalization

TConfig.ReleaseInstance;

end.
