---
area: Tirocini
progetto: Gesty
aggiornato: 2026-10-30
rilascio: OUT/20261030-specifiche-vive-dei-progetti/010
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

# Tirocini

Questa specifica descrive le regole che Gesty rispetta quando si inseriscono e modificano i tirocini (tabella `STUDENTI_TIROCINI`, vista `STUDENTI_TIROCINI_ELENCO`), i loro periodi di proroga, sospensione e interruzione, il calendario (`STUDENTI_TIROCINI_CALEND_STAGE`), le presenze (`STUDENTI_PRESENZE_TIROCINIO`) e le indennità mensili (`STUDENTI_TIROCINI_INDENNITA`). Descrive il comportamento atteso, non il codice. Le regole stanno quasi tutte nel database: trigger `STUDENTI_TIROCINI_ELENCO_BIUD0`, `STUDENTI_TIROCINI_BIU1`, `STUDENTI_TIROCINI_AU0`, `STUDENTI_TIROCINI_BD0`, `STUDENTI_TIROCINI_CAL_STAG_BIU0`, `STUDENTI_PRESENZE_TIROCIN_BIU0`, `STUDENTI_TIRO_PRES_CHECK_SOVRAP`, `STUDENTI_TIROCINI_PERIODI_AIUD0`, `STUDENTI_TIROC_ELENCO_IND_BIUD0`; procedure `STUDENTI_TIROCINI_GENERA_CALEND`, `STUDENTI_TIROCINI_GENERA_PRESEN`, `STUDENTI_TIROCINI_DIFFERENZE_PRESEN`, `STUDENTI_TIROCINI_AGGIORNA_DATE`, `STUDENTI_TIROCINI_INDEN_ELABORA`, `STUDENTI_TIROCINI_INDENNITA_DETAIL`, `STUDENTI_TIROCINI_PRIMO_GG_SCAD`; funzione `STUDENTI_TIROCINI_GET_STATO`. Il resto sta nel modulo dati `dmTirocini.pas` (comandi della sezione Tirocini) e nel dialogo `frmGeneraCalendarioStage.pas`.

**Fuori da quest'area**, con una specifica propria quando un lavoro le toccherà: blocco del registro e trasmissione a SIUF delle presenze (qui solo il cenno di GESTY-TIR-020), esportazioni GRS e Futura, stampe (registro stage, progetto formativo, convenzione), area web dello stage, prestazioni dell'elenco dei tirocini (ticket 137). Il rilevamento delle ore dei docenti è descritto in `Rilevamento ore.md`: i tirocini non generano rilevamenti, e le regole GESTY-RIL-NNN non si applicano alle presenze di tirocinio.

**Origine.** Ricavata il 2026-10-30 dal database master `GESTY` (fotografia dei metadati e catalogo vivo dello stesso giorno), dai sorgenti in `SRC\Gesty_Group\_Sorgenti` e dal dizionario LZ in `SRC\Gesty_Group\LZ`, e dalle preanalisi dei ticket 34, 48, 51, 62, 64, 96, 116, 126, 137, 153, 179, 223, 229, 251. Dove una regola viene solo da un ticket e non è stata riletta sul codice, il requisito cita il ticket.

## GESTY-TIR-001 Dati obbligatori e legami del tirocinio
Un tirocinio appartiene a uno studente e a un progetto, e indica sempre tutor del progetto, azienda ospitante, sede operativa, tutor aziendale, data di inizio e data di fine. Sede operativa, tutor aziendale e convenzione devono appartenere all'azienda ospitante scelta; la convenzione deve essere anche dello stesso ente; l'ambito di inserimento e la mansione devono essere previsti per quella sede. La convenzione, l'ambito e la mansione sono facoltativi.

### Scenario: tutor di un'altra azienda
- **Dato** un tirocinio presso l'azienda A
- **Quando** si sceglie come tutor aziendale un tutor dell'azienda B
- **Allora** il salvataggio si ferma per violazione del legame fra azienda e tutor (`FK_STUDENTI_TIROCINI_AZIENDE_TU`)

