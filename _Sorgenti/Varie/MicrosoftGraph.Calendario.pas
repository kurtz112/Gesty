// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-22
// ---------------------------------------------------------------------------
unit MicrosoftGraph.Calendario;

// Calendario Outlook dell'utente collegato, via Microsoft Graph (REST v1.0).
// Non dipende dall'applicazione: il token lo fornisce chi la usa (LeggiToken).
//
// Tutte le chiamate chiedono:
// - identificativi immutabili (IdType="ImmutableId"), che non cambiano se
//   l'utente sposta l'evento in un'altra cartella;
// - date e ore nel fuso orario indicato (outlook.timezone), cosi' inizio e fine
//   arrivano e partono nell'ora locale dell'agenda.

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.JSON,
  System.Net.HttpClient,
  System.Net.URLClient;

type
  EMicrosoftGraph = class(Exception)
  public
    StatoHttp: Integer;
  end;

  // La lettura delle modifiche (delta) non e' piu' valida: va ripresa da capo
  EMicrosoftGraphDeltaScaduto = class(EMicrosoftGraph);

  TMicrosoftGraphEvento = record
    Id: string;
    ChangeKey: string;
    Oggetto: string;
    Note: string;
    Inizio: TDateTime;
    Fine: TDateTime;
    // ora locale
    UltimaModifica: TDateTime;
    GiornataIntera: Boolean;
    Annullato: Boolean;
    // cancellato in Outlook: solo Id e' valorizzato
    Rimosso: Boolean;
  end;

  TMicrosoftGraphProfilo = record
    Mail: string;
    NomeAccesso: string;
    Nome: string;
  end;

  TMicrosoftGraphCalendario = class
  strict private
    FClient: THTTPClient;
    FLeggiToken: TFunc<string>;
    FFusoOrario: string;
    function Intestazioni(const ConCorpo, Delta: Boolean): TNetHeaders;
    function Esegui(const Metodo, Indirizzo, Corpo: string; const Delta: Boolean = False): TJSONValue;
    function PercorsoCalendario(const IdCalendario: string): string;
    function LeggiEvento(Oggetto: TJSONObject): TMicrosoftGraphEvento;
    function CorpoEvento(const Evento: TMicrosoftGraphEvento; const ConNote: Boolean): string;
    class function CodificaId(const Id: string): string; static;
    class function DaTestoLocale(const Testo: string): TDateTime; static;
    class function DaTestoUtc(const Testo: string): TDateTime; static;
    class function ATestoLocale(const Data: TDateTime): string; static;
  public
    constructor Create(const LeggiToken: TFunc<string>);
    destructor Destroy; override;

    function Profilo: TMicrosoftGraphProfilo;

    // Eventi cambiati dall'ultima lettura (DeltaLink vuoto = tutti quelli fra Dal e Al).
    // Al ritorno DeltaLink e' l'indirizzo da usare la volta successiva.
    // Gli eventi ricorrenti arrivano gia' divisi nelle singole occorrenze.
    procedure LeggiModifiche(const IdCalendario: string; var DeltaLink: string; const Dal, Al: TDate; Eventi: TList<TMicrosoftGraphEvento>);

    function CreaEvento(const IdCalendario: string; const Evento: TMicrosoftGraphEvento): TMicrosoftGraphEvento;
    // ConNote = False lascia com'e' il testo dell'evento in Outlook
    function AggiornaEvento(const Evento: TMicrosoftGraphEvento; const ConNote: Boolean): TMicrosoftGraphEvento;
    // Falso se l'evento in Outlook non c'era gia' piu'
    function EliminaEvento(const Id: string): Boolean;

    // Nome Windows del fuso orario (predefinito "W. Europe Standard Time")
    property FusoOrario: string read FFusoOrario write FFusoOrario;
  end;

implementation

uses
  System.DateUtils,
  System.NetEncoding,
  System.Math;

const
  INDIRIZZO_GRAPH = 'https://graph.microsoft.com/v1.0';
  TENTATIVI_MASSIMI = 3;

{ TMicrosoftGraphCalendario }

