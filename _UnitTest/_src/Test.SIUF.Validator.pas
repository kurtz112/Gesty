unit Test.SIUF.Validator;

// Test DUnitX per SIUF.CooperazioneApplicativa.Validator.pas.
// TSiufValidator.Valida applica i controlli client-side prima dell'invio SIUF:
// campi header obbligatori, intervallo date (max 3 giorni), identificazione
// studente, forma del codice fiscale (Mantis #189), tipologia ammessa dal
// canale (Mantis #93, #100), ore di assenza giustificata, campi del tracciato
// ordinamentale (Mantis #100), data lezione nell'intervallo, coerenza minuti
// presenza/assenza vs durata. Logica pura: nessun DB, UI o rete.
//
// Gli assert verificano il CAMPO della violazione (stabile) e non il testo del
// messaggio (contiene accenti e potrebbe cambiare): niente rischi di encoding.

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  DUnitX.TestFramework,
  SIUF.CooperazioneApplicativa.Types,
  SIUF.CooperazioneApplicativa.Validator;

type
  [TestFixture]
  TTestSiufValidator = class
  private
    FPayload: TSiufPayload;
    // Costruisce un payload header+riga completamente valido (Extra Obbligo).
    procedure CostruisciValido;
    // Come CostruisciValido, sul canale ordinamentale (sede valorizzata).
    procedure CostruisciValidoOrdinamentale;
    function AggiungiRigaValida: TSiufPresenza;
    function Viola(const ACampo: string): Boolean;
    function ContaViolazioni: Integer; overload;
    function ContaViolazioni(const ACampo: string): Integer; overload;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure PayloadValido_NessunaViolazione;
    [Test]
    procedure PayloadValidoOrdinamentale_NessunaViolazione;
    [Test]
    procedure CfUtenteMancante_Viola;
    [Test]
    procedure IdSezioneNonValido_Viola;
    [Test]
    procedure DateHeaderMalformate_Viola;
    [Test]
    procedure DataFinePrimaDiInizio_Viola;
    [Test]
    procedure IntervalloOltreTreGiorni_Viola;
    [Test]
    procedure IntervalloTreGiorniEsatti_Ok;
    [Test]
    procedure ListaStudentiVuota_Viola;
    [Test]
    procedure StudenteNonIdentificabile_Viola;
    [Test]
    procedure StudenteConCognomeNome_Ok;
    [Test]
    procedure AssenzaGiustificataNonZero_Viola;
    [Test]
    procedure DataLezioneFuoriIntervallo_Viola;
    [Test]
    procedure DataLezioneFormatoErrato_Viola;
    [Test]
    procedure DataLezioneAltroSeparatore_Ok;
    [Test]
    procedure OraFineNonSuccessiva_Viola;
    [Test]
    procedure MinutiNonCoerenti_Viola;
    [Test]
    procedure MinutiConGiustificate_Coerenti;
    [Test]
    procedure RaccoglieTutteLeViolazioni;

    // --- Mantis #93 - 2026-09-08: tipologia ammessa dall'Extra Obbligo ---
    [Test]
    procedure TipologiaNonMappata_Viola;
    [Test]
    [TestCase('Aula', '1')]
    [TestCase('Stage', '2')]
    [TestCase('Esercitazione', '3')]
    [TestCase('FAD', '4')]
    procedure TipologiaExtraObbligoAmmessa_Ok(ATipologia: Integer);
    [Test]
    procedure TipologiaExtraObbligoFuoriElenco_Viola;

    // --- Mantis #100 - 2026-09-11: canale ordinamentale ---
    [Test]
    procedure Ordinamentale_TipologiaNonMappata_Viola;
    [Test]
    procedure Ordinamentale_TipologiaOltreQuattro_Ok;
    [Test]
    procedure Ordinamentale_SedeObbligatoria;
    [Test]
    procedure Ordinamentale_MotivoChiusuraNonPrevisto_Viola;
    [Test]
    procedure Ordinamentale_MotivoChiusuraSenzaDate_Viola;
    [Test]
    procedure Ordinamentale_ChiusuraCompleta_Ok;
    [Test]
    procedure ExtraObbligo_CampiChiusuraIgnorati;
    // Mantis #186 - 2026-09-30: ITS e IFTS inviano le giustificate reali
    // come gli altri corsi ordinamentali
    [Test]
    procedure Ordinamentale_AssenzaGiustificataReale_Ok;

    // --- Mantis #189 - 2026-09-28: forma del codice fiscale ---
    [Test]
    [TestCase('DataDiNascita', '12/05/2008')]
    [TestCase('TroppoCorto', 'RSSMRA80A01H50')]
    [TestCase('UndiciConLettere', 'RSSMRA80A01')]
    [TestCase('ConTrattino', 'RSSMRA80-01H501U')]
    procedure CodiceFiscaleMalformato_Viola(const ACodice: string);
    [Test]
    [TestCase('Ordinario', 'VRDGPP90B02F205X')]
    [TestCase('Minuscolo', 'vrdgpp90b02f205x')]
    [TestCase('Omocodico', 'VRDGPP90B02F2R5X')]
    [TestCase('Numerico', '01234567890')]
    procedure CodiceFiscaleFormaAmmessa_Ok(const ACodice: string);
    [Test]
    procedure CodiceFiscaleMalformato_SegnalatoUnaVoltaSola;

    // --- Mantis #152 - 2026-09-21: messaggio dell'eccezione ---
    [Test]
    procedure EValido_ListaEdEsito;
    [Test]
    procedure ValidaOErrore_PayloadValido_NonSolleva;
    [Test]
    procedure ValidaOErrore_Solleva_ConTutteLeViolazioni;
  end;

