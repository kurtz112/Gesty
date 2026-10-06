unit BaseWebModalFrm;

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
  zz.Web.JS,
  zz.Web.JSClasses,
  DevExtreme,
  DevExtreme.form,
  DevExtreme.Types,
  BaseWebCustomFrm,
  BaseWebFrm;

type
  TBaseWebModalForm = class(TBaseWebCustomForm)
  protected
    idTimerResize: integer;
    ResizeObserver: TResizeObserver;
    procedure CalculateFormDimension(const Immediate: boolean); virtual;
    procedure Resized; virtual;
  protected
    data: TJSObject;
  private
    HeaderDragPoint: TPoint;
    FMoveable: boolean;
    procedure SetMoveable(const Value: boolean);
    function HeaderMouseDown(aEvent: TJSMouseEvent): boolean;
    function HeaderMouseUp(aEvent: TJSMouseEvent): boolean;
    function HeaderMouseMove(aEvent: TJSMouseEvent): boolean;
  protected
    OkProc: TProc;
    OkCancelDIV: TJSHTMLElement;
    dxFormOkCancel: TdxForm;

    procedure CreateOkCancel(const OkText, AnnullaText: String);
    procedure doAnnulla; virtual;
    procedure doOk; virtual;
  public
    procedure SetFormColor(const color: string);
    procedure SetBorderColor(const color: string);
    procedure SetPadding(const top, right, bottom, left: integer);
    procedure SetSizeable;
    procedure CenterForm;
    property Moveable: boolean read FMoveable write SetMoveable;
  public
    destructor Destroy; override;

    procedure CreateResizeObserver;
    procedure AfterCreate(const id: integer; data: TJSObject; OkProc: TProc); overload; virtual;
    procedure AfterShowModal(AValue: TModalResult); virtual;
  end;

implementation

uses
  System.Math,
  MainFrm,
  zz.Web.html;

{$R *.dfm}

destructor TBaseWebModalForm.Destroy;
begin
  if assigned(ResizeObserver) then
    ResizeObserver.disconnect;

  inherited;
end;

procedure TBaseWebModalForm.AfterCreate(const id: integer; data: TJSObject; OkProc: TProc);
var
  ColorScheme: TApplicationColorScheme;
begin
  inherited AfterCreate;

  Width := DefaultWidth;
  Height := DefaultHeight;
  Self.OkProc := OkProc;
  Self.data := data;

  SetBorderColor('silver');
  SetPadding(ContainerPad, ContainerPad, ContainerPad, ContainerPad);

  SetSizeable;

  //

  ColorScheme := dx.themes.ColorScheme;

  case ColorScheme of
    csNoScheme:
      SetFormColor('white');
    csLight:
      SetFormColor('white');
    csDark:
      SetFormColor('#363640');
  end;
end;

procedure TBaseWebModalForm.AfterShowModal(AValue: TModalResult);
begin
end;

procedure TBaseWebModalForm.SetBorderColor(const color: string);
var
  e: TJSElement;
  s: string;
begin
  e := TJSHTMLElement(container); // contenirore della form

  if e.hasAttribute('style') then
    s := e.getAttribute('style')
  else
    s := '';

  s := s + ' border-color: ' + color + ';';
  e.setAttribute('style', s.trim);
end;

procedure TBaseWebModalForm.SetFormColor(const color: string);
var
  e: TJSElement;
  s: string;
begin
  e := TJSHTMLElement(container); // contenirore della form

  if e.hasAttribute('style') then
    s := e.getAttribute('style')
  else
    s := '';

  s := s + ' background-color: ' + color + ';';
  e.setAttribute('style', s.trim);
end;

procedure TBaseWebModalForm.SetPadding(const top, right, bottom, left: integer);
var
  e: TJSHTMLElement;
  s: string;
begin
  s := px(top) + ' ' + px(right) + ' ' + px(bottom) + ' ' + px(left);
  e := TJSHTMLElement(container);
  e.style.setProperty('padding', s);
end;

procedure TBaseWebModalForm.SetSizeable;
var
  e: TJSHTMLElement;
begin
  { TODO : Verificare overflow }
  e := TJSHTMLElement(container);
  e.style.setProperty('overflow-x', 'auto');
  e.style.setProperty('overflow-y', 'hidden');
  e.style.setProperty('resize', 'both');
end;

procedure TBaseWebModalForm.CenterForm;

  procedure CenterFormHorz;
  var
    w, f, l: integer;
  begin
    w := window.InnerWidth;
    f := FormWidth;
    l := (w - f) div 2;

    left := l;
  end;

  procedure CenterFormVert;
  begin
    top := (window.InnerHeight - FormHeight) div 3;
  end;

