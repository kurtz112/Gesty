unit CalendarioAule.classes;

interface

uses
  System.SysUtils,
  System.classes,
  System.Generics.Collections,
  System.UITypes,
  Vcl.ExtCtrls,
  Data.DB,
  cxTL,
  cxSchedulerStorage,
  zFbDataSet,
  zz.GenericCollection,
  Gesty.Types;

type
  TOra = class(TCollectionItem)
  private
    FOraInizio: TTime;
    FOraFine: TTime;
    FColonnaSuperiore: TcxTreeListColumn;
    FColonnaInferiore: TcxTreeListColumn;
    function GetColumnCaption: string;
  public
    constructor Create(Collection: TCollection); override;

    property OraInizio: TTime read FOraInizio write FOraInizio;
    property OraFine: TTime read FOraFine write FOraFine;
    property ColonnaSuperiore: TcxTreeListColumn read FColonnaSuperiore write FColonnaSuperiore;
    property ColonnaInferiore: TcxTreeListColumn read FColonnaInferiore write FColonnaInferiore;
    property ColumnCaption: string read GetColumnCaption;
  end;

  TOre = class(TzGenericCollection<TOra>)
  protected
    function Compare(Item1, Item2: TOra): integer; override;
  public
    function AddOra(const OraInizio, OraFine: TTime): TOra;
    function GetOra(const OraInizio: TTime): TOra;
  end;

  /// /////////////////////////

  TGiorno = class(TCollectionItem)
  private
    FDataLezione: TDate;
    FOre: TOre;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    property DataLezione: TDate read FDataLezione write FDataLezione;
    property Ore: TOre read FOre;
  end;

  TGiorni = class(TzGenericCollection<TGiorno>)
  protected
    function Compare(Item1, Item2: TGiorno): integer; override;
  public
    function AddGiorno(const DataLezione: TDate): TGiorno;
    function GetGiorno(const DataLezione: TDate): TGiorno;
  end;

  /// /////////////////////////

  TEvento = class(TCollectionItem)
  private
    FAula: string;
    FColonnaInferiore: TcxTreeListColumn;
    FColonnaSuperiore: TcxTreeListColumn;
    FColore: integer;
    FDataCalendario: TDate;
    FDescAula: string;
    FIdGiornoChiusura: integer;
    FIdInagibilitaAula: integer;
    FIdRisorsa: integer;
    FIdOrario: integer;
    FIdPrenotazioneAula: integer;
    FIdRiunione: integer;
    FModificabile: boolean;
    FNominativo: string;
    FOraInizio: TTime;
    FOraFine: TTime;
    FTipoEvento: TSchedulerTipoEvento;
    FTitolo: string;
    function GetIdEvento: integer;
  public
    constructor Create(Collection: TCollection); override;

    property IdEvento: integer read GetIdEvento;
    property TipoEvento: TSchedulerTipoEvento read FTipoEvento;
    property Modificabile: boolean read FModificabile;
    property Titolo: string read FTitolo;
    property Colore: integer read FColore;

    property DataCalendario: TDate read FDataCalendario;
    property OraInizio: TTime read FOraInizio;
    property OraFine: TTime read FOraFine;
    property IdRisorsa: integer read FIdRisorsa;
    property Nominativo: string read FNominativo;

    property Aula: string read FAula;
    property DescAula: string read FDescAula;
  public
    property IdOrario: integer read FIdOrario;
    property IdRiunione: integer read FIdRiunione;
    property IdPrenotazioneAula: integer read FIdPrenotazioneAula;
    property IdInagibilitaAula: integer read FIdInagibilitaAula;
    property IdGiornoChiusura: integer read FIdGiornoChiusura;
  public
    property ColonnaSuperiore: TcxTreeListColumn read FColonnaSuperiore write FColonnaSuperiore;
    property ColonnaInferiore: TcxTreeListColumn read FColonnaInferiore write FColonnaInferiore;
  end;

  TEventi = class(TzGenericCollection<TEvento>)
  public
  end;

  TAula = class(TCollectionItem)
  private
    FAula: string;
    FDescAula: string;
    FOccupazioni: TEventi;
    FNode: TcxTreeListNode;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    property Aula: string read FAula write FAula;
    property DescAula: string read FDescAula write FDescAula;
    property Node: TcxTreeListNode read FNode write FNode;

    property Eventi: TEventi read FOccupazioni;
  end;

  TAule = class(TzGenericCollection<TAula>)
  protected
    function Compare(Item1, Item2: TAula): integer; override;
  public
    function AddAula(const Aula, DescAula: string): TAula;
    function GetAula(const Aula: string): TAula; overload;
    function GetAula(Node: TcxTreeListNode): TAula; overload;
  end;

  /// /////////////////////////
  /// Calendario

  TCalendarioLezioniAule = class
  private
    FElencoAule: TAule;
    FElencoGiorni: TGiorni;
  private
    procedure Clear;
    procedure Sort;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Load(DataSet: TDataSet);
    procedure LoadScheduler(cxSchedulerStorage: TcxSchedulerStorage);

    function GetAulaIndex(const Aula: string): integer;
    function GetColumns(DataLezione: TDate; OraInizio: TTime; out ColonnaSuperiore, ColonnaInferiore: TcxTreeListColumn): boolean;
    function GetColumnName(DataLezione: TDate; OraInizio: TTime): string;

    function GetEvento(Node: TcxTreeListNode; Column: TcxTreeListColumn; out Evento: TEvento): boolean;
  public
    property ElencoGiorni: TGiorni read FElencoGiorni;
    property ElencoAule: TAule read FElencoAule;
  end;

