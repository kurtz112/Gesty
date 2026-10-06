unit BaseWeb.Repository;

{
  Repository di accesso dati per il sistema BASE_WEB (ZZWebDesigner).

  Pattern di accesso:
  - Load*  : usa TFDQuery con SELECT da procedure BASE_WEB_TABLE_IO.
             I parametri filtro sono string: se vuota il PARAM_* non viene
             impostato e Firebird restituisce tutti i record.
  - Save*  : usa BaseWebDM.GetSP<T>, assegna i parametri e chiama ExecuteAndCommit.
             Le SP di GROUPS/TABBED/TABS scrivono trasparentemente anche CONTAINER.

  Prefisso tipi: nessuno (standard progetto).
  Nessun supporto Custom/Nullable in questo layer.
}

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Data.Db,
  FireDAC.Comp.Client,
  zStoredProc,
  BaseWeb.Models,
  Gesty_StoredProcs;

type
  TBaseWebRepository = class
  private
    class procedure CheckConfigured; static;
    class function GetFDQuery(const sql: string): TFDQuery;
    class function GetSP<T: zStoredProc.TzStoredProc, constructor>: T; static;

    class function QStr(QR: TFDQuery; const Field: string): string; static; inline;
    class function QInt(QR: TFDQuery; const Field: string; Default: Integer = 0): Integer; static; inline;
    class function QBool(QR: TFDQuery; const Field: string; Default: Boolean = False): Boolean; static; inline;
    class function QMemo(QR: TFDQuery; const Field: string): string; static; inline;

    class procedure SetParam(QR: TFDQuery; const ParamName: string; const V: string); static; inline;
    class procedure SetSPStr(SP: TzStoredProc; const ParamName: string; const V: string); static; inline;

    class procedure FillDataset(DS: TBaseWebDataset; QR: TFDQuery); static;
  public

    { ---- DATASETS ---- }
    class procedure LoadDatasets(List: TObjectList<TBaseWebDataset>; const DatasetID: string);
    class procedure SaveDataset(DS: TBaseWebDataset);

    { ---- FIELDS ---- }
    class procedure LoadFields(List: TObjectList<TBaseWebDatasetField>; const DatasetID: string; const Field: string);
    class procedure SaveField(F: TBaseWebDatasetField);

    { ---- FORM TABBED ---- }
    class procedure LoadFormTabbed(List: TObjectList<TBaseWebFormTabbed>; const DatasetID: string; const TabbedName: string);
    class procedure SaveFormTabbed(T: TBaseWebFormTabbed);

    { ---- FORM TABS ---- }
    class procedure LoadFormTabs(List: TObjectList<TBaseWebFormTab>; const DatasetID: string; const TabName: string);
    class procedure SaveFormTab(T: TBaseWebFormTab);

    { ---- FORM GROUPS ---- }
    class procedure LoadFormGroups(List: TObjectList<TBaseWebFormGroup>; const DatasetID: string; const GroupName: string);
    class procedure SaveFormGroup(G: TBaseWebFormGroup);

    { ---- FORM FIELDS (layout) ---- }
    class procedure LoadFormFields(List: TObjectList<TBaseWebFormField>; const DatasetID: string; const FieldName: string);
    class procedure SaveFormField(FF: TBaseWebFormField);

    { ---- FORM BUTTONS ---- }
    class procedure LoadFormButtons(List: TObjectList<TBaseWebFormButton>; const DatasetID: string; const ButtonName: string);
    class procedure SaveFormButton(B: TBaseWebFormButton);

    { ---- FORM EMPTY ---- }
    class procedure LoadFormEmpty(List: TObjectList<TBaseWebFormEmpty>; const DatasetID: string; const EmptyName: string);
    class procedure SaveFormEmpty(E: TBaseWebFormEmpty);

    { ---- GRID BANDS ---- }
    class procedure LoadGridBands(List: TObjectList<TBaseWebGridBand>; const DatasetID: string; const BandName: string);
    class procedure SaveGridBand(B: TBaseWebGridBand);

    { ---- GRID COLUMNS ---- }
    class procedure LoadGridColumns(List: TObjectList<TBaseWebGridColumn>; const DatasetID: string; const FieldName: string);
    class procedure SaveGridColumn(C: TBaseWebGridColumn);

    { ---- LOOKUPS ---- }
    class procedure LoadLookups(List: TObjectList<TBaseWebLookup>; const LookupID: string);
    class procedure SaveLookup(L: TBaseWebLookup);
    class procedure LoadLookupColumns(List: TObjectList<TBaseWebLookupColumn>; const LookupID: string; const FieldName: string);
    class procedure SaveLookupColumn(C: TBaseWebLookupColumn);

    { ---- PICKLISTS ---- }
    class procedure LoadPicklists(List: TObjectList<TBaseWebPicklist>; const PicklistID: string);
    class procedure SavePicklist(P: TBaseWebPicklist);
    class procedure LoadPicklistItems(List: TObjectList<TBaseWebPicklistItem>; const PicklistID: string; const Nome: string);
    class procedure SavePicklistItem(I: TBaseWebPicklistItem);

    { ---- STRUTTURA COMPLETA ---- }
    class function LoadDatasetStructure(const DatasetID: string): TBaseWebDatasetStructure; static;
    class procedure SaveDatasetStructure(const Struct: TBaseWebDatasetStructure); static;
  end;

  TBaseWebDataAccessAbstract = class abstract
  public
    function GetFDQuery(const sql: string): TFDQuery; virtual; abstract;
    function GetSP(AClass: zStoredProc.TzStoredProcClass): zStoredProc.TzStoredProc; virtual; abstract;
    function ExecuteSQL(const sql: string): variant; virtual; abstract;
  end;

var
  BaseWebDataAccess: TBaseWebDataAccessAbstract;

implementation

{ --------------------------------------------------------- }
{ Infrastruttura }
{ --------------------------------------------------------- }

class procedure TBaseWebRepository.CheckConfigured;
begin
  if not Assigned(BaseWebDataAccess) then
    raise Exception.Create('BaseWebDataAccess non configurato.');
end;

class function TBaseWebRepository.GetFDQuery(const sql: string): TFDQuery;
begin
  CheckConfigured;
  Result := BaseWebDataAccess.GetFDQuery(sql);
end;

class function TBaseWebRepository.GetSP<T>: T;
begin
  CheckConfigured;
  Result := T(BaseWebDataAccess.GetSP(T));
end;

{ --------------------------------------------------------- }
{ Helper lettura da TFDQuery }
{ --------------------------------------------------------- }

class function TBaseWebRepository.QStr(QR: TFDQuery; const Field: string): string;
begin
  Result := QR.FieldByName(Field).AsString;
end;

class function TBaseWebRepository.QInt(QR: TFDQuery; const Field: string; Default: Integer): Integer;
begin
  if QR.FieldByName(Field).IsNull then
    Result := Default
  else
    Result := QR.FieldByName(Field).AsInteger;