implementation

{ TTestSiufValidator }

procedure TTestSiufValidator.Setup;
begin
  FPayload := TSiufPayload.Create;
end;

procedure TTestSiufValidator.TearDown;
begin
  FPayload.Free;
end;

function TTestSiufValidator.AggiungiRigaValida: TSiufPresenza;
begin
  Result := FPayload.AddPresenza;
  Result.CodiceFiscale := 'VRDGPP90B02F205X';
  Result.Cognome := 'Verdi';
  Result.Nome := 'Giuseppe';
  Result.Data := '03/03/2026'; // dentro l'intervallo
  Result.OraInizio := '09:00';
  Result.OraFine := '10:00'; // durata 60 min
  Result.OrePresenza := '1'; // 60 min, intero come lo vuole SIUF (Mantis #186)
  Result.OreAssenza := '0'; // 0 min
  // Mantis #93 - 2026-09-08: senza tipologia (0 = non mappata) l'invio si
  // ferma; la riga valida e' una lezione d'aula
  Result.Tipologia := TIPOLOGIA_SIUF_AULA;
  // OreAssenzaGiustificata resta '0' (default). 60 + 0 + 0 = 60 = durata.
end;

procedure TTestSiufValidator.CostruisciValido;
begin
  FPayload.CodiceFiscaleUser := 'RSSMRA80A01H501U';
  FPayload.IdSezione := 100;
  FPayload.DataInizio := '2026-03-02';
  FPayload.DataFine := '2026-03-04'; // 3 giorni distinti (diff = 2)
  AggiungiRigaValida;
end;

procedure TTestSiufValidator.CostruisciValidoOrdinamentale;
begin
  CostruisciValido;
  FPayload.Canale := scOrdinamentale;
  FPayload.ListaStudenti[0].Sede := 'Sede di Pordenone';
end;

function TTestSiufValidator.Viola(const ACampo: string): Boolean;
begin
  Result := ContaViolazioni(ACampo) > 0;
end;

function TTestSiufValidator.ContaViolazioni: Integer;
var
  V: TList<TSiufViolazione>;
begin
  V := TSiufValidator.Valida(FPayload);
  try
    Result := V.Count;
  finally
    V.Free;
  end;
end;

function TTestSiufValidator.ContaViolazioni(const ACampo: string): Integer;
var
  V: TList<TSiufViolazione>;
  x: TSiufViolazione;
begin
  Result := 0;
  V := TSiufValidator.Valida(FPayload);
  try
    for x in V do
      if x.Campo = ACampo then
        Inc(Result);
  finally
    V.Free;
  end;
end;

procedure TTestSiufValidator.PayloadValido_NessunaViolazione;
begin
  CostruisciValido;
  Assert.AreEqual(0, ContaViolazioni);
end;

procedure TTestSiufValidator.PayloadValidoOrdinamentale_NessunaViolazione;
begin
  CostruisciValidoOrdinamentale;
  Assert.AreEqual(0, ContaViolazioni);
end;

procedure TTestSiufValidator.CfUtenteMancante_Viola;
begin
  CostruisciValido;
  FPayload.CodiceFiscaleUser := '   ';
  Assert.IsTrue(Viola('codiceFiscaleUser'));
end;

