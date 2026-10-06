unit zFBExpert.Engine;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Script,
  FireDAC.VCLUI.Wait,
  FireDAC.VCLUI.Async,
  FireDAC.VCLUI.Login,
  FireDAC.VCLUI.Error,
  FireDAC.Stan.Error,
  FireDAC.Comp.UI,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase,
  FireDAC.Comp.Client,
  FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Util,
  FireDAC.Comp.Script,
  FireDAC.VCLUI.Memo,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  zMetaData,
  zFbDataSet,
  zFbScriptRunner;

type
  TzFBExpertEngine = class(TDataModule)
    FDScript: TFDScript;
    FDGUIxScriptDialog: TFDGUIxScriptDialog;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDGUIxAsyncExecuteDialog: TFDGUIxAsyncExecuteDialog;
    FDGUIxErrorDialog: TFDGUIxErrorDialog;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure FDScriptAfterExecute(Sender: TObject);
    procedure FDScriptConsoleGet(AEngine: TFDScript; const APrompt: string; var AResult: string);
    procedure FDScriptConsolePut(AEngine: TFDScript; const AMessage: string; AKind: TFDScriptOutputKind);
    procedure FDScriptError(ASender, AInitiator: TObject; var AException: Exception);
    procedure FDScriptPause(AEngine: TFDScript; const AText: string);
  private
    FConnection: TFDConnection;
    FDataSet: TzFbDataSet;
    FReadTrans: TFDTransaction;
    FWriteTrans: TFDTransaction;
    FMetadata: TzMetadata;
    procedure ScriptRunnerMessage(Sender: TObject; Kind: TzScriptMessageKind; const Text: string);
  public
    function RunEnabled: boolean;
    procedure Run;
    procedure RunByStep;
    procedure ValidateStep;
  public
    procedure Prepare(const sql: string);
    procedure OpenQuery(const sql: string);
    procedure ExecuteScript(const sql: string);
  public
    logProc: TProc<string>;
    procedure Log(const s: string);
  public
    function CreateElement(const elementName: string; const MetadataElement: TMetadataElement): string;
    function UpdateElement(const elementName: string; const MetadataElement: TMetadataElement): string;
    function DropElement(const elementName: string; const MetadataElement: TMetadataElement): string;
  public
    function dropSelect(const elementName: string; const MetadataElement: TMetadataElement): string;
    function dropExecProc(const elementName: string; const MetadataElement: TMetadataElement): string;
  public
    property Connection: TFDConnection read FConnection;
    property ReadTrans: TFDTransaction read FReadTrans;
    property WriteTrans: TFDTransaction read FWriteTrans;
    property DataSet: TzFbDataSet read FDataSet;
    property Metadata: TzMetadata read FMetadata;
  public
    procedure Init(aConnection: TFDConnection; aReadTrans, aWriteTrans: TFDTransaction; aDataSet: TzFbDataSet; aMetadata: TzMetadata);
    procedure LoadMetadata(const ReopenConnection: boolean = false);
  end;

implementation

uses
  System.Types, System.IniFiles, FireDAC.Stan.Consts, zMetadata.Loader,
  zMetadata.ScriptGenerator, zBaseLib, zMsg;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

type
  TFDReconnectScriptCommand = class(TFDScriptCommand)
  public
    class procedure Keywords(AKwds: TStrings); override;
  end;

  TFDCommitScriptCommand = class(TFDScriptCommand)
  public
    class procedure Keywords(AKwds: TStrings); override;
    function Parse(const AKwd: String): boolean; override;
  end;

class procedure TFDReconnectScriptCommand.Keywords(AKwds: TStrings);
begin
  AKwds.Add('Reconnect');
end;

{ TFDCommitScriptCommand }

class procedure TFDCommitScriptCommand.Keywords(AKwds: TStrings);
begin
  inherited;
  AKwds.Add('COMMIT');
end;

function TFDCommitScriptCommand.Parse(const AKwd: String): boolean;
var
  s: String;
begin
  s := Parser.GetUCWord;
end;

procedure TzFBExpertEngine.DataModuleDestroy(Sender: TObject);
begin
    FDataSet := nil;
end;

/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////
/// ////////////////////////////////////////////////////////////////////////////

procedure TzFBExpertEngine.DataModuleCreate(Sender: TObject);
begin
  FConnection := nil;
  FReadTrans := nil;
  FWriteTrans := nil;
  FDataSet := nil;
  FMetadata := nil;

  FDScript.SQLScripts.Add.Name := 'Script';
end;

procedure TzFBExpertEngine.FDScriptConsoleGet(AEngine: TFDScript; const APrompt: string; var AResult: string);
begin
  InputQuery('Enter value', APrompt, AResult);
end;

