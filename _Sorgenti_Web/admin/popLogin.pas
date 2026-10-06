unit popLogin;

interface

procedure Login;

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
  zz.Web.html,
  zz.Web.user,
  zz.Web.helper,
  AppController,
  AdminDM,
  DevExtreme.factory,
  DevExtreme.Options;

procedure Login;
var
  data: TJSObject;
  frmOptions: TJSObject;
  popOptions: TJSObject;
  items: TJSArray;
  frm: TdxForm;
  pop: TdxPopup;
  popContentId: string;

  function doLogin(e: TJSObject): JSValue;
  begin
    // Admin.Login(JS.ToString(data['usr']), JS.ToString(data['pwd']), JS.ToBoolean(data['RestaConnesso']));

    Admin.Login(data.ToString('usr'), data.ToString('pwd'), data.ToBoolean('RestaConnesso'));
    pop.hide();
    pop.dispose();
  end;

  function doPasswordDimenticata(e: TJSObject): JSValue;
  begin
    Controller.Admin.PasswordDimenticata;
  end;

  function doRegistrazione(e: TJSObject): JSValue;
  begin
    Controller.Admin.Registrazione;
  end;

  function btnLogin: TJSObject;
  var
    buttonOptions: TJSObject;
  begin
    result := TjdxForm.Button('btnLogin', 'Accedi', '', btSuccess, bsContained, haCenter, @doLogin);

    buttonOptions := TJSObject(result['buttonOptions']);
    buttonOptions['width'] := '100%';
  end;

  function btnRegistrati: TJSObject;
  var
    buttonOptions: TJSObject;
  begin
    result := TjdxForm.Button('btnRegistrazione', 'Registrati', '', btDefault, bsContained, haLeft, @doRegistrazione);
    buttonOptions := TJSObject(result['buttonOptions']);
    buttonOptions['width'] := '100%';
  end;

  function btnPasswordSmarrita: TJSObject;
  var
    buttonOptions: TJSObject;
  begin
    result := TjdxForm.Button('btnPasswordSmarrita', 'Recupera password', '', btDefault, bsContained, haLeft, @doPasswordDimenticata);
    buttonOptions := TJSObject(result['buttonOptions']);
    buttonOptions['width'] := '100%';
  end;

  function getItems: TJSArray;
  var
    group: TJSObject;
  begin
    result := TJSArray.new;
    result.push(TjdxForm.Item('usr', 'Username', true));
    result.push(TjdxForm.Password('pwd', 'Password', false)); { TODO : Ripristinare True (required) }
    result.push(btnLogin);
    result.push(TjdxForm.CheckBox('RestaConnesso', 'Resta connesso', false, []));
    result.push(TjdxForm.ItemEmpty);
    group := TjdxForm.group([btnPasswordSmarrita], 1);
    // group := TjdxForm.group([btnRegistrati, btnPasswordSmarrita], 1);
    // group['colCountByScreen'] := dxColCountByScreen(1, 1, 1, 1);
    result.push(group);
    result.push(TjdxForm.ItemEmpty);
  end;

  procedure doOk;
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
        end);
    end
    else
      TdxUtils.alert('Modifica password', TdxValidation.ErrorMessage(j));
  end;

begin
  data := TJSObject.new;
  data['usr'] := user.UserName;
  data['pwd'] := '';
  data['RestaConnesso'] := false;

  frmOptions := dxOptions.Form('');
  frmOptions['formData'] := data;
  frmOptions['colCount'] := 1;
  frmOptions['items'] := getItems;
  frmOptions['labelLocation'] := 'left';
  frmOptions['height'] := 'auto';
  frmOptions['onFieldDataChanged'] := function(e: TJSObject): JSValue
    var
      j: JSValue;
    begin
      j := frm.validate;

      if TdxValidation.isValid(j) then
        TjdxPopup.EnableButton(pop, 'Conferma', true)
      else
        TjdxPopup.EnableButton(pop, 'Conferma', false);
    end;

  /// /////////////////////////////////////////////////

  popOptions := dxOptions.popup('Login', not TdxThemes.dark);
  popContentId := TjdxPopup.ContentId(popOptions);
  popOptions['width'] := '400px';
  popOptions['height'] := 'auto';

  if false then
    popOptions['onContentReady'] :=
    function(e: TJSObject): JSValue var el: TJSElement;
  begin

    el := document.getElementById(popContentId);
    if assigned(el) then
      if not assigned(frm) then
      begin
        pop := TdxPopup(e['component']);
        frm := dxFactory.Form('#' + popContentId, frmOptions);
      end;
  end;

  popOptions['onShowing'] := function(e: TJSObject): JSValue
    var
      el: TJSElement;
    begin
      el := document.getElementById(popContentId);
      if assigned(el) then
      begin
        pop := TdxPopup(e['component']);
        frm := dxFactory.Form('#' + popContentId, frmOptions);
      end;
    end;

  popOptions['onShown'] := function(e: TJSObject): JSValue
    begin

      if assigned(frm) then
      begin
        if data['usr'] = '' then
          frm.FocusEditor('usr')
        else
          frm.FocusEditor('pwd');
      end;
    end;

  { TODO : vedere }
  // Admin.Login(JS.ToString(data['usr']), JS.ToString(data['pwd']), JS.ToBoolean(data['RestaConnesso']));
  TjdxPopup.ShowPopup(popOptions);
end;

end.
