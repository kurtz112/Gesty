unit dmData;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  Data.DB,
  Data.DBCommon,
  Web.HTTPApp,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  zz.DataRequest,
  lib.Context,
  Route,
  Routes.Attributes;

type
  TX = class
  end;

  [Path('zz')]
  TData = class(TRoute)
  private type
    TSQLKind = (skFields, skSelect, skInsert, skUpdate, skDelete, skCount, skCommand);
  private
    function SqlTypeStr(SQLKind: TSQLKind): string;
  protected
    procedure SetParam(Param: TFDParam; const Value: string); override;
  private
    function GetFieldOrigin(DataSet: TFDQuery; Field: TField): string;
    function GetFieldTableName(DataSet: TFDQuery; Field: TField): string;
    function GetSQLFK: string;
    procedure CreateFieldsFile(DataRequest: TDataRequest; ctx: TzContext);
  private
    procedure ExecuteSQL(const SQL: String; DataRequest: TDataRequest; ctx: TzContext);
    procedure LoadDataSet(const App, DataModule, DataSetName: String; out TableName, PK: string);
    procedure SaveDataSet(const App, DataModule, DataSetName, TableName, PK: string);
  private
    procedure doFields(DataRequest: TDataRequest; ctx: TzContext);
    procedure doCommand(DataRequest: TDataRequest; ctx: TzContext);
    procedure doSelect(DataRequest: TDataRequest; ctx: TzContext);
    procedure doInsert(DataRequest: TDataRequest; ctx: TzContext);
    procedure doUpdate(DataRequest: TDataRequest; ctx: TzContext);
    procedure doDelete(DataRequest: TDataRequest; ctx: TzContext);
    procedure doCount(DataRequest: TDataRequest; ctx: TzContext);
    procedure doExecSP(DataRequest: TDataRequest; ctx: TzContext);
  private
    procedure AppendDataRequestParams(Request: TWebRequest; DataRequest: TDataRequest);
    procedure AppendDataRequestKeys(Request: TWebRequest; DataRequest: TDataRequest; DataSet: TFDQuery; const TableName, PK: string);

    function LoadSQL(DataRequest: TDataRequest; SQLKind: TSQLKind; out SQL, TableName, PK: string): String;
  private
    function metaFolder(const App, DataModuleName: String; const SubFolder: string; const ForceDir: boolean): string;
    function sqlFileName(const App, DataModule, DataSetName, sqlType: string): string;
  private
    function Get_RelationNameFromSQL(SQL: string): string;
  private
    datasets: TObjectDictionary<string, TX>;
    function DatasetKey(dm, DataSet: string): string;
  private
    /// /////////////////
    ///
    procedure InternalLoadDataset(ctx: TzContext; datasetRequest: TDatasetRequest);
    procedure InternalSaveDataset(ctx: TzContext; datasetRequest: TDatasetRequest);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  public
    /// /////////////////

    [POST('getDataset', pkJWT)]
    procedure GetDataset(ctx: TzContext);

    [POST('setDataset', pkJWT)]
    procedure SetDataset(ctx: TzContext);

    /// ////////////////////////////////////

    [POST('data', pkJWT)]
    procedure DataRequest(ctx: TzContext);
  end;

var
  Requests: TData;

implementation

uses
  System.UITypes,
  System.IOUtils,
  fib.SqlTxtRtns,
  zz.SmartInspect,
  zz.Folders,
  lib.JsonRest,
  lib.Config,
  lib.DateISO;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

constructor TData.Create(aOwner: TComponent);
begin
  inherited;
  datasets := TObjectDictionary<string, TX>.Create([doOwnsValues]);
end;

destructor TData.Destroy;
begin
  FreeAndNil(datasets);
  inherited;
end;

procedure TData.ExecuteSQL(const SQL: String; DataRequest: TDataRequest; ctx: TzContext);
var
  Command: TFDCommand;
begin

  if SQL = '' then
  begin
    ctx.Response.RenderError('Sql non specificato.', -1);
    Exit;
  end;

  Connect(ctx);
  try
    Command := CreateCommand(SQL);
    try
      /// ///////////////////////////////////////////////////////////////////////////////////
      /// ///////////////////////////////////////////////////////////////////////////////////
      // Con EXECUTE PROCEDURE non usare RETURNING
      Prepare(ctx.Request, Command);
      Command.Execute;
      ctx.Response.Render(Command);
    finally
      FreeAndNil(Command);
    end;
  finally
    Disconnect;
  end;
end;

