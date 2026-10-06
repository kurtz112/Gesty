unit dmAbitare_Sostegno_Scheda;

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
  zFbDataSet,
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
  zDbCardDlg;

type
  TAbitareSostegnoScheda = class(TBaseDataModule)
    cardInquilino: TzDbCardDlg;
    cardProprietario: TzDbCardDlg;
  private
    FIdRichiestaSostegno: integer;
    procedure RichiestaBeforeOpen(DataSet: TDataSet);
    procedure RichiestaAfterPost(DataSet: TDataSet);
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    constructor Create(aOwner: TComponent); override;
  public
    procedure CreaRichiesta;

    procedure MostraSchedaInquilino;
    procedure MostraSchedaProprietario;

    property IdRichiestaSostegno: integer read FIdRichiestaSostegno write FIdRichiestaSostegno;
  end;

var
  AbitareSostegnoScheda: TAbitareSostegnoScheda;

implementation

{$R *.dfm}
{ TAbitareSostegnoScheda }

constructor TAbitareSostegnoScheda.Create(aOwner: TComponent);
begin
  inherited;
  FIdRichiestaSostegno := -1;
end;

procedure TAbitareSostegnoScheda.AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'Richiesta') then
  begin
    DataSet.BeforeOpen := RichiestaBeforeOpen;
    DataSet.AfterPost := RichiestaAfterPost;
  end;
end;

procedure TAbitareSostegnoScheda.RichiestaBeforeOpen(DataSet: TDataSet);
var
  Richiesta: TzFbDataSet;
begin
  Richiesta := GetDataSet('Richiesta');
  Richiesta.ParamByName('ID_RICHIESTA_SOSTEGNO').AsInteger := IdRichiestaSostegno;
end;

procedure TAbitareSostegnoScheda.RichiestaAfterPost(DataSet: TDataSet);
begin
  IdRichiestaSostegno := DataSet.FieldByName('ID_RICHIESTA_SOSTEGNO').AsInteger;
end;

procedure TAbitareSostegnoScheda.CreaRichiesta;
var
  Richiesta: TzFbDataSet;
begin
  FIdRichiestaSostegno := -1;
  OpenDataSets;

  // La scheda viene aperta per una richiesta nuova: il dataset si apre su
  // ID_RICHIESTA_SOSTEGNO = -1 e non restituisce righe, quindi va messo in
  // inserimento qui. Senza, la scheda si presenta vuota e tocca all'operatore
  // premere il pulsante di inserimento della barra.
  // La guardia sullo stato evita il secondo record se la scheda ci arriva
  // gia' in inserimento.
  Richiesta := GetDataSet('Richiesta');

  if Richiesta.State = dsBrowse then
    Richiesta.Append;
end;

procedure TAbitareSostegnoScheda.MostraSchedaInquilino;
begin
  cardInquilino.DataSet := GetDataSet('Richiesta');
  cardInquilino.Execute;
end;

procedure TAbitareSostegnoScheda.MostraSchedaProprietario;
begin
  cardProprietario.DataSet := GetDataSet('Richiesta');
  cardProprietario.Execute;
end;

end.
