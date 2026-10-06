unit dmDiarioSociale;

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
  Base_DataModule;

type
  TDiarioSociale= class(TBaseDataModule)
  end;

var
  DiarioSociale: TDiarioSociale;

implementation

{$R *.dfm}

end.
