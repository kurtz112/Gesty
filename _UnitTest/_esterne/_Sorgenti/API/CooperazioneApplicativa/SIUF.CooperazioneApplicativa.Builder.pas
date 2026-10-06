unit SIUF.CooperazioneApplicativa.Builder;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  Data.DB,
  SIUF.CooperazioneApplicativa.Types;

type
  /// Chiave di raggruppamento primaria: una entry per (ID_PROGETTO, SIUF_ID_SEZIONE).
  /// Usata internamente come chiave del dizionario di accumulo.
  TSiufGroupKey = record
    IdProgetto: Integer;
    IdSezione: Integer;
  end;

  /// Costruisce la lista di TSiufPayload da un dataset GRS_EXPORT già aperto.
  TSiufPayloadBuilder = class
  private type
    TSiufGroupDict = TObjectDictionary<TSiufGroupKey, TObjectList<TSiufPresenza>>;
  private
    /// "HH:MM" -> formato ore SIUF (vedi MinutiToSiuf)
    class function OreToSiuf(const AHHMM: string): string; static;
    /// "HH:MM" -> minuti totali (0 se vuoto/senza ':')
    class function HHMMToMinuti(const AHHMM: string): Integer; static;
    /// minuti totali -> ore SIUF: intero se i minuti sono zero ("1", "0"),
    /// altrimenti ore.minuti, NON decimale ("1.45", "0.30")
    class function MinutiToSiuf(AMinuti: Integer): string; static;
    class function FieldToHHMM(AField: TField): string; static;
    /// Normalizza i caratteri tipografici (apostrofi/virgolette curve, trattini
    /// lunghi) in equivalenti ASCII, per non far dipendere il match SIUF su
    /// Materia/ContenutiMateria da come il testo è stato digitato o incollato.
    class function NormalizzaTestoSiuf(const AText: string): string; static;
    /// Conversione della tipologia verso il canale Extra Obbligo (4 codici).
    class function TipologiaToId(const ATipologia: string): Integer; static;
    /// Mantis #100 - 2026-09-11: conversione verso il canale ordinamentale,
    /// dove il codice del dominio Gesty coincide con quello atteso da SIUF.
    class function TipologiaOrdinamentaleToId(const ATipologia: string): Integer; static;
    /// Applica la conversione corretta per il canale indicato.
    class function TipologiaPerCanale(const ATipologia: string; ACanale: TSiufCanale): Integer; static;
    class function FieldDate(AField: TField): TDate; static;
    /// Valore di un campo che può non esistere nel dataset ('' se assente o NULL).
    class function FieldOpt(ADataset: TDataSet; const AName: string): string; static;
    /// Data in formato YYYY-MM-DD da un campo che può non esistere ('' se assente o NULL).
    class function FieldOptDateISO(ADataset: TDataSet; const AName: string): string; static;
    class function IdSezione(const RifEventoFormativo: string): Integer;
    /// Legge una TSiufPresenza dal cursore corrente del dataset (non avanza).
    class function LoadPresenza(ADataset: TDataSet; ACanale: TSiufCanale; AItsIfts: Boolean): TSiufPresenza; static;

    /// Legge tutto il dataset e accumula le presenze nel dizionario raggruppate per progetto/sezione.
    class procedure LoadDataSet(ADataset: TDataSet; AGroups: TSiufGroupDict; const ACanaleResolver: TSiufCanaleResolver; const AItsIftsResolver: TSiufItsIftsResolver); static;

    // Mantis #93 - 2026-09-08: due presenze sono la stessa lezione SIUF se
    // riguardano lo stesso studente, giorno, sezione, docente, codocente,
    // materia, contenuti e tipologia, e sono adiacenti nel tempo.
    class function StessaLezioneSiuf(APrecedente, ASuccessiva: TSiufPresenza): Boolean; static;

    /// Mantis #93 - 2026-09-08: fonde le ore adiacenti della stessa lezione in
    /// un'unica presenza, perché SIUF cerca l'evento formativo per ora di
    /// inizio e ora di fine esatte, mentre Gesty registra le presenze ora per ora.
    class procedure AggregaOreContigue(APresenze: TObjectList<TSiufPresenza>); static;

    /// ogni gruppo nel dizionario ordina le presenze e le spezza in finestre temporali.
    class procedure ProcessGroups(AGroups: TSiufGroupDict; const ACodiceFiscaleUser: string; AOut: TObjectList<TSiufPayload>); static;

    /// Spezza una lista di presenze (già ordinata per DataLezione) in
    /// finestre da MAX_GIORNI_CHUNK giorni distinti e produce i payload.
    class procedure SplitInChunks(APres: TObjectList<TSiufPresenza>; AIdProgetto, AIdSezione: Integer; const ACodiceFiscaleUser: string; AOut: TObjectList<TSiufPayload>); static;
  public
    /// Legge tutto il dataset (fa First), raggruppa in memoria e produce
    /// la lista di chunk pronti per l'invio.
    /// Il chiamante è proprietario della lista restituita.
    ///
    /// Mantis #100 - 2026-09-11: ACanaleResolver dice, dato un ID progetto, se
    /// quel progetto viaggia sul canale ordinamentale o sull'Extra Obbligo.
    /// Non cambia destinatario né credenziali (è SIUF a smistare in base a
    /// idSezione): decide la codifica della tipologia, la forma del tracciato e
    /// il trattamento delle ore di assenza giustificata. Se non viene passato,
    /// il comportamento resta quello storico, cioè tutto Extra Obbligo.
    ///
    /// Mantis #186 - 2026-09-25: AItsIftsResolver dice, dato un ID progetto, se
    /// è ITS/IFTS (PROGETTI.ITS_IFTS). È indipendente da ACanaleResolver: un
    /// progetto ordinamentale può essere IeFP/Apprendistato non-IFTS oppure
    /// ITS/IFTS. Il valore arriva su ogni presenza (TSiufPresenza.ItsIfts).
    /// Mantis #186 - 2026-09-28: non decide più il formato delle ore, che
    /// AT SIUF ha dichiarato unico per tutti i corsi (vedi MinutiToSiuf).
    /// Mantis #186 - 2026-09-30: non decide nemmeno il trattamento delle ore
    /// giustificate, perché AT SIUF ha confermato che ITS e IFTS le inviano
    /// come gli altri corsi ordinamentali. Oggi non cambia nulla nel tracciato.
    class function BuildChunks(ADataset: TDataSet; const ACodiceFiscaleUser: string; const ACanaleResolver: TSiufCanaleResolver = nil; const AItsIftsResolver: TSiufItsIftsResolver = nil): TObjectList<TSiufPayload>; static;
  end;

