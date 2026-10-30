unit frame_CalendarioAule;

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
  dxScrollbarAnnotations,
  dxBar,
  dxLayoutContainer,
  dxLayoutControl,
  dxLayoutcxEditAdapters,
  dxLayoutControlAdapters,
  dxCore,
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
  dxFileActions,
  dxPScxSchedulerLnk,
  dxBarBuiltInMenu,
  dxPSRichEditControlLnk,
  dxPSdxSpreadSheetLnk,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxCustomData,
  cxStyles,
  cxTL,
  cxTLdxBarBuiltInMenu,
  cxInplaceContainer,
  cxImageList,
  cxClasses,
  cxContainer,
  cxEdit,
  cxDateUtils,
  cxButtons,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxCalendar,
  cxDrawTextUtils,
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
  cxSchedulerRibbonStyleEventEditor,
  cxSchedulerTreeListBrowser,
  cxLabel,
  cxFilter,
  Base_Frame,
  CalendarioAule.Classes,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl,
  cxMemo,
  dxPSdxPDFViewerLnk;

const
  msg_SelezioneAula = WM_USER + 2885;

type
  TFrameCalendarioAule = class(TBaseFrame)
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
    labelAula: TcxLabel;
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
    PrintStyleRepository: TcxStyleRepository;
    PrintTreeStyle: TcxStyle;
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
    function CreateBand(const Caption: string; const Width: Integer; Style: TcxStyle): TcxTreeListBand;
    function CreateColumn(band: TcxTreeListBand; const Name, Caption: string; const Width: Integer; const LineCount: Integer; propClass: TcxCustomEditPropertiesClass): TcxTreeListColumn;
    procedure CreateStructure;
    procedure DestroyStructure;
  private
    procedure TreeBeforePrint;
    procedure TreeAfterPrint;
  private
    procedure HandleSelezioneAula(var Message: TMessage); message msg_SelezioneAula;
  private
    FSelectedAula: string;

    procedure SetSelectedAula(const Value: string);
    property SelectedAula: string read FSelectedAula write SetSelectedAula;
  private
    FIdSede: Integer;
    FStartDate: TDate;
    StampaInCorso: boolean;

    procedure SetStartDate(const Value: TDate);
    procedure IncrementaPeriodo(Incrementa: boolean);
    procedure LoadCalendario;
    procedure LoadTree;
  private
    procedure SedeChanged(Sender: TObject);
    procedure SetIdSede(const Value: Integer);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  public
    CalendarioLezioniAule: TCalendarioLezioniAule;

    procedure Show;
    procedure Stampa;
    procedure Esporta(const FileName: string);

    property StartDate: TDate read FStartDate write SetStartDate;
    property IdSede: Integer read FIdSede write SetIdSede;
  end;

implementation

uses
  System.DateUtils,
  System.IOUtils,
  System.Math,
  cxTLExportLink,
  cxBarEditItem,
  zDX,
  zBaseLib,
  dmCalendarioAule,
  zMsg,
  dmScheduler.Tools,
  Gesty.Types,
  zSystem,
  Gesty_Filters;

{$R *.dfm}
{ TFrameCalendarioAule }

constructor TFrameCalendarioAule.Create(aOwner: TComponent);
begin
  inherited;
  FIdSede := -1;
  StampaInCorso := False;

  dx.InitBar(dxBarManagerBar);
  dx.InitLayoutControl(dxLayoutControl);
  dx.initTreeList(tree);
  dx.InitScheduler(Scheduler);
  dx.InitPrinter(dxComponentPrinter);

  dxLayoutGroupTab.TabbedOptions.HideTabs := true;
  dxLayoutGroupTab.ItemIndex := 0;

  CalendarioLezioniAule := TCalendarioLezioniAule.Create;

  FSelectedAula := '';
  labelAula.Caption := 'Aula: ';

  FVistaGiornalieraSettimanale := vgsGiornaliera;

  FStartDate := StartOfTheWeek(Date);
  VaiAlGiorno.Caption := DateToStr(StartDate);
end;

destructor TFrameCalendarioAule.Destroy;
begin
  FreeAndNil(CalendarioLezioniAule);
  inherited;
end;

procedure TFrameCalendarioAule.DestroyStructure;
var
  i: Integer;
  col: TcxTreeListColumn;
