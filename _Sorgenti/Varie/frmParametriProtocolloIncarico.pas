unit frmParametriProtocolloIncarico;

interface

uses
  WinApi.Windows,
  System.SysUtils,
  System.Classes,
  Vcl.Graphics,
  Vcl.Forms,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxClasses,
  dxLayoutContainer,
  dxLayoutControl,
  OkCancel,
  cxContainer,
  cxEdit,
  dxLayoutcxEditAdapters,
  Vcl.ComCtrls,
  dxCore,
  cxDateUtils,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxCalendar,
  cxMemo,
  cxSpinEdit;

type
  TFormParametriProtocolloIncarico = class(TForm)
    dxLayoutControlGroup_Root: TdxLayoutGroup;
    dxLayoutControl: TdxLayoutControl;
    memoRiepilogo: TcxMemo;
    dxLayoutItemRiepilogo: TdxLayoutItem;
    edDataProtocollo: TcxDateEdit;
    dxLayoutItemDataProtocollo: TdxLayoutItem;
    edNumeroProtocollo: TcxTextEdit;
    dxLayoutItemNumeroProtocollo: TdxLayoutItem;
    dxLayoutGroup: TdxLayoutGroup;
    dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem;
    OkCancel: TOkCancel;
    edDataAutorizzazione: TcxDateEdit;
    dxLayoutItemDataAutorizzazione: TdxLayoutItem;
    edParametroRicavoSpecifico: TcxSpinEdit;
    dxLayoutItemParametroRicavo: TdxLayoutItem;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
  public
    function Autorizza(const Protocolla: Boolean; const Riepilogo: String; var DataAutorizzazione, DataProtocollo: TDateTime; var NumeroProtocollo: string;
      out ParametroRicavoSpecifico: double): Boolean;
  end;

function ChiediParametriProtocolloIncarico(const Protocolla: Boolean; const Riepilogo: String; var DataAutorizzazione, DataProtocollo: TDateTime; var NumeroProtocollo: string;
  out ParametroRicavoSpecifico: double): Boolean;

implementation

uses
  Vcl.Dialogs, zDX, zMsg;

{$R *.dfm}

function ChiediParametriProtocolloIncarico(const Protocolla: Boolean; const
    Riepilogo: String; var DataAutorizzazione, DataProtocollo: TDateTime; var
    NumeroProtocollo: string; out ParametroRicavoSpecifico: double): Boolean;
var
  FormParametriProtocolloIncarico: TFormParametriProtocolloIncarico;
begin
  Application.CreateForm(TFormParametriProtocolloIncarico, FormParametriProtocolloIncarico);
  try
    result := FormParametriProtocolloIncarico.Autorizza(Protocolla, Riepilogo, DataAutorizzazione, DataProtocollo, NumeroProtocollo, ParametroRicavoSpecifico);
  finally
    FreeAndNil(FormParametriProtocolloIncarico);
  end;
end;

procedure TFormParametriProtocolloIncarico.FormCreate(Sender: TObject);
begin
  dx.InitLayoutControl(dxLayoutControl);
end;

function TFormParametriProtocolloIncarico.Autorizza(const Protocolla: Boolean; const Riepilogo: String; var DataAutorizzazione, DataProtocollo: TDateTime; var NumeroProtocollo: string;
  out ParametroRicavoSpecifico: double): Boolean;
begin
  memoRiepilogo.Lines.Text := Riepilogo;
  edDataAutorizzazione.Date := DataAutorizzazione;
  edDataProtocollo.Date := DataProtocollo;
  edNumeroProtocollo.Text := NumeroProtocollo;
  edParametroRicavoSpecifico.Clear;

  dxLayoutItemDataProtocollo.Enabled := Protocolla;
  dxLayoutItemNumeroProtocollo.Enabled := Protocolla;

  result := ShowModal = mrOk;

  if result then
  begin
    DataAutorizzazione := edDataAutorizzazione.Date;
    DataProtocollo := edDataProtocollo.Date;
    NumeroProtocollo := edNumeroProtocollo.Text;
    ParametroRicavoSpecifico := edParametroRicavoSpecifico.Value;
  end;
end;

procedure TFormParametriProtocolloIncarico.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;

  if ModalResult = mrOk then
  begin
    if edDataAutorizzazione.Text = '' then
    begin
      CanClose := False;
      ConfirmOk('Data autorizzazione mancante.');
      edDataProtocollo.SetFocus;
    end;

    if (dxLayoutItemDataProtocollo.Enabled) and (edDataProtocollo.Text = '') then
    begin
      CanClose := False;
      ConfirmOk('Data protocollo mancante.');
      edDataProtocollo.SetFocus;
    end;

    if (dxLayoutItemNumeroProtocollo.Enabled) and (edNumeroProtocollo.Text = '') then
    begin
      CanClose := False;
      ConfirmOk('Numero protocollo mancante.');
      edNumeroProtocollo.SetFocus;
    end;
  end;
end;

end.zsystemfrm
