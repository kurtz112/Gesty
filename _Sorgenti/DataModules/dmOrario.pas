unit dmOrario;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Generics.Collections,
  System.Variants,
  System.Classes,
  System.Actions,
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
  cxSchedulerStorage,
  cxSchedulerDBStorage,
  cxSchedulerHolidays,
  cxClasses,
  Base_DataModule,
  zFbDataSet,
  dbMaster,
  zDbViewDlg,
  zDbCardDlg,
  zProgressBox,
  Gesty.Types,
  Gesty.Scheduler,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

type
  TGeneraCalendarioParams = record
    DalGiorno: TDateTime;
    AlGiorno: TDateTime;
    lunedi: Boolean;
    martedi: Boolean;
    mercoledi: Boolean;
    giovedi: Boolean;
    venerdi: Boolean;
    sabato: Boolean;
    domenica: Boolean;
    procedure Init;
  end;

  TOrario = class(TBaseDataModule, ISchedulerStorage, ISchedulerCopyPaste)
    CalendarioSrc: TDataSource;
    cxSchedulerDBStorage: TcxSchedulerDBStorage;
    Calendario: TzFbDataSet;
    lkProgetti: TzFbDataSet;
    lkProgettiSrc: TDataSource;
    lkMaterie: TzFbDataSet;
    lkDocenti: TzFbDataSet;
    lkAule: TzFbDataSet;
    ProgressBox: TProgressBox;
    lkCorsi: TzFbDataSet;
    lkCorsiSrc: TDataSource;
    lkEnti: TzFbDataSet;
    lkEntiSrc: TDataSource;
    lkProgettiCodReg: TzFbDataSet;
    lkProgettiCodRegSrc: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure DatasetViewsBeforeOpen(DataSet: TDataSet);
    procedure FiltroEnteBeforeOpen(DataSet: TDataSet);
    procedure lkProgettiAfterOpen(DataSet: TDataSet);
  private
    FFiltroEnte: integer;
    FDataSelezionata: TDate;
    FIdCorso: integer;
    FIdProgetto: integer;
    FOraFineSelezionata: TTime;
    FOraInizioSelezionata: TTime;
    procedure SetIdProgetto(const Value: integer);
    procedure SetIdCorso(const Value: integer);
    procedure RiapriDatasetViews;
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  private
    procedure OrarioLezioniBeforeOpen(DataSet: TDataSet);
    procedure TmpOrarioAfterCreateFields(DataSet: TDataSet);
    procedure TmpOrarioCalcFields(DataSet: TDataSet);
    procedure TmpOrarioNewRecord(DataSet: TDataSet);
    procedure SegnalaAnomalieFileUntis(Files: TList<integer>);
  public
    procedure ImportaFileUntis(Files: TStrings);
    procedure ElaboraFileUntis(Files: TList<integer>);

    procedure ImportaFiles(Files: TStrings);
  public
    procedure AssegnaAulaPerIlGiorno(const Data: TDateTime; const Aula: string);
    function GetNearestFreeTime(idOrario: integer; Value: TDateTime): TDateTime;
  public
    procedure SelezionaLezionePerViews(Data: TDate; DalleOre, AlleOre: TTime);

    property DataSelezionata: TDate read FDataSelezionata;
    property OraInizioSelezionata: TTime read FOraInizioSelezionata;
    property OraFineSelezionata: TTime read FOraFineSelezionata;
  public
    property FiltroEnte: integer read FFiltroEnte write FFiltroEnte;
    property IdProgetto: integer read FIdProgetto write SetIdProgetto;
    property IdCorso: integer read FIdCorso write SetIdCorso;
  private
    SchedulerParams: TSchedulerParams;
  public
    procedure InitStorage;
    function GetSchedulerParams: TSchedulerParams;

    procedure SetPeriodo(DalGiorno: TDate; AlGiorno: TDate);
    procedure RefreshScheduler;
    function SpostaEvento(TipoEvento: TSchedulerTipoEvento; const id: integer; Data: TDate; OraInizio: TTime): Boolean;
    function TipoEventiPerInserimento: TSchedulerTipoEventi;
  public // ISchedulerCopyPaste
    function TipoEventiAmmessi: TSchedulerTipoEventi;
    procedure IncollaOra(srcId: integer; DestData: TDate; DestOra: TTime; Taglia: Boolean);
    procedure IncollaGiorno(srcGiorno, destGiorno: TDateTime);
    procedure IncollaSettimana(srcGiorno, destGiorno: TDateTime);
    procedure InitActions(CopiaOra, CopiaGiorno, CopiaSettimana, TagliaOra, Incolla: TContainedAction);
  public
    GeneraCalendarioParams: TGeneraCalendarioParams;
    procedure ClearTmpOrario;
    procedure GeneraCalendario;
    procedure EliminaCalendario;
  end;

