---
area: Budget
progetto: Gesty
aggiornato: 2026-10-31
rilascio: OUT/20261031-specifica-budget/002
header: "Gesty | SOLUZIONI PER LA FORMAZIONE PROFESSIONALE E SERVIZI ALLA PERSONA."
footer: "| www.zebro.it/gesty"
colore_pagina: "#699E38"
colore_titoli: "#699E38"
carattere: "Calibri"
carattere_titoli: "Calibri Light"
---

<!-- header -->
**Gesty** — SOLUZIONI PER LA FORMAZIONE PROFESSIONALE E SERVIZI ALLA PERSONA.

---
<!-- /header -->

# Budget

Questa specifica descrive la pagina «Budget - Analisi Costi/Ricavi» di Gesty (menu «Budget», form `TFormBudget`, modulo dati `TBudget`, modulo LZ `Budget`): l'analisi di costi, ricavi e margine di ogni progetto, a preventivo e a consuntivo, per progetto e per esercizio. È l'area che il cliente CAPAC usa per controllare la redditività dei corsi. Descrive il comportamento atteso, non il codice.

**Dove sta la logica: nel database.** Il codice Delphi è un guscio: `dmBudget.pas` ha un solo metodo (`ElaboraCostiRicavi`, che chiede conferma ed esegue la procedura `COAN_ELABORA`), `frmBudget.pas` aggiunge un filtro per nome progetto sulle tabelle pivot e il doppio clic che apre il progetto. Tabelle, pivot, viste e schede nascono dal dizionario LZ. Tutti i numeri sono scritti da procedure Firebird (`COAN_*`) in tabelle di fotografia (`COAN_COSTI_RICAVI_PER_PROGETTO`, `COAN_COSTI_RICAVI_PER_ESERCIZIO` e collegate) e i totali e i margini sono colonne calcolate (`COMPUTED BY`) di quelle tabelle. **Conseguenza per il collaudo:** le regole si provano con script SQL su una copia del database (caratterizzazione, livello 3 di `collaudo.md`), non con la sonda a video; la sonda serve solo per i punti dell'interfaccia (GESTY-BUD-001, 002, 004 e 018).

**Fuori da quest'area**, con una specifica propria quando un lavoro la toccherà: la scheda del progetto che contiene i dati di partenza (metodo di determinazione dei ricavi, parametri della dote, ricavo atteso ed effettivo del corso a pagamento, quota di cofinanziamento), i costi del personale a monte (`Rilevamento ore.md`, `Autorizzazione incarichi.md`), le presenze degli studenti (`Presenze allievi e registro.md`), la contabilità COGE (non in uso: la modalità «da documenti» di `COAN_ELABORA_CON_DOCUMENTI` e `COAN_ORIGINE_CONSUNTIVO = 'DOC'` non si descrivono), la tabella `PROGETTI_BUDGET` e il pacchetto `BudgetCopiaDaAltroProgetto` di `dmProgetti.pas` (budget di spesa per tipo incarico, non collegato alle tabelle `COAN_*`) e i grafici (`Budget.Coan_Costi_Ricavi_Per_*_Grafico`, lavoro `OUT\20261020-grafici-budget`).

**Origine.** Ricavata il 2026-10-31 dal database master `GESTY` (fotografia dei metadati del 2026-10-30 13:19; ogni procedura citata riletta per intero), dal database CAPAC per le misure (copia di lavoro del 2026-10-24, letta in sola lettura), da `dmBudget.pas`, `frmBudget.pas`, `MainForm.pas` e `frmBudget.dfm` in `SRC\Gesty_Group\_Sorgenti` e dal dizionario LZ (`lz_resolve_form` su `TFormBudget`). Nessuna preanalisi di ticket tratta quest'area per intero; le righe che citano un ticket (#55, #140, #229, #231) vengono dai commenti scritti nelle procedure. "Provato" indica che la regola o il difetto è stato riscontrato su sorgente, su dati o con la caratterizzazione SQL `Prove\caratterizzazione\07-budget.sql` (25 casi su una copia di CAPAC, lanciata il 2026-10-31); "dedotto" che segue dalla lettura del codice e non è stato eseguito (resta solo DIV-BUD-8, da provare con la sonda). Le formule di corso a pagamento, dote, Emergo, ricavi uguali ai costi, sostegno e margine sono confermate dalla caratterizzazione.

**Dati di CAPAC al momento della lettura.** 1.580 progetti, tutti con `COAN_ATTIVO` vero e `COAN_ORIGINE_CONSUNTIVO = 'MAN'`; 1.553 righe per progetto e 1.993 per esercizio; 92.069 righe di costi del personale mensili; 1.160 righe di presenze studenti; nessun ricavo effettivo manuale e un solo costo vario. Metodo di determinazione dei ricavi: nessuno per 1.258 progetti, corso a pagamento 130, ricavi uguali a costi 80, progetti a dote 67, parametro orario 43, Emergo 2. CODEBRI ha 496 progetti, tutti senza metodo: per Codebri l'analisi dei ricavi si riduce al parametro orario del tipo incarico.

## GESTY-BUD-001 Chi può aprire il Budget
La voce «Budget» del menu principale è nascosta a tutti per impostazione predefinita (`RestrictionManager.AddDefaultLevel(Budget, alNone)`): compare solo a chi ha l'autorizzazione `Budget` (campo `USR_DEFAULT_AUTHORIZATIONS.BUDGET`, voce «Budget» in `Gesty.Authorizations`). La voce apre `TFormBudget` con il modulo dati `TBudget`. Il motivo è che la pagina mostra i ricavi e i margini dei corsi, dati che il personale ordinario non deve vedere.

