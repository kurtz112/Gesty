unit frmAttivitaFuoriSede;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  zDbView,
  BaseFrm,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  System.Actions,
  Vcl.ActnList,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  dxLayoutcxEditAdapters,
  dxLayoutContainer,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBExtLookupComboBox,
  dxLayoutControl;

type
  TFormAttivitaFuoriSede = class(TBaseForm)
    Actions: TActionList;
    Precedente: TAction;
    Successiva: TAction;
    Oggi: TAction;
    VaiAlGiorno: TAction;
    dxLayoutControl: TdxLayoutControl;
    dxBarDockControl: TdxBarDockControl;
    dxLayoutControlGroup_Root: TdxLayoutGroup;
    dxLayoutGrouptoolbar: TdxLayoutGroup;
    dxLayoutItemBar: TdxLayoutItem;
    dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem;
    dxBarManagerBar: TdxBar;
    dxBarButton1: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    dxBarButton5: TdxBarButton;
    procedure FormCreate(Sender: TObject);
    procedure OggiExecute(Sender: TObject);
    procedure PrecedenteExecute(Sender: TObject);
    procedure SuccessivaExecute(Sender: TObject);
    procedure VaiAlGiornoExecute(Sender: TObject);
    procedure SetVaiAlGiornoCaption;
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure AfterCreateControls; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormAttivitaFuoriSede: TFormAttivitaFuoriSede;

implementation

uses
  zDm_Images,
  dmAttivitaFuoriSede,
  zDX,
  zMsg;

{$R *.dfm}

procedure TFormAttivitaFuoriSede.CreateDataModule;
begin
  inherited;
  CreateDM(TAttivitaFuoriSede, AttivitaFuoriSede);
end;

procedure TFormAttivitaFuoriSede.DestroyDataModule;
begin
  inherited;
  FreeAndNil(AttivitaFuoriSede);
end;

constructor TFormAttivitaFuoriSede.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'AttivitaFuoriSede';
  Caption := 'AttivitaFuoriSede';
end;

procedure TFormAttivitaFuoriSede.FormCreate(Sender: TObject);
begin
  inherited;
  dxLayoutControl.Visible := False;
  dxLayoutControl.Parent := Self;

  dx.InitBar(dxBarManagerBar);

  SetVaiAlGiornoCaption;
end;

procedure TFormAttivitaFuoriSede.AfterCreateControls;
begin
  inherited;
  AddLayoutItem(dxLayoutControl, 'FiltriToolbar', False);
end;

procedure TFormAttivitaFuoriSede.SetVaiAlGiornoCaption;
begin
  VaiAlGiorno.Caption := FormatDateTime('dddd dd mmmm yyyy', AttivitaFuoriSede.DataAttivita);
end;

procedure TFormAttivitaFuoriSede.OggiExecute(Sender: TObject);
begin
  inherited;
  AttivitaFuoriSede.DataAttivita := Date;
  SetVaiAlGiornoCaption;
end;

procedure TFormAttivitaFuoriSede.PrecedenteExecute(Sender: TObject);
begin
  inherited;
  AttivitaFuoriSede.Precedente;
  SetVaiAlGiornoCaption;
end;

procedure TFormAttivitaFuoriSede.SuccessivaExecute(Sender: TObject);
begin
  inherited;
  AttivitaFuoriSede.Successivo;
  SetVaiAlGiornoCaption;
end;

procedure TFormAttivitaFuoriSede.VaiAlGiornoExecute(Sender: TObject);
var
  Data: TDate;
begin
  inherited;

  Data := AttivitaFuoriSede.DataAttivita;

  if zMsg.InputDate('Seleziona data', 'Seleziona data', Data) then
  begin
    AttivitaFuoriSede.DataAttivita := Data;
    SetVaiAlGiornoCaption;
  end;
end;

end.
