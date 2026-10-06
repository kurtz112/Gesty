unit frame_RiepilogoGiornalieroAule;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ShellAPI,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  System.Actions,
  System.ImageList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ImgList,
  Vcl.ActnList,
  Vcl.ComCtrls,
  Vcl.Menus,
  Vcl.StdCtrls,
  Vcl.StdActns,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxCustomData,
  cxStyles,
  dxScrollbarAnnotations,
  cxTL,
  cxTLdxBarBuiltInMenu,
  cxInplaceContainer,
  cxImageList,
  cxClasses,
  dxBar,
  dxLayoutContainer,
  dxLayoutControl,
  dxLayoutcxEditAdapters,
  dxLayoutControlAdapters,
  cxContainer,
  cxEdit,
  dxCore,
  cxDateUtils,
  cxButtons,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxCalendar,
  dxPSGlbl,
  dxPSUtl,
  dxPSEngn,
  dxPrnPg,
  dxBkgnd,
  dxWrap,
  dxPrnDev,
  dxPSCompsProvider,
  dxPSFillPatterns,
  dxPSEdgePatterns,
  dxPSPDFExportCore,
  dxPSPDFExport,
  cxDrawTextUtils,
  dxPSPrVwStd,
  dxPSPrVwAdv,
  dxPSPrVwRibbon,
  dxPScxPageControlProducer,
  dxPScxTLLnk,
  dxPScxEditorProducers,
  dxPScxExtEditorProducers,
  dxPSCore,
  dxPScxCommon,
  dxShellDialogs,
  Base_Frame,
  dxFileActions,
  RiepilogoGiornalieroAule.Classes,
  dxPScxSchedulerLnk,
  dxPSRichEditControlLnk,
  dxPSdxSpreadSheetLnk,
  cxFilter;

type
  TFrameRiepilogoGiornalieroAule = class(TBaseFrame)
    ActionList: TActionList;
    tree: TcxTreeList;
    dxBarButton1: TdxBarButton;
    dxLayoutControlGroup_Root: TdxLayoutGroup;
    dxLayoutControl: TdxLayoutControl;
    dxLayoutItemTree: TdxLayoutItem;
    edDalGiorno: TcxDateEdit;
    dxLayoutItemDalGiorno: TdxLayoutItem;
    dxLayoutGroupTop: TdxLayoutGroup;
    dxComponentPrinter: TdxComponentPrinter;
    dxComponentPrinterLink: TcxTreeListReportLink;
    actEsporta: TdxFileSaveAs;
    ColorRepository: TcxStyleRepository;
    Precedente: TAction;
    Successiva: TAction;
    btnPrecedente: TcxButton;
    btnSuccessiva: TcxButton;
    dxLayoutItemPrecedente: TdxLayoutItem;
    dxLayoutItemSuccessiva: TdxLayoutItem;
    procedure dxComponentPrinterLinkInitializeCell(Sender: TcxTreeListCustomReportLink; ANode: TcxTreeListNode; AColumn: TcxTreeListColumn; AnItem: TAbstractdxReportCellData);
    procedure edDalGiornoPropertiesEditValueChanged(Sender: TObject);
    procedure actEsportaAccept(Sender: TObject);
    procedure PrecedenteExecute(Sender: TObject);
    procedure SuccessivaExecute(Sender: TObject);
    procedure treeDblClick(Sender: TObject);
    procedure treeStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; var AStyle: TcxStyle);
  private
    function getColorStyle(Color: TColor): TcxStyle;
    function CreateBand(const Caption: string; const Width: integer; Style: TcxStyle): TcxTreeListBand;
    function CreateColumn(band: TcxTreeListBand; const Name, Caption: string; const Width: integer): TcxTreeListColumn;
    procedure DestroyStructure;
    procedure CreateStructure;
  private
    FStartDate: TDate;
    procedure SetStartDate(const Value: TDate);
    procedure IncrementaPeriodo(Incrementa: Boolean);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  public
    RiepilogoGiornalieroAule: TRiepilogoGiornalieroAule;

    procedure LoadTree;
    procedure Stampa;
    procedure Esporta(const FileName: string);

    property StartDate: TDate read FStartDate write SetStartDate;
  end;

implementation

uses
  System.DateUtils,
  System.IOUtils,
  System.Math,
  cxTLExportLink,
  zDm_Images,
  zDX,
  zBaseLib,
  dmAule,
  zMsg;

{$R *.dfm}
{ TFrameCalendarioDocenti }

constructor TFrameRiepilogoGiornalieroAule.Create(aOwner: TComponent);
begin
  inherited;
  dx.InitLayoutControl(dxLayoutControl);
  dx.initTreeList(tree);
  dx.InitPrinter(dxComponentPrinter);

  RiepilogoGiornalieroAule := TRiepilogoGiornalieroAule.Create;

  FStartDate := StartOfTheWeek(Date);
  edDalGiorno.Date := StartDate;
