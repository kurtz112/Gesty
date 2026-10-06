unit BaseWeb.PropertyEditors;

{
  Property editor personalizzati per i campi enum di BaseWeb.Models.
  Da registrare all'avvio dell'applicazione (o nella sezione initialization).

  Ogni editor mostra un combo a tendina con i valori ammessi dal dominio
  Firebird corrispondente. I valori con asterisco (*) sono quelli di default.

  Registrazione automatica via sezione initialization di questa unit:
  basta includerla nei uses di qualsiasi unit del progetto ZZWebDesigner.

  Dipendenze DevExpress:
  cxPropertyEditorFactory, cxRTTIInspector
}

interface

uses
  System.SysUtils,
  System.Classes,
  // cxPropertyEditorFactory,
  cxOI,
  zz.Nullable,
  BaseWeb.Models,
  System.Rtti;

{ Registra tutti i property editor. Chiamata automatica da initialization. }
procedure RegisterBaseWebPropertyEditors;

implementation

uses
  TypInfo,
  Variants;

{ --------------------------------------------------------- }
{ Classe base: editor a tendina con lista valori fissi }
{ --------------------------------------------------------- }

type
  TBaseWebEnumEditor = class(TcxPropertyEditor)
  protected
    { Restituisce i valori ammessi del dominio, separati da virgola.
      Rinominato EnumValues per non confliggersi con GetValues di TcxPropertyEditor. }
    function EnumValues: string; virtual; abstract;
  public
    function GetAttributes: TcxPropertyAttributes; override;
    { Metodo corretto dell'API TcxPropertyEditor: chiama Proc per ogni valore. }
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TBaseWebEnumEditor.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaValueList, ipaSortList, ipaMultiSelect];
end;

procedure TBaseWebEnumEditor.GetValues(Proc: TGetStrProc);
var
  Values: TStringList;
  I: Integer;
begin
  Values := TStringList.Create;
  try
    Values.CommaText := EnumValues;
    for I := 0 to Values.Count - 1 do
      Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

{ --------------------------------------------------------- }
{ BASE_WEB_GRID_EDIT_MODE }
{ Property: TBaseWebDataset.GridEditMode }
{ Dominio Firebird: VARCHAR(10) }
{ Valori: popup* | row | batch | cell | form }
{ --------------------------------------------------------- }

type
  TGridEditModeEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TGridEditModeEditor.EnumValues: string;
begin
  Result := 'popup,row,batch,cell,form';
end;

{ --------------------------------------------------------- }
{ BASE_WEB_GRID_SELECTION_MODE }
{ Property: TBaseWebDataset.GridSelectionMode }
{ Dominio Firebird: VARCHAR(10) }
{ Valori: none* | single | multiple }
{ --------------------------------------------------------- }

type
  TGridSelectionModeEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TGridSelectionModeEditor.EnumValues: string;
begin
  Result := 'none,single,multiple';
end;

{ --------------------------------------------------------- }
{ BASE_WEB_GRID_SELECTION_CHECKBOX }
{ Property: TBaseWebDataset.GridSelectionCheckbox }
{ Dominio Firebird: VARCHAR(10) }
{ Valori: onClick* | always }
{ --------------------------------------------------------- }

type
  TGridSelectionCheckboxEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TGridSelectionCheckboxEditor.EnumValues: string;
begin
  Result := 'onClick,always';
end;

{ --------------------------------------------------------- }
{ BASE_WEB_GRID_SELECTION_SELECTALL }
{ Property: TBaseWebDataset.GridSelectionSelectAll }
{ Dominio Firebird: VARCHAR(10) }
{ Valori: allPages* | page }
{ --------------------------------------------------------- }

type
  TGridSelectionSelectAllEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TGridSelectionSelectAllEditor.EnumValues: string;
begin
  Result := 'allPages,page';
end;

{ --------------------------------------------------------- }
{ BASE_WEB_GRID_EXPORT_FORMATS }
{ Property: TBaseWebDataset.GridExportFormats }
{ Dominio Firebird: VARCHAR(30)  (combinabile con virgola) }
{ Valori: xlsx* | csv | pdf }
{ Nota: ammette valori combinati es. "xlsx,csv" }
{ --------------------------------------------------------- }

