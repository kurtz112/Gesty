---
area: Importazione Untis e OmniaTime
progetto: Gesty
aggiornato: 2026-10-30
rilascio: OUT/20261030-specifiche-vive-dei-progetti/015
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

# Importazione Untis e OmniaTime

Questa specifica descrive le regole che Gesty rispetta in tre funzioni che portano dati da fuori: l'importazione dell'orario delle lezioni dai file Untis (Calendario Corsi, file orario), la generazione del calendario dalle ore lezione provvisorie (Generazione Calendario) e l'importazione delle timbrature e dei precaricamenti OmniaTime, da cui nascono le presenze dei dipendenti (Personale, Presenze). Descrive il comportamento atteso, non il codice. Le regole stanno quasi tutte nel database: procedure `ORARIO_IMP_FILES_UNTIS_*`, `UNTIS_*_ADD`, `TMP_ORARIO_*`, `OMNIATIME_FILES_*`, `PERSONALE_ORARIO_GET`, trigger `ORARIO_IMPORT_FILES_UNTIS_BI`, `ORARIO_IMPORT_FILE_UNTIS_ELENCO_BU0`, `TMP_ORARIO_BI0`, `OMNIATIME_FILES_BI`, `OMNIATIME_RIGHE_AU0`, `OMNIATIME_RIGHE_BD0`, `PERSONALE_PRESENZE_BIU0`, `PERSONALE_PRESENZE_AIU0`; il programma (`dmOrario`, `dmPersonalePresenze`) chiede conferma, chiama le procedure e mostra gli esiti.

**Fuori da quest'area**, con una specifica propria: le regole del rilevamento ore che le importazioni toccano (sovrapposizioni, validazione, legame con l'orario: `Rilevamento ore`, GESTY-RIL-*), le presenze degli allievi, la firma e il congelamento del registro (`Presenze allievi e registro`, GESTY-PRE-*), l'importazione GRS (altra specifica), la trasmissione a SIUF, le stampe.

**Origine.** Ricavata il 2026-10-30 dal codice del database master `GESTY` (fotografia dei metadati del 2026-10-30 13:19), dai sorgenti di `D:\AI\SRC\Gesty_Group` e dal dizionario LZ di `SRC`, a partire dalle preanalisi dei ticket 28, 72, 134, 205, 261, 262, 263, 271, 272, 277, 279, 290, 307. I ticket 271, 272, 277, 279 e 307 riguardano l'importazione GRS: qui non compaiono, se non per dire che l'importazione Untis non genera rilevamenti (GESTY-IMP-015). Ogni regola è stata riletta sul codice; dove una regola viene solo da un ticket, il requisito lo dice.

## Importazione dell'orario da Untis

## GESTY-IMP-001 Un file Untis si importa una volta sola
Un file si riconosce dal contenuto, non dal nome: se il suo contenuto è identico a quello di un file già importato, l'importazione si ferma con "File già importato: <id>". Il file si registra in una transazione propria, poi si elabora (GESTY-IMP-014): se l'elaborazione fallisce, il file resta registrato senza righe, e per riprovare si usa "Elabora" su quel file, perché importarlo di nuovo verrebbe rifiutato come doppione. Le righe vuote del file si ignorano. Importando più file insieme, un file che fallisce mostra il suo errore e l'importazione passa al successivo.

### Scenario: stesso file con un altro nome
- **Dato** un file Untis già importato come `orario_settimana_41.txt`
- **Quando** si importa lo stesso contenuto salvato come `copia.txt`
- **Allora** l'importazione si ferma con "File già importato: <id del primo file>"

### Scenario: elaborazione fallita all'importazione
- **Dato** un file con una lezione di durata 90 minuti
- **Quando** lo si importa
- **Allora** compare "Durata lezione non valida." e il file resta nell'elenco senza righe; dopo aver corretto la causa si rielabora con "Elabora"

## GESTY-IMP-002 Lettura della riga del file
Ogni riga del file è una lezione, con i campi separati da virgola in quest'ordine: docente, anno, mese, giorno, numero dell'ora, materia, classe, aula, due campi non usati, numero della lezione, ora di inizio (`HHMM`), durata in minuti. L'anno formativo si ricava dalla data della lezione. Il codice della classe si legge per i primi 20 caratteri: la parte che eccede si perde (vedi DIV-IMP-1). Una lezione più lunga di 60 minuti ferma l'elaborazione dell'intero file con "Durata lezione non valida.", con durata, data, ora, classe e materia.

### Scenario: riga valida
- **Dato** la riga `BONINO,2020,5,4,4,IRC/ET.-MOR,3M,,0,,632,1400,60,`
- **Quando** il file si elabora
- **Allora** nasce la riga del file del 04/05/2020, dalle 14:00 alle 15:00, classe `3M`, materia `IRC/ET.-MOR`, docente `BONINO`, anno formativo 2019/2020

