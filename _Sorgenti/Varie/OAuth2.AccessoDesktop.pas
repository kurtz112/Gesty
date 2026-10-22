// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-22
// ---------------------------------------------------------------------------
unit OAuth2.AccessoDesktop;

// Parti comuni dell'accesso OAuth 2.0 di un programma desktop per conto
// dell'utente (Microsoft 365, Google), sopra gli agenti di DevExpress:
// - TOAuth2FormAccesso: apre la pagina di accesso nel browser di sistema e
//   riceve la risposta su http://localhost:<porta libera> con un piccolo server
//   HTTP, invece della finestra con il motore di Internet Explorer;
// - TOAuth2Pkce: verificatore e challenge PKCE (S256), valore casuale per
//   "state", porta locale libera;
// - AccediOAuth2 e TokenAccessoOAuth2: accesso con il refresh token salvato e,
//   se non basta, nel browser; token valido per le chiamate.

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
  // Finestra di attesa mentre l'utente accede nel browser di sistema
  TOAuth2FormAccesso = class(TdxCustomAuthorizationForm)
  strict private
    FServer: TIdHTTPServer;
    FMessaggio: TLabel;
    FNomeServizio: string;
    FStatoAtteso: string;
    procedure SetNomeServizio(const Valore: string);
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
    // nome del servizio nei testi della finestra: "Microsoft 365", "Google"
    property NomeServizio: string read FNomeServizio write SetNomeServizio;
    // valore di "state" mandato nella richiesta: una risposta con un altro valore si scarta
    property StatoAtteso: string read FStatoAtteso write FStatoAtteso;
  end;

  TOAuth2Pkce = class
  public
    // Base64 senza a capo, con l'alfabeto per gli indirizzi e senza "=" in coda (RFC 7636)
    class function Base64Url(const Dati: TBytes): string; static;
    class function CasualeBase64Url(const NumeroByte: Integer): string; static;
    class function Challenge(const Verificatore: string): string; static;
    // porta TCP libera su 127.0.0.1, scelta da Windows
    class function PortaLibera: Word; static;
  end;

// Errore restituito dal servizio all'ultimo accesso nel browser (accesso negato, consenso mancante...)
function UltimoErroreAccessoOAuth2: string;

// Prima il refresh token salvato (niente browser se e' ancora valido); poi, solo
// se Interattiva, l'accesso nel browser. Errore: testo per l'utente.
function AccediOAuth2(Agente: TdxOAuth2AuthorizationAgent; const RefreshToken: string; const Interattiva: Boolean;
  const NomeServizio: string; out Errore: string): Boolean;

// Token per le chiamate, rinnovato se e' scaduto (dura circa un'ora)
function TokenAccessoOAuth2(Agente: TdxOAuth2AuthorizationAgent; const NomeServizio: string): string;

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
  BCRYPT_USE_SYSTEM_PREFERRED_RNG = $00000002;

function BCryptGenRandom(hAlgorithm: THandle; pbBuffer: PByte; cbBuffer: ULONG; dwFlags: ULONG): Integer; stdcall; external 'bcrypt.dll';

var
  // scritto dal thread del server HTTP, letto dopo la chiusura della finestra
  ErroreAccesso: string;

function UltimoErroreAccessoOAuth2: string;
begin
  Result := ErroreAccesso;
end;

function AccediOAuth2(Agente: TdxOAuth2AuthorizationAgent; const RefreshToken: string; const Interattiva: Boolean;
  const NomeServizio: string; out Errore: string): Boolean;
begin
  Result := False;
  Errore := '';

  if RefreshToken <> '' then
  begin
    Agente.Load('', RefreshToken, 'Bearer');
    if Agente.RefreshAccessToken then
    begin
      Agente.StartAuthorization;
      if Agente.IsAuthorized then
        Exit(True);
    end;
  end;

  if not Interattiva then
  begin
    Errore := Format('L''accesso a %s va rinnovato: usa il pulsante di sincronizzazione nell''agenda.', [NomeServizio]);
    Exit;
  end;

  Agente.FinishAuthorization;
  Agente.StartAuthorization;
  Result := Agente.IsAuthorized;

  if not Result then
  begin
    if UltimoErroreAccessoOAuth2 <> '' then
      Errore := Format('Accesso a %s non riuscito: %s', [NomeServizio, UltimoErroreAccessoOAuth2])
    else
      Errore := Format('Accesso a %s non completato.', [NomeServizio]);
  end;
end;

function TokenAccessoOAuth2(Agente: TdxOAuth2AuthorizationAgent; const NomeServizio: string): string;
begin
  Agente.ValidateAccessToken;
  if Agente.AccessToken = '' then
    raise Exception.CreateFmt('Accesso a %s scaduto: rifai la sincronizzazione dall''agenda', [NomeServizio]);
  Result := Agente.AccessToken;
end;

{ TOAuth2FormAccesso }

