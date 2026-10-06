// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-13
// ---------------------------------------------------------------------------

unit HelpGen.AI;

// Generazione della guida tramite un motore AI (oggi Gemini).
//
// E' il pezzo che mancava fra il descrittore della form e il generatore del
// documento Word. Il giro completo e':
//
//   BaseForm.HelpDescribeForm
//     -> TBaseFormDescriptor.GeneraRequest   (descrittore in TOON + modello di
//                                             richiesta HelpGen_RichiestaCompleta.txt)
//       -> TzHelpGenAI.Richiedi              (questa unit: invio e attesa)
//         -> risposta del modello, chiesta in TOON per spendere meno token
//           -> InterpretaRisposta            (TOON o JSON, indifferentemente)
//             -> THelpGenResponseDocumentazione.FromJSON
//               -> THelpGenGenerator.GeneraDocumentazione (Word)
//
// Questa unit non sa nulla del fornitore: parla solo con TzAIEngine. Cambiare
// da Gemini a un altro fornitore e' una riga della configurazione.
//
// Configurazione: un esemplare DEDICATO, separato da quello della chat. La
// generazione di un documento vuole impostazioni diverse da una conversazione
// (modello piu' capace, molti piu' token in uscita, temperatura bassa, attesa
// lunga) e non deve essere disturbata da chi cambia modello nella tendina
// della chat. Si legge da HelpGen_AI.ini, nella cartella dei modelli di
// richiesta, e alla prima esecuzione il file viene creato con i predefiniti.
//
// La richiesta e' asincrona: Richiedi ritorna subito, la risposta arriva su
// OnDocumentazione (sul thread principale). L'oggetto THelpGenResponseDocumentazione
// consegnato all'evento appartiene a questa unit e viene distrutto all'uscita
// dall'evento: chi lo riceve lo usa e basta, non lo conserva.

interface

uses
  System.SysUtils,
  System.Classes,
  HelpGen.Types,
  HelpGen.Response.Classes,
  zAI.Configuration,
  zAI.Engine;

const
  // Etichette dei due formati riconosciuti in risposta
  FormatoJSON = 'JSON';
  FormatoTOON = 'TOON';

  // Sezione e nome del file di configurazione del servizio AI della guida.
  // Ripiego: la configurazione vera sta nel database (AI_UTILIZZI, utilizzo
  // 'GUIDA'), il file serve quando la riga non c'e' o il database non risponde
  HelpGenAIConfigSection = 'HelpGenAI';
  HelpGenAIConfigFileName = 'HelpGen_AI.ini';

  // Utilizzo corrispondente in AI_UTILIZZI
  HelpGenUtilizzo = 'GUIDA';

  // Predefiniti pensati per un documento intero, non per una chat
  HelpGenDefaultModel = 'gemini-2.5-pro';
  HelpGenDefaultMaxToken = 65536;
  HelpGenDefaultTimeout = 600000; // 10 minuti
  HelpGenDefaultTemperature = 0.2;

