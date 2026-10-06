// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-03
// ---------------------------------------------------------------------------

unit Test.zAI.Protocol;

// Test di BASE\AI\zAI.Protocol e dei quattro dialetti (OpenAI, Ollama,
// Gemini, Claude). Un protocollo costruisce il JSON della richiesta e legge
// quello della risposta senza aprire connessioni: qui si confrontano i due
// testi con la forma documentata in testa a ciascuna unit. Le risposte sono
// scritte a mano sul modello della documentazione dei fornitori.
//
// Se un fornitore cambia dialetto, il test da aggiornare e' quello del suo
// fixture: gli altri tre non devono muoversi.

interface

uses
  System.SysUtils,
  System.JSON,
  DUnitX.TestFramework,
  zAI.Tools,
  zAI.Protocol,
  zAI.Protocol.OpenAI,
  zAI.Protocol.Ollama,
  zAI.Protocol.Gemini,
  zAI.Protocol.Claude;

type
  // Esito di ParseResponse raccolto in un oggetto solo, per non ripetere in
  // ogni test le quattro variabili e la loro liberazione
  TEsitoRisposta = class
  public
    Riuscita: Boolean;
    Testo: string;
    Chiamate: TzAIFunctionCalls;
    Turno: TJSONObject;
    Errore: string;
    constructor Create;
    destructor Destroy; override;
  end;

  [TestFixture]
  TTestRegistroProtocolli = class
  public
    [Test]
    procedure ProtocolClassOf_QuattroFornitori;
    [Test]
    procedure ProtocolClassOf_SenzaMaiuscole;
    [Test]
    procedure ProtocolClassOf_Sconosciuto_Nil;
    [Test]
    procedure Endpoint_PerFornitore;
    [Test]
    procedure FunctionCall_ArgomentiNil_OggettoVuoto;
  end;

  [TestFixture]
  TTestProtocolloOpenAI = class
  private
    FProtocollo: TzAIOpenAIProtocol;
    FStrumenti: TzAIToolSet;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure Richiesta_IstruzioniUtenteParametri;
    [Test]
    procedure Richiesta_ParametriAZero_NonTrasmessi;
    [Test]
    procedure Richiesta_Strumenti_SchemaSempre;
    [Test]
    procedure Reset_SvuotaConversazione;
    [Test]
    procedure Risposta_Testo;
    [Test]
    procedure Risposta_ChiamataConArgomentiTesto;
    [Test]
    procedure Risposta_ArgomentiNonJSON_Grezzi;
    [Test]
    procedure Risposta_Errore;
    [Test]
    procedure Risposta_NonJSON;
    [Test]
    procedure Risposta_SenzaScelte;
    [Test]
    procedure Risposta_Vuota_DiceIlMotivo;
    [Test]
    procedure Giro_TurnoERisultatoRispediti;
  end;

  [TestFixture]
  TTestProtocolloOllama = class
  private
    FProtocollo: TzAIOllamaProtocol;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure Richiesta_StreamFalsoEOptions;
    [Test]
    procedure Risposta_ArgomentiOggetto;
    [Test]
    procedure Risposta_ErroreStringa;
    [Test]
    procedure Risultato_ToolNameEIdSoloSePresente;
  end;

  [TestFixture]
  TTestProtocolloGemini = class
  private
    FProtocollo: TzAIGeminiProtocol;
    FStrumenti: TzAIToolSet;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure Richiesta_IstruzioniContenutiStrumenti;
    [Test]
    procedure Richiesta_SenzaParametri_NienteGenerationConfig;
    [Test]
    procedure Risposta_PensieroNonMostrato;
    [Test]
    procedure Risposta_ChiamataDiFunzione;
    [Test]
    procedure Risposta_Bloccata_DiceIlMotivo;
    [Test]
    procedure Risposta_CandidatoSenzaContenuto;
    [Test]
    procedure TurnoSenzaRuolo_DiventaModel;
    [Test]
    procedure Risultati_UnTurnoUser;
  end;

  [TestFixture]
  TTestProtocolloClaude = class
  private
    FProtocollo: TzAIClaudeProtocol;
    FStrumenti: TzAIToolSet;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure Richiesta_MaxTokensObbligatorio;
    [Test]
    procedure Richiesta_InputSchemaAncheSenzaParametri;
    [Test]
    procedure Risposta_TestoEStrumento;
    [Test]
    procedure Risposta_Errore;
    [Test]
    procedure Risposta_ContenutoVuoto;
    [Test]
    procedure Risultati_UnMessaggioEIsError;
  end;

implementation

