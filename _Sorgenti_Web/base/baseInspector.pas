unit baseInspector;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  JS,
  DevExtreme.Utils,
  DevExtreme.Types;

procedure InspectObject(title: string; obj: TJSObject; OkProc: TdxOkCancelProc; CancelProc: TdxOkCancelProc = nil);

implementation

uses
  Web,
  libjquery,
  DevExtreme.Form,
  DevExtreme.Form.JS,
  DevExtreme.Button.JS,
  DevExtreme.Popup,
  DevExtreme.Popup.JS,
  DevExtreme.validation,
  DevExtreme.themes,
  zz.Web.html,
  DevExtreme.factory,
  DevExtreme.Options;

procedure InspectObject(title: string; obj: TJSObject; OkProc: TdxOkCancelProc; CancelProc: TdxOkCancelProc = nil);
var
  frmOptions: TJSObject;
  popOptions: TJSObject;
  items: TJSArray;
  item: TJSObject;
  popContentId: string;
  propName: string;
  typeOf: string;
  pop: TdxPopup;
  frm: TdxForm;
  btnOptions: TJSObject;

  procedure doOk(closeProc: TProc);
  var
    j: JSValue;
  begin
    j := frm.validate;

    if TdxValidation.isValid(j) then
    begin
      if assigned(OkProc) then
        OkProc;

      closeProc;
    end
    else
      TdxUtils.Alert('Errore', TdxValidation.ErrorMessage(j));
  end;

  procedure doCancel(closeProc: TProc);
  begin
    if assigned(CancelProc) then
      CancelProc;

    closeProc;
  end;

begin
  items := TJSArray.new;

  for propName in TJSObject.keys(obj) do
  begin
    typeOf := jsTypeOf(obj[propName]);
    item := nil;

    if typeOf = 'string' then
      item := TjdxForm.item(propName, propName, false)
    else
      if typeOf = 'number' then
      begin
        item := TjdxForm.item(propName, propName, false);
        item['editorType'] := 'dxNumberBox';
      end
      else
        if typeOf = 'bigint' then
        begin
          item := TjdxForm.item(propName, propName, false);
          item['editorType'] := 'dxNumberBox';
        end
        else
          if typeOf = 'boolean' then
          begin
            item := TjdxForm.item(propName, propName, false);
            item['editorType'] := 'dxCheckBox';
          end
          else
            if typeOf = 'object' then
            begin
              btnOptions := TJSObject.new;
              btnOptions['text'] := propName;
              // btnOptions['type'] := 'default';
              btnOptions['onClick'] := function(e: TJSObject): JSValue
                var
                  btn: TdxButton;
                  o: TJSObject;
                  propName: string;
                begin
                  btn := TdxButton(e['component']);
                  propName := JS.ToString(btn.option('text'));
                  o := JS.ToObject(obj[propName]);

                  InspectObject(propName, o, nil, nil);
                end;

              item := TJSObject.new;
              item['name'] := propName;
              item['itemType'] := 'button';
              item['buttonOptions'] := btnOptions;
              item['propName'] := propName;
              item['horizontalAlignment'] := 'left';
              item['labelMode'] := 'outside';

              if JS.isNull(obj[propName]) then
                item['disabled'] := true;
            end;

    { TODO : gestire i casi object/array per object potrebbe chiamare ricorsivamente InspectObject }

    if assigned(item) then
      items.push(item);
  end;

  frmOptions := dxOptions.Form('');
  frmOptions['formData'] := obj;
  frmOptions['colCount'] := 1;
  frmOptions['items'] := items;
  frmOptions['labelLocation'] := 'left';
  frmOptions['onFieldDataChanged'] := function(e: TJSObject): JSValue
    var
      j: JSValue;
    begin
      // abilita pulsante Conferma
      j := frm.validate;

      if TdxValidation.isValid(j) then
        TjdxPopup.EnableButton(pop, 'Conferma', true)
      else
        TjdxPopup.EnableButton(pop, 'Conferma', false);
    end;

  /// /////////////////////////////////////////////////
  if title.IsEmpty then
    popOptions := dxOptions.Popup(JS.ToString(obj['_title']), not TdxThemes.dark)
  else
    popOptions := dxOptions.Popup(title, not TdxThemes.dark);

  popOptions['width'] := '300px';
  popOptions['height'] := '300px';
  popContentId := TjdxPopup.ContentId(popOptions);

  popOptions['onShowing'] := function(e: TJSObject): JSValue
    var
      el, div_: TJSHTMLElement;
    begin
      pop := TdxPopup(e['component']);
      div_ := TJSHTMLElement(document.getElementById(popContentId));
      el := _DIV(div_, 'inspector');
      el.style.setProperty('width', '100%');
      el.style.setProperty('height', '100%');
      frm := dxFactory.Form('#inspector', frmOptions);
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
