---
area: Stampe e allegati
progetto: Gesty
aggiornato: 2026-10-30
rilascio: OUT/20261030-specifiche-vive-dei-progetti/017
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

# Stampe e allegati

Questa specifica descrive come Gesty produce e mostra i documenti: la finestra **Reports** che elenca i modelli di una videata, l'anteprima e la stampa dei modelli FastReport (`.fr3`), Word (`.docx`) ed Excel (`.xlsx`), l'unione dei dati nei modelli Word, la stampa automatica del contratto e della designazione d'incarico, la stampa multipla degli incarichi, i modelli del progetto formativo, del verbale e degli attestati, e il visualizzatore degli allegati con i suoi pulsanti Stampa e Anteprima. Descrive il comportamento atteso, non il codice. Le regole stanno quasi tutte nel programma: `TzReportsManager` e `TzFastReportEngine` (zPack, cartella `zOffice`), `TzReportsForm`, `TMailMergeEngine`, i frame del visualizzatore (`zOffice.Pdf.Frame`, `.Word.Frame`, `.Excel.Frame`, `.Mail.Frame`), `TBaseDataModule.Print` e le sue ridefinizioni in `dmTirocini`, `dmRiunioni`; nel database stanno `CURRENT_USER_STAMPA_AUTOMATICA_CONTRATTO` e `_INCARICO`, `OBJ_FILES_GENERAZIONI` e le viste dei dati stampati (`PROGETTI_ASR_SICUREZZA_ELENCO`, `INCARICHI_ELENCO`).

**Fuori da quest'area**, con una specifica propria: il rilevamento ore e i timesheet (`Rilevamento ore.md`; qui solo il fatto che sono modelli come gli altri), la firma dei contratti dal gruppo Documento dell'anteprima (`Firma dei contratti.md`, codici GESTY-FIR-NNN; qui solo il punto di innesto, STA-016), il contenuto del documento di autorizzazione al pagamento e il ciclo dell'autorizzazione (`Autorizzazione incarichi.md`), il registro stage e la convenzione dei tirocini (`Tirocini.md`; qui solo la scelta della cartella dei modelli, STA-009), protocollo, invio PEC e conservazione dei documenti generati (nessuna specifica ancora).

**Origine.** Ricavata il 2026-10-30 dai sorgenti in `SRC\zPack\zOffice` e `SRC\Gesty_Group\_Sorgenti`, dal dizionario LZ in `SRC\Gesty_Group\LZ`, dai modelli in `SRC\Gesty_Group\Reports_CAPAC` e `SRC\Reports\codebri`, dal database master `GESTY` (lettura viva e fotografia dei metadati del 2026-10-30) e dalle preanalisi dei ticket 44, 74, 75, 101, 128, 131, 138, 139, 156, 172, 246, 280, 284, 287. Dove una regola viene solo da un ticket e non è stata riletta sul codice, il requisito cita il ticket.

## GESTY-STA-001 La finestra Reports di una videata
Il pulsante Stampa di una videata apre la finestra **Reports** (modale, 660 x 469, al centro dello schermo) con l'albero dei modelli del gruppo di report della videata (`ReportGroup` delle opzioni del modulo LZ) e dei modelli condivisi di quel dataset. I modelli sono i file `.fr3`, `.docx` e `.xlsx` della cartella del gruppo, sottocartelle comprese, ciascuno con l'icona del suo tipo. Il pulsante **Stampa** della videata si disabilita mentre la finestra è aperta, così non se ne aprono due. Dentro la finestra l'unico comando sempre attivo oltre a Chiudi è **Anteprima** (disponibile solo con un modello selezionato, anche con doppio clic); **Nuovo**, **Modifica**, **Cartella**, **Politiche accessi**, **Ricarica politiche** e **Proprietà** partono disattivati e si accendono solo con le politiche di accesso dell'utente (Proprietà e il menu Sistema richiedono anche il permesso del menu di sistema dei report). **Stampanti** è sempre attivo.

### Scenario: utente senza permessi di modifica
- **Dato** un utente le cui politiche non abilitano Nuovo e Modifica
- **Quando** apre la finestra Reports dalla scheda Risorse
- **Allora** vede l'albero e può fare Anteprima, ma Nuovo e Modifica sono inattivi

