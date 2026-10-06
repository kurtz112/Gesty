unit zChatSessionsDropDown;

// Menu a tendina dello storico sessioni (stile Claude/Gemini): una piccola
// finestra senza bordi ancorata sotto il bottone "Storico", con l'elenco
// delle conversazioni salvate. Ogni riga mostra titolo e data su due righe;
// al passaggio del mouse compare il cestino per l'eliminazione.
//
//   - click sulla riga     -> apre la sessione (evento OnSessionChosen)
//   - click sul cestino    -> elimina la sessione e aggiorna l'elenco
//   - click fuori / ESC    -> chiude la tendina
//
// Costruita senza DFM (CreateNew), interamente su controlli DevExpress.

interface

uses
  System.Classes, System.SysUtils, System.Types, System.Math,
  Winapi.Windows,
  Vcl.Controls, Vcl.Graphics, Vcl.Forms, Vcl.StdCtrls,
  cxGraphics, cxCustomListBox, cxListBox, dxForms, dxGDIPlusClasses,
  zChatSessions;

type
  TzChatSessionChosenEvent = procedure(Sender: TObject;
    const SessionId: string) of object;

  TzChatSessionsDropDown = class(TdxForm)
  private
    FListBox: TcxListBox;
    FStore: TzChatSessionStore;
    FIds: TStringList;
    FDates: TStringList;
    FTrashIcon: TdxSmartImage;
    FHotIndex: Integer;
    FOnSessionChosen: TzChatSessionChosenEvent;
    procedure RefreshSessions;
    function TrashRect(const ItemRect: TRect): TRect;
    procedure ListBoxDrawItem(AControl: TcxListBox; ACanvas: TcxCanvas;
      AIndex: Integer; ARect: TRect; AState: TOwnerDrawState);
    procedure ListBoxMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure ListBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDeactivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Aggiorna l'elenco e mostra la tendina sotto il controllo di ancoraggio,
      allineata al suo bordo destro. }
    procedure ShowBelow(AnchorControl: TControl; AWidth: Integer);
    property Store: TzChatSessionStore read FStore write FStore;
    property OnSessionChosen: TzChatSessionChosenEvent
      read FOnSessionChosen write FOnSessionChosen;
  end;

implementation

const
  ROW_HEIGHT = 40;
  MAX_VISIBLE_ROWS = 8;
  TEXT_MARGIN = 8;
  TRASH_ZONE_WIDTH = 30;
  TRASH_ICON_SIZE = 16;

  SVG_TRASH =
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16">' +
    '<path fill="none" stroke="#727272" stroke-width="1.3" ' +
    'd="M3 4.5h10M6.5 4.5V3h3v1.5M4.5 4.5l.7 8.5h5.6l.7-8.5' +
    'M6.7 7v4M9.3 7v4"/></svg>';

{ TzChatSessionsDropDown }

constructor TzChatSessionsDropDown.Create(AOwner: TComponent);
var
  SvgStream: TStringStream;
begin
  // CreateNew: nessun DFM da caricare
  inherited CreateNew(AOwner);
  BorderStyle := bsNone;
  FormStyle := fsStayOnTop;
  KeyPreview := True;
  OnDeactivate := FormDeactivate;
  OnKeyDown := FormKeyDown;

  FIds := TStringList.Create;
  FDates := TStringList.Create;
  FHotIndex := -1;

  FTrashIcon := TdxSmartImage.Create;
  SvgStream := TStringStream.Create(SVG_TRASH, TEncoding.UTF8);
  try
    FTrashIcon.LoadFromStream(SvgStream);
  finally
    SvgStream.Free;
  end;

  FListBox := TcxListBox.Create(Self);
  FListBox.Parent := Self;
  FListBox.Align := alClient;
  // ListStyle (non Style, che e' lo stile del contenitore cx): abilita
  // l'owner-draw a righe di altezza fissa con OnDrawItem
  FListBox.ListStyle := lbOwnerDrawFixed;
  FListBox.ItemHeight := ROW_HEIGHT;
  FListBox.OnDrawItem := ListBoxDrawItem;
  FListBox.OnMouseMove := ListBoxMouseMove;
  FListBox.OnMouseDown := ListBoxMouseDown;
end;

destructor TzChatSessionsDropDown.Destroy;
begin
  FTrashIcon.Free;
  FDates.Free;
  FIds.Free;
  inherited Destroy;
end;

procedure TzChatSessionsDropDown.RefreshSessions;
begin
  FHotIndex := -1;
  FStore.ListSessions(FIds, FListBox.Items, FDates);
  // Stato vuoto: una riga informativa non cliccabile (FIds resta vuota)
  if FListBox.Items.Count = 0 then
    FListBox.Items.Add('Nessuna conversazione salvata');
end;

procedure TzChatSessionsDropDown.ShowBelow(AnchorControl: TControl;
  AWidth: Integer);
var
  ScreenPos: TPoint;
  VisibleRows: Integer;