type
  TGridExportFormatsEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TGridExportFormatsEditor.EnumValues: string;
begin
  // Valori singoli + combinazioni comuni
  Result := 'xlsx,csv,pdf,xlsx csv,xlsx pdf,xlsx csv pdf';
end;

{ --------------------------------------------------------- }
{ BASE_WEB_FORM_LABEL_LOC }
{ Property: TBaseWebDataset.FormLabelLoc }
{ Dominio Firebird: VARCHAR(5) }
{ Valori: top* | left }
{ --------------------------------------------------------- }

type
  TFormLabelLocEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TFormLabelLocEditor.EnumValues: string;
begin
  Result := 'top,left';
end;

{ --------------------------------------------------------- }
{ BASE_WEB_FORM_LAYOUT }
{ Property: TBaseWebDataset.FormLayout }
{ Dominio Firebird: VARCHAR(10) }
{ Valori: flat* | groups | tabs }
{ --------------------------------------------------------- }

type
  TFormLayoutEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TFormLayoutEditor.EnumValues: string;
begin
  Result := 'flat,groups,tabs';
end;

{ --------------------------------------------------------- }
{ BASE_WEB_EDITOR_TYPE }
{ Property: TBaseWebField.EditorType }
{ Dominio Firebird: VARCHAR(30) }
{ Valori: tipi editor DevExtreme dxForm }
{ --------------------------------------------------------- }

type
  TEditorTypeEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TEditorTypeEditor.EnumValues: string;
begin
  Result := 'dxTextBox,' + 'dxNumberBox,' + 'dxDateBox,' + 'dxDateRangeBox,' + 'dxCheckBox,' + 'dxSelectBox,' + 'dxTagBox,' + 'dxTextArea,' + 'dxHtmlEditor,' + 'dxColorBox,' + 'dxSlider,' + 'dxRangeSlider,' + 'dxSwitch,' + 'dxRadioGroup,' +
    'dxAutocomplete,' + 'dxLookup,' + 'dxFileUploader';
end;

{ --------------------------------------------------------- }
{ BASE_WEB_ALIGN (usato per Alignment e Fixed) }
{ Properties: TBaseWebGridBand.Alignment }
{ TBaseWebGridColumn.Alignment }
{ TBaseWebGridColumn.Fixed }
{ TBaseWebLookupColumn.Alignment }
{ Dominio Firebird: CHAR(1) }
{ Valori: S=sinistra | D=destra | C=centro }
{ (Fixed usa solo: S=sinistra | D=destra) }
{ --------------------------------------------------------- }

type
  TAlignmentEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TAlignmentEditor.EnumValues: string;
begin
  // S=Left, D=Right, C=Center — mostriamo il codice usato nel DB
  Result := 'S,D,C';
end;

type
  TFixedEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TFixedEditor.EnumValues: string;
begin
  // Fixed accetta solo S (sinistra) o D (destra)
  Result := 'S,D';
end;

{ --------------------------------------------------------- }
{ BASE_WEB_SUMMARY_TYPE }
{ Property: TBaseWebGridColumn.SummaryType }
{ Dominio Firebird: VARCHAR(10) }
{ Valori: sum | min | max | avg | count }
{ --------------------------------------------------------- }

type
  TSummaryTypeEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TSummaryTypeEditor.EnumValues: string;
begin
  Result := 'sum,min,max,avg,count';
end;

{ --------------------------------------------------------- }
{ BASE_WEB_BUTTON_TYPE }
{ Property: TBaseWebFormButton.BtnType }
{ Dominio Firebird: VARCHAR(10) }
{ Valori DevExtreme dxButton.type: default | normal | }
{ success | danger | back }
{ --------------------------------------------------------- }

type
  TBtnTypeEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TBtnTypeEditor.EnumValues: string;
begin
  Result := 'default,normal,success,danger,back';
end;

{ --------------------------------------------------------- }
{ BASE_WEB_BUTTON_H_ALIGN }
{ Property: TBaseWebFormButton.BtnHorizontalAlign }
{ Dominio Firebird: VARCHAR(10) }
{ Valori: left | center | right }
{ --------------------------------------------------------- }

