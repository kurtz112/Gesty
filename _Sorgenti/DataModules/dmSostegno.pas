unit dmSostegno;

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
  zDbViewDlg;

type
  TSostegno = class(TBaseDataModule)
    lkProgetti: TzFbDataSet;
    lkProgettiSrc: TDataSource;
    lkCorsi: TzFbDataSet;
    lkCorsiSrc: TDataSource;
    lkDocenti: TzFbDataSet;
    lkDocentiSrc: TDataSource;
    lkStudenti: TzFbDataSet;
    lkStudentiSrc: TDataSource;
    lkStudentiDlg: TzDbViewDlg;
    procedure DataModuleCreate(Sender: TObject);
    procedure lkCorsiBeforeOpen(DataSet: TDataSet);
  private
    FDataLezione: TDateTime;
    FIdCorso: integer;
    FIdDocente: integer;
    FIdProgetto: integer;
    procedure SetDataLezione(const Value: TDateTime);
    procedure SetIdCorso(const Value: integer);
    procedure SetIdDocente(const Value: integer);
    procedure SetIdProgetto(const Value: integer);
  private
    procedure OreSostegnoBeforeOpen(DataSet: TDataSet);
    procedure OreSostegnoNewRecord(DataSet: TDataSet);
    procedure OreSostegnoAfterCreateFields(DataSet: TDataSet);
    procedure OreSostegnoCalcolaOraFine(Sender: TField);
    procedure OreSostegnoFieldChanged(Sender: TField);
    procedure FiltriChanged;
  private
    procedure PresenzeUpdateMaster(DataSet: TDataSet);
  private
    function GetField(DataSet: TDataSet; FieldName: string; out Field: TField): boolean;
    function GetRilevamento(idDocente, IdProgetto, IdCorso: integer; DataLezione: TDateTime; OraInizio, OraFine: TTime; IdIncarico: integer): integer;
    function CercaIncarico(FieldProgetto, FieldCorso, FieldDocente, FieldDataLezione, FieldMateria: TField): integer;
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    property IdProgetto: integer read FIdProgetto write SetIdProgetto;
    property IdCorso: integer read FIdCorso write SetIdCorso;
    property idDocente: integer read FIdDocente write SetIdDocente;
    property DataLezione: TDateTime read FDataLezione write SetDataLezione;
  public
    procedure AggiungiStudenti;
    procedure GeneraIncarico;
    procedure GeneraRilevamento;
  end;

var
  Sostegno: TSostegno;

implementation

uses
  System.DateUtils,
  WizInserimentoIncaricoFrm,
  Gesty_StoredProcs,
  zBaseLib,
  ConfigModule,
  zMsg;

{$R *.dfm}

procedure TSostegno.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FIdProgetto := -1;
  FIdCorso := -1;
  FIdDocente := -1;
  FDataLezione := Date;
end;

procedure TSostegno.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'Ore_Sostegno') then
  begin
    DataSet.BeforeOpen := OreSostegnoBeforeOpen;
    DataSet.OnNewRecord := OreSostegnoNewRecord;
    DataSet.OnAfterCreateFields := OreSostegnoAfterCreateFields;
  end
  else
    if SameText(DataSetName, 'Studenti_Presenze_Sostegno') then
    begin
      DataSet.AfterPost := PresenzeUpdateMaster;
      DataSet.AfterDelete := PresenzeUpdateMaster;
    end;
end;

function TSostegno.GetField(DataSet: TDataSet; FieldName: string; out Field: TField): boolean;
begin
  result := False;

  Field := DataSet.FindField(FieldName);

  result := Assigned(Field);
end;

procedure TSostegno.OreSostegnoBeforeOpen(DataSet: TDataSet);
var
  OreSostegno: TzFbDataSet;

  procedure SetParam(Param: TFDParam; Value: integer);
  begin
    if Value = -1 then
      Param.Clear
    else
      Param.Value := Value;
  end;