constructor TMicrosoftGraphCalendario.Create(const LeggiToken: TFunc<string>);
begin
  inherited Create;
  FLeggiToken := LeggiToken;
  FFusoOrario := 'W. Europe Standard Time';
  FClient := THTTPClient.Create;
  FClient.ConnectionTimeout := 30000;
  FClient.ResponseTimeout := 60000;
end;

destructor TMicrosoftGraphCalendario.Destroy;
begin
  FreeAndNil(FClient);
  inherited Destroy;
end;

function TMicrosoftGraphCalendario.Intestazioni(const ConCorpo, Delta: Boolean): TNetHeaders;
var
  Preferenze: string;
begin
  Preferenze := Format('IdType="ImmutableId", outlook.timezone="%s"', [FusoOrario]);
  if Delta then
    Preferenze := Preferenze + ', odata.maxpagesize=100';

  Result := [TNetHeader.Create('Authorization', 'Bearer ' + FLeggiToken()), TNetHeader.Create('Prefer', Preferenze), TNetHeader.Create('Accept', 'application/json')];

  if ConCorpo then
    Result := Result + [TNetHeader.Create('Content-Type', 'application/json')];
end;

function TMicrosoftGraphCalendario.Esegui(const Metodo, Indirizzo, Corpo: string; const Delta: Boolean): TJSONValue;
var
  Risposta: IHTTPResponse;
  Flusso: TStringStream;
  Tentativo: Integer;
  Attesa: Integer;
  Testo: string;
  Errore: TJSONValue;
  CodiceErrore: string;
  MessaggioErrore: string;
  Eccezione: EMicrosoftGraph;
begin
  Result := nil;
  Risposta := nil;

  for Tentativo := 1 to TENTATIVI_MASSIMI do
  begin
    Flusso := nil;
    try
      if Corpo <> '' then
        Flusso := TStringStream.Create(Corpo, TEncoding.UTF8);

      if Metodo = 'GET' then
        Risposta := FClient.Get(Indirizzo, nil, Intestazioni(False, Delta))
      else if Metodo = 'POST' then
        Risposta := FClient.Post(Indirizzo, Flusso, nil, Intestazioni(True, False))
      else if Metodo = 'PATCH' then
        Risposta := FClient.Patch(Indirizzo, Flusso, nil, Intestazioni(True, False))
      else if Metodo = 'DELETE' then
        Risposta := FClient.Delete(Indirizzo, nil, Intestazioni(False, False))
      else
        raise EMicrosoftGraph.Create('Metodo HTTP non previsto: ' + Metodo);
    finally
      Flusso.Free;
    end;

    // troppe richieste o servizio occupato: Graph dice quanto aspettare
    if (Risposta.StatusCode = 429) or (Risposta.StatusCode = 503) then
    begin
      if Tentativo = TENTATIVI_MASSIMI then
        Break;
      Attesa := StrToIntDef(Risposta.HeaderValue['Retry-After'], 5);
      Sleep(Min(Attesa, 30) * 1000);
      Continue;
    end;

    Break;
  end;

  Testo := Risposta.ContentAsString(TEncoding.UTF8);

  if Risposta.StatusCode >= 400 then
  begin
    CodiceErrore := '';
    MessaggioErrore := Testo;
    Errore := TJSONObject.ParseJSONValue(Testo);
    try
      if Assigned(Errore) then
      begin
        CodiceErrore := Errore.GetValue<string>('error.code', '');
        MessaggioErrore := Errore.GetValue<string>('error.message', Testo);
      end;
    finally
      Errore.Free;
    end;

    // 410 o stato di sincronizzazione perso: la lettura delta riparte da capo
    if (Risposta.StatusCode = 410) or CodiceErrore.Contains('SyncState') or CodiceErrore.Contains('resyncRequired') then
      Eccezione := EMicrosoftGraphDeltaScaduto.Create(MessaggioErrore)
    else
      Eccezione := EMicrosoftGraph.CreateFmt('Microsoft Graph, errore %d %s: %s', [Risposta.StatusCode, CodiceErrore, MessaggioErrore]);
    Eccezione.StatoHttp := Risposta.StatusCode;
    raise Eccezione;
  end;

  if Testo.Trim <> '' then
    Result := TJSONObject.ParseJSONValue(Testo);
