unit SIUF.CooperazioneApplicativa.Validator;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  SIUF.CooperazioneApplicativa.Types;

type
  /// Singola violazione rilevata lato client (prima dell'invio)
  TSiufViolazione = record
    Indice: Integer; // indice riga in listaStudenti (-1 = livello header)
    Campo: string; // campo coinvolto
    Messaggio: string; // descrizione leggibile
    constructor Create(AIndice: Integer; const ACampo, AMessaggio: string);
  end;

  /// Esegue i controlli prevenibili senza chiamare il server.
  /// Non possiede il payload. Raccoglie TUTTE le violazioni (invio bloccante).
  TSiufValidator = class
  public
    /// Restituisce la lista (eventualmente vuota) delle violazioni.
    /// Il chiamante è proprietario della lista restituita.
    class function Valida(APayload: TSiufPayload): TList<TSiufViolazione>; static;
    /// True se il payload è valido (nessuna violazione)
    class function EValido(APayload: TSiufPayload; out AViolazioni: TList<TSiufViolazione>): Boolean; static;
    /// Valida e, se ci sono violazioni, solleva ESiufValidazione.
    /// Gestisce internamente il ciclo di vita della lista (nessun free a carico del chiamante).
    class procedure ValidaOErrore(APayload: TSiufPayload); static;
  end;

  /// Sollevata quando la validazione client-side blocca l'invio.
  /// Espone tutte le violazioni rilevate.
  ESiufValidazione = class(Exception)
  private
    FViolazioni: TArray<TSiufViolazione>;
  public
    constructor CreateFromList(AList: TList<TSiufViolazione>);
    property Violazioni: TArray<TSiufViolazione> read FViolazioni;
  end;

implementation

{ TSiufViolazione }

constructor TSiufViolazione.Create(AIndice: Integer; const ACampo, AMessaggio: string);
begin
  Indice := AIndice;
  Campo := ACampo;
  Messaggio := AMessaggio;
end;

{ TSiufValidator }

// "YYYY-MM-DD" -> TDate (formato header)
function ParseData(const S: string; out D: TDate): Boolean;
var
  Y, M, G: word;
  tmp: TDateTime;
begin
  Result := False;
  if Length(S) <> 10 then
    Exit;
  Y := StrToIntDef(Copy(S, 1, 4), 0);
  M := StrToIntDef(Copy(S, 6, 2), 0);
  G := StrToIntDef(Copy(S, 9, 2), 0);
  if (Y = 0) or (M = 0) or (G = 0) then
    Exit;
  Result := TryEncodeDate(Y, M, G, tmp);

  if Result then
    D := tmp;
end;

// "DD/MM/YYYY" (o con altro separatore) -> TDate (formato riga listaStudenti).
// Robusta: estrae i 3 gruppi di cifre indipendentemente dal separatore usato.
function ParseDataRiga(const S: string; out D: TDate): Boolean;
var
  Parti: TArray<string>;
  Y, M, G: Integer;
  tmp: TDateTime;
  T: string;
  i: Integer;
begin
  Result := False;
  T := Trim(S);
  if T = '' then
    Exit;

  // Normalizza qualunque separatore non numerico a '/'
  for i := 1 to Length(T) do
    if not CharInSet(T[i], ['0' .. '9']) then
      T[i] := '/';

  Parti := T.Split(['/'], TStringSplitOptions.ExcludeEmpty);
  if Length(Parti) <> 3 then
    Exit;

  G := StrToIntDef(Parti[0], 0);
  M := StrToIntDef(Parti[1], 0);
  Y := StrToIntDef(Parti[2], 0);
  if (Y = 0) or (M = 0) or (G = 0) then
    Exit;

  Result := TryEncodeDate(Y, M, G, tmp);
  if Result then
    D := tmp;
end;

// Mantis #189 - 2026-09-28: forma di un codice fiscale che SIUF può riconoscere.
// Sedici caratteri fra lettere e cifre (codice fiscale, anche omocodico, e i
// codici provvisori STP o MICF) oppure undici cifre (codice numerico). Non è la
// verifica del carattere di controllo: serve a fermare i valori che nel campo
// non dovrebbero proprio stare, come una data di nascita o una ragione sociale
// arrivate da un import con le colonne sfalsate. È la stessa regola della
// funzione ANAGRAFE_CODICE_FISCALE_AMMESSO del database.
function CodiceFiscaleFormalmenteValido(const S: string): Boolean;
var
  Codice: string;
  Carattere: Char;
  SoloCifre: Boolean;
