unit dmAttivitaFuoriSede;

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
  dbMaster,
  zFbDataSet;

type
  TAttivitaFuoriSede = class(TBaseDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    FDataAttivita: TDateTime;
    procedure SetDataAttivita(const Value: TDateTime);
    procedure Risorse_Attivita_Fuori_SedeBeforeOpen(DataSet: TDataSet);
  protected
    procedure AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    procedure Precedente;
    procedure Successivo;

    property DataAttivita: TDateTime read FDataAttivita write SetDataAttivita;
  end;

var
  AttivitaFuoriSede: TAttivitaFuoriSede;

implementation

uses
  System.DateUtils;

{$R *.dfm}
{ TAttivitaFuoriSede }

procedure TAttivitaFuoriSede.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FDataAttivita := Date;
end;

procedure TAttivitaFuoriSede.AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'Risorse_Attivita_Fuori_Sede') then
  begin
    DataSet.BeforeOpen := Risorse_Attivita_Fuori_SedeBeforeOpen;
  end;
end;

procedure TAttivitaFuoriSede.Risorse_Attivita_Fuori_SedeBeforeOpen(DataSet: TDataSet);
var
  attivita: TzFbDataSet;
begin
  attivita := getDataSet('Risorse_Attivita_Fuori_Sede');
  attivita.ParamByName('DATA_ATTIVITA').Value := DataAttivita;
end;

procedure TAttivitaFuoriSede.SetDataAttivita(const Value: TDateTime);
begin
  FDataAttivita := Value;
  ReopenDataSet('Risorse_Attivita_Fuori_Sede');
end;

procedure TAttivitaFuoriSede.Precedente;
begin
  DataAttivita := IncDay(DataAttivita, -1);
end;

procedure TAttivitaFuoriSede.Successivo;
begin
  DataAttivita := IncDay(DataAttivita, +1);
end;

end.
