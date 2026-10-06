// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-13
// ---------------------------------------------------------------------------

unit zAI.Configuration;

// Configurazione di un servizio AI (fornitore, modello, chiave, istruzioni).
//
// E' il punto di regolazione esterno: l'applicazione ospite decide fornitore
// (driver), modello, chiave, istruzioni di sistema e profondita' del contesto
// PRIMA che il servizio venga usato, oppure in qualunque momento riassegnando
// le proprieta': OnChange fa riallineare da solo il motore (TzAIEngine).
//
// Ogni consumatore (chat, generazione della guida, ...) puo' avere il proprio
// esemplare: quello condiviso (AIConfiguration) e' solo il predefinito.
//
// La unit non dipende da SmartCoreAI ne' dal motore: contiene solo dati.
// I nomi dei driver sono quelli registrati da SmartCoreAI
// (TAIDriverRegistry): 'Gemini', 'OpenAI', 'Claude', 'Ollama'.

interface

uses
  System.SysUtils,
  System.Classes,
  System.IniFiles;

const
  // Nomi dei driver SmartCoreAI. Ripetuti qui per non legare questa unit
  // a SmartCoreAI.Consts: sono valori di configurazione, non codice.
  DriverGemini = 'Gemini';
  DriverOpenAI = 'OpenAI';
  DriverClaude = 'Claude';
  DriverOllama = 'Ollama';

  // Sezione predefinita del file di configurazione
  AIConfigurationSection = 'ChatAI';

  // Valori predefiniti
  DefaultDriverName = DriverGemini;
  DefaultAssistantName = 'Assistente';
  DefaultWelcomeMessage = 'Ciao! Come posso aiutarti?';
  DefaultHistoryDepth = 20;
  DefaultTemperature = 0.0; // 0 = lascia decidere al fornitore

  // Presidio di conformita' al Regolamento UE 2024/1689 (AI Act art. 14 e 50)
  DefaultSystemInstruction =
    'Agisci come assistente operativo a supporto dell''operatore per il gestionale Gesty. ' +
    'I tuoi suggerimenti hanno valore puramente consultivo e redazionale e non costituiscono ' +
    'provvedimento amministrativo o certificazione legale (AI Act art. 14 e 50). ' +
    'Se rilevi incertezze su normative regionali o calcolo ore, esplicita la necessita'' di verifica sui registri ufficiali.';

