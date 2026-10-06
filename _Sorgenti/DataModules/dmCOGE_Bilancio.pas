unit dmCOGE_Bilancio;

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
  TCOGE_Bilancio = class(TBaseDataModule)
  end;

var
  COGE_Bilancio: TCOGE_Bilancio;

implementation

{$R *.dfm}

end.
