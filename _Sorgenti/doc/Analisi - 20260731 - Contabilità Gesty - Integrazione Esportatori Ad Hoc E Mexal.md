---
data: 2026-07-31
categoria: Integrazione
status: Review
sessione: "Contabilità in Gesty: confronto con JForma"
---

# Integrazione del nucleo COGE con il motore di esportazione Ad Hoc e Mexal

## 1. Sintesi

⚠️ **Review.** Il motore di esportazione multi-gestionale progettato in `D:\AI\OUT\20260731-integrazione-gestionali-commerciali` **si riusa così com'è**: le unit `EsportazioneContabile.*` non hanno dipendenze applicative, quindi valgono per WT e per Gesty senza forcarle. Serve solo il ponte lato Gesty, più tre correzioni puntuali.

| Cosa | Esito |
|---|---|
| Motore, classe base, registro degli esportatori | 🟢 Riuso integrale |
| Esportatore Ad Hoc (SDF a lunghezza fissa) | 🟢 Riuso integrale |
| Esportatore Mexal (CSV testate + righe) | 🟡 Riuso, con l'aggiunta del quarto file: le righe di contabilità analitica |
| `EsportazioneContabile.Types` | 🟡 Due campi da aggiungere a `TzRigaContabile` |
| Codici dei gestionali | 🔴 Non coincidevano: corretti |
| Ponte Gesty | 🟢 Scritto |

**La scoperta che conta:** l'esportatore Mexal esistente dichiara che «Dati Intra e contabilità analitica non riguardano l'export da WinTarif». Vero per WT, **falso per Gesty**: qui ogni movimento porta il progetto e il centro di costo, ed è proprio il dato che in contabilità generale si perde. Senza il quarto file l'imputazione ai progetti si ferma sulla soglia dell'amministrazione.

---

## 2. I due modelli, messi uno accanto all'altro

| WT — `ESPORTAZIONI_CONTABILI_*` | Gesty — `COGE_INTERSCAMBIO_*` | Nota |
|---|---|---|
| `_GESTIONALI` | `_FORNITORI` | Stessa funzione; **i codici devono coincidere con quelli del registro Delphi** |
| `_CONFIGURAZIONE` (`ID_AZIENDA`) | `_CONFIGURAZIONE` (`ID_TENANT` → `ENTI`) | Il tenant di Gesty è l'ente |
| `_CONFIG_PARAMETRI` | `_CONFIG_PARAMETRI` | Identiche |
| `_CORRISPONDENZE` | `_MAPPATURE` | Codici a tre lettere in Gesty: la vista `_MOTORE` li traduce nelle parole che il motore si aspetta |
| `_REGISTRAZIONI` (stati `G`/`C`/`A`/`E`) | `_LOTTI` (stati `APE`/`PRO`/`INV`/`CHI`/`ERR`) | Stessa macchina a stati con nomi diversi, vedi §4 |
| `_REGISTRAZIONI_FILES` | 🔴 mancava → **aggiunta** `_LOTTI_FILES` | Mexal produce più file per una sola esportazione |
| `_REGISTRAZIONI_DOCUMENTI` | `_LOTTI_RIGHE` | L'anti-doppione |

Nessuna tabella va rinominata: le due applicazioni hanno database diversi e il contratto `IzCorrispondenzeContabili` è quello che le rende intercambiabili. È il ponte a sapere dove stanno i dati.

---

## 3. Le tre correzioni

### 3.1 🔴 I codici dei gestionali non coincidevano

Il registro Delphi si popola così:

```pascal
TzEsportatoriContabili.Registra('MEXAL', TzEsportatoreContabileMexal);
TzEsportatoriContabili.Registra('ADHOC', TzEsportatoreContabileAdHoc);
```

`COGE_INTERSCAMBIO_FORNITORI` era stata popolata con `PASSEPARTOUT` e `ZUC_ADHOC`. Con quei codici `TzEsportatoriContabili.Crea` non trova la classe e solleva «Nessun esportatore registrato per il gestionale». Lo script `13` allinea i codici a `MEXAL`, `ADHOC`, `GESTIONALE1`, `ONDA`.

