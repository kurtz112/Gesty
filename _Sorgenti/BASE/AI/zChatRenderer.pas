// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-13
// ---------------------------------------------------------------------------

unit zChatRenderer;

{ Renderer concreto di bolla testuale per TzChat.
  Implementa IzChatMessageRenderer come oggetto con stato (padding, raggio,
  palette), iniettabile sui TzChatMessage. Nessuna closure.

  Supporta la resa differenziata di:
  - Blocchi di codice Markdown (``` ... ```) con font monospazio e riquadro
  - Messaggi d'errore (status msError) con tavolozza di allarme
  - Allegati immagini e file generici }

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  System.UITypes,
  System.Generics.Collections,
  Winapi.Windows,
  Vcl.Graphics,
  cxGraphics,
  cxClasses,
  zChatTypes;

type
  TzChatBlockKind = (bkText, bkCode);

  TzChatTextBlock = record
    Kind: TzChatBlockKind;
    Content: string;
    Language: string;
  end;

  { Parametri estetici della bolla. Raggruppati per poter condividere
    una singola istanza di renderer tra piu' item con lo stesso stile. }
  TzChatBubbleTextRenderer = class(TInterfacedObject, IzChatMessageRenderer)
  private
    FHorizontalPadding: Integer;
    FVerticalPadding: Integer;
    FCornerRadius: Integer;
    FTimestampHeight: Integer;
    FOwnTextColor: TColor;
    FOtherTextColor: TColor;
    FOwnBubbleColor: TColor;
    FOtherBubbleColor: TColor;
    FTimestampColor: TColor;
    FPalette: TzChatPalette;
    function BubbleColor(Item: TzChatMessage; IsOwn: Boolean): TColor;
    function TextColor(Item: TzChatMessage; IsOwn: Boolean): TColor;
    function TimestampColor: TColor;
    function FormatTimestamp(Item: TzChatMessage): string;
    function TextRect(const BubbleRect: TRect): TRect;
    function TextHeight(Canvas: TcxCanvas; const Text: string; MaxWidth: Integer): Integer;
    function AttachmentsHeight(Item: TzChatMessage): Integer;
    procedure DrawAttachments(Canvas: TcxCanvas; const InnerRect: TRect; StartY: Integer; Item: TzChatMessage; IsOwn: Boolean);
    function ParseBlocks(const Text: string): TArray<TzChatTextBlock>;
    procedure DrawBlocks(Canvas: TcxCanvas; const TextArea: TRect; const Text: string; Item: TzChatMessage; IsOwn: Boolean);
  public
    constructor Create;
    procedure AggiornaPalette;
    // --- IzChatMessageRenderer ---
    procedure DrawBubble(Canvas: TcxCanvas; const BubbleRect: TRect; Item: TzChatMessage; IsOwn: Boolean);
    function MeasureBubble(Canvas: TcxCanvas; MaxWidth: Integer; Item: TzChatMessage): TSize;
    // --- configurazione ---
    property HorizontalPadding: Integer read FHorizontalPadding write FHorizontalPadding;
    property VerticalPadding: Integer read FVerticalPadding write FVerticalPadding;
    property CornerRadius: Integer read FCornerRadius write FCornerRadius;
    property OwnBubbleColor: TColor read FOwnBubbleColor write FOwnBubbleColor;
    property OtherBubbleColor: TColor read FOtherBubbleColor write FOtherBubbleColor;
    property OwnTextColor: TColor read FOwnTextColor write FOwnTextColor;
    property OtherTextColor: TColor read FOtherTextColor write FOtherTextColor;
    property TimestampTextColor: TColor read FTimestampColor write FTimestampColor;
  end;

implementation

const
  { Flag GDI del corpo messaggio, condivisi da misura e disegno: se cambia
    una, deve cambiare l'altra, altrimenti l'altezza calcolata e il testo
    disegnato non coincidono e le ultime righe escono dalla bolla.
    DT_WORDBREAK   manda a capo sulle parole;
    DT_NOPREFIX    la '&' e' un carattere come gli altri, non un
    acceleratore: le risposte AI ne contengono;
    DT_EXPANDTABS  le tabulazioni dei blocchi di codice occupano spazio
    invece di sparire. }
  TEXT_FLAGS = DT_WORDBREAK or DT_NOPREFIX or DT_EXPANDTABS or DT_LEFT or DT_TOP;

  THUMB_HEIGHT = 96; // lato max anteprima immagine
  FILE_ROW_HEIGHT = 22; // riga per allegato non-immagine (icona+nome)
  ATTACHMENT_GAP = 6; // spazio verticale tra allegati e col testo
  ICON_SIZE = 16; // icona file generico
  CODE_PADDING = 6; // padding interno blocco codice
  BLOCK_GAP = 4; // distanza tra blocchi di testo e codice
  CODE_FONT = 'Consolas';
  { Il codice si scrive un punto piu' piccolo del discorso, non a un corpo
    fisso: la dimensione della conversazione la sceglie chi usa il programma
    (TzChat.ConversationFont) e va rispettata. }
  CODE_FONT_DELTA = 1;

  { TzChatBubbleTextRenderer }

constructor TzChatBubbleTextRenderer.Create;
begin
  inherited Create;
  FHorizontalPadding := 10;
  FVerticalPadding := 6;
  FCornerRadius := 12;
  FTimestampHeight := 14;
  FOwnBubbleColor := clDefault;
  FOtherBubbleColor := clDefault;
  FOwnTextColor := clDefault;
  FOtherTextColor := clDefault;
  FTimestampColor := clDefault;

  AggiornaPalette;
end;

procedure TzChatBubbleTextRenderer.AggiornaPalette;
begin
  FPalette := TzChatPalette.Corrente;
end;

function TzChatBubbleTextRenderer.BubbleColor(Item: TzChatMessage; IsOwn: Boolean): TColor;
begin
  if (Item <> nil) and (Item.Status = msError) then
    Exit(FPalette.SfondoErrore);

  if (Item <> nil) and (Item.Author <> nil) and (Item.Author.Color <> clNone) then
    Exit(Item.Author.Color);

  if IsOwn then
  begin
    if FOwnBubbleColor = clDefault then
      Result := FPalette.BollaPropria
    else
      Result := FOwnBubbleColor;
  end
  else
  begin
    if FOtherBubbleColor = clDefault then
      Result := FPalette.BollaAltrui
    else
      Result := FOtherBubbleColor;
  end;
end;

function TzChatBubbleTextRenderer.TextColor(Item: TzChatMessage; IsOwn: Boolean): TColor;
begin
  if (Item <> nil) and (Item.Status = msError) then
    Exit(FPalette.TestoErrore);

  if IsOwn then
  begin
    if FOwnTextColor = clDefault then
      Result := FPalette.TestoProprio
    else
      Result := FOwnTextColor;
  end
  else
  begin
    if FOtherTextColor = clDefault then
      Result := FPalette.TestoAltrui
    else
      Result := FOtherTextColor;
  end;
end;

function TzChatBubbleTextRenderer.TimestampColor: TColor;
begin
  if FTimestampColor = clDefault then
    Result := FPalette.Orario
  else
    Result := FTimestampColor;
end;

function TzChatBubbleTextRenderer.FormatTimestamp(Item: TzChatMessage): string;
begin
  Result := FormatDateTime('hh:nn', Item.Timestamp);
end;

function TzChatBubbleTextRenderer.TextRect(const BubbleRect: TRect): TRect;
begin
  Result := BubbleRect;
  Inc(Result.Left, FHorizontalPadding);
  Dec(Result.Right, FHorizontalPadding);
  Inc(Result.Top, FVerticalPadding);
  Dec(Result.Bottom, FVerticalPadding + FTimestampHeight);
end;

function TzChatBubbleTextRenderer.AttachmentsHeight(Item: TzChatMessage): Integer;
var
  Index: Integer;
  Attachment: TzChatAttachment;
begin
  Result := 0;
  if Item.Attachments.Count = 0 then
    Exit;
  for Index := 0 to Item.Attachments.Count - 1 do
  begin
    Attachment := Item.Attachments[Index];
    if Attachment.IsImage then
      Inc(Result, THUMB_HEIGHT + ATTACHMENT_GAP)
    else
      Inc(Result, FILE_ROW_HEIGHT + ATTACHMENT_GAP);
  end;
end;

procedure TzChatBubbleTextRenderer.DrawAttachments(Canvas: TcxCanvas; const InnerRect: TRect; StartY: Integer; Item: TzChatMessage; IsOwn: Boolean);
var
  Index, Y, ThumbSide: Integer;
  Attachment: TzChatAttachment;
  ThumbRect, IconRect, NameRect: TRect;
  Ratio: Double;
begin
  Y := StartY;
  for Index := 0 to Item.Attachments.Count - 1 do
  begin
    Attachment := Item.Attachments[Index];
    if Attachment.IsImage and not Attachment.Preview.Empty then
    begin
      if Attachment.Preview.Height > 0 then
        Ratio := Attachment.Preview.Width / Attachment.Preview.Height
      else
        Ratio := 1;
      ThumbSide := THUMB_HEIGHT;
      ThumbRect := Rect(InnerRect.Left, Y, InnerRect.Left + Round(ThumbSide * Ratio), Y + ThumbSide);
      if ThumbRect.Right > InnerRect.Right then
        ThumbRect.Right := InnerRect.Right;
      Attachment.Preview.StretchDraw(Canvas.Canvas.Handle, ThumbRect);
      Inc(Y, THUMB_HEIGHT + ATTACHMENT_GAP);
    end
    else
    begin
      IconRect := Rect(InnerRect.Left, Y, InnerRect.Left + ICON_SIZE, Y + ICON_SIZE);
      Canvas.Brush.Color := clBtnShadow;
      Canvas.Brush.Style := bsSolid;
      Canvas.FillRect(IconRect);
      Canvas.Brush.Style := bsClear;
      NameRect := Rect(InnerRect.Left + ICON_SIZE + 4, Y, InnerRect.Right, Y + FILE_ROW_HEIGHT);
      Canvas.Font.Color := TextColor(Item, IsOwn);
      Canvas.DrawTexT(Attachment.FileName, NameRect, taLeftJustify, vaCenter, False, False);
      Inc(Y, FILE_ROW_HEIGHT + ATTACHMENT_GAP);
    end;
  end;
end;

function TzChatBubbleTextRenderer.ParseBlocks(const Text: string): TArray<TzChatTextBlock>;
var
  List: TList<TzChatTextBlock>;
  PosStart, PosEnd, FirstLineEnd: Integer;
  Remainder: string;
  Block: TzChatTextBlock;
begin
  List := TList<TzChatTextBlock>.Create;
  try
    Remainder := Text;
    while True do
    begin
      PosStart := Pos('```', Remainder);
      if PosStart = 0 then
      begin
        if Remainder <> '' then
        begin
          Block.Kind := bkText;
          Block.Content := Remainder;
          Block.Language := '';
          List.Add(Block);
        end;
        Break;
      end;

      if PosStart > 1 then
      begin
        Block.Kind := bkText;
        Block.Content := Copy(Remainder, 1, PosStart - 1);
        Block.Language := '';
        List.Add(Block);
      end;

      Delete(Remainder, 1, PosStart + 2); // toglie ```
      PosEnd := Pos('```', Remainder);
      if PosEnd = 0 then
      begin
        Block.Kind := bkCode;
        Block.Content := Remainder;
        Block.Language := '';
        List.Add(Block);
        Break;
      end;

      Block.Kind := bkCode;
      Block.Content := Copy(Remainder, 1, PosEnd - 1);
      Block.Language := '';

      FirstLineEnd := Pos(#10, Block.Content);
      if (FirstLineEnd > 0) and (FirstLineEnd <= 30) then
      begin
        Block.Language := Trim(Copy(Block.Content, 1, FirstLineEnd - 1));
        Delete(Block.Content, 1, FirstLineEnd);
      end;

      List.Add(Block);
      Delete(Remainder, 1, PosEnd + 2); // toglie ``` di chiusura
    end;
    Result := List.ToArray;
  finally
    List.Free;
  end;
end;

function TzChatBubbleTextRenderer.TextHeight(Canvas: TcxCanvas; const Text: string; MaxWidth: Integer): Integer;
var
  Blocks: TArray<TzChatTextBlock>;
  Index, TotalH, BlockH: Integer;
  MeasureRect: TRect;
  OldFontName: string;
  OldFontSize: Integer;
begin
  if Text = '' then
    Exit(0);

  Blocks := ParseBlocks(Text);

  { Scorciatoia solo per il testo semplice. Un messaggio fatto di UN SOLO
    blocco di codice — "ecco la query:" e basta, che e' il caso piu' comune
    quando si chiede una SQL — deve passare dal ramo lungo, altrimenti si
    vedono i tre apici e il carattere resta quello del discorso. }
  if (Length(Blocks) = 0) or ((Length(Blocks) = 1) and (Blocks[0].Kind = bkText)) then
  begin
    MeasureRect := Rect(0, 0, MaxWidth, 0);
    Winapi.Windows.DrawTexT(Canvas.Canvas.Handle, PChar(Text), Length(Text), MeasureRect, TEXT_FLAGS or DT_CALCRECT);
    Exit(MeasureRect.Bottom - MeasureRect.Top);
  end;

  TotalH := 0;
  OldFontName := Canvas.Font.Name;
  OldFontSize := Canvas.Font.Size;
  try
    for Index := 0 to High(Blocks) do
    begin
      if Blocks[Index].Kind = bkCode then
      begin
        Canvas.Font.Name := CODE_FONT;
        Canvas.Font.Size := OldFontSize - CODE_FONT_DELTA;
        MeasureRect := Rect(0, 0, MaxWidth - (2 * CODE_PADDING), 0);
        Winapi.Windows.DrawTexT(Canvas.Canvas.Handle, PChar(Blocks[Index].Content), Length(Blocks[Index].Content), MeasureRect, TEXT_FLAGS or DT_CALCRECT);
        BlockH := (MeasureRect.Bottom - MeasureRect.Top) + (2 * CODE_PADDING);
      end
      else
      begin
        Canvas.Font.Name := OldFontName;
        Canvas.Font.Size := OldFontSize;
        MeasureRect := Rect(0, 0, MaxWidth, 0);
        Winapi.Windows.DrawTexT(Canvas.Canvas.Handle, PChar(Blocks[Index].Content), Length(Blocks[Index].Content), MeasureRect, TEXT_FLAGS or DT_CALCRECT);
        BlockH := MeasureRect.Bottom - MeasureRect.Top;
      end;

      Inc(TotalH, BlockH);
      if Index < High(Blocks) then
        Inc(TotalH, BLOCK_GAP);
    end;
    Result := TotalH;
  finally
    Canvas.Font.Name := OldFontName;
    Canvas.Font.Size := OldFontSize;
  end;
end;

function TzChatBubbleTextRenderer.MeasureBubble(Canvas: TcxCanvas; MaxWidth: Integer; Item: TzChatMessage): TSize;
var
  TextWidth: Integer;
begin
  TextWidth := MaxWidth - 2 * FHorizontalPadding;
  if TextWidth < 1 then
    TextWidth := 1;

  Result.cx := MaxWidth;
  Result.cy := TextHeight(Canvas, Item.Text, TextWidth) + 2 * FVerticalPadding + FTimestampHeight + AttachmentsHeight(Item);
end;

procedure TzChatBubbleTextRenderer.DrawBlocks(Canvas: TcxCanvas; const TextArea: TRect; const Text: string; Item: TzChatMessage; IsOwn: Boolean);
var
  Blocks: TArray<TzChatTextBlock>;
  Index, CurrentY, BlockH: Integer;
  BlockRect, InnerCodeRect, MeasureRect: TRect;
  OldFontName: string;
  OldFontSize: Integer;
begin
  Blocks := ParseBlocks(Text);

  // Stessa condizione della misura: se qui e' diversa, l'altezza non torna
  if (Length(Blocks) = 0) or ((Length(Blocks) = 1) and (Blocks[0].Kind = bkText)) then
  begin
    BlockRect := TextArea;
    Canvas.Font.Color := TextColor(Item, IsOwn);
    SetBkMode(Canvas.Canvas.Handle, TRANSPARENT);
    Winapi.Windows.DrawTexT(Canvas.Canvas.Handle, PChar(Text), Length(Text), BlockRect, TEXT_FLAGS);
    Exit;
  end;

  CurrentY := TextArea.Top;
  OldFontName := Canvas.Font.Name;
  OldFontSize := Canvas.Font.Size;
  try
    for Index := 0 to High(Blocks) do
    begin
      if Blocks[Index].Kind = bkCode then
      begin
        Canvas.Font.Name := CODE_FONT;
        Canvas.Font.Size := OldFontSize - CODE_FONT_DELTA;
        MeasureRect := Rect(0, 0, TextArea.Right - TextArea.Left - (2 * CODE_PADDING), 0);
        Winapi.Windows.DrawTexT(Canvas.Canvas.Handle, PChar(Blocks[Index].Content), Length(Blocks[Index].Content), MeasureRect, TEXT_FLAGS or DT_CALCRECT);
        BlockH := (MeasureRect.Bottom - MeasureRect.Top) + (2 * CODE_PADDING);

        BlockRect := Rect(TextArea.Left, CurrentY, TextArea.Right, CurrentY + BlockH);
        Canvas.Brush.Color := FPalette.SfondoCodice;
        Canvas.Pen.Color := FPalette.BordoCodice;
        Canvas.RoundRect(BlockRect, 6, 6);

        InnerCodeRect := BlockRect;
        InflateRect(InnerCodeRect, -CODE_PADDING, -CODE_PADDING);
        Canvas.Font.Color := FPalette.TestoAltrui;
        Canvas.Brush.Style := bsClear;
        SetBkMode(Canvas.Canvas.Handle, TRANSPARENT);
        Winapi.Windows.DrawTexT(Canvas.Canvas.Handle, PChar(Blocks[Index].Content), Length(Blocks[Index].Content), InnerCodeRect, TEXT_FLAGS);
      end
      else
      begin
        Canvas.Font.Name := OldFontName;
        Canvas.Font.Size := OldFontSize;
        MeasureRect := Rect(0, 0, TextArea.Right - TextArea.Left, 0);
        Winapi.Windows.DrawTexT(Canvas.Canvas.Handle, PChar(Blocks[Index].Content), Length(Blocks[Index].Content), MeasureRect, TEXT_FLAGS or DT_CALCRECT);
        BlockH := MeasureRect.Bottom - MeasureRect.Top;

        BlockRect := Rect(TextArea.Left, CurrentY, TextArea.Right, CurrentY + BlockH);
        Canvas.Font.Color := TextColor(Item, IsOwn);
        Canvas.Brush.Style := bsClear;
        SetBkMode(Canvas.Canvas.Handle, TRANSPARENT);
        Winapi.Windows.DrawTexT(Canvas.Canvas.Handle, PChar(Blocks[Index].Content), Length(Blocks[Index].Content), BlockRect, TEXT_FLAGS);
      end;

      Inc(CurrentY, BlockH + BLOCK_GAP);
    end;
  finally
    Canvas.Font.Name := OldFontName;
    Canvas.Font.Size := OldFontSize;
  end;
end;

procedure TzChatBubbleTextRenderer.DrawBubble(Canvas: TcxCanvas; const BubbleRect: TRect; Item: TzChatMessage; IsOwn: Boolean);
var
  InnerRect: TRect;
  TextArea: TRect;
  TimestampRect: TRect;
begin
  Canvas.Brush.Color := BubbleColor(Item, IsOwn);
  if (Item <> nil) and (Item.Status = msError) then
    Canvas.Pen.Color := FPalette.BordoErrore
  else
    Canvas.Pen.Color := BubbleColor(Item, IsOwn);

  Canvas.RoundRect(BubbleRect, FCornerRadius, FCornerRadius);

  InnerRect := TextRect(BubbleRect);
  TextArea := InnerRect;
  Dec(TextArea.Bottom, AttachmentsHeight(Item));

  DrawBlocks(Canvas, TextArea, Item.Text, Item, IsOwn);

  if Item.Attachments.Count > 0 then
    DrawAttachments(Canvas, InnerRect, TextArea.Bottom, Item, IsOwn);

  TimestampRect := BubbleRect;
  Inc(TimestampRect.Top, TimestampRect.Bottom - TimestampRect.Top - FTimestampHeight - FVerticalPadding);
  Dec(TimestampRect.Right, FHorizontalPadding);
  Canvas.Font.Color := TimestampColor;
  Canvas.DrawTexT(FormatTimestamp(Item), TimestampRect, taRightJustify, vaBottom, False, False);

  Canvas.Brush.Style := bsSolid;
end;

end.
