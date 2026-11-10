unit frame_RegistroCollettivo;

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
  Data.DB,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxCustomData,
  cxStyles,
  dxScrollbarAnnotations,
  cxTL,
  cxTextEdit,
  cxCheckBox,
  cxTLdxBarBuiltInMenu,
  dxLayoutcxEditAdapters,
  dxLayoutContainer,
  dxLayoutControlAdapters,
  Vcl.ComCtrls,
  dxCore,
  cxDateUtils,
  Vcl.Menus,
  System.ImageList,
  Vcl.ImgList,
  cxImageList,
  Vcl.StdCtrls,
  cxButtons,
  cxDropDownEdit,
  cxCalendar,
  System.Actions,
  Vcl.ActnList,
  cxClasses,
  cxInplaceContainer,
  cxMaskEdit,
  cxLookupEdit,
  cxDBLookupEdit,
  cxDBLookupComboBox,
  dxLayoutControl,
  cxScrollBar,
  Generics.Collections,
  cxEditRepositoryItems,
  cxImageComboBox,
  cxLabel,
  cxExtEditRepositoryItems,
  cxVGrid,
  cxOI,
  cxCheckGroup,
  dxToggleSwitch,
  cxTimeEdit,
  cxDBEditRepository,
  dxBar,
  cxBarEditItem,
  dxBarExtItems,
  Base_Frame,
  zDbView,
  RegistroStudentiCollettiva.Classes,
  dmRegistroStudenti,
  cxFilter,
  Vcl.ExtCtrls,
  cxDBExtLookupComboBox;

const
  cmd_DisplayTree = wm_User + 1;
  cmd_CaricaProgetto = wm_User + 2;

type
  TFrameRegistroCollettivo = class(TBaseFrame)
    dxLayoutControl: TdxLayoutControl;
    treeRegistro: TcxTreeList;
    treeRegistroColStudente: TcxTreeListColumn;
    treeRegistroColStatoPresenza: TcxTreeListColumn;
    treeRegistroColOrePresenza: TcxTreeListColumn;
    dxLayoutControlGroup_Root: TdxLayoutGroup;
    dxLayoutItemRegistro: TdxLayoutItem;
    Actions: TActionList;
    treeMaterie: TcxTreeList;
    dxLayoutItemMaterie: TdxLayoutItem;
    cxScrollBar: TcxScrollBar;
    dxLayoutItemScrollbar: TdxLayoutItem;
    Firma: TAction;
    cxEditRepository: TcxEditRepository;
    cxEditRepositoryTipologiaFormazione: TcxEditRepositoryImageComboBoxItem;
    cxEditRepositoryTotaleOre: TcxEditRepositoryLabel;
    cxEditRepositoryStatoPresenza: TcxEditRepositoryImageComboBoxItem;
    treeMaterieOraInizio1: TcxTreeListColumn;
    treeMaterieOraFine1: TcxTreeListColumn;
    treeMaterieMateria1: TcxTreeListColumn;
    treeMaterieDocente1: TcxTreeListColumn;
    treeMaterieIncarichiMancanti1: TcxTreeListColumn;
    treeMaterieOraBuca1: TcxTreeListColumn;
    treeMaterieColonnaVuota: TcxTreeListColumn;
    cxEditRepositoryOra: TcxEditRepositoryTimeItem;
    cxEditRepositoryMateria: TcxEditRepositoryComboBoxItem;
    cxEditRepositoryCheckBox: TcxEditRepositoryCheckBoxItem;
    cxEditRepositoryDocente: TcxEditRepositoryComboBoxItem;
    dxLayoutGroupCollettiva: TdxLayoutGroup;
    Precedente: TAction;
    Successiva: TAction;

    lkProgettiSrc: TDataSource;
    edProgetto: TcxExtLookupComboBox;
    dxLayoutItemProgetto: TdxLayoutItem;
    dxLayoutGrouptoolbar: TdxLayoutGroup;
    ForzaTipologiaFormazione: TAction;
    treeRegistroColFAD: TcxTreeListColumn;
    cxEditRepositoryFAD: TcxEditRepositoryCheckBoxItem;
    Salva: TAction;
    imageTreeMaterie: TcxImageList;
    edCorso: TcxExtLookupComboBox;
    dxLayoutItemCorso: TdxLayoutItem;
    dxLayoutGroupProgetto: TdxLayoutGroup;
    dxBarPopupMenu: TdxBarPopupMenu;
    btnMinuti15: TdxBarButton;
    btnMinuti30: TdxBarButton;
    btnMinuti45: TdxBarButton;
    btnMinuti60: TdxBarButton;
    btnMinuti0: TdxBarButton;
    cxEditRepositoryMinutiAssenza: TcxEditRepositoryComboBoxItem;
    Oggi: TAction;
    VaiAlGiorno: TAction;
    dxBarDockControl: TdxBarDockControl;
    dxBarManagerBar: TdxBar;
    dxLayoutItemBar: TdxLayoutItem;
    dxBarButtonOggi: TdxBarButton;
    dxBarButtonVaiAlGiorno: TdxBarButton;
    dxBarButtonPrecedente: TdxBarButton;
    dxBarButtonSuccessiva: TdxBarButton;
    dxBarControlContainerItem: TdxBarControlContainerItem;
    dxBarButtonForzaTipologiaFormazione: TdxBarButton;
    dxBarButtonSalva: TdxBarButton;
    dxBarButtonFirma: TdxBarButton;
    pnlSeparatoreUno: TPanel;
    btnMinuti5: TdxBarButton;
    btnMinuti10: TdxBarButton;
    btnMinuti20: TdxBarButton;
    btnMinuti25: TdxBarButton;
    btnMinuti35: TdxBarButton;
    btnMinuti40: TdxBarButton;
    btnMinuti50: TdxBarButton;
    btnMinuti55: TdxBarButton;
    dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem;
    dxLayoutSplitterItem2: TdxLayoutSplitterItem;
    edEnte: TcxExtLookupComboBox;
    edProgettoCodReg: TcxExtLookupComboBox;
    dxLayoutItemEnte: TdxLayoutItem;
    dxLayoutItemProgettoCodReg: TdxLayoutItem;
    dxLayoutSplitterItem3: TdxLayoutSplitterItem;
    dxLayoutGroup1: TdxLayoutGroup;
    dxLayoutGroup2: TdxLayoutGroup;
    dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem;
    dxLayoutEmptySpaceItem3: TdxLayoutEmptySpaceItem;
    CalendarioCorsi: TAction;
    dxBarButton1: TdxBarButton;
    pnlSeparatoreDue: TPanel;
    dxBarContainerItem1: TdxBarContainerItem;
    dxBarControlContainerItem1: TdxBarControlContainerItem;
    dxLayoutSplitterItem1: TdxLayoutSplitterItem;
    BloccaPresenze: TAction;
    dxBarButtonBloccaPresenze: TdxBarButton;
    procedure btnMinutiAssenzaClick(Sender: TObject);
    procedure CalendarioCorsiExecute(Sender: TObject);
    procedure cxScrollBarChange(Sender: TObject);
    procedure treeMaterieLeftPosChanged(Sender: TObject);
    procedure treeRegistroLeftPosChanged(Sender: TObject);
    procedure cxEditRepositoryPresenzaPropertiesPopup(Sender: TObject);
    procedure cxEditRepositoryStatoPresenzaPropertiesEditValueChanged(Sender: TObject);
    procedure PrecedenteExecute(Sender: TObject);
    procedure SuccessivaExecute(Sender: TObject);
    procedure treeMaterieDblClick(Sender: TObject);
    procedure treeRegistroClick(Sender: TObject);
    procedure treeRegistroColumnSizeChanged(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn);
    procedure edProgettoPropertiesEditValueChanged(Sender: TObject);
    procedure ForzaTipologiaFormazioneExecute(Sender: TObject);
    procedure cxEditRepositoryFADPropertiesEditValueChanged(Sender: TObject);
    procedure dxBarPopupMenuPopup(Sender: TObject);
    procedure FirmaExecute(Sender: TObject);
    procedure FirmaUpdate(Sender: TObject);
    procedure SalvaExecute(Sender: TObject);
    procedure SalvaUpdate(Sender: TObject);
    procedure treeMaterieGetCellHint(Sender: TcxCustomTreeList; ACell: TObject; var AText: string; var ANeedShow: Boolean);
    procedure treeRegistroCustomDrawDataCell(Sender: TcxCustomTreeList; ACanvas: TcxCanvas; AViewInfo: TcxTreeListEditCellViewInfo; var ADone: Boolean);
    procedure edCorsoPropertiesEditValueChanged(Sender: TObject);
    procedure treeRegistroInitEdit(Sender, AItem: TObject; AEdit: TcxCustomEdit);
    procedure cxEditRepositoryMinutiAssenzaPropertiesEditValueChanged(Sender: TObject);
    procedure OggiExecute(Sender: TObject);
    procedure VaiAlGiornoExecute(Sender: TObject);
    procedure edFiltroEntePropertiesEditValueChanged(Sender: TObject);
    procedure edProgettoCodRegPropertiesEditValueChanged(Sender: TObject);
    // Mantis #47 - 2026-07-28: gestori dell'azione BloccaPresenze
    procedure BloccaPresenzeExecute(Sender: TObject);
    procedure BloccaPresenzeUpdate(Sender: TObject);
  private
    function Normalize(value: integer): integer;
  private
    procedure InitMinuti;
  private
    procedure DestroyMaterieColumns;
    function CreateColumn(Tree: TcxTreeList; const Name, Caption: string): TcxTreeListColumn;
    procedure CreateMaterieColumns;
    procedure CreateMaterieBand(Materia: TMateria);
    function GetMateriaColumn(const Ora: integer): TcxTreeListColumn;
    function GetMinutiAssenzaColumn(const Ora: integer): TcxTreeListColumn;
    function GetFADColumn(const Ora: integer): TcxTreeListColumn;
    // Mantis #260 - 2026-10-19: casella Calcolare (esclusione dall'invio a SIUF), per ora e complessiva.
    // Colonne e repository sono creati in codice, come le colonne delle ore, per non toccare il DFM.
    function GetCalcolareColumn(const Ora: integer): TcxTreeListColumn;
    procedure CreaColonnaCalcolare;
    procedure CalcolarePropertiesEditValueChanged(Sender: TObject);
    function GetMateria(const column: TcxTreeListColumn): TMateria;

    function SelectedStudente: TStudente;
    function GetTipologiaFormazione(var TipologiaFormazione: string): Boolean;
    // Mantis #47 - 2026-07-28: vero se la colonna corrisponde a un'ora con le
    // presenze studenti congelate (o, per le colonne complessive Stato
    // Presenza/FAD, se lo e' almeno un'ora della giornata)
    function IsOraBloccata(const Column: TcxTreeListColumn): Boolean;
    // Mantis #336 - 2026-11-10: come IsOraBloccata, ma se l'ora e' bloccata avvisa
    // l'utente e ridisegna la riga con i valori veri del database (la modifica
    // appena fatta nella casella non e' stata salvata)
    function RifiutaSeOraBloccata(const Column: TcxTreeListColumn): Boolean;
  private
    procedure doCaricaProgetto(var Message: TMessage); message cmd_CaricaProgetto;
    procedure CaricaProgetto;

    procedure doDisplayTree(var Message: TMessage); message cmd_DisplayTree;
    procedure DisplayTreeMaterie;
    procedure DisplayTree(const ClearNodes: Boolean);
  private
    procedure StatoPresenzaMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; x, Y: integer);
    procedure PreparaItemsStatoPresenza;
  private
    FDataLezione: TDate;
    Scrolling: Boolean;
    // Mantis #260 - 2026-10-19
    FColonnaCalcolare: TcxTreeListColumn;
    FRepositoryCalcolare: TcxEditRepositoryCheckBoxItem;

    function GetIdProgetto: integer;
    function GetIdCorso: integer;

    procedure SyncPos(x: integer);
    procedure InitStyles;
    procedure InitScrollBar;
    procedure SetDataLezione(const value: TDate);
  public
    constructor Create(aOwner: TComponent); override;
    procedure SalvaRegistro;
    procedure Aggiorna;
    procedure AggiornaAltezzaTreeMaterie;
  public
    property IdProgetto: integer read GetIdProgetto;
    property IdCorso: integer read GetIdCorso;
    property DataLezione: TDate read FDataLezione write SetDataLezione;
  public
    procedure OpenRegistro(aDataLezione: TDateTime; const aIdProgetto, aIdCorso: integer);
  end;

