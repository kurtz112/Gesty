// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-05
// ---------------------------------------------------------------------------
unit Gefos.Types;

// Oggetti dell'API di GE.FO.S. (Regione Lombardia, gestione formazione sicurezza),
// secondo la specifica "GEFOS - Documento Integrazione API" v2.3 del 21/09/2026.
// La unit non dipende da Gesty: l'aggancio al database sta nel DataModule ponte.

interface

uses
  System.SysUtils,
  System.DateUtils,
  System.Generics.Collections;

const
  // Metodo di svolgimento dell'edizione (sezione 6.1)
  GEFOS_METODO_PRESENZA_FISICA   = 1;
  GEFOS_METODO_E_LEARNING        = 2;
  GEFOS_METODO_VIDEO_CONFERENZA  = 3;
  GEFOS_METODO_MISTA             = 4;

  // Esito del partecipante (sezione 6.3)
  GEFOS_ESITO_SUPERATO      = 1;
  GEFOS_ESITO_NON_SUPERATO  = 2;
  GEFOS_ESITO_NON_AMMESSO   = 3;

  // Limiti di iscrizione (sezione 3.10)
  GEFOS_MASSIMO_PARTECIPANTI_PRESENZA    = 30;
  GEFOS_MASSIMO_PARTECIPANTI_E_LEARNING  = 1;

  // Giorni entro cui va confermata la conclusione, dalla data di fine (sezione 3.0.2)
  GEFOS_GIORNI_PER_CONFERMA = 30;

  // Codici di errore che non arrivano da GEFOS ma nascono prima della sua risposta
  GEFOS_ERRORE_TRASPORTO = 'TRASPORTO';
  GEFOS_ERRORE_TOKEN     = 'TOKEN';

