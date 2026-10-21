// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-21
// ---------------------------------------------------------------------------
unit Gesty.Scheduler;

// Ponte fra il calendario di zPack (TzDbScheduler, zDbScheduler.Types) e Gesty.
//
// - registra i dieci tipi di evento di TSchedulerTipoEvento nel registro
//   TzSchedulerEvents, con gli stessi codici di SCHEDULER_TIPO_EVENTO, le
//   stesse colonne chiave, le stesse icone e didascalie del vecchio
//   Frame_Scheduler e con i gestori di TSchedulerTools (ApriEvento,
//   SpostaEvento, EliminaEvento);
// - dichiara i contratti dei moduli dati del calendario (TSchedulerParams,
//   ISchedulerStorage, ISchedulerCopyPaste), che stavano in Frame_Scheduler
//   prima della sua eliminazione, e li adatta ai contratti di zPack: la form
//   chiama
//     FrameScheduler.Init(TGestyScheduler.Storage(Orario), TGestyScheduler.CopiaIncolla(Orario))
//
// La risorsa del nuovo evento e dello spostamento finisce in Aula solo se il
// campo risorsa dello storage e' AULA, come nel vecchio frame.

interface

uses
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  Vcl.ActnList,
  cxSchedulerDBStorage,
  zDbScheduler.Types,
  Gesty.Types,
  dmScheduler.Tools;

type
  // Periodo, orario e storage del calendario di un modulo dati
  TSchedulerParams = record
    Storage: TcxSchedulerDBStorage;
    DalGiorno: TDate;
    AlGiorno: TDate;
    OraInizio: TTime;
    OraFine: TTime;
    AfterRefreshScheduler: TProc;
    procedure SetAfterRefreshScheduler(proc: TProc);
    procedure Init(aStorage: TcxSchedulerDBStorage);
  end;

  // Modulo dati che fornisce gli eventi al calendario (dmOrario, dmAgenda, dmPrenotazioniAule)
  ISchedulerStorage = interface
    procedure InitStorage;
    function GetSchedulerParams: TSchedulerParams;

    procedure SetPeriodo(DalGiorno: TDate; AlGiorno: TDate);
    procedure RefreshScheduler;
    function TipoEventiPerInserimento: TSchedulerTipoEventi;
  end;

  // Modulo dati che sa copiare e incollare ore, giorni e settimane
  ISchedulerCopyPaste = interface
    // i tipi di evento che IncollaOra sa incollare: non coincidono per forza con
    // quelli che si possono inserire (l'agenda inserisce appuntamenti e attivita'
    // fuori sede, ma incolla solo rilevamenti ore)
    function TipoEventiAmmessi: TSchedulerTipoEventi;
    procedure IncollaOra(srcId: integer; DestData: TDate; DestOra: TTime; Taglia: boolean);
    procedure IncollaGiorno(srcGiorno, destGiorno: TDateTime);
    procedure IncollaSettimana(srcGiorno, destGiorno: TDateTime);
    procedure InitActions(CopiaOra, CopiaGiorno, CopiaSettimana, TagliaOra, Incolla: TContainedAction);
  end;

  TGestyScheduler = record
  public
    // Modulo dati del calendario (ISchedulerStorage) come IzSchedulerStorage
    class function Storage(SchedulerStorage: ISchedulerStorage): IzSchedulerStorage; static;
    // Copia/incolla del modulo dati come IzSchedulerCopyPaste; nil resta nil
    class function CopiaIncolla(SchedulerCopyPaste: ISchedulerCopyPaste): IzSchedulerCopyPaste; static;
    // Insieme di tipi dell'applicazione come elenco di codici, nell'ordine dell'enumerato
    class function Kinds(const TipoEventi: TSchedulerTipoEventi): TzSchedulerKinds; static;
    // Parametri del componente come TEventoParams di TSchedulerTools
    class function EventoParams(const Params: TzSchedulerEventParams): TEventoParams; static;
    // Registrazione dei tipi; chiamata dalla initialization, ripetibile
    class procedure RegisterKinds; static;
  end;

implementation

uses
  cxScheduler,
  zDX;

type
  TGestySchedulerStorage = class(TInterfacedObject, IzSchedulerStorage)
  private
    FStorage: ISchedulerStorage;
  public
    constructor Create(SchedulerStorage: ISchedulerStorage);
    procedure InitStorage;
    function GetSchedulerParams: TzSchedulerParams;
    procedure SetPeriodo(DalGiorno: TDate; AlGiorno: TDate);
    procedure RefreshScheduler;
    function TipoEventiPerInserimento: TzSchedulerKinds;
  end;

  TGestySchedulerCopyPaste = class(TInterfacedObject, IzSchedulerCopyPaste)
  private
    FCopyPaste: ISchedulerCopyPaste;
  public
    constructor Create(SchedulerCopyPaste: ISchedulerCopyPaste);
    function TipoEventiPerInserimento: TzSchedulerKinds;
    procedure IncollaOra(IdOrigine: Integer; DataDestinazione: TDate; OraDestinazione: TTime; Taglia: Boolean);
    procedure IncollaGiorno(GiornoOrigine, GiornoDestinazione: TDateTime);
    procedure IncollaSettimana(GiornoOrigine, GiornoDestinazione: TDateTime);
    procedure InitActions(CopiaOra, CopiaGiorno, CopiaSettimana, TagliaOra, Incolla: TContainedAction);
  end;

