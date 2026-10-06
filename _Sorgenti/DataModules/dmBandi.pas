unit dmBandi;

interface

uses
  System.SysUtils, System.Classes, Base_DataModule, dbMaster;

type
  TBandi = class(TBaseDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Bandi: TBandi;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
