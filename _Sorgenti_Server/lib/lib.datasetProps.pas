unit lib.datasetProps;

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
  TFieldProps = class(TCollectionItem)
  private
    FAlign: String;
    FCaption: String;
    FColSpan: integer;
    FCustom: boolean;
    FDataSet: string;
    FDataType: string;
    FDefaultValue: string;
    FEditorType: string;
    FFieldDecimals: integer;
    FFieldDomain: String;
    FFieldName: String;
    FFieldOrigin: String;
    FFields2Clear: string;
    FFieldSize: integer;
    FFieldType: String;
    FLineBreak: boolean;
    FLookup: string;
    FLookupDataSet: string;
    FLookupDisplayExpr: string;
    FLookupMappings: string;
    FLookupParams: string;
    FLookupValueExpr: string;
    FPickList: string;
    FPickListItems: string;
    FReadOnly: boolean;
    FRequired: boolean;
    FCardVisible: boolean;
    FCardIndex: integer;
    FViewIndex: integer;
    FViewVisible: boolean;
  public
    constructor Create(Collection: TCollection); override;
    //
    procedure Assign(Src: TFieldProps);
    function asJSON: TJsonObject;

    class function Decode(const JSON: string): TFieldProps; overload; static;
    class function Decode(const JSON: TJsonObject): TFieldProps; overload; static;
    class procedure Decode(const JSON: TJsonObject; FieldProps: TFieldProps); overload; static;
  public
    function AlignStr: string;
  published
    property DataSet: string read FDataSet write FDataSet;
    property FieldName: String read FFieldName write FFieldName;
    property FieldOrigin: String read FFieldOrigin write FFieldOrigin;
    property FieldDomain: String read FFieldDomain write FFieldDomain;
    property FieldType: String read FFieldType write FFieldType;
    property FieldSize: integer read FFieldSize write FFieldSize;
    property FieldDecimals: integer read FFieldDecimals write FFieldDecimals;
    property DataType: string read FDataType write FDataType;
    property Align: String read FAlign write FAlign;
    property Caption: String read FCaption write FCaption;
    property Required: boolean read FRequired write FRequired;
    property ReadOnly: boolean read FReadOnly write FReadOnly;
    property Fields2Clear: string read FFields2Clear write FFields2Clear;
    property EditorType: string read FEditorType write FEditorType;
    property ColSpan: integer read FColSpan write FColSpan;
    property DefaultValue: string read FDefaultValue write FDefaultValue;
    property PickList: string read FPickList write FPickList;
    property PickListItems: string read FPickListItems write FPickListItems;
    property Lookup: string read FLookup write FLookup;
    property LookupDataSet: string read FLookupDataSet write FLookupDataSet;
    property LookupValueExpr: string read FLookupValueExpr write FLookupValueExpr;
    property LookupDisplayExpr: string read FLookupDisplayExpr write FLookupDisplayExpr;
    property LookupParams: string read FLookupParams write FLookupParams;
    property LookupMappings: string read FLookupMappings write FLookupMappings;
    property LineBreak: boolean read FLineBreak write FLineBreak;
    property CardVisible: boolean read FCardVisible write FCardVisible;
    property CardIndex: integer read FCardIndex write FCardIndex;
    property ViewVisible: boolean read FViewVisible write FViewVisible;
    property ViewIndex: integer read FViewIndex write FViewIndex;
    property Custom: boolean read FCustom write FCustom;
  end;

  TFieldsProps = class(TzGenericCollection<TFieldProps>)
  private
    procedure AddFieldFromDataSet(const DatasetName: string; DataSet: TDataSet);
  public
    function asJSON: TJSONArray;

    class function Decode(const JSON: string): TFieldsProps; static;
  public
    procedure LoadFieldsFromDataSet(const DatasetName: string; DataSet: TDataSet);
    procedure UpdateFields(fields: TFieldsProps);
  end;

  TDatasetProps = class(TCollectionItem)
  private
    Fapp: string;
    FCanDelete: boolean;
    FCanInsert: boolean;
    FCanUpdate: boolean;
    Fdm: string;
    FDataSet: string;
    FFields: TFieldsProps;
    FSelectSql: TStrings;
    FInsertSql: TStrings;
    FUpdateSql: TStrings;
    FDeleteSql: TStrings;
    FCountSql: TStrings;
    FisCustom: boolean;
    FPK: string;
    FRelationName: string;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    procedure Assign(Src: TDatasetProps);
    function IsEmptyDataset: boolean;
  public
    property app: string read Fapp write Fapp;
    property dm: string read Fdm write Fdm;
    property DataSet: string read FDataSet write FDataSet;
    property isCustom: boolean read FisCustom write FisCustom;
    property RelationName: string read FRelationName write FRelationName;
    property PK: string read FPK write FPK;
    property fields: TFieldsProps read FFields write FFields;
    property CanInsert: boolean read FCanInsert write FCanInsert;
    property CanUpdate: boolean read FCanUpdate write FCanUpdate;
    property CanDelete: boolean read FCanDelete write FCanDelete;
    property SelectSql: TStrings read FSelectSql write FSelectSql;
    property InsertSql: TStrings read FInsertSql write FInsertSql;
    property UpdateSql: TStrings read FUpdateSql write FUpdateSql;
    property DeleteSql: TStrings read FDeleteSql write FDeleteSql;
    property CountSql: TStrings read FCountSql write FCountSql;
  end;

  TDatasetsProps = class(TzGenericCollection<TDatasetProps>)
  public
    class function Encode(datasetProps: TDatasetProps): TJsonObject; static;
    class function Decode(const JSON: string): TDatasetProps; overload; static;
    class function Decode(const JSON: TJsonObject): TDatasetProps; overload; static;
  public
    function GetDataset(const dm, name: string; out datasetProps: TDatasetProps): boolean; overload;
    function GetDataset(const DataSet: string; out datasetProps: TDatasetProps): boolean; overload;

    procedure UpdateFields(fields: TFieldsProps);

    function LoadFromDataSet(const app, dm, name: string; DataSet: TFDDataSet): TDatasetProps;
  end;

