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
    ModificaEstensore: TAction;
    AccettaOreResidue: TAction;
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
    Procedi: TAction;
    Respingi: TAction;
    procedure AccettaOreResidueExecute(Sender: TObject);
    procedure AggiungiStudentiStageExecute(Sender: TObject);
    procedure BudgetAggiungiRigheExecute(Sender: TObject);
    procedure BudgetCopiaDaAltroProgettoExecute(Sender: TObject);
    procedure CalendarioCorsiExecute(Sender: TObject);
    procedure CopiaMaterieExecute(Sender: TObject);
    procedure EsportaPDFFirmatiDigitalmenteExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IscrizioneStudentiExecute(Sender: TObject);
    procedure MaterieGeneraIncaricoExecute(Sender: TObject);
    procedure ModificaEstensoreExecute(Sender: TObject);
    procedure NumerazioneRegistroExecute(Sender: TObject);
    procedure NuovaAziendaOspitanteExecute(Sender: TObject);
    procedure NuovoPianoPersonaleExecute(Sender: TObject);
    procedure ProcediExecute(Sender: TObject);
    procedure RegistroStudentiExecute(Sender: TObject);
    procedure RespingiExecute(Sender: TObject);
  private
    procedure IncarichiDaLavorare(view: TzDbView; Incarichi: TList<integer>);
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
  zMsg,
  frmContratti,
  zFbDataSet,
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

// Mantis #183 - 2026-10-02: VerificatoExecute e AutorizzaIncaricoExecute
// servivano gli elenchi IncarichiDaVerificare e IncarichiDaAutorizzare, tolti:
// i loro passaggi si eseguono con Procedi dall'elenco unico.

// Mantis #183 - 2026-10-01: un solo comando per l'elenco unico. Il passaggio
// dipende dalla fase degli incarichi selezionati, che deve essere una sola.
procedure TFormProgetti.ProcediExecute(Sender: TObject);
var
  Incarichi: TList<integer>;
  view: TzDbView;
  Fase, Azione: string;
begin
  inherited;

  // Mantis #183 - 2026-10-08: l'elenco si chiama IncarichiDaGestire (prima IncarichiDaLavorare)
  view := getView('IncarichiDaGestire');

  Incarichi := TList<integer>.Create;
  try
    // Mantis #183 - 2026-10-29: dalla scheda aperta solo l'incarico della
    // scheda, dall'elenco la selezione solo se comprende la riga corrente
    IncarichiDaLavorare(view, Incarichi);

    Fase := Progetti.FaseDegliIncarichi(Incarichi, Azione);

    if Fase = '' then
      exit;

    // approvazione e invio della firma stanno nella gestione dei contratti,
    // con i firmatari e l'aggiornamento dello stato dal fornitore
    if SameText(Fase, 'FIRMA_DA_APPROVARE') or SameText(Fase, 'FIRMA_DA_INVIARE') then
    begin
      if FormCollection.FormExists(TFormContratti) then
        FormCollection.GetForm(TFormContratti).ShowForm(False)
      else
        FormCollection.CreateForm(TFormContratti);
    end
    else
      if SameText(Fase, 'FIRMA_DA_RIFARE') then
        ConfirmOk('La firma si rimanda dal contratto dell''incarico, fra i suoi documenti, con il comando Firma.')
      else
        Progetti.Procedi(Incarichi, Fase, Azione);
  finally
    FreeAndNil(Incarichi);
  end;

  // Mantis #183 - 2026-10-19: dopo la riapertura la selezione restava sulle
  // righe di prima e il Procedi successivo poteva riprendere un incarico gia'
  // lavorato: si riparte dalla sola riga corrente
  view.ClearSelection;
  view.FocusGrid;
end;

// Mantis #183 - 2026-10-29: gli incarichi su cui lavora Procedi. Prima era
// sempre la selezione della griglia, anche con la scheda di un incarico
// aperta: la scheda lavora sul record corrente, ma la griglia poteva tenere
// selezionate altre righe (a CAPAC il 22/10, dalla scheda dell'incarico 513036,
// e' stato attivato e protocollato anche il 513002, che lo precede
// nell'elenco, con lo stesso numero 671). Ora:
// - con la scheda aperta conta solo l'incarico della scheda;
// - dall'elenco conta la selezione se comprende la riga corrente; una
//   selezione che non la comprende e' rimasta da un passaggio precedente e
//   si lavora sulla sola riga corrente, quella che l'utente vede.
procedure TFormProgetti.IncarichiDaLavorare(view: TzDbView; Incarichi: TList<integer>);
var
  DataSet: TzFbDataSet;
  IdCorrente: integer;
begin
  Incarichi.Clear;

  DataSet := view.zDataSet;
  if (not assigned(DataSet)) or (not DataSet.Active) or DataSet.IsEmpty then
    exit;

  IdCorrente := DataSet.FieldByName('ID_INCARICO').AsInteger;

  if not view.CardVisible then
  begin
    // Mantis #183 - 2026-10-19: ogni incarico una volta sola
    view.GetSelectedRows('ID_INCARICO', Incarichi, true);

    if Incarichi.Contains(IdCorrente) then
      exit;

    Incarichi.Clear;
  end;

  Incarichi.Add(IdCorrente);
end;

// Mantis #183 - 2026-10-29: respinge le richieste selezionate nell'elenco
// unico, in attesa del visto contabile o della direzione. La
// ripresentazione invece passa da Procedi (fase RESPINTO).
procedure TFormProgetti.RespingiExecute(Sender: TObject);
var
  Incarichi: TList<integer>;
  view: TzDbView;
begin
  inherited;

  view := getView('IncarichiDaGestire');

  Incarichi := TList<integer>.Create;
  try
    // stesso criterio di Procedi: con la scheda aperta solo il suo incarico
    IncarichiDaLavorare(view, Incarichi);
    Progetti.Respingi(Incarichi);
  finally
    FreeAndNil(Incarichi);
  end;

  // come dopo Procedi: si riparte dalla sola riga corrente
  view.ClearSelection;
  view.FocusGrid;
end;

procedure TFormProgetti.CopiaMaterieExecute(Sender: TObject);
begin
  inherited;
  Progetti.CopiaMaterie;
end;

// Mantis #183 - 2026-10-02: era IncongruitaVerificataExecute, su IncarichiNonCongrui
procedure TFormProgetti.AccettaOreResidueExecute(Sender: TObject);
var
  Incarichi: TList<integer>;
begin
  inherited;

  Incarichi := TList<integer>.Create;
  try
    getView('IncarichiScadutiConOreResidue').GetSelectedRows('ID_INCARICO', Incarichi);
    Progetti.AccettaOreResidue('IncarichiScadutiConOreResidue', Incarichi);
  finally
    FreeAndNil(Incarichi);
  end;
end;

procedure TFormProgetti.ModificaEstensoreExecute(Sender: TObject);
begin
  inherited;
  // Mantis #183 - 2026-10-01: dall'elenco unico (IncarichiDaGestire)
  Progetti.ModificaEstensore(SelectedDataSetName);
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
