// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-23
// ---------------------------------------------------------------------------
unit CalcoloAbitare.Lib;

// I totali degli interventi di Abitare Emergenza, calcolati in Delphi.
//
// Serve a una cosa sola: sapere, mentre il record e' ancora nel buffer del
// client, quanto verrebbe un totale con i valori appena digitati. Da li' nasce
// la domanda all'operatore quando quel totale era stato scritto a mano.
//
// Sono replicate solo le quattro formule degli importi FORZABILI, perche' sono
// le sole su cui si puo' chiedere qualcosa. Gli altri valori calcolati servono
// a mostrare e li fornisce la vista.
//
// OGNI FUNZIONE E' LA COPIA DI UN OGGETTO DEL DATABASE, dichiarato nel commento
// che la precede con la riga
//
//     // DB: <tipo> <nome> -> <uscita>
//
// Una ricerca di "// DB:" su tutto il progetto restituisce l'elenco completo di
// quello che il client replica. Il confronto automatico fra le due copie sta in
// CalcoloAbitare.Verifiche.
//
// Le funzioni sono pure: ricevono valori, non TField, e non toccano il database.
// Il DataModule legge il buffer e passa i valori.

interface

type
  // I valori digitati su una scheda di Pronto Intervento, nella versione
  // prevista o in quella effettiva. Le due versioni hanno la stessa struttura,
  // e la sola differenza e' la data di fine.
  TValoriProntoIntervento = record
    DataInizio: TDateTime;
    DataFine: TDateTime;
    ImportoGiornaliero: Currency;
    SpesePuliziaMensili: Currency;
    AltreSpesePulizia: Currency;
    TassaSoggiorno: Currency;
    AltriImporti: Currency;
  end;

  // I valori digitati su una scheda di Progetto, in una delle due versioni
  TValoriProgetto = record
    DataInizio: TDateTime;
    DataFine: TDateTime;
    ImportoMensileAlloggio: Currency;
    AltriImportiAlloggio: Currency;
    OreEducativeMensili: Double;
    CostoOrarioOreEducative: Currency;
    PacchettoOreMediazione: Double;
    CostoOrarioMediazione: Currency;
    PacchettoOreEducatoreFinanziario: Double;
    CostoOrarioEducatoreFinanziario: Currency;
    CostiVari: Currency;
  end;

  TCalcoloAbitare = class
  public
    // Pronto Intervento
    class function SpesePuliziaTotaliPreviste(const Valori: TValoriProntoIntervento): Currency;
    class function SpesePuliziaTotaliEffettive(const Valori: TValoriProntoIntervento): Currency;
    class function PrevisioneDiSpesa(const Valori: TValoriProntoIntervento): Currency;
    class function TotaleSpesaEffettiva(const Valori: TValoriProntoIntervento): Currency;
    // Progetti
    class function TotaleCostiAlloggio(const Valori: TValoriProgetto): Currency;
    class function TotaleCostiEducativi(const Valori: TValoriProgetto): Currency;
    class function TotaleCostiIntervento(const Valori: TValoriProgetto): Currency;
  end;

implementation

uses
  CalcoloPeriodi.Lib;

// DB: TABLE ABITARE_EMERGENZA_PRONTO_INTERVENTO -> SPESE_PULIZIA_TOTALI_PREVISTE
//     (fino alla migrazione e' una colonna COMPUTED BY; dopo, un'uscita della
//      procedura ABITARE_EMERGENZA_PRONTO_INTERVENTO_DETAIL)
//
//   (SPESE_PULIZIA_MENSILI_PREVISTE * (DATEDIFF(MONTH FROM DATA_INIZIO_PROGETTO TO DATA_FINE_PROGETTO_PREVISTA)))
//   + ALTRE_SPESE_PULIZIA_PREVISTE
//
// ATTENZIONE: qui il conteggio dei mesi e' senza "1 +", mentre la colonna
// gemella EFFETTIVE ce l'ha. La differenza e' nel database ed e' riprodotta
// fedelmente: correggerla sposterebbe valori gia' registrati, ed e' una delle
// decisioni in sospeso.
class function TCalcoloAbitare.SpesePuliziaTotaliPreviste(const Valori: TValoriProntoIntervento): Currency;
begin
  Result := (Valori.SpesePuliziaMensili * TCalcoloPeriodi.MesiCalendario(Valori.DataInizio, Valori.DataFine)) + Valori.AltreSpesePulizia;
end;

// DB: TABLE ABITARE_EMERGENZA_PRONTO_INTERVENTO -> SPESE_PULIZIA_TOTALI_EFFETTIVE
//
//   (SPESE_PULIZIA_MENSILI_EFFETTIVE * (1 + DATEDIFF(MONTH FROM DATA_INIZIO_PROGETTO TO DATA_FINE_PROGETTO_EFFETTIVA)))
//   + ALTRE_SPESE_PULIZIA_EFFETTIVE
class function TCalcoloAbitare.SpesePuliziaTotaliEffettive(const Valori: TValoriProntoIntervento): Currency;
begin
  Result := (Valori.SpesePuliziaMensili * (1 + TCalcoloPeriodi.MesiCalendario(Valori.DataInizio, Valori.DataFine))) + Valori.AltreSpesePulizia;
