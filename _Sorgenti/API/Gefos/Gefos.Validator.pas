// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-05
// ---------------------------------------------------------------------------
unit Gefos.Validator;

// Controlli da fare prima di chiamare GEFOS, con le stesse regole del servizio
// (specifica v2.3, sezioni 3.0.2, 3.10, 3.16, 4.6, 4.7). Lo scopo e' che l'operatore
// veda il problema in Gesty, con il nome del partecipante o la data della giornata,
// invece di una risposta 422 che arriva a meta' di una sequenza di chiamate.
//
// Ogni problema riporta, quando esiste, il codice che GEFOS restituirebbe.

interface

uses
  System.SysUtils,
  System.DateUtils,
  System.Generics.Collections,
  System.Generics.Defaults,
  Gefos.Types;

type
  TGefosValidatore = class
  public
    // Edizione e calendario prima di POST .../edizione (PerCreazione = True)
    // o di PUT .../edizione + PUT .../calendari (PerCreazione = False)
    class function ControllaEdizione(const Edizione: TGefosEdizione; const Tipologia: TGefosTipologiaCorso;
      Oggi: TDate; PerCreazione: Boolean): TGefosProblemi; static;

    // PUT .../calendari: gli slot con data passata vanno reinviati identici, con il loro id
    class function ControllaAggiornamentoCalendari(const Precedenti, Nuovi: TArray<TGefosCalendario>;
      Oggi: TDate): TGefosProblemi; static;

    // Dati anagrafici di un partecipante prima di POST .../partecipante
    class function ControllaPartecipante(const Partecipante: TGefosPartecipante; Oggi: TDate): TGefosProblemi; static;

    // Tutti i partecipanti dell'edizione: dati di ciascuno, doppioni e numero massimo
    class function ControllaPartecipanti(Metodo: Integer; const Partecipanti: TArray<TGefosPartecipante>;
      Oggi: TDate): TGefosProblemi; static;

    // POST .../avvio
    class function ControllaAvvio(const Edizione: TGefosEdizione; DichiarazioniAccettate,
      TestoDichiarazioniDisponibile: Boolean): TGefosProblemi; static;

    // POST .../conferma: Edizione con partecipanti (Id GEFOS e Esito) e calendari
    class function ControllaConclusione(const Edizione: TGefosEdizione; DichiarazioniAccettate,
      TestoDichiarazioniDisponibile: Boolean; Oggi: TDate): TGefosProblemi; static;

    // Ultimo giorno utile per confermare la conclusione
    class function UltimoGiornoConferma(DataFine: TDate): TDate; static;

    // Esito GEFOS dai due flag che Gesty registra gia' sul partecipante ASR:
    // Ammesso = PROGETTI_ASR_SICUREZZA_PARTECIPANTI.FORMATO (ammissione alla verifica,
    // la vista lo somma come NUMERO_AMMESSI_VERIFICA), Idoneo = IDONEO.
    // Il non ammesso prevale: chi non e' stato ammesso non puo' aver superato la verifica.
    // Le ore di presenza non entrano: nei dati reali ORE_PRESENZA spesso non e' compilato.
    class function EsitoDaIdoneita(Ammesso, Idoneo: Boolean): Integer; static;

    // Unisce gli slot dello stesso giorno che si toccano (fine dell'uno = inizio
    // dell'altro) e hanno stesso luogo, collegamento e metodo: in Gesty una giornata
    // e' spesso spezzata in piu' righe ORARIO consecutive. Gli intervalli fra due
    // righe (pause) restano: gli slot separati non si fondono.
    class function FondiSlotContigui(const Calendari: TArray<TGefosCalendario>): TArray<TGefosCalendario>; static;

    class function CodiceFiscaleFormaValida(const CodiceFiscale: string): Boolean; static;
    class function EmailFormaValida(const Email: string): Boolean; static;
  end;

implementation

function DescriviSlot(const Calendario: TGefosCalendario): string;
begin
  Result := 'Giornata ' + FormatDateTime('dd/mm/yyyy hh:nn', Calendario.DataOraDa) + '-' +
    FormatDateTime('hh:nn', Calendario.DataOraA);
end;

function StessoMinuto(Primo, Secondo: TDateTime): Boolean;
begin
  Result := Abs(Primo - Secondo) < (0.5 / MinsPerDay);
end;

