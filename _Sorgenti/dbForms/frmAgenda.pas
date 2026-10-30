unit frmAgenda;

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
  fs_iinterpreter,
  dxBarExtItems,
  dxBar,
  cxClasses,
  ActnList,
  cxNavigator,
  cxDBNavigator,
  dxLayoutControl,
  cxControls,
  ExtCtrls,
  Menus,
  cxStyles,
  cxGraphics,
  cxEdit,
  cxScheduler,
  cxSchedulerStorage,
  cxSchedulerCustomControls,
  cxExportSchedulerLink,
  cxSchedulerCustomResourceView,
  cxSchedulerDayView,
  cxSchedulerDateNavigator,
  cxSchedulerHolidays,
  cxSchedulerTimeGridView,
  cxSchedulerUtils,
  cxSchedulerWeekView,
  cxSchedulerYearView,
  cxSchedulerGanttView,
  dxStatusBar,
  cxLookAndFeelPainters,
  StdCtrls,
  cxButtons,
  cxLookAndFeels,
  Buttons,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  DB,
  cxDBData,
  cxGridLevel,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  cxSchedulercxGridConnection,
  StdActns,
  BaseFrm,
  Gesty.CalendarioEsterno,
  cxContainer,
  cxLabel,
  zDbView,
  dxLayoutLookAndFeels,
  cxPC,
  ImgList,
  dxSkinsCore,
  dxSkinsdxBarPainter,
  cxSchedulerTreeListBrowser,
  dxSkinscxSchedulerPainter,
  dxSkinscxPCPainter,
  cxPCdxBarPopupMenu,
  dxRibbonSkins,
  dxRibbonCustomizationForm,
  cxSchedulerAgendaView,
  cxSchedulerRecurrence,
  cxSchedulerRibbonStyleEventEditor,
  dxBarBuiltInMenu,
  System.ImageList,
  System.Actions,
  dxRibbon,
  Base_DataModule,
  dxFileActions,
  Base_Frame,
  zDbScheduler,
  SmartInspect.VCL.SiAuto,
  SmartInspect.VCL,
  dxUIAClasses;

