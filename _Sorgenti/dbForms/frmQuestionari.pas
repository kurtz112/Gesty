unit frmQuestionari;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  BaseFrm,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  System.Actions,
  Vcl.ActnList,
  dxBar,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  zDbView,
  zDbPivot,
  zSystem,
  zFormController,
  dxLayoutcxEditAdapters,
  dxLayoutContainer,
  cxSpinEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  dxLayoutControl,
  cxImageComboBox,
  cxDBExtLookupComboBox,
   zProgressBox,
  dxLayoutControlAdapters,
  Vcl.Menus,
  Vcl.StdCtrls,
  cxButtons,
  cxCheckBox,
  Vcl.StdActns,
  dxFileActions,
  dxUIAClasses;

type
  TFormQuestionari = class(TBaseForm)
    ActionList: TActionList;
    CopiaLinkSuClipboard: TAction;
    GeneraQuestionari: TAction;
    DuplicaQuestionario: TAction;
    Test_Questionario: TAction;
    Test_Progetto: TAction;
    SalvaLinkSuFile: TAction;
    layoutFiltri: TdxLayoutControl;
    layoutFiltriGroup_Root: TdxLayoutGroup;
    edFiltroEnte: TcxImageComboBox;
    edFiltroAnnoFormativoProgetto: TcxImageComboBox;
    edFiltroProgetto: TcxExtLookupComboBox;
    dxLayoutItemEnte: TdxLayoutItem;
    dxLayoutItemAnnoFormativoProgetto: TdxLayoutItem;
    dxLayoutItemProgetto: TdxLayoutItem;
    dxLayoutItemCorso: TdxLayoutItem;
    edFiltroCorso: TcxExtLookupComboBox;
    ProgressBox: TProgressBox;
    edFiltroAreaRiferimento: TcxImageComboBox;
    edFiltroDocente: TcxExtLookupComboBox;
    dxLayoutItemAreaRiferimento: TdxLayoutItem;
    dxLayoutItemDocente: TdxLayoutItem;
    dxLayoutGroupTop: TdxLayoutGroup;
    dxLayoutGroupBottom: TdxLayoutGroup;
    dxBarLargeButton1: TdxBarLargeButton;
    edFiltroQuestionario: TcxExtLookupComboBox;
    dxLayoutItemQuestionario: TdxLayoutItem;
    dxLayoutGroupProgetto: TdxLayoutGroup;
    btnGeneraReportCustom: TcxButton;
    GeneraReport: TdxFileOpen;
    dxLayoutItemGeneraReportCustom: TdxLayoutItem;
    edFiltroRaggruppamento: TcxExtLookupComboBox;
    dxLayoutItemRaggruppamento: TdxLayoutItem;
    edFiltroAnnoFormativoCorso: TcxImageComboBox;
    dxLayoutGroupCorso: TdxLayoutGroup;
    dxLayoutItemAnnoFormativoCorso: TdxLayoutItem;
    dxLayoutGroupMain: TdxLayoutGroup;
    dxLayoutEmptySpaceItem: TdxLayoutEmptySpaceItem;
    procedure FormCreate(Sender: TObject);
    procedure CopiaLinkSuClipboardExecute(Sender: TObject);
    procedure DuplicaQuestionarioExecute(Sender: TObject);
    procedure GeneraQuestionariExecute(Sender: TObject);
    procedure SalvaLinkSuFileExecute(Sender: TObject);
    procedure Test_ProgettoExecute(Sender: TObject);
    procedure Test_QuestionarioExecute(Sender: TObject);
    procedure edFiltroEntePropertiesEditValueChanged(Sender: TObject);
    procedure edFiltroAnnoFromativoPropertiesEditValueChanged(Sender: TObject);
    procedure edFiltroProgettoPropertiesEditValueChanged(Sender: TObject);
    procedure edFiltroCorsoPropertiesEditValueChanged(Sender: TObject);
    procedure edFiltroAreaRiferimentoPropertiesEditValueChanged(Sender: TObject);
    procedure edFiltroDocentePropertiesEditValueChanged(Sender: TObject);
    procedure edFiltroQuestionarioPropertiesEditValueChanged(Sender: TObject);
    procedure GeneraReportAccept(Sender: TObject);
    procedure GeneraReportBeforeExecute(Sender: TObject);
    procedure edFiltroRaggruppamentoPropertiesEditValueChanged(Sender: TObject);
    procedure edFiltroAnnoFormativoCorsoPropertiesEditValueChanged(Sender: TObject);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure AfterCreateControls; override;
    procedure DatasetSelected(DiagramDataSet: TzDiagramDataSet); override;
  public
  end;