var
  Orario: TOrario;

implementation

uses
  ConfigModule,
  System.DateUtils,
  Gesty_StoredProcs,
  zBaseLib,
  dmScheduler.tools,
  zMsg,
  dmCommon;

{$R *.dfm}
{ TGeneraCalendarioParams }

procedure TGeneraCalendarioParams.Init;
begin
  DalGiorno := 0;
  AlGiorno := 0;
  lunedi := false;
  martedi := false;
  mercoledi := false;
  giovedi := false;
  venerdi := false;
  sabato := false;
  domenica := false;
end;

procedure TOrario.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FFiltroEnte := -1;
  FIdProgetto := -1;
  FIdCorso := -1;
  GeneraCalendarioParams.Init;

  FDataSelezionata := 0;
  FOraInizioSelezionata := 0;
  FOraFineSelezionata := 0;

  SchedulerParams.Init(cxSchedulerDBStorage);
  SchedulerParams.DalGiorno := StartOfTheWeek(Date);
  SchedulerParams.AlGiorno := EndOfTheWeek(Date);
  SchedulerParams.OraInizio := EncodeTime(7, 0, 0, 0);
  SchedulerParams.OraFine := EncodeTime(20, 0, 0, 0);

  InitStorage;
end;

procedure TOrario.ElaboraFileUntis(Files: TList<integer>);
var
  id: integer;
  sp: TSP_ORARIO_IMP_FILES_UNTIS_ELABORA;
begin

  ProgressBox.Show(Files.Count, 'Elaborazione File Orario', 'Elaborazione File Orario', 'Attendere');
  try
    sp := TSP_ORARIO_IMP_FILES_UNTIS_ELABORA.Create(WriteTrans);
    try
      for id in Files do
      begin
        ProgressBox.IncProgress;

        if ProgressBox.Cancelled then
          Exit;

        sp.Id_Orario_Import_File_Untis := id;
        sp.ExecuteAndCommit;
      end;
    finally
      freeAndNil(sp);
    end;

    RefreshDataSets;
  finally
    ProgressBox.Close;
  end;

  SegnalaAnomalieFileUntis(Files);
end;

// Dopo l'elaborazione elenca le classi senza progetto (righe che non sono diventate lezioni)
// e le materie e i docenti non collegati (lezioni create senza materia o senza docente):
// prima la procedura li saltava senza dire niente
procedure TOrario.SegnalaAnomalieFileUntis(Files: TList<integer>);
var
  Anomalie: TzFbDataSet;
  Elenco: TStringList;
  IdFile: integer;
  Riga: string;
