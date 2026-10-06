unit GestyTools.GDrive;

interface

uses
  System.SysUtils,
  System.Classes,
  cxClasses,
  dxCloudStorage,
  dxAuthorizationAgents;

type
  TGDrive = class(TDataModule)
    dxCloudStorage: TdxCloudStorage;
    dxGoogleAPIOAuth2AuthorizationAgent: TdxGoogleAPIOAuth2AuthorizationAgent;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
    constructor Create(aOwner: TComponent); override;

    procedure Connect;
    function DownloadFile(const AFileName, DestFileName: string; AProgressCallback: TdxCloudStorageFileProgressCallback = nil): Boolean;
    function UploadFile(const ATargetPath, AFileName: string; AProgressCallback: TdxCloudStorageFileProgressCallback = nil; AOverwriteIfExists: Boolean = True): TdxCloudStorageFile;
  end;

var
  GDrive: TGDrive;

implementation

uses
  GestyTools.Config;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

constructor TGDrive.Create(aOwner: TComponent);
begin
  inherited;
  Config.Load;

  dxGoogleAPIOAuth2AuthorizationAgent.ClientId := Config.ClientId;
  dxGoogleAPIOAuth2AuthorizationAgent.ClientSecret := Config.ClientSecret;

end;

procedure TGDrive.DataModuleCreate(Sender: TObject);
begin

end;

{ TGDrive }

procedure TGDrive.Connect;
begin

  if dxCloudStorage.Connected then
    exit;

  if not Config.AccessToken.IsEmpty then
    dxGoogleAPIOAuth2AuthorizationAgent.Load(Config.AccessToken, Config.RefreshToken, Config.TokenType);

  dxCloudStorage.Connected := True;

  if (Config.AccessToken <> dxGoogleAPIOAuth2AuthorizationAgent.AccessToken) or (Config.RefreshToken <> dxGoogleAPIOAuth2AuthorizationAgent.RefreshToken) or
    (Config.TokenType <> dxGoogleAPIOAuth2AuthorizationAgent.AccessTokenType) then
  begin
    Config.AccessToken := dxGoogleAPIOAuth2AuthorizationAgent.AccessToken;
    Config.RefreshToken := dxGoogleAPIOAuth2AuthorizationAgent.RefreshToken;
    Config.TokenType := dxGoogleAPIOAuth2AuthorizationAgent.AccessTokenType;
    Config.Save;
  end;
end;

function TGDrive.DownloadFile(const AFileName, DestFileName: string; AProgressCallback: TdxCloudStorageFileProgressCallback): Boolean;
var
  stream: TFileStream;
begin
  Connect;

  stream := TFileStream.Create(DestFileName, fmCreate);
  try
    result := dxCloudStorage.DownloadFile(AFileName, stream, AProgressCallback);
  finally
    FreeAndNil(stream);
  end;
end;

function TGDrive.UploadFile(const ATargetPath, AFileName: string; AProgressCallback: TdxCloudStorageFileProgressCallback; AOverwriteIfExists: Boolean): TdxCloudStorageFile;
begin
  Connect;

  result := dxCloudStorage.UploadFile(ATargetPath, AFileName, AProgressCallback, AOverwriteIfExists);
end;

end.
