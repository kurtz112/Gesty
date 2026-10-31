-- Fotografia (golden master) di TIME_REPORT, area Timesheet, specifica GESTY-TIM-001..003.
-- Una sola SELECT: la prima colonna e il nome del caso, ogni riga del risultato e un caso.
-- Per ogni caso: righe, ore, righe senza incarico e una impronta delle righe restituite dalla
-- procedura. L impronta e la somma delle HASH di ogni riga; ogni riga comincia con il suo numero
-- di uscita (ROW_NUMBER), quindi cambia se cambia una colonna o l ordine delle righe, ma non
-- dipende dall ordine con cui Firebird raggruppa. I due logo (BLOB) restano fuori.
-- Il riferimento e time-report.riferimento.txt, scritto da zCollaudo con --aggiorna-riferimenti.
-- Dati: i periodi sono passati e le risorse fisse, nessuna data corrente e nessun progressivo
-- nell output. Il riferimento vale per la copia del database madre su cui e stato scritto:
-- se la madre viene riallineata dal master va rifatto.
-- Firebird 5 non ha VALUES come tabella: i casi sono un UNION ALL.
SELECT
    CASI.CASO,
    COUNT(RIGHE.TESTO) RIGHE,
    COALESCE(SUM(RIGHE.ORE), 0) ORE,
    COALESCE(SUM(IIF(RIGHE.SENZA_INCARICO, 1, 0)), 0) SENZA_INCARICO,
    CAST(COALESCE(SUM(CAST(HASH(RIGHE.TESTO) AS INT128)), 0) AS VARCHAR(40)) IMPRONTA
FROM
    (SELECT '01 nessun filtro' CASO, 441081 ID_RISORSA, DATE '2026-08-01' DAL, DATE '2026-08-31' AL, CAST(NULL AS INTEGER) ID_PROGETTO, CAST(NULL AS VARCHAR(50)) TIPO_INCARICO, CAST(NULL AS INTEGER) ID_INCARICO, FALSE PER_MESE FROM RDB$DATABASE
     UNION ALL SELECT '02 filtro progetto', 441081, DATE '2026-08-01', DATE '2026-08-31', 469465, NULL, NULL, FALSE FROM RDB$DATABASE
     UNION ALL SELECT '03 progetto con ora senza incarico', 441081, DATE '2026-08-01', DATE '2026-08-31', 491288, NULL, NULL, FALSE FROM RDB$DATABASE
     UNION ALL SELECT '04 filtro tipo incarico', 441081, DATE '2026-08-01', DATE '2026-08-31', NULL, 'Docenza', NULL, FALSE FROM RDB$DATABASE
     UNION ALL SELECT '05 filtro incarico (esclude le ore senza)', 441081, DATE '2026-08-01', DATE '2026-08-31', NULL, NULL, 499730, FALSE FROM RDB$DATABASE
     UNION ALL SELECT '06 stampa per mese su tre mesi', 441081, DATE '2026-06-01', DATE '2026-08-31', NULL, NULL, NULL, TRUE FROM RDB$DATABASE
     UNION ALL SELECT '07 altra risorsa, cinque progetti', 11171, DATE '2025-09-01', DATE '2025-09-30', NULL, NULL, NULL, FALSE FROM RDB$DATABASE
     UNION ALL SELECT '08 giorno finale mancante', 441081, DATE '2026-08-01', NULL, NULL, NULL, NULL, FALSE FROM RDB$DATABASE
     UNION ALL SELECT '09 risorsa -1', -1, DATE '2026-08-01', DATE '2026-08-31', NULL, NULL, NULL, FALSE FROM RDB$DATABASE
     UNION ALL SELECT '10 primi due giorni dell''anno', 441081, DATE '2026-01-01', DATE '2026-01-02', NULL, NULL, NULL, FALSE FROM RDB$DATABASE) CASI
    LEFT JOIN LATERAL (
        SELECT
            R.ORE,
            R.SENZA_INCARICO,
            ROW_NUMBER() OVER () || '#' || R.ID_RISORSA || '#' || R.NOMINATIVO_O_RAGIONE_SOCIALE || '#' || R.ID_PROGETTO || '#' || R.DESC_COMPLETA_PROGETTO || '#' ||
            R.TIPO_INCARICO || '#' || R.DATA || '#' || R.ORA_INIZIO || '#' || R.ORA_FINE || '#' || R.ORE || '#' ||
            COALESCE(CAST(R.SUPPLENZA AS VARCHAR(5)), '~') || '#' || CAST(R.SENZA_INCARICO AS VARCHAR(5)) || '#' ||
            COALESCE(R.ID_PIANO_PERSONALIZZATO, '~') || '#' || COALESCE(R.ID_STUDENTE, '~') || '#' ||
            COALESCE(R.NOMINATIVO_STUDENTE, '~') || '#' || COALESCE(R.SERVIZIO_EROGATO, '~') || '#' || COALESCE(R.MATERIA, '~') || '#' ||
            COALESCE(SUBSTRING(R.DESCRIZIONE_ATTIVITA FROM 1 FOR 500), '~') || '#' ||
            COALESCE(R.TOTALE_ORE_ATTRIBUITE, '~') || '#' || COALESCE(R.TOTALE_ORE_RILEVATE, '~') || '#' ||
            COALESCE(R.DENOMINAZIONE_ENTE, '~') || '#' || COALESCE(R.CITTA, '~') || '#' || COALESCE(R.DIRETTORE, '~') || '#' ||
            R.RAGGRUPPAMENTO || '#' || R.FIRMA_COME TESTO
        FROM
            TIME_REPORT(CASI.ID_RISORSA, CASI.DAL, CASI.AL, CASI.ID_PROGETTO, CASI.TIPO_INCARICO, NULL, NULL, NULL, CASI.PER_MESE, CASI.ID_INCARICO) R
    ) RIGHE ON TRUE
GROUP BY
    CASI.CASO
ORDER BY
    CASI.CASO
