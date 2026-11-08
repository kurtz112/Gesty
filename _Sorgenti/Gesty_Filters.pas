unit Gesty_Filters;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Variants,
  System.DateUtils,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Vcl.Controls,
  dxBar,
  cxBarEditItem,
  cxImageComboBox,
  cxSpinEdit,
  Base_DataModule,
  zFbDataSet,
  zToolFilter,
  zSystem,
  dbMaster,
  System.Generics.Collections,
  cxCalendar;

// ── DataModule lookup ─────────────────────────────────────────────────────────

type
  TGestyFilterDefs = class(TBaseDataModule)
    lkAnniFormativi: TzFbDataSet;
    lkAnniEsercizio: TzFbDataSet;
    lkEnti: TzFbDataSet;
    lkSedi: TzFbDataSet;
    lkFontiFinanziamento: TzFbDataSet;
    lkAreeRiferimento: TzFbDataSet;
    lkSettoriAziendali: TzFbDataSet;
    lkAS_Comuni: TzFbDataSet;
    lkAbitareSost_Comuni: TzFbDataSet;
    lkAbitareEmergenza_Comuni: TzFbDataSet;
    lkSia_Macrogruppi: TzFbDataSet;
    lkSia_Comuni: TzFbDataSet;
    lkSportelliSAL: TzFbDataSet;
    lkFigureProfessionali: TzFbDataSet;
    lkMansioniAziendali: TzFbDataSet;
  public
    // Valore anno formativo corrente letto dal database.
    // Corrisponde a Common.AnnoFormativoCorrente del vecchio dmTools.
    function AnnoFormativoCorrente: Variant;
  end;

  // Accessor lazy. Crea TGestyFilterDefs al primo accesso, la riusa poi.
  // Non deve essere chiamato prima che la connessione DB sia attiva.
function GestyFilters: TGestyFilterDefs;

// ── Classi concrete TzToolFilter ───────────────────────────────────────────────
//
// Nota generale: i costruttori per-classe sono spariti — le classi ereditano
// Create(AProps) e Create(AInitialValue) dalla base TzToolFilter. Caption,
// Hint, Width, FieldName, Position vengono letti in Apply tramite gli accessor
// Filter* della base: il literal storico resta come Default, l'override
// per-istanza arriva dal TzToolFilterProps persistito.

