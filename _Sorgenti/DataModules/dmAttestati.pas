unit dmAttestati;

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
  TAttestati= class(TBaseDataModule)
  end;

var
  Attestati: TAttestati;

implementation

{$R *.dfm}

end.
