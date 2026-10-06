// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-15
// ---------------------------------------------------------------------------

unit zChatAIPane;

// Pannello chat AI "chiavi in mano": la facciata che un form deve creare
// per avere l'intera funzionalita' (equivalente dell'AIChatControl WinForms,
// che unisce chat UI + servizio AI + header con titolo e pulsanti).
//
// Compone:
// TzChatSlidingPanel (apertura/chiusura animata, ridimensionamento)
// + intestazione (titolo + icone: Contesto, Storico, Nuova chat, Chiudi)
// + TzChat (conversazione, input, allegati con chip rimovibili, scelta modello)
// + TAI (datamodule dei servizi: modelli, benvenuto, risposte a flusso)
// + TzChatSessionStore (storicizzazione sessioni stile Claude/Gemini)
// + footer di conformita' normativa (AI Act art. 14 e 50, GDPR art. 22)
//
// Sessioni: ogni conversazione viene salvata automaticamente a ogni
// messaggio; "Nuova chat" archivia la corrente e ne inizia una nuova;
// "Storico" apre una tendina con le sessioni salvate (click = apri,
// cestino = elimina).

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Controls,
  Vcl.Graphics,
  Vcl.Forms,
  Vcl.ActnList,
  Vcl.Dialogs,
  Winapi.Windows,
  cxButtons,
  cxGroupBox,
  cxLabel,
  cxLookAndFeels,
  zChatSlidingPanel,
  zChatTypes,
  zChatControl,
  zChatSessions,
  zChatSessionsDropDown,
  dmAI,
  HelpGen.Types;