procedure TData.doCommand(DataRequest: TDataRequest; ctx: TzContext);
var
  FileName: string;
  SQL: string;
begin
  FileName := sqlFileName(DataRequest.App, DataRequest.dm, DataRequest.Name, SqlTypeStr(skCommand));

  if TFile.Exists(FileName) then
    SQL := TFile.ReadAllText(FileName)
  else
    raise Exception.Create('DataSet non trovato: ' + FileName);

  ExecuteSQL(SQL, DataRequest, ctx);
end;

procedure TData.doSelect(DataRequest: TDataRequest; ctx: TzContext);
var
  DataSet: TFDQuery;
  Field: TField;
  i: Integer;
  o: TJSONObject;
  Param: TFDParam;
  ParamName: string;
  ParamValue: string;
  RowsTo: string;
  SQL, TableName, PK: string;

  function GetRowsTo(DataRequest: TDataRequest): String;
  var
    rows_, to_: Integer;
  begin
    Result := '';

    if DataRequest.PageSize > 0 then
    begin
      rows_ := DataRequest.PageSize * DataRequest.PageNum;
      to_ := DataRequest.PageSize * (DataRequest.PageNum + 1);
      Result := ' ROWS ' + rows_.ToString + ' TO ' + to_.ToString;
    end;
  end;

begin
  // assegnare i parametri, sort, filter
  Connect(ctx);
  try
    DataSet := CreateDataSet;
    try
      LoadSQL(DataRequest, skSelect, SQL, TableName, PK);
      DataSet.SQL.Text := SQL;

      if not DataRequest.KeyValues.IsEmpty then
        AppendDataRequestKeys(ctx.Request, DataRequest, DataSet, TableName, PK);

      Prepare(ctx.Request, DataSet);

      if not DataRequest.Filter.IsEmpty then
        DataSet.SQL.Text := fib.SqlTxtRtns.AddToWhereClause(DataSet.SQL.Text, DataRequest.Filter, true);

      if not DataRequest.Sort.IsEmpty then
        DataSet.SQL.Text := fib.SqlTxtRtns.SetOrderClause(DataSet.SQL.Text, DataRequest.Sort);

      if DataRequest.PageSize > 0 then
        DataSet.SQL.Text := DataSet.SQL.Text + #13#10 + GetRowsTo(DataRequest);

      DataSet.Active := true;
      try
        ctx.Response.Render(DataSet, [j2doDateISO]);
      finally
        DataSet.Active := false;
      end;
    finally
      FreeAndNil(DataSet);
    end;
  finally
    Disconnect;
  end;
end;

procedure TData.doInsert(DataRequest: TDataRequest; ctx: TzContext);
var
  SQL, TableName, PK: string;
begin
  LoadSQL(DataRequest, skInsert, SQL, TableName, PK);
  ExecuteSQL(SQL, DataRequest, ctx);
end;

procedure TData.doUpdate(DataRequest: TDataRequest; ctx: TzContext);
var
  SQL, TableName, PK: string;
begin
  LoadSQL(DataRequest, skUpdate, SQL, TableName, PK);
  ExecuteSQL(SQL, DataRequest, ctx);
end;

procedure TData.doDelete(DataRequest: TDataRequest; ctx: TzContext);
var
  SQL, TableName, PK: string;
begin
  LoadSQL(DataRequest, skDelete, SQL, TableName, PK);
  ExecuteSQL(SQL, DataRequest, ctx);
end;

procedure TData.doCount(DataRequest: TDataRequest; ctx: TzContext);
var
  DataSet: TFDQuery;
  Field: TField;
  i: Integer;
  o: TJSONObject;
  Param: TFDParam;
  ParamName: string;
  ParamValue: string;
  SQL, TableName, PK: string;
  totalCount: Integer;
begin
  Connect(ctx);
  try
    DataSet := CreateDataSet;
    try
      LoadSQL(DataRequest, skCount, SQL, TableName, PK);
      DataSet.SQL.Text := SQL;

      if not DataRequest.KeyValues.IsEmpty then
        AppendDataRequestKeys(ctx.Request, DataRequest, DataSet, TableName, PK);

      Prepare(ctx.Request, DataSet);

      if not DataRequest.Filter.IsEmpty then
        DataSet.SQL.Text := fib.SqlTxtRtns.AddToWhereClause(DataSet.SQL.Text, DataRequest.Filter, true);

      if not DataRequest.Sort.IsEmpty then
        DataSet.SQL.Text := fib.SqlTxtRtns.SetOrderClause(DataSet.SQL.Text, DataRequest.Sort);

      DataSet.Active := true;
      try
        totalCount := DataSet.Fields[0].AsInteger;
      finally
        DataSet.Active := false;
      end;

      { TODO : da rivedere il metodo di restituzione del dato,
        al momento la select risponde con -1 }
      ctx.Response.Render(true, TJSONNumber.Create(totalCount));
    finally
      FreeAndNil(DataSet);
    end;
  finally
    Disconnect;
  end;
