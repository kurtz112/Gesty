unit RegistroStudentiCollettiva.Classes;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.UITypes,
  Vcl.ExtCtrls,
  data.DB,
  cxTL,
  zFbDataSet,
  zz.GenericCollection,
  Gesty.Types;

const
  FAD = '12';

type

  TMateria = class(TCollectionItem)
  private
    FDurata: integer;
    FIdDocente: integer;
    FIdOrario: integer;
    FIncarichiMancanti: boolean;
    FLezioneSvolta: boolean;
    FMateria: string;
    FNominativoDocente: string;
    FOra: integer;
    FOraFine: TTime;
    FOraInizio: TTime;
    FPresenzeBloccate: boolean;
    FTipologiaFormazione: string;
  public
    constructor Create(Collection: TCollection); override;

    property IdOrario: integer read FIdOrario write FIdOrario;
    property Ora: integer read FOra write FOra;
    // verificare <=
    property OraInizio: TTime read FOraInizio write FOraInizio;
    property Durata: integer read FDurata write FDurata;
    property OraFine: TTime read FOraFine write FOraFine;
    property Materia: string read FMateria write FMateria;
    property IdDocente: integer read FIdDocente write FIdDocente;
    property NominativoDocente: string read FNominativoDocente write FNominativoDocente;
    property LezioneSvolta: boolean read FLezioneSvolta write FLezioneSvolta;
    property IncarichiMancanti: boolean read FIncarichiMancanti write FIncarichiMancanti;
    property TipologiaFormazione: string read FTipologiaFormazione write FTipologiaFormazione;
    // Mantis #47 - 2026-07-28: presenze studenti congelate su questa specifica ora
    // (ORARIO.BLOCCA_PRESENZE_STUDENTI), letta dalla colonna omonima aggiunta a
    // STUDENTI_PRESENZE_COLLETT_TMP
    property PresenzeBloccate: boolean read FPresenzeBloccate write FPresenzeBloccate;
  end;

  TMaterie = class(TzGenericCollection<TMateria>)
  protected
    function Exists(const OraInizio: TTime): boolean;
    procedure LoadRecord(DataSet: TzFbDataSet);
  public
    function GetMateria(const Ora: integer): TMateria;
    function GetOra(const OraInizio: TDateTime): integer;
  end;

  TPresenza = class(TCollectionItem)
  private
    FIdPresenzaCollettiva: integer;
    FIdOrario: integer;
    FMinutiAssenza: integer;
    FOra: integer;
    FOverrideTipologiaFormazione: string;
    FStatoPresenza: TStatoPresenza;
  public
    constructor Create(Collection: TCollection); override;

    property IdPresenzaCollettiva: integer read FIdPresenzaCollettiva write FIdPresenzaCollettiva;
    property IdOrario: integer read FIdOrario write FIdOrario;
    property Ora: integer read FOra write FOra;
    property OverrideTipologiaFormazione: string read FOverrideTipologiaFormazione write FOverrideTipologiaFormazione;
    property StatoPresenza: TStatoPresenza read FStatoPresenza write FStatoPresenza;
    property MinutiAssenza: integer read FMinutiAssenza write FMinutiAssenza;
  end;

  TPresenze = class(TzGenericCollection<TPresenza>)
  private
    procedure SetStatoPresenza(const Value: TStatoPresenza);
    function GetStatoPresenza: TStatoPresenza;
    function GetTotaleOre: integer;
  public
    function GetPresenza(const Ora: integer): TPresenza;
    procedure UpdatePresenza(const Ora: integer; Materia: TMateria; const StatoPresenza: TStatoPresenza); overload;
    procedure UpdatePresenza(const Ora: integer; const MinutiAssenza: integer); overload;

    procedure OverrideTipologia(const Ora: integer; IsFAD: boolean);

    property StatoPresenza: TStatoPresenza read GetStatoPresenza write SetStatoPresenza;
    property TotaleOre: integer read GetTotaleOre;
  end;

  TStudente = class(TCollectionItem)
  private
    FIdStudente: integer;
    FNode: TcxTreeListNode;
    FNominativoStudente: string;
    FPresenzeOre: TPresenze;
    function GetIsFAD: boolean;
    function GetStatoPresenza: TStatoPresenza;
    function GetTotaleOre: integer;
    procedure SetStatoPresenza(const Value: TStatoPresenza);
    procedure SetPresenzeOre(const Value: TPresenze);
    procedure SetIsFAD(const Value: boolean);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  public
    property IdStudente: integer read FIdStudente write FIdStudente;
    property NominativoStudente: string read FNominativoStudente write FNominativoStudente;
    property OrePresenza: TPresenze read FPresenzeOre write SetPresenzeOre;
    property StatoPresenza: TStatoPresenza read GetStatoPresenza write SetStatoPresenza;
    property IsFAD: boolean read GetIsFAD write SetIsFAD;
    property TotaleOre: integer read GetTotaleOre;
    property Node: TcxTreeListNode read FNode write FNode;
  end;

  TStudenti = class(TzGenericCollection<TStudente>)
  protected
    procedure LoadRecord(DataSet: TzFbDataSet; Materie: TMaterie);
  public
    procedure ClearNodes;
    function GetStudente(const IdStudente: integer): TStudente; overload;
    function GetStudente(Node: TcxTreeListNode): TStudente; overload;
  end;

  TRegistroCollettivo = class
  private
    FDataLezione: TDateTime;
    FIdProgetto: integer;
    FMaterie: TMaterie;
    FPresenzeModificate: boolean;
    FStudenti: TStudenti;
    FBloccaDocenti: boolean;
    FBloccaStudenti: boolean;
    FNuovePresenzeDaSalvare: boolean;
  public
    constructor Create;
    Destructor Destroy; override;

    procedure LoadFromDataSet(DataSet: TzFbDataSet);
  public
    procedure Salvato;
    procedure Modificato;
    property NuovePresenzeDaSalvare: boolean read FNuovePresenzeDaSalvare write FNuovePresenzeDaSalvare;
    property PresenzeModificate: boolean read FPresenzeModificate write FPresenzeModificate;
  public
    property BloccaDocenti: boolean read FBloccaDocenti write FBloccaDocenti;
    // Mantis #47 - 2026-07-28: valorizzato da STUDENTI_PRESENZE_COLL_TMP_PREP,
    // vero quando almeno un'ora della giornata ha le presenze congelate; lo
    // stato per singola ora sta su TMateria.PresenzeBloccate
    property BloccaStudenti: boolean read FBloccaStudenti write FBloccaStudenti;
  public
    property IdProgetto: integer read FIdProgetto write FIdProgetto;
    property DataLezione: TDateTime read FDataLezione write FDataLezione;
    property Materie: TMaterie read FMaterie write FMaterie;
    property Studenti: TStudenti read FStudenti write FStudenti;
  end;