end;

class function TBaseWebRepository.QBool(QR: TFDQuery; const Field: string; Default: Boolean): Boolean;
var
  F: TField;
begin
  F := QR.FieldByName(Field);
  if F.IsNull then
    Result := Default
  else
    Result := F.AsBoolean;
end;

class function TBaseWebRepository.QMemo(QR: TFDQuery; const Field: string): string;
begin
  Result := QR.FieldByName(Field).AsString;
end;

class procedure TBaseWebRepository.SetParam(QR: TFDQuery; const ParamName: string; const V: string);
begin
  if V <> '' then
    QR.ParamByName(ParamName).AsString := V;
end;

class procedure TBaseWebRepository.SetSPStr(SP: TzStoredProc; const ParamName: string; const V: string);
begin
  if V.Trim <> '' then
    SP.SetParamValue(ParamName, V, false)
  else
    SP.SetParamValue(ParamName, '', true);
end;

{ --------------------------------------------------------- }
{ Fill interni da TFDQuery }
{ --------------------------------------------------------- }

class procedure TBaseWebRepository.FillDataset(DS: TBaseWebDataset; QR: TFDQuery);
begin
  DS.Dataset := QStr(QR, 'DATASET');
  DS.DM := QStr(QR, 'DM');
  DS.Name := QStr(QR, 'NAME');
  DS.PkFields := QStr(QR, 'PK_FIELDS');
  DS.RelationName := QStr(QR, 'RELATION_NAME');
  DS.SequenceName := QStr(QR, 'SEQUENCE_NAME');
  DS.CanInsert := QBool(QR, 'CAN_INSERT');
  DS.CanUpdate := QBool(QR, 'CAN_UPDATE');
  DS.CanDelete := QBool(QR, 'CAN_DELETE');
  DS.SqlSelect := QMemo(QR, 'SQL_SELECT');
  DS.SqlCount := QMemo(QR, 'SQL_COUNT');
  DS.SqlInsert := QMemo(QR, 'SQL_INSERT');
  DS.SqlUpdate := QMemo(QR, 'SQL_UPDATE');
  DS.SqlDelete := QMemo(QR, 'SQL_DELETE');
  DS.Note := QMemo(QR, 'NOTE');
  DS.Caption := QStr(QR, 'CAPTION');
  DS.GridAllowView := QBool(QR, 'GRID_ALLOW_VIEW', true);
  DS.GridEditMode := QStr(QR, 'GRID_EDIT_MODE');
  DS.GridUseFormEdit := QBool(QR, 'GRID_USE_FORM_EDIT');
  DS.GridConfirmDelete := QBool(QR, 'GRID_CONFIRM_DELETE', true);
  DS.GridSelectionMode := QStr(QR, 'GRID_SELECTION_MODE');
  DS.GridSelectionCheckbox := QStr(QR, 'GRID_SELECTION_CHECKBOX');
  DS.GridSelectionSelectAll := QStr(QR, 'GRID_SELECTION_SELECTALL');
  DS.GridExportEnabled := QBool(QR, 'GRID_EXPORT_ENABLED', true);
  DS.GridExportSelected := QBool(QR, 'GRID_EXPORT_SELECTED', true);
  DS.GridExportFileName := QStr(QR, 'GRID_EXPORT_FILENAME');
  DS.GridExportFormats := QStr(QR, 'GRID_EXPORT_FORMATS');
  DS.GridPageSize := QInt(QR, 'GRID_PAGE_SIZE', 25);
  DS.GridPageSizes := QStr(QR, 'GRID_PAGE_SIZES');
  DS.FormColCount := QInt(QR, 'FORM_COL_COUNT', 2);
  DS.FormLabelLoc := QStr(QR, 'FORM_LABEL_LOC');
  DS.FormLabelColon := QBool(QR, 'FORM_LABEL_COLON', true);
  DS.FormLayout := QStr(QR, 'FORM_LAYOUT');
  DS.FormWidth := QInt(QR, 'FORM_WIDTH');
  DS.FormHeight := QInt(QR, 'FORM_HEIGHT');
end;

{ --------------------------------------------------------- }
{ DATASETS }
{ --------------------------------------------------------- }

class procedure TBaseWebRepository.LoadDatasets(List: TObjectList<TBaseWebDataset>; const DatasetID: string);
var
  QR: TFDQuery;
  DS: TBaseWebDataset;
begin
  QR := GetFDQuery('SELECT * FROM BASE_WEB_TABLE_IO.BASE_WEB_DATASETS_LOAD(:PARAM_DATASET)');
  try
    SetParam(QR, 'PARAM_DATASET', DatasetID);
    QR.Open;
    while not QR.Eof do
    begin
      DS := TBaseWebDataset.Create;
      FillDataset(DS, QR);
      List.Add(DS);
      QR.Next;
    end;
  finally
    QR.Free;
  end;
end;

class procedure TBaseWebRepository.SaveDataset(DS: TBaseWebDataset);
var
  SP: TSP_base_Web_Table_Io__Base_Web_Datasets_Save;
begin
  SP := GetSP<TSP_base_Web_Table_Io__Base_Web_Datasets_Save>;
  try
    SP.Dataset := DS.Dataset;
    SP.Pk_Fields := DS.PkFields;
    SP.Relation_Name := DS.RelationName;
    SetSPStr(SP, 'SEQUENCE_NAME', DS.SequenceName);
    SP.Can_Insert := DS.CanInsert;
    SP.Can_Update := DS.CanUpdate;
    SP.Can_Delete := DS.CanDelete;
    SP.Sql_Select.Text := DS.SqlSelect;
    SP.Sql_Count.Text := DS.SqlCount;
    SP.Sql_Insert.Text := DS.SqlInsert;
    SP.Sql_Update.Text := DS.SqlUpdate;
    SP.Sql_Delete.Text := DS.SqlDelete;
    SP.Note.Text := DS.Note;
    SetSPStr(SP, 'CAPTION', DS.Caption);
    SP.Grid_Allow_View := DS.GridAllowView;
    SP.Grid_Edit_Mode := DS.GridEditMode;
    SP.Grid_Use_Form_Edit := DS.GridUseFormEdit;
    SP.Grid_Confirm_Delete := DS.GridConfirmDelete;
    SP.Grid_Selection_Mode := DS.GridSelectionMode;
    SP.Grid_Selection_Checkbox := DS.GridSelectionCheckbox;
    SP.Grid_Selection_Selectall := DS.GridSelectionSelectAll;
    SP.Grid_Export_Enabled := DS.GridExportEnabled;
    SP.Grid_Export_Selected := DS.GridExportSelected;
    SetSPStr(SP, 'GRID_EXPORT_FILENAME', DS.GridExportFileName);
    SP.Grid_Export_Formats := DS.GridExportFormats;
    SP.Grid_Page_Size := DS.GridPageSize;
    SP.Grid_Page_Sizes := DS.GridPageSizes;
    SP.Form_Col_Count := DS.FormColCount;
    SP.Form_Label_Loc := DS.FormLabelLoc;
    SP.Form_Label_Colon := DS.FormLabelColon;
    SP.Form_Layout := DS.FormLayout;
    SP.Form_Width := DS.FormWidth;
    SP.Form_Height := DS.FormHeight;
    SP.ExecuteAndCommit;
  finally
    SP.Free;
  end;
