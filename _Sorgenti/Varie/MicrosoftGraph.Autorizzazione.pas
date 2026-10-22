// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-22
// ---------------------------------------------------------------------------
unit MicrosoftGraph.Autorizzazione;

// Accesso a Microsoft Graph per conto dell'utente (OAuth 2.0, permessi delegati)
// per un programma desktop registrato dal CED del cliente in Microsoft Entra.
//
// Estende TdxMicrosoftGraphAPIOAuth2AuthorizationAgent di DevExpress, che da solo:
// - usa l'indirizzo "common", rifiutato dalle registrazioni limitate al tenant;
// - manda il client secret quando l'indirizzo di ritorno e' http://...;
// - apre l'accesso in una finestra con il motore di Internet Explorer;
// - non usa PKCE.
// Qui: indirizzi del tenant, nessun segreto, browser di sistema con risposta su
// http://localhost:<porta libera>, PKCE con S256.

interface

uses
  System.SysUtils,
  System.Classes,
  IdContext,
  IdCustomHTTPServer,
  IdHTTPServer,
  Vcl.StdCtrls,
  dxAuthorizationAgents;

type
  // Finestra di attesa mentre l'utente accede nel browser di sistema: riceve la
  // risposta di Microsoft su localhost con un piccolo server HTTP
  TMicrosoftGraphFormAccesso = class(TdxCustomAuthorizationForm)
  strict private
    FServer: TIdHTTPServer;
    FMessaggio: TLabel;
    procedure AvviaServer;
    procedure RichiestaRicevuta(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  protected
    function GetDefaultHeight: Integer; override;
    function GetDefaultWidth: Integer; override;
    procedure Initialize; override;
    procedure Navigate(const AUri: string); override;
  public
    constructor CreateEx; override;
    destructor Destroy; override;
  end;

  TMicrosoftGraphAutorizzazione = class(TdxMicrosoftGraphAPIOAuth2AuthorizationAgent)
  strict private
    FTenantId: string;
    FCodeVerifier: string;
    FRedirectUriConPorta: string;
    function GetUltimoErrore: string;
    class function Base64Url(const Dati: TBytes): string; static;
    class function CasualeBase64Url(const NumeroByte: Integer): string; static;
    class function PortaLibera: Word; static;
  protected
    function CanUseClientSecret: Boolean; override;
    function CreateAuthorizationForm: TdxCustomAuthorizationForm; override;
    function GetAuthEndPoint: string; override;
    function GetReceiveTokenEndPointParams: string; override;
    function GetRedirectUri: string; override;
    function GetTokenEndPointObjectName: string; override;
  public
    // ID tenant (Directory ID) di Microsoft Entra del cliente
    property TenantId: string read FTenantId write FTenantId;
    // Errore restituito da Microsoft all'ultimo accesso (accesso negato, consenso mancante...)
    property UltimoErrore: string read GetUltimoErrore;
  end;

implementation

uses
  Winapi.Windows,
  Winapi.ShellAPI,
  Winapi.Winsock2,
  System.Hash,
  System.NetEncoding,
  Vcl.Controls,
  Vcl.Forms,
  IdGlobal,
  IdSocketHandle;

const
  INDIRIZZO_ACCESSO = 'https://login.microsoftonline.com/%s/oauth2/v2.0/authorize?' +
    'client_id=%s&' +
    'response_type=code&' +
    'response_mode=query&' +
    'redirect_uri=%s&' +
    'scope=%s&' +
    'code_challenge=%s&' +
    'code_challenge_method=S256&' +
    'prompt=select_account';

  PARAMETRI_TOKEN =
    'code=%s&' +
    'redirect_uri=%s&' +
    'client_id=%s&' +
    'scope=%s&' +
    'grant_type=authorization_code&' +
    'code_verifier=%s';

  BCRYPT_USE_SYSTEM_PREFERRED_RNG = $00000002;

function BCryptGenRandom(hAlgorithm: THandle; pbBuffer: PByte; cbBuffer: ULONG; dwFlags: ULONG): Integer; stdcall; external 'bcrypt.dll';

var
  // scritto dal thread del server HTTP, letto dopo la chiusura della finestra
  ErroreAccesso: string;

{ TMicrosoftGraphFormAccesso }

constructor TMicrosoftGraphFormAccesso.CreateEx;
begin
  inherited CreateEx;
  BorderStyle := bsDialog;
  Position := poScreenCenter;
  Caption := 'Accesso a Microsoft 365';

  FServer := TIdHTTPServer.Create(Self);
  FServer.OnCommandGet := RichiestaRicevuta;
end;

destructor TMicrosoftGraphFormAccesso.Destroy;
begin
  if Assigned(FServer) then
    FServer.Active := False;
  FreeAndNil(FServer);
  inherited Destroy;
end;

function TMicrosoftGraphFormAccesso.GetDefaultHeight: Integer;
begin
  Result := 160;
end;

function TMicrosoftGraphFormAccesso.GetDefaultWidth: Integer;
begin
  Result := 460;
end;

procedure TMicrosoftGraphFormAccesso.Initialize;
begin
  inherited Initialize;

  FMessaggio := TLabel.Create(Self);
  FMessaggio.Parent := Self;
  FMessaggio.AlignWithMargins := True;
  FMessaggio.Margins.SetBounds(16, 16, 16, 16);
  FMessaggio.Align := alClient;
  FMessaggio.WordWrap := True;
  FMessaggio.Caption := 'Completa l''accesso con il tuo account Microsoft 365 nella pagina che si ' +
    #232' aperta nel browser.' + sLineBreak + sLineBreak +
    'Questa finestra si chiude da sola ad accesso completato. Per rinunciare, chiudila.';
end;

procedure TMicrosoftGraphFormAccesso.AvviaServer;
var
  Porta: Integer;
  Posizione: Integer;
  Binding: TIdSocketHandle;
begin
  // FRedirectUri e' http://localhost:<porta>
  Posizione := FRedirectUri.LastIndexOf(':');
  Porta := StrToInt(FRedirectUri.Substring(Posizione + 1));

  // solo indirizzi locali, IPv4 e IPv6: "localhost" il browser puo' risolverlo in tutti e due
  Binding := FServer.Bindings.Add;
  Binding.IP := '127.0.0.1';
  Binding.Port := Porta;
  Binding.IPVersion := Id_IPv4;

  Binding := FServer.Bindings.Add;
  Binding.IP := '::1';
  Binding.Port := Porta;
  Binding.IPVersion := Id_IPv6;

  try
    FServer.Active := True;
  except
    // macchina senza IPv6: basta IPv4
    FServer.Active := False;
    FServer.Bindings.Delete(1);
    FServer.Active := True;
  end;
end;

procedure TMicrosoftGraphFormAccesso.Navigate(const AUri: string);
begin
  ErroreAccesso := '';

  // il server ascolta prima di aprire il browser: con l'accesso automatico
  // (Windows gia' collegato a Microsoft 365) la risposta arriva subito
  AvviaServer;
  ShellExecute(0, 'open', PChar(AUri), nil, nil, SW_SHOWNORMAL);
end;

procedure TMicrosoftGraphFormAccesso.RichiestaRicevuta(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  Parametri: string;
  Indirizzo: string;
  Completo: Boolean;
  Errore: string;
begin
  Parametri := ARequestInfo.UnparsedParams;

  // il browser chiede anche altro (favicon.ico): conta solo la risposta di Microsoft
  if FComplete or not (Parametri.Contains('code=') or Parametri.Contains('error=')) then
  begin
    AResponseInfo.ResponseNo := 404;
    Exit;
  end;

  if Parametri.Contains('error=') then
  begin
    Errore := ARequestInfo.Params.Values['error_description'];
    if Errore = '' then
      Errore := ARequestInfo.Params.Values['error'];
    ErroreAccesso := Errore;
  end;

  Indirizzo := FRedirectUri + '?' + Parametri;
  Completo := False;

  // OnComplete legge il codice e lo passa all'agente: si esegue nel thread principale
  TThread.Synchronize(nil,
    procedure
    begin
      if Assigned(OnComplete) then
        OnComplete(Indirizzo, Completo);
    end);

  AResponseInfo.ContentType := 'text/html';
  AResponseInfo.CharSet := 'utf-8';
  if Completo and (ErroreAccesso = '') then
    AResponseInfo.ContentText := '<html><body style="font-family:sans-serif">' +
      '<h3>Accesso completato</h3><p>Puoi chiudere questa scheda e tornare a Gesty.</p></body></html>'
  else
    AResponseInfo.ContentText := '<html><body style="font-family:sans-serif">' +
      '<h3>Accesso non riuscito</h3><p>Torna a Gesty per i dettagli.</p></body></html>';

  if Completo then
    TThread.Queue(nil,
      procedure
      begin
        FComplete := True;
        DoComplete;
      end);
end;

{ TMicrosoftGraphAutorizzazione }

class function TMicrosoftGraphAutorizzazione.Base64Url(const Dati: TBytes): string;
var
  Codifica: TBase64Encoding;
begin
  // Base64 senza a capo, con l'alfabeto per gli indirizzi e senza "=" in coda (RFC 7636)
  Codifica := TBase64Encoding.Create(0);
  try
    Result := Codifica.EncodeBytesToString(Dati);
  finally
    Codifica.Free;
  end;
  Result := Result.Replace('+', '-').Replace('/', '_').TrimRight(['=']);
end;

class function TMicrosoftGraphAutorizzazione.CasualeBase64Url(const NumeroByte: Integer): string;
var
  Dati: TBytes;
begin
  SetLength(Dati, NumeroByte);
  if BCryptGenRandom(0, @Dati[0], NumeroByte, BCRYPT_USE_SYSTEM_PREFERRED_RNG) <> 0 then
    raise Exception.Create('Generatore di numeri casuali di Windows non disponibile');
  Result := Base64Url(Dati);
end;

class function TMicrosoftGraphAutorizzazione.PortaLibera: Word;
var
  Dati: TWSAData;
  Presa: TSocket;
  Indirizzo: TSockAddrIn;
  Lunghezza: Integer;
begin
  // si chiede a Windows una porta libera legandosi alla porta 0
  if WSAStartup($0202, Dati) <> 0 then
    raise Exception.Create('Winsock non disponibile');
  try
    Presa := socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    if Presa = INVALID_SOCKET then
      raise Exception.Create('Impossibile aprire una porta locale per l''accesso a Microsoft 365');
    try
      FillChar(Indirizzo, SizeOf(Indirizzo), 0);
      Indirizzo.sin_family := AF_INET;
      Indirizzo.sin_addr.S_addr := htonl($7F000001);
      Indirizzo.sin_port := 0;
      if bind(Presa, PSockAddr(@Indirizzo)^, SizeOf(Indirizzo)) <> 0 then
        raise Exception.Create('Impossibile aprire una porta locale per l''accesso a Microsoft 365');

      Lunghezza := SizeOf(Indirizzo);
      if getsockname(Presa, PSockAddr(@Indirizzo)^, Lunghezza) <> 0 then
        raise Exception.Create('Impossibile aprire una porta locale per l''accesso a Microsoft 365');

      Result := ntohs(Indirizzo.sin_port);
    finally
      closesocket(Presa);
    end;
  finally
    WSACleanup;
  end;
end;

function TMicrosoftGraphAutorizzazione.CanUseClientSecret: Boolean;
begin
  // applicazione pubblica: nessun segreto, anche con ritorno su http://localhost
  Result := False;
end;

function TMicrosoftGraphAutorizzazione.CreateAuthorizationForm: TdxCustomAuthorizationForm;
begin
  // browser di sistema e risposta su localhost, invece del motore di Internet Explorer
  Result := TMicrosoftGraphFormAccesso.CreateEx;
end;

function TMicrosoftGraphAutorizzazione.GetAuthEndPoint: string;
var
  Challenge: string;
begin
  // ogni accesso ha il suo verificatore PKCE e la sua porta
  FCodeVerifier := CasualeBase64Url(32);
  Challenge := Base64Url(THashSHA2.GetHashBytes(FCodeVerifier, THashSHA2.TSHA2Version.SHA256));
  FRedirectUriConPorta := Format('http://localhost:%d', [PortaLibera]);

  Result := Format(INDIRIZZO_ACCESSO,
    [EscapeDataString(TenantId), EscapeDataString(ClientID), EscapeDataString(FRedirectUriConPorta), GetScopes, Challenge]);
end;

function TMicrosoftGraphAutorizzazione.GetReceiveTokenEndPointParams: string;
begin
  Result := Format(PARAMETRI_TOKEN,
    [EscapeDataString(AuthorizationCode), EscapeDataString(GetRedirectUri), EscapeDataString(ClientID), GetScopes, FCodeVerifier]);
end;

function TMicrosoftGraphAutorizzazione.GetRedirectUri: string;
begin
  // la finestra di accesso e il controllo della risposta usano l'indirizzo con la porta;
  // la proprieta' RedirectUri resta http://localhost, quello registrato dal CED
  if FRedirectUriConPorta <> '' then
    Result := FRedirectUriConPorta
  else
    Result := inherited GetRedirectUri;
end;

function TMicrosoftGraphAutorizzazione.GetTokenEndPointObjectName: string;
begin
  Result := TenantId + '/oauth2/v2.0/token';
end;

function TMicrosoftGraphAutorizzazione.GetUltimoErrore: string;
begin
  Result := ErroreAccesso;
end;

end.
