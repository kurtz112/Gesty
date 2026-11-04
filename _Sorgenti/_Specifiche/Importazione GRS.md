---
area: Importazione GRS
progetto: Gesty
aggiornato: 2026-11-04
rilascio: Ticket_Gesty/324 - problema ore registrate trasferite senza alcun incarico- err/001
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

# Importazione GRS

Questa specifica descrive le regole che Gesty rispetta quando importa i file del registro elettronico (GRS, il tracciato regionale del registro scaricato da ClasseViva; con lo stesso percorso anche i file GOL e il registro scaricato da SIUF): registrazione e controllo del file, riconoscimento di allievi, docenti, progetti e corsi, confronto con le lezioni già presenti, scrittura di lezioni, presenze, incarichi di supplenza e rilevamenti dei docenti, rielaborazione ed eliminazione. Descrive il comportamento atteso, non il codice.

Le regole stanno quasi tutte nel database: procedure `GRS_IMPORT_FILES_ADD`, `GRS_IMPORT_FILES_PROCESSA_FILE`, `GRS_IMPORT_FILES_VALIDA_TESTO`, `GRS_IMPORT_FILES_RISOLVI_RIGA`, `GRS_IMPORT_FILES_CONFRONTA`, `GRS_IMPORT_FILES_DECIDI`, `GRS_IMPORT_FILES_ELABORA`, `GRS_IMPORT_FILES_ELABORA_RIGHE_NON_VALIDE`, `GRS_IMPORT_FILES_ELIMINA`, `GRS_IMPORT_ADD_PRES_COLLETTIVA`, `GRS_IMPORT_ADD_PRES_SOSTEGNO`, `GRS_IMPORT_ADD_PRESENZA_INTERVENTI_INTEGRATIVI`, `GRS_IMPORT_ADD_PRES_FORMAZIONE_INTERNA`, `GRS_IMPORT_GENERA_SUPPLENZA`, `GRS_IMPORT_AGGANCIA_INCARICO`, `GRS_IMPORT_AGGANCIA_RILEVAMENTO`, `INCARICHI_GET_X_IMPORT_GRS`, `INCARICHI_GET_X_SOSTEGNO`; funzioni `GRS_IMPORT_TROVA_LEZIONE`, `GRS_IMPORT_FILES_SOSTEGNO_NON_ISCRITTI_MSG`; trigger `GRS_IMPORT_FILES_BI`, `GRS_IMPORT_FILES_BIU0`, `GRS_IMPORT_FILES_RIGHE_ELABORAZ_BIU0`, `GRS_IMPORT_FILES_RIGHE_ELAB_AD0`. Il resto sta nel modulo dati `dmGRS.pas` e nella form `frmGRS.pas` (comandi "Importa GRS", "Importa GOL", "Importa SIUF", "Elabora", "Elimina", "Rielabora righe non valide", "Genera incarico", "Genera rilevamento", scelte sulla scheda "Differenze con Gesty") e nel modulo dati LZ `GRS`.

**Fuori da quest'area**, con una specifica propria: le presenze degli allievi in sé (stati, minuti, "Calcolare", registro, firma), in *Presenze allievi e registro*; il rilevamento delle ore dei docenti, in `Rilevamento ore.md` (qui compare solo quello che l'importazione genera); l'invio a SIUF, il blocco dei periodi trasmessi, la sezione e il codice fiscale del docente nel tracciato, il controllo giornaliero di importazioni e invii, in *Trasmissione a SIUF*; le importazioni Untis e OmniaTime, in un'altra bozza; i riepiloghi del sostegno (ticket 233).

**Origine.** Ricavata il 2026-10-30 dal database master `GESTY` (fotografia dei metadati delle 13:19 dello stesso giorno), dai sorgenti in `SRC\Gesty_Group\_Sorgenti` (`dmGRS.pas`, `frmGRS.pas`) e dal dizionario LZ in `SRC\Gesty_Group\LZ` (modulo `GRS`), e dalle preanalisi dei ticket 83, 127, 166, 167, 182, 191, 206, 215, 216, 228, 233, 237, 259, 260, 271, 275, 307. Il ticket 171 non ha una preanalisi: il difetto dei codocenti non contati è la voce R-171, già consegnata. Dove una regola viene solo da un ticket e non è stata riletta sul codice, il requisito cita il ticket.

## GESTY-GRS-001 File che si importano
Dalla sezione GRS si importano tre tracciati, con colonne in ordine fisso e la prima riga d'intestazione saltata:
- **GRS** ("Importa GRS"): foglio elettronico `.xlsx` o `.xls`, oppure `.csv` o `.xml`, con le colonne da A a P: codice fiscale studente, cognome, nome, data, ora d'inizio, ora di fine, ore di presenza, assenza, assenza giustificata, riferimento dell'evento formativo, tipologia, codice fiscale del docente, materia, contenuti, sede, codice fiscale del codocente. Le colonne oltre la P (motivo e date di chiusura) non si leggono;
- **GOL** ("Importa GOL"): stesso contenuto con la sezione in colonna A e nome e cognome invertiti; la tipologia `AULA` vale `1`;
- **registro SIUF** ("Importa SIUF"): GESTY-SIU-019.

Prima di registrare il file, Gesty toglie da ogni cella i caratteri di controllo, gli a capo e gli spazi non separabili, e sostituisce il punto e virgola con la virgola. L'importazione registra soltanto il file; l'elaborazione parte subito dopo, sempre passando dal confronto di GESTY-GRS-010 (ticket 228).

