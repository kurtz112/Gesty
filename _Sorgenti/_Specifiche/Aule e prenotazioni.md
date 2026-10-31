---
area: Aule e prenotazioni
progetto: Gesty
aggiornato: 2026-10-31
rilascio: OUT/20261031-specifica-aule-e-prenotazioni/001
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

# Aule e prenotazioni

Questa specifica descrive le regole che Gesty rispetta per le aule (tabella `AULE`) e per la loro occupazione: prenotazioni (`AULE_PRENOTAZIONI`), lezioni dell'orario collettivo (`ORARIO.AULA`), riunioni (`RIUNIONI.AULA`), periodi di inagibilità (`AULE_INAGIBILITA`) e giorni di chiusura della sede (`ENTI_SEDI_GIORNI_CHIUSURA`). Descrive il comportamento atteso, non il codice. Le regole di conflitto e di permesso stanno quasi tutte nel database (procedura `AULA_VERIFICA_SOVRAPPOSIZIONE`, trigger `AULE_PRENOTAZIONI_BUD0`, `AULE_PRENOTAZIONI_BI`, `AULE_PRENOTAZIONI_AIU0`, `AULE_PRENOTAZIONI_BD0`, `AULE_PRENOTAZIONI_ELENCO_BIUD0`) e valgono per ogni canale. La parte dell'interfaccia sta nelle form Aule (`TFormAule`, modulo LZ `Aule`), Prenotazioni Aule (`TFormPrenotazioniAule`, modulo LZ `PrenotazioniAule`), Calendario Aule (`TFormCalendarioAule`, modulo LZ `CalendarioAule`) e nella finestra di prenotazione dall'agenda personale (`TFormPrenotaAulaDaAgenda`, modulo LZ `Agenda`).

**Utilizzo.** Area usata ogni giorno, soprattutto da Codebri.

**Fuori da quest'area.** Le presenze degli allievi (`Presenze allievi e registro.md`) e il rilevamento ore (`Rilevamento ore.md`) non leggono le prenotazioni delle aule; l'unico legame con l'orario è l'aula della lezione (GESTY-AUL-016). Restano senza specifica propria: dotazioni e attrezzature delle aule (`AULE_DOTAZIONI`), la configurazione dei giorni di chiusura, l'area personale web (`WEB_AREA_PERSONALE`), le esportazioni delle aule verso GRS, Untis e Futura (`GRS_EXPORT_AULE`, `UNTIS_AULE_ADD`, `FUTURA_EXPORT_PRESENZE_AULA`) e l'assegnazione automatica dell'aula alla lezione (`ORARIO_ASSEGNA_AULA_PER_GIORNO`).

**Origine.** Ricavata il 2026-10-31 dai sorgenti in `SRC\Gesty_Group\_Sorgenti` (`dmAule`, `dmPrenotazioniAule`, `dmCalendarioAule`, `dmAgenda`, `dmScheduler.Tools`, `frmAule`, `frmPrenotazioniAule`, `frmCalendarioAule`, `frmPrenotaAulaDaAgenda`, `frmGeneraPrenotazioniAule`), dai moduli LZ `Aule`, `PrenotazioniAule` e `CalendarioAule` e dai metadati del database master (fotografia del 2026-10-30 13:19: trigger, procedure, funzioni e viste citate). Nessuna prova sul banco: le righe segnate "dedotta" nelle divergenze vanno provate prima di correggere. Il ticket 133 (rilascio di settembre 2026) ha introdotto l'annullamento al posto della cancellazione, l'inagibilità annullabile e gli stessi controlli nella ricerca e nel salvataggio; ticket 180 per il messaggio della generazione per periodo; ticket 197 per il record rimasto in inserimento nella scheda.

## GESTY-AUL-001 Anagrafica dell'aula
Un'aula (o "spazio") si identifica con il codice `AULA`, unico; ha una descrizione, un tipo (`ZZ_TIPO_AULE`), un ente e una sede (obbligatori e coerenti: la sede deve appartenere all'ente), un colore, il numero di postazioni e le regole di prenotazione (`MODIFICA_PRENOTAZIONI`, `RICHIEDE_AUTORIZZAZIONE`, `GG_LIMITE_PRENOTAZIONE`). Un'aula nuova nasce con ente e sede predefiniti dell'utente. Un'aula non attiva (`ATTIVA = FALSE`) resta nei dati e nello storico ma non compare più nel calendario delle prenotazioni, nell'elenco da cui si scelgono le aule da mostrare, nelle ricerche di orari liberi e nel calendario aule. Se cambia il codice, le prenotazioni, le inagibilità e le risorse autorizzate lo seguono.

### Scenario: aula nuova
- **Dato** un utente con ente e sede predefiniti
- **Quando** inserisce una nuova aula nell'elenco Aule
- **Allora** ente e sede sono già compilati con i valori predefiniti
- **E** `MODIFICA_PRENOTAZIONI` vale 1 (qualunque utente), `RICHIEDE_AUTORIZZAZIONE` e `NOTIFICA_RICHIESTA_AI_RESPONSAB` valgono falso, `GG_LIMITE_PRENOTAZIONE` vale 0

### Scenario: aula disattivata
- **Dato** un'aula con prenotazioni passate
- **Quando** si imposta `ATTIVA = FALSE`
- **Allora** le prenotazioni passate restano visibili nell'elenco prenotazioni
- **E** l'aula non è più proposta nella ricerca degli orari liberi né nell'elenco "Seleziona aule" del calendario

### Scenario: aula citata da un'altra scheda
- **Dato** un collegamento ipertestuale su un codice aula (`HyperLinks`, tipo `AULA`)
- **Quando** l'utente lo apre
- **Allora** si apre l'elenco Aule filtrato su quel solo codice

## GESTY-AUL-002 Che cos'è una prenotazione
Una prenotazione occupa un'aula in un giorno e in una fascia oraria. Ha l'aula, il richiedente (una risorsa), la data, l'ora di inizio e di fine, un oggetto facoltativo, un progetto e un corso facoltativi (il corso deve appartenere al progetto), le note, il flag "visibile in agenda" (predefinito vero) e lo stato di annullamento. La durata in minuti si calcola da inizio e fine. L'ora di fine non può precedere quella di inizio, salvo la fine a mezzanotte (`00:00`). Il richiedente, quando la scheda si apre da calendario, da ricerca o dall'agenda, è la risorsa dell'utente collegato; l'oggetto è limitato a 100 caratteri quando si scrive dall'elenco prenotazioni.