### Scenario: nessun modello selezionato
- **Dato** la finestra Reports con selezionata una cartella e non un modello
- **Quando** l'utente guarda la barra
- **Allora** Anteprima è disabilitata

## GESTY-STA-002 Quali modelli compaiono: gruppo, condivisi e modello scelto da un campo
Oltre ai modelli della cartella del gruppo, compaiono i modelli condivisi elencati nelle proprietà di stampa del dataset selezionato e dei suoi dataset padre (`ReportProps.SharedReports` del dizionario LZ), cercati nella cartella `__Shared`. Una voce può avere la forma `Nome=[Dataset.CAMPO]`: il modello da usare è allora il nome di file scritto in quel campo della riga corrente (per i contratti `Risorse_Incarichi.TEMPLATE_FILENAME`, quindi una versione di modello diversa per ogni incarico). Se il dataset o il campo non esistono la voce non compare e l'errore va nel registro SmartInspect. La cartella del gruppo, se manca su disco, viene creata da Gesty quando serve (comando Cartella).

### Scenario: contratto scelto dall'incarico
- **Dato** l'incarico 504193 con `TEMPLATE_FILENAME = 'Contratto Occasionale - Versione 4.docx'` selezionato nell'elenco delle designazioni
- **Quando** si apre la finestra Reports
- **Allora** "Contratto" compare e rimanda a quel file; un incarico con un'altra versione mostra l'altra

### Scenario: cartella dei modelli inesistente
- **Dato** un gruppo di report senza cartella su disco
- **Quando** l'utente preme Cartella
- **Allora** Gesty crea la cartella e la apre in Esplora risorse; se non riesce a crearla avvisa e non apre niente

## GESTY-STA-003 Dataset del documento
Un modello legge i dati dai dataset registrati per la videata. Il dataset principale di un modello Word è quello che ha lo stesso nome del file del modello (senza estensione); se non c'è, quello selezionato nella videata; se manca anche questo l'unione si ferma con "MailMerge: dataset non trovato". Quando un nome di dataset non si trova fra quelli registrati, Gesty **non segnala l'errore** ma usa in silenzio il dataset selezionato, e in mancanza di questo il primo registrato (DIV-STA-3). L'unione stampa solo il **record selezionato**: un modello Word genera un documento per la riga corrente, non uno per riga.

### Scenario: dataset del modello inesistente
- **Dato** un modello Word con un campo `DOCVARIABLE Pagamenti_Righe.IMPORTO` mentre il dataset "Pagamenti_Righe" non è registrato nella videata
- **Quando** si apre l'anteprima
- **Allora** il campo non provoca un errore: legge dal dataset selezionato (vedi DIV-STA-3)

### Scenario: nessun dataset disponibile
- **Dato** una videata senza dataset selezionato né registrati
- **Quando** si apre l'anteprima di un modello Word
- **Allora** compare l'avviso "MailMerge: dataset non trovato" e non si apre nessun documento

## GESTY-STA-004 Anteprima e Stampa mostrano sempre il documento
Per ogni tipo di modello, **Anteprima** prepara il documento e lo mostra. **Stampa** (chiamata `Print` del gestore dei report) non invia mai il documento alla stampante senza che l'utente lo veda: per Word ed Excel fa esattamente quello che fa l'anteprima (si apre il visualizzatore, da cui si stampa con il pulsante Stampa del visualizzatore); per FastReport apre la finestra di anteprima con la scelta di stampa (la stampa diretta, senza finestra, esiste nel motore ma il gestore non la richiede mai). Se prima della preparazione l'utente preme Annulla nella barra di avanzamento, il documento non si apre e non si stampa nulla.

### Scenario: stampa automatica di una designazione
- **Dato** un modello `Incarico.fr3` e l'utente con la stampa automatica dell'incarico attiva
- **Quando** si chiude la procedura guidata di inserimento incarico
- **Allora** si apre la finestra di anteprima FastReport con la scelta di stampa

### Scenario: annullo durante la preparazione
- **Dato** una designazione con molti record e la barra di avanzamento aperta
- **Quando** l'utente preme Annulla
- **Allora** il visualizzatore non si apre e nessun file viene prodotto

