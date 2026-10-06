unit HelpGen.Generator;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON.Serializers,
  System.Generics.Collections,
  System.JSON.Converters,
  System.JSON,
  System.Actions,
  Vcl.ActnList,
  Vcl.Menus,
  Vcl.Graphics,
  Vcl.ImgList,
  dxRichEdit.NativeApi,
  dxRichEdit.Control,
  HelpGen.types,
  HelpGen.config,
  HelpGen.Request.Classes,
  HelpGen.Response.Classes;

type
  THelpGenGenerator = record
  private
    procedure CreateTableStyles(dxRichEditControl: TdxRichEditControl);
    function CreateTable(dxRichEditControl: TdxRichEditControl; const RowCount, ColCount: integer; const TableStyle: string; const skipFirstCol: Boolean): IdxRichEditTable;
    procedure SetTableCellText(dxRichEditControl: TdxRichEditControl; table: IdxRichEditTable; const Row, col: integer; const text: string; const WordWrap: Boolean);
    procedure SetTableCellImage(dxRichEditControl: TdxRichEditControl; table: IdxRichEditTable; const Row, col: integer; Action: TCustomAction);
  private
    procedure Aggiungi_Titolo(dxRichEditControl: TdxRichEditControl; HelpSubject: IHelpSubject);
    procedure Aggiungi_DescrizioneBreve(dxRichEditControl: TdxRichEditControl; ResponseDocumentazione: THelpGenResponseDocumentazione);
    procedure Aggiungi_Immagine(dxRichEditControl: TdxRichEditControl; HelpSubject: IHelpSubject);
    procedure Aggiungi_DescrizioneEstesa(dxRichEditControl: TdxRichEditControl; ResponseDocumentazione: THelpGenResponseDocumentazione);

    procedure Aggiungi_Elemento(dxRichEditControl: TdxRichEditControl; HelpSubject: IHelpSubject; Elemento: THelpGenResponseElemento);
    procedure Aggiungi_Elementi(dxRichEditControl: TdxRichEditControl; HelpSubject: IHelpSubject; Elementi: TObjectList<THelpGenResponseElemento>);
    procedure Aggiungi_Azioni(dxRichEditControl: TdxRichEditControl; HelpSubject: IHelpSubject; Azioni: TObjectList<THelpGenResponseAzione>);
    procedure Aggiungi_Filtri(dxRichEditControl: TdxRichEditControl; Filtri: TObjectList<THelpGenResponseFiltro>);
  public
    procedure GeneraDocumentazione(dxRichEditControl: TdxRichEditControl; HelpSubject: IHelpSubject; ResponseDocumentazione: THelpGenResponseDocumentazione);
  end;

implementation

uses
  dxCoreGraphics,
  dxCoreClasses,
  dxGDIPlusClasses,
  zOffice.Word.Utils,
  System.IOUtils,
  zMsg;