function OrdinaPerInizio(const Calendari: TArray<TGefosCalendario>): TArray<TGefosCalendario>;
begin
  Result := Copy(Calendari);
  TArray.Sort<TGefosCalendario>(Result, TComparer<TGefosCalendario>.Construct(
    function(const Primo, Secondo: TGefosCalendario): Integer
    begin
      Result := CompareDateTime(Primo.DataOraDa, Secondo.DataOraDa);
    end));
end;

function SlotUguali(const Primo, Secondo: TGefosCalendario): Boolean;
begin
  Result := StessoMinuto(Primo.DataOraDa, Secondo.DataOraDa) and
    StessoMinuto(Primo.DataOraA, Secondo.DataOraA) and
    (Primo.MetodoGiornata = Secondo.MetodoGiornata) and
    SameText(Trim(Primo.Link), Trim(Secondo.Link)) and
    SameText(Trim(Primo.Indirizzo), Trim(Secondo.Indirizzo)) and
    SameText(Trim(Primo.NumeroCivico), Trim(Secondo.NumeroCivico)) and
    SameText(Trim(Primo.Cap), Trim(Secondo.Cap)) and
    SameText(Trim(Primo.Citta), Trim(Secondo.Citta)) and
    SameText(Trim(Primo.Provincia), Trim(Secondo.Provincia));
end;

function StessoLuogo(const Primo, Secondo: TGefosCalendario): Boolean;
begin
  Result := (Primo.MetodoGiornata = Secondo.MetodoGiornata) and
    SameText(Trim(Primo.Link), Trim(Secondo.Link)) and
    SameText(Trim(Primo.Indirizzo), Trim(Secondo.Indirizzo)) and
    SameText(Trim(Primo.NumeroCivico), Trim(Secondo.NumeroCivico)) and
    SameText(Trim(Primo.Cap), Trim(Secondo.Cap)) and
    SameText(Trim(Primo.Citta), Trim(Secondo.Citta)) and
    SameText(Trim(Primo.Provincia), Trim(Secondo.Provincia));
end;

procedure Aggiungi(var Problemi: TGefosProblemi; const Problema: TGefosProblema);
begin
  Problemi := Problemi + [Problema];
end;

{ TGefosValidatore }

class function TGefosValidatore.CodiceFiscaleFormaValida(const CodiceFiscale: string): Boolean;
var
  Carattere: Char;
  Pulito: string;
begin
  // Solo la forma (16 caratteri alfanumerici, sezione 4.6): il carattere di controllo
  // lo verifica gia' Gesty all'inserimento dell'anagrafica
  Pulito := UpperCase(Trim(CodiceFiscale));
  if Length(Pulito) <> 16 then
    Exit(False);
  for Carattere in Pulito do
    if not CharInSet(Carattere, ['A'..'Z', '0'..'9']) then
      Exit(False);
  Result := True;
end;

class function TGefosValidatore.EmailFormaValida(const Email: string): Boolean;
var
  Pulito, Dominio: string;
  Chiocciola: Integer;
begin
  Pulito := Trim(Email);
  Chiocciola := Pos('@', Pulito);
  if (Chiocciola <= 1) or (Pulito.CountChar('@') <> 1) or (Pos(' ', Pulito) > 0) then
    Exit(False);
  Dominio := Copy(Pulito, Chiocciola + 1, MaxInt);
  Result := (Pos('.', Dominio) > 1) and not Dominio.EndsWith('.');
end;

class function TGefosValidatore.UltimoGiornoConferma(DataFine: TDate): TDate;
begin
  Result := IncDay(DateOf(DataFine), GEFOS_GIORNI_PER_CONFERMA);
end;

class function TGefosValidatore.EsitoDaIdoneita(Ammesso, Idoneo: Boolean): Integer;
begin
  if not Ammesso then
    Result := GEFOS_ESITO_NON_AMMESSO
  else if Idoneo then
    Result := GEFOS_ESITO_SUPERATO
  else
    Result := GEFOS_ESITO_NON_SUPERATO;
end;

class function TGefosValidatore.FondiSlotContigui(const Calendari: TArray<TGefosCalendario>): TArray<TGefosCalendario>;
var
  Ordinati: TArray<TGefosCalendario>;
  Calendario: TGefosCalendario;
  Ultimo: Integer;