## GESTY-IMP-003 Una riga per file, giorno, ora e classe
In un file c'è al massimo una riga per data, ora di inizio e classe Untis (`UNQ1_ORARIO_IMP_FILES_UNTIS_RIG`). Rielaborando un file, ogni riga si riscrive sulla propria; la stessa classe alla stessa ora in un altro file è una riga diversa, che appartiene a quel file.

### Scenario: rielaborazione dello stesso file
- **Dato** un file già elaborato
- **Quando** lo si elabora di nuovo
- **Allora** il numero delle righe del file resta lo stesso, senza doppioni

## GESTY-IMP-004 Le voci da transcodificare nascono da sole
Ogni classe (per anno formativo), docente, materia e aula che compare in un file e non è ancora nota a Gesty diventa una voce di transcodifica vuota, da collegare nelle schede Untis Progetti, Untis Docenti, Untis Materie, Untis Aule. Il collegamento vale per tutte le righe e per tutti i file con lo stesso nome Untis, anche successivi. Le lezioni già create non cambiano da sole: si aggiornano solo elaborando di nuovo il file. L'elenco "Dati Untis da transcodificare" conta le voci ancora vuote, escluse quelle segnate come extra gestionali.

### Scenario: classe nuova
- **Dato** un file con la classe `1B  PASTI`, mai vista nell'anno 2026/2027
- **Quando** il file si elabora
- **Allora** in Untis Progetti compare la voce `1B  PASTI` / 2026/2027 senza progetto, e le righe di quella classe non diventano lezioni (GESTY-IMP-007)

## GESTY-IMP-005 La dicitura Untis non si modifica
In Untis Progetti la chiave è la coppia dicitura Untis e anno formativo (`PK_UNTIS_PROGETTI`): nella scheda sono in sola lettura, si modifica solo il progetto collegato. Lo stesso vale per la dicitura in Untis Materie. Più diciture diverse della stessa classe (per esempio con uno o due spazi, come arrivano dai file) si collegano allo stesso progetto: sono voci distinte con lo stesso progetto, e non si cancellano, perché l'importazione successiva le ricreerebbe vuote (ticket 134).

### Scenario: due diciture della stessa classe
- **Dato** la voce `1B PASTI` / 2026/2027 collegata al progetto 1°B e la voce `1B  PASTI` / 2026/2027 senza progetto
- **Quando** si apre la seconda voce e si sceglie il progetto 1°B
- **Allora** il salvataggio riesce e da quel momento le righe con l'una e con l'altra dicitura diventano lezioni di 1°B

## GESTY-IMP-006 Collegamento dalla riga del file
Dalla griglia delle righe di un file, aprendo la scheda della riga, si collegano materia, docente e progetto; gli altri campi della riga restano quelli importati. Il collegamento si scrive nella transcodifica (`ORARIO_IMPORT_FILE_UNTIS_ELENCO_BU0`), quindi vale come in GESTY-IMP-004 per tutte le righe con lo stesso nome Untis, e il progetto si sceglie fra quelli dell'anno formativo della riga. Una riga senza il nome Untis da collegare si rifiuta con un messaggio (ticket 205).

### Scenario: materia collegata da una riga
- **Dato** due righe di file diversi con la materia Untis `ITA`, non collegata
- **Quando** dalla scheda della prima riga si sceglie la materia Italiano e si conferma
- **Allora** entrambe le righe mostrano Italiano; le lezioni già create restano senza materia finché non si rielabora il file

### Scenario: riga senza materia Untis
- **Dato** una riga del file senza materia
- **Quando** se ne sceglie la materia
- **Allora** il salvataggio si ferma con "La riga non ha una materia Untis: non c'e' niente da collegare."

## GESTY-IMP-007 Righe incomplete e anomalie dell'elaborazione
Una riga la cui classe non è collegata a un progetto non diventa lezione. Una riga con classe collegata ma materia o docente non collegati diventa una lezione senza materia o senza docente. Al termine dell'importazione o dell'elaborazione, il programma elenca questi casi per ciascun file, con il numero delle righe, escluse le voci extra gestionali: "Elaborazione completata, ma alcune righe non sono state importate per intero: ... Completare le transcodifiche Untis (Progetti, Materie, Docenti) ed elaborare di nuovo il file." Le aule non collegate non compaiono nell'elenco (DIV-IMP-4).

### Scenario: classe senza progetto
- **Dato** un file con 3 righe della classe `LADA bar`, senza progetto
- **Quando** il file si elabora
- **Allora** le 3 righe restano senza lezione e il riepilogo riporta "Classe senza progetto: lezioni non create: LADA bar <anno> (3 righe)"

## GESTY-IMP-008 Un codice classe, un progetto
Ogni codice classe di Untis, per anno formativo, porta a un solo progetto, e ogni riga del file crea al più una lezione. Una lezione comune a più classi arriva come un codice unico (`3B PASTI~3C SALA BAR`): oggi diventa una lezione del solo progetto collegato a quel codice, e le altre classi non la ricevono (ticket 263, DIV-IMP-1).

