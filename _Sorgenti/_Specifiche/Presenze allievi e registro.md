---
area: Presenze degli allievi e registro
progetto: Gesty
aggiornato: 2026-10-30
rilascio: OUT/20261030-specifiche-vive-dei-progetti/012
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

# Presenze degli allievi e registro

Questa specifica descrive le regole che Gesty rispetta quando registra, modifica, firma, blocca o cancella le presenze degli allievi alle lezioni: le presenze collettive, una per allievo e per ora dell'orario (`STUDENTI_PRESENZE_COLLETTIVA`), e le presenze individuali dei piani personalizzati (`STUDENTI_PRESENZE_INDIVIDUALE`). Descrive il comportamento atteso, non il codice. Le regole stanno quasi tutte nel database: trigger `STUDENTI_PRESENZE_COLLETTIVA_BI`, `STUDENTI_PRESENZE_COLLETT_BIUD0`, `STUDENTI_PRESENZE_COLLETTIVA_CHECK_SIUF`, `STUDENTI_PRES_COLL_CHECK_SOVRAP`, `STUDENTI_PRESENZE_INDIVIDUALE_RILEVAMENTO_BIU` e `_AD`, `STUDENTI_PROGETTI_AI0` e `_BD0`, `ORARIO_BIU0`; procedure `STUDENTI_PRESENZE_COLL_TMP_PREP`, `_SAVE`, `_UPD`, `_FIRM`, `STUDENTI_PRESENZE_COLL_BLOCCA`, `STUDENTI_PRESENZE_CHECK_SOVRAPP`. La schermata principale è il Registro Collettivo (`TFrameRegistroCollettivo`, modulo dati `TRegistroStudenti`), che lavora per giornata: progetto, corso e data.

**Regole già scritte altrove, qui solo richiamate:** le presenze di stage e la loro generazione dal calendario stanno in Tirocini (GESTY-TIR-012, 013, 014, 015, 020); il rilevamento delle ore del docente, compreso quello generato dalle presenze individuali e dall'orario, sta in Rilevamento ore (GESTY-RIL-007, 012, 018 e DIV-RIL-4, 5, 6).

**Fuori da quest'area**, con una specifica propria quando un lavoro le toccherà: trasmissione a SIUF e costruzione del tracciato (qui compare solo il blocco delle presenze già trasmesse, GESTY-PRE-017); importazioni GRS, Untis e OmniaTime (qui compaiono solo le presenze che producono); sostegno e interventi integrativi; stampe e riepiloghi.

**Origine.** Ricavata il 2026-10-30 dal database master (fotografia `GESTY` del 2026-10-30 13:19) e dal sorgente in `SRC`, a partire dalle preanalisi dei ticket 47, 179, 198, 214, 219, 221, 226, 230, 237, 251, 260, 275. Ogni regola è stata riletta sul codice; dove una regola viene solo da un ticket, il ticket è citato.

## GESTY-PRE-001 Due tipi di presenza
Una presenza collettiva lega un allievo a un'ora dell'orario (`ORARIO`): data, orario, materia, docente e tipologia sono quelli della lezione, l'allievo ha una sola presenza per ora (`UNQ1_STUDENTI_PRESENZE_COLLETTI`). Una presenza individuale vive dentro il piano personalizzato dell'allievo e porta da sé data, ora di inizio, durata, risorsa, tipo di incarico, piano e servizio erogato, tutti obbligatori. Le presenze di stage seguono Tirocini; sostegno e interventi integrativi hanno tabelle proprie.

### Scenario: due presenze sulla stessa ora
- **Dato** un allievo con la presenza alla lezione del 12/10 delle 09:00
- **Quando** se ne registra una seconda sulla stessa ora
- **Allora** il salvataggio si ferma per il vincolo di unicità

## GESTY-PRE-002 Stati della presenza
Lo stato di una presenza è presente (`P`), assente (`A`) o assente giustificato (`G`). Presente vale per `P`; assente vale per `A` e `G`; giustificato solo per `G`; da giustificare solo per `A`. Lo stato `B` serve solo al registro per mostrare "Non Svolta" sulle ore di una lezione non svolta (GESTY-PRE-003) e non si salva come tale dal registro. Il dominio ammette anche `I` ("INDIVIDUALE"), che nessun oggetto del database usa (DIV-PRE-10).

