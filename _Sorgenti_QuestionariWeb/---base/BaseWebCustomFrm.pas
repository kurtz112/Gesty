unit BaseWebCustomFrm;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  System.Generics.Collections,
  Vcl.Controls,
  WEBLib.Graphics,
  WEBLib.Controls,
  WEBLib.Forms,
  WEBLib.Dialogs,
  WEBLib.REST,
  JS,
  Web,
  libjquery,
  zz.Web.JSClasses,
  DevExtreme,
  DevExtreme.form,
  DevExtreme.Types;

type
  TBaseWebCustomForm = class(TWebForm)
    procedure WebFormClose(Sender: TObject; var Action: TCloseAction);
    procedure WebFormCreate(Sender: TObject);
  private
    FHeaderImage: string;
  protected
    HeaderDIV: TJSHTMLElement;
    procedure CreateStructure; virtual;

    procedure CreateHEADER(const header: string);
    function CreateDIV(const id: string): TJSHTMLElement;
    function VSpace(H: integer): TJSHTMLElement;
  protected
    function DefaultHeight: integer; virtual;
    function DefaultWidth: integer; virtual;

    function FormWidth: integer;
    function FormHeight: integer;

    function FormLeft: integer; overload;
    procedure FormLeft(aLeft: integer); overload;
    function FormTop: integer; overload;
    procedure FormTop(aTop: integer); overload;
  public
    procedure AfterCreate; overload; virtual;
  public
    procedure OpenPDF(const Url: String);
    procedure ScrollTo(id: string);
  public
    procedure ShowMessage(const Title, msg: string);
    procedure DisplayError(const Title, msg: string);
    procedure Confirm(const Title, msg: string; OkProc: TProc; CancelProc: TProc);
  public
    property HeaderImage: string read FHeaderImage write FHeaderImage;
  end;

implementation

uses
  System.Math,
  MainFrm,
  BaseWebFrmController,
  zz.Web.html;

{$R *.dfm}

procedure TBaseWebCustomForm.WebFormCreate(Sender: TObject);
begin
  FHeaderImage := '';
  BaseWebFormController.Add(Self);
end;

procedure TBaseWebCustomForm.WebFormClose(Sender: TObject; var Action: TCloseAction);
begin
  BaseWebFormController.Remove(Self);
end;

function TBaseWebCustomForm.CreateDIV(const id: string): TJSHTMLElement;
begin
  result := _DIV(container, id);
end;

procedure TBaseWebCustomForm.CreateHEADER(const header: string);
begin
  HeaderDIV := _HEADER(container, header, 'header');
  HeaderDIV.style.setProperty('margin-bottom', '10px');
end;

procedure TBaseWebCustomForm.CreateStructure;
begin
end;

procedure TBaseWebCustomForm.OpenPDF(const Url: String);
begin
  Application.Navigate(Url, TNavigationTarget.ntBlank);
end;

procedure TBaseWebCustomForm.DisplayError(const Title, msg: string);
begin
  dx.utils.alert(Title, msg);
end;

procedure TBaseWebCustomForm.ShowMessage(

  const Title, msg: string);
begin
  dx.utils.alert(Title, msg);
end;

function TBaseWebCustomForm.VSpace(H: integer): TJSHTMLElement;
begin
  result := _VSPACE(container, H);
end;

function TBaseWebCustomForm.FormHeight: integer;
begin
  result := 0;

  if not assigned(container) then
    exit;

  result := container.clientHeight;

  if not TJSHTMLElement(container).style.getPropertyValue('padding').isEmpty then
    result := result - (ContainerPad * 2);
end;

procedure TBaseWebCustomForm.FormLeft(aLeft: integer);
begin
  TJSHTMLElement(container).style.setProperty('left', aLeft.ToString + 'px');
end;

function TBaseWebCustomForm.FormLeft: integer;
var
  s: string;
begin
  result := 0;

  if not assigned(container) then
    exit;

  s := TJSHTMLElement(container).style.getPropertyValue('left');

  s := s.replace('px', '');

  result := s.ToInteger;
end;

procedure TBaseWebCustomForm.FormTop(aTop: integer);
begin
  TJSHTMLElement(container).style.setProperty('top', aTop.ToString + 'px');
end;

function TBaseWebCustomForm.FormTop: integer;
var
  s: string;
begin
  result := 0;

  if not assigned(container) then
    exit;

  s := TJSHTMLElement(container).style.getPropertyValue('top');

  s := s.replace('px', '');

  result := s.ToInteger;
end;

function TBaseWebCustomForm.FormWidth: integer;
begin
  result := 0;

  if not assigned(container) then
    exit;

  result := container.clientWidth;

  if not TJSHTMLElement(container).style.getPropertyValue('padding').isEmpty then
    result := result - (ContainerPad * 2);
end;

procedure TBaseWebCustomForm.AfterCreate;
begin
  CreateStructure;
end;

procedure TBaseWebCustomForm.Confirm(const Title, msg: string; OkProc, CancelProc: TProc);
begin
  dx.utils.Confirm(Title, msg, OkProc, CancelProc);
end;

function TBaseWebCustomForm.DefaultHeight: integer;
begin
  result := 300;
end;

function TBaseWebCustomForm.DefaultWidth: integer;
begin
  result := 300;
end;

procedure TBaseWebCustomForm.ScrollTo(id: string);
var
  e: TJSElement;
begin
  e := document.getElementByID(id);

  if assigned(e) then
  asm
    e.scrollIntoView(true);
    setTimeout(function(){ $('html, body').scrollTop(0); }, 100); // altrimenti scrolla la toolbar
  end;
end;

end.
