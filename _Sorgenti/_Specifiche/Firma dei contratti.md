---
area: Firma dei contratti
progetto: Gesty
aggiornato: 2026-11-12
rilascio: Ticket_Gesty/341 - QUESTIONI DA RISOLVERE/002
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

# Firma dei contratti

Questa specifica descrive le regole che Gesty rispetta quando un contratto (incarico, tipo documento `CON`) o un incarico di massima (tipo documento `CDM`) viene mandato in firma elettronica presso il fornitore (oggi eSignAnyWhere di Namirial), approvato, respinto, inviato, verificato, scaricato nella versione firmata, consultato ed eliminato. Descrive il comportamento atteso, non il codice.

Le regole stanno in tre posti. Nel database: procedure `OBJ_FILES_FIRMA_REGISTRAZIONE_ADD`, `_APPROVA`, `_RESPINGI`, `_ANNULLA`, `_SCADENZA`, `_SCADUTA_PRIMA_INVIO`, `_INVIATA`, `_FIRMATA`, `_SCADUTA`, `_RESPINTA_FORNITORE`, `_ERRORE`, `OBJ_FILES_FIRMA_CONTRATTI_AMMESSA`, `OBJ_FILES_FIRMA_CONTRATTI_FIRMATARI`, `OBJ_FIRME_ELETTRONICHE_CHECK_RISORSA`, `OBJ_FILES_FIRMA_REGISTRAZIONI_ELIMINA`, `OBJECT_DELETE`, trigger `INCARICHI_AD0`, `INCARICHI_DI_MASSIMA_AD0`, `PERSONALE_ELENCO_BIUD0`, `RISORSE_BI0`, vista `OBJ_FILES_ELENCO`. Nel programma: ponte `TDocumentazioneBridgeFirma`, motore `TDocumentazioneFirmaElettronica`, controller `TDocumentazioneReportActionsController` e `TCommon.FirmaElettronicaController`, form `TFormContratti`. In zPack: il fornitore astratto (`zDocumentale.Firma.*`) e la barra delle azioni documentali (`zOffice.Reports.*`).

**Fuori da quest'area**, con una specifica propria quando un lavoro le toccherà: protocollo e conservazione dei documenti (`OBJ_FILES` in generale), invio PEC, fatture, firma delle convenzioni e dei contratti di fornitura (stesso motore, regole non verificate qui), il vecchio circuito di firma `OBJ_FIRME_ELETTRONICHE` (citato solo dove pesa ancora).

**Origine.** Ricavata il 2026-10-30 dai metadati del database master (`GESTY`, fotografia del 2026-10-30 13:19), dalle restrizioni del database `CAPAC` (fotografia del 2026-10-24), dal codice in `D:\AI\SRC\Gesty_Group\_Sorgenti` e `D:\AI\SRC\zPack`, dalle preanalisi dei ticket 61, 66, 84, 87, 90, 92, 107, 111, 130, 185, 194, 222, 227, 232, 254, 289. Le regole non rilette sul codice citano il ticket da cui vengono.

## Stati di una pratica di firma

Ogni invio in firma è una pratica (`OBJ_FILES_FIRMA_REGISTRAZIONI`) legata all'oggetto (`OID`: l'incarico o l'incarico di massima), al tipo documento e al PDF da firmare.

| Codice | Descrizione | Innesco | Transizioni ammesse | Spiegazione logica |
|---|---|---|---|---|
| `I` | Inserita, in approvazione | Firma dall'anteprima del contratto | `A`, `R` | I contratti passano da un controllo interno prima di partire verso il fornitore |
| `A` | Approvata | Approva nella coda "da approvare" | `D`, `R`, `S` | Pronta per l'invio, non ancora partita; si può annullare (`R`) o scade se l'incarico inizia prima dell'invio (`S`) |
| `D` | In firma | Invio riuscito al fornitore | `F`, `R`, `S` | La busta esiste presso il fornitore e aspetta i firmatari |
| `F` | Firmata | Verifica dello stato: busta completata | nessuna | Versione firmata e verbale scaricati |
| `R` | Respinta | Respinta interna, o rifiuto/annullamento presso il fornitore | nessuna | Chiusa: si può aprire una pratica nuova |
| `S` | Scaduta | Verifica dello stato: busta scaduta presso il fornitore; oppure invio di una pratica il cui incarico è già iniziato | nessuna | Chiusa: si può aprire una pratica nuova, ma solo se l'incarico non è ancora iniziato (GESTY-FIR-010) |