type
  THelpGenAIMode = (hmDocumentazione, hmElaborazioneTesto);

  THelpGenAIAzioneTesto = (
    atRiscrivi,
    atEspandi,
    atSintetizza,
    atNoteAvvertenza,
    atCorreggi,
    atPromptLibero
  );

  TzHelpGenDocumentazioneEvent = procedure(Sender: TObject;
    Documentazione: THelpGenResponseDocumentazione) of object;

  TzHelpGenTestoEvent = procedure(Sender: TObject; const TestoElaborato: string) of object;

  TzHelpGenAI = class(TComponent)
  private
    FEngine: TzAIEngine;
    // Tiene viva la form da documentare per tutta la richiesta, che e' asincrona
    FHelpSubject: IHelpSubject;
    FModuleName: string;
    FMode: THelpGenAIMode;
    FAzioneTestoCorrente: THelpGenAIAzioneTesto;
    FOnProcessingStart: TNotifyEvent;
    FOnDocumentazione: TzHelpGenDocumentazioneEvent;
    FOnTestoElaborato: TzHelpGenTestoEvent;
    FOnError: TzAITextEvent;
    procedure EngineProcessingStart(Sender: TObject);
    procedure EngineResponse(Sender: TObject; const Text: string);
    procedure EngineError(Sender: TObject; const ErrorMessage: string);
    procedure ReportError(const ErrorMessage: string);
    procedure EngineRegistraRichiesta(Sender: TObject;
      const AUtilizzo, AModello, APrompt: string; out AIdRegistrazione: Int64);
    procedure EngineRegistraRisposta(Sender: TObject; const AIdRegistrazione: Int64;
      const AEsito, ARisposta, AErrore: string; ADurataMs: Integer);
    procedure CaricaConfigurazione(AConfigurazione: TzAIConfiguration);
    function ConfigFileName: string;
    function GetConfiguration: TzAIConfiguration;
    function GetResponseInProgress: Boolean;
  public
    constructor Create(AOwner: TComponent); override;

    // Estrae il JSON dal testo consegnato dal modello: toglie le recinzioni
    // ```json, il BOM e qualunque frase di contorno prima o dopo l'oggetto.
    // Ritorna stringa vuota se nel testo non c'e' un oggetto JSON.
    class function EstraiJSON(const AText: string): string;

    // Lettura tollerante: riconosce da sola se la risposta e' in JSON o in
    // TOON e restituisce comunque JSON, l'unica cosa che
    // THelpGenResponseDocumentazione.FromJSON sa interpretare.
    // Si chiede il TOON per risparmiare token in uscita, ma il modello ogni
    // tanto risponde in JSON lo stesso: senza questa doppia strada una
    // generazione riuscita andrebbe buttata via per il solo formato.
    // AFormato riporta quale strada ha funzionato, per la traccia e per il log.
    class function InterpretaRisposta(const AText: string; out AJson, AFormato: string): Boolean;

    // Avvia la generazione per la form indicata. Ritorna Falso se la richiesta
    // non e' nemmeno partita (in quel caso OnError e' gia' scattato).
    function Richiedi(const AHelpSubject: IHelpSubject): Boolean;

    // Elabora un brano di testo (o argomento) dell'editor secondo l'azione redazionale specificata
    function ElaboraTesto(const ATesto: string; const AAzione: THelpGenAIAzioneTesto;
      const AIstruzioneUtente: string = ''): Boolean;

    procedure Annulla;

    // Prova chiave e raggiungibilita' del fornitore. Bloccante.
    function ProvaConnessione(out Response: string): Boolean;

    // Configurazione in uso (dedicata alla guida). Appartiene al motore, che
    // la distrugge con se stesso: qui si legge e si modifica, non si libera.
    property Configuration: TzAIConfiguration read GetConfiguration;
    property ResponseInProgress: Boolean read GetResponseInProgress;
    property Mode: THelpGenAIMode read FMode;
    property AzioneTestoCorrente: THelpGenAIAzioneTesto read FAzioneTestoCorrente;

    property OnProcessingStart: TNotifyEvent read FOnProcessingStart write FOnProcessingStart;
    property OnDocumentazione: TzHelpGenDocumentazioneEvent read FOnDocumentazione write FOnDocumentazione;
    property OnTestoElaborato: TzHelpGenTestoEvent read FOnTestoElaborato write FOnTestoElaborato;
    property OnError: TzAITextEvent read FOnError write FOnError;
  end;

implementation

uses
  System.IOUtils,
  System.JSON,
  zz.toon,
  SmartInspect.Vcl.SiAuto,
  AI.Bridge,
  HelpGen.Config;

resourcestring
  MsgRispostaIlleggibile = 'La risposta del servizio AI non e'' interpretabile ne'' come JSON ne'' come TOON. Il testo ricevuto e'' in Response_Raw_<modulo>.txt.';
  MsgRispostaNonInterpretabile = 'La risposta del servizio AI non e'' interpretabile: %s';
  MsgNessunaForm = 'Nessuna form da documentare.';

{ TzHelpGenAI }

constructor TzHelpGenAI.Create(AOwner: TComponent);
var
  Configurazione: TzAIConfiguration;
begin
  inherited Create(AOwner);

  FMode := hmDocumentazione;
  FAzioneTestoCorrente := atRiscrivi;

  // Configurazione dedicata alla guida: predefiniti da documento, poi il file
  // ini ha l'ultima parola. Se il file non esiste viene scritto con questi
  // valori, cosi' l'utente trova dove mettere la chiave
  Configurazione := TzAIConfiguration.Create;
  Configurazione.DriverName := DriverGemini;
  Configurazione.Model := HelpGenDefaultModel;
  Configurazione.MaxToken := HelpGenDefaultMaxToken;
  Configurazione.Timeout := HelpGenDefaultTimeout;
  Configurazione.Temperature := HelpGenDefaultTemperature;
  // Le istruzioni permanenti stanno gia' nel modello di richiesta
  // HelpGen_RichiestaCompleta.txt: qui resterebbero duplicate
  Configurazione.SystemInstruction := '';
  // La guida non deve registrare il motore presso i componenti DevExpress:
  // quello lo fa il pannello di chat, una volta sola per applicazione
  Configurazione.RegisterDevExpressChatClient := False;
  CaricaConfigurazione(Configurazione);

  FEngine := TzAIEngine.Create(Self, Configurazione, True);
  FEngine.Utilizzo := HelpGenUtilizzo;
  FEngine.OnProcessingStart := EngineProcessingStart;
  FEngine.OnResponse := EngineResponse;
  FEngine.OnError := EngineError;
  FEngine.OnRegistraRichiesta := EngineRegistraRichiesta;
  FEngine.OnRegistraRisposta := EngineRegistraRisposta;
