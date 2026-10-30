---
area: Richieste di attivazione
progetto: Gesty
aggiornato: 2026-10-30
rilascio: OUT/20261030-specifiche-vive-dei-progetti/008
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

# Richieste di attivazione

Questa specifica descrive le regole che Gesty rispetta quando si chiede di attivare un collaboratore o un'azienda fornitrice (tabella `RICHIESTE_ATTIVAZIONE`): inserimento con la procedura guidata "Nuova Richiesta Attivazione", convalida, approvazione, generazione della risorsa, data di attivazione e firma elettronica della risorsa che nasce. Descrive il comportamento atteso, non il codice. Le regole stanno in parte nel database (procedure `RICHIESTE_ATTIV_CHECK_COD_FISC`, `RICHIESTE_ATTIV_CAMPI_NOT_NULL`, `RICHIESTE_ATTIV_VERIFICA_ALLEG`, `RICHIESTA_ATTIVAZIONE_CONVALIDA`, `RICHIESTA_ATTIVAZIONE_APPROVA`, `RICHIESTA_ATTIVAZIONE_GENERA`, `RICHIESTA_ATTIV_GENERA_RISORSA`, `RICHIESTE_ATTIV_COPIA_FILE`; trigger `RICHIESTE_ATTIVAZIONE_BI0`, `RICHIESTE_ATTIVAZIONE_BU0`, `RICHIESTE_ATTIV_ELENCO_BIUD0`, `PERSONALE_ELENCO_BIUD0`, `RISORSE_BI0`, `RISORSE_AU0`; vista `RICHIESTE_ATTIVAZIONE_ELENCO`) e in parte nella procedura guidata e nel modulo Richieste Attivazione (`WizNuovaRichiestaAttivazioneDM`, `WizNuovaRichiestaAttivazioneFrm`, `dmRichiesteAttivazione`, dizionario LZ `RichiesteAttivazione`). Le regole del database valgono per ogni canale; quelle dell'interfaccia valgono solo dove sono indicate.

**Fuori da quest'area**, con una specifica propria quando un lavoro le toccherà: candidature (`CANDIDATURE_GENERA_RISORSA`), inserimento manuale di una persona o di un'azienda dalla scheda Risorse, gestione degli inquadramenti e degli incarichi dopo la generazione, invio dei documenti alla firma elettronica.

**Origine.** Ricavata il 2026-10-30 dal codice del database master (fotografia dei metadati del 2026-10-30), dai sorgenti in `SRC` e dal dizionario `GESTY.LZ` dello stesso giorno, con i conteggi letti sul database CAPAC (fotografia del 2026-10-24) e le preanalisi dei ticket 39, 107, 132, 223, 236. Ogni regola è stata riletta sul codice; dove la fonte è solo un ticket, il requisito lo dice.

## GESTY-ATT-001 Chi vede le richieste
Un utente vede le richieste di cui è il richiedente (la risorsa collegata al suo utente) e, se ha almeno una delle autorizzazioni `RichiesteAttivazione.Inserimento`, `RichiesteAttivazione.Valutazione`, `RichiesteAttivazione.Approvazione`, vede tutte le richieste. Il filtro sta nella vista, quindi vale per ogni elenco, per la procedura guidata e per le stampe che la usano.

### Scenario: richiedente senza autorizzazioni
- **Dato** un utente senza nessuna delle tre autorizzazioni, collegato alla risorsa 120
- **Quando** apre l'elenco delle richieste
- **Allora** vede solo le richieste con richiedente 120

## GESTY-ATT-002 Autorizzazioni per ogni passaggio
Ogni passaggio richiede un'autorizzazione propria, controllata dal database:

| Passaggio | Autorizzazione |
|---|---|
| Inserire una richiesta nuova | `RichiesteAttivazione.Inserimento` |
| Convalidare o dichiarare non valida | `RichiesteAttivazione.Valutazione` |
| Approvare o respingere | `RichiesteAttivazione.Approvazione` |
| Generare la risorsa | `RichiesteAttivazione.Valutazione` e `RichiesteAttivazione.Approvazione` |
| Modificare una richiesta già approvata | `RichiesteAttivazione.Approvazione` |

La generazione chiede entrambe perché la procedura controlla la prima e la scrittura del collegamento alla risorsa su una richiesta approvata fa scattare il controllo della seconda.

