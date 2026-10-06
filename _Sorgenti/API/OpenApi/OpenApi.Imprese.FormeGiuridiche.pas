unit OpenApi.Imprese.FormeGiuridiche;

interface

uses
  system.SysUtils,
  system.Classes,
  system.Generics.Collections,
  REST.Json.Types,
  Pkg.Json.DTO;

{$M+}

type
  TData = class
  private
    [JSONName('codice_natura_giuridica')]
    FCodiceNaturaGiuridica: string;
    FValore: string;
  published
    property CodiceNaturaGiuridica: string read FCodiceNaturaGiuridica write FCodiceNaturaGiuridica;
    property Valore: string read FValore write FValore;
  end;

  TOpenApi_Imprese_FormeGiuridiche = class(TJsonDTO)
  private
    [JSONName('data'), JSONMarshalled(False)]
    FDataArray: TArray<TData>;
    [GenericListReflect]
    FData: TObjectList<TData>;
    FMessage: string;
    FSuccess: Boolean;
    function GetData: TObjectList<TData>;
  protected
    function GetAsJson: string; override;
  published
    property Data: TObjectList<TData> read GetData;
    property Message: string read FMessage write FMessage;
    property Success: Boolean read FSuccess write FSuccess;
  public
    destructor Destroy; override;
  end;

implementation

{ TRoot }

destructor TOpenApi_Imprese_FormeGiuridiche.Destroy;
begin
  GetData.Free;
  inherited;
end;

function TOpenApi_Imprese_FormeGiuridiche.GetData: TObjectList<TData>;
begin
  Result := ObjectList<TData>(FData, FDataArray);
end;

function TOpenApi_Imprese_FormeGiuridiche.GetAsJson: string;
begin
  RefreshArray<TData>(FData, FDataArray);
  Result := inherited;
end;

end.
