---
area: Trasmissione a SIUF
progetto: Gesty
aggiornato: 2026-10-30
rilascio: OUT/20261030-specifiche-vive-dei-progetti/013
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

# Trasmissione a SIUF

Questa specifica descrive le regole che Gesty rispetta quando trasmette a SIUF (Sistema Informativo Unitario della Formazione di Regione Lombardia) le presenze degli allievi per cooperazione applicativa, quando registra l'esito degli invii, quando protegge i periodi già trasmessi, quando importa il registro scaricato da SIUF e quando controlla ogni giorno importazioni e invii. Descrive il comportamento atteso, non il codice.

Le regole stanno in due posti. La scelta delle righe da trasmettere è nel database: procedure `GRS_EXPORT` e i suoi rami `GRS_EXPORT_AULE` → `GRS_EXPORT_COLLETTIVA`, `GRS_EXPORT_PIP`, `GRS_EXPORT_SOSTEGNO`, `GRS_EXPORT_TIROCINI_NON_ACCORP`, `GRS_EXPORT_FORMAZIONE_INTERNA`; funzioni `GRS_EXPORT_GET_CODICE_FISCALE_DOCENTE`, `GET_TIPOLOGIA_FORMAZIONE`, `SIUF_SEZIONE_GIA_TRASMESSA`, `SIUF_PRESENZA_GIA_TRASMESSA`; trigger `*_CHECK_SIUF` delle cinque tabelle di presenza, `PROGETTI_BIU0`, `SIUF_COOP_CONFIG_BI_ATTIVO`; procedure `SIUF_COOPERAZIONE_APPLICATIVA_CONFIG_GET`, `SIUF_COOPERAZIONE_APPLICATIVA_INVII_ADD`, `PROGETTI_GET_CANALE_SIUF`, `SIUF_MONITORAGGIO_*`. La costruzione e la spedizione del tracciato sono nell'applicazione: unit `SIUF.CooperazioneApplicativa.Builder`, `.Validator`, `.Client`, `.Types` e modulo dati `dmSIUF_CooperazioneApplicativa`, richiamati dalla sezione GRS (`dmGRS.pas`, `frmGRS.pas`).

