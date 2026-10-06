unit OpenApi.Imprese.Advance;

interface

uses
  system.SysUtils,
  system.Classes,
  system.Generics.Collections,
  REST.Json.Types,
  Pkg.Json.DTO;

{$M+}

type
  T_2017 = class;
  T_2018 = class;
  T_2019 = class;
  T_2020 = class;
  T_2021 = class;
  T_2022 = class;
  T_2023 = class;
  TBilanci = class;
  TDettaglio = class;
  TGps = class;
  TGruppoIva = class;
  TSoci = class;

  TGps = class(TJsonDTO)
  private
    [JSONName('coordinates')]
    FCoordinatesArray: TArray<Double>;
    [JSONMarshalled(False)]
    FCoordinates: TList<Double>;
    function GetCoordinates: TList<Double>;
  protected
    function GetAsJson: string; override;
  published
    property Coordinates: TList<Double> read GetCoordinates;
  public
    destructor Destroy; override;
  end;

  TSoci = class
  private
    [JSONName('cf_socio')]
    FCfSocio: string;
    FCognome: string;
    FDenominazione: string;
    FNome: string;
    FQuota: Integer;
  published
    property CfSocio: string read FCfSocio write FCfSocio;
    property Cognome: string read FCognome write FCognome;
    property Denominazione: string read FDenominazione write FDenominazione;
    property Nome: string read FNome write FNome;
    property Quota: Integer read FQuota write FQuota;
  end;

  TGruppoIva = class
  private
    [JSONName('anagrafica_ok')]
    FAnagraficaOk: Boolean;
    FPartecipazione: Boolean;
    [JSONName('piva_capogruppo')]
    FPivaCapogruppo: Boolean;
  published
    property AnagraficaOk: Boolean read FAnagraficaOk write FAnagraficaOk;
    property Partecipazione: Boolean read FPartecipazione write FPartecipazione;
    property PivaCapogruppo: Boolean read FPivaCapogruppo write FPivaCapogruppo;
  end;

  T_2023 = class
  private
    [JSONName('capitale_sociale')]
    FCapitaleSociale: Integer;
    FDipendenti: Integer;
  published
    property CapitaleSociale: Integer read FCapitaleSociale write FCapitaleSociale;
    property Dipendenti: Integer read FDipendenti write FDipendenti;
  end;

  T_2022 = class
  private
    [JSONName('capitale_sociale')]
    FCapitaleSociale: Integer;
    [SuppressZero, JSONName('data_chiusura_bilancio')]
    FDataChiusuraBilancio: TDateTime;
    FDipendenti: Integer;
    FFatturato: Integer;
    FUtile: Integer;
  published
    property CapitaleSociale: Integer read FCapitaleSociale write FCapitaleSociale;
    property DataChiusuraBilancio: TDateTime read FDataChiusuraBilancio write FDataChiusuraBilancio;
    property Dipendenti: Integer read FDipendenti write FDipendenti;
    property Fatturato: Integer read FFatturato write FFatturato;
    property Utile: Integer read FUtile write FUtile;
  end;

  T_2021 = class
  private
    [JSONName('capitale_sociale')]
    FCapitaleSociale: Integer;
    [SuppressZero, JSONName('data_chiusura_bilancio')]
    FDataChiusuraBilancio: TDateTime;
    FDipendenti: Integer;
    FFatturato: Integer;
    FUtile: Integer;
  published
    property CapitaleSociale: Integer read FCapitaleSociale write FCapitaleSociale;
    property DataChiusuraBilancio: TDateTime read FDataChiusuraBilancio write FDataChiusuraBilancio;
    property Dipendenti: Integer read FDipendenti write FDipendenti;
    property Fatturato: Integer read FFatturato write FFatturato;
    property Utile: Integer read FUtile write FUtile;
  end;

  T_2020 = class
  private
    [JSONName('capitale_sociale')]
    FCapitaleSociale: Integer;
    [SuppressZero, JSONName('data_chiusura_bilancio')]
    FDataChiusuraBilancio: TDateTime;
    FDipendenti: Integer;
    FFatturato: Integer;
    FUtile: Integer;
  published
    property CapitaleSociale: Integer read FCapitaleSociale write FCapitaleSociale;
    property DataChiusuraBilancio: TDateTime read FDataChiusuraBilancio write FDataChiusuraBilancio;
    property Dipendenti: Integer read FDipendenti write FDipendenti;
    property Fatturato: Integer read FFatturato write FFatturato;
    property Utile: Integer read FUtile write FUtile;
  end;

  T_2017 = class
  private
    [SuppressZero, JSONName('data_chiusura_bilancio')]
    FDataChiusuraBilancio: TDateTime;
    FFatturato: Integer;
    FUtile: Integer;
  published
    property DataChiusuraBilancio: TDateTime read FDataChiusuraBilancio write FDataChiusuraBilancio;
    property Fatturato: Integer read FFatturato write FFatturato;
    property Utile: Integer read FUtile write FUtile;
  end;

  T_2018 = class
  private
    [SuppressZero, JSONName('data_chiusura_bilancio')]
    FDataChiusuraBilancio: TDateTime;
    FFatturato: Integer;
    FUtile: Integer;
  published
    property DataChiusuraBilancio: TDateTime read FDataChiusuraBilancio write FDataChiusuraBilancio;
    property Fatturato: Integer read FFatturato write FFatturato;
    property Utile: Integer read FUtile write FUtile;
  end;

  T_2019 = class
  private
    [JSONName('capitale_sociale')]
    FCapitaleSociale: Integer;
    [SuppressZero, JSONName('data_chiusura_bilancio')]
    FDataChiusuraBilancio: TDateTime;
    FDipendenti: Integer;
    FFatturato: Integer;
    FUtile: Integer;
  published
    property CapitaleSociale: Integer read FCapitaleSociale write FCapitaleSociale;
    property DataChiusuraBilancio: TDateTime read FDataChiusuraBilancio write FDataChiusuraBilancio;
    property Dipendenti: Integer read FDipendenti write FDipendenti;
    property Fatturato: Integer read FFatturato write FFatturato;
    property Utile: Integer read FUtile write FUtile;
  end;

  TBilanci = class
  private
    [JSONName('2017')]
    F_2017: T_2017;
    [JSONName('2018')]
    F_2018: T_2018;
    [JSONName('2019')]
    F_2019: T_2019;
    [JSONName('2020')]
    F_2020: T_2020;
    [JSONName('2021')]
    F_2021: T_2021;
    [JSONName('2022')]
    F_2022: T_2022;
    [JSONName('2023')]
    F_2023: T_2023;
  published
    property _2017: T_2017 read F_2017;
    property _2018: T_2018 read F_2018;
    property _2019: T_2019 read F_2019;
    property _2020: T_2020 read F_2020;
    property _2021: T_2021 read F_2021;
    property _2022: T_2022 read F_2022;
    property _2023: T_2023 read F_2023;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TDettaglio = class(TJsonDTO)
  private
    FBilanci: TBilanci;
    FCciaa: string;
    FCessata: Boolean;
    [JSONName('codice_ateco')]
    FCodiceAteco: string;
    [JSONName('codice_natura_giuridica')]
    FCodiceNaturaGiuridica: string;
    [SuppressZero, JSONName('data_inizio_attivita')]
    FDataInizioAttivita: TDateTime;
    [JSONName('descrizione_ateco')]
    FDescrizioneAteco: string;
    [JSONName('gruppo_iva')]
    FGruppoIva: TGruppoIva;
    FPec: string;
    FRea: string;
    [JSONName('soci'), JSONMarshalled(False)]
    FSociArray: TArray<TSoci>;
    [GenericListReflect]
    FSoci: TObjectList<TSoci>;
    [JSONName('timestamp_cessata')]
    FTimestampCessata: Integer;
    function GetSoci: TObjectList<TSoci>;
  protected
    function GetAsJson: string; override;
  published
    property Bilanci: TBilanci read FBilanci;
    property Cciaa: string read FCciaa write FCciaa;
    property Cessata: Boolean read FCessata write FCessata;
    property CodiceAteco: string read FCodiceAteco write FCodiceAteco;
    property CodiceNaturaGiuridica: string read FCodiceNaturaGiuridica write FCodiceNaturaGiuridica;
    property DataInizioAttivita: TDateTime read FDataInizioAttivita write FDataInizioAttivita;
    property DescrizioneAteco: string read FDescrizioneAteco write FDescrizioneAteco;
    property GruppoIva: TGruppoIva read FGruppoIva;
    property Pec: string read FPec write FPec;
    property Rea: string read FRea write FRea;
    property Soci: TObjectList<TSoci> read GetSoci;
    property TimestampCessata: Integer read FTimestampCessata write FTimestampCessata;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TData = class(TPersistent)
  private
    FCap: string;
    FCf: string;
    FCivico: string;
    [JSONName('codice_destinatario')]
    FCodiceDestinatario: string;
    FComune: string;
    [SuppressZero, JSONName('data_iscrizione')]
    FDataIscrizione: TDateTime;
    FDenominazione: string;
    FDettaglio: TDettaglio;
    FFrazione: string;
    FGps: TGps;
    FId: string;
    FIndirizzo: string;
    FPiva: string;
    FProvincia: string;
    [JSONName('stato_attivita')]
    FStatoAttivita: string;
    FTimestamp: Integer;
    [JSONName('timestamp_codice_destinatario')]
    FTimestampCodiceDestinatario: Integer;
    [JSONName('timestamp_creation')]
    FTimestampCreation: Integer;
    [JSONName('timestamp_last_update')]
    FTimestampLastUpdate: Integer;
    FToponimo: string;
    FVia: string;
  published
    property Cap: string read FCap write FCap;
    property Cf: string read FCf write FCf;
    property Civico: string read FCivico write FCivico;
    property CodiceDestinatario: string read FCodiceDestinatario write FCodiceDestinatario;
    property Comune: string read FComune write FComune;
    property DataIscrizione: TDateTime read FDataIscrizione write FDataIscrizione;
    property Denominazione: string read FDenominazione write FDenominazione;
    property Dettaglio: TDettaglio read FDettaglio;
    property Frazione: string read FFrazione write FFrazione;
    property Gps: TGps read FGps;
    property Id: string read FId write FId;
    property Indirizzo: string read FIndirizzo write FIndirizzo;
    property Piva: string read FPiva write FPiva;
    property Provincia: string read FProvincia write FProvincia;
    property StatoAttivita: string read FStatoAttivita write FStatoAttivita;
    property Timestamp: Integer read FTimestamp write FTimestamp;
    property TimestampCodiceDestinatario: Integer read FTimestampCodiceDestinatario write FTimestampCodiceDestinatario;
    property TimestampCreation: Integer read FTimestampCreation write FTimestampCreation;
    property TimestampLastUpdate: Integer read FTimestampLastUpdate write FTimestampLastUpdate;
    property Toponimo: string read FToponimo write FToponimo;
    property Via: string read FVia write FVia;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TOpenApi_Imprese_Advance = class(TJsonDTO)
  private
    FData: TData;
    FError: string;
    FMessage: string;
    FSuccess: Boolean;
  published
    property Data: TData read FData;
    property Error: string read FError write FError;
    property Message: string read FMessage write FMessage;
    property Success: Boolean read FSuccess write FSuccess;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TGps }

