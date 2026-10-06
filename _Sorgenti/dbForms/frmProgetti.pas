unit frmProgetti;

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
  zDbView,
  System.Actions,
  zFormController,
  zFileViewer,
  Generics.Collections,
  Base_DataModule,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxCheckComboBox,
  cxDBCheckComboBox,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl,
  dxUIAClasses;

type
  TFormProgetti = class(TBaseForm)
    ActionList: TActionList;
    Verificato: TAction;
    AutorizzaIncarico: TAction;
    ModificaEstensore: TAction;
    IncongruitaVerificata: TAction;
    CopiaMaterie: TAction;
    NuovoPianoPersonale: TAction;
    IscrizioneStudenti: TAction;
    NumerazioneRegistro: TAction;
    AggiungiStudentiStage: TAction;
    NuovaAziendaOspitante: TAction;
    MaterieGeneraIncarico: TAction;
    BudgetCopiaDaAltroProgetto: TAction;
    BudgetAggiungiRighe: TAction;
    RegistroStudenti: TAction;
    CalendarioCorsi: TAction;
    EsportaPDFFirmatiDigitalmente: TAction;
    procedure AggiungiStudentiStageExecute(Sender: TObject);
    procedure AutorizzaIncaricoExecute(Sender: TObject);
    procedure BudgetAggiungiRigheExecute(Sender: TObject);
    procedure BudgetCopiaDaAltroProgettoExecute(Sender: TObject);
    procedure CalendarioCorsiExecute(Sender: TObject);
    procedure CopiaMaterieExecute(Sender: TObject);
    procedure EsportaPDFFirmatiDigitalmenteExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IncongruitaVerificataExecute(Sender: TObject);
    procedure IscrizioneStudentiExecute(Sender: TObject);
    procedure MaterieGeneraIncaricoExecute(Sender: TObject);
    procedure ModificaEstensoreExecute(Sender: TObject);
    procedure NumerazioneRegistroExecute(Sender: TObject);
    procedure NuovaAziendaOspitanteExecute(Sender: TObject);
    procedure NuovoPianoPersonaleExecute(Sender: TObject);
    procedure RegistroStudentiExecute(Sender: TObject);
    procedure VerificatoExecute(Sender: TObject);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetPK(const Value: Variant); override;
  public
    procedure Stampa; override;
  end;

var
  FormProgetti: TFormProgetti;

implementation

uses
  System.UITypes,
  cxFilter,
  dmProgetti,
  zHyperLinks,
  Files.Lib,
  zDm_Images,
  frmParametriProtocolloIncarico,
  ConfigModule,
   
  frmRegistroStudenti,
  frmOrario,
  zDX,
  zBaseLib,
  MDI_Lib,
  zSystem;

{$R *.dfm}

procedure TFormProgetti.CreateDataModule;
begin
  inherited;
  CreateDM(TProgetti, Progetti);
end;

procedure TFormProgetti.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Progetti);
end;

procedure TFormProgetti.FormCreate(Sender: TObject);
begin
  inherited;
  ReportGroup := 'Progetti';
  Caption := 'Progetti';

  ModificaEstensore.Visible := False; // sarà eventualmente attivato dalle policy
end;

procedure TFormProgetti.SetPK(const Value: Variant);
var
  view: TzDbView;
begin
  inherited;
  //
  if pkMode then
  begin
    SelectedDataSetName := 'Progetti_Finanziamenti';

    view := getView('Progetti');
    if Assigned(view) then
    begin
      view.ClearFilter(False);
      view.AddFilterCondition('ID_PROGETTO', foEqual, pk);
    end;
  end;
end;

procedure TFormProgetti.VerificatoExecute(Sender: TObject);
var
  Incarichi: TList<integer>;
  view: TzDbView;
begin
  Incarichi := TList<integer>.Create;
  try
    view := getView('IncarichiDaVerificare');
    view.GetSelectedRows('ID_INCARICO', Incarichi);
    Progetti.Verificato(Incarichi);
  finally
    FreeAndNil(Incarichi);
  end;
end;

procedure TFormProgetti.AutorizzaIncaricoExecute(Sender: TObject);
var
  view: TzDbView;
begin
  Progetti.AutorizzaIncarico;

  view := getView('IncarichiDaAutorizzare');
  view.FocusGrid;
end;