**Fuori da quest'area**, con una specifica propria: le presenze degli allievi in sé (stati, minuti, registro, blocco del registro firmato, generazione delle presenze d'ufficio), nella bozza in corso *Presenze allievi e registro*. Qui compare solo ciò che decide se una presenza parte, come parte e quando non si può più toccare. Fuori anche le importazioni GRS da ClasseViva, Untis e OmniaTime (qui compare solo l'importazione del registro SIUF, che usa lo stesso percorso di elaborazione), il rilevamento ore dei docenti (`Rilevamento ore.md`) e l'esportazione in foglio elettronico verso il GRS. Le presenze di tirocinio già trasmesse sono già descritte in GESTY-TIR-020 di `Tirocini.md`: qui si richiama la regola, non si ripete.

**Origine.** Ricavata il 2026-10-30 dal database master `GESTY` (fotografia dei metadati dello stesso giorno), dai sorgenti in `SRC\Gesty_Group\_Sorgenti` e dal dizionario LZ in `SRC\Gesty_Group\LZ`, e dalle preanalisi dei ticket 56, 81, 93, 98, 100, 110, 126, 152, 179, 186, 189, 191, 228, 230, 251. Dove una regola viene solo da un ticket o dalla risposta di AT SIUF e non è verificabile sul codice, il requisito cita il ticket.

## GESTY-SIU-001 Chi invia e che cosa parte
Il comando "Invia SIUF" della sezione GRS è visibile e utilizzabile solo da chi ha l'autorizzazione "SIUF - Cooperazione Applicativa" (`Gesty_Authorizations.SIUF_COOPERAZIONE_APPLICATIVA`). Parte l'intero contenuto della vista su cui si preme il comando, nel periodo e con i filtri di progetto, corso e studente impostati: non le sole righe selezionate. Prima di partire Gesty chiede conferma indicando ambiente (Test o Produzione), ente e periodo "dal ... al ..." del filtro. Le viste da cui si invia sono "Export Completo" (`GRS.ExportGRS`, tutti i rami insieme) e le viste di aula, PIP e sostegno (ticket 251); il tirocinio parte solo da "Export Completo".

### Scenario: utente senza autorizzazione
- **Dato** un utente senza "SIUF - Cooperazione Applicativa"
- **Quando** cerca di inviare
- **Allora** il comando non è visibile; se richiamato, compare "Utente non autorizzato." e non parte nulla

### Scenario: vista vuota
- **Dato** un filtro che non restituisce righe
- **Quando** si preme "Invia SIUF"
- **Allora** compare "Nessuna presenza da inviare."

### Scenario: periodo nella conferma
- **Dato** il filtro dal 21/09/2026 al 23/09/2026
- **Quando** si preme "Invia SIUF"
- **Allora** la conferma riporta "Periodo dal 21/09/2026 al 23/09/2026" (ticket 56: prima mostrava due volte la data iniziale)

## GESTY-SIU-002 Configurazione dell'ente e utente che firma l'invio
Ogni ente ha la propria configurazione (`SIUF_COOPERAZIONE_APPLICATIVA_CONFIG`): indirizzo del servizio, identificativo ente, utenza e codice, ambiente di test o di produzione. È usata la configurazione attiva; attivarne una disattiva quella dell'altro ambiente. Ogni invio porta il codice fiscale dell'utente Gesty che lo lancia, letto dalla sua anagrafica: se manca o non è valido l'invio non parte. Gli enti che non hanno una configurazione attiva non possono inviare.

### Scenario: ente non configurato
- **Dato** un ente senza configurazione attiva
- **Quando** si invia
- **Allora** l'operazione si ferma con "Cooperazione Applicativa non configurata."

### Scenario: utente senza codice fiscale
- **Dato** un utente la cui anagrafica non ha codice fiscale
- **Quando** si invia
- **Allora** l'operazione si ferma con "Codice Fiscale utente corrente non trovato."

### Scenario: passaggio da test a produzione
- **Dato** un ente con la configurazione di test attiva
- **Quando** si attiva la configurazione di produzione
- **Allora** quella di test risulta disattivata

## GESTY-SIU-003 Canale della sezione
Ogni progetto trasmesso a SIUF appartiene a un canale (`PROGETTI.CANALE_SIUF`): ordinamentale (`ORD`: IeFP, IFTS, ITS, apprendistato) o Extra Obbligo (`EOB`). Su un progetto GRS senza canale Gesty lo propone dall'area di riferimento: `IeFP 2° ciclo`, `Superiore` e `Apprendistato` diventano `ORD`, tutte le altre `EOB`; il valore resta correggibile a mano finché la sezione non ha invii riusciti. Un progetto senza canale viene trasmesso come Extra Obbligo. Il canale decide codifica della tipologia (GESTY-SIU-009), campi del tracciato (sede e chiusure solo sull'ordinamentale), trattamento delle assenze giustificate (GESTY-SIU-008) e ricomposizione delle ore (GESTY-SIU-007); indirizzo e credenziali sono gli stessi per i due canali. Il flag ITS/IFTS del progetto arriva al tracciato ma oggi non cambia nulla (ticket 186).

### Scenario: canale proposto
- **Dato** un progetto GRS con area `Superiore` e canale vuoto
- **Quando** si salva
- **Allora** il canale diventa `ORD`

### Scenario: canale di una sezione già trasmessa
- **Dato** un progetto con canale `EOB` e almeno un invio riuscito per la sua sezione
- **Quando** si cambia il canale in `ORD`
- **Allora** il salvataggio si ferma con "Impossibile cambiare il canale SIUF: la sezione ha già invii riusciti a portale."

## GESTY-SIU-004 Sezione a cui va ogni riga
Ogni riga trasmessa indica la sezione SIUF (`RIF_EVENTO_FORMATIVO`, nel tracciato `idSezione`): di norma il codice regionale del progetto (`PROGETTI.CODICE_REGIONALE`). Per la lezione collettiva dei progetti di apprendistato e per il sostegno vale invece il riferimento del piano formativo dell'iscrizione dello studente (`STUDENTI_PROGETTI.IDENTIF_PIANO_FORMATIVO`), se c'è. Per il sostegno, un'ora senza corso prende l'iscrizione dello studente al progetto qualunque sia il corso (ticket 191). La sezione deve essere un numero: una riga senza sezione valida ferma l'intero invio prima di contattare SIUF.

