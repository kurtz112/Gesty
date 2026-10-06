unit dmCartellaProgetto;

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
  Base_DataModule,
  zFbDataSet,
  dbMaster;

type
  TCartellaProgetto = class(TBaseDataModule)
  public
  end;

var
  CartellaProgetto: TCartellaProgetto;

implementation

{$R *.dfm}

end.
