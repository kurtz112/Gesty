unit frmRilevamentoOre;

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
  Data.DB,
  Base_DataModule,
  zFormController,
  dxLayoutContainer;

type
  TFormRilevamentoOre = class(TBaseForm)
    ActionList: TActionList;
    RegistraMeseRilevazione: TAction;
    GeneraRilevamento: TAction;
    procedure FormCreate(Sender: TObject);
    procedure GeneraRilevamentoExecute(Sender: TObject);
    procedure RegistraMeseRilevazioneExecute(Sender: TObject);
  private
    function FormControllerTabChanging(group: TdxLayoutGroup; ANewTabIndex: integer): boolean;
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure AfterShowForm(const Modal: boolean); override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
  end;

implementation

uses
  dmRilevamentoOre,
  zDbCard,
  zDm_Images,
  zDbView;

{$R *.dfm}

procedure TFormRilevamentoOre.CreateDataModule;
begin
  inherited;
  CreateDM(TRilevamentoOre, RilevamentoOre);
end;

procedure TFormRilevamentoOre.DestroyDataModule;
begin
  inherited;
  FreeAndNil(RilevamentoOre);
end;

procedure TFormRilevamentoOre.FormCreate(Sender: TObject);
begin
  inherited;
  ReportGroup := 'Rilevamento Ore';
  Caption := 'Rilevamento Ore';

  FormController.LayoutController.TabChangingProc := FormControllerTabChanging;
end;

procedure TFormRilevamentoOre.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // card: TzDbCard;
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbCard then
  // begin
    // card := TzDbCard(Component);
// 
    // if SameText(DataSetName, 'Personale_Rilevamento_Ore') then
    // begin
      // card.AddAction(RegistraMeseRilevazione, zDmImages.ImageList16);
      // card.InitToolActions;
    // end;
  // end
  // else
// 
    // if Component is TzDbView then
    // begin
      // view := TzDbView(Component);
// 
      // if SameText(DataSetName, 'Incarichi') then
      // begin
        // Tools.AddFiltroEnte(view, RilevamentoOre.GetDataSet(DataSetName));
        // Tools.AddFiltroAnnoFormativo(view, RilevamentoOre.GetDataSet(DataSetName));
      // end
      // else
        // if SameText(DataSetName, 'Personale_Presenze_Libere') then
        // begin
          // view.AddAction(GeneraRilevamento, zDmImages.ImageList16).HideInCard;
          // view.InitToolActions;
        // end;
    // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormRilevamentoOre.AfterShowForm(const Modal: boolean);
begin
  inherited;
  RilevamentoOre.Aggiungi;
end;

procedure TFormRilevamentoOre.RegistraMeseRilevazioneExecute(Sender: TObject);
begin
  inherited;
  RilevamentoOre.RegistraMeseRilevazione;
end;

procedure TFormRilevamentoOre.GeneraRilevamentoExecute(Sender: TObject);
const
  DataSetName = 'Incarichi_Ore_Rilevate';
var
  view: TzDbView;
begin
  inherited;

  if RilevamentoOre.GeneraRilevamentoDaOraLibera then
  begin
    view := GetView(DataSetName);
    if Assigned(view) then
      view.ShowRecord(False);
  end;
end;

function TFormRilevamentoOre.FormControllerTabChanging(group: TdxLayoutGroup; ANewTabIndex: integer): boolean;
begin

  if SameText(group.Name, 'dxLayoutGroupDataModule_RilevamentoOre') then
    result := CloseQuery;
end;

end.

  zDbCard
  zdbview

  zsystem
  zformcontroller