### Scenario: assenza giustificata
- **Dato** un allievo segnato `G` su un'ora
- **Quando** si leggono le sue ore
- **Allora** l'ora conta come assenza, giustificata

## GESTY-PRE-003 Lezione non svolta
Una lezione segnata non svolta (`ORARIO.LEZIONE_SVOLTA = FALSE`) vale per tutta la classe. Nel registro le sue ore compaiono come "Non Svolta" per ogni allievo, ma lo stato salvato delle presenze non cambia: se la lezione torna svolta, ogni allievo ritrova lo stato che aveva. Una presenza mancante su un'ora non svolta si salva come presente. Le ore non svolte non contano come presenza né come assenza: le escludono il registro unificato (`STUDENTI_REGISTRO_PRESENZE`), l'esportazione verso SIUF (`GRS_EXPORT_COLLETTIVA`, ticket 230), i controlli di sovrapposizione fatti dalle altre presenze dell'allievo e il controllo delle presenze già trasmesse (GESTY-PRE-017). La firma non genera il rilevamento del docente per un'ora non svolta (GESTY-PRE-011).

### Scenario: lezione annullata dopo l'appello
- **Dato** una classe con le presenze del 09/10 alle 09:00 già registrate, alcune `P` e alcune `G`
- **Quando** la lezione viene segnata non svolta
- **Allora** il registro mostra "Non Svolta" per tutti, l'esportazione verso SIUF non riporta quell'ora, e lo stato salvato resta `P` o `G`

### Scenario: lezione ripristinata
- **Dato** la stessa lezione
- **Quando** torna svolta
- **Allora** ogni allievo ritrova lo stato di prima

## GESTY-PRE-004 Presenza esclusa dal calcolo
Ogni presenza ha l'indicazione "Calcolare" (`CALCOLARE`): tolta, la presenza resta registrata con il suo stato ma vale zero ore, non entra nelle esportazioni (GRS, SIUF, Regione Lombardia) e non partecipa ai controlli di sovrapposizione. È il modo di escludere un singolo allievo da una singola ora senza un nuovo stato (ticket 179). Nel Registro Collettivo la casella c'è per ogni ora ("Calc.") e per l'allievo ("Calcolare", vera se lo sono tutte le sue ore; cambiarla cambia tutte le ore), con le stesse regole di blocco delle altre colonne (ticket 260). Una presenza creata dal registro o dall'iscrizione nasce da calcolare; l'assenza creata d'ufficio dall'importazione GRS per l'allievo che il file non riporta nasce esclusa (ticket 260, cenno). La stessa indicazione si cambia anche dal registro unificato delle presenze, che la riporta alla tabella di origine.

### Scenario: allievo da non conteggiare
- **Dato** un allievo assente il 19/10 alle 08:00
- **Quando** si toglie "Calc." su quell'ora e si salva
- **Allora** la presenza resta assente, vale zero ore e non va nell'esportazione verso SIUF

## GESTY-PRE-005 Ore della presenza
Una presenza collettiva dura quanto l'ora di lezione. Su ogni ora si possono indicare i minuti di ritardo o di uscita anticipata ("R/A"), da 0 a 60 (`CHK1_STUDENTI_PRESENZE_COLLETTI`). Una presenza individuale dura più di zero minuti e al massimo 720. Le ore di presenza e di assenza valgono solo per le presenze da calcolare (GESTY-PRE-004).

### Scenario: ritardo oltre l'ora
- **Dato** un'ora di lezione
- **Quando** si indicano 75 minuti di ritardo
- **Allora** il salvataggio si ferma per il vincolo sui minuti

## GESTY-PRE-006 La giornata del registro nasce tutta presente
Aprendo una giornata nel Registro Collettivo, ogni allievo iscritto al progetto e al corso alla data della lezione (fra data di iscrizione e data di ritiro) compare su ogni ora; dove non c'è ancora una presenza, compare presente e da calcolare. Il registro segnala che c'è lavoro da salvare quando mancano presenze su ore non congelate. Il salvataggio (comando Salva, firma, chiusura con conferma delle modifiche) crea le presenze mancanti e riscrive solo quelle cambiate in stato, minuti, tipologia (FAD) o "Calcolare"; non tocca mai le ore congelate (GESTY-PRE-012). Ogni modifica a una cella si salva subito nella tabella di appoggio del registro e passa alle presenze al salvataggio.