function Impostazioni(const AModello: string; ATemperatura: Double; AMaxToken: Integer): TzAIGenerationSettings;
begin
  Result := Default(TzAIGenerationSettings);
  Result.Model := AModello;
  Result.Temperature := ATemperatura;
  Result.MaxToken := AMaxToken;
end;

function Richiesta(AProtocollo: TzAIProtocol; AStrumenti: TzAIToolSet; const AImpostazioni: TzAIGenerationSettings): TJSONObject;
begin
  Result := TJSONObject.ParseJSONValue(AProtocollo.BuildRequest(AStrumenti, AImpostazioni)) as TJSONObject;
end;

function Leggi(AProtocollo: TzAIProtocol; const AJson: string): TEsitoRisposta;
begin
  Result := TEsitoRisposta.Create;
  Result.Riuscita := AProtocollo.ParseResponse(AJson, Result.Testo, Result.Chiamate, Result.Turno, Result.Errore);
end;

function UnRisultato(const ANome, AId: string; AValore: TJSONObject): TzAIFunctionResults;
begin
  Result := TzAIFunctionResults.Create;
  Result.Add(TzAIFunctionResult.Create(ANome, AId, AValore));
end;

{ TEsitoRisposta }

constructor TEsitoRisposta.Create;
begin
  inherited Create;
  Chiamate := TzAIFunctionCalls.Create;
end;

destructor TEsitoRisposta.Destroy;
begin
  Turno.Free;
  Chiamate.Free;
  inherited Destroy;
end;

{ TTestRegistroProtocolli }

procedure TTestRegistroProtocolli.ProtocolClassOf_QuattroFornitori;
begin
  // Le unit si registrano da sole nella initialization: basta collegarle
  Assert.IsTrue(ProtocolClassOf('OpenAI') = TzAIOpenAIProtocol, 'OpenAI');
  Assert.IsTrue(ProtocolClassOf('Ollama') = TzAIOllamaProtocol, 'Ollama');
  Assert.IsTrue(ProtocolClassOf('Gemini') = TzAIGeminiProtocol, 'Gemini');
  Assert.IsTrue(ProtocolClassOf('Claude') = TzAIClaudeProtocol, 'Claude');
end;

procedure TTestRegistroProtocolli.ProtocolClassOf_SenzaMaiuscole;
begin
  Assert.IsTrue(ProtocolClassOf('openai') = TzAIOpenAIProtocol);
  Assert.IsTrue(ProtocolClassOf('GEMINI') = TzAIGeminiProtocol);
end;

procedure TTestRegistroProtocolli.ProtocolClassOf_Sconosciuto_Nil;
begin
  // nil = function calling non ancora scritto per quel fornitore
  Assert.IsTrue(ProtocolClassOf('Mistral') = nil);
  Assert.IsTrue(ProtocolClassOf('') = nil);
end;

procedure TTestRegistroProtocolli.Endpoint_PerFornitore;
var
  Protocollo: TzAIProtocol;
begin
  Protocollo := TzAIOpenAIProtocol.Create;
  try
    Assert.AreEqual('/chat/completions', Protocollo.Endpoint);
  finally
    Protocollo.Free;
  end;

  Protocollo := TzAIOllamaProtocol.Create;
  try
    Assert.AreEqual('/chat', Protocollo.Endpoint);
  finally
    Protocollo.Free;
  end;

  Protocollo := TzAIClaudeProtocol.Create;
  try
    Assert.AreEqual('/messages', Protocollo.Endpoint);
  finally
    Protocollo.Free;
  end;

  // Gemini ha il modello nell'indirizzo: endpoint vuoto, decide il driver
  Protocollo := TzAIGeminiProtocol.Create;
  try
    Assert.AreEqual('', Protocollo.Endpoint);
  finally
    Protocollo.Free;
  end;
end;

procedure TTestRegistroProtocolli.FunctionCall_ArgomentiNil_OggettoVuoto;
var
  Chiamata: TzAIFunctionCall;
  Risultato: TzAIFunctionResult;
begin
  Chiamata := TzAIFunctionCall.Create('f', 'id1', nil);
  try
    Assert.IsNotNull(Chiamata.Args);
    Assert.AreEqual(0, Chiamata.Args.Count);
  finally
    Chiamata.Free;
  end;

  Risultato := TzAIFunctionResult.Create('f', 'id1', nil);
  try
    Assert.IsNotNull(Risultato.Value);
  finally
    Risultato.Free;
  end;
end;

{ TTestProtocolloOpenAI }

procedure TTestProtocolloOpenAI.Setup;
begin
  FProtocollo := TzAIOpenAIProtocol.Create;
  FStrumenti := TzAIToolSet.Create;