procedure THelpGenGenerator.CreateTableStyles(dxRichEditControl: TdxRichEditControl);

  procedure CreateStyle(const StyleName: string; skipFirstCol: Boolean);
  var
    TableStyle: IdxRichEditTableStyle;
    WholeTable: IdxRichEditTableConditionalStyle;
    dispari, pari: IdxRichEditTableConditionalStyle;
    FirstCol: IdxRichEditTableConditionalStyle;
    clVerdeTenue: TdxAlphaColor; // Righe dispari
    // clVerdeIntestazione: TdxAlphaColor; // Intestazione (se presente)
    clGrigioLinee: TdxAlphaColor; // Bordi
  begin
    // Definizione colori
    clVerdeTenue := dxMakeAlphaColor(240, 248, 240); // Verde molto tenue
    // clVerdeIntestazione := dxMakeAlphaColor(220, 237, 220); // Verde chiaro per intestazione
    clGrigioLinee := dxMakeAlphaColor(200, 200, 200); // Grigio chiaro per linee

    // Crea lo stile
    TableStyle := dxRichEditControl.Document.TableStyles.CreateNew;
    TableStyle.Name := StyleName;
    dxRichEditControl.Document.TableStyles.Add(TableStyle);

    // === STILE BASE (WholeTable) - Bordi griglia ===
    WholeTable := TableStyle.ConditionalStyleProperties.CreateConditionalStyle(TdxRichEditConditionalTableStyleFormattingType.WholeTable);
    // Bordi celle
    WholeTable.TableCellProperties.TableCellBorders.Top.LineColor := clGrigioLinee;
    WholeTable.TableCellProperties.TableCellBorders.Top.LineStyle := TdxRichEditTableBorderLineStyle.Single;
    WholeTable.TableCellProperties.TableCellBorders.Top.LineThickness := 0.5;
    WholeTable.TableCellProperties.TableCellBorders.Bottom.LineColor := clGrigioLinee;
    WholeTable.TableCellProperties.TableCellBorders.Bottom.LineStyle := TdxRichEditTableBorderLineStyle.Single;
    WholeTable.TableCellProperties.TableCellBorders.Bottom.LineThickness := 0.5;
    WholeTable.TableCellProperties.TableCellBorders.Left.LineColor := clGrigioLinee;
    WholeTable.TableCellProperties.TableCellBorders.Left.LineStyle := TdxRichEditTableBorderLineStyle.Single;
    WholeTable.TableCellProperties.TableCellBorders.Left.LineThickness := 0.5;
    WholeTable.TableCellProperties.TableCellBorders.Right.LineColor := clGrigioLinee;
    WholeTable.TableCellProperties.TableCellBorders.Right.LineStyle := TdxRichEditTableBorderLineStyle.Single;
    WholeTable.TableCellProperties.TableCellBorders.Right.LineThickness := 0.5;

    // === RIGHE DISPARI - Verde tenue ===
    dispari := TableStyle.ConditionalStyleProperties.CreateConditionalStyle(TdxRichEditConditionalTableStyleFormattingType.OddRowBanding);
    dispari.TableCellProperties.CellBackgroundColor := clVerdeTenue;

    // === RIGHE PARI - Bianco ===
    pari := TableStyle.ConditionalStyleProperties.CreateConditionalStyle(TdxRichEditConditionalTableStyleFormattingType.EvenRowBanding);
    pari.TableCellProperties.CellBackgroundColor := TdxAlphaColors.White;

    if skipFirstCol then
    begin
      FirstCol := TableStyle.ConditionalStyleProperties.CreateConditionalStyle(TdxRichEditConditionalTableStyleFormattingType.FirstColumn);
      FirstCol.TableCellProperties.CellBackgroundColor := TdxAlphaColors.White;
    end;
  end;

begin

  CreateStyle('HelpGen_Azioni', true);
  CreateStyle('HelpGen_Filtri', false);
end;

