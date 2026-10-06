unit MDI_Lib;

interface

uses
  System.SysUtils,
  System.Classes,

  Vcl.Forms,
  Vcl.Controls,
  BaseFrm,
  SmartInspect.Vcl,
  SmartInspect.Vcl.SiAuto;

type
  TBaseFormClass = class of TBaseForm;

  TFormItem = class(TCollectionItem)
  private
    FForm: TBaseForm;
    procedure SetForm(const Value: TBaseForm);
  protected
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    property Form: TBaseForm read FForm write SetForm;
  end;

  TFormCollection = class(TCollection)
  private
    FActiveForm: TBaseForm;
    FOnChange: TNotifyEvent;
    function GetItem(Index: Integer): TFormItem;
    procedure SetItem(Index: Integer; const Value: TFormItem);
    procedure SetActiveForm(const Value: TBaseForm);
  protected
    Working: boolean;
    function ActiveFormItem: TFormItem;
    procedure doChanged;
    function InternalCreateForm(MdiFormClass: TBaseFormClass): TBaseForm;
  protected
    Busy: boolean;
  public
    constructor Create;
    function Add(Form: TBaseForm): TFormItem;
    procedure Remove(Form: TBaseForm);
    function IndexOf(dbForm: TBaseForm): Integer; overload;
    function IndexOf(ClassName: string): Integer; overload;
    function Insert(Index: Integer): TFormItem;

    function GetForm(MdiFormClass: TBaseFormClass): TBaseForm;
    function FormExists(MdiFormClass: TBaseFormClass): boolean;

    property Items[Index: Integer]: TFormItem read GetItem write SetItem; default;
    property ActiveForm: TBaseForm read FActiveForm write SetActiveForm;

    function CreateForm(MdiFormClass: TBaseFormClass): TBaseForm; overload;
    function CreateForm(MdiFormClass: TBaseFormClass; const PkField: string; const Pk: Variant): TBaseForm; overload;

    procedure ShowForm(dbForm: TBaseForm);
    procedure Test;
  public
    procedure ParamChanged(params: array of string);
    procedure UpdatePolicies;
  public
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

function FormCollection: TFormCollection;

var
  MainUpdatePolicies: TProc = nil;

implementation

uses
  Vcl.Dialogs, zBaseLib, zMsg;

var
  __FormCollection: TFormCollection;

function FormCollection: TFormCollection;
begin
  if not Assigned(__FormCollection) then
    __FormCollection := TFormCollection.Create;

  Result := __FormCollection;
end;

constructor TFormItem.Create(Collection: TCollection);
begin
  inherited;
  FForm := nil;
end;

procedure TFormItem.Assign(Source: TPersistent);
begin
  if Source is TFormItem then
  begin
    if Assigned(Collection) then
      Collection.BeginUpdate;
    try
      Form := TFormItem(Source).Form;
    finally
      if Assigned(Collection) then
        Collection.EndUpdate;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TFormItem.SetForm(const Value: TBaseForm);
begin
  FForm := Value;
end;

function TFormCollection.Add(Form: TBaseForm): TFormItem;
begin
  Result := TFormItem(inherited Add);
  Result.Form := Form;
  doChanged;
end;

function TFormCollection.GetItem(Index: Integer): TFormItem;
begin
  Result := TFormItem(inherited Items[Index]);
end;

function TFormCollection.Insert(Index: Integer): TFormItem;
begin
  Result := TFormItem(inherited Insert(Index));
end;

procedure TFormCollection.Remove(Form: TBaseForm);
var
  idx: Integer;
  i: Integer;
begin
  if ActiveForm = Form then
    FActiveForm := nil;

  idx := IndexOf(Form);
  if idx <> -1 then
    Delete(idx);

  doChanged;
end;

procedure TFormCollection.SetItem(Index: Integer; const Value: TFormItem);
begin
  Items[Index].Assign(Value);
end;

function TFormCollection.IndexOf(dbForm: TBaseForm): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to count - 1 do
    if dbForm = Items[i].Form then
    begin
      Result := i;
      Break;
    end;
end;

