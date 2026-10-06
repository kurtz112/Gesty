unit dmCalendarioDocenti;

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
  CalendarioDocenti.Classes;

type
  TCalendarioDocenti = class(TBaseDataModule)
    CalendarioDocenti: TzFbDataSet;
    Orario: TzFbDataSet;
    cardOrario: TzDbCardDlg;
    cxSchedulerStorage: TcxSchedulerStorage;
  private
    procedure LoadScheduler(CalendarioLezioniDocenti: TCalendarioLezioniDocenti);
  public
    procedure LoadCalendarioDocenti(DalGiorno, AlGiorno: TDate; idRisorsa: integer; CalendarioLezioniDocenti: TCalendarioLezioniDocenti);
    function ApriOrario(const idOrario: integer): boolean;
  end;

var
  CalendarioDocenti: TCalendarioDocenti;

implementation

uses
  zBaseLib;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TData }

procedure TCalendarioDocenti.LoadCalendarioDocenti(DalGiorno, AlGiorno: TDate; idRisorsa: integer; CalendarioLezioniDocenti: TCalendarioLezioniDocenti);
begin
  StartWait('Attendere...', True);
  try
    CalendarioDocenti.Active := False;
    CalendarioDocenti.ParamByName('DAL_GIORNO').AsDate := DalGiorno;
    CalendarioDocenti.ParamByName('AL_GIORNO').AsDate := AlGiorno;
    CalendarioDocenti.ParamByName('ID_DOCENTE_SELEZIONATO').AsInteger := idRisorsa;

    CalendarioDocenti.Active := True;
    try
      CalendarioLezioniDocenti.Load(CalendarioDocenti);
    finally
      CalendarioDocenti.Active := False;
    end;

    LoadScheduler(CalendarioLezioniDocenti);
  finally
    StopWait;
  end;
end;

function TCalendarioDocenti.ApriOrario(const idOrario: integer): boolean;
begin
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

procedure TCalendarioDocenti.LoadScheduler(CalendarioLezioniDocenti: TCalendarioLezioniDocenti);
var
  Docente: TDocente;
  event: TcxSchedulerEvent;
  Lezione: TLezione;
begin
  cxSchedulerStorage.BeginUpdate;
  try
    cxSchedulerStorage.Clear;

    for Docente in CalendarioLezioniDocenti.ElencoDocenti do
      for Lezione in Docente.Lezioni do
      begin
        event := cxSchedulerStorage.createEvent;
        event.Start := Lezione.DataLezione + Lezione.OraInizio;
        event.Finish := Lezione.DataLezione + Lezione.OraFine;

        event.Caption := Lezione.SiglaProgetto;

        if not Lezione.Aula.IsEmpty then
          event.Location := 'Aula: ' + Lezione.Aula;

        if Lezione.Materia.IsEmpty then
          event.Message := Lezione.DenominazioneProgetto
        else
          event.Message := Lezione.Materia + ' - ' + Lezione.DenominazioneProgetto;

        event.SetCustomFieldValueByName('ID_DOCENTE', Docente.IdDocente);
        event.SetCustomFieldValueByName('NOMINATIVO', Docente.Nominativo);
        event.SetCustomFieldValueByName('ID_ORARIO', Lezione.idOrario);
        event.Post;
      end;
  finally
    cxSchedulerStorage.EndUpdate;
  end;
end;

end.
