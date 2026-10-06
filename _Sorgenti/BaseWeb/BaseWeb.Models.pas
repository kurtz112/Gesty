unit BaseWeb.Models;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections;

type
  { --- BASE COMPONENT --- }

  TBaseWebComponent = class(TComponent)
  private
    FModified: boolean;
  public
    constructor Create;

    property Modified: boolean read FModified write FModified;
  end;

  { --- DATASET --- }

  TBaseWebDataset = class(TBaseWebComponent)
  private
    FDataset: string;
    FDM: string;
    FName: string;
    FPkFields: string;
    FRelationName: string;
    FSequenceName: string;
    FCanInsert: boolean;
    FCanUpdate: boolean;
    FCanDelete: boolean;
    FSqlSelect: string;
    FSqlCount: string;
    FSqlInsert: string;
    FSqlUpdate: string;
    FSqlDelete: string;
    FNote: string;
    FCaption: string;
    FGridAllowView: boolean;
    FGridEditMode: string;
    FGridUseFormEdit: boolean;
    FGridConfirmDelete: boolean;
    FGridSelectionMode: string;
    FGridSelectionCheckbox: string;
    FGridSelectionSelectAll: string;
    FGridExportEnabled: boolean;
    FGridExportSelected: boolean;
    FGridExportFileName: string;
    FGridExportFormats: string;
    FGridPageSize: Integer;
    FGridPageSizes: string;
    FFormColCount: Integer;
    FFormLabelLoc: string;
    FFormLabelColon: boolean;
    FFormLayout: string;
    FFormWidth: Integer;
    FFormHeight: Integer;
  published
    property Dataset: string read FDataset write FDataset;
    property DM: string read FDM write FDM;
    property Name: string read FName write FName;
    property PkFields: string read FPkFields write FPkFields;
    property RelationName: string read FRelationName write FRelationName;
    property SequenceName: string read FSequenceName write FSequenceName;
    property CanInsert: boolean read FCanInsert write FCanInsert;
    property CanUpdate: boolean read FCanUpdate write FCanUpdate;
    property CanDelete: boolean read FCanDelete write FCanDelete;
    property SqlSelect: string read FSqlSelect write FSqlSelect;
    property SqlCount: string read FSqlCount write FSqlCount;
    property SqlInsert: string read FSqlInsert write FSqlInsert;
    property SqlUpdate: string read FSqlUpdate write FSqlUpdate;
    property SqlDelete: string read FSqlDelete write FSqlDelete;
    property Note: string read FNote write FNote;
    property Caption: string read FCaption write FCaption;
    property GridAllowView: boolean read FGridAllowView write FGridAllowView;
    property GridEditMode: string read FGridEditMode write FGridEditMode;
    property GridUseFormEdit: boolean read FGridUseFormEdit write FGridUseFormEdit;
    property GridConfirmDelete: boolean read FGridConfirmDelete write FGridConfirmDelete;
    property GridSelectionMode: string read FGridSelectionMode write FGridSelectionMode;
    property GridSelectionCheckbox: string read FGridSelectionCheckbox write FGridSelectionCheckbox;
    property GridSelectionSelectAll: string read FGridSelectionSelectAll write FGridSelectionSelectAll;
    property GridExportEnabled: boolean read FGridExportEnabled write FGridExportEnabled;
    property GridExportSelected: boolean read FGridExportSelected write FGridExportSelected;
    property GridExportFileName: string read FGridExportFileName write FGridExportFileName;
    property GridExportFormats: string read FGridExportFormats write FGridExportFormats;
    property GridPageSize: Integer read FGridPageSize write FGridPageSize;
    property GridPageSizes: string read FGridPageSizes write FGridPageSizes;
    property FormColCount: Integer read FFormColCount write FFormColCount;
    property FormLabelLoc: string read FFormLabelLoc write FFormLabelLoc;
    property FormLabelColon: boolean read FFormLabelColon write FFormLabelColon;
    property FormLayout: string read FFormLayout write FFormLayout;
    property FormWidth: Integer read FFormWidth write FFormWidth;
    property FormHeight: Integer read FFormHeight write FFormHeight;
  end;

  { --- DATASET FIELD --- }

  TBaseWebDatasetField = class(TBaseWebComponent)
  private
    FDataset: string;
    FField: string;
    FFieldOrigin: string;
    FCaption: string;
    FRequired: boolean;
    FReadonly: boolean;
    FFields2Clear: string;
    FEditorType: string;
    FPicklist: string;
    FLookup: string;
    FFormPlaceholder: string;
    FFormHelpText: string;
    FEditorOptions: string;
    FValidation: string;
    FDependsOn: string;
  published
    property Dataset: string read FDataset write FDataset;
    property Field: string read FField write FField;
    property FieldOrigin: string read FFieldOrigin write FFieldOrigin;
    property Caption: string read FCaption write FCaption;
    property Required: boolean read FRequired write FRequired;
    property Readonly: boolean read FReadonly write FReadonly;
    property Fields2Clear: string read FFields2Clear write FFields2Clear;
    property EditorType: string read FEditorType write FEditorType;
    property Picklist: string read FPicklist write FPicklist;
    property Lookup: string read FLookup write FLookup;
    property FormPlaceholder: string read FFormPlaceholder write FFormPlaceholder;
    property FormHelpText: string read FFormHelpText write FFormHelpText;
    property EditorOptions: string read FEditorOptions write FEditorOptions;
    property Validation: string read FValidation write FValidation;
    property DependsOn: string read FDependsOn write FDependsOn;
  end;

  { --- FORM LAYOUT & CONTAINERS --- }

  TBaseWebFormContainer = class(TBaseWebComponent)
  private
    FDataset: string;
    FContainerName: string;
    FContainerType: string;
    FParentContainerName: string;
    FParentContainerType: string;
    FSortOrder: Integer;
    FVisible: boolean;
    FCaption: string;
    FColSpan: Integer;
    FCssClass: string;
  published
    property Dataset: string read FDataset write FDataset;
    property ContainerName: string read FContainerName write FContainerName;
    property ContainerType: string read FContainerType write FContainerType;
    property ParentContainerName: string read FParentContainerName write FParentContainerName;
    property ParentContainerType: string read FParentContainerType write FParentContainerType;
    property SortOrder: Integer read FSortOrder write FSortOrder;
    property Visible: boolean read FVisible write FVisible;
    property Caption: string read FCaption write FCaption;
    property ColSpan: Integer read FColSpan write FColSpan;
    property CssClass: string read FCssClass write FCssClass;
  end;

  { --- FORM FIELD (foglia) --- }

  TBaseWebFormField = class(TBaseWebComponent)
  private
    FDataset: string;
    FField: string;
    FContainerName: string;
    FContainerType: string;
    FSortOrder: Integer;
    FVisible: boolean;
    FLabelText: string;
    FColSpan: Integer;
    FLinebreak: boolean;
    FPlaceholder: string;
    FHelpText: string;
    FCssClass: string;
    FRequired: boolean;
    FEditorOptions: string;
  published
    property Dataset: string read FDataset write FDataset;
    property Field: string read FField write FField;
    property ContainerName: string read FContainerName write FContainerName;
    property ContainerType: string read FContainerType write FContainerType;
    property SortOrder: Integer read FSortOrder write FSortOrder;
    property Visible: boolean read FVisible write FVisible;
    property LabelText: string read FLabelText write FLabelText;
    property ColSpan: Integer read FColSpan write FColSpan;
    property Linebreak: boolean read FLinebreak write FLinebreak;
    property Placeholder: string read FPlaceholder write FPlaceholder;
    property HelpText: string read FHelpText write FHelpText;
    property CssClass: string read FCssClass write FCssClass;
    property Required: boolean read FRequired write FRequired;
    property EditorOptions: string read FEditorOptions write FEditorOptions;
  end;

  { --- FORM GROUP (include campi CONTAINER trasparenti) --- }

  TBaseWebFormGroup = class(TBaseWebComponent)
  private
    FDataset: string;
    FGroupName: string;
    // campi da CONTAINER (trasparenti)
    FParentContainerName: string;
    FParentContainerType: string;
    FSortOrder: Integer;
    FVisible: boolean;
    FCaption: string;
    FColSpan: Integer;
    FCssClass: string;
    // campo specifico GROUPS
    FColCount: Integer;
  published
    property Dataset: string read FDataset write FDataset;
    property GroupName: string read FGroupName write FGroupName;
    // CONTAINER
    property ParentContainerName: string read FParentContainerName write FParentContainerName;
    property ParentContainerType: string read FParentContainerType write FParentContainerType;
    property SortOrder: Integer read FSortOrder write FSortOrder;
    property Visible: boolean read FVisible write FVisible;
    property Caption: string read FCaption write FCaption;
    property ColSpan: Integer read FColSpan write FColSpan;
    property CssClass: string read FCssClass write FCssClass;
    // specifico
    property ColCount: Integer read FColCount write FColCount;
  end;

  { --- FORM TABBED (include campi CONTAINER trasparenti) --- }

  TBaseWebFormTabbed = class(TBaseWebComponent)
  private
    FDataset: string;
    FTabbedName: string;
    // campi da CONTAINER (trasparenti)
    FParentContainerName: string;
    FParentContainerType: string;
    FSortOrder: Integer;
    FVisible: boolean;
    FCaption: string;
    FColSpan: Integer;
    FCssClass: string;
    // campi specifici TABBED (tabPanelOptions)
    FAnimationEnabled: boolean;
    FSwipeEnabled: boolean;
    FLoop: boolean;
    FDeferRendering: boolean;
    FTabsPosition: string;
    FStylingMode: string;
    FScrollingEnabled: boolean;
    FShowNavButtons: boolean;
    FIconPosition: string;
    FSelectedIndex: Integer;
    FHeight: Integer;
    FTabPanelOptions: string;
  published
    property Dataset: string read FDataset write FDataset;
    property TabbedName: string read FTabbedName write FTabbedName;
    // CONTAINER
    property ParentContainerName: string read FParentContainerName write FParentContainerName;
    property ParentContainerType: string read FParentContainerType write FParentContainerType;
    property SortOrder: Integer read FSortOrder write FSortOrder;
    property Visible: boolean read FVisible write FVisible;
    property Caption: string read FCaption write FCaption;
    property ColSpan: Integer read FColSpan write FColSpan;
    property CssClass: string read FCssClass write FCssClass;
    // specifici
    property AnimationEnabled: boolean read FAnimationEnabled write FAnimationEnabled;
    property SwipeEnabled: boolean read FSwipeEnabled write FSwipeEnabled;
    property Loop: boolean read FLoop write FLoop;
    property DeferRendering: boolean read FDeferRendering write FDeferRendering;
    property TabsPosition: string read FTabsPosition write FTabsPosition;
    property StylingMode: string read FStylingMode write FStylingMode;
    property ScrollingEnabled: boolean read FScrollingEnabled write FScrollingEnabled;
    property ShowNavButtons: boolean read FShowNavButtons write FShowNavButtons;
    property IconPosition: string read FIconPosition write FIconPosition;
    property SelectedIndex: Integer read FSelectedIndex write FSelectedIndex;
    property Height: Integer read FHeight write FHeight;
    property TabPanelOptions: string read FTabPanelOptions write FTabPanelOptions;
  end;

  { --- FORM TAB (include campi CONTAINER trasparenti) --- }

  TBaseWebFormTab = class(TBaseWebComponent)
  private
    FDataset: string;
    FTabName: string;
    FTabbedName: string;
    // campi da CONTAINER (trasparenti)
    FParentContainerName: string;
    FParentContainerType: string;
    FSortOrder: Integer;
    FVisible: boolean;
    FCaption: string;
    FColSpan: Integer;
    FCssClass: string;
    // campi specifici TABS
    FColCount: Integer;
    FDisabled: boolean;
    FIcon: string;
    FBadge: string;
    FAlignItemLabels: boolean;
  published
    property Dataset: string read FDataset write FDataset;
    property TabName: string read FTabName write FTabName;
    property TabbedName: string read FTabbedName write FTabbedName;
    // CONTAINER
    property ParentContainerName: string read FParentContainerName write FParentContainerName;
    property ParentContainerType: string read FParentContainerType write FParentContainerType;
    property SortOrder: Integer read FSortOrder write FSortOrder;
    property Visible: boolean read FVisible write FVisible;
    property Caption: string read FCaption write FCaption;
    property ColSpan: Integer read FColSpan write FColSpan;
    property CssClass: string read FCssClass write FCssClass;
    // specifici
    property ColCount: Integer read FColCount write FColCount;
    property Disabled: boolean read FDisabled write FDisabled;
    property Icon: string read FIcon write FIcon;
    property Badge: string read FBadge write FBadge;
    property AlignItemLabels: boolean read FAlignItemLabels write FAlignItemLabels;
  end;

  { --- FORM BUTTON (foglia) --- }

  TBaseWebFormButton = class(TBaseWebComponent)
  private
    FDataset: string;
    FButtonName: string;
    FContainerName: string;
    FContainerType: string;
    FSortOrder: Integer;
    FVisible: boolean;
    FColSpan: Integer;
    FBtnText: string;
    FBtnType: string;
    FBtnIcon: string;
    FBtnAction: string;
    FBtnHorizontalAlign: string;
    FBtnIconPosition: string;
    FBtnDisabled: boolean;
    FBtnStylingMode: string;
    FCssClass: string;
  published
    property Dataset: string read FDataset write FDataset;
    property ButtonName: string read FButtonName write FButtonName;
    property ContainerName: string read FContainerName write FContainerName;
    property ContainerType: string read FContainerType write FContainerType;
    property SortOrder: Integer read FSortOrder write FSortOrder;
    property Visible: boolean read FVisible write FVisible;
    property ColSpan: Integer read FColSpan write FColSpan;
    property BtnText: string read FBtnText write FBtnText;
    property BtnType: string read FBtnType write FBtnType;
    property BtnIcon: string read FBtnIcon write FBtnIcon;
    property BtnAction: string read FBtnAction write FBtnAction;
    property BtnHorizontalAlign: string read FBtnHorizontalAlign write FBtnHorizontalAlign;
    property BtnIconPosition: string read FBtnIconPosition write FBtnIconPosition;
    property BtnDisabled: boolean read FBtnDisabled write FBtnDisabled;
    property BtnStylingMode: string read FBtnStylingMode write FBtnStylingMode;
    property CssClass: string read FCssClass write FCssClass;
  end;

  { --- FORM EMPTY (foglia) --- }

  TBaseWebFormEmpty = class(TBaseWebComponent)
  private
    FDataset: string;
    FEmptyName: string;
    FContainerName: string;
    FContainerType: string;
    FSortOrder: Integer;
    FVisible: boolean;
    FColSpan: Integer;
  published
    property Dataset: string read FDataset write FDataset;
    property EmptyName: string read FEmptyName write FEmptyName;
    property ContainerName: string read FContainerName write FContainerName;
    property ContainerType: string read FContainerType write FContainerType;
    property SortOrder: Integer read FSortOrder write FSortOrder;
    property Visible: boolean read FVisible write FVisible;
    property ColSpan: Integer read FColSpan write FColSpan;
  end;

  { --- GRID --- }

  TBaseWebGridBand = class(TBaseWebComponent)
  private
    FDataset: string;
    FBandName: string;
    FParentBand: string;
    FCaption: string;
    FSortOrder: Integer;
    FVisible: boolean;
    FAlignment: string;
    FCssClass: string;
  published
    property Dataset: string read FDataset write FDataset;
    property BandName: string read FBandName write FBandName;
    property ParentBand: string read FParentBand write FParentBand;
    property Caption: string read FCaption write FCaption;
    property SortOrder: Integer read FSortOrder write FSortOrder;
    property Visible: boolean read FVisible write FVisible;
    property Alignment: string read FAlignment write FAlignment;
    property CssClass: string read FCssClass write FCssClass;
  end;

  TBaseWebGridColumn = class(TBaseWebComponent)
  private
    FDataset: string;
    FField: string;
    FCaption: string;
    FDataType: string;
    FBandName: string;
    FSortOrder: Integer;
    FFixed: boolean;
    FFixedPosition: string;
    FVisible: boolean;
    FWidth: Integer;
    FMinWidth: Integer;
    FAlignment: string;
    FFormatStr: string;
    FGroupIndex: Integer;
    FSummaryType: string;
    FAllowFilter: boolean;
    FAllowSort: boolean;
    FAllowGroup: boolean;
    FAllowResize: boolean;
    FAllowReorder: boolean;
    FAllowHiding: boolean;
    FHeaderFilter: boolean;
    FWordWrap: boolean;
    FEncodeHtml: boolean;
    FCssClass: string;
  published
    property Dataset: string read FDataset write FDataset;
    property Field: string read FField write FField;
    property Caption: string read FCaption write FCaption;
    property DataType: string read FDataType write FDataType;
    property BandName: string read FBandName write FBandName;
    property SortOrder: Integer read FSortOrder write FSortOrder;
    property Fixed: boolean read FFixed write FFixed;
    property FixedPosition: string read FFixedPosition write FFixedPosition;
    property Visible: boolean read FVisible write FVisible;
    property Width: Integer read FWidth write FWidth;
    property MinWidth: Integer read FMinWidth write FMinWidth;
    property Alignment: string read FAlignment write FAlignment;
    property FormatStr: string read FFormatStr write FFormatStr;
    property GroupIndex: Integer read FGroupIndex write FGroupIndex;
    property SummaryType: string read FSummaryType write FSummaryType;
    property AllowFilter: boolean read FAllowFilter write FAllowFilter;
    property AllowSort: boolean read FAllowSort write FAllowSort;
    property AllowGroup: boolean read FAllowGroup write FAllowGroup;
    property AllowResize: boolean read FAllowResize write FAllowResize;
    property AllowReorder: boolean read FAllowReorder write FAllowReorder;
    property AllowHiding: boolean read FAllowHiding write FAllowHiding;
    property HeaderFilter: boolean read FHeaderFilter write FHeaderFilter;
    property WordWrap: boolean read FWordWrap write FWordWrap;
    property EncodeHtml: boolean read FEncodeHtml write FEncodeHtml;
    property CssClass: string read FCssClass write FCssClass;
  end;

  { --- LOOKUPS & PICKLISTS --- }

  TBaseWebLookup = class(TBaseWebComponent)
  private
    FLookup: string;
    FDataset: string;
    FFkTable: string;
    FValueExpr: string;
    FDisplayExpr: string;
    FParams: string;
    FMappings: string;
    FPageSize: Integer;
    FDropdownWidth: Integer;
  published
    property Lookup: string read FLookup write FLookup;
    property Dataset: string read FDataset write FDataset;
    property FkTable: string read FFkTable write FFkTable;
    property ValueExpr: string read FValueExpr write FValueExpr;
    property DisplayExpr: string read FDisplayExpr write FDisplayExpr;
    property Params: string read FParams write FParams;
    property Mappings: string read FMappings write FMappings;
    property PageSize: Integer read FPageSize write FPageSize;
    property DropdownWidth: Integer read FDropdownWidth write FDropdownWidth;
  end;

  TBaseWebLookupColumn = class(TBaseWebComponent)
  private
    FLookup: string;
    FField: string;
    FCaption: string;
    FWidth: Integer;
    FAlignment: string;
  published
    property Lookup: string read FLookup write FLookup;
    property Field: string read FField write FField;
    property Caption: string read FCaption write FCaption;
    property Width: Integer read FWidth write FWidth;
    property Alignment: string read FAlignment write FAlignment;
  end;

  TBaseWebPicklist = class(TBaseWebComponent)
  private
    FPicklist: string;
    FItems: string;
    FHasIcons: boolean;
    FMeta: string;
  published
    property Picklist: string read FPicklist write FPicklist;
    property Items: string read FItems write FItems;
    property HasIcons: boolean read FHasIcons write FHasIcons;
    property Meta: string read FMeta write FMeta;
  end;

  TBaseWebPicklistItem = class(TBaseWebComponent)
  private
    FPicklist: string;
    FNome: string;
    FValore: string;
    FIcona: string;
  published
    property Picklist: string read FPicklist write FPicklist;
    property Nome: string read FNome write FNome;
    property Valore: string read FValore write FValore;
    property Icona: string read FIcona write FIcona;
  end;

  { --- DATASET STRUCTURE RECORD --- }

  TBaseWebDatasetStructure = record
    Dataset: TBaseWebDataset;
    Fields: TObjectList<TBaseWebDatasetField>;
    FormTabbed: TObjectList<TBaseWebFormTabbed>;
    FormTabs: TObjectList<TBaseWebFormTab>;
    FormGroups: TObjectList<TBaseWebFormGroup>;
    FormFields: TObjectList<TBaseWebFormField>;
    FormButtons: TObjectList<TBaseWebFormButton>;
    FormEmpty: TObjectList<TBaseWebFormEmpty>;
    GridBands: TObjectList<TBaseWebGridBand>;
    GridColumns: TObjectList<TBaseWebGridColumn>;

    procedure FreeObjects;
    procedure ResetModified;
  end;