end;

{ Database prima, file poi: come per la chat. }
procedure TzHelpGenAI.CaricaConfigurazione(AConfigurazione: TzAIConfiguration);
begin

  try

    if AIBridge.Carica(HelpGenUtilizzo, AConfigurazione) then
      Exit;

  except
    on E: Exception do
      SiMain.LogWarning('Configurazione AI dal database non riuscita: ' + E.Message);
  end;

  AConfigurazione.LoadFromIniFile(ConfigFileName, HelpGenAIConfigSection);
end;

{ Registro delle chiamate. Per la guida i testi si conservano davvero
  (REGISTRAZIONE = 'TES' in AI_UTILIZZI): la richiesta descrive l'interfaccia,
  non contiene dati di nessuno, ed e' quello che si rilegge quando il JSON
  torna storto. }
procedure TzHelpGenAI.EngineRegistraRichiesta(Sender: TObject;
  const AUtilizzo, AModello, APrompt: string; out AIdRegistrazione: Int64);
begin
  AIdRegistrazione := 0;

  try
    AIdRegistrazione := AIBridge.ApriRegistro(AUtilizzo, AModello, APrompt);
  except
    on E: Exception do
      SiMain.LogWarning('Registro AI non scritto: ' + E.Message);
  end;
end;

procedure TzHelpGenAI.EngineRegistraRisposta(Sender: TObject; const AIdRegistrazione: Int64;
  const AEsito, ARisposta, AErrore: string; ADurataMs: Integer);
begin

  try
    AIBridge.ChiudiRegistro(AIdRegistrazione, AEsito, ARisposta, AErrore, ADurataMs);
  except
    on E: Exception do
      SiMain.LogWarning('Registro AI non chiuso: ' + E.Message);
  end;
end;

function TzHelpGenAI.ConfigFileName: string;
begin
  Result := zHelpConfig.TemplateFolder + HelpGenAIConfigFileName;
end;

function TzHelpGenAI.GetConfiguration: TzAIConfiguration;
begin
  Result := FEngine.Configuration;
end;

function TzHelpGenAI.GetResponseInProgress: Boolean;
begin
  Result := FEngine.ResponseInProgress;
end;

function TzHelpGenAI.ProvaConnessione(out Response: string): Boolean;
begin
  Result := FEngine.TestConnection(Response);
end;

function TzHelpGenAI.Richiedi(const AHelpSubject: IHelpSubject): Boolean;
var
  Richiesta: string;
begin
  Result := False;

  if not Assigned(AHelpSubject) then
  begin
    ReportError(MsgNessunaForm);
    Exit;
  end;

  FMode := hmDocumentazione;
  FHelpSubject := AHelpSubject;
  FModuleName := AHelpSubject.HelpModuleName;

  try
    // Descrittore della form + modello di richiesta: e' qui che entra tutto
    // il contesto costruito da zAI.Descriptors
    Richiesta := AHelpSubject.HelpDescribeForm;
  except
    on E: Exception do
    begin
      ReportError(E.Message);
      Exit;
    end;
  end;

  Result := FEngine.Ask(Richiesta);
end;

function TzHelpGenAI.ElaboraTesto(const ATesto: string; const AAzione: THelpGenAIAzioneTesto;
  const AIstruzioneUtente: string = ''): Boolean;
var
  Prompt: string;
  IstruzioneAzione: string;