function DatasetKey(dm, DataSet: string): string;

var
  cacheDatasets: TDatasetsProps;

implementation

uses
  System.StrUtils,
  System.Rtti,
  FireDAC.Stan.Param,
  REST.JSON;

{ TFieldProps }

function DatasetKey(dm, DataSet: string): string;
begin

  if dm.IsEmpty then
    Result := DataSet
  else
    Result := dm + '.' + DataSet;
end;

function GetString(JSON: TJsonObject; const PropertyName: string): string;
begin
  if not JSON.tryGetValue<string>(PropertyName, Result) then
    Result := '';
end;

function GetInt(JSON: TJsonObject; const PropertyName: string): integer;
begin
  if not JSON.tryGetValue<integer>(PropertyName, Result) then
    Result := -1;
end;

function GetBool(JSON: TJsonObject; const PropertyName: string): boolean;
begin
  if not JSON.tryGetValue<boolean>(PropertyName, Result) then
    Result := false;
end;

function GetArray(JSON: TJsonObject; const PropertyName: string): TJSONArray;
begin
  if not JSON.tryGetValue<TJSONArray>(PropertyName, Result) then
    Result := nil;
end;

/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////

constructor TFieldProps.Create;
begin
  inherited;
  FFieldName := '';
  FFieldOrigin := '';
  FFieldDomain := '';
  FFieldType := '';
  FFieldSize := 0;
  FFieldDecimals := 0;
  FDataType := '';
  FAlign := '';
  FCaption := '';
  FRequired := false;
  FReadOnly := false;
  FFields2Clear := '';
  FEditorType := '';
  FColSpan := 1;
  FDefaultValue := '';
  FPickList := '';
  FPickListItems := '';
  FLookup := '';
  FLookupDataSet := '';
  FLookupValueExpr := '';
  FLookupDisplayExpr := '';
  FLookupParams := '';
  FLookupMappings := '';
  FLineBreak := false;
  FCardVisible := true;
  FCardIndex := 0;
  FViewVisible := true;
  FViewIndex := 0;
  FCustom := false;
