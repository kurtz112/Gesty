---
area: Rilevamento ore
progetto: Gesty
aggiornato: 2026-11-12
rilascio: Ticket_Gesty/345 - rilevamento ore/001
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

# Rilevamento ore

Questa specifica descrive le regole che Gesty rispetta quando si inseriscono, modificano, validano o cancellano le ore rilevate del personale e dei docenti (tabella `ORE_RILEVATE`). Descrive il comportamento atteso, non il codice. Quasi tutte le regole stanno nel database: trigger `ORE_RILEVATE_BIU0`, `ORE_RILEVATE_AIU0`, `ORE_RILEVATE_BD0`, `ORE_RILEVATE_BIU_INQUADRAMENTO`, `ORE_RILEVATE_LOG_MODIFICHE`, procedure `ORE_RILEVATE_GENERA_RILEVAMENTO`, `ORE_RILEVATE_GET_RILEVAMENTO`, `ORE_RILEVATE_SET_VALIDAZIONE`. Valgono quindi per ogni canale: modulo Rilevamento Ore della segreteria, scheda e agenda personale del docente, area personale web, importazioni.

**Fuori da quest'area**, con una specifica propria quando un lavoro le toccherà: presenze degli allievi, blocco del registro e periodi trasmessi a SIUF; importazioni GRS, Untis e OmniaTime (qui compare solo il rilevamento che generano); timesheet e stampe.

**Origine.** Ricavata il 2026-10-30 dal codice del database master e dalle preanalisi dei ticket 28, 30, 37, 53, 135, 199, 214, 219, 220, 221, 234, 271, 272, 277, 279, 296, 304, 307. Aggiornata il 2026-11-12 con il ticket 345 (GESTY-RIL-006, DIV-RIL-3).

## GESTY-RIL-001 Chi rileva
Ogni rilevamento ha un rilevatore. Se non è indicato, è la risorsa collegata all'utente che sta lavorando; un utente senza risorsa collegata non può rilevare ore.

### Scenario: rilevatore non indicato
- **Dato** un utente collegato alla risorsa 120
- **Quando** inserisce un rilevamento senza indicare il rilevatore
- **Allora** il rilevatore è la risorsa 120

### Scenario: utente senza risorsa
- **Dato** un utente non collegato a nessuna risorsa
- **Quando** salva un rilevamento
- **Allora** il salvataggio si ferma con "Utente non abilitato al rilevamento ore (login non effettuato)"

## GESTY-RIL-002 Tipi di incarico ammessi secondo il canale
Ogni tipo di incarico dichiara da dove si può rilevare (`ZZ_TIPI_INCARICO.TIPO_RILEVAMENTO_ORE`): solo dalla segreteria (`S`), solo dal docente (`D`), da entrambi (`E`). Il modulo Rilevamento Ore della segreteria ammette `S` ed `E`; scheda personale e agenda del docente ammettono `D` ed `E`. Un tipo non ammesso compare nell'elenco ma disabilitato.

### Scenario: tipo riservato alla segreteria scelto dal docente
- **Dato** un tipo di incarico con `TIPO_RILEVAMENTO_ORE = 'S'`
- **Quando** il docente lo sceglie dalla propria scheda o dall'agenda
- **Allora** compare "Il valore selezionato è disabilitato." e il valore non viene accettato

## GESTY-RIL-003 Incarico facoltativo
Un rilevamento può non avere incarico. Nella scheda personale e nel modulo Rilevamento Ore l'incarico non si sceglie a mano: viene ricavato da progetto, tipo, data e ore (`INCARICHI_GET_PRESENZE`); se nessun incarico li copre, o se quello che li copre non ha ore residue sufficienti, il campo resta vuoto e il rilevamento si salva lo stesso. Le ore senza incarico non entrano nei controlli legati all'incarico (GESTY-RIL-005, 013, 014, 015) e nella validazione (GESTY-RIL-008); la sovrapposizione con altre ore dello stesso docente viene invece controllata (GESTY-RIL-006).