### Scenario: ora di sostegno senza corso
- **Dato** un'ora di sostegno senza corso, su un progetto senza codice regionale, e uno studente iscritto a un corso con piano formativo 195280
- **Quando** si invia
- **Allora** la riga va alla sezione 195280

### Scenario: sezione mancante
- **Dato** una riga senza sezione
- **Quando** si invia
- **Allora** non parte nulla e compare "Id Sezione non valida: " (il messaggio non dice quale riga)

## GESTY-SIU-005 Quali presenze entrano nel tracciato
Entrano solo le presenze di progetti con GRS attivo (`PROGETTI.GRS`) dell'ente indicato, nel periodo scelto, e solo quelle da calcolare (`CALCOLARE` vero su ogni tabella di presenza: è il modo di escludere un singolo allievo da una singola lezione, ticket 179). In più, per ogni ramo:
- **Aula** (`STUDENTI_PRESENZE_COLLETTIVA`): solo le ore di lezioni svolte (`ORARIO.LEZIONE_SVOLTA`), e solo le presenze che producono ore di presenza o di assenza: ora buca (`B`) e attività individuale (`I`) restano fuori. L'attività individuale parte dal ramo PIP.
- **PIP** (`STUDENTI_PRESENZE_INDIVIDUALE`), **sostegno**, **tirocinio non accorpato**: tutte le righe da calcolare.
- **Formazione interna**: solo le righe da calcolare e valide (`VALIDO`).

Cosa siano stato, minuti e "da calcolare" di una presenza lo descrive la specifica delle presenze degli allievi.

### Scenario: lezione annullata
- **Dato** un'ora 09:00-10:00 segnata "non svolta", con le presenze degli allievi rimaste `P`
- **Quando** si invia il giorno
- **Allora** quell'ora non compare nel tracciato (ticket 230: prima partiva come ora di presenza, senza docente e senza materia)

### Scenario: allievo escluso dall'invio
- **Dato** una presenza con "Calcolare" tolto
- **Quando** si invia la lezione
- **Allora** quell'allievo non compare nel tracciato per quella lezione; gli altri sì

## GESTY-SIU-006 Righe da un'ora
Ogni riga del tracciato copre al massimo un'ora: le fasce più lunghe (tipicamente tirocinio, PIP, sostegno) vengono spezzate in ore a partire dall'ora d'inizio, e l'ultima porzione può essere più corta. Le lezioni d'aula sono già registrate ora per ora. Le ore di presenza, assenza e assenza giustificata di ogni riga sono calcolate sulla sua durata.

### Scenario: tirocinio di quattro ore
- **Dato** una presenza di tirocinio dalle 09:00 alle 13:00
- **Quando** si costruisce il tracciato
- **Allora** nascono quattro righe da un'ora prima della ricomposizione di GESTY-SIU-007

## GESTY-SIU-007 Ricomposizione della lezione secondo il canale
I due canali vogliono forme opposte (ticket 93, 152):
- **Extra Obbligo**: SIUF cerca la lezione per data, ora d'inizio e ora di fine esatte. Le ore adiacenti dello stesso studente vengono fuse in una riga sola se coincidono giorno, progetto, sezione, tipologia, docente, codocente, materia e contenuti (questi ultimi senza distinzione di maiuscole), e la seconda comincia esattamente dove finisce la prima. Presenza, assenza e assenza giustificata si sommano in minuti, così la somma resta uguale alla durata.
- **Ordinamentale**: nessuna fusione, una riga per ogni ora.

Un'ora mancante in mezzo (lezione annullata, pausa) tiene separate le due fasce.

### Scenario: lezione serale di due ore, Extra Obbligo
- **Dato** due ore 20:00-21:00 e 21:00-22:00 con stesso docente, materia e contenuti
- **Quando** si invia
- **Allora** per ogni studente parte una riga 20:00-22:00

### Scenario: stessa lezione, ordinamentale
- **Dato** la stessa coppia di ore su un progetto `ORD`
- **Quando** si invia
- **Allora** partono due righe da 60 minuti

### Scenario: ora annullata in mezzo
- **Dato** tre ore 10:00-13:00 su un progetto `EOB` con l'ora 11:00-12:00 non svolta
- **Quando** si invia
- **Allora** partono le fasce 10:00-11:00 e 12:00-13:00

