---
data: 2026-07-31
categoria: Progetti
status: Review
sessione: "Contabilità in Gesty: confronto con JForma"
---

# Contabilità in Gesty — Sommario

## Sintesi

⚠️ **Review.** Gesty ha già la parte difficile della contabilità di un ente di formazione — la **contabilità analitica per progetto** (costi/ricavi preventivo-consuntivo, margine, centri di costo, elaborazione automatica da ore e presenze) — ma non ha **nessun documento fiscale**: né fattura, né ricevuta, né scadenzario, né IVA. JForma è messa all'opposto: ha il ciclo fiscale leggero e completo (fatturazione elettronica, ricevute, rate con solleciti, incasso online) e un "rendiconto di corso" molto più povero del motore COAN di Gesty.

**Decisione proposta:** costruire in Gesty il **ciclo attivo documentale** (fatture, ricevute, note di credito, scadenzario, incassi), la **fattura elettronica** e un **nucleo contabile di base** (piano dei conti, causali, registrazioni in partita doppia, registri IVA), riusando i motori già in produzione in WT, e collegarlo al gestionale amministrativo del cliente con uno **strato di interscambio multi-fornitore**.

🔄 **Aggiornamento del 2026-07-31, seconda sessione.** Su indicazione del cliente il perimetro si allarga: Gesty ha un proprio nucleo contabile e dialoga in entrata e in uscita con gestionali diversi da cliente a cliente (Zucchetti Ad Hoc e Onda, TeamSystem, Passepartout, Wolters Kluwer). Restano fuori liquidazioni, dichiarativi, cespiti e bilancio. Il dettaglio è nel documento `Analisi - 20260731 - Contabilità Gesty - Interscambio Con I Gestionali.md`; le tabelle che seguono sono aggiornate di conseguenza.

---

## Confronto per aree

| Area | Gesty oggi | JForma | Divario |
|---|---|---|---|
| Contabilità analitica di progetto | ✅ Motore COAN: preventivo/consuntivo, per progetto e per esercizio, margine, ore interne/esterne | 🟡 Rendiconto di corso: costi, ricavi, MOL, centri di spesa | Gesty è **avanti** |
| Costo del personale | ✅ Costi orari, inquadramenti, costo ente calcolato, costi mensili | 🟡 Importo orario da anagrafica × ore da calendario | Gesty è **avanti** |
| Autorizzazioni al pagamento / incarichi | ✅ `AUTORIZZAZIONI_PAGAMENTO` con stato, numero, versione, CUP | 🟡 Conferimenti di incarico con modelli e invio email | Pari, con impostazioni diverse |
| Quote allievi incassate | 🟡 `STUDENTI_PAGAMENTI`: solo l'incassato, senza atteso | ✅ Contabilità corsista: pattuito, rate, incassato, semafori | 🔴 Divario |
| Rate e scadenze | 🔴 Assente | ✅ Da 1 a 12 rate, cadenza configurabile, multiprezzo, coupon | 🔴 Divario |
| Promemoria e solleciti | 🔴 Assente | ✅ Email automatiche prima della scadenza e sull'insoluto | 🔴 Divario |
| Fattura / ricevuta / nota di credito / proforma | 🔴 Assente | ✅ Modulo Fatturazione (190 €/anno) e Ricevute web (80 €/anno) | 🔴 Divario |
| IVA, split payment, bollo, ritenute | 🔴 Assente (nessun dominio IVA nel database) | ✅ Aliquote, split payment, bollo virtuale, ritenute nel rendiconto | 🔴 Divario |
| Fattura elettronica SDI | 🔴 Assente in Gesty — ✅ **completa in WT** | ✅ B2B/B2C/PA, TD01 automatica, conservazione 10 anni a consumo | 🔴 Divario colmabile per riuso |
| Incasso online (carta, PayPal) | 🔴 Assente | ✅ Gateway PayPal (80 €/anno), anche "paga in 3 rate" | 🟡 Divario opzionale |
| Ciclo passivo (fatture fornitori) | 🟡 Solo registrazione estremi in ambito servizi sociali (`SIA_FATTURE`) | 🟡 Recapito automatico del ciclo passivo | Pari, entrambi deboli |
| Prima nota, piano dei conti, registri IVA | 🔴 Assente — ✅ **presente in WT** (`COGE_*`) | 🔴 Assente (esporta in un foglio elettronico) | 🔴 Divario: **in perimetro**, per riuso da WT |
| Liquidazioni, dichiarativi, cespiti, bilancio | 🔴 Assente | 🔴 Assente | Fuori perimetro: restano al gestionale del cliente |
| Interscambio con il gestionale amministrativo | 🔴 Assente | 🟡 Solo esportazione in un foglio elettronico | 🔴 Divario: è il cuore della richiesta del cliente |
| Servizi al Lavoro | 🔴 Nessuna dimensione economica: i servizi erogati non hanno tariffa né collegamento a progetto | — (JForma non copre i servizi al lavoro) | 🔴 Divario, tutto da progettare |

