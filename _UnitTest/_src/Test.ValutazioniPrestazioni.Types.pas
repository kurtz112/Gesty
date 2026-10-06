unit Test.ValutazioniPrestazioni.Types;

// Test DUnitX per ValutazioniPrestazioni.types.pas: round-trip delle property
// AsString (GetAsString/SetAsString) e coerenza delle Description per gli enum
// di risorsa/fornitore/contratto/stato. Nessuna dipendenza esterna.

interface

uses
  System.SysUtils,
  DUnitX.TestFramework,
  ValutazioniPrestazioni.types;

type
  [TestFixture]
  TTestValutazioniTypes = class
  public
    [Test]
    procedure TipoRisorsa_RoundTrip;
    [Test]
    procedure TipoRisorsa_Description;
    [Test]
    procedure TipologiaFornitore_RoundTrip;
    [Test]
    procedure TipoContratto_RoundTrip;
    [Test]
    procedure TipoContratto_Description;
    [Test]
    procedure StatoRisorsa_RoundTrip;
    [Test]
    procedure StatoRisorsa_Description;
    [Test]
    procedure SetAsString_CaseInsensitive;
  end;

implementation

{ TTestValutazioniTypes }

procedure TTestValutazioniTypes.TipoRisorsa_RoundTrip;
var
  v, r: TTipoRisorsa;
begin
  for v := Low(TTipoRisorsa) to High(TTipoRisorsa) do
  begin
    r.AsString := v.AsString;
    Assert.AreEqual(Ord(v), Ord(r), 'Round-trip TipoRisorsa ord ' + Ord(v).ToString);
  end;
end;

procedure TTestValutazioniTypes.TipoRisorsa_Description;
begin
  Assert.AreEqual('Persona', trPersona.Description);
  Assert.AreEqual('Azienda', trAzienda.Description);
  Assert.AreEqual('P', trPersona.AsString);
  Assert.AreEqual('A', trAzienda.AsString);
end;

procedure TTestValutazioniTypes.TipologiaFornitore_RoundTrip;
var
  v, r: TTipologiaFornitore;
begin
  for v := Low(TTipologiaFornitore) to High(TTipologiaFornitore) do
  begin
    r.AsString := v.AsString;
    Assert.AreEqual(Ord(v), Ord(r), 'Round-trip TipologiaFornitore ord ' + Ord(v).ToString);
  end;
end;

procedure TTestValutazioniTypes.TipoContratto_RoundTrip;
var
  v, r: TTipoContratto;
begin
  for v := Low(TTipoContratto) to High(TTipoContratto) do
  begin
    r.AsString := v.AsString;
    Assert.AreEqual(Ord(v), Ord(r), 'Round-trip TipoContratto ord ' + Ord(v).ToString);
  end;
end;

procedure TTestValutazioniTypes.TipoContratto_Description;
begin
  Assert.AreEqual('D', tcDipendente.AsString);
  Assert.AreEqual('Partita Iva', tcPartitaIva.Description);
  Assert.AreEqual('Interinale', tcInterinale.Description);
end;

procedure TTestValutazioniTypes.StatoRisorsa_RoundTrip;
var
  v, r: TStatoRisorsa;
begin
  for v := Low(TStatoRisorsa) to High(TStatoRisorsa) do
  begin
    r.AsString := v.AsString;
    Assert.AreEqual(Ord(v), Ord(r), 'Round-trip StatoRisorsa ord ' + Ord(v).ToString);
  end;
end;

procedure TTestValutazioniTypes.StatoRisorsa_Description;
begin
  Assert.AreEqual('Attiva', srAttiva.Description);
  Assert.AreEqual('Sospesa', srSospesa.Description);
  Assert.AreEqual('Eliminata', srEliminata.Description);
end;

procedure TTestValutazioniTypes.SetAsString_CaseInsensitive;
var
  r: TTipoContratto;
begin
  // SetAsString usa SameText: accetta minuscole.
  r.AsString := 'd';
  Assert.AreEqual(Ord(tcDipendente), Ord(r));
  r.AsString := 'a';
  Assert.AreEqual(Ord(tcAzienda), Ord(r));
end;

initialization
  TDUnitX.RegisterTestFixture(TTestValutazioniTypes);

end.