end;

procedure TTestProtocolloOpenAI.TearDown;
begin
  FStrumenti.Free;
  FProtocollo.Free;
end;

procedure TTestProtocolloOpenAI.Richiesta_IstruzioniUtenteParametri;
var
  Json: TJSONObject;
begin
  FProtocollo.SetSystemInstruction('  Rispondi in italiano.  ');
  FProtocollo.AddUserText('Quanti allievi?');

  Json := Richiesta(FProtocollo, nil, Impostazioni('gpt-4.1', 0.2, 2048));
  try
    Assert.AreEqual('gpt-4.1', Json.GetValue<string>('model'));
    // Le istruzioni vanno nel ruolo di sistema, ripulite dagli spazi
    Assert.AreEqual('system', Json.GetValue<string>('messages[0].role'));
    Assert.AreEqual('Rispondi in italiano.', Json.GetValue<string>('messages[0].content'));
    Assert.AreEqual('user', Json.GetValue<string>('messages[1].role'));
    Assert.AreEqual('Quanti allievi?', Json.GetValue<string>('messages[1].content'));
    // "max_tokens" e non "max_completion_tokens": lo capiscono anche i compatibili
    Assert.AreEqual(2048, Json.GetValue<Integer>('max_tokens'));
    Assert.AreEqual(0.2, Json.GetValue<Double>('temperature'), 0.0001);
    Assert.IsNull(Json.GetValue('tools'));
  finally
    Json.Free;
  end;
end;

procedure TTestProtocolloOpenAI.Richiesta_ParametriAZero_NonTrasmessi;
var
  Json: TJSONObject;
begin
  FProtocollo.AddUserText('ciao');
  Json := Richiesta(FProtocollo, nil, Impostazioni('gpt-4.1', 0, 0));
  try
    Assert.IsNull(Json.GetValue('temperature'));
    Assert.IsNull(Json.GetValue('max_tokens'));
    // Senza istruzioni niente messaggio di sistema
    Assert.AreEqual(1, (Json.GetValue('messages') as TJSONArray).Count);
  finally
    Json.Free;
  end;
end;

procedure TTestProtocolloOpenAI.Richiesta_Strumenti_SchemaSempre;
var
  Json: TJSONObject;
begin
  FStrumenti.Add('elenca_corsi', 'Elenca i corsi', nil);
  FProtocollo.AddUserText('ciao');

  Json := Richiesta(FProtocollo, FStrumenti, Impostazioni('gpt-4.1', 0, 0));
  try
    Assert.AreEqual('function', Json.GetValue<string>('tools[0].type'));
    Assert.AreEqual('elenca_corsi', Json.GetValue<string>('tools[0].function.name'));
    // Schema vuoto anche senza parametri: alcuni servizi compatibili lo pretendono
    Assert.IsNotNull(Json.FindValue('tools[0].function.parameters'));
  finally
    Json.Free;
  end;
end;

procedure TTestProtocolloOpenAI.Reset_SvuotaConversazione;
var
  Json: TJSONObject;
begin
  FProtocollo.SetSystemInstruction('regole');
  FProtocollo.AddUserText('prima domanda');
  FProtocollo.Reset;
  FProtocollo.AddUserText('seconda domanda');

  Json := Richiesta(FProtocollo, nil, Impostazioni('m', 0, 0));
  try
    Assert.AreEqual(1, (Json.GetValue('messages') as TJSONArray).Count);
    Assert.AreEqual('seconda domanda', Json.GetValue<string>('messages[0].content'));
  finally
    Json.Free;
  end;
end;

procedure TTestProtocolloOpenAI.Risposta_Testo;
var
  Esito: TEsitoRisposta;
begin
  Esito := Leggi(FProtocollo,
    '{"choices":[{"finish_reason":"stop","message":{"role":"assistant","content":"Sono 12.",' +
    '"refusal":null,"annotations":[]}}]}');
  try
    Assert.IsTrue(Esito.Riuscita, Esito.Errore);
    Assert.AreEqual('Sono 12.', Esito.Testo);
    Assert.AreEqual(0, Esito.Chiamate.Count);
    // Il turno si riaccoda coi soli role, content e tool_calls
    Assert.IsNotNull(Esito.Turno);
    Assert.AreEqual('assistant', Esito.Turno.GetValue<string>('role'));
    Assert.IsNull(Esito.Turno.GetValue('refusal'));
    Assert.IsNull(Esito.Turno.GetValue('annotations'));
  finally
    Esito.Free;
  end;
end;

procedure TTestProtocolloOpenAI.Risposta_ChiamataConArgomentiTesto;
var
  Esito: TEsitoRisposta;
