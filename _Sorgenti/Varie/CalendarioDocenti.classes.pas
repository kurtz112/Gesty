unit CalendarioDocenti.classes;

interface

uses
  System.SysUtils,
  System.classes,
  System.Generics.Collections,
  System.UITypes,
  Vcl.ExtCtrls,
  Data.DB,
  cxTL,
  zFbDataSet,
  zz.GenericCollection,
  Gesty.Types;

type
  /// /////////////////////////

  /// /////////////////////////

  TOra = class(TCollectionItem)
  private
    FOraInizio: TTime;
    FColonnaProgetto: TcxTreeListColumn;
    FColonnaAula: TcxTreeListColumn;
  public
    constructor Create(Collection: TCollection); override;

    property OraInizio: TTime read FOraInizio write FOraInizio;
    property ColonnaProgetto: TcxTreeListColumn read FColonnaProgetto write FColonnaProgetto;
    property ColonnaAula: TcxTreeListColumn read FColonnaAula write FColonnaAula;
  end;

  TOre = class(TzGenericCollection<TOra>)
  protected
    function Compare(Item1, Item2: TOra): integer; override;
  public
    function AddOra(const OraInizio: TTime): TOra;
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

  TLezione = class(TCollectionItem)
  private
    FAula: string;
    FColonnaAula: TcxTreeListColumn;
    FColonnaProgetto: TcxTreeListColumn;
    FColore: integer;
    FDataLezione: TDate;
    FDenominazioneProgetto: string;
    FDescAula: string;
    FIdDocente: integer;
    FIdOrario: integer;
    FIdProgetto: integer;
    FMateria: string;
    FNominativo: string;
    FOraInizio: TTime;
    FOraFine: TTime;
    FSiglaProgetto: string;
  public
    constructor Create(Collection: TCollection); override;

    property IdOrario: integer read FIdOrario;
    property DataLezione: TDate read FDataLezione;
    property OraInizio: TTime read FOraInizio;
    property OraFine: TTime read FOraFine;
    property IdDocente: integer read FIdDocente;
    property Nominativo: string read FNominativo;
    property IdProgetto: integer read FIdProgetto;
    property DenominazioneProgetto: string read FDenominazioneProgetto;
    property SiglaProgetto: string read FSiglaProgetto;
    property Colore: integer read FColore;
    property Materia: string read FMateria;
    property Aula: string read FAula;
    property DescAula: string read FDescAula;
  public
    property ColonnaProgetto: TcxTreeListColumn read FColonnaProgetto write FColonnaProgetto;
    property ColonnaAula: TcxTreeListColumn read FColonnaAula write FColonnaAula;
  end;

  TLezioni = class(TzGenericCollection<TLezione>)
  public
    // function Get(Docente, Giorno, Ora)
  end;

  TDocente = class(TCollectionItem)
  private
    FIdDocente: integer;
    FLezioni: TLezioni;
    FNode: TcxTreeListNode;
    FNominativo: string;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    property IdDocente: integer read FIdDocente write FIdDocente;
    property Nominativo: string read FNominativo write FNominativo;
    property Node: TcxTreeListNode read FNode write FNode;

    property Lezioni: TLezioni read FLezioni;
  end;

  TDocenti = class(TzGenericCollection<TDocente>)
  protected
    function Compare(Item1, Item2: TDocente): integer; override;
  public
    function AddDocente(const IdDocente: integer; const Nominativo: string): TDocente;
    function GetDocente(const IdDocente: integer): TDocente; overload;
    function GetDocente(Node: TcxTreeListNode): TDocente; overload;
  end;

  /// /////////////////////////
  /// Calendario

  TCalendarioLezioniDocenti = class
  private
    FElencoDocenti: TDocenti;
    FElencoGiorni: TGiorni;
  private
    procedure Clear;
    procedure Sort;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Load(DataSet: TDataSet);

    function GetDocenteIndex(const IdDocente: integer): integer;
    function GetColumns(DataLezione: TDate; OraInizio: TTime; out ColonnaProgetto, ColonnaAula: TcxTreeListColumn): boolean;
    function GetColumnName(DataLezione: TDate; OraInizio: TTime): string;
    function GetLezione(Node: TcxTreeListNode; Column: TcxTreeListColumn; out Lezione: TLezione): boolean;
  public
    property ElencoGiorni: TGiorni read FElencoGiorni;

    property ElencoDocenti: TDocenti read FElencoDocenti;
  end;

implementation

