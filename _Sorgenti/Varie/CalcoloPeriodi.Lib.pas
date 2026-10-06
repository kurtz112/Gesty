// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-23
// ---------------------------------------------------------------------------
unit CalcoloPeriodi.Lib;

// Durata di un periodo secondo le convenzioni in uso nel database.
//
// Calcolo tutto in Delphi, nessun accesso al database: serve dove la scheda
// deve mostrare un conteggio, o decidere una domanda all'operatore, mentre il
// record e' ancora nel buffer del client.
//
// OGNI FUNZIONE E' LA COPIA DI UN OGGETTO DEL DATABASE, dichiarato nel commento
// che la precede con la riga
//
//     // DB: <tipo> <nome>
//
// Una ricerca di "// DB:" su tutto il progetto restituisce l'elenco completo di
// quello che il client replica, e di quale oggetto Firebird va riletto quando
// si vuole verificare l'allineamento. Il confronto automatico fra le due copie
// sta in CalcoloPeriodi.Verifiche.
//
// Esempio d'uso:
//
//   Periodo := TCalcoloPeriodi.Calcola(DataInizio.AsDateTime, DataFine.AsDateTime);
//
//   if Periodo.Valorizzato then
//     NumeroMesi.Value := Periodo.MesiInteri
//   else
//     NumeroMesi.Clear;

interface

type
  // Valorizzato resta falso quando manca una delle due date: e' la stessa
  // regola delle funzioni Firebird, dove NULL in ingresso significa NULL in
  // uscita e mai zero. Chi chiama decide se azzerare o svuotare il campo.
  TPeriodo = record
    Valorizzato: Boolean;
    // Giorni di durata, estremi inclusi: dal 1 al 31 gennaio sono 31
    Giorni: Integer;
    // Confini di mese attraversati: dal 31 gennaio al 1 febbraio e' 1
    MesiCalendario: Integer;
    // Settimane arrotondate al valore piu' vicino, minimo una (regola SIA)
    SettimaneIntere: Integer;
    // Mesi arrotondati su un mese medio di 30,4375 giorni, minimo uno (regola SIA)
    MesiInteri: Integer;
    // Mensilita' con la frazione dell'ultimo mese: 2,48 (regola Abitare Progetti)
    Mensilita: Double;
  end;

  TCalcoloPeriodi = class
  public
    class function Giorni(const DataInizio, DataFine: TDateTime): Integer;
    class function MesiCalendario(const DataInizio, DataFine: TDateTime): Integer;
    class function SettimaneIntere(const DataInizio, DataFine: TDateTime): Integer;
    class function MesiInteri(const DataInizio, DataFine: TDateTime): Integer;
    class function Mensilita(const DataInizio, DataFine: TDateTime): Double;
    // Tutte le convenzioni in un colpo solo, con la data mancante gestita
    class function Calcola(const DataInizio, DataFine: TDateTime): TPeriodo;
  end;

implementation

uses
  System.SysUtils,
  System.Math,
  System.DateUtils;

const
  // 365,25 / 12: la durata media di un mese che tiene conto degli anni bisestili
  GiorniPerMeseMedio = 30.4375;

  // Arrotondamento al valore piu' vicino con la mezza unita' verso l'alto, come
  // il CAST a un tipo esatto di Firebird. Round di Delphi segue lo standard
  // IEEE 754 e a meta' strada arrotonda al pari (Round(2.5) restituisce 2): su un
  // conteggio di settimane darebbe risultati che nessuno saprebbe spiegare.
function ArrotondaAlPiuVicino(const Valore: Double): Integer;
begin
  Result := Floor(Valore + 0.5);
end;

// DB: 1 + DATEDIFF(DAY FROM <inizio> TO <fine>)
//
// Non e' una funzione ma un'espressione, e compare in quattro punti: le colonne
// calcolate TOTALE_GIORNI_COLLOCAMENTO_PREVISTI e _EFFETTIVI di
// ABITARE_EMERGENZA_PRONTO_INTERVENTO, le TOTALE_GIORNI_PREVISTI e _EFFETTIVI di
// ABITARE_EMERGENZA_PROGETTI, e le procedure _DETAIL dei due moduli.
//
// Estremi inclusi: dal 1 al 31 gennaio sono 31 giorni. Le date invertite restano
// negative invece di essere azzerate, come nel database. Qui la data mancante
// vale zero e restituisce zero: chi vuole distinguerla usa Calcola, che espone
// Valorizzato, mentre nel database il NULL si propaga da solo.
class function TCalcoloPeriodi.Giorni(const DataInizio, DataFine: TDateTime): Integer;
begin
  Result := 0;

  if (DataInizio = 0) or (DataFine = 0) then
    Exit;

  Result := 1 + Trunc(DataFine) - Trunc(DataInizio);
end;