type
  // ── Anno Formativo ───────────────────────────────────────────────────────────

  TAnnoFormativoBarFilter = class(TzToolFilter)
  public
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
    class procedure InitProperties(Props: TcxImageComboBoxProperties);
  end;

  // ── Anno Solare ──────────────────────────────────────────────────────────────

  TAnnoSolareBarFilter = class(TzToolFilter)
  private
    // Validator sullo spin: respinge anni < 1900, rimette l'anno corrente
    procedure AnnoSolareValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  public
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
  end;

  // ── Anno Esercizio ───────────────────────────────────────────────────────────

  TAnnoEsercizioBarFilter = class(TzToolFilter)
  public
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
    class procedure InitProperties(Props: TcxImageComboBoxProperties);
  end;

  // ── Mese ─────────────────────────────────────────────────────────────────────

  TMeseBarFilter = class(TzToolFilter)
  public
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
  end;

  // ── Ente ─────────────────────────────────────────────────────────────────────

  TEnteBarFilter = class(TzToolFilter)
  public
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
    class procedure InitProperties(Props: TcxImageComboBoxProperties);
  end;

  // ── Sede ─────────────────────────────────────────────────────────────────────
  // Nota: FOnChange non è supportato dal registro (parametro fuori banda).
  // Chi necessita di OnChange personalizzato crea TSedeBarFilter direttamente
  // in SetupComponents, passando il callback nel costruttore dedicato.

  TSedeBarFilter = class(TzToolFilter)
  private
    FOnChange: TNotifyEvent;
  public
    // Creazione manuale con callback custom (il registro usa Create(AProps))
    constructor Create(AInitialValue: TFilterInitialValue; AOnChange: TNotifyEvent); overload;
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
    class procedure InitProperties(Props: TcxImageComboBoxProperties);

    // Metodo di compatibilita' per il vecchio Tools.AddFiltroSede(dxBarManagerBar, SedeChanged, ivDefault, 0)
    class procedure ApplyTo(Component: TComponent; OnChange: TNotifyEvent; AInitialValue: TFilterInitialValue = ivDefault; const APosition: Integer = -1); reintroduce; overload;
  end;

  // ── Fonte Finanziamento ──────────────────────────────────────────────────────

  TFonteFinanziamentoBarFilter = class(TzToolFilter)
  public
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
    class procedure InitProperties(Props: TcxImageComboBoxProperties);
  end;

  // ── Area Riferimento ─────────────────────────────────────────────────────────

  TAreaRiferimentoBarFilter = class(TzToolFilter)
  public
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
    class procedure InitProperties(Props: TcxImageComboBoxProperties);
  end;

  // ── Settore Aziendale ────────────────────────────────────────────────────────

  TSettoreAziendaleBarFilter = class(TzToolFilter)
  public
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
    class procedure InitProperties(Props: TcxImageComboBoxProperties);
  end;

  // ── AS Comuni (Assistenza Sociale) ───────────────────────────────────────────
  // Lookup: lkAS_Comuni → BELFIORE / COMUNE

  TASComuniBarFilter = class(TzToolFilter)
  public
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
    class procedure InitProperties(Props: TcxImageComboBoxProperties);
  end;

  // ── Abitare Sostegno Comuni ──────────────────────────────────────────────────
  // Lookup: lkAbitareSost_Comuni → BELFIORE / COMUNE

  TAbitareSostegnoComuniBarFilter = class(TzToolFilter)
  public
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
    class procedure InitProperties(Props: TcxImageComboBoxProperties);
  end;

  // ── Abitare Emergenza Comuni ─────────────────────────────────────────────────
  // Lookup: lkAbitareEmergenza_Comuni → BELFIORE / COMUNE

  TAbitareEmergenzaComuniBarFilter = class(TzToolFilter)
  public
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
    class procedure InitProperties(Props: TcxImageComboBoxProperties);
  end;

  // ── SIA Macrogruppi ──────────────────────────────────────────────────────────
  // Lookup: lkSia_Macrogruppi → MACROGRUPPO_SIA / DESC_MACROGRUPPO_SIA

  TSiaMacrogruppiBarFilter = class(TzToolFilter)
  public
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
    class procedure InitProperties(Props: TcxImageComboBoxProperties);
  end;

  // ── SIA Comuni ───────────────────────────────────────────────────────────────
  // Lookup: lkSia_Comuni → BELFIORE / COMUNE
  // Il parametro predefinito e' COMUNE_SIA, il nome del campo negli interventi;
  // sui finanziamenti la vista LZ indica BELFIORE in FieldName.

  TSiaComuniBarFilter = class(TzToolFilter)
  public
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
    class procedure InitProperties(Props: TcxImageComboBoxProperties);
  end;

  // ── Sportello SAL ────────────────────────────────────────────────────────────
  // Lookup: lkSportelliSAL → SPORTELLO_SAL / SPORTELLO_SAL

  TSportelloSALBarFilter = class(TzToolFilter)
  public
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
    class procedure InitProperties(Props: TcxImageComboBoxProperties);
  end;

  // ── PickList (generico) ──────────────────────────────────────────────────────
  // Parametri letti dal TzToolFilterProps (property tipizzate, con fallback
  // transitorio sulle chiavi omonime in Params per gli LZ pre-promozione):
  // PickList    = nome della TzPickList (es: 'INCARICO_INTERNO_ESTERNO')
  // FieldName   = nome del parametro nel dataset
  // Caption     = etichetta del controllo
  // Hint        = tooltip (opzionale, default = Caption minuscolo)
  // Width       = larghezza in pixel (opzionale, default 100)
  // AllowNull   = voce 'tutti' presente (opzionale, default True)
  // CaptionAll  = etichetta voce "tutti" (opzionale, default 'Tutti')

  TPickListBarFilter = class(TzToolFilter)
  public
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
  end;

  // ── Boolean ──────────────────────────────────────────────────────────────────
  // Parametri letti dal TzToolFilterProps:
  // FieldName = nome del parametro nel dataset
  // Caption   = etichetta del controllo
  // Hint      = tooltip (opzionale)
  // Width     = larghezza in pixel (opzionale, default 75)
  // AllowNull = voce 'tutti' presente (default True; False = sì/no obbligatorio)
  // CaptionAll= etichetta voce "tutti" (default 'Tutti')

  TBooleanBarFilter = class(TzToolFilter)
  public
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;
  end;

  // ── Filtro Data ──────────────────────────────────────────────────────────────

  TDateBarFilter = class(TzToolFilter)
  private
    class var FChangeProcs: TDictionary<TcxBarEditItem, TProc<string, Variant>>;
    class var FFieldNames: TDictionary<TcxBarEditItem, string>;
    class procedure DateChangeHandler(Sender: TObject);
  public
    class constructor Create;
    class destructor Destroy;
    class function FilterName: string; override;
    function Description: string; override;
    procedure Apply(Component: TComponent; DataSet: TzFbDataSet); override;

    // Metodo di compatibilita' per il vecchio Tools.AddFiltroData
    class procedure ApplyTo(Component: TComponent; DataSet: TzFbDataSet; const AFieldName, ACaption, AHint: string; const AInitialValue: Variant; OnChangeProc: TProc<string, Variant> = nil; const AAllowNull: Boolean = False;
      const AWidth: Integer = 120; const APosition: Integer = -1); reintroduce; overload;
  end;

implementation

uses
  Vcl.Graphics,
  ConfigModule,
  zDX,
  zBaseLib,
  zDxBarHelper,
  zToolFilterHelper,
  dmCommon;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
// ── Lazy accessor ─────────────────────────────────────────────────────────────

var
  FGestyFilterDefs: TGestyFilterDefs = nil;

function GestyFilters: TGestyFilterDefs;
begin
  if not Assigned(FGestyFilterDefs) then
    FGestyFilterDefs := TGestyFilterDefs.Create(nil);
  Result := FGestyFilterDefs;
end;

// ── TGestyFilterDefs ──────────────────────────────────────────────────────────

function TGestyFilterDefs.AnnoFormativoCorrente: Variant;
begin
  Result := Common.AnnoFormativoCorrente;
end;

// ── Helper locale ─────────────────────────────────────────────────────────────

function GetToolbar(Component: TComponent): TdxBar;
var
  Comp: IzBaseComponent;
begin
  Result := nil;
  if Supports(Component, IzBaseComponent, Comp) then
    Result := Comp.GetToolbar;
end;

// Popola un TcxImageComboBoxProperties da un TzFbDataSet lookup.
// Apre e chiude il dataset — non deve essere aperto all'esterno.
procedure InitFromDataSet(Props: TcxImageComboBoxProperties; DataSet: TzFbDataSet; const FieldValue, FieldDesc: string);
begin
  Props.Items.Clear;

  TzToolFilterHelper.AddPickListValue(Props, Null, 'Tutti'); // ← voce 'Tutti' sempre prima

  DataSet.RevertSQL(true);
  try
    DataSet.DisableControls;
    try
      DataSet.First;

      while not DataSet.Eof do
      begin
        TzToolFilterHelper.AddPickListValue(Props, DataSet.FieldByName(FieldValue).Value, DataSet.FieldByName(FieldDesc).AsString);
        DataSet.Next;
      end;
    finally
      DataSet.EnableControls;
    end;
  finally
    DataSet.Active := False;
  end;
end;

