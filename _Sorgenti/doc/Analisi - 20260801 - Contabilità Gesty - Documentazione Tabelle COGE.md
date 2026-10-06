---
data: 2026-08-01
categoria: Progetti
status: WIP
sessione: "Contabilità Gesty - Documentazione tabelle COGE"
---

## Sintesi

Documentazione di riferimento per tutte le tabelle nuove del nucleo contabile COGE, esclusa la parte di fattura elettronica (file `08_fattura_elettronica.sql` e `14_fattura_elettronica_costruzione_uscita.sql`, che meritano un documento a parte). Le tabelle sono raggruppate per gli otto file SQL che le introducono; per ognuna viene spiegato il ruolo e le scelte non ovvie dalla sola lettura del DDL. Nessuno script è stato eseguito: questo documento descrive un progetto, non uno stato del database.

## 1. Struttura portante - piano dei conti, causali, tipi documento (file 02)

Il principio guida di questo gruppo è che il comportamento del motore contabile è **dati, non codice**: cambiare come si contabilizza una fattura significa modificare una riga di causale, non ricompilare un DataModule.

| Tabella | Ruolo | Peculiarità |
|---|---|---|
| `COGE_ESERCIZI` | Stato contabile dell'esercizio (aperto/chiuso) per ente | Chiave composta `(ID_ENTE, ANNO_ESERCIZIO)`, appoggiata a `ENTI_ANNI_ESERCIZIO` che già definisce anno e date di validità: qui si aggiunge solo `CHIUSO` e le date di apertura/chiusura contabile |
| `COGE_CONTI` | Piano dei conti | Albero a **profondità libera**: `LIVELLO` è un dato calcolato, non una struttura fissa a quattro livelli. Solo i conti con `ACCETTA_MOVIMENTI = TRUE` possono comparire in una scrittura (i conti di raggruppamento restano bloccati, vedi il trigger in `COGE_REGISTRAZIONI_MOVIMENTI`). `CODICE_COMPLETO` è calcolato dal padre e vincolato `UNIQUE` per ente |
| `COGE_CONTI_FINANZIARI` | Casse, banche, conti di moneta elettronica | Ogni conto finanziario punta sempre a un conto del piano (`ID_CONTO`): il saldo di cassa/banca è sempre anche un saldo di bilancio, non un dato parallelo |
| `COGE_ALIQUOTE_IVA` | Anagrafica aliquote IVA | `CHECK` di mutua esclusione: aliquota positiva con natura `NULL`, oppure aliquota zero con natura valorizzata (`CHK_COGE_ALIQUOTE_IVA_NATURA`) - non si possono avere entrambe o nessuna delle due |
| `COGE_REGISTRI_IVA` | Registri IVA vendite/acquisti | Tipizzata da `COGE_TIPI_REGISTRO_IVA`; collegata sia alle causali sia ai sezionali |
| `COGE_CAUSALI` | Testata della causale contabile | Contiene solo intestazione (codice, registro IVA, se genera scadenze): il comportamento vero sta nella tabella successiva |
| `COGE_CAUSALI_RIGHE` | Schema della scrittura generata dalla causale | **Il cuore del motore**: ogni riga dichiara `ORIGINE_IMPORTO` (da dove prendere l'importo: netto, imponibile, IVA, ritenuta, bollo, arrotondamento, totale) e `ORIGINE_CONTO` (dove scrivere: sul soggetto, sulla riga, su un conto fisso, sull'aliquota, sulla modalità di pagamento, sul conto finanziario). Un `CHECK` impone `ID_CONTO` valorizzato solo quando `ORIGINE_CONTO = 'FIS'`. Aggiungere un nuovo tipo di scrittura è un `INSERT`, non una modifica applicativa |
| `COGE_TIPI_DOCUMENTO` | Catalogo dei tipi documento (fattura, acconto, nota di credito...) | Tabella di appoggio dietro al dominio `COGE_TIPO_DOCUMENTO`, per questo **non ha** `COMMENT ON DOMAIN`. `SEGNO` (±1) è ciò che fa funzionare le note di credito senza logica dedicata nel codice. `CODICE_FATTURA_ELETTRONICA` è l'unico punto di contatto con il tracciato FatturaPA, ed è per questo che resta qui e non nel file dedicato alla fattura elettronica |
| `COGE_SEZIONALI` | Numerazione dei documenti per ente, tipo e anno | `PREFISSO`/`SUFFISSO`/`LUNGHEZZA_NUMERO` formattano il numero; la numerazione qui prodotta è indipendente da quella eventualmente riassegnata dal gestionale del cliente in fase di importazione |
| `COGE_MODALITA_PAGAMENTO` | Modalità di pagamento (bonifico, contanti...) | `MODALITA_PAGAMENTO_FE` fa già da ponte verso i codici `MPxx` del tracciato FatturaPA pur restando fuori dal file dedicato; `PAGAMENTO_ELETTRONICO` + `FORNITORE_PAGAMENTO` agganciano PagoPA/PayPal (file 09) |
| `COGE_TERMINI_PAGAMENTO` | Termini di pagamento (immediato, 30gg fine mese, rateale...) | Genera il piano rate: `NUMERO_RATE`, `CADENZA_RATE`, `GIORNI_PRIMA_RATA`, `FINE_MESE`, `GIORNO_FISSO`. `CHECK` vincola `GIORNO_FISSO` fra 1 e 31 quando valorizzato |