type
  TBtnHorizontalAlignEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TBtnHorizontalAlignEditor.EnumValues: string;
begin
  Result := 'left,center,right';
end;

{ --------------------------------------------------------- }
{ BASE_WEB_BUTTON_ICON_POS }
{ Property: TBaseWebFormButton.BtnIconPosition }
{ Dominio Firebird: VARCHAR(10) }
{ Valori DevExtreme dxButton.iconPosition: left | right }
{ --------------------------------------------------------- }

type
  TBtnIconPositionEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TBtnIconPositionEditor.EnumValues: string;
begin
  Result := 'left,right';
end;

{ --------------------------------------------------------- }
{ BtnStylingMode  (nessun dominio dedicato in Firebird, }
{ Property: TBaseWebFormButton.BtnStylingMode }
{ Valori DevExtreme dxButton.stylingMode: }
{ contained | outlined | text }
{ --------------------------------------------------------- }

type
  TBtnStylingModeEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TBtnStylingModeEditor.EnumValues: string;
begin
  Result := 'contained,outlined,text';
end;

{ --------------------------------------------------------- }
{ BASE_WEB_FORM_TABS_POSITION }
{ Property: TBaseWebFormTabbed.TabsPosition }
{ TBaseWebFormTabbedCustom.TabsPosition }
{ Valori DevExtreme dxTabPanel.tabsPosition: }
{ top* | bottom | left | right }
{ --------------------------------------------------------- }

type
  TTabsPositionEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TTabsPositionEditor.EnumValues: string;
begin
  Result := 'top,bottom,left,right';
end;

{ --------------------------------------------------------- }
{ BASE_WEB_FORM_TABBED_STYLING_MODE }
{ Property: TBaseWebFormTabbed.StylingMode }
{ TBaseWebFormTabbedCustom.StylingMode }
{ Valori DevExtreme dxTabPanel.stylingMode: }
{ primary | secondary | text }
{ --------------------------------------------------------- }

type
  TTabbedStylingModeEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TTabbedStylingModeEditor.EnumValues: string;
begin
  Result := 'primary,secondary,text';
end;

{ --------------------------------------------------------- }
{ BASE_WEB_FORM_TABBED_ICON_POSITION }
{ Property: TBaseWebFormTabbed.IconPosition }
{ TBaseWebFormTabbedCustom.IconPosition }
{ Valori DevExtreme: top | start | end | bottom }
{ --------------------------------------------------------- }

type
  TIconPositionEditor = class(TBaseWebEnumEditor)
  protected
    function EnumValues: string; override;
  end;

function TIconPositionEditor.EnumValues: string;
begin
  Result := 'top,start,end,bottom';
end;

{ --------------------------------------------------------- }
{ TNullableBoolean — editor a tre stati }
{ Valori visualizzati: (null) | True | False }
{ }
{ GetValue/SetValue operano sulla property come stringa: }
{ null  -> '(null)' }
{ True  -> 'True' }
{ False -> 'False' }
{ }
{ Nota: l'inspector chiama GetValue/SetValue passando }
{ la property come OrdinalValue tramite RTTI. Per i record }
{ Nullable<T> il TcxPropertyEditor non ha un handler }
{ nativo, quindi usiamo GetValueAsText/SetValueAsText che }
{ operano sulla rappresentazione stringa della property. }
{ --------------------------------------------------------- }

type
  TNullableBooleanEditor = class(TcxPropertyEditor)
  private
    function GetNullableValue: TNullable<Boolean>;
    procedure SetNullableValue(const AValue: TNullable<Boolean>);
    procedure Initialize;
  public
    function GetAttributes: TcxPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TNullableBooleanEditor.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaValueList, ipaSortList, ipaMultiSelect];
end;



// function TNullableBooleanEditor.GetNullableBoolean: TNullableBoolean;
// var
// V: TNullableBoolean;
// begin
// // Legge il valore raw dal primo componente selezionato
// // TcxPropertyEditor.GetOrdValue restituisce il valore come Int64;
// // per i record occorre usare GetValueAsVariant o accedere via indirizzo.
// // Usiamo il casting diretto tramite PropInfo address.
// Result.Clear;
// try
// // Il runtime RTTI per record non è supportato da GetOrdValue/GetFloatValue.
// // Accediamo al campo via GetOrdValue interpretando i byte del record.
// // TNullableBoolean = packed record fValue: Boolean; fHasValue: string; end
// // La dimensione del record dipende dalla piattaforma; usiamo GetPropValue
// // che restituisce Variant e sfruttiamo l'operatore implicito Variant->T.
// var vt := GetPropValue(GetComponent(0), GetName, False);
// if VarIsNull(vt) or VarIsEmpty(vt) then
// Result.Clear
// else if Boolean(vt) then
// Result := True
// else
// Result := False;
// except
// Result.Clear;
// end;
// end;
//
// procedure TNullableBooleanEditor.SetNullableBoolean(const V: TNullableBoolean);
// var
// I: Integer;
// begin
// for I := 0 to PropCount - 1 do
// try
// if V.IsNull then
// SetPropValue(GetComponent(I), GetName, Null)
// else
// SetPropValue(GetComponent(I), GetName, V.Value);
// except
// // ignora errori su singoli componenti in multi-select
// end;
// end;

// Lettura
function TNullableBooleanEditor.GetNullableValue: TNullable<Boolean>;
var
  Ctx: TRttiContext;
  Typ: TRttiType;
  Prop: TRttiProperty;
  Val: TValue;
begin
  Result.Clear;

  Ctx := TRttiContext.Create;
  try
    Typ := Ctx.GetType(GetComponent(0).ClassType);
    Prop := Typ.GetProperty(GetName);
    if Assigned(Prop) then
    begin
      Val := Prop.GetValue(GetComponent(0));
      Val.ExtractRawData(@Result);
    end;
  finally
    Ctx.Free;
  end;
end;

// Scrittura
procedure TNullableBooleanEditor.SetNullableValue(const AValue: TNullable<Boolean>);
var
  Ctx: TRttiContext;
  Typ: TRttiType;
  Prop: TRttiProperty;
  Val: TValue;
begin
  Ctx := TRttiContext.Create;
  try
    Typ := Ctx.GetType(GetComponent(0).ClassType);
    Prop := Typ.GetProperty(GetName);
    if Assigned(Prop) then
    begin
      TValue.Make(@AValue, Prop.PropertyType.Handle, Val);
      Prop.SetValue(GetComponent(0), Val);
    end;
  finally
    Ctx.Free;
  end;
end;

procedure TNullableBooleanEditor.Initialize;
var
  NV: TNullable<Boolean>;
begin
  inherited;
  NV := GetNullableValue;
  if NV.IsNull then
    // mostra stato "null" nel tuo controllo
  else
    // mostra NV.Value (True/False)
end;

function TNullableBooleanEditor.GetValue: string;
var
  V: TNullableBoolean;
begin
  V := GetNullableValue;
  if V.IsNull then
    Result := '(null)'
  else
    if V.Value then
      Result := 'True'
    else
      Result := 'False';
end;

procedure TNullableBooleanEditor.SetValue(const Value: string);
var
  V: TNullableBoolean;
begin
  if SameText(Value, '(null)') or (Value = '') then
    V.Clear
  else
    if SameText(Value, 'True') then
      V := True
    else
      V := False;
  SetNullableValue(V);
end;

procedure TNullableBooleanEditor.GetValues(Proc: TGetStrProc);
begin
  Proc('(null)');
  Proc('True');
  Proc('False');
end;

{ --------------------------------------------------------- }
{ TNullableString — editor testo libero con stato (null) }
{ --------------------------------------------------------- }

type
  TNullableStringEditor = class(TcxPropertyEditor)
  private
    function GetNullableValue: TNullableString;
    procedure SetNullableValue(const AValue: TNullableString);
  public
    function GetAttributes: TcxPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

function TNullableStringEditor.GetAttributes: TcxPropertyAttributes;
begin
  // Testo libero: nessuna dropdown, supporta multi-select
  Result := [ipaMultiSelect];
end;

function TNullableStringEditor.GetNullableValue: TNullableString;
var
  Ctx: TRttiContext;
  Prop: TRttiProperty;
  Val: TValue;
begin
  Result.Clear;
  Ctx := TRttiContext.Create;
  try
    Prop := Ctx.GetType(GetComponent(0).ClassType).GetProperty(GetName);
    if Assigned(Prop) then
    begin
      Val := Prop.GetValue(GetComponent(0));
      Val.ExtractRawData(@Result);
    end;
  finally
    Ctx.Free;
  end;
end;

procedure TNullableStringEditor.SetNullableValue(const AValue: TNullableString);
var
  Ctx: TRttiContext;
  Prop: TRttiProperty;
  Val: TValue;
  I: Integer;
begin
  Ctx := TRttiContext.Create;
  try
    for I := 0 to PropCount - 1 do
    begin
      Prop := Ctx.GetType(GetComponent(I).ClassType).GetProperty(GetName);
      if Assigned(Prop) then
      begin
        TValue.Make(@AValue, Prop.PropertyType.Handle, Val);
        Prop.SetValue(GetComponent(I), Val);
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

function TNullableStringEditor.GetValue: string;
var
  V: TNullableString;
begin
  V := GetNullableValue;
  if V.IsNull then
    Result := ''
  else
    Result := V.Value;
end;

procedure TNullableStringEditor.SetValue(const Value: string);
var
  V: TNullableString;
begin
  if Value = '' then
    V.Clear
  else
    V := Value;
  SetNullableValue(V);
end;

{ --------------------------------------------------------- }
{ TNullableIntegerEditor — editor numerico con stato (null) }
{ Blank = null; qualsiasi intero = valore valorizzato }
{ --------------------------------------------------------- }

type
  TNullableIntegerEditor = class(TcxPropertyEditor)
  private
    function GetNullableValue: TNullableInteger;
    procedure SetNullableValue(const AValue: TNullableInteger);
  public
    function GetAttributes: TcxPropertyAttributes; override;
    function GetValue: string; override;
    procedure SetValue(const Value: string); override;
  end;

function TNullableIntegerEditor.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaMultiSelect];
end;