implementation

uses
  System.DateUtils,
  zdx,
  zFbDataSet,
  zMsg,
  ConfigModule,
  zBaseLib,
  Gesty.Types,
  Gesty.Authorizations,
  CalendarioCorsi.Classes,
  frmOrario,
  MDI_Lib;

{$R *.dfm}

const
  WidthMinutiAssenza = 40;
  // Mantis #260 - 2026-10-19
  WidthCalcolare = 40;

type
  TcxTreeListAccess = class(TcxTreeList);
  TcxCustomEditAccess = class(TcxCustomEdit);

constructor TFrameRegistroCollettivo.Create(aOwner: TComponent);
begin
  inherited;
  // ReportGroup := 'RegistroStudenti';
  Caption := 'Registro Studenti';

  Scrolling := false;

  dx.InitBar(dxBarManagerBar);
  dx.InitTreeList(treeRegistro);

  // Mantis #260 - 2026-10-19: prima di InitStyles, che applica lo stile a tutte le colonne
  CreaColonnaCalcolare;

  InitStyles;

  Actions.Images := dx.Immagini;
  // treeRegistro.Images := zDmImages.ImageList16;

  InitMinuti;

  cxEditRepositoryStatoPresenza.Properties.Images := dx.Immagini;

  dx.InitLookup('', edEnte, RegistroStudenti.lkEnti, RegistroStudenti.lkEntiSrc, 'ID_ENTE', 'ID_ENTE');
  dx.InitLookup('', edProgetto, RegistroStudenti.lkProgetti, RegistroStudenti.lkProgettiSrc, 'ID_PROGETTO', 'ID_PROGETTO');
  dx.InitLookup('', edProgettoCodReg, RegistroStudenti.lkProgettiCodReg, RegistroStudenti.lkProgettiCodRegSrc, 'ID_PROGETTO', 'ID_PROGETTO');
  dx.InitLookup('', edCorso, RegistroStudenti.lkCorsi, RegistroStudenti.lkCorsiSrc, 'ID_CORSO', 'ID_CORSO');

  dx.InitPickList(cxEditRepositoryStatoPresenza.Properties, 'STATO_PRESENZA');
  PreparaItemsStatoPresenza;

  FDataLezione := Date;
  VaiAlGiorno.Caption := DateToStr(DataLezione);

  // parametrizzare
  if false then // tools.EnteDefault in ...
    if DebugHook <> 0 then
    begin
      edProgetto.EditValue := 42114;
      edCorso.EditValue := 63037;
      FDataLezione := EncodeDate(2022, 07, 28);
    end;

  CaricaProgetto;
end;