begin
  // Gli argomenti arrivano come TESTO JSON dentro una stringa
  Esito := Leggi(FProtocollo,
    '{"choices":[{"finish_reason":"tool_calls","message":{"role":"assistant","content":null,' +
    '"tool_calls":[{"id":"call_1","type":"function","function":{"name":"cerca_corsi",' +
    '"arguments":"{\"testo\":\"saldatura\",\"anno\":2026}"}}]}}]}');
  try
    Assert.IsTrue(Esito.Riuscita, Esito.Errore);
    Assert.AreEqual('', Esito.Testo);
    Assert.AreEqual(1, Esito.Chiamate.Count);
    Assert.AreEqual('cerca_corsi', Esito.Chiamate[0].Name);
    Assert.AreEqual('call_1', Esito.Chiamate[0].Id);
    Assert.AreEqual('saldatura', Esito.Chiamate[0].Args.GetValue<string>('testo'));
    Assert.AreEqual(2026, Esito.Chiamate[0].Args.GetValue<Integer>('anno'));
    // Con le sole chiamate il testo si rispedisce null, non stringa vuota
    Assert.IsTrue(Esito.Turno.GetValue('content') is TJSONNull);
    Assert.IsTrue(Esito.Turno.GetValue('tool_calls') is TJSONArray);
  finally
    Esito.Free;
  end;
end;

procedure TTestProtocolloOpenAI.Risposta_ArgomentiNonJSON_Grezzi;
var
  Esito: TEsitoRisposta;
begin
  Esito := Leggi(FProtocollo,
    '{"choices":[{"message":{"role":"assistant","content":null,' +
    '"tool_calls":[{"id":"c","function":{"name":"f","arguments":"non e'' json"}}]}}]}');
  try
    Assert.IsTrue(Esito.Riuscita, Esito.Errore);
    Assert.AreEqual('non e'' json', Esito.Chiamate[0].Args.GetValue<string>('raw'));
  finally
    Esito.Free;
  end;
end;

procedure TTestProtocolloOpenAI.Risposta_Errore;
var
  Esito: TEsitoRisposta;
begin
  Esito := Leggi(FProtocollo, '{"error":{"message":"Incorrect API key provided","type":"invalid_request_error"}}');
  try
    Assert.IsFalse(Esito.Riuscita);
    Assert.AreEqual('Incorrect API key provided', Esito.Errore);
    Assert.IsNull(Esito.Turno);
  finally
    Esito.Free;
  end;
end;

procedure TTestProtocolloOpenAI.Risposta_NonJSON;
var
  Esito: TEsitoRisposta;
begin
  Esito := Leggi(FProtocollo, '<html>502 Bad Gateway</html>');
  try
    Assert.IsFalse(Esito.Riuscita);
    Assert.IsTrue(Esito.Errore <> '');
  finally
    Esito.Free;
  end;
end;

procedure TTestProtocolloOpenAI.Risposta_SenzaScelte;
var
  Esito: TEsitoRisposta;
begin
  Esito := Leggi(FProtocollo, '{"choices":[]}');
  try
    Assert.IsFalse(Esito.Riuscita);
    Assert.IsTrue(Esito.Errore <> '');
  finally
    Esito.Free;
  end;
end;

procedure TTestProtocolloOpenAI.Risposta_Vuota_DiceIlMotivo;
var
  Esito: TEsitoRisposta;
begin
  Esito := Leggi(FProtocollo, '{"choices":[{"finish_reason":"length","message":{"role":"assistant","content":""}}]}');
  try
    Assert.IsFalse(Esito.Riuscita);
    Assert.Contains(Esito.Errore, 'length');
    Assert.IsNull(Esito.Turno);
  finally
    Esito.Free;
  end;
end;

procedure TTestProtocolloOpenAI.Giro_TurnoERisultatoRispediti;
var
  Esito: TEsitoRisposta;
  Risultati: TzAIFunctionResults;
  Json: TJSONObject;
