unit dmRicercaProfili;

interface

uses
  System.SysUtils,
  System.Classes,
  Base_DataModule,
  dbMaster,
  zFbDataSet;

type
  TRicercaProfili = class(TBaseDataModule)
  private
    Fcallback: TProc<integer>;
    FidRichiestaPersonale: integer;
    { Private declarations }
  public
    property idRichiestaPersonale: integer read FidRichiestaPersonale write FidRichiestaPersonale;
    property callback: TProc<integer> read Fcallback write Fcallback;
  end;

var
  RicercaProfili: TRicercaProfili;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

end.
