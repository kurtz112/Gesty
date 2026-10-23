unit dmEnti;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Base_DataModule, dbMaster, zFbDataSet;

type
  TEnti = class(TBaseDataModule)
  private
    procedure Enti_Carta_Intestata_FormatNewRecord(DataSet: TDataSet);
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    { Public declarations }
  end;

var
  Enti: TEnti;

implementation

uses
  Gesty_StoredProcs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TEnti.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'Enti_Carta_Intestata_Format') then
    DataSet.OnNewRecord := Enti_Carta_Intestata_FormatNewRecord;
end;

procedure TEnti.Enti_Carta_Intestata_FormatNewRecord(DataSet: TDataSet);
var
  CartaIntestata: TzFbDataSet;
  PeriodoProposto: TSP_enti_Carta_Intestata_Format_Periodo_Proposto;
begin
  // Periodo del format nuovo proposto dal database: inizio dopo l'ultimo format
  // dell'ente e tipo di carta, fine sempre DATA_9999. Se c'e' un format in
  // vigore, il trigger lo chiude al giorno prima dell'inizio del nuovo.
  CartaIntestata := GetDataSet('Enti_Carta_Intestata');

  PeriodoProposto := GetSP<TSP_enti_Carta_Intestata_Format_Periodo_Proposto>();
  try
    PeriodoProposto.Id_Ente := CartaIntestata.FieldByName('ID_ENTE').AsLargeInt;
    PeriodoProposto.Tipo_Carta_Intestata := CartaIntestata.FieldByName('TIPO_CARTA_INTESTATA').AsString;
    PeriodoProposto.ExecuteWithoutCommit;

    DataSet.FieldByName('DATA_INIZIO_VALIDITA').AsDateTime := PeriodoProposto.Data_Inizio_Validita.Value;
    DataSet.FieldByName('DATA_FINE_VALIDITA').AsDateTime := PeriodoProposto.Data_Fine_Validita.Value;
  finally
    FreeAndNil(PeriodoProposto);
  end;
end;

end.