end;

class function TFieldProps.Decode(const JSON: TJsonObject): TFieldProps;
begin
  Result := TFieldProps.Create(nil);
  try
    Decode(JSON, Result);
  except
    on e: exception do
    begin
      Result.Free;
      raise;
    end;
  end;
end;

class procedure TFieldProps.Decode(const JSON: TJsonObject; FieldProps: TFieldProps);
begin
  FieldProps.DataSet := GetString(JSON, 'dataSet');
  FieldProps.FieldName := GetString(JSON, 'dataField');
  FieldProps.FieldOrigin := GetString(JSON, 'origin');
  FieldProps.FieldDomain := GetString(JSON, 'domain');
  FieldProps.FieldType := GetString(JSON, 'fieldType');
  FieldProps.FieldSize := GetInt(JSON, 'size');
  FieldProps.FieldDecimals := GetInt(JSON, 'decimals');
  FieldProps.DataType := GetString(JSON, 'type');
  FieldProps.Align := GetString(JSON, 'align');
  FieldProps.Caption := GetString(JSON, 'caption');
  FieldProps.Required := GetBool(JSON, 'required');
  FieldProps.ReadOnly := GetBool(JSON, 'readOnly');
  FieldProps.Fields2Clear := GetString(JSON, 'fields2Clear');
  FieldProps.EditorType := GetString(JSON, 'editorType');
  FieldProps.ColSpan := GetInt(JSON, 'colSpan');
  FieldProps.DefaultValue := GetString(JSON, 'defaultValue');
  FieldProps.PickList := GetString(JSON, 'pickList');
  FieldProps.PickListItems := GetString(JSON, 'pickListItems');
  FieldProps.Lookup := GetString(JSON, 'lookup');
  FieldProps.LookupDataSet := GetString(JSON, 'lookupDataSet');
  FieldProps.LookupValueExpr := GetString(JSON, 'lookupValueExpr');
  FieldProps.LookupDisplayExpr := GetString(JSON, 'lookupDisplayExpr');
  FieldProps.LookupParams := GetString(JSON, 'lookupParams');
  FieldProps.LookupMappings := GetString(JSON, 'lookupMappings');
  FieldProps.LineBreak := GetBool(JSON, 'lineBreak');
  FieldProps.CardVisible := GetBool(JSON, 'cardVisible');
  FieldProps.CardIndex := GetInt(JSON, 'cardIndex');
  FieldProps.ViewVisible := GetBool(JSON, 'viewVisible');
  FieldProps.ViewIndex := GetInt(JSON, 'viewIndex');
  FieldProps.Custom := GetBool(JSON, 'custom');
end;

class function TFieldProps.Decode(const JSON: string): TFieldProps;
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

procedure TFieldProps.Assign(Src: TFieldProps);
begin
  FDataSet := Src.DataSet;
  FFieldName := Src.FieldName;
  FFieldOrigin := Src.FieldOrigin;
  FFieldDomain := Src.FieldDomain;
  FFieldType := Src.FieldType;
  FFieldSize := Src.FieldSize;
  FFieldDecimals := Src.FieldDecimals;
  FDataType := Src.DataType;
  FAlign := Src.Align;
  FCaption := Src.Caption;
  FRequired := Src.Required;
  FReadOnly := Src.ReadOnly;
  FFields2Clear := Src.Fields2Clear;
  FEditorType := Src.EditorType;
  FColSpan := Src.ColSpan;
  FDefaultValue := Src.DefaultValue;
  FPickList := Src.PickList;
  FPickListItems := Src.PickListItems;
  FLookup := Src.Lookup;
  FLookupDataSet := Src.LookupDataSet;
  FLookupValueExpr := Src.LookupValueExpr;
  FLookupDisplayExpr := Src.LookupDisplayExpr;
  FLookupParams := Src.LookupParams;
  FLookupMappings := Src.LookupMappings;
  FLineBreak := Src.LineBreak;
  FCardVisible := Src.CardVisible;
  FCardIndex := Src.CardIndex;
  FViewVisible := Src.ViewVisible;
  FViewIndex := Src.ViewIndex;
  FCustom := Src.Custom;