## GESTY-FIR-001 La firma dipende dal fornitore dell'ente del documento
La firma è disponibile solo se l'ente a cui appartiene il documento ha un fornitore di firma attivo (`OBJ_FILES_FIRMA_CONFIGURAZIONE.ATTIVO`). L'ente è quello del progetto per un incarico e quello dell'incarico di massima per un incarico di massima (`OBJ_FILES_FIRMA_ENTE_GET`), non l'ente di lavoro dell'utente. Invio e verifica della busta usano le credenziali dell'ente della pratica. La configurazione si rilegge al più una volta al minuto.

### Scenario: ente senza fornitore
- **Dato** un ente senza fornitore di firma attivo
- **Quando** si apre l'anteprima di un suo contratto
- **Allora** il pulsante Firma non compare

### Scenario: contratto di un progetto di un altro ente
- **Dato** un utente che lavora sull'ente 1492 e un contratto di un progetto dell'ente 21020
- **Quando** lo manda in firma
- **Allora** la pratica nasce sull'ente 21020 e parte con le sue credenziali

### Scenario: oggetto senza ente
- **Dato** un documento il cui oggetto non ha un ente
- **Quando** si chiede la firma
- **Allora** l'operazione si ferma con "La firma non e' disponibile per questo documento: l'oggetto non ha un ente"

## GESTY-FIR-002 Da dove parte la firma
La firma di un contratto o di un incarico di massima parte dall'anteprima della stampa (pulsante Stampa della griglia), nel gruppo Documento: le griglie non hanno un pulsante Firma proprio. Il pulsante compare solo se il modello di stampa dichiara, nel suo file `.json` accanto al modello, un profilo documentale che ammette la firma (oggi `"profilo": "CONTRATTO"`) e se l'utente ha il permesso `Report.Azione.Firma`. Prima della firma il documento stampato viene salvato fra gli allegati dell'oggetto, con tipo allegato `Contratto` salvo diversa dichiarazione del modello.

### Scenario: modello senza file di configurazione
- **Dato** un modello di stampa senza il `.json` che ne dichiara il profilo
- **Quando** si apre l'anteprima
- **Allora** il pulsante Firma non compare

