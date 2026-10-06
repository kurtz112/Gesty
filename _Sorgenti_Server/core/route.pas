unit Route;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  System.Generics.Collections,
  Web.HTTPApp,
  Data.DB,
  FireDAC.Phys.FBDef,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Comp.Client,
  FireDAC.Phys.IBBase,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  lib.Context,
  System.Rtti;

type
  TRoute = class(TDataModule) // classe normale, implementa HandleRequest
  private
    _Connection: TFDConnection;
    _Transaction: TFDTransaction;
  protected
    function Connection: TFDConnection;
    function Transaction: TFDTransaction;
  protected
    function CreateDataSet: TFDQuery;
    procedure InitDataSet(DataSet: TFDQuery; const Unidirectional: boolean = true);

    function CreateStoredProc(const StoredProcName: string = ''): TFDStoredproc;
    procedure InitStoredProc(sp: TFDStoredproc);

    function CreateCommand(const SQL: string): TFDCommand;
    procedure InitCommand(command: TFDCommand);

    procedure SetParam(Param: TFDParam; const Value: string); virtual;
    procedure Prepare(Request: TWebRequest; DataSet: TFDQuery); overload;
    procedure Prepare(Request: TWebRequest; StoredProc: TFDStoredproc); overload;
    procedure Prepare(Request: TWebRequest; command: TFDCommand); overload;
  protected
    function DataSetFileName(const DataModule, DataSetName: string; const Ext: string = '.sql'): string;
    function DataModuleFolder(const DataModuleName: String): string;
  protected
    function ParseSQL(Request: TWebRequest; const SQL: string): string;
    procedure LoadSql(Request: TWebRequest; DataSet: TFDQuery); overload;
    procedure LoadSql(Request: TWebRequest; DataSet: TFDQuery; const DataModule, DataSetName: string); overload;
  private
    function GetUserConnectionName(DbUserName: string): string;
    procedure RegisterConnection(Const ConnectionName: string);

    procedure InternaleConnect(Const ConnectionName: string);
  protected
    function CreateUserConnection(Const DbUserName: string): string;
    function DefaultConnectionName: string;

    procedure AdminConnect;
    procedure Connect(ConnectionName: string); overload;
    procedure Connect(Context: TzContext); overload;
    procedure Disconnect;

    procedure StartTrans;
    procedure Commit;
    function GetRecordCount(DataSet: TFDQuery): integer;
    procedure Rollback;
  private
    function StoredProcAllowed(const StoredProcName: string): boolean;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  public
    procedure ExecSQL(const SQL: string; Context: TzContext; Request: TWebRequest; Response: TWebResponse);
    procedure ExecSP(const StoredProcName: string; ctx: TzContext); overload;
    procedure ExecSP(ctx: TzContext); overload; virtual;

    procedure GetData(ctx: TzContext); overload; virtual;
    procedure GetData(ctx: TzContext; const DataModule, DataSetName: string); overload;
  end;

  TRouteClass = class of TRoute;

implementation

uses
  System.IOUtils,
  zz.Folders,
  zz.SmartInspect,
  fib.SqlTxtRtns,
  lib.Config,
  lib.JsonRest,
  lib.Consts,
  IdURI,
  sqlParser,
  zz.Strings, lib.DateISO;

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

constructor TRoute.Create(aOwner: TComponent);
begin
  inherited;
  _Connection := nil;
  _Transaction := nil;
end;

destructor TRoute.Destroy;
begin
  inherited;
end;

function TRoute.Connection: TFDConnection;
begin

  if not assigned(_Connection) then
  begin
    _Connection := TFDConnection.Create(Self);
    _Connection.LoginPrompt := False;
    _Connection.ResourceOptions.SilentMode := true;

    _Connection.Transaction := Transaction;
    _Connection.UpdateTransaction := Transaction;
  end;

  Result := _Connection;
end;

function TRoute.Transaction: TFDTransaction;
begin
  if not assigned(_Transaction) then
  begin
    _Transaction := TFDTransaction.Create(Self);
    _Transaction.Connection := _Connection
  end;

  Result := _Transaction;
end;

