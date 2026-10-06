// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-03
// ---------------------------------------------------------------------------

unit Test.SIUF.Builder;

// Test di API\CooperazioneApplicativa\SIUF.CooperazioneApplicativa.Builder:
// dal dataset della GRS_EXPORT ai payload pronti per SIUF. E' il punto in cui
// si sono concentrati i ticket del canale SIUF (#93, #100, #126, #152, #186):
// accorpamento delle ore contigue, codifica della tipologia per canale,
// formato delle ore, ore giustificate, suddivisione in finestre di tre giorni.
//
// Il dataset e' un TClientDataSet in memoria con le colonne che LoadPresenza
// legge, quindi niente database. Si passa solo da BuildChunks, l'unico metodo
// pubblico: gli aiuti privati (MinutiToSiuf, TipologiaToId...) si vedono
// attraverso i payload che producono.

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  Data.DB,
  Datasnap.DBClient,
  DUnitX.TestFramework,
  SIUF.CooperazioneApplicativa.Types,
  SIUF.CooperazioneApplicativa.Validator,
  SIUF.CooperazioneApplicativa.Builder;

type
  // Una riga della GRS_EXPORT: si parte da RigaBase e si cambia solo cio' che
  // il test vuole mettere alla prova
  TRigaGrs = record
    IdProgetto: Integer;
    Sezione: string;
    CodiceFiscale: string;
    Cognome: string;
    Nome: string;
    Docente: string;
    CoDocente: string;
    Materia: string;
    Contenuti: string;
    Data: TDate;
    OraInizio: string;
    OraFine: string;
    OrePresenza: string;
    OreAssenza: string;
    OreGiustificate: string;
    Tipologia: string;
    Sede: string;
    MotivoChiusura: string;
    DataInizioChiusura: TDate;
    DataFineChiusura: TDate;
  end;

  [TestFixture]
  TTestSiufBuilder = class
  private
    FDati: TClientDataSet;
    FChunk: TObjectList<TSiufPayload>;
    FCanale: TSiufCanale;
    FChiamateResolver: Integer;
    procedure CreaDataset(AConCampiOrdinamentali: Boolean = True);
    function RigaBase(AGiorno: Integer = 3; const AOraInizio: string = '09:00'; const AOraFine: string = '10:00'): TRigaGrs;
    procedure Aggiungi(const ARiga: TRigaGrs);
    procedure Costruisci(AConResolver: Boolean = True);
    function Presenza(AChunk, AIndice: Integer): TSiufPresenza;
    function TipologiaInviata(const ATipologia: string; ACanale: TSiufCanale): Integer;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    // --- Mantis #93 - 2026-09-08: ore adiacenti della stessa lezione ---
    [Test]
    procedure OreAdiacenti_UnaPresenzaSola;
    [Test]
    procedure OreConPausa_RestanoDistinte;
    [Test]
    procedure DocenteDiverso_RestanoDistinte;
    [Test]
    procedure MateriaDiversa_RestanoDistinte;
    [Test]
    procedure StudentiDiversi_RestanoDistinti;
    [Test]
    procedure OreAdiacentiInDisordine_Accorpate;
    // Mantis #152 - 2026-09-21: l'ordinamentale vuole righe da 60 minuti
    [Test]
    procedure Ordinamentale_NonAccorpa;

    // --- Mantis #186 - 2026-09-28: formato delle ore ---
    [Test]
    procedure FormatoOre_InteroSenzaZeri_MinutiOreMinuti;

    // --- Mantis #100 / #186: ore di assenza giustificata ---
    [Test]
    procedure ExtraObbligo_GiustificateNelleAssenze;
    [Test]
    procedure Ordinamentale_GiustificateSeparate;

    // --- Mantis #93 / #126: tipologia sull'Extra Obbligo ---
    [Test]
    [TestCase('Collettiva', '1,1')]
    [TestCase('AulaInPresenza', '29,1')]
    [TestCase('Tirocinio', '2,2')]
    [TestCase('AlternanzaProtetta', '16,2')]
    [TestCase('TirocinioSmartWorking', '31,2')]
    [TestCase('Fad', '9,4')]
    [TestCase('FadSincrona', '12,4')]
    [TestCase('FadAsincronaRecupero', '18,4')]
    [TestCase('Esercitazione', 'ES,3')]
    [TestCase('EsercitazioneMinuscolo', 'es,3')]
    [TestCase('FormazioneEsterna', '5,0')]
    [TestCase('ProjectWork', '6,0')]
    [TestCase('NonNumerica', 'X,0')]
    procedure TipologiaExtraObbligo(const ATipologia: string; AAtteso: Integer);

    // --- Mantis #100: tipologia sull'ordinamentale ---
    [Test]
    [TestCase('Collettiva', '1,1')]
    [TestCase('FormazioneInterna', '4,4')]
    [TestCase('Orientamento', '21,21')]
    [TestCase('Ultimo', '34,34')]
    [TestCase('ProjectWorkGenerico', '6,0')]
    [TestCase('FadGenerica', '9,0')]
    [TestCase('Esercitazione', 'ES,0')]
    [TestCase('FuoriTabella', '35,0')]
    [TestCase('Zero', '0,0')]
    procedure TipologiaOrdinamentale(const ATipologia: string; AAtteso: Integer);

    // --- Mantis #100: caratteri tipografici in materia e contenuti ---
    [Test]
    procedure Materia_ApostrofoCurvoNormalizzato;
    [Test]
    procedure Contenuti_VirgoletteETrattiniNormalizzati;

    // --- suddivisione in finestre (limite SIUF: tre giorni distinti) ---
    [Test]
    procedure QuattroGiorni_DueChunk;
    [Test]
    procedure TreGiorni_UnChunk;
    [Test]
    procedure GiorniLontani_ChunkSeparati;
    [Test]
    procedure SezioniDiverse_ChunkSeparati;
    [Test]
    procedure Header_UtenteSezioneProgettoCanale;

    // --- lettura del dataset ---
    [Test]
    procedure Resolver_UnaVoltaPerProgetto;
    [Test]
    procedure SenzaResolver_ExtraObbligo;
    [Test]
    procedure SezioneNonNumerica_Solleva;
    [Test]
    procedure CampiOrdinamentaliAssenti_NonSolleva;
    [Test]
    procedure Chiusura_DateInFormatoIso;
    [Test]
    procedure Data_FormatoGiornoMeseAnno;
    [Test]
    procedure Dataset_RiportatoAllaPrimaRiga;
    [Test]
    procedure DatasetVuoto_NessunChunk;

    // --- dal dataset al validatore ---
    [Test]
    procedure PayloadCostruito_SuperaIlValidatore;
  end;

