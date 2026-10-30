unit frmAS_Rendicontazione;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnList,
  Vcl.StdActns,
  Data.DB,
  dxBar,
  dxBarExtItems,
  dxFileActions,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxClasses,
  cxLabel,
  BaseFrm,
  zDbView,
  dxUIAClasses,
  zDbPivot,
  cxDBPivotGrid,
  cxCustomPivotGrid;

type
  TFormAS_Rendicontazione = class(TBaseForm)
    ActionList: TActionList;
    ElaboraTreEffe: TAction;
    ImportTreEffe: TdxFileOpen;
    procedure ElaboraTreEffeExecute(Sender: TObject);
    procedure ImportTreEffeAccept(Sender: TObject);
  private
    procedure PivotStatoAvanzamentoAfterCreateControls(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetupComponent(const DataSetName: String; Component: TComponent); override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormAS_Rendicontazione: TFormAS_Rendicontazione;

implementation

uses
  cxFilter,
  dmAS_Rendicontazione,
  zSystem;

{$R *.dfm}

procedure TFormAS_Rendicontazione.CreateDataModule;
begin
  inherited;
  CreateDM(TAS_Rendicontazione, AS_Rendicontazione);
end;

procedure TFormAS_Rendicontazione.DestroyDataModule;
begin
  inherited;
  FreeAndNil(AS_Rendicontazione);
end;

constructor TFormAS_Rendicontazione.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'AS_Rendicontazione';
  Caption := 'AS_Rendicontazione';
end;

procedure TFormAS_Rendicontazione.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
// view: TzDbView;
// pivot: TzDbPivot;
// begin
// inherited;
//
// if Component is TzDbView then
// begin
// view := TzDbView(Component);
//
// if SameText(DataSetName, 'As_Interventi_Rend_Tre_Effe_Import_Files') then
// begin
// view.AddAction(ImportTreEffe, zDmImages.ImageList16);
// view.AddAction(ElaboraTreEffe, zDmImages.ImageList16);
// view.InitToolActions;
// end
// else
// if SameText(DataSetName, 'As_Interventi_Rend_Tre_Effe_Import_Righe') then
// begin
// tools.AddFiltroBoolean(view, AS_Rendicontazione.GetDataSet(DataSetName), 'RENDICONTATA', 'Rendicontata', 'Rendicontata', '');
// tools.AddFiltroAS_Comuni(view, AS_Rendicontazione.GetDataSet(DataSetName));
//
// view.InitToolActions;
// end
// else
// if SameText(DataSetName, 'RiepilogoRendicontazioni') then
// begin
// view.AddAction(ImportTreEffe, zDmImages.ImageList16);
// view.AddAction(ElaboraTreEffe, zDmImages.ImageList16);
//
// tools.AddFiltroAS_Comuni(view, AS_Rendicontazione.GetDataSet(DataSetName));
// tools.AddFiltroMese(view, AS_Rendicontazione.GetDataSet(DataSetName));
// tools.AddFiltroAnnoFormativo(view, AS_Rendicontazione.GetDataSet(DataSetName));
//
// view.InitToolActions;
// end
// else
// if SameText(DataSetName, 'As_Interventi_Rend_Transcodifica_Utente') then
// begin
// tools.AddFiltroBoolean(view, AS_Rendicontazione.GetDataSet(DataSetName), 'TRANSCODIFICATO', 'Rendicontata', 'Transcodificato', '');
// end
// else
// if SameText(DataSetName, 'As_Stato_Avanzamento') then
// begin
// tools.AddFiltroMese(view, AS_Rendicontazione.GetDataSet(DataSetName));
// tools.AddFiltroAnnoFormativo(view, AS_Rendicontazione.GetDataSet(DataSetName));
// tools.AddFiltroPickList('AS_TIPO_ORE', view, AS_Rendicontazione.GetDataSet(DataSetName), 'TIPO_ORE', 'Tipo Ore', 'tipo orerichiesta', null, true, 'Tutti', 120);
// tools.AddFiltroPickList('AS_TIPO_INTERVENTO', view, AS_Rendicontazione.GetDataSet(DataSetName), 'TIPO_INTERVENTO', 'Tipo Intervento', 'tipo intervento', null, true, 'Tutti', 120);
// tools.AddFiltroAS_Comuni(view, AS_Rendicontazione.GetDataSet(DataSetName));
// end;
// end
// else
// if Component is TzDbPivot then
// begin
// pivot := TzDbPivot(Component);
//
// if SameText(DataSetName, 'As_Stato_Avanzamento') then
// begin
// tools.AddFiltroMese(pivot, AS_Rendicontazione.GetDataSet(DataSetName), ivNull);
// tools.AddFiltroAnnoFormativo(pivot, AS_Rendicontazione.GetDataSet(DataSetName));
// tools.AddFiltroPickList('AS_TIPO_ORE', pivot, AS_Rendicontazione.GetDataSet(DataSetName), 'TIPO_ORE', 'Tipo Ore', 'tipo orerichiesta', null, true, 'Tutti', 120);
// tools.AddFiltroPickList('AS_TIPO_INTERVENTO', pivot, AS_Rendicontazione.GetDataSet(DataSetName), 'TIPO_INTERVENTO', 'Tipo Intervento', 'tipo intervento', null, true, 'Tutti', 120);
// tools.AddFiltroAS_Comuni(pivot, AS_Rendicontazione.GetDataSet(DataSetName));
//
// pivot.OnAfterCreateControls := PivotStatoAvanzamentoAfterCreateControls;
// end;
// end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent }
end;

procedure TFormAS_Rendicontazione.ElaboraTreEffeExecute(Sender: TObject);
begin
  inherited;
  AS_Rendicontazione.ElaboraTreEffeSelezionato;
end;

procedure TFormAS_Rendicontazione.ImportTreEffeAccept(Sender: TObject);
var
  id: integer;
  view: TzDbView;
begin
  inherited;

  id := AS_Rendicontazione.ImportTreEffe(ImportTreEffe.Dialog.FileName);

  if id = -1 then
    exit;

  view := getView('As_Interventi_Rend_Tre_Effe_Import_Files');
  if assigned(view) then
  begin
    view.ClearFilter(False);
    view.AddFilterCondition('ID_IMPORT_REND_TRE_EFFE_FILE', foEqual, id);
  end;
end;

procedure TFormAS_Rendicontazione.PivotStatoAvanzamentoAfterCreateControls(Sender: TObject);
var
  pivot: TzDbPivot;
  PivotField: TcxDBPivotGridField;
begin

  if not(Sender is TzDbPivot) then
    exit;

  pivot := TzDbPivot(Sender);

  // Il totale generale di riga non deve contare la colonna 'Ore Dirette Totali',
  // che è già un totale derivato: senza esclusione verrebbe sommata due volte.
  pivot.SetGrandTotalExclusions('ORE_TOTALI', ['Ore Dirette Totali']);
  pivot.SetGrandTotalExclusions('COSTO_TOTALE', ['Ore Dirette Totali']);
end;

procedure TFormAS_Rendicontazione.SetupComponent(const DataSetName: String; Component: TComponent);
var
  pivot: TzDbPivot;
begin
  inherited;

  if Component is TzDbPivot then
  begin
    pivot := TzDbPivot(Component);

    if SameText(DataSetName, 'As_Stato_Avanzamento') then
    begin
      pivot.OnAfterCreateControls := PivotStatoAvanzamentoAfterCreateControls;
    end;
  end;
end;

end.