### Scenario: appello su una giornata nuova
- **Dato** una classe di 20 allievi e una giornata di 5 ore senza presenze
- **Quando** si apre la giornata, si segnano due assenti e si salva
- **Allora** nascono 100 presenze: 98 presenti e 2 assenti, tutte da calcolare

### Scenario: allievo non ancora iscritto
- **Dato** un allievo iscritto dal 15/10
- **Quando** si apre la giornata del 14/10
- **Allora** l'allievo non compare

## GESTY-PRE-007 Presenza coerente con l'iscrizione
Una presenza collettiva si registra solo per un allievo iscritto al progetto della lezione alla data della lezione, e la regola si ripete quando la presenza viene spostata su un'altra ora.

### Scenario: allievo già ritirato
- **Dato** un allievo ritirato il 22/04
- **Quando** gli si registra una presenza su una lezione del 02/09
- **Allora** il salvataggio si ferma con "Progetto non valido per lo studente."

## GESTY-PRE-008 Iscrizione e ritiro riallineano le presenze
Quando si inserisce un'iscrizione o se ne cambiano progetto, data di iscrizione o data di ritiro, le presenze collettive dell'allievo si riallineano al periodo:
- **dentro il periodo** nascono, presenti e da calcolare, le presenze mancanti sulle lezioni fino a oggi, salvo le giornate già trasmesse a SIUF (saltate senza avviso) e le ore in cui l'allievo ha già un'altra presenza presente e da calcolare (individuale, sostegno, interventi integrativi, stage);
- **fuori dal periodo** le presenze dell'allievo vengono cancellate, insieme al collegamento con la riga d'importazione GRS da cui erano nate. Qui le giornate già trasmesse non si saltano: la cancellazione si ferma con il controllo di GESTY-PRE-017.

Un'iscrizione non si cancella se l'allievo ha presenze su lezioni svolte del periodo.

### Scenario: ritiro retrodatato
- **Dato** un allievo con 48 assenze registrate dopo il 22/04, nessuna in giornate congelate o trasmesse
- **Quando** si registra la data di ritiro 22/04
- **Allora** le 48 presenze vengono cancellate e il ritiro si salva

### Scenario: iscrizione tardiva
- **Dato** un allievo iscritto dal 14/09 e lezioni già registrate per la classe dal 14/09
- **Quando** si salva l'iscrizione
- **Allora** nascono le sue presenze dal 14/09 a oggi, presenti

### Scenario: cancellazione dell'iscrizione con presenze
- **Dato** un'iscrizione con presenze su lezioni svolte
- **Quando** la si cancella
- **Allora** l'operazione si ferma con "Esistono rilevamenti per questo studente e progetto: impossibile eliminare."

## GESTY-PRE-009 Iscrizione e ritiro su giornate congelate
Se il riallineamento di GESTY-PRE-008 dovrebbe creare o cancellare presenze in giornate congelate (GESTY-PRE-012), l'operazione si ferma prima di scrivere, con un solo messaggio che dice quante giornate, la prima e l'ultima, e il comando da usare. Il blocco non ha deroghe, nemmeno per chi può sbloccare: l'utente sblocca le giornate, ripete l'operazione e le blocca di nuovo (ticket 198).

### Scenario: ritiro con giornate congelate
- **Dato** un allievo iscritto dal 14/10/2025 con assenze in tre giornate congelate del settembre successivo
- **Quando** si registra il ritiro al 22/04/2026
- **Allora** l'operazione si ferma con "Con iscrizione dal 14/10/2025 e ritiro al 22/04/2026 restano fuori dal periodo presenze dell'allievo in 3 giornate con il registro bloccato, dal 02/09/2026 al 04/09/2026. Per eliminarle sbloccare prima le presenze di quelle giornate dal Registro Collettivo (comando Sblocca Presenze), ripetere l'operazione e poi bloccarle di nuovo."
- **E** nessuna presenza cambia