implementation

{ TRegistroStudenti }

constructor TRegistroCollettivo.Create;
begin
  inherited Create;
  FNuovePresenzeDaSalvare := False;
  FPresenzeModificate := False;
  FBloccaDocenti := False;
  FBloccaStudenti := False;

  FIdProgetto := -1;
  FDataLezione := Date;

  FMaterie := TMaterie.Create(TMateria);
  FStudenti := TStudenti.Create(TStudente);
end;

destructor TRegistroCollettivo.Destroy;
begin
  FreeAndNil(FMaterie);
  FreeAndNil(FStudenti);

  inherited;
end;

procedure TRegistroCollettivo.LoadFromDataSet(DataSet: TzFbDataSet);
begin
  Materie.Clear;
  Studenti.Clear;

  DataSet.First;
  while not DataSet.Eof do
  begin
    Materie.LoadRecord(DataSet);
    Studenti.LoadRecord(DataSet, Materie);
    DataSet.Next;
  end;
end;

procedure TRegistroCollettivo.Modificato;
begin
  FPresenzeModificate := True;
end;

procedure TRegistroCollettivo.Salvato;
begin
  FNuovePresenzeDaSalvare := False;
  FPresenzeModificate := False;
end;

{ TMateria }

constructor TMateria.Create(Collection: TCollection);
begin
  inherited;
  FIdOrario := -1;
  FOra := -1;
  FOraInizio := 0;
  FDurata := 0;
  FOraFine := 0;
  FMateria := '';
  FIdDocente := -1;
  FNominativoDocente := '';
  FLezioneSvolta := True;
  FIncarichiMancanti := True;
  FPresenzeBloccate := False;
  FTipologiaFormazione := '';
end;

{ TStudente }

constructor TStudente.Create(Collection: TCollection);
begin
  inherited;
  FNode := nil;
  FIdStudente := -1;
  FNominativoStudente := '';
  FPresenzeOre := TPresenze.Create(TPresenza);
