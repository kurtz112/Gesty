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
  lib.DataRequest,
  lib.datasetProps,
  lib.Context,
  Route,
  Routes.Attributes;

type

  [Path('api/data')]
  TData = class(TRoute)
  private type
    TSQLKind = (skFields, skSelect, skInsert, skUpdate, skDelete, skCount, skCommand);
  private // Ok
    function Get_RelationNameFromSQL(SQL: string): string;
  private // eliminare
    function SqlTypeStr(SQLKind: TSQLKind): string; // usato da doCommand
    procedure ExecuteSQL(const SQL: String; DataRequest: TDataRequest; ctx: TzContext; useOpen: boolean = false); // usato da doCommand
  protected
    procedure aSetParam(Param: TFDParam; const Value: string);
  private
    function GetFieldOrigin(DataSet: TFDQuery; Field: TField): string;
  private
    procedure CheckSessioneAttiva(ctx: TzContext);
  private
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
    procedure PrepareDatasetForSelect(ctx: TzContext; DataRequest: TDataRequest; datasetProps: TDatasetProps; DataSet: TFDQuery);
  private
    function metaFolder(const App, DataModuleName: String; const SubFolder: string; const ForceDir: boolean): string;
    function sqlFileName(const App, DataModule, DataSetName, sqlType: string): string;
  private
    function getMeta(datasetProps: TDatasetProps): TJSONObject;
  private
    /// /////////////////
    ///
    procedure InternalLoadFields(datasetProps: TDatasetProps);
    function InternalLoadDataset(ctx: TzContext; const dm, DataSet: string; const LoadFields: boolean = false): TDatasetProps;
    procedure InternalSaveDataset(ctx: TzContext; const datasetProps: TDatasetProps);
  public
    /// /////////////////

    [POST('getDataset', pkJWT)]
    procedure GetDataset(ctx: TzContext);

    [POST('setDataset', pkJWT)]
    procedure SetDataset(ctx: TzContext);

    [POST('setFields', pkJWT)]
    procedure SetFields(ctx: TzContext);

  public
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
  lib.DateISO,
  Server_Module,
  dmMeta;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

type
  TFDQueryAccess = class(TFDQuery);

procedure TData.ExecuteSQL(const SQL: String; DataRequest: TDataRequest; ctx: TzContext; useOpen: boolean = false);
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
    startTrans;
    try
      CheckSessioneAttiva(ctx);

      Command := CreateCommand(SQL);
      try
        /// ///////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////
        // Con EXECUTE PROCEDURE non usare RETURNING
        Prepare(ctx.Request, Command);

        if useOpen then
          Command.Open
        else
          Command.Execute;

        ctx.Response.Render(Command);
      finally
        FreeAndNil(Command);
      end;

      Commit;
    except
      on e: Exception do
        Rollback;
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

function TData.getMeta(datasetProps: TDatasetProps): TJSONObject;
var
  fields: TJSONArray;
begin
  result := TJSONObject.Create;
  try
    result.AddPair('canInsert', datasetProps.CanInsert);
    result.AddPair('canUpdate', datasetProps.CanUpdate);
    result.AddPair('canDelete', datasetProps.CanDelete);

    // al primo accesso non carica correttamente i fields
    if datasetProps.fields.Count = 0 then
      InternalLoadFields(datasetProps);

    fields := datasetProps.fields.asJSON;
    result.AddPair('fields', fields)
  except
    on e: Exception do
    begin
      result.free;
      raise;
    end;
  end;
end;

procedure TData.PrepareDatasetForSelect(ctx: TzContext; DataRequest: TDataRequest; datasetProps: TDatasetProps; DataSet: TFDQuery);
var
  SQL: string;
begin
  SQL := datasetProps.SelectSql.Text;

  if not datasetProps.IsEmptyDataset then // nel caso di RDB$DATABASE aggiungerebbe l'id del dataset
  begin
    if not DataRequest.KeyValues.IsEmpty then
      AppendDataRequestKeys(ctx.Request, DataRequest, DataSet, datasetProps.RelationName, datasetProps.PK);

    if not DataRequest.Filter.IsEmpty then
      SQL := fib.SqlTxtRtns.AddToWhereClause(SQL, DataRequest.Filter, true);

    if not DataRequest.Sort.IsEmpty then
      SQL := fib.SqlTxtRtns.SetOrderClause(SQL, DataRequest.Sort);

    SQL := SQL + DataRequest.GetRowsTo;
  end;

  DataSet.SQL.Text := SQL;

  Prepare(ctx.Request, DataSet);