### Scenario: file importato
- **Dato** un file `.xlsx` del registro di una classe
- **Quando** l'operatrice lo importa con "Importa GRS"
- **Allora** il file compare nell'elenco "Import GRS" e Gesty propone subito il confronto e l'elaborazione

## GESTY-GRS-002 Lo stesso file non si importa due volte
Un file con lo stesso contenuto di uno già registrato viene rifiutato, anche se ha un nome diverso. Il confronto è sul contenuto (impronta del testo), non sul nome.

### Scenario: file caricato due volte
- **Dato** il file del 23/09 già importato con il numero 27591
- **Quando** lo si importa di nuovo
- **Allora** l'importazione si ferma con "File già importato: 27591"

## GESTY-GRS-003 Struttura del file controllata prima di scrivere
Prima di scrivere una sola riga, Gesty controlla che ogni riga abbia nelle prime sedici colonne il tipo di valore atteso (codice fiscale, data, orario, numero di ore, testo). Se una riga non torna, il file non viene importato e il messaggio dice riga, colonna, valore trovato e valore atteso, e prova a spiegare il motivo: colonna mancante, colonna in più, due colonne scambiate. Un codice fiscale non viene mai riportato nel messaggio. La tipologia deve essere un codice di al massimo due caratteri oppure `AULA` (ticket 259). Sede e codocente (colonne 15 e 16) sono facoltative: una riga che si ferma ai contenuti è valida e si legge senza codocente (R-171).

### Scenario: colonna del codice fiscale mancante
- **Dato** un file in cui la prima colonna contiene il cognome
- **Quando** lo si importa
- **Allora** compare "Il file ha una struttura diversa da quella prevista e non e' stato importato: nessuna riga e' stata scritta. Prima anomalia, riga 2: manca probabilmente la colonna 1 (Codice fiscale studente)..."

### Scenario: righe a quattordici colonne
- **Dato** un file che si ferma alla colonna dei contenuti
- **Quando** lo si importa
- **Allora** le righe si leggono senza sede e senza codocente, e non risultano codocenti non trovati

