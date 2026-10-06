unit SIUF.CooperazioneApplicativa.Types;

interface

uses
  System.SysUtils,
  System.Generics.Collections;

const
  // Mantis #93 - 2026-09-08: tipologie di lezione ammesse dal canale Extra
  // Obbligo, paragrafo 1.5 del documento di specifiche tecniche EOB. Sono
  // solo queste quattro: qualunque altro valore fa fallire la ricerca della
  // lezione, perché la tipologia è uno dei campi di confronto del paragrafo 1.3.
  TIPOLOGIA_SIUF_AULA = 1;
  TIPOLOGIA_SIUF_STAGE = 2;
  TIPOLOGIA_SIUF_ESERCITAZIONE = 3;
  TIPOLOGIA_SIUF_FAD = 4;

  /// Segnaposto per un codice Gesty che non ha una corrispondenza decisa fra
  /// le quattro tipologie EOB. Non è un valore inviabile: il validatore blocca
  /// l'invio e nomina la riga, invece di lasciar passare una tipologia inventata.
  TIPOLOGIA_SIUF_NON_MAPPATA = 0;

  // Mantis #100 - 2026-09-11: intervallo dei codici ammessi dal canale
  // ordinamentale (IeFP/IFTS/ITS/apprendistato), paragrafo 1.5 delle specifiche
  // tecniche IeFP e art. 15 c.3 del decreto GRS n. 10848. Coincidono uno a uno
  // col dominio Gesty TIPOLOGIA_FORMAZIONE, quindi qui il codice si trasmette
  // com'è: non serve la compressione a quattro valori richiesta dall'Extra
  // Obbligo. Fanno eccezione i codici 6 (Project Work generico) e 9 (FAD
  // generica), presenti nel dominio Gesty ma assenti dalla lista dei valori
  // accettati dal servizio: li ferma TipologiaOrdinamentaleToId.
  TIPOLOGIA_ORD_MIN = 1;
  TIPOLOGIA_ORD_MAX = 34;

  // Motivo di chiusura: allineato al dominio GRS_EXPORT_MOTIVO_CHIUSURA e alla
  // slide 16 della presentazione IeFP. Serve a escludere quei giorni dal
  // calcolo del "fuori limite" sui termini di trasmissione (art. 6 del decreto).
  MOTIVO_CHIUSURA_FESTA_PATRONALE = '1';
  MOTIVO_CHIUSURA_PONTE = '2';
  MOTIVO_CHIUSURA_FORZA_MAGGIORE = '3';