### Scenario: utente senza autorizzazione
- **Dato** un utente senza l'autorizzazione `Budget`
- **Quando** apre il programma
- **Allora** la voce «Budget» non compare nel menu

## GESTY-BUD-002 Chi non ha l'autorizzazione non vede nemmeno i dati sparsi per il programma
La funzione `CAN_SEE_BUDGET()` risponde vero solo a chi ha l'autorizzazione `Budget`. Per gli altri il database nasconde i dati del Budget anche fuori dalla pagina: nell'elenco progetti il ricavo atteso e il ricavo effettivo del corso a pagamento valgono 0 e la descrizione del metodo diventa un segnaposto; nell'elenco incarichi il parametro ricavo del tipo incarico e quello specifico dell'incarico sono vuoti; le procedure di dettaglio dei tipi incarico (`PROGETTI_TIPI_INCARICO_DETAIL`) e dei piani personalizzati (`PROGETTI_PIANI_PERS_SRV_DETAIL`) restituiscono zero in ogni importo; nelle modifiche, il parametro ricavo specifico dell'incarico e il totale dei costi effettivi mantengono il valore precedente, e gli importi del sostegno si salvano a zero in inserimento. Chi crea un progetto senza l'autorizzazione lo crea comunque con `COAN_ATTIVO` vero; chi lo modifica non può spegnere il flag.

### Scenario: utente senza autorizzazione apre l'elenco progetti
- **Dato** un progetto di tipo «corso a pagamento» con ricavo atteso di 26.000 euro
- **Quando** lo apre un utente senza l'autorizzazione `Budget`
- **Allora** il ricavo atteso compare come 0

### Scenario: utente senza autorizzazione modifica un progetto
- **Dato** un progetto con `COAN_ATTIVO` falso
- **Quando** un utente senza l'autorizzazione salva il progetto
- **Allora** `COAN_ATTIVO` resta falso

## GESTY-BUD-003 Quali progetti entrano nel Budget
Entrano nell'elaborazione i soli progetti con `PROGETTI.COAN_ATTIVO` vero (predefinito: vero). Il flag si modifica nella scheda del progetto, solo da chi ha l'autorizzazione `Budget`. Un progetto con flag falso non viene toccato dall'elaborazione: le sue righe di fotografia già esistenti restano come sono (DIV-BUD-1).

### Scenario: progetto fuori dal Budget
- **Dato** un progetto con `COAN_ATTIVO` falso, mai elaborato
- **Quando** si elabora il Budget
- **Allora** il progetto non compare nelle analisi per progetto e per esercizio

## GESTY-BUD-004 Elaborazione dei costi e ricavi
Il pulsante «Elabora Costi/Ricavi» della barra della pagina chiede conferma («Si desidera elaborare i costi / ricavi ?»); con «No» non succede nulla; con «Sì», mostra l'attesa, esegue `COAN_ELABORA` e conferma la transazione. L'elaborazione ricostruisce da zero le fotografie dei soli progetti attivi, nell'ordine: costi del personale mensili, presenze degli studenti, riga per progetto (poi riempita da `COAN_ELABORA_COSTI_E_RICAVI_PERSONALE_PER_PROGETTO` e dalle procedure dei ricavi), righe per esercizio (stesso schema). **Le analisi sono una fotografia:** finché non si rielabora, i numeri non seguono le ore, i costi vari e i parametri modificati dopo l'ultima elaborazione. Se la procedura fallisce, l'eccezione arriva all'utente e la transazione non viene confermata.

### Scenario: conferma negata
- **Dato** la pagina Budget aperta
- **Quando** l'utente preme «Elabora Costi/Ricavi» e risponde «No»
- **Allora** nessuna tabella cambia

### Scenario: ore rilevate dopo l'ultima elaborazione
- **Dato** un progetto elaborato ieri e un'ora rilevata oggi
- **Quando** si apre l'analisi per progetto senza rielaborare
- **Allora** le ore e i costi consuntivi non comprendono l'ora di oggi

### Scenario: rielaborazione
- **Dato** un progetto elaborato, con un'ora in più rilevata
- **Quando** si rielabora
- **Allora** le ore rilevate e il costo consuntivo del progetto aumentano di quell'ora

## GESTY-BUD-005 Costi del personale mensili
`COAN_ELABORA_COSTI_PERSONALE_MENSILI` cancella le righe mensili dei progetti attivi e le ricostruisce raggruppando le ore rilevate per progetto, anno di esercizio, mese, tipo incarico, risorsa, natura dell'inquadramento (dipendente o no), costo orario congelato sulla riga di ore (ticket #55) e parametro ricavo. Servono un incarico e un inquadramento: le ore senza incarico non compaiono (GESTY-RIL-003) e gli incarichi collegati a un incarico principale (`ID_INCARICO_MASTER` valorizzato) sono esclusi per non contare due volte le stesse ore. Il parametro ricavo è quello specifico dell'incarico se diverso da zero, altrimenti quello del tipo incarico nel progetto, altrimenti zero. La tabella alimenta la scheda «Costi Interni Mensili» del progetto e il pivot omonimo; non entra nei totali per progetto o per esercizio, che si ricalcolano dalle ore.

