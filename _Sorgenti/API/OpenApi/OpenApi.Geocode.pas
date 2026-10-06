unit OpenApi.Geocode;

interface

uses
  system.SysUtils,
  system.Classes,
  system.Generics.Collections,
  REST.Json.Types,
  Pkg.Json.DTO;

{$M+}

type
  T_1 = class;
  T_2 = class;
  T_3 = class;
  TAdminLevels = class;
  TBounds = class;

  T_3 = class
  private
    FCode: string;
    FLevel: Integer;
    FName: string;
  published
    property Code: string read FCode write FCode;
    property Level: Integer read FLevel write FLevel;
    property Name: string read FName write FName;
  end;

  T_2 = class
  private
    FCode: string;
    FLevel: Integer;
    FName: string;
  published
    property Code: string read FCode write FCode;
    property Level: Integer read FLevel write FLevel;
    property Name: string read FName write FName;
  end;

  T_1 = class
  private
    FCode: string;
    FLevel: Integer;
    FName: string;
  published
    property Code: string read FCode write FCode;
    property Level: Integer read FLevel write FLevel;
    property Name: string read FName write FName;
  end;

  TAdminLevels = class
  private
    [JSONName('1')]
    F_1: T_1;
    [JSONName('2')]
    F_2: T_2;
    [JSONName('3')]
    F_3: T_3;
  published
    property _1: T_1 read F_1;
    property _2: T_2 read F_2;
    property _3: T_3 read F_3;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TBounds = class
  private
    FEast: Double;
    FNorth: Double;
    FSouth: Double;
    FWest: Double;
  published
    property East: Double read FEast write FEast;
    property North: Double read FNorth write FNorth;
    property South: Double read FSouth write FSouth;
    property West: Double read FWest write FWest;
  end;

  TElement = class(TPersistent)
  private
    FAdminLevels: TAdminLevels;
    FBounds: TBounds;
    FCountry: string;
    FCountryCode: string;
    FId: string;
    FLatitude: Double;
    FLocality: string;
    FLongitude: Double;
    FPostalCode: string;
    FProvidedBy: string;
    FStreetName: string;
    FStreetNumber: string;
  published
    property AdminLevels: TAdminLevels read FAdminLevels;
    property Bounds: TBounds read FBounds;
    property Country: string read FCountry write FCountry;
    property CountryCode: string read FCountryCode write FCountryCode;
    property Id: string read FId write FId;
    property Latitude: Double read FLatitude write FLatitude;
    property Locality: string read FLocality write FLocality;
    property Longitude: Double read FLongitude write FLongitude;
    property PostalCode: string read FPostalCode write FPostalCode;
    property ProvidedBy: string read FProvidedBy write FProvidedBy;
    property StreetName: string read FStreetName write FStreetName;
    property StreetNumber: string read FStreetNumber write FStreetNumber;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TOpenApi_Geocode = class(TJsonDTO)
  private
    FElement: TElement;
    FMessage: string;
    FSourced: Boolean;
    FSuccess: Boolean;
  published
    property Element: TElement read FElement;
    property Message: string read FMessage write FMessage;
    property Sourced: Boolean read FSourced write FSourced;
    property Success: Boolean read FSuccess write FSuccess;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TAdminLevels }

constructor TAdminLevels.Create;
begin
  inherited;
  F_1 := T_1.Create;
  F_2 := T_2.Create;
  F_3 := T_3.Create;
end;

destructor TAdminLevels.Destroy;
begin
  F_1.Free;
  F_2.Free;
  F_3.Free;
  inherited;
end;

{ TElement }

constructor TElement.Create;
begin
  inherited;
  FBounds := TBounds.Create;
  FAdminLevels := TAdminLevels.Create;
end;

destructor TElement.Destroy;
begin
  FBounds.Free;
  FAdminLevels.Free;
  inherited;
end;

{ TRoot }

constructor TOpenApi_Geocode.Create;
begin
  inherited;
  FElement := TElement.Create;
end;

destructor TOpenApi_Geocode.Destroy;
begin
  FElement.Free;
  inherited;
end;

end.