begin
  Result := nil;
  Ordinati := OrdinaPerInizio(Calendari);
  for Calendario in Ordinati do
  begin
    Ultimo := High(Result);
    // Uno slot gia' noto a GEFOS (Id <> 0) non si fonde: il suo id va reinviato intatto
    if (Ultimo >= 0) and (Result[Ultimo].Id = 0) and (Calendario.Id = 0) and
       SameDate(Result[Ultimo].DataOraA, Calendario.DataOraDa) and
       StessoMinuto(Result[Ultimo].DataOraA, Calendario.DataOraDa) and
       StessoLuogo(Result[Ultimo], Calendario) then
    begin
      if Calendario.DataOraA > Result[Ultimo].DataOraA then
        Result[Ultimo].DataOraA := Calendario.DataOraA;
    end
    else
      Result := Result + [Calendario];
  end;
end;

class function TGefosValidatore.ControllaEdizione(const Edizione: TGefosEdizione; const Tipologia: TGefosTipologiaCorso;
  Oggi: TDate; PerCreazione: Boolean): TGefosProblemi;
var
  Calendario: TGefosCalendario;
  Ordinati: TArray<TGefosCalendario>;
  Metodo, Indice: Integer;
  Inizio, FineEdizione: TDateTime;
  PrimoGiornoCoperto, UltimoGiornoCoperto: Boolean;
  Riferimento: string;