### Scenario: due mesi, una risorsa
- **Dato** una risorsa con 10 ore in ottobre e 6 in novembre sullo stesso incarico
- **Quando** si elabora
- **Allora** ci sono due righe mensili, con 10 e 6 ore, al costo orario di ciascuna riga di ore

### Scenario: ora senza incarico
- **Dato** un'ora rilevata senza incarico su un progetto attivo
- **Quando** si elabora
- **Allora** l'ora non compare in nessuna riga mensile (DIV-BUD-9)

## GESTY-BUD-006 Ore e costi del personale per progetto
`COAN_ELABORA_COSTI_E_RICAVI_PERSONALE_PER_PROGETTO` scrive nella riga del progetto:
- **a preventivo**, ore e costi dagli incarichi del progetto (esclusi quelli collegati): ore attribuite meno ore non svolte meno le ore delle sostituzioni, per il costo orario dell'incarico alla data di inizio incarico (`INCARICO_GET_COSTO_ORARIO`);
- **a consuntivo**, ore e costi dalle ore rilevate, con il costo orario congelato su ogni riga di ore (GESTY-RIL-019) e l'inquadramento della riga, altrimenti quello dell'incarico.

In entrambi i casi la somma si divide in **interni** (inquadramento con `DIPENDENTE` vero) ed **esterni**. Le ore senza incarico non entrano nel consuntivo, che quindi può risultare più basso del timesheet (`Timesheet.md`, GESTY-TIM-002).

### Scenario: dipendente ed esterno
- **Dato** un progetto con un incarico da dipendente (100 ore attribuite, 20 euro l'ora) e uno da consulente (50 ore, 30 euro l'ora)
- **Quando** si elabora
- **Allora** i costi di personale interno a preventivo sono 2.000 euro, quelli esterni 1.500 euro, il totale 3.500 euro

### Scenario: sostituzione
- **Dato** un incarico di 100 ore con una sostituzione di 20 ore
- **Quando** si elabora
- **Allora** le ore attribuite del titolare a preventivo sono 80

## GESTY-BUD-007 Ricavi a parametro orario
Il ricavo a parametro di un'ora è il suo parametro ricavo (specifico dell'incarico se diverso da zero, altrimenti quello del tipo incarico nel progetto) per le ore: a preventivo per le ore attribuite, a consuntivo per le ore rilevate. Il risultato va in `RICAVI_PARAMETRO_SPECIFICO_PREVENTIVO` e `_CONSUNTIVO` (e, per esercizio, `RICAVI_PARAMETRO_SPECIFICO`). **Si calcola per ogni progetto attivo, qualunque sia il suo metodo di determinazione dei ricavi:** il flag `PARAMETRO_RICAVO_SPECIFICO` del metodo «Ricavo in base a parametro orario» non è letto da nessuna procedura (DIV-BUD-2).

### Scenario: parametro del tipo incarico
- **Dato** un incarico di 10 ore rilevate con parametro ricavo del tipo incarico 15 e parametro specifico 0
- **Quando** si elabora
- **Allora** il ricavo a parametro consuntivo è 150 euro

### Scenario: parametro specifico dell'incarico
- **Dato** lo stesso incarico con parametro specifico 20
- **Quando** si elabora
- **Allora** il ricavo a parametro consuntivo è 200 euro

## GESTY-BUD-008 Costi vari
I costi vari di un progetto sono le righe di `PROGETTI_COSTI_VARI` (tipo costo dalla tabella `ZZ_TIPO_COSTI`, anno di esercizio, importo a preventivo e a consuntivo, indicatore «costo non riconosciuto»). Per progetto il preventivo e il consuntivo sono la somma degli importi; per esercizio il consuntivo è la somma per anno (il preventivo non ha colonna per esercizio). Le righe si inseriscono nella scheda «Costi Vari» del progetto e vanno rielaborate per comparire nelle analisi. La somma per esercizio non guarda `COAN_ATTIVO` (DIV-BUD-1).

### Scenario: due righe di costi vari
- **Dato** un progetto attivo con costi vari di 500 e 300 euro a consuntivo nello stesso esercizio
- **Quando** si elabora
- **Allora** i costi vari consuntivi sono 800 euro, per progetto e per quell'esercizio

## GESTY-BUD-009 Ricavi vari
Come i costi vari: righe di `PROGETTI_RICAVI_VARI` (tipo ricavo da `ZZ_TIPO_RICAVI`, anno di esercizio, importo a preventivo e a consuntivo), sommate per progetto e per esercizio e contate nei ricavi di entrambe le analisi. Vale la stessa osservazione su `COAN_ATTIVO` (DIV-BUD-1).

### Scenario: ricavo vario
- **Dato** un progetto attivo con un ricavo vario di 1.000 euro a consuntivo
- **Quando** si elabora
- **Allora** i ricavi vari consuntivi sono 1.000 euro e entrano nei ricavi del progetto

## GESTY-BUD-010 Metodo di determinazione dei ricavi
Ogni progetto ha un metodo (campo `PROGETTI.METODO_DETERMINAZIONE_RICAVI`, tabella `ZZ_METODI_DETERMINAZIONE_RICAVI`, modificabile dalla pagina «Metodi Determinazione Ricavi»). Cinque metodi, ciascuno con un indicatore che attiva una procedura di ricavo:

