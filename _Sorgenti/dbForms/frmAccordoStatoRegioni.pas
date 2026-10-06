unit frmAccordoStatoRegioni;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  Vcl.ActnList,
  Vcl.StdActns,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  dxFileActions,
  cxMemo,
  zDbView,
  zDbCard,
  BaseFrm;

type
  TNotaCorso = (NOTE_ANALISI_FABBISOGNI, NOTE_OBIETTIVI_E_RISULTATI_ATTESI, NOTE_ARTICOLAZIONE_DIDATTICA, NOTE_METODOLOGIA, NOTE_MATERIALI, NOTE_MONITORAGGIO, DESCRIZIONE_PROVA_VERIFICA, NOTE_VERBALE);

  TFormAccordoStatoRegioni = class(TBaseForm)
    ActionList: TActionList;
    NuovoIncarico: TAction;
    ImportaStudenti: TAction;
    ImportaFileIscrizioni: TdxFileOpen;
    ImportNoteAnalisiFabbisogni: TAction;
    ImportNoteObiettiviRisultatiAttesi: TAction;
    ImportNoteArticolazioneDidattica: TAction;
    ImportNoteMetodologia: TAction;
    ImportNoteMateriali: TAction;
    ImportNoteMonitoraggio: TAction;
    ImportDescrizioneProvaVerifica: TAction;
    ImportNoteVerbale: TAction;
    ImportaAnagrafe: TAction;
    procedure ImportaAnagrafeExecute(Sender: TObject);
    procedure ImportaFileIscrizioniAccept(Sender: TObject);
    procedure ImportaStudentiExecute(Sender: TObject);
    procedure ImportDescrizioneProvaVerificaExecute(Sender: TObject);
    procedure ImportNoteAnalisiFabbisogniExecute(Sender: TObject);
    procedure ImportNoteArticolazioneDidatticaExecute(Sender: TObject);
    procedure ImportNoteMaterialiExecute(Sender: TObject);
    procedure ImportNoteMetodologiaExecute(Sender: TObject);
    procedure ImportNoteMonitoraggioExecute(Sender: TObject);
    procedure ImportNoteObiettiviRisultatiAttesiExecute(Sender: TObject);
    procedure ImportNoteVerbaleExecute(Sender: TObject);
    procedure NuovoIncaricoExecute(Sender: TObject);
  private
    procedure CardAfterCreateControls(Sender: TObject);
    procedure doImportNota(Nota: TNotaCorso);
    function GetAzione(Nota: TNotaCorso): TAction;
    function GetLookupDataSet(Nota: TNotaCorso): string;
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetupComponent(const DataSetName: String; Component: TComponent); override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormAccordoStatoRegioni: TFormAccordoStatoRegioni;

implementation

uses
  System.StrUtils,
  zDm_Images,
  dmAccordoStatoRegioni;

{$R *.dfm}

procedure TFormAccordoStatoRegioni.CreateDataModule;
begin
  inherited;
  CreateDM(TAccordoStatoRegioni, AccordoStatoRegioni);
end;

procedure TFormAccordoStatoRegioni.DestroyDataModule;
begin
  inherited;
  FreeAndNil(AccordoStatoRegioni);
end;

constructor TFormAccordoStatoRegioni.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'AccordoStatoRegioni';
  Caption := 'AccordoStatoRegioni';
end;

procedure TFormAccordoStatoRegioni.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
// view: TzDbView;
// begin
// inherited;
//
// if Component is TzDbView then
// begin
// view := TzDbView(Component);
//
// if SameText(DataSetName, 'Progetti_Asr_Sicurezza') then
// begin
// Tools.AddFiltroEnte(view, AccordoStatoRegioni.GetDataSet(DataSetName));
// Tools.AddFiltroAnnoFormativo(view, AccordoStatoRegioni.GetDataSet(DataSetName));
//
// view.OnCardAfterCreateControls := CardAfterCreateControls;
// end
// else
// if SameText(DataSetName, 'Progetti_Asr_Sicurezza_Incarichi_Elenco') then
// begin
// view.AddAction(NuovoIncarico, zDmImages.ImageList16).HideInCard;
// view.InitToolActions;
// end
// else
// if SameText(DataSetName, 'Partecipanti') then
// begin
// view.AddAction(ImportaStudenti, zDmImages.ImageList16);
// view.AddAction(ImportaFileIscrizioni, zDmImages.ImageList16);
//
// view.InitToolActions;
// end;
// end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent }
end;

procedure TFormAccordoStatoRegioni.NuovoIncaricoExecute(Sender: TObject);
begin
  inherited;
  AccordoStatoRegioni.NuovoIncarico;
end;

procedure TFormAccordoStatoRegioni.ImportaFileIscrizioniAccept(Sender: TObject);
begin
  inherited;
  AccordoStatoRegioni.ImportaFileIscrizioni(ImportaFileIscrizioni.Dialog.FileName);
end;

procedure TFormAccordoStatoRegioni.ImportaStudentiExecute(Sender: TObject);
begin
  inherited;
  AccordoStatoRegioni.ImportaStudenti;
end;

function TFormAccordoStatoRegioni.GetAzione(Nota: TNotaCorso): TAction;
begin
  Result := nil;

  case Nota of
    NOTE_ANALISI_FABBISOGNI:
      Result := ImportNoteAnalisiFabbisogni;
    NOTE_OBIETTIVI_E_RISULTATI_ATTESI:
      Result := ImportNoteObiettiviRisultatiAttesi;
    NOTE_ARTICOLAZIONE_DIDATTICA:
      Result := ImportNoteArticolazioneDidattica;
    NOTE_METODOLOGIA:
      Result := ImportNoteMetodologia;
    NOTE_MATERIALI:
      Result := ImportNoteMateriali;
    NOTE_MONITORAGGIO:
      Result := ImportNoteMonitoraggio;
    DESCRIZIONE_PROVA_VERIFICA:
      Result := ImportDescrizioneProvaVerifica;
    NOTE_VERBALE:
      Result := ImportNoteVerbale;
  end;