### Scenario: prenotazione dal calendario
- **Dato** un utente collegato alla risorsa 120
- **Quando** apre una nuova prenotazione dal calendario, scegliendo aula, giorno e ora
- **Allora** la scheda è già compilata con aula, data, ora di inizio, ora di fine e richiedente la risorsa 120

### Scenario: fine prima dell'inizio
- **Dato** una prenotazione dalle 11:00
- **Quando** si indica come fine le 10:00
- **Allora** il salvataggio si ferma per il vincolo `CHK1_AULE_PRENOTAZIONI`

## GESTY-AUL-003 Le prenotazioni si annullano, non si cancellano
La cancellazione fisica di una prenotazione è rifiutata con "Le prenotazioni non si cancellano: si annullano, così resta la traccia di chi aveva prenotato e di quando ha rinunciato". Annullare significa impostare `ANNULLATA = TRUE`: il database registra da solo la data e l'ora dell'annullamento e l'utente che l'ha fatto, e l'aula torna libera. Il motivo (`MOTIVO_ANNULLAMENTO`) lo indica l'utente. Se l'annullamento viene revocato, data, utente e motivo si azzerano. Fanno eccezione, con un'autorizzazione esplicita del chiamante, lo svuotamento di un periodo (GESTY-AUL-014) e l'eliminazione di una risorsa (le sue prenotazioni, annullate comprese, vengono eliminate fisicamente perché la chiave esterna sulla risorsa lo impone). Dall'elenco prenotazioni la cancellazione di una riga è trasformata in annullamento.

### Scenario: cancellazione diretta
- **Dato** una prenotazione attiva
- **Quando** si tenta di cancellarla dalla tabella `AULE_PRENOTAZIONI`
- **Allora** compare "Le prenotazioni non si cancellano: si annullano…" con aula, data e ora di inizio

### Scenario: annullamento
- **Dato** una prenotazione attiva
- **Quando** si imposta `ANNULLATA = TRUE` con il motivo "Corso rinviato"
- **Allora** `DATA_ORA_ANNULLAMENTO` e `USER_ID_ANNULLAMENTO` sono valorizzati dal database
- **E** l'aula risulta di nuovo libera in quella fascia

### Scenario: revoca dell'annullamento
- **Dato** una prenotazione annullata
- **Quando** si imposta `ANNULLATA = FALSE`
- **Allora** data, utente e motivo dell'annullamento tornano vuoti
- **E** il controllo di sovrapposizione si riesegue (GESTY-AUL-004)

### Scenario: cancellazione dalla griglia
- **Dato** una riga dell'elenco prenotazioni (`AULE_PRENOTAZIONI_ELENCO`) che è una prenotazione attiva
- **Quando** la si cancella
- **Allora** la prenotazione risulta annullata e non eliminata

## GESTY-AUL-004 Nessuna sovrapposizione fra prenotazioni attive
Su una stessa aula e in uno stesso giorno due prenotazioni attive non si sovrappongono. Le fasce che si toccano senza sovrapporsi (09:00-10:00 e 10:00-11:00) sono ammesse. Le prenotazioni annullate non occupano l'aula. Non possono esistere due prenotazioni attive con la stessa aula, data e ora di inizio (indice univoco `UNQ1_AULE_PRENOTAZIONI`). Il messaggio dice "Risulta un'altra prenotazione per l'aula" con aula, data, ora di inizio e di fine e il nome del richiedente della prenotazione in conflitto. Il controllo si fa dopo la scrittura (trigger `AULE_PRENOTAZIONI_AIU0`), quindi annulla l'intero salvataggio; scatta quando la prenotazione è nuova, quando si revoca l'annullamento e quando cambiano data, ora di inizio o durata. Non scatta se si modificano soltanto oggetto, note, progetto o corso, e non scatta se la prenotazione che si salva è annullata.

### Scenario: stessa aula, fasce sovrapposte
- **Dato** una prenotazione attiva dell'aula A101 il 12/11 dalle 09:00 alle 11:00
- **Quando** se ne inserisce un'altra per A101 il 12/11 dalle 10:00 alle 12:00
- **Allora** il salvataggio si ferma con "Risulta un'altra prenotazione per l'aula."
- **E** il messaggio riporta aula, data, 10:00, 12:00 e il richiedente della prima prenotazione

### Scenario: fasce contigue
- **Dato** una prenotazione di A101 dalle 09:00 alle 10:00
- **Quando** se ne inserisce una dalle 10:00 alle 11:00
- **Allora** il salvataggio riesce

### Scenario: aule diverse nella stessa ora
- **Dato** una prenotazione di A101 dalle 09:00 alle 11:00
- **Quando** se ne inserisce una per A102 nella stessa fascia
- **Allora** il salvataggio riesce

### Scenario: la prenotazione precedente è annullata
- **Dato** una prenotazione annullata di A101 dalle 09:00 alle 11:00
- **Quando** se ne inserisce una nuova per A101 dalle 09:00 alle 11:00
- **Allora** il salvataggio riesce

### Scenario: correzione dell'oggetto
- **Dato** una prenotazione già salvata
- **Quando** si cambia solo l'oggetto
- **Allora** il salvataggio riesce e la sovrapposizione non viene ricontrollata

## GESTY-AUL-005 L'aula occupata da una lezione o da una riunione
Oltre che da una prenotazione, un'aula è occupata da una lezione dell'orario collettivo (`ORARIO` con `AULA` valorizzata e `LEZIONE_SVOLTA = TRUE`) e da una riunione con quell'aula non annullata (`STATO_RIUNIONE` diverso da `A`). Una lezione non svolta o una riunione annullata non occupano l'aula. Il controllo vale in tutte le direzioni: una prenotazione che cade su una lezione o su una riunione è rifiutata ("L'aula risulta prenotata per la formazione collettiva", "Risulta una riuione per l'aula": il messaggio contiene questo refuso); una riunione e una lezione che cadono su una prenotazione attiva sono rifiutate con "Risulta un'altra prenotazione per l'aula". Il controllo sulle lezioni scatta quando l'aula, la data, l'ora di inizio o la durata di una lezione cambiano, quello sulle riunioni a ogni salvataggio di una riunione non annullata con aula, data e ora di inizio. Due lezioni nella stessa aula e nella stessa fascia sono invece ammesse: serve ai corsi collegati.

### Scenario: prenotazione su una lezione
- **Dato** una lezione svolta in A101 il 12/11 dalle 09:00 alle 11:00
- **Quando** si prenota A101 il 12/11 dalle 10:00 alle 11:00
- **Allora** il salvataggio si ferma con "L'aula risulta prenotata per la formazione collettiva."
- **E** il messaggio riporta il progetto e il docente della lezione