// Mantis #260 - 2026-10-19: repository e colonna complessiva "Calcolare" (tutte le ore dell'allievo)
procedure TFrameRegistroCollettivo.CreaColonnaCalcolare;
begin
  FRepositoryCalcolare := TcxEditRepositoryCheckBoxItem.Create(cxEditRepositoryFAD.Repository);
  FRepositoryCalcolare.Properties.OnEditValueChanged := CalcolarePropertiesEditValueChanged;

  FColonnaCalcolare := CreateColumn(treeRegistro, treeRegistro.Name + 'Calcolare', 'Calcolare');
  FColonnaCalcolare.DataBinding.ValueType := 'boolean';
  FColonnaCalcolare.RepositoryItem := FRepositoryCalcolare;
  FColonnaCalcolare.Options.Sizing := false;
  FColonnaCalcolare.MinWidth := Normalize(60);
  FColonnaCalcolare.Width := FColonnaCalcolare.MinWidth;
  FColonnaCalcolare.BestFitMaxWidth := FColonnaCalcolare.MinWidth;
end;

procedure TFrameRegistroCollettivo.cxScrollBarChange(Sender: TObject);
begin
  if not Scrolling then
    SyncPos(cxScrollBar.Position);
end;

procedure TFrameRegistroCollettivo.InitScrollBar;
var
  ViewInfo: TcxTreeListViewInfo;
begin
  ViewInfo := TcxTreeListAccess(treeRegistro).ViewInfo;

  cxScrollBar.Max := ViewInfo.HScrollSize - 1;
  cxScrollBar.SmallChange := ViewInfo.HScrollInc;
  cxScrollBar.PageSize := ViewInfo.HScrollPage;
  cxScrollBar.Position := ViewInfo.HScrollPos;
end;

procedure TFrameRegistroCollettivo.SyncPos(x: integer);
begin
  if Scrolling then
    exit;

  Scrolling := true;
  try
    treeRegistro.HideEdit;
    treeMaterie.HideEdit;

    cxScrollBar.Position := x;

    if TcxTreeListAccess(treeRegistro).Controller.LeftPos <> x then
    begin
      TcxTreeListAccess(treeRegistro).Controller.LeftPos := x;
      treeRegistro.Invalidate;
    end;

    if TcxTreeListAccess(treeMaterie).Controller.LeftPos <> x then
    begin
      TcxTreeListAccess(treeMaterie).Controller.LeftPos := x;
      treeRegistro.Invalidate;
    end;
  finally
    Scrolling := false;
  end;
end;

procedure TFrameRegistroCollettivo.treeMaterieLeftPosChanged(Sender: TObject);
begin
  SyncPos(TcxTreeListAccess(treeMaterie).ViewInfo.HScrollPos);
end;

procedure TFrameRegistroCollettivo.treeRegistroLeftPosChanged(Sender: TObject);
begin
  SyncPos(TcxTreeListAccess(treeRegistro).ViewInfo.HScrollPos);
end;

procedure TFrameRegistroCollettivo.SalvaRegistro;
begin
  // metodo chiamato dalla form
  RegistroStudenti.SalvaRegistroCollettivo(IdProgetto, IdCorso, DataLezione);
  DisplayTree(true);
end;

function TFrameRegistroCollettivo.SelectedStudente: TStudente;
begin
  result := nil;

  if treeRegistro.SelectionCount > 0 then
    result := RegistroStudenti.RegistroCollettivo.Studenti.GetStudente(treeRegistro.Selections[0]);
end;

function TFrameRegistroCollettivo.IsOraBloccata(const Column: TcxTreeListColumn): Boolean;
var
  Materia: TMateria;
begin
  if not Assigned(Column) then
    Exit(False);

  Materia := GetMateria(Column);

  if Assigned(Materia) then
    // colonna di una singola ora: stato per quell'ora
    result := Materia.PresenzeBloccate
  else
    // colonna complessiva (Stato Presenza / FAD): bloccata se lo e'
    // almeno un'ora della giornata
    result := RegistroStudenti.RegistroCollettivo.BloccaStudenti;
end;

// Mantis #336 - 2026-11-10: dopo la firma le presenze restano bloccate anche se la
// firma viene tolta; prima la modifica veniva scartata in silenzio e la casella
// restava con un valore che nel database non c'era (flag FAD tolto ma ancora
// presente, rielaborazione SIUF con la fascia ancora FAD)
function TFrameRegistroCollettivo.RifiutaSeOraBloccata(const Column: TcxTreeListColumn): Boolean;
begin
  Result := IsOraBloccata(Column);

  if Result then
  begin
    MessageDlg('Le presenze di questa ora risultano bloccate: la modifica non '#232' stata salvata.' + sLineBreak +
      'Per modificarle serve lo sblocco delle presenze (comando Sblocca Presenze, riservato a chi ha l'#39'autorizzazione).',
      mtWarning, [mbOK], 0);
    PostMessage(Self.Handle, cmd_DisplayTree, 0, 0);
  end;
end;

procedure TFrameRegistroCollettivo.InitStyles;
var
  i: integer;
begin
  /// /
  treeRegistro.Styles.Background := dx.GetStyle(scControl);
  treeRegistro.Styles.Inactive := dx.GetStyle(scControl);
  treeRegistro.Styles.Footer := dx.GetStyle(scFooter);

  for i := 0 to treeRegistro.ColumnCount - 1 do
    treeRegistro.Columns[i].Styles.Header := dx.GetStyle(scBtnFace);

  treeRegistroColOrePresenza.Styles.Content := dx.GetStyle(scFooter);

  treeRegistro.Styles.ContentOdd := dx.GetStyle(scContentOdd);
  treeRegistro.Styles.ContentEven := dx.GetStyle(scContentEven);
end;

function TFrameRegistroCollettivo.CreateColumn(Tree: TcxTreeList; const Name, Caption: string): TcxTreeListColumn;
begin
  result := Tree.CreateColumn(Tree.Bands[0]);
  result.Name := Name;
  result.Caption.Text := Caption;
  result.DataBinding.ValueType := 'String';
  result.Position.BandIndex := 0;
  result.Position.RowIndex := 0;
  result.Position.ColIndex := Tree.ColumnCount;
  result.Options.IncSearch := false;
  result.Options.Moving := false;
  result.Options.Sorting := false;
  result.Focused := true;

  result.Styles.Header := dx.GetStyle(scBtnFace);

  // if odd(result.Position.ColIndex - 1) then
  // result.Styles.Content := dx.GetStyle(scContentOdd)
  // else
  // result.Styles.Content := dx.GetStyle(scContentEven);
end;

procedure TFrameRegistroCollettivo.CreateMaterieBand(Materia: TMateria);
var
  band: TcxTreeListBand;
  col: TcxTreeListColumn;
