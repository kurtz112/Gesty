// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-05
// ---------------------------------------------------------------------------
unit Gefos.Client;

// Client REST di GE.FO.S. (specifica v2.3): token OAuth2 client credentials,
// intestazione X-Gefos-Ente-Erogatore, chiamate e lettura degli errori dal campo "code".
//
// Ogni chiamata restituisce un TGefosRisposta e non solleva eccezioni per gli errori
// del servizio: il chiamante decide cosa mostrare. Ogni chiamata passa anche per
// OnChiamata, cosi' il DataModule ponte la registra in GEFOS_COOPERAZIONE_APPLICATIVA_INVII
// senza che il client conosca il database.
//
// Il trasporto HTTP e' un'interfaccia: in esercizio THTTPClient, nelle prove un simulatore.

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.Generics.Collections,
  Gefos.Types;

type
  TGefosIntestazione = record
    Nome: string;
    Valore: string;
    class function Create(const Nome, Valore: string): TGefosIntestazione; static;
  end;

  TGefosRichiestaHttp = record
    Metodo: string;
    Url: string;
    Intestazioni: TArray<TGefosIntestazione>;
    Corpo: string;
  end;

  TGefosRispostaHttp = record
    Stato: Integer;
    Corpo: TBytes;
    TipoContenuto: string;
  end;

  // Errore di rete: il servizio non ha risposto
  EGefosTrasporto = class(EGefosErrore);

  IGefosTrasporto = interface
    ['{6B0F2B67-6E0B-4C2B-9D0E-3B7E8E2C1A41}']
    function Esegui(const Richiesta: TGefosRichiestaHttp): TGefosRispostaHttp;
  end;

  TGefosTrasportoHttp = class(TInterfacedObject, IGefosTrasporto)
  private
    FTimeoutConnessioneMs: Integer;
    FTimeoutRispostaMs: Integer;
  public
    constructor Create(TimeoutConnessioneMs, TimeoutRispostaMs: Integer);
    function Esegui(const Richiesta: TGefosRichiestaHttp): TGefosRispostaHttp;
  end;

  TGefosEventoChiamata = procedure(const Risposta: TGefosRisposta) of object;

  TGefosClient = class
  private
    FConfigurazione: TGefosConfigurazione;
    FTrasporto: IGefosTrasporto;
    FToken: string;
    FScadenzaToken: TDateTime;
    FAdesso: TFunc<TDateTime>;
    FOnChiamata: TGefosEventoChiamata;
    // Vero solo durante avvio e conferma: finisce nella risposta prima di OnChiamata,
    // cosi' il registro dice chi ha accettato le dichiarazioni
    FDichiarazioniAccettate: Boolean;
    function ChiamaConDichiarazioni(Operazione: TGefosOperazione; const Percorso: string): TGefosRisposta;
    function UrlCompleto(const Percorso: string): string;
    function TokenValido: Boolean;
    function RichiediToken(out Risposta: TGefosRisposta): Boolean;
    function Chiama(Operazione: TGefosOperazione; const Metodo, Percorso, Corpo, Accetta: string): TGefosRisposta;
    function ChiamaConJson(Operazione: TGefosOperazione; const Metodo, Percorso: string; Corpo: TJSONValue): TGefosRisposta;
    procedure Notifica(const Risposta: TGefosRisposta);
    function PercorsoEdizione(IdCorso, IdEdizione: Int64): string;
  public
    constructor Create(const Configurazione: TGefosConfigurazione; const Trasporto: IGefosTrasporto = nil);

    // GET /tipologieCorso
    function TipologieCorso(out Tipologie: TArray<TGefosTipologiaCorso>): TGefosRisposta;
    // GET /corsi/tipologiaCorsoId/{id}
    function CorsiPerTipologia(IdTipologia: Int64; out Corsi: TArray<TGefosCorsoLeggero>): TGefosRisposta;
    // GET /corso/{id}
    function LeggiCorso(IdCorso: Int64; out Corso: TGefosCorso): TGefosRisposta;
    // POST /corso: in IdCreato l'identificativo del corso
    function CreaCorso(IdTipologia: Int64): TGefosRisposta;
    // PUT /corso/{id}: solo se il corso non ha edizioni
    function ModificaCorso(IdCorso, IdTipologia: Int64): TGefosRisposta;
    // GET /corso/{id}/edizione/{id}
    function LeggiEdizione(IdCorso, IdEdizione: Int64; out Edizione: TGefosEdizione): TGefosRisposta;
    // POST /corso/{id}/edizione con il calendario intero: in IdCreato l'identificativo dell'edizione
    function CreaEdizione(IdCorso: Int64; const Edizione: TGefosEdizione): TGefosRisposta;
    // PUT /corso/{id}/edizione/{id}: azzera il calendario in GEFOS, che va reinviato
    function ModificaEdizione(IdCorso, IdEdizione: Int64; const Edizione: TGefosEdizione): TGefosRisposta;
    // PUT .../calendari con la lista intera degli slot
    function AggiornaCalendari(IdCorso, IdEdizione: Int64; MetodoEdizione: Integer; const Calendari: TArray<TGefosCalendario>): TGefosRisposta;
    // POST .../avvio: rifiuta in locale se le dichiarazioni non sono state accettate
    function ComunicaAvvio(IdCorso, IdEdizione: Int64; DichiarazioniAccettate: Boolean): TGefosRisposta;
    // POST .../partecipante: in IdCreato l'identificativo del partecipante
    function AggiungiPartecipante(IdCorso, IdEdizione: Int64; const Partecipante: TGefosPartecipante): TGefosRisposta;
    // DELETE .../partecipante/{id}
    function RimuoviPartecipante(IdCorso, IdEdizione, IdPartecipante: Int64): TGefosRisposta;
    // POST (Aggiorna = False) o PUT (Aggiorna = True) .../partecipante/esito
    function ComunicaEsito(IdCorso, IdEdizione: Int64; const Esito: TGefosEsitoPartecipante; Aggiorna: Boolean): TGefosRisposta;
    // POST .../esiti
    function ComunicaEsiti(IdCorso, IdEdizione: Int64; const Esiti: TArray<TGefosEsitoPartecipante>): TGefosRisposta;
    // POST .../conferma: irreversibile; rifiuta in locale se le dichiarazioni non sono state accettate
    function ConfermaConclusione(IdCorso, IdEdizione: Int64; DichiarazioniAccettate: Boolean): TGefosRisposta;
    // GET .../partecipante/{id}/attestato: PDF in Contenuto
    function ScaricaAttestato(IdCorso, IdEdizione, IdPartecipante: Int64): TGefosRisposta;
    // GET .../attestati: ZIP in Contenuto
    function ScaricaAttestati(IdCorso, IdEdizione: Int64): TGefosRisposta;

    // Dimentica il token: la chiamata successiva ne chiede uno nuovo
    procedure AzzeraToken;

    property Configurazione: TGefosConfigurazione read FConfigurazione;
    // Orologio sostituibile nelle prove per simulare la scadenza del token
    property Adesso: TFunc<TDateTime> read FAdesso write FAdesso;
    property OnChiamata: TGefosEventoChiamata read FOnChiamata write FOnChiamata;
  end;