type

  TSchedulerView = (viewDay, viewWorkDays, viewWeek, viewMonth, viewYear);

  TFormAgenda = class(TBaseForm)
    dxBarButton7: TdxBarButton;
    dxBarButton8: TdxBarButton;
    dxBarButton9: TdxBarButton;
    dxBarButton10: TdxBarButton;
    dxBarButton11: TdxBarButton;
    dxBarButton12: TdxBarButton;
    dxBarLargeButton2: TdxBarLargeButton;
    dxBarLargeButton3: TdxBarLargeButton;
    dxBarLargeButton4: TdxBarLargeButton;
    dxBarManagerBarAgenda: TdxBar;
    dxBarLargeButton5: TdxBarLargeButton;
    dxBarLargeButton6: TdxBarLargeButton;
    dxBarLargeButton7: TdxBarLargeButton;
    dxBarLargeButton8: TdxBarLargeButton;
    dxBarLargeButton9: TdxBarLargeButton;
    FrameScheduler: TzDbScheduler;
    flagActions: TActionList;
    MostraLezioni: TAction;
    MostraRilevamenti: TAction;
    MostraRiunioni: TAction;
    MostraAgendaPersonale: TAction;
    MostraPrenotazioniAule: TAction;
    MostraInagibilitaAule: TAction;
    MostraChiusureSedi: TAction;
    MostraPresenzePersonale: TAction;
    MostraAssenze: TAction;
    MostraScadenze: TAction;
    MostraFuoriSede: TAction;
    procedure FormShow(Sender: TObject);
    procedure FrameSchedulerSchedulerCustomDrawContent(Sender: TObject; ACanvas: TcxCanvas; AViewInfo: TcxSchedulerContentCellViewInfo; var ADone: Boolean);
    procedure MostraAgendaPersonaleExecute(Sender: TObject);
    procedure MostraAgendaPersonaleUpdate(Sender: TObject);
    procedure MostraAssenzeExecute(Sender: TObject);
    procedure MostraAssenzeUpdate(Sender: TObject);
    procedure MostraChiusureSediExecute(Sender: TObject);
    procedure MostraChiusureSediUpdate(Sender: TObject);
    procedure MostraFuoriSedeExecute(Sender: TObject);
    procedure MostraFuoriSedeUpdate(Sender: TObject);
    procedure MostraInagibilitaAuleExecute(Sender: TObject);
    procedure MostraInagibilitaAuleUpdate(Sender: TObject);
    procedure MostraLezioniExecute(Sender: TObject);
    procedure MostraLezioniUpdate(Sender: TObject);
    procedure MostraPrenotazioniAuleExecute(Sender: TObject);
    procedure MostraPrenotazioniAuleUpdate(Sender: TObject);
    procedure MostraPresenzePersonaleExecute(Sender: TObject);
    procedure MostraPresenzePersonaleUpdate(Sender: TObject);
    procedure MostraRilevamentiExecute(Sender: TObject);
    procedure MostraRilevamentiUpdate(Sender: TObject);
    procedure MostraRiunioniExecute(Sender: TObject);
    procedure MostraRiunioniUpdate(Sender: TObject);
    procedure MostraScadenzeExecute(Sender: TObject);
    procedure MostraScadenzeUpdate(Sender: TObject);
  private
    AnchorDate: TDateTime;
  private
    function EsistePresenza(inizio, fine: TDateTime): Boolean;
  private // prenotazione di un'aula dall'agenda
    procedure AggiungiVociPrenotazioneAula;
    procedure LeggiSelezione(out Data: TDate; out DalleOre, AlleOre: TTime);
    procedure CercaAulaLiberaExecute(Sender: TObject);
    procedure CercaQuandoLiberaAulaExecute(Sender: TObject);
  private // sincronizzazione con un calendario esterno (Outlook o Google Calendar)
    FornitoriCalendario: TFornitoriCalendario;
    AzioneSincronizzaCalendario: TAction;
    AzioneScollegaCalendario: TAction;
    procedure AggiungiAzioniCalendario;
    procedure AggiornaAzioniCalendario;
    function ScegliFornitoreCalendario(out Fornitore: TFornitoreCalendario): Boolean;
    procedure SincronizzaCalendario(const Fornitore: TFornitoreCalendario; const Interattiva: Boolean);
    procedure SincronizzaCalendarioExecute(Sender: TObject);
    procedure ScollegaCalendarioExecute(Sender: TObject);
  protected
    procedure AfterCreateControls; override;
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;
    procedure Aggiorna; override;
  end;

implementation

uses
  Gesty.Scheduler,
  System.DateUtils,
  System.Math,
  dmAgenda,
  frmPrenotaAulaDaAgenda,
  cxSchedulerDialogs,
  cxSchedulerOutlookExchange,
  zdx,
  zBaseLib,
  zMsg;
{$R *.dfm}
{ TFormAgenda }

var
  FormAgenda: TFormAgenda;

procedure TFormAgenda.CreateDataModule;
begin
  SiMain.EnterMethod(Self, 'CreateDataModule');
  inherited;
  CreateDM(TAgenda, Agenda);
  // il modulo dati resta quello di sempre: il ponte Gesty.Scheduler lo adatta
  // al calendario di zPack
  FrameScheduler.Init(TGestyScheduler.Storage(Agenda), TGestyScheduler.CopiaIncolla(Agenda));
  // dopo Init, che mette in cima al menu del calendario le voci "Nuovo ..."
  AggiungiVociPrenotazioneAula;
  SiMain.LeaveMethod(Self, 'CreateDataModule');
end;

procedure TFormAgenda.AggiungiVociPrenotazioneAula;

  function NuovaVoce(const NomeAzione, Caption: string; Handler: TNotifyEvent; const Posizione: Integer): TdxBarItemLink;
  var
    Azione: TAction;
    Pulsante: TdxBarButton;
  begin
    // con un nome, come le azioni del .dfm: permessi e collaudo la trovano
    Azione := TAction.Create(Self);
    Azione.Name := NomeAzione;
    Azione.Caption := Caption;
    Azione.OnExecute := Handler;

    // come le voci "Nuovo ..." del frame (TzDbScheduler.AggiungiAzioneNuovo):
    // il pulsante appartiene al frame, che ha il gestore delle barre del menu
    Pulsante := TdxBarButton.Create(FrameScheduler);
    Pulsante.Action := Azione;

    result := FrameScheduler.popScheduler.ItemLinks.Add(Pulsante);
    result.Index := Posizione;
  end;

