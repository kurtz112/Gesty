unit MainForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Menus,
  Vcl.ActnList,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.ToolWin,
  Vcl.Buttons,
  Vcl.Mask,
  Vcl.StdActns,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.Comp.Client,
  dxStatusBar,
  dxBar,
  dxRibbonForm,
  dxSkinsCore,
  dxSkinsdxStatusBarPainter,
  dxSkinsdxBarPainter,
  dxLayoutContainer,
  dxLayoutControl,
  dxRibbonSkins,
  dxRibbonCustomizationForm,
  dxRibbon,
  dxRibbonStatusBar,
  dxBarApplicationMenu,
  dxGallery,
  dxGalleryControl,
  dxRibbonBackstageViewGalleryControl,
  dxRibbonBackstageView,
  dxGDIPlusClasses,
  dxSVGImage,
  dxRibbonGallery,
  dxSkinChooserGallery,
  dxSkinsForm,
  dxOfficeSearchBox,
  dxCore,
  dxShellDialogs,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxClasses,
  cxContainer,
  cxEdit,
  cxImage,
  cxSplitter,
  cxStyles,
  cxInplaceContainer,
  cxVGrid,
  cxOI,
  cxTextEdit,
  cxMaskEdit,
  cxSpinEdit,
  cxTimeEdit,
  cxBarEditItem,
  cxImageComboBox,
  cxCheckGroup,
  cxFontNameComboBox,
  cxDropDownEdit,
  cxColorComboBox,
  cxCheckBox,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  StdCtrls,
  zDbView,
  MDI_Lib,
  zWaitFrm,
  zCollection,
  ActionListController,
  frmAgenda,
  zRestrictions,
  frmOrario,
  frmInserimentoLavorativo,
  zFbDataSet,
  zNavBarTools,
  dxUIAdorners,
  System.Win.TaskbarCore,
  Vcl.Taskbar,
  zz.Taskbar,
  dxUIAClasses,
   zProgressBox,
  dxScreenTip,
  dxSkinsDefaultPainters,
  zChatAIPane;

