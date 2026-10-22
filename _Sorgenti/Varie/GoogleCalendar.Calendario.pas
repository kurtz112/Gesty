// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-22
// ---------------------------------------------------------------------------
unit GoogleCalendar.Calendario;

// Calendario Google dell'utente collegato, via Google Calendar API v3 (REST).
// Non dipende dall'applicazione: il token lo fornisce chi la usa (LeggiToken).
//
// - Letture con singleEvents=true (ricorrenze divise nelle occorrenze) e
//   showDeleted=true (gli eventi cancellati arrivano con status "cancelled").
// - Lettura delle sole modifiche con syncToken: la prima lettura e' limitata alla
//   finestra di date, le successive no (Google non accetta la finestra insieme al
//   syncToken), quindi possono portare anche eventi fuori finestra.
// - Date e ore nel fuso orario indicato (FusoOrario, nome IANA): Google le
//   restituisce con lo scostamento, qui riportate all'ora locale di Windows.
// Evento, profilo ed errori sono quelli comuni di CalendarioEsterno.Types: la
// versione dell'evento (Versione) e' l'etag di Google.

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.JSON,
  System.Net.HttpClient,
  System.Net.URLClient,
  CalendarioEsterno.Types;

type
  EGoogleCalendar = class(ECalendarioEsterno);

  // Il syncToken non e' piu' valido (410 Gone): la lettura va ripresa da capo
  EGoogleCalendarSincronizzazioneScaduta = class(ECalendarioEsternoLetturaScaduta);

  TGoogleCalendarCalendario = class
  strict private
    FClient: THTTPClient;
    FLeggiToken: TFunc<string>;
    FFusoOrario: string;
    function Intestazioni(const ConCorpo: Boolean): TNetHeaders;
    function Esegui(const Metodo, Indirizzo, Corpo: string): TJSONValue;
    function PercorsoEventi(const IdCalendario: string): string;
    function LeggiEvento(Oggetto: TJSONObject): TEventoEsterno;
    function CorpoEvento(const Evento: TEventoEsterno; const ConNote: Boolean): string;
    class function Codifica(const Testo: string): string; static;
    class function DaTestoGoogle(const Testo: string): TDateTime; static;
    class function ATestoLocale(const Data: TDateTime): string; static;
  public
    constructor Create(const LeggiToken: TFunc<string>);
    destructor Destroy; override;

    // account con cui l'utente ha fatto l'accesso (permessi openid ed email)
    function Profilo: TProfiloEsterno;

    // Eventi cambiati dall'ultima lettura (SyncToken vuoto = tutti quelli fra Dal e Al).
    // Al ritorno SyncToken e' quello da usare la volta successiva.
    procedure LeggiModifiche(const IdCalendario: string; var SyncToken: string; const Dal, Al: TDate; Eventi: TList<TEventoEsterno>);

    function CreaEvento(const IdCalendario: string; const Evento: TEventoEsterno): TEventoEsterno;
    // ConNote = False lascia com'e' il testo dell'evento in Google
    function AggiornaEvento(const IdCalendario: string; const Evento: TEventoEsterno; const ConNote: Boolean): TEventoEsterno;
    // Falso se l'evento in Google non c'era gia' piu'
    function EliminaEvento(const IdCalendario, Id: string): Boolean;

    // Nome IANA del fuso orario (predefinito "Europe/Rome")
    property FusoOrario: string read FFusoOrario write FFusoOrario;
  end;

implementation

uses
  System.DateUtils,
  System.NetEncoding,
  System.Math;

const
  INDIRIZZO_CALENDARIO = 'https://www.googleapis.com/calendar/v3';
  INDIRIZZO_PROFILO = 'https://openidconnect.googleapis.com/v1/userinfo';
  TENTATIVI_MASSIMI = 3;

{ TGoogleCalendarCalendario }

