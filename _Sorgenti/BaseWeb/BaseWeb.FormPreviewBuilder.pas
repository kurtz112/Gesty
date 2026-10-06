unit BaseWeb.FormPreviewBuilder;

{
  Anteprima form nel designer, basata su TBaseWebDatasetStructure.

  - Lavora con TBaseWebFormTabbed / TBaseWebFormTab / TBaseWebFormGroup /
  TBaseWebFormField / TBaseWebFormButton / TBaseWebFormEmpty.
  - GROUPS/TABBED/TABS includono trasparentemente i campi CONTAINER
  (ParentContainerName, SortOrder, Visible, Caption, ColSpan, CssClass).
  - I dati di anteprima sono read-only; gli editor non possono essere editati.
  - Supporta layout flat (solo gruppi), tabbed (Tabbed -> Tab -> Group) e misti.
  - PopupMenu contestuale su editor e su area gruppo.
  - Highlight del campo selezionato nell'albero (HighlightField).
  - Metodo RefreshFromStruct per ricostruire l'intera preview.
}

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.Generics.Defaults,
  System.Types,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  dxLayoutControl,
  dxLayoutContainer,
  dxLayoutLookAndFeels,
  cxTextEdit,
  cxMemo,
  cxSpinEdit,
  cxCalendar,
  cxCheckBox,
  cxDropDownEdit,
  cxCurrencyEdit,
  cxTimeEdit,
  cxColorComboBox,
  cxMaskEdit,
  cxEdit,
  dxToggleSwitch,
  dxBar,
  BaseWeb.Models,
  BaseWeb.Consts,
  BaseWeb.Types;