### Scenario: nessun incarico copre il rilevamento
- **Dato** un docente senza incarichi sul progetto per quel tipo e quella data
- **Quando** rileva un'ora dalla scheda personale
- **Allora** il rilevamento si salva senza incarico

## GESTY-RIL-004 Niente ore su progetti provvisori
Non si rilevano ore su un progetto provvisorio (`PROGETTI.PROVVISORIO`), né inserendo un rilevamento né spostandone uno su quel progetto.

### Scenario: progetto provvisorio
- **Dato** un progetto provvisorio
- **Quando** si inserisce un rilevamento su quel progetto, o se ne sposta uno su di esso
- **Allora** il salvataggio si ferma con "Rilevamento ore su progetti provvisori."

## GESTY-RIL-005 Incarico coerente con il rilevamento
Se il rilevamento indica un incarico, l'incarico deve essere valido per progetto, risorsa, data, tipo, corso, piano personalizzato, servizio erogato e materia del rilevamento (`INCARICHI_GET`).

### Scenario: incarico scaduto alla data
- **Dato** un incarico che termina il 30/06
- **Quando** si rileva un'ora del 01/07 su quell'incarico
- **Allora** il salvataggio si ferma con "Incarico non valido per questo rilevamento ore."

## GESTY-RIL-006 Nessuna sovrapposizione per lo stesso docente
Una persona non può essere in due posti nello stesso momento: due rilevamenti della stessa risorsa nello stesso giorno non si sovrappongono. Le fasce si toccano senza sovrapporsi (09:00-10:00 e 10:00-11:00 sono ammesse). La sovrapposizione è ammessa solo fra incarichi **collegati**: uno è il master dell'altro, oppure hanno lo stesso master (`INCARICO_IS_COLLEGATO`); la sostituzione (`ID_INCARICO_SOSTITUZIONE`) non conta. Due rilevamenti sullo stesso incarico sovrapposti sono invece un errore.

Il controllo non si fa per le risorse che sono aziende (`AZIENDE`), che rappresentano più persone. Per un rilevamento con incarico si ripete a ogni salvataggio della riga, anche quando cambia un campo che non c'entra con l'orario.

Un rilevamento **senza incarico** viene controllato quando viene inserito e quando cambiano risorsa, data, ora di inizio o ora di fine (ticket 345): è il caso di chi rileva una seconda volta ore già presenti su un incarico esaurito, che resta senza incarico perché la ricerca automatica scarta gli incarichi senza ore residue (GESTY-RIL-003). Non viene controllato in due casi: quando si salva senza toccare l'orario, per non bloccare le righe già sovrapposte prima del ticket 345; e durante le elaborazioni automatiche (OmniaTime con `CONST_FLAGS.ELABORAZIONE_PRESENZE`, importazione GRS con `CONST_FLAGS.IMPORT_FILE_GRS`), che non hanno un utente a cui mostrare il messaggio. Fino al ticket 345 il rilevamento senza incarico non veniva controllato mai: l'esclusione era stata introdotta il 27.10.2023 e confermata il 23.11.2024.

### Scenario: due progetti nella stessa ora
- **Dato** un docente con un rilevamento il 12/10 dalle 09:00 alle 11:00 sul progetto A
- **Quando** si rileva per lui il 12/10 dalle 10:00 alle 12:00 sul progetto B, con un incarico non collegato
- **Allora** il salvataggio si ferma con "Sovrapposizione con un altro inserimento per lo stesso docente."
- **E** il messaggio indica docente, data, fascia e i rilevamenti in conflitto (al massimo 5, poi "e altri N"), ciascuno con id, fascia, tipo e progetto

### Scenario: fasce contigue
- **Dato** un rilevamento dalle 09:00 alle 10:00
- **Quando** se ne inserisce uno dalle 10:00 alle 11:00 per lo stesso docente
- **Allora** il salvataggio riesce

### Scenario: lezione con più incarichi collegati
- **Dato** un incarico master e il suo incarico collegato sulla stessa lezione
- **Quando** si rilevano le stesse ore su entrambi
- **Allora** il salvataggio riesce

