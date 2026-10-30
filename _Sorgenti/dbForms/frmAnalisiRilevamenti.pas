unit frmAnalisiRilevamenti;

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
  dxLayoutContainer,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxClasses,
  cxLabel,
  zDbView,
  BaseFrm,
  zDbPivot;

type
  TFormAnalisiRilevamenti = class(TBaseForm)
    zDbPivot1: TzDbPivot;
  private
    function FormControllerTabChanging(group: TdxLayoutGroup; ANewTabIndex: integer): boolean;
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormAnalisiRilevamenti: TFormAnalisiRilevamenti;

implementation

uses
  dmAnalisiRilevamenti;

{$R *.dfm}

procedure TFormAnalisiRilevamenti.CreateDataModule;
begin
  inherited;
  CreateDM(TAnalisiRilevamenti, AnalisiRilevamenti);
end;

procedure TFormAnalisiRilevamenti.DestroyDataModule;
begin
  inherited;
  FreeAndNil(AnalisiRilevamenti);
end;

constructor TFormAnalisiRilevamenti.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'AnalisiRilevamenti';
  Caption := 'AnalisiRilevamenti';
  FormController.LayoutController.TabChangingProc := FormControllerTabChanging;
end;

procedure TFormAnalisiRilevamenti.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'Timesheet') then
    // begin
      // view.AddAction(Autorizza, zDmImages.ImageList16);
      // view.InitToolActions;
      // Tools.AddFiltroAreaRiferimento(view, AnalisiRilevamenti.GetDataSet(DataSetName));
      // Tools.AddFiltroAnnoFormativo(view, AnalisiRilevamenti.GetDataSet(DataSetName));
      // Tools.AddFiltroEnte(view, AnalisiRilevamenti.GetDataSet(DataSetName));
    // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

function TFormAnalisiRilevamenti.FormControllerTabChanging(group: TdxLayoutGroup; ANewTabIndex: integer): boolean;
var
  pivot: TzDbPivot;
begin
  result := true;

  pivot := GetPivot('TimeSheet');
  pivot.DataSourceEnabled := ANewTabIndex = 1;
end;

end.