begin
  OreSostegno := GetDataSet('Ore_Sostegno');
  OreSostegno.ParamByName('DATA_LEZIONE').Value := DataLezione;
  SetParam(OreSostegno.ParamByName('ID_PROGETTO'), IdProgetto);
  SetParam(OreSostegno.ParamByName('ID_CORSO'), IdCorso);
  SetParam(OreSostegno.ParamByName('ID_FORMATORE'), idDocente);
end;

procedure TSostegno.SetIdProgetto(const Value: integer);
begin
  FIdProgetto := Value;
  FiltriChanged;
end;

procedure TSostegno.SetIdCorso(const Value: integer);
begin
  FIdCorso := Value;
  FiltriChanged;
end;

procedure TSostegno.SetIdDocente(const Value: integer);
begin
  FIdDocente := Value;
  FiltriChanged;
end;

procedure TSostegno.SetDataLezione(const Value: TDateTime);
begin
  FDataLezione := Value;
  FiltriChanged;
end;

procedure TSostegno.AggiungiStudenti;
var
  Ore_Sostegno: TzFbDataSet;
  Studenti: TzFbDataSet;
begin
  Ore_Sostegno := GetDataSet('Ore_Sostegno');
  Ore_Sostegno.CheckBrowseMode;

  Studenti := GetDataSet('Studenti_Presenze_Sostegno');

  if Ore_Sostegno.IsEmpty then
    exit;

  lkStudenti.RevertSQL(False);
  lkStudenti.ParamByName('ID_PROGETTO').Value := Ore_Sostegno.FieldByName('ID_PROGETTO').Value;
  lkStudenti.ParamByName('ID_CORSO').Value := Ore_Sostegno.FieldByName('ID_CORSO').Value;
  lkStudenti.ParamByName('DATA').Value := Ore_Sostegno.FieldByName('DATA_LEZIONE').Value;
  lkStudenti.Active := True;
  try

    lkStudentiDlg.Execute(
      procedure
      begin
        Studenti.Append;
        Studenti.FieldByName('ID_STUDENTE').Value := lkStudenti.FieldByName('ID_STUDENTE').Value;
        Studenti.Post;
      end);

    Studenti.ReOpen();
  finally
    lkStudenti.Active := False;
  end;
end;

procedure TSostegno.FiltriChanged;
begin
  ReopenDataSet('Ore_Sostegno');
end;

procedure TSostegno.lkCorsiBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  lkCorsi.ParamByName('ID_PROGETTO').AsInteger := IdProgetto;
end;

procedure TSostegno.OreSostegnoAfterCreateFields(DataSet: TDataSet);

  procedure AssignEvent(FieldName: string; OnChange: TFieldNotifyEvent);
  var
    Field: TField;
  begin
    Field := DataSet.FindField(FieldName);
    if Assigned(Field) then
      Field.OnChange := OnChange;
  end;

begin
  inherited;

  // calcolo ora fine
  AssignEvent('ORA_INIZIO', OreSostegnoCalcolaOraFine);
  AssignEvent('DURATA', OreSostegnoCalcolaOraFine);

  // id_Incarico
  AssignEvent('ID_PROGETTO', OreSostegnoFieldChanged);
  AssignEvent('ID_CORSO', OreSostegnoFieldChanged);
  AssignEvent('ID_FORMATORE', OreSostegnoFieldChanged);
  AssignEvent('DATA_LEZIONE', OreSostegnoFieldChanged);
  AssignEvent('MATERIA', OreSostegnoFieldChanged);
end;

procedure TSostegno.OreSostegnoCalcolaOraFine(Sender: TField);
var
  DataSet: TzFbDataSet;
  Inizio, Fine, Durata: TField;
begin
  DataSet := GetDataSet('Ore_Sostegno');

  Inizio := DataSet.FieldByName('ORA_INIZIO');
  Durata := DataSet.FieldByName('DURATA');
  Fine := DataSet.FieldByName('ORA_FINE');

  if (Inizio.IsNull or Durata.IsNull) then
    Fine.Clear
  else
    Fine.Value := IncMinute(Inizio.asDateTime, Durata.AsInteger);

  OreSostegnoFieldChanged(Sender);
