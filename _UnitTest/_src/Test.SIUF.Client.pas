// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-03
// ---------------------------------------------------------------------------

unit Test.SIUF.Client;

// Test di API\CooperazioneApplicativa\SIUF.CooperazioneApplicativa.Client
// limitati alla parte che non apre connessioni: il JSON interno (che finisce
// anche nel file di appoggio su disco) e il corpo con il payload in Base64.
// Mantis #100 - 2026-09-11: i campi di sede e chiusura esistono solo nel
// tracciato del canale ordinamentale e non vanno mai sull'Extra Obbligo.

interface

uses
  System.SysUtils,
  System.JSON,
  System.NetEncoding,
  DUnitX.TestFramework,
  SIUF.CooperazioneApplicativa.Types,
  SIUF.CooperazioneApplicativa.Client;

type
  [TestFixture]
  TTestSiufClient = class
  private
    FClient: TSiufCoopClient;
    FPayload: TSiufPayload;
    function JsonInterno: TJSONObject;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure Header_CampiETipi;
    [Test]
    procedure Riga_CampiComuni;
    [Test]
    procedure ExtraObbligo_SenzaSedeEChiusura;
    [Test]
    procedure Ordinamentale_ConSedeEChiusura;
    [Test]
    procedure Ordinamentale_ChiusuraVuota_StringheVuote;
    [Test]
    procedure Body_PayloadBase64DelJsonInterno;
    [Test]
    procedure Body_CaratteriAccentati_InUtf8;
  end;

implementation

{ TTestSiufClient }

procedure TTestSiufClient.Setup;
var
  Configurazione: TSiufCoopConfig;
  Presenza: TSiufPresenza;
begin
  Configurazione := Default(TSiufCoopConfig);
  FClient := TSiufCoopClient.Create(Configurazione);

  FPayload := TSiufPayload.Create;
  FPayload.CodiceFiscaleUser := 'RSSMRA80A01H501U';
  FPayload.IdSezione := 170146;
  FPayload.DataInizio := '2026-03-02';
  FPayload.DataFine := '2026-03-04';

  Presenza := FPayload.AddPresenza;
  Presenza.CodiceFiscale := 'VRDGPP90B02F205X';
  Presenza.CodiceFiscaleDocente := 'BNCLRA75C41G888K';
  Presenza.Cognome := 'Verdi';
  Presenza.Nome := 'Giuseppe';
  Presenza.Materia := 'Gestione aziendale';
  Presenza.ContenutiMateria := 'Bilancio';
  Presenza.Data := '03/03/2026';
  Presenza.OraInizio := '09:00';
  Presenza.OraFine := '11:00';
  Presenza.OrePresenza := '1.45';
  Presenza.OreAssenza := '0.15';
  Presenza.Tipologia := TIPOLOGIA_SIUF_AULA;
  Presenza.Sede := 'Sede di Pordenone';
  Presenza.MotivoChiusura := MOTIVO_CHIUSURA_PONTE;
  Presenza.DataInizioChiusura := '2026-03-02';
  Presenza.DataFineChiusura := '2026-03-02';
end;

procedure TTestSiufClient.TearDown;
begin
  FPayload.Free;
  FClient.Free;
end;

function TTestSiufClient.JsonInterno: TJSONObject;
begin
  Result := TJSONObject.ParseJSONValue(FClient.BuildReadableJson(FPayload)) as TJSONObject;
end;

procedure TTestSiufClient.Header_CampiETipi;
var
  Json: TJSONObject;
begin
  Json := JsonInterno;
  try
    Assert.AreEqual('RSSMRA80A01H501U', Json.GetValue<string>('codiceFiscaleUser'));
    Assert.AreEqual('2026-03-02', Json.GetValue<string>('dataInizio'));
    Assert.AreEqual('2026-03-04', Json.GetValue<string>('dataFine'));
    // idSezione e tipologia sono numeri, non testo
    Assert.IsTrue(Json.GetValue('idSezione') is TJSONNumber);
    Assert.AreEqual(170146, Json.GetValue<Integer>('idSezione'));
    Assert.AreEqual(1, (Json.GetValue('listaStudenti') as TJSONArray).Count);
  finally
    Json.Free;
  end;
end;

procedure TTestSiufClient.Riga_CampiComuni;
var
  Json: TJSONObject;
