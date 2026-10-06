// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-03
// ---------------------------------------------------------------------------

unit Test.zAI.Configuration;

// Test di BASE\AI\zAI.Configuration: valori predefiniti, condizione minima per
// avviare una richiesta, notifiche di modifica (il motore vi si aggancia per
// riallinearsi) e andata e ritorno dal file .ini. I file di prova stanno nella
// cartella temporanea e si cancellano a fine test.

interface

uses
  System.SysUtils,
  System.Classes,
  System.IOUtils,
  DUnitX.TestFramework,
  zAI.Configuration;

type
  [TestFixture]
  TTestConfigurazioneAI = class
  private
    FConfigurazione: TzAIConfiguration;
    FNotifiche: Integer;
    FFileIni: string;
    procedure Notifica(Sender: TObject);
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure Predefiniti;
    [Test]
    procedure IsConfigured_SenzaChiave_Falso;
    [Test]
    procedure IsConfigured_ConChiave_Vero;
    [Test]
    procedure IsConfigured_Ollama_SenzaChiave_Vero;
    [Test]
    procedure IsConfigured_SenzaFornitore_Falso;
    [Test]
    procedure SuggestedModels_PerFornitore;
    [Test]
    procedure SuggestedModels_Sconosciuto_Vuoto;
    [Test]
    procedure OnChange_SoloSeIlValoreCambia;
    [Test]
    procedure OnChange_ModificaDeiModelli;
    [Test]
    procedure Assign_CopiaTuttoENotificaUnaVolta;
    [Test]
    procedure RestoreDefaults_RiportaAiPredefiniti;
    [Test]
    procedure Ini_AndataERitorno;
    [Test]
    procedure Ini_IstruzioniSuPiuRighe;
    [Test]
    procedure Ini_FileMancante_CreatoCoiValoriAttuali;
    // R-037: TIniFile.ReadString legge al massimo 2047 caratteri
    // (System.IniFiles, buffer fisso): istruzioni di sistema piu' lunghe
    // tornano troncate senza nessun avviso
    [Test]
    [Ignore('R-037: TIniFile tronca le istruzioni di sistema oltre 2047 caratteri')]
    procedure Ini_IstruzioniLunghe_Intere;
  end;

implementation

{ TTestConfigurazioneAI }

procedure TTestConfigurazioneAI.Setup;
begin
  FConfigurazione := TzAIConfiguration.Create;
  FNotifiche := 0;
  FFileIni := TPath.Combine(TPath.GetTempPath, 'GestyTests_zAI_' + TGUID.NewGuid.ToString + '.ini');
end;

procedure TTestConfigurazioneAI.TearDown;
begin
  FConfigurazione.Free;

  if TFile.Exists(FFileIni) then
    TFile.Delete(FFileIni);
end;

procedure TTestConfigurazioneAI.Notifica(Sender: TObject);
begin
  Inc(FNotifiche);
end;

procedure TTestConfigurazioneAI.Predefiniti;
begin
  Assert.AreEqual(DriverGemini, FConfigurazione.DriverName);
  Assert.AreEqual('', FConfigurazione.APIKey);
  Assert.AreEqual('', FConfigurazione.Model);
  Assert.AreEqual(DefaultAssistantName, FConfigurazione.AssistantName);
  Assert.AreEqual(DefaultHistoryDepth, FConfigurazione.HistoryDepth);
  Assert.AreEqual(0.0, FConfigurazione.Temperature, 0.0001);
  Assert.AreEqual(0, FConfigurazione.MaxToken);
  Assert.AreEqual(0, FConfigurazione.Models.Count);
  Assert.IsTrue(FConfigurazione.RegisterDevExpressChatClient);
  // Il presidio AI Act deve esserci sempre di partenza
  Assert.Contains(FConfigurazione.SystemInstruction, 'AI Act');
end;

procedure TTestConfigurazioneAI.IsConfigured_SenzaChiave_Falso;
begin
  Assert.IsFalse(FConfigurazione.IsConfigured);
  FConfigurazione.APIKey := '   ';
  Assert.IsFalse(FConfigurazione.IsConfigured);
end;

procedure TTestConfigurazioneAI.IsConfigured_ConChiave_Vero;
begin
  FConfigurazione.APIKey := 'chiave';
  Assert.IsTrue(FConfigurazione.IsConfigured);
end;

procedure TTestConfigurazioneAI.IsConfigured_Ollama_SenzaChiave_Vero;
begin
  // Ollama gira in locale e non usa la chiave
  FConfigurazione.DriverName := 'ollama';
  Assert.IsTrue(FConfigurazione.IsConfigured);
