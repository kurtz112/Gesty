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
  cxSchedulerDialogs,
  cxSchedulerOutlookExchange,
  zDm_Images,
  zdx;
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
  SiMain.LeaveMethod(Self, 'CreateDataModule');
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

  SiMain.LeaveMethod(Self, 'Create');
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
begin
  SiMain.EnterMethod(Self, 'FormShow');
  inherited;
  FrameScheduler.RefreshScheduler;
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
