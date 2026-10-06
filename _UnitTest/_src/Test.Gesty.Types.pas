unit Test.Gesty.Types;

// Test DUnitX per Gesty.Types.pas: round-trip degli helper enum<->stringa.
// Il pattern e' FromString(ToString(x)) = x su tutti i valori dell'enum:
// intercetta il classico "aggiunto un valore all'enum ma non al case".
// Nessuna dipendenza da UI, database o rete.

interface

uses
  System.SysUtils,
  DUnitX.TestFramework,
  Gesty.Types;

type
  [TestFixture]
  TTestGestyTypesRoundTrip = class
  public
    // --- enum con round-trip completo ---
    [Test]
    procedure StatoPresenza_RoundTrip;
    [Test]
    procedure SchedulerTipoEvento_RoundTrip;
    [Test]
    procedure StatoRiunione_RoundTrip;
    [Test]
    procedure FirmaTipoDoc_RoundTrip;
    [Test]
    procedure ASTipoIntervento_RoundTrip;
    // Corretto in Gesty.Types: FromString gestisce anche 'F' e 'A'
    [Test]
    procedure TipoTirocinio_RoundTrip_Completo;

    // --- casi limite documentati ---
    [Test]
    procedure StatoPresenza_StringaIgnota_DefaultPresente;
    [Test]
    procedure ASTipoIntervento_Null_StringaVuota;
    // Corretto in Gesty.Types: niente enum casuale su stringa ignota
    [Test]
    procedure TipoTirocinio_StringaIgnota_DefaultAltro;
    [Test]
    procedure FirmaTipoDoc_StringaIgnota_DefaultContratto;
    [Test]
    procedure StatoRiunione_StringaIgnota_DefaultInserita;
    [Test]
    procedure SchedulerTipoEvento_SenzaMaiuscole;
    [Test]
    procedure SchedulerTipoEvento_StringaIgnota_Null;

    // --- comportamento aggiuntivo ---
    [Test]
    procedure SchedulerTipoEvento_CanIntersect_SoloAgendaEScadenza;
    [Test]
    procedure SchedulerTipoEvento_IdFieldName_Mappato;
    [Test]
    procedure SchedulerTipoEvento_IdFieldNameEDescrizione_TuttiTranneNull;
    [Test]
    procedure TipoTirocinio_Description_NonVuota;
  end;

implementation

{ TTestGestyTypesRoundTrip }

procedure TTestGestyTypesRoundTrip.StatoPresenza_RoundTrip;
var
  v: TStatoPresenza;
begin
  for v := Low(TStatoPresenza) to High(TStatoPresenza) do
    Assert.AreEqual(Ord(v), Ord(TStatoPresenza.FromString(v.ToString)),
      'Round-trip fallito per StatoPresenza ord ' + Ord(v).ToString);
end;

procedure TTestGestyTypesRoundTrip.SchedulerTipoEvento_RoundTrip;
var
  v: TSchedulerTipoEvento;
begin
  for v := Low(TSchedulerTipoEvento) to High(TSchedulerTipoEvento) do
    Assert.AreEqual(Ord(v), Ord(TSchedulerTipoEvento.FromString(v.ToString)),
      'Round-trip fallito per SchedulerTipoEvento ord ' + Ord(v).ToString);
end;

procedure TTestGestyTypesRoundTrip.StatoRiunione_RoundTrip;
var
  v: TStatoRiunione;
begin
  for v := Low(TStatoRiunione) to High(TStatoRiunione) do
    Assert.AreEqual(Ord(v), Ord(TStatoRiunione.FromString(v.ToString)),
      'Round-trip fallito per StatoRiunione ord ' + Ord(v).ToString);
end;

procedure TTestGestyTypesRoundTrip.FirmaTipoDoc_RoundTrip;
var
  v: TFirmaTipoDoc;
begin
  for v := Low(TFirmaTipoDoc) to High(TFirmaTipoDoc) do
    Assert.AreEqual(Ord(v), Ord(TFirmaTipoDoc.FromString(v.ToString)),
      'Round-trip fallito per FirmaTipoDoc ord ' + Ord(v).ToString);
end;

procedure TTestGestyTypesRoundTrip.ASTipoIntervento_RoundTrip;
var
  v: TASTipoIntervento;
begin
  for v := Low(TASTipoIntervento) to High(TASTipoIntervento) do
    Assert.AreEqual(Ord(v), Ord(TASTipoIntervento.FromString(v.ToString)),
      'Round-trip fallito per ASTipoIntervento ord ' + Ord(v).ToString);
end;

