// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-08-31
// ---------------------------------------------------------------------------
unit zGrid;

// Griglia leggera su un TDataSet qualunque.
//
// Nasce come alternativa a TzDbView per i casi in cui non esiste un modello
// LZ: TzDbView richiede un TzSystem e lo usa in punti non protetti dal
// riferimento nullo (zDbView.pas righe 959, 986, 1476, 2183), quindi si porta
// dietro dizionario dei domini, configurazione salvata delle viste, scheda di
// dettaglio e permessi. Su una query estemporanea niente di tutto questo
// esiste.
//
// Qui le colonne nascono dai campi del dataset e basta. Cosa resta fuori
// rispetto a TzDbView: dizionario dei domini, filtri configurabili salvati,
// formattazione condizionale, scheda di dettaglio, permessi.
//
// Non dipende da Firebird ne' da zFbDataSet: si aggancia a un TDataSet, cosi'
// serve anche per le griglie di sola lettura sulle tabelle MON$.
//
// Destinazione finale zPack\zBase\ (unit riusabile, quindi senza prefisso
// applicativo). Per ora vive nel progetto.

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  System.Actions,
  System.IniFiles,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnList,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Clipbrd,
  Data.DB,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxClasses,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxNavigator,
  cxDBData,
  cxTextEdit,
  cxMemo,
  cxGridLevel,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  dxCore,
  dxBar,
  dxScrollbarAnnotations,
  dxDateRanges;

type
  TzGridCellEvent = procedure(Sender: TObject; Column: TcxGridDBColumn; Field: TField) of object;

  TzGrid = class(TFrame)
    dockTop: TdxBarDockControl;
    cxGrid: TcxGrid;
    GridView: TcxGridDBTableView;
    GridLevel: TcxGridLevel;
    DataSource: TDataSource;
    ActionList: TActionList;
    SaveDialog: TSaveDialog;
    actAdattaLarghezza: TAction;
    actRigaFiltri: TAction;
    actRicerca: TAction;
    actRaggruppamento: TAction;
    actPiePagina: TAction;
    actCopiaCella: TAction;
    actCopiaRiga: TAction;
    actImpostaNull: TAction;
    actImpostaVuoto: TAction;
    actVediValore: TAction;
    actEsportaExcel: TAction;
    actEsportaCsv: TAction;
    actEsportaHtml: TAction;
    procedure actAdattaLarghezzaExecute(Sender: TObject);
    procedure actCopiaCellaExecute(Sender: TObject);
    procedure actCopiaRigaExecute(Sender: TObject);
    procedure actEsportaCsvExecute(Sender: TObject);
    procedure actEsportaExcelExecute(Sender: TObject);
    procedure actEsportaHtmlExecute(Sender: TObject);
    procedure actImpostaNullExecute(Sender: TObject);
    procedure actImpostaVuotoExecute(Sender: TObject);
    procedure actPiePaginaExecute(Sender: TObject);
    procedure actRaggruppamentoExecute(Sender: TObject);
    procedure actRicercaExecute(Sender: TObject);
    procedure actRigaFiltriExecute(Sender: TObject);
    procedure actVediValoreExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure GridViewCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  private
    FBarManager: TdxBarManager;
    FBar: TdxBar;
    FDataSet: TDataSet;
    FOnCellDblClick: TzGridCellEvent;
    FShowToolbar: Boolean;

    procedure CreateBar;
    function FocusedColumn: TcxGridDBColumn;
    function FocusedField: TField;
    procedure SetShowToolbar(const Value: Boolean);
    function EsportaChiediNomeFile(const Descrizione, Estensione: string; out FileName: string): Boolean;
    procedure ModificaCampoFocalizzato(const Vuoto: Boolean);
  public
    constructor Create(aOwner: TComponent); override;

    // Aggancia il dataset e ricostruisce le colonne dai suoi campi.
    procedure Attach(aDataSet: TDataSet);
    procedure Detach;

    procedure RebuildColumns;
    procedure ApplyBestFit;

    // Modificabilita': la decide il chiamante, che e' l'unico a sapere se il
    // cursore e' aggiornabile. Qui non si interroga il modello dei metadati.
    procedure SetEditing(const CanInsert, CanUpdate, CanDelete: Boolean);

    // Disposizione delle colonne. Su una query estemporanea le colonne
    // cambiano a ogni esecuzione: se il ripristino non corrisponde ai campi
    // presenti, DevExpress solleva un errore, quindi LoadLayout torna False e
    // ricostruisce le colonne invece di propagarlo.
    procedure SaveLayout(const FileName, Chiave: string);
    function LoadLayout(const FileName, Chiave: string): Boolean;

    // Mostra il contenuto per esteso del campo focalizzato: serve per i campi
    // lunghi e per i BLOB di testo, illeggibili nella cella.
    procedure MostraValoreCampo(Field: TField);

    property DataSet: TDataSet read FDataSet;
    property BarManager: TdxBarManager read FBarManager;
    property Bar: TdxBar read FBar;
  published
    property ShowToolbar: Boolean read FShowToolbar write SetShowToolbar default True;
    property OnCellDblClick: TzGridCellEvent read FOnCellDblClick write FOnCellDblClick;
  end;

