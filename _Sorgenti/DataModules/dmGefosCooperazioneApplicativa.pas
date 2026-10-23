// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-23
// ---------------------------------------------------------------------------
unit dmGefosCooperazioneApplicativa;

// Ponte fra Gesty e il motore GE.FO.S. (unit Gefos.*), sul modello di
// dmSIUF_CooperazioneApplicativa: legge corso ASR, giornate (ORARIO) e partecipanti
// (ANAGRAFE), costruisce gli oggetti TGefos*, li controlla con TGefosValidatore,
// registra ogni chiamata in GEFOS_COOPERAZIONE_APPLICATIVA_INVII e aggiorna le tabelle
// di collegamento PROGETTI_ASR_SICUREZZA_GEFOS, _EDIZIONI_GEFOS e _PARTECIPANTI_GEFOS.
// Analisi: D:\AI\OUT\20261005-integrazione-gefos\ (paragrafi 10 e 12).
//
// Letture e scritture usano query FireDAC dirette e non i wrapper TSP_*: le procedure
// GEFOS_* nascono con lo script dello stesso rilascio, e il modulo deve compilare anche
// prima che i wrapper vengano rigenerati.
//
// Ogni risposta positiva di GEFOS si salva subito, con una transazione propria: lo stato
// remoto cambia a ogni chiamata, e un errore a meta' sequenza non deve far perdere gli
// identificativi gia' ottenuti. Rilanciando la stessa operazione, la sequenza riprende
// dal punto in cui si era fermata (corso, edizione, partecipanti, avvio).

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.DApt,
  FireDAC.Comp.Client,
  Base_DataModule,
  dbMaster,
  zFbDataSet,
  Gefos.Types,
  Gefos.Client,
  Gefos.Validator;

type
  // Riga PROGETTI_ASR_SICUREZZA con i suoi dati GEFOS (PROGETTI_ASR_SICUREZZA_GEFOS)
  TGefosCorsoAsr = record
    IdProgettoAsr: Int64;
    IdProgetto: Int64;
    // 0 = progetto senza corso (ORARIO.ID_CORSO NULL)
    IdCorso: Int64;
    IdEnte: Int64;
    Descrizione: string;
    DataInizio: TDate;
    DataFine: TDate;
    ModalitaErogazione: string;
    Metodo: Integer;
    // 0 = corso non ancora creato in GEFOS
    IdCorsoGefos: Int64;
    Tipologia: TGefosTipologiaCorso;
    SedeIndirizzo: string;
    SedeNumeroCivico: string;
    SedeCap: string;
    SedeCitta: string;
    // Nome per esteso da ZZ_PROVINCIE, come lo vuole GEFOS
    SedeProvincia: string;
    LinkVideoconferenza: string;
  end;

  TGefosPartecipanteAsr = record
    IdPartecipanteProgettoAsr: Int64;
    // PROGETTI_ASR_SICUREZZA_PARTECIPANTI.FORMATO: ammesso alla verifica
    Ammesso: Boolean;
    Idoneo: Boolean;
    // 0 = non ancora iscritto in GEFOS
    IdEdizioneAsrGefos: Int64;
    // 0 = esito non ancora comunicato
    EsitoComunicato: Integer;
    // Dati.Id = ID_PARTECIPANTE_GEFOS
    Dati: TGefosPartecipante;
  end;

  TGefosEdizioneAsr = record
    // 0 = riga PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS non ancora creata
    IdEdizioneAsrGefos: Int64;
    // 0 = edizione di tutti i partecipanti; altrimenti edizione e-learning personale
    IdPartecipanteProgettoAsr: Int64;
    Avviata: Boolean;
    Conclusa: Boolean;
    // Edizione.Id = ID_EDIZIONE_GEFOS
    Edizione: TGefosEdizione;
    Partecipanti: TArray<TGefosPartecipanteAsr>;
    function Nome: string;
    // Dati anagrafici dei partecipanti, nella forma che vuole TGefosValidatore
    function DatiPartecipanti: TArray<TGefosPartecipante>;
  end;

  // Riferimenti della chiamata in corso, scritti nel registro da RegistraChiamata
  TGefosContestoChiamata = record
    IdProgettoAsr: Int64;
    IdPartecipanteProgettoAsr: Int64;
    IdCorsoGefos: Int64;
    IdEdizioneGefos: Int64;
    IdPartecipanteGefos: Int64;
  end;

  TGefosCooperazioneApplicativa = class(TBaseDataModule)
  private
    FTransazione: TFDTransaction;
    FConfigurazione: TGefosConfigurazione;
    FIdEnte: Int64;
    FAmbienteTest: Boolean;
    FCartellaTemporanea: string;
    FContesto: TGefosContestoChiamata;
    FRiepilogo: TStringList;

    // --- Accesso al database ---
    function NuovaQuery(const Sql: string): TFDQuery;
    procedure EseguiScrittura(Query: TFDQuery);

    // --- Lettura dei dati di Gesty ---
    procedure CaricaConfigurazione(IdEnte: Int64);
    function CaricaCorso(IdProgettoAsr: Int64): TGefosCorsoAsr;
    function CaricaCalendari(const Corso: TGefosCorsoAsr): TArray<TGefosCalendario>;
    function CaricaPartecipanti(const Corso: TGefosCorsoAsr): TArray<TGefosPartecipanteAsr>;
    function CostruisciEdizioni(const Corso: TGefosCorsoAsr): TArray<TGefosEdizioneAsr>;
    function TestoDichiarazioni(const Operazione: string; IdDenominazione: Integer): string;

    // --- Scritture delle tabelle di collegamento ---
    procedure SalvaIdCorso(const Corso: TGefosCorsoAsr);
    procedure InserisciEdizioneLocale(const Corso: TGefosCorsoAsr; var Edizione: TGefosEdizioneAsr);
    procedure SalvaDatiEdizione(const Edizione: TGefosEdizioneAsr);
    procedure SalvaAvvio(const Edizione: TGefosEdizioneAsr);
    procedure SalvaConclusione(const Edizione: TGefosEdizioneAsr);
    procedure SalvaIscrizione(const Edizione: TGefosEdizioneAsr; const Partecipante: TGefosPartecipanteAsr);
    procedure SalvaEsito(const Partecipante: TGefosPartecipanteAsr; Esito: Integer);

    // --- Registro delle chiamate (evento OnChiamata del client) ---
    procedure ImpostaContesto(IdProgettoAsr, IdPartecipanteProgettoAsr, IdCorsoGefos, IdEdizioneGefos, IdPartecipanteGefos: Int64);
    procedure RegistraChiamata(const Risposta: TGefosRisposta);
    function ScriviFileTemporaneo(Operazione: TGefosOperazione; const Momento, Parte, Contenuto: string): string;

    // --- Passi delle sequenze ---
    function NuovoClient: TGefosClient;
    function CreaCorsoSeManca(Client: TGefosClient; var Corso: TGefosCorsoAsr): Boolean;
    function PreparaEdizioneRemota(Client: TGefosClient; const Corso: TGefosCorsoAsr; var Edizione: TGefosEdizioneAsr): Boolean;
    function AllineaEdizioneRemota(Client: TGefosClient; const Corso: TGefosCorsoAsr; var Edizione: TGefosEdizioneAsr): Boolean;
    function IscriviPartecipantiMancanti(Client: TGefosClient; const Corso: TGefosCorsoAsr; var Edizione: TGefosEdizioneAsr): Boolean;
    function CercaPartecipanteRemoto(Client: TGefosClient; const Corso: TGefosCorsoAsr; const Edizione: TGefosEdizioneAsr;
      const Partecipante: TGefosPartecipante): Int64;
    function AvviaEdizione(Client: TGefosClient; const Corso: TGefosCorsoAsr; var Edizione: TGefosEdizioneAsr): Boolean;
    function ComunicaEsitiEdizione(Client: TGefosClient; const Corso: TGefosCorsoAsr; var Edizione: TGefosEdizioneAsr): Boolean;

    // --- Dialogo con l'operatore ---
    procedure AnnotaErrore(const Riferimento: string; const Risposta: TGefosRisposta);
    function MostraProblemi(const Problemi: TGefosProblemi; const Operazione: string): Boolean;
    function AccettaDichiarazioni(const Operazione: string; IdDenominazione: Integer; const Descrizione: string): Boolean;
    procedure MostraRiepilogo(const Titolo: string);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    // Legge GET /tipologieCorso e aggiorna GEFOS_TIPOLOGIE_CORSO dell'ente; le
    // tipologie che GEFOS non restituisce piu' restano, con ATTIVA = FALSE
    function AggiornaTipologie(IdEnte: Int64): Boolean;

    // Crea la riga PROGETTI_ASR_SICUREZZA_GEFOS del corso, se manca: tipologia proposta
    // da GEFOS_TIPOLOGIE_CORSO (solo se ce n'e' una sola compatibile) e sede copiata
    // dalla sede dell'ente del progetto. Restituisce False se la tipologia va scelta a mano.
    function PreparaCorsoGefos(IdProgettoAsr: Int64): Boolean;

    // Riempie ORARIO con PROGETTI_ASR_SICUREZZA_GENERA_GIORNATE; restituisce il messaggio per l'operatore
    function GeneraGiornate(IdProgettoAsr: Int64; OraInizioMattina, OraInizioPomeriggio: TTime; OreMattina: Integer): string;

    // Controlli senza nessuna chiamata a GEFOS: testo dei problemi, vuoto se tutto e' pronto
    function ControllaCorso(IdProgettoAsr: Int64): string;

    // Crea corso, edizioni e partecipanti che mancano in GEFOS e comunica l'avvio delle
    // edizioni non ancora avviate, dopo l'accettazione esplicita delle dichiarazioni
    function ComunicaAvvio(IdProgettoAsr: Int64): Boolean;

    // Iscrive i partecipanti aggiunti dopo l'avvio e comunica gli esiti nuovi o cambiati
    // delle edizioni avviate e non concluse (FORMATO e IDONEO, vedi EsitoDaIdoneita)
    function ComunicaEsiti(IdProgettoAsr: Int64): Boolean;

    // Conferma la conclusione delle edizioni avviate: irreversibile, con dichiarazioni
    function ConfermaConclusione(IdProgettoAsr: Int64): Boolean;
  end;

var
  GefosCooperazioneApplicativa: TGefosCooperazioneApplicativa;

implementation

uses
  System.Variants,
  System.DateUtils,
  System.IOUtils,
  System.StrUtils,
  Vcl.Forms,
  Vcl.Dialogs,
  ConfigModule,
  zMsg,
  zMemoDialog,
  zBaseLib;

{$R *.dfm}

const
  OPERAZIONE_DICHIARAZIONI_AVVIO = 'AVV';
  OPERAZIONE_DICHIARAZIONI_CONCLUSIONE = 'CON';

{ Funzioni di appoggio }

// I parametri FireDAC delle query dirette nascono senza tipo: per scrivere NULL il tipo
// va dato prima, altrimenti FireDAC rifiuta il parametro
procedure ImpostaIntero(Parametro: TFDParam; Valore: Int64);
begin
  if Valore = 0 then
  begin
    if Parametro.DataType = ftUnknown then
      Parametro.DataType := ftLargeint;
    Parametro.Clear;
  end
  else
    Parametro.AsLargeInt := Valore;
end;

procedure ImpostaTesto(Parametro: TFDParam; const Valore: string);
begin
  if Trim(Valore) = '' then
  begin
    if Parametro.DataType = ftUnknown then
      Parametro.DataType := ftWideString;
    Parametro.Clear;
  end
  else
    Parametro.AsWideString := Trim(Valore);
end;

procedure ImpostaDataOra(Parametro: TFDParam; Valore: TDateTime);
begin
  if Valore = 0 then
  begin
    if Parametro.DataType = ftUnknown then
      Parametro.DataType := ftDateTime;
    Parametro.Clear;
  end
  else
    Parametro.AsDateTime := Valore;
end;

procedure ImpostaData(Parametro: TFDParam; Valore: TDate);
begin
  if Valore = 0 then
  begin
    if Parametro.DataType = ftUnknown then
      Parametro.DataType := ftDate;
    Parametro.Clear;
  end
  else
    Parametro.AsDate := Valore;
end;

function TestoCampo(Query: TFDQuery; const Nome: string): string;
begin
  Result := Trim(Query.FieldByName(Nome).AsString);
end;

function InteroCampo(Query: TFDQuery; const Nome: string): Int64;
begin
  if Query.FieldByName(Nome).IsNull then
    Result := 0
  else
    Result := Query.FieldByName(Nome).AsLargeInt;
end;

function StessoMinuto(Primo, Secondo: TDateTime): Boolean;
begin
  Result := Abs(Primo - Secondo) < (0.5 / MinsPerDay);
end;

