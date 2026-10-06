unit Gesty.Authorizations;

interface

type
  TGesty_Authorizations = record
  public const
    GESTIONE_UTENTI = 'Admin.Utenti.Gestione';
    CREAZIONE_UTENTI_SISTEMA = 'Admin.Utenti.Creazione';
    MODIFICA_RESTRIZIONI = 'Admin.Restrizioni.Modifica';

    AI_UTILIZZO = 'AI';

    AULE_PRENOTAZIONI_GESTIONE = 'Aule.Gestione';
    AULE_PRENOTAZIONI_INSERIMENTO = 'Aule.Prenotazioni.Inserimento';
    AULE_PRENOTAZIONI_MODIFICA = 'Aule.Prenotazioni.Modifica';

    BUDGET = 'Budget';

    ORARIO_ELIMINAZIONE = 'CalendarioCorsi.Eliminazione';

    INCARICHI_SUPERVISORE = 'Incarichi.Supervisore';
    INCARICHI_VERIFICA_INCONGRUITA = 'Incarichi.VerificaIncongruita';
    INCARICHI_MODIFICA_ESTENSORE = 'Incarichi.ModificaEstensore';
    INCARICHI_AUTORIZZAZIONE = 'Incarichi.Autorizzazione';
    INCARICHI_VISUALIZZAZIONE = 'Incarichi.Visualizzazione';
    INCARICHI_FORZA_ELIMINAZIONE = 'Incarichi.ForzaEliminazione';
    INCARICHI_VALUTAZIONE = 'Incarichi.Valutazione';

    RICHIESTE_ATTIV_INSERIMENTO = 'RichiesteAttivazione.Inserimento';
    RICHIESTE_ATTIV_VALUTAZIONE = 'RichiesteAttivazione.Valutazione';
    RICHIESTE_ATTIV_APPROVAZIONE = 'RichiesteAttivazione.Approvazione';

    RISORSE_RESPONSABILE = 'Risorse.Responsabile';
    RISORSE_INSERIMENTO_PRESENZE = 'Risorse.InserimentoPresenze';
    RISORSE_VALIDAZIONE_ORE_RILEVAT = 'Risorse.ValidazioneOreRilevate';
    RISORSE_SBLOCCO_ORE_RILEVAT = 'Risorse.SbloccoOreValidate';
    RISORSE_RETTIFICA_ORE_VALIDATE = 'Risorse.RettificaOreValidate';
    ORE_RECUPERO_ATTIVITA_DIVERSE = 'Risorse.OreRecuperoAttivitaDiverse';
    RISORSE_VALUTAZIONE = 'Risorse.Valutazione';
    RISORSE_PRIVACY = 'Risorse.Privacy';

    AZIENDE_INSERIMENTO = 'Aziende.Inserimento';

    REGISTRO_COLL_BLOCCA_DOCENTI = 'Registro.BloccaDocenti';
    REGISTRO_COLL_SBLOCCA_DOCENTI = 'Registro.SbloccaDocenti';
    REGISTRO_COLL_BLOCCA_STUDENTI = 'Registro.BloccaStudenti';
    REGISTRO_COLL_SBLOCCA_STUDENTI = 'Registro.SbloccaStudenti';

    PERSONALE_PRESENZE_MANUALI = 'Personale.PresenzeManuali';

    QUESTIONARI_ELIMINA_RISPOSTE = 'Questionari.EliminazioneRisposte';

    REPORT = 'Report.Modifica';
    REPORT_MODIFICA_ANTEPRIMA = 'Report.Preview.Editing';
    CUSTOMIZZA_CAPTION = 'Base.Customize.Captions';

    HELP_MODIFICA = 'Help.Modifica';

    RIUNIONI_RENDICONTAZIONE = 'Riunioni.Rendicontazione';

    FIRMA_VISUALIZZAZIONE = 'Firma.Visualizzazione';
    FIRMA_VALIDAZIONE = 'Firma.Validazione';
    FIRMA_APPROVAZIONE = 'Firma.Approvazione';

    SIUF_COOPERAZIONE_APPLICATIVA = 'SIUF - Cooperazione Applicativa';

  end;

var
  Gesty_Authorizations: TGesty_Authorizations;

implementation

end.
