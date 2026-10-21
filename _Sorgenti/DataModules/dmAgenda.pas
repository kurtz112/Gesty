unit dmAgenda;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
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
  Gesty.Types,
  Gesty.Scheduler,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

type
  TAgenda = class(TBaseDataModule, ISchedulerStorage, ISchedulerCopyPaste)
    SetColorsSrc: TDataSource;
    cxSchedulerDBStorage: TcxSchedulerDBStorage;
    Calendario: TzFbDataSet;
    CalendarioSrc: TDataSource;
  public
  private
    FMostraAgendaPersonale: boolean;
    FMostraAssenze: boolean;
    FMostraChiusureSedi: boolean;
    FMostraFuoriSede: boolean;
    FMostraInagibilitaAule: boolean;
    FMostraLezioni: boolean;
    FMostraPrenotazioniAule: boolean;
    FMostraPresenzePersonale: boolean;
    FMostraRilevamenti: boolean;
    FMostraRiunioni: boolean;
    FMostraScadenze: boolean;
    SchedulerParams: TSchedulerParams;
    function IdRisorsa: integer;
    procedure SetMostraAgendaPersonale(const Value: boolean);
    procedure SetMostraAssenze(const Value: boolean);
    procedure SetMostraChiusureSedi(const Value: boolean);
    procedure SetMostraInagibilitaAule(const Value: boolean);
    procedure SetMostraLezioni(const Value: boolean);
    procedure SetMostraPrenotazioniAule(const Value: boolean);
    procedure SetMostraPresenzePersonale(const Value: boolean);
    procedure SetMostraRilevamenti(const Value: boolean);
    procedure SetMostraRiunioni(const Value: boolean);
    procedure SetMostraScadenze(const Value: boolean);
  private
    function getConfig(const name: string): boolean;
    procedure setConfig(const name: string; const Value: boolean);
    procedure SetMostraFuoriSede(const Value: boolean);
  public
    constructor Create(aOwner: TComponent); override;
    procedure InitStorage;
    function GetSchedulerParams: TSchedulerParams;

    procedure SetPeriodo(DalGiorno: TDate; AlGiorno: TDate);
    procedure RefreshScheduler;
    function TipoEventiPerInserimento: TSchedulerTipoEventi;
  public // prenotazione di un'aula dall'agenda (TFormPrenotaAulaDaAgenda)
    function AuleLibere: TzFbDataSet;
    function SlotLiberiAula: TzFbDataSet;
    function ElencoAule: TzFbDataSet;
    // Modo A: aule libere nell'orario, tenendo conto anche degli impegni della persona
    procedure CercaAuleLibere(Data: TDate; DalleOre, AlleOre: TTime);
    // Modo B: orari in cui sono liberi l'aula e la persona
    procedure CercaSlotLiberiAula(const Aula: string; DalGiorno, AlGiorno: TDate; DalleOre, AlleOre: TTime; Durata, Passo: integer; IncludiFineSettimana: boolean);
    // La persona dell'agenda non ha impegni nella fascia (PERSONALE_LIBERO)
    function PersonaLibera(Data: TDate; DalleOre, AlleOre: TTime): boolean;
    // Apre la scheda della prenotazione con data, ore e aula della riga corrente.
    // Vero se la prenotazione e' stata salvata; PrenotazioniAccese e' vero se
    // per mostrarla e' stato acceso "Mostra prenotazioni aule"
    function PrenotaDaRicerca(Risultati: TzFbDataSet; out PrenotazioniAccese: boolean): boolean;
  public // ISchedulerCopyPaste
    function TipoEventiAmmessi: TSchedulerTipoEventi;
    procedure IncollaOra(srcId: integer; DestData: TDate; DestOra: TTime; Taglia: boolean);
    procedure IncollaGiorno(srcGiorno, destGiorno: TDateTime);
    procedure IncollaSettimana(srcGiorno, destGiorno: TDateTime);
    procedure InitActions(CopiaOra, CopiaGiorno, CopiaSettimana, TagliaOra, Incolla: TContainedAction);
  public
    property MostraLezioni: boolean read FMostraLezioni write SetMostraLezioni;
    property MostraRilevamenti: boolean read FMostraRilevamenti write SetMostraRilevamenti;
    property MostraRiunioni: boolean read FMostraRiunioni write SetMostraRiunioni;
    property MostraAgendaPersonale: boolean read FMostraAgendaPersonale write SetMostraAgendaPersonale;
    property MostraPrenotazioniAule: boolean read FMostraPrenotazioniAule write SetMostraPrenotazioniAule;
    property MostraInagibilitaAule: boolean read FMostraInagibilitaAule write SetMostraInagibilitaAule;
    property MostraChiusureSedi: boolean read FMostraChiusureSedi write SetMostraChiusureSedi;
    property MostraPresenzePersonale: boolean read FMostraPresenzePersonale write SetMostraPresenzePersonale;
    property MostraAssenze: boolean read FMostraAssenze write SetMostraAssenze;
    property MostraScadenze: boolean read FMostraScadenze write SetMostraScadenze;
    property MostraFuoriSede: boolean read FMostraFuoriSede write SetMostraFuoriSede;
  end;

