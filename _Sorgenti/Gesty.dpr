// JCL_DEBUG_EXPERT_INSERTJDBG ON
// JCL_DEBUG_EXPERT_GENERATEJDBG ON
// JCL_DEBUG_EXPERT_DELETEMAPFILE ON
// in caso di errore su firedac: FireDAC.Phys.IBWrapper in 'X:\Druido\LIB\Patch\FireDAC.Phys.IBWrapper',

// per la corretta gestione degli SVG
// frxPNGGraphics,
// frxSVGGraphics,
// dxGDIPlusAPI,

program Gesty;

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.HtmlHelpViewer,
  Vcl.StdCtrls,
  vcl.Consts in 'vcl.Consts.pas',
  PBJustOne,
  frPNGGraphics,
  frSVGGraphics,
  dxGDIPlusAPI,
  zDiagnostica.Log,
  cxLookAndFeels,
  FireDAC.Phys.IBWrapper in 'FireDAC.Phys.IBWrapper.pas',
  dxSpreadSheetReportDesigner in 'X:\Druido\LIB\dxSpreadSheetReportDesigner.pas',
  zBaseLib,
  zSystem,
  zz.SplashWait,
  MDI_Lib in 'BASE\MDI_Lib.pas',
  Files.Lib in 'Varie\Files.Lib.pas',
  Gesty_StoredProcs in 'Gesty_StoredProcs.pas',
  Init_Controls in 'BASE\Init_Controls.pas',
  Base_DataModule in 'BASE\Base_DataModule.pas' {BaseDataModule: TDataModule},
  BaseFrm in 'BASE\BaseFrm.pas' {BaseForm},
  Base_Frame in 'BASE\Base_Frame.pas' {BaseFrame: TFrame},
  BaseWizrd in 'BASE\BaseWizrd.pas' {BaseWizard},
  zHyperLinks in 'BASE\zHyperLinks.pas',
  ConfigModule in 'BASE\ConfigModule.pas' {Config: TDataModule},
  zStorage,
  dmAgenda in 'DataModules\dmAgenda.pas' {Agenda: TDataModule},
  dmProgetti in 'DataModules\dmProgetti.pas' {Progetti: TDataModule},
  dmDocentiRiepilogoOre in 'DataModules\dmDocentiRiepilogoOre.pas' {DocentiRiepilogoOre: TDataModule},
  dmStudenti in 'DataModules\dmStudenti.pas' {Studenti: TDataModule},
  dmTabelle in 'DataModules\dmTabelle.pas' {Tabelle: TDataModule},
  dmCartellaProgetto in 'DataModules\dmCartellaProgetto.pas' {CartellaProgetto: TDataModule},
  frmAgenda in 'dbForms\frmAgenda.pas' {FormAgenda},
  frmProgetti in 'dbForms\frmProgetti.pas' {FormProgetti},
  frmStudenti in 'dbForms\frmStudenti.pas' {FormStudenti},
  frmTabelle in 'dbForms\frmTabelle.pas' {FormTabelle},
  frmCartellaProgetto in 'dbForms\frmCartellaProgetto.pas' {FormCartellaProgetto},
  dmGestioneUtenti in 'DataModules\dmGestioneUtenti.pas' {GestioneUtenti: TDataModule},
  frmGestioneUtenti in 'dbForms\frmGestioneUtenti.pas' {FormGestioneUtenti},
  dmRilevamentoOre in 'DataModules\dmRilevamentoOre.pas' {RilevamentoOre: TDataModule},
  WizInserimentoIncaricoDM in 'DataModules\WizInserimentoIncaricoDM.pas' {WizInserimentoIncarico: TDataModule},
  WizNuovaRichiestaAttivazioneDM in 'DataModules\WizNuovaRichiestaAttivazioneDM.pas' {WizNuovaRichiestaAttivazione: TDataModule},
  frmRilevamentoOre in 'dbForms\frmRilevamentoOre.pas' {FormRilevamentoOre},
  WizInserimentoIncaricoFrm in 'dbForms\WizInserimentoIncaricoFrm.pas' {WizInserimentoIncaricoForm},
  WizNuovaRichiestaAttivazioneFrm in 'dbForms\WizNuovaRichiestaAttivazioneFrm.pas' {WizNuovaRichiestaAttivazioneForm},
  dmPersonaleScheda in 'DataModules\dmPersonaleScheda.pas' {PersonaleScheda: TDataModule},
  frmPersonaleScheda in 'dbForms\frmPersonaleScheda.pas' {FormPersonaleScheda},
  frmParametriProtocolloIncarico in 'Varie\frmParametriProtocolloIncarico.pas' {FormParametriProtocolloIncarico},
  dmPersonalePresenze in 'DataModules\dmPersonalePresenze.pas' {PersonalePresenze: TDataModule},
  frmPersonalePresenze in 'dbForms\frmPersonalePresenze.pas' {FormPersonalePresenze},
  WizInserimentoPianiPersonalizzatiFrm in 'dbForms\WizInserimentoPianiPersonalizzatiFrm.pas' {WizInserimentoPianiPersonalizzatiForm},
  WizInserimentoPianiPersonalizzatiDM in 'DataModules\WizInserimentoPianiPersonalizzatiDM.pas' {WizInserimentoPianiPersonalizzati: TDataModule},
  dmRisorse in 'DataModules\dmRisorse.pas' {Risorse: TDataModule},
  frmRisorse in 'dbForms\frmRisorse.pas' {FormRisorse},
  HelpGen.Editor in 'BASE\HelpGen\HelpGen.Editor.pas' {HelpGenEditor},
  HelpGen.Response.classes in 'BASE\HelpGen\HelpGen.Response.classes.pas',
  HelpGen.Generator in 'BASE\HelpGen\HelpGen.Generator.pas',
  HelpGen.descriptor in 'BASE\HelpGen\HelpGen.descriptor.pas',
  HelpGen.Request.classes in 'BASE\HelpGen\HelpGen.Request.classes.pas',
  HelpGen.types in 'BASE\HelpGen\HelpGen.types.pas',
  HelpGen.config in 'BASE\HelpGen\HelpGen.config.pas',
  HelpGen.HelpCompiler in 'BASE\HelpGen\HelpGen.HelpCompiler.pas',
  zHelp.form in 'BASE\zHelp.form.pas',
  WizInserimentoStudenteDM in 'DataModules\WizInserimentoStudenteDM.pas' {WizInserimentoStudente: TDataModule},
  WizInserimentoStudenteFrm in 'dbForms\WizInserimentoStudenteFrm.pas' {WizInserimentoStudenteForm},
  dmStudentiRilevamentoPresenzeAssenze in 'DataModules\dmStudentiRilevamentoPresenzeAssenze.pas' {StudentiRilevamentoPresenzeAssenze},
  dmPagamenti in 'DataModules\dmPagamenti.pas' {Pagamenti},
  frmPagamenti in 'dbForms\frmPagamenti.pas' {FormPagamenti},
  frmStudentiRilevamentoPresenzeAssenze in 'dbForms\frmStudentiRilevamentoPresenzeAssenze.pas' {FormStudentiRilevamentoPresenzeAssenze},
  dmOrario in 'DataModules\dmOrario.pas' {Orario},
  frmOrario in 'dbForms\frmOrario.pas' {FormOrario},
  dmInserimentoLavorativo in 'DataModules\dmInserimentoLavorativo.pas' {InserimentoLavorativo: TDataModule},
  frmInserimentoLavorativo in 'dbForms\frmInserimentoLavorativo.pas' {FormInserimentoLavorativo},
  dmRicercaProfili in 'DataModules\dmRicercaProfili.pas' {RicercaProfili: TDataModule},
  frmRicercaProfili in 'dbForms\frmRicercaProfili.pas' {FormRicercaProfili},
  frmStudentiRilevamentoAttivitaIndividuali in 'Varie\frmStudentiRilevamentoAttivitaIndividuali.pas' {FormStudentiRilevamentoAttivitaIndividuali},
  dmRegistroStudenti in 'DataModules\dmRegistroStudenti.pas' {RegistroStudenti: TDataModule},
  frmRegistroStudenti in 'dbForms\frmRegistroStudenti.pas' {FormRegistroStudenti},
  RegistroStudentiCollettiva.Classes in 'Varie\RegistroStudentiCollettiva.Classes.pas',
  frame_RegistroCollettivo in 'frames\frame_RegistroCollettivo.pas' {FrameRegistroCollettivo: T},
  ValutazioniPrestazioni.classi in 'Varie\ValutazioniPrestazioni.classi.pas',
  ValutazioniPrestazioni.types in 'Varie\ValutazioniPrestazioni.types.pas',
  dmValutazioniRisorse in 'DataModules\dmValutazioniRisorse.pas' {ValutazioniRisorse: TDataModule},
  frmValutazioniRisorse in 'dbForms\frmValutazioniRisorse.pas' {FormValutazioniRisorse},
  WizNuovaAziendaOspitanteDM in 'DataModules\WizNuovaAziendaOspitanteDM.pas' {WizNuovaAziendaOspitante: TDataModule},
  WizNuovaAziendaOspitanteFrm in 'dbForms\WizNuovaAziendaOspitanteFrm.pas' {WizNuovaAziendaOspitanteForm},
  dmQuestionari in 'DataModules\dmQuestionari.pas' {Questionari: TDataModule},
  frmQuestionari in 'dbForms\frmQuestionari.pas' {FormQuestionari},
  dmExportRegione in 'DataModules\dmExportRegione.pas' {ExportRegione: TDataModule},
  dmTirocini in 'DataModules\dmTirocini.pas' {Tirocini: TDataModule},
  dmPianiIndividuali in 'DataModules\dmPianiIndividuali.pas' {PianiIndividuali: TDataModule},
  WizTirociniDM in 'DataModules\WizTirociniDM.pas' {WizTirocini: TDataModule},
  frmExportRegione in 'dbForms\frmExportRegione.pas' {FormExportRegione},
  frmTirocini in 'dbForms\frmTirocini.pas' {FormTirocini},
  frmPianiIndividuali in 'dbForms\frmPianiIndividuali.pas' {FormPianiIndividuali},
  WizTirociniFrm in 'dbForms\WizTirociniFrm.pas' {WizTirociniForm},
  dmAllegati in 'DataModules\dmAllegati.pas' {Allegati: TDataModule},
  frmAllegati in 'dbForms\frmAllegati.pas' {FormAllegati},
  frmRegistraPresenzeTirocini in 'Varie\frmRegistraPresenzeTirocini.pas' {FormRegistraPresenzeTirocini},
  Gesty.Types in 'Varie\Gesty.Types.pas',
  dmGRS in 'DataModules\dmGRS.pas' {GRS: TDataModule},
  frmGRS in 'dbForms\frmGRS.pas' {FormGRS},
  frmInail in 'dbForms\frmInail.pas' {FormInail},
  dmInail in 'DataModules\dmInail.pas' {Inail: TDataModule},
  dmPrenotazioniAule in 'DataModules\dmPrenotazioniAule.pas' {PrenotazioniAule},
  frmPrenotazioniAule in 'dbForms\frmPrenotazioniAule.pas' {FormPrenotazioniAule},
  frmPrenotaAulaDaAgenda in 'dbForms\frmPrenotaAulaDaAgenda.pas' {FormPrenotaAulaDaAgenda},
  CalendarioCorsi.classes in 'Varie\CalendarioCorsi.classes.pas',
  Frame_CalendarioDocenti in 'frames\Frame_CalendarioDocenti.pas' {FrameCalendarioDocenti: TFrame},
  dmCalendarioDocenti in 'DataModules\dmCalendarioDocenti.pas' {CalendarioDocenti: TDataModule},
  CalendarioDocenti.classes in 'Varie\CalendarioDocenti.classes.pas',
  frmCalendarioDocenti in 'dbForms\frmCalendarioDocenti.pas' {FormCalendarioDocenti},
  dmEnti in 'DataModules\dmEnti.pas' {Enti: TDataModule},
  frmEnti in 'dbForms\frmEnti.pas' {FormEnti},
  dmAule in 'DataModules\dmAule.pas' {Aule: TDataModule},
  frmAule in 'dbForms\frmAule.pas' {FormAule},
  dmBandi in 'DataModules\dmBandi.pas' {Bandi: TDataModule},
  frmBandi in 'dbForms\frmBandi.pas' {FormBandi},
  RiepilogoGiornalieroAule.classes in 'Varie\RiepilogoGiornalieroAule.classes.pas',
  frame_RiepilogoGiornalieroAule in 'frames\frame_RiepilogoGiornalieroAule.pas' {FrameRiepilogoGiornalieroAule: TFrame},
  MainForm in 'MainForm.pas' {Main},
  dmCalendarioAvvioCorsi in 'DataModules\dmCalendarioAvvioCorsi.pas' {CalendarioAvvioCorsi: TDataModule},
  frmCalendarioAvvioCorsi in 'dbForms\frmCalendarioAvvioCorsi.pas' {FormCalendarioAvvioCorsi},
  dmRiunioni in 'DataModules\dmRiunioni.pas' {Riunioni: TDataModule},
  WizRiunioniDM in 'DataModules\WizRiunioniDM.pas' {WizRiunioni: TDataModule},
  frmRiunioni in 'dbForms\frmRiunioni.pas' {FormRiunioni},
  WizRiunioniFrm in 'dbForms\WizRiunioniFrm.pas' {WizRiunioniForm},
  dmScheduler.Tools in 'DataModules\dmScheduler.Tools.pas' {SchedulerTools: TDataModule},
  Gesty.Scheduler in 'Varie\Gesty.Scheduler.pas',
  CalendarioEsterno.Types in 'Varie\CalendarioEsterno.Types.pas',
  OAuth2.AccessoDesktop in 'Varie\OAuth2.AccessoDesktop.pas',
  MicrosoftGraph.Autorizzazione in 'Varie\MicrosoftGraph.Autorizzazione.pas',
  MicrosoftGraph.Calendario in 'Varie\MicrosoftGraph.Calendario.pas',
  GoogleCalendar.Autorizzazione in 'Varie\GoogleCalendar.Autorizzazione.pas',
  GoogleCalendar.Calendario in 'Varie\GoogleCalendar.Calendario.pas',
  CalendarioEsterno.Microsoft in 'Varie\CalendarioEsterno.Microsoft.pas',
  CalendarioEsterno.Google in 'Varie\CalendarioEsterno.Google.pas',
  Gesty.CalendarioEsterno in 'Varie\Gesty.CalendarioEsterno.pas',
  dmScadenze in 'DataModules\dmScadenze.pas' {Scadenze: TDataModule},
  frmScadenze in 'dbForms\frmScadenze.pas' {FormScadenze},
  frmGeneraCalendarioStage in 'Varie\frmGeneraCalendarioStage.pas' {FormGeneraCalendarioStage},
  dmAttrezzature in 'DataModules\dmAttrezzature.pas' {Attrezzature: TDataModule},
  frmAttrezzature in 'dbForms\frmAttrezzature.pas' {FormAttrezzature},
  Excel_FoglioDiCalcoloXML2003 in 'Varie\Excel_FoglioDiCalcoloXML2003.pas',
  dmBudget in 'DataModules\dmBudget.pas' {Budget: TDataModule},
  frmBudget in 'dbForms\frmBudget.pas' {FormBudget},
  dmRichiesteAttivazione in 'DataModules\dmRichiesteAttivazione.pas' {RichiesteAttivazione: TDataModule},
  frmRichiesteAttivazione in 'dbForms\frmRichiesteAttivazione.pas' {FormRichiesteAttivazione},
  Questionari.Report in 'Varie\Questionari.Report.pas',
  dmSostegno in 'DataModules\dmSostegno.pas' {Sostegno: TDataModule},
  dmInterventiIntegrativi in 'DataModules\dmInterventiIntegrativi.pas' {InterventiIntegrativi: TDataModule},
  frmSostegno in 'dbForms\frmSostegno.pas' {FormSostegno},
  frmInterventiIntegrativi in 'dbForms\frmInterventiIntegrativi.pas' {FormInterventiIntegrativi},
  dmAssistenzaScolastica in 'DataModules\dmAssistenzaScolastica.pas' {AssistenzaScolastica: TDataModule},
  frmAssistenzaScolastica in 'dbForms\frmAssistenzaScolastica.pas' {FormAssistenzaScolastica},
  dmAS_Rendicontazione in 'DataModules\dmAS_Rendicontazione.pas' {AS_Rendicontazione: TDataModule},
  frmAS_Rendicontazione in 'dbForms\frmAS_Rendicontazione.pas' {FormAS_Rendicontazione},
  dmDiarioSociale in 'DataModules\dmDiarioSociale.pas' {DiarioSociale: TDataModule},
  frmDiarioSociale in 'dbForms\frmDiarioSociale.pas' {FormDiarioSociale},
  dmAnalisiRilevamenti in 'DataModules\dmAnalisiRilevamenti.pas' {AnalisiRilevamenti: TDataModule},
  frmAnalisiRilevamenti in 'dbForms\frmAnalisiRilevamenti.pas' {FormAnalisiRilevamenti},
  dmFrontOffice in 'DataModules\dmFrontOffice.pas' {FrontOffice: TDataModule},
  frmFrontOffice in 'dbForms\frmFrontOffice.pas' {FormFrontOffice},
  Comunicazioni.Modelli in 'Varie\Comunicazioni.Modelli.pas',
  dmOrientamento in 'DataModules\dmOrientamento.pas' {Orientamento: TDataModule},
  frmOrientamento in 'dbForms\frmOrientamento.pas' {FormOrientamento},
  dmCandidature in 'DataModules\dmCandidature.pas' {Candidature: TDataModule},
  frmCandidature in 'dbForms\frmCandidature.pas' {FormCandidature},
  frmGeneraPrenotazioniAule in 'Varie\frmGeneraPrenotazioniAule.pas' {FormGeneraPrenotazioniAule},
  dmServiziAlLavoro in 'DataModules\dmServiziAlLavoro.pas' {ServiziAlLavoro: TDataModule},
  frmServiziAlLavoro in 'dbForms\frmServiziAlLavoro.pas' {FormServiziAlLavoro},
  frmAnagrafiche in 'dbForms\frmAnagrafiche.pas' {FormAnagrafiche},
  dmAnagrafiche in 'DataModules\dmAnagrafiche.pas' {Anagrafiche: TDataModule},
  dmAbitare_Sostegno in 'DataModules\dmAbitare_Sostegno.pas' {AbitareSostegno: TDataModule},
  dmAbitare_Sostegno_Scheda in 'DataModules\dmAbitare_Sostegno_Scheda.pas' {AbitareSostegnoScheda: TDataModule},
  frmAbitare_Sostegno in 'dbForms\frmAbitare_Sostegno.pas' {FormAbitareSostegno},
  frmAbitare_Sostegno_Scheda in 'dbForms\frmAbitare_Sostegno_Scheda.pas' {FormAbitareSostegnoScheda},
  dmAbitare_Emergenza in 'DataModules\dmAbitare_Emergenza.pas' {AbitareEmergenza: TDataModule},
  frmAbitare_Emergenza in 'dbForms\frmAbitare_Emergenza.pas' {FormAbitareEmergenza},
  dmEventHandler in 'DataModules\dmEventHandler.pas' {EventHandler: TDataModule},
  dmAziende in 'DataModules\dmAziende.pas' {Aziende: TDataModule},
  frmAziende in 'dbForms\frmAziende.pas' {FormAziende},
  dmFTP in 'BASE\dmFTP.pas' {FTP: TDataModule},
  dmAziendaScheda in 'DataModules\dmAziendaScheda.pas' {AziendaScheda: TDataModule},
  frmAziendaScheda in 'dbForms\frmAziendaScheda.pas' {FormAziendaScheda},
  dmNotifiche in 'DataModules\dmNotifiche.pas' {Notifiche: TDataModule},
  frmNotifiche in 'dbForms\frmNotifiche.pas' {FormNotifiche},
  CalendarioAule.classes in 'Varie\CalendarioAule.classes.pas',
  dmCalendarioAule in 'DataModules\dmCalendarioAule.pas' {CalendarioAule: TDataModule},
  Frame_CalendarioAule in 'frames\Frame_CalendarioAule.pas' {FrameCalendarioAule: TFrame},
  frmCalendarioAule in 'dbForms\frmCalendarioAule.pas' {FormCalendarioAule},
  dmTimesheet in 'DataModules\dmTimesheet.pas' {Timesheet: TDataModule},
  frmTimesheet in 'dbForms\frmTimesheet.pas' {FormTimesheet},
  dmCommon in 'DataModules\dmCommon.pas' {Common: TDataModule},
  dmContratti in 'DataModules\dmContratti.pas' {Contratti: TDataModule},
  frmContratti in 'dbForms\frmContratti.pas' {FormContratti},
  UtentiDominio.lib in 'Varie\UtentiDominio.lib.pas',
  dmSIA_ServizioInclusioneAdulti in 'DataModules\dmSIA_ServizioInclusioneAdulti.pas' {SIA_ServizioInclusioneAdulti: TDataModule},
  frmSIA_ServizioInclusioneAdulti in 'dbForms\frmSIA_ServizioInclusioneAdulti.pas' {FormSIA_ServizioInclusioneAdulti: TDataModule},
  dmAssistentiSociali in 'DataModules\dmAssistentiSociali.pas' {AssistentiSociali: TDataModule},
  frmAssistentiSociali in 'dbForms\frmAssistentiSociali.pas' {FormAssistentiSociali},
  dmAttivitaFuoriSede in 'DataModules\dmAttivitaFuoriSede.pas' {AttivitaFuoriSede: TDataModule},
  frmAttivitaFuoriSede in 'dbForms\frmAttivitaFuoriSede.pas' {FormAttivitaFuoriSede},
  eSignAnyWhere.classes.Envelope in 'API\eSignAnyWhere\eSignAnyWhere.classes.Envelope.pas',
  eSignAnyWhere.classes.Prepare in 'API\eSignAnyWhere\eSignAnyWhere.classes.Prepare.pas',
  eSignAnyWhere.classes.PrepareResponse in 'API\eSignAnyWhere\eSignAnyWhere.classes.PrepareResponse.pas',
  eSignAnyWhere.classes.FindRequest in 'API\eSignAnyWhere\eSignAnyWhere.classes.FindRequest.pas',
  eSignAnyWhere.classes.EnvelopeFiles in 'API\eSignAnyWhere\eSignAnyWhere.classes.EnvelopeFiles.pas',
  eSignAnyWhere.classes.EnvelopeResponse in 'API\eSignAnyWhere\eSignAnyWhere.classes.EnvelopeResponse.pas',
  eSignAnyWhere.params in 'API\eSignAnyWhere\eSignAnyWhere.params.pas',
  eSignAnyWhere.utils in 'API\eSignAnyWhere\eSignAnyWhere.utils.pas',
  eSignAnyWhere in 'API\eSignAnyWhere\eSignAnyWhere.pas' {eSignAnyWhereEngine: TDataModule},
  Gesty.Authorizations in 'Varie\Gesty.Authorizations.pas',
  zFBExpert.Engine in 'FbTools\zFBExpert.Engine.pas' {zFBExpertEngine: TDataModule},
  zFBExpert.Frame in 'FbTools\zFBExpert.Frame.pas' {zFBExpertFrame: TFrame},
  dmFbExpert in 'FbTools\dmFbExpert.pas' {FbExpert: TDataModule},
  frmFbExpert in 'FbTools\frmFbExpert.pas' {FormFbExpert},
  dmFbMonitor in 'FbTools\dmFbMonitor.pas' {FbMonitor: TDataModule},
  dmFbProfiler in 'FbTools\dmFbProfiler.pas' {FbProfiler: TDataModule},
  frmFbMonitor in 'FbTools\frmFbMonitor.pas' {FormFbMonitor},
  frmFbProfiler in 'FbTools\frmFbProfiler.pas' {FormFbProfiler},
  frmSelezionaDate in 'Varie\frmSelezionaDate.pas' {FormSelezionaDate},
  dmFormazioneInterna in 'DataModules\dmFormazioneInterna.pas' {FormazioneInterna: TDataModule},
  frmFormazioneInterna in 'dbForms\frmFormazioneInterna.pas' {FormFormazioneInterna},
  dmAccordoStatoRegioni in 'DataModules\dmAccordoStatoRegioni.pas' {AccordoStatoRegioni: TDataModule},
  dmAttestati in 'DataModules\dmAttestati.pas' {Attestati: TDataModule},
  frmAccordoStatoRegioni in 'dbForms\frmAccordoStatoRegioni.pas' {FormAccordoStatoRegioni},
  frmAttestati in 'dbForms\frmAttestati.pas' {FormAttestati},
  BaseWeb.DM in 'BaseWeb\BaseWeb.DM.pas',
  BaseWeb.Models in 'BaseWeb\BaseWeb.Models.pas',
  BaseWeb.Repository in 'BaseWeb\BaseWeb.Repository.pas',
  BaseWeb.Designer.Frame in 'BaseWeb\BaseWeb.Designer.Frame.pas',
  BaseWeb.PropertyEditors in 'BaseWeb\BaseWeb.PropertyEditors.pas',
  BaseWeb.Form in 'BaseWeb\BaseWeb.Form.pas',
  BaseWeb.FormPreviewBuilder in 'BaseWeb\BaseWeb.FormPreviewBuilder.pas',
  BaseWeb.Consts in 'BaseWeb\BaseWeb.Consts.pas',
  BaseWeb.Types in 'BaseWeb\BaseWeb.Types.pas',
  BaseWeb.Designer.Form in 'BaseWeb\BaseWeb.Designer.Form.pas',
  dxMessageDialog,
  zMetadata.Query,
  Gesty_Filters in 'Gesty_Filters.pas',
  zMsg,
  SIUF.CooperazioneApplicativa.Builder in 'API\CooperazioneApplicativa\SIUF.CooperazioneApplicativa.Builder.pas',
  SIUF.CooperazioneApplicativa.Client in 'API\CooperazioneApplicativa\SIUF.CooperazioneApplicativa.Client.pas',
  SIUF.CooperazioneApplicativa.Types in 'API\CooperazioneApplicativa\SIUF.CooperazioneApplicativa.Types.pas',
  SIUF.CooperazioneApplicativa.Validator in 'API\CooperazioneApplicativa\SIUF.CooperazioneApplicativa.Validator.pas',
  dmSIUF_CooperazioneApplicativa in 'DataModules\dmSIUF_CooperazioneApplicativa.pas',
  Gefos.Types in 'API\Gefos\Gefos.Types.pas',
  Gefos.Client in 'API\Gefos\Gefos.Client.pas',
  Gefos.Validator in 'API\Gefos\Gefos.Validator.pas',
  dmGefosCooperazioneApplicativa in 'DataModules\dmGefosCooperazioneApplicativa.pas',
  zFormController,
  Documentazione.Bridge.Protocollo in 'DataModules\Documentazione.Bridge.Protocollo.pas' {DocumentazioneBridgeProtocollo},
  Documentazione.Bridge.Firma in 'DataModules\Documentazione.Bridge.Firma.pas' {DocumentazioneBridgeFirma},
  Documentazione.Bridge.Conservazione in 'DataModules\Documentazione.Bridge.Conservazione.pas' {DocumentazioneBridgeConservazione},
  Documentazione.Bridge.Messaggi in 'DataModules\Documentazione.Bridge.Messaggi.pas' {DocumentazioneBridgeMessaggi},
  Documentazione.Firma.ESignAnyWhere in 'MotoriDocumentali\Documentazione.Firma.ESignAnyWhere.pas',
  Documentazione.ReportActionsController in 'MotoriDocumentali\Documentazione.ReportActionsController.pas',
  dmDocumentazioneConservazione in 'DataModules\dmDocumentazioneConservazione.pas' {DocumentazioneConservazione},
  dmDocumentazioneRegistroFirme in 'DataModules\dmDocumentazioneRegistroFirme.pas' {DocumentazioneRegistroFirme},
  frmDocumentazioneRegistroFirme in 'dbForms\frmDocumentazioneRegistroFirme.pas' {FormDocumentazioneRegistroFirme},
  dmDocumentazioneRegistroProtocollo in 'DataModules\dmDocumentazioneRegistroProtocollo.pas' {DocumentazioneRegistroProtocollo},
  frmDocumentazioneRegistroProtocollo in 'dbForms\frmDocumentazioneRegistroProtocollo.pas' {FormDocumentazioneRegistroProtocollo},
  dmDocumentazioneCruscotto in 'DataModules\dmDocumentazioneCruscotto.pas' {DocumentazioneCruscotto},
  frmDocumentazioneCruscotto in 'dbForms\frmDocumentazioneCruscotto.pas' {FormDocumentazioneCruscotto},
  dmDocumentazioneFirmaElettronica in 'DataModules\dmDocumentazioneFirmaElettronica.pas' {DocumentazioneFirmaElettronica},
  frmDocumentazioneFirmaElettronica in 'dbForms\frmDocumentazioneFirmaElettronica.pas' {FormDocumentazioneFirmaElettronica},
  dmDocumentazioneProtocolloImport in 'DataModules\dmDocumentazioneProtocolloImport.pas' {DocumentazioneProtocolloImport},
  frmDocumentazioneConservazione in 'dbForms\frmDocumentazioneConservazione.pas' {FormDocumentazioneConservazione},
  dmDocumentazioneMessaggiRegistro in 'DataModules\dmDocumentazioneMessaggiRegistro.pas' {DocumentazioneMessaggiRegistro},
  frmDocumentazioneMessaggiRegistro in 'dbForms\frmDocumentazioneMessaggiRegistro.pas' {FormDocumentazioneMessaggiRegistro},
  frmDocumentazioneInvioMessaggio in 'Varie\frmDocumentazioneInvioMessaggio.pas' {FormDocumentazioneInvioMessaggio},
  dmCOGE_Bilancio in 'DataModules\dmCOGE_Bilancio.pas' {COGE_Bilancio},
  dmCOGE_Configurazione in 'DataModules\dmCOGE_Configurazione.pas' {COGE_Configurazione},
  dmCOGE_Documenti in 'DataModules\dmCOGE_Documenti.pas' {COGE_Documenti},
  dmCOGE_FattureElettroniche in 'DataModules\dmCOGE_FattureElettroniche.pas' {COGE_FattureElettroniche},
  dmCOGE_Incassi in 'DataModules\dmCOGE_Incassi.pas' {COGE_Incassi},
  dmCOGE_Registrazioni in 'DataModules\dmCOGE_Registrazioni.pas' {COGE_Registrazioni},
  dmCOGE_Soggetti in 'DataModules\dmCOGE_Soggetti.pas' {COGE_Soggetti},
  dmCOGE_Gateway_Contabile in 'DataModules\dmCOGE_Gateway_Contabile.pas' {COGE_Gateway_Contabile},
  frmCOGE_Bilancio in 'dbForms\frmCOGE_Bilancio.pas' {FormCOGE_Bilancio},
  frmCOGE_Configurazione in 'dbForms\frmCOGE_Configurazione.pas' {FormCOGE_Configurazione},
  frmCOGE_Documenti in 'dbForms\frmCOGE_Documenti.pas' {FormCOGE_Documenti},
  frmCOGE_FattureElettroniche in 'dbForms\frmCOGE_FattureElettroniche.pas' {FormCOGE_FattureElettroniche},
  frmCOGE_Incassi in 'dbForms\frmCOGE_Incassi.pas' {FormCOGE_Incassi},
  frmCOGE_Registrazioni in 'dbForms\frmCOGE_Registrazioni.pas' {FormCOGE_Registrazioni},
  frmCOGE_Soggetti in 'dbForms\frmCOGE_Soggetti.pas' {FormCOGE_Soggetti},
  frmCOGE_Gateway_Contabile in 'dbForms\frmCOGE_Gateway_Contabile.pas' {FormCOGE_Gateway_Contabile},
  Gesty.AI.Resolvers in 'Gesty.AI.Resolvers.pas',
  HelpGen.AI in 'BASE\HelpGen\HelpGen.AI.pas',
  zAI.Engine in 'BASE\AI\zAI.Engine.pas',
  zAI.Configuration in 'BASE\AI\zAI.Configuration.pas',
  zChatTypes in 'BASE\AI\zChatTypes.pas',
  zChatRenderer in 'BASE\AI\zChatRenderer.pas',
  zChatScroller in 'BASE\AI\zChatScroller.pas',
  zChatInput in 'BASE\AI\zChatInput.pas',
  zChatControl in 'BASE\AI\zChatControl.pas',
  zChatSessions in 'BASE\AI\zChatSessions.pas',
  zChatSessionsDropDown in 'BASE\AI\zChatSessionsDropDown.pas',
  zChatSlidingPanel in 'BASE\AI\zChatSlidingPanel.pas',
  zChatAIPane in 'BASE\AI\zChatAIPane.pas',
  zAI.Tools in 'BASE\AI\zAI.Tools.pas',
  zAI.Protocol in 'BASE\AI\zAI.Protocol.pas',
  zAI.Protocol.Gemini in 'BASE\AI\zAI.Protocol.Gemini.pas',
  zAI.Protocol.OpenAI in 'BASE\AI\zAI.Protocol.OpenAI.pas',
  zAI.Protocol.Claude in 'BASE\AI\zAI.Protocol.Claude.pas',
  zAI.Protocol.Ollama in 'BASE\AI\zAI.Protocol.Ollama.pas',
  zAI.Driver.Ollama in 'BASE\AI\zAI.Driver.Ollama.pas',
  dmAI in 'BASE\AI\dmAI.pas' {AI: TDataModule},
  AI.Bridge in 'DataModules\AI.Bridge.pas' {AIBridgeDataModule: TDataModule},
  AI.Strumenti in 'DataModules\AI.Strumenti.pas' {AIStrumenti: TDataModule},
  zNet.Tls.OpenSsl,
  zNet.Tls.SChannel,
  zDocumentale.Providers,
  SmartInspect.Vcl,
  SmartInspect.Vcl.SiAuto,
  Gesty.dxSettings in 'Gesty.dxSettings.pas',
  Gesty.Sonda in 'Varie\Gesty.Sonda.pas',
  Gesty.Uso in 'Varie\Gesty.Uso.pas',
  CalcoloPeriodi.Verifiche in 'Varie\CalcoloPeriodi.Verifiche.pas',
  CalcoloAbitare.Lib in 'Varie\CalcoloAbitare.Lib.pas',
  CalcoloAbitare.Verifiche in 'Varie\CalcoloAbitare.Verifiche.pas',
  CalcoloPeriodi.Lib in 'Varie\CalcoloPeriodi.Lib.pas';