destructor TGps.Destroy;
begin
  GetCoordinates.Free;
  inherited;
end;

function TGps.GetCoordinates: TList<Double>;
begin
  Result := List<Double>(FCoordinates, FCoordinatesArray);
end;

function TGps.GetAsJson: string;
begin
  RefreshArray<Double>(FCoordinates, FCoordinatesArray);
  Result := inherited;
end;

{ TBilanci }

constructor TBilanci.Create;
begin
  inherited;
  F_2019 := T_2019.Create;
  F_2018 := T_2018.Create;
  F_2017 := T_2017.Create;
  F_2020 := T_2020.Create;
  F_2021 := T_2021.Create;
  F_2022 := T_2022.Create;
  F_2023 := T_2023.Create;
end;

destructor TBilanci.Destroy;
begin
  F_2019.Free;
  F_2018.Free;
  F_2017.Free;
  F_2020.Free;
  F_2021.Free;
  F_2022.Free;
  F_2023.Free;
  inherited;
end;

{ TDettaglio }

constructor TDettaglio.Create;
begin
  inherited;
  FBilanci := TBilanci.Create;
  FGruppoIva := TGruppoIva.Create;
end;

destructor TDettaglio.Destroy;
begin
  FBilanci.Free;
  FGruppoIva.Free;
  GetSoci.Free;
  inherited;
end;

function TDettaglio.GetSoci: TObjectList<TSoci>;
begin
  Result := ObjectList<TSoci>(FSoci, FSociArray);
end;

function TDettaglio.GetAsJson: string;
begin
  RefreshArray<TSoci>(FSoci, FSociArray);
  Result := inherited;
end;

{ TData }

constructor TData.Create;
begin
  inherited;
  FDettaglio := TDettaglio.Create;
  FGps := TGps.Create;
end;

destructor TData.Destroy;
begin
  FDettaglio.Free;
  FGps.Free;
  inherited;
end;

{ TOpenApi_Imprese_Advance }

constructor TOpenApi_Imprese_Advance.Create;
begin
  inherited;
  FData := TData.Create;
end;

destructor TOpenApi_Imprese_Advance.Destroy;
begin
  FData.Free;
  inherited;
end;

end.