function TNullableIntegerEditor.GetNullableValue: TNullableInteger;
var
  Ctx: TRttiContext;
  Prop: TRttiProperty;
  Val: TValue;
begin
  Result.Clear;
  Ctx := TRttiContext.Create;
  try
    Prop := Ctx.GetType(GetComponent(0).ClassType).GetProperty(GetName);
    if Assigned(Prop) then
    begin
      Val := Prop.GetValue(GetComponent(0));
      Val.ExtractRawData(@Result);
    end;
  finally
    Ctx.Free;
  end;
end;

procedure TNullableIntegerEditor.SetNullableValue(const AValue: TNullableInteger);
var
  Ctx: TRttiContext;
  Prop: TRttiProperty;
  Val: TValue;
  I: Integer;
begin
  Ctx := TRttiContext.Create;
  try
    for I := 0 to PropCount - 1 do
    begin
      Prop := Ctx.GetType(GetComponent(I).ClassType).GetProperty(GetName);
      if Assigned(Prop) then
      begin
        TValue.Make(@AValue, Prop.PropertyType.Handle, Val);
        Prop.SetValue(GetComponent(I), Val);
      end;
    end;
  finally
    Ctx.Free;
  end;
end;

function TNullableIntegerEditor.GetValue: string;
var
  V: TNullableInteger;
