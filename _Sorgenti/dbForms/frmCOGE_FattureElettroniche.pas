unit frmCOGE_FattureElettroniche;

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
  TFormCOGE_FattureElettroniche = class(TBaseForm)
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormCOGE_FattureElettroniche: TFormCOGE_FattureElettroniche;

implementation

uses
  zDm_Images,
  dmCOGE_FattureElettroniche;

{$R *.dfm}

procedure TFormCOGE_FattureElettroniche.CreateDataModule;
begin
  inherited;
  CreateDM(TCOGE_FattureElettroniche, COGE_FattureElettroniche);
end;

procedure TFormCOGE_FattureElettroniche.DestroyDataModule;
begin
  inherited;
  FreeAndNil(COGE_FattureElettroniche);
end;

constructor TFormCOGE_FattureElettroniche.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'COGE_FattureElettroniche';
  Caption := 'COGE_FattureElettroniche';
end;

end.