## GESTY-FIR-003 Contratto e incarico di massima si distinguono dal modello
Il tipo documento della pratica è `CON` (contratto) se il modello non dichiara altro, `CDM` se il modello lo dichiara con `"tipoDocumento": "CDM"` (con `"tipoAllegato"` per il tipo dell'allegato). Il tipo decide da quale tabella si legge la risorsa: `INCARICHI` per `CON`, `INCARICHI_DI_MASSIMA` per `CDM`. Origine: ticket 90.

### Scenario: anteprima di un incarico di massima
- **Dato** il modello dell'incarico di massima con `"tipoDocumento": "CDM"`
- **Quando** lo si manda in firma
- **Allora** la pratica nasce con tipo documento `CDM` e i controlli leggono la risorsa dall'incarico di massima

## GESTY-FIR-004 Risorse che vogliono il contratto su carta
Una risorsa con il flag firma elettronica spento (`RISORSE.FIRMA_ELETTRONICA = FALSE`) firma su carta: nell'anteprima il pulsante Firma resta visibile ma disabilitato, con il motivo accanto. L'esito si tiene in memoria per 5 secondi, distinto per oggetto e tipo documento: chi accende il flag sulla risorsa lo vede recepito entro pochi secondi, senza riavviare.

### Scenario: risorsa a contratto cartaceo
- **Dato** una risorsa con firma elettronica spenta
- **Quando** si apre l'anteprima del suo contratto
- **Allora** il pulsante Firma è disabilitato con "Questa risorsa richiede il contratto cartaceo"

### Scenario: flag acceso con l'anteprima aperta
- **Dato** l'anteprima di un contratto con il pulsante Firma disabilitato
- **Quando** si accende il flag sulla risorsa e si torna sull'anteprima dopo qualche secondo
- **Allora** il pulsante Firma è attivo

## GESTY-FIR-005 Il flag firma elettronica di un collaboratore nuovo
Un collaboratore creato senza indicare il flag (approvazione di una richiesta di attivazione, candidatura) nasce con la firma elettronica accesa se la sua e-mail, ripulita, è valida per il fornitore (`E_MAIL_VALIDA`), spenta altrimenti. Un valore indicato da chi inserisce resta quello. Un aggiornamento della persona che non riguarda il flag non lo cambia. Vale per i collaboratori, non per le aziende. L'avviso ai sottoscrittori "Attivata Firma Elettronica" parte solo quando il flag viene acceso su una risorsa già esistente, non alla creazione.

### Scenario: richiesta di attivazione con e-mail valida
- **Dato** una richiesta di attivazione con e-mail `mario.rossi@esempio.it`
- **Quando** viene approvata e genera il collaboratore
- **Allora** il collaboratore nasce con la firma elettronica accesa e nessun avviso parte

### Scenario: richiesta di attivazione con e-mail non valida
- **Dato** una richiesta con e-mail `0`
- **Quando** genera il collaboratore
- **Allora** il collaboratore nasce con la firma elettronica spenta

### Scenario: aggiornamento che non tocca il flag
- **Dato** un collaboratore con firma elettronica spenta di proposito
- **Quando** se ne cambia la data di disattivazione
- **Allora** il flag resta spento

## GESTY-FIR-006 Avviso sull'e-mail non utilizzabile
Sulla richiesta di attivazione di una persona, scrivere un'e-mail non valida per il fornitore mostra subito un avviso: la persona, una volta attivata, non potrà firmare elettronicamente e il flag nascerà spento. Sulla scheda della persona, secondo il ticket 107, un'e-mail valida accende il flag, una non valida mostra un avviso e lo spegne, e il flag acceso a mano senza e-mail valida viene respinto; il flag non si riaccende da solo se la persona ha incarichi in corso o futuri (vedi DIV-FIR-1).

### Scenario: e-mail non valida sulla richiesta
- **Dato** una richiesta di attivazione di tipo persona
- **Quando** l'e-mail diventa `elbifood@gmail.com>`
- **Allora** compare l'avviso "L'indirizzo e-mail non è valido per la firma elettronica (formato richiesto dal fornitore di firma): ..."

## GESTY-FIR-007 Una sola pratica in corso per documento
Per lo stesso oggetto e tipo documento può esistere una sola pratica in corso (stato `I`, `A` o `D`), qualunque sia l'ente da cui la si apre. Le pratiche chiuse (`F`, `R`, `S`) non bloccano una pratica nuova. La pratica registra chi l'ha aperta e quando (`USER_ID_VALIDAZIONE`, `DATA_ORA_VALIDAZIONE`).

### Scenario: seconda firma sullo stesso contratto
- **Dato** un contratto con una pratica in stato `D`
- **Quando** lo si manda di nuovo in firma
- **Allora** l'operazione si ferma con "Esiste gia' una pratica di firma in corso per questo documento (Oid <oid>)"

### Scenario: nuova firma dopo una respinta
- **Dato** un contratto con una sola pratica in stato `R`
- **Quando** lo si manda di nuovo in firma
- **Allora** nasce una pratica nuova in stato `I`

## GESTY-FIR-008 Il firmatario del contratto si controlla prima di aprire la pratica
Per `CON` e `CDM`, prima che la pratica nasca e di nuovo al momento dell'invio, la risorsa del contratto deve esistere e avere e-mail presente e in formato valido per il fornitore, telefono (su cui arriva il codice OTP), nome e cognome. Se manca un dato la pratica non nasce. I dati si leggono ripuliti da spazi e caratteri invisibili (GESTY-FIR-013).

### Scenario: e-mail mancante
- **Dato** un collaboratore senza e-mail
- **Quando** si manda in firma il suo contratto
- **Allora** l'operazione si ferma con "Email invio non trovata." e la pratica non nasce

### Scenario: e-mail malformata
- **Dato** un collaboratore con e-mail `CERBONEMARCO@YAHOO.IT PADRE`
- **Quando** si manda in firma il suo contratto
- **Allora** l'operazione si ferma con "Email invio non valida per la firma elettronica." con id risorsa ed e-mail

### Scenario: telefono mancante
- **Dato** un collaboratore senza telefono
- **Quando** si manda in firma il suo contratto
- **Allora** l'operazione si ferma con "Telefono invio non trovata."

## GESTY-FIR-009 Approvazione e respinta interna
Nella form Contratti, la coda "da approvare" elenca le pratiche in stato `I`. Approvare porta la pratica in `A` e registra chi approva e quando. Respingere porta la pratica in `R`, con `RESPINTA` vero, chi respinge e quando. Entrambe le azioni chiedono conferma e lavorano su tutte le righe selezionate, con una barra di avanzamento che si può annullare.

Nella coda "da inviare" (stato `A`) l'azione "Annulla Contratto" porta le pratiche selezionate in `R`, con `RESPINTA` vero, chi annulla, quando e il motivo "Annullata dall'operatore prima dell'invio." (ticket 341). Si annullano solo le pratiche non ancora inviate (`I`, `A`): per una busta già inviata (`D`) la procedura rifiuta l'annullo, perché la busta resterebbe attiva presso il fornitore e il docente potrebbe ancora firmarla.

### Scenario: annullo di un contratto approvato e non inviato
- **Dato** una pratica in stato `A` nella coda "da inviare"
- **Quando** si preme Annulla Contratto e si conferma
- **Allora** passa in `R` con il motivo scritto e un nuovo invio in firma dello stesso contratto è ammesso (GESTY-FIR-007)

### Scenario: annullo di una busta già inviata
- **Dato** una pratica in stato `D`
- **Quando** se ne chiede l'annullo
- **Allora** la procedura si ferma con "Si possono annullare solo le pratiche non ancora inviate a Namirial." e la pratica non cambia

### Scenario: approvazione di due contratti
- **Dato** due pratiche in stato `I` selezionate
- **Quando** si preme Approva e si conferma "Si desidera approvare i 2 contratti selezionati?"
- **Allora** entrambe passano in `A` con l'utente e la data di approvazione

### Scenario: respinta interna
- **Dato** una pratica in stato `I`
- **Quando** la si respinge
- **Allora** passa in `R` e un nuovo invio in firma dello stesso contratto è ammesso (GESTY-FIR-007)

## GESTY-FIR-010 Invio al fornitore
La coda "da inviare" elenca le pratiche in stato `A`. All'invio i firmatari si ricalcolano sui dati di quel momento, nell'ordine: Direttore dell'ente in carica alla data (obbligatorio, firma remota), Legale Rappresentante in carica (se c'è, firma remota), la risorsa del contratto come "Docente" (firma con codice OTP). Si invia solo una pratica approvata. Se l'invio riesce la pratica passa in `D`, conserva l'identificativo della busta e conta un tentativo in più; se il fornitore rifiuta, il messaggio d'errore resta sulla pratica, il tentativo si conta e lo stato non cambia.

