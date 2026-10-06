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
  BaseWebCustomFrm,
  BaseWebFrm,
  BaseWebModalFrm;

type
  TBaseWebCustomFormClass = class of TBaseWebCustomForm;
  TBaseWebFormClass = class of TBaseWebForm;
  TBaseWebModalFormClass = class of TBaseWebModalForm;

  TBaseWebFormController = class(TComponent)
  private
    PrevActiveModalForm: TBaseWebModalForm;
    Forms: TList<TBaseWebCustomForm>;
  public
    Constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Add(Form: TBaseWebCustomForm);
    procedure Remove(Form: TBaseWebCustomForm);
  public
    procedure ShowForm(BaseWebFormClass: TBaseWebFormClass; var reference; const id: integer = -1);
    procedure ShowFormModal(BaseWebModalFormClass: TBaseWebModalFormClass; var reference; const id: integer = -1; data: TJSObject = nil; OkProc: TProc = nil);

    function ActiveModalForm: TBaseWebModalForm;
    procedure CenterModalForms;
    procedure CloseActiveModalForm;
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
  PrevActiveModalForm := nil;
  Forms := TList<TBaseWebCustomForm>.Create;
end;

destructor TBaseWebFormController.Destroy;
begin
  FreeAndNil(Forms);
  inherited;
end;

procedure TBaseWebFormController.Add(Form: TBaseWebCustomForm);
begin
  Forms.Add(Form);
end;

procedure TBaseWebFormController.Remove(Form: TBaseWebCustomForm);
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
    if assigned(main.drawer) then
      main.drawer.hide();

  Form := BaseWebFormClass.CreateNew('FormContainer', @doAfterCreate);
  reference := BaseWebForm;
  Form.Popup := False;
end;

procedure TBaseWebFormController.ShowFormModal(BaseWebModalFormClass: TBaseWebModalFormClass; var reference; const id: integer = -1; data: TJSObject = nil; OkProc: TProc = nil);
var
  BaseWebModalForm: TBaseWebModalForm;

  procedure doAfterCreate(AForm: TObject);
  var
    F: TBaseWebModalForm;
  begin
    F := TBaseWebModalForm(AForm);
    F.AfterCreate(id, data, OkProc);
    F.CreateResizeObserver;
  end;

  procedure doAfterShowModal(AValue: TModalResult);
  begin
    BaseWebModalForm.AfterShowModal(AValue);

    if assigned(PrevActiveModalForm) then
      PrevActiveModalForm.Show;
  end;

begin
  if assigned(main) then
    if assigned(main.drawer) then
      main.drawer.hide();

  BaseWebFormController.PrevActiveModalForm := ActiveModalForm;

  BaseWebModalForm := BaseWebModalFormClass.CreateNew(@doAfterCreate);
  reference := BaseWebModalForm;
  BaseWebModalForm.Popup := True;
  BaseWebModalForm.PopupOpacity := 0.5;
  BaseWebModalForm.ShowModal(@doAfterShowModal);
end;

function TBaseWebFormController.ActiveModalForm: TBaseWebModalForm;
var
  CustomForm: TCustomForm;
begin
  result := nil;

  CustomForm := Application.ActiveForm;
  if assigned(CustomForm) then
    if CustomForm is TBaseWebModalForm then
    begin
      result := TBaseWebModalForm(CustomForm);
      exit;
    end;
end;

procedure TBaseWebFormController.CenterModalForms;
var
  F: TBaseWebCustomForm;
begin
  for F in Forms do
    if F is TBaseWebModalForm then
      TBaseWebModalForm(F).CenterForm;
end;

procedure TBaseWebFormController.CloseActiveModalForm;
var
  F: TBaseWebCustomForm;
begin
  for F in Forms do
    if F is TBaseWebModalForm then
      TBaseWebModalForm(F).Close;
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