{ TSchedulerParams }

procedure TSchedulerParams.Init(aStorage: TcxSchedulerDBStorage);
begin
  Storage := aStorage;
  DalGiorno := 0;
  AlGiorno := 0;
  OraInizio := 0;
  OraFine := 0;
  AfterRefreshScheduler := nil;
end;

procedure TSchedulerParams.SetAfterRefreshScheduler(proc: TProc);
begin
  AfterRefreshScheduler := proc;
end;

{ TGestySchedulerStorage }

constructor TGestySchedulerStorage.Create(SchedulerStorage: ISchedulerStorage);
begin
  inherited Create;
  FStorage := SchedulerStorage;
end;

procedure TGestySchedulerStorage.InitStorage;
begin
  FStorage.InitStorage;
end;

function TGestySchedulerStorage.GetSchedulerParams: TzSchedulerParams;
var
  Params: TSchedulerParams;
begin
  Params := FStorage.GetSchedulerParams;

  result.Init(Params.Storage);
  result.DalGiorno := Params.DalGiorno;
  result.AlGiorno := Params.AlGiorno;
  result.OraInizio := Params.OraInizio;
  result.OraFine := Params.OraFine;
  result.AfterRefreshScheduler := Params.AfterRefreshScheduler;
end;

procedure TGestySchedulerStorage.SetPeriodo(DalGiorno: TDate; AlGiorno: TDate);
begin
  FStorage.SetPeriodo(DalGiorno, AlGiorno);
end;

procedure TGestySchedulerStorage.RefreshScheduler;
begin
  FStorage.RefreshScheduler;
end;

function TGestySchedulerStorage.TipoEventiPerInserimento: TzSchedulerKinds;
begin
  result := TGestyScheduler.Kinds(FStorage.TipoEventiPerInserimento);
end;

{ TGestySchedulerCopyPaste }

constructor TGestySchedulerCopyPaste.Create(SchedulerCopyPaste: ISchedulerCopyPaste);
begin
  inherited Create;
  FCopyPaste := SchedulerCopyPaste;
end;

function TGestySchedulerCopyPaste.TipoEventiPerInserimento: TzSchedulerKinds;
begin
  // Il calendario di zPack abilita Copia e Taglia sui tipi restituiti qui, e
  // Incolla passa l'id dell'evento a IncollaOra del modulo dati. Con i tipi
  // inseribili l'agenda abilitava Copia e Taglia anche su appuntamenti e
  // attivita' fuori sede, e AGENDA_RILEVAMENTI_INCOLLA_ORA copiava (e con
  // Taglia cancellava) il rilevamento ore con lo stesso numero, di chiunque fosse:
  // le chiavi delle due tabelle hanno contatori distinti e si sovrappongono
  result := TGestyScheduler.Kinds(FCopyPaste.TipoEventiAmmessi);
end;

procedure TGestySchedulerCopyPaste.IncollaOra(IdOrigine: Integer; DataDestinazione: TDate; OraDestinazione: TTime; Taglia: Boolean);
begin
  FCopyPaste.IncollaOra(IdOrigine, DataDestinazione, OraDestinazione, Taglia);
end;

procedure TGestySchedulerCopyPaste.IncollaGiorno(GiornoOrigine, GiornoDestinazione: TDateTime);
begin
  FCopyPaste.IncollaGiorno(GiornoOrigine, GiornoDestinazione);
end;

procedure TGestySchedulerCopyPaste.IncollaSettimana(GiornoOrigine, GiornoDestinazione: TDateTime);
begin
  FCopyPaste.IncollaSettimana(GiornoOrigine, GiornoDestinazione);
end;

procedure TGestySchedulerCopyPaste.InitActions(CopiaOra, CopiaGiorno, CopiaSettimana, TagliaOra, Incolla: TContainedAction);
begin
  FCopyPaste.InitActions(CopiaOra, CopiaGiorno, CopiaSettimana, TagliaOra, Incolla);
end;

{ TGestyScheduler }

class function TGestyScheduler.Storage(SchedulerStorage: ISchedulerStorage): IzSchedulerStorage;
begin
  result := nil;

  if Assigned(SchedulerStorage) then
    result := TGestySchedulerStorage.Create(SchedulerStorage);
end;

class function TGestyScheduler.CopiaIncolla(SchedulerCopyPaste: ISchedulerCopyPaste): IzSchedulerCopyPaste;
begin
  result := nil;

  if Assigned(SchedulerCopyPaste) then
    result := TGestySchedulerCopyPaste.Create(SchedulerCopyPaste);
end;

class function TGestyScheduler.Kinds(const TipoEventi: TSchedulerTipoEventi): TzSchedulerKinds;
var
  TipoEvento: TSchedulerTipoEvento;