### Scenario: lezione non svolta
- **Dato** una lezione con `LEZIONE_SVOLTA = FALSE` in A101 il 12/11 dalle 09:00 alle 11:00
- **Quando** si prenota A101 nella stessa fascia
- **Allora** il salvataggio riesce

### Scenario: lezione su una prenotazione
- **Dato** una prenotazione attiva di A101 il 12/11 dalle 09:00 alle 11:00
- **Quando** si assegna A101 a una lezione il 12/11 dalle 10:00 alle 11:00
- **Allora** il salvataggio della lezione si ferma con "Risulta un'altra prenotazione per l'aula."

### Scenario: riunione annullata
- **Dato** una riunione annullata in A101 il 12/11 dalle 09:00 alle 11:00
- **Quando** si prenota A101 nella stessa fascia
- **Allora** il salvataggio riesce

### Scenario: corsi collegati
- **Dato** una lezione svolta in A101 il 12/11 dalle 09:00 alle 11:00
- **Quando** si assegna A101 a un'altra lezione nella stessa fascia
- **Allora** il salvataggio riesce

## GESTY-AUL-006 Inagibilità dell'aula
Un periodo di inagibilità (aula, dal giorno, al giorno, motivo, annullata sì/no) impedisce di prenotare l'aula in tutti i giorni del periodo, estremi compresi, qualunque sia l'ora. Vale per prenotazioni, lezioni e riunioni. Il messaggio dice "L'aula risulta inagibile per" seguito dal motivo. Un'inagibilità annullata (`ANNULLATA = 'N'` è l'unico valore che blocca) non blocca più. Il periodo si compila con la data iniziale non successiva alla finale. Le inagibilità non cancellano le prenotazioni già fatte: le nuove vengono rifiutate.

### Scenario: prenotazione in un periodo di inagibilità
- **Dato** l'aula A101 inagibile dal 10/11 al 14/11 per "Lavori impianto elettrico"
- **Quando** si prenota A101 il 12/11
- **Allora** il salvataggio si ferma con "L'aula risulta inagibile per Lavori impianto elettrico."

### Scenario: inagibilità annullata
- **Dato** un'inagibilità dal 10/11 al 14/11 con `ANNULLATA = 'S'`
- **Quando** si prenota l'aula il 12/11
- **Allora** il salvataggio riesce

### Scenario: estremo del periodo
- **Dato** l'inagibilità dal 10/11 al 14/11
- **Quando** si prenota l'aula il 14/11
- **Allora** il salvataggio si ferma per inagibilità

## GESTY-AUL-007 Giorni di chiusura della sede
Una sede può avere giorni di chiusura (`ENTI_SEDI_GIORNI_CHIUSURA`). Se il giorno è segnato come "non consente prenotazione aule" (`CONSENTI_PRENOTAZIONE_AULE = FALSE`) le ricerche di orari liberi non propongono nessuna aula di quella sede in quel giorno, e il giorno compare come occupato nell'elenco delle occupazioni (`AULE_PRENOTAZIONI_ELENCO`, tipo "giorno di chiusura", dalle 00:01 alle 23:59). Il salvataggio di una prenotazione in quel giorno non è invece controllato: vedi DIV-AUL-1.

### Scenario: la ricerca salta il giorno di chiusura
- **Dato** una sede chiusa il 25/12 con prenotazioni aule non consentite
- **Quando** si cercano orari liberi per un'aula della sede dal 24/12 al 26/12
- **Allora** nessun orario del 25/12 è proposto

### Scenario: chiusura che consente le prenotazioni
- **Dato** un giorno di chiusura con `CONSENTI_PRENOTAZIONE_AULE = TRUE`
- **Quando** si cercano orari liberi
- **Allora** gli orari di quel giorno sono proposti come in un giorno normale

## GESTY-AUL-008 Aule riservate a persone autorizzate
Se per un'aula esiste almeno una riga in "Risorse autorizzate" (`AULE_RISORSE_AUTORIZZATE_PRENOT`), solo quelle persone possono inserire, modificare o cancellare le sue prenotazioni; per le altre il salvataggio si ferma con "Utente non autorizzato alla prenotazione dell'aula". Il controllo guarda il richiedente della prenotazione, non l'utente che sta lavorando. Un'aula senza righe non ha limitazioni. Le ricerche di orari liberi propongono a ciascuno solo le aule che può prenotare (la persona indicata, altrimenti l'utente collegato).

### Scenario: aula riservata
- **Dato** un'aula con una sola risorsa autorizzata, la risorsa 120
- **Quando** la risorsa 130 inserisce una prenotazione per quell'aula
- **Allora** il salvataggio si ferma con "Utente non autorizzato alla prenotazione dell'aula."

### Scenario: aula senza limitazioni
- **Dato** un'aula senza risorse autorizzate
- **Quando** qualunque utente con il permesso di inserimento prenota
- **Allora** il salvataggio riesce

### Scenario: la ricerca rispetta l'elenco
- **Dato** l'aula riservata alla risorsa 120
- **Quando** la risorsa 130 cerca orari liberi dall'agenda
- **Allora** l'aula non compare fra le proposte

## GESTY-AUL-009 Anticipo massimo della prenotazione
Una prenotazione non può avere una data più lontana di un certo numero di giorni da oggi: il limite è `GG_LIMITE_PRENOTAZIONE` dell'aula; se vale 0 vale quello della sede (`ENTI_SEDI.GG_LIMITE_PRENOTAZIONE_AULE`, predefinito 999); in mancanza di entrambi 999. Il controllo vale solo (1) per le prenotazioni senza corso e senza progetto, perché quelle collegate sono programmazione didattica; (2) quando la prenotazione è nuova o ne cambia la data, così correggere una prenotazione già fuori finestra resta possibile; (3) per chi non ha l'autorizzazione "Aule.Prenotazioni.DerogaLimiteTemporale". Il messaggio dice "Non è consentito prenotare l'aula con più di N giorni di anticipo". Le ricerche di orari liberi non propongono le date oltre il limite, salvo per chi ha la deroga.

### Scenario: oltre il limite
- **Dato** un'aula con limite di 30 giorni e un utente senza deroga
- **Quando** inserisce una prenotazione senza corso né progetto fra 45 giorni
- **Allora** il salvataggio si ferma con "Non è consentito prenotare l'aula con più di 30 giorni di anticipo."