begin
  if Files.Count = 0 then
    Exit;

  Elenco := TStringList.Create;
  try
    Anomalie := TzFbDataSet.Create(Self);
    try
      Anomalie.Connection := Config.Database;
      Anomalie.Transaction := ReadTrans;
      Anomalie.Sql.Text :=
        'SELECT ' +
        '    ORARIO_IMP_FILES_UNTIS_ANOMALIE.ANOMALIA, ' +
        '    ORARIO_IMP_FILES_UNTIS_ANOMALIE.CODICE_UNTIS, ' +
        '    ORARIO_IMP_FILES_UNTIS_ANOMALIE.ANNO_FORMATIVO, ' +
        '    ORARIO_IMP_FILES_UNTIS_ANOMALIE.RIGHE ' +
        'FROM ' +
        '    ORARIO_IMP_FILES_UNTIS_ANOMALIE(:ID_ORARIO_IMPORT_FILE_UNTIS)';

      for IdFile in Files do
      begin
        Anomalie.ParamByName('ID_ORARIO_IMPORT_FILE_UNTIS').AsInteger := IdFile;
        Anomalie.Open;
        try
          while not Anomalie.Eof do
          begin
            Riga := Format('%s: %s', [Anomalie.FieldByName('ANOMALIA').AsString, Anomalie.FieldByName('CODICE_UNTIS').AsString]);

            if not Anomalie.FieldByName('ANNO_FORMATIVO').IsNull then
              Riga := Riga + ' ' + Anomalie.FieldByName('ANNO_FORMATIVO').AsString;

            Riga := Riga + Format(' (%d righe)', [Anomalie.FieldByName('RIGHE').AsInteger]);

            if Elenco.IndexOf(Riga) = -1 then
              Elenco.Add(Riga);

            Anomalie.Next;
          end;
        finally
          Anomalie.Close;
        end;
      end;
    finally
      FreeAndNil(Anomalie);
    end;

    if Elenco.Count > 0 then
      ConfirmOk('Elaborazione completata, ma alcune righe non sono state importate per intero:' + sLineBreak + sLineBreak +
        Elenco.Text + sLineBreak +
        'Completare le transcodifiche Untis (Progetti, Materie, Docenti) ed elaborare di nuovo il file.', mtWarning);
  finally
    FreeAndNil(Elenco);
  end;
end;

procedure TOrario.ImportaFiles(Files: TStrings);
var
  sp: TSP_ORARIO_IMPORT_FILE;
  FileName: string;
begin

  ProgressBox.Show(Files.Count, 'Import File Orario', 'Import File Orario', '');
  try
    sp := TSP_ORARIO_IMPORT_FILE.Create(WriteTrans);
    try
      for FileName in Files do
      begin
        ProgressBox.IncProgress('Import File Orario', FileName);

        if ProgressBox.Cancelled then
          Exit;

        sp.Nome_File := System.copy(extractfilename(FileName), 1, 255);
        sp.File_Originale.LoadFromFile(FileName);

        try
          sp.ExecuteAndCommit;
        except
          on e: exception do
            Application.HandleException(e);
        end;
      end;

    finally
      freeAndNil(sp);
    end;

    RefreshDataSets;
  finally
    ProgressBox.Close;
  end;
end;

procedure TOrario.ImportaFileUntis(Files: TStrings);
var
  sp: TSP_ORARIO_IMP_FILES_UNTIS_ADD;
  FileName: string;
  FileImportati: TList<integer>;
begin

  // l'importazione elabora anche il file (ORARIO_IMP_FILES_UNTIS_ADD chiama ORARIO_IMP_FILES_UNTIS_ELABORA):
  // si tengono gli identificativi dei file riusciti per segnalarne le anomalie
  FileImportati := TList<integer>.Create;
  try
    ProgressBox.Show(Files.Count, 'Import File Orario', 'Import File Orario', '');
    try
      sp := TSP_ORARIO_IMP_FILES_UNTIS_ADD.Create(WriteTrans);
      try
        sp.Id_Ente.Clear;
        sp.Id_Sede.Clear;

        for FileName in Files do
        begin
          ProgressBox.IncProgress('Import File Orario', FileName);

          if ProgressBox.Cancelled then
            Exit;

          sp.Nome_File := System.copy(extractfilename(FileName), 1, 255);
          sp.File_Originale.LoadFromFile(FileName);

          try
            sp.ExecuteAndCommit;

            if sp.Id_Orario_Import_File_Untis.HasValue then
              FileImportati.Add(Integer(sp.Id_Orario_Import_File_Untis.Value));
          except
            on e: exception do
              Application.HandleException(e);
          end;
        end;

      finally
        freeAndNil(sp);
      end;

      RefreshDataSets;
    finally
      ProgressBox.Close;
    end;

    SegnalaAnomalieFileUntis(FileImportati);
  finally
    FreeAndNil(FileImportati);
  end;
