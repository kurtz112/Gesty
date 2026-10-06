unit DevExtreme.Popup;

interface

uses
  System.SysUtils,
  System.Classes,
  Types,
  WEBLib.Controls,
  jsdelphisystem,
  JS,
  Web,
  libjquery,
  DevExtreme.CustomControl,
  DevExtreme.Popup.Custom,
  DevExtreme.Popup.JS,
  DevExtreme.Types;

const
  cssAccentBackgroundColor = 'dx-theme-accent-as-background-color';
  cssAccentTextColor = 'dx-theme-background-color-as-text-color';
  cssCard = 'dx-card';
  PopIdent = 'popId';

type
  TjdxPopup = class(TjdxCustomPopup)
  public
    class function toolbarButton(const text: string; btnType: TdxButtonType; proc: TProc): TJSObject;
    class function toolbarItems(OkProc: TProc; CancelProc: TProc): TJSArray;

    class procedure EnableButton(pop: TjdxPopup; buttonText: string; Enabled: boolean); overload;
    class procedure EnableButton(pop: TdxPopup; buttonText: string; Enabled: boolean); overload;

    class function ContentId(Popup: TdxPopup): string; overload;
    class function ContentId(options: TJSObject): string; overload;
    class function ContentId(PopId: string): string; overload;

    class procedure ShowPopup(options: TJSObject);
    class procedure ShowPopupModal(options: TJSObject; OkProc: TdxOkCancelProc; CancelProc: TdxOkCancelProc = nil);
  end;

  TdxPopupHelper = class helper for TdxPopup
  private
    function GetPopId: string;
    function GetContentId: string;
  public
    procedure EnableButton(buttonText: string; Enabled: boolean);
  public
    property PopId: string read GetPopId;
    property ContentId: string read GetContentId;
  end;

implementation

uses
  DevExtreme.factory;

function internalCreatePopup(options: TJSObject): TdxPopup;
var
  PopId: string;
  el: TJSElement;
begin
  PopId := TjdxPopup.ContentId(options);
  el := document.CreateElement('DIV');
  el.setAttribute('id', 'div_' + PopId);
  document.body.appendChild(el);
  result := dxFactory.Popup('#div_' + PopId, options);
end;

/// ////////////////////////////////////////////////////////////////////////////

procedure TdxPopupHelper.EnableButton(buttonText: string; Enabled: boolean);
begin
  TjdxPopup.EnableButton(self, buttonText, Enabled);
end;

function TdxPopupHelper.GetContentId: string;
begin
  result := TjdxPopup.ContentId(PopId);
end;

function TdxPopupHelper.GetPopId: string;
begin
  result := TjdxPopup.ContentId(option());
end;

/// ////////////////////////////////////////////////////////////////////////////

{ TjdxPopup }

class function TjdxPopup.ContentId(Popup: TdxPopup): string;
var
  options: TJSObject;
begin
  options := Popup.option();
  result := TjdxPopup.ContentId(options);
end;

class function TjdxPopup.ContentId(options: TJSObject): string;
var
  PopId: string;
begin
  PopId := JS.ToString(options[PopIdent]);
  result := TjdxPopup.ContentId(PopId);
end;

class function TjdxPopup.ContentId(PopId: string): string;
const
  contentIdent = 'popup_content_';
begin
  result := contentIdent + PopId;
end;

class procedure TjdxPopup.EnableButton(pop: TdxPopup; buttonText: string; Enabled: boolean);
var
  tb: TJSArray;
  btn: TJSObject;
begin
  tb := TJSArray(pop.option('toolbarItems'));

  tb.forEach(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      btn, options: TJSObject;
    begin
      btn := JS.ToObject(element);
      options := JS.ToObject(btn['options']);
      if SameText(JS.ToString(options['text']), buttonText) then
        options['disabled'] := not Enabled;
    end);

  pop.option('toolbarItems', tb);
end;

class procedure TjdxPopup.EnableButton(pop: TjdxPopup; buttonText: string; Enabled: boolean);
var
  tb: TJSArray;
  btn: TJSObject;
begin
  tb := TJSArray(pop.option('toolbarItems'));

  tb.forEach(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      btn, options: TJSObject;
    begin
      btn := JS.ToObject(element);
      options := JS.ToObject(btn['options']);
      if SameText(JS.ToString(options['text']), buttonText) then
        options['disabled'] := not Enabled;
    end);

  pop.option('toolbarItems', tb);
end;

class procedure TjdxPopup.ShowPopup(options: TJSObject);
var
  pop: TdxPopup;
begin
  pop := internalCreatePopup(options);
  pop.show;
end;

class procedure TjdxPopup.ShowPopupModal(options: TJSObject; OkProc: TdxOkCancelProc; CancelProc: TdxOkCancelProc = nil);
var
  pop: TdxPopup;
begin
  pop := internalCreatePopup(options);

  pop.option('toolbarItems', toolbarItems(
    procedure
    var
      tb: TJSArray;
    begin
      if assigned(OkProc) then
        OkProc(
          procedure
          begin
            pop.hide;
            pop.dispose;
          end)
      else
      begin
        pop.hide;
        pop.dispose;
      end;
    end,
    procedure
    begin
      if assigned(CancelProc) then
        CancelProc(
          procedure
          begin
            pop.hide;
            pop.dispose;
          end)
      else
      begin
        pop.hide;
        pop.dispose;
      end;
    end));

  pop.show;
end;

class function TjdxPopup.toolbarButton(const text: string; btnType: TdxButtonType; proc: TProc): TJSObject;
var
  options: TJSObject;
begin
  options := TJSObject.new;
  options['type'] := btnType.ToString;
  // options['icon']: 'email',
  options['text'] := text;
  options['stylingMode'] := 'contained';
  options['onClick'] := function(e: TJSObject): boolean
    begin
      if assigned(proc) then
        proc;
    end;

  result := TJSObject.new;
  result['widget'] := 'dxButton';
  result['toolbar'] := 'bottom';
  result['location'] := 'after';
  result['options'] := options;
end;

class function TjdxPopup.toolbarItems(OkProc, CancelProc: TProc): TJSArray;
begin
  result := TJSArray.new;
  result.push(toolbarButton('Conferma', btSuccess, OkProc));
  result.push(toolbarButton('Annulla', btDefault, CancelProc));
end;

end.