end;

// DB: TABLE ABITARE_EMERGENZA_PRONTO_INTERVENTO -> PREVISIONE_DI_SPESA
//
//   (TOTALE_GIORNI_COLLOCAMENTO_PREVISTI * IMPORTO_GIORNALIERO_PREVISTO)
//   + SPESE_PULIZIA_TOTALI_PREVISTE + TASSA_SOGGIORNO_PREVISTA + ALTRI_IMPORTI_PREVISTI
//
// dove TOTALE_GIORNI_COLLOCAMENTO_PREVISTI e' GIORNI_BETWEEN(inizio, fine prevista).
class function TCalcoloAbitare.PrevisioneDiSpesa(const Valori: TValoriProntoIntervento): Currency;
begin
  Result := (TCalcoloPeriodi.Giorni(Valori.DataInizio, Valori.DataFine) * Valori.ImportoGiornaliero) + SpesePuliziaTotaliPreviste(Valori) +
    Valori.TassaSoggiorno + Valori.AltriImporti;
end;

// DB: TABLE ABITARE_EMERGENZA_PRONTO_INTERVENTO -> TOTALE_SPESA_EFFETTIVA
//
//   (TOTALE_GIORNI_COLLOCAMENTO_EFFETTIVI * IMPORTO_GIORNALIERO_EFFETTIVO)
//   + SPESE_PULIZIA_TOTALI_EFFETTIVE + TASSA_SOGGIORNO_EFFETTIVA + ALTRI_IMPORTI_EFFETTIVI
class function TCalcoloAbitare.TotaleSpesaEffettiva(const Valori: TValoriProntoIntervento): Currency;
begin
  Result := (TCalcoloPeriodi.Giorni(Valori.DataInizio, Valori.DataFine) * Valori.ImportoGiornaliero) + SpesePuliziaTotaliEffettive(Valori) +
    Valori.TassaSoggiorno + Valori.AltriImporti;
end;

// DB: TABLE ABITARE_EMERGENZA_PROGETTI -> TOTALE_COSTI_ALLOGGIO_PREVISTO / _EFFETTIVO
//
//   (MENSILITA_* * IMPORTO_MENSILE_ALLOGGIO_*) + ALTRI_IMPORTI_ALLOGGIO_*
//
// dove MENSILITA_* e' MESI_BETWEEN(inizio, fine), con la frazione dell'ultimo mese.
class function TCalcoloAbitare.TotaleCostiAlloggio(const Valori: TValoriProgetto): Currency;
begin
  Result := (TCalcoloPeriodi.Mensilita(Valori.DataInizio, Valori.DataFine) * Valori.ImportoMensileAlloggio) + Valori.AltriImportiAlloggio;
end;

// DB: TABLE ABITARE_EMERGENZA_PROGETTI -> TOTALE_COSTI_EDUCATIVI_PREVISTI / _EFFETTIVI
//
//   COSTI_TOTALI_ORE_EDUCATIVE_* + COSTO_TOTALE_MEDIAZIONE_* + COSTO_TOTALE_EDUCATORE_FINANZIARIO_*
//
// a loro volta:
//   COSTI_TOTALI_ORE_EDUCATIVE_*        = ORE_EDUCATIVE_MENSILI_DA_PROGETTO_* * COSTO_ORARIO_ORE_EDUCATIVE_* * MENSILITA_*
//   COSTO_TOTALE_MEDIAZIONE_*           = PACCHETTO_ORE_MEDIAZIONE_* * COSTO_ORARIO_MEDIAZIONE_*
//   COSTO_TOTALE_EDUCATORE_FINANZIARIO_* = PACCHETTO_ORE_EDUCATORE_FINANZIARIO_* * COSTO_ORARIO_EDUCATORE_FINANZIARIO_*
class function TCalcoloAbitare.TotaleCostiEducativi(const Valori: TValoriProgetto): Currency;
var
  OreEducative: Currency;
  Mediazione: Currency;
  EducatoreFinanziario: Currency;
begin
  OreEducative := Valori.OreEducativeMensili * Valori.CostoOrarioOreEducative * TCalcoloPeriodi.Mensilita(Valori.DataInizio, Valori.DataFine);
  Mediazione := Valori.PacchettoOreMediazione * Valori.CostoOrarioMediazione;
  EducatoreFinanziario := Valori.PacchettoOreEducatoreFinanziario * Valori.CostoOrarioEducatoreFinanziario;

  Result := OreEducative + Mediazione + EducatoreFinanziario;
end;

// DB: TABLE ABITARE_EMERGENZA_PROGETTI -> TOTALE_COSTI_INTERVENTO_PREVISTI / _EFFETTIVI
//
//   TOTALE_COSTI_ALLOGGIO_* + TOTALE_COSTI_EDUCATIVI_* + COSTI_VARI_*
class function TCalcoloAbitare.TotaleCostiIntervento(const Valori: TValoriProgetto): Currency;
begin
  Result := TotaleCostiAlloggio(Valori) + TotaleCostiEducativi(Valori) + Valori.CostiVari;
end;

end.
