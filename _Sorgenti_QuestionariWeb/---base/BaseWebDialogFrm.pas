unit BaseWebDialogFrm;

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
  BaseWebModalFrm;

type
  TBaseWebDialogForm = class(TBaseWebModalForm)
  protected
    // trovare un nome
    dxModalForm: TdxForm;
    dxModalFormDIV: TJSHTMLElement;
    procedure CreateModalFormDIV(const id: string);
    procedure CreateModalForm(const id: string; options: TJSObject);
  protected
    procedure CalculateFormDimension(const Immediate: boolean); override;
  public
  end;

implementation

uses
  System.Math,
  MainFrm,
  zz.Web.html;

{$R *.dfm}

procedure TBaseWebDialogForm.CreateModalFormDIV(const id: string);
begin
  dxModalFormDIV := CreateDIV(id);
end;

procedure TBaseWebDialogForm.CalculateFormDimension(const Immediate: boolean);

  procedure SetModalFormHeight(const h: integer);
  begin
    if assigned(dxModalFormDIV) then
      dxModalFormDIV.style.setProperty('height', h.ToString + 'px');
  end;

  function HeaderHeight: integer;
  begin
    result := 0;
    if assigned(HeaderDIV) then
      result := JQuery(HeaderDIV).outerHeight(True)
  end;

  function dxFormHeight: integer;
  begin
    result := 0;
    if assigned(dxModalForm) then
      result := dxModalForm.ScrollHeight; // margine superiore del div
  end;

  function OkCancelHeight: integer;
  begin
    result := 0;
    if assigned(OkCancelDIV) then
      result := JQuery(OkCancelDIV).outerHeight(True)
  end;

  function HeaderFooterHeight: integer;
  begin
    result := HeaderHeight + OkCancelHeight;
  end;

  function getNewWidth: integer;
  begin
    result := 0;

    if assigned(dxModalForm) then
      result := DefaultWidth
    else
      result := FormWidth; // modale senza dxform

    if window.InnerWidth < result then
      result := Min(Trunc(window.InnerWidth * 0.8), result);
  end;

  function getNewHeight: integer;
  begin
    result := 0;

    if assigned(dxModalForm) then
      result := HeaderFooterHeight + dxFormHeight
    else
      result := FormHeight; // modale senza dxform, non varia l'altezza

    if window.InnerHeight < result then
      result := Min(Trunc(window.InnerHeight * 0.8), result);
  end;

  function NeedResize(NewWidth, NewHeight: integer): boolean;
  begin
    result := True;

    if abs(NewWidth - FormWidth) <= 1 then
      if abs(NewHeight - FormHeight) <= 1 then
        result := false;
  end;

  procedure SetPlaceholders(NewHeight: integer);
  var
    h: integer;
  begin

    if assigned(dxModalForm) then
    begin
      h := Trunc(HeaderFooterHeight + FormHeight);
      // if NewHeight >= (HeaderFooterHeight + FormHeight) then // normale
      if NewHeight < h then // normale
      begin
        dxModalForm.Placeholders(false);
        dxModalForm.ScrollBarVisible(false);
      end
      else
      begin
        dxModalForm.Placeholders(True);
        dxModalForm.ScrollBarVisible(True);
      end;
    end;
  end;

var
  proc: TProc;
  NewHeight, NewWidth: integer;
begin
  /// ////////////////////

  NewWidth := getNewWidth;
  NewHeight := getNewHeight;
  //
  SetPlaceholders(NewHeight); // ricalcolo dxForm
  NewHeight := getNewHeight; // ricalcolo altezza

  /// ////////////////////

  if NeedResize(NewWidth, NewHeight) then
  begin
    window.clearTimeout(idTimerResize);

    proc := procedure
      var
        clientHeight: integer;
      begin
        if assigned(ResizeObserver) then
          ResizeObserver.UnObserve(container);
        try
          Width := NewWidth;
          Height := NewHeight;
        finally
          if assigned(ResizeObserver) then
            ResizeObserver.Observe(container);
        end;

        if assigned(dxModalForm) then
        begin
          clientHeight := HeaderFooterHeight + FormHeight;

          if NewHeight = clientHeight then // normale
          begin
            // dxModalForm.Placeholders(false);
            SetModalFormHeight(dxModalForm.ScrollHeight);
          end
          else
          begin // ridotta
            // dxModalForm.Placeholders(True);
            SetModalFormHeight(FormHeight - HeaderFooterHeight);
          end;
        end;

        if not Moveable then
          CenterForm;

        Resized;
      end;

    if Immediate then
      proc
    else
      idTimerResize := window.setTimeout(proc, 30);
  end
  else
  begin
    SetModalFormHeight(FormHeight - HeaderFooterHeight);

    if not Moveable then
      CenterForm; // altrimenti form senza dxModalForm non verrebbero centrate
  end;
end;

procedure TBaseWebDialogForm.CreateModalForm(const id: string; options: TJSObject);
begin
  CreateModalFormDIV(id);
  dxModalForm := dxForm('#' + id, options);
end;

end.
