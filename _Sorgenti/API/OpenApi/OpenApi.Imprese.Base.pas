unit OpenApi.Imprese.Base;

interface

uses
  system.SysUtils,
  system.Classes,
  system.Generics.Collections,
  REST.Json.Types,
  Pkg.Json.DTO;

{$M+}

type
  TGps = class;

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

  TOpenApi_Imprese_Base = class(TJsonDTO)
  private
    FData: TData;
    FMessage: string;
    FSuccess: Boolean;
  published
    property Data: TData read FData;
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

{ TData }

constructor TData.Create;
begin
  inherited;
  FGps := TGps.Create;
end;

destructor TData.Destroy;
begin
  FGps.Free;
  inherited;
end;

{ TRoot }

constructor TOpenApi_Imprese_Base.Create;
begin
  inherited;
  FData := TData.Create;
end;

destructor TOpenApi_Imprese_Base.Destroy;
begin
  FData.Free;
  inherited;
end;

end.
