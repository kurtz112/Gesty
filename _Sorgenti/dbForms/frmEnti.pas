unit frmEnti;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  BaseFrm,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  System.Actions,
  Vcl.ActnList,
  dxBar,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  zDbView;

type
  TFormEnti = class(TBaseForm)
    procedure FormCreate(Sender: TObject);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  end;

var
  FormEnti: TFormEnti;

implementation

uses
  dmEnti;

{$R *.dfm}
{ TFormEnti }

procedure TFormEnti.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Enti';
  ReportGroup := 'Enti';
end;

procedure TFormEnti.CreateDataModule;
begin
  inherited;
  CreateDM(TEnti, Enti);
end;

procedure TFormEnti.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Enti);
end;

end.
