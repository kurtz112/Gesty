---
area: SIA
progetto: Gesty
aggiornato: 2026-11-08
rilascio: OUT/20261106-macrogruppi-e-residui-sia-codebri/003
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

# SIA - Servizio Inclusione Adulti

Questa specifica descrive, per ora, i soli macrogruppi del modulo SIA e i filtri sulla barra di Interventi, Finanziamenti e Riepilogo fatture (modulo LZ `SIA_ServizioInclusioneAdulti`, form `TFormSIA_ServizioInclusioneAdulti`). Il resto del modulo (coperture, fatture, rendicontazione) si aggiunge quando un lavoro lo toccherà.

**Fuori da questa specifica:** trasferimenti fra finanziamenti, importo liberato o consuntivo degli interventi chiusi, riepilogo dei residui e controllo di coerenza fra macrogruppo dell'intervento e della copertura. Sono proposte in attesa delle risposte del cliente, vedi `OUT\20261106-macrogruppi-e-residui-sia-codebri`.

**Origine.** Scritta il 2026-11-06 per il rilascio dei macrogruppi, riconsegnata il 2026-11-08 con il rilascio 003, che riprende senza modifiche il 001 scartato perché prematuro. La migrazione è stata provata su una copia di produzione di CODEBRI.

## GESTY-SIA-001 I macrogruppi stanno in una tabella
I macrogruppi sono le righe di `SIA_MACROGRUPPI`: codice, descrizione, quota percentuale (solo informativa, nessun calcolo la usa), ordine e note. Il cliente ne aggiunge altri dalla voce «Macrogruppi» di «Tabelle SIA», senza modifiche al programma. Le righe iniziali sono `EQUIPE` (30%) e `COMUNI` (70%).

## GESTY-SIA-002 Ogni finanziamento appartiene a un macrogruppo
`SIA_FINANZIAMENTI.MACROGRUPPO_SIA` è obbligatorio: ogni quota appartiene a un solo gruppo.

### Scenario: finanziamento senza macrogruppo
- **Dato** un finanziamento nuovo
- **Quando** si salva senza macrogruppo
- **Allora** il salvataggio viene rifiutato

## GESTY-SIA-003 Il macrogruppo dell'intervento è facoltativo
`SIA_INTERVENTI.MACROGRUPPO_SIA` serve a selezionare gli interventi e si sceglie nella scheda. Può restare vuoto: la migrazione lo riempie solo se tutte le coperture dell'intervento stanno nello stesso macrogruppo, e lascia vuoti gli interventi senza copertura e quelli con coperture di due macrogruppi.

## GESTY-SIA-004 Filtri degli interventi
La barra della vista Interventi ha i filtri Macrogruppo, Comune, Anno e Stato, tutti vuoti all'apertura. Un filtro vuoto non limita l'elenco. Anno mostra gli interventi attivi in quell'anno: inizio entro l'anno e fine non precedente. L'anno parte vuoto perché la form può aprire un intervento per identificativo, anche di un altro anno.

## GESTY-SIA-005 Filtri dei finanziamenti
La barra della vista Finanziamenti ha i filtri Macrogruppo, Comune e Anno. Macrogruppo e Comune partono vuoti, Anno parte dall'anno corrente e mostra i finanziamenti la cui validità tocca quell'anno.

## GESTY-SIA-006 Filtri del riepilogo fatture
La barra del Riepilogo fatture ha i filtri Macrogruppo, Comune e Anno, con Anno sull'anno corrente e riferito alla data della fattura. Il macrogruppo di una fattura è quello del finanziamento che la copre, non quello dell'intervento, che può essere vuoto o misto.

## GESTY-SIA-007 Il record nuovo eredita i filtri
Un intervento o un finanziamento nuovo nasce con il macrogruppo e il comune scelti nei filtri della barra; con i filtri vuoti restano i valori predefiniti.

### Scenario: nuovo intervento con i filtri impostati
- **Dato** il filtro Macrogruppo su Equipe e il filtro Comune su Desio
- **Quando** si inserisce un intervento nuovo
- **Allora** la scheda parte con macrogruppo Equipe e comune Desio