### Scenario: stesso incarico due volte
- **Dato** un rilevamento dalle 09:00 alle 11:00 sull'incarico 500
- **Quando** se ne inserisce un altro dalle 10:00 alle 12:00 sullo stesso incarico
- **Allora** il salvataggio si ferma per sovrapposizione

### Scenario: rilevamento senza incarico sovrapposto
- **Dato** un docente con un rilevamento il 16/10 dalle 14:30 alle 15:30 su un incarico esaurito
- **Quando** si inserisce per lui il 16/10 dalle 14:30 alle 18:30 sullo stesso progetto, e il rilevamento resta senza incarico
- **Allora** il salvataggio si ferma con "Sovrapposizione con un altro inserimento per lo stesso docente."

### Scenario: nota su una riga senza incarico già sovrapposta
- **Dato** un rilevamento senza incarico già presente e sovrapposto a un altro
- **Quando** se ne cambia solo la nota
- **Allora** il salvataggio riesce

### Scenario: ora senza incarico da un'elaborazione automatica
- **Dato** un docente con un rilevamento dalle 09:00 alle 11:00
- **Quando** un'elaborazione automatica (OmniaTime, importazione GRS) inserisce per lui un rilevamento senza incarico dalle 09:30 alle 10:30
- **Allora** il salvataggio riesce

### Scenario: risorsa azienda
- **Dato** una risorsa che è un'azienda fornitrice
- **Quando** le si rilevano due fasce sovrapposte
- **Allora** il salvataggio riesce

## GESTY-RIL-007 Rilevamento generato da altre funzioni
Presenze individuali degli allievi, sostegno e interventi integrativi importati da GRS, orario delle lezioni generano il rilevamento del docente con `ORE_RILEVATE_GENERA_RILEVAMENTO`. La procedura prima cerca un rilevamento da riusare: stesso docente, progetto, corso e data, fascia sovrapposta, e lo stesso incarico o nessun incarico. Se lo trova lo riusa; altrimenti ne crea uno nuovo, che porta anche piano personalizzato e servizio erogato della presenza. Una sovrapposizione con un altro rilevamento ferma l'operazione con il messaggio di GESTY-RIL-006, oppure fa saltare la generazione senza avviso quando chi chiama lo chiede (`RAISE_ERRORS = FALSE`).

Il rilevamento generato si scollega da tutte le righe che lo citano quando viene cancellato (GESTY-RIL-018). Una presenza individuale cancellata cancella il suo rilevamento solo se nessun'altra riga lo usa.

### Scenario: presenza individuale nuova
- **Dato** una presenza individuale con stato P, da calcolare e con un incarico valido
- **Quando** viene inserita
- **Allora** nasce il rilevamento del docente e la presenza ne conserva l'id (`STUDENTI_PRESENZE_INDIVIDUALE.ID_RILEVAMENTO_ORE`)

### Scenario: presenza individuale sovrapposta
- **Dato** un docente con un altro rilevamento non collegato nella stessa fascia
- **Quando** si inserisce la presenza individuale
- **Allora** l'inserimento si ferma con il messaggio di sovrapposizione

### Scenario: due presenze sulla stessa lezione
- **Dato** un rilevamento già generato per il docente su quella lezione
- **Quando** si genera la presenza di un secondo allievo sulla stessa fascia e lo stesso incarico
- **Allora** si riusa il rilevamento esistente, senza crearne un secondo

## GESTY-RIL-008 Validazione
Validare un rilevamento significa confermarlo per compensi e rendicontazione. Serve l'autorizzazione `Risorse.ValidazioneOreRilevate`; per togliere la validazione servono questa e `Risorse.SbloccoOreValidate`. Si validano solo rilevamenti con incarico. Chi valida, quando, e ogni validazione o sblocco restano registrati (`ID_VALIDATORE`, `DATA_ORA_VALIDAZIONE`, `ORE_RILEVATE_VALIDAZIONI`).

