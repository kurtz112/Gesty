unit AppController;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  JS,
  Web;

type
  TAdminController = record
  public
    procedure Login;
    procedure CambioPassword;
    procedure PasswordDimenticata;
    procedure Registrazione;

    procedure Profilo;
    procedure MailAssistenza;
  end;

  TDocentiController = record
  public
    procedure RegistroElettronico;
  end;

  TRisorseController = record
  public
    procedure AgendaPersonale;
    procedure ElencoIncarichi;
    procedure ElencoOreRilevate; // Timesheet
    procedure ElencoPresenze; // Non serve
    procedure OreRecupero; // Dopo...
    procedure PrenotazioniAule;
    procedure SchedaAnagrafica;
  end;

  TStudentiController = record
  public
    procedure PresenzeStage;
    procedure Documentazione;
  end;

  TTutorAziendaliController = record
  public
    procedure ValidazionePresenze;
    procedure Documentazione;
    procedure InvioFile;
  end;

  TController = record
  public
    Admin: TAdminController;
    Docenti: TDocentiController;
    Risorse: TRisorseController;
    Studenti: TStudentiController;
    TutorAziendali: TTutorAziendaliController;
  public
    procedure StartApplication;
  end;

var
  Controller: TController;

implementation

uses
  WEBLib.Forms,
  DevExtreme.Utils,
  //
  BaseWebFrmController,
  //
  popLogin,
  popCambioPassword,
  popPasswordDimenticata,
  popRegistrazione,
  //
  MainFrm,
  AdminDM,
  //
  frmElencoIncarichi,
  frmRegistroElettronico,
  frmRilevamenti,
  //
  frmStagePresenze,
  frmStageDownloadFile,
  frmStageInvioFile;

/// //////////////////////////////////////////

/// //////////////////////////////////////////
{ TController }

procedure TController.StartApplication;
begin
  main.StartApplication;
end;

/// //////////////////////////////////////////
{ TAdminController }

procedure TAdminController.Login;
begin
  popLogin.Login;
end;

procedure TAdminController.Registrazione;
begin
  popRegistrazione.Registrazione;
end;

procedure TAdminController.CambioPassword;
begin
  popCambioPassword.CambioPassword;
end;

procedure TAdminController.PasswordDimenticata;
begin
  popPasswordDimenticata.PasswordDimenticata;
end;

procedure TAdminController.Profilo;
var
  stringList: TStringList;
begin
  stringList := TStringList.Create;
  try
    stringList.AddPair('Utente', 'Nominativo Utente');
    stringList.AddPair('Platform', TdxUtils.platform);
    stringList.AddPair('Platform Ver,', JS.ToString(TdxUtils.PlatformVersion));
    stringList.AddPair('Device Type', TdxUtils.DeviceType);
    stringList.AddPair('Device Grade', TdxUtils.DeviceGrade);
    stringList.AddPair('Screen', TdxUtils.screen.ToString);
    stringList.AddPair('Orientation', TdxUtils.Orientation.ToString);
    stringList.AddPair('Width', window.InnerWidth.ToString);
    stringList.AddPair('Height', window.InnerHeight.ToString);

    TdxUtils.Alert('Impostazioni', stringList.text);
  finally
    FreeAndNil(stringList);
  end;
end;

procedure TAdminController.MailAssistenza;
begin
  window.location.href := 'mailto:assistenza@zebro.it?subject=subject&body=body';
end;

/// //////////////////////////////////////////
{ TDocentiController }

procedure TDocentiController.RegistroElettronico;
begin
  BaseWebFormController.ShowForm(TFormRegistroElettronico, FormRegistroElettronico);
end;

/// //////////////////////////////////////////
{ TRisorseController }

procedure TRisorseController.AgendaPersonale;
begin
  // BaseWebFormController.ShowForm(TFormAgendaPersonale, FormAgendaPersonale );
  TdxUtils.Alert('AgendaPersonale', 'AgendaPersonale');
end;

procedure TRisorseController.ElencoIncarichi;
begin
  BaseWebFormController.ShowForm(TFormElencoIncarichi, FormElencoIncarichi);
end;

procedure TRisorseController.ElencoOreRilevate;
begin
  BaseWebFormController.ShowForm(TFormRilevamenti, FormRilevamenti);
end;

procedure TRisorseController.ElencoPresenze;
begin
  // BaseWebFormController.ShowForm(TFormElencoPresenze, FormElencoPresenze);
  TdxUtils.Alert('ElencoPresenze', 'ElencoPresenze');
end;

procedure TRisorseController.OreRecupero;
begin
  // BaseWebFormController.ShowForm(TFormOreRecupero, FormOreRecupero);
  TdxUtils.Alert('OreRecupero', 'OreRecupero');
end;

procedure TRisorseController.PrenotazioniAule;
begin
  // BaseWebFormController.ShowForm(TFormPrenotazioniAule, FormPrenotazioniAule);
  TdxUtils.Alert('PrenotazioniAule', 'PrenotazioniAule');
end;

procedure TRisorseController.SchedaAnagrafica;
begin
  // BaseWebFormController.ShowForm(TFormSchedaAnagrafica, FormSchedaAnagrafica);
  TdxUtils.Alert('SchedaAnagrafica', 'SchedaAnagrafica');
end;

procedure TStudentiController.Documentazione;
begin
  BaseWebFormController.ShowForm(TFormStageDownloadFile, FormStageDownloadFile);
end;

procedure TStudentiController.PresenzeStage;
begin
  BaseWebFormController.ShowForm(TFormStagePresenze, FormStagePresenze);
end;

/// //////////////////////////////////////////
{ TTutorAziendaliController }

procedure TTutorAziendaliController.ValidazionePresenze;
begin
  BaseWebFormController.ShowForm(TFormStagePresenze, FormStagePresenze);
  // BaseWebFormController.ShowForm(TFormTutorValidazionePresenze, FormTutorValidazionePresenze);
end;

procedure TTutorAziendaliController.Documentazione;
begin
  BaseWebFormController.ShowForm(TFormStageDownloadFile, FormStageDownloadFile);
end;

procedure TTutorAziendaliController.InvioFile;
begin
  BaseWebFormController.ShowForm(TFormStageInvioFile, FormStageInvioFile);
end;

end.