type
  EGefosErrore = class(Exception);

  // Operazione chiamata: il codice di tre lettere e' quello del dominio GEFOS_OPERAZIONE
  TGefosOperazione = (
    goToken,
    goTipologieCorso,
    goCorsiPerTipologia,
    goLeggiCorso,
    goCreaCorso,
    goModificaCorso,
    goLeggiEdizione,
    goCreaEdizione,
    goModificaEdizione,
    goAggiornaCalendari,
    goAvvio,
    goAggiungiPartecipante,
    goRimuoviPartecipante,
    goInserisciEsito,
    goAggiornaEsito,
    goInserisciEsiti,
    goConfermaConclusione,
    goAttestato,
    goAttestati);

  TGefosConfigurazione = record
    UrlToken: string;
    UrlBase: string;
    Scope: string;
    ClientId: string;
    ClientSecret: string;
    // Codice fiscale o partita IVA dell'ente: intestazione X-Gefos-Ente-Erogatore
    EnteErogatore: string;
    TimeoutConnessioneMs: Integer;
    TimeoutRispostaMs: Integer;
    class function Create(const UrlToken, UrlBase, ClientId, ClientSecret, EnteErogatore: string): TGefosConfigurazione; static;
  end;

  // Errore nel formato restituito da GEFOS (title, status, code, detail)
  TGefosErrore = record
    Titolo: string;
    Stato: Integer;
    Codice: string;
    Dettaglio: string;
    function IsVuoto: Boolean;
    // Messaggio comprensibile per l'operatore, scelto dal codice e non dal testo
    function MessaggioOperatore: string;
  end;

  TGefosTipologiaCorso = record
    Id: Int64;
    Descrizione: string;
    IdDenominazione: Integer;
    DescrizioneDenominazione: string;
    // Ore minime del calendario; senza valore quando HaMonteOre = False
    MonteOre: Integer;
    HaMonteOre: Boolean;
    MetodiSvolgimento: TArray<Integer>;
    function AmmetteMetodo(Metodo: Integer): Boolean;
    function MetodiSvolgimentoTesto: string;
  end;

  // Uno slot del calendario (sezione 4.7)
  TGefosCalendario = record
    // 0 = slot nuovo; va reinviato negli aggiornamenti per gli slot gia' esistenti
    Id: Int64;
    DataOraDa: TDateTime;
    DataOraA: TDateTime;
    // Solo per le edizioni miste; 0 = non indicato
    MetodoGiornata: Integer;
    Link: string;
    Indirizzo: string;
    NumeroCivico: string;
    Cap: string;
    Citta: string;
    // Nome per esteso (es. "Milano"), non la sigla
    Provincia: string;
    function DurataMinuti: Integer;
  end;

  // Partecipante (sezione 4.6)
  TGefosPartecipante = record
    // Restituito da GEFOS all'iscrizione; 0 = non ancora iscritto
    Id: Int64;
    Nome: string;
    Cognome: string;
    CodiceFiscale: string;
    CodiceIdentificativoEstero: string;
    // 0 = non indicata
    DataNascita: TDate;
    // Descrizione o codice GEFOS (es. "Italia" o "ITA")
    StatoNascita: string;
    ProvinciaNascita: string;
    ComuneNascita: string;
    Email: string;
    // 0 = nessun esito
    Esito: Integer;
    function NatoInItalia: Boolean;
    function Nominativo: string;
  end;

  TGefosEsitoPartecipante = record
    IdPartecipante: Int64;
    Esito: Integer;
    class function Create(IdPartecipante: Int64; Esito: Integer): TGefosEsitoPartecipante; static;
  end;

  // Edizione (sezioni 4.3 e 4.4)
  TGefosEdizione = record
    Id: Int64;
    Avviata: Boolean;
    MetodoSvolgimento: Integer;
    DataOraInizio: TDateTime;
    // Solo data
    DataFine: TDate;
    Calendari: TArray<TGefosCalendario>;
    Partecipanti: TArray<TGefosPartecipante>;
    function DurataCalendarioMinuti: Integer;
  end;

  TGefosCorsoLeggero = record
    Id: Int64;
    IdTipologiaCorso: Int64;
  end;

  TGefosCorso = record
    Id: Int64;
    IdTipologiaCorso: Int64;
    Edizioni: TArray<TGefosEdizione>;
  end;

  // Esito di una chiamata: riuscita o no, con tutto quello che serve a registrarla
  TGefosRisposta = record
    Operazione: TGefosOperazione;
    MetodoHttp: string;
    Url: string;
    CorpoRichiesta: string;
    StatoHttp: Integer;
    CorpoRisposta: string;
    // Contenuto binario per attestati (PDF) e archivi (ZIP)
    Contenuto: TBytes;
    TipoContenuto: string;
    Riuscita: Boolean;
    Errore: TGefosErrore;
    DurataMs: Integer;
    // Identificativo restituito dalle creazioni (corso, edizione, partecipante)
    IdCreato: Int64;
    // Valorizzato solo per avvio e conferma
    DichiarazioniAccettate: Boolean;
    function MessaggioOperatore: string;
  end;

  // Problema trovato dai controlli prima dell'invio
  TGefosGravita = (ggErrore, ggAvviso);

  TGefosProblema = record
    Gravita: TGefosGravita;
    // Codice GEFOS che il servizio restituirebbe, quando esiste: aiuta a riconoscerlo
    Codice: string;
    // Su chi o cosa: nominativo del partecipante, data dello slot, nome del campo
    Riferimento: string;
    Messaggio: string;
    class function Errore(const Codice, Riferimento, Messaggio: string): TGefosProblema; static;
    class function Avviso(const Codice, Riferimento, Messaggio: string): TGefosProblema; static;
    function Testo: string;
  end;

  TGefosProblemi = TArray<TGefosProblema>;

// Codice di tre lettere dell'operazione (dominio GEFOS_OPERAZIONE)
function GefosCodiceOperazione(Operazione: TGefosOperazione): string;
function GefosDescrizioneOperazione(Operazione: TGefosOperazione): string;

