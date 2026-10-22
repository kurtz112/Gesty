// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-22
// ---------------------------------------------------------------------------
unit GoogleCalendar.Autorizzazione;

// Accesso alle API Google per conto dell'utente (OAuth 2.0) per un programma
// desktop, con un client OAuth di tipo "App desktop" creato dal cliente nel suo
// progetto Google Cloud.
//
// Estende TdxGoogleAPIOAuth2AuthorizationAgent di DevExpress, che da solo:
// - manda uno "state" fisso (state_parameter_passthrough_value), quindi non
//   riconosce una risposta che non nasce dalla sua richiesta;
// - sceglie la porta a caso, senza controllare che sia libera;
// - non usa PKCE;
// - usa il vecchio indirizzo dei token (www.googleapis.com/oauth2/v4/token).
// Qui: browser di sistema con risposta su http://127.0.0.1:<porta libera>, PKCE
// con S256, "state" casuale controllato, oauth2.googleapis.com/token.
// Il client secret delle app desktop Google non e' riservato, ma va mandato.

interface

uses
  System.SysUtils,
  System.Classes,
  dxAuthorizationAgents;

type
  TGoogleCalendarAutorizzazione = class(TdxGoogleAPIOAuth2AuthorizationAgent)
  strict private
    FCodeVerifier: string;
    FStato: string;
    FRedirectUriConPorta: string;
    function GetUltimoErrore: string;
  protected
    function CreateAuthorizationForm: TdxCustomAuthorizationForm; override;
    function GetAuthEndPoint: string; override;
    function GetReceiveTokenEndPointParams: string; override;
    function GetRedirectUri: string; override;
    function GetTokenEndPointObjectName: string; override;
    function GetTokenEndPointServerName: string; override;
  public
    // Errore restituito da Google all'ultimo accesso (accesso negato, app non autorizzata...)
    property UltimoErrore: string read GetUltimoErrore;
  end;

implementation

uses
  OAuth2.AccessoDesktop;

const
  // access_type=offline e prompt=consent: Google da' il refresh token solo cosi',
  // anche a chi aveva gia' dato il consenso in passato
  INDIRIZZO_ACCESSO = 'https://accounts.google.com/o/oauth2/v2/auth?' +
    'client_id=%s&' +
    'response_type=code&' +
    'redirect_uri=%s&' +
    'scope=%s&' +
    'code_challenge=%s&' +
    'code_challenge_method=S256&' +
    'state=%s&' +
    'access_type=offline&' +
    'include_granted_scopes=true&' +
    'prompt=select_account%%20consent';

  PARAMETRI_TOKEN =
    'code=%s&' +
    'redirect_uri=%s&' +
    'client_id=%s&' +
    'client_secret=%s&' +
    'grant_type=authorization_code&' +
    'code_verifier=%s';

{ TGoogleCalendarAutorizzazione }

function TGoogleCalendarAutorizzazione.CreateAuthorizationForm: TdxCustomAuthorizationForm;
var
  Finestra: TOAuth2FormAccesso;
begin
  Finestra := TOAuth2FormAccesso.CreateEx;
  Finestra.NomeServizio := 'Google';
  Finestra.StatoAtteso := FStato;
  Result := Finestra;
end;

function TGoogleCalendarAutorizzazione.GetAuthEndPoint: string;
begin
  // ogni accesso ha il suo verificatore PKCE, il suo "state" e la sua porta;
  // Google raccomanda 127.0.0.1 per le app desktop e ignora la porta nel confronto
  FCodeVerifier := TOAuth2Pkce.CasualeBase64Url(32);
  FStato := TOAuth2Pkce.CasualeBase64Url(16);
  FRedirectUriConPorta := Format('http://127.0.0.1:%d', [TOAuth2Pkce.PortaLibera]);

  Result := Format(INDIRIZZO_ACCESSO,
    [EscapeDataString(ClientID), EscapeDataString(FRedirectUriConPorta), GetScopes,
     TOAuth2Pkce.Challenge(FCodeVerifier), FStato]);
end;

function TGoogleCalendarAutorizzazione.GetReceiveTokenEndPointParams: string;
begin
  Result := Format(PARAMETRI_TOKEN,
    [EscapeDataString(AuthorizationCode), EscapeDataString(GetRedirectUri), EscapeDataString(ClientID),
     EscapeDataString(DoGetClientSecret), FCodeVerifier]);
end;

function TGoogleCalendarAutorizzazione.GetRedirectUri: string;
begin
  if FRedirectUriConPorta <> '' then
    Result := FRedirectUriConPorta
  else
    Result := inherited GetRedirectUri;
end;

function TGoogleCalendarAutorizzazione.GetTokenEndPointObjectName: string;
begin
  Result := 'token';
end;

function TGoogleCalendarAutorizzazione.GetTokenEndPointServerName: string;
begin
  Result := 'oauth2.googleapis.com';
end;

function TGoogleCalendarAutorizzazione.GetUltimoErrore: string;
begin
  Result := UltimoErroreAccessoOAuth2;
end;

end.
