unit BaseWeb.DM;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Stan.Param,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Phys.Intf,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.DatS,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Data.DB,
  FireDAC.Phys.IBBase,
  BaseWeb.Models,
  zStoredProc,
  Base_DataModule,
  dbMaster,
  zFbDataSet,
  Vcl.Dialogs,
   zProgressBox,
  BaseWeb.Repository;

type
  TBaseWebDM = class(TBaseDataModule)
    qryExec: TFDQuery;
    FDCommand: TFDCommand;
    ProgressBox: TProgressBox;
    Campi: TzFbDataSet;
  private
    function GetFieldOrigin(DataSet: TFDQuery; Field: TField): string;
  public
    procedure ExecSQL(const ASQL: string; const AParams: array of Variant); overload;

    procedure GeneraCampi(datasets: TList<string>);
    procedure VerificaDataSet(datasets: TList<string>);
  public // implements
    // IBaseWebDataAccess
    function GetFDQuery(const sql: string): TFDQuery;
    function GetStoredProc(AClass: zStoredProc.TzStoredProcClass): zStoredProc.TzStoredProc;
  end;

var
  BaseWebDM: TBaseWebDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses
  System.Variants,
  zMsg,
  zSql.SqlTxtRtns,
  Gesty_StoredProcs,
  ConfigModule,
  zSystem;

type
  TFDQueryAccess = class(TFDQuery);

procedure TBaseWebDM.ExecSQL(const ASQL: string; const AParams: array of Variant);
begin
  qryExec.sql.Text := ASQL;
  for var I := 0 to High(AParams) do
    qryExec.Params[I].Value := AParams[I];
  qryExec.ExecSQL;
end;