implementation

uses
  System.StrUtils,
  cxExport,
  cxGridExportLink,
  zdx,
  zBaseLib,
  zMsg;

{$R *.dfm}

constructor TzGrid.Create(aOwner: TComponent);
begin
  inherited;

  FShowToolbar := True;

  CreateBar;
end;

procedure TzGrid.CreateBar;

  procedure Aggiungi(Action: TBasicAction; const IniziaGruppo: Boolean = False);
  var
    Pulsante: TdxBarButton;
    Collegamento: TdxBarItemLink;
  begin
    Pulsante := TdxBarButton(FBarManager.AddItem(TdxBarButton));
    Pulsante.Action := Action;

    Collegamento := FBar.ItemLinks.Add;
    Collegamento.Item := Pulsante;
    Collegamento.BeginGroup := IniziaGruppo;
  end;

begin
  FBarManager := TdxBarManager.Create(Self);
  FBarManager.Categories.Add('Griglia');

  FBar := FBarManager.Bars.Add;
  FBar.Caption := 'Griglia';
  FBar.DockingStyle := dsNone;
  FBar.Visible := True;

  dockTop.BarManager := FBarManager;
  FBar.DockControl := dockTop;

  Aggiungi(actAdattaLarghezza);
  Aggiungi(actRigaFiltri, True);
  Aggiungi(actRicerca);
  Aggiungi(actRaggruppamento);
  Aggiungi(actPiePagina);
  Aggiungi(actCopiaCella, True);
  Aggiungi(actCopiaRiga);
  Aggiungi(actVediValore);
  Aggiungi(actImpostaNull, True);
  Aggiungi(actImpostaVuoto);
  Aggiungi(actEsportaExcel, True);
  Aggiungi(actEsportaCsv);
  Aggiungi(actEsportaHtml);

  dx.InitBar(FBar);
end;

procedure TzGrid.SetShowToolbar(const Value: Boolean);
begin
  FShowToolbar := Value;

  dockTop.Visible := Value;
end;

// ---------------------------------------------------------------------------
// Aggancio del dataset
// ---------------------------------------------------------------------------

procedure TzGrid.Attach(aDataSet: TDataSet);
begin
  FDataSet := aDataSet;

  DataSource.DataSet := aDataSet;

  RebuildColumns;
end;

procedure TzGrid.Detach;
begin
  FDataSet := nil;

  DataSource.DataSet := nil;

  GridView.ClearItems;
end;

procedure TzGrid.RebuildColumns;
var
  Indice: Integer;
  Colonna: TcxGridDBColumn;
begin
  GridView.BeginUpdate;
  try
    GridView.ClearItems;

    if not Assigned(FDataSet) or not FDataSet.Active then
      Exit;

    GridView.DataController.CreateAllItems;

    for Indice := 0 to GridView.ColumnCount - 1 do
    begin
      Colonna := GridView.Columns[Indice];

      Colonna.Visible := True;

      // senza dizionario dei domini la didascalia e' il nome del campo reso
      // leggibile: e' quello che il codice del vecchio editor faceva a mano
      if Colonna.Caption = '' then
        Colonna.Caption := CapFirst(Colonna.DataBinding.FieldName);

      // i BLOB non si modificano nella cella: il contenuto si guarda con
      // il comando dedicato
      if Assigned(Colonna.DataBinding.Field) and Colonna.DataBinding.Field.IsBlob then
        Colonna.Options.Editing := False;
    end;
  finally
    GridView.EndUpdate;
  end;

  ApplyBestFit;
end;

procedure TzGrid.ApplyBestFit;
begin
  if not Assigned(FDataSet) or not FDataSet.Active then
    Exit;

  if GridView.ColumnCount = 0 then
    Exit;

  // senza righe l'adattamento non ha nulla da misurare e su alcune versioni
  // solleva un errore di indice
  if GridView.ViewInfo.HeaderViewInfo.Count = 0 then
    Exit;

  GridView.OptionsBehavior.BestFitMaxRecordCount := GridView.DataController.RowCount;
  GridView.ApplyBestFit(nil);
end;