procedure TTestSiufValidator.IdSezioneNonValido_Viola;
begin
  CostruisciValido;
  FPayload.IdSezione := 0;
  Assert.IsTrue(Viola('idSezione'));
end;

procedure TTestSiufValidator.DateHeaderMalformate_Viola;
begin
  CostruisciValido;
  FPayload.DataInizio := '02-03-2026'; // formato errato (atteso YYYY-MM-DD)
  Assert.IsTrue(Viola('dataInizio/dataFine'));
end;

procedure TTestSiufValidator.DataFinePrimaDiInizio_Viola;
begin
  CostruisciValido;
  FPayload.DataInizio := '2026-03-04';
  FPayload.DataFine := '2026-03-02';
  Assert.IsTrue(Viola('dataInizio/dataFine'));
end;

procedure TTestSiufValidator.IntervalloOltreTreGiorni_Viola;
begin
  CostruisciValido;
  FPayload.DataInizio := '2026-03-01';
  FPayload.DataFine := '2026-03-05'; // 5 giorni: oltre il limite
  Assert.IsTrue(Viola('dataInizio/dataFine'));
end;

procedure TTestSiufValidator.IntervalloTreGiorniEsatti_Ok;
begin
  CostruisciValido;
  // 02..04 marzo = 3 giorni distinti: al limite, ammesso.
  Assert.IsFalse(Viola('dataInizio/dataFine'));
end;

procedure TTestSiufValidator.ListaStudentiVuota_Viola;
begin
  // Header valido ma nessuna riga.
  FPayload.CodiceFiscaleUser := 'RSSMRA80A01H501U';
  FPayload.IdSezione := 100;
  FPayload.DataInizio := '2026-03-02';
  FPayload.DataFine := '2026-03-04';
  Assert.IsTrue(Viola('listaStudenti'));
end;

procedure TTestSiufValidator.StudenteNonIdentificabile_Viola;
var
  P: TSiufPresenza;
begin
  CostruisciValido;
  P := FPayload.ListaStudenti[0];
  P.CodiceFiscale := '';
  P.Cognome := '';
  P.Nome := '';
  Assert.IsTrue(Viola('codiceFiscale'));
end;

procedure TTestSiufValidator.StudenteConCognomeNome_Ok;
var
  P: TSiufPresenza;
begin
  CostruisciValido;
  P := FPayload.ListaStudenti[0];
  P.CodiceFiscale := ''; // manca il CF ma cognome+nome bastano
  Assert.IsFalse(Viola('codiceFiscale'));
end;

procedure TTestSiufValidator.AssenzaGiustificataNonZero_Viola;
var
  P: TSiufPresenza;
begin
  CostruisciValido;
  P := FPayload.ListaStudenti[0];
  P.OreAssenzaGiustificata := '1';
  Assert.IsTrue(Viola('oreAssenzaGiustificata'));
end;

procedure TTestSiufValidator.DataLezioneFuoriIntervallo_Viola;
var
  P: TSiufPresenza;
begin
  CostruisciValido;
  P := FPayload.ListaStudenti[0];
  P.Data := '10/03/2026'; // oltre dataFine
  Assert.IsTrue(Viola('data'));
end;

procedure TTestSiufValidator.DataLezioneFormatoErrato_Viola;
var
  P: TSiufPresenza;
begin
  CostruisciValido;
  P := FPayload.ListaStudenti[0];
  P.Data := 'non-una-data';
  Assert.IsTrue(Viola('data'));
end;

procedure TTestSiufValidator.DataLezioneAltroSeparatore_Ok;
var
  P: TSiufPresenza;
begin
  CostruisciValido;
  P := FPayload.ListaStudenti[0];
  // La data di riga si legge qualunque sia il separatore
  P.Data := '03-03-2026';
  Assert.IsFalse(Viola('data'));
end;

procedure TTestSiufValidator.OraFineNonSuccessiva_Viola;
var
  P: TSiufPresenza;
begin
  CostruisciValido;
  P := FPayload.ListaStudenti[0];
  P.OraInizio := '10:00';
  P.OraFine := '09:00'; // durata <= 0
  Assert.IsTrue(Viola('oraInizio/oraFine'));
end;

procedure TTestSiufValidator.MinutiNonCoerenti_Viola;
var
  P: TSiufPresenza;
begin
  CostruisciValido;
  P := FPayload.ListaStudenti[0];
  // durata 60 min ma presenza dichiarata 30 min: 30 <> 60.
  P.OrePresenza := '0.30';
  Assert.IsTrue(Viola('orePresenza/oreAssenza'));
