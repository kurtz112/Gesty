// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-23
// ---------------------------------------------------------------------------
unit CalcoloAbitare.Verifiche;

// Confronta le quattro formule di CalcoloAbitare.Lib con quello che restituisce
// il database, su interventi veri.
//
// A differenza di CalcoloPeriodi.Verifiche, che lavora su casi costruiti, qui si
// legge il magazzino: per ogni intervento si prendono i valori digitati e il
// totale prodotto dal database, si rifa' il conto in Delphi e si confrontano.
// E' il collaudo che conta, perche' un disallineamento si manifesta sui dati
// reali molto prima che su un caso di prova.
//
// Non entra nel funzionamento normale: si richiama da una voce di diagnostica,
// e va rieseguita ogni volta che si tocca una delle due copie.
//
//   Differenze := TCalcoloAbitareVerifiche.Esegui(Config.Database, 0);
//
// Il secondo parametro limita il numero di interventi esaminati per modulo:
// zero li esamina tutti.
//
// PRIMA DELLA MIGRAZIONE alle procedure _DETAIL le colonne di confronto si
// chiamano senza il suffisso _CALCOLATA, perche' il totale e' ancora una colonna
// COMPUTED BY: togliere il suffisso dalle due SELECT qui sotto.

interface

uses
  System.Classes,
  FireDAC.Comp.Client;

type
  TCalcoloAbitareVerifiche = class
  public
    // Una riga per ogni differenza trovata. Elenco vuoto: le due copie
    // coincidono su tutti gli interventi esaminati. Chi chiama libera l'elenco.
    class function Esegui(const Connessione: TFDConnection; const MassimoInterventi: Integer = 0): TStringList;
  end;

implementation

uses
  System.SysUtils,
  Data.DB,
  CalcoloAbitare.Lib;

