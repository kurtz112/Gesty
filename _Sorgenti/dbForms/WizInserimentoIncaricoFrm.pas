unit WizInserimentoIncaricoFrm;

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
  BaseWizrd,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  System.ImageList,
  Vcl.ImgList,
  System.Actions,
  Vcl.ActnList,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  Vcl.ExtCtrls,
  zDbView,
  zDbCard,
  cxTextEdit,
  cxMemo,
  Vcl.StdCtrls,
  Base_DataModule,
  cxSplitter,
  dxCustomWizardControl,
  dxWizardControl,
  dxLayoutContainer,
  dxLayoutControl,
  zBaseLib,
  zFbDataSet,
  cxImageList,
  cxMaskEdit,
  cxDropDownEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBExtLookupComboBox,
  dxUIAClasses;

type
  TWizInserimentoIncaricoForm = class(TBaseWizard)
    cardIncarico: TzDbCard;
    viewPiani: TzDbView;
    memoRiepilogo: TcxMemo;
    InserimentoPersonale: TAction;
    Splitter: TcxSplitter;
    viewServizi: TzDbView;
    AggiungiStudenti: TAction;
    AggiungiServizi: TAction;
    cardRiepilogo: TzDbCard;
    Panel: TPanel;
    ImageList: TImageList;
    pagePIP: TdxWizardControlPage;
    pageCorsi: TdxWizardControlPage;
    layoutCorsiGroup_Root: TdxLayoutGroup;
    layoutCorsi: TdxLayoutControl;
    viewCorsi: TzDbView;
    dxLayoutItemViewCorsi: TdxLayoutItem;
    cardCorsi: TzDbCard;
    dxLayoutItemCardCorsi: TdxLayoutItem;
    dxLayoutSplitterItem1: TdxLayoutSplitterItem;
    CreaNuovoCorso: TAction;
    progettoActions: TActionList;
    NuovoProgetto: TAction;
    procedure AggiungiServiziExecute(Sender: TObject);
    procedure AggiungiStudentiExecute(Sender: TObject);
    procedure cardCorsiAfterCreateControls(Sender: TObject);
    procedure cardIncaricoAfterCreateControls(Sender: TObject);
    procedure cardIncaricoAfterCreateDbControl(Sender: TObject; const FieldName: string; cxCustomEdit: TcxCustomEdit);
    procedure CreaNuovoCorsoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InserimentoPersonaleExecute(Sender: TObject);
    procedure NuovoProgettoExecute(Sender: TObject);
    procedure WizardButtonClick(Sender: TObject; AKind: TdxWizardControlButtonKind; var AHandled: Boolean);
    procedure WizardPageChanged(Sender: TObject);
    procedure WizardPageChanging(Sender: TObject; ANewPage: TdxWizardControlCustomPage; var AAllow: Boolean);
  private type
    TStato = (Inserimento, InserimentoDaOrario, InserimentoDaPIP, InserimentoDaASR, Rettifica, Duplicazione);
  private
    Stato: TStato;
    IdPianoPersonalizzato: integer;
    IdentificativoPIP: string;
  protected
    procedure LoadWizardFromZip; override;
  protected
    function ConfermaAnnulla: Boolean; override;
    function ConfermaChiusura: Boolean; override;
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure AfterShowForm(const Modal: Boolean); override;
  end;

function ApriInserimentoIncarico(const IdPersonale: integer = -1; const IdProgetto: integer = -1; const DataInizio: TDateTime = 0; const DataFine: TDateTime = 0; const TipoIncarico: string = ''; const Materia: string = '';
  const TotaleOreAttribuite: double = 0): integer;

function ApriInserimentoIncaricoDaOrario(const IdOrario: integer): integer;
function ApriInserimentoIncaricoDaPIP(const IdPersonale, IdProgetto, IdPianoPersonalizzato: integer; const IdentificativoPIP: string; const DataInizio, DataFine: TDateTime): integer;
function ApriRettificaIncarico(const IdIncarico: integer): integer;
function ApriDuplicaIncarico(const IdIncarico: integer): integer;

function ApriInserimentoASR(const IdProgetto: integer = -1; const IdCorso: integer = -1; const TotaleOreAttribuite: double = 0): integer;

implementation

uses
  ConfigModule,
  zdx,
  WizInserimentoIncaricoDM,
  WizNuovaRichiestaAttivazioneFrm,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

{$R *.dfm}

function ApriInserimentoIncarico(const IdPersonale: integer = -1; const IdProgetto: integer = -1; const DataInizio: TDateTime = 0; const DataFine: TDateTime = 0; const TipoIncarico: string = ''; const Materia: string = '';
  const TotaleOreAttribuite: double = 0): integer;