### Scenario: validazione senza autorizzazione
- **Dato** un utente senza `Risorse.ValidazioneOreRilevate`
- **Quando** valida un rilevamento
- **Allora** l'operazione si ferma con l'errore di autorizzazione

### Scenario: sblocco riservato
- **Dato** un utente che ha `Risorse.ValidazioneOreRilevate` ma non `Risorse.SbloccoOreValidate`
- **Quando** toglie la validazione
- **Allora** l'operazione si ferma con l'errore di autorizzazione

## GESTY-RIL-009 Un rilevamento validato non si modifica
Su un rilevamento validato non si cambiano risorsa, data, ore di inizio e fine, progetto, tipo incarico, piano personalizzato, servizio erogato, descrizione dell'attività e incarico: prima va tolta la validazione (GESTY-RIL-008). Materia, note e gli altri campi restano modificabili.

### Scenario: correzione dell'orario di un'ora validata
- **Dato** un rilevamento validato
- **Quando** si cambia l'ora di fine
- **Allora** il salvataggio si ferma con "Il rilevamento risulta validato. Id Rilevamento: <id>"

### Scenario: nota su un'ora validata
- **Dato** un rilevamento validato
- **Quando** si cambia la nota
- **Allora** il salvataggio riesce

## GESTY-RIL-010 Le ore di un altro si rettificano solo con autorizzazione
Sui rilevamenti non validati, i campi di GESTY-RIL-009 li modifica liberamente solo chi li ha rilevati. Gli altri hanno bisogno di `Risorse.RettificaOreValidate`. Fa eccezione l'importazione GRS, che riscrive i rilevamenti che ha generato.

### Scenario: segreteria corregge l'ora di un docente
- **Dato** un rilevamento non validato inserito dal docente
- **Quando** un utente della segreteria senza `Risorse.RettificaOreValidate` ne cambia la data
- **Allora** il salvataggio si ferma con l'errore di autorizzazione

## GESTY-RIL-011 Cancellazione di ore validate
Le ore validate alimentano compensi e rendicontazione: le cancella solo chi ha `Risorse.ValidazioneOreRilevate`. Dall'agenda l'avviso arriva prima del tentativo, in termini comprensibili; il database fa comunque lo stesso controllo per ogni altro canale.

### Scenario: cancellazione dall'agenda senza autorizzazione
- **Dato** un rilevamento validato e un utente senza `Risorse.ValidazioneOreRilevate`
- **Quando** lo elimina dall'agenda
- **Allora** compare "Le ore selezionate sono gia' state validate e non si possono cancellare. Chieda a un supervisore di togliere la validazione, poi potra' cancellarle."
- **E** il rilevamento resta

## GESTY-RIL-012 Rilevamento legato all'orario delle lezioni
Un rilevamento citato da una riga dell'orario (`ORARIO.ID_RILEVAMENTO_ORE`, `_COD_1`, `_COD_2`, `_COD_3`) non cambia risorsa, data, ore, progetto e tipo incarico: va corretta la lezione. Le procedure che riallineano orario e rilevamenti sospendono il controllo (`CONST_FLAGS.BLOCCA_CONTROLLO_FIRMA_ORARIO`).

### Scenario: spostamento di un'ora generata dall'orario
- **Dato** un rilevamento collegato a una lezione
- **Quando** se ne cambia l'ora di inizio
- **Allora** il salvataggio si ferma con "L'orario risulta firmato, impossibile modificare il rilevamento."

## GESTY-RIL-013 Piano personalizzato obbligatorio dove serve
Su un progetto con piani personalizzati (`PROGETTI.PIANI_PERSONALIZZATI`), piano personalizzato e servizio erogato sono obbligatori, salvo per i tipi di incarico che non lo richiedono (`ZZ_TIPI_INCARICO.VERIFICA_PIP = FALSE`). Dove non servono, il rilevamento non li conserva.

### Scenario: piano mancante
- **Dato** un progetto con piani personalizzati e un tipo di incarico che li richiede
- **Quando** si salva un rilevamento senza piano
- **Allora** il salvataggio si ferma con "Piano personalizzato non specificato."

