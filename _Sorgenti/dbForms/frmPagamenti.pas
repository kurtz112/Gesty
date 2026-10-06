unit frmPagamenti;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  BaseFrm,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  dxBarExtItems,
  cxClasses,
  ActnList,
  cxLabel,
  System.Actions,
  zFormController,
  zFileViewer,
  Base_DataModule;

type
  TFormPagamenti = class(TBaseForm)
    procedure FormCreate(Sender: TObject);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
  end;

var
  FormPagamenti: TFormPagamenti;

implementation

uses
  dmPagamenti,
  Files.Lib;
{$R *.dfm}

procedure TFormPagamenti.CreateDataModule;
begin
  inherited;
  CreateDM(TPagamenti, Pagamenti);
end;

procedure TFormPagamenti.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Pagamenti);
end;

procedure TFormPagamenti.FormCreate(Sender: TObject);
begin
  inherited;
  ReportGroup := 'Pagamenti';
  Caption := 'Pagamenti';
end;

end.
