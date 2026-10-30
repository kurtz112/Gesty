unit frmCOGE_Soggetti;

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
  TFormCOGE_Soggetti = class(TBaseForm)
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormCOGE_Soggetti: TFormCOGE_Soggetti;

implementation

uses
  dmCOGE_Soggetti;

{$R *.dfm}

procedure TFormCOGE_Soggetti.CreateDataModule;
begin
  inherited;
  CreateDM(TCOGE_Soggetti, COGE_Soggetti);
end;

procedure TFormCOGE_Soggetti.DestroyDataModule;
begin
  inherited;
  FreeAndNil(COGE_Soggetti);
end;

constructor TFormCOGE_Soggetti.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'COGE_Soggetti';
  Caption := 'COGE_Soggetti';
end;

end.
