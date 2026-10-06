unit frmAziendaScheda;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnList,
  Data.DB,
  dxBar,
  dxBarExtItems,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxClasses,
  cxLabel,
  zDbView,
  BaseFrm,
  OkCancel,
  zFileViewer;

type
  TFormAziendaScheda = class(TBaseForm)
    OkCancel: TOkCancel;
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure BeforeShow; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormAziendaScheda: TFormAziendaScheda;

implementation

uses
  cxFilter,
  zDm_Images,
  dmAziendaScheda,
  zz.files,
  Files.Lib;

{$R *.dfm}

procedure TFormAziendaScheda.CreateDataModule;
begin
  inherited;
  CreateDM(TAziendaScheda, AziendaScheda);
end;

procedure TFormAziendaScheda.DestroyDataModule;
begin
  inherited;
  FreeAndNil(AziendaScheda);
end;

constructor TFormAziendaScheda.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'AziendaScheda';
  Caption := 'Scheda Azienda';

  Position := PoMainFormCenter;

  actEsci.Visible := false;

  Height := 820;
  Width := 980;

  OkCancel.Top := ClientHeight - 1;
end;

procedure TFormAziendaScheda.BeforeShow;
begin
  inherited;
  LoadFromIni;
end;

initialization

// HyperLinks.RegisterHandler('ID_AZIENDA', TFormRisorse);
// HyperLinks.RegisterHandler('ID_AZIENDA_OSPITANTE', TFormRisorse);

end.