// MODALITA_EROGAZIONE di Gesty -> metodo di svolgimento GEFOS (paragrafo 3.2 dell'analisi)
function MetodoDaModalita(const Modalita: string): Integer;
begin
  if SameText(Modalita, 'PR') then
    Result := GEFOS_METODO_PRESENZA_FISICA
  else if SameText(Modalita, 'EL') then
    Result := GEFOS_METODO_E_LEARNING
  else if SameText(Modalita, 'VS') then
    Result := GEFOS_METODO_VIDEO_CONFERENZA
  else if SameText(Modalita, 'MI') then
    Result := GEFOS_METODO_MISTA
  else
    Result := 0;
end;

// ORARIO.TIPOLOGIA_FORMAZIONE -> metodo della giornata nelle edizioni miste.
// 1 (collettiva, il valore di quasi tutto ORARIO) e 29 (aula in presenza, quello scritto
// da PROGETTI_ASR_SICUREZZA_GENERA_GIORNATE) valgono entrambi come presenza.
// 0 = non ammesso in ASR: il validatore lo segnala come metodo mancante.
function MetodoDaTipologiaFormazione(const TipologiaFormazione: string): Integer;
begin
  if (TipologiaFormazione = '1') or (TipologiaFormazione = '29') then
    Result := GEFOS_METODO_PRESENZA_FISICA
  else if TipologiaFormazione = '12' then
    Result := GEFOS_METODO_VIDEO_CONFERENZA
  else if (TipologiaFormazione = '13') or (TipologiaFormazione = '28') then
    Result := GEFOS_METODO_E_LEARNING
  else
    Result := 0;
end;

function MetodiDaTesto(const Testo: string): TArray<Integer>;
var
  Parte: string;
  Metodo: Integer;
begin
  Result := nil;
  for Parte in Testo.Split([',', ';', ' '], TStringSplitOptions.ExcludeEmpty) do
    if TryStrToInt(Trim(Parte), Metodo) then
      Result := Result + [Metodo];
end;

// Confronto di uno slot locale con quello letto da GEFOS: contano solo i campi che
// GEFOS conserva per il metodo effettivo della giornata (indirizzo o collegamento)
function StessoSlot(MetodoEdizione: Integer; const Primo, Secondo: TGefosCalendario): Boolean;
begin
  Result := StessoMinuto(Primo.DataOraDa, Secondo.DataOraDa) and StessoMinuto(Primo.DataOraA, Secondo.DataOraA);
  if not Result then
    Exit;
  if MetodoEdizione = GEFOS_METODO_MISTA then
    Result := Primo.MetodoGiornata = Secondo.MetodoGiornata;
  if not Result then
    Exit;
  case GefosMetodoEffettivo(MetodoEdizione, Primo) of
    GEFOS_METODO_PRESENZA_FISICA:
      Result := SameText(Trim(Primo.Indirizzo), Trim(Secondo.Indirizzo)) and
        SameText(Trim(Primo.NumeroCivico), Trim(Secondo.NumeroCivico)) and
        SameText(Trim(Primo.Cap), Trim(Secondo.Cap)) and
        SameText(Trim(Primo.Citta), Trim(Secondo.Citta)) and
        SameText(Trim(Primo.Provincia), Trim(Secondo.Provincia));
    GEFOS_METODO_VIDEO_CONFERENZA:
      Result := SameText(Trim(Primo.Link), Trim(Secondo.Link));
  end;
end;

// Per l'e-learning ogni partecipante ha la sua edizione e gli stessi problemi del
// calendario si ripeterebbero una volta per edizione: si tengono una volta sola
procedure AggiungiSenzaDoppioni(var Destinazione: TGefosProblemi; const Origine: TGefosProblemi);
var
  Nuovo, Presente: TGefosProblema;
  Trovato: Boolean;
begin
  for Nuovo in Origine do
  begin
    Trovato := False;
    for Presente in Destinazione do
      if Presente.Testo = Nuovo.Testo then
      begin
        Trovato := True;
        Break;
      end;
    if not Trovato then
      Destinazione := Destinazione + [Nuovo];
  end;
end;

{ TGefosEdizioneAsr }

function TGefosEdizioneAsr.Nome: string;
begin
  if (IdPartecipanteProgettoAsr <> 0) and (Length(Partecipanti) > 0) then
    Result := 'Edizione di ' + Partecipanti[0].Dati.Nominativo
  else
    Result := 'Edizione del corso';
  if Edizione.Id <> 0 then
    Result := Result + Format(' (GEFOS %d)', [Edizione.Id]);
end;

function TGefosEdizioneAsr.DatiPartecipanti: TArray<TGefosPartecipante>;
var
  Partecipante: TGefosPartecipanteAsr;
begin
  Result := nil;
  for Partecipante in Partecipanti do
    Result := Result + [Partecipante.Dati];
end;

{ TGefosCooperazioneApplicativa }

constructor TGefosCooperazioneApplicativa.Create(aOwner: TComponent);
begin
  inherited;
  FRiepilogo := TStringList.Create;
  // Transazione propria: il Commit del modulo dati salverebbe anche le modifiche
  // ancora aperte nella schermata da cui parte l'invio
  FTransazione := TFDTransaction.Create(nil);
  FTransazione.Connection := Config.Database;
  FCartellaTemporanea := IncludeTrailingPathDelimiter(
    TPath.Combine(ExtractFilePath(Application.ExeName), 'GEFOS_CooperazioneApplicativa_Log'));
end;

destructor TGefosCooperazioneApplicativa.Destroy;
begin
  FreeAndNil(FTransazione);
  FreeAndNil(FRiepilogo);
  inherited;
end;

function TGefosCooperazioneApplicativa.NuovaQuery(const Sql: string): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := Config.Database;
  Result.Transaction := FTransazione;
  // Tutte le righe subito: la transazione di lettura si chiude appena aperta la query
  Result.FetchOptions.Mode := fmAll;
  Result.SQL.Text := Sql;
end;

procedure TGefosCooperazioneApplicativa.EseguiScrittura(Query: TFDQuery);
begin
  FTransazione.StartTransaction;
  try
    Query.ExecSQL;
    FTransazione.Commit;
  except
    if FTransazione.Active then
      FTransazione.Rollback;
    raise;
  end;
end;

{ Lettura dei dati di Gesty }

procedure TGefosCooperazioneApplicativa.CaricaConfigurazione(IdEnte: Int64);
var
  Query: TFDQuery;
begin
  Query := NuovaQuery(
    'SELECT ' +
    '    GEFOS_COOPERAZIONE_APPLICATIVA_CONFIG.AMBIENTE_TEST, ' +
    '    GEFOS_COOPERAZIONE_APPLICATIVA_CONFIG.URL_TOKEN, ' +
    '    GEFOS_COOPERAZIONE_APPLICATIVA_CONFIG.URL_BASE, ' +
    '    GEFOS_COOPERAZIONE_APPLICATIVA_CONFIG.SCOPE, ' +
    '    GEFOS_COOPERAZIONE_APPLICATIVA_CONFIG.ENTE_EROGATORE, ' +
    '    GEFOS_COOPERAZIONE_APPLICATIVA_CONFIG.CLIENT_ID, ' +
    '    GEFOS_COOPERAZIONE_APPLICATIVA_CONFIG.CLIENT_SECRET ' +
    'FROM ' +
    '    GEFOS_COOPERAZIONE_APPLICATIVA_CONFIG ' +
    'WHERE ' +
    '    GEFOS_COOPERAZIONE_APPLICATIVA_CONFIG.ID_ENTE = :ID_ENTE AND ' +
    '    GEFOS_COOPERAZIONE_APPLICATIVA_CONFIG.ATTIVO = TRUE');
  try
    Query.ParamByName('ID_ENTE').AsLargeInt := IdEnte;
    Query.Open;
    if Query.IsEmpty then
      raise EGefosErrore.Create('Nessuna configurazione GEFOS attiva per l''ente del corso: ' +
        'inserire indirizzi e credenziali in GEFOS_COOPERAZIONE_APPLICATIVA_CONFIG.');

    FIdEnte := IdEnte;
    FAmbienteTest := Query.FieldByName('AMBIENTE_TEST').AsBoolean;
    FConfigurazione := TGefosConfigurazione.Create(
      TestoCampo(Query, 'URL_TOKEN'),
      TestoCampo(Query, 'URL_BASE'),
      TestoCampo(Query, 'CLIENT_ID'),
      TestoCampo(Query, 'CLIENT_SECRET'),
      TestoCampo(Query, 'ENTE_EROGATORE'));
    if TestoCampo(Query, 'SCOPE') <> '' then
      FConfigurazione.Scope := TestoCampo(Query, 'SCOPE');
  finally
    Query.Free;
  end;
end;

function TGefosCooperazioneApplicativa.CaricaCorso(IdProgettoAsr: Int64): TGefosCorsoAsr;
var
  Query: TFDQuery;
begin
  Result := Default(TGefosCorsoAsr);
  Query := NuovaQuery(
    'SELECT ' +
    '    PROGETTI_ASR_SICUREZZA.ID_PROGETTO, ' +
    '    PROGETTI_ASR_SICUREZZA.ID_CORSO, ' +
    '    PROGETTI.ID_ENTE, ' +
    '    PROGETTI_ASR_SICUREZZA.TIPOLOGIA_CORSO, ' +
    '    PROGETTI_ASR_SICUREZZA.DATA_INIZIO_EFFETTIVA, ' +
    '    PROGETTI_ASR_SICUREZZA.DATA_FINE_EFFETTIVA, ' +
    '    PROGETTI_ASR_SICUREZZA.MODALITA_EROGAZIONE, ' +
    '    PROGETTI_ASR_SICUREZZA_GEFOS.ID_PROGETTO_ASR AS ID_PROGETTO_ASR_GEFOS, ' +
    '    PROGETTI_ASR_SICUREZZA_GEFOS.ID_TIPOLOGIA_CORSO_GEFOS, ' +
    '    PROGETTI_ASR_SICUREZZA_GEFOS.ID_CORSO_GEFOS, ' +
    '    PROGETTI_ASR_SICUREZZA_GEFOS.SEDE_INDIRIZZO, ' +
    '    PROGETTI_ASR_SICUREZZA_GEFOS.SEDE_NUMERO_CIVICO, ' +
    '    PROGETTI_ASR_SICUREZZA_GEFOS.SEDE_CAP, ' +
    '    PROGETTI_ASR_SICUREZZA_GEFOS.SEDE_CITTA, ' +
    '    PROGETTI_ASR_SICUREZZA_GEFOS.SEDE_PROVINCIA, ' +
    '    PROGETTI_ASR_SICUREZZA_GEFOS.LINK_VIDEOCONFERENZA, ' +
    '    ZZ_PROVINCIE.DESC_PROVINCIA, ' +
    '    GEFOS_TIPOLOGIE_CORSO.DESCRIZIONE AS DESCRIZIONE_TIPOLOGIA, ' +
    '    GEFOS_TIPOLOGIE_CORSO.ID_DENOMINAZIONE, ' +
    '    GEFOS_TIPOLOGIE_CORSO.DESCRIZIONE_DENOMINAZIONE, ' +
    '    GEFOS_TIPOLOGIE_CORSO.MONTE_ORE, ' +
    '    GEFOS_TIPOLOGIE_CORSO.METODI_SVOLGIMENTO ' +
    'FROM ' +
    '    PROGETTI_ASR_SICUREZZA ' +
    '        INNER JOIN PROGETTI ON PROGETTI.ID_PROGETTO = PROGETTI_ASR_SICUREZZA.ID_PROGETTO ' +
    '        LEFT OUTER JOIN PROGETTI_ASR_SICUREZZA_GEFOS ON PROGETTI_ASR_SICUREZZA_GEFOS.ID_PROGETTO_ASR = PROGETTI_ASR_SICUREZZA.ID_PROGETTO_ASR ' +
    '        LEFT OUTER JOIN GEFOS_TIPOLOGIE_CORSO ON GEFOS_TIPOLOGIE_CORSO.ID_TIPOLOGIA_CORSO_GEFOS = PROGETTI_ASR_SICUREZZA_GEFOS.ID_TIPOLOGIA_CORSO_GEFOS ' +
    '        LEFT OUTER JOIN ZZ_PROVINCIE ON ZZ_PROVINCIE.PROVINCIA = PROGETTI_ASR_SICUREZZA_GEFOS.SEDE_PROVINCIA ' +
    'WHERE ' +
    '    PROGETTI_ASR_SICUREZZA.ID_PROGETTO_ASR = :ID_PROGETTO_ASR');
  try
    Query.ParamByName('ID_PROGETTO_ASR').AsLargeInt := IdProgettoAsr;
    Query.Open;
    if Query.IsEmpty then
      raise EGefosErrore.CreateFmt('Corso ASR %d non trovato.', [IdProgettoAsr]);

    if Query.FieldByName('ID_PROGETTO_ASR_GEFOS').IsNull then
      raise EGefosErrore.Create('Il corso non ha ancora i dati GEFOS (tipologia, sede, collegamento): ' +
        'compilarli prima di comunicare con GEFOS.');

    Result.IdProgettoAsr := IdProgettoAsr;
    Result.IdProgetto := InteroCampo(Query, 'ID_PROGETTO');
    Result.IdCorso := InteroCampo(Query, 'ID_CORSO');
    Result.IdEnte := InteroCampo(Query, 'ID_ENTE');
    Result.DataInizio := DateOf(Query.FieldByName('DATA_INIZIO_EFFETTIVA').AsDateTime);
    Result.DataFine := DateOf(Query.FieldByName('DATA_FINE_EFFETTIVA').AsDateTime);
    Result.Descrizione := Format('%s dal %s al %s', [TestoCampo(Query, 'TIPOLOGIA_CORSO'),
      FormatDateTime('dd/mm/yyyy', Result.DataInizio), FormatDateTime('dd/mm/yyyy', Result.DataFine)]);
    Result.ModalitaErogazione := TestoCampo(Query, 'MODALITA_EROGAZIONE');
    Result.Metodo := MetodoDaModalita(Result.ModalitaErogazione);
    Result.IdCorsoGefos := InteroCampo(Query, 'ID_CORSO_GEFOS');

    Result.SedeIndirizzo := TestoCampo(Query, 'SEDE_INDIRIZZO');
    Result.SedeNumeroCivico := TestoCampo(Query, 'SEDE_NUMERO_CIVICO');
    Result.SedeCap := TestoCampo(Query, 'SEDE_CAP');
    Result.SedeCitta := TestoCampo(Query, 'SEDE_CITTA');
    // La sigla resta solo se la provincia non e' in ZZ_PROVINCIE: il validatore la segnala
    Result.SedeProvincia := TestoCampo(Query, 'DESC_PROVINCIA');
    if Result.SedeProvincia = '' then
      Result.SedeProvincia := TestoCampo(Query, 'SEDE_PROVINCIA');
    Result.LinkVideoconferenza := TestoCampo(Query, 'LINK_VIDEOCONFERENZA');

    Result.Tipologia := Default(TGefosTipologiaCorso);
    if not Query.FieldByName('DESCRIZIONE_TIPOLOGIA').IsNull then
    begin
      Result.Tipologia.Id := InteroCampo(Query, 'ID_TIPOLOGIA_CORSO_GEFOS');
      Result.Tipologia.Descrizione := TestoCampo(Query, 'DESCRIZIONE_TIPOLOGIA');
      Result.Tipologia.IdDenominazione := InteroCampo(Query, 'ID_DENOMINAZIONE');
      Result.Tipologia.DescrizioneDenominazione := TestoCampo(Query, 'DESCRIZIONE_DENOMINAZIONE');
      Result.Tipologia.HaMonteOre := not Query.FieldByName('MONTE_ORE').IsNull;
      if Result.Tipologia.HaMonteOre then
        Result.Tipologia.MonteOre := Query.FieldByName('MONTE_ORE').AsInteger;
      Result.Tipologia.MetodiSvolgimento := MetodiDaTesto(TestoCampo(Query, 'METODI_SVOLGIMENTO'));
    end;
  finally
    Query.Free;
  end;
