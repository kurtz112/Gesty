unit BaseWebFrmController;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  System.Generics.Collections,
  Vcl.Controls,
  WEBLib.Graphics,
  WEBLib.Controls,
  WEBLib.Forms,
  WEBLib.Dialogs,
  WEBLib.REST,
  JS,
  Web,
  BaseWebFrm;

type
  TBaseWebFormClass = class of TBaseWebForm;

  TBaseWebFormController = class(TComponent)
  private
    Forms: TList<TBaseWebForm>;
  public
    Constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Add(Form: TBaseWebForm);
    procedure Remove(Form: TBaseWebForm);
  public
    procedure ShowForm(BaseWebFormClass: TBaseWebFormClass; var reference; const id: integer = -1);

    procedure CloseActiveForm;
  end;

var
  BaseWebFormController: TBaseWebFormController;

implementation

uses
  System.Math,
  MainFrm;

constructor TBaseWebFormController.Create(AOwner: TComponent);
begin
  inherited;
  Forms := TList<TBaseWebForm>.Create;
end;

destructor TBaseWebFormController.Destroy;
begin
  FreeAndNil(Forms);
  inherited;
end;

procedure TBaseWebFormController.Add(Form: TBaseWebForm);
begin
  Forms.Add(Form);
end;

procedure TBaseWebFormController.Remove(Form: TBaseWebForm);
begin
  Forms.Remove(Form);
end;

procedure TBaseWebFormController.ShowForm(BaseWebFormClass: TBaseWebFormClass; var reference; const id: integer = -1);
var
  Form: TBaseWebForm;

  procedure doAfterCreate(AForm: TObject);
  begin
    (AForm as TBaseWebForm).AfterCreate(id);
  end;

begin
  if assigned(main) then
   main.HideDrawer;

  Form := BaseWebFormClass.CreateNew('FormContainer', @doAfterCreate);
  reference := Form;
  Form.Popup := False;
end;

procedure TBaseWebFormController.CloseActiveForm;
var
  F: TCustomForm;
begin
  F := Application.ActiveForm;
  if assigned(F) then
    if F <> main then
      F.Close;
end;

initialization

BaseWebFormController := TBaseWebFormController.Create(Application);

end.