implementation

uses
  System.DateUtils,
  zBaseLib;

{ TAula }

constructor TAula.Create(Collection: TCollection);
begin
  inherited;
  FAula := '';
  FDescAula := '';
  FNode := nil;
  FOccupazioni := TEventi.Create(TEvento);
end;

destructor TAula.Destroy;
begin
  FreeAndNil(FOccupazioni);
  inherited;
end;

{ TOra }

constructor TOra.Create(Collection: TCollection);
begin
  inherited;
  FOraInizio := OraZero;
  FColonnaSuperiore := nil;
  FColonnaInferiore := nil;
end;

function TOra.GetColumnCaption: string;
begin
  Result := FormatDateTime('HH:MM', OraInizio) + ' - ' + FormatDateTime('HH:MM', OraFine);
end;

{ TGiorno }

constructor TGiorno.Create(Collection: TCollection);
begin
  inherited;
  FDataLezione := DataZero;
  FOre := TOre.Create(TOra);
end;

destructor TGiorno.Destroy;
begin
  FreeAndNil(FOre);
  inherited;
end;

{ TAule }

function TAule.Compare(Item1, Item2: TAula): integer;
begin
  Result := CompareText(Item1.Aula, Item2.Aula);
end;

function TAule.GetAula(const Aula: string): TAula;
var
  item: TAula;
begin
  Result := nil;

  for item in self do
    if item.Aula = Aula then
    begin
      Result := item;
      Exit;
    end;
end;

function TAule.GetAula(Node: TcxTreeListNode): TAula;
var
  item: TAula;
begin
  Result := nil;

  for item in self do
    if item.Node = Node then
    begin
      Result := item;
      Exit;
    end;
end;

function TAule.AddAula(const Aula, DescAula: string): TAula;
var
  idx: integer;
begin
  Result := GetAula(Aula);

  if not assigned(Result) then
  begin
    Result := Add;
    Result.Aula := Aula;
    Result.DescAula := DescAula;
  end;
end;

{ TOre }

function TOre.Compare(Item1, Item2: TOra): integer;
begin
  Result := CompareTime(Item1.OraInizio, Item2.OraInizio);
end;

function TOre.GetOra(const OraInizio: TTime): TOra;
var
  item: TOra;
begin
  Result := nil;

  for item in self do
    if item.OraInizio = OraInizio then
    begin
      Result := item;
      Exit;
    end;
end;

function TOre.AddOra(const OraInizio, OraFine: TTime): TOra;
var
  idx: integer;
