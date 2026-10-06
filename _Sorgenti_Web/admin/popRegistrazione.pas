unit popRegistrazione;

interface

procedure Registrazione;

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
  AdminDM, DevExtreme.factory, DevExtreme.Options;

procedure Registrazione;
var
  data: TJSObject;
  frmOptions: TJSObject;
  popOptions: TJSObject;
  items: TJSArray;
  frm: TdxForm;
  pop: TdxPopup;
  popContentId: string;
  idTimer: integer;
  comuni: TJSArray;

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

  function itemEmail: TJSObject;
  begin
    result := TjdxForm.Item('email', 'email', true, [loLabelBold]);
    TdxValidation.AddRule(result, TdxValidation.Email('email'));
  end;

  function itemPassword: TJSObject;
  begin
    result := TjdxForm.Password('password', 'Password', true, [loLabelBold]);
    TdxValidation.AddRule(result, TdxValidation.StringLength('La lunghezza della password deve essere compresa tra 8 e 255 caratteri.', 8, 255));
  end;

  function itemConfermaPwd: TJSObject;
  begin
    result := TjdxForm.Password('confermaPassword', 'Conferma password', true, [loLabelBold]);
    TdxValidation.AddRule(result, TdxValidation.Compare('La password di conferma non corrisponde.', ComparePwdFunc));
  end;

  function itemQualitaPwd: TJSObject;
  var
    editorOptions: TJSObject;
  begin
    result := TjdxForm.Slider('qualitaPassword', 'Qualità Password:', false, [loLabelBold]);
    editorOptions := TJSObject(result['editorOptions']);
    editorOptions['readOnly'] := true;
    editorOptions['min'] := 0;
    editorOptions['max'] := 5;
    editorOptions['value'] := 0;
  end;

  function itemBelfiore: TJSObject;
  var
    editorOptions, dropDownOptions: TJSObject;
  begin
    result := TjdxForm.Item('belfiore', 'Comune', true, [loLabelBold]);
    // result['editorType'] := 'dxLookup';
    result['editorType'] := 'dxSelectBox';

    editorOptions := TjdxForm.editorOptions(result);
    editorOptions['dataSource'] := comuni;
    editorOptions['displayExpr'] := 'COMUNE';
    editorOptions['valueExpr'] := 'BELFIORE';
    editorOptions['searchEnabled'] := true;
    editorOptions['popupHeight'] := 'auto';

    dropDownOptions := TJSObject.new;

    // dropDownOptions['container'] := container;

    editorOptions['dropDownOptions'] := dropDownOptions;

    result['editorOptions'] := editorOptions;
  end;

  procedure LoadComuni;
  begin
    Admin.ComuniAbilitati(
      procedure(data: TJSArray)
      var
        ed: TJSObject;
      begin
        ed := toObject(frm.getEditor('belfiore'));
        asm
          ed.option('dataSource', data);
        end;
      end);
  end;

  procedure doOk(closeProc: TProc);
  var
    j: JSValue;
    s: string;
  begin
    j := frm.validate;

    if TdxValidation.IsValid(j) then
      Admin.RichiestaRegistrazione(JS.ToString(data['codiceCliente']), JS.ToString(data['email']), JS.ToString(data['userName']), JS.ToString(data['password']), JS.ToString(data['codiceFiscale']),
        JS.ToString(data['belfiore']),
        procedure
        begin
          if assigned(closeProc) then
            closeProc;
        end)
    else
      TdxUtils.alert('Registrazione', TdxValidation.ErrorMessage(j));
  end;

begin

  data := TJSObject.new;
  data['codiceCliente'] := '';
  data['email'] := '';
  data['userName'] := '';
  data['password'] := '';
  data['qualitaPassword'] := '';
  data['confermaPassword'] := '';
  data['codiceFiscale'] := '';
  data['belfiore'] := '';

  comuni := TJSArray.new;

  items := TJSArray.new;
  items.push(itemBelfiore);
  items.push(TjdxForm.Item('codiceCliente', 'Codice Cliente', true, [loLabelBold]));
  items.push(TjdxForm.Item('codiceFiscale', 'Codice Fiscale o Partita Iva', true, [loLabelBold]));
  items.push(itemEmail);
  items.push(TjdxForm.Item('userName', 'Username', true, [loLabelBold]));
  items.push(itemPassword);
  items.push(itemConfermaPwd);
  items.push(itemQualitaPwd);

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

      if TdxValidation.IsValid(j) then
        TjdxPopup.EnableButton(pop, 'Conferma', true)
      else
        TjdxPopup.EnableButton(pop, 'Conferma', false);

      /// //////////////////////
      /// imposta qualità password
      j := frm.getEditorValue('password');

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

  popOptions := dxOptions.Popup('Registrazione', not TdxThemes.dark);
  popOptions['width'] := '600px';
  popOptions['height'] := '700px';
  popContentId := TjdxPopup.ContentId(popOptions);

  popOptions['onShowing'] := function(e: TJSObject): JSValue
    begin
      pop := TdxPopup(e['component']);
      frm := dxFactory.Form('#' + popContentId, frmOptions);
    end;

  popOptions['onShown'] := function(e: TJSObject): JSValue
    begin
      frm.FocusEditor('belfiore');
      LoadComuni;
      frm.validate;
    end;

  TjdxPopup.ShowPopupModal(popOptions, @doOk);
end;

end.