type
  TMain = class(TdxRibbonForm, IRestriction)
    ActionList: TActionList;
    Esci: TAction;
    AggiornaProgressivi: TAction;
    Sistema: TAction;
    WindowCloseAll: TAction;
    Login: TAction;
    LoadZip: TAction;
    SaveZip: TAction;
    dxBarManager: TdxBarManager;
    dxBarButtonAggiornaProgressivi: TdxBarButton;
    dxBarButtonEsci: TdxBarButton;
    dxBarButtonSistema: TdxBarButton;
    dxBarButtonChiudiTutto: TdxBarButton;
    dxBarButtonLogin: TdxBarButton;
    dxBarButtonLoadZip: TdxBarButton;
    dxBarButtonSaveZip: TdxBarButton;
    File1: TdxBarSubItem;
    Quantita1: TdxBarSubItem;
    Tariffa1: TdxBarSubItem;
    Fatturazione1: TdxBarSubItem;
    Incassi1: TdxBarSubItem;
    Contabilit1: TdxBarSubItem;
    Partitario1: TdxBarSubItem;
    Utilit1: TdxBarSubItem;
    Finestre1: TdxBarSubItem;
    Help1: TdxBarSubItem;
    ConfigurazioneLog: TAction;
    dxRibbonMain: TdxRibbon;
    dxBarManagerBarQuickAccess: TdxBar;
    dxBarApplicationMenu: TdxBarApplicationMenu;
    dxBarSubItemSistema: TdxBarSubItem;
    dxBarSubItemUtentiPermessi: TdxBarSubItem;
    dxBarSubItemSviluppo: TdxBarSubItem;
    dxBarButtonTabelle: TdxBarButton;
    dxBarButtonConfigurazioneLog: TdxBarButton;
    ModuliActions: TActionList;
    Progetti: TAction;
    Budget: TAction;
    Studenti: TAction;
    Tabelle: TAction;
    tabEntiProgetti: TdxRibbonTab;
    dxBarManagerBarAnagrafiche: TdxBar;
    dxBarLargeButtonTabelle: TdxBarLargeButton;
    dxBarManagerBarMDI: TdxBar;
    Agenda: TAction;
    tabFormazione: TdxRibbonTab;
    dxBarManagerBarStudenti: TdxBar;
    tabRisorse: TdxRibbonTab;
    dxBarManagerBarRisorse: TdxBar;
    dxBarLargeButtonRisorse: TdxBarLargeButton;
    actPoliticheAccessi: TAction;
    actRicaricaPolitiche: TAction;
    actCambiaPassword: TAction;
    actGestioneUtenti: TAction;
    dxBarButtonGestioneUtenti: TdxBarButton;
    dxBarButtonGestionePermessi: TdxBarButton;
    dxBarButtonCambiaPassword: TdxBarButton;
    dxBarButtonRicaricaPolitiche: TdxBarButton;
    NuovaRichiestaAttivazione: TAction;
    InserimentoIncarico: TAction;
    RilevamentoOre: TAction;
    dxBarLargeButtonInserimentoPersonale: TdxBarLargeButton;
    dxBarLargeButtonInserimentoIncarico: TdxBarLargeButton;
    dxBarLargeButtonRilevamentoOre: TdxBarLargeButton;
    PersonaleScheda: TAction;
    dxBarButtonCartellaProgetto: TdxBarButton;
    dxBarLargeButtonPersonaleScheda: TdxBarLargeButton;
    BaseStatusBar: TdxRibbonStatusBar;
    PresenzePersonale: TAction;
    dxBarLargeButton1: TdxBarLargeButton;
    Risorse: TAction;
    dxBarLargeButton2: TdxBarLargeButton;
    RilevamentoAssenzeStudenti: TAction;
    RegistrazionePagamenti: TAction;
    dxBarLargeButton4: TdxBarLargeButton;
    dxSkinChooserGalleryItem: TdxSkinChooserGalleryItem;
    dxBarLargeButton5: TdxBarLargeButton;
    Orario: TAction;
    dxBarLargeButton6: TdxBarLargeButton;
    InserimentoLavorativo: TAction;
    RegistroStudenti: TAction;
    dxBarLargeButton8: TdxBarLargeButton;
    TabAreaSearchToolBar: TdxBar;
    beOfficeSearchBox: TcxBarEditItem;
    dxBarLargeButton9: TdxBarLargeButton;
    Valutazioni: TAction;
    Questionari: TAction;
    dxBarLargeButton10: TdxBarLargeButton;
    dxBarManagerBarEsiti: TdxBar;
    dxBarLargeButton11: TdxBarLargeButton;
    cxImage: TcxImage;
    Tirocini: TAction;
    PianiIndividuali: TAction;
    ExportRegione: TAction;
    dxBarLargeButton12: TdxBarLargeButton;
    dxBarLargeButton13: TdxBarLargeButton;
    dxBarLargeButton14: TdxBarLargeButton;
    cxBarEditItem1: TcxBarEditItem;
    Allegati: TAction;
    dxBarLargeButton16: TdxBarLargeButton;
    GRS: TAction;
    dxBarLargeButton17: TdxBarLargeButton;
    Inail: TAction;
    PrenotazioniAule: TAction;
    tabAccoglienza: TdxRibbonTab;
    tabAdempimenti: TdxRibbonTab;
    dxBarManagerBarHome: TdxBar;
    tabHome: TdxRibbonTab;
    dxBarManagerBarQuestionari: TdxBar;
    dxBarManagerBarComunicazioniInail: TdxBar;
    dxBarManagerBarAccordoStatoRegioni: TdxBar;
    dxBarManagerBarRilevamentoAssenze: TdxBar;
    dxBarLargeButtonNotifiche: TdxBarLargeButton;
    dxBarManagerBarAdempimenti: TdxBar;
    dxBarLargeButton19: TdxBarLargeButton;
    dxBarManagerBarPrenotazioniAule: TdxBar;
    dxBarLargeButton18: TdxBarLargeButton;
    dxBarManagerBarInserimentoLavorativo: TdxBar;
    dxBarLargeButton20: TdxBarLargeButton;
    dxBarManagerBarAssistentiSociali: TdxBar;
    dxBarLargeButton72: TdxBarLargeButton;
    AssistentiSociali: TAction;
    WindowClose: TAction;
    WindowCascade: TAction;
    WindowTileHorizontal: TAction;
    WindowTileVertical: TAction;
    WindowMinimizeAll: TAction;
    Adatta: TAction;
    tabVisualizza: TdxRibbonTab;
    dxBarManagerBarVisualizza: TdxBar;
    dxBarLargeButton7: TdxBarLargeButton;
    dxBarLargeButton21: TdxBarLargeButton;
    dxBarLargeButton22: TdxBarLargeButton;
    dxBarLargeButton23: TdxBarLargeButton;
    dxBarLargeButton24: TdxBarLargeButton;
    dxBarLargeButton25: TdxBarLargeButton;
    dxBarLargeButton26: TdxBarLargeButton;
    CalendarioDocenti: TAction;
    dxBarManagerBarCalendarioDocenti: TdxBar;
    dxBarLargeButton27: TdxBarLargeButton;
    Enti: TAction;
    dxBarLargeButton28: TdxBarLargeButton;
    Aule: TAction;
    dxBarLargeButton29: TdxBarLargeButton;
    Bandi: TAction;
    dxBarLargeButton30: TdxBarLargeButton;
    popActions: TdxBarPopupMenu;
    dxBarButton1: TdxBarButton;
    actPermessiAzione: TAction;
    CalendarioAvvioCorsi: TAction;
    dxBarManagerBarAgenda: TdxBar;
    dxBarLargeButton31: TdxBarLargeButton;
    Riunioni: TAction;
    dxBarLargeButton32: TdxBarLargeButton;
    dxBarSubItemElencoForm: TdxBarSubItem;
    Scadenze: TAction;
    dxBarLargeButton33: TdxBarLargeButton;
    Attrezzature: TAction;
    actDizionari: TAction;
    dxBarButton2: TdxBarButton;
    dxBarSubItemControlloOrtografico: TdxBarSubItem;
    dxBarLargeButton35: TdxBarLargeButton;
    RichiesteAttivazione: TAction;
    dxBarLargeButton36: TdxBarLargeButton;
    dxBarManagerBar6: TdxBar;
    dxBarManagerBar7: TdxBar;
    dxRibbonMainTabServiziAllaPersona: TdxRibbonTab;
    dxBarManagerBarAssistenzaScolastica: TdxBar;
    dxBarManagerBarAbitare: TdxBar;
    dxBarManagerBarDiarioSociale: TdxBar;
    dxBarManagerBar8: TdxBar;
    Sostegno: TAction;
    InterventiIntegrativi: TAction;
    dxBarLargeButton37: TdxBarLargeButton;
    dxBarLargeButton38: TdxBarLargeButton;
    AssistenzaScolastica: TAction;
    dxBarLargeButton39: TdxBarLargeButton;
    dxBarLargeButton40: TdxBarLargeButton;
    AS_Rendicontazione: TAction;
    AbitareEmergenza: TAction;
    dxBarLargeButton41: TdxBarLargeButton;
    dxBarLargeButton42: TdxBarLargeButton;
    dxBarManagerBarInterventi: TdxBar;
    dxBarLargeButton43: TdxBarLargeButton;
    DiarioSociale: TAction;
    dxBarLargeButton3: TdxBarLargeButton;
    AnalisiRilevamenti: TAction;
    dxBarLargeButton44: TdxBarLargeButton;
    dxBarLargeButton34: TdxBarLargeButton;
    FrontOffice: TAction;
    dxBarManagerBarFrontOffice: TdxBar;
    dxBarLargeButton45: TdxBarLargeButton;
    Candidature: TAction;
    dxBarManagerBarAziende: TdxBar;
    dxBarLargeButton46: TdxBarLargeButton;
    ServiziAlLavoro: TAction;
    dxBarLargeButton47: TdxBarLargeButton;
    Anagrafiche: TAction;
    dxBarLargeButton48: TdxBarLargeButton;
    AbitareSostegno: TAction;
    dxBarLargeButton49: TdxBarLargeButton;
    Aziende: TAction;
    dxBarLargeButton50: TdxBarLargeButton;
    dxUIAdornerManager: TdxUIAdornerManager;
    dxUIAdornerManager1Badge: TdxBadge;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    dxBarManagerBarTabArea: TdxBar;
    Notifiche: TAction;
    dxBarButtonNotifiche: TdxBarButton;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    dxBarButton7: TdxBarButton;
    TimerStartup: TTimer;
    ModuliStyleRepository: TcxStyleRepository;
    cxStyleValutazione: TcxStyle;
    cxStyleNonAbilitato: TcxStyle;
    cxStyleInSviluppo: TcxStyle;
    actStatoAttivazioneModulo: TAction;
    dxBarButton8: TdxBarButton;
    dxBarLargeButton51: TdxBarLargeButton;
    CalendarioAule: TAction;
    actDownloadAggiornamento: TAction;
    dxBarButton9: TdxBarButton;
    MonitorFireDAC: TAction;
    dxBarLargeButton53: TdxBarLargeButton;
    Contratti: TAction;
    dxBarLargeButton54: TdxBarLargeButton;
    FbExpert: TAction;
    dxBarLargeButton55: TdxBarLargeButton;
    ServizioInclusioneAdulti: TAction;
    dxBarManagerBarSIA: TdxBar;
    dxBarLargeButton56: TdxBarLargeButton;
    dxBarButtonAttivaLog: TdxBarButton;
    Timesheet: TAction;
    dxBarLargeButton57: TdxBarLargeButton;
    AttivitaFuoriSede: TAction;
    dxBarLargeButton58: TdxBarLargeButton;
    dxBarLargeButton59: TdxBarLargeButton;
    FormazioneInterna: TAction;
    dxScreenTipRepository: TdxScreenTipRepository;
    actTip: TAction;
    dxBarButton11: TdxBarButton;
    Riconnessione: TAction;
    dxBarButton12: TdxBarButton;
    MonitorFB: TAction;
    ProfilerFB: TAction;
    dxBarButton13: TdxBarButton;
    dxBarButton14: TdxBarButton;
    BaseWeb: TAction;
    dxBarButton15: TdxBarButton;
    AccordoStatoRegioni: TAction;
    Attestati: TAction;
    dxBarLargeButton60: TdxBarLargeButton;
    dxBarLargeButton61: TdxBarLargeButton;
    dxBarManagerBarProgetti: TdxBar;
    dxBarManagerBarCorsi: TdxBar;
    dxBarManagerBar15: TdxBar;
    dxRibbonSkinSelector: TdxRibbonSkinSelector;
    RegistroMessaggi: TAction;
    tabDocumentazione: TdxRibbonTab;
    dxBarManagerBar16: TdxBar;
    dxBarLargeButton15: TdxBarLargeButton;
    dxBarManagerBar17: TdxBar;
    dxBarLargeButton62: TdxBarLargeButton;
    // --- Orientamento e motori documentali (Firma/Protocollo/Conservazione) ---
    // Orientamento e' collegata a TFormOrientamento (modulo Orientamento ITS, 2026-09):
    // e' un gruppo del tab Accoglienza e Agende, accanto a Front Office (2026-10).
    dxBarManagerBarOrientamento: TdxBar;
    dxBarManagerBarDocumentaliMotori: TdxBar;
    Orientamento: TAction;
    RegistroFirma: TAction;
    RegistroProtocollo: TAction;
    RegistroConservazione: TAction;
    dxBarLargeButtonOrientamento: TdxBarLargeButton;
    dxBarLargeButtonRegistroFirma: TdxBarLargeButton;
    dxBarLargeButtonRegistroProtocollo: TdxBarLargeButton;
    dxBarLargeButtonRegistroConservazione: TdxBarLargeButton;
    CruscottoDocumentale: TAction;
    dxBarLargeButton52: TdxBarLargeButton;
    dxBarManagerBar1: TdxBar;
    FirmaDocumenti: TAction;
    dxBarLargeButton63: TdxBarLargeButton;
    AttivaLog: TAction;
    SegnalibroLog: TAction;
    dxBarButtonSegnalibroLog: TdxBarButton;
    dxBarSubItemAssistenza: TdxBarSubItem;
    RegistraDalProssimoAvvio: TAction;
    dxBarButtonRegistraDalProssimoAvvio: TdxBarButton;
    TicketAssistenza: TAction;
    dxBarButtonTicketAssistenza: TdxBarButton;
    CoGe_Bilancio: TAction;
    tabContabilita: TdxRibbonTab;
    dxBarManagerBar2: TdxBar;
    dxBarManagerBarIncassi: TdxBar;
    dxBarManagerBarFattureElettroniche: TdxBar;
    dxBarManagerBarRegistrazioni: TdxBar;
    dxBarManagerBarConfigurazione: TdxBar;
    dxBarLargeButton64: TdxBarLargeButton;
    dxBarLargeButton65: TdxBarLargeButton;
    dxBarLargeButton66: TdxBarLargeButton;
    dxBarLargeButton67: TdxBarLargeButton;
    dxBarLargeButton68: TdxBarLargeButton;
    dxBarLargeButton69: TdxBarLargeButton;
    dxBarLargeButton70: TdxBarLargeButton;
    dxBarManagerBarGateway_Contabile: TdxBar;
    dxBarLargeButton71: TdxBarLargeButton;
    CoGe_Gateway_Contabile: TAction;
    actAI: TAction;
    dxBarButton17: TdxBarButton;
    actPatchLzDaFile: TAction;
    actPatchLzDagliAppunti: TAction;
    dxBarSubItemPatchLz: TdxBarSubItem;
    dxBarButtonPatchLzDaFile: TdxBarButton;
    dxBarButtonPatchLzDagliAppunti: TdxBarButton;
    procedure AbitareEmergenzaExecute(Sender: TObject);
    procedure AbitareSostegnoExecute(Sender: TObject);
    procedure AccordoStatoRegioniExecute(Sender: TObject);
    procedure actAIExecute(Sender: TObject);
    procedure actAIUpdate(Sender: TObject);
    procedure actCambiaPasswordExecute(Sender: TObject);
    procedure actDizionariExecute(Sender: TObject);
    procedure actDownloadAggiornamentoExecute(Sender: TObject);
    procedure actGestioneUtentiExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActionUpdateAdmin(Sender: TObject);
    procedure actPatchLzDaFileExecute(Sender: TObject);
    procedure actPatchLzDagliAppuntiExecute(Sender: TObject);
    procedure actPermessiAzioneExecute(Sender: TObject);
    procedure actPoliticheAccessiExecute(Sender: TObject);
    procedure actRicaricaPoliticheExecute(Sender: TObject);
    procedure actStatoAttivazioneModuloExecute(Sender: TObject);
    procedure actTipExecute(Sender: TObject);
    procedure AgendaExecute(Sender: TObject);
    procedure AggiornaProgressiviExecute(Sender: TObject);
    procedure AllegatiExecute(Sender: TObject);
    procedure AnagraficheExecute(Sender: TObject);
    procedure AnalisiRilevamentiExecute(Sender: TObject);
    procedure AssistenzaScolasticaExecute(Sender: TObject);
    procedure AS_RendicontazioneExecute(Sender: TObject);
    procedure AttivitaFuoriSedeExecute(Sender: TObject);
    procedure AuleExecute(Sender: TObject);
    procedure BandiExecute(Sender: TObject);
    procedure CalendarioAvvioCorsiExecute(Sender: TObject);
    procedure CalendarioDocentiExecute(Sender: TObject);
    procedure BudgetExecute(Sender: TObject);
    procedure SistemaExecute(Sender: TObject);
    procedure EsciExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WindowCloseAllExecute(Sender: TObject);
    procedure ConfigurazioneLogExecute(Sender: TObject);
    procedure cxImageDblClick(Sender: TObject);
    procedure AttrezzatureExecute(Sender: TObject);
    procedure AziendeExecute(Sender: TObject);
    procedure CalendarioAuleExecute(Sender: TObject);
    procedure CandidatureExecute(Sender: TObject);
    procedure ContrattiExecute(Sender: TObject);
    procedure DiarioSocialeExecute(Sender: TObject);
    procedure dxBarManagerBarVisibleChange(Sender: TdxBarManager; ABar: TdxBar);
    procedure dxBarManagerShowToolbarsPopup(Sender: TdxBarManager; PopupItemLinks: TdxBarItemLinks);
    procedure dxBarPopupMenuPopup(Sender: TObject);
    procedure dxSkinChooserGalleryItemSkinChanged(Sender: TObject; const ASkinName: string);
    procedure dxUIAdornerManager1BadgeClick(AManager: TdxUIAdornerManager; AAdorner: TdxCustomAdorner);
    procedure EntiExecute(Sender: TObject);
    procedure ExportRegioneExecute(Sender: TObject);
    procedure FbExpertExecute(Sender: TObject);
    procedure FormazioneInternaExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FrontOfficeExecute(Sender: TObject);
    procedure OrientamentoExecute(Sender: TObject);
    procedure GRSExecute(Sender: TObject);
    procedure InailExecute(Sender: TObject);
    procedure InserimentoIncaricoExecute(Sender: TObject);
    procedure InserimentoLavorativoExecute(Sender: TObject);
    procedure InterventiIntegrativiExecute(Sender: TObject);
    procedure NuovaRichiestaAttivazioneExecute(Sender: TObject);
    procedure LoginExecute(Sender: TObject);
    procedure LoadZipExecute(Sender: TObject);
    procedure ModuliActionsExecute(Action: TBasicAction; var Handled: Boolean);
    procedure MonitorFBExecute(Sender: TObject);
    procedure MonitorFireDACExecute(Sender: TObject);
    procedure NotificheExecute(Sender: TObject);
    procedure OrarioExecute(Sender: TObject);
    procedure PersonaleSchedaExecute(Sender: TObject);
    procedure PianiIndividualiExecute(Sender: TObject);
    procedure popActionsPopup(Sender: TObject);
    procedure PrenotazioniAuleExecute(Sender: TObject);
    procedure PresenzePersonaleExecute(Sender: TObject);
    procedure ProgettiExecute(Sender: TObject);
    procedure QuestionariExecute(Sender: TObject);
    procedure RegistrazionePagamentiExecute(Sender: TObject);
    procedure RegistroStudentiExecute(Sender: TObject);
    procedure RichiesteAttivazioneExecute(Sender: TObject);
    procedure RilevamentoAssenzeStudentiExecute(Sender: TObject);
    procedure RilevamentoOreExecute(Sender: TObject);
    procedure RisorseExecute(Sender: TObject);
    procedure RiunioniExecute(Sender: TObject);
    procedure SaveZipExecute(Sender: TObject);
    procedure ScadenzeExecute(Sender: TObject);
    procedure ServiziAlLavoroExecute(Sender: TObject);
    procedure ServizioInclusioneAdultiExecute(Sender: TObject);
    procedure AssistentiSocialiExecute(Sender: TObject);
    procedure SostegnoExecute(Sender: TObject);
    procedure StudentiExecute(Sender: TObject);
    procedure TabelleExecute(Sender: TObject);
    procedure TimerStartupTimer(Sender: TObject);
    procedure TimesheetExecute(Sender: TObject);
    procedure TirociniExecute(Sender: TObject);
    procedure ValutazioniExecute(Sender: TObject);
    procedure WindowActionUpdate(Sender: TObject);
    procedure AdattaExecute(Sender: TObject);
    procedure AttestatiExecute(Sender: TObject);
    procedure AttivaLogExecute(Sender: TObject);
    procedure ProfilerFBExecute(Sender: TObject);
    procedure RiconnessioneExecute(Sender: TObject);
    procedure BaseWebExecute(Sender: TObject);
    procedure CoGe_BilancioExecute(Sender: TObject);
    procedure CoGe_ConfigurazioneExecute(Sender: TObject);
    procedure CoGe_DocumentiExecute(Sender: TObject);
    procedure CoGe_FattureElettronicheExecute(Sender: TObject);
    procedure CoGe_Gateway_ContabileExecute(Sender: TObject);
    procedure CoGe_IncassiExecute(Sender: TObject);
    procedure CoGe_RegistrazioniExecute(Sender: TObject);
    procedure CoGe_SoggettiExecute(Sender: TObject);
    procedure CruscottoDocumentaleExecute(Sender: TObject);
    procedure dxRibbonSkinSelectorPaletteChanged(Sender: TObject; const AArgs: TdxRibbonSkinSelectorPaletteChangedArgs);
    procedure dxRibbonSkinSelectorSetSkin(Sender: TObject; const AHelper: TdxRibbonSkinSelectorSetSkinHelper; const AArgs: TdxRibbonSkinSelectorSetSkinArgs; var AHandled: Boolean);
    procedure FirmaDocumentiExecute(Sender: TObject);
    procedure RegistroMessaggiExecute(Sender: TObject);
    procedure RegistroConservazioneExecute(Sender: TObject);
    procedure RegistroFirmaExecute(Sender: TObject);
    procedure RegistroProtocolloExecute(Sender: TObject);
    procedure SegnalibroLogExecute(Sender: TObject);
    procedure RegistraDalProssimoAvvioExecute(Sender: TObject);
    procedure TicketAssistenzaExecute(Sender: TObject);
    procedure WindowCascadeExecute(Sender: TObject);
    procedure WindowCloseExecute(Sender: TObject);
    procedure WindowMinimizeAllExecute(Sender: TObject);
    procedure WindowTileHorizontalExecute(Sender: TObject);
    procedure WindowTileVerticalExecute(Sender: TObject);
  private
    FChatAI: TzChatAIPane;
  private
    CambioParametriLavoroInCorso: Boolean;
    ActionListController: TActionListController;
    Occupato: Boolean;
    ScegliComuneEnabled: Boolean;
    // procedure CreaDiagramFrame(DiagramName: string);
    procedure CreaForm(MdiFormClass: TBaseFormClass);
    procedure HideEmptyTabs;
    procedure DestroyForms;
    procedure AggiornaStatusBar;
    procedure BarApplicationMenuMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    procedure ApplyModuli;
    procedure ApplyRestrictions;
    function GetRestrictionManager: TRestrictionManager;
  private
    procedure StatoLogCambiato(Sender: TObject);
  private
    procedure InitTips;
    procedure InitSessioneLog;
  private
    procedure CenterImage;
    procedure LoadImage;
  private
    procedure CaricaSkin(ASkinName: string);
    procedure InitSkin;
  private
    Taskbar: TzTaskbar;
    procedure InitTaskBar;
  private
    RestrictionManager: TRestrictionManager;
    ToolButtons: TzComponentList<TdxBarButton>;
    procedure ToolMDIChanged(Sender: TObject);
    procedure ToolMDIClick(Sender: TObject);
    procedure UpdateToolMDI;
  private
    procedure AbilitaTrascinamentoPatchLz;
  protected
    procedure CreateWnd; override;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    function GetFormBorderIcons: TdxRibbonBorderIcons; override;
    procedure WMEndSession(var Msg: TWMEndSession);
    procedure WMQueryEndSession(var Msg: TWMQueryEndSession);
  public
    procedure UpdatePolicies;
    procedure AfterLogin;

    function IsShortCut(var Message: TWMKey): Boolean; override; // dynamic;
  public type
    TLogoProps = record
      FileName: string;
      ImageRatioW: double;
      ImageRatioH: double;
      procedure Init;
      procedure LoadFromIni;
      function ImageExists: Boolean;
    end;
  public
    LogoProps: TLogoProps;
  public
    procedure MostraBadgeNotifiche(const NumeroNotificheNonLette: Integer);

    procedure pippo;

    procedure salvaimageList;
  end;