implementation

{ TTestSiufBuilder }

procedure TTestSiufBuilder.Setup;
begin
  FDati := nil;
  FChunk := nil;
  FCanale := scExtraObbligo;
  FChiamateResolver := 0;
end;

procedure TTestSiufBuilder.TearDown;
begin
  FChunk.Free;
  FDati.Free;
end;

procedure TTestSiufBuilder.CreaDataset(AConCampiOrdinamentali: Boolean);
begin
  FDati.Free;
  FDati := TClientDataSet.Create(nil);

  FDati.FieldDefs.Add('ID_PROGETTO', ftInteger);
  FDati.FieldDefs.Add('RIF_EVENTO_FORMATIVO', ftString, 20);
  FDati.FieldDefs.Add('CODICE_FISCALE_STUDENTE', ftString, 20);
  FDati.FieldDefs.Add('COGNOME', ftString, 50);
  FDati.FieldDefs.Add('NOME', ftString, 50);
  FDati.FieldDefs.Add('CODICE_FISCALE_DOCENTE', ftString, 20);
  FDati.FieldDefs.Add('CODICE_FISCALE_CODOCENTE', ftString, 20);
  // Testi Unicode: gli apostrofi curvi devono arrivare intatti al builder
  FDati.FieldDefs.Add('MATERIA', ftWideString, 100);
  FDati.FieldDefs.Add('CONTENUTI_MATERIA', ftWideString, 100);
  FDati.FieldDefs.Add('DATA', ftDate);
  FDati.FieldDefs.Add('ORA_INIZIO', ftString, 5);
  FDati.FieldDefs.Add('ORA_FINE', ftString, 5);
  FDati.FieldDefs.Add('ORE_PRESENZA', ftString, 5);
  FDati.FieldDefs.Add('ORE_ASSENZA', ftString, 5);
  FDati.FieldDefs.Add('ORE_ASSENZA_GIUSTIFICATA', ftString, 5);
  FDati.FieldDefs.Add('TIPOLOGIA', ftString, 5);

  if AConCampiOrdinamentali then
  begin
    FDati.FieldDefs.Add('SEDE_FISICA_O_VIRTUALE', ftWideString, 100);
    FDati.FieldDefs.Add('MOTIVO_CHIUSURA', ftString, 1);
    FDati.FieldDefs.Add('DATA_INIZIO_CHIUSURA', ftDate);
    FDati.FieldDefs.Add('DATA_FINE_CHIUSURA', ftDate);
  end;

  FDati.CreateDataSet;
