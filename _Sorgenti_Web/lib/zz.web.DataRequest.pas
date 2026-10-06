unit zz.web.DataRequest;

interface

uses
  System.SysUtils,
  System.Classes,
  WEBLib.JSON,
  js,
  web;

type
  TIUD = (iudInsert, iudUpdate, iudDelete);

  TIUDHelper = record helper for TIUD
  private
    function GetAsString: String;
    procedure SetAsString(const Value: String);
  public
    property AsString: String read GetAsString write SetAsString;
  end;

  TDataRequestType = (rtMeta, rtCommand, rtSelect, rtInsert, rtUpdate, rtDelete, rtCount, rtExecSP);

  TDataRequestTypeHelper = record helper for TDataRequestType
  private
    function GetAsString: String;
    procedure SetAsString(const Value: String);
  public
    property AsString: String read GetAsString write SetAsString;
  end;

  TDataRequest = class
  private
    FName: string;
    FPageNum: integer;
    Fdm: string;
    FPageSize: integer;
    FParams: TStrings;
    FRequestType: TDataRequestType;
    FSelect: TJSObject;
    FFilter: string;
    FGroup: string;
    FKeyValues: string;
    FSort: string;
    FSkip: integer;
    FTake: integer;
    procedure SetParams(const Value: TStrings);
  public
    constructor Create;
    destructor Destroy; override;
    function Encode: string;

    property dm: string read Fdm write Fdm;
    property Name: string read FName write FName;

    property RequestType: TDataRequestType read FRequestType write FRequestType;
    property KeyValues: string read FKeyValues write FKeyValues;
    property Params: TStrings read FParams write SetParams;

    property Select: TJSObject read FSelect write FSelect;

    property Filter: string read FFilter write FFilter;
    property Group: string read FGroup write FGroup;
    property Sort: string read FSort write FSort;

    property Skip: integer read FSkip write FSkip;
    property Take: integer read FTake write FTake;
  public
    class function GetDataRequest(const RequestType: TDataRequestType; const dm, name, KeyValues, Params: string; loadOptions: TJSObject = nil): string; static;
  end;

  TOptionsRequest = class
  private
    Fdm: string;
    FName: string;
    FClassName: string;
    FOptions: TStrings;
  public
    constructor Create;
    destructor Destroy; override;

    function Encode: string;
  published
    property dm: string read Fdm write Fdm;
    property Name: string read FName write FName;
    property ClassName: string read FClassName write FClassName;
    property Options: TStrings read FOptions write FOptions;
  public
    class function GetOptionRequest(const dm, name, ClassName: string; Options: TJSObject = nil): string; static;
  end;

  TSqlRequest = class
  private
    Fdm: string;
    FName: string;
    FSelectSql: TStrings;
    FInsertSql: TStrings;
    FUpdateSql: TStrings;
    FDeleteSql: TStrings;
    FCountSql: TStrings;
    FFields: TStrings;
    FPK: string;
    FTableName: string;
  public
    constructor Create;
    destructor Destroy; override;

    function Encode: string;
  published
    property dm: string read Fdm write Fdm;
    property Name: string read FName write FName;

    property TableName: string read FTableName write FTableName;
    property PK: string read FPK write FPK;
    property Fields: TStrings read FFields write FFields;
    property SelectSql: TStrings read FSelectSql write FSelectSql;
    property InsertSql: TStrings read FInsertSql write FInsertSql;
    property UpdateSql: TStrings read FUpdateSql write FUpdateSql;
    property DeleteSql: TStrings read FDeleteSql write FDeleteSql;
    property CountSql: TStrings read FCountSql write FCountSql;
  public
    class function GetSqlRequest(const dm, name, TableName, PK: string; Fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: string): string; static;
  end;

var
  __app: string;

implementation

uses
  System.StrUtils,
  zz.web.js,
  zz.web.JSON;

function JSArray(strings: TStrings): TJSArray;
var
  s: string;
begin
  result := TJSArray.new;
  for s in strings do
    result.push(s);
end;

function TDataRequestTypeHelper.GetAsString: String;
begin
  case self of
    rtMeta:
      result := 'META';
    rtCommand:
      result := 'CMD';
    rtSelect:
      result := 'SEL';
    rtInsert:
      result := 'INS';
    rtUpdate:
      result := 'UPD';
    rtDelete:
      result := 'DEL';
    rtCount:
      result := 'CNT';
    rtExecSP:
      result := 'SP';
  end;
end;

procedure TDataRequestTypeHelper.SetAsString(const Value: String);
var
  i: integer;
begin
  i := IndexStr(Value, ['META', 'CMD', 'SEL', 'INS', 'UPD', 'DEL', 'CNT', 'SP']);
  self := TDataRequestType(i);
end;

constructor TDataRequest.Create;
begin
  inherited;
  Fdm := '';
  FName := '';
  FRequestType := rtSelect;
  FSelect := nil;
  FFilter := '';
  FGroup := '';
  FSort := '';
  FSkip := -1;
  FTake := -1;
  FParams := TStringList.Create;
end;

destructor TDataRequest.Destroy;
begin
  FreeAndNil(FParams);
  inherited;
end;

function TDataRequest.Encode: string;
var
  o: TJSObject;
begin
  o := TJSObject.new;
  o['app'] := __app;
  o['dm'] := dm;
  o['Name'] := Name;
  o['RequestType'] := RequestType.AsString;
  o['KeyValues'] := KeyValues;
  o['Params'] := JSArray(Params);
  o['Filter'] := Filter;
  o['Sort'] := Sort;
  o['Select'] := Select;
  o['Group'] := Group;
  o['Skip'] := Skip;
  o['Take'] := Take;

  result := TJSJSON.stringify(o, nil, 2);