end;

procedure TOrario.AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet);
begin
  if SameText(DataSetName, 'Orario_Lezioni') then
    DataSet.BeforeOpen := OrarioLezioniBeforeOpen
  else
    if SameText(DataSetName, 'Tmp_Orario') then
    begin
      DataSet.OnAfterCreateFields := TmpOrarioAfterCreateFields;
      DataSet.OnCalcFields := TmpOrarioCalcFields;
      DataSet.OnNewRecord := TmpOrarioNewRecord;
    end;
end;

procedure TOrario.OrarioLezioniBeforeOpen(DataSet: TDataSet);
var
  Orario: TzFbDataSet;
  OrarioLezioni: TzFbDataSet;
begin
  Orario := getDataSet('Orario');
  OrarioLezioni := getDataSet('Orario_Lezioni');
  OrarioLezioni.ParamByName('ID_ORARIO').AsInteger := Orario.FieldByName('ID_ORARIO').AsInteger;
end;

/// ////////////////////////////////////////////////

procedure TOrario.SetIdProgetto(const Value: integer);
begin
  FIdProgetto := Value;

  lkCorsi.Active := false;
  lkCorsi.ParamByName('ID_PROGETTO').Value := IdProgetto;
  lkCorsi.Active := True;

  RefreshScheduler;
  RiapriDatasetViews;
  ClearTmpOrario;
end;

procedure TOrario.lkProgettiAfterOpen(DataSet: TDataSet);
begin
  inherited;

  if IdProgetto <> -1 then
    lkProgetti.Locate('ID_PROGETTO', IdProgetto, []);
end;

procedure TOrario.SetIdCorso(const Value: integer);
begin
  FIdCorso := Value;
  RefreshScheduler;
  ClearTmpOrario;
end;

procedure TOrario.SelezionaLezionePerViews(Data: TDate; DalleOre, AlleOre: TTime);
begin
  FDataSelezionata := Data;
  FOraInizioSelezionata := DalleOre;
  FOraFineSelezionata := AlleOre;

  RiapriDatasetViews;
end;

procedure TOrario.RiapriDatasetViews;
begin
  lkMaterie.ReOpen();
  lkDocenti.ReOpen();
  lkAule.ReOpen();
end;

procedure TOrario.DatasetViewsBeforeOpen(DataSet: TDataSet);
var
  lkDataSet: TzFbDataSet;
begin
  inherited;
  lkDataSet := TzFbDataSet(DataSet);
  lkDataSet.ParamByName('ID_PROGETTO').AsInteger := IdProgetto;
  lkDataSet.ParamByName('DATA_LEZIONE').asDateTime := DataSelezionata;
  lkDataSet.ParamByName('DALLE_ORE').asDateTime := OraInizioSelezionata;
  lkDataSet.ParamByName('ALLE_ORE').asDateTime := OraFineSelezionata;
end;

procedure TOrario.AssegnaAulaPerIlGiorno(const Data: TDateTime; const Aula: string);
var
  sp: TSP_ORARIO_ASSEGNA_AULA_PER_GIORNO;
begin
  StartWait('Attendere...', True);
  try
    sp := TSP_ORARIO_ASSEGNA_AULA_PER_GIORNO.Create(WriteTrans);
    try
      sp.id_Progetto := IdProgetto;
      sp.Data := Data;
      sp.Aula := Aula;
      sp.ExecuteAndCommit;
    finally
      freeAndNil(sp);
    end;
  finally
    StopWait;
  end;

  RefreshScheduler;