var
  Posizione: Integer;
  Indice: Integer;
begin
  // subito dopo le voci "Nuovo ...", cioe' prima di "Copia giorno", la prima
  // voce fissa del menu del calendario
  Posizione := FrameScheduler.popScheduler.ItemLinks.Count;
  for Indice := 0 to FrameScheduler.popScheduler.ItemLinks.Count - 1 do
    if FrameScheduler.popScheduler.ItemLinks[Indice].Item = FrameScheduler.dxBarButtonCopiaGiorno then
    begin
      Posizione := Indice;
      Break;
    end;

  NuovaVoce('CercaAulaLibera', 'Cerca aula libera in questo orario...', CercaAulaLiberaExecute, Posizione).BeginGroup := True;
  NuovaVoce('CercaQuandoLiberaAula', 'Cerca quando '#232' libera un''aula...', CercaQuandoLiberaAulaExecute, Posizione + 1);
end;

procedure TFormAgenda.LeggiSelezione(out Data: TDate; out DalleOre, AlleOre: TTime);
var
  Inizio: TDateTime;
  Fine: TDateTime;
begin
  // dalla selezione del calendario, non dal punto del clic: e' la regola di
  // NuovoEvento (Mantis #197), perche' fuori dalle celle HitTest.Time vale
  // NullDate. Il clic destro seleziona la cella (SelectOnRightClick)
  Inizio := FrameScheduler.Scheduler.SelStart;
  Fine := FrameScheduler.Scheduler.SelFinish;

  // nessuna cella selezionata: oggi, nell'orario di lavoro
  if Inizio < EncodeDate(1900, 1, 1) then
  begin
    Inizio := Date;
    Fine := IncDay(Inizio);
  end;

  Data := DateOf(Inizio);

  if (TimeOf(Inizio) = 0) and (Fine - Inizio >= 1) then
  begin
    // giornate intere (vista mese o riga del giorno): la prima ora di lavoro
    DalleOre := FrameScheduler.Scheduler.OptionsView.WorkStart;
    AlleOre := IncHour(DalleOre, 1);
  end
  else
  begin
    DalleOre := TimeOf(Inizio);

    // una selezione che arriva a mezzanotte finisce alle 23:59, come i nuovi eventi
    if DateOf(Fine) > Data then
      AlleOre := EncodeTime(23, 59, 0, 0)
    else
      AlleOre := TimeOf(Fine);
  end;

  if AlleOre <= DalleOre then
    AlleOre := Min(IncHour(DalleOre, 1), EncodeTime(23, 59, 0, 0));
end;

procedure TFormAgenda.CercaAulaLiberaExecute(Sender: TObject);
var
  Data: TDate;
  DalleOre, AlleOre: TTime;
begin
  LeggiSelezione(Data, DalleOre, AlleOre);

  if TFormPrenotaAulaDaAgenda.Esegui(mraAuleLibere, Data, DalleOre, AlleOre, FrameScheduler.Scheduler.OptionsView.WorkStart, FrameScheduler.Scheduler.OptionsView.WorkFinish) then
    FrameScheduler.RefreshScheduler;
end;

procedure TFormAgenda.CercaQuandoLiberaAulaExecute(Sender: TObject);
var
  Data: TDate;
  DalleOre, AlleOre: TTime;
begin
  LeggiSelezione(Data, DalleOre, AlleOre);

  // il periodo parte dal giorno selezionato, ma mai prima di oggi
  if Data < Date then
    Data := Date;

  if TFormPrenotaAulaDaAgenda.Esegui(mraOrariAula, Data, DalleOre, AlleOre, FrameScheduler.Scheduler.OptionsView.WorkStart, FrameScheduler.Scheduler.OptionsView.WorkFinish) then
    FrameScheduler.RefreshScheduler;
end;

procedure TFormAgenda.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Agenda);
end;

