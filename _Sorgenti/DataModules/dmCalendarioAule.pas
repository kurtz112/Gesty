unit dmCalendarioAule;

interface

uses
  System.SysUtils,
  System.Classes,
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
  cxClasses,
  cxSchedulerStorage,
  dbMaster,
  Base_DataModule,
  zDbCardDlg,
  zFbDataSet,
  CalendarioAule.Classes;

type
  TCalendarioAule = class(TBaseDataModule)
    CalendarioAule: TzFbDataSet;
    Orario: TzFbDataSet;
    cardOrario: TzDbCardDlg;
    cxSchedulerStorage: TcxSchedulerStorage;
  private
  public
    procedure LoadCalendarioAule(DalGiorno, AlGiorno: TDate; Aula: string; IdSede:integer; CalendarioLezioniAule: TCalendarioLezioniAule);

    function ApriOrario(const idOrario: integer): boolean;
  end;

var
  CalendarioAule: TCalendarioAule;

implementation

uses
  zBaseLib;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TData }

procedure TCalendarioAule.LoadCalendarioAule(DalGiorno, AlGiorno: TDate; Aula:
    string; IdSede:integer; CalendarioLezioniAule: TCalendarioLezioniAule);
begin
  StartWait('Attendere...', True);
  try
    CalendarioAule.Active := False;
    CalendarioAule.ParamByName('DAL_GIORNO').AsDate := DalGiorno;
    CalendarioAule.ParamByName('AL_GIORNO').AsDate := AlGiorno;
    CalendarioAule.ParamByName('AULA_SELEZIONATA').AsString := Aula;
    CalendarioAule.ParamByName('ID_SEDE').AsInteger:= idSede;

    CalendarioAule.Active := True;
    try
      CalendarioLezioniAule.Load(CalendarioAule);
    finally
      CalendarioAule.Active := False;
    end;

    CalendarioLezioniAule.LoadScheduler(cxSchedulerStorage);
  finally
    StopWait;
  end;
end;

function TCalendarioAule.ApriOrario(const idOrario: integer): boolean;
begin
  // params.id := -1;
  // params.Data := DateOf(FrameScheduler.Scheduler.CurrentView.HitTest.Time);
  // params.OraInizio := TimeOf(FrameScheduler.Scheduler.CurrentView.HitTest.Time);
  // params.Durata := 60;
  //
  // params.FieldName3 := FieldName3;
  // params.value3 := value3;
  // params.FieldName4 := FieldName4;
  // params.value4 := value4;
  //
  // if SchedulerTools.ApriEvento(params) then
  // AggiornaCalendario;

  result := False;

  Orario.RevertSql(False);
  Orario.ParamByName('ID_ORARIO').AsInteger := idOrario;
  Orario.Active := True;
  try
    result := cardOrario.Execute;
  finally
    Orario.Active := False;
  end;
end;

end.

  frame_CalendarioDocenti
