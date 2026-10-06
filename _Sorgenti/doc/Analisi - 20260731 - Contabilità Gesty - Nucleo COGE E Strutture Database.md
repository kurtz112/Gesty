---
data: 2026-07-31
categoria: Progetti
status: Review
sessione: "Contabilità in Gesty: confronto con JForma"
---

# Nucleo contabile COGE — progetto e strutture del database

## 1. Sintesi

⚠️ **Review.** Sistema nuovo, non trapiantato da WT. Sono proposte **57 tabelle** (52 con prefisso `COGE`, 5 sul lato formativo per quote e tariffe), **35 domini**, **7 eccezioni**, **111 trigger** e 4 procedure di servizio. Gli script sono in `sql\`, pronti da eseguire in ordine su una copia del database. L'identificatore più lungo è di 43 caratteri: sta nel limite di Firebird 4 e oltre, come già fanno le tabelle `OBJ_FILES_MAIL_E_MESSAGGI_CONFIG_PARAMETRI` presenti in produzione.

Tre scelte che cambiano rispetto all'analisi precedente, tutte su indicazione dell'utente:

| Punto | Scelta |
|---|---|
| Strutture di WT | **Non si copiano.** Sono datate e legate alla tassa rifiuti: si riprende solo il concetto, dove regge |
| Prefisso | **`COGE`**, come piace all'utente. È un'abbreviazione, quindi una deroga consapevole alla regola dei nomi per esteso: vale solo per il prefisso, non per i nomi delle colonne |
| Fattura elettronica | Si usa la libreria già esistente in `D:\AI\SRC\FE`, non se ne scrive un'altra |
| Pagamenti | PagoPA **e** PayPal, con lo stesso motore multi-fornitore |

---

## 2. Che cosa si è preso dalla realtà del database, non dalle convenzioni

Prima di disegnare, le strutture di Gesty sono state lette:

| Meccanismo reale | Conseguenza sul progetto |
|---|---|
| Ogni chiave primaria nasce da `OBJECT_CREATE(NEW.ID, 'NOME_TABELLA')` in un trigger `_BI0`: esiste un **OID globale** valido per tutto il database | Tutte le tabelle nuove hanno lo stesso trigger. E soprattutto: i collegamenti polimorfi si fanno con una sola colonna `OID`, senza colonne di tipo e senza tabelle ponte |
| Le colonne di traccia sono valorizzate dal trigger `_LOG` con `USR_LOG` | Riprodotto su tutte le tabelle nuove, comprese quelle di registro |
| I motori documentali seguono lo schema `*_FORNITORI` + `*_CONFIGURAZIONE` + `*_CONFIG_PARAMETRI` + `*_LOG_REQUEST` + `*_LOG_RESPONSE`, con `ID_TENANT` verso `ENTI` | Fattura elettronica, pagamenti elettronici e interscambio usano lo stesso schema, campo per campo: chi conosce il protocollo conosce già la contabilità |
| Gli allegati passano da `OBJ_FILES` con `OBJ_FILES_REFS.OID_REF` | Nessuna tabella di allegati nel nucleo contabile: si riusa quella |
| `ENTI_ANNI_ESERCIZIO` definisce già gli anni per ente | `COGE_ESERCIZI` aggiunge solo lo stato contabile, non duplica l'anagrafica |
| I domini `VALUTA_2`, `VALUTA_5`, `PERCENTUALE`, `ANNO_ESERCIZIO`, `CENTRO_DI_COSTO`, `STR_*` esistono già | Nessun dominio di comodo reinventato |

---

## 3. Che cosa è deliberatamente diverso da WT

| WT | Qui | Perché |
|---|---|---|
| Piano dei conti a quattro livelli fissi (`COGE_PCON_01_GRUPPI` … `_04_SOTTOCONTI`) | `COGE_CONTI`: un solo albero autoreferenziale con `LIVELLO` e `ID_CONTO_PADRE` | I clienti hanno piani dei conti diversi, e a tre o cinque livelli. Il livello è un dato, non una struttura |
| `COGE_REG_MOVIMENTI` con due colonne `DARE` e `AVERE` più un `CHECK` che impedisce di riempirle entrambe | `SEZIONE` più `IMPORTO` positivo, con `SALDO` calcolato | La stessa informazione con metà delle occasioni di sbagliare |
| Contabilizzazione scritta nelle procedure `COGE_GENERA_REG_ENTRATE*` | `COGE_CAUSALI_RIGHE`: lo schema della scrittura è una tabella | Cambiare il modo in cui una fattura si contabilizza diventa una modifica di dati. Ogni cliente ha il suo |
| `DOCUMENTI` con 80 colonne, metà specifiche della tassa rifiuti (Belfiore, contratto, macrocategoria) | `COGE_DOCUMENTI` con i soli dati fiscali, e l'imputazione al progetto sulle righe | Il documento non deve sapere di che dominio è |
| Tabelle separate per ricevute, storni, note | Registro unico con `TIPO_DOCUMENTO` e `TIPO_REGISTRO` | Fattura, ricevuta e nota di credito hanno la stessa struttura: cambia il segno e la numerazione |
| Nessun collegamento generico all'oggetto di origine | `ORIGINE_OID` su righe, movimenti e registrazioni | Una sola colonna copre rata, servizio erogato, compenso, e le origini che verranno |

---

## 4. Fattura elettronica: si usa la libreria di `D:\AI\SRC\FE`

La libreria è già quello che serve, ed è nuova:

| Cosa c'è | Dettaglio |
|---|---|
| 16 tabelle `FE_*` | `FE_FATTURA`, `FE_TRASMISSIONE`, `FE_CEDENTE`, `FE_CESSIONARIO`, `FE_INTERMEDIARIO`, `FE_FATTURA_BODY`, `FE_DATI_GENERALI`, `FE_DOCUMENTO_CORRELATO`, `FE_DATI_VEICOLI`, `FE_BENE_SERVIZIO`, `FE_SCONTO_MAGGIORAZIONE`, `FE_RIEPILOGO_IVA`, `FE_DATI_PAGAMENTO`, `FE_DETTAGLIO_PAGAMENTO`, `FE_ALLEGATO`, `FE_IMPORTAZIONE_LOG` — la gerarchia XML mappata una a una |
| 69 domini | Compresi i codici ministeriali già vincolati: `FE_NATURA`, `FE_MODALITA_PAGAMENTO`, `FE_ESIGIBILITA_IVA`, `FE_TIPO_DOCUMENTO`, `FE_FORMATO_TRASMISSIONE` |
| 16 procedure `FE_*_ADD` | Già incapsulate in `FE_StoredProcs.pas` con le proprietà `Nullable<T>` |
| `FE_XMLImport.pas` | Importazione completa del file XML, con registro degli esiti |

**Le tabelle `FE_*` si installano così come sono e non si modificano**, così restano rigenerabili quando la libreria evolve. Tutto ciò che manca sta nelle tabelle `COGE_FATTURE_ELETTRONICHE*`: il legame con il documento contabile, le trasmissioni, le notifiche dello SDI, la configurazione del recapitatore.

🔴 **Lacuna da colmare:** la libreria oggi sa solo **importare**. La generazione dell'XML in uscita va scritta come modulo gemello (`FE_XMLExport`), che legge le stesse tabelle `FE_*` al contrario. È l'unico pezzo di lavoro vero sulla fattura elettronica: il modello dati e i codici ci sono già.

Il flusso in uscita diventa: documento → righe `FE_*` → file XML → recapitatore → notifiche → stato del documento aggiornato dal trigger.

Il flusso in entrata è già pronto e serve il ciclo passivo: file XML ricevuto → `ImportaXml` → riga in `COGE_FATTURE_ELETTRONICHE` con `ID_DOCUMENTO` nullo → l'operatore la trasforma in documento passivo imputandola ai progetti.

---

## 5. Pagamenti elettronici: PagoPA e PayPal

Un solo modello per tutti e due, perché la sostanza è la stessa: un importo, un debitore, una scadenza da chiudere, un identificativo restituito dal fornitore, un indirizzo dove si paga.

| | PagoPA | PayPal |
|---|---|---|
| Identificativo | IUV | Identificativo dell'ordine |
| Riferimento per il debitore | Codice avviso | Indirizzo di pagamento |
| Parametri propri | Dominio, intermediario, stazione, tassonomia, cifra ausiliaria, IBAN di accredito | Identificativo e segreto dell'applicazione, divisa, pagamento in tre rate |
| Commissioni | A carico del debitore o dell'ente | Trattenute sull'incasso |

I parametri specifici stanno in `COGE_PAGAMENTI_ELETTRONICI_CONFIG_PARAMETRI` come coppie chiave-valore: **aggiungere un terzo fornitore non tocca nessuna tabella**.

Quando arriva la conferma, il motore crea il movimento finanziario e lo attribuisce alla scadenza: da lì in poi è un incasso come tutti gli altri. Gli eventi in arrivo si registrano prima di essere interpretati (`COGE_PAGAMENTI_ELETTRONICI_EVENTI`), così una notifica che fallisce l'elaborazione non si perde.

---

## 6. Mappa delle tabelle

### 6.1 🗄️ Base — `sql\02_tabelle_base.sql`

| Tabella | Contenuto |
|---|---|
| `COGE_ESERCIZI` | Stato contabile dell'esercizio, sopra `ENTI_ANNI_ESERCIZIO` |
| `COGE_CONTI` | Piano dei conti ad albero, con `ACCETTA_MOVIMENTI` sui soli conti di ultimo livello |
| `COGE_CONTI_FINANZIARI` | Casse, banche, conti di moneta elettronica |
| `COGE_ALIQUOTE_IVA` | Aliquota, natura, esigibilità, quota indetraibile, conto IVA |
| `COGE_REGISTRI_IVA` | Vendite, acquisti, corrispettivi |
| `COGE_CAUSALI` + `COGE_CAUSALI_RIGHE` | Schema della scrittura: sezione, origine dell'importo, origine del conto |
| `COGE_TIPI_DOCUMENTO` | Dieci tipi già caricati, con il codice del tracciato elettronico |
| `COGE_SEZIONALI` | Numerazione per ente, tipo e anno |
| `COGE_MODALITA_PAGAMENTO`, `COGE_TERMINI_PAGAMENTO` | Modalità con il codice `MP*` e regole di rateazione |

### 6.2 🗄️ Soggetti — `sql\03_soggetti.sql`

| Tabella | Contenuto |
|---|---|
| `COGE_SOGGETTI` | Anagrafica fiscale unificata, con il collegamento facoltativo ad `ANAGRAFE`, `AZIENDE`, `ENTI` o `RISORSE` e il vincolo che ne ammette al massimo uno |
| `COGE_SOGGETTI_COORDINATE_BANCARIE` | Coordinate, oggi assenti per aziende ed enti |

### 6.3 🗄️ Quote e tariffe — `sql\04_quote_e_listini.sql`

| Tabella | Contenuto |
|---|---|
| `PROGETTI_QUOTE` | Listino del progetto: quota intera e quote ridotte |
| `STUDENTI_PROGETTI_QUOTE` | Quota pattuita sull'iscrizione, con il pagante che può non essere l'allievo |
| `STUDENTI_PROGETTI_QUOTE_RATE` | Piano rate, stato, solleciti — **è l'importo atteso che oggi manca** |
| `SAL_SERVIZI_TARIFFE`, `SAL_UTENTI_SERVIZI_RICAVI` | Tariffa e ricavo maturato dei servizi al lavoro |

### 6.4 🗄️ Documenti — `sql\05_documenti.sql`

`COGE_DOCUMENTI`, `COGE_DOCUMENTI_RIGHE`, `COGE_DOCUMENTI_IVA`, `COGE_DOCUMENTI_SCADENZE`, `COGE_DOCUMENTI_RITENUTE`, `COGE_DOCUMENTI_COLLEGAMENTI`.

Regole messe nel database, non nell'applicazione:

- in bozza il numero **non esiste**: il vincolo lo impone, così la numerazione non ha buchi;
- un documento emesso non cambia numero, sezionale o data, e non si cancella: il trigger solleva `E_COGE_DOCUMENTO_EMESSO`;
- lo stato della scadenza discende dagli importi, lo calcola il trigger.

### 6.5 🗄️ Incassi — `sql\06_incassi_e_pagamenti.sql`

`COGE_MOVIMENTI_FINANZIARI` e `COGE_MOVIMENTI_FINANZIARI_RIGHE`: l'attribuzione è a parte perché un bonifico può saldare tre fatture e una fattura può essere saldata da tre bonifici. Due procedure tengono allineati gli importi derivati e un trigger impedisce di attribuire più del residuo.

Qui confluiscono i 5.522 pagamenti di `STUDENTI_PAGAMENTI`, come movimenti senza attribuzione, conservando l'OID di origine.

### 6.6 🗄️ Prima nota — `sql\07_registrazioni.sql`

`COGE_REGISTRAZIONI`, `COGE_REGISTRAZIONI_MOVIMENTI`, `COGE_SALDI`. Una registrazione non provvisoria deve quadrare, una consolidata non si tocca, si movimentano solo i conti che accettano movimenti: tutto imposto dai trigger.

### 6.7 🗄️ Fattura elettronica — `sql\08_fattura_elettronica.sql`

`COGE_FATTURE_ELETTRONICHE` (ponte con `FE_FATTURA`), `_INVII`, `_NOTIFICHE`, più le cinque tabelle del motore multi-fornitore. Lo stato della fattura elettronica si riflette da solo sullo stato del documento.

### 6.8 🗄️ Pagamenti elettronici — `sql\09_pagamenti_elettronici.sql`

`COGE_PAGAMENTI_ELETTRONICI`, `_EVENTI`, più le cinque tabelle del motore. Fornitori già caricati: `NESSUNO`, `PAGOPA`, `PAYPAL`.

### 6.9 🗄️ Interscambio — `sql\10_interscambio.sql`

| Tabella | Contenuto |
|---|---|
| `COGE_INTERSCAMBIO_FORNITORI` | Gestionali riconosciuti, con il canale massimo supportato |
| `COGE_INTERSCAMBIO_CONFIGURAZIONE` + `_CONFIG_PARAMETRI` | Configurazione per ente e fornitore |
| `COGE_INTERSCAMBIO_FLUSSI` | **Matrice canale per flusso**: impedisce che lo stesso fatto arrivi al gestionale per due strade e venga registrato due volte |
| `COGE_INTERSCAMBIO_TRACCIATI` + `_RIGHE` + `_CAMPI` | Il tracciato come dato: posizione, lunghezza, allineamento, formato, sorgente |
| `COGE_INTERSCAMBIO_MAPPATURE` | Traduzione dei codici: conto, causale, aliquota, sezionale, centro di costo |
| `COGE_INTERSCAMBIO_CORRISPONDENZE` | OID interno ↔ codice presso il gestionale, chiave dell'operazione ripetibile |
| `COGE_INTERSCAMBIO_LOTTI` + `_RIGHE` | Elaborazioni, esiti riga per riga, righe scartate |

Fornitori già caricati: `GENERICO`, `ZUC_ADHOC`, `ZUC_ONDA`, `TEAMSYSTEM`, `PASSEPARTOUT`, `WOLTERSKLUWER`, `NESSUNO`.

---

## 6.10 ⚙️ Procedure di generazione — `sql\11_procedure_generazione.sql`

Quindici procedure. Le prime sette sono il motore, le altre otto sono le porte d'ingresso dai dati di Gesty.

| Procedura | Che cosa fa |
|---|---|
| `COGE_SEZIONALE_GET` | Trova il sezionale attivo, altrimenti solleva `E_COGE_SEZIONALE_MANCANTE` |
| `COGE_DOCUMENTO_RICALCOLA` | Rifà gli imponibili di riga, ricostruisce il riepilogo IVA e riporta i totali in testata. La scissione dei pagamenti non cambia l'imposta: cambia il netto a pagare |
| `COGE_DOCUMENTO_GENERA_SCADENZE` | Se il documento nasce da rate di iscrizione le scadenze ricalcano le rate; altrimenti applica il termine di pagamento, con cadenza, giorno fisso e fine mese. L'ultima rata assorbe l'arrotondamento |
| `COGE_REGISTRAZIONE_ADD` | Testata di prima nota, con numerazione e protocollo IVA per esercizio; rifiuta l'esercizio chiuso |
| `COGE_REGISTRAZIONE_MOVIMENTO_ADD` | Movimento singolo; un importo negativo viene registrato nella sezione opposta invece che con il segno meno |
| `COGE_DOCUMENTO_GENERA_REGISTRAZIONE` | Legge le righe della causale e costruisce la scrittura: l'imponibile si espande per conto, l'imposta per aliquota. La registrazione diventa definitiva solo se quadra |
| `COGE_DOCUMENTO_EMETTI` | Numera il documento prelevando il progressivo in aggiornamento sul sezionale, poi genera scadenze e scrittura |
| `COGE_DOCUMENTO_ADD` / `COGE_DOCUMENTO_RIGA_ADD` | Bozza e righe, con i dati fiscali del soggetto congelati in testata |
| `COGE_QUOTA_GENERA_RATE` | Piano rate della quota di iscrizione; si rifiuta di rigenerare se una rata è già stata fatturata |
| `COGE_DOCUMENTO_GENERA_DA_RATE` | Fattura le rate non ancora fatturate di un'iscrizione |
| `COGE_DOCUMENTO_GENERA_DA_SERVIZI_SAL` | Fattura al committente i servizi al lavoro maturati in un periodo |
| `COGE_DOCUMENTO_GENERA_DA_AUTORIZZAZIONE` | Compenso passivo da un'autorizzazione al pagamento: ore rilevate collegate × compenso orario di riga, più la ritenuta d'acconto del soggetto |
| `COGE_DOCUMENTO_STORNA` | Nota di credito che copia le righe; è il segno del tipo documento a invertirle |
| `COGE_INCASSO_REGISTRA` | Movimento finanziario più attribuzione alla scadenza; la rata di iscrizione segue lo stato della scadenza |

Il filo che tiene insieme le porte d'ingresso è `ORIGINE_OID`: una rata, un servizio o un'autorizzazione risultano già fatturati quando esiste una riga di documento che li punta. Nessun contatore, nessun flag da tenere allineato.

---

## 6.11 🔗 Rapporto con il COAN — `sql\12_ponte_coan.sql`

**Verifica fatta sui sorgenti delle procedure COAN.** Oggi il consuntivo arriva da quattro campi compilati a mano:

| Voce COAN | Origine attuale | Righe in produzione |
|---|---|---|
| `RICAVI_CORSI_A_PAGAMENTO_CONSUNTIVO` | `PROGETTI.RICAVO_EFFETTIVO_CORSO_A_PAGAMENTO`, un campo per progetto | — |
| `RICAVI_EFFETTIVI` | `COAN_RICAVI_EFFETTIVI`, inserimento manuale | — |
| `RICAVI_VARI_CONSUNTIVO` | `PROGETTI_RICAVI_VARI.IMPORTO_CONSUNTIVO` | **0** |
| `COSTI_VARI_CONSUNTIVO` | `PROGETTI_COSTI_VARI.IMPORTO_CONSUNTIVO` | **1** |
| Costo del personale | Ore rilevate e inquadramenti — **già automatico** | 1.459 progetti |

⚠️ **Come vanno letti questi numeri.** Il COAN è stato introdotto da poco ed è in **fase di avviamento**: non tutte le modalità di determinazione dei ricavi sono state realizzate e le voci di dettaglio non sono ancora popolate. Non è un modulo trascurato, è un modulo giovane. Il fatto tecnico che conta per questo progetto resta però: la parte automatica funziona, quella che dipende da un inserimento manuale è ferma, e alimentarla dai documenti è la via più rapida per completare l'avviamento.

**Che cosa cambia con i documenti.** Le stesse quattro voci si leggono dai fatti:

| Voce | Nuova origine |
|---|---|
| Ricavi corsi a pagamento | Righe dei documenti attivi imputate al progetto, al netto delle note di credito |
| Ricavi vari | Le stesse righe, per i progetti che non sono corsi a pagamento |
| Ricavi effettivi | **Incassato**, non fatturato: somma delle attribuzioni ai documenti del progetto |
| Costi vari | Righe dei documenti passivi imputate al progetto |

🔴 **Il rischio da conoscere: il doppio conteggio.** Il costo del personale arriva già dalle ore rilevate. I documenti passivi di tipo `CMP` (compenso a collaboratore) sono **lo stesso costo visto dal lato documentale**: se entrassero nei costi vari, il margine di ogni progetto risulterebbe dimezzato. Le procedure li escludono per tipo documento, ed è la riga di codice più importante del file.

🟡 **Il passaggio non può essere globale.** I progetti già impostati con il metodo manuale devono restare come sono, e l'avviamento del COAN non va interrotto a metà. Per questo il file aggiunge `PROGETTI.COAN_ORIGINE_CONSUNTIVO` (`MAN` o `DOC`, predefinito `MAN`): la nuova origine vale progetto per progetto e le installazioni esistenti non cambiano comportamento finché nessuno la commuta.

| Procedura | Che cosa fa |
|---|---|
| `COAN_ELABORA_RICAVI_DA_DOCUMENTI_PER_PROGETTO` | Ricavi e incassato dei progetti con origine documentale |
| `COAN_ELABORA_COSTI_DA_DOCUMENTI_PER_PROGETTO` | Costi vari dai documenti passivi, esclusi i compensi |
| `COAN_ELABORA_DA_DOCUMENTI_PER_ESERCIZIO` | Le stesse grandezze per anno di esercizio, che è quello del documento e non quello del progetto: un progetto biennale fattura su due esercizi |
| `COAN_ELABORA_CON_DOCUMENTI` | Orchestratore: richiama `COAN_ELABORA` **senza modificarla**, poi sovrascrive i soli progetti con origine documentale e rifà totali e margini |
| `COAN_VERIFICA_QUADRATURA_DOCUMENTI` | Procedura selezionabile: elenca i progetti dove consuntivo COAN e fatturato non coincidono. Serve durante il passaggio, per capire che cosa non torna prima di fidarsi |

`COAN_ELABORA` resta intatta: nessuna procedura esistente viene riscritta.

---

## 6.12 💻 Esportazione della fattura elettronica — `src\uFE_XMLExport.pas`

Il modulo gemello di `uFE_XMLImport`: legge le stesse tabelle `FE_*` al contrario e produce il file XML. L'importazione scrive con le procedure `FE_*_ADD`, l'esportazione legge con query dirette, perché in lettura non serve incapsulare nulla.

| Metodo | Uso |
|---|---|
| `EsportaXml(IdFattura)` | Restituisce il documento XML completo |
| `EsportaSuFile(IdFattura, NomeFile)` | Lo scrive su disco in UTF-8 **senza distinta di byte iniziale**: alcuni recapitatori la rifiutano |
| `ComponiNomeFile(IdFattura)` | Nome secondo le specifiche: paese, codice del trasmittente, progressivo |

Scelte di dettaglio che evitano gli scarti più comuni:

- nessun nodo viene creato se il valore è vuoto — il tracciato rifiuta gli elementi vuoti;
- separatore decimale sempre il punto, con `TFormatSettings.Invariant`;
- due decimali sugli importi, cinque su quantità, prezzo unitario e totale di riga;
- `versione` dell'elemento radice presa dal formato di trasmissione (`FPA12` o `FPR12`), non da un valore fisso.

⚠️ Due lacune della libreria emerse scrivendo l'esportazione, segnate nel codice con `MANCA_IN_LIBRERIA`:

| Elemento del tracciato | Problema |
|---|---|
| `DatiCassaPrevidenziale` | Nel tracciato è ripetibile; `FE_DATI_GENERALI` ha il solo campo `IMPORTO_CASSA`. Serve una tabella dedicata per esporlo |
| `DataRiferimentoTerminiPagamento` | Non ha colonna in `FE_DETTAGLIO_PAGAMENTO` |

Nessuna delle due blocca la fatturazione ordinaria di un ente di formazione, ma vanno chiuse prima di usare la libreria con professionisti che hanno cassa previdenziale.

---

## 7. Ordine di esecuzione degli script

| # | File | Contenuto | Dipende da |
|---|---|---|---|
| 1 | `01_domini.sql` | 35 domini e 7 eccezioni | — |
| 2 | `02_tabelle_base.sql` | Piano dei conti, aliquote, causali, sezionali | 01 |
| 3 | `03_soggetti.sql` | Anagrafica fiscale | 02 |
| 4 | `04_quote_e_listini.sql` | Quote, rate, tariffe dei servizi | 03 |
| 5 | `05_documenti.sql` | Documenti, righe, IVA, scadenze | 04 |
| 6 | `06_incassi_e_pagamenti.sql` | Movimenti finanziari | 05 |
| 7 | `07_registrazioni.sql` | Prima nota e saldi | 06 |
| 8 | `08_fattura_elettronica.sql` | Ponte con la libreria FE | 05, **più le tabelle `FE_*` già installate** |
| 9 | `09_pagamenti_elettronici.sql` | PagoPA e PayPal | 06 |
| 10 | `10_interscambio.sql` | Tracciati, mappature, lotti | 07 |
| 11 | `11_procedure_generazione.sql` | 15 procedure di generazione | 01-10 |
| 12 | `12_ponte_coan.sql` | Origine documentale del consuntivo COAN | 11 |
| 13 | `13_allineamento_esportatori.sql` | Allineamento col motore Mexal / Ad Hoc, file dei lotti, prima nota da esportare | 12 |

⚠️ Prima dell'8 va eseguito `D:\AI\SRC\FE\FE_Struttuda_Database.sql`, limitatamente alle tabelle, ai domini e alle procedure `FE_*`: la parte `USR_*` di quello script appartiene all'applicazione di prova e in Gesty esiste già.

⚠️ Gli script non sono stati eseguiti su nessun database. Vanno provati su una copia, in quest'ordine, e riletti con la lente del cliente pilota prima di toccare la produzione.

---

## 8. Che cosa resta da progettare

| Punto | Nota |
|---|---|
| Piano dei conti iniziale | Serve un piano dei conti di partenza per un ente di formazione, con le causali già configurate: senza quello le procedure girano a vuoto |
| Firma del file XML | L'esportazione produce il file; la firma resta al recapitatore o al motore di firma già presente |
| Cassa previdenziale nel tracciato | Manca la tabella nella libreria FE, vedi 6.12 |
| Liquidazione IVA | Fuori perimetro: resta al gestionale del cliente |
| Oggetti LZ | Ogni form nuova va creata nei metadati LZ. Rinominare in seguito un modulo dati o una form lascia orfani gli oggetti |
| Migrazione | `STUDENTI_PAGAMENTI` → `COGE_MOVIMENTI_FINANZIARI`; le anagrafiche esistenti → `COGE_SOGGETTI`, solo per chi ha davvero un documento |

---

## Fonti

- Documenti collegati nella stessa cartella: sommario, dettaglio, interscambio con i gestionali.
- Struttura reale del database `GESTY` letta il 2026-07-31: trigger `OBJECT_CREATE` e `USR_LOG`, schema dei motori documentali, domini disponibili.
- Libreria fattura elettronica: `D:\AI\SRC\FE` (`FE_Struttuda_Database.sql`, `FE_StoredProcs.pas`, `FE_XMLImport.pas`, `schema.txt`).
