unit dmRequests;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
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
  lib.DataRequest,
  lib.Context,
  Route,
  Routes.Attributes;

type
  TRequests = class(TRoute)
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
    function datasetFileName(const App, DataModule, DataSetName: string): string;
    function optionsFileName(const App, DataModule, DataSetName, className: string; const placeHolder: boolean): string;
  public
    /// /////////////////
    [POST('data', pkJWT)]
    procedure DataRequest(ctx: TzContext);
    /// /////////////////
    // SQL

    [POST('getSql', pkJWT)]
    procedure GetSqlRequest(ctx: TzContext);
    [POST('setSql', pkJWT)]
    procedure SetSqlRequest(ctx: TzContext);

    /// /////////////////
    // OPTIONS

    [POST('getOptions', pkJWT)]
    procedure GetWidget(ctx: TzContext);
    [POST('setOptions', pkJWT)]
    procedure SetWidget(ctx: TzContext);
  end;

var
  Requests: TRequests;

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

function zzCapFirst(Value: string; ReplaceUnderScore: boolean): string;
var
  i: Integer;
  s: string;
begin
  Result := '';
  if trim(Value) = '' then
    Exit;
  s := uppercase(Value[1]);
  for i := 2 to length(Value) do
  begin
    if (Value[i - 1] in [' ', '_']) then
      s := s + uppercase(Value[i])
    else
      s := s + lowercase(Value[i]);
  end;

  if ReplaceUnderScore then
    s := StringReplace(s, '_', ' ', [rfReplaceAll]);
  Result := s;
end;

procedure TRequests.ExecuteSQL(const SQL: String; DataRequest: TDataRequest; ctx: TzContext);
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

procedure TRequests.doCommand(DataRequest: TDataRequest; ctx: TzContext);
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

procedure TRequests.doSelect(DataRequest: TDataRequest; ctx: TzContext);
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

      DataSet.SQL.Text := DataSet.SQL.Text + DataRequest.GetRowsTo;

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

procedure TRequests.doInsert(DataRequest: TDataRequest; ctx: TzContext);
var
  SQL, TableName, PK: string;
begin
  LoadSQL(DataRequest, skInsert, SQL, TableName, PK);
  ExecuteSQL(SQL, DataRequest, ctx);
end;

procedure TRequests.doUpdate(DataRequest: TDataRequest; ctx: TzContext);
var
  SQL, TableName, PK: string;
begin
  LoadSQL(DataRequest, skUpdate, SQL, TableName, PK);
  ExecuteSQL(SQL, DataRequest, ctx);
end;

procedure TRequests.doDelete(DataRequest: TDataRequest; ctx: TzContext);
var
  SQL, TableName, PK: string;
begin
  LoadSQL(DataRequest, skDelete, SQL, TableName, PK);
  ExecuteSQL(SQL, DataRequest, ctx);
end;

procedure TRequests.doCount(DataRequest: TDataRequest; ctx: TzContext);
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

procedure TRequests.doExecSP(DataRequest: TDataRequest; ctx: TzContext);
var
  StoredProcName: string;
begin
  StoredProcName := DataRequest.Name;
  ExecSP(StoredProcName, ctx);
end;

function TRequests.LoadSQL(DataRequest: TDataRequest; SQLKind: TSQLKind; out SQL, TableName, PK: string): String;
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

procedure TRequests.AppendDataRequestParams(Request: TWebRequest; DataRequest: TDataRequest);
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

procedure TRequests.SetParam(Param: TFDParam; const Value: string);
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

procedure TRequests.AppendDataRequestKeys(Request: TWebRequest; DataRequest: TDataRequest; DataSet: TFDQuery; const TableName, PK: string);
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

procedure TRequests.DataRequest(ctx: TzContext);
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

procedure TRequests.GetSqlRequest(ctx: TzContext);
var
  SqlRequest: TSqlRequest;
  JSONObject: TJSONObject;
  folder: string;
  FileName: string;
  PK: string;
  TableName: string;

  procedure LoadFile(const FileName: string; strings: TStrings);
  begin
    strings.Clear;

    if FileExists(FileName) then
      strings.LoadFromFile(FileName);
  end;

