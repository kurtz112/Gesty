unit frmDiarioSociale;

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
  BaseFrm, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxBar, System.Actions, Vcl.ActnList, dxBarExtItems,
  cxClasses, cxLabel;

type
  TFormDiarioSociale= class(TBaseForm)
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormDiarioSociale: TFormDiarioSociale;

implementation

uses
  zDm_Images,
  dmDiarioSociale;

{$R *.dfm}

procedure TFormDiarioSociale.CreateDataModule;
begin
  inherited;
  CreateDM(TDiarioSociale, DiarioSociale);
end;

procedure TFormDiarioSociale.DestroyDataModule;
begin
  inherited;
  FreeAndNil(DiarioSociale);
end;

constructor TFormDiarioSociale.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'DiarioSociale';
  Caption :=  'DiarioSociale';
end;

end.