begin
  Result := GetOra(OraInizio);

  if not assigned(Result) then
  begin
    Result := Add;
    Result.OraInizio := OraInizio;
    Result.OraFine := OraFine;
  end;
end;

{ TGiorni }

function TGiorni.Compare(Item1, Item2: TGiorno): integer;
begin
  Result := CompareDate(Item1.DataLezione, Item2.DataLezione);
end;

function TGiorni.GetGiorno(const DataLezione: TDate): TGiorno;
var
  item: TGiorno;
begin
  Result := nil;

  for item in self do
    if item.DataLezione = DataLezione then
    begin
      Result := item;
      Exit;
    end;
end;

function TGiorni.AddGiorno(const DataLezione: TDate): TGiorno;
begin
  Result := GetGiorno(DataLezione);

  if not assigned(Result) then
  begin
    Result := Add;
    Result.DataLezione := DataLezione;
  end;
end;

{ TLezione }

constructor TEvento.Create(Collection: TCollection);
begin
  inherited;
  FTipoEvento := teNull;
  FAula := '';
  FDescAula := '';
  FColore := -1;
  FModificabile := false;
  FDataCalendario := DataZero;
  FOraInizio := OraZero;
  FOraFine := OraZero;
  FIdRisorsa := -1;
  FNominativo := '';
  FTitolo := '';
  FIdGiornoChiusura := -1;
  FIdInagibilitaAula := -1;
  FIdRisorsa := -1;
  FIdOrario := -1;
  FIdPrenotazioneAula := -1;
  FIdRiunione := -1;

  FColonnaSuperiore := nil;
  FColonnaInferiore := nil;
end;

function TEvento.GetIdEvento: integer;
begin

  Result := -1;

  case TipoEvento of
    teNull:
      Result := -1;
    teOrarioLezione:
      Result := IdOrario;
    teOreRilevamento:
      Result := -1;
    teRiunione:
      Result := IdRiunione;
    teAgendaPersonale:
      Result := -1;
    tePrenotazioneAule:
      Result := IdPrenotazioneAula;
    teInagibilitaAula:
      Result := IdInagibilitaAula;
    teChiusuraSede:
      Result := IdGiornoChiusura;
    tePresenzaPersonale:
      Result := -1;
    teScadenza:
      Result := -1;
  end;
end;

{ TCalendarioDocenti }

constructor TCalendarioLezioniAule.Create;
begin
  inherited Create;
  FElencoAule := TAule.Create(TAula);
  FElencoGiorni := TGiorni.Create(TGiorno);
end;

destructor TCalendarioLezioniAule.Destroy;
begin
  FreeAndNil(FElencoAule);
  FreeAndNil(FElencoGiorni);
  inherited;
end;

procedure TCalendarioLezioniAule.Clear;
begin
  FElencoAule.Clear;
  FElencoGiorni.Clear;
end;

procedure TCalendarioLezioniAule.Sort;
var
  Aula: TAula;
  Giorno: TGiorno;
begin
  FElencoAule.Sort;

  for Aula in ElencoAule do
    Aula.Eventi.Sort;

  FElencoGiorni.Sort;

  for Giorno in ElencoGiorni do
    Giorno.Ore.Sort;
end;

function TCalendarioLezioniAule.GetColumnName(DataLezione: TDate; OraInizio: TTime): string;
begin
  Result := FormatDateTime('yyyymmdd', DataLezione) + '_' + FormatDateTime('HHMM', OraInizio);
end;

function TCalendarioLezioniAule.GetColumns(DataLezione: TDate; OraInizio: TTime; out ColonnaSuperiore, ColonnaInferiore: TcxTreeListColumn): boolean;
var
  Giorno: TGiorno;
  Ora: TOra;
begin
  Result := false;
  ColonnaSuperiore := nil;
  ColonnaInferiore := nil;

  Giorno := ElencoGiorni.GetGiorno(DataLezione);

  if assigned(Giorno) then
  begin
    Ora := Giorno.Ore.GetOra(OraInizio);

    if assigned(Ora) then
    begin
      Result := True;
      ColonnaSuperiore := Ora.ColonnaSuperiore;
      ColonnaInferiore := Ora.ColonnaInferiore;
    end;
  end;