end;

class function TMicrosoftGraphCalendario.CodificaId(const Id: string): string;
begin
  Result := TNetEncoding.URL.Encode(Id);
end;

function TMicrosoftGraphCalendario.PercorsoCalendario(const IdCalendario: string): string;
begin
  if IdCalendario = '' then
    Result := INDIRIZZO_GRAPH + '/me'
  else
    Result := INDIRIZZO_GRAPH + '/me/calendars/' + CodificaId(IdCalendario);
end;

class function TMicrosoftGraphCalendario.DaTestoLocale(const Testo: string): TDateTime;
begin
  // "2026-10-22T09:30:00.0000000", gia' nel fuso orario chiesto con outlook.timezone
  Result := EncodeDateTime(
    StrToInt(Testo.Substring(0, 4)), StrToInt(Testo.Substring(5, 2)), StrToInt(Testo.Substring(8, 2)),
    StrToInt(Testo.Substring(11, 2)), StrToInt(Testo.Substring(14, 2)), StrToInt(Testo.Substring(17, 2)), 0);
end;

class function TMicrosoftGraphCalendario.DaTestoUtc(const Testo: string): TDateTime;
begin
  // "2026-10-22T07:30:44.7155469Z": ora UTC, riportata all'ora locale
  if Testo = '' then
    Exit(0);
  Result := TTimeZone.Local.ToLocalTime(DaTestoLocale(Testo));
end;

class function TMicrosoftGraphCalendario.ATestoLocale(const Data: TDateTime): string;
begin
  Result := FormatDateTime('yyyy"-"mm"-"dd"T"hh":"nn":"ss', Data);
end;

function TMicrosoftGraphCalendario.LeggiEvento(Oggetto: TJSONObject): TMicrosoftGraphEvento;
begin
  Result := Default(TMicrosoftGraphEvento);
  Result.Id := Oggetto.GetValue<string>('id', '');

  if Assigned(Oggetto.FindValue('@removed')) then
  begin
    Result.Rimosso := True;
    Exit;
  end;

  Result.ChangeKey := Oggetto.GetValue<string>('changeKey', '');
  Result.Oggetto := Oggetto.GetValue<string>('subject', '');
  Result.Note := Oggetto.GetValue<string>('bodyPreview', '');
  Result.GiornataIntera := Oggetto.GetValue<Boolean>('isAllDay', False);
  Result.Annullato := Oggetto.GetValue<Boolean>('isCancelled', False);
  Result.Inizio := DaTestoLocale(Oggetto.GetValue<string>('start.dateTime', ''));
  Result.Fine := DaTestoLocale(Oggetto.GetValue<string>('end.dateTime', ''));
  Result.UltimaModifica := DaTestoUtc(Oggetto.GetValue<string>('lastModifiedDateTime', ''));
end;

function TMicrosoftGraphCalendario.CorpoEvento(const Evento: TMicrosoftGraphEvento; const ConNote: Boolean): string;
var
  Oggetto: TJSONObject;
  Momento: TJSONObject;
  Testo: TJSONObject;
begin
  Oggetto := TJSONObject.Create;
  try
    Oggetto.AddPair('subject', Evento.Oggetto);

    Momento := TJSONObject.Create;
    Momento.AddPair('dateTime', ATestoLocale(Evento.Inizio));
    Momento.AddPair('timeZone', FusoOrario);
    Oggetto.AddPair('start', Momento);

    Momento := TJSONObject.Create;
    Momento.AddPair('dateTime', ATestoLocale(Evento.Fine));
    Momento.AddPair('timeZone', FusoOrario);
    Oggetto.AddPair('end', Momento);

    if ConNote then
    begin
      Testo := TJSONObject.Create;
      Testo.AddPair('contentType', 'text');
      Testo.AddPair('content', Evento.Note);
      Oggetto.AddPair('body', Testo);
    end;

    Result := Oggetto.ToJSON;
  finally
    Oggetto.Free;
  end;