implementation

uses
  System.DateUtils,
  System.Generics.Defaults;

const
  MAX_GIORNI_CHUNK = 3; // limite SIUF: max 3 giorni distinti per chiamata

  // ---------------------------------------------------------------------------
  // Comparatore per ordinare TSiufPresenza per DataLezione, poi OraInizio
  // ---------------------------------------------------------------------------
type
  TPresenzaDateComparer = class(TComparer<TSiufPresenza>)
    function Compare(const Left, Right: TSiufPresenza): Integer; override;
  end;

function TPresenzaDateComparer.Compare(const Left, Right: TSiufPresenza): Integer;
var
  DiffData: Integer;
begin
  DiffData := Trunc(Left.DataLezione) - Trunc(Right.DataLezione);
  if DiffData <> 0 then
    Exit(DiffData);
  Result := CompareStr(Left.OraInizio, Right.OraInizio);
end;

// ---------------------------------------------------------------------------
// Mantis #93 - 2026-09-08: ordinamento per studente, giorno e ora di inizio.
// Serve all'aggregazione delle ore contigue: mette in sequenza le ore che
// possono appartenere alla stessa lezione SIUF, così la fusione si fa con una
// sola passata sulla lista.
// ---------------------------------------------------------------------------
type
  TPresenzaAggregazioneComparer = class(TComparer<TSiufPresenza>)
    function Compare(const Left, Right: TSiufPresenza): Integer; override;
  end;

function TPresenzaAggregazioneComparer.Compare(const Left, Right: TSiufPresenza): Integer;
var
  DiffStudente: Integer;
  DiffData: Integer;
begin
  DiffStudente := CompareText(Trim(Left.CodiceFiscale), Trim(Right.CodiceFiscale));
  if DiffStudente <> 0 then
    Exit(DiffStudente);

  DiffData := Trunc(Left.DataLezione) - Trunc(Right.DataLezione);
  if DiffData <> 0 then
    Exit(DiffData);

  Result := CompareStr(Left.OraInizio, Right.OraInizio);
end;

// ---------------------------------------------------------------------------
// Equalità e hash per TSiufGroupKey (necessari per TDictionary)
// ---------------------------------------------------------------------------
type
  TGroupKeyEqualityComparer = class(TEqualityComparer<TSiufGroupKey>)
    function Equals(const Left, Right: TSiufGroupKey): Boolean; override;
    function GetHashCode(const Value: TSiufGroupKey): Integer; override;
  end;

function TGroupKeyEqualityComparer.Equals(const Left, Right: TSiufGroupKey): Boolean;
begin
  Result := (Left.IdProgetto = Right.IdProgetto) and (Left.IdSezione = Right.IdSezione);
end;

function TGroupKeyEqualityComparer.GetHashCode(const Value: TSiufGroupKey): Integer;
begin
  Result := Value.IdProgetto xor (Value.IdSezione shl 16);
end;

{ TSiufPayloadBuilder – helpers di campo }

class function TSiufPayloadBuilder.FieldDate(AField: TField): TDate;
begin
  if AField.IsNull then
    Result := 0
  else
    Result := Trunc(AField.AsDateTime);
end;

class function TSiufPayloadBuilder.FieldToHHMM(AField: TField): string;
var
  T: TDateTime;
begin
  if AField.IsNull then
    Exit('00:00');
  case AField.DataType of
    ftTime, ftDateTime, ftTimeStamp:
      begin
        T := AField.AsDateTime;
        Result := FormatDateTime('hh:nn', T);
      end;
  else
    Result := Trim(AField.AsString);
  end;
