---
area: Timesheet
progetto: Gesty
aggiornato: 2026-10-30
rilascio: OUT/20261030-specifiche-vive-dei-progetti/016
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

# Timesheet

Questa specifica descrive come Gesty costruisce il timesheet del personale a partire dalle ore rilevate (tabella `ORE_RILEVATE`): la stampa per periodo `TIME_REPORT` (rapporti `Timesheet.fr3` di Codebri e `Time Report.fr3` di CAPAC), i modelli Excel mensili della scheda personale (procedure `TIMESHEET_ELENCO_PROGETTI_X_RISORSA`, `TIMESHEET_INTESTAZIONE`, `TIMESHEET_GIORNI`, `TIMESHEET_ATTIVITA_X_GIORNO`, `TIMESHEET_RIEPILOGO_ANNUALE`, `TIMESHEET_RILEVAMENTI`, `TIMESHEET_ELENCO_COLONNE`), le anomalie che un timesheet incompleto rivela (ore senza incarico), le autorizzazioni di pagamento e le notule che ne derivano e la pagina web "Timesheet". Descrive il comportamento atteso, non il codice. Le regole stanno quasi tutte nelle procedure del database; il resto è nel modulo dati `dmPersonaleScheda.pas` (scelta dei progetti, colonne da nascondere), nei file `.xlsx` con il loro `.xlsx.json` e nei rapporti FastReport.

**Come si lega a Rilevamento ore.** Il timesheet è una lettura: non scrive mai `ORE_RILEVATE`. Come le ore nascono, si validano, si correggono e si cancellano (incarico facoltativo, sovrapposizioni, validazione, costo congelato, storico) sta in `Rilevamento ore.md` e qui si richiama soltanto: GESTY-RIL-003, 006, 008, 009, 015, 019, 020 e DIV-RIL-3, 11.

**Fuori da quest'area**, con una specifica propria quando un lavoro le toccherà: ciclo autorizzativo degli incarichi (`Autorizzazione incarichi.md`), validazione delle autorizzazioni di pagamento e documenti contabili che ne nascono (qui compare solo la generazione dalle ore), costo orario aziendale (ticket 244), registro presenze del personale e importazione OmniaTime (`Importazione Untis e OmniaTime.md`), generatore dei modelli Word dei contratti, motore dei modelli Excel di zPack (qui solo come i modelli lo usano).

**Origine.** Ricavata il 2026-10-30 dal database master `GESTY` (catalogo vivo; la fotografia dei metadati delle 13:19 è precedente alla correzione di `TIME_REPORT` del ticket 304, quindi quella procedura è stata riletta dal catalogo), dai sorgenti in `SRC\Gesty_Group\_Sorgenti`, dal dizionario LZ in `SRC\Gesty_Group\LZ`, dai rapporti e dai modelli in `SRC\Reports\codebri` e `SRC\Gesty_Group\Reports_CAPAC`, e dalle preanalisi dei ticket 25, 284, 293, 296, 304 (il 280 solo per il formato del file `.xlsx.json`). Dove una regola viene solo da un ticket e non è stata riletta sul codice, il requisito cita il ticket. Lette e scartate perché citano la parola solo di passaggio: 150, 167, 181, 183; non toccano il timesheet: 231, 244, 246, 287.

## GESTY-TIM-001 Chi può essere stampato, e con quali filtri (`TIME_REPORT`)
`TIME_REPORT` restituisce una riga per ogni rilevamento di una risorsa in un periodo. Servono risorsa, primo e ultimo giorno: se manca uno dei tre, o la risorsa vale -1, la procedura non restituisce nessuna riga e non dà errore. Sono facoltativi progetto, tipo incarico, materia, studente (del piano personalizzato), servizio erogato e incarico; il valore -1 e la stringa vuota valgono "nessun filtro". Il periodo è libero: non è un mese. Le ore entrano in stampa a prescindere dalla validazione (GESTY-TIM-019).

### Scenario: filtro per progetto e tipo incarico
- **Dato** una risorsa con ore su due progetti nel periodo
- **Quando** si stampa indicando un progetto e un tipo incarico
- **Allora** compaiono solo i rilevamenti di quel progetto con quel tipo

### Scenario: periodo non indicato
- **Dato** una richiesta di stampa senza data di fine
- **Quando** la procedura viene eseguita
- **Allora** non esce nessuna riga e non compare nessun messaggio

## GESTY-TIM-002 Le ore senza incarico restano nel timesheet, segnalate (ticket 304)
L'incarico di un rilevamento è facoltativo (GESTY-RIL-003). `TIME_REPORT` lega l'incarico con un join esterno, prende il progetto dal rilevamento e non dall'incarico, e per ogni riga espone `SENZA_INCARICO` (vero quando manca l'incarico). La data di protocollo dell'incarico serve a scegliere la carta intestata valida in quel giorno: senza incarico si usa la data del rilevamento. Il filtro per incarico continua invece a escludere le ore senza incarico, perché chi lo usa vuole solo le ore di quell'incarico. Prima del ticket 304 queste ore sparivano dal totale stampato senza nessun avviso.

Il rapporto di Codebri (`Timesheet.fr3`) anteppone "SENZA INCARICO - " alla descrizione dell'attività delle righe segnalate. Il rapporto di CAPAC (`Time Report.fr3`) non conosce il campo (DIV-TIM-3).

