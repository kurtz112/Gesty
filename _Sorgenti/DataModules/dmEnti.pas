unit dmEnti;

interface

uses
  System.SysUtils, System.Classes, Base_DataModule, dbMaster;

type
  TEnti = class(TBaseDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Enti: TEnti;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