// ZC 08.11.2026: larghezza del filtro ricavata dalle voci invece che fissa.
// Prima i filtri SIA nascevano larghi Combo.Width + 150 qualunque fosse il loro
// contenuto, e sulla barra degli interventi occupavano piu' spazio del necessario.
// Ora la larghezza e' quella della descrizione piu' lunga fra le voci ('Tutti'
// compresa) piu' lo spazio del pulsante a tendina, in pixel logici a 96 DPI:
// SetFilterWidth la riporta poi alla scala corrente della barra. La misura usa
// il carattere della barra e la sua risoluzione (Font.PixelsPerInch), cosi' il
// risultato non dipende dal DPI del monitor. Una larghezza scritta nel
// dizionario (ToolFilters.Width) resta prioritaria.
function LarghezzaDalleVoci(Combo: TcxBarEditItem; Props: TcxImageComboBoxProperties): Integer;
const
  SpazioPulsante = 34;
var
  Misura: TBitmap;
  Indice: Integer;
  Larghezza: Integer;
begin
  Result := 0;
  Misura := TBitmap.Create;
  try
    if Assigned(Combo.BarManager) then
      Misura.Canvas.Font.Assign(Combo.BarManager.Font);
    for Indice := 0 to Props.Items.Count - 1 do
    begin
      Larghezza := Misura.Canvas.TextWidth(Props.Items[Indice].Description);
      if Larghezza > Result then
        Result := Larghezza;
    end;
    if Misura.Canvas.Font.PixelsPerInch > 0 then
      Result := Round(Result * 96 / Misura.Canvas.Font.PixelsPerInch);
  finally
    Misura.Free;
  end;
  Result := Result + SpazioPulsante;
end;

// ── TAnnoFormativoBarFilter ───────────────────────────────────────────────────

class procedure TAnnoFormativoBarFilter.InitProperties(Props: TcxImageComboBoxProperties);
begin
  InitFromDataSet(Props, GestyFilters.lkAnniFormativi, 'ANNO_FORMATIVO', 'ANNO_FORMATIVO');
end;

class function TAnnoFormativoBarFilter.FilterName: string;
begin
  Result := 'AnnoFormativo';
end;

// ── TAnnoFormativoBarFilter ───────────────────────────────────────────────────

function TAnnoFormativoBarFilter.Description: string;
begin
  Result := DescribeInitial('Filtro anno formativo', 'anno corrente');
end;

procedure TAnnoFormativoBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  Combo: TcxBarEditItem;
  ComboProps: TcxImageComboBoxProperties;
const
  ComboName = ToolFilterPrefix + 'AnnoFormativo';
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;
  if TzDxBarHelper.ItemExists(Bar, ComboName) then
    Exit;

  Combo := TzDxBarHelper.CreateCombo(Bar, ComboName, FilterCaption('Anno Formativo:'), FilterHint('anno formativo'), FilterPosition);
  ComboProps := Combo.Properties as TcxImageComboBoxProperties;

  InitProperties(ComboProps);

  Combo.Tag := NativeInt(DataSet);
  SetFilterWidth(Combo, Combo.Width - 1);
  BindFilter(Combo, FilterFieldName('ANNO_FORMATIVO'));

  case InitialValue of
    ivNull:
      Combo.EditValue := Null;
    ivDefault:
      Combo.EditValue := GestyFilters.AnnoFormativoCorrente;
    ivCustom:
      Combo.EditValue := CustomEditValue;
  end;
end;

// ── TAnnoSolareBarFilter ──────────────────────────────────────────────────────

class function TAnnoSolareBarFilter.FilterName: string;
begin
  Result := 'AnnoSolare';
end;

function TAnnoSolareBarFilter.Description: string;
begin
  Result := DescribeInitial('Filtro anno solare', 'anno corrente');
end;

procedure TAnnoSolareBarFilter.AnnoSolareValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  I: Integer;
begin
  if not VarIsNull(DisplayValue) then
    if VarIsStr(DisplayValue) then
      if TryStrToInt(DisplayValue, I) then
        if I < 1900 then
          DisplayValue := YearOf(Date).ToString;
end;

procedure TAnnoSolareBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  Spin: TcxBarEditItem;
  SpinProps: TcxSpinEditProperties;
const
  SpinName = ToolFilterPrefix + 'AnnoSolare';
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;
  if TzDxBarHelper.ItemExists(Bar, SpinName) then
    Exit;

  Spin := TzDxBarHelper.CreateSpin(Bar, SpinName, FilterCaption('Anno:'), FilterHint('filtro per anno'), FilterPosition);
  SpinProps := Spin.Properties as TcxSpinEditProperties;
  SpinProps.MinValue := 0;
  SpinProps.OnValidate := AnnoSolareValidate;

  Spin.Tag := NativeInt(DataSet);
  SetFilterWidth(Spin, Spin.Width - 30);
  BindFilter(Spin, FilterFieldName('ANNO'));

  case InitialValue of
    ivNull:
      Spin.EditValue := Null;
    ivDefault:
      Spin.EditValue := YearOf(Date);
    ivCustom:
      Spin.EditValue := CustomEditValue;
  end;
end;

// ── TAnnoEsercizioBarFilter ───────────────────────────────────────────────────

class procedure TAnnoEsercizioBarFilter.InitProperties(Props: TcxImageComboBoxProperties);
begin
  InitFromDataSet(Props, GestyFilters.lkAnniEsercizio, 'ANNO_ESERCIZIO', 'ANNO_ESERCIZIO');
end;

class function TAnnoEsercizioBarFilter.FilterName: string;
begin
  Result := 'AnnoEsercizio';
end;

function TAnnoEsercizioBarFilter.Description: string;
begin
  Result := DescribeInitial('Filtro anno esercizio', 'anno corrente');
end;

procedure TAnnoEsercizioBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  Combo: TcxBarEditItem;
  ComboProps: TcxImageComboBoxProperties;