### Scenario: buco fra due incarichi
- **Dato** la risorsa 37501, con ore del 2 ottobre 2026 (8,5 ore) cadute fra la fine di un incarico (30/09) e l'inizio del successivo (05/10), quindi senza incarico
- **Quando** si stampa ottobre 2026 senza filtri
- **Allora** il totale è 48,75 ore (14 righe) e le due righe del 2 ottobre hanno `SENZA_INCARICO` vero; prima della correzione il totale era 40,25

### Scenario: filtro per incarico
- **Dato** lo stesso mese
- **Quando** si stampa indicando l'incarico 100380
- **Allora** le ore senza incarico non compaiono

## GESTY-TIM-003 Raggruppamento, totali e firma del Time Report
Ogni riga porta `RAGGRUPPAMENTO` = risorsa.progetto.tipo incarico, con in coda anno.mese quando la stampa è per mese (`PARAM_STAMPA_X_MESE`); i rapporti ci costruiscono i gruppi. `TOTALE_ORE_RILEVATE` è la somma delle ore stampate per risorsa, progetto e tipo incarico; `TOTALE_ORE_ATTRIBUITE` è la somma delle ore attribuite di **tutti** gli incarichi della stessa risorsa, progetto e tipo che si sovrappongono al periodo, per intero e non in quota, e non tiene conto del filtro per incarico. L'ordine è risorsa, progetto, tipo incarico (senza distinzione di maiuscole), data, ora di inizio. `FIRMA_COME` è "Il Presidente" se la risorsa stampata è il direttore indicato dalla carta intestata dell'ente, altrimenti "Il Direttore". Le righe passano da una tabella temporanea di sessione (`TIME_REPORT_TMP`), svuotata a ogni esecuzione e a ogni commit.

### Scenario: stampa per mese
- **Dato** un periodo di tre mesi e `PARAM_STAMPA_X_MESE` vero
- **Quando** si stampa
- **Allora** `RAGGRUPPAMENTO` cambia a ogni mese, e il rapporto che raggruppa su quel campo apre un gruppo per mese

### Scenario: firma del direttore
- **Dato** una risorsa che è il direttore della carta intestata del progetto
- **Quando** si stampa il suo Time Report
- **Allora** la firma è "Il Presidente"

## GESTY-TIM-004 Da dove si stampa il Time Report e cosa propongono i due rapporti
Il rapporto riceve la risorsa dalla variabile `TimeReport_ID_Personale`, che assegnano `TPersonaleScheda`, `TRilevamentoOre`, `TRisorse` (con l'incarico selezionato) e `TProgetti` (con progetto, incarico e periodo dell'incarico) tramite `common.AssegnaVariabiliTimeReport`. Il rapporto di Codebri apre un dialogo con periodo, progetto, tipo incarico, materia, studente, servizio e identificativo dell'incarico; propone come primo giorno il 1° settembre dell'anno formativo in corso e come ultimo giorno oggi, chiama `TIME_REPORT` con `PARAM_STAMPA_X_MESE` falso e raggruppa su risorsa, progetto e tipo incarico. Il rapporto di CAPAC chiede anche la stampa per mese e raggruppa su `RAGGRUPPAMENTO`. Il dataset LZ `Timesheet.Time_Report` (modulo `Timesheet`, form `TFormTimesheet`) richiama la stessa procedura con `PARAM_STAMPA_X_MESE` falso e, dalla patch LZ del ticket 304, con l'incarico nell'ultimo argomento. Il pulsante "Timesheet" del menu principale apre `TFormTimesheet`, un guscio senza codice proprio (DIV-TIM-2).

### Scenario: periodo proposto a ottobre
- **Dato** una stampa di Codebri aperta il 30 ottobre 2026
- **Quando** compare il dialogo
- **Allora** il periodo proposto va dal 01/09/2026 al 30/10/2026

## GESTY-TIM-005 Elenchi della finestra di stampa
I progetti offerti nel dialogo sono quelli su cui la risorsa ha almeno un rilevamento nel periodo (`TIME_REPORT_LK_PROGETTI`), e i tipi incarico quelli rilevati su quel progetto nel periodo (`TIME_REPORT_LK_TIPI_INCARICO`): l'elenco guarda i rilevamenti, non gli incarichi, quindi offre anche i progetti su cui le ore sono rimaste senza incarico.

### Scenario: progetto con sole ore senza incarico
- **Dato** una risorsa con ore su un progetto in cui nessun incarico copre quelle date
- **Quando** si apre il dialogo con quel periodo
- **Allora** il progetto compare nell'elenco e, scelto, restituisce quelle ore segnalate come senza incarico

## GESTY-TIM-006 Timesheet mensile della scheda personale: i progetti del mese
Dalla scheda personale la vista "Timesheet Per Progetto" (`TIMESHEET_ELENCO_PROGETTI_X_RISORSA`) elenca per mese e anno i progetti sui quali la risorsa ha **un incarico che si sovrappone al mese**, con le ore rilevate sul progetto e il totale delle ore del mese su tutti i progetti. È l'elenco da cui nasce ogni stampa: si stampa un foglio per progetto. Un progetto su cui la risorsa ha ore ma nessun incarico nel mese non compare (DIV-TIM-4). A ogni apertura dell'elenco si riaprono i dataset del timesheet (`TimeSheetProgettiAfterOpen`).