end;

{ --------------------------------------------------------- }
{ FIELDS }
{ --------------------------------------------------------- }

class procedure TBaseWebRepository.LoadFields(List: TObjectList<TBaseWebDatasetField>; const DatasetID: string; const Field: string);
var
  QR: TFDQuery;
  F: TBaseWebDatasetField;
begin
  QR := GetFDQuery('SELECT * FROM BASE_WEB_TABLE_IO.BASE_WEB_DATASETS_FIELDS_LOAD(:PARAM_DATASET, :PARAM_FIELD)');
  try
    SetParam(QR, 'PARAM_DATASET', DatasetID);
    SetParam(QR, 'PARAM_FIELD', Field);
    QR.Open;
    while not QR.Eof do
    begin
      F := TBaseWebDatasetField.Create;
      F.Dataset := QStr(QR, 'DATASET');
      F.Field := QStr(QR, 'FIELD');
      F.FieldOrigin := QStr(QR, 'FIELD_ORIGIN');
      F.Caption := QStr(QR, 'CAPTION');
      F.Required := QBool(QR, 'REQUIRED');
      F.Readonly := QBool(QR, 'READONLY');
      F.Fields2Clear := QStr(QR, 'FIELDS_2_CLEAR');
      F.EditorType := QStr(QR, 'EDITOR_TYPE');
      F.Picklist := QStr(QR, 'PICKLIST');
      F.Lookup := QStr(QR, 'LOOKUP');
      F.FormPlaceholder := QStr(QR, 'FORM_PLACEHOLDER');
      F.FormHelpText := QStr(QR, 'FORM_HELP_TEXT');
      F.EditorOptions := QMemo(QR, 'EDITOR_OPTIONS');
      F.Validation := QMemo(QR, 'VALIDATION');
      F.DependsOn := QMemo(QR, 'DEPENDS_ON');
      List.Add(F);
      QR.Next;
    end;
  finally
    QR.Free;
  end;
end;

class procedure TBaseWebRepository.SaveField(F: TBaseWebDatasetField);
var
  SP: TSP_base_Web_Table_Io__Base_Web_Datasets_Fields_Save;
begin
  SP := GetSP<TSP_base_Web_Table_Io__Base_Web_Datasets_Fields_Save>;
  try
    SP.Dataset := F.Dataset;
    SP.Field := F.Field;
    SetSPStr(SP, 'FIELD_ORIGIN', F.FieldOrigin);
    SetSPStr(SP, 'CAPTION', F.Caption);
    SP.Required := F.Required;
    SP.Readonly := F.Readonly;
    SetSPStr(SP, 'FIELDS_2_CLEAR', F.Fields2Clear);
    SetSPStr(SP, 'EDITOR_TYPE', F.EditorType);
    SetSPStr(SP, 'PICKLIST', F.Picklist);
    SetSPStr(SP, 'LOOKUP', F.Lookup);
    SetSPStr(SP, 'FORM_PLACEHOLDER', F.FormPlaceholder);
    SetSPStr(SP, 'FORM_HELP_TEXT', F.FormHelpText);
    SetSPStr(SP, 'EDITOR_OPTIONS', F.EditorOptions);
    SetSPStr(SP, 'VALIDATION', F.Validation);
    SetSPStr(SP, 'DEPENDS_ON', F.DependsOn);
    SP.ExecuteAndCommit;
  finally
    SP.Free;
  end;
end;

{ --------------------------------------------------------- }
{ FORM TABBED }
{ --------------------------------------------------------- }

class procedure TBaseWebRepository.LoadFormTabbed(List: TObjectList<TBaseWebFormTabbed>; const DatasetID: string; const TabbedName: string);
var
  QR: TFDQuery;
  T: TBaseWebFormTabbed;
begin
  QR := GetFDQuery('SELECT * FROM BASE_WEB_TABLE_IO.BASE_WEB_FORM_TABBED_LOAD(:PARAM_DATASET, :PARAM_TABBED_NAME)');
  try
    SetParam(QR, 'PARAM_DATASET', DatasetID);
    SetParam(QR, 'PARAM_TABBED_NAME', TabbedName);
    QR.Open;
    while not QR.Eof do
    begin
      T := TBaseWebFormTabbed.Create;
      T.Dataset := QStr(QR, 'DATASET');
      T.TabbedName := QStr(QR, 'TABBED_NAME');
      // campi CONTAINER (trasparenti dalla _LOAD)
      T.ParentContainerName := QStr(QR, 'PARENT_CONTAINER_NAME');
      T.ParentContainerType := QStr(QR, 'PARENT_CONTAINER_TYPE');
      T.SortOrder := QInt(QR, 'SORT_ORDER');
      T.Visible := QBool(QR, 'VISIBLE', true);
      T.Caption := QStr(QR, 'CAPTION');
      T.ColSpan := QInt(QR, 'COL_SPAN');
      T.CssClass := QStr(QR, 'CSS_CLASS');
      // campi specifici TABBED
      T.AnimationEnabled := QBool(QR, 'ANIMATION_ENABLED', true);
      T.SwipeEnabled := QBool(QR, 'SWIPE_ENABLED', true);
      T.Loop := QBool(QR, 'LOOP');
      T.DeferRendering := QBool(QR, 'DEFER_RENDERING', true);
      T.TabsPosition := QStr(QR, 'TABS_POSITION');
      T.StylingMode := QStr(QR, 'STYLING_MODE');
      T.ScrollingEnabled := QBool(QR, 'SCROLLING_ENABLED', true);
      T.ShowNavButtons := QBool(QR, 'SHOW_NAV_BUTTONS');
      T.IconPosition := QStr(QR, 'ICON_POSITION');
      T.SelectedIndex := QInt(QR, 'SELECTED_INDEX');
      T.Height := QInt(QR, 'HEIGHT');
      T.TabPanelOptions := QMemo(QR, 'TAB_PANEL_OPTIONS');
      List.Add(T);
      QR.Next;
    end;
  finally
    QR.Free;
  end;
end;

class procedure TBaseWebRepository.SaveFormTabbed(T: TBaseWebFormTabbed);
var
  SP: TSP_base_Web_Table_Io__Base_Web_Form_Tabbed_Save;