begin
  band := treeMaterie.Bands.Add;
  // Mantis #260 - 2026-10-19: + colonna "Calc." di ogni ora
  band.Width := treeRegistroColStatoPresenza.Width + treeRegistroColFAD.Width + Normalize(WidthMinutiAssenza) + Normalize(WidthCalcolare);
  //
  // Docente
  col := CreateColumn(treeMaterie, treeMaterie.Name + 'Docente' + Materia.Ora.ToString, 'Docente' + Materia.Ora.ToString);
  col.Tag := Materia.Ora;
  col.DataBinding.ValueType := 'string';
  col.RepositoryItem := cxEditRepositoryDocente;
  col.Options.Sizing := false;
  col.Options.Editing := false;
  col.MinWidth := band.Width;
  col.Width := band.Width;
  col.Position.BandIndex := band.Index;
  col.Position.ColIndex := 0;
  col.Position.RowIndex := 0;
  col.Styles.Content := dx.GetStyle(scContentEven);
  col.StatusHint := 'Docente';
  // Materia
  col := CreateColumn(treeMaterie, treeMaterie.Name + 'Materia' + Materia.Ora.ToString, 'Materia' + Materia.Ora.ToString);
  col.Tag := Materia.Ora;
  col.DataBinding.ValueType := 'string';
  col.RepositoryItem := cxEditRepositoryMateria;
  col.Options.Sizing := false;
  col.Options.Editing := false;
  col.MinWidth := band.Width;
  col.Width := band.Width;
  col.Position.BandIndex := band.Index;
  col.Position.ColIndex := 0;
  col.Position.RowIndex := 1;
  col.Styles.Content := dx.GetStyle(scContentOdd);
  col.StatusHint := 'Materia';
  // Ora Buca
  col := CreateColumn(treeMaterie, treeMaterie.Name + 'OraBuca' + Materia.Ora.ToString, 'OraBuca' + Materia.Ora.ToString);
  col.Tag := Materia.Ora;
  col.DataBinding.ValueType := 'Boolean';
  col.RepositoryItem := cxEditRepositoryCheckBox;
  col.Options.Sizing := false;
  col.Options.Editing := false;
  col.MinWidth := Normalize(28);
  col.Width := col.MinWidth;
  col.Position.BandIndex := band.Index;
  col.Position.ColIndex := 0;
  col.Position.RowIndex := 2;
  col.Styles.Content := dx.GetStyle(scContentEven);
  col.StatusHint := 'Lezione Svolta';
  // Incarichi Mancanti
  col := CreateColumn(treeMaterie, treeMaterie.Name + 'IncarichiMancanti' + Materia.Ora.ToString, 'IncarichiMancanti' + Materia.Ora.ToString);
  col.Tag := Materia.Ora;
  col.DataBinding.ValueType := 'Boolean';
  col.RepositoryItem := cxEditRepositoryCheckBox;
  col.Options.Sizing := false;
  col.Options.Editing := false;
  col.MinWidth := Normalize(27);
  col.Width := col.MinWidth;
  col.Position.BandIndex := band.Index;
  col.Position.ColIndex := 1;
  col.Position.RowIndex := 2;
  col.Styles.Content := dx.GetStyle(scContentEven);
  col.StatusHint := 'Incarichi Mancanti';
  // Ora Inizio
  col := CreateColumn(treeMaterie, treeMaterie.Name + 'OraInizio' + Materia.Ora.ToString, 'OraInizio' + Materia.Ora.ToString);
  col.Tag := Materia.Ora;
  col.DataBinding.ValueType := 'DateTime';
  col.RepositoryItem := cxEditRepositoryOra;
  col.Options.Sizing := false;
  col.Options.Editing := false;
  col.MinWidth := Normalize(65);
  col.Width := col.MinWidth;
  col.Position.BandIndex := band.Index;
  col.Position.ColIndex := 2;
  col.Position.RowIndex := 2;
  col.Styles.Content := dx.GetStyle(scContentEven);
  col.StatusHint := 'Ora Inizio';
  // Ora Fine
  col := CreateColumn(treeMaterie, treeMaterie.Name + 'OraFine' + Materia.Ora.ToString, 'OraFine' + Materia.Ora.ToString);
  col.Tag := Materia.Ora;
  col.DataBinding.ValueType := 'DateTime';
  col.RepositoryItem := cxEditRepositoryOra;
  col.Options.Sizing := false;
  col.Options.Editing := false;
  col.MinWidth := Normalize(65);
  col.Width := col.MinWidth;
  col.Position.BandIndex := band.Index;
  col.Position.ColIndex := 3;
  col.Position.RowIndex := 2;
  col.Styles.Content := dx.GetStyle(scContentEven);
  col.StatusHint := 'Ora Fine';
  // Mantis #47 - 2026-07-28: Presenze Bloccate. Aggiunta come ULTIMA colonna
  // creata per questa materia: DisplayTreeMaterie si affida all'ordine di
  // creazione per calcolare l'ItemIndex (idx+7), spostarla altera quel calcolo.
  // Larghezza e riga da rivedere in IDE: qui occupa una riga intera come
  // Docente/Materia, non e' detto sia la sistemazione migliore.
  col := CreateColumn(treeMaterie, treeMaterie.Name + 'PresenzeBloccate' + Materia.Ora.ToString, 'PresenzeBloccate' + Materia.Ora.ToString);
  col.Tag := Materia.Ora;
  col.DataBinding.ValueType := 'Boolean';
  col.RepositoryItem := cxEditRepositoryCheckBox;
  col.Options.Sizing := false;
  col.Options.Editing := false;
  col.MinWidth := band.Width;
  col.Width := band.Width;
  col.Position.BandIndex := band.Index;
  col.Position.ColIndex := 0;
  col.Position.RowIndex := 3;
  col.Styles.Content := dx.GetStyle(scContentOdd);
  col.StatusHint := 'Presenze Bloccate';
end;

procedure TFrameRegistroCollettivo.CreateMaterieColumns;
var
  i: integer;
  col: TcxTreeListColumn;
  Materia: TMateria;
begin
  treeMaterie.BeginUpdate;
  try
    treeRegistro.BeginUpdate;
    try
      treeMaterie.Clear;
      treeRegistro.Clear;

      DestroyMaterieColumns;

      /// //////////////////////////////

      for Materia in RegistroStudenti.RegistroCollettivo.Materie do
      begin
        CreateMaterieBand(Materia);
        col := CreateColumn(treeRegistro, treeRegistro.Name + 'Ora' + Materia.Ora.ToString, 'Ora ' + Materia.Ora.ToString + ' (' + Materia.Materia + ')');
        col.Tag := Materia.Ora;
        col.DataBinding.ValueType := 'string';
        col.RepositoryItem := cxEditRepositoryStatoPresenza;
        col.Options.Sizing := false;
        col.MinWidth := treeRegistroColStatoPresenza.MinWidth;
        col.Width := treeRegistroColStatoPresenza.MinWidth;

        // cxEditRepositoryMinutiAssenza
        col := CreateColumn(treeRegistro, treeRegistro.Name + 'MinutiAssenza' + Materia.Ora.ToString, 'R/A');
        col.Tag := Materia.Ora;
        col.DataBinding.ValueType := 'integer';
        col.RepositoryItem := cxEditRepositoryMinutiAssenza;
        col.Options.Sizing := false;
        col.MinWidth := Normalize(WidthMinutiAssenza);
        col.Width := col.MinWidth;
        col.BestFitMaxWidth := col.MinWidth;

        // cxEditRepositoryFAD
        col := CreateColumn(treeRegistro, treeRegistro.Name + 'FAD' + Materia.Ora.ToString, 'FAD');
        col.Tag := Materia.Ora;
        col.DataBinding.ValueType := 'boolean';
        col.RepositoryItem := cxEditRepositoryFAD;
        col.Options.Sizing := false;
        col.MinWidth := Normalize(treeRegistroColFAD.MinWidth);
        col.Width := col.MinWidth;
        col.BestFitMaxWidth := col.MinWidth;

        // Mantis #260 - 2026-10-19: Calcolare per questa ora
        col := CreateColumn(treeRegistro, treeRegistro.Name + 'Calcolare' + Materia.Ora.ToString, 'Calc.');
        col.Tag := Materia.Ora;
        col.DataBinding.ValueType := 'boolean';
        col.RepositoryItem := FRepositoryCalcolare;
        col.Options.Sizing := false;
        col.MinWidth := Normalize(WidthCalcolare);
        col.Width := col.MinWidth;
        col.BestFitMaxWidth := col.MinWidth;
      end;

      treeMaterie.Bands[0].Width := treeRegistroColStudente.Width + treeRegistroColStatoPresenza.Width + treeRegistroColFAD.Width + treeRegistroColOrePresenza.Width + FColonnaCalcolare.Width;
    finally
      treeRegistro.EndUpdate;
    end;
  finally
    treeMaterie.EndUpdate;
  end;
end;

function TFrameRegistroCollettivo.GetMateriaColumn(const Ora: integer): TcxTreeListColumn;
var
  i: integer;
  col: TcxTreeListColumn;
  Materia: TMateria;
