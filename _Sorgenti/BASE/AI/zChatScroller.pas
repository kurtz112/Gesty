unit zChatScroller;

{ Scroller virtualizzato per TzChat.
  Disegna solo le bolle nella finestra visibile, delegando measure/draw
  all'interfaccia IzChatMessageRenderer di ciascun item.
  L'altezza calcolata viene cachata sull'item e invalidata su resize. }

interface

uses
  System.SysUtils, System.Classes, System.Types, System.Math,
  Winapi.Windows, Winapi.Messages,
  Vcl.Controls, Vcl.Graphics, Vcl.Forms, Vcl.Menus, Vcl.Clipbrd,
  Vcl.StdCtrls,
  cxGraphics, cxControls, cxContainer, cxClasses, cxScrollBar,
  cxLookAndFeels, cxLookAndFeelPainters, dxActivityIndicator,
  zChatTypes;

const
  VERTICAL_MARGIN = 6;    // spazio tra bolle
  SIDE_MARGIN = 12;       // rientro della bolla dal bordo
  WIDTH_FRACTION = 0.72;  // larghezza max bolla come frazione della viewport
  LINE_STEP = 24;         // px per riga di scroll (frecce/rotellina)
  TYPING_WIDTH = 56;      // segnaposto "sto rispondendo": larghezza
  TYPING_HEIGHT = 26;     // segnaposto "sto rispondendo": altezza
  SELECTION_TINT = 22;    // % del colore di selezione nella tinta di fondo
  SELECTION_BAR_WIDTH = 3; // barretta verticale sul bordo sinistro
  SCROLLBAR_WIDTH = 15;   // larghezza della barra verticale (scalata per DPI)