var
  Agenda: TAgenda;

implementation

uses
  System.Threading,
  System.DateUtils,
  Gesty_StoredProcs,
  zOffice.Reports,

  dmScheduler.Tools,
  ConfigModule,
  zBaseLib;

{$R *.dfm}

constructor TAgenda.Create(aOwner: TComponent);
begin
  inherited;

  SchedulerParams.Init(cxSchedulerDBStorage);
  SchedulerParams.DalGiorno := StartOfTheWeek(Date);
  SchedulerParams.AlGiorno := EndOfTheWeek(Date);
  SchedulerParams.OraInizio := EncodeTime(7, 0, 0, 0);
  SchedulerParams.OraFine := EncodeTime(20, 0, 0, 0);

  InitStorage;

  /// ///////
  FMostraLezioni := getConfig('MostraLezioni');
  FMostraRilevamenti := getConfig('MostraRilevamenti');
  FMostraRiunioni := getConfig('MostraRiunioni');
  FMostraAgendaPersonale := getConfig('MostraAgendaPersonale');
  FMostraPrenotazioniAule := getConfig('MostraPrenotazioniAule');
  FMostraInagibilitaAule := getConfig('MostraInagibilitaAule');
  FMostraChiusureSedi := getConfig('MostraChiusureSedi');
  FMostraPresenzePersonale := getConfig('MostraPresenzePersonale');
  FMostraScadenze := getConfig('MostraScadenze');
  FMostraAssenze := getConfig('MostraAssenze');
  FMostraFuoriSede := getConfig('MostraAttivitaFuoriSede');
end;

function TAgenda.GetSchedulerParams: TSchedulerParams;
begin
  result := SchedulerParams;
end;

function TAgenda.IdRisorsa: integer;
var
  Master: TzFbDataSet;
begin
  Master := getDataSet('SchedaPersonale');
  Master.Active := true;
  result := Master.FieldByName('ID_PERSONALE').AsInteger;
end;

procedure TAgenda.InitStorage;
begin
  OpenDataSets;

  cxSchedulerDBStorage.Resources.DataSource := nil; //
  cxSchedulerDBStorage.DataSource := CalendarioSrc;
  SchedulerTools.InitStorage(cxSchedulerDBStorage);
end;

procedure TAgenda.SetPeriodo(DalGiorno: TDate; AlGiorno: TDate);
begin
  SchedulerParams.DalGiorno := DalGiorno;
  SchedulerParams.AlGiorno := AlGiorno;

  RefreshScheduler;
end;