end;

function TTestSiufBuilder.RigaBase(AGiorno: Integer; const AOraInizio, AOraFine: string): TRigaGrs;
begin
  Result := Default(TRigaGrs);
  Result.IdProgetto := 1;
  Result.Sezione := '170146';
  Result.CodiceFiscale := 'VRDGPP90B02F205X';
  Result.Cognome := 'Verdi';
  Result.Nome := 'Giuseppe';
  Result.Docente := 'BNCLRA75C41G888K';
  Result.Materia := 'Gestione aziendale';
  Result.Contenuti := 'Bilancio';
  Result.Data := EncodeDate(2026, 3, AGiorno);
  Result.OraInizio := AOraInizio;
  Result.OraFine := AOraFine;
  Result.OrePresenza := '01:00';
  Result.OreAssenza := '00:00';
  Result.OreGiustificate := '00:00';
  Result.Tipologia := '1';
  Result.Sede := 'Sede di Pordenone';
end;

procedure TTestSiufBuilder.Aggiungi(const ARiga: TRigaGrs);
begin
  if FDati = nil then
    CreaDataset;

  FDati.Append;
  FDati.FieldByName('ID_PROGETTO').AsInteger := ARiga.IdProgetto;
  FDati.FieldByName('RIF_EVENTO_FORMATIVO').AsString := ARiga.Sezione;
  FDati.FieldByName('CODICE_FISCALE_STUDENTE').AsString := ARiga.CodiceFiscale;
  FDati.FieldByName('COGNOME').AsString := ARiga.Cognome;
  FDati.FieldByName('NOME').AsString := ARiga.Nome;
  FDati.FieldByName('CODICE_FISCALE_DOCENTE').AsString := ARiga.Docente;
  FDati.FieldByName('CODICE_FISCALE_CODOCENTE').AsString := ARiga.CoDocente;
  FDati.FieldByName('MATERIA').AsWideString := ARiga.Materia;
  FDati.FieldByName('CONTENUTI_MATERIA').AsWideString := ARiga.Contenuti;
  FDati.FieldByName('DATA').AsDateTime := ARiga.Data;
  FDati.FieldByName('ORA_INIZIO').AsString := ARiga.OraInizio;
  FDati.FieldByName('ORA_FINE').AsString := ARiga.OraFine;
  FDati.FieldByName('ORE_PRESENZA').AsString := ARiga.OrePresenza;
  FDati.FieldByName('ORE_ASSENZA').AsString := ARiga.OreAssenza;
  FDati.FieldByName('ORE_ASSENZA_GIUSTIFICATA').AsString := ARiga.OreGiustificate;
  FDati.FieldByName('TIPOLOGIA').AsString := ARiga.Tipologia;

  if FDati.FindField('SEDE_FISICA_O_VIRTUALE') <> nil then
  begin
    FDati.FieldByName('SEDE_FISICA_O_VIRTUALE').AsWideString := ARiga.Sede;

    if ARiga.MotivoChiusura <> '' then
      FDati.FieldByName('MOTIVO_CHIUSURA').AsString := ARiga.MotivoChiusura;

    // Le date di chiusura mancanti restano NULL, come nella GRS_EXPORT
    if ARiga.DataInizioChiusura <> 0 then
      FDati.FieldByName('DATA_INIZIO_CHIUSURA').AsDateTime := ARiga.DataInizioChiusura;
    if ARiga.DataFineChiusura <> 0 then
      FDati.FieldByName('DATA_FINE_CHIUSURA').AsDateTime := ARiga.DataFineChiusura;
  end;

  FDati.Post;
end;

