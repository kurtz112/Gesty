unit dmPagamenti;

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
  dbMaster,
  Base_DataModule,
  zFbDataSet,
  zBaseLib;

type
  TPagamenti = class(TBaseDataModule)
  private
  public
  end;

var
  Pagamenti: TPagamenti;

implementation

{$R *.dfm}

end.
