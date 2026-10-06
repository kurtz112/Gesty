unit lib.DataRequest;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
//  web.HTTPApp,
  Data.DB;

type
  TDataRequestType = (rtMeta, rtCommand, rtSelect, rtInsert, rtUpdate, rtDelete);
  TJSONFieldType = (jftUnknown, jftString, jftInteger, jftLargeInt, jftBoolean, jftFloat, jftDate, jftTime, jftDateTime, jftAutoInc, jftBlob, jftMemo, jftFixedChar, jftVariant,
    jftDataset);

  TJson2DataSetOption = (j2doDateUTC);
  TJson2DataSetOptions = set of TJson2DataSetOption;

  TDataRequestTypeHelper = record helper for TDataRequestType
  private
    function GetAsString: String;
    procedure SetAsString(const Value: String);
  public
    function ToString: string;
    property AsString: String read GetAsString write SetAsString;
  end;

  TDataRequest = class
  private
    FDataSet: string;
    FPageNum: integer;
    FDataModule: string;
    FSort: string;
    FPageSize: integer;
    FFilter: string;
    FParams: TStrings;
    FRequestType: string;
    procedure SetParams(const Value: TStrings);
  public
    class function Encode(DataRequest: TDataRequest): TJsonObject;
    class function Decode(const JSON: string): TDataRequest; overload;
    class function Decode(const JSON: TJsonObject): TDataRequest; overload;
  public
    constructor Create;
    destructor Destroy; override;
    function ToString: string; override;
  published
    property DataSet: string read FDataSet write FDataSet;
    property DataModule: string read FDataModule write FDataModule;
    property RequestType: string read FRequestType write FRequestType;
    property Params: TStrings read FParams write SetParams;
    property Filter: string read FFilter write FFilter;
    property Sort: string read FSort write FSort;
    property PageNum: integer read FPageNum write FPageNum;
    property PageSize: integer read FPageSize write FPageSize;
  end;

implementation

uses
  System.StrUtils,
  System.Rtti,
  REST.JSON;

function TDataRequestTypeHelper.GetAsString: String;
begin
  case self of
    rtMeta:
      Result := 'META';
    rtCommand:
      Result := 'CMD';
    rtSelect:
      Result := 'SEL';
    rtInsert:
      Result := 'INS';
    rtUpdate:
      Result := 'UPD';
    rtDelete:
      Result := 'DEL';
  end;
end;

procedure TDataRequestTypeHelper.SetAsString(const Value: String);
var
  i: integer;
begin
  i := IndexStr(Value, ['META', 'CMD', 'SEL', 'INS', 'UPD', 'DEL']);
  self := TDataRequestType(i);
end;

function TDataRequestTypeHelper.ToString: string;
begin
  Result := TRttiEnumerationType.GetName(self);
end;

constructor TDataRequest.Create;
begin
  inherited;
  FDataSet := '';
  FDataModule := '';
  FRequestType := rtMeta.AsString;
  FFilter := '';
  FSort := '';
  FPageNum := -1;
  FPageSize := -1;
  FParams := TStringList.Create;
end;

destructor TDataRequest.Destroy;
begin
  FreeAndNil(FParams);
  inherited;
end;

class function TDataRequest.Decode(const JSON: string): TDataRequest;
var
  o: TJsonObject;
begin
  o := TJsonObject.ParseJSONValue(TEncoding.ASCII.GetBytes(JSON), 0) as TJsonObject;
  try
    Result := Decode(o);
  finally
    o.Free;
  end;
end;

class function TDataRequest.Decode(const JSON: TJsonObject): TDataRequest;

  procedure LoadStringList(const PropertyName: string; StringList: TStrings);
  var
    i: integer;
    v: TJSONValue;
    a: TJsonArray;
  begin
    StringList.Clear;

    v := JSON.GetValue(PropertyName);

    if Assigned(v) then
      if v is TJsonArray then
      begin

        a := TJsonArray(v);

        for i := 0 to a.Size - 1 do
          StringList.Add(a.get(i).Value);
      end;
  end;

  function GetString(const PropertyName: string): string;
  begin
    if not JSON.tryGetValue<string>(PropertyName, Result) then
      Result := '';
  end;

  function GetInt(const PropertyName: string): integer;
  begin
    if not JSON.tryGetValue<integer>(PropertyName, Result) then
      Result := -1;
  end;

var
  a: TJsonArray;
begin
  // Result := TJson.JsonToObject<TDataRequest>(JSON);

  Result := TDataRequest.Create;
  try
    Result.DataSet := GetString('DataSet');
    Result.DataModule := GetString('DataModule');
    Result.RequestType := GetString('RequestType');
    Result.Filter := GetString('Filter');
    Result.Sort := GetString('Sort');
    Result.PageNum := GetInt('PageNum');
    Result.PageSize := GetInt('PageSize');
    LoadStringList('Params', Result.Params);
  except
    on e: exception do
    begin
      Result.Free;
      raise;
    end;
  end;
end;

class function TDataRequest.Encode(DataRequest: TDataRequest): TJsonObject;
  function StringsToJSONArray(const Data: TStrings): TJsonArray;
  var
    i: integer;
  begin
    Result := TJsonArray.Create;
    for i := 0 to Data.Count - 1 do
      Result.Add(Data[i]);
  end;

begin
  // Result := TJson.ObjectToJsonObject(DataRequest);

  Result := TJsonObject.Create;
  try
    Result.AddPair('DataSet', DataRequest.DataSet);
    Result.AddPair('DataModule', DataRequest.DataModule);
    Result.AddPair('RequestType', DataRequest.RequestType);
    Result.AddPair('Params', StringsToJSONArray(DataRequest.Params));
    Result.AddPair('Filter', DataRequest.Filter);
    Result.AddPair('Sort', DataRequest.Sort);
    Result.AddPair('PagaNum', TJSONNumber.Create(DataRequest.PageNum));
    Result.AddPair('PageSize', TJSONNumber.Create(DataRequest.PageSize));
  except
    on e: exception do
    begin
      Result.Free;
      raise;
    end;
  end;
end;

procedure TDataRequest.SetParams(const Value: TStrings);
begin
  FParams.Assign(Value);
end;

function TDataRequest.ToString: string;
var
  rt: TDataRequestType;
begin
  rt.AsString := RequestType;

  Result := 'DataSet = ' + DataSet + #13#10 + 'DataModule = ' + DataModule + #13#10 + 'RequestType = ' + rt.ToString + #13#10 + 'Filter = ' + Filter + #13#10 + 'Sort = ' + Sort +
    #13#10 + 'PageNum = ' + PageNum.ToString + #13#10 + 'PageSize = ' + PageSize.ToString;
end;

end.