## GESTY-GRS-004 Una riga per allievo e ora d'inizio
Nel file importato una riga è identificata da studente (codice fiscale, cognome, nome), data e ora d'inizio: se il file ne contiene due uguali vale l'ultima. Le ore si leggono nel formato ore.minuti (`1.30` è un'ora e mezza).

### Scenario: riga ripetuta
- **Dato** un file con due righe dello stesso allievo per il 23/09 alle 08:00, la prima presente e la seconda assente
- **Quando** lo si importa
- **Allora** resta una riga sola, assente

## GESTY-GRS-005 Allievi e docenti
L'allievo si riconosce dal codice fiscale fra gli studenti. Il docente e il codocente si riconoscono dal codice fiscale, in quest'ordine: persona fisica fra il personale docente; azienda docente per codice fiscale; azienda docente per partita IVA; persona indicata fra i contatti di un'azienda docente, che vale come l'azienda (ticket 83). Una riga è **valida** quando progetto, allievo e docente sono riconosciuti, e il codocente quando il file lo indica. L'elenco dei file riporta per ciascuno righe totali, valide, non valide, elaborate, e quanti progetti, studenti, docenti e codocenti non sono stati trovati, con due contatori distinti per docenti e codocenti (R-171). Un file è "elaborazione completata" quando non ha righe non valide.

### Scenario: docente di un'azienda
- **Dato** un'azienda docente con il contatto MEGGIORINI CHETY
- **Quando** il file indica come docente il codice fiscale di MEGGIORINI CHETY
- **Allora** la riga ha come docente l'azienda

### Scenario: codocente non censito
- **Dato** un file con un codice fiscale di codocente che non corrisponde a nessun docente
- **Quando** lo si elabora
- **Allora** la riga non è valida e il file conta un codocente non trovato

## GESTY-GRS-006 Progetto della riga
Il progetto si cerca in quest'ordine, e vince il primo che risponde:
1. solo per il sostegno (tipologie 14 e 32): il progetto di sostegno trasversale a cui l'allievo è iscritto alla data, se il docente vi ha un incarico di sostegno valido a quella data (ticket 167);
2. il progetto il cui codice regionale è il riferimento dell'evento formativo della riga;
3. l'iscrizione dell'allievo il cui piano formativo (`STUDENTI_PROGETTI.IDENTIF_PIANO_FORMATIVO`) è quel riferimento, aperta alla data; fra più iscrizioni vince il progetto in corso alla data della lezione, poi l'iscrizione più recente (ticket 206);
4. se l'allievo non è iscritto al progetto trovato, il progetto collegato a cui è iscritto alla data (`PROGETTI_COLLEGATI`).

Se alla fine l'allievo non risulta iscritto a nessuno, la riga resta senza allievo e compare fra gli "Studenti non abbinati". Quando la riga va sul trasversale, il riferimento dell'evento formativo (il codice della classe) viene copiato nel piano formativo dell'iscrizione al trasversale se è vuoto e non supera 50 caratteri; un valore già presente non si tocca: serve all'invio per allievo (GESTY-SIU-004). Una volta deciso, il progetto della riga resta quello anche nelle elaborazioni successive.

### Scenario: passaggio d'anno con l'iscrizione vecchia aperta
- **Dato** un allievo iscritto al 2025/2026 (mai chiuso) e al 2026/2027 con lo stesso piano formativo
- **Quando** si elabora una lezione del 05/10/2026
- **Allora** la riga va sul progetto 2026/2027, senza l'errore "multiple rows in singleton select"

### Scenario: allievo del sostegno trasversale
- **Dato** un allievo della 1K iscritto al trasversale "SOSTEGNO CAPAC AMORETTI 2026/2027 - KML" e un docente con incarico di tipo Sostegno sul trasversale
- **Quando** si elabora una sua ora di sostegno con riferimento `194591`
- **Allora** l'ora va sul trasversale, e l'iscrizione al trasversale prende `194591` come piano formativo se non lo aveva

## GESTY-GRS-007 Corso della riga
Nei progetti con più corsi (apprendistato) la riga va nel corso a cui l'allievo è iscritto alla data; fra più iscrizioni vince quella con il piano formativo uguale al riferimento della riga. Il corso decide su quale lezione cade la presenza (GESTY-GRS-011) e quali allievi ricevono le assenze d'ufficio (GESTY-GRS-014). Nei progetti senza corsi tutto resta senza corso. Sostegno e interventi integrativi non usano il corso (ticket 166).

### Scenario: due corsi alla stessa ora
- **Dato** il progetto APPRENDISTATO DUALE AMORETTI 2026/2027 con 3 MAP e 4 MAP a lezione alla stessa ora
- **Quando** si elabora il file del 3 MAP
- **Allora** le presenze vanno sulle lezioni del 3 MAP e nessun allievo del 4 MAP viene segnato assente

## GESTY-GRS-008 Dove va ogni riga, secondo la tipologia
Solo le righe con allievo e progetto riconosciuti producono qualcosa. La tipologia decide il registro:

| Tipologia | Registro | Requisito |
|---|---|---|
| `4` formazione interna | presenze di formazione interna | GESTY-GRS-019 |
| `14`, `32` sostegno | ore e presenze di sostegno | GESTY-GRS-016 |
| `21`, `22`, `23` interventi integrativi | ore e presenze degli interventi integrativi | GESTY-GRS-018 |
| tutte le altre, compresa `5` formazione esterna, `17` e `24`-`27` | lezioni d'aula e presenze collettive | GESTY-GRS-011 |

Le tipologie dei servizi individuali (17, 24-27: colloqui, definizione del percorso, accoglienza) vanno oggi sul registro collettivo. CAPAC ha chiesto di portarle sul registro individuale agganciandole a piano, servizio e incarico già esistenti, mai creati con valori presunti, e scartando con segnalazione le righe senza; manca la corrispondenza fra tipologie e servizi del catalogo (ticket 182). Nelle schermate le tipologie 21-27 mostrano la descrizione e si salvano: l'annotazione sta nella descrizione del dominio, non dopo il codice (ticket 182).

### Scenario: colloquio specialistico
- **Dato** un file con due righe di tipologia 24 per CIURAR ALEX il 24/09 dalle 14:30
- **Quando** lo si elabora
- **Allora** nascono due lezioni d'aula di tipologia 24 con le sue presenze, e gli altri iscritti ricevono l'assenza d'ufficio di GESTY-GRS-014

## GESTY-GRS-009 Stato dell'allievo in ogni ora
Una riga del file copre una fascia che Gesty divide in ore da 60 minuti a partire dall'inizio. Per ogni ora lo stato si assegna consumando le ore del file in quest'ordine: assenza giustificata, poi assenza, poi presenza. Un'assenza conta se supera un quarto d'ora (più di `0.15`); un residuo di assenza fino a 15 minuti diventa, sull'ora di presenza, minuti di assenza (ritardo o uscita anticipata).

### Scenario: due ore con un'ora di assenza
- **Dato** una riga dalle 08:00 alle 10:00 con presenza `1` e assenza `1`
- **Quando** la si elabora
- **Allora** l'allievo è assente nell'ora delle 08:00 e presente in quella delle 09:00 (l'ordine nella giornata non è quello reale: il file non lo dice)

### Scenario: ritardo di dieci minuti
- **Dato** una riga di un'ora con presenza `0.50` e assenza `0.10`
- **Quando** la si elabora
- **Allora** l'allievo è presente con 10 minuti di assenza

## GESTY-GRS-010 Confronto con le lezioni già presenti
Prima di scrivere, Gesty confronta il file con le lezioni d'aula già presenti e registra le differenze su docente, codocente, materia, contenuti e stato della presenza dei singoli allievi (scheda "Differenze con Gesty"). Il confronto non tocca lezioni, presenze e incarichi. Se il file cambierebbe lezioni non ancora decise, l'operatrice sceglie fra: sovrascrivere tutte quelle lezioni con il file, supplenze comprese; decidere lezione per lezione ("Mantieni Gesty" o "Sovrascrivi") e poi rilanciare "Elabora"; annullare. Senza decisione l'elaborazione non parte. Una lezione mantenuta come in Gesty non cambia docente, materia, contenuti e presenze, non genera supplenze e non riceve assenze d'ufficio. La decisione vale per l'intera lezione e non si cambia più dopo che il file l'ha elaborata (ticket 228). Le lezioni nuove non si confrontano.

### Scenario: docente diverso da quello in calendario
- **Dato** una lezione del 14/10 alle 09:00 con docente ROSSI in Gesty e BIANCHI nel file
- **Quando** si elabora il file
- **Allora** compare "Il file cambierebbe 1 lezioni gia' presenti in Gesty..." con le tre scelte, e la lezione resta com'è finché l'operatrice non decide

### Scenario: decisione già usata
- **Dato** una lezione già elaborata dal file con la decisione "Sovrascrivi"
- **Quando** l'operatrice sceglie "Mantieni Gesty"
- **Allora** compare "La lezione del ... e' gia' stata elaborata da questo file: la decisione non si puo' piu' cambiare."

## GESTY-GRS-011 Lezione d'aula: trovata o creata
La presenza di un'ora cade sulla lezione dello stesso progetto e corso, nello stesso giorno, che contiene l'ora. Se non c'è, nasce una lezione nuova con progetto, corso, tipologia, materia, contenuti, docente, codocente, incarichi e sede della riga. Se c'è, la lezione prende dal file docente, codocente, materia e contenuti **a ogni importazione**, anche se docente e incarico non cambiano (ticket 127); tipologia, orario e sede della lezione esistente restano quelli di Gesty. La materia del file entra nell'elenco delle materie e fra quelle del progetto, se manca.

### Scenario: contenuti aggiornati
- **Dato** una lezione con contenuti "Presentazione programma" e lo stesso docente del file
- **Quando** si importa un file con contenuti "Conoscenza classe"
- **Allora** la lezione ha contenuti "Conoscenza classe"

### Scenario: lezione che non c'era
- **Dato** nessuna lezione il 24/09 alle 14:30
- **Quando** si elabora un colloquio di quell'ora
- **Allora** nasce la lezione 14:30-15:30 nel corso dell'allievo, con la tipologia del file

## GESTY-GRS-012 Incarico del docente sulla lezione
Se la lezione non ha incarico, l'importazione cerca per il docente un incarico di formazione collettiva sul progetto, valido alla data, collegato al corso se la riga ne ha uno, con ore residue: prima fra quelli con la stessa materia della lezione, poi fra tutti; a parità vince quello iniziato prima. Gli incarichi a ore esaurite non si scelgono, anche se ammettono il superamento delle ore (diverso dal sostegno, GESTY-GRS-016). Lo stesso vale per il codocente. Le lezioni rimaste senza incarico compaiono in "Incarichi mancanti", da cui si apre l'inserimento guidato dell'incarico ("Genera incarico"), che poi viene agganciato alla lezione. L'incarico si cerca solo quando la lezione nasce o si importa: ogni notte il controllo `CRON_VERIFICA_INCARICHI_MANCANTI` (chiamato da `CRON`) ripassa le lezioni svolte fino a oggi, dal 01/09/2025, con docente e senza incarico, e aggancia quello che oggi le copre con la stessa ricerca dell'importazione (`ORARIO_AGGANCIA_INCARICHI_MANCANTI`, ticket 314). Salta le lezioni di supplenza e non tocca il codocente (DIV-GRS-16). Se dopo il passaggio restano lezioni scoperte, il Centro Notifiche avvisa gli iscritti all'avviso "Lezioni svolte senza incarico" (a CAPAC: Alessio Sabrina, Marinoni Serena, Faelli Joyce) con il numero e i docenti interessati; l'avviso non si ripete finché il numero non cambia, e comunque dopo sette giorni. Ogni utente che ha inserito lezioni rimaste scoperte (chi ha elaborato il file GRS o scritto l'orario) riceve inoltre un avviso personale con le sole lezioni sue, con la stessa regola di ripetizione, purché sia attivo, non sia un utente di servizio e non sia già iscritto all'avviso generale. L'avviso conta le lezioni della vista `ORARIO_LEZIONI_SENZA_INCARICO` (svolte, fino a oggi, dal 01/09/2025, con docente e senza incarico); il clic sull'avviso apre "Incarichi mancanti" con le stesse lezioni, e per l'avviso personale con le sole lezioni dell'utente (ticket 324).

### Scenario: dall'avviso all'elenco
- **Dato** un avviso "Lezioni svolte senza incarico: 9" nel Centro Notifiche
- **Quando** l'utente fa clic sull'avviso
- **Allora** si apre "Incarichi mancanti" con le stesse 9 lezioni, ciascuna con il suo motivo (ticket 324)

### Scenario: avviso a chi ha inserito le lezioni
- **Dato** 6 lezioni scoperte inserite in orario da un'operatrice che non è iscritta all'avviso, e 3 inserite da un'iscritta
- **Quando** gira il controllo notturno
- **Allora** gli iscritti ricevono l'avviso di tutte le 9 lezioni; l'operatrice riceve "Lezioni inserite da te senza incarico: 6", e il clic le apre l'elenco con le sole sue 6; l'iscritta non riceve un secondo avviso (ticket 324)

### Scenario: materia dell'incarico
- **Dato** un docente con due incarichi sul progetto, uno di MATEMATICA e uno senza materia, entrambi con ore residue
- **Quando** si elabora una sua lezione di MATEMATICA
- **Allora** la lezione prende l'incarico di MATEMATICA

### Scenario: incarico esaurito
- **Dato** un docente con un solo incarico sul progetto e nessuna ora residua
- **Quando** si elabora una sua lezione
- **Allora** la lezione resta senza incarico e compare in "Incarichi mancanti"

### Scenario: incarico creato dopo l'importazione
- **Dato** 72 lezioni di un docente importate dal 05/10 al 29/10 senza incarico, e un incarico inserito il 30/10 che le copre con ore residue
- **Quando** passa il controllo notturno
- **Allora** le 72 lezioni prendono quell'incarico, escono da "Incarichi mancanti" e passano in "Rilevamenti mancanti", da cui "Genera rilevamento" crea le ore del docente (il controllo notturno non ha un utente con login e non le genera: il trigger delle ore rilevate rifiuta "Utente non abilitato al rilevamento ore")

## GESTY-GRS-013 Supplenza
Quando la lezione esistente ha un docente (o un codocente) diverso da quello del file e la lezione si sovrascrive, il docente del file è un supplente, e l'incarico si sceglie così:
1. un incarico di supplenza del supplente sul progetto, non ancora attivato, valido alla data e con almeno un'ora residua, preparato dalla segreteria;
2. altrimenti la supplenza generata dall'importazione per lo stesso giorno e lo stesso incarico sostituito, a cui si aggiunge un'ora;
3. altrimenti un incarico nuovo di un giorno e di un'ora: stesso tipo, sede e descrizione dell'incarico sostituito, compenso dall'incarico di massima del supplente per ente e anno (senza collegarlo all'incarico di massima), nessun protocollo, nota "Generato da import GRS. id_file_grs N", segnato come generato dall'importazione. È una supplenza dell'incarico sostituito solo se quello ha ancora ore residue.

