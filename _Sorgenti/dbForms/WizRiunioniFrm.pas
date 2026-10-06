unit WizRiunioniFrm;

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
  System.Actions,
  Vcl.ActnList,
  dxBarExtItems,
  cxClasses,
  dxCustomWizardControl,
  dxWizardControl,
  cxLabel;

type
  TWizRiunioniForm = class(TBaseWizard)
  private
  protected
    function ConfermaAnnulla: Boolean; override;
    function ConfermaChiusura: Boolean; override;
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;

    function NuovaRiunione: integer;
  end;

function NuovaRiunione: integer;

implementation

uses
  Files.lib,
  WizRiunioniDM;

{$R *.dfm}
{ TWizRiunioniForm }

function NuovaRiunione: integer;
var
  WizRiunioniForm: TWizRiunioniForm;
begin
  Application.CreateForm(TWizRiunioniForm, WizRiunioniForm);
  try
    result := WizRiunioniForm.NuovaRiunione;
  finally
    FreeAndNil(WizRiunioniForm);
  end;
end;

procedure TWizRiunioniForm.CreateDataModule;
begin
  inherited;
  CreateDM(TWizRiunioni, WizRiunioni);
end;

procedure TWizRiunioniForm.DestroyDataModule;
begin
  inherited;
  FreeAndNil(WizRiunioni);
end;

constructor TWizRiunioniForm.Create(aOwner: TComponent);
begin
  inherited;

  Height := 800;
  Width := 1270;

  Caption := 'Inserimento Riunione';
  ReportGroup := 'Wizard Inserimento Riunione';

  // setPageIndex([pageWelcome, pageAltriDati, pageProgettiDoti, pageGenitori, pageBisogniEducativiSpeciali, pageLingue, pageEsperienze, pageDispOrari, pageContiCorrenti,
  // pageAllegatiStudente, pageFinish]);

  // SetCard(WizInserimentoStudente.Studenti, cardStudente);
  // viewProgetti.zDataSet := WizInserimentoStudente.Progetti;
end;

function TWizRiunioniForm.ConfermaAnnulla: Boolean;
begin
  result := False;
  if CloseQuery then
    result := WizRiunioni.ConfermaAnnulla;
end;

function TWizRiunioniForm.ConfermaChiusura: Boolean;
begin
  result := WizRiunioni.ConfermaChiusura;
end;

function TWizRiunioniForm.NuovaRiunione: integer;
begin
  result := -1;

  if ShowModal = mrOk then
    result := -1;
end;

end.