type
  { Evento: l'utente ha cliccato su un editor → campo selezionato }
  TFormFieldSelectedEvent = procedure(Sender: TObject; const AFieldName: string) of object;

  { Evento: l'utente ha cliccato con il tasto destro su un editor → campo }
  TFormFieldContextEvent = procedure(Sender: TObject; const AFieldName: string; X, Y: Integer) of object;

  { Evento: clic destro sull'area di un gruppo → GroupName }
  TFormGroupContextEvent = procedure(Sender: TObject; const AGroupName: string; X, Y: Integer) of object;

  TOnContainerSelected = procedure(Sender: TObject; AContainerKind: TBaseWebNodeKind; AContainerObj: TComponent) of object;

  { ------------------------------------------------------------------ }
  { TFormPreviewBuilder2 }
  { ------------------------------------------------------------------ }
  TFormPreviewBuilder = class
  private
    FOwner: TComponent;
    FLayoutControl: TdxLayoutControl;
    FLookAndFeelHighlight: TdxCustomLayoutLookAndFeel; // assegnato dall'esterno
    FStruct: TBaseWebDatasetStructure;

    { Mappe nome→oggetto dxLayout }
    FGroupMap: TDictionary<string, TdxLayoutGroup>; // GroupName → gruppo
    FTabMap: TDictionary<string, TdxLayoutGroup>;
    FItemMap: TDictionary<string, TdxLayoutItem>; // FieldName → item

    { Lista degli editor creati (ownership = True → distrutti da ItemControls) }
    ItemControls: TObjectList<TWinControl>;
    { Lista dei controlli VCL ordinari (TButton, TPanel) per button/empty }

    { Popup menu contestuali (assegnati dall'esterno) }
    FPopupMenuField: TdxBarPopupMenu; // clic destro su campo
    FPopupMenuGroup: TdxBarPopupMenu; // clic destro su gruppo

    { Callback }
    FOnFieldSelected: TFormFieldSelectedEvent;
    FOnFieldContext: TFormFieldContextEvent;
    FOnGroupContext: TFormGroupContextEvent;
    FOnContainerSelected: TOnContainerSelected;

    { ---------- helper privati ---------- }
    procedure ClearLayout;
    function CreateEditorForType(const AEditorType: string): TcxCustomEdit;
    procedure ConfigureLabelLocation(AItem: TdxLayoutItem; const ALabelLoc: string);
    function ResolveField(const AFieldName: string): TBaseWebDatasetField;

    { Crea la gerarchia di gruppi dxLayout secondo la struttura }
    procedure BuildGroupHierarchy;

    { Popola i campi, i button-placeholder e gli empty-placeholder }
    procedure PopulateGroupContent(const AGroupName: string; ALayoutGroup: TdxLayoutGroup);

    { Crea una riga orizzontale dentro ALayoutGroup e restituisce il gruppo-riga }
    function NewRowGroup(AParent: TdxLayoutGroup): TdxLayoutGroup;

    { ---------- event handler sugli editor ---------- }
    procedure EditorMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure EditorClick(Sender: TObject);
    procedure EditorContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    { Chiamato internamente ogni volta che si crea un TdxLayoutGroup
      che rappresenta un Group, Tab o Tabbed del modello.
      Imposta Group.Tag con il puntatore al ModelObject e collega
      il click tramite l'evento disponibile nella versione DevExpress in uso. }
    procedure WireContainerClick(AGroup: TdxLayoutGroup; AKind: TBaseWebNodeKind; AModelObj: TComponent);
    procedure LayoutGroupClick(Sender: TObject);

    procedure VclControlClick(Sender: TObject);
    procedure VclControlContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
  public
    constructor Create(AOwner: TComponent; ALayoutControl: TdxLayoutControl);
    destructor Destroy; override;

    { Costruisce l'intera preview a partire dalla struttura caricata }
    procedure BuildFromStruct(const AStruct: TBaseWebDatasetStructure);

    { Ricostruisce la preview (dopo modifiche al modello) }
    procedure RefreshFromStruct;

    { Evidenzia il campo AFieldName (es. quando l'albero seleziona un nodo) }
    procedure HighlightField(const AFieldName: string);

    { Rimuove tutti gli highlight }
    procedure ClearHighlight;

    { Abilita / disabilita la modalità customization di dxLayoutControl }
    procedure EnableCustomization(AEnable: Boolean);

    { Dato un item, restituisce il FieldName associato ('' se non trovato) }
    function GetFieldNameFromItem(AItem: TdxLayoutItem): string;

    { ---- Proprietà ---- }
    property ItemMap: TDictionary<string, TdxLayoutItem> read FItemMap;
    property GroupMap: TDictionary<string, TdxLayoutGroup> read FGroupMap;
    property TabMap: TDictionary<string, TdxLayoutGroup> read FTabMap;

    property LookAndFeelHighlight: TdxCustomLayoutLookAndFeel read FLookAndFeelHighlight write FLookAndFeelHighlight;

    property PopupMenuField: TdxBarPopupMenu read FPopupMenuField write FPopupMenuField;

    property PopupMenuGroup: TdxBarPopupMenu read FPopupMenuGroup write FPopupMenuGroup;

    property OnFieldSelected: TFormFieldSelectedEvent read FOnFieldSelected write FOnFieldSelected;

    property OnFieldContext: TFormFieldContextEvent read FOnFieldContext write FOnFieldContext;

    property OnGroupContext: TFormGroupContextEvent read FOnGroupContext write FOnGroupContext;

    property OnContainerSelected: TOnContainerSelected read FOnContainerSelected write FOnContainerSelected;
  end;

implementation

uses
  System.StrUtils,
  cxRadioGroup,
  cxTrackBar,
  dxPanel,
  System.UITypes,
  cxLabel,
  cxButtons;

{ ============================================================ }
{ Costruttore / Distruttore }
{ ============================================================ }

constructor TFormPreviewBuilder.Create(AOwner: TComponent; ALayoutControl: TdxLayoutControl);
begin
  inherited Create;
  FOwner := AOwner;
  FLayoutControl := ALayoutControl;
  FGroupMap := TDictionary<string, TdxLayoutGroup>.Create;
  FTabMap := TDictionary<string, TdxLayoutGroup>.Create;
  FItemMap := TDictionary<string, TdxLayoutItem>.Create;
  ItemControls := TObjectList<TWinControl>.Create(True);
  FLookAndFeelHighlight := nil;
  FPopupMenuField := nil;
  FPopupMenuGroup := nil;
end;

destructor TFormPreviewBuilder.Destroy;
begin
  ClearLayout;
  FGroupMap.Free;
  FTabMap.Free;
  FItemMap.Free;
  ItemControls.Free;
  inherited;
end;

{ ============================================================ }
{ Pulizia }
{ ============================================================ }

procedure TFormPreviewBuilder.ClearLayout;
begin
  FGroupMap.Clear;
  FTabMap.Clear;
  FItemMap.Clear;

  FLayoutControl.BeginUpdate;
  try
    { Scollega i controlli prima di distruggerli }
    for var I := FLayoutControl.AbsoluteItemCount - 1 downto 0 do
      if FLayoutControl.AbsoluteItems[I] is TdxLayoutItem then
        TdxLayoutItem(FLayoutControl.AbsoluteItems[I]).Control := nil;
    while FLayoutControl.AbsoluteItemCount > 0 do
      FLayoutControl.AbsoluteItems[0].Free;
  finally
    FLayoutControl.EndUpdate;
  end;

  ItemControls.Clear; // gli editor sono in ownership → vengono distrutti
end;

{ ============================================================ }
{ Helper: crea un editor per tipo }
{ ============================================================ }
//
// function TFormPreviewBuilder.CreateEditorForType(const AEditorType: string): TcxCustomEdit;
// var
// ET: string;
// begin
// ET := LowerCase(AEditorType);
//
// if ET = EDITOR_TEXT then
// Result := TcxTextEdit.Create(FOwner)
// else
// if (ET = EDITOR_PASSWORD) or (ET = EDITOR_EMAIL) or (ET = EDITOR_URL) then
// Result := TcxTextEdit.Create(FOwner)
// else
// if ET = EDITOR_PHONE then
// Result := TcxMaskEdit.Create(FOwner)
// else
// if (ET = EDITOR_NUMBER) or (ET = EDITOR_PERCENT) or (ET = EDITOR_RANGE) then
// Result := TcxSpinEdit.Create(FOwner)
// else
// if ET = EDITOR_CURRENCY then
// Result := TcxCurrencyEdit.Create(FOwner)
// else
// if (ET = EDITOR_DATE) or (ET = EDITOR_DATETIME) then
// Result := TcxDateEdit.Create(FOwner)
// else
// if ET = EDITOR_TIME then
// Result := TcxTimeEdit.Create(FOwner)
// else
// if ET = EDITOR_CHECKBOX then
// Result := TcxCheckBox.Create(FOwner)
// else
// if ET = EDITOR_SWITCH then
// Result := TdxToggleSwitch.Create(FOwner)
// else
// if ET = EDITOR_TEXTAREA then
// begin
// Result := TcxMemo.Create(FOwner);
// TcxMemo(Result).Properties.ScrollBars := ssVertical;
// Result.Height := 80;
// end
// else
// if (ET = EDITOR_SELECT) or (ET = EDITOR_RADIO) or (ET = EDITOR_LOOKUP) then
// Result := TcxComboBox.Create(FOwner)
// else
// if ET = EDITOR_COLOR then
// Result := TcxColorComboBox.Create(FOwner)
// else
// Result := TcxTextEdit.Create(FOwner);
//
// { In anteprima: sola lettura }
// if Result is TcxCustomTextEdit then
// TcxCustomTextEdit(Result).Properties.ReadOnly := True;
//
// Result.OnClick := EditorClick;
// Result.OnContextPopup := EditorContextPopup;
//
// ItemControls.Add(Result);
// end;

function TFormPreviewBuilder.CreateEditorForType(const AEditorType: string): TcxCustomEdit;
var
  ET: string;
begin
  ET := LowerCase(AEditorType);

  if (ET = LowerCase(EDITOR_TEXTBOX)) or (ET = LowerCase(EDITOR_AUTOCOMPLETE)) then
    Result := TcxTextEdit.Create(FOwner)

  else
    if ET = LowerCase(EDITOR_NUMBERBOX) then
      Result := TcxSpinEdit.Create(FOwner)

    else
      if (ET = LowerCase(EDITOR_DATEBOX)) or (ET = LowerCase(EDITOR_CALENDAR)) or (ET = LowerCase(EDITOR_DATERANGEBOX)) then
        Result := TcxDateEdit.Create(FOwner)

      else
        if ET = LowerCase(EDITOR_CHECKBOX) then
          Result := TcxCheckBox.Create(FOwner)

        else
          if ET = LowerCase(EDITOR_SWITCH) then
            Result := TdxToggleSwitch.Create(FOwner)

          else
            if (ET = LowerCase(EDITOR_TEXTAREA)) or (ET = LowerCase(EDITOR_HTMLEDITOR)) then
            begin
              Result := TcxMemo.Create(FOwner);
              TcxMemo(Result).Properties.ScrollBars := ssVertical;
              Result.Height := 80;
            end

            else
              if (ET = LowerCase(EDITOR_SELECTBOX)) or (ET = LowerCase(EDITOR_LOOKUP)) or (ET = LowerCase(EDITOR_DROPDOWNBOX)) or (ET = LowerCase(EDITOR_TAGBOX)) then
                Result := TcxComboBox.Create(FOwner)

              else
                if ET = LowerCase(EDITOR_RADIOGROUP) then
                  Result := TcxRadioGroup.Create(FOwner)

                else
                  if (ET = LowerCase(EDITOR_SLIDER)) or (ET = LowerCase(EDITOR_RANGESLIDER)) then
                    Result := TcxTrackBar.Create(FOwner)

                  else
                    if ET = LowerCase(EDITOR_COLORBOX) then
                      Result := TcxColorComboBox.Create(FOwner)

                    else
                      Result := TcxTextEdit.Create(FOwner);

  if Result is TcxCustomTextEdit then
    TcxCustomTextEdit(Result).Properties.ReadOnly := True;

  Result.OnMouseDown := EditorMouseDown;
  Result.OnClick := EditorClick;
  Result.OnContextPopup := EditorContextPopup;
  ItemControls.Add(Result);
end;

{ ============================================================ }
{ Helper: posizione label }
{ ============================================================ }

procedure TFormPreviewBuilder.ConfigureLabelLocation(AItem: TdxLayoutItem; const ALabelLoc: string);
begin
  AItem.CaptionOptions.Visible := True;
  if SameText(ALabelLoc, LABEL_TOP) then
    AItem.CaptionOptions.Layout := clTop
  else
    if SameText(ALabelLoc, LABEL_LEFT) then
      AItem.CaptionOptions.Layout := clLeft
    else
      if SameText(ALabelLoc, LABEL_RIGHT) then
        AItem.CaptionOptions.Layout := clRight
      else
        if SameText(ALabelLoc, LABEL_HIDDEN) then
          AItem.CaptionOptions.Visible := False
        else
          AItem.CaptionOptions.Layout := clTop;
end;

{ ============================================================ }
{ Helper: recupera TBaseWebDatasetField dal nome }
{ ============================================================ }

function TFormPreviewBuilder.ResolveField(const AFieldName: string): TBaseWebDatasetField;
begin
  Result := nil;

  for var F in FStruct.Fields do
    if SameText(F.Field, AFieldName) then
      Exit(F);
end;

procedure TFormPreviewBuilder.VclControlClick(Sender: TObject);
begin
  EditorClick(Sender);
end;

procedure TFormPreviewBuilder.VclControlContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  EditorContextPopup(Sender, MousePos, Handled);
end;

{ ============================================================ }
{ Helper: crea gruppo-riga orizzontale }
{ ============================================================ }

function TFormPreviewBuilder.NewRowGroup(AParent: TdxLayoutGroup): TdxLayoutGroup;
begin
  Result := AParent.CreateGroup;
  Result.LayoutDirection := ldHorizontal;
  Result.ShowBorder := False;
  Result.CaptionOptions.Visible := False;
  Result.AlignHorz := ahClient;
end;

{ ============================================================ }
{ Costruzione gerarchia gruppi }
{ ============================================================ }

procedure TFormPreviewBuilder.BuildGroupHierarchy;
var
  Dataset: TBaseWebDataset;
  LabelLoc: string;
  ColonFlag: Boolean;
begin
  Dataset := FStruct.Dataset;
  LabelLoc := Dataset.FormLabelLoc;
  ColonFlag := Dataset.FormLabelColon;

  FLayoutControl.Container.Root.LayoutDirection := ldVertical;

  { -----------------------------------------------------------
    CASO 1: ci sono Tabbed container
    Struttura: Root → TabbedWrapper (ldTabbed) → un gruppo per
    ogni Tab → sotto ogni tab i gruppi del Tab
    ----------------------------------------------------------- }
  for var Tabbed in FStruct.FormTabbed do
  begin
    var
    LTabbedGroup := FLayoutControl.Container.Root.CreateGroup;
    LTabbedGroup.LayoutDirection := ldTabbed;
    LTabbedGroup.ShowBorder := False;
    LTabbedGroup.CaptionOptions.Visible := False;
    LTabbedGroup.AlignHorz := ahClient;
    WireContainerClick(LTabbedGroup, nkFormTabbed, Tabbed);
    { Usa il ContainerName come caption del pannello tabbed (opzionale) }

    { Per ogni Tab associato a questo Tabbed... }
    for var Tab in FStruct.FormTabs do
    begin
      if not SameText(Tab.TabbedName, Tabbed.TabbedName) then
        Continue;

      { Risolvi caption del tab (Custom ha priorità) }
      var
      TabCaption := IfThen(Tab.Caption <> '', Tab.Caption, Tab.TabName);

      var
      LTabGroup := LTabbedGroup.CreateGroup;
      LTabGroup.Caption := TabCaption;
      LTabGroup.CaptionOptions.Visible := True;
      LTabGroup.LayoutDirection := ldVertical;
      LTabGroup.ShowBorder := False;
      LTabGroup.AlignHorz := ahClient;
      FTabMap.Add(Tab.TabName, LTabGroup);
      WireContainerClick(LTabGroup, nkFormTab, Tab);

      { Gruppi dentro il tab }
      for var Group in FStruct.FormGroups do
      begin
        if not SameText(Group.ParentContainerName, Tab.TabName) then
          Continue;

        var
        GrpCaption := IfThen(Group.Caption <> '', Group.Caption, Group.GroupName);

        var
        LGrp := LTabGroup.CreateGroup;
        LGrp.Caption := GrpCaption;
        LGrp.CaptionOptions.Visible := True;
        LGrp.ShowBorder := True;
        LGrp.LayoutDirection := ldVertical;
        LGrp.AlignHorz := ahClient;
        FGroupMap.Add(Group.GroupName, LGrp);
        WireContainerClick(LGrp, nkFormGroup, Group);
      end;
    end;
  end;

  { -----------------------------------------------------------
    CASO 2: Tab senza Tabbed associato (tab orfane)
    ----------------------------------------------------------- }
  for var Tab in FStruct.FormTabs do
  begin
    { È già stata processata sopra? }
    if FTabMap.ContainsKey(Tab.TabName) then
      Continue;

    var
    TabCaption := IfThen(Tab.Caption <> '', Tab.Caption, Tab.TabName);
    var
    LTabGroup := FLayoutControl.Container.Root.CreateGroup;
    LTabGroup.Caption := TabCaption;
    LTabGroup.CaptionOptions.Visible := True;
    LTabGroup.LayoutDirection := ldVertical;
    LTabGroup.ShowBorder := False;
    LTabGroup.AlignHorz := ahClient;
    FTabMap.Add(Tab.TabName, LTabGroup);
    WireContainerClick(LTabGroup, nkFormTab, Tab);

    for var Group in FStruct.FormGroups do
    begin
      if not SameText(Group.ParentContainerName, Tab.TabName) then
        Continue;

      var
      GrpCaption := IfThen(Group.Caption <> '', Group.Caption, Group.GroupName);

      var
      LGrp := LTabGroup.CreateGroup;
      LGrp.Caption := GrpCaption;
      LGrp.CaptionOptions.Visible := True;
      LGrp.ShowBorder := True;
      LGrp.LayoutDirection := ldVertical;
      LGrp.AlignHorz := ahClient;
      FGroupMap.Add(Group.GroupName, LGrp);
      WireContainerClick(LGrp, nkFormGroup, Group);
    end;
  end;

  { -----------------------------------------------------------
    CASO 3: Gruppi senza contenitore (flat)
    ----------------------------------------------------------- }
  for var Group in FStruct.FormGroups do
  begin
    if FGroupMap.ContainsKey(Group.GroupName) then
      Continue; // già processato

    { Solo gruppi davvero senza contenitore }
    if Group.ParentContainerName <> '' then
      Continue;

    var
    GrpCaption := IfThen(Group.Caption <> '', Group.Caption, Group.GroupName);

    var
    LGrp := FLayoutControl.Container.Root.CreateGroup;
    LGrp.Caption := GrpCaption;
    LGrp.CaptionOptions.Visible := True;
    LGrp.ShowBorder := True;
    LGrp.LayoutDirection := ldVertical;
    LGrp.AlignHorz := ahClient;
    FGroupMap.Add(Group.GroupName, LGrp);
    WireContainerClick(LGrp, nkFormGroup, Group);
  end;

  { -----------------------------------------------------------
    CASO 4: Sottogruppi (gruppo dentro gruppo)
    Itera fino a quando non ci sono piu' gruppi da aggiungere.
    ----------------------------------------------------------- }
  var
  AddedAny := True;
  while AddedAny do
  begin
    AddedAny := False;
    for var SubGroup in FStruct.FormGroups do
    begin
      if FGroupMap.ContainsKey(SubGroup.GroupName) then
        Continue; // già processato

      // Solo gruppi il cui parent è un gruppo già in mappa
      if (SubGroup.ParentContainerName = '') or not SameText(SubGroup.ParentContainerType, 'group') then
        Continue;

      var
        LParent: TdxLayoutGroup;
      if not FGroupMap.TryGetValue(SubGroup.ParentContainerName, LParent) then
        Continue; // parent non ancora in mappa, riprova al prossimo giro

      var
      SubCaption := IfThen(SubGroup.Caption <> '', SubGroup.Caption, SubGroup.GroupName);
      var
      LSubGrp := LParent.CreateGroup;
      LSubGrp.Caption := SubCaption;
      LSubGrp.CaptionOptions.Visible := True;
      LSubGrp.ShowBorder := True;
      LSubGrp.LayoutDirection := ldVertical;
      LSubGrp.AlignHorz := ahClient;
      FGroupMap.Add(SubGroup.GroupName, LSubGrp);
      WireContainerClick(LSubGrp, nkFormGroup, SubGroup);
      AddedAny := True;
    end;
  end;
end;

{ ============================================================ }
{ Popola il contenuto di un gruppo }
{ ============================================================ }

procedure TFormPreviewBuilder.PopulateGroupContent(const AGroupName: string; ALayoutGroup: TdxLayoutGroup);
type
  TContentKind = (ckField, ckButton, ckEmpty);

  TContentEntry = record
    Kind: TContentKind;
    SortOrder: Integer;
    FieldName: string; // per ckField
    ButtonName: string; // per ckButton
    EmptyName: string; // per ckEmpty
    ColSpan: Integer;
    LineBreak: Boolean;
    Caption: string;
    EditorType: string; // solo ckField
    Required: Boolean;
    ReadOnly: Boolean;
    BtnAction: string; // solo ckButton
  end;

var
  Dataset: TBaseWebDataset;
  GlobalColCount: Integer;
  GrpColCount: Integer;
  EffColCount: Integer;
  LabelLoc: string;
  ColonFlag: Boolean;
  Entries: TList<TContentEntry>;
  RowGroup: TdxLayoutGroup;
  ColPos: Integer;
  Entry: TContentEntry;
  NeedNewRow: Boolean;
  Span: Integer;
begin
  Dataset := FStruct.Dataset;
  GlobalColCount := Dataset.FormColCount;
  if GlobalColCount < 1 then
    GlobalColCount := 1;
  LabelLoc := Dataset.FormLabelLoc;
  ColonFlag := Dataset.FormLabelColon;

  GrpColCount := 0;
  for var G in FStruct.FormGroups do
    if SameText(G.GroupName, AGroupName) then
    begin
      GrpColCount := G.ColCount;
      Break;
    end;

  EffColCount := GrpColCount;
  if EffColCount < 1 then
    EffColCount := GlobalColCount;

  { -----------------------------------------------------------
    Raccoglie tutte le voci del gruppo (field + button + empty)
    ordinate per SortOrder
    ----------------------------------------------------------- }
  Entries := TList<TContentEntry>.Create;
  try
    { FormFields }
    for var FF in FStruct.FormFields do
    begin
      if not SameText(FF.ContainerName, AGroupName) then
        Continue;

      var
        E: TContentEntry;
      E.Kind := ckField;
      E.FieldName := FF.Field;
      E.ButtonName := '';
      E.EmptyName := '';
      E.SortOrder := FF.SortOrder;
      E.ColSpan := FF.ColSpan;
      E.LineBreak := FF.LineBreak;
      E.Required := FF.Required;
      // E.ReadOnly := FF.ReadOnly; { TODO : Verificare }
      E.BtnAction := '';

      { Risolvi Caption e EditorType dalla definizione campo (con Custom) }
      E.Caption := FF.Field;
      E.EditorType := EDITOR_TEXTBOX;
      for var FD in FStruct.Fields do
        if SameText(FD.Field, FF.Field) then
        begin
          E.Caption := FD.Caption;
          E.EditorType := IfThen(FD.EditorType <> '', FD.EditorType, EDITOR_TEXTBOX);
          Break;
        end;

      Entries.Add(E);
    end;

    { FormButtons }
    for var FB in FStruct.FormButtons do
    begin
      if not SameText(FB.ContainerName, AGroupName) then
        Continue;

      var
        E: TContentEntry;
      E.Kind := ckButton;
      E.FieldName := '';
      E.ButtonName := FB.ButtonName;
      E.EmptyName := '';
      E.SortOrder := FB.SortOrder;
      E.ColSpan := FB.ColSpan;
      E.LineBreak := False;
      E.Caption := FB.BtnText;
      E.EditorType := '';
      E.Required := False;
      E.ReadOnly := False;
      E.BtnAction := FB.BtnAction;
      E.Caption := FB.ButtonName;

      Entries.Add(E);
    end;

    { FormEmpty }
    for var FE in FStruct.FormEmpty do
    begin
      if not SameText(FE.ContainerName, AGroupName) then
        Continue;

      var
        E: TContentEntry;
      E.Kind := ckEmpty;
      E.FieldName := '';
      E.ButtonName := '';
      E.EmptyName := FE.EmptyName;
      E.SortOrder := FE.SortOrder;
      E.ColSpan := FE.ColSpan;
      E.LineBreak := False;
      E.Caption := FE.EmptyName;
      E.EditorType := '';
      E.Required := False;
      E.ReadOnly := False;
      E.BtnAction := '';

      Entries.Add(E);
    end;

    { Ordina per SortOrder }
    Entries.Sort(TComparer<TContentEntry>.Construct(
      function(const A, B: TContentEntry): Integer
      begin
        Result := A.SortOrder - B.SortOrder;
      end));

    { -----------------------------------------------------------
      Layout grid row-based
      ----------------------------------------------------------- }
    RowGroup := nil;
    ColPos := 0;

    for Entry in Entries do
    begin
      Span := Entry.ColSpan;
      if Span < 1 then
        Span := 1;
      if Span > EffColCount then
        Span := EffColCount;

      NeedNewRow := (RowGroup = nil) or (ColPos + Span > EffColCount) or Entry.LineBreak;

      if NeedNewRow then
      begin
        RowGroup := NewRowGroup(ALayoutGroup);
        ColPos := 0;
      end;

      case Entry.Kind of

        ckField:
          begin
            var
            LItem := RowGroup.CreateItem(TdxLayoutItem) as TdxLayoutItem;

            { Caption con eventuale * e : }
            var
            Cap := Entry.Caption;
            if Entry.Required then
              Cap := '* ' + Cap;
            if ColonFlag then
              Cap := Cap + ':';
            LItem.CaptionOptions.Text := Cap;

            ConfigureLabelLocation(LItem, LabelLoc);

            { Layout: ogni item prende una larghezza proporzionale
              al suo Span rispetto a EffColCount. ahClient su tutti
              gli item nella riga fa sì che si dividano lo spazio
              equamente; Width aggiuntivo dà il peso proporzionale. }
            LItem.AlignHorz := ahClient;
            if EffColCount > 1 then
              LItem.Width := Span * (FLayoutControl.Width div EffColCount);

            var
            LEditor := CreateEditorForType(Entry.EditorType);

            { Stile read-only visivo }
            if Entry.ReadOnly and (LEditor is TcxCustomTextEdit) then
              TcxCustomTextEdit(LEditor).Style.Color := $00F0F0F0;

            LItem.Control := LEditor;
            { Usa il Tag dell'item per trovare il campo al click }
            LItem.Tag := NativeInt(Pointer(LEditor));

            FItemMap.AddOrSetValue(Entry.FieldName, LItem);
          end;

        ckButton:
          begin
            { Placeholder visivo: un bottone VCL in un item layout }
            var
            LItem := RowGroup.CreateItem(TdxLayoutItem) as TdxLayoutItem;
            LItem.Caption := Entry.Caption;
            LItem.CaptionOptions.Visible := False;
            LItem.AlignHorz := ahClient;
            if EffColCount > 1 then
              LItem.Width := Span * (FLayoutControl.Width div EffColCount);

            var
            LBtn := TcxButton.Create(nil);
            LBtn.Caption := Entry.Caption;
            LBtn.Enabled := True; // solo anteprima
            LBtn.OnClick := VclControlClick;
            LBtn.OnContextPopup := VclControlContextPopup;
            ItemControls.Add(LBtn);
            LItem.Control := LBtn;
            // { Usa il Tag dell'item per trovare il campo al click }
            // LItem.Tag := NativeInt(Pointer(LBtn));

            FItemMap.AddOrSetValue(Entry.ButtonName, LItem);
          end;

        ckEmpty:
          begin
            { Placeholder vuoto }
            var
            LItem := RowGroup.CreateItem(TdxLayoutItem) as TdxLayoutItem;
            LItem.Caption := Entry.Caption;
            LItem.CaptionOptions.Visible := False;
            LItem.AlignHorz := ahClient;
            if EffColCount > 1 then
              LItem.Width := Span * (FLayoutControl.Width div EffColCount);

            // TcxLabel come placeholder visivo: grigio, non editabile
            var
            LLbl := TcxLabel.Create(FOwner); // FOwner → ownership VCL corretta
            LLbl.AutoSize := false;
            { TODO : todo }
            LLbl.Style.Color := $00E8E8E8;
            LLbl.Style.TextColor := $00909090;
            LLbl.Caption := '[ ' + Entry.EmptyName + ' ]';
            LLbl.Properties.Alignment.Horz := taCenter;
            LLbl.OnClick := EditorClick;
            LLbl.OnContextPopup := EditorContextPopup;
            ItemControls.Add(LLbl); // ownership unificata con gli altri editor
            LItem.Control := LLbl;

            FItemMap.AddOrSetValue(Entry.EmptyName, LItem);
          end;
      end; // case

      Inc(ColPos, Span);
    end; // for Entry

  finally
    Entries.Free;
  end;
end;

{ ============================================================ }
{ Punto di ingresso principale }
{ ============================================================ }

procedure TFormPreviewBuilder.BuildFromStruct(const AStruct: TBaseWebDatasetStructure);
begin
  FStruct := AStruct;
  ClearLayout;

  FLayoutControl.BeginUpdate;
  try
    { 1. Crea la gerarchia di gruppi/tab }
    BuildGroupHierarchy;

    { 2. Popola il contenuto di ogni gruppo }
    for var Pair in FGroupMap do
      PopulateGroupContent(Pair.Key, Pair.Value);

    { 3. FormField orfani (senza ContainerName → gruppo implicito root
      con la stessa logica row-based di PopulateGroupContent)

      Registra un gruppo fittizio '' in FGroupMap così PopulateGroupContent
      gestisce i campi con ContainerName vuoto/null. }
    var
    HasOrphans := False;
    for var FF in FStruct.FormFields do
    begin
      if (FF.ContainerName = '') and not FItemMap.ContainsKey(FF.Field) then
      begin
        HasOrphans := True;
        Break;
      end;
    end;

    if HasOrphans then
    begin
      var
      LRootGroup := FLayoutControl.Container.Root.CreateGroup;
      LRootGroup.ShowBorder := False;
      LRootGroup.CaptionOptions.Visible := False;
      LRootGroup.LayoutDirection := ldVertical;
      LRootGroup.AlignHorz := ahClient;
      FGroupMap.AddOrSetValue('', LRootGroup);
      PopulateGroupContent('', LRootGroup);
    end;

  finally
    FLayoutControl.EndUpdate;
  end;
end;

procedure TFormPreviewBuilder.RefreshFromStruct;
begin
  BuildFromStruct(FStruct);
end;

{ ============================================================ }
{ Highlight }
{ ============================================================ }

procedure TFormPreviewBuilder.HighlightField(const AFieldName: string);
var
  LItem: TdxLayoutItem;
begin
  ClearHighlight;
  if FItemMap.TryGetValue(AFieldName, LItem) then
  begin
    if Assigned(FLookAndFeelHighlight) then
      LItem.LayoutLookAndFeel := FLookAndFeelHighlight;
    LItem.MakeVisible;
  end;
end;

procedure TFormPreviewBuilder.ClearHighlight;
begin
  for var Pair in FItemMap do
    Pair.Value.LayoutLookAndFeel := nil;
end;

procedure TFormPreviewBuilder.EnableCustomization(AEnable: Boolean);
begin
  FLayoutControl.Customization := AEnable;
end;

function TFormPreviewBuilder.GetFieldNameFromItem(AItem: TdxLayoutItem): string;
begin
  Result := '';
  for var Pair in FItemMap do
    if Pair.Value = AItem then
      Exit(Pair.Key);
end;

{ ============================================================ }
{ Event handler: click su editor }
{ ============================================================ }

procedure TFormPreviewBuilder.EditorClick(Sender: TObject);
begin
  { Cerca il FieldName a partire dall'editor cliccato }
  for var Pair in FItemMap do
    if Assigned(Pair.Value.Control) and (Pair.Value.Control = Sender) then
    begin
      if Assigned(FOnFieldSelected) then
        FOnFieldSelected(Self, Pair.Key);
      Exit;
    end;
end;

procedure TFormPreviewBuilder.EditorContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
  FieldName: string;
  P: TPoint;
begin
  FieldName := '';
  for var Pair in FItemMap do
    if Assigned(Pair.Value.Control) and (Pair.Value.Control = Sender) then
    begin
      FieldName := Pair.Key;
      Break;
    end;

  P := TControl(Sender).ClientToScreen(MousePos);

  if Assigned(FOnFieldContext) then
    FOnFieldContext(Self, FieldName, P.X, P.Y);

  if Assigned(FPopupMenuField) then
    FPopupMenuField.Popup(P.X, P.Y);

  Handled := True;
end;

procedure TFormPreviewBuilder.EditorMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
    EditorClick(Sender);
end;

procedure TFormPreviewBuilder.WireContainerClick(AGroup: TdxLayoutGroup; AKind: TBaseWebNodeKind; AModelObj: TComponent);
begin
  { Salva il puntatore al modello nel Tag, esattamente come già avviene
    per TcxGridBand.Tag e TcxGridBandedColumn.Tag nella grid. }
  AGroup.Tag := NativeInt(AModelObj);
  AGroup.OnCaptionClick := LayoutGroupClick;
end;

procedure TFormPreviewBuilder.LayoutGroupClick(Sender: TObject);
var
  AGroup: TdxLayoutGroup;
  AModelObj: TComponent;
  AKind: TBaseWebNodeKind;
begin
  if not(Sender is TdxLayoutGroup) then
    Exit;
  AGroup := TdxLayoutGroup(Sender);
  AModelObj := TComponent(Pointer(AGroup.Tag));
  if not Assigned(AModelObj) then
    Exit;

  if AModelObj is TBaseWebFormGroup then
    AKind := nkFormGroup
  else
    if AModelObj is TBaseWebFormTab then
      AKind := nkFormTab
    else
      if AModelObj is TBaseWebFormTabbed then
        AKind := nkFormTabbed
      else
        Exit;

  if Assigned(FOnContainerSelected) then
    FOnContainerSelected(Self, AKind, AModelObj);
end;

end.
