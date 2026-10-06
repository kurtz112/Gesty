unit frmAbitare_Sostegno;

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
  zFileViewer;

type
  TFormAbitareSostegno = class(TBaseForm)
    dxBarButton1: TdxBarButton;
    ActionList: TActionList;
    DownloadAllegati: TAction;
    procedure DownloadAllegatiExecute(Sender: TObject);
    procedure DownloadAllegatiUpdate(Sender: TObject);
    procedure RichiestaShowCard(Sender: TObject; Inserting: Boolean);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetupComponent(const DataSetName: String; Component: TComponent); override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormAbitareSostegno: TFormAbitareSostegno;

implementation

uses
  cxFilter,
  zDm_Images,
  dmAbitare_Sostegno,
   
  zFbDataSet,
  zz.files,
  files.Lib,
  ConfigModule;

{$R *.dfm}

procedure TFormAbitareSostegno.CreateDataModule;
begin
  inherited;
  CreateDM(TAbitareSostegno, AbitareSostegno);
end;

procedure TFormAbitareSostegno.DestroyDataModule;
begin
  inherited;
  FreeAndNil(AbitareSostegno);
end;

constructor TFormAbitareSostegno.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'AbitareSostegno';
  Caption := 'AbitareSostegno';
end;

procedure TFormAbitareSostegno.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'ElencoRichieste') then
    // begin
      // view.OnShowCard := RichiestaShowCard;
      // view.AddAction(Autorizza, zDmImages.ImageList16);
      // view.InitToolActions;
// 
      // Tools.AddFiltroAnnoSolare(view, AbitareSostegno.GetDataSet(DataSetName));
      // Tools.AddFiltroAbitareSostegno_Comuni(view, AbitareSostegno.GetDataSet(DataSetName));
    // end
    // else
      // if SameText(DataSetName, 'ElencoLiquidazioni') then
      // begin
        // view.AddAction(Autorizza, zDmImages.ImageList16);
        // view.InitToolActions;
// 
        // Tools.AddFiltroMese(view, AbitareSostegno.GetDataSet(DataSetName));
        // Tools.AddFiltroAnnoSolare(view, AbitareSostegno.GetDataSet(DataSetName));
        // Tools.AddFiltroAbitareSostegno_Comuni(view, AbitareSostegno.GetDataSet(DataSetName));
      // end
      // else
        // if SameText(DataSetName, 'ElencoInquilini') then
        // begin
          // view.AddAction(Autorizza, zDmImages.ImageList16);
          // view.InitToolActions;
// 
          // Tools.AddFiltroAbitareSostegno_Comuni(view, AbitareSostegno.GetDataSet(DataSetName));
        // end
  // end
  // else
    // if SameText(DataSetName, 'ElencoInquilini_StoricoRichieste') then
    // begin
      // view.OnShowCard := RichiestaShowCard;
      // view.AddAction(Autorizza, zDmImages.ImageList16);
      // view.InitToolActions;
    // end
    // else
      // if SameText(DataSetName, 'ElencoProprietari_StoricoRichieste') then
      // begin
        // view.OnShowCard := RichiestaShowCard;
        // view.AddAction(Autorizza, zDmImages.ImageList16);
        // view.InitToolActions;
      // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormAbitareSostegno.RichiestaShowCard(Sender: TObject; Inserting: Boolean);
var
  view: TzDbView;
begin
  inherited;
  AbitareSostegno.ApriSchedaSostegno(Inserting);

  view := TzDbView(Sender);

  if Inserting then
    view.zDataSet.ReOpen()
  else
    view.zDataSet.RefreshRecord();
end;

procedure TFormAbitareSostegno.DownloadAllegatiExecute(Sender: TObject);
begin
  inherited;
  AbitareSostegno.DownloadAllegati;
end;

procedure TFormAbitareSostegno.DownloadAllegatiUpdate(Sender: TObject);
begin
  inherited;

  if Assigned(Config) then
    DownloadAllegati.Visible := Config.zSystem.IsAdmin;
end;

procedure TFormAbitareSostegno.SetupComponent(const DataSetName: String; Component: TComponent);
var
  view: TzDbView;
begin
  inherited;

  if Component is TzDbView then
  begin
    view := TzDbView(Component);

    if SameText(DataSetName, 'ElencoRichieste') then
    begin
      view.OnShowCard := RichiestaShowCard;
    end
    else if SameText(DataSetName, 'ElencoInquilini_StoricoRichieste') then
    begin
      view.OnShowCard := RichiestaShowCard;
    end
    else if SameText(DataSetName, 'ElencoProprietari_StoricoRichieste') then
    begin
      view.OnShowCard := RichiestaShowCard;
    end
    ;
  end;

end;

end.

  Abitare.Abitare_Sostegno_Richieste Abitare.Abitare_Sostegno_Liquidazioni_Elenco

  Abitare.Abitare_Sostegno_Inquilini

  finanziamenti
(totale liquidato, percentuale, etc)dettaglio liquidazioni

// ApriRichiesta

  AddFiltroAnnoSolare AddFiltroMese AddFiltroAbitareSostegno_Comuni