end;

destructor TFrameRiepilogoGiornalieroAule.Destroy;
begin
  FreeAndNil(RiepilogoGiornalieroAule);
  inherited;
end;

procedure TFrameRiepilogoGiornalieroAule.DestroyStructure;
var
  i: integer;
  col: TcxTreeListColumn;
begin

  for i := tree.ColumnCount - 1 downto 0 do
  begin
    col := tree.Columns[i];
    col.Free;
  end;

  tree.Bands.Clear;
end;

function TFrameRiepilogoGiornalieroAule.CreateBand(const Caption: string; const Width: integer; Style: TcxStyle): TcxTreeListBand;
begin
  result := tree.Bands.Add;
  result.Caption.Text := Caption;
  result.Caption.AlignHorz := taCenter;
  result.Width := Width;
  result.Styles.Content := Style;
end;

function TFrameRiepilogoGiornalieroAule.CreateColumn(band: TcxTreeListBand; const Name, Caption: string; const Width: integer): TcxTreeListColumn;
begin
  result := tree.CreateColumn(band);
  result.Name := Name;
  result.Caption.Text := Caption;
  result.DataBinding.ValueType := 'String';
  // result.Position.BandIndex := 0;
  // result.Position.RowIndex := 0;
  // result.Position.ColIndex := tree.ColumnCount;
  result.Options.IncSearch := false;
  result.Options.Moving := false;
  result.Options.Sorting := false;
  result.Focused := true;
  result.Width := Width;

  result.Styles.Header := dx.GetStyle(scBtnFace);
end;

procedure TFrameRiepilogoGiornalieroAule.CreateStructure;
var
  band: TcxTreeListBand;
  col: TcxTreeListColumn;
  Giorno: TGiorno;
  Ora: TOra;
  colName: string;
  bandWidth: integer;
const
  DocentWidth = 200;
  GiornoWidth = 141;
  OraWidth = 80;
begin
  DestroyStructure;

  band := CreateBand('Docenti', DocentWidth, dx.cxStyleBtnFace);
  band.FixedKind := tlbfLeft;
  col := CreateColumn(band, 'colDocenti', '', DocentWidth);
  col.Position.LineCount := 2;

  for Giorno in RiepilogoGiornalieroAule.ElencoGiorni do
  begin
    bandWidth := Max(GiornoWidth, (OraWidth + 1) * Giorno.Ore.Count);
    band := CreateBand(FormatDateTime('dddd, dd mmm yyyy', Giorno.DataLezione), bandWidth, nil);

    for Ora in Giorno.Ore do
    begin
      colName := 'colSigla' + RiepilogoGiornalieroAule.GetColumnName(Giorno.DataLezione, Ora.OraInizio);
      col := CreateColumn(band, colName, FormatDateTime('HH:MM', Ora.OraInizio), OraWidth);
      Ora.ColonnaProgetto := col;

      colName := 'colAula' + RiepilogoGiornalieroAule.GetColumnName(Giorno.DataLezione, Ora.OraInizio);
      col := CreateColumn(band, colName, '', OraWidth);
      col.Position.RowIndex := 1;
      Ora.ColonnaAula := col;
    end;
  end;
end;

procedure TFrameRiepilogoGiornalieroAule.LoadTree;
var
  node: TcxTreeListNode;
  ColonnaProgetto, ColonnaAula: TcxTreeListColumn;
  Docente: TDocente;
  idxDocente: integer;
  Lezione: TLezione;
begin
  StartWait('Attendere...', true);
  try
    tree.BeginUpdate;
    try
      tree.Clear;

      CreateStructure;

      for Docente in RiepilogoGiornalieroAule.ElencoDocenti do
      begin
        node := tree.Add;
        Docente.node := node;
        node.Texts[0] := Docente.Nominativo;

        for Lezione in Docente.Lezioni do
        begin
          //
          if not RiepilogoGiornalieroAule.GetColumns(Lezione.DataLezione, Lezione.OraInizio, ColonnaProgetto, ColonnaAula) then
            raise Exception.Create('Errore struttura: Data: ' + DateToStr(Lezione.DataLezione) + ' - Ora: ' + TimeToStr(Lezione.OraInizio));

          node.Texts[ColonnaProgetto.ItemIndex] := ' ' + Lezione.SiglaProgetto;
          node.Texts[ColonnaAula.ItemIndex] := ' ' + Lezione.Aula;

          Lezione.ColonnaProgetto := ColonnaProgetto;
          Lezione.ColonnaAula := ColonnaAula;
        end;
      end;
    finally
      tree.EndUpdate;
    end;
  finally
    StopWait;
  end;
end;