### Scenario: iscrizione anticipata su giornate congelate
- **Dato** cinque giornate congelate dal 14/09 al 18/09 senza presenze dell'allievo
- **Quando** si salva l'iscrizione dal 14/09
- **Allora** l'operazione si ferma con "Con iscrizione dal 14/09/2026 mancano presenze dell'allievo in 5 giornate con il registro bloccato, dal 14/09/2026 al 18/09/2026. Per salvare l'iscrizione sbloccare prima ..."

## GESTY-PRE-010 Nessuna sovrapposizione per lo stesso allievo
Un allievo non può essere presente in due posti nello stesso momento: una presenza presente e da calcolare non si sovrappone a un'altra presenza presente e da calcolare dello stesso allievo, collettiva, individuale, di sostegno, di interventi integrativi o di stage (`STUDENTI_PRESENZE_CHECK_SOVRAPP`, lo stesso controllo di GESTY-TIR-014). Sono ammesse la lezione collettiva insieme al sostegno, e lo stage insieme al sostegno. Le assenze e le presenze escluse dal calcolo non contano; dalla parte delle altre presenze, non contano nemmeno le ore di lezioni non svolte (DIV-PRE-3).

### Scenario: presenza individuale durante la lezione
- **Dato** un allievo presente in aula il 15/10 dalle 09:00 alle 10:00
- **Quando** gli si registra una presenza individuale presente il 15/10 dalle 09:30
- **Allora** il salvataggio si ferma con "Esistono rilevamenti registro collettivo per lo studente <nominativo>. - " seguito da allievo, data e ora

### Scenario: allievo assente in aula
- **Dato** lo stesso allievo segnato assente in aula
- **Quando** gli si registra la stessa presenza individuale
- **Allora** il salvataggio riesce

## GESTY-PRE-011 Firma del registro
La firma riguarda la giornata intera (progetto, corso, data) e chiede conferma ("Si desidera firmare il registro? Attenzione: saranno impedite ulteriori modifiche."). Prima salva la giornata (GESTY-PRE-006), poi, per ogni ora non ancora firmata e svolta, genera i rilevamenti del docente e dei codocenti (il rilevamento resta legato alla lezione, GESTY-RIL-012) e segna l'ora firmata; infine congela le presenze (GESTY-PRE-012). Serve l'autorizzazione `Registro.BloccaDocenti`. La firma si ferma se un'ora svolta non ha il docente ("Docente non assegnato. Ora Inizio: <ora>") o se per il docente o un codocente non si trova l'incarico ("Incarico non assegnato. Ora Inizio: <ora>"); il registro mostra per ogni ora gli incarichi mancanti.

La giornata risulta "Firmato" solo se tutte le sue ore sono firmate. Annullare la firma ("Si desidera annullare la firma del registro?") richiede `Registro.SbloccaDocenti`, toglie la firma dalle ore e lascia i rilevamenti già generati e il congelamento delle presenze. Su una giornata firmata la scheda della lezione aperta dal registro è in sola lettura e la forzatura della tipologia di formazione si rifiuta con "Il registro risulta firmato.".

### Scenario: firma di una giornata completa
- **Dato** una giornata di 5 ore svolte con docente e incarico
- **Quando** si firma
- **Allora** nascono i rilevamenti dei docenti, le ore risultano firmate, le presenze congelate, e il comando diventa "Firmato"

### Scenario: incarico mancante
- **Dato** un'ora svolta il cui docente non ha un incarico valido per quella lezione
- **Quando** si firma
- **Allora** la firma si ferma con "Incarico non assegnato. Ora Inizio: <ora>" e nessuna ora della giornata risulta firmata

### Scenario: annullamento della firma
- **Dato** una giornata firmata
- **Quando** un utente con `Registro.SbloccaDocenti` annulla la firma
- **Allora** le ore tornano non firmate, i rilevamenti dei docenti restano e le presenze restano congelate