**Scadenza della busta (ticket 341).** Per un contratto (`CON`) il docente deve firmare entro l'inizio dell'incarico: la busta scade alle 23:59:59 del giorno di `INCARICHI.DATA_INIZIO_INCARICO`, contate sull'orologio del database dal momento dell'invio. Il tetto è la scadenza configurata nei parametri del fornitore (`EXPIRATION_IN_SECONDS_AFTER_SENDING`, 14 giorni su CAPAC): se l'incarico inizia fra più giorni, vale il tetto. L'incarico di massima (`CDM`) non ha questo limite e usa sempre la scadenza configurata. Con una scadenza più breve di `BEFORE_EXPIRATION_IN_DAYS` + 1 giorni i promemoria del fornitore vengono spenti, perché Namirial altrimenti rifiuta la busta con l'errore ERR0176.

L'incarico non può essere già iniziato (data di inizio precedente a oggi): la pratica non nasce, l'azione Firma si ferma con "L'incarico è già iniziato: il contratto doveva essere firmato entro la data di inizio e non si può più inviare a firma.". Se l'incarico inizia mentre la pratica aspetta (stato `I` o `A`), all'invio la pratica passa in `S` con il messaggio "Scaduta prima dell'invio: l'incarico è iniziato il gg/mm/aaaa e il contratto non è più firmabile. Non è stata inviata a Namirial.", senza chiamare il fornitore; l'invio delle altre pratiche selezionate continua e a fine giro i motivi si mostrano in un solo errore.

### Scenario: incarico che inizia fra poche ore
- **Dato** una pratica in stato `A` per un incarico che inizia oggi
- **Quando** la si invia
- **Allora** la busta parte con scadenza a fine giornata, senza promemoria

### Scenario: incarico già iniziato
- **Dato** una pratica in stato `A` il cui incarico è iniziato ieri
- **Quando** la si invia
- **Allora** passa in `S` con il messaggio di scadenza prima dell'invio e il fornitore non viene chiamato

### Scenario: direttore non in carica
- **Dato** un ente senza direttore in carica alla data odierna
- **Quando** si invia una pratica approvata
- **Allora** l'invio si ferma con "Nessun firmatario dell'ente trovato (direttore non in carica?) (<id>)"

### Scenario: pratica non approvata
- **Dato** una pratica in stato `I`
- **Quando** se ne chiede l'invio
- **Allora** l'invio si ferma con "Il contratto risulta non approvato. (<id>)"

### Scenario: invio riuscito
- **Dato** una pratica in stato `A` con firmatari completi
- **Quando** la si invia
- **Allora** passa in `D` con l'identificativo della busta e stato del fornitore `Sent`

### Scenario: busta rifiutata dal fornitore
- **Dato** un firmatario il cui indirizzo il fornitore non accetta
- **Quando** si invia la pratica
- **Allora** compare l'errore del fornitore, la pratica resta in `A` con il messaggio e un tentativo in più

