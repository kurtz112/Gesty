unit frmCOGE_Configurazione;

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
  TFormCOGE_Configurazione = class(TBaseForm)
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormCOGE_Configurazione: TFormCOGE_Configurazione;

implementation

uses
  dmCOGE_Configurazione;

{$R *.dfm}

procedure TFormCOGE_Configurazione.CreateDataModule;
begin
  inherited;
  CreateDM(TCOGE_Configurazione, COGE_Configurazione);
end;

procedure TFormCOGE_Configurazione.DestroyDataModule;
begin
  inherited;
  FreeAndNil(COGE_Configurazione);
end;

constructor TFormCOGE_Configurazione.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'COGE_Configurazione';
  Caption := 'COGE_Configurazione';
end;

end.
