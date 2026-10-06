unit popPasswordDimenticata;

interface

procedure PasswordDimenticata;

implementation

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  JS,
  Web,
  libjquery,
  DevExtreme.Types,
  DevExtreme.Form,
  DevExtreme.Form.JS,
  DevExtreme.popup,
  DevExtreme.popup.JS,
  DevExtreme.validation,
  DevExtreme.themes,
  DevExtreme.utils,
  DevExtreme.factory,
  DevExtreme.Options,
  zz.Web.html,
  AdminDM;

procedure PasswordDimenticata;
var
  data: TJSObject;
  frmOptions: TJSObject;
  popOptions: TJSObject;
  items: TJSArray;
  frm: TdxForm;
  pop: TdxPopup;
  popContentId: string;

  function itemEmail: TJSObject;
  begin
    result := TjdxForm.Item('email', 'email', true);
    TdxValidation.AddRule(result, TdxValidation.Email('email'));
  end;

  procedure doOk(closeProc: TProc);
  var
    j: JSValue;
  begin
    j := frm.validate;

    if TdxValidation.isValid(j) then
    begin
      Admin.RecuperaPassword(JS.ToString(data['codiceCliente']), JS.ToString(data['email']),
        procedure
        begin
          if assigned(closeProc) then
            closeProc;
        end);
    end
    else
      TdxUtils.alert('Recupero password', TdxValidation.ErrorMessage(j));
  end;

begin
  data := TJSObject.new;
  data['codiceCliente'] := '';
  data['email'] := '';

  items := TJSArray.new;
  items.push(TjdxForm.Item('codiceCliente', 'Codice Cliente', true));
  items.push(itemEmail);

  frmOptions := dxOptions.Form('');
  frmOptions['formData'] := data;
  frmOptions['colCount'] := 1;
  frmOptions['items'] := items;
  frmOptions['labelLocation'] := 'top';
  frmOptions['onFieldDataChanged'] := function(e: TJSObject): JSValue
    var
      j: JSValue;
      NuovaPassword: string;
      i: integer;
    begin
      // abilita pulsante Conferma
      j := frm.validate;

      if TdxValidation.isValid(j) then
        TjdxPopup.EnableButton(pop, 'Conferma', true)
      else
        TjdxPopup.EnableButton(pop, 'Conferma', false);

      /// //////////////////////
      /// imposta qualità password
      j := frm.getEditorValue('nuovaPassword');

      if assigned(j) then
      begin
        NuovaPassword := JS.ToString(j);
        i := Admin.PasswordStrength(NuovaPassword);
      end
      else
        i := 0;

      asm
        frm.updateData('qualitaPassword', i);
      end;
    end;

  /// /////////////////////////////////////////////////

  popOptions := dxOptions.popup('Recupero password', not TdxThemes.dark);
  popOptions['width'] := '300px';
  popOptions['height'] := '400px'; // @@@
  popContentId := TjdxPopup.ContentId(popOptions);

  popOptions['onShowing'] := function(e: TJSObject): JSValue
    var
      w, h: integer;
    begin
      pop := TdxPopup(e['component']);
      frm := dxFactory.Form('#' + popContentId, frmOptions);
    end;

  popOptions['onShown'] := function(e: TJSObject): JSValue
    begin
      frm.FocusEditor('codiceCliente');
    end;

  TjdxPopup.ShowPopupModal(popOptions, @doOk);
end;

end.