// Serializzazione e lettura dei messaggi, pubbliche per le prove e per il registro
function GefosJsonEdizione(const Edizione: TGefosEdizione; ConCalendari: Boolean): TJSONObject;
function GefosJsonCalendario(MetodoEdizione: Integer; const Calendario: TGefosCalendario): TJSONObject;
function GefosJsonCalendari(MetodoEdizione: Integer; const Calendari: TArray<TGefosCalendario>): TJSONArray;
function GefosJsonPartecipante(const Partecipante: TGefosPartecipante): TJSONObject;
function GefosJsonEsito(const Esito: TGefosEsitoPartecipante): TJSONObject;

function GefosLeggiTipologia(Oggetto: TJSONObject): TGefosTipologiaCorso;
function GefosLeggiCalendario(Oggetto: TJSONObject): TGefosCalendario;
function GefosLeggiPartecipante(Oggetto: TJSONObject): TGefosPartecipante;
function GefosLeggiEdizioneJson(Oggetto: TJSONObject): TGefosEdizione;
function GefosLeggiCorsoJson(Oggetto: TJSONObject): TGefosCorso;
function GefosLeggiErrore(const Corpo: string; StatoHttp: Integer): TGefosErrore;

implementation

uses
  System.DateUtils,
  System.Diagnostics,
  System.NetEncoding,
  System.Net.URLClient,
  System.Net.HttpClient;

const
  // Il token vale 1800 secondi: lo si rinnova un minuto prima, per non farlo
  // scadere a meta' di una sequenza di chiamate
  MARGINE_RINNOVO_TOKEN_SECONDI = 60;

  TIPO_JSON = 'application/json';

{ Lettura prudente dei campi JSON: un campo assente o null non deve far fallire la lettura }

function CampoTesto(Oggetto: TJSONObject; const Nome: string): string;
var
  Valore: TJSONValue;
begin
  Valore := Oggetto.GetValue(Nome);
  if (Valore = nil) or (Valore is TJSONNull) then
    Result := ''
  else if Valore is TJSONString then
    Result := TJSONString(Valore).Value
  else
    Result := Valore.Value;
end;

function CampoIntero(Oggetto: TJSONObject; const Nome: string; Predefinito: Int64 = 0): Int64;
var
  Valore: TJSONValue;
begin
  Valore := Oggetto.GetValue(Nome);
  if Valore is TJSONNumber then
    Result := TJSONNumber(Valore).AsInt64
  else if Valore is TJSONString then
    Result := StrToInt64Def(TJSONString(Valore).Value, Predefinito)
  else
    Result := Predefinito;
end;

function CampoPresente(Oggetto: TJSONObject; const Nome: string): Boolean;
var
  Valore: TJSONValue;
begin
  Valore := Oggetto.GetValue(Nome);
  Result := (Valore <> nil) and not (Valore is TJSONNull);
end;

function CampoBooleano(Oggetto: TJSONObject; const Nome: string): Boolean;
begin
  Result := Oggetto.GetValue(Nome) is TJSONTrue;
end;

function CampoArray(Oggetto: TJSONObject; const Nome: string): TJSONArray;
var
  Valore: TJSONValue;
begin
  Valore := Oggetto.GetValue(Nome);
  if Valore is TJSONArray then
    Result := TJSONArray(Valore)
  else
    Result := nil;
end;

procedure AggiungiTestoSePresente(Oggetto: TJSONObject; const Nome, Valore: string);
begin
  if Trim(Valore) <> '' then
    Oggetto.AddPair(Nome, Trim(Valore));
end;

{ Serializzazione }

function GefosJsonCalendario(MetodoEdizione: Integer; const Calendario: TGefosCalendario): TJSONObject;
var
  Metodo: Integer;