function GefosDescrizioneMetodo(Metodo: Integer): string;
function GefosDescrizioneEsito(Esito: Integer): string;
function GefosMetodoValido(Metodo: Integer): Boolean;
function GefosMetodoGiornataValido(Metodo: Integer): Boolean;
function GefosEsitoValido(Esito: Integer): Boolean;

// Metodo effettivo di uno slot: quello della giornata per le edizioni miste,
// altrimenti quello dell'edizione (sezione 4.7)
function GefosMetodoEffettivo(MetodoEdizione: Integer; const Calendario: TGefosCalendario): Integer;

// Massimo di partecipanti ammesso per il metodo (sezione 3.10); 0 = nessun limite
function GefosMassimoPartecipanti(Metodo: Integer): Integer;

// Formati delle date dell'API: YYYY-MM-DDTHH:mm e YYYY-MM-DD
function GefosFormatoDataOra(Valore: TDateTime): string;
function GefosFormatoData(Valore: TDate): string;
function GefosLeggiDataOra(const Testo: string): TDateTime;
function GefosLeggiData(const Testo: string): TDate;

function GefosProblemiHannoErrori(const Problemi: TGefosProblemi): Boolean;
function GefosProblemiTesto(const Problemi: TGefosProblemi): string;
procedure GefosAggiungiProblemi(var Destinazione: TGefosProblemi; const Origine: TGefosProblemi);

implementation

const
  CODICI_OPERAZIONE: array [TGefosOperazione] of string = (
    'TOK', 'TIP', 'LCT', 'LCO', 'COR', 'MCO', 'LED', 'EDI', 'MED', 'CAL',
    'AVV', 'PAR', 'RPA', 'ESI', 'MES', 'ESB', 'CON', 'ATT', 'ATZ');

  DESCRIZIONI_OPERAZIONE: array [TGefosOperazione] of string = (
    'Richiesta del token',
    'Lettura tipologie corso',
    'Lettura corsi per tipologia',
    'Lettura corso',
    'Creazione corso',
    'Modifica corso',
    'Lettura edizione',
    'Creazione edizione',
    'Modifica edizione',
    'Aggiornamento calendario',
    'Comunicazione avvio',
    'Aggiunta partecipante',
    'Rimozione partecipante',
    'Inserimento esito',
    'Aggiornamento esito',
    'Inserimento esiti in blocco',
    'Conferma conclusione',
    'Scarico attestato',
    'Scarico attestati');

function GefosCodiceOperazione(Operazione: TGefosOperazione): string;
begin
  Result := CODICI_OPERAZIONE[Operazione];
end;

function GefosDescrizioneOperazione(Operazione: TGefosOperazione): string;
begin
  Result := DESCRIZIONI_OPERAZIONE[Operazione];
end;

function GefosDescrizioneMetodo(Metodo: Integer): string;
begin
  case Metodo of
    GEFOS_METODO_PRESENZA_FISICA:
      Result := 'Presenza fisica';
    GEFOS_METODO_E_LEARNING:
      Result := 'E-learning';
    GEFOS_METODO_VIDEO_CONFERENZA:
      Result := 'Video-conferenza';
    GEFOS_METODO_MISTA:
      Result := 'Mista';
  else
    Result := Format('Metodo %d', [Metodo]);
  end;
end;

function GefosDescrizioneEsito(Esito: Integer): string;
begin
  case Esito of
    GEFOS_ESITO_SUPERATO:
      Result := 'Superato';
    GEFOS_ESITO_NON_SUPERATO:
      Result := 'Non superato';
    GEFOS_ESITO_NON_AMMESSO:
      Result := 'Non ammesso';
  else
    Result := '';
  end;
end;

function GefosMetodoValido(Metodo: Integer): Boolean;
begin
  Result := (Metodo >= GEFOS_METODO_PRESENZA_FISICA) and (Metodo <= GEFOS_METODO_MISTA);
