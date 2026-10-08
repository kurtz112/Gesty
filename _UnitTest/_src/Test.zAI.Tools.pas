// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-08
// ---------------------------------------------------------------------------

unit Test.zAI.Tools;

// Test di BASE\AI\zAI.Tools: strumenti che il modello AI puo' chiedere di
// eseguire (function calling). Copre le regole sul nome, lo schema JSON dei
// parametri, la dichiarazione neutra, l'esecuzione che non solleva mai e la
// lettura tollerante degli argomenti. Nessuna rete, nessun fornitore.
//
// I testi delle stringhe restano in ASCII: i caratteri accentati si scrivono
// col codice (#$00E0), cosi' il risultato non dipende dalla codifica del file.

interface

uses
  System.SysUtils,
  System.JSON,
  DUnitX.TestFramework,
  zAI.Tools;

type
  [TestFixture]
  TTestNomeStrumento = class
  public
    [Test]
    [TestCase('Semplice', 'cerca_progetti')]
    [TestCase('TrattinoBassoIniziale', '_interno')]
    [TestCase('ConTrattino', 'cerca-progetti')]
    [TestCase('ConCifre', 'versione2')]
    procedure NomeValido(const Nome: string);
    [Test]
    [TestCase('IniziaConCifra', '2cerca')]
    [TestCase('IniziaConTrattino', '-cerca')]
    [TestCase('ConSpazio', 'cerca progetti')]
    [TestCase('ConPunto', 'cerca.progetti')]
    procedure NomeNonValido(const Nome: string);
    [Test]
    procedure Lunghezza_SessantaquattroAmmessa_SessantacinqueNo;
    // R-038: le lettere accentate, che i fornitori (OpenAI, Gemini, Claude)
    // rifiutano, non devono superare il controllo del nome
    [Test]
    procedure NomeConLetteraAccentata_NonValido;
  end;

  [TestFixture]
  TTestStrumento = class
  private
    FStrumento: TzAITool;
    function Proprieta: TJSONObject;
    function Obbligatori: TJSONArray;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure Schema_VuotoAllaCreazione;
    [Test]
    procedure AddParameter_TipoEDescrizione;
    [Test]
    procedure AddParameter_Facoltativo_NonInRequired;
    [Test]
    procedure AddParameter_ValoriAmmessi_Enum;
    [Test]
    procedure AddParameter_RestituisceLoStrumento;
    [Test]
    procedure AddParameter_Ridefinito_SostituisceLoSchema;
    // R-038: un parametro obbligatorio ridefinito compare una volta sola in
    // "required"; ridefinito come facoltativo ne esce
    [Test]
    procedure AddParameter_Ridefinito_RequiredCoerente;
    [Test]
    procedure Declaration_SenzaParametri_NienteParameters;
    [Test]
    procedure Declaration_SenzaParametri_SchemaVuotoSuRichiesta;
    [Test]
    procedure Declaration_ConParametri_NomeDescrizioneSchema;
    [Test]
    procedure Declaration_ECopia_NonToccaLoStrumento;
  end;

  [TestFixture]
  TTestEsecuzione = class
  public
    [Test]
    procedure Execute_RisultatoDelGestore;
    [Test]
    procedure Execute_GestoreRestituisceNil_OggettoVuoto;
    [Test]
    procedure Execute_EccezioneDiventaErrore;
    [Test]
    procedure Execute_SenzaGestore_Errore;
    [Test]
    procedure Risultato_EErrore_Chiavi;
  end;

  [TestFixture]
  TTestInsiemeStrumenti = class
  private
    FInsieme: TzAIToolSet;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure Add_NomeNonValido_Solleva;
    [Test]
    procedure Add_Duplicato_SollevaAncheConMaiuscole;
    [Test]
    procedure Find_SenzaMaiuscole;
    [Test]
    procedure Remove_EClear;
    [Test]
    procedure Execute_StrumentoSconosciuto_ErroreLeggibile;
    [Test]
    procedure Execute_InoltraAlloStrumento;
    [Test]
    procedure Declarations_UnaPerStrumento;
  end;

  [TestFixture]
  TTestArgomenti = class
  private
    FArgomenti: TJSONObject;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure ArgString_PresenteMancanteNull;
    [Test]
    procedure ArgString_NumeroComeTesto;
    [Test]
    procedure ArgString_ArgomentiNil_Predefinito;
    [Test]
    procedure ArgInteger_IntRealeETesto;
    [Test]
    procedure ArgInteger_TestoNonNumerico_Predefinito;
    [Test]
    procedure ArgFloat_TestoColPunto_IndipendenteDallaLingua;
    [Test]
    procedure ArgFloat_TestoConVirgola_Predefinito;
    [Test]
    procedure ArgBoolean_FormeAccettate;
    [Test]
    procedure ArgBoolean_Mancante_Predefinito;
  end;