---

## Cosa c'è già da riusare in WT

| Blocco WT | Contenuto | Riuso per Gesty |
|---|---|---|
| `FE_FATTURE_*`, `DOCUMENTI_FE_INVII_SDI`, `FPA_*` | Tracciato FatturaPA mappato 1:1 sulle tabelle, invii, trasmittenti, intermediari | 🟢 Alto: struttura riportabile quasi identica |
| `Schema_del_file_xml_FatturaPA_versione_121a.pas`, `DatiFatturav20.pas` | Generazione del file XML | 🟢 Alto: unit già indipendenti dall'applicazione |
| `dmFPA_WebService` | Dialogo con l'intermediario (accesso, invio, monitoraggio, notifiche, esibizione a norma) | 🟢 Alto: si riscrive come ponte con la stessa interfaccia |
| `DOCUMENTI`, `DOC_CORPO`, `DOC_IVA`, `DOC_SCADENZE`, `DOC_RICEVUTE` | Modello testata/righe/IVA/scadenze/incassi | 🟡 Medio: il modello è valido, i campi sono specifici della tassa rifiuti |
| `COGE_*` (piano dei conti a 4 livelli, registrazioni, movimenti dare/avere, saldi, causali, 29 procedure) | Contabilità generale completa | 🟢 Alto: **è l'ossatura del nucleo contabile**. In Gesty i nomi vanno per esteso (`CONTABILITA_REGISTRAZIONI` e simili), non con l'abbreviazione `COGE_` |
| `AZ_SOTTOCONTI_*`, `CG_EP_FATTURATO_PER_CONTAB_*` | Mappatura oggetti applicativi → sottoconti ed esportazione del fatturato | 🟡 Medio: modello valido per le mappature dell'interscambio |

---

## Blocchi di lavoro proposti

| # | Blocco | Priorità | Contenuto | Stima indicativa |
|---|---|---|---|---|
| 1 | Anagrafiche fiscali e listini | 🔴 | Dati fiscali su enti/aziende/allievi (destinatario SDI, regime, IBAN), aliquote IVA, sezionali di numerazione, quote attese per iscrizione | 10-15 gg |
| 2 | Ciclo attivo documentale | 🔴 | Registro documenti (fattura, ricevuta, nota di credito, proforma, preventivo), righe, riepilogo IVA, scadenzario, incassi; travaso di `STUDENTI_PAGAMENTI` | 25-35 gg |
| 3 | Nucleo contabile | 🔴 | Piano dei conti, causali, registrazioni in partita doppia generate dai documenti, registri IVA, saldi — per riuso da `COGE_*` | 20-25 gg |
| 4 | Fattura elettronica | 🔴 | Generazione XML, invio, notifiche, conservazione — per riuso da WT | 15-20 gg |
| 5 | Interscambio, gradini 1 e 2 | 🔴 | File XML FatturaPA verso il gestionale, motore dei tracciati configurabili, mappature, lotti ed esiti | 20-28 gg |
| 6 | Ciclo passivo e ponte con COAN | 🟡 | Fatture fornitori e compensi da `AUTORIZZAZIONI_PAGAMENTO` con ritenuta; i documenti alimentano costi e ricavi effettivi del COAN | 15-20 gg |
| 7 | Interscambio, gradino 3 | 🟢 | Primo connettore nativo, solo per il gestionale più diffuso fra i clienti | 10-15 gg per fornitore |
| 8 | Solleciti e incasso online | 🟢 | Promemoria e solleciti sul motore messaggi già presente, pagamento con carta/PagoPA | 10-15 gg |
| 9 | Servizi al Lavoro | 🟡 | Tariffa sul servizio erogato, maturazione del ricavo, fatturazione al committente | 12-18 gg |

