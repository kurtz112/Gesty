unit dmPrenotazioniAule;

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
  dbMaster,
  Base_DataModule,
  zFbDataSet,
  zDbViewDlg,
  zDbCardDlg,
   zProgressBox,
  Gesty.Scheduler,
  Gesty.Types;

type
  TPrenotazioniAule = class(TBaseDataModule, ISchedulerStorage, ISchedulerCopyPaste)
    CalendarioSrc: TDataSource;
    cxSchedulerDBStorage: TcxSchedulerDBStorage;
    Calendario: TzFbDataSet;
    ElencoAule: TzFbDataSet;
    ElencoAuleSrc: TDataSource;
    ProgressBox: TProgressBox;
    SlotLiberi: TzFbDataSet;
    lkFiltroAule: TzFbDataSet;
    lkFiltroAuleSrc: TDataSource;
    RiepilogoOccupazioni: TzFbDataSet;
    RiepilogoOccupazioniSrc: TDataSource;
    lkFiltroSedi: TzFbDataSet;
    lkFiltroSediSrc: TDataSource;
    lkAule: TzFbDataSet;
    lkAuleSrc: TDataSource;
    procedure CalendarioBeforeOpen(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure cxSchedulerDBStorageResourcesResourceLoaded(Sender: TObject; AResource: TcxSchedulerStorageResourceItem);
  private
    SchedulerParams: TSchedulerParams;
  public
    procedure InitStorage;
    function GetSchedulerParams: TSchedulerParams;

    procedure SetPeriodo(DalGiorno: TDate; AlGiorno: TDate);
    procedure RefreshScheduler;
    function TipoEventiPerInserimento: TSchedulerTipoEventi;
  public
    procedure AttivaCalendario;
    procedure CercaSlotLiberi(Aula: string; idSede: integer; DalGiorno, AlGiorno: TDate; DalleOre, AlleOre: TTime; DurataEvento: integer; Granularita: integer);
    function PrenotaAulaDaGiorniLiberi: boolean;
  public
    AuleSelezionate: TStringList;
    procedure SelezionaAule(Aule: TList<string>);
  public
    function TipoEventiAmmessi: TSchedulerTipoEventi;
    procedure IncollaOra(srcId: integer; DestData: TDate; DestOra: TTime; Taglia: boolean);
    procedure IncollaGiorno(srcGiorno, destGiorno: TDateTime);
    procedure IncollaSettimana(srcGiorno, destGiorno: TDateTime);
    procedure InitActions(CopiaOra, CopiaGiorno, CopiaSettimana, TagliaOra, Incolla: TContainedAction);
  public
    procedure GeneraPrenotazioniAule(const Aula: string);
  end;

var
  PrenotazioniAule: TPrenotazioniAule;

implementation

uses
  System.DateUtils,
  ConfigModule,
  Gesty_StoredProcs,
  zBaseLib,
  dmScheduler.Tools,
  frmGeneraPrenotazioniAule,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

{$R *.dfm}

type
  TcxSchedulerStorageResourcesAccess = class(TcxSchedulerStorageResources);

procedure TPrenotazioniAule.DataModuleCreate(Sender: TObject);
begin
  SiMain.EnterMethod(Self, 'DataModuleCreate');
  inherited;
  AuleSelezionate := TStringList.Create;
  SchedulerParams.Init(cxSchedulerDBStorage);
  SchedulerParams.DalGiorno := StartOfTheWeek(Date);
  SchedulerParams.AlGiorno := EndOfTheWeek(Date);
  SchedulerParams.OraInizio := EncodeTime(7, 0, 0, 0);
  SchedulerParams.OraFine := EncodeTime(20, 0, 0, 0);

  InitStorage;
  SiMain.LeaveMethod(Self, 'DataModuleCreate');
end;

procedure TPrenotazioniAule.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(AuleSelezionate);
end;

procedure TPrenotazioniAule.cxSchedulerDBStorageResourcesResourceLoaded(Sender: TObject; AResource: TcxSchedulerStorageResourceItem);
begin
  inherited;
  AResource.Visible := AuleSelezionate.IndexOf(AResource.ResourceID) <> -1;
end;

procedure TPrenotazioniAule.IncollaOra(srcId: integer; DestData: TDate; DestOra: TTime; Taglia: boolean);
var
  sp: TSP_AULE_PRENOTAZIONI_INCOLLA_ORA;
begin
  sp := TSP_AULE_PRENOTAZIONI_INCOLLA_ORA.Create(WriteTrans);
  try
    sp.ID_PRENOTAZIONE_AULA := srcId;
    sp.Dest_Data := DestData;
    sp.Dest_Ora := DestOra;
    sp.Taglia := Taglia;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  RefreshScheduler;
end;

procedure TPrenotazioniAule.IncollaGiorno(srcGiorno, destGiorno: TDateTime);
var
  sp: TSP_AULE_PRENOTAZIONI_INCOLLA_GIORN;
begin
  sp := TSP_AULE_PRENOTAZIONI_INCOLLA_GIORN.Create(WriteTrans);
  try
    sp.Src_Data := srcGiorno;
    sp.Dest_Data := destGiorno;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  RefreshScheduler;
end;

procedure TPrenotazioniAule.IncollaSettimana(srcGiorno, destGiorno: TDateTime);
var
  sp: TSP_AULE_PRENOTAZIONI_INCOLLA_SETT;
begin
  sp := TSP_AULE_PRENOTAZIONI_INCOLLA_SETT.Create(WriteTrans);
  try
    sp.Src_Data := srcGiorno;
    sp.Dest_Data := destGiorno;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  RefreshScheduler;
end;

function TPrenotazioniAule.TipoEventiAmmessi: TSchedulerTipoEventi;
begin
  result := [tePrenotazioneAule];
end;

procedure TPrenotazioniAule.InitStorage;

  procedure InizializzaAuleSelezionate;
  begin
    AuleSelezionate.Clear;
    ElencoAule.Active := True;

    if not ElencoAule.Eof then
      AuleSelezionate.Add(ElencoAule.FieldByName('AULA').AsString);
  end;

begin
  SiMain.EnterMethod(Self, 'InitStorage');

  OpenDataSets;
  InizializzaAuleSelezionate;

  /// //////////////////////////////////////////////////////////////////////////
  SiMain.LogVerbose('Resources');
  cxSchedulerDBStorage.Resources.DataSource := nil;
  cxSchedulerDBStorage.Resources.ResourceID := 'AULA';
  cxSchedulerDBStorage.Resources.ResourceName := 'DESC_AULA';
  cxSchedulerDBStorage.Resources.ResourceColor := 'COLORE';
  cxSchedulerDBStorage.Resources.ResourceImageIndex := 'IMAGE_INDEX';
  cxSchedulerDBStorage.Resources.DataSource := ElencoAuleSrc;

  /// //////////////////////////////////////////////////////////////////////////
  SiMain.LogVerbose('DataSource');
  cxSchedulerDBStorage.DataSource := CalendarioSrc;
  SchedulerTools.InitStorage(cxSchedulerDBStorage);

  cxSchedulerDBStorage.FieldNames.ResourceID := 'AULA';
  cxSchedulerDBStorage.CUSTOMFIELDS.Add.FieldName := 'AULA';
  SiMain.LeaveMethod(Self, 'InitStorage');
end;

function TPrenotazioniAule.GetSchedulerParams: TSchedulerParams;
begin
  result := SchedulerParams;
end;

procedure TPrenotazioniAule.SetPeriodo(DalGiorno: TDate; AlGiorno: TDate);
begin
  SchedulerParams.DalGiorno := DalGiorno;
  SchedulerParams.AlGiorno := AlGiorno;

  RefreshScheduler;
end;

procedure TPrenotazioniAule.CalendarioBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  Calendario.ParamByName('DAL_GIORNO').asDate := SchedulerParams.DalGiorno;
  Calendario.ParamByName('AL_GIORNO').asDate := SchedulerParams.AlGiorno;
end;

procedure TPrenotazioniAule.RefreshScheduler;
begin
  SiMain.EnterMethod(Self, 'RefreshScheduler');

  if Calendario.Active then
    Calendario.ReOpen();

  if Assigned(SchedulerParams.AfterRefreshScheduler) then
    SchedulerParams.AfterRefreshScheduler();

  SiMain.LeaveMethod(Self, 'RefreshScheduler');
end;

procedure TPrenotazioniAule.AttivaCalendario;
begin
  SiMain.EnterMethod(Self, 'AttivaCalendario');

  Calendario.Active := True;

  SiMain.LeaveMethod(Self, 'AttivaCalendario');
end;

function TPrenotazioniAule.TipoEventiPerInserimento: TSchedulerTipoEventi;
begin
  result := [tePrenotazioneAule];
end;

function TPrenotazioniAule.PrenotaAulaDaGiorniLiberi: boolean;
var
  params: TEventoParams;

  Data: TDate;
  OraInizio, OraFine: TTime;
  Aula: string;
begin
  result := False;

  if SlotLiberi.IsEmpty then
    exit;

  params.Init;

  params.TipoEvento := tePrenotazioneAule;
  params.id := -1;
  params.Data := SlotLiberi.FieldByName('DATA').Value;
  params.OraInizio := SlotLiberi.FieldByName('ORA_INIZIO').Value;
  params.OraFine := SlotLiberi.FieldByName('ORA_FINE').Value;
  params.Aula := SlotLiberi.ParamByName('PARAM_AULA').Value; // Param non Field

  result := SchedulerTools.ApriEvento(params);
end;

procedure TPrenotazioniAule.CercaSlotLiberi(Aula: string; idSede: integer; DalGiorno, AlGiorno: TDate; DalleOre, AlleOre: TTime; DurataEvento: integer; Granularita: integer);
begin
  StartWait('Attendere...', True);
  try
    SlotLiberi.Active := False;
    SlotLiberi.ParamByName('PARAM_AULA').AsString := Aula;
    SlotLiberi.ParamByName('PARAM_ID_SEDE').Value := idSede;
    SlotLiberi.ParamByName('DATA_INIZIO').Value := DalGiorno;
    SlotLiberi.ParamByName('DATA_FINE').Value := AlGiorno;
    SlotLiberi.ParamByName('DALLE_ORE').Value := DalleOre;
    SlotLiberi.ParamByName('ALLE_ORE').Value := AlleOre;
    SlotLiberi.ParamByName('DURATA').Value := DurataEvento;
    SlotLiberi.ParamByName('MINUTI_INCREMENTO').Value := Granularita;
    SlotLiberi.Active := True;
  finally
    StopWait;
  end;
end;

procedure TPrenotazioniAule.InitActions(CopiaOra, CopiaGiorno, CopiaSettimana, TagliaOra, Incolla: TContainedAction);
begin
  CopiaOra.Caption := 'Copia Prenotazione';
  CopiaGiorno.Caption := 'Copia Prenotazioni Giorno';
  CopiaSettimana.Caption := 'Copia Prenotazioni Settimana';
  TagliaOra.Caption := 'Taglia Prenotazione';
  Incolla.Caption := 'Incolla Prenotazioni';
end;

procedure TPrenotazioniAule.SelezionaAule(Aule: TList<string>);
var
  i: integer;
  Aula: string;
  Resource: TcxSchedulerStorageResourceItem;
begin
  SiMain.EnterMethod(Self, 'SelezionaAule');

  AuleSelezionate.Clear;
  ElencoAule.Active := True;

  cxSchedulerDBStorage.BeginUpdate;
  try
    for i := 0 to cxSchedulerDBStorage.Resources.ResourceItems.Count - 1 do
      cxSchedulerDBStorage.Resources.ResourceItems[i].Visible := False;

    if Aule.Count = 0 then
    begin

      // viene attivata la prima
      if cxSchedulerDBStorage.Resources.ResourceItems.Count > 0 then
        cxSchedulerDBStorage.Resources.ResourceItems[0].Visible := True;
    end
    else
    begin

      for Aula in Aule do
      begin
        Resource := TcxSchedulerStorageResourcesAccess(cxSchedulerDBStorage.Resources).GetResourceItemByID(Aula);

        if Assigned(Resource) then
        begin
          Resource.Visible := True;
          AuleSelezionate.Add(Aula);
        end;
      end;
    end;
  finally
    cxSchedulerDBStorage.EndUpdate;
  end;

  AttivaCalendario; // La prima volta viene chiamata dall'OnShow della form
  RefreshScheduler;
  SiMain.LeaveMethod(Self, 'SelezionaAule');
end;

procedure TPrenotazioniAule.GeneraPrenotazioniAule(const Aula: string);
var
  params: TGenerazionePrenotazioniAuleParams;
  sp: TSP_AULE_PRENOTA_PERIODO;
begin
  params.Init;
  params.Aula := Aula;
  params.DalGiorno := GetSchedulerParams.DalGiorno;
  params.AlGiorno := GetSchedulerParams.AlGiorno;

  if GenerazionePrenotazioniAule(params) then
  begin
    sp := TSP_AULE_PRENOTA_PERIODO.Create(WriteTrans);
    try
      sp.Aula := params.Aula;
      sp.OGGETTO := params.OGGETTO;

      if params.IdProgetto <> -1 then
        sp.ID_PROGETTO := params.IdProgetto
      else
        sp.ID_PROGETTO.Clear;

      if params.IdCorso <> -1 then
        sp.ID_CORSO := params.IdCorso
      else
        sp.ID_CORSO.Clear;

      sp.DAL_GIORNO := params.DalGiorno;
      sp.AL_GIORNO := params.AlGiorno;

      sp.Svuotamento_Prenotazioni := params.SvuotaPrenotazioni;

      sp.LUNEDI := params.LUNEDI;
      sp.MARTEDI := params.MARTEDI;
      sp.MERCOLEDI := params.MERCOLEDI;
      sp.GIOVEDI := params.GIOVEDI;
      sp.VENERDI := params.VENERDI;
      sp.SABATO := params.SABATO;
      sp.DOMENICA := params.DOMENICA;

      if params.LUNEDI then
      begin
        sp.ORA_INIZIO_LUNEDI := params.OraInizio_Lunedi;
        sp.ORA_FINE_LUNEDI := params.OraFine_Lunedi;
      end;

      if params.MARTEDI then
      begin
        sp.ORA_INIZIO_MARTEDI := params.OraInizio_Martedi;
        sp.ORA_FINE_MARTEDI := params.OraFine_Martedi;
      end;

      if params.MERCOLEDI then
      begin
        sp.ORA_INIZIO_MERCOLEDI := params.OraInizio_Mercoledi;
        sp.ORA_FINE_MERCOLEDI := params.OraFine_Mercoledi;
      end;

      if params.GIOVEDI then
      begin
        sp.ORA_INIZIO_GIOVEDI := params.OraInizio_Giovedi;
        sp.ORA_FINE_GIOVEDI := params.OraFine_Giovedi;
      end;

      if params.VENERDI then
      begin
        sp.ORA_INIZIO_VENERDI := params.OraInizio_Venerdi;
        sp.ORA_FINE_VENERDI := params.OraFine_Venerdi;
      end;

      if params.SABATO then
      begin
        sp.ORA_INIZIO_SABATO := params.OraInizio_Sabato;
        sp.ORA_FINE_SABATO := params.OraFine_Sabato;
      end;

      if params.DOMENICA then
      begin
        sp.ORA_INIZIO_DOMENICA := params.OraInizio_Domenica;
        sp.ORA_FINE_DOMENICA := params.OraFine_Domenica;
      end;

      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    RefreshScheduler;
  end;
end;

end.