begin
  SP := GetSP<TSP_base_Web_Table_Io__Base_Web_Form_Tabbed_Save>;
  try
    SP.Dataset := T.Dataset;
    SP.Tabbed_Name := T.TabbedName;
    // campi CONTAINER
    SetSPStr(SP, 'PARENT_CONTAINER_NAME', T.ParentContainerName);
    SetSPStr(SP, 'PARENT_CONTAINER_TYPE', T.ParentContainerType);
    SP.Sort_Order := T.SortOrder;
    SP.Visible := T.Visible;
    SetSPStr(SP, 'CAPTION', T.Caption);
    SP.Col_Span := T.ColSpan;
    SetSPStr(SP, 'CSS_CLASS', T.CssClass);
    // campi specifici
    SP.Animation_Enabled := T.AnimationEnabled;
    SP.Swipe_Enabled := T.SwipeEnabled;
    SP.Loop := T.Loop;
    SP.Defer_Rendering := T.DeferRendering;
    SetSPStr(SP, 'TABS_POSITION', T.TabsPosition);
    SetSPStr(SP, 'STYLING_MODE', T.StylingMode);
    SP.Scrolling_Enabled := T.ScrollingEnabled;
    SP.Show_Nav_Buttons := T.ShowNavButtons;
    SetSPStr(SP, 'ICON_POSITION', T.IconPosition);
    SP.Selected_Index := T.SelectedIndex;
    SP.Height := T.Height;
    SetSPStr(SP, 'TAB_PANEL_OPTIONS', T.TabPanelOptions);
    SP.ExecuteAndCommit;
  finally
    SP.Free;
  end;
end;

{ --------------------------------------------------------- }
{ FORM TABS }
{ --------------------------------------------------------- }

class procedure TBaseWebRepository.LoadFormTabs(List: TObjectList<TBaseWebFormTab>; const DatasetID: string; const TabName: string);
var
  QR: TFDQuery;
  T: TBaseWebFormTab;
begin
  QR := GetFDQuery('SELECT * FROM BASE_WEB_TABLE_IO.BASE_WEB_FORM_TABS_LOAD(:PARAM_DATASET, :PARAM_TAB_NAME)');
  try
    SetParam(QR, 'PARAM_DATASET', DatasetID);
    SetParam(QR, 'PARAM_TAB_NAME', TabName);
    QR.Open;
    while not QR.Eof do
    begin
      T := TBaseWebFormTab.Create;
      T.Dataset := QStr(QR, 'DATASET');
      T.TabName := QStr(QR, 'TAB_NAME');
      T.TabbedName := QStr(QR, 'TABBED_NAME');
      // campi CONTAINER (trasparenti)
      T.ParentContainerName := QStr(QR, 'PARENT_CONTAINER_NAME');
      T.ParentContainerType := QStr(QR, 'PARENT_CONTAINER_TYPE');
      T.SortOrder := QInt(QR, 'SORT_ORDER');
      T.Visible := QBool(QR, 'VISIBLE', true);
      T.Caption := QStr(QR, 'CAPTION');
      T.ColSpan := QInt(QR, 'COL_SPAN');
      T.CssClass := QStr(QR, 'CSS_CLASS');
      // campi specifici TABS
      T.ColCount := QInt(QR, 'COL_COUNT', 2);
      T.Disabled := QBool(QR, 'DISABLED');
      T.Icon := QStr(QR, 'ICON');
      T.Badge := QStr(QR, 'BADGE');
      T.AlignItemLabels := QBool(QR, 'ALIGN_ITEM_LABELS', true);
      List.Add(T);
      QR.Next;
    end;
  finally
    QR.Free;
  end;
end;

class procedure TBaseWebRepository.SaveFormTab(T: TBaseWebFormTab);
var
  SP: TSP_base_Web_Table_Io__Base_Web_Form_Tabs_Save;
begin
  SP := GetSP<TSP_base_Web_Table_Io__Base_Web_Form_Tabs_Save>;
  try
    SP.Dataset := T.Dataset;
    SP.Tab_Name := T.TabName;
    SP.Tabbed_Name := T.TabbedName;
    // campi CONTAINER
    SetSPStr(SP, 'PARENT_CONTAINER_NAME', T.ParentContainerName);
    SetSPStr(SP, 'PARENT_CONTAINER_TYPE', T.ParentContainerType);
    SP.Sort_Order := T.SortOrder;
    SP.Visible := T.Visible;
    SetSPStr(SP, 'CAPTION', T.Caption);
    SP.Col_Span := T.ColSpan;
    SetSPStr(SP, 'CSS_CLASS', T.CssClass);
    // campi specifici
    SP.Col_Count := T.ColCount;
    SP.Disabled := T.Disabled;
    SetSPStr(SP, 'ICON', T.Icon);
    SetSPStr(SP, 'BADGE', T.Badge);
    SP.Align_Item_Labels := T.AlignItemLabels;
    SP.ExecuteAndCommit;
  finally
    SP.Free;
  end;
end;

{ --------------------------------------------------------- }
{ FORM GROUPS }
{ --------------------------------------------------------- }

class procedure TBaseWebRepository.LoadFormGroups(List: TObjectList<TBaseWebFormGroup>; const DatasetID: string; const GroupName: string);
var
  QR: TFDQuery;
  G: TBaseWebFormGroup;
begin
  QR := GetFDQuery('SELECT * FROM BASE_WEB_TABLE_IO.BASE_WEB_FORM_GROUPS_LOAD(:PARAM_DATASET, :PARAM_GROUP_NAME)');
  try
    SetParam(QR, 'PARAM_DATASET', DatasetID);
    SetParam(QR, 'PARAM_GROUP_NAME', GroupName);
    QR.Open;
    while not QR.Eof do
    begin
      G := TBaseWebFormGroup.Create;
      G.Dataset := QStr(QR, 'DATASET');
      G.GroupName := QStr(QR, 'GROUP_NAME');
      // campi CONTAINER (trasparenti)
      G.ParentContainerName := QStr(QR, 'PARENT_CONTAINER_NAME');
      G.ParentContainerType := QStr(QR, 'PARENT_CONTAINER_TYPE');
      G.SortOrder := QInt(QR, 'SORT_ORDER');
      G.Visible := QBool(QR, 'VISIBLE', true);
      G.Caption := QStr(QR, 'CAPTION');
      G.ColSpan := QInt(QR, 'COL_SPAN');
      G.CssClass := QStr(QR, 'CSS_CLASS');
      // campo specifico
      G.ColCount := QInt(QR, 'COL_COUNT', 2);
      List.Add(G);
      QR.Next;
    end;
  finally
    QR.Free;
  end;
end;

class procedure TBaseWebRepository.SaveFormGroup(G: TBaseWebFormGroup);
var
  SP: TSP_base_Web_Table_Io__Base_Web_Form_Groups_Save;