begin
  Codice := UpperCase(Trim(S));
  if (Length(Codice) <> 16) and (Length(Codice) <> 11) then
    Exit(False);

  SoloCifre := True;
  for Carattere in Codice do
  begin
    if not CharInSet(Carattere, ['0' .. '9', 'A' .. 'Z']) then
      Exit(False);
    if not CharInSet(Carattere, ['0' .. '9']) then
      SoloCifre := False;
  end;

  Result := (Length(Codice) = 16) or SoloCifre;
end;

// Mantis #189 - 2026-09-28: True se lo stesso codice fiscale compare in una
// riga precedente del payload. Uno studente ha una riga per ogni ora di
// lezione: senza questo controllo lo stesso codice sbagliato verrebbe
// segnalato decine di volte e nasconderebbe le altre violazioni.
function CodiceFiscaleInRighePrecedenti(APayload: TSiufPayload; AIndice: Integer): Boolean;
var
  Riga: Integer;
begin
  Result := False;
  for Riga := 0 to AIndice - 1 do
    if SameText(Trim(APayload.ListaStudenti[Riga].CodiceFiscale), Trim(APayload.ListaStudenti[AIndice].CodiceFiscale)) then
      Exit(True);
end;

class function TSiufValidator.Valida(APayload: TSiufPayload): TList<TSiufViolazione>;
var
  V: TList<TSiufViolazione>;
  DInizio, DFine, DLez: TDate;
  HeaderDateOk: Boolean;
  i, DurataLez, SommaMin: Integer;
  P: TSiufPresenza;