### Scenario: progetto con incarico nel mese
- **Dato** una risorsa con incarico sul progetto A dal 01/10 al 31/10
- **Quando** si apre la vista per ottobre
- **Allora** il progetto A compare, con le ore rilevate in ottobre

### Scenario: ore su un progetto senza incarico nel mese
- **Dato** una risorsa con ore a ottobre su un progetto in cui non ha incarichi in quel mese
- **Quando** si apre la vista per ottobre
- **Allora** quel progetto non compare e non si può stampare un foglio per esso

## GESTY-TIM-007 Modelli Excel disponibili
Il foglio si genera da un modello `.xlsx` accompagnato dal suo `.xlsx.json`, che dichiara testata, dataset e bande; modello e file JSON si consegnano sempre in coppia. I modelli esistono nella cartella `Reports\codebri\PersonaleScheda` e non in quella di CAPAC, quindi la scelta di modelli dalla scheda personale dipende dal cliente:

| Modello | Tipologia | Dataset |
|---|---|---|
| `Timesheet_Giorni` | mensile riepilogativo, un giorno per riga | `Timesheet_Giorni` |
| `Timesheet_Giorni_Multiprogetto` | come sopra, una colonna per progetto scelto | `Timesheet_Giorni` |
| `Timesheet_Attivita_X_Giorno` | una riga per attività, trentuno colonne giorno | `Timesheet_Attivita_X_Giorno` |
| `Timesheet_Giorni_Mattina_Pomeriggio` | registro con fascia di mattina e di pomeriggio, solo giorni lavorati | `Timesheet_Giorni_Lavorati` |
| `Timesheet_Riepilogo_Annuale` | un mese per colonna, per progetto della risorsa | `Timesheet_Riepilogo_Annuale` |
| `Timesheet_Rilevamenti`, `Timesheet_Rilevamenti_Operatore` | un rilevamento per riga con dalle/alle | `Timesheet_Rilevamenti` |
| `Progetti\Timesheet_Riepilogo_Annuale_Risorse` | un mese per colonna, per risorsa del progetto (scheda progetto) | `Progetti.Timesheet_Riepilogo_Annuale` |

Ogni modello apre la testata `Timesheet_Intestazione` come dataset principale e il proprio dataset come dettaglio (chiavi `DUMMY_MASTER` e `DUMMY_DETAIL`). Il lettore del file JSON accetta l'ordinamento sia come numero sia come testo (`soAscending`), dopo il ticket 280. Nei modelli la modifica a mano resta possibile (`readOnly` falso): sono compilati a mano relazione sintetica, CCNL e assenze (GESTY-TIM-020).

### Scenario: cliente senza modelli
- **Dato** un cliente la cui cartella `PersonaleScheda` contiene solo `Agenda Docente.fr3` e `Riepilogo Progetti.fr3`
- **Quando** il personale apre la stampa dalla scheda personale
- **Allora** non è offerto nessun modello di timesheet

## GESTY-TIM-008 Testata del foglio (`TIMESHEET_INTESTAZIONE`)
La testata ha una riga con i dati della persona (cognome, nome, codice fiscale: assenti nella stampa dalla scheda progetto), del progetto (denominazione, codice regionale, CUP, bandiera FSE, tipo, date), dell'ente (con logo, piè di pagina e legale rappresentante dalla carta intestata valida a fine mese) e del mese. Regole di ripiego:

- **legale rappresentante:** quello della carta intestata; se manca, quello valido nel mese in `ENTI_LEGALI_RAPPRESENTANTI`;
- **capofila e partner:** se il progetto ha un ente promotore, è il capofila e l'ente Gesty il partner; altrimenti l'ente Gesty è capofila e il partner resta vuoto;
- **incarico prevalente:** fra gli incarichi della persona sul progetto che si sovrappongono al mese, quello con più ore attribuite (poi il più vecchio); da lui vengono sede abituale e inquadramento, che altrimenti è quello valido nel mese;
- **figura professionale:** descrizione del tipo incarico, poi tipo inquadramento, poi tipo incarico stesso; **mansione:** i tipi incarico dell'elenco, con la descrizione aggiuntiva, separati da virgola;
- **data di compilazione:** l'ultimo giorno rilevato nel mese sul progetto, altrimenti l'ultimo giorno del mese;
- **progetti scelti:** fino a otto, con id e titolo ("denominazione - ID codice regionale") per colonna.

### Scenario: progetto con ente promotore
- **Dato** un progetto con ente promotore "Ambito X"
- **Quando** si genera la testata
- **Allora** capofila è "Ambito X", partner è l'ente Gesty e `CAPOFILA_E_PARTNER` li riporta separati da " / "

### Scenario: mese senza rilevamenti
- **Dato** un mese in cui la persona non ha ore sul progetto
- **Quando** si genera la testata
- **Allora** la data di compilazione è l'ultimo giorno del mese