type
  /// Mantis #100 - 2026-09-11: canale formativo di destinazione.
  ///
  /// NON è un parametro della chiamata: endpoint, credenziali e header sono
  /// identici per i due canali ed è SIUF a smistare in base a idSezione
  /// (catalogo errori: "la sezione X non risulta appartenere a nessun canale
  /// formativo"). Serve però a Gesty per tre decisioni che il tracciato impone:
  ///
  ///   1. come codificare la tipologia di lezione: le due tabelle collidono sui
  ///      numeri (4 = FAD sull'Extra Obbligo, 4 = Formazione interna
  ///      sull'ordinamentale), quindi lo stesso codice interno va tradotto
  ///      in modo diverso;
  ///   2. quali campi mettere nel JSON: sede e i tre campi di chiusura esistono
  ///      solo sul tracciato ordinamentale;
  ///   3. come trattare le ore di assenza giustificata: l'Extra Obbligo le vuole
  ///      obbligatoriamente a "0", l'ordinamentale le accetta reali.
  ///
  /// Resta quindi una scelta interna, invisibile all'operatore: il comando di
  /// invio è uno solo.
  TSiufCanale = (
    /// Percorsi extra-ordinamentali e politiche del lavoro (canale "EOB")
    scExtraObbligo,
    /// Percorsi ordinamentali: IeFP, IFTS, ITS, apprendistato art. 43/45
    scOrdinamentale);

  TSiufCanaleHelper = record helper for TSiufCanale
  public
    function ToString: string;
    /// True se il canale prevede i campi aggiuntivi del tracciato
    /// (sede, motivoChiusura, dataInizioChiusura, dataFineChiusura).
    function HaCampiEstesi: Boolean;
  end;

  /// Risolve il canale a partire dall'ID del progetto. Lo fornisce il chiamante,
  /// che ha accesso al database: così il builder resta una trasformazione pura
  /// sul dataset, senza dipendere dal livello dati.
  TSiufCanaleResolver = reference to function(AIdProgetto: Integer): TSiufCanale;

  /// Mantis #186 - 2026-09-25: risolve se il progetto è ITS/IFTS
  /// (PROGETTI.ITS_IFTS), indipendente dal canale ORD/EOB restituito da
  /// TSiufCanaleResolver: un progetto ordinamentale può essere IeFP o
  /// Apprendistato non-IFTS oppure ITS/IFTS, che per SIUF hanno regole proprie.
  /// Mantis #186 - 2026-09-28: il formato delle ore non dipende più da questo
  /// flag, perché AT SIUF lo ha dichiarato unico per tutti i corsi.
  /// Mantis #186 - 2026-09-30: AT SIUF ha confermato che ITS e IFTS inviano le
  /// ore giustificate come gli altri corsi ordinamentali: oggi il flag non
  /// cambia nulla nel tracciato.
  TSiufItsIftsResolver = reference to function(AIdProgetto: Integer): Boolean;

  /// Singola presenza studente (elemento di listaStudenti[])
  TSiufPresenza = class
  private
    FCodiceFiscale: string;
    FCodiceFiscaleDocente: string;
    FCognome: string;
    FNome: string;
    FMateria: string;
    FContenutiMateria: string;
    FData: string; // DD/MM/YYYY
    FOraInizio: string; // HH:MM
    FOraFine: string; // HH:MM
    FOreAssenza: string; // intero ("1") o ore.minuti ("0.30"), mai "1.00"
    FOreAssenzaGiustificata: string; // come FOreAssenza; sempre "0" sull'Extra Obbligo
    FOrePresenza: string; // intero ("1") o ore.minuti ("0.30"), mai "1.00"
    FTipologia: Integer; // EOB: 1=Aula 2=Stage 3=Esercitazione 4=FAD - ordinamentale: codice del dominio Gesty
    FCodiceFiscaleCoDocente: string;
    // --- Campi presenti solo sul tracciato ordinamentale (IeFP/IFTS/ITS) ---
    FSede: string; // sede fisica, oppure piattaforma software se FAD
    FMotivoChiusura: string; // '1' | '2' | '3' | '' (vedi MOTIVO_CHIUSURA_*)
    FDataInizioChiusura: string; // YYYY-MM-DD
    FDataFineChiusura: string; // YYYY-MM-DD
    // --- Campi interni per il chunking (non serializzati nel JSON) ---
    FDataLezione: TDate; // copia tipizzata di FData, per confronto rapido
    FIdProgetto: Integer; // ID_PROGETTO dal dataset
    FSiufIdSezione: Integer; // SIUF_ID_SEZIONE dal dataset (chiave chunk)
    FTipologiaGesty: string; // codice interno di partenza, per i messaggi d'errore
    FCanale: TSiufCanale; // canale del progetto, risolto in fase di caricamento
    FItsIfts: Boolean; // Mantis #186 - 2026-09-25: progetto ITS/IFTS, risolto in fase di caricamento
  public
    constructor Create;
    /// Durata della lezione in minuti, da oraInizio/oraFine ("HH:MM")
    function DurataLezioneMinuti: Integer;
    /// orePresenza in minuti (formato "H.MM" ore.minuti)
    function OrePresenzaMinuti: Integer;
    /// oreAssenza in minuti (formato "H.MM" ore.minuti)
    function OreAssenzaMinuti: Integer;
    /// oreAssenzaGiustificata in minuti (formato "H.MM" ore.minuti)
    function OreAssenzaGiustificataMinuti: Integer;

    property CodiceFiscale: string read FCodiceFiscale write FCodiceFiscale;
    property CodiceFiscaleDocente: string read FCodiceFiscaleDocente write FCodiceFiscaleDocente;
    property Cognome: string read FCognome write FCognome;
    property Nome: string read FNome write FNome;
    property Materia: string read FMateria write FMateria;
    property ContenutiMateria: string read FContenutiMateria write FContenutiMateria;
    property Data: string read FData write FData;
    property OraInizio: string read FOraInizio write FOraInizio;
    property OraFine: string read FOraFine write FOraFine;
    property OreAssenza: string read FOreAssenza write FOreAssenza;
    property OreAssenzaGiustificata: string read FOreAssenzaGiustificata write FOreAssenzaGiustificata;
    property OrePresenza: string read FOrePresenza write FOrePresenza;
    property Tipologia: Integer read FTipologia write FTipologia;
    property CodiceFiscaleCoDocente: string read FCodiceFiscaleCoDocente write FCodiceFiscaleCoDocente;
    // Campi del solo tracciato ordinamentale: sul canale Extra Obbligo restano
    // valorizzati ma non vengono serializzati (vedi TSiufCanale.HaCampiEstesi).
    property Sede: string read FSede write FSede;
    property MotivoChiusura: string read FMotivoChiusura write FMotivoChiusura;
    property DataInizioChiusura: string read FDataInizioChiusura write FDataInizioChiusura;
    property DataFineChiusura: string read FDataFineChiusura write FDataFineChiusura;
    // Campi di supporto al chunking
    property DataLezione: TDate read FDataLezione write FDataLezione;
    property IdProgetto: Integer read FIdProgetto write FIdProgetto;
    property SiufIdSezione: Integer read FSiufIdSezione write FSiufIdSezione;
    // Mantis #93 - 2026-09-08: codice del dominio TIPOLOGIA_FORMAZIONE da cui
    // deriva Tipologia. Non entra nel JSON: serve solo perché il messaggio di
    // errore possa dire quale tipologia di Gesty non ha una corrispondenza.
    property TipologiaGesty: string read FTipologiaGesty write FTipologiaGesty;
    /// Canale del progetto a cui appartiene la presenza. Non entra nel JSON:
    /// serve a portare l'informazione dal caricamento fino al payload.
    property Canale: TSiufCanale read FCanale write FCanale;
    /// Mantis #186 - 2026-09-25: True se il progetto è ITS/IFTS. Non entra nel
    /// JSON. Dal 2026-09-28 non decide più il formato delle ore (unico per
    /// tutti i corsi, vedi TSiufPayloadBuilder.MinutiToSiuf). Dal 2026-09-30
    /// nemmeno il trattamento delle ore giustificate, identico agli altri
    /// corsi ordinamentali.
    property ItsIfts: Boolean read FItsIfts write FItsIfts;
  end;

  /// Payload completo (header + lista presenze)
  TSiufPayload = class
  private
    FCodiceFiscaleUser: string;
    FDataInizio: string; // YYYY-MM-DD
    FDataFine: string; // YYYY-MM-DD
    FIdSezione: Integer;
    FListaStudenti: TObjectList<TSiufPresenza>;
    // Metadati di contesto (non fanno parte del JSON SIUF)
    FIdProgetto: Integer;
    // Mantis #100 - 2026-09-11: canale di destinazione. Non finisce nel JSON
    // (SIUF smista da idSezione), ma decide forma del tracciato e codifica
    // della tipologia. Tutte le presenze di un payload appartengono allo
    // stesso progetto/sezione, quindi allo stesso canale.
    FCanale: TSiufCanale;
  public
    constructor Create;
    destructor Destroy; override;
    /// Crea, aggiunge alla lista e restituisce una nuova presenza (owned)
    function AddPresenza: TSiufPresenza;
    /// Numero di codici fiscali distinti presenti (per NUMERO_STUDENTI nella SP)
    function CalcolaNumeroStudenti: Integer;

    property CodiceFiscaleUser: string read FCodiceFiscaleUser write FCodiceFiscaleUser;
    property DataInizio: string read FDataInizio write FDataInizio;
    property DataFine: string read FDataFine write FDataFine;
    property IdSezione: Integer read FIdSezione write FIdSezione;
    property ListaStudenti: TObjectList<TSiufPresenza> read FListaStudenti;
    // Metadati di contesto
    property IdProgetto: Integer read FIdProgetto write FIdProgetto;
    property Canale: TSiufCanale read FCanale write FCanale;
    // Conteggio CF distinti, calcolato on-demand (niente cache stale)
    property NumeroStudenti: Integer read CalcolaNumeroStudenti;
  end;

  /// Classificazione best-effort dell'errore server (il messaggio leggibile
  /// resta la fonte di verità; questa enum serve solo per log/routing).
  TSiufErroreTipo = (setNessuno, setUserNonEsiste, setIntervalloDateTroppoAmpio, setSezioneInesistente, setStudenteNonCensito, setStudenteNonInLezione, setDocenteNonDelCorso, setDocenteNonInLezione, setLezioneNonTrovata, setDataFuoriIntervallo,
    setMinutiNonCorrispondenti, setAssenzaGiustificataNonZero, setValidationError, setErroreTrasporto, setAltro);

  TSiufErroreTipoHelper = record helper for TSiufErroreTipo
  public
    function ToString: string;
  end;

  TSiufDettaglioErrore = record
    TipoErrore: TSiufErroreTipo;
    Studente: string;
    Sezione: string;
    DocenteCoDocente: string;
    CorsoLezione: string;
    Data: string;
    MessaggioOriginale: string;
  end;

  /// Esito della chiamata (risposta del server)
  TSiufEsito = record
    EsitoCaricamento: Boolean;
    Messaggio: string;
    Tipo: TSiufErroreTipo;
    HttpStatus: Integer;
    RawResponse: string;
    DettaglioErrore: TSiufDettaglioErrore;
  end;

  /// Credenziali/endpoint per la cooperazione applicativa SIUF EOB
  TSiufCoopConfig = record
    Url: string; // es. http://51.144.72.49:9080/geco/presenzecall/api/importaPresenze
    IdentificativoEnte: string; // header IDENTIFICATIVO_ENTE
    Username: string; // header USERNAME
    Code: string; // header CODE (password)
    AmbienteTest: Boolean;
  end;

  // -----------------------------------------------------------------------
  // Contesto di esecuzione (parametri passati dall'esterno)
  // -----------------------------------------------------------------------
  TSiufExportContext = record
    // Credenziali / endpoint SIUF (lette da SIUF_COOPERAZIONE_APPLICATIVA_CONFIG)
    ClientConfig: TSiufCoopConfig;
    // CF dell'utente che lancia l'operazione
    CodiceFiscaleUser: string;
    // Nominativo dell'utente che lancia l'operazione
    NominativoUser: string;
    // USER_ID dell'utente (per la SP di log)
    UserId: Integer;
    // ID_ENTE corrente
    IdEnte: Integer;
    // ENTE corrente
    Ente: string;
    // Directory temporanea per i dump (deve esistere o essere creabile)
    TempDir: string;
  end;

  // -----------------------------------------------------------------------
  // Esito per singolo chunk
  // -----------------------------------------------------------------------
  TSiufExportEsitoDettaglio = record
    IdProgetto: Integer;
    IdSezione: Integer;
    DataInizio: string;
    DataFine: string;
    NumeroStudenti: Integer;
    Esito: TSiufEsito;
    IdInvio: Integer; // ID_SIUF_COOPERAZIONE_APPLICATIVA_INVIO
    FilePayload: string; // percorso finale del file payload (dopo lo spostamento)
    FileResponse: string; // percorso finale del file response
    ErroreLocale: string; // eccezione locale (vuoto se ok)
  end;

  // -----------------------------------------------------------------------
  // Esito aggregato dell'intera esportazione
  // -----------------------------------------------------------------------
  TSiufExportEsito = record
    TotaleChunk: Integer;
    ChunkOK: Integer;
    ChunkKO: Integer;
    Dettaglio: TArray<TSiufExportEsitoDettaglio>;
  end;