end;

function TFieldProps.AlignStr: string;
begin

  if Align = 'left' then
    Result := 'S'
  else
    Result := 'D';
end;

function TFieldProps.asJSON: TJsonObject;
begin
  Result := TJsonObject.Create;
  Result.AddPair('dataSet', DataSet);
  Result.AddPair('dataField', FieldName);
  Result.AddPair('origin', FieldOrigin);
  Result.AddPair('domain', FieldDomain);
  Result.AddPair('caption', Caption);
  Result.AddPair('align', Align);
  Result.AddPair('readOnly', ReadOnly);
  Result.AddPair('required', Required);
  Result.AddPair('fieldType', FieldType);
  Result.AddPair('type', DataType);
  Result.AddPair('size', FieldSize);
  Result.AddPair('decimals', FieldDecimals);
  Result.AddPair('fields2Clear', Fields2Clear);
  Result.AddPair('editorType', EditorType);
  Result.AddPair('colSpan', ColSpan);
  Result.AddPair('defaultValue', DefaultValue);
  Result.AddPair('pickList', PickList);
  Result.AddPair('pickListItems', PickListItems);
  Result.AddPair('lookup', Lookup);
  Result.AddPair('lookupDataSet', LookupDataSet);
  Result.AddPair('lookupValueExpr', LookupValueExpr);
  Result.AddPair('lookupDisplayExpr', LookupDisplayExpr);
  Result.AddPair('lookupParams', LookupParams);
  Result.AddPair('lookupMappings', LookupMappings);
  Result.AddPair('lineBreak', LineBreak);
  Result.AddPair('cardVisible', CardVisible);
  Result.AddPair('cardIndex', CardIndex);
  Result.AddPair('viewVisible', ViewVisible);
  Result.AddPair('viewIndex', ViewIndex);
  Result.AddPair('custom', Custom);
end;

/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////

constructor TDatasetProps.Create;
begin
  inherited;
  Fapp := '';
  Fdm := '';
  FDataSet := '';
  FisCustom := false;
  FRelationName := '';
  FPK := '';
  FCanInsert := true;
  FCanUpdate := true;
  FCanDelete := true;
  FSelectSql := TStringList.Create;
  FInsertSql := TStringList.Create;
  FUpdateSql := TStringList.Create;
  FDeleteSql := TStringList.Create;
  FCountSql := TStringList.Create;
  FFields := TFieldsProps.Create(TFieldProps);
end;

destructor TDatasetProps.Destroy;
begin
  FreeAndNil(FSelectSql);
  FreeAndNil(FInsertSql);
  FreeAndNil(FUpdateSql);
  FreeAndNil(FDeleteSql);
  FreeAndNil(FCountSql);
  FFields.Clear;
  FreeAndNil(FFields);
  inherited;
end;

function TDatasetProps.IsEmptyDataset: boolean;
begin
  Result := RelationName.Equals('RDB$DATABASE');
end;

procedure TDatasetProps.Assign(Src: TDatasetProps);

var
  srcField, FieldProps: TFieldProps;