end;

function TGefosCooperazioneApplicativa.CaricaCalendari(const Corso: TGefosCorsoAsr): TArray<TGefosCalendario>;
var
  Query: TFDQuery;
  Calendario: TGefosCalendario;
  Sede: string;
begin
  Result := nil;
  // Le giornate di un corso ASR sono le righe ORARIO con lo stesso progetto e corso
  // (paragrafo 12.1 dell'analisi)
  Query := NuovaQuery(
    'SELECT ' +
    '    ORARIO.DATA_LEZIONE, ' +
    '    ORARIO.ORA_INIZIO, ' +
    '    ORARIO.DURATA, ' +
    '    ORARIO.TIPOLOGIA_FORMAZIONE, ' +
    '    ORARIO.SEDE_FISICA_O_VIRTUALE ' +
    'FROM ' +
    '    ORARIO ' +
    'WHERE ' +
    '    ORARIO.ID_PROGETTO = :ID_PROGETTO AND ' +
    '    ORARIO.ID_CORSO IS NOT DISTINCT FROM :ID_CORSO ' +
    'ORDER BY ' +
    '    ORARIO.DATA_LEZIONE, ' +
    '    ORARIO.ORA_INIZIO');
  try
    Query.ParamByName('ID_PROGETTO').AsLargeInt := Corso.IdProgetto;
    ImpostaIntero(Query.ParamByName('ID_CORSO'), Corso.IdCorso);
    Query.Open;
    while not Query.Eof do
    begin
      Calendario := Default(TGefosCalendario);
      Calendario.DataOraDa := DateOf(Query.FieldByName('DATA_LEZIONE').AsDateTime) + TimeOf(Query.FieldByName('ORA_INIZIO').AsDateTime);
      Calendario.DataOraA := IncMinute(Calendario.DataOraDa, Query.FieldByName('DURATA').AsInteger);
      // Il metodo della singola giornata si invia solo nelle edizioni miste
      if Corso.Metodo = GEFOS_METODO_MISTA then
        Calendario.MetodoGiornata := MetodoDaTipologiaFormazione(TestoCampo(Query, 'TIPOLOGIA_FORMAZIONE'));

      Calendario.Indirizzo := Corso.SedeIndirizzo;
      Calendario.NumeroCivico := Corso.SedeNumeroCivico;
      Calendario.Cap := Corso.SedeCap;
      Calendario.Citta := Corso.SedeCitta;
      Calendario.Provincia := Corso.SedeProvincia;

      // Un collegamento scritto sulla giornata prevale su quello del corso (paragrafo 12.2)
      Sede := TestoCampo(Query, 'SEDE_FISICA_O_VIRTUALE');
      if StartsText('http://', Sede) or StartsText('https://', Sede) then
        Calendario.Link := Sede
      else
        Calendario.Link := Corso.LinkVideoconferenza;

      Result := Result + [Calendario];
      Query.Next;
    end;
  finally
    Query.Free;
  end;

  // In ORARIO una giornata e' spezzata in righe di un'ora: GEFOS vuole slot continui
  Result := TGefosValidatore.FondiSlotContigui(Result);
end;

function TGefosCooperazioneApplicativa.CaricaPartecipanti(const Corso: TGefosCorsoAsr): TArray<TGefosPartecipanteAsr>;
var
  Query: TFDQuery;
  Partecipante: TGefosPartecipanteAsr;
begin
  Result := nil;
  Query := NuovaQuery(
    'SELECT ' +
    '    PROGETTI_ASR_SICUREZZA_PARTECIPANTI.ID_PARTECIPANTE_PROGETTO_ASR, ' +
    '    PROGETTI_ASR_SICUREZZA_PARTECIPANTI.FORMATO, ' +
    '    PROGETTI_ASR_SICUREZZA_PARTECIPANTI.IDONEO, ' +
    '    ANAGRAFE.NOME, ' +
    '    ANAGRAFE.COGNOME, ' +
    '    ANAGRAFE.CODICE_FISCALE, ' +
    '    ANAGRAFE.DATA_NASCITA, ' +
    '    ANAGRAFE.E_MAIL, ' +
    '    ANAGRAFE.SIGLA_STATO_NASCITA, ' +
    '    ANAGRAFE.LUOGO_NASCITA, ' +
    '    ZZ_COMUNI.COMUNE, ' +
    '    ZZ_PROVINCIE.DESC_PROVINCIA, ' +
    '    ZZ_STATI_ESTERI.CODICE_ISO_3166_1_ALPHA_3, ' +
    '    PROGETTI_ASR_SICUREZZA_PARTECIPANTI_GEFOS.ID_PARTECIPANTE_GEFOS, ' +
    '    PROGETTI_ASR_SICUREZZA_PARTECIPANTI_GEFOS.ID_EDIZIONE_ASR_GEFOS, ' +
    '    PROGETTI_ASR_SICUREZZA_PARTECIPANTI_GEFOS.ESITO ' +
    'FROM ' +
    '    PROGETTI_ASR_SICUREZZA_PARTECIPANTI ' +
    '        INNER JOIN STUDENTI_PROGETTI ON STUDENTI_PROGETTI.ID_STUDENTE_PROGETTO = PROGETTI_ASR_SICUREZZA_PARTECIPANTI.ID_STUDENTE_PROGETTO ' +
    '        INNER JOIN ANAGRAFE ON ANAGRAFE.ID_ANAGRAFICA = STUDENTI_PROGETTI.ID_STUDENTE ' +
    '        LEFT OUTER JOIN ZZ_COMUNI ON ZZ_COMUNI.BELFIORE = ANAGRAFE.BELFIORE_NASCITA ' +
    '        LEFT OUTER JOIN ZZ_PROVINCIE ON ZZ_PROVINCIE.PROVINCIA = ZZ_COMUNI.PROVINCIA ' +
    '        LEFT OUTER JOIN ZZ_STATI_ESTERI ON ZZ_STATI_ESTERI.SIGLA_STATO = ANAGRAFE.SIGLA_STATO_NASCITA ' +
    '        LEFT OUTER JOIN PROGETTI_ASR_SICUREZZA_PARTECIPANTI_GEFOS ON PROGETTI_ASR_SICUREZZA_PARTECIPANTI_GEFOS.ID_PARTECIPANTE_PROGETTO_ASR = PROGETTI_ASR_SICUREZZA_PARTECIPANTI.ID_PARTECIPANTE_PROGETTO_ASR ' +
    'WHERE ' +
    '    PROGETTI_ASR_SICUREZZA_PARTECIPANTI.ID_PROGETTO_ASR = :ID_PROGETTO_ASR ' +
    'ORDER BY ' +
    '    ANAGRAFE.COGNOME, ' +
    '    ANAGRAFE.NOME');
  try
    Query.ParamByName('ID_PROGETTO_ASR').AsLargeInt := Corso.IdProgettoAsr;
    Query.Open;
    while not Query.Eof do
    begin
      Partecipante := Default(TGefosPartecipanteAsr);
      Partecipante.IdPartecipanteProgettoAsr := InteroCampo(Query, 'ID_PARTECIPANTE_PROGETTO_ASR');
      Partecipante.Ammesso := Query.FieldByName('FORMATO').AsBoolean;
      Partecipante.Idoneo := Query.FieldByName('IDONEO').AsBoolean;
      Partecipante.IdEdizioneAsrGefos := InteroCampo(Query, 'ID_EDIZIONE_ASR_GEFOS');
      Partecipante.EsitoComunicato := InteroCampo(Query, 'ESITO');

      Partecipante.Dati.Id := InteroCampo(Query, 'ID_PARTECIPANTE_GEFOS');
      Partecipante.Dati.Nome := TestoCampo(Query, 'NOME');
      Partecipante.Dati.Cognome := TestoCampo(Query, 'COGNOME');
      Partecipante.Dati.CodiceFiscale := UpperCase(TestoCampo(Query, 'CODICE_FISCALE'));
      if not Query.FieldByName('DATA_NASCITA').IsNull then
        Partecipante.Dati.DataNascita := DateOf(Query.FieldByName('DATA_NASCITA').AsDateTime);
      // Solo l'e-mail personale: quella dell'ente o la PEC non identificano il lavoratore
      // (domanda 1 a CAPAC, ancora aperta)
      Partecipante.Dati.Email := TestoCampo(Query, 'E_MAIL');

      // GEFOS accetta il codice a tre lettere ("ITA"); la sigla di Gesty coincide quasi
      // sempre, e resta come ripiego se lo stato non e' in ZZ_STATI_ESTERI
      Partecipante.Dati.StatoNascita := TestoCampo(Query, 'CODICE_ISO_3166_1_ALPHA_3');
      if Partecipante.Dati.StatoNascita = '' then
        Partecipante.Dati.StatoNascita := TestoCampo(Query, 'SIGLA_STATO_NASCITA');
      if Partecipante.Dati.NatoInItalia then
      begin
        Partecipante.Dati.ProvinciaNascita := TestoCampo(Query, 'DESC_PROVINCIA');
        Partecipante.Dati.ComuneNascita := TestoCampo(Query, 'COMUNE');
        if Partecipante.Dati.ComuneNascita = '' then
          Partecipante.Dati.ComuneNascita := TestoCampo(Query, 'LUOGO_NASCITA');
      end;

      Result := Result + [Partecipante];
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

function TGefosCooperazioneApplicativa.CostruisciEdizioni(const Corso: TGefosCorsoAsr): TArray<TGefosEdizioneAsr>;
var
  Calendari: TArray<TGefosCalendario>;
  Partecipanti: TArray<TGefosPartecipanteAsr>;
  Partecipante: TGefosPartecipanteAsr;
  Calendario: TGefosCalendario;
  Modello: TGefosEdizioneAsr;
  Query: TFDQuery;
  Indice: Integer;
  IdPartecipante: Int64;
