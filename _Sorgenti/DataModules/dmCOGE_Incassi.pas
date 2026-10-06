unit dmCOGE_Incassi;

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
  TCOGE_Incassi = class(TBaseDataModule)
  end;

var
  COGE_Incassi: TCOGE_Incassi;

implementation

{$R *.dfm}

end.