## GESTY-FIR-011 Verifica dello stato delle buste
"Aggiorna Stato" della form Contratti interroga il fornitore per tutte le pratiche in stato `D`, non solo per quelle selezionate, dopo una conferma che ne indica il numero. Per ogni busta:

| Stato presso il fornitore | Esito su Gesty |
|---|---|
| `Completed` | `F`: versione firmata e verbale scaricati (GESTY-FIR-012) |
| `Rejected`, `Canceled` | `R`: respinta dal firmatario o annullata, senza utente interno; il messaggio riporta lo stato del fornitore |
| `Expired` | `S`, con il messaggio "Scaduta presso Namirial: il docente non ha firmato entro il termine." |
| altro | resta `D`; si aggiorna solo lo stato grezzo del fornitore |

Una pratica che non è in `D` non viene interrogata. Un errore del fornitore resta registrato sulla pratica.

### Scenario: firmatario che rifiuta
- **Dato** una busta che il docente ha rifiutato presso il fornitore
- **Quando** si preme Aggiorna Stato
- **Allora** la pratica passa in `R` con messaggio `Rejected` e senza utente di approvazione (ticket 66)

### Scenario: busta scaduta
- **Dato** una busta scaduta presso il fornitore
- **Quando** si preme Aggiorna Stato
- **Allora** la pratica passa in `S`

## GESTY-FIR-012 Versione firmata e verbale
Quando la busta risulta completata, nella catena del documento originale nascono due versioni nuove: la versione firmata (`FIR`, nome `<originale>_firmato.pdf`) e, come sua figlia, il verbale del fornitore (`RIC`, `<originale>_audit.pdf`). Le versioni ereditano oggetto, tipo allegato, tipologia e profilo documentale del documento originale. La cartella del file si crea se non esiste. La pratica passa in `F` e conserva i due documenti (`ID_OBJECT_FILE_FIRMATO`, `ID_OBJECT_FILE_AUDIT`).

### Scenario: prima firma completata di un documento
- **Dato** una busta completata il cui documento non ha mai avuto versioni
- **Quando** si preme Aggiorna Stato
- **Allora** i due PDF vengono scritti nella cartella del nuovo documento, anche se non esisteva (ticket 87), e la pratica passa in `F`

## GESTY-FIR-013 Recapiti dei firmatari ripuliti
Cognome, nome, e-mail e telefono dei firmatari non contengono spazi ai bordi né caratteri invisibili. Si ripuliscono quando si salvano le anagrafiche (persone, aziende, legali rappresentanti) e di nuovo quando si leggono per la firma, così anche i dati vecchi mai risalvati arrivano puliti al fornitore. La ripulitura non corregge un indirizzo sbagliato (più indirizzi nello stesso campo, segnaposto `0`): quello lo ferma GESTY-FIR-008.

### Scenario: spazio finale nell'e-mail
- **Dato** un collaboratore con e-mail `CHIARA.PEZZANA@CENTROAUTISMO.ORG ` (spazio in coda)
- **Quando** si invia il suo contratto
- **Allora** al fornitore arriva l'indirizzo senza lo spazio e la busta parte (ticket 92)

## GESTY-FIR-014 Registro delle chiamate al fornitore
Ogni chiamata al fornitore (invio `FIRMA`, verifica `STATO`, scaricamento `DOWNLOAD`) lascia una richiesta in `OBJ_FILES_FIRMA_LOG_REQUEST`, scritta prima della chiamata, e la sua risposta in `OBJ_FILES_FIRMA_LOG_RESPONSE`, con codice HTTP ed eventuale errore. Le chiamate fuori da una pratica (prova di connessione) restano senza pratica.

### Scenario: verifica di una busta in firma
- **Dato** una pratica in `D`
- **Quando** si preme Aggiorna Stato
- **Allora** nel registro compare una richiesta `STATO` per quella pratica, con la sua risposta

## GESTY-FIR-015 Quale allegato è "firmato"
Negli elenchi degli allegati, un documento è firmato se è la versione firmata di una pratica in stato `F` oppure il file firmato del circuito storico (`OBJ_FIRME_ELETTRONICHE.ID_FILE_FIRMATO`). Il PDF originale e il verbale non sono "firmati".

### Scenario: contratto firmato col circuito attuale
- **Dato** un incarico con pratica `F`, originale 31877, firmato 32103, verbale 32104
- **Quando** si leggono i suoi allegati
- **Allora** solo il 32103 risulta firmato (ticket 130)