var
  WizInserimentoIncaricoForm: TWizInserimentoIncaricoForm;
begin
  result := -1;

  Application.CreateForm(TWizInserimentoIncaricoForm, WizInserimentoIncaricoForm);
  try
    WizInserimentoIncaricoForm.Stato := Inserimento;
    WizInserimentoIncarico.InsertIncarico(IdPersonale, IdProgetto, DataInizio, DataFine, TipoIncarico, Materia, TotaleOreAttribuite);

    if WizInserimentoIncaricoForm.ShowForm(True) then
      result := WizInserimentoIncarico.IdIncarico;
  finally
    FreeAndNil(WizInserimentoIncaricoForm);
  end;
end;

function ApriInserimentoIncaricoDaOrario(const IdOrario: integer): integer;
var
  WizInserimentoIncaricoForm: TWizInserimentoIncaricoForm;
begin
  result := -1;

  Application.CreateForm(TWizInserimentoIncaricoForm, WizInserimentoIncaricoForm);
  try
    WizInserimentoIncaricoForm.Stato := InserimentoDaOrario;
    WizInserimentoIncarico.InsertIncaricoDaOrario(IdOrario);

    if WizInserimentoIncaricoForm.ShowForm(True) then
      result := WizInserimentoIncarico.IdIncarico;
  finally
    FreeAndNil(WizInserimentoIncaricoForm);
  end;
end;

function ApriInserimentoIncaricoDaPIP(const IdPersonale, IdProgetto, IdPianoPersonalizzato: integer; const IdentificativoPIP: string; const DataInizio, DataFine: TDateTime): integer;
var
  WizInserimentoIncaricoForm: TWizInserimentoIncaricoForm;
begin
  result := -1;

  Application.CreateForm(TWizInserimentoIncaricoForm, WizInserimentoIncaricoForm);
  try
    WizInserimentoIncaricoForm.Stato := InserimentoDaPIP;
    WizInserimentoIncaricoForm.IdPianoPersonalizzato := IdPianoPersonalizzato;
    WizInserimentoIncaricoForm.IdentificativoPIP := IdentificativoPIP;
    WizInserimentoIncarico.InsertIncarico(IdPersonale, IdProgetto, DataInizio, DataFine);

    if WizInserimentoIncaricoForm.ShowForm(True) then
      result := WizInserimentoIncarico.IdIncarico;
  finally
    FreeAndNil(WizInserimentoIncaricoForm);
  end;
end;

function ApriRettificaIncarico(const IdIncarico: integer): integer;
var
  WizInserimentoIncaricoForm: TWizInserimentoIncaricoForm;
begin
  result := -1;

  Application.CreateForm(TWizInserimentoIncaricoForm, WizInserimentoIncaricoForm);
  try
    WizInserimentoIncaricoForm.Stato := Rettifica;
    WizInserimentoIncarico.RettificaIncarico(IdIncarico);

    if WizInserimentoIncaricoForm.ShowForm(True) then
      result := WizInserimentoIncarico.IdIncarico;
  finally
    FreeAndNil(WizInserimentoIncaricoForm);
  end;
end;

function ApriDuplicaIncarico(const IdIncarico: integer): integer;
var
  WizInserimentoIncaricoForm: TWizInserimentoIncaricoForm;
begin
  result := -1;

  Application.CreateForm(TWizInserimentoIncaricoForm, WizInserimentoIncaricoForm);
  try
    WizInserimentoIncaricoForm.Stato := Duplicazione;
    WizInserimentoIncarico.DuplicaIncarico(IdIncarico);

    if WizInserimentoIncaricoForm.ShowForm(True) then
      result := WizInserimentoIncarico.IdIncarico;
  finally
    FreeAndNil(WizInserimentoIncaricoForm);
  end;
end;

function ApriInserimentoASR(const IdProgetto: integer = -1; const IdCorso: integer = -1; const TotaleOreAttribuite: double = 0): integer;
var
  WizInserimentoIncaricoForm: TWizInserimentoIncaricoForm;
begin
  result := -1;

  Application.CreateForm(TWizInserimentoIncaricoForm, WizInserimentoIncaricoForm);
  try
    WizInserimentoIncaricoForm.Stato := InserimentoDaASR;
    WizInserimentoIncarico.InserimentoDaASR(IdProgetto, IdCorso, TotaleOreAttribuite);

    if WizInserimentoIncaricoForm.ShowForm(True) then
      result := WizInserimentoIncarico.IdIncarico;
  finally
    FreeAndNil(WizInserimentoIncaricoForm);
  end;