## 2. Anagrafica fiscale unificata (file 03)

| Tabella | Ruolo | Peculiarità |
|---|---|---|
| `COGE_SOGGETTI` | Punto di incontro fiscale fra allievo, azienda, ente committente e collaboratore | Un allievo (`ANAGRAFE`), un'azienda, un ente o una risorsa diventano lo **stesso tipo di controparte** quando entrano in un documento. `CHK_COGE_SOGGETTI_ORIGINE` impone che al massimo una delle quattro chiavi di origine sia valorizzata (zero per il tipo `ALT`, un soggetto senza anagrafica di riferimento). `CHK_COGE_SOGGETTI_IDENTIFICATIVO` impone codice fiscale o partita IVA: senza uno dei due non si può emettere nulla |
| `COGE_SOGGETTI_COORDINATE_BANCARIE` | IBAN del soggetto | Usata per gli incassi/rimborsi SEPA; non ha nulla a che fare con l'IBAN del cedente nella fattura elettronica, che vive in una tabella propria |

## 3. Quote e listini - l'importo atteso (file 04)

Questo è il gruppo che colma una lacuna reale: oggi `STUDENTI_PAGAMENTI` registra solo quanto è stato incassato, quindi non esistono né insoluti né solleciti. Le tabelle non hanno il prefisso `COGE` perché appartengono al dominio formativo (progetti, iscrizioni): è il documento contabile che le richiama, non viceversa.

| Tabella | Ruolo | Peculiarità |
|---|---|---|
| `PROGETTI_QUOTE` | Listino del progetto (quota intera, quote ridotte) | Collegata alle aliquote e ai termini di pagamento COGE, ma appartiene concettualmente a `PROGETTI` |
| `STUDENTI_PROGETTI_QUOTE` | Quota pattuita sulla singola iscrizione | Il pagante (`ID_SOGGETTO_PAGANTE`) è un `COGE_SOGGETTI`, **non necessariamente l'allievo**: può essere l'azienda, un genitore, un ente. `IMPORTO_DOVUTO` è `COMPUTED` (pattuito meno sconto) |
| `STUDENTI_PROGETTI_QUOTE_RATE` | Piano rate della quota pattuita | La rata è l'atteso; quando il documento viene emesso, la rata si aggancia alla scadenza del documento (`ID_SCADENZA`) e da quel momento l'incasso vive sulla scadenza, non più sulla rata. La chiave esterna verso `COGE_DOCUMENTI_SCADENZE` viene aggiunta solo nel file 05, perché quella tabella non esiste ancora a questo punto della sequenza degli script |
| `SAL_SERVIZI_TARIFFE` | Tariffa dei servizi al lavoro | `SAL_SERVIZI` oggi contiene solo il nome del servizio: senza tariffa e senza committente il ramo Servizi al Lavoro non può produrre ricavo |
| `SAL_UTENTI_SERVIZI_RICAVI` | Ricavo maturato dal servizio erogato all'utente | Riga di collegamento fra servizio erogato e tariffa che lo valorizza. Non punta alla fattura: è `COGE_DOCUMENTI_RIGHE.ORIGINE_OID` che punta qui, cosicché il meccanismo di collegamento resta uno solo per tutte le origini (rette, servizi SAL, autorizzazioni) |

## 4. Documenti contabili - ciclo attivo e passivo (file 05)

