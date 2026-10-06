unit DevExtreme.dataGrid.popup;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  JS,
  libjquery,
  DevExtreme.popup,
  DevExtreme.form,
  DevExtreme.utils,
  zz.web.types;

procedure ShowRecord(const Caption: String; const readOnly: boolean; OkProc: TCallbackProc; InitParams: TdxFormInitParams);

implementation

uses
  DevExtreme,
  DevExtreme.Types,
  DevExtreme.lookup,
  System.Math;

procedure ShowRecord(const Caption: String; const readOnly: boolean; OkProc: TCallbackProc; InitParams: TdxFormInitParams);
var
  formOptions: TJSObject;
  form: TdxForm;
  popOptions: TJSObject;
  pop: TdxPopup;
begin
  formOptions := TdxFormUtils.Options(InitParams);
  formOptions['readOnly'] := readOnly;

//  if not assigned(formOptions['onFieldDataChanged']) then
//  begin
//    formOptions['onFieldDataChanged'] := function(e: TJSObject): JSValue
//      var
//        j: JSValue;
//        dxForm: TdxForm;
//      begin
//        dxForm := TdxForm(e['component']);
//
//        j := dxForm.validate;
//
//        if dx.validation.isValid(j) then
//          dxPopupEnableButton(pop, 'Conferma', true)
//        else
//          dxPopupEnableButton(pop, 'Conferma', false);
//      end;
//  end;

  popOptions := dxPopupOptions(Caption);
  popOptions['onShowing'] := function(e: TJSObject): JSValue
    var
      w, h: integer;
    begin
      pop := TdxPopup(e['component']);
      form := TdxFormUtils.Form('#' + pop.ContentId, formOptions);

      if tdxutils.ScreenSize >= ssMedium then
        pop.option('width', 'auto')
      else
        pop.option('width', '90%');

      pop.option('height', 'auto');
    end;

  popOptions['onShown'] := function(e: TJSObject): JSValue
    var
      w: integer;
    begin

      asm
        e.component.content().find('input').first().focus();
      end;
    end;

  dxShowPopupModal(popOptions, OkProc);
end;

end.