type
  { Configurazione del servizio AI. Un solo esemplare condiviso, accessibile
    con la funzione AIConfiguration; se ne possono comunque creare altri e
    passarli a un singolo datamodule. }
  TzAIConfiguration = class(TPersistent)
  private
    FDriverName: string;
    FAPIKey: string;
    FModel: string;
    FBaseURL: string;
    FSystemInstruction: string;
    FAssistantName: string;
    FWelcomeMessage: string;
    FTemperature: Double;
    FMaxToken: Integer;
    FTimeout: Integer;
    FHistoryDepth: Integer;
    FModels: TStringList;
    FRegisterDevExpressChatClient: Boolean;
    FOnChange: TNotifyEvent;
    procedure SetDriverName(const Value: string);
    procedure SetAPIKey(const Value: string);
    procedure SetModel(const Value: string);
    procedure SetBaseURL(const Value: string);
    procedure SetSystemInstruction(const Value: string);
    procedure SetAssistantName(const Value: string);
    procedure SetWelcomeMessage(const Value: string);
    procedure SetTemperature(const Value: Double);
    procedure SetMaxToken(const Value: Integer);
    procedure SetTimeout(const Value: Integer);
    procedure SetHistoryDepth(const Value: Integer);
    function GetModels: TStrings;
    procedure SetModels(const Value: TStrings);
    procedure ModelsChanged(Sender: TObject);
  protected
    procedure Changed;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure RestoreDefaults;

    { Elenco di modelli proposto quando Models e' vuoto. Serve solo a
      popolare la tendina senza interrogare il fornitore: l'elenco reale si
      ottiene con TAI.RefreshModels. }
    class function SuggestedModels(const ADriverName: string): TArray<string>;

    { Vero quando la configurazione basta ad avviare una richiesta. Ollama
      gira in locale e non usa la chiave. }
    function IsConfigured: Boolean;

    procedure LoadFromIniFile(const AFileName: string; const ASection: string = AIConfigurationSection);
    procedure SaveToIniFile(const AFileName: string; const ASection: string = AIConfigurationSection);

    // --- identita' del fornitore ---
    property DriverName: string read FDriverName write SetDriverName;
    property APIKey: string read FAPIKey write SetAPIKey;
    property Model: string read FModel write SetModel;
    { Vuoto = indirizzo predefinito del driver. Da valorizzare solo per
      installazioni locali o inoltri aziendali. }
    property BaseURL: string read FBaseURL write SetBaseURL;

    // --- generazione ---
    { 0 = non trasmesso, decide il fornitore. }
    property Temperature: Double read FTemperature write SetTemperature;
    property MaxToken: Integer read FMaxToken write SetMaxToken;
    property Timeout: Integer read FTimeout write SetTimeout;
    { Istruzioni permanenti anteposte a ogni richiesta (ruolo, tono, lingua,
      vincoli). I driver SmartCoreAI espongono la sola chiamata Chat con un
      testo unico, quindi vengono anteposte al prompt. }
    property SystemInstruction: string read FSystemInstruction write SetSystemInstruction;
    { Quanti messaggi della conversazione ritrasmettere a ogni richiesta
      (i motori sono senza memoria). 0 = tutti. }
    property HistoryDepth: Integer read FHistoryDepth write SetHistoryDepth;

    // --- aspetto ---
    property AssistantName: string read FAssistantName write SetAssistantName;
    property WelcomeMessage: string read FWelcomeMessage write SetWelcomeMessage;
    { Modelli elencati nella tendina. Vuoto = elenco suggerito del driver. }
    property Models: TStrings read GetModels write SetModels;

    { Registra il driver anche come motore dei componenti DevExpress
      (dxRichEdit, dxSpreadSheet, ...) tramite TdxAIChatClients. }
    property RegisterDevExpressChatClient: Boolean read FRegisterDevExpressChatClient write FRegisterDevExpressChatClient;

    { Scatta a ogni modifica: il datamodule vi si aggancia per riallineare
      il driver senza che il chiamante debba ricordarsene. }
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  { Esemplare condiviso, creato al primo uso e distrutto alla chiusura. }
function AIConfiguration: TzAIConfiguration;

implementation

uses
  System.IOUtils;

var
  SharedConfiguration: TzAIConfiguration = nil;

function AIConfiguration: TzAIConfiguration;
begin
  if SharedConfiguration = nil then
    SharedConfiguration := TzAIConfiguration.Create;
  Result := SharedConfiguration;
end;

{ TzAIConfiguration }

constructor TzAIConfiguration.Create;
begin
  inherited Create;
  FModels := TStringList.Create;
  FModels.OnChange := ModelsChanged;
  RestoreDefaults;
end;

destructor TzAIConfiguration.Destroy;
begin
  FModels.OnChange := nil;
  FModels.Free;
  inherited Destroy;
end;

procedure TzAIConfiguration.RestoreDefaults;
begin
  FDriverName := DefaultDriverName;
  FAPIKey := '';
  FModel := '';
  FBaseURL := '';
  FSystemInstruction := DefaultSystemInstruction;
  FAssistantName := DefaultAssistantName;
  FWelcomeMessage := DefaultWelcomeMessage;
  FTemperature := DefaultTemperature;
  FMaxToken := 0;
  FTimeout := 0;
  FHistoryDepth := DefaultHistoryDepth;
  FRegisterDevExpressChatClient := True;
  FModels.OnChange := nil;
  try
    FModels.Clear;
  finally
    FModels.OnChange := ModelsChanged;
  end;
  Changed;
end;

procedure TzAIConfiguration.Assign(Source: TPersistent);
var
  Other: TzAIConfiguration;