implementation

uses
  System.Generics.Defaults;

{ ---- utilità interne ---- }

// "HH:MM" -> minuti totali
function HHMMToMin(const S: string): Integer;
var
  P: Integer;
begin
  P := Pos(':', S);
  if P = 0 then
    Exit(0);
  Result := StrToIntDef(Copy(S, 1, P - 1), 0) * 60 + StrToIntDef(Copy(S, P + 1, MaxInt), 0);
end;

// "H.MM" (ore.minuti, NON decimale) -> minuti totali. "" -> 0
function OreToMin(const S: string): Integer;
var
  P: Integer;
  T: string;
begin
  T := Trim(S);
  T := StringReplace(T, ',', '.', [rfReplaceAll]);
  if T = '' then
    Exit(0);
  P := Pos('.', T);
  if P = 0 then
    Exit(StrToIntDef(T, 0) * 60); // solo ore intere, es. "1" o "2"
  Result := StrToIntDef(Copy(T, 1, P - 1), 0) * 60 + StrToIntDef(Copy(T, P + 1, MaxInt), 0);
end;

{ TSiufCanaleHelper }

function TSiufCanaleHelper.ToString: string;
begin
  case Self of
    scOrdinamentale:
      Result := 'Ordinamentale (IeFP/IFTS/ITS)';
  else
    Result := 'Extra Obbligo';
  end;
