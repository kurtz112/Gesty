unit dmAziendaScheda;

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
  TAziendaScheda = class(TBaseDataModule)
  private
    FIdAzienda: integer;
    procedure AziendaAfterPost(DataSet: TDataSet);
    procedure AziendaBeforeOpen(DataSet: TDataSet);
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure CreaAzienda;

    property IdAzienda: integer read FIdAzienda write FIdAzienda;
  end;

var
  AziendaScheda: TAziendaScheda;

implementation

{$R *.dfm}
{ TAziendaScheda }

constructor TAziendaScheda.Create(aOwner: TComponent);
begin
  inherited;
  FIdAzienda := -1;
end;

procedure TAziendaScheda.AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'Azienda') then
  begin
    DataSet.BeforeOpen := AziendaBeforeOpen;
    DataSet.AfterPost := AziendaAfterPost;
  end;
end;

procedure TAziendaScheda.AziendaBeforeOpen(DataSet: TDataSet);
var
  Azienda: TzFbDataSet;
begin
  Azienda := GetDataSet('Azienda');
  Azienda.ParamByName('ID_AZIENDA').AsInteger := IdAzienda;
end;

procedure TAziendaScheda.AziendaAfterPost(DataSet: TDataSet);
begin
  IdAzienda := DataSet.FieldByName('ID_AZIENDA').AsInteger;
end;

procedure TAziendaScheda.CreaAzienda;
var
  Azienda: TzFbDataSet;
begin
  FIdAzienda := -1;
  OpenDataSets;
end;

end.
