unit dmCOGE_Registrazioni;

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
  TCOGE_Registrazioni = class(TBaseDataModule)
  end;

var
  COGE_Registrazioni: TCOGE_Registrazioni;

implementation

{$R *.dfm}

end.