begin
  SP := GetSP<TSP_base_Web_Table_Io__Base_Web_Form_Groups_Save>;
  try
    SP.Dataset := G.Dataset;
    SP.Group_Name := G.GroupName;
    // campi CONTAINER
    SetSPStr(SP, 'PARENT_CONTAINER_NAME', G.ParentContainerName);
    SetSPStr(SP, 'PARENT_CONTAINER_TYPE', G.ParentContainerType);
    SP.Sort_Order := G.SortOrder;
    SP.Visible := G.Visible;
    SetSPStr(SP, 'CAPTION', G.Caption);
    SP.Col_Span := G.ColSpan;
    SetSPStr(SP, 'CSS_CLASS', G.CssClass);
    // specifico
    SP.Col_Count := G.ColCount;
    SP.ExecuteAndCommit;
  finally
    SP.Free;
  end;
end;

{ --------------------------------------------------------- }
{ FORM FIELDS }
{ --------------------------------------------------------- }

class procedure TBaseWebRepository.LoadFormFields(List: TObjectList<TBaseWebFormField>; const DatasetID: string; const FieldName: string);
var
  QR: TFDQuery;
  FF: TBaseWebFormField;
begin
  QR := GetFDQuery('SELECT * FROM BASE_WEB_TABLE_IO.BASE_WEB_FORM_FIELDS_LOAD(:PARAM_DATASET, :PARAM_FIELD)');
  try
    SetParam(QR, 'PARAM_DATASET', DatasetID);
    SetParam(QR, 'PARAM_FIELD', FieldName);
    QR.Open;
    while not QR.Eof do
    begin
      FF := TBaseWebFormField.Create;
      FF.Dataset := QStr(QR, 'DATASET');
      FF.Field := QStr(QR, 'FIELD');
      FF.ContainerName := QStr(QR, 'CONTAINER_NAME');
      FF.ContainerType := QStr(QR, 'CONTAINER_TYPE');
      FF.SortOrder := QInt(QR, 'SORT_ORDER');
      FF.Visible := QBool(QR, 'VISIBLE', true);
      FF.LabelText := QStr(QR, 'LABEL_TEXT');
      FF.ColSpan := QInt(QR, 'COL_SPAN');
      FF.Linebreak := QBool(QR, 'LINEBREAK');
      FF.Placeholder := QStr(QR, 'PLACEHOLDER');
      FF.HelpText := QStr(QR, 'HELP_TEXT');
      FF.CssClass := QStr(QR, 'CSS_CLASS');
      FF.Required := QBool(QR, 'REQUIRED');
      FF.EditorOptions := QMemo(QR, 'EDITOR_OPTIONS');
      List.Add(FF);
      QR.Next;
    end;
  finally
    QR.Free;
  end;
end;

class procedure TBaseWebRepository.SaveFormField(FF: TBaseWebFormField);
var
  SP: TSP_base_Web_Table_Io__Base_Web_Form_Fields_Save;
begin
  SP := GetSP<TSP_base_Web_Table_Io__Base_Web_Form_Fields_Save>;
  try
    SP.Dataset := FF.Dataset;
    SP.Field := FF.Field;
    SetSPStr(SP, 'CONTAINER_NAME', FF.ContainerName);
    SetSPStr(SP, 'CONTAINER_TYPE', FF.ContainerType);
    SP.Sort_Order := FF.SortOrder;
    SP.Visible := FF.Visible;
    SetSPStr(SP, 'LABEL_TEXT', FF.LabelText);
    SP.Col_Span := FF.ColSpan;
    SP.Linebreak := FF.Linebreak;
    SetSPStr(SP, 'PLACEHOLDER', FF.Placeholder);
    SetSPStr(SP, 'HELP_TEXT', FF.HelpText);
    SetSPStr(SP, 'CSS_CLASS', FF.CssClass);
    SP.Required := FF.Required;
    SetSPStr(SP, 'EDITOR_OPTIONS', FF.EditorOptions);
    SP.ExecuteAndCommit;
  finally
    SP.Free;
  end;
end;

{ --------------------------------------------------------- }
{ FORM BUTTONS }
{ --------------------------------------------------------- }

class procedure TBaseWebRepository.LoadFormButtons(List: TObjectList<TBaseWebFormButton>; const DatasetID: string; const ButtonName: string);
var
  QR: TFDQuery;
  B: TBaseWebFormButton;
begin
  QR := GetFDQuery('SELECT * FROM BASE_WEB_TABLE_IO.BASE_WEB_FORM_BUTTONS_LOAD(:PARAM_DATASET, :PARAM_BUTTON_NAME)');
  try
    SetParam(QR, 'PARAM_DATASET', DatasetID);
    SetParam(QR, 'PARAM_BUTTON_NAME', ButtonName);
    QR.Open;
    while not QR.Eof do
    begin
      B := TBaseWebFormButton.Create;
      B.Dataset := QStr(QR, 'DATASET');
      B.ButtonName := QStr(QR, 'BUTTON_NAME');
      B.ContainerName := QStr(QR, 'CONTAINER_NAME');
      B.ContainerType := QStr(QR, 'CONTAINER_TYPE');
      B.SortOrder := QInt(QR, 'SORT_ORDER');
      B.Visible := QBool(QR, 'VISIBLE', true);
      B.ColSpan := QInt(QR, 'COL_SPAN');
      B.BtnText := QStr(QR, 'BTN_TEXT');
      B.BtnType := QStr(QR, 'BTN_TYPE');
      B.BtnIcon := QStr(QR, 'BTN_ICON');
      B.BtnAction := QStr(QR, 'BTN_ACTION');
      B.BtnHorizontalAlign := QStr(QR, 'BTN_HORIZONTAL_ALIGN');
      B.BtnIconPosition := QStr(QR, 'BTN_ICON_POSITION');
      B.BtnDisabled := QBool(QR, 'BTN_DISABLED');
      B.BtnStylingMode := QStr(QR, 'BTN_STYLING_MODE');
      B.CssClass := QStr(QR, 'CSS_CLASS');
      List.Add(B);
      QR.Next;
    end;
  finally
    QR.Free;
  end;
end;

class procedure TBaseWebRepository.SaveFormButton(B: TBaseWebFormButton);
var
  SP: TSP_base_Web_Table_Io__Base_Web_Form_Buttons_Save;
begin
  SP := GetSP<TSP_base_Web_Table_Io__Base_Web_Form_Buttons_Save>;
  try
    SP.Dataset := B.Dataset;
    SP.Button_Name := B.ButtonName;
    SetSPStr(SP, 'CONTAINER_NAME', B.ContainerName);
    SetSPStr(SP, 'CONTAINER_TYPE', B.ContainerType);
    SP.Sort_Order := B.SortOrder;
    SP.Visible := B.Visible;
    SP.Col_Span := B.ColSpan;
    SetSPStr(SP, 'BTN_TEXT', B.BtnText);
    SetSPStr(SP, 'BTN_TYPE', B.BtnType);
    SetSPStr(SP, 'BTN_ICON', B.BtnIcon);
    SP.Btn_Action := B.BtnAction;
    SetSPStr(SP, 'BTN_HORIZONTAL_ALIGN', B.BtnHorizontalAlign);
    SetSPStr(SP, 'BTN_ICON_POSITION', B.BtnIconPosition);
    SP.Btn_Disabled := B.BtnDisabled;
    SetSPStr(SP, 'BTN_STYLING_MODE', B.BtnStylingMode);
    SetSPStr(SP, 'CSS_CLASS', B.CssClass);
    SP.ExecuteAndCommit;
  finally
    SP.Free;
  end;