Un supplente senza inquadramento alla data ferma l'elaborazione con "Inquadramento non definito per la risorsa.". Il rilevamento della lezione passa al supplente (GESTY-RIL-010: l'importazione riscrive i rilevamenti che ha generato). Una supplenza della lezione di una classe mista si collega alla supplenza del master, così il controllo di sovrapposizione la accetta (ticket 307, rilascio accettato il 30/10 alle 18:30, dopo la fotografia del master: da verificare installato).

### Scenario: prima ora di supplenza
- **Dato** una lezione con docente ROSSI e incarico 500 con ore residue, e BIANCHI nel file
- **Quando** si elabora con "Sovrascrivi"
- **Allora** nasce per BIANCHI un incarico di supplenza di 1 ora, del giorno della lezione, in sostituzione dell'incarico 500, e la lezione passa a BIANCHI

### Scenario: seconda ora dello stesso giorno
- **Dato** la supplenza appena generata
- **Quando** il file riporta BIANCHI anche nell'ora successiva in sostituzione dello stesso incarico
- **Allora** la stessa supplenza passa a 2 ore

## GESTY-GRS-014 Presenze collettive e assenze d'ufficio
Ogni ora della riga crea o aggiorna la presenza dell'allievo sulla lezione, con lo stato e i minuti di GESTY-GRS-009; una presenza nuova nasce da calcolare. Finito il file, su ogni lezione del progetto che si sovrappone a una riga del file, nel corso di almeno un allievo del file, ogni iscritto a quel corso alla data che non ha ancora una presenza riceve un'assenza d'ufficio **esclusa dal calcolo** (non va a SIUF, GESTY-PRE-004, ticket 260). Le lezioni mantenute come in Gesty (GESTY-GRS-010) non ricevono assenze d'ufficio. Su un giorno già trasmesso a SIUF ogni scrittura dell'elaborazione segue GESTY-SIU-017.