## GESTY-SIU-008 Ore nel tracciato
Le ore si scrivono come intero quando i minuti sono zero (`"1"`, `"0"`) e come ore.minuti, non decimali, altrimenti (`"1.45"`, `"0.30"`), su tutti i canali (ticket 186, risposta scritta di AT SIUF del 28/09/2026). Presenza, assenza e assenza giustificata di una riga sommano esattamente la sua durata. Le assenze giustificate seguono il canale:
- **Extra Obbligo**: confluiscono nell'assenza, e il campo dell'assenza giustificata vale sempre `"0"`;
- **Ordinamentale**, ITS e IFTS compresi: restano separate e reali (ticket 186, risposta di AT SIUF del 30/09/2026).

### Scenario: assenza giustificata su Extra Obbligo
- **Dato** uno studente assente giustificato un'ora su un progetto `EOB`
- **Quando** si invia
- **Allora** la riga ha `oreAssenza = "1"` e `oreAssenzaGiustificata = "0"`

### Scenario: minuti che non tornano
- **Dato** una riga di 120 minuti con 60 minuti assegnati
- **Quando** si invia
- **Allora** l'invio di quel blocco si ferma prima di partire con "... non corrispondono i minuti assegnati per presenza, assenza e assenza giustificata (durata 120 min, assegnati 60 min)"

## GESTY-SIU-009 Tipologia della lezione
La tipologia trasmessa dipende dal canale.
- **Extra Obbligo**: solo quattro valori (1 Aula, 2 Stage, 3 Esercitazione, 4 FAD). Collettiva e aula in presenza (1, 29) vanno in Aula; tirocinio, alternanza scuola-lavoro protetta, tirocinio in presenza e in smart working (2, 16, 30, 31) in Stage; le FAD (9, 12, 13, 18) in FAD; `ES` "Esercitazione Extra Obbligo" in Esercitazione (ticket 126). Ogni altro codice non ha corrispondenza.
- **Ordinamentale**: il codice di Gesty si trasmette com'è, perché coincide con la tabella del canale; non sono ammessi `ES`, 6, 9 e i codici fuori da 1-34.

Un codice senza corrispondenza ferma l'invio del blocco prima di partire, indicando riga, studente, data e codice interno: non viene mai ricondotto d'ufficio all'aula (ticket 93). Sui progetti ITS/IFTS la tipologia della lezione d'aula si ricalcola al momento dell'invio (1 → 29, 2 → 30 o 31, 13 → 28); una tipologia forzata sulla singola presenza prevale.

### Scenario: formazione esterna su Extra Obbligo
- **Dato** una lezione con tipologia 5 "Formazione esterna" su un progetto `EOB`
- **Quando** si invia
- **Allora** il blocco si ferma con "... la tipologia di lezione 5 (codice interno) ... non ha una corrispondenza fra quelle ammesse dal canale Extra Obbligo (1 Aula, 2 Stage, 3 Esercitazione, 4 FAD)..."

### Scenario: Esercitazione su ordinamentale
- **Dato** una lezione `ES` su un progetto `ORD`
- **Quando** si invia
- **Allora** il blocco si ferma: `ES` esiste solo sull'Extra Obbligo

## GESTY-SIU-010 Codice fiscale di docente e codocente
SIUF riconosce solo docenti persona fisica. Per ogni riga il codice fiscale del docente è, nell'ordine: quello della persona indicata sull'incarico come docente dell'azienda (`INCARICHI.ID_DOCENTE_AZIENDA`), se l'incarico è intestato a un'azienda e il campo è compilato; altrimenti quello dell'anagrafica del collaboratore incaricato; altrimenti il codice fiscale dell'azienda (ticket 81). La stessa regola vale per il codocente della lezione d'aula. Il rilevamento ore e la fatturazione restano intestati all'azienda. Gesty non controlla il codice fiscale del docente prima dell'invio: un'ora senza docente, o con la partita IVA di un'azienda, parte e viene rifiutata da SIUF (ticket 81, 152, 230).

### Scenario: incarico a un'azienda con docente indicato
- **Dato** un incarico intestato all'azienda "LE TERME DI FIDO" con docente dell'azienda MEGGIORINI CHETY
- **Quando** si invia una sua lezione
- **Allora** il tracciato porta il codice fiscale di MEGGIORINI CHETY

### Scenario: docente dell'azienda non indicato
- **Dato** lo stesso incarico senza docente dell'azienda
- **Quando** si invia
- **Allora** parte la partita IVA dell'azienda e SIUF risponde "lezione non trovata"