begin
  self.app := Src.app;
  self.dm := Src.dm;
  self.DataSet := Src.DataSet;
  self.isCustom := Src.isCustom;
  self.RelationName := Src.RelationName;
  self.PK := Src.PK;
  self.CanInsert := Src.CanInsert;
  self.CanUpdate := Src.CanUpdate;
  self.CanDelete := Src.CanDelete;
  self.SelectSql.Text := Src.SelectSql.Text;
  self.InsertSql.Text := Src.InsertSql.Text;
  self.UpdateSql.Text := Src.UpdateSql.Text;
  self.DeleteSql.Text := Src.DeleteSql.Text;
  self.CountSql.Text := Src.CountSql.Text;

  fields.Assign(Src.fields);
end;

/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////

procedure TFieldsProps.LoadFieldsFromDataSet(const DatasetName: string; DataSet: TDataSet);
begin
  Clear;

  DataSet.First;

  while not DataSet.Eof do
  begin
    AddFieldFromDataSet(DatasetName, DataSet);
    DataSet.Next;
  end;
end;

procedure TFieldsProps.UpdateFields(fields: TFieldsProps);
var
  idx: integer;
  item: TFieldProps;
  field: TFieldProps;
begin

  for field in fields do
  begin
    idx := IndexOf(
      function(item: TFieldProps): boolean
      begin
        Result := SameText(item.FieldName, field.FieldName);
      end);

    if idx = -1 then
      item := Add
    else
      item := items[idx];

    item.Assign(field);
  end;
end;

procedure TFieldsProps.AddFieldFromDataSet(const DatasetName: string; DataSet: TDataSet);

  function getStr(const FieldName: string): string;
  var
    field: TField;
  begin
    field := DataSet.FieldByName(FieldName);

    if field.isNull then
      Result := ''
    else
      Result := field.AsString;
  end;

  function GetBool(const FieldName: string): boolean;
  var
    field: TField;
  begin
    field := DataSet.FieldByName(FieldName);

    if field.isNull then
      Result := false
    else
      Result := field.AsBoolean;
  end;

  function GetInt(const FieldName: string): integer;
  var
    field: TField;
  begin
    field := DataSet.FieldByName(FieldName);

    if field.isNull then
      Result := -1
    else
      Result := field.asInteger;
  end;

  function getAlign(const FieldName: string): string;
  var
    field: TField;
    Align: string;
  begin
    Result := 'left';

    field := DataSet.FieldByName(FieldName);

    if field.isNull then
      Align := ''
    else
      Align := field.AsString;

    // 'center' | 'left' | 'right'

    if Align = 'S' then
      Result := 'left'
    else
      if Align = 'D' then
        Result := 'right'
      else
        if Align = 'C' then
          Result := 'center';
  end;

var
  field: TFieldProps;
begin
  field := Add();
  field.DataSet := DatasetName;
  field.FieldName := getStr('FIELD');
  field.FieldOrigin := getStr('FIELD_ORIGIN');
  field.FieldDomain := getStr('FIELD_DOMAIN');
  field.FieldType := getStr('FIELD_TYPE');
  field.FieldSize := GetInt('FIELD_SIZE');
  field.FieldDecimals := GetInt('FIELD_DECIMALS');
  field.DataType := getStr('DATA_TYPE');
  field.Align := getAlign('ALIGN');
  field.Caption := getStr('CAPTION');
  field.Required := GetBool('REQUIRED');
  field.ReadOnly := GetBool('READONLY');
  field.Fields2Clear := getStr('FIELDS_2_CLEAR');
  field.EditorType := getStr('EDITOR_TYPE');
  field.ColSpan := GetInt('COL_SPAN');
  field.DefaultValue := getStr('DEFAULT_VALUE');
  field.PickList := getStr('PICKLIST');
  field.PickListItems := getStr('PICKLISTS_ITEMS').Replace(sLineBreak, ';', [rfReplaceAll]);
  field.Lookup := getStr('LOOKUP');
  field.LookupDataSet := getStr('LOOKUP_DATASET');
  field.LookupValueExpr := getStr('LOOKUP_VALUE_EXPR');
  field.LookupDisplayExpr := getStr('LOOKUP_DISPLAY_EXPR');
  field.LookupParams := getStr('LOOKUP_PARAMS');
  field.LookupMappings := getStr('LOOKUP_MAPPINGS');
  field.LineBreak := GetBool('LINEBREAK');
  field.CardVisible := GetBool('CARD_VISIBLE');
  field.CardIndex := GetInt('CARD_INDEX');
  field.ViewVisible := GetBool('VIEW_VISIBLE');
  field.ViewIndex := GetInt('VIEW_INDEX');
  field.Custom := GetBool('IS_CUSTOM');