### Scenario: servizio mancante
- **Dato** lo stesso progetto e un piano indicato
- **Quando** si salva un rilevamento senza servizio erogato
- **Allora** il salvataggio si ferma con "Servizio erogato del piano personalizzato non specificato."

## GESTY-RIL-014 Tetto delle ore del servizio nel piano personalizzato
Dove il piano è richiesto (GESTY-RIL-013), le ore rilevate su incarico, piano e servizio non superano quelle assegnate al servizio (`INCARICHI_PIANI_PERS_SERVIZI.ORE_PIP`), salvo i progetti che ammettono il superamento (`PROGETTI.CONSENTI_SUPERAMENTO_ORE_PIP`).

### Scenario: servizio esaurito
- **Dato** un servizio con 10 ore assegnate e 9 già rilevate
- **Quando** si rilevano altre 2 ore
- **Allora** il salvataggio si ferma con "Superato il numero di ore massimo per il servizio erogato."

## GESTY-RIL-015 Tetto delle ore dell'incarico
Le ore rilevate su un incarico non superano le ore attribuite (`INCARICO_DETAIL`), salvo gli incarichi che ammettono il superamento (`CONSENTI_SUPERAMENTO_ORE`). Il controllo si fa dopo la scrittura, sul totale aggiornato, e non durante le elaborazioni delle presenze (`CONST_FLAGS.ELABORAZIONE_PRESENZE`) né quando si toglie una validazione.

### Scenario: monte ore esaurito
- **Dato** un incarico di 20 ore con 19 già rilevate e senza superamento ammesso
- **Quando** si rilevano altre 2 ore
- **Allora** il salvataggio si ferma con "Le ore inserite superano il monte ore residuo per l'incarico. Verifica i dati rilevati oppure contattare il responsabile per una verifica dell'incarico."
- **E** il messaggio riporta ore attribuite, rilevate e residue

### Scenario: superamento ammesso
- **Dato** lo stesso incarico con `CONSENTI_SUPERAMENTO_ORE` vero
- **Quando** si rilevano altre 2 ore
- **Allora** il salvataggio riesce

## GESTY-RIL-016 Tetto delle ore del cedolino
Se per il mese della data sono registrate le ore del cedolino del dipendente (`PERSONALE_ORE_CEDOLINO`), le ore rilevate nel mese non le superano. Senza ore del cedolino il controllo non si fa.

### Scenario: mese chiuso dal cedolino
- **Dato** un dipendente con 120 ore di cedolino a ottobre e 119 già rilevate
- **Quando** si rilevano altre 2 ore in ottobre
- **Allora** il salvataggio si ferma con "Ore rilevate maggiori delle ore cedolino."

## GESTY-RIL-017 Fatturata e ore di recupero
Due campi del rilevamento richiedono un'autorizzazione propria: segnare o togliere "fatturata" richiede `Risorse.OreRilevateFatturate`; indicare ore di recupero (`ORE_RECUPERO` maggiore di zero) richiede `Risorse.OreRecuperoAttivitaDiverse`. Chi non ha la seconda vede le ore di recupero a zero negli elenchi.

### Scenario: ore di recupero senza autorizzazione
- **Dato** un utente senza `Risorse.OreRecuperoAttivitaDiverse`
- **Quando** inserisce un rilevamento con ore di recupero
- **Allora** il salvataggio si ferma con l'errore di autorizzazione

## GESTY-RIL-018 Cancellazione e collegamenti
Cancellare un rilevamento lo scollega da tutte le righe che lo citano: righe elaborate dei file GRS, ore di sostegno, interventi integrativi, orario delle lezioni. Quelle righe restano, senza rilevamento.

### Scenario: cancellazione di un'ora di sostegno generata
- **Dato** un rilevamento citato da una riga di `ORE_SOSTEGNO`
- **Quando** il rilevamento viene cancellato
- **Allora** la riga di sostegno resta con `ID_RILEVAMENTO_ORE` vuoto