begin
  FProtocollo.AddUserText('Cerca i corsi di saldatura');
  Esito := Leggi(FProtocollo,
    '{"choices":[{"message":{"role":"assistant","content":null,' +
    '"tool_calls":[{"id":"call_7","type":"function","function":{"name":"cerca","arguments":"{}"}}]}}]}');
  try
    FProtocollo.AddModelTurn(Esito.Turno);
  finally
    Esito.Free;
  end;

  Risultati := UnRisultato('cerca', 'call_7', TzAITool.Risultato('3 corsi'));
  try
    FProtocollo.AddFunctionResults(Risultati);
  finally
    Risultati.Free;
  end;

  Json := Richiesta(FProtocollo, nil, Impostazioni('m', 0, 0));
  try
    Assert.AreEqual(3, (Json.GetValue('messages') as TJSONArray).Count);
    Assert.AreEqual('assistant', Json.GetValue<string>('messages[1].role'));
    Assert.AreEqual('call_7', Json.GetValue<string>('messages[1].tool_calls[0].id'));
    // Un messaggio "tool" per risultato, con l'identificativo della chiamata
    Assert.AreEqual('tool', Json.GetValue<string>('messages[2].role'));
    Assert.AreEqual('call_7', Json.GetValue<string>('messages[2].tool_call_id'));
    // Il contenuto e' il JSON del risultato reso testo
    Assert.AreEqual('{"risultato":"3 corsi"}', Json.GetValue<string>('messages[2].content'));
  finally
    Json.Free;
  end;
end;

{ TTestProtocolloOllama }

procedure TTestProtocolloOllama.Setup;
begin
  FProtocollo := TzAIOllamaProtocol.Create;
end;

procedure TTestProtocolloOllama.TearDown;
begin
  FProtocollo.Free;
end;

procedure TTestProtocolloOllama.Richiesta_StreamFalsoEOptions;
var
  Json: TJSONObject;
begin
  FProtocollo.SetSystemInstruction('regole');
  FProtocollo.AddUserText('ciao');

  Json := Richiesta(FProtocollo, nil, Impostazioni('granite4.1:8b', 0.3, 512));
  try
    Assert.AreEqual('granite4.1:8b', Json.GetValue<string>('model'));
    // Senza stream=false la risposta arriva a pezzi, una riga per parola
    Assert.IsNotNull(Json.GetValue('stream'));
    Assert.IsFalse(Json.GetValue<Boolean>('stream'));
    Assert.AreEqual(0.3, Json.GetValue<Double>('options.temperature'), 0.0001);
    Assert.AreEqual(512, Json.GetValue<Integer>('options.num_predict'));
    Assert.IsNull(Json.GetValue('max_tokens'));
    Assert.IsNull(Json.GetValue('temperature'));
    Assert.AreEqual('system', Json.GetValue<string>('messages[0].role'));
  finally
    Json.Free;
  end;
end;

procedure TTestProtocolloOllama.Risposta_ArgomentiOggetto;
var
  Esito: TEsitoRisposta;
begin
  // Qui gli argomenti arrivano gia' come oggetto, e il turno sta in "message"
  Esito := Leggi(FProtocollo,
    '{"model":"granite4.1:8b","message":{"role":"assistant","content":"","thinking":"...",' +
    '"tool_calls":[{"function":{"name":"cerca","arguments":{"testo":"abc"}}}]},' +
    '"done_reason":"stop","done":true}');
  try
    Assert.IsTrue(Esito.Riuscita, Esito.Errore);
    Assert.AreEqual(1, Esito.Chiamate.Count);
    Assert.AreEqual('cerca', Esito.Chiamate[0].Name);
    Assert.AreEqual('', Esito.Chiamate[0].Id);
    Assert.AreEqual('abc', Esito.Chiamate[0].Args.GetValue<string>('testo'));
    // Il ragionamento non va rispedito
    Assert.IsNull(Esito.Turno.GetValue('thinking'));
  finally
    Esito.Free;
  end;
end;

procedure TTestProtocolloOllama.Risposta_ErroreStringa;
var
  Esito: TEsitoRisposta;
begin
  Esito := Leggi(FProtocollo, '{"error":"registry.ollama.ai/library/gemma does not support tools"}');
  try
    Assert.IsFalse(Esito.Riuscita);
    Assert.Contains(Esito.Errore, 'does not support tools');
  finally
    Esito.Free;
  end;
end;

procedure TTestProtocolloOllama.Risultato_ToolNameEIdSoloSePresente;
var
  Risultati: TzAIFunctionResults;
  Json: TJSONObject;
begin
  FProtocollo.AddUserText('ciao');
  Risultati := UnRisultato('cerca', '', TzAITool.Risultato('ok'));
  try
    FProtocollo.AddFunctionResults(Risultati);
  finally
    Risultati.Free;
  end;

  Json := Richiesta(FProtocollo, nil, Impostazioni('m', 0, 0));
  try
    Assert.AreEqual('tool', Json.GetValue<string>('messages[1].role'));
    Assert.AreEqual('cerca', Json.GetValue<string>('messages[1].tool_name'));
    Assert.IsNull(Json.FindValue('messages[1].tool_call_id'));
  finally
    Json.Free;
  end;
end;