### Scenario: prenotazione di un corso
- **Dato** la stessa aula e lo stesso utente
- **Quando** inserisce una prenotazione con progetto e corso fra 45 giorni
- **Allora** il salvataggio riesce

### Scenario: utente con deroga
- **Dato** un utente con l'autorizzazione di deroga
- **Quando** inserisce una prenotazione senza corso né progetto fra 45 giorni
- **Allora** il salvataggio riesce

### Scenario: limite dell'aula a zero
- **Dato** un'aula con `GG_LIMITE_PRENOTAZIONE = 0` in una sede con limite di 15 giorni
- **Quando** si inserisce una prenotazione fra 20 giorni
- **Allora** vale il limite della sede e il salvataggio si ferma

### Scenario: prenotazione già fuori finestra
- **Dato** una prenotazione senza corso né progetto già a 60 giorni, inserita con la deroga
- **Quando** un utente senza deroga ne cambia solo l'oggetto
- **Allora** il salvataggio riesce

## GESTY-AUL-010 Permessi sulle prenotazioni
Inserire una prenotazione richiede l'autorizzazione "Aule.Prenotazioni.Inserimento". Per modificare o annullare una prenotazione conta la regola dell'aula (`MODIFICA_PRENOTAZIONI`):

| Valore | Chi può modificare |
|---|---|
| 1 | Qualunque utente, nessun controllo |
| 2 | Il richiedente; gli altri solo con "Aule.Prenotazioni.Modifica" |
| 3 | Chi ha "Aule.Prenotazioni.Modifica" |
| 4 | Il richiedente, e solo se ha anche "Aule.Prenotazioni.Modifica" |

Per il valore 4 un altro utente riceve "Solo l'utente che ha inserito la prenotazione può modificarla". "Richiedente" è la risorsa collegata all'utente (`CURRENT_ID_RISORSA`). Il controllo vale anche per la cancellazione e per le operazioni che modificano righe esistenti (taglia e sposta). Il permesso "Aule.Gestione" è definito ma non è applicato (DIV-AUL-5).

### Scenario: aula che accetta tutti
- **Dato** un'aula con `MODIFICA_PRENOTAZIONI = 1`
- **Quando** un utente diverso dal richiedente modifica la prenotazione
- **Allora** la modifica riesce

### Scenario: solo il richiedente
- **Dato** un'aula con valore 2 e un utente senza "Aule.Prenotazioni.Modifica"
- **Quando** modifica la prenotazione di un altro
- **Allora** il salvataggio si ferma per mancanza di autorizzazione
- **E** la stessa modifica sulla propria prenotazione riesce

### Scenario: solo richiedente autorizzato
- **Dato** un'aula con valore 4 e un utente che ha "Aule.Prenotazioni.Modifica"
- **Quando** modifica la prenotazione di un altro
- **Allora** il salvataggio si ferma con "Solo l'utente che ha inserito la prenotazione può modificarla."

### Scenario: inserimento senza permesso
- **Dato** un utente senza "Aule.Prenotazioni.Inserimento"
- **Quando** salva una nuova prenotazione
- **Allora** il salvataggio si ferma per mancanza di autorizzazione

## GESTY-AUL-011 Aule che richiedono autorizzazione
Un'aula con `RICHIEDE_AUTORIZZAZIONE = TRUE` ha prenotazioni che nascono "da autorizzare". Una prenotazione è considerata autorizzata (`IS_AUTORIZZATA`) se l'aula non richiede autorizzazione, oppure se la data e l'ora di autorizzazione sono valorizzate. L'elenco Autorizzazioni (form Aule) mostra le prenotazioni di oggi e future, di aule che richiedono autorizzazione; l'azione "Autorizza" chiede conferma ("Autorizzare le prenotazioni selezionate?") e autorizza le righe selezionate una per una. Autorizzare registra la data e l'ora; una prenotazione già autorizzata non cambia. Se il responsabile dell'autorizzazione viene indicato, la data si compila da sola; se viene tolto, la data si azzera. Dalla scheda della prenotazione si può inviare una mail di richiesta all'indirizzo `CONFIG.EMAIL_AUTORIZZAZIONE_AULE`, con aula, giorno, ore, richiedente, oggetto e progetto; la mail non parte se la prenotazione è già autorizzata, se l'aula non richiede autorizzazione, se è annullata o se i parametri di posta non sono configurati.

### Scenario: prenotazione di un'aula con autorizzazione
- **Dato** un'aula con `RICHIEDE_AUTORIZZAZIONE = TRUE`
- **Quando** si salva una prenotazione per una data futura
- **Allora** la prenotazione risulta non autorizzata (`IS_AUTORIZZATA = FALSE`) e compare nell'elenco Autorizzazioni

### Scenario: autorizzazione
- **Dato** una prenotazione futura non autorizzata
- **Quando** l'utente la seleziona nell'elenco Autorizzazioni e conferma
- **Allora** `DATA_ORA_AUTORIZZAZIONE` è valorizzata e `IS_AUTORIZZATA` è vero

### Scenario: autorizzazione ripetuta
- **Dato** una prenotazione già autorizzata
- **Quando** la si autorizza di nuovo
- **Allora** data e ora di autorizzazione restano quelle di prima

### Scenario: mail di richiesta su una prenotazione autorizzata
- **Dato** una prenotazione già autorizzata
- **Quando** l'utente sceglie l'invio della mail di richiesta
- **Allora** compare "La prenotazione risulta autorizzata." e la mail non parte

### Scenario: aula che non richiede autorizzazione
- **Dato** un'aula con `RICHIEDE_AUTORIZZAZIONE = FALSE`
- **Quando** si consulta `IS_AUTORIZZATA` di una sua prenotazione
- **Allora** vale vero senza data di autorizzazione

## GESTY-AUL-012 Avviso delle prenotazioni di oggi
Quando si salva una prenotazione con la data di oggi, o se ne sposta una a oggi, il database invia la notifica "Prenotazione aula" ("Aula: …, Ore: …") ai sottoscrittori della notifica `PRENOTAZIONE_AULA`. Non parte per prenotazioni di altri giorni né per le modifiche che lasciano la data invariata.

### Scenario: prenotazione per oggi
- **Dato** un sottoscrittore della notifica prenotazione aula
- **Quando** si inserisce una prenotazione con la data di oggi
- **Allora** riceve "Prenotazione aula" con aula e ora di inizio

### Scenario: prenotazione per domani
- **Dato** un sottoscrittore della notifica prenotazione aula
- **Quando** si inserisce una prenotazione per domani
- **Allora** nessuna notifica parte