implementation

constructor TBaseWebComponent.Create;
begin
  inherited Create(nil);
  FModified := false;
end;

{ TBaseWebDatasetStructure }

procedure TBaseWebDatasetStructure.FreeObjects;
begin
  FreeAndNil(Dataset);
  FreeAndNil(Fields);
  FreeAndNil(FormTabbed);
  FreeAndNil(FormTabs);
  FreeAndNil(FormGroups);
  FreeAndNil(FormFields);
  FreeAndNil(FormButtons);
  FreeAndNil(FormEmpty);
  FreeAndNil(GridBands);
  FreeAndNil(GridColumns);
end;

procedure TBaseWebDatasetStructure.ResetModified;
begin
  if Assigned(Dataset) then
    Dataset.Modified := false;

  for var F in Fields do
    F.Modified := false;
  for var FT in FormTabbed do
    FT.Modified := false;
  for var T in FormTabs do
    T.Modified := false;
  for var G in FormGroups do
    G.Modified := false;
  for var FF in FormFields do
    FF.Modified := false;
  for var B in FormButtons do
    B.Modified := false;
  for var E in FormEmpty do
    E.Modified := false;
  for var GB in GridBands do
    GB.Modified := false;
  for var GC in GridColumns do
    GC.Modified := false;
end;

end.
