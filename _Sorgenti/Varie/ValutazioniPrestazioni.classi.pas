unit ValutazioniPrestazioni.classi;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.Db,
  zz.GenericCollection,
  ValutazioniPrestazioni.types;

type
  TValutazione = class(TCollectionItem)
  private
    FIdValutazione: integer;
    FAnnoValutazione: integer;
    FDataValutazione: TDate;
    FValutazione: string;
    FDescValutazione: string;
  public
    constructor Create(Collection: TCollection); override;
    procedure LoadFromDataSet(DataSet: TDataSet);
  published
    property IdValutazione: integer read FIdValutazione;
    property AnnoValutazione: integer read FAnnoValutazione;
    property DataValutazione: TDate read FDataValutazione;
    property Valutazione: string read FValutazione;
    property DescValutazione: string read FDescValutazione;
  end;

  TValutazioni = class(TzGenericCollection<TValutazione>)
  public
    constructor Create;
  end;

  TRisorsa = class(TCollectionItem)
  private
    FIdRisorsa: integer;
    FBloccaIncarichi: boolean;
    FTipoContratto: TTipoContratto;
    FDescStatoRisorsa: string;
    FTipoInquadramento: string;
    FDataInizioValiditaInquadramento: TDate;
    FTipoRisorsa: TTipoRisorsa;
    FDataFineValiditaInquadramento: TDate;
    FStatoRisorsa: TStatoRisorsa;
    FTipologiaFornitore: TTipologiaFornitore;
    FDataAttivazione: TDate;
    FDataDisattivazione: TDate;
    FNominativo: string;
    FValutazioni: TValutazioni;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    procedure LoadFromDataSet(DataSet: TDataSet);
  published
    property IdRisorsa: integer read FIdRisorsa;
    property TipoRisorsa: TTipoRisorsa read FTipoRisorsa;
    property Nominativo: string read FNominativo;
    property TipologiaFornitore: TTipologiaFornitore read FTipologiaFornitore;
    property DataAttivazione: TDate read FDataAttivazione;
    property DataDisattivazione: TDate read FDataDisattivazione;
    property DataInizioValiditaInquadramento: TDate read FDataInizioValiditaInquadramento;
    property DataFineValiditaInquadramento: TDate read FDataFineValiditaInquadramento;
    property TipoInquadramento: string read FTipoInquadramento;
    property TipoContratto: TTipoContratto read FTipoContratto;
    property BloccaIncarichi: boolean read FBloccaIncarichi;
    property StatoRisorsa: TStatoRisorsa read FStatoRisorsa;
    property DescStatoRisorsa: string read FDescStatoRisorsa;
    property Valutazioni: TValutazioni read FValutazioni;
  end;

  TRisorse = class(TzGenericCollection<TRisorsa>)
  public
    constructor Create;
    function Get(Const IdRisorsa: integer): TRisorsa;
  end;

  TElencoValutazioni = class
  private
    FAnnoMin: integer;
    FAnnoMax: integer;
    FRisorse: TRisorse;
    function GetNumeroAnnualita: integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromDataSet(DataSet: TDataSet);
  public
    property AnnoMin: integer read FAnnoMin;
    property AnnoMax: integer read FAnnoMax;
    property NumeroAnnualita: integer read GetNumeroAnnualita;
    property Risorse: TRisorse read FRisorse;
  end;

implementation

{ TValutazione }

constructor TValutazione.Create(Collection: TCollection);
begin
  inherited;
  FIdValutazione := -1;
  FAnnoValutazione := 0;
  FDataValutazione := 0;
  FValutazione := '';
  FDescValutazione := '';
end;

procedure TValutazione.LoadFromDataSet(DataSet: TDataSet);
begin
  FIdValutazione := DataSet.FieldByName('ID_VALUTAZIONE').asInteger;
  FAnnoValutazione := DataSet.FieldByName('ANNO_VALUTAZIONE').asInteger;
  FDataValutazione := DataSet.FieldByName('DATA_VALUTAZIONE').asDateTime;
  FValutazione := DataSet.FieldByName('VALUTAZIONE').asString;
  FDescValutazione := DataSet.FieldByName('DESC_VALUTAZIONE').asString;
end;

{ TValutazioni }

constructor TValutazioni.Create;
begin
  inherited Create(TValutazione);