begin
  Calendari := CaricaCalendari(Corso);
  Partecipanti := CaricaPartecipanti(Corso);

  // Dati comuni a tutte le edizioni del corso. L'ora di inizio e' quella della prima
  // giornata del primo giorno: GEFOS vuole che coincidano. Senza giornate quel giorno
  // resta la mezzanotte, e il validatore segnala il primo giorno scoperto.
  Modello := Default(TGefosEdizioneAsr);
  Modello.Edizione.MetodoSvolgimento := Corso.Metodo;
  Modello.Edizione.DataOraInizio := Corso.DataInizio;
  for Calendario in Calendari do
    if SameDate(Calendario.DataOraDa, Corso.DataInizio) then
    begin
      Modello.Edizione.DataOraInizio := Calendario.DataOraDa;
      Break;
    end;
  Modello.Edizione.DataFine := Corso.DataFine;
  Modello.Edizione.Calendari := Calendari;

  // In e-learning GEFOS ammette un solo partecipante per edizione: un'edizione per
  // partecipante, sotto lo stesso corso (paragrafo 12.3). Altrimenti una sola edizione.
  Result := nil;
  if Corso.Metodo = GEFOS_METODO_E_LEARNING then
    for Partecipante in Partecipanti do
    begin
      Modello.IdPartecipanteProgettoAsr := Partecipante.IdPartecipanteProgettoAsr;
      Modello.Partecipanti := [Partecipante];
      Result := Result + [Modello];
    end
  else
  begin
    Modello.IdPartecipanteProgettoAsr := 0;
    Modello.Partecipanti := Partecipanti;
    Result := Result + [Modello];
  end;

  // Stato delle edizioni gia' registrate
  Query := NuovaQuery(
    'SELECT ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.ID_EDIZIONE_ASR_GEFOS, ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.ID_PARTECIPANTE_PROGETTO_ASR, ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.ID_EDIZIONE_GEFOS, ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.DATA_ORA_AVVIO, ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.DATA_ORA_CONCLUSIONE ' +
    'FROM ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS ' +
    'WHERE ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.ID_PROGETTO_ASR = :ID_PROGETTO_ASR');
  try
    Query.ParamByName('ID_PROGETTO_ASR').AsLargeInt := Corso.IdProgettoAsr;
    Query.Open;
    while not Query.Eof do
    begin
      IdPartecipante := InteroCampo(Query, 'ID_PARTECIPANTE_PROGETTO_ASR');
      for Indice := 0 to High(Result) do
        if Result[Indice].IdPartecipanteProgettoAsr = IdPartecipante then
        begin
          Result[Indice].IdEdizioneAsrGefos := InteroCampo(Query, 'ID_EDIZIONE_ASR_GEFOS');
          Result[Indice].Edizione.Id := InteroCampo(Query, 'ID_EDIZIONE_GEFOS');
          Result[Indice].Edizione.Avviata := not Query.FieldByName('DATA_ORA_AVVIO').IsNull;
          Result[Indice].Avviata := Result[Indice].Edizione.Avviata;
          Result[Indice].Conclusa := not Query.FieldByName('DATA_ORA_CONCLUSIONE').IsNull;
          Break;
        end;
      Query.Next;
    end;
  finally
    Query.Free;
  end;
end;

function TGefosCooperazioneApplicativa.TestoDichiarazioni(const Operazione: string; IdDenominazione: Integer): string;
var
  Query: TFDQuery;
  Righe: TStringBuilder;
begin
  // Prima le righe comuni a tutte le denominazioni (ID_DENOMINAZIONE 0, ORDINE 0 =
  // preambolo), poi quelle della denominazione del corso
  Query := NuovaQuery(
    'SELECT ' +
    '    GEFOS_DICHIARAZIONI.TESTO ' +
    'FROM ' +
    '    GEFOS_DICHIARAZIONI ' +
    'WHERE ' +
    '    GEFOS_DICHIARAZIONI.OPERAZIONE = :OPERAZIONE AND ' +
    '    GEFOS_DICHIARAZIONI.ID_DENOMINAZIONE IN (0, :ID_DENOMINAZIONE) ' +
    'ORDER BY ' +
    '    IIF(GEFOS_DICHIARAZIONI.ID_DENOMINAZIONE = 0, 0, 1), ' +
    '    GEFOS_DICHIARAZIONI.ORDINE');
  Righe := TStringBuilder.Create;
  try
    Query.ParamByName('OPERAZIONE').AsWideString := Operazione;
    Query.ParamByName('ID_DENOMINAZIONE').AsInteger := IdDenominazione;
    Query.Open;
    while not Query.Eof do
    begin
      if Righe.Length > 0 then
        Righe.AppendLine.AppendLine;
      Righe.Append(TestoCampo(Query, 'TESTO'));
      Query.Next;
    end;
    Result := Righe.ToString;
  finally
    Righe.Free;
    Query.Free;
  end;
end;

{ Scritture delle tabelle di collegamento }

procedure TGefosCooperazioneApplicativa.SalvaIdCorso(const Corso: TGefosCorsoAsr);
var
  Query: TFDQuery;
begin
  Query := NuovaQuery(
    'UPDATE PROGETTI_ASR_SICUREZZA_GEFOS ' +
    'SET ' +
    '    PROGETTI_ASR_SICUREZZA_GEFOS.ID_CORSO_GEFOS = :ID_CORSO_GEFOS ' +
    'WHERE ' +
    '    PROGETTI_ASR_SICUREZZA_GEFOS.ID_PROGETTO_ASR = :ID_PROGETTO_ASR');
  try
    Query.ParamByName('ID_CORSO_GEFOS').AsLargeInt := Corso.IdCorsoGefos;
    Query.ParamByName('ID_PROGETTO_ASR').AsLargeInt := Corso.IdProgettoAsr;
    EseguiScrittura(Query);
  finally
    Query.Free;
  end;
end;

procedure TGefosCooperazioneApplicativa.InserisciEdizioneLocale(const Corso: TGefosCorsoAsr; var Edizione: TGefosEdizioneAsr);
var
  Query: TFDQuery;
begin
  // Con RETURNING FireDAC apre l'istruzione come un cursore di una riga
  Query := NuovaQuery(
    'INSERT INTO PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS (ID_PROGETTO_ASR, ID_PARTECIPANTE_PROGETTO_ASR) ' +
    'VALUES (:ID_PROGETTO_ASR, :ID_PARTECIPANTE_PROGETTO_ASR) ' +
    'RETURNING ID_EDIZIONE_ASR_GEFOS');
  try
    Query.ParamByName('ID_PROGETTO_ASR').AsLargeInt := Corso.IdProgettoAsr;
    ImpostaIntero(Query.ParamByName('ID_PARTECIPANTE_PROGETTO_ASR'), Edizione.IdPartecipanteProgettoAsr);
    FTransazione.StartTransaction;
    try
      Query.Open;
      Edizione.IdEdizioneAsrGefos := Query.FieldByName('ID_EDIZIONE_ASR_GEFOS').AsLargeInt;
      Query.Close;
      FTransazione.Commit;
    except
      if FTransazione.Active then
        FTransazione.Rollback;
      raise;
    end;
  finally
    Query.Free;
  end;
end;

procedure TGefosCooperazioneApplicativa.SalvaDatiEdizione(const Edizione: TGefosEdizioneAsr);
var
  Query: TFDQuery;
begin
  Query := NuovaQuery(
    'UPDATE PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS ' +
    'SET ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.ID_EDIZIONE_GEFOS = :ID_EDIZIONE_GEFOS, ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.METODO_SVOLGIMENTO = :METODO_SVOLGIMENTO, ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.DATA_ORA_INIZIO = :DATA_ORA_INIZIO, ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.DATA_FINE = :DATA_FINE, ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.DATA_ORA_CALENDARIO = CURRENT_TIMESTAMP ' +
    'WHERE ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.ID_EDIZIONE_ASR_GEFOS = :ID_EDIZIONE_ASR_GEFOS');
  try
    ImpostaIntero(Query.ParamByName('ID_EDIZIONE_GEFOS'), Edizione.Edizione.Id);
    Query.ParamByName('METODO_SVOLGIMENTO').AsSmallInt := Edizione.Edizione.MetodoSvolgimento;
    ImpostaDataOra(Query.ParamByName('DATA_ORA_INIZIO'), Edizione.Edizione.DataOraInizio);
    ImpostaData(Query.ParamByName('DATA_FINE'), Edizione.Edizione.DataFine);
    Query.ParamByName('ID_EDIZIONE_ASR_GEFOS').AsLargeInt := Edizione.IdEdizioneAsrGefos;
    EseguiScrittura(Query);
  finally
    Query.Free;
  end;
end;

procedure TGefosCooperazioneApplicativa.SalvaAvvio(const Edizione: TGefosEdizioneAsr);
var
  Query: TFDQuery;
begin
  // USER_AVVIO e' chi ha accettato le dichiarazioni (vincolo CHK_..._AVVIO)
  Query := NuovaQuery(
    'UPDATE PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS ' +
    'SET ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.DATA_ORA_AVVIO = CURRENT_TIMESTAMP, ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.USER_AVVIO = :USER_AVVIO ' +
    'WHERE ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.ID_EDIZIONE_ASR_GEFOS = :ID_EDIZIONE_ASR_GEFOS');
  try
    Query.ParamByName('USER_AVVIO').AsLargeInt := Config.CurrentUserID;
    Query.ParamByName('ID_EDIZIONE_ASR_GEFOS').AsLargeInt := Edizione.IdEdizioneAsrGefos;
    EseguiScrittura(Query);
  finally
    Query.Free;
  end;
end;

procedure TGefosCooperazioneApplicativa.SalvaConclusione(const Edizione: TGefosEdizioneAsr);
var
  Query: TFDQuery;
begin
  Query := NuovaQuery(
    'UPDATE PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS ' +
    'SET ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.DATA_ORA_CONCLUSIONE = CURRENT_TIMESTAMP, ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.USER_CONCLUSIONE = :USER_CONCLUSIONE ' +
    'WHERE ' +
    '    PROGETTI_ASR_SICUREZZA_EDIZIONI_GEFOS.ID_EDIZIONE_ASR_GEFOS = :ID_EDIZIONE_ASR_GEFOS');
  try
    Query.ParamByName('USER_CONCLUSIONE').AsLargeInt := Config.CurrentUserID;
    Query.ParamByName('ID_EDIZIONE_ASR_GEFOS').AsLargeInt := Edizione.IdEdizioneAsrGefos;
    EseguiScrittura(Query);
  finally
    Query.Free;
  end;
end;

procedure TGefosCooperazioneApplicativa.SalvaIscrizione(const Edizione: TGefosEdizioneAsr; const Partecipante: TGefosPartecipanteAsr);
var
  Query: TFDQuery;
begin
  Query := NuovaQuery(
    'UPDATE OR INSERT INTO PROGETTI_ASR_SICUREZZA_PARTECIPANTI_GEFOS (ID_PARTECIPANTE_PROGETTO_ASR, ID_EDIZIONE_ASR_GEFOS, ID_PARTECIPANTE_GEFOS, DATA_ORA_ISCRIZIONE) ' +
    'VALUES (:ID_PARTECIPANTE_PROGETTO_ASR, :ID_EDIZIONE_ASR_GEFOS, :ID_PARTECIPANTE_GEFOS, CURRENT_TIMESTAMP) ' +
    'MATCHING (ID_PARTECIPANTE_PROGETTO_ASR)');
  try
    Query.ParamByName('ID_PARTECIPANTE_PROGETTO_ASR').AsLargeInt := Partecipante.IdPartecipanteProgettoAsr;
    Query.ParamByName('ID_EDIZIONE_ASR_GEFOS').AsLargeInt := Edizione.IdEdizioneAsrGefos;
    Query.ParamByName('ID_PARTECIPANTE_GEFOS').AsLargeInt := Partecipante.Dati.Id;
    EseguiScrittura(Query);
  finally
    Query.Free;
  end;
end;

procedure TGefosCooperazioneApplicativa.SalvaEsito(const Partecipante: TGefosPartecipanteAsr; Esito: Integer);
var
  Query: TFDQuery;
begin
  Query := NuovaQuery(
    'UPDATE PROGETTI_ASR_SICUREZZA_PARTECIPANTI_GEFOS ' +
    'SET ' +
    '    PROGETTI_ASR_SICUREZZA_PARTECIPANTI_GEFOS.ESITO = :ESITO, ' +
    '    PROGETTI_ASR_SICUREZZA_PARTECIPANTI_GEFOS.DATA_ORA_ESITO = CURRENT_TIMESTAMP ' +
    'WHERE ' +
    '    PROGETTI_ASR_SICUREZZA_PARTECIPANTI_GEFOS.ID_PARTECIPANTE_PROGETTO_ASR = :ID_PARTECIPANTE_PROGETTO_ASR');
  try
    Query.ParamByName('ESITO').AsSmallInt := Esito;
    Query.ParamByName('ID_PARTECIPANTE_PROGETTO_ASR').AsLargeInt := Partecipante.IdPartecipanteProgettoAsr;
    EseguiScrittura(Query);
  finally
    Query.Free;
  end;