const
  ComboName = ToolFilterPrefix + 'AnnoEsercizio';
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;
  if TzDxBarHelper.ItemExists(Bar, ComboName) then
    Exit;

  Combo := TzDxBarHelper.CreateCombo(Bar, ComboName, FilterCaption('Anno Esercizio:'), FilterHint('anno esercizio'), FilterPosition);
  ComboProps := Combo.Properties as TcxImageComboBoxProperties;

  InitProperties(ComboProps);

  Combo.Tag := NativeInt(DataSet);
  SetFilterWidth(Combo, Combo.Width - 1);
  BindFilter(Combo, FilterFieldName('ANNO_ESERCIZIO'));

  // Nel codice originale ivDefault → null (problema non risolto).
  // Mantenuto lo stesso comportamento; ivCustom però è ora rispettato e
  // permette di impostare l'anno di partenza per singolo DataModule.
  if InitialValue = ivCustom then
    Combo.EditValue := CustomEditValue
  else
    Combo.EditValue := Null;
end;

// ── TMeseBarFilter ────────────────────────────────────────────────────────────

class function TMeseBarFilter.FilterName: string;
begin
  Result := 'Mese';
end;

function TMeseBarFilter.Description: string;
begin
  Result := DescribeInitial('Filtro mese', 'mese corrente');
end;

procedure TMeseBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  Combo: TcxBarEditItem;
  ComboProps: TcxImageComboBoxProperties;
  Mese: Integer;
const
  ComboName = ToolFilterPrefix + 'Mese';
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;
  if TzDxBarHelper.ItemExists(Bar, ComboName) then
    Exit;

  Combo := TzDxBarHelper.CreateCombo(Bar, ComboName, FilterCaption('Mese:'), FilterHint('mese'), FilterPosition);
  ComboProps := Combo.Properties as TcxImageComboBoxProperties;

  TzToolFilterHelper.AddPickListValue(ComboProps, Null, 'Tutti');
  for Mese := 1 to 12 do
    TzToolFilterHelper.AddPickListValue(ComboProps, Mese, zzCapFirst(FormatSettings.LongMonthNames[Mese], False));

  Combo.Tag := NativeInt(DataSet);
  SetFilterWidth(Combo, 100);
  BindFilter(Combo, FilterFieldName('MESE'));

  case InitialValue of
    ivNull:
      Combo.EditValue := Null;
    ivDefault:
      Combo.EditValue := MonthOf(Date);
    ivCustom:
      Combo.EditValue := CustomEditValue;
  end;
end;

// ── TEnteBarFilter ────────────────────────────────────────────────────────────

class procedure TEnteBarFilter.InitProperties(Props: TcxImageComboBoxProperties);
begin
  InitFromDataSet(Props, GestyFilters.lkEnti, 'ID_ENTE', 'ENTE');
end;

class function TEnteBarFilter.FilterName: string;
begin
  Result := 'Ente';
end;

function TEnteBarFilter.Description: string;
begin
  Result := DescribeInitial('Filtro ente', 'ente predefinito');
end;

procedure TEnteBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  Combo: TcxBarEditItem;
  ComboProps: TcxImageComboBoxProperties;
const
  ComboName = ToolFilterPrefix + 'Ente';
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;
  if TzDxBarHelper.ItemExists(Bar, ComboName) then
    Exit;

  Combo := TzDxBarHelper.CreateCombo(Bar, ComboName, FilterCaption('Ente:'), FilterHint('ente'), FilterPosition);
  ComboProps := Combo.Properties as TcxImageComboBoxProperties;

  InitProperties(ComboProps);

  Combo.Tag := NativeInt(DataSet);
  SetFilterWidth(Combo, Combo.Width + 75);
  BindFilter(Combo, FilterFieldName('ID_ENTE'));

  case InitialValue of
    ivNull:
      Combo.EditValue := Null;
    ivDefault:
      Combo.EditValue := Common.EnteDefault;
    ivCustom:
      Combo.EditValue := CustomEditValue;
  end;
end;

// ── TSedeBarFilter ────────────────────────────────────────────────────────────

constructor TSedeBarFilter.Create(AInitialValue: TFilterInitialValue; AOnChange: TNotifyEvent);
begin
  inherited Create(AInitialValue);
  FOnChange := AOnChange;
end;

class procedure TSedeBarFilter.InitProperties(Props: TcxImageComboBoxProperties);
begin
  InitFromDataSet(Props, GestyFilters.lkSedi, 'ID_SEDE', 'SEDE');
end;

class function TSedeBarFilter.FilterName: string;
begin
  Result := 'Sede';
end;

function TSedeBarFilter.Description: string;
begin
  Result := DescribeInitial('Filtro sede', 'sede predefinita');
end;

procedure TSedeBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  Combo: TcxBarEditItem;
  ComboProps: TcxImageComboBoxProperties;
const
  ComboName = ToolFilterPrefix + 'Sede';
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;
  if TzDxBarHelper.ItemExists(Bar, ComboName) then
    Exit;

  Combo := TzDxBarHelper.CreateCombo(Bar, ComboName, FilterCaption('Sede:'), FilterHint('sede'), FilterPosition);
  ComboProps := Combo.Properties as TcxImageComboBoxProperties;

  InitProperties(ComboProps);

  Combo.Tag := NativeInt(DataSet);
  SetFilterWidth(Combo, Combo.Width + 75);

  // OnChange custom (es: aggiornamento dataset dipendente) oppure standard
  if Assigned(FOnChange) then
    Combo.OnChange := FOnChange
  else
    BindFilter(Combo, FilterFieldName('ID_SEDE'));

  case InitialValue of
    ivNull:
      Combo.EditValue := Null;
    ivDefault:
      Combo.EditValue := Common.SedeDefault;
    ivCustom:
      Combo.EditValue := CustomEditValue;
  end;
end;

class procedure TSedeBarFilter.ApplyTo(Component: TComponent; OnChange: TNotifyEvent; AInitialValue: TFilterInitialValue; const APosition: Integer);
var
  Filter: TSedeBarFilter;
  TmpProps: TzToolFilterProps;
