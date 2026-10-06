unit WizTirociniFrm;

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
  cxLabel,
  cxFilter,
  zFormController,
  zDbView;

type
  TWizTirociniForm = class(TBaseWizard)
    procedure AggiungiStudentiStageExecute(Sender: TObject);
    procedure NuovaAziendaOspitanteExecute(Sender: TObject);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
  end;

var
  WizTirociniForm: TWizTirociniForm;

implementation

{$R *.dfm}

uses
  zDm_Images,
  WizTirociniDM;

procedure TWizTirociniForm.CreateDataModule;
begin
  inherited;
  CreateDM(TWizTirocini, WizTirocini);
end;

procedure TWizTirociniForm.DestroyDataModule;
begin
  inherited;
  FreeAndNil(WizTirocini);
end;

procedure TWizTirociniForm.AggiungiStudentiStageExecute(Sender: TObject);
begin
  WizTirocini.AggiungiStudentiStage;
end;

procedure TWizTirociniForm.NuovaAziendaOspitanteExecute(Sender: TObject);
begin
  inherited;
  WizTirocini.NuovaAziendaOspitante;
end;

end.