// procedure THelpGenGenerator.CreateTableStyles(dxRichEditControl: TdxRichEditControl);
// var
// Document: IdxRichEditDocument;
// TableStyle: IdxRichEditTableStyle;
// // AWholeTable, AFirstRow, AFirstCol: IdxRichEditTableConditionalStyle;
// WholeTable: IdxRichEditTableConditionalStyle;
// pari, dispari: IdxRichEditTableConditionalStyle;
//
// // Colori dello stile "Accent 6" (Arancione) di Word
// clAccent6Dark: TdxAlphaColor; // Intestazione
// clAccent6Light: TdxAlphaColor; // Righe dispari
// clAccent6Border: TdxAlphaColor; // Bordi
// clWhite: TdxAlphaColor;
// begin
// // Definizione colori (palette Accent 6 - Arancione di Office)
// clAccent6Dark := dxMakeAlphaColor(244, 177, 131); // #F4B183 - Intestazione
// clAccent6Light := dxMakeAlphaColor(251, 229, 214); // #FBE5D6 - Righe chiare
// clAccent6Border := dxMakeAlphaColor(237, 125, 49); // #ED7D31 - Bordi (Accent 6 base)
// clWhite := TdxAlphaColors.White;
//
// Document := dxRichEditControl.Document;
// // Crea lo stile tabella
// TableStyle := Document.TableStyles.CreateNew;
// TableStyle.Name := 'HelpGen';
// Document.TableStyles.Add(TableStyle);
//
// // === STILE BASE TABELLA (WholeTable) ===
// WholeTable := TableStyle.ConditionalStyleProperties.CreateConditionalStyle(TdxRichEditConditionalTableStyleFormattingType.WholeTable);
// // Bordi della griglia
// WholeTable.TableCellProperties.TableCellBorders.Top.LineColor := clAccent6Border;
// WholeTable.TableCellProperties.TableCellBorders.Top.LineStyle := TdxRichEditTableBorderLineStyle.Single;
// WholeTable.TableCellProperties.TableCellBorders.Top.LineThickness := 0.5;
// WholeTable.TableCellProperties.TableCellBorders.Bottom.LineColor := clAccent6Border;
// WholeTable.TableCellProperties.TableCellBorders.Bottom.LineStyle := TdxRichEditTableBorderLineStyle.Single;
// WholeTable.TableCellProperties.TableCellBorders.Bottom.LineThickness := 0.5;
// WholeTable.TableCellProperties.TableCellBorders.Left.LineColor := clAccent6Border;
// WholeTable.TableCellProperties.TableCellBorders.Left.LineStyle := TdxRichEditTableBorderLineStyle.Single;
// WholeTable.TableCellProperties.TableCellBorders.Left.LineThickness := 0.5;
// WholeTable.TableCellProperties.TableCellBorders.Right.LineColor := clAccent6Border;
// WholeTable.TableCellProperties.TableCellBorders.Right.LineStyle := TdxRichEditTableBorderLineStyle.Single;
// WholeTable.TableCellProperties.TableCellBorders.Right.LineThickness := 0.5;
//
// // // === RIGA INTESTAZIONE (FirstRow) ===
// // AFirstRow := TableStyle.ConditionalStyleProperties.CreateConditionalStyle(TdxRichEditConditionalTableStyleFormattingType.FirstRow);
// // AFirstRow.TableCellProperties.CellBackgroundColor := clAccent6Dark;
// // AFirstRow.CharacterProperties.Bold := True;
// // // Bordo inferiore più spesso per l'intestazione
// // AFirstRow.TableCellProperties.TableCellBorders.Bottom.LineColor := clAccent6Border;
// // AFirstRow.TableCellProperties.TableCellBorders.Bottom.LineStyle := TdxRichEditTableBorderLineStyle.Single;
// // AFirstRow.TableCellProperties.TableCellBorders.Bottom.LineThickness := 1.5;
// //
// // // === PRIMA COLONNA (FirstColumn) ===
// // AFirstCol := TableStyle.ConditionalStyleProperties.CreateConditionalStyle(TdxRichEditConditionalTableStyleFormattingType.FirstColumn);
// // AFirstCol.CharacterProperties.Bold := True;
//
// // === RIGHE PARI (EvenRowBanding) - Bianco ===
// pari := TableStyle.ConditionalStyleProperties.CreateConditionalStyle(TdxRichEditConditionalTableStyleFormattingType.EvenRowBanding);
// pari.TableCellProperties.CellBackgroundColor := clRed; // dxMakeAlphaColor(245, 252, 245);
//
// // === RIGHE DISPARI (OddRowBanding) - Colore chiaro ===
// dispari := TableStyle.ConditionalStyleProperties.CreateConditionalStyle(TdxRichEditConditionalTableStyleFormattingType.OddRowBanding);
// dispari.TableCellProperties.CellBackgroundColor := clWhite;
//
// // clVerdeTenuissimo := dxMakeAlphaColor(245, 252, 245);  // Appena percettibile
// //
// /// / Verde molto tenue
// // clVerdeMoltoTenue := dxMakeAlphaColor(240, 248, 240);  // #F0F8F0
// //
// /// / Verde tenue (consigliato per righe alternate)
// // clVerdeTenue := dxMakeAlphaColor(232, 245, 232);       // #E8F5E8
// //
// /// / Verde tenue medio
// // clVerdeTenueMedio := dxMakeAlphaColor(224, 240, 224);  // #E0F0E0
// //
// /// / Verde chiaro (più visibile)
// // clVerdeChiaro := dxMakeAlphaColor(216, 235, 216);      // #D8EBD8
// //
// /// / clMoneyGreen per confronto
// // clMoneyGreen := dxMakeAlphaColor(192, 220, 192);       // #C0DCC0
//
//
//
// // /////////////////////////////////////////////////////////////////////////
// // // === CREA LA TABELLA ===
// // ATable := Document.Tables.Add(Document.CaretPosition, ARowCount, AColCount);
// //
// // // Applica lo stile
// // ATable.Style := ATableStyle;
// //
// // // Imposta TableLook per attivare: intestazione, prima colonna, banded rows
// // ATable.TableLook := [TdxRichEditTableLookType.ApplyFirstRow, // Riga intestazione
// // TdxRichEditTableLookType.ApplyFirstColumn // Prima colonna in grassetto
// // // NON includere DoNotApplyRowBanding per avere le righe alternate
// // ];
// //
// // // Imposta bordi esterni della tabella
// // ATable.Borders.Top.LineColor := clAccent6Border;
// // ATable.Borders.Top.LineStyle := TdxRichEditTableBorderLineStyle.Single;
// // ATable.Borders.Top.LineThickness := 1.5;
// // ATable.Borders.Bottom.LineColor := clAccent6Border;
// // ATable.Borders.Bottom.LineStyle := TdxRichEditTableBorderLineStyle.Single;
// // ATable.Borders.Bottom.LineThickness := 1.5;
// // ATable.Borders.Left.LineColor := clAccent6Border;
// // ATable.Borders.Left.LineStyle := TdxRichEditTableBorderLineStyle.Single;
// // ATable.Borders.Left.LineThickness := 0.5;
// // ATable.Borders.Right.LineColor := clAccent6Border;
// // ATable.Borders.Right.LineStyle := TdxRichEditTableBorderLineStyle.Single;
// // ATable.Borders.Right.LineThickness := 0.5;
// //
// // // Bordi interni
// // ATable.Borders.InsideHorizontalBorder.LineColor := clAccent6Border;
// // ATable.Borders.InsideHorizontalBorder.LineStyle := TdxRichEditTableBorderLineStyle.Single;
// // ATable.Borders.InsideHorizontalBorder.LineThickness := 0.5;
// // ATable.Borders.InsideVerticalBorder.LineColor := clAccent6Border;
// // ATable.Borders.InsideVerticalBorder.LineStyle := TdxRichEditTableBorderLineStyle.Single;
// // ATable.Borders.InsideVerticalBorder.LineThickness := 0.5;
// end;

