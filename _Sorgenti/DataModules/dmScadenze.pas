unit dmScadenze;

interface

uses
  System.SysUtils, System.Classes, Base_DataModule, dbMaster;

type
  TScadenze = class(TBaseDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Scadenze: TScadenze;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
