unit frmRegistraPresenzeTirocini;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  System.Actions,
  System.ImageList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.StdActns,
  Vcl.ActnList,
  Vcl.ImgList,
  Data.DB,
  dxScrollbarAnnotations,
  dxCore,
  dxLayoutContainer,
  dxLayoutcxEditAdapters,
  dxLayoutControl,
  dxCheckGroupBox,
  dxStatusBar,
  dxBar,
  dxFileActions,
  dxActions,
  dxForms,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
  cxSchedulerStorage,
  cxSchedulerCustomControls,
  cxSchedulerDateNavigator,
  cxContainer,
  cxDateNavigator,
  cxEdit,
  cxInplaceContainer,
  cxVGrid,
  cxOI,
  cxDateUtils,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxCalendar,
  cxSpinEdit,
  cxTimeEdit,
  cxClasses,
  cxGroupBox,
  cxCheckBox,
  cxBarEditItem,
  cxSchedulerActions,
  cxImageList,
  cxGridCustomTableView,
  OkCancel,
  zDbView,
  zDbCard;

type
  TFormRegistraPresenzeTirocini = class(TdxForm)
    Actions: TActionList;
    PrimoGiornoDaRendicontare: TAction;
    SelezionaGiorno: TAction;
    Precedente: TAction;
    Successivo: TAction;
    dxBarManager: TdxBarManager;
    dxBarManagerBar: TdxBar;
    cxBarEditItem1: TcxBarEditItem;
    dxBarButtonVaiAlGiorno: TdxBarButton;
    dxBarButtonPrecedente: TdxBarButton;
    dxBarButtonSuccessivo: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    viewSettimanale: TzDbView;
    dxBarButton2: TdxBarButton;
    Chiudi: TAction;
    dxBarButton3: TdxBarButton;
    GeneraPresenze: TAction;
    dxBarButton1: TdxBarButton;
    cardRiepilogoOre: TzDbCard;
    dxLayoutControlGroup_Root: TdxLayoutGroup;
    dxLayoutControl: TdxLayoutControl;
    dxLayoutItemViewSettimanale: TdxLayoutItem;
    dxLayoutItemCard: TdxLayoutItem;
    dxStatusBar: TdxStatusBar;
    dxLayoutSplitterItem: TdxLayoutSplitterItem;
    RiepilogoSrc: TDataSource;
    Giornaliera: TAction;
    Settimanale: TAction;
    viewPresenze: TzDbView;
    dxLayoutItemViewPresenze: TdxLayoutItem;
    dxLayoutGroupViste: TdxLayoutGroup;
    dxLayoutSplitterItem1: TdxLayoutSplitterItem;
    procedure ChiudiExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PrecedenteExecute(Sender: TObject);
    procedure SuccessivoExecute(Sender: TObject);
    procedure SelezionaGiornoExecute(Sender: TObject);
    procedure GeneraPresenzeExecute(Sender: TObject);
    procedure PrimoGiornoDaRendicontareExecute(Sender: TObject);
    procedure viewCalendarioStagecxGridDBTableViewEditing(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; var AAllow: Boolean);
  private
    procedure UpdateSelezionaGiornoCaption;
  protected
    procedure LoadFromIni;
    procedure SaveToIni;
  public
    procedure Edit();
  end;

var
  FormRegistraPresenzeTirocini: TFormRegistraPresenzeTirocini;

procedure ApriRegistraPresenzeTirocini;

implementation

uses
  System.DateUtils,
  zDX,
  dmTirocini,
  zMsg,
  ConfigModule,
  zStorage;

{$R *.dfm}

procedure ApriRegistraPresenzeTirocini;
begin
  Application.CreateForm(TFormRegistraPresenzeTirocini, FormRegistraPresenzeTirocini);
  try
    FormRegistraPresenzeTirocini.Edit();
  finally
    FreeAndNil(FormRegistraPresenzeTirocini);
  end;
end;

