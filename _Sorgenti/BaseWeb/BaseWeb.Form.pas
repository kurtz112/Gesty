unit BaseWeb.Form;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
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
  BaseWeb.Designer.Frame,
  BaseWeb.Models,
  Vcl.ExtCtrls,
  cxTextEdit,
  cxMemo,
  cxDBEdit,
  cxGeometry,
  dxFramedControl,
  dxPanel;

type
  TFormBaseWeb = class(TBaseForm)
    ActionList: TActionList;
    VerificaDataSet: TAction;
    GeneraCampi: TAction;
    Editor: TAction;
    dxPanel1: TdxPanel;
    procedure EditorExecute(Sender: TObject);
    procedure GeneraCampiExecute(Sender: TObject);
    procedure VerificaDataSetExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure zDbView1CardBeforeCreateDbControl(Sender: TObject; const FieldName: string; var cxCustomEdit: TcxCustomEdit);
  private
    procedure Base_Web_DatasetsCardAfterCreateDbControl(Sender: TObject; const FieldName: string; cxCustomEdit: TcxCustomEdit);
    procedure Base_Web_Datasets_MetaAfterCreateDbControl(Sender: TObject; const FieldName: string; cxCustomEdit: TcxCustomEdit);
    procedure Base_Web_PicklistsCardAfterCreateDbControl(Sender: TObject; const FieldName: string; cxCustomEdit: TcxCustomEdit);

    procedure Base_Web_DatasetsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Base_Web_Datasets_MetaDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Base_Web_PicklistsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;

    procedure SetupComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetPK(const Value: Variant); override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormBaseWeb: TFormBaseWeb;

implementation

uses
  zDm_Images,
  zHyperLinks,
  cxFilter,
  BaseWeb.DM,
  BaseWeb.Repository,
  zFbDataSet,
  zBaseLib,
  BaseWeb.Designer.Form,
  zDbCard,
  Form_Editor_JSON,
  Form_Editor_SQL,
  System.StrUtils;

{$R *.dfm}

procedure TFormBaseWeb.CreateDataModule;
begin
  inherited;
  CreateDM(TBaseWebDM, BaseWebDM);
end;

procedure TFormBaseWeb.DestroyDataModule;
begin
  inherited;
  FreeAndNil(BaseWebDM);
end;

constructor TFormBaseWeb.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'BaseWeb';
  Caption := 'BaseWeb';
end;

procedure TFormBaseWeb.GeneraCampiExecute(Sender: TObject);
var
  datasets: TList<string>;
  view: TzDbView;
begin
  inherited;

  datasets := TList<string>.Create;
  try
    view := GetView('Base_Web_Datasets');
    view.GetSelectedRows('DATASET', datasets);
    BaseWebDM.GeneraCampi(datasets);
  finally
    FreeAndNil(datasets);
  end;
end;

procedure TFormBaseWeb.SetPK(const Value: Variant);
var
  view: TzDbView;
  idRisorsa: Integer;
begin
  inherited;
  //
  if pkMode then
  begin
    SelectedDataSetName := 'Base_Web_Datasets';

    view := GetView('Base_Web_Datasets');
    if Assigned(view) then
    begin
      view.ClearFilter(False);
      view.AddFilterCondition('DATASET', foEqual, Value);
    end;
  end;
end;

procedure TFormBaseWeb.VerificaDataSetExecute(Sender: TObject);
var
  datasets: TList<string>;
  view: TzDbView;
begin
  inherited;

  datasets := TList<string>.Create;
  try
    view := GetView('Base_Web_Datasets');
    view.GetSelectedRows('DATASET', datasets);
    BaseWebDM.VerificaDataSet(datasets);
  finally
    FreeAndNil(datasets);
  end;
end;

procedure TFormBaseWeb.FormShow(Sender: TObject);
var
  view: TzDbView;
begin
  inherited;
  view := GetView('Base_Web_Datasets');
  view.AddFilterCondition('DATASET', foEqual, 'Risorsa.Incarichi');
end;

procedure TFormBaseWeb.EditorExecute(Sender: TObject);
var
  dataset: TzFbDataSet;
  idDataset: string;
  Struct: TBaseWebDatasetStructure;
begin
  inherited;
  dataset := BaseWebDM.getDataSet('Base_Web_Datasets');
  idDataset := dataset.FieldByName('DATASET').AsString;

  Struct := TBaseWebRepository.LoadDatasetStructure(idDataset); // mettere poi ID

  if BaseWebEditDataSet(Struct) then
    TBaseWebRepository.SaveDatasetStructure(Struct);
end;

procedure TFormBaseWeb.SetupComponent(const DataSetName: String; Component: TComponent);
var
  view: TzDbView;
  card: TzDbCard;