begin
  Result := TJSONObject.Create;
  try
    if Calendario.Id <> 0 then
      Result.AddPair('id', TJSONNumber.Create(Calendario.Id));
    Result.AddPair('dataOraDa', GefosFormatoDataOra(Calendario.DataOraDa));
    Result.AddPair('dataOraA', GefosFormatoDataOra(Calendario.DataOraA));
    // Il metodo della giornata e' obbligatorio nelle edizioni miste e vietato nelle
    // altre (errore CALENDARIO_METODO_GIORNATA_NON_AMMESSO): si scrive solo se serve
    if MetodoEdizione = GEFOS_METODO_MISTA then
      Result.AddPair('metodoSvolgimentoGiornataId', TJSONNumber.Create(Calendario.MetodoGiornata));

    // Si inviano solo i campi del metodo effettivo della giornata (sezione 4.7)
    Metodo := GefosMetodoEffettivo(MetodoEdizione, Calendario);
    case Metodo of
      GEFOS_METODO_PRESENZA_FISICA:
        begin
          AggiungiTestoSePresente(Result, 'indirizzo', Calendario.Indirizzo);
          AggiungiTestoSePresente(Result, 'nCivico', Calendario.NumeroCivico);
          AggiungiTestoSePresente(Result, 'cap', Calendario.Cap);
          AggiungiTestoSePresente(Result, 'citta', Calendario.Citta);
          AggiungiTestoSePresente(Result, 'provincia', Calendario.Provincia);
        end;
      GEFOS_METODO_VIDEO_CONFERENZA:
        AggiungiTestoSePresente(Result, 'link', Calendario.Link);
    end;
  except
    Result.Free;
    raise;
  end;
end;

function GefosJsonCalendari(MetodoEdizione: Integer; const Calendari: TArray<TGefosCalendario>): TJSONArray;
var
  Calendario: TGefosCalendario;
begin
  Result := TJSONArray.Create;
  try
    for Calendario in Calendari do
      Result.AddElement(GefosJsonCalendario(MetodoEdizione, Calendario));
  except
    Result.Free;
    raise;
  end;
end;

function GefosJsonEdizione(const Edizione: TGefosEdizione; ConCalendari: Boolean): TJSONObject;
begin
  Result := TJSONObject.Create;
  try
    Result.AddPair('metodoSvolgimentoId', TJSONNumber.Create(Edizione.MetodoSvolgimento));
    Result.AddPair('dataOraInizio', GefosFormatoDataOra(Edizione.DataOraInizio));
    Result.AddPair('dataOraFine', GefosFormatoData(Edizione.DataFine));
    if ConCalendari then
      Result.AddPair('calendari', GefosJsonCalendari(Edizione.MetodoSvolgimento, Edizione.Calendari));
  except
    Result.Free;
    raise;
  end;
end;

function GefosJsonPartecipante(const Partecipante: TGefosPartecipante): TJSONObject;
begin
  // L'id non si invia all'iscrizione, e nemmeno l'esito (sezione 4.6)
  Result := TJSONObject.Create;
  try
    Result.AddPair('nome', Trim(Partecipante.Nome));
    Result.AddPair('cognome', Trim(Partecipante.Cognome));
    AggiungiTestoSePresente(Result, 'codiceFiscale', UpperCase(Partecipante.CodiceFiscale));
    AggiungiTestoSePresente(Result, 'codiceIdentificativoEstero', Partecipante.CodiceIdentificativoEstero);
    if Partecipante.DataNascita <> 0 then
      Result.AddPair('dataNascita', GefosFormatoData(Partecipante.DataNascita));
    AggiungiTestoSePresente(Result, 'statoNascita', Partecipante.StatoNascita);
    AggiungiTestoSePresente(Result, 'provinciaNascita', Partecipante.ProvinciaNascita);
    AggiungiTestoSePresente(Result, 'comuneNascita', Partecipante.ComuneNascita);
    Result.AddPair('email', Trim(Partecipante.Email));
  except
    Result.Free;
    raise;
  end;
end;

function GefosJsonEsito(const Esito: TGefosEsitoPartecipante): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('id', TJSONNumber.Create(Esito.IdPartecipante));
  Result.AddPair('esitoId', TJSONNumber.Create(Esito.Esito));
end;

function JsonDichiarazioni(Accettate: Boolean): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('dichiarazioniAccettate', TJSONBool.Create(Accettate));
end;

{ Lettura }

function GefosLeggiTipologia(Oggetto: TJSONObject): TGefosTipologiaCorso;
var
  Metodi: TJSONArray;
  Indice: Integer;
begin
  Result := Default(TGefosTipologiaCorso);
  Result.Id := CampoIntero(Oggetto, 'id');
  Result.Descrizione := CampoTesto(Oggetto, 'descrizione');
  Result.IdDenominazione := CampoIntero(Oggetto, 'idDenominazione');
  Result.DescrizioneDenominazione := CampoTesto(Oggetto, 'descrDenominazione');
  // monteOre e' sempre presente ma puo' essere null: allora non c'e' un minimo
  Result.HaMonteOre := CampoPresente(Oggetto, 'monteOre');
  if Result.HaMonteOre then
    Result.MonteOre := CampoIntero(Oggetto, 'monteOre');
  Metodi := CampoArray(Oggetto, 'metodiSvolgimento');
  if Metodi <> nil then
  begin
    SetLength(Result.MetodiSvolgimento, Metodi.Count);
    for Indice := 0 to Metodi.Count - 1 do
      if Metodi.Items[Indice] is TJSONNumber then
        Result.MetodiSvolgimento[Indice] := TJSONNumber(Metodi.Items[Indice]).AsInt
      else
        Result.MetodiSvolgimento[Indice] := StrToIntDef(Metodi.Items[Indice].Value, 0);
  end;
end;