procedure TFormRegistraPresenzeTirocini.FormCreate(Sender: TObject);
begin
  Width := 1050;
  Height := 480;

  // Legami a dx.Immagini ripristinati da codice: l'IDE li toglie dal DFM se la unit
  // si salva con zDX chiuso
  Actions.Images := dx.Immagini;
  dxBarManager.ImageOptions.Images := dx.Immagini;
  dxBarManager.ImageOptions.LargeImages := dx.Immagini;

  dx.InitBar(dxBarManagerBar);
  dx.InitLayoutControl(dxLayoutControl);

  dxLayoutGroupViste.TabbedOptions.HideTabs := True;
  dxLayoutGroupViste.ItemIndex := 0;

  viewSettimanale.zSystem := Config.zSystem;
  viewSettimanale.zDataSet := Tirocini.GetDataSet('RendicontazioneSettimanale');
  viewSettimanale.cxGridDBTableView.OnEditing := viewCalendarioStagecxGridDBTableViewEditing;

  viewPresenze.zSystem := Config.zSystem;
  viewPresenze.zDataSet := Tirocini.GetDataSet('RendicontazioneSettimanaleDettaglio');

  cardRiepilogoOre.zSystem := Config.zSystem;
  cardRiepilogoOre.zDataSet := Tirocini.GetDataSet('Studenti_Tirocini_Calendario_Riepilogo_Ore');

  // essendo "lookup" non assegna automaticamente la MasterSource
  RiepilogoSrc.DataSet := viewSettimanale.zDataSet;
  viewPresenze.zDataSet.MasterSource := RiepilogoSrc;
  cardRiepilogoOre.zDataSet.MasterSource := RiepilogoSrc;
end;

procedure TFormRegistraPresenzeTirocini.ChiudiExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormRegistraPresenzeTirocini.Edit;
begin
  UpdateSelezionaGiornoCaption;

  if assigned(viewSettimanale.zDataSet) then
    viewSettimanale.zDataSet.Active := True;

  if assigned(viewPresenze.zDataSet) then
    viewPresenze.zDataSet.Active := True;

  if assigned(cardRiepilogoOre.zDataSet) then
    cardRiepilogoOre.zDataSet.Active := True;

  LoadFromIni;
  ShowModal;
  SaveToIni;
end;

procedure TFormRegistraPresenzeTirocini.LoadFromIni;
var
  MaxWidth, MaxHeight: Integer;
begin
  MaxWidth := ClientWidth;
  MaxHeight := ClientHeight;

  TzStorage.LoadControlFromIni(Config.StorageFileName, Self, MaxWidth, MaxHeight);
end;

procedure TFormRegistraPresenzeTirocini.SaveToIni;
begin
  TzStorage.SaveControlToIni(Config.StorageFileName, Self);
end;

procedure TFormRegistraPresenzeTirocini.viewCalendarioStagecxGridDBTableViewEditing(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem; var AAllow: Boolean);
var
  DataPresenza: TDateTime;
  attiva: Boolean;
begin
  AAllow := True;

  try
    DataPresenza := viewSettimanale.GetValue('DATA_PRESENZA');
    attiva := viewSettimanale.GetValue('ATTIVA');

    AAllow := attiva and (DataPresenza <= Date);
  except
  end;
end;

procedure TFormRegistraPresenzeTirocini.PrimoGiornoDaRendicontareExecute(Sender: TObject);
begin
  Tirocini.SelezionaPrimoGiornoNonRendicontato;
end;

procedure TFormRegistraPresenzeTirocini.GeneraPresenzeExecute(Sender: TObject);
begin
  Tirocini.GeneraPresenze;
end;

procedure TFormRegistraPresenzeTirocini.UpdateSelezionaGiornoCaption;
begin
  SelezionaGiorno.Caption := Tirocini.RendicontazioneParams.DataInizio.ToString;
end;

procedure TFormRegistraPresenzeTirocini.PrecedenteExecute(Sender: TObject);
begin
  Tirocini.RendicontazioneParams.Decrementa;
  UpdateSelezionaGiornoCaption;
end;

procedure TFormRegistraPresenzeTirocini.SuccessivoExecute(Sender: TObject);
begin
  Tirocini.RendicontazioneParams.Incrementa;
  UpdateSelezionaGiornoCaption;
end;

procedure TFormRegistraPresenzeTirocini.SelezionaGiornoExecute(Sender: TObject);
var
  Data: TDate;
begin
  inherited;

  Data := Tirocini.RendicontazioneParams.DataInizio;

  if zMsg.InputDate('Seleziona data', 'Seleziona data', Data) then
  begin
    Tirocini.RendicontazioneParams.DataInizio := Data;
    UpdateSelezionaGiornoCaption;
  end;
end;

end.