end;

procedure TData.doExecSP(DataRequest: TDataRequest; ctx: TzContext);
var
  StoredProcName: string;
begin
  StoredProcName := DataRequest.Name;
  ExecSP(StoredProcName, ctx);
end;

function TData.LoadSQL(DataRequest: TDataRequest; SQLKind: TSQLKind; out SQL, TableName, PK: string): String;
var
  FileName: string;
begin
  TableName := '';
  PK := '';
  SQL := '';

  LoadDataSet(DataRequest.App, DataRequest.dm, DataRequest.Name, TableName, PK);

  FileName := sqlFileName(DataRequest.App, DataRequest.dm, DataRequest.Name, SqlTypeStr(SQLKind));

  if FileExists(FileName) then
    SQL := TFile.ReadAllText(FileName)
  else
  begin
    case SQLKind of
      skFields:
        SQL := '';
      skSelect:
        SQL := 'SELECT 1 FROM RDB$DATABASE';
      skInsert:
        SQL := '';
      skUpdate:
        SQL := '';
      skDelete:
        SQL := '';
      skCount:
        SQL := 'SELECT 1 FROM RDB$DATABASE';
      skCommand:
        SQL := '';
    end;

    TFile.WriteAllText(FileName, SQL);
    // raise Exception.Create('DataRequest: sql non trovato. ' + ExtractFileName(FileName));
  end;
end;

procedure TData.AppendDataRequestParams(Request: TWebRequest; DataRequest: TDataRequest);
var
  i: Integer;
  ParamName: string;
  ParamValue: string;
begin

  for i := 0 to DataRequest.Params.Count - 1 do
  begin
    ParamName := DataRequest.Params.Names[i];
    ParamValue := DataRequest.Params.ValueFromIndex[i];
    Request.AddParam(ParamName, ParamValue);
  end;
end;

procedure TData.SetParam(Param: TFDParam; const Value: string);
begin

  if Value.IsEmpty then
    Param.Clear
  else
    if Value = '(?)' then // DevExtreme
      Param.Clear
    else
      if Param.DataType = ftDate then
        Param.Value := DateISO.StringToDate(Value)
      else
        if Param.DataType = ftTime then
          Param.Value := DateISO.StringToTime(Value)
        else
          if Param.DataType in [ftDateTime, ftTimeStamp] then
            Param.Value := DateISO.StringToDateTime(Value)
          else
            inherited;
end;

procedure TData.AppendDataRequestKeys(Request: TWebRequest; DataRequest: TDataRequest; DataSet: TFDQuery; const TableName, PK: string);
var
  i: Integer;
  KeyList, ValueList: TStringList;
  ParamPrefix: string;
  ParamName: string;
  ParamValue: string;
  FullParamName: string;
begin

  if DataRequest.KeyValues.IsEmpty then
    Exit;

  KeyList := TStringList.Create;
  try
    ValueList := TStringList.Create;
    try
      KeyList.Delimiter := ',';
      ValueList.Delimiter := KeyList.Delimiter;
      KeyList.DelimitedText := PK;
      ValueList.DelimitedText := DataRequest.KeyValues;

      for i := 0 to KeyList.Count - 1 do
        if i < ValueList.Count then
        begin
          ParamName := KeyList[i];
          ParamValue := ValueList[i].Replace('=', '');

          if not TableName.IsEmpty then
            FullParamName := TableName + '.' + ParamName
          else
            FullParamName := ParamName;

          Request.AddParam(ParamName, ParamValue);

          if not assigned(DataSet.FindParam(ParamName)) then
            DataSet.SQL.Text := fib.SqlTxtRtns.AddToWhereClause(DataSet.SQL.Text, FullParamName + '=:' + ParamName, true);
        end;
    finally
      FreeAndNil(ValueList);
    end;
  finally
    FreeAndNil(KeyList);
  end;
end;