procedure TFrameRiepilogoGiornalieroAule.edDalGiornoPropertiesEditValueChanged(Sender: TObject);
begin

  if StartDate <> edDalGiorno.Date then
    StartDate := edDalGiorno.Date;
end;

procedure TFrameRiepilogoGiornalieroAule.Esporta(const FileName: string);
var
  i: integer;
begin
  inherited;
  cxExportTLToXLSX(FileName, tree, true, true, true);

  if ConfirmYesNo('Si desidera aprire il file esportato?', mtWarning) then
  begin
    i := ShellExecute(0, 'open', Pchar(FileName), nil, nil, SW_RESTORE);

    // se non riesce ad aprire il file apre la cartella
    if i <= 32 then
      ShellExecute(0, Pchar('open'), Pchar(ExtractFilePath(FileName)), nil, nil, SW_RESTORE);
    // ConfirmOk(FileName + ': ' + i.ToString);
  end;
end;

procedure TFrameRiepilogoGiornalieroAule.Stampa;
begin
  dxComponentPrinterLink.PrinterPage.Orientation := poLandscape;
  dxComponentPrinter.Preview(true);
end;

procedure TFrameRiepilogoGiornalieroAule.actEsportaAccept(Sender: TObject);
begin
  inherited;
  Esporta(actEsporta.Dialog.FileName);
end;

function TFrameRiepilogoGiornalieroAule.getColorStyle(Color: TColor): TcxStyle;
var
  i: integer;
begin
  result := nil;

  for i := 0 to ColorRepository.Count - 1 do
    if ColorRepository.Items[i] is TcxStyle then
      if TcxStyle(ColorRepository.Items[i]).Color = Color then
      begin
        result := TcxStyle(ColorRepository.Items[i]);
        exit;
      end;

  result := TcxStyle(ColorRepository.CreateItem(TcxStyle));
  result.Color := Color;
  result.TextColor := GetContrastColor(Color);
end;

procedure TFrameRiepilogoGiornalieroAule.PrecedenteExecute(Sender: TObject);
begin
  IncrementaPeriodo(false);
end;

procedure TFrameRiepilogoGiornalieroAule.SuccessivaExecute(Sender: TObject);
begin
  IncrementaPeriodo(true);
end;

procedure TFrameRiepilogoGiornalieroAule.IncrementaPeriodo(Incrementa: Boolean);
var
  Data: TDateTime;
  Delta: smallint;
begin
  if Incrementa then
    Delta := 1
  else
    Delta := -1;

  StartDate := IncWeek(StartOfTheWeek(StartDate), Delta);
end;

procedure TFrameRiepilogoGiornalieroAule.SetStartDate(const Value: TDate);
begin

  if FStartDate <> Value then
  begin
    FStartDate := Value;
    edDalGiorno.Date := StartDate;
    Aule.LoadRiepilogoGiornalieroAule(StartDate, RiepilogoGiornalieroAule);
    LoadTree;
  end;
end;

procedure TFrameRiepilogoGiornalieroAule.treeDblClick(Sender: TObject);
var
  Lezione: TLezione;
begin

  if tree.HitTest.HitAtNode then
    if tree.HitTest.HitAtColumn then
      if tree.HitTest.HitColumn.Position.BandIndex > 0 then
        if RiepilogoGiornalieroAule.GetLezione(tree.HitTest.HitNode, tree.HitTest.HitColumn, Lezione) then
          // ConfirmOk('Modificare IdOrario: ' + Lezione.IdOrario.ToString);
          { TODO : In funzione del tipo }
          if Aule.ApriOrario(Lezione.IdOrario) then
            LoadTree;
end;

procedure TFrameRiepilogoGiornalieroAule.treeStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; var AStyle: TcxStyle);
var
  Lezione: TLezione;
begin

  if assigned(AColumn) then
  begin
    if odd(AColumn.Position.BandIndex) then
      AStyle := dx.cxStyleContentOdd
    else
      AStyle := dx.cxStyleContentEven;

    if assigned(ANode) then
      if RiepilogoGiornalieroAule.GetLezione(ANode, AColumn, Lezione) then
        AStyle := getColorStyle(Lezione.Colore);
  end;
end;

procedure TFrameRiepilogoGiornalieroAule.dxComponentPrinterLinkInitializeCell(Sender: TcxTreeListCustomReportLink; ANode: TcxTreeListNode; AColumn: TcxTreeListColumn;
  AnItem: TAbstractdxReportCellData);
var
  Lezione: TLezione;
begin

  if assigned(AColumn) then
    if assigned(ANode) then
      if RiepilogoGiornalieroAule.GetLezione(ANode, AColumn, Lezione) then
      begin
        AnItem.Color := Lezione.Colore;
        // AnItem.Font.Color := GetContrastColor(AnItem.Color);
      end;
end;

end.