end;

function GefosMetodoGiornataValido(Metodo: Integer): Boolean;
begin
  // La giornata di un'edizione mista non puo' essere a sua volta "mista" (sezione 6.2)
  Result := (Metodo >= GEFOS_METODO_PRESENZA_FISICA) and (Metodo <= GEFOS_METODO_VIDEO_CONFERENZA);
end;

function GefosEsitoValido(Esito: Integer): Boolean;
begin
  Result := (Esito >= GEFOS_ESITO_SUPERATO) and (Esito <= GEFOS_ESITO_NON_AMMESSO);
end;

function GefosMetodoEffettivo(MetodoEdizione: Integer; const Calendario: TGefosCalendario): Integer;
begin
  if MetodoEdizione = GEFOS_METODO_MISTA then
    Result := Calendario.MetodoGiornata
  else
    Result := MetodoEdizione;
end;

function GefosMassimoPartecipanti(Metodo: Integer): Integer;
begin
  case Metodo of
    GEFOS_METODO_PRESENZA_FISICA, GEFOS_METODO_MISTA:
      Result := GEFOS_MASSIMO_PARTECIPANTI_PRESENZA;
    GEFOS_METODO_E_LEARNING:
      Result := GEFOS_MASSIMO_PARTECIPANTI_E_LEARNING;
  else
    // La specifica non pone limiti alla video-conferenza
    Result := 0;
  end;
end;

function GefosFormatoDataOra(Valore: TDateTime): string;
begin
  Result := FormatDateTime('yyyy"-"mm"-"dd"T"hh":"nn', Valore);
end;

function GefosFormatoData(Valore: TDate): string;
begin
  Result := FormatDateTime('yyyy"-"mm"-"dd', Valore);
end;

function GefosLeggiDataOra(const Testo: string): TDateTime;
var
  Anno, Mese, Giorno, Ora, Minuto: Integer;
  Pulito: string;
begin
  // Formato atteso YYYY-MM-DDTHH:mm; tollerati i secondi e la sola data
  Pulito := Trim(Testo);
  if Pulito = '' then
    Exit(0);
  if (Length(Pulito) < 10) or
     not TryStrToInt(Copy(Pulito, 1, 4), Anno) or
     not TryStrToInt(Copy(Pulito, 6, 2), Mese) or
     not TryStrToInt(Copy(Pulito, 9, 2), Giorno) then
    raise EGefosErrore.CreateFmt('Data e ora non riconosciute: "%s"', [Testo]);
  Ora := 0;
  Minuto := 0;
  if Length(Pulito) >= 16 then
  begin
    if not TryStrToInt(Copy(Pulito, 12, 2), Ora) or
       not TryStrToInt(Copy(Pulito, 15, 2), Minuto) then
      raise EGefosErrore.CreateFmt('Data e ora non riconosciute: "%s"', [Testo]);
  end;
  Result := EncodeDateTime(Anno, Mese, Giorno, Ora, Minuto, 0, 0);
end;

function GefosLeggiData(const Testo: string): TDate;
begin
  Result := DateOf(GefosLeggiDataOra(Testo));
end;

function GefosProblemiHannoErrori(const Problemi: TGefosProblemi): Boolean;
var
  Problema: TGefosProblema;
begin
  for Problema in Problemi do
    if Problema.Gravita = ggErrore then
      Exit(True);
  Result := False;
end;

function GefosProblemiTesto(const Problemi: TGefosProblemi): string;
var
  Problema: TGefosProblema;
  Righe: TStringBuilder;
begin
  Righe := TStringBuilder.Create;
  try
    for Problema in Problemi do
      Righe.AppendLine(Problema.Testo);
    Result := Righe.ToString.TrimRight;
  finally
    Righe.Free;
  end;
end;

procedure GefosAggiungiProblemi(var Destinazione: TGefosProblemi; const Origine: TGefosProblemi);
begin
  Destinazione := Destinazione + Origine;
