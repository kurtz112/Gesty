unit WizInserimentoPianiPersonalizzatiFrm;

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
  zDbView,
  Base_DataModule,
  dxCustomWizardControl,
  dxWizardControl,
  cxTextEdit,
  cxMemo;

type
  TWizInserimentoPianiPersonalizzatiForm = class(TBaseWizard)
    cardPiano: TzDbCard;
    viewServizi: TzDbView;
    AggiungiStudente: TAction;
    pageServiziErogati: TdxWizardControlPage;
    memoRiepilogo: TcxMemo;
    AggiungiServizi: TAction;
    procedure AggiungiServiziExecute(Sender: TObject);
    procedure AggiungiStudenteExecute(Sender: TObject);
    procedure cardPianoAfterCreateControls(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure WizardPageChanging(Sender: TObject; ANewPage: TdxWizardControlCustomPage; var AAllow: Boolean);
  protected
    function ConfermaAnnulla: Boolean; override;
    function ConfermaChiusura: Boolean; override;
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
  end;

function ApriInserimentoPianoPersonalizzato(const IdProgetto: integer; const DataInizioProgetto: TDateTime): Boolean;

implementation

uses
  WizInserimentoPianiPersonalizzatiDM,
  cxDBLookupComboBox;

{$R *.dfm}

function ApriInserimentoPianoPersonalizzato(const IdProgetto: integer; const DataInizioProgetto: TDateTime): Boolean;
var
  WizInserimentoPianiPersonalizzatiForm: TWizInserimentoPianiPersonalizzatiForm;
begin
  result := false;

  Application.CreateForm(TWizInserimentoPianiPersonalizzatiForm, WizInserimentoPianiPersonalizzatiForm);
  try
    WizInserimentoPianiPersonalizzati.Init(IdProgetto, DataInizioProgetto);

    result := WizInserimentoPianiPersonalizzatiForm.ShowForm(true);
  finally
    FreeAndNil(WizInserimentoPianiPersonalizzatiForm);
  end;
end;

procedure TWizInserimentoPianiPersonalizzatiForm.AggiungiServiziExecute(Sender: TObject);
begin
  inherited;
  WizInserimentoPianiPersonalizzati.AggiungiServizi;
end;

procedure TWizInserimentoPianiPersonalizzatiForm.CreateDataModule;
begin
  inherited;
  CreateDM(TWizInserimentoPianiPersonalizzati, WizInserimentoPianiPersonalizzati);
end;

procedure TWizInserimentoPianiPersonalizzatiForm.DestroyDataModule;
begin
  inherited;
  FreeAndNil(WizInserimentoPianiPersonalizzati);
end;

procedure TWizInserimentoPianiPersonalizzatiForm.FormCreate(Sender: TObject);
begin
  inherited;

  Caption := 'Inserimento Piano Personalizzato';
  ReportGroup := 'Wizard Inserimento Piano Personalizzato';

  SetPageIndex([pageWelcome, pageServiziErogati, pageFinish]);

  cardPiano.zDataSet := WizInserimentoPianiPersonalizzati.Piano;
  viewServizi.zDataSet := WizInserimentoPianiPersonalizzati.Servizi;
end;

function TWizInserimentoPianiPersonalizzatiForm.ConfermaAnnulla: Boolean;
begin
  result := false;
  if CloseQuery then
    result := WizInserimentoPianiPersonalizzati.ConfermaAnnulla;
end;

function TWizInserimentoPianiPersonalizzatiForm.ConfermaChiusura: Boolean;
begin
  result := WizInserimentoPianiPersonalizzati.ConfermaChiusura;
end;

procedure TWizInserimentoPianiPersonalizzatiForm.AggiungiStudenteExecute(Sender: TObject);
begin
  inherited;

  WizInserimentoPianiPersonalizzati.AggiungiStudente;
end;

procedure TWizInserimentoPianiPersonalizzatiForm.cardPianoAfterCreateControls(Sender: TObject);
var
  zCtrl: TzControl;
begin
  inherited;

  zCtrl := cardPiano.zControls.Find('ID_STUDENTE');
  if Assigned(zCtrl) then
    zCtrl.SetLookupTransactions(WizInserimentoPianiPersonalizzati.WriteTrans, WizInserimentoPianiPersonalizzati.WriteTrans);
end;

procedure TWizInserimentoPianiPersonalizzatiForm.WizardPageChanging(Sender: TObject; ANewPage: TdxWizardControlCustomPage; var AAllow: Boolean);
begin
  inherited;

  if Assigned(WizInserimentoPianiPersonalizzati) then
    if WizInserimentoPianiPersonalizzati.Piano.Active then
      WizInserimentoPianiPersonalizzati.Piano.CheckBrowseMode;

  if ANewPage = pageFinish then
    memoRiepilogo.Lines.Text := WizInserimentoPianiPersonalizzati.GetRiepilogo;
end;

end.