## GESTY-PRE-012 Presenze congelate
Una presenza su un'ora congelata (`ORARIO.BLOCCA_PRESENZE_STUDENTI`) non si crea, non si modifica e non si cancella, da nessun canale: registro, schede, importazioni, iscrizione e ritiro. Il congelamento nasce dalla firma (GESTY-PRE-011) e vale ora per ora: nel registro le celle delle ore congelate non si modificano, le altre sì, e le colonne complessive dell'allievo sono bloccate se lo è almeno un'ora. Una colonna del riquadro delle materie indica quali ore sono congelate. Il congelamento vale dalle firme fatte dopo il rilascio del ticket 47: le lezioni firmate prima non sono state congelate a ritroso (ticket 47). Nelle schede della lezione la casella "Blocca Presenze Studenti" è in sola lettura.

### Scenario: correzione su un'ora congelata
- **Dato** una giornata firmata e congelata
- **Quando** da una scheda si cambia lo stato di un allievo sull'ora delle 08:30
- **Allora** il salvataggio si ferma con "Le presenze della lezione 02/09/2026 08:30-09:30 ARTE DEL CIOCCOLATO risultano bloccate. Per modificarle serve lo sblocco del registro. IdOrario:  (<id>)"

### Scenario: giornata con ore in stati diversi
- **Dato** una giornata con le prime due ore congelate e le altre no
- **Quando** si salva il registro
- **Allora** si salvano le ore non congelate e le prime due restano com'erano, senza errore

## GESTY-PRE-013 Sblocco e nuovo blocco delle presenze
Le presenze congelate si sbloccano solo dal comando del Registro Collettivo "Sblocca Presenze", per la giornata intera, dopo la conferma ("Si desidera sbloccare le presenze di questa giornata? Sarà possibile modificarle fino al blocco successivo."). Il comando è visibile solo a chi ha `Registro.SbloccaStudenti`; sbloccare richiede `Registro.SbloccaStudenti`, ricongelare con "Blocca Presenze" richiede `Registro.BloccaStudenti` (DIV-PRE-9). Sblocco e blocco toccano solo le presenze: la firma dei docenti resta com'è.

### Scenario: correzione autorizzata
- **Dato** una giornata congelata e un utente con `Registro.SbloccaStudenti`
- **Quando** sblocca, corregge un'assenza e ricongela
- **Allora** la correzione resta e la giornata torna congelata

### Scenario: utente senza autorizzazione
- **Dato** un utente senza `Registro.SbloccaStudenti`
- **Quando** apre una giornata congelata
- **Allora** il comando "Sblocca Presenze" non compare

## GESTY-PRE-014 Lezioni con presenze
Una lezione con presenze non cambia progetto né data ("Esistono rilevamenti presenze per questo orario.") e non si cancella (legame `FK_STUDENTI_PRESENZE_COLL_ORARI`). Orario, durata, docente, materia e indicazione di lezione svolta restano modificabili anche con presenze, ore firmate o presenze congelate (DIV-PRE-2).

### Scenario: lezione spostata di giorno
- **Dato** una lezione con le presenze già registrate
- **Quando** se ne cambia la data
- **Allora** il salvataggio si ferma con "Esistono rilevamenti presenze per questo orario."

## GESTY-PRE-015 Presenze individuali
Una presenza individuale non può avere una data successiva a oggi (`CHK3_STUDENTI_PRESENZE_INDIVID`; la scheda lo segnala già con "Data non valida."). L'incarico non si sceglie a mano: viene proposto da risorsa, progetto, tipo di incarico, piano, servizio, materia, data e orario (`INCARICHI_GET_PRESENZE`) a ogni cambio di uno di questi dati, e può restare vuoto. Le presenze individuali non hanno firma né congelamento.

Una presenza individuale presente, da calcolare e con incarico genera o riusa il rilevamento del docente, con piano personalizzato e servizio della presenza (GESTY-RIL-007, ticket 219, 221, 226). In modifica il rilevamento si cerca solo se la presenza non ne ha già uno e se cambiano data, ora, durata, risorsa, incarico, stato o "Calcolare"; in modifica un conflitto con altri rilevamenti del docente non ferma il salvataggio (DIV-RIL-4). Cancellando la presenza, il rilevamento si cancella solo se nessun'altra riga lo usa.

### Scenario: presenza di colloquio
- **Dato** un piano personalizzato con servizio "COLLOQUI DI PRIMA INFORMAZIONE E ORIENTAMENTO" e un docente con incarico valido
- **Quando** si registra la presenza presente del 08/10 dalle 13:00 alle 14:00
- **Allora** nasce il rilevamento del docente con lo stesso piano e lo stesso servizio, e la presenza ne conserva l'identificativo