## GESTY-TIM-009 Un giorno per riga (`TIMESHEET_GIORNI`)
La procedura restituisce una riga per ogni giorno del mese, anche senza ore (28-31 righe), con giorno della settimana e indicatore di fine settimana. Per ogni giorno espone le ore sul progetto principale, le ore su altri progetti cofinanziati FSE (`PROGETTI.FSE`), le ore su altri progetti non FSE, la presenza della persona (`PERSONALE_PRESENZE`), le ore di altre attività e il totale. Il totale è progetto + altri FSE + altri non FSE + altre attività. Con il parametro "solo giorni lavorati" (modello mattina/pomeriggio) restano solo i giorni con ore sul progetto principale.

### Scenario: giorno senza ore
- **Dato** il 2 di un mese senza rilevamenti
- **Quando** si genera il foglio
- **Allora** la riga del 2 c'è, con ore a zero

### Scenario: registro dei soli giorni lavorati
- **Dato** un mese con ore sul progetto in dieci giorni
- **Quando** si usa il dataset dei giorni lavorati
- **Allora** il foglio ha dieci righe

## GESTY-TIM-010 Altre attività ordinarie
Le ore di altre attività di un giorno sono la presenza del giorno meno le ore a progetto, mai negative. Per chi non timbra (nessuna riga in `PERSONALE_PRESENZE`) valgono zero. Nel foglio per attività vale lo stesso criterio sulla riga "Altre attività ordinarie": presenza meno tutte le ore rilevate del giorno, su tutti i progetti.

### Scenario: presenza maggiore delle ore rilevate
- **Dato** una presenza di 8 ore e 6,5 ore rilevate
- **Quando** si genera il foglio
- **Allora** le altre attività del giorno sono 1,5

### Scenario: ore rilevate maggiori della presenza
- **Dato** una presenza di 4 ore e 6 ore rilevate
- **Quando** si genera il foglio
- **Allora** le altre attività del giorno sono zero e il totale del giorno è 6

## GESTY-TIM-011 Fascia di mattina e di pomeriggio
Le ore del progetto principale si dividono con uno spartiacque (predefinito 13:00). Un rilevamento che finisce entro lo spartiacque è di mattina, uno che comincia dopo è di pomeriggio, uno a cavallo si divide in proporzione ai minuti. Per ogni fascia si riporta il primo orario di inizio e l'ultimo di fine, ritagliati sullo spartiacque.

### Scenario: rilevamento a cavallo dello spartiacque
- **Dato** un rilevamento dalle 12:00 alle 14:00
- **Quando** si genera il foglio
- **Allora** la mattina va dalle 12:00 alle 13:00 per 1 ora e il pomeriggio dalle 13:00 alle 14:00 per 1 ora

## GESTY-TIM-012 Descrizione dell'attività svolta, per giorno e per rilevamento
Nel foglio per giorno (`TIMESHEET_GIORNI`) l'attività svolta è l'elenco dei testi distinti del giorno sul progetto, separati da punto e virgola, con `CONTENUTI` che ha la precedenza su `DESCRIZIONE_ATTIVITA`, troncato a mille caratteri. Nel foglio per rilevamento (`TIMESHEET_RILEVAMENTI`) il testo è `CONTENUTI`, poi `DESCRIZIONE_ATTIVITA`, poi la descrizione del tipo incarico (`ZZ_TIPI_INCARICO`), poi il tipo incarico stesso. Nel foglio per attività vale una regola diversa (GESTY-TIM-014, DIV-TIM-5).

### Scenario: due rilevamenti nello stesso giorno
- **Dato** due rilevamenti dello stesso giorno con testi diversi
- **Quando** si genera il foglio per giorno
- **Allora** la riga del giorno riporta i due testi separati da "; "

## GESTY-TIM-013 Foglio per attività, trentuno giorni (`TIMESHEET_ATTIVITA_X_GIORNO`)
Una riga per voce, con ore per ciascun giorno (`GG_01`...`GG_31`) e totale; le colonne dei giorni oltre la fine del mese sono vuote, e il modello nasconde le colonne in più (`TimesheetNascondiColonne`). Le righe sono, nell'ordine del campo `ORDINE`: le attività del progetto principale (tipo `P`, ordine 10); il totale del progetto (`TP`, 20, sempre presente); i progetti scelti alla stampa (`C`, 31-38); gli altri progetti, esclusi principale e scelti, divisi in cofinanziati FSE (`F`, 40), non FSE (`N`, 41) e servizi (`S`, 42, quando `PROGETTI.TIPO_PROGETTO = 'S'`), sempre presenti anche a zero; le altre attività ordinarie (`O`, 50). Le righe di assenza (permessi, ferie, malattia, festività, riposi) non sono prodotte: restano nel modello (GESTY-TIM-020). Il modello ordina per `ORDINE`; la procedura ordina anche per attività.

### Scenario: progetti scelti
- **Dato** un progetto principale e due progetti scelti alla stampa
- **Quando** si genera il foglio
- **Allora** i due progetti compaiono con una riga ciascuno (ordine 31 e 32) e le loro ore non entrano nelle righe "Altri progetti"