| Metodo | Indicatore | Procedura che lo usa | Requisito |
|---|---|---|---|
| CORSO A PAGAMENTO | `CORSO_A_PAGAMENTO` | `COAN_ELABORA_RICAVI_CORSO_A_PAGAMENTO_*` | GESTY-BUD-011, 012 |
| RICAVI=COSTI | `RICAVO_UGUALE_COSTI` | `COAN_ELABORA_RICAVI_RICAVO_UGUALE_COSTI_*` | GESTY-BUD-016 |
| RICAVO IN BASE A PARAMETRO ORARIO | `PARAMETRO_RICAVO_SPECIFICO` | nessuna (DIV-BUD-2) | GESTY-BUD-007 |
| PROGETTI A DOTE | `PROGETTI_A_DOTE` | `COAN_ELABORA_PRESENZE_STUDENTI`, `COAN_ELABORA_RICAVI_PROGETTI_A_DOTE_PER_PROGETTO` | GESTY-BUD-014, 015 |
| PROGETTI EMERGO | `DOTI_PIP` | `COAN_ELABORA_RICAVI_DOTI_PIP_*` | GESTY-BUD-013 |

Un progetto senza metodo (la maggioranza, 1.258 su 1.580 in CAPAC) ha solo costi, ricavi a parametro, ricavi vari e ricavi effettivi manuali.

### Scenario: progetto senza metodo
- **Dato** un progetto attivo senza metodo e senza parametri di ricavo
- **Quando** si elabora
- **Allora** ha costi consuntivi e ricavi a zero e margine negativo, uguale ai costi cambiati di segno