end;

{ TGefosConfigurazione }

class function TGefosConfigurazione.Create(const UrlToken, UrlBase, ClientId, ClientSecret, EnteErogatore: string): TGefosConfigurazione;
begin
  Result := Default(TGefosConfigurazione);
  Result.UrlToken := UrlToken;
  Result.UrlBase := UrlBase;
  Result.Scope := 'gefos';
  Result.ClientId := ClientId;
  Result.ClientSecret := ClientSecret;
  Result.EnteErogatore := EnteErogatore;
  Result.TimeoutConnessioneMs := 15000;
  Result.TimeoutRispostaMs := 60000;
end;

{ TGefosErrore }

function TGefosErrore.IsVuoto: Boolean;
begin
  Result := (Codice = '') and (Dettaglio = '') and (Stato = 0);
end;

function TGefosErrore.MessaggioOperatore: string;
var
  Spiegazione: string;
begin
  // I testi spiegano cosa fare in Gesty: il "detail" di GEFOS resta in coda
  // perche' a volte indica il dato preciso che non va.
  if Codice = 'BAD_REQUEST' then
    Spiegazione := 'GEFOS ha rifiutato la richiesta perche'' incompleta o malformata.'
  else if Codice = 'ENTE_NON_CENSITO' then
    Spiegazione := 'L''ente erogatore indicato nella configurazione non e'' censito in GEFOS: verificare codice fiscale o partita IVA.'
  else if Codice = 'ENTE_NON_AUTORIZZATO' then
    Spiegazione := 'L''ente non e'' autorizzato su questo corso o edizione: forse appartiene a un altro ente.'
  else if Codice = 'NOT_FOUND' then
    Spiegazione := 'Il corso o l''edizione non esistono piu'' in GEFOS: verificare i collegamenti salvati.'
  else if Codice = 'INVALID_TIPOLOGIA' then
    Spiegazione := 'La tipologia di corso non e'' fra quelle ammesse per l''ente: aggiornare le tipologie GEFOS.'
  else if Codice = 'TIPOLOGIA_NON_MODIFICABILE' then
    Spiegazione := 'La tipologia del corso non si puo'' cambiare perche'' il corso ha gia'' edizioni.'
  else if Codice = 'INVALID_METODO_SVOLGIMENTO' then
    Spiegazione := 'Il metodo di svolgimento non e'' valido.'
  else if Codice = 'METODO_SVOLGIMENTO_NON_COMPATIBILE_TIPOLOGIA' then
    Spiegazione := 'La modalita'' di erogazione non e'' ammessa per la tipologia di corso scelta.'
  else if Codice = 'EDIZIONE_AVVIATA' then
    Spiegazione := 'L''avvio e'' gia'' stato comunicato: metodo e date dell''edizione non si possono piu'' cambiare.'
  else if Codice = 'EDIZIONE_NON_MODIFICABILE' then
    Spiegazione := 'La conclusione e'' gia'' stata confermata: l''edizione non si puo'' piu'' modificare.'
  else if Codice = 'EDIZIONE_GIA_CONFERMATA' then
    Spiegazione := 'La conclusione dell''edizione era gia'' stata confermata.'
  else if Codice = 'EDIZIONE_SENZA_PARTECIPANTI' then
    Spiegazione := 'Per confermare la conclusione serve almeno un partecipante iscritto in GEFOS.'
  else if Codice = 'EDIZIONE_SENZA_CALENDARI' then
    Spiegazione := 'Per confermare la conclusione serve almeno una giornata di calendario.'
  else if Codice = 'EDIZIONE_ESITI_INCOMPLETI' then
    Spiegazione := 'Per confermare la conclusione ogni partecipante deve avere un esito comunicato.'
  else if Codice = 'CONFERMA_FUORI_TERMINE' then
    Spiegazione := 'Sono passati piu'' di 30 giorni dalla fine dell''edizione: la conclusione non si puo'' piu'' confermare via API, va chiesta ad ARIA.'
  else if Codice = 'DICHIARAZIONI_NON_ACCETTATE' then
    Spiegazione := 'Le dichiarazioni non risultano accettate.'
  else if Codice = 'CALENDARIO_OUT_OF_RANGE' then
    Spiegazione := 'Una giornata del calendario cade fuori dalle date di inizio e fine dell''edizione.'
  else if Codice = 'CALENDARIO_INCOERENTE_EDIZIONE' then
    Spiegazione := 'Il calendario deve avere una giornata il primo e l''ultimo giorno dell''edizione, e la prima deve cominciare all''ora di inizio dell''edizione.'
  else if Codice = 'CALENDARIO_SLOT_PASSATO' then
    Spiegazione := 'Le giornate con data precedente a oggi non si possono aggiungere, cambiare o togliere.'
  else if Codice = 'CALENDARIO_MONTE_ORE_INSUFFICIENTE' then
    Spiegazione := 'Le ore del calendario non raggiungono il monte ore minimo della tipologia di corso.'
  else if Codice = 'CALENDARIO_INDIRIZZO_OBBLIGATORIO' then
    Spiegazione := 'Per le giornate in presenza servono indirizzo, numero civico, CAP, comune e provincia della sede.'
  else if Codice = 'CALENDARIO_LINK_OBBLIGATORIO' then
    Spiegazione := 'Per le giornate in video-conferenza serve il collegamento alla piattaforma.'
  else if Codice = 'CALENDARIO_METODO_GIORNATA_OBBLIGATORIO' then
    Spiegazione := 'In un''edizione mista ogni giornata deve dire se e'' in presenza, in e-learning o in video-conferenza.'
  else if Codice = 'CALENDARIO_METODO_GIORNATA_NON_AMMESSO' then
    Spiegazione := 'Il metodo della singola giornata si indica solo nelle edizioni miste.'
  else if Codice = 'INVALID_METODO_SVOLGIMENTO_GIORNATA' then
    Spiegazione := 'Il metodo indicato per una giornata non e'' valido.'
  else if Codice = 'PARTECIPANTE_DUPLICATO' then
    Spiegazione := 'Il partecipante e'' gia'' iscritto a questa edizione in GEFOS.'
  else if Codice = 'PARTECIPANTE_NON_PRESENTE' then
    Spiegazione := 'Il partecipante non risulta iscritto all''edizione in GEFOS.'
  else if Codice = 'MAX_PARTECIPANTI_SUPERATO' then
    Spiegazione := 'Le edizioni in presenza e miste ammettono al massimo 30 partecipanti.'
  else if Codice = 'ELEARNING_MAX_PARTECIPANTI' then
    Spiegazione := 'Un''edizione in e-learning ammette un solo partecipante.'
  else if Codice = 'ESITO_NON_VALIDO' then
    Spiegazione := 'L''esito indicato non e'' fra quelli ammessi.'
  else if Codice = 'ATTESTATO_NON_DISPONIBILE' then
    Spiegazione := 'L''attestato e'' disponibile solo dopo la conferma della conclusione.'
  else if Codice = 'NESSUN_ATTESTATO_DISPONIBILE' then
    Spiegazione := 'Nessun attestato disponibile per i partecipanti dell''edizione.'
  else if Codice = GEFOS_ERRORE_TOKEN then
    Spiegazione := 'Autenticazione verso GEFOS non riuscita: verificare le credenziali nella configurazione.'
  else if Codice = GEFOS_ERRORE_TRASPORTO then
    Spiegazione := 'GEFOS non e'' raggiungibile: verificare la connessione e riprovare.'
  else if Stato = 401 then
    Spiegazione := 'GEFOS ha rifiutato le credenziali.'
  else if Stato >= 500 then
    Spiegazione := 'GEFOS ha avuto un errore interno: riprovare piu'' tardi.'
  else
    Spiegazione := 'GEFOS ha rifiutato la richiesta.';

  Result := Spiegazione;
  if (Dettaglio <> '') and (Dettaglio <> Spiegazione) then
    Result := Result + sLineBreak + 'Dettaglio: ' + Dettaglio;
  if Codice <> '' then
    Result := Result + sLineBreak + Format('(codice %s, HTTP %d)', [Codice, Stato])
  else if Stato <> 0 then
    Result := Result + sLineBreak + Format('(HTTP %d)', [Stato]);