## GESTY-SIU-011 Codice fiscale dello studente
Prima dell'invio Gesty ferma le righe il cui codice fiscale non ha la forma di un codice fiscale: sedici caratteri fra lettere e cifre (anche codici provvisori `STP`, `MICF`) oppure undici cifre. Non verifica il carattere di controllo. Lo stesso codice sbagliato è segnalato una volta sola per blocco. Uno studente senza codice fiscale deve avere almeno cognome e nome (ticket 189).

### Scenario: data di nascita al posto del codice fiscale
- **Dato** uno studente iscritto con codice fiscale `19/09/2009`
- **Quando** si invia la classe
- **Allora** il blocco non parte e il messaggio nomina lo studente: "... ha un codice fiscale non valido ("19/09/2009"). Probabile scheda anagrafica doppia o importata con le colonne sfalsate..."

## GESTY-SIU-012 Testi di materia, contenuti e sede
SIUF confronta materia e contenuti con il calendario della lezione. Prima dell'invio Gesty riconduce apostrofi, virgolette e trattini tipografici ai caratteri semplici in materia, contenuti e sede (ticket 100, 110). Dalla vista "Export Completo" tutti i testi della riga passano anche dalla sanificazione del database (`SANIFICATION.SANIFICA_TESTO`).

### Scenario: apostrofo curvo
- **Dato** una materia "Gestione d’azienda"
- **Quando** si invia
- **Allora** il tracciato porta "Gestione d'azienda"

## GESTY-SIU-013 Blocchi di invio
Le righe si raggruppano per progetto e sezione, si ordinano per data e si spezzano in blocchi che coprono al massimo tre giorni consecutivi a partire dal primo giorno con presenze, perché SIUF non accetta intervalli più lunghi. Ogni blocco è una chiamata a sé, con il proprio controllo preventivo: un errore in un blocco ferma tutto quel blocco (tutti gli studenti della sezione in quei giorni) ma non gli altri (ticket 110). Un errore di comunicazione con SIUF interrompe l'invio dei blocchi successivi; quelli già spediti restano. "Annulla" ferma l'invio dopo il blocco in corso. Il limite dei tre giorni si applica anche al tirocinio, per scelta prudente (ticket 100).

### Scenario: cinque giorni
- **Dato** presenze di una sezione dal 21 al 25/09
- **Quando** si invia
- **Allora** partono due blocchi: 21-23/09 e 24-25/09

### Scenario: errore di trasporto
- **Dato** tre blocchi e la rete che cade durante il secondo
- **Quando** si invia
- **Allora** il primo è registrato con il suo esito, il secondo come "Errore Trasporto", il terzo non parte e compare "Invio interrotto per un errore di comunicazione con SIUF: ..."

## GESTY-SIU-014 Registro degli invii
Ogni blocco tentato lascia una riga in `SIUF_COOPERAZIONE_APPLICATIVA_INVII`: momento, ente, utente, sezione, periodo, numero di studenti, codici di tipologia contenuti (`TIPOLOGIE_INVIATE`, ticket 251), esito, stato HTTP, tipo di errore e messaggio. Anche un blocco fermato dal controllo preventivo è registrato, con esito negativo e tipo "Validation Error". Il tracciato spedito e la risposta di SIUF si conservano come allegati dell'invio. Il tipo di errore è ricavato dal testo della risposta di SIUF (utente inesistente, intervallo troppo ampio, sezione inesistente, studente non censito o non nella lezione, docente non del corso o non nella lezione, lezione non trovata, data fuori intervallo, minuti non corrispondenti, assenze giustificate); un testo non riconosciuto è "Altro". A fine invio compare il riepilogo per blocco, con esito, messaggio e percorso dei due file, su più righe.

### Scenario: blocco rifiutato prima di partire
- **Dato** un blocco con una tipologia non mappata
- **Quando** si invia
- **Allora** nel registro c'è una riga con esito negativo e tipo "Validation Error", senza tracciato allegato