function THelpGenGenerator.CreateTable(dxRichEditControl: TdxRichEditControl; const RowCount, ColCount: integer; const TableStyle: string; const skipFirstCol: Boolean): IdxRichEditTable;
var
  iTableStyle: IdxRichEditTableStyle;
  clGrigioLinee: TdxAlphaColor; // Bordi
begin
  clGrigioLinee := dxMakeAlphaColor(200, 200, 200); // Grigio chiaro per linee

  result := dxRichEditControl.Document.Tables.Add(dxRichEditControl.Document.CaretPosition, RowCount, ColCount);

  // Bordi esterni
  result.Borders.Top.LineColor := clGrigioLinee;
  result.Borders.Top.LineStyle := TdxRichEditTableBorderLineStyle.Single;
  result.Borders.Top.LineThickness := 0.75;
  result.Borders.Bottom.LineColor := clGrigioLinee;
  result.Borders.Bottom.LineStyle := TdxRichEditTableBorderLineStyle.Single;
  result.Borders.Bottom.LineThickness := 0.75;
  result.Borders.Left.LineColor := clGrigioLinee;
  result.Borders.Left.LineStyle := TdxRichEditTableBorderLineStyle.Single;
  result.Borders.Left.LineThickness := 0.75;
  result.Borders.Right.LineColor := clGrigioLinee;
  result.Borders.Right.LineStyle := TdxRichEditTableBorderLineStyle.Single;
  result.Borders.Right.LineThickness := 0.75;

  // Bordi interni
  result.Borders.InsideHorizontalBorder.LineColor := clGrigioLinee;
  result.Borders.InsideHorizontalBorder.LineStyle := TdxRichEditTableBorderLineStyle.Single;
  result.Borders.InsideHorizontalBorder.LineThickness := 0.5;
  result.Borders.InsideVerticalBorder.LineColor := clGrigioLinee;
  result.Borders.InsideVerticalBorder.LineStyle := TdxRichEditTableBorderLineStyle.Single;
  result.Borders.InsideVerticalBorder.LineThickness := 0.5;

  if not TableStyle.IsEmpty then
  begin
    iTableStyle := dxRichEditControl.Document.TableStyles.Self[TableStyle];
    result.Style := iTableStyle;

    if skipFirstCol then
      result.TableLook := [TdxRichEditTableLookType.ApplyFirstColumn]
    else
      result.TableLook := [];
  end;