begin
  TmpProps := TzToolFilterProps.Create(nil);
  try
    TmpProps.Position := APosition;
    TmpProps.InitialValue := AInitialValue;
    Filter := TSedeBarFilter.Create(TmpProps);
    try
      Filter.FOnChange := OnChange;
      Filter.Apply(Component, nil);
    finally
      Filter.Free;
    end;
  finally
    TmpProps.Free;
  end;
end;

// ── TFonteFinanziamentoBarFilter ──────────────────────────────────────────────

class procedure TFonteFinanziamentoBarFilter.InitProperties(Props: TcxImageComboBoxProperties);
begin
  InitFromDataSet(Props, GestyFilters.lkFontiFinanziamento, 'FONTE_FINANZIAMENTO', 'FONTE_FINANZIAMENTO');
end;

class function TFonteFinanziamentoBarFilter.FilterName: string;
begin
  Result := 'FonteFinanziamento';
end;

function TFonteFinanziamentoBarFilter.Description: string;
begin
  Result := 'Filtro fonte di finanziamento (default: nessun filtro)';
end;

procedure TFonteFinanziamentoBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  Combo: TcxBarEditItem;
  ComboProps: TcxImageComboBoxProperties;
const
  ComboName = ToolFilterPrefix + 'FonteFinanziamento';
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;
  if TzDxBarHelper.ItemExists(Bar, ComboName) then
    Exit;

  Combo := TzDxBarHelper.CreateCombo(Bar, ComboName, FilterCaption('Fonte Finanziamento:'), FilterHint('fonte finanziamento'), FilterPosition);
  ComboProps := Combo.Properties as TcxImageComboBoxProperties;

  InitProperties(ComboProps);

  Combo.Tag := NativeInt(DataSet);
  SetFilterWidth(Combo, Combo.Width + 150);
  BindFilter(Combo, FilterFieldName('FONTE_FINANZIAMENTO'));
  if InitialValue = ivCustom then
    Combo.EditValue := CustomEditValue
  else
    Combo.EditValue := Null;
end;

// ── TAreaRiferimentoBarFilter ─────────────────────────────────────────────────

class procedure TAreaRiferimentoBarFilter.InitProperties(Props: TcxImageComboBoxProperties);
begin
  InitFromDataSet(Props, GestyFilters.lkAreeRiferimento, 'AREA_RIFERIMENTO', 'AREA_RIFERIMENTO');
end;

class function TAreaRiferimentoBarFilter.FilterName: string;
begin
  Result := 'AreaRiferimento';
end;

function TAreaRiferimentoBarFilter.Description: string;
begin
  Result := 'Filtro area di riferimento (default: nessun filtro)';
end;

procedure TAreaRiferimentoBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  Combo: TcxBarEditItem;
  ComboProps: TcxImageComboBoxProperties;
const
  ComboName = ToolFilterPrefix + 'AreaRiferimento';
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;
  if TzDxBarHelper.ItemExists(Bar, ComboName) then
    Exit;

  Combo := TzDxBarHelper.CreateCombo(Bar, ComboName, FilterCaption('Area Riferimento:'), FilterHint('area riferimento'), FilterPosition);
  ComboProps := Combo.Properties as TcxImageComboBoxProperties;

  InitProperties(ComboProps);

  Combo.Tag := NativeInt(DataSet);
  SetFilterWidth(Combo, Combo.Width + 100);
  BindFilter(Combo, FilterFieldName('AREA_RIFERIMENTO'));
  if InitialValue = ivCustom then
    Combo.EditValue := CustomEditValue
  else
    Combo.EditValue := Null;
end;

// ── TSettoreAziendaleBarFilter ────────────────────────────────────────────────

class procedure TSettoreAziendaleBarFilter.InitProperties(Props: TcxImageComboBoxProperties);
begin
  InitFromDataSet(Props, GestyFilters.lkSettoriAziendali, 'CODICE_SETTORE_AZIENDALE', 'SETTORE_AZIENDALE');
end;

class function TSettoreAziendaleBarFilter.FilterName: string;
begin
  Result := 'SettoreAziendale';
end;

function TSettoreAziendaleBarFilter.Description: string;
begin
  Result := 'Filtro settore aziendale (default: nessun filtro)';
end;

procedure TSettoreAziendaleBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  Combo: TcxBarEditItem;
  ComboProps: TcxImageComboBoxProperties;
const
  ComboName = ToolFilterPrefix + 'SettoreAziendale';
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;
  if TzDxBarHelper.ItemExists(Bar, ComboName) then
    Exit;

  Combo := TzDxBarHelper.CreateCombo(Bar, ComboName, FilterCaption('Settore Aziendale:'), FilterHint('settore aziendale'), FilterPosition);
  ComboProps := Combo.Properties as TcxImageComboBoxProperties;

  InitProperties(ComboProps);

  Combo.Tag := NativeInt(DataSet);
  SetFilterWidth(Combo, Combo.Width + 150);
  BindFilter(Combo, FilterFieldName('CODICE_SETTORE_AZIENDALE'));
  if InitialValue = ivCustom then
    Combo.EditValue := CustomEditValue
  else
    Combo.EditValue := Null;
end;

// ── TASComuniBarFilter ────────────────────────────────────────────────────────

class procedure TASComuniBarFilter.InitProperties(Props: TcxImageComboBoxProperties);
begin
  InitFromDataSet(Props, GestyFilters.lkAS_Comuni, 'BELFIORE', 'COMUNE');
end;

class function TASComuniBarFilter.FilterName: string;
begin
  Result := 'ASComuni';
end;

function TASComuniBarFilter.Description: string;
begin
  Result := 'Filtro comune (Assistenza Sociale) (default: nessun filtro)';
end;

procedure TASComuniBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  Combo: TcxBarEditItem;
  ComboProps: TcxImageComboBoxProperties;