procedure TzGrid.SetEditing(const CanInsert, CanUpdate, CanDelete: Boolean);
begin
  GridView.OptionsData.Inserting := CanInsert;
  GridView.OptionsData.Editing := CanUpdate;
  GridView.OptionsData.Deleting := CanDelete;
end;

// ---------------------------------------------------------------------------
// Cella focalizzata
// ---------------------------------------------------------------------------

function TzGrid.FocusedColumn: TcxGridDBColumn;
begin
  Result := nil;

  if GridView.Controller.FocusedItem is TcxGridDBColumn then
    Result := TcxGridDBColumn(GridView.Controller.FocusedItem);
end;

function TzGrid.FocusedField: TField;
var
  Colonna: TcxGridDBColumn;
begin
  Result := nil;

  Colonna := FocusedColumn;

  if Assigned(Colonna) then
    Result := Colonna.DataBinding.Field;
end;

procedure TzGrid.GridViewCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if Assigned(FOnCellDblClick) then
    FOnCellDblClick(Self, FocusedColumn, FocusedField);
end;

// ---------------------------------------------------------------------------
// Comandi di vista
// ---------------------------------------------------------------------------

procedure TzGrid.actAdattaLarghezzaExecute(Sender: TObject);
begin
  ApplyBestFit;
end;

procedure TzGrid.actRigaFiltriExecute(Sender: TObject);
begin
  GridView.FilterRow.Visible := not GridView.FilterRow.Visible;
end;

procedure TzGrid.actRicercaExecute(Sender: TObject);
begin
  if GridView.Controller.IsFindPanelVisible then
    GridView.Controller.HideFindPanel
  else
    GridView.Controller.ShowFindPanel;
end;

procedure TzGrid.actRaggruppamentoExecute(Sender: TObject);
begin
  GridView.OptionsView.GroupByBox := not GridView.OptionsView.GroupByBox;
end;

procedure TzGrid.actPiePaginaExecute(Sender: TObject);
begin
  GridView.OptionsView.Footer := not GridView.OptionsView.Footer;
end;

// ---------------------------------------------------------------------------
// Appunti e modifica del valore
// ---------------------------------------------------------------------------

procedure TzGrid.actCopiaCellaExecute(Sender: TObject);
var
  Colonna: TcxGridDBColumn;
begin
  Colonna := FocusedColumn;

  if not Assigned(Colonna) or not Assigned(GridView.Controller.FocusedRecord) then
    Exit;

  Clipboard.AsText := GridView.Controller.FocusedRecord.DisplayTexts[Colonna.Index];
end;

procedure TzGrid.actCopiaRigaExecute(Sender: TObject);
var
  Indice: Integer;
  Valori: TStringList;
  Record_: TcxCustomGridRecord;
begin
  Record_ := GridView.Controller.FocusedRecord;

  if not Assigned(Record_) then
    Exit;

  Valori := TStringList.Create;
  try
    Valori.Delimiter := #9;
    Valori.StrictDelimiter := True;

    for Indice := 0 to GridView.VisibleColumnCount - 1 do
      Valori.Add(Record_.DisplayTexts[GridView.VisibleColumns[Indice].Index]);

    Clipboard.AsText := Valori.DelimitedText;
  finally
    FreeAndNil(Valori);
  end;
end;

procedure TzGrid.ModificaCampoFocalizzato(const Vuoto: Boolean);
var
  Campo: TField;
begin
  Campo := FocusedField;

  if not Assigned(Campo) or not Assigned(FDataSet) then
    Exit;

  if not(FDataSet.State in [dsEdit, dsInsert]) then
    FDataSet.Edit;

  if Vuoto then
    Campo.AsString := ''
  else
    Campo.Clear;
end;

procedure TzGrid.actImpostaNullExecute(Sender: TObject);
begin
  ModificaCampoFocalizzato(False);
end;

procedure TzGrid.actImpostaVuotoExecute(Sender: TObject);
begin
  ModificaCampoFocalizzato(True);
end;

// ---------------------------------------------------------------------------
// Contenuto per esteso di un campo
// ---------------------------------------------------------------------------

procedure TzGrid.actVediValoreExecute(Sender: TObject);
begin
  MostraValoreCampo(FocusedField);
end;

procedure TzGrid.MostraValoreCampo(Field: TField);
var
  Finestra: TForm;
  Memo: TcxMemo;
  Testo: string;