constructor TGoogleCalendarCalendario.Create(const LeggiToken: TFunc<string>);
begin
  inherited Create;
  FLeggiToken := LeggiToken;
  FFusoOrario := 'Europe/Rome';
  FClient := THTTPClient.Create;
  FClient.ConnectionTimeout := 30000;
  FClient.ResponseTimeout := 60000;
end;

destructor TGoogleCalendarCalendario.Destroy;
begin
  FreeAndNil(FClient);
  inherited Destroy;
end;

class function TGoogleCalendarCalendario.Codifica(const Testo: string): string;
begin
  Result := TNetEncoding.URL.Encode(Testo);
end;

function TGoogleCalendarCalendario.Intestazioni(const ConCorpo: Boolean): TNetHeaders;
begin
  Result := [TNetHeader.Create('Authorization', 'Bearer ' + FLeggiToken()), TNetHeader.Create('Accept', 'application/json')];
  if ConCorpo then
    Result := Result + [TNetHeader.Create('Content-Type', 'application/json')];
end;

function TGoogleCalendarCalendario.Esegui(const Metodo, Indirizzo, Corpo: string): TJSONValue;
var
  Risposta: IHTTPResponse;
  Flusso: TStringStream;
  Tentativo: Integer;
  Testo: string;
  Errore: TJSONValue;
  Motivo: string;
  MessaggioErrore: string;
  Eccezione: ECalendarioEsterno;
begin
  Result := nil;
  Risposta := nil;
  Motivo := '';
  MessaggioErrore := '';

  for Tentativo := 1 to TENTATIVI_MASSIMI do
  begin
    Flusso := nil;
    try
      if Corpo <> '' then
        Flusso := TStringStream.Create(Corpo, TEncoding.UTF8);

      if Metodo = 'GET' then
        Risposta := FClient.Get(Indirizzo, nil, Intestazioni(False))
      else if Metodo = 'POST' then
        Risposta := FClient.Post(Indirizzo, Flusso, nil, Intestazioni(True))
      else if Metodo = 'PATCH' then
        Risposta := FClient.Patch(Indirizzo, Flusso, nil, Intestazioni(True))
      else if Metodo = 'DELETE' then
        Risposta := FClient.Delete(Indirizzo, nil, Intestazioni(False))
      else
        raise EGoogleCalendar.Create('Metodo HTTP non previsto: ' + Metodo);
    finally
      Flusso.Free;
    end;

    Testo := Risposta.ContentAsString(TEncoding.UTF8);
    Motivo := '';
    MessaggioErrore := Testo;
    if Risposta.StatusCode >= 400 then
    begin
      Errore := TJSONObject.ParseJSONValue(Testo);
      try
        if Assigned(Errore) then
        begin
          Motivo := Errore.GetValue<string>('error.errors[0].reason', '');
          MessaggioErrore := Errore.GetValue<string>('error.message', Testo);
        end;
      finally
        Errore.Free;
      end;
    end;

    // troppe richieste o servizio occupato: Google chiede di riprovare con attese crescenti
    if (Risposta.StatusCode = 429) or (Risposta.StatusCode = 503) or
       ((Risposta.StatusCode = 403) and ((Motivo = 'rateLimitExceeded') or (Motivo = 'userRateLimitExceeded'))) then
    begin
      if Tentativo = TENTATIVI_MASSIMI then
        Break;
      Sleep(Round(Power(2, Tentativo)) * 1000);
      Continue;
    end;

    Break;
  end;

  if Risposta.StatusCode >= 400 then
  begin
    // syncToken scaduto: la lettura delle modifiche riparte da capo
    if (Risposta.StatusCode = 410) and Indirizzo.Contains('syncToken=') then
      Eccezione := EGoogleCalendarSincronizzazioneScaduta.Create(MessaggioErrore)
    else
      Eccezione := EGoogleCalendar.CreateFmt('Google Calendar, errore %d %s: %s', [Risposta.StatusCode, Motivo, MessaggioErrore]);
    Eccezione.StatoHttp := Risposta.StatusCode;
    raise Eccezione;
  end;

  if Testo.Trim <> '' then
    Result := TJSONObject.ParseJSONValue(Testo);