begin
  if Source is TzAIConfiguration then
  begin
    Other := TzAIConfiguration(Source);
    FDriverName := Other.FDriverName;
    FAPIKey := Other.FAPIKey;
    FModel := Other.FModel;
    FBaseURL := Other.FBaseURL;
    FSystemInstruction := Other.FSystemInstruction;
    FAssistantName := Other.FAssistantName;
    FWelcomeMessage := Other.FWelcomeMessage;
    FTemperature := Other.FTemperature;
    FMaxToken := Other.FMaxToken;
    FTimeout := Other.FTimeout;
    FHistoryDepth := Other.FHistoryDepth;
    FRegisterDevExpressChatClient := Other.FRegisterDevExpressChatClient;
    FModels.OnChange := nil;
    try
      FModels.Assign(Other.FModels);
    finally
      FModels.OnChange := ModelsChanged;
    end;
    Changed;
  end
  else
    inherited Assign(Source);
end;

procedure TzAIConfiguration.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function TzAIConfiguration.GetModels: TStrings;
begin
  Result := FModels;
end;

procedure TzAIConfiguration.ModelsChanged(Sender: TObject);
begin
  Changed;
end;

procedure TzAIConfiguration.SetDriverName(const Value: string);
begin
  if FDriverName <> Value then
  begin
    FDriverName := Value;
    Changed;
  end;
end;

procedure TzAIConfiguration.SetAPIKey(const Value: string);
begin
  if FAPIKey <> Value then
  begin
    FAPIKey := Value;
    Changed;
  end;
end;

procedure TzAIConfiguration.SetModel(const Value: string);
begin
  if FModel <> Value then
  begin
    FModel := Value;
    Changed;
  end;
end;

procedure TzAIConfiguration.SetBaseURL(const Value: string);
begin
  if FBaseURL <> Value then
  begin
    FBaseURL := Value;
    Changed;
  end;
end;

procedure TzAIConfiguration.SetSystemInstruction(const Value: string);
begin
  if FSystemInstruction <> Value then
  begin
    FSystemInstruction := Value;
    Changed;
  end;
end;

procedure TzAIConfiguration.SetAssistantName(const Value: string);
begin
  if FAssistantName <> Value then
  begin
    FAssistantName := Value;
    Changed;
  end;
end;

procedure TzAIConfiguration.SetWelcomeMessage(const Value: string);
begin
  if FWelcomeMessage <> Value then
  begin
    FWelcomeMessage := Value;
    Changed;
  end;
end;

procedure TzAIConfiguration.SetTemperature(const Value: Double);
begin
  if FTemperature <> Value then
  begin
    FTemperature := Value;
    Changed;
  end;
end;

procedure TzAIConfiguration.SetMaxToken(const Value: Integer);
begin
  if FMaxToken <> Value then
  begin
    FMaxToken := Value;
    Changed;
  end;
end;

procedure TzAIConfiguration.SetTimeout(const Value: Integer);
begin
  if FTimeout <> Value then
  begin
    FTimeout := Value;
    Changed;
  end;
end;

procedure TzAIConfiguration.SetHistoryDepth(const Value: Integer);
begin
  if FHistoryDepth <> Value then
  begin
    FHistoryDepth := Value;
    Changed;
  end;
end;

procedure TzAIConfiguration.SetModels(const Value: TStrings);
begin
  FModels.Assign(Value); // OnChange di FModels propaga la notifica
end;

function TzAIConfiguration.IsConfigured: Boolean;
begin
  Result := (Trim(FDriverName) <> '') and (SameText(FDriverName, DriverOllama) or (Trim(FAPIKey) <> ''));
end;

class function TzAIConfiguration.SuggestedModels(const ADriverName: string): TArray<string>;
begin
  if SameText(ADriverName, DriverGemini) then
    Result := ['gemini-2.5-flash', 'gemini-2.5-pro', 'gemini-2.0-flash']
  else
    if SameText(ADriverName, DriverOpenAI) then
      Result := ['gpt-5', 'gpt-4.1', 'gpt-4o', 'gpt-4o-mini']
    else
      if SameText(ADriverName, DriverClaude) then
        Result := ['claude-sonnet-4-latest', 'claude-opus-4-latest', 'claude-haiku-4-latest']
      else
        if SameText(ADriverName, DriverOllama) then
          Result := ['llama3.1:8b']
        else
          Result := [];