begin
  RefreshSessions;
  VisibleRows := Min(Max(FListBox.Items.Count, 1), MAX_VISIBLE_ROWS);
  // Ancorata sotto il bordo destro del controllo di riferimento
  ScreenPos := AnchorControl.ClientToScreen(
    Point(AnchorControl.Width, AnchorControl.Height + 2));
  SetBounds(ScreenPos.X - AWidth, ScreenPos.Y, AWidth,
    VisibleRows * ROW_HEIGHT + 4);
  Show;
end;

function TzChatSessionsDropDown.TrashRect(const ItemRect: TRect): TRect;
begin
  Result := ItemRect;
  Result.Left := ItemRect.Right - TRASH_ZONE_WIDTH;
  // Icona centrata nella zona cestino
  Result := Rect(
    Result.Left + (TRASH_ZONE_WIDTH - TRASH_ICON_SIZE) div 2,
    ItemRect.Top + (ItemRect.Height - TRASH_ICON_SIZE) div 2,
    Result.Left + (TRASH_ZONE_WIDTH + TRASH_ICON_SIZE) div 2,
    ItemRect.Top + (ItemRect.Height + TRASH_ICON_SIZE) div 2);
end;

procedure TzChatSessionsDropDown.ListBoxDrawItem(AControl: TcxListBox;
  ACanvas: TcxCanvas; AIndex: Integer; ARect: TRect;
  AState: TOwnerDrawState);
var
  TextRect: TRect;
begin
  // Sfondo: evidenzia la riga calda / selezionata
  if (AIndex = FHotIndex) or (odSelected in AState) then
    ACanvas.Brush.Color := clBtnFace
  else
    ACanvas.Brush.Color := clWindow;
  ACanvas.FillRect(ARect);
  ACanvas.Brush.Style := bsClear;

  TextRect := ARect;
  Inc(TextRect.Left, TEXT_MARGIN);
  Dec(TextRect.Right, TRASH_ZONE_WIDTH);

  if FIds.Count = 0 then
  begin
    // Stato vuoto: riga informativa in grigio corsivo
    ACanvas.Font.Assign(Font);
    ACanvas.Font.Style := [fsItalic];
    ACanvas.Font.Color := clGrayText;
    ACanvas.DrawTexT(FListBox.Items[AIndex], TextRect,
      cxAlignLeft or cxAlignVCenter or cxSingleLine);
    ACanvas.Brush.Style := bsSolid;
    Exit;
  end;

  // Prima riga: titolo della conversazione (ellissi se non ci sta)
  ACanvas.Font.Assign(Font);
  ACanvas.Font.Color := clWindowText;
  ACanvas.DrawTexT(FListBox.Items[AIndex],
    Rect(TextRect.Left, ARect.Top + 4, TextRect.Right, ARect.Top + 21),
    cxAlignLeft or cxAlignVCenter or cxSingleLine or cxShowEndEllipsis);

  // Seconda riga: data in piccolo e in grigio
  ACanvas.Font.Assign(Font);
  ACanvas.Font.Size := Font.Size - 1;
  ACanvas.Font.Color := clGrayText;
  ACanvas.DrawTexT(FDates[AIndex],
    Rect(TextRect.Left, ARect.Top + 21, TextRect.Right, ARect.Bottom - 2),
    cxAlignLeft or cxAlignVCenter or cxSingleLine);

  // Cestino: visibile solo sulla riga sotto il mouse
  if AIndex = FHotIndex then
    FTrashIcon.StretchDraw(ACanvas.Canvas.Handle, TrashRect(ARect));

  ACanvas.Brush.Style := bsSolid;
end;

procedure TzChatSessionsDropDown.ListBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  NewIndex: Integer;
begin
  NewIndex := FListBox.ItemAtPos(Point(X, Y), True);
  if NewIndex <> FHotIndex then
  begin
    FHotIndex := NewIndex;
    FListBox.Invalidate;
  end;
end;

procedure TzChatSessionsDropDown.ListBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Index: Integer;
  ItemRect: TRect;
begin
  if Button <> mbLeft then
    Exit;
  Index := FListBox.ItemAtPos(Point(X, Y), True);
  if (Index < 0) or (Index >= FIds.Count) then
    Exit;

  ItemRect := Rect(0, (Index - FListBox.TopIndex) * ROW_HEIGHT,
    FListBox.ClientWidth, (Index - FListBox.TopIndex + 1) * ROW_HEIGHT);
  if X >= ItemRect.Right - TRASH_ZONE_WIDTH then
  begin
    // Click sul cestino: elimina e aggiorna l'elenco restando aperti
    FStore.DeleteSession(FIds[Index]);
    RefreshSessions;
    FListBox.Invalidate;
  end
  else
  begin
    // Click sulla riga: apre la sessione e chiude la tendina
    Hide;
    if Assigned(FOnSessionChosen) then
      FOnSessionChosen(Self, FIds[Index]);
  end;
end;

procedure TzChatSessionsDropDown.FormDeactivate(Sender: TObject);
begin
  Hide;
end;

procedure TzChatSessionsDropDown.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Hide;
end;

end.
