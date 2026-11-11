---
area: Progettazione bandi
progetto: Gesty
aggiornato: 2026-11-11
rilascio: OUT/20261107-modulo-progettazione-bandi-codebri/001
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

# Progettazione bandi

Questa specifica descrive il modulo Bandi di Gesty (menu «Bandi», form `TFormBandi`, modulo dati `TBandi`, modulo LZ `Bandi`): l'iter di un bando di finanziamento dalla rilevazione dell'avviso ai pareri interni, dalle candidature all'esito, fino al passaggio al progetto operativo e al confronto economico con il Budget. È un modulo base: i livelli di parere si configurano per cliente. Descrive il comportamento atteso, non il codice.

**Dove sta la logica: nel database.** Stati, controlli e permessi stanno in funzioni, procedure e trigger (`BANDO_FASE`, `BANDO_PARERE`, `BANDO_RIAPRI_VALUTAZIONE`, `BANDI_CANDIDATURA_FASE`, `BANDI_CANDIDATURE_BIU0`). `dmBandi.pas` raccoglie solo i dati dei comandi.

**Fuori da quest'area:** la gestione del progetto operativo, l'elaborazione del Budget (`Budget.md`), la rendicontazione e il consuntivo del bando, l'invio degli avvisi per posta elettronica.

**Origine.** Foglio dell'Ufficio Progetti di Codebri del 2026-06-26 e offerta tecnica del 2026-07-19 (`OUT\20261107-modulo-progettazione-bandi-codebri`). Le regole sono provate da `Prove\caratterizzazione\08-progettazione-bandi.sql`, tranne GESTY-BAN-012.

## GESTY-BAN-001 Autorizzazioni
Inserire, modificare ed eliminare bandi, candidature e partner richiede `Bandi.Gestione`. Gli enti finanziatori sono un'anagrafica condivisa con altri moduli (Abitare, SIA): inserirli non richiede `Bandi.Gestione`, così chi lavora in quei moduli può crearli senza il permesso dei bandi. `Bandi.Supervisore` serve per riaprire una valutazione, per modificare i livelli, per modificare una candidatura chiusa e per eliminare una candidatura presentata. Essere amministratore non esenta dal controllo.

### Scenario: inserimento senza autorizzazione
- **Dato** un utente senza `Bandi.Gestione`
- **Quando** inserisce un bando
- **Allora** l'operazione si ferma con "Autorizzazione Bandi.Gestione necessaria per questa operazione."

### Scenario: ente finanziatore senza autorizzazione
- **Dato** un utente senza `Bandi.Gestione`
- **Quando** inserisce un ente finanziatore
- **Allora** l'inserimento riesce

## GESTY-BAN-002 Dati del bando
Un bando ha ente finanziatore e titolo obbligatori. Il territorio Comunale o Altro richiede la descrizione. La data ultima per i pareri non può seguire la scadenza del bando. La tipologia del fondo usa le stesse fonti di finanziamento dei progetti.

### Scenario: data dei pareri oltre la scadenza
- **Dato** un bando in scadenza il 10/01/2030
- **Quando** si indica il 20/01/2030 come data ultima per i pareri
- **Allora** il salvataggio si ferma

## GESTY-BAN-003 Stato del bando
Lo stato si calcola dai pareri validi sui livelli attivi e non si scrive mai. Una candidatura successiva non lo cambia.

| Stato | Quando |
|---|---|
| Scartato | un livello attivo ha dato parere contrario |
| Approvato | tutti i livelli attivi hanno dato parere favorevole |
| Rilevato | nessun parere favorevole |
| In valutazione | alcuni livelli attivi hanno dato parere favorevole |
| Scaduto | rilevato o in valutazione con la scadenza del bando passata |

### Scenario: bando nuovo
- **Dato** un bando appena inserito
- **Quando** se ne legge lo stato
- **Allora** è Rilevato

## GESTY-BAN-004 Ordine dei livelli
I livelli si esprimono per `ORDINE` crescente. Un livello si esprime solo quando quelli con ordine più basso hanno dato parere favorevole, e una sola volta.

### Scenario: livello saltato
- **Dato** un bando senza il parere dell'Ufficio Progetti
- **Quando** si esprime il parere di settore
- **Allora** l'operazione si ferma: il parere "si esprime dopo i pareri favorevoli dei livelli precedenti"

## GESTY-BAN-005 Chi esprime il parere
Esprime il parere chi ha l'autorizzazione del livello. Dove il livello lo prevede (`RESPONSABILE_SETTORE`), lo esprime anche il responsabile attuale del settore del bando, senza autorizzazione.

### Scenario: responsabile del settore
- **Dato** il responsabile del settore del bando, senza `Bandi.Parere.Settore`
- **Quando** esprime il parere di settore
- **Allora** il parere è registrato

## GESTY-BAN-006 Parere contrario
Il parere contrario richiede la motivazione e scarta il bando: nessun altro parere si può esprimere finché la valutazione non è riaperta.

### Scenario: motivazione mancante
- **Dato** un bando in attesa di parere
- **Quando** si dà parere contrario senza motivazione
- **Allora** l'operazione si ferma con "La motivazione è obbligatoria per un parere contrario."

## GESTY-BAN-007 I pareri non si scrivono a mano
I pareri si registrano solo con i comandi del modulo e non si modificano: restano autore, data, esito e motivazione. Eliminando il bando si eliminano anche i suoi pareri.

### Scenario: scrittura diretta
- **Dato** un utente con accesso alla tabella
- **Quando** inserisce un parere direttamente
- **Allora** l'operazione si ferma