| Tabella | Ruolo | Peculiarità |
|---|---|---|
| `COGE_DOCUMENTI` | Testata unica per fattura, acconto, nota di credito, nota di debito, ricevuta, proforma, preventivo, fattura fornitore, compenso | Cambia il tipo, non la struttura. I dati fiscali del soggetto sono **copiati** sulla testata al momento dell'emissione (`SOGGETTO_*`): il documento resta leggibile come è stato emesso anche se l'anagrafica cambia dopo. `CHK_COGE_DOCUMENTI_NUMERO` impone che in stato `BOZ` il numero resti `NULL` (non consuma numerazione) e che fuori bozza numero e data siano sempre valorizzati. Il trigger `COGE_DOCUMENTI_BU1` blocca la modifica di numero, sezionale o data una volta emesso (si storna, non si corregge). Gli allegati non hanno una tabella propria: si riusa `OBJ_FILES` con `OBJ_FILES_REFS.OID_REF = COGE_DOCUMENTI.ID_DOCUMENTO` |
| `COGE_DOCUMENTI_RIGHE` | Righe del documento | `ORIGINE_OID` sfrutta l'OID globale di Gesty: una sola colonna copre rata di iscrizione, servizio al lavoro maturato o riga di autorizzazione al pagamento, oggi e per qualunque origine futura, senza bisogno di una FK dedicata per ciascuna |
| `COGE_DOCUMENTI_IVA` | Riepilogo IVA del documento, per aliquota | `UNIQUE (ID_DOCUMENTO, ID_ALIQUOTA_IVA)`: una sola riga di riepilogo per aliquota |
| `COGE_DOCUMENTI_SCADENZE` | Scadenzario del documento | `IMPORTO_RESIDUO` è `COMPUTED` (scadenza meno incassato). `IMPORTO_INCASSATO` **non si scrive mai a mano**: lo aggiorna il trigger del motore degli incassi (file 06) leggendo `COGE_MOVIMENTI_FINANZIARI_RIGHE`. `STATO_SCADENZA` è calcolato dal trigger `BIU1` in base agli importi e alla data, non è una scelta dell'utente |
| `COGE_DOCUMENTI_RITENUTE` | Ritenute d'acconto e cassa previdenziale del documento | Una riga per tipo di ritenuta; alimenta sia la scrittura contabile (causale `RIT`) sia il tracciato FatturaPA |
| `COGE_DOCUMENTI_COLLEGAMENTI` | Collegamenti fra documenti (nota di credito verso la fattura originale, ordine, DDT...) | Auto-referenziale su `COGE_DOCUMENTI`; `TIPO_COLLEGAMENTO` distingue la natura del legame |

## 5. Incassi e movimenti finanziari (file 06)

Un movimento finanziario è un fatto di cassa o di banca (entra o esce denaro); l'attribuzione alle scadenze è una tabella a parte perché il legame non è mai uno a uno: un bonifico può saldare tre fatture, una fattura può essere saldata da tre bonifici.

| Tabella | Ruolo | Peculiarità |
|---|---|---|
| `COGE_MOVIMENTI_FINANZIARI` | Movimento di cassa/banca, prima ancora di essere attribuito | `ORIGINE_OID` è pensato per la migrazione dei 5.522 pagamenti già presenti in `STUDENTI_PAGAMENTI`, importabili come movimenti senza attribuzione conservando l'OID di origine. `CHECK` impone importo positivo e attribuito non superiore all'importo |
| `COGE_MOVIMENTI_FINANZIARI_RIGHE` | Attribuzione del movimento alle scadenze | Relazione N a N. Il trigger `BIU1` impedisce di attribuire più del residuo della scadenza (`E_COGE_INCASSO_ECCEDENTE`); il trigger `AIUD0`, dopo ogni inserimento/modifica/cancellazione, **ricalcola sempre** sia `COGE_DOCUMENTI_SCADENZE.IMPORTO_INCASSATO` sia `COGE_MOVIMENTI_FINANZIARI.IMPORTO_ATTRIBUITO`: questi due valori non vanno mai scritti dall'applicazione |

## 6. Registrazioni contabili e saldi (file 07)

La prima nota qui non ha due colonne dare/avere di cui una vincolata a zero: ha una sezione (`D`/`A`) e un importo sempre positivo. È la stessa informazione con metà delle occasioni di sbagliare. La scrittura non si scrive mai a mano dall'applicazione: la genera il motore leggendo `COGE_CAUSALI_RIGHE`.