constructor TOAuth2FormAccesso.CreateEx;
begin
  inherited CreateEx;
  BorderStyle := bsDialog;
  Position := poScreenCenter;

  FServer := TIdHTTPServer.Create(Self);
  FServer.OnCommandGet := RichiestaRicevuta;
end;

destructor TOAuth2FormAccesso.Destroy;
begin
  if Assigned(FServer) then
    FServer.Active := False;
  FreeAndNil(FServer);
  inherited Destroy;
end;

function TOAuth2FormAccesso.GetDefaultHeight: Integer;
begin
  Result := 160;
end;

function TOAuth2FormAccesso.GetDefaultWidth: Integer;
begin
  Result := 460;
end;

procedure TOAuth2FormAccesso.Initialize;
begin
  inherited Initialize;

  FMessaggio := TLabel.Create(Self);
  FMessaggio.Parent := Self;
  FMessaggio.AlignWithMargins := True;
  FMessaggio.Margins.SetBounds(16, 16, 16, 16);
  FMessaggio.Align := alClient;
  FMessaggio.WordWrap := True;
  NomeServizio := 'Microsoft 365';
end;

procedure TOAuth2FormAccesso.SetNomeServizio(const Valore: string);
begin
  FNomeServizio := Valore;
  Caption := 'Accesso a ' + Valore;
  FMessaggio.Caption := Format('Completa l''accesso con il tuo account %s nella pagina che si ' +
    #232' aperta nel browser.', [Valore]) + sLineBreak + sLineBreak +
    'Questa finestra si chiude da sola ad accesso completato. Per rinunciare, chiudila.';
end;

procedure TOAuth2FormAccesso.AvviaServer;
var
  Porta: Integer;
  Posizione: Integer;
  Binding: TIdSocketHandle;
begin
  // FRedirectUri e' http://localhost:<porta> oppure http://127.0.0.1:<porta>
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

procedure TOAuth2FormAccesso.Navigate(const AUri: string);
begin
  ErroreAccesso := '';

  // il server ascolta prima di aprire il browser: con l'accesso automatico
  // (Windows gia' collegato all'account) la risposta arriva subito
  AvviaServer;
  ShellExecute(0, 'open', PChar(AUri), nil, nil, SW_SHOWNORMAL);
end;

procedure TOAuth2FormAccesso.RichiestaRicevuta(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  Parametri: string;
  Indirizzo: string;
  Completo: Boolean;
  Errore: string;
begin
  Parametri := ARequestInfo.UnparsedParams;

  // il browser chiede anche altro (favicon.ico): conta solo la risposta del servizio
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

  // una risposta che non porta lo "state" mandato non nasce dalla richiesta di Gesty:
  // si completa senza codice, cosi' l'accesso fallisce
  if (FStatoAtteso <> '') and (ErroreAccesso = '') and (ARequestInfo.Params.Values['state'] <> FStatoAtteso) then
  begin
    ErroreAccesso := 'risposta di accesso non valida';
    Parametri := 'error=state';
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

{ TOAuth2Pkce }

class function TOAuth2Pkce.Base64Url(const Dati: TBytes): string;
var
  Codifica: TBase64Encoding;
begin
  Codifica := TBase64Encoding.Create(0);
  try
    Result := Codifica.EncodeBytesToString(Dati);
  finally
    Codifica.Free;
  end;
  Result := Result.Replace('+', '-').Replace('/', '_').TrimRight(['=']);
end;

class function TOAuth2Pkce.CasualeBase64Url(const NumeroByte: Integer): string;
var
  Dati: TBytes;
begin
  SetLength(Dati, NumeroByte);
  if BCryptGenRandom(0, @Dati[0], NumeroByte, BCRYPT_USE_SYSTEM_PREFERRED_RNG) <> 0 then
    raise Exception.Create('Generatore di numeri casuali di Windows non disponibile');
  Result := Base64Url(Dati);
end;

class function TOAuth2Pkce.Challenge(const Verificatore: string): string;
begin
  Result := Base64Url(THashSHA2.GetHashBytes(Verificatore, THashSHA2.TSHA2Version.SHA256));
end;

class function TOAuth2Pkce.PortaLibera: Word;
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
      raise Exception.Create('Impossibile aprire una porta locale per l''accesso');
    try
      FillChar(Indirizzo, SizeOf(Indirizzo), 0);
      Indirizzo.sin_family := AF_INET;
      Indirizzo.sin_addr.S_addr := htonl($7F000001);
      Indirizzo.sin_port := 0;
      if bind(Presa, PSockAddr(@Indirizzo)^, SizeOf(Indirizzo)) <> 0 then
        raise Exception.Create('Impossibile aprire una porta locale per l''accesso');

      Lunghezza := SizeOf(Indirizzo);
      if getsockname(Presa, PSockAddr(@Indirizzo)^, Lunghezza) <> 0 then
        raise Exception.Create('Impossibile aprire una porta locale per l''accesso');

      Result := ntohs(Indirizzo.sin_port);
    finally
      closesocket(Presa);
    end;
  finally
    WSACleanup;
  end;
end;

end.