end;

procedure TSostegno.OreSostegnoNewRecord(DataSet: TDataSet);
begin
  if IdProgetto = -1 then
    exit;

  DataSet.FieldByName('ID_PROGETTO').Value := IdProgetto;

  if IdCorso <> -1 then
    DataSet.FieldByName('ID_CORSO').Value := IdCorso;

  if idDocente <> -1 then
    DataSet.FieldByName('ID_FORMATORE').Value := idDocente;

  DataSet.FieldByName('DATA_LEZIONE').Value := DataLezione;
end;

procedure TSostegno.OreSostegnoFieldChanged(Sender: TField);
var
  DataSet: TzFbDataSet;
  FieldProgetto, FieldCorso, FieldDocente, FieldDataLezione, FieldMateria, FieldIncarico, FieldRilevamento, FieldOraInizio, FieldOraFine: TField;
  idRilevamento, idIncarico: integer;
begin
  DataSet := GetDataSet('Ore_Sostegno');

  // Viene chiamato anche da

  if GetField(DataSet, 'ID_PROGETTO', FieldProgetto) and (not FieldProgetto.IsNull) then
    if GetField(DataSet, 'ID_CORSO', FieldCorso) then
      if GetField(DataSet, 'ID_FORMATORE', FieldDocente) and (not FieldDocente.IsNull) then
        if GetField(DataSet, 'DATA_LEZIONE', FieldDataLezione) and (not FieldDataLezione.IsNull) then
          if GetField(DataSet, 'MATERIA', FieldMateria) then
            if GetField(DataSet, 'ID_INCARICO', FieldIncarico) and (FieldIncarico.IsNull) then
              if GetField(DataSet, 'ID_RILEVAMENTO_ORE', FieldRilevamento) then
                if GetField(DataSet, 'ORA_INIZIO', FieldOraInizio) then
                  if GetField(DataSet, 'ORA_FINE', FieldOraFine) then
                  begin
                    idIncarico := CercaIncarico(FieldProgetto, FieldCorso, FieldDocente, FieldDataLezione, FieldMateria);
                    if idIncarico <> -1 then
                      FieldIncarico.Value := idIncarico;
                    { TODO : Verificare se un eventuale id_incarico preesistente è ancora valido? }

                      if not FieldIncarico.IsNull then
                        if FieldRilevamento.IsNull then { TODO : else verificare se un eventuale rilevamento preesistente è ancora valido? }
                        begin
                          idRilevamento := GetRilevamento(FieldDocente.AsInteger, FieldProgetto.AsInteger, FieldCorso.AsInteger, FieldDataLezione.asDateTime, FieldOraInizio.asDateTime,
                            FieldOraFine.asDateTime, FieldIncarico.AsInteger);

                          if idRilevamento = -1 then
                            FieldRilevamento.Clear
                          else
                            FieldRilevamento.Value := idRilevamento;
                        end;
                  end;
end;

// Cerca l'incarico di sostegno valido per la riga (stessa chiamata usata quando si modifica un campo della riga e da GeneraRilevamento).
// Restituisce -1 se non ne trova.
function TSostegno.CercaIncarico(FieldProgetto, FieldCorso, FieldDocente, FieldDataLezione, FieldMateria: TField): integer;
var
  sp: TSP_INCARICHI_GET_X_SOSTEGNO;
begin
  result := -1;

  sp := TSP_INCARICHI_GET_X_SOSTEGNO.Create(WriteTrans);
  try
    sp.ID_PROGETTO := FieldProgetto.Value;

    if FieldCorso.IsNull then
      sp.ID_CORSO.Clear
    else
      sp.ID_CORSO := FieldCorso.Value;

    sp.ID_RISORSA := FieldDocente.Value;
    sp.DATA_LEZIONE := FieldDataLezione.Value;

    if FieldMateria.IsNull then
      sp.MATERIA.Clear
    else
      sp.MATERIA := FieldMateria.Value;

    sp.SUPPLENZA := False;

    sp.ExecuteAndCommit;

    if not sp.ID_INCARICO.IsNull then
      result := sp.ID_INCARICO.Value;
  finally
    FreeAndNil(sp);
  end;