### Scenario: allievo assente dal file
- **Dato** una classe di 20 iscritti e un file che riporta 18 allievi alle 09:00
- **Quando** lo si elabora
- **Allora** i due allievi mancanti hanno sulla lezione delle 09:00 un'assenza esclusa dal calcolo

### Scenario: altro corso dello stesso progetto
- **Dato** il file del 3 MAP
- **Quando** lo si elabora
- **Allora** gli iscritti al 4 MAP non ricevono assenze d'ufficio, né sulle lezioni del 3 MAP né sulle proprie (ticket 166)

## GESTY-GRS-015 Rilevamento del docente della lezione d'aula
Per ogni lezione d'aula con docente e incarico, l'importazione genera o riusa il rilevamento del docente e dei codocenti, uno per lezione, qualunque sia il numero di allievi (GESTY-RIL-007, GESTY-PRE-016). Una lezione segnata non svolta non genera rilevamento. Se la generazione non riesce (sovrapposizione con un altro rilevamento, incarico del codocente mancante) l'errore non ferma l'elaborazione: la lezione resta senza rilevamento (DIV-RIL-4) e compare in "Rilevamenti mancanti", da cui "Genera rilevamento" lo crea mostrando l'errore.

### Scenario: lezione senza rilevamento
- **Dato** una lezione importata con incarico e senza rilevamento
- **Quando** l'operatrice la seleziona in "Rilevamenti mancanti" e preme "Genera rilevamento"
- **Allora** nasce il rilevamento, oppure compare l'errore che l'importazione aveva taciuto

## GESTY-GRS-016 Sostegno
Le righe di sostegno (14, 32) con docente riconosciuto producono un'ora di sostegno per progetto, docente, giorno e ora d'inizio, con gli allievi presenti su quell'ora; le righe senza docente si saltano. Il progetto è la classe (modello per classe) o il trasversale (GESTY-GRS-006); i due modelli convivono. L'incarico è un incarico di tipo sostegno (`ZZ_TIPI_INCARICO.FORMAZIONE_SOSTEGNO`) dello stesso progetto, valido alla data: hanno la precedenza quelli con ore residue, poi quello iniziato prima; a ore esaurite resta valido solo se ammette il superamento delle ore (ticket 167). Gli incarichi `PEI` non sono sostegno: riconoscono le ore di redazione del piano educativo, a timesheet (ticket 167). Con l'incarico nasce il rilevamento del docente, collegato all'ora di sostegno (ticket 167); una sovrapposizione con un altro rilevamento del docente ferma l'elaborazione del file, e il messaggio aggiunge allievo, progetto della riga, riga del file e, se il conflitto è sul trasversale, l'invito a iscrivere l'allievo (ticket 271). Il codocente del file non si usa: nel sostegno non esiste (ticket 167). La presenza di sostegno si crea o si aggiorna, sempre da calcolare.