end;

function TCalendarioLezioniAule.GetAulaIndex(const Aula: string): integer;
var
  item: TAula;
begin
  Result := -1;

  item := ElencoAule.GetAula(Aula);

  if assigned(item) then
    Result := item.Index;
end;

function TCalendarioLezioniAule.GetEvento(Node: TcxTreeListNode; Column: TcxTreeListColumn; out Evento: TEvento): boolean;
var
  Docente: TAula;

  item: TEvento;
begin
  Result := false;
  Evento := nil;

  Docente := ElencoAule.GetAula(Node);

  if assigned(Docente) then
    for item in Docente.Eventi do
      if (Column = item.ColonnaSuperiore) or (Column = item.ColonnaInferiore) then
      begin
        Result := True;
        Evento := item;
        Exit;
      end;
end;

procedure TCalendarioLezioniAule.Load(DataSet: TDataSet);
var
  Aula: TAula;
  Evento: TEvento;
  Giorno: TGiorno;
  TipoEvento: TSchedulerTipoEvento;
begin
  Clear;

  DataSet.First;
  while not DataSet.Eof do
  begin
    Aula := ElencoAule.AddAula(DataSet.FieldByName('AULA').AsString, DataSet.FieldByName('DESC_AULA').AsString);
    Giorno := ElencoGiorni.AddGiorno(DateOf(DataSet.FieldByName('DATA_CALENDARIO').AsDateTime));
    Giorno.Ore.AddOra(TimeOf(DataSet.FieldByName('ORA_INIZIO').AsDateTime), TimeOf(DataSet.FieldByName('ORA_FINE').AsDateTime));

    TipoEvento := TSchedulerTipoEvento.FromString(DataSet.FieldByName('SCHEDULER_TIPO_EVENTO').AsString);

    if TipoEvento <> teNull then
    begin
      // Lezioni
      Evento := Aula.Eventi.Add;
      Evento.FTipoEvento := TipoEvento;
      Evento.FAula := DataSet.FieldByName('AULA').AsString;
      Evento.FDescAula := DataSet.FieldByName('DESC_AULA').AsString;
      Evento.FColore := DataSet.FieldByName('COLORE').asInteger;
      Evento.FModificabile := DataSet.FieldByName('MODIFICABILE').AsBoolean;
      Evento.FDataCalendario := DateOf(DataSet.FieldByName('DATA_CALENDARIO').AsDateTime);
      Evento.FOraInizio := TimeOf(DataSet.FieldByName('ORA_INIZIO').AsDateTime);
      Evento.FOraFine := TimeOf(DataSet.FieldByName('ORA_FINE').AsDateTime);
      Evento.FIdRisorsa := DataSet.FieldByName('ID_RISORSA').asInteger;
      Evento.FNominativo := DataSet.FieldByName('NOMINATIVO_O_RAGIONE_SOCIALE').AsString;
      Evento.FTitolo := DataSet.FieldByName('TITOLO_EVENTO').AsString;

      Evento.FIdOrario := DataSet.FieldByName('ID_ORARIO').asInteger;
      Evento.FIdPrenotazioneAula := DataSet.FieldByName('ID_PRENOTAZIONE_AULA').asInteger;
      Evento.FIdRiunione := DataSet.FieldByName('ID_RIUNIONE').asInteger;
      Evento.FIdGiornoChiusura := DataSet.FieldByName('ID_GIORNO_CHIUSURA').asInteger;
      Evento.FIdInagibilitaAula := DataSet.FieldByName('ID_INAGIBILITA_AULA').asInteger;

      if DataSet.FieldByName('COLORE').isNull then
      begin
        case random(4) of
          0:
            Evento.FColore := 16776176;
          1:
            Evento.FColore := TColors.Red;
          2:
            Evento.FColore := 10930928;
          3:
            Evento.FColore := -16777192;
          4:
            Evento.FColore := TColors.Yellow;
        end;
      end;
    end;
    //
    DataSet.Next;
  end;

  Sort;