### Scenario: approvazione senza autorizzazione
- **Dato** un utente con `RichiesteAttivazione.Valutazione` ma senza `RichiesteAttivazione.Approvazione`
- **Quando** approva una richiesta convalidata
- **Allora** l'operazione si ferma con l'errore di autorizzazione

## GESTY-ATT-003 Stati e percorso della richiesta
Una richiesta passa per questi stati (`STATO_RICHIESTA`):

| Codice | Stato | Come ci si arriva | Elenco in cui compare |
|---|---|---|---|
| `I` | Inserita | inserimento o reinserimento dalla procedura guidata | Da validare |
| `V` | Validata | convalida | Da approvare |
| `N` | Non valida | dichiarata non valida in convalida | Elenco generale |
| `A` | Approvata | approvazione | Da generare finché la risorsa non esiste, poi elenco generale |
| `R` | Respinta | respingimento in approvazione | Elenco generale |

Una richiesta approvata non si convalida né si approva di nuovo ("La richiesta attivazione risulta già approvata."). La risorsa si genera solo da una richiesta approvata e una volta sola ("La richiesta attivazione non risulta approvata.", "La risorsa risulta già generata."). L'ordine Inserita → Validata → Approvata lo impongono gli elenchi, non le procedure (DIV-ATT-11).

### Scenario: seconda generazione
- **Dato** una richiesta approvata da cui la risorsa è già stata generata
- **Quando** si chiede di generarla di nuovo
- **Allora** l'operazione si ferma con "La risorsa risulta già generata."

