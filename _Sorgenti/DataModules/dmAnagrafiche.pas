unit dmAnagrafiche;

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
  TAnagrafiche = class(TBaseDataModule)
  end;

var
  Anagrafiche: TAnagrafiche;

implementation

{$R *.dfm}

end.