procedure TData.DataRequest(ctx: TzContext);
var
  DataRequest: TDataRequest;
  DataSet: TFDQuery;
  Field: TField;
  i: Integer;
  o: TJSONObject;
  Param: TFDParam;
  ParamName: string;
  ParamValue: string;
  RowsTo: string;

  function GetRowsTo(DataRequest: TDataRequest): String;
  var
    rows_, to_: Integer;
  begin
    Result := '';

    if DataRequest.PageSize > 0 then
    begin
      rows_ := DataRequest.PageSize * DataRequest.PageNum;
      to_ := DataRequest.PageSize * (DataRequest.PageNum + 1);
      Result := ' ROWS ' + rows_.ToString + ' TO ' + to_.ToString;
    end;
  end;

begin
  SiMain.EnterMethod('DataRequest');

  DataRequest := ctx.Request.DataRequest;
  try
    // rendere obbligatorio dopo i test
    if assigned(DataRequest) then
    begin
      SiMain.LogColored(TColors.Yellow, 'DataRequest-' + DataRequest.RequestType.AsString);
      SiMain.LogString(TWebRequest.identDataRequest, ctx.Request.ParamByName(TWebRequest.identDataRequest));
      SiMain.LogObject(TWebRequest.identDataRequest, DataRequest);

      AppendDataRequestParams(ctx.Request, DataRequest);

      case DataRequest.RequestType of
        rtMeta:
          doFields(DataRequest, ctx);
        rtCommand:
          doCommand(DataRequest, ctx);
        rtSelect:
          doSelect(DataRequest, ctx);
        rtInsert:
          doInsert(DataRequest, ctx);
        rtUpdate:
          doUpdate(DataRequest, ctx);
        rtDelete:
          doDelete(DataRequest, ctx);
        rtCount:
          doCount(DataRequest, ctx);
        rtExexSP:
          doExecSP(DataRequest, ctx);
      end;
    end
    else
      SiMain.LogVerbose('DataRequest non assegnata.');
  finally
    FreeAndNil(DataRequest);
  end;

  SiMain.leaveMethod('DataRequest');
end;

function TData.SqlTypeStr(SQLKind: TSQLKind): string;
begin
  Result := '';

  case SQLKind of
    skFields:
      Result := 'fields';
    skSelect:
      Result := 'select';
    skInsert:
      Result := 'insert';
    skUpdate:
      Result := 'update';
    skDelete:
      Result := 'delete';
    skCount:
      Result := 'count';
    skCommand:
      Result := 'command';
  end;
end;

procedure TData.doFields(DataRequest: TDataRequest; ctx: TzContext);
var
  FileName: string;
  s: string;
  j: TJsonValue;
begin
  SiMain.EnterMethod('doFields');

  FileName := sqlFileName(DataRequest.App, DataRequest.dm, DataRequest.Name, SqlTypeStr(skFields));

  // se non esiste il file lo crea
  if not TFile.Exists(FileName) then
    CreateFieldsFile(DataRequest, ctx);

  if not TFile.Exists(FileName) then
    ctx.Response.RenderError('Fields non trovato: ' + ExtractFileName(FileName), -1)
  else
  begin
    s := TFile.ReadAllText(FileName);
    SiMain.LogString(FileName, s);

    j := TJSONObject.ParseJSONValue(s);

    ctx.Response.Render(true, j);
  end;

  SiMain.leaveMethod('doFields');
end;

function TData.GetFieldOrigin(DataSet: TFDQuery; Field: TField): string;
var
  Column: TFDDatSColumn;
  Alias: string;
  TableName: string;
  FieldName: string;
  tmp: string;
begin
  Result := '';

  if not assigned(Field) then
    Exit;

  if assigned(Field) then
    if assigned(DataSet.Table) then
      if DataSet.Table.Columns.IndexOfName(Field.FieldName) <> -1 then
      begin
        Column := DataSet.Table.Columns.ColumnByName(Field.FieldName);

        if assigned(Column) then
        begin
          FieldName := Column.OriginColName;
          TableName := Column.OriginTabName;

          if TableName.IsEmpty then // parse dell'sql
          begin
            tmp := fib.SqlTxtRtns.FieldNameFromSelect(DataSet.SQL.Text, Field.FieldName);

            if tmp.Contains('.') then
              TableName := tmp.Substring(0, tmp.IndexOf('.'));
          end;

          if ((TableName = '') or (FieldName = '')) then
            Result := TableName + FieldName
          else
            Result := TableName + '.' + FieldName;
        end;
      end;

  // Per i campi calcolati
  if Result.IsEmpty then
  begin
    Result := Field.FieldName;

    if Pos('.', Result) = 0 then
      if not TableName.IsEmpty then
        Result := TableName + '.' + Result;
  end;
end;