end;

procedure TWizInserimentoIncaricoForm.CreateDataModule;
begin
  inherited;
  CreateDM(TWizInserimentoIncarico, WizInserimentoIncarico);
end;

procedure TWizInserimentoIncaricoForm.DestroyDataModule;
begin
  inherited;
  FreeAndNil(WizInserimentoIncarico);
end;

procedure TWizInserimentoIncaricoForm.FormCreate(Sender: TObject);
begin
  inherited;

  width := 850;
  Height := 650;
  LoadFromIni;

  AutoOpenDataSets := False; // vengono aperti dai singoli metodi
  Stato := Inserimento;
  IdPianoPersonalizzato := -1;
  IdentificativoPIP := '';

  Caption := 'Inserimento Incarico';
  ReportGroup := 'Stampa Incarico';

  SetPageIndex([pageWelcome, pageCorsi, pagePIP, pageFinish]);

  cardIncarico.zDataSet := WizInserimentoIncarico.Incarico;
  cardCorsi.zDataSet := WizInserimentoIncarico.Corsi;
  viewCorsi.zDataSet := WizInserimentoIncarico.Corsi;
  viewPiani.zDataSet := WizInserimentoIncarico.Piani;
  viewServizi.zDataSet := WizInserimentoIncarico.Servizi;
  cardRiepilogo.zDataSet := WizInserimentoIncarico.Riepilogo;

  dx.InitLayoutControl(layoutCorsi);
end;

function TWizInserimentoIncaricoForm.ConfermaChiusura: Boolean;
begin
  result := WizInserimentoIncarico.ConfermaChiusura;
end;

function TWizInserimentoIncaricoForm.ConfermaAnnulla: Boolean;
begin
  result := False;
  if CloseQuery then
    result := WizInserimentoIncarico.ConfermaAnnulla;
end;

procedure TWizInserimentoIncaricoForm.InserimentoPersonaleExecute(Sender: TObject);
var
  id: integer;
begin
  inherited;
  id := ApriNuovaRichiestaAttivazione;

  if id <> -1 then
  begin
    WizInserimentoIncarico.Incarico.CheckEditMode;
    WizInserimentoIncarico.Incarico.FieldByName('ID_RISORSA').asInteger := id;
  end;
end;

procedure TWizInserimentoIncaricoForm.LoadWizardFromZip;
begin
  inherited;
  case Stato of
    Inserimento:
      pageWelcome.Header.Title := 'Inserimento Richiesta Incarico';
    InserimentoDaOrario:
      pageWelcome.Header.Title := 'Inserimento Incarico Da Orario';
    InserimentoDaPIP:
      pageWelcome.Header.Title := 'Inserimento Incarico Da Piano Individuale';
    Rettifica:
      pageWelcome.Header.Title := 'Rettifica Richiesta Incarico';
    Duplicazione:
      pageWelcome.Header.Title := 'Duplicazione Richiesta Incarico';
  end;
end;

procedure TWizInserimentoIncaricoForm.AggiungiServiziExecute(Sender: TObject);
begin
  inherited;
  WizInserimentoIncarico.AggiungiServizi;
end;

procedure TWizInserimentoIncaricoForm.AggiungiStudentiExecute(Sender: TObject);
begin
  inherited;
  WizInserimentoIncarico.AggiungiStudenti;
end;

procedure TWizInserimentoIncaricoForm.AfterShowForm(const Modal: Boolean);
begin
  inherited;

  if Modal then
    if ModalResult = mrOk then
    begin
      WizInserimentoIncarico.StampaIncarico;
      WizInserimentoIncarico.InviaMailOccasionali;
      WizInserimentoIncarico.InviaMailNotifica;
    end;
end;

procedure TWizInserimentoIncaricoForm.WizardButtonClick(Sender: TObject; AKind: TdxWizardControlButtonKind; var AHandled: Boolean);
begin
  inherited;

  AHandled := False;

  if AKind = wcbkNext then
    if Wizard.ActivePage = pageWelcome then
    begin
      WizInserimentoIncarico.Incarico.CheckBrowseMode;

      pageCorsi.PageVisible := WizInserimentoIncarico.CorsiVisible;
      pagePIP.PageVisible := WizInserimentoIncarico.PipVisible or (Stato = InserimentoDaPIP);
    end;
end;

procedure TWizInserimentoIncaricoForm.WizardPageChanging(Sender: TObject; ANewPage: TdxWizardControlCustomPage; var AAllow: Boolean);
var
  isNext: Boolean;