type
  { Descrittore di layout calcolato per un item: posizione verticale
    assoluta nel documento virtuale e altezza cachata. }
  TzChatItemLayout = record
    Top: Integer;
    Height: Integer;
  end;

  { Scroller a documento virtuale.

    Lo scorrimento e' interamente nostro: FScrollOffset e' la posizione in
    pixel di documento, e FScrollBar (un TcxScrollBar figlio, allineato a
    destra) la rispecchia. Le scrollbar interne di TcxControl non vengono
    usate: la loro comparsa dipende da meccanismi interni che qui non si
    innescavano mai, lasciando il contenuto piu' alto della viewport
    senza alcun modo di essere scorso. }
  TzChatVirtualScroller = class(TcxScrollingControl)
  private
    FMessages: TzChatMessageCollection;
    FCurrentUser: TzChatUser;    // le sue bolle vanno a destra
    FLayout: array of TzChatItemLayout;
    FTotalHeight: Integer;
    FMeasuredWidth: Integer;     // larghezza usata nell'ultimo ricalcolo
    FMeasureFont: TFont;         // font con cui si misura e si disegna
    FPendingScrollToBottom: Boolean; // scroll in fondo richiesto prima dell'handle
    FSelStart: Integer;          // indice primo messaggio selezionato (-1 = nessuno)
    FSelEnd: Integer;            // indice ultimo messaggio selezionato
    FSelecting: Boolean;         // True durante il trascinamento
    FMenu: TPopupMenu;           // menu contestuale (copia)
    FTypingIndicator: TdxActivityIndicator; // segnaposto della risposta in arrivo
    FTypingActive: Boolean;
    FContentHeight: Integer;     // altezza dei soli messaggi, senza segnaposto
    FRemeasuring: Boolean;       // guardia contro il rientro in RecalcLayout
    FScrollOffset: Integer;      // posizione verticale, in pixel di documento
    FUpdatingScrollBar: Boolean; // guardia: stiamo riflettendo l'offset sulla barra
    FScrollBar: TcxScrollBar;    // barra verticale nostra, non quella di cx
    FPalette: TzChatPalette;     // colori della skin attiva
    { Larghezza utile per le bolle: il client meno la barra, quando c'e'. }
    function ContentWidth: Integer;
    { Allinea range, pagina, posizione e visibilita' della barra al layout. }
    procedure UpdateScrollBar;
    procedure ScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    { Porta il segnaposto dove cadrebbe la bolla successiva: scorre col
      contenuto, come nelle chat dei fornitori AI. }
    procedure UpdateTypingBounds;
    function TypingReserve: Integer;
    procedure SetMessages(const Value: TzChatMessageCollection);
    procedure SetCurrentUser(const Value: TzChatUser);
    procedure SetMeasureFont(const Value: TFont);
    { True se il messaggio appartiene all'utente corrente (bolla a destra). }
    function IsOwnMessage(Item: TzChatMessage): Boolean;
    function MaxBubbleWidth: Integer;
    function MaxScrollOffset: Integer;
    function GetScrollOffset: Integer;
    { Applica FMeasureFont al canvas attivo prima di misurare/disegnare. }
    procedure ApplyMeasureFont;
    { Indice del messaggio sotto la coordinata Y-viewport (o -1). }
    function ItemAtY(ViewportY: Integer): Integer;
    { True se l'indice ricade nel range selezionato corrente. }
    function IsItemSelected(Index: Integer): Boolean;
    procedure CopySelection(Sender: TObject);
    procedure CopyMessageAtCursor(Sender: TObject);
  protected
    procedure CreateWnd; override;
    procedure Resize; override;
    procedure Paint; override;
    { Selezione via mouse: down avvia, move estende, up chiude. }
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    { La rotellina arriva come WM_MOUSEWHEEL; la barra verticale ci
      chiama invece con il proprio OnScroll. }
    function DoMouseWheelDown(Shift: TShiftState;
      MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState;
      MousePos: TPoint): Boolean; override;
    { Imposta la posizione verticale (clampata) e ridisegna. }
    procedure SetOffset(Value: Integer);
    { Invalidate solo se l'handle esiste: su TcxControl un Invalidate
      senza handle forza CreateWnd, che fallisce se manca il parent. }
    procedure SafeInvalidate;
    { Ricalcola il layout verticale usando la cache d'altezza degli item.
      ForceMeasure=True ignora la cache (es. dopo cambio larghezza/font). }
    procedure RecalcLayout(ForceMeasure: Boolean);
    { Indici primo/ultimo item visibili nella viewport corrente. }
    procedure VisibleRange(out First, Last: Integer);
    function MeasureItem(Item: TzChatMessage): Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InvalidateContent;   // forza ricalcolo completo + repaint
    procedure ScrollToBottom;      // porta lo scroll in fondo al documento
    { Porta in vista l'ultimo messaggio: se e' piu' alto della viewport
      ne allinea l'inizio in cima, altrimenti scorre in fondo come
      ScrollToBottom. E' quello che serve dopo un nuovo messaggio: una
      risposta lunga si legge dalla prima riga, non dall'ultima. }
    procedure ScrollToLastMessage;
    { Rinfresca i colori dalla skin attiva. La chiama TzChat, che e' iscritto
      alle notifiche di cambio skin. }
    procedure AggiornaPalette;
    procedure ClearSelection;      // annulla la selezione corrente
    { Mostra/nasconde il segnaposto animato in coda alla conversazione. }
    procedure SetTyping(Active: Boolean);
    { Segnaposto della risposta in arrivo: esposto per personalizzarne
      aspetto, dimensione dei punti e durata dell'animazione. }
    property TypingIndicator: TdxActivityIndicator read FTypingIndicator;
    property Messages: TzChatMessageCollection
      read FMessages write SetMessages;
    { Utente corrente del controllo: determina il lato delle bolle
      (come in dxChat: author = chat.user -> destra). }
    property CurrentUser: TzChatUser read FCurrentUser write SetCurrentUser;
    { Font di conversazione: impostato dal contenitore. Misura e disegno
      usano questo font, cosi' altezza cachata e rendering combaciano. }
    property MeasureFont: TFont read FMeasureFont write SetMeasureFont;
    { Offset verticale corrente = posizione scrollbar verticale (sola lettura). }
    property ScrollOffset: Integer read GetScrollOffset;
    property TotalHeight: Integer read FTotalHeight;
  end;

implementation

{ Miscela due colori: Percent e' la quota del primo. Fatta a mano per non
  dipendere dagli helper di colore delle varie versioni DevExpress. }
{ La mescolanza dei colori sta ora in zChatTypes, accanto alla tavolozza:
  la usano anche il renderer e il riquadro di scrittura. }

{ TzChatVirtualScroller }

constructor TzChatVirtualScroller.Create(AOwner: TComponent);
var
  MenuItem: TMenuItem;
begin
  inherited Create(AOwner);
  AggiornaPalette;
  FMeasuredWidth := -1;
  FMeasureFont := TFont.Create;
  FSelStart := -1;
  FSelEnd := -1;
  TabStop := True;   // necessario per ricevere Ctrl+C

  { Menu contestuale con copia selezione e copia singolo messaggio. }
  FMenu := TPopupMenu.Create(Self);
  MenuItem := TMenuItem.Create(FMenu);
  MenuItem.Caption := 'Copia selezione';
  MenuItem.OnClick := CopySelection;
  FMenu.Items.Add(MenuItem);
  MenuItem := TMenuItem.Create(FMenu);
  MenuItem.Caption := 'Copia questo messaggio';
  MenuItem.OnClick := CopyMessageAtCursor;
  FMenu.Items.Add(MenuItem);
  PopupMenu := FMenu;

  { Segnaposto della risposta in arrivo: sta nel flusso dei messaggi, al
    posto della bolla che sta per comparire. E' un controllo, non una
    bolla disegnata: viene spostato dal layout invece che dal renderer. }
  { La barra verticale la gestiamo noi, come controllo figlio. Qui viene
    solo creata e configurata: Parent e Align si assegnano in CreateWnd,
    perche' allineare un figlio costringe il genitore a riallinearsi, e
    in fase di costruzione la catena di finestre non esiste ancora
    (TzChat non ha ancora un parent). }
  FScrollBar := TcxScrollBar.Create(Self);
  FScrollBar.Kind := sbVertical;
  FScrollBar.Visible := False;
  FScrollBar.SmallChange := LINE_STEP;
  FScrollBar.OnScroll := ScrollBarScroll;

  FTypingIndicator := TdxActivityIndicator.Create(Self);
  FTypingIndicator.Parent := Self;
  FTypingIndicator.Transparent := True;
  FTypingIndicator.Visible := False;
  FTypingIndicator.ShowHint := True;
  FTypingIndicator.PropertiesClassName := 'TdxActivityIndicatorHorizontalDotsProperties';
  with FTypingIndicator.Properties as TdxActivityIndicatorDotBasedProperties do
  begin
    DotCount := 3;
    DotSize := 5;
    AnimationTime := 1400;
  end;
end;

destructor TzChatVirtualScroller.Destroy;
begin
  FMeasureFont.Free;
  inherited Destroy;
end;

procedure TzChatVirtualScroller.SetMeasureFont(const Value: TFont);
begin
  FMeasureFont.Assign(Value);
  InvalidateContent;   // il wrap/altezze dipendono dal font: rimisura tutto
end;

procedure TzChatVirtualScroller.ApplyMeasureFont;
begin
  { Chiamato solo da RecalcLayout, che esce se manca l'handle:
    qui ActiveCanvas e' quindi sempre valido. }
  ActiveCanvas.Font.Assign(FMeasureFont);
end;

procedure TzChatVirtualScroller.CreateWnd;
begin
  inherited CreateWnd;
  { Ora l'handle esiste: si assegna il colore di fondo della skin, si
    aggancia la barra verticale, si esegue il primo layout reale (con
    misura sul canvas) e si aggiorna la barra. Tutto cio' era stato
    saltato durante la costruzione. }
  Color := FPalette.Sfondo;

  if FScrollBar.Parent = nil then
  begin
    { Le scrollbar interne di TcxControl restano fuori gioco. }
    ScrollBars := ssNone;
    FScrollBar.Parent := Self;
    FScrollBar.Align := alRight;
    FScrollBar.Width := SCROLLBAR_WIDTH;
  end;
  RecalcLayout(True);
  UpdateScrollBar;
  if FPendingScrollToBottom then
  begin
    FPendingScrollToBottom := False;
    ScrollToLastMessage;
  end;
end;

function TzChatVirtualScroller.GetScrollOffset: Integer;
begin
  { L'offset e' nostro, non della scrollbar: la barra lo rispecchia, non
    lo custodisce. Tenerlo dentro la posizione della barra significava
    perdere la possibilita' di scorrere ogni volta che la barra non era
    visibile o non era ancora configurata. }
  Result := FScrollOffset;
end;

procedure TzChatVirtualScroller.SetMessages(
  const Value: TzChatMessageCollection);
begin
  FMessages := Value;
  InvalidateContent;
end;

procedure TzChatVirtualScroller.SetCurrentUser(const Value: TzChatUser);
begin
  if FCurrentUser <> Value then
  begin
    FCurrentUser := Value;
    SafeInvalidate;   // cambia solo l'allineamento, le misure restano valide
  end;
end;

function TzChatVirtualScroller.IsOwnMessage(Item: TzChatMessage): Boolean;
begin
  Result := (Item.Author <> nil) and (Item.Author = FCurrentUser);
end;

function TzChatVirtualScroller.ContentWidth: Integer;
begin
  { La barra e' allineata a destra ma non riduce ClientWidth: lo spazio
    che occupa va tolto a mano, o le bolle finiscono sotto di essa e il
    wrap viene calcolato su una larghezza che non c'e'. }
  Result := ClientWidth;
  if (FScrollBar <> nil) and (FScrollBar.Parent <> nil) and FScrollBar.Visible then
    Dec(Result, FScrollBar.Width);
  if Result < 1 then
    Result := 1;
end;

function TzChatVirtualScroller.MaxBubbleWidth: Integer;
begin
  Result := Round((ContentWidth - 2 * SIDE_MARGIN) * WIDTH_FRACTION);
  if Result < 40 then
    Result := 40;
end;

function TzChatVirtualScroller.MeasureItem(Item: TzChatMessage): Integer;
var
  Size: TSize;
begin
  { Cache: -1 significa da ricalcolare. Il renderer misura il contenuto
    entro la larghezza massima consentita per la bolla. }
  if Item.CachedHeight >= 0 then
    Exit(Item.CachedHeight);

  if Item.Renderer = nil then
    Size.cy := 0
  else
    Size := Item.Renderer.MeasureBubble(ActiveCanvas, MaxBubbleWidth, Item);

  Item.CachedHeight := Size.cy;
  Result := Size.cy;
end;

procedure TzChatVirtualScroller.RecalcLayout(ForceMeasure: Boolean);
var
  Index, Current: Integer;
begin
  { Senza handle non si puo' misurare: qualsiasi accesso al canvas cx
    (ActiveCanvas) forza CreateWnd, che fallisce se manca il parent.
    Il layout viene calcolato al primo CreateWnd. }
  if not HandleAllocated then
    Exit;

  if FMessages = nil then
  begin
    SetLength(FLayout, 0);
    FContentHeight := VERTICAL_MARGIN;
    FTotalHeight := FContentHeight + TypingReserve;
    UpdateTypingBounds;
    Exit;
  end;

  { Se la larghezza e' cambiata la cache non e' piu' valida: le bolle
    vanno rimisurate perche' il wrap del testo dipende dalla larghezza. }
  if ForceMeasure or (FMeasuredWidth <> ContentWidth) then
  begin
    FMessages.InvalidateMeasures;
    FMeasuredWidth := ContentWidth;
  end;

  SetLength(FLayout, FMessages.Count);
  ApplyMeasureFont;   // font coerente per tutte le misure di questo giro
  Current := VERTICAL_MARGIN;
  for Index := 0 to FMessages.Count - 1 do
  begin
    FLayout[Index].Top := Current;
    FLayout[Index].Height := MeasureItem(FMessages[Index]);
    Inc(Current, FLayout[Index].Height + VERTICAL_MARGIN);
  end;
  FContentHeight := Current;
  { Lo spazio del segnaposto entra nell'altezza del documento: cosi'
    l'ultima bolla resta scorribile sopra di esso e non ci finisce sotto. }
  FTotalHeight := Current + TypingReserve;
  { Se il contenuto si e' accorciato l'offset puo' essere finito oltre il
    nuovo fondo: si riporta nel range prima di pubblicare la barra. }
  FScrollOffset := EnsureRange(FScrollOffset, 0, MaxScrollOffset);
  UpdateScrollBar;

  { La comparsa (o la sparizione) della scrollbar verticale cambia
    la larghezza utile: le bolle misurate un attimo fa sono calcolate su
    una larghezza che non esiste piu', il testo va a capo piu' volte e
    l'ultimo messaggio risulta tagliato. Si rimisura una volta sola:
    la guardia impedisce l'oscillazione fra i due stati. }
  if (ContentWidth <> FMeasuredWidth) and not FRemeasuring then
  begin
    FRemeasuring := True;
    try
      RecalcLayout(True);
    finally
      FRemeasuring := False;
    end;
    Exit;
  end;

  UpdateTypingBounds;
end;

procedure TzChatVirtualScroller.VisibleRange(out First, Last: Integer);
var
  Index, Top, Bottom: Integer;
begin
  First := -1;
  Last := -1;
  Top := ScrollOffset;
  Bottom := ScrollOffset + ClientHeight;

  for Index := 0 to High(FLayout) do
  begin
    if FLayout[Index].Top + FLayout[Index].Height < Top then
      Continue;              // interamente sopra la viewport
    if FLayout[Index].Top > Bottom then
      Break;                 // interamente sotto: gli altri seguono
    if First < 0 then
      First := Index;
    Last := Index;
  end;
end;

function TzChatVirtualScroller.ItemAtY(ViewportY: Integer): Integer;
var
  Index, DocY: Integer;
begin
  { Converte la Y-viewport in Y-documento e cerca l'item che la contiene. }
  Result := -1;
  DocY := ViewportY + ScrollOffset;
  for Index := 0 to High(FLayout) do
    if (DocY >= FLayout[Index].Top)
      and (DocY < FLayout[Index].Top + FLayout[Index].Height) then
      Exit(Index);
end;

function TzChatVirtualScroller.IsItemSelected(Index: Integer): Boolean;
begin
  Result := (FSelStart >= 0)
    and (Index >= Min(FSelStart, FSelEnd))
    and (Index <= Max(FSelStart, FSelEnd));
end;

procedure TzChatVirtualScroller.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  Index: Integer;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if CanFocus then
    SetFocus;   // per ricevere Ctrl+C
  if Button = mbLeft then
  begin
    Index := ItemAtY(Y);
    FSelStart := Index;
    FSelEnd := Index;
    FSelecting := Index >= 0;
    SafeInvalidate;
  end;
end;

procedure TzChatVirtualScroller.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Index: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  if FSelecting then
  begin
    Index := ItemAtY(Y);
    if Index >= 0 then
    begin
      FSelEnd := Index;
      SafeInvalidate;
    end;
  end;
end;

procedure TzChatVirtualScroller.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if Button = mbLeft then
    FSelecting := False;
end;

procedure TzChatVirtualScroller.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  { Ctrl+C copia la selezione corrente. }
  if (Key = Ord('C')) and (ssCtrl in Shift) then
    CopySelection(Self);
end;

procedure TzChatVirtualScroller.CopySelection(Sender: TObject);
var
  Index: Integer;
  Text: string;
begin
  if (FSelStart < 0) or (FMessages = nil) then
    Exit;
  Text := '';
  for Index := Min(FSelStart, FSelEnd) to Max(FSelStart, FSelEnd) do
  begin
    if Text <> '' then
      Text := Text + sLineBreak + sLineBreak;
    if FMessages[Index].Author <> nil then
      Text := Text + FMessages[Index].Author.Name + ': ';
    Text := Text + FMessages[Index].Text;
  end;
  if Text <> '' then
    Clipboard.AsText := Text;
end;

procedure TzChatVirtualScroller.CopyMessageAtCursor(Sender: TObject);
var
  P: TPoint;
  Index: Integer;
begin
  { Copia il singolo messaggio sotto il puntatore (posizione del click destro). }
  P := ScreenToClient(Mouse.CursorPos);
  Index := ItemAtY(P.Y);
  if (Index >= 0) and (FMessages <> nil) then
    Clipboard.AsText := FMessages[Index].Text;
end;

function TzChatVirtualScroller.MaxScrollOffset: Integer;
begin
  Result := Max(0, FTotalHeight - ClientHeight);
end;

procedure TzChatVirtualScroller.SafeInvalidate;
begin
  { Su TcxControl Invalidate senza handle innesca CreateWnd -> eccezione
    se non c'e' parent. Rimandiamo: al primo Paint il contenuto e' fresco. }
  if HandleAllocated then
    Invalidate;
end;

procedure TzChatVirtualScroller.UpdateScrollBar;
var
  NeedScrollBar: Boolean;
begin
  { Senza handle la barra non e' ancora agganciata: si aggiornera' al
    primo CreateWnd. }
  if (FScrollBar = nil) or (FScrollBar.Parent = nil) or not HandleAllocated then
    Exit;

  NeedScrollBar := FTotalHeight > ClientHeight;
  FUpdatingScrollBar := True;
  try
    if FScrollBar.Visible <> NeedScrollBar then
      FScrollBar.Visible := NeedScrollBar;
    if NeedScrollBar then
      { AMin, AMax, APosition, APageSize: la posizione massima
        raggiungibile e' AMax - APageSize + 1, cioe' MaxScrollOffset. }
      FScrollBar.SetScrollParams(0, Max(0, FTotalHeight - 1),
        EnsureRange(FScrollOffset, 0, MaxScrollOffset), ClientHeight, True);
  finally
    FUpdatingScrollBar := False;
  end;
end;

procedure TzChatVirtualScroller.ScrollBarScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
var
  NewOffset: Integer;
begin
  NewOffset := FScrollOffset;
  case ScrollCode of
    scLineUp:   Dec(NewOffset, LINE_STEP);
    scLineDown: Inc(NewOffset, LINE_STEP);
    scPageUp:   Dec(NewOffset, ClientHeight);
    scPageDown: Inc(NewOffset, ClientHeight);
    scPosition, scTrack: NewOffset := ScrollPos;
    scTop:      NewOffset := 0;
    scBottom:   NewOffset := MaxScrollOffset;
    scEndScroll: Exit;
  end;
  NewOffset := EnsureRange(NewOffset, 0, MaxScrollOffset);
  ScrollPos := NewOffset;   // la barra si posiziona dove siamo andati davvero
  SetOffset(NewOffset);
end;

procedure TzChatVirtualScroller.SetOffset(Value: Integer);
begin
  Value := EnsureRange(Value, 0, MaxScrollOffset);
  if Value = FScrollOffset then
    Exit;

  FScrollOffset := Value;
  { La barra rispecchia l'offset, non lo custodisce: si aggiorna solo se
    e' visibile, e lo scorrimento funziona comunque anche senza. }
  if (FScrollBar <> nil) and (FScrollBar.Parent <> nil) and
    FScrollBar.Visible and not FUpdatingScrollBar then
  begin
    FUpdatingScrollBar := True;
    try
      FScrollBar.Position := FScrollOffset;
    finally
      FUpdatingScrollBar := False;
    end;
  end;
  UpdateTypingBounds;   // il segnaposto scorre col contenuto
  SafeInvalidate;
end;

function TzChatVirtualScroller.DoMouseWheelDown(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  SetOffset(ScrollOffset + LINE_STEP * 3);
  Result := True;   // gestito
end;

function TzChatVirtualScroller.DoMouseWheelUp(Shift: TShiftState;
  MousePos: TPoint): Boolean;
begin
  SetOffset(ScrollOffset - LINE_STEP * 3);
  Result := True;   // gestito
end;

procedure TzChatVirtualScroller.ScrollToBottom;
begin
  RecalcLayout(True);   // forza rimisura: il nuovo item va calcolato
  UpdateScrollBar;
  if HandleAllocated then
  begin
    SetOffset(MaxScrollOffset);
    Repaint;   // ridisegno immediato: SetOffset non invalida se la
               // posizione non cambia (es. gia' in fondo o unico messaggio)
  end
  else
    FPendingScrollToBottom := True;  // rimandato a CreateWnd
end;

procedure TzChatVirtualScroller.AggiornaPalette;
begin
  FPalette := TzChatPalette.Corrente;

  { Color si assegna solo a finestra creata: su TcxControl toccarla prima
    innesca CreateWnd, che senza parent solleva. Ci pensa CreateWnd, che
    arriva comunque prima del primo disegno. }
  if HandleAllocated then
    Color := FPalette.Sfondo;

  SafeInvalidate;
end;

procedure TzChatVirtualScroller.ScrollToLastMessage;
var
  LastIndex: Integer;
begin
  RecalcLayout(True);   // forza rimisura: il nuovo item va calcolato
  UpdateScrollBar;
  if not HandleAllocated then
  begin
    { Senza handle non si puo' misurare ne' scorrere: si rimanda, e al
      primo CreateWnd il messaggio viene comunque portato in vista. }
    FPendingScrollToBottom := True;
    Exit;
  end;

  LastIndex := High(FLayout);
  if (LastIndex >= 0) and (FLayout[LastIndex].Height > ClientHeight) then
    { Messaggio piu' alto della viewport: si allinea il suo inizio in
      cima, cosi' la lettura parte dalla prima riga. }
    SetOffset(FLayout[LastIndex].Top - VERTICAL_MARGIN)
  else
    SetOffset(MaxScrollOffset);
  Repaint;   // SetOffset non invalida se la posizione non cambia
end;

procedure TzChatVirtualScroller.Resize;
begin
  inherited Resize;
  { Il cambio di larghezza invalida il wrap: ricalcolo forzato.
    Cambia anche la pagina della scrollbar, quindi va ripubblicata. }
  RecalcLayout(True);
  UpdateScrollBar;
  SafeInvalidate;
end;

function TzChatVirtualScroller.TypingReserve: Integer;
begin
  if FTypingActive then
    Result := TYPING_HEIGHT + VERTICAL_MARGIN
  else
    Result := 0;
end;

procedure TzChatVirtualScroller.UpdateTypingBounds;
var
  NewBounds: TRect;
begin
  if (FTypingIndicator = nil) or not FTypingActive then
    Exit;
  { Stesso rientro delle bolle dell'assistente (lato sinistro), subito
    sotto l'ultimo messaggio. }
  NewBounds := Rect(SIDE_MARGIN, FContentHeight - ScrollOffset,
    SIDE_MARGIN + TYPING_WIDTH, FContentHeight - ScrollOffset + TYPING_HEIGHT);
  { Solo se cambia: SetBounds invalida, e in Paint innescherebbe un giro
    di ridisegni a vuoto. }
  if not EqualRect(NewBounds, FTypingIndicator.BoundsRect) then
    FTypingIndicator.BoundsRect := NewBounds;
end;

procedure TzChatVirtualScroller.SetTyping(Active: Boolean);
begin
  if FTypingActive = Active then
    Exit;
  FTypingActive := Active;
  FTypingIndicator.Visible := Active;
  { L'animazione ha un timer proprio: spenta insieme al segnaposto. }
  FTypingIndicator.Active := Active;
  RecalcLayout(False);
  if Active then
    ScrollToBottom
  else
    SafeInvalidate;
end;

procedure TzChatVirtualScroller.ClearSelection;
begin
  FSelStart := -1;
  FSelEnd := -1;
  FSelecting := False;
  SafeInvalidate;
end;

procedure TzChatVirtualScroller.InvalidateContent;
begin
  RecalcLayout(True);
  UpdateScrollBar;
  SafeInvalidate;
end;

procedure TzChatVirtualScroller.Paint;
var
  First, Last, Index, Y: Integer;
  Item: TzChatMessage;
  BubbleRect: TRect;
  BubbleWidth: Integer;
  SelectionColor: TColor;
begin
  { Sfondo: il colore lo detta la skin, non clWindow. Il pennello va
    impostato esplicitamente, altrimenti si riempie con quello lasciato
    dall'ultimo disegno. }
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := FPalette.Sfondo;
  Canvas.FillRect(ClientRect);
  Canvas.Font.Assign(FMeasureFont); // stesso font della misura: layout coerente

  if (FMessages = nil) or (FMessages.Count = 0) then
    Exit;

  if Length(FLayout) <> FMessages.Count then
    RecalcLayout(False);

  VisibleRange(First, Last);
  if First < 0 then
    Exit;

  BubbleWidth := MaxBubbleWidth;
  for Index := First to Last do
  begin
    Item := FMessages[Index];
    if Item.Renderer = nil then
      Continue;

    Y := FLayout[Index].Top - ScrollOffset;

    { Evidenziazione selezione: tinta leggera a tutta larghezza piu' una
      barretta piena sul bordo sinistro. Il colore lo detta la skin e la
      tinta lascia leggibile il testo della bolla, cosa che il pieno
      clHighlight non faceva. }
    if IsItemSelected(Index) then
    begin
      SelectionColor := FPalette.Selezione;
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := zChatBlendColors(SelectionColor, FPalette.Sfondo, SELECTION_TINT);
      Canvas.FillRect(Rect(0, Y, ContentWidth, Y + FLayout[Index].Height));
      Canvas.Brush.Color := SelectionColor;
      Canvas.FillRect(Rect(0, Y, SELECTION_BAR_WIDTH, Y + FLayout[Index].Height));
      Canvas.Brush.Style := bsClear;
    end;

    { Allineamento: bolle dell'utente corrente a destra, altre a sinistra. }
    if IsOwnMessage(Item) then
      BubbleRect := Rect(ContentWidth - SIDE_MARGIN - BubbleWidth, Y,
        ContentWidth - SIDE_MARGIN, Y + FLayout[Index].Height)
    else
      BubbleRect := Rect(SIDE_MARGIN, Y,
        SIDE_MARGIN + BubbleWidth, Y + FLayout[Index].Height);

    Item.Renderer.DrawBubble(Canvas, BubbleRect, Item, IsOwnMessage(Item));
  end;
end;

end.
