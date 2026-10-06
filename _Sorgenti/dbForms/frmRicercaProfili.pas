unit frmRicercaProfili;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  BaseFrm,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  System.Actions,
  Vcl.ActnList,
  dxBar,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  zDm_Images,
  zFormController,
  zFileViewer,
  zFbDataSet,
  dxLayoutcxEditAdapters,
  dxLayoutContainer,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  dxLayoutControl,
  cxDropDownEdit,
  cxTextEdit,
  cxMaskEdit,
  cxSpinEdit, cxDBExtLookupComboBox;

type
  TFormRicercaProfili = class(TBaseForm)
    ActionList: TActionList;
    edEtaMin: TcxSpinEdit;
    edEtaMax: TcxSpinEdit;
    edCap: TcxSpinEdit;
    edSesso: TcxComboBox;
    layoutFiltri: TdxLayoutControl;
    edMese: TcxComboBox;
    edProgetto: TcxExtLookupComboBox;
    edAnno: TcxSpinEdit;
    layoutFiltriGroup_Root: TdxLayoutGroup;
    dxLayoutItemMese: TdxLayoutItem;
    dxLayoutItemProgetto: TdxLayoutItem;
    dxLayoutItemAnno: TdxLayoutItem;
    procedure FormCreate(Sender: TObject);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure AfterCreateControls; override;
  public
    procedure ApriRicercaProfili(const idRichiestaPersonale: integer; proc: TProc<integer>);
  end;

var
  FormRicercaProfili: TFormRicercaProfili;

procedure ApriRicercaProfili(const idRichiestaPersonale: integer; proc: TProc<integer>);

implementation

uses
  dmRicercaProfili,
  zHyperLinks,
  zDbView,
  cxFilter,
  Files.Lib;

{$R *.dfm}

procedure ApriRicercaProfili(const idRichiestaPersonale: integer; proc: TProc<integer>);
var
  FormRicercaProfili: TFormRicercaProfili;
begin
  Application.CreateForm(TFormRicercaProfili, FormRicercaProfili);
  try
    FormRicercaProfili.ApriRicercaProfili(idRichiestaPersonale, proc);
  finally
    FreeAndNil(FormRicercaProfili);
  end;
end;

procedure TFormRicercaProfili.CreateDataModule;
begin
  inherited;
  CreateDM(TRicercaProfili, RicercaProfili);
end;

procedure TFormRicercaProfili.DestroyDataModule;
begin
  inherited;
  FreeAndNil(RicercaProfili);
end;

procedure TFormRicercaProfili.FormCreate(Sender: TObject);
begin
  inherited;
  ReportGroup := 'Ricerca Profili';
  Caption := 'Ricerca Profili';

  layoutFiltri.Visible := False;
  layoutFiltri.Parent := Self;
end;

procedure TFormRicercaProfili.AfterCreateControls;
begin
  inherited;
  AddLayoutItem(layoutFiltri, 'Filtri', False);
end;

procedure TFormRicercaProfili.ApriRicercaProfili(const idRichiestaPersonale: integer; proc: TProc<integer>);
begin
  ShowForm(False);
end;

end.

  ID_CURRICULUM_ESTERNO

  corso, età, sesso, cap
