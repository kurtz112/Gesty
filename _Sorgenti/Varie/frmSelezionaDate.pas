unit frmSelezionaDate;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Buttons,
  ExtCtrls,
  cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  Vcl.Menus,
  cxControls,
  cxContainer,
  cxEdit,
  Vcl.ComCtrls,
  dxCore,
  cxDateUtils,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxCalendar,
  cxButtons, dxUIAClasses;

type
  TFormSelezionaDate = class(TForm)
    PanelBottoni: TPanel;
    BitBtn1: TcxButton;
    BitBtn2: TcxButton;
    edAlGiorno: TcxDateEdit;
    edDalGiorno: TcxDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    function Edit(var DalGiorno, AlGiorno: TDateTime): Boolean;
    { Public declarations }
  end;

function SelezionaDate(var DalGiorno, AlGiorno: TDateTime): Boolean;

implementation

uses
  zMsg;

{$R *.DFM}
{ TFormSelezionaDate }

function SelezionaDate(var DalGiorno, AlGiorno: TDateTime): Boolean;
var
  FormSelezionaDate: TFormSelezionaDate;
begin
  result := false;

  Application.CreateForm(TFormSelezionaDate, FormSelezionaDate);
  try
    result := FormSelezionaDate.Edit(DalGiorno, AlGiorno);
  finally
    FreeAndNil(FormSelezionaDate);
  end;
end;

function TFormSelezionaDate.Edit(var DalGiorno, AlGiorno: TDateTime): Boolean;
begin
  edDalGiorno.Date := DalGiorno;
  edAlGiorno.Date := AlGiorno;

  ActiveControl := edDalGiorno;
  result := ShowModal = mrOk;
  if result then
  begin
    DalGiorno := edDalGiorno.Date;
    AlGiorno := edAlGiorno.Date;
  end;
end;

procedure TFormSelezionaDate.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult = mrOk then
    if edDalGiorno.Date > edAlGiorno.Date then
    begin
      CanClose := false;
      ConfirmOk('Data iniziale maggiore della data finale');
    end;
end;

end.