end;

{ TRisorsa }

constructor TRisorsa.Create(Collection: TCollection);
begin
  inherited;
  FIdRisorsa := -1;
  FTipoRisorsa := trPersona;
  FNominativo := '';
  FTipologiaFornitore := tfCollaborazioni;
  FDataAttivazione := 0;
  FDataDisattivazione := 0;
  FDataInizioValiditaInquadramento := 0;
  FDataFineValiditaInquadramento := 0;
  FTipoInquadramento := '';
  FTipoContratto := tcDipendente;
  FBloccaIncarichi := false;
  FStatoRisorsa := srAttiva;
  FDescStatoRisorsa := '';
  FValutazioni := TValutazioni.Create;
end;

destructor TRisorsa.Destroy;
begin
  FreeandNil(FValutazioni);
  inherited;
end;

procedure TRisorsa.LoadFromDataSet(DataSet: TDataSet);
begin
  FIdRisorsa := DataSet.FieldByName('ID_RISORSA').asInteger;
  FTipoRisorsa.asString := DataSet.FieldByName('TIPO_RISORSA').asString;
  FNominativo := DataSet.FieldByName('NOMINATIVO_O_RAGIONE_SOCIALE').asString;
  FTipologiaFornitore.asString := DataSet.FieldByName('TIPOLOGIA_FORNITORE').asString;
  FDataAttivazione := DataSet.FieldByName('DATA_ATTIVAZIONE').asDateTime;
  FDataDisattivazione := DataSet.FieldByName('DATA_DISATTIVAZIONE').asDateTime;
  FDataInizioValiditaInquadramento := DataSet.FieldByName('DATA_INIZIO_VALIDITA_INQUADRAM').asDateTime;
  FDataFineValiditaInquadramento := DataSet.FieldByName('DATA_FINE_VALIDITA_INQUADRAMENT').asDateTime;
  FTipoInquadramento := DataSet.FieldByName('TIPO_INQUADRAMENTO').asString;
  FTipoContratto.asString := DataSet.FieldByName('TIPO_CONTRATTO').asString;
  FBloccaIncarichi := DataSet.FieldByName('BLOCCA_INCARICHI').asBoolean;
  FStatoRisorsa.asString := DataSet.FieldByName('STATO_RISORSA').asString;
  FDescStatoRisorsa := DataSet.FieldByName('DESC_STATO_RISORSA').asString;
end;

constructor TRisorse.Create;
begin
  inherited Create(TRisorsa);
end;

function TRisorse.Get(const IdRisorsa: integer): TRisorsa;
begin
  for result in self do
    if result.IdRisorsa = IdRisorsa then
      Exit;

  result := nil;
end;

{ TElencoValutazioni }

constructor TElencoValutazioni.Create;
begin
  inherited;
  FRisorse := TRisorse.Create;
end;

destructor TElencoValutazioni.Destroy;
begin
  FreeandNil(FRisorse);
  inherited;
end;

function TElencoValutazioni.GetNumeroAnnualita: integer;
begin
  if AnnoMax = -1 then
    result := 0
  else
    result := 1 + (AnnoMax - AnnoMin);
end;

procedure TElencoValutazioni.LoadFromDataSet(DataSet: TDataSet);
var
  Risorsa: TRisorsa;
  Valutazione: TValutazione;
begin
  Risorse.Clear;

  FAnnoMin := 9999;
  FAnnoMax := -1;

  DataSet.First;
  while not DataSet.Eof do
  begin
    Risorsa := Risorse.Get(DataSet.FieldByName('ID_RISORSA').asInteger);

    if not Assigned(Risorsa) then
    begin
      Risorsa := Risorse.Add;
      Risorsa.LoadFromDataSet(DataSet);
    end;

    if not DataSet.FieldByName('ANNO_VALUTAZIONE').isNull then
    begin
      Valutazione := Risorsa.Valutazioni.Add;
      Valutazione.LoadFromDataSet(DataSet);

      if Valutazione.AnnoValutazione < AnnoMin then
        FAnnoMin := Valutazione.AnnoValutazione;

      if Valutazione.AnnoValutazione > AnnoMax then
        FAnnoMax := Valutazione.AnnoValutazione;
    end;

    DataSet.Next;
  end;
end;

end.