end;

function TSostegno.GetRilevamento(idDocente, IdProgetto, IdCorso: integer; DataLezione: TDateTime; OraInizio, OraFine: TTime; IdIncarico: integer): integer;
var
  sp: TSP_ORE_RILEVATE_GET_RILEVAMENTO;
begin
  result := -1;

  sp := TSP_ORE_RILEVATE_GET_RILEVAMENTO.Create(WriteTrans);
  try
    sp.ID_DOCENTE := idDocente;
    sp.ID_PROGETTO := IdProgetto;

    if IdCorso = -1 then
      sp.ID_CORSO.Clear
    else
      sp.ID_CORSO := IdCorso;

    sp.ID_INCARICO := IdIncarico;
    sp.DATA_LEZIONE := DataLezione;
    sp.ORA_INIZIO := OraInizio;
    sp.ORA_FINE := OraFine;

    sp.ExecuteAndCommit;

    if sp.ID_RILEVAMENTO_ORE.IsNull then
      result := -1
    else
      result := sp.ID_RILEVAMENTO_ORE;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TSostegno.GeneraIncarico;
var
  IdIncarico: integer;
  Ore_Sostegno: TzFbDataSet;

  IdPersonale, IdProgetto: integer;
  DataLezione: TDateTime;
  TipoIncarico, MATERIA: string;
  TotaleOreAttribuite: double;
begin
  Ore_Sostegno := GetDataSet('Ore_Sostegno');

  Ore_Sostegno.CheckBrowseMode;

  if Ore_Sostegno.IsEmpty then
    exit;

  if not Ore_Sostegno.FieldByName('ID_INCARICO').IsNull then
  begin
    ConfirmOk('Incarico già assegnato.');
    exit;
  end;

  IdPersonale := Ore_Sostegno.FieldByName('ID_FORMATORE').AsInteger;
  IdProgetto := Ore_Sostegno.FieldByName('ID_PROGETTO').AsInteger;
  DataLezione := Ore_Sostegno.FieldByName('DATA_LEZIONE').asDateTime;
  TipoIncarico := '';
  MATERIA := Ore_Sostegno.FieldByName('MATERIA').asString;
  TotaleOreAttribuite := Ore_Sostegno.FieldByName('DURATA').AsInteger / 60;

  IdIncarico := ApriInserimentoIncarico(IdPersonale, IdProgetto, DataLezione, DataLezione, TipoIncarico, MATERIA, TotaleOreAttribuite);

  if IdIncarico <> -1 then
  begin
    Ore_Sostegno.CheckEditMode;
    Ore_Sostegno.FieldByName('ID_INCARICO').AsInteger := IdIncarico;
    Ore_Sostegno.CheckBrowseMode;
  end;
end;

procedure TSostegno.GeneraRilevamento;
var
  sp: TSP_ORE_RILEVATE_GENERA_RILEVAMENTO;
  FieldProgetto, FieldCorso, FieldDocente, FieldDataLezione, FieldMateria, FieldContenuti, FieldIncarico, FieldRilevamento, FieldOraInizio, FieldOraFine: TField;
  Ore_Sostegno: TzFbDataSet;
  idRilevamento, idIncarico: integer;