end;

{ TGefosTipologiaCorso }

function TGefosTipologiaCorso.AmmetteMetodo(Metodo: Integer): Boolean;
var
  Ammesso: Integer;
begin
  for Ammesso in MetodiSvolgimento do
    if Ammesso = Metodo then
      Exit(True);
  Result := False;
end;

function TGefosTipologiaCorso.MetodiSvolgimentoTesto: string;
var
  Metodo: Integer;
begin
  Result := '';
  for Metodo in MetodiSvolgimento do
  begin
    if Result <> '' then
      Result := Result + ',';
    Result := Result + IntToStr(Metodo);
  end;
end;

{ TGefosCalendario }

function TGefosCalendario.DurataMinuti: Integer;
begin
  if DataOraA <= DataOraDa then
    Exit(0);
  // Arrotondato: con le date in virgola mobile 09:00-13:00 puo' valere 239,9999 minuti
  Result := Round((DataOraA - DataOraDa) * MinsPerDay);
end;

{ TGefosPartecipante }

function TGefosPartecipante.NatoInItalia: Boolean;
var
  Stato: string;
begin
  // GEFOS accetta descrizione o codice: entrambe le forme indicano l'Italia
  Stato := UpperCase(Trim(StatoNascita));
  Result := (Stato = 'ITA') or (Stato = 'ITALIA');