## GESTY-SIU-015 "Lezione non trovata"
L'errore "lezione non trovata" lo genera SIUF, non Gesty: la cooperazione applicativa carica le presenze di lezioni che devono già esistere sul calendario SIUF, con gli stessi estremi esatti e gli stessi dati di identificazione (data, ore, tipologia, materia, contenuti, docente e codocente). Gesty non può leggere il calendario SIUF e non può avvisare prima (ticket 93, 98). Le cause viste finora: lezione non ancora disponibile su SIUF (passata da errore a riuscita in 30 minuti senza modifiche, ticket 98), ore non ricomposte (GESTY-SIU-007), tipologia sbagliata (GESTY-SIU-009), docente partita IVA (GESTY-SIU-010), lezione pratica classificata in modo diverso sul calendario (ticket 126).

### Scenario: lezione non ancora sul calendario
- **Dato** una lezione presente in Gesty e non ancora registrata su SIUF
- **Quando** si invia
- **Allora** SIUF rifiuta il blocco con "... non sono state trovate lezioni in data ... con ora inizio ... e ora fine ..." e il registro lo classifica "Lezione Non Trovata"

## GESTY-SIU-016 Periodo trasmesso
Un giorno è **trasmesso** per un progetto quando nel registro degli invii esiste un invio riuscito per la sezione del progetto (`PROGETTI.CODICE_REGIONALE`) il cui periodo contiene quel giorno. Un invio fallito non conta. Per le presenze di tirocinio conta solo un invio che conteneva la tipologia della presenza; un invio registrato prima del 17/10/2026, senza tipologie, conta per tutte (ticket 251, GESTY-TIR-020). Per le altre presenze conta qualunque invio riuscito della sezione, qualunque cosa contenesse: il registro non sa quali singole presenze sono partite.

### Scenario: invio fallito
- **Dato** un solo invio del 15/10, rifiutato da SIUF
- **Quando** si controlla se il 15/10 è trasmesso
- **Allora** non lo è

## GESTY-SIU-017 Presenze di un periodo trasmesso
Su un giorno trasmesso, inserire, modificare o cancellare presenze di aula, PIP, formazione interna e sostegno richiede l'autorizzazione `SIUF.ModificaPresenzeTrasmesse`, concessa su valutazione dai responsabili dell'ente (ticket 100, 251). Per l'aula sono escluse le ore non svolte, che non arrivano a SIUF (ticket 237). Il tirocinio segue GESTY-TIR-020: inserimento sempre libero, modifica e cancellazione controllate per tipologia. Il controllo vale per ogni canale di scrittura: maschere, importazioni GRS e SIUF, generazioni automatiche. Le lezioni dell'orario (`ORARIO`) non hanno questo controllo (ticket 237, R-097).

### Scenario: correzione di un'assenza già trasmessa
- **Dato** un'assenza del 15/10, giorno trasmesso, e un utente senza `SIUF.ModificaPresenzeTrasmesse`
- **Quando** la cambia in presenza
- **Allora** il salvataggio si ferma con "Le presenze di questo periodo sono già state trasmesse a SIUF con successo: la modifica richiede l'autorizzazione specifica."

### Scenario: utente autorizzato
- **Dato** lo stesso caso e un utente con `SIUF.ModificaPresenzeTrasmesse`
- **Quando** cambia la presenza
- **Allora** il salvataggio riesce

### Scenario: sostegno inviato prima dell'aula
- **Dato** un invio riuscito del solo sostegno del 15/10 sotto la stessa sezione
- **Quando** un utente senza autorizzazione importa il GRS aula del 15/10
- **Allora** l'elaborazione si ferma: per l'aula si importa tutto, poi si invia (ticket 251)

## GESTY-SIU-018 Iscrizione tardiva
Iscrivere uno studente, o spostarne la data di iscrizione o di ritiro, non crea le sue presenze d'ufficio sulle lezioni di giorni già trasmessi: quelle lezioni vengono saltate senza errore. È l'unica scrittura che rinuncia al dato invece di chiedere l'autorizzazione di GESTY-SIU-017.

### Scenario: iscrizione dopo l'invio
- **Dato** una classe con le lezioni del 15/10 trasmesse
- **Quando** si iscrive uno studente dal 14/10
- **Allora** non riceve presenze per il 15/10; le riceve per i giorni non trasmessi