procedure TAgenda.RefreshScheduler;
begin
  Calendario.Active := False;
  Calendario.ParamByName('PARAM_ID_RISORSA').AsInteger := IdRisorsa;
  Calendario.ParamByName('DAL_GIORNO').asDate := SchedulerParams.DalGiorno;
  Calendario.ParamByName('AL_GIORNO').asDate := SchedulerParams.AlGiorno;
  Calendario.ParamByName('MOSTRA_LEZIONI').asBoolean := MostraLezioni;
  Calendario.ParamByName('MOSTRA_ORE_RILEVAMENTI').asBoolean := MostraRilevamenti;
  Calendario.ParamByName('MOSTRA_RIUNIONI').asBoolean := MostraRiunioni;
  Calendario.ParamByName('MOSTRA_AGENDA_PERSONALE').asBoolean := MostraAgendaPersonale;
  Calendario.ParamByName('MOSTRA_PRENOTAZIONI_AULE').asBoolean := MostraPrenotazioniAule;
  Calendario.ParamByName('MOSTRA_INAGIBILITA_AULE').asBoolean := MostraInagibilitaAule;
  Calendario.ParamByName('MOSTRA_CHIUSURE_SEDI').asBoolean := MostraChiusureSedi;
  Calendario.ParamByName('MOSTRA_PRESENZE_PERSONALE').asBoolean := MostraPresenzePersonale;
  Calendario.ParamByName('MOSTRA_ASSENZE').asBoolean := MostraAssenze;
  Calendario.ParamByName('MOSTRA_SCADENZE').asBoolean := MostraScadenze;
  Calendario.ParamByName('MOSTRA_ATTIVITA_FUORI_SEDE').asBoolean := MostraFuoriSede;
  Calendario.Active := true;

  if Assigned(SchedulerParams.AfterRefreshScheduler) then
    SchedulerParams.AfterRefreshScheduler();
end;

function TAgenda.TipoEventiPerInserimento: TSchedulerTipoEventi;
begin
  // la prenotazione d'aula e' inseribile ma non incollabile (TipoEventiAmmessi):
  // Copia e Taglia guardano TipoEventiAmmessi dal rilascio 001
  result := [teAgendaPersonale, teOreRilevamento, teAttivitaFuoriSede, tePrenotazioneAule];
end;

function TAgenda.AuleLibere: TzFbDataSet;
begin
  result := GetDataSet('AuleLibere');
end;

function TAgenda.SlotLiberiAula: TzFbDataSet;
begin
  result := GetDataSet('SlotLiberiAula');
end;

function TAgenda.ElencoAule: TzFbDataSet;
begin
  result := GetDataSet('lkAule');
end;

procedure TAgenda.CercaAuleLibere(Data: TDate; DalleOre, AlleOre: TTime);
var
  Risultati: TzFbDataSet;
  Durata: integer;
begin
  // un solo orario: durata e passo coincidono con la fascia scelta
  Durata := Round((AlleOre - DalleOre) * MinsPerDay);

  Risultati := AuleLibere;
  StartWait('Attendere...', True);
  try
    Risultati.Active := False;
    Risultati.ParamByName('PARAM_AULA').AsString := '';
    Risultati.ParamByName('PARAM_ID_SEDE').Value := -1;
    Risultati.ParamByName('DATA_INIZIO').AsDate := Data;
    Risultati.ParamByName('DATA_FINE').AsDate := Data;
    Risultati.ParamByName('DALLE_ORE').AsTime := DalleOre;
    Risultati.ParamByName('ALLE_ORE').AsTime := AlleOre;
    Risultati.ParamByName('DURATA').Value := Durata;
    Risultati.ParamByName('MINUTI_INCREMENTO').Value := Durata;
    Risultati.ParamByName('PARAM_ID_RISORSA').Value := IdRisorsa;
    // il giorno l'ha scelto l'utente: anche sabato e domenica
    Risultati.ParamByName('INCLUDI_FINE_SETTIMANA').AsBoolean := true;
    Risultati.Active := true;
  finally
    StopWait;
  end;
end;

procedure TAgenda.CercaSlotLiberiAula(const Aula: string; DalGiorno, AlGiorno: TDate; DalleOre, AlleOre: TTime; Durata, Passo: integer; IncludiFineSettimana: boolean);
var
  Risultati: TzFbDataSet;
