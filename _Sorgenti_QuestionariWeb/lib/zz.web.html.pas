unit zz.web.html;

interface

uses
  System.SysUtils,
  System.Classes,
  System.UITypes,
  WEBLib.JSON,
  WEBLib.Controls,
  libjquery,
  db,
  js,
  web;

const
  cssAccentBackgroundColor = 'dx-theme-accent-as-background-color';
  cssAccentTextColor = 'dx-theme-background-color-as-text-color';
  cssCard = 'dx-card';

const
  ContainerPad = 7;
  DefaultMarginTop = 14;

function ColorToHtml(Color: integer): string;

function CreateElement(tagName: string; Parent: TJSElement; id: string; css: string): TJSElement;
function CreateHTMLElement(tagName: string; Parent: TJSElement; id: string; css: string): TJSHTMLElement;

function _DIV(Parent: TJSElement; const id: string): TJSHTMLElement;
function _SPAN(Parent: TJSElement; const text: string; const id: string): TJSHTMLElement;

function _H1(Parent: TJSElement; const text: string; const id: string; const css: string = ''): TJSHTMLElement;
function _H2(Parent: TJSElement; const text: string; const id: string; const css: string = ''): TJSHTMLElement;
function _H3(Parent: TJSElement; const text: string; const id: string; const css: string = ''): TJSHTMLElement;
function _H4(Parent: TJSElement; const text: string; const id: string; const css: string = ''): TJSHTMLElement;
function _H5(Parent: TJSElement; const text: string; const id: string; const css: string = ''): TJSHTMLElement;

function _HEADER(Parent: TJSElement; const Title: string; const id: string): TJSHTMLElement; overload;
function _HEADER(Parent: TJSElement; const id: string): TJSHTMLElement; overload;
function _FOOTER(Parent: TJSElement; const id: string): TJSHTMLElement;

function _BR(Parent: TJSElement; const id: string = ''): TJSHTMLElement;

function _VSPACE(Parent: TJSElement; const H: integer; const id: string = ''; css: string = ''): TJSHTMLElement;

implementation

function CreateElement(tagName: string; Parent: TJSElement; id: string; css: string): TJSElement;
begin
  result := document.CreateElement(tagName);

  if assigned(Parent) then
    Parent.appendChild(result);

  if id <> '' then
    result.setAttribute('id', id);

  if css <> '' then
    result['class'] := css;
end;

function CreateHTMLElement(tagName: string; Parent: TJSElement; id: string; css: string): TJSHTMLElement;
begin
  result := CreateElement(tagName, Parent, id, css) as TJSHTMLElement;
end;

/// ///////

function _DIV(Parent: TJSElement; const id: string): TJSHTMLElement;
begin
  result := CreateHTMLElement('DIV', Parent, id, '');
end;

function _SPAN(Parent: TJSElement; const text: string; const id: string): TJSHTMLElement;
begin
  result := CreateHTMLElement('SPAN', Parent, id, '');
  result.innerHTML := text;
end;

function _H1(Parent: TJSElement; const text: string; const id: string; const css: string = ''): TJSHTMLElement;
begin
  result := CreateHTMLElement('H1', Parent, id, css);
  result.innerHTML := text;
end;

function _H2(Parent: TJSElement; const text: string; const id: string; const css: string = ''): TJSHTMLElement;
begin
  result := CreateHTMLElement('H2', Parent, id, css);
  result.innerHTML := text;
end;

function _H3(Parent: TJSElement; const text: string; const id: string; const css: string = ''): TJSHTMLElement;
begin
  result := CreateHTMLElement('H3', Parent, id, css);
  result.innerHTML := text;
end;

function _H4(Parent: TJSElement; const text: string; const id: string; const css: string = ''): TJSHTMLElement;
begin
  result := CreateHTMLElement('H4', Parent, id, css);
  result.innerHTML := text;
end;

function _H5(Parent: TJSElement; const text: string; const id: string; const css: string = ''): TJSHTMLElement;
begin
  result := CreateHTMLElement('H5', Parent, id, css);
  result.innerHTML := text;
end;

function _HEADER(Parent: TJSElement; const Title: string; const id: string): TJSHTMLElement;
var
  H3: TJSHTMLElement;
begin
  result := CreateHTMLElement('HEADER', Parent, id, cssAccentBackgroundColor + ' ' + cssAccentTextColor);
  H3 := _H3(result, Title, '');
  H3.style.setProperty('padding', '5px 5px 5px 5px');
end;

function _HEADER(Parent: TJSElement; const id: string): TJSHTMLElement;
begin
  result := CreateHTMLElement('HEADER', Parent, id, cssAccentBackgroundColor);
end;

function _FOOTER(Parent: TJSElement; const id: string): TJSHTMLElement;
begin
  result := CreateHTMLElement('FOOTER', Parent, id, cssAccentBackgroundColor);
end;

function _BR(Parent: TJSElement; const id: string = ''): TJSHTMLElement;
begin
  result := CreateHTMLElement('BR', Parent, id, '');
end;

function _VSPACE(Parent: TJSElement; const H: integer; const id: string = ''; css: string = ''): TJSHTMLElement;
begin
  result := CreateHTMLElement('DIV', Parent, id, css);

  if H > 0 then
    result.style.setProperty('margin-top', H.ToString + 'px');
end;

function ColorToHtml(Color: integer): string;
begin
  result := IntToHex(Color, 6);
  result := '#' + result.Substring(5, 2) + result.Substring(3, 2) + result.Substring(1, 2);
end;

end.
