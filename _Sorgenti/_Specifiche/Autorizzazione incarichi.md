---
area: Autorizzazione incarichi
progetto: Gesty
aggiornato: 2026-11-05
rilascio: Ticket_Gesty/326 - incarichi non presenti tra quelli da autorizzare gestire/001
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

# Autorizzazione incarichi

Questa specifica descrive le regole che Gesty rispetta dal momento in cui una richiesta di incarico viene inserita fino a quando l'incarico diventa operativo: autorizzazione finanziaria (a Codebri "visto contabile"), autorizzazione della direzione, attivazione (a Codebri "perfezionamento"), respingimento e ripresentazione, stati dell'incarico, elenco "Incarichi Da Gestire", chi vede cosa e quali avvisi partono. Descrive il comportamento atteso, non il codice. Le regole stanno quasi tutte nel database (procedure `INCARICO_AUTORIZZAZIONE_FINANZIARIA`, `INCARICO_AUTORIZZAZIONE_DIREZIONE`, `INCARICO_ATTIVA`, `INCARICO_ANNULLA_ATTIVAZIONE`, `INCARICO_RESPINGI`, `INCARICO_RIPRESENTA`, `INCARICO_ACCETTA_ORE_RESIDUE`, funzioni `INCARICO_FASE`, `INCARICHI_FASE_ESEGUIBILE`, `INCARICO_*_RICHIESTA`, trigger `INCARICHI_BIU0`, `INCARICHI_AIU0`, `INCARICHI_BD0`, vista `INCARICHI_ELENCO`); l'elenco e i comandi stanno nel dataset LZ `Progetti.IncarichiDaGestire` e in `TProgetti` (`dmProgetti.pas`).

**Fuori da quest'area**, con una specifica propria quando un lavoro le toccherà: inserimento della richiesta nella procedura guidata (controlli su risorsa, progetto, date, ore, casellario, importi degli occasionali), firma digitale del contratto e gestione dei contratti, rilevamento delle ore sugli incarichi (vedi `Rilevamento ore.md`), autorizzazioni di pagamento (`AUTORIZZAZIONI_PAGAMENTO`, un'altra entità con nomi simili).

**Origine.** Bozza ricavata il 2026-10-30 dalle preanalisi dei ticket 183, 184, 190, 210, 276, 281, 282, 301, e riletta sul database master `GESTY` (fotografia del 2026-10-30 13:19), sul dizionario LZ e sui sorgenti di `SRC` dello stesso giorno. Configurazione dei clienti letta sulle copie `CAPAC` (2026-10-24) e `CODEBRI` (dati fino al 28/10). Le preanalisi 121, 222 e 227 non trattano l'autorizzazione. Dove una regola viene solo da un ticket, il ticket è citato.

## GESTY-AUT-001 Autorizzazioni dell'utente
Ogni passaggio del ciclo richiede un'autorizzazione nominata (`USR_DEFAULT_AUTHORIZATIONS`), assegnata all'utente direttamente o tramite un gruppo. Le autorizzazioni si caricano all'accesso: un'autorizzazione assegnata a sessione aperta vale dal collegamento successivo. Essere amministratore non esenta da nessun controllo. Quando manca, l'operazione si ferma con il messaggio dell'autorizzazione (`GET_MESSAGE`) o, se non ne ha uno proprio, con "<nome> Autorizzazione necessaria per questa operazione." Le autorizzazioni non hanno ambito: valgono per tutti gli incarichi, di qualunque settore o progetto (GESTY-AUT-014).

| Autorizzazione | Cosa permette |
|---|---|
| `Incarichi.AutorizzazioneFinanziaria` | dare l'autorizzazione finanziaria e respingere in quella fase |
| `Incarichi.AutorizzazioneDirezione` | dare l'autorizzazione della direzione e respingere in quella fase |
| `Incarichi.Attivazione` | attivare; modificare richieste altrui non ancora attivate; ripresentare richieste altrui |
| `Incarichi.Attivazione.Annulla` | annullare un'attivazione |
| `Incarichi.Supervisore` | modificare o eliminare incarichi già attivati o protocollati; cambiare il protocollo |
| `Incarichi.AccettaOreResidue` | accettare le ore residue di un incarico scaduto |
| `Incarichi.ModificaEstensore` | intestare la richiesta a un altro estensore |
| `Incarichi.Visualizzazione`, `Incarichi.VisualizzaImporti` | vedere incarichi e importi di altri (GESTY-AUT-013) |

