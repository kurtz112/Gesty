unit dmFbProfiler;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.UITypes,
  Data.DB,
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
  FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  zFbDataSet,
  Base_DataModule,
  dbMaster, Vcl.ExtCtrls;

type
  TProfilerEvent = procedure(const AMessage: string; AColor: TColor) of object;
  TQueryCompleteEvent = procedure(ADuration: Double; ARecords: Int64) of object;

  TFbProfiler = class(TBaseDataModule)
    Sessions: TzFbDataSet;
    Results: TzFbDataSet;
    qryCommand: TzFbDataSet;
    AsyncQry: TzFbDataSet;
    SessionsSrc: TDataSource;
    ResultsSrc: TDataSource;
    FDCommand: TFDCommand;
    PrepareQry: TzFbDataSet;
    AsyncConnection: TFDConnection;
    AsyncTransaction: TFDTransaction;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FCurrentSessionID: Int64;
    FRunning: boolean;
    FExecuting: boolean;
    FQueryStartTime: TDateTime;
    FOnStatusChange: TProfilerEvent;
    FOnQueryComplete: TQueryCompleteEvent;
    FAutoFlush: boolean;

    procedure UpdateStatus(const AMessage: string; AColor: TColor);

    function StartSession(const ADescription: string = 'Query Profiler Session'): boolean;
    function StopSession: boolean;

    procedure InitAsync;
    procedure QueryCompleted(ADuration: Double; ARecCount: Int64);
    procedure QueryFailed(const AErrorMsg: string);
  public
    // Gestione profiling
    function FlushSession: boolean;

    // Esecuzione query
    function ExecuteQuery(const DescSessione: string; const ASQL: string; AAsync: boolean): boolean;
    function CancelQuery: boolean;
    procedure PrepareSQL(const SQL: String);

    // Gestione sessioni
    procedure LoadSessions;
    function DeleteAllSessions(Sessions: TList<integer>): boolean;

    property CurrentSessionID: Int64 read FCurrentSessionID;
    property Running: boolean read FRunning;
    property Executing: boolean read FExecuting;
    property AutoFlush: boolean read FAutoFlush write FAutoFlush;

    // Eventi
    property OnStatusChange: TProfilerEvent read FOnStatusChange write FOnStatusChange;
    property OnQueryComplete: TQueryCompleteEvent read FOnQueryComplete write FOnQueryComplete;
  end;

var
  FbProfiler: TFbProfiler;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses
  System.DateUtils,
  System.Threading,
  Vcl.Graphics,

  zMsg,
  ConfigModule,
  zBaseLib;

{ TFbProfiler }

procedure TFbProfiler.DataModuleCreate(Sender: TObject);
begin
  FRunning := false;
  FExecuting := false;
  FCurrentSessionID := -1;
  FAutoFlush := True;

  InitAsync;
end;

procedure TFbProfiler.DataModuleDestroy(Sender: TObject);
begin
  if Running then
    StopSession;
end;

procedure TFbProfiler.InitAsync;

  procedure Init(ADataSet: TFDRdbmsDataSet);
  begin
    ADataSet.Connection := AsyncConnection;
    ADataSet.Transaction := AsyncTransaction;
    ADataSet.UpdateOptions.AutoCommitUpdates := True;
  end;

begin
  AsyncConnection.Assign(Config.Database);

  Init(AsyncQry);
  Init(qryCommand);

  // AsyncQry sempre in modalità blocking (il thread lo gestiamo noi)
  AsyncQry.ResourceOptions.CmdExecMode := amBlocking;

  FDCommand.Connection := AsyncConnection;
  FDCommand.Transaction := AsyncTransaction;
  FDCommand.UpdateOptions.AutoCommitUpdates := True;
end;

procedure TFbProfiler.UpdateStatus(const AMessage: string; AColor: TColor);
begin
  if Assigned(FOnStatusChange) then
    FOnStatusChange(AMessage, AColor);
end;

{ --- Gestione sessioni profiler --- }

function TFbProfiler.StartSession(const ADescription: string): boolean;
begin
  Result := false;

  if Running then
  begin
    UpdateStatus('Profiling già attivo', clRed);
    Exit;
  end;

  try
    AsyncConnection.Connected := True;

    qryCommand.SQL.Text := 'SELECT PROFILER.START_SESSION(:DESCRIPTION) FROM RDB$DATABASE';
    qryCommand.ParamByName('DESCRIPTION').AsString := ADescription;
    qryCommand.Open;

    FCurrentSessionID := qryCommand.Fields[0].AsLargeInt;
    qryCommand.Close;

    FRunning := True;
    UpdateStatus(Format('Profiling avviato - Session ID: %d', [FCurrentSessionID]), clGreen);
    Result := True;
  except
    on E: Exception do
    begin
      UpdateStatus('Errore avvio profiling: ' + E.Message, clRed);
      FRunning := false;
    end;
  end;
end;

function TFbProfiler.StopSession: boolean;
begin
  Result := false;

  if not Running then
    Exit;

  try
    FlushSession;

    qryCommand.SQL.Text := 'EXECUTE BLOCK AS BEGIN PROFILER.STOP_SESSION(NULL, TRUE); END';
    qryCommand.ExecSQL;

    FRunning := false;
    UpdateStatus(Format('Profiling terminato - Session ID: %d salvata', [FCurrentSessionID]), clBlue);
    FCurrentSessionID := -1;
    Result := True;
  except
    on E: Exception do
      UpdateStatus('Errore stop profiling: ' + E.Message, clRed);
  end;