## GESTY-RIL-019 Costo congelato alla data dell'ora
Inquadramento e costo orario del rilevamento sono quelli validi alla data dell'ora (`RISORSA_INQUADRAMENTO_ALLA_DATA`, `INCARICO_GET_COSTO_ORARIO`), e si ricalcolano a ogni salvataggio. Un cambio di inquadramento successivo non tocca le ore già rilevate finché non vengono ricalcolate (`CONST_FLAGS.RICALCOLO_COSTO_ORE`, che durante il ricalcolo sospende tutti gli altri controlli).

### Scenario: inquadramento cambiato a metà anno
- **Dato** un dipendente inquadrato A fino al 31/03 e B dal 01/04
- **Quando** si rileva un'ora del 15/03
- **Allora** il rilevamento prende l'inquadramento A e il suo costo orario

## GESTY-RIL-020 Storico delle modifiche
Ogni modifica a un dato che incide su ore, costo o validazione, e ogni cancellazione, lascia in `LOG_ORE_RILEVATE` la versione precedente della riga, con l'utente e il momento. Il ricalcolo massivo dei costi non lascia traccia riga per riga.

### Scenario: correzione dell'ora di fine
- **Dato** un rilevamento dalle 09:00 alle 11:00
- **Quando** l'ora di fine diventa 12:00
- **Allora** in `LOG_ORE_RILEVATE` c'è una riga `/` con fine 11:00, l'utente e la data della modifica

## GESTY-RIL-021 Rilevamenti visibili in agenda
In agenda i rilevamenti compaiono solo se lo strato "Rilevamenti" è attivo. È un'impostazione di ciascun utente (`MostraRilevamenti` in `USR_UTENTI_SETTINGS`): il pulsante la inverte e la conserva.

### Scenario: strato spento
- **Dato** un utente che ha spento lo strato dei rilevamenti
- **Quando** riapre l'agenda
- **Allora** i rilevamenti non compaiono finché non lo riaccende

## Divergenze note

Punti in cui il codice di oggi non mantiene ciò che i requisiti dicono, o in cui due parti del codice applicano la stessa regola in modo diverso. Si correggono nella voce R-178 di `Attivita Rinviate.md`; con la correzione il requisito si aggiorna e questa sezione si accorcia.