begin
  result := nil;

  for i := treeRegistro.ColumnCount - 1 downto 0 do
  begin
    col := treeRegistro.Columns[i];

    if col.Tag > 0 then
      if col.Tag = Ora then
        if col.Caption.Text <> 'FAD' then
          if col.Caption.Text <> 'R/A' then
            // Mantis #260 - 2026-10-19: la colonna Calc. e' distinta dalla colonna Ora
            if col.Caption.Text <> 'Calc.' then
              exit(col);
  end;
end;

// Mantis #260 - 2026-10-19
function TFrameRegistroCollettivo.GetCalcolareColumn(const Ora: integer): TcxTreeListColumn;
var
  i: integer;
  col: TcxTreeListColumn;
begin
  result := nil;

  for i := treeRegistro.ColumnCount - 1 downto 0 do
  begin
    col := treeRegistro.Columns[i];

    if col.Tag > 0 then
      if col.Tag = Ora then
        if col.Caption.Text = 'Calc.' then
          exit(col);
  end;
end;

function TFrameRegistroCollettivo.GetMinutiAssenzaColumn(const Ora: integer): TcxTreeListColumn;
var
  i: integer;
  col: TcxTreeListColumn;
  Materia: TMateria;
begin
  result := nil;

  for i := treeRegistro.ColumnCount - 1 downto 0 do
  begin
    col := treeRegistro.Columns[i];

    if col.Tag > 0 then
      if col.Tag = Ora then
        if col.Caption.Text = 'R/A' then
          exit(col);
  end;
end;

function TFrameRegistroCollettivo.GetFADColumn(const Ora: integer): TcxTreeListColumn;
var
  i: integer;
  col: TcxTreeListColumn;
  Materia: TMateria;
begin
  result := nil;

  for i := treeRegistro.ColumnCount - 1 downto 0 do
  begin
    col := treeRegistro.Columns[i];

    if col.Tag > 0 then
      if col.Tag = Ora then
        if col.Caption.Text = 'FAD' then
          exit(col);
  end;
end;

procedure TFrameRegistroCollettivo.DestroyMaterieColumns;
var
  i: integer;
  col: TcxTreeListColumn;
begin
  for i := treeRegistro.ColumnCount - 1 downto 0 do
  begin
    col := treeRegistro.Columns[i];

    if col.Tag > 0 then
      col.Free;
  end;

  for i := treeMaterie.ColumnCount - 1 downto 0 do
  begin
    col := treeMaterie.Columns[i];

    if col.Position.BandIndex > 0 then
      col.Free;
  end;

  for i := treeMaterie.Bands.Count - 1 downto 1 do
    treeMaterie.Bands.Delete(i);
end;

procedure TFrameRegistroCollettivo.DisplayTree(const ClearNodes: Boolean);
var
  Studente: TStudente;
  Presenza: TPresenza;
  nodo: TcxTreeListNode;
  col: TcxTreeListColumn;
begin

  treeRegistro.BeginUpdate;
  try
    cxScrollBar.Position := 0;

    if ClearNodes then
    begin
      treeRegistro.Clear;
      RegistroStudenti.RegistroCollettivo.Studenti.ClearNodes;
    end;

    for Studente in RegistroStudenti.RegistroCollettivo.Studenti do
    begin
      nodo := Studente.Node;

      if not Assigned(nodo) then
      begin
        nodo := treeRegistro.Root.AddChild;
        Studente.Node := nodo;
      end;

      nodo.Values[treeRegistroColStudente.ItemIndex] := Studente.NominativoStudente;
      nodo.Values[treeRegistroColStatoPresenza.ItemIndex] := Studente.StatoPresenza.ToString;
      nodo.Values[treeRegistroColFAD.ItemIndex] := Studente.IsFAD;
      nodo.Values[treeRegistroColOrePresenza.ItemIndex] := Studente.TotaleOre;
      nodo.Values[FColonnaCalcolare.ItemIndex] := Studente.Calcolare;

      for Presenza in Studente.OrePresenza do
      begin
        col := GetMateriaColumn(Presenza.Ora);
        nodo.Values[col.ItemIndex] := Presenza.StatoPresenza.ToString;

        col := GetMinutiAssenzaColumn(Presenza.Ora);
        nodo.Values[col.ItemIndex] := Presenza.MinutiAssenza.ToString;

        col := GetFADColumn(Presenza.Ora);
        nodo.Values[col.ItemIndex] := Presenza.OverrideTipologiaFormazione = FAD;

        col := GetCalcolareColumn(Presenza.Ora);
        nodo.Values[col.ItemIndex] := Presenza.Calcolare;
      end;
    end;

    // treeRegistro.ApplyBestFit;
    treeRegistroColStudente.ApplyBestFit;
  finally
    treeRegistro.EndUpdate;
  end;
end;

procedure TFrameRegistroCollettivo.DisplayTreeMaterie;
var
  nodo: TcxTreeListNode;
  Materia: TMateria;
  idx: integer;
begin
  treeMaterie.BeginUpdate;
  try
    treeMaterie.Clear;
    nodo := treeMaterie.Root.AddChild;

    for Materia in RegistroStudenti.RegistroCollettivo.Materie do
    begin
      // Mantis #47 - 2026-07-28: 7 valori per materia (prima erano 6), per la
      // nuova colonna PresenzeBloccate aggiunta come ultima in CreateMaterieBand
      idx := ((Materia.Ora - 1) * 7); // 2: progetto+tipologia+data

      nodo.Values[idx + 1] := Materia.NominativoDocente; // occhio
      nodo.Values[idx + 2] := Materia.Materia;
      nodo.Values[idx + 3] := Materia.LezioneSvolta;
      nodo.Values[idx + 4] := Materia.IncarichiMancanti;
      nodo.Values[idx + 5] := Materia.OraInizio;
      nodo.Values[idx + 6] := Materia.OraFine;
      nodo.Values[idx + 7] := Materia.PresenzeBloccate;
    end;
  finally
    treeMaterie.EndUpdate;
  end;
end;

procedure TFrameRegistroCollettivo.doDisplayTree(var Message: TMessage);
begin
  DisplayTree(false);
end;

procedure TFrameRegistroCollettivo.edCorsoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if not RegistroStudenti.CloseQuery then
  begin
    edCorso.Properties.OnEditValueChanged := nil;
    edCorso.EditValue := RegistroStudenti.CurrentCorso;
    edCorso.Properties.OnEditValueChanged := edCorsoPropertiesEditValueChanged;
    exit;
  end;

  edCorso.SelStart := 0;

  CaricaProgetto;
end;

procedure TFrameRegistroCollettivo.edFiltroEntePropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if not RegistroStudenti.CloseQuery then
  begin
    edEnte.Properties.OnEditValueChanged := nil;
    edEnte.EditValue := RegistroStudenti.CurrentProgetto;
    edEnte.Properties.OnEditValueChanged := edFiltroEntePropertiesEditValueChanged;
    exit;
  end;

  if varIsNull(edEnte.EditValue) then
    RegistroStudenti.FiltroEnte := -1
  else
    RegistroStudenti.FiltroEnte := edEnte.EditValue;

  edEnte.SelStart := 0;

  edProgetto.Clear;
  edProgettoCodReg.Clear;
  edCorso.Clear;
  CaricaProgetto
end;

procedure TFrameRegistroCollettivo.edProgettoPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if not RegistroStudenti.CloseQuery then
  begin
    edProgetto.Properties.OnEditValueChanged := nil;
    edProgetto.EditValue := RegistroStudenti.CurrentProgetto;
    edProgetto.Properties.OnEditValueChanged := edProgettoPropertiesEditValueChanged;
    exit;
  end;

  edProgettoCodReg.Properties.OnEditValueChanged := nil;
  try
    edProgettoCodReg.EditValue := edProgetto.EditValue;
  finally
    edProgettoCodReg.Properties.OnEditValueChanged := edProgettoCodRegPropertiesEditValueChanged;
  end;

  edProgetto.SelStart := 0;

  edCorso.Clear;

  RegistroStudenti.ApriCorsi(IdProgetto);
  CaricaProgetto;