procedure TTestSiufBuilder.Costruisci(AConResolver: Boolean);
begin
  if FDati = nil then
    CreaDataset;

  FreeAndNil(FChunk);

  if AConResolver then
    FChunk := TSiufPayloadBuilder.BuildChunks(FDati, 'RSSMRA80A01H501U',
      function(AIdProgetto: Integer): TSiufCanale
      begin
        Inc(FChiamateResolver);
        Result := FCanale;
      end)
  else
    FChunk := TSiufPayloadBuilder.BuildChunks(FDati, 'RSSMRA80A01H501U');
end;

function TTestSiufBuilder.Presenza(AChunk, AIndice: Integer): TSiufPresenza;
begin
  Result := FChunk[AChunk].ListaStudenti[AIndice];
end;

function TTestSiufBuilder.TipologiaInviata(const ATipologia: string; ACanale: TSiufCanale): Integer;
var
  Riga: TRigaGrs;
begin
  FCanale := ACanale;
  Riga := RigaBase;
  Riga.Tipologia := ATipologia;
  Aggiungi(Riga);
  Costruisci;
  Result := Presenza(0, 0).Tipologia;
end;

procedure TTestSiufBuilder.OreAdiacenti_UnaPresenzaSola;
var
  P: TSiufPresenza;
begin
  // SIUF cerca la lezione per ora di inizio e di fine esatte: due ore di
  // Gesty, 09-10 e 10-11, sul GRS sono una lezione sola 09-11
  Aggiungi(RigaBase(3, '09:00', '10:00'));
  Aggiungi(RigaBase(3, '10:00', '11:00'));
  Costruisci;

  Assert.AreEqual(1, FChunk.Count);
  Assert.AreEqual(1, FChunk[0].ListaStudenti.Count);
  P := Presenza(0, 0);
  Assert.AreEqual('09:00', P.OraInizio);
  Assert.AreEqual('11:00', P.OraFine);
  Assert.AreEqual('2', P.OrePresenza);
  Assert.AreEqual('0', P.OreAssenza);
  Assert.AreEqual('0', P.OreAssenzaGiustificata);
end;

procedure TTestSiufBuilder.OreConPausa_RestanoDistinte;
begin
  Aggiungi(RigaBase(3, '09:00', '10:00'));
  Aggiungi(RigaBase(3, '11:00', '12:00'));
  Costruisci;

  Assert.AreEqual(2, FChunk[0].ListaStudenti.Count);
end;

procedure TTestSiufBuilder.DocenteDiverso_RestanoDistinte;
var
  Riga: TRigaGrs;
begin
  Aggiungi(RigaBase(3, '09:00', '10:00'));
  Riga := RigaBase(3, '10:00', '11:00');
  Riga.Docente := 'GLLMRC70D10L219Z';
  Aggiungi(Riga);
  Costruisci;

  Assert.AreEqual(2, FChunk[0].ListaStudenti.Count);
end;

procedure TTestSiufBuilder.MateriaDiversa_RestanoDistinte;
var
  Riga: TRigaGrs;
begin
  Aggiungi(RigaBase(3, '09:00', '10:00'));
  Riga := RigaBase(3, '10:00', '11:00');
  Riga.Materia := 'Informatica';
  Aggiungi(Riga);
  Costruisci;

  Assert.AreEqual(2, FChunk[0].ListaStudenti.Count);
end;

procedure TTestSiufBuilder.StudentiDiversi_RestanoDistinti;
var
  Riga: TRigaGrs;
  P: TSiufPresenza;
begin
  Aggiungi(RigaBase(3, '09:00', '10:00'));
  Riga := RigaBase(3, '10:00', '11:00');
  Riga.CodiceFiscale := 'RSSLCU02E15G888P';
  Aggiungi(Riga);
  Aggiungi(RigaBase(3, '10:00', '11:00'));
  Riga := RigaBase(3, '09:00', '10:00');
  Riga.CodiceFiscale := 'RSSLCU02E15G888P';
  Aggiungi(Riga);
  Costruisci;

  // Due studenti, ognuno con la sua lezione 09-11
  Assert.AreEqual(2, FChunk[0].ListaStudenti.Count);
  for P in FChunk[0].ListaStudenti do
  begin
    Assert.AreEqual('09:00', P.OraInizio, P.CodiceFiscale);
    Assert.AreEqual('11:00', P.OraFine, P.CodiceFiscale);
  end;
end;

procedure TTestSiufBuilder.OreAdiacentiInDisordine_Accorpate;
var
  Riga: TRigaGrs;
