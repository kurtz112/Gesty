unit dmInterventiIntegrativi;

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
  zDbViewDlg,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  zFbDataSet;

type
  TInterventiIntegrativi = class(TBaseDataModule)
    lkDocenti: TzFbDataSet;
    lkDocentiSrc: TDataSource;
    lkStudenti: TzFbDataSet;
    lkStudentiSrc: TDataSource;
    lkStudentiDlg: TzDbViewDlg;
    procedure DataModuleCreate(Sender: TObject);
  private
    FIdDocente: integer;
    FDataLezione: TDateTime;
    procedure SetIdDocente(const Value: integer);
    procedure SetDataLezione(const Value: TDateTime);
  private
    procedure InterventiIntegrativiBeforeOpen(DataSet: TDataSet);
    procedure InterventiIntegrativiNewRecord(DataSet: TDataSet);
    procedure InterventiIntegrativiAfterCreateFields(DataSet: TDataSet);
    procedure InterventiIntegrativiCalcolaOraFine(Sender: TField);
    procedure InterventiIntegrativiFieldChanged(Sender: TField);
    procedure FiltriChanged;
  private
    procedure PresenzeUpdateMaster(DataSet: TDataSet);
  private
    function GetField(DataSet: TDataSet; FieldName: string; out Field: TField): boolean;
    function GetRilevamento(idDocente, IdProgetto, IdCorso: integer; DataLezione: TDateTime; OraInizio, OraFine: TTime; IdIncarico: integer): integer;
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    property idDocente: integer read FIdDocente write SetIdDocente;
    property DataLezione: TDateTime read FDataLezione write SetDataLezione;
  public
    procedure AggiungiStudenti;
    procedure GeneraIncarico;
    procedure GeneraRilevamento;
  end;

var
  InterventiIntegrativi: TInterventiIntegrativi;

implementation

uses
  System.DateUtils,
  WizInserimentoIncaricoFrm,
  Gesty_StoredProcs,
  zBaseLib,
  ConfigModule,
  zMsg;

{$R *.dfm}

procedure TInterventiIntegrativi.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FIdDocente := -1;
  FDataLezione := Date;
end;

procedure TInterventiIntegrativi.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'InterventiIntegrativi') then
  begin
    DataSet.BeforeOpen := InterventiIntegrativiBeforeOpen;
    DataSet.OnNewRecord := InterventiIntegrativiNewRecord;
    DataSet.OnAfterCreateFields := InterventiIntegrativiAfterCreateFields;
  end
  else
    if SameText(DataSetName, 'Presenze') then
    begin
      DataSet.AfterPost := PresenzeUpdateMaster;
      DataSet.AfterDelete := PresenzeUpdateMaster;
    end;
end;

function TInterventiIntegrativi.GetField(DataSet: TDataSet; FieldName: string; out Field: TField): boolean;
begin
  result := False;

  Field := DataSet.FindField(FieldName);

  result := Assigned(Field);
end;

procedure TInterventiIntegrativi.InterventiIntegrativiBeforeOpen(DataSet: TDataSet);
var
  InterventiIntegrativi: TzFbDataSet;

  procedure SetParam(Param: TFDParam; Value: integer);
  begin
    if Value = -1 then
      Param.Clear
    else
      Param.Value := Value;
  end;

begin
  InterventiIntegrativi := GetDataSet('InterventiIntegrativi');
  InterventiIntegrativi.ParamByName('DATA_LEZIONE').Value := DataLezione;
  SetParam(InterventiIntegrativi.ParamByName('ID_FORMATORE'), idDocente);
end;

procedure TInterventiIntegrativi.SetIdDocente(const Value: integer);
begin
  FIdDocente := Value;
  FiltriChanged;
end;

procedure TInterventiIntegrativi.SetDataLezione(const Value: TDateTime);
begin
  FDataLezione := Value;
  FiltriChanged;
end;

procedure TInterventiIntegrativi.AggiungiStudenti;
var
  InterventiIntegrativi: TzFbDataSet;
  Presenze: TzFbDataSet;