end;

procedure TFrameRegistroCollettivo.edProgettoCodRegPropertiesEditValueChanged(Sender: TObject);
begin
  inherited;

  if not RegistroStudenti.CloseQuery then
  begin
    edProgettoCodReg.Properties.OnEditValueChanged := nil;
    edProgettoCodReg.EditValue := RegistroStudenti.CurrentProgetto;
    edProgettoCodReg.Properties.OnEditValueChanged := edProgettoCodRegPropertiesEditValueChanged;
    exit;
  end;

  edProgetto.Properties.OnEditValueChanged := nil;
  try
    edProgetto.EditValue := edProgettoCodReg.EditValue;
  finally
    edProgetto.Properties.OnEditValueChanged := edProgettoPropertiesEditValueChanged;
  end;

  edProgettoCodReg.SelStart := 0;

  edCorso.Clear;

  RegistroStudenti.ApriCorsi(IdProgetto);
  CaricaProgetto;
end;

procedure TFrameRegistroCollettivo.StatoPresenzaMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; x, Y: integer);
var
  cxImageComboBox: TcxImageComboBox;
begin

  if Button = mbLeft then
    if Sender is TcxImageComboBox then
    begin
      cxImageComboBox := TcxImageComboBox(Sender);
      cxImageComboBox.DroppedDown := false;

      // -2: si esclude l'ora buca
      if cxImageComboBox.ItemIndex < cxImageComboBox.Properties.Items.Count - 2 then
        cxImageComboBox.ItemIndex := cxImageComboBox.ItemIndex + 1
      else
        cxImageComboBox.ItemIndex := 0;
    end;
end;

procedure TFrameRegistroCollettivo.cxEditRepositoryPresenzaPropertiesPopup(Sender: TObject);
begin
  TcxImageComboBox(Sender).DroppedDown := false;
end;

function TFrameRegistroCollettivo.GetIdCorso: integer;
begin
  if varIsNull(edCorso.EditValue) then
    result := -1
  else
    result := edCorso.EditValue;
end;

function TFrameRegistroCollettivo.GetIdProgetto: integer;
begin
  if varIsNull(edProgetto.EditValue) then
    result := -1
  else
    result := edProgetto.EditValue;
end;

procedure TFrameRegistroCollettivo.PrecedenteExecute(Sender: TObject);
begin
  inherited;

  if RegistroStudenti.CloseQuery then
    DataLezione := IncDay(DataLezione, -1);
end;

procedure TFrameRegistroCollettivo.SuccessivaExecute(Sender: TObject);
begin
  inherited;

  if RegistroStudenti.CloseQuery then
    DataLezione := IncDay(DataLezione, 1);
end;

procedure TFrameRegistroCollettivo.treeRegistroClick(Sender: TObject);
var
  cxImageComboBox: TcxImageComboBox;
begin

  if treeRegistro.HitTest.HitAtNode then
    if treeRegistro.FocusedColumn.RepositoryItem = cxEditRepositoryStatoPresenza then
      // Mantis #47 - 2026-07-28: gate per singola ora, non piu' per l'intera
      // giornata (era: if not RegistroStudenti.RegistroCollettivo.BloccaStudenti)
      if not IsOraBloccata(treeRegistro.FocusedColumn) then
      begin
        treeRegistro.ShowEdit;
        if treeRegistro.InplaceEditor is TcxImageComboBox then
        begin
          cxImageComboBox := TcxImageComboBox(treeRegistro.InplaceEditor);
          cxImageComboBox.OnMouseDown := StatoPresenzaMouseDown;
          StatoPresenzaMouseDown(cxImageComboBox, mbLeft, [], 0, 0);
        end;
      end;
end;

procedure TFrameRegistroCollettivo.treeRegistroColumnSizeChanged(Sender: TcxCustomTreeList; AColumn: TcxTreeListColumn);
begin
  treeMaterie.Bands[0].Width := treeRegistroColStudente.Width + treeRegistroColStatoPresenza.Width + treeRegistroColFAD.Width + treeRegistroColOrePresenza.Width + FColonnaCalcolare.Width;
end;

procedure TFrameRegistroCollettivo.PreparaItemsStatoPresenza;
  procedure Add(const NomeIcona: string; const Caption: String; const value: String);
  var
    item: TcxImageComboBoxItem;
  begin
    item := cxEditRepositoryStatoPresenza.Properties.Items.Add;
    item.Description := Caption;
    item.value := value;
    item.ImageIndex := dx.IndiceIcona(NomeIcona);
  end;

begin
  cxEditRepositoryStatoPresenza.Properties.Items.Clear;
  // Mantis #270 - 2026-10-21: icone per nome in dx.Immagini, gli indici fissi della vecchia ImageList16 mostravano icone di tabella
  Add('pallino_verde', 'Presente', 'P');
  Add('pallino_rosso', 'Assente', 'A');
  Add('pallino_blu', 'Giustificato', 'G');
  Add('pallino_nero', 'Non Svolta', 'B');
end;

procedure TFrameRegistroCollettivo.treeMaterieDblClick(Sender: TObject);
var
  Materia: TMateria;
begin
  inherited;
  if treeMaterie.HitTest.HitAtNode then
    if Assigned(treeMaterie.HitTest.HitColumn) then
    begin
      Materia := GetMateria(treeMaterie.HitTest.HitColumn);
      if Assigned(Materia) then
        if RegistroStudenti.ModificaOrario(Materia.IdOrario) then
          PostMessage(Self.Handle, cmd_CaricaProgetto, 0, 0);
    end;
end;

function TFrameRegistroCollettivo.GetMateria(const column: TcxTreeListColumn): TMateria;
begin
  result := RegistroStudenti.RegistroCollettivo.Materie.GetMateria(column.Tag);
end;

procedure TFrameRegistroCollettivo.Aggiorna;
begin
  // propagato da Form.Aggiorna
  CaricaProgetto;
end;

procedure TFrameRegistroCollettivo.CaricaProgetto;
begin

  if varIsNull(edProgetto.EditValue) then
    exit;

  RegistroStudenti.CaricaRegistroCollettivo(IdProgetto, IdCorso, DataLezione);
  CreateMaterieColumns;

  DisplayTree(true);
  DisplayTreeMaterie;
end;

procedure TFrameRegistroCollettivo.doCaricaProgetto(var Message: TMessage);
begin
  CaricaProgetto;
  SyncPos(0);
end;

function TFrameRegistroCollettivo.GetTipologiaFormazione(var TipologiaFormazione: string): Boolean;
begin
  result := InputCombo('Tipologia Formazione', 'Tipologia Formazione', TipologiaFormazione, nil, nil, true, true,
    procedure(dlg: TInputDialog)
    begin
      dx.InitPickList((dlg.cxCustomEdit as TcxImageComboBox).Properties, 'TIPOLOGIA_FORMAZIONE');
    end);
end;

procedure TFrameRegistroCollettivo.ForzaTipologiaFormazioneExecute(Sender: TObject);
var
  TipologiaFormazione: string;
begin
  TipologiaFormazione := '';

  if not GetTipologiaFormazione(TipologiaFormazione) then
    exit;

  RegistroStudenti.ForzaTipologiaFormazione(IdProgetto, IdCorso, DataLezione, TipologiaFormazione);
  PostMessage(Self.Handle, cmd_CaricaProgetto, 0, 0);
end;

