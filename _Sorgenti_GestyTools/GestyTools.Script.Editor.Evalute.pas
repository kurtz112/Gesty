unit GestyTools.Script.Editor.Evalute;

interface

{$I fs.inc}

uses
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  fs_iInterpreter;

type
  TScriptEditorEvalute = class(TForm)
    Label1: TLabel;
    edExpression: TEdit;
    Label2: TLabel;
    memoResult: TMemo;

    procedure FormCreate(Sender: TObject);
    procedure edExpressionKeyPress(Sender: TObject; var Key: Char);
  private
    procedure doEvalute(const expression: string);
  public
    procedure Evalute(const expression: string);
  end;

var
  ScriptEditorEvalute: TScriptEditorEvalute;

implementation

{$R *.dfm}

uses
  System.Variants,
  GestyTools.Script;

procedure TScriptEditorEvalute.FormCreate(Sender: TObject);
begin
  memoResult.Text := '';
end;

procedure TScriptEditorEvalute.edExpressionKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    doEvalute(edExpression.Text);
    edExpression.SelectAll;
  end
  else
    if Key = #27 then
      Close;
end;

procedure TScriptEditorEvalute.Evalute(const expression: string);
begin
  edExpression.Text := expression;
  edExpression.SelectAll;

  doEvalute(expression);

  ScriptEditorEvalute.Show;
  ScriptEditorEvalute.BringToFront;
end;

procedure TScriptEditorEvalute.doEvalute(const expression: string);
begin
  memoResult.Text := ScriptModule.Evaluate(expression);
end;

end.