begin
  Result := nil;

  // Metodo di svolgimento
  if not GefosMetodoValido(Edizione.MetodoSvolgimento) then
    Aggiungi(Result, TGefosProblema.Errore('INVALID_METODO_SVOLGIMENTO', 'Modalita'' di erogazione',
      'Modalita'' di erogazione mancante o non riconosciuta.'))
  else if (Tipologia.Id <> 0) and not Tipologia.AmmetteMetodo(Edizione.MetodoSvolgimento) then
    Aggiungi(Result, TGefosProblema.Errore('METODO_SVOLGIMENTO_NON_COMPATIBILE_TIPOLOGIA', 'Modalita'' di erogazione',
      Format('%s non e'' ammessa per la tipologia GEFOS scelta (ammessi: %s).',
        [GefosDescrizioneMetodo(Edizione.MetodoSvolgimento), Tipologia.MetodiSvolgimentoTesto])));

  if Tipologia.Id = 0 then
    Aggiungi(Result, TGefosProblema.Errore('INVALID_TIPOLOGIA', 'Tipologia GEFOS',
      'Manca la tipologia di corso GEFOS associata all''edizione.'));

  // Date dell'edizione
  if Edizione.DataOraInizio = 0 then
    Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', 'Data di inizio', 'Manca la data di inizio dell''edizione.'));
  if Edizione.DataFine = 0 then
    Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', 'Data di fine', 'Manca la data di fine dell''edizione.'));
  if (Edizione.DataOraInizio <> 0) and (Edizione.DataFine <> 0) and (DateOf(Edizione.DataFine) < DateOf(Edizione.DataOraInizio)) then
    Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', 'Date dell''edizione',
      'La data di fine e'' precedente alla data di inizio.'));

  // Calendario
  if Length(Edizione.Calendari) = 0 then
  begin
    Aggiungi(Result, TGefosProblema.Errore('EDIZIONE_SENZA_CALENDARI', 'Calendario',
      'L''edizione non ha giornate di calendario: in GEFOS ne serve almeno una.'));
    Exit;
  end;

  Inizio := Edizione.DataOraInizio;
  // La fine dell'edizione e' una data: vale fino all'ultimo minuto del giorno
  FineEdizione := EndOfTheDay(Edizione.DataFine);
  PrimoGiornoCoperto := False;
  UltimoGiornoCoperto := False;

  for Calendario in Edizione.Calendari do
  begin
    Riferimento := DescriviSlot(Calendario);

    if Calendario.DataOraA < Calendario.DataOraDa then
      Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', Riferimento, 'L''ora di fine precede l''ora di inizio.'))
    else if StessoMinuto(Calendario.DataOraA, Calendario.DataOraDa) then
      Aggiungi(Result, TGefosProblema.Avviso('', Riferimento, 'Giornata di durata nulla.'));

    if (Calendario.DataOraDa < Inizio - (0.5 / MinsPerDay)) or (Calendario.DataOraA > FineEdizione) then
      Aggiungi(Result, TGefosProblema.Errore('CALENDARIO_OUT_OF_RANGE', Riferimento,
        'La giornata cade fuori dalle date di inizio e fine dell''edizione.'));

    if SameDate(Calendario.DataOraDa, Inizio) then
      PrimoGiornoCoperto := True;
    if (DateOf(Calendario.DataOraDa) <= DateOf(Edizione.DataFine)) and (DateOf(Calendario.DataOraA) >= DateOf(Edizione.DataFine)) then
      UltimoGiornoCoperto := True;

    // Slot con data passata: in creazione non si possono inviare affatto; in aggiornamento
    // solo quelli gia' noti a GEFOS (con id), e invariati: lo verifica ControllaAggiornamentoCalendari
    if (DateOf(Calendario.DataOraDa) < Oggi) and (PerCreazione or (Calendario.Id = 0)) then
      Aggiungi(Result, TGefosProblema.Errore('CALENDARIO_SLOT_PASSATO', Riferimento,
        'GEFOS non accetta giornate nuove con data precedente a oggi: l''edizione andava comunicata prima dell''inizio.'));

    // Metodo della giornata: obbligatorio nelle miste, vietato nelle altre
    if Edizione.MetodoSvolgimento = GEFOS_METODO_MISTA then
    begin
      if not GefosMetodoGiornataValido(Calendario.MetodoGiornata) then
        Aggiungi(Result, TGefosProblema.Errore('CALENDARIO_METODO_GIORNATA_OBBLIGATORIO', Riferimento,
          'In un''edizione mista ogni giornata deve indicare se e'' in presenza, in e-learning o in video-conferenza.'));
    end
    else if Calendario.MetodoGiornata <> 0 then
      Aggiungi(Result, TGefosProblema.Errore('CALENDARIO_METODO_GIORNATA_NON_AMMESSO', Riferimento,
        'Il metodo della singola giornata si indica solo nelle edizioni miste.'));

    // Campi richiesti dal metodo effettivo della giornata
    Metodo := GefosMetodoEffettivo(Edizione.MetodoSvolgimento, Calendario);
    if Metodo = GEFOS_METODO_PRESENZA_FISICA then
    begin
      if (Trim(Calendario.Indirizzo) = '') or (Trim(Calendario.NumeroCivico) = '') or (Trim(Calendario.Cap) = '') or
         (Trim(Calendario.Citta) = '') or (Trim(Calendario.Provincia) = '') then
        Aggiungi(Result, TGefosProblema.Errore('CALENDARIO_INDIRIZZO_OBBLIGATORIO', Riferimento,
          'Per le giornate in presenza servono via, numero civico, CAP, comune e provincia della sede.'));
      if (Trim(Calendario.Cap) <> '') and ((Length(Trim(Calendario.Cap)) <> 5) or (StrToIntDef(Trim(Calendario.Cap), -1) < 0)) then
        Aggiungi(Result, TGefosProblema.Avviso('', Riferimento, Format('CAP "%s" non di cinque cifre.', [Calendario.Cap])));
      if Length(Trim(Calendario.Provincia)) = 2 then
        Aggiungi(Result, TGefosProblema.Avviso('', Riferimento,
          Format('La provincia "%s" sembra una sigla: GEFOS vuole il nome per esteso.', [Calendario.Provincia])));
    end
    else if Metodo = GEFOS_METODO_VIDEO_CONFERENZA then
    begin
      if Trim(Calendario.Link) = '' then
        Aggiungi(Result, TGefosProblema.Errore('CALENDARIO_LINK_OBBLIGATORIO', Riferimento,
          'Per le giornate in video-conferenza serve il collegamento alla piattaforma.'));
    end;
  end;

  // Primo e ultimo giorno coperti, e prima giornata all'ora di inizio dell'edizione
  if Edizione.DataOraInizio <> 0 then
  begin
    if not PrimoGiornoCoperto then
      Aggiungi(Result, TGefosProblema.Errore('CALENDARIO_INCOERENTE_EDIZIONE', 'Calendario',
        Format('Nessuna giornata il primo giorno dell''edizione (%s).', [FormatDateTime('dd/mm/yyyy', Inizio)])));
    Ordinati := OrdinaPerInizio(Edizione.Calendari);
    if PrimoGiornoCoperto and not StessoMinuto(Ordinati[0].DataOraDa, Inizio) then
      Aggiungi(Result, TGefosProblema.Errore('CALENDARIO_INCOERENTE_EDIZIONE', 'Calendario',
        Format('La prima giornata comincia alle %s, l''edizione alle %s: devono coincidere.',
          [FormatDateTime('hh:nn', Ordinati[0].DataOraDa), FormatDateTime('hh:nn', Inizio)])));

    // Sovrapposizioni: GEFOS non le cita, ma gonfiano il monte ore
    for Indice := 1 to High(Ordinati) do
      if Ordinati[Indice].DataOraDa < Ordinati[Indice - 1].DataOraA - (0.5 / MinsPerDay) then
        Aggiungi(Result, TGefosProblema.Avviso('', DescriviSlot(Ordinati[Indice]),
          'La giornata si sovrappone alla precedente: le ore verrebbero contate due volte.'));
  end;
  if (Edizione.DataFine <> 0) and not UltimoGiornoCoperto then
    Aggiungi(Result, TGefosProblema.Errore('CALENDARIO_INCOERENTE_EDIZIONE', 'Calendario',
      Format('Nessuna giornata l''ultimo giorno dell''edizione (%s).', [FormatDateTime('dd/mm/yyyy', Edizione.DataFine)])));

  // Monte ore della tipologia: non per l'e-learning, e solo se la tipologia lo prevede
  if Tipologia.HaMonteOre and (Edizione.MetodoSvolgimento <> GEFOS_METODO_E_LEARNING) and
     (Edizione.DurataCalendarioMinuti < Tipologia.MonteOre * 60) then
    Aggiungi(Result, TGefosProblema.Errore('CALENDARIO_MONTE_ORE_INSUFFICIENTE', 'Calendario',
      Format('Il calendario somma %s ore, la tipologia ne richiede almeno %d.',
        [FormatFloat('0.##', Edizione.DurataCalendarioMinuti / 60), Tipologia.MonteOre])));
