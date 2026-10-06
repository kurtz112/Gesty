unit frmRichiesteAttivazione;

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
  TFormRichiesteAttivazione = class(TBaseForm)
    ActionList: TActionList;
    NuovaRichiestaAttivazione: TAction;
    RicopiaAllegatiRisorsa: TAction;
    ConvalidaRichiestaAttivazione: TAction;
    RichiestaAttivazioneNonValida: TAction;
    ApprovaRichiestaAttivazione: TAction;
    RespingiRichiestaAttivazione: TAction;
    GeneraRisorsa: TAction;
    procedure ApprovaRichiestaAttivazioneExecute(Sender: TObject);
    procedure ConvalidaRichiestaAttivazioneExecute(Sender: TObject);
    procedure GeneraRisorsaExecute(Sender: TObject);
    procedure NuovaRichiestaAttivazioneExecute(Sender: TObject);
    procedure RespingiRichiestaAttivazioneExecute(Sender: TObject);
    procedure RichiestaAttivazioneNonValidaExecute(Sender: TObject);
    procedure RicopiaAllegatiRisorsaExecute(Sender: TObject);
  private
  protected
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormRichiesteAttivazione: TFormRichiesteAttivazione;

implementation

uses
  cxFilter,
  zDm_Images,
  dmRichiesteAttivazione,
  WizNuovaRichiestaAttivazioneFrm,
  Files.Lib;

{$R *.dfm}

procedure TFormRichiesteAttivazione.CreateDataModule;
begin
  inherited;
  CreateDM(TRichiesteAttivazione, RichiesteAttivazione);
end;

procedure TFormRichiesteAttivazione.DestroyDataModule;
begin
  inherited;
  FreeAndNil(RichiesteAttivazione);
end;

constructor TFormRichiesteAttivazione.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'RichiesteAttivazione';
  Caption := 'RichiesteAttivazione';
end;

procedure TFormRichiesteAttivazione.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
// view: TzDbView;
// begin
// inherited;
//
// if Component is TzDbView then
// begin
// view := TzDbView(Component);
//
// if SameText(DataSetName, 'Richieste_Attivazione') then
// begin
// view.AddAction(NuovaRichiestaAttivazione, zDmImages.ImageList16).HideInCard;
// view.InitToolActions;
// end
// else
// if SameText(DataSetName, 'RichiesteDaValidare') then
// begin
// view.AddAction(ConvalidaRichiestaAttivazione, zDmImages.ImageList16).HideInView;
// view.AddAction(RichiestaAttivazioneNonValida, zDmImages.ImageList16).HideInView;
// view.InitToolActions;
// end
// else
// if SameText(DataSetName, 'RichiesteDaApprovare') then
// begin
// view.AddAction(ApprovaRichiestaAttivazione, zDmImages.ImageList16).HideInView;
// view.AddAction(RespingiRichiestaAttivazione, zDmImages.ImageList16).HideInView;
// view.InitToolActions;
// end
// else
// if SameText(DataSetName, 'RichiesteDaGenerare') then
// begin
// view.AddAction(GeneraRisorsa, zDmImages.ImageList16).HideInView;
// view.InitToolActions;
// end
// else
// if SameText(DataSetName, 'RichiesteDaGenerare_Allegati') then
// begin
// view.AddAction(RicopiaAllegatiRisorsa, zDmImages.ImageList16);
// view.InitToolActions;
// end;
// end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent }
end;

procedure TFormRichiesteAttivazione.ApprovaRichiestaAttivazioneExecute(Sender: TObject);
var
  view: TzDbView;
begin
  inherited;

  if RichiesteAttivazione.ApprovaRichiestaAttivazione then
  begin
    view := getView('RichiesteDaApprovare');
    if Assigned(view) then
      view.CloseCard(False);
  end;
end;

procedure TFormRichiesteAttivazione.ConvalidaRichiestaAttivazioneExecute(Sender: TObject);
var
  view: TzDbView;
begin
  inherited;

  if RichiesteAttivazione.ConvalidaRichiestaAttivazione then
  begin
    view := getView('RichiesteDaValidare');
    if Assigned(view) then
      view.CloseCard(False);
  end;
end;

procedure TFormRichiesteAttivazione.GeneraRisorsaExecute(Sender: TObject);
begin
  inherited;
  RichiesteAttivazione.GeneraRisorsa;
end;

procedure TFormRichiesteAttivazione.NuovaRichiestaAttivazioneExecute(Sender: TObject);
begin
  inherited;

  if ApriNuovaRichiestaAttivazione <> -1 then
    Aggiorna;
end;

procedure TFormRichiesteAttivazione.RespingiRichiestaAttivazioneExecute(Sender: TObject);
begin
  inherited;
  RichiesteAttivazione.RespingiRichiestaAttivazione;
end;

procedure TFormRichiesteAttivazione.RichiestaAttivazioneNonValidaExecute(Sender: TObject);
begin
  inherited;
  RichiesteAttivazione.RichiestaAttivazioneNonValida;
end;

procedure TFormRichiesteAttivazione.RicopiaAllegatiRisorsaExecute(Sender: TObject);
begin
  inherited;
  RichiesteAttivazione.RicopiaAllegatiRisorsa;
end;

end.