begin
  Json := JsonInterno;
  try
    Assert.AreEqual('VRDGPP90B02F205X', Json.GetValue<string>('listaStudenti[0].codiceFiscale'));
    Assert.AreEqual('BNCLRA75C41G888K', Json.GetValue<string>('listaStudenti[0].codiceFiscaleDocente'));
    Assert.AreEqual('03/03/2026', Json.GetValue<string>('listaStudenti[0].data'));
    Assert.AreEqual('09:00', Json.GetValue<string>('listaStudenti[0].oraInizio'));
    Assert.AreEqual('11:00', Json.GetValue<string>('listaStudenti[0].oraFine'));
    Assert.AreEqual('1.45', Json.GetValue<string>('listaStudenti[0].orePresenza'));
    Assert.AreEqual('0.15', Json.GetValue<string>('listaStudenti[0].oreAssenza'));
    Assert.AreEqual('0', Json.GetValue<string>('listaStudenti[0].oreAssenzaGiustificata'));
    Assert.IsTrue(Json.FindValue('listaStudenti[0].tipologia') is TJSONNumber);
    Assert.AreEqual(1, Json.GetValue<Integer>('listaStudenti[0].tipologia'));
    // Il codocente c'e' su entrambi i canali, anche vuoto
    Assert.IsNotNull(Json.FindValue('listaStudenti[0].codiceFiscaleCoDocente'));
  finally
    Json.Free;
  end;
end;

procedure TTestSiufClient.ExtraObbligo_SenzaSedeEChiusura;
var
  Json: TJSONObject;
begin
  // Valorizzati sulla presenza ma il tracciato EOB non li prevede
  FPayload.Canale := scExtraObbligo;
  Json := JsonInterno;
  try
    Assert.IsNull(Json.FindValue('listaStudenti[0].sede'));
    Assert.IsNull(Json.FindValue('listaStudenti[0].motivoChiusura'));
    Assert.IsNull(Json.FindValue('listaStudenti[0].dataInizioChiusura'));
    Assert.IsNull(Json.FindValue('listaStudenti[0].dataFineChiusura'));
  finally
    Json.Free;
  end;
end;

procedure TTestSiufClient.Ordinamentale_ConSedeEChiusura;
var
  Json: TJSONObject;
begin
  FPayload.Canale := scOrdinamentale;
  Json := JsonInterno;
  try
    Assert.AreEqual('Sede di Pordenone', Json.GetValue<string>('listaStudenti[0].sede'));
    Assert.AreEqual(MOTIVO_CHIUSURA_PONTE, Json.GetValue<string>('listaStudenti[0].motivoChiusura'));
    Assert.AreEqual('2026-03-02', Json.GetValue<string>('listaStudenti[0].dataInizioChiusura'));
    Assert.AreEqual('2026-03-02', Json.GetValue<string>('listaStudenti[0].dataFineChiusura'));
  finally
    Json.Free;
  end;
end;

procedure TTestSiufClient.Ordinamentale_ChiusuraVuota_StringheVuote;
var
  Json: TJSONObject;
  Presenza: TSiufPresenza;
begin
  // Senza chiusura i tre campi restano stringhe vuote, come nell'esempio
  // del paragrafo 1.6 delle specifiche IeFP
  FPayload.Canale := scOrdinamentale;
  Presenza := FPayload.ListaStudenti[0];
  Presenza.MotivoChiusura := '';
  Presenza.DataInizioChiusura := '';
  Presenza.DataFineChiusura := '';

  Json := JsonInterno;
  try
    Assert.AreEqual('', Json.GetValue<string>('listaStudenti[0].motivoChiusura'));
    Assert.AreEqual('', Json.GetValue<string>('listaStudenti[0].dataInizioChiusura'));
  finally
    Json.Free;
  end;
end;

procedure TTestSiufClient.Body_PayloadBase64DelJsonInterno;
var
  Esterno: TJSONObject;
  Decodificato: string;
begin
  Esterno := TJSONObject.ParseJSONValue(FClient.BuildBody(FPayload)) as TJSONObject;
  try
    Assert.IsNotNull(Esterno);
    Assert.AreEqual(1, Esterno.Count);
    Decodificato := TEncoding.UTF8.GetString(TNetEncoding.Base64.DecodeStringToBytes(Esterno.GetValue<string>('payload')));
    Assert.AreEqual(FClient.BuildReadableJson(FPayload), Decodificato);
  finally
    Esterno.Free;
  end;
end;

procedure TTestSiufClient.Body_CaratteriAccentati_InUtf8;
var
  Esterno: TJSONObject;
  Interno: TJSONObject;
  Decodificato: string;
begin
  FPayload.ListaStudenti[0].Nome := 'Niccol' + #$00F2;
  FPayload.ListaStudenti[0].ContenutiMateria := 'Sicurezza nel cantiere ' + #$2013 + ' modulo ' + #$00E8;

  Esterno := TJSONObject.ParseJSONValue(FClient.BuildBody(FPayload)) as TJSONObject;
  try
    Decodificato := TEncoding.UTF8.GetString(TNetEncoding.Base64.DecodeStringToBytes(Esterno.GetValue<string>('payload')));
  finally
    Esterno.Free;
  end;

  Interno := TJSONObject.ParseJSONValue(Decodificato) as TJSONObject;
  try
    Assert.AreEqual('Niccol' + #$00F2, Interno.GetValue<string>('listaStudenti[0].nome'));
    Assert.AreEqual('Sicurezza nel cantiere ' + #$2013 + ' modulo ' + #$00E8, Interno.GetValue<string>('listaStudenti[0].contenutiMateria'));
  finally
    Interno.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestSiufClient);

end.