## GESTY-FIR-016 Dove si consultano i contratti firmati
I contratti firmati si consultano in tre punti, che mostrano solo gli allegati firmati (GESTY-FIR-015):
- scheda Risorse, allegati dell'incarico (`Risorse.Incarichi_Allegati`);
- scheda Progetti, allegati degli incarichi dei docenti (`Progetti.Docenti_Incarichi_Allegati`);
- scheda Progetti, "Contratti Firmati Digitalmente": gli incarichi del progetto con una pratica `F` e versione firmata (`Progetti.RiepilogoContrattiFirmatiDigitalmente`), con i loro PDF firmati.

I tre punti e il pulsante "Esporta PDF" sono componenti riservati (`USR_APPS_FORMS_COMPONENTS`): chi ha l'accesso predefinito `X` li vede solo se una sua policy li apre. Su CAPAC li apre la policy `Visualizzazione Contratti Firmati` (gruppo omonimo), oltre a policy di responsabili e amministratori. Le restrizioni si rileggono alla successiva apertura di Gesty. Un contratto non ancora firmato non compare in nessuno dei tre.

### Scenario: responsabile senza abilitazione
- **Dato** un utente con accesso predefinito `X` e nessuna policy che apre gli allegati firmati
- **Quando** apre un incarico in Risorse
- **Allora** non vede la scheda degli allegati firmati

### Scenario: responsabile aggiunto al gruppo
- **Dato** lo stesso utente aggiunto al gruppo `Visualizzazione Contratti Firmati`
- **Quando** riapre Gesty
- **Allora** vede gli allegati firmati in Risorse e il riepilogo con l'esportazione in Progetti (ticket 289)

## GESTY-FIR-017 Esportazione dei PDF firmati
"Esporta PDF" del riepilogo "Contratti Firmati Digitalmente" chiede una cartella e vi copia i PDF firmati di tutti gli incarichi del riepilogo, sovrascrivendo i file con lo stesso nome, poi apre la cartella. Un file che non si trova sul disco viene saltato senza avviso. Il pulsante sta nella barra del riepilogo, dichiarato nel dizionario LZ (ticket 111).

### Scenario: esportazione di un progetto
- **Dato** un progetto con tre incarichi firmati
- **Quando** si preme Esporta PDF e si sceglie una cartella
- **Allora** nella cartella ci sono i tre PDF firmati e la cartella si apre

## GESTY-FIR-018 Estremi della firma nella barra dei documenti
Per un documento con firma completata la barra delle azioni mostra "Vedi estremi - Firma". Gli estremi si leggono una volta per documento selezionato e si rileggono dopo ogni azione o verifica dello stato, non a ogni aggiornamento della barra (ticket 194).

### Scenario: documento firmato aperto a lungo
- **Dato** un documento firmato selezionato in un visualizzatore
- **Quando** la form resta aperta per un minuto
- **Allora** gli estremi della firma si leggono dal database una volta sola

## GESTY-FIR-019 Eliminazione di un incarico con firma
Un incarico con firma conclusa (pratica `F`, oppure qualunque riga del circuito storico) non si elimina. Un incarico senza firma conclusa si elimina insieme alle sue pratiche di firma, con le loro richieste, risposte e firmatari; i documenti prodotti dal flusso di firma (tipo allegato `Contratto`, `Audit Contratto`, `Contratto Firmato`) diventano eliminati e poi si cancellano. Restano bloccanti gli altri allegati non eliminati, che l'utente deve togliere prima. L'eliminazione di un ente intero non passa da questo controllo.

### Scenario: incarico firmato
- **Dato** un incarico con una pratica in stato `F`
- **Quando** lo si elimina
- **Allora** l'eliminazione si ferma con "Impossibile eliminare: incarico già firmato."

### Scenario: incarico inviato in firma ma non firmato
- **Dato** un incarico con una pratica in `D`, cinque richieste al fornitore registrate e il `Contratto.pdf` generato
- **Quando** lo si elimina
- **Allora** l'incarico, la pratica con il suo registro e il documento spariscono (ticket 222, 227)

### Scenario: allegato caricato a mano
- **Dato** un incarico non firmato con un allegato di tipo diverso da quelli del flusso di firma
- **Quando** lo si elimina
- **Allora** l'eliminazione si ferma con "Impossibile eliminare: all'elemento sono ancora collegati documenti allegati. Rimuoverli prima di procedere."

## GESTY-FIR-020 Eliminazione di un incarico di massima
Eliminare un incarico di massima cancella le sue pratiche di firma con richieste, risposte e firmatari. Non c'è controllo sulla firma conclusa e i documenti generati non vengono marcati come eliminati (vedi DIV-FIR-3).

### Scenario: incarico di massima mai mandato in firma
- **Dato** un incarico di massima senza pratiche e senza allegati
- **Quando** lo si elimina
- **Allora** l'eliminazione riesce