begin
  inherited;

  if not Assigned(WizInserimentoIncarico) then
    exit;

  isNext := Wizard.ActivePage.PageIndex < ANewPage.PageIndex;

  if isNext then //
  begin

    // post dell'incarico
    if Wizard.ActivePage = pageWelcome then
    begin
      WizInserimentoIncarico.Incarico.CheckBrowseMode;

      pageCorsi.PageVisible := WizInserimentoIncarico.CorsiVisible;
      pagePIP.PageVisible := WizInserimentoIncarico.PipVisible or (Stato = InserimentoDaPIP);
      WizInserimentoIncarico.VerificaIncarico(False);
    end
    else
      if Wizard.ActivePage = pageCorsi then
      begin
        WizInserimentoIncarico.Corsi.CheckBrowseMode;
        WizInserimentoIncarico.VerificaIncarico(True);
      end;

    ANewPage := NextVisiblePage;

    // if ANewPage = pagePIP then
    // begin
    // // post dell'incarico
    // if Wizard.ActivePage = pageWelcome then
    // WizInserimentoIncarico.Incarico.CheckBrowseMode;
    //
    // /// //////////////////////////////////////////////
    // /// test per PIP
    // if not WizInserimentoIncarico.PipVisible then
    // begin
    // if Wizard.ActivePage = pageWelcome then
    // ANewPage := pageFinish
    // else
    // if Wizard.ActivePage = pageFinish then
    // ANewPage := pageWelcome;
    // end;
    // end;

    if ANewPage = pageFinish then
      memoRiepilogo.Lines.Text := WizInserimentoIncarico.GetRiepilogo;
  end;
end;

procedure TWizInserimentoIncaricoForm.WizardPageChanged(Sender: TObject);
begin
  inherited;

  if Wizard.ActivePage = pagePIP then
    if Stato = InserimentoDaPIP then
      if IdPianoPersonalizzato <> -1 then
        WizInserimentoIncarico.AggiungiPIP(IdPianoPersonalizzato, IdentificativoPIP);
end;

procedure TWizInserimentoIncaricoForm.cardCorsiAfterCreateControls(Sender: TObject);
var
  zControl: TzControl;
begin
  inherited;

  zControl := cardCorsi.zControls.Find('ID_CORSO');

  if Assigned(zControl) then
    if Assigned(zControl.lkDataSet) then
      WizInserimentoIncarico.InitLookupCorso(zControl.lkDataSet);
end;

procedure TWizInserimentoIncaricoForm.cardIncaricoAfterCreateControls(Sender: TObject);
begin
  inherited;
  // cardIncarico.HideField('NOTE');

  // Mantis #183 - 2026-10-01: la motivazione si vede solo dove e' attiva
  // (CONFIG.INCARICHI_MOTIVAZIONE_VISIBILE). FORCE_HIDDEN di OVERRIDES non e'
  // applicato dalle schede, quindi si nasconde da qui.
  if not WizInserimentoIncarico.MotivazioneVisibile then
    cardIncarico.HideField('MOTIVAZIONE');
end;

procedure TWizInserimentoIncaricoForm.CreaNuovoCorsoExecute(Sender: TObject);
begin
  inherited;

  if WizInserimentoIncarico.CreaNuovoCorso <> -1 then
    cardCorsi.ReopenLookupDataSet('ID_CORSO', True);
end;

procedure TWizInserimentoIncaricoForm.cardIncaricoAfterCreateDbControl(Sender: TObject; const FieldName: string; cxCustomEdit: TcxCustomEdit);
var
  combo: TcxDBExtLookupComboBox;
  btn: TcxEditButton;
begin
  inherited;

  if sameText(FieldName, 'ID_PROGETTO') then
    if cxCustomEdit is TcxDBExtLookupComboBox then
    begin
      combo := TcxDBExtLookupComboBox(cxCustomEdit);
      btn := combo.Properties.Buttons.Add;
      btn.Action := NuovoProgetto;
      btn.Kind := bkGlyph;
      dx.GetBitmap(btn.Glyph, dx.MicroImages, NuovoProgetto.ImageIndex);
    end;
end;

procedure TWizInserimentoIncaricoForm.NuovoProgettoExecute(Sender: TObject);
var
  IdProgetto: integer;
begin
  inherited;

  IdProgetto := WizInserimentoIncarico.InserisciNuovoProgetto;

  if IdProgetto <> -1 then
  begin
    WizInserimentoIncarico.Incarico.CheckEditMode;
    WizInserimentoIncarico.Incarico.FieldByName('ID_PROGETTO').asInteger := IdProgetto;
    cardIncarico.ReopenLookupDataSet('ID_PROGETTO', True);
    abort;
  end;
end;

end.

  zDbCard