function TRoute.CreateDataSet: TFDQuery;
begin
  Result := TFDQuery.Create(Self);
  InitDataSet(Result);
end;

function TRoute.CreateStoredProc(const StoredProcName: string = ''): TFDStoredproc;
begin
  SiMain.EnterMethod(Self, 'CreateStoredProc');
  SiMain.LogString('StoredProcName', StoredProcName);
  Result := TFDStoredproc.Create(Self);
  InitStoredProc(Result);
  Result.StoredProcName := StoredProcName;

  if Result.StoredProcName <> '' then
    Result.Prepare;

  SiMain.LeaveMethod(Self, 'CreateStoredProc');
end;

procedure TRoute.InitStoredProc(sp: TFDStoredproc);
begin
  sp.Connection := Connection;
  sp.UpdateTransaction := Transaction;
  sp.ResourceOptions.SilentMode := true;
end;

procedure TRoute.Disconnect;
begin
  SiMain.EnterMethod(Self, 'Disconnect');
  try
    Connection.Connected := False;
  finally
    SiMain.LeaveMethod(Self, 'Disconnect');
  end;
end;

procedure TRoute.Commit;
begin
  if Transaction.Active then
    Transaction.Commit;
end;

procedure TRoute.AdminConnect;
begin
  SiMain.EnterMethod(Self, 'AdminConnect');
  try
    InternaleConnect(DefaultConnectionName);
  finally
    SiMain.LeaveMethod(Self, 'AdminConnect');
  end;
end;

procedure TRoute.Connect(Context: TzContext);
begin
  SiMain.EnterMethod(Self, 'Connect(Context)');
  try
    if Context.ConnectionName = '' then
    begin
      AdminConnect;
      Exit;
    end;

    // si da per scontato che sia la connessione ActiveDirecotry..
    if not FDManager.IsConnectionDef(Context.ConnectionName) then
      RegisterConnection(Context.ConnectionName);

    Connect(Context.ConnectionName);
  finally
    SiMain.LeaveMethod(Self, 'Connect(Context)');
  end;
end;

procedure TRoute.Connect(ConnectionName: string);
begin
  SiMain.EnterMethod(Self, 'Connect(ConnectionName)');
  try
    InternaleConnect(ConnectionName);
  finally
    SiMain.LeaveMethod(Self, 'Connect(ConnectionName)');
  end;
end;

function TRoute.CreateUserConnection(Const DbUserName: string): string;
begin
  SiMain.EnterMethod(Self, 'CreateUserConnection');
  try
    Result := '';

    if DbUserName = '' then
      Exit;

    Result := ConnectionNamePrefix + DbUserName;

    if not FDManager.IsConnectionDef(Result) then
      RegisterConnection(Result);

    SiMain.LogString('NewConnectionName', Result);
  finally
    SiMain.LeaveMethod(Self, 'CreateUserConnection');
  end;
end;

procedure TRoute.Rollback;
begin
  if Transaction.Active then
    Transaction.Rollback;
end;

function TRoute.DataModuleFolder(const DataModuleName: String): string;
begin
  Result := TFolders.SubFolder(TFolders.SubFolder(ConfigProps.CartellaFiles, 'SQL'), DataModuleName);
end;

function TRoute.DataSetFileName(const DataModule, DataSetName: string; const Ext: string = '.sql'): string;
begin
  Result := '';

  if DataSetName = '' then
    raise Exception.Create('DataSet non specificato.');

  if DataModule = '' then
    raise Exception.Create('DataModule non specificato.');

  Result := ChangeFileExt(DataModuleFolder(DataModule) + DataSetName, Ext);
end;

procedure TRoute.InternaleConnect(Const ConnectionName: string);
begin
  SiMain.EnterMethod(Self, 'InternaleConnect');
  try
    SiMain.LogString('ConnectionName', ConnectionName);
    Connection.Connected := False;
    Connection.ConnectionDefName := ConnectionName;
    Connection.Connected := true;
  finally
    SiMain.LeaveMethod(Self, 'InternaleConnect');
  end;
end;