## GESTY-SIU-019 Importazione del registro da SIUF
Il comando "Importa SIUF" legge il foglio elettronico scaricato dal registro presenze di SIUF (prima riga d'intestazione saltata) con le colonne in ordine fisso: codice fiscale, nome, cognome, data, ora d'inizio e di fine, ore di presenza, assenza giustificata, assenza, sezione, tipologia, docente, materia, contenuti. Codocente e sede non si importano. Il file diventa un file d'importazione GRS e segue lo stesso percorso: confronto con le lezioni già presenti, decisione dell'operatrice (sovrascrivere tutto, decidere lezione per lezione, annullare), poi elaborazione (ticket 228). Le scritture dell'elaborazione sono soggette a GESTY-SIU-017.

### Scenario: file che cambierebbe lezioni esistenti
- **Dato** un registro SIUF con un docente diverso da quello di Gesty su una lezione
- **Quando** lo si importa
- **Allora** prima di scrivere Gesty chiede se sovrascrivere tutte le lezioni, deciderle una per una o annullare

## GESTY-SIU-020 Controllo giornaliero di importazioni e invii
Ogni mattina (GestyScript pianificato alle 7:00, procedura `SIUF_MONITORAGGIO_ESEGUI_PIANIFICATO`) e a richiesta da Gesty ("Esegui controllo", ieri e oggi) si controllano, per ogni classe con canale SIUF e ogni giorno con lezioni svolte, le lezioni d'aula (ticket 228):

| Tipo | Difformità |
|---|---|
| `NIM` | nessuna lezione del giorno importata da ClasseViva |
| `LNI` | una lezione prevista non importata |
| `INM` | giorno con presenze senza invio riuscito, o progetto senza codice regionale |
| `INR` | l'ultimo invio del giorno è fallito, con il tipo di errore |
| `MDI` | lezione o presenza modificata dopo l'ultimo invio riuscito |

Il controllo non modifica lezioni e non invia nulla. Ogni difformità trovata lascia una riga nel registro (`SIUF_MONITORAGGIO_REGISTRO`), anche se è la stessa del giorno prima; il registro non si modifica né si cancella. Lo stato di una difformità è quello della sua ultima riga: `V` da verificare, `G` giustificata (con motivazione obbligatoria, e resta tale finché i valori non cambiano), `R` risolta (quando il controllo non la trova più, o per scelta dell'operatrice). L'esito per classe è "tutto OK" quando non restano difformità `V`. Giustificare, risolvere e riaprire richiedono "SIUF - Cooperazione Applicativa". Sostegno, interventi integrativi, formazione interna e tirocinio non sono controllati.

### Scenario: giustificazione senza motivazione
- **Dato** una difformità `V`
- **Quando** l'operatrice la giustifica senza scrivere il motivo
- **Allora** l'operazione si ferma con "Per giustificare una difformità serve la motivazione."

### Scenario: difformità che sparisce
- **Dato** una difformità `INM` del 07/10
- **Quando** il 07/10 viene inviato con successo e il controllo si ripete
- **Allora** nel registro si aggiunge una riga `R` "Non più rilevata dal controllo"

### Scenario: tentativo di correggere il registro
- **Dato** una riga del registro dei controlli
- **Quando** si prova a modificarla o cancellarla
- **Allora** l'operazione si ferma con "Il registro dei controlli SIUF non si modifica e non si cancella: ogni cambiamento è una riga nuova."

## Divergenze note

Punti in cui il codice di oggi non mantiene ciò che i requisiti dicono, o in cui due parti del codice applicano la stessa regola in modo diverso. Raccolte in R-184; con la correzione il requisito si aggiorna e questa sezione si accorcia.

| Codice | Divergenza | Conseguenza |
|---|---|---|
| DIV-SIU-1 | Il periodo trasmesso (`SIUF_SEZIONE_GIA_TRASMESSA`, `SIUF_PRESENZA_GIA_TRASMESSA`), la protezione del canale (`PROGETTI_BIU0`) e il controllo giornaliero (`SIUF_MONITORAGGIO_ESEGUI`) cercano gli invii con `PROGETTI.CODICE_REGIONALE`, ma l'aula dei progetti di apprendistato e il sostegno partono con la sezione del piano formativo dell'iscrizione (GESTY-SIU-004) | Per quelle sezioni il blocco di GESTY-SIU-017 non scatta mai, il canale resta modificabile dopo gli invii, l'iscrizione tardiva crea presenze su giorni già inviati e il controllo giornaliero segnala `INM` ("nessun invio" o "progetto senza codice regionale") su giorni inviati con successo |
| DIV-SIU-2 | La correzione del ticket 191 sul corso è solo in `GRS_EXPORT_SOSTEGNO`: per l'aula dei progetti di apprendistato `GRS_EXPORT_COLLETTIVA` cerca ancora l'iscrizione con lo stesso corso della lezione, e altrimenti ricade sul codice regionale del progetto | Una lezione senza corso, o con un corso diverso da quello dell'iscrizione, prende la sezione del progetto; se il progetto non ha codice regionale l'invio intero si ferma con "Id Sezione non valida: ", senza dire quale riga |
| DIV-SIU-3 | Il blocco dei periodi trasmessi è diverso per tabella: tirocinio per tipologia e con inserimento libero; aula, PIP, formazione interna e sostegno per sola sezione e data, inserimento compreso. Sull'aula scatta anche su presenze con "Calcolare" tolto, che non partono mai, e su un salvataggio che non cambia nulla | Un invio di sola aula blocca il sostegno dello stesso giorno e viceversa (ticket 251); escludere un allievo da un giorno già inviato richiede l'autorizzazione anche se quella presenza non era partita |
| DIV-SIU-4 | Il controllo giornaliero conta, per `MDI` e per decidere se il giorno ha presenze, anche le ore non svolte, che dal ticket 230 non partono | Modificare una lezione annullata dopo l'invio produce una difformità `MDI` su dati che SIUF non ha mai ricevuto |
| DIV-SIU-5 | In `dmSIUF_CooperazioneApplicativa` resta il ramo di prova: se accanto a `Gesty.exe` c'è `SIUF_CooperazioneApplicativa.Test.ini`, indirizzo e credenziali si leggono da lì invece che dal database, e l'utente registrato nell'invio è fisso (`ctx.UserId := 11`) (ticket 93) | La conferma lo dice, ma gli invii di quella postazione vanno all'ambiente del file e nel registro risultano fatti da un altro utente |
| DIV-SIU-6 | La sanificazione completa dei testi (`SANIFICATION.SANIFICA_TESTO` su tutti i campi) sta solo in `GRS_EXPORT`, cioè nella vista "Export Completo". Le viste di aula, PIP e sostegno, da cui si può inviare (ticket 251), leggono le procedure di ramo senza sanificazione; al salvataggio `ORARIO_SANIFICA_BI1` tratta contenuti e sede ma non la materia | Lo stesso giorno inviato da due viste diverse può partire con testi diversi; oltre agli apostrofi di GESTY-SIU-012, nella materia possono restare caratteri che la sanificazione toglierebbe |
| DIV-SIU-7 | `SIUF_COOP_CONFIG_BI_ATTIVO` disattiva solo la configurazione attiva dell'**altro** ambiente; `SIUF_COOPERAZIONE_APPLICATIVA_CONFIG_GET` legge la configurazione attiva con una lettura a valore singolo | Due configurazioni attive dello stesso ambiente per lo stesso ente sono ammesse, e da quel momento ogni invio dell'ente si ferma con l'errore di Firebird "multiple rows in singleton select" |
| DIV-SIU-8 | `GET_TIPOLOGIA_FORMAZIONE` non ha un ramo per il codice 32 "Sostegno tirocinio/formazione interna", che il dominio ammette e il canale ordinamentale accetta | Una lezione d'aula con tipologia 32 esce senza tipologia e il blocco si ferma come "non fra quelle accettate", con il codice vuoto nel messaggio |
| DIV-SIU-9 | La classificazione degli errori (`ClassificaErrore`) riconosce i testi del catalogo Extra Obbligo, non quelli visti sul canale ordinamentale: "la lezione duri (60 minuti)" (ticket 152), "Il valore di Ore Assenza Giustificata non può essere diverso da zero" (ticket 186, il controllo cerca "assenze giustificate") | Nel registro e nel controllo giornaliero questi rifiuti compaiono come "Altro" |
| DIV-SIU-10 | `SIUF_MONITORAGGIO_CAMBIA_STATO` accetta qualunque passaggio fra `V`, `G` e `R`, anche da `R` a `G`, mentre la matrice degli stati del ticket 228 prevede per `R` solo il ritorno a `V` quando la difformità ricompare; l'autorizzazione è controllata solo nell'applicazione | Una difformità risolta può essere giustificata, e da una connessione diretta al database lo stato si cambia senza autorizzazione |

<!-- footer -->
---

[www.zebro.it/gesty](https://www.zebro.it/gesty)
<!-- /footer -->
