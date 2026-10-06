unit OpenApi.VerificaCF;

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
    FValidita: Boolean;
  published
    property Validita: Boolean read FValidita write FValidita;
  end;

  TOpenApi_VerificaCF = class(TJsonDTO)
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

constructor TOpenApi_VerificaCF.Create;
begin
  inherited;
  FData := TData.Create;
end;

destructor TOpenApi_VerificaCF.Destroy;
begin
  FData.Free;
  inherited;
end;

end.
