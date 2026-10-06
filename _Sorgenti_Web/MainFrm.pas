unit MainFrm;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Controls,
  WEBLib.Graphics,
  WEBLib.Controls,
  WEBLib.Forms,
  WEBLib.Dialogs,
  WEBLib.REST,
  JS,
  Web,
  libjquery,
  DevExtreme.Types,
  DevExtreme.CustomControl,
  DevExtreme.Box.JS,
  DevExtreme.Drawer.JS,
  DevExtreme.Toolbar.JS,
  WEBLib.WebCtrls;

const
  Versione = '3.0.5';

type
  TMain = class(TWebForm)
    procedure WebFormCreate(Sender: TObject);
    procedure WebFormShow(Sender: TObject);
  private
    Box: TdxBox;
    Toolbar: TdxToolbar;
    Drawer: TdxDrawer;
  private
    procedure onError(Sender: TObject; AError: TApplicationError; var Handled: Boolean);
  private
    function ToolbarDrawerButton: TJSObject;
    function ToolbarTitle: TJSObject;
    function ToolbarUserLabel: TJSObject;
    function ToolbarThemeSwitcher: TJSObject;
    function ToolbarItems: TJSArray;
  private
    function DrawerTemplate: JSValue;
  private
    procedure DefineMainBox;
    procedure DefineToolbar;
    procedure DefineDrawer;
    procedure DefineFooter;
  public
    procedure StartApplication;
    procedure HideDrawer;
  end;

var
  Main: TMain;

implementation

uses
  zz.Web.url,
  zz.Web.JS,
  zz.Web.user,
  zz.Web.html,
  zz.Web.cordova,
  zz.Web.fetch,
  zz.Web.helper,
  DevExtreme.Utils,
  DevExtreme.List,
  DevExtreme.List.JS,
  DevExtreme.themes,
  DevExtreme.Button.JS,
  images,
  ActionsDM,
  AdminDM,
  DevExtreme.factory;

{$R *.dfm}
{$IFDEF LCLTMSWEB}
{$ENDIF}

procedure TMain.WebFormCreate(Sender: TObject);
begin
  Application.ErrorType := aeSilent;
  Application.onError := onError;
end;

procedure TMain.onError(Sender: TObject; AError: TApplicationError; var Handled: Boolean);
begin
  Handled := False;

  TdxUtils.Alert('Errore', AError.AMessage);
end;

function TMain.ToolbarDrawerButton: TJSObject;
var
  options: TJSObject;
  elementAttr: TJSObject;
begin
  options := TJSObject.new;
  options['icon'] := imageMenu;

  elementAttr := TJSObject.new;
  elementAttr['style'] := 'background-color: inherit;'; // sfondo del bottone
  options['elementAttr'] := elementAttr;

  options['onClick'] := procedure
    begin
      Drawer.toggle;
    end;

  result := TJSObject.new;
  result['widget'] := 'dxButton';
  result['location'] := 'before';
  result['locateInMenu'] := 'never';
  result['options'] := options;
end;

function TMain.ToolbarTitle: TJSObject;
begin
  result := TJSObject.new;
  result['location'] := 'center';
  result['locateInMenu'] := 'never';

  if False then
  begin
    result['template'] := function(): JSValue
      begin
        result := JQuery('<H4 class=''toolbar-label''><b>Gesty</b></H4>');
      end;
  end;

  result['text'] := 'Gesty';
  result['cssClass'] := 'dx-toolbar-label';
end;

function TMain.ToolbarUserLabel: TJSObject;
begin
  result := TJSObject.new;
  result['location'] := 'after';
  result['locateInMenu'] := 'never';
  result['text'] := user.Nominativo;
  result['cssClass'] := 'dx-toolbar-label'; // toobar-nominativo';
end;

function TMain.ToolbarThemeSwitcher: TJSObject;
var
  options: TJSObject;
  elementAttr: TJSObject;

  function currentIcon: string;
  begin
    if TdxThemes.dark then
      result := imageThemeLigth
    else
      result := imageThemeDark;
  end;