procedure TFormProgetti.CopiaMaterieExecute(Sender: TObject);
begin
  inherited;
  Progetti.CopiaMaterie;
end;

procedure TFormProgetti.IncongruitaVerificataExecute(Sender: TObject);
begin
  inherited;
  Progetti.IncongruitaVerificata;
end;

procedure TFormProgetti.ModificaEstensoreExecute(Sender: TObject);
begin
  inherited;
  Progetti.ModificaEstensore;
end;

procedure TFormProgetti.NumerazioneRegistroExecute(Sender: TObject);
begin
  inherited;
  Progetti.NumerazioneRegistro;
end;

procedure TFormProgetti.IscrizioneStudentiExecute(Sender: TObject);
begin
  inherited;
  Progetti.IscrizioneStudenti;
end;

procedure TFormProgetti.NuovoPianoPersonaleExecute(Sender: TObject);
begin
  inherited;
  Progetti.NuovoPianoPersonale;
end;

procedure TFormProgetti.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
// begin
  // inherited;
// 
  // siMain.LogColored(TColors.Green, DataSetName);
// 
  // if Component is TzDbView then
  // begin
    // siMain.LogColored(TColors.Red, DataSetName);
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'Progetti') then
    // begin
      // Tools.AddFiltroEnte(view, Progetti.GetDataSet('Progetti'));
      // Tools.AddFiltroAnnoSolare(view, Progetti.GetDataSet('Progetti'), ivNull);
      // Tools.AddFiltroAnnoFormativo(view, Progetti.GetDataSet('Progetti'));
      // Tools.AddFiltroPickList('TIPO_PROGETTO', view, Progetti.GetDataSet('Progetti'), 'TIPO_PROGETTO', 'Tipo Progetto', 'tipo progetto', null, true, 'Tutti', 120);
    // end
    // else
      // if SameText(DataSetName, 'Riepilogo_Ore') then
      // begin
        // Tools.AddFiltroMese(view, Progetti.GetDataSet(DataSetName));
        // Tools.AddFiltroAnnoFormativo(view, Progetti.GetDataSet(DataSetName));
      // end
      // else
        // if SameText(DataSetName, 'IncarichiDaVerificare') then
        // begin
          // view.AddAction(Verificato, zDmImages.ImageList16);
          // view.InitToolActions;
        // end
        // else
          // if SameText(DataSetName, 'IncarichiDaAutorizzare') then
          // begin
            // Tools.AddFiltroPickList('INCARICO_INTERNO_ESTERNO', view, Progetti.GetDataSet(DataSetName), 'INCARICO_INTERNO_ESTERNO', 'Tipo Incarico', 'tipo incarico', null, true, 'Tutti', 100);
// 
            // view.AddAction(ModificaEstensore, zDmImages.ImageList16);
            // view.AddAction(AutorizzaIncarico, zDmImages.ImageList16);
            // view.InitToolActions;
          // end
          // else
            // if SameText(DataSetName, 'IncarichiNonCongrui') then
            // begin
              // view.AddAction(IncongruitaVerificata, zDmImages.ImageList16);
              // view.InitToolActions;
            // end
            // else
              // if SameText(DataSetName, 'Progetti_Materie') then
              // begin
                // view.AddAction(CopiaMaterie, zDmImages.ImageList16);
                // view.AddAction(MaterieGeneraIncarico, zDmImages.ImageList16);
                // view.InitToolActions;
              // end
              // else
                // if SameText(DataSetName, 'Progetti_Piani_Personalizzati') then
                // begin
                  // view.AddAction(NuovoPianoPersonale, zDmImages.ImageList16);
                  // view.InitToolActions;
                // end
                // else
                  // if SameText(DataSetName, 'Studenti_Progetti') then
                  // begin
                    // view.AddAction(IscrizioneStudenti, zDmImages.ImageList16);
                    // view.AddAction(NumerazioneRegistro, zDmImages.ImageList16);
                    // view.InitToolActions;
                  // end
                  // else
                    // if SameText(DataSetName, 'Studenti_Stage') then
                    // begin
                      // view.AddAction(AggiungiStudentiStage, zDmImages.ImageList16);
                      // view.InitToolActions;
                    // end
                    // else
                      // if SameText(DataSetName, 'Progetti_Formativi_Aziende') then
                      // begin
                        // view.AddAction(NuovaAziendaOspitante, zDmImages.ImageList16);
                        // view.InitToolActions;
                      // end
                      // else
                        // if SameText(DataSetName, 'Progetti_Budget_Elenco') then
                        // begin
                          // view.AddAction(BudgetCopiaDaAltroProgetto, zDmImages.ImageList16);
                          // view.AddAction(BudgetAggiungiRighe, zDmImages.ImageList16);
                          // view.InitToolActions;
                        // end
                        // else
                          // if SameText(DataSetName, 'LezioniDaRendicontare') then
                          // begin
                            // view.AddAction(CalendarioCorsi, zDmImages.ImageList16);
                            // view.AddAction(RegistroStudenti, zDmImages.ImageList16);
                            // view.InitToolActions;
                          // end
                          // else
                            // if SameText(DataSetName, 'RiepilogoContrattiFirmatiDigitalmente') then
                            // begin
                              // view.AddAction(EsportaPDFFirmatiDigitalmente, zDmImages.ImageList16);
                              // view.InitToolActions;
                            // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormProgetti.AggiungiStudentiStageExecute(Sender: TObject);