end;

function TSiufCanaleHelper.HaCampiEstesi: Boolean;
begin
  // sede, motivoChiusura, dataInizioChiusura e dataFineChiusura compaiono solo
  // nel tracciato del canale ordinamentale (paragrafo 1.4 delle specifiche
  // IeFP). Sull'Extra Obbligo non vanno serializzati: il tracciato del
  // paragrafo 1.4 EOB non li prevede e l'invio oggi funziona senza.
  Result := Self = scOrdinamentale;
end;

{ TSiufPresenza }

constructor TSiufPresenza.Create;
begin
  inherited Create;
  // Vincolo costante sull'Extra Obbligo. Sul canale ordinamentale il valore
  // reale viene sovrascritto da chi carica la presenza (vedi LoadPresenza).
  FOreAssenzaGiustificata := '0';
end;

function TSiufPresenza.DurataLezioneMinuti: Integer;
begin
  Result := HHMMToMin(FOraFine) - HHMMToMin(FOraInizio);
end;

function TSiufPresenza.OrePresenzaMinuti: Integer;
begin
  Result := OreToMin(FOrePresenza);
end;

function TSiufPresenza.OreAssenzaMinuti: Integer;
begin
  Result := OreToMin(FOreAssenza);
end;

function TSiufPresenza.OreAssenzaGiustificataMinuti: Integer;
begin
  Result := OreToMin(FOreAssenzaGiustificata);