## GESTY-AUL-013 Calendario delle prenotazioni
La form Prenotazioni Aule mostra un calendario con una colonna per ogni aula selezionata. A sinistra l'elenco delle aule attive (filtrabile per sede) permette di scegliere quali mostrare, anche più di una; la prima volta, e ogni volta che la selezione resta vuota, è mostrata la prima aula dell'elenco. Il calendario parte dalla settimana corrente, con orario di lavoro 07:00-20:00, ha un aggiornamento automatico il cui intervallo scelto si ricorda per l'utente (`PrenotazioniAule.AutoRefresh`) e mostra le lezioni (anche non svolte, DIV-AUL-11), le riunioni non annullate e le prenotazioni **non annullate** dell'aula; una prenotazione annullata sparisce dal calendario. Un clic su un'ora libera o su un evento riporta aula e giorno nel pannello di ricerca degli orari liberi (30 giorni da quel giorno). Ricaricando il calendario si conservano le aule selezionate. Una prenotazione si crea, si apre, si sposta con il trascinamento (cambiando giorno, ora e anche aula) e si elimina dal calendario; i tipi di evento ammessi sono solo le prenotazioni di aula.

### Scenario: prima apertura
- **Dato** l'elenco di aule attive A101, A102, A103
- **Quando** si apre la form
- **Allora** è visibile solo la colonna di A101

### Scenario: più aule
- **Dato** la form aperta
- **Quando** si selezionano A102 e A103
- **Allora** il calendario mostra le sole colonne A102 e A103 con le loro occupazioni

### Scenario: prenotazione annullata
- **Dato** una prenotazione annullata dell'aula A101
- **Quando** si mostra il calendario di A101
- **Allora** la prenotazione non compare

### Scenario: spostamento in un'altra fascia occupata
- **Dato** una prenotazione di A101 dalle 09:00 alle 10:00 e una di A101 dalle 10:00 alle 11:00
- **Quando** si trascina la prima sulla fascia 10:00-11:00
- **Allora** lo spostamento è rifiutato (stessa aula, data e ora di inizio, o sovrapposizione) e nel database la prenotazione non cambia

## GESTY-AUL-014 Copia, taglia e incolla
Dal calendario si possono copiare e incollare una prenotazione, tutte le prenotazioni di un giorno, tutte quelle di una settimana, o tagliare e incollare una prenotazione. Le azioni si chiamano "Copia Prenotazione", "Copia Prenotazioni Giorno", "Copia Prenotazioni Settimana", "Taglia Prenotazione", "Incolla Prenotazioni". Le copie nascono con lo stesso richiedente, aula, oggetto, progetto, corso e visibilità dell'originale, nell'orario di destinazione; per una sola prenotazione la durata è conservata e l'ora iniziale è quella dove si incolla. Dove nella stessa aula e allo stesso giorno esiste già una prenotazione con la stessa ora di inizio, la copia di quella riga viene saltata. Se una copia si sovrappone ad altro, il controllo di GESTY-AUL-004 ferma l'intero incolla. Il taglio crea la nuova prenotazione e annulla la vecchia con il motivo "Spostata in un'altra data od ora". Incollare un giorno sullo stesso giorno, o una settimana sulla stessa settimana, non fa nulla. Copia di una settimana: ogni prenotazione va allo stesso giorno della settimana di destinazione.

### Scenario: incolla una prenotazione
- **Dato** una prenotazione copiata di 2 ore
- **Quando** la si incolla il 13/11 alle 14:00
- **Allora** nasce una prenotazione dal 13/11 dalle 14:00 alle 16:00 per la stessa aula e lo stesso richiedente

### Scenario: taglia e incolla
- **Dato** una prenotazione tagliata
- **Quando** la si incolla in un'altra data
- **Allora** la nuova prenotazione esiste e quella di partenza è annullata con il motivo "Spostata in un'altra data od ora"

### Scenario: incolla un giorno
- **Dato** due prenotazioni del 10/11 in due aule diverse
- **Quando** si copia il giorno e lo si incolla sul 17/11
- **Allora** nascono due prenotazioni del 17/11 con gli stessi orari

### Scenario: destinazione già occupata dalla stessa ora
- **Dato** una prenotazione del 10/11 di A101 alle 09:00 e una del 17/11 di A101 alle 09:00
- **Quando** si incolla il 10/11 sul 17/11
- **Allora** la riga di A101 è saltata e le altre vengono copiate

### Scenario: copia sovrapposta ad altro
- **Dato** una prenotazione del 10/11 di A101 dalle 09:00 alle 11:00 e una del 17/11 di A101 dalle 10:00 alle 12:00
- **Quando** si incolla il 10/11 sul 17/11
- **Allora** l'intero incolla si ferma per sovrapposizione e nulla viene copiato

## GESTY-AUL-015 Prenotazione per periodo
Il comando "Prenotazione periodo" (barra del calendario) genera molte prenotazioni insieme per un'aula: si indicano aula (di norma quella selezionata, altrimenti la prima), oggetto, progetto e corso facoltativi, il periodo (di partenza quello visibile), i giorni della settimana da includere (lunedì-venerdì di partenza) e per ciascuno l'ora di inizio e di fine (di partenza 08:00-12:00). Verifiche prima di lanciare: aula, oggetto (salvo lo svuotamento), data inizio e fine, data inizio non dopo la fine, ora inizio minore dell'ora fine per ogni giorno scelto. Per ogni giorno scelto del periodo, prima si controlla che l'aula sia libera e poi si inserisce la prenotazione con richiedente l'utente collegato; il primo conflitto ferma l'intera generazione e nessun giorno resta inserito a metà, con il messaggio di GESTY-AUL-004. Con "Eliminazione prenotazioni" (svuotamento) non si inserisce nulla: si eliminano fisicamente tutte le prenotazioni dell'aula, attive e annullate, che si sovrappongono alle fasce dei giorni scelti, dopo la domanda "Si desidera eliminare le prenotazioni preesistenti?".

### Scenario: generazione settimanale
- **Dato** l'aula A101, il periodo 02/11-27/11 e lunedì e mercoledì dalle 14:00 alle 17:00
- **Quando** si lancia la generazione
- **Allora** nascono 8 prenotazioni, tutte con richiedente l'utente collegato

### Scenario: conflitto in un giorno del periodo
- **Dato** una prenotazione di A101 il 11/11 alle 15:00
- **Quando** si genera lunedì-venerdì 14:00-17:00 dal 09/11 al 13/11
- **Allora** la generazione si ferma con "Risulta un'altra prenotazione per l'aula."
- **E** nessuna prenotazione dei giorni 09/11 e 10/11 resta inserita