function TData.GetFieldTableName(DataSet: TFDQuery; Field: TField): string;
var
  Origin: string;
begin
  Assert(assigned(Field));

  Result := '';

  if assigned(Field) then
    if assigned(DataSet.Table) then
      if DataSet.Table.Columns.IndexOfName(Field.FieldName) <> -1 then
        Result := DataSet.Table.Columns.ColumnByName(Field.FieldName).OriginTabName;

  if Result.IsEmpty then
  begin
    Origin := GetFieldOrigin(DataSet, Field);
    if not Origin.IsEmpty then
      Result := System.Copy(Origin, 1, Pos('.', Origin) - 1);
  end;
end;

procedure TData.CreateFieldsFile(DataRequest: TDataRequest; ctx: TzContext);
var
  FileName: string;
  DataSet: TFDQuery;
  MetaDataSet: TFDQuery;
  a: TJsonArray;
  SQL, TableName, PK: string;
  i: Integer;
  JSONObject, lookupObj: TJSONObject;
  FieldName: string;
begin
  SiMain.EnterMethod('CreateFieldsFile');

  FileName := sqlFileName(DataRequest.App, DataRequest.dm, DataRequest.Name, SqlTypeStr(skFields));

  if FileExists(FileName) then
    Exit;

  Connect(ctx);
  try
    DataSet := CreateDataSet;
    try
      LoadSQL(DataRequest, skSelect, SQL, TableName, PK);
      DataSet.SQL.Text := SQL;

      Prepare(ctx.Request, DataSet);

      DataSet.Active := true;
      try
        // deve creare i fields, occorre aprire il dataset
        a := TJsonEngine.MetadataToJSON(DataSet, true);
      finally
        DataSet.Active := false;
      end;
    finally
      FreeAndNil(DataSet);
    end;

    /// ///////////////////////////////////////////////////////////
    // Aggiunta di eventuali lookup
    TableName := GetTableNameFromSQL(SQL);

    if not TableName.IsEmpty then
    begin
      try
        MetaDataSet := CreateDataSet;
        try
          MetaDataSet.SQL.Text := GetSQLFK;
          SiMain.LogStringList('MetaDataSet', MetaDataSet.SQL);
          MetaDataSet.Prepare;
          MetaDataSet.ParamByName('TABLENAME').AsString := TableName;

          for i := 0 to a.Count - 1 do
          begin
            JSONObject := TJSONObject(a[i]);

            FieldName := JSONObject.GetValue<string>('FieldName');

            MetaDataSet.Active := false;
            MetaDataSet.ParamByName('FIELDNAME').AsString := FieldName;

            MetaDataSet.Active := true;
            try
              if not MetaDataSet.IsEmpty then
              begin
                lookupObj := TJSONObject.Create;
                lookupObj.AddPair('dm', DataRequest.dm);
                lookupObj.AddPair('dataset', MetaDataSet.FieldByName('CONSTRAINT_NAME').AsString);
                lookupObj.AddPair('key', MetaDataSet.FieldByName('FK_KEY_FIELD').AsString);
                lookupObj.AddPair('columns', MetaDataSet.FieldByName('COLUMNS').AsString);

                lookupObj.AddPair('displayExpr', FieldName);
                lookupObj.AddPair('valueExpr', FieldName);
                lookupObj.AddPair('fieldMappings', MetaDataSet.FieldByName('FIELD_MAPPINGS').AsString);

                JSONObject.AddPair('lookup', lookupObj);
              end;
            finally
              MetaDataSet.Active := false;
            end;
          end;
        finally
          FreeAndNil(MetaDataSet);
        end;
      except
        // casi di errori nella GetSQLFK, ad esempio se coinvolgono proc o altro
      end;
    end;
  finally
    Disconnect;
  end;

  TFile.WriteAllText(FileName, a.Format(4));

  SiMain.leaveMethod('CreateFieldsFile');
end;