begin
  Ore_Sostegno := GetDataSet('Ore_Sostegno');

  Ore_Sostegno.CheckBrowseMode;

  if Ore_Sostegno.IsEmpty then
    exit;

  if not Ore_Sostegno.FieldByName('ID_RILEVAMENTO_ORE').IsNull then
  begin
    ConfirmOk('Rilevamento già assegnato.');
    exit;
  end;

  if GetField(Ore_Sostegno, 'ID_PROGETTO', FieldProgetto) then
    if GetField(Ore_Sostegno, 'ID_CORSO', FieldCorso) then
      if GetField(Ore_Sostegno, 'ID_FORMATORE', FieldDocente) then
        if GetField(Ore_Sostegno, 'DATA_LEZIONE', FieldDataLezione) then
          if GetField(Ore_Sostegno, 'MATERIA', FieldMateria) then
            if GetField(Ore_Sostegno, 'CONTENUTI', FieldContenuti) then
              if GetField(Ore_Sostegno, 'ID_INCARICO', FieldIncarico) then
                if GetField(Ore_Sostegno, 'ID_RILEVAMENTO_ORE', FieldRilevamento) then
                  if GetField(Ore_Sostegno, 'ORA_INIZIO', FieldOraInizio) then
                    if GetField(Ore_Sostegno, 'ORA_FINE', FieldOraFine) then
                    begin

                      if FieldProgetto.IsNull then
                      begin
                        ConfirmOk('Progetto non specificato.');
                        exit;
                      end;

                      if FieldDocente.IsNull then
                      begin
                        ConfirmOk('Formatore non specificato.');
                        exit;
                      end;

                      if FieldDataLezione.IsNull then
                      begin
                        ConfirmOk('Data Lezione non specificato.');
                        exit;
                      end;

                      // Mantis #266 - 2026-10-21: l'incarico puo' essere stato creato dopo l'inserimento della riga, quindi lo si cerca di nuovo prima di rifiutare
                      if FieldIncarico.IsNull then
                      begin
                        idIncarico := CercaIncarico(FieldProgetto, FieldCorso, FieldDocente, FieldDataLezione, FieldMateria);

                        if idIncarico <> -1 then
                        begin
                          Ore_Sostegno.CheckEditMode;
                          FieldIncarico.Value := idIncarico;
                          Ore_Sostegno.CheckBrowseMode;
                        end;
                      end;

                      if FieldIncarico.IsNull then
                      begin
                        ConfirmOk('Il formatore non ha un incarico di sostegno valido su questo progetto nella data della lezione.' + sLineBreak +
                          'Creare l''incarico con "Genera Incarico".');
                        exit;
                      end;

                      if not ConfirmYesNo('Si desidera generare il rilevamento?') then
                        exit;

                      StartWait('Attendere...', True);
                      try
                        sp := TSP_ORE_RILEVATE_GENERA_RILEVAMENTO.Create(WriteTrans);
                        try
                          sp.ID_DOCENTE := FieldDocente.Value;
                          sp.ID_PROGETTO := FieldProgetto.Value;

                          if FieldCorso.IsNull or FieldCorso.Value = -1 then
                            sp.ID_CORSO.Clear
                          else
                            sp.ID_CORSO := FieldCorso.Value;

                          sp.ID_INCARICO := FieldIncarico.Value;
                          sp.DATA_LEZIONE := FieldDataLezione.Value;
                          sp.ORA_INIZIO := FieldOraInizio.Value;
                          sp.ORA_FINE := FieldOraFine.Value;

                          if FieldMateria.IsNull then
                            sp.MATERIA.Clear
                          else
                            sp.MATERIA := FieldMateria.Value;

                          if FieldContenuti.IsNull then
                            sp.CONTENUTI.Clear
                          else
                            sp.CONTENUTI := FieldContenuti.Value;

                          sp.RAISE_ERRORS := True;
                          sp.ExecuteAndCommit;
                          idRilevamento := sp.ID_RILEVAMENTO_ORE;
                        finally
                          FreeAndNil(sp);
                        end;

                        if idRilevamento <> -1 then
                        begin
                          Ore_Sostegno.CheckEditMode;
                          Ore_Sostegno.FieldByName('ID_RILEVAMENTO_ORE').AsInteger := idRilevamento;
                          Ore_Sostegno.CheckBrowseMode;
                        end;
                      finally
                        StopWait;
                      end;
                    end;
end;

procedure TSostegno.PresenzeUpdateMaster(DataSet: TDataSet);
var
  Ore_Sostegno: TzFbDataSet;
begin
  Ore_Sostegno := GetDataSet('Ore_Sostegno');
  Ore_Sostegno.RefreshRecord(False);
end;

end.