const
  ComboName = ToolFilterPrefix + 'AS_Comune';
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;
  if TzDxBarHelper.ItemExists(Bar, ComboName) then
    Exit;

  Combo := TzDxBarHelper.CreateCombo(Bar, ComboName, FilterCaption('Comune:'), FilterHint('comune'), FilterPosition);
  ComboProps := Combo.Properties as TcxImageComboBoxProperties;

  InitProperties(ComboProps);

  Combo.Tag := NativeInt(DataSet);
  SetFilterWidth(Combo, Combo.Width + 150);
  BindFilter(Combo, FilterFieldName('BELFIORE'));
  if InitialValue = ivCustom then
    Combo.EditValue := CustomEditValue
  else
    Combo.EditValue := Null;
end;

// ── TAbitareSostegnoComuniBarFilter ───────────────────────────────────────────

class procedure TAbitareSostegnoComuniBarFilter.InitProperties(Props: TcxImageComboBoxProperties);
begin
  InitFromDataSet(Props, GestyFilters.lkAbitareSost_Comuni, 'BELFIORE', 'COMUNE');
end;

class function TAbitareSostegnoComuniBarFilter.FilterName: string;
begin
  Result := 'AbitareSostegnoComuni';
end;

function TAbitareSostegnoComuniBarFilter.Description: string;
begin
  Result := 'Filtro comune (Abitare Sostegno) (default: nessun filtro)';
end;

procedure TAbitareSostegnoComuniBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  Combo: TcxBarEditItem;
  ComboProps: TcxImageComboBoxProperties;
const
  ComboName = ToolFilterPrefix + 'AbitareSostegno_Comuni';
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;
  if TzDxBarHelper.ItemExists(Bar, ComboName) then
    Exit;

  Combo := TzDxBarHelper.CreateCombo(Bar, ComboName, FilterCaption('Comune:'), FilterHint('comune'), FilterPosition);
  ComboProps := Combo.Properties as TcxImageComboBoxProperties;

  InitProperties(ComboProps);

  Combo.Tag := NativeInt(DataSet);
  SetFilterWidth(Combo, Combo.Width + 150);
  BindFilter(Combo, FilterFieldName('BELFIORE'));
  if InitialValue = ivCustom then
    Combo.EditValue := CustomEditValue
  else
    Combo.EditValue := Null;
end;

// ── TAbitareEmergenzaComuniBarFilter ──────────────────────────────────────────

class procedure TAbitareEmergenzaComuniBarFilter.InitProperties(Props: TcxImageComboBoxProperties);
begin
  InitFromDataSet(Props, GestyFilters.lkAbitareEmergenza_Comuni, 'BELFIORE', 'COMUNE');
end;

class function TAbitareEmergenzaComuniBarFilter.FilterName: string;
begin
  Result := 'AbitareEmergenzaComuni';
end;

function TAbitareEmergenzaComuniBarFilter.Description: string;
begin
  Result := 'Filtro comune (Abitare Emergenza) (default: nessun filtro)';
end;

procedure TAbitareEmergenzaComuniBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  Combo: TcxBarEditItem;
  ComboProps: TcxImageComboBoxProperties;
const
  ComboName = ToolFilterPrefix + 'AbitareEmergenza_Comuni';
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;
  if TzDxBarHelper.ItemExists(Bar, ComboName) then
    Exit;

  Combo := TzDxBarHelper.CreateCombo(Bar, ComboName, FilterCaption('Comune:'), FilterHint('comune'), FilterPosition);
  ComboProps := Combo.Properties as TcxImageComboBoxProperties;

  InitProperties(ComboProps);

  Combo.Tag := NativeInt(DataSet);
  SetFilterWidth(Combo, Combo.Width + 150);
  BindFilter(Combo, FilterFieldName('BELFIORE'));
  if InitialValue = ivCustom then
    Combo.EditValue := CustomEditValue
  else
    Combo.EditValue := Null;
end;

// ── TSiaMacrogruppiBarFilter ──────────────────────────────────────────────────

class procedure TSiaMacrogruppiBarFilter.InitProperties(Props: TcxImageComboBoxProperties);
begin
  InitFromDataSet(Props, GestyFilters.lkSia_Macrogruppi, 'MACROGRUPPO_SIA', 'DESC_MACROGRUPPO_SIA');
end;

class function TSiaMacrogruppiBarFilter.FilterName: string;
begin
  Result := 'SiaMacrogruppo';
end;

function TSiaMacrogruppiBarFilter.Description: string;
begin
  Result := 'Filtro macrogruppo SIA (default: nessun filtro)';
end;

procedure TSiaMacrogruppiBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  Combo: TcxBarEditItem;
  ComboProps: TcxImageComboBoxProperties;
const
  ComboName = ToolFilterPrefix + 'Sia_Macrogruppo';
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;
  if TzDxBarHelper.ItemExists(Bar, ComboName) then
    Exit;

  Combo := TzDxBarHelper.CreateCombo(Bar, ComboName, FilterCaption('Macrogruppo:'), FilterHint('macrogruppo'), FilterPosition);
  ComboProps := Combo.Properties as TcxImageComboBoxProperties;

  InitProperties(ComboProps);

  Combo.Tag := NativeInt(DataSet);
  SetFilterWidth(Combo, LarghezzaDalleVoci(Combo, ComboProps));
  BindFilter(Combo, FilterFieldName('MACROGRUPPO_SIA'));
  if InitialValue = ivCustom then
    Combo.EditValue := CustomEditValue
  else
    Combo.EditValue := Null;
end;

// ── TSiaComuniBarFilter ───────────────────────────────────────────────────────

class procedure TSiaComuniBarFilter.InitProperties(Props: TcxImageComboBoxProperties);
begin
  InitFromDataSet(Props, GestyFilters.lkSia_Comuni, 'BELFIORE', 'COMUNE');
end;

class function TSiaComuniBarFilter.FilterName: string;
begin
  Result := 'SiaComune';
end;

function TSiaComuniBarFilter.Description: string;
begin
  Result := 'Filtro comune SIA (default: nessun filtro)';
end;