end;

function TOrario.GetNearestFreeTime(idOrario: integer; Value: TDateTime): TDateTime;

  function RoundTime(Time: TDateTime; Minutes: integer): TDateTime;
  var
    IncrementFraction: Double;
  begin
    IncrementFraction := (Minutes * 60) / (60 * 60 * 24); // minuti/giorno
    result := round(Time / IncrementFraction) * IncrementFraction;
  end;

  function SetMinute(Time: TDateTime; Minutes: integer): TDateTime;
  var
    h, m, s, ms: word;
  begin
    DecodeTime(Time, h, m, s, ms);
    result := EncodeTime(h, 0, 0, 0);
  end;

  function Overlap(From1: TDateTime; To1: TDateTime; From2: TDateTime; To2: TDateTime): Boolean;
  begin
    result := (From1 < To2) and (From2 < To1);
  end;

  function Occupato(Value: TDateTime; Durata: integer): Boolean;
  var
    delta: integer;
    I: integer;
  begin
    result := false;

    for I := 0 to cxSchedulerDBStorage.EventCount - 1 do
    begin
      delta := MinutesBetween(cxSchedulerDBStorage.Events[I].Start, Value);

      if idOrario <> -1 then
        if cxSchedulerDBStorage.Events[I].GetCustomFieldValueByName('ID_ORARIO') = idOrario then
          continue;

      result := Overlap(cxSchedulerDBStorage.Events[I].Start, cxSchedulerDBStorage.Events[I].Finish, Value, IncMinute(Value, Durata));

      if result then
        break;
    end;
  end;

  function GetTime(delta: integer): TDateTime;
  begin
    result := Value;
    result.AddMinute(delta);
    result := RoundTime(result, 30);
  end;

const
  Durata = 60;

var
  tmp: TDateTime;
begin
  SiMain.EnterMethod(Self, 'GetNearestFreeTime');
  SiMain.LogDateTime('Param', Value);

  result := -1;

  tmp := RoundTime(Value, 30);

  if not Occupato(tmp, Durata) then
    result := tmp
  else
  begin
    // tenta la mezz'ora precedente
    tmp := GetTime(-30);
    if not Occupato(tmp, Durata) then
      result := tmp
    else
    begin
      // tenta la mezz'ora successiva
      tmp := GetTime(+30);
      if not Occupato(tmp, Durata) then
        result := tmp
      else
      begin
        // tenta l'ora precedente
        tmp := GetTime(-60);
        if not Occupato(tmp, Durata) then
          result := tmp
        else
        begin
          // tenta l'ora successiva
          tmp := GetTime(+60);
          if not Occupato(tmp, Durata) then
            result := tmp
        end;
      end;
    end;
  end;

  SiMain.LogDateTime('Result', result);
  SiMain.LeaveMethod(Self, 'GetNearestFreeTime');
end;

/// ////////////////////////////////////////////////////////////////

procedure TOrario.InitStorage;
begin
  OpenDataSets;

  cxSchedulerDBStorage.Resources.DataSource := nil; //

  cxSchedulerDBStorage.DataSource := CalendarioSrc;
  SchedulerTools.InitStorage(cxSchedulerDBStorage);
end;

function TOrario.GetSchedulerParams: TSchedulerParams;
begin
  result := SchedulerParams;
end;

procedure TOrario.SetPeriodo(DalGiorno: TDate; AlGiorno: TDate);
begin
  SchedulerParams.DalGiorno := DalGiorno;
  SchedulerParams.AlGiorno := AlGiorno;

  RefreshScheduler;
end;