begin
  Result := False;

  FMode := hmElaborazioneTesto;
  FAzioneTestoCorrente := AAzione;

  if Assigned(FHelpSubject) then
    FModuleName := FHelpSubject.HelpModuleName
  else
    FModuleName := 'TestoEditor';

  case AAzione of
    atRiscrivi:
      IstruzioneAzione :=
        'Riscrivi e perfeziona il seguente testo destinato alla documentazione/guida utente di Gesty.' + sLineBreak +
        '- Rendilo chiaro, scorrevole, professionale e privo di ambiguita'' o ripetizioni.' + sLineBreak +
        '- Mantieni inalterati tutti i concetti operativi e la terminologia gestionale.';

    atEspandi:
      IstruzioneAzione :=
        'Espandi e approfondisci la spiegazione del seguente testo per la guida utente.' + sLineBreak +
        '- Fornisci dettagli operativi passo-passo utili all''operatore.' + sLineBreak +
        '- Chiarisci il significato funzionale e le implicazioni delle opzioni o azioni descritte.';

    atSintetizza:
      IstruzioneAzione :=
        'Sintetizza e riassumi in modo rapido ed essenziale il seguente testo della guida.' + sLineBreak +
        '- Mantieni solo i passaggi operativi fondamentali e le informazioni indispensabili.' + sLineBreak +
        '- Utilizza periodi brevi e diretti.';

    atNoteAvvertenza:
      IstruzioneAzione :=
        'Formula un riquadro o paragrafo di ATTENZIONE / NOTA OPERATIVA per la guida utente a partire dal testo/argomento fornito.' + sLineBreak +
        '- Metti in risalto i rischi di errori operativi, i vincoli e le conseguenze importanti sui dati.' + sLineBreak +
        '- Inizia con una formula chiara come "ATTENZIONE:" o "NOTA OPERATIVA:".';

    atCorreggi:
      IstruzioneAzione :=
        'Effettua la revisione ortografica, grammaticale, di punteggiatura e sintattica del seguente testo.' + sLineBreak +
        '- Preserva fedelmente la struttura, la punteggiatura logica e i termini tecnici.';

    atPromptLibero:
      IstruzioneAzione :=
        'Esegui la seguente istruzione redazionale specifica sul testo (o argomento) indicato.' + sLineBreak +
        'Istruzione dell''operatore: ' + AIstruzioneUtente;
  end;

  Prompt :=
    'Sei un assistente editoriale per la redazione di guide utente e manuali operativi di software gestionali aziendali.' + sLineBreak +
    'REGOLE DI GENERAZIONE TASSATIVE:' + sLineBreak +
    '1. Rispondi SEMPRE ed ESCLUSIVAMENTE in lingua italiana.' + sLineBreak +
    '2. Non inserire preamboli, introduzioni, convenevoli o formule conclusive (nessun "Certamente", "Ecco il testo", ecc.).' + sLineBreak +
    '3. Non racchiudere il testo in blocchi di codice markdown con tre apici inversi (```).' + sLineBreak +
    '4. Restituisci SOLAMENTE il testo pronto per essere inserito direttamente nel documento della guida.' + sLineBreak +
    sLineBreak +
    '--- ISTRUZIONE ---' + sLineBreak +
    IstruzioneAzione + sLineBreak +
    sLineBreak +
    '--- TESTO DI PARTENZA ---' + sLineBreak +
    ATesto;

  Result := FEngine.Ask(Prompt);
end;

procedure TzHelpGenAI.Annulla;
begin
  FEngine.Cancel;
end;

procedure TzHelpGenAI.EngineProcessingStart(Sender: TObject);
begin
  if Assigned(FOnProcessingStart) then
    FOnProcessingStart(Self);
end;

procedure TzHelpGenAI.ReportError(const ErrorMessage: string);
begin
  if Assigned(FOnError) then
    FOnError(Self, ErrorMessage);
end;

procedure TzHelpGenAI.EngineError(Sender: TObject; const ErrorMessage: string);
begin
  ReportError(ErrorMessage);
end;

class function TzHelpGenAI.EstraiJSON(const AText: string): string;
var
  Testo: string;
  Inizio: Integer;
  Fine: Integer;
