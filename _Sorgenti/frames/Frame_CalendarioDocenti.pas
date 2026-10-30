unit frame_CalendarioDocenti;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ShellAPI,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  System.Actions,
  System.ImageList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ImgList,
  Vcl.ActnList,
  Vcl.ComCtrls,
  Vcl.Menus,
  Vcl.StdCtrls,
  Vcl.StdActns,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxCustomData,
  cxStyles,
  dxScrollbarAnnotations,
  cxTL,
  cxTLdxBarBuiltInMenu,
  cxInplaceContainer,
  cxImageList,
  cxClasses,
  dxBar,
  dxLayoutContainer,
  dxLayoutControl,
  dxLayoutcxEditAdapters,
  dxLayoutControlAdapters,
  cxContainer,
  cxEdit,
  dxCore,
  cxDateUtils,
  cxButtons,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxCalendar,
  dxPSGlbl,
  dxPSUtl,
  dxPSEngn,
  dxPrnPg,
  dxBkgnd,
  dxWrap,
  dxPrnDev,
  dxPSCompsProvider,
  dxPSFillPatterns,
  dxPSEdgePatterns,
  dxPSPDFExportCore,
  dxPSPDFExport,
  cxDrawTextUtils,
  dxPSPrVwStd,
  dxPSPrVwAdv,
  dxPSPrVwRibbon,
  dxPScxPageControlProducer,
  dxPScxTLLnk,
  dxPScxEditorProducers,
  dxPScxExtEditorProducers,
  dxPSCore,
  dxPScxCommon,
  dxShellDialogs,
  Base_Frame,
  dxFileActions,
  CalendarioDocenti.Classes,
  dxPScxSchedulerLnk,
  cxScheduler,
  cxSchedulerStorage,
  cxSchedulerCustomControls,
  cxSchedulerCustomResourceView,
  cxSchedulerDayView,
  cxSchedulerAgendaView,
  cxSchedulerDateNavigator,
  cxSchedulerHolidays,
  cxSchedulerTimeGridView,
  cxSchedulerUtils,
  cxSchedulerWeekView,
  cxSchedulerYearView,
  cxSchedulerGanttView,
  cxSchedulerRecurrence,
  dxBarBuiltInMenu,
  cxSchedulerRibbonStyleEventEditor,
  cxSchedulerTreeListBrowser,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl,
  cxLabel,
  dxPSRichEditControlLnk,
  dxPSdxSpreadSheetLnk,
  cxFilter;

const
  msg_SelezioneDocente = WM_USER + 2845;