procedure TFrameRegistroCollettivo.cxEditRepositoryStatoPresenzaPropertiesEditValueChanged(Sender: TObject);
var
  Studente: TStudente;
  Ora: integer;
  Materia: TMateria;
  StatoPresenza: TStatoPresenza;
begin
  // Mantis #47 - 2026-07-28: gate per singola ora (era: BloccaStudenti globale)
  // Mantis #336 - 2026-11-10: con avviso e ridisegno invece dell'uscita silenziosa
  if RifiutaSeOraBloccata(treeRegistro.FocusedColumn) then
    exit;

  Studente := SelectedStudente;
  StatoPresenza := TStatoPresenza.FromString(VarToStr(TcxCheckBox(Sender).EditValue));

  if treeRegistro.FocusedColumn = treeRegistroColStatoPresenza then
    Studente.StatoPresenza := StatoPresenza
  else
  begin
    Ora := treeRegistro.FocusedColumn.Tag;
    Materia := RegistroStudenti.RegistroCollettivo.Materie.GetMateria(Ora);
    Studente.OrePresenza.UpdatePresenza(Ora, Materia, StatoPresenza);
  end;

  RegistroStudenti.SalvaStudente(IdProgetto, DataLezione, Studente);
  PostMessage(Self.Handle, cmd_DisplayTree, 0, 0);
end;

procedure TFrameRegistroCollettivo.cxEditRepositoryFADPropertiesEditValueChanged(Sender: TObject);
var
  Studente: TStudente;
  Ora: integer;
  Materia: TMateria;
  IsFAD: Boolean;
begin
  // Mantis #47 - 2026-07-28: gate per singola ora (era: BloccaStudenti globale)
  // Mantis #336 - 2026-11-10: con avviso e ridisegno invece dell'uscita silenziosa
  if RifiutaSeOraBloccata(treeRegistro.FocusedColumn) then
    exit;

  Studente := SelectedStudente;
  IsFAD := TcxCheckBox(Sender).EditValue;

  if treeRegistro.FocusedColumn = treeRegistroColFAD then
    Studente.IsFAD := IsFAD
  else
  begin
    Ora := treeRegistro.FocusedColumn.Tag;
    Materia := RegistroStudenti.RegistroCollettivo.Materie.GetMateria(Ora);
    Studente.OrePresenza.OverrideTipologia(Ora, IsFAD);
  end;

  RegistroStudenti.SalvaStudente(IdProgetto, DataLezione, Studente);
  PostMessage(Self.Handle, cmd_DisplayTree, 0, 0);
end;

// Mantis #260 - 2026-10-19: modello di cxEditRepositoryFADPropertiesEditValueChanged. Colonna complessiva =
// tutte le ore dell'allievo, colonna di un'ora = solo quell'ora
procedure TFrameRegistroCollettivo.CalcolarePropertiesEditValueChanged(Sender: TObject);
var
  Studente: TStudente;
  Ora: integer;
  Calcolare: Boolean;
begin
  // Mantis #336 - 2026-11-10: con avviso e ridisegno invece dell'uscita silenziosa
  if RifiutaSeOraBloccata(treeRegistro.FocusedColumn) then
    exit;

  Studente := SelectedStudente;
  if not Assigned(Studente) then
    exit;

  Calcolare := TcxCheckBox(Sender).EditValue;

  if treeRegistro.FocusedColumn = FColonnaCalcolare then
    Studente.Calcolare := Calcolare
  else
  begin
    Ora := treeRegistro.FocusedColumn.Tag;
    Studente.OrePresenza.ImpostaCalcolare(Ora, Calcolare);
  end;

  RegistroStudenti.SalvaStudente(IdProgetto, DataLezione, Studente);
  PostMessage(Self.Handle, cmd_DisplayTree, 0, 0);
end;

procedure TFrameRegistroCollettivo.cxEditRepositoryMinutiAssenzaPropertiesEditValueChanged(Sender: TObject);
var
  Studente: TStudente;
  Ora: integer;
  MinutiAssenza: integer;
  s: String;
begin
  // Mantis #47 - 2026-07-28: gate per singola ora (era: BloccaStudenti globale)
  // Mantis #336 - 2026-11-10: con avviso e ridisegno invece dell'uscita silenziosa
  if RifiutaSeOraBloccata(treeRegistro.FocusedColumn) then
    exit;

  s := TcxComboBox(Sender).EditValue;

  if not TryStrToInt(s, MinutiAssenza) then
    MinutiAssenza := 0;

  Studente := SelectedStudente;
  Ora := treeRegistro.FocusedColumn.Tag;
  Studente.OrePresenza.UpdatePresenza(Ora, MinutiAssenza);
  RegistroStudenti.SalvaStudente(IdProgetto, DataLezione, Studente);
  PostMessage(Self.Handle, cmd_DisplayTree, 0, 0);
end;

procedure TFrameRegistroCollettivo.FirmaExecute(Sender: TObject);
begin
  inherited;
  RegistroStudenti.FirmaRegistroCollettivo(IdProgetto, IdCorso, DataLezione);
  DisplayTree(true);
end;

procedure TFrameRegistroCollettivo.FirmaUpdate(Sender: TObject);
begin
  inherited;

  if RegistroStudenti.RegistroCollettivo.BloccaDocenti then
  begin
    Firma.ImageIndex := dx.IndiceIcona('bs_dichiarazione__actions_check');
    Firma.Caption := 'Firmato'
  end
  else
  begin
    Firma.ImageIndex := dx.IndiceIcona('bs_dichiarazione');
    Firma.Caption := 'Firma';
  end;
end;

procedure TFrameRegistroCollettivo.BloccaPresenzeExecute(Sender: TObject);
begin
  inherited;

  // Mantis #47 - 2026-07-28: comando di blocco/sblocco autorizzato delle
  // presenze studenti della giornata, indipendente dalla firma docenti.
  // Il ricarico completo (PostMessage cmd_CaricaProgetto, non un semplice
  // DisplayTree) e' necessario: dopo uno sblocco puo' comparire lavoro nuovo
  // da salvare (NuovePresenzeDaSalvare), che si legge solo rieseguendo PREP.
  RegistroStudenti.BloccaPresenzeCollettivo(IdProgetto, IdCorso, DataLezione, not RegistroStudenti.RegistroCollettivo.BloccaStudenti);
  PostMessage(Self.Handle, cmd_CaricaProgetto, 0, 0);
end;

procedure TFrameRegistroCollettivo.BloccaPresenzeUpdate(Sender: TObject);
begin
  inherited;

  // Mantis #47 - 2026-07-28: visibile solo a chi ha l'autorizzazione allo
  // sblocco; la firma NON pretende piu' questa autorizzazione (vedi
  // STUDENTI_PRESENZE_COLL_TMP_FIRM), quindi il comando resta l'unico varco.
  TAction(Sender).Visible := Config.zSystem.Authorizhed(Gesty_Authorizations.REGISTRO_COLL_SBLOCCA_STUDENTI);

  if RegistroStudenti.RegistroCollettivo.BloccaStudenti then
  begin
    // icone di dx.Immagini: presenze con il lucchetto chiuso o aperto
    BloccaPresenze.ImageIndex := dx.IndiceIcona('mdi_calendar-account__security_unlock');
    BloccaPresenze.Caption := 'Sblocca Presenze';
  end
  else
  begin
    BloccaPresenze.ImageIndex := dx.IndiceIcona('mdi_calendar-account__security_lock');
    BloccaPresenze.Caption := 'Blocca Presenze';
  end;
end;

procedure TFrameRegistroCollettivo.SalvaExecute(Sender: TObject);
begin
  inherited;
  SalvaRegistro;
end;

