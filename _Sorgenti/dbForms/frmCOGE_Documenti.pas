unit frmCOGE_Documenti;

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
  TFormCOGE_Documenti = class(TBaseForm)
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormCOGE_Documenti: TFormCOGE_Documenti;

implementation

uses
  zDm_Images,
  dmCOGE_Documenti;

{$R *.dfm}

procedure TFormCOGE_Documenti.CreateDataModule;
begin
  inherited;
  CreateDM(TCOGE_Documenti, COGE_Documenti);
end;

procedure TFormCOGE_Documenti.DestroyDataModule;
begin
  inherited;
  FreeAndNil(COGE_Documenti);
end;

constructor TFormCOGE_Documenti.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'COGE_Documenti';
  Caption := 'COGE_Documenti';
end;

end.