function TData.GetSQLFK: string;
begin
  Result := '';
  Result := Result + 'SELECT FIRST 1' + #13;
  Result := Result + '    A.RDB$CONSTRAINT_NAME CONSTRAINT_NAME,' + #13;
  Result := Result + '    A.RDB$RELATION_NAME TABLE_NAME,' + #13;
  Result := Result + '    D.RDB$FIELD_NAME FK_KEY_FIELD,' + #13;
  Result := Result + '    (SELECT LIST(TRIM(D.RDB$FIELD_NAME), ' + #13 + ';' + #13 + ')' + #13;
  Result := Result + '     FROM RDB$INDEX_SEGMENTS D' + #13;
  Result := Result + '         INNER JOIN RDB$INDEX_SEGMENTS E ON A.RDB$INDEX_NAME = E.RDB$INDEX_NAME AND' + #13;
  Result := Result + '                                            D.RDB$FIELD_POSITION = E.RDB$FIELD_POSITION' + #13;
  Result := Result + '     WHERE' + #13;
  Result := Result + '       C.RDB$INDEX_NAME = D.RDB$INDEX_NAME) COLUMNS,' + #13;
  Result := Result + '    (SELECT' + #13;
  Result := Result + '         LIST(TRIM(E.RDB$FIELD_NAME) || ' + #39 + '=' + #39 + ' || TRIM(D.RDB$FIELD_NAME), ' + #39 + ';' + #39 + ')' + #13;
  Result := Result + '     FROM' + #13;
  Result := Result + '         RDB$INDEX_SEGMENTS D' + #13;
  Result := Result + '               INNER JOIN RDB$INDEX_SEGMENTS E ON A.RDB$INDEX_NAME = E.RDB$INDEX_NAME AND' + #13;
  Result := Result + '                     D.RDB$FIELD_POSITION = E.RDB$FIELD_POSITION' + #13;
  Result := Result + '     WHERE' + #13;
  Result := Result + '         C.RDB$INDEX_NAME = D.RDB$INDEX_NAME) FIELD_MAPPINGS' + #13;
  Result := Result + 'FROM' + #13;
  Result := Result + '    RDB$RELATION_CONSTRAINTS A' + #13;
  Result := Result + '          INNER JOIN RDB$REF_CONSTRAINTS B ON A.RDB$CONSTRAINT_NAME = B.RDB$CONSTRAINT_NAME' + #13;
  Result := Result + '          INNER JOIN RDB$RELATION_CONSTRAINTS C ON B.RDB$CONST_NAME_UQ = C.RDB$CONSTRAINT_NAME' + #13;
  Result := Result + '' + #13;
  Result := Result + '          INNER JOIN RDB$INDEX_SEGMENTS D ON C.RDB$INDEX_NAME = D.RDB$INDEX_NAME' + #13;
  Result := Result + '          INNER JOIN RDB$INDEX_SEGMENTS E ON A.RDB$INDEX_NAME = E.RDB$INDEX_NAME AND' + #13;
  Result := Result + '                D.RDB$FIELD_POSITION = E.RDB$FIELD_POSITION' + #13;
  Result := Result + 'WHERE' + #13;
  Result := Result + '    A.RDB$RELATION_NAME = :TABLENAME AND' + #13;
  Result := Result + '    E.RDB$FIELD_NAME = :FIELDNAME AND' + #13;
  Result := Result + '    A.RDB$CONSTRAINT_TYPE = ' + #39 + 'FOREIGN KEY' + #39;
end;

procedure TData.LoadDataSet(const App, DataModule, DataSetName: String; out TableName, PK: string);
var
  FileName: string;
  StringList: TStringList;
begin
  TableName := '';
  PK := '';

  FileName := datasetFileName(App, DataModule, DataSetName);

  if not FileExists(FileName) then
    Exit;

  StringList := TStringList.Create;
  try
    StringList.LoadFromFile(FileName);

    TableName := StringList.Values['TableName'];
    PK := StringList.Values['PK'];
  finally
    FreeAndNil(StringList);
  end;
end;

procedure TData.SaveDataSet(const App, DataModule, DataSetName, TableName, PK: string);
var
  FileName: string;
  StringList: TStringList;
begin
  FileName := datasetFileName(App, DataModule, DataSetName);

  StringList := TStringList.Create;
  try
    StringList.AddPair('TableName', TableName);
    StringList.AddPair('PK', PK);
    StringList.SaveToFile(FileName);
  finally
    FreeAndNil(StringList);
  end;
end;

function TData.metaFolder(const App, DataModuleName: String; const SubFolder: string; const ForceDir: boolean): string;
  function AddFolder(const BaseFolder, SubFolder: string; const ForceDir: boolean = false): string;
  begin
    Result := IncludeTrailingPathDelimiter(BaseFolder);
    SiMain.LogString('Folder', Result);

    if ForceDir then
      ForceDirectories(Result);

    if not SubFolder.IsEmpty then
    begin
      Result := IncludeTrailingPathDelimiter(Result + SubFolder);
      SiMain.LogString('SubFolder', Result);

      if ForceDir then
        ForceDirectories(Result);
    end;
  end;