end;

procedure TData.doSelect(DataRequest: TDataRequest; ctx: TzContext);
var
  DataSet: TFDQuery;
  datasetProps: TDatasetProps;
  meta: TJSONObject;
begin
  datasetProps := InternalLoadDataset(ctx, DataRequest.dm, DataRequest.Name, DataRequest.meta);

  // assegnare i parametri, sort, filter
  Connect(ctx);
  try
    CheckSessioneAttiva(ctx);

    DataSet := CreateDataSet;
    try
      PrepareDatasetForSelect(ctx, DataRequest, datasetProps, DataSet);

      DataSet.Active := true;
      try

        if DataRequest.meta then
        begin
          meta := getMeta(datasetProps);

          ctx.Response.Render(DataSet, [j2doDateISO], meta);
        end
        else
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

  siMain.LogColored(tColors.Firebrick, DatasetKey(DataRequest.dm, DataRequest.Name));
end;

procedure TData.doInsert(DataRequest: TDataRequest; ctx: TzContext);
var
  datasetProps: TDatasetProps;
begin
  datasetProps := InternalLoadDataset(ctx, DataRequest.dm, DataRequest.Name);
  ExecuteSQL(datasetProps.InsertSql.Text, DataRequest, ctx, true);
end;

procedure TData.doUpdate(DataRequest: TDataRequest; ctx: TzContext);
var
  datasetProps: TDatasetProps;
begin
  datasetProps := InternalLoadDataset(ctx, DataRequest.dm, DataRequest.Name);
  ExecuteSQL(datasetProps.UpdateSql.Text, DataRequest, ctx, true);
end;

procedure TData.doDelete(DataRequest: TDataRequest; ctx: TzContext);
var
  datasetProps: TDatasetProps;
begin
  datasetProps := InternalLoadDataset(ctx, DataRequest.dm, DataRequest.Name);
  ExecuteSQL(datasetProps.DeleteSql.Text, DataRequest, ctx);
end;

procedure TData.doCount(DataRequest: TDataRequest; ctx: TzContext);
var
  DataSet: TFDQuery;
  datasetProps: TDatasetProps;
  totalCount: Integer;
begin
  datasetProps := InternalLoadDataset(ctx, DataRequest.dm, DataRequest.Name);

  Connect(ctx);
  try
    CheckSessioneAttiva(ctx);

    DataSet := CreateDataSet;
    try

      if not datasetProps.CountSql.Text.IsEmpty then
        DataSet.SQL.Text := datasetProps.CountSql.Text
      else
        DataSet.SQL.Text := fib.SqlTxtRtns.CountSelect(datasetProps.SelectSql.Text);

      if not DataRequest.KeyValues.IsEmpty then
        AppendDataRequestKeys(ctx.Request, DataRequest, DataSet, datasetProps.RelationName, datasetProps.PK);

      Prepare(ctx.Request, DataSet);

      if not DataRequest.Filter.IsEmpty then
        DataSet.SQL.Text := fib.SqlTxtRtns.AddToWhereClause(DataSet.SQL.Text, DataRequest.Filter, true);

      if not DataRequest.Sort.IsEmpty then
        DataSet.SQL.Text := fib.SqlTxtRtns.SetOrderClause(DataSet.SQL.Text, DataRequest.Sort);

      DataSet.Active := true;
      try
        totalCount := DataSet.fields[0].AsInteger;
      finally
        DataSet.Active := false;
      end;

      { TODO : da rivedere il metodo di restituzione del dato, al momento la select risponde con -1 }
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

procedure TData.aSetParam(Param: TFDParam; const Value: string);
begin

  if Value.IsEmpty or Value.Equals('null') or Value.Equals('(?)') then
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
begin
  siMain.EnterMethod('DataRequest');

  DataRequest := ctx.Request.DataRequest;
  try
    // rendere obbligatorio dopo i test
    if assigned(DataRequest) then
    begin
      siMain.LogColored(tColors.Yellow, 'DataRequest-' + DataRequest.RequestType.AsString);
      siMain.LogString(TWebRequest.identDataRequest, ctx.Request.ParamByName(TWebRequest.identDataRequest));
      siMain.LogObject(TWebRequest.identDataRequest, DataRequest);

      AppendDataRequestParams(ctx.Request, DataRequest);

      case DataRequest.RequestType of
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
      siMain.LogVerbose('DataRequest non assegnata.');
  finally
    FreeAndNil(DataRequest);
  end;

  siMain.leaveMethod('DataRequest');
