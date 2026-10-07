unit frmRisorse;

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
  System.Actions,
  Vcl.ActnList,
  dxBar,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  zFileViewer,
  zFormController,
  dxLayoutcxEditAdapters,
  dxLayoutContainer,
  cxSpinEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  dxLayoutControl,
  zSystem,
  zDbView,
  zDbCard,
  cxBarEditItem,
  cxImageComboBox,
  cxCheckBox,
  cxCheckComboBox,
  cxDBEdit,
  cxDBCheckComboBox,
  Vcl.StdActns,
  dxFileActions,
  cxDBExtLookupComboBox,
  dxUIAClasses;

type
  TFormRisorse = class(TBaseForm)
    layoutCP1: TdxLayoutControl;
    edMese: TcxComboBox;
    edProgetto: TcxExtLookupComboBox;
    edAnno: TcxSpinEdit;
    layoutCP1Group_Root: TdxLayoutGroup;
    dxLayoutItemMese: TdxLayoutItem;
    dxLayoutItemProgetto: TdxLayoutItem;
    dxLayoutItemAnno: TdxLayoutItem;
    InserimentoIncarico: TAction;
    CreaUtenteSistema: TAction;
    RettificaIndirizzoRisorse: TAction;
    DuplicaIncarico: TAction;
    ValidataRilevamentoOre: TAction;
    AnnullaValidazione: TAction;
    InviaMail: TAction;
    RicalcolaTotaliOreAttribuite: TAction;
    RicalcolaOreRecupero: TAction;
    RettificaIncarico: TAction;
    GeneraCollegato: TAction;
    InserimentoIncaricoDaOrario: TAction;
    GeneraRilevamentiOre: TAction;
    ActionList: TActionList;
    GeneraTutorAziendale: TAction;
    dxLayoutEmptySpaceItemCP1: TdxLayoutEmptySpaceItem;
    dxLayoutSplitterItemCP1: TdxLayoutSplitterItem;
    GeneraIncarichiMancantiDaRilevamenti: TAction;
    PersonaleImport: TdxFileOpen;
    PersonaleElaboraImport: TAction;
    AziendeImport: TdxFileOpen;
    AziendeElaboraImport: TAction;
    SpostaAltroProgetto: TAction;
    Supplenza: TAction;
    dxLayoutGroup2: TdxLayoutGroup;
    dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem;
    CreaUtenteSistemaTutor: TAction;
    EliminaIncarico: TAction;
    Integrazione: TAction;
    RettificaProtocollo: TAction;
    AnnullaAttivazioneIncarico: TAction;
    CreaUtenteDominio: TAction;
    ValidaOrePerSettore: TAction;
    AnnullaValidazionePerSettore: TAction;
    RilevamentoOreFatturate: TAction;
    RilevamentoOreTogliFatturate: TAction;
    GeneraAutorizzazionePagamentoXRisorsa: TAction;
    procedure AnnullaAttivazioneIncaricoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edProgettoPropertiesEditValueChanged(Sender: TObject);
    procedure edAnnoPropertiesChange(Sender: TObject);
    procedure edMesePropertiesChange(Sender: TObject);

    procedure AnnullaValidazioneExecute(Sender: TObject);
    procedure AnnullaValidazionePerSettoreExecute(Sender: TObject);
    procedure AziendeElaboraImportExecute(Sender: TObject);
    procedure AziendeImportAccept(Sender: TObject);
    procedure CreaUtenteDominioExecute(Sender: TObject);
    procedure CreaUtenteSistemaExecute(Sender: TObject);
    procedure CreaUtenteSistemaTutorExecute(Sender: TObject);
    procedure DuplicaIncaricoExecute(Sender: TObject);
    procedure EliminaIncaricoExecute(Sender: TObject);
    procedure EliminaIncaricoUpdate(Sender: TObject);
    procedure GeneraAutorizzazionePagamentoXRisorsaExecute(Sender: TObject);
    procedure GeneraCollegatoExecute(Sender: TObject);
    procedure GeneraIncarichiMancantiDaRilevamentiExecute(Sender: TObject);
    procedure GeneraRilevamentiOreExecute(Sender: TObject);
    procedure InserimentoIncaricoDaOrarioExecute(Sender: TObject);
    procedure InserimentoIncaricoExecute(Sender: TObject);
    procedure IntegrazioneExecute(Sender: TObject);
    procedure InviaMailExecute(Sender: TObject);
    procedure PersonaleElaboraImportExecute(Sender: TObject);
    procedure RettificaIncaricoExecute(Sender: TObject);
    procedure RettificaIndirizzoRisorseExecute(Sender: TObject);
    procedure RicalcolaOreRecuperoExecute(Sender: TObject);
    procedure RicalcolaTotaliOreAttribuiteExecute(Sender: TObject);
    procedure PersonaleImportAccept(Sender: TObject);
    procedure RettificaProtocolloExecute(Sender: TObject);
    procedure RilevamentoOreFatturateExecute(Sender: TObject);
    procedure RilevamentoOreTogliFatturateExecute(Sender: TObject);
    procedure SpostaAltroProgettoExecute(Sender: TObject);
    procedure SupplenzaExecute(Sender: TObject);
    procedure ValidaOrePerSettoreExecute(Sender: TObject);
    procedure ValidataRilevamentoOreExecute(Sender: TObject);
    procedure edProgettoPropertiesInitPopup(Sender: TObject);
  private
    procedure edProgettoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure RisorseShowCard(Sender: TObject; Inserting: Boolean);
  private
  private
    DisableCP1: Boolean;
  public
    procedure Stampa; override;
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
    procedure SetPK(const Value: Variant); override;
    procedure AfterCreateControls; override;
    procedure OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent); override;
    procedure SetupComponent(const DataSetName: String; Component: TComponent); override;
    procedure DatasetAssigned(const DataSetName: String; Component: TComponent); override;
  end;