### Scenario: svuotamento
- **Dato** prenotazioni di A101 lunedì 14:00-17:00 per quattro settimane
- **Quando** si lancia lo svuotamento con lunedì 14:00-17:00 sullo stesso periodo e si risponde sì
- **Allora** le prenotazioni di quelle fasce non esistono più

### Scenario: ora di fine non valida
- **Dato** un giorno scelto con inizio 17:00 e fine 14:00
- **Quando** si lancia la generazione
- **Allora** compare "Lunedì: ora inizio maggiore di ora fine." e non si genera nulla

## GESTY-AUL-016 Ricerca degli orari liberi
La ricerca di orari liberi propone, per ogni aula attiva, i possibili inizi nella fascia richiesta, ogni `passo` minuti, per una `durata` data, nel periodo dal-al. Un orario è proposto se l'aula è libera in tutta la durata (nessuna prenotazione attiva, lezione svolta, riunione non annullata, inagibilità: stessa regola del salvataggio, GESTY-AUL-004, 005 e 006), l'orario finisce entro la fascia richiesta, la sede non è chiusa con prenotazioni non consentite (GESTY-AUL-007), l'aula è prenotabile da chi chiede (GESTY-AUL-008) e l'anticipo è nei limiti (GESTY-AUL-009). Si può limitare a un'aula o a una sede. Nella form Prenotazioni Aule la ricerca non guarda gli impegni di nessuna persona e include sabato e domenica; con una persona indicata (agenda) propone solo gli orari in cui è libera anche lei. Un doppio clic su una riga apre la scheda di prenotazione già compilata con aula, giorno e ore proposti. I filtri di partenza della form: fascia dall'inizio alla fine dell'orario di lavoro del calendario, durata e passo 60 minuti; senza date compare "Intervallo date non specificato.".

### Scenario: fascia con inizi proposti
- **Dato** l'aula A101 libera il 12/11 e fascia 08:00-12:00, durata 60, passo 60
- **Quando** si cerca
- **Allora** gli inizi proposti sono 08:00, 09:00, 10:00 e 11:00

### Scenario: l'orario deve finire entro la fascia
- **Dato** fascia 08:00-18:00, durata 60 e passo 30
- **Quando** si cerca
- **Allora** l'ultimo inizio proposto è 17:00, non 17:30

### Scenario: aula occupata a metà
- **Dato** una prenotazione di A101 il 12/11 dalle 09:00 alle 10:00
- **Quando** si cerca con durata 60 e passo 60 nella fascia 08:00-12:00
- **Allora** 09:00 non è proposto e 08:00, 10:00 e 11:00 sì

### Scenario: nessuna proposta
- **Dato** una fascia in cui tutte le aule sono occupate
- **Quando** la ricerca non trova nulla
- **Allora** la griglia dei risultati è vuota e il doppio clic non apre nessuna scheda

### Scenario: prenotazione da una riga
- **Dato** una riga proposta (A101, 12/11, 10:00-11:00)
- **Quando** l'utente la apre con doppio clic
- **Allora** si apre la scheda di prenotazione con aula, data e ore precompilati
- **E** dopo il salvataggio il calendario si porta sul giorno prenotato

## GESTY-AUL-017 Prenotazione dall'agenda personale
Dall'agenda personale una finestra "Prenota aula" offre due modi. "Aule libere": si parte dal giorno e dalle ore scelti nel calendario, la ricerca parte subito e propone le aule libere in quella fascia (anche sabato e domenica) che non confliggono con gli impegni della persona. "Quando è libera un'aula": si sceglie l'aula, il periodo (di partenza 30 giorni dal giorno scelto), la fascia di lavoro, la durata (predefinita 60 minuti), il passo (predefinito 30 minuti) e, facoltativo, se includere sabato e domenica; si propongono gli orari in cui sono libere sia l'aula sia la persona. La prenotazione si apre con la scheda di sempre, già compilata. Verifiche: giorno indicato, ora di fine dopo l'ora di inizio, aula scelta (modo 2), periodo valido. Messaggi: se la persona ha già un impegno nella fascia "In questo orario hai già un impegno in agenda: nessuna aula proposta."; altrimenti "Nessuna aula libera in questo orario."; per il secondo modo "Nessun orario in cui siano liberi sia l'aula sia tu.". Dopo ogni prenotazione la ricerca si ripete, così l'orario preso sparisce dall'elenco. Se nell'agenda non erano visibili le prenotazioni aule, la visualizzazione si attiva e un messaggio lo dice.

### Scenario: aule libere nella fascia scelta
- **Dato** un utente con la fascia 10:00-11:00 libera in agenda e A102 libera
- **Quando** apre "Prenota aula" dal calendario sulla fascia
- **Allora** l'elenco propone A102 e le altre aule libere

### Scenario: persona occupata
- **Dato** un impegno dell'utente dalle 10:00 alle 11:00
- **Quando** cerca aule libere in quella fascia e l'elenco risulta vuoto
- **Allora** compare "In questo orario hai già un impegno in agenda: nessuna aula proposta."

### Scenario: ora di fine non valida
- **Dato** la finestra "Prenota aula" aperta in uno dei due modi
- **Quando** la fine è uguale o precedente all'inizio
- **Allora** compare "L'ora di fine deve essere dopo l'ora di inizio." e la ricerca non parte

### Scenario: prima prenotazione con le prenotazioni nascoste
- **Dato** l'agenda con "Mostra prenotazioni aule" spento
- **Quando** la persona prenota un'aula dalla finestra
- **Allora** la visualizzazione delle prenotazioni aule si attiva e compare il messaggio che lo dice

### Scenario: prenotazioni dell'agenda
- **Dato** una prenotazione con `VISIBILE_IN_AGENDA = TRUE` il cui richiedente è la persona
- **Quando** si mostra la sua agenda con le prenotazioni aule accese
- **Allora** la prenotazione compare nell'agenda del richiedente

## GESTY-AUL-018 Calendario Aule e riepiloghi
La form Calendario Aule (`CALENDARIO_AULE`) mostra, per un periodo, un'aula o una sede, gli orari delle aule attive a intervalli di 30 minuti (dalle 08:00 alle 23:00 di partenza), con gli intervalli liberi, le lezioni, le riunioni e le prenotazioni; da lì si apre la scheda dell'orario (lezione). Il resto delle viste informative sull'area:

| Vista (form Aule) | Contenuto |
|---|---|
| Riepilogo Utilizzo | Per aula e periodo (di partenza ultimi 12 mesi), 8 ore al giorno: giorni aperti, giorni inagibile, ore disponibili, ore di lezioni, prenotazioni e riunioni, percentuale di occupazione, prenotazioni totali, annullate e annullate all'ultimo momento; con grafico |
| Riepilogo Occupazioni | Elenco unificato di prenotazioni, lezioni, riunioni, giorni di chiusura e inagibilità, per anno e per ente |
| Elenco Sovrapposizioni | Prenotazioni, lezioni, chiusure e inagibilità che si incontrano nello stesso giorno sulla stessa aula |
| Inagibilità Aule | Periodi di inagibilità di tutte le aule |

La form Prenotazioni Aule ha inoltre un "Riepilogo occupazioni" con filtro per periodo e per aula (il codice cercato può essere anche una parte).

### Scenario: calendario di un'aula
- **Dato** una lezione svolta e una prenotazione nella stessa giornata di A101
- **Quando** si apre il Calendario Aule su quel giorno per A101
- **Allora** compaiono la lezione e la prenotazione negli orari occupati, gli altri intervalli sono liberi

### Scenario: apertura di una lezione dal calendario
- **Dato** una lezione mostrata nel Calendario Aule
- **Quando** l'utente la apre
- **Allora** si apre la scheda dell'orario di quella lezione

### Scenario: prenotazioni annullate nel riepilogo
- **Dato** un'aula con 10 prenotazioni nel periodo, 3 delle quali annullate
- **Quando** si apre il Riepilogo Utilizzo
- **Allora** le prenotazioni annullate valgono 3 e le ore di prenotazione contano solo le 7 attive

## GESTY-AUL-019 Rapporto con l'orario, i rilevamenti e le presenze
L'orario collettivo e le prenotazioni condividono lo stesso insieme di regole di occupazione (GESTY-AUL-004, 005, 006): `AULA_VERIFICA_SOVRAPPOSIZIONE` è l'unico punto di verifica per prenotazioni, lezioni e riunioni, e `AULA_LIBERA` la sua copia per le ricerche. Una lezione occupa l'aula solo se è svolta; l'aula di una lezione non genera una prenotazione e non passa dall'elenco prenotazioni, ma compare nelle viste unificate (calendario, occupazioni, sovrapposizioni). Il rilevamento ore, le presenze degli allievi e il registro non leggono né scrivono prenotazioni di aule (nessun trigger o procedura di quelle aree cita `AULE_PRENOTAZIONI`): annullare o spostare una prenotazione non cambia ore rilevate né presenze. Il verso opposto esiste per le persone: la ricerca di orari liberi per una persona (`PERSONALE_LIBERO`) la considera occupata se ha lezioni svolte, ore rilevate per sé, riunioni non annullate o appuntamenti personali nella fascia, come l'agenda personale. La ricerca di date libere per una riunione (`RIUNIONI_DATE_LIBERE`) esclude le aule con una prenotazione attiva sovrapposta. La fusione di due risorse sposta le prenotazioni dalla risorsa eliminata a quella corretta; l'eliminazione di una risorsa elimina le sue prenotazioni.

### Scenario: lezione non svolta
- **Dato** una lezione con aula A101 e `LEZIONE_SVOLTA = FALSE`
- **Quando** si cerca un orario libero per A101 nella stessa fascia
- **Allora** la fascia è proposta come libera

### Scenario: annullamento e ore rilevate
- **Dato** una prenotazione con progetto e corso e ore rilevate sullo stesso progetto
- **Quando** la prenotazione viene annullata
- **Allora** le ore rilevate e le presenze restano invariate

### Scenario: fusione di risorse
- **Dato** due risorse duplicate, la seconda con prenotazioni di aule
- **Quando** si fondono
- **Allora** le prenotazioni risultano della risorsa corretta

### Scenario: eliminazione di una risorsa
- **Dato** una risorsa con prenotazioni attive e annullate
- **Quando** la risorsa viene eliminata
- **Allora** tutte le sue prenotazioni sono eliminate

## Divergenze note

Punti in cui il codice di oggi non mantiene ciò che i requisiti dicono, o in cui due parti del codice applicano la stessa regola in modo diverso. Si correggono nella voce R-194 di `Attivita Rinviate.md`; con la correzione il requisito si aggiorna e questa sezione si accorcia. Le righe segnate "dedotta" derivano dalla lettura del codice e vanno provate sul banco; non si decide qui se un comportamento sia un difetto.