procedure TOrario.RefreshScheduler;
begin

  if IdProgetto = -1 then
    Exit;

  Calendario.Active := false;
  Calendario.ParamByName('PARAM_ID_PROGETTO').AsInteger := IdProgetto;
  Calendario.ParamByName('PARAM_ID_CORSO').AsInteger := IdCorso;
  Calendario.ParamByName('PARAM_ID_RISORSA').Clear;
  Calendario.ParamByName('DAL_GIORNO').asDate := SchedulerParams.DalGiorno;
  Calendario.ParamByName('AL_GIORNO').asDate := SchedulerParams.AlGiorno;
  Calendario.Active := True;

  if Assigned(SchedulerParams.AfterRefreshScheduler) then
    SchedulerParams.AfterRefreshScheduler();
end;

function TOrario.SpostaEvento(TipoEvento: TSchedulerTipoEvento; const id: integer; Data: TDate; OraInizio: TTime): Boolean;
begin
  result := false; // Implementare
end;

function TOrario.TipoEventiPerInserimento: TSchedulerTipoEventi;
begin
  result := [teOrarioLezione];
end;

function TOrario.TipoEventiAmmessi: TSchedulerTipoEventi;
begin
  result := [teOrarioLezione];
end;

procedure TOrario.IncollaOra(srcId: integer; DestData: TDate; DestOra: TTime; Taglia: Boolean);
var
  sp: TSP_ORARIO_INCOLLA_ORA;
begin
  sp := TSP_ORARIO_INCOLLA_ORA.Create(WriteTrans);
  try
    sp.Id_Orario := srcId;
    sp.Dest_Data := DestData;
    sp.Dest_Ora := DestOra;
    sp.Taglia := Taglia;
    sp.ExecuteAndCommit;
  finally
    freeAndNil(sp);
  end;

  RefreshScheduler;
end;

procedure TOrario.IncollaGiorno(srcGiorno, destGiorno: TDateTime);
var
  sp: TSP_ORARIO_INCOLLA_GIORNO;
begin
  sp := TSP_ORARIO_INCOLLA_GIORNO.Create(WriteTrans);
  try
    sp.id_Progetto := IdProgetto;
    sp.Src_Data := srcGiorno;
    sp.Dest_Data := destGiorno;
    sp.ExecuteAndCommit;
  finally
    freeAndNil(sp);
  end;

  RefreshScheduler;
end;

procedure TOrario.IncollaSettimana(srcGiorno, destGiorno: TDateTime);
var
  sp: TSP_ORARIO_INCOLLA_SETTIMANA;
begin
  sp := TSP_ORARIO_INCOLLA_SETTIMANA.Create(WriteTrans);
  try
    sp.id_Progetto := IdProgetto;
    sp.Src_Data := srcGiorno;
    sp.Dest_Data := destGiorno;
    sp.ExecuteAndCommit;
  finally
    freeAndNil(sp);
  end;

  RefreshScheduler;
end;

procedure TOrario.InitActions(CopiaOra, CopiaGiorno, CopiaSettimana, TagliaOra, Incolla: TContainedAction);
begin
  CopiaOra.Caption := 'Copia Lezione';
  CopiaGiorno.Caption := 'Copia Giorno';
  CopiaSettimana.Caption := 'Copia Settimana';
  TagliaOra.Caption := 'Taglia Lezione';
  Incolla.Caption := 'Incolla Lezioni';
end;

procedure TOrario.ClearTmpOrario;
var
  sp: TSP_tmp_Orario_Clear;

  TmpOrario: TzFbDataSet;
begin
  sp := TSP_tmp_Orario_Clear.Create(WriteTrans);
  try
    sp.ExecuteAndCommit;
  finally
    freeAndNil(sp);
  end;

  ///

  TmpOrario := getDataSet('Tmp_Orario');

  if TmpOrario.Active then
    TmpOrario.ReOpen();
end;

procedure TOrario.GeneraCalendario;
var
  DataSet: TzFbDataSet;
  sp: TSP_TMP_ORARIO_ELABORA;