begin
  InterventiIntegrativi := GetDataSet('InterventiIntegrativi');
  InterventiIntegrativi.CheckBrowseMode;

  Presenze := GetDataSet('Presenze');

  if InterventiIntegrativi.IsEmpty then
    exit;

  lkStudenti.RevertSQL(False);
  lkStudenti.ParamByName('ID_PROGETTO').Value := InterventiIntegrativi.FieldByName('ID_PROGETTO').Value;
  lkStudenti.ParamByName('ID_CORSO').Value := InterventiIntegrativi.FieldByName('ID_CORSO').Value;
  lkStudenti.ParamByName('DATA').Value := InterventiIntegrativi.FieldByName('DATA_LEZIONE').Value;
  lkStudenti.Active := True;
  try

    lkStudentiDlg.Execute(
      procedure
      begin
        Presenze.Append;
        Presenze.FieldByName('ID_STUDENTE').Value := lkStudenti.FieldByName('ID_STUDENTE').Value;
        Presenze.Post;
      end);

    Presenze.ReOpen();
  finally
    lkStudenti.Active := False;
  end;
end;

procedure TInterventiIntegrativi.FiltriChanged;
begin
  ReopenDataSet('InterventiIntegrativi');
end;

procedure TInterventiIntegrativi.InterventiIntegrativiAfterCreateFields(DataSet: TDataSet);

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
  AssignEvent('ORA_INIZIO', InterventiIntegrativiCalcolaOraFine);
  AssignEvent('DURATA', InterventiIntegrativiCalcolaOraFine);

  // id_Incarico
  AssignEvent('ID_PROGETTO', InterventiIntegrativiFieldChanged);
  AssignEvent('ID_CORSO', InterventiIntegrativiFieldChanged);
  AssignEvent('ID_FORMATORE', InterventiIntegrativiFieldChanged);
  AssignEvent('DATA_LEZIONE', InterventiIntegrativiFieldChanged);
  AssignEvent('MATERIA', InterventiIntegrativiFieldChanged);
end;

procedure TInterventiIntegrativi.InterventiIntegrativiCalcolaOraFine(Sender: TField);
var
  DataSet: TzFbDataSet;
  Inizio, Fine, Durata: TField;
begin
  DataSet := GetDataSet('InterventiIntegrativi');

  Inizio := DataSet.FieldByName('ORA_INIZIO');
  Durata := DataSet.FieldByName('DURATA');
  Fine := DataSet.FieldByName('ORA_FINE');

  if (Inizio.IsNull or Durata.IsNull) then
    Fine.Clear
  else
    Fine.Value := IncMinute(Inizio.asDateTime, Durata.AsInteger);

  InterventiIntegrativiFieldChanged(Sender);
end;

procedure TInterventiIntegrativi.InterventiIntegrativiNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('DATA_LEZIONE').Value := DataLezione;

  if idDocente <> -1 then
    DataSet.FieldByName('ID_FORMATORE').Value := idDocente;
end;

procedure TInterventiIntegrativi.InterventiIntegrativiFieldChanged(Sender: TField);
var
  DataSet: TzFbDataSet;
  FieldProgetto, FieldCorso, FieldDocente, FieldDataLezione, FieldMateria, FieldIncarico, FieldRilevamento, FieldOraInizio, FieldOraFine: TField;
  idRilevamento: integer;
  sp: TSP_incarichi_Get_X_Int_Integrativo;
begin
  DataSet := GetDataSet('InterventiIntegrativi');

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
                    sp := TSP_incarichi_Get_X_Int_Integrativo.Create(WriteTrans);
                    try
                      sp.ID_RISORSA := FieldDocente.Value;
                      sp.DATA_LEZIONE := FieldDataLezione.Value;

                      if FieldMateria.IsNull then
                        sp.MATERIA.Clear
                      else
                        sp.MATERIA := FieldMateria.Value;

                      sp.SUPPLENZA := False;

                      sp.ExecuteAndCommit;

                      if not sp.ID_INCARICO.IsNull then
                        if sp.ID_INCARICO.Value <> -1 then
                          FieldIncarico.Value := sp.ID_INCARICO;
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
                    finally
                      FreeAndNil(sp);
                    end;
                  end;
end;

function TInterventiIntegrativi.GetRilevamento(idDocente, IdProgetto, IdCorso: integer; DataLezione: TDateTime; OraInizio, OraFine: TTime; IdIncarico: integer): integer;
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