### Scenario: tre allievi nella stessa ora
- **Dato** un file con tre allievi del trasversale seguiti da Agradi il 18/09 alle 12:00
- **Quando** lo si elabora
- **Allora** nasce una sola ora di sostegno con tre presenze e un solo rilevamento di Agradi

### Scenario: docente senza incarico di sostegno
- **Dato** un docente che sulla classe ha solo incarichi `PEI`
- **Quando** si elabora una sua ora di sostegno
- **Allora** l'ora nasce senza incarico e senza rilevamento, e non scala ore

### Scenario: classe mista con incarichi non collegati
- **Dato** un docente con l'incarico della 4°A e un incarico della 4°C non collegato, e un file con allievi delle due classi alle 10:00
- **Quando** lo si elabora
- **Allora** l'elaborazione si ferma con il messaggio di sovrapposizione (GESTY-RIL-006); collegando l'incarico della 4°C a quello della 4°A e rielaborando, il file passa (ticket 215, 216)

## GESTY-GRS-017 Allievi non iscritti al trasversale
Prima di scrivere, Gesty controlla le righe di sostegno ancora da elaborare: se nella stessa ora lo stesso docente ha allievi iscritti al trasversale e allievi che non lo sono, l'ora finirebbe su due progetti. In quel caso l'elaborazione non parte e un solo messaggio elenca gli allievi da iscrivere (al massimo quattro, poi "e altri N"), ciascuno con la prima data e ora, il docente e il trasversale (ticket 271).

### Scenario: allievo da iscrivere
- **Dato** un file in cui Agradi segue alle 12:00 un allievo iscritto al trasversale e ZHOU, che non lo è
- **Quando** si elabora il file
- **Allora** compare "Ore di sostegno con lo stesso docente per allievi iscritti al progetto trasversale e allievi non iscritti..." con la riga di ZHOU, e non si scrive nulla

## GESTY-GRS-018 Interventi integrativi
Le righe 21, 22, 23 vanno sul progetto degli interventi integrativi indicato per l'ente e l'anno formativo (`ENTI_ANNI_FORMATIVI.ID_PROGETTO_INTERVENTI_INTEGRATIVO`); senza, l'elaborazione si ferma con "Anno formativo non configurato per l'ente.". Un'ora si riusa se esiste già per lo stesso docente, giorno e ora d'inizio, oppure sullo stesso progetto, tipologia e fascia; la presenza dell'allievo porta il progetto e il corso della sua classe. L'incarico è un incarico di interventi integrativi del docente sul progetto degli interventi, e con l'incarico nasce il rilevamento (DIV-GRS-4).

### Scenario: ente senza progetto degli interventi
- **Dato** un ente senza progetto degli interventi integrativi per il 2026/2027
- **Quando** si elabora una riga di tipologia 22 di ottobre 2026
- **Allora** l'elaborazione si ferma con "Anno formativo non configurato per l'ente."

## GESTY-GRS-019 Formazione interna
Le righe di tipologia 4 producono una presenza di formazione interna per l'intera fascia (più ore in una presenza sola), con docente indicato solo come codice fiscale, materia, contenuti e sede del file. Non cercano incarichi e non generano rilevamenti.

### Scenario: mattina di formazione interna
- **Dato** una riga di tipologia 4 dalle 09:00 alle 13:00
- **Quando** la si elabora
- **Allora** nasce una presenza di formazione interna di 240 minuti, senza rilevamento del docente

## GESTY-GRS-020 Rielaborazione
Un file si può rielaborare ("Elabora") quante volte serve, per esempio dopo aver censito un allievo, iscritto un allievo o creato un incarico: le righe già elaborate si saltano, quelle non ancora elaborate passano di nuovo dal riconoscimento e dal confronto. Per correggere righe già elaborate (allievo sul progetto sbagliato, lezione sbagliata) bisogna prima togliere quello che hanno prodotto (GESTY-GRS-021): rielaborare senza togliere lascia tutto com'è (ticket 166, 275). "Rielabora righe non valide" rilancia l'elaborazione di tutti i file che hanno righe non valide (DIV-GRS-7).

### Scenario: allievo censito dopo l'importazione
- **Dato** un file con una riga di uno studente non trovato
- **Quando** lo studente viene censito e iscritto, e si rilancia "Elabora"
- **Allora** la sua riga viene elaborata, le altre restano come erano

## GESTY-GRS-021 Eliminazione di un file e di quello che ha prodotto
"Elimina" toglie, dopo due conferme, il file con le sue righe e quello che ha generato e che nessun altro file usa: presenze collettive, lezioni create dal file rimaste senza presenze e non nate da un'importazione dell'orario, rilevamenti, presenze e ore di sostegno con il loro rilevamento, presenze di formazione interna. Le lezioni nate da un'importazione dell'orario tornano al docente dell'orario, con il suo incarico. Una sola presenza nata da un file non si cancella da sola: si cancella l'intero file (DIV-PRE-8, che vale identica per il sostegno, ticket 275).

### Scenario: file sbagliato
- **Dato** un file elaborato che ha creato sei lezioni nuove con le loro presenze
- **Quando** lo si elimina
- **Allora** spariscono presenze, rilevamenti e le sei lezioni; le lezioni già presenti prima restano

### Scenario: una sola ora di sostegno da togliere
- **Dato** due ore di sostegno di un file, una giusta e una da togliere
- **Quando** l'operatrice elimina quella sbagliata dalla lista del sostegno
- **Allora** l'eliminazione si ferma con "Inconguenza registrazione GRS: presenza non generata." (ticket 275)

