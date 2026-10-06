unit baseEditorJson;

interface

uses
  System.SysUtils,
  System.Classes,
  types,
  JS,
  web,
  DevExtreme.types;

procedure EditJSObject(const title: string; options: TJSObject; ReturnProc: TEditOptionsReturnProc);

implementation

uses
  DevExtreme.popup,
  DevExtreme.popup.JS,
  zz.web.JS,
  zz.web.html,
  libjquery,
  DevExtreme.options, zz.web.json;

procedure EditJSObject(const title: string; options: TJSObject; ReturnProc: TEditOptionsReturnProc);
var
  popOptions: TJSObject;
  popContentId: string;

  procedure doCancel(closeProc: TProc);
  begin
    if assigned(closeProc) then
      closeProc;
  end;

begin
  popOptions := dxOptions.popup(title, true); // not TdxThemes.dark);
  popOptions['width'] := '80%';
  popOptions['height'] := '80%';
  popContentId := TjdxPopup.ContentId(popOptions);

  popOptions['onShowing'] := function(e: TJSObject): JSValue
    var
      el, div_: TJSHTMLElement;
      s: string;
    begin
      div_ := TJSHTMLElement(document.getElementById(popContentId));
      el := _DIV(div_, 'editor');
      el.style.setProperty('width', '100%');
      el.style.setProperty('height', '100%');

      s := Stringify(options, true);

      asm
        var editor = ace.edit("editor");
        editor.setTheme("ace/theme/tomorrow_night_blue");
        editor.session.setMode("ace/mode/json");
        editor.setValue(s);
      end;
    end;

  popOptions['onShown'] := function(e: TJSObject): JSValue
    begin
      asm
        e.component.content().find('input').first().focus();
      end;
    end;
  // >
  TjdxPopup.ShowPopupModal(popOptions,
    procedure(callBack: TProc)
    var
      s: String;
      o: TJSObject;
    begin
      asm
        var editor = ace.edit("editor");
        s = editor.getValue();
      end;

      o := Parse(s);

      asm
        delete o["integrationOptions"];
      end;

      ReturnProc(o, callBack);
    end, @doCancel);
end;

end.