begin
  Result := '';
  Testo := AText;

  // Il modello incornicia quasi sempre il JSON con ```json ... ```, e a volte
  // ci aggiunge una frase di cortesia prima o dopo. Si tiene il tratto che va
  // dalla prima graffa aperta all'ultima chiusa: e' l'oggetto di risposta
  Testo := Testo.Replace('```', '', [rfReplaceAll]);
  Testo := Testo.Replace(#$FEFF, '', [rfReplaceAll]);

  Inizio := Testo.IndexOf('{');
  Fine := Testo.LastIndexOf('}');

  if (Inizio < 0) or (Fine <= Inizio) then
    Exit;

  Result := Testo.Substring(Inizio, Fine - Inizio + 1);
end;

class function TzHelpGenAI.InterpretaRisposta(const AText: string; out AJson, AFormato: string): Boolean;

  // Il JSON deve interpretarsi davvero, non solo somigliare a un JSON: la
  // prova e' il parser, non l'aspetto della prima riga
  function ProvaJSON: Boolean;
  var
    Testo: string;
    Valore: TJSONValue;
  begin
    Result := False;
    Testo := EstraiJSON(AText);

    if Testo.IsEmpty then
      exit;

    Valore := TJSONObject.ParseJSONValue(Testo, False, False);

    if not Assigned(Valore) then
      exit;

    try
      Result := (Valore is TJSONObject) and (TJSONObject(Valore).Count > 0);

      if Result then
      begin
        AJson := Testo;
        AFormato := FormatoJSON;
      end;
    finally
      Valore.Free;
    end;
  end;

  function ProvaTOON: Boolean;
  var
    Valore: TJSONValue;
  begin
    Result := False;

    try
      Valore := TzToon.ToJsonValue(AText);
    except
      // il lettore TOON e' tollerante, ma se proprio non ce la fa non deve
      // portarsi dietro la generazione
      exit;
    end;

    try
      Result := (Valore is TJSONObject) and (TJSONObject(Valore).Count > 0);

      if Result then
      begin
        AJson := Valore.ToJSON;
        AFormato := FormatoTOON;
      end;
    finally
      Valore.Free;
    end;
  end;

var
  Ripulito: string;
begin
  AJson := '';
  AFormato := '';

  // Si prova per prima la strada che il testo suggerisce, l'altra come rete
  Ripulito := AText.Replace(#$FEFF, '', [rfReplaceAll]).Replace('```', '', [rfReplaceAll]).TrimLeft;

  if Ripulito.StartsWith('{') or Ripulito.StartsWith('[') then
  begin
    Result := ProvaJSON;

    if not Result then
      Result := ProvaTOON;
  end
  else
  begin
    Result := ProvaTOON;

    if not Result then
      Result := ProvaJSON;
  end;
end;

procedure TzHelpGenAI.EngineResponse(Sender: TObject; const Text: string);
var
  JSON: string;
  Formato: string;
  Documentazione: THelpGenResponseDocumentazione;
  TestoPulito: string;
  Linee: TStringList;
begin
  // Traccia grezza di quello che ha risposto il modello: quando la risposta
  // non si lascia interpretare e' l'unico modo per capire cosa e' arrivato
  try
    TFile.WriteAllText(zHelpConfig.TemplateFolder + 'Response_Raw_' + FModuleName + '.txt', Text);
  except
    // la traccia non deve far fallire la generazione
  end;

  if FMode = hmElaborazioneTesto then
  begin
    TestoPulito := Text.Trim;

    // Rimuove eventuali recinzioni di codice markdown (```...) prodotte dal modello
    if TestoPulito.StartsWith('```') then
    begin
      Linee := TStringList.Create;
      try
        Linee.Text := TestoPulito;
        if Linee.Count > 0 then
          Linee.Delete(0);
        if (Linee.Count > 0) and Linee[Linee.Count - 1].Trim.StartsWith('```') then
          Linee.Delete(Linee.Count - 1);
        TestoPulito := Linee.Text.Trim;
      finally
        Linee.Free;
      end;
    end;

    if Assigned(FOnTestoElaborato) then
      FOnTestoElaborato(Self, TestoPulito);
    Exit;
  end;

  if not InterpretaRisposta(Text, JSON, Formato) then
  begin
    ReportError(MsgRispostaIlleggibile);
    Exit;
  end;

  SiMain.LogString('HelpGen: formato della risposta', Formato);

  // Prima scrittura non formattata: se FromJSON solleva, il file resta
  // comunque a disposizione per l'esame
  try
    TFile.WriteAllText(zHelpConfig.TemplateFolder + 'Response_' + FModuleName + '.json', JSON);
  except
    // idem
  end;

  try
    Documentazione := THelpGenResponseDocumentazione.FromJSON(JSON);
  except
    on E: Exception do
    begin
      ReportError(Format(MsgRispostaNonInterpretabile, [E.Message]));
      Exit;
    end;
  end;

  try
    // Sovrascrive, adesso che si sa che e' valido, con il JSON formattato
    try
      TFile.WriteAllText(zHelpConfig.TemplateFolder + 'Response_' + FModuleName + '.json',
        Documentazione.ToJSONString);
    except
      // idem
    end;

    if Assigned(FOnDocumentazione) then
      FOnDocumentazione(Self, Documentazione);
  finally
    Documentazione.Free;
  end;
end;

end.