begin

  for i := tree.ColumnCount - 1 downto 0 do
  begin
    col := tree.Columns[i];
    col.Free;
  end;

  tree.Bands.Clear;
end;

function TFrameCalendarioAule.CreateBand(const Caption: string; const Width: Integer; Style: TcxStyle): TcxTreeListBand;
begin
  result := tree.Bands.Add;
  result.Caption.Text := Caption;
  result.Caption.AlignHorz := TAlignment.taLeftJustify;
  result.Width := Width;
  result.Styles.Content := Style;
end;

function TFrameCalendarioAule.CreateColumn(band: TcxTreeListBand; const Name, Caption: string; const Width: Integer; const LineCount: Integer; propClass: TcxCustomEditPropertiesClass): TcxTreeListColumn;
begin
  result := tree.CreateColumn(band);
  result.Name := Name;
  result.Caption.Text := Caption;
  result.Caption.MultiLine := true;
  result.DataBinding.ValueType := 'String';
  result.Caption.AlignHorz := taCenter;
  // result.Position.BandIndex := 0;
  // result.Position.RowIndex := 0;
  // result.Position.ColIndex := tree.ColumnCount;
  result.Options.IncSearch := False;
  result.Options.Moving := False;
  result.Options.Sorting := False;
  result.Focused := true;
  result.Width := Width;
  result.Position.LineCount := LineCount;

  result.Styles.Header := dx.GetStyle(scBtnFace);

  result.PropertiesClass := propClass;
end;

procedure TFrameCalendarioAule.CreateStructure;
var
  band: TcxTreeListBand;
  col: TcxTreeListColumn;
  Giorno: TGiorno;
  Ora: TOra;
  colName: string;
  bandWidth: Integer;
const
  AulaWidth = 250;
  OraWidth = 150; // 150
  MinGiornoWidth = 141;
begin
  DestroyStructure;

  band := CreateBand('Aula', AulaWidth, dx.cxStyleBtnFace);
  band.FixedKind := tlbfLeft;
  col := CreateColumn(band, 'colAula', '', AulaWidth, 4, TcxMemoProperties);
  // TcxTextEditProperties(col.Properties).Alignment.Vert := taVCenter;

  col.Options.IncSearch := true;
  tree.OptionsBehavior.IncSearchItem := col;

  for Giorno in CalendarioLezioniAule.ElencoGiorni do
  begin
    bandWidth := Max(MinGiornoWidth, (OraWidth + 1) * Giorno.Ore.Count);
    band := CreateBand(FormatDateTime('dddd, dd mmm yyyy', Giorno.DataLezione), bandWidth, nil);

    for Ora in Giorno.Ore do
    begin
      colName := 'colSuperiore' + CalendarioLezioniAule.GetColumnName(Giorno.DataLezione, Ora.OraInizio);
      { TODO : qui }
      // col := CreateColumn(band, colName, '', OraWidth, 4);
      col := CreateColumn(band, colName, Ora.ColumnCaption, OraWidth, 4, TcxMemoProperties);
      Ora.ColonnaSuperiore := col;
      { TODO : qui }
      // colName := 'colInferiore' + CalendarioLezioniAule.GetColumnName(Giorno.DataLezione, Ora.OraInizio);
      // col := CreateColumn(band, colName, Ora.ColumnCaption, OraWidth, 2);
      // col.Position.RowIndex := 1;
      // Ora.ColonnaInferiore := col;
    end;
  end;
end;

procedure TFrameCalendarioAule.LoadTree;
var
  node: TcxTreeListNode;
  ColonnaSuperiore, ColonnaInferiore: TcxTreeListColumn;
  aula: TAula;
  idxDocente: Integer;
  Evento: TEvento;
begin
  StartWait('Attendere...', true);
  try
    tree.BeginUpdate;
    try
      tree.Clear;

      CreateStructure;

      for aula in CalendarioLezioniAule.ElencoAule do
      begin
        node := tree.Add;
        aula.node := node;
        node.Texts[0] := aula.DescAula;

        for Evento in aula.Eventi do
        begin
          //
          if not CalendarioLezioniAule.GetColumns(Evento.DataCalendario, Evento.OraInizio, ColonnaSuperiore, ColonnaInferiore) then
            raise Exception.Create('Errore struttura: Data: ' + DateToStr(Evento.DataCalendario) + ' - Ora: ' + TimeToStr(Evento.OraInizio));

          { TODO : qui }
          node.Texts[ColonnaSuperiore.ItemIndex] := ' ' + Evento.Titolo.Substring(0, 30).Trim + slinebreak + slinebreak + Evento.Nominativo;

          // node.Texts[ColonnaSuperiore.ItemIndex] := ' ' + Evento.Titolo;
          // node.Texts[ColonnaInferiore.ItemIndex] := ' ' + Evento.Nominativo;

          Evento.ColonnaSuperiore := ColonnaSuperiore;
          Evento.ColonnaInferiore := ColonnaInferiore;
        end;
      end;
    finally
      tree.EndUpdate;
    end;
  finally
    StopWait;
  end;
