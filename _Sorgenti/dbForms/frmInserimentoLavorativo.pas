unit frmInserimentoLavorativo;

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
  zFormController,
  zFileViewer;

type
  TFormInserimentoLavorativo = class(TBaseForm)
    ActionList: TActionList;
    RicercaProfili: TAction;
    ProponiCandidato: TAction;
    PianificaColloquio: TAction;
    procedure FormCreate(Sender: TObject);
    procedure PianificaColloquioExecute(Sender: TObject);
    procedure ProponiCandidatoExecute(Sender: TObject);
    procedure RicercaProfiliExecute(Sender: TObject);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure DatasetAssigned(const DataSetName: String; Component: TComponent); override;
    procedure SetPK(const Value: Variant); override;
  end;

var
  FormInserimentoLavorativo: TFormInserimentoLavorativo;

implementation

uses
  dmInserimentoLavorativo,
  zHyperLinks,
  zDbView,
  cxFilter,
   
  Files.Lib;

{$R *.dfm}

procedure TFormInserimentoLavorativo.CreateDataModule;
begin
  inherited;
  CreateDM(TInserimentoLavorativo, InserimentoLavorativo);
end;

procedure TFormInserimentoLavorativo.DatasetAssigned(const DataSetName: String; Component: TComponent);
var
  view: TzDbView;
begin
  inherited;

  if SameText(DataSetName, 'TranscodificaProgetti') then
  begin
    view := getView('TranscodificaProgetti');

    if Assigned(view) then
      view.AddFilterCondition('CODICE_GIS', foEqual, null);
  end;
end;

procedure TFormInserimentoLavorativo.DestroyDataModule;
begin
  inherited;
  FreeAndNil(InserimentoLavorativo);
end;

procedure TFormInserimentoLavorativo.FormCreate(Sender: TObject);
begin
  inherited;
  ReportGroup := 'Inserimento Lavorativo';
  Caption := 'Inserimento Lavorativo';
end;

procedure TFormInserimentoLavorativo.SetPK(const Value: Variant);
var
  view: TzDbView;
begin
  inherited;
  //
  if pkMode then
  begin

    if pkField = 'ID_RICHIESTA_PERSONALE' then
    begin
      SelectedDataSetName := 'Richieste_Personale';

      view := getView('Richieste_Personale');
      if Assigned(view) then
      begin
        view.ClearFilter(False);
        view.AddFilterCondition('ID_RICHIESTA_PERSONALE', foEqual, pk);
      end;
    end;
  end;
end;

procedure TFormInserimentoLavorativo.RicercaProfiliExecute(Sender: TObject);
begin
  inherited;
  InserimentoLavorativo.RicercaProfili;
end;

procedure TFormInserimentoLavorativo.PianificaColloquioExecute(Sender: TObject);
var
  view: TzDbView;
begin
  inherited;
  view := getView('Richieste_Pers_Colloqui');
  view.ShowRecord(True)
end;

procedure TFormInserimentoLavorativo.ProponiCandidatoExecute(Sender: TObject);
var
  view: TzDbView;
begin
  inherited;
  // aggiungere id_profilo
  if InserimentoLavorativo.ProponiProfiloCorrente then
  begin
    view := getView('Richieste_Pers_Candidature');
    view.ShowRecord(False);
  end;
end;

procedure TFormInserimentoLavorativo.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
  // Richieste_Personale
  // Richieste_Pers_Profili
  // Richieste_Pers_Colloqui
  // Richieste_Pers_Candidature
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'Richieste_Personale') then
    // begin
      // view.AddAction(RicercaProfili, zDmImages.ImageList16).HideInView;
      // view.InitToolActions;
// 
      // tools.AddFiltroPickList('RICHIESTE_PERSONALE_STATO_RICH', view, InserimentoLavorativo.GetDataSet(DataSetName), 'STATO_RICHIESTA', 'Stato', 'stato richiesta', 'A', True, 'Tutti', 120);
    // end
    // else
      // if SameText(DataSetName, 'Richieste_Pers_Profili') then
      // begin
        // view.AddAction(RicercaProfili, zDmImages.ImageList16);
// 
        // view.AddAction(PianificaColloquio, zDmImages.ImageList16);
        // view.AddAction(ProponiCandidato, zDmImages.ImageList16);
        // view.InitToolActions;
      // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

initialization

HyperLinks.RegisterHandler('ID_RICHIESTA_PERSONALE', TFormInserimentoLavorativo);

end.

  ID_CURRICULUM_ESTERNO
