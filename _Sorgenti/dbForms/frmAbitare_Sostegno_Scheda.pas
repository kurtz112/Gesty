unit frmAbitare_Sostegno_Scheda;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnList,
  Data.DB,
  dxBar,
  dxBarExtItems,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxClasses,
  cxLabel,
  zDbView,
  zDbCard,
  BaseFrm,
  OkCancel,
  zFileViewer;

type
  TFormAbitareSostegnoScheda = class(TBaseForm)
    OkCancel: TOkCancel;
    ActionList: TActionList;
    MostraSchedaInquilino: TAction;
    MostraSchedaProprietario: TAction;
    procedure MostraSchedaProprietarioExecute(Sender: TObject);
    procedure MostraSchedaInquilinoExecute(Sender: TObject);
  private
  private
    procedure SalvaClick(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
  protected
    procedure BeforeShow; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormAbitareSostegnoScheda: TFormAbitareSostegnoScheda;

function ApriRichiesta(var IdRichiesta: integer): boolean;

implementation

uses
  cxFilter,
  zDm_Images,
  dmAbitare_Sostegno_Scheda,
  zz.files,
  files.Lib;

{$R *.dfm}

function ApriRichiesta(var IdRichiesta: integer): boolean;
var
  FormAbitareSostegnoScheda: TFormAbitareSostegnoScheda;
begin
  result := false;

  Application.CreateForm(TFormAbitareSostegnoScheda, FormAbitareSostegnoScheda);
  try
    AbitareSostegnoScheda.IdRichiestaSostegno := IdRichiesta;

    if IdRichiesta = -1 then
      AbitareSostegnoScheda.CreaRichiesta;

    result := FormAbitareSostegnoScheda.ShowForm(true);

    if result then
      IdRichiesta := AbitareSostegnoScheda.IdRichiestaSostegno;
  finally
    FreeAndNil(FormAbitareSostegnoScheda);
  end;
end;

procedure TFormAbitareSostegnoScheda.CreateDataModule;
begin
  inherited;
  CreateDM(TAbitareSostegnoScheda, AbitareSostegnoScheda);
end;

procedure TFormAbitareSostegnoScheda.DestroyDataModule;
begin
  inherited;
  FreeAndNil(AbitareSostegnoScheda);
end;

procedure TFormAbitareSostegnoScheda.BeforeShow;
begin
  inherited;
  LoadFromIni;
end;

constructor TFormAbitareSostegnoScheda.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'AbitareSostegnoScheda';
  Caption := 'AbitareSostegnoScheda';

  Position := PoMainFormCenter;

  actEsci.Visible := false;

  Height := 820;
  Width := 980;

  OkCancel.Top := ClientHeight - 1;
end;

procedure TFormAbitareSostegnoScheda.SalvaClick(Sender: TObject);
begin
  try
    Salva;
  except
    ModalResult := mrNone;
    raise;
  end;
end;

procedure TFormAbitareSostegnoScheda.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
  // card: TzDbCard;
// begin
  // inherited;
// 
  // if Component is TzDbCard then
  // begin
    // card := TzDbCard(Component);
// 
    // if SameText(DataSetName, 'Richiesta') then
    // begin
      // card.AddAction(MostraSchedaInquilino, zDmImages.ImageList16);
      // card.AddAction(MostraSchedaProprietario, zDmImages.ImageList16);
      // card.InitToolActions;
    // end;
  // end
  // else
    // if Component is TzDbView then
    // begin
      // view := TzDbView(Component);
// 
      // if SameText(DataSetName, 'XYZ') then
      // begin
        // view.AddAction(Autorizza, zDmImages.ImageList16);
        // view.InitToolActions;
      // end;
    // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormAbitareSostegnoScheda.MostraSchedaInquilinoExecute(Sender: TObject);
begin
  inherited;
  AbitareSostegnoScheda.MostraSchedaInquilino
end;

procedure TFormAbitareSostegnoScheda.MostraSchedaProprietarioExecute(Sender: TObject);
begin
  inherited;
  AbitareSostegnoScheda.MostraSchedaProprietario;
end;

end.

  procedure MostraSchedaInquilino; procedure MostraSchedaProprietario;