### 3.2 🟡 `TzRigaContabile` non porta l'imputazione analitica

Due campi da aggiungere in `EsportazioneContabile.Types.pas`, dentro `TzRigaContabile`:

```pascal
    CodiceCommessa: string;         // progetto Gesty, tradotto via corrispondenze
    CodiceCentroDiCosto: string;    // centro di costo del movimento
```

Sono additivi: WT continua a lasciarli vuoti e nulla cambia per gli esportatori esistenti. Senza di loro il file della contabilità analitica non si può scrivere.

### 3.3 🟡 Il quarto file di Mexal

`EsportazioneContabile.Mexal.Analitica.pas` (in `src\`) scrive le righe di contabilità analitica. **Non è un discendente** dell'esportatore Mexal — i suoi membri sono privati e un discendente in un'altra unit non li vedrebbe — ma un fratello che estende la stessa classe base. Il ponte chiama prima l'esportatore, poi questo, se il parametro `ESPORTA_ANALITICA` vale `S`.

Se nessun movimento porta imputazione analitica il file **non viene prodotto**: un file vuoto in ingresso a Mexal è un errore, non un file vuoto.

---

## 4. Corrispondenza fra gli stati

| WT | Gesty | Significato |
|---|---|---|
| `G` Generata | `PRO` Prodotto | I file esistono, non sono ancora entrati nel gestionale |
| `C` Consegnata | `INV` Consegnato | L'operatore conferma di averli importati; da qui scatta l'anti-doppione |
| `A` Annullata | `ERR` + righe `IGN` | Libera le registrazioni per una nuova esportazione |
| `E` Errore | `ERR` | Eccezione in generazione |
| — | `APE` Aperto | Stato in più: il lotto nasce prima che i file esistano, così anche un fallimento lascia traccia |

La regola condivisa: **la consegna è un atto dell'operatore, non del programma.** Il file viene importato a mano nel gestionale e solo dopo il lotto si chiude. Finché non è consegnato, le registrazioni restano fra quelle da esportare.

---

## 5. 🔴 Le due trappole dei tracciati

### 5.1 Ad Hoc salda i conti ripetuti

L'appendice 5-13 del manuale Ad Hoc avverte che **righe consecutive con lo stesso conto vengono saldate in una riga sola** dall'import. La procedura `COGE_DOCUMENTO_GENERA_REGISTRAZIONE` raggruppa l'imponibile per conto **e per progetto**: lo stesso conto di ricavo può quindi comparire due volte nella stessa scrittura, una per progetto. Verso Ad Hoc quelle due righe diventerebbero una sola, e l'ente scoprirebbe la fusione dopo l'import.

Soluzione: `COGE_INTERSCAMBIO_PRIMA_NOTA_DA_ESPORTARE` ha il parametro `AGGREGA_PER_CONTO`, che il ponte accende in automatico quando il gestionale è `ADHOC`. Si aggrega **prima**, consapevolmente, invece di lasciarlo fare al gestionale.

### 5.2 Verso Mexal l'aggregazione va spenta

Aggregare per conto cancella il dettaglio per progetto, che è esattamente ciò che alimenta il quarto file. Il valore predefinito è quindi `S` per Ad Hoc e `N` per tutti gli altri, sovrascrivibile col parametro `AGGREGA_PER_CONTO`.

**Le due trappole tirano in direzioni opposte:** è la ragione per cui il comportamento dipende dal gestionale e non è una costante.

---

## 6. Artefatti

### 🗄️ Database — `sql\13_allineamento_esportatori.sql` (non eseguito)

| Oggetto | Ruolo |
|---|---|
| Aggiornamento di `COGE_INTERSCAMBIO_FORNITORI` | Codici allineati al registro degli esportatori |
| `COGE_INTERSCAMBIO_LOTTI_FILES` + dominio `COGE_RUOLO_FILE` | Un record per file prodotto: `TESTATE`, `RIGHE`, `ANALITICA`, `UNICO`, … |
| Vista `COGE_INTERSCAMBIO_CORRISPONDENZE_MOTORE` | Traduce i codici a tre lettere nelle parole del motore |
| `COGE_INTERSCAMBIO_PRIMA_NOTA_DA_ESPORTARE` | Prima nota non ancora consegnata, appiattita come la vuole `TzMovimentoContabile`, con l'aggregazione opzionale per conto |
| `COGE_INTERSCAMBIO_LOTTO_ADD` / `_RIGA_ADD` / `_FILE_ADD` / `_CONSEGNA` / `_ANNULLA` | Ciclo di vita del lotto |

### 💻 Codice — `src\` (non compilato)

| Unit | Contenuto |
|---|---|
| `Gesty.EsportazioneContabile.Bridge.pas` | Ponte: configurazione, corrispondenze, parametri, caricamento dei movimenti, apertura del lotto, registrazione di file e righe, consegna e annullamento |
| `EsportazioneContabile.Mexal.Analitica.pas` | Quarto file di Mexal |

### 📋 Da applicare alle unit dell'altra cartella

| File | Modifica |
|---|---|
| `EsportazioneContabile.Types.pas` | Due campi in `TzRigaContabile` (§3.2) |
| `EsportazioneContabile.Mexal.pas` | Aggiornare il commento: la contabilità analitica **riguarda** l'export da Gesty |

Nessun'altra modifica: `Base`, `Registry`, `AdHoc` e il ponte WT restano intatti.

---

## 7. Quadro decisionale

| Punto | Scelta |
|---|---|
| Un solo motore per WT e Gesty | Sì: le unit non hanno dipendenze applicative, i ponti sono due |
| Codici dei gestionali | Quelli del registro Delphi (`MEXAL`, `ADHOC`, `GESTIONALE1`): il database si adegua al codice, non viceversa |
| Aggregazione per conto | Automatica per Ad Hoc, spenta altrove, sovrascrivibile per parametro |
| Contabilità analitica | Solo Mexal, che ha il file apposito. Ad Hoc la gestisce con altre logiche, da valutare quando arriva il tracciato |
| Consegna | Resta manuale, come nel progetto WT |

---

## 8. Punti aperti

| # | Punto | Nota |
|---|---|---|
| 1 | Tracciati campo per campo | Restano da recuperare: Mexal dal manuale completo edupass, Ad Hoc dalla funzione "Stampa Tracciati Records" di un'installazione, Gestionale 1 dall'assistenza Zucchetti. Fino ad allora gli esportatori scrivono nell'ordine provvisorio |
| 2 | Corrispondenza dei conti | Il piano dei conti di Gesty va mappato su quello del gestionale contabile prima della prima esportazione: senza mappatura l'esportazione si ferma, ed è voluto |
| 3 | Codice del progetto verso il gestionale | Oggi il ponte passa `PROGETTI.CODICE_IMPORT`. Va confermato che sia il codice che il gestionale contabile si aspetta come commessa, altrimenti serve una mappatura di tipo `CDC` |
| 4 | Anagrafiche | `EsportaAnagrafiche` solleva ancora eccezione in entrambi gli esportatori: da completare quando serve il primo invio di clienti e fornitori |
| 5 | Cliente pilota | Il secondo cliente misura se l'impianto tiene: se richiede codice nuovo invece di configurazione, il motore va corretto prima di procedere |

---

## Fonti

- `D:\AI\OUT\20260731-integrazione-gestionali-commerciali` — analisi, schema `ESPORTAZIONI_CONTABILI_*` e unit `EsportazioneContabile.*` (lette il 2026-07-31).
- Documenti collegati nella stessa cartella: nucleo COGE e strutture database, interscambio con i gestionali, dettaglio, sommario.
- [Prima nota da ASCII/CSV — manuale Passcom/Mexal](https://www.edupass.it/manuali/manualistica-mexal/manuale-prodotto?a=manuale-prodotto/servizi/trasferimento-archivi/caricamento-ascii-csv/prima-nota) · [Manuale "Procedure di Import" Ad Hoc R7.0](https://www.adhocenter.com/wp-content/uploads/2016/07/Import_Dati-1.pdf)
