unit dmCOGE_Documenti;

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
  TCOGE_Documenti = class(TBaseDataModule)
  end;

var
  COGE_Documenti: TCOGE_Documenti;

implementation

{$R *.dfm}

end.
