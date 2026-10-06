unit lib.JWT;

interface

uses
  System.Classes,
  System.SysUtils,
  System.DateUtils,
  Web.HTTPApp,
  lib.Context;

function CreateToken(const App, Username, Password, ConnectionName: String; const UserID, idSessione: integer): string;
function VerifyRequest(var Context: TzContext; out error: string): boolean; overload;
function VerifyRequest(var Context: TzContext): boolean; overload;

implementation

uses
  JOSE.Core.JWT,
  JOSE.Core.JWS,
  JOSE.Core.JWK,
  JOSE.Core.JWA,
  JOSE.Types.JSON,
  JOSE.Core.Builder,
  JOSE.Encoding.Base64,
  lib.Consts,
  zz.SmartInspect;

type
  TClaims = class(TJWTClaims)
  private
    function GetApp: String;
    function GetConnectionName: string;
    function GetPassword: string;
    function GetSessionID: integer;
    function GetUserID: integer;
    function GetUsername: string;
    procedure SetApp(const Value: String);
    procedure SetConnectionName(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetSessionID(const Value: integer);
    procedure SetUserID(const Value: integer);
    procedure SetUsername(const Value: string);
  public
    property App: String read GetApp write SetApp;
    property SessionID: integer read GetSessionID write SetSessionID;
    property UserID: integer read GetUserID write SetUserID;
    property Username: string read GetUsername write SetUsername;
    property Password: string read GetPassword write SetPassword;
    property ConnectionName: string read GetConnectionName write SetConnectionName;
  end;

function CreateKey: TJWK;
const
  pwd = '{9A1FE2D7-ED61-4FA0-9650-D6908C8F93DB}';
begin
  result := TJWK.Create(pwd);
end;

function CalcExpiration(const App: string): TDateTime;
var
  h: Word;
begin

  if SameText(App, 'RICICLARIO') then
    result := EncodeDateTime(9999, 12, 31, 23, 59, 59, 0)
  else
  begin // WTWEB_CITTADINO, WTWEB_SPORTELLO, GECO, etc
    result := Tomorrow;

    h := HourOf(date); // ora attuale

    if h < 18 then // cittadini: se loggano a sera gli si da lo stesso un tot di ore
      result := RecodeHour(result, 0)
    else
      result := RecodeHour(result, 6);

    result := RecodeMinute(result, 00);
    result := RecodeSecond(result, 01);
  end;
end;

function CreateToken(const App, Username, Password, ConnectionName: String; const UserID, idSessione: integer): string;
var
  JWT: TJWT;
  Key: TJWK;
  Signer: TJWS;
  Claims: TClaims;
begin
  result := '';

  JWT := TJWT.Create(TClaims);
  try
    JWT.Header.HeaderType := 'JWT';
    JWT.Header.Algorithm := 'HS256';

    Claims := JWT.Claims as TClaims;
    Claims.Issuer := 'Gesty Server';
    Claims.App := App;
    Claims.Username := Username;
    Claims.Password := Password;
    Claims.ConnectionName := ConnectionName;
    Claims.UserID := UserID;
    Claims.SessionID := idSessione;
    Claims.IssuedAt := now;
    Claims.Expiration := CalcExpiration(App);

    Signer := TJWS.Create(JWT);
    try
      Key := CreateKey;
      try
        Signer.Sign(Key, TJOSEAlgorithmId.HS256);
        result := Signer.CompactToken;
      finally
        Key.Free;
      end;
    finally
      Signer.Free;
    end;
  finally
    JWT.Free;
  end;
end;

function VerifyRequest(var Context: TzContext; out error: string): boolean;
var
  s: string;
  token: TJWT;
  Key: TJWK;
  WtClaims: TClaims;
  Expiration: TDateTime;

  function Verifica(Key: TJWK; s: string): TJWT;
  begin
    try
      result := TJOSE.Verify(Key, s);
    except
      on e: exception do
      begin
        simain.LogError('Errore JWT: ' + s);
        simain.LogError('Errore JWT: ' + Context.Request.PathInfo);
        raise;
      end;
    end;
  end;

begin

  error := '';
  result := False;
  try
    if Context.Request.Authorization.ToLower.StartsWith('bearer ') then
      s := Context.Request.Authorization.Replace('bearer ', '', [rfIgnoreCase]);

      { TODO : TODO: recuperare da TMainForm.DoParseAuthentication}

    // togliere ----------------------------------------
    if s = '' then
      s := Context.Request.GetFieldByName(ident_JWT);

    if s = '' then
      s := Context.Request.ContentFields.Values[ident_JWT];

    if s = '' then
      s := Context.Request.QueryFields.Values[ident_JWT];
    // \togliere ---------------------------------------

    if s = '' then
    begin
      error := 'Token jwt non specificato.';
      simain.LogError(error);
      Exit(False);
    end;

    Key := CreateKey;
    try
      token := Verifica(Key, s);
      try
        result := Assigned(token) and (token.Verified);

        if not result then
        begin
          error := 'Token jwt non valido.';
          simain.LogError(error);
          Exit(False);
        end;

        simain.LogString('JWT.Payload', token.Claims.JSON.ToString);

        Context.App := TJSONUtils.GetJSONValue('App', token.Claims.JSON).AsString;
        Context.Username := TJSONUtils.GetJSONValue('Username', token.Claims.JSON).AsString;
        Context.Password := TJSONUtils.GetJSONValue('Password', token.Claims.JSON).AsString;
        Context.ConnectionName := TJSONUtils.GetJSONValue('ConnectionName', token.Claims.JSON).AsString;

        s := TJSONUtils.GetJSONValue('UserID', token.Claims.JSON).ToString;
        Context.UserID := s.ToInteger();

        s := TJSONUtils.GetJSONValue('SessionID', token.Claims.JSON).ToString;
        Context.SessionID := s.ToInteger();

        if False then
        begin
          try // dxFileUploader da un ' No mapping for the Unicode character exists in the target multi-byte code page'
            simain.LogBoolean('Verificato', result);
            simain.LogString('Claims', token.Claims.JSON.ToString);
            simain.LogString('App', Context.App);
            simain.LogString('Username', Context.Username);
            simain.LogInteger('UserID - JWT', Context.UserID);
            simain.LogString('UserID - Request', Context.Request.ContentFields.Values[ident_UserId]);
            simain.LogString('Password', Context.Password);
            simain.LogString('ConnectionName', Context.ConnectionName);
            simain.LogInteger('SessionID', Context.SessionID);
          except
          end;
        end;

        // verificare la scadenza
        if result then
        begin
          Expiration := token.Claims.Expiration;

          if Expiration < now then
          begin
            simain.LogDateTime('Expiration', Expiration);
            error := 'Sessione Scaduta.';
            simain.LogError(error);
            Exit(False);
          end;
        end;

        // WtClaims := token.Claims as TWtClaims;
        // Request.ContentFields.Values[ident_JWT_User] := WtClaims.Username;
        // Request.ContentFields.Values[ident_JWT_Session] := WtClaims.SessionID.ToString;
        Context.Request.ContentFields.Values[ident_JWT_User] := Context.Username;

        if Context.Request.ContentFields.Values[ident_UserId].IsEmpty then // caso Modifica Password di geco: passa l'id come parametro, non c'è nel jwt
          Context.Request.ContentFields.Values[ident_UserId] := Context.UserID.ToString;

        Context.Request.ContentFields.Values[ident_JWT_Session] := Context.SessionID.ToString;
        Context.Request.ContentFields.Values[ident_ID_SESSIONE] := Context.SessionID.ToString;
      finally
        token.Free;
      end;
    finally
      Key.Free;
    end;
  except
    on e: exception do
    begin
      simain.LogException(e);
      Exit(False);
    end;
  end;
end;

function VerifyRequest(var Context: TzContext): boolean;
var
  error: string;
begin
  result := VerifyRequest(Context, error);
end;

function TClaims.GetApp: String;
begin
  result := TJSONUtils.GetJSONValue('App', FJSON).AsString;
end;

function TClaims.GetConnectionName: string;
begin
  result := TJSONUtils.GetJSONValue('ConnectionName', FJSON).AsString;
end;

function TClaims.GetPassword: string;
begin
  result := TJSONUtils.GetJSONValue('Password', FJSON).AsString;
end;

function TClaims.GetSessionID: integer;
begin
  result := TJSONUtils.GetJSONValue('SessionID', FJSON).AsInteger;
end;

function TClaims.GetUserID: integer;
begin
  result := TJSONUtils.GetJSONValue('UserID', FJSON).AsInteger;
end;

function TClaims.GetUsername: string;
begin
  result := TJSONUtils.GetJSONValue('Username', FJSON).AsString;
end;

procedure TClaims.SetApp(const Value: String);
begin
  TJSONUtils.SetJSONValueFrom<string>('App', Value, FJSON);
end;

procedure TClaims.SetConnectionName(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('ConnectionName', Value, FJSON);
end;

procedure TClaims.SetPassword(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('Password', Value, FJSON);
end;

procedure TClaims.SetSessionID(const Value: integer);
begin
  TJSONUtils.SetJSONValueFrom<integer>('SessionID', Value, FJSON);
end;

procedure TClaims.SetUserID(const Value: integer);
begin
  TJSONUtils.SetJSONValueFrom<integer>('UserID', Value, FJSON);
end;

procedure TClaims.SetUsername(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('Username', Value, FJSON);
end;

end.

zoffice.word.form
