unit dmAule;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.UITypes,
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
  zFbDataSet,
  dbMaster,
  Base_DataModule,
  RiepilogoGiornalieroAule.Classes,
  CalendarioDocenti.Classes,
  Vcl.Dialogs,
   zProgressBox;

type
  TAule = class(TBaseDataModule)
    RiepGiornalieroAule: TzFbDataSet;
    ProgressBox: TProgressBox;
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
    procedure AuleNewRecord(DataSet: TDataSet);
  public
    function ApriOrario(const idOrario: integer): boolean;
    function ApriPrenotazione(const idPrenotazione: integer): boolean;
    function ApriInagibilita(const IdInagibilita: integer): boolean;
    procedure LoadRiepilogoGiornalieroAule(Giorno: TDate; RiepilogoGiornalieroAule: TRiepilogoGiornalieroAule);

    procedure Autorizza(Prenotazioni: TList<integer>);
  end;

var
  Aule: TAule;

implementation

uses
  zBaseLib, Gesty_StoredProcs,   dmCommon, zMsg;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TAule.LoadRiepilogoGiornalieroAule(Giorno: TDate; RiepilogoGiornalieroAule: TRiepilogoGiornalieroAule);
begin
  StartWait('Attendere...', True);
  try
    RiepGiornalieroAule.Active := False;
    RiepGiornalieroAule.ParamByName('GIORNO').AsDate := Giorno;
    RiepGiornalieroAule.Active := True;
    try
      RiepilogoGiornalieroAule.Load(RiepGiornalieroAule);
    finally
      RiepGiornalieroAule.Active := False;
    end;
  finally
    StopWait;
  end;
end;

function TAule.ApriInagibilita(const IdInagibilita: integer): boolean;
begin
  result := False;
end;

function TAule.ApriOrario(const idOrario: integer): boolean;
begin
  result := False;
end;

function TAule.ApriPrenotazione(const idPrenotazione: integer): boolean;
begin
  result := False;
end;

procedure TAule.Autorizza(Prenotazioni: TList<integer>);
var
  id: integer;
  sp: TSP_AULE_PRENOTAZIONI_AUTORIZZA;
begin
  Assert(Assigned(Prenotazioni));
  if Prenotazioni.Count = 0 then
    exit;

  if not ConfirmYesNo('Autorizzare le prenotazioni selezionate?') then
    exit;

  ProgressBox.Show(Prenotazioni.Count, 'Prenotazioni', 'Prenotazioni', 'Attendere...');
  try
    sp := TSP_AULE_PRENOTAZIONI_AUTORIZZA.Create(WriteTrans);
    try
      for id in Prenotazioni do
      begin
        sp.ID_PRENOTAZIONE_AULA := id;
        sp.ExecuteAndCommit;
      end;
    finally
      FreeAndNil(sp);
    end;

    RefreshDataSets;
  finally
    ProgressBox.Close;
  end;
end;

procedure TAule.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
var
  Field: TField;
begin
  inherited;
  if SameText(DataSetName, 'Aule') then
    DataSet.OnNewRecord := AuleNewRecord;
end;

procedure TAule.AuleNewRecord(DataSet: TDataSet);
var
  Ente, Sede: integer;
  Raggruppamento: string;
begin
  inherited;
  Common.GetEnteAndSedeDefault(Ente, Sede, Raggruppamento);
  DataSet.FieldByName('ID_ENTE').Value := Ente;
  DataSet.FieldByName('ID_SEDE').Value := Sede;
end;

end.