## GESTY-TIM-014 Una riga per attività svolta (ticket 296, ticket 293)
Nel ramo `P` l'etichetta della riga è `DESCRIZIONE_ATTIVITA` del rilevamento, tolti gli spazi, con ripiego sul tipo incarico quando è vuota; non contiene più il nome del progetto, che è già nella testata. Prima del ticket 296 l'etichetta era "progetto - tipo incarico" e, poiché il tipo incarico è costante per tutto l'incarico, l'operatore aveva una sola riga al mese qualunque attività avesse svolto. Il raggruppamento non distingue maiuscole e accenti (le colonne `DESCRIZIONE_ATTIVITA` e `TIPO_INCARICO` hanno collazione `UNICODE_CI_AI`, che sopravvive al `CAST` a `VARCHAR(1000)`). `CONTENUTI` non si legge in questo foglio (DIV-TIM-5).

Restano **decisioni aperte** del ticket 296: righe fisse per tutte le attività di un elenco anche a zero (il database non ha un elenco di attività per progetto), ore dei giorni in formato 7:30 invece dei centesimi (le procedure espongono già le colonne `_60`), CCNL e categoria contrattuale in testata (`RISORSE_INQUADRAMENTI` non ha i campi), ordine delle righe come l'elenco del cliente. Per ottenere righe uguali al foglio manuale i rilevamenti devono avere la descrizione compilata (a Codebri quasi nessuno dei rilevamenti QSFP ce l'ha).

### Scenario: maiuscole diverse
- **Dato** due rilevamenti dello stesso mese con attività "Visita domiciliare" e "VISITA DOMICILIARE"
- **Quando** si genera il foglio
- **Allora** c'è una sola riga

### Scenario: descrizione vuota
- **Dato** un rilevamento senza descrizione e con tipo incarico "segretariato sociale"
- **Quando** si genera il foglio
- **Allora** la riga porta "segretariato sociale"

## GESTY-TIM-015 Progetti scelti alla stampa
I due modelli con colonne o righe per progetto (`Timesheet_Giorni_Multiprogetto`, `Timesheet_Attivita_X_Giorno`) chiedono, prima di stampare, quali progetti affiancare al principale. La finestra elenca i progetti su cui la persona ha ore nel mese, escluso il principale (`lkProgettiColonne`: guarda i rilevamenti, non gli incarichi). Si prendono al massimo otto (`TIMESHEET_ELENCO_COLONNE` si ferma all'ottavo, e `TimesheetScegliProgettiColonne` ignora i successivi); annullare la scelta ferma la stampa; se non c'è nessun altro progetto con ore si stampa il solo principale senza chiedere. Colonne e righe non usate si nascondono a foglio costruito. L'elenco scelto resta in memoria fino alla stampa successiva. Gli altri modelli non chiedono nulla.

### Scenario: nove progetti selezionati
- **Dato** un mese con nove progetti oltre al principale, tutti selezionati
- **Quando** si stampa il modello multiprogetto
- **Allora** compaiono solo i primi otto e le ore del nono entrano in "Altri progetti" (DIV-TIM-7)

### Scenario: annullamento
- **Dato** la finestra di scelta aperta
- **Quando** l'utente annulla
- **Allora** la stampa non parte

## GESTY-TIM-016 Un rilevamento per riga (`TIMESHEET_RILEVAMENTI`)
Una riga per rilevamento del progetto nel mese: giorno, dalle e alle, ore, azione (tipo incarico), attività svolta (GESTY-TIM-012), sede dell'incarico (vuota senza incarico) e totale del periodo. L'ordine è data, ora di inizio, identificativo. La procedura accetta un incarico come filtro, ma il dataset LZ `PersonaleScheda.Timesheet_Rilevamenti` passa sempre `NULL`: dalla scheda personale il filtro non si usa. Include le ore senza incarico.

### Scenario: due rilevamenti nello stesso giorno
- **Dato** due rilevamenti dello stesso giorno, alle 09:00 e alle 14:00
- **Quando** si genera il foglio
- **Allora** compaiono in due righe in ordine di ora di inizio

## GESTY-TIM-017 Riepilogo annuale (`TIMESHEET_RIEPILOGO_ANNUALE`)
Una riga per coppia risorsa-progetto con le ore di ciascun mese (da primo a ultimo mese richiesti, gli altri vuoti), il totale in centesimi e un totale "base 100" arrotondato per difetto alla mezz'ora. Con raggruppamento `P` le righe sono i progetti della risorsa (scheda personale, sempre l'anno intero); con `R` sono le risorse del progetto (scheda progetto, Allegato 2). La riga porta il ruolo (il tipo incarico con più ore nel periodo), la categoria (inquadramento valido a fine periodo), codice regionale, CUP e codice fiscale. La testata della scheda progetto prende l'anno dal riepilogo.

### Scenario: arrotondamento del totale base 100
- **Dato** un totale annuo di 20,75 ore
- **Quando** si genera il riepilogo
- **Allora** il totale in centesimi è 20,75 e quello in base 100 è 20,50 (DIV-TIM-11)

## GESTY-TIM-018 Ore in due unità
Ogni colonna ore esce due volte: in centesimi di ora (`ORE_100`, 8,50 è otto ore e mezza) e in ore e minuti (`ORE_60`, 8,30 è otto ore e trenta minuti), con suffisso `_60`; la conversione è `ORE_60_FROM_ORE_100`. Il modello sceglie quale campo mostrare. `ORE_RILEVATE.ORE` è una colonna calcolata dagli orari, arrotondata al centesimo per ogni rilevamento (20 minuti valgono 0,33): i totali sono somme di valori arrotondati (DIV-TIM-12).