begin
  StartWait('Attendere...', True);
  try
    DataSet := getDataSet('TMP_ORARIO');
    DataSet.CheckBrowseMode;

    if DataSet.IsEmpty then
    begin
      ConfirmOk('Nessuna lezione inserita.');
      Exit;
    end;

    sp := TSP_TMP_ORARIO_ELABORA.Create(WriteTrans);
    try
      sp.id_Progetto := IdProgetto;
      sp.Id_Corso := IdCorso;

      sp.Dal_Giorno := GeneraCalendarioParams.DalGiorno;
      sp.Al_Giorno := GeneraCalendarioParams.AlGiorno;

      sp.lunedi := GeneraCalendarioParams.lunedi;
      sp.martedi := GeneraCalendarioParams.martedi;
      sp.mercoledi := GeneraCalendarioParams.mercoledi;
      sp.giovedi := GeneraCalendarioParams.giovedi;
      sp.venerdi := GeneraCalendarioParams.venerdi;
      sp.sabato := GeneraCalendarioParams.sabato;
      sp.domenica := GeneraCalendarioParams.domenica;

      sp.ExecuteAndCommit;
    finally
      freeAndNil(sp);
    end;

    RefreshScheduler;
  finally
    StopWait;
  end;
end;

procedure TOrario.TmpOrarioAfterCreateFields(DataSet: TDataSet);
begin
  DataSet.CreateCalculatedField(TDateTimeField, 'DATA');
  DataSet.CreateCalculatedField(TIntegerField, 'ID_PROGETTO');
  DataSet.CreateCalculatedField(TIntegerField, 'ID_CORSO');
end;

procedure TOrario.TmpOrarioCalcFields(DataSet: TDataSet);

  procedure SetValue(const FieldName: string; const Value: integer);
  begin

    if Value = -1 then
      DataSet.FieldByName(FieldName).Clear
    else
      DataSet.FieldByName(FieldName).AsInteger := Value;
  end;

begin
  SetValue('ID_PROGETTO', IdProgetto);
  SetValue('ID_CORSO', IdCorso);
  DataSet.FieldByName('DATA').asDateTime := GeneraCalendarioParams.DalGiorno;
end;

procedure TOrario.TmpOrarioNewRecord(DataSet: TDataSet);
begin
  try

    DataSet.FieldByName('ID_SESSIONE').Value := Common.CurrentIdSessione;
    DataSet.FieldByName('ORA_INIZIO').FocusControl;
  except
  end;
end;

procedure TOrario.FiltroEnteBeforeOpen(DataSet: TDataSet);
var
  zFbDataSet: TzFbDataSet;
begin
  inherited;
  zFbDataSet := TzFbDataSet(DataSet);

  if zFbDataSet.ParamExists('ID_ENTE') then
    zFbDataSet.ParamByName('ID_ENTE').AsInteger := FiltroEnte;
end;

procedure TOrario.EliminaCalendario;
var
  sp: TSP_ORARIO_ELIMINA_PERIODO;
begin
  StartWait('Attendere...', True);
  try

    sp := TSP_ORARIO_ELIMINA_PERIODO.Create(WriteTrans);
    try
      sp.id_Progetto := IdProgetto;
      sp.Id_Corso := IdCorso;

      sp.Dal_Giorno := GeneraCalendarioParams.DalGiorno;
      sp.Al_Giorno := GeneraCalendarioParams.AlGiorno;

      sp.lunedi := GeneraCalendarioParams.lunedi;
      sp.martedi := GeneraCalendarioParams.martedi;
      sp.mercoledi := GeneraCalendarioParams.mercoledi;
      sp.giovedi := GeneraCalendarioParams.giovedi;
      sp.venerdi := GeneraCalendarioParams.venerdi;
      sp.sabato := GeneraCalendarioParams.sabato;
      sp.domenica := GeneraCalendarioParams.domenica;

      sp.ExecuteAndCommit;
    finally
      freeAndNil(sp);
    end;

    RefreshScheduler;
  finally
    StopWait;
  end;
end;

end.
