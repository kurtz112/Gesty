unit frmCOGE_Incassi;

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
  TFormCOGE_Incassi = class(TBaseForm)
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormCOGE_Incassi: TFormCOGE_Incassi;

implementation

uses
  zDm_Images,
  dmCOGE_Incassi;

{$R *.dfm}

procedure TFormCOGE_Incassi.CreateDataModule;
begin
  inherited;
  CreateDM(TCOGE_Incassi, COGE_Incassi);
end;

procedure TFormCOGE_Incassi.DestroyDataModule;
begin
  inherited;
  FreeAndNil(COGE_Incassi);
end;

constructor TFormCOGE_Incassi.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'COGE_Incassi';
  Caption := 'COGE_Incassi';
end;

end.