### Scenario: presenza di domani
- **Dato** oggi 30/10
- **Quando** si registra una presenza individuale del 31/10
- **Allora** il salvataggio si ferma

## GESTY-PRE-016 Le ore del docente non dipendono dall'appello
Le presenze collettive non generano rilevamenti per il docente: le ore del docente di una lezione nascono dalla firma del registro (GESTY-PRE-011) o dall'orario, una per ora e per docente, qualunque sia il numero di allievi presenti. Le presenze individuali invece generano il rilevamento (GESTY-PRE-015). Un docente che vede ore nel registro degli allievi e non nella propria scheda ha quindi lezioni non ancora firmate, o presenze individuali senza incarico (ticket 214).

### Scenario: lezione appellata ma non firmata
- **Dato** una lezione con l'appello salvato e la giornata non firmata
- **Quando** il docente guarda le proprie ore rilevate
- **Allora** l'ora non c'è finché la giornata non viene firmata

## GESTY-PRE-017 Presenze di un periodo già trasmesso a SIUF (cenno)
Creare, modificare o cancellare una presenza collettiva o individuale di una giornata già trasmessa a SIUF con esito positivo per la sezione del progetto richiede l'autorizzazione `SIUF.ModificaPresenzeTrasmesse`; senza, l'operazione si ferma con "Le presenze di questo periodo sono già state trasmesse a SIUF con successo: la modifica richiede l'autorizzazione specifica." Il controllo guarda sezione e data, non il tipo di presenza (ticket 251). Fanno eccezione le ore di lezioni non svolte, che non arrivano mai a SIUF (ticket 237), e l'iscrizione tardiva, che salta le giornate trasmesse (GESTY-PRE-008). Per lo stage vale GESTY-TIR-020. Il dettaglio appartiene alla specifica della trasmissione a SIUF.

### Scenario: firma di una giornata già inviata con ore non svolte
- **Dato** una giornata già trasmessa con tre ore di laboratorio non svolte e senza presenze, e un utente senza `SIUF.ModificaPresenzeTrasmesse`
- **Quando** l'utente firma la giornata
- **Allora** la firma riesce: il salvataggio crea le presenze delle ore non svolte senza fermarsi

### Scenario: correzione su un'ora svolta già inviata
- **Dato** la stessa giornata e lo stesso utente
- **Quando** cambia lo stato di un allievo su un'ora svolta
- **Allora** il salvataggio si ferma con il messaggio delle presenze già trasmesse

## Divergenze note

Punti in cui il codice di oggi non mantiene ciò che i requisiti dicono, o in cui due parti del codice applicano la stessa regola in modo diverso. Raccolte in R-183; con la correzione il requisito si aggiorna e questa sezione si accorcia.