begin
  // Il dataset non e' ordinato per ora: l'accorpamento ordina prima
  Aggiungi(RigaBase(3, '11:00', '12:00'));
  Aggiungi(RigaBase(3, '09:00', '10:00'));
  Riga := RigaBase(3, '10:00', '11:00');
  Riga.OrePresenza := '00:30';
  Riga.OreAssenza := '00:30';
  Aggiungi(Riga);
  Costruisci;

  Assert.AreEqual(1, FChunk[0].ListaStudenti.Count);
  Assert.AreEqual('09:00', Presenza(0, 0).OraInizio);
  Assert.AreEqual('12:00', Presenza(0, 0).OraFine);
  Assert.AreEqual('2.30', Presenza(0, 0).OrePresenza);
  Assert.AreEqual('0.30', Presenza(0, 0).OreAssenza);
end;

procedure TTestSiufBuilder.Ordinamentale_NonAccorpa;
begin
  FCanale := scOrdinamentale;
  Aggiungi(RigaBase(3, '09:00', '10:00'));
  Aggiungi(RigaBase(3, '10:00', '11:00'));
  Costruisci;

  Assert.AreEqual(2, FChunk[0].ListaStudenti.Count);
  Assert.AreEqual('10:00', Presenza(0, 0).OraFine);
end;

procedure TTestSiufBuilder.FormatoOre_InteroSenzaZeri_MinutiOreMinuti;
var
  Riga: TRigaGrs;
begin
  // SIUF rifiuta "1.00" e "0.00": vuole "1" e "0". I minuti restano ore.minuti
  Riga := RigaBase(3, '09:00', '10:00');
  Riga.OrePresenza := '00:45';
  Riga.OreAssenza := '00:15';
  Aggiungi(Riga);
  Riga := RigaBase(4, '09:00', '10:00');
  Aggiungi(Riga);
  Costruisci;

  Assert.AreEqual('0.45', Presenza(0, 0).OrePresenza);
  Assert.AreEqual('0.15', Presenza(0, 0).OreAssenza);
  Assert.AreEqual('1', Presenza(0, 1).OrePresenza);
  Assert.AreEqual('0', Presenza(0, 1).OreAssenza);
end;

procedure TTestSiufBuilder.ExtraObbligo_GiustificateNelleAssenze;
var
  Riga: TRigaGrs;
begin
  // L'Extra Obbligo impone oreAssenzaGiustificata = "0": le giustificate
  // confluiscono nelle assenze
  Riga := RigaBase;
  Riga.OrePresenza := '00:30';
  Riga.OreAssenza := '00:15';
  Riga.OreGiustificate := '00:15';
  Aggiungi(Riga);
  Costruisci;

  Assert.AreEqual('0.30', Presenza(0, 0).OreAssenza);
  Assert.AreEqual('0', Presenza(0, 0).OreAssenzaGiustificata);
end;

procedure TTestSiufBuilder.Ordinamentale_GiustificateSeparate;
var
  Riga: TRigaGrs;
begin
  // Sull'ordinamentale, ITS e IFTS compresi, le giustificate sono reali
  FCanale := scOrdinamentale;
  Riga := RigaBase;
  Riga.OrePresenza := '00:30';
  Riga.OreAssenza := '00:15';
  Riga.OreGiustificate := '00:15';
  Aggiungi(Riga);
  Costruisci;

  Assert.AreEqual('0.15', Presenza(0, 0).OreAssenza);
  Assert.AreEqual('0.15', Presenza(0, 0).OreAssenzaGiustificata);
end;

procedure TTestSiufBuilder.TipologiaExtraObbligo(const ATipologia: string; AAtteso: Integer);
begin
  Assert.AreEqual(AAtteso, TipologiaInviata(ATipologia, scExtraObbligo), ATipologia);
  // Il codice di partenza resta, per il messaggio del validatore
  Assert.AreEqual(ATipologia, Presenza(0, 0).TipologiaGesty);
end;

procedure TTestSiufBuilder.TipologiaOrdinamentale(const ATipologia: string; AAtteso: Integer);
begin
  Assert.AreEqual(AAtteso, TipologiaInviata(ATipologia, scOrdinamentale), ATipologia);
end;

procedure TTestSiufBuilder.Materia_ApostrofoCurvoNormalizzato;
var
  Riga: TRigaGrs;
