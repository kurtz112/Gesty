// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-22
// ---------------------------------------------------------------------------
unit CalendarioEsterno.Microsoft;

// Calendario Outlook (Microsoft 365) come ICalendarioEsterno: unisce l'accesso
// (MicrosoftGraph.Autorizzazione) e le chiamate al calendario
// (MicrosoftGraph.Calendario). Permessi delegati: User.Read, Calendars.ReadWrite,
// offline_access (aggiunto dall'agente DevExpress).

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  CalendarioEsterno.Types,
  MicrosoftGraph.Autorizzazione,
  MicrosoftGraph.Calendario;

type
  TCalendarioEsternoMicrosoft = class(TInterfacedObject, ICalendarioEsterno)
  strict private
    FAutorizzazione: TMicrosoftGraphAutorizzazione;
    FCalendario: TMicrosoftGraphCalendario;
    FIdCalendario: string;
    function LeggiToken: string;
  public
    // IdCalendario vuoto = calendario predefinito dell'utente
    constructor Create(const TenantId, ClientId, IdCalendario: string);
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

{ TCalendarioEsternoMicrosoft }

constructor TCalendarioEsternoMicrosoft.Create(const TenantId, ClientId, IdCalendario: string);
begin
  inherited Create;
  FIdCalendario := IdCalendario;

  FAutorizzazione := TMicrosoftGraphAutorizzazione.Create(nil);
  FAutorizzazione.TenantId := TenantId;
  FAutorizzazione.ClientID := ClientId;
  FAutorizzazione.AdditionalScopes.Text := 'User.Read' + sLineBreak + 'Calendars.ReadWrite';

  FCalendario := TMicrosoftGraphCalendario.Create(LeggiToken);
end;

destructor TCalendarioEsternoMicrosoft.Destroy;
begin
  FreeAndNil(FCalendario);
  FreeAndNil(FAutorizzazione);
  inherited Destroy;
end;

function TCalendarioEsternoMicrosoft.LeggiToken: string;
begin
  Result := TokenAccessoOAuth2(FAutorizzazione, 'Microsoft 365');
end;

function TCalendarioEsternoMicrosoft.NomeServizio: string;
begin
  Result := 'Outlook';
end;

function TCalendarioEsternoMicrosoft.Accedi(const RefreshToken: string; const Interattiva: Boolean; out Errore: string): Boolean;
begin
  Result := AccediOAuth2(FAutorizzazione, RefreshToken, Interattiva, 'Microsoft 365', Errore);
end;

function TCalendarioEsternoMicrosoft.RefreshToken: string;
begin
  Result := FAutorizzazione.RefreshToken;
end;

function TCalendarioEsternoMicrosoft.Profilo: TProfiloEsterno;
begin
  Result := FCalendario.Profilo;
end;

procedure TCalendarioEsternoMicrosoft.LeggiModifiche(var Stato: string; const Dal, Al: TDate; Eventi: TList<TEventoEsterno>);
begin
  FCalendario.LeggiModifiche(FIdCalendario, Stato, Dal, Al, Eventi);
end;

function TCalendarioEsternoMicrosoft.CreaEvento(const Evento: TEventoEsterno): TEventoEsterno;
begin
  Result := FCalendario.CreaEvento(FIdCalendario, Evento);
end;

function TCalendarioEsternoMicrosoft.AggiornaEvento(const Evento: TEventoEsterno; const ConNote: Boolean): TEventoEsterno;
begin
  Result := FCalendario.AggiornaEvento(Evento, ConNote);
end;

function TCalendarioEsternoMicrosoft.EliminaEvento(const Id: string): Boolean;
begin
  Result := FCalendario.EliminaEvento(Id);
end;

end.
