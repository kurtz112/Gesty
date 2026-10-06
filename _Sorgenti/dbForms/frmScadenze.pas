unit frmScadenze;

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
  dxBar,
  System.Actions,
  Vcl.ActnList,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  zDbView;

type
  TFormScadenze = class(TBaseForm)
    procedure FormCreate(Sender: TObject);
  private

  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public

  end;

var
  FormScadenze: TFormScadenze;

implementation

uses
  dmScadenze;

{$R *.dfm}

procedure TFormScadenze.CreateDataModule;
begin
  inherited;
  CreateDM(TScadenze, Scadenze);
end;

procedure TFormScadenze.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Scadenze);
end;

procedure TFormScadenze.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Scadenze';
  ReportGroup := 'Scadenze';
end;

end.