begin
  V := TList<TSiufViolazione>.Create;
  try
    // --- livello header ---
    if Trim(APayload.CodiceFiscaleUser) = '' then
      V.Add(TSiufViolazione.Create(-1, 'codiceFiscaleUser', 'Il codice fiscale utente è obbligatorio.'));

    if APayload.IdSezione <= 0 then
      V.Add(TSiufViolazione.Create(-1, 'idSezione', 'idSezione mancante o non valido.'));

    HeaderDateOk := ParseData(APayload.DataInizio, DInizio) and ParseData(APayload.DataFine, DFine);

    if not HeaderDateOk then
      V.Add(TSiufViolazione.Create(-1, 'dataInizio/dataFine', 'Date intervallo non valide (atteso YYYY-MM-DD).'))
    else
    begin
      if DFine < DInizio then
        V.Add(TSiufViolazione.Create(-1, 'dataInizio/dataFine', 'dataFine precedente a dataInizio.'));
      // max 3 giorni DISTINTI => differenza in giorni <= 2 (01..03 = 3 giorni)
      //
      // Mantis #100 - 2026-09-11: la slide 11 della presentazione IeFP precisa
      // che il limite vale per le sole lezioni di tipologia AULA, mentre per il
      // TIROCINIO se ne possono trasmettere di più. Qui il limite resta
      // applicato a tutti i casi: è conservativo (spezza in più chiamate del
      // necessario) ma mai sbagliato. Da rivedere solo se il volume di invii
      // diventasse un problema.
      if (Trunc(DFine) - Trunc(DInizio) > 2) then
        V.Add(TSiufViolazione.Create(-1, 'dataInizio/dataFine', 'Attenzione! Non si può inserire un intervallo di date di più di 3 giorni'));
    end;

    if APayload.ListaStudenti.Count = 0 then
      V.Add(TSiufViolazione.Create(-1, 'listaStudenti', 'Nessuna presenza da inviare.'));

    // --- livello riga ---
    for i := 0 to APayload.ListaStudenti.Count - 1 do
    begin
      P := APayload.ListaStudenti[i];

      // identificazione studente: serve almeno CF oppure cognome+nome
      if (Trim(P.CodiceFiscale) = '') and ((Trim(P.Cognome) = '') or (Trim(P.Nome) = '')) then
        V.Add(TSiufViolazione.Create(i, 'codiceFiscale', Format('Riga %d: studente non identificabile (manca codice fiscale o cognome+nome).', [i])));

      // Mantis #189 - 2026-09-28: un codice fiscale che non ha nemmeno la forma
      // giusta non viene riconosciuto da SIUF, che rifiuta l'intero invio con
      // "studente non assegnato all'Evento Formativo" e in qualche caso carica
      // comunque una parte delle ore. Il caso reale è una scheda doppia con la
      // data di nascita nel codice fiscale, iscritta alla classe accanto a
      // quella giusta: qui l'invio si ferma prima di partire e dice quale
      // studente sistemare.
      if (Trim(P.CodiceFiscale) <> '') and not CodiceFiscaleFormalmenteValido(P.CodiceFiscale) and not CodiceFiscaleInRighePrecedenti(APayload, i) then
        V.Add(TSiufViolazione.Create(i, 'codiceFiscale', Format('Riga %d: lo studente %s %s ha un codice fiscale non valido ("%s"). ' +
          'Probabile scheda anagrafica doppia o importata con le colonne sfalsate: correggere la scheda, o l''iscrizione alla classe, prima di ripetere l''invio. ' +
          'Le altre righe dello stesso studente non vengono ripetute.', [i, Trim(P.Cognome), Trim(P.Nome), Trim(P.CodiceFiscale)])));

      // Mantis #93 - 2026-09-08: il canale Extra Obbligo ammette solo le
      // quattro tipologie del paragrafo 1.5 delle specifiche EOB, ed è uno dei
      // campi con cui SIUF cerca la lezione (paragrafo 1.3). Se la conversione
      // dal codice interno di Gesty non ha trovato corrispondenza si blocca
      // qui, invece di far partire un invio che verrebbe rifiutato con un
      // messaggio fuorviante ("lezione non trovata") o, peggio, accettato con
      // la tipologia sbagliata.
      // Mantis #100 - 2026-09-11: il messaggio e l'intervallo ammesso dipendono
      // dal canale. Sull'ordinamentale la tipologia non viene compressa a
      // quattro valori, quindi l'unica cosa che può mancare è la presenza del
      // codice nella lista accettata dal servizio.
      if P.Tipologia = TIPOLOGIA_SIUF_NON_MAPPATA then
      begin
        if APayload.Canale = scOrdinamentale then
          V.Add(TSiufViolazione.Create(i, 'tipologia', Format('Riga %d: la tipologia di lezione %s dello studente %s in data %s non è fra quelle accettate dal canale ordinamentale ' +
            '(codici da %d a %d della tabella dell''art. 15 c.3 del decreto GRS, esclusi il 6 e il 9 che il servizio SIUF non contempla).',
            [i, P.TipologiaGesty, Trim(P.CodiceFiscale), P.Data, TIPOLOGIA_ORD_MIN, TIPOLOGIA_ORD_MAX])))
        else
          V.Add(TSiufViolazione.Create(i, 'tipologia', Format('Riga %d: la tipologia di lezione %s (codice interno) dello studente %s in data %s non ha una corrispondenza ' +
            'fra quelle ammesse dal canale Extra Obbligo (1 Aula, 2 Stage, 3 Esercitazione, 4 FAD). ' + 'Va concordata la conversione con AT SIUF prima di poter trasmettere queste presenze.',
            [i, P.TipologiaGesty, Trim(P.CodiceFiscale), P.Data])));
      end
      else
        if (APayload.Canale = scExtraObbligo) and ((P.Tipologia < TIPOLOGIA_SIUF_AULA) or (P.Tipologia > TIPOLOGIA_SIUF_FAD)) then
          V.Add(TSiufViolazione.Create(i, 'tipologia', Format('Riga %d: tipologia %d non prevista dal canale Extra Obbligo (ammesse da %d a %d).', [i, P.Tipologia, TIPOLOGIA_SIUF_AULA, TIPOLOGIA_SIUF_FAD])));

      // Mantis #100 - 2026-09-11: oreAssenzaGiustificata deve valere "0" solo
      // sull'Extra Obbligo (paragrafo 1.4 EOB: "OBBLIGATORIAMENTE UGUALE A 0").
      // Il canale ordinamentale le accetta reali, e l'art. 17 del decreto le
      // richiede per la vigilanza sull'obbligo di istruzione.
      // Mantis #186 - 2026-09-30: ITS e IFTS seguono la regola dell'ordinamentale
      // (assenze giustificate reali), confermato per iscritto da AT SIUF.
      if (APayload.Canale = scExtraObbligo) and (Trim(P.OreAssenzaGiustificata) <> '0') then
        V.Add(TSiufViolazione.Create(i, 'oreAssenzaGiustificata', Format('Attenzione! Nella riga dello studente %d risultano assenze giustificate. ' + '(Il valore di assenze giustificate deve essere sempre uguale a 0)', [i])));

      // Mantis #100 - 2026-09-11: sul canale ordinamentale i tre campi di
      // chiusura si valorizzano insieme o restano tutti vuoti; il motivo, se
      // c'è, è uno dei tre codici del dominio GRS_EXPORT_MOTIVO_CHIUSURA.
      if APayload.Canale = scOrdinamentale then
      begin
        if (Trim(P.MotivoChiusura) <> '') and (Trim(P.MotivoChiusura) <> MOTIVO_CHIUSURA_FESTA_PATRONALE) and (Trim(P.MotivoChiusura) <> MOTIVO_CHIUSURA_PONTE) and
          (Trim(P.MotivoChiusura) <> MOTIVO_CHIUSURA_FORZA_MAGGIORE) then
          V.Add(TSiufViolazione.Create(i, 'motivoChiusura', Format('Riga %d: motivo di chiusura "%s" non previsto (ammessi 1 festa patronale, 2 chiusura per ponti, 3 cause di forza maggiore).', [i, P.MotivoChiusura])));

        if (Trim(P.MotivoChiusura) <> '') and ((Trim(P.DataInizioChiusura) = '') or (Trim(P.DataFineChiusura) = '')) then
          V.Add(TSiufViolazione.Create(i, 'dataInizioChiusura/dataFineChiusura',
            Format('Riga %d: indicato un motivo di chiusura senza le due date. Vanno compilate entrambe anche per un solo giorno di chiusura.', [i])));

        if Trim(P.Sede) = '' then
          V.Add(TSiufViolazione.Create(i, 'sede', Format('Riga %d: la sede è obbligatoria sul canale ordinamentale (art. 3 c.3 del decreto GRS).', [i])));
      end;

      // data lezione nell'intervallo header (P.Data è in formato DD/MM/YYYY)
      if ParseDataRiga(P.Data, DLez) then
      begin
        if HeaderDateOk and ((DLez < DInizio) or (DLez > DFine)) then
          V.Add(TSiufViolazione.Create(i, 'data', Format('Attenzione! Nella riga dello studente %d il campo Data (%s) è precedente ' + 'al campo dataInizio o successivo al campo dataFine', [i, P.Data])));
      end
      else
        V.Add(TSiufViolazione.Create(i, 'data', Format('Riga %d: data lezione non valida (atteso DD/MM/YYYY, trovato "%s").', [i, P.Data])));

      // coerenza presenza+assenza+giustificata vs durata lezione
      DurataLez := P.DurataLezioneMinuti;
      if DurataLez <= 0 then
        V.Add(TSiufViolazione.Create(i, 'oraInizio/oraFine', Format('Riga %d: oraFine non successiva a oraInizio.', [i])))
      else
      begin
        SommaMin := P.OrePresenzaMinuti + P.OreAssenzaMinuti + P.OreAssenzaGiustificataMinuti;
        if SommaMin <> DurataLez then
          V.Add(TSiufViolazione.Create(i, 'orePresenza/oreAssenza', Format('Attenzione! Nella riga dello studente %d nella fascia oraria che inizia alle %s ' + 'e finisce alle %s in data %s non corrispondono i minuti assegnati per presenza, ' +
            'assenza e assenza giustificata (durata %d min, assegnati %d min)', [i, P.OraInizio, P.OraFine, P.Data, DurataLez, SommaMin])));
      end;
    end;

    Result := V;
  except
    V.Free;
    raise;
  end;