| Codice | Divergenza | Conseguenza |
|---|---|---|
| DIV-AUL-1 | `AULA_VERIFICA_SOVRAPPOSIZIONE` non controlla i giorni di chiusura della sede: li guardano solo le ricerche di orari liberi (`AULE_CERCA_SLOT_LIBERI_RISORSA`) e le viste (`AULE_PRENOTAZIONI_ELENCO`, `AULE_ELENCO_SOVRAPPOSIZIONI`, `AULE_RIEPILOGO_UTILIZZO`). Il ticket 133 ha allineato ricerca e salvataggio su lezioni, riunioni e inagibilità ma non sulle chiusure | Una prenotazione, una lezione o una riunione si salva in un giorno di chiusura che la ricerca non propone; il giorno compare poi in "Elenco Sovrapposizioni" come conflitto |
| DIV-AUL-2 | Il controllo di sovrapposizione di `AULE_PRENOTAZIONI_AIU0` riparte se cambiano annullamento, data, ora di inizio o durata, **non** se cambia l'aula. Lo sposta di una prenotazione su un'altra aula (trascinamento nel calendario, che scrive anche `AULA`) è fermato solo dall'indice univoco sulla stessa ora di inizio | Una prenotazione trascinata su un'altra aula con fascia sovrapposta ma ora di inizio diversa si salva senza avviso; l'aula risulta occupata due volte. Dedotta dal codice del trigger |
| DIV-AUL-3 | Il vincolo ammette `ORA_FINE = 00:00`, ma `OVERLAP_TIME(inizio1, fine1, inizio2, fine2)` confronta con la fine numerica: una fine a mezzanotte vale "prima di ogni inizio", quindi non è mai in conflitto; la durata calcolata da `MINUTES_BETWEEN` risulta negativa | Una prenotazione serale che finisce a mezzanotte non blocca nulla e non è bloccata da nulla; la ricerca slot finisce comunque entro le 23:59. Dedotta |
| DIV-AUL-4 | Nella modifica, `AULE_PRENOTAZIONI_BUD0` controlla il richiedente con il valore **nuovo** (`NEW.ID_RISORSA`) e non con quello registrato. Con le regole 2 e 4 un utente che cambia il richiedente di una prenotazione altrui con la propria risorsa supera il controllo e la prende in carico | Il controllo "solo il richiedente" si aggira se la scheda lascia modificare il richiedente (da verificare nella scheda LZ `Aule.Aule_Prenotazioni`). Dedotta |
| DIV-AUL-5 | L'autorizzazione "Aule.Gestione" (`AUTH.AULE_PRENOTAZIONI_GESTIONE`, colonna `USR_DEFAULT_AUTHORIZATIONS.AULE_PRENOTAZIONI_GESTIONE`) non è richiesta da nessun trigger, procedura o menu del dizionario LZ. Anche "Autorizza" non verifica chi la esegue: né un'autorizzazione, né che l'utente sia un responsabile (`AULE_RESPONSABILI`) | Chiunque apra l'elenco Autorizzazioni può autorizzare qualunque prenotazione. Dedotta |
| DIV-AUL-6 | `dmAule.Autorizza` chiama `AULE_PRENOTAZIONI_AUTORIZZA` senza valorizzare `ID_RESPONSABILE_AULE`, e la procedura scrive il parametro così com'è | La prenotazione risulta autorizzata (data e ora) ma senza responsabile: `RESPONSABILE_AULA` resta vuoto e non si sa chi ha autorizzato. Il trigger si accorge solo di cambi del responsabile, quindi non lo compila |
| DIV-AUL-7 | Il flag `NOTIFICA_RICHIESTA_AI_RESPONSAB` non è letto da nessun oggetto: la richiesta di autorizzazione parte solo se qualcuno invia a mano la mail, a un solo indirizzo di configurazione (`CONFIG.EMAIL_AUTORIZZAZIONE_AULE`) | Spuntare il flag nell'aula non ha alcun effetto; i responsabili non ricevono nulla |
| DIV-AUL-8 | `EliminaPrenotazioneAula` (eliminazione dal calendario) cancella la riga con `Delete` sul dataset della tabella `AULE_PRENOTAZIONI`, mentre `AULE_PRENOTAZIONI_BD0` rifiuta ogni cancellazione fisica fuori dalle eccezioni; la trasformazione in annullamento esiste solo per la vista `AULE_PRENOTAZIONI_ELENCO` | Dal calendario "Elimina" mostra l'errore "Le prenotazioni non si cancellano…" e non permette di indicare il motivo; si annulla dalla scheda. Dedotta, da provare sul banco |
| DIV-AUL-9 | `AULE_PRENOTAZIONI_INCOLLA_ORA/GIORN/SETT` saltano la destinazione se esiste una riga con stessa aula, data e ora di inizio, anche annullata, mentre l'indice univoco ignora le annullate; copiano anche le prenotazioni annullate (restano annullate) e non le note; incolla giorno e settimana copiano **tutte** le aule, anche quelle non visibili; il richiedente resta quello dell'originale. Nel taglio, l'annullamento della riga di partenza avviene anche quando la copia è stata saltata | Una prenotazione annullata nel giorno di destinazione impedisce di incollarci sopra una prenotazione valida; incollare un giorno può duplicare prenotazioni di aule di cui l'utente non vede il calendario; tagliare e incollare nella stessa aula, data e ora (la riga di partenza è la riga "esistente") annulla la prenotazione senza crearne una nuova. L'ultimo punto dedotto |
| DIV-AUL-10 | `AULE_PRENOTAZIONI_INCOLLA_SETT` calcola la fine della settimana di partenza come `SRC_DATA + 6 giorni` ma l'inizio come lunedì della settimana | Se la data di partenza non è un lunedì, vengono copiate anche le prenotazioni dei primi giorni della settimana seguente, spostate della stessa differenza. Dedotta: dipende dalla data passata dall'interfaccia |
| DIV-AUL-11 | Le prenotazioni annullate compaiono in più punti: in `CALENDARIO_AULE` (form Calendario Aule) e in `CALENDARIO_AGENDA_PERSONALE` (agenda del richiedente) non c'è il filtro `ANNULLATA`, che invece c'è in `CALENDARIO_PRENOTAZIONE_AULE`; nell'elenco `AULE_ELENCO_SOVRAPPOSIZIONI` una prenotazione annullata è segnalata come sovrapposta. Inoltre `CALENDARIO_PRENOTAZIONE_AULE` mostra le lezioni senza guardare `LEZIONE_SVOLTA`, mentre ricerche e salvataggio ignorano le lezioni non svolte | Una prenotazione annullata continua a occupare visivamente l'aula nel Calendario Aule e nell'agenda personale, ma non nel calendario delle prenotazioni; ricerche e salvataggio la ignorano. Una lezione non svolta appare nel calendario come se occupasse l'aula, che invece si può prenotare |
| DIV-AUL-12 | `AULE_ELENCO_SOVRAPPOSIZIONI` segnala una sovrapposizione se prenotazione e lezione cadono nello stesso **giorno** sulla stessa aula, senza confrontare le fasce orarie; non filtra le inagibilità annullate; il ramo "inagibilità" di `AULE_PRENOTAZIONI_ELENCO` non filtra `ANNULLATA = 'N'` (`AULE_RIEPILOGO_UTILIZZO` invece lo fa) | L'elenco mostra come conflitti casi che il salvataggio accetta (stesso giorno, fasce diverse) e come inagibili periodi annullati nelle occupazioni; il filtro del ticket 133 sta in `AULA_VERIFICA_SOVRAPPOSIZIONE`, `AULA_LIBERA` e nel riepilogo, non in queste due viste |
| DIV-AUL-13 | `AULE_PRENOTA_PERIODO` con lo svuotamento cancella **tutte** le prenotazioni dell'aula che si sovrappongono alle fasce scelte, anche quelle inserite a mano da altri e quelle annullate; la cancellazione passa comunque da `AULE_PRENOTAZIONI_BUD0`, quindi le regole di modifica 2-4 (GESTY-AUL-010) valgono anche per lo svuotamento | Il commento del ticket 133 parla di "righe generate", ma la procedura non distingue le generate dalle altre. Chi può prenotare ma non modificare le prenotazioni altrui vede lo svuotamento fermarsi al primo giorno con una prenotazione altrui, con annullamento dell'intera operazione. Dedotta |

<!-- footer -->
---

[www.zebro.it/gesty](https://www.zebro.it/gesty)
<!-- /footer -->