type
  { IcxLookAndFeelNotificationListener: il pannello ha parti proprie da
    ricolorare (sfondo e icone dell'intestazione/footer) che TzChat non vede. }
  TzChatAIPane = class(TzChatSlidingPanel, IcxLookAndFeelNotificationListener)
  private
    FChat: TzChat;
    FPalette: TzChatPalette;
    FHeaderButtons: array of TcxButton; // per ricolorarne le icone
    FHeaderGlyphs: array of string; // l'SVG di ciascuna, col segnaposto
    FAI: TAI;
    FAssistantUser: TzChatUser;
    FTitleLabel: TcxLabel;
    FContextButton: TcxButton;
    FHistoryButton: TcxButton;
    FFooterPanel: TcxGroupBox;
    FDisclaimerLabel: TcxLabel;
    FInfoButton: TcxButton;
    FToggleAction: TCustomAction;
    FOpenedImageIndex: Integer;
    FClosedImageIndex: Integer;
    FSessionStore: TzChatSessionStore;
    FSessionsDropDown: TzChatSessionsDropDown;
    FCurrentSessionId: string;
    FIncludeContext: Boolean;
    FCurrentInFlightMessage: TzChatMessage;
    procedure BuildHeader;
    procedure BuildChat;
    procedure BuildFooter;
    procedure ChatMessageEntered(Sender: TObject; const Text: string; Attachments: TStrings);
    procedure AIProcessingStart(Sender: TObject);
    procedure AIPartialResponse(Sender: TObject; const PartialText: string);
    procedure AIResponse(Sender: TObject; const Text: string);
    procedure AIError(Sender: TObject; const ErrorMessage: string);
    procedure InputCancel(Sender: TObject);
    procedure RefreshModelsClick(Sender: TObject);
    { AShowErrors = False per la chiamata silenziosa in apertura pannello: una
      rete lenta o assente non deve interrompere l'apertura con un avviso,
      resta semplicemente l'elenco statico di ripiego gia' in Models. }
    procedure DoRefreshModels(const AShowErrors: Boolean);
    procedure CloseButtonClick(Sender: TObject);
    procedure NewChatButtonClick(Sender: TObject);
    procedure HistoryButtonClick(Sender: TObject);
    procedure ContextButtonClick(Sender: TObject);
    procedure InfoButtonClick(Sender: TObject);
    procedure AggiornaPalette;
    function GetActiveFormContext: string;
    { --- IcxLookAndFeelNotificationListener --- }
    function GetObject: TObject;
    procedure MasterLookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
    procedure MasterLookAndFeelDestroying(Sender: TcxLookAndFeel);
    procedure SessionChosen(Sender: TObject; const SessionId: string);
    procedure SaveCurrentSession;
    function GetTitle: string;
    procedure SetTitle(const Value: string);
  protected
    { Tiene allineati Checked e icona dell'action collegata. }
    procedure StateChanged(AOpen: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Archivia la conversazione corrente e ne inizia una nuova. }
    procedure ClearConversation;
    property Chat: TzChat read FChat;
    property AI: TAI read FAI;
    property SessionStore: TzChatSessionStore read FSessionStore;
    { Action che comanda il pannello (es. bottone nel ribbon): il pannello
      ne sincronizza Checked e ImageIndex a ogni apertura/chiusura. }
    property ToggleAction: TCustomAction read FToggleAction write FToggleAction;
    property OpenedImageIndex: Integer read FOpenedImageIndex write FOpenedImageIndex;
    property ClosedImageIndex: Integer read FClosedImageIndex write FClosedImageIndex;
    property Title: string read GetTitle write SetTitle;
    property IncludeContext: Boolean read FIncludeContext write FIncludeContext;
  end;

implementation

uses
  cxEdit;

const
  HEADER_HEIGHT = 36;
  FOOTER_HEIGHT = 24;
  ICON_BUTTON_WIDTH = 28;
  DROPDOWN_WIDTH = 300;

  { Icone SVG inline: seguono il DPI. }
  SVG_HISTORY = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16">' + '<circle cx="8" cy="8" r="5.5" fill="none" stroke="%0:s" stroke-width="1.3"/>' + '<path d="M8 5v3.2l2.2 1.3" fill="none" stroke="%0:s" stroke-width="1.3"/></svg>';
  SVG_NEW_CHAT = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16">' + '<path d="M8 3.5v9M3.5 8h9" fill="none" stroke="%0:s" stroke-width="1.4"/></svg>';
  SVG_CLOSE = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16">' + '<path d="M4.5 4.5l7 7M11.5 4.5l-7 7" fill="none" stroke="%0:s" stroke-width="1.4"/></svg>';
  SVG_CONTEXT = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16">' + '<rect x="2.5" y="2.5" width="11" height="11" rx="2" fill="none" stroke="%0:s" stroke-width="1.3"/>' +
    '<path d="M5 6h6M5 8.5h6M5 11h4" fill="none" stroke="%0:s" stroke-width="1.2"/></svg>';

  // Carica un'icona SVG nel glyph del bottone
procedure LoadSvgGlyph(Button: TcxButton; const SvgText: string);
var
  SvgStream: TStringStream;
begin
  SvgStream := TStringStream.Create(SvgText, TEncoding.UTF8);
  try
    Button.OptionsImage.Glyph.LoadFromStream(SvgStream);
  finally
    SvgStream.Free;
  end;
end;

{ TzChatAIPane }

constructor TzChatAIPane.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOpenedImageIndex := -1;
  FClosedImageIndex := -1;
  FIncludeContext := False;
  FCurrentInFlightMessage := nil;

  FPalette := TzChatPalette.Corrente;
  Style.Color := FPalette.Sfondo;
  RootLookAndFeel.AddChangeListener(Self);

  // Servizio AI: fornisce modelli, benvenuto, risposte e flusso
  FAI := TAI.Create(Self);
  FAI.OnProcessingStart := AIProcessingStart;
  FAI.OnResponse := AIResponse;
  FAI.OnError := AIError;
  FAI.OnPartialResponse := AIPartialResponse;

  // Storicizzazione: ogni conversazione e' una sessione salvata su file
  FSessionStore := TzChatSessionStore.Create(Self);
  FCurrentSessionId := FSessionStore.NewSessionId;

  BuildHeader;
  BuildFooter;
  BuildChat;
end;

destructor TzChatAIPane.Destroy;
begin
  RootLookAndFeel.RemoveChangeListener(Self);
  if (FSessionStore <> nil) and (FChat <> nil) then
    FSessionStore.SaveFromChat(FChat, FCurrentSessionId);
  inherited Destroy;
end;

procedure TzChatAIPane.BuildHeader;
var
  Header: TcxGroupBox;
  CloseButton: TcxButton;
  NewChatButton: TcxButton;

  function CreateButton(const ASvg, AHint: string): TcxButton;
  begin
    result := TcxButton.Create(Self);
    result.Parent := Header;
    result.Align := alRight;
    result.AlignWithMargins := True;
    result.Margins.SetBounds(0, 4, 4, 4);
    result.Width := ICON_BUTTON_WIDTH;
    result.SpeedButtonOptions.Flat := True;
    result.SpeedButtonOptions.Transparent := True;
    result.SpeedButtonOptions.CanBeFocused := False;
    result.Hint := AHint;
    result.ShowHint := True;
    LoadSvgGlyph(result, Format(ASvg, [zChatColorToHtml(FPalette.TestoAltrui)]));

    SetLength(FHeaderButtons, Length(FHeaderButtons) + 1);
    SetLength(FHeaderGlyphs, Length(FHeaderGlyphs) + 1);
    FHeaderButtons[High(FHeaderButtons)] := result;
    FHeaderGlyphs[High(FHeaderGlyphs)] := ASvg;
  end;

begin
  Header := TcxGroupBox.Create(Self);
  Header.Parent := Self;
  Header.Align := alTop;
  Header.Height := HEADER_HEIGHT;
  Header.PanelStyle.Active := True;
  Header.Caption := '';

  FTitleLabel := TcxLabel.Create(Self);
  FTitleLabel.Parent := Header;
  FTitleLabel.Align := alLeft;
  FTitleLabel.AlignWithMargins := True;
  FTitleLabel.Margins.SetBounds(12, 0, 0, 0);
  FTitleLabel.Properties.Alignment.Vert := TcxEditVertAlignment.taVCenter;
  FTitleLabel.Transparent := True;
  FTitleLabel.Style.TextStyle := [fsBold];
  FTitleLabel.Caption := 'Chat AI';

  CloseButton := CreateButton(SVG_CLOSE, 'Chiudi');
  CloseButton.OnClick := CloseButtonClick;

  NewChatButton := CreateButton(SVG_NEW_CHAT, 'Nuova conversazione');
  NewChatButton.OnClick := NewChatButtonClick;

  FHistoryButton := CreateButton(SVG_HISTORY, 'Storico conversazioni');
  FHistoryButton.OnClick := HistoryButtonClick;

  FContextButton := CreateButton(SVG_CONTEXT, 'Collega il contesto della scheda attiva nelle domande');
  FContextButton.OnClick := ContextButtonClick;

  Header.DisableAlign;
  try
    FContextButton.Left := 0;
    FHistoryButton.Left := 1000;
    NewChatButton.Left := 2000;
    CloseButton.Left := 3000;
  finally
    Header.EnableAlign;
  end;
end;

procedure TzChatAIPane.BuildFooter;
begin
  FFooterPanel := TcxGroupBox.Create(Self);
  FFooterPanel.Parent := Self;
  FFooterPanel.Align := alBottom;
  FFooterPanel.Height := FOOTER_HEIGHT;
  FFooterPanel.PanelStyle.Active := True;
  FFooterPanel.Caption := '';

  FDisclaimerLabel := TcxLabel.Create(Self);
  FDisclaimerLabel.Parent := FFooterPanel;
  FDisclaimerLabel.Align := alClient;
  FDisclaimerLabel.AlignWithMargins := True;
  FDisclaimerLabel.Margins.SetBounds(8, 0, 2, 0);
  FDisclaimerLabel.Properties.Alignment.Vert := TcxEditVertAlignment.taVCenter;
  FDisclaimerLabel.Transparent := True;
  FDisclaimerLabel.Style.Font.Size := 8;
  FDisclaimerLabel.Style.TextColor := FPalette.Orario;
  FDisclaimerLabel.Caption := 'L''assistente AI puo'' commettere errori. Verifica sempre i dati.';

  FInfoButton := TcxButton.Create(Self);
  FInfoButton.Parent := FFooterPanel;
  FInfoButton.Align := alRight;
  FInfoButton.AlignWithMargins := True;
  FInfoButton.Margins.SetBounds(0, 1, 4, 1);
  FInfoButton.Width := 36;
  FInfoButton.SpeedButtonOptions.Flat := True;
  FInfoButton.SpeedButtonOptions.Transparent := True;
  FInfoButton.SpeedButtonOptions.CanBeFocused := False;
  FInfoButton.Caption := 'Info';
  FInfoButton.Hint := 'Trasparenza AI (Reg. UE 2024/1689 AI Act e GDPR)';
  FInfoButton.ShowHint := True;
  FInfoButton.OnClick := InfoButtonClick;
end;

procedure TzChatAIPane.InfoButtonClick(Sender: TObject);
const
  CR = sLineBreak;
var
  InfoMsg: string;
begin
  InfoMsg := 'INFORMATIVA TRASPARENZA INTELLIGENZA ARTIFICIALE' + CR + CR + '1. Trasparenza (Regolamento UE 2024/1689 - AI Act, art. 50):' + CR + '   Le risposte di questa chat sono generate tramite modelli di intelligenza artificiale ' +
    'ed hanno carattere puramente consultivo e redazionale.' + CR + CR + '2. Sorveglianza umana (AI Act, art. 14):' + CR + '   L''assistente non adotta decisioni vincolanti ne'' emette atti amministrativi. ' +
    'L''approvazione delle ore, la convalida delle presenze e la conformita'' dei documenti ' + 'restano di esclusiva responsabilita'' dell''operatore umano.' + CR + CR + '3. Riservatezza (Regolamento UE 2016/679 - GDPR):' + CR +
    '   E'' vietata qualsiasi decisione automatizzata con effetti sfavorevoli per allievi o ' + 'personale (art. 22). I dati inviati seguono i livelli di mascheramento impostati dall''ente.';

  Application.MessageBox(PChar(InfoMsg), 'Informazioni Trasparenza AI', MB_OK or MB_ICONINFORMATION);
end;

procedure TzChatAIPane.ContextButtonClick(Sender: TObject);
begin
  FIncludeContext := not FIncludeContext;
  if FIncludeContext then
    FContextButton.Hint := 'Contesto scheda attiva: COLLEGATO'
  else
    FContextButton.Hint := 'Contesto scheda attiva: NON COLLEGATO';
end;

function TzChatAIPane.GetActiveFormContext: string;
var
  ActiveForm: TCustomForm;

begin
  result := '';
  if not FIncludeContext then
    Exit;

  ActiveForm := Screen.ActiveCustomForm;
  if (ActiveForm <> nil) and (ActiveForm <> Self.Owner) and (ActiveForm <> Self.Parent) then
  begin
    result := '[CONTESTO SCHEDA ATTIVA: ' + ActiveForm.Caption + ']' + sLineBreak;

    { HelpDescribeContext, non HelpDescribeForm: il secondo restituisce la
      RICHIESTA COMPLETA della guida, cioe' il descrittore preceduto dal
      modello di prompt che ordina di produrre la documentazione in JSON.
      Allegato a una domanda, l'assistente ubbidirebbe a quello invece che
      all'utente. }
    if Supports(ActiveForm, IHelpSubject) then
      try
        result := result + (ActiveForm as IHelpSubject).HelpDescribeContext + sLineBreak;
      except
        // Tolleranza: se la scheda solleva, non si blocca l'invio
      end;
  end;
end;

procedure TzChatAIPane.AggiornaPalette;
var
  Indice: Integer;
begin
  FPalette := TzChatPalette.Corrente;
  Style.Color := FPalette.Sfondo;

  if FFooterPanel <> nil then
    FFooterPanel.Style.Color := FPalette.Sfondo;

  if FDisclaimerLabel <> nil then
    FDisclaimerLabel.Style.TextColor := FPalette.Orario;

  for Indice := 0 to High(FHeaderButtons) do
    LoadSvgGlyph(FHeaderButtons[Indice], Format(FHeaderGlyphs[Indice], [zChatColorToHtml(FPalette.TestoAltrui)]));

  Invalidate;
end;

function TzChatAIPane.GetObject: TObject;
begin
  result := Self;
end;

procedure TzChatAIPane.MasterLookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
begin
  AggiornaPalette;
end;

procedure TzChatAIPane.MasterLookAndFeelDestroying(Sender: TcxLookAndFeel);
begin
  // IcxLookAndFeelNotificationListener
end;

procedure TzChatAIPane.BuildChat;
var
  OwnUser: TzChatUser;
  Models: TStringList;
begin
  FChat := TzChat.Create(Self);
  FChat.Parent := Self;
  FChat.Align := alClient;

  OwnUser := FChat.AddUser('utente', 'Tu');
  FChat.User := OwnUser;
  FAssistantUser := FChat.AddUser('assistente', FAI.AssistantName);

  Models := TStringList.Create;
  try
    FAI.ListModels(Models);
    FChat.Models := Models;
  finally
    Models.Free;
  end;

  { L'elenco statico appena assegnato resta come ripiego: se l'aggiornamento
    fallisce (rete, chiave), DoRefreshModels esce senza toccare FChat.Models. }
  DoRefreshModels(False);

  FChat.OnMessageEntered := ChatMessageEntered;
  FChat.Input.OnCancel := InputCancel;
  FChat.OnRefreshModels := RefreshModelsClick;

  FChat.AddMessage(FAssistantUser, FAI.WelcomeMessage);
end;

procedure TzChatAIPane.StateChanged(AOpen: Boolean);
begin
  inherited StateChanged(AOpen);
  if FToggleAction = nil then
    Exit;
  FToggleAction.Checked := AOpen;
  if AOpen and (FOpenedImageIndex >= 0) then
    FToggleAction.ImageIndex := FOpenedImageIndex;
  if not AOpen and (FClosedImageIndex >= 0) then
    FToggleAction.ImageIndex := FClosedImageIndex;
end;

procedure TzChatAIPane.ChatMessageEntered(Sender: TObject; const Text: string; Attachments: TStrings);
var
  ContextText: string;
begin
  ContextText := GetActiveFormContext;
  FAI.RequestResponse(Text, FChat.CurrentModel, FChat.Messages, ContextText);
  SaveCurrentSession;
end;

procedure TzChatAIPane.AIProcessingStart(Sender: TObject);
begin
  FChat.Input.Processing := True;
  FChat.SetTyping(FAssistantUser.Name, True);
  FCurrentInFlightMessage := nil;
end;

procedure TzChatAIPane.AIPartialResponse(Sender: TObject; const PartialText: string);
begin
  if FCurrentInFlightMessage = nil then
  begin
    FChat.SetTyping(FAssistantUser.Name, False);
    FCurrentInFlightMessage := FChat.AddMessage(FAssistantUser, PartialText);
  end
  else
  begin
    FCurrentInFlightMessage.Text := FCurrentInFlightMessage.Text + PartialText;
    FCurrentInFlightMessage.InvalidateMeasure;
    FChat.Scroller.ScrollToLastMessage;
  end;
end;

procedure TzChatAIPane.AIResponse(Sender: TObject; const Text: string);
begin
  FChat.Input.Processing := False;
  FChat.SetTyping(FAssistantUser.Name, False);

  if FCurrentInFlightMessage <> nil then
  begin
    FCurrentInFlightMessage.Text := Text;
    FCurrentInFlightMessage.InvalidateMeasure;
    FChat.Scroller.ScrollToLastMessage;
    FCurrentInFlightMessage := nil;
  end
  else
    FChat.AddMessage(FAssistantUser, Text);

  SaveCurrentSession;
end;

procedure TzChatAIPane.AIError(Sender: TObject; const ErrorMessage: string);
var
  ErrMsg: TzChatMessage;
begin
  FChat.Input.Processing := False;
  FChat.SetTyping(FAssistantUser.Name, False);
  FCurrentInFlightMessage := nil;

  ErrMsg := FChat.AddMessage(FAssistantUser, 'Errore servizio AI: ' + ErrorMessage);
  ErrMsg.Status := msError;
  SaveCurrentSession;
end;

{ Comando esplicito dal pulsante nel combo: qui l'operatore vuole sapere
  subito se l'aggiornamento e' riuscito, quindi l'errore si mostra. }
procedure TzChatAIPane.RefreshModelsClick(Sender: TObject);
begin
  DoRefreshModels(True);
end;

{ RefreshModels e' bloccante (interroga davvero il fornitore via HTTP), ma
  la creazione del pannello e' gia' pigra (nasce al primo clic su actAI, non
  all'avvio dell'applicazione): il breve fermo qui dentro e' lo stesso genere
  di attesa di un pannello che si apre, non un ritardo di avvio. Senza questa
  chiamata la tendina restava bloccata sull'elenco statico di ripiego di
  TzAIConfiguration.SuggestedModels, scritto una volta e mai piu' aggiornato. }
procedure TzChatAIPane.DoRefreshModels(const AShowErrors: Boolean);
var
  Models: TStringList;
begin
  Models := TStringList.Create;
  try
    Screen.Cursor := crHourGlass;
    try
      if not FAI.RefreshModels(Models) then
      begin
        if AShowErrors then
          MessageDlg('Impossibile aggiornare l''elenco dei modelli: ' + FAI.LastError,
            mtError, [mbOK], 0);
        Exit;
      end;
    finally
      Screen.Cursor := crDefault;
    end;

    FChat.Models := Models;
  finally
    Models.Free;
  end;
end;

procedure TzChatAIPane.InputCancel(Sender: TObject);
begin
  FAI.CancelRequest;
  FChat.Input.Processing := False;
  FChat.SetTyping(FAssistantUser.Name, False);
  if FCurrentInFlightMessage <> nil then
  begin
    FCurrentInFlightMessage.Text := FCurrentInFlightMessage.Text + sLineBreak + '[Interrotto dall''utente]';
    FCurrentInFlightMessage.InvalidateMeasure;
    FCurrentInFlightMessage := nil;
  end;
  SaveCurrentSession;
end;

procedure TzChatAIPane.SaveCurrentSession;
begin
  FSessionStore.SaveFromChat(FChat, FCurrentSessionId);
end;

procedure TzChatAIPane.ClearConversation;
begin
  FAI.CancelRequest;
  FChat.Input.Processing := False;
  FChat.SetTyping(FAssistantUser.Name, False);
  FCurrentInFlightMessage := nil;

  SaveCurrentSession;
  FCurrentSessionId := FSessionStore.NewSessionId;
  FChat.Clear;
  FChat.AddMessage(FAssistantUser, FAI.WelcomeMessage);
end;

procedure TzChatAIPane.HistoryButtonClick(Sender: TObject);
begin
  SaveCurrentSession;
  if FSessionsDropDown = nil then
  begin
    FSessionsDropDown := TzChatSessionsDropDown.Create(Self);
    FSessionsDropDown.Store := FSessionStore;
    FSessionsDropDown.OnSessionChosen := SessionChosen;
  end;
  FSessionsDropDown.ShowBelow(FHistoryButton, DROPDOWN_WIDTH);
end;

procedure TzChatAIPane.SessionChosen(Sender: TObject; const SessionId: string);
begin
  if FSessionStore.LoadIntoChat(FChat, SessionId) then
    FCurrentSessionId := SessionId;
end;

procedure TzChatAIPane.CloseButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TzChatAIPane.NewChatButtonClick(Sender: TObject);
begin
  ClearConversation;
end;

function TzChatAIPane.GetTitle: string;
begin
  result := FTitleLabel.Caption;
end;

procedure TzChatAIPane.SetTitle(const Value: string);
begin
  FTitleLabel.Caption := Value;
end;

end.