end;

function TGoogleCalendarCalendario.PercorsoEventi(const IdCalendario: string): string;
begin
  if IdCalendario = '' then
    Result := INDIRIZZO_CALENDARIO + '/calendars/primary/events'
  else
    Result := INDIRIZZO_CALENDARIO + '/calendars/' + Codifica(IdCalendario) + '/events';
end;

class function TGoogleCalendarCalendario.DaTestoGoogle(const Testo: string): TDateTime;
begin
  // "2026-10-22T09:30:00+02:00" o "2026-10-22T07:30:44.715Z": riportata all'ora locale;
  // "2026-10-22" (giornata intera): la data cosi' com'e'
  if Testo = '' then
    Exit(0);
  if Testo.Length = 10 then
    Result := EncodeDate(StrToInt(Testo.Substring(0, 4)), StrToInt(Testo.Substring(5, 2)), StrToInt(Testo.Substring(8, 2)))
  else
    Result := ISO8601ToDate(Testo, False);
end;

class function TGoogleCalendarCalendario.ATestoLocale(const Data: TDateTime): string;
begin
  Result := FormatDateTime('yyyy"-"mm"-"dd"T"hh":"nn":"ss', Data);
end;

function TGoogleCalendarCalendario.LeggiEvento(Oggetto: TJSONObject): TEventoEsterno;
var
  Inizio: string;
  Fine: string;
begin
  Result := Default(TEventoEsterno);
  Result.Id := Oggetto.GetValue<string>('id', '');

  // cancellato in Google, o occorrenza tolta da una serie
  if Oggetto.GetValue<string>('status', '') = 'cancelled' then
  begin
    Result.Rimosso := True;
    Exit;
  end;

  Result.Versione := Oggetto.GetValue<string>('etag', '');
  Result.Oggetto := Oggetto.GetValue<string>('summary', '');
  Result.Note := Oggetto.GetValue<string>('description', '');
  Result.UltimaModifica := DaTestoGoogle(Oggetto.GetValue<string>('updated', ''));

  // giornata intera: solo la data, con la fine esclusa (il giorno dopo a mezzanotte)
  Inizio := Oggetto.GetValue<string>('start.dateTime', '');
  Fine := Oggetto.GetValue<string>('end.dateTime', '');
  if Inizio = '' then
  begin
    Result.GiornataIntera := True;
    Inizio := Oggetto.GetValue<string>('start.date', '');
    Fine := Oggetto.GetValue<string>('end.date', '');
  end;
  Result.Inizio := DaTestoGoogle(Inizio);
  Result.Fine := DaTestoGoogle(Fine);
end;

function TGoogleCalendarCalendario.CorpoEvento(const Evento: TEventoEsterno; const ConNote: Boolean): string;
var
  Oggetto: TJSONObject;
  Momento: TJSONObject;
begin
  Oggetto := TJSONObject.Create;
  try
    Oggetto.AddPair('summary', Evento.Oggetto);

    Momento := TJSONObject.Create;
    Momento.AddPair('dateTime', ATestoLocale(Evento.Inizio));
    Momento.AddPair('timeZone', FusoOrario);
    Oggetto.AddPair('start', Momento);

    Momento := TJSONObject.Create;
    Momento.AddPair('dateTime', ATestoLocale(Evento.Fine));
    Momento.AddPair('timeZone', FusoOrario);
    Oggetto.AddPair('end', Momento);

    if ConNote then
      Oggetto.AddPair('description', Evento.Note);

    Result := Oggetto.ToJSON;
  finally
    Oggetto.Free;
  end;
end;

function TGoogleCalendarCalendario.Profilo: TProfiloEsterno;
var
  Risposta: TJSONValue;
