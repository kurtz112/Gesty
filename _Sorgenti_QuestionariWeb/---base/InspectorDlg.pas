unit InspectorDlg;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  JS,
  Web,
  libjquery,
  WEBLib.Graphics,
  WEBLib.Controls,
  WEBLib.Forms,
  WEBLib.Dialogs,
  BaseWebFrm,
  BaseWebModalFrm,
  BaseWebDialogFrm,
  DevExtreme;

type
  TInspectorDialog = class(TBaseWebDialogForm)
  private
    procedure onFieldDataChanged(e: TJSObject);
    procedure SaveObj;
  protected
    procedure doOk; override;
  public
    procedure AfterCreate(const id: integer; data: TJSObject; OkProc: TProc); override;
  end;

var
  InspectorDialog: TInspectorDialog;

procedure InspectObject(title: string; obj: TJSObject; OkProc: TProc);

implementation

uses
  System.Math,
  DevExtreme.Types,
  DevExtreme.Form,
  DevExtreme.Datagrid,
  AppController;

{$R *.dfm}

procedure TInspectorDialog.AfterCreate(const id: integer; data: TJSObject; OkProc: TProc);
var
  options: TJSObject;
  items: TJSArray;
  item: TJSObject;
  propName: string;
  typeOf: string;
  title: string;
begin
  inherited;

  title := JS.ToString(data['_title']);
  CreateHEADER('Inspector: ' + title);

  options := dxFormOptions('InspectorDlg', data);
  options['colCount'] := 1;
  options['labelLocation'] := 'left';
  options['onFieldDataChanged'] := @onFieldDataChanged;

  // copiarli in un nuovo insieme
  items := TJSArray.new;
  for propName in TJSObject.keys(data) do
  begin
    typeOf := jsTypeOf(data[propName]);
    item := nil;

    if typeOf = 'string' then
      item := dxFormItem(propName, propName, false)
    else
      if typeOf = 'number' then
      begin
        item := dxFormItem(propName, propName, false);
        item['editorType'] := 'dxNumberBox';
      end
      else
        if typeOf = 'bigint' then
        begin
          item := dxFormItem(propName, propName, false);
          item['editorType'] := 'dxNumberBox';
        end
        else
          if typeOf = 'boolean' then
          begin
            item := dxFormItem(propName, propName, false);
            item['editorType'] := 'dxCheckBox';
          end;

    // if typeOf = 'object' then

    if assigned(item) then
      items.push(item);
  end;

  if assigned(items) then
  begin
    options['items'] := items;
    CreateModalForm('Inspector', options);
  end;

  //
  CreateOkCancel('Ok', 'Annulla');
end;

procedure TInspectorDialog.SaveObj;
begin

end;

procedure TInspectorDialog.doOk;
var
  j: JSValue;
begin
  j := dxModalForm.validate;

  if dx.validation.isValid(j) then
  begin
    SaveObj;

    inherited;
  end
  else
    DisplayError('Errore', dx.validation.ErrorMessage(j));
end;

procedure TInspectorDialog.onFieldDataChanged(e: TJSObject);
var
  j: JSValue;
begin
  j := dxModalForm.validate;

  if dx.validation.isValid(j) then
    dxModalForm.ButtonEnabled('btnOk', True)
  else
    dxModalForm.ButtonEnabled('btnOk', false);
end;

procedure InspectObject(title: string; obj: TJSObject; OkProc: TProc);
begin
  obj['_title'] := title;
  Controller.Utils.Inspect(obj, OkProc);
end;

end.