end;

procedure TFrameCalendarioAule.actEsportaAccept(Sender: TObject);
begin
  inherited;
  Esporta(actEsporta.Dialog.FileName);
end;

function TFrameCalendarioAule.getColorStyle(Color: TColor): TcxStyle;
var
  i: Integer;
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

procedure TFrameCalendarioAule.PrecedenteExecute(Sender: TObject);
begin
  IncrementaPeriodo(False);
end;

procedure TFrameCalendarioAule.SuccessivaExecute(Sender: TObject);
begin
  IncrementaPeriodo(true);
end;

procedure TFrameCalendarioAule.treeStylesGetContentStyle(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn; ANode: TcxTreeListNode; var AStyle: TcxStyle);
var
  Evento: TEvento;
begin

  if not StampaInCorso then
    if assigned(AColumn) then
    begin
      if odd(AColumn.Position.BandIndex) then
        AStyle := dx.cxStyleContentOdd
      else
        AStyle := dx.cxStyleContentEven;

      if assigned(ANode) then
        if CalendarioLezioniAule.GetEvento(ANode, AColumn, Evento) then
          AStyle := getColorStyle(Evento.Colore);
    end;
end;

procedure TFrameCalendarioAule.GiornoExecute(Sender: TObject);
begin
  inherited;
  VistaGiornalieraSettimanale := vgsGiornaliera;
end;

procedure TFrameCalendarioAule.SettimanaExecute(Sender: TObject);
begin
  inherited;
  VistaGiornalieraSettimanale := vgsSettimanale;
end;

procedure TFrameCalendarioAule.IncrementaPeriodo(Incrementa: boolean);
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

procedure TFrameCalendarioAule.SetStartDate(const Value: TDate);
begin

  if FStartDate <> Value then
  begin
    FStartDate := Value;
    VaiAlGiorno.Caption := DateToStr(StartDate);
    LoadCalendario;
  end;
end;

procedure TFrameCalendarioAule.LoadCalendario;
var
  DalGiorno, AlGiorno: TDate;
  aula: string;
begin
  DalGiorno := StartDate;

  case VistaGiornalieraSettimanale of
    vgsGiornaliera:
      AlGiorno := StartDate;
    vgsSettimanale:
      AlGiorno := EndOfTheWeek(StartDate);
  end;

  aula := SelectedAula;

  if not assigned(Scheduler.Storage) then
    Scheduler.Storage := dmCalendarioAule.CalendarioAule.cxSchedulerStorage;

  dmCalendarioAule.CalendarioAule.LoadCalendarioAule(DalGiorno, AlGiorno, aula, IdSede, CalendarioLezioniAule);
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

procedure TFrameCalendarioAule.SetSelectedAula(const Value: string);
begin
  SiMain.EnterMethod(Self, 'SetSelectedAula');

  FSelectedAula := Value;

  LoadCalendario;

  if SelectedAula.IsEmpty then
    dxLayoutGroupTab.ItemIndex := 0
  else
    dxLayoutGroupTab.ItemIndex := 1;

  actEsporta.Enabled := SelectedAula.IsEmpty;

  SiMain.LeaveMethod(Self, 'SetSelectedAula');
end;

procedure TFrameCalendarioAule.SetVistaGiornalieraSettimanale(const Value: TVistaGiornalieraSettimanale);
begin
  FVistaGiornalieraSettimanale := Value;
  LoadCalendario;
end;

procedure TFrameCalendarioAule.Show;
begin

  LoadCalendario;

  // Tools.AddFiltroSede(dxBarManagerBar, SedeChanged, ivDefault, 0);
  TSedeBarFilter.ApplyTo(dxBarManagerBar, SedeChanged, ivDefault, 0);

  dxLayoutGroupTab.ItemIndex := 0;