end;

{ --------------------------------------------------------- }
{ FORM EMPTY }
{ --------------------------------------------------------- }

class procedure TBaseWebRepository.LoadFormEmpty(List: TObjectList<TBaseWebFormEmpty>; const DatasetID: string; const EmptyName: string);
var
  QR: TFDQuery;
  E: TBaseWebFormEmpty;
begin
  QR := GetFDQuery('SELECT * FROM BASE_WEB_TABLE_IO.BASE_WEB_FORM_EMPTY_LOAD(:PARAM_DATASET, :PARAM_EMPTY_NAME)');
  try
    SetParam(QR, 'PARAM_DATASET', DatasetID);
    SetParam(QR, 'PARAM_EMPTY_NAME', EmptyName);
    QR.Open;
    while not QR.Eof do
    begin
      E := TBaseWebFormEmpty.Create;
      E.Dataset := QStr(QR, 'DATASET');
      E.EmptyName := QStr(QR, 'EMPTY_NAME');
      E.ContainerName := QStr(QR, 'CONTAINER_NAME');
      E.ContainerType := QStr(QR, 'CONTAINER_TYPE');
      E.SortOrder := QInt(QR, 'SORT_ORDER');
      E.Visible := QBool(QR, 'VISIBLE', true);
      E.ColSpan := QInt(QR, 'COL_SPAN', 1);
      List.Add(E);
      QR.Next;
    end;
  finally
    QR.Free;
  end;
end;

class procedure TBaseWebRepository.SaveFormEmpty(E: TBaseWebFormEmpty);
var
  SP: TSP_base_Web_Table_Io__Base_Web_Form_Empty_Save;
begin
  SP := GetSP<TSP_base_Web_Table_Io__Base_Web_Form_Empty_Save>;
  try
    SP.Dataset := E.Dataset;
    SP.Empty_Name := E.EmptyName;
    SetSPStr(SP, 'CONTAINER_NAME', E.ContainerName);
    SetSPStr(SP, 'CONTAINER_TYPE', E.ContainerType);
    SP.Sort_Order := E.SortOrder;
    SP.Visible := E.Visible;
    SP.Col_Span := E.ColSpan;
    SP.ExecuteAndCommit;
  finally
    SP.Free;
  end;
end;

{ --------------------------------------------------------- }
{ GRID BANDS }
{ --------------------------------------------------------- }

class procedure TBaseWebRepository.LoadGridBands(List: TObjectList<TBaseWebGridBand>; const DatasetID: string; const BandName: string);
var
  QR: TFDQuery;
  B: TBaseWebGridBand;
begin
  QR := GetFDQuery('SELECT * FROM BASE_WEB_TABLE_IO.BASE_WEB_GRID_BANDS_LOAD(:PARAM_DATASET, :PARAM_BAND_NAME)');
  try
    SetParam(QR, 'PARAM_DATASET', DatasetID);
    SetParam(QR, 'PARAM_BAND_NAME', BandName);
    QR.Open;
    while not QR.Eof do
    begin
      B := TBaseWebGridBand.Create;
      B.Dataset := QStr(QR, 'DATASET');
      B.BandName := QStr(QR, 'BAND_NAME');
      B.ParentBand := QStr(QR, 'PARENT_BAND');
      B.Caption := QStr(QR, 'CAPTION');
      B.SortOrder := QInt(QR, 'SORT_ORDER');
      B.Visible := QBool(QR, 'VISIBLE', true);
      B.Alignment := QStr(QR, 'ALIGNMENT');
      B.CssClass := QStr(QR, 'CSS_CLASS');
      List.Add(B);
      QR.Next;
    end;
  finally
    QR.Free;
  end;
end;

class procedure TBaseWebRepository.SaveGridBand(B: TBaseWebGridBand);
var
  SP: TSP_base_Web_Table_Io__Base_Web_Grid_Bands_Save;
begin
  SP := GetSP<TSP_base_Web_Table_Io__Base_Web_Grid_Bands_Save>;
  try
    SP.Dataset := B.Dataset;
    SP.Band_Name := B.BandName;
    SetSPStr(SP, 'PARENT_BAND', B.ParentBand);
    SP.Caption := B.Caption;
    SP.Sort_Order := B.SortOrder;
    SP.Visible := B.Visible;
    SetSPStr(SP, 'ALIGNMENT', B.Alignment);
    SetSPStr(SP, 'CSS_CLASS', B.CssClass);
    SP.ExecuteAndCommit;
  finally
    SP.Free;
  end;
end;

{ --------------------------------------------------------- }
{ GRID COLUMNS }
{ --------------------------------------------------------- }

class procedure TBaseWebRepository.LoadGridColumns(List: TObjectList<TBaseWebGridColumn>; const DatasetID: string; const FieldName: string);
var
  QR: TFDQuery;
  C: TBaseWebGridColumn;
begin
  QR := GetFDQuery('SELECT * FROM BASE_WEB_TABLE_IO.BASE_WEB_GRID_COLUMNS_LOAD(:PARAM_DATASET, :PARAM_FIELD)');
  try
    SetParam(QR, 'PARAM_DATASET', DatasetID);
    SetParam(QR, 'PARAM_FIELD', FieldName);
    QR.Open;
    while not QR.Eof do
    begin
      C := TBaseWebGridColumn.Create;
      C.Dataset := QStr(QR, 'DATASET');
      C.Field := QStr(QR, 'FIELD');
      C.Caption := QStr(QR, 'CAPTION');
      C.DataType := QStr(QR, 'DATA_TYPE');
      C.BandName := QStr(QR, 'BAND_NAME');
      C.SortOrder := QInt(QR, 'SORT_ORDER');
      C.Fixed := QBool(QR, 'FIXED');
      C.FixedPosition := QStr(QR, 'FIXED_POSITION');
      C.Visible := QBool(QR, 'VISIBLE', true);
      C.Width := QInt(QR, 'WIDTH');
      C.MinWidth := QInt(QR, 'MIN_WIDTH');
      C.Alignment := QStr(QR, 'ALIGNMENT');
      C.FormatStr := QStr(QR, 'FORMAT_STR');
      C.GroupIndex := QInt(QR, 'GROUP_INDEX');
      C.SummaryType := QStr(QR, 'SUMMARY_TYPE');
      C.AllowFilter := QBool(QR, 'ALLOW_FILTER', true);
      C.AllowSort := QBool(QR, 'ALLOW_SORT', true);
      C.AllowGroup := QBool(QR, 'ALLOW_GROUP');
      C.AllowResize := QBool(QR, 'ALLOW_RESIZE', true);
      C.AllowReorder := QBool(QR, 'ALLOW_REORDER', true);
      C.AllowHiding := QBool(QR, 'ALLOW_HIDING', true);
      C.HeaderFilter := QBool(QR, 'HEADER_FILTER');
      C.WordWrap := QBool(QR, 'WORD_WRAP');
      C.EncodeHtml := QBool(QR, 'ENCODE_HTML', true);
      C.CssClass := QStr(QR, 'CSS_CLASS');
      List.Add(C);
      QR.Next;
    end;
  finally
    QR.Free;
  end;