procedure TInterventiIntegrativi.GeneraIncarico;
var
  IdIncarico: integer;
  InterventiIntegrativi: TzFbDataSet;

  IdPersonale, IdProgetto: integer;
  DataLezione: TDateTime;
  TipoIncarico, MATERIA: string;
  TotaleOreAttribuite: double;
begin
  InterventiIntegrativi := GetDataSet('InterventiIntegrativi');

  InterventiIntegrativi.CheckBrowseMode;

  if InterventiIntegrativi.IsEmpty then
    exit;

  if not InterventiIntegrativi.FieldByName('ID_INCARICO').IsNull then
  begin
    ConfirmOk('Incarico già assegnato.');
    exit;
  end;

  IdPersonale := InterventiIntegrativi.FieldByName('ID_FORMATORE').AsInteger;
  IdProgetto := InterventiIntegrativi.FieldByName('ID_PROGETTO').AsInteger;
  DataLezione := InterventiIntegrativi.FieldByName('DATA_LEZIONE').asDateTime;
  TipoIncarico := '';
  MATERIA := InterventiIntegrativi.FieldByName('MATERIA').asString;
  TotaleOreAttribuite := InterventiIntegrativi.FieldByName('DURATA').AsInteger / 60;

  IdIncarico := ApriInserimentoIncarico(IdPersonale, IdProgetto, DataLezione, DataLezione, TipoIncarico, MATERIA, TotaleOreAttribuite);

  if IdIncarico <> -1 then
  begin
    InterventiIntegrativi.CheckEditMode;
    InterventiIntegrativi.FieldByName('ID_INCARICO').AsInteger := IdIncarico;
    InterventiIntegrativi.CheckBrowseMode;
  end;
end;

procedure TInterventiIntegrativi.GeneraRilevamento;
var
  sp: TSP_ORE_RILEVATE_GENERA_RILEVAMENTO;
  FieldProgetto, FieldCorso, FieldDocente, FieldDataLezione, FieldMateria, FieldContenuti, FieldIncarico, FieldRilevamento, FieldOraInizio, FieldOraFine: TField;
  InterventiIntegrativi: TzFbDataSet;
  idRilevamento: integer;
begin
  InterventiIntegrativi := GetDataSet('InterventiIntegrativi');

  InterventiIntegrativi.CheckBrowseMode;

  if InterventiIntegrativi.IsEmpty then
    exit;

  if not InterventiIntegrativi.FieldByName('ID_RILEVAMENTO_ORE').IsNull then
  begin
    ConfirmOk('Rilevamento già assegnato.');
    exit;
  end;

  if GetField(InterventiIntegrativi, 'ID_PROGETTO', FieldProgetto) then
    if GetField(InterventiIntegrativi, 'ID_CORSO', FieldCorso) then
      if GetField(InterventiIntegrativi, 'ID_FORMATORE', FieldDocente) then
        if GetField(InterventiIntegrativi, 'DATA_LEZIONE', FieldDataLezione) then
          if GetField(InterventiIntegrativi, 'MATERIA', FieldMateria) then
            if GetField(InterventiIntegrativi, 'CONTENUTI', FieldContenuti) then
              if GetField(InterventiIntegrativi, 'ID_INCARICO', FieldIncarico) then
                if GetField(InterventiIntegrativi, 'ID_RILEVAMENTO_ORE', FieldRilevamento) then
                  if GetField(InterventiIntegrativi, 'ORA_INIZIO', FieldOraInizio) then
                    if GetField(InterventiIntegrativi, 'ORA_FINE', FieldOraFine) then
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

                      if FieldIncarico.IsNull then
                      begin
                        ConfirmOk('Id Incarico non specificato.');
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
                          InterventiIntegrativi.CheckEditMode;
                          InterventiIntegrativi.FieldByName('ID_RILEVAMENTO_ORE').AsInteger := idRilevamento;
                          InterventiIntegrativi.CheckBrowseMode;
                        end;
                      finally
                        StopWait;
                      end;
                    end;
end;

procedure TInterventiIntegrativi.PresenzeUpdateMaster(DataSet: TDataSet);
var
  InterventiIntegrativi: TzFbDataSet;
begin
  InterventiIntegrativi := GetDataSet('InterventiIntegrativi');
  InterventiIntegrativi.RefreshRecord(False);
end;

end.