begin
  result := nil;

  for TipoEvento := Low(TSchedulerTipoEvento) to High(TSchedulerTipoEvento) do
    if (TipoEvento <> teNull) and (TipoEvento in TipoEventi) then
      result := result + [TipoEvento.ToString];
end;

class function TGestyScheduler.EventoParams(const Params: TzSchedulerEventParams): TEventoParams;
begin
  result.Init;
  result.TipoEvento := TSchedulerTipoEvento.FromString(Params.Kind);
  result.ReadOnly := Params.ReadOnly;
  result.id := Params.Id;
  result.Data := Params.Data;
  result.OraInizio := Params.OraInizio;

  // come il vecchio Frame_Scheduler: la durata si imposta dopo l'ora di inizio e calcola
  // l'ora di fine; senza durata (modifica, eliminazione) non si tocca
  if Params.Durata <> 0 then
    result.Durata := Params.Durata;

  result.ResourceID := Params.ResourceID;

  if SameText(Params.ResourceFieldName, 'AULA') and not VarIsNull(Params.ResourceID) then
    result.Aula := VarToStr(Params.ResourceID);

  result.FieldName1 := Params.FieldName1;
  result.Value1 := Params.Value1;
  result.FieldName2 := Params.FieldName2;
  result.Value2 := Params.Value2;
  result.FieldName3 := Params.FieldName3;
  result.Value3 := Params.Value3;
  result.FieldName4 := Params.FieldName4;
  result.Value4 := Params.Value4;
  result.FieldName5 := Params.FieldName5;
  result.Value5 := Params.Value5;
end;

class procedure TGestyScheduler.RegisterKinds;
const
  // indici nelle icone degli eventi del componente (imagesScheduler), come
  // SchedulerInitEventImages del vecchio Frame_Scheduler
  EventImage: array [TSchedulerTipoEvento] of Integer = (-1, 0, 1, 2, 3, 4, 6, 5, 7, 8, -1);
var
  TipoEvento: TSchedulerTipoEvento;
  Kind: TzSchedulerEventKind;
begin
  for TipoEvento := Succ(teNull) to High(TSchedulerTipoEvento) do
  begin
    Kind := TzSchedulerEvents.Register(TipoEvento.ToString, TipoEvento.Description, TipoEvento.IdFieldName);
    Kind.EventImageIndex := EventImage[TipoEvento];
    Kind.DefaultDuration := 60;
    // CanIntersect: ammesso se almeno uno dei due tipi lo ammette
    Kind.IntersectionAllowed := TipoEvento.CanIntersect(teNull);

    Kind.Apri :=
      function(const Params: TzSchedulerEventParams): Boolean
      begin
        result := Assigned(SchedulerTools) and SchedulerTools.ApriEvento(TGestyScheduler.EventoParams(Params));
      end;

    Kind.Sposta :=
      function(const Params: TzSchedulerEventParams): Boolean
      begin
        result := Assigned(SchedulerTools) and SchedulerTools.SpostaEvento(TGestyScheduler.EventoParams(Params));
      end;

    Kind.Elimina :=
      function(const Params: TzSchedulerEventParams): Boolean
      begin
        result := Assigned(SchedulerTools) and SchedulerTools.EliminaEvento(TGestyScheduler.EventoParams(Params));
      end;
  end;

  // didascalie e icone delle azioni di inserimento del vecchio Frame_Scheduler; gli
  // indici sono quelli della ImageList del componente
  Kind := TzSchedulerEvents.Find(teOrarioLezione.ToString);
  Kind.NewCaption := 'Nuova Lezione';
  Kind.NewImageIndex := dx.IndiceIcona('bs_calendario__actions_add');

  Kind := TzSchedulerEvents.Find(teOreRilevamento.ToString);
  Kind.NewCaption := 'Nuovo Rilevamento';
  Kind.NewImageIndex := dx.IndiceIcona('timelineview__actions_add');

  Kind := TzSchedulerEvents.Find(teAgendaPersonale.ToString);
  Kind.NewCaption := 'Nuovo Evento';
  Kind.NewImageIndex := dx.IndiceIcona('bs_eventi__actions_add');

  Kind := TzSchedulerEvents.Find(tePrenotazioneAule.ToString);
  Kind.NewCaption := 'Nuova Prenotazione Aula';
  Kind.NewImageIndex := dx.IndiceIcona('opencalendar__actions_add');

  Kind := TzSchedulerEvents.Find(teAttivitaFuoriSede.ToString);
  Kind.NewCaption := 'Nuova Attivit' + #224 + ' Fuori Sede';
  Kind.NewImageIndex := dx.IndiceIcona('car__actions_add');

  // esportazione di Gesty: Excel o CSV per Google Calendar e Outlook
  TzSchedulerEvents.ExportProc :=
    procedure(Scheduler: TObject)
    begin
      if Assigned(SchedulerTools) and (Scheduler is TcxScheduler) then
        SchedulerTools.ExportEvents(TcxScheduler(Scheduler));
    end;
end;

initialization

TGestyScheduler.RegisterKinds;

end.
