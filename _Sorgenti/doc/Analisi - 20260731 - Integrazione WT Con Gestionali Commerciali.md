---
data: 2026-07-31
categoria: Integrazione
status: Review
sessione: "Specifiche integrazione WT con gestionali commerciali"
---

# Integrazione WT con i principali gestionali commerciali — ricognizione e progetto

## Sintesi

**Stato: Review.** Ricognizione delle specifiche di integrazione dei principali gestionali contabili in commercio, seguita dal **progetto del motore di esportazione multi-gestionale** per i tre con tracciato documentato pubblicamente (Passepartout Mexal, Zucchetti Ad Hoc, Zucchetti Gestionale 1). **Decisione:** WT produce file di importazione nel tracciato nativo del gestionale del cliente; il gestionale attivo è un dato di configurazione per azienda, sostituibile nel tempo senza perdita di storico né di corrispondenze. Schema database, unit del motore e ponte WT consegnati in questa cartella (`sql\`, `src\`), non compilati.

## 1. Quadro comparativo dei gestionali

| Gestionale | Canale di integrazione | Specifiche pubbliche | Dove |
|---|---|---|---|
| 🟢 **Passepartout Mexal / Passcom** | Caricamento prima nota e anagrafiche da file ASCII/CSV (file separati per testate, righe, dati Intra, analitica) | ✅ Manuale completo e pubblico | edupass.it |
| 🟢 **Zucchetti Gestionale 1** | Procedura "Import Dati": piano dei conti, anagrafiche, causali, prima nota — formati `LEMCO` (ordinaria) / `LEMSE` (semplificata) | ✅ Help pubblico (procedura); tracciato campo per campo da richiedere | gestionale1.it/help |
| 🟢 **Zucchetti Ad Hoc Enterprise / Revolution** | Modulo "Import Dati": file ASCII a lunghezza fissa con tracciati record configurabili e precaricati | ✅ Manuale PDF pubblico (158 pagine) | adhocenter.com |
| 🟡 **Zucchetti Gestionale 2** | Tracciati ufficiali di import (Excel/CSV/XML); import paghe da file sequenziale `TRPWCO` a 656 caratteri | ⚠️ Repository manuali con accesso da cliente/partner | g2web.zucchetti.it |
| 🟡 **TeamSystem (Alyante / Gamma)** | Import prima nota con tracciato `IMPPN` (file `.dat`) | ⚠️ Il tracciato circola ma non è pubblicato in chiaro | — |
| 🔴 **Onda / Onda iGes / Onda Vision** | Import movimenti contabili presente nel prodotto | ❌ Documentazione riservata ai partner | — |
| 🔴 **Sistemi eSOLVER / PROFIS** | Import con tracciato nativo che l'applicazione esterna deve produrre | ❌ Specifiche via concessionari | — |

Precisazioni: le "API pubbliche" Zucchetti riguardano solo l'infrastruttura in nuvola (Servizi-IT); l'unica interfaccia REST aperta del settore è la fattura elettronica (Digital Hub, TS Digital Invoice), ambito già coperto da WT con FatturaPA.

## 2. Fatti verificati sui tracciati (prima ondata)

### 2.1 Passepartout Mexal / Passcom — verificato su edupass.it
- Funzione "Caricamento ASCII (CSV) > Prima nota": **accoda** le registrazioni e aggiorna i progressivi Dare/Avere come l'immissione manuale.
- **Quattro file** per la prima nota: testate, testate dati Intra, righe, righe di contabilità analitica (gli ultimi due facoltativi).
- Separatore configurabile: `;` `:` `,`. File righe preferibilmente **ordinato per chiave primaria** ("file righe allineato = S", altrimenti l'import rilegge il file per ogni documento).
- Opzioni lato Mexal: import di prova (definitivo = N), protocollo IVA automatico, aggiornamento scadenzario.
- 📋 Il tracciato campo per campo è nel manuale completo scaricabile da edupass (capitolo "tracciati record").

### 2.2 Zucchetti Ad Hoc — verificato sul manuale "Procedure di Import" Release 7.0
- File ASCII a **lunghezza fissa** (formato SDF), record chiusi da CR+LF.
- Numerici: allineati a destra, virgola decimale (accettato anche il punto), niente separatore migliaia, `-` davanti alla prima cifra, campo del valore zero anche vuoto. Alfanumerici: a sinistra, spazi a destra, eccedenze troncate. Date: `AAAAMMGG`.
- Tracciati record multipli: **tipo record nei primi 2 caratteri**; testata/corpo legati dai **primi 10 caratteri** del record.
- Destinazione prima nota: `PNT_MAST` (testata: `PNCODESE`, `PNDATREG`, `PNCODCAU`, `PNNUMDOC`, `PNDATDOC`, `PNCODCLF`, `PNTOTDOC`, ...) e `PNT_DETT` (righe: `PNTIPCON`, `PNCODCON`, `PNIMPDAR`, `PNIMPAVE`, `PNDESRIG`, ...).
- 🔴 Avvertenza dell'appendice 5-13: righe consecutive con lo **stesso conto** vengono saldate in una riga sola dall'import — l'esportatore deve emettere una riga per conto/sezione.
- 📋 Posizioni e larghezze esatte: le pagine dell'appendice sono immagini; si ricavano dalla funzione "Stampa Tracciati Records" di un'installazione Ad Hoc (tracciati standard precaricati).

### 2.3 Zucchetti Gestionale 1 — verificato sull'help pubblico
- La procedura "Import Dati" importa piano dei conti, anagrafiche clienti/fornitori, causali e prima nota in formato `LEMCO`/`LEMSE`.
- Richiede la "tabella di conversione" dei mastri: la controparte lato WT è `ESPORTAZIONI_CONTABILI_CORRISPONDENZE`.
- 📋 L'help documenta la procedura ma **non** pubblica il tracciato: da richiedere all'assistenza Zucchetti o da ricavare da un export di esempio del Collegamento Studio. L'esportatore consegnato è uno scheletro disattivato che segnala il tracciato mancante.

## 3. Architettura

Il requisito guida è il **cambio di gestionale nel tempo**: la soluzione replica lo schema multi-fornitore già in produzione per `OBJ_FILES_PROTOCOLLO_*`.

| Requisito | Risposta nel progetto |
|---|---|
| Il cliente cambia gestionale | `ESPORTAZIONI_CONTABILI_CONFIGURAZIONE` indica solo il gestionale **attivo**: il cambio è un aggiornamento di una riga |
| Non perdere il lavoro di mappatura | Corrispondenze e parametri sono chiavati **per gestionale**: quelli del vecchio restano, un ritorno indietro li ritrova |
| Storico leggibile dopo il cambio | Ogni riga di `ESPORTAZIONI_CONTABILI_REGISTRAZIONI` ricorda il gestionale con cui fu prodotta |
| Aggiungere un gestionale | Una riga in `ESPORTAZIONI_CONTABILI_GESTIONALI` + una unit esportatore registrata: **nessun DDL** |
| Evitare doppie esportazioni | `ESPORTAZIONI_CONTABILI_REGISTRAZIONI_DOCUMENTI` traccia i documenti WT inclusi in ogni file |

```
WT (incassi, fatture emesse, anagrafiche contribuenti)
        |
        v
WT.EsportazioneContabile.Bridge (DataModule ponte)
  - legge configurazione, corrispondenze, parametri
  - implementa IzCorrispondenzeContabili
        |
        v
EsportazioneContabile.Registry ---> crea l'esportatore dal codice GESTIONALE
        |
        +--> EsportazioneContabile.Mexal        (CSV testate+righe, separatore configurabile)
        +--> EsportazioneContabile.AdHoc        (SDF lunghezza fissa, chiave 10 caratteri)
        +--> EsportazioneContabile.Gestionale1  (LEMCO/LEMSE - in attesa del tracciato)
        |
        v
File nella CARTELLA_DESTINAZIONE + registro esportazioni (stati sotto)
```

Una corrispondenza mancante **ferma l'esportazione** con errore esplicito: nessun codice non mappato deve finire silenziosamente nel file.

## 4. Matrice degli stati (`ESPORTAZIONI_CONTABILI_STATO`)

| Codice | Descrizione | Innesco | Transizioni ammesse | Spiegazione logica |
|---|---|---|---|---|
| `G` | Generata | File scritti senza errori | → `C`, → `A` | Il file esiste ma non è ancora entrato nel gestionale: la consegna è un atto dell'operatore |
| `C` | Consegnata | Conferma dell'operatore dopo l'import nel gestionale | → `A` | Chiude il ciclo; i documenti inclusi risultano esportati ai controlli anti-doppione |
| `A` | Annullata | Annullamento manuale | — | Libera i documenti inclusi per una nuova esportazione (l'import di prova del gestionale ha scartato il file, o il file è stato rifatto) |
| `E` | Errore | Eccezione durante la generazione | → `A` | Corrispondenza mancante o file non scrivibile; il messaggio resta in `MESSAGGIO` |

## 5. Impatto tecnico e artefatti

### 🗄️ Database — `sql\01 - Domini e tabelle ESPORTAZIONI_CONTABILI.sql` (non eseguito)
| Oggetto | Ruolo |
|---|---|
| `ESPORTAZIONI_CONTABILI_GESTIONALI` | Tabella di appoggio dei gestionali (prima ondata: `MEXAL`, `ADHOC`, `GESTIONALE1`) |
| `ESPORTAZIONI_CONTABILI_CONFIGURAZIONE` | Gestionale attivo e cartella di destinazione per azienda |
| `ESPORTAZIONI_CONTABILI_CONFIG_PARAMETRI` | Parametri chiave/valore per gestionale (es. `SEPARATORE` Mexal) |
| `ESPORTAZIONI_CONTABILI_CORRISPONDENZE` | Conti, causali, codici IVA e pagamenti WT → codici del gestionale |
| `ESPORTAZIONI_CONTABILI_REGISTRAZIONI` (+`_FILES`, +`_DOCUMENTI`) | Registro delle esportazioni, file prodotti, documenti inclusi |
| Domini `ESPORTAZIONI_CONTABILI_*` | `CONTENUTO` (PRN/ANA/SCA), `STATO` (G/C/A/E), `TIPO_CORRISPONDENZA`, con commenti picklist |

Riusa i domini WT esistenti (`AUTO_INC`, `FOREIGN_KEY`, `USR_ID`, `TRUE_FALSE`, `MEMO`, ...). Indici secondari, trigger e procedure demandati a uno script successivo.

### 💻 Codice e logica applicativa — `src\` (non compilato)
| Unit | Titolare | Contenuto |
|---|---|---|
| `EsportazioneContabile.Types.pas` | Luca Zebro | `TzMovimentoContabile`/`TzRigaContabile`, `IzEsportatoreContabile`, `IzCorrispondenzeContabili` |
| `EsportazioneContabile.Base.pas` | Luca Zebro | Formattazione SDF e CSV secondo le convenzioni verificate (numeri, date `AAAAMMGG`, ANSI + CR/LF) |
| `EsportazioneContabile.Registry.pas` | Luca Zebro | Registro codice gestionale → classe esportatore |
| `EsportazioneContabile.Mexal.pas` | Luca Zebro | CSV testate+righe, righe sempre allineate; 📋 colonne da allineare al tracciato record ufficiale |
| `EsportazioneContabile.AdHoc.pas` | Luca Zebro | SDF con tipo record (2 car.) + chiave (8 car.), campi `PNT_MAST`/`PNT_DETT`; 📋 larghezze da "Stampa Tracciati Records" |
| `EsportazioneContabile.Gestionale1.pas` | Luca Zebro | Scheletro disattivato in attesa del tracciato LEMCO/LEMSE |
| `WT.EsportazioneContabile.Bridge.pas` | Softline S.r.l. | DataModule ponte: configurazione, corrispondenze, creazione esportatore; 📋 query da completare in IDE |

Il motore non dipende da unit applicative: l'aggancio a `Config`/`AziendaDiLavoro` sta solo nel ponte, come da convenzione. I flussi a tracciato fisso hanno un precedente interno nei moduli CBI/SEPA (`Varie/CBI*.pas`, `Varie/SEPA*.pas`).

### 🖥️ Interfaccia utente — da realizzare
- Procedura guidata `WizEsportazioneContabile` (modello `Wiz*` esistente): periodo, contenuto, anteprima dei documenti, generazione, conferma di consegna.
- Form di configurazione per corrispondenze e parametri (candidata alla generazione da metadati LZ).

## 6. Quadro decisionale

- ✅ Canale unico: file di importazione nel tracciato nativo; niente API.
- ✅ Architettura multi-gestionale sul modello `OBJ_FILES_PROTOCOLLO_*`; il cambio di gestionale è configurazione, non sviluppo.
- ✅ Prima ondata: Mexal, Ad Hoc, Gestionale 1. Gli altri si aggiungono con un inserimento in tabella + una unit, quando il tracciato arriva dal rivenditore.
- ✅ Corrispondenza mancante = esportazione bloccata con errore esplicito.
- 📋 Aperto: quali contenuti esporta WT nel primo rilascio (prima nota degli incassi? fatture emesse? anagrafiche?) — dipende dal primo caso reale.
- 📋 Aperto: recupero dei tracciati campo per campo — Mexal (manuale completo edupass), Ad Hoc ("Stampa Tracciati Records"), Gestionale 1 (assistenza Zucchetti).
- 📋 Aperto: verifica che i domini WT riusati (`STR_100` per i percorsi, `OID`) esistano con questi nomi anche nel database di destinazione.

## 7. Fonti

| Fonte | Contenuto |
|---|---|
| [Prima nota da ASCII/CSV — manuale Passcom/Mexal](https://www.edupass.it/manuali/manualistica-mexal/manuale-prodotto?a=manuale-prodotto/servizi/trasferimento-archivi/caricamento-ascii-csv/prima-nota) | Funzione di caricamento, quattro file, separatori, opzioni (letto il 31/07/2026) |
| [Manuale "Procedure di Import" Ad Hoc Enterprise R7.0 (PDF)](https://www.adhocenter.com/wp-content/uploads/2016/07/Import_Dati-1.pdf) | Convenzioni ASCII/SDF, tracciati record, campi `PNT_MAST`/`PNT_DETT` (letto il 31/07/2026) |
| [Import Dati LEMCO/LEMSE — help Gestionale 1](http://www.gestionale1.it/help/Content/STUDIO/zuc_lemImport_Dati.html) | Procedura di import e tabella di conversione mastri |
| [Import paghe TRPWCO — manuale G2 (PDF)](https://g2web.zucchetti.it/softweare/REPOSITORY/Manuali_G2/pdf/contabilita'/g2_pagheweb.pdf) | Esempio di tracciato sequenziale G2 (656 caratteri) |
| [Esportazione verso TeamSystem — Cloud Finance](https://help.cloudfinance.it/guida-online/esportazione-verso-team-system/) | Uso del tracciato `IMPPN` da software terzo |
| [Le integrazioni di eSOLVER — Sistemi](https://www.sistemi.com/software-gestionali/esolver/le-integrazioni-di-esolver/) | Import con tracciato definibile, senza specifiche pubbliche |
| [Scheda prodotto Onda — Zucchetti](https://www.zucchetti.it/website/cms/prodotto/8075-onda.html) | Solo materiale commerciale |
| [API pubbliche Servizi-IT — help Zucchetti](https://help.zucchetti.it/cms/kb/soluzioni/servizi-it/api-pubbliche) | Le API Zucchetti pubbliche riguardano solo l'infrastruttura in nuvola |
| `D:\AI\SRC\varie\OBJ_FILES\01_domini_e_tabelle.sql` | Modello interno multi-fornitore replicato dallo schema |