end;

// Mantis #100 - 2026-09-11: il paragrafo 1.3 delle specifiche tecniche EOB
// elenca Materia e ContenutiMateria fra i campi con cui SIUF identifica la
// lezione (confronto ignoreCase, ma NON insensibile ai caratteri tipografici).
// Un apostrofo curvo (’) nel calendario caricato a portale contro un apostrofo
// dritto (') nel payload inviato - o viceversa - fa fallire il confronto con
// "lezione non trovata" pur essendo il contenuto testuale identico (caso
// reale: sezione 170146, 09/09/2026, "Gestione d'azienda" / "Gestione d’azienda").
// Si normalizzano quindi ai rispettivi equivalenti ASCII i caratteri
// tipografici più comuni, così un'incoerenza di digitazione/copia-incolla fra
// Gesty e il calendario portale non blocca più l'invio delle presenze.
class function TSiufPayloadBuilder.NormalizzaTestoSiuf(const AText: string): string;
begin
  Result := AText;
  // apostrofi e virgolette singole tipografiche -> apostrofo dritto (')
  Result := StringReplace(Result, '’', '''', [rfReplaceAll]);
  Result := StringReplace(Result, '‘', '''', [rfReplaceAll]);
  Result := StringReplace(Result, '´', '''', [rfReplaceAll]);
  Result := StringReplace(Result, '`', '''', [rfReplaceAll]);
  // virgolette doppie tipografiche -> virgolette dritte (")
  Result := StringReplace(Result, '“', '"', [rfReplaceAll]);
  Result := StringReplace(Result, '”', '"', [rfReplaceAll]);
  // trattini lunghi -> trattino corto (-)
  Result := StringReplace(Result, '–', '-', [rfReplaceAll]);
  Result := StringReplace(Result, '—', '-', [rfReplaceAll]);
end;

// Mantis #100 - 2026-09-11: campi che esistono nel dataset solo quando la
// GRS_EXPORT li espone. Leggerli con FindField invece che con FieldByName
// evita di rompere l'invio Extra Obbligo su installazioni in cui la procedura
// non fosse ancora allineata.
class function TSiufPayloadBuilder.FieldOpt(ADataset: TDataSet; const AName: string): string;
var
  Fld: TField;
begin
  Fld := ADataset.FindField(AName);
  if (Fld = nil) or Fld.IsNull then
    Exit('');
  Result := Trim(Fld.AsString);
end;

class function TSiufPayloadBuilder.FieldOptDateISO(ADataset: TDataSet; const AName: string): string;
var
  Fld: TField;
begin
  Fld := ADataset.FindField(AName);
  if (Fld = nil) or Fld.IsNull then
    Exit('');
  Result := FormatDateTime('yyyy-mm-dd', Fld.AsDateTime);
end;

class function TSiufPayloadBuilder.IdSezione(const RifEventoFormativo: string): Integer;
begin

  if not TryStrToInt(RifEventoFormativo, Result) then
    raise Exception.Create('Id Sezione non valida: ' + RifEventoFormativo);
end;

class function TSiufPayloadBuilder.OreToSiuf(const AHHMM: string): string;
begin
  if Pos(':', AHHMM) = 0 then
    Exit(AHHMM);
  Result := MinutiToSiuf(HHMMToMinuti(AHHMM));
end;

class function TSiufPayloadBuilder.HHMMToMinuti(const AHHMM: string): Integer;
var
  P: Integer;
begin
  P := Pos(':', AHHMM);
  if P = 0 then
    Exit(0);
  Result := StrToIntDef(Copy(AHHMM, 1, P - 1), 0) * 60 + StrToIntDef(Copy(AHHMM, P + 1, MaxInt), 0);
end;

// Mantis #186 - 2026-09-28: formato unico per tutti i corsi e tutti i canali,
// confermato per iscritto da AT SIUF il 28/09/2026: SIUF non accetta lo zero
// dopo il punto ("1.00", "0.00") e vuole l'intero letterale ("1", "0"); i
// minuti restano in notazione ore.minuti ("1.45", "0.30"). È anche il formato
// di tutti gli esempi della documentazione ufficiale. OreToMin e le proprietà
// *Minuti di TSiufPresenza leggono già entrambe le forme.
class function TSiufPayloadBuilder.MinutiToSiuf(AMinuti: Integer): string;
begin
  if AMinuti < 0 then
    AMinuti := 0;
  if AMinuti mod 60 = 0 then
    Result := IntToStr(AMinuti div 60)
  else
    Result := IntToStr(AMinuti div 60) + '.' + Format('%.2d', [AMinuti mod 60]);
end;

// Mantis #93 - 2026-09-08: conversione dal codice interno di Gesty (dominio
// TIPOLOGIA_FORMAZIONE, 1..32, restituito da GET_TIPOLOGIA_FORMAZIONE) alle
// quattro tipologie previste dal canale Extra Obbligo, elencate al paragrafo
// 1.5 del documento di specifiche tecniche EOB. Non si può né confrontare il
// campo con le parole 'aula'/'stage'/… (non le contiene mai), né passare il
// numero così com'è (codici come 29 o 12 nel canale EOB non esistono).
//
// La tipologia è uno dei campi con cui SIUF cerca la lezione (paragrafo 1.3):
// un codice sbagliato la fa fallire esattamente come un orario sbagliato e,
// quando invece la ricerca va comunque a buon fine, il dato finisce storto sul
// registro regionale senza che nessuno se ne accorga. Per questo i codici
// privi di una corrispondenza decisa NON vengono ricondotti d'ufficio all'aula:
// restituiscono TIPOLOGIA_SIUF_NON_MAPPATA e il validatore blocca l'invio
// dicendo quale riga sistemare.
class function TSiufPayloadBuilder.TipologiaToId(const ATipologia: string): Integer;
var
  TipologiaGesty: string;
begin
  TipologiaGesty := UpperCase(Trim(ATipologia));

  // Mantis #126 - 2026-09-15: 'ES' è il nuovo valore dedicato del dominio
  // TIPOLOGIA_FORMAZIONE (Gesty/db/Domini/TIPOLOGIA_FORMAZIONE.dom), riservato
  // all'Esercitazione del canale EOB (CAPAC, corso ACAD). Nessun codice
  // numerico esistente rappresentava questa distinzione: verificato sul
  // database CAPAC che, per il corso ACAD, tutte le lezioni usavano lo stesso
  // codice (1 o 12) indipendentemente dal contenuto pratico o teorico.
  if TipologiaGesty = 'ES' then
  begin
    Result := TIPOLOGIA_SIUF_ESERCITAZIONE;
    Exit;
  end;

  case StrToIntDef(TipologiaGesty, 0) of
    1, // COLLETTIVA
    29: // AULA IN PRESENZA
      Result := TIPOLOGIA_SIUF_AULA;

    2, // TIROCINIO
    16, // ALTERNANZA SCUOLA LAVORO PROTETTA
    30, // TIROCINIO IN PRESENZA
    31: // TIROCINIO IN SMART WORKING
      Result := TIPOLOGIA_SIUF_STAGE;

    9, // FAD
    12, // FAD SINCRONA
    13, // FAD ASINCRONA
    18: // FAD ASINCRONA RECUPERO FAD SINCRONA
      Result := TIPOLOGIA_SIUF_FAD;
  else
    // Restano fuori, in attesa di una decisione condivisa con AT SIUF:
    // 5 formazione esterna (l'unico che compare davvero nei dati del canale
    // EOB), 3 evento, 4 formazione interna, 6/10/11/20 project work,
    // 7/8 formazione in assetto lavorativo, 14/32 sostegno, 17 formazione
    // individuale PPD, 19 moduli aggiuntivi di recupero, 21..27 interventi di
    // orientamento e PIP, più i due codici su cui il commento del dominio e
    // quello di GET_TIPOLOGIA_FORMAZIONE non concordano (15 smart working
    // oppure FAD a recupero, 28 aula in FAD asincrona).
    Result := TIPOLOGIA_SIUF_NON_MAPPATA;
  end;
end;

// Mantis #100 - 2026-09-11: sul canale ordinamentale non serve alcuna
// conversione. Il dominio Gesty TIPOLOGIA_FORMAZIONE è allineato uno a uno alla
// tabella del paragrafo 1.5 delle specifiche IeFP (1..27 più 32), che a sua
// volta coincide con l'art. 15 c.3 del decreto GRS n. 10848: il codice interno
// È il codice SIUF e si trasmette com'è.
//
// Vanno fermati solo tre casi:
//   - 'ES' (Mantis #126): è l'Esercitazione del canale Extra Obbligo, non
//     esiste nella tabella del canale ordinamentale, dove il 3 è "Evento";
//   - 6 (Project Work generico) e 9 (FAD generica): presenti nel dominio Gesty
//     ma NON nella lista dei valori accettati dal servizio (allegato "Vincoli
//     per compilazione Importa Registro Presenze"). Il 9 è già commentato come
//     inutilizzato nel dominio, il 6 no. Inviarli farebbe fallire la riga lato
//     server, quindi si blocca prima;
//   - i codici fuori 1..34, che non esistono in nessuna delle due tabelle.
class function TSiufPayloadBuilder.TipologiaOrdinamentaleToId(const ATipologia: string): Integer;
var
  TipologiaGesty: string;
  Codice: Integer;
begin
  TipologiaGesty := UpperCase(Trim(ATipologia));

  if TipologiaGesty = 'ES' then
    Exit(TIPOLOGIA_SIUF_NON_MAPPATA);

  Codice := StrToIntDef(TipologiaGesty, 0);

  if (Codice < TIPOLOGIA_ORD_MIN) or (Codice > TIPOLOGIA_ORD_MAX) then
    Exit(TIPOLOGIA_SIUF_NON_MAPPATA);

  if (Codice = 6) or (Codice = 9) then
    Exit(TIPOLOGIA_SIUF_NON_MAPPATA);

  Result := Codice;
end;

class function TSiufPayloadBuilder.TipologiaPerCanale(const ATipologia: string; ACanale: TSiufCanale): Integer;
begin
  case ACanale of
    scOrdinamentale:
      Result := TipologiaOrdinamentaleToId(ATipologia);
  else
    Result := TipologiaToId(ATipologia);
  end;
end;

{ TSiufPayloadBuilder – lettura singola riga }

class function TSiufPayloadBuilder.LoadPresenza(ADataset: TDataSet; ACanale: TSiufCanale; AItsIfts: Boolean): TSiufPresenza;
  function F(const AName: string): TField;
  begin
    Result := ADataset.FieldByName(AName);
  end;

var
  P: TSiufPresenza;
  RowData: TDate;
begin
  Result := nil;
  P := TSiufPresenza.Create;
  try
    RowData := FieldDate(F('DATA'));

    P.Canale := ACanale;
    P.ItsIfts := AItsIfts; // Mantis #186 - 2026-09-25
    P.CodiceFiscale := F('CODICE_FISCALE_STUDENTE').AsString;
    P.CodiceFiscaleDocente := F('CODICE_FISCALE_DOCENTE').AsString;
    P.Cognome := F('COGNOME').AsString;
    P.Nome := F('NOME').AsString;
    P.Materia := NormalizzaTestoSiuf(F('MATERIA').AsString);
    P.ContenutiMateria := NormalizzaTestoSiuf(F('CONTENUTI_MATERIA').AsString);
    P.Data := FormatDateTime('dd/mm/yyyy', RowData);
    P.DataLezione := RowData;
    P.OraInizio := FieldToHHMM(F('ORA_INIZIO'));
    P.OraFine := FieldToHHMM(F('ORA_FINE'));
    P.OrePresenza := OreToSiuf(FieldToHHMM(F('ORE_PRESENZA')));

    // Mantis #100 - 2026-09-11: le assenze giustificate sono l'unica differenza
    // di calcolo fra i due canali. L'Extra Obbligo non le contempla e impone
    // oreAssenzaGiustificata = "0" (paragrafo 1.4 EOB), quindi confluiscono
    // nelle ore di assenza. Il canale ordinamentale le prevede come valore
    // reale, e il decreto (art. 17) le richiede espressamente per la vigilanza
    // sull'obbligo di istruzione: lì vanno tenute separate.
    //
    // Mantis #186 - 2026-09-30: vale anche per i corsi ITS e IFTS. AT SIUF ha
    // confermato per iscritto che per loro l'inserimento è lo stesso degli
    // altri corsi, con esempio oreAssenzaGiustificata = "0.15". L'errore "Il
    // valore di Ore Assenza Giustificata non può essere diverso da zero" era
    // dovuto al formato "0.00", corretto in MinutiToSiuf.
    if ACanale = scOrdinamentale then
    begin
      P.OreAssenza := OreToSiuf(FieldToHHMM(F('ORE_ASSENZA')));
      P.OreAssenzaGiustificata := OreToSiuf(FieldToHHMM(F('ORE_ASSENZA_GIUSTIFICATA')));
    end
    else
    begin
      P.OreAssenza := MinutiToSiuf(HHMMToMinuti(FieldToHHMM(F('ORE_ASSENZA'))) + HHMMToMinuti(FieldToHHMM(F('ORE_ASSENZA_GIUSTIFICATA'))));
      // OreAssenzaGiustificata resta "0" (default in TSiufPresenza.Create).
    end;

    // Mantis #93 - 2026-09-08: si conserva anche il codice di partenza, così
    // se la conversione non trova corrispondenza il messaggio di errore può
    // dire quale tipologia di Gesty va decisa con AT SIUF.
    P.TipologiaGesty := Trim(F('TIPOLOGIA').AsString);
    P.Tipologia := TipologiaPerCanale(P.TipologiaGesty, ACanale);
    P.CodiceFiscaleCoDocente := F('CODICE_FISCALE_CODOCENTE').AsString;

    // Mantis #100 - 2026-09-11: campi del solo tracciato ordinamentale. La
    // GRS_EXPORT li espone già tutti e quattro; si leggono comunque in modo
    // difensivo, perché sull'Extra Obbligo non verranno serializzati.
    P.Sede := NormalizzaTestoSiuf(FieldOpt(ADataset, 'SEDE_FISICA_O_VIRTUALE'));
    P.MotivoChiusura := FieldOpt(ADataset, 'MOTIVO_CHIUSURA');
    P.DataInizioChiusura := FieldOptDateISO(ADataset, 'DATA_INIZIO_CHIUSURA');
    P.DataFineChiusura := FieldOptDateISO(ADataset, 'DATA_FINE_CHIUSURA');

    P.IdProgetto := F('ID_PROGETTO').AsInteger;
    { TODO : Passare attraverso una funzione che restituisca un errore se non è un integer }
    P.SiufIdSezione := IdSezione(F('RIF_EVENTO_FORMATIVO').AsString);

    Result := P;
  except
    P.Free;
    raise;
  end;
end;

{ TSiufPayloadBuilder – FASE 1: Estrazione e Caricamento }

class procedure TSiufPayloadBuilder.LoadDataSet(ADataset: TDataSet; AGroups: TSiufGroupDict; const ACanaleResolver: TSiufCanaleResolver; const AItsIftsResolver: TSiufItsIftsResolver);
var
  P: TSiufPresenza;
  Key: TSiufGroupKey;
  Group: TObjectList<TSiufPresenza>;
  Canale: TSiufCanale;
  ItsIfts: Boolean;
  CanalePerProgetto: TDictionary<Integer, TSiufCanale>;
  ItsIftsPerProgetto: TDictionary<Integer, Boolean>; // Mantis #186 - 2026-09-25
  IdProgetto: Integer;
begin
  // Mantis #100 - 2026-09-11: il canale si risolve una volta per progetto: il
  // resolver di solito interroga il database, mentre il dataset ha una riga per
  // ogni studente e per ogni ora.
  CanalePerProgetto := TDictionary<Integer, TSiufCanale>.Create;
  // Mantis #186 - 2026-09-25: stesso schema di cache per il flag ITS/IFTS,
  // indipendente dal canale (vedi TSiufItsIftsResolver).
  ItsIftsPerProgetto := TDictionary<Integer, Boolean>.Create;
  try
    ADataset.DisableControls;
    try
      ADataset.First;
      while not ADataset.Eof do
      begin
        IdProgetto := ADataset.FieldByName('ID_PROGETTO').AsInteger;

        if not CanalePerProgetto.TryGetValue(IdProgetto, Canale) then
        begin
          if Assigned(ACanaleResolver) then
            Canale := ACanaleResolver(IdProgetto)
          else
            Canale := scExtraObbligo; // comportamento storico
          CanalePerProgetto.Add(IdProgetto, Canale);
        end;

        // Mantis #186 - 2026-09-25: se il resolver non è passato, resta False.
        if not ItsIftsPerProgetto.TryGetValue(IdProgetto, ItsIfts) then
        begin
          if Assigned(AItsIftsResolver) then
            ItsIfts := AItsIftsResolver(IdProgetto)
          else
            ItsIfts := False;
          ItsIftsPerProgetto.Add(IdProgetto, ItsIfts);
        end;

        P := LoadPresenza(ADataset, Canale, ItsIfts);

        Key.IdProgetto := P.IdProgetto;
        Key.IdSezione := P.SiufIdSezione;

        if not AGroups.TryGetValue(Key, Group) then
        begin
          Group := TObjectList<TSiufPresenza>.Create(True);
          AGroups.Add(Key, Group);
        end;

        Group.Add(P);
        ADataset.Next;
      end;
    finally
      ADataset.First;
      ADataset.EnableControls;
    end;
  finally
    CanalePerProgetto.Free;
    ItsIftsPerProgetto.Free; // Mantis #186 - 2026-09-25
  end;
end;

{ TSiufPayloadBuilder – FASE 1 bis: aggregazione delle ore in lezioni SIUF }

// Mantis #93 - 2026-09-08: i campi confrontati sono quelli che SIUF usa per
// riconoscere la lezione, elencati al paragrafo 1.3 del documento di specifiche
// tecniche EOB: data, ora inizio, ora fine, tipologia, materia e contenuti
// (senza distinzione fra maiuscole e minuscole, da cui SameText), docente e
// codocente. Se cambia anche solo il docente o la materia, sul GRS sono due
// lezioni distinte e vanno lasciate separate.
class function TSiufPayloadBuilder.StessaLezioneSiuf(APrecedente, ASuccessiva: TSiufPresenza): Boolean;
begin
  Result :=
    SameText(Trim(APrecedente.CodiceFiscale), Trim(ASuccessiva.CodiceFiscale)) and
    (Trunc(APrecedente.DataLezione) = Trunc(ASuccessiva.DataLezione)) and
    (APrecedente.IdProgetto = ASuccessiva.IdProgetto) and
    (APrecedente.SiufIdSezione = ASuccessiva.SiufIdSezione) and
    (APrecedente.Tipologia = ASuccessiva.Tipologia) and
    SameText(Trim(APrecedente.CodiceFiscaleDocente), Trim(ASuccessiva.CodiceFiscaleDocente)) and
    SameText(Trim(APrecedente.CodiceFiscaleCoDocente), Trim(ASuccessiva.CodiceFiscaleCoDocente)) and
    SameText(Trim(APrecedente.Materia), Trim(ASuccessiva.Materia)) and
    SameText(Trim(APrecedente.ContenutiMateria), Trim(ASuccessiva.ContenutiMateria)) and
    // adiacenza: la lezione successiva comincia esattamente dove finisce la
    // precedente. Con una pausa in mezzo sul GRS ci sono due eventi distinti.
    (APrecedente.OraFine = ASuccessiva.OraInizio);
end;

// Mantis #93 - 2026-09-08: Gesty registra le presenze ora per ora (ORARIO ha
// una riga per ogni ora di lezione; per PIP, sostegno e tirocinio è la
// GRS_EXPORT_* a spezzare la fascia con ZZ_RANGE_ORE a 60 minuti). SIUF invece
// cerca la lezione per ora di inizio e ora di fine esatte dell'evento
// formativo: una lezione registrata sul GRS dalle 20:00 alle 22:00 non viene
// trovata se il payload la dichiara dalle 20:00 alle 21:00. Qui le ore
// adiacenti della stessa lezione tornano a essere una presenza sola, con le
// ore di presenza e di assenza sommate in minuti (così la somma resta uguale
// alla durata complessiva, come pretende SIUF).
class procedure TSiufPayloadBuilder.AggregaOreContigue(APresenze: TObjectList<TSiufPresenza>);
var
  AggregazioneCmp: IComparer<TSiufPresenza>;
  Indice: Integer;
  Accumulata: TSiufPresenza;
  Corrente: TSiufPresenza;
begin
  if APresenze.Count < 2 then
    Exit;

  // Mantis #152 - 2026-09-21: l'accorpamento vale solo per l'Extra Obbligo.
  // Sul canale ordinamentale (IeFP/IFTS/ITS) SIUF pretende righe da 60 minuti
  // esatti e rifiuta la fascia unita, con il messaggio "verificare che la
  // formattazione degli orari sia la seguente (HH:mm) e che la lezione duri
  // (60 minuti)". I due canali hanno quindi regole opposte: a blocchi l'Extra
  // Obbligo, ora per ora l'ordinamentale.
  //
  // Tutte le presenze del gruppo appartengono allo stesso progetto, quindi il
  // canale della prima vale per tutte.
  if APresenze[0].Canale = scOrdinamentale then
    Exit;

  // AggregazioneCmp è un'interfaccia reference-counted: si rilascia da sola a
  // fine metodo, non va liberata a mano (stesso motivo di DateCmp).
  AggregazioneCmp := TPresenzaAggregazioneComparer.Create;
  APresenze.Sort(AggregazioneCmp);

  Accumulata := APresenze[0];
  Indice := 1;
  while Indice < APresenze.Count do
  begin
    Corrente := APresenze[Indice];

    if StessaLezioneSiuf(Accumulata, Corrente) then
    begin
      // La presenza accumulata si allunga fino alla fine di quella corrente.
      Accumulata.OraFine := Corrente.OraFine;
      Accumulata.OrePresenza := MinutiToSiuf(Accumulata.OrePresenzaMinuti + Corrente.OrePresenzaMinuti);
      Accumulata.OreAssenza := MinutiToSiuf(Accumulata.OreAssenzaMinuti + Corrente.OreAssenzaMinuti);

      // Mantis #152 - 2026-09-21: anche le ore di assenza giustificata vanno sommate.
      // Oggi qui arriva solo l'Extra Obbligo, dove LoadPresenza le fa confluire in
      // OreAssenza e il campo resta '0', quindi la somma non scatta mai: resta come
      // rete di sicurezza, perché senza di essa riaprire l'accorpamento al canale
      // ordinamentale (che tiene le giustificate separate, Mantis #100) rimetterebbe
      // in circolo una fascia larga il doppio con la metà dei minuti.
      // Mantis #186 - 2026-09-28: MinutiToSiuf(0) restituisce ora '0', il valore
      // letterale che l'Extra Obbligo pretende: la somma si scrive sempre.
      Accumulata.OreAssenzaGiustificata := MinutiToSiuf(Accumulata.OreAssenzaGiustificataMinuti + Corrente.OreAssenzaGiustificataMinuti);

      // La lista possiede gli elementi (OwnsObjects=True): Delete distrugge
      // l'oggetto assorbito. Non si avanza l'indice, perché la Delete ha già
      // fatto scorrere di uno la lista.
      APresenze.Delete(Indice);
    end
    else
    begin
      Accumulata := Corrente;
      Inc(Indice);
    end;
  end;
end;

{ TSiufPayloadBuilder – FASE 2: Ordinamento e Processamento }

class procedure TSiufPayloadBuilder.ProcessGroups(AGroups: TSiufGroupDict; const ACodiceFiscaleUser: string; AOut: TObjectList<TSiufPayload>);
var
  DateCmp: IComparer<TSiufPresenza>;
  Pair: TPair<TSiufGroupKey, TObjectList<TSiufPresenza>>;
begin
  // Ownership: i gruppi restano proprietari (OwnsObjects=True) per tutta la
  // durata. SplitInChunks NON copia i riferimenti ma li ESTRAE dal gruppo
  // (ExtractAt) e li passa ai payload: il trasferimento è atomico, non esiste
  // mai un istante in cui due contenitori possiedono la stessa presenza.
  // Qualunque eccezione lascia ogni presenza posseduta da un solo contenitore,
  // quindi la pulizia (AGroups.Free / Result_.Free) non causa double-free.
  //
  // DateCmp è un'interfaccia reference-counted: viene rilasciata da sola a fine
  // metodo. NON liberarla a mano (Sort la usa come IComparer e un Free esplicito
  // dopo l'auto-release causerebbe un invalid pointer).
  DateCmp := TPresenzaDateComparer.Create;
  for Pair in AGroups do
  begin
    // Mantis #93 - 2026-09-08: prima si ricompongono le ore adiacenti nella
    // lezione unica che SIUF si aspetta, poi si riordina per data perché
    // SplitInChunks pretende la lista ordinata cronologicamente.
    AggregaOreContigue(Pair.Value);

    Pair.Value.Sort(DateCmp);
    SplitInChunks(Pair.Value, Pair.Key.IdProgetto, Pair.Key.IdSezione, ACodiceFiscaleUser, AOut);
  end;
end;

{ TSiufPayloadBuilder – suddivisione in finestre temporali }

class procedure TSiufPayloadBuilder.SplitInChunks(APres: TObjectList<TSiufPresenza>; AIdProgetto, AIdSezione: Integer; const ACodiceFiscaleUser: string; AOut: TObjectList<TSiufPayload>);
var
  Payload: TSiufPayload;
  P: TSiufPresenza;
  WindowStart: TDate;
  MaxDate: TDate;

  procedure FlushPayload;
  begin
    if Assigned(Payload) and (Payload.ListaStudenti.Count > 0) then
    begin
      Payload.DataFine := FormatDateTime('yyyy-mm-dd', MaxDate);
      AOut.Add(Payload);
    end
    else
      Payload.Free;
    Payload := nil;
  end;

  procedure OpenPayload(AFirstDate: TDate; ACanale: TSiufCanale);
  begin
    Payload := TSiufPayload.Create;
    Payload.CodiceFiscaleUser := ACodiceFiscaleUser;
    Payload.IdSezione := AIdSezione;
    Payload.IdProgetto := AIdProgetto;
    // Mantis #100 - 2026-09-11: tutte le presenze del gruppo appartengono allo
    // stesso progetto, quindi allo stesso canale: basta quello della prima.
    Payload.Canale := ACanale;
    Payload.DataInizio := FormatDateTime('yyyy-mm-dd', AFirstDate);
    WindowStart := AFirstDate;
    MaxDate := AFirstDate;
  end;

begin
  Payload := nil;
  P := nil;
  try
    // Iteriamo per indice crescente: APres è già ordinata. Usiamo Extract così
    // ogni presenza esce dal gruppo (che ne perde la ownership) ed entra nel
    // payload nello stesso passo, senza doppia ownership in caso di eccezione.
    while APres.Count > 0 do
    begin
      P := APres.ExtractAt(0);

      if Payload = nil then
        OpenPayload(P.DataLezione, P.Canale)
      else
        if (Trunc(P.DataLezione) - Trunc(WindowStart)) >= MAX_GIORNI_CHUNK then
        begin
          FlushPayload;
          OpenPayload(P.DataLezione, P.Canale);
        end
        else
        begin
          if Trunc(P.DataLezione) > Trunc(MaxDate) then
            MaxDate := P.DataLezione;
        end;

      Payload.ListaStudenti.Add(P);
      P := nil; // ceduta al payload: non è più "orfana"
    end;

    FlushPayload;
  except
    // P: estratta dal gruppo ma non ancora ceduta a un payload -> orfana.
    P.Free;
    // Payload: non ancora consegnato ad AOut (possiede le presenze già aggiunte).
    Payload.Free;
    raise;
  end;
end;

{ TSiufPayloadBuilder – punto di ingresso pubblico }

class function TSiufPayloadBuilder.BuildChunks(ADataset: TDataSet; const ACodiceFiscaleUser: string; const ACanaleResolver: TSiufCanaleResolver; const AItsIftsResolver: TSiufItsIftsResolver): TObjectList<TSiufPayload>;
var
  Groups: TSiufGroupDict;
  KeyCmp: IEqualityComparer<TSiufGroupKey>;
  Result_: TObjectList<TSiufPayload>;
begin
  Result_ := TObjectList<TSiufPayload>.Create(True);

  // KeyCmp è un'interfaccia reference-counted: il dizionario ne incrementa il
  // refcount e lo rilascia alla propria distruzione. NON va liberato a mano
  // (un Free esplicito causerebbe un double-free dopo Groups.Free).
  KeyCmp := TGroupKeyEqualityComparer.Create;

  // I gruppi restano proprietari delle presenze finché SplitInChunks non le
  // estrae trasferendole ai payload. In caso d'eccezione, ogni presenza è
  // posseduta da UN solo contenitore (gruppo oppure payload in Result_):
  // liberarli entrambi nel cleanup è quindi sicuro (insiemi disgiunti).
  Groups := TSiufGroupDict.Create([doOwnsValues], KeyCmp);
  try
    try
      // FASE 1 – lettura dataset ed estrazione in memoria
      LoadDataSet(ADataset, Groups, ACanaleResolver, AItsIftsResolver);

      // FASE 2 – ordinamento dei gruppi e generazione dei chunk
      ProcessGroups(Groups, ACodiceFiscaleUser, Result_);

      Result := Result_;
    except
      // Presenze non trasferite -> nei gruppi (libera Groups.Free nel finally).
      // Presenze trasferite -> nei payload di Result_ (libera Result_.Free qui).
      Result_.Free;
      Result := nil;
      raise;
    end;
  finally
    Groups.Free; // KeyCmp viene rilasciato automaticamente (refcount -> 0)
  end;
end;

end.