function GefosLeggiCalendario(Oggetto: TJSONObject): TGefosCalendario;
begin
  Result := Default(TGefosCalendario);
  Result.Id := CampoIntero(Oggetto, 'id');
  Result.DataOraDa := GefosLeggiDataOra(CampoTesto(Oggetto, 'dataOraDa'));
  Result.DataOraA := GefosLeggiDataOra(CampoTesto(Oggetto, 'dataOraA'));
  Result.MetodoGiornata := CampoIntero(Oggetto, 'metodoSvolgimentoGiornataId');
  Result.Link := CampoTesto(Oggetto, 'link');
  Result.Indirizzo := CampoTesto(Oggetto, 'indirizzo');
  Result.NumeroCivico := CampoTesto(Oggetto, 'nCivico');
  Result.Cap := CampoTesto(Oggetto, 'cap');
  Result.Citta := CampoTesto(Oggetto, 'citta');
  Result.Provincia := CampoTesto(Oggetto, 'provincia');
end;

function GefosLeggiPartecipante(Oggetto: TJSONObject): TGefosPartecipante;
var
  DataNascita: string;
begin
  Result := Default(TGefosPartecipante);
  Result.Id := CampoIntero(Oggetto, 'id');
  Result.Nome := CampoTesto(Oggetto, 'nome');
  Result.Cognome := CampoTesto(Oggetto, 'cognome');
  Result.CodiceFiscale := CampoTesto(Oggetto, 'codiceFiscale');
  Result.CodiceIdentificativoEstero := CampoTesto(Oggetto, 'codiceIdentificativoEstero');
  DataNascita := CampoTesto(Oggetto, 'dataNascita');
  if DataNascita <> '' then
    Result.DataNascita := GefosLeggiData(DataNascita);
  Result.StatoNascita := CampoTesto(Oggetto, 'statoNascita');
  Result.ProvinciaNascita := CampoTesto(Oggetto, 'provinciaNascita');
  Result.ComuneNascita := CampoTesto(Oggetto, 'comuneNascita');
  Result.Email := CampoTesto(Oggetto, 'email');
  Result.Esito := CampoIntero(Oggetto, 'esitoId');
end;

function GefosLeggiEdizioneJson(Oggetto: TJSONObject): TGefosEdizione;
var
  Elenco: TJSONArray;
  Indice: Integer;
begin
  Result := Default(TGefosEdizione);
  Result.Id := CampoIntero(Oggetto, 'id');
  Result.Avviata := CampoBooleano(Oggetto, 'avviata');
  Result.MetodoSvolgimento := CampoIntero(Oggetto, 'metodoSvolgimentoId');
  Result.DataOraInizio := GefosLeggiDataOra(CampoTesto(Oggetto, 'dataOraInizio'));
  Result.DataFine := GefosLeggiData(CampoTesto(Oggetto, 'dataOraFine'));

  Elenco := CampoArray(Oggetto, 'partecipanti');
  if Elenco <> nil then
  begin
    SetLength(Result.Partecipanti, Elenco.Count);
    for Indice := 0 to Elenco.Count - 1 do
      Result.Partecipanti[Indice] := GefosLeggiPartecipante(Elenco.Items[Indice] as TJSONObject);
  end;

  Elenco := CampoArray(Oggetto, 'calendari');
  if Elenco <> nil then
  begin
    SetLength(Result.Calendari, Elenco.Count);
    for Indice := 0 to Elenco.Count - 1 do
      Result.Calendari[Indice] := GefosLeggiCalendario(Elenco.Items[Indice] as TJSONObject);
  end;
end;

function GefosLeggiCorsoJson(Oggetto: TJSONObject): TGefosCorso;
var
  Elenco: TJSONArray;
  Indice: Integer;
begin
  Result := Default(TGefosCorso);
  Result.Id := CampoIntero(Oggetto, 'id');
  Result.IdTipologiaCorso := CampoIntero(Oggetto, 'tipologiaCorsoId');
  Elenco := CampoArray(Oggetto, 'edizioni');
  if Elenco <> nil then
  begin
    SetLength(Result.Edizioni, Elenco.Count);
    for Indice := 0 to Elenco.Count - 1 do
      Result.Edizioni[Indice] := GefosLeggiEdizioneJson(Elenco.Items[Indice] as TJSONObject);
  end;
end;

function GefosLeggiErrore(const Corpo: string; StatoHttp: Integer): TGefosErrore;
var
  Valore: TJSONValue;
  Oggetto: TJSONObject;
begin
  Result := Default(TGefosErrore);
  Result.Stato := StatoHttp;
  Valore := TJSONObject.ParseJSONValue(Corpo);
  try
    if Valore is TJSONObject then
    begin
      Oggetto := TJSONObject(Valore);
      Result.Titolo := CampoTesto(Oggetto, 'title');
      Result.Codice := CampoTesto(Oggetto, 'code');
      Result.Dettaglio := CampoTesto(Oggetto, 'detail');
      if CampoPresente(Oggetto, 'status') then
        Result.Stato := CampoIntero(Oggetto, 'status', StatoHttp);
    end
    else
      // Risposta non JSON (pagina del gestore delle API, proxy...): si conserva il testo
      Result.Dettaglio := Copy(Trim(Corpo), 1, 500);
  finally
    Valore.Free;
  end;
end;

function TestoDaByte(const Dati: TBytes): string;
begin
  if Length(Dati) = 0 then
    Result := ''
  else
    Result := TEncoding.UTF8.GetString(Dati);
end;

function ContenutoTestuale(const TipoContenuto: string): Boolean;
var
  Tipo: string;
begin
  Tipo := LowerCase(TipoContenuto);
  Result := (Tipo = '') or Tipo.Contains('json') or Tipo.StartsWith('text/') or Tipo.Contains('xml');