## GESTY-ATT-004 Richiedente ed esigenza obbligatori
Nella prima pagina della procedura guidata servono il richiedente (proposto: la risorsa dell'utente) e il testo dell'esigenza, scritto a mano o scelto fra i testi predefiniti. Senza uno dei due la procedura non va avanti. Fonte del caso concreto: ticket 39, dove l'avviso è stato preso per un errore del programma e segnalato.

### Scenario: esigenza vuota
- **Dato** la prima pagina della procedura guidata con l'esigenza vuota
- **Quando** si preme Continua
- **Allora** compare "Esigenza non specificata." e la procedura resta sulla prima pagina

### Scenario: richiedente vuoto
- **Dato** la prima pagina con il richiedente cancellato
- **Quando** si preme Continua
- **Allora** compare "Richiedente non specificato."

## GESTY-ATT-005 Codice fiscale e partita IVA
Prima di proseguire la procedura controlla il codice fiscale e la partita IVA (pulsante Verifica, e di nuovo al passaggio alla pagina successiva):

- per una persona il codice fiscale è obbligatorio e deve essere valido;
- per un'azienda la partita IVA è obbligatoria; se manca il codice fiscale vale la partita IVA, e un codice fiscale formalmente non valido è accettato se la partita IVA è valida;
- non si attiva una persona il cui codice fiscale, o la cui partita IVA, è già nel personale;
- non si attiva un'azienda già presente in anagrafica con lo stesso codice fiscale **e** la stessa partita IVA. Un'azienda ospitante che deve diventare fornitrice si completa dalla sua scheda, non con una richiesta (ticket 223).

### Scenario: persona già nel personale
- **Dato** un collaboratore già presente con codice fiscale RSSMRA80A01F205X
- **Quando** si avvia una richiesta per lo stesso codice fiscale
- **Allora** compare "Codice fiscale già presente nel personale." e la procedura resta sulla prima pagina

### Scenario: azienda già presente
- **Dato** un'azienda ospitante con codice fiscale e partita IVA 01234567890
- **Quando** si avvia una richiesta di tipo azienda con gli stessi valori
- **Allora** compare "Codice fiscale/partita iva già presenti in aziende."

### Scenario: azienda senza partita IVA
- **Dato** una richiesta di tipo azienda
- **Quando** si prosegue senza partita IVA né codice fiscale
- **Allora** compare "Partita Iva non specificato per l'azienda."

## GESTY-ATT-006 Richiesta già presente per la stessa persona
Se esiste già una richiesta con lo stesso codice fiscale, la procedura non ne crea una seconda: riapre quella esistente, la riporta a Inserita e ne aggiorna richiedente, esigenza e data della richiesta (oggi). Gli altri dati restano quelli già scritti e si correggono nelle pagine successive.

### Scenario: reinserimento di una richiesta respinta
- **Dato** una richiesta respinta per il codice fiscale RSSMRA80A01F205X
- **Quando** si avvia una nuova richiesta con lo stesso codice fiscale
- **Allora** si riapre la richiesta esistente, che torna nello stato Inserita con la data di oggi

## GESTY-ATT-007 Dati obbligatori e valori proposti
I dati obbligatori dipendono dal tipo (`RICHIESTE_ATTIV_CAMPI_NOT_NULL`): per tutti esigenza, codice fiscale, tipo di inquadramento e tipologia di fornitore; per una persona anche cognome, nome, dipendente pubblico, indirizzo completo di residenza, sesso, data e luogo di nascita, stato di nascita e titolo di studio; per un'azienda anche partita IVA, ragione sociale, sede legale e sede operativa complete, cognome, nome, codice fiscale, luogo e data di nascita del legale rappresentante. Su una richiesta nuova la procedura propone il tipo di inquadramento predefinito per il tipo di risorsa (`GET_INQUADRAMENTO_DEFAULT`) e, per una persona con codice fiscale valido, ricava sesso, data, luogo e stato di nascita e cittadinanza.

### Scenario: dati ricavati dal codice fiscale
- **Dato** una richiesta nuova di tipo persona con codice fiscale valido
- **Quando** si passa alla pagina dei dati anagrafici
- **Allora** sesso, data di nascita, comune, stato di nascita e cittadinanza sono già compilati

## GESTY-ATT-008 Allegati obbligatori
La procedura guidata non si chiude con Fine finché mancano gli allegati richiesti (`RICHIESTE_ATTIV_VERIFICA_ALLEG`), e li elenca ("Mancano i seguenti allegati: ..."). Ogni allegato deve avere il tipo. Quali tipi servono lo dice la tabella dei tipi di allegato (`ZZ_TIPO_ALLEGATI`): quelli per le persone, quelli in più per le persone che hanno bisogno del permesso di soggiorno, quelli per le aziende, quelli per il casellario giudiziario quando è stato fornito un certificato o una dichiarazione. Gli allegati di una richiesta annullata con Annulla non restano, perché la procedura lavora in una transazione sola che si conferma solo con Fine.

Nella configurazione di CAPAC servono per le persone curriculum, scheda fiscale e codice fiscale; per le aziende visura camerale, scheda fiscale e consenso al trattamento (ticket 223). Le regole sul permesso di soggiorno e sul casellario non scattano mai (DIV-ATT-3, DIV-ATT-4).

### Scenario: curriculum mancante
- **Dato** una richiesta di tipo persona con scheda fiscale e codice fiscale allegati, senza curriculum
- **Quando** si preme Fine
- **Allora** compare "Mancano i seguenti allegati:" seguito da "CURRICULUM VITAE" e la procedura resta aperta

## GESTY-ATT-009 Avviso sull'e-mail non utilizzabile per la firma
Sulla richiesta di una persona non c'è la casella della firma elettronica: la decide la generazione (GESTY-ATT-015). Quando si scrive un'e-mail che il servizio di firma non accetterebbe (`E_MAIL_VALIDA` sul testo ripulito, come all'invio), compare subito un avviso che la persona nascerà con la firma elettronica spenta. L'avviso non blocca il salvataggio. Oggi compare solo nell'elenco generale e nell'elenco delle richieste da approvare del modulo Richieste Attivazione (DIV-ATT-8).

### Scenario: e-mail con due indirizzi
- **Dato** una richiesta di tipo persona nell'elenco da approvare
- **Quando** si scrive come e-mail "mario.rossi@ente.it; m.rossi@casa.it"
- **Allora** compare l'avviso che l'indirizzo non è valido per la firma elettronica e che il flag nascerà spento
- **E** il valore si può salvare lo stesso

## GESTY-ATT-010 Convalida
Dall'elenco delle richieste da validare si convalida una richiesta o la si dichiara non valida. In entrambi i casi si scrive l'esito della valutazione (si può annullare, e allora non cambia nulla); la data della valutazione è quella di oggi.

### Scenario: richiesta non valida
- **Dato** una richiesta inserita
- **Quando** la si dichiara non valida e si conferma la motivazione
- **Allora** la richiesta passa a Non valida, con data di valutazione di oggi e la motivazione come esito

## GESTY-ATT-011 Approvazione e data di attivazione
Dall'elenco delle richieste da approvare si approva una richiesta convalidata scrivendo l'esito (annullando non cambia nulla). La data di approvazione è quella di oggi. La data di attivazione, che diventerà la data di attivazione della risorsa, è nell'ordine:

1. quella scritta sulla scheda della richiesta, che nell'elenco da approvare è modificabile;
2. se manca, la data limite di approvazione;
3. se manca anche quella, la data di oggi.

L'approvazione non chiede più la data in una finestra a parte (tolta su richiesta il 07/06/2023): si scrive sulla scheda prima di premere Approva (ticket 132).

### Scenario: data scritta dall'operatore
- **Dato** una richiesta convalidata con data limite di approvazione 30/11/2025
- **Quando** l'operatore scrive 11/11/2025 come data di attivazione e approva
- **Allora** la richiesta è approvata con data di attivazione 11/11/2025

### Scenario: nessuna data
- **Dato** una richiesta convalidata senza data di attivazione né data limite
- **Quando** viene approvata
- **Allora** la data di attivazione è quella di oggi

## GESTY-ATT-012 Respingimento
Dall'elenco delle richieste da approvare si respinge una richiesta scrivendo la motivazione. La richiesta passa a Respinta, con data di approvazione di oggi; la data di attivazione eventualmente scritta resta sulla richiesta. Una richiesta respinta si ripresenta solo con un reinserimento (GESTY-ATT-006).

### Scenario: respingimento
- **Dato** una richiesta convalidata
- **Quando** viene respinta con motivazione "Profilo non adeguato"
- **Allora** passa a Respinta con quell'esito e non compare più fra le richieste da approvare

## GESTY-ATT-013 Generazione della risorsa
Dall'elenco delle richieste da generare (approvate e senza risorsa) si genera la risorsa, dopo una conferma. Nascono:

- per una persona, l'anagrafica e il collaboratore con i dati della richiesta, compresa la tipologia di fornitore;
- per un'azienda, la risorsa e l'azienda con i dati della richiesta; e-mail e telefono valgono anche come recapiti per la firma elettronica; se è indicato il legale rappresentante, nasce come contatto attivo dell'azienda e ne diventa il legale rappresentante;
- per entrambe: i tipi di fornitura, le competenze, i settori, l'inquadramento del tipo indicato (con le condizioni predefinite di quel tipo) e gli allegati della richiesta.

Subito dopo si apre la scheda dell'inquadramento appena creato, per completarlo. La generazione si rifiuta se nel frattempo la persona o l'azienda è stata inserita in altro modo (DIV-ATT-7 per il criterio).

### Scenario: generazione di un collaboratore
- **Dato** una richiesta approvata di tipo persona, con due competenze e un tipo di fornitura
- **Quando** si genera la risorsa
- **Allora** nasce il collaboratore con le due competenze, il tipo di fornitura e l'inquadramento del tipo indicato
- **E** la richiesta esce dall'elenco da generare e porta il collegamento alla risorsa
- **E** si apre la scheda dell'inquadramento

## GESTY-ATT-014 Date della risorsa generata
La risorsa nasce con la data di attivazione della richiesta e senza data di disattivazione (31/12/9999); l'inquadramento vale dalla stessa data. Finché la risorsa non è generata, la data si corregge sulla scheda della richiesta nell'elenco da generare. I tipi di fornitura valgono invece dal giorno della generazione.

### Scenario: data di attivazione passata
- **Dato** una richiesta approvata con data di attivazione 01/09/2026, generata il 15/09/2026
- **Quando** si apre la risorsa
- **Allora** data di attivazione e inizio dell'inquadramento sono 01/09/2026
- **E** i tipi di fornitura valgono dal 15/09/2026

## GESTY-ATT-015 Firma elettronica della risorsa generata
Un collaboratore generato da una richiesta nasce con la firma elettronica attiva se la sua e-mail è valida per il servizio di firma (`E_MAIL_VALIDA` sul testo ripulito), spenta altrimenti. Un'azienda generata da una richiesta nasce sempre con la firma elettronica spenta. La nascita della risorsa non invia la notifica "Attivata Firma Elettronica": la notifica parte solo quando la firma viene accesa su una risorsa già esistente (ticket 107, decisioni 1, 3 e 4, rilette sul database master).

### Scenario: e-mail valida
- **Dato** una richiesta approvata di tipo persona con e-mail mario.rossi@ente.it
- **Quando** si genera la risorsa
- **Allora** il collaboratore ha la firma elettronica attiva e nessuna notifica viene inviata

### Scenario: e-mail mancante
- **Dato** una richiesta approvata di tipo persona senza e-mail
- **Quando** si genera la risorsa
- **Allora** il collaboratore ha la firma elettronica spenta

### Scenario: azienda
- **Dato** una richiesta approvata di tipo azienda con e-mail valida
- **Quando** si genera la risorsa
- **Allora** l'azienda ha la firma elettronica spenta

## GESTY-ATT-016 Allegati portati nella risorsa
Gli allegati della richiesta che non sono annullati vengono registrati anche sulla risorsa e i file vengono copiati nella cartella della risorsa; un file d'origine che non si trova più sul disco viene saltato senza avviso, un file già presente a destinazione non viene sovrascritto.

### Scenario: allegati alla generazione
- **Dato** una richiesta con curriculum e scheda fiscale allegati
- **Quando** si genera la risorsa
- **Allora** la risorsa ha gli stessi due allegati, con lo stesso tipo, e i file sono nella sua cartella

## GESTY-ATT-017 Data di attivazione dopo la generazione
Dopo la generazione la data di attivazione vive sulla risorsa: sulla richiesta resta come dato storico, non è più modificabile dall'elenco generale e un suo cambio non arriverebbe alla risorsa. Si corregge dalla scheda della risorsa, con l'autorizzazione `Risorse.Responsabile`. Quando cambia, l'inquadramento che cominciava alla vecchia data si sposta alla nuova, se a quella data non ne comincia già un altro. Un inquadramento non può cominciare prima dell'attivazione, e un incarico nemmeno ("La risorsa non risulta attivata alla data di inizio incarico."). Caso concreto: ticket 236.

### Scenario: data anticipata dalla scheda della risorsa
- **Dato** una risorsa generata con data di attivazione 09/09/2026 e inquadramento dal 09/09/2026
- **Quando** un utente con `Risorse.Responsabile` porta la data al 07/09/2026
- **Allora** anche l'inquadramento comincia il 07/09/2026

### Scenario: senza autorizzazione
- **Dato** la stessa risorsa e un utente senza `Risorse.Responsabile`
- **Quando** cambia la data di attivazione
- **Allora** il salvataggio si ferma con l'errore di autorizzazione

## Divergenze note

Punti in cui il codice di oggi non mantiene ciò che i requisiti dicono, in cui due parti del codice applicano la stessa regola in modo diverso, o in cui un controllo scritto non scatta. Raccolti in R-179 di `Attivita Rinviate.md`; con la correzione il requisito si aggiorna e questa sezione si accorcia.

| Codice | Divergenza | Conseguenza |
|---|---|---|
| DIV-ATT-1 | Il reinserimento (GESTY-ATT-006) riapre la richiesta con lo stesso codice fiscale in qualunque stato e la riporta a Inserita. Il controllo `RICHIESTE_ATTIVAZIONE_BU0` scatta solo quando il nuovo stato è Approvata e `RICHIESTE_ATTIVAZIONE_BI0` solo sull'inserimento: riportare a Inserita non chiede nessuna autorizzazione | Un utente con la sola autorizzazione di inserimento può riportare indietro una richiesta approvata e non ancora generata, senza avviso. Oggi su CAPAC non ce ne sono (0 approvate senza risorsa), ma il caso esiste fra l'approvazione e la generazione |
| DIV-ATT-2 | Il reinserimento non svuota data di approvazione, esiti e data limite. All'approvazione successiva, se la data di attivazione è vuota, `ApprovaRichiestaAttivazione` usa la vecchia data di approvazione, cioè il giorno del respingimento, prima della data limite e di oggi | Una persona respinta e poi riproposta può essere attivata con la data del vecchio respingimento, anche mesi prima |
| DIV-ATT-3 | "Permesso di soggiorno richiesto" (`PERMESSO_DI_SOGGIORNO_RICHIESTO`) è nascosto nella procedura guidata e visibile nella scheda di convalida, ma il trigger della vista `RICHIESTE_ATTIV_ELENCO_BIUD0` non lo scrive né in inserimento né in modifica | Il valore resta sempre falso (CAPAC: 1.677 richieste su 1.677): gli allegati previsti per chi ha bisogno del permesso non vengono mai chiesti e il collaboratore generato nasce sempre senza il flag. Chi lo spunta in convalida lo vede sparire al salvataggio |
| DIV-ATT-4 | In `RICHIESTE_ATTIV_VERIFICA_ALLEG` la condizione sul casellario è un'uguaglianza (`RICHIESTE_CASELLARIO_GIUDIZIARIO = (CASELLARIO IN ('C','D'))`), non "anche questi se fornito": con certificato o dichiarazione restano richiesti solo i tipi marcati per il casellario | A CAPAC nessun tipo è marcato per il casellario: per le richieste con casellario C o D non è richiesto **nessun** allegato, nemmeno curriculum o visura (oggi 98 persone e 3 aziende); con casellario O o N il casellario non è mai richiesto |
| DIV-ATT-5 | Al passaggio dalla pagina degli allegati la procedura guidata verifica gli allegati e prova a restare sulla pagina assegnando `ANewPage`, che però arriva per valore: il passaggio avviene lo stesso | L'avviso compare ma la procedura va avanti; il blocco vero c'è solo su Fine (GESTY-ATT-008), dove l'utente lo scopre a lavoro finito |
| DIV-ATT-6 | In `RICHIESTE_ATTIV_CHECK_COD_FISC` la ricerca della richiesta già presente per partita IVA non si esegue mai: la prima ricerca restituisce -1 e non nullo, e la seconda parte solo se il valore è nullo. La ricerca per codice fiscale è inoltre a valore singolo | Un'azienda già richiesta con un codice fiscale diverso ma la stessa partita IVA genera una seconda richiesta. Con due richieste per lo stesso codice fiscale la procedura si fermerebbe con l'errore di Firebird "multiple rows in singleton select": a CAPAC i codici fiscali con più richieste sono 28, oggi mascherati perché la persona è già nel personale e il controllo precedente si ferma prima |
| DIV-ATT-7 | Il controllo di duplicato della persona è diverso nei due momenti: la procedura guidata rifiuta lo stesso codice fiscale (dal 06/06/2024, partita IVA a parte), la generazione solo lo stesso codice fiscale **con** la stessa partita IVA. Il ticket 223 descrive il controllo delle aziende come "codice fiscale già presente", mentre il codice chiede codice fiscale e partita IVA uguali | Una persona inserita a mano fra approvazione e generazione con una partita IVA diversa non ferma la generazione. Un'azienda con lo stesso codice fiscale e partita IVA diversa (o mancante) passa il controllo |
| DIV-ATT-8 | L'avviso sull'e-mail (GESTY-ATT-009) è agganciato solo ai dataset `Richieste_Attivazione` e `RichiesteDaApprovare` del modulo Richieste Attivazione, non alla procedura guidata (dove l'e-mail si scrive), né agli elenchi da validare e da generare. La nota al cliente del ticket 107 dice che il programma "avvisa subito" | Chi inserisce la richiesta non vede l'avviso; lo vede solo chi corregge l'e-mail in approvazione. Va verificato sul banco se nell'elenco generale l'e-mail è modificabile |
| DIV-ATT-9 | L'azione "Ricopia allegati nella risorsa" sta sugli allegati dell'elenco da generare, che contiene solo richieste senza risorsa: `RICHIESTE_ATTIV_COPIA_FILE` e `RICHIESTE_ATTIV_FILE_DA_COPIARE` escono subito quando la risorsa manca | L'azione non copia mai nulla, ma chiude con "File copiati." |
| DIV-ATT-10 | La generazione registra gli allegati sulla risorsa senza tipologia e profilo documentale e filtra solo gli annullati; la ricopia (`RICHIESTE_ATTIV_COPIA_FILE`) porta tipologia e profilo ed esclude anche gli eliminati | Gli allegati nati con la generazione perdono la classificazione documentale; un allegato eliminato sulla richiesta potrebbe ricomparire sulla risorsa, se la vista `OBJ_FILES_ELENCO` non lo esclude già (da verificare) |
| DIV-ATT-11 | `RICHIESTA_ATTIVAZIONE_CONVALIDA` e `RICHIESTA_ATTIVAZIONE_APPROVA` escludono solo lo stato Approvata: non controllano di partire da Inserita e da Validata | L'ordine dei passaggi lo garantiscono solo gli elenchi; da un altro canale si può approvare una richiesta mai convalidata o convalidare una respinta |
| DIV-ATT-12 | Nella procedura guidata di inserimento incarico l'azione `InserimentoPersonale` apre la richiesta di attivazione e scrive nell'incarico, come risorsa, l'identificativo della **richiesta** | Se l'azione è raggiungibile, l'incarico punta a una risorsa che non esiste. Nel codice letto l'azione non è collegata a nessun pulsante: va verificato se compare a video |

<!-- footer -->
---

[www.zebro.it/gesty](https://www.zebro.it/gesty)
<!-- /footer -->