begin
  options := TJSObject.new;

  options['icon'] := currentIcon;

  elementAttr := TJSObject.new;
  elementAttr['style'] := 'background-color: inherit;'; // sfondo del bottone
  options['elementAttr'] := elementAttr;

  options['onClick'] := function(e: TJSObject): JSValue
    var
      btn: TdxButton;
      icon: string;
    begin
      TdxThemes.ToggleDarkLight;

      btn := TdxButton(e['component']);
      btn.option('icon', currentIcon);
      Admin.SaveUserTheme;
    end;

  result := TJSObject.new;
  result['widget'] := 'dxButton';
  result['location'] := 'after';
  result['locateInMenu'] := 'never';
  result['options'] := options;
end;

function TMain.ToolbarItems: TJSArray;
var
  Items: TJSArray;
  elementAttr: TJSObject;
begin
  Items := TJSArray.new;
  Items.Push(ToolbarDrawerButton);
  Items.Push(ToolbarTitle);
  // items.Push(ToolbarUserLabel);
  Items.Push(ToolbarThemeSwitcher);

  Actions.AdminItems.forEach(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): Boolean
    var
      btn, options: TJSObject;
    begin
      btn := TJSObject.new;
      btn['widget'] := 'dxButton';
      btn['locateInMenu'] := 'always';

      options := TJSObject.assign(TJSObject.new, JS.ToObject(element));

      elementAttr := TJSObject.new;
      elementAttr['style'] := 'height: 35px;';
      options['elementAttr'] := elementAttr;

      btn['options'] := options;
      Items.Push(btn);
    end);

  result := Items;
end;

procedure TMain.DefineMainBox;
var
  options: TJSObject;
  Items: TJSArray;

  function boxItem(html: string; baseSize: string; ratio: Integer; shrink: Integer): TJSObject;
  begin
    result := TJSObject.new;
    result['html'] := html;
    result['baseSize'] := baseSize;
    result['ratio'] := ratio;
    result['shrink'] := shrink;
  end;

var
  e, span: TJSHTMLElement;
  htmlToolbar, htmlContainer, htmlFooter: string;
begin
  e := _DIV(document.body, 'box');
  e['class'] := 'dx-theme-background-color';
  e.style.setProperty('height', '100%');
  e.style.setProperty('width', '100%');

  { TODO : Colori }
  // htmlToolbar := '<HEADER id="toolbar" class="dx-theme-accent-as-background-color" style="height: 40px; margin-right: 5px;"></HEADER>';
  // htmlContainer := '<DIV id="drawer" style="width:100%; height:100%;"></DIV>';
  // htmlFooter := '<FOOTER id="footer" class="dx-theme-accent-as-background-color"></FOOTER>';
  htmlToolbar := '<HEADER id="toolbar" style="height: 60px; margin-right: 5px;"></HEADER>';
  htmlContainer := '<DIV id="drawer" style="width:100%; height:100%;"></DIV>';
  htmlFooter := '<FOOTER id="footer"></FOOTER>';

  //
  Items := TJSArray.new;
  Items.Push(boxItem(htmlToolbar, '60px', 0, 1));
  Items.Push(boxItem(htmlContainer, '200', 2, 2));
  Items.Push(boxItem(htmlFooter, '25px', 0, 1));
  //
  options := TJSObject.new;
  options['direction'] := 'col';
  options['width'] := '100%';
  options['height'] := '100%';
  options['items'] := Items;
  options['onContentReady'] := function(e: TJSObject): JSValue
    var
      res: TJQuery;
      jq: TJQuery;
    begin
      DefineToolbar;
      DefineDrawer;
      DefineFooter;
    end;

  Box := dxFactory.Box('#box', options);
end;

procedure TMain.DefineDrawer;
var
  options: TJSObject;