end;

class procedure TBaseWebRepository.SaveGridColumn(C: TBaseWebGridColumn);
var
  SP: TSP_base_Web_Table_Io__Base_Web_Grid_Columns_Save;
begin
  SP := GetSP<TSP_base_Web_Table_Io__Base_Web_Grid_Columns_Save>;
  try
    SP.Dataset := C.Dataset;
    SP.Field := C.Field;
    SetSPStr(SP, 'CAPTION', C.Caption);
    SetSPStr(SP, 'DATA_TYPE', C.DataType);
    SetSPStr(SP, 'BAND_NAME', C.BandName);
    SP.Sort_Order := C.SortOrder;
    SP.Fixed := C.Fixed;
    SetSPStr(SP, 'FIXED_POSITION', C.FixedPosition);
    SP.Visible := C.Visible;
    SP.Width := C.Width;
    SP.Min_Width := C.MinWidth;
    SetSPStr(SP, 'ALIGNMENT', C.Alignment);
    SetSPStr(SP, 'FORMAT_STR', C.FormatStr);
    SP.Group_Index := C.GroupIndex;
    SetSPStr(SP, 'SUMMARY_TYPE', C.SummaryType);
    SP.Allow_Filter := C.AllowFilter;
    SP.Allow_Sort := C.AllowSort;
    SP.Allow_Group := C.AllowGroup;
    SP.Allow_Resize := C.AllowResize;
    SP.Allow_Reorder := C.AllowReorder;
    SP.Allow_Hiding := C.AllowHiding;
    SP.Header_Filter := C.HeaderFilter;
    SP.Word_Wrap := C.WordWrap;
    SP.Encode_Html := C.EncodeHtml;
    SetSPStr(SP, 'CSS_CLASS', C.CssClass);
    SP.ExecuteAndCommit;
  finally
    SP.Free;
  end;
end;

{ --------------------------------------------------------- }
{ LOOKUPS }
{ --------------------------------------------------------- }

class procedure TBaseWebRepository.LoadLookups(List: TObjectList<TBaseWebLookup>; const LookupID: string);
var
  QR: TFDQuery;
  L: TBaseWebLookup;
begin
  QR := GetFDQuery('SELECT * FROM BASE_WEB_TABLE_IO.BASE_WEB_LOOKUPS_LOAD(:PARAM_LOOKUP)');
  try
    SetParam(QR, 'PARAM_LOOKUP', LookupID);
    QR.Open;
    while not QR.Eof do
    begin
      L := TBaseWebLookup.Create;
      L.Lookup := QStr(QR, 'LOOKUP');
      L.Dataset := QStr(QR, 'DATASET');
      L.FkTable := QStr(QR, 'FK_TABLE');
      L.ValueExpr := QStr(QR, 'VALUE_EXPR');
      L.DisplayExpr := QStr(QR, 'DISPLAY_EXPR');
      L.Params := QMemo(QR, 'PARAMS');
      L.Mappings := QMemo(QR, 'MAPPINGS');
      L.PageSize := QInt(QR, 'PAGESIZE');
      L.DropdownWidth := QInt(QR, 'DROPDOWN_WIDTH');
      List.Add(L);
      QR.Next;
    end;
  finally
    QR.Free;
  end;
end;

class procedure TBaseWebRepository.SaveLookup(L: TBaseWebLookup);
var
  SP: TSP_base_Web_Table_Io__Base_Web_Lookups_Save;
begin
  SP := GetSP<TSP_base_Web_Table_Io__Base_Web_Lookups_Save>;
  try
    SP.Lookup := L.Lookup;
    SP.Dataset := L.Dataset;
    SP.Fk_Table := L.FkTable;
    SP.Value_Expr := L.ValueExpr;
    SP.Display_Expr := L.DisplayExpr;
    SP.Params.Text := L.Params;
    SP.Mappings.Text := L.Mappings;
    SP.PageSize := L.PageSize;
    SP.Dropdown_Width := L.DropdownWidth;
    SP.ExecuteAndCommit;
  finally
    SP.Free;
  end;
end;

class procedure TBaseWebRepository.LoadLookupColumns(List: TObjectList<TBaseWebLookupColumn>; const LookupID: string; const FieldName: string);
var
  QR: TFDQuery;
  C: TBaseWebLookupColumn;
begin
  QR := GetFDQuery('SELECT * FROM BASE_WEB_TABLE_IO.BASE_WEB_LOOKUPS_COLUMNS_LOAD(:PARAM_LOOKUP, :PARAM_FIELD)');
  try
    SetParam(QR, 'PARAM_LOOKUP', LookupID);
    SetParam(QR, 'PARAM_FIELD', FieldName);
    QR.Open;
    while not QR.Eof do
    begin
      C := TBaseWebLookupColumn.Create;
      C.Lookup := QStr(QR, 'LOOKUP');
      C.Field := QStr(QR, 'FIELD');
      C.Caption := QStr(QR, 'CAPTION');
      C.Width := QInt(QR, 'WIDTH');
      C.Alignment := QStr(QR, 'ALIGNMENT');
      List.Add(C);
      QR.Next;
    end;
  finally
    QR.Free;
  end;
end;

class procedure TBaseWebRepository.SaveLookupColumn(C: TBaseWebLookupColumn);
var
  SP: TSP_base_Web_Table_Io__Base_Web_Lookups_Columns_Save;
begin
  SP := GetSP<TSP_base_Web_Table_Io__Base_Web_Lookups_Columns_Save>;
  try
    SP.Lookup := C.Lookup;
    SP.Field := C.Field;
    SP.Caption := C.Caption;
    SP.Width := C.Width;
    SP.Alignment := C.Alignment;
    SP.ExecuteAndCommit;
  finally
    SP.Free;
  end;
end;

{ --------------------------------------------------------- }
{ PICKLISTS }
{ --------------------------------------------------------- }

class procedure TBaseWebRepository.LoadPicklists(List: TObjectList<TBaseWebPicklist>; const PicklistID: string);
var
  QR: TFDQuery;
  P: TBaseWebPicklist;