function TFormCollection.IndexOf(ClassName: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to count - 1 do
    if SameText(ClassName, Items[i].Form.ClassName) then
    begin
      Result := i;
      Break;
    end;
end;

procedure TFormCollection.SetActiveForm(const Value: TBaseForm);
begin
  FActiveForm := Value;
end;

procedure TFormCollection.ShowForm(dbForm: TBaseForm);
begin
  // If Screen.ActiveForm <> dbForm then //se minimizzata non la pesca
  dbForm.ShowForm(False);
end;

function TFormCollection.ActiveFormItem: TFormItem;
var
  idx: Integer;
begin
  Result := nil;
  if Assigned(ActiveForm) then
  begin
    idx := IndexOf(ActiveForm);
    if idx <> -1 then
      Result := Items[idx];
  end;
end;

function TFormCollection.InternalCreateForm(MdiFormClass: TBaseFormClass): TBaseForm;
var
  idx: Integer;
  item: TFormItem;
  PrevMdiForm: TBaseForm;
begin
  SiMain.LogSeparator;
  SiMain.EnterMethod(Self, 'InternalCreateForm');
  Result := nil;

  if Working then
    exit;

  if Assigned(Screen.ActiveCustomForm) then
    if (fsModal in Screen.ActiveCustomForm.FormState) then
      Screen.ActiveCustomForm.ModalResult := mrCancel;

  PrevMdiForm := ActiveForm;

  if not Assigned(MdiFormClass) then
    exit;

  idx := IndexOf(MdiFormClass.ClassName);
  if idx <> -1 then
    Result := Items[idx].Form
  else
  begin
    Working := True;
    try
      Result := MdiFormClass.Create(Application);

      // 03.11.2008 spostato: prima era in baseform.create. Ora dovrebbe evitare gli errori di form già esistente
      Add(Result);
    finally
      Working := False;
    end;
  end;

  if Assigned(PrevMdiForm) then
  begin
    idx := IndexOf(MdiFormClass.ClassName);
    item := Items[idx];
    idx := IndexOf(PrevMdiForm.ClassName);
  end;
  SiMain.LeaveMethod(Self, 'InternalCreateForm');
end;

function TFormCollection.CreateForm(MdiFormClass: TBaseFormClass): TBaseForm;
begin
  if Working then
    exit(nil);

  Result := InternalCreateForm(MdiFormClass);
  ShowForm(Result);
end;

function TFormCollection.CreateForm(MdiFormClass: TBaseFormClass; const PkField: string; const Pk: Variant): TBaseForm;
begin
  if Working then
    exit(nil);

  Result := InternalCreateForm(MdiFormClass);

  StartWait('Ricerca...');
  try
    Result.PkField := PkField;
    Result.Pk := Pk;
  finally
    StopWait;
  end;

  ShowForm(Result);
end;

constructor TFormCollection.Create;
begin
  inherited Create(TFormItem);
  Working := False;
  Busy := False;
  FOnChange := nil;
end;

function TFormCollection.GetForm(MdiFormClass: TBaseFormClass): TBaseForm;
var
  i: Integer;
begin
  Result := nil;

  for i := 0 to count - 1 do
    if Items[i].Form is MdiFormClass then
    begin
      Result := Items[i].Form;
      exit;
    end;
end;

procedure TFormCollection.UpdatePolicies;
var
  i: Integer;
begin

  if Assigned(MainUpdatePolicies) then
    MainUpdatePolicies;

  for i := count - 1 downto 0 do
    Items[i].Form.UpdatePolicies;
end;

procedure TFormCollection.doChanged;
begin
  if Assigned(FOnChange) then
    OnChange(Self);
end;

function TFormCollection.FormExists(MdiFormClass: TBaseFormClass): boolean;
begin
  Result := Assigned(GetForm(MdiFormClass));
end;

procedure TFormCollection.Test;
  function WindowStateStr(WindowState: TWindowState): string;
  begin
    Result := '';
    case WindowState of
      wsNormal:
        Result := 'wsNormal';
      wsMinimized:
        Result := 'wsMinimized';
      wsMaximized:
        Result := 'wsMaximized';
    end;
  end;

var
  FormItem: TFormItem;
  i: Integer;
  s: string;
begin
  s := '';

  for i := 0 to count - 1 do
  begin
    FormItem := Self.Items[i];

    if Assigned(FormItem.Form) then
      s := s + FormItem.Form.Name + ': ' + WindowStateStr(FormItem.Form.WindowState) + #13;
  end;

  ConfirmOk(s);
end;

procedure TFormCollection.ParamChanged(params: array of string);
var
  i: Integer;
begin
  for i := count - 1 downto 0 do
    Items[i].Form.ParamChanged(params);
end;

initialization

__FormCollection := nil;

finalization

FreeAndNil(__FormCollection);

end.

// FormController
// RegisterForm
// RegisterDataModule
// ShowForm(name:string; const field name:string=''; pk:varriant=null)
//
// se registrata=> crea
// else
// crea una generica