end;

{ TGefosIntestazione }

class function TGefosIntestazione.Create(const Nome, Valore: string): TGefosIntestazione;
begin
  Result.Nome := Nome;
  Result.Valore := Valore;
end;

{ TGefosTrasportoHttp }

constructor TGefosTrasportoHttp.Create(TimeoutConnessioneMs, TimeoutRispostaMs: Integer);
begin
  inherited Create;
  FTimeoutConnessioneMs := TimeoutConnessioneMs;
  FTimeoutRispostaMs := TimeoutRispostaMs;
end;

function TGefosTrasportoHttp.Esegui(const Richiesta: TGefosRichiestaHttp): TGefosRispostaHttp;
var
  Http: THTTPClient;
  Intestazioni: TNetHeaders;
  Indice: Integer;
  Corpo: TStringStream;
  Ricevuto: TBytesStream;
  Risposta: IHTTPResponse;
begin
  Result := Default(TGefosRispostaHttp);
  Http := THTTPClient.Create;
  Corpo := nil;
  Ricevuto := TBytesStream.Create;
  try
    if FTimeoutConnessioneMs > 0 then
      Http.ConnectionTimeout := FTimeoutConnessioneMs;
    if FTimeoutRispostaMs > 0 then
      Http.ResponseTimeout := FTimeoutRispostaMs;

    SetLength(Intestazioni, Length(Richiesta.Intestazioni));
    for Indice := 0 to High(Richiesta.Intestazioni) do
      Intestazioni[Indice] := TNameValuePair.Create(Richiesta.Intestazioni[Indice].Nome, Richiesta.Intestazioni[Indice].Valore);

    try
      if SameText(Richiesta.Metodo, 'GET') then
        Risposta := Http.Get(Richiesta.Url, Ricevuto, Intestazioni)
      else if SameText(Richiesta.Metodo, 'DELETE') then
        Risposta := Http.Delete(Richiesta.Url, Ricevuto, Intestazioni)
      else
      begin
        Corpo := TStringStream.Create(Richiesta.Corpo, TEncoding.UTF8, False);
        if SameText(Richiesta.Metodo, 'PUT') then
          Risposta := Http.Put(Richiesta.Url, Corpo, Ricevuto, Intestazioni)
        else if SameText(Richiesta.Metodo, 'POST') then
          Risposta := Http.Post(Richiesta.Url, Corpo, Ricevuto, Intestazioni)
        else
          raise EGefosErrore.CreateFmt('Metodo HTTP non previsto: %s', [Richiesta.Metodo]);
      end;
    except
      on Errore: EGefosErrore do
        raise;
      on Errore: Exception do
        raise EGefosTrasporto.CreateFmt('Comunicazione con GEFOS non riuscita (%s): %s', [Richiesta.Url, Errore.Message]);
    end;

    Result.Stato := Risposta.StatusCode;
    Result.TipoContenuto := Risposta.MimeType;
    Result.Corpo := Copy(Ricevuto.Bytes, 0, Ricevuto.Size);
  finally
    Ricevuto.Free;
    Corpo.Free;
    Http.Free;
  end;
end;

{ TGefosClient }

constructor TGefosClient.Create(const Configurazione: TGefosConfigurazione; const Trasporto: IGefosTrasporto);
begin
  inherited Create;
  FConfigurazione := Configurazione;
  if FConfigurazione.Scope = '' then
    FConfigurazione.Scope := 'gefos';
  if Trasporto <> nil then
    FTrasporto := Trasporto
  else
    FTrasporto := TGefosTrasportoHttp.Create(Configurazione.TimeoutConnessioneMs, Configurazione.TimeoutRispostaMs);
  FAdesso :=
    function: TDateTime
    begin
      Result := Now;
    end;
end;

procedure TGefosClient.AzzeraToken;
begin
  FToken := '';
  FScadenzaToken := 0;
end;

function TGefosClient.UrlCompleto(const Percorso: string): string;
var
  Base: string;
begin
  Base := FConfigurazione.UrlBase;
  while Base.EndsWith('/') do
    Base := Copy(Base, 1, Length(Base) - 1);
  Result := Base + Percorso;
end;

function TGefosClient.PercorsoEdizione(IdCorso, IdEdizione: Int64): string;
begin
  Result := Format('/corso/%d/edizione/%d', [IdCorso, IdEdizione]);
end;

function TGefosClient.TokenValido: Boolean;
begin
  Result := (FToken <> '') and (FAdesso() < FScadenzaToken);
end;

procedure TGefosClient.Notifica(const Risposta: TGefosRisposta);
begin
  if Assigned(FOnChiamata) then
    FOnChiamata(Risposta);
end;

function TGefosClient.RichiediToken(out Risposta: TGefosRisposta): Boolean;
var
  Richiesta: TGefosRichiestaHttp;
  RispostaHttp: TGefosRispostaHttp;
  Credenziali: string;
  Valore: TJSONValue;
  Oggetto: TJSONObject;
  Durata: Int64;
  Cronometro: TStopwatch;
