unit zz.web.JsonResponse;

interface

uses
  System.SysUtils,
  System.Classes,
  WEBLib.JSON,
  js;

type
  TJsonResponse = class
  private
    ParsedObject: TJSON;
    FErrorMsg: string;
    FJSValue: JSValue;
    FJSONObject: TJSObject;
    FResult: boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Parse(const s: string; doRaiseError: boolean); overload;
    procedure Parse(const j: JSValue; doRaiseError: boolean); overload;
    procedure RaiseError;
  public
    property Result: boolean read FResult;
    property ErrorMsg: string read FErrorMsg;
    property JSONValue: JSValue read FJSValue;
    property JSONObject: TJSObject read FJSONObject;
  end;

implementation

{ TJsonResponse }

// uses zz.web.lib;

constructor TJsonResponse.Create;
begin
  inherited;
  FResult := false;
  FErrorMsg := '';

  ParsedObject := nil;
  FJSValue := nil;
  FJSONObject := nil;
end;

destructor TJsonResponse.Destroy;
begin
  FreeAndNil(ParsedObject);
  // sono proprietà di parsed
  // FreeAndNil(FJSONOValue);
  // FreeAndNil(FJSONObject);
  inherited;
end;

procedure TJsonResponse.Parse(const j: JSValue; doRaiseError: boolean);
var
  o: TJSObject;
begin
  FResult := false;

  ParsedObject := TJSON.Create;

  if js.isObject(j) then
  begin
    o := js.toObject(j);

    FResult := js.toBoolean(o['success']);

    if Result then
    begin

      FJSValue := o['result'];

      if not js.isObject(FJSValue) then
        FErrorMsg := 'Struttura json del messaggio di risposta non valida.'
      else
        FJSONObject := js.toObject(FJSValue);
    end
    else
    begin
      FErrorMsg := js.toString(o['error']);
    end;
  end
  else
    FErrorMsg := 'Struttura di risposta JSON non valida.';

  if not Result then
    if FErrorMsg <> '' then
      if doRaiseError then
        RaiseError;
end;

procedure TJsonResponse.Parse(const s: string; doRaiseError: boolean);
var
  o: TJSONObject;
begin
  FResult := false;

  ParsedObject := TJSON.Create;

  o := ParsedObject.Parse(s) as TJSONObject;

  if Assigned(o) then
  begin

    FResult := js.toBoolean(o.JSObject.Properties['success']);

    if Result then
    begin

      FJSValue := o.JSObject.Properties['result'];

      if not js.isObject(FJSValue) then
        FErrorMsg := 'Struttura json del messaggio di risposta non valida.'
      else
        FJSONObject := js.toObject(FJSValue);
    end
    else
    begin
      FErrorMsg := js.toString(o.JSObject.Properties['error']);
    end;
  end
  else
    FErrorMsg := 'Struttura di risposta JSON non valida.';

  if not Result then
    if FErrorMsg <> '' then
      if doRaiseError then
        RaiseError;
end;

procedure TJsonResponse.RaiseError;
begin
  if ErrorMsg <> '' then
    raise exception.Create(ErrorMsg);
end;

end.