{$R *.RES}
{$SETPEOPTFLAGS IMAGE_DLLCHARACTERISTICS_TERMINAL_SERVER_AWARE}
// {$SETPEFLAGS IMAGE_FILE_NET_RUN_FROM_SWAP} da verificare
{$SETPEOPTFLAGS $140}

// Blocco dell'avvio messo da GestyTools durante la manutenzione (pulsante
// "Blocca avvio", o shutdown): il file Gesty.blocco accanto all'eseguibile.
// Se c'e', avvisa e restituisce True: l'avvio si ferma prima di toccare il
// database. GestyTools avvia Gesty con -ignorablocco, perche' chi aggiorna
// deve poterlo provare prima di togliere il blocco.
function AvvioBloccato: Boolean;
var
  NomeFile: string;
  Contenuto: TStringList;
  Dettaglio: string;
begin
  NomeFile := ExtractFilePath(ParamStr(0)) + 'Gesty.blocco';
  Result := FileExists(NomeFile) and not FindCmdLineSwitch('ignorablocco');
  if not Result then
    Exit;

  // chi ha messo il blocco e quando, per sapere a chi chiedere
  Dettaglio := '';
  Contenuto := TStringList.Create;
  try
    try
      Contenuto.LoadFromFile(NomeFile);
      if Contenuto.Values['Data'] <> '' then
        Dettaglio := sLineBreak + sLineBreak + 'Bloccato il ' + Contenuto.Values['Data'] + ' da ' + Contenuto.Values['Utente'] + ' (' +
          Contenuto.Values['Computer'] + ').';
    except
      // file illeggibile, per esempio mentre GestyTools lo scrive: basta il
      // messaggio senza dettaglio
    end;
  finally
    Contenuto.Free;
  end;

  ConfirmOk('Gesty e'' in manutenzione (aggiornamento in corso) e al momento non puo'' essere aperto.' + sLineBreak + 'Riprovare piu'' tardi.' +
    Dettaglio, mtWarning);
