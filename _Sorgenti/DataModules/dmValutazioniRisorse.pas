unit dmValutazioniRisorse;

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
  dbMaster,
  zFbDataSet,
  zBaseLib,
  ValutazioniPrestazioni.classi,
  ValutazioniPrestazioni.types;

type
  TValutazioniRisorse = class(TBaseDataModule)
    Valutazioni: TzFbDataSet;
  private
    FElencoValutazioni: TElencoValutazioni;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadValutazioni;
  public
    property ElencoValutazioni: TElencoValutazioni read FElencoValutazioni;
  end;

var
  ValutazioniRisorse: TValutazioniRisorse;

implementation

{$R *.dfm}
{ TValutazioniRisorse }

constructor TValutazioniRisorse.Create(aOwner: TComponent);
begin
  inherited;
  FElencoValutazioni := TElencoValutazioni.Create;
end;

destructor TValutazioniRisorse.Destroy;
begin
  FreeAndNil(FElencoValutazioni);
  inherited;
end;

procedure TValutazioniRisorse.LoadValutazioni;
begin
  Valutazioni.Active := True;
  try
    ElencoValutazioni.LoadFromDataSet(Valutazioni);
  finally
    Valutazioni.Active := False;
  end;
end;

end.