begin
  V := GetNullableValue;
  if V.IsNull then
    Result := ''
  else
    Result := IntToStr(V.Value);
end;

procedure TNullableIntegerEditor.SetValue(const Value: string);
var
  V: TNullableInteger;
  N: Integer;
begin
  if Trim(Value) = '' then
    V.Clear
  else
    if TryStrToInt(Trim(Value), N) then
      V := N
    else
      Exit; // input non numerico: ignora silenziosamente
  SetNullableValue(V);
end;

{ --------------------------------------------------------- }
{ CONTAINER_TYPE }
{ Property: ContainerType su FormField, FormGroup, ecc. }
{ Tipo: TNullableString }
{ Valori ammessi: group | tab | tabbed }
{ --------------------------------------------------------- }

type
  TContainerTypeEditor = class(TNullableStringEditor)
  public
    function GetAttributes: TcxPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

function TContainerTypeEditor.GetAttributes: TcxPropertyAttributes;
begin
  Result := [ipaValueList, ipaSortList, ipaMultiSelect];
end;

procedure TContainerTypeEditor.GetValues(Proc: TGetStrProc);
begin
  Proc('group');
  Proc('tab');
  Proc('tabbed');
end;

{ --------------------------------------------------------- }
{ Registrazione }
{ --------------------------------------------------------- }