## GESTY-STA-005 Dataset durante la generazione
Prima di preparare un documento Gesty apre i dataset dichiarati per il modello e chiusi (`datasets` del file `.json` del modello) e li richiude alla fine, insieme a quelli che il `.json` chiede di chiudere. Per leggere in fretta, congela lo scorrimento delle griglie sui dataset registrati (`DisableControlsExt`), mantenendo vivo il legame master/dettaglio, e lo ripristina al termine (`EnableControlsExt`). **Un dataset chiuso viene lasciato com'è**: il congelamento si applica solo ai dataset attivi, perché assegnare `BlockReadSize` a un dataset chiuso solleva l'errore "dataset chiuso" (ticket 44, dataset di ricerca `lkProgetti`, che per natura è chiuso a riposo). Al ritorno dalla generazione i dataset ritornano ai valori precedenti anche se la generazione è finita con un errore.

### Scenario: dataset di ricerca chiuso
- **Dato** un modulo dati con il dataset di ricerca `lkProgetti` chiuso fra quelli registrati
- **Quando** si apre l'anteprima di un report
- **Allora** l'anteprima parte e non compare l'errore "Impossibile eseguire questa operazione su un dataset chiuso" (ticket 44)

### Scenario: errore a metà
- **Dato** un report che solleva un errore durante la preparazione
- **Quando** l'anteprima si chiude con l'errore
- **Allora** le griglie della videata tornano a scorrere normalmente

