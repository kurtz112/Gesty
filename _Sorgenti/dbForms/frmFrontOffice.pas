unit frmFrontOffice;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  zDbView,
  BaseFrm,
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
  cxLabel;

type
  TFormFrontOffice = class(TBaseForm)
    ActionList: TActionList;
    InoltraComunicazione: TAction;
    AssegnaTicket: TAction;
    ModificaTicket: TAction;
    RichiedeRisposta: TAction;
    SbloccaDatiAnagrafe: TAction;
    procedure InoltraComunicazioneExecute(Sender: TObject);
    procedure AssegnaTicketExecute(Sender: TObject);
    procedure ModificaTicketExecute(Sender: TObject);
    procedure RichiedeRispostaExecute(Sender: TObject);
    procedure RichiedeRispostaUpdate(Sender: TObject);
    procedure SbloccaDatiAnagrafeExecute(Sender: TObject);
    procedure SbloccaDatiAnagrafeUpdate(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormFrontOffice: TFormFrontOffice;

implementation

uses
  zDm_Images,
  dmFrontOffice,
  zFbDataSet;

{$R *.dfm}

procedure TFormFrontOffice.CreateDataModule;
begin
  inherited;
  CreateDM(TFrontOffice, FrontOffice);
end;

procedure TFormFrontOffice.DestroyDataModule;
begin
  inherited;
  FreeAndNil(FrontOffice);
end;

constructor TFormFrontOffice.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'FrontOffice';
  Caption := 'FrontOffice';
end;

procedure TFormFrontOffice.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
// view: TzDbView;
// begin
// inherited;
//
// if Component is TzDbView then
// begin
// view := TzDbView(Component);
//
// if SameText(DataSetName, 'Front_Office_Contatti') then
// begin
// view.AddAction(AssegnaTicket, zDmImages.ImageList16);
// view.AddAction(InoltraComunicazione, zDmImages.ImageList16);
// view.InitToolActions;
// Tools.AddFiltroPickList('FRONT_OFFICE_STATO_RISPOSTA', view, FrontOffice.GetDataSet(DataSetName), 'STATO_RISPOSTA', 'Stato Risposta', 'stato risposta', null, True, 'Tutti', 150);
// end
// else
// if SameText(DataSetName, 'Front_Office_Contatti_Ticket') then
// begin
// view.AddAction(AssegnaTicket, zDmImages.ImageList16);
// view.InitToolActions;
// end;
// end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent }
end;

procedure TFormFrontOffice.InoltraComunicazioneExecute(Sender: TObject);
begin
  inherited;
  FrontOffice.InoltraComunicazione;
end;

procedure TFormFrontOffice.AssegnaTicketExecute(Sender: TObject);
begin
  inherited;
  FrontOffice.AssegnaTicket;
end;

procedure TFormFrontOffice.ModificaTicketExecute(Sender: TObject);
begin
  inherited;
  FrontOffice.ModificaTicket;
end;

procedure TFormFrontOffice.RichiedeRispostaExecute(Sender: TObject);
begin
  inherited;
  FrontOffice.SetRichiedeRisposta(TAction(Sender).Checked);
end;

procedure TFormFrontOffice.RichiedeRispostaUpdate(Sender: TObject);
var
  Checked, Visible: boolean;
begin
  inherited;

  FrontOffice.UpdateRichiedeRisposta(Checked, Visible);

  RichiedeRisposta.Checked := Checked;
  RichiedeRisposta.Visible := Visible;
end;

// Mantis #252 - 2026-10-16: sblocco dei dati copiati dall'anagrafe
procedure TFormFrontOffice.SbloccaDatiAnagrafeExecute(Sender: TObject);
begin
  inherited;
  FrontOffice.SbloccaDatiAnagrafe;
end;

procedure TFormFrontOffice.SbloccaDatiAnagrafeUpdate(Sender: TObject);
var
  Visible: boolean;
begin
  inherited;

  FrontOffice.UpdateSbloccaDatiAnagrafe(Visible);

  SbloccaDatiAnagrafe.Visible := Visible;
end;

end.
