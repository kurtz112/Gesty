unit frmAllegati;

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
  zDbView,
  zFileViewer,
  dxLayoutControlAdapters,
  Vcl.Menus,
  dxLayoutContainer,
  Vcl.StdCtrls,
  cxButtons,
  cxTextEdit,
  dxLayoutControl,
  dxLayoutcxEditAdapters;

type
  TFormAllegati = class(TBaseForm)
    ActionList: TActionList;
    IndicizzaAllegatiSenzaTesto: TAction;
    layoutCerca: TdxLayoutControl;
    layoutCercaGroup_Root: TdxLayoutGroup;
    edCerca: TcxTextEdit;
    btnCerca: TcxButton;
    dxLayoutItemBtnCerca: TdxLayoutItem;
    Cerca: TAction;
    dxLayoutItemEdCerca: TdxLayoutItem;
    IndicizzaAllegatoSelezionato: TAction;
    procedure CercaExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IndicizzaAllegatiSenzaTestoExecute(Sender: TObject);
    procedure IndicizzaAllegatoSelezionatoExecute(Sender: TObject);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure AfterCreateControls; override;
  public
  end;

var
  FormAllegati: TFormAllegati;

implementation

uses
  cxFilter,
  dmAllegati,
  zDm_Images,
  zRestrictions,
  zRestrictions.Types,
   
  zMsg;

{$R *.dfm}
{ TFormAllegati }

procedure TFormAllegati.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Elenco Allegati';
  ReportGroup := 'Elenco Allegati';

  layoutCerca.Visible := False;
  layoutCerca.Parent := Self;

  RestrictionManager.AddDefaultLevel(IndicizzaAllegatiSenzaTesto, TAccessLevel.alNone);
end;

procedure TFormAllegati.CreateDataModule;
begin
  inherited;
  CreateDM(TAllegati, Allegati);
end;

procedure TFormAllegati.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Allegati);
end;

procedure TFormAllegati.AfterCreateControls;
begin
  inherited;
  AddLayoutItem(layoutCerca, 'Cerca', False);
end;

procedure TFormAllegati.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
  // exit;
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'ElencoAllegatiRisorse') then
    // begin
      // view.AddAction(IndicizzaAllegatiSenzaTesto, zDmImages.ImageList16);
      // view.AddAction(IndicizzaAllegatoSelezionato, zDmImages.ImageList16);
      // view.InitToolActions;
    // end
    // else
      // if SameText(DataSetName, 'Risorse_Senza_Cv') then
      // begin
        // Tools.AddFiltroAnnoFormativo(view, Allegati.GetDataSet(DataSetName));
      // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormAllegati.CercaExecute(Sender: TObject);
var
  view: TzDbView;
begin
  inherited;

  view := GetView('ElencoAllegatiRisorse');

  if edCerca.Text = '' then
    view.AddFilterCondition('TESTO', foContains, null)
  else
    view.AddFilterCondition('TESTO', foContains, edCerca.Text);
end;

procedure TFormAllegati.IndicizzaAllegatiSenzaTestoExecute(Sender: TObject);
begin
  inherited;

  if ConfirmYesNo('Si desidera indicizzare tutti gli allegati?') then
    Allegati.IndicizzaAllegatiSenzaTesto;
end;

procedure TFormAllegati.IndicizzaAllegatoSelezionatoExecute(Sender: TObject);
begin
  inherited;
  Allegati.IndicizzaAllegatoSelezionato;
end;

end.