procedure TFrameRegistroCollettivo.SalvaUpdate(Sender: TObject);
begin
  inherited;
  // Mantis #47 - 2026-07-28: NuovePresenzeDaSalvare segnala le presenze
  // mancanti da creare (tipico dopo uno sblocco, o per un allievo iscritto
  // dopo la firma). Senza includerlo qui l'utente non ha modo di farle
  // creare, perche' non ha nulla da modificare a mano su quell'ora.
  TAction(Sender).Enabled := RegistroStudenti.RegistroCollettivo.PresenzeModificate or RegistroStudenti.RegistroCollettivo.NuovePresenzeDaSalvare;
end;

procedure TFrameRegistroCollettivo.treeMaterieGetCellHint(Sender: TcxCustomTreeList; ACell: TObject; var AText: string; var ANeedShow: Boolean);
begin
  inherited;
  ANeedShow := true;

  if ACell is TcxTreeListEditCellViewInfo then
    AText := TcxTreeListEditCellViewInfo(ACell).column.StatusHint;
end;

procedure TFrameRegistroCollettivo.treeRegistroCustomDrawDataCell(Sender: TcxCustomTreeList; ACanvas: TcxCanvas; AViewInfo: TcxTreeListEditCellViewInfo; var ADone: Boolean);
var
  StatoPresenza: TStatoPresenza;
begin
  inherited;
  ADone := false;
  ACanvas.Font.Style := ACanvas.Font.Style - [fsBold];

  if AViewInfo.column = treeRegistroColStudente then
  begin
    StatoPresenza := TStatoPresenza.FromString(VarToStr(AViewInfo.Node.Values[treeRegistroColStatoPresenza.ItemIndex]));

    if StatoPresenza in [spAssente, spGiustificato] then
      ACanvas.Font.Style := ACanvas.Font.Style + [fsBold];
  end;
end;

procedure TFrameRegistroCollettivo.treeRegistroInitEdit(Sender, AItem: TObject; AEdit: TcxCustomEdit);
begin
  inherited;

  if AItem is TcxTreeListColumn then
    // Mantis #47 - 2026-07-28: gate per singola ora (era: BloccaStudenti globale)
    if not IsOraBloccata(TcxTreeListColumn(AItem)) then
      if AItem <> treeRegistroColStatoPresenza then
        if TcxTreeListColumn(AItem).RepositoryItem = cxEditRepositoryStatoPresenza then
          TcxCustomEditAccess(AEdit).PopupMenu := dxBarPopupMenu;
end;

procedure TFrameRegistroCollettivo.btnMinutiAssenzaClick(Sender: TObject);
var
  Studente: TStudente;
  Ora: integer;
  MinutiAssenza: integer;
begin
  inherited;

  // Mantis #47 - 2026-07-28: gate per singola ora (era: BloccaStudenti globale)
  if not IsOraBloccata(treeRegistro.FocusedColumn) then
    if Sender is TdxBarButton then
    begin
      MinutiAssenza := TdxBarButton(Sender).Tag;
      Studente := SelectedStudente;
      Ora := treeRegistro.FocusedColumn.Tag;
      Studente.OrePresenza.UpdatePresenza(Ora, MinutiAssenza);
      RegistroStudenti.SalvaStudente(IdProgetto, DataLezione, Studente);
      PostMessage(Self.Handle, cmd_DisplayTree, 0, 0);
    end;
end;

procedure TFrameRegistroCollettivo.SetDataLezione(const value: TDate);
begin
  FDataLezione := value;
  VaiAlGiorno.Caption := DateToStr(DataLezione);
  CaricaProgetto;
end;

procedure TFrameRegistroCollettivo.OggiExecute(Sender: TObject);
begin
  inherited;

  if RegistroStudenti.CloseQuery then
    DataLezione := Date;
end;

procedure TFrameRegistroCollettivo.VaiAlGiornoExecute(Sender: TObject);
var
  Data: TDate;
begin
  inherited;

  if not RegistroStudenti.CloseQuery then
    exit;

  Data := DataLezione;

  if zMsg.InputDate('Seleziona data', 'Seleziona data', Data) then
    DataLezione := Data;
end;

procedure TFrameRegistroCollettivo.InitMinuti;
  procedure Init(btn: TdxBarButton; minuti: integer);
  begin
    btn.Caption := minuti.ToString + ' minuti';
    btn.Tag := minuti;
    btn.OnClick := btnMinutiAssenzaClick;
    btn.ButtonStyle := bsChecked;
    btn.GroupIndex := 1;
  end;

begin
  Init(btnMinuti0, 0);
  Init(btnMinuti5, 5);
  Init(btnMinuti10, 10);
  Init(btnMinuti15, 15);
  Init(btnMinuti20, 20);
  Init(btnMinuti25, 25);
  Init(btnMinuti30, 30);
  Init(btnMinuti35, 35);
  Init(btnMinuti40, 40);
  Init(btnMinuti45, 45);
  Init(btnMinuti50, 50);
  Init(btnMinuti55, 55);
  Init(btnMinuti60, 60);
end;

procedure TFrameRegistroCollettivo.dxBarPopupMenuPopup(Sender: TObject);
var
  Studente: TStudente;
  Ora: integer;
  MinutiAssenza: integer;
  Presenza: TPresenza;
begin
  inherited;

  // Mantis #47 - 2026-07-28: gate per singola ora (era: BloccaStudenti globale)
  if IsOraBloccata(treeRegistro.FocusedColumn) then
    Abort;

  if treeRegistro.FocusedColumn = treeRegistroColStatoPresenza then
    Abort;

  Studente := SelectedStudente;
  Ora := treeRegistro.FocusedColumn.Tag;
  Presenza := Studente.OrePresenza.getPresenza(Ora);
  MinutiAssenza := Presenza.MinutiAssenza;

  btnMinuti0.Down := MinutiAssenza = 0;
  btnMinuti5.Down := MinutiAssenza = 5;
  btnMinuti10.Down := MinutiAssenza = 10;
  btnMinuti15.Down := MinutiAssenza = 15;
  btnMinuti20.Down := MinutiAssenza = 20;
  btnMinuti25.Down := MinutiAssenza = 25;
  btnMinuti30.Down := MinutiAssenza = 30;
  btnMinuti35.Down := MinutiAssenza = 35;
  btnMinuti40.Down := MinutiAssenza = 40;
  btnMinuti45.Down := MinutiAssenza = 45;
  btnMinuti50.Down := MinutiAssenza = 50;
  btnMinuti55.Down := MinutiAssenza = 55;
  btnMinuti60.Down := MinutiAssenza = 60;
end;

procedure TFrameRegistroCollettivo.AggiornaAltezzaTreeMaterie;
begin
  dxLayoutItemMaterie.ControlOptions.OriginalHeight := Normalize(dxLayoutItemMaterie.ControlOptions.OriginalHeight);
end;

function TFrameRegistroCollettivo.Normalize(value: integer): integer;
begin
  result := MulDiv(value, CurrentPPI, 96);
end;

procedure TFrameRegistroCollettivo.OpenRegistro(aDataLezione: TDateTime; const aIdProgetto, aIdCorso: integer);
begin
  DataLezione := aDataLezione;
  edProgetto.EditValue := aIdProgetto;
  edCorso.EditValue := aIdCorso;
end;

procedure TFrameRegistroCollettivo.CalendarioCorsiExecute(Sender: TObject);
var
  FormOrario: TFormOrario;
begin
  inherited;

  if FormCollection.FormExists(TFormOrario) then
    FormOrario := FormCollection.GetForm(TFormOrario) as TFormOrario
  else
    FormOrario := FormCollection.CreateForm(TFormOrario) as TFormOrario;

  FormOrario.ShowForm(false);

  FormOrario.OpenCalendarioCorsi(RegistroStudenti.CurrentData, RegistroStudenti.CurrentProgetto, RegistroStudenti.CurrentCorso);
end;

end.
