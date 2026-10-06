unit BaseWebFrm;

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
  DevExtreme.form,
  DevExtreme.Types;

type
  TBaseWebForm = class(TWebForm)
    procedure WebFormCreate(Sender: TObject);
    procedure WebFormClose(Sender: TObject; var Action: TCloseAction);
    procedure WebFormShow(Sender: TObject);
  private
    FHeaderImage: string;
    HeaderDIV: TJSHTMLElement;
  protected
    procedure CreateHEADER(const header: string);
    function CreateDIV(const id: string): TJSHTMLElement;
    function CreateMainDIV(const id: string; const addSpace: boolean = true): TJSHTMLElement;
    function VSpace(H: integer): TJSHTMLElement;
  public
    [async]
    procedure AfterCreate(const id: integer = -1); virtual;
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
  zz.Web.html,
  DevExtreme.utils,
  BaseWebFrmController,
  MainFrm;

{$R *.dfm}

procedure TBaseWebForm.WebFormCreate(Sender: TObject);
begin
  FHeaderImage := '';
  BaseWebFormController.Add(Self);
end;

procedure TBaseWebForm.WebFormClose(Sender: TObject; var Action: TCloseAction);
begin
  BaseWebFormController.Remove(Self);
end;

procedure TBaseWebForm.WebFormShow(Sender: TObject);
begin
  // dalla 2.3 imposta il container a self.height
  JQuery('#' + FormContainer).css('height', '100%');
end;

procedure TBaseWebForm.AfterCreate(const id: integer);
begin
  ElementClassName := 'dx-theme-background-color';
end;

function TBaseWebForm.CreateDIV(const id: string): TJSHTMLElement;
begin
  result := _DIV(container, id);
end;

procedure TBaseWebForm.CreateHEADER(const header: string);
begin
  HeaderDIV := _HEADER(container, header, 'header');
  HeaderDIV.style.setProperty('margin-bottom', '10px');
end;

function TBaseWebForm.CreateMainDIV(const id: string; const addSpace: boolean = true): TJSHTMLElement;
begin

  if addSpace then
    VSpace(15);

  result := CreateDIV(id);
  result.style.setProperty('width', '100%');
  result.style.setProperty('height', '100%');
end;

procedure TBaseWebForm.OpenPDF(const Url: String);
begin
  Application.Navigate(Url, TNavigationTarget.ntBlank);
end;

procedure TBaseWebForm.DisplayError(const Title, msg: string);
begin
  TdxUtils.alert(Title, msg);
end;

procedure TBaseWebForm.ShowMessage(const Title, msg: string);
begin
  TdxUtils.alert(Title, msg);
end;

function TBaseWebForm.VSpace(H: integer): TJSHTMLElement;
begin
  result := _VSPACE(container, H);
end;

procedure TBaseWebForm.Confirm(const Title, msg: string; OkProc, CancelProc: TProc);
begin
  TdxUtils.Confirm(Title, msg, OkProc, CancelProc);
end;

procedure TBaseWebForm.ScrollTo(id: string);
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