end;

function TGefosPartecipante.Nominativo: string;
begin
  Result := Trim(Cognome + ' ' + Nome);
  if CodiceFiscale <> '' then
    Result := Result + ' (' + CodiceFiscale + ')';
end;

{ TGefosEsitoPartecipante }

class function TGefosEsitoPartecipante.Create(IdPartecipante: Int64; Esito: Integer): TGefosEsitoPartecipante;
begin
  Result.IdPartecipante := IdPartecipante;
  Result.Esito := Esito;
end;

{ TGefosEdizione }

function TGefosEdizione.DurataCalendarioMinuti: Integer;
var
  Calendario: TGefosCalendario;
begin
  Result := 0;
  for Calendario in Calendari do
    Inc(Result, Calendario.DurataMinuti);
end;

{ TGefosRisposta }

function TGefosRisposta.MessaggioOperatore: string;
begin
  if Riuscita then
    Result := ''
  else
    Result := GefosDescrizioneOperazione(Operazione) + ': ' + Errore.MessaggioOperatore;
end;

{ TGefosProblema }

class function TGefosProblema.Errore(const Codice, Riferimento, Messaggio: string): TGefosProblema;
begin
  Result.Gravita := ggErrore;
  Result.Codice := Codice;
  Result.Riferimento := Riferimento;
  Result.Messaggio := Messaggio;
end;

class function TGefosProblema.Avviso(const Codice, Riferimento, Messaggio: string): TGefosProblema;
begin
  Result.Gravita := ggAvviso;
  Result.Codice := Codice;
  Result.Riferimento := Riferimento;
  Result.Messaggio := Messaggio;
end;

function TGefosProblema.Testo: string;
const
  PREFISSI: array [TGefosGravita] of string = ('Errore', 'Avviso');
begin
  Result := PREFISSI[Gravita] + ': ';
  if Riferimento <> '' then
    Result := Result + Riferimento + ' - ';
  Result := Result + Messaggio;
end;

end.
