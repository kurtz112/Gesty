unit dmDocentiRiepilogoOre;

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
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Base_DataModule,
  zFbDataSet,
  dbMaster,
  zBaseLib;

type
  TDocentiRiepilogoOre = class(TBaseDataModule)
    RiepilogoOre: TzFbDataSet;
    RiepilogoOreSrc: TDataSource;
  private
  public
  end;

var
  DocentiRiepilogoOre: TDocentiRiepilogoOre;

implementation

uses
  ConfigModule;

{$R *.dfm}

end.