procedure TSiaComuniBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  Combo: TcxBarEditItem;
  ComboProps: TcxImageComboBoxProperties;
const
  ComboName = ToolFilterPrefix + 'Sia_Comune';
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;
  if TzDxBarHelper.ItemExists(Bar, ComboName) then
    Exit;

  Combo := TzDxBarHelper.CreateCombo(Bar, ComboName, FilterCaption('Comune:'), FilterHint('comune'), FilterPosition);
  ComboProps := Combo.Properties as TcxImageComboBoxProperties;

  InitProperties(ComboProps);

  Combo.Tag := NativeInt(DataSet);
  SetFilterWidth(Combo, LarghezzaDalleVoci(Combo, ComboProps));
  BindFilter(Combo, FilterFieldName('COMUNE_SIA'));
  if InitialValue = ivCustom then
    Combo.EditValue := CustomEditValue
  else
    Combo.EditValue := Null;
end;

// ── TSportelloSALBarFilter ────────────────────────────────────────────────────

class procedure TSportelloSALBarFilter.InitProperties(Props: TcxImageComboBoxProperties);
begin
  InitFromDataSet(Props, GestyFilters.lkSportelliSAL, 'SPORTELLO_SAL', 'SPORTELLO_SAL');
end;

class function TSportelloSALBarFilter.FilterName: string;
begin
  Result := 'SportelloSAL';
end;

function TSportelloSALBarFilter.Description: string;
begin
  Result := 'Filtro sportello SAL (default: nessun filtro)';
end;

procedure TSportelloSALBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  Combo: TcxBarEditItem;
  ComboProps: TcxImageComboBoxProperties;
const
  ComboName = ToolFilterPrefix + 'SportelloSAL';
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;
  if TzDxBarHelper.ItemExists(Bar, ComboName) then
    Exit;

  Combo := TzDxBarHelper.CreateCombo(Bar, ComboName, FilterCaption('Sportello:'), FilterHint('sportello SAL'), FilterPosition);
  ComboProps := Combo.Properties as TcxImageComboBoxProperties;

  InitProperties(ComboProps);

  Combo.Tag := NativeInt(DataSet);
  SetFilterWidth(Combo, Combo.Width + 150);
  BindFilter(Combo, FilterFieldName('SPORTELLO_SAL'));
  if InitialValue = ivCustom then
    Combo.EditValue := CustomEditValue
  else
    Combo.EditValue := Null;
end;

// ── TPickListBarFilter ────────────────────────────────────────────────────────

class function TPickListBarFilter.FilterName: string;
begin
  Result := 'PickList';
end;

function TPickListBarFilter.Description: string;
var
  Cap, PL: string;
begin
  Cap := FilterCaption('');
  if Cap <> '' then
    Result := 'Filtro ' + Cap
  else
    Result := 'Filtro ' + FilterFieldName('');
  PL := FilterPickListName('');
  if PL <> '' then
    Result := Result + ' (' + PL + ')';
end;

procedure TPickListBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  Combo: TcxBarEditItem;
  ComboProps: TcxImageComboBoxProperties;
  Item: TcxImageComboBoxItem;
  ComboName, PLName: string;
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;

  PLName := FilterPickListName('');

  // univoco per istanza; il default e' il nome storico
  ComboName := ToolFilterPrefix + FilterInstanceName('PickList' + PLName + FilterFieldName(''));

  if TzDxBarHelper.ItemExists(Bar, ComboName) then
    Exit;

  Combo := TzDxBarHelper.CreateCombo(Bar, ComboName, FilterCaption(''), FilterHint(FilterCaption('').ToLower), FilterPosition);
  ComboProps := Combo.Properties as TcxImageComboBoxProperties;

  dx.InitPickList(ComboProps, PLName);
  ComboProps.Images := dx.Immagini;

  if FilterAllowNull(true) then
  begin
    Item := ComboProps.Items.Add;
    Item.Index := 0;
    Item.Description := FilterCaptionAll('Tutti');
    Item.Value := Null;
    Item.ImageIndex := ImmagineVoceTutti;
  end;

  Combo.Tag := NativeInt(DataSet);
  SetFilterWidth(Combo, 100);
  BindFilter(Combo, FilterFieldName(''));

  if InitialValue = ivCustom then
    Combo.EditValue := CustomEditValue
  else
    Combo.EditValue := Null;
end;



// ── TBooleanBarFilter ─────────────────────────────────────────────────────────

class function TBooleanBarFilter.FilterName: string;
begin
  Result := 'Boolean';
end;

function TBooleanBarFilter.Description: string;
var
  Cap: string;
begin
  Cap := FilterCaption('');
  if Cap <> '' then
    Result := 'Filtro ' + Cap + ' (sì/no/tutti)'
  else
    Result := 'Filtro booleano ' + FilterFieldName('') + ' (sì/no/tutti)';
end;

procedure TBooleanBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Tmp: TzToolFilterProps;
  Filter: TPickListBarFilter;
begin
  // Boolean è un PickList con la pick list 'BOOLEAN' predefinita.
  // Clona il prop e forza PickList + Width (default 75 anziché 100);
  // AllowNull e CaptionAll passano dal prop: un filtro booleano con
  // AllowNull=False diventa una scelta sì/no obbligatoria (senza 'Tutti').
  Tmp := TzToolFilterProps.Create(nil);
  try
    if Assigned(Props) then
      Tmp.Assign(Props);
    Tmp.PickListName := 'BOOLEAN';
    Tmp.Width := FilterWidth(75);

    Filter := TPickListBarFilter.Create(Tmp);
    try
      Filter.Apply(Component, DataSet);
    finally
      Filter.Free;
    end;
  finally
    FreeAndNil(Tmp);
  end;
end;

// ── TDateBarFilter ────────────────────────────────────────────────────────────

class constructor TDateBarFilter.Create;
begin
  FChangeProcs := TDictionary < TcxBarEditItem, TProc < string, Variant >>.Create;
  FFieldNames := TDictionary<TcxBarEditItem, string>.Create;