## GESTY-FIR-021 Conservazione dei documenti firmati
Gesty non versa i documenti firmati in conservazione presso Namirial: il versamento è un'elaborazione notturna di Namirial, impostata sull'account del cliente. Un errore di quel versamento ("lavoro di versamento ... Execution Timeout Expired") si segnala all'assistenza Namirial; i documenti firmati restano in Gesty. Origine: ticket 232.

### Scenario: errore del versamento notturno
- **Dato** una mail di Namirial Archive su un lavoro di versamento fallito
- **Quando** il cliente la inoltra
- **Allora** non c'è nulla da correggere in Gesty: il lavoro va fatto ripetere a Namirial

## GESTY-FIR-022 Avviso dei contratti non firmati all'inizio dell'incarico
Ogni notte la procedura `CRON` richiama `CRON_VERIFICA_CONTRATTI_NON_FIRMATI` (ticket 341). Un contratto (`CON`) è "non firmato" se per l'incarico esiste almeno una pratica di firma e nessuna è conclusa (stato `F`): vale quindi anche per una pratica scaduta (`S`) o respinta (`R`) che nessuno ha rimandato in firma, oltre che per quelle in approvazione (`I`), approvate ma non inviate (`A`) o in attesa del docente (`D`). Gli incarichi respinti non contano. Dopo mezzogiorno il controllo guarda gli incarichi che iniziano il giorno dopo, così l'avviso è già visibile la mattina in cui il docente deve firmare; prima di mezzogiorno guarda quelli che iniziano oggi. Se il giorno controllato è un sabato, l'elenco arriva fino al lunedì. L'avviso (`CONTRATTI_NON_FIRMATI`) va a chi lo ha sottoscritto, con l'elenco di docente, progetto, data di inizio e stato della pratica (fino a trenta righe, poi solo il numero degli altri); lo stesso elenco non si ripete nello stesso giorno. Non si avvisano i contratti mai messi in firma: per l'incarico non esiste nessuna pratica, quindi non si può sapere se un contratto era dovuto.

### Scenario: contratto inviato e non ancora firmato
- **Dato** un incarico che inizia domani con una pratica in stato `D`
- **Quando** gira la `CRON` di notte
- **Allora** i sottoscrittori ricevono l'avviso "Contratti con firma digitale non firmati: 1" con il nome del docente

### Scenario: contratto firmato in tempo
- **Dato** un incarico che inizia domani con una pratica in stato `F`
- **Quando** gira la `CRON`
- **Allora** nessun avviso

### Scenario: busta scaduta e mai rimandata
- **Dato** un incarico che inizia domani la cui unica pratica è in stato `S`
- **Quando** gira la `CRON`
- **Allora** l'avviso lo elenca come "busta scaduta, da rimandare in firma"

## Divergenze note

Punti in cui il codice o i dati di oggi non mantengono ciò che i requisiti o i ticket dicono, o in cui due parti applicano la stessa regola in modo diverso. Raccolti in R-180. Con la correzione il requisito si aggiorna e questa sezione si accorcia.