### Scenario: amministratore senza autorizzazione
- **Dato** un utente amministratore che non ha `Incarichi.Attivazione`, né direttamente né per gruppo
- **Quando** attiva un incarico
- **Allora** l'attivazione si ferma con l'errore di autorizzazione (ticket 276, stesso meccanismo su un'altra autorizzazione)

### Scenario: autorizzazione appena assegnata
- **Dato** un utente collegato a cui viene assegnata `Incarichi.AutorizzazioneFinanziaria`
- **Quando** prova il visto senza uscire da Gesty
- **Allora** l'operazione si ferma ancora; dopo un nuovo accesso riesce

## GESTY-AUT-002 Tre passaggi, configurati per cliente
Una richiesta diventa incarico operativo attraverso tre passaggi, in quest'ordine: autorizzazione finanziaria, autorizzazione della direzione, attivazione. Quattro interruttori di `CONFIG` dicono, separatamente per gli incarichi a dipendenti (tipo di contratto `D`, "interni") e a collaboratori esterni, se l'autorizzazione finanziaria è una fase propria e se serve quella della direzione. Un quinto (`ATTIVAZIONE_INCARICHI_INTERNI`) dice se gli incarichi ai dipendenti compaiono nell'elenco da gestire (GESTY-AUT-012).

- Dove la finanziaria **non** è una fase propria, la registra l'attivazione, con la stessa data e lo stesso utente (GESTY-AUT-006): le colonne della finanziaria sono quindi sempre valorizzate su un incarico attivato.
- Dove la direzione non serve, la richiesta la riceve subito come "non richiesta" (`TIPO_AUTORIZZAZIONE_DIREZIONE = 'A'`, con la data del giorno), all'inserimento e a ogni salvataggio che la riporterebbe "da autorizzare".

| Cliente | Finanziaria propria (int. / est.) | Direzione (int. / est.) | Dipendenti nell'elenco |
|---|---|---|---|
| Master, CAPAC | no / no | no / no | sì |
| Codebri | no / **sì** | no / **sì** | no |

### Scenario: CAPAC, un passaggio solo
- **Dato** CAPAC, con tutti gli interruttori della finanziaria e della direzione spenti
- **Quando** si inserisce una richiesta per un collaboratore esterno
- **Allora** la richiesta è subito in fase `ATTIVAZIONE`, con direzione "non richiesta"
- **E** all'attivazione si registrano insieme finanziaria e attivazione

### Scenario: Codebri, collaboratore esterno
- **Dato** Codebri
- **Quando** si inserisce una richiesta per un esterno
- **Allora** la richiesta è in fase `FINANZIARIA` e chi vista riceve l'avviso (GESTY-AUT-015)

## GESTY-AUT-003 Stati dell'incarico
Lo stato (fase) di un incarico si calcola sempre dai suoi dati, non si scrive: lo stesso calcolo (`INCARICO_FASE`) serve l'elenco, la scheda e gli avvisi. I codici sono fissi; descrizione, nome del comando e testo dell'esito si leggono da `ZZ_INCARICHI_FASI` e ogni cliente può avere i suoi (a Codebri "Da vistare (visto contabile)", "Da autorizzare (Direttore)", "Da perfezionare"). Le fasi si valutano in quest'ordine, e vale la prima che corrisponde:

| Codice | Descrizione predefinita | Quando |
|---|---|---|
| `RESPINTO` | Respinto | non attivato e respinto (GESTY-AUT-009) |
| `FINANZIARIA` | Da autorizzare (finanziaria) | non attivato, finanziaria propria e mancante, direzione non ancora data |
| `DIREZIONE` | Da autorizzare (direzione) | non attivato, direzione da dare (`'?'`) |
| `ATTIVAZIONE` | Da attivare | non attivato, direzione data o non richiesta |
| `FIRMA_DA_APPROVARE` | Firma da approvare | attivato, ultima pratica di firma del contratto in `I` |
| `FIRMA_DA_INVIARE` | Firma da inviare | pratica in `A` |
| `IN_FIRMA` | In firma | pratica in `D` |
| `FIRMA_DA_RIFARE` | Firma da rifare | pratica in `R` o `S`, incarico non scaduto |
| `ORE_RESIDUE` | Scaduto con ore residue | scaduto, ore residue maggiori di zero e non accettate |
| `CHIUSO` | Concluso | scaduto senza residuo, o residuo accettato |
| `IN_CORSO` | In corso | attivato e non scaduto, in tutti gli altri casi |

Un incarico è operativo (ore, rilevamenti, pagamenti) solo da attivato (`ATTIVATO`, vero quando c'è la data di attivazione).

### Scenario: direzione data prima che la finanziaria diventasse una fase propria
- **Dato** un incarico già autorizzato dalla direzione (`'M'`) e senza finanziaria, in un cliente che accende la finanziaria come fase propria
- **Quando** se ne calcola la fase
- **Allora** è `ATTIVAZIONE`: la finanziaria non si chiede più a chi ha già l'assenso della direzione

### Scenario: attivato senza contratto da firmare
- **Dato** un incarico attivato senza nessuna pratica di firma e non scaduto
- **Quando** se ne calcola la fase
- **Allora** è `IN_CORSO` (vedi DIV-AUT-9)

## GESTY-AUT-004 Autorizzazione finanziaria (visto contabile)
La dà chi ha `Incarichi.AutorizzazioneFinanziaria`, solo dove è una fase propria e solo su un incarico non attivato. Registra la data del giorno e l'utente che la dà, e avvisa gli iscritti a "Autorizzazione finanziaria concessa" (a Codebri il Direttore). Se la finanziaria c'è già, o la direzione ha già autorizzato, non fa nulla e non dà errore.

### Scenario: fase non propria
- **Dato** un incarico a un dipendente di Codebri, dove per gli interni la finanziaria non è una fase propria
- **Quando** si chiede l'autorizzazione finanziaria
- **Allora** l'operazione si ferma con "Per questo incarico l'autorizzazione finanziaria non è una fase propria: la registra l'attivazione dell'incarico."

### Scenario: incarico già attivato
- **Dato** un incarico attivato
- **Quando** si chiede l'autorizzazione finanziaria
- **Allora** l'operazione si ferma con "L'incarico risulta già attivato."

### Scenario: senza autorizzazione
- **Dato** un utente senza `Incarichi.AutorizzazioneFinanziaria`
- **Quando** appone il visto
- **Allora** l'operazione si ferma con l'errore di autorizzazione; lo stesso controllo vale per chi scrive la data della finanziaria per qualunque altra strada

## GESTY-AUT-005 Autorizzazione della direzione
La dà chi ha `Incarichi.AutorizzazioneDirezione`, su un incarico in attesa (`'?'`). Dove la finanziaria è una fase propria, la direzione autorizza solo dopo di essa. Registra `'M'`, la data del giorno e l'utente; avvisa gli iscritti a "Incarico autorizzato dalla direzione" (a Codebri chi perfeziona). Su un incarico che non è in attesa non fa nulla e non dà errore.

### Scenario: manca il visto
- **Dato** un incarico esterno di Codebri senza visto contabile
- **Quando** il Direttore lo autorizza
- **Allora** l'operazione si ferma con "L'incarico non ha ancora l'autorizzazione finanziaria."

### Scenario: senza autorizzazione
- **Dato** un utente senza `Incarichi.AutorizzazioneDirezione`
- **Quando** autorizza un incarico in attesa
- **Allora** l'operazione si ferma con l'errore di autorizzazione

## GESTY-AUT-006 Attivazione
La esegue chi ha `Incarichi.Attivazione` (ma vedi DIV-AUT-2). L'incarico non deve essere già attivato e deve avere l'autorizzazione della direzione, data o non richiesta; dove la direzione non serve e la finanziaria è una fase propria, deve avere la finanziaria. La data di attivazione è obbligatoria, non futura e non anteriore al 2000; può precedere la data della richiesta, perché è una prassi (a CAPAC migliaia di casi).

L'attivazione registra data e utente, il protocollo (solo per gli incarichi non collegati a un incarico di massima), il parametro di ricavo specifico e, dove la finanziaria non è una fase propria, anche la finanziaria con la stessa data e lo stesso utente. Se il progetto non ha ancora una riga di budget per quel tipo di incarico, la crea a importo zero con le ore attribuite. Avvisa gli iscritti a "Incarico attivato".

Dall'elenco l'attivazione segue due strade secondo l'inquadramento (`ZZ_TIPO_INQUADRAMENTO`):
- se l'incarico richiede protocollo o contratto, una finestra per incarico chiede data di attivazione, protocollo (se richiesto) e parametro di ricavo; dopo, se l'incarico richiede il contratto e l'utente ha la stampa automatica, si apre l'anteprima del contratto, da cui parte la firma;
- se non richiede né protocollo né contratto (a CAPAC dipendenti, interinali, stage, co.co.co. e ogni incarico collegato a un incarico di massima), una sola conferma per tutti i selezionati e la data di attivazione è quella del giorno (vedi DIV-AUT-8).

### Scenario: direzione mancante
- **Dato** un incarico in attesa della direzione
- **Quando** si attiva
- **Allora** l'operazione si ferma con "L'incarico non ha ancora l'autorizzazione della direzione."

### Scenario: data impossibile
- **Dato** un incarico pronto per l'attivazione
- **Quando** si attiva con data 01/01/2109
- **Allora** l'operazione si ferma con "Data di attivazione non valida: 01/01/2109."

### Scenario: incarico senza protocollo né contratto
- **Dato** un incarico a un dipendente di CAPAC, fase `ATTIVAZIONE`
- **Quando** si preme Procedi
- **Allora** compare "Attiva incarico: 1 incarichi senza protocollo e senza contratto, con la data di oggi. Procedere?"
- **E** con Sì l'incarico è attivato con la data del giorno; con No resta da attivare e il cursore passa al successivo (ticket 301)

### Scenario: annullamento nella finestra
- **Dato** tre incarichi selezionati che richiedono protocollo
- **Quando** nella finestra del secondo si preme Annulla
- **Allora** il primo è attivato, il secondo e il terzo restano da attivare e il cursore resta sul secondo (ticket 183, collaudo del 19/10)

## GESTY-AUT-007 Annullamento dell'attivazione
Chi ha `Incarichi.Attivazione.Annulla` riporta un incarico attivato a non attivato: si tolgono data e utente dell'attivazione e, dove la finanziaria non è una fase propria, anche la finanziaria, che era stata registrata con lei. Su un incarico non attivato non fa nulla. Protocollo e autorizzazione della direzione restano.

### Scenario: CAPAC
- **Dato** un incarico attivato a CAPAC
- **Quando** si annulla l'attivazione
- **Allora** l'incarico torna in fase `ATTIVAZIONE` e le colonne della finanziaria sono vuote

## GESTY-AUT-008 Il compenso cambiato fa ripartire il ciclo
Dove la finanziaria è una fase propria, se prima dell'attivazione cambia il compenso orario, decadono finanziaria e direzione: la nuova cifra deve ripassare dalla contabilità e dal Direttore. Nessun'altra modifica le fa decadere (decisione del cliente nel ticket 183). Dove la finanziaria non è una fase propria, il compenso cambiato non tocca le autorizzazioni. Il ritorno a "da autorizzare" non richiede nessun permesso.

### Scenario: compenso corretto dopo il visto
- **Dato** un incarico esterno di Codebri con visto, in fase `DIREZIONE`
- **Quando** l'estensore cambia il compenso orario
- **Allora** l'incarico torna in fase `FINANZIARIA` e chi vista riceve di nuovo l'avviso "da vistare"

### Scenario: date corrette dopo il visto
- **Dato** lo stesso incarico
- **Quando** l'estensore cambia la data di fine
- **Allora** il visto resta

## GESTY-AUT-009 Respingimento
Nelle fasi `FINANZIARIA` e `DIREZIONE` chi ha l'autorizzazione di quella fase può respingere la richiesta, con un motivo obbligatorio; chi attiva non respinge. Si registrano momento, utente, fase e motivo. Dove la finanziaria è una fase propria il visto già dato si toglie, così la richiesta ripresentata riparte dal visto anche se l'ha respinta il Direttore. La richiesta resta in fase `RESPINTO` finché non viene ripresentata.

L'avviso "Richiesta di incarico respinta", con fase, autore e motivo, va a estensore, a chi ha inserito la richiesta, al responsabile del progetto, al responsabile del settore aziendale del progetto e agli iscritti all'avviso, mai a chi respinge.

Dall'elenco si respingono più richieste insieme con un solo motivo, purché tutte nella stessa fase. Il comando Respingi è disattivato quando la riga corrente non è in fase `FINANZIARIA` o `DIREZIONE`; il controllo guarda la sola riga corrente, e una selezione di fasi miste si ferma comunque con il messaggio sotto.

### Scenario: respingimento del Direttore dopo il visto
- **Dato** un incarico esterno di Codebri con visto, in fase `DIREZIONE`
- **Quando** il Direttore lo respinge con motivo "compenso fuori tabella"
- **Allora** l'incarico è `RESPINTO`, senza visto
- **E** l'estensore riceve l'avviso con fase, autore e motivo

### Scenario: motivo vuoto
- **Dato** una richiesta in fase `FINANZIARIA`
- **Quando** la si respinge senza motivo
- **Allora** l'operazione si ferma con "Il motivo del respingimento è obbligatorio."

### Scenario: fase sbagliata
- **Dato** una richiesta in fase `ATTIVAZIONE`
- **Quando** la si respinge
- **Allora** l'operazione si ferma con "Si possono respingere solo le richieste in attesa del visto contabile o dell'autorizzazione della direzione."

### Scenario: già respinta
- **Dato** una richiesta `RESPINTO`
- **Quando** la si respinge di nuovo
- **Allora** l'operazione si ferma con "La richiesta risulta già respinta."

## GESTY-AUT-010 Ripresentazione
Una richiesta respinta la ripresenta il suo estensore, dopo averla corretta, oppure chi ha `Incarichi.Attivazione`. La ripresentazione cancella i dati del respingimento (lo storico resta in `LOG_INCARICHI`) e la richiesta rientra nella fase che le spetta: con la finanziaria propria in `FINANZIARIA`, con l'avviso "da vistare". Chi aveva respinto e gli iscritti ricevono "Richiesta di incarico ripresentata", mai chi ripresenta. Dall'elenco la ripresentazione è il comando Procedi sulla fase `RESPINTO`, con la conferma "<comando>: N richieste selezionate. Le richieste ripartono dal primo passaggio di autorizzazione. Procedere?". L'estensore può anche eliminare la richiesta respinta (GESTY-AUT-011).

### Scenario: ripresentazione dell'estensore
- **Dato** una richiesta esterna di Codebri respinta dal Direttore
- **Quando** l'estensore la ripresenta
- **Allora** è in fase `FINANZIARIA`, chi vista riceve "da vistare" e il Direttore riceve "ripresentata"

### Scenario: richiesta non respinta
- **Dato** una richiesta in fase `DIREZIONE`
- **Quando** la si ripresenta
- **Allora** l'operazione si ferma con "La richiesta non risulta respinta."

## GESTY-AUT-011 Modifica ed eliminazione di una richiesta
I dati essenziali della richiesta (progetto, risorsa, azienda, estensore, tipo, descrizione, materia, sostituzioni e collegamenti, date, ore attribuite, compenso, costo, data della richiesta, attivazione, protocollo) li modifica liberamente il suo estensore finché non è attivata; gli altri hanno bisogno di `Incarichi.Attivazione`. Su un incarico attivato serve `Incarichi.Supervisore`. Cambiare data o numero di protocollo richiede sempre `Incarichi.Supervisore` e un incarico che non sia in attesa della direzione. Le altre colonne (note, motivazione, valutazione...) restano libere.

Eliminare una richiesta non attivata e senza protocollo è permesso all'estensore; agli altri, e su ogni incarico attivato o protocollato, serve `Incarichi.Supervisore`. Non si elimina un incarico con ore rilevate validate (GESTY-RIL-008) o con il contratto già firmato.

"Modifica estensore" intesta la richiesta a un altro estensore e richiede `Incarichi.ModificaEstensore`; è la strada per far correggere a un collega le richieste di chi ha lasciato l'ente (ticket 183, risposta 3; ticket 184).

### Scenario: richiesta di un collega uscito
- **Dato** una richiesta non attivata il cui estensore è Francesca Biffi
- **Quando** Debora Galimberti, senza `Incarichi.Attivazione`, ne cambia le ore attribuite
- **Allora** il salvataggio si ferma con l'errore di autorizzazione (ticket 184)
- **E** dopo "Modifica estensore" a suo nome il salvataggio riesce

### Scenario: protocollo corretto da chi attiva
- **Dato** un incarico attivato e un utente con `Incarichi.Attivazione` ma senza `Incarichi.Supervisore`
- **Quando** cambia il numero di protocollo
- **Allora** il salvataggio si ferma con l'errore di autorizzazione

## GESTY-AUT-012 Elenco "Incarichi Da Gestire"
Un solo elenco raccoglie le richieste su cui l'utente ha qualcosa da fare. Mostra gli incarichi:
- non attivati;
- con data di inizio negli ultimi 365 giorni, oppure inseriti negli ultimi 365 giorni (`INCARICHI.USR_DATA_INS`): una richiesta inserita a posteriori con inizio più vecchio compare lo stesso (ticket 326). La data della richiesta non conta, perché chi inserisce a posteriori la retrodata insieme all'inizio;
- esterni, e anche ai dipendenti dove `CONFIG.ATTIVAZIONE_INCARICHI_INTERNI` è vero (CAPAC sì, Codebri no: ticket 281);
- in una fase per cui l'utente ha l'autorizzazione (`FINANZIARIA`, `DIREZIONE`, `ATTIVAZIONE`, e `RESPINTO` per chi ha `Incarichi.Attivazione`), oppure respinti e di cui l'utente è l'estensore.

L'ordine è per fase, poi dalla richiesta più recente. Il comando Procedi esegue il passaggio della fase sugli incarichi selezionati (o sul solo incarico corrente, con la scheda aperta); la selezione deve essere tutta in una fase. Ogni passaggio chiede conferma e registra un incarico alla volta: se uno si ferma, quelli prima restano registrati. Dopo il passaggio l'elenco si riapre e il cursore va sul primo incarico che seguiva la selezione e non ne faceva parte, altrimenti sul più vicino che la precede.

Gli incarichi attivati, quelli in firma e quelli scaduti con ore residue non sono in questo elenco: hanno la gestione dei contratti e l'elenco "Incarichi scaduti con ore residue".

### Scenario: fasi miste
- **Dato** un incarico in `FINANZIARIA` e uno in `DIREZIONE` selezionati
- **Quando** si preme Procedi
- **Allora** compare "Gli incarichi selezionati sono in fasi diverse: selezionarne di una fase sola." e non si registra nulla

### Scenario: chi vista non vede i da attivare
- **Dato** Lavinia Macrì, con `Incarichi.AutorizzazioneFinanziaria` e senza `Incarichi.Attivazione`
- **Quando** apre l'elenco
- **Allora** vede solo le richieste in fase `FINANZIARIA`

### Scenario: estensore con richiesta respinta
- **Dato** un responsabile di settore senza autorizzazioni del ciclo, estensore di una richiesta respinta
- **Quando** apre l'elenco
- **Allora** vede quella richiesta, con motivo, autore e fase del respingimento, e il comando Procedi la ripresenta

### Scenario: cursore dopo l'attivazione
- **Dato** il cursore sul terzo incarico dell'elenco
- **Quando** lo si attiva
- **Allora** l'incarico esce dall'elenco e il cursore è sul successivo, unica riga selezionata (ticket 183, collaudo del 19/10)

### Scenario: richiesta vecchia
- **Dato** una richiesta non attivata con inizio 400 giorni fa, inserita 400 giorni fa
- **Quando** si apre l'elenco
- **Allora** non compare (vedi DIV-AUT-7)

### Scenario: richiesta retrodatata
- **Dato** una richiesta per un collaboratore esterno di CAPAC inserita oggi, con data della richiesta e inizio 400 giorni fa
- **Quando** si apre l'elenco
- **Allora** compare in fase `ATTIVAZIONE` e si può attivare (ticket 326: incarichi 513690 e 513691, inseriti il 24/10/2026 con inizio 23/09/2025)

## GESTY-AUT-013 Chi vede gli importi
Compenso e costo di un incarico li vedono l'estensore, la risorsa stessa se non è dipendente, il responsabile del progetto, chi ha `Incarichi.VisualizzaImporti` e chi ha `Incarichi.Supervisore` (`CAN_SEE_IMPORTI_INCARICHI`). Gli altri li vedono vuoti; se salvano l'incarico, compenso e costo restano quelli di prima senza avviso, così una modifica di altri campi non tocca la cifra che non vedono. Chi vista deve quindi vedere gli importi (a Codebri Macrì li vede per il gruppo "Visualizzazione Importi"). Parametro di ricavo e costi effettivi si vedono e si scrivono solo con l'autorizzazione `Budget`; con la stessa autorizzazione si cambia "Consenti superamento ore" del progetto (ticket 190).

### Scenario: segreteria senza importi
- **Dato** un utente senza `Incarichi.VisualizzaImporti` né `Incarichi.Supervisore`, che non è estensore né responsabile del progetto
- **Quando** apre un incarico e ne modifica le note
- **Allora** vede il compenso vuoto e, salvando, il compenso resta quello registrato

### Scenario: superamento ore del progetto
- **Dato** un utente senza `Budget`
- **Quando** spunta "Consenti superamento ore" su un progetto
- **Allora** il salvataggio si ferma con "Autorizzazione Budget necessaria per questa operazione." (ticket 190)

## GESTY-AUT-014 Settore aziendale
Il settore aziendale del progetto (`ZZ_SETTORI_AZIENDALI_RESPONSAB`, con validità nel tempo) dà il responsabile di settore mostrato nell'elenco e destinatario dell'avviso di respingimento (GESTY-AUT-009). Non dà né toglie autorizzazioni: chi ha un'autorizzazione del ciclo la esercita su incarichi di ogni settore, e chi la deve esercitare per un settore la riceve come autorizzazione propria (ticket 184). Il settore non limita neppure quali incarichi si vedono (vedi DIV-AUT-1).

### Scenario: cambio di responsabile di settore
- **Dato** il settore S01 passato da Biffi a Galbusera
- **Quando** Galimberti deve sistemare le richieste di S01
- **Allora** non basta il settore: le serve `Incarichi.Attivazione`, o che le richieste siano intestate a lei (ticket 184)

## GESTY-AUT-015 Avvisi del ciclo
Ogni passaggio avvisa chi deve fare il successivo, per iscrizione all'avviso (`USR_UTENTI_SOTTOSCRIZIONI_NOTIFICHE`); oggetto e testo usano le parole del cliente (`ZZ_NOTIFICHE.DESC_NOTIFICA`, `ZZ_INCARICHI_FASI.ESITO`) seguite dal nominativo della risorsa.

| Avviso | Quando parte | A chi |
|---|---|---|
| Incarico inserito | all'inserimento | iscritti |
| Incarico da autorizzare (finanziaria) | quando l'incarico entra in fase `FINANZIARIA`: inserimento, compenso cambiato, ripresentazione | iscritti |
| Autorizzazione finanziaria concessa | al visto | iscritti |
| Incarico autorizzato dalla direzione | all'autorizzazione della direzione | iscritti |
| Incarico attivato | all'attivazione | iscritti |
| Richiesta di incarico respinta | al respingimento | interessati della richiesta e iscritti (GESTY-AUT-009) |
| Richiesta di incarico ripresentata | alla ripresentazione | chi aveva respinto e iscritti |

Nessun avviso dice "da autorizzare (direzione)" o "da attivare": chi autorizza o attiva lo sa dall'avviso del passaggio precedente. Durante la sessione un avviso compare entro pochi minuti anche se il canale degli eventi del database si è interrotto (controllo periodico e riapertura del canale, ticket 183 rilasci 013 e 014).

### Scenario: avviso a sessione aperta da ore
- **Dato** chi vista collegato da tre ore da un portatile, con il canale degli eventi caduto
- **Quando** arriva una richiesta da vistare
- **Allora** l'avviso compare entro qualche minuto, senza uscire da Gesty

## GESTY-AUT-016 Motivazione della richiesta
Dove `CONFIG.INCARICHI_MOTIVAZIONE_VISIBILE` è vero (oggi Codebri), la procedura guidata mostra la motivazione, la propone con il testo predefinito del cliente e la richiede per le richieste nuove a collaboratori esterni. Le richieste già inserite restano come sono. Dove è falso il campo non compare.

### Scenario: esterno senza motivazione
- **Dato** Codebri e una richiesta nuova per un esterno con la motivazione cancellata
- **Quando** la si conferma nella procedura guidata
- **Allora** compare "La motivazione è obbligatoria per gli incarichi a collaboratori esterni." (vedi DIV-AUT-6)

## GESTY-AUT-017 Ore residue di un incarico scaduto
Un incarico scaduto con ore residue resta in fase `ORE_RESIDUE` finché chi ha `Incarichi.AccettaOreResidue` non le accetta, dall'elenco "Incarichi scaduti con ore residue" anche per più incarichi insieme. Accettate, l'incarico è `CHIUSO`.

### Scenario: accettazione di più incarichi
- **Dato** tre incarichi scaduti con ore residue selezionati
- **Quando** si accettano le ore residue
- **Allora** compare "Accettare le ore residue dei 3 incarichi selezionati?" e, con Sì, tutti e tre sono `CHIUSO`

## GESTY-AUT-018 Una copia non eredita le autorizzazioni
Duplicando un incarico nella procedura guidata, la copia non porta nessuna autorizzazione né l'utente che l'ha data, né attivazione o protocollo: nasce all'inizio del ciclo (ticket 183, difetto D4).

### Scenario: duplicazione di un incarico attivato
- **Dato** un incarico attivato e protocollato
- **Quando** lo si duplica
- **Allora** la copia è nella prima fase del ciclo, senza attivazione né protocollo

## GESTY-AUT-019 Tempi dell'elenco
L'elenco si apre in pochi secondi e non blocca l'interfaccia più del necessario: la struttura dei campi si legge senza eseguire la query (`TzFbDataSet`, `ROWS 0`), così la vista si calcola una volta sola per apertura, e le barre azioni dei documenti non rileggono il database a ogni momento di inattività quando più documenti sono aperti insieme. Il tempo che resta (circa 4 secondi sui dati del master del 2026-10-08) è il calcolo della vista `INCARICHI_ELENCO`, che per ogni riga esegue più procedure. Regola presa dalle misure dei ticket 183 e 210; nel codice di oggi verificata solo la presenza dei due rimedi, non i tempi.

### Scenario: apertura dell'elenco
- **Dato** l'elenco con circa 1.300 righe
- **Quando** lo si apre con la registrazione dei tempi attiva
- **Allora** la lettura della struttura (`BuildFields`) dura meno di 50 ms e la query si esegue una volta sola (ticket 183)

## Divergenze note

Punti in cui il codice di oggi non mantiene ciò che i requisiti o i ticket dicono, o in cui un controllo scritto non scatta davvero. Raccolte in R-182; con la correzione il requisito si aggiorna e questa sezione si accorcia.

| Codice | Divergenza | Conseguenza |
|---|---|---|
| DIV-AUT-1 | `CAN_SEE_INCARICHI` (estensore, responsabile del progetto, risorsa, `Incarichi.Visualizzazione`, `Incarichi.Supervisore`) non è usata da nessuna vista, procedura, dataset LZ o unit. Il ticket 184 la indica come la regola di visibilità degli incarichi per responsabile e settore | La visibilità degli incarichi per ruolo o settore non esiste: chi apre un elenco degli incarichi li vede tutti; il settore conta solo per gli avvisi. Va deciso se la regola va applicata o tolta |
| DIV-AUT-2 | L'attivazione con protocollo cambia data e numero del protocollo, e `INCARICHI_BIU0` per quel cambio chiede sempre `Incarichi.Supervisore`. Inoltre la data di attivazione è fra i dati essenziali e, se nel trigger `ATTIVATO` vale già il valore nuovo, anche ogni attivazione chiede `Incarichi.Supervisore` | `Incarichi.Attivazione` da sola non basta ad attivare, almeno gli incarichi con protocollo. Non si vede oggi perché chi attiva (Stefani a CAPAC, Condello a Codebri) ha anche `Incarichi.Supervisore` |
| DIV-AUT-3 | `Incarichi.Attivazione` governa anche la modifica delle richieste altrui non attivate e la ripresentazione delle richieste altrui (`INCARICHI_BIU0`, `INCARICO_RIPRESENTA`) | Il nome dice meno di ciò che permette. Togliere l'attivazione a chi deve "solo inserire" (Galimberti, ticket 183 risposta 3) le toglie anche la correzione delle richieste di altri, per cui le era stata data (ticket 184) |
| DIV-AUT-4 | `INCARICO_AUTORIZZAZIONE_FINANZIARIA` e `INCARICO_AUTORIZZAZIONE_DIREZIONE` non controllano il respingimento | Chiamate su una richiesta `RESPINTO` registrano il passaggio; la richiesta resta respinta, ma alla ripresentazione salta quel passaggio. Dall'elenco non succede (per `RESPINTO` Procedi ripresenta); resta aperto a ogni altro canale |
| DIV-AUT-5 | Il permesso sull'autorizzazione della direzione si controlla solo in modifica (`UPDATING`), e il trigger non verifica che ci sia la finanziaria richiesta: lo fa solo la procedura. La vista `INCARICHI_ELENCO` accetta `TIPO_AUTORIZZAZIONE_DIREZIONE` in inserimento e in modifica | Un inserimento con `'M'` nasce autorizzato dalla direzione senza permesso e senza visto; una modifica diretta del campo da parte di chi ha il permesso salta il visto. In interfaccia il campo è in sola lettura in tutte le schede: il rischio riguarda importazioni e altri canali |
| DIV-AUT-6 | La motivazione obbligatoria è controllata solo dalla procedura guidata, non dal database | Una richiesta esterna inserita da un'altra strada (scheda, importazione) nasce senza motivazione a Codebri |
| DIV-AUT-7 | L'elenco esclude le richieste con inizio e inserimento oltre 365 giorni fa (fino al ticket 326 bastava l'inizio, e una richiesta inserita a posteriori non compariva mai); a Codebri esclude per sempre gli incarichi ai dipendenti, che restano in fase `ATTIVAZIONE` (ticket 281) | Una richiesta vecchia non attivata sparisce da ogni elenco di lavoro senza essere attivata, respinta o chiusa. Per i dipendenti di Codebri va chiesto se ore e stampe dipendono dall'attivazione |
| DIV-AUT-8 | Gli incarichi senza protocollo né contratto si attivano in blocco con la data del giorno, senza finestra. CAPAC chiede la finestra di sempre (ticket 301); la proposta (finestra per tutti, oppure domanda a tre vie) aspetta la scelta del cliente e non è nel codice | Si perde la scelta della data di attivazione: a CAPAC dal 19/10 nessun dipendente è stato attivato (311 in attesa) e l'incarico 505906 ha la data del giorno invece di quella scelta |
| DIV-AUT-9 | Un incarico attivato che richiede il contratto ma non ha nessuna pratica di firma è `IN_CORSO`: non esiste una fase "contratto da generare" (ticket 282) | Se l'anteprima del contratto si chiude senza Firma, l'incarico non compare in nessun elenco di lavoro: a CAPAC 20 casi su 206 dal 01 al 22/10 |
| DIV-AUT-10 | In `INCARICHI_ELENCO` il settore mostrato è quello dell'incarico, ma il responsabile di settore si calcola dal settore del progetto; anche l'avviso di respingimento usa il settore del progetto | Se incarico e progetto hanno settori diversi, l'elenco mostra un responsabile che non è quello del settore indicato. Da verificare sui dati se il caso esiste |
| DIV-AUT-11 | Procedi e `INCARICHI_FASE_ESEGUIBILE` gestiscono le fasi della firma e delle ore residue, ma l'elenco mostra solo incarichi non attivati (dal 19/10, ticket 183) | Quei rami non si raggiungono dall'elenco; la tabella delle fasi del ticket 183 li indica ancora come lavorabili da lì |
| DIV-AUT-12 | `INCARICO_AUTORIZZAZIONE_DIREZIONE` su un incarico non in attesa, e `INCARICO_AUTORIZZAZIONE_FINANZIARIA` su un incarico già vistato o autorizzato dalla direzione, finiscono senza fare nulla e senza messaggio | L'utente conferma, l'elenco si riapre e non capisce perché la richiesta non è cambiata (per esempio una finanziaria su un incarico che la direzione aveva già autorizzato) |

<!-- footer -->
---

[www.zebro.it/gesty](https://www.zebro.it/gesty)
<!-- /footer -->