procedure TzFBExpertEngine.FDScriptPause(AEngine: TFDScript; const AText: string);
begin
  ConfirmOk(AText + #13#10'Press OK to continue script execution');
end;

procedure TzFBExpertEngine.FDScriptError(ASender, AInitiator: TObject; var AException: Exception);
begin

  if (AException is EFDException) and (EFDException(AException).FDCode = er_FD_ClntDbLoginAborted) then
  begin
    AException.Free;
    AException := EAbort.Create('');
  end;
end;

function TzFBExpertEngine.RunEnabled: boolean;
begin
  Result := not FDScript.Eof;
end;

procedure TzFBExpertEngine.Run;
begin
  FDScript.ValidateAll;

  // if FDScript.Status = ssFinishSuccess then
  // begin
  // FDScript.ExecuteAll;
  // if FDScript.TotalErrors = 0 then
  // StatusBar.Panels[0].Text := 'Done.'
  // else
  // StatusBar.Panels[0].Text := 'Done with errors.';
  // end
  // else
  // StatusBar.Panels[0].Text := 'Failed.'
end;

procedure TzFBExpertEngine.RunByStep;
var
  rPos: TPoint;
begin
  // rPos := ScriptMemo.CaretPos;
  // FDScript.ExecuteStep;
  //
  // if FDScript.TotalErrors = 0 then
  // StatusBar.Panels[0].Text := 'Done.'
  // else
  // begin
  // ScriptMemo.CaretPos := rPos;
  // StatusBar.Panels[0].Text := 'Done with errors.';
  // end;
end;

procedure TzFBExpertEngine.ValidateStep;
begin
  FDScript.ValidateStep;
end;

procedure TzFBExpertEngine.Prepare(const sql: string);
begin
  assert(assigned(DataSet));

  DataSet.Active := false;
  DataSet.Fields.Clear;
  DataSet.sql.Text := sql;
  DataSet.Prepare;
end;

procedure TzFBExpertEngine.OpenQuery(const sql: string);
begin
  assert(assigned(DataSet));

  DataSet.Active := false;
  DataSet.Fields.Clear;
  DataSet.sql.Text := sql;
  DataSet.Active := true;
end;

procedure TzFBExpertEngine.ExecuteScript(const sql: string);
var
  ScriptRunner: TzFbScriptRunner;
  ScriptResult: TzScriptResult;
begin
  // FDScript (TFDScript) non va piu' usato per eseguire lo script: la sua unica
  // classe SET, condivisa da tutte le opzioni SET *, non riconosce SET AUTODDL
  // e falliva con "Token unknown" (il precedente tentativo TFDAutoDDLScriptCommand
  // era codice morto: 'SET' matcha per primo e la sua classe non arriva mai a
  // vedere 'SET AUTODDL'); inoltre TFDScript spezza i comandi al primo ';' e
  // rompe i corpi PSQL con piu' istruzioni. TzFbScriptRunner (zPack\zFIB)
  // risolve entrambi i problemi: salta le direttive isql non supportate e
  // rispetta SET TERM nello split dei comandi.
  ScriptRunner := TzFbScriptRunner.Create(nil);
  try
    ScriptRunner.Connection := Connection;
    ScriptRunner.Transaction := WriteTrans;
    ScriptRunner.StopOnError := False;
    ScriptRunner.OnMessage := ScriptRunnerMessage;

    ScriptResult := ScriptRunner.ExecuteText(sql);

    if ScriptResult.Succeeded then
      Log('Done.')
    else
      Log('Done with errors.');
  finally
    ScriptRunner.Free;
  end;
end;

procedure TzFBExpertEngine.Log(const s: string);
begin

  if assigned(logProc) then
    logProc(s);
end;

procedure TzFBExpertEngine.ScriptRunnerMessage(Sender: TObject; Kind: TzScriptMessageKind; const Text: string);
begin
  Log(Text);
  Application.ProcessMessages;
end;

procedure TzFBExpertEngine.FDScriptAfterExecute(Sender: TObject);
begin

  // StatusBar.Panels[1].Text := 'Delimiter: ' + '[' + FDScript.ScriptOptions.ActualCommandSeparator + ']';
  //
  // if not FDScript.Eof then
  // begin
  // ScriptMemo.CaretPos := FDScript.Position;
  // StatusBar.Panels[2].Text := Format('Position: %d, %d', [FDScript.Position.X, FDScript.Position.Y]);
  // end
  // else
  // begin
  // ScriptMemo.SelStart := ScriptMemo.GetTextLen;
  // StatusBar.Panels[2].Text := 'Position: EOF';
  // end;
end;

procedure TzFBExpertEngine.FDScriptConsolePut(AEngine: TFDScript; const AMessage: string; AKind: TFDScriptOutputKind);
begin
  { TODO : TMemo does not support Objects[] property }

  // if AEngine.CurrentCommand <> nil then
  // LogMemo.Lines.AddObject(AMessage, TObject(AEngine.CurrentCommand.Position.Y))
  // else
  // LogMemo.Lines.AddObject(AMessage, TObject(-1));
  //

  Log(AMessage);
  Application.ProcessMessages;
end;

function TzFBExpertEngine.CreateElement(const elementName: string; const MetadataElement: TMetadataElement): string;
begin
  Result := 'CREATE ' + elementName;
end;

function TzFBExpertEngine.UpdateElement(const elementName: string; const MetadataElement: TMetadataElement): string;
var
  domain: TzmdDomain;
  table: TzmdTable;
  view: TzmdView;
  proc: TzmdProcedure;
  func: TzmdFunction;
  trigger: TzmdTrigger;
  sequence: TzmdGenerator;
  package: TzmdPackage;
begin
  Result := '';

  case MetadataElement of

    meDomain:
      begin
        domain := Metadata.Domains.Get(elementName, false);

        if assigned(domain) then
          Result := TScriptGenerator.domain(domain)
        else
          Result := 'Dominio non trovato: ' + elementName;
      end;
    meTable:
      begin
        table := Metadata.Tables.Get(elementName, false);

        if assigned(table) then
          Result := TScriptGenerator.CreateTable(table)
        else
          Result := 'Tabella non trovata: ' + elementName;
      end;
    meView:
      begin
        view := Metadata.Views.Get(elementName, false);

        if assigned(view) then
          Result := TScriptGenerator.CreateView(view)
        else
          Result := 'View non trovata: ' + elementName;
      end;
    meStoredProc:
      begin
        proc := Metadata.Procedures.Get(elementName, false);

        if assigned(proc) then
          Result := TScriptGenerator.CreateProcImpl(proc)
        else
          Result := 'SP non trovata: ' + elementName;
      end;
    meFunc:
      begin
        func := Metadata.Functions.Get(elementName, false);

        if assigned(func) then
          Result := TScriptGenerator.CreateFunctionImpl(func)
        else
          Result := 'Funzione non trovata: ' + elementName;
      end;
    mePackage:
      begin
        package := Metadata.Packages.Get(elementName, false);

        if assigned(package) then
          Result := TScriptGenerator.CreatePackage(package)
        else
          Result := 'Package non trovato: ' + elementName;
      end;
    meTrigger:
      begin
        trigger := Metadata.Triggers.Get(elementName, false);

        if assigned(trigger) then
          Result := TScriptGenerator.CreateTrigger(trigger)
        else
          Result := 'Trigger non trovata: ' + elementName;
      end;
    meSequence:
      begin
        sequence := Metadata.Generators.Get(elementName, false);

        if assigned(trigger) then
          Result := TScriptGenerator.sequence(sequence)
        else
          Result := 'Generator non trovata: ' + elementName;
      end;
  end;
end;

function TzFBExpertEngine.DropElement(const elementName: string; const MetadataElement: TMetadataElement): string;
begin
  Result := 'DROP ' + elementName;
end;

function TzFBExpertEngine.dropSelect(const elementName: string; const MetadataElement: TMetadataElement): string;
begin
  { TODO : Nel caso di Procedure deve comprendere i parametri di ingresso }
  Result := 'SELECT' + sLineBreak + '  *' + sLineBreak + 'FROM ' + elementName;
end;

function TzFBExpertEngine.dropExecProc(const elementName: string; const MetadataElement: TMetadataElement): string;
begin
  Result := 'EXECUTE PROCEDURE ' + elementName;
end;

procedure TzFBExpertEngine.Init(aConnection: TFDConnection; aReadTrans, aWriteTrans: TFDTransaction; aDataSet: TzFbDataSet; aMetadata: TzMetadata);
begin
  FConnection := aConnection;
  FReadTrans := aReadTrans;
  FWriteTrans := aWriteTrans;
  FDataSet := aDataSet;
  FMetadata := aMetadata;

  FDScript.Connection := Connection;
  FDScript.Transaction := WriteTrans;

  if FMetadata.IsEmpty then
    LoadMetadata(false);
end;

procedure TzFBExpertEngine.LoadMetadata(const ReopenConnection: boolean = false);
begin

  if not assigned(Connection) then
    exit;

  if not assigned(ReadTrans) then
    exit;

  StartWait('Attendere...', true);
  try

    if ReopenConnection then
    begin
      Connection.Connected := false;
      Connection.Connected := true;
    end;

    FillFirebirdMetadata(Metadata, Connection, ReadTrans, true, nil);
  finally
    StopWait;
  end;
end;

initialization

FDScriptCommandRegistry().AddCommand(TFDReconnectScriptCommand);
FDScriptCommandRegistry().AddCommand(TFDCommitScriptCommand);

end.