begin
  Result := Default(TProfiloEsterno);
  Risposta := Esegui('GET', INDIRIZZO_PROFILO, '');
  try
    if Assigned(Risposta) then
    begin
      Result.Mail := Risposta.GetValue<string>('email', '');
      Result.NomeAccesso := Result.Mail;
      Result.Nome := Risposta.GetValue<string>('name', '');
    end;
  finally
    Risposta.Free;
  end;
end;

procedure TGoogleCalendarCalendario.LeggiModifiche(const IdCalendario: string; var SyncToken: string; const Dal, Al: TDate; Eventi: TList<TEventoEsterno>);
var
  Base: string;
  Indirizzo: string;
  Pagina: string;
  Risposta: TJSONValue;
  Valori: TJSONArray;
  Elemento: TJSONValue;
  Prossimo: string;
begin
  // gli stessi parametri nella prima lettura e in quelle con syncToken
  Base := PercorsoEventi(IdCalendario) +
    '?singleEvents=true&showDeleted=true&maxResults=250&timeZone=' + Codifica(FusoOrario);
  if SyncToken <> '' then
    Base := Base + '&syncToken=' + Codifica(SyncToken)
  else
    Base := Base +
      '&timeMin=' + Codifica(DateToISO8601(DateOf(Dal), False)) +
      '&timeMax=' + Codifica(DateToISO8601(IncDay(DateOf(Al)), False));

  // le pagine continuano con nextPageToken; l'ultima porta nextSyncToken
  SyncToken := '';
  Pagina := '';
  repeat
    Indirizzo := Base;
    if Pagina <> '' then
      Indirizzo := Indirizzo + '&pageToken=' + Codifica(Pagina);

    Risposta := Esegui('GET', Indirizzo, '');
    try
      Pagina := '';
      if not Assigned(Risposta) then
        Break;

      Valori := Risposta.GetValue<TJSONArray>('items', nil);
      if Assigned(Valori) then
        for Elemento in Valori do
          if Elemento is TJSONObject then
            Eventi.Add(LeggiEvento(TJSONObject(Elemento)));

      Prossimo := Risposta.GetValue<string>('nextPageToken', '');
      if Prossimo <> '' then
        Pagina := Prossimo
      else
        SyncToken := Risposta.GetValue<string>('nextSyncToken', '');
    finally
      Risposta.Free;
    end;
  until Pagina = '';
end;

function TGoogleCalendarCalendario.CreaEvento(const IdCalendario: string; const Evento: TEventoEsterno): TEventoEsterno;
var
  Risposta: TJSONValue;
begin
  Risposta := Esegui('POST', PercorsoEventi(IdCalendario), CorpoEvento(Evento, True));
  try
    if not (Risposta is TJSONObject) then
      raise EGoogleCalendar.Create('Google Calendar non ha restituito l''evento creato');
    Result := LeggiEvento(TJSONObject(Risposta));
  finally
    Risposta.Free;
  end;
end;

function TGoogleCalendarCalendario.AggiornaEvento(const IdCalendario: string; const Evento: TEventoEsterno; const ConNote: Boolean): TEventoEsterno;
var
  Risposta: TJSONValue;
begin
  Risposta := Esegui('PATCH', PercorsoEventi(IdCalendario) + '/' + Codifica(Evento.Id), CorpoEvento(Evento, ConNote));
  try
    if not (Risposta is TJSONObject) then
      raise EGoogleCalendar.Create('Google Calendar non ha restituito l''evento aggiornato');
    Result := LeggiEvento(TJSONObject(Risposta));
  finally
    Risposta.Free;
  end;
end;

function TGoogleCalendarCalendario.EliminaEvento(const IdCalendario, Id: string): Boolean;
var
  Risposta: TJSONValue;
begin
  Result := True;
  try
    Risposta := Esegui('DELETE', PercorsoEventi(IdCalendario) + '/' + Codifica(Id), '');
    Risposta.Free;
  except
    // 410: gia' cancellato in Google
    on E: EGoogleCalendar do
      if (E.StatoHttp = 404) or (E.StatoHttp = 410) then
        Result := False
      else
        raise;
  end;
end;

end.