| Tabella | Ruolo | Peculiarità |
|---|---|---|
| `COGE_REGISTRAZIONI` | Testata della registrazione di prima nota | `STATO_REGISTRAZIONE` distingue provvisoria (`PRO`) da consolidata (`CON`); il trigger `BU1` impedisce di modificare una registrazione consolidata e blocca lo squadre fra dare e avere fuori dallo stato provvisorio; il trigger `BD0` impedisce la cancellazione di una registrazione consolidata |
| `COGE_REGISTRAZIONI_MOVIMENTI` | Riga di movimento della registrazione | `SEZIONE` + `IMPORTO` positivo al posto delle colonne dare/avere separate; `SALDO` è `COMPUTED` col segno derivato dalla sezione. Il trigger `BIU1` impedisce di movimentare un conto che non accetta movimenti diretti (solo i conti foglia di `COGE_CONTI`) |
| `COGE_SALDI` | Progressivo mensile per conto | **Non è un bilancio**: è il progressivo che serve a leggere un mastrino senza riscorrere tutte le scritture. Si ricalcola per intero con `COGE_SALDI_RICALCOLA`, non si aggiorna riga per riga |

Il file aggiunge anche `COGE_DOCUMENTI.ID_REGISTRAZIONE` e `COGE_MOVIMENTI_FINANZIARI.ID_REGISTRAZIONE` (colonne, non tabelle nuove): sono il collegamento fra documento, movimento finanziario e registrazione contabile.

## 7. Pagamenti elettronici - PagoPA e PayPal (file 09)

Una richiesta di pagamento è la stessa cosa per tutti i fornitori: un importo, un debitore, una scadenza da chiudere, un identificativo restituito dal fornitore, un indirizzo dove pagare. Il pattern è lo stesso già in uso per firma e protocollo in `OBJ_FILES`: multi-fornitore con parametri chiave-valore, non colonne dedicate.

| Tabella | Ruolo | Peculiarità |
|---|---|---|
| `COGE_PAGAMENTI_ELETTRONICI_FORNITORI` | Catalogo dei fornitori riconosciuti | Seed: `NESSUNO`, `PAGOPA`, `PAYPAL` |
| `COGE_PAGAMENTI_ELETTRONICI_CONFIGURAZIONE` | Configurazione per ente e fornitore | Contiene le credenziali e i conti (finanziario, commissioni) da usare |
| `COGE_PAGAMENTI_ELETTRONICI_CONFIG_PARAMETRI` | Parametri specifici del fornitore | Per PagoPA: identificativo dominio/intermediario/stazione, tipo versamento, codice tassonomia, IBAN accredito. Per PayPal: client id/secret, divisa, marca, pagamento in tre rate. Aggiungere un terzo fornitore non tocca la struttura, solo i parametri |
| `COGE_PAGAMENTI_ELETTRONICI` | Richiesta di pagamento | `CHK_COGE_PAG_EL_ORIGINE` impone di pagare **o** una scadenza già fatturata **o** una rata non ancora fatturata, mai entrambe |
| `COGE_PAGAMENTI_ELETTRONICI_EVENTI` | Notifiche in arrivo dal fornitore | Ogni evento si registra **prima** di essere interpretato (`ELABORATO = FALSE` di default): se l'elaborazione fallisce il fatto resta e si può rielaborare, non va perso |
| `COGE_PAGAMENTI_ELETTRONICI_LOG_REQUEST` / `_LOG_RESPONSE` | Registro delle chiamate HTTP verso il fornitore | Stesso pattern di tracciamento già usato altrove nel sistema documentale |

Quando arriva la conferma di pagamento, il motore crea il movimento finanziario e lo attribuisce alla scadenza: da quel momento è un incasso come tutti gli altri, gestito dalle tabelle del punto 5.

## 8. Interscambio con il gestionale del cliente (file 10 e 13)

Il gestionale amministrativo cambia da cliente a cliente: la regola che regge questo gruppo è che il tracciato è un dato, non è codice. Tre canali per costo crescente: `XML` (FatturaPA, universale), `TRC` (tracciato configurabile, coperto da tutti i prodotti), `API` (interfaccia applicativa nativa, solo dove conviene).