## GESTY-BAN-008 Pareri in parallelo
Livelli con lo stesso ordine si esprimono in qualunque ordine fra loro. Il bando prosegue solo quando tutti hanno dato parere favorevole.

### Scenario: un parere su due
- **Dato** settore e finanziario con lo stesso ordine
- **Quando** si esprime solo il finanziario
- **Allora** il bando resta In valutazione

## GESTY-BAN-009 Candidature
Una candidatura nasce solo su un bando approvato; un bando può averne più di una. Il finanziamento non supera il budget totale né l'importo massimo del bando, se indicato. Il cofinanziamento previsto è la differenza fra budget totale e finanziamento.

### Scenario: bando non approvato
- **Dato** un bando in valutazione
- **Quando** si inserisce una candidatura
- **Allora** l'operazione si ferma con "Si progetta solo su un bando approvato: completare prima i pareri."

## GESTY-BAN-010 Avvisi
Gli avvisi usano le iscrizioni di Gesty e compaiono nel programma.

| Avviso | Quando parte | A chi |
|---|---|---|
| Bando da valutare | all'inserimento, quando tocca al gruppo di livelli successivo, alla riapertura | iscritti, e responsabile del settore se tocca al suo livello |
| Valutazione del bando conclusa | quando il bando è approvato o scartato | iscritti e chi ha inserito il bando |
| Bando in scadenza | dalla procedura notturna `CRON`, entro `CONFIG.GG_AVVISO_SCADENZA_BANDI` giorni (10 di norma) dalla data ultima dei pareri o dalla scadenza del bando, una volta per bando e per tipo di scadenza | iscritti |

### Scenario: scadenza ripetuta
- **Dato** un bando in scadenza fra tre giorni e un utente iscritto
- **Quando** la procedura notturna gira due volte
- **Allora** l'utente riceve un solo avviso

## GESTY-BAN-011 Stato della candidatura
Lo stato si calcola dalle date: In progettazione, Non presentata (rinuncia con motivo), Presentata, Approvata, Non approvata (con motivo), In esecuzione (assegnata al settore), Chiusa. L'esito richiede la presentazione; l'assegnazione richiede l'approvazione; la chiusura richiede l'assegnazione. Una candidatura chiusa si modifica solo con `Bandi.Supervisore`.

### Scenario: esito senza presentazione
- **Dato** una candidatura in progettazione
- **Quando** si registra l'esito
- **Allora** il salvataggio si ferma con "L'esito si registra solo su una candidatura presentata."

## GESTY-BAN-012 Schermata
Il modulo mostra: Bandi, con pareri, candidature (partner e allegati) e allegati; Da valutare, con i soli pareri che l'utente può esprimere adesso e i comandi Parere favorevole e Parere contrario; Andamento economico; Enti finanziatori; Livelli di valutazione. Gli allegati usano la gestione documentale di Gesty.

### Scenario: elenco di lavoro
- **Dato** un utente con `Bandi.Parere.UfficioProgetti` e un bando rilevato
- **Quando** apre Da valutare
- **Allora** vede il bando con il livello Ufficio Progetti e può esprimere il parere

## GESTY-BAN-013 Collegamento al progetto
Una candidatura approvata si collega a un progetto operativo, uno solo. Il progetto riceve la data di approvazione del bando, la fonte di finanziamento e il settore, solo se non li ha già: nulla di valorizzato si sovrascrive.

### Scenario: progetto senza data di approvazione
- **Dato** un progetto senza data di approvazione del bando
- **Quando** lo si collega a una candidatura approvata
- **Allora** il progetto prende la data dell'esito

## GESTY-BAN-014 Confronto con il Budget
Andamento economico mette il budget della candidatura accanto a costi, ricavi e margine che il Budget calcola per il progetto collegato, con il budget residuo (budget gestito dall'ente meno costi a consuntivo) e la percentuale di spesa. Costi, ricavi, residuo e percentuale li vede solo chi ha l'autorizzazione `Budget` (GESTY-BUD-002): per gli altri valgono 0. I numeri sono quelli dell'ultima elaborazione del Budget.

### Scenario: utente senza autorizzazione Budget
- **Dato** una candidatura collegata a un progetto
- **Quando** la legge un utente senza `Budget`
- **Allora** il budget della candidatura si vede, costi e residuo valgono 0

## GESTY-BAN-015 Riapertura della valutazione
Con `Bandi.Supervisore` e un motivo, la valutazione di un bando senza candidature riparte dal primo livello: i pareri restano nello storico come annullati e non contano più.

### Scenario: bando con candidature
- **Dato** un bando con una candidatura
- **Quando** si riapre la valutazione
- **Allora** l'operazione si ferma

## GESTY-BAN-016 Livelli configurabili
Ogni cliente configura i livelli: descrizione, ordine, autorizzazione, ammissione del responsabile di settore, attivo. Di partenza: Ufficio Progetti (10), Responsabile di settore e Responsabile finanziario (20, in parallelo); Direzione (30) c'è ma è spenta. Il cambio vale subito anche per i bandi già valutati: accendere un livello riporta In valutazione i bandi approvati che non ne hanno il parere.

### Scenario: direzione accesa
- **Dato** un bando approvato
- **Quando** si attiva il livello Direzione
- **Allora** il bando torna In valutazione

## Divergenze note

Nessuna: il modulo nasce con questa specifica.

<!-- footer -->
---

[www.zebro.it/gesty](https://www.zebro.it/gesty)
<!-- /footer -->
