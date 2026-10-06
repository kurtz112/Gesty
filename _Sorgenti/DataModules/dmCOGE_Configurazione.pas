unit dmCOGE_Configurazione;

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
  TCOGE_Configurazione = class(TBaseDataModule)
  end;

var
  COGE_Configurazione: TCOGE_Configurazione;

implementation

{$R *.dfm}

end.