end;

function TMicrosoftGraphCalendario.Profilo: TMicrosoftGraphProfilo;
var
  Risposta: TJSONValue;
begin
  Result := Default(TMicrosoftGraphProfilo);
  Risposta := Esegui('GET', INDIRIZZO_GRAPH + '/me?$select=mail,userPrincipalName,displayName', '');
  try
    if Assigned(Risposta) then
    begin
      Result.Mail := Risposta.GetValue<string>('mail', '');
      Result.NomeAccesso := Risposta.GetValue<string>('userPrincipalName', '');
      Result.Nome := Risposta.GetValue<string>('displayName', '');
    end;
  finally
    Risposta.Free;
  end;
end;

procedure TMicrosoftGraphCalendario.LeggiModifiche(const IdCalendario: string; var DeltaLink: string; const Dal, Al: TDate; Eventi: TList<TMicrosoftGraphEvento>);
var
  Indirizzo: string;
  Risposta: TJSONValue;
  Valori: TJSONArray;
  Elemento: TJSONValue;
  Successivo: string;
begin
  if DeltaLink <> '' then
    Indirizzo := DeltaLink
  else
    Indirizzo := PercorsoCalendario(IdCalendario) + '/calendarView/delta' +
      '?startDateTime=' + FormatDateTime('yyyy"-"mm"-"dd"T00:00:00"', Dal) +
      '&endDateTime=' + FormatDateTime('yyyy"-"mm"-"dd"T23:59:59"', Al);

  // le pagine continuano con @odata.nextLink; l'ultima porta @odata.deltaLink
  while Indirizzo <> '' do
  begin
    Risposta := Esegui('GET', Indirizzo, '', True);
    try
      Indirizzo := '';
      if not Assigned(Risposta) then
        Break;

      Valori := Risposta.GetValue<TJSONArray>('value', nil);
      if Assigned(Valori) then
        for Elemento in Valori do
          if Elemento is TJSONObject then
            Eventi.Add(LeggiEvento(TJSONObject(Elemento)));

      Successivo := Risposta.GetValue<string>('@odata.nextLink', '');
      if Successivo <> '' then
        Indirizzo := Successivo
      else
        DeltaLink := Risposta.GetValue<string>('@odata.deltaLink', DeltaLink);
    finally
      Risposta.Free;
    end;
  end;
end;

function TMicrosoftGraphCalendario.CreaEvento(const IdCalendario: string; const Evento: TMicrosoftGraphEvento): TMicrosoftGraphEvento;
var
  Risposta: TJSONValue;
begin
  Risposta := Esegui('POST', PercorsoCalendario(IdCalendario) + '/events', CorpoEvento(Evento, True));
  try
    if not (Risposta is TJSONObject) then
      raise EMicrosoftGraph.Create('Microsoft Graph non ha restituito l''evento creato');
    Result := LeggiEvento(TJSONObject(Risposta));
  finally
    Risposta.Free;
  end;
end;

function TMicrosoftGraphCalendario.AggiornaEvento(const Evento: TMicrosoftGraphEvento; const ConNote: Boolean): TMicrosoftGraphEvento;
var
  Risposta: TJSONValue;
begin
  Risposta := Esegui('PATCH', INDIRIZZO_GRAPH + '/me/events/' + CodificaId(Evento.Id), CorpoEvento(Evento, ConNote));
  try
    if not (Risposta is TJSONObject) then
      raise EMicrosoftGraph.Create('Microsoft Graph non ha restituito l''evento aggiornato');
    Result := LeggiEvento(TJSONObject(Risposta));
  finally
    Risposta.Free;
  end;
end;

function TMicrosoftGraphCalendario.EliminaEvento(const Id: string): Boolean;
var
  Risposta: TJSONValue;
begin
  Result := True;
  try
    Risposta := Esegui('DELETE', INDIRIZZO_GRAPH + '/me/events/' + CodificaId(Id), '');
    Risposta.Free;
  except
    on E: EMicrosoftGraph do
      if E.StatoHttp = 404 then
        Result := False
      else
        raise;
  end;
end;

end.