end;

var
  logfilename: string;

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;

  if AvvioBloccato then
    Exit;

  if FindCmdLineSwitch('log', logfilename) then
    if not logfilename.IsEmpty then
      si.Connections := 'file(append="true", filename="' + logfilename + '")';

  si.Enabled := true;
  try
    ForceDirectories(Path + 'log');

    // Registrazione per l'assistenza chiesta dall'utente per questo avvio
    // (voce "Registra dal prossimo avvio"): se nella cartella dei log c'e' il
    // file di richiesta di questa postazione, la registrazione parte qui,
    // prima dell'accesso e della creazione dei moduli dati, cosi' copre anche
    // il caricamento del dizionario LZ. Con -log il .sil resta attivo accanto.
    SessioneLog.AvviaAllAvvio;

    DefaultCharCase := ecNormal;

    if not CheckGdiPlus then
      ConfirmOk('Attenzione: GDI+ non presente nel sistema.');

    // ShortDateFormat := 'dd/MM/yyyy';
    // TeeSetItalian;

    UseMultiViewer := true;

    // TdxVisualRefinements.ApplyLightStyle;
    UseLatestCommonDialogs := true;
    dxUseStandardMessageDialogs := false;

    Application.Initialize;
    Application.Title := 'Gesty';
    Application.HelpFile := ChangeFileExt(Application.ExeName, '.chm');

    // Sonda di collaudo: attiva solo nelle versioni compilate con la direttiva
    // SONDA e avviate con --sonda <pipe> da zMCP_App; altrimenti non fa niente.
    // Qui, prima del login, perche' il collaudo deve vedere anche la finestra
    // di accesso e i dialoghi dell'avvio.
    AvviaSondaGesty;

    // Schermata di avvio di DevExpress. Va mostrata qui e non dall'InitProc di
    // Gesty.dxSettings.pas: quella procedura chiama LoadAppearance, che azzera
    // lo skin (UseSkins False, SkinName vuoto), e la schermata comparirebbe coi
    // colori predefiniti. Lo skin dell'ultima sessione va quindi riapplicato
    // prima che la definizione si carichi (BeforeFirstShow). Siamo comunque
    // prima della creazione dei moduli dati, che e' la parte lenta dell'avvio.
    // La schermata compare sul monitor su cui si lavorava alla chiusura
    // precedente (TWorkingMonitor, file .login).
    TSmartSplashForm.BeforeFirstShow(
      procedure
      begin
        TzSecurity.LoadSkinFromIni;
      end);
    TSmartSplashForm.UseStatusText('Stato');
    TSmartSplashForm.Show;

  Application.CreateForm(Tconfig, config);
  Application.CreateForm(TCommon, Common);
  Application.CreateForm(TEventHandler, EventHandler);
  Application.CreateForm(TSchedulerTools, SchedulerTools);
  Application.CreateForm(TeSignAnyWhereEngine, eSignAnyWhereEngine);
  if config.LoggedIn then
    begin
      // ShowSplash; -- chiamato da Login
      // try
      Application.CreateForm(TMain, Main);

      // finally
      // Mantis #7056 - 2026-11-02: la schermata viene chiusa da
      // TMain.FormShow, dopo il lavoro di apertura della finestra.
      // end;
    end;

    Application.Run;

    // La registrazione per l'assistenza, se ancora attiva, va chiusa qui:
    // ExitProcess salta le finalization delle unit e la sessione resterebbe
    // senza riepilogo. Il marcatore .inCorso resta di proposito, cosi' al
    // prossimo avvio viene proposto l'invio della sessione.
    SessioneLog.ChiudiPerTerminazione;

    Application.Terminate;

    OutputDebugString('Termine.');
    // sometimes the application hung here, due to OLE issues
    // exitprocess prevents that.
    ExitProcess(0);

  except
    on e: exception do
    begin
      siMain.LogException(e);
      raise;
    end;
  end;

end.

  zOffice.Reports.Proprieta

  zstoredproc zSystem zlayouts

  Documentazione.Firma.eSignAnyWhere.pas Documentazione.Bridge.Firma.pas

  zOffice.Reports zOffice.Reports.ActionsBarHelper.pas

  z zProgressBox zOffice.word.form zSystem

  zDbView zDbPivot zDbCard

  Gesty_Filters zSystem

  zFbDataSet

  zSystem