// DB: DATEDIFF(MONTH FROM <inizio> TO <fine>)
//
// Non e' una funzione del database ma un suo operatore, e conta i confini di
// mese attraversati, non i mesi pieni: dal 31 gennaio al 1 febbraio risponde 1.
// MonthsBetween della RTL risponderebbe 0, ed e' il motivo per cui il conteggio
// e' scritto a mano invece di usare la libreria.
// Lo usano le due colonne delle spese di pulizia di Pronto Intervento.
class function TCalcoloPeriodi.MesiCalendario(const DataInizio, DataFine: TDateTime): Integer;
begin
  Result := 0;

  if (DataInizio = 0) or (DataFine = 0) then
    Exit;

  Result := ((YearOf(DataFine) - YearOf(DataInizio)) * 12) + (MonthOf(DataFine) - MonthOf(DataInizio));
end;

// DB: nessuno
//
// Regola dei voucher SIA. Oggi vive solo in Delphi, dentro
// dmSIA_ServizioInclusioneAdulti.pas: e' quella la copia di riferimento, ed e'
// riprodotta qui perche' quel modulo passi a usare questa unit. Quando la regola
// verra' portata anche nel database, il riferimento va scritto qui.
class function TCalcoloPeriodi.SettimaneIntere(const DataInizio, DataFine: TDateTime): Integer;
var
  NumeroGiorni: Integer;
begin
  NumeroGiorni := Giorni(DataInizio, DataFine);

  if NumeroGiorni <= 0 then
    Exit(0);

  Result := ArrotondaAlPiuVicino(NumeroGiorni / 7);

  if Result = 0 then
    Result := 1;
end;

// DB: nessuno
//
// Come SettimaneIntere, con il divisore 30,4375: regola dei voucher SIA, oggi
// solo in dmSIA_ServizioInclusioneAdulti.pas.
class function TCalcoloPeriodi.MesiInteri(const DataInizio, DataFine: TDateTime): Integer;
var
  NumeroGiorni: Integer;
begin
  NumeroGiorni := Giorni(DataInizio, DataFine);

  if NumeroGiorni <= 0 then
    Exit(0);

  Result := ArrotondaAlPiuVicino(NumeroGiorni / GiorniPerMeseMedio);

  if Result = 0 then
    Result := 1;
end;

// DB: FUNCTION MESI_BETWEEN
//
//   IF ((:DATA_INIZIO IS NULL) OR (:DATA_FINE IS NULL)) THEN RETURN 0;
//   IF (DATA_INIZIO >= :DATA_FINE) THEN RETURN 0;
//   NUMERO_MESI_COMPLETI = DATEDIFF(MONTH FROM :DATA_INIZIO TO DATA_FINE);
//   DATA_INIZIO_ULTIMO_MESE = FIRST_DAY(OF MONTH FROM :DATA_FINE);
//   DATA_FINE_ULTIMO_MESE = LAST_DAY(OF MONTH FROM :DATA_FINE);
//   GG_ULTIMO_MESE = 1 + DATEDIFF(DAY, DATA_INIZIO_ULTIMO_MESE, DATA_FINE_ULTIMO_MESE);
//   GG_RIMANENTI = 1 + DATEDIFF(DAY, DATA_INIZIO_ULTIMO_MESE, DATA_FINE);
//   RESULT = CAST(NUMERO_MESI_COMPLETI + (:GG_RIMANENTI / GG_ULTIMO_MESE) AS NUMERICO_10_2);
class function TCalcoloPeriodi.Mensilita(const DataInizio, DataFine: TDateTime): Double;
var
  MesiCompleti: Integer;
  GiorniUltimoMese: Integer;
  GiorniRimanenti: Integer;
begin
  Result := 0;

  if (DataInizio = 0) or (DataFine = 0) then
    Exit;

  if DataInizio >= DataFine then
    Exit;

  MesiCompleti := MesiCalendario(DataInizio, DataFine);

  // 1 + i giorni dal primo del mese alla fine del mese, cioe' i giorni del mese
  GiorniUltimoMese := DaysInMonth(DataFine);
  // 1 + i giorni dal primo del mese alla data, cioe' il numero del giorno
  GiorniRimanenti := DayOf(DataFine);

  Result := SimpleRoundTo(MesiCompleti + (GiorniRimanenti / GiorniUltimoMese), -2);
end;

class function TCalcoloPeriodi.Calcola(const DataInizio, DataFine: TDateTime): TPeriodo;
begin
  Result := Default (TPeriodo);

  if (DataInizio = 0) or (DataFine = 0) then
    Exit;

  Result.Valorizzato := true;
  Result.Giorni := Giorni(DataInizio, DataFine);
  Result.MesiCalendario := MesiCalendario(DataInizio, DataFine);
  Result.SettimaneIntere := SettimaneIntere(DataInizio, DataFine);
  Result.MesiInteri := MesiInteri(DataInizio, DataFine);
  Result.Mensilita := Mensilita(DataInizio, DataFine);
end;

end.