uses
  zBaseLib,
  System.DateUtils;

{ TDocente }

constructor TDocente.Create(Collection: TCollection);
begin
  inherited;
  FIdDocente := -1;
  FNominativo := '';
  FNode := nil;
  FLezioni := TLezioni.Create(TLezione);
end;

destructor TDocente.Destroy;
begin
  FreeAndNil(FLezioni);
  inherited;
end;

{ TOra }

constructor TOra.Create(Collection: TCollection);
begin
  inherited;
  FOraInizio := OraZero;
  FColonnaProgetto := nil;
  FColonnaAula := nil;
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

{ TDocenti }

function TDocenti.Compare(Item1, Item2: TDocente): integer;
begin
  result := CompareText(Item1.Nominativo, Item2.Nominativo);
end;

function TDocenti.GetDocente(const IdDocente: integer): TDocente;
var
  item: TDocente;
begin
  result := nil;

  for item in self do
    if item.IdDocente = IdDocente then
    begin
      result := item;
      Exit;
    end;
end;

function TDocenti.GetDocente(Node: TcxTreeListNode): TDocente;
var
  item: TDocente;
begin
  result := nil;

  for item in self do
    if item.Node = Node then
    begin
      result := item;
      Exit;
    end;
end;

function TDocenti.AddDocente(const IdDocente: integer; const Nominativo: string): TDocente;
var
  idx: integer;
begin
  result := GetDocente(IdDocente);

  if not assigned(result) then
  begin
    result := Add;
    result.IdDocente := IdDocente;
    result.Nominativo := Nominativo;
  end;
end;

{ TOre }

function TOre.Compare(Item1, Item2: TOra): integer;
begin
  result := CompareTime(Item1.OraInizio, Item2.OraInizio);
end;

function TOre.GetOra(const OraInizio: TTime): TOra;
var
  item: TOra;
begin
  result := nil;

  for item in self do
    if item.OraInizio = OraInizio then
    begin
      result := item;
      Exit;
    end;
end;

function TOre.AddOra(const OraInizio: TTime): TOra;
var
  idx: integer;
begin
  result := GetOra(OraInizio);

  if not assigned(result) then
  begin
    result := Add;
    result.OraInizio := OraInizio;
  end;
end;

{ TGiorni }

function TGiorni.Compare(Item1, Item2: TGiorno): integer;
begin
  result := CompareDate(Item1.DataLezione, Item2.DataLezione);
end;

function TGiorni.GetGiorno(const DataLezione: TDate): TGiorno;
var
  item: TGiorno;
begin
  result := nil;

  for item in self do
    if item.DataLezione = DataLezione then
    begin
      result := item;
      Exit;
    end;
end;

function TGiorni.AddGiorno(const DataLezione: TDate): TGiorno;
begin
  result := GetGiorno(DataLezione);

  if not assigned(result) then
  begin
    result := Add;
    result.DataLezione := DataLezione;
  end;
end;

{ TLezione }

constructor TLezione.Create(Collection: TCollection);
begin
  inherited;
  FIdOrario := -1;
  FDataLezione := DataZero;
  FOraInizio := OraZero;
  FOraFine := OraZero;
  FIdDocente := -1;
  FNominativo := '';
  FIdProgetto := -1;
  FDenominazioneProgetto := '';
  FSiglaProgetto := '';
  FColore := -1;
  FMateria := '';
  FAula := '';
  FDescAula := '';

  FColonnaProgetto := nil;
  FColonnaAula := nil;
end;

{ TCalendarioDocenti }

constructor TCalendarioLezioniDocenti.Create;
begin
  inherited Create;
  FElencoDocenti := TDocenti.Create(TDocente);
  FElencoGiorni := TGiorni.Create(TGiorno);
end;

destructor TCalendarioLezioniDocenti.Destroy;
begin
  FreeAndNil(FElencoDocenti);
  FreeAndNil(FElencoGiorni);
  inherited;
end;

procedure TCalendarioLezioniDocenti.Clear;
begin
  FElencoDocenti.Clear;
  FElencoGiorni.Clear;
end;

procedure TCalendarioLezioniDocenti.Sort;
var
  Docente: TDocente;
  Giorno: TGiorno;
begin
  FElencoDocenti.Sort;

  for Docente in ElencoDocenti do
    Docente.Lezioni.Sort;

  FElencoGiorni.Sort;

  for Giorno in ElencoGiorni do
    Giorno.Ore.Sort;
end;