## GESTY-BUD-011 Corso a pagamento: totali per progetto
Per i progetti attivi con metodo «corso a pagamento», il ricavo a preventivo è il ricavo atteso della scheda (`RICAVO_ATTESO_CORSO_A_PAGAMENTO`) e il consuntivo di quella colonna resta zero. Il ricavo effettivo è il ricavo effettivo della scheda (`RICAVO_EFFETTIVO_CORSO_A_PAGAMENTO`) se maggiore di zero, altrimenti la somma delle righe manuali dei ricavi effettivi (GESTY-BUD-017) (ticket #140 e #231). Per i progetti con altri metodi il ricavo effettivo è sempre la somma delle righe manuali.

### Scenario: ricavo effettivo della scheda
- **Dato** un corso a pagamento con ricavo atteso 26.000 e ricavo effettivo 24.500 nella scheda
- **Quando** si elabora
- **Allora** i ricavi a preventivo sono 26.000 e il ricavo effettivo (e il consuntivo) 24.500

### Scenario: ricavo effettivo solo manuale
- **Dato** un corso a pagamento con ricavo effettivo 0 nella scheda e due righe manuali da 3.000 e 2.000
- **Quando** si elabora
- **Allora** il ricavo effettivo del progetto è 5.000

## GESTY-BUD-012 Corso a pagamento: ripartizione per esercizio
Il ricavo atteso e il ricavo effettivo del corso si ripartiscono sugli esercizi del progetto (`COAN_ELABORA_RICAVI_CORSO_A_PAGAMENTO_PER_ESERCIZIO`, ticket #231). Regole, nell'ordine:
- **Base della ripartizione:** le ore rilevate sugli incarichi di formazione collettiva (`ZZ_TIPI_INCARICO.FORMAZIONE_COLLETTIVA`, esclusi gli incarichi collegati) in ciascun esercizio; se non ce ne sono, i giorni di calendario del progetto compresi in ogni esercizio.
- **Denominatore:** le ore totali; ma se il progetto non è ancora finito e ha una durata prevista (`DURATA_ORE` fra 1 e 99.999.998) vale il maggiore fra durata prevista e ore rilevate, così che il ricavo non si anticipi sugli esercizi già trascorsi.
- **Arrotondamento:** si arrotonda il progressivo e non la quota di ogni anno, così la somma degli esercizi torna al centesimo.
- **Righe manuali dei ricavi effettivi:** un esercizio con riga manuale prende per ricavo effettivo la somma delle sue righe; l'atteso resta la quota sulle ore. Il residuo (ricavo effettivo della scheda, o in sua assenza ricavo atteso, meno le righe manuali, mai negativo) si divide sugli esercizi senza riga manuale, per ore, poi per giorni, poi in parti uguali.

### Scenario: due esercizi, ore uguali
- **Dato** un corso a pagamento finito, con ricavo atteso 10.000 e 100 ore rilevate in ciascuno di due esercizi
- **Quando** si elabora
- **Allora** ogni esercizio ha 5.000 euro di ricavo a pagamento

### Scenario: riga manuale su un esercizio
- **Dato** lo stesso corso con ricavo effettivo della scheda 8.000 e una riga manuale di 6.000 sul primo esercizio
- **Quando** si elabora
- **Allora** il primo esercizio ha ricavo effettivo 6.000 e il secondo 2.000

### Scenario: nessuna ora collettiva
- **Dato** un corso senza ore di formazione collettiva, che dura il 40% dei giorni nel primo esercizio e il 60% nel secondo
- **Quando** si elabora
- **Allora** il ricavo si divide 40% e 60%

## GESTY-BUD-013 Progetti Emergo (piani personalizzati)
Per i progetti attivi con metodo «PROGETTI EMERGO» il ricavo a preventivo è la somma, sui servizi dei piani personalizzati, delle ore previste (`ORE_PIP`) per il parametro dote del servizio; a consuntivo, per il parametro dote, le ore di quel servizio rilevate sugli incarichi collegati al piano (durata fra ora di inizio e ora di fine). Per esercizio il consuntivo si ripartisce per anno di esercizio della data dell'ora; il preventivo non ha colonna per esercizio. La scheda «Piani Personali» del progetto mostra gli stessi totali per servizio (ore attribuite, non attribuite, effettuate, non svolte, residue, valore della dote a preventivo e a consuntivo).

### Scenario: servizio di un piano
- **Dato** un servizio con 50 ore previste, parametro dote 10 e 30 ore effettuate
- **Quando** si elabora
- **Allora** il ricavo Emergo è 500 a preventivo e 300 a consuntivo

## GESTY-BUD-014 Progetti a dote: presenze degli studenti
Per i progetti attivi con metodo «progetti a dote» `COAN_ELABORA_PRESENZE_STUDENTI` calcola una riga per ogni iscrizione (`COAN_PRESENZE_STUDENTI`; visibile nella scheda «Presenze Studenti»). Le ore effettuate sono le presenze del registro collettivo (presente e da calcolare) nel periodo fra iscrizione e ritiro, più le ore di presenza dei tirocini dell'iscrizione (ticket #229); le ore giustificate si calcolano allo stesso modo. La percentuale di frequenza è ore effettuate su durata del progetto, al massimo 100. Il ricavo della dote (a preventivo e a consuntivo, uguali) segue i parametri del progetto:
- percentuale sotto la frequenza minima: zero;
- percentuale sopra il limite di riconoscimento della dote massima: la dote massima;
- altrimenti: ore effettuate per l'importo riconosciuto per ora frequentata.

Le ore riconosciute (ore effettuate meno le non riconosciute, più le assenze giustificate fino alla quota consentita) vengono scritte in tabella ma non entrano nel ricavo (DIV-BUD-4).

### Scenario: frequenza sotto il minimo
- **Dato** una dote con frequenza minima del 30% e un'iscrizione con il 20% di frequenza
- **Quando** si elabora
- **Allora** il ricavo della dote è 0

### Scenario: frequenza intermedia
- **Dato** un'iscrizione con il 50% di frequenza (300 ore su 600), importo orario 6,72 e dote massima 6.654, limite di riconoscimento al 75%
- **Quando** si elabora
- **Allora** il ricavo della dote è 300 × 6,72 = 2.016 euro

### Scenario: frequenza oltre il limite
- **Dato** la stessa dote e un'iscrizione con l'80% di frequenza
- **Quando** si elabora
- **Allora** il ricavo della dote è 6.654 euro

## GESTY-BUD-015 Sostegno
Per un progetto a dote, il sostegno è una quota aggiuntiva per studente: ore di sostegno effettivamente fruite (`ORE_SOSTEGNO`, presenze `STUDENTI_PRESENZE_SOSTEGNO`) per l'importo orario di sostegno del progetto, limitato all'importo massimo di sostegno per studente (`COAN_SOSTEGNO`, scheda «Sostegno»). Il totale del sostegno si somma al ricavo a dote consuntivo del progetto, non al preventivo e non alla riga per esercizio (DIV-BUD-3, DIV-BUD-5).

### Scenario: tetto del sostegno
- **Dato** un progetto con importo orario di sostegno 45, tetto per studente 2.250 e uno studente con 60 ore
- **Quando** si legge il sostegno
- **Allora** l'importo dello studente è 2.250 euro (e non 2.700)

## GESTY-BUD-016 Ricavi uguali ai costi
Per i progetti attivi con metodo «RICAVI=COSTI» il ricavo è la quota di cofinanziamento dei costi riconosciuti: (costi di personale meno gli importi non riconosciuti del progetto) × percentuale di cofinanziamento ÷ 100 × quota di copertura dei costi generali, più i costi vari che non sono «non riconosciuti». A preventivo si usano i costi di personale a preventivo, a consuntivo quelli a consuntivo. Per esercizio i costi di personale non riconosciuti si sottraggono nell'ultimo anno (`ULTIMO_ANNO`) e i costi vari sono quelli dell'anno.

### Scenario: cofinanziamento
- **Dato** un progetto con costi di personale consuntivi 10.000, non riconosciuti 1.000, cofinanziamento 80%, quota di copertura 1, senza costi vari
- **Quando** si elabora
- **Allora** i ricavi uguali ai costi a consuntivo sono 7.200 euro

## GESTY-BUD-017 Ricavi effettivi manuali
La scheda «Ricavi Effettivi» (`COAN_RICAVI_EFFETTIVI`, una riga per progetto ed esercizio) permette di scrivere il ricavo effettivamente incassato in un esercizio. Per i progetti non a corso a pagamento la somma delle righe (per esercizio la riga dell'anno) è il ricavo effettivo del progetto; per i corsi a pagamento valgono le regole di GESTY-BUD-011 e 012.

### Scenario: ricavo effettivo di un esercizio
- **Dato** un progetto senza metodo con una riga manuale di 4.000 euro nell'esercizio 2025
- **Quando** si elabora
- **Allora** il ricavo effettivo per progetto è 4.000 e quello dell'esercizio 2025 è 4.000

## GESTY-BUD-018 Totali, ricavi e margini
Le tabelle di fotografia non memorizzano i totali: li calcolano come colonne derivate.

| Campo | Regola |
|---|---|
| Ore e costi di personale | interni + esterni |
| Costi (per progetto, preventivo e consuntivo) | costi di personale interni + esterni + costi vari |
| Ricavi a preventivo (per progetto) | parametro orario + corso a pagamento + Emergo + dote + ricavi uguali ai costi + ricavi vari (senza ricavi effettivi) |
| Ricavi a consuntivo (per progetto) | gli stessi addendi a consuntivo + ricavi effettivi |
| Ricavi (per esercizio) | parametro orario + Emergo + dote + ricavi uguali ai costi + ricavi vari + (ricavi effettivi se diversi da zero, altrimenti ricavi del corso a pagamento) |
| Margine | sempre ricavi meno costi |

Il margine può essere negativo anche per mancanza di ricavi: un progetto con costi e nessun ricavo risulta in perdita, per l'importo dei costi (DIV-BUD-6, corretta il 2026-10-31 col rilascio `OUT/20261031-specifica-budget/003`; prima il margine era 0 quando i ricavi erano zero). I valori per progetto e per esercizio non coincidono per costruzione (GESTY-BUD-019).

### Scenario: progetto in perdita con ricavi
- **Dato** un progetto con costi consuntivi 10.000 e ricavi consuntivi 6.000
- **Quando** si legge il margine
- **Allora** il margine consuntivo è −4.000

### Scenario: progetto con costi e senza ricavi
- **Dato** un progetto con costi consuntivi 10.000 e nessun ricavo
- **Quando** si legge il margine
- **Allora** il margine consuntivo è −10.000

## GESTY-BUD-019 Analisi per esercizio
Per ogni progetto attivo si crea una riga per ciascun esercizio fra la data di inizio e di fine del progetto (`ZZ_RANGE_ANNI_ESERCIZIO`, calendario di esercizio dell'ente); l'ultima è segnata `ULTIMO_ANNO`. Ore e costi di personale, ricavi a parametro e ricavi Emergo sono quelli delle ore rilevate dentro l'esercizio (per data dell'ora); costi e ricavi vari quelli dell'anno di esercizio della riga; i ricavi a dote **non** si calcolano per esercizio (DIV-BUD-3). Le ore rilevate fuori dal periodo del progetto non entrano in nessuna riga per esercizio, mentre entrano nel totale per progetto (DIV-BUD-7).

### Scenario: progetto a cavallo di due esercizi
- **Dato** un progetto dal 01/10/2025 al 30/06/2026 con ore in entrambi gli esercizi
- **Quando** si elabora
- **Allora** ci sono due righe per esercizio, con le ore e i costi di ciascun esercizio, e la seconda è segnata come ultimo anno

## GESTY-BUD-020 Pagina di analisi
La pagina ha un albero a sinistra e le seguenti schede (voce dell'albero → dataset):

| Voce | Dataset | Contenuto |
|---|---|---|
| Analisi Costi Ricavi Per Progetto | `Budget.Coan_Costi_Ricavi_Per_Progetto` | tabella pivot e grafico; parametri facoltativi ente e anno formativo |
| Analisi Costi Ricavi Per Esercizio | `Budget.Coan_Costi_Ricavi_Per_Esercizio` | tabella pivot e grafico; parametri facoltativi ente e anno di esercizio |
| Elenco Progetti | `Budget.Progetti_Elenco` | elenco con i totali per progetto e, in dettaglio, le schede Costi/Ricavi Incarichi, Risorse Incaricate, Costi Interni Mensili, Piani Personali, Presenze Studenti, Sostegno, Costi Vari, Ricavi Vari, Ricavi Effettivi, Finanziamenti |
| Metodi Determinazione Ricavi, Tipo Costi, Tipo Ricavi | tabelle di base | modificabili |

Un doppio clic su una cella o sull'intestazione di gruppo di un progetto nelle due pivot apre l'«Elenco Progetti» filtrato su quel progetto (usa `ID_PROGETTO`, che è un campo nascosto del dataset). La form offre anche due caselle di ricerca per nome progetto (contiene, senza distinzione di maiuscole) sulle due pivot; la loro visibilità e il fatto che trovino il campo da filtrare non sono verificati (DIV-BUD-8).

### Scenario: apri un progetto dalla pivot
- **Dato** l'analisi per progetto con un progetto in riga
- **Quando** l'utente fa doppio clic sul nome del progetto
- **Allora** compare l'elenco progetti con solo quel progetto

## GESTY-BUD-021 Costi e ricavi per tipo incarico (scheda «Costi/Ricavi Incarichi»)
La scheda mostra, per ogni tipo incarico del progetto (`PROGETTI_TIPI_INCARICO_DETAIL`), ore previste, attribuite, da attribuire, rilevate e residue, costi e ricavi a preventivo e a consuntivo (divisi in interni ed esterni dal tipo di contratto `D`), l'importo di budget, la differenza fra budget e costo consuntivo e la percentuale di completamento. Le ore residue sono ore attribuite meno ore delle sostituzioni, meno ore rilevate, meno ore non svolte. Per chi non ha l'autorizzazione `Budget` tutti gli importi sono zero (GESTY-BUD-002). I valori di questa scheda sono calcolati al momento e non dalla fotografia, quindi possono differire dalle analisi finché non si rielabora o per i motivi di DIV-BUD-10.

### Scenario: ore residue
- **Dato** un tipo incarico con 100 ore attribuite, 30 rilevate, 10 non svolte e nessuna sostituzione
- **Quando** si apre la scheda
- **Allora** le ore residue sono 60

### Scenario: ore esaurite
- **Dato** un tipo incarico con 100 ore attribuite e 100 rilevate
- **Quando** si apre la scheda
- **Allora** le ore residue sono 0 e la percentuale di completamento dovrebbe essere 100 (DIV-BUD-10)

## Divergenze note

Punti in cui il codice di oggi non mantiene ciò che i requisiti dicono, o in cui due parti del codice applicano la stessa regola in modo diverso. Non si è deciso se siano difetti: sono segnalati e vanno decisi con l'utente. Si correggono nella voce R-195 di `Attivita Rinviate.md`; con la correzione il requisito si aggiorna e questa sezione si accorcia.

| Codice | Divergenza | Conseguenza |
|---|---|---|
| 🟡 DIV-BUD-1 | Provato sulla copia di CAPAC (caratterizzazione 07, costi vari): `COAN_ELABORA_COSTI_VARIE_PER_ESERCIZIO` e `COAN_ELABORA_RICAVI_VARI_PER_ESERCIZIO` non filtrano su `COAN_ATTIVO` (le versioni per progetto sì); le righe di un progetto reso non attivo non sono cancellate dall'elaborazione, che le lascia come sono. Progetto 472722 spento con un costo vario nuovo di 123,45 euro: ore rilevate invariate (634), costi vari per progetto 0, costi vari per esercizio 123,45. In CAPAC tutti i progetti sono attivi | Un progetto spento dal Budget conserva le vecchie righe e, per esercizio, riceve i costi e ricavi vari nuovi su numeri vecchi: dati misti. Nessun effetto finché nessun progetto viene spento |
| 🟡 DIV-BUD-2 | Provato sul codice, sui dati e con la caratterizzazione 07: il flag `PARAMETRO_RICAVO_SPECIFICO` del metodo non è letto da nessuna procedura; i ricavi a parametro si calcolano per ogni progetto attivo che abbia un parametro. In CAPAC hanno ricavi a parametro, a consuntivo, 6 progetti senza metodo e 2 corsi a pagamento; a preventivo anche 1 progetto «ricavi uguali a costi» (7, 2 e 1 in tutto) | Un corso a pagamento o un progetto «ricavi uguali ai costi» con un parametro ricavo nel tipo incarico somma due criteri di ricavo diversi: il totale può contare due volte lo stesso ricavo |
| 🟡 DIV-BUD-3 | Provato sul codice e sulla copia di CAPAC (caratterizzazione 07): `COAN_ELABORA_RICAVI_PROGETTI_A_DOTE_PER_ESERCIZIO` è vuota (resta un commento «VEDI FILE DOCX»). Con i parametri della dote impostati su due progetti, i progetti con ricavi a dote consuntivi sono 3 e valgono 155.606,16 euro per progetto; per esercizio la somma è 0 (uno solo dei tre ha righe per esercizio) | L'analisi per esercizio non mostra mai i ricavi dei progetti a dote né il sostegno: i totali per progetto e per esercizio non tornano per questi progetti |
| 🟡 DIV-BUD-4 | Provato sulla copia di CAPAC (caratterizzazione 07, parametri dell'avviso impostati su due progetti: minimo 10%, 6,72 euro l'ora, dote 6.654 oltre il 75%, assenze 25%): nel calcolo della dote il ricavo usa le ore effettuate (17 iscrizioni intermedie su 17 con assenze giustificate hanno ricavo = effettuate × importo, nessuna = riconosciute × importo); le ore riconosciute sono calcolate e salvate ma non usate. In più il tetto del 25% non funziona: la procedura moltiplica le ore per la percentuale scritta come 25 invece di 0,25, quindi il tetto non scatta mai e 6 iscrizioni su 17 hanno ore riconosciute oltre il 125% delle effettuate. Le tre fasce di frequenza (sotto il minimo 8 iscrizioni, intermedie 19, oltre il limite 19) rispettano la regola. In CAPAC i parametri della dote dei progetti reali sono a zero | Se la regola voluta è quella del commento, la dote è sottostimata per gli studenti con assenze giustificate; il valore delle ore riconosciute, se un giorno entrasse nel ricavo, sarebbe sbagliato per il tetto mancante. Con i parametri a zero, un'iscrizione con ore frequentate supera il limite di riconoscimento e prende la dote massima (anch'essa 0) |
| 🟡 DIV-BUD-5 | Provato sulla copia di CAPAC (caratterizzazione 07): `COAN_ELABORA_RICAVI_PROGETTI_A_DOTE_PER_PROGETTO` aggiunge il totale del sostegno a **ogni** riga di `COAN_COSTI_RICAVI_PER_PROGETTO`, anche di progetti senza metodo a dote e di progetti non attivi che l'elaborazione non ricostruisce. (a) Progetto 472722 senza metodo a dote, ancora attivo: i ricavi a dote consuntivi restano 4.500 euro (solo sostegno). (b) Lo stesso progetto spento: una sola elaborazione senza altre modifiche porta i ricavi a dote da 4.500 a 9.000 euro; ogni giro somma di nuovo il sostegno. Il valore cresce solo se il progetto spento non ha righe di presenze a dote (le righe di presenze resettano il valore prima della somma): è il caso di un progetto spento e senza metodo a dote | Il sostegno conta nei ricavi anche per progetti senza metodo a dote. Un progetto spento e senza presenze a dote vede il ricavo crescere a ogni elaborazione. Per i progetti attivi la riga riparte da zero e il difetto non si vede |
| ✅ DIV-BUD-6 (corretta il 2026-10-31, rilascio `OUT/20261031-specifica-budget/003`: ora il margine è sempre ricavi meno costi; la descrizione che segue riguarda il comportamento di prima) | Provato sui dati: il margine valeva 0 quando i ricavi erano zero (`IIF(RICAVI > 0, RICAVI − COSTI, 0)`). Sulla copia di CAPAC (caratterizzazione 07) 1.348 progetti hanno costi consuntivi e ricavi a zero e tutti e 1.348 hanno margine 0; con ricavi maggiori di zero il margine è sempre ricavi meno costi (16 progetti in perdita lo mostrano) | I progetti che costano e non fatturano compaiono con margine 0 invece che negativo; il margine complessivo dell'ente è quindi sovrastimato di tutte le perdite dei progetti senza ricavi. Da decidere se è voluto |
| 🟡 DIV-BUD-7 | Provato sulla copia di CAPAC (caratterizzazione 07): le ore per esercizio si prendono dagli esercizi compresi fra le date del progetto e dentro gli esercizi configurati per l'ente; un'ora fuori da quelle date, o dopo l'ultimo esercizio configurato, non entra nelle righe per esercizio ma entra nei costi per progetto. Differenza di 568.181,51 euro sui costi di personale consuntivi, spiegata per intero: 103.776,93 di ore fuori dalle date del progetto e 464.404,60 di ore dentro le date ma oltre il 31/08/2026, ultimo esercizio configurato per l'ente 1492 (resta uno scarto di 0,02, arrotondamento) | I costi per esercizio sommano meno dei costi per progetto. La parte più grande non è un difetto del codice ma un dato mancante: finché l'ente non ha l'esercizio 2026/2027 le ore da settembre 2026 sono perse per esercizio (vedi DIV-BUD-11) |
| 🟢 DIV-BUD-8 | Ancora dedotto (non è materia di SQL, resta da provare con la sonda): `FiltraProgetto` cerca il campo `DENOMINAZIONE_PROGETTO`, ma i dataset delle due analisi hanno `PROGETTO`; se la pivot non ha quel campo il filtro non si può costruire. Le caselle `edMese` e `edAnno` della form non sono lette da nessun gestore. Non verificato a video se le caselle di ricerca sono visibili | Il pulsante «Cerca» potrebbe fallire o non esistere per l'utente. Da provare con la sonda |
| 🟡 DIV-BUD-9 | Provato sul codice: le ore senza incarico (`ID_INCARICO` vuoto) non entrano in nessun conteggio del Budget (costi mensili, per progetto e per esercizio), mentre il timesheet le mostra dal ticket 304 (`Timesheet.md`, GESTY-TIM-002). Su CODEBRI 504 righe e 1.324,46 ore del 2026 | I costi consuntivi del Budget possono essere più bassi del lavoro realmente svolto; il confronto con il timesheet non torna |
| 🟡 DIV-BUD-10 | Provato sul codice e sui dati: in `PROGETTI_TIPI_INCARICO_DETAIL` (a) la percentuale di completamento vale 0 quando le ore residue sono zero o negative (manca un `ELSE` fra i controlli: in CAPAC 1.930 righe su 1.930 con ore esaurite hanno percentuale 0, mentre la procedura gemella dei piani personalizzati restituisce 100); (b) provato (caratterizzazione 07, progetto 491288 «Docenza», tutti gli incarichi con parametro specifico): i ricavi a parametro specifico sono contati sia dentro i ricavi interni/esterni sia di nuovo nella colonna a parametro specifico, quindi sommati due volte (159.061 euro più 159.061 = 318.122 euro di ricavi consuntivi della scheda); (c) smentita su CAPAC: il costo consuntivo della scheda coincide con la somma delle ore per il costo congelato sulle righe (105.443,88 euro), perché il costo orario non cambia nel tempo per questi incarichi; la differenza può comparire solo se il costo orario di un'inquadratura cambia dopo le ore. Smentita anche l'ipotesi che le ore della scheda comprendano gli incarichi collegati (1.443 ore uguali con e senza collegati). | La scheda «Costi/Ricavi Incarichi» mostra incarichi finiti come non iniziati e, quando gli incarichi hanno un parametro ricavo specifico, raddoppia i ricavi |
| 🟡 DIV-BUD-11 | Nuova, provata sulla copia di CAPAC (caratterizzazione 07): `ZZ_RANGE_ANNI_ESERCIZIO` restituisce solo gli esercizi già configurati per l'ente (`ENTI_ANNI_ESERCIZIO`); per l'ente 1492 l'ultimo si chiude il 31/08/2026. Un progetto che comincia dopo (per esempio il 494593, dal 01/09/2026) non ha nessuna riga per esercizio: 115 progetti attivi sono in questo caso. Ai progetti più vecchi mancano nelle righe per esercizio le ore rilevate da settembre 2026 (464.404,60 euro di costi, vedi DIV-BUD-7) | Finché non si inserisce l'esercizio 2026/2027, l'analisi per esercizio omette progetti interi e le ore recenti. Non è un difetto di una procedura: serve il dato dell'esercizio, o un avviso quando manca |

<!-- footer -->
---

[www.zebro.it/gesty](https://www.zebro.it/gesty)
<!-- /footer -->