var
  Main: TMain;

implementation

uses
  System.IniFiles,
  System.Math,
  Vcl.Clipbrd,
  ConfigModule,
  zSystem,
  zSystem.Patcher,
  zMsg,
  Base_DataModule,
  zDm_Images,
  zBaseLib,
  Init_Controls,
  zRestrictions.Types,
  BaseFrm,
  frmProgetti,
  frmStudenti,
  frmTabelle,
  frmCartellaProgetto,
  frmGestioneUtenti,
  WizInserimentoIncaricoFrm,
  WizNuovaRichiestaAttivazioneFrm,
  frmRilevamentoOre,
  frmPersonaleScheda,
  frmPersonalePresenze,
  frmRisorse,
  frmPagamenti,
  frmStudentiRilevamentoPresenzeAssenze,
  frmRegistroStudenti,
  frmValutazioniRisorse,
  frmQuestionari,
  frmGRS,
  frmExportRegione,
  frmTirocini,
  frmPianiIndividuali,
  frmAllegati,
  WizTirociniFrm,
  Gesty_StoredProcs,
  zDX,
  zz.SplashWait,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl,
  frmInail,
  frmPrenotazioniAule,
  frmCalendarioDocenti,
  frmEnti,
  frmAule,
  frmBandi,
  zz.Vcl,
  frmCalendarioAvvioCorsi,
  frmRiunioni,
  frmScadenze,
  frmAttrezzature,
  frmBudget,
  frmRichiesteAttivazione,
  frmSostegno,
  frmInterventiIntegrativi,
  frmAssistenzaScolastica,
  frmAS_Rendicontazione,
  frmDiarioSociale,
  frmAnalisiRilevamenti,
  frmFrontOffice,
  frmOrientamento,
  frmCandidature,
  frmServiziAlLavoro,
  frmAnagrafiche,
  frmAbitare_Sostegno,
  frmAbitare_Emergenza,
  frmAziende,
  frmNotifiche,
  zModuli,
  frmCalendarioAule,
  frmContratti,
  Gesty.Authorizations,
  frmFbExpert,
  frmSIA_ServizioInclusioneAdulti,
  frmAssistentiSociali,
  System.IOUtils,
  frmTimesheet,
  frmAttivitaFuoriSede,
  frmFormazioneInterna,
  zz.base.editor._form,
  zMemoDialog,
  frmFbMonitor,
  frmFbProfiler,
  BaseWeb.Form,
  frmAttestati,
  frmAccordoStatoRegioni,
  frmDocumentazioneMessaggiRegistro,
  frmDocumentazioneConservazione,
  frmDocumentazioneRegistroFirme,
  frmDocumentazioneRegistroProtocollo,
  frmDocumentazioneFirmaElettronica,
  frmDocumentazioneCruscotto,
  frmCoge_Bilancio,
  frmCoge_Configurazione,
  frmCoge_Documenti,
  frmCoge_FattureElettroniche,
  frmCoge_Incassi,
  frmCoge_Registrazioni,
  frmCoge_Soggetti,
  zDiagnostica.Log,
  zDiagnostica.Log.Perf,
  frmCOGE_Gateway_Contabile;


// zSystem_OLD;

{$R *.dfm}

type
  TdxBarControlAccess = class(TdxBarControl);
  TdxBarSubMenuControlAccess = class(TdxBarSubMenuControl);

procedure TMain.actCambiaPasswordExecute(Sender: TObject);
begin
  if Assigned(Config) then
    if Config.zSystem.zSecurity.LoggedIn then
      Config.CambiaPassword;
end;

procedure TMain.actGestioneUtentiExecute(Sender: TObject);
begin
  CreaForm(TFormGestioneUtenti);
end;

procedure TMain.ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
  function dxBarVisible(const Visible: Boolean): TdxBarItemVisible;
  begin
    if Visible then
      Result := ivAlways
    else
      Result := ivNever;
  end;