begin
  Result := TFolders.SubFolder(ConfigProps.CartellaFiles, 'meta');

  if ForceDir then
    ForceDirectories(Result);

  Result := AddFolder(Result, App, ForceDir);
  Result := AddFolder(Result, DataModuleName, ForceDir);

  if not SubFolder.IsEmpty then
    Result := AddFolder(Result, SubFolder, ForceDir);
end;

function TData.sqlFileName(const App, DataModule, DataSetName, sqlType: string): string;
begin
  Result := '';

  if App = '' then
    raise Exception.Create('App non specificata.');

  if DataModule = '' then
    raise Exception.Create('DataModule non specificato.');

  if DataSetName = '' then
    raise Exception.Create('DataSet non specificato.');

  Result := metaFolder(App, DataModule, '', false) + DataSetName + '.' + sqlType + '.sql';
end;

/// ////////////////////////////////////////////////////////////////////////////

procedure TData.InternalLoadDataset(ctx: TzContext; datasetRequest: TDatasetRequest);
var
  StoredProc: TFDStoredProc;
  x: TX;
begin

  /// /////////////////////////////////////////////////////////////

  if datasets.TryGetValue(DatasetKey(datasetRequest.dm, datasetRequest.DataSet), x) then
  begin
    { TODO : datasetRequest.FromX(X); }
    // datasetRequest.FromX(X);
    // exit;
  end;

  /// //////////////////////////////////////////////////////////////////////////

  Connect(ctx);
  try
    StoredProc := CreateStoredProc('ZZ_DATASETS_GET');
    try
      StoredProc.Prepare;
      if StoredProc.ParamByName('PARAM_APP') <> nil then
        StoredProc.ParamByName('PARAM_APP').AsString := ctx.App;
      StoredProc.ParamByName('PARAM_DATAMODULE').AsString := datasetRequest.dm;
      StoredProc.ParamByName('PARAM_DATASET').AsString := datasetRequest.DataSet;
      StoredProc.ExecProc;

      datasetRequest.RelationName := StoredProc.ParamByName('RELATION_NAME').AsString;
      datasetRequest.PK := StoredProc.ParamByName('PK_FIELDS').AsString;
      // datasetRequest.Fields.Text := StoredProc.ParamByName('PARAM_DATASET').Value;
      datasetRequest.CanInsert := StoredProc.ParamByName('CAN_INSERT').asBoolean;
      datasetRequest.CanUpdate := StoredProc.ParamByName('CAN_UPDATE').asBoolean;
      datasetRequest.CanDelete := StoredProc.ParamByName('CAN_DELETE').asBoolean;
      datasetRequest.SelectSql.Text := StoredProc.ParamByName('SQL_SELECT').AsString;
      datasetRequest.InsertSql.Text := StoredProc.ParamByName('SQL_INSERT').AsString;
      datasetRequest.UpdateSql.Text := StoredProc.ParamByName('SQL_UPDATE').AsString;
      datasetRequest.DeleteSql.Text := StoredProc.ParamByName('SQL_DELETE').AsString;
      datasetRequest.CountSql.Text := StoredProc.ParamByName('SQL_COUNT').AsString;

      StoredProc.Close;
    finally
      FreeAndNil(StoredProc);
    end;
  finally
    Disconnect;
  end;

  /// //////////////////////////////////////////////////////////////////////////
  { TODO : X:=TX.FromDatasetRequest(datasetRequest) }
  // X:=TX.FromDatasetRequest(datasetRequest)
  TMonitor.Enter(datasets);
  try
    datasets.add(DatasetKey(datasetRequest.dm, datasetRequest.DataSet), x);
  finally
    TMonitor.Exit(datasets);
  end;
end;

procedure TData.InternalSaveDataset(ctx: TzContext; datasetRequest: TDatasetRequest);
var
  StoredProc: TFDStoredProc;
  x: TX;
