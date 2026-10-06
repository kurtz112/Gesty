unit dmFbMonitor;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Base_DataModule,
  dbMaster,
  zFbDataSet,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.Comp.Client;

type
  TFbMonitor = class(TBaseDataModule)
    FDCommand: TFDCommand;
    DataBaseSrc: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  protected
    procedure CreateDataSets; override;
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  private
    procedure doCancelStatement(const datastName: String);
  public
    procedure KillConnection;
    procedure CancelStatement;
    procedure CancelConnectionStatement;
  end;

var
  FbMonitor: TFbMonitor;

implementation

uses
  Gesty_StoredProcs,
  zMsg,
  ConfigModule,
  zBaseLib;

{$R *.dfm}
{ TFbMonitor }

procedure TFbMonitor.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FDCommand.Connection := Config.Database;
  FDCommand.Transaction := WriteTrans;
end;

procedure TFbMonitor.CreateDataSets;
begin
  inherited;
  // se vengono ricreati i dataset lo riassocia
  DataBaseSrc.DataSet := GetDataSet('Monitor_Databases');
  DataBaseSrc.DataSet.Active := true;
end;

procedure TFbMonitor.AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet);
begin

  if sameText(DataSetName, '') then
  begin
  end;
end;

procedure TFbMonitor.CancelConnectionStatement;
begin
  doCancelStatement('Monitor_Attachments_Statements');
end;

procedure TFbMonitor.CancelStatement;
begin
  doCancelStatement('Monitor_Statements');
end;

procedure TFbMonitor.doCancelStatement(const datastName: String);
var
  // sp: TSP_monitor_KILL_CONNECTION;
  DataSet: TzFbDataSet;
  id: integer;
begin
  DataSet := GetDataSet(datastName);

  if DataSet.isEmpty then
    exit;

  if not ConfirmOkCancel('Si desidera annullare lo statement selezionato?') then
    exit;

  id := DataSet.FieldByName('STATEMENT_ID').value;

  StartWait('Attendere...', true);
  try
    FDCommand.Execute('EXECUTE BLOCK AS BEGIN MONITOR.KILL_STATEMENT(' + id.ToString + '); END');
  finally
    StopWait;
  end;
end;

procedure TFbMonitor.KillConnection;
var
  DataSet: TzFbDataSet;
  id: integer;
begin
  DataSet := GetDataSet('Monitor_Attachments');

  if DataSet.isEmpty then
    exit;

  if not ConfirmOkCancel('Si desidera terminare la connessione selezionata?') then
    exit;

  id := DataSet.FieldByName('ATTACHMENT_ID').value;

  StartWait('Attendere...', true);
  try
    FDCommand.Execute('EXECUTE BLOCK AS BEGIN MONITOR.KILL_CONNECTION(' + id.ToString + '); END');
  finally
    StopWait;
  end;
end;

end.