end;

class destructor TDateBarFilter.Destroy;
begin
  FreeAndNil(FChangeProcs);
  FreeAndNil(FFieldNames);
end;

class function TDateBarFilter.FilterName: string;
begin
  Result := 'Date';
end;

function TDateBarFilter.Description: string;
begin
  Result := DescribeInitial('Filtro data', 'nessun filtro');
end;

procedure TDateBarFilter.Apply(Component: TComponent; DataSet: TzFbDataSet);
var
  Bar: TdxBar;
  DateItem: TcxBarEditItem;
  DateProps: TcxDateEditProperties;
  ComboName: string;
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;

  ComboName := ToolFilterPrefix + FilterInstanceName('FiltroData' + FilterFieldName('DATA'));

  if TzDxBarHelper.ItemExists(Bar, ComboName) then
    Exit;

  DateItem := TzDxBarHelper.CreateDate(Bar, ComboName, FilterCaption('Data:'), FilterHint('filtro per data'), FilterPosition);
  DateProps := DateItem.Properties as TcxDateEditProperties;

  DateItem.Tag := NativeInt(DataSet);
  SetFilterWidth(DateItem, 120);

  // Se c'è una procedura di callback registrata, colleghiamo il gestore di classe
  if FChangeProcs.ContainsKey(DateItem) then
    DateItem.OnChange := DateChangeHandler
  else
    BindFilter(DateItem, FilterFieldName('DATA'));

  case InitialValue of
    ivNull:
      DateItem.EditValue := Null;
    ivDefault:
      DateItem.EditValue := Date; // data corrente come default
    ivCustom:
      DateItem.EditValue := CustomEditValue;
  end;
end;

class procedure TDateBarFilter.DateChangeHandler(Sender: TObject);
var
  Item: TcxBarEditItem;
  ParamName: string;
  Proc: TProc<string, Variant>;
begin
  if not(Sender is TcxBarEditItem) then
    Exit;
  Item := TcxBarEditItem(Sender);

  if FFieldNames.TryGetValue(Item, ParamName) then
  begin
    if Item.Tag <> 0 then
      TzToolFilterHelper.ImpostaFiltro(Item, ParamName);

    if FChangeProcs.TryGetValue(Item, Proc) then
      Proc(ParamName, Item.EditValue);
  end;
end;

class procedure TDateBarFilter.ApplyTo(Component: TComponent; DataSet: TzFbDataSet; const AFieldName, ACaption, AHint: string; const AInitialValue: Variant; OnChangeProc: TProc<string, Variant>; const AAllowNull: Boolean; const AWidth: Integer;
  const APosition: Integer);
var
  Filter: TDateBarFilter;
  TmpProps: TzToolFilterProps;
  ComboName: string;
  Bar: TdxBar;
  Item: TcxBarEditItem;
begin
  Bar := GetToolbar(Component);
  if not Assigned(Bar) then
    Exit;

  // Cerchiamo l'elemento sulla toolbar per evitare di registrarlo più volte
  ComboName := ToolFilterPrefix + 'FiltroData' + AFieldName;
  Item := TcxBarEditItem(TzDxBarHelper.FindItem(Bar.BarManager, ComboName));

  TmpProps := TzToolFilterProps.Create(nil);
  try
    TmpProps.FieldName := AFieldName;
    TmpProps.Caption := ACaption;
    TmpProps.Hint := AHint;
    TmpProps.Width := AWidth;
    TmpProps.Position := APosition;
    TmpProps.AllowNull := AAllowNull;

    if not VarIsNull(AInitialValue) then
    begin
      TmpProps.InitialValue := ivCustom;
      TmpProps.CustomValue := VarToStr(AInitialValue);
    end
    else
      TmpProps.InitialValue := ivNull;

    Filter := TDateBarFilter.Create(TmpProps);
    try
      Filter.Apply(Component, DataSet);

      if not Assigned(Item) then
        Item := TcxBarEditItem(TzDxBarHelper.FindItem(Bar.BarManager, ComboName));

      if Assigned(Item) then
      begin
        if Assigned(OnChangeProc) then
        begin
          FChangeProcs.AddOrSetValue(Item, OnChangeProc);
          FFieldNames.AddOrSetValue(Item, AFieldName);
          Item.OnChange := DateChangeHandler;
        end;
      end;
    finally
      Filter.Free;
    end;
  finally
    TmpProps.Free;
  end;
end;

// ── Registrazione ─────────────────────────────────────────────────────────────

initialization

TzToolFilterRegistry.Register(TAnnoFormativoBarFilter);
TzToolFilterRegistry.Register(TAnnoSolareBarFilter);
TzToolFilterRegistry.Register(TAnnoEsercizioBarFilter);
TzToolFilterRegistry.Register(TMeseBarFilter);
TzToolFilterRegistry.Register(TEnteBarFilter);
TzToolFilterRegistry.Register(TSedeBarFilter);
TzToolFilterRegistry.Register(TFonteFinanziamentoBarFilter);
TzToolFilterRegistry.Register(TAreaRiferimentoBarFilter);
TzToolFilterRegistry.Register(TSettoreAziendaleBarFilter);
TzToolFilterRegistry.Register(TASComuniBarFilter);
TzToolFilterRegistry.Register(TAbitareSostegnoComuniBarFilter);
TzToolFilterRegistry.Register(TAbitareEmergenzaComuniBarFilter);
TzToolFilterRegistry.Register(TSiaMacrogruppiBarFilter);
TzToolFilterRegistry.Register(TSiaComuniBarFilter);
TzToolFilterRegistry.Register(TSportelloSALBarFilter);
TzToolFilterRegistry.Register(TPickListBarFilter);
TzToolFilterRegistry.Register(TBooleanBarFilter);
TzToolFilterRegistry.Register(TDateBarFilter);

finalization

FreeAndNil(FGestyFilterDefs);

end.