procedure RegisterBaseWebPropertyEditors;
begin
  // --- TBaseWebDataset ---
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebDataset, 'GridEditMode', TGridEditModeEditor);
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebDataset, 'GridSelectionMode', TGridSelectionModeEditor);
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebDataset, 'GridSelectionCheckbox', TGridSelectionCheckboxEditor);
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebDataset, 'GridSelectionSelectAll', TGridSelectionSelectAllEditor);
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebDataset, 'GridExportFormats', TGridExportFormatsEditor);
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebDataset, 'FormLabelLoc', TFormLabelLocEditor);
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebDataset, 'FormLayout', TFormLayoutEditor);

  // --- TBaseWebDatasetField / TBaseWebDatasetFieldCustom ---
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebDatasetField, 'EditorType', TEditorTypeEditor);

  // --- TBaseWebFormButton / TBaseWebFormButtonCustom ---
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebFormButton, 'BtnType', TBtnTypeEditor);
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebFormButton, 'BtnHorizontalAlign', TBtnHorizontalAlignEditor);
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebFormButton, 'BtnIconPosition', TBtnIconPositionEditor);
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebFormButton, 'BtnStylingMode', TBtnStylingModeEditor);

  // --- TBaseWebGridBand ---
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebGridBand, 'Alignment', TAlignmentEditor);

  // --- TBaseWebGridColumn ---
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebGridColumn, 'Alignment', TAlignmentEditor);
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebGridColumn, 'Fixed', TFixedEditor);
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebGridColumn, 'SummaryType', TSummaryTypeEditor);

  // --- TBaseWebLookupColumn ---
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebLookupColumn, 'Alignment', TAlignmentEditor);

  // --- TBaseWebFormTabbed / TBaseWebFormTabbedCustom ---
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebFormTabbed, 'TabsPosition', TTabsPositionEditor);
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebFormTabbed, 'StylingMode', TTabbedStylingModeEditor);
  cxRegisterPropertyEditor(TypeInfo(string), TBaseWebFormTabbed, 'IconPosition', TIconPositionEditor);

  // --- ContainerType (TNullableString → combo GROUP/TAB/TABBED) ---
  cxRegisterPropertyEditor(TypeInfo(TNullableString), TBaseWebFormField, 'ContainerType', TContainerTypeEditor);
  cxRegisterPropertyEditor(TypeInfo(TNullableString), TBaseWebFormGroup, 'ContainerType', TContainerTypeEditor);
  cxRegisterPropertyEditor(TypeInfo(TNullableString), TBaseWebFormButton, 'ContainerType', TContainerTypeEditor);
  cxRegisterPropertyEditor(TypeInfo(TNullableString), TBaseWebFormEmpty, 'ContainerType', TContainerTypeEditor);
  cxRegisterPropertyEditor(TypeInfo(TNullableString), TBaseWebFormTab, 'ContainerType', TContainerTypeEditor);

  cxRegisterPropertyEditor(TypeInfo(TNullableString), nil, '', TNullableStringEditor);
  cxRegisterPropertyEditor(TypeInfo(TNullableInteger), nil, '', TNullableIntegerEditor);
  cxRegisterPropertyEditor(TypeInfo(TNullableBoolean), nil, '', TNullableBooleanEditor);
end;

initialization

RegisterBaseWebPropertyEditors;

end.