## GESTY-GRS-022 Elenchi di controllo
Per ogni file la sezione GRS mostra righe, presenze generate da ogni riga (con docente dell'incarico e del rilevamento), differenze con Gesty, progetti, studenti e docenti non trovati, studenti non abbinati (riconosciuti ma non iscritti al progetto alla data), righe senza materia o contenuti, righe senza incarico, righe non valide; e, su tutti i file, lezioni svolte senza incarico e lezioni svolte fino a oggi con incarico e senza rilevamento. Gli elenchi non modificano nulla. "Incarichi mancanti" mostra solo le lezioni fino a oggi (le future non sono ancora svolte) e una colonna **Motivo** che dice perché la lezione è scoperta: incarico disponibile e in attesa del controllo notturno, lezione di sostegno messa in orario (il sostegno si registra con le ore di sostegno, GESTY-GRS-016, e nessun incarico di formazione la coprirà mai: va tolta dall'orario), nessun incarico del docente sul progetto, incarico che non copre la data, ore esaurite, supplenza, docente mancante, anno formativo precedente al 2025/2026 (non verificato) (ticket 314, 324). Di norma l'elenco mostra le stesse lezioni che conta l'avviso (dal 01/09/2025, con docente); il filtro "Anche anni precedenti" aggiunge quelle più vecchie e quelle senza docente. La colonna "Inserita da" dice chi ha inserito la lezione (ticket 324).

### Scenario: studente non abbinato
- **Dato** un allievo riconosciuto dal codice fiscale ma non iscritto alla classe del file alla data della lezione
- **Quando** si apre "Studenti Non Abbinati" del file
- **Allora** l'allievo compare con il riferimento dell'evento formativo della riga

## GESTY-GRS-023 Esportazione in foglio elettronico verso il GRS
Dalla sezione GRS ogni vista di esportazione si salva in `.xlsx` con le diciannove colonne del tracciato (le sedici dell'importazione più motivo, data d'inizio e data di fine della chiusura), tutte come testo; le ore si scrivono come intero o come ore.minuti (`1.30`). Cosa entra nelle viste e con quale codice fiscale del docente è descritto in GESTY-SIU-005 e GESTY-SIU-010.

### Scenario: ora e mezza
- **Dato** una riga con 90 minuti di presenza
- **Quando** si esporta
- **Allora** la colonna "Ore Presenza" vale `1.30`

## Divergenze note

Punti in cui il codice di oggi non mantiene ciò che i requisiti dicono, o in cui due parti del codice applicano la stessa regola in modo diverso. Raccolte in R-185; con la correzione il requisito si aggiorna e questa sezione si accorcia. Quelle segnate "dedotto" vengono dalla lettura del codice e vanno provate sul banco. Restano in sospeso, senza essere divergenze: la segnalazione nell'importazione degli allievi assenti al sostegno e delle ore con più di tre allievi (R-089, ticket 233) e l'instradamento dei servizi individuali sul registro individuale (ticket 182).

