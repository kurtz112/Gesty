unit frmInail;

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
  cxLabel;

type
  TFormInail = class(TBaseForm)
    procedure FormCreate(Sender: TObject);
  private
  protected
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
  end;

var
  FormInail: TFormInail;

implementation

uses
  dmInail,
  zDbView;

{$R *.dfm}

procedure TFormInail.CreateDataModule;
begin
  inherited;
  CreateDM(TInail, Inail);
end;

procedure TFormInail.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Inail);
end;

procedure TFormInail.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Inail';
  ReportGroup := 'Inail';
end;

procedure TFormInail.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
// view: TzDbView;
// begin
// inherited;
//
// if Component is TzDbView then
// begin
// view := TzDbView(Component);
//
// if SameText(DataSetName, 'Inail_Tirocini') then
// begin
// view.AddAction(Indicizza, zDmImages.ImageList16);
// view.InitToolActions;
// Tools.AddFiltroAnnoFormativo(view, Inail.GetDataSet(DataSetName));
// Tools.AddFiltroEnte(view, Inail.GetDataSet(DataSetName));
// end
// else
// if SameText(DataSetName, 'DettaglioGiorniIndennita') then
// begin
// Tools.AddFiltroAnnoFormativo(view, Inail.GetDataSet(DataSetName));
// Tools.AddFiltroEnte(view, Inail.GetDataSet(DataSetName));
// end
// else
// if SameText(DataSetName, 'RiepilogoGiorniIndennita') then
// begin
// Tools.AddFiltroAnnoFormativo(view, Inail.GetDataSet(DataSetName));
// Tools.AddFiltroEnte(view, Inail.GetDataSet(DataSetName));
// end
// else
// if SameText(DataSetName, 'DettaglioGiorniPresenze') then
// begin
// Tools.AddFiltroAnnoFormativo(view, Inail.GetDataSet(DataSetName));
// Tools.AddFiltroEnte(view, Inail.GetDataSet(DataSetName));
// end
// else
// if SameText(DataSetName, 'RiepilogoGiorniPresenze') then
// begin
// Tools.AddFiltroAnnoFormativo(view, Inail.GetDataSet(DataSetName));
// Tools.AddFiltroEnte(view, Inail.GetDataSet(DataSetName));
// end
// else
// if SameText(DataSetName, 'RiepilogoPresenzeStudenti') then
// begin
// Tools.AddFiltroSede(view, Inail.GetDataSet(DataSetName));
// Tools.AddFiltroEnte(view, Inail.GetDataSet(DataSetName));
// end;
// end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent }
end;

end.