var
  FormQuestionari: TFormQuestionari;

implementation

uses
  dmQuestionari,
  zDm_Images,
  zDX,
  zOffice.Excel.Utils,
  Gesty_Filters;

{$R *.dfm}

procedure TFormQuestionari.CreateDataModule;
begin
  inherited;
  CreateDM(TQuestionari, Questionari);
end;

procedure TFormQuestionari.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Questionari);
end;

procedure TFormQuestionari.FormCreate(Sender: TObject);
begin
  inherited;
  // Questionari_Analisi_Risposte_Valutazione_Docenti: Numero risposte � MAX
  // per mail Ughetto 23.12.2022: "Valutazione dei docenti: il n� risposte moltiplica il n� effettivo di risposte (persone) x il numero totale delle domande (7 persone x 6 domande = 42)"

  ReportGroup := 'Risorse';
  Caption := 'Risorse';

  layoutFiltri.Visible := False;
  layoutFiltri.Parent := Self;
  dx.InitLayoutControl(layoutFiltri);
  layoutFiltri.Height := 120;

  TEnteBarFilter.InitProperties(edFiltroEnte.Properties);
  TAnnoFormativoBarFilter.InitProperties(edFiltroAnnoFormativoProgetto.Properties);
  TAnnoFormativoBarFilter.InitProperties(edFiltroAnnoFormativoCorso.Properties);
  TAreaRiferimentoBarFilter.InitProperties(edFiltroAreaRiferimento.Properties);

  dx.InitLookup('', edFiltroQuestionario, Questionari.lkQuestionari, Questionari.lkQuestionariSrc, 'ID_QUESTIONARIO', 'TITOLO_QUESTIONARIO');
  dx.InitLookup('', edFiltroRaggruppamento, Questionari.lkRaggruppamenti, Questionari.lkRaggruppamentiSrc, 'RAGGRUPPAMENTO', 'RAGGRUPPAMENTO');
  dx.InitLookup('', edFiltroProgetto, Questionari.lkProgetti, Questionari.lkProgettiSrc, 'ID_PROGETTO', 'DENOMINAZIONE_PROGETTO;ANNO_FORMATIVO');
  dx.InitLookup('', edFiltroCorso, Questionari.lkCorsi, Questionari.lkCorsiSrc, 'ID_CORSO', 'DESC_CORSO_COMPLETA;ID_CORSO');
  dx.InitLookup('', edFiltroDocente, Questionari.lkDocenti, Questionari.lkDocentiSrc, 'ID_RISORSA', 'NOMINATIVO_O_RAGIONE_SOCIALE;ID_RISORSA');

  edFiltroQuestionario.EditValue := Questionari.FiltroQuestionario;
  edFiltroEnte.EditValue := Questionari.FiltroEnte;
  edFiltroRaggruppamento.EditValue := Questionari.FiltroRaggruppamento;
  edFiltroAnnoFormativoProgetto.EditValue := Questionari.FiltroAnnoFormativoProgetto;
  edFiltroAnnoFormativoCorso.EditValue := Questionari.FiltroAnnoFormativoCorso;
  edFiltroProgetto.EditValue := Questionari.FiltroProgetto;
  edFiltroCorso.EditValue := Questionari.FiltroCorso;
end;

