unit zz.web.url;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TUrl = record
  private
    class var _BaseURL: String;
    class var _JWT: string;
    class procedure SetJWT(const Value: string); static;
  public
    class function Ping: string; static;
    class function Ver: string; static;
    class function Login: string; static;
    class function Logout: string; static;
    class function Check_JWT: string; static;
    class function WebConfig: string; static;

    class function RichiestaRegistrazione: string; static;
    class function ComuniAbilitati: string; static;
    class function ConfermaRegistrazione: string; static;
    class function RecuperaUsername: string; static;
    class function RecuperaPassword: string; static;
    class function ModificaPassword: string; static;
  public
    class function DataRequest: string; static;

    class function GetOptions: string; static;
    class function SetOptions: string; static;
    class function GetSql: string; static;
    class function SetSql: string; static;

    class function GetFile: string; static;
    class function DownloadFile: string; static;
    class function UploadFile: string; static;
  public
    class procedure Init(aBaseURL: String); static;
    class property BaseURL: String read _BaseURL write _BaseURL;
    class property JWT: string read _JWT write SetJWT;
  end;

implementation

uses
  System.StrUtils,
  zz.web.JS,
  JS,
  web;

{ TUrl }

class function TUrl.Login: string;
begin
  result := BaseURL + 'login';
end;

class function TUrl.Logout: string;
begin
  result := BaseURL + 'logout';
end;

class function TUrl.ConfermaRegistrazione: string;
begin
  result := BaseURL + 'confermaRegistrazione';
end;

class function TUrl.ModificaPassword: string;
begin
  result := BaseURL + 'modificaPassword';
end;

class function TUrl.Ping: string;
begin
  result := BaseURL + 'ping';
end;

class function TUrl.RecuperaPassword: string;
begin
  result := BaseURL + 'recuperaPassword';
end;

class function TUrl.RecuperaUsername: string;
begin
  result := BaseURL + 'recuperaUsername';
end;

class function TUrl.RichiestaRegistrazione: string;
begin
  result := BaseURL + 'richiestaRegistrazione';
end;

class function TUrl.WebConfig: string;
begin
  result := BaseURL + 'webConfig';
end;

class function TUrl.Check_JWT: string;
begin
  result := BaseURL + 'checkjwt';
end;

class function TUrl.ComuniAbilitati: String;
begin
  result := BaseURL + 'comuniAbilitati';
end;

class function TUrl.DataRequest: string;
begin
  result := BaseURL + 'data';
end;

class function TUrl.DownloadFile: string;
begin
  result := BaseURL + 'download';
end;

class function TUrl.GetFile: string;
begin
  result := BaseURL + 'GetGeDoFile';
end;

class procedure TUrl.Init(aBaseURL: String);
begin
  BaseURL := aBaseURL;

  if not AnsiEndsStr('/', BaseURL) then
    BaseURL := BaseURL + '/';

  JWT := '';
end;

class procedure TUrl.SetJWT(const Value: string);
begin
  _JWT := Value;
end;

class function TUrl.Ver: string;
begin
  result := BaseURL + 'ver';
end;

class function TUrl.GetOptions: string;
begin
  result := BaseURL + 'getOptions';
end;

class function TUrl.SetOptions: string;
begin
  result := BaseURL + 'setOptions';
end;

class function TUrl.GetSql: string;
begin
  result := BaseURL + 'getSql';
end;

class function TUrl.SetSql: string;
begin
  result := BaseURL + 'setSql';
end;

class function TUrl.UploadFile: string;
begin
    result := BaseURL + 'upload';
end;

var
  __url: string;

initialization

__url := JS.ToString(window['_URL']);
TUrl.Init(__url);

end.
