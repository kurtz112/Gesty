---
data: 2026-08-01
categoria: Progetti
status: WIP
sessione: "Contabilità Gesty - Moduli Delphi"
---

## Sintesi

Elenco dei DataModule e delle form Delphi necessari per portare il nucleo contabile COGE nell'interfaccia di Gesty: 9 coppie dm/frm nuove e 6 moduli esistenti da modificare. Rispetto alla prima stesura, le sette coppie di sola configurazione (piano dei conti, causali, esercizi, sezionali, aliquote/registri IVA, modalità/termini di pagamento, conti finanziari) sono state accorpate in un unico modulo `dmContabilitaConfigurazione` + `frmContabilitaConfigurazione`, su richiesta esplicita per ridurre il numero di moduli. Nessun file Delphi è stato scritto: è solo la mappa dei moduli, da usare come base per la stima e per l'ordine di sviluppo.

## Moduli da aggiungere

| DataModule + Form | Descrizione | Tabelle di riferimento |
|---|---|---|
| dmContabilitaConfigurazione + frmContabilitaConfigurazione | Modulo unico per tutte le tabelle di sola configurazione: albero dei conti, causali e relative righe, esercizi contabili, sezionali di numerazione, aliquote e registri IVA, modalità e termini di pagamento, conti finanziari. Nella form una pagina per gruppo (tab o navigatore ad albero DevExpress), un solo DataModule con un `TzFbDataSet` per tabella | COGE_CONTI, COGE_CAUSALI, COGE_CAUSALI_RIGHE, COGE_ESERCIZI, COGE_SEZIONALI, COGE_ALIQUOTE_IVA, COGE_REGISTRI_IVA, COGE_MODALITA_PAGAMENTO, COGE_TERMINI_PAGAMENTO, COGE_CONTI_FINANZIARI |
| dmContabilitaSoggetti + frmContabilitaSoggetti | Anagrafica fiscale unificata, collegamento ad Anagrafe/Aziende/Enti/Risorse | COGE_SOGGETTI, COGE_SOGGETTI_COORDINATE_BANCARIE |
| dmContabilitaDocumenti + frmContabilitaDocumenti | Testata e righe documento, emissione, storno | COGE_DOCUMENTI, COGE_DOCUMENTI_RIGHE, COGE_DOCUMENTI_IVA, COGE_DOCUMENTI_SCADENZE, COGE_DOCUMENTI_RITENUTE |
| dmContabilitaRegistrazioni + frmContabilitaRegistrazioni | Prima nota, libro giornale | COGE_REGISTRAZIONI, COGE_REGISTRAZIONI_MOVIMENTI |
| dmContabilitaIncassi + frmContabilitaIncassi | Incassi e pagamenti, riconciliazione delle scadenze | COGE_DOCUMENTI_SCADENZE, COGE_REGISTRAZIONI (via COGE_INCASSO_REGISTRA) |
| dmFatturaElettronicaConfigurazione + frmFatturaElettronicaConfigurazione | Fornitore di trasmissione attivo e dati fiscali del cedente | COGE_FATTURE_ELETTRONICHE_CONFIGURAZIONE, COGE_FATTURE_ELETTRONICHE_CONFIG_PARAMETRI, COGE_FATTURE_ELETTRONICHE_FORNITORI, COGE_FATTURE_ELETTRONICHE_DATI_CEDENTE |
| dmFatturaElettronicaMonitor + frmFatturaElettronicaMonitor | Stato degli invii e delle notifiche SDI | COGE_FATTURE_ELETTRONICHE, COGE_FATTURE_ELETTRONICHE_INVII, COGE_FATTURE_ELETTRONICHE_NOTIFICHE, COGE_FATTURE_ELETTRONICHE_LOG_REQUEST, COGE_FATTURE_ELETTRONICHE_LOG_RESPONSE |
| WizEsportazioneContabileDM + WizEsportazioneContabileFrm | Procedura guidata di esportazione verso il gestionale del cliente (Mexal/Ad Hoc) | COGE_REGISTRAZIONI, tabelle ponte ESPORTAZIONI_CONTABILI_* (consegna 20260731-integrazione-gestionali-commerciali) |
| dmContabilitaBilancino + frmContabilitaBilancino | Stampa della situazione conti e del bilancino di verifica | COGE_CONTI, COGE_REGISTRAZIONI_MOVIMENTI |

Non accorpato nel modulo di configurazione: `dmFatturaElettronicaConfigurazione`, perché tratta un dominio diverso (fornitore di trasmissione e dati fiscali del cedente per la fattura elettronica, non il piano dei conti) e resta già isolato come da documento sulle tabelle di fattura elettronica.

## Moduli da modificare

| DataModule / Form | Modifica prevista | Tabelle di riferimento |
|---|---|---|
| dmAziende / frmAziende | Collegamento a COGE_SOGGETTI e pulsante "genera documento contabile" | COGE_SOGGETTI |
| Form/DataModule delle iscrizioni ai progetti (nome reale da individuare sul .dpr) | Generazione automatica del documento da rette e quote | COGE_DOCUMENTI (via COGE_DOCUMENTO_GENERA_DA_SERVIZI_SAL, COGE_DOCUMENTO_GENERA_DA_AUTORIZZAZIONE) |
| dmDocumentazioneCruscotto / frmDocumentazioneCruscotto | Aggiungere lo stato della fattura elettronica accanto agli altri motori documentali | COGE_FATTURE_ELETTRONICHE |
| dmCommon (Gesty.Globals) | Esporre l'ente e l'esercizio contabile corrente ai nuovi DataModule | Nessuna tabella diretta - contesto applicativo |
| ConfigModule (TConfig) | Estendere il modello di sicurezza con i permessi sulla contabilità | Nessuna tabella COGE diretta - modello di sicurezza TzSystem |
| Gesty.EsportazioneContabile.Bridge (consegna precedente sui gestionali commerciali) | Ricollegarlo al nucleo COGE al posto della fonte dati provvisoria con cui era stato scritto | COGE_REGISTRAZIONI, ESPORTAZIONI_CONTABILI_* |

## Nota

L'elenco è una proposta di impostazione, non una verifica sul codice: i nomi nuovi seguono le convenzioni di Gesty (dm*/frm*/Wiz*), quelli esistenti (dmAziende, frmAziende, dmCommon, ConfigModule, dmDocumentazioneCruscotto) sono stati confermati sui sorgenti reali in D:\AI\SRC\Gesty. Il modulo delle iscrizioni ai progetti resta da individuare con una ricerca sul file Gesty.dpr prima di iniziare lo sviluppo.