const
  // Le due copie lavorano su tipi diversi - Currency in Delphi, NUMERIC nel
  // database - quindi il confronto e' sul centesimo, non sull'uguaglianza.
  ScartoAmmesso = 0.005;

  SQL_PRONTO_INTERVENTO =
    'SELECT' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO.ID_PRONTO_INTERVENTO,' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO.DATA_INIZIO_PROGETTO,' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO.DATA_FINE_PROGETTO_PREVISTA,' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO.DATA_FINE_PROGETTO_EFFETTIVA,' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO.IMPORTO_GIORNALIERO_PREVISTO,' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO.SPESE_PULIZIA_MENSILI_PREVISTE,' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO.ALTRE_SPESE_PULIZIA_PREVISTE,' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO.TASSA_SOGGIORNO_PREVISTA,' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO.ALTRI_IMPORTI_PREVISTI,' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO.IMPORTO_GIORNALIERO_EFFETTIVO,' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO.SPESE_PULIZIA_MENSILI_EFFETTIVE,' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO.ALTRE_SPESE_PULIZIA_EFFETTIVE,' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO.TASSA_SOGGIORNO_EFFETTIVA,' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO.ALTRI_IMPORTI_EFFETTIVI,' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO_ELENCO.PREVISIONE_DI_SPESA_CALCOLATA,' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO_ELENCO.TOTALE_SPESA_EFFETTIVA_CALCOLATA' + sLineBreak +
    'FROM' + sLineBreak +
    '    ABITARE_EMERGENZA_PRONTO_INTERVENTO' + sLineBreak +
    '          INNER JOIN ABITARE_EMERGENZA_PRONTO_INTERVENTO_ELENCO ON' + sLineBreak +
    '                ABITARE_EMERGENZA_PRONTO_INTERVENTO_ELENCO.ID_PRONTO_INTERVENTO = ABITARE_EMERGENZA_PRONTO_INTERVENTO.ID_PRONTO_INTERVENTO' + sLineBreak +
    'ORDER BY' + sLineBreak +
    '        ABITARE_EMERGENZA_PRONTO_INTERVENTO.ID_PRONTO_INTERVENTO';

  SQL_PROGETTI =
    'SELECT' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.ID_PROGETTO,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.DATA_INIZIO_PROGETTO,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.DATA_FINE_PROGETTO_PREVISTA,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.DATA_FINE_PROGETTO_EFFETTIVA,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.IMPORTO_MENSILE_ALLOGGIO_PREVISTO,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.ALTRI_IMPORTI_ALLOGGIO_PREVISTI,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.ORE_EDUCATIVE_MENSILI_DA_PROGETTO_PREVISTE,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.COSTO_ORARIO_ORE_EDUCATIVE_PREVISTE,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.PACCHETTO_ORE_MEDIAZIONE_PREVISTO,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.COSTO_ORARIO_MEDIAZIONE_PREVISTO,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.PACCHETTO_ORE_EDUCATORE_FINANZIARIO_PREVISTO,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.COSTO_ORARIO_EDUCATORE_FINANZIARIO_PREVISTO,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.COSTI_VARI_PREVISTI,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.IMPORTO_MENSILE_ALLOGGIO_EFFETTIVO,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.ALTRI_IMPORTI_ALLOGGIO_EFFETTIVI,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.ORE_EDUCATIVE_MENSILI_DA_PROGETTO_EFFETTIVE,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.COSTO_ORARIO_ORE_EDUCATIVE_EFFETTIVE,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.PACCHETTO_ORE_MEDIAZIONE_EFFETTIVO,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.COSTO_ORARIO_MEDIAZIONE_EFFETTIVO,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.PACCHETTO_ORE_EDUCATORE_FINANZIARIO_EFFETTIVO,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.COSTO_ORARIO_EDUCATORE_FINANZIARIO_EFFETTIVO,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI.COSTI_VARI_EFFETTIVI,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI_ELENCO.TOTALE_COSTI_INTERVENTO_PREVISTI_CALCOLATI,' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI_ELENCO.TOTALE_COSTI_INTERVENTO_EFFETTIVI_CALCOLATI' + sLineBreak +
    'FROM' + sLineBreak +
    '    ABITARE_EMERGENZA_PROGETTI' + sLineBreak +
    '          INNER JOIN ABITARE_EMERGENZA_PROGETTI_ELENCO ON' + sLineBreak +
    '                ABITARE_EMERGENZA_PROGETTI_ELENCO.ID_PROGETTO = ABITARE_EMERGENZA_PROGETTI.ID_PROGETTO' + sLineBreak +
    'ORDER BY' + sLineBreak +
    '        ABITARE_EMERGENZA_PROGETTI.ID_PROGETTO';

class function TCalcoloAbitareVerifiche.Esegui(const Connessione: TFDConnection; const MassimoInterventi: Integer): TStringList;
var
  Query: TFDQuery;
  Esaminati: Integer;
  ValoriProntoIntervento: TValoriProntoIntervento;
  ValoriProgetto: TValoriProgetto;

  procedure Confronta(const Modulo: string; const Identificativo: Integer; const Totale: string; const Delphi: Currency; const CampoFirebird: TField);
  begin
    // Il totale vuoto nel database significa che una data manca: il Delphi
    // restituisce zero, e non e' una differenza da segnalare.
    if CampoFirebird.IsNull then
      Exit;

    if Abs(Delphi - CampoFirebird.AsCurrency) > ScartoAmmesso then
      Result.Add(Format('%s %d - %s: Delphi %.2f, Firebird %.2f', [Modulo, Identificativo, Totale, Delphi, CampoFirebird.AsCurrency]));
  end;