procedure TCalendarioLezioniDocenti.Load(DataSet: TDataSet);
var
  Docente: TDocente;
  Lezione: TLezione;
  Giorno: TGiorno;
begin
  Clear;

  DataSet.First;
  while not DataSet.Eof do
  begin
    Docente := ElencoDocenti.AddDocente(DataSet.FieldByName('ID_DOCENTE').asInteger, DataSet.FieldByName('NOMINATIVO_O_RAGIONE_SOCIALE').asString);
    Giorno := ElencoGiorni.AddGiorno(DateOf(DataSet.FieldByName('DATA_LEZIONE').AsDateTime));
    Giorno.Ore.AddOra(TimeOf(DataSet.FieldByName('ORA_INIZIO').AsDateTime));

    // Lezioni
    Lezione := Docente.Lezioni.Add;
    Lezione.FIdOrario := DataSet.FieldByName('ID_ORARIO').asInteger;
    Lezione.FDataLezione := DateOf(DataSet.FieldByName('DATA_LEZIONE').AsDateTime);
    Lezione.FOraInizio := TimeOf(DataSet.FieldByName('ORA_INIZIO').AsDateTime);
    Lezione.FOraFine := TimeOf(DataSet.FieldByName('ORA_FINE').AsDateTime);
    Lezione.FIdDocente := DataSet.FieldByName('ID_DOCENTE').asInteger;
    Lezione.FNominativo := DataSet.FieldByName('NOMINATIVO_O_RAGIONE_SOCIALE').asString;
    Lezione.FIdProgetto := DataSet.FieldByName('ID_PROGETTO').asInteger;
    Lezione.FDenominazioneProgetto := DataSet.FieldByName('DENOMINAZIONE_PROGETTO').asString;
    Lezione.FSiglaProgetto := DataSet.FieldByName('SIGLA').asString;

    if DataSet.FieldByName('COLORE').isNull then
    begin
      case random(4) of
        0:
          Lezione.FColore := 16776176;
        1:
          Lezione.FColore := TColors.Red;
        2:
          Lezione.FColore := 10930928;
        3:
          Lezione.FColore := -16777192;
        4:
          Lezione.FColore := TColors.Yellow;
      end;
    end
    else
      Lezione.FColore := DataSet.FieldByName('COLORE').asInteger;

    Lezione.FMateria := DataSet.FieldByName('MATERIA').asString;
    Lezione.FAula := DataSet.FieldByName('AULA').asString;
    Lezione.FDescAula := DataSet.FieldByName('DESC_AULA').asString;
    //
    DataSet.Next;
  end;

  Sort;
end;

function TCalendarioLezioniDocenti.GetColumnName(DataLezione: TDate; OraInizio: TTime): string;
begin
  result := FormatDateTime('yyyymmdd', DataLezione) + '_' + FormatDateTime('HHMM', OraInizio);
end;

function TCalendarioLezioniDocenti.GetColumns(DataLezione: TDate; OraInizio: TTime; out ColonnaProgetto, ColonnaAula: TcxTreeListColumn): boolean;
var
  Giorno: TGiorno;
  Ora: TOra;
begin
  result := false;
  ColonnaProgetto := nil;
  ColonnaAula := nil;

  Giorno := ElencoGiorni.GetGiorno(DataLezione);

  if assigned(Giorno) then
  begin
    Ora := Giorno.Ore.GetOra(OraInizio);

    if assigned(Ora) then
    begin
      result := True;
      ColonnaProgetto := Ora.ColonnaProgetto;
      ColonnaAula := Ora.ColonnaAula;
    end;
  end;
end;

function TCalendarioLezioniDocenti.GetDocenteIndex(const IdDocente: integer): integer;
var
  Docente: TDocente;
begin
  result := -1;

  Docente := ElencoDocenti.GetDocente(IdDocente);

  if assigned(Docente) then
    result := Docente.Index;
end;

function TCalendarioLezioniDocenti.GetLezione(Node: TcxTreeListNode; Column: TcxTreeListColumn; out Lezione: TLezione): boolean;
var
  Docente: TDocente;

  item: TLezione;
begin
  result := false;
  Lezione := nil;

  Docente := ElencoDocenti.GetDocente(Node);

  if assigned(Docente) then
    for item in Docente.Lezioni do
      if (Column = item.ColonnaProgetto) or (Column = item.ColonnaAula) then
      begin
        result := True;
        Lezione := item;
        Exit;
      end;
end;

end.

  System.Generics.Collections