{ TTestProtocolloGemini }

procedure TTestProtocolloGemini.Setup;
begin
  FProtocollo := TzAIGeminiProtocol.Create;
  FStrumenti := TzAIToolSet.Create;
end;

procedure TTestProtocolloGemini.TearDown;
begin
  FStrumenti.Free;
  FProtocollo.Free;
end;

procedure TTestProtocolloGemini.Richiesta_IstruzioniContenutiStrumenti;
var
  Json: TJSONObject;
begin
  FStrumenti.Add('elenca_corsi', 'Elenca i corsi', nil);
  FStrumenti.Add('cerca_allievo', 'Cerca un allievo', nil).AddParameter('cognome', ptString, 'Cognome');
  FProtocollo.SetSystemInstruction('Rispondi in italiano.');
  FProtocollo.AddUserText('Quanti allievi?');

  Json := Richiesta(FProtocollo, FStrumenti, Impostazioni('gemini-2.5-flash', 0.2, 1024));
  try
    // Il modello sta nell'indirizzo, non nel corpo
    Assert.IsNull(Json.GetValue('model'));
    Assert.AreEqual('Rispondi in italiano.', Json.GetValue<string>('systemInstruction.parts[0].text'));
    Assert.AreEqual('user', Json.GetValue<string>('contents[0].role'));
    Assert.AreEqual('Quanti allievi?', Json.GetValue<string>('contents[0].parts[0].text'));
    Assert.AreEqual('elenca_corsi', Json.GetValue<string>('tools[0].functionDeclarations[0].name'));
    // Gemini rifiuta lo schema vuoto: lo strumento senza parametri non lo ha
    Assert.IsNull(Json.FindValue('tools[0].functionDeclarations[0].parameters'));
    Assert.IsNotNull(Json.FindValue('tools[0].functionDeclarations[1].parameters'));
    Assert.AreEqual(1024, Json.GetValue<Integer>('generationConfig.maxOutputTokens'));
    Assert.AreEqual(0.2, Json.GetValue<Double>('generationConfig.temperature'), 0.0001);
  finally
    Json.Free;
  end;
end;

procedure TTestProtocolloGemini.Richiesta_SenzaParametri_NienteGenerationConfig;
var
  Json: TJSONObject;
begin
  FProtocollo.AddUserText('ciao');
  Json := Richiesta(FProtocollo, nil, Impostazioni('', 0, 0));
  try
    Assert.IsNull(Json.GetValue('generationConfig'));
    Assert.IsNull(Json.GetValue('systemInstruction'));
    Assert.IsNull(Json.GetValue('tools'));
  finally
    Json.Free;
  end;
end;

procedure TTestProtocolloGemini.Risposta_PensieroNonMostrato;
var
  Esito: TEsitoRisposta;
begin
  Esito := Leggi(FProtocollo,
    '{"candidates":[{"content":{"role":"model","parts":[' +
    '{"text":"Devo contare gli allievi.","thought":true},{"text":"Sono 12."}]},"finishReason":"STOP"}]}');
  try
    Assert.IsTrue(Esito.Riuscita, Esito.Errore);
    Assert.AreEqual('Sono 12.', Esito.Testo);
    // Il pensiero resta nel turno da riaccodare
    Assert.AreEqual(2, (Esito.Turno.GetValue('parts') as TJSONArray).Count);
  finally
    Esito.Free;
  end;
end;

procedure TTestProtocolloGemini.Risposta_ChiamataDiFunzione;
var
  Esito: TEsitoRisposta;
begin
  Esito := Leggi(FProtocollo,
    '{"candidates":[{"content":{"role":"model","parts":[' +
    '{"functionCall":{"name":"cerca_allievo","args":{"cognome":"Rossi"}},"thoughtSignature":"abc"}]}}]}');
  try
    Assert.IsTrue(Esito.Riuscita, Esito.Errore);
    Assert.AreEqual('', Esito.Testo);
    Assert.AreEqual(1, Esito.Chiamate.Count);
    Assert.AreEqual('cerca_allievo', Esito.Chiamate[0].Name);
    Assert.AreEqual('Rossi', Esito.Chiamate[0].Args.GetValue<string>('cognome'));
    // La firma del pensiero va rispedita tale e quale, o il turno dopo e' rifiutato
    Assert.AreEqual('abc', Esito.Turno.GetValue<string>('parts[0].thoughtSignature'));
  finally
    Esito.Free;
  end;
end;

procedure TTestProtocolloGemini.Risposta_Bloccata_DiceIlMotivo;
var
  Esito: TEsitoRisposta;