begin
  dxBarSubItemSistema.Visible := dxBarVisible(Config.zSystem.CanEditRestrictions or Config.zSystem.IsAdmin);
  // Chi vede Sistema per le sole politiche di accesso trova solo la voce
  // Sistema (la via per diventare amministratore), Utenti e permessi e
  // Dizionari: i sottomenu di amministrazione e di sviluppo, e la patch LZ
  // dentro il primo, sono dell'amministratore. Le singole azioni dentro
  // hanno anche OnUpdate = ActionUpdateAdmin; nascondere il contenitore
  // evita di lasciare un sottomenu vuoto.
  dxBarSubItemSviluppo.Visible := dxBarVisible(Config.zSystem.IsAdmin);
  dxBarSubItemPatchLz.Visible := dxBarVisible(Config.zSystem.IsAdmin);
  // Dovr  diventare GESTIONE_UTENTI
  // dxBarSubItemSistema.Visible := dx.Visible(Config.Authorizhed(Gesty_Authorizations.GESTIONE_UTENTI));
end;

procedure TMain.FormDestroy(Sender: TObject);
begin
  TaskbarManager.Reset;
  FreeAndNil(ToolButtons);
  FreeAndNil(ActionListController);
  FreeAndNil(RestrictionManager);
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  inherited;

  TimerStartup.Enabled := false;
  DisableAero := true;
  Occupato := false;
  CambioParametriLavoroInCorso := false;
  ScegliComuneEnabled := false;

  FChatAI:=nil;

  cxImage.AutoSize := false;
  cxImage.Visible := false; // viene poi ativata da center image

  dxRibbonMain.ShowTabGroups := false;
  if dxRibbonMain.Tabs.Count > 0 then
    dxRibbonMain.ActiveTab := dxRibbonMain.Tabs[0];

  RestrictionManager := TRestrictionManager.Create(Self, Config.zSystem, Self, nil);
  RestrictionManager.AddDefaultLevel(Esci, 'Base', TAccessLevel.alFull);
  RestrictionManager.AddDefaultLevel(Login, 'Base', TAccessLevel.alFull);
  RestrictionManager.AddDefaultLevel(actCambiaPassword, 'Base', TAccessLevel.alFull);
  RestrictionManager.AddDefaultLevel(Sistema, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(MonitorFireDAC, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(MonitorFB, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(ProfilerFB, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(LoadZip, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(SaveZip, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(actPatchLzDaFile, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(actPatchLzDagliAppunti, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(ConfigurazioneLog, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(actGestioneUtenti, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(actPoliticheAccessi, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(actRicaricaPolitiche, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(AggiornaProgressivi, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(actDizionari, 'Base', TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(actDownloadAggiornamento, 'Base', TAccessLevel.alNone);

  RestrictionManager.AddDefaultLevel(Budget, TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(AssistenzaScolastica, TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(Anagrafiche, TAccessLevel.alNone);
  RestrictionManager.AddDefaultLevel(Contratti, TAccessLevel.alNone);
  //
  RestrictionManager.AddDefaultLevel(FbExpert, TAccessLevel.alNone);
  //

  ToolButtons := TzComponentList<TdxBarButton>.Create;
  Init_Ctrls(Self);

  if TerminalServer then
    BorderIcons := BorderIcons - [biMinimize];

  HelpType := htContext;
  HelpContext := Config.zSystem.GetHelpContext(Self);

  Main.Caption := Application.Title;

  MDI_Lib.MainUpdatePolicies := procedure
    begin
      Self.UpdatePolicies;
    end;

  BaseStatusBar.Panels[0].Visible := false; // verr  attivato da UpdateToolMDI;
  AggiornaStatusBar;

  // Sullo stesso monitor della schermata di avvio e della finestra di
  // accesso, prima di ingrandirsi: la finestra si ingrandisce sul monitor in
  // cui sta. Senza, con poDesktopCenter finiva sul monitor al centro del
  // desktop, e alla chiusura TWorkingMonitor.Remember salvava quello,
  // trascinandoci anche la schermata dell'avvio successivo.
  TWorkingMonitor.CenterForm(Self);
  WindowState := wsMaximized;

  ApplyModuli;
  ApplyRestrictions;

  FormCollection.onChange := ToolMDIChanged;

  ActionListController := TActionListController.Create;
  ActionListController.register(ActionList);

  // La schermata di avvio non si chiude piu' qui: resta a video per tutta la
  // creazione della finestra principale e la chiude il .dpr subito dopo
  // CreateForm, cioe' appena prima che questa finestra compaia.

  InitSkin;

  InitTips;

  LoadImage;
end;

procedure TMain.CreaForm(MdiFormClass: TBaseFormClass);
var
  Module: String;
begin
  if Occupato then
    Exit;

  Occupato := true;
  try
    FormCollection.CreateForm(MdiFormClass)
  finally
    Occupato := false;
  end;

  Main.Realign;
end;

function TMain.IsShortCut(var Message: TWMKey): Boolean;
var
  ctrl: TWinControl;
  comp: TComponent;
  i: Integer;
begin
  ctrl := ActiveControl;
  if ctrl <> nil then
  begin
    repeat
      ctrl := ctrl.Parent
    until (ctrl = nil) or (ctrl is TCustomFrame);
    if ctrl <> nil then
    begin
      for i := 0 to ctrl.ComponentCount - 1 do
      begin
        comp := ctrl.Components[i];
        if comp is TCustomActionList then
        begin
          Result := TCustomActionList(comp).IsShortCut(Message);
          if Result then
            Exit;
        end;
      end;
    end;
  end;
  Result := inherited IsShortCut(Message);
end;

procedure TMain.AggiornaProgressiviExecute(Sender: TObject);
begin
  if ConfirmOkCancel('Aggiornare i progressivi ?') then
    Config.zSystem.UpdateGenerators;
end;

procedure TMain.SistemaExecute(Sender: TObject);
var
  i: Integer;
begin
  if not Config.zSystem.IsAdmin then
    Config.zSystem.CheckAdmin; // chiede l password

  if not Config.zSystem.IsAdmin then
    Exit;

  Config.zSystem.ShowSystemForm;
end;

procedure TMain.EsciExecute(Sender: TObject);
begin
  Close;
end;

procedure TMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  TimerStartup.Enabled := false;
  StopWait;

  if Config.ShuttingDown then
  begin
    CanClose := true;
    Exit;
  end;

  if not debug then
    CanClose := ConfirmYesNo('Si desidera terminare Gesty?');
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  // Su quale monitor stiamo lavorando, per il prossimo avvio: la schermata di
  // avvio non ha altro modo di saperlo, perche' quando compare non esiste
  // ancora nessuna finestra e il puntatore del mouse dice dove si e' fatto
  // doppio clic, non dove si lavora.
  TWorkingMonitor.Remember(Self);

  for i := FormCollection.Count - 1 downto 0 do
    FormCollection[i].Form.Close;
end;

procedure TMain.ApplyRestrictions;
begin
  RestrictionManager.ApplyRestrictions;
  HideEmptyTabs;
end;

procedure TMain.LoginExecute(Sender: TObject);
begin
  DestroyForms;
  Config.Login;
  AfterLogin;
end;

procedure TMain.LoadZipExecute(Sender: TObject);
begin
  LoadZip.Enabled := false;
  try
    Config.RicaricaImpostazioni;
  finally
    LoadZip.Enabled := true;
  end;
end;

procedure TMain.SaveZipExecute(Sender: TObject);
begin
  // SaveZip.Enabled := False;
  // try
  // Config.zSystem.BackupZip;
  // Config.zSystem.SaveZip(csAll, 'main');
  // finally
  // SaveZip.Enabled := true;
  // end;
end;

procedure TMain.ActionUpdateAdmin(Sender: TObject);
begin
  if Sender is TAction then
    if Assigned(Config) then
      if Config.zSystem.zSecurity.LoggedIn then
      begin
        TAction(Sender).Enabled := Config.zSystem.IsAdmin;
        TAction(Sender).Visible := Config.zSystem.IsAdmin;
      end;
end;

procedure TMain.actPatchLzDaFileExecute(Sender: TObject);
begin
  // la voce e' visibile solo all'amministratore; il controllo si ripete qui
  // perche' la patch riscrive l'archivio LZ condiviso dalla postazione
  if not Config.zSystem.IsAdmin then
    Exit;

  ApplyPatchFromFile(Config.zSystem);
end;

procedure TMain.actPatchLzDagliAppuntiExecute(Sender: TObject);
begin
  if not Config.zSystem.IsAdmin then
    Exit;

  ApplyPatchFromClipboard(Config.zSystem);
end;

procedure TMain.actPoliticheAccessiExecute(Sender: TObject);
begin
  RestrictionManager.EditRestrictions;
end;

procedure TMain.actRicaricaPoliticheExecute(Sender: TObject);
begin
  ApplyRestrictions;
end;

procedure TMain.AbilitaTrascinamentoPatchLz;
begin
  // l'amministratore si riconosce solo dopo il login: si richiama anche da AfterLogin
  if HandleAllocated and Assigned(Config) and Assigned(Config.zSystem) then
    AcceptPatchDrop(Config.zSystem, Handle);
end;

procedure TMain.CreateWnd;
begin
  inherited;
  AbilitaTrascinamentoPatchLz;
end;

procedure TMain.WMDropFiles(var Msg: TWMDropFiles);
begin
  // un file .json trascinato sulla finestra principale e' trattato come una
  // patch del dizionario LZ (stesso flusso di Sistema - Applica patch - Da file)
  ApplyPatchFromDrop(Config.zSystem, Msg.Drop);
  Msg.Result := 0;
end;

procedure TMain.AfterLogin;
begin
  AbilitaTrascinamentoPatchLz;
  InitSkin;
  ApplyModuli;
  ApplyRestrictions;
  AggiornaStatusBar;
  // La riconnessione rilegge i parametri di Mantis (InitMantis): la
  // disponibilita' della registrazione puo' essere cambiata.
  StatoLogCambiato(Self);
end;

procedure TMain.AgendaExecute(Sender: TObject);
begin
  CreaForm(TFormAgenda);
end;

procedure TMain.BudgetExecute(Sender: TObject);
begin
  CreaForm(TFormBudget);
end;

procedure TMain.DestroyForms;
var
  i: Integer;
  Form: TBaseForm;
begin
  Occupato := true;
  try
    for i := FormCollection.Count - 1 downto 0 do
    begin
      Form := FormCollection.Items[i].Form;
      FreeAndNil(Form);
    end;
  finally
    Occupato := false;
  end;
end;

procedure TMain.WMEndSession(var Msg: TWMEndSession);
begin
  if Msg.EndSession then
  begin

  end;
  inherited;
end;

procedure TMain.WMQueryEndSession(var Msg: TWMQueryEndSession);
begin
  Msg.Result := 1;
end;

procedure TMain.dxBarManagerShowToolbarsPopup(Sender: TdxBarManager; PopupItemLinks: TdxBarItemLinks);
begin
  // nasconde il popup del men  delle toolbar
  PopupItemLinks.Clear;
end;

function TMain.GetFormBorderIcons: TdxRibbonBorderIcons;
begin
  Result := inherited GetFormBorderIcons - [rbiDisplayOptions];
end;

function TMain.GetRestrictionManager: TRestrictionManager;
begin
  Result := RestrictionManager;
end;

procedure TMain.InserimentoIncaricoExecute(Sender: TObject);
begin
  ApriInserimentoIncarico(-1);
end;

procedure TMain.NuovaRichiestaAttivazioneExecute(Sender: TObject);
begin
  ApriNuovaRichiestaAttivazione;
end;

procedure TMain.PersonaleSchedaExecute(Sender: TObject);
begin
  CreaForm(TFormPersonaleScheda);
end;

procedure TMain.RilevamentoOreExecute(Sender: TObject);
begin
  CreaForm(TFormRilevamentoOre);
end;

procedure TMain.StudentiExecute(Sender: TObject);
begin
  CreaForm(TFormStudenti);
end;

procedure TMain.TabelleExecute(Sender: TObject);
begin
  CreaForm(TFormTabelle);
end;

procedure TMain.ToolMDIChanged(Sender: TObject);
begin
  cxImage.Visible := FormCollection.Count = 0;
  UpdateToolMDI;
end;

procedure TMain.ToolMDIClick(Sender: TObject);
var
  Item: TdxBarButton;
begin
  if Occupato then
    Exit;

  if not(Sender is TdxBarButton) then
    Exit;

  Item := Sender as TdxBarButton;

  Occupato := true;
  try
    FormCollection.ShowForm(FormCollection.Items[Item.Tag].Form);
  finally
    Occupato := false;
  end;
end;

procedure TMain.UpdateToolMDI;
var
  i: Integer;
  btn: TdxBarButton;
begin

  FormCollection.onChange := nil;
  try
    for i := ToolButtons.Count - 1 downto 0 do
    begin
      btn := ToolButtons[i];
      ToolButtons.Remove(btn);
      FreeAndNil(btn);
    end;

    ToolButtons.Clear;

    for i := 0 to FormCollection.Count - 1 do
    begin
      btn := TdxBarButton.Create(Self);
      ToolButtons.Add(btn);
      btn.Caption := FormCollection.Items[i].Form.Caption;
      btn.Tag := i;
      btn.ImageIndex := dx.IndiceIcona('finestra_elenco');
      btn.OnClick := ToolMDIClick;
      btn.PaintStyle := psCaptionGlyph;
      dxBarSubItemElencoForm.ItemLinks.Add(btn);
    end;
  finally
    FormCollection.onChange := ToolMDIChanged;
  end;

  dxBarSubItemElencoForm.Caption := FormCollection.Count.ToString;
  BaseStatusBar.Panels[0].Visible := FormCollection.Count > 1;
end;

procedure TMain.AggiornaStatusBar;
var
  i: Integer;
  usr, conn, DB: String;
begin
  usr := '';
  conn := '';
  DB := '';

  if Assigned(Config) then
    if Config.zSystem.zSecurity.LoggedIn then
    begin
      usr := Config.zSystem.zSecurity.LoginParams.UserDisplayName;
      conn := Config.zSystem.zSecurity.LoginParams.ConnectionName;

      if Config.zSystem.IsAdmin then
        DB := Config.Database.Params.Database;
    end;

  // BaseStatusBar.Panels[0] <= elenco form
  BaseStatusBar.Panels[1].Text := ' ' + GetFileVersion;
  BaseStatusBar.Panels[2].Text := GetCurrentProcessId.ToString;
  BaseStatusBar.Panels[3].Text := usr;
  BaseStatusBar.Panels[4].Text := conn;
  BaseStatusBar.Panels[5].Text := DB;

  if Config.WireCompression then
    BaseStatusBar.Panels[5].Text := BaseStatusBar.Panels[5].Text + ' (*)';

  for i := 1 to 5 do
    BaseStatusBar.Panels[i].Width := 10 + BaseStatusBar.Canvas.TextWidth(BaseStatusBar.Panels[i].Text);

  BaseStatusBar.Panels[5].Visible := Config.zSystem.IsAdmin;
end;

procedure TMain.AllegatiExecute(Sender: TObject);
begin
  CreaForm(TFormAllegati);
end;

procedure TMain.PresenzePersonaleExecute(Sender: TObject);
begin
  CreaForm(TFormPersonalePresenze);
end;

procedure TMain.ProgettiExecute(Sender: TObject);
begin
  CreaForm(TFormProgetti);
end;

procedure TMain.RisorseExecute(Sender: TObject);
begin
  CreaForm(TFormRisorse);
end;

procedure TMain.UpdatePolicies;
begin
  ApplyRestrictions;
  AggiornaStatusBar;
end;

procedure TMain.HideEmptyTabs;
var
  iGrp: Integer;
  iTab: Integer;
  tabVisible: Boolean;
  ToolBar: TdxBar;
begin
  for iTab := 0 to dxRibbonMain.Tabs.Count - 1 do
  begin

    tabVisible := false;

    for iGrp := 0 to dxRibbonMain.Tabs[iTab].Groups.Count - 1 do
      if Assigned(dxRibbonMain.Tabs[iTab].Groups[iGrp].ToolBar) then
      begin
        ToolBar := dxRibbonMain.Tabs[iTab].Groups[iGrp].ToolBar;
        ToolBar.Visible := ToolBar.ItemLinks.VisibleItemCount > 0;

        if ToolBar.Visible then
          tabVisible := true;
      end;

    dxRibbonMain.Tabs[iTab].Visible := tabVisible;
  end;
end;

procedure TMain.RegistrazionePagamentiExecute(Sender: TObject);
begin
  CreaForm(TFormPagamenti);
end;

procedure TMain.RilevamentoAssenzeStudentiExecute(Sender: TObject);
begin
  if ConfirmYesNo('Attenzione: questa sezione   in sola consultazione.' + #13#10 + 'Utilizzare per le rilevazioni "Registro studenti".' + #13#10 + 'Continuare?', mtWarning) then
    CreaForm(TFormStudentiRilevamentoPresenzeAssenze);
end;

procedure TMain.InitSkin;
var
  Skin: string;
begin
  // blocco da eliminare
  dx.InitSkinChooserGalleryItem(dxSkinChooserGalleryItem);

  Skin := Config.zSystem.SkinName;
  CaricaSkin(Skin);

  // \fine blocco

  dx.InitRibbonSkinSelector(dxRibbonSkinSelector);
  dx.SkinPaletteName := Config.zSystem.SkinPaletteName;

  if not Config.zSystem.SkinName.IsEmpty then
    dxRibbonSkinSelector.SetSkin(Config.zSystem.SkinName, Config.zSystem.SkinPaletteName);
end;

procedure TMain.dxRibbonSkinSelectorSetSkin(Sender: TObject; const AHelper: TdxRibbonSkinSelectorSetSkinHelper; const AArgs: TdxRibbonSkinSelectorSetSkinArgs; var AHandled: Boolean);
begin
  CaricaSkin(AArgs.SkinName);
  AHandled := true;
end;

procedure TMain.dxRibbonSkinSelectorPaletteChanged(Sender: TObject; const AArgs: TdxRibbonSkinSelectorPaletteChangedArgs);
begin
  dx.SkinPaletteName := AArgs.PaletteName;
  Config.zSystem.SkinPaletteName := AArgs.PaletteName;
end;

procedure TMain.dxSkinChooserGalleryItemSkinChanged(Sender: TObject; const ASkinName: string);
var
  NomeSkin: string;
begin
  // Mantis #239 - 2026-10-14: la galleria si ricostruisce a clic concluso, altrimenti
  // TdxCustomRibbonGalleryItem.DoClick salva in FFirstVisibleGroupItem la voce appena distrutta
  NomeSkin := ASkinName;
  TThread.ForceQueue(nil,
    procedure
    begin
      CaricaSkin(NomeSkin);
      dx.InitSkinChooserGalleryItem(dxSkinChooserGalleryItem);
    end);
end;

procedure TMain.CaricaSkin(ASkinName: string);
begin
  dx.SkinName := ASkinName;

  if dx.SkinActive then
  begin
   if Config.zSystem.SkinName <> ASkinName then
    Config.zSystem.SkinName := ASkinName;
   
   dxRibbonMain.ColorSchemeName := 'UserSkin';
  end
  else
  begin
    if Config.zSystem.SkinName <> '' then
      Config.zSystem.SkinName := '';
    dxRibbonMain.ColorSchemeName := 'Colorful';
  end;
end;

procedure TMain.FormResize(Sender: TObject);
begin

  if Showing then
    CenterImage;
end;

procedure TMain.InserimentoLavorativoExecute(Sender: TObject);
begin
  CreaForm(TFormInserimentoLavorativo);
end;

procedure TMain.OrarioExecute(Sender: TObject);
begin
  CreaForm(TFormOrario);
end;

procedure TMain.RegistroStudentiExecute(Sender: TObject);
begin
  CreaForm(TFormRegistroStudenti);
end;

procedure TMain.ValutazioniExecute(Sender: TObject);
begin
  CreaForm(TFormValutazioniRisorse);
end;

procedure TMain.FormShow(Sender: TObject);
begin
  InitSessioneLog;

  Config.Autorun(ModuliActions);

  if DebugHook <> 0 then
  begin
    // Orario.Execute;
    // RegistroStudenti.Execute;
    // Tirocini.Execute;
    // Questionari.Execute;
    // Risorse.Execute;
    // Aziende.Execute;
    // Progetti.Execute;
    // Riunioni.Execute;
    // FrontOffice.Execute;
    // CalendarioAule.Execute;
    // PrenotazioniAule.Execute;
    // Budget.Execute;
    // Contratti.Execute;
    // Agenda.Execute;
    // PersonaleScheda.Execute;
    // Studenti.Execute;
    // ProfilerFB.Execute;
    // ServizioInclusioneAdulti.Execute;
    // AssistenzaScolastica.Execute;
    // AccordoStatoRegioni.Execute;
    // RilevamentoOre.Execute;
    // InserimentoIncarico.Execute;
    // Risorse.Execute;
  end;

  TimerStartup.Enabled := false;
  TimerStartup.Enabled := true;
end;

procedure TMain.QuestionariExecute(Sender: TObject);
begin
  CreaForm(TFormQuestionari);
end;

procedure TMain.ExportRegioneExecute(Sender: TObject);
begin
  CreaForm(TFormExportRegione);
end;

procedure TMain.PianiIndividualiExecute(Sender: TObject);
begin
  CreaForm(TFormPianiIndividuali);
end;

procedure TMain.TirociniExecute(Sender: TObject);
begin
  CreaForm(TFormTirocini);
end;

procedure TMain.GRSExecute(Sender: TObject);
begin
  CreaForm(TFormGRS);
end;

procedure TMain.CenterImage;
var
  l, t, w, h: Integer;
begin
  w := trunc(ClientWidth * LogoProps.ImageRatioW);
  h := trunc(cxImage.Picture.Width * LogoProps.ImageRatioH);

  w := Min(w, trunc(ClientWidth * 0.8));
  h := Min(h, trunc(ClientHeight * 0.8));

  l := (ClientWidth - w) div 2;
  t := (ClientHeight - h) div 2;
  cxImage.SetBounds(l, t, w, h);

  cxImage.Visible := FormCollection.Count = 0;
end;

procedure TMain.LoadImage;
begin
  LogoProps.LoadFromIni;

  if LogoProps.ImageExists then
  begin
    cxImage.Picture.LoadFromFile(LogoProps.FileName);
    CenterImage;
  end;
end;

procedure TMain.cxImageDblClick(Sender: TObject);
begin
  // if Config.zSystem.IsAdmin then
  // Riconnessione.Execute;

  // ConfirmOk(FlushComponentDefsToLZ.ToString);

  LoadImage;
  pippo;
  // DropCollectionDuplicates;
end;

procedure TMain.InailExecute(Sender: TObject);
begin
  CreaForm(TFormInail);
end;

procedure TMain.PrenotazioniAuleExecute(Sender: TObject);
begin
  CreaForm(TFormPrenotazioniAule);
end;

procedure TMain.CalendarioDocentiExecute(Sender: TObject);
begin
  CreaForm(TFormCalendarioDocenti);
end;

procedure TMain.EntiExecute(Sender: TObject);
begin
  CreaForm(TFormEnti);
end;

{ TMain.TLogoProps }

procedure TMain.TLogoProps.Init;
begin
  FileName := '';
  // ImageRatioW := 0.50;
  // ImageRatioH := 0.706;
  ImageRatioW := 1;
  ImageRatioH := 1;
end;

procedure TMain.TLogoProps.LoadFromIni;

const
  Section = 'Application';
var
  ini: TMemIniFile;
  IniFileName: string;
begin
  Init;

  IniFileName := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'logo.ini';

  if FileExists(IniFileName) then
  begin
    ini := TMemIniFile.Create(IniFileName);
    try
      FileName := ini.ReadString(Section, 'Filename', '');
      ImageRatioW := ini.ReadFloat(Section, 'RatioW', ImageRatioW);
      ImageRatioH := ini.ReadFloat(Section, 'RatioH', ImageRatioH);
    finally
      FreeAndNil(ini);
    end;
  end;
end;

function TMain.TLogoProps.ImageExists: Boolean;
begin
  Result := FileExists(FileName);
end;

procedure TMain.actDizionariExecute(Sender: TObject);
begin
  dx.ShowSpellingOptionsDialog;
end;

procedure TMain.AuleExecute(Sender: TObject);
begin
  CreaForm(TFormAule);
end;

procedure TMain.BandiExecute(Sender: TObject);
begin
  CreaForm(TFormBandi);
end;

procedure TMain.WindowActionUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := FormCollection.Count > 0;
end;

procedure TMain.AdattaExecute(Sender: TObject);
begin
  ArrangeIcons
end;

procedure TMain.WindowCascadeExecute(Sender: TObject);
begin
  Cascade;
end;

procedure TMain.WindowCloseExecute(Sender: TObject);
begin

  if Assigned(Screen.ActiveForm) then
    if Screen.ActiveForm is TBaseForm then
      Screen.ActiveForm.Close;
end;

procedure TMain.WindowCloseAllExecute(Sender: TObject);
var
  i: Integer;
begin
  Occupato := true;
  try
    FormCollection.BeginUpdate;
    try
      for i := FormCollection.Count - 1 downto 0 do
        FormCollection.Items[i].Form.Close;
    finally
      FormCollection.EndUpdate;
    end;
  finally
    Occupato := false;
  end;
end;

procedure TMain.WindowMinimizeAllExecute(Sender: TObject);
var
  i: Integer;
begin

  for i := MDIChildCount - 1 downto 0 do
    MDIChildren[i].WindowState := wsMinimized;
end;

procedure TMain.WindowTileHorizontalExecute(Sender: TObject);
begin
  if (Self.FormStyle = fsMDIForm) and (Self.ClientHandle <> 0) then
    SendMessage(Self.ClientHandle, WM_MDITILE, MDITILE_HORIZONTAL, 0);
end;

procedure TMain.WindowTileVerticalExecute(Sender: TObject);
begin
  if (Self.FormStyle = fsMDIForm) and (Self.ClientHandle <> 0) then
    SendMessage(Self.ClientHandle, WM_MDITILE, MDITILE_VERTICAL, 0);
end;

procedure TMain.dxBarManagerBarVisibleChange(Sender: TdxBarManager; ABar: TdxBar);
begin
  dx.dxBarAssignPopupMenu(ABar, popActions);
end;

procedure TMain.popActionsPopup(Sender: TObject);
begin
  if not Config.zSystem.CanEditRestrictions then
    System.SysUtils.Abort;
end;

procedure TMain.BarApplicationMenuMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  subMenu: TdxBarSubMenuControlAccess;
  Item: TdxBarItemControl;
  barItem: TdxBarItem;
  APoint: TPoint;
  dxBarPopupMenu: TdxBarPopupMenu;
begin
  subMenu := TdxBarSubMenuControlAccess(Sender);
  Item := subMenu.ItemAtPos(Point(X, Y));

  if Assigned(Item) then
  begin
    barItem := Item.Item;

    if (Button = mbRight) and Assigned(barItem) and ((barItem is TdxBarButton) or (barItem is TdxBarLargeButton)) then
    begin
      APoint := subMenu.ClientToScreen(Point(X, Y));
      dxBarPopupMenu := TdxBarPopupMenu(subMenu.Tag);
      dxBarPopupMenu.Tag := Integer(barItem.Action);
      dxBarPopupMenu.Popup(APoint.X, APoint.Y);
      Abort;
    end;
  end;
end;

procedure TMain.AssistenzaScolasticaExecute(Sender: TObject);
begin
  CreaForm(TFormAssistenzaScolastica);
end;

procedure TMain.CalendarioAvvioCorsiExecute(Sender: TObject);
begin
  CreaForm(TFormCalendarioAvvioCorsi);
end;

procedure TMain.AttrezzatureExecute(Sender: TObject);
begin
  CreaForm(TFormAttrezzature);
end;

procedure TMain.RiunioniExecute(Sender: TObject);
begin
  CreaForm(TFormRiunioni);
end;

procedure TMain.ScadenzeExecute(Sender: TObject);
begin
  CreaForm(TFormScadenze);
end;

procedure TMain.dxBarPopupMenuPopup(Sender: TObject);
var
  i: Integer;
  MenuItem: TdxBarButton;
  pt: TPoint;
  BeginGroup: Boolean;
  PopupMenu: TPopupMenu;
begin
  pt := GetMouseCursorPos;
  pt := ActiveControl.ScreenToClient(pt);

  PopupMenu := TPopupMenu.Create(nil);
  try
    dx.PrepareSpellCheckerPopup(pt, PopupMenu);

    /// ////////////////

    for i := dxBarSubItemControlloOrtografico.ItemLinks.Count - 1 downto 0 do
    begin
      MenuItem := dxBarSubItemControlloOrtografico.ItemLinks[i].Item as TdxBarButton;
      dxBarSubItemControlloOrtografico.ItemLinks.Delete(i);
      FreeAndNil(MenuItem);
    end;

    /// ////////////////

    for i := 0 to PopupMenu.Items.Count - 1 do
    begin

      if PopupMenu.Items[i].Caption = cLineCaption then
        BeginGroup := true
      else
      begin
        MenuItem := TdxBarButton.Create(dxBarSubItemControlloOrtografico.Owner);
        dxBarSubItemControlloOrtografico.ItemLinks.Add(MenuItem).BeginGroup := BeginGroup;
        BeginGroup := false;

        MenuItem.PaintStyle := psCaptionGlyph;
        MenuItem.Caption := PopupMenu.Items[i].Caption;
        MenuItem.OnClick := PopupMenu.Items[i].OnClick;
        MenuItem.Tag := PopupMenu.Items[i].Tag;
      end;
    end;
  finally
    FreeAndNil(PopupMenu);
  end;

  dxBarSubItemControlloOrtografico.Visible := dx.Visible(dxBarSubItemControlloOrtografico.ItemLinks.Count > 0);
end;

procedure TMain.RichiesteAttivazioneExecute(Sender: TObject);
begin
  CreaForm(TFormRichiesteAttivazione);
end;

procedure TMain.SostegnoExecute(Sender: TObject);
begin
  CreaForm(TFormSostegno);
end;

procedure TMain.InterventiIntegrativiExecute(Sender: TObject);
begin
  CreaForm(TFormInterventiIntegrativi);
end;

procedure TMain.AS_RendicontazioneExecute(Sender: TObject);
begin
  CreaForm(TFormAS_Rendicontazione);
end;

procedure TMain.AbitareEmergenzaExecute(Sender: TObject);
begin
  CreaForm(TFormAbitareEmergenza);
end;

procedure TMain.AbitareSostegnoExecute(Sender: TObject);
begin
  CreaForm(TFormAbitareSostegno);
end;

procedure TMain.actDownloadAggiornamentoExecute(Sender: TObject);
begin
  Config.DownloadAggiornamento;
end;

procedure TMain.AnagraficheExecute(Sender: TObject);
begin
  CreaForm(TFormAnagrafiche);
end;

procedure TMain.AnalisiRilevamentiExecute(Sender: TObject);
begin
  CreaForm(TFormAnalisiRilevamenti);
end;

procedure TMain.AziendeExecute(Sender: TObject);
begin
  CreaForm(TFormAziende);
end;

procedure TMain.CandidatureExecute(Sender: TObject);
begin
  CreaForm(TFormCandidature);
end;

procedure TMain.DiarioSocialeExecute(Sender: TObject);
begin
  CreaForm(TFormDiarioSociale);
end;

procedure TMain.FrontOfficeExecute(Sender: TObject);
begin
  CreaForm(TFormFrontOffice);
end;

procedure TMain.OrientamentoExecute(Sender: TObject);
begin
  CreaForm(TFormOrientamento);
end;

procedure TMain.ServiziAlLavoroExecute(Sender: TObject);
begin
  CreaForm(TFormServiziAlLavoro);
end;

procedure TMain.dxUIAdornerManager1BadgeClick(AManager: TdxUIAdornerManager; AAdorner: TdxCustomAdorner);
begin
  Notifiche.Execute;
end;

procedure TMain.MostraBadgeNotifiche(const NumeroNotificheNonLette: Integer);
begin

  if Notifiche.Visible then
  begin
    dxUIAdornerManager1Badge.Text := NumeroNotificheNonLette.ToString;
    dxUIAdornerManager1Badge.Visible := NumeroNotificheNonLette > 0;
  end;
end;

procedure TMain.NotificheExecute(Sender: TObject);
begin
  CreaForm(TFormNotifiche);
end;

procedure TMain.TimerStartupTimer(Sender: TObject);
begin
  TimerStartup.Enabled := false;

  Config.Startup;

  InitTaskBar;
end;

procedure TMain.ApplyModuli;
var
  i: Integer;
  Action: TBasicAction;
begin
  Config.RegisterModuli(ModuliActions);

  for i := 0 to dxBarManager.ItemCount - 1 do
    if dxBarManager.Items[i] is TdxBarLargeButton then
    begin
      Action := TdxBarLargeButton(dxBarManager.Items[i]).Action;

      TdxBarLargeButton(dxBarManager.Items[i]).AutoGrayScale := not TdxBarLargeButton(dxBarManager.Items[i]).AutoGrayScale;

      if Assigned(Action) then
        if Action is TContainedAction then
          if TContainedAction(Action).ActionList = ModuliActions then
          begin
            //
            case Config.GetStatoAttivazione(Action.Name) of
              saUnknown:
                dxBarManager.Items[i].Style := nil;
              saAttivo:
                dxBarManager.Items[i].Style := nil;
              saNonAttivo:
                dxBarManager.Items[i].Style := cxStyleNonAbilitato;
              saValutazione:
                dxBarManager.Items[i].Style := cxStyleValutazione;
              saSviluppo:
                dxBarManager.Items[i].Style := cxStyleInSviluppo;
            end;
          end;
    end;
end;

procedure TMain.ModuliActionsExecute(Action: TBasicAction; var Handled: Boolean);
begin
  Handled := not Config.CheckModulo(Action.Name, TContainedAction(Action).Caption);
end;

procedure TMain.actPermessiAzioneExecute(Sender: TObject);
var
  Action: TCustomAction;
begin
  Action := TCustomAction(popActions.Tag);

  if Assigned(Action) then
    RestrictionManager.EditComponentRestrictions('Main', ccAction, Action.Name);
end;

procedure TMain.actStatoAttivazioneModuloExecute(Sender: TObject);
var
  Action: TCustomAction;
begin
  Action := TCustomAction(popActions.Tag);

  if Assigned(Action) then
  begin
    Config.ModificaStatoAttivazioneModulo(Action.Name);
    ApplyModuli;
  end;
end;

procedure TMain.CalendarioAuleExecute(Sender: TObject);
begin
  CreaForm(TFormCalendarioAule);
end;

procedure TMain.ContrattiExecute(Sender: TObject);
begin
  CreaForm(TFormContratti);
end;

procedure TMain.FbExpertExecute(Sender: TObject);
begin
  CreaForm(TFormFbExpert);
end;

procedure TMain.MonitorFireDACExecute(Sender: TObject);
begin
  Config.EditMonitorProps;
end;

procedure TMain.ServizioInclusioneAdultiExecute(Sender: TObject);
begin
  CreaForm(TFormSIA_ServizioInclusioneAdulti);
end;

procedure TMain.AssistentiSocialiExecute(Sender: TObject);
begin
  CreaForm(TFormAssistentiSociali);
end;

procedure TMain.ConfigurazioneLogExecute(Sender: TObject);
var
  dlg: TdxOpenFileDialog;
begin

  dlg := TdxOpenFileDialog.Create(nil);
  try
    dlg.Options := dlg.Options + [ofOverwritePrompt];
    dlg.DefaultExt := 'sil';
    dlg.Filter := 'sil|*.sil';
    dlg.InitialDir := Config.zSystem.ConfigFolder;

    if dlg.Execute then
      Si.LoadConfiguration(dlg.FileName);
  finally
    FreeAndNil(dlg);
  end;
end;

procedure TMain.AttivitaFuoriSedeExecute(Sender: TObject);
begin
  CreaForm(TFormAttivitaFuoriSede);
end;

procedure TMain.FormazioneInternaExecute(Sender: TObject);
begin
  CreaForm(TFormFormazioneInterna);
end;

procedure TMain.TimesheetExecute(Sender: TObject);
begin
  CreaForm(TFormTimesheet);
end;

procedure TMain.pippo;
var
  ProgressBox: TProgressBox;

  // oldDomains: zSystem_OLD.TzDomains;
  // oldDomain: zSystem_OLD.TzDomain;
  //
  // newDomain: zSystem.TzDomain;
  lookup: TzLookup;
  i: TObject;

  procedure CloneToolsDefsToGestyFilterDefs;
  const
    cFrom = 'GestyFilterDefs.';
    cTo = 'Tools.';
    // helper generico su una singola collection (zDbViews / zDbCards / zDbPivots)

    procedure ProcessCollection(Coll: TzCustomCollection); // <-- tipo da confermare
    var
      i, idx: Integer;
      Src, Dst: TzCollectionItem; // <-- tipo item da confermare
      DstName: string;
    begin
      // copia degli item perch  potremmo iterare e basta (non aggiungiamo nuovi)
      for i := 0 to Coll.Count - 1 do
      begin
        Src := Coll.Items[i] as TzCollectionItem;

        if Src.Name.StartsWith('Tools.') then
        begin
          DstName := Src.Name.Replace('Tools.', 'GestyFilterDefs.', [rfIgnoreCase]);

          idx := Coll.IndexOf(DstName);

          if idx <> -1 then
          begin
            Dst := Coll.Items[idx] as TzCollectionItem;
            Dst.assign(Src);
            Dst.Name := DstName;

            if Dst is TzDbViewProps then
              TzDbViewProps(Dst).DataSet := DstName
            else
              if Dst is TzDbCardProps then
                TzDbCardProps(Dst).DataSet := DstName;
          end;
        end;
      end;
    end;

  begin
    ProcessCollection(base.zDataSets);
    ProcessCollection(base.zDbViews);
    ProcessCollection(base.zDbCards);
    base.SaveZip(csAll, 'tools');
  end;

begin

  // CloneToolsDefsToGestyFilterDefs;
  // salvaimageList;
  // ProgressBox := TProgressBox.Create(nil);
  // try
  // // /// //////////////////////////////////////////////////////////////////////
  // oldDomains := zSystem_OLD.TzDomains.Create(TzDomain, 'DataDictionary', -1, nil, False);
  // try
  // oldDomains.LoadFromFile('C:\Users\Luca\Desktop\TzDomains.dfm');
  //
  // ProgressBox.Show(oldDomains.Count, 'DefaultExpression', 'DefaultExpression', 'True');
  // try
  // for oldDomain in oldDomains do
  // begin
  // ProgressBox.IncProgress(oldDomain.Name);
  //
  // newDomain := zSystem.base.zDataDictionary.Get(oldDomain.Name, False);
  //
  // if newDomain <> nil then
  // begin
  // if newDomain.ReadOnly <> oldDomain.ReadOnly then
  // newDomain.ReadOnly := oldDomain.ReadOnly;
  //
  // if newDomain.Required <> oldDomain.Required then
  // newDomain.Required := oldDomain.Required;
  // end;
  // end;
  //
  // zSystem.base.SaveZip(zSystem.csAll, 'old domains');
  // finally
  // ProgressBox.Close;
  // end;
  // finally
  // FreeAndNil(oldDomains);
  // end;

  // ProgressBox.Show(base.zLookups.Count, 'zLookups', 'zLookups', 'True');
  // try
  // for lookup in base.zLookups do
  // begin
  // ProgressBox.IncProgress(lookup.Name);
  //
  // if lookup.KeyField.Contains(';') then
  // begin
  // // Edit_CollectionItem(base, lookup);
  // lookup.KeyField := lookup.KeyField.Substring(0, lookup.KeyField.IndexOf(';'));
  // DisplayColumns
  // lookup.SearchFields := lookup.KeyField;
  // zLookup.DisplayColumns := zLookup.FieldNamesFK;
  // end;
  // end;
  //
  // base.SaveZip(csAll, 'DefaultExpression');
  // finally
  // ProgressBox.Close;
  // end;
  /// //////////////////////////////////////////////////////////////////////
  // finally
  // FreeAndNil(ProgressBox);
  // end;
end;

procedure TMain.InitTips;
  procedure AssignButtonTip(const actionName: string; tip: TdxScreenTip);
  var
    i: Integer;
    dxBarItem: TdxBarItem;
  begin

    for i := 0 to dxBarManager.ItemCount - 1 do
      if dxBarManager.Items[i] is TdxBarItem then
      begin
        dxBarItem := dxBarManager.Items[i] as TdxBarItem;

        if Assigned(dxBarItem.Action) then
          if sameText(dxBarItem.Action.Name, actionName) then
            dxBarItem.ScreenTip := tip;
      end;
  end;

var
  Action: TContainedAction;
  tip: TdxScreenTip;
  ztip: TzTip;
begin

  if false then
    if DebugHook = 0 then
      Exit;

  base.zTips.LoadFromActionList(name, ModuliActions);
  // base.SaveZip(csTips, 'Tips');
  dxScreenTipRepository.Items.Clear;

  for ztip in base.zTips do
    if sameText(ztip.FormName, name) then
    begin
      tip := dxScreenTipRepository.Items.Add;
      tip.Name := 'tip' + ztip.Name;

      tip.Header.Text := ztip.HeaderText;
      tip.Description.Text := ztip.Description;

      AssignButtonTip(ztip.Name, tip);
    end;
end;

procedure TMain.actTipExecute(Sender: TObject);
var
  Action: TCustomAction;
  ztip: TzTip;
begin
  Action := TCustomAction(popActions.Tag);

  if Assigned(Action) then
  begin
    ztip := base.zTips.Get(Action.Name, true);

    if ztip.Inspect then
    begin
      base.SaveZip(csTips, 'Tips');
      InitTips;
    end;
  end;
end;

procedure TMain.InitTaskBar;
begin
  try
    Taskbar := TzTaskbar.Create(Self);
    Taskbar.Name := 'Taskbar';

    TaskbarManager.Taskbar := Taskbar;
  except
    FreeAndNil(Taskbar);
  end;
end;

procedure TMain.MonitorFBExecute(Sender: TObject);
begin
  CreaForm(TFormFbMonitor);
end;

procedure TMain.ProfilerFBExecute(Sender: TObject);
begin
  CreaForm(TFormFbProfiler);
end;

procedure TMain.RiconnessioneExecute(Sender: TObject);
begin

  if ConfirmOkCancel('Si desidera riavviare la connessione al database?') then
    Login.Execute;
end;

procedure TMain.BaseWebExecute(Sender: TObject);
begin
  CreaForm(TFormBaseWeb);
end;

procedure TMain.AttestatiExecute(Sender: TObject);
begin
  CreaForm(TFormAttestati);
end;

procedure TMain.AccordoStatoRegioniExecute(Sender: TObject);
begin
  CreaForm(TFormAccordoStatoRegioni);
end;

procedure TMain.CruscottoDocumentaleExecute(Sender: TObject);
begin
  CreaForm(TFormDocumentazioneCruscotto);
end;

procedure TMain.FirmaDocumentiExecute(Sender: TObject);
begin
  CreaForm(TFormDocumentazioneFirmaElettronica);
end;

procedure TMain.RegistroMessaggiExecute(Sender: TObject);
begin
  CreaForm(TFormDocumentazioneMessaggiRegistro);
end;

procedure TMain.RegistroConservazioneExecute(Sender: TObject);
begin
  CreaForm(TFormDocumentazioneConservazione);
end;

procedure TMain.RegistroFirmaExecute(Sender: TObject);
begin
  CreaForm(TFormDocumentazioneRegistroFirme);
end;

procedure TMain.RegistroProtocolloExecute(Sender: TObject);
begin
  CreaForm(TFormDocumentazioneRegistroProtocollo);
end;

procedure TMain.salvaimageList;
var
  NomeFileTesto, DirDestinazione: string;
  Riga: string;
  ImageIndex: Integer;
  Bitmap: TBitmap;
  Parti: TArray<string>;
  PathImmagine: string;
begin

  Exit;

  NomeFileTesto := 'C:\Users\Luca\Desktop\GUI\gesty\_Sorgenti\__OUTPUT\report_contatori.txt';
  DirDestinazione := 'C:\Users\Luca\Desktop\GUI\bmp usate';
  // Controllo esistenza file con TFile
  if not TFile.Exists(NomeFileTesto) then
    raise EFileNotFoundException.Create('File sorgente non trovato.');

  // Creazione cartella con TDirectory (gestisce ricorsivamente la creazione)
  if not TDirectory.Exists(DirDestinazione) then
    TDirectory.CreateDirectory(DirDestinazione);

  Bitmap := TBitmap.Create;
  try
    // Leggiamo tutte le righe in un ciclo for-in usando TFile
    for Riga in TFile.ReadAllLines(NomeFileTesto) do
      if Riga.StartsWith('ImageIndex') then
      begin
        if Riga.Trim.IsEmpty then
          Continue;

        // Parsing: dividiamo la riga per spazi
        Parti := Riga.Split([' '], TStringSplitOptions.ExcludeEmpty);

        // Verifichiamo che ci sia almeno "ImageIndex" e il numero
        if (Length(Parti) >= 2) and TryStrToInt(Parti[1], ImageIndex) then
        begin
          if (ImageIndex >= 0) and (ImageIndex < zDmImages.ImageList24.Count) then
          begin
            // Prepariamo il bitmap
            Bitmap.SetSize(zDmImages.ImageList24.Width, zDmImages.ImageList24.Height);

            // Pulizia sfondo (importante per TBitmap)
            Bitmap.Canvas.Brush.Color := clWhite;
            Bitmap.Canvas.FillRect(Rect(0, 0, Bitmap.Width, Bitmap.Height));

            // Estrazione immagine da cxImageList
            zDmImages.ImageList24.GetImage(ImageIndex, Bitmap);

            // Costruzione percorso sicuro con TPath
            PathImmagine := TPath.Combine(DirDestinazione, Format('Img_%d.bmp', [ImageIndex]));

            Bitmap.SaveToFile(PathImmagine);
          end;
        end;
      end;
  finally
    Bitmap.Free;
  end;
end;

procedure TMain.AttivaLogExecute(Sender: TObject);
begin
  // Una sola voce: la prima pressione avvia la registrazione, la seconda
  // chiude i file e apre il ticket su Mantis.
  SessioneLog.Commuta;
end;

procedure TMain.InitSessioneLog;
begin
  SessioneLog.CategoriaMantis := 'LOG'; // deve esistere nel progetto Mantis
  SessioneLog.SogliaOperazioneLentaMs := 300; // soglia oltre la quale l'evento va anche nel log testuale
  // Oltre, la registrazione si chiude da sola. Vale per .sil e .log insieme:
  // zippati diventano 2-3 MB, sotto il limite predefinito degli allegati Mantis.
  SessioneLog.DimensioneMassimaMb := 40;
  SessioneLog.DurataMassimaMinuti := 120;
  SessioneLog.OnStatoCambiato := StatoLogCambiato;
  StatoLogCambiato(Self);
  SessioneLog.VerificaSessioneInterrotta;
end;

procedure TMain.SegnalibroLogExecute(Sender: TObject);
begin
  SessioneLog.InserisciSegnalibro;
end;

procedure TMain.RegistraDalProssimoAvvioExecute(Sender: TObject);
begin
  // Una sola voce: la prima pressione chiede la registrazione per il prossimo
  // avvio, la seconda annulla la richiesta. La registrazione vera la avvia il
  // .dpr (SessioneLog.AvviaAllAvvio) alla prossima apertura.
  SessioneLog.CommutaRichiestaAvvio;
end;

procedure TMain.TicketAssistenzaExecute(Sender: TObject);
begin
  // Richieste di assistenza aperte da questo utente: stato, risposte
  // pubbliche, note e allegati (zMantis.TicketAssistenza.form).
  Config.MostraTicketAssistenza;
end;

procedure TMain.StatoLogCambiato(Sender: TObject);
begin
  // Visibile solo dove Mantis e' configurato: senza i parametri il log si
  // registrerebbe senza avere un posto dove mandarlo, e l'utente resterebbe
  // con due file su disco e nessuna istruzione. Il contenitore si governa
  // qui; le due voci dentro seguono da sole le azioni a cui sono agganciate.
  // Il sottomenu Assistenza compare se c'e' almeno una delle sue funzioni:
  // la registrazione di sessione o "Le mie segnalazioni", che esiste solo
  // quando Mantis e' configurato e il registro locale e' stato creato.
  dxBarSubItemAssistenza.Visible := dx.Visible(SessioneLog.Disponibile or Config.TicketAssistenzaDisponibile);
  TicketAssistenza.Visible := Config.TicketAssistenzaDisponibile;
  AttivaLog.Visible := SessioneLog.Disponibile;
  SegnalibroLog.Visible := SessioneLog.Disponibile;
  RegistraDalProssimoAvvio.Visible := SessioneLog.Disponibile;

  AttivaLog.Caption := SessioneLog.DidascaliaVoceMenu;
  AttivaLog.Hint := SessioneLog.SuggerimentoVoceMenu;
  // Segnale visibile che la registrazione e' in corso: il pulsante e' a
  // spunta (bsChecked) e segue Checked dell'azione. Mentre e' attiva
  // l'applicazione risulta piu' lenta e l'utente deve saperlo.
  AttivaLog.Checked := SessioneLog.Attiva;

  // Stesso criterio per la richiesta dal prossimo avvio: la spunta dice che
  // alla prossima apertura la registrazione partira' da sola.
  RegistraDalProssimoAvvio.Caption := SessioneLog.DidascaliaVoceAvvio;
  RegistraDalProssimoAvvio.Hint := SessioneLog.SuggerimentoVoceAvvio;
  RegistraDalProssimoAvvio.Checked := SessioneLog.RichiestaAvvioPresente;
end;

procedure TMain.CoGe_BilancioExecute(Sender: TObject);
begin
  CreaForm(TFormCoge_Bilancio);
end;

procedure TMain.CoGe_ConfigurazioneExecute(Sender: TObject);
begin
  CreaForm(TFormCOGE_Configurazione);
end;

procedure TMain.CoGe_DocumentiExecute(Sender: TObject);
begin
  CreaForm(TFormCOGE_Documenti);
end;

procedure TMain.CoGe_FattureElettronicheExecute(Sender: TObject);
begin
  CreaForm(TFormCOGE_FattureElettroniche);
end;

procedure TMain.CoGe_Gateway_ContabileExecute(Sender: TObject);
begin

  CreaForm(TFormCOGE_Gateway_Contabile);
end;

procedure TMain.CoGe_IncassiExecute(Sender: TObject);
begin
  CreaForm(TFormCOGE_Incassi);
end;

procedure TMain.CoGe_RegistrazioniExecute(Sender: TObject);
begin
  CreaForm(TFormCOGE_Registrazioni);
end;

procedure TMain.CoGe_SoggettiExecute(Sender: TObject);
begin
  CreaForm(TFormCOGE_Soggetti);
end;


procedure TMain.actAIExecute(Sender: TObject);
const
  // Icone in dx.Immagini: scintilla monocromatica (spento) e colorata (acceso)
  ICONA_CHAT_SPENTA = 'assistente_ai_spento';
  ICONA_CHAT_ACCESA = 'assistente_ai_acceso';
begin

  // Creazione pigra: il pannello nasce alla prima richiesta
  if FChatAI = nil then
  begin
    FChatAI := TzChatAIPane.Create(Self);
    FChatAI.Parent := Self;
    FChatAI.ToggleAction := actAI;   // il pannello sincronizza Checked e icona
    FChatAI.OpenedImageIndex := dx.IndiceIcona(ICONA_CHAT_ACCESA);
    FChatAI.ClosedImageIndex := dx.IndiceIcona(ICONA_CHAT_SPENTA);
  end;

  FChatAI.Toggle;
end;

procedure TMain.actAIUpdate(Sender: TObject);
begin
 TAction(Sender).Visible := Config.zSystem.Authorizhed(Gesty_Authorizations.AI_UTILIZZO);
end;

end.