begin
  CenterFormHorz;
  CenterFormVert;
end;

procedure TBaseWebModalForm.Resized;
begin

end;

procedure TBaseWebModalForm.CalculateFormDimension(const Immediate: boolean);
var
  proc: TProc;
begin
  window.clearTimeout(idTimerResize);

  proc := procedure
    begin
      CenterForm;
      Resized;
    end;

  if Immediate then
    proc
  else
    idTimerResize := window.setTimeout(proc, 100);
end;

procedure TBaseWebModalForm.CreateOkCancel(const OkText, AnnullaText: String);

  function itemBtnOk: TJSObject;
  var
    buttonOptions, elementAttr: TJSObject;
  begin
    result := dxFormButton('btnOk', OkText, '', btSuccess, smContained, haLeft,
      function(e: TJSObject): boolean
      begin
        doOk;
      end);
    buttonOptions := TJSObject(result['buttonOptions']);
    elementAttr := TJSObject(buttonOptions['elementAttr']);
    elementAttr['style'] := 'width:90%;';
  end;

  function itemBtnAnnulla: TJSObject;
  var
    buttonOptions, elementAttr: TJSObject;
  begin
    result := dxFormButton('btnAnnulla', AnnullaText, '', btDefault, smContained, haRight,
      function(e: TJSObject): boolean
      begin
        doAnnulla;
      end);
    buttonOptions := TJSObject(result['buttonOptions']);
    elementAttr := TJSObject(buttonOptions['elementAttr']);
    elementAttr['style'] := 'width:90%;';
  end;

var
  options, group: TJSObject;
  items: TJSArray;
  IDOkCancel: string;
begin
  IDOkCancel := 'OkCancel_' + random(maxint).ToString;

  options := dxFormOptions('OkCancel', nil);
  items := TJSArray.new;
  group := dxFormGroup([itemBtnOk, itemBtnAnnulla], 2);
  group['colCountByScreen'] := dxColCountByScreen(2, 2, 2, 2);
  items.push(group);
  options.Properties['height'] := 'auto';
  options['items'] := items;

  OkCancelDIV := CreateDIV(IDOkCancel);
  OkCancelDIV.style.setProperty('margin-top', '10px');
  OkCancelDIV.style.setProperty('bottom', '0');
  dxFormOkCancel := dxForm('#' + IDOkCancel, options);
end;

procedure TBaseWebModalForm.CreateResizeObserver;
begin
  CalculateFormDimension(True);
  ResizeObserver := TResizeObserver.new(
    procedure
    begin

      if assigned(container) then
        CalculateFormDimension(False);
    end);

  window.setTimeout(
    procedure
    begin
      ResizeObserver.Observe(container);
    end, 30);
end;

procedure TBaseWebModalForm.doAnnulla;
begin
  Close;
end;

procedure TBaseWebModalForm.doOk;
begin

  if assigned(OkProc) then
  begin
    OkProc;
    Close;
  end;
end;

procedure TBaseWebModalForm.SetMoveable(const Value: boolean);
begin
  FMoveable := Value;

  HeaderDragPoint := point(0, 0);

  if not assigned(HeaderDIV) then
    Exit;

  if Moveable then
    HeaderDIV.OnMouseDown := HeaderMouseDown
  else
    HeaderDIV.OnMouseDown := nil;
end;

function TBaseWebModalForm.HeaderMouseDown(aEvent: TJSMouseEvent): boolean;
begin
  aEvent.preventDefault();
  HeaderDragPoint := point(trunc(aEvent.ClientX), trunc(aEvent.ClientY));

  if assigned(HeaderDIV) then
  begin
    document.OnMouseUp := HeaderMouseUp;
    document.OnMouseMove := HeaderMouseMove;
  end;
end;

function TBaseWebModalForm.HeaderMouseMove(aEvent: TJSMouseEvent): boolean;
var
  p: TPoint;
begin
  aEvent.preventDefault();

  p := point(trunc(HeaderDragPoint.X - aEvent.ClientX), trunc(HeaderDragPoint.Y - aEvent.ClientY));
  HeaderDragPoint := point(trunc(aEvent.ClientX), trunc(aEvent.ClientY));

  FormLeft(FormLeft - p.X);
  FormTop(FormTop - p.Y);
end;

function TBaseWebModalForm.HeaderMouseUp(aEvent: TJSMouseEvent): boolean;
begin
  aEvent.preventDefault();
  HeaderDragPoint := point(0, 0);

  if assigned(HeaderDIV) then
  begin
    document.OnMouseUp := nil;
    document.OnMouseMove := nil;
  end;
end;

end.