end;

{ Registro delle chiamate }

procedure TGefosCooperazioneApplicativa.ImpostaContesto(IdProgettoAsr, IdPartecipanteProgettoAsr, IdCorsoGefos, IdEdizioneGefos,
  IdPartecipanteGefos: Int64);
begin
  FContesto.IdProgettoAsr := IdProgettoAsr;
  FContesto.IdPartecipanteProgettoAsr := IdPartecipanteProgettoAsr;
  FContesto.IdCorsoGefos := IdCorsoGefos;
  FContesto.IdEdizioneGefos := IdEdizioneGefos;
  FContesto.IdPartecipanteGefos := IdPartecipanteGefos;
end;

function TGefosCooperazioneApplicativa.ScriviFileTemporaneo(Operazione: TGefosOperazione; const Momento, Parte, Contenuto: string): string;
begin
  if Contenuto = '' then
    Exit('');
  ForceDirectories(FCartellaTemporanea);
  // Es.: GEFOS AVV 2026-10-23 10-15-02-123 richiesta.json
  Result := TPath.Combine(FCartellaTemporanea, Format('GEFOS %s %s %s.json', [GefosCodiceOperazione(Operazione), Momento, Parte]));
  TFile.WriteAllText(Result, Contenuto, TEncoding.UTF8);
end;

procedure TGefosCooperazioneApplicativa.RegistraChiamata(const Risposta: TGefosRisposta);

  procedure CopiaNellArchivio(const Origine, Destinazione: string);
  begin
    if (Origine = '') or (Destinazione = '') or not TFile.Exists(Origine) then
      Exit;
    ForceDirectories(TPath.GetDirectoryName(Destinazione));
    TFile.Copy(Origine, Destinazione, True);
  end;

var
  Procedura: TFDStoredProc;
  Momento, FileRichiesta, FileRisposta, DestinazioneRichiesta, DestinazioneRisposta: string;
begin
  // Il registro non deve mai interrompere la sequenza delle chiamate: un errore qui
  // si annota nel riepilogo, e la chiamata resta comunque nei file temporanei
  try
    Momento := FormatDateTime('yyyy-mm-dd hh-nn-ss-zzz', Now);
    FileRichiesta := ScriviFileTemporaneo(Risposta.Operazione, Momento, 'richiesta', Risposta.CorpoRichiesta);
    FileRisposta := ScriviFileTemporaneo(Risposta.Operazione, Momento, 'risposta', Risposta.CorpoRisposta);

    Procedura := TFDStoredProc.Create(nil);
    try
      Procedura.Connection := Config.Database;
      Procedura.Transaction := FTransazione;
      Procedura.StoredProcName := 'GEFOS_COOPERAZIONE_APPLICATIVA_INVII_ADD';
      Procedura.Prepare;

      Procedura.ParamByName('ID_ENTE').AsLargeInt := FIdEnte;
      Procedura.ParamByName('AMBIENTE_TEST').AsBoolean := FAmbienteTest;
      Procedura.ParamByName('USER_ID').AsLargeInt := Config.CurrentUserID;
      Procedura.ParamByName('OPERAZIONE').AsWideString := GefosCodiceOperazione(Risposta.Operazione);
      Procedura.ParamByName('METODO_HTTP').AsWideString := Risposta.MetodoHttp;
      Procedura.ParamByName('URL').AsWideString := Risposta.Url;
      ImpostaIntero(Procedura.ParamByName('ID_PROGETTO_ASR'), FContesto.IdProgettoAsr);
      ImpostaIntero(Procedura.ParamByName('ID_PARTECIPANTE_PROGETTO_ASR'), FContesto.IdPartecipanteProgettoAsr);
      // Per le creazioni l'identificativo nuovo arriva nella risposta
      if (Risposta.Operazione = goCreaCorso) and (Risposta.IdCreato <> 0) then
        ImpostaIntero(Procedura.ParamByName('ID_CORSO_GEFOS'), Risposta.IdCreato)
      else
        ImpostaIntero(Procedura.ParamByName('ID_CORSO_GEFOS'), FContesto.IdCorsoGefos);
      if (Risposta.Operazione = goCreaEdizione) and (Risposta.IdCreato <> 0) then
        ImpostaIntero(Procedura.ParamByName('ID_EDIZIONE_GEFOS'), Risposta.IdCreato)
      else
        ImpostaIntero(Procedura.ParamByName('ID_EDIZIONE_GEFOS'), FContesto.IdEdizioneGefos);
      if (Risposta.Operazione = goAggiungiPartecipante) and (Risposta.IdCreato <> 0) then
        ImpostaIntero(Procedura.ParamByName('ID_PARTECIPANTE_GEFOS'), Risposta.IdCreato)
      else
        ImpostaIntero(Procedura.ParamByName('ID_PARTECIPANTE_GEFOS'), FContesto.IdPartecipanteGefos);
      if Risposta.Operazione in [goAvvio, goConfermaConclusione] then
        Procedura.ParamByName('DICHIARAZIONI_ACCETTATE').AsBoolean := Risposta.DichiarazioniAccettate
      else
        Procedura.ParamByName('DICHIARAZIONI_ACCETTATE').Clear;
      Procedura.ParamByName('RIUSCITA').AsBoolean := Risposta.Riuscita;
      if Risposta.StatoHttp <> 0 then
        Procedura.ParamByName('HTTP_STATUS').AsInteger := Risposta.StatoHttp
      else
        Procedura.ParamByName('HTTP_STATUS').Clear;
      ImpostaTesto(Procedura.ParamByName('CODICE_ERRORE'), Risposta.Errore.Codice);
      ImpostaTesto(Procedura.ParamByName('MESSAGGIO'), Risposta.MessaggioOperatore);
      Procedura.ParamByName('DURATA_MS').AsInteger := Risposta.DurataMs;
      ImpostaTesto(Procedura.ParamByName('REQUEST_FILE_NAME'), TPath.GetFileName(FileRichiesta));
      ImpostaTesto(Procedura.ParamByName('RESPONSE_FILE_NAME'), TPath.GetFileName(FileRisposta));

      FTransazione.StartTransaction;
      try
        Procedura.ExecProc;
        FTransazione.Commit;
      except
        if FTransazione.Active then
          FTransazione.Rollback;
        raise;
      end;

      DestinazioneRichiesta := Procedura.ParamByName('REQUEST_FULL_FILE_NAME').AsString;
      DestinazioneRisposta := Procedura.ParamByName('RESPONSE_FULL_FILE_NAME').AsString;
    finally
      Procedura.Free;
    end;

    CopiaNellArchivio(FileRichiesta, DestinazioneRichiesta);
    CopiaNellArchivio(FileRisposta, DestinazioneRisposta);
  except
    on Errore: Exception do
      FRiepilogo.Add(Format('Attenzione: la chiamata "%s" non e'' stata registrata nell''archivio degli invii: %s',
        [GefosDescrizioneOperazione(Risposta.Operazione), Errore.Message]));
  end;
end;

{ Passi delle sequenze }

function TGefosCooperazioneApplicativa.NuovoClient: TGefosClient;
begin
  Result := TGefosClient.Create(FConfigurazione);
  Result.OnChiamata := RegistraChiamata;
end;

procedure TGefosCooperazioneApplicativa.AnnotaErrore(const Riferimento: string; const Risposta: TGefosRisposta);
begin
  FRiepilogo.Add('KO - ' + Riferimento);
  FRiepilogo.Add('     ' + StringReplace(Risposta.MessaggioOperatore, sLineBreak, sLineBreak + '     ', [rfReplaceAll]));
end;

function TGefosCooperazioneApplicativa.CreaCorsoSeManca(Client: TGefosClient; var Corso: TGefosCorsoAsr): Boolean;
var
  Risposta: TGefosRisposta;
begin
  if Corso.IdCorsoGefos <> 0 then
    Exit(True);

  ImpostaContesto(Corso.IdProgettoAsr, 0, 0, 0, 0);
  Risposta := Client.CreaCorso(Corso.Tipologia.Id);
  if not Risposta.Riuscita or (Risposta.IdCreato = 0) then
  begin
    // Una risposta positiva senza id non si puo' usare: si tratta come un errore,
    // altrimenti MessaggioOperatore resterebbe vuoto
    if Risposta.Riuscita then
    begin
      Risposta.Riuscita := False;
      Risposta.Errore.Dettaglio := 'GEFOS non ha restituito l''identificativo del corso.';
    end;
    AnnotaErrore('Creazione del corso', Risposta);
    Exit(False);
  end;

  Corso.IdCorsoGefos := Risposta.IdCreato;
  SalvaIdCorso(Corso);
  FRiepilogo.Add(Format('OK - Corso creato in GEFOS (%d).', [Corso.IdCorsoGefos]));
  Result := True;
end;

function TGefosCooperazioneApplicativa.PreparaEdizioneRemota(Client: TGefosClient; const Corso: TGefosCorsoAsr;
  var Edizione: TGefosEdizioneAsr): Boolean;
var
  Risposta: TGefosRisposta;
begin
  if Edizione.IdEdizioneAsrGefos = 0 then
    InserisciEdizioneLocale(Corso, Edizione);

  // Edizione gia' creata in una sequenza precedente: si riallineano date e calendario
  if Edizione.Edizione.Id <> 0 then
    Exit(AllineaEdizioneRemota(Client, Corso, Edizione));

  ImpostaContesto(Corso.IdProgettoAsr, Edizione.IdPartecipanteProgettoAsr, Corso.IdCorsoGefos, 0, 0);
  Risposta := Client.CreaEdizione(Corso.IdCorsoGefos, Edizione.Edizione);
  if not Risposta.Riuscita or (Risposta.IdCreato = 0) then
  begin
    if Risposta.Riuscita then
    begin
      Risposta.Riuscita := False;
      Risposta.Errore.Dettaglio := 'GEFOS non ha restituito l''identificativo dell''edizione.';
    end;
    AnnotaErrore(Edizione.Nome + ': creazione', Risposta);
    Exit(False);
  end;

  Edizione.Edizione.Id := Risposta.IdCreato;
  SalvaDatiEdizione(Edizione);
  FRiepilogo.Add('OK - ' + Edizione.Nome + ': creata con il calendario.');
  Result := True;
end;

function TGefosCooperazioneApplicativa.AllineaEdizioneRemota(Client: TGefosClient; const Corso: TGefosCorsoAsr;
  var Edizione: TGefosEdizioneAsr): Boolean;
var
  Remota: TGefosEdizione;
  Precedente: TGefosCalendario;
  Nuovi: TArray<TGefosCalendario>;
  Problemi: TGefosProblemi;
  Risposta: TGefosRisposta;
  DatiCambiati, CalendarioCambiato: Boolean;
  Indice: Integer;
begin
  Result := False;
  ImpostaContesto(Corso.IdProgettoAsr, Edizione.IdPartecipanteProgettoAsr, Corso.IdCorsoGefos, Edizione.Edizione.Id, 0);
  Risposta := Client.LeggiEdizione(Corso.IdCorsoGefos, Edizione.Edizione.Id, Remota);
  if not Risposta.Riuscita then
  begin
    AnnotaErrore(Edizione.Nome + ': lettura da GEFOS', Risposta);
    Exit;
  end;

  // Gia' avviata in GEFOS: metodo e date non si cambiano piu'; l'avvio che segue
  // ricevera' EDIZIONE_AVVIATA e allineera' Gesty
  if Remota.Avviata then
    Exit(True);

  DatiCambiati := (Remota.MetodoSvolgimento <> Edizione.Edizione.MetodoSvolgimento) or
    not StessoMinuto(Remota.DataOraInizio, Edizione.Edizione.DataOraInizio) or
    (DateOf(Remota.DataFine) <> DateOf(Edizione.Edizione.DataFine));

  // Gli slot invariati si reinviano con il loro id, come chiede PUT .../calendari
  Nuovi := Copy(Edizione.Edizione.Calendari);
  for Indice := 0 to High(Nuovi) do
    for Precedente in Remota.Calendari do
      if StessoSlot(Edizione.Edizione.MetodoSvolgimento, Nuovi[Indice], Precedente) then
      begin
        Nuovi[Indice].Id := Precedente.Id;
        Break;
      end;
  CalendarioCambiato := Length(Nuovi) <> Length(Remota.Calendari);
  for Indice := 0 to High(Nuovi) do
    if Nuovi[Indice].Id = 0 then
      CalendarioCambiato := True;

  if not DatiCambiati and not CalendarioCambiato then
    Exit(True);

  if DatiCambiati then
  begin
    Risposta := Client.ModificaEdizione(Corso.IdCorsoGefos, Edizione.Edizione.Id, Edizione.Edizione);
    if not Risposta.Riuscita then
    begin
      AnnotaErrore(Edizione.Nome + ': modifica di metodo e date', Risposta);
      Exit;
    end;
    // La modifica dell'edizione azzera il calendario in GEFOS: si reinvia per intero
    for Indice := 0 to High(Nuovi) do
      Nuovi[Indice].Id := 0;
  end
  else
  begin
    Problemi := TGefosValidatore.ControllaAggiornamentoCalendari(Remota.Calendari, Nuovi, Date);
    if GefosProblemiHannoErrori(Problemi) then
    begin
      FRiepilogo.Add('KO - ' + Edizione.Nome + ': calendario non aggiornabile');
      FRiepilogo.Add(GefosProblemiTesto(Problemi));
      Exit;
    end;
  end;

  Risposta := Client.AggiornaCalendari(Corso.IdCorsoGefos, Edizione.Edizione.Id, Edizione.Edizione.MetodoSvolgimento, Nuovi);
  if not Risposta.Riuscita then
  begin
    AnnotaErrore(Edizione.Nome + ': aggiornamento del calendario', Risposta);
    Exit;
  end;

  SalvaDatiEdizione(Edizione);
  FRiepilogo.Add('OK - ' + Edizione.Nome + ': date e calendario aggiornati.');
  Result := True;