| Tabella | Ruolo | Peculiarità |
|---|---|---|
| `COGE_INTERSCAMBIO_FORNITORI` | Catalogo dei gestionali riconosciuti | `CANALE_MASSIMO` dice fin dove ci si può spingere con quel prodotto: quasi tutti importano da file esterno, l'interfaccia applicativa esiste solo sui prodotti in rete. Seed comprende Ad Hoc, Onda, TeamSystem, Mexal, B.Point/Arca; i codici sono stati riallineati nel file 13 a quelli usati dal registro Delphi degli esportatori (`ADHOC`, `MEXAL`, `ONDA`, aggiunto `GESTIONALE1`) |
| `COGE_INTERSCAMBIO_CONFIGURAZIONE` / `_CONFIG_PARAMETRI` | Configurazione per ente e fornitore | Stesso pattern multi-fornitore del punto 7; qui compaiono anche i riferimenti allo studio (nome, referente, e-mail) per i tracciati che li richiedono |
| `COGE_INTERSCAMBIO_TRACCIATI` | Intestazione di un formato di scambio | Descrive separatore campi, delimitatore testo, formato data, codifica, terminatore riga: un tracciato a lunghezza fissa o delimitato si configura, non si programma |
| `COGE_INTERSCAMBIO_TRACCIATI_RIGHE` | Tipi di record del tracciato (testata, riga, piede...) | `RIPETIBILE` distingue i record che si ripetono (le righe) da quelli singoli (la testata) |
| `COGE_INTERSCAMBIO_TRACCIATI_CAMPI` | Singolo campo di un record | `SORGENTE` porta il nome logico del dato esposto dal motore (per esempio `DOCUMENTO.NUMERO`); se il valore va tradotto, `TIPO_MAPPATURA` rimanda a `COGE_INTERSCAMBIO_MAPPATURE`. `CHECK` impone che il campo abbia una sorgente **o** un valore fisso |
| `COGE_INTERSCAMBIO_FLUSSI` | Matrice: quale canale usa un fornitore per un dato flusso e direzione | `CHECK` impone il tracciato valorizzato solo quando il canale è `TRC` |
| `COGE_INTERSCAMBIO_MAPPATURE` | Traduzione dei valori di dominio | Esempio dal file: il conto `60.10.001` di Gesty diventa il conto `4010000123` del gestionale |
| `COGE_INTERSCAMBIO_CORRISPONDENZE` | Legame fra un singolo oggetto Gesty e il suo codice presso il gestionale | Chiave sull'OID globale (`OID_INTERNO`): una sola tabella copre documenti, soggetti, registrazioni e qualunque altro oggetto, presente o futuro |
| `COGE_INTERSCAMBIO_LOTTI` | Un tentativo di esportazione o importazione | Il trigger `BU1` impedisce di riaprire un lotto già consegnato o chiuso (`E_COGE_LOTTO_GIA_CONSEGNATO`): si apre un lotto di rettifica, non si tocca quello già andato. Questo è ciò che impedisce che lo stesso fatto arrivi al gestionale due volte |
| `COGE_INTERSCAMBIO_LOTTI_RIGHE` | Righe incluse in un lotto | `ESITO_RIGA` traccia lo stato di ogni singolo oggetto esportato, indipendentemente dall'esito complessivo del lotto |
| `COGE_INTERSCAMBIO_LOG_REQUEST` / `_LOG_RESPONSE` | Registro delle chiamate | Usato solo per il canale `API` |
| `COGE_INTERSCAMBIO_LOTTI_FILES` (file 13) | File fisici prodotti da un lotto | Aggiunta successiva: Mexal produce più file per una sola esportazione (testate, righe, e per Gesty anche la contabilità analitica); mancava un posto dove tracciarli tutti sotto lo stesso lotto |

Il file 13 aggiunge inoltre la vista `COGE_INTERSCAMBIO_CORRISPONDENZE_MOTORE` (non una tabella: appiattisce i tipi di mappatura a tre lettere nei cinque nomi conosciuti dal motore Delphi `TzEsportatoriContabili`) e le procedure di gestione del lotto (`COGE_INTERSCAMBIO_LOTTO_ADD`, `_RIGA_ADD`, `_FILE_ADD`, `_CONSEGNA`, `_ANNULLA`) più la selezionabile `COGE_INTERSCAMBIO_PRIMA_NOTA_DA_ESPORTARE`, che restituisce la prima nota già appiattita nella forma attesa da `TzMovimentoContabile`.

## Nota - il ponte con la contabilità analitica COAN (file 12)

Il file 12 non introduce tabelle nuove: aggiunge il dominio `COGE_ORIGINE_CONSUNTIVO` (`MAN`/`DOC`) e la colonna `PROGETTI.COAN_ORIGINE_CONSUNTIVO`, che decide **progetto per progetto** se il consuntivo COAN continua ad arrivare dall'inserimento manuale o viene letto dai documenti contabili. Il passaggio non è mai globale: i progetti già impostati col metodo manuale restano come sono. Va ricordato che il COAN è un modulo introdotto di recente e ancora in fase di avviamento, non un modulo in disuso: i numeri bassi fotografano questo, non un abbandono.