begin
  inherited;

  if Component is TzDbCard then
  begin
    card := TzDbCard(Component);

    if SameText(DataSetName, 'Base_Web_Datasets_Meta') then
    begin
      card.OnAfterCreateDbControl := Base_Web_Datasets_MetaAfterCreateDbControl;
    end;
  end
  else
    if Component is TzDbView then
    begin
      view := TzDbView(Component);

      if SameText(DataSetName, 'Base_Web_Datasets') then
      begin
        view.OnCardAfterCreateDbControl := Base_Web_DatasetsCardAfterCreateDbControl;
      end
      else
        if SameText(DataSetName, 'Base_Web_Picklists') then
        begin
          view.OnCardAfterCreateDbControl := Base_Web_PicklistsCardAfterCreateDbControl;
        end;
    end;
end;

procedure TFormBaseWeb.Base_Web_DatasetsCardAfterCreateDbControl(Sender: TObject; const FieldName: string; cxCustomEdit: TcxCustomEdit);
begin

  if SameText(FieldName, 'SQL_SELECT') then
    cxCustomEdit.OnKeyDown := Base_Web_DatasetsKeyDown // Editor apposito
  else
    if MatchStr(FieldName, ['SQL_COUNT', 'SQL_INSERT', 'SQL_UPDATE', 'SQL_DELETE']) then
      cxCustomEdit.OnKeyDown := Base_Web_DatasetsKeyDown;
end;

procedure TFormBaseWeb.Base_Web_Datasets_MetaAfterCreateDbControl(Sender: TObject; const FieldName: string; cxCustomEdit: TcxCustomEdit);
begin

  if SameText(FieldName, 'META') then
    cxCustomEdit.OnKeyDown := Base_Web_Datasets_MetaDown;
end;

procedure TFormBaseWeb.Base_Web_PicklistsCardAfterCreateDbControl(Sender: TObject; const FieldName: string; cxCustomEdit: TcxCustomEdit);
begin

  if SameText(FieldName, 'META') then
    cxCustomEdit.OnKeyDown := Base_Web_PicklistsKeyDown;
end;

procedure TFormBaseWeb.Base_Web_DatasetsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  memo: TcxDbMemo;
  dataset: TzFbDataSet;
  DataSetName, FieldName: string;
  Value: String;
begin

  if Key = vk_f2 then
  begin
    memo := Sender as TcxDbMemo;
    FieldName := memo.DataBinding.DataField;

    // SQL_SELECT SQL_COUNT SQL_INSERT SQL_UPDATE SQL_DELETE

    dataset := BaseWebDM.getDataSet('Base_Web_Datasets');
    DataSetName := dataset.FieldByName('DATASET').AsString;
    Value := dataset.FieldByName(FieldName).AsString;

    dataset.CheckEditMode;
    if EditSQL(Value, DataSetName + ' - ' + FieldName, False) then
      dataset.FieldByName(FieldName).AsString := Value;
  end;
end;

procedure TFormBaseWeb.Base_Web_Datasets_MetaDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  JSON: string;
  dataset: TzFbDataSet;
begin
  if Key = vk_f2 then
  begin
    Key := 0;

    dataset := BaseWebDM.getDataSet('Base_Web_Datasets_Meta');

    dataset.CheckEditMode;
    JSON := dataset.FieldByName('META').AsString;

    if EditJSON(JSON, 'Dataset Meta', False) then
      dataset.FieldByName('META').AsString := JSON;
  end;
end;

procedure TFormBaseWeb.Base_Web_PicklistsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  JSON: string;
  dataset: TzFbDataSet;
  Picklist: string;
begin
  if Key = vk_f2 then
  begin
    Key := 0;

    dataset := BaseWebDM.getDataSet('Base_Web_Picklists');

    dataset.CheckEditMode;
    JSON := dataset.FieldByName('META').AsString;
    Picklist := dataset.FieldByName('PICKLIST').AsString;

    if EditJSON(JSON, 'Picklist - ' + Picklist, False) then
      dataset.FieldByName('META').AsString := JSON;
  end;
end;

procedure TFormBaseWeb.zDbView1CardBeforeCreateDbControl(Sender: TObject; const FieldName: string; var cxCustomEdit: TcxCustomEdit);
begin
  inherited;

  // BaseWebDM.Base_Web_Datasets per gli SQL
  // BaseWebDM.Base_Web_Datasets_Meta [occhio: è una card]  e per il JSON
  // BaseWebDM.Base_Web_Picklists per il JSON

  // aaaaaaaaaaaaa zdbcard
  // procedure F2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  //
  // if Sender is TcxDbMemo then
  // begin
  // CheckEditMode;
  // zExecuteMemoDialog(Sender as TcxDbMemo, '');
  // Key := 0;
  // end
end;

initialization

HyperLinks.RegisterHandler('DATASET', TFormBaseWeb);

end.

  zmemodialog

  Form_Editor_JSON