end;

function TFbProfiler.FlushSession: boolean;
begin
  Result := false;

  if not Running then
    Exit;

  try
    qryCommand.SQL.Text := 'EXECUTE BLOCK AS BEGIN PROFILER.FLUSH_SESSION(NULL); END';
    qryCommand.ExecSQL;
    Result := True;
  except
    on E: Exception do
      UpdateStatus('Errore flush profiling: ' + E.Message, clRed);
  end;
end;

{ --- Esecuzione query --- }

function TFbProfiler.ExecuteQuery(const DescSessione: string; const ASQL: string; AAsync: boolean): boolean;
begin
  Result := false;

  if Trim(ASQL) = '' then
  begin
    UpdateStatus('Query SQL vuota', clRed);
    Exit;
  end;

  if FExecuting then
  begin
    UpdateStatus('Esecuzione già in corso', clRed);
    Exit;
  end;

  if not StartSession(DescSessione) then
    Exit;

  FQueryStartTime := Now;
  FExecuting := True;
  UpdateStatus('Esecuzione query in corso...', clMaroon);

  AsyncQry.SQL.Text := ASQL;

  if AAsync then
  begin
    TTask.Run(
      procedure
      var
        LDuration: Double;
        LRecCount: Int64;
        LErrorMsg: string;
      begin
        try
          AsyncQry.Open;

          LDuration := MilliSecondsBetween(Now, FQueryStartTime);
          LRecCount := AsyncQry.RecordCount;

          TThread.Queue(nil,
            procedure
            begin
              QueryCompleted(LDuration, LRecCount);
            end);
        except
          on E: Exception do
          begin
            LErrorMsg := E.Message;
            TThread.Queue(nil,
              procedure
              begin
                QueryFailed(LErrorMsg);
              end);
          end;
        end;
      end);
  end
  else
  begin
    try
      AsyncQry.Open;
      QueryCompleted(MilliSecondsBetween(Now, FQueryStartTime), AsyncQry.RecordCount);
    except
      on E: Exception do
        QueryFailed(E.Message);
    end;
  end;

  Result := True;
end;

procedure TFbProfiler.QueryCompleted(ADuration: Double; ARecCount: Int64);
begin
  try
    AsyncQry.Close;

    if FAutoFlush and Running then
      FlushSession;

    StopSession;

    UpdateStatus(Format('Query eseguita in %.2f ms - %d record(s)', [ADuration, ARecCount]), clGreen);

    if Assigned(FOnQueryComplete) then
      FOnQueryComplete(ADuration, ARecCount);

    LoadSessions;
    Results.ReOpen();
  finally
    FExecuting := false;
  end;
end;

procedure TFbProfiler.QueryFailed(const AErrorMsg: string);
begin
  try
    AsyncQry.Close;
    StopSession;

    UpdateStatus('Errore query: ' + AErrorMsg, clRed);

    if Assigned(FOnQueryComplete) then
      FOnQueryComplete(-1, -1);
  finally
    FExecuting := false;
  end;
end;

function TFbProfiler.CancelQuery: boolean;
begin
  Result := false;

  if not FExecuting then
    Exit;

  try
    AsyncQry.AbortJob(True);
    AsyncQry.Close;
    UpdateStatus('Query annullata dall''utente', clRed);

    StopSession;
    LoadSessions;

    FExecuting := false;
    Result := True;
  except
    on E: Exception do
    begin
      UpdateStatus('Errore annullamento query: ' + E.Message, clRed);
      FExecuting := false;
    end;
  end;
end;

{ --- Gestione sessioni --- }

procedure TFbProfiler.LoadSessions;
begin
  try
    Sessions.ReOpen();
    UpdateStatus(Format('%d sessioni caricate', [Sessions.RecordCount]), clBlue);
  except
    on E: Exception do
      UpdateStatus('Errore caricamento sessioni: ' + E.Message, clRed);
  end;
end;

function TFbProfiler.DeleteAllSessions(Sessions: TList<integer>): boolean;
var
  id: integer;
  msg: String;
begin
  Result := false;

  if Sessions.Count = 0 then
    Exit;

  if Sessions.Count > 1 then
    msg := 'Elimino tutte le sessioni selezionate?'
  else
    msg := 'Elimino la sessione?';

  Result := ConfirmYesNo(msg);

  if not Result then
    Exit;

  StartWait('Attendere...', True);
  try
    qryCommand.SQL.Text :=
      'EXECUTE BLOCK(PROFILE_ID ID = :PROFILE_ID) AS BEGIN PROFILER.DELETE_SESSION(:PROFILE_ID); END';
    try
      for id in Sessions do
      begin
        qryCommand.ParamByName('PROFILE_ID').AsLargeInt := id;
        qryCommand.ExecSQL;
      end;

      LoadSessions;
      Results.Active := false;
      UpdateStatus('Tutte le sessioni eliminate', clBlue);
      Result := True;
    except
      on E: Exception do
        UpdateStatus('Errore eliminazione sessioni: ' + E.Message, clRed);
    end;
  finally
    StopWait;
  end;
end;

{ --- Prepare --- }

procedure TFbProfiler.PrepareSQL(const SQL: String);
begin
  if Running or FExecuting then
    Exit;

  PrepareQry.Active := false;
  PrepareQry.Fields.Clear;
  PrepareQry.SelectSQL.Text := SQL;
  PrepareQry.Prepare;
end;

end.
