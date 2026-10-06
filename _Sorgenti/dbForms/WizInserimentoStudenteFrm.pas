unit WizInserimentoStudenteFrm;

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
  zFileViewer,
  zDbView,
  zDbCard,
  cxSplitter,
  dxCustomWizardControl,
  dxWizardControl,
  dxUIAClasses;

type
  TWizInserimentoStudenteForm = class(TBaseWizard)
    viewGenitori: TzDbView;
    Splitter1: TcxSplitter;
    Panel1: TPanel;
    viewAllegatiGenitori: TzDbView;
    viewerAllegatiGenitori: TzFileViewer;
    Splitter2: TcxSplitter;
    viewBisogniEducativiSpeciali: TzDbView;
    cardStudente: TzDbCard;
    viewAllegatiStudente: TzDbView;
    Splitter3: TcxSplitter;
    viewerAllegatiStudente: TzFileViewer;

    pageAltriDati: TdxWizardControlPage;
    pageProgettiDoti: TdxWizardControlPage;
    pageGenitori: TdxWizardControlPage;
    pageBisogniEducativiSpeciali: TdxWizardControlPage;
    pageLingue: TdxWizardControlPage;
    pageEsperienze: TdxWizardControlPage;
    pageDispOrari: TdxWizardControlPage;
    pageContiCorrenti: TdxWizardControlPage;
    pageAllegatiStudente: TdxWizardControlPage;

    viewLingue: TzDbView;
    viewEsperienze: TzDbView;
    viewDispOrari: TzDbView;
    viewContiCorrenti: TzDbView;
    cardAltro: TzDbCard;
    viewFigureProfessionali: TzDbView;
    cxSplitter1: TcxSplitter;
    cardProgetti: TzDbCard;
    procedure viewerImportFile(sender: TzFileViewer; const FileName: string);
  private
    { Private declarations }
  protected
    function ConfermaAnnulla: Boolean; override;
    function ConfermaChiusura: Boolean; override;
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  WizInserimentoStudenteForm: TWizInserimentoStudenteForm;

function ApriInserimentoStudente: integer;

implementation

uses
  Files.lib,
  WizInserimentoStudenteDM,
  zFbDataSet,
  cxFilter;

{$R *.dfm}

function ApriInserimentoStudente: integer;
var
  WizInserimentoStudenteForm: TWizInserimentoStudenteForm;
begin
  result := -1;

  Application.CreateForm(TWizInserimentoStudenteForm, WizInserimentoStudenteForm);
  try
    WizInserimentoStudente.Init;

    if WizInserimentoStudenteForm.ShowForm(True) then
      result := WizInserimentoStudente.IdStudente;
  finally
    FreeAndNil(WizInserimentoStudenteForm);
  end;
end;

function TWizInserimentoStudenteForm.ConfermaAnnulla: Boolean;
begin
  result := False;
  if CloseQuery then
    result := WizInserimentoStudente.ConfermaAnnulla;
end;

function TWizInserimentoStudenteForm.ConfermaChiusura: Boolean;
begin
  result := WizInserimentoStudente.ConfermaChiusura;
end;

procedure TWizInserimentoStudenteForm.CreateDataModule;
begin
  inherited;
  CreateDM(TWizInserimentoStudente, WizInserimentoStudente);
end;

procedure TWizInserimentoStudenteForm.DestroyDataModule;
begin
  inherited;
  FreeAndNil(WizInserimentoStudente);
end;

constructor TWizInserimentoStudenteForm.Create(aOwner: TComponent);
  procedure SetCard(DataSet: TzFbDataSet; card: TzDbCard);
  begin
    if Assigned(card.zDataSet) then
      exit;

    card.cardId := Self.Name + '.' + card.Name;
    card.zDataSet := DataSet;
    card.UpdateColors;
  end;

begin
  inherited;

  Height := 800;
  Width := 980;

  Caption := 'Inserimento Destinatario Corso';
  ReportGroup := 'Wizard Inserimento Studente';

  setPageIndex([pageWelcome,

    pageAltriDati, pageGenitori, pageProgettiDoti, pageBisogniEducativiSpeciali, pageLingue, pageEsperienze, pageDispOrari, pageContiCorrenti, pageAllegatiStudente, pageFinish]);

  /// ////////////////////////

  SetCard(WizInserimentoStudente.Studenti, cardStudente);
  SetCard(WizInserimentoStudente.Studenti, cardAltro);
  // cardAltriDati

  cardProgetti.zDataSet := WizInserimentoStudente.Progetti;

  viewBisogniEducativiSpeciali.zDataSet := WizInserimentoStudente.BisogniEd;

  viewGenitori.zDataSet := WizInserimentoStudente.Genitori;

  viewLingue.zDataSet := WizInserimentoStudente.Lingue;
  viewFigureProfessionali.zDataSet := WizInserimentoStudente.FigureProfessionali;
  viewEsperienze.zDataSet := WizInserimentoStudente.Esperienze;
  viewDispOrari.zDataSet := WizInserimentoStudente.DispOrari;
  viewContiCorrenti.zDataSet := WizInserimentoStudente.ContiCorrenti;
  //
  viewAllegatiGenitori.zDataSet := WizInserimentoStudente.GenitoriFiles;
  viewerAllegatiGenitori.FieldName := 'FULL_FILE_NAME';
  viewerAllegatiGenitori.DataSet := WizInserimentoStudente.GenitoriFiles;
  //
  viewAllegatiStudente.zDataSet := WizInserimentoStudente.StudentiFiles;
  viewerAllegatiStudente.FieldName := 'FULL_FILE_NAME';
  viewerAllegatiStudente.DataSet := WizInserimentoStudente.StudentiFiles;
end;

procedure TWizInserimentoStudenteForm.viewerImportFile(sender: TzFileViewer; const FileName: string);
var
  idFile: integer;
  view: TzDbView;
begin
  inherited;
  idFile := ImportObjFile(GetOid(sender.DataSet), sender.DataSet, FileName, nil, false);

  view := nil;

  if sender = viewerAllegatiGenitori then
    view := viewAllegatiGenitori
  else
    if sender = viewerAllegatiStudente then
      view := viewAllegatiStudente;

  if Assigned(view) then
  begin
    view.ClearFilter(False);
    view.AddFilterCondition('ID_OBJECT_FILE', foEqual, pk);
    view.ShowRecord(False);
  end;
end;

end.

  zDbCard