| Codice | Divergenza | Conseguenza |
|---|---|---|
| DIV-PRE-1 | Il controllo delle autorizzazioni su chi cambia firma e congelamento direttamente sulla lezione (`ORARIO_CHECK_FIRMATO`) è disattivato. Le schede della lezione hanno la casella in sola lettura, ma le viste "Elenco Lezioni" e "Assenze" del dizionario la tengono nascosta e modificabile, e il trigger della vista `ORARIO_ELENCO_BIUD0` la ricopia in inserimento e in modifica | Una lezione creata per duplicazione da una lezione congelata nasce congelata, e qualunque scrittura sulla vista che porti il valore lo cambia senza autorizzazione (ticket 47). Il giro normale (firma e "Sblocca Presenze") resta l'unico controllato |
| DIV-PRE-2 | Per lo stesso motivo una lezione firmata o con presenze congelate cambia orario, durata, docente, materia e indicazione di lezione svolta; nessun controllo SIUF guarda le modifiche alla lezione (`ORARIO` non ha un trigger `*_CHECK_SIUF`) | Le presenze congelate cambiano significato senza essere toccate; annullare una lezione già trasmessa a SIUF passa senza autorizzazione e toglie l'ora dalla trasmissione successiva (ticket 237, voce R-097) |
| DIV-PRE-3 | Le presenze delle ore non svolte si salvano come presenti e da calcolare. Il controllo di sovrapposizione delle altre presenze le ignora (`ORARIO.LEZIONE_SVOLTA = TRUE` in `STUDENTI_PRESENZE_CHECK_SOVRAPP`), ma quello della presenza collettiva stessa (`STUDENTI_PRES_COLL_CHECK_SOVRAP`) non guarda se la lezione è svolta | Dedotto dal codice, da provare sul banco: un allievo con uno stage o una presenza individuale nell'ora di una lezione annullata può impedire il salvataggio, e quindi la firma, dell'intera giornata |
| DIV-PRE-4 | Nel salvataggio (`STUDENTI_PRESENZE_COLL_TMP_SAVE`) il confronto dello stato considera sempre cambiate le righe delle ore non svolte, perché il registro le porta come `B`; l'aggiornamento rimette lo stato di prima ma scatta comunque | A ogni salvataggio e a ogni firma le presenze delle ore non svolte vengono riscritte, con autore e data di modifica aggiornati, e passano dai controlli di scrittura (era la seconda causa del ticket 237). Lo storico delle modifiche non dice più chi ha davvero toccato quelle righe |
| DIV-PRE-5 | Nel registro unificato (`STUDENTI_REGISTRO_PRESENZE`) le ore di presenza collettiva valgono l'intera durata della lezione e ignorano i minuti di ritardo o uscita anticipata, che la vista riporta in una colonna a parte | Da verificare quale uso è giusto: chi somma le ore dal registro unificato conta come presenza piena un'ora con 45 minuti di ritardo |
| DIV-PRE-6 | Il Registro Collettivo non ha un limite sulle date future: nessun vincolo su `STUDENTI_PRESENZE_COLLETTIVA`, né `STUDENTI_PRESENZE_COLL_TMP_PREP` né il programma filtrano la data, mentre le presenze individuali e quelle di stage la vietano e l'iscrizione crea presenze solo fino a oggi | Dedotto dal codice, da provare sul banco: aprendo e salvando una giornata futura nascono in anticipo presenze tutte presenti, che poi vanno corrette una per una |
| DIV-PRE-7 | `STUDENTI_PRESENZE_INDIVIDUALE_RILEVAMENTO_BIU` esce subito se la presenza ha già un rilevamento: oltre ai cambi di data e ora (DIV-RIL-5), anche un passaggio ad assente, la tolta di "Calcolare" o un cambio di incarico lasciano il rilevamento com'era | Il docente conserva un'ora pagabile per un colloquio a cui l'allievo risulta assente o escluso |
| DIV-PRE-8 | Una presenza collettiva nata da un'importazione GRS non si cancella da sola: il legame con la riga d'importazione si svuota (`SET NULL`) e `GRS_IMPORT_FILES_RIGHE_ELABORAZ_BIU0` rifiuta una riga senza presenza ("Inconguenza registrazione GRS: presenza non generata."). Il ritiro lo evita cancellando prima la riga d'importazione | Chi deve togliere una sola presenza importata può solo cancellare l'intero file, che toglie anche le presenze giuste (ticket 275, descritto sul sostegno e uguale sulla collettiva) |
| DIV-PRE-9 | "Sblocca Presenze" e "Blocca Presenze" sono lo stesso comando, visibile con `Registro.SbloccaStudenti`; ricongelare richiede invece `Registro.BloccaStudenti` | Un utente con la sola autorizzazione di sblocco può sbloccare una giornata e non riesce a ricongelarla. Su CAPAC le due autorizzazioni sono degli stessi gruppi (ticket 198), quindi oggi il caso non si presenta |
| DIV-PRE-10 | Il dominio `STATO_PRESENZA` ammette `I` ("INDIVIDUALE") e descrive `B` come "ORA BUCA", mentre il registro mostra `B` come "Non Svolta" e nessun oggetto del database usa `I`. Un `B` salvato davvero non è né presenza né assenza | Le schede che usano l'elenco valori del dominio offrono due stati senza significato per la presenza; da verificare sul banco quali schede li mostrano e che cosa succede a una presenza salvata `B` o `I` |

<!-- footer -->
---

[www.zebro.it/gesty](https://www.zebro.it/gesty)
<!-- /footer -->