implementation

function Oggetto(const ATesto: string): TJSONObject;
begin
  Result := TJSONObject.ParseJSONValue(ATesto) as TJSONObject;
end;

{ TTestNomeStrumento }

procedure TTestNomeStrumento.NomeValido(const Nome: string);
begin
  Assert.IsTrue(IsValidToolName(Nome), Nome);
end;

procedure TTestNomeStrumento.NomeNonValido(const Nome: string);
begin
  Assert.IsFalse(IsValidToolName(Nome), Nome);
end;

procedure TTestNomeStrumento.Lunghezza_SessantaquattroAmmessa_SessantacinqueNo;
begin
  Assert.IsFalse(IsValidToolName(''));
  Assert.IsTrue(IsValidToolName(StringOfChar('a', 64)));
  Assert.IsFalse(IsValidToolName(StringOfChar('a', 65)));
end;

procedure TTestNomeStrumento.NomeConLetteraAccentata_NonValido;
begin
  Assert.IsFalse(IsValidToolName('cerca_citt' + #$00E0));
end;

{ TTestStrumento }

procedure TTestStrumento.Setup;
begin
  FStrumento := TzAITool.Create('cerca_progetti', 'Cerca i progetti', nil);
end;

procedure TTestStrumento.TearDown;
begin
  FStrumento.Free;
end;

function TTestStrumento.Proprieta: TJSONObject;
begin
  Result := FStrumento.Parameters.GetValue('properties') as TJSONObject;
end;

function TTestStrumento.Obbligatori: TJSONArray;
begin
  Result := FStrumento.Parameters.GetValue('required') as TJSONArray;
end;

procedure TTestStrumento.Schema_VuotoAllaCreazione;
begin
  Assert.AreEqual('object', FStrumento.Parameters.GetValue<string>('type'));
  Assert.AreEqual(0, Proprieta.Count);
  Assert.AreEqual(0, Obbligatori.Count);
end;

procedure TTestStrumento.AddParameter_TipoEDescrizione;
begin
  FStrumento.AddParameter('testo', ptString, 'Parte della denominazione');
  FStrumento.AddParameter('anno', ptInteger, '');
  FStrumento.AddParameter('importo', ptNumber, 'Importo');
  FStrumento.AddParameter('attivi', ptBoolean, 'Solo attivi');

  Assert.AreEqual('string', Proprieta.GetValue<string>('testo.type'));
  Assert.AreEqual('Parte della denominazione', Proprieta.GetValue<string>('testo.description'));
  Assert.AreEqual('integer', Proprieta.GetValue<string>('anno.type'));
  // Descrizione vuota: la chiave non c'e'
  Assert.IsNull((Proprieta.GetValue('anno') as TJSONObject).GetValue('description'));
  Assert.AreEqual('number', Proprieta.GetValue<string>('importo.type'));
  Assert.AreEqual('boolean', Proprieta.GetValue<string>('attivi.type'));
  Assert.AreEqual(4, Obbligatori.Count);
end;

procedure TTestStrumento.AddParameter_Facoltativo_NonInRequired;
begin
  FStrumento.AddParameter('testo', ptString, 'Testo');
  FStrumento.AddParameter('solo_in_corso', ptBoolean, 'Solo attivi', False);

  Assert.AreEqual(2, Proprieta.Count);
  Assert.AreEqual(1, Obbligatori.Count);
  Assert.AreEqual('testo', Obbligatori.Items[0].Value);
end;

procedure TTestStrumento.AddParameter_ValoriAmmessi_Enum;
var
  Valori: TJSONArray;
begin
  FStrumento.AddParameter('stato', ptString, 'Stato', True, ['A', 'S', 'E']);

  Valori := (Proprieta.GetValue('stato') as TJSONObject).GetValue('enum') as TJSONArray;
  Assert.IsNotNull(Valori);
  Assert.AreEqual(3, Valori.Count);
  Assert.AreEqual('S', Valori.Items[1].Value);
end;

procedure TTestStrumento.AddParameter_RestituisceLoStrumento;
begin
  Assert.AreSame(FStrumento, FStrumento.AddParameter('a', ptString, '').AddParameter('b', ptString, ''));
  Assert.AreEqual(2, Proprieta.Count);
end;

procedure TTestStrumento.AddParameter_Ridefinito_SostituisceLoSchema;
begin
  FStrumento.AddParameter('anno', ptString, 'Anno come testo');
  FStrumento.AddParameter('anno', ptInteger, 'Anno');

  Assert.AreEqual(1, Proprieta.Count);
  Assert.AreEqual('integer', Proprieta.GetValue<string>('anno.type'));
end;

procedure TTestStrumento.AddParameter_Ridefinito_RequiredCoerente;
begin
  FStrumento.AddParameter('anno', ptInteger, 'Anno');
  FStrumento.AddParameter('anno', ptInteger, 'Anno');
  Assert.AreEqual(1, Obbligatori.Count, 'ridefinito obbligatorio');

  FStrumento.AddParameter('anno', ptInteger, 'Anno', False);
  Assert.AreEqual(0, Obbligatori.Count, 'ridefinito facoltativo');
end;

procedure TTestStrumento.Declaration_SenzaParametri_NienteParameters;
var
  Dichiarazione: TJSONObject;
begin
  // Gemini rifiuta uno schema "object" con "properties" vuoto
  Dichiarazione := FStrumento.Declaration;
  try
    Assert.IsNull(Dichiarazione.GetValue('parameters'));
  finally
    Dichiarazione.Free;
  end;
end;

procedure TTestStrumento.Declaration_SenzaParametri_SchemaVuotoSuRichiesta;
var
  Dichiarazione: TJSONObject;
begin
  // Claude pretende lo schema anche vuoto
  Dichiarazione := FStrumento.Declaration(True);
  try
    Assert.IsNotNull(Dichiarazione.GetValue('parameters'));
    Assert.AreEqual('object', Dichiarazione.GetValue<string>('parameters.type'));
  finally
    Dichiarazione.Free;
  end;
end;

procedure TTestStrumento.Declaration_ConParametri_NomeDescrizioneSchema;
var
  Dichiarazione: TJSONObject;
begin
  FStrumento.AddParameter('testo', ptString, 'Testo');
  Dichiarazione := FStrumento.Declaration;
  try
    Assert.AreEqual('cerca_progetti', Dichiarazione.GetValue<string>('name'));
    Assert.AreEqual('Cerca i progetti', Dichiarazione.GetValue<string>('description'));
    Assert.AreEqual('string', Dichiarazione.GetValue<string>('parameters.properties.testo.type'));
  finally
    Dichiarazione.Free;
  end;
end;

procedure TTestStrumento.Declaration_ECopia_NonToccaLoStrumento;
var
  Dichiarazione: TJSONObject;
begin
  FStrumento.AddParameter('testo', ptString, 'Testo');
  Dichiarazione := FStrumento.Declaration;
  try
    (Dichiarazione.FindValue('parameters.properties') as TJSONObject).AddPair('intruso', TJSONObject.Create);
  finally
    Dichiarazione.Free;
  end;

  Assert.AreEqual(1, Proprieta.Count);
end;

{ TTestEsecuzione }

procedure TTestEsecuzione.Execute_RisultatoDelGestore;
var
  Strumento: TzAITool;
  Argomenti: TJSONObject;
  Esito: TJSONObject;
begin
  Strumento := TzAITool.Create('eco', 'Ripete il testo',
    function(const Args: TJSONObject): TJSONObject
    begin
      Result := TzAITool.Risultato(TzAITool.ArgString(Args, 'testo'));
    end);
  Argomenti := Oggetto('{"testo":"ciao"}');
  try
    Esito := Strumento.Execute(Argomenti);
    try
      Assert.AreEqual('ciao', Esito.GetValue<string>('risultato'));
    finally
      Esito.Free;
    end;
  finally
    Argomenti.Free;
    Strumento.Free;
  end;
end;

procedure TTestEsecuzione.Execute_GestoreRestituisceNil_OggettoVuoto;
var
  Strumento: TzAITool;
  Esito: TJSONObject;
begin
  Strumento := TzAITool.Create('niente', 'Non restituisce nulla',
    function(const Args: TJSONObject): TJSONObject
    begin
      Result := nil;
    end);
  try
    Esito := Strumento.Execute(nil);
    try
      Assert.IsNotNull(Esito);
      Assert.AreEqual(0, Esito.Count);
    finally
      Esito.Free;
    end;
  finally
    Strumento.Free;
  end;
end;

procedure TTestEsecuzione.Execute_EccezioneDiventaErrore;
var
  Strumento: TzAITool;
  Esito: TJSONObject;
begin
  Strumento := TzAITool.Create('rotto', 'Solleva sempre',
    function(const Args: TJSONObject): TJSONObject
    begin
      raise Exception.Create('archivio non raggiungibile');
    end);
  try
    Esito := Strumento.Execute(nil);
    try
      Assert.AreEqual('archivio non raggiungibile', Esito.GetValue<string>('errore'));
    finally
      Esito.Free;
    end;
  finally
    Strumento.Free;
  end;
end;

procedure TTestEsecuzione.Execute_SenzaGestore_Errore;
var
  Strumento: TzAITool;
  Esito: TJSONObject;
begin
  Strumento := TzAITool.Create('vuoto', 'Senza gestore', nil);
  try
    Esito := Strumento.Execute(nil);
    try
      Assert.Contains(Esito.GetValue<string>('errore'), 'vuoto');
    finally
      Esito.Free;
    end;
  finally
    Strumento.Free;
  end;
end;

procedure TTestEsecuzione.Risultato_EErrore_Chiavi;
var
  Esito: TJSONObject;
begin
  // Claude marca is_error proprio guardando la chiave "errore"
  Esito := TzAITool.Risultato('fatto');
  try
    Assert.AreEqual('fatto', Esito.GetValue<string>('risultato'));
    Assert.IsNull(Esito.GetValue('errore'));
  finally
    Esito.Free;
  end;

  Esito := TzAITool.Errore('fallito');
  try
    Assert.AreEqual('fallito', Esito.GetValue<string>('errore'));
    Assert.IsNull(Esito.GetValue('risultato'));
  finally
    Esito.Free;
  end;
end;

{ TTestInsiemeStrumenti }

procedure TTestInsiemeStrumenti.Setup;
begin
  FInsieme := TzAIToolSet.Create;
end;

procedure TTestInsiemeStrumenti.TearDown;
begin
  FInsieme.Free;
end;

procedure TTestInsiemeStrumenti.Add_NomeNonValido_Solleva;
begin
  Assert.WillRaise(
    procedure
    begin
      FInsieme.Add('nome con spazi', 'x', nil);
    end, EArgumentException);
  Assert.AreEqual(0, FInsieme.Count);
end;

procedure TTestInsiemeStrumenti.Add_Duplicato_SollevaAncheConMaiuscole;
begin
  FInsieme.Add('cerca', 'x', nil);
  Assert.WillRaise(
    procedure
    begin
      FInsieme.Add('CERCA', 'y', nil);
    end, EArgumentException);
  Assert.AreEqual(1, FInsieme.Count);
end;

procedure TTestInsiemeStrumenti.Find_SenzaMaiuscole;
var
  Strumento: TzAITool;
begin
  Strumento := FInsieme.Add('cerca_allievi', 'x', nil);
  Assert.AreSame(Strumento, FInsieme.Find('Cerca_Allievi'));
  Assert.IsNull(FInsieme.Find('cerca_docenti'));
end;

procedure TTestInsiemeStrumenti.Remove_EClear;
begin
  FInsieme.Add('a', 'x', nil);
  FInsieme.Add('b', 'x', nil);
  FInsieme.Add('c', 'x', nil);

  FInsieme.Remove('B');
  Assert.AreEqual(2, FInsieme.Count);
  Assert.IsNull(FInsieme.Find('b'));

  // Rimuovere un nome che non c'e' non fa nulla
  FInsieme.Remove('z');
  Assert.AreEqual(2, FInsieme.Count);

  FInsieme.Clear;
  Assert.AreEqual(0, FInsieme.Count);
end;

procedure TTestInsiemeStrumenti.Execute_StrumentoSconosciuto_ErroreLeggibile;
var
  Esito: TJSONObject;
begin
  // Il modello ogni tanto inventa uno strumento: la conversazione continua
  Esito := FInsieme.Execute('inventato', nil);
  try
    Assert.Contains(Esito.GetValue<string>('errore'), 'inventato');
  finally
    Esito.Free;
  end;
end;

procedure TTestInsiemeStrumenti.Execute_InoltraAlloStrumento;
var
  Esito: TJSONObject;
begin
  FInsieme.Add('saluta', 'x',
    function(const Args: TJSONObject): TJSONObject
    begin
      Result := TzAITool.Risultato('ciao');
    end);

  Esito := FInsieme.Execute('SALUTA', nil);
  try
    Assert.AreEqual('ciao', Esito.GetValue<string>('risultato'));
  finally
    Esito.Free;
  end;
end;

procedure TTestInsiemeStrumenti.Declarations_UnaPerStrumento;
var
  Dichiarazioni: TJSONArray;
begin
  FInsieme.Add('a', 'prima', nil);
  FInsieme.Add('b', 'seconda', nil).AddParameter('x', ptString, '');

  Dichiarazioni := FInsieme.Declarations;
  try
    Assert.AreEqual(2, Dichiarazioni.Count);
    Assert.AreEqual('a', (Dichiarazioni.Items[0] as TJSONObject).GetValue<string>('name'));
    Assert.IsNull((Dichiarazioni.Items[0] as TJSONObject).GetValue('parameters'));
    Assert.IsNotNull((Dichiarazioni.Items[1] as TJSONObject).GetValue('parameters'));
  finally
    Dichiarazioni.Free;
  end;
end;

{ TTestArgomenti }

procedure TTestArgomenti.Setup;
begin
  FArgomenti := Oggetto(
    '{"testo":"abc","nullo":null,"intero":12,"reale":12.0,"arrotondato":12.6,' +
    '"intero_testo":"12","parola":"abc","decimale_testo":"3.5","virgola_testo":"3,5",' +
    '"vero":true,"falso":false,"si":"si","uno":"1","vero_testo":"TRUE","zero":0,"due":2}');
end;

procedure TTestArgomenti.TearDown;
begin
  FArgomenti.Free;
end;

procedure TTestArgomenti.ArgString_PresenteMancanteNull;
begin
  Assert.AreEqual('abc', TzAITool.ArgString(FArgomenti, 'testo'));
  Assert.AreEqual('predefinito', TzAITool.ArgString(FArgomenti, 'manca', 'predefinito'));
  Assert.AreEqual('predefinito', TzAITool.ArgString(FArgomenti, 'nullo', 'predefinito'));
end;

procedure TTestArgomenti.ArgString_NumeroComeTesto;
begin
  Assert.AreEqual('12', TzAITool.ArgString(FArgomenti, 'intero'));
end;

procedure TTestArgomenti.ArgString_ArgomentiNil_Predefinito;
begin
  Assert.AreEqual('x', TzAITool.ArgString(nil, 'testo', 'x'));
  Assert.AreEqual(7, TzAITool.ArgInteger(nil, 'intero', 7));
  Assert.IsTrue(TzAITool.ArgBoolean(nil, 'vero', True));
end;

procedure TTestArgomenti.ArgInteger_IntRealeETesto;
begin
  // Il modello manda un intero come 12, come 12.0 o come "12"
  Assert.AreEqual(12, TzAITool.ArgInteger(FArgomenti, 'intero'));
  Assert.AreEqual(12, TzAITool.ArgInteger(FArgomenti, 'reale'));
  Assert.AreEqual(12, TzAITool.ArgInteger(FArgomenti, 'intero_testo'));
  Assert.AreEqual(13, TzAITool.ArgInteger(FArgomenti, 'arrotondato'));
  Assert.AreEqual(-1, TzAITool.ArgInteger(FArgomenti, 'manca', -1));
end;

procedure TTestArgomenti.ArgInteger_TestoNonNumerico_Predefinito;
begin
  Assert.AreEqual(5, TzAITool.ArgInteger(FArgomenti, 'parola', 5));
  // Un booleano non e' un numero: resta il predefinito
  Assert.AreEqual(5, TzAITool.ArgInteger(FArgomenti, 'vero', 5));
end;

procedure TTestArgomenti.ArgFloat_TestoColPunto_IndipendenteDallaLingua;
begin
  // Il JSON usa il punto anche su Windows in italiano
  Assert.AreEqual(3.5, TzAITool.ArgFloat(FArgomenti, 'decimale_testo'), 0.0001);
  Assert.AreEqual(12.6, TzAITool.ArgFloat(FArgomenti, 'arrotondato'), 0.0001);
end;

procedure TTestArgomenti.ArgFloat_TestoConVirgola_Predefinito;
begin
  Assert.AreEqual(-1.0, TzAITool.ArgFloat(FArgomenti, 'virgola_testo', -1), 0.0001);
end;

procedure TTestArgomenti.ArgBoolean_FormeAccettate;
begin
  Assert.IsTrue(TzAITool.ArgBoolean(FArgomenti, 'vero'));
  Assert.IsFalse(TzAITool.ArgBoolean(FArgomenti, 'falso', True));
  Assert.IsTrue(TzAITool.ArgBoolean(FArgomenti, 'si'));
  Assert.IsTrue(TzAITool.ArgBoolean(FArgomenti, 'uno'));
  Assert.IsTrue(TzAITool.ArgBoolean(FArgomenti, 'vero_testo'));
  Assert.IsFalse(TzAITool.ArgBoolean(FArgomenti, 'parola', True));
  Assert.IsFalse(TzAITool.ArgBoolean(FArgomenti, 'zero', True));
  Assert.IsTrue(TzAITool.ArgBoolean(FArgomenti, 'due'));
end;

procedure TTestArgomenti.ArgBoolean_Mancante_Predefinito;
begin
  Assert.IsTrue(TzAITool.ArgBoolean(FArgomenti, 'manca', True));
  Assert.IsFalse(TzAITool.ArgBoolean(FArgomenti, 'manca', False));
end;

initialization
  TDUnitX.RegisterTestFixture(TTestNomeStrumento);
  TDUnitX.RegisterTestFixture(TTestStrumento);
  TDUnitX.RegisterTestFixture(TTestEsecuzione);
  TDUnitX.RegisterTestFixture(TTestInsiemeStrumenti);
  TDUnitX.RegisterTestFixture(TTestArgomenti);

end.