begin
  // Caso reale: sezione 170146, 09/09/2026, "Gestione d'azienda" scritto
  // con l'apostrofo curvo in Gesty e con quello dritto sul portale
  Riga := RigaBase;
  Riga.Materia := 'Gestione d' + #$2019 + 'azienda';
  Aggiungi(Riga);
  Costruisci;

  Assert.AreEqual('Gestione d''azienda', Presenza(0, 0).Materia);
end;

procedure TTestSiufBuilder.Contenuti_VirgoletteETrattiniNormalizzati;
var
  Riga: TRigaGrs;
begin
  Riga := RigaBase;
  Riga.Contenuti := #$201C + 'Sicurezza' + #$201D + ' ' + #$2013 + ' modulo ' + #$2018 + 'base' + #$2019 + ' ' + #$2014 + ' fine';
  Aggiungi(Riga);
  Costruisci;

  Assert.AreEqual('"Sicurezza" - modulo ''base'' - fine', Presenza(0, 0).ContenutiMateria);
end;

procedure TTestSiufBuilder.QuattroGiorni_DueChunk;
begin
  Aggiungi(RigaBase(2));
  Aggiungi(RigaBase(3));
  Aggiungi(RigaBase(4));
  Aggiungi(RigaBase(5));
  Costruisci;

  Assert.AreEqual(2, FChunk.Count);
  Assert.AreEqual('2026-03-02', FChunk[0].DataInizio);
  Assert.AreEqual('2026-03-04', FChunk[0].DataFine);
  Assert.AreEqual(3, FChunk[0].ListaStudenti.Count);
  Assert.AreEqual('2026-03-05', FChunk[1].DataInizio);
  Assert.AreEqual('2026-03-05', FChunk[1].DataFine);
end;

procedure TTestSiufBuilder.TreGiorni_UnChunk;
begin
  Aggiungi(RigaBase(4));
  Aggiungi(RigaBase(2));
  Aggiungi(RigaBase(3));
  Costruisci;

  Assert.AreEqual(1, FChunk.Count);
  Assert.AreEqual('2026-03-02', FChunk[0].DataInizio);
  Assert.AreEqual('2026-03-04', FChunk[0].DataFine);
  // In ordine di data dentro il chunk
  Assert.AreEqual('02/03/2026', Presenza(0, 0).Data);
  Assert.AreEqual('04/03/2026', Presenza(0, 2).Data);
end;

procedure TTestSiufBuilder.GiorniLontani_ChunkSeparati;
begin
  // La finestra si misura dal primo giorno, non conta solo i giorni presenti
  Aggiungi(RigaBase(2));
  Aggiungi(RigaBase(6));
  Costruisci;

  Assert.AreEqual(2, FChunk.Count);
  Assert.AreEqual('2026-03-02', FChunk[0].DataFine);
end;

procedure TTestSiufBuilder.SezioniDiverse_ChunkSeparati;
var
  Riga: TRigaGrs;
  Sezioni: TList<Integer>;
  Payload: TSiufPayload;
begin
  Aggiungi(RigaBase);
  Riga := RigaBase;
  Riga.Sezione := '170147';
  Aggiungi(Riga);
  Costruisci;

  Assert.AreEqual(2, FChunk.Count);

  // L'ordine dei gruppi non e' garantito: si controlla l'insieme
  Sezioni := TList<Integer>.Create;
  try
    for Payload in FChunk do
      Sezioni.Add(Payload.IdSezione);
    Assert.IsTrue(Sezioni.Contains(170146));
    Assert.IsTrue(Sezioni.Contains(170147));
  finally
    Sezioni.Free;
  end;
end;

procedure TTestSiufBuilder.Header_UtenteSezioneProgettoCanale;
var
  Riga: TRigaGrs;
begin
  FCanale := scOrdinamentale;
  Riga := RigaBase;
  Riga.IdProgetto := 42;
  Aggiungi(Riga);
  Costruisci;

  Assert.AreEqual('RSSMRA80A01H501U', FChunk[0].CodiceFiscaleUser);
  Assert.AreEqual(170146, FChunk[0].IdSezione);
  Assert.AreEqual(42, FChunk[0].IdProgetto);
  Assert.IsTrue(FChunk[0].Canale = scOrdinamentale);
  Assert.IsTrue(Presenza(0, 0).Canale = scOrdinamentale);
end;