begin
  SiMain.EnterMethod('GetSqlRequest');

  if not ConfigProps.AllowMetaRequest then
  begin
    ctx.Response.RenderError('Metodo non riconosciuto.', -1);
    Exit;
  end;

  SqlRequest := ctx.Request.SqlRequest;
  try
    SiMain.LogColored(TColors.Yellow, 'GetSqlRequest: ' + SqlRequest.dm + '.' + SqlRequest.Name);
    SiMain.LogObject(TWebRequest.identSqlRequest, SqlRequest);

    /// /////////////////////////////////////////////////////////////
    // non deve provare a crearla se non esiste, siamo in get
    folder := metaFolder(SqlRequest.App, SqlRequest.dm, '', false);

    /// /////////////////////////////////////////////////////////////
    ///
    LoadDataSet(SqlRequest.App, SqlRequest.dm, SqlRequest.Name, TableName, PK);
    SqlRequest.TableName := TableName;
    SqlRequest.PK := PK;
    ///
    /// /////////////////////////////////////////////////////////////

    FileName := sqlFileName(SqlRequest.App, SqlRequest.dm, SqlRequest.Name, SqlTypeStr(skFields));
    LoadFile(FileName, SqlRequest.Fields);

    FileName := sqlFileName(SqlRequest.App, SqlRequest.dm, SqlRequest.Name, SqlTypeStr(skSelect));
    LoadFile(FileName, SqlRequest.selectSql);

    FileName := sqlFileName(SqlRequest.App, SqlRequest.dm, SqlRequest.Name, SqlTypeStr(skInsert));
    LoadFile(FileName, SqlRequest.InsertSql);

    FileName := sqlFileName(SqlRequest.App, SqlRequest.dm, SqlRequest.Name, SqlTypeStr(skUpdate));
    LoadFile(FileName, SqlRequest.UpdateSql);

    FileName := sqlFileName(SqlRequest.App, SqlRequest.dm, SqlRequest.Name, SqlTypeStr(skDelete));
    LoadFile(FileName, SqlRequest.DeleteSql);

    FileName := sqlFileName(SqlRequest.App, SqlRequest.dm, SqlRequest.Name, SqlTypeStr(skCount));
    LoadFile(FileName, SqlRequest.CountSql);

    /// /////////////////////////////////////////////////////////////

    JSONObject := TSqlRequest.Encode(SqlRequest);
    SiMain.LogString(TWebRequest.identSqlRequest, JSONObject.ToJSON);
    ctx.Response.Render(true, JSONObject);
  finally
    FreeAndNil(SqlRequest);
  end;

  SiMain.leaveMethod('GetSqlRequest');
end;

procedure TRequests.SetSqlRequest(ctx: TzContext);
var
  SqlRequest: TSqlRequest;
  JSONObject: TJSONObject;
  folder: string;
  FileName: string;

  procedure SaveFile(const FileName: string; strings: TStrings);
  begin

    if strings.Count = 0 then
    begin
      if TFile.Exists(FileName) then
        TFile.Delete(FileName);
    end
    else
      strings.SaveToFile(FileName);
  end;

begin
  SiMain.EnterMethod('SetSqlRequest');

  if not ConfigProps.AllowMetaRequest then
  begin
    ctx.Response.RenderError('Metodo non riconosciuto.', -1);
    Exit;
  end;

  SqlRequest := ctx.Request.SqlRequest;
  try
    SiMain.LogColored(TColors.Yellow, 'GetSqlRequest: ' + SqlRequest.dm + '.' + SqlRequest.Name);
    SiMain.LogObject(TWebRequest.identSqlRequest, SqlRequest);

    /// /////////////////////////////////////////////////////////////

    folder := metaFolder(SqlRequest.App, SqlRequest.dm, '', true); // crearla se non esiste, siamo in Set

    /// /////////////////////////////////////////////////////////////
    ///
    SaveDataSet(SqlRequest.App, SqlRequest.dm, SqlRequest.Name, SqlRequest.TableName, SqlRequest.PK);
    ///
    /// /////////////////////////////////////////////////////////////

    FileName := sqlFileName(SqlRequest.App, SqlRequest.dm, SqlRequest.Name, SqlTypeStr(skSelect));
    SaveFile(FileName, SqlRequest.selectSql);

    FileName := sqlFileName(SqlRequest.App, SqlRequest.dm, SqlRequest.Name, SqlTypeStr(skInsert));
    SaveFile(FileName, SqlRequest.InsertSql);

    FileName := sqlFileName(SqlRequest.App, SqlRequest.dm, SqlRequest.Name, SqlTypeStr(skUpdate));
    SaveFile(FileName, SqlRequest.UpdateSql);

    FileName := sqlFileName(SqlRequest.App, SqlRequest.dm, SqlRequest.Name, SqlTypeStr(skDelete));
    SaveFile(FileName, SqlRequest.DeleteSql);

    FileName := sqlFileName(SqlRequest.App, SqlRequest.dm, SqlRequest.Name, SqlTypeStr(skCount));
    SaveFile(FileName, SqlRequest.CountSql);

    /// /////////////////////////////////////////////////////////////

    ctx.Response.RenderOk;
  finally
    FreeAndNil(SqlRequest);
  end;

  SiMain.leaveMethod('SetSqlRequest');
end;

procedure TRequests.GetWidget(ctx: TzContext);
var
  WidgetProps: TWidgetProps;
  JSONObject: TJSONObject;
  FileName: string;
  placeHolder: string;
  s: string;