procedure TFormQuestionari.edFiltroAnnoFromativoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if varIsNull(edFiltroAnnoFormativoProgetto.EditValue) then
    Questionari.FiltroAnnoFormativoProgetto := ''
  else
    Questionari.FiltroAnnoFormativoProgetto := edFiltroAnnoFormativoProgetto.EditValue;

  edFiltroProgetto.ItemIndex := -1;
  edFiltroCorso.ItemIndex := -1;
end;

procedure TFormQuestionari.edFiltroAnnoFormativoCorsoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if varIsNull(edFiltroAnnoFormativoCorso.EditValue) then
    Questionari.FiltroAnnoFormativoCorso := ''
  else
    Questionari.FiltroAnnoFormativoCorso := edFiltroAnnoFormativoCorso.EditValue;

  edFiltroCorso.ItemIndex := -1;
end;

procedure TFormQuestionari.edFiltroAreaRiferimentoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  edFiltroAreaRiferimento.SelStart := 0;

  if varIsNull(edFiltroAreaRiferimento.EditValue) then
    Questionari.FiltroAreaRiferimento := ''
  else
    Questionari.FiltroAreaRiferimento := edFiltroAreaRiferimento.EditValue;

  edFiltroProgetto.ItemIndex := -1;
  edFiltroCorso.ItemIndex := -1;
end;

procedure TFormQuestionari.edFiltroEntePropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if varIsNull(edFiltroEnte.EditValue) then
    Questionari.FiltroEnte := -1
  else
    Questionari.FiltroEnte := edFiltroEnte.EditValue;

  edFiltroProgetto.ItemIndex := -1;
  edFiltroCorso.ItemIndex := -1;
end;

procedure TFormQuestionari.edFiltroProgettoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  edFiltroProgetto.SelStart := 0;

  edFiltroCorso.ItemIndex := -1;

  if varIsNull(edFiltroProgetto.EditValue) then
    Questionari.FiltroProgetto := -1
  else
    Questionari.FiltroProgetto := edFiltroProgetto.EditValue;
end;

procedure TFormQuestionari.edFiltroQuestionarioPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if varIsNull(edFiltroQuestionario.EditValue) then
    Questionari.FiltroQuestionario := -1
  else
    Questionari.FiltroQuestionario := edFiltroQuestionario.EditValue;
end;

procedure TFormQuestionari.edFiltroRaggruppamentoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if varIsNull(edFiltroRaggruppamento.EditValue) then
    Questionari.FiltroRaggruppamento := ''
  else
    Questionari.FiltroRaggruppamento := edFiltroRaggruppamento.EditValue;
end;

procedure TFormQuestionari.edFiltroCorsoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  edFiltroCorso.SelStart := 0;

  if varIsNull(edFiltroCorso.EditValue) then
    Questionari.FiltroCorso := -1
  else
    Questionari.FiltroCorso := edFiltroCorso.EditValue;
end;

procedure TFormQuestionari.edFiltroDocentePropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  edFiltroDocente.SelStart := 0;

  if varIsNull(edFiltroDocente.EditValue) then
    Questionari.FiltroDocente := -1
  else
    Questionari.FiltroDocente := edFiltroDocente.EditValue;
end;

procedure TFormQuestionari.AfterCreateControls;
begin
  inherited;
  AddLayoutItem(layoutFiltri, 'FiltriRisposte', False);
end;

procedure TFormQuestionari.DuplicaQuestionarioExecute(Sender: TObject);
begin
  inherited;
  Questionari.DuplicaQuestionario;
end;

procedure TFormQuestionari.GeneraQuestionariExecute(Sender: TObject);
begin
  inherited;
  Questionari.GeneraQuestionari;
end;