end;

procedure TCalendarioLezioniAule.LoadScheduler(cxSchedulerStorage: TcxSchedulerStorage);
var
  Aula: TAula;
  event: TcxSchedulerEvent;
  Evento: TEvento;

  procedure AddCustomFields(const FieldName, ValueType: string);
  var
    cxSchedulerStorageField: TcxSchedulerStorageField;
  begin
    cxSchedulerStorageField := cxSchedulerStorage.CustomFields.Add;
    cxSchedulerStorageField.Name := FieldName;
    cxSchedulerStorageField.ValueType := ValueType;
  end;

begin
  cxSchedulerStorage.BeginUpdate;
  try
    cxSchedulerStorage.Clear;
    cxSchedulerStorage.CustomFields.Clear;

    AddCustomFields('AULA', 'String');
    AddCustomFields('DESC_AULA', 'String');
    AddCustomFields('COLORE', 'Integer');
    AddCustomFields('SCHEDULER_TIPO_EVENTO', 'String');
    AddCustomFields('MODIFICABILE', 'boolean');
    AddCustomFields('DATA_CALENDARIO', 'DateTime');
    AddCustomFields('ORA_INIZIO', 'DateTime');
    AddCustomFields('ORA_FINE', 'DateTime');
    AddCustomFields('ID_RISORSA', 'Integer');
    AddCustomFields('NOMINATIVO_O_RAGIONE_SOCIALE', 'String');
    AddCustomFields('TITOLO_EVENTO', 'String');
    AddCustomFields('ID_ORARIO', 'Integer');
    AddCustomFields('ID_PRENOTAZIONE_AULA', 'Integer');
    AddCustomFields('ID_RIUNIONE', 'Integer');
    AddCustomFields('ID_GIORNO_CHIUSURA', 'Integer');
    AddCustomFields('ID_INAGIBILITA_AULA', 'Integer');

    /// ////

    for Aula in ElencoAule do
      for Evento in Aula.Eventi do
      begin
        event := cxSchedulerStorage.createEvent;
        event.Start := Evento.DataCalendario + Evento.OraInizio;
        event.Finish := Evento.DataCalendario + Evento.OraFine;

        event.Caption := Evento.Titolo;

        if not Evento.Nominativo.IsEmpty then
          event.Location := Evento.Nominativo;

        event.Message := Evento.Titolo;

        event.SetCustomFieldValueByName('AULA', Evento.Aula);
        event.SetCustomFieldValueByName('DESC_AULA', Evento.DescAula);
        event.SetCustomFieldValueByName('COLORE', Evento.Colore);
        event.SetCustomFieldValueByName('SCHEDULER_TIPO_EVENTO', Evento.TipoEvento.ToString);
        event.SetCustomFieldValueByName('MODIFICABILE', Evento.Modificabile);
        event.SetCustomFieldValueByName('DATA_CALENDARIO', Evento.DataCalendario);
        event.SetCustomFieldValueByName('ORA_INIZIO', Evento.OraInizio);
        event.SetCustomFieldValueByName('ORA_FINE', Evento.OraFine);
        event.SetCustomFieldValueByName('ID_RISORSA', Evento.IdRisorsa);
        event.SetCustomFieldValueByName('NOMINATIVO_O_RAGIONE_SOCIALE', Evento.Nominativo);
        event.SetCustomFieldValueByName('TITOLO_EVENTO', Evento.Titolo);
        event.SetCustomFieldValueByName('ID_ORARIO', Evento.IdOrario);
        event.SetCustomFieldValueByName('ID_PRENOTAZIONE_AULA', Evento.IdPrenotazioneAula);
        event.SetCustomFieldValueByName('ID_RIUNIONE', Evento.IdRiunione);
        event.SetCustomFieldValueByName('ID_GIORNO_CHIUSURA', Evento.IdGiornoChiusura);
        event.SetCustomFieldValueByName('ID_INAGIBILITA_AULA', Evento.IdInagibilitaAula);

        event.Post;
      end;
  finally
    cxSchedulerStorage.EndUpdate;
  end;
end;

end.