var
  FormRisorse: TFormRisorse;

implementation

uses
  System.Generics.Collections,
  zHyperLinks,
  Files.Lib,
  dmRisorse,
  ConfigModule,
  zBaseLib,
  zDm_Images,
  zdx,
  zFbDataSet,
   
  cxFilter,
  System.StrUtils,
  zRestrictions.Types,
  Gesty.Authorizations;

{$R *.dfm}

procedure TFormRisorse.CreateDataModule;
begin
  inherited;
  CreateDM(TRisorse, Risorse);

  Risorse.GetSelectedDataSetNameFunc := function: String
    begin
      result := SelectedDataSetName
    end
end;

procedure TFormRisorse.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Risorse);
end;

procedure TFormRisorse.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  inherited;
  ReportGroup := 'Risorse';
  Caption := 'Risorse';

  layoutCP1.Visible := False;
  layoutCP1.Parent := Self;

  RestrictionManager.AddDefaultLevel(SpostaAltroProgetto, TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(RettificaProtocollo, TAccessLevel.alNone);

  DisableCP1 := True;
  try
    for I := 1 to 12 do
      edMese.Properties.Items.Add(FormatSettings.LongMonthNames[I]);

    edMese.ItemIndex := Risorse.CP1.Mese - 1;
    edAnno.Value := Risorse.CP1.Anno;

    dx.InitLookup('', edProgetto, Risorse.lkProgetti, Risorse.lkProgettiSrc, 'ID_PROGETTO', 'DENOMINAZIONE_PROGETTO;ANNO_FORMATIVO,ID_PROGETTO');
    edProgetto.EditValue := null; // altrimenti � 0
    edProgetto.Properties.OnButtonClick := edProgettoPropertiesButtonClick;
  finally
    DisableCP1 := False;
  end;
end;

procedure TFormRisorse.OLD_AfterCreateComponent(const DataSetName: String; Component: TComponent);
// var
  // view: TzDbView;
  // card: TzDbCard;
// begin
  // inherited;
// 
  // if Component is TzDbCard then
  // begin
    // card := TzDbCard(Component);
// 
    // if SameText(DataSetName, 'Personale_Ore_Recupero') then
    // begin
      // card.AddAction(RicalcolaOreRecupero, zDmImages.ImageList16);
      // card.InitToolActions;
// 
      // Tools.AddFiltroAnnoFormativo(card, Risorse.GetDataSet(DataSetName));
    // end;
  // end;
// 
  // if Component is TzDbView then
  // begin
    // view := TzDbView(Component);
// 
    // if SameText(DataSetName, 'Risorse') then
    // begin
      // view.OnShowCard := RisorseShowCard;
      // view.AddAction(RettificaIndirizzoRisorse, zDmImages.ImageList16);
      // view.AddAction(InviaMail, zDmImages.ImageList16);
      // view.AddAction(CreaUtenteSistema, zDmImages.ImageList16);
      // view.AddAction(CreaUtenteDominio, zDmImages.ImageList16);
      // view.InitActions;
    // end
    // else
      // if SameText(DataSetName, 'Risorse_Incarichi') then
      // begin
        // view.AddAction(DuplicaIncarico, zDmImages.ImageList16).HideInCard;
        // view.AddAction(InserimentoIncarico, zDmImages.ImageList16).HideInCard;
        // view.AddAction(Supplenza, zDmImages.ImageList16).HideInCard;
        // view.AddAction(RettificaIncarico, zDmImages.ImageList16).HideInCard;
        // view.AddAction(GeneraCollegato, zDmImages.ImageList16).HideInCard;
        // view.AddAction(SpostaAltroProgetto, zDmImages.ImageList16).HideInView;
        // view.AddAction(Integrazione, zDmImages.ImageList16).HideInView;
        // view.AddAction(EliminaIncarico, zDmImages.ImageList16);
        // view.AddAction(RettificaProtocollo, zDmImages.ImageList16);
        // view.AddAction(AnnullaAttivazioneIncarico, zDmImages.ImageList16).HideInView;
        // view.InitActions;
// 
        // Tools.AddFiltroAnnoSolare(view, Risorse.GetDataSet(DataSetName), ivNull);
        // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
        // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
      // end
      // else
        // if SameText(DataSetName, 'Contratti') then
        // begin
          // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
          // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
        // end
        // else
          // if SameText(DataSetName, 'Incarichi_Di_Massima') then
          // begin
            // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
            // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
          // end
          // else
            // if SameText(DataSetName, 'Risorse_Rilevamento_Ore') then
            // begin
              // Tools.AddFiltroMese(view, Risorse.GetDataSet(DataSetName));
              // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
              // Tools.AddFiltroAnnoSolare(view, Risorse.GetDataSet(DataSetName), ivNull);
            // end
            // else
              // if SameText(DataSetName, 'RilevamentiControlloPeriodico') then
              // begin
                // view.AddAction(ValidataRilevamentoOre, zDmImages.ImageList16);
                // view.AddAction(AnnullaValidazione, zDmImages.ImageList16);
// 
                // view.InitActions;
              // end
              // else
                // if SameText(DataSetName, 'OreFatturate') then
                // begin
                  // Tools.AddFiltroBoolean(view, Risorse.GetDataSet(DataSetName), 'FATTURATA', 'Fatturata', '', '');
                  // Tools.AddFiltroMese(view, Risorse.GetDataSet(DataSetName));
                  // Tools.AddFiltroAnnoSolare(view, Risorse.GetDataSet(DataSetName), ivDefault);
// 
                  // view.AddAction(RilevamentoOreFatturate, zDmImages.ImageList16);
                  // view.AddAction(RilevamentoOreTogliFatturate, zDmImages.ImageList16);
                  // view.InitActions;
                // end
                /// /////////////////////
                // else
                  // if SameText(DataSetName, 'Personale_Ore_Effettuate_Per_Tipologia') then
                  // begin
                    // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                    // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
                    // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                  // end
                  // else
                    // if SameText(DataSetName, 'Risorse_Totali_Ore') then
                    // begin
                      // view.AddAction(RicalcolaTotaliOreAttribuite, zDmImages.ImageList16);
                      // view.InitActions;
// 
                      // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                    // end
                    // else
                      // if SameText(DataSetName, 'Personale_Ore_Assegnate_Per_Tipologia') then
                      // begin
                        // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
                        // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                      // end
                      // else
                        // if SameText(DataSetName, 'Risorse_Totali_Ore_Elenco') then
                        // begin
                          // view.AddAction(RicalcolaTotaliOreAttribuite, zDmImages.ImageList16);
                          // view.InitActions;
// 
                          // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                        // end
                        // else
                          // if SameText(DataSetName, 'Personale_Ore_Recupero') then
                          // begin
                            // view.AddAction(RicalcolaOreRecupero, zDmImages.ImageList16);
                            // view.InitActions;
// 
                            // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                          // end
                          // else
                            // if SameText(DataSetName, 'Personale_Ore_Recupero_Elenco') then
                            // begin
                              // view.AddAction(RicalcolaOreRecupero, zDmImages.ImageList16);
                              // view.InitActions;
// 
                              // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                            // end
                            // else
                              // if SameText(DataSetName, 'Elenco_Fornitori_Con_Incarichi') then
                              // begin
                                // view.AddAction(RicalcolaOreRecupero, zDmImages.ImageList16);
                                // view.InitActions;
// 
                                // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                                // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
                              // end
                              // else
                                // if SameText(DataSetName, 'RegistroSenzaIncarichi') then
                                // begin
                                  // chiamare proc ORARIO_GENERA_RILEVAMENTO
                                  // view.AddAction(InserimentoIncaricoDaOrario, zDmImages.ImageList16);
                                  // view.AddAction(GeneraRilevamentiOre, zDmImages.ImageList16);
                                  // view.InitActions;
                                  // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                                  // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
                                // end
                                // else
                                  // if SameText(DataSetName, 'Riepilogo_Ore_Docenza') then
                                  // begin
                                    // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                                    // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
                                  // end
                                  // else
                                    // if SameText(DataSetName, 'ElencoIncarichi') then
                                    // begin
                                      // Tools.AddFiltroPickList('INCARICO_INTERNO_ESTERNO', view, Risorse.GetDataSet(DataSetName), 'INCARICO_INTERNO_ESTERNO', 'Tipo Incarico', 'tipo incarico', null, True, 'Tutti', 100);
// 
                                      // Tools.AddFiltroAnnoSolare(view, Risorse.GetDataSet(DataSetName), ivNull);
                                      // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                                      // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
                                    // end
                                    // else
                                      // if SameText(DataSetName, 'Incarichi_A_Occasionali') then
                                      // begin
                                        // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                                        // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
                                      // end
                                      // else
                                        // if SameText(DataSetName, 'Aziende_Contatti') then
                                        // begin
                                        // view.AddAction(CreaUtenteSistemaTutor, zDmImages.ImageList16);
                                        // view.InitActions;
                                        // end
                                        // else
                                        // if SameText(DataSetName, 'RilevamentiSenzaIncarico') then
                                        // begin
                                        // view.AddAction(GeneraIncarichiMancantiDaRilevamenti, zDmImages.ImageList16);
                                        // view.InitActions;
                                        // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                                        // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
                                        // end
                                        // else
                                        // if SameText(DataSetName, 'PresenzeMancanti') then
                                        // begin
                                        // Tools.AddFiltroMese(view, Risorse.GetDataSet(DataSetName));
                                        // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                                        // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
                                        // end
                                        // else
                                        // if SameText(DataSetName, 'Progetti_Piani_Pers_Elenco') then
                                        // begin
                                        // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                                        // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
                                        // end
                                        // else
                                        // if SameText(DataSetName, 'Personale_Import_Files') then
                                        // begin
                                        // view.AddAction(PersonaleImport, zDmImages.ImageList16);
                                        // view.AddAction(PersonaleElaboraImport, zDmImages.ImageList16);
                                        // view.InitActions;
                                        // end
                                        // else
                                        // if SameText(DataSetName, 'Aziende_Import_Files') then
                                        // begin
                                        // view.AddAction(AziendeImport, zDmImages.ImageList16);
                                        // view.AddAction(AziendeElaboraImport, zDmImages.ImageList16);
                                        // view.InitActions;
                                        // end
                                        // else
                                        // if SameText(DataSetName, 'Personale_Presenze') then
                                        // begin
                                        // Tools.AddFiltroMese(view, Risorse.GetDataSet(DataSetName));
                                        // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                                        // end
                                        // else
                                        // if SameText(DataSetName, 'Contratti_Elenco') then
                                        // begin
                                        // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                                        // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
                                        // end
                                        // else
                                        // if SameText(DataSetName, 'Incarichi_Di_Massima_Elenco') then
                                        // begin
                                        // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                                        // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
                                        // end
                                        // else
                                        // if SameText(DataSetName, 'RilevamentiPerSettoreAziendale') then
                                        // begin
                                        // view.AddAction(ValidaOrePerSettore, zDmImages.ImageList16);
                                        // view.AddAction(AnnullaValidazionePerSettore, zDmImages.ImageList16);
                                        // view.InitActions;
// 
                                        // Tools.AddFiltroMese(view, Risorse.GetDataSet(DataSetName));
                                        // Tools.AddFiltroAnnoSolare(view, Risorse.GetDataSet(DataSetName));
                                        // Tools.AddFiltroSettoreAziendale(view, Risorse.GetDataSet(DataSetName));
                                        // end
                                        // else
                                        // if SameText(DataSetName, 'Autorizzazioni_Pagamento_Elenco') then
                                        // begin
                                        // Da Vedere
                                        // view.AddAction(GeneraAutorizzazionePagamento, zDmImages.ImageList16);
                                        // view.InitActions;
                                        // Tools.AddFiltroMese(view, Risorse.GetDataSet(DataSetName), ivNull);
                                        // Tools.AddFiltroAnnoSolare(view, Risorse.GetDataSet(DataSetName), ivNull);
                                        // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
                                        // end
                                        // else
                                        // if SameText(DataSetName, 'Risorse_Autorizzazioni_Pagamento') then
                                        // begin
                                        // view.AddAction(GeneraAutorizzazionePagamentoXRisorsa, zDmImages.ImageList16);
                                        // view.InitActions;
// 
                                        // Tools.AddFiltroMese(view, Risorse.GetDataSet(DataSetName), ivNull);
                                        // Tools.AddFiltroAnnoSolare(view, Risorse.GetDataSet(DataSetName), ivNull);
                                        // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName));
                                        // end
                                        // else
                                        // if SameText(DataSetName, 'Storico_Ore_Rilevate') then
                                        // begin
                                        // Tools.AddFiltroMese(view, Risorse.GetDataSet(DataSetName));
                                        // Tools.AddFiltroAnnoFormativo(view, Risorse.GetDataSet(DataSetName));
                                        // Tools.AddFiltroAnnoSolare(view, Risorse.GetDataSet(DataSetName), ivNull);
                                        // Tools.AddFiltroEnte(view, Risorse.GetDataSet(DataSetName), ivNull);
                                        // end;
  // end;
// end;
begin
  { TODO : Eliminare OLD_AfterCreateComponent}
end;

procedure TFormRisorse.SetPK(const Value: Variant);
var
  view: TzDbView;
  idRisorsa: Integer;
begin
  inherited;
  //
  if pkMode then
  begin

    if pkField = 'ID_INCARICO' then
    begin

      idRisorsa := Risorse.GetRisorsaFromIncarico(pk);

      if idRisorsa = -1 then
        exit;

      SelectedDataSetName := 'Risorse_Incarichi';

      // punta alla risorsa corretta
      view := getView('Risorse');
      if Assigned(view) then
      begin
        view.ClearFilter(False);
        view.AddFilterCondition('ID_RISORSA', foEqual, idRisorsa);
      end;

      // filtra l'incarico. Nota: azzerare i filtri su anno/ente
      view := getView('Risorse_Incarichi');
      if Assigned(view) then
      begin
        view.ClearFilter(False);
        view.AddFilterCondition('ID_INCARICO', foEqual, pk);
      end;
    end
    else
      if pkField = 'ID_RISORSA' then
      begin
        SelectedDataSetName := 'Risorse_Incarichi';

        view := getView('Risorse');
        if Assigned(view) then
        begin
          view.ClearFilter(False);
          view.AddFilterCondition('ID_RISORSA', foEqual, pk);
        end;
      end
      else
        if IndexText(pkField, ['ID_PERSONALE', 'ID_DOCENTE', 'ID_RESPONSABILE', 'ID_RESPONSABILE_TIROCINI', 'ID_REFERENTE', 'ID_COORDINATORE', 'ID_TUTOR', 'ID_TUROR_PROGETTO', 'ID_ESTENSORE_RICHIESTA', 'ID_RESPONSABILE_RIUNIONE', 'ID_FORMATORE'])
          <> -1 then
        begin
          SelectedDataSetName := 'Personale_Presenze';

          view := getView('Risorse');
          if Assigned(view) then
          begin
            view.ClearFilter(False);
            view.AddFilterCondition('ID_RISORSA', foEqual, pk);
          end;
        end
        else
          if (pkField = 'ID_AZIENDA') or (pkField = 'ID_AZIENDA_OSPITANTE') then
          begin
            SelectedDataSetName := 'Aziende_Contatti';

            view := getView('Risorse');
            if Assigned(view) then
            begin
              view.ClearFilter(False);
              view.AddFilterCondition('ID_AZIENDA', foEqual, pk);
            end;
          end;
  end;
end;

procedure TFormRisorse.edAnnoPropertiesChange(Sender: TObject);
begin
  inherited;

  if DisableCP1 then
    exit;

  Risorse.CP1.Anno := trunc(edAnno.Value);
  Risorse.AggiornaControlloPeriodico;
end;

procedure TFormRisorse.edMesePropertiesChange(Sender: TObject);
begin
  inherited;

  if DisableCP1 then
    exit;

  Risorse.CP1.Mese := edMese.ItemIndex + 1;
  Risorse.AggiornaControlloPeriodico;
end;

procedure TFormRisorse.edProgettoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;
  if DisableCP1 then
    exit;

  if VarIsNull(edProgetto.EditValue) then
    Risorse.CP1.IdProgetto := -1
  else
    Risorse.CP1.IdProgetto := edProgetto.EditValue;

  Risorse.CP1.DescProgetto := edProgetto.EditText;
  Risorse.AggiornaControlloPeriodico;
end;

procedure TFormRisorse.edProgettoPropertiesInitPopup(Sender: TObject);
begin
  inherited;
  Risorse.lkProgetti.Active := True;
end;

procedure TFormRisorse.AfterCreateControls;
var
  ControlloPeriodico: TzDiagramDataSet;
begin
  inherited;

  // Mantis #128 - 2026-09-17: il pannello dei filtri va nel gruppo di layout del
  // dataset Controllo Periodico, che esiste solo se l'utente ha accesso al dataset.
  // Senza accesso la voce finiva alla radice del layout, visibile accanto a ogni
  // pagina della form (Elenco Incarichi schiacciato a meta' larghezza).
  ControlloPeriodico := Risorse.zDataModule.FindDataSet('RilevamentiControlloPeriodico');

  if Assigned(ControlloPeriodico) and (ControlloPeriodico.ActualAccessLevel <> TAccessLevel.alNone) then
    AddLayoutItem(layoutCP1, 'RilevamentiControlloPeriodico', False);
end;

procedure TFormRisorse.AnnullaValidazioneExecute(Sender: TObject);
var
  Ore: TList<Integer>;
  view: TzDbView;
begin
  inherited;

  view := getView('RilevamentiControlloPeriodico');

  Ore := TList<Integer>.Create;
  try
    view.GetSelectedRows('ID_RILEVAMENTO_ORE', Ore);
    Risorse.ValidaRilevamentiOre(Ore, False, 'RilevamentiControlloPeriodico');
  finally
    FreeAndNil(Ore);
  end;
end;

procedure TFormRisorse.CreaUtenteSistemaExecute(Sender: TObject);
begin
  inherited;
  Risorse.CreaUtente;
end;

procedure TFormRisorse.edProgettoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  id: Integer;
  Descrizione: string;
begin
  inherited;

  if AButtonIndex = 1 then
    if Risorse.LookupProgetto(id, Descrizione) then
    begin
      Risorse.CP1.IdProgetto := id;
      Risorse.CP1.DescProgetto := Descrizione;
      Risorse.AggiornaControlloPeriodico;

      if id <> -1 then
        edProgetto.SetValidatableEditValue(id)
      else
        edProgetto.EditValue := null;
    end;
end;

procedure TFormRisorse.InviaMailExecute(Sender: TObject);
begin
  inherited;
  Risorse.InviaMail;
end;

procedure TFormRisorse.RettificaIndirizzoRisorseExecute(Sender: TObject);
begin
  inherited;
  Risorse.RettificaIndirizzoRisorsa;
end;

procedure TFormRisorse.ValidataRilevamentoOreExecute(Sender: TObject);
var
  Ore: TList<Integer>;
  view: TzDbView;
begin
  inherited;

  view := getView('RilevamentiControlloPeriodico');

  Ore := TList<Integer>.Create;
  try
    view.GetSelectedRows('ID_RILEVAMENTO_ORE', Ore);
    Risorse.ValidaRilevamentiOre(Ore, True, 'RilevamentiControlloPeriodico');
  finally
    FreeAndNil(Ore);
  end;
end;

procedure TFormRisorse.GeneraCollegatoExecute(Sender: TObject);
begin
  inherited;
  Risorse.GeneraCollegato;
end;

procedure TFormRisorse.RettificaIncaricoExecute(Sender: TObject);
begin
  inherited;
  Risorse.RettificaIncarico;
end;

procedure TFormRisorse.RicalcolaOreRecuperoExecute(Sender: TObject);
begin
  inherited;
  Risorse.RicalcolaOreRecupero;
end;

procedure TFormRisorse.RicalcolaTotaliOreAttribuiteExecute(Sender: TObject);
begin
  inherited;
  Risorse.RicalcolaTotaliOreAttribuite;
end;

procedure TFormRisorse.InserimentoIncaricoExecute(Sender: TObject);
begin
  inherited;
  Risorse.InserimentoIncarico;
end;

procedure TFormRisorse.InserimentoIncaricoDaOrarioExecute(Sender: TObject);
begin
  inherited;
  Risorse.InserimentoIncaricoDaOrario;
end;

procedure TFormRisorse.DuplicaIncaricoExecute(Sender: TObject);
begin
  inherited;
  Risorse.DuplicaIncarico;
end;

procedure TFormRisorse.GeneraRilevamentiOreExecute(Sender: TObject);
var
  orari: TList<Integer>;
  view: TzDbView;
begin
  orari := TList<Integer>.Create;
  try
    view := getView('RegistroSenzaIncarichi');
    view.GetSelectedRows('ID_ORARIO', orari);
    Risorse.GeneraRilevamentiOre(orari);
  finally
    FreeAndNil(orari);
  end;
end;

procedure TFormRisorse.DatasetAssigned(const DataSetName: String; Component: TComponent);
var
  view: TzDbView;
begin
  inherited;

  if SameText(DataSetName, 'Incarichi_A_Occasionali') then
  begin
    view := getView('Incarichi_A_Occasionali');

    if Assigned(view) then
      view.AddFilterCondition('DATA_COMUNICAZIONE_ITL', foEqual, null);
  end;
end;

procedure TFormRisorse.GeneraIncarichiMancantiDaRilevamentiExecute(Sender: TObject);
begin
  inherited;
  Risorse.GeneraIncarichiMancantiDaRilevamenti;
end;

procedure TFormRisorse.RisorseShowCard(Sender: TObject; Inserting: Boolean);
var
  viewRisorse: TzDbView;
  viewInquadramento: TzDbView;
  idRisorsa: Integer;
begin
  idRisorsa := Risorse.EditaRisorsaCorrente(Inserting);

  if Inserting then
    if idRisorsa <> -1 then
    begin

      StartWait('Attendere...', True);
      try
        viewRisorse := getView('Risorse');
        viewRisorse.AddFilterCondition('ID_RISORSA', foEqual, idRisorsa);

        SelectedDataSetName := 'Risorse_Inquadramento';
      finally
        StopWait;
      end;

      viewInquadramento := getView('Risorse_Inquadramento');
      viewInquadramento.ShowRecord(True);
    end;
end;

procedure TFormRisorse.PersonaleImportAccept(Sender: TObject);
var
  id: Integer;
  view: TzDbView;
begin
  inherited;

  id := Risorse.PersonaleImportFile(PersonaleImport.Dialog.FileName);

  if id <> -1 then
  begin
    view := getView('Personale_Import_Files');

    view.AddFilterCondition('ID_PERSONALE_IMPORT_FILE', foEqual, id);

    view.ShowRecord(False);
  end;
end;

procedure TFormRisorse.PersonaleElaboraImportExecute(Sender: TObject);
begin
  inherited;
  Risorse.PersonaleElaboraImport;
end;

procedure TFormRisorse.AziendeImportAccept(Sender: TObject);
var
  id: Integer;
  view: TzDbView;
begin
  inherited;

  id := Risorse.AziendeImportFile(AziendeImport.Dialog.FileName);

  if id <> -1 then
  begin
    view := getView('Aziende_Import_Files');

    view.AddFilterCondition('ID_AZIENDE_IMPORT_FILE', foEqual, id);

    view.ShowRecord(False);
  end;
end;

procedure TFormRisorse.AziendeElaboraImportExecute(Sender: TObject);
begin
  inherited;
  Risorse.AziendeElaboraImport;
end;

procedure TFormRisorse.CreaUtenteSistemaTutorExecute(Sender: TObject);
begin
  inherited;
  Risorse.CreaUtenteTutor;
end;

procedure TFormRisorse.EliminaIncaricoExecute(Sender: TObject);
begin
  inherited;
  Risorse.ForzaEliminazioneIncarico;
end;

procedure TFormRisorse.EliminaIncaricoUpdate(Sender: TObject);
begin
  inherited;
  if Sender is TAction then
    if Assigned(Config) then
      if Config.zSystem.ZSecurity.LoggedIn then
        TAction(Sender).Visible := Config.zSystem.Authorizhed(Gesty_Authorizations.INCARICHI_FORZA_ELIMINAZIONE);
end;

procedure TFormRisorse.IntegrazioneExecute(Sender: TObject);
begin
  inherited;
  Risorse.Integrazione;
end;

procedure TFormRisorse.RettificaProtocolloExecute(Sender: TObject);
begin
  inherited;
  Risorse.RettificaProtocollo;
end;

procedure TFormRisorse.SpostaAltroProgettoExecute(Sender: TObject);
begin
  inherited;
  Risorse.SpostaAltroProgetto;
end;

procedure TFormRisorse.SupplenzaExecute(Sender: TObject);
begin
  inherited;
  Risorse.GeneraIncaricoSupplenza;
end;

// Mantis #183 - 2026-10-06: era AnnullaAutorizzazioneIncaricoExecute
procedure TFormRisorse.AnnullaAttivazioneIncaricoExecute(Sender: TObject);
begin
  inherited;
  Risorse.AnnullaAttivazioneIncarico;
end;

procedure TFormRisorse.CreaUtenteDominioExecute(Sender: TObject);
begin
  inherited;
  Risorse.CreaUtenteDominio;
end;

procedure TFormRisorse.ValidaOrePerSettoreExecute(Sender: TObject);
var
  Ore: TList<Integer>;
  view: TzDbView;
begin
  inherited;

  view := getView('RilevamentiPerSettoreAziendale');

  Ore := TList<Integer>.Create;
  try
    view.GetSelectedRows('ID_RILEVAMENTO_ORE', Ore);
    Risorse.ValidaRilevamentiOre(Ore, True, 'RilevamentiPerSettoreAziendale');
  finally
    FreeAndNil(Ore);
  end;
end;

procedure TFormRisorse.AnnullaValidazionePerSettoreExecute(Sender: TObject);
var
  Ore: TList<Integer>;
  view: TzDbView;
begin
  inherited;

  view := getView('RilevamentiPerSettoreAziendale');

  Ore := TList<Integer>.Create;
  try
    view.GetSelectedRows('ID_RILEVAMENTO_ORE', Ore);
    Risorse.ValidaRilevamentiOre(Ore, False, 'RilevamentiPerSettoreAziendale');
  finally
    FreeAndNil(Ore);
  end;
end;

procedure TFormRisorse.RilevamentoOreFatturateExecute(Sender: TObject);
var
  Ore: TList<Integer>;
  view: TzDbView;
begin
  inherited;

  view := getView('OreFatturate');

  Ore := TList<Integer>.Create;
  try
    view.GetSelectedRows('ID_RILEVAMENTO_ORE', Ore);
    Risorse.RilevamentiOreSetFatturata(Ore, True);
  finally
    FreeAndNil(Ore);
  end;
end;

procedure TFormRisorse.RilevamentoOreTogliFatturateExecute(Sender: TObject);
var
  Ore: TList<Integer>;
  view: TzDbView;
begin
  inherited;

  view := getView('OreFatturate');

  Ore := TList<Integer>.Create;
  try
    view.GetSelectedRows('ID_RILEVAMENTO_ORE', Ore);
    Risorse.RilevamentiOreSetFatturata(Ore, False);
  finally
    FreeAndNil(Ore);
  end;
end;

procedure TFormRisorse.Stampa;
var
  view: TzDbView;
begin

  if SameText(SelectedDataSetName, 'Risorse_Incarichi') then
  begin
    view := getView('Risorse_Incarichi');
    view.GetSelectedRows('ID_INCARICO', Risorse.RisorseIncarichiSelezionati);
  end;

  inherited;
  Risorse.RisorseIncarichiSelezionati.clear;
end;

procedure TFormRisorse.GeneraAutorizzazionePagamentoXRisorsaExecute(Sender: TObject);
begin
  inherited;
  Risorse.GeneraAutorizzazionePagamentoXRisorsa;
end;

procedure TFormRisorse.SetupComponent(const DataSetName: String; Component: TComponent);
var
  view: TzDbView;
begin
  inherited;

  if Component is TzDbView then
  begin
    view := TzDbView(Component);

    if SameText(DataSetName, 'Risorse') then
    begin
      view.OnShowCard := RisorseShowCard;
    end;
  end;
end;

initialization

HyperLinks.RegisterHandler('ID_INCARICO', TFormRisorse);

HyperLinks.RegisterHandler('ID_AZIENDA', TFormRisorse);
HyperLinks.RegisterHandler('ID_AZIENDA_OSPITANTE', TFormRisorse);

HyperLinks.RegisterHandler('ID_PERSONALE', TFormRisorse);
HyperLinks.RegisterHandler('ID_DOCENTE', TFormRisorse);
HyperLinks.RegisterHandler('ID_RESPONSABILE', TFormRisorse);
HyperLinks.RegisterHandler('ID_RESPONSABILE_TIROCINI', TFormRisorse);
HyperLinks.RegisterHandler('ID_REFERENTE', TFormRisorse);
HyperLinks.RegisterHandler('ID_COORDINATORE', TFormRisorse);
HyperLinks.RegisterHandler('ID_TUTOR', TFormRisorse);
HyperLinks.RegisterHandler('ID_TUROR_PROGETTO', TFormRisorse);
HyperLinks.RegisterHandler('ID_RISORSA', TFormRisorse);
HyperLinks.RegisterHandler('ID_FORMATORE', TFormRisorse);
HyperLinks.RegisterHandler('ID_ESTENSORE_RICHIESTA', TFormRisorse);
HyperLinks.RegisterHandler('ID_RESPONSABILE_RIUNIONE', TFormRisorse);

end.


// procedure TzDbView.cxGridDBTableViewEditing(Sender: TcxCustomGridTableView;    AItem: TcxCustomGridTableItem; var AAllow: Boolean);
// begin
//
// end;

  Risorse.RilevamentiSenzaIncarico
(id_progetto; id_risorsa 302

  RettificaProtocollo

  GeneraAutorizzazionePagamento Autorizzazioni_Pagamento_Elenco

  GeneraAutorizzazionePagamentoXRisorsa Risorse_Autorizzazioni_Pagamento

  zBaseLib zz.wait

  zFbDataSet
  zsystem
  zdbcard