end;

procedure THelpGenGenerator.SetTableCellText(dxRichEditControl: TdxRichEditControl; table: IdxRichEditTable; const Row, col: integer; const text: string; const WordWrap: Boolean);
var
  Range: IdxRichEditDocumentRange;
  paragraph: IdxRichEditParagraph;
  // cell:TdxTableCell;
begin
  Range := dxRichEditControl.Document.InsertText(table.Cell(Row, col).Range.Start, text);
  table.Cell(Row, col).WordWrap := WordWrap;
  table.Cell(Row, col).VerticalAlignment := TdxRichEditTableCellVerticalAlignment.Center;

  table.Cell(Row, col).LeftPadding := 0.2;
  table.Cell(Row, col).RightPadding := 0;
  table.Cell(Row, col).TopPadding := 0.2;
  table.Cell(Row, col).BottomPadding := 0;

  paragraph := dxRichEditControl.Document.GetParagraph(Range.Start);
  paragraph.SpacingBefore := 0;
  paragraph.SpacingAfter := 0;
  paragraph.LineSpacingRule := TdxRichEditParagraphLineSpacing.Single;
end;

procedure THelpGenGenerator.SetTableCellImage(dxRichEditControl: TdxRichEditControl; table: IdxRichEditTable; const Row, col: integer; Action: TCustomAction);
var
  Range: IdxRichEditDocumentRange;
  paragraph: IdxRichEditParagraph;
  bmp: TBitmap;
  ImageList: TCustomImageList;
begin
  // immagine posizione 0
  if Action.ImageIndex <> -1 then
  begin
    ImageList := Action.Images;

    if assigned(ImageList) then
      if Action.ImageIndex <= ImageList.Count - 1 then
      begin
        bmp := TBitmap.Create;
        try
          bmp.PixelFormat := pf32bit;
          bmp.AlphaFormat := afIgnored;
          ImageList.GetBitmap(Action.ImageIndex, bmp);
          Range := dxRichEditControl.Document.InsertImage(table.Cell(Row, col).Range.Start, bmp).Range;

          paragraph := dxRichEditControl.Document.GetParagraph(Range.Start);
          paragraph.SpacingBefore := 0;
          paragraph.SpacingAfter := 0;
          table.Cell(Row, col).LeftPadding := 0;
          table.Cell(Row, col).RightPadding := 0;
          table.Cell(Row, col).TopPadding := 0;
          table.Cell(Row, col).BottomPadding := 0;

          paragraph.LineSpacingRule := TdxRichEditParagraphLineSpacing.Single;
          table.Cell(Row, col).VerticalAlignment := TdxRichEditTableCellVerticalAlignment.Center;
        finally
          FreeAndNil(bmp);
        end;
      end;
  end;
end;

procedure THelpGenGenerator.GeneraDocumentazione(dxRichEditControl: TdxRichEditControl; HelpSubject: IHelpSubject; ResponseDocumentazione: THelpGenResponseDocumentazione);
begin
  dxRichEditControl.Document.BeginUpdate;
  try
    CreateTableStyles(dxRichEditControl);

    Aggiungi_Titolo(dxRichEditControl, HelpSubject);
    Aggiungi_DescrizioneBreve(dxRichEditControl, ResponseDocumentazione);
    Aggiungi_Immagine(dxRichEditControl, HelpSubject);
    Aggiungi_DescrizioneEstesa(dxRichEditControl, ResponseDocumentazione);
    Aggiungi_Azioni(dxRichEditControl, HelpSubject, ResponseDocumentazione.azioniNonCollegate);

    Aggiungi_Elementi(dxRichEditControl, HelpSubject, ResponseDocumentazione.menu);
  finally
    dxRichEditControl.Document.EndUpdate;
  end;
end;

procedure THelpGenGenerator.Aggiungi_Titolo(dxRichEditControl: TdxRichEditControl; HelpSubject: IHelpSubject);
begin
  dxRichEditControl.AddText('Title', HelpSubject.HelpCaption, false);
end;

procedure THelpGenGenerator.Aggiungi_DescrizioneBreve(dxRichEditControl: TdxRichEditControl; ResponseDocumentazione: THelpGenResponseDocumentazione);
begin
  dxRichEditControl.AddText('Normal', ResponseDocumentazione.descrizioneBreve);