| Codice | Divergenza | Conseguenza |
|---|---|---|
| DIV-GRS-1 | Per ogni ora di una riga lunga più di un'ora, `GRS_IMPORT_FILES_ELABORA` (e allo stesso modo `GRS_IMPORT_FILES_CONFRONTA`) calcola l'ora corrente ma passa ai rami collettivo, sostegno e interventi integrativi sempre l'ora d'inizio della riga (dedotto) | Una riga 08:00-10:00 produce due volte l'ora delle 08:00: la seconda ora non nasce e lo stato della prima è quello dell'ultima. I file ClasseViva visti finora hanno una riga per ora (ticket 166, 167), quindi oggi il caso non si presenta |
| DIV-GRS-2 | Lo stato dell'ora (GESTY-GRS-009) non si azzera fra un'ora e l'altra né fra una riga e l'altra: se presenza, assenza e assenza giustificata sono esaurite o zero, resta lo stato dell'ora precedente, anche di un altro allievo (dedotto) | Una riga con tutte le ore a zero, o con meno ore della fascia, prende lo stato della riga prima; sulla prima riga del file lo stato resta vuoto |
| DIV-GRS-3 | Quando l'allievo ha già una presenza sulla lezione, il ramo collettivo aggiorna stato e minuti ma non rimette "Calcolare" a vero; sostegno e interventi integrativi invece lo rimettono (dedotto) | Un'assenza d'ufficio esclusa dal calcolo (GESTY-GRS-014), che un file successivo trasforma in presenza, resta esclusa: l'allievo presente non va a SIUF e vale zero ore |
| DIV-GRS-4 | `GRS_IMPORT_ADD_PRESENZA_INTERVENTI_INTEGRATIVI` genera il rilevamento ma non lo scrive nell'ora dell'intervento (inserimento senza `ID_RILEVAMENTO_ORE`, aggiornamento con il commento `-- ID_RILEVAMENTO_ORE ?`): è il difetto corretto per il sostegno nel ticket 167. `GRS_IMPORT_FILES_ELIMINA` non tratta gli interventi integrativi; con il docente non riconosciuto l'inserimento fallisce con "Errore Inserimento Tabella Sostegno." | Cancellando l'ora dell'intervento le ore restano scalate all'incarico; eliminando il file il rilevamento sparisce ma ore e presenze dell'intervento restano; il messaggio parla di sostegno anche per gli interventi |
| DIV-GRS-5 | Se la lezione esistente ha un docente ma nessun incarico e il file porta un altro docente, la supplenza si cerca con un incarico sostituito vuoto e non trova nulla; la ricerca dell'incarico proprio del docente del file non si fa (dedotto) | La lezione passa al nuovo docente senza incarico e senza rilevamento, anche se lui ha un incarico valido sul progetto |
| DIV-GRS-6 | L'incarico del codocente si cerca fra gli incarichi di formazione collettiva, non fra quelli di codocenza; e in `ORARIO_GENERA_RILEVAMENTO` un codocente senza incarico annulla anche il rilevamento del docente, in silenzio (dedotto) | Un codocente con un incarico di sola codocenza non viene agganciato, e il docente principale della stessa lezione resta senza ore (DIV-RIL-4) |
| DIV-GRS-7 | "Rielabora righe non valide" chiama `GRS_IMPORT_FILES_ELABORA` su tutti i file del database con righe non valide, senza il confronto e le decisioni di GESTY-GRS-010; il controllo di GESTY-GRS-017 di un solo file ferma tutta l'operazione. Le righe di aula senza docente sono già "elaborate" (la lezione nasce senza docente) e la rielaborazione le salta: la riga diventa valida ma la lezione resta senza docente | Lezioni già in Gesty possono essere sovrascritte senza che nessuno abbia deciso; censire il docente dopo l'importazione non sistema le lezioni |
| DIV-GRS-8 | Gli elenchi "Docenti Non Trovati" cercano solo fra le persone fisiche, mentre l'importazione riconosce anche aziende e loro contatti (GESTY-GRS-005); "Progetti Non Trovati" su tutti i file guarda solo il codice regionale, quello del singolo file anche il piano formativo; nessuno dei due conosce trasversale e progetti collegati | Un docente azienda riconosciuto compare fra i non trovati; le sezioni di apprendistato risultano progetti non trovati nell'elenco generale |
| DIV-GRS-9 | Il controllo dei doppioni di `GRS_IMPORT_FILES_ADD` confronta con l'identificativo del file ancora vuoto e non trova mai nulla: il riuso di un file registrato senza righe non avviene, e decide sempre il trigger `GRS_IMPORT_FILES_BI` | La registrazione avviene in una transazione propria, quindi un file fermato dopo (struttura sbagliata, allievi da iscrivere al trasversale) resta nell'elenco senza righe o non elaborato, e reimportarlo identico dà "File già importato": va ripreso dall'elenco con "Elabora". Il messaggio della procedura "Il file risulta già importato" non compare mai |
| DIV-GRS-10 | Il controllo della struttura accetta come tipologia qualunque codice di due caratteri; un codice che il dominio `TIPOLOGIA_FORMAZIONE` non ammette (per esempio `9` o `33`) fa fallire la scrittura della riga (dedotto) | Invece del messaggio comprensibile di GESTY-GRS-003 compare l'errore di vincolo di Firebird, senza riga né colonna. Nello stesso dominio la voce `9` "--FAD" dell'elenco non è ammessa dal vincolo |
| DIV-GRS-11 | Il ramo della formazione interna scrive sempre presente con zero minuti di assenza, qualunque cosa dica il file (dedotto) | Un'assenza in un file di formazione interna diventa presenza |
| DIV-GRS-12 | Quando l'incarico sostituito non ha più ore, la supplenza nasce come incarico normale (non supplenza, senza incarico sostituito); le due ricerche di riuso di GESTY-GRS-013 vogliono una supplenza e non la ritrovano (dedotto) | Per un titolare a ore esaurite ogni ora sostituita genera un incarico nuovo di un'ora; 4.687 supplenze generate su CAPAC (ticket 307) |
| DIV-GRS-13 | Nella supplenza il passaggio del rilevamento al supplente, se non riesce (rilevamento validato, legato a un'altra regola), viene ignorato: il rilevamento si stacca dalla lezione e resta del titolare (dedotto) | Il titolare conserva un'ora validata di una lezione che risulta tenuta dal supplente, e il supplente riceve un rilevamento suo |
| DIV-GRS-14 | Eliminando un file, sulle lezioni nate da un'importazione dell'orario si cancella sempre il rilevamento corrente della lezione, anche se il docente non era cambiato; le supplenze generate dal file restano, e i rilevamenti dei codocenti non si toccano (dedotto) | Il titolare perde il rilevamento della sua lezione finché non lo si rigenera; restano incarichi di supplenza senza ore |
| DIV-GRS-15 | Le presenze importate su una lezione segnata non svolta in Gesty si scrivono senza avviso, e il confronto non segnala la differenza (dedotto) | Il file del registro dice che la lezione si è tenuta, Gesty che non si è tenuta: l'ora non va a SIUF (GESTY-SIU-005) e non genera rilevamento, senza che nessuno lo veda |
| DIV-GRS-16 | Il riaggancio notturno (ticket 314) cerca l'incarico del solo docente principale: l'incarico dei codocenti (`ID_INCARICO_COD_1..3`) e le lezioni di supplenza restano com'erano. Non genera i rilevamenti ore, perché il trigger `ORE_RILEVATE_BIU0` richiede un utente con login. L'elenco "Incarichi mancanti" filtra però sul solo docente principale | Le lezioni con codocente scoperto non compaiono in "Incarichi mancanti" e non si riagganciano da sole; dopo il riaggancio le ore del docente non esistono finché qualcuno non preme "Genera rilevamento" in "Rilevamenti mancanti" |

<!-- footer -->
---

[www.zebro.it/gesty](https://www.zebro.it/gesty)
<!-- /footer -->