type
  TFrameCalendarioDocenti = class(TBaseFrame)
    ActionList: TActionList;
    tree: TcxTreeList;
    dxBarButton1: TdxBarButton;
    dxLayoutControlGroup_Root: TdxLayoutGroup;
    dxLayoutControl: TdxLayoutControl;
    dxLayoutItemTree: TdxLayoutItem;
    dxComponentPrinter: TdxComponentPrinter;
    dxComponentPrinterLinkTree: TcxTreeListReportLink;
    actEsporta: TdxFileSaveAs;
    ColorRepository: TcxStyleRepository;
    Precedente: TAction;
    Successiva: TAction;
    Giorno: TAction;
    Settimana: TAction;
    dxLayoutItemScheduler: TdxLayoutItem;
    Scheduler: TcxScheduler;
    dxLayoutGroupTab: TdxLayoutGroup;
    Elenco: TAction;
    labelDocente: TcxLabel;
    dxLayoutItemLabelDocente: TdxLayoutItem;
    dxLayoutGroupScheduler: TdxLayoutGroup;
    dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItem3: TdxLayoutEmptySpaceItem;
    btnElenco: TcxButton;
    dxLayoutItemElencoDocenti: TdxLayoutItem;
    dxLayoutGroupDocente: TdxLayoutGroup;
    dxComponentPrinterLinkScheduler: TcxSchedulerReportLink;
    dxLayoutItemBar: TdxLayoutItem;
    dxBarDockControl: TdxBarDockControl;
    dxBarManagerBar: TdxBar;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    Oggi: TAction;
    VaiAlGiorno: TAction;
    dxBarButton7: TdxBarButton;
    dxBarButton8: TdxBarButton;
    procedure dxComponentPrinterLinkTreeInitializeCell(Sender: TcxTreeListCustomReportLink; ANode: TcxTreeListNode; AColumn: TcxTreeListColumn; AnItem: TAbstractdxReportCellData);
    procedure actEsportaAccept(Sender: TObject);
    procedure ElencoExecute(Sender: TObject);
    procedure GiornoExecute(Sender: TObject);
    procedure OggiExecute(Sender: TObject);
    procedure PrecedenteExecute(Sender: TObject);
    procedure SchedulerDblClick(Sender: TObject);
    procedure SettimanaExecute(Sender: TObject);
    procedure SuccessivaExecute(Sender: TObject);
    procedure treeDblClick(Sender: TObject);
    procedure treeStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; var AStyle: TcxStyle);
    procedure VaiAlGiornoExecute(Sender: TObject);
  private type
    TVistaGiornalieraSettimanale = (vgsGiornaliera, vgsSettimanale);
  private
    FVistaGiornalieraSettimanale: TVistaGiornalieraSettimanale;
    procedure SetVistaGiornalieraSettimanale(const Value: TVistaGiornalieraSettimanale);
    property VistaGiornalieraSettimanale: TVistaGiornalieraSettimanale read FVistaGiornalieraSettimanale write SetVistaGiornalieraSettimanale;
  private
    function getColorStyle(Color: TColor): TcxStyle;
    function CreateBand(const Caption: string; const Width: integer; Style: TcxStyle): TcxTreeListBand;
    function CreateColumn(band: TcxTreeListBand; const Name, Caption: string; const Width: integer): TcxTreeListColumn;
    procedure DestroyStructure;
    procedure CreateStructure;
  private
    procedure HandleSelezioneDocente(var Message: TMessage); message msg_SelezioneDocente;
  private
    FSelectedDocente: integer;

    procedure SetSelectedDocente(const Value: integer);
    property SelectedDocente: integer read FSelectedDocente write SetSelectedDocente;
  private
    FStartDate: TDate;

    procedure SetStartDate(const Value: TDate);
    procedure IncrementaPeriodo(Incrementa: Boolean);
    procedure LoadCalendario;
    procedure LoadTree;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  public
    CalendarioLezioniDocenti: TCalendarioLezioniDocenti;

    procedure Show;
    procedure Stampa;
    procedure Esporta(const FileName: string);

    property StartDate: TDate read FStartDate write SetStartDate;
  end;

implementation

uses
  System.DateUtils,
  System.IoUtils,
  System.Math,
  cxTLExportLink,
  zdx,
  zBaseLib,
  dmCalendarioDocenti,
  zMsg;

{$R *.dfm}
{ TFrameCalendarioDocenti }

constructor TFrameCalendarioDocenti.Create(aOwner: TComponent);
begin
  inherited;
  dx.InitBar(dxBarManagerBar);
  dx.InitLayoutControl(dxLayoutControl);
  dx.initTreeList(tree);
  dx.InitScheduler(Scheduler);
  dx.InitPrinter(dxComponentPrinter);

  dxLayoutGroupTab.TabbedOptions.HideTabs := true;
  dxLayoutGroupTab.ItemIndex := 0;

  CalendarioLezioniDocenti := TCalendarioLezioniDocenti.Create;

  FSelectedDocente := -1;
  labelDocente.Caption := 'Docente: ';

  FVistaGiornalieraSettimanale := vgsGiornaliera;

  FStartDate := StartOfTheWeek(Date);
  VaiAlGiorno.Caption := DateToStr(StartDate);
end;

destructor TFrameCalendarioDocenti.Destroy;
begin
  FreeAndNil(CalendarioLezioniDocenti);
  inherited;
end;

procedure TFrameCalendarioDocenti.DestroyStructure;
var
  i: integer;
  col: TcxTreeListColumn;
begin

  for i := tree.ColumnCount - 1 downto 0 do
  begin
    col := tree.Columns[i];
    col.Free;
  end;

  tree.Bands.Clear;
end;

function TFrameCalendarioDocenti.CreateBand(const Caption: string; const Width: integer; Style: TcxStyle): TcxTreeListBand;
begin
  result := tree.Bands.Add;
  result.Caption.Text := Caption;
  result.Caption.AlignHorz := taCenter;
  result.Width := Width;
  result.Styles.Content := Style;
end;