### Scenario: sede operativa mancante
- **Dato** un tirocinio nuovo
- **Quando** si salva senza sede operativa
- **Allora** il salvataggio si ferma: il campo è obbligatorio

## GESTY-TIR-002 Valori predefiniti del tirocinio nuovo
Un tirocinio nuovo nasce curriculare (`TIPO_TIROCINIO = 'C'`), con durata in ore 0, al massimo 8 ore al giorno e 36 alla settimana, indennità mensile 0, senza buono pasto, e con i cinque documenti (convenzione, progetto formativo, registro stage, dossier individuale, lista delle attività) "non consegnati" (`'R'`). Tutti questi campi sono obbligatori: se chi scrive non li valorizza, valgono i predefiniti. Vedi DIV-TIR-6 per il caso in cui il programma li manda vuoti.

### Scenario: inserimento senza le ore massime
- **Dato** la scheda "Tirocinio" in cui l'operatore compila studente, azienda, sede, tutor e date
- **Quando** salva senza indicare le ore massime giornaliere
- **Allora** il tirocinio si salva con `MAX_ORE_GIORNALIERE = 8` e `MAX_ORE_SETTIMANALE = 36`

## GESTY-TIR-003 Ore massime giornaliere e settimanali
`MAX_ORE_GIORNALIERE` e `MAX_ORE_SETTIMANALE` sono dati del progetto formativo del tirocinio: si conservano, si mostrano e si passano all'area web dello stage (`WEB_STAGE_ELENCO_TIROCINI`). **Non limitano** il calendario né le presenze: un giorno di calendario o di presenze può superarle senza che il programma lo segnali (DIV-TIR-5 per i due campi).