procedure TTestGestyTypesRoundTrip.TipoTirocinio_RoundTrip_Completo;
var
  v: TTipoTirocinio;
begin
  for v := Low(TTipoTirocinio) to High(TTipoTirocinio) do
    Assert.AreEqual(Ord(v), Ord(TTipoTirocinio.FromString(v.ToString)),
      'Round-trip fallito per TipoTirocinio ord ' + Ord(v).ToString);
end;

procedure TTestGestyTypesRoundTrip.StatoPresenza_StringaIgnota_DefaultPresente;
begin
  // FromString inizializza Result := spPresente prima dei confronti.
  Assert.AreEqual(Ord(spPresente), Ord(TStatoPresenza.FromString('?')));
  Assert.AreEqual(Ord(spPresente), Ord(TStatoPresenza.FromString('')));
end;

procedure TTestGestyTypesRoundTrip.ASTipoIntervento_Null_StringaVuota;
begin
  Assert.AreEqual('', tiNull.ToString);
  Assert.AreEqual(Ord(tiNull), Ord(TASTipoIntervento.FromString('')));
end;

procedure TTestGestyTypesRoundTrip.TipoTirocinio_StringaIgnota_DefaultAltro;
begin
  Assert.AreEqual(Ord(ttAltro), Ord(TTipoTirocinio.FromString('?')));
  Assert.AreEqual(Ord(ttAltro), Ord(TTipoTirocinio.FromString('')));
end;

procedure TTestGestyTypesRoundTrip.FirmaTipoDoc_StringaIgnota_DefaultContratto;
begin
  Assert.AreEqual(Ord(ftContratto), Ord(TFirmaTipoDoc.FromString('XYZ')));
end;

procedure TTestGestyTypesRoundTrip.StatoRiunione_StringaIgnota_DefaultInserita;
begin
  Assert.AreEqual(Ord(srInserita), Ord(TStatoRiunione.FromString('Z')));
end;

procedure TTestGestyTypesRoundTrip.SchedulerTipoEvento_SenzaMaiuscole;
begin
  // A differenza degli altri helper, qui il confronto e' SameText
  Assert.AreEqual(Ord(teOrarioLezione), Ord(TSchedulerTipoEvento.FromString('l')));
  Assert.AreEqual(Ord(teAttivitaFuoriSede), Ord(TSchedulerTipoEvento.FromString('f')));
end;

procedure TTestGestyTypesRoundTrip.SchedulerTipoEvento_StringaIgnota_Null;
begin
  Assert.AreEqual(Ord(teNull), Ord(TSchedulerTipoEvento.FromString('?')));
end;

procedure TTestGestyTypesRoundTrip.SchedulerTipoEvento_CanIntersect_SoloAgendaEScadenza;
begin
  // Le sovrapposizioni sono ammesse solo se almeno uno dei due e'
  // Agenda Personale o Scadenza.
  Assert.IsTrue(teAgendaPersonale.CanIntersect(teOrarioLezione));
  Assert.IsTrue(teOrarioLezione.CanIntersect(teScadenza));
  Assert.IsFalse(teOrarioLezione.CanIntersect(teRiunione));
end;

procedure TTestGestyTypesRoundTrip.SchedulerTipoEvento_IdFieldName_Mappato;
begin
  Assert.AreEqual('ID_ORARIO', teOrarioLezione.IdFieldName);
  Assert.AreEqual('ID_PRENOTAZIONE_AULA', tePrenotazioneAule.IdFieldName);
  // teNull non ha campo id: stringa vuota.
  Assert.AreEqual('', teNull.IdFieldName);
end;

procedure TTestGestyTypesRoundTrip.SchedulerTipoEvento_IdFieldNameEDescrizione_TuttiTranneNull;
var
  v: TSchedulerTipoEvento;
begin
  // Un tipo di evento nuovo senza campo chiave non si apre dal calendario
  for v := Succ(teNull) to High(TSchedulerTipoEvento) do
  begin
    Assert.IsTrue(v.IdFieldName <> '', 'IdFieldName vuoto per ord ' + Ord(v).ToString);
    Assert.IsTrue(v.Description <> '', 'Description vuota per ord ' + Ord(v).ToString);
  end;
end;

procedure TTestGestyTypesRoundTrip.TipoTirocinio_Description_NonVuota;
var
  v: TTipoTirocinio;
begin
  for v := Low(TTipoTirocinio) to High(TTipoTirocinio) do
    Assert.IsTrue(v.Description <> '',
      'Description vuota per TipoTirocinio ord ' + Ord(v).ToString);
end;

initialization
  TDUnitX.RegisterTestFixture(TTestGestyTypesRoundTrip);

end.