end;

procedure TTestSiufValidator.MinutiConGiustificate_Coerenti;
var
  P: TSiufPresenza;
begin
  CostruisciValidoOrdinamentale;
  P := FPayload.ListaStudenti[0];
  // 30 + 15 + 15 = 60: le giustificate entrano nella somma
  P.OrePresenza := '0.30';
  P.OreAssenza := '0.15';
  P.OreAssenzaGiustificata := '0.15';
  Assert.IsFalse(Viola('orePresenza/oreAssenza'));
end;

procedure TTestSiufValidator.RaccoglieTutteLeViolazioni;
begin
  CostruisciValido;
  FPayload.CodiceFiscaleUser := '';
  FPayload.IdSezione := -1;
  FPayload.ListaStudenti[0].Data := 'x';
  // L'invio e' bloccante: si vedono tutte, non solo la prima
  Assert.AreEqual(3, ContaViolazioni);
end;

procedure TTestSiufValidator.TipologiaNonMappata_Viola;
begin
  CostruisciValido;
  FPayload.ListaStudenti[0].Tipologia := TIPOLOGIA_SIUF_NON_MAPPATA;
  FPayload.ListaStudenti[0].TipologiaGesty := '5';
  Assert.IsTrue(Viola('tipologia'));
end;

procedure TTestSiufValidator.TipologiaExtraObbligoAmmessa_Ok(ATipologia: Integer);
begin
  CostruisciValido;
  FPayload.ListaStudenti[0].Tipologia := ATipologia;
  Assert.IsFalse(Viola('tipologia'));
end;

procedure TTestSiufValidator.TipologiaExtraObbligoFuoriElenco_Viola;
begin
  CostruisciValido;
  FPayload.ListaStudenti[0].Tipologia := 29;
  Assert.IsTrue(Viola('tipologia'));
end;

procedure TTestSiufValidator.Ordinamentale_TipologiaNonMappata_Viola;
begin
  CostruisciValidoOrdinamentale;
  FPayload.ListaStudenti[0].Tipologia := TIPOLOGIA_SIUF_NON_MAPPATA;
  Assert.IsTrue(Viola('tipologia'));
end;

procedure TTestSiufValidator.Ordinamentale_TipologiaOltreQuattro_Ok;
begin
  // Sull'ordinamentale il codice Gesty si trasmette com'e' (1..34)
  CostruisciValidoOrdinamentale;
  FPayload.ListaStudenti[0].Tipologia := 20;
  Assert.IsFalse(Viola('tipologia'));
end;

procedure TTestSiufValidator.Ordinamentale_SedeObbligatoria;
begin
  CostruisciValidoOrdinamentale;
  FPayload.ListaStudenti[0].Sede := '  ';
  Assert.IsTrue(Viola('sede'));

  // Sull'Extra Obbligo la sede non esiste nel tracciato
  FPayload.Canale := scExtraObbligo;
  Assert.IsFalse(Viola('sede'));
end;

procedure TTestSiufValidator.Ordinamentale_MotivoChiusuraNonPrevisto_Viola;
var
  P: TSiufPresenza;
begin
  CostruisciValidoOrdinamentale;
  P := FPayload.ListaStudenti[0];
  P.MotivoChiusura := '4';
  P.DataInizioChiusura := '2026-03-03';
  P.DataFineChiusura := '2026-03-03';
  Assert.IsTrue(Viola('motivoChiusura'));
end;

procedure TTestSiufValidator.Ordinamentale_MotivoChiusuraSenzaDate_Viola;
var
  P: TSiufPresenza;
begin
  CostruisciValidoOrdinamentale;
  P := FPayload.ListaStudenti[0];
  P.MotivoChiusura := MOTIVO_CHIUSURA_PONTE;
  P.DataInizioChiusura := '2026-03-03';
  // manca la data di fine: vanno compilate entrambe anche per un giorno solo
  Assert.IsTrue(Viola('dataInizioChiusura/dataFineChiusura'));
end;

procedure TTestSiufValidator.Ordinamentale_ChiusuraCompleta_Ok;
var
  P: TSiufPresenza;
begin
  CostruisciValidoOrdinamentale;
  P := FPayload.ListaStudenti[0];
  P.MotivoChiusura := MOTIVO_CHIUSURA_FESTA_PATRONALE;
  P.DataInizioChiusura := '2026-03-03';
  P.DataFineChiusura := '2026-03-03';
  Assert.AreEqual(0, ContaViolazioni);