end;

procedure TFrameCalendarioAule.Esporta(const FileName: string);
var
  i: Integer;
begin
  inherited;

  if SelectedAula.IsEmpty then
    cxExportTLToXLSX(FileName, tree, true, true, true)
  else
    exit; { TODO : Gestire? }

  if ConfirmYesNo('Si desidera aprire il file esportato?', mtWarning) then
  begin
    i := ShellExecute(0, 'open', Pchar(FileName), nil, nil, SW_RESTORE);

    // se non riesce ad aprire il file apre la cartella
    if i <= 32 then
      ShellExecute(0, Pchar('open'), Pchar(ExtractFilePath(FileName)), nil, nil, SW_RESTORE);
    // ConfirmOk(FileName + ': ' + i.ToString);
  end;
end;

procedure TFrameCalendarioAule.SchedulerDblClick(Sender: TObject);
var
  IdOrario: Integer;
begin
  inherited;

  if Scheduler.SelectedEventCount > 0 then
  begin
    IdOrario := Scheduler.SelectedEvents[0].GetCustomFieldValueByName('ID_ORARIO');

    if IdOrario <> -1 then
      dmCalendarioAule.CalendarioAule.ApriOrario(IdOrario);
  end;
end;

procedure TFrameCalendarioAule.Stampa;
begin

  // Tree
  dxComponentPrinterLinkTree.PrinterPage.Orientation := poLandscape;
  dxComponentPrinterLinkTree.ReportTitle.Text := 'Calendario occupazione aule ' + DateToStr(StartDate);
  dxComponentPrinterLinkTree.OptionsFormatting.GridLineColor := clBlack;
  dxComponentPrinterLinkTree.OptionsFormatting.UseNativeStyles := true; // bianco e nero
  // dxComponentPrinterLinkTree.OptionsSize.AutoWidth := true;
  dxComponentPrinterLinkTree.OptionsView.BandHeaders := False;

  // Scheduler
  dxComponentPrinterLinkScheduler.PrinterPage.Orientation := poLandscape;
  dxComponentPrinterLinkScheduler.PrintStyles.Weekly.DaysLayout := wdlOneColumn;
  dxComponentPrinterLinkScheduler.ReportTitle.Text := labelAula.Caption;

  /// //////////////////////////////

  if SelectedAula.IsEmpty then
  begin
    TreeBeforePrint;
    try
      dxComponentPrinterLinkTree.Preview(true);
    finally
      TreeAfterPrint;
    end;
  end
  else
    dxComponentPrinterLinkScheduler.Preview(true);
end;

procedure TFrameCalendarioAule.OggiExecute(Sender: TObject);
begin
  inherited;
  StartDate := Date;
end;

procedure TFrameCalendarioAule.VaiAlGiornoExecute(Sender: TObject);
var
  Data: TDate;
begin
  inherited;

  Data := StartDate;

  if zMsg.InputDate('Seleziona data', 'Seleziona data', Data) then
    StartDate := Data;
end;

procedure TFrameCalendarioAule.treeDblClick(Sender: TObject);
var
  params: TEventoParams;
  Evento: TEvento;
  aula: TAula;
begin

  if tree.HitTest.HitAtNode then
    if tree.HitTest.HitAtColumn then
    begin
      if tree.HitTest.HitColumn.Position.BandIndex = 0 then
      begin
        aula := CalendarioLezioniAule.ElencoAule.GetAula(tree.HitTest.HitNode);

        if assigned(aula) then
        begin
          labelAula.Caption := 'Aula: ' + aula.DescAula;
          PostMessage(Self.Handle, msg_SelezioneAula, 0, aula.Index);
        end;
      end
      else
        if CalendarioLezioniAule.GetEvento(tree.HitTest.HitNode, tree.HitTest.HitColumn, Evento) then
        begin
          params.Init;
          params.TipoEvento := Evento.TipoEvento;

          if params.TipoEvento <> teNull then
          begin
            params.id := Evento.IdEvento;

            if params.id <> -1 then
              if SchedulerTools.ApriEvento(params) then
                LoadTree;
            // ConfirmOk('Modificare IdOrario: ' + Evento.IdOrario.ToString);
            // if dmCalendarioAule.CalendarioAule.ApriOrario(Evento.IdOrario) then
          end;
        end;
    end;