end;

class function TDataRequest.GetDataRequest(const RequestType: TDataRequestType; const dm, name, KeyValues, Params: string; loadOptions: TJSObject = nil): string;
var
  DataRequest: TDataRequest;
begin
  DataRequest := TDataRequest.Create;
  try
    DataRequest.RequestType := RequestType;
    DataRequest.dm := dm;
    DataRequest.name := Name;
    DataRequest.KeyValues := KeyValues;
    DataRequest.Params.Text := Params;

    if assigned(loadOptions) then
    begin
      DataRequest.Select := js.ToObject(loadOptions['select']);
      DataRequest.Filter := js.ToString(loadOptions['filter']);
      DataRequest.Group := js.ToString(loadOptions['group']);
      DataRequest.Sort := js.ToString(loadOptions['sort']);

      if loadOptions.hasOwnProperty('skip') then
        DataRequest.Skip := js.ToInteger(loadOptions['skip']);

      if loadOptions.hasOwnProperty('take') then
        DataRequest.Take := js.ToInteger(loadOptions['take']);
    end;

    result := 'DataRequest=' + encodeURIComponent(DataRequest.Encode);
  finally
    DataRequest.Free;
  end;
end;

procedure TDataRequest.SetParams(const Value: TStrings);
begin
  FParams.Assign(Value);
end;

constructor TOptionsRequest.Create;
begin
  inherited;
  Fdm := '';
  FName := '';
  FClassName := '';
  FOptions := TStringList.Create;
end;

destructor TOptionsRequest.Destroy;
begin
  inherited;
  FreeAndNil(FOptions);
end;

function TOptionsRequest.Encode: string;
var
  o: TJSObject;
begin
  o := TJSObject.new;
  o['app'] := __app;
  o['dm'] := dm;
  o['Name'] := Name;
  o['ClassName'] := ClassName;
  o['Options'] := JSArray(Options);

  result := TJSJSON.stringify(o, nil, 2);
end;

class function TOptionsRequest.GetOptionRequest(const dm, name, ClassName: string; Options: TJSObject = nil): string;
var
  OptionsRequest: TOptionsRequest;
  s: string;
begin
  OptionsRequest := TOptionsRequest.Create;
  try
    OptionsRequest.dm := dm;
    OptionsRequest.name := Name;
    OptionsRequest.ClassName := ClassName;

    // s := TJSJSON.stringify(Options, nil, 2);
    s := stringify(Options, false);

    if assigned(Options) then
      OptionsRequest.Options.Text := s
    else
      OptionsRequest.Options.Clear;

    result := 'OptionsRequest=' + encodeURIComponent(OptionsRequest.Encode);
  finally
    OptionsRequest.Free;
  end;
end;

{ TSqlRequest }

constructor TSqlRequest.Create;
begin
  inherited;
  Fdm := '';
  FName := '';
  FTableName := '';
  FTableName := '';
  FFields := TStringList.Create;
  FSelectSql := TStringList.Create;
  FInsertSql := TStringList.Create;
  FUpdateSql := TStringList.Create;
  FDeleteSql := TStringList.Create;
  FCountSql := TStringList.Create;
end;

destructor TSqlRequest.Destroy;
begin
  FreeAndNil(FFields);
  FreeAndNil(FSelectSql);
  FreeAndNil(FInsertSql);
  FreeAndNil(FUpdateSql);
  FreeAndNil(FDeleteSql);
  FreeAndNil(FCountSql);
  inherited;
end;

function TSqlRequest.Encode: string;
var
  o: TJSObject;
begin
  o := TJSObject.new;
  o['app'] := __app;
  o['dm'] := dm;
  o['Name'] := Name;
  o['TableName'] := TableName;
  o['PK'] := PK;
  o['Fields'] := JSArray(Fields);
  o['SelectSql'] := JSArray(SelectSql);
  o['InsertSql'] := JSArray(InsertSql);
  o['UpdateSql'] := JSArray(UpdateSql);
  o['DeleteSql'] := JSArray(DeleteSql);
  o['CountSql'] := JSArray(CountSql);

  result := TJSJSON.stringify(o, nil, 2);
end;

class function TSqlRequest.GetSqlRequest(const dm, name, TableName, PK: string; Fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: string): string;
var
  SqlRequest: TSqlRequest;
begin
  SqlRequest := TSqlRequest.Create;
  try
    SqlRequest.dm := dm;
    SqlRequest.name := Name;
    SqlRequest.TableName := TableName;
    SqlRequest.PK := PK;

    SqlRequest.Fields.Text := Fields;
    SqlRequest.SelectSql.Text := SelectSql;
    SqlRequest.InsertSql.Text := InsertSql;
    SqlRequest.UpdateSql.Text := UpdateSql;
    SqlRequest.DeleteSql.Text := DeleteSql;
    SqlRequest.CountSql.Text := CountSql;

    result := 'SqlRequest=' + encodeURIComponent(SqlRequest.Encode);
  finally
    SqlRequest.Free;
  end;
end;

{ TIUDHelper }

function TIUDHelper.GetAsString: String;
begin
  case self of
    iudInsert:
      result := '+'; // INSERT
    iudUpdate:
      result := '/'; // UPDATE
    iudDelete:
      result := '-'; // DELETE
  end;

end;

procedure TIUDHelper.SetAsString(const Value: String);
begin
  if Value = '+' then
    self := iudInsert
  else
    if Value = '/' then
      self := iudUpdate
    else
      if Value = '-' then
        self := iudDelete;
end;

initialization

end.