end;

function TFieldsProps.asJSON: TJSONArray;
var
  field: TFieldProps;
begin
  Result := TJSONArray.Create;

  for field in self do
    Result.Add(field.asJSON);
end;

class function TFieldsProps.Decode(const JSON: string): TFieldsProps;
var
  fields: TJSONArray;
  v: TJSONValue;
  FieldProps: TFieldProps;
begin
  Result := TFieldsProps.Create(TFieldProps);
  try
    fields := TJsonObject.ParseJSONValue(TEncoding.ASCII.GetBytes(JSON), 0) as TJSONArray;
    try
      for v in fields do
      begin
        FieldProps := Result.Add;
        TFieldProps.Decode(v as TJsonObject, FieldProps);
      end;
    finally
      fields.Free;
    end;
  except
    on e: exception do
    begin
      Result.Free;
      raise;
    end;
  end;
end;

/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////

class function TDatasetsProps.Encode(datasetProps: TDatasetProps): TJsonObject;
begin
  Result := TJsonObject.Create;
  try
    Result.AddPair('app', datasetProps.app);
    Result.AddPair('dm', datasetProps.dm);
    Result.AddPair('dataset', datasetProps.DataSet);
    Result.AddPair('isCustom', datasetProps.isCustom);
    Result.AddPair('relationName', datasetProps.RelationName);
    Result.AddPair('pk', datasetProps.PK);

    Result.AddPair('canInsert', datasetProps.CanInsert);
    Result.AddPair('canUpdate', datasetProps.CanUpdate);
    Result.AddPair('canDelete', datasetProps.CanDelete);
    Result.AddPair('selectSql', datasetProps.SelectSql.Text);
    Result.AddPair('insertSql', datasetProps.InsertSql.Text);
    Result.AddPair('updateSql', datasetProps.UpdateSql.Text);
    Result.AddPair('deleteSql', datasetProps.DeleteSql.Text);
    Result.AddPair('countSql', datasetProps.CountSql.Text);

    Result.AddPair('fields', datasetProps.fields.asJSON);
  except
    on e: exception do
    begin
      Result.Free;
      raise;
    end;
  end;
end;

class function TDatasetsProps.Decode(const JSON: TJsonObject): TDatasetProps;
var
  a: TJSONArray;
begin
  Result := TDatasetProps.Create(nil);
  try
    Result.app := GetString(JSON, 'app');
    Result.dm := GetString(JSON, 'dm');
    Result.DataSet := GetString(JSON, 'dataset');
    Result.isCustom := GetBool(JSON, 'isCustom');
    Result.RelationName := GetString(JSON, 'relationName');
    Result.PK := GetString(JSON, 'pk');
    Result.CanInsert := GetBool(JSON, 'canInsert');
    Result.CanUpdate := GetBool(JSON, 'canUpdate');
    Result.CanDelete := GetBool(JSON, 'canDelete');
    // Result.Fields := GetString(JSON, 'fields');
    Result.SelectSql.Text := GetString(JSON, 'selectSql');
    Result.InsertSql.Text := GetString(JSON, 'insertSql');
    Result.UpdateSql.Text := GetString(JSON, 'updateSql');
    Result.DeleteSql.Text := GetString(JSON, 'deleteSql');
    Result.CountSql.Text := GetString(JSON, 'countSql');
    // LoadStringList(JSON, 'fields', Result.Fields);
    // LoadStringList(JSON, 'selectSql', Result.SelectSql);
    // LoadStringList(JSON, 'insertSql', Result.InsertSql);
    // LoadStringList(JSON, 'updateSql', Result.UpdateSql);
    // LoadStringList(JSON, 'deleteSql', Result.DeleteSql);
    // LoadStringList(JSON, 'countSql', Result.CountSql);
  except
    on e: exception do
    begin
      Result.Free;
      raise;
    end;
  end;
