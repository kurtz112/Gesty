unit zz.web.DataRequest;

interface

uses
  System.SysUtils,
  System.Classes,
  WEBLib.JSON,
  js;

type
  TDataRequestType = (rtMeta, rtCommand, rtSelect, rtInsert, rtUpdate, rtDelete, rtCount);

  TDataRequestTypeHelper = record helper for TDataRequestType
  private
    function GetAsString: String;
    procedure SetAsString(const Value: String);
  public
    property AsString: String read GetAsString write SetAsString;
  end;

  TDataRequest = class
  private
    FDataSet: string;
    FPageNum: integer;
    FDataModule: string;
    FPageSize: integer;
    FParams: TStrings;
    FRequestType: TDataRequestType;
    FSelect: TJSObject;
    FFilter: TJSObject;
    FGroup: TJSObject;
    FSort: TJSObject;
    FSkip: integer;
    FTake: integer;
    procedure SetParams(const Value: TStrings);
  public
    constructor Create;
    destructor Destroy; override;
    function Encode: string;

    property DataSet: string read FDataSet write FDataSet;
    property DataModule: string read FDataModule write FDataModule;
    property RequestType: TDataRequestType read FRequestType write FRequestType;
    property Params: TStrings read FParams write SetParams;

    property Select: TJSObject read FSelect write FSelect;
    property Filter: TJSObject read FFilter write FFilter;
    property Group: TJSObject read FGroup write FGroup;
    property Sort: TJSObject read FSort write FSort;

    property Skip: integer read FSkip write FSkip;
    property Take: integer read FTake write FTake;
  end;

function GetDataRequest(const RequestType: TDataRequestType; const dm, name, Params: string; loadOptions: TJSObject = nil): string;

implementation

uses
  System.StrUtils,
  zz.web.js;

function GetDataRequest(const RequestType: TDataRequestType; const dm, name, Params: string; loadOptions: TJSObject = nil): string;
var
  DataRequest: TDataRequest;
begin
  DataRequest := TDataRequest.Create;
  try
    DataRequest.RequestType := RequestType;
    DataRequest.DataModule := dm;
    DataRequest.DataSet := Name;
    DataRequest.Params.Text := Params;

    if assigned(loadOptions) then
    begin
      DataRequest.Select := js.ToObject(loadOptions['select']);
      DataRequest.Filter := js.ToObject(loadOptions['filter']);
      DataRequest.Group := js.ToObject(loadOptions['group']);
      DataRequest.Sort := js.ToObject(loadOptions['sort']);

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
  end;
end;

procedure TDataRequestTypeHelper.SetAsString(const Value: String);
var
  i: integer;
begin
  i := IndexStr(Value, ['META', 'CMD', 'SEL', 'INS', 'UPD', 'DEL', 'CNT']);
  self := TDataRequestType(i);
end;

constructor TDataRequest.Create;
begin
  inherited;
  FDataSet := '';
  FDataModule := '';
  FRequestType := rtMeta;
  FSelect := nil;
  FFilter := nil;
  FGroup := nil;
  FSort := nil;
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
  function JSArray(strings: TStrings): TJSArray;
  var
    s: string;
  begin
    result := TJSArray.new;
    for s in strings do
      result.push(s);
  end;

var
  o: TJSObject;
begin
  o := TJSObject.new;
  o['DataSet'] := DataSet;
  o['DataModule'] := DataModule;
  o['RequestType'] := RequestType.AsString;
  o['Params'] := JSArray(Params);
  o['Filter'] := Filter;
  o['Sort'] := Sort;
  o['Select'] := Select;
  o['Group'] := Group;
  o['Skip'] := Skip;
  o['Take'] := Take;

  result := TJSJSON.stringify(o);
end;

procedure TDataRequest.SetParams(const Value: TStrings);
begin
  FParams.Assign(Value);
end;

initialization

end.
