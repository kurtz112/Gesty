unit popCambioPassword;

interface

procedure CambioPassword;

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
  zz.Web.user,
  zz.Web.html,
  AdminDM,
  AppController;

procedure CambioPassword;
const
  MinPasswordLength = 3;

var
  data: TJSObject;
  frmOptions: TJSObject;
  popOptions: TJSObject;
  items: TJSArray;
  frm: TdxForm;
  pop: TdxPopup;
  popContentId: string;

  function ComparePwdFunc: TJSFunction;
    function GetPassword: JSValue;
    var
      j: JSValue;
    begin
      j := frm.getEditorValue('nuovaPassword');
      result := j;
    end;

  begin
    result := TJSFunction(@GetPassword);
  end;

  function itemAttualePwd: TJSObject;
  begin
    result := TjdxForm.Password('passwordCorrente', 'Password attuale', true);
    TdxValidation.AddRule(result, TdxValidation.StringLength('La lunghezza della password deve essere compresa tra ' + MinPasswordLength.ToString + ' e 255 caratteri.', MinPasswordLength, 255));
  end;

  function itemNuovaPwd: TJSObject;
  begin
    result := TjdxForm.Password('nuovaPassword', 'Nuova password', true);
    TdxValidation.AddRule(result, TdxValidation.StringLength('La lunghezza della password deve essere compresa tra ' + MinPasswordLength.ToString + ' e 255 caratteri.', MinPasswordLength, 255));
  end;

  function itemConfermaPwd: TJSObject;
  begin
    result := TjdxForm.Password('confermaPassword', 'Conferma password', true);
    TdxValidation.AddRule(result, TdxValidation.Compare('La password di conferma non corrisponde.', ComparePwdFunc));
  end;

  function itemQualitaPwd: TJSObject;
  var
    editorOptions: TJSObject;
  begin
    result := TjdxForm.Slider('qualitaPassword', 'Qualità Password:', false);
    editorOptions := TJSObject(result['editorOptions']);
    editorOptions['readOnly'] := true;
    editorOptions['value'] := 0;
    editorOptions['max'] := 5;
  end;

  procedure doOk(closeProc: TProc);
  var
    j: JSValue;
    s: string;
  begin
    j := frm.validate;

    if TdxValidation.isValid(j) then
    begin
      Admin.ModificaPassword(JS.ToString(data['passwordCorrente']), JS.ToString(data['nuovaPassword']),
        procedure
        begin
          if assigned(closeProc) then
            closeProc;

          if user.PasswordScaduta then
            Controller.Admin.Login;
        end);
    end
    else
      TdxUtils.alert('Modifica password', TdxValidation.ErrorMessage(j));
  end;

  procedure doCancel(closeProc: TProc);
  begin
    // se proviene da login/password scadura deve tornare al login,
    // altrimenti chiude e basta
    if assigned(closeProc) then
      closeProc;

    if user.PasswordScaduta then
      Controller.Admin.Login;
  end;

begin
  data := TJSObject.new;
  data['passwordCorrente'] := '';
  data['nuovaPassword'] := '';
  data['qualitaPassword'] := '';
  data['confermaPassword'] := '';

  items := TJSArray.new;
  items.push(itemAttualePwd);
  items.push(itemNuovaPwd);
  items.push(itemConfermaPwd);
  items.push(itemQualitaPwd);

  frmOptions := dxOptions.Form('');
  frmOptions['formData'] := data;
  frmOptions['colCount'] := 1;
  frmOptions['items'] := items;
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

  popOptions := dxOptions.popup('Modifica password', not TdxThemes.dark);
  popOptions['width'] := '400px';
  popOptions['height'] := '450px';
  popContentId := TjdxPopup.ContentId(popOptions);

  popOptions['onShowing'] := function(e: TJSObject): JSValue
    begin
      pop := TdxPopup(e['component']);
      frm := dxFactory.Form('#' + popContentId, frmOptions);
    end;

  popOptions['onShown'] := function(e: TJSObject): JSValue
    begin
      asm
        e.component.content().find('input').first().focus();
      end;
    end;

  TjdxPopup.ShowPopupModal(popOptions, @doOk, @doCancel);
end;

end.