### Scenario: conversione
- **Dato** 8,50 ore
- **Quando** il foglio le mostra in ore e minuti
- **Allora** il valore è 8,30

## GESTY-TIM-019 Quali ore entrano nel timesheet
Il timesheet somma tutte le ore rilevate della persona, validate o no, con o senza incarico. Nessuna procedura filtra su `ORE_RILEVATE.VALIDATA`: la validazione (GESTY-RIL-008) governa i compensi (GESTY-TIM-023), non la stampa. Le ore si sommano così come sono registrate: due rilevamenti sovrapposti (GESTY-RIL-006, DIV-RIL-3) sono entrambi contati. Le ore sono sempre quelle della persona (`ID_RISORSA`), mai quelle che ha rilevato per altri.

### Scenario: ora non validata
- **Dato** un rilevamento non validato
- **Quando** si stampa il timesheet del mese
- **Allora** le sue ore sono nel totale

### Scenario: rilevamenti sovrapposti
- **Dato** due rilevamenti 13:00-17:00 e 13:30-17:00 dello stesso giorno (ticket 296)
- **Quando** si stampa il foglio
- **Allora** il giorno riporta 7,5 ore

## GESTY-TIM-020 Cosa il timesheet non produce
Per decisione del 2026-09-16 le righe di permessi, riposi compensativi, ferie, festività, malattia e le altre assenze non hanno una fonte dati (`PERSONALE_ASSENZE` è vuota, e la procedura non le produce): le compila a mano il personale nel file, dopo la generazione. Allo stesso modo restano a mano la relazione sintetica mensile, il CCNL di riferimento (`ZZ_CCNL_CONTRATTI` è vuota), gli estremi di convenzione e accordo, e la categoria contrattuale se non è in `TIPO_INQUADRAMENTO`.

### Scenario: foglio generato
- **Dato** un foglio per attività generato
- **Quando** lo si apre
- **Allora** le righe di assenza sono vuote e modificabili

## GESTY-TIM-021 Ore senza incarico: come nascono e come si sistemano (ticket 304)
Un rilevamento resta senza incarico quando nessun incarico valido per progetto, risorsa, data e tipo lo copre alla data (un buco fra due incarichi) o quando l'unico incarico possibile è esaurito (DIV-RIL-11). L'incarico non si digita: a ogni modifica dei campi da cui l'incarico dipende (data, orari, progetto, tipo incarico) la scheda personale chiama `INCARICHI_GET_PRESENZE` (`GetDettagliPresenza`) e riscrivono `ID_INCARICO` con il risultato; se nessun incarico copre la data il campo torna vuoto, e anche un valore forzato verrebbe rifiutato dal database con "Incarico non valido per questo rilevamento ore." (GESTY-RIL-005). Il rilevamento si salva comunque (GESTY-RIL-003). Non compare nessun avviso che dica perché il campo è vuoto (DIV-TIM-8). Per sistemare un caso si correggono le date dell'incarico (o se ne crea uno che copra i giorni) e poi si riapre e si salva ciascuna ora, perché ricalcoli l'incarico.

Misura del 2026-10-30: su CODEBRI le ore del 2026 senza incarico sono 504 righe per 1.324,46 ore e 35 risorse; sul master `GESTY` 4 righe e 16 ore.

### Scenario: incarico digitato a mano
- **Dato** un'ora del 2 ottobre sul progetto 84173 mentre l'incarico 100380 comincia il 5 ottobre
- **Quando** l'utente digita 100380 nel campo incarico
- **Allora** il campo torna vuoto e l'ora si salva senza incarico

### Scenario: correzione delle date
- **Dato** lo stesso caso con la data di inizio dell'incarico portata al 1° ottobre
- **Quando** l'utente riapre e salva le due ore
- **Allora** le ore prendono l'incarico 100380 e non sono più segnalate nel timesheet

