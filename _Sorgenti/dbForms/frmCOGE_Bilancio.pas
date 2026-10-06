unit frmCOGE_Bilancio;

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
  TFormCOGE_Bilancio = class(TBaseForm)
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormCOGE_Bilancio: TFormCOGE_Bilancio;

implementation

uses
  zDm_Images,
  dmCOGE_Bilancio;

{$R *.dfm}

procedure TFormCOGE_Bilancio.CreateDataModule;
begin
  inherited;
  CreateDM(TCOGE_Bilancio, COGE_Bilancio);
end;

procedure TFormCOGE_Bilancio.DestroyDataModule;
begin
  inherited;
  FreeAndNil(COGE_Bilancio);
end;

constructor TFormCOGE_Bilancio.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'COGE_Bilancio';
  Caption := 'COGE_Bilancio';
end;

end.