end;

function TData.SqlTypeStr(SQLKind: TSQLKind): string;
begin
  result := '';

  case SQLKind of
    skFields:
      result := 'fields';
    skSelect:
      result := 'select';
    skInsert:
      result := 'insert';
    skUpdate:
      result := 'update';
    skDelete:
      result := 'delete';
    skCount:
      result := 'count';
    skCommand:
      result := 'command';
  end;
end;

function TData.GetFieldOrigin(DataSet: TFDQuery; Field: TField): string;
var
  Column: TFDDatSColumn;
  Alias: string;
  TableName: string;
  FieldName: string;
  tmp: string;
begin
  result := '';

  if not assigned(Field) then
    Exit;

  if assigned(Field) then
    if assigned(DataSet.Table) then
      if DataSet.Table.Columns.IndexOfName(Field.FieldName) <> -1 then
      begin
        Column := DataSet.Table.Columns.ColumnByName(Field.FieldName);

        if assigned(Column) then
        begin
          FieldName := Column.OriginColName.trim.Replace('"', '', [rfReplaceAll]);
          TableName := Column.OriginTabName.trim.Replace('"', '', [rfReplaceAll]);

          if TableName.IsEmpty then // parse dell'sql
          begin
            tmp := fib.SqlTxtRtns.FieldNameFromSelect(DataSet.SQL.Text, Field.FieldName);

            if tmp.Contains('.') then
              TableName := tmp.Substring(0, tmp.IndexOf('.'));
          end;

          if ((TableName = '') or (FieldName = '')) then
            result := TableName + FieldName
          else
            result := TableName + '.' + FieldName;
        end;
      end;

  // Per i campi calcolati
  if result.IsEmpty then
  begin
    result := Field.FieldName;

    if Pos('.', result) = 0 then
      if not TableName.IsEmpty then
        result := TableName + '.' + result;
  end;
end;

function TData.metaFolder(const App, DataModuleName: String; const SubFolder: string; const ForceDir: boolean): string;
  function AddFolder(const BaseFolder, SubFolder: string; const ForceDir: boolean = false): string;
  begin
    result := IncludeTrailingPathDelimiter(BaseFolder);
    siMain.LogString('Folder', result);

    if ForceDir then
      ForceDirectories(result);

    if not SubFolder.IsEmpty then
    begin
      result := IncludeTrailingPathDelimiter(result + SubFolder);
      siMain.LogString('SubFolder', result);

      if ForceDir then
        ForceDirectories(result);
    end;
  end;

begin
  result := TFolders.SubFolder(ConfigProps.CartellaFiles, 'meta');

  if ForceDir then
    ForceDirectories(result);

  result := AddFolder(result, App, ForceDir);
  result := AddFolder(result, DataModuleName, ForceDir);

  if not SubFolder.IsEmpty then
    result := AddFolder(result, SubFolder, ForceDir);
end;

function TData.sqlFileName(const App, DataModule, DataSetName, sqlType: string): string;
begin
  result := '';

  if App = '' then
    raise Exception.Create('App non specificata.');

  if DataModule = '' then
    raise Exception.Create('DataModule non specificato.');

  if DataSetName = '' then
    raise Exception.Create('DataSet non specificato.');

  result := metaFolder(App, DataModule, '', false) + DataSetName + '.' + sqlType + '.sql';
end;

/// ////////////////////////////////////////////////////////////////////////////

procedure TData.InternalLoadFields(datasetProps: TDatasetProps);
var
  DataSet: TFDQuery;
  StoredProc: TFDStoredProc;
  Field: TField;
  fieldNames, fieldOrigins: string;
  key: string;