## GESTY-TIM-022 Autorizzazione di pagamento dalle ore validate
`AUTORIZZAZIONI_PAGAMENTO_GENERA` raccoglie per una risorsa e un ente le ore **validate** (`VALIDATA`) con incarico, nel periodo di competenza (mese e anno di inizio e fine; la fine non può precedere l'inizio), escludendo gli incarichi collegati (`ID_INCARICO_MASTER` non vuoto: le loro ore non generano righe) e le ore che compaiono già in un'altra autorizzazione non annullata (stato diverso da `A`). Crea una autorizzazione in stato `I` per ogni coppia ente-CUP, con la riga di ogni ora che porta compenso orario lordo, cassa previdenziale e aliquota IVA presi dall'inquadramento congelato sul rilevamento (GESTY-RIL-019) o, in mancanza, dall'incarico. Un'autorizzazione validata (`V`) non si modifica nelle sue righe. Le ore senza incarico, e quelle non validate, non entrano: per questo il loro timesheet può essere più alto del pagato (GESTY-TIM-019). Le ore già trattenute da un'autorizzazione non annullata sono escluse in silenzio (DIV-TIM-10).

### Scenario: ore trattenute da un'autorizzazione mensile (ticket 25)
- **Dato** le ore di maggio 2026 di una risorsa, validate e già nell'autorizzazione mensile 498446 in stato `I`
- **Quando** si genera un'autorizzazione per settembre 2025 - giugno 2026
- **Allora** le ore di maggio non vi compaiono

### Scenario: autorizzazione annullata
- **Dato** la stessa autorizzazione portata a stato `A`
- **Quando** si rigenera per settembre 2025 - giugno 2026
- **Allora** le ore di maggio sono incluse

## GESTY-TIM-023 Notula di collaborazione occasionale
La notula è il rapporto `Nota di collaborazione.fr3`, uno per cliente (Codebri in `Reports\codebri\__Shared`, CAPAC in `Reports_CAPAC\__Shared`), stampato dall'incarico. All'apertura chiede la data e il **numero di ore, digitato dall'utente**; non legge `ORE_RILEVATE`. Calcola totale = ore × compenso orario lordo dell'incarico, ritenuta = totale × percentuale di ritenuta dell'incarico, netto a pagare = totale − ritenuta; si ferma con "Numero ore non specificate." o "Numero ore non valide." se il campo è vuoto o non numerico. La procedura `NOTULA` (ore rilevate per incarico nel periodo × compenso e costo orario) non è chiamata da nessun dataset, rapporto o codice (DIV-TIM-9). Per CAPAC il ticket 284 sostituisce la dicitura di esenzione IVA con la dichiarazione sul limite di 5.000 euro di compensi occasionali (lettera l dell'art. 67 TUIR, art. 5 DPR 633/72): il rilascio è sigillato il 2026-10-26, ma la copia del rapporto in `SRC` ha ancora il testo precedente.

### Scenario: calcolo della notula
- **Dato** un incarico con compenso orario lordo di 20 euro e ritenuta del 20%
- **Quando** si digitano 10 ore
- **Allora** totale 200 euro, ritenuta 40 euro, netto a pagare 160 euro

### Scenario: ore vuote
- **Dato** la finestra della notula
- **Quando** si conferma senza ore
- **Allora** compare "Numero ore non specificate." e la stampa non parte

## GESTY-TIM-024 Pagina web "Timesheet"
La pagina `timesheet` di GestyWeb legge il dataset `Risorsa.Timesheet` (`BASE_WEB_DATASETS`, sola lettura: niente inserimento, modifica o cancellazione, nessuna autorizzazione) che esegue `WEB_AREA_PERSONALE.RISORSA_TIMESHEET(:ID_SESSIONE)` sulla vista `ORE_RILEVATE_ELENCO`. Mostra tre totali (ore totali, ore validate, ore da validare), ciascuno filtro della griglia al clic, calcolati sui primi cinquemila rilevamenti restituiti. La scheda di inserimento è solo grafica: il pulsante avvisa che l'inserimento non è collegato al server e non salva niente (le procedure `RISORSA_TIMESHEET_INSERISCI`, `_MODIFICA` e `_ELIMINA` esistono nel pacchetto ma nessun dataset le usa). Il pacchetto dovrebbe restituire solo le ore dell'utente della sessione (DIV-TIM-1).

### Scenario: inserimento dalla pagina
- **Dato** la pagina aperta
- **Quando** l'utente compila e salva una nuova attività
- **Allora** compare l'avviso "Inserimento ore non ancora collegato al server" e nessun rilevamento viene creato

## Divergenze note

Punti in cui il codice di oggi non mantiene ciò che i requisiti dicono, o in cui due parti del codice applicano la stessa regola in modo diverso. Si correggono nella voce R-188 di `Attivita Rinviate.md`; con la correzione il requisito si aggiorna e questa sezione si accorcia. "Provato" indica che il difetto è stato riscontrato su sorgente o sul database di oggi; "dedotto" che segue dalla lettura del codice e non è stato eseguito.