begin
  Esito := Leggi(FProtocollo, '{"promptFeedback":{"blockReason":"SAFETY"}}');
  try
    Assert.IsFalse(Esito.Riuscita);
    Assert.Contains(Esito.Errore, 'SAFETY');
  finally
    Esito.Free;
  end;
end;

procedure TTestProtocolloGemini.Risposta_CandidatoSenzaContenuto;
var
  Esito: TEsitoRisposta;
begin
  Esito := Leggi(FProtocollo, '{"candidates":[{"finishReason":"RECITATION"}]}');
  try
    Assert.IsFalse(Esito.Riuscita);
    Assert.Contains(Esito.Errore, 'RECITATION');
    Assert.IsNull(Esito.Turno);
  finally
    Esito.Free;
  end;
end;

procedure TTestProtocolloGemini.TurnoSenzaRuolo_DiventaModel;
var
  Turno: TJSONObject;
  Json: TJSONObject;
begin
  Turno := TJSONObject.ParseJSONValue('{"parts":[{"text":"ok"}]}') as TJSONObject;
  try
    FProtocollo.AddModelTurn(Turno);
    // Il turno viene clonato: resta del chiamante
    Assert.IsNull(Turno.GetValue('role'));
  finally
    Turno.Free;
  end;

  Json := Richiesta(FProtocollo, nil, Impostazioni('', 0, 0));
  try
    Assert.AreEqual('model', Json.GetValue<string>('contents[0].role'));
  finally
    Json.Free;
  end;
end;

procedure TTestProtocolloGemini.Risultati_UnTurnoUser;
var
  Risultati: TzAIFunctionResults;
  Json: TJSONObject;
begin
  Risultati := TzAIFunctionResults.Create;
  try
    Risultati.Add(TzAIFunctionResult.Create('a', '', TzAITool.Risultato('uno')));
    Risultati.Add(TzAIFunctionResult.Create('b', 'id-b', TzAITool.Risultato('due')));
    FProtocollo.AddFunctionResults(Risultati);
  finally
    Risultati.Free;
  end;

  Json := Richiesta(FProtocollo, nil, Impostazioni('', 0, 0));
  try
    Assert.AreEqual(1, (Json.GetValue('contents') as TJSONArray).Count);
    Assert.AreEqual('user', Json.GetValue<string>('contents[0].role'));
    Assert.AreEqual('a', Json.GetValue<string>('contents[0].parts[0].functionResponse.name'));
    Assert.IsNull(Json.FindValue('contents[0].parts[0].functionResponse.id'));
    Assert.AreEqual('id-b', Json.GetValue<string>('contents[0].parts[1].functionResponse.id'));
    // "response" e' un oggetto, non testo
    Assert.AreEqual('due', Json.GetValue<string>('contents[0].parts[1].functionResponse.response.risultato'));
  finally
    Json.Free;
  end;
end;

{ TTestProtocolloClaude }

procedure TTestProtocolloClaude.Setup;
begin
  FProtocollo := TzAIClaudeProtocol.Create;
  FStrumenti := TzAIToolSet.Create;
end;

procedure TTestProtocolloClaude.TearDown;
begin
  FStrumenti.Free;
  FProtocollo.Free;
end;

procedure TTestProtocolloClaude.Richiesta_MaxTokensObbligatorio;
var
  Json: TJSONObject;
begin
  FProtocollo.SetSystemInstruction('Rispondi in italiano.');
  FProtocollo.AddUserText('ciao');

  Json := Richiesta(FProtocollo, nil, Impostazioni('claude-sonnet-4-5', 0, 0));
  try
    // Il servizio esige max_tokens: senza configurazione si manda 4096
    Assert.AreEqual(4096, Json.GetValue<Integer>('max_tokens'));
    Assert.AreEqual('Rispondi in italiano.', Json.GetValue<string>('system'));
    Assert.AreEqual('user', Json.GetValue<string>('messages[0].role'));
    Assert.IsNull(Json.GetValue('temperature'));
  finally
    Json.Free;
  end;

  Json := Richiesta(FProtocollo, nil, Impostazioni('claude-sonnet-4-5', 0.5, 800));
  try
    Assert.AreEqual(800, Json.GetValue<Integer>('max_tokens'));
    Assert.AreEqual(0.5, Json.GetValue<Double>('temperature'), 0.0001);
  finally
    Json.Free;
  end;
end;

procedure TTestProtocolloClaude.Richiesta_InputSchemaAncheSenzaParametri;
var
  Json: TJSONObject;
