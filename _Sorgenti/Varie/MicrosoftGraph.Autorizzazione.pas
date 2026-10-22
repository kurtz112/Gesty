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
// http://localhost:<porta libera>, PKCE con S256, "state" controllato.
// La finestra di accesso e PKCE stanno in OAuth2.AccessoDesktop, comuni a Google.

interface

uses
  System.SysUtils,
  System.Classes,
  dxAuthorizationAgents;

type
  TMicrosoftGraphAutorizzazione = class(TdxMicrosoftGraphAPIOAuth2AuthorizationAgent)
  strict private
    FTenantId: string;
    FCodeVerifier: string;
    FStato: string;
    FRedirectUriConPorta: string;
    function GetUltimoErrore: string;
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
  OAuth2.AccessoDesktop;

const
  INDIRIZZO_ACCESSO = 'https://login.microsoftonline.com/%s/oauth2/v2.0/authorize?' +
    'client_id=%s&' +
    'response_type=code&' +
    'response_mode=query&' +
    'redirect_uri=%s&' +
    'scope=%s&' +
    'code_challenge=%s&' +
    'code_challenge_method=S256&' +
    'state=%s&' +
    'prompt=select_account';

  PARAMETRI_TOKEN =
    'code=%s&' +
    'redirect_uri=%s&' +
    'client_id=%s&' +
    'scope=%s&' +
    'grant_type=authorization_code&' +
    'code_verifier=%s';

{ TMicrosoftGraphAutorizzazione }

function TMicrosoftGraphAutorizzazione.CanUseClientSecret: Boolean;
begin
  // applicazione pubblica: nessun segreto, anche con ritorno su http://localhost
  Result := False;
end;

function TMicrosoftGraphAutorizzazione.CreateAuthorizationForm: TdxCustomAuthorizationForm;
var
  Finestra: TOAuth2FormAccesso;
begin
  // browser di sistema e risposta su localhost, invece del motore di Internet Explorer
  Finestra := TOAuth2FormAccesso.CreateEx;
  Finestra.NomeServizio := 'Microsoft 365';
  Finestra.StatoAtteso := FStato;
  Result := Finestra;
end;

function TMicrosoftGraphAutorizzazione.GetAuthEndPoint: string;
begin
  // ogni accesso ha il suo verificatore PKCE, il suo "state" e la sua porta
  FCodeVerifier := TOAuth2Pkce.CasualeBase64Url(32);
  FStato := TOAuth2Pkce.CasualeBase64Url(16);
  FRedirectUriConPorta := Format('http://localhost:%d', [TOAuth2Pkce.PortaLibera]);

  Result := Format(INDIRIZZO_ACCESSO,
    [EscapeDataString(TenantId), EscapeDataString(ClientID), EscapeDataString(FRedirectUriConPorta), GetScopes,
     TOAuth2Pkce.Challenge(FCodeVerifier), FStato]);
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
  Result := UltimoErroreAccessoOAuth2;
end;

end.