procedure TBaseWebDM.GeneraCampi(datasets: TList<string>);

  procedure Genera(datasetName, sql: string);
  var
    Field: TField;
    fieldNames: string;
    fieldOrigins: string;
    sp: TSP_base_Web__Datasets_Fields_Sync;
  begin
    Campi.Unprepare;
    Campi.Fields.Clear;
    Campi.sql.Text := sql;
    Campi.Prepare;
    Campi.FieldDefs.Updated := false;
    Campi.FieldDefs.Update;
    TFDQueryAccess(Campi).DoCreateFields;

    fieldNames := '';
    fieldOrigins := '';

    for Field in Campi.Fields do
    begin

      if Field.Origin.IsEmpty then
        Field.Origin := GetFieldOrigin(Campi, Field);

      fieldNames := fieldNames + Field.FieldName + slineBreak;
      fieldOrigins := fieldOrigins + Field.FieldName + '=' + Field.Origin + slineBreak;
    end;

    /// /////////////////////////////////////////
    Config.Database.ExecSQLScalar('SELECT BASE_WEB.META_UPDATE_DISABLE() FROM RDB$DATABASE');
    try
      sp := GetSP<TSP_base_Web__Datasets_Fields_Sync>;
      try
        sp.DataSet := datasetName;
        sp.Fields.Text := fieldNames;
        sp.Field_Origins.Text := fieldOrigins;
        sp.ExecuteAndCommit;
      finally
        FreeAndNil(sp);
      end;
    finally
      Config.Database.ExecSQLScalar('SELECT BASE_WEB.META_UPDATE_ENABLE(' + #39 + datasetName + #39 + ') FROM RDB$DATABASE');
    end;
  end;

var
  DataSet: TzFbDataSet;
  datasetName: string;
begin
  if datasets.count = 0 then
    exit;

  if not ConfirmOkCancel('Si desidera generare i campi dei dataset?') then
    exit;

  DataSet := getDataSet('Base_Web_Datasets');
  DataSet.UseSqlLocate := false;
  try
    ProgressBox.Show(datasets.count, 'Generazione campi', '', 'Attendere...');
    try

      for datasetName in datasets do
      begin
        ProgressBox.IncProgress(datasetName);
        if ProgressBox.Cancelled then
          exit;

        if not DataSet.Locate('DATASET', datasetName, []) then
          continue;

        Genera(datasetName, DataSet.FieldByName('SQL_SELECT').asString);
      end;

      ReopenDataSet('Base_Web_DATASETS_FIELDS');
    finally
      ProgressBox.Close;
    end;
  finally
    DataSet.UseSqlLocate := True;
  end;
end;

function TBaseWebDM.GetFieldOrigin(DataSet: TFDQuery; Field: TField): string;
var
  Column: TFDDatSColumn;
  Alias: string;
  TableName: string;
  FieldName: string;
  tmp: string;
begin
  Result := '';

  if not assigned(Field) then
    exit;

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
            tmp := zSql.SqlTxtRtns.FieldNameFromSelect(DataSet.sql.Text, Field.FieldName);

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

procedure TBaseWebDM.VerificaDataSet(datasets: TList<string>);

  procedure VerificaSQL(const caption, sql: string);
  begin
    if sql.trim.IsEmpty then
      exit;

    ProgressBox.SecondLabel := caption;

    FDCommand.Prepare(sql);
  end;

var
  DataSet: TzFbDataSet;
  datasetName: string;
begin
  if datasets.count = 0 then
    exit;

  if not ConfirmOkCancel('Si desidera verificare gli sql dei dataset?') then
    exit;

  DataSet := getDataSet('Base_Web_Datasets');
  DataSet.UseSqlLocate := false;
  try
    ProgressBox.Show(datasets.count, 'Verifica dataset', '', 'Attendere...');
    try

      for datasetName in datasets do
      begin
        ProgressBox.IncProgress(datasetName);
        if ProgressBox.Cancelled then
          exit;

        if not DataSet.Locate('DATASET', datasetName, []) then
          continue;

        VerificaSQL('Select', DataSet.FieldByName('SQL_SELECT').asString);
        VerificaSQL('Count', DataSet.FieldByName('SQL_COUNT').asString);
        VerificaSQL('Refresh', DataSet.FieldByName('SQL_REFRESH').asString);
        VerificaSQL('Insert', DataSet.FieldByName('SQL_INSERT').asString);
        VerificaSQL('Update', DataSet.FieldByName('SQL_UPDATE').asString);
        VerificaSQL('Delete', DataSet.FieldByName('SQL_DELETE').asString);
      end;
    finally
      ProgressBox.Close;
    end;
  finally
    DataSet.UseSqlLocate := True;
  end;
end;

function TBaseWebDM.GetFDQuery(const sql: string): TFDQuery;
begin
  Result := TzFbDataSet.Create(Owner);
  Result.Connection := Config.Database;
  Result.Transaction := ReadTrans;
  Result.UpdateTransaction := WriteTrans;
  Result.FetchOptions.UniDirectional := True;
  Result.sql.Text := sql;
  Result.Prepare;
end;

function TBaseWebDM.GetStoredProc(AClass: zStoredProc.TzStoredProcClass): zStoredProc.TzStoredProc;
begin
  Result := AClass.Create;
  Result.zSystem := Config.zSystem;
  Result.Database := Config.Database;
  Result.Transaction := WriteTrans;
end;

/// ////////////////////////////////////////////////
///
type
  TBaseWebDataAccess = class(TBaseWebDataAccessAbstract)
  public
    function GetFDQuery(const sql: string): TFDQuery; override;
    function GetSP(AClass: zStoredProc.TzStoredProcClass): zStoredProc.TzStoredProc; override;
    function ExecuteSQL(const sql: string): Variant; override;
  end;

function TBaseWebDataAccess.ExecuteSQL(const sql: string): Variant;
begin
  // Result := inherited ExecuteSQL(sql);
  Result := Config.Database.ExecSQLScalar(sql);
end;

function TBaseWebDataAccess.GetFDQuery(const sql: string): TFDQuery;
begin
  Result := nil;

  if assigned(BaseWebDM) then
    Result := BaseWebDM.GetFDQuery(sql);
end;

function TBaseWebDataAccess.GetSP(AClass: zStoredProc.TzStoredProcClass): zStoredProc.TzStoredProc;
begin
  Result := nil;

  if assigned(BaseWebDM) then
    Result := BaseWebDM.GetStoredProc(AClass);
end;

initialization

BaseWeb.Repository.BaseWebDataAccess := TBaseWebDataAccess.Create;

end.