begin
  // deve già essere in transazione

  key := DatasetKey(datasetProps.dm, datasetProps.DataSet);
  fieldNames := '';
  fieldOrigins := '';

  // Verifica dei campi esistenti
  DataSet := CreateDataSet;
  try
    DataSet.SQL.Text := datasetProps.SelectSql.Text;
    DataSet.Prepare;
    DataSet.FieldDefs.Updated := false;
    DataSet.FieldDefs.Update;
    TFDQueryAccess(DataSet).DoCreateFields;

    for Field in DataSet.fields do
    begin

      if Field.Origin.IsEmpty then
        Field.Origin := GetFieldOrigin(DataSet, Field);

      fieldNames := fieldNames + Field.FieldName + ';';
      fieldOrigins := fieldOrigins + Field.FieldName + '=' + Field.Origin + ';';
    end;
  finally
    FreeAndNil(DataSet);
  end;

  /// //////////////////////////////
  siMain.LogColored(tColors.Greenyellow, 'ZZ_WEB_DATASETS_FIELDS_SYNC');
  siMain.LogString('DataSetName', key);
  siMain.LogString('fieldNames', fieldNames);
  siMain.LogString('fieldOrigins', fieldOrigins);

  /// //////////////////////////////
  StoredProc := CreateStoredProc('ZZ_WEB_DATASETS_FIELDS_SYNC');
  try
    StoredProc.Prepare;
    StoredProc.ParamByName('DATASET').Value := key;
    StoredProc.ParamByName('FIELDS').Value := fieldNames;
    StoredProc.ParamByName('FIELD_ORIGINS').Value := fieldOrigins;
    StoredProc.ExecProc;
    StoredProc.Close;
  finally
    FreeAndNil(StoredProc);
  end;
  /// //////////////////////////////

  DataSet := CreateDataSet;
  try
    DataSet.SQL.Text := 'SELECT * FROM ZZ_WEB_DATASETS_FIELDS_GET(:DATASET)';
    DataSet.Prepare;
    DataSet.ParamByName('DATASET').AsString := key;

    DataSet.Active := true;
    try
      datasetProps.fields.LoadFieldsFromDataSet(key, DataSet);
    finally
      DataSet.Active := false;
    end;
  finally
    FreeAndNil(DataSet);
  end;
end;

function TData.InternalLoadDataset(ctx: TzContext; const dm, DataSet: string; const LoadFields: boolean = false): TDatasetProps;
var
  StoredProc: TFDStoredProc;
  key: string;
  tmp: TDatasetProps;
  loaded: boolean;
begin

  /// /////////////////////////////////////////////////////////////

  if cacheDatasets.GetDataset(dm, DataSet, tmp) then
  begin
    result := tmp;
    Exit;
  end;

  /// //////////////////////////////////////////////////////////////////////////
  key := DatasetKey(dm, DataSet);

  Connect(ctx);
  try
    StoredProc := CreateStoredProc('ZZ_WEB_DATASETS_GET');
    try
      StoredProc.Prepare;
      StoredProc.ParamByName('PARAM_DATASET').AsString := key;
      StoredProc.ExecProc;
      result := cacheDatasets.LoadFromDataSet(ctx.App, dm, DataSet, StoredProc);
      StoredProc.Close;
    finally
      FreeAndNil(StoredProc);
    end;

    if LoadFields then
      InternalLoadFields(result);
  finally
    Disconnect;
  end;
end;

procedure TData.InternalSaveDataset(ctx: TzContext; const datasetProps: TDatasetProps);
var
  StoredProc: TFDStoredProc;

  // tmp: TDatasetProps;

  procedure VerificaSql(const SQL: string);
  var
    Command: TFDCommand;
  begin

    if SQL.trim.IsEmpty then
      Exit;

    Command := CreateCommand(SQL);
    try
      Command.Prepare();
    finally
      FreeAndNil(Command);
    end;
  end;