function TFrameCalendarioDocenti.CreateColumn(band: TcxTreeListBand; const Name, Caption: string; const Width: integer): TcxTreeListColumn;
begin
  result := tree.CreateColumn(band);
  result.Name := Name;
  result.Caption.Text := Caption;
  result.DataBinding.ValueType := 'String';
  // result.Position.BandIndex := 0;
  // result.Position.RowIndex := 0;
  // result.Position.ColIndex := tree.ColumnCount;
  result.Options.IncSearch := False;
  result.Options.Moving := False;
  result.Options.Sorting := False;
  result.Focused := true;
  result.Width := Width;

  result.Styles.Header := dx.GetStyle(scBtnFace);
end;

procedure TFrameCalendarioDocenti.CreateStructure;
var
  band: TcxTreeListBand;
  col: TcxTreeListColumn;
  Giorno: TGiorno;
  Ora: TOra;
  colName: string;
  bandWidth: integer;
const
  DocentWidth = 200;
  GiornoWidth = 141;
  OraWidth = 80;
begin
  DestroyStructure;

  band := CreateBand('Docenti', DocentWidth, dx.cxStyleBtnFace);
  band.FixedKind := tlbfLeft;
  col := CreateColumn(band, 'colDocenti', '', DocentWidth);
  col.Position.LineCount := 2;
  col.Options.IncSearch := true;
  tree.OptionsBehavior.IncSearchItem := col;

  for Giorno in CalendarioLezioniDocenti.ElencoGiorni do
  begin
    bandWidth := Max(GiornoWidth, (OraWidth + 1) * Giorno.Ore.Count);
    band := CreateBand(FormatDateTime('dddd, dd mmm yyyy', Giorno.DataLezione), bandWidth, nil);

    for Ora in Giorno.Ore do
    begin
      colName := 'colSigla' + CalendarioLezioniDocenti.GetColumnName(Giorno.DataLezione, Ora.OraInizio);
      col := CreateColumn(band, colName, FormatDateTime('HH:MM', Ora.OraInizio), OraWidth);
      Ora.ColonnaProgetto := col;

      colName := 'colAula' + CalendarioLezioniDocenti.GetColumnName(Giorno.DataLezione, Ora.OraInizio);
      col := CreateColumn(band, colName, '', OraWidth);
      col.Position.RowIndex := 1;
      Ora.ColonnaAula := col;
    end;
  end;
end;

procedure TFrameCalendarioDocenti.LoadTree;
var
  node: TcxTreeListNode;
  ColonnaProgetto, ColonnaAula: TcxTreeListColumn;
  Docente: TDocente;
  idxDocente: integer;
  Lezione: TLezione;
begin
  StartWait('Attendere...', true);
  try
    tree.BeginUpdate;
    try
      tree.Clear;

      CreateStructure;

      for Docente in CalendarioLezioniDocenti.ElencoDocenti do
      begin
        node := tree.Add;
        Docente.node := node;
        node.Texts[0] := Docente.Nominativo;

        for Lezione in Docente.Lezioni do
        begin
          //
          if not CalendarioLezioniDocenti.GetColumns(Lezione.DataLezione, Lezione.OraInizio, ColonnaProgetto, ColonnaAula) then
            raise Exception.Create('Errore struttura: Data: ' + DateToStr(Lezione.DataLezione) + ' - Ora: ' + TimeToStr(Lezione.OraInizio));

          node.Texts[ColonnaProgetto.ItemIndex] := ' ' + Lezione.SiglaProgetto;
          node.Texts[ColonnaAula.ItemIndex] := ' ' + Lezione.Aula;

          Lezione.ColonnaProgetto := ColonnaProgetto;
          Lezione.ColonnaAula := ColonnaAula;
        end;
      end;
    finally
      tree.EndUpdate;
    end;
  finally
    StopWait;
  end;
end;

procedure TFrameCalendarioDocenti.actEsportaAccept(Sender: TObject);
begin
  inherited;
  Esporta(actEsporta.Dialog.FileName);
end;

function TFrameCalendarioDocenti.getColorStyle(Color: TColor): TcxStyle;
var
  i: integer;
begin
  result := nil;

  for i := 0 to ColorRepository.Count - 1 do
    if ColorRepository.Items[i] is TcxStyle then
      if TcxStyle(ColorRepository.Items[i]).Color = Color then
      begin
        result := TcxStyle(ColorRepository.Items[i]);
        exit;
      end;

  result := TcxStyle(ColorRepository.CreateItem(TcxStyle));
  result.Color := Color;
  result.TextColor := GetContrastColor(Color);