end;

class function TGefosValidatore.ControllaAggiornamentoCalendari(const Precedenti, Nuovi: TArray<TGefosCalendario>;
  Oggi: TDate): TGefosProblemi;
var
  Precedente, Nuovo: TGefosCalendario;
  Trovato: Boolean;
begin
  Result := nil;
  if Length(Nuovi) = 0 then
    Aggiungi(Result, TGefosProblema.Errore('EDIZIONE_SENZA_CALENDARI', 'Calendario',
      'L''aggiornamento del calendario deve contenere almeno una giornata.'));

  // Gli slot gia' passati devono restare nella lista, con id e contenuto invariati
  for Precedente in Precedenti do
  begin
    if DateOf(Precedente.DataOraDa) >= Oggi then
      Continue;
    Trovato := False;
    for Nuovo in Nuovi do
      if Nuovo.Id = Precedente.Id then
      begin
        Trovato := True;
        if not SlotUguali(Nuovo, Precedente) then
          Aggiungi(Result, TGefosProblema.Errore('CALENDARIO_SLOT_PASSATO', DescriviSlot(Precedente),
            'La giornata e'' gia'' passata e non si puo'' modificare in GEFOS.'));
        Break;
      end;
    if not Trovato then
      Aggiungi(Result, TGefosProblema.Errore('CALENDARIO_SLOT_PASSATO', DescriviSlot(Precedente),
        'La giornata e'' gia'' passata e non si puo'' togliere dal calendario GEFOS.'));
  end;

  for Nuovo in Nuovi do
    if (Nuovo.Id = 0) and (DateOf(Nuovo.DataOraDa) < Oggi) then
      Aggiungi(Result, TGefosProblema.Errore('CALENDARIO_SLOT_PASSATO', DescriviSlot(Nuovo),
        'Non si possono aggiungere giornate con data precedente a oggi.'));
end;

class function TGefosValidatore.ControllaPartecipante(const Partecipante: TGefosPartecipante; Oggi: TDate): TGefosProblemi;
var
  Riferimento: string;
