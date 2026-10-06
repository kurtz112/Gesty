unit DevExtreme.MenuBase;

interface

uses
  System.SysUtils,
  System.Classes,
  WEBLib.Controls,
  jsdelphisystem,
  JS,
  Web,
  libjquery,
  DevExtreme.CustomControl,
  DevExtreme.Types;

type
  [ComponentPlatforms(TMSWebPlatform)]
  TjdxMenuBase = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    Fanimation: TJSObject;
    FcssClass: string;
    FdataSource: JSValue;
    Fdisabled: boolean;
    FdisabledExpr: JSValue;
    FdisplayExpr: JSValue;
    FelementAttr: TJSObject;
    FexpandedExpr: JSValue;
    FfocusedElement: TJSElement;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FitemHoldTimeout: integer;
    Fitems: TJSArray;
    FitemsExpr: JSValue;
    FitemTemplate: JSValue;
    FkeyExpr: JSValue;
    FloopItemFocus: boolean;
    FnoDataText: string;
    FparentIdExpr: JSValue;
    FrtlEnabled: boolean;
    FselectByClick: boolean;
    FselectedExpr: JSValue;
    FselectedIndex: integer;
    FselectedItem: JSValue;
    FselectedItemKeys: TJSArray;
    FselectedItems: TJSArray;
    FselectionByClick: boolean;
    FselectionMode: TCollectionWidgetSelectionMode;
    FselectionRequired: boolean;
    FselectOnFocus: boolean;
    FshowSubmenuMode: TJSObject;
    FtabIndex: integer;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonItemClick: TdxEventHandler;
    FonItemContextMenu: TdxEventHandler;
    FonItemDeleted: TdxEventHandler;
    FonItemDeleting: TdxEventHandler;
    FonItemHold: TdxEventHandler;
    FonItemRendered: TdxEventHandler;
    FonItemReordered: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_animation(const value: TJSObject);
    procedure Set_cssClass(const value: string);
    procedure Set_dataSource(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_disabledExpr(const value: JSValue);
    procedure Set_displayExpr(const value: JSValue);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_expandedExpr(const value: JSValue);
    procedure Set_focusedElement(const value: TJSElement);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_itemHoldTimeout(const value: integer);
    procedure Set_items(const value: TJSArray);
    procedure Set_itemsExpr(const value: JSValue);
    procedure Set_itemTemplate(const value: JSValue);
    procedure Set_keyExpr(const value: JSValue);
    procedure Set_loopItemFocus(const value: boolean);
    procedure Set_noDataText(const value: string);
    procedure Set_parentIdExpr(const value: JSValue);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_selectByClick(const value: boolean);
    procedure Set_selectedExpr(const value: JSValue);
    procedure Set_selectedIndex(const value: integer);
    procedure Set_selectedItem(const value: JSValue);
    procedure Set_selectedItemKeys(const value: TJSArray);
    procedure Set_selectedItems(const value: TJSArray);
    procedure Set_selectionByClick(const value: boolean);
    procedure Set_selectionMode(const value: TCollectionWidgetSelectionMode);
    procedure Set_selectionRequired(const value: boolean);
    procedure Set_selectOnFocus(const value: boolean);
    procedure Set_showSubmenuMode(const value: TJSObject);
    procedure Set_tabIndex(const value: integer);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onItemClick(const value: TdxEventHandler);
    procedure Set_onItemContextMenu(const value: TdxEventHandler);
    procedure Set_onItemDeleted(const value: TdxEventHandler);
    procedure Set_onItemDeleting(const value: TdxEventHandler);
    procedure Set_onItemHold(const value: TdxEventHandler);
    procedure Set_onItemRendered(const value: TdxEventHandler);
    procedure Set_onItemReordered(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property animation: TJSObject read Fanimation write Set_animation;
    property dataSource: JSValue read FdataSource write Set_dataSource;
    property disabledExpr: JSValue read FdisabledExpr write Set_disabledExpr;
    property displayExpr: JSValue read FdisplayExpr write Set_displayExpr;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property expandedExpr: JSValue read FexpandedExpr write Set_expandedExpr;
    property focusedElement: TJSElement read FfocusedElement write Set_focusedElement;
    property height_: JSValue read Fheight_ write Set_height_;
    property items: TJSArray read Fitems write Set_items;
    property itemsExpr: JSValue read FitemsExpr write Set_itemsExpr;
    property itemTemplate: JSValue read FitemTemplate write Set_itemTemplate;
    property keyExpr: JSValue read FkeyExpr write Set_keyExpr;
    property parentIdExpr: JSValue read FparentIdExpr write Set_parentIdExpr;
    property selectedExpr: JSValue read FselectedExpr write Set_selectedExpr;
    property selectedItem: JSValue read FselectedItem write Set_selectedItem;
    property selectedItemKeys: TJSArray read FselectedItemKeys write Set_selectedItemKeys;
    property selectedItems: TJSArray read FselectedItems write Set_selectedItems;
    property showSubmenuMode: TJSObject read FshowSubmenuMode write Set_showSubmenuMode;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property cssClass: string read FcssClass write Set_cssClass;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property itemHoldTimeout: integer read FitemHoldTimeout write Set_itemHoldTimeout;
    property loopItemFocus: boolean read FloopItemFocus write Set_loopItemFocus;
    property noDataText: string read FnoDataText write Set_noDataText;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property selectByClick: boolean read FselectByClick write Set_selectByClick default false;
    property selectedIndex: integer read FselectedIndex write Set_selectedIndex;
    property selectionByClick: boolean read FselectionByClick write Set_selectionByClick default true;
    property selectionMode: TCollectionWidgetSelectionMode read FselectionMode write Set_selectionMode default cwsmNone;
    property selectionRequired: boolean read FselectionRequired write Set_selectionRequired default false;
    property selectOnFocus: boolean read FselectOnFocus write Set_selectOnFocus;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onItemClick: TdxEventHandler read FonItemClick write Set_onItemClick;
    property onItemContextMenu: TdxEventHandler read FonItemContextMenu write Set_onItemContextMenu;
    property onItemDeleted: TdxEventHandler read FonItemDeleted write Set_onItemDeleted;
    property onItemDeleting: TdxEventHandler read FonItemDeleting write Set_onItemDeleting;
    property onItemHold: TdxEventHandler read FonItemHold write Set_onItemHold;
    property onItemRendered: TdxEventHandler read FonItemRendered write Set_onItemRendered;
    property onItemReordered: TdxEventHandler read FonItemReordered write Set_onItemReordered;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
  end;

implementation


constructor TjdxMenuBase.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  Fanimation := TJSObject.new;
  FcssClass := '';
  FdataSource := nil;
  Fdisabled := false;
  FdisabledExpr := nil;
  FdisplayExpr := nil;
  FelementAttr := TJSObject.new;
  FexpandedExpr := nil;
  FfocusedElement := nil;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FitemHoldTimeout := 0;
  Fitems := TJSArray.new;
  FitemsExpr := nil;
  FitemTemplate := nil;
  FkeyExpr := nil;
  FloopItemFocus := false;
  FnoDataText := '';
  FparentIdExpr := nil;
  FrtlEnabled := false;
  FselectByClick := false;
  FselectedExpr := nil;
  FselectedIndex := 0;
  FselectedItem := nil;
  FselectedItemKeys := TJSArray.new;
  FselectedItems := TJSArray.new;
  FselectionByClick := true;
  FselectionMode := cwsmNone;
  FselectionRequired := false;
  FselectOnFocus := false;
  FshowSubmenuMode := TJSObject.new;
  FtabIndex := 0;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonItemClick := nil;
  FonItemContextMenu := nil;
  FonItemDeleted := nil;
  FonItemDeleting := nil;
  FonItemHold := nil;
  FonItemRendered := nil;
  FonItemReordered := nil;
  FonOptionChanged := nil;
  FonSelectionChanged := nil;
end;

procedure TjdxMenuBase.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxMenuBase.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxMenuBase.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
end;

procedure TjdxMenuBase.Set_cssClass(const Value: string);
begin
  FcssClass := Value;
end;

procedure TjdxMenuBase.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxMenuBase.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxMenuBase.Set_disabledExpr(const Value: JSValue);
begin
  FdisabledExpr := Value;
end;

procedure TjdxMenuBase.Set_displayExpr(const Value: JSValue);
begin
  FdisplayExpr := Value;
end;

procedure TjdxMenuBase.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxMenuBase.Set_expandedExpr(const Value: JSValue);
begin
  FexpandedExpr := Value;
end;

procedure TjdxMenuBase.Set_focusedElement(const Value: TJSElement);
begin
  FfocusedElement := Value;
end;

procedure TjdxMenuBase.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxMenuBase.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxMenuBase.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxMenuBase.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxMenuBase.Set_itemHoldTimeout(const Value: integer);
begin
  FitemHoldTimeout := Value;
end;

procedure TjdxMenuBase.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
end;

procedure TjdxMenuBase.Set_itemsExpr(const Value: JSValue);
begin
  FitemsExpr := Value;
end;

procedure TjdxMenuBase.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
end;

procedure TjdxMenuBase.Set_keyExpr(const Value: JSValue);
begin
  FkeyExpr := Value;
end;

procedure TjdxMenuBase.Set_loopItemFocus(const Value: boolean);
begin
  FloopItemFocus := Value;
end;

procedure TjdxMenuBase.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
end;

procedure TjdxMenuBase.Set_parentIdExpr(const Value: JSValue);
begin
  FparentIdExpr := Value;
end;

procedure TjdxMenuBase.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxMenuBase.Set_selectByClick(const Value: boolean);
begin
  FselectByClick := Value;
end;

procedure TjdxMenuBase.Set_selectedExpr(const Value: JSValue);
begin
  FselectedExpr := Value;
end;

procedure TjdxMenuBase.Set_selectedIndex(const Value: integer);
begin
  FselectedIndex := Value;
end;

procedure TjdxMenuBase.Set_selectedItem(const Value: JSValue);
begin
  FselectedItem := Value;
end;

procedure TjdxMenuBase.Set_selectedItemKeys(const Value: TJSArray);
begin
  FselectedItemKeys := Value;
end;

procedure TjdxMenuBase.Set_selectedItems(const Value: TJSArray);
begin
  FselectedItems := Value;
end;

procedure TjdxMenuBase.Set_selectionByClick(const Value: boolean);
begin
  FselectionByClick := Value;
end;

procedure TjdxMenuBase.Set_selectionMode(const Value: TCollectionWidgetSelectionMode);
begin
  FselectionMode := Value;
end;

procedure TjdxMenuBase.Set_selectionRequired(const Value: boolean);
begin
  FselectionRequired := Value;
end;

procedure TjdxMenuBase.Set_selectOnFocus(const Value: boolean);
begin
  FselectOnFocus := Value;
end;

procedure TjdxMenuBase.Set_showSubmenuMode(const Value: TJSObject);
begin
  FshowSubmenuMode := Value;
end;

procedure TjdxMenuBase.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxMenuBase.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxMenuBase.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxMenuBase.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxMenuBase.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxMenuBase.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxMenuBase.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxMenuBase.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxMenuBase.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
end;

procedure TjdxMenuBase.Set_onItemContextMenu(const Value: TdxEventHandler);
begin
  FonItemContextMenu := Value;
end;

procedure TjdxMenuBase.Set_onItemDeleted(const Value: TdxEventHandler);
begin
  FonItemDeleted := Value;
end;

procedure TjdxMenuBase.Set_onItemDeleting(const Value: TdxEventHandler);
begin
  FonItemDeleting := Value;
end;

procedure TjdxMenuBase.Set_onItemHold(const Value: TdxEventHandler);
begin
  FonItemHold := Value;
end;

procedure TjdxMenuBase.Set_onItemRendered(const Value: TdxEventHandler);
begin
  FonItemRendered := Value;
end;

procedure TjdxMenuBase.Set_onItemReordered(const Value: TdxEventHandler);
begin
  FonItemReordered := Value;
end;

procedure TjdxMenuBase.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxMenuBase.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
end;

end.
