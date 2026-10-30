unit frmTimesheet;

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
  BaseFrm, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxBar, System.Actions, Vcl.ActnList, dxBarExtItems,
  cxClasses, cxLabel;

type
  TFormTimesheet= class(TBaseForm)
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormTimesheet: TFormTimesheet;

implementation

uses
  dmTimesheet;

{$R *.dfm}

procedure TFormTimesheet.CreateDataModule;
begin
  inherited;
  CreateDM(TTimesheet, Timesheet);
end;

procedure TFormTimesheet.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Timesheet);
end;

constructor TFormTimesheet.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'Timesheet';
  Caption :=  'Timesheet';
end;

end.