### Scenario: lezione comune a due classi
- **Dato** il codice `3B PASTI~3C SALA BAR` collegato al progetto 3°C
- **Quando** si elabora un file con una lezione di Italiano con quel codice
- **Allora** la lezione nasce sul calendario di 3°C e non su quello di 3°B

## GESTY-IMP-009 Creazione e aggiornamento delle lezioni
Per ogni riga con progetto, la lezione si cerca nel calendario del progetto per data e fascia sovrapposta. Se non c'è, si crea; se c'è, si riscrivono data, ora, durata, tipologia, materia, aula, docente e incarico, anche se la lezione era stata inserita o corretta a mano (ticket 134). La lezione nasce come formazione collettiva (con la tipologia ITS/IFTS se il progetto lo è) e senza corso; l'incarico è quello del docente valido per progetto, data e materia (`INCARICHI_GET_X_ORARIO`), se c'è. Una materia che il progetto non ha ancora gli viene aggiunta con monte ore 0. Restano escluse le lezioni del registro firmato (GESTY-IMP-010) e, per docente e incarico, quelle con ore già rilevate (GESTY-IMP-011).

### Scenario: lezione nuova
- **Dato** una riga di 3°C del 20/10 alle 09:00, materia collegata a Italiano, che il progetto non ha fra le sue materie
- **Quando** il file si elabora
- **Allora** nasce la lezione del 20/10 dalle 09:00 alle 10:00 e Italiano entra fra le materie del progetto con monte ore 0

### Scenario: lezione corretta a mano
- **Dato** una lezione del 20/10 alle 09:00 a cui la segreteria ha cambiato l'aula
- **Quando** si elabora un file che contiene quella lezione con l'aula di Untis
- **Allora** la lezione torna all'aula del file

## GESTY-IMP-010 Il registro firmato non si tocca
Una lezione con il registro firmato (`ORARIO.BLOCCA_RILEVAMENTI_DOCENTI`, GESTY-PRE-011) non viene modificata dall'elaborazione, e la riga del file resta senza lezione collegata. Il controllo guarda la lezione che comincia alla stessa ora della riga (DIV-IMP-2).

### Scenario: lezione firmata
- **Dato** una lezione firmata del 19/10 alle 08:00
- **Quando** si elabora un file che per quell'ora indica un altro docente
- **Allora** la lezione resta col docente firmato

## GESTY-IMP-011 Lezione con ore già rilevate
Se la lezione ha già un rilevamento ore (`ORARIO.ID_RILEVAMENTO_ORE`) e il file indica un docente o un incarico diversi, docente e incarico della lezione non cambiano; gli altri dati si aggiornano. Prima l'elaborazione si fermava con la violazione di `FK_ORARIO_ORE_RILEVATE` (ticket 262). Nessun avviso dice quali lezioni sono rimaste col docente vecchio (DIV-IMP-3).

### Scenario: cambio di docente dopo il rilevamento
- **Dato** una lezione del 19/10 alle 08:00 con docente A e il suo rilevamento ore
- **Quando** si elabora un file che per quell'ora indica il docente B
- **Allora** l'elaborazione riesce e la lezione resta al docente A

## GESTY-IMP-012 Aule della lezione importata
Prima di assegnare l'aula, l'elaborazione la toglie alle altre lezioni sovrapposte che la occupano, purché non firmate e di progetti la cui area di riferimento ammette la sovrascrittura del calendario (`ZZ_AREE_RIFERIMENTO.SOVRASCRIVI_CALENDARIO_CORSI`). Poi l'aula assegnata passa dai controlli consueti dell'aula: altra prenotazione, lezione già svolta, riunione, inagibilità. Un conflitto ferma l'elaborazione dell'intero file con il messaggio del controllo (per esempio "L'aula risulta inagibile per <motivo>.").

### Scenario: aula occupata da una lezione non firmata
- **Dato** una lezione non firmata di un altro progetto, con area che ammette la sovrascrittura, nell'aula 12 alle 09:00
- **Quando** si elabora un file che mette nell'aula 12 alle 09:00 una lezione di 3°C
- **Allora** l'altra lezione resta senza aula e quella di 3°C la prende

### Scenario: aula inagibile
- **Dato** l'aula 12 inagibile il 20/10
- **Quando** si elabora un file con una lezione nell'aula 12 il 20/10
- **Allora** l'elaborazione si ferma e nessuna riga del file viene salvata

