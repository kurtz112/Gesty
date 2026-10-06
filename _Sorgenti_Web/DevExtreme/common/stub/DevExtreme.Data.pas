unit DevExtreme.Data;

interface

uses
  System.SysUtils,
  System.Classes,
  JS,
  WEBLib.Controls;

type
  TdxInitOptionsProc = Reference to Procedure(options: TJSObject);

  [ComponentPlatforms(TMSWebPlatform)]
  TjdxDataSource = class(TComponent)
  private
    Fdataset: string;
    Fdm: string;
    Fkey: string;
    Fparams: TStringList;
    FInitOptionsProc: TdxInitOptionsProc;
    function Getparams: TStringList;
    procedure Setparams(const Value: TStringList);
  public
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;

    property InitOptionsProc: TdxInitOptionsProc read FInitOptionsProc write FInitOptionsProc;
  published
    property dm: string read Fdm write Fdm;
    property dataset: string read Fdataset write Fdataset;
    property key: string read Fkey write Fkey;

    property Params: TStringList read Getparams write Setparams;
  end;

implementation

constructor TjdxDataSource.Create(aOwner: TComponent);
begin
  inherited;
  Fdm := '';
  Fdataset:='';
  Fkey := '';
  FInitOptionsProc := nil;
  Fparams := TStringList.Create;
end;

destructor TjdxDataSource.Destroy;
begin
  inherited;
  FreeAndNil(Fparams);
end;

procedure TjdxDataSource.Setparams(const Value: TStringList);
begin
  Fparams.Assign(Value);
end;

function TjdxDataSource.Getparams: TStringList;
begin
  Result := Fparams;
end;

end.