| Codice | Divergenza | Conseguenza |
|---|---|---|
| 🔴 DIV-TIM-1 | Provato sul catalogo vivo del master: `WEB_AREA_PERSONALE.RISORSA_TIMESHEET` filtra `ORE_RILEVATE_ELENCO.ID_RISORSA = 10`, con il commento "TOGLIERE DOPO SVILUPPO" e `CURRENT_ID_RISORSA_WEB()` commentato; la sessione è controllata (`WEB_CHECK_SESSIONE`) ma non usata per filtrare | Chiunque apra la pagina vede le ore della risorsa 10 e non le proprie; i tre totali della pagina sono quelli di quella risorsa. L'esposizione nei database dei clienti dipende da se il pacchetto vi è stato installato (non verificato). `RISORSA_TIMESHEET_MODIFICA` ed `_ELIMINA` filtrano invece sull'utente corrente |
| 🟡 DIV-TIM-2 | Dedotto: `TFormTimesheet`/`TTimesheet` (menu "Timesheet") non assegnano `TimeReport_ID_Personale` né le altre variabili `TimeReport_*`, che assegnano solo scheda personale, rilevamento ore, risorse e progetti. Il rapporto ha come valore di progetto 22 (Codebri) e 89287 (CAPAC) | Dal pulsante del menu la risorsa potrebbe essere quella di prova scritta nel file del rapporto, o nessuna (nessuna riga). Il ticket 304 attribuisce la segnalazione al menu: da confermare con la sonda e con il cliente da quale schermata stampa |
| 🟡 DIV-TIM-3 | Provato sul file: `Time Report.fr3` di CAPAC non contiene `SENZA_INCARICO` (zero occorrenze), `Timesheet.fr3` di Codebri sì. Dopo il ticket 304 `TIME_REPORT` include le ore senza incarico per tutti | CAPAC vedrà le ore senza incarico dentro i totali, senza nessun segno che le distingua; prima del ticket 304 non le vedeva affatto |
| 🟡 DIV-TIM-4 | Provato su CODEBRI: `TIMESHEET_ELENCO_PROGETTI_X_RISORSA` parte dagli incarichi del mese. Nel 2026 ci sono 132 rilevamenti (344,25 ore, 13 risorse) su progetti in cui la persona non ha nessun incarico nel mese del rilevamento | Per quei progetti la scheda personale non offre nessun foglio: le ore compaiono solo come "Altri progetti" negli altri fogli. È la stessa famiglia del ticket 304, ma sul foglio mensile e non sul Time Report; il ticket non la tratta |
| 🟡 DIV-TIM-5 | Provato sulle procedure vive: `TIMESHEET_GIORNI` e `TIMESHEET_RILEVAMENTI` usano `CONTENUTI` e poi `DESCRIZIONE_ATTIVITA`; `TIMESHEET_ATTIVITA_X_GIORNO`, dopo il ticket 296, usa solo `DESCRIZIONE_ATTIVITA` (poi il tipo incarico). Il ticket 296 dice che il nuovo comportamento è "come" quello delle altre due | Un rilevamento con `CONTENUTI` compilato e descrizione vuota mostra il testo nel foglio per giorno e per rilevamento, e il tipo incarico nel foglio per attività |
| 🟢 DIV-TIM-6 | Provato sul codice: `TIMESHEET_ATTIVITA_X_GIORNO` separa i progetti di tipo `S` ("Altri servizi") dalla riga non FSE; `TIMESHEET_GIORNI` li conta in `ORE_ALTRI_NON_FSE` | Le ore totali coincidono, ma "Altri progetti non FSE" ha valori diversi nel foglio per giorno e in quello per attività |
| 🟢 DIV-TIM-7 | Provato sul codice: la finestra di scelta non limita a otto i progetti selezionabili; `TimesheetScegliProgettiColonne` scarta senza avviso quelli oltre l'ottavo | Chi ne seleziona nove non sa che l'ultimo è finito in "Altri progetti" |
| 🟡 DIV-TIM-8 | Provato sul codice: `GetDettagliPresenza` riscrive `ID_INCARICO` con il risultato di `INCARICHI_GET_PRESENZE` senza mostrare alcun messaggio quando torna vuoto. L'avviso in agenda proposto dal ticket 304 (punto 3, facoltativo) non esiste. `INCARICHI_GET_PRESENZE` scarta ancora gli incarichi esauriti anche se ammettono il superamento (punto 4; già DIV-RIL-11, riletta sul catalogo vivo) | L'operatore non sa perché il campo resta vuoto; le ore finiscono nel timesheet segnalate come senza incarico solo da quando vale la correzione del ticket 304 |
| 🟡 DIV-TIM-9 | Provato: la notula stampata calcola su ore digitate a mano, non sulle ore rilevate né sul monte ore dell'incarico; la procedura `NOTULA`, che fa quel calcolo, non ha dipendenze nel catalogo e nessun uso in dizionario LZ, codice Delphi o rapporti | Il compenso della notula può non coincidere con le ore validate e con quelle già pagate, e nessun controllo se ne accorge |
| 🟡 DIV-TIM-10 | Provato sul codice (confermato nei dati dal ticket 25, non riletto): `AUTORIZZAZIONI_PAGAMENTO_GENERA` esclude le ore già in una autorizzazione non annullata e non riferisce quante ne ha lasciate fuori | Una autorizzazione mensile dimenticata in stato `I` toglie in silenzio le sue ore a ogni autorizzazione più ampia; si scopre solo confrontando le ore con il timesheet |
| 🟢 DIV-TIM-11 | Dedotto: `TIMESHEET_RIEPILOGO_ANNUALE` calcola il totale "base 100" come `FLOOR(totale × 2) / 2` (per difetto alla mezz'ora); l'analisi del 2026-09-16 lo prevedeva come somma arrotondata a un decimale. Non verificato quale delle due regole richieda l'Allegato 2 | Il totale base 100 può differire dal totale in centesimi fino a mezz'ora (20,75 diventa 20,50) |
| 🟢 DIV-TIM-12 | Provato sulla funzione: `HOURS_BETWEEN` arrotonda ogni rilevamento al centesimo (20 minuti valgono 0,33) e i totali sommano i valori arrotondati | Tre rilevamenti di 20 minuti danno 0,99 ore e non 1; l'effetto è trascurabile (nel 2025 solo 5 rilevamenti su 7.863 non sono multipli di 15 minuti) |
| 🟢 DIV-TIM-13 | Provato sui file: `Reports\codebri\PersonaleScheda\Timesheet Ministeriale.xlsx` e il suo `.json` leggono il dataset `Timesheet_Mensile`, eliminato dal dizionario LZ e dal database con il lavoro del 2026-09-16 | Se il modello compare fra quelli offerti, l'anteprima non trova la sorgente dei dati |