begin
  FStrumenti.Add('elenca_corsi', 'Elenca i corsi', nil);
  FProtocollo.AddUserText('ciao');

  Json := Richiesta(FProtocollo, FStrumenti, Impostazioni('m', 0, 0));
  try
    Assert.AreEqual('elenca_corsi', Json.GetValue<string>('tools[0].name'));
    Assert.AreEqual('Elenca i corsi', Json.GetValue<string>('tools[0].description'));
    Assert.AreEqual('object', Json.GetValue<string>('tools[0].input_schema.type'));
    // La chiave neutra "parameters" non deve restare nella dichiarazione
    Assert.IsNull(Json.FindValue('tools[0].parameters'));
  finally
    Json.Free;
  end;
end;

procedure TTestProtocolloClaude.Risposta_TestoEStrumento;
var
  Esito: TEsitoRisposta;
begin
  Esito := Leggi(FProtocollo,
    '{"id":"msg_1","type":"message","role":"assistant","stop_reason":"tool_use","content":[' +
    '{"type":"thinking","thinking":"...","signature":"firma"},' +
    '{"type":"text","text":"Controllo."},' +
    '{"type":"tool_use","id":"toolu_1","name":"cerca","input":{"testo":"abc"}}]}');
  try
    Assert.IsTrue(Esito.Riuscita, Esito.Errore);
    Assert.AreEqual('Controllo.', Esito.Testo);
    Assert.AreEqual(1, Esito.Chiamate.Count);
    Assert.AreEqual('toolu_1', Esito.Chiamate[0].Id);
    Assert.AreEqual('abc', Esito.Chiamate[0].Args.GetValue<string>('testo'));
    // Il turno conserva il content intero, blocco "thinking" con la firma compreso
    Assert.AreEqual('assistant', Esito.Turno.GetValue<string>('role'));
    Assert.AreEqual(3, (Esito.Turno.GetValue('content') as TJSONArray).Count);
    Assert.AreEqual('firma', Esito.Turno.GetValue<string>('content[0].signature'));
  finally
    Esito.Free;
  end;
end;

procedure TTestProtocolloClaude.Risposta_Errore;
var
  Esito: TEsitoRisposta;
begin
  Esito := Leggi(FProtocollo, '{"type":"error","error":{"type":"overloaded_error","message":"Overloaded"}}');
  try
    Assert.IsFalse(Esito.Riuscita);
    Assert.AreEqual('Overloaded', Esito.Errore);
  finally
    Esito.Free;
  end;
end;

procedure TTestProtocolloClaude.Risposta_ContenutoVuoto;
var
  Esito: TEsitoRisposta;
begin
  Esito := Leggi(FProtocollo, '{"type":"message","role":"assistant","stop_reason":"refusal","content":[]}');
  try
    Assert.IsFalse(Esito.Riuscita);
    Assert.Contains(Esito.Errore, 'refusal');
  finally
    Esito.Free;
  end;
end;

procedure TTestProtocolloClaude.Risultati_UnMessaggioEIsError;
var
  Risultati: TzAIFunctionResults;
  Json: TJSONObject;
begin
  FProtocollo.AddUserText('ciao');
  Risultati := TzAIFunctionResults.Create;
  try
    Risultati.Add(TzAIFunctionResult.Create('a', 'toolu_1', TzAITool.Risultato('uno')));
    Risultati.Add(TzAIFunctionResult.Create('b', 'toolu_2', TzAITool.Errore('archivio chiuso')));
    FProtocollo.AddFunctionResults(Risultati);
  finally
    Risultati.Free;
  end;

  Json := Richiesta(FProtocollo, nil, Impostazioni('m', 0, 0));
  try
    // Ogni tool_use deve trovare il suo tool_result nel messaggio successivo
    Assert.AreEqual(2, (Json.GetValue('messages') as TJSONArray).Count);
    Assert.AreEqual('user', Json.GetValue<string>('messages[1].role'));
    Assert.AreEqual('tool_result', Json.GetValue<string>('messages[1].content[0].type'));
    Assert.AreEqual('toolu_1', Json.GetValue<string>('messages[1].content[0].tool_use_id'));
    Assert.IsNull(Json.FindValue('messages[1].content[0].is_error'));
    // Il risultato marcato con la chiave "errore" diventa is_error
    Assert.IsTrue(Json.GetValue<Boolean>('messages[1].content[1].is_error'));
  finally
    Json.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestRegistroProtocolli);
  TDUnitX.RegisterTestFixture(TTestProtocolloOpenAI);
  TDUnitX.RegisterTestFixture(TTestProtocolloOllama);
  TDUnitX.RegisterTestFixture(TTestProtocolloGemini);
  TDUnitX.RegisterTestFixture(TTestProtocolloClaude);

end.
