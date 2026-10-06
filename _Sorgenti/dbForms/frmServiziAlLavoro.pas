unit frmServiziAlLavoro;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
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
  cxLabel;

type
  TFormServiziAlLavoro = class(TBaseForm)
    ActionList: TActionList;
    NuovaAzienda: TAction;
    AggiungiServizi: TAction;
    procedure AggiungiServiziExecute(Sender: TObject);
    procedure NuovaAziendaExecute(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormServiziAlLavoro: TFormServiziAlLavoro;

implementation

uses
  zDm_Images, dmServiziAlLavoro, WizNuovaAziendaOspitanteFrm,   zSystem;

{$R *.dfm}

procedure TFormServiziAlLavoro.CreateDataModule;
begin
  inherited;
  CreateDM(TServiziAlLavoro, ServiziAlLavoro);
end;

procedure TFormServiziAlLavoro.DestroyDataModule;
begin
  inherited;
  FreeAndNil(ServiziAlLavoro);
end;

constructor TFormServiziAlLavoro.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'ServiziAlLavoro';
  Caption := 'ServiziAlLavoro';
end;

procedure TFormServiziAlLavoro.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'UtenteElencoAccessi') then
    // begin
      // Tools.AddFiltroAnnoSolare(view, ServiziAlLavoro.GetDataSet(DataSetName), ivNull);
      // Tools.AddFiltroSportelloSAL(view, ServiziAlLavoro.GetDataSet(DataSetName));
    // end
    // else
      // if SameText(DataSetName, 'AziendeElencoAccessi') then
      // begin
        // view.AddAction(NuovaAzienda, zDmImages.ImageList16);
        // view.InitToolActions;
// 
        // Tools.AddFiltroAnnoSolare(view, ServiziAlLavoro.GetDataSet(DataSetName), ivNull);
        // Tools.AddFiltroSportelloSAL(view, ServiziAlLavoro.GetDataSet(DataSetName));
      // end
      // else
        // if SameText(DataSetName, 'Sal_Utenti_Servizi') then
        // begin
          // view.AddAction(AggiungiServizi, zDmImages.ImageList16);
          // view.InitToolActions;
        // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormServiziAlLavoro.AggiungiServiziExecute(Sender: TObject);
begin
  inherited;
  ServiziAlLavoro.AggiungiServizi;
end;

procedure TFormServiziAlLavoro.NuovaAziendaExecute(Sender: TObject);
begin
  inherited;
  InserisciNuovaAziendaOspitante;
end;

end.