end;

procedure TzAIConfiguration.LoadFromIniFile(const AFileName, ASection: string);
var
  IniFile: TIniFile;
  ModelList: string;
begin

 if not TFile.Exists(aFileName) then
 begin
   SaveToIniFile(aFileName, aSection);
   exit;
 end;


  IniFile := TIniFile.Create(AFileName);
  try
    DriverName := IniFile.ReadString(ASection, 'DriverName', FDriverName);
    APIKey := IniFile.ReadString(ASection, 'APIKey', FAPIKey);
    Model := IniFile.ReadString(ASection, 'Model', FModel);
    BaseURL := IniFile.ReadString(ASection, 'BaseURL', FBaseURL);
    // Le istruzioni di sistema sono multiriga: nel file stanno su una riga
    // sola con \n al posto degli a capo
    SystemInstruction := StringReplace(IniFile.ReadString(ASection, 'SystemInstruction', StringReplace(FSystemInstruction, sLineBreak, '\n', [rfReplaceAll])), '\n', sLineBreak, [rfReplaceAll]);
    AssistantName := IniFile.ReadString(ASection, 'AssistantName', FAssistantName);
    WelcomeMessage := IniFile.ReadString(ASection, 'WelcomeMessage', FWelcomeMessage);
    Temperature := StrToFloatDef(IniFile.ReadString(ASection, 'Temperature', ''), FTemperature, TFormatSettings.Invariant);
    MaxToken := IniFile.ReadInteger(ASection, 'MaxToken', FMaxToken);
    Timeout := IniFile.ReadInteger(ASection, 'Timeout', FTimeout);
    HistoryDepth := IniFile.ReadInteger(ASection, 'HistoryDepth', FHistoryDepth);
    RegisterDevExpressChatClient := IniFile.ReadBool(ASection, 'RegisterDevExpressChatClient', FRegisterDevExpressChatClient);

    ModelList := IniFile.ReadString(ASection, 'Models', '');
    if ModelList <> '' then
    begin
      FModels.OnChange := nil;
      try
        FModels.CommaText := ModelList;
      finally
        FModels.OnChange := ModelsChanged;
      end;
      Changed;
    end;
  finally
    IniFile.Free;
  end;
end;

procedure TzAIConfiguration.SaveToIniFile(const AFileName, ASection: string);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(AFileName);
  try
    IniFile.WriteString(ASection, 'DriverName', FDriverName);
    // Attenzione: la chiave finisce in chiaro nel file. Se il file non e'
    // protetto, lasciare vuota questa voce e valorizzare APIKey da codice
    IniFile.WriteString(ASection, 'APIKey', FAPIKey);
    IniFile.WriteString(ASection, 'Model', FModel);
    IniFile.WriteString(ASection, 'BaseURL', FBaseURL);
    IniFile.WriteString(ASection, 'SystemInstruction', StringReplace(FSystemInstruction, sLineBreak, '\n', [rfReplaceAll]));
    IniFile.WriteString(ASection, 'AssistantName', FAssistantName);
    IniFile.WriteString(ASection, 'WelcomeMessage', FWelcomeMessage);
    IniFile.WriteString(ASection, 'Temperature', FloatToStr(FTemperature, TFormatSettings.Invariant));
    IniFile.WriteInteger(ASection, 'MaxToken', FMaxToken);
    IniFile.WriteInteger(ASection, 'Timeout', FTimeout);
    IniFile.WriteInteger(ASection, 'HistoryDepth', FHistoryDepth);
    IniFile.WriteBool(ASection, 'RegisterDevExpressChatClient', FRegisterDevExpressChatClient);
    IniFile.WriteString(ASection, 'Models', FModels.CommaText);
  finally
    IniFile.Free;
  end;
end;

initialization

finalization

FreeAndNil(SharedConfiguration);

end.