end;

constructor TPresenza.Create(Collection: TCollection);
begin
  inherited;
  FIdPresenzaCollettiva := -1;
  FIdOrario := -1;
  FOra := -1;
  FOverrideTipologiaFormazione := '';
  FStatoPresenza := spPresente;
  FMinutiAssenza := 0;
end;

function TPresenze.GetPresenza(const Ora: integer): TPresenza;
begin
  for Result in Self do
    if Result.Ora = Ora then
      Exit;

  Result := nil;
end;

function TPresenze.GetStatoPresenza: TStatoPresenza;
var
  Presenza: TPresenza;
begin
  Result := spOraBuca;

  for Presenza in Self do
    case Presenza.StatoPresenza of
      spPresente:
        // sempre posto a presente
        Result := spPresente;
      spAssente:
        // se finora risultava orabuca/giustificato passa ad Assente
        if Result in [spGiustificato, spOraBuca] then
          Result := spAssente;
      spGiustificato:
        // se non ancora settato a presente/assente pasas a giustificato
        if Result = spOraBuca then
          Result := spGiustificato;
      spOraBuca:
        // non deve fare nulla
      end;
    end;

  function TPresenze.GetTotaleOre: integer;
  var
    Presenza: TPresenza;
  begin
    Result := 0;

    for Presenza in Self do
      if Presenza.StatoPresenza = spPresente then
        inc(Result);
  end;

  procedure TPresenze.OverrideTipologia(const Ora: integer; IsFAD: boolean);
  var
    Presenza: TPresenza;
    Stato: TStatoPresenza;
  begin
    Presenza := GetPresenza(Ora);

    if IsFAD then
      Presenza.OverrideTipologiaFormazione := FAD
    else
      Presenza.OverrideTipologiaFormazione := '';
  end;

  procedure TPresenze.UpdatePresenza(const Ora: integer; Materia: TMateria; const StatoPresenza: TStatoPresenza);
  var
    Presenza: TPresenza;
    Stato: TStatoPresenza;
  begin
    Presenza := GetPresenza(Ora);

    Stato := StatoPresenza;
    if Assigned(Materia) then
      if not Materia.LezioneSvolta then
        Stato := spOraBuca;

    if Assigned(Presenza) then
      Presenza.StatoPresenza := Stato;
  end;

  procedure TPresenze.UpdatePresenza(const Ora: integer; const MinutiAssenza: integer);
  var
    Presenza: TPresenza;
  begin
    Presenza := GetPresenza(Ora);

    if Assigned(Presenza) then
      Presenza.MinutiAssenza := MinutiAssenza;
  end;

  procedure TPresenze.SetStatoPresenza(const Value: TStatoPresenza);
  var
    Presenza: TPresenza;
  begin
    for Presenza in Self do
      Presenza.StatoPresenza := Value;
  end;

  destructor TStudente.Destroy;
  begin
    FreeAndNil(FPresenzeOre);
    inherited;
  end;

  function TStudente.GetStatoPresenza: TStatoPresenza;
  begin
    Result := OrePresenza.StatoPresenza;
  end;

  function TStudente.GetTotaleOre: integer;
  begin
    Result := OrePresenza.TotaleOre;
  end;

  procedure TStudente.SetStatoPresenza(const Value: TStatoPresenza);
  begin
    OrePresenza.StatoPresenza := Value;
  end;

  procedure TStudente.SetIsFAD(const Value: boolean);
  var
    Presenza: TPresenza;
  begin

    for Presenza in OrePresenza do
      if Value then
        Presenza.OverrideTipologiaFormazione := FAD
      else
        Presenza.OverrideTipologiaFormazione := '';
  end;

  function TStudente.GetIsFAD: boolean;
  var
    Presenza: TPresenza;
  begin

    if OrePresenza.Count = 0 then
      Exit(False);

    Result := True;

    for Presenza in OrePresenza do
      if Presenza.OverrideTipologiaFormazione <> FAD then
        Exit(False);
  end;

  procedure TStudente.SetPresenzeOre(const Value: TPresenze);
  begin
    FPresenzeOre := Value;
  end;

  function TMaterie.Exists(const OraInizio: TTime): boolean;
  var
    Materia: TMateria;
  begin
    Result := False;

    for Materia in Self do
      if Materia.OraInizio = OraInizio then
        Exit(True);
  end;

  { TMaterie }

  function TMaterie.GetMateria(const Ora: integer): TMateria;
  begin
    for Result in Self do
      if Result.Ora = Ora then
        Exit;

    Result := nil;
  end;

  function TMaterie.GetOra(const OraInizio: TDateTime): integer;
  var
    Materia: TMateria;
  begin
    Result := -1;

    for Materia in Self do
      if Materia.OraInizio = OraInizio then
        Exit(Materia.Ora);
  end;

  procedure TMaterie.LoadRecord(DataSet: TzFbDataSet);
  var
    OraInizio: TTime;
    Materia: TMateria;
  begin
    OraInizio := DataSet.FieldByName('ORA_INIZIO').AsDateTime;
    // cerca se esiste
    if Exists(OraInizio) then
      Exit;

    Materia := Add;
    Materia.Ora := Count; // partir� da 1
    Materia.IdOrario := DataSet.FieldByName('ID_ORARIO').AsInteger;
    Materia.OraInizio := DataSet.FieldByName('ORA_INIZIO').AsDateTime;
    Materia.Durata := DataSet.FieldByName('DURATA').AsInteger;
    Materia.OraFine := DataSet.FieldByName('ORA_FINE').AsDateTime;

    Materia.Materia := DataSet.FieldByName('MATERIA').asString;

    if DataSet.FieldByName('ID_DOCENTE').IsNull then
      Materia.IdDocente := -1
    else
      Materia.IdDocente := DataSet.FieldByName('ID_DOCENTE').AsInteger;

    Materia.NominativoDocente := DataSet.FieldByName('NOMINATIVO_DOCENTE').asString;
    Materia.LezioneSvolta := DataSet.FieldByName('LEZIONE_SVOLTA').asBoolean;
    Materia.IncarichiMancanti := DataSet.FieldByName('INCARICHI_MANCANTI').asBoolean;

    Materia.TipologiaFormazione := DataSet.FieldByName('TIPOLOGIA_FORMAZIONE').asString;

    // Mantis #47 - 2026-07-28: richiede la colonna BLOCCA_PRESENZE_STUDENTI su
    // STUDENTI_PRESENZE_COLLETT_TMP e sulla vista STUDENTI_PRES_COLL_TMP_ELENCO
    Materia.PresenzeBloccate := DataSet.FieldByName('BLOCCA_PRESENZE_STUDENTI').asBoolean;
  end;

  { TStudenti }

  procedure TStudenti.ClearNodes;
  var
    Studente: TStudente;
  begin
    for Studente in Self do
      Studente.Node := nil;
  end;

  function TStudenti.GetStudente(const IdStudente: integer): TStudente;
  begin
    for Result in Self do
      if Result.IdStudente = IdStudente then
        Exit;

    Result := nil;
  end;

  function TStudenti.GetStudente(Node: TcxTreeListNode): TStudente;
  begin
    for Result in Self do
      if Result.Node = Node then
        Exit;

    Result := nil;
  end;

  procedure TStudenti.LoadRecord(DataSet: TzFbDataSet; Materie: TMaterie);
  var
    Studente: TStudente;
    Presenza: TPresenza;
  begin
    Studente := GetStudente(DataSet.FieldByName('ID_STUDENTE').Value);

    if not Assigned(Studente) then
      Studente := Add;

    Studente.IdStudente := DataSet.FieldByName('ID_STUDENTE').Value;
    Studente.NominativoStudente := DataSet.FieldByName('NOMINATIVO_STUDENTE').asString;

    Presenza := Studente.OrePresenza.Add;
    Presenza.IdPresenzaCollettiva := DataSet.FieldByName('ID_PRESENZA_COLLETTIVA').Value;
    Presenza.IdOrario := DataSet.FieldByName('ID_ORARIO').Value;
    Presenza.Ora := Materie.GetOra(DataSet.FieldByName('ORA_INIZIO').AsDateTime);
    Presenza.OverrideTipologiaFormazione := DataSet.FieldByName('OVERRIDE_TIPOLOGIA_FORMAZIONE').asString;
    Presenza.StatoPresenza := TStatoPresenza.FromString(DataSet.FieldByName('STATO_PRESENZA').asString);
    Presenza.MinutiAssenza := DataSet.FieldByName('MINUTI_ASSENZA').Value;
  end;

end.