begin
  Risultati := SlotLiberiAula;
  StartWait('Attendere...', True);
  try
    Risultati.Active := False;
    Risultati.ParamByName('PARAM_AULA').AsString := Aula;
    Risultati.ParamByName('PARAM_ID_SEDE').Value := -1;
    Risultati.ParamByName('DATA_INIZIO').AsDate := DalGiorno;
    Risultati.ParamByName('DATA_FINE').AsDate := AlGiorno;
    Risultati.ParamByName('DALLE_ORE').AsTime := DalleOre;
    Risultati.ParamByName('ALLE_ORE').AsTime := AlleOre;
    Risultati.ParamByName('DURATA').Value := Durata;
    Risultati.ParamByName('MINUTI_INCREMENTO').Value := Passo;
    Risultati.ParamByName('PARAM_ID_RISORSA').Value := IdRisorsa;
    Risultati.ParamByName('INCLUDI_FINE_SETTIMANA').AsBoolean := IncludiFineSettimana;
    Risultati.Active := true;
  finally
    StopWait;
  end;
end;

function TAgenda.PersonaLibera(Data: TDate; DalleOre, AlleOre: TTime): boolean;
var
  Esito: Variant;
begin
  Esito := Config.Database.ExecSQLScalar('SELECT PERSONALE_LIBERO(CAST(:ID_RISORSA AS BIGINT), CAST(:DATA AS DATE), CAST(:DALLE_ORE AS TIME), CAST(:ALLE_ORE AS TIME)) FROM RDB$DATABASE',
    [IdRisorsa, DateOf(Data), TimeOf(DalleOre), TimeOf(AlleOre)]);

  result := VarIsNull(Esito) or (Esito = true);
end;

function TAgenda.PrenotaDaRicerca(Risultati: TzFbDataSet; out PrenotazioniAccese: boolean): boolean;
var
  Params: TEventoParams;
begin
  result := False;
  PrenotazioniAccese := False;

  if not Risultati.Active or Risultati.IsEmpty then
    exit;

  Params.Init;
  Params.TipoEvento := tePrenotazioneAule;
  Params.id := -1;
  Params.Data := DateOf(Risultati.FieldByName('DATA').AsDateTime);
  Params.OraInizio := TimeOf(Risultati.FieldByName('ORA_INIZIO').AsDateTime);
  Params.OraFine := TimeOf(Risultati.FieldByName('ORA_FINE').AsDateTime);
  Params.Aula := Risultati.FieldByName('AULA').AsString;

  result := SchedulerTools.ApriEvento(Params);

  if result then
  begin
    // senza "Mostra prenotazioni aule" la prenotazione appena fatta non
    // comparirebbe nell'agenda: si accende, e il cambio rilegge il calendario
    if not MostraPrenotazioniAule then
    begin
      MostraPrenotazioniAule := true;
      PrenotazioniAccese := true;
    end
    else
      RefreshScheduler;
  end;
end;

function TAgenda.TipoEventiAmmessi: TSchedulerTipoEventi;
begin
  result := [teOreRilevamento];
end;

procedure TAgenda.IncollaOra(srcId: integer; DestData: TDate; DestOra: TTime; Taglia: boolean);
var
  sp: TSP_AGENDA_RILEVAMENTI_INCOLLA_ORA;
begin
  sp := TSP_AGENDA_RILEVAMENTI_INCOLLA_ORA.Create(WriteTrans);
  try
    sp.ID_RILEVAMENTO_ORE := srcId;
    sp.Dest_Data := DestData;
    sp.Dest_Ora := DestOra;
    sp.Taglia := Taglia;
    sp.ExecuteAndCommit;
  finally
    freeAndNil(sp);
  end;

  RefreshScheduler;
end;

procedure TAgenda.IncollaGiorno(srcGiorno, destGiorno: TDateTime);
var
  sp: TSP_AGENDA_RILEVAMENTI_INCOLLA_GIOR;
begin
  sp := TSP_AGENDA_RILEVAMENTI_INCOLLA_GIOR.Create(WriteTrans);
  try
    sp.Src_Data := srcGiorno;
    sp.Dest_Data := destGiorno;
    sp.ExecuteAndCommit;
  finally
    freeAndNil(sp);
  end;

  RefreshScheduler;