begin
  options := new([]);

  // rivedere su screenSize
  // el:= document.querySelector('#dx-6531ed55-d207-759e-f56a-421935928591 > div > div > i');

  // if TdxUtils.IsPhone then
  // options['minSize'] := 1
  // else
  // if TdxUtils.IsTablet then
  // options['minSize'] := 45
  // else
  // options['minSize'] := 35;

  options['minSize'] := 1;
  options['opened'] := True; // not TdxUtils.IsPhone;
  options['hideOnOutsideClick'] := True;
  options['revealMode'] := 'expand';
  options['template'] := DrawerTemplate;

  options['onContentReady'] := function(e: TJSObject): JSValue
    var
      el: TJSHTMLElement;
      minSize: Integer;
      jq: TJQuery;
    begin
      el := TJSHTMLElement(document.body.querySelector('.dx-drawer-content'));
      _DIV(el, 'FormContainer');

      exit; // <---------------------------------------------
      if not TdxUtils.IsPhone then
      begin
        jq := JQuery('#drawer');
        jq := jq.find('.dx-list-item-icon-container:first');

        asm
          try {
          minSize = jq.outerWidth() + 5; // oppure aggiungere il padding del parent
          e['component'].option('minSize', minSize);
           }
          catch (error)  {
          console.error(error);
           }
        end;
      end;
    end;

  Drawer := dxFactory.Drawer('#drawer', options);
end;

function TMain.DrawerTemplate: JSValue;
begin
  result := function: JSValue
    var
      options: TJSObject;
      elementAttr: TJSObject;
    begin
      options := TJSObject.new;
      options['width'] := 300;
      options['grouped'] := True;
      options['items'] := Actions.DrawerMenuItems;
      options['selectionMode'] := 'single';
      options['noDataText'] := '';

      elementAttr := TJSObject.new;
      // color swatch: elementAttr['class'] := 'dx-swatch-gesty-light-cs';
      options['elementAttr'] := elementAttr;

      result := dxFactory.List('<div/>', options).element;
    end;
end;

procedure TMain.HideDrawer;
begin
  if assigned(Drawer) then
    Drawer.hide();
end;

procedure TMain.DefineFooter;

  function Year(date: TDateTime): word;
  var
    y, m, d: word;
  begin
    result := 0;
    DecodeDate(date, y, m, d);
    result := y;
  end;

var
  e, span: TJSHTMLElement;
begin
  e := TJSHTMLElement(document.body.querySelector('#footer'));

  span := _SPAN(e, 'Ver. ' + Versione, 'Versione');
  span.style.setProperty('margin-top', '7px');
  span.style.setProperty('margin-left', '7px');
  span.style.setProperty('float', 'left');

  span := _SPAN(e, 'Luca Zebro ' + Year(date).ToString, 'LucaZebro');
  span.style.setProperty('margin-top', '7px');
  span.style.setProperty('margin-right', '7px');
  span.style.setProperty('float', 'right');
end;

procedure TMain.DefineToolbar;
var
  options: TJSObject;
begin
  options := TJSObject.new;
  options['items'] := ToolbarItems;

  { TODO : Colori }
  // options['onContentReady'] := function(e: TJSObject): JSValue
  // var
  // res: TJQuery;
  // jq: TJQuery;
  // begin
  // jq := TJQuery(e['element']);
  //
  // res := jq.find('[aria-label="overflow"');
  //
  // if assigned(res) then
  // res.addClass(cssAccentBackgroundColor); // + ' ' + cssAccentTextColor);
  // end;

  Toolbar := dxFactory.Toolbar('#toolbar', options);
end;

procedure TMain.WebFormShow(Sender: TObject);
begin
  inherited;

  // dalla 2.3 imposta il body all'altezza della main
  JQuery('body').css('height', '100%');

  // Admin.StartApplication verifica se deve chiamare o meno login
  // Dopo aver caricato le configurazioni dal server chiama
  // Controller.StartApplication, il quale chiama a sua volta
  // Main.StartApplication per costruire la mainForm

  window.setTimeout(
    procedure
    begin
      TdxUtils.Notify('StartApplication');

      Admin.StartApplication;
    end, 300);
end;

procedure TMain.StartApplication;
begin
  DefineMainBox;

  // case user.Ruolo of
  // trOnnipotente:
  // Controller.ApriRicercaIntestatari;
  // Controller.ApriRicercaIntestatari;
  // Controller.ApriDashBoard(user.IdIntestatario);
  // trSistema:
  // end;
end;

end.