procedure TRoute.Prepare(Request: TWebRequest; DataSet: TFDQuery);
var
  i: integer;
  s: string;
begin
  Assert(assigned(DataSet));

  DataSet.Active := False;
  DataSet.Prepare;

  // Se chiamata con Request
  If assigned(Request) Then
    for i := 0 to DataSet.ParamCount - 1 do
    begin
      s := Request.ParamByName(DataSet.Params[i].Name);
      SetParam(DataSet.Params[i], s);
    end;
end;

procedure TRoute.Prepare(Request: TWebRequest; StoredProc: TFDStoredproc);
var
  i: integer;
  s: string;
  paramname: String;
begin
  Assert(assigned(StoredProc));

  StoredProc.Prepare;

  // Se chiamata con Request
  If assigned(Request) Then
    for i := 0 to StoredProc.ParamCount - 1 do
      if StoredProc.Params[i].ParamType in [ptInput, ptInputOutput] then
      begin
        s := Request.ParamByName(StoredProc.Params[i].Name);
        SetParam(StoredProc.Params[i], s);
      end;
end;

procedure TRoute.Prepare(Request: TWebRequest; command: TFDCommand);
var
  i: integer;
  s: string;
  paramname: String;
begin
  Assert(assigned(command));

  // Con EXECUTE PROCEDURE non usare RETURNING
  command.Prepare;

  // Se chiamata con Request
  If assigned(Request) Then
    for i := 0 to command.Params.Count - 1 do
      if command.Params[i].ParamType in [ptInput, ptInputOutput] then
      begin
        s := Request.ParamByName(command.Params[i].Name);
        SetParam(command.Params[i], s);
      end;
end;

procedure TRoute.LoadSql(Request: TWebRequest; DataSet: TFDQuery);
var
  DataSetName: string;
  DataModuleName: string;
begin
  DataSetName := Request.ParamByName(ident_DataSet);
  if DataSetName = '' then
    DataSetName := Request.ParamByName('DataSet');
  // Vecchio FastCGI

  if DataSetName = '' then
    raise Exception.Create('DataSet non specificato.');
  // ToDo: rows, offset

  DataModuleName := Request.ParamByName(ident_Datamodule);
  if DataModuleName = '' then
    DataModuleName := Request.ParamByName('Datamodule'); // Vecchio FastCGI
  if DataModuleName = '' then
    DataModuleName := Request.ParamByName('DM'); // Vecchio FastCGI

  LoadSql(Request, DataSet, DataModuleName, DataSetName);
end;

procedure TRoute.LoadSql(Request: TWebRequest; DataSet: TFDQuery; const DataModule, DataSetName: string);
var
  SQL: string;
  FileName: String;
begin
  DataSet.Active := False;
  DataSet.Fields.Clear;
  DataSet.SQL.Clear;

  FileName := DataSetFileName(DataModule, DataSetName, '.sql');

  if not TFile.Exists(FileName) then
    raise Exception.Create('DataSet non trovato: ' + FileName);

  SQL := TFile.ReadAllText(FileName);
  SQL := ParseSQL(Request, SQL);
  DataSet.SQL.Text := SQL;
end;

procedure TRoute.SetParam(Param: TFDParam; const Value: string);
begin
  if not assigned(Param) then
    SiMain.LogWarning('Parametro non trovato')
  else
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
            if Param.DataType in [ftString, ftFixedChar, ftWideString, ftFixedWideChar] then
              Param.Text := Value.Substring(0, Param.Size)
            else // altrimenti fa casino con il size nel caso di interi o altro
              Param.Text := Value; // text, non asString!!!!
  end;
end;

procedure TRoute.StartTrans;
begin
  Transaction.StartTransaction;
end;

