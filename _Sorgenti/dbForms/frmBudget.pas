unit frmBudget;

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
  dxBar,
  System.Actions,
  Vcl.ActnList,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  zDbView,
  cxCustomPivotGrid,
  dxUIAClasses,
  zDm_Images,
  zDbPivot,
  dxLayoutcxEditAdapters,
  dxLayoutControlAdapters,
  Vcl.Menus,
  Vcl.StdCtrls,
  cxButtons,
  dxLayoutContainer,
  cxSpinEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBExtLookupComboBox,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  dxLayoutControl;

type
  TFormBudget = class(TBaseForm)
    ActionList: TActionList;
    ElaboraCostiRicavi: TAction;
    dxBarButton1: TdxBarButton;
    CercaPerProgetto: TAction;
    layoutCercaPerProgetto: TdxLayoutControl;
    edMese: TcxComboBox;
    edProgettoPerProgetto: TcxTextEdit;
    edAnno: TcxSpinEdit;
    layoutCercaPerProgettoGroup_Root: TdxLayoutGroup;
    dxLayoutItemProgetto: TdxLayoutItem;
    btnCercaPerProgetto: TcxButton;
    dxLayoutItemBtnCercaPerProgetto: TdxLayoutItem;
    CercaPerEsercizio: TAction;
    layoutCercaPerEsercizio: TdxLayoutControl;
    edProgettoPerEsercizio: TcxTextEdit;
    btnCercaPerEsercizio: TcxButton;
    dxLayoutGroup1: TdxLayoutGroup;
    dxLayoutItemProgettoPerEsercizio: TdxLayoutItem;
    dxLayoutItemCercaPerEsercizio: TdxLayoutItem;
    dxLayoutGroup2: TdxLayoutGroup;
    dxLayoutGroup3: TdxLayoutGroup;
    procedure CercaPerEsercizioExecute(Sender: TObject);
    procedure CercaPerProgettoExecute(Sender: TObject);
    procedure ElaboraCostiRicaviExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure initPivot(pivot: TzDbPivot);
    procedure ApriProgettoDaGroupItem(pivot: TzDbPivot; GroupItem: TcxPivotGridGroupItem; var Handled: Boolean);
    procedure PivotCellDblClick(Sender: TObject; CrossCell: TcxPivotGridCrossCell; var Handled: Boolean);
    procedure PivotGroupHeaderDblClick(Sender: TObject; GroupItem: TcxPivotGridGroupItem; var Handled: Boolean);
    procedure FiltraProgetto(const DataSetName: string; FilterValue: String);
    procedure ApriProgetto(const idProgetto: integer);
  protected
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetupComponent(const DataSetName: String; Component: TComponent); override;
    procedure AfterCreateControls; override;
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
  end;

var
  FormBudget: TFormBudget;

implementation

uses
  cxDBPivotGrid,
  dmBudget,

  dmProgetti,
  cxFilter,
  zDX,
  System.StrUtils;

{$R *.dfm}

procedure TFormBudget.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Budget';
  ReportGroup := 'Budget';

  dx.InitLayoutControl(layoutCercaPerProgetto);
  dx.InitLayoutControl(layoutCercaPerEsercizio);

  layoutCercaPerProgetto.Visible := False;
  layoutCercaPerProgetto.Parent := Self;
  layoutCercaPerProgetto.Height := 30;
  layoutCercaPerEsercizio.Visible := False;
  layoutCercaPerEsercizio.Parent := Self;
  layoutCercaPerEsercizio.Height := 30;
end;

procedure TFormBudget.CreateDataModule;
begin
  inherited;
  CreateDM(TBudget, Budget);
end;

procedure TFormBudget.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Budget);
end;

procedure TFormBudget.AfterCreateControls;
begin
  inherited;
  AddLayoutItem(layoutCercaPerProgetto, 'layoutCercaPerProgetto', False);
  AddLayoutItem(layoutCercaPerEsercizio, 'layoutCercaPerEsercizio', False);
end;

procedure TFormBudget.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
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
// if SameText(DataSetName, 'Progetti_Elenco') then
// begin
// view.AddAction(Indicizza, zDmImages.ImageList16);
// view.InitToolActions;
//
// Tools.AddFiltroAnnoFormativo(view, Budget.GetDataSet(DataSetName));
// Tools.AddFiltroEnte(view, Budget.GetDataSet(DataSetName));
// end
// else
// if SameText(DataSetName, 'CostiInterniMensili') then
// begin
// view.AddAction(Indicizza, zDmImages.ImageList16);
// view.InitToolActions;
//
// Tools.AddFiltroMese(view, Budget.GetDataSet(DataSetName));
// Tools.AddFiltroAnnoSolare(view, Budget.GetDataSet(DataSetName));
// end;
// end
// else
// if Component is TzDbPivot then
// begin
// pivot := TzDbPivot(Component);
// initPivot(pivot);
//
// if SameText(DataSetName, 'Coan_Costi_Ricavi_Per_Progetto') then
// begin
// pivot.AddAction(Action1, zDmImages.ImageList16);
// pivot.InitToolActions;
//
// Tools.AddFiltroAnnoFormativo(pivot, Budget.GetDataSet(DataSetName));
// Tools.AddFiltroEnte(pivot, Budget.GetDataSet(DataSetName));
// pivot.cxDBPivotGrid.OnDblClick := cxDBPivotGridDblClick;
// end
// else
// if SameText(DataSetName, 'Coan_Costi_Ricavi_Per_Esercizio') then
// begin
// Tools.AddFiltroAnnoEsercizio(pivot, Budget.GetDataSet(DataSetName));
// Tools.AddFiltroEnte(pivot, Budget.GetDataSet(DataSetName));
// pivot.cxDBPivotGrid.OnDblClick := cxDBPivotGridDblClick;
// end
// else
// if SameText(DataSetName, 'Coan_Pivot_Costi_Personale_Mensili') then
// begin
// Tools.AddFiltroEnte(pivot, Budget.GetDataSet(DataSetName));
// end;
// end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent }
end;

