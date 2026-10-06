unit dmCOGE_FattureElettroniche;

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
  Base_DataModule,
  dbMaster;

type
  TCOGE_FattureElettroniche = class(TBaseDataModule)
  end;

var
  COGE_FattureElettroniche: TCOGE_FattureElettroniche;

implementation

{$R *.dfm}

end.