function TRoute.ParseSQL(Request: TWebRequest; const SQL: string): string;

  function GetRowsLimitOldWeb: string;
  var
    Start, Limit: integer;
  begin
    Result := '';

    if Request.ParamByName('start') = '' then
      Exit;

    Start := Request.ParamByName('start').ToInteger;
    if Start < 0 then
      Exit;

    Start := Start + 1;

    Result := 'ROWS ' + IntToStr(Start);

    Limit := Request.ParamByName('limit').ToInteger;

    if Limit > 0 then
      Result := Result + ' TO ' + IntToStr(Start + Limit - 1);
  end;

  function GetRowsLimit: string;
  var
    _from, _to: integer;
  begin
    Result := GetRowsLimitOldWeb;

    if Result <> '' then
      Exit;

    if Request.ParamByName(ident_Offset) = '' then
      if Request.ParamByName('rows') = '' then
        Exit;

    _from := Request.ParamByName(ident_Offset).ToInteger;

    if _from < 0 then
      _from := Request.ParamByName('rows').ToInteger;

    if _from < 0 then
      Exit;

    /// /////////////////////////////////

    _to := Request.ParamByName(ident_Limit).ToInteger;

    if _to < 0 then
      _to := Request.ParamByName('offset').ToInteger;
    /// /////////////////////////////////

    Result := 'ROWS ' + IntToStr(_from);

    if _to <= 0 then
      _to := DefaultLimit;

    Result := Result + ' TO ' + IntToStr(_from + _to - 1);
  end;

  function GetOrderBy: string;
  begin
    Result := Request.ParamByName('sort');

    if Result <> '' then
      if SameText(Request.ParamByName('dir'), 'DESC') then
        Result := Result + ' DESC ';
  end;

  function GetComboFilter: string;
  var
    s: string;
    FieldName, FieldType, FilterOperator, Value: string;
    o: TJSONObject;
  begin
    Result := '';
    // filter=[{"property":"DESC_SERVIZIO"}]
    // query=valore      ident_ComboQueryParam

    s := Request.ParamByName('filter');
    if s = '' then
      Exit;

    FieldName := RemoveStrings(s, ['[', '{', '"property"', ':', '"', '}', ']']);
    ///
    ///

    if FieldName = '' then
      Exit;

    Value := UpperCase(AnsiQuotedStr(Request.ParamByName(ident_ComboQueryParam), #39));
    FilterOperator := ' STARTING WITH '; // numerici, date etc?? Servono??
    Result := Result + FieldName + FilterOperator + Value;
  end;

  function GetFilter: string;
  var
    i: integer;
    idx, FieldName, FieldType, FilterOperator, Value: string;
  begin
    Result := '';

    for i := 0 to Request.ParamCount - 1 do
    begin
      idx := IntToStr(i);
      FieldName := Request.ParamByName('filter[' + idx + '][field]');

      if FieldName = '' then
        Exit;

      FieldType := Request.ParamByName('filter[' + idx + '][data][type]');

      FilterOperator := Request.ParamByName('filter[' + idx + '][data][comparison]');
      Value := Request.ParamByName('filter[' + idx + '][data][value]');

      if FieldType = 'date' then
        Value := QuotedStr(FormatDateTime('dd.mm.yyyy', StrToDate(Value)))
      else
        if FieldType = 'string' then
          Value := QuotedStr(Value);

      if FilterOperator = '' then

        FilterOperator := '='
      else
        if FilterOperator = 'eq' then
          FilterOperator := '='
        else
          if FilterOperator = 'lt' then
            FilterOperator := '<'
          else
            if FilterOperator = 'gt' then
              FilterOperator := '>';

      if Result <> '' then
        Result := Result + ' AND ';

      Result := Result + FieldName + FilterOperator + Value;
    end
  end;

var
  Filter, ComboFilter, OrderBy, Limit: string;
begin
  Result := SQL;

  if Result = '' then
    Exit;
  /// /////////////////////////////////////////////////////////////
  /// Toglie la coda ri ROWS che viene aggiunta alla qry
  System.Delete(Result, Pos('ROWS ', Result), Length(Result));
  while CharInSet(Result[Length(Result)], [#13, #10]) do
    Delete(Result, Length(Result), 1);
  /// /////////////////////////////////////////////////////////////
  Filter := GetFilter;
  ComboFilter := GetComboFilter;
  OrderBy := GetOrderBy;
  Limit := GetRowsLimit;

  if Filter <> '' then
    Result := fib.SqlTxtRtns.AddToWhereClause(Result, Filter, true);

  if ComboFilter <> '' then
    Result := fib.SqlTxtRtns.AddToWhereClause(Result, ComboFilter, true);

  if OrderBy <> '' then
    Result := fib.SqlTxtRtns.SetOrderClause(Result, OrderBy);

  if Limit <> '' then
    Result := Result + #13#10 + Limit;

  SiMain.LogString('SQL', Result);
end;

function TRoute.GetUserConnectionName(DbUserName: string): string;
begin
  Result := ConnectionNamePrefix + '_' + DbUserName;

  if not FDManager.IsConnectionDef(Result) then
    RegisterConnection(Result);
end;

function TRoute.DefaultConnectionName: string;
begin
  Result := ConnectionNamePrefix + 'Default';

  if not FDManager.IsConnectionDef(Result) then
    RegisterConnection(Result);
end;

procedure TRoute.ExecSP(const StoredProcName: string; ctx: TzContext);
var
  i: integer;
  StoredProc: TFDStoredproc;
begin

  if not StoredProcAllowed(StoredProcName) then
    raise Exception.Create('Chiamata non autorizzata.');

  Connect(ctx);
  try
    StoredProc := CreateStoredProc(StoredProcName);
    try
      Prepare(ctx.Request, StoredProc);
      StoredProc.ExecProc;
      ctx.Response.Render(StoredProc);
      StoredProc.Close;
    finally
      FreeAndNil(StoredProc);
    end;
  finally
    Disconnect;
  end;
end;

function TRoute.StoredProcAllowed(const StoredProcName: string): boolean;
var
  Whitelist: TStringList;
begin
  SiMain.LogString('SP_Whitelist', ConfigProps.SP_Whitelist);
  Result := ConfigProps.SP_Whitelist.IsEmpty;

  if not ConfigProps.SP_Whitelist.IsEmpty then
    if FileExists(ConfigProps.SP_Whitelist) then
    begin
      Whitelist := TStringList.Create;
      try
        Whitelist.LoadFromFile(ConfigProps.SP_Whitelist);
        Whitelist.Text := Whitelist.Text.ToUpper;

        Result := Whitelist.IndexOf(StoredProcName.ToUpper) <> -1;
      finally
        FreeAndNil(Whitelist);
      end;
    end
    else
      SiMain.LogString('File SP_Whitelist non trovato: ', ConfigProps.SP_Whitelist);

  SiMain.LogBoolean('SP_Whitelist: StoredProcName', Result);
end;

procedure TRoute.ExecSP(ctx: TzContext);
var
  StoredProcName: string;
begin
  StoredProcName := ctx.Request.ParamByName(ident_StoredProc);
  ExecSP(StoredProcName, ctx);
end;

procedure TRoute.GetData(ctx: TzContext);
var
  DataSet: TFDQuery;
  RecordCount: integer;
begin
  SiMain.EnterMethod(Self, 'GetData');
  try
    Connect(ctx);
    try
      DataSet := CreateDataSet;
      try
        LoadSql(ctx.Request, DataSet);

        Prepare(ctx.Request, DataSet);
        DataSet.Active := true;
        try
          RecordCount := GetRecordCount(DataSet);
          ctx.Response.Render(DataSet, [], nil, RecordCount);
        finally
          DataSet.Active := False;
        end;
      finally
        FreeAndNil(DataSet);
      end;
    finally
      Disconnect;
    end;
  finally
    SiMain.LeaveMethod(Self, 'GetData');
  end;
end;

procedure TRoute.RegisterConnection(Const ConnectionName: string);
var
  Params: TStrings;
  ParametriRegistro: TStringList;
begin
  if not FDManager.IsConnectionDef(ConnectionName) then
  begin
    Params := TStringList.Create;
    try
      Params.Clear;
      Params.Add('DriverID=FB');
      Params.Add('Server=' + ConfigProps.DbServer);
      Params.Add('Database=' + ConfigProps.DataBaseName);
      Params.Add('User_Name=' + ConfigProps.DbUserName);
      Params.Add('Password=' + ConfigProps.DbPassword);
      Params.Add('CharacterSet=' + ConfigProps.CharacterSet);
      Params.Add('Pooled=True');
      // Nel registro la password non deve comparire: il registro si allega
      // alle segnalazioni. Si registra una copia con la password coperta; la
      // lista vera resta intatta per la definizione della connessione.
      ParametriRegistro := TStringList.Create;
      try
        ParametriRegistro.Assign(Params);
        ParametriRegistro.Values['Password'] := '***';
        SiMain.LogStringList('dbParams', ParametriRegistro);
      finally
        FreeAndNil(ParametriRegistro);
      end;
      FDManager.AddConnectionDef(ConnectionName, 'FB', Params);
    finally
      FreeAndNil(Params);
    end;
  end;
end;

function TRoute.GetRecordCount(DataSet: TFDQuery): integer;
var
  i: integer;
  Parser: TSQLParser;
  tmp: TFDQuery;
begin
  Parser := TSQLParser.Create(nil);
  try
    Parser.SQL := DataSet.SQL.Text;

    if Parser.ROWS = '' then
      Result := DataSet.RecordCount
    else
    begin
      Parser.SELECT := 'SELECT COUNT(*) ';
      Parser.ROWS := '';

      tmp := CreateDataSet;
      try
        tmp.SQL.Text := Parser.SQL;
        tmp.Prepare;
        tmp.Params.Assign(DataSet.Params);
        tmp.FetchOptions.RecordCountMode := cmFetched;
        tmp.Active := true;
        try
          Result := tmp.Fields[0].AsInteger;
        finally
          tmp.Active := False;
        end;
      finally
        FreeAndNil(tmp);
      end;
    end;
  finally
    Parser.Free;
  end;
end;

procedure TRoute.GetData(ctx: TzContext; const DataModule, DataSetName: string);
var
  DataSet: TFDQuery;
  RecordCount: integer;
begin
  SiMain.EnterMethod(Self, 'GetData');
  try
    Connect(ctx);
    try
      DataSet := CreateDataSet;
      try
        LoadSql(ctx.Request, DataSet, DataModule, DataSetName);

        Prepare(ctx.Request, DataSet);
        DataSet.Active := true;
        try
          RecordCount := GetRecordCount(DataSet);
          ctx.Response.Render(DataSet, [], nil, RecordCount);
        finally
          DataSet.Active := False;
        end;
      finally
        FreeAndNil(DataSet);
      end;
    finally
      Disconnect;
    end;
  finally
    SiMain.LeaveMethod(Self, 'GetData');
  end;
end;

function TRoute.CreateCommand(const SQL: string): TFDCommand;
begin
  SiMain.EnterMethod(Self, 'CreateCommand');
  SiMain.LogString('SQL', SQL);
  Result := TFDCommand.Create(Self);
  InitCommand(Result);
  Result.CommandText.Text := SQL;

  if Result.SQLText <> '' then
    Result.Prepare;

  SiMain.LeaveMethod(Self, 'CreateCommand');
end;

procedure TRoute.InitCommand(command: TFDCommand);
begin
  command.Connection := Connection;
  command.Transaction := Transaction;
  command.FetchOptions.RecordCountMode := cmTotal;
  command.ResourceOptions.SilentMode := true;
end;

procedure TRoute.InitDataSet(DataSet: TFDQuery; const Unidirectional: boolean = true);
begin
  DataSet.Connection := Connection;
  DataSet.Transaction := Transaction;
  DataSet.UpdateTransaction := Transaction;
  DataSet.FetchOptions.Unidirectional := Unidirectional;
  DataSet.FetchOptions.RecordCountMode := cmTotal;
  DataSet.ResourceOptions.SilentMode := true;
end;

procedure TRoute.ExecSQL(const SQL: string; Context: TzContext; Request: TWebRequest; Response: TWebResponse);
var
  i: integer;
  command: TFDCommand;
begin
  Connect(Context);
  try
    command := CreateCommand(SQL);
    try
      Prepare(Request, command);
      command.Execute;
      Response.Render(command);
      command.Close;
    finally
      FreeAndNil(command);
    end;
  finally
    Disconnect;
  end;
end;

end.