end;

function TGefosCooperazioneApplicativa.CercaPartecipanteRemoto(Client: TGefosClient; const Corso: TGefosCorsoAsr;
  const Edizione: TGefosEdizioneAsr; const Partecipante: TGefosPartecipante): Int64;
var
  Remota: TGefosEdizione;
  Iscritto: TGefosPartecipante;
begin
  // Serve quando GEFOS ha gia' il partecipante ma Gesty non ne ha salvato l'id
  // (per esempio un salvataggio fallito dopo un'iscrizione riuscita)
  Result := 0;
  if not Client.LeggiEdizione(Corso.IdCorsoGefos, Edizione.Edizione.Id, Remota).Riuscita then
    Exit;
  for Iscritto in Remota.Partecipanti do
    if ((Partecipante.CodiceFiscale <> '') and SameText(Iscritto.CodiceFiscale, Partecipante.CodiceFiscale)) or
       ((Partecipante.CodiceIdentificativoEstero <> '') and SameText(Iscritto.CodiceIdentificativoEstero, Partecipante.CodiceIdentificativoEstero)) then
      Exit(Iscritto.Id);
end;

function TGefosCooperazioneApplicativa.IscriviPartecipantiMancanti(Client: TGefosClient; const Corso: TGefosCorsoAsr;
  var Edizione: TGefosEdizioneAsr): Boolean;
var
  Indice: Integer;
  Problemi: TGefosProblemi;
  Risposta: TGefosRisposta;
  IdRecuperato: Int64;
begin
  Result := True;
  for Indice := 0 to High(Edizione.Partecipanti) do
  begin
    if Edizione.Partecipanti[Indice].Dati.Id <> 0 then
      Continue;

    Problemi := TGefosValidatore.ControllaPartecipante(Edizione.Partecipanti[Indice].Dati, Date);
    if GefosProblemiHannoErrori(Problemi) then
    begin
      FRiepilogo.Add('KO - ' + Edizione.Partecipanti[Indice].Dati.Nominativo + ': dati incompleti');
      FRiepilogo.Add(GefosProblemiTesto(Problemi));
      Result := False;
      Continue;
    end;

    ImpostaContesto(Corso.IdProgettoAsr, Edizione.Partecipanti[Indice].IdPartecipanteProgettoAsr, Corso.IdCorsoGefos,
      Edizione.Edizione.Id, 0);
    Risposta := Client.AggiungiPartecipante(Corso.IdCorsoGefos, Edizione.Edizione.Id, Edizione.Partecipanti[Indice].Dati);
    if Risposta.Riuscita and (Risposta.IdCreato <> 0) then
      Edizione.Partecipanti[Indice].Dati.Id := Risposta.IdCreato
    else if SameText(Risposta.Errore.Codice, 'PARTECIPANTE_DUPLICATO') then
    begin
      IdRecuperato := CercaPartecipanteRemoto(Client, Corso, Edizione, Edizione.Partecipanti[Indice].Dati);
      if IdRecuperato = 0 then
      begin
        AnnotaErrore(Edizione.Partecipanti[Indice].Dati.Nominativo + ': iscrizione', Risposta);
        Result := False;
        Continue;
      end;
      Edizione.Partecipanti[Indice].Dati.Id := IdRecuperato;
    end
    else
    begin
      if Risposta.Riuscita then
      begin
        Risposta.Riuscita := False;
        Risposta.Errore.Dettaglio := 'GEFOS non ha restituito l''identificativo del partecipante.';
      end;
      AnnotaErrore(Edizione.Partecipanti[Indice].Dati.Nominativo + ': iscrizione', Risposta);
      Result := False;
      Continue;
    end;

    Edizione.Partecipanti[Indice].IdEdizioneAsrGefos := Edizione.IdEdizioneAsrGefos;
    SalvaIscrizione(Edizione, Edizione.Partecipanti[Indice]);
    FRiepilogo.Add(Format('OK - %s: iscritto (%d).', [Edizione.Partecipanti[Indice].Dati.Nominativo, Edizione.Partecipanti[Indice].Dati.Id]));
  end;
end;

function TGefosCooperazioneApplicativa.AvviaEdizione(Client: TGefosClient; const Corso: TGefosCorsoAsr;
  var Edizione: TGefosEdizioneAsr): Boolean;
var
  Problemi: TGefosProblemi;
  Risposta: TGefosRisposta;
begin
  Result := False;
  Problemi := TGefosValidatore.ControllaAvvio(Edizione.Edizione, True, True);
  if GefosProblemiHannoErrori(Problemi) then
  begin
    FRiepilogo.Add('KO - ' + Edizione.Nome + ': avvio');
    FRiepilogo.Add(GefosProblemiTesto(Problemi));
    Exit;
  end;

  ImpostaContesto(Corso.IdProgettoAsr, Edizione.IdPartecipanteProgettoAsr, Corso.IdCorsoGefos, Edizione.Edizione.Id, 0);
  Risposta := Client.ComunicaAvvio(Corso.IdCorsoGefos, Edizione.Edizione.Id, True);
  if Risposta.Riuscita then
    FRiepilogo.Add('OK - ' + Edizione.Nome + ': avvio comunicato.')
  else if SameText(Risposta.Errore.Codice, 'EDIZIONE_AVVIATA') then
    // Avvio gia' arrivato a GEFOS (sequenza precedente interrotta prima del salvataggio)
    FRiepilogo.Add('OK - ' + Edizione.Nome + ': GEFOS la risultava gia'' avviata, Gesty e'' stato allineato.')
  else
  begin
    AnnotaErrore(Edizione.Nome + ': avvio', Risposta);
    Exit;
  end;

  SalvaAvvio(Edizione);
  Edizione.Avviata := True;
  Edizione.Edizione.Avviata := True;
  Result := True;
end;

function TGefosCooperazioneApplicativa.ComunicaEsitiEdizione(Client: TGefosClient; const Corso: TGefosCorsoAsr;
  var Edizione: TGefosEdizioneAsr): Boolean;
var
  Nuovi: TArray<TGefosEsitoPartecipante>;
  Indice, Esito: Integer;
  Risposta: TGefosRisposta;
begin
  Result := True;

  // Prima gli esiti mai comunicati, tutti insieme con POST .../esiti
  Nuovi := nil;
  for Indice := 0 to High(Edizione.Partecipanti) do
    if (Edizione.Partecipanti[Indice].Dati.Id <> 0) and (Edizione.Partecipanti[Indice].EsitoComunicato = 0) then
      Nuovi := Nuovi + [TGefosEsitoPartecipante.Create(Edizione.Partecipanti[Indice].Dati.Id,
        TGefosValidatore.EsitoDaIdoneita(Edizione.Partecipanti[Indice].Ammesso, Edizione.Partecipanti[Indice].Idoneo))];

  if Length(Nuovi) > 0 then
  begin
    ImpostaContesto(Corso.IdProgettoAsr, Edizione.IdPartecipanteProgettoAsr, Corso.IdCorsoGefos, Edizione.Edizione.Id, 0);
    Risposta := Client.ComunicaEsiti(Corso.IdCorsoGefos, Edizione.Edizione.Id, Nuovi);
    if Risposta.Riuscita then
    begin
      for Indice := 0 to High(Edizione.Partecipanti) do
        if (Edizione.Partecipanti[Indice].Dati.Id <> 0) and (Edizione.Partecipanti[Indice].EsitoComunicato = 0) then
        begin
          Esito := TGefosValidatore.EsitoDaIdoneita(Edizione.Partecipanti[Indice].Ammesso, Edizione.Partecipanti[Indice].Idoneo);
          SalvaEsito(Edizione.Partecipanti[Indice], Esito);
          Edizione.Partecipanti[Indice].EsitoComunicato := Esito;
        end;
      FRiepilogo.Add(Format('OK - %s: %d esiti comunicati.', [Edizione.Nome, Length(Nuovi)]));
    end
    else
    begin
      AnnotaErrore(Edizione.Nome + ': esiti', Risposta);
      Result := False;
    end;
  end;

  // Poi gli esiti cambiati in Gesty dopo l'invio, uno per uno con PUT
  for Indice := 0 to High(Edizione.Partecipanti) do
  begin
    if (Edizione.Partecipanti[Indice].Dati.Id = 0) or (Edizione.Partecipanti[Indice].EsitoComunicato = 0) then
      Continue;
    Esito := TGefosValidatore.EsitoDaIdoneita(Edizione.Partecipanti[Indice].Ammesso, Edizione.Partecipanti[Indice].Idoneo);
    if Esito = Edizione.Partecipanti[Indice].EsitoComunicato then
      Continue;

    ImpostaContesto(Corso.IdProgettoAsr, Edizione.Partecipanti[Indice].IdPartecipanteProgettoAsr, Corso.IdCorsoGefos,
      Edizione.Edizione.Id, Edizione.Partecipanti[Indice].Dati.Id);
    Risposta := Client.ComunicaEsito(Corso.IdCorsoGefos, Edizione.Edizione.Id,
      TGefosEsitoPartecipante.Create(Edizione.Partecipanti[Indice].Dati.Id, Esito), True);
    if Risposta.Riuscita then
    begin
      SalvaEsito(Edizione.Partecipanti[Indice], Esito);
      Edizione.Partecipanti[Indice].EsitoComunicato := Esito;
      FRiepilogo.Add(Format('OK - %s: esito aggiornato a "%s".', [Edizione.Partecipanti[Indice].Dati.Nominativo, GefosDescrizioneEsito(Esito)]));
    end
    else
    begin
      AnnotaErrore(Edizione.Partecipanti[Indice].Dati.Nominativo + ': aggiornamento dell''esito', Risposta);
      Result := False;
    end;
  end;
end;