constructor TFormAgenda.Create(aOwner: TComponent);

  procedure AddToolbarButton(action: TAction);
  var
    btn: TdxBarButton;
  begin
    btn := FrameScheduler.AddToolbarButton(action);
    btn.PaintStyle := psStandard;

    if action.ImageIndex <> -1 then
    begin
      // Le azioni di flagActions hanno gli indici della lista globale dx.Immagini: imagesScheduler
      // ha solo le icone degli eventi, e un indice fuori lista lascia il pulsante senza icona
      dx.GetBitmap(btn.Glyph, dx.Immagini, action.ImageIndex);
      btn.ImageIndex := -1;
    end;
  end;

begin
  SiMain.EnterMethod(Self, 'Create');
  inherited;
  SiMain.LogVerbose('AfterCreate');

  ReportGroup := 'Agenda';
  Caption := 'Agenda';

  FrameScheduler.ControlBoxVisible := False;
  // Mantis #203 - 2026-10-02: il calendario di zPack sta nel .dfm come componente semplice,
  // come TzDbView: le personalizzazioni del calendario si impostano qui e non nel .dfm
  FrameScheduler.Scheduler.DateNavigator.ColCount := 1;
  FrameScheduler.Scheduler.OnCustomDrawContent := FrameSchedulerSchedulerCustomDrawContent;
  // FrameScheduler.dxBarManagerBarFree.Images := FrameScheduler.imagesScheduler;
  flagActions.Images := dx.Immagini;

  AddToolbarButton(MostraLezioni);
  AddToolbarButton(MostraRilevamenti);
  AddToolbarButton(MostraRiunioni);
  AddToolbarButton(MostraAgendaPersonale);
  AddToolbarButton(MostraPrenotazioniAule);
  AddToolbarButton(MostraChiusureSedi);
  AddToolbarButton(MostraInagibilitaAule);
  AddToolbarButton(MostraPresenzePersonale);
  AddToolbarButton(MostraScadenze);
  AddToolbarButton(MostraFuoriSede);
  // FrameScheduler.AddToolbarButton(MostraAssenze);

  AggiungiAzioniCalendario;

  SiMain.LeaveMethod(Self, 'Create');
end;

procedure TFormAgenda.AggiungiAzioniCalendario;

  function NuovaAzione(const NomeAzione: string; Handler: TNotifyEvent): TAction;
  var
    Pulsante: TdxBarButton;
  begin
    // con un nome, come le azioni del .dfm: permessi e collaudo la trovano
    Result := TAction.Create(Self);
    Result.Name := NomeAzione;
    Result.ActionList := flagActions;
    Result.OnExecute := Handler;
    // solo Outlook configurato: la sua icona; altrimenti quella del calendario
    if FornitoriCalendario = [FornitoreMicrosoft] then
      Result.ImageIndex := dx.IndiceIcona('outlook')
    else
      Result.ImageIndex := dx.IndiceIcona('opencalendar');

    Pulsante := FrameScheduler.AddToolbarButton(Result);
    Pulsante.PaintStyle := psStandard;
    if Result.ImageIndex <> -1 then
    begin
      dx.GetBitmap(Pulsante.Glyph, dx.Immagini, Result.ImageIndex);
      Pulsante.ImageIndex := -1;
    end;
  end;

begin
  // nessun fornitore configurato in CONFIG: la funzione non c'e'
  FornitoriCalendario := TSincronizzazioneCalendario.FornitoriDisponibili;
  if FornitoriCalendario = [] then
    Exit;

  AzioneSincronizzaCalendario := NuovaAzione('SincronizzaCalendario', SincronizzaCalendarioExecute);
  AzioneScollegaCalendario := NuovaAzione('ScollegaCalendario', ScollegaCalendarioExecute);
  AggiornaAzioniCalendario;
end;

procedure TFormAgenda.AggiornaAzioniCalendario;
var
  Collegato: TFornitoreCalendario;
  Nome: string;