begin
  SiMain.EnterMethod('GetOptionsRequest');

  if not ConfigProps.AllowMetaRequest then
  begin
    ctx.Response.RenderError('Metodo non riconosciuto.', -1);
    Exit;
  end;

  WidgetProps := ctx.Request.WidgetProps;
  try
    SiMain.LogColored(TColors.Yellow, 'GetOptionsRequest: ' + WidgetProps.dm + '.' + WidgetProps.id);
    SiMain.LogObject(TWebRequest.identOptionsRequest, WidgetProps);

    /// /////////////////////////////////////////////////////////////

    // non deve provare a crearla se non esiste, siamo in get
    FileName := optionsFileName(WidgetProps.App, WidgetProps.dm, WidgetProps.id, WidgetProps.className, false);

    SiMain.LogString('FileName', FileName);

    if FileExists(FileName) then
      TFile.ReadAllText(FileName)
    else
    begin
      SiMain.LogVerbose(FileName + ' non trovato.');
      WidgetProps.options := '';

      // verifica che esista la cartella
      placeHolder := optionsFileName(WidgetProps.App, WidgetProps.dm, WidgetProps.id, WidgetProps.widget, true);
      TFile.WriteAllText(placeHolder, '{}');
    end;

    /// /////////////////////////////////////////////////////////////

    JSONObject := TWidgetProps.Encode(WidgetProps);
    SiMain.LogString(TWebRequest.identOptionsRequest, JSONObject.ToJSON);
    ctx.Response.Render(true, JSONObject);
  finally
    FreeAndNil(WidgetProps);
  end;

  SiMain.leaveMethod('GetOptionsRequest');
end;

procedure TRequests.SetWidget(ctx: TzContext);
var
  WidgetProps: TWidgetProps;
  JSONObject: TJSONObject;
  FileName: string;
begin
  SiMain.EnterMethod('SetOptionsRequest');

  if not ConfigProps.AllowMetaRequest then
  begin
    ctx.Response.RenderError('Metodo non riconosciuto.', -1);
    Exit;
  end;

  WidgetProps := ctx.Request.WidgetProps;
  try
    SiMain.LogColored(TColors.Yellow, 'SetOptionsRequest: ' + WidgetProps.dm + '.' + WidgetProps.id);
    SiMain.LogObject(TWebRequest.identOptionsRequest, WidgetProps);

    /// /////////////////////////////////////////////////////////////

    FileName := optionsFileName(WidgetProps.App, WidgetProps.dm, WidgetProps.id, WidgetProps.widget, false);

    if WidgetProps.options.IsEmpty then
    begin
      if TFile.Exists(FileName) then
        TFile.Delete(FileName);
    end
    else
      TFile.WriteAllText(FileName, WidgetProps.options);

    /// /////////////////////////////////////////////////////////////

    ctx.Response.RenderOk;
  finally
    FreeAndNil(WidgetProps);
  end;

  SiMain.leaveMethod('SetOptionsRequest');
end;

function TRequests.SqlTypeStr(SQLKind: TSQLKind): string;
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

procedure TRequests.doFields(DataRequest: TDataRequest; ctx: TzContext);
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

function TRequests.GetFieldOrigin(DataSet: TFDQuery; Field: TField): string;
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

function TRequests.GetFieldTableName(DataSet: TFDQuery; Field: TField): string;
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

procedure TRequests.CreateFieldsFile(DataRequest: TDataRequest; ctx: TzContext);
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

function TRequests.GetSQLFK: string;
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

procedure TRequests.LoadDataSet(const App, DataModule, DataSetName: String; out TableName, PK: string);
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

procedure TRequests.SaveDataSet(const App, DataModule, DataSetName, TableName, PK: string);
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

function TRequests.metaFolder(const App, DataModuleName: String; const SubFolder: string; const ForceDir: boolean): string;
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

function TRequests.sqlFileName(const App, DataModule, DataSetName, sqlType: string): string;
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

function TRequests.datasetFileName(const App, DataModule, DataSetName: string): string;
begin
  Result := '';

  if App = '' then
    raise Exception.Create('App non specificata.');

  if DataModule = '' then
    raise Exception.Create('DataModule non specificato.');

  if DataSetName = '' then
    raise Exception.Create('DataSet non specificato.');

  Result := ChangeFileExt(metaFolder(App, DataModule, '', false) + DataSetName, '.ini');
end;

function TRequests.optionsFileName(const App, DataModule, DataSetName, className: string; const placeHolder: boolean): string;
var
  folder: string;
begin
  Result := '';

  if App = '' then
    raise Exception.Create('App non specificata.');

  if DataModule = '' then
    raise Exception.Create('DataModule non specificato.');

  if DataSetName = '' then
    raise Exception.Create('DataSet non specificato.');

  if className = '' then
    raise Exception.Create('ClassName non specificata.');

  /// ///

  folder := metaFolder(App, DataModule, DataSetName, placeHolder);

  if placeHolder then
    Result := IncludeTrailingBackslash(folder) + '___' + DataSetName + '.' + className + '.json'
  else
    Result := IncludeTrailingBackslash(folder) + DataSetName + '.' + className + '.json';
end;

initialization

RegisterClass(TRequests);

end.