end;

procedure TFrameCalendarioAule.ElencoExecute(Sender: TObject);
begin
  inherited;
  PostMessage(Self.Handle, msg_SelezioneAula, 0, -1);
end;

procedure TFrameCalendarioAule.HandleSelezioneAula(var Message: TMessage);
var
  idxAula: Integer;
begin
  idxAula := Message.LParam;

  if idxAula >= 0 then
    SelectedAula := CalendarioLezioniAule.ElencoAule.Items[idxAula].aula
  else
    SelectedAula := '';
end;

procedure TFrameCalendarioAule.SedeChanged(Sender: TObject);
var
  cxBarEditItem: TcxBarEditItem;
  v: variant;
begin

  if Sender is TcxBarEditItem then
  begin
    cxBarEditItem := TcxBarEditItem(Sender);
    v := cxBarEditItem.EditValue;

    if VarIsNull(v) then
      IdSede := -1
    else
      IdSede := v;
  end;
end;

procedure TFrameCalendarioAule.SetIdSede(const Value: Integer);
begin
  FIdSede := Value;
  LoadCalendario;
end;

procedure TFrameCalendarioAule.TreeBeforePrint;
var
  i: Integer;
begin
  StampaInCorso := true;

  dxComponentPrinterLinkTree.PDFExportOptions.DefaultFileName := 'Calendario occupazione aule ' + DateToStr(StartDate);

  tree.Styles.Background := nil;
  tree.Styles.ColumnHeader := PrintTreeStyle;
  tree.Styles.Content := PrintTreeStyle;
  tree.Styles.Footer := nil;

  tree.Bands[0].Width := 700;
  tree.Columns[0].Width := 700;

  for i := 1 to tree.ColumnCount - 1 do
  begin
    tree.Columns[i].Width := 100;
    tree.Columns[i].Caption.Text := StringReplace(tree.Columns[i].Caption.Text, ' - ', slinebreak, []);
  end;

  for i := 0 to tree.ColumnCount - 1 do
    tree.Columns[i].Position.LineCount := 1;

  dxComponentPrinterLinkTree.OptionsSize.AutoWidth := true;
end;

procedure TFrameCalendarioAule.TreeAfterPrint;
var
  i: Integer;
begin
  dxComponentPrinterLinkTree.PDFExportOptions.DefaultFileName := '';
  dxComponentPrinterLinkTree.OptionsSize.AutoWidth := False;
  tree.Styles.Background := dx.GetStyle(scControl);
  tree.Styles.ColumnHeader := nil;
  tree.Styles.Content := dx.GetStyle(scControl);
  tree.Styles.Footer := dx.GetStyle(scFooter);

  tree.Bands[0].Width := 250;
  tree.Columns[0].Width := 250;

  for i := 1 to tree.ColumnCount - 1 do
  begin
    tree.Columns[i].Width := 200;
    tree.Columns[i].Caption.Text := StringReplace(tree.Columns[i].Caption.Text, slinebreak, ' - ', []);
  end;

  for i := 0 to tree.ColumnCount - 1 do
    tree.Columns[i].Position.LineCount := 4;

  StampaInCorso := False;
  tree.FullRefresh;
end;

procedure TFrameCalendarioAule.dxComponentPrinterLinkTreeInitializeCell(Sender: TcxTreeListCustomReportLink; ANode: TcxTreeListNode; AColumn: TcxTreeListColumn; AnItem: TAbstractdxReportCellData);
var
  Evento: TEvento;
  s: string;

  function MaxLength(IsAula: boolean; Width: Integer): Integer;
  begin

    if IsAula then
    begin
      if Width >= 150 then
        result := 35
      else
        result := 24;
    end
    else
    begin
      if Width >= 40 then
        result := 6
      else
        result := 4;
    end;
  end;

begin

  // il wordWrap delle celle sbaglia con singole parole lunghe. Es. 'Apprendistato'

  if AnItem is TdxReportCellText then
  begin
    s := TdxReportCellText(AnItem).Text.Trim;
    // s:= '123456789a123456789b123456789c123456789d123456789e';

    s := s.Substring(0, MaxLength(AColumn.ItemIndex = 0, TdxReportCellText(AnItem).Width));
    TdxReportCellText(AnItem).Text := s;
  end;
end;

end.