begin
  QR := GetFDQuery('SELECT * FROM BASE_WEB_TABLE_IO.BASE_WEB_PICKLISTS_LOAD(:PARAM_PICKLIST)');
  try
    SetParam(QR, 'PARAM_PICKLIST', PicklistID);
    QR.Open;
    while not QR.Eof do
    begin
      P := TBaseWebPicklist.Create;
      P.Picklist := QStr(QR, 'PICKLIST');
      P.Items := QMemo(QR, 'ITEMS');
      P.HasIcons := QBool(QR, 'HAS_ICONS');
      P.Meta := QMemo(QR, 'META');
      List.Add(P);
      QR.Next;
    end;
  finally
    QR.Free;
  end;
end;

class procedure TBaseWebRepository.SavePicklist(P: TBaseWebPicklist);
var
  SP: TSP_base_Web_Table_Io__Base_Web_Picklists_Save;
begin
  SP := GetSP<TSP_base_Web_Table_Io__Base_Web_Picklists_Save>;
  try
    SP.Picklist := P.Picklist;
    SP.Items.Text := P.Items;
    SP.Has_Icons := P.HasIcons;
    SP.Meta.Text := P.Meta;
    SP.ExecuteAndCommit;
  finally
    SP.Free;
  end;
end;

class procedure TBaseWebRepository.LoadPicklistItems(List: TObjectList<TBaseWebPicklistItem>; const PicklistID: string; const Nome: string);
var
  QR: TFDQuery;
  I: TBaseWebPicklistItem;
begin
  QR := GetFDQuery('SELECT * FROM BASE_WEB_TABLE_IO.BASE_WEB_PICKLISTS_ITEMS_LOAD(:PARAM_PICKLIST, :PARAM_NOME)');
  try
    SetParam(QR, 'PARAM_PICKLIST', PicklistID);
    SetParam(QR, 'PARAM_NOME', Nome);
    QR.Open;
    while not QR.Eof do
    begin
      I := TBaseWebPicklistItem.Create;
      I.Picklist := QStr(QR, 'PICKLIST');
      I.Nome := QStr(QR, 'NOME');
      I.Valore := QStr(QR, 'VALORE');
      I.Icona := QStr(QR, 'ICONA');
      List.Add(I);
      QR.Next;
    end;
  finally
    QR.Free;
  end;
end;

class procedure TBaseWebRepository.SavePicklistItem(I: TBaseWebPicklistItem);
var
  SP: TSP_base_Web_Table_Io__Base_Web_Picklists_Items_Save;
begin
  SP := GetSP<TSP_base_Web_Table_Io__Base_Web_Picklists_Items_Save>;
  try
    SP.Picklist := I.Picklist;
    SP.Nome := I.Nome;
    SP.Valore := I.Valore;
    SetSPStr(SP, 'ICONA', I.Icona);
    SP.ExecuteAndCommit;
  finally
    SP.Free;
  end;
end;

{ --------------------------------------------------------- }
{ STRUTTURA COMPLETA }
{ --------------------------------------------------------- }

class function TBaseWebRepository.LoadDatasetStructure(const DatasetID: string): TBaseWebDatasetStructure;
var
  DatasetList: TObjectList<TBaseWebDataset>;
begin
  DatasetList := TObjectList<TBaseWebDataset>.Create(true);
  try
    LoadDatasets(DatasetList, DatasetID);
    if DatasetList.Count = 0 then
      raise Exception.CreateFmt('Dataset "%s" non trovato.', [DatasetID]);
    Result.Dataset := DatasetList.Extract(DatasetList[0]);
  finally
    DatasetList.Free;
  end;

  Result.Fields := TObjectList<TBaseWebDatasetField>.Create(true);
  LoadFields(Result.Fields, DatasetID, '');

  Result.FormTabbed := TObjectList<TBaseWebFormTabbed>.Create(true);
  LoadFormTabbed(Result.FormTabbed, DatasetID, '');

  Result.FormTabs := TObjectList<TBaseWebFormTab>.Create(true);
  LoadFormTabs(Result.FormTabs, DatasetID, '');

  Result.FormGroups := TObjectList<TBaseWebFormGroup>.Create(true);
  LoadFormGroups(Result.FormGroups, DatasetID, '');

  Result.FormFields := TObjectList<TBaseWebFormField>.Create(true);
  LoadFormFields(Result.FormFields, DatasetID, '');

  Result.FormButtons := TObjectList<TBaseWebFormButton>.Create(true);
  LoadFormButtons(Result.FormButtons, DatasetID, '');

  Result.FormEmpty := TObjectList<TBaseWebFormEmpty>.Create(true);
  LoadFormEmpty(Result.FormEmpty, DatasetID, '');

  Result.GridBands := TObjectList<TBaseWebGridBand>.Create(true);
  LoadGridBands(Result.GridBands, DatasetID, '');

  Result.GridColumns := TObjectList<TBaseWebGridColumn>.Create(true);
  LoadGridColumns(Result.GridColumns, DatasetID, '');
end;

class procedure TBaseWebRepository.SaveDatasetStructure(const Struct: TBaseWebDatasetStructure);

  procedure DisableMetaUpdate;
  begin
    BaseWebDataAccess.ExecuteSQL('SELECT BASE_WEB.META_UPDATE_DISABLE() FROM RDB$DATABASE');
  end;

  procedure EnableMetaUpdate;
  var
    sql: string;
  begin
    if Assigned(Struct.Dataset) then
      sql := 'SELECT BASE_WEB.META_UPDATE_ENABLE(' + #39 + Struct.Dataset.Dataset + #39 + ') FROM RDB$DATABASE'
    else
      sql := 'SELECT BASE_WEB.META_UPDATE_ENABLE(NULL) FROM RDB$DATABASE';
    BaseWebDataAccess.ExecuteSQL(sql);
  end;

begin
  CheckConfigured;

  DisableMetaUpdate;
  try
    if Assigned(Struct.Dataset) and Struct.Dataset.Modified then
      SaveDataset(Struct.Dataset);

    for var F in Struct.Fields do
      if F.Modified then SaveField(F);
    for var FT in Struct.FormTabbed do
      if FT.Modified then SaveFormTabbed(FT);
    for var T in Struct.FormTabs do
      if T.Modified then SaveFormTab(T);
    for var G in Struct.FormGroups do
      if G.Modified then SaveFormGroup(G);
    for var FF in Struct.FormFields do
      if FF.Modified then SaveFormField(FF);
    for var B in Struct.FormButtons do
      if B.Modified then SaveFormButton(B);
    for var E in Struct.FormEmpty do
      if E.Modified then SaveFormEmpty(E);
    for var GB in Struct.GridBands do
      if GB.Modified then SaveGridBand(GB);
    for var GC in Struct.GridColumns do
      if GC.Modified then SaveGridColumn(GC);
  finally
    EnableMetaUpdate;
  end;
end;

initialization

BaseWebDataAccess := nil;

finalization

FreeAndNil(BaseWebDataAccess);

end.