end;

procedure TFrameCalendarioDocenti.PrecedenteExecute(Sender: TObject);
begin
  IncrementaPeriodo(False);
end;

procedure TFrameCalendarioDocenti.SuccessivaExecute(Sender: TObject);
begin
  IncrementaPeriodo(true);
end;

procedure TFrameCalendarioDocenti.treeDblClick(Sender: TObject);
var
  Lezione: TLezione;
  Docente: TDocente;
begin

  if tree.HitTest.HitAtNode then
    if tree.HitTest.HitAtColumn then
    begin
      if tree.HitTest.HitColumn.Position.BandIndex = 0 then
      begin

        Docente := CalendarioLezioniDocenti.ElencoDocenti.GetDocente(tree.HitTest.HitNode);
        if assigned(Docente) then
        begin
          labelDocente.Caption := 'Docente: ' + Docente.Nominativo;
          PostMessage(Self.Handle, msg_SelezioneDocente, 0, Docente.IdDocente);
        end;
      end
      else
        if CalendarioLezioniDocenti.GetLezione(tree.HitTest.HitNode, tree.HitTest.HitColumn, Lezione) then
          // ConfirmOk('Modificare IdOrario: ' + Lezione.IdOrario.ToString);
          if dmCalendarioDocenti.CalendarioDocenti.ApriOrario(Lezione.IdOrario) then
            LoadTree;
    end;
end;

procedure TFrameCalendarioDocenti.ElencoExecute(Sender: TObject);
begin
  inherited;
  PostMessage(Self.Handle, msg_SelezioneDocente, 0, -1);
end;

procedure TFrameCalendarioDocenti.HandleSelezioneDocente(var Message: TMessage);
begin
  SelectedDocente := Message.LParam;
end;

procedure TFrameCalendarioDocenti.treeStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; var AStyle: TcxStyle);
var
  Lezione: TLezione;
begin

  if assigned(AColumn) then
  begin
    if odd(AColumn.Position.BandIndex) then
      AStyle := dx.cxStyleContentOdd
    else
      AStyle := dx.cxStyleContentEven;

    if assigned(ANode) then
      if CalendarioLezioniDocenti.GetLezione(ANode, AColumn, Lezione) then
        AStyle := getColorStyle(Lezione.Colore);
  end;
end;

procedure TFrameCalendarioDocenti.dxComponentPrinterLinkTreeInitializeCell(Sender: TcxTreeListCustomReportLink; ANode: TcxTreeListNode; AColumn: TcxTreeListColumn; AnItem: TAbstractdxReportCellData);
var
  Lezione: TLezione;
begin

  if assigned(AColumn) then
    if assigned(ANode) then
      if CalendarioLezioniDocenti.GetLezione(ANode, AColumn, Lezione) then
      begin
        AnItem.Color := Lezione.Colore;
        // AnItem.Font.Color := GetContrastColor(AnItem.Color);
      end;
end;

procedure TFrameCalendarioDocenti.GiornoExecute(Sender: TObject);
begin
  inherited;
  VistaGiornalieraSettimanale := vgsGiornaliera;
end;

procedure TFrameCalendarioDocenti.SettimanaExecute(Sender: TObject);
begin
  inherited;
  VistaGiornalieraSettimanale := vgsSettimanale;
end;

procedure TFrameCalendarioDocenti.IncrementaPeriodo(Incrementa: Boolean);
var
  Data: TDateTime;
  Delta: smallint;
begin
  if Incrementa then
    Delta := 1
  else
    Delta := -1;

  case VistaGiornalieraSettimanale of
    vgsGiornaliera:
      StartDate := IncDay(StartDate, Delta);
    vgsSettimanale:
      StartDate := IncWeek(StartOfTheWeek(StartDate), Delta);
  end;
end;

procedure TFrameCalendarioDocenti.SetStartDate(const Value: TDate);
begin

  if FStartDate <> Value then
  begin
    FStartDate := Value;
    VaiAlGiorno.Caption := DateToStr(StartDate);
    LoadCalendario;
  end;
end;

procedure TFrameCalendarioDocenti.LoadCalendario;
var
  DalGiorno, AlGiorno: TDate;
  IdDocente: integer;
