unit dmCOGE_Soggetti;

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
  TCOGE_Soggetti = class(TBaseDataModule)
  end;

var
  COGE_Soggetti: TCOGE_Soggetti;

implementation

{$R *.dfm}

end.