end;

procedure THelpGenGenerator.Aggiungi_DescrizioneEstesa(dxRichEditControl: TdxRichEditControl; ResponseDocumentazione: THelpGenResponseDocumentazione);
begin
  dxRichEditControl.AddText('Normal', ResponseDocumentazione.descrizioneEstesa);
  dxRichEditControl.NewLine;
end;

procedure THelpGenGenerator.Aggiungi_Immagine(dxRichEditControl: TdxRichEditControl; HelpSubject: IHelpSubject);
var
  dxSmartImage: TdxSmartImage;
begin
  dxRichEditControl.AddParagraph('Normal');
  dxSmartImage := TdxSmartImage.Create;
  try
    dxSmartImage.assign(HelpSubject.HelpScreenShot);
    dxRichEditControl.AddImage(dxSmartImage);
  finally
    FreeAndNil(dxSmartImage);
  end;
end;

procedure THelpGenGenerator.Aggiungi_Elemento(dxRichEditControl: TdxRichEditControl; HelpSubject: IHelpSubject; Elemento: THelpGenResponseElemento);
begin
  dxRichEditControl.AddText('heading 1', Elemento.nome, false);
  dxRichEditControl.AddText('Normal', Elemento.descrizione);

  Aggiungi_Filtri(dxRichEditControl, Elemento.Filtri);
  Aggiungi_Azioni(dxRichEditControl, HelpSubject, Elemento.Azioni);

  Aggiungi_Elementi(dxRichEditControl, HelpSubject, Elemento.sottoElementi);
end;

procedure THelpGenGenerator.Aggiungi_Elementi(dxRichEditControl: TdxRichEditControl; HelpSubject: IHelpSubject; Elementi: TObjectList<THelpGenResponseElemento>);
var
  Elemento: THelpGenResponseElemento;
begin

  for Elemento in Elementi do
    Aggiungi_Elemento(dxRichEditControl, HelpSubject, Elemento);
end;

procedure THelpGenGenerator.Aggiungi_Azioni(dxRichEditControl: TdxRichEditControl; HelpSubject: IHelpSubject; Azioni: TObjectList<THelpGenResponseAzione>);
var
  Row: integer;
  table: IdxRichEditTable;
  azione: THelpGenResponseAzione;
  Action: TCustomAction;
begin

  if Azioni.Count = 0 then
    exit;

  dxRichEditControl.AddParagraph('heading 3');
  dxRichEditControl.AddText('Azioni disponibili', false);

  dxRichEditControl.AddParagraph('Normal');

  table := CreateTable(dxRichEditControl, Azioni.Count, 4, 'HelpGen_Azioni', true);
  Row := 0;

  for azione in Azioni do
  begin
    Action := HelpSubject.HelpGetAction(azione.Name);

    if assigned(Action) then
      SetTableCellImage(dxRichEditControl, table, Row, 0, Action);

    SetTableCellText(dxRichEditControl, table, Row, 1, azione.caption, false);
    SetTableCellText(dxRichEditControl, table, Row, 2, azione.shortCut, false);
    SetTableCellText(dxRichEditControl, table, Row, 3, azione.descrizione, true);
    inc(Row);
  end;

  dxRichEditControl.NewLine;
end;

procedure THelpGenGenerator.Aggiungi_Filtri(dxRichEditControl: TdxRichEditControl; Filtri: TObjectList<THelpGenResponseFiltro>);
var
  filtro: THelpGenResponseFiltro;
  Row: integer;
  table: IdxRichEditTable;
begin
  if Filtri.Count = 0 then
    exit;

  dxRichEditControl.AddParagraph('heading 3');
  dxRichEditControl.AddText('Filtri disponibili', false);

  dxRichEditControl.AddParagraph('Normal');

  table := CreateTable(dxRichEditControl, Filtri.Count, 2, 'HelpGen_Filtri', false);
  Row := 0;

  for filtro in Filtri do
  begin
    SetTableCellText(dxRichEditControl, table, Row, 0, filtro.nome.replace(':', '', []), false);
    SetTableCellText(dxRichEditControl, table, Row, 1, filtro.descrizione, true);
    inc(Row);
  end;

  dxRichEditControl.NewLine;
end;

end.
