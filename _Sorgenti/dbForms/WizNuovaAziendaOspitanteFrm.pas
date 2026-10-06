unit WizNuovaAziendaOspitanteFrm;

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
  BaseWizrd,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  System.ImageList,
  Vcl.ImgList,
  System.Actions,
  Vcl.ActnList,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  Vcl.ExtCtrls,
  zDbCard,
  zFbDataSet,
  zDbView,
  data.db,
  cxTextEdit,
  cxMemo,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.Mask,
  dxLayoutContainer,
  dxLayoutControl,
  dxLayoutControlAdapters,
  Vcl.Menus,
  cxButtons,
  dxLayoutcxEditAdapters,
  cxMaskEdit,
  dxGDIPlusClasses,
  cxImage,
  cxRadioGroup,
  cxDropDownEdit,
  cxImageComboBox,
  cxImageList,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  zFileViewer,
  Base_DataModule,
  dxLayoutLookAndFeels,
  cxSplitter,
  dxCustomWizardControl,
  dxWizardControl,
  cxDBCheckComboBox,
  cxCheckBox;

type
  TWizNuovaAziendaOspitanteForm = class(TBaseWizard)
    memoRiepilogo: TcxMemo;
    dxLayoutControlRicercaGroup_Root: TdxLayoutGroup;
    dxLayoutControlRicerca: TdxLayoutControl;
    cardAziendaDetail: TzDbCard;
    ImageList: TImageList;
    pageSediOperative: TdxWizardControlPage;
    pageAziendaDetail: TdxWizardControlPage;
    pageContatti: TdxWizardControlPage;
    viewSediOperative: TzDbView;
    cardAzienda: TzDbCard;
    edCodiceFiscale: TcxMaskEdit;
    edPartitaIVA: TcxTextEdit;
    btnCerca: TcxButton;
    Cerca: TAction;
    dxLayoutItemCodiceFiscale: TdxLayoutItem;
    dxLayoutItemPartitaIva: TdxLayoutItem;
    dxLayoutItemCerca: TdxLayoutItem;
    dxLayoutGroupRicerca: TdxLayoutGroup;
    dxLayoutItemCardAzienda: TdxLayoutItem;
    pnlAmbiti: TPanel;
    cxSplitter1: TcxSplitter;
    viewAmbiti: TzDbView;
    cxSplitter2: TcxSplitter;
    viewMansioni: TzDbView;
    pageConvenzioni: TdxWizardControlPage;
    viewContatti: TzDbView;
    viewConvenzioni: TzDbView;
    checkEstero: TcxCheckBox;
    dxLayoutItemEstero: TdxLayoutItem;
    procedure CercaExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure WizardPageChanging(Sender: TObject; ANewPage: TdxWizardControlCustomPage; var AAllow: Boolean);
  private
  protected
    function ConfermaAnnulla: Boolean; override;
    function ConfermaChiusura: Boolean; override;
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
  end;

function InserisciNuovaAziendaOspitante: Integer;

implementation

uses
  WizNuovaAziendaOspitanteDM, zCodiceFiscale, zDm_Images, ConfigModule,
  zBaseLib, zDbViewDlg, Files.Lib, zDX, cxFilter, zSystem,   zMsg;

{$R *.dfm}

function InserisciNuovaAziendaOspitante: Integer;
var
  WizNuovaAziendaOspitanteForm: TWizNuovaAziendaOspitanteForm;
begin
  result := -1;

  Application.CreateForm(TWizNuovaAziendaOspitanteForm, WizNuovaAziendaOspitanteForm);
  try
    if WizNuovaAziendaOspitanteForm.ShowForm(True) then
      result := WizNuovaAziendaOspitante.IdAzienda;
  finally
    FreeAndNil(WizNuovaAziendaOspitanteForm);
  end;
end;

function TWizNuovaAziendaOspitanteForm.ConfermaAnnulla: Boolean;
begin
  result := False;
  if CloseQuery then
    result := WizNuovaAziendaOspitante.ConfermaAnnulla;
end;

function TWizNuovaAziendaOspitanteForm.ConfermaChiusura: Boolean;
begin
  result := WizNuovaAziendaOspitante.ConfermaChiusura;
end;

procedure TWizNuovaAziendaOspitanteForm.CreateDataModule;
begin
  inherited;
  CreateDM(TWizNuovaAziendaOspitante, WizNuovaAziendaOspitante);
end;

procedure TWizNuovaAziendaOspitanteForm.DestroyDataModule;
begin
  inherited;
  FreeAndNil(WizNuovaAziendaOspitante);
end;

procedure TWizNuovaAziendaOspitanteForm.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Inserimento Azienda Ospitante';
  ReportGroup := 'Wizard Azienda Ospitante';

  setPageIndex([pageWelcome, pageAziendaDetail, pageContatti, pageConvenzioni, pageSediOperative, pageFinish]);

  cardAzienda.CardID := Name + '.' + cardAzienda.Name;
  cardAziendaDetail.CardID := Name + '.' + cardAziendaDetail.Name;

  cardAzienda.zDataSet := WizNuovaAziendaOspitante.Aziende;
  cardAziendaDetail.zDataSet := WizNuovaAziendaOspitante.Aziende;
  viewContatti.zDataSet := WizNuovaAziendaOspitante.Contatti;
  viewConvenzioni.zDataSet := WizNuovaAziendaOspitante.Convenzioni;
  viewSediOperative.zDataSet := WizNuovaAziendaOspitante.SediOperative;
  viewAmbiti.zDataSet := WizNuovaAziendaOspitante.Ambiti;
  viewMansioni.zDataSet := WizNuovaAziendaOspitante.Mansioni;
end;

procedure TWizNuovaAziendaOspitanteForm.WizardPageChanging(Sender: TObject; ANewPage: TdxWizardControlCustomPage; var AAllow: Boolean);
var
  isNext: Boolean;
begin
  inherited;

  if not Assigned(Wizard.ActivePage) then
    Exit;

  /// ///////

  isNext := ANewPage.PageIndex >= Wizard.ActivePage.PageIndex;

  if isNext then
  begin

    if Wizard.ActivePage = pageWelcome then
    begin
      WizNuovaAziendaOspitante.VerificaCodiceFiscale;
      WizNuovaAziendaOspitante.Aziende.CheckBrowseMode;
    end;

    if Wizard.ActivePage = pageAziendaDetail then
      WizNuovaAziendaOspitante.Aziende.CheckBrowseMode;

    if Wizard.ActivePage = pageConvenzioni then
      if WizNuovaAziendaOspitante.Convenzioni.IsEmpty then
        ConfirmOk('Nessuna convenzione inserita.');

    if Wizard.ActivePage = pageSediOperative then
      if WizNuovaAziendaOspitante.SediOperative.IsEmpty then
        ConfirmOk('Nessuna sede operativa inserita.');

    if Wizard.ActivePage = pageContatti then
      if WizNuovaAziendaOspitante.Contatti.IsEmpty then // raffinare
        ConfirmOk('Nessun contatto/tutor aziendale inserita.');

    if ANewPage = pageFinish then
      memoRiepilogo.Lines.Text := WizNuovaAziendaOspitante.GetRiepilogo;
  end;
end;

procedure TWizNuovaAziendaOspitanteForm.CercaExecute(Sender: TObject);
begin
  inherited;
  WizNuovaAziendaOspitante.InizializzaAzienda(edCodiceFiscale.Text, edPartitaIVA.Text, checkEstero.Checked);
end;

end.