begin
  /// //////////////////////////////////////////////////////////////////////////

  if datasetRequest.RelationName.IsEmpty then
    datasetRequest.RelationName := Get_RelationNameFromSQL(datasetRequest.SelectSql.Text);

  if datasetRequest.SelectSql.Text.IsEmpty then
    if not datasetRequest.RelationName.IsEmpty then
      datasetRequest.SelectSql.Text := 'SELECT * FROM ' + datasetRequest.RelationName.ToUpper;

  /// //////////////////////////////////////////////////////////////////////////

  Connect(ctx);
  try
    StoredProc := CreateStoredProc('ZZ_DATASETS_ADD');
    try
      StoredProc.Prepare;
      StoredProc.ParamByName('APP').Value := ctx.App;
      StoredProc.ParamByName('DATAMODULE').Value := datasetRequest.dm;
      StoredProc.ParamByName('DATASET').Value := datasetRequest.DataSet;
      StoredProc.ParamByName('RELATION_NAME').Value := datasetRequest.RelationName;
      StoredProc.ParamByName('PK_FIELDS').Value := datasetRequest.PK;
      // StoredProc.ParamByName('PARAM_DATASET').Value := datasetRequest.Fields.Text;
      StoredProc.ParamByName('CAN_INSERT').Value := datasetRequest.CanInsert;
      StoredProc.ParamByName('CAN_UPDATE').Value := datasetRequest.CanUpdate;
      StoredProc.ParamByName('CAN_DELETE').Value := datasetRequest.CanDelete;
      StoredProc.ParamByName('SQL_SELECT').AsString := datasetRequest.SelectSql.Text;
      StoredProc.ParamByName('SQL_INSERT').AsString := datasetRequest.InsertSql.Text;
      StoredProc.ParamByName('SQL_UPDATE').AsString := datasetRequest.UpdateSql.Text;
      StoredProc.ParamByName('SQL_DELETE').AsString := datasetRequest.DeleteSql.Text;
      StoredProc.ParamByName('SQL_COUNT').AsString := datasetRequest.CountSql.Text;
      StoredProc.ExecProc;
      StoredProc.Close;
    finally
      FreeAndNil(StoredProc);
    end;
  finally
    Disconnect;
  end;

  /// //////////////////////////////////////////////////////////////////////////

  { TODO : X:=TX.FromDatasetRequest(datasetRequest) }
  // X:=TX.FromDatasetRequest(datasetRequest)

  TMonitor.Enter(datasets);
  try
    datasets.AddOrSetValue(DatasetKey(datasetRequest.dm, datasetRequest.DataSet), x);
  finally
    TMonitor.Exit(datasets);
  end;
end;

procedure TData.GetDataset(ctx: TzContext);
var
  datasetRequest: TDatasetRequest;
  JSONObject: TJSONObject;
begin
  SiMain.EnterMethod('GetDatasetRequest');

  if not ConfigProps.AllowMetaRequest then
  begin
    ctx.Response.RenderError('Metodo non riconosciuto.', -1);
    Exit;
  end;

  datasetRequest := ctx.Request.datasetRequest;
  try
    SiMain.LogColored(TColors.Yellow, 'GetDatasetRequest: ' + datasetRequest.dm + '.' + datasetRequest.DataSet);
    SiMain.LogObject(TWebRequest.identDataRequest, datasetRequest);

    /// /////////////////////////////////////////////////////////////

    InternalLoadDataset(ctx, datasetRequest);

    /// /////////////////////////////////////////////////////////////

    JSONObject := TDatasetRequest.Encode(datasetRequest);
    SiMain.LogString(TWebRequest.identDatasetRequest, JSONObject.ToJSON);
    ctx.Response.Render(JSONObject); // direttamente il json
  finally
    FreeAndNil(datasetRequest);
  end;

  SiMain.leaveMethod('GetDatasetRequest');
end;

procedure TData.SetDataset(ctx: TzContext);
var
  datasetRequest: TDatasetRequest;
begin
  SiMain.EnterMethod('SetDatasetRequest');

  if not ConfigProps.AllowMetaRequest then
  begin
    ctx.Response.RenderError('Metodo non riconosciuto.', -1);
    Exit;
  end;

  datasetRequest := ctx.Request.datasetRequest;
  try
    SiMain.LogColored(TColors.Yellow, 'GetSqlRequest: ' + datasetRequest.dm + '.' + datasetRequest.DataSet);
    SiMain.LogObject(TWebRequest.identDatasetRequest, datasetRequest);

    /// /////////////////////////////////////////////////////////////

    InternalSaveDataset(ctx, datasetRequest);

    /// /////////////////////////////////////////////////////////////

    ctx.Response.RenderOk;
  finally
    FreeAndNil(datasetRequest);
  end;

  SiMain.leaveMethod('SetDatasetRequest');
end;

function TData.Get_RelationNameFromSQL(SQL: string): string;
begin
  Result := '';

  if trim(SQL) = '' then
    Exit;

  Result := GetTableNameFromSQL(SQL.trim.ToUpper);
  Result := Result.trim.ToUpper();
end;

function TData.DatasetKey(dm, DataSet: string): string;
begin
  Result := dm + '.' + DataSet;
end;

initialization

RegisterClass(TData);

end.