{ Dialogo con l'operatore }

function TGefosCooperazioneApplicativa.MostraProblemi(const Problemi: TGefosProblemi; const Operazione: string): Boolean;
var
  Testo: string;
begin
  if Length(Problemi) = 0 then
    Exit(True);

  if GefosProblemiHannoErrori(Problemi) then
  begin
    Testo := Operazione + ': i dati non sono pronti per GEFOS. Correggerli in Gesty e riprovare.' + sLineBreak + sLineBreak +
      GefosProblemiTesto(Problemi);
    zExecuteMemoDialog(Testo, 'GEFOS - controlli prima dell''invio', nil, nil, True);
    Exit(False);
  end;

  Testo := Operazione + ': controlli superati, con questi avvisi.' + sLineBreak + sLineBreak + GefosProblemiTesto(Problemi);
  zExecuteMemoDialog(Testo, 'GEFOS - controlli prima dell''invio', nil, nil, True);
  Result := ConfirmYesNo('Proseguire con l''invio a GEFOS nonostante gli avvisi?');
end;

function TGefosCooperazioneApplicativa.AccettaDichiarazioni(const Operazione: string; IdDenominazione: Integer;
  const Descrizione: string): Boolean;
var
  Testo: string;
begin
  Testo := TestoDichiarazioni(Operazione, IdDenominazione);
  if Testo = '' then
    raise EGefosErrore.Create('Manca il testo delle dichiarazioni in GEFOS_DICHIARAZIONI: va inserito prima di comunicare con GEFOS.');

  // Le dichiarazioni valgono come dichiarazione sostitutiva (art. 76 DPR 445/2000):
  // due gesti espliciti, leggere il testo e confermare, e mai un'accettazione automatica
  Testo := Descrizione + sLineBreak + sLineBreak + Testo;
  if not zExecuteMemoDialog(Testo, 'GEFOS - dichiarazioni da accettare', nil, nil, True) then
    Exit(False);

  Result := ConfirmYesNo(Format('%s, confermi di accettare le dichiarazioni appena lette a nome dell''ente?' + sLineBreak + sLineBreak +
    'Valgono come dichiarazione sostitutiva (art. 76 DPR 445/2000). L''accettazione viene registrata con data, ora e utente.',
    [Config.CurrentUserDisplayName]));
end;

procedure TGefosCooperazioneApplicativa.MostraRiepilogo(const Titolo: string);
var
  Testo: string;
begin
  if FRiepilogo.Count = 0 then
    Exit;
  Testo := FRiepilogo.Text;
  zExecuteMemoDialog(Testo, Titolo, nil, nil, True);
end;

{ Operazioni pubbliche }

function TGefosCooperazioneApplicativa.AggiornaTipologie(IdEnte: Int64): Boolean;
var
  Client: TGefosClient;
  Risposta: TGefosRisposta;
  Tipologie: TArray<TGefosTipologiaCorso>;
  Tipologia: TGefosTipologiaCorso;
  Query, Disattiva: TFDQuery;
  Identificativi: string;
begin
  Result := False;
  FRiepilogo.Clear;
  CaricaConfigurazione(IdEnte);
  ImpostaContesto(0, 0, 0, 0, 0);

  StartWait('Lettura delle tipologie di corso da GEFOS...');
  try
    Client := NuovoClient;
    try
      Risposta := Client.TipologieCorso(Tipologie);
    finally
      Client.Free;
    end;
  finally
    StopWait;
  end;

  if not Risposta.Riuscita then
  begin
    AnnotaErrore('Lettura delle tipologie di corso', Risposta);
    MostraRiepilogo('GEFOS - tipologie di corso');
    Exit;
  end;

  // Le colonne TIPOLOGIA_CORSO e LIVELLO_RISCHIO sono la proposta dell'operatore:
  // UPDATE OR INSERT non le tocca
  Query := NuovaQuery(
    'UPDATE OR INSERT INTO GEFOS_TIPOLOGIE_CORSO (ID_TIPOLOGIA_CORSO_GEFOS, DESCRIZIONE, ID_DENOMINAZIONE, DESCRIZIONE_DENOMINAZIONE, ' +
    '    MONTE_ORE, METODI_SVOLGIMENTO, ATTIVA, DATA_ORA_AGGIORNAMENTO) ' +
    'VALUES (:ID_TIPOLOGIA_CORSO_GEFOS, :DESCRIZIONE, :ID_DENOMINAZIONE, :DESCRIZIONE_DENOMINAZIONE, ' +
    '    :MONTE_ORE, :METODI_SVOLGIMENTO, TRUE, CURRENT_TIMESTAMP) ' +
    'MATCHING (ID_TIPOLOGIA_CORSO_GEFOS)');
  Disattiva := nil;
  try
    Identificativi := '';
    FTransazione.StartTransaction;
    try
      for Tipologia in Tipologie do
      begin
        Query.ParamByName('ID_TIPOLOGIA_CORSO_GEFOS').AsLargeInt := Tipologia.Id;
        Query.ParamByName('DESCRIZIONE').AsWideString := Tipologia.Descrizione;
        Query.ParamByName('ID_DENOMINAZIONE').AsInteger := Tipologia.IdDenominazione;
        ImpostaTesto(Query.ParamByName('DESCRIZIONE_DENOMINAZIONE'), Tipologia.DescrizioneDenominazione);
        if Tipologia.HaMonteOre then
          Query.ParamByName('MONTE_ORE').AsInteger := Tipologia.MonteOre
        else
        begin
          Query.ParamByName('MONTE_ORE').DataType := ftInteger;
          Query.ParamByName('MONTE_ORE').Clear;
        end;
        Query.ParamByName('METODI_SVOLGIMENTO').AsWideString := Tipologia.MetodiSvolgimentoTesto;
        Query.ExecSQL;

        if Identificativi <> '' then
          Identificativi := Identificativi + ', ';
        Identificativi := Identificativi + IntToStr(Tipologia.Id);
      end;

      // Una risposta vuota non spegne tutto: e' piu' probabile un problema di GEFOS
      // che la revoca di tutte le tipologie dell'ente
      if Identificativi <> '' then
      begin
        Disattiva := NuovaQuery(
          'UPDATE GEFOS_TIPOLOGIE_CORSO ' +
          'SET ' +
          '    GEFOS_TIPOLOGIE_CORSO.ATTIVA = FALSE, ' +
          '    GEFOS_TIPOLOGIE_CORSO.DATA_ORA_AGGIORNAMENTO = CURRENT_TIMESTAMP ' +
          'WHERE ' +
          '    GEFOS_TIPOLOGIE_CORSO.ATTIVA = TRUE AND ' +
          '    GEFOS_TIPOLOGIE_CORSO.ID_TIPOLOGIA_CORSO_GEFOS NOT IN (' + Identificativi + ')');
        Disattiva.ExecSQL;
      end;
      FTransazione.Commit;
    except
      if FTransazione.Active then
        FTransazione.Rollback;
      raise;
    end;
  finally
    Disattiva.Free;
    Query.Free;
  end;

  FRiepilogo.Add(Format('OK - %d tipologie di corso lette da GEFOS e salvate.', [Length(Tipologie)]));
  if Length(Tipologie) = 0 then
    FRiepilogo.Add('Attenzione: GEFOS non ha restituito nessuna tipologia per l''ente; quelle gia'' salvate restano attive.');
  MostraRiepilogo('GEFOS - tipologie di corso');
  Result := True;
end;

function TGefosCooperazioneApplicativa.PreparaCorsoGefos(IdProgettoAsr: Int64): Boolean;
var
  Query: TFDQuery;
  IdTipologia: Int64;
begin
  Result := False;

  Query := NuovaQuery(
    'SELECT ' +
    '    PROGETTI_ASR_SICUREZZA_GEFOS.ID_PROGETTO_ASR ' +
    'FROM ' +
    '    PROGETTI_ASR_SICUREZZA_GEFOS ' +
    'WHERE ' +
    '    PROGETTI_ASR_SICUREZZA_GEFOS.ID_PROGETTO_ASR = :ID_PROGETTO_ASR');
  try
    Query.ParamByName('ID_PROGETTO_ASR').AsLargeInt := IdProgettoAsr;
    Query.Open;
    if not Query.IsEmpty then
      Exit(True);
  finally
    Query.Free;
  end;

  // La tipologia si propone solo se una sola tipologia attiva corrisponde a tipologia
  // e livello di rischio del corso: altrimenti la sceglie l'operatore (paragrafo 10.1)
  Query := NuovaQuery(
    'SELECT ' +
    '    GEFOS_TIPOLOGIE_CORSO.ID_TIPOLOGIA_CORSO_GEFOS ' +
    'FROM ' +
    '    GEFOS_TIPOLOGIE_CORSO ' +
    '        INNER JOIN PROGETTI_ASR_SICUREZZA ON PROGETTI_ASR_SICUREZZA.TIPOLOGIA_CORSO = GEFOS_TIPOLOGIE_CORSO.TIPOLOGIA_CORSO ' +
    'WHERE ' +
    '    PROGETTI_ASR_SICUREZZA.ID_PROGETTO_ASR = :ID_PROGETTO_ASR AND ' +
    '    GEFOS_TIPOLOGIE_CORSO.ATTIVA = TRUE AND ' +
    '    (GEFOS_TIPOLOGIE_CORSO.LIVELLO_RISCHIO IS NULL OR ' +
    '     GEFOS_TIPOLOGIE_CORSO.LIVELLO_RISCHIO = PROGETTI_ASR_SICUREZZA.LIVELLO_RISCHIO)');
  try
    Query.ParamByName('ID_PROGETTO_ASR').AsLargeInt := IdProgettoAsr;
    Query.Open;
    if Query.RecordCount <> 1 then
    begin
      ConfirmOk(Format('Le tipologie GEFOS compatibili con il corso sono %d: la tipologia va scelta a mano nei dati GEFOS del corso.',
        [Query.RecordCount]), mtWarning);
      Exit;
    end;
    IdTipologia := InteroCampo(Query, 'ID_TIPOLOGIA_CORSO_GEFOS');
  finally
    Query.Free;
  end;

  // Sede proposta: la sede dell'ente del progetto, gia' con il civico separato.
  // Se il corso si tiene presso un'azienda va corretta a mano.
  Query := NuovaQuery(
    'INSERT INTO PROGETTI_ASR_SICUREZZA_GEFOS (ID_PROGETTO_ASR, ID_TIPOLOGIA_CORSO_GEFOS, SEDE_INDIRIZZO, SEDE_NUMERO_CIVICO, ' +
    '    SEDE_CAP, SEDE_CITTA, SEDE_PROVINCIA) ' +
    'SELECT ' +
    '    PROGETTI_ASR_SICUREZZA.ID_PROGETTO_ASR, ' +
    '    CAST(:ID_TIPOLOGIA_CORSO_GEFOS AS BIGINT), ' +
    '    ENTI_SEDI.INDIRIZZO, ' +
    '    ENTI_SEDI.NUMERO_CIVICO, ' +
    '    ENTI_SEDI.CAP, ' +
    '    ENTI_SEDI.CITTA, ' +
    '    ENTI_SEDI.PROVINCIA ' +
    'FROM ' +
    '    PROGETTI_ASR_SICUREZZA ' +
    '        INNER JOIN PROGETTI ON PROGETTI.ID_PROGETTO = PROGETTI_ASR_SICUREZZA.ID_PROGETTO ' +
    '        LEFT OUTER JOIN ENTI_SEDI ON ENTI_SEDI.ID_ENTE = PROGETTI.ID_ENTE AND ENTI_SEDI.ID_SEDE = PROGETTI.ID_SEDE ' +
    'WHERE ' +
    '    PROGETTI_ASR_SICUREZZA.ID_PROGETTO_ASR = :ID_PROGETTO_ASR');
  try
    Query.ParamByName('ID_TIPOLOGIA_CORSO_GEFOS').AsLargeInt := IdTipologia;
    Query.ParamByName('ID_PROGETTO_ASR').AsLargeInt := IdProgettoAsr;
    EseguiScrittura(Query);
  finally
    Query.Free;
  end;
  Result := True;
end;

function TGefosCooperazioneApplicativa.GeneraGiornate(IdProgettoAsr: Int64; OraInizioMattina, OraInizioPomeriggio: TTime;
  OreMattina: Integer): string;
var
  Query: TFDQuery;
  GiorniUsati, GiorniUtili, RigheOrario: Integer;
begin
  // La procedura e' selezionabile (SUSPEND) ma scrive in ORARIO: va aperta dentro una
  // transazione di scrittura e confermata
  Query := NuovaQuery(
    'SELECT ' +
    '    PROGETTI_ASR_SICUREZZA_GENERA_GIORNATE.GIORNI_USATI, ' +
    '    PROGETTI_ASR_SICUREZZA_GENERA_GIORNATE.GIORNI_UTILI, ' +
    '    PROGETTI_ASR_SICUREZZA_GENERA_GIORNATE.RIGHE_ORARIO ' +
    'FROM ' +
    '    PROGETTI_ASR_SICUREZZA_GENERA_GIORNATE(:ID_PROGETTO_ASR, :ORA_INIZIO_MATTINA, :ORA_INIZIO_POMERIGGIO, :ORE_MATTINA)');
  try
    Query.ParamByName('ID_PROGETTO_ASR').AsLargeInt := IdProgettoAsr;
    Query.ParamByName('ORA_INIZIO_MATTINA').AsTime := OraInizioMattina;
    Query.ParamByName('ORA_INIZIO_POMERIGGIO').AsTime := OraInizioPomeriggio;
    Query.ParamByName('ORE_MATTINA').AsInteger := OreMattina;
    FTransazione.StartTransaction;
    try
      Query.Open;
      GiorniUsati := Query.FieldByName('GIORNI_USATI').AsInteger;
      GiorniUtili := Query.FieldByName('GIORNI_UTILI').AsInteger;
      RigheOrario := Query.FieldByName('RIGHE_ORARIO').AsInteger;
      Query.Close;
      FTransazione.Commit;
    except
      if FTransazione.Active then
        FTransazione.Rollback;
      raise;
    end;
  finally
    Query.Free;
  end;

  Result := Format('Generate %d ore di lezione su %d giorni.', [RigheOrario, GiorniUsati]);
  if GiorniUsati < GiorniUtili then
    Result := Result + sLineBreak + sLineBreak +
      Format('Le ore del corso non bastano a coprire tutti i %d giorni feriali fra inizio e fine: ' +
        'l''ultimo giorno e'' rimasto senza lezioni, e GEFOS chiede una giornata anche l''ultimo giorno. ' +
        'Correggere le giornate o la data di fine del corso.', [GiorniUtili]);
end;

function TGefosCooperazioneApplicativa.ControllaCorso(IdProgettoAsr: Int64): string;
var
  Corso: TGefosCorsoAsr;
  Edizioni: TArray<TGefosEdizioneAsr>;
  Edizione: TGefosEdizioneAsr;
  Problemi: TGefosProblemi;
begin
  Corso := CaricaCorso(IdProgettoAsr);
  Edizioni := CostruisciEdizioni(Corso);
  Problemi := nil;
  for Edizione in Edizioni do
    if not Edizione.Avviata then
    begin
      AggiungiSenzaDoppioni(Problemi, TGefosValidatore.ControllaEdizione(Edizione.Edizione, Corso.Tipologia, Date,
        Edizione.Edizione.Id = 0));
      AggiungiSenzaDoppioni(Problemi, TGefosValidatore.ControllaPartecipanti(Corso.Metodo, Edizione.DatiPartecipanti, Date));
    end;
  if Length(Edizioni) = 0 then
    AggiungiSenzaDoppioni(Problemi, [TGefosProblema.Errore('EDIZIONE_SENZA_PARTECIPANTI', 'Partecipanti',
      'Il corso in e-learning non ha partecipanti: in GEFOS ogni partecipante ha la sua edizione.')]);
  if TestoDichiarazioni(OPERAZIONE_DICHIARAZIONI_AVVIO, Corso.Tipologia.IdDenominazione) = '' then
    AggiungiSenzaDoppioni(Problemi, [TGefosProblema.Errore('DICHIARAZIONI_NON_ACCETTATE', 'Dichiarazioni',
      'Manca il testo delle dichiarazioni di avvio in GEFOS_DICHIARAZIONI.')]);
  Result := GefosProblemiTesto(Problemi);
end;

function TGefosCooperazioneApplicativa.ComunicaAvvio(IdProgettoAsr: Int64): Boolean;
var
  Corso: TGefosCorsoAsr;
  Edizioni: TArray<TGefosEdizioneAsr>;
  Edizione: TGefosEdizioneAsr;
  Problemi: TGefosProblemi;
  Client: TGefosClient;
  Indice, DaAvviare, Avviate: Integer;
begin
  Result := False;
  FRiepilogo.Clear;

  Corso := CaricaCorso(IdProgettoAsr);
  CaricaConfigurazione(Corso.IdEnte);
  Edizioni := CostruisciEdizioni(Corso);

  DaAvviare := 0;
  Problemi := nil;
  for Edizione in Edizioni do
    if not Edizione.Avviata then
    begin
      Inc(DaAvviare);
      AggiungiSenzaDoppioni(Problemi, TGefosValidatore.ControllaEdizione(Edizione.Edizione, Corso.Tipologia, Date,
        Edizione.Edizione.Id = 0));
      AggiungiSenzaDoppioni(Problemi, TGefosValidatore.ControllaPartecipanti(Corso.Metodo, Edizione.DatiPartecipanti, Date));
    end;

  if Length(Edizioni) = 0 then
  begin
    ConfirmOk('Il corso in e-learning non ha partecipanti: in GEFOS ogni partecipante ha la sua edizione, non c''e'' niente da avviare.');
    Exit;
  end;
  if DaAvviare = 0 then
  begin
    ConfirmOk('L''avvio di tutte le edizioni del corso e'' gia'' stato comunicato a GEFOS.');
    Exit;
  end;
  if TestoDichiarazioni(OPERAZIONE_DICHIARAZIONI_AVVIO, Corso.Tipologia.IdDenominazione) = '' then
    AggiungiSenzaDoppioni(Problemi, [TGefosProblema.Errore('DICHIARAZIONI_NON_ACCETTATE', 'Dichiarazioni',
      'Manca il testo delle dichiarazioni di avvio in GEFOS_DICHIARAZIONI.')]);

  if not MostraProblemi(Problemi, 'Comunicazione dell''avvio') then
    Exit;

  if not AccettaDichiarazioni(OPERAZIONE_DICHIARAZIONI_AVVIO, Corso.Tipologia.IdDenominazione,
    Format('Comunicazione a GEFOS dell''avvio del corso %s (%d edizioni, ambiente %s).' + sLineBreak +
      'Dopo l''avvio metodo di svolgimento e date delle edizioni non si possono piu'' cambiare.',
      [Corso.Descrizione, DaAvviare, IfThen(FAmbienteTest, 'di collaudo', 'di produzione')])) then
    Exit;

  Avviate := 0;
  Client := NuovoClient;
  StartWait('Comunicazione dell''avvio a GEFOS...');
  try
    try
      if CreaCorsoSeManca(Client, Corso) then
        for Indice := 0 to High(Edizioni) do
        begin
          if Edizioni[Indice].Avviata then
            Continue;
          UpdateWait(Edizioni[Indice].Nome + '...');
          // Un partecipante non iscritto ferma l'avvio della sua edizione: l'operatore
          // corregge i dati e rilancia, e la sequenza riprende da li'
          if PreparaEdizioneRemota(Client, Corso, Edizioni[Indice]) and
             IscriviPartecipantiMancanti(Client, Corso, Edizioni[Indice]) and
             AvviaEdizione(Client, Corso, Edizioni[Indice]) then
            Inc(Avviate);
        end;
    except
      on Errore: Exception do
        FRiepilogo.Add('Sequenza interrotta: ' + Errore.Message);
    end;
  finally
    StopWait;
    Client.Free;
  end;

  FRiepilogo.Insert(0, Format('Edizioni avviate: %d su %d.', [Avviate, DaAvviare]));
  FRiepilogo.Insert(1, '');
  MostraRiepilogo('GEFOS - comunicazione dell''avvio');
  Result := Avviate = DaAvviare;
end;

function TGefosCooperazioneApplicativa.ComunicaEsiti(IdProgettoAsr: Int64): Boolean;
var
  Corso: TGefosCorsoAsr;
  Edizioni: TArray<TGefosEdizioneAsr>;
  Client: TGefosClient;
  Indice, DaComunicare, Riuscite: Integer;
begin
  Result := False;
  FRiepilogo.Clear;

  Corso := CaricaCorso(IdProgettoAsr);
  CaricaConfigurazione(Corso.IdEnte);
  Edizioni := CostruisciEdizioni(Corso);

  DaComunicare := 0;
  for Indice := 0 to High(Edizioni) do
    if Edizioni[Indice].Avviata and not Edizioni[Indice].Conclusa then
      Inc(DaComunicare);
  if DaComunicare = 0 then
  begin
    ConfirmOk('Nessuna edizione del corso e'' avviata e non ancora conclusa: gli esiti si comunicano dopo l''avvio e prima della conclusione.');
    Exit;
  end;

  if not ConfirmYesNo(Format('Comunicare a GEFOS gli esiti dei partecipanti del corso %s?' + sLineBreak + sLineBreak +
    'L''esito si ricava da "Ammesso alla verifica" e "Idoneo": chi non e'' stato ammesso risulta "Non ammesso".',
    [Corso.Descrizione])) then
    Exit;

  Riuscite := 0;
  Client := NuovoClient;
  StartWait('Comunicazione degli esiti a GEFOS...');
  try
    try
      for Indice := 0 to High(Edizioni) do
      begin
        if not Edizioni[Indice].Avviata or Edizioni[Indice].Conclusa then
          Continue;
        UpdateWait(Edizioni[Indice].Nome + '...');
        // I partecipanti aggiunti in Gesty dopo l'avvio si iscrivono prima degli esiti
        if IscriviPartecipantiMancanti(Client, Corso, Edizioni[Indice]) and
           ComunicaEsitiEdizione(Client, Corso, Edizioni[Indice]) then
          Inc(Riuscite);
      end;
    except
      on Errore: Exception do
        FRiepilogo.Add('Sequenza interrotta: ' + Errore.Message);
    end;
  finally
    StopWait;
    Client.Free;
  end;

  FRiepilogo.Insert(0, Format('Edizioni con gli esiti completi in GEFOS: %d su %d.', [Riuscite, DaComunicare]));
  FRiepilogo.Insert(1, '');
  MostraRiepilogo('GEFOS - esiti dei partecipanti');
  Result := Riuscite = DaComunicare;
end;

function TGefosCooperazioneApplicativa.ConfermaConclusione(IdProgettoAsr: Int64): Boolean;
var
  Corso: TGefosCorsoAsr;
  Edizioni: TArray<TGefosEdizioneAsr>;
  Verifica: TGefosEdizione;
  Problemi: TGefosProblemi;
  Client: TGefosClient;
  Risposta: TGefosRisposta;
  Indice, Partecipante, DaConcludere, Concluse: Integer;
begin
  Result := False;
  FRiepilogo.Clear;

  Corso := CaricaCorso(IdProgettoAsr);
  CaricaConfigurazione(Corso.IdEnte);
  Edizioni := CostruisciEdizioni(Corso);

  // Il validatore vuole i partecipanti con l'id GEFOS e l'esito gia' comunicato
  DaConcludere := 0;
  Problemi := nil;
  for Indice := 0 to High(Edizioni) do
  begin
    if Edizioni[Indice].Conclusa then
      Continue;
    if not Edizioni[Indice].Avviata then
    begin
      AggiungiSenzaDoppioni(Problemi, [TGefosProblema.Errore('', Edizioni[Indice].Nome,
        'L''avvio non e'' stato comunicato: va comunicato prima della conclusione.')]);
      Continue;
    end;
    Inc(DaConcludere);
    Verifica := Edizioni[Indice].Edizione;
    Verifica.Partecipanti := nil;
    for Partecipante := 0 to High(Edizioni[Indice].Partecipanti) do
    begin
      Verifica.Partecipanti := Verifica.Partecipanti + [Edizioni[Indice].Partecipanti[Partecipante].Dati];
      Verifica.Partecipanti[High(Verifica.Partecipanti)].Esito := Edizioni[Indice].Partecipanti[Partecipante].EsitoComunicato;
    end;
    AggiungiSenzaDoppioni(Problemi, TGefosValidatore.ControllaConclusione(Verifica, True,
      TestoDichiarazioni(OPERAZIONE_DICHIARAZIONI_CONCLUSIONE, Corso.Tipologia.IdDenominazione) <> '', Date));
  end;

  if (DaConcludere = 0) and not GefosProblemiHannoErrori(Problemi) then
  begin
    ConfirmOk('La conclusione di tutte le edizioni del corso e'' gia'' stata confermata a GEFOS.');
    Exit;
  end;
  if not MostraProblemi(Problemi, 'Conferma della conclusione') then
    Exit;

  if not AccettaDichiarazioni(OPERAZIONE_DICHIARAZIONI_CONCLUSIONE, Corso.Tipologia.IdDenominazione,
    Format('Conferma a GEFOS della conclusione del corso %s (%d edizioni, ambiente %s).' + sLineBreak +
      'La conferma e'' irreversibile: dopo, l''edizione in GEFOS non si puo'' piu'' modificare.',
      [Corso.Descrizione, DaConcludere, IfThen(FAmbienteTest, 'di collaudo', 'di produzione')])) then
    Exit;

  Concluse := 0;
  Client := NuovoClient;
  StartWait('Conferma della conclusione a GEFOS...');
  try
    try
      for Indice := 0 to High(Edizioni) do
      begin
        if not Edizioni[Indice].Avviata or Edizioni[Indice].Conclusa then
          Continue;
        UpdateWait(Edizioni[Indice].Nome + '...');
        ImpostaContesto(Corso.IdProgettoAsr, Edizioni[Indice].IdPartecipanteProgettoAsr, Corso.IdCorsoGefos,
          Edizioni[Indice].Edizione.Id, 0);
        Risposta := Client.ConfermaConclusione(Corso.IdCorsoGefos, Edizioni[Indice].Edizione.Id, True);
        if Risposta.Riuscita then
          FRiepilogo.Add('OK - ' + Edizioni[Indice].Nome + ': conclusione confermata.')
        else if SameText(Risposta.Errore.Codice, 'EDIZIONE_GIA_CONFERMATA') then
          FRiepilogo.Add('OK - ' + Edizioni[Indice].Nome + ': GEFOS la risultava gia'' conclusa, Gesty e'' stato allineato.')
        else
        begin
          AnnotaErrore(Edizioni[Indice].Nome + ': conferma della conclusione', Risposta);
          Continue;
        end;
        SalvaConclusione(Edizioni[Indice]);
        Edizioni[Indice].Conclusa := True;
        Inc(Concluse);
      end;
    except
      on Errore: Exception do
        FRiepilogo.Add('Sequenza interrotta: ' + Errore.Message);
    end;
  finally
    StopWait;
    Client.Free;
  end;

  FRiepilogo.Insert(0, Format('Edizioni concluse: %d su %d.', [Concluse, DaConcludere]));
  FRiepilogo.Insert(1, '');
  MostraRiepilogo('GEFOS - conferma della conclusione');
  Result := Concluse = DaConcludere;
end;

end.