begin
  DalGiorno := StartDate;

  case VistaGiornalieraSettimanale of
    vgsGiornaliera:
      AlGiorno := StartDate;
    vgsSettimanale:
      AlGiorno := EndOfTheWeek(StartDate);
  end;

  IdDocente := SelectedDocente;

  if not assigned(Scheduler.Storage) then
    Scheduler.Storage := dmCalendarioDocenti.CalendarioDocenti.cxSchedulerStorage;

  dmCalendarioDocenti.CalendarioDocenti.LoadCalendarioDocenti(DalGiorno, AlGiorno, IdDocente, CalendarioLezioniDocenti);
  LoadTree;

  /// ////////////////////////////////////

  case VistaGiornalieraSettimanale of
    vgsGiornaliera:
      begin
        Scheduler.GoToDate(StartDate, vmDay);
        Scheduler.ViewDay.Active := true;
      end;
    vgsSettimanale:
      begin
        Scheduler.GoToDate(StartDate, vmWeek);
        // Scheduler.ViewWeek.Active := true;
        // Scheduler.SelectDays(StartDate, EndOfTheWeek(StartDate));
        Scheduler.ViewDay.Active := true;
      end;
  end;

  Scheduler.LayoutChanged;
end;

procedure TFrameCalendarioDocenti.SetSelectedDocente(const Value: integer);
begin
  SiMain.EnterMethod(Self, 'SetSelectedDocente');

  FSelectedDocente := Value;

  LoadCalendario;

  if SelectedDocente = -1 then
    dxLayoutGroupTab.ItemIndex := 0
  else
    dxLayoutGroupTab.ItemIndex := 1;

  actEsporta.Enabled := SelectedDocente = -1;

  SiMain.LeaveMethod(Self, 'SetSelectedDocente');
end;

procedure TFrameCalendarioDocenti.SetVistaGiornalieraSettimanale(const Value: TVistaGiornalieraSettimanale);
begin
  FVistaGiornalieraSettimanale := Value;
  LoadCalendario;
end;

procedure TFrameCalendarioDocenti.Show;
begin
  LoadCalendario;
  dxLayoutGroupTab.ItemIndex := 0;
end;

procedure TFrameCalendarioDocenti.Esporta(const FileName: string);
var
  i: integer;
begin
  inherited;

  if SelectedDocente = -1 then
    cxExportTLToXLSX(FileName, tree, true, true, true)
  else
    exit; { TODO : Gestire? }

  if ConfirmYesNo('Si desidera aprire il file esportato?') then
  begin
    i := ShellExecute(0, 'open', Pchar(FileName), nil, nil, SW_RESTORE);

    // se non riesce ad aprire il file apre la cartella
    if i <= 32 then
      ShellExecute(0, Pchar('open'), Pchar(ExtractFilePath(FileName)), nil, nil, SW_RESTORE);
    // ConfirmOk(FileName + ': ' + i.ToString);
  end;
end;

procedure TFrameCalendarioDocenti.SchedulerDblClick(Sender: TObject);
var
  IdOrario: integer;
begin
  inherited;

  if Scheduler.SelectedEventCount > 0 then
  begin
    IdOrario := Scheduler.SelectedEvents[0].GetCustomFieldValueByName('ID_ORARIO');

    if IdOrario <> -1 then
      dmCalendarioDocenti.CalendarioDocenti.ApriOrario(IdOrario);
  end;
end;

procedure TFrameCalendarioDocenti.Stampa;
begin
  dxComponentPrinterLinkTree.PrinterPage.Orientation := poLandscape;

  dxComponentPrinterLinkScheduler.PrinterPage.Orientation := poLandscape;
  dxComponentPrinterLinkScheduler.PrintStyles.Weekly.DaysLayout := wdlOneColumn;
  dxComponentPrinterLinkScheduler.ReportTitle.Text := labelDocente.Caption;

  // if FSelectedDocente = 0 then
  if SelectedDocente = -1 then
    dxComponentPrinterLinkTree.Preview(true)
  else
    dxComponentPrinterLinkScheduler.Preview(true);
end;

procedure TFrameCalendarioDocenti.OggiExecute(Sender: TObject);
begin
  inherited;
  StartDate := Date;
end;

procedure TFrameCalendarioDocenti.VaiAlGiornoExecute(Sender: TObject);
var
  Data: TDate;
begin
  inherited;

  Data := StartDate;

  if zMsg.InputDate('Seleziona data', 'Seleziona data', Data) then
    StartDate := Data;
end;

end.

  zrestrictions.form zdx