## GESTY-IMP-013 Lezioni che il file non contiene più
Dopo aver scritto le lezioni, per ogni progetto del file e nel periodo che il file copre per quel progetto (dalla prima all'ultima lezione), si cancellano le lezioni create da un altro file Untis che il file elaborato non contiene più (nessuna sua lezione sovrapposta nello stesso giorno). Restano sempre: le lezioni inserite a mano o generate dal calendario, quelle con registro firmato o presenze congelate, quelle con presenze collettive registrate e quelle che vengono dall'importazione GRS (`ORARIO_IMPORT_FILES_RIGHE`). Il confronto non guarda quale dei due file sia più recente (DIV-IMP-5).

### Scenario: lezione tolta dalla settimana
- **Dato** una lezione di 3°C del 21/10 alle 11:00 creata dal file della settimana precedente, senza presenze
- **Quando** si elabora il file nuovo della stessa settimana, che alle 11:00 del 21/10 non ha nulla per 3°C
- **Allora** la lezione delle 11:00 viene cancellata

### Scenario: lezione inserita a mano
- **Dato** una lezione di 3°C del 21/10 alle 15:00 inserita a mano
- **Quando** si elabora un file che copre il 21/10 senza quell'ora
- **Allora** la lezione resta

## GESTY-IMP-014 Elaborazione: un file alla volta, tutto o niente
"Elabora" chiede conferma ("Si desidera elaborare i files selezionati?") e lavora i file selezionati uno dopo l'altro, ciascuno in una transazione propria: un file si elabora per intero o non cambia nulla. Un errore ferma il file in corso e quelli che seguono; i file già elaborati restano. Annullare dalla finestra di avanzamento ferma prima del file successivo. Il riepilogo delle anomalie (GESTY-IMP-007) compare a elaborazione finita.

### Scenario: errore sul secondo di tre file
- **Dato** tre file selezionati, il secondo con un'aula inagibile
- **Quando** si elaborano
- **Allora** il primo resta elaborato, il secondo resta com'era e il terzo non viene elaborato

## GESTY-IMP-015 L'importazione Untis non rileva ore
L'importazione crea e aggiorna lezioni, non rilevamenti ore: i rilevamenti dei docenti nascono dalla firma del registro (GESTY-PRE-011) e restano legati alla lezione (GESTY-RIL-012). Per questo i blocchi per sovrapposizione delle ore del docente (GESTY-RIL-006, ticket 271, 272, 277, 279, 307) non si presentano qui.

### Scenario: elaborazione di una settimana nuova
- **Dato** un docente con lezioni in due classi alla stessa ora nel file
- **Quando** il file si elabora
- **Allora** nascono le due lezioni e nessun rilevamento ore

## GESTY-IMP-016 Ente e sede del file
Il file importato porta un ente e una sede (`ORARIO_IMPORT_FILES_UNTIS.ID_ENTE`, `ID_SEDE`), che seguono la sede se questa cambia identificativo. All'importazione nascono vuoti e si possono indicare dalla scheda del file; l'elaborazione non li usa: le lezioni dipendono solo dai progetti e dalle aule collegati (ticket 261, DIV-IMP-7).

### Scenario: file senza sede
- **Dato** un file importato senza ente e sede
- **Quando** lo si elabora
- **Allora** le lezioni nascono come per un file con la sede indicata

## GESTY-IMP-017 Cancellazione di un file
Cancellare un file importato cancella le sue righe; le lezioni che il file aveva creato restano nel calendario, senza più legame con un file Untis, e quindi da quel momento valgono come lezioni inserite a mano (GESTY-IMP-013). Da verificare sul banco (DIV-IMP-6).

### Scenario: file cancellato
- **Dato** un file elaborato che ha creato 30 lezioni
- **Quando** lo si cancella dall'elenco dei file
- **Allora** le 30 lezioni restano e un file successivo non le cancella più

## Generazione del calendario

## GESTY-IMP-018 Ore lezione provvisorie dell'utente
Nella Generazione Calendario le ore lezione da ripetere (inizio, fine, tipologia, materia, docente, incarico, aula) si preparano in una tabella provvisoria (`TMP_ORARIO`) che appartiene alla sola connessione di chi lavora: due utenti che preparano calendari insieme non vedono l'uno le righe dell'altro, e le righe spariscono chiudendo il programma. La sessione della riga la scrive il database (`TMP_ORARIO_BI0`); nella stessa preparazione due ore non cominciano alla stessa ora e l'inizio precede la fine. Le ore provvisorie si azzerano cambiando progetto o corso e con "Azzera".

### Scenario: inserimento di un'ora dalla scheda
- **Dato** un utente nella griglia "Ore Lezione"
- **Quando** inserisce un'ora dalle 09:00 alle 13:00 con il comando Inserisci
- **Allora** l'ora si salva senza che l'utente indichi la sessione (ticket 72, da riprovare sul banco: DIV-IMP-17)

### Scenario: fine prima dell'inizio
- **Dato** la griglia "Ore Lezione"
- **Quando** si salva un'ora dalle 11:00 alle 10:00
- **Allora** il salvataggio si ferma per il vincolo `CHK1_TMP_ORARIO`

## GESTY-IMP-019 Generazione delle lezioni
"Genera" crea, per il progetto e il corso scelti, una lezione per ogni ora intera (60 minuti) delle ore provvisorie, in ogni giorno del periodo che cade nei giorni della settimana scelti. Se nel calendario c'è già una lezione del progetto e corso che comincia alla stessa ora, non se ne crea un'altra: la si aggiorna con tipologia, materia, aula, docente e incarico, salvo che abbia già un rilevamento ore, nel qual caso resta com'è. Senza progetto o senza periodo non si genera nulla; senza ore provvisorie compare "Nessuna lezione inserita.".

### Scenario: mattina ripetuta per un mese
- **Dato** un'ora provvisoria dalle 09:00 alle 12:00, il periodo 01/10-31/10 e i soli lunedì
- **Quando** si genera
- **Allora** ogni lunedì di ottobre ha tre lezioni, alle 09:00, 10:00 e 11:00

### Scenario: lezione già rilevata
- **Dato** un lunedì in cui la lezione delle 09:00 ha già il rilevamento del docente
- **Quando** si genera con un altro docente
- **Allora** la lezione delle 09:00 resta col docente rilevato, le altre si aggiornano

## Importazione OmniaTime

## GESTY-IMP-020 File OmniaTime: tipo e unicità
Un file OmniaTime è di timbrature o di precaricamenti: il tipo si riconosce dal contenuto (un file con il punto e virgola è di precaricamenti). Come per Untis, un file con contenuto identico a uno già importato si rifiuta con "File già importato: <id>"; il contenuto "Nessun oggetto trovato" vale come file vuoto. Importazione ed elaborazione stanno in un'unica transazione: un errore annulla anche la registrazione del file. Importando più file, il primo errore ferma i successivi.

### Scenario: file di precaricamenti
- **Dato** un file con righe `127;20230102;SW;8:30;13:00;`
- **Quando** lo si importa
- **Allora** il file è registrato come precaricamenti e le righe come precaricamenti di smart working

## GESTY-IMP-021 Lettura delle timbrature
Ogni riga di un file di timbrature ha posizioni fisse: lettore, verso (`E` entrata, `U` uscita), badge, giorno, mese, anno a due cifre, ore e minuti. L'ora si arrotonda alla mezz'ora: da 0 a 15 minuti all'ora intera, da 16 a 44 alla mezza, da 45 a 59 all'ora successiva. Il dipendente si ricava dal numero del badge senza zeri iniziali, fra i badge validi alla data della timbratura; un badge che non corrisponde a nessuno prende il codice `B` (Badge non trovato) e non genera presenze. Una riga illeggibile ferma il file con "Errore caricamento file presenze.", con id e nome del file e numero della riga.

### Scenario: arrotondamento
- **Dato** un'entrata alle 08:14 e un'uscita alle 17:50
- **Quando** il file si importa
- **Allora** le timbrature valgono 08:00 e 18:00

### Scenario: badge riassegnato
- **Dato** il badge 40 assegnato a una dipendente fino al 31/03 e a un'altra dal 01/04
- **Quando** si importa una timbratura del badge 40 del 09/04
- **Allora** la timbratura va alla seconda dipendente

## GESTY-IMP-022 Lettura dei precaricamenti
Ogni riga di un file di precaricamenti porta badge, data (`AAAAMMGG`), tipo, entrata e uscita. I tipi ammessi sono `SW` (smart working), `SERVIZ` (uscita di servizio), `SERVRIP` (servizio in giorno non lavorativo), `PRESFS` (presenza fuori sede), `PRESFS-R` (presenza fuori sede in giorno di riposo), `SWGGRIP` (smart working in giorno di riposo); un altro tipo ferma il file con "Tipo Precaricamento non gestito", con badge, data e tipo. Nella presenza generata smart working, uscita di servizio e servizio in giorno non lavorativo hanno un tipo proprio; gli altri tre diventano "Altro" (DIV-IMP-16).

### Scenario: tipo sconosciuto
- **Dato** un file con una riga di tipo `FERIE`
- **Quando** lo si importa
- **Allora** l'importazione si ferma con "Tipo Precaricamento non gestito" e il file non resta registrato

## GESTY-IMP-023 Accoppiamento di entrata e uscita
Per ogni dipendente e giorno le timbrature si leggono in ordine di ora (a parità d'ora prima l'uscita) e si accoppiano un'entrata con l'uscita che la segue. Una coppia valida dà l'orario rilevato a entrambe le righe. Le timbrature che non si accoppiano prendono un codice e non generano presenze: un'uscita senza entrata prima `E` (Entrata precedente non trovata); due entrate di fila, la prima `U` (Uscita precedente non trovata); un'entrata senza uscita in fondo alla giornata `C` (Uscita collegata non trovata). Una coppia in cui, dopo l'arrotondamento, l'uscita non segue l'entrata resta senza orario rilevato e senza codice (DIV-IMP-15).

### Scenario: entrata dimenticata
- **Dato** per un dipendente il 12/10 le timbrature E 08:30, U 12:30, U 17:30
- **Quando** il file si elabora
- **Allora** la coppia 08:30-12:30 è valida e l'uscita delle 17:30 prende il codice `E`

## GESTY-IMP-024 Normalizzazione sull'orario di lavoro
L'orario rilevato si riporta all'orario di lavoro del dipendente valido alla data (`PERSONALE_ORARIO`, due fasce al giorno): chi entra prima dell'inizio della prima fascia risulta entrato all'inizio, e se esce dopo la fine della prima fascia risulta uscito alla fine. Chi entra in orario o dopo conserva l'orario rilevato. Se l'orario normalizzato si discosta da quello rilevato di oltre 60 minuti, all'entrata o all'uscita, la coppia prende il codice `N` (Errore normalizzazione Orario) e non genera presenze finché non si correggono a mano le ore (GESTY-IMP-026). La regola per la fascia del pomeriggio è scritta ma non scatta (DIV-IMP-9).

### Scenario: entrata anticipata
- **Dato** un dipendente con orario 08:30-12:30, che timbra 08:00 e 12:00
- **Quando** il file si elabora
- **Allora** la presenza vale 08:30-12:00

### Scenario: scarto oltre l'ora
- **Dato** un dipendente con orario 08:30-12:30, che timbra 07:00 e 16:00
- **Quando** il file si elabora
- **Allora** la coppia prende il codice `N` e non genera la presenza

## GESTY-IMP-025 Timbratura singola
Per i dipendenti con l'orario a timbratura singola (`PERSONALE_ORARIO.TIMBRATURA_SINGOLA`) basta una timbratura al giorno: la riga diventa l'entrata della prima fascia dell'orario del giorno e Gesty aggiunge le righe che mancano (uscita della prima fascia, entrata e uscita della seconda), con gli orari dell'orario. Un giorno con la sola seconda fascia usa quella. Rielaborando il file, le righe aggiunte si cancellano e si ricreano, e il risultato non cambia (ticket 290). La domenica usa l'orario della domenica (prima del ticket 290 usava la fine del lunedì).

### Scenario: dipendente a timbratura singola
- **Dato** una dipendente con timbratura singola e orario del martedì 09:30-13:00 e 14:00-17:30
- **Quando** si elabora un file con una sua timbratura del martedì
- **Allora** nascono le presenze 09:30-13:00 e 14:00-17:30

### Scenario: seconda elaborazione
- **Dato** lo stesso file già elaborato
- **Quando** lo si elabora di nuovo
- **Allora** le presenze sono le stesse, senza righe in più

## GESTY-IMP-026 Correzione a mano delle ore
In una riga del file si possono indicare a mano entrata e uscita (l'entrata deve precedere l'uscita). Le ore a mano prevalgono su quelle rilevate e normalizzate, e rendono la riga utilizzabile anche se aveva un codice di errore; la correzione si copia sull'altra riga della stessa coppia. La presenza si crea o si aggiorna alla successiva elaborazione del file; le ore a mano restano anche quando il file si rielabora.

### Scenario: coppia con errore di normalizzazione
- **Dato** una coppia con il codice `N`
- **Quando** se ne indicano a mano 08:30 e 15:00 e si rielabora il file
- **Allora** nasce la presenza 08:30-15:00

## GESTY-IMP-027 Presenze generate
Ogni coppia utilizzabile (senza codice di errore e da non verificare, oppure con le ore a mano) diventa una presenza del dipendente di tipo "Badge"; per i precaricamenti il tipo segue GESTY-IMP-022. Il rilevatore è la risorsa collegata all'utente che elabora: senza utente collegato l'elaborazione delle timbrature si ferma con "Login non effettuato.". Due righe con lo stesso dipendente, giorno e orario usano la stessa presenza, e una presenza dello stesso tipo e orario già esistente si riusa. Le presenze di un dipendente non si sovrappongono (`PERSONALE_PRESENZE_BIU0`): se la presenza non si può creare, la riga prende il codice `S` (Sovrapposizione presenze personale), le altre righe del file proseguono, e alla rielaborazione si riprova. Il codice `S` copre in realtà qualunque errore nella creazione (DIV-IMP-11).

### Scenario: smart working sovrapposto
- **Dato** una presenza di smart working dalle 14:00 alle 18:00 per una dipendente
- **Quando** si elabora un file di timbrature con la sua coppia 14:00-17:30 dello stesso giorno
- **Allora** la riga prende il codice `S` e le altre presenze del file nascono

## GESTY-IMP-028 Presenze e ore rilevate
Una presenza appena creata si collega ai rilevamenti ore del dipendente di quel giorno che vi stanno dentro per intero e non hanno ancora una presenza. Un rilevamento salvato in seguito prende la presenza che lo contiene (`GET_PRESENZA_PERSONALE`). Ogni collegamento è un salvataggio del rilevamento, e passa dai suoi controlli (GESTY-RIL-006): un rilevamento in sovrapposizione impedisce di creare o di cancellare la presenza che lo contiene (ticket 28, DIV-RIL-3). Una presenza collegata a ore validate non cambia giorno né orario ("Impossibile modificare la presenza: esistono rilevamenti ore validate.").

### Scenario: ora rilevata dentro la presenza
- **Dato** un rilevamento del 09/04 dalle 09:00 alle 11:00 senza presenza
- **Quando** l'elaborazione crea la presenza del 09/04 dalle 08:00 alle 13:00 per lo stesso dipendente
- **Allora** il rilevamento risulta collegato a quella presenza

## GESTY-IMP-029 Rielaborazione di un file
"Elabora" lavora il file selezionato, dopo la conferma "Si desidera elaborare il file di import selezionato?", e si può ripetere. Ogni elaborazione ricalcola il file da capo: ricerca dei badge, accoppiamento, normalizzazione, timbrature singole; cancella le presenze che il file aveva generato e le ricrea. Le correzioni a mano (GESTY-IMP-026) restano. Il file registra la data dell'ultima elaborazione, il numero delle righe e quello delle righe che hanno generato una presenza.

### Scenario: anagrafica del badge corretta
- **Dato** un file con righe in codice `B` perché il badge non era ancora assegnato
- **Quando** si assegna il badge al dipendente e si rielabora il file
- **Allora** le righe prendono il dipendente e generano le presenze

## GESTY-IMP-030 Un errore non intercettato annulla l'intero file
L'elaborazione di un file OmniaTime è un'unica transazione: un errore che non diventa un codice della riga (GESTY-IMP-027) annulla tutto il file, comprese le presenze corrette degli altri dipendenti. Il caso tipico è la rielaborazione di un file per un dipendente che ha due rilevamenti ore sovrapposti: cancellare la sua presenza vecchia aggiorna i rilevamenti collegati, il controllo di sovrapposizione si ferma e nessuna presenza del file viene salvata (ticket 28). Il messaggio cita la persona in conflitto, che può non essere quella di cui mancano le presenze.

### Scenario: conflitto su un'altra dipendente
- **Dato** un file già elaborato, e per la dipendente Z due rilevamenti non collegati e sovrapposti il 09/04, entrambi dentro la sua presenza generata dal file
- **Quando** si rielabora il file
- **Allora** l'elaborazione si ferma con il messaggio di sovrapposizione per Z e mancano le presenze anche della dipendente L, che non ha alcun conflitto (da riprovare sul banco)

## Divergenze note

Punti in cui il codice di oggi non mantiene ciò che i requisiti o i ticket dicono, o in cui due parti del codice applicano la stessa regola in modo diverso. Raccolte in R-186. Con la correzione il requisito si aggiorna e questa sezione si accorcia.

| Codice | Divergenza | Conseguenza |
|---|---|---|
| DIV-IMP-1 | Una lezione comune a più classi arriva con un solo codice (`A~B`), che si collega a un solo progetto; il codice si legge per 20 caratteri e la seconda classe può restare tronca (`1D PAN PAST~1C SALA `); la riga del file tiene una sola lezione (ticket 263, correzione non ancora fatta) | Le altre classi non ricevono le lezioni comuni; nessun messaggio lo segnala |
| DIV-IMP-2 | Il controllo del registro firmato (GESTY-IMP-010) cerca una lezione firmata con la stessa ora di inizio della riga, mentre la lezione da aggiornare si cerca per fascia sovrapposta. `ORARIO_CHECK_FIRMATO`, che proteggerebbe le lezioni firmate, è disattivato | Una lezione firmata alle 09:00 può essere spostata alle 09:30, con docente e materia, da una riga che comincia alle 09:30 |
| DIV-IMP-3 | Quando una lezione rilevata conserva docente e incarico (GESTY-IMP-011), l'elaborazione non lo annota e il riepilogo delle anomalie non lo riporta (ticket 262: "nessun punto di visualizzazione individuato") | Il calendario resta diverso da Untis senza che la segreteria lo sappia |
| DIV-IMP-4 | Il riepilogo delle anomalie non elenca le aule non collegate, che "Dati Untis da transcodificare" invece conta. Il campo "Extra gestionale" di classi, docenti, materie e aule, che esclude le voci dai due elenchi, non compare nelle griglie e schede Untis del dizionario; compare invece "Annullato" di Untis Progetti, che nessuna procedura legge | Una lezione può nascere senza aula senza avviso; una voce non si può escludere dalle anomalie dal programma; segnare una classe annullata non cambia nulla |
| DIV-IMP-5 | `ORARIO_IMP_FILES_UNTIS_ELIMINA_ORARI_NON_VALIDI` dice di togliere le lezioni "non più presenti nel file più recente", ma confronta con qualunque altro file, senza guardare la data. Con più file selezionati l'ordine di elaborazione è quello della selezione nella griglia, ordinata per file dal più recente | Rielaborare un file vecchio riporta il calendario a quel file (ticket 134 lo evita di proposito); elaborando insieme più settimane sovrapposte può prevalere la più vecchia. Da verificare sul banco |
| DIV-IMP-6 | `ORARIO_IMP_FILES_UNTIS_ELIMINA`, che cancella righe e lezioni di un file, non è chiamata da nessuna parte; la cancellazione del file toglie solo le righe (chiave a cascata) | Le lezioni di un file cancellato restano e diventano indistinguibili da quelle inserite a mano |
| DIV-IMP-7 | All'importazione il programma passa ente e sede vuoti; la scheda del file li lascia modificare, ma l'elaborazione non li usa. La stessa scheda elenca un campo `ID_ORARIO_FILE` che la tabella non ha | Ente e sede del file sono solo un'annotazione; lo spostamento dei file da una sede all'altra (ticket 261) non cambia nulla nel calendario |
| DIV-IMP-8 | Nei precaricamenti l'aggiornamento finale delle righe ha la condizione `OMNIATIME_PRECARICAMENTI.ID_OMNIATIME_FILE = OMNIATIME_PRECARICAMENTI.ID_OMNIATIME_FILE`, sempre vera: lo stesso difetto corretto nelle timbrature col ticket 290 | Elaborando un file di precaricamenti si agganciano alla presenza, o si segnano con `S`, righe di altri file con lo stesso dipendente, giorno e orario |
| DIV-IMP-9 | Nella normalizzazione la fascia del pomeriggio scatta solo se l'entrata è prima dell'inizio del pomeriggio e non prima della **fine del pomeriggio** (`ORARIO_ORA_FINE_2`): il commento dice "test su ora fine mattino" | Con un orario pomeridiano completo, un'entrata anticipata nel pomeriggio non viene mai riportata all'inizio della fascia |
| DIV-IMP-10 | `PERSONALE_ORARIO_GET` prende, fra gli orari con fine validità successiva alla data, quello con la fine più lontana, non quello in vigore alla data (ticket 290, non corretto) | Con due orari nel tempo, timbrature singole e normalizzazione usano l'orario futuro. In CAPAC oggi nessuno ha più di un orario |
| DIV-IMP-11 | La creazione della presenza intercetta qualunque errore e lo registra come `S` "Sovrapposizione presenze personale": anche un rilevamento ore in sovrapposizione (GESTY-IMP-028) o un rilevatore che non è un dipendente (`FK_PERSONALE_PRESENZE_RILEVATOR`). La cancellazione delle presenze vecchie, all'inizio della rielaborazione, invece non intercetta nulla | Il codice indica una causa che può non essere quella vera; lo stesso conflitto alla prima elaborazione segna la riga, alla seconda blocca l'intero file (ticket 28) |
| DIV-IMP-12 | Una presenza già esistente con lo stesso tipo e orario si riusa anche se l'ha generata un altro file; all'inizio della rielaborazione le presenze del file si scollegano da tutte le righe che le usano, di qualunque file, e si cancellano | Rielaborando un file si tolgono le presenze anche alle righe di un altro file che le condivideva, finché anche quello non si rielabora |
| DIV-IMP-13 | `OMNIATIME_FILES_ELABORA` accende all'inizio la sospensione dei controlli di `ORE_RILEVATE_AIU0` (`CONST_FLAGS.ELABORAZIONE_PRESENZE`) e alla fine la imposta di nuovo a vero invece di spegnerla | La sospensione dura fino alla fine della transazione; oggi il programma la chiude subito, ma un chiamante che proseguisse nella stessa transazione salterebbe il tetto delle ore dell'incarico (GESTY-RIL-015) |
| DIV-IMP-14 | Nella timbratura singola il verso letto dal file si sovrascrive con `E`, e le righe aggiunte da Gesty si ricreano a ogni rielaborazione (ticket 290, limite noto) | Se un dipendente passa alla timbratura doppia, i suoi file già elaborati vanno reimportati; le ore a mano scritte su una riga aggiunta si perdono alla rielaborazione (da verificare sul banco) |
| DIV-IMP-15 | Una coppia entrata-uscita che dopo l'arrotondamento ha l'uscita non successiva all'entrata (E 08:10 e U 08:14, entrambe 08:00) non riceve orario rilevato né codice | La riga resta "da verificare" senza un motivo leggibile |
| DIV-IMP-16 | L'elaborazione dei precaricamenti non controlla che l'utente sia collegato a una risorsa, a differenza delle timbrature; smart working in giorno di riposo (`SG`) diventa presenza "Altro", non smart working | Senza risorsa collegata ogni riga finisce in `S` senza spiegazione; lo smart working in giorno di riposo non si distingue nelle presenze. Da confermare con l'utente se la seconda è voluta |
| DIV-IMP-17 | Il ticket 72 descrive `TMP_ORARIO` come tabella condivisa con `ID_SESSIONE` obbligatorio senza valore predefinito, e propone di togliere l'obbligo nel programma. Oggi è una tabella temporanea della connessione con valore predefinito -1, la correzione proposta non c'è e il programma scrive la sessione alla creazione della riga; la vista del dizionario resta senza filtro di sessione, che non serve più | Il difetto del ticket probabilmente non si presenta più, ma va riprovato sul banco (Inserisci nella griglia "Ore Lezione") |

<!-- footer -->
---

[www.zebro.it/gesty](https://www.zebro.it/gesty)
<!-- /footer -->
