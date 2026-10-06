unit frmBandi;

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
  cxLabel;

type
  TFormBandi = class(TBaseForm)
    procedure FormCreate(Sender: TObject);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
  end;

var
  FormBandi: TFormBandi;

implementation

uses
  dmBandi,
  zDbView;

{$R *.dfm}

procedure TFormBandi.CreateDataModule;
begin
  inherited;
  CreateDM(TBandi, Bandi);
end;

procedure TFormBandi.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Bandi);
end;

procedure TFormBandi.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Bandi';
  ReportGroup := 'Bandi';
end;

end.