begin
  Result := nil;
  Riferimento := Partecipante.Nominativo;
  if Riferimento = '' then
    Riferimento := 'Partecipante senza nome';

  if Trim(Partecipante.Nome) = '' then
    Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', Riferimento, 'Manca il nome.'));
  if Trim(Partecipante.Cognome) = '' then
    Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', Riferimento, 'Manca il cognome.'));

  if Trim(Partecipante.Email) = '' then
    Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', Riferimento, 'Manca l''indirizzo e-mail, obbligatorio in GEFOS.'))
  else if not EmailFormaValida(Partecipante.Email) then
    Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', Riferimento,
      Format('L''indirizzo e-mail "%s" non e'' valido.', [Partecipante.Email])));

  if Partecipante.DataNascita = 0 then
    Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', Riferimento, 'Manca la data di nascita, obbligatoria in GEFOS.'))
  else if DateOf(Partecipante.DataNascita) >= Oggi then
    Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', Riferimento, 'La data di nascita non e'' passata.'));

  if Trim(Partecipante.StatoNascita) = '' then
    Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', Riferimento, 'Manca lo stato di nascita.'))
  else if Partecipante.NatoInItalia then
  begin
    // Nati in Italia: codice fiscale, provincia e comune obbligatori
    if Trim(Partecipante.CodiceFiscale) = '' then
      Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', Riferimento, 'Manca il codice fiscale, obbligatorio per i nati in Italia.'))
    else if not CodiceFiscaleFormaValida(Partecipante.CodiceFiscale) then
      Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', Riferimento,
        Format('Il codice fiscale "%s" non ha 16 caratteri alfanumerici.', [Partecipante.CodiceFiscale])));
    if Trim(Partecipante.ProvinciaNascita) = '' then
      Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', Riferimento, 'Manca la provincia di nascita.'))
    else if Length(Trim(Partecipante.ProvinciaNascita)) = 2 then
      Aggiungi(Result, TGefosProblema.Avviso('', Riferimento,
        Format('La provincia di nascita "%s" sembra una sigla: GEFOS vuole il nome per esteso.', [Partecipante.ProvinciaNascita])));
    if Trim(Partecipante.ComuneNascita) = '' then
      Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', Riferimento, 'Manca il comune di nascita.'));
  end
  else
  begin
    // Nati all'estero: basta il codice fiscale oppure l'identificativo estero
    if (Trim(Partecipante.CodiceFiscale) = '') and (Trim(Partecipante.CodiceIdentificativoEstero) = '') then
      Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', Riferimento,
        'Per i nati all''estero serve il codice fiscale o un identificativo personale del paese di nascita.'))
    else if (Trim(Partecipante.CodiceFiscale) <> '') and not CodiceFiscaleFormaValida(Partecipante.CodiceFiscale) then
      Aggiungi(Result, TGefosProblema.Errore('BAD_REQUEST', Riferimento,
        Format('Il codice fiscale "%s" non ha 16 caratteri alfanumerici.', [Partecipante.CodiceFiscale])));
  end;
end;

class function TGefosValidatore.ControllaPartecipanti(Metodo: Integer; const Partecipanti: TArray<TGefosPartecipante>;
  Oggi: TDate): TGefosProblemi;
var
  Partecipante: TGefosPartecipante;
  CodiciVisti: TDictionary<string, string>;
  Codice, Precedente: string;
  Massimo: Integer;
begin
  Result := nil;

  Massimo := GefosMassimoPartecipanti(Metodo);
  if (Massimo > 0) and (Length(Partecipanti) > Massimo) then
  begin
    if Metodo = GEFOS_METODO_E_LEARNING then
      Aggiungi(Result, TGefosProblema.Errore('ELEARNING_MAX_PARTECIPANTI', 'Partecipanti',
        Format('Un''edizione in e-learning ammette un solo partecipante: qui sono %d.', [Length(Partecipanti)])))
    else
      Aggiungi(Result, TGefosProblema.Errore('MAX_PARTECIPANTI_SUPERATO', 'Partecipanti',
        Format('Le edizioni in presenza e miste ammettono al massimo %d partecipanti: qui sono %d.', [Massimo, Length(Partecipanti)])));
  end;

  CodiciVisti := TDictionary<string, string>.Create;
  try
    for Partecipante in Partecipanti do
    begin
      GefosAggiungiProblemi(Result, ControllaPartecipante(Partecipante, Oggi));
      Codice := UpperCase(Trim(Partecipante.CodiceFiscale));
      if Codice = '' then
        Continue;
      if CodiciVisti.TryGetValue(Codice, Precedente) then
        Aggiungi(Result, TGefosProblema.Errore('PARTECIPANTE_DUPLICATO', Partecipante.Nominativo,
          Format('Stesso codice fiscale di %s: GEFOS rifiuta il secondo.', [Precedente])))
      else
        CodiciVisti.Add(Codice, Partecipante.Nominativo);
    end;
  finally
    CodiciVisti.Free;
  end;
