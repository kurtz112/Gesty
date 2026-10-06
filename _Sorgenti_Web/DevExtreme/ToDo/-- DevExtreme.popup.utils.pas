unit DevExtreme.popup.utils;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  JS,
  Web,
  libjquery,
  DevExtreme.Types,
  DevExtreme.popup,
  DevExtreme.popup.JS,
  zz.Web.Types;

type
  TjdxPopupHelper = class helper for TjdxPopup
  private
    function GetPopId: string;
    function GetContentId: string;
  public
    procedure EnableButton(buttonText: string; Enabled: boolean);
  public
    property PopId: string read GetPopId;
    property ContentId: string read GetContentId;
  end;

function toolbarButton(const text: string; btnType: TdxButtonType; proc: TProc): TJSObject;
function toolbarItems(OkProc: TProc; CancelProc: TProc): TJSArray;

procedure dxPopupEnableButton(pop: TjdxPopup; buttonText: string; Enabled: boolean); overload;
procedure dxPopupEnableButton(pop: TdxPopup; buttonText: string; Enabled: boolean); overload;

procedure dxShowPopup(options: TJSObject);

function dxPopupOptions(const Title: string = ''; const AccentTitleCss: boolean = false): TJSObject;

procedure dxShowPopupModal(options: TJSObject; OkProc: TCallbackProc; CancelProc: TCallbackProc = nil);

function dxPopupContentId(popup: TdxPopup): string; overload;
function dxPopupContentId(options: TJSObject): string; overload;
function dxPopupContentId(PopId: string): string; overload;

implementation

uses
  zz.Web.html,
  DevExtreme.utils;

const
  PopIdent = 'popId';

function CalcContentId(const PopId: string): string;
const
  contentIdent = 'popup_content_';
begin
  result := contentIdent + PopId;
end;

procedure TjdxPopupHelper.EnableButton(buttonText: string; Enabled: boolean);
begin
  dxPopupEnableButton(self, buttonText, Enabled);
end;

function TjdxPopupHelper.GetContentId: string;
begin
  result := CalcContentId(PopId);
end;

function TjdxPopupHelper.GetPopId: string;
var
  j: JSValue;
begin
  result := '';

  j := self.option(PopIdent);
  result := JS.ToString(j);
end;

function toolbarButton(const text: string; btnType: TdxButtonType; proc: TProc): TJSObject;
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

function toolbarItems(OkProc: TProc; CancelProc: TProc): TJSArray;
begin
  result := TJSArray.new;
  result.push(toolbarButton('Conferma', btSuccess, OkProc));
  result.push(toolbarButton('Annulla', btDefault, CancelProc));
end;

function internalCreatePopup(options: TJSObject): TdxPopup;
var
  PopId: string;
begin
  PopId := JS.ToString(options[PopIdent]);
  _DIV(document.body, 'div_' + PopId);
  result := popup('#div_' + PopId, options);
end;

procedure dxShowPopup(options: TJSObject);
var
  pop: TdxPopup;
begin
  pop := internalCreatePopup(options);
  pop.show;
end;

function dxPopupOptions(const Title: string = ''; const AccentTitleCss: boolean = false): TJSObject;
var
  PopId: string;
begin
  PopId := 'pop' + Random(maxint).ToString;

  result := TJSObject.new;
  result[PopIdent] := PopId;
  result['animation'] := TJSObject.new; // toglie l'effetto in show
  result['hideOnOutsideClick'] := false;
  result['dragOutsideBoundary'] := false;
  result['resizeEnabled'] := True;
  result['shading'] := True;
  result['showCloseButton'] := false;

  if Title.isEmpty then
    result['showTitle'] := false
  else
  begin
    result['showTitle'] := True;
    result['title'] := Title;
  end;

  if AccentTitleCss then
    result['onTitleRendered'] :=
    function(e: TJSObject): JSValue var Title: TJQuery;
  begin
    Title := TJQuery(e['titleElement']);
    Title.addClass(cssAccentBackgroundColor + ' ' + cssAccentTextColor);
  end;

  result['position'] := 'center';
  result['restorePosition'] := True;

  result['width'] := '100px';
  result['height'] := '100px';

  result['maxWidth'] := '97%'; // max/min
  result['maxHeight'] := '97%'; // max/min

  result['contentTemplate'] := function(e: TJSObject): JSValue
    var
      pop: TjdxPopup;
    begin
      result := JQuery('<div id="' + CalcContentId(PopId) + '"></div>');
    end;

  result['onDisposing'] := function(e: TJSObject): JSValue
    var
      pop: TdxPopup;
      PopupId: string;
    begin
      // rimuove il DIV creato all'apertura
      pop := TdxPopup(e['component']);
      PopupId := JS.ToString(pop['PopupId']);

      if not PopupId.isEmpty then
        Window.setTimeout(
          procedure
          var
            div_: TJQuery;
          begin
            div_ := JQuery('#div_' + PopupId);

            if assigned(div_) then
              div_.remove;
          end, 100);
    end;
end;

procedure dxPopupEnableButton(pop: TjdxPopup; buttonText: string; Enabled: boolean);
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

procedure dxPopupEnableButton(pop: TdxPopup; buttonText: string; Enabled: boolean);
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


procedure dxShowPopupModal(options: TJSObject; OkProc: TCallbackProc; CancelProc: TCallbackProc = nil);
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

function dxPopupContentId(PopId: string): string;
begin
  result := CalcContentId(PopId);
end;

function dxPopupContentId(options: TJSObject): string;
var
  PopId: string;
begin
  PopId := JS.ToString(options[PopIdent]);
  result := dxPopupContentId(PopId);
end;

function dxPopupContentId(popup: TdxPopup): string;
var
  PopId: string;
begin
  PopId := JS.ToString(popup.option(PopIdent));
  result := dxPopupContentId(PopId);
end;

end.
