unit OpenApi.EuropeanVat;

interface

uses
  system.SysUtils,
  system.Classes,
  system.Generics.Collections,
  REST.Json.Types,
  Pkg.Json.DTO;

{$M+}

type
  TData = class(TPersistent)
  private
    [JSONName('company_address')]
    FCompanyAddress: string;
    [JSONName('company_name')]
    FCompanyName: string;
    [JSONName('country_code')]
    FCountryCode: string;
    [JSONName('format_valid')]
    FFormatValId: Boolean;
    FValId: Boolean;
    [JSONName('vat_number')]
    FVatNumber: string;
  published
    property CompanyName: string read FCompanyName write FCompanyName;
    property CompanyAddress: string read FCompanyAddress write FCompanyAddress;
    property CountryCode: string read FCountryCode write FCountryCode;
    property VatNumber: string read FVatNumber write FVatNumber;
    property FormatValId: Boolean read FFormatValId write FFormatValId;
    property ValId: Boolean read FValId write FValId;
  end;

  TOpenApi_EuropeanVat = class(TJsonDTO)
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

{ TRoot }

constructor TOpenApi_EuropeanVat.Create;
begin
  inherited;
  FData := TData.Create;
end;

destructor TOpenApi_EuropeanVat.Destroy;
begin
  FData.Free;
  inherited;
end;

end.