## GESTY-STA-006 L'elenco dei modelli si rilegge a ogni uso e la selezione resta
A ogni anteprima, stampa o modifica Gesty rilegge l'elenco dei modelli dal disco: gli oggetti che rappresentavano i file vengono distrutti e ricreati. La finestra Reports, che li tiene nei nodi dell'albero, svuota l'albero un istante prima e lo ricostruisce subito dopo, rimettendo la selezione sul modello che era scelto (ricercato per nome). Non deve restare nessun nodo che punta a oggetti distrutti: è la causa dell'access violation del ticket 139 (la finestra Reports restava aperta dopo l'anteprima e al primo ciclo di inattività rileggeva memoria liberata). L'aggancio fra gestore e finestra viene tolto sempre alla chiusura della finestra, anche se questa si chiude con un errore.

### Scenario: anteprima e poi nuova anteprima
- **Dato** la finestra Reports con selezionato "Contratto Partita IVA - Versione 4"
- **Quando** l'utente apre l'anteprima, chiude il documento e torna alla finestra
- **Allora** l'albero è ricostruito, il modello resta selezionato e non compare nessuna eccezione al ciclo di inattività

### Scenario: modifica di un modello
- **Dato** un modello selezionato e il comando Modifica
- **Quando** si chiude l'editor
- **Allora** l'albero si rilegge e il modello resta selezionato

## GESTY-STA-007 Stampa multipla delle designazioni e dei contratti selezionati
Dalle videate Risorse (dataset `Risorse_Incarichi`) e Progetti (dataset `Docenti_Incarichi`) la stampa del modello FastReport **Incarico** riguarda le sole righe selezionate nella griglia: Gesty raccoglie gli `ID_INCARICO` selezionati, filtra il dataset su quelli e stampa un'unica pagina per incarico; alla fine toglie il filtro. Il meccanismo vale solo per il modello FastReport che si chiama "Incarico": un modello Word, o un FastReport con altro nome, stampa la sola riga corrente (DIV-STA-7).

### Scenario: tre incarichi selezionati
- **Dato** tre designazioni selezionate nell'elenco di una risorsa
- **Quando** si stampa il modello "Incarico"
- **Allora** il documento contiene le tre designazioni e solo quelle; chiusa l'anteprima, l'elenco torna completo

## GESTY-STA-008 Stampa automatica del contratto e della designazione
Due preferenze dell'utente fanno aprire da sole il documento a fine lavoro: stampa automatica **dell'incarico** (a chiusura della procedura guidata di inserimento, modello "Incarico") e stampa automatica **del contratto** (dopo "Autorizza incarico", modello "Contratto", se l'incarico richiede il contratto). Ciascuna è attiva se la configurazione generale (`CONFIG.STAMPA_AUTOMATICA_CONTRATTO` e `_INCARICO`) è accesa e l'utente non ha la preferenza "disabilitata"; se la configurazione è spenta dovrebbe attivarsi solo con la preferenza "abilitata" dell'utente (ma vedi DIV-STA-1). Per il contratto Gesty ricarica prima la riga (perché protocollo e carta intestata sono cambiati con l'attivazione) e passa l'identificativo dell'incarico (`WithOid`) all'anteprima, altrimenti i comandi del gruppo Documento non saprebbero a quale incarico appartiene il documento. Con identificativo mancante il dataset non solleva più un errore ma restituisce 0, e il comando che ne ha bisogno risponde "OID non impostato" (ticket 74 e 75).

### Scenario: utente con la stampa del contratto disabilitata
- **Dato** la configurazione accesa e l'utente con `STAMPA_AUTOMATICA_CONTRATTO_DISABILITATA`
- **Quando** autorizza un incarico che richiede il contratto
- **Allora** l'incarico si attiva e l'anteprima non si apre da sola

### Scenario: dataset senza chiave
- **Dato** un'anteprima aperta su un dataset di sola lettura senza chiave dichiarata (vista `IncarichiDaAutorizzare`)
- **Quando** si apre il visualizzatore Word e i comandi del gruppo Documento chiedono lo stato
- **Allora** non compare l'access violation del ticket 74: l'identificativo vale 0 oppure è quello passato dal chiamante

## GESTY-STA-009 Cartella dei modelli del tirocinio
Dalla videata dei tirocini la finestra Reports mostra solo le sottocartelle del tipo del tirocinio corrente: le cartelle degli altri tipi (CURRICULARE, EXTRACURRICULARE, INCLUSIONE, FORMAZIONE INTERNA, ALTRO) sono escluse. Senza un tirocinio selezionato compaiono tutte. Per le riunioni, prima dell'elenco Gesty salva la riunione e riapre il riepilogo dei partecipanti sulla riunione corrente.

### Scenario: tirocinio extracurriculare
- **Dato** un tirocinio di tipo extracurriculare
- **Quando** si apre la stampa
- **Allora** l'albero mostra i modelli della cartella EXTRACURRICULARE e non quelli delle altre

## GESTY-STA-010 Documenti Word: campi, immagini, frammenti e collegamenti
Un modello Word riceve i valori da quattro tipi di segnaposto. Le variabili `DOCVARIABLE <Dataset>.<CAMPO>` (nel nome del dataset il punto diventa trattino basso, es. `AccordoStatoRegioni_Progetti_Asr_Sicurezza.TITOLO`) leggono il valore del dataset; i `MERGEFIELD` senza dataset leggono il dataset principale, cioè il nodo selezionato nel menu della scheda; i **frammenti** (un secondo `.docx` e un dataset, dichiarati nel `.json` del modello o per convenzione di nome `modello~~~variabile.docx`) producono tabelle ripetute con i record del dataset indicato; i collegamenti il cui indirizzo comincia con `@` vengono sostituiti con testo e indirizzo calcolati (un collegamento non risolvibile sparisce). Le immagini (logo e timbro dell'ente, loghi di intestazione e piè di pagina, firme del direttore, del legale rappresentante, del responsabile, del coordinatore, del referente di segreteria) sono lette dai campi omonimi del dataset e inserite dove il modello ha un campo immagine; un'immagine vuota non lascia il quadratino segnaposto.

### Scenario: campo senza dataset e nodo diverso
- **Dato** un attestato con `MERGEFIELD DATA_NASCITA` senza dataset e la scheda studente con selezionato il nodo "Attestati Sicurezza"
- **Quando** si apre l'attestato
- **Allora** nome e cognome (campo con dataset) compaiono e data di nascita, luogo e codice fiscale restano vuoti perché letti dal dataset selezionato (ticket 246)

### Scenario: frammento dei partecipanti
- **Dato** il verbale ASR con la variabile `Partecipanti` dichiarata nel `.json` come frammento del dataset `Partecipanti`
- **Quando** si apre l'anteprima
- **Allora** nel verbale compare la tabella con un partecipante per riga

## GESTY-STA-011 Progetto formativo e verbale degli ASR Sicurezza
Nella sezione Progetti Asr Sicurezza (modulo `AccordoStatoRegioni`, dataset `Progetti_Asr_Sicurezza`, vista `PROGETTI_ASR_SICUREZZA_ELENCO`) le stampe sono due modelli Word: `Progetto_Formativo_ASR.docx` e `Verbale_Verifica_ASR.docx`. Non c'è logica Delphi intermedia: stampano esattamente i campi della vista e dipendono dai segnaposto del modello. Il responsabile del progetto formativo si legge dalla vista (`RESPONSABILE_PROGETTI_FORMATIVI`: responsabile in carica alla data del verbale, o a oggi se il verbale non c'è) e compare in entrambi i punti in cui il modello CAPAC lo cita (punto 1 "Dati generali" e punto 8 "Risorse professionali"). Il luogo della sottoscrizione del verbale è il campo `LUOGO_VERBALE`, distinto dal `LUOGO_VERIFICA` ("Luogo di svolgimento della verifica", punto 2): per comparire in stampa deve essere compilabile dalla scheda del progetto, quindi visibile e modificabile nella scheda LZ `AccordoStatoRegioni.Progetti_Asr_Sicurezza` (ticket 138). Verbale e progetto sono modelli per cliente: la copia CAPAC e la copia Codebri non coincidono (DIV-STA-6).

### Scenario: responsabile al punto 8
- **Dato** un progetto ASR con il responsabile in carica
- **Quando** si stampa il progetto formativo CAPAC
- **Allora** il responsabile compare sia al punto 1 sia al punto 8

### Scenario: luogo del verbale
- **Dato** un progetto ASR con `LUOGO_VERBALE = 'Milano'` e `LUOGO_VERIFICA = 'Aula 3'`
- **Quando** si stampa il verbale
- **Allora** "Luogo di svolgimento della verifica" riporta Aula 3 e la sottoscrizione riporta Milano

## GESTY-STA-012 Attestati e modelli degli studenti
Gli attestati della formazione (sicurezza, HACCP, primo soccorso, apprendistato) e i moduli per lo studente (liberatorie, patto di corresponsabilità, schede di iscrizione) sono modelli Word delle cartelle `Studenti` e `Studenti Documentazione` del cliente, stampati con le regole di STA-003 e STA-010. Non esiste una funzione Delphi che li produca: il modulo `Attestati` non ha logica propria. Perciò i dati di uno studente compaiono se il modello li legge con un dataset esplicito o se, per i campi senza dataset, il nodo selezionato nel menu della scheda è quello dello studente; un attestato che mischia i due modi stampa il nome e lascia vuoti gli altri dati quando il nodo è diverso (ticket 246: correzione fatta sui modelli, quattro file).

### Scenario: attestato di chi non ha ancora attestati
- **Dato** la scheda studente con il nodo "Attestati Sicurezza" selezionato e vuoto per quello studente
- **Quando** si apre il modello con campi senza dataset
- **Allora** i campi senza dataset sono vuoti (vedi STA-010); con i campi tutti legati a `Studenti_Studenti` i dati compaiono comunque

## GESTY-STA-013 Il visualizzatore degli allegati: Stampa e Anteprima
Tutti gli allegati (risorse, incarichi, studenti, contratti, ecc.) si vedono nel visualizzatore a frame (`TzMultiViewer`, attivo in Gesty dall'avvio: `UseMultiViewer := true`), che sceglie il frame dal tipo di file: PDF, Word, Excel, e-mail, immagine. Il pulsante **Stampa** di ogni frame (e **Anteprima** dove esiste: Word, Excel, e-mail, immagine) è abilitato quando c'è un documento caricato, **non** quando un collegamento di stampa si è registrato (ticket 156: il pulsante Stampa del PDF restava grigio dopo la correzione del 128 perché il collegamento di stampa nasceva troppo tardi). Il collegamento di stampa e il `TdxComponentPrinter` nascono **al primo clic**, non all'apertura della form: aprire un allegato non legge la stampante predefinita, e con una stampante di rete lenta o non raggiungibile l'apertura non si blocca e non compare la finestra del driver. Senza allegato selezionato il pulsante torna grigio.

### Scenario: allegato PDF di una risorsa
- **Dato** la scheda Risorse con un allegato PDF selezionato
- **Quando** si osserva la barra del visualizzatore
- **Allora** Stampa è attivo; premendolo si apre la finestra di stampa DevExpress

### Scenario: stampante di rete irraggiungibile
- **Dato** una stampante predefinita di rete non raggiungibile
- **Quando** si apre la scheda Risorse con gli allegati
- **Allora** la scheda si apre senza ritardi né finestre del driver; l'attesa, se c'è, arriva solo al clic su Stampa

## GESTY-STA-014 Pagina di stampa degli allegati PDF
La stampa di un allegato PDF usa pagina A4, margini di 1 cm per lato, intestazione e piè di pagina a zero, il documento centrato e la scala **"adatta alla pagina"**, e la finestra di stampa si apre su quella scala senza forzare il 100 % (ticket 128: prima i margini erano di 80,64 mm e un gestore riportava la scala al 100 %, e un A4 scansionato usciva in un riquadro di circa 6,5 x 11 cm). Lo stesso vale per il vecchio visualizzatore `TzFileViewer`, usato da WinTarif e da Gesty se `UseMultiViewer` è spento. I frame Word, Excel ed e-mail stampano con i valori predefiniti del collegamento DevExpress, **in bianco e nero** (`GrayShading`), vedi DIV-STA-5.

### Scenario: scansione A4
- **Dato** un allegato PDF di una pagina A4 da scansione
- **Quando** si apre la stampa dell'allegato
- **Allora** l'anteprima mostra la pagina a pieno foglio (area utile 190 x 277 mm) con scala "adatta", non in miniatura

## GESTY-STA-015 Pulsanti di stampa della videata e dei documenti generati
Il visualizzatore Word dei documenti generati (contratti, incarichi) non legge la stampante predefinita all'apertura (così l'anteprima del contratto non tarda con una stampante di rete lenta); la lettura avviene a Stampa, Anteprima o esportazione. Quando il visualizzatore si chiude Gesty rimette il cursore normale, perché la stampa può lasciare la clessidra accesa.

### Scenario: chiusura dopo la stampa
- **Dato** un documento stampato dal visualizzatore
- **Quando** il visualizzatore si chiude
- **Allora** il cursore del programma è quello normale

## GESTY-STA-016 Azioni sul documento generato
Il visualizzatore dei documenti generati mostra il gruppo **Documento** (firma, protocollo, invio PEC, conservazione, genera allegato) solo se il modello lo dichiara nel suo `.json` e se un controller applicativo è assegnato (in Gesty `TDocumentazioneReportActionsController`). **Genera allegato** esporta il documento in PDF temporaneo e lo registra come allegato dell'oggetto (incarico), una sola volta per sessione; ricordando che la registrazione richiede l'identificativo dell'oggetto passato dal chiamante. L'origine di ogni documento generato (nome del modello, gruppo, tipo di modello) si conserva in `OBJ_FILES_GENERAZIONI`, una riga per file. La firma è descritta in `Firma dei contratti.md` (GESTY-FIR-002 e successivi): qui basta sapere che parte da questo gruppo e dal pulsante Stampa della videata.

### Scenario: generare l'allegato due volte
- **Dato** un'anteprima del contratto già persistita come allegato nella stessa sessione
- **Quando** l'utente ripete Genera allegato
- **Allora** non si crea un secondo allegato: resta quello della sessione

## GESTY-STA-017 Esportazione in PDF dall'anteprima Word
Dal visualizzatore Word si esporta il documento in PDF con le opzioni del modello (`pdf` del `.json`): nome file scelto con una finestra, o fisso, o ricavato da un campo del dataset (con estensione `.pdf`), oppure file temporaneo. Un nome senza percorso finisce nella cartella Documenti dell'utente, non in quella dell'eseguibile. I caratteri possono essere incorporati per intero, a sottoinsieme o per nulla secondo l'opzione. Per i file temporanei, usati dalle azioni documentali, il PDF viene cancellato dopo l'uso.

### Scenario: nome senza percorso
- **Dato** un modello con nome file PDF `contratto.pdf` senza cartella
- **Quando** si esporta
- **Allora** il file nasce nella cartella Documenti dell'utente

## GESTY-STA-018 Salvataggio dei modelli e dei report con percorsi lunghi
Prima di salvare un modello Word, Excel o FastReport che si sta modificando, Gesty ne fa una copia di sicurezza nella sottocartella `__backup` accanto al modello, con prefisso data e ora. La copia usa percorsi estesi (`TzPercorsiLunghi`): anche con percorsi di rete lunghi (oltre i 260 caratteri di `MAX_PATH`) il salvataggio non fallisce con "Impossibile trovare il percorso specificato" (ticket 131).

### Scenario: dossier tirocinio con percorso di 232 caratteri
- **Dato** un modello con percorso di 232 caratteri che con il prefisso del backup supera i 260
- **Quando** si salva il modello
- **Allora** la copia di sicurezza è creata e il salvataggio riesce

## GESTY-STA-019 Modelli Excel e associazione dei dati
Un modello Excel ha accanto un file `<modello>.xlsx.json` con l'associazione dei dati (`excel.databinding`: sorgenti, gruppi e ordinamenti). Il campo `sortOrder` degli ordinamenti si legge sia come numero (come lo scrive Gesty), sia come nome dell'enumerato (`soAscending`, `soDescending`), sia in forma breve: un file scritto a mano non blocca più l'anteprima con "Could not convert string to integer" (ticket 280). Gesty scrive sempre il numero.

### Scenario: ordinamento scritto a testo
- **Dato** il modello `Timesheet_Rilevamenti_Operatore.xlsx` con `"sortOrder": "soAscending"`
- **Quando** si apre l'anteprima dalla Scheda Personale
- **Allora** l'anteprima parte e ordina in senso crescente

## GESTY-STA-020 Scheda Risorse: pannello filtri e dimensioni della videata
Il pannello dei filtri del Controllo Periodico (Mese, Anno, Progetto) compare nella scheda Risorse **solo** se l'utente ha accesso al dataset `Risorse.RilevamentiControlloPeriodico`; senza accesso la voce di layout non viene aggiunta e, se resta una voce con un gruppo padre mancante, viene nascosta invece che riportata alla radice (ticket 128: prima il pannello occupava metà larghezza di ogni pagina e schiacciava la griglia "Elenco Incarichi"). Vale per tutti i controlli agganciati a un gruppo di dataset a cui l'utente non accede.

### Scenario: utente senza Controllo Periodico
- **Dato** un utente non amministratore senza accesso al dataset del Controllo Periodico
- **Quando** apre Elenco Incarichi dalla scheda Risorse
- **Allora** la griglia occupa tutta la larghezza e nessun pannello filtri vuoto compare a sinistra

## Divergenze note

Punti in cui il codice di oggi non mantiene ciò che i requisiti dicono, o in cui un modello o un dato non è coerente con la regola. Divergenze raccolte in R-189 (voce R-189); con la correzione il requisito si aggiorna e questa sezione si accorcia. "Provata" indica che l'ho riscontrata nel codice o sul master il 2026-10-30; "dedotta" che deriva dalla lettura del codice o di un ticket e non è stata provata in esecuzione.

| Codice | Divergenza | Conseguenza |
|---|---|---|
| DIV-STA-1 | **Provata sul master.** `CURRENT_USER_STAMPA_AUTOMATICA_CONTRATTO` e `_INCARICO`, nel ramo in cui la configurazione generale è spenta, restituiscono `NOT USR_SETTING_EXISTS(<preferenza ABILITATA>)`: vero quando l'utente **non** ha la preferenza, falso quando ce l'ha. Il ramo con la configurazione accesa è corretto (`NOT` della preferenza "disabilitata"). Oggi `CONFIG.STAMPA_AUTOMATICA_CONTRATTO` e `_INCARICO` sono entrambe accese sul master | Su un database con la configurazione spenta la stampa automatica scatta per tutti gli utenti tranne quelli che l'hanno abilitata a mano: l'opposto di ciò che dice STA-008. Latente sul master, da controllare sui database dei clienti |
| DIV-STA-2 | **Provata.** `TzReportsManager.Print` chiama `FFastReport.Print` con il valore predefinito `ShowDialog = True`, quindi il ramo `FReport.Print` (stampa diretta) non è mai raggiunto dal gestore; per Word ed Excel `Print` è identico a `Preview` | Il nome "Stampa" fa pensare a un invio diretto alla stampante: si apre sempre il documento. Va deciso se la stampa diretta serve (STA-004) |
| DIV-STA-3 | **Provata.** `TzReportsManager.GetDataSet` e le chiamate dei modelli Word/Excel restituiscono il dataset selezionato (o il primo registrato) quando il nome richiesto non esiste, senza avviso | Un nome di dataset sbagliato nel modello non dà errore e stampa i dati di un altro dataset; il campo `MERGEFIELD` senza dataset dipende dal nodo selezionato nella scheda (causa del ticket 246) |
| DIV-STA-4 | **Dedotta.** La finestra Reports ritrova il modello dopo il ricaricamento per **nome** (`FBookMark`) e il gestore cerca il modello per nome (`FileByName`): due modelli con lo stesso nome in cartelle diverse (vedi per esempio i contratti nel gruppo e in `__Shared`) non si distinguono | Dopo un'anteprima la selezione può spostarsi sul primo modello omonimo; con omonimi in cartelle diverse l'anteprima apre il primo trovato |
| DIV-STA-5 | **Dedotta dal commento nel codice.** I collegamenti di stampa dei frame Word, Excel ed e-mail e del visualizzatore Word hanno `GrayShading = True`; un commento di `zOffice.Word.Form` osserva che la richiesta CAPAC di stampare a colori "non arrivava alla stampa" e che è questo valore a decidere | Documenti con colori (loghi, intestazioni) possono uscire in scala di grigi; da provare su una stampante a colori |
| DIV-STA-6 | **Provata sui file.** I modelli ASR non sono gli stessi nei due clienti: in `Reports_CAPAC` il progetto formativo non legge `LUOGO_VERBALE` e il verbale sì; in `Reports\codebri` è il contrario (il progetto formativo lo legge, il verbale no). Il progetto formativo Codebri ha 32 campi contro i 24 di CAPAC | I due clienti stampano verbali con campi diversi; il luogo della sottoscrizione non compare nel verbale Codebri. Dipende dai modelli, non dal programma, ma la correzione del ticket 138 è stata fatta solo su CAPAC |
| DIV-STA-7 | **Dedotta.** La stampa multipla degli incarichi (STA-007) si attiva da `ReportLoadedProc`, che il gestore richiama solo per i modelli FastReport (`LoadReport`), e controlla il nome `'Incarico'`; non c'è un equivalente per Word | Un contratto o una designazione Word stampa la sola riga corrente anche con più righe selezionate; i modelli FastReport con altro nome (per esempio "Incarico SENZA TABELLA") non hanno il filtro sulla selezione |
| DIV-STA-8 | **Provata.** `Attestato.docx` nella cartella `AccordoStatoRegioni` (CAPAC e Codebri) non ha campi unione: i segnaposto sono testo semplice (`«NOMINATIVO_STUDENTE»`, con i caratteri delle virgolette danneggiati) | Il file, se usato, stampa i segnaposto invece dei dati. Non ho verificato se un menu lo richiami: i modelli degli attestati usati sono quelli in `Studenti` |
| DIV-STA-9 | **Provata.** Il file `Verbale_Verifica_ASR.docx.json` dichiara `"id": "Progetto_Formativo_ASR"` (CAPAC e Codebri), cioè l'identificatore del modello del progetto formativo | L'identificativo del modello non corrisponde al nome del file. L'effetto (`TzReportJsonConfigContext.ReportId`) non è stato verificato: può essere innocuo, ma nei registri e nelle azioni documentali il verbale risulterebbe un altro documento |
| DIV-STA-10 | **Provata sul sorgente, da confermare con l'utente.** Il filtro Anno Formativo dell'elenco "Designazioni d'incarico" (`Risorse.Risorse_Incarichi`) è predefinito sull'anno formativo corrente (`ivDefault` → `CURRENT_ANNO_FORMATIVO_DESC()`), che cambia il 1° settembre | A settembre l'elenco, e le stampe fatte da lì, appaiono vuote finché non si azzera il filtro (ticket 101, segnalazione senza dettagli, in attesa di conferma) |
| DIV-STA-11 | **Provata.** `Documentazione.ReportActionsController.pas` in `SRC` comincia con il commento "PROPOSTA - Mantis #90 ... non sostituisce il file sorgente (di sola lettura)" | Intestazione di una proposta di preanalisi rimasta nel file integrato: non dice se il codice sia quello definitivo. Va tolta con la prossima modifica |