procedure TFormBudget.ElaboraCostiRicaviExecute(Sender: TObject);
begin
  inherited;
  Budget.ElaboraCostiRicavi;
end;

procedure TFormBudget.initPivot(pivot: TzDbPivot);
var
  field: TcxDBPivotGridField;
begin
  field := pivot.FieldByName('DENOMINAZIONE_PROGETTO');

  if assigned(field) then
  begin
    field.Width := 350;
    pivot.zDbPivotProps.BestFitAfterExpand := False;
  end;

  // for i := 0 to cxDBPivotGrid.FieldCount - 1 do
  // begin
  // Field := TcxDBPivotGridField(cxDBPivotGrid.Fields[i]);

end;

procedure TFormBudget.CercaPerProgettoExecute(Sender: TObject);
begin
  inherited;
  FiltraProgetto('Coan_Costi_Ricavi_Per_Progetto', edProgettoPerProgetto.Text);
end;

procedure TFormBudget.CercaPerEsercizioExecute(Sender: TObject);
begin
  inherited;
  FiltraProgetto('Coan_Costi_Ricavi_Per_Esercizio', edProgettoPerEsercizio.Text);
end;

procedure TFormBudget.FiltraProgetto(const DataSetName: string; FilterValue: String);
var
  i: integer;
  pivot: TzDbPivot;
  field: TcxDBPivotGridField;
begin
  pivot := GetPivot(DataSetName);

  pivot.cxDBPivotGrid.BeginUpdate;
  try
    pivot.FullExpand;

    pivot.cxDBPivotGrid.DataController.Filter.PercentWildcard := '*';
    pivot.cxDBPivotGrid.DataController.Filter.Options := pivot.cxDBPivotGrid.DataController.Filter.Options + [fcoCaseInsensitive];

    pivot.cxDBPivotGrid.DataController.Filter.Active := False;
    pivot.cxDBPivotGrid.DataController.Filter.Clear;

    if not FilterValue.IsEmpty then
    begin
      field := pivot.FieldByName('DENOMINAZIONE_PROGETTO');

      pivot.cxDBPivotGrid.DataController.Filter.Root.AddItem(field, foLike, '*' + FilterValue + '*', FilterValue);
      pivot.cxDBPivotGrid.DataController.Filter.Active := true;
    end;
  finally
    pivot.cxDBPivotGrid.EndUpdate;
  end;

  pivot.ApplyBestFit;
end;

procedure TFormBudget.ApriProgetto(const idProgetto: integer);
const
  DataSetName = 'Progetti_Elenco';
var
  view: TzDbView;
begin
  inherited;

  SelectedDataSetName := DataSetName;

  view := getView(DataSetName);
  if assigned(view) then
  begin
    view.ClearFilter(False);
    view.AddFilterCondition('ID_PROGETTO', foEqual, idProgetto);
  end;
end;

procedure TFormBudget.SetupComponent(const DataSetName: String; Component: TComponent);
var
  pivot: TzDbPivot;
begin
  inherited;

  if Component is TzDbPivot then
  begin
    pivot := TzDbPivot(Component);

    if SameText(DataSetName, 'CostiInterniMensili') then
    begin
      initPivot(pivot);
    end
    else
      if SameText(DataSetName, 'Coan_Costi_Ricavi_Per_Progetto') then
      begin
        pivot.OnCellDblClick := PivotCellDblClick;
        pivot.OnGroupHeaderDblClick := PivotGroupHeaderDblClick;
      end
      else
        if SameText(DataSetName, 'Coan_Costi_Ricavi_Per_Esercizio') then
        begin
          pivot.OnCellDblClick := PivotCellDblClick;
          pivot.OnGroupHeaderDblClick := PivotGroupHeaderDblClick;
        end
  end;
end;

procedure TFormBudget.ApriProgettoDaGroupItem(pivot: TzDbPivot; GroupItem: TcxPivotGridGroupItem; var Handled: Boolean);
var
  id: Variant;
begin
  if assigned(GroupItem) and assigned(GroupItem.field) and MatchText(TcxDBPivotGridField(GroupItem.field).DataBinding.FieldName, ['PROGETTO', 'DENOMINAZIONE_PROGETTO', 'DESC_COMPLETA_PROGETTO']) then
  begin
    // ID_PROGETTO è un campo di servizio nascosto del dataset: se manca,
    // GetGroupItemValue restituisce Null e il doppio clic resta senza effetto
    id := pivot.GetGroupItemValue(GroupItem, 'ID_PROGETTO');
    if not VarIsNull(id) then
    begin
      ApriProgetto(id);
      Handled := true;
    end;
  end;
end;

procedure TFormBudget.PivotCellDblClick(Sender: TObject; CrossCell: TcxPivotGridCrossCell; var Handled: Boolean);
begin
  ApriProgettoDaGroupItem(Sender as TzDbPivot, CrossCell.Row, Handled);
end;

procedure TFormBudget.PivotGroupHeaderDblClick(Sender: TObject; GroupItem: TcxPivotGridGroupItem; var Handled: Boolean);
begin
  ApriProgettoDaGroupItem(Sender as TzDbPivot, GroupItem, Handled);
end;

end.