end;

procedure TTestConfigurazioneAI.IsConfigured_SenzaFornitore_Falso;
begin
  FConfigurazione.DriverName := ' ';
  FConfigurazione.APIKey := 'chiave';
  Assert.IsFalse(FConfigurazione.IsConfigured);
end;

procedure TTestConfigurazioneAI.SuggestedModels_PerFornitore;
var
  Modelli: TArray<string>;
begin
  Modelli := TzAIConfiguration.SuggestedModels(DriverGemini);
  Assert.IsTrue(Length(Modelli) > 0, DriverGemini);
  Assert.AreEqual('gemini-2.5-flash', Modelli[0]);

  Assert.IsTrue(Length(TzAIConfiguration.SuggestedModels('openai')) > 0, 'openai');
  Assert.IsTrue(Length(TzAIConfiguration.SuggestedModels(DriverClaude)) > 0, DriverClaude);
  Assert.IsTrue(Length(TzAIConfiguration.SuggestedModels(DriverOllama)) > 0, DriverOllama);
end;

procedure TTestConfigurazioneAI.SuggestedModels_Sconosciuto_Vuoto;
begin
  Assert.AreEqual(0, Length(TzAIConfiguration.SuggestedModels('Mistral')));
end;

procedure TTestConfigurazioneAI.OnChange_SoloSeIlValoreCambia;
begin
  FConfigurazione.OnChange := Notifica;

  FConfigurazione.Model := 'gemini-2.5-pro';
  Assert.AreEqual(1, FNotifiche);

  // Stesso valore: il motore non deve riallinearsi per niente
  FConfigurazione.Model := 'gemini-2.5-pro';
  Assert.AreEqual(1, FNotifiche);

  FConfigurazione.Temperature := 0.4;
  FConfigurazione.HistoryDepth := 5;
  Assert.AreEqual(3, FNotifiche);
end;

procedure TTestConfigurazioneAI.OnChange_ModificaDeiModelli;
begin
  FConfigurazione.OnChange := Notifica;
  FConfigurazione.Models.Add('gemini-2.5-flash');
  Assert.IsTrue(FNotifiche > 0);
end;

procedure TTestConfigurazioneAI.Assign_CopiaTuttoENotificaUnaVolta;
var
  Origine: TzAIConfiguration;
begin
  Origine := TzAIConfiguration.Create;
  try
    Origine.DriverName := DriverClaude;
    Origine.APIKey := 'chiave';
    Origine.Model := 'claude-sonnet-4-latest';
    Origine.BaseURL := 'https://inoltro.ente.it';
    Origine.Temperature := 0.3;
    Origine.MaxToken := 900;
    Origine.Timeout := 30;
    Origine.HistoryDepth := 4;
    Origine.RegisterDevExpressChatClient := False;
    Origine.Models.Add('uno');

    FConfigurazione.OnChange := Notifica;
    FConfigurazione.Assign(Origine);

    Assert.AreEqual(1, FNotifiche);
    Assert.AreEqual(DriverClaude, FConfigurazione.DriverName);
    Assert.AreEqual('chiave', FConfigurazione.APIKey);
    Assert.AreEqual('claude-sonnet-4-latest', FConfigurazione.Model);
    Assert.AreEqual('https://inoltro.ente.it', FConfigurazione.BaseURL);
    Assert.AreEqual(0.3, FConfigurazione.Temperature, 0.0001);
    Assert.AreEqual(900, FConfigurazione.MaxToken);
    Assert.AreEqual(30, FConfigurazione.Timeout);
    Assert.AreEqual(4, FConfigurazione.HistoryDepth);
    Assert.IsFalse(FConfigurazione.RegisterDevExpressChatClient);

    // I modelli sono una copia: cambiare l'origine non tocca la destinazione
    Origine.Models.Add('due');
    Assert.AreEqual(1, FConfigurazione.Models.Count);
  finally
    Origine.Free;
  end;
end;

procedure TTestConfigurazioneAI.RestoreDefaults_RiportaAiPredefiniti;
begin
  FConfigurazione.DriverName := DriverOpenAI;
  FConfigurazione.APIKey := 'chiave';
  FConfigurazione.Models.Add('gpt-5');
  FConfigurazione.RestoreDefaults;

  Assert.AreEqual(DriverGemini, FConfigurazione.DriverName);
  Assert.AreEqual('', FConfigurazione.APIKey);
  Assert.AreEqual(0, FConfigurazione.Models.Count);
