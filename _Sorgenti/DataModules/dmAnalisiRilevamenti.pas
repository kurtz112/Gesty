unit dmAnalisiRilevamenti;

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
  TAnalisiRilevamenti= class(TBaseDataModule)
  end;

var
  AnalisiRilevamenti: TAnalisiRilevamenti;

implementation

{$R *.dfm}

end.