end;

class function TDatasetsProps.Decode(const JSON: string): TDatasetProps;
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

function TDatasetsProps.GetDataset(const dm, name: string; out datasetProps: TDatasetProps): boolean;
var
  idx: integer;
begin
  Result := false;

  idx := IndexOf(
    function(item: TDatasetProps): boolean
    begin
      Result := SameText(dm, item.dm) and SameText(name, item.DataSet);
    end);

  Result := idx <> -1;

  if Result then
    datasetProps := items[idx];
end;

function TDatasetsProps.GetDataset(const DataSet: string; out datasetProps: TDatasetProps): boolean;
var
  idx: integer;
begin
  Result := false;

  idx := IndexOf(
    function(item: TDatasetProps): boolean
    begin
      Result := SameText(DataSet, item.dm + '.' + item.DataSet);
    end);

  Result := idx <> -1;

  if Result then
    datasetProps := items[idx];
end;

function TDatasetsProps.LoadFromDataSet(const app, dm, name: string; DataSet: TFDDataSet): TDatasetProps;
  function getStr(Param: TFDParam): string;
  begin
    if Param.isNull then
      Result := ''
    else
      Result := Param.Value;
  end;

begin
  TMonitor.Enter(self);
  try
    if not GetDataset(dm, name, Result) then
      Result := Add;

    Result.app := app;
    Result.dm := dm;
    Result.DataSet := name;

    Result.RelationName := getStr(DataSet.ParamByName('RELATION_NAME'));
    Result.PK := getStr(DataSet.ParamByName('PK_FIELDS'));
    Result.CanInsert := DataSet.ParamByName('CAN_INSERT').AsBoolean;
    Result.CanUpdate := DataSet.ParamByName('CAN_UPDATE').AsBoolean;
    Result.CanDelete := DataSet.ParamByName('CAN_DELETE').AsBoolean;
    Result.SelectSql.Text := getStr(DataSet.ParamByName('SQL_SELECT'));
    Result.InsertSql.Text := getStr(DataSet.ParamByName('SQL_INSERT'));
    Result.UpdateSql.Text := getStr(DataSet.ParamByName('SQL_UPDATE'));
    Result.DeleteSql.Text := getStr(DataSet.ParamByName('SQL_DELETE'));
    Result.CountSql.Text := getStr(DataSet.ParamByName('SQL_COUNT'));

    if Result.SelectSql.Text.IsEmpty then
    begin
      Result.SelectSql.Text := 'SELECT 1 FROM RDB$DATABASE';
      Result.PK := 'COSTANT';
    end;
  finally
    TMonitor.Exit(self);
  end;
end;

procedure TDatasetsProps.UpdateFields(fields: TFieldsProps);
var
  datasetProps: TDatasetProps;
begin

  if fields.count = 0 then
    Exit;

  if not GetDataset(fields[0].DataSet, datasetProps) then
    Exit;

  TMonitor.Enter(self);
  try
    datasetProps.fields.UpdateFields(fields);
  finally
    TMonitor.Exit(self);
  end;
end;

initialization

cacheDatasets := TDatasetsProps.Create(TDatasetProps);

finalization

cacheDatasets.Clear;
FreeAndNil(cacheDatasets);

end.