end;

procedure TFormAccordoStatoRegioni.CardAfterCreateControls(Sender: TObject);
  procedure AddCustomAction(card: TzDbCard; const FieldName: string; Action: TAction);
  var
    ctrl: TzControl;
  begin
    ctrl := TzDbCard(Sender).zControls.Find(FieldName);
    ctrl.AddCustomAction(Action);
  end;

var
  card: TzDbCard;
begin
  card := TzDbCard(Sender);

  AddCustomAction(card, 'NOTE_ANALISI_FABBISOGNI', ImportNoteAnalisiFabbisogni);
  AddCustomAction(card, 'NOTE_OBIETTIVI_E_RISULTATI_ATTESI', ImportNoteObiettiviRisultatiAttesi);
  AddCustomAction(card, 'NOTE_ARTICOLAZIONE_DIDATTICA', ImportNoteArticolazioneDidattica);
  AddCustomAction(card, 'NOTE_METODOLOGIA', ImportNoteMetodologia);
  AddCustomAction(card, 'NOTE_MATERIALI', ImportNoteMateriali);
  AddCustomAction(card, 'NOTE_MONITORAGGIO', ImportNoteMonitoraggio);
  AddCustomAction(card, 'DESCRIZIONE_PROVA_VERIFICA', ImportDescrizioneProvaVerifica);
  AddCustomAction(card, 'NOTE_VERBALE', ImportNoteVerbale);
end;

procedure TFormAccordoStatoRegioni.ImportNoteAnalisiFabbisogniExecute(Sender: TObject);
begin
  inherited;
  doImportNota(NOTE_ANALISI_FABBISOGNI);
end;

procedure TFormAccordoStatoRegioni.ImportNoteObiettiviRisultatiAttesiExecute(Sender: TObject);
begin
  inherited;
  doImportNota(NOTE_OBIETTIVI_E_RISULTATI_ATTESI);
end;

procedure TFormAccordoStatoRegioni.ImportNoteArticolazioneDidatticaExecute(Sender: TObject);
begin
  inherited;
  doImportNota(NOTE_ARTICOLAZIONE_DIDATTICA);
end;

procedure TFormAccordoStatoRegioni.ImportNoteMetodologiaExecute(Sender: TObject);
begin
  inherited;
  doImportNota(NOTE_METODOLOGIA);
end;

procedure TFormAccordoStatoRegioni.ImportNoteMaterialiExecute(Sender: TObject);
begin
  inherited;
  doImportNota(NOTE_MATERIALI);
end;

procedure TFormAccordoStatoRegioni.ImportNoteMonitoraggioExecute(Sender: TObject);
begin
  inherited;
  doImportNota(NOTE_MONITORAGGIO);
end;

procedure TFormAccordoStatoRegioni.ImportDescrizioneProvaVerificaExecute(Sender: TObject);
begin
  inherited;
  doImportNota(DESCRIZIONE_PROVA_VERIFICA);
end;

procedure TFormAccordoStatoRegioni.ImportNoteVerbaleExecute(Sender: TObject);
begin
  inherited;
  doImportNota(NOTE_VERBALE);
end;

function TFormAccordoStatoRegioni.GetLookupDataSet(Nota: TNotaCorso): string;
begin
  Result := '';

  case Nota of
    NOTE_ANALISI_FABBISOGNI:
      Result := 'lkZZ_ASR_NOTE_ANALISI_FABBISOGNI';
    NOTE_OBIETTIVI_E_RISULTATI_ATTESI:
      Result := 'lkZZ_ASR_NOTE_OBIETTIVI_E_RISULTATI_ATTESI';
    NOTE_ARTICOLAZIONE_DIDATTICA:
      Result := 'lkZZ_ASR_NOTE_ARTICOLAZIONE_DIDATTICA';
    NOTE_METODOLOGIA:
      Result := 'lkZZ_ASR_NOTE_METODOLOGIA';
    NOTE_MATERIALI:
      Result := 'lkZZ_ASR_NOTE_MATERIALI';
    NOTE_MONITORAGGIO:
      Result := 'lkZZ_ASR_NOTE_MONITORAGGIO';
    DESCRIZIONE_PROVA_VERIFICA:
      Result := 'lkZZ_ASR_DESCRIZIONI_PROVE_VERIFICA';
    NOTE_VERBALE:
      Result := 'lkZZ_ASR_NOTE_VERBALE';
  end;
end;

procedure TFormAccordoStatoRegioni.doImportNota(Nota: TNotaCorso);
var
  memo: TcxMemo;
  azione: TAction;
  LookupDataSet: string;
begin
  azione := GetAzione(Nota);
  memo := TcxMemo(azione.Tag);
  LookupDataSet := GetLookupDataSet(Nota);

  AccordoStatoRegioni.ImportNote(LookupDataSet, memo);
end;

procedure TFormAccordoStatoRegioni.ImportaAnagrafeExecute(Sender: TObject);
begin
  inherited;
  AccordoStatoRegioni.ImportaAnagrafe;
end;

procedure TFormAccordoStatoRegioni.SetupComponent(const DataSetName: String; Component: TComponent);
var
  view: TzDbView;
begin
  inherited;

  if Component is TzDbView then
  begin
    view := TzDbView(Component);

    if SameText(DataSetName, 'Progetti_Asr_Sicurezza') then
    begin
      view.OnCardAfterCreateControls := CardAfterCreateControls;
    end;
  end;

end;

end.