**Controllo delle 40 ore settimanali (Mantis #344).** Indipendente dai due campi sopra, la procedura selezionabile `STUDENTI_TIROCINI_ORE_OLTRE_TETTO(DAL_GIORNO, AL_GIORNO, FILTRO_ID_STUDENTE, TETTO_ORE)` somma, per ogni allievo e per ogni settimana da lunedì a domenica, le ore di **presenza** (`ORE_PRESENZA`: presente e da calcolare; le assenze, giustificate o no, non contano) di **tutti i suoi tirocini**, e restituisce le settimane che superano il tetto (40 ore se `TETTO_ORE` è vuoto). Il periodo chiesto si allarga alle settimane intere che tocca. È una **segnalazione, non un blocco**: le presenze restano scritte. La usano due punti: a fine "Genera Presenze" (`TTirocini.SegnalaSettimaneOltreTetto`) un avviso elenca le settimane oltre il tetto dell'allievo del tirocinio, e la voce Controlli "Settimane Oltre Il Tetto" del modulo Tirocini elenca tutti gli allievi, con filtro per anno e mese (del lunedì).

### Scenario: giornata più lunga del massimo
- **Dato** un tirocinio con al massimo 8 ore al giorno
- **Quando** il calendario prevede per un giorno tre fasce per 9 ore complessive
- **Allora** il calendario si salva e le presenze generate contano 9 ore

### Scenario: settimana di 40 ore
- **Dato** un allievo con presenze di 8 ore da lunedì a venerdì
- **Quando** si cercano le settimane oltre il tetto
- **Allora** la settimana non compare

### Scenario: settimana di 41 ore
- **Dato** lo stesso allievo con un'ora in più il sabato
- **Quando** si cercano le settimane oltre il tetto, anche solo per il sabato
- **Allora** compare una riga dal lunedì alla domenica con 41 ore e 1 ora in eccesso

### Scenario: avviso a fine generazione
- **Dato** un allievo le cui presenze generate portano una settimana oltre 40 ore
- **Quando** si preme "Genera Presenze" e la generazione finisce
- **Allora** compare un avviso con il nominativo, le settimane e le ore, e le presenze restano scritte

## GESTY-TIR-004 Stato del tirocinio
Lo stato non si scrive: si calcola ogni volta da date e periodi (`STUDENTI_TIROCINI_GET_STATO`). Prima della data di inizio il tirocinio è programmato (`P`), fra inizio e fine è attivo (`A`), dopo la fine è chiuso (`C`). Mentre è attivo, se oggi cade in un periodo di sospensione è sospeso (`S`), se cade in un periodo di interruzione è interrotto (`I`).

### Scenario: sospensione in corso
- **Dato** un tirocinio dal 01/03 al 31/12 con una sospensione dal 01/08 al 31/08
- **Quando** si apre l'elenco dei tirocini il 10/08
- **Allora** lo stato del tirocinio è "sospeso"

## GESTY-TIR-005 Periodi di proroga, sospensione e interruzione
Ogni periodo ha un tipo (proroga `P`, sospensione `S`, interruzione `I`) e una data di inizio non successiva alla data di fine. Un periodo nuovo propone come inizio il giorno dopo la fine del tirocinio. Dopo ogni inserimento, modifica o cancellazione di un periodo, la data di fine del tirocinio diventa la fine più lontana fra le proroghe e le interruzioni; le sospensioni non la spostano. Se non restano proroghe né interruzioni la data di fine resta quella che c'era.

### Scenario: proroga
- **Dato** un tirocinio che finisce il 30/06
- **Quando** si inserisce una proroga dal 01/07 al 31/07
- **Allora** la data di fine del tirocinio diventa 31/07 e la scheda la mostra subito

### Scenario: proroga cancellata
- **Dato** lo stesso tirocinio, prorogato al 31/07, senza altri periodi
- **Quando** si cancella la proroga
- **Allora** la data di fine resta 31/07 (punto da confermare sul banco: vedi i punti dubbi)

## GESTY-TIR-006 Iscrizione al progetto collegata al tirocinio
Il tirocinio si collega a una precisa iscrizione dello studente al progetto (`ID_STUDENTE_PROGETTO`). Se nessuno la indica, o se quella indicata non è più dello stesso studente e progetto, il programma sceglie da solo: prima un'iscrizione con il settore aziendale valorizzato, poi la più vecchia. Se lo studente non è iscritto al progetto, il tirocinio si salva senza iscrizione. Un'iscrizione creata dopo collega i tirocini dello stesso studente e progetto rimasti senza. Un'iscrizione con un tirocinio collegato non si cancella. Grazie al collegamento, l'elenco dei tirocini ha una sola riga per tirocinio anche quando lo studente ha più iscrizioni allo stesso progetto (ticket 229).

### Scenario: studente con due iscrizioni allo stesso progetto
- **Dato** uno studente con due iscrizioni al progetto, una sola con il settore aziendale
- **Quando** si inserisce un tirocinio senza indicare l'iscrizione
- **Allora** il tirocinio si collega all'iscrizione con il settore
- **E** l'elenco dei tirocini mostra una riga sola, e la modifica della scheda si salva senza l'errore "updated [0] instead of [1] record"

### Scenario: iscrizione di un altro studente
- **Dato** un tirocinio dello studente A
- **Quando** si indica un'iscrizione dello studente B
- **Allora** il salvataggio si ferma per violazione del legame con l'iscrizione (`FK_STUDENTI_TIROCINI_ISCRIZIONE`)

### Scenario: cancellazione dell'iscrizione
- **Dato** un'iscrizione con un tirocinio collegato
- **Quando** la si cancella
- **Allora** l'operazione si ferma con "A questa iscrizione e' collegato un tirocinio: impossibile eliminarla. Eliminare il tirocinio o collegarlo a un'altra iscrizione dello studente."

## GESTY-TIR-007 Aggiornamento del tirocinio dalla scheda
La scheda scrive il tirocinio attraverso la vista `STUDENTI_TIROCINI_ELENCO`: ogni salvataggio riscrive tutti i campi del tirocinio con i valori della scheda. Numero e protocollo della convenzione presso la Regione si mostrano sul tirocinio ma sono dati della convenzione: si scrivono sulla convenzione, all'inserimento solo se valorizzati, in modifica solo il campo che l'operatore ha cambiato.

### Scenario: cambio di convenzione
- **Dato** un tirocinio con la convenzione C1, che ha un numero regionale
- **Quando** si sceglie la convenzione C2 senza toccare il numero regionale
- **Allora** il numero di C1 non viene scritto su C2

## GESTY-TIR-008 Azienda ospitante
Un'azienda ospitante creata dalla sezione Tirocini (procedura guidata "Nuova azienda ospitante") nasce già fornitrice di servizi. Le aziende già presenti non si riattivano con la richiesta di attivazione risorsa, che rifiuta i codici fiscali già registrati: per usarle come fornitrici si completa la loro scheda e si crea l'inquadramento, senza il quale un incarico non si salva (ticket 223; l'incarico è fuori da quest'area).

### Scenario: nuova azienda ospitante
- **Dato** l'inserimento di un tirocinio
- **Quando** si crea l'azienda ospitante con la procedura guidata
- **Allora** l'azienda ha "Fornitrice Servizi" spuntato

## GESTY-TIR-009 Generazione del calendario
Il calendario ha una riga per ogni giorno, attivo o no. Il dialogo "Genera calendario" propone le date del tirocinio e rifiuta date mancanti o inizio dopo la fine. La generazione non esce mai dalle date del tirocinio: un intervallo più largo viene ristretto (correzione del ticket 34). Prima cancella le righe dell'intervallo, poi le riscrive; le righe fuori dall'intervallo restano. Un giorno è attivo se è uno dei giorni della settimana scelti, non cade in una sospensione e non è un giorno di chiusura della sede del progetto (salvo le chiusure che ammettono la prenotazione delle aule). Gli orari si scrivono solo sui giorni attivi e solo se si chiede di generarli. Ogni riga prende materia e contenuti predefiniti del tirocinio (i contenuti del giorno, se indicati, hanno la precedenza) e la tipologia tirocinio: `2`, oppure `30` sui progetti ITS/IFTS.

### Scenario: data di fine digitata male
- **Dato** un tirocinio dal 08/04/2026 al 31/07/2026
- **Quando** si genera il calendario indicando come fine il 30/06/2029
- **Allora** il calendario arriva al 31/07/2026

### Scenario: giorno di chiusura della sede
- **Dato** un giorno di chiusura della sede del progetto senza prenotazione delle aule
- **Quando** si genera il calendario su un intervallo che lo contiene
- **Allora** quel giorno c'è nel calendario ma non è attivo e non ha orari

## GESTY-TIR-010 Fasce orarie del calendario
Ogni giorno ha fino a tre fasce. In ogni fascia l'inizio precede la fine; le fasce sono in ordine e non si toccano: la seconda comincia dopo la fine della prima, la terza dopo la fine della seconda. Un orario `00:00` vale come fascia vuota. Ogni fascia con orario ha uno stato di presenza, "presente" se non indicato; un giorno non attivo, o una fascia senza orario, non ha stato.

### Scenario: fasce contigue
- **Dato** un giorno con la prima fascia 09:00-13:00
- **Quando** si indica la seconda fascia 13:00-17:00
- **Allora** il salvataggio si ferma: la seconda fascia deve cominciare dopo le 13:00 (nel dialogo: "data 1 fine maggiore di data 2 inizio.")

## GESTY-TIR-011 Ore previste
Le ore previste del tirocinio sono la somma delle ore dei giorni attivi del calendario, meno le ore di malattia e di chiusura aziendale indicate sulle indennità, mai sotto zero. Le ore previste di un mese, nell'elenco delle indennità, si calcolano allo stesso modo sui soli giorni del mese. Vedi DIV-TIR-4.

### Scenario: mese con malattia
- **Dato** un mese con 92 ore di calendario attivo e 8 ore di malattia sull'indennità
- **Quando** si apre l'elenco delle indennità del mese
- **Allora** le ore previste sono 84

## GESTY-TIR-012 Generazione delle presenze
"Genera Presenze" lavora sulla settimana visualizzata nella rendicontazione (da lunedì a domenica) e, dopo la conferma ("eventuali rilevamenti preesistenti verranno sovrascritti"), allinea le presenze al calendario solo nei giorni che stanno entro le date del tirocinio. Confronta fascia per fascia, con chiave data e ora di inizio: cancella le presenze che il calendario non prevede più, aggiorna quelle in cui tipologia, durata, stato, materia o contenuti sono diversi, inserisce quelle mancanti; le fasce identiche non si riscrivono. Le presenze conservate tengono identificativo, validazione, autorizzazione del tutor aziendale e l'indicazione "da calcolare" (ticket 251). Uno stato o una durata corretti a mano su una presenza vengono riportati a quelli del calendario.

### Scenario: rigenerazione a calendario invariato
- **Dato** una settimana con presenze già generate e calendario non cambiato
- **Quando** si preme "Genera Presenze"
- **Allora** nessuna presenza viene scritta, e quelle validate restano validate

### Scenario: assenza registrata a mano
- **Dato** una presenza del martedì segnata assente a mano, con il calendario che per quel giorno dice "presente"
- **Quando** si rigenerano le presenze della settimana
- **Allora** la presenza torna "presente"

### Scenario: fascia tolta dal calendario
- **Dato** una presenza del pomeriggio del 29/09
- **Quando** il pomeriggio viene tolto dal calendario e si rigenera
- **Allora** la presenza del pomeriggio viene cancellata

## GESTY-TIR-013 Presenze in giorni non ancora trascorsi
Una presenza di tirocinio non può avere una data successiva a oggi (`CHK1_STUDENTI_PRESENZE_TIROCIN`), né in inserimento né in modifica. Il ticket 48 chiede invece di poter chiudere la rendicontazione del mese prima che finisca, per anticipare il pagamento delle indennità: la generazione oggi prova a scrivere anche i giorni futuri e la regola la ferma (DIV-TIR-1).

### Scenario: settimana in corso
- **Dato** oggi lunedì 27/07 e un calendario attivo da lunedì a venerdì
- **Quando** si generano le presenze della settimana 27/07-02/08
- **Allora** la generazione si ferma con "Studenti Presenze Tirocinio: violazione della regola: CHECK(DATA_LEZIONE <= CURRENT_DATE" e nessuna presenza della settimana cambia

## GESTY-TIR-014 Controlli sulla singola presenza
Ogni presenza, generata o scritta a mano, rispetta queste regole:
- la data sta entro le date del tirocinio ("Data lezione non compatibile con il periodo di tirocinio.");
- la data non cade in una sospensione o interruzione ("Il tirocinio risulta sospeso alla data indicata.", "... interrotto ...");
- due presenze dello stesso tirocinio nello stesso giorno non si sovrappongono ("Presenze tirocinio: sovrapposizione ora inizio/fine.");
- la durata è maggiore di zero e al massimo 720 minuti;
- la tipologia è tirocinio (`2`), tirocinio in presenza (`30`) o in smart working (`31`);
- una presenza "presente" e da calcolare non si sovrappone alle altre presenze dello stesso studente (aula, individuali e le altre), con il controllo comune `STUDENTI_PRESENZE_CHECK_SOVRAPP`.

Nella griglia della rendicontazione un giorno non attivo del calendario non si modifica.

### Scenario: presenza durante una sospensione
- **Dato** una sospensione dal 01/08 al 31/08
- **Quando** si inserisce una presenza del 10/08
- **Allora** il salvataggio si ferma con "Il tirocinio risulta sospeso alla data indicata."

### Scenario: stage sovrapposto a una lezione d'aula
- **Dato** uno studente presente in aula il 15/10 dalle 09:00 alle 13:00
- **Quando** gli si registra una presenza di stage "presente" il 15/10 dalle 11:00 alle 15:00
- **Allora** il salvataggio si ferma per sovrapposizione delle presenze dello studente

## GESTY-TIR-015 Ore effettive e ore a zero
Le ore effettive di un tirocinio sono la somma delle presenze "presente" e da calcolare; le assenze e le presenze escluse dal calcolo valgono zero. Le ore residue sono la durata in ore del tirocinio meno le ore effettive, mai sotto zero. Le ore di stage esistono solo come presenze di un tirocinio: un corso senza tirocini ha zero ore di tirocinio anche se l'orario del progetto contiene ore di stage caricate come lezioni d'aula (ticket 64).

### Scenario: presenza esclusa dal calcolo
- **Dato** una presenza di 4 ore "presente" con "Calcolare" tolto
- **Quando** si legge il totale delle ore effettive
- **Allora** quella presenza conta zero ore

### Scenario: stage caricato come aula
- **Dato** un corso senza tirocini, con l'orario pieno di lezioni d'aula
- **Quando** si filtra l'elenco presenze del corso per tipo presenza "tirocinio"
- **Allora** l'elenco è vuoto

## GESTY-TIR-016 Primo giorno da rendicontare
Il comando che porta la rendicontazione al primo giorno non rilevato sceglie il primo giorno del tirocinio presente nel calendario e senza presenze. Se non ne trova, avvisa "Non risultano date non rilevate per il tirocinio." (DIV-TIR-8).

### Scenario: rendicontazione ferma a metà mese
- **Dato** un tirocinio con presenze fino a venerdì 12/09 e calendario attivo dal lunedì al venerdì
- **Quando** si chiede il primo giorno non rilevato
- **Allora** la rendicontazione si posiziona sulla settimana che contiene il primo giorno successivo senza presenze

## GESTY-TIR-017 Elaborazione delle indennità del mese
Le indennità riguardano solo i tirocini extracurricolari (`X`) e di inclusione (`I`). "Elabora" sul mese scelto (in apertura il mese precedente a oggi) crea una riga per ogni tirocinio che tocca il mese e non è sospeso per tutto il mese, se la riga non c'è già. La riga nuova copia dal tirocinio fonte di finanziamento, indennità mensile e tipo di pagamento predefinito, prende il conto corrente non chiuso più recente dello studente, e nasce con giorni di presenza e importo a zero. Rielaborare un mese cancella e ricrea soltanto le righe ancora vuote (giorni e importo a zero) e senza data di pagamento; le righe valorizzate o pagate restano.

### Scenario: tirocinio curriculare
- **Dato** un tirocinio curriculare attivo a settembre
- **Quando** si elaborano le indennità di settembre
- **Allora** per quel tirocinio non nasce nessuna riga

### Scenario: mese interamente sospeso
- **Dato** un tirocinio extracurricolare sospeso dal 01/08 al 31/08
- **Quando** si elaborano le indennità di agosto
- **Allora** per quel tirocinio non nasce nessuna riga

### Scenario: rielaborazione con una riga pagata
- **Dato** una riga di luglio con importo zero ma data di pagamento indicata
- **Quando** si rielabora luglio
- **Allora** la riga resta com'era

## GESTY-TIR-018 Fonte di finanziamento e indennità mensile
Fonte di finanziamento e indennità mensile si copiano nella riga di indennità quando la riga nasce: così il mese pagato conserva la fonte con cui è stato pagato. Quando cambiano sul tirocinio, il nuovo valore arriva alle sole righe ancora vuote, non pagate e che avevano il valore vecchio; le righe con una fonte scelta a mano nella maschera "Indennità Mensili" restano com'erano (ticket 51). La fonte non ha una data di decorrenza.

### Scenario: cambio di fonte a metà anno
- **Dato** un tirocinio con fonte "PNRR", mesi da febbraio a giugno valorizzati e righe di settembre e ottobre già create ma vuote
- **Quando** la fonte del tirocinio diventa "fondo povertà"
- **Allora** settembre e ottobre passano a "fondo povertà", febbraio-giugno restano "PNRR"

### Scenario: fonte personalizzata su un mese
- **Dato** la riga di dicembre, vuota, con fonte "Comune di Limbiate" scelta a mano
- **Quando** cambia la fonte del tirocinio
- **Allora** la riga di dicembre resta "Comune di Limbiate"

## GESTY-TIR-019 Cancellazioni protette
Una riga di indennità con data di pagamento non si cancella dalla maschera ("Impossibile eliminare un'indennita' gia' pagata (Data pagamento non vuota)."). Un tirocinio non si cancella se ha indennità con importo diverso da zero ("Risultano pagamenti indennità effettuati per questo tirocinio,"), né se ha presenze. Cancellando un tirocinio senza importi e senza presenze se ne cancellano anche indennità, calendario e periodi.

### Scenario: tirocinio con presenze
- **Dato** un tirocinio con presenze registrate
- **Quando** lo si cancella
- **Allora** l'operazione si ferma per il legame con le presenze (`FK_STUDENTI_PRESENZE_TIR_ST_TIR`)

## GESTY-TIR-020 Presenze di stage già trasmesse a SIUF (cenno)
Inserire una presenza di tirocinio è sempre libero. Modificarla o cancellarla richiede l'autorizzazione `SIUF.ModificaPresenzeTrasmesse` quando un invio a SIUF riuscito per la sezione del progetto copre quel giorno e conteneva la tipologia della presenza (ticket 251). Per questo la generazione di GESTY-TIR-012 non riscrive le fasce invariate. Il dettaglio appartiene alla specifica del blocco del registro e della trasmissione a SIUF.

### Scenario: correzione di uno stage già inviato
- **Dato** un invio riuscito del 15/10 che conteneva lo stage, e un utente senza `SIUF.ModificaPresenzeTrasmesse`
- **Quando** l'utente cambia la durata di una presenza di stage del 15/10
- **Allora** il salvataggio si ferma con l'errore di autorizzazione

## Divergenze note

Punti in cui il codice di oggi non mantiene ciò che i requisiti dicono, o in cui due parti del codice applicano la stessa regola in modo diverso. Divergenze raccolte in R-181; con la correzione il requisito si aggiorna e questa sezione si accorcia.

| Codice | Divergenza | Conseguenza |
|---|---|---|
| DIV-TIR-1 | Il vincolo `CHK1_STUDENTI_PRESENZE_TIROCIN CHECK(DATA_LEZIONE <= CURRENT_DATE)` è ancora attivo sul master, mentre `STUDENTI_TIROCINI_DIFFERENZE_PRESEN` non filtra più i giorni futuri. Il commento in testa a `STUDENTI_TIROCINI_GENERA_PRESEN` dice che il taglio alla data odierna "diventa opzionale" (ticket 48), ma la procedura non ha il parametro `INCLUDI_GIORNI_FUTURI` | Ogni generazione su una settimana che contiene un giorno futuro attivo si ferma per intero, compresi i giorni già trascorsi; il mese in corso non si chiude in anticipo, che è l'esigenza del ticket 48. Il vincolo blocca anche la correzione di una presenza futura |
| DIV-TIR-2 | La generazione delle presenze ignora l'indicazione "attivo" del giorno di calendario: guarda solo se la fascia ha un orario. Il trigger del calendario, quando un giorno viene disattivato, svuota lo stato ma lascia gli orari, e la generazione ripiega su "presente" | Un giorno disattivato a mano con gli orari ancora scritti produce presenze "presente": le ore previste (GESTY-TIR-011) lo escludono, le ore effettive lo contano (già annotato nel ticket 251) |
| DIV-TIR-3 | Il calendario esclude dai giorni attivi solo le sospensioni (`TIPO_PERIODO = 'S'`), le presenze rifiutano sospensioni e interruzioni; anche l'elaborazione delle indennità esclude solo i mesi sospesi | Un'interruzione dentro un calendario già generato con orari fa fermare tutta la generazione della settimana con "Il tirocinio risulta interrotto alla data indicata."; l'indennità del mese interrotto nasce comunque |
| DIV-TIR-4 | Le ore previste (`CALENDARIO_TOTALI` nella vista `STUDENTI_TIROCINI_ELENCO`, `STUDENTI_TIROCINI_INDENNITA_DETAIL`) sommano tutte le righe del calendario, anche quelle fuori dalle date del tirocinio. La generazione del calendario ora resta entro le date ma non cancella le righe che stanno fuori | Le righe rimaste da un calendario generato male (ticket 34: 2027-2029) o da una data di fine anticipata gonfiano le ore previste e la percentuale di frequenza, e compaiono nelle estrazioni |
| DIV-TIR-5 | `MAX_ORE_GIORNALIERE` e `MAX_ORE_SETTIMANALE` non sono letti da nessun controllo: né nel database (unici usi: tabella, vista, trigger della vista, `WEB_STAGE_ELENCO_TIROCINI`) né nel codice Delphi | Il nome dei campi fa pensare a un tetto che il programma non applica; va deciso se il tetto serve (GESTY-TIR-003). Dal Mantis #344 le 40 ore settimanali per allievo sono controllate da `STUDENTI_TIROCINI_ORE_OLTRE_TETTO` con un tetto proprio (40), senza leggere questi due campi: restano da decidere per il singolo tirocinio |
| DIV-TIR-6 | Il trigger `STUDENTI_TIROCINI_ELENCO_BIUD0` passa alla tabella i campi con predefinito (`MAX_ORE_GIORNALIERE`, `MAX_ORE_SETTIMANALE`, documenti, `BUONO_PASTO`, ...) anche quando sono vuoti, quindi il predefinito della tabella non scatta mai: l'unica difesa è il programma, che rimette i predefiniti del dizionario LZ prima del nuovo record (correzione in `zFbDataSet.pas`, ticket 153). Nella scheda "Tirocinio" `MAX_ORE_GIORNALIERE` è ancora nascosto | Ogni scrittura sulla vista che non passi dal dataset di Gesty (importazioni, area web, procedure future) con quei campi vuoti fallisce con `validation error for column "STUDENTI_TIROCINI"."MAX_ORE_GIORNALIERE"` (ticket 62, 96, 116, 153); l'operatore non vede il valore che verrà salvato |
| DIV-TIR-7 | Su `STUDENTI_TIROCINI` nessun vincolo o trigger controlla che la data di inizio non sia successiva alla data di fine (i periodi invece lo controllano) | Un tirocinio con le date invertite si salva; il calendario generato e le presenze restano vuoti senza un messaggio. Da verificare se la scheda LZ lo impedisce |
| DIV-TIR-8 | `STUDENTI_TIROCINI_PRIMO_GG_SCAD` cerca il primo giorno del calendario senza presenze senza guardare se il giorno è attivo; il calendario ha una riga per ogni giorno | Il "primo giorno non rilevato" può essere un sabato o una domenica non lavorati, o un giorno di chiusura, già prima della vera lacuna |
| DIV-TIR-9 | In apertura il mese delle indennità è `MonthOf(Date) - 1` con l'anno corrente (`TTirocini.DataModuleCreate`) | A gennaio il mese proposto è 0, che il dominio `MESE` rifiuta, invece di dicembre dell'anno precedente. Da verificare sul banco che cosa mostra la maschera |
| DIV-TIR-10 | Il vincolo `CHK1_STUDENTI_TIROCINI_INDENNIT` ammette solo anni fino a quello corrente | A dicembre non si possono creare in anticipo le indennità di gennaio, mentre nello stesso anno l'elaborazione anticipata è ammessa e usata (ticket 51: settembre e ottobre elaborati a luglio) |
| DIV-TIR-11 | La vista `STUDENTI_TIROCINI_ELENCO_INDENN` mostra l'indennità mensile del tirocinio (valore vivo) accanto alla fonte della riga (valore congelato); il trigger della vista, inserendo una riga dalla maschera, non scrive l'indennità mensile, che resta 0 nella riga | Dopo un cambio di indennità mensile i mesi già pagati mostrano l'importo nuovo con la fonte vecchia (ticket 51, punto 2.2, ancora vero); il dettaglio dentro il tirocinio, che legge la tabella, mostra valori diversi per lo stesso mese |
| DIV-TIR-12 | La cancellazione di un'indennità è protetta sulla data di pagamento, quella del tirocinio sull'importo diverso da zero | Un tirocinio con una riga pagata a importo zero si cancella, e la riga con lui. Inoltre il messaggio di indennità pagata riporta l'identificativo da `NEW`, che in cancellazione è vuoto |

<!-- footer -->
---

[www.zebro.it/gesty](https://www.zebro.it/gesty)
<!-- /footer -->