procedure TTestSiufBuilder.Resolver_UnaVoltaPerProgetto;
var
  Riga: TRigaGrs;
  Giorno: Integer;
begin
  // Il resolver di solito interroga il database: una volta per progetto,
  // non una per riga
  for Giorno := 2 to 4 do
    Aggiungi(RigaBase(Giorno));
  Riga := RigaBase;
  Riga.IdProgetto := 2;
  Aggiungi(Riga);
  Riga.Data := EncodeDate(2026, 3, 4);
  Aggiungi(Riga);
  Costruisci;

  Assert.AreEqual(2, FChiamateResolver);
end;

procedure TTestSiufBuilder.SenzaResolver_ExtraObbligo;
begin
  Aggiungi(RigaBase);
  Costruisci(False);

  Assert.IsTrue(FChunk[0].Canale = scExtraObbligo);
end;

procedure TTestSiufBuilder.SezioneNonNumerica_Solleva;
var
  Riga: TRigaGrs;
begin
  Riga := RigaBase;
  Riga.Sezione := 'ABC';
  Aggiungi(Riga);

  Assert.WillRaise(
    procedure
    begin
      Costruisci;
    end, Exception);
end;

procedure TTestSiufBuilder.CampiOrdinamentaliAssenti_NonSolleva;
begin
  // Installazioni con la GRS_EXPORT non ancora allineata: i campi mancano
  FCanale := scOrdinamentale;
  CreaDataset(False);
  Aggiungi(RigaBase);
  Costruisci;

  Assert.AreEqual('', Presenza(0, 0).Sede);
  Assert.AreEqual('', Presenza(0, 0).MotivoChiusura);
  Assert.AreEqual('', Presenza(0, 0).DataInizioChiusura);
end;

procedure TTestSiufBuilder.Chiusura_DateInFormatoIso;
var
  Riga: TRigaGrs;
begin
  FCanale := scOrdinamentale;
  Riga := RigaBase;
  Riga.MotivoChiusura := MOTIVO_CHIUSURA_PONTE;
  Riga.DataInizioChiusura := EncodeDate(2026, 3, 2);
  Riga.DataFineChiusura := EncodeDate(2026, 3, 3);
  Aggiungi(Riga);
  Aggiungi(RigaBase(4));
  Costruisci;

  Assert.AreEqual(MOTIVO_CHIUSURA_PONTE, Presenza(0, 0).MotivoChiusura);
  Assert.AreEqual('2026-03-02', Presenza(0, 0).DataInizioChiusura);
  Assert.AreEqual('2026-03-03', Presenza(0, 0).DataFineChiusura);
  Assert.AreEqual('Sede di Pordenone', Presenza(0, 0).Sede);
  // Date NULL: stringa vuota, non 1899-12-30
  Assert.AreEqual('', Presenza(0, 1).DataInizioChiusura);
end;

procedure TTestSiufBuilder.Data_FormatoGiornoMeseAnno;
begin
  Aggiungi(RigaBase(9));
  Costruisci;

  Assert.AreEqual('09/03/2026', Presenza(0, 0).Data);
  Assert.AreEqual(Double(EncodeDate(2026, 3, 9)), Double(Presenza(0, 0).DataLezione), 0.0001);
end;

procedure TTestSiufBuilder.Dataset_RiportatoAllaPrimaRiga;
begin
  Aggiungi(RigaBase(2));
  Aggiungi(RigaBase(3));
  FDati.Last;
  Costruisci;

  Assert.AreEqual(1, FDati.RecNo);
end;

procedure TTestSiufBuilder.DatasetVuoto_NessunChunk;
begin
  CreaDataset;
  Costruisci;

  Assert.IsNotNull(FChunk);
  Assert.AreEqual(0, FChunk.Count);
end;

procedure TTestSiufBuilder.PayloadCostruito_SuperaIlValidatore;
var
  Violazioni: TList<TSiufViolazione>;
  Payload: TSiufPayload;
begin
  Aggiungi(RigaBase(2, '09:00', '10:00'));
  Aggiungi(RigaBase(2, '10:00', '11:00'));
  Aggiungi(RigaBase(3, '14:00', '15:00'));
  Costruisci;

  for Payload in FChunk do
  begin
    Violazioni := TSiufValidator.Valida(Payload);
    try
      Assert.AreEqual(0, Violazioni.Count);
    finally
      Violazioni.Free;
    end;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestSiufBuilder);

end.