| Codice | Divergenza | Conseguenza |
|---|---|---|
| DIV-RIL-1 | In `ORE_RILEVATE_BIU0` il controllo "Superato il numero di ore attribuite" confronta la durata con `TOTALE_ORE_RESIDUE`, che in quel blocco non viene letto da `INCARICO_DETAIL`: vale NULL fuori dai piani personalizzati, il residuo del servizio dentro. L'esclusione degli incarichi di docenza (`TIPOLOGIA_INCARICO = 'FD'`) vale solo per questo controllo | Prima della scrittura il tetto dell'incarico non scatta mai, o scatta col residuo sbagliato. Il tetto vero lo applica `ORE_RILEVATE_AIU0` dopo la scrittura (GESTY-RIL-015), su tutti gli incarichi, docenza compresa |
| DIV-RIL-2 | La sovrapposizione si verifica con due condizioni diverse. Il trigger `BIU0` considera sovrapposti anche due rilevamenti sullo stesso incarico ed esclude le aziende; `ORE_RILEVATE_GENERA_RILEVAMENTO` lascia passare lo stesso incarico e non esclude le aziende, ma per il messaggio usa `ORE_RILEVATE_SOVRAPPOSIZIONE_MSG`, che segue la condizione del trigger | Una generazione automatica può fermarsi su un'azienda che a mano si salverebbe; il messaggio della generazione può elencare rilevamenti che per la procedura non erano in conflitto (ticket 271, 272) |
| DIV-RIL-3 | Ridotta dal ticket 345: a mano un'ora senza incarico non entra più sopra un'ora esistente. Resta che un rilevamento senza incarico già presente, o inserito da un'elaborazione automatica, conta come conflitto per gli altri (`INCARICO_IS_COLLEGATO` con un incarico nullo restituisce falso), mentre lui stesso si risalva senza controllo | Dove un'ora senza incarico è sovrapposta a un'altra, ogni salvataggio dell'altra riga, anche un ricalcolo che non tocca l'orario, si ferma per sovrapposizione (ticket 28, rielaborazione OmniaTime; ticket 296, 13:00-17:00 e 13:30-17:00) |
| DIV-RIL-4 | Un conflitto nella generazione automatica ha tre esiti: blocca l'inserimento di una presenza individuale e l'importazione del sostegno GRS; viene ignorato nella modifica di una presenza individuale; viene ingoiato senza avviso nell'importazione GRS della collettiva (`ORARIO_GENERA_RILEVAMENTO(..., FALSE)`) | Nella collettiva una supplenza in conflitto resta a 0 ore e la lezione senza rilevamento, senza che nessuno lo sappia (ticket 307) |
| DIV-RIL-5 | `STUDENTI_PRESENZE_INDIVIDUALE_RILEVAMENTO_BIU` esce subito se la presenza ha già un rilevamento | Cambiando data, ora o durata di una presenza già agganciata, il rilevamento del docente resta quello vecchio; l'analisi del ticket 219 chiedeva il riallineamento |
| DIV-RIL-6 | `ORE_RILEVATE_GET_RILEVAMENTO` legge il rilevamento da riusare con un'assegnazione a valore singolo | Se esistono già due rilevamenti sovrapposti con gli stessi dati (possibile per DIV-RIL-3), la generazione si ferma con l'errore di Firebird "multiple rows in singleton select" invece di un messaggio comprensibile. Un rilevamento si riusa anche se ha un piano personalizzato diverso (ticket 221) |
| DIV-RIL-7 | Dove il piano personalizzato non è richiesto, `BIU0` svuota piano e servizio anche quando il progetto ha i piani personalizzati e l'utente li ha compilati | Il dato scritto dall'utente sparisce senza avviso (ticket 53, ancora aperto). Il ticket 221 considera invece giusto che, con `VERIFICA_PIP = FALSE`, il rilevamento nasca senza piano: va deciso quale delle due regole vale |
| DIV-RIL-8 | Il blocco di GESTY-RIL-012 guarda solo che il rilevamento sia citato dall'orario, non che la lezione sia firmata (`ORARIO.BLOCCA_RILEVAMENTI_DOCENTI`); inoltre vale per la modifica ma non per la cancellazione, che scollega l'orario (GESTY-RIL-018) | Il messaggio parla di firma anche su lezioni mai firmate; un rilevamento che non si può spostare si può cancellare |
| DIV-RIL-9 | Cancellare un'ora validata richiede `Risorse.ValidazioneOreRilevate` (`ORE_RILEVATE_BD0`), togliere la validazione richiede anche `Risorse.SbloccoOreValidate`. L'autorizzazione `Risorse.RettificaOreValidate` serve invece a correggere ore **non** validate di altri (GESTY-RIL-010) | Chi può validare ma non sbloccare può far sparire un'ora validata, non correggerla; l'avviso dell'agenda gli dice di chiedere lo sblocco, che non gli serve. Il nome dell'autorizzazione di rettifica dice il contrario di ciò che controlla |
| DIV-RIL-10 | `ORE_RILEVATE_SET_VALIDAZIONE` scrive la riga in `ORE_RILEVATE_VALIDAZIONI` anche quando non ha cambiato nulla (rilevamento senza incarico o già nello stato chiesto) | Lo storico delle validazioni registra validazioni mai avvenute |
| DIV-RIL-11 | L'assegnazione automatica dell'incarico nella scheda personale (`INCARICHI_GET_PRESENZE`) scarta gli incarichi esauriti anche quando ammettono il superamento delle ore | Ore che potevano andare sull'incarico restano senza (ticket 304, punto 4); `INCARICHI_GET_X_SOSTEGNO` è già stata corretta nel ticket 167 |

<!-- footer -->
---

[www.zebro.it/gesty](https://www.zebro.it/gesty)
<!-- /footer -->