begin
  if not Assigned(AzioneSincronizzaCalendario) then
    Exit;

  // il nome del servizio quando e' certo: quello collegato, o l'unico configurato
  Collegato := TSincronizzazioneCalendario.FornitoreCollegato;
  if Collegato <> FornitoreNessuno then
    Nome := TSincronizzazioneCalendario.NomeServizio(Collegato)
  else if FornitoriCalendario = [FornitoreMicrosoft] then
    Nome := TSincronizzazioneCalendario.NomeServizio(FornitoreMicrosoft)
  else if FornitoriCalendario = [FornitoreGoogle] then
    Nome := TSincronizzazioneCalendario.NomeServizio(FornitoreGoogle)
  else
    Nome := '';

  if Nome <> '' then
  begin
    AzioneSincronizzaCalendario.Caption := 'Sincronizza con ' + Nome;
    AzioneSincronizzaCalendario.Hint := Format('Allinea la tua agenda personale con il tuo calendario %s ' +
      '(al primo uso chiede l''accesso al tuo account)', [Nome]);
  end
  else
  begin
    AzioneSincronizzaCalendario.Caption := 'Sincronizza calendario';
    AzioneSincronizzaCalendario.Hint := 'Allinea la tua agenda personale con il tuo calendario Outlook o Google ' +
      '(al primo uso chiede quale e l''accesso al tuo account)';
  end;

  AzioneScollegaCalendario.Caption := 'Scollega calendario';
  AzioneScollegaCalendario.Hint := 'Interrompe la sincronizzazione con il calendario esterno: gli eventi gi' + #224 +
    ' presenti restano nei due calendari';
  AzioneScollegaCalendario.Enabled := Collegato <> FornitoreNessuno;
end;

function TFormAgenda.ScegliFornitoreCalendario(out Fornitore: TFornitoreCalendario): Boolean;
var
  Dialogo: TTaskDialog;
  Pulsante: TTaskDialogBaseButtonItem;
begin
  Fornitore := FornitoreNessuno;

  Dialogo := TTaskDialog.Create(nil);
  try
    Dialogo.Caption := 'Sincronizza calendario';
    Dialogo.Title := 'Con quale calendario vuoi allineare la tua agenda?';
    Dialogo.Text := 'La scelta vale finch' + #233 + ' non scolleghi il calendario.';
    Dialogo.Flags := [tfUseCommandLinks, tfAllowDialogCancellation];
    Dialogo.CommonButtons := [tcbCancel];

    Pulsante := Dialogo.Buttons.Add;
    Pulsante.Caption := 'Outlook';
    Pulsante.ModalResult := 100 + Ord(FornitoreMicrosoft);
    TTaskDialogButtonItem(Pulsante).CommandLinkHint := 'Account di lavoro Microsoft 365';

    Pulsante := Dialogo.Buttons.Add;
    Pulsante.Caption := 'Google Calendar';
    Pulsante.ModalResult := 100 + Ord(FornitoreGoogle);
    TTaskDialogButtonItem(Pulsante).CommandLinkHint := 'Account Google Workspace';

    Result := Dialogo.Execute and (Dialogo.ModalResult >= 100 + Ord(FornitoreMicrosoft));
    if Result then
      Fornitore := TFornitoreCalendario(Dialogo.ModalResult - 100);
  finally
    Dialogo.Free;
  end;
end;

procedure TFormAgenda.SincronizzaCalendario(const Fornitore: TFornitoreCalendario; const Interattiva: Boolean);
var
  Esito: string;
  Riuscita: Boolean;
  Nome: string;
begin
  Nome := TSincronizzazioneCalendario.NomeServizio(Fornitore);
  StartWait(Format('Sincronizzazione con %s...', [Nome]), True);
  try
    Riuscita := TSincronizzazioneCalendario.Sincronizza(Fornitore, Interattiva, Esito);
  finally
    StopWait;
  end;

  if Riuscita then
    FrameScheduler.RefreshScheduler;

  // all'apertura dell'agenda la sincronizzazione e' silenziosa: l'esito resta in USR_UTENTI_CALENDARI_ESTERNI
  if Interattiva then
  begin
    AggiornaAzioniCalendario;
    if Riuscita then
      ConfirmOk(Esito, mtInformation)
    else
      ConfirmOk(Esito, mtWarning);
  end
  else
    SiMain.LogMessage(Format('Sincronizzazione con %s all''apertura: %s', [Nome, Esito]));