procedure TFormQuestionari.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
// view: TzDbView;
// pivot: TzDbPivot;
// begin
// inherited;
//
// if Component is TzDbView then
// begin
// view := TzDbView(Component);
//
// if SameText(DataSetName, 'Progetti') then
// begin
// view.AddAction(Test_Progetto, zDmImages.ImageList16);
// view.InitToolActions;
//
// tools.AddFiltroAnnoFormativo(view, Questionari.GetDataSet('Progetti'));
// tools.AddFiltroEnte(view, Questionari.GetDataSet('Progetti'));
// end
// else
// if SameText(DataSetName, 'Studenti_Progetti') then
// begin
// view.AddAction(GeneraQuestionari, zDmImages.ImageList16);
// view.AddAction(CopiaLinkSuClipboard, zDmImages.ImageList16);
// view.AddAction(SalvaLinkSuFile, zDmImages.ImageList16);
// view.InitToolActions;
// end
// else
// if SameText(DataSetName, 'Questionari') then
// begin
// view.AddAction(DuplicaQuestionario, zDmImages.ImageList16);
// view.AddAction(Test_Questionario, zDmImages.ImageList16);
// view.InitToolActions;
// end
// else
// if SameText(DataSetName, 'Questionari_Risposte_Elenco') then
// begin
// tools.AddFiltroAnnoFormativo(view, Questionari.GetDataSet(DataSetName));
// tools.AddFiltroEnte(view, Questionari.GetDataSet(DataSetName));
// end
// else
// if SameText(DataSetName, 'Questionari_Analisi_Campione') then
// begin
// tools.AddFiltroAnnoFormativo(view, Questionari.GetDataSet(DataSetName));
// tools.AddFiltroEnte(view, Questionari.GetDataSet(DataSetName));
// end
// else
// if SameText(DataSetName, 'Questionari_Risp_Elenco_Suggerimenti') then
// begin
// tools.AddFiltroAnnoFormativo(view, Questionari.GetDataSet(DataSetName));
// tools.AddFiltroEnte(view, Questionari.GetDataSet(DataSetName));
// end;
// end
// else
// if Component is TzDbPivot then
// begin
// pivot := TzDbPivot(Component);
//
// if False then
// if Questionari.IsDatasetAnalisi(DataSetName) then
// begin
// tools.AddFiltroAnnoFormativo(pivot, Questionari.GetDataSet(DataSetName));
// tools.AddFiltroEnte(pivot, Questionari.GetDataSet(DataSetName));
// end;
// end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent }
end;

procedure TFormQuestionari.Test_ProgettoExecute(Sender: TObject);
begin
  inherited;
  Questionari.TestProgetto;
end;

procedure TFormQuestionari.Test_QuestionarioExecute(Sender: TObject);
begin
  inherited;
  Questionari.TestQuestionario;
end;

procedure TFormQuestionari.CopiaLinkSuClipboardExecute(Sender: TObject);
begin
  inherited;
  Questionari.CopiaLinkSuClipboard;
end;

procedure TFormQuestionari.SalvaLinkSuFileExecute(Sender: TObject);
begin
  inherited;
  Questionari.SalvaLinkSuFile;
end;

procedure TFormQuestionari.DatasetSelected(DiagramDataSet: TzDiagramDataSet);
begin
  inherited;
  edFiltroDocente.Enabled := SameText(DiagramDataSet.Name, 'Questionari_Analisi_Risposte_Valutazione_Docenti');
end;

procedure TFormQuestionari.GeneraReportAccept(Sender: TObject);
begin
  inherited;
  Questionari.GeneraReport(GeneraReport.Dialog.FileName);
end;

procedure TFormQuestionari.GeneraReportBeforeExecute(Sender: TObject);
begin
  inherited;
  GeneraReport.Dialog.InitialDir := Questionari.TemplateFolder(ReportGroup);
end;

end.

// campi calcolati
// activateDataset: se pivot => expand
// FullExpand: proprieta della pivot
// zdbpivot

// 72996
// 73273: in analisi campione risposte ricevute moltiplica per il numero di corsi
// 73273: in analisi campione per settore risposte ricevute moltiplica per il numero di corsi
//
// 2021/2022
// 42082
//
// --------------------------------
// Filtro Per Area Riferimento
// !!! Indirizzo Test

  Questionari.GeneraReport
(ReportGroup, checkSingolo.Checked);