Le stime sono indicative e non comprendono analisi funzionale con il cliente, collaudo e migrazione dei dati esistenti.

---

## Quadro decisionale

| Punto | Proposta |
|---|---|
| Nucleo contabile in Gesty | **Sì, nella forma ridotta:** piano dei conti, causali, prima nota, registri IVA, saldi. Fuori restano liquidazioni, dichiarativi, cespiti e bilancio |
| Collegamento con il gestionale del cliente | Strato di interscambio a tre gradini: file XML FatturaPA (universale), tracciato configurabile (copre quasi tutti), connettore nativo solo dove serve |
| Tracciati di scambio | Definiti come **dato in tabella**, non come codice: un cliente nuovo si serve con una configurazione, non con un rilascio |
| Modello dei documenti | Registro unico `DOCUMENTI_CONTABILI` con tipo registro attivo/passivo, non tabelle separate per tipo documento |
| Fattura elettronica | Riuso del percorso WT (tracciato, XML, ponte con l'intermediario), con il fornitore scelto dal cliente |
| Allegati e conservazione | Sul sistema documentale `OBJ_FILES` già progettato, non su una gestione file dedicata |
| Quote allievi | Il pattuito diventa un piano rate sull'iscrizione; `STUDENTI_PAGAMENTI` diventa l'incasso di una scadenza |
| Multi-ente | Sezionali di numerazione per ente e anno di esercizio, come già fa `ENTI_ANNI_ESERCIZIO` |

---

## Da chiarire con il cliente

| # | Domanda | Opzione consigliata |
|---|---|---|
| 1 | Quali gestionali usano oggi i clienti, e con quale diffusione? | Decide per quale prodotto vale un connettore nativo |
| 2 | Chi possiede l'anagrafica clienti: Gesty o il gestionale? | Di norma il gestionale, con importazione in Gesty |
| 3 | Chi numera le fatture emesse? | Gesty, su un sezionale dedicato concordato con chi tiene la contabilità |
| 4 | Chi riconcilia gli incassi in banca? | Il gestionale, con ritorno in Gesty per chiudere le scadenze |
| 5 | Il gestionale del cliente importa già le fatture elettroniche generando la scrittura? | Se sì il flusso dell'attivo si chiude subito e a costo zero |
| 6 | Con quale intermediario si trasmette allo SDI? | Lo stesso già usato in WT, se il cliente non ne ha uno proprio |
| 7 | Chi emette i documenti: un solo ente o più enti e sedi con numerazioni separate? | Sezionale per ente |
| 8 | Nei Servizi al Lavoro si fattura a ore rendicontate o a servizio erogato? | Da definire: cambia il modello dati |
| 9 | Serve l'incasso online delle quote o basta il bonifico? | Rinviare a una fase successiva |
| 10 | Si migrano i 5.522 pagamenti allievi già registrati? | Sì, come incassi senza documento collegato |
| 11 | Con quale cliente si parte come pilota, e chi tiene la sua contabilità è disponibile a validare tracciato e sezionali? | Serve il consenso di chi riceve i dati prima di andare in produzione |

---

## Fonti

- Documenti collegati nella stessa cartella: `Analisi - 20260731 - Contabilità Gesty - Dettaglio.md` e `Analisi - 20260731 - Contabilità Gesty - Interscambio Con I Gestionali.md`.
- Database `GESTY` letto il 2026-07-31 (ultimo pagamento registrato: 2026-07-27).
- Sorgenti `D:\AI\SRC\Gesty` e `D:\AI\SRC\WT`.
- [Caratteristiche Jforma](https://www.jforma.it/caratteristiche/), [Moduli aggiuntivi](https://www.jforma.it/moduli-aggiuntivi/), [Fatturazione](https://www.jforma.it/fatturazione/), [Prezzi](https://www.jforma.it/prezzi/), [Rendiconto di corso](https://documentazione.jforma.it/docs/rendiconto-di-corso/), [Gestione rate e pagamenti](https://documentazione.jforma.it/docs/gestione-rate-e-pagamenti/), [Fatturazione automatica](https://documentazione.jforma.it/docs/fatturazione-automatica/).