end;

class function TGefosValidatore.ControllaAvvio(const Edizione: TGefosEdizione; DichiarazioniAccettate,
  TestoDichiarazioniDisponibile: Boolean): TGefosProblemi;
begin
  Result := nil;
  if Edizione.Id = 0 then
    Aggiungi(Result, TGefosProblema.Errore('NOT_FOUND', 'Edizione', 'L''edizione non e'' ancora stata creata in GEFOS.'));
  if Edizione.Avviata then
    Aggiungi(Result, TGefosProblema.Errore('EDIZIONE_AVVIATA', 'Edizione', 'L''avvio dell''edizione e'' gia'' stato comunicato.'));
  if not TestoDichiarazioniDisponibile then
    Aggiungi(Result, TGefosProblema.Errore('DICHIARAZIONI_NON_ACCETTATE', 'Dichiarazioni',
      'Manca il testo delle dichiarazioni di avvio per questa denominazione di corso: va inserito prima di comunicare l''avvio.'));
  if not DichiarazioniAccettate then
    Aggiungi(Result, TGefosProblema.Errore('DICHIARAZIONI_NON_ACCETTATE', 'Dichiarazioni',
      'Per comunicare l''avvio vanno accettate le dichiarazioni.'));
end;

class function TGefosValidatore.ControllaConclusione(const Edizione: TGefosEdizione; DichiarazioniAccettate,
  TestoDichiarazioniDisponibile: Boolean; Oggi: TDate): TGefosProblemi;
var
  Partecipante: TGefosPartecipante;
  Scadenza: TDate;
begin
  Result := nil;
  if Edizione.Id = 0 then
    Aggiungi(Result, TGefosProblema.Errore('NOT_FOUND', 'Edizione', 'L''edizione non e'' ancora stata creata in GEFOS.'));

  if Length(Edizione.Partecipanti) = 0 then
    Aggiungi(Result, TGefosProblema.Errore('EDIZIONE_SENZA_PARTECIPANTI', 'Partecipanti',
      'Per confermare la conclusione serve almeno un partecipante.'));
  for Partecipante in Edizione.Partecipanti do
  begin
    if Partecipante.Id = 0 then
      Aggiungi(Result, TGefosProblema.Errore('PARTECIPANTE_NON_PRESENTE', Partecipante.Nominativo,
        'Il partecipante non e'' iscritto all''edizione in GEFOS.'))
    else if not GefosEsitoValido(Partecipante.Esito) then
      Aggiungi(Result, TGefosProblema.Errore('EDIZIONE_ESITI_INCOMPLETI', Partecipante.Nominativo,
        'Esito non ancora comunicato a GEFOS.'));
  end;

  if Length(Edizione.Calendari) = 0 then
    Aggiungi(Result, TGefosProblema.Errore('EDIZIONE_SENZA_CALENDARI', 'Calendario',
      'Per confermare la conclusione serve almeno una giornata di calendario.'));

  if Edizione.DataFine <> 0 then
  begin
    Scadenza := UltimoGiornoConferma(Edizione.DataFine);
    if Oggi > Scadenza then
      Aggiungi(Result, TGefosProblema.Errore('CONFERMA_FUORI_TERMINE', 'Edizione',
        Format('Il termine per confermare la conclusione e'' scaduto il %s (30 giorni dalla fine).', [FormatDateTime('dd/mm/yyyy', Scadenza)])))
    else if Oggi < DateOf(Edizione.DataFine) then
      Aggiungi(Result, TGefosProblema.Avviso('', 'Edizione',
        Format('L''edizione finisce il %s: la conclusione e'' irreversibile, confermarla prima e'' insolito.',
          [FormatDateTime('dd/mm/yyyy', Edizione.DataFine)])));
  end;

  if not TestoDichiarazioniDisponibile then
    Aggiungi(Result, TGefosProblema.Errore('DICHIARAZIONI_NON_ACCETTATE', 'Dichiarazioni',
      'Manca il testo delle dichiarazioni di conclusione: va inserito prima di confermare.'));
  if not DichiarazioniAccettate then
    Aggiungi(Result, TGefosProblema.Errore('DICHIARAZIONI_NON_ACCETTATE', 'Dichiarazioni',
      'Per confermare la conclusione vanno accettate le dichiarazioni.'));
end;

end.