end;

procedure TFormAgenda.SincronizzaCalendarioExecute(Sender: TObject);
var
  Fornitore: TFornitoreCalendario;
begin
  // collegato: sempre lo stesso calendario; altrimenti l'unico configurato, o la scelta dell'utente
  Fornitore := TSincronizzazioneCalendario.FornitoreCollegato;
  if Fornitore = FornitoreNessuno then
    if FornitoriCalendario = [FornitoreMicrosoft] then
      Fornitore := FornitoreMicrosoft
    else if FornitoriCalendario = [FornitoreGoogle] then
      Fornitore := FornitoreGoogle
    else if not ScegliFornitoreCalendario(Fornitore) then
      Exit;

  SincronizzaCalendario(Fornitore, True);
end;

procedure TFormAgenda.ScollegaCalendarioExecute(Sender: TObject);
var
  Nome: string;
begin
  Nome := TSincronizzazioneCalendario.NomeServizio(TSincronizzazioneCalendario.FornitoreCollegato);
  if not ConfirmYesNo(Format('Interrompere la sincronizzazione dell''agenda con %s?', [Nome]) + sLineBreak +
    Format('Gli eventi gi' + #224 + ' presenti restano sia in Gesty sia in %s, ma non saranno pi' + #249 + ' allineati.', [Nome]), mtConfirmation) then
    Exit;

  TSincronizzazioneCalendario.Scollega;
  AggiornaAzioniCalendario;
  ConfirmOk(Format('Agenda scollegata da %s.', [Nome]), mtInformation);
end;

procedure TFormAgenda.AfterCreateControls;
begin
  inherited;
  AddLayoutItem(FrameScheduler, 'Calendario', False);
end;

procedure TFormAgenda.Aggiorna;
begin
  SiMain.EnterMethod(Self, 'Aggiorna');
  inherited;
  FrameScheduler.RefreshScheduler;
  SiMain.LeaveMethod(Self, 'Aggiorna');
end;

procedure TFormAgenda.FormShow(Sender: TObject);
var
  Collegato: TFornitoreCalendario;
begin
  SiMain.EnterMethod(Self, 'FormShow');
  inherited;
  FrameScheduler.RefreshScheduler;

  // chi ha gia' collegato un calendario trova l'agenda allineata; senza browser:
  // se l'accesso va rinnovato lo dira' il pulsante di sincronizzazione
  if FornitoriCalendario <> [] then
  begin
    Collegato := TSincronizzazioneCalendario.FornitoreCollegato;
    if Collegato in FornitoriCalendario then
      SincronizzaCalendario(Collegato, False);
  end;

  SiMain.LeaveMethod(Self, 'FormShow');
end;

procedure TFormAgenda.MostraLezioniExecute(Sender: TObject);
begin
  inherited;
  Agenda.MostraLezioni := not Agenda.MostraLezioni;
end;

procedure TFormAgenda.MostraLezioniUpdate(Sender: TObject);
begin
  inherited;
  MostraLezioni.Checked := Agenda.MostraLezioni;
end;

procedure TFormAgenda.MostraRilevamentiExecute(Sender: TObject);
begin
  inherited;
  Agenda.MostraRilevamenti := not Agenda.MostraRilevamenti;
end;

procedure TFormAgenda.MostraRilevamentiUpdate(Sender: TObject);
begin
  inherited;
  MostraRilevamenti.Checked := Agenda.MostraRilevamenti;
end;

procedure TFormAgenda.MostraRiunioniExecute(Sender: TObject);
begin
  inherited;
  Agenda.MostraRiunioni := not Agenda.MostraRiunioni;
end;

procedure TFormAgenda.MostraRiunioniUpdate(Sender: TObject);
begin
  inherited;
  MostraRiunioni.Checked := Agenda.MostraRiunioni;
end;

procedure TFormAgenda.MostraAgendaPersonaleExecute(Sender: TObject);
begin
  inherited;
  Agenda.MostraAgendaPersonale := not Agenda.MostraAgendaPersonale;
end;

procedure TFormAgenda.MostraAgendaPersonaleUpdate(Sender: TObject);
begin
  inherited;
  MostraAgendaPersonale.Checked := Agenda.MostraAgendaPersonale;
end;

procedure TFormAgenda.MostraPrenotazioniAuleExecute(Sender: TObject);
begin
  inherited;
  Agenda.MostraPrenotazioniAule := not Agenda.MostraPrenotazioniAule;
end;

procedure TFormAgenda.MostraPrenotazioniAuleUpdate(Sender: TObject);
begin
  inherited;
  MostraPrenotazioniAule.Checked := Agenda.MostraPrenotazioniAule;
end;

procedure TFormAgenda.MostraChiusureSediExecute(Sender: TObject);
begin
  inherited;
  Agenda.MostraChiusureSedi := not Agenda.MostraChiusureSedi;
end;

procedure TFormAgenda.MostraChiusureSediUpdate(Sender: TObject);
begin
  inherited;
  MostraChiusureSedi.Checked := Agenda.MostraChiusureSedi;
end;

procedure TFormAgenda.MostraInagibilitaAuleExecute(Sender: TObject);
begin
  inherited;
  Agenda.MostraInagibilitaAule := not Agenda.MostraInagibilitaAule;
end;

procedure TFormAgenda.MostraInagibilitaAuleUpdate(Sender: TObject);
begin
  inherited;
  MostraInagibilitaAule.Checked := Agenda.MostraInagibilitaAule;
end;

procedure TFormAgenda.MostraPresenzePersonaleExecute(Sender: TObject);
begin
  inherited;
  Agenda.MostraPresenzePersonale := not Agenda.MostraPresenzePersonale;
end;

procedure TFormAgenda.MostraPresenzePersonaleUpdate(Sender: TObject);
begin
  inherited;
  MostraPresenzePersonale.Checked := Agenda.MostraPresenzePersonale;
end;

procedure TFormAgenda.MostraScadenzeExecute(Sender: TObject);
begin
  inherited;
  Agenda.MostraScadenze := not Agenda.MostraScadenze;
end;

procedure TFormAgenda.MostraScadenzeUpdate(Sender: TObject);
begin
  inherited;
  MostraScadenze.Checked := Agenda.MostraScadenze;
end;

procedure TFormAgenda.MostraAssenzeExecute(Sender: TObject);
begin
  inherited;
  Agenda.MostraAssenze := not Agenda.MostraAssenze;
end;

procedure TFormAgenda.MostraAssenzeUpdate(Sender: TObject);
begin
  inherited;
  MostraAssenze.Checked := Agenda.MostraAssenze;
end;

procedure TFormAgenda.MostraFuoriSedeExecute(Sender: TObject);
begin
  inherited;
  Agenda.MostraFuoriSede := not Agenda.MostraFuoriSede;
end;

procedure TFormAgenda.MostraFuoriSedeUpdate(Sender: TObject);
begin
  inherited;
  MostraFuoriSede.Checked := Agenda.MostraFuoriSede;
end;

procedure TFormAgenda.FrameSchedulerSchedulerCustomDrawContent(Sender: TObject; ACanvas: TcxCanvas; AViewInfo: TcxSchedulerContentCellViewInfo; var ADone: Boolean);
begin
  inherited;
  FrameScheduler.SchedulerCustomDrawContent(Sender, ACanvas, AViewInfo, ADone);

  if not(AViewInfo is TcxSchedulerMonthDayContentCellViewInfo) then
    if EsistePresenza(AViewInfo.TimeStart, AViewInfo.TimeFinish) then
    begin
      AViewInfo.Color := TcxSchedulerPainterHelper.GetContentColor(ACanvas.Brush.Color, False);
      ACanvas.Brush.Style := bsDiagCross;
      AViewInfo.Draw(ACanvas);
      ADone := True;
    end;
end;

function TFormAgenda.EsistePresenza(inizio, fine: TDateTime): Boolean;
begin
  Result := False; // HourOf(inizio) >= 12;
end;

end.

  MostraFuoriSede