end;

class function TSiufValidator.EValido(APayload: TSiufPayload; out AViolazioni: TList<TSiufViolazione>): Boolean;
begin
  AViolazioni := Valida(APayload);
  Result := AViolazioni.Count = 0;
end;

class procedure TSiufValidator.ValidaOErrore(APayload: TSiufPayload);
var
  V: TList<TSiufViolazione>;
begin
  V := Valida(APayload);
  try
    if V.Count > 0 then
      raise ESiufValidazione.CreateFromList(V);
  finally
    V.Free;
  end;
end;

{ ESiufValidazione }

constructor ESiufValidazione.CreateFromList(AList: TList<TSiufViolazione>);
var
  i: Integer;
  Sb: TStringBuilder;
begin
  SetLength(FViolazioni, AList.Count);
  Sb := TStringBuilder.Create;
  try
    Sb.AppendLine('Invio bloccato: rilevate violazioni nei dati.');
    for i := 0 to AList.Count - 1 do
    begin
      FViolazioni[i] := AList[i];
      // Mantis #152 - 2026-09-21: intestazione e messaggio su due righe distinte.
      // Il messaggio e' lungo e nel riquadro va a capo da solo: tenendolo rientrato
      // sotto la propria intestazione si continua a vedere dove finisce una
      // violazione e dove comincia quella dopo.
      if AList[i].Indice >= 0 then
        Sb.AppendLine(Format('- Riga %d, campo %s', [AList[i].Indice, AList[i].Campo]))
      else
        Sb.AppendLine(Format('- Header, campo %s', [AList[i].Campo]));

      Sb.AppendLine('      ' + AList[i].Messaggio);
    end;
    inherited Create(Sb.ToString);
  finally
    Sb.Free;
  end;
end;

end.
