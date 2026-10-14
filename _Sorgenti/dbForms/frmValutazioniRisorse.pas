unit frmValutazioniRisorse;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnList,
  Vcl.StdActns,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  BaseFrm,
  cxCustomData,
  cxStyles,
  dxScrollbarAnnotations,
  cxTL,
  cxTLdxBarBuiltInMenu,
  cxInplaceContainer,
  cxEditRepositoryItems,
  cxExtEditRepositoryItems,
  cxSplitter,
  cxFilterControl,
  ValutazioniPrestazioni.types,
  ValutazioniPrestazioni.classi,
  cxTextEdit,
  cxDropDownEdit,
  cxCalendar,
  cxCheckBox,
  cxHyperLinkEdit,
  cxTLExportLink,
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
  dxPScxEditorProducers,
  dxPScxExtEditorProducers,
  dxPSCore,
  dxPScxCommon,
  dxPScxTLLnk,
  cxImageComboBox,
  dxFileActions, dxPSdxSpreadSheetLnk, dxPScxSchedulerLnk, cxFilter;

type
  TFormValutazioniRisorse = class(TBaseForm)
    ActionList: TActionList;
    dxBarButton1: TdxBarButton;
    Esporta: TdxFileSaveAs;
    tree: TcxTreeList;
    cxEditRepository: TcxEditRepository;
    cxEditRepositoryTipoRisorsa: TcxEditRepositoryImageComboBoxItem;
    cxEditRepositoryNominativo: TcxEditRepositoryLabel;
    cxEditRepositoryTipologiaFornitore: TcxEditRepositoryImageComboBoxItem;
    cxEditRepositoryData: TcxEditRepositoryDateItem;
    cxEditRepositoryTipoInquadramento: TcxEditRepositoryLabel;
    cxEditRepositoryTipoContratto: TcxEditRepositoryImageComboBoxItem;
    cxEditRepositoryBoolean: TcxEditRepositoryCheckBoxItem;
    cxEditRepositoryStatoRisorsa: TcxEditRepositoryImageComboBoxItem;
    cxEditRepositoryDescStatoRisorsa: TcxEditRepositoryLabel;
    cxEditRepositoryIdValutazione: TcxEditRepositoryLabel;
    cxEditRepositoryAnnoValutazione: TcxEditRepositoryLabel;
    cxEditRepositoryValutazione: TcxEditRepositoryLabel;
    cxEditRepositoryDescValutazione: TcxEditRepositoryLabel;
    treeColIdRisorsa: TcxTreeListColumn;
    treeColTipoRisorsa: TcxTreeListColumn;
    treeColNominativo: TcxTreeListColumn;
    treeColTipologiaFornitore: TcxTreeListColumn;
    treeColDataAttivazione: TcxTreeListColumn;
    treeColDataDisattivazione: TcxTreeListColumn;
    treeColDataInizioValiditaInquadramento: TcxTreeListColumn;
    treeColDataFineValiditaInquadramento: TcxTreeListColumn;
    treeColTipoInquadramento: TcxTreeListColumn;
    treeColTipoContratto: TcxTreeListColumn;
    treeColBloccaIncarichi: TcxTreeListColumn;
    treeColStatoRisorsa: TcxTreeListColumn;
    treeColDescStatoRisorsa: TcxTreeListColumn;
    cxEditRepositoryIdRisorsa: TcxEditRepositoryHyperLinkItem;
    dxComponentPrinter: TdxComponentPrinter;
    dxComponentPrinterLink: TcxTreeListReportLink;
    treeColDescTipologiaFornitore: TcxTreeListColumn;
    procedure EsportaAccept(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure BeforeShow; override;
  private
    function ColumnIndex(Campo: TCampoValutazione; Anno: integer): integer;
    function CreateColumn(const Name, Caption: string; RepositoryItem: TcxEditRepositoryItem; Const visible: boolean; const Anno: integer = -1): TcxTreeListColumn;
    procedure CreateColumns;
    procedure DestroyColumns;
    procedure CaricaDati;
  public
    procedure Stampa; override;
    procedure Aggiorna; virtual;
  end;

var
  FormValutazioniRisorse: TFormValutazioniRisorse;

implementation

uses
  dmValutazioniRisorse,
  zDm_Images,
  zDX,
  Winapi.ShellAPI,
  System.DateUtils,
  zBaseLib;

{$R *.dfm}
{ TFormValutazioniRisorse }

procedure TFormValutazioniRisorse.CreateDataModule;
begin
  inherited;
  CreateDM(TValutazioniRisorse, ValutazioniRisorse);
end;

procedure TFormValutazioniRisorse.DestroyDataModule;
begin
  inherited;
  FreeAndNil(ValutazioniRisorse);
end;

procedure TFormValutazioniRisorse.FormCreate(Sender: TObject);
begin
  inherited;
  ReportGroup := 'Valutazioni Risorse';
  Caption := 'Valutazioni Risorse';

  ActionList.Images := dx.Immagini;

  dx.InitTreeList(tree);
  dx.InitPrinter(dxComponentPrinter);

  // dx.InitPickList(cxEditRepositoryTipoRisorsa.Properties, 'TIPO_RISORSA');
  // dx.InitPickList(cxEditRepositoryTipologiaFornitore.Properties, 'TIPOLOGIA_FORNITORE');
  // dx.InitPickList(cxEditRepositoryTipoContratto.Properties, 'TIPO_CONTRATTO');
  // dx.InitPickList(cxEditRepositoryStatoRisorsa.Properties, 'STATO_RISORSA');
end;

procedure TFormValutazioniRisorse.Aggiorna;
begin
  inherited;
  CaricaDati;
end;

procedure TFormValutazioniRisorse.DestroyColumns;
var
  i: integer;
  col: TcxTreeListColumn;
begin
  for i := tree.ColumnCount - 1 downto 0 do
  begin
    col := tree.Columns[i];

    if col.Position.BandIndex = 1 then
      col.Free;
  end;
end;

procedure TFormValutazioniRisorse.Stampa;
begin
  // inherited;
  dxComponentPrinterLink.Preview(true);
end;

procedure TFormValutazioniRisorse.EsportaAccept(Sender: TObject);
begin
  inherited;
  cxExportTLToExcel(Esporta.Dialog.FileName, tree, true, true, false);
  ShellExecute(0, PCHAR('open'), PCHAR(Esporta.Dialog.FileName), nil, nil, SW_RESTORE);
end;

procedure TFormValutazioniRisorse.BeforeShow;
begin
  inherited;
  CaricaDati;
end;

function TFormValutazioniRisorse.CreateColumn(const Name, Caption: string; RepositoryItem: TcxEditRepositoryItem; Const visible: boolean; const Anno: integer = -1): TcxTreeListColumn;
begin
  result := tree.CreateColumn(tree.Bands[0]);
  result.Name := 'treeCol' + Name + '_' + Anno.ToString;
  result.Caption.Text := Caption;
  result.Caption.AlignHorz := taCenter;
  result.DataBinding.ValueType := 'String';
  result.RepositoryItem := RepositoryItem;
  result.Position.BandIndex := 1;
  result.Position.RowIndex := 0;
  result.Position.ColIndex := tree.ColumnCount;
  result.Options.IncSearch := false;
  result.Options.Moving := false;
  result.Options.Sorting := false;
  result.Focused := true;
  result.Tag := Anno;
  result.visible := visible;

  result.Styles.Header := dx.GetStyle(scBtnFace);
end;

procedure TFormValutazioniRisorse.CreateColumns;
var
  Anno: integer;
  i: integer;
  col: TcxTreeListColumn;
begin
  tree.BeginUpdate;
  try
    tree.Clear;

    DestroyColumns;

    /// //////////////////////////////
    for i := 0 to ValutazioniRisorse.ElencoValutazioni.NumeroAnnualita - 1 do
    begin
      Anno := ValutazioniRisorse.ElencoValutazioni.AnnoMin + i;
      col := CreateColumn('Valutazione', 'Valutazione ' + sLineBreak + Anno.ToString, cxEditRepositoryValutazione, true, Anno);
      col.Caption.MultiLine := true;
      col.Width := 75;
      col.BestFitMaxWidth := 75;

      col := CreateColumn('IdValutazione', 'Id Valutazione', cxEditRepositoryIdValutazione, false, Anno);
      col := CreateColumn('AnnoValutazione', 'Anno Valutazione', cxEditRepositoryAnnoValutazione, false, Anno);
      col := CreateColumn('DataValutazione', 'Data Valutazione', cxEditRepositoryData, false, Anno);
      col := CreateColumn('DescValutazione', 'Desc Valutazione', cxEditRepositoryDescValutazione, false, Anno);
    end;
  finally
    tree.EndUpdate;
  end;
end;

function TFormValutazioniRisorse.ColumnIndex(Campo: TCampoValutazione; Anno: integer): integer;
var
  FirstCol: integer;
  MoltiplicatoreAnno: integer;
  NumeroCampi: integer;
  PosCampo: integer;
begin
  FirstCol := treeColDescStatoRisorsa.ItemIndex;

  MoltiplicatoreAnno := (Anno - ValutazioniRisorse.ElencoValutazioni.AnnoMin);
  NumeroCampi := 5;

  case Campo of
    cvValutazione:
      PosCampo := 1;
    cvIdValutazione:
      PosCampo := 2;
    cvAnnoValutazione:
      PosCampo := 3;
    cvDataValutazione:
      PosCampo := 4;
    cvDescValutazione:
      PosCampo := 5;
  end;

  result := FirstCol + (MoltiplicatoreAnno * NumeroCampi) + PosCampo;
end;

procedure TFormValutazioniRisorse.CaricaDati;
var
  idx: integer;
  nodo: TcxTreeListNode;
  Risorsa: TRisorsa;
  Valutazione: TValutazione;

  function DataValue(const Data: TDateTime): variant;
  begin
    if YearOf(Data) = 1899 then
      result := null
    else
      result := Data;
  end;

begin
  StartWait('Attendere...', true);
  try
    ValutazioniRisorse.LoadValutazioni;

    tree.BeginUpdate;
    try
      tree.Clear;

      CreateColumns;

      for Risorsa in ValutazioniRisorse.ElencoValutazioni.Risorse do
      begin
        nodo := tree.Root.AddChild;

        nodo.Values[treeColIdRisorsa.ItemIndex] := Risorsa.IdRisorsa;

        nodo.Values[treeColIdRisorsa.ItemIndex] := Risorsa.IdRisorsa;
        nodo.Values[treeColTipoRisorsa.ItemIndex] := Risorsa.TipoRisorsa;
        nodo.Values[treeColNominativo.ItemIndex] := Risorsa.Nominativo;
        nodo.Values[treeColDescTipologiaFornitore.ItemIndex] := Risorsa.TipologiaFornitore.Description;
        nodo.Values[treeColDataAttivazione.ItemIndex] := DataValue(Risorsa.DataAttivazione);
        nodo.Values[treeColDataDisattivazione.ItemIndex] := DataValue(Risorsa.DataDisattivazione);
        nodo.Values[treeColDataInizioValiditaInquadramento.ItemIndex] := DataValue(Risorsa.DataInizioValiditaInquadramento);
        nodo.Values[treeColDataFineValiditaInquadramento.ItemIndex] := DataValue(Risorsa.DataFineValiditaInquadramento);
        nodo.Values[treeColTipoInquadramento.ItemIndex] := Risorsa.TipoInquadramento;
        nodo.Values[treeColTipoContratto.ItemIndex] := Risorsa.TipoContratto;
        nodo.Values[treeColBloccaIncarichi.ItemIndex] := Risorsa.BloccaIncarichi;
        nodo.Values[treeColStatoRisorsa.ItemIndex] := Risorsa.StatoRisorsa;
        nodo.Values[treeColDescStatoRisorsa.ItemIndex] := Risorsa.DescStatoRisorsa;

        for Valutazione in Risorsa.Valutazioni do
        begin
          nodo.Values[ColumnIndex(cvValutazione, Valutazione.AnnoValutazione)] := Valutazione.Valutazione;
          nodo.Values[ColumnIndex(cvIdValutazione, Valutazione.AnnoValutazione)] := Valutazione.IdValutazione;
          nodo.Values[ColumnIndex(cvAnnoValutazione, Valutazione.AnnoValutazione)] := Valutazione.AnnoValutazione;
          nodo.Values[ColumnIndex(cvDataValutazione, Valutazione.AnnoValutazione)] := DataValue(Valutazione.DataValutazione);
          nodo.Values[ColumnIndex(cvDescValutazione, Valutazione.AnnoValutazione)] := Valutazione.DescValutazione;
        end;
      end;

      tree.ApplyBestFit;
    finally
      tree.EndUpdate;
    end;
  finally
    StopWait;
  end;
end;

end.zsystem zDX