begin
  Result := TStringList.Create;
  try
    Query := TFDQuery.Create(nil);
    try
      Query.Connection := Connessione;

      // ---------------------------------------------------------------- Pronto Intervento
      Query.SQL.Text := SQL_PRONTO_INTERVENTO;
      Query.Open;
      Esaminati := 0;

      while not Query.Eof do
      begin
        ValoriProntoIntervento := Default (TValoriProntoIntervento);
        ValoriProntoIntervento.DataInizio := Query.FieldByName('DATA_INIZIO_PROGETTO').AsDateTime;

        // Previsto
        ValoriProntoIntervento.DataFine := Query.FieldByName('DATA_FINE_PROGETTO_PREVISTA').AsDateTime;
        ValoriProntoIntervento.ImportoGiornaliero := Query.FieldByName('IMPORTO_GIORNALIERO_PREVISTO').AsCurrency;
        ValoriProntoIntervento.SpesePuliziaMensili := Query.FieldByName('SPESE_PULIZIA_MENSILI_PREVISTE').AsCurrency;
        ValoriProntoIntervento.AltreSpesePulizia := Query.FieldByName('ALTRE_SPESE_PULIZIA_PREVISTE').AsCurrency;
        ValoriProntoIntervento.TassaSoggiorno := Query.FieldByName('TASSA_SOGGIORNO_PREVISTA').AsCurrency;
        ValoriProntoIntervento.AltriImporti := Query.FieldByName('ALTRI_IMPORTI_PREVISTI').AsCurrency;

        Confronta('Pronto Intervento', Query.FieldByName('ID_PRONTO_INTERVENTO').AsInteger, 'previsione di spesa',
          TCalcoloAbitare.PrevisioneDiSpesa(ValoriProntoIntervento), Query.FieldByName('PREVISIONE_DI_SPESA_CALCOLATA'));

        // Effettivo
        ValoriProntoIntervento.DataFine := Query.FieldByName('DATA_FINE_PROGETTO_EFFETTIVA').AsDateTime;
        ValoriProntoIntervento.ImportoGiornaliero := Query.FieldByName('IMPORTO_GIORNALIERO_EFFETTIVO').AsCurrency;
        ValoriProntoIntervento.SpesePuliziaMensili := Query.FieldByName('SPESE_PULIZIA_MENSILI_EFFETTIVE').AsCurrency;
        ValoriProntoIntervento.AltreSpesePulizia := Query.FieldByName('ALTRE_SPESE_PULIZIA_EFFETTIVE').AsCurrency;
        ValoriProntoIntervento.TassaSoggiorno := Query.FieldByName('TASSA_SOGGIORNO_EFFETTIVA').AsCurrency;
        ValoriProntoIntervento.AltriImporti := Query.FieldByName('ALTRI_IMPORTI_EFFETTIVI').AsCurrency;

        Confronta('Pronto Intervento', Query.FieldByName('ID_PRONTO_INTERVENTO').AsInteger, 'totale spesa effettiva',
          TCalcoloAbitare.TotaleSpesaEffettiva(ValoriProntoIntervento), Query.FieldByName('TOTALE_SPESA_EFFETTIVA_CALCOLATA'));

        Inc(Esaminati);

        if (MassimoInterventi > 0) and (Esaminati >= MassimoInterventi) then
          Break;

        Query.Next;
      end;

      // ---------------------------------------------------------------- Progetti
      Query.Close;
      Query.SQL.Text := SQL_PROGETTI;
      Query.Open;
      Esaminati := 0;

      while not Query.Eof do
      begin
        ValoriProgetto := Default (TValoriProgetto);
        ValoriProgetto.DataInizio := Query.FieldByName('DATA_INIZIO_PROGETTO').AsDateTime;

        // Previsto
        ValoriProgetto.DataFine := Query.FieldByName('DATA_FINE_PROGETTO_PREVISTA').AsDateTime;
        ValoriProgetto.ImportoMensileAlloggio := Query.FieldByName('IMPORTO_MENSILE_ALLOGGIO_PREVISTO').AsCurrency;
        ValoriProgetto.AltriImportiAlloggio := Query.FieldByName('ALTRI_IMPORTI_ALLOGGIO_PREVISTI').AsCurrency;
        ValoriProgetto.OreEducativeMensili := Query.FieldByName('ORE_EDUCATIVE_MENSILI_DA_PROGETTO_PREVISTE').AsFloat;
        ValoriProgetto.CostoOrarioOreEducative := Query.FieldByName('COSTO_ORARIO_ORE_EDUCATIVE_PREVISTE').AsCurrency;
        ValoriProgetto.PacchettoOreMediazione := Query.FieldByName('PACCHETTO_ORE_MEDIAZIONE_PREVISTO').AsFloat;
        ValoriProgetto.CostoOrarioMediazione := Query.FieldByName('COSTO_ORARIO_MEDIAZIONE_PREVISTO').AsCurrency;
        ValoriProgetto.PacchettoOreEducatoreFinanziario := Query.FieldByName('PACCHETTO_ORE_EDUCATORE_FINANZIARIO_PREVISTO').AsFloat;
        ValoriProgetto.CostoOrarioEducatoreFinanziario := Query.FieldByName('COSTO_ORARIO_EDUCATORE_FINANZIARIO_PREVISTO').AsCurrency;
        ValoriProgetto.CostiVari := Query.FieldByName('COSTI_VARI_PREVISTI').AsCurrency;

        Confronta('Progetto', Query.FieldByName('ID_PROGETTO').AsInteger, 'totale costi intervento previsti',
          TCalcoloAbitare.TotaleCostiIntervento(ValoriProgetto), Query.FieldByName('TOTALE_COSTI_INTERVENTO_PREVISTI_CALCOLATI'));

        // Effettivo
        ValoriProgetto.DataFine := Query.FieldByName('DATA_FINE_PROGETTO_EFFETTIVA').AsDateTime;
        ValoriProgetto.ImportoMensileAlloggio := Query.FieldByName('IMPORTO_MENSILE_ALLOGGIO_EFFETTIVO').AsCurrency;
        ValoriProgetto.AltriImportiAlloggio := Query.FieldByName('ALTRI_IMPORTI_ALLOGGIO_EFFETTIVI').AsCurrency;
        ValoriProgetto.OreEducativeMensili := Query.FieldByName('ORE_EDUCATIVE_MENSILI_DA_PROGETTO_EFFETTIVE').AsFloat;
        ValoriProgetto.CostoOrarioOreEducative := Query.FieldByName('COSTO_ORARIO_ORE_EDUCATIVE_EFFETTIVE').AsCurrency;
        ValoriProgetto.PacchettoOreMediazione := Query.FieldByName('PACCHETTO_ORE_MEDIAZIONE_EFFETTIVO').AsFloat;
        ValoriProgetto.CostoOrarioMediazione := Query.FieldByName('COSTO_ORARIO_MEDIAZIONE_EFFETTIVO').AsCurrency;
        ValoriProgetto.PacchettoOreEducatoreFinanziario := Query.FieldByName('PACCHETTO_ORE_EDUCATORE_FINANZIARIO_EFFETTIVO').AsFloat;
        ValoriProgetto.CostoOrarioEducatoreFinanziario := Query.FieldByName('COSTO_ORARIO_EDUCATORE_FINANZIARIO_EFFETTIVO').AsCurrency;
        ValoriProgetto.CostiVari := Query.FieldByName('COSTI_VARI_EFFETTIVI').AsCurrency;

        Confronta('Progetto', Query.FieldByName('ID_PROGETTO').AsInteger, 'totale costi intervento effettivi',
          TCalcoloAbitare.TotaleCostiIntervento(ValoriProgetto), Query.FieldByName('TOTALE_COSTI_INTERVENTO_EFFETTIVI_CALCOLATI'));

        Inc(Esaminati);

        if (MassimoInterventi > 0) and (Esaminati >= MassimoInterventi) then
          Break;

        Query.Next;
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