end;

procedure TTestSiufValidator.ExtraObbligo_CampiChiusuraIgnorati;
var
  P: TSiufPresenza;
begin
  CostruisciValido;
  P := FPayload.ListaStudenti[0];
  P.MotivoChiusura := '9';
  // Sull'Extra Obbligo i campi di chiusura non si serializzano: niente controlli
  Assert.AreEqual(0, ContaViolazioni);
end;

procedure TTestSiufValidator.Ordinamentale_AssenzaGiustificataReale_Ok;
var
  P: TSiufPresenza;
begin
  CostruisciValidoOrdinamentale;
  P := FPayload.ListaStudenti[0];
  P.OrePresenza := '0.45';
  P.OreAssenzaGiustificata := '0.15';
  Assert.IsFalse(Viola('oreAssenzaGiustificata'));
  Assert.AreEqual(0, ContaViolazioni);
end;

procedure TTestSiufValidator.CodiceFiscaleMalformato_Viola(const ACodice: string);
begin
  CostruisciValido;
  FPayload.ListaStudenti[0].CodiceFiscale := ACodice;
  Assert.IsTrue(Viola('codiceFiscale'), ACodice);
end;

procedure TTestSiufValidator.CodiceFiscaleFormaAmmessa_Ok(const ACodice: string);
begin
  CostruisciValido;
  FPayload.ListaStudenti[0].CodiceFiscale := ACodice;
  Assert.IsFalse(Viola('codiceFiscale'), ACodice);
end;

procedure TTestSiufValidator.CodiceFiscaleMalformato_SegnalatoUnaVoltaSola;
var
  Riga: Integer;
  P: TSiufPresenza;
begin
  // Il caso reale del ticket: una scheda doppia con la data di nascita nel
  // codice fiscale, una riga per ogni ora di lezione. La segnalazione e' una,
  // altrimenti nasconde le altre violazioni
  CostruisciValido;
  FPayload.ListaStudenti[0].CodiceFiscale := '12/05/2008';

  for Riga := 1 to 3 do
  begin
    P := AggiungiRigaValida;
    P.CodiceFiscale := '12/05/2008';
    P.OraInizio := Format('%.2d:00', [9 + Riga]);
    P.OraFine := Format('%.2d:00', [10 + Riga]);
  end;

  // Un secondo studente sbagliato ha la sua segnalazione
  AggiungiRigaValida.CodiceFiscale := 'ROSSI MARIO';

  Assert.AreEqual(2, ContaViolazioni('codiceFiscale'));
end;

procedure TTestSiufValidator.EValido_ListaEdEsito;
var
  Violazioni: TList<TSiufViolazione>;
begin
  CostruisciValido;
  Assert.IsTrue(TSiufValidator.EValido(FPayload, Violazioni));
  try
    Assert.AreEqual(0, Violazioni.Count);
  finally
    Violazioni.Free;
  end;

  FPayload.IdSezione := 0;
  Assert.IsFalse(TSiufValidator.EValido(FPayload, Violazioni));
  try
    Assert.AreEqual(1, Violazioni.Count);
    // -1 = livello header
    Assert.AreEqual(-1, Violazioni[0].Indice);
  finally
    Violazioni.Free;
  end;
end;

procedure TTestSiufValidator.ValidaOErrore_PayloadValido_NonSolleva;
begin
  CostruisciValido;
  Assert.WillNotRaise(
    procedure
    begin
      TSiufValidator.ValidaOErrore(FPayload);
    end);
end;

procedure TTestSiufValidator.ValidaOErrore_Solleva_ConTutteLeViolazioni;
var
  Sollevata: Boolean;
begin
  CostruisciValido;
  FPayload.IdSezione := 0;
  FPayload.ListaStudenti[0].Data := 'x';

  Sollevata := False;
  try
    TSiufValidator.ValidaOErrore(FPayload);
  except
    on E: ESiufValidazione do
    begin
      Sollevata := True;
      Assert.AreEqual(2, Length(E.Violazioni));
      // Mantis #152 - 2026-09-21: intestazione della violazione su una riga
      // sua, il messaggio rientrato sotto
      Assert.Contains(E.Message, '- Header, campo idSezione');
      Assert.Contains(E.Message, '- Riga 0, campo data');
    end;
  end;

  Assert.IsTrue(Sollevata, 'ESiufValidazione attesa');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestSiufValidator);

end.
