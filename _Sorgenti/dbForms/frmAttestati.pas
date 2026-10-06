unit frmAttestati;

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
  TFormAttestati= class(TBaseForm)
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormAttestati: TFormAttestati;

implementation

uses
  zDm_Images,
  dmAttestati;

{$R *.dfm}

procedure TFormAttestati.CreateDataModule;
begin
  inherited;
  CreateDM(TAttestati, Attestati);
end;

procedure TFormAttestati.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Attestati);
end;

constructor TFormAttestati.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'Attestati';
  Caption :=  'Attestati';
end;

end.