end;

{ TSiufPayload }

constructor TSiufPayload.Create;
begin
  inherited Create;
  FListaStudenti := TObjectList<TSiufPresenza>.Create(True); // owns elements
  // Default prudente: il canale storico. Chi costruisce il payload lo
  // sovrascrive quando il progetto risulta ordinamentale.
  FCanale := scExtraObbligo;
end;

destructor TSiufPayload.Destroy;
begin
  FListaStudenti.Free;
  inherited Destroy;
end;

function TSiufPayload.AddPresenza: TSiufPresenza;
begin
  Result := TSiufPresenza.Create;
  FListaStudenti.Add(Result);
end;

function TSiufPayload.CalcolaNumeroStudenti: Integer;
var
  CFs: TDictionary<string, Byte>;
  P: TSiufPresenza;
  CF: string;
begin
  CFs := TDictionary<string, Byte>.Create;
  try
    for P in FListaStudenti do
    begin
      CF := Trim(P.CodiceFiscale);
      if CF <> '' then
        CFs.AddOrSetValue(CF, 0);
    end;
    Result := CFs.Count;
  finally
    CFs.Free;
  end;
end;

{ TSiufErroreTipoHelper }

function TSiufErroreTipoHelper.ToString: string;
begin
  Result := '';

  case Self of
    setNessuno:
      Result := '';
    setUserNonEsiste:
      Result := 'User Non Esiste';
    setIntervalloDateTroppoAmpio:
      Result := 'Intervallo Date';
    setSezioneInesistente:
      Result := 'Sezione Inesistente';
    setStudenteNonCensito:
      Result := 'Studente Non Censito';
    setStudenteNonInLezione:
      Result := 'Studente Non In Lezione';
    setDocenteNonDelCorso:
      Result := 'Docente Non Del Corso';
    setDocenteNonInLezione:
      Result := 'Docente Non In Lezione';
    setLezioneNonTrovata:
      Result := 'Lezione Non Trovata';
    setDataFuoriIntervallo:
      Result := 'Data Fuori Intervallo';
    setMinutiNonCorrispondenti:
      Result := 'Minuti Non Corrispondenti';
    setAssenzaGiustificataNonZero:
      Result := 'Assenza Giustificata';
    setValidationError:
      Result := 'Validation Error';
    setErroreTrasporto:
      Result := 'Errore Trasporto';
  else
    Result := 'Altro';
  end;
end;

end.
