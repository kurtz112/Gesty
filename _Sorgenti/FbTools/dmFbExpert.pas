unit dmFbExpert;

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
  FireDAC.UI.Intf,
  FireDAC.Stan.Async,
  FireDAC.Comp.ScriptCommands,
  FireDAC.Stan.Util,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.VCLUI.Script,
  FireDAC.VCLUI.Wait,
  FireDAC.VCLUI.Async,
  FireDAC.VCLUI.Error,
  FireDAC.Comp.UI,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  FireDAC.Comp.Script,
  Base_DataModule,
  dbMaster, zFbDataSet;

type
  TFbExpert = class(TBaseDataModule)
    FDScript: TFDScript;
    DataSet: TzFbDataSet;
    FDGUIxScriptDialog: TFDGUIxScriptDialog;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDGUIxAsyncExecuteDialog: TFDGUIxAsyncExecuteDialog;
    FDGUIxErrorDialog: TFDGUIxErrorDialog;
    procedure DataModuleCreate(Sender: TObject);
  end;

var
  FbExpert: TFbExpert;

implementation

uses
  ConfigModule;

{$R *.dfm}

procedure TFbExpert.DataModuleCreate(Sender: TObject);
begin
  inherited;
  DataSet.Connection := Config.Database;
  DataSet.Transaction := Config.ReadTrans;
  DataSet.UpdateTransaction := Config.WriteTrans;
end;

end.
