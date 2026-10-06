unit zChatControl;

{ TzChat: il controllo chat, equivalente VCL del dxChat DevExtreme.
  Compone: TzChatVirtualScroller (area messaggi) + splitter + indicatore
  di digitazione + TzChatInputPanel (input in basso).

  Mappatura sull'API dxChat:
    - User             ~ user            (bolle a destra)
    - Users            ~ collezione dei partecipanti (owner dei TzChatUser)
    - Messages         ~ items
    - AddMessage       ~ renderMessage
    - OnMessageEntered ~ onMessageEntered
    - SetTyping        ~ typingUsers
    - Clear            ~ pulsante "clear chat" dell'AIChatControl WinForms

  Flusso di invio: input.OnSend -> il messaggio dell'utente corrente viene
  aggiunto alla vista -> OnMessageEntered notifica il consumatore, che
  inoltra la domanda al servizio AI e aggiunge la risposta. }

interface

uses
  System.SysUtils, System.Classes, System.Types,
  Vcl.Controls, Vcl.Graphics,
  cxControls, cxContainer, cxGraphics, cxSplitter, cxLookAndFeels,
  zChatTypes, zChatScroller, zChatRenderer, zChatInput;

type
  { IcxLookAndFeelNotificationListener: e' TzChat, che possiede tutte le
    parti, a iscriversi ai cambi di skin. Un solo ascoltatore invece di uno
    per controllo: alla notifica ridistribuisce la tavolozza a scroller,
    riquadro di scrittura, divisore e disegnatore delle bolle. }
  TzChat = class(TcxControl, IcxLookAndFeelNotificationListener)
  private
    FScroller: TzChatVirtualScroller;
    FInputSplitter: TcxSplitter;
    FInput: TzChatInputPanel;
    FMessages: TzChatMessageCollection;
    FUsers: TzChatUsers;
    FUser: TzChatUser;                    // utente corrente (~ dxChat user)
    FRenderer: IzChatMessageRenderer;     // condiviso tra tutti gli item
    { Lo stesso disegnatore, per tipo: serve a passargli i colori della skin,
      cosa che l'interfaccia non prevede. Vale solo finche' e' quello creato
      qui: se il chiamante ne assegna un altro, il riferimento si azzera. }
    FBubbleRenderer: TzChatBubbleTextRenderer;
    FPalette: TzChatPalette;              // colori della skin attiva
    FConversationFont: TFont;
    FOnModelChanged: TNotifyEvent;
    FOnMessageEntered: TzChatSendEvent;
    FOnRefreshModels: TNotifyEvent;
    procedure InputSend(Sender: TObject; const Text: string;
      Attachments: TStrings);
    procedure InputModelChanged(Sender: TObject);
    procedure InputRefreshModels(Sender: TObject);
    procedure ConversationFontChanged(Sender: TObject);
    procedure ApplyScrollerFont;
    procedure SetUser(const Value: TzChatUser);
    procedure SetConversationFont(const Value: TFont);
    procedure SetModels(const Value: TStrings);
    function GetModels: TStrings;
    function GetCurrentModel: string;
    procedure SetRenderer(const Value: IzChatMessageRenderer);
    procedure AggiornaPalette;
  protected
    { --- IcxLookAndFeelNotificationListener --- }
    function GetObject: TObject;
    procedure MasterLookAndFeelChanged(Sender: TcxLookAndFeel;
      AChangedValues: TcxLookAndFeelValues);
    procedure MasterLookAndFeelDestroying(Sender: TcxLookAndFeel);
  protected
    { TcxControl non disegna lo sfondo: senza questo riempimento le zone
      non coperte da un figlio opaco (lo splitter) restano nere. }
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Crea un partecipante e lo aggiunge alla collezione posseduta. }
    function AddUser(const AId, AName: string;
      AColor: TColor = clNone): TzChatUser;
    { Aggiunge un messaggio alla conversazione (~ renderMessage). }
    function AddMessage(Author: TzChatUser; const Text: string;
      Attachments: TStrings = nil): TzChatMessage;
    { Aggiunge un messaggio dell'utente corrente. }
    function AddOwnMessage(const Text: string;
      Attachments: TStrings = nil): TzChatMessage;
    { Mostra/nasconde l'indicatore "sta scrivendo" (~ typingUsers). }
    procedure SetTyping(const UserName: string; Active: Boolean);
    { Rimuove tutti i messaggi dalla conversazione. }
    procedure Clear;
    property Messages: TzChatMessageCollection read FMessages;
    property Users: TzChatUsers read FUsers;
    { Utente corrente: i suoi messaggi appaiono a destra. }
    property User: TzChatUser read FUser write SetUser;
    property Renderer: IzChatMessageRenderer read FRenderer write SetRenderer;
    property ConversationFont: TFont
      read FConversationFont write SetConversationFont;
    { Modelli AI selezionabili e modello scelto (delegati all'input). }
    property Models: TStrings read GetModels write SetModels;
    property CurrentModel: string read GetCurrentModel;
    property OnModelChanged: TNotifyEvent
      read FOnModelChanged write FOnModelChanged;
    { Scatta quando l'operatore preme il pulsante di aggiornamento dentro il
      combo modello: chi ospita il controllo scarica il vero elenco dal
      fornitore (bloccante) e lo riassegna a Models. }
    property OnRefreshModels: TNotifyEvent
      read FOnRefreshModels write FOnRefreshModels;
    { Scatta dopo che l'utente ha inviato un messaggio (testo+allegati gia'
      in vista): il consumatore lo usa per generare la risposta
      (~ onMessageEntered di dxChat). }
    property OnMessageEntered: TzChatSendEvent
      read FOnMessageEntered write FOnMessageEntered;
    property Scroller: TzChatVirtualScroller read FScroller;
    property Input: TzChatInputPanel read FInput;
  end;

implementation

const
  INPUT_HEIGHT = 76;

{ TzChat }

constructor TzChat.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  { Lo sfondo lo dipinge Paint (TcxControl non lo fa da se'). Il colore lo
    detta la skin: clWindow, che c'era prima, e' un colore di SISTEMA e le
    skin DevExpress non lo toccano — con una skin scura la chat restava un
    rettangolo bianco. }
  FPalette := TzChatPalette.Corrente;

  { Iscrizione ai cambi di skin: senza, i colori sarebbero giusti all'avvio
    e sbagliati dal primo cambio in poi. }
  RootLookAndFeel.AddChangeListener(Self);

  FMessages := TzChatMessageCollection.Create(Self, TzChatMessage);
  FUsers := TzChatUsers.Create(Self, TzChatUser);
  FBubbleRenderer := TzChatBubbleTextRenderer.Create;
  FRenderer := FBubbleRenderer;   // refcounted via interfaccia

  FConversationFont := TFont.Create;
  FConversationFont.Name := 'Segoe UI';
  FConversationFont.Size := 10;
  FConversationFont.OnChange := ConversationFontChanged;

  { Scroller: occupa il client sopra l'input. }
  FScroller := TzChatVirtualScroller.Create(Self);
  FScroller.Parent := Self;
  FScroller.Align := alClient;
  FScroller.Messages := FMessages;

  { Input in basso. }
  FInput := TzChatInputPanel.Create(Self);
  FInput.Parent := Self;
  FInput.Align := alBottom;
  FInput.Height := INPUT_HEIGHT;
  FInput.OnSend := InputSend;
  FInput.OnModelChanged := InputModelChanged;
  FInput.OnRefreshModels := InputRefreshModels;

  { Splitter sopra l'input: consente all'utente di stirare l'area di
    inserimento. Il binding esplicito via Control lo lega all'input
    anche quando fra i due si inseriscono altri controlli. }
  FInputSplitter := TcxSplitter.Create(Self);
  FInputSplitter.Parent := Self;
  FInputSplitter.AlignSplitter := salBottom;
  FInputSplitter.Control := FInput;
  FInputSplitter.Height := 5;
  { NativeBackground disegnerebbe lo sfondo del genitore, che TcxControl
    lascia vuoto: si passa al colore proprio. }
  FInputSplitter.NativeBackground := False;
  FInputSplitter.Color := FPalette.Sfondo;
  FInputSplitter.AutoSnap := False;
  FInputSplitter.MinSize := INPUT_HEIGHT;
  FInputSplitter.ResizeUpdate := True;

  ApplyScrollerFont;
  AggiornaPalette;
end;

destructor TzChat.Destroy;
begin
  RootLookAndFeel.RemoveChangeListener(Self);
  FConversationFont.Free;
  FUsers.Free;
  FMessages.Free;
  FBubbleRenderer := nil;
  FRenderer := nil;   // rilascio esplicito dell'interfaccia
  inherited Destroy;
end;

procedure TzChat.Paint;
begin
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := FPalette.Sfondo;
  Canvas.FillRect(ClientRect);
end;

{ Sostituendo il disegnatore si perde quello di casa: da quel momento i
  colori della skin non lo riguardano piu'. }
procedure TzChat.SetRenderer(const Value: IzChatMessageRenderer);
begin
  if FRenderer = Value then
    exit;

  FBubbleRenderer := nil;
  FRenderer := Value;
  FMessages.InvalidateMeasures;

  if FScroller <> nil then
    FScroller.InvalidateContent;
end;

{ Ridistribuisce i colori della skin attiva a tutte le parti. Il disegnatore
  delle bolle non e' un componente e non riceve notifiche: gliele passa qui
  chi lo possiede. }
procedure TzChat.AggiornaPalette;
begin
  FPalette := TzChatPalette.Corrente;

  if HandleAllocated then
    Color := FPalette.Sfondo;

  if FScroller <> nil then
    FScroller.AggiornaPalette;

  if FInput <> nil then
    FInput.AggiornaPalette;

  if FInputSplitter <> nil then
    FInputSplitter.Color := FPalette.Sfondo;

  { Il disegnatore delle bolle: solo se e' ancora il nostro. Uno messo da
    fuori si arrangia da se' — non e' un difetto, e' una scelta di chi
    l'ha sostituito. }
  if FBubbleRenderer <> nil then
    FBubbleRenderer.AggiornaPalette;

  if HandleAllocated then
    Invalidate;
end;

function TzChat.GetObject: TObject;
begin
  // IcxLookAndFeelNotificationListener
  Result := Self;
end;

procedure TzChat.MasterLookAndFeelChanged(Sender: TcxLookAndFeel;
  AChangedValues: TcxLookAndFeelValues);
begin
  // IcxLookAndFeelNotificationListener: qui passa il cambio di skin
  AggiornaPalette;
end;

procedure TzChat.MasterLookAndFeelDestroying(Sender: TcxLookAndFeel);
begin
  // IcxLookAndFeelNotificationListener
end;

procedure TzChat.ApplyScrollerFont;
begin
  { Lo scroller possiede il proprio font di misura e lo applica al canvas
    attivo prima di misurare e disegnare: cosi' altezza cachata e rendering
    combaciano, anche prima che la window abbia un handle. }
  if FScroller <> nil then
    FScroller.MeasureFont := FConversationFont;
end;

procedure TzChat.ConversationFontChanged(Sender: TObject);
begin
  ApplyScrollerFont;
end;

procedure TzChat.SetConversationFont(const Value: TFont);
begin
  FConversationFont.Assign(Value);
  // OnChange scatena ApplyScrollerFont
end;

procedure TzChat.SetUser(const Value: TzChatUser);
begin
  FUser := Value;
  FScroller.CurrentUser := Value;   // determina il lato delle bolle
end;

function TzChat.AddUser(const AId, AName: string;
  AColor: TColor): TzChatUser;
begin
  Result := FUsers.Add(AId, AName, AColor);
end;

function TzChat.AddMessage(Author: TzChatUser;
  const Text: string; Attachments: TStrings): TzChatMessage;
var
  Index: Integer;
begin
  Result := FMessages.Add;
  Result.Text := Text;
  Result.Author := Author;
  Result.Renderer := FRenderer;   // renderer condiviso
  { Propaga eventuali allegati: ogni percorso diventa un TzChatAttachment. }
  if Attachments <> nil then
    for Index := 0 to Attachments.Count - 1 do
      Result.Attachments.Add(Attachments[Index]);
  { Forza rimisura + repaint: il nuovo messaggio appare subito. Se e'
    piu' alto della viewport viene allineato in cima invece che in fondo,
    cosi' una risposta lunga si legge dalla prima riga. }
  FScroller.ScrollToLastMessage;
end;

function TzChat.AddOwnMessage(const Text: string;
  Attachments: TStrings): TzChatMessage;
begin
  Result := AddMessage(FUser, Text, Attachments);
end;

procedure TzChat.SetTyping(const UserName: string; Active: Boolean);
begin
  { Il segnaposto vive nel flusso dei messaggi, in coda alla
    conversazione: se ne occupa lo scroller. UserName non serve piu' —
    resta nella firma per non toccare i chiamanti — ma diventa il
    suggerimento del segnaposto. }
  FScroller.TypingIndicator.Hint := UserName;
  FScroller.SetTyping(Active);
end;

procedure TzChat.Clear;
begin
  { La selezione va azzerata prima: dopo il Clear i suoi indici
    punterebbero a messaggi non piu' esistenti. }
  FScroller.ClearSelection;
  FMessages.Clear;
  FScroller.InvalidateContent;
end;

procedure TzChat.InputSend(Sender: TObject; const Text: string;
  Attachments: TStrings);
begin
  AddOwnMessage(Text, Attachments);
  if Assigned(FOnMessageEntered) then
    FOnMessageEntered(Self, Text, Attachments);
end;

procedure TzChat.InputModelChanged(Sender: TObject);
begin
  if Assigned(FOnModelChanged) then
    FOnModelChanged(Self);
end;

procedure TzChat.InputRefreshModels(Sender: TObject);
begin
  if Assigned(FOnRefreshModels) then
    FOnRefreshModels(Self);
end;

procedure TzChat.SetModels(const Value: TStrings);
begin
  FInput.Models := Value;
end;

function TzChat.GetModels: TStrings;
begin
  Result := FInput.Models;
end;

function TzChat.GetCurrentModel: string;
begin
  Result := FInput.CurrentModel;
end;

end.
