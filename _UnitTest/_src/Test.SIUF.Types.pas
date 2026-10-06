unit Test.SIUF.Types;

// Test DUnitX per SIUF.CooperazioneApplicativa.Types.pas.
// Copre la conversione degli orari in minuti (HH:MM per la durata lezione,
// H.MM ore.minuti per presenza/assenza), il conteggio dei codici fiscali
// distinti, il canale di destinazione (Mantis #100) e il mapping enum
// errore->stringa. Nessun DB, nessuna rete.

interface

uses
  System.SysUtils,
  DUnitX.TestFramework,
  SIUF.CooperazioneApplicativa.Types;

type
  [TestFixture]
  TTestSiufPresenza = class
  private
    FPayload: TSiufPayload;
    function NuovaPresenza: TSiufPresenza;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure DurataLezione_OreEMinuti;
    [Test]
    procedure DurataLezione_OrarioNonValido_Zero;
    [Test]
    procedure DurataLezione_OraFinePrimaDiInizio_Negativa;
    [Test]
    procedure OrePresenza_FormatoOrePunto_Minuti;
    [Test]
    procedure OrePresenza_SoloOreIntere;
    [Test]
    procedure OrePresenza_Vuota_Zero;
    [Test]
    procedure OrePresenza_SpaziAttorno_Ignorati;
    [Test]
    procedure OreAssenza_VirgolaComeSeparatore;
    [Test]
    procedure OreAssenzaGiustificata_DefaultZero;
    // Mantis #186 - 2026-09-30: sul canale ordinamentale le giustificate sono
    // reali, nel formato ore.minuti ("0.15")
    [Test]
    procedure OreAssenzaGiustificata_QuartoDOra;
    [Test]
    procedure CalcolaNumeroStudenti_CfDistinti;
    [Test]
    procedure CalcolaNumeroStudenti_IgnoraCfVuoti;
  end;

  // Mantis #100 - 2026-09-11: canale formativo di destinazione
  [TestFixture]
  TTestSiufCanale = class
  public
    [Test]
    procedure Payload_CanalePredefinito_ExtraObbligo;
    [Test]
    procedure HaCampiEstesi_SoloOrdinamentale;
    [Test]
    procedure ToString_DueCanaliDistinti;
    [Test]
    procedure Tipologie_ValoriDelleSpecifiche;
  end;

  [TestFixture]
  TTestSiufErroreTipo = class
  public
    [Test]
    procedure ToString_Nessuno_Vuoto;
    [Test]
    procedure ToString_ValoreNoto;
    [Test]
    procedure ToString_ValoreFuoriElenco_Altro;
    [Test]
    procedure ToString_TuttiTranneNessuno_NonVuoti;
  end;

implementation

{ TTestSiufPresenza }

procedure TTestSiufPresenza.Setup;
begin
  FPayload := TSiufPayload.Create;
end;

procedure TTestSiufPresenza.TearDown;
begin
  FPayload.Free;
end;

function TTestSiufPresenza.NuovaPresenza: TSiufPresenza;
begin
  // Le presenze sono owned dal payload: niente free manuale nei test.
  Result := FPayload.AddPresenza;
end;

procedure TTestSiufPresenza.DurataLezione_OreEMinuti;
var
  P: TSiufPresenza;
begin
  P := NuovaPresenza;
  P.OraInizio := '09:30';
  P.OraFine := '11:00';
  Assert.AreEqual(90, P.DurataLezioneMinuti);
end;

procedure TTestSiufPresenza.DurataLezione_OrarioNonValido_Zero;
var
  P: TSiufPresenza;
begin
  P := NuovaPresenza;
  P.OraInizio := '';
  P.OraFine := '';
  // Nessun ':' => HHMMToMin restituisce 0 per entrambi.
  Assert.AreEqual(0, P.DurataLezioneMinuti);
end;

procedure TTestSiufPresenza.DurataLezione_OraFinePrimaDiInizio_Negativa;
var
  P: TSiufPresenza;
begin
  P := NuovaPresenza;
  P.OraInizio := '10:00';
  P.OraFine := '09:00';
  // Documenta che la durata NON viene clampata: sta al validator scartarla.
  Assert.AreEqual(-60, P.DurataLezioneMinuti);
end;

procedure TTestSiufPresenza.OrePresenza_FormatoOrePunto_Minuti;
var
  P: TSiufPresenza;
begin
  P := NuovaPresenza;
  P.OrePresenza := '2.30'; // 2 ore e 30 minuti = 150 (NON decimale)
  Assert.AreEqual(150, P.OrePresenzaMinuti);
end;

procedure TTestSiufPresenza.OrePresenza_SoloOreIntere;
var
  P: TSiufPresenza;
begin
  P := NuovaPresenza;
  P.OrePresenza := '3'; // senza separatore => ore intere
  Assert.AreEqual(180, P.OrePresenzaMinuti);
end;

procedure TTestSiufPresenza.OrePresenza_Vuota_Zero;
var
  P: TSiufPresenza;
begin
  P := NuovaPresenza;
  P.OrePresenza := '';
  Assert.AreEqual(0, P.OrePresenzaMinuti);
end;

procedure TTestSiufPresenza.OrePresenza_SpaziAttorno_Ignorati;
var
  P: TSiufPresenza;
