unit frmCOGE_Registrazioni;

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
  TFormCOGE_Registrazioni = class(TBaseForm)
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormCOGE_Registrazioni: TFormCOGE_Registrazioni;

implementation

uses
  dmCOGE_Registrazioni;

{$R *.dfm}

procedure TFormCOGE_Registrazioni.CreateDataModule;
begin
  inherited;
  CreateDM(TCOGE_Registrazioni, COGE_Registrazioni);
end;

procedure TFormCOGE_Registrazioni.DestroyDataModule;
begin
  inherited;
  FreeAndNil(COGE_Registrazioni);
end;

constructor TFormCOGE_Registrazioni.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'COGE_Registrazioni';
  Caption := 'COGE_Registrazioni';
end;

end.