| Codice | Divergenza | Conseguenza |
|---|---|---|
| DIV-FIR-1 | Il rilascio 002 del ticket 107 (registrato "fuso a mano" il 2026-10-07) contiene in `dmRisorse.pas` la coerenza fra e-mail e flag sulla scheda persona. Il `dmRisorse.pas` di `SRC`, datato 2026-10-08, non contiene nessuna di quelle righe; `dmRichiesteAttivazione.pas` invece sì | Sulla scheda persona l'avviso e lo spegnimento del flag di GESTY-FIR-006 probabilmente non ci sono: la modifica può essere stata persa da una versione successiva del file. Va controllata la produzione |
| DIV-FIR-2 | Il meccanismo di GESTY-FIR-003 c'è nel codice, ma in `SRC\Gesty_Group\Reports_CAPAC\__Shared` non esiste `Incarico di massima - Versione 4.json`: hanno il `.json` solo i tre modelli Contratto e "Contratto Versioni Precedenti" | Se la cartella dei modelli del cliente è come la copia, dall'anteprima di un incarico di massima il pulsante Firma non compare (ticket 90). Senza `"tipoDocumento": "CDM"` una firma partita comunque nascerebbe come `CON` e leggerebbe la risorsa dall'incarico con lo stesso numero |
| DIV-FIR-3 | `INCARICHI_DI_MASSIMA_AD0` ha la correzione del ticket 222 (registro cancellato) ma non quelle del 227: nessun blocco "già firmato", nessun documento del flusso marcato eliminato | Un incarico di massima firmato si elimina insieme alla sua pratica `F`, se non ha allegati; uno con il documento generato non si elimina mai, con il messaggio "documenti allegati" che l'utente non può risolvere |
| DIV-FIR-4 | Il flag firma elettronica della risorsa (GESTY-FIR-004) è controllato solo dal pulsante Firma dell'anteprima, nel programma. `OBJ_FILES_FIRMA_REGISTRAZIONE_ADD` e l'invio non lo leggono; il controller dei visualizzatori generici (`Common.DocumentAzioniController`) non ha quel controllo, non ha tipo documento e non passa dall'approvazione interna | Un flag spento dopo l'apertura della pratica non ferma l'invio; una firma chiesta da un visualizzatore di allegati salterebbe controllo, coda di approvazione e firmatari dei contratti (da verificare sul banco) |
| DIV-FIR-5 | Il controllo di formato dell'e-mail (GESTY-FIR-008) vale solo per la risorsa del contratto. Direttore e Legale Rappresentante si leggono ripuliti ma senza `E_MAIL_VALIDA` | Un indirizzo malformato del direttore fa respingere l'intera busta dal fornitore con un errore che non dice quale firmatario è sbagliato (ticket 92) |
| DIV-FIR-6 | Le procedure che cambiano stato (`_APPROVA`, `_RESPINGI`, `_INVIATA`, `_FIRMATA`, `_SCADUTA`) non controllano lo stato di partenza; le transizioni della matrice le garantiscono solo le code della form Contratti e il controllo di `OBJ_FILES_FIRMA_CONTRATTI_FIRMATARI` all'invio | Un'altra via (script, servizio, motore generico) può approvare una pratica già in firma o respingerne una firmata |
| DIV-FIR-7 | La respinta interna (`TContratti.Respingi`) non chiede il motivo: passa una stringa vuota e `OBJ_FILES_FIRMA_REGISTRAZIONE_RESPINGI` la scrive in `MESSAGGIO` | Il motivo del rifiuto non resta da nessuna parte, e un eventuale messaggio d'errore precedente sulla pratica si perde |
| DIV-FIR-8 | `INCARICHI_AD0` considera "già firmato" un incarico con qualunque riga in `OBJ_FIRME_ELETTRONICHE`, in qualunque stato; per il circuito attuale guarda solo lo stato `F` | Un incarico con una pratica del vecchio circuito mai firmata si rifiuta di eliminarsi con un messaggio non vero. Inoltre l'eliminazione di un incarico con pratica in `D` non annulla la busta presso il fornitore |
| DIV-FIR-9 | Le versioni firmata e verbale (GESTY-FIR-012) si registrano e si confermano prima dello scaricamento dei file. Se lo scaricamento fallisce la pratica resta in `D` con le due righe già scritte, e la verifica successiva ne crea altre due | Restano allegati senza file sul disco nella catena del documento, uno per ogni tentativo fallito |
| DIV-FIR-10 | Su CAPAC la policy `Visualizzazione Contratti Firmati` apre allegati firmati di Risorse, riepilogo ed esportazione, ma non `Progetti.Docenti_Incarichi_Allegati`; la richiesta del ticket 289 era "visionare", la policy dà `W` | Chi è nel gruppo non vede i contratti firmati dalla scheda docenti del progetto; può modificarne o cancellarne le righe se il dataset lo permette |
| DIV-FIR-11 | Nella verifica dello stato (GESTY-FIR-011) un errore su una busta interrompe il giro: le pratiche successive non vengono interrogate. Lo stesso errore incrementa `TENTATIVI`, che conta così anche le verifiche e non solo gli invii | Una busta problematica blocca l'aggiornamento di tutte le altre fino a quando non si risolve; il numero dei tentativi non dice più quante volte si è provato a inviare |
| DIV-FIR-12 | I messaggi di `OBJ_FIRME_ELETTRONICHE_CHECK_RISORSA` dicono "Telefono invio non trovata." e "Nominativo legale rappresentante non trovata." anche quando il firmatario è un collaboratore | L'operatore cerca il dato sbagliato nell'anagrafica sbagliata |
| DIV-FIR-13 | Il legame fra scadenza della busta e inizio dell'incarico (GESTY-FIR-010) vale per i contratti `CON`. L'incarico di massima (`CDM`) non ha una data di inizio sul documento e conserva la scadenza fissa del fornitore (`EXPIRATION_IN_SECONDS_AFTER_SENDING`: 14 giorni su CAPAC) | Un incarico di massima può essere firmato anche dopo l'inizio delle attività che copre. Se serve, la regola va estesa quando si stabilisce da quale data far dipendere la scadenza |

<!-- footer -->
---

[www.zebro.it/gesty](https://www.zebro.it/gesty)
<!-- /footer -->
