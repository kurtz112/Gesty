unit dmTimesheet;

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
  Base_DataModule, dbMaster;

type
  TTimesheet = class(TBaseDataModule)
  end;

var
  Timesheet: TTimesheet;

implementation

{$R *.dfm}

end.