end;

procedure TAgenda.IncollaSettimana(srcGiorno, destGiorno: TDateTime);
var
  sp: TSP_AGENDA_RILEVAMENTI_INCOLLA_SETT;
begin
  sp := TSP_AGENDA_RILEVAMENTI_INCOLLA_SETT.Create(WriteTrans);
  try
    sp.Src_Data := srcGiorno;
    sp.Dest_Data := destGiorno;
    sp.ExecuteAndCommit;
  finally
    freeAndNil(sp);
  end;

  RefreshScheduler;
end;

procedure TAgenda.InitActions(CopiaOra, CopiaGiorno, CopiaSettimana, TagliaOra, Incolla: TContainedAction);
begin
  CopiaOra.Caption := 'Copia Rilevamento';
  CopiaGiorno.Caption := 'Copia Rilevamenti Giorno';
  CopiaSettimana.Caption := 'Copia Rilevamenti Settimana';
  TagliaOra.Caption := 'Taglia Rilevamento';
  Incolla.Caption := 'Incolla Rilevamenti';
end;

procedure TAgenda.SetMostraLezioni(const Value: boolean);
begin
  FMostraLezioni := Value;
  RefreshScheduler;
  setConfig('MostraLezioni', MostraLezioni);
end;

procedure TAgenda.SetMostraRilevamenti(const Value: boolean);
begin
  FMostraRilevamenti := Value;
  RefreshScheduler;
  setConfig('MostraRilevamenti', MostraRilevamenti);
end;

procedure TAgenda.SetMostraRiunioni(const Value: boolean);
begin
  FMostraRiunioni := Value;
  RefreshScheduler;
  setConfig('MostraRiunioni', MostraRiunioni);
end;

procedure TAgenda.SetMostraAgendaPersonale(const Value: boolean);
begin
  FMostraAgendaPersonale := Value;
  RefreshScheduler;
  setConfig('MostraAgendaPersonale', MostraAgendaPersonale);
end;

procedure TAgenda.SetMostraPrenotazioniAule(const Value: boolean);
begin
  FMostraPrenotazioniAule := Value;
  RefreshScheduler;
  setConfig('MostraPrenotazioniAule', MostraPrenotazioniAule);
end;

procedure TAgenda.SetMostraInagibilitaAule(const Value: boolean);
begin
  FMostraInagibilitaAule := Value;
  RefreshScheduler;
  setConfig('MostraInagibilitaAule', MostraInagibilitaAule);
end;

procedure TAgenda.SetMostraChiusureSedi(const Value: boolean);
begin
  FMostraChiusureSedi := Value;
  RefreshScheduler;
  setConfig('MostraChiusureSedi', MostraChiusureSedi);
end;

procedure TAgenda.SetMostraPresenzePersonale(const Value: boolean);
begin
  FMostraPresenzePersonale := Value;
  RefreshScheduler;
  setConfig('MostraPresenzePersonale', MostraPresenzePersonale);
end;

procedure TAgenda.SetMostraScadenze(const Value: boolean);
begin
  FMostraScadenze := Value;
  RefreshScheduler;
  setConfig('MostraScadenze', MostraScadenze);
end;

procedure TAgenda.SetMostraAssenze(const Value: boolean);
begin
  FMostraAssenze := Value;
  RefreshScheduler;
  setConfig('MostraAssenze', MostraAssenze);
end;

function TAgenda.getConfig(const name: string): boolean;
var
  s: string;
begin
  s := config.zSystem.Setting(name, 'True');
  result := SameText(s, 'True');
end;

procedure TAgenda.setConfig(const name: string; const Value: boolean);
begin
  if Value then
    config.zSystem.Settings[name] := 'True'
  else
    config.zSystem.Settings[name] := 'False';
end;

procedure TAgenda.SetMostraFuoriSede(const Value: boolean);
begin
  FMostraFuoriSede := Value;
  RefreshScheduler;
  setConfig('MostraAttivitaFuoriSede', MostraFuoriSede);
end;

end.