begin
  /// //////////////////////////////////////////////////////////////////////////

  if datasetProps.RelationName.IsEmpty then
    datasetProps.RelationName := Get_RelationNameFromSQL(datasetProps.SelectSql.Text);

  if datasetProps.SelectSql.Text.IsEmpty then
    if not datasetProps.RelationName.IsEmpty then
      datasetProps.SelectSql.Text := 'SELECT * FROM ' + datasetProps.RelationName.ToUpper;

  Connect(ctx);
  try
    startTrans;
    try
      /// //////////////////////////////////////////////////////////////////////////
      // verificare tutti gli sql prima del salvataggio (prepare)

      VerificaSql(datasetProps.SelectSql.Text);
      VerificaSql(datasetProps.InsertSql.Text);
      VerificaSql(datasetProps.UpdateSql.Text);
      VerificaSql(datasetProps.DeleteSql.Text);
      VerificaSql(datasetProps.CountSql.Text);

      /// //////////////////////////////////////////////////////////////////////////

      StoredProc := CreateStoredProc('ZZ_WEB_DATASETS_SET');
      try
        StoredProc.Prepare;
        StoredProc.ParamByName('DATASET').Value := DatasetKey(datasetProps.dm, datasetProps.DataSet);
        StoredProc.ParamByName('IS_CUSTOM').Value := datasetProps.IsCustom;
        StoredProc.ParamByName('RELATION_NAME').Value := datasetProps.RelationName;
        StoredProc.ParamByName('PK_FIELDS').Value := datasetProps.PK;
        StoredProc.ParamByName('CAN_INSERT').Value := datasetProps.CanInsert;
        StoredProc.ParamByName('CAN_UPDATE').Value := datasetProps.CanUpdate;
        StoredProc.ParamByName('CAN_DELETE').Value := datasetProps.CanDelete;
        StoredProc.ParamByName('SQL_SELECT').Value := datasetProps.SelectSql.Text;
        StoredProc.ParamByName('SQL_INSERT').Value := datasetProps.InsertSql.Text;
        StoredProc.ParamByName('SQL_UPDATE').Value := datasetProps.UpdateSql.Text;
        StoredProc.ParamByName('SQL_DELETE').Value := datasetProps.DeleteSql.Text;
        StoredProc.ParamByName('SQL_COUNT').Value := datasetProps.CountSql.Text;
        StoredProc.ExecProc;

        cacheDatasets.LoadFromDataSet(ctx.App, datasetProps.dm, datasetProps.DataSet, StoredProc);

        StoredProc.Close;
      finally
        FreeAndNil(StoredProc);
      end;

      InternalLoadFields(datasetProps);

      Commit;
    except
      on e: Exception do
        Rollback;
    end;
  finally
    Disconnect;
  end;
end;

procedure TData.GetDataset(ctx: TzContext);
var
  datasetProps, tmp: TDatasetProps;
  JSONObject: TJSONObject;
begin
  siMain.EnterMethod('GetDatasetRequest');

  if not ConfigProps.AllowMetaRequest then
  begin
    ctx.Response.RenderError('Metodo non riconosciuto.', -1);
    Exit;
  end;

  datasetProps := ctx.Request.datasetProps;
  try
    siMain.LogColored(tColors.Yellow, 'GetDatasetRequest: ' + datasetProps.dm + '.' + datasetProps.DataSet);
    siMain.LogObject(TWebRequest.identDataRequest, datasetProps);

    /// /////////////////////////////////////////////////////////////

    tmp := InternalLoadDataset(ctx, datasetProps.dm, datasetProps.DataSet, true);

    /// /////////////////////////////////////////////////////////////

    JSONObject := TDatasetsProps.Encode(tmp);
    siMain.LogString(TWebRequest.identDatasetRequest, JSONObject.ToJSON);
    ctx.Response.Render(JSONObject); // direttamente il json
  finally
    FreeAndNil(datasetProps);
  end;

  siMain.leaveMethod('GetDatasetRequest');
end;

procedure TData.SetDataset(ctx: TzContext);
var
  datasetProps: TDatasetProps;
begin
  siMain.EnterMethod('SetDataset');

  if not ConfigProps.AllowMetaRequest then
  begin
    ctx.Response.RenderError('Metodo non riconosciuto.', -1);
    Exit;
  end;

  datasetProps := ctx.Request.datasetProps;
  try
    siMain.LogColored(tColors.Yellow, 'SetDataset: ' + datasetProps.dm + '.' + datasetProps.DataSet);
    siMain.LogObject(TWebRequest.identDatasetRequest, datasetProps);

    /// /////////////////////////////////////////////////////////////

    InternalSaveDataset(ctx, datasetProps);

    /// /////////////////////////////////////////////////////////////

    ctx.Response.RenderOk;
  finally
    FreeAndNil(datasetProps);
  end;

  siMain.leaveMethod('SetDataset');
end;

function TData.Get_RelationNameFromSQL(SQL: string): string;
begin
  result := '';

  if trim(SQL) = '' then
    Exit;

  result := GetTableNameFromSQL(SQL.trim.ToUpper);
  result := result.trim.ToUpper();
end;

procedure TData.SetFields(ctx: TzContext);
var
  FieldsProps: TFieldsProps;
  FieldProps: TFieldProps;
  StoredProc: TFDStoredProc;