begin
  inherited;
  Progetti.AggiungiStudentiStage;
end;

procedure TFormProgetti.BudgetAggiungiRigheExecute(Sender: TObject);
begin
  inherited;
  Progetti.BudgetAggiungiRighe;
end;

procedure TFormProgetti.BudgetCopiaDaAltroProgettoExecute(Sender: TObject);
begin
  inherited;
  Progetti.BudgetCopiaDaAltroProgetto;
end;

procedure TFormProgetti.MaterieGeneraIncaricoExecute(Sender: TObject);
begin
  inherited;
  Progetti.MaterieGeneraIncarico;
end;

procedure TFormProgetti.NuovaAziendaOspitanteExecute(Sender: TObject);
var
  id: integer;
  view: TzDbView;
begin
  inherited;

  id := Progetti.NuovaAziendaOspitante;

  if id = -1 then
    exit;

  view := getView('Progetti_Formativi_Aziende');
  view.ShowDbCard;
end;

procedure TFormProgetti.CalendarioCorsiExecute(Sender: TObject);
var
  FormOrario: TFormOrario;
  Data: TDateTime;
  IdProgetto: integer;
begin
  inherited;

  if not Progetti.GetLezioniDaRendicontare(Data, IdProgetto) then
    exit;

  if FormCollection.FormExists(TFormOrario) then
    FormOrario := FormCollection.GetForm(TFormOrario) as TFormOrario
  else
    FormOrario := FormCollection.CreateForm(TFormOrario) as TFormOrario;

  FormOrario.ShowForm(False);

  FormOrario.OpenCalendarioCorsi(Data, IdProgetto, -1);
end;

procedure TFormProgetti.RegistroStudentiExecute(Sender: TObject);
var
  FormRegistroStudenti: TFormRegistroStudenti;
  Data: TDateTime;
  IdProgetto: integer;
begin
  inherited;

  if not Progetti.GetLezioniDaRendicontare(Data, IdProgetto) then
    exit;

  if FormCollection.FormExists(TFormRegistroStudenti) then
    FormRegistroStudenti := FormCollection.GetForm(TFormRegistroStudenti) as TFormRegistroStudenti
  else
    FormRegistroStudenti := FormCollection.CreateForm(TFormRegistroStudenti) as TFormRegistroStudenti;

  FormRegistroStudenti.ShowForm(False);

  FormRegistroStudenti.OpenRegistro(Data, IdProgetto, -1);
end;

procedure TFormProgetti.EsportaPDFFirmatiDigitalmenteExecute(Sender: TObject);
begin
  inherited;
  Progetti.EsportaPDFFirmatiDigitalmente;
end;

procedure TFormProgetti.Stampa;
var
  view: TzDbView;
begin

  if SameText(SelectedDataSetName, 'Docenti_Incarichi') then
  begin
    view := getView('Docenti_Incarichi');
    view.GetSelectedRows('ID_INCARICO', Progetti.DocentiIncarichiSelezionati);
  end;

  inherited;
  Progetti.DocentiIncarichiSelezionati.clear;
end;

initialization

HyperLinks.RegisterHandler('ID_PROGETTO', TFormProgetti);

end.
