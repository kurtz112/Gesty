unit lib.widgetOptions;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.Generics.Collections,
  Data.DB,
  FireDAC.Comp.DataSet,
  zz.GenericCollection,
  lib.DataRequest,
  SmartInspect.core.SiAuto,
  SmartInspect.core;

type
  TWidgetOptions = class(TCollectionItem)
  private
    Fapp: string;
    Fdm: string;
    Fid: string;
    Fwidget: string;
    Foptions: string;
    FisCustom: boolean;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Src: TWidgetOptions);
  public
    property app: string read Fapp write Fapp;
    property dm: string read Fdm write Fdm;
    property id: string read Fid write Fid;
    property widget: string read Fwidget write Fwidget;
    property options: string read Foptions write Foptions;
    property isCustom: boolean read FisCustom write FisCustom;
  end;

  TWidgetsOptions = class(TzGenericCollection<TWidgetOptions>)
  public
    class function Encode(widgetOptions: TWidgetOptions): TJsonObject; static;
    class function Decode(const JSON: string): TWidgetOptions; overload; static;
    class function Decode(const JSON: TJsonObject): TWidgetOptions; overload; static;

    function GetWidget(const key: string; out widgetOptions: TWidgetOptions): boolean;

    function LoadFromDataSet(const app, dm, name: string; DataSet: TFDDataSet): TWidgetOptions;
  end;

var
  cacheWidgets: TWidgetsOptions;

function WidgetKey(dm, id, widget: string): string;

implementation

uses
  System.StrUtils,
  System.Rtti,
  REST.JSON;

function WidgetKey(dm, id, widget: string): string;
begin

  if dm.IsEmpty then
    Result := id
  else
    Result := dm + '.' + id;

  Result := Result + '.' + widget;
end;

/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////

constructor TWidgetOptions.Create;
begin
  inherited;
  Fapp := '';
  Fdm := '';
  Fid := '';
  Fwidget := '';
  Foptions := '';
  FisCustom := false;
end;

procedure TWidgetOptions.Assign(Src: TWidgetOptions);
begin
  self.app := Src.app;
  self.dm := Src.dm;
  self.id := Src.id;
  self.widget := Src.widget;;
  self.options := Src.options;
  self.isCustom := Src.isCustom;
end;

/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////

class function TWidgetsOptions.Encode(widgetOptions: TWidgetOptions): TJsonObject;
begin
  Result := TJsonObject.Create;
  try
    Result.AddPair('app', widgetOptions.app);
    Result.AddPair('dm', widgetOptions.dm);
    Result.AddPair('id', widgetOptions.id);
    Result.AddPair('widget', widgetOptions.widget);
    Result.AddPair('options', widgetOptions.options);
    Result.AddPair('isCustom', widgetOptions.isCustom);
  except
    on e: exception do
    begin
      Result.Free;
      raise;
    end;
  end;
end;

class function TWidgetsOptions.Decode(const JSON: TJsonObject): TWidgetOptions;

  function GetString(JSON: TJsonObject; const PropertyName: string): string;
  begin
    if not JSON.tryGetValue<string>(PropertyName, Result) then
      Result := '';
  end;
  function GetBool(JSON: TJsonObject; const PropertyName: string): boolean;
  begin
    if not JSON.tryGetValue<boolean>(PropertyName, Result) then
      Result := false;
  end;

var
  a: TJsonArray;
begin
  Result := TWidgetOptions.Create(nil);
  Result.app := GetString(JSON, 'app');
  Result.dm := GetString(JSON, 'dm');
  Result.id := GetString(JSON, 'id');
  Result.widget := GetString(JSON, 'widget');
  Result.options := GetString(JSON, 'options');
  Result.isCustom := GetBool(JSON, 'isCustom');

  if Result.dm.IsEmpty then
    if Result.id.Contains('.') then
    begin
      Result.dm := Result.id.Substring(0, Result.id.IndexOf('.'));
      Result.id := Result.id.Substring(Result.id.IndexOf('.') + 1);
    end;
end;

class function TWidgetsOptions.Decode(const JSON: string): TWidgetOptions;
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

function TWidgetsOptions.GetWidget(const key: string; out widgetOptions: TWidgetOptions): boolean;
var
  idx: integer;
begin
  Result := false;

  idx := IndexOf(
    function(item: TWidgetOptions): boolean
    begin
      Result := SameText(key, WidgetKey(item.dm, item.id, item.widget));
    end);

  Result := idx <> -1;

  if Result then
    widgetOptions := items[idx];
end;

function TWidgetsOptions.LoadFromDataSet(const app, dm, name: string; DataSet: TFDDataSet): TWidgetOptions;
begin
  TMonitor.Enter(self);
  try
    Result := Add;
    Result.app := app;
    Result.dm := dm;
    Result.id := DataSet.ParamByName('WIDGET_NAME').AsString;
    Result.widget := DataSet.ParamByName('WIDGET_TYPE').AsString;
    Result.options := DataSet.ParamByName('OPTIONS').AsString;
    Result.isCustom := DataSet.ParamByName('IS_CUSTOM').asBoolean;
  finally
    TMonitor.Exit(self);
  end;
end;

initialization

cacheWidgets := TWidgetsOptions.Create(TWidgetOptions);

finalization

FreeAndNil(cacheWidgets);

end.