begin
  siMain.EnterMethod('SetField');

  if not ConfigProps.AllowMetaRequest then
  begin
    ctx.Response.RenderError('Metodo non riconosciuto.', -1);
    Exit;
  end;

  FieldsProps := ctx.Request.FieldsProps;
  try
    siMain.LogColored(tColors.Yellow, 'SetFields');
    siMain.LogObject(TWebRequest.identFieldsRequest, FieldsProps);

    /// /////////////////////////////////////////////////////////////

    Connect(ctx);
    try
      startTrans;
      try
        StoredProc := CreateStoredProc('ZZ_WEB_DATASETS_FIELD_SAVE');
        try
          StoredProc.Prepare;

          for FieldProps in FieldsProps do
          begin
            StoredProc.ParamByName('DATASET').Value := FieldProps.DataSet;
            StoredProc.ParamByName('FIELD').Value := FieldProps.FieldName;
            StoredProc.ParamByName('FIELD_ORIGIN').Value := FieldProps.FieldOrigin;
            StoredProc.ParamByName('FIELD_DOMAIN').Value := FieldProps.FieldDomain;
            StoredProc.ParamByName('FIELD_TYPE').Value := FieldProps.FieldType;
            StoredProc.ParamByName('FIELD_SIZE').Value := FieldProps.FieldSize;
            StoredProc.ParamByName('FIELD_DECIMALS').Value := FieldProps.FieldDecimals;
            StoredProc.ParamByName('ALIGN').Value := FieldProps.AlignStr;
            StoredProc.ParamByName('CAPTION').Value := FieldProps.Caption;
            StoredProc.ParamByName('REQUIRED').Value := FieldProps.Required;
            StoredProc.ParamByName('READONLY').Value := FieldProps.ReadOnly;
            StoredProc.ParamByName('FIELDS_2_CLEAR').Value := FieldProps.Fields2Clear;
            StoredProc.ParamByName('EDITOR_TYPE').Value := FieldProps.EditorType;
            StoredProc.ParamByName('COL_SPAN').Value := FieldProps.ColSpan;
            StoredProc.ParamByName('DEFAULT_VALUE').Value := FieldProps.DefaultValue;
            StoredProc.ParamByName('PICKLIST').Value := FieldProps.PickList;
            StoredProc.ParamByName('PICKLISTS_ITEMS').Value := FieldProps.PickListItems;
            StoredProc.ParamByName('LOOKUP').Value := FieldProps.Lookup;
            StoredProc.ParamByName('LOOKUP_DATASET').Value := FieldProps.LookupDataSet;
            StoredProc.ParamByName('LOOKUP_VALUE_EXPR').Value := FieldProps.LookupValueExpr;
            StoredProc.ParamByName('LOOKUP_DISPLAY_EXPR').Value := FieldProps.LookupDisplayExpr;
            StoredProc.ParamByName('LOOKUP_PARAMS').Value := FieldProps.LookupParams;
            StoredProc.ParamByName('LOOKUP_MAPPINGS').Value := FieldProps.LookupMappings;
            StoredProc.ParamByName('LINEBREAK').Value := FieldProps.LineBreak;
            StoredProc.ParamByName('CARD_VISIBLE').Value := FieldProps.CardVisible;
            StoredProc.ParamByName('CARD_INDEX').Value := FieldProps.CardIndex;
            StoredProc.ParamByName('VIEW_VISIBLE').Value := FieldProps.ViewVisible;
            StoredProc.ParamByName('VIEW_INDEX').Value := FieldProps.ViewIndex;
            StoredProc.ParamByName('IS_CUSTOM').Value := FieldProps.Custom;
            StoredProc.ExecProc;
          end;
          StoredProc.Close;
        finally
          FreeAndNil(StoredProc);
        end;

        Commit;
      except
        on e: Exception do
          Rollback;
      end;
    finally
      Disconnect;
    end;

    cacheDatasets.UpdateFields(FieldsProps);

    ctx.Response.RenderOk;
  finally
    FreeAndNil(FieldProps);
  end;

  siMain.leaveMethod('SetField');
end;

procedure TData.CheckSessioneAttiva(ctx: TzContext);
var
  StoredProc: TFDStoredProc;
begin
  // Deve essere in connessione

  StoredProc := CreateStoredProc('USR_CHECK_SESSIONE_ATTIVA');
  try
    StoredProc.UpdateOptions.AutoCommitUpdates := false;
    Prepare(ctx.Request, StoredProc);
    StoredProc.ExecProc;
    ctx.Response.Render(StoredProc);
    StoredProc.Close;
  finally
    FreeAndNil(StoredProc);
  end;
end;

initialization

RegisterClass(TData);

end.


// CAMPI
//
// InternalSaveDataset, deve validare i campi.
// - eliminare quelli non più presenti
// - aggiungere i mancanti
// - aggiornare la posizione
//
// Salvataggio del singolo campo?
//
