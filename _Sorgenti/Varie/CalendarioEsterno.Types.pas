// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-22
// ---------------------------------------------------------------------------
unit CalendarioEsterno.Types;

// Tipi comuni ai calendari esterni (Outlook, Google Calendar) da allineare con
// un'agenda: evento, profilo dell'account, errori e interfaccia del fornitore.
// Non dipende dall'applicazione: chi sincronizza parla solo con ICalendarioEsterno.

interface

uses
  System.SysUtils,
  System.Generics.Collections;

type
  ECalendarioEsterno = class(Exception)
  public
    StatoHttp: Integer;
  end;

  // Lo stato della lettura delle modifiche non e' piu' valido: va ripresa da capo
  ECalendarioEsternoLetturaScaduta = class(ECalendarioEsterno);

  TEventoEsterno = record
    Id: string;
    // versione dell'evento (changeKey di Outlook, etag di Google): cambia a ogni modifica
    Versione: string;
    Oggetto: string;
    Note: string;
    // ora locale
    Inizio: TDateTime;
    Fine: TDateTime;
    UltimaModifica: TDateTime;
    GiornataIntera: Boolean;
    Annullato: Boolean;
    // cancellato nel calendario esterno: solo Id e' valorizzato
    Rimosso: Boolean;
  end;

  TProfiloEsterno = record
    Mail: string;
    NomeAccesso: string;
    Nome: string;
  end;

  ICalendarioEsterno = interface
    ['{CE19B5EC-1543-486B-A3FB-CCA7CBE63923}']
    // nome per l'utente: "Outlook", "Google Calendar"
    function NomeServizio: string;

    // Accesso con il refresh token salvato; se non basta e Interattiva e' vero,
    // nel browser. Errore: testo per l'utente quando l'accesso non riesce
    function Accedi(const RefreshToken: string; const Interattiva: Boolean; out Errore: string): Boolean;
    // refresh token attuale, da salvare: il servizio puo' cambiarlo a ogni rinnovo
    function RefreshToken: string;
    function Profilo: TProfiloEsterno;

    // Eventi cambiati dall'ultima lettura (Stato vuoto = tutti quelli fra Dal e Al).
    // Al ritorno Stato e' quello da usare la volta successiva.
    // Gli eventi ricorrenti arrivano gia' divisi nelle singole occorrenze.
    procedure LeggiModifiche(var Stato: string; const Dal, Al: TDate; Eventi: TList<TEventoEsterno>);

    function CreaEvento(const Evento: TEventoEsterno): TEventoEsterno;
    // ConNote = False lascia com'e' il testo dell'evento nel calendario esterno.
    // Evento non piu' presente: ECalendarioEsterno con StatoHttp 404 o 410
    function AggiornaEvento(const Evento: TEventoEsterno; const ConNote: Boolean): TEventoEsterno;
    // Falso se l'evento non c'era gia' piu'
    function EliminaEvento(const Id: string): Boolean;
  end;

implementation

end.