begin
  AzzeraToken;
  Risposta := Default(TGefosRisposta);
  Risposta.Operazione := goToken;
  Risposta.MetodoHttp := 'POST';
  Risposta.Url := FConfigurazione.UrlToken;

  if (FConfigurazione.ClientId = '') or (FConfigurazione.ClientSecret = '') then
  begin
    Risposta.Errore.Codice := GEFOS_ERRORE_TOKEN;
    Risposta.Errore.Dettaglio := 'Credenziali di GEFOS non configurate per l''ente.';
    Notifica(Risposta);
    Exit(False);
  end;

  // Il segreto non entra mai in CorpoRichiesta, che finisce nel registro delle chiamate
  Credenziali := TNetEncoding.Base64String.Encode(FConfigurazione.ClientId + ':' + FConfigurazione.ClientSecret);
  Credenziali := Credenziali.Replace(#13, '').Replace(#10, '');
  Richiesta.Metodo := 'POST';
  Richiesta.Url := FConfigurazione.UrlToken;
  Richiesta.Corpo := 'grant_type=client_credentials&scope=' + TNetEncoding.URL.Encode(FConfigurazione.Scope);
  Richiesta.Intestazioni := [
    TGefosIntestazione.Create('Authorization', 'Basic ' + Credenziali),
    TGefosIntestazione.Create('Content-Type', 'application/x-www-form-urlencoded'),
    TGefosIntestazione.Create('Accept', TIPO_JSON)];
  Risposta.CorpoRichiesta := Richiesta.Corpo;

  Cronometro := TStopwatch.StartNew;
  try
    RispostaHttp := FTrasporto.Esegui(Richiesta);
  except
    on Errore: EGefosTrasporto do
    begin
      Risposta.DurataMs := Cronometro.ElapsedMilliseconds;
      Risposta.Errore.Codice := GEFOS_ERRORE_TRASPORTO;
      Risposta.Errore.Dettaglio := Errore.Message;
      Notifica(Risposta);
      Exit(False);
    end;
  end;
  Risposta.DurataMs := Cronometro.ElapsedMilliseconds;
  Risposta.StatoHttp := RispostaHttp.Stato;
  Risposta.CorpoRisposta := TestoDaByte(RispostaHttp.Corpo);

  Valore := nil;
  if (RispostaHttp.Stato >= 200) and (RispostaHttp.Stato < 300) then
    Valore := TJSONObject.ParseJSONValue(Risposta.CorpoRisposta);
  try
    if Valore is TJSONObject then
    begin
      Oggetto := TJSONObject(Valore);
      FToken := CampoTesto(Oggetto, 'access_token');
      Durata := CampoIntero(Oggetto, 'expires_in', 1800);
      if Durata > MARGINE_RINNOVO_TOKEN_SECONDI * 2 then
        Durata := Durata - MARGINE_RINNOVO_TOKEN_SECONDI;
      FScadenzaToken := IncSecond(FAdesso(), Durata);
    end;
  finally
    Valore.Free;
  end;

  // Il token non va nel registro: la risposta si conserva senza il suo valore
  Risposta.CorpoRisposta := '';
  Risposta.Riuscita := FToken <> '';
  if not Risposta.Riuscita then
  begin
    Risposta.Errore.Stato := RispostaHttp.Stato;
    Risposta.Errore.Codice := GEFOS_ERRORE_TOKEN;
    Risposta.Errore.Dettaglio := Format('Token non ottenuto dal gestore delle API (HTTP %d).', [RispostaHttp.Stato]);
    // Le richieste di token riuscite non si registrano: sarebbero una ogni mezz'ora
    Notifica(Risposta);
  end;
  Result := Risposta.Riuscita;
end;

function TGefosClient.Chiama(Operazione: TGefosOperazione; const Metodo, Percorso, Corpo, Accetta: string): TGefosRisposta;
var
  Richiesta: TGefosRichiestaHttp;
  RispostaHttp: TGefosRispostaHttp;
  RispostaToken: TGefosRisposta;
  Tentativo: Integer;
  Cronometro: TStopwatch;
  Valore: TJSONValue;
begin
  Result := Default(TGefosRisposta);
  Result.Operazione := Operazione;
  Result.MetodoHttp := Metodo;
  Result.Url := UrlCompleto(Percorso);
  Result.CorpoRichiesta := Corpo;
  Result.DichiarazioniAccettate := FDichiarazioniAccettate;

  Richiesta.Metodo := Metodo;
  Richiesta.Url := Result.Url;
  Richiesta.Corpo := Corpo;

  for Tentativo := 1 to 2 do
  begin
    if not TokenValido then
      if not RichiediToken(RispostaToken) then
      begin
        Result.Errore := RispostaToken.Errore;
        Result.StatoHttp := RispostaToken.StatoHttp;
        Result.DurataMs := RispostaToken.DurataMs;
        Notifica(Result);
        Exit;
      end;

    Richiesta.Intestazioni := [
      TGefosIntestazione.Create('Authorization', 'Bearer ' + FToken),
      TGefosIntestazione.Create('X-Gefos-Ente-Erogatore', FConfigurazione.EnteErogatore),
      TGefosIntestazione.Create('Accept', Accetta)];
    if Corpo <> '' then
      Richiesta.Intestazioni := Richiesta.Intestazioni + [TGefosIntestazione.Create('Content-Type', TIPO_JSON)];

    Cronometro := TStopwatch.StartNew;
    try
      RispostaHttp := FTrasporto.Esegui(Richiesta);
    except
      on Errore: EGefosTrasporto do
      begin
        Result.DurataMs := Cronometro.ElapsedMilliseconds;
        Result.Errore.Codice := GEFOS_ERRORE_TRASPORTO;
        Result.Errore.Dettaglio := Errore.Message;
        Notifica(Result);
        Exit;
      end;
    end;
    Result.DurataMs := Cronometro.ElapsedMilliseconds;

    // Un 401 con un token creduto valido vuol dire che il gestore lo ha revocato
    // o che l'orologio locale e' avanti: si chiede un token nuovo e si riprova una volta
    if (RispostaHttp.Stato = 401) and (Tentativo = 1) then
    begin
      AzzeraToken;
      Continue;
    end;
    Break;
  end;

  Result.StatoHttp := RispostaHttp.Stato;
  Result.TipoContenuto := RispostaHttp.TipoContenuto;
  Result.Riuscita := (RispostaHttp.Stato >= 200) and (RispostaHttp.Stato < 300);

  if Result.Riuscita and not ContenutoTestuale(RispostaHttp.TipoContenuto) then
    Result.Contenuto := RispostaHttp.Corpo
  else
    Result.CorpoRisposta := TestoDaByte(RispostaHttp.Corpo);

  if Result.Riuscita then
  begin
    // Le creazioni restituiscono {"id": ...}
    if Result.CorpoRisposta <> '' then
    begin
      Valore := TJSONObject.ParseJSONValue(Result.CorpoRisposta);
      try
        if Valore is TJSONObject then
          Result.IdCreato := CampoIntero(TJSONObject(Valore), 'id');
      finally
        Valore.Free;
      end;
    end;
  end
  else
    Result.Errore := GefosLeggiErrore(Result.CorpoRisposta, RispostaHttp.Stato);

  Notifica(Result);
end;

function TGefosClient.ChiamaConJson(Operazione: TGefosOperazione; const Metodo, Percorso: string; Corpo: TJSONValue): TGefosRisposta;
var
  Testo: string;
begin
  try
    Testo := Corpo.ToJSON;
  finally
    Corpo.Free;
  end;
  Result := Chiama(Operazione, Metodo, Percorso, Testo, TIPO_JSON);
end;

function TGefosClient.TipologieCorso(out Tipologie: TArray<TGefosTipologiaCorso>): TGefosRisposta;
var
  Valore: TJSONValue;
  Elenco: TJSONArray;
  Indice: Integer;
begin
  Tipologie := nil;
  Result := Chiama(goTipologieCorso, 'GET', '/tipologieCorso', '', TIPO_JSON);
  if not Result.Riuscita then
    Exit;
  Valore := TJSONObject.ParseJSONValue(Result.CorpoRisposta);
  try
    if not (Valore is TJSONArray) then
      raise EGefosErrore.Create('Risposta di GET /tipologieCorso non riconosciuta: attesa una lista.');
    Elenco := TJSONArray(Valore);
    SetLength(Tipologie, Elenco.Count);
    for Indice := 0 to Elenco.Count - 1 do
      Tipologie[Indice] := GefosLeggiTipologia(Elenco.Items[Indice] as TJSONObject);
  finally
    Valore.Free;
  end;
end;

function TGefosClient.CorsiPerTipologia(IdTipologia: Int64; out Corsi: TArray<TGefosCorsoLeggero>): TGefosRisposta;
var
  Valore: TJSONValue;
  Elenco: TJSONArray;
  Indice: Integer;
begin
  Corsi := nil;
  Result := Chiama(goCorsiPerTipologia, 'GET', Format('/corsi/tipologiaCorsoId/%d', [IdTipologia]), '', TIPO_JSON);
  if not Result.Riuscita then
    Exit;
  Valore := TJSONObject.ParseJSONValue(Result.CorpoRisposta);
  try
    if Valore is TJSONArray then
    begin
      Elenco := TJSONArray(Valore);
      SetLength(Corsi, Elenco.Count);
      for Indice := 0 to Elenco.Count - 1 do
      begin
        Corsi[Indice].Id := CampoIntero(Elenco.Items[Indice] as TJSONObject, 'id');
        Corsi[Indice].IdTipologiaCorso := CampoIntero(Elenco.Items[Indice] as TJSONObject, 'tipologiaCorsoId');
      end;
    end;
  finally
    Valore.Free;
  end;
end;

function TGefosClient.LeggiCorso(IdCorso: Int64; out Corso: TGefosCorso): TGefosRisposta;
var
  Valore: TJSONValue;
begin
  Corso := Default(TGefosCorso);
  Result := Chiama(goLeggiCorso, 'GET', Format('/corso/%d', [IdCorso]), '', TIPO_JSON);
  if not Result.Riuscita then
    Exit;
  Valore := TJSONObject.ParseJSONValue(Result.CorpoRisposta);
  try
    if Valore is TJSONObject then
      Corso := GefosLeggiCorsoJson(TJSONObject(Valore));
  finally
    Valore.Free;
  end;
end;

function TGefosClient.CreaCorso(IdTipologia: Int64): TGefosRisposta;
var
  Corpo: TJSONObject;
begin
  Corpo := TJSONObject.Create;
  Corpo.AddPair('tipologiaCorsoId', TJSONNumber.Create(IdTipologia));
  Result := ChiamaConJson(goCreaCorso, 'POST', '/corso', Corpo);
end;

function TGefosClient.ModificaCorso(IdCorso, IdTipologia: Int64): TGefosRisposta;
var
  Corpo: TJSONObject;
begin
  Corpo := TJSONObject.Create;
  Corpo.AddPair('tipologiaCorsoId', TJSONNumber.Create(IdTipologia));
  Result := ChiamaConJson(goModificaCorso, 'PUT', Format('/corso/%d', [IdCorso]), Corpo);
end;

function TGefosClient.LeggiEdizione(IdCorso, IdEdizione: Int64; out Edizione: TGefosEdizione): TGefosRisposta;
var
  Valore: TJSONValue;
begin
  Edizione := Default(TGefosEdizione);
  Result := Chiama(goLeggiEdizione, 'GET', PercorsoEdizione(IdCorso, IdEdizione), '', TIPO_JSON);
  if not Result.Riuscita then
    Exit;
  Valore := TJSONObject.ParseJSONValue(Result.CorpoRisposta);
  try
    if Valore is TJSONObject then
      Edizione := GefosLeggiEdizioneJson(TJSONObject(Valore));
  finally
    Valore.Free;
  end;
end;

function TGefosClient.CreaEdizione(IdCorso: Int64; const Edizione: TGefosEdizione): TGefosRisposta;
begin
  Result := ChiamaConJson(goCreaEdizione, 'POST', Format('/corso/%d/edizione', [IdCorso]), GefosJsonEdizione(Edizione, True));
end;

function TGefosClient.ModificaEdizione(IdCorso, IdEdizione: Int64; const Edizione: TGefosEdizione): TGefosRisposta;
begin
  Result := ChiamaConJson(goModificaEdizione, 'PUT', PercorsoEdizione(IdCorso, IdEdizione), GefosJsonEdizione(Edizione, False));
end;

function TGefosClient.AggiornaCalendari(IdCorso, IdEdizione: Int64; MetodoEdizione: Integer; const Calendari: TArray<TGefosCalendario>): TGefosRisposta;
begin
  // Il metodo dell'edizione serve a scegliere i campi di ogni slot (sezione 4.7)
  Result := ChiamaConJson(goAggiornaCalendari, 'PUT', PercorsoEdizione(IdCorso, IdEdizione) + '/calendari',
    GefosJsonCalendari(MetodoEdizione, Calendari));
end;

function TGefosClient.ComunicaAvvio(IdCorso, IdEdizione: Int64; DichiarazioniAccettate: Boolean): TGefosRisposta;
begin
  // Le dichiarazioni valgono come dichiarazione sostitutiva (art. 76 DPR 445/2000):
  // senza l'accettazione esplicita dell'operatore non si chiama nemmeno il servizio
  if not DichiarazioniAccettate then
    raise EGefosErrore.Create('Avvio non comunicato: le dichiarazioni non sono state accettate.');
  Result := ChiamaConDichiarazioni(goAvvio, PercorsoEdizione(IdCorso, IdEdizione) + '/avvio');
end;

function TGefosClient.ChiamaConDichiarazioni(Operazione: TGefosOperazione; const Percorso: string): TGefosRisposta;
begin
  FDichiarazioniAccettate := True;
  try
    Result := ChiamaConJson(Operazione, 'POST', Percorso, JsonDichiarazioni(True));
  finally
    FDichiarazioniAccettate := False;
  end;
end;

function TGefosClient.AggiungiPartecipante(IdCorso, IdEdizione: Int64; const Partecipante: TGefosPartecipante): TGefosRisposta;
begin
  Result := ChiamaConJson(goAggiungiPartecipante, 'POST', PercorsoEdizione(IdCorso, IdEdizione) + '/partecipante',
    GefosJsonPartecipante(Partecipante));
end;

function TGefosClient.RimuoviPartecipante(IdCorso, IdEdizione, IdPartecipante: Int64): TGefosRisposta;
begin
  Result := Chiama(goRimuoviPartecipante, 'DELETE',
    Format('%s/partecipante/%d', [PercorsoEdizione(IdCorso, IdEdizione), IdPartecipante]), '', '*/*');
end;

function TGefosClient.ComunicaEsito(IdCorso, IdEdizione: Int64; const Esito: TGefosEsitoPartecipante; Aggiorna: Boolean): TGefosRisposta;
begin
  // Stesso percorso, verbo diverso: POST inserisce, PUT aggiorna (sezioni 3.13 e 3.14)
  if Aggiorna then
    Result := ChiamaConJson(goAggiornaEsito, 'PUT', PercorsoEdizione(IdCorso, IdEdizione) + '/partecipante/esito', GefosJsonEsito(Esito))
  else
    Result := ChiamaConJson(goInserisciEsito, 'POST', PercorsoEdizione(IdCorso, IdEdizione) + '/partecipante/esito', GefosJsonEsito(Esito));
end;

function TGefosClient.ComunicaEsiti(IdCorso, IdEdizione: Int64; const Esiti: TArray<TGefosEsitoPartecipante>): TGefosRisposta;
var
  Elenco: TJSONArray;
  Esito: TGefosEsitoPartecipante;
begin
  Elenco := TJSONArray.Create;
  for Esito in Esiti do
    Elenco.AddElement(GefosJsonEsito(Esito));
  Result := ChiamaConJson(goInserisciEsiti, 'POST', PercorsoEdizione(IdCorso, IdEdizione) + '/esiti', Elenco);
end;

function TGefosClient.ConfermaConclusione(IdCorso, IdEdizione: Int64; DichiarazioniAccettate: Boolean): TGefosRisposta;
begin
  if not DichiarazioniAccettate then
    raise EGefosErrore.Create('Conclusione non confermata: le dichiarazioni non sono state accettate.');
  Result := ChiamaConDichiarazioni(goConfermaConclusione, PercorsoEdizione(IdCorso, IdEdizione) + '/conferma');
end;

function TGefosClient.ScaricaAttestato(IdCorso, IdEdizione, IdPartecipante: Int64): TGefosRisposta;
begin
  Result := Chiama(goAttestato, 'GET',
    Format('%s/partecipante/%d/attestato', [PercorsoEdizione(IdCorso, IdEdizione), IdPartecipante]), '', 'application/pdf');
end;

function TGefosClient.ScaricaAttestati(IdCorso, IdEdizione: Int64): TGefosRisposta;
begin
  Result := Chiama(goAttestati, 'GET', PercorsoEdizione(IdCorso, IdEdizione) + '/attestati', '', 'application/zip');
end;

end.
