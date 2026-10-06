unit frmGestioneUtenti;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  BaseFrm,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  dxBarExtItems,
  cxClasses,
  ActnList,
  cxLabel,
  ExtCtrls,
  zDbView,
  cxPC,
  cxPCdxBarPopupMenu,
  cxSplitter,
  dxSkinsCore,
  dxSkinsdxBarPainter,
  dxSkinscxPCPainter,
  dxBarBuiltInMenu,
  System.Actions,
  zFormController,
  Base_DataModule,
  cxImageComboBox,
  cxBarEditItem,
  dxUIAClasses;

type
  TFormGestioneUtenti = class(TBaseForm)
    ActionList: TActionList;
    RicaricaImpostazioniUtente: TAction;
    InizializzaSettings: TAction;
    dxBarLargeButton1: TdxBarLargeButton;
    dxBarButtonRicaricaImpostazioniUtente: TdxBarButton;
    InizializzaAutorizzazioni: TAction;
    ClonaUtente: TAction;
    InizializzaHyperLinks: TAction;
    ImpersonaUtenteSelezionato: TAction;
    Shutdown: TAction;
    BroadcastMessage: TAction;
    AggiungiUtenti: TAction;
    InizializzaNotifiche: TAction;
    CreaUtenteDominio: TAction;
    procedure AggiungiUtentiExecute(Sender: TObject);
    procedure BroadcastMessageExecute(Sender: TObject);
    procedure ClonaUtenteExecute(Sender: TObject);
    procedure CreaUtenteDominioExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImpersonaUtenteSelezionatoExecute(Sender: TObject);
    procedure InizializzaAutorizzazioniExecute(Sender: TObject);
    procedure InizializzaHyperLinksExecute(Sender: TObject);
    procedure InizializzaNotificheExecute(Sender: TObject);
    procedure InizializzaSettingsExecute(Sender: TObject);
    procedure RicaricaImpostazioniUtenteExecute(Sender: TObject);
    procedure ShutdownExecute(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
  public
  end;

var
  FormGestioneUtenti: TFormGestioneUtenti;

implementation

uses
  dmGestioneUtenti,
  zDm_Images,
  MainForm,
  MDI_Lib,
  ConfigModule,
  zSystem,
  Gesty_Filters;
{$R *.dfm}

procedure TFormGestioneUtenti.CreateDataModule;
begin
  inherited;
  CreateDM(TGestioneUtenti, GestioneUtenti);
end;

procedure TFormGestioneUtenti.DestroyDataModule;
begin
  inherited;
  FreeAndNil(GestioneUtenti);
end;

procedure TFormGestioneUtenti.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Gestione Utenti';
  ReportGroup := 'GestioneUtenti';
end;

procedure TFormGestioneUtenti.InizializzaAutorizzazioniExecute(Sender: TObject);
begin
  inherited;
  GestioneUtenti.InizializzaAutorizzazioni;
end;

procedure TFormGestioneUtenti.InizializzaSettingsExecute(Sender: TObject);
begin
  inherited;
  GestioneUtenti.InizializzaSettings;
end;

procedure TFormGestioneUtenti.RicaricaImpostazioniUtenteExecute(Sender: TObject);
begin
  inherited;
  GestioneUtenti.RicaricaImpostazioniUtente;
  FormCollection.UpdatePolicies;
end;

procedure TFormGestioneUtenti.ClonaUtenteExecute(Sender: TObject);
begin
  inherited;
  GestioneUtenti.ClonaUtente;
end;

procedure TFormGestioneUtenti.ImpersonaUtenteSelezionatoExecute(Sender: TObject);
begin
  inherited;
  if GestioneUtenti.ImpersonaUtenteSelezionato then
    Close;
end;

procedure TFormGestioneUtenti.InizializzaHyperLinksExecute(Sender: TObject);
begin
  inherited;
  GestioneUtenti.InizializzaHyperLinks;
end;

procedure TFormGestioneUtenti.ShutdownExecute(Sender: TObject);
begin
  inherited;
  Config.Shutdown;
end;

procedure TFormGestioneUtenti.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
// view: TzDbView;
//
// procedure AddFiltroAttivo(view: TzDbView; const DataSetName: String);
// begin
// tools.AddFiltroPickList('Attivo', view, GestioneUtenti.GetDataSet(DataSetName), 'PARAM_ATTIVO', 'Attivo', 'attivo', null, True, 'Tutti', 110);
// end;
//
// procedure AddFiltroVisibile(view: TzDbView; const DataSetName: String);
// begin
// tools.AddFiltroPickList('Visibile', view, GestioneUtenti.GetDataSet(DataSetName), 'PARAM_VISIBILE', 'Visibile', 'visibile', null, True, 'Tutti', 110);
// end;
//
// begin
// inherited;
//
// if Component is TzDbView then
// begin
// view := TzDbView(Component);
//
// if SameText(DataSetName, 'Usr_Utenti') then
// begin
// view.AddAction(ClonaUtente, zDmImages.ImageList16);
// view.AddAction(ImpersonaUtenteSelezionato, zDmImages.ImageList16);
// view.AddAction(CreaUtenteDominio, zDmImages.ImageList16);
// view.InitToolActions;
// end
// else
// if SameText(DataSetName, 'Usr_Utenti_Gruppi') then
// begin
// AddFiltroAttivo(view, DataSetName);
// end
// else
// if SameText(DataSetName, 'Usr_Utenti_Authorizations') then
// begin
// view.AddAction(InizializzaAutorizzazioni, zDmImages.ImageList16);
// view.InitToolActions;
// AddFiltroAttivo(view, DataSetName);
// end
// else
// if SameText(DataSetName, 'Usr_Utenti_Policies') then
// begin
// AddFiltroAttivo(view, DataSetName);
// end
// else
// if SameText(DataSetName, 'Usr_Utenti_Enti_Sedi') then
// begin
// AddFiltroVisibile(view, DataSetName);
// end
// else
// if SameText(DataSetName, 'Usr_Utenti_Allegati') then
// begin
// AddFiltroVisibile(view, DataSetName);
// end
// else
// if SameText(DataSetName, 'Usr_Settings') then
// begin
// view.AddAction(InizializzaSettings, zDmImages.ImageList16);
// view.InitToolActions;
// end
// else
// if SameText(DataSetName, 'Usr_Hyperlinks') then
// begin
// view.AddAction(InizializzaHyperLinks, zDmImages.ImageList16);
// view.InitToolActions;
// end
// else
// if SameText(DataSetName, 'Usr_Utenti_Attivi') then
// begin
// view.AddAction(BroadcastMessage, zDmImages.ImageList16);
// view.AddAction(Shutdown, zDmImages.ImageList16);
// view.InitToolActions;
// end
// else
// if SameText(DataSetName, 'Gruppi_Utenti') then
// begin
// view.AddAction(AggiungiUtenti, zDmImages.ImageList16);
// view.InitToolActions;
// end
// else
// if SameText(DataSetName, 'Usr_Authorizations') then
// begin
// view.AddAction(InizializzaAutorizzazioni, zDmImages.ImageList16);
// view.InitToolActions;
// end
//
// else
// if SameText(DataSetName, 'Gruppi_Autorizzazioni') then
// begin
// AddFiltroAttivo(view, DataSetName);
// end
// else
// if SameText(DataSetName, 'Usr_Gruppi_Policies') then
// begin
// AddFiltroAttivo(view, DataSetName);
// end
// else
// if SameText(DataSetName, 'Authorizations_Gruppi') then
// begin
// AddFiltroAttivo(view, DataSetName);
// end
// else
// if SameText(DataSetName, 'Usr_Gruppi_Enti_Sedi_Elenco') then
// begin
// AddFiltroVisibile(view, DataSetName);
// end
// else
// if SameText(DataSetName, 'Usr_Gruppi_Allegati_Elenco') then
// begin
// AddFiltroVisibile(view, DataSetName);
// end
// else
// if SameText(DataSetName, 'Usr_Policies_Gruppi') then
// begin
// AddFiltroAttivo(view, DataSetName);
// end
// else
// if SameText(DataSetName, 'zz_Notifiche') then
// begin
// view.AddAction(InizializzaNotifiche, zDmImages.ImageList16);
// view.InitToolActions;
// end
// else
// if SameText(DataSetName, 'zz_Notifiche_Sottoscrizioni') then
// begin
// AddFiltroAttivo(view, DataSetName);
// end
// else
// if SameText(DataSetName, 'Usr_Utenti_Sottoscrizioni_Notifiche') then
// begin
// AddFiltroAttivo(view, DataSetName);
// end
// else
// if SameText(DataSetName, 'Usr_Gruppi_Sottoscrizioni_Notifiche') then
// begin
// AddFiltroAttivo(view, DataSetName);
// end
// end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent }
end;

procedure TFormGestioneUtenti.AggiungiUtentiExecute(Sender: TObject);
begin
  inherited;
  GestioneUtenti.AggiungiUtenti;
end;

procedure TFormGestioneUtenti.BroadcastMessageExecute(Sender: TObject);
begin
  inherited;
  Config.BroadcastMessage;
end;

procedure TFormGestioneUtenti.CreaUtenteDominioExecute(Sender: TObject);
begin
  inherited;
  GestioneUtenti.CreaUtenteDominio;
end;

procedure TFormGestioneUtenti.InizializzaNotificheExecute(Sender: TObject);
begin
  inherited;
  GestioneUtenti.InizializzaNotifiche
end;

end.
