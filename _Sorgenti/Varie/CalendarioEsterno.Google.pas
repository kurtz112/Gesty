// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-22
// ---------------------------------------------------------------------------
unit CalendarioEsterno.Google;

// Google Calendar come ICalendarioEsterno: unisce l'accesso
// (GoogleCalendar.Autorizzazione) e le chiamate al calendario
// (GoogleCalendar.Calendario). Permessi: openid ed email (per il controllo
// dell'account) e calendar.events (eventi dei calendari dell'utente).

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  CalendarioEsterno.Types,
  GoogleCalendar.Autorizzazione,
  GoogleCalendar.Calendario;

type
  TCalendarioEsternoGoogle = class(TInterfacedObject, ICalendarioEsterno)
  strict private
    FAutorizzazione: TGoogleCalendarAutorizzazione;
    FCalendario: TGoogleCalendarCalendario;
    FIdCalendario: string;
    function LeggiToken: string;
  public
    // IdCalendario vuoto = calendario principale dell'account
    constructor Create(const ClientId, ClientSecret, IdCalendario: string);
    destructor Destroy; override;

    function NomeServizio: string;
    function Accedi(const RefreshToken: string; const Interattiva: Boolean; out Errore: string): Boolean;
    function RefreshToken: string;
    function Profilo: TProfiloEsterno;
    procedure LeggiModifiche(var Stato: string; const Dal, Al: TDate; Eventi: TList<TEventoEsterno>);
    function CreaEvento(const Evento: TEventoEsterno): TEventoEsterno;
    function AggiornaEvento(const Evento: TEventoEsterno; const ConNote: Boolean): TEventoEsterno;
    function EliminaEvento(const Id: string): Boolean;
  end;

implementation

uses
  OAuth2.AccessoDesktop;

{ TCalendarioEsternoGoogle }

constructor TCalendarioEsternoGoogle.Create(const ClientId, ClientSecret, IdCalendario: string);
begin
  inherited Create;
  FIdCalendario := IdCalendario;

  FAutorizzazione := TGoogleCalendarAutorizzazione.Create(nil);
  FAutorizzazione.ClientID := ClientId;
  FAutorizzazione.ClientSecret := ClientSecret;
  FAutorizzazione.AdditionalScopes.Text := 'openid' + sLineBreak + 'email' + sLineBreak +
    'https://www.googleapis.com/auth/calendar.events';

  FCalendario := TGoogleCalendarCalendario.Create(LeggiToken);
end;

destructor TCalendarioEsternoGoogle.Destroy;
begin
  FreeAndNil(FCalendario);
  FreeAndNil(FAutorizzazione);
  inherited Destroy;
end;

function TCalendarioEsternoGoogle.LeggiToken: string;
begin
  Result := TokenAccessoOAuth2(FAutorizzazione, 'Google');
end;

function TCalendarioEsternoGoogle.NomeServizio: string;
begin
  Result := 'Google Calendar';
end;

function TCalendarioEsternoGoogle.Accedi(const RefreshToken: string; const Interattiva: Boolean; out Errore: string): Boolean;
begin
  Result := AccediOAuth2(FAutorizzazione, RefreshToken, Interattiva, 'Google', Errore);
end;

function TCalendarioEsternoGoogle.RefreshToken: string;
begin
  Result := FAutorizzazione.RefreshToken;
end;

function TCalendarioEsternoGoogle.Profilo: TProfiloEsterno;
begin
  Result := FCalendario.Profilo;
end;

procedure TCalendarioEsternoGoogle.LeggiModifiche(var Stato: string; const Dal, Al: TDate; Eventi: TList<TEventoEsterno>);
begin
  FCalendario.LeggiModifiche(FIdCalendario, Stato, Dal, Al, Eventi);
end;

function TCalendarioEsternoGoogle.CreaEvento(const Evento: TEventoEsterno): TEventoEsterno;
begin
  Result := FCalendario.CreaEvento(FIdCalendario, Evento);
end;

function TCalendarioEsternoGoogle.AggiornaEvento(const Evento: TEventoEsterno; const ConNote: Boolean): TEventoEsterno;
begin
  Result := FCalendario.AggiornaEvento(FIdCalendario, Evento, ConNote);
end;

function TCalendarioEsternoGoogle.EliminaEvento(const Id: string): Boolean;
begin
  Result := FCalendario.EliminaEvento(FIdCalendario, Id);
end;

end.
