// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-23
// ---------------------------------------------------------------------------
unit CalcoloPeriodi.Verifiche;

// Confronta le funzioni di CalcoloPeriodi.Lib con le espressioni Firebird che
// replicano, dichiarate nei commenti "// DB:" di quella unit.
//
// Restano fuori SettimaneIntere e MesiInteri: sono le regole dei voucher SIA e
// nel database non esiste ancora una controparte da interrogare. Il giorno in
// cui ci sara', vanno aggiunte qui.
//
// Il prezzo di avere il calcolo in due posti e' che le due copie possono
// allontanarsi: e' gia' successo ai moduli Abitare Emergenza e Assistenza
// Educativa, dove la formula Delphi e quella del database erano divergenti in
// due punti su tre e nessuno se n'era accorto. Questa unit rende il
// disallineamento una cosa che si scopre con un collaudo.
//
// Non entra nel funzionamento normale dell'applicazione: si richiama da una
// voce di diagnostica, e va rieseguita ogni volta che si tocca una delle due
// copie.
//
//   Differenze := TCalcoloPeriodiVerifiche.Esegui(Config.Database);
//   try
//     if Differenze.Count = 0 then
//       ShowMessage('Delphi e Firebird calcolano gli stessi periodi.')
//     else
//       ShowMessage(Differenze.Text);
//   finally
//     Differenze.Free;
//   end;

interface

uses
  System.Classes,
  FireDAC.Comp.Client;

type
  TCalcoloPeriodiVerifiche = class
  public
    // Una riga per ogni differenza trovata. Elenco vuoto: le due copie
    // coincidono su tutti i casi di prova. Chi chiama libera l'elenco.
    class function Esegui(const Connessione: TFDConnection): TStringList;
  end;

implementation

uses
  System.SysUtils,
  System.DateUtils,
  CalcoloPeriodi.Lib;

type
  TCasoDiProva = record
    Descrizione: string;
    DataInizio: TDate;
    DataFine: TDate;
  end;

function CasiDiProva: TArray<TCasoDiProva>;

  function Caso(const Descrizione: string; const Anno1, Mese1, Giorno1, Anno2, Mese2, Giorno2: Word): TCasoDiProva;
  begin
    Result.Descrizione := Descrizione;
    Result.DataInizio := EncodeDate(Anno1, Mese1, Giorno1);
    Result.DataFine := EncodeDate(Anno2, Mese2, Giorno2);
  end;

begin
  // I casi non sono decorativi: ognuno copre un punto in cui le due copie
  // potrebbero divergere in silenzio.
  Result := [Caso('un solo giorno', 2026, 3, 10, 2026, 3, 10),
             Caso('mese intero', 2026, 1, 1, 2026, 1, 31),
             Caso('cambio di mese di un giorno', 2026, 1, 31, 2026, 2, 1),
             Caso('meno di una settimana', 2026, 1, 1, 2026, 1, 3),
             Caso('mezza settimana esatta', 2026, 1, 1, 2026, 1, 4),
             Caso('semestre', 2026, 1, 1, 2026, 6, 30),
             Caso('anno intero', 2026, 1, 1, 2026, 12, 31),
             Caso('anno bisestile su febbraio', 2028, 1, 15, 2028, 2, 29),
             Caso('a cavallo di due anni', 2025, 11, 20, 2026, 3, 15),
             Caso('frazione di mese', 2026, 1, 1, 2026, 3, 15),
             Caso('date invertite', 2026, 3, 15, 2026, 1, 1)];
end;

class function TCalcoloPeriodiVerifiche.Esegui(const Connessione: TFDConnection): TStringList;
var
  Query: TFDQuery;
  Caso: TCasoDiProva;

  procedure Confronta(const Funzione: string; const Delphi, Firebird: Double);
  begin
    // Il confronto e' su due cifre decimali: MESI_BETWEEN restituisce un
    // NUMERIC(10,2), il resto sono interi.
    if Abs(Delphi - Firebird) > 0.005 then
      Result.Add(Format('%s - %s (%s / %s): Delphi %.2f, Firebird %.2f',
        [Funzione, Caso.Descrizione, DateToStr(Caso.DataInizio), DateToStr(Caso.DataFine), Delphi, Firebird]));
  end;

begin
  Result := TStringList.Create;
  try
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := Connessione;

      Query.SQL.Text := 'SELECT' + sLineBreak +
                        '    1 + DATEDIFF(DAY FROM :DAL TO :AL)   AS GIORNI,' + sLineBreak +
                        '    DATEDIFF(MONTH FROM :DAL TO :AL)     AS MESI_CALENDARIO,' + sLineBreak +
                        '    MESI_BETWEEN(:DAL, :AL)              AS MENSILITA' + sLineBreak +
                        'FROM' + sLineBreak +
                        '    RDB$DATABASE';

      for Caso in CasiDiProva do
      begin
        Query.Close;
        Query.ParamByName('DAL').AsDate := Caso.DataInizio;
        Query.ParamByName('AL').AsDate := Caso.DataFine;
        Query.Open;

        Confronta('1 + DATEDIFF(DAY)', TCalcoloPeriodi.Giorni(Caso.DataInizio, Caso.DataFine), Query.FieldByName('GIORNI').AsFloat);
        Confronta('DATEDIFF(MONTH)', TCalcoloPeriodi.MesiCalendario(Caso.DataInizio, Caso.DataFine), Query.FieldByName('MESI_CALENDARIO').AsFloat);
        Confronta('MESI_BETWEEN', TCalcoloPeriodi.Mensilita(Caso.DataInizio, Caso.DataFine), Query.FieldByName('MENSILITA').AsFloat);
      end;
    finally
      Query.Free;
    end;
  except
    Result.Free;
    raise;
  end;
end;

end.