begin
  P := NuovaPresenza;
  P.OrePresenza := ' 1.45 ';
  Assert.AreEqual(105, P.OrePresenzaMinuti);
end;

procedure TTestSiufPresenza.OreAssenza_VirgolaComeSeparatore;
var
  P: TSiufPresenza;
begin
  P := NuovaPresenza;
  P.OreAssenza := '1,30'; // la virgola viene normalizzata a punto => 90
  Assert.AreEqual(90, P.OreAssenzaMinuti);
end;

procedure TTestSiufPresenza.OreAssenzaGiustificata_DefaultZero;
var
  P: TSiufPresenza;
begin
  P := NuovaPresenza;
  // Il costruttore forza '0' da specifica SIUF.
  Assert.AreEqual('0', P.OreAssenzaGiustificata);
  Assert.AreEqual(0, P.OreAssenzaGiustificataMinuti);
end;

procedure TTestSiufPresenza.OreAssenzaGiustificata_QuartoDOra;
var
  P: TSiufPresenza;
begin
  P := NuovaPresenza;
  P.OreAssenzaGiustificata := '0.15';
  Assert.AreEqual(15, P.OreAssenzaGiustificataMinuti);
end;

procedure TTestSiufPresenza.CalcolaNumeroStudenti_CfDistinti;
begin
  NuovaPresenza.CodiceFiscale := 'RSSMRA80A01H501U';
  NuovaPresenza.CodiceFiscale := 'RSSMRA80A01H501U'; // duplicato
  NuovaPresenza.CodiceFiscale := 'VRDGPP90B02F205X';
  Assert.AreEqual(2, FPayload.CalcolaNumeroStudenti);
  Assert.AreEqual(2, FPayload.NumeroStudenti);
end;

procedure TTestSiufPresenza.CalcolaNumeroStudenti_IgnoraCfVuoti;
begin
  NuovaPresenza.CodiceFiscale := 'RSSMRA80A01H501U';
  NuovaPresenza.CodiceFiscale := '   '; // solo spazi: ignorato dopo Trim
  NuovaPresenza.CodiceFiscale := '';
  Assert.AreEqual(1, FPayload.CalcolaNumeroStudenti);
end;

{ TTestSiufCanale }

procedure TTestSiufCanale.Payload_CanalePredefinito_ExtraObbligo;
var
  Payload: TSiufPayload;
begin
  // Il canale storico: chi costruisce il payload lo cambia se serve
  Payload := TSiufPayload.Create;
  try
    Assert.IsTrue(Payload.Canale = scExtraObbligo);
  finally
    Payload.Free;
  end;
end;

procedure TTestSiufCanale.HaCampiEstesi_SoloOrdinamentale;
begin
  // sede e i tre campi di chiusura esistono solo nel tracciato IeFP
  Assert.IsTrue(scOrdinamentale.HaCampiEstesi);
  Assert.IsFalse(scExtraObbligo.HaCampiEstesi);
end;

procedure TTestSiufCanale.ToString_DueCanaliDistinti;
begin
  Assert.AreEqual('Extra Obbligo', scExtraObbligo.ToString);
  Assert.AreNotEqual(scExtraObbligo.ToString, scOrdinamentale.ToString);
end;

procedure TTestSiufCanale.Tipologie_ValoriDelleSpecifiche;
begin
  // Paragrafo 1.5 delle specifiche EOB: sono questi i numeri che SIUF confronta
  Assert.AreEqual(1, TIPOLOGIA_SIUF_AULA);
  Assert.AreEqual(2, TIPOLOGIA_SIUF_STAGE);
  Assert.AreEqual(3, TIPOLOGIA_SIUF_ESERCITAZIONE);
  Assert.AreEqual(4, TIPOLOGIA_SIUF_FAD);
  Assert.AreEqual(0, TIPOLOGIA_SIUF_NON_MAPPATA);
end;

{ TTestSiufErroreTipo }

procedure TTestSiufErroreTipo.ToString_Nessuno_Vuoto;
begin
  Assert.AreEqual('', setNessuno.ToString);
end;

procedure TTestSiufErroreTipo.ToString_ValoreNoto;
begin
  Assert.AreEqual('User Non Esiste', setUserNonEsiste.ToString);
  Assert.AreEqual('Minuti Non Corrispondenti', setMinutiNonCorrispondenti.ToString);
end;

procedure TTestSiufErroreTipo.ToString_ValoreFuoriElenco_Altro;
begin
  // I valori non mappati esplicitamente cadono nel ramo else => 'Altro'.
  Assert.AreEqual('Altro', setAltro.ToString);
end;

procedure TTestSiufErroreTipo.ToString_TuttiTranneNessuno_NonVuoti;
var
  Tipo: TSiufErroreTipo;
begin
  // Un valore aggiunto all'enum senza la sua voce nel case finisce in 'Altro',
  // che e' leggibile; vuoto resta riservato a "nessun errore"
  for Tipo := Succ(Low(TSiufErroreTipo)) to High(TSiufErroreTipo) do
    Assert.IsTrue(Tipo.ToString <> '', 'Tipo ord ' + Ord(Tipo).ToString);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestSiufPresenza);
  TDUnitX.RegisterTestFixture(TTestSiufCanale);
  TDUnitX.RegisterTestFixture(TTestSiufErroreTipo);

end.
