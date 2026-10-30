unit frmRiunioni;

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
  dxBar,
  System.Actions,
  Vcl.ActnList,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  zDbView,
  zFileViewer;

type
  TFormRiunioni = class(TBaseForm)
    ActionList: TActionList;
    NuovaRiunione: TAction;
    AggiungiPartecipanti: TAction;
    InviaMail: TAction;
    ProgrammaRiunione: TAction;
    AnnullaRiunione: TAction;
    RipristinaRiunione: TAction;
    Verbalizza: TAction;
    Contabilizza: TAction;
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure AggiungiPartecipantiExecute(Sender: TObject);
    procedure AnnullaRiunioneExecute(Sender: TObject);
    procedure ContabilizzaExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InviaMailExecute(Sender: TObject);
    procedure NuovaRiunioneExecute(Sender: TObject);
    procedure ProgrammaRiunioneExecute(Sender: TObject);
    procedure RipristinaRiunioneExecute(Sender: TObject);
    procedure VerbalizzaExecute(Sender: TObject);
  private
    procedure SelezionaRiunione(const IdRiunione: integer);
  protected
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure SetPK(const Value: Variant); override;
  public

  end;

var
  FormRiunioni: TFormRiunioni;

implementation

uses
  cxFilter,
  Files.Lib,
  zHyperLinks,
  WizRiunioniFrm,
  dmRiunioni,
  Gesty.Types;

{$R *.dfm}

procedure TFormRiunioni.CreateDataModule;
begin
  inherited;
  CreateDM(TRiunioni, Riunioni);
end;

procedure TFormRiunioni.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Riunioni);
end;

procedure TFormRiunioni.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Riunioni';
  ReportGroup := 'Riunioni';

  // Valutare se implementare il wizard
  NuovaRiunione.Visible := False;
end;

procedure TFormRiunioni.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
// view: TzDbView;
// begin
// inherited;
//
// if Component is TzDbView then
// begin
// view := TzDbView(Component);
//
// if SameText(DataSetName, 'Riunioni') then
// begin
// view.AddAction(NuovaRiunione, zDmImages.ImageList16);
// view.AddAction(ProgrammaRiunione, zDmImages.ImageList16);
// view.AddAction(Verbalizza, zDmImages.ImageList16).BeginGroup := true;
// view.AddAction(Contabilizza, zDmImages.ImageList16);
// view.AddAction(AnnullaRiunione, zDmImages.ImageList16).BeginGroup := true;
// view.AddAction(RipristinaRiunione, zDmImages.ImageList16).BeginGroup := true;
//
// view.InitToolActions;
//
// Tools.AddFiltroPickList('RIUNIONI_STATO', view, GetDataSet(DataSetName), 'STATO_RIUNIONE', 'Stato Riunione', 'stato riunione', null, true, 'Tutti', 120);
// end
// else
// if SameText(DataSetName, 'Riunioni_Partecipanti') then
// begin
// view.AddAction(AggiungiPartecipanti, zDmImages.ImageList16);
// view.InitToolActions;
// end;
// end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent }
end;

procedure TFormRiunioni.SelezionaRiunione(const IdRiunione: integer);
var
  view: TzDbView;
begin
  view := getView('Riunioni');
  if Assigned(view) then
  begin
    view.ClearFilter(False);

    if IdRiunione <> -1 then
      view.AddFilterCondition('ID_RIUNIONE', foEqual, IdRiunione);
  end;
end;

procedure TFormRiunioni.SetPK(const Value: Variant);
var
  IdRiunione: integer;
begin
  inherited;

  IdRiunione := Value;

  if IdRiunione <> -1 then
    SelezionaRiunione(Value);
end;

procedure TFormRiunioni.NuovaRiunioneExecute(Sender: TObject);
var
  id: integer;
begin
  inherited;
  id := WizRiunioniFrm.NuovaRiunione;

  if id <> -1 then
    SelezionaRiunione(id);
end;

procedure TFormRiunioni.AggiungiPartecipantiExecute(Sender: TObject);
begin
  inherited;
  Riunioni.AggiungiPartecipanti;
end;

procedure TFormRiunioni.AnnullaRiunioneExecute(Sender: TObject);
begin
  inherited;
  Riunioni.AnnullaRiunione;
end;

procedure TFormRiunioni.ContabilizzaExecute(Sender: TObject);
begin
  inherited;
  Riunioni.Contabilizza;
end;

procedure TFormRiunioni.ProgrammaRiunioneExecute(Sender: TObject);
begin
  inherited;
  Riunioni.ProgrammaRiunione;
end;

procedure TFormRiunioni.InviaMailExecute(Sender: TObject);
begin
  inherited;
  Riunioni.InviaMail;
end;

procedure TFormRiunioni.RipristinaRiunioneExecute(Sender: TObject);
begin
  inherited;
  Riunioni.RipristinaRiunione;
end;

procedure TFormRiunioni.VerbalizzaExecute(Sender: TObject);
begin
  inherited;
  Riunioni.Verbalizza;
end;

procedure TFormRiunioni.ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
var
  StatoRiunione: TStatoRiunione;
begin
  inherited;
  StatoRiunione := Riunioni.StatoRiunioneCorrente;

  InviaMail.Visible := StatoRiunione <> srAnnullata;
  AggiungiPartecipanti.Visible := StatoRiunione in [srInserita, srProgrammata];
  ProgrammaRiunione.Visible := StatoRiunione = srInserita;
  Verbalizza.Visible := StatoRiunione = srProgrammata;
  Contabilizza.Visible := StatoRiunione = srVerbalizzata;
  AnnullaRiunione.Visible := StatoRiunione <> srAnnullata;
  RipristinaRiunione.Visible := StatoRiunione = srAnnullata;
end;

initialization

HyperLinks.RegisterHandler('ID_RIUNIONE', TFormRiunioni);

end.