begin
  if not Assigned(Field) then
    Exit;

  if Field.IsNull then
    Testo := '(NULL)'
  else
    try
      Testo := Field.AsString;
    except
      // BLOB binario: AsString su dati non testuali solleva, e mostrare la
      // dimensione e' piu' utile di un errore
      on E: Exception do
        Testo := Format('(contenuto binario, %d byte)', [Field.DataSize]);
    end;

  Finestra := TForm.Create(nil);
  try
    Finestra.Caption := Field.FieldName;
    Finestra.Position := poMainFormCenter;
    Finestra.Width := 700;
    Finestra.Height := 500;
    Finestra.BorderIcons := [biSystemMenu, biMaximize];

    Memo := TcxMemo.Create(Finestra);
    Memo.Parent := Finestra;
    Memo.Align := alClient;
    Memo.Properties.ReadOnly := True;
    Memo.Properties.ScrollBars := ssBoth;
    Memo.Properties.WordWrap := False;
    Memo.Style.Font.Name := 'Consolas';
    Memo.Lines.Text := Testo;

    Finestra.ShowModal;
  finally
    FreeAndNil(Finestra);
  end;
end;

// ---------------------------------------------------------------------------
// Esportazione
//
// Le procedure di cxGridExportLink lavorano direttamente sul TcxGrid: nessun
// bisogno del contorno che zDbView.Export costruisce attorno a TzDbView.
// ---------------------------------------------------------------------------

function TzGrid.EsportaChiediNomeFile(const Descrizione, Estensione: string; out FileName: string): Boolean;
begin
  FileName := '';

  SaveDialog.Filter := Descrizione + ' (*.' + Estensione + ')|*.' + Estensione;
  SaveDialog.DefaultExt := Estensione;

  Result := SaveDialog.Execute;

  if Result then
    FileName := SaveDialog.FileName;
end;

procedure TzGrid.actEsportaExcelExecute(Sender: TObject);
var
  FileName: string;
begin
  if not EsportaChiediNomeFile('Cartella di Excel', 'xlsx', FileName) then
    Exit;

  ExportGridToXLSX(FileName, cxGrid);
end;

procedure TzGrid.actEsportaCsvExecute(Sender: TObject);
var
  FileName: string;
begin
  if not EsportaChiediNomeFile('Testo separato da punto e virgola', 'csv', FileName) then
    Exit;

  ExportGridToCSV(FileName, cxGrid, True, True, ';');
end;

procedure TzGrid.actEsportaHtmlExecute(Sender: TObject);
var
  FileName: string;
begin
  if not EsportaChiediNomeFile('Pagina HTML', 'html', FileName) then
    Exit;

  ExportGridToHTML(FileName, cxGrid);
end;

// ---------------------------------------------------------------------------
// Disposizione delle colonne
// ---------------------------------------------------------------------------

procedure TzGrid.SaveLayout(const FileName, Chiave: string);
begin
  if GridView.ColumnCount = 0 then
    Exit;

  // AReCreate a False: piu' disposizioni convivono nello stesso file,
  // distinte dal nome passato come chiave
  GridView.StoreToIniFile(FileName, False, [], Chiave);
end;

function TzGrid.LoadLayout(const FileName, Chiave: string): Boolean;
begin
  Result := False;

  if not FileExists(FileName) then
    Exit;

  try
    GridView.RestoreFromIniFile(FileName, True, False, [], Chiave);
    Result := True;
  except
    // la documentazione DevExpress avverte che il ripristino va fatto sugli
    // stessi campi: su una query estemporanea le colonne cambiano a ogni
    // esecuzione, quindi si riparte dalle colonne nuove
    on E: Exception do
      RebuildColumns;
  end;
end;

// ---------------------------------------------------------------------------
// Stato dei comandi
// ---------------------------------------------------------------------------

procedure TzGrid.ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
var
  Attivo: Boolean;
  Campo: TField;
begin
  Attivo := Assigned(FDataSet) and FDataSet.Active;
  Campo := FocusedField;

  actAdattaLarghezza.Enabled := Attivo;
  actRicerca.Enabled := Attivo;
  actEsportaExcel.Enabled := Attivo;
  actEsportaCsv.Enabled := Attivo;
  actEsportaHtml.Enabled := Attivo;

  actCopiaCella.Enabled := Attivo and (FocusedColumn <> nil);
  actCopiaRiga.Enabled := Attivo and Assigned(GridView.Controller.FocusedRecord);
  actVediValore.Enabled := Attivo and Assigned(Campo);

  actImpostaNull.Enabled := Attivo and Assigned(Campo) and GridView.OptionsData.Editing;
  actImpostaVuoto.Enabled := actImpostaNull.Enabled;

  actRigaFiltri.Checked := GridView.FilterRow.Visible;
  actRaggruppamento.Checked := GridView.OptionsView.GroupByBox;
  actPiePagina.Checked := GridView.OptionsView.Footer;
  actRicerca.Checked := GridView.Controller.IsFindPanelVisible;
end;

end.