end;

procedure TTestConfigurazioneAI.Ini_AndataERitorno;
var
  Riletta: TzAIConfiguration;
begin
  FConfigurazione.DriverName := DriverOpenAI;
  FConfigurazione.APIKey := 'sk-prova';
  FConfigurazione.Model := 'gpt-4.1';
  FConfigurazione.BaseURL := 'http://localhost:1234/v1';
  FConfigurazione.AssistantName := 'Aiuto';
  FConfigurazione.WelcomeMessage := 'Buongiorno';
  FConfigurazione.Temperature := 0.7;
  FConfigurazione.MaxToken := 1500;
  FConfigurazione.Timeout := 45;
  FConfigurazione.HistoryDepth := 0;
  FConfigurazione.RegisterDevExpressChatClient := False;
  FConfigurazione.Models.Add('gpt-4.1');
  FConfigurazione.Models.Add('gpt-4o-mini');
  FConfigurazione.SaveToIniFile(FFileIni);

  Riletta := TzAIConfiguration.Create;
  try
    Riletta.LoadFromIniFile(FFileIni);

    Assert.AreEqual(DriverOpenAI, Riletta.DriverName);
    Assert.AreEqual('sk-prova', Riletta.APIKey);
    Assert.AreEqual('gpt-4.1', Riletta.Model);
    Assert.AreEqual('http://localhost:1234/v1', Riletta.BaseURL);
    Assert.AreEqual('Aiuto', Riletta.AssistantName);
    Assert.AreEqual('Buongiorno', Riletta.WelcomeMessage);
    // La temperatura si scrive col punto, qualunque sia la lingua di Windows
    Assert.AreEqual(0.7, Riletta.Temperature, 0.0001);
    Assert.AreEqual(1500, Riletta.MaxToken);
    Assert.AreEqual(45, Riletta.Timeout);
    Assert.AreEqual(0, Riletta.HistoryDepth);
    Assert.IsFalse(Riletta.RegisterDevExpressChatClient);
    Assert.AreEqual(2, Riletta.Models.Count);
    Assert.AreEqual('gpt-4o-mini', Riletta.Models[1]);
  finally
    Riletta.Free;
  end;
end;

procedure TTestConfigurazioneAI.Ini_IstruzioniSuPiuRighe;
var
  Riletta: TzAIConfiguration;
  Istruzioni: string;
begin
  // Nel file stanno su una riga sola con \n al posto degli a capo
  Istruzioni := 'Prima riga.' + sLineBreak + 'Seconda riga.' + sLineBreak + 'Terza riga.';
  FConfigurazione.SystemInstruction := Istruzioni;
  FConfigurazione.SaveToIniFile(FFileIni);

  Riletta := TzAIConfiguration.Create;
  try
    Riletta.LoadFromIniFile(FFileIni);
    Assert.AreEqual(Istruzioni, Riletta.SystemInstruction);
  finally
    Riletta.Free;
  end;
end;

procedure TTestConfigurazioneAI.Ini_FileMancante_CreatoCoiValoriAttuali;
var
  Riletta: TzAIConfiguration;
begin
  FConfigurazione.DriverName := DriverOllama;
  Assert.IsFalse(TFile.Exists(FFileIni));

  // Un file che manca si crea con la configurazione corrente, che resta intatta
  FConfigurazione.LoadFromIniFile(FFileIni);
  Assert.IsTrue(TFile.Exists(FFileIni));
  Assert.AreEqual(DriverOllama, FConfigurazione.DriverName);

  Riletta := TzAIConfiguration.Create;
  try
    Riletta.LoadFromIniFile(FFileIni);
    Assert.AreEqual(DriverOllama, Riletta.DriverName);
  finally
    Riletta.Free;
  end;
end;

procedure TTestConfigurazioneAI.Ini_IstruzioniLunghe_Intere;
var
  Riletta: TzAIConfiguration;
  Istruzioni: string;
begin
  Istruzioni := StringOfChar('a', 3000) + ' fine';
  FConfigurazione.SystemInstruction := Istruzioni;
  FConfigurazione.SaveToIniFile(FFileIni);

  Riletta := TzAIConfiguration.Create;
  try
    Riletta.LoadFromIniFile(FFileIni);
    Assert.AreEqual(Length(Istruzioni), Length(Riletta.SystemInstruction));
  finally
    Riletta.Free;
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestConfigurazioneAI);

end.
