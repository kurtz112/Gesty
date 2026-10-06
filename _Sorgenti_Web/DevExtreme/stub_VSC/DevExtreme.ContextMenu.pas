unit DevExtreme.ContextMenu;

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
  TjdxContextMenu = class(TjdxCustomControl)
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
    FhideOnOutsideClick: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FitemHoldAction: JSValue;
    FitemHoldTimeout: integer;
    Fitems: TJSArray;
    FitemsExpr: JSValue;
    FitemTemplate: JSValue;
    FkeyExpr: JSValue;
    FloopItemFocus: boolean;
    FnoDataText: string;
    FparentIdExpr: JSValue;
    Fposition: JSValue;
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
    FshowEvent: TJSObject;
    FshowSubmenuMode: TJSObject;
    FsubmenuDirection: TdxContextSubmenuDirection;
    FtabIndex: integer;
    Ftarget: JSValue;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonHidden: TdxEventHandler;
    FonHiding: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonItemClick: TdxEventHandler;
    FonItemContextMenu: TdxEventHandler;
    FonItemDeleted: TdxEventHandler;
    FonItemDeleting: TdxEventHandler;
    FonItemHold: TdxEventHandler;
    FonItemRendered: TdxEventHandler;
    FonItemReordered: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonPositioning: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
    FonShowing: TdxEventHandler;
    FonShown: TdxEventHandler;
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
    procedure Set_hideOnOutsideClick(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_itemHoldAction(const value: JSValue);
    procedure Set_itemHoldTimeout(const value: integer);
    procedure Set_items(const value: TJSArray);
    procedure Set_itemsExpr(const value: JSValue);
    procedure Set_itemTemplate(const value: JSValue);
    procedure Set_keyExpr(const value: JSValue);
    procedure Set_loopItemFocus(const value: boolean);
    procedure Set_noDataText(const value: string);
    procedure Set_parentIdExpr(const value: JSValue);
    procedure Set_position(const value: JSValue);
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
    procedure Set_showEvent(const value: TJSObject);
    procedure Set_showSubmenuMode(const value: TJSObject);
    procedure Set_submenuDirection(const value: TdxContextSubmenuDirection);
    procedure Set_tabIndex(const value: integer);
    procedure Set_target(const value: JSValue);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onHidden(const value: TdxEventHandler);
    procedure Set_onHiding(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onItemClick(const value: TdxEventHandler);
    procedure Set_onItemContextMenu(const value: TdxEventHandler);
    procedure Set_onItemDeleted(const value: TdxEventHandler);
    procedure Set_onItemDeleting(const value: TdxEventHandler);
    procedure Set_onItemHold(const value: TdxEventHandler);
    procedure Set_onItemRendered(const value: TdxEventHandler);
    procedure Set_onItemReordered(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onPositioning(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
    procedure Set_onShowing(const value: TdxEventHandler);
    procedure Set_onShown(const value: TdxEventHandler);
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
    property hideOnOutsideClick: JSValue read FhideOnOutsideClick write Set_hideOnOutsideClick;
    property itemHoldAction: JSValue read FitemHoldAction write Set_itemHoldAction;
    property items: TJSArray read Fitems write Set_items;
    property itemsExpr: JSValue read FitemsExpr write Set_itemsExpr;
    property itemTemplate: JSValue read FitemTemplate write Set_itemTemplate;
    property keyExpr: JSValue read FkeyExpr write Set_keyExpr;
    property parentIdExpr: JSValue read FparentIdExpr write Set_parentIdExpr;
    property position: JSValue read Fposition write Set_position;
    property selectedExpr: JSValue read FselectedExpr write Set_selectedExpr;
    property selectedItem: JSValue read FselectedItem write Set_selectedItem;
    property selectedItemKeys: TJSArray read FselectedItemKeys write Set_selectedItemKeys;
    property selectedItems: TJSArray read FselectedItems write Set_selectedItems;
    property showEvent: TJSObject read FshowEvent write Set_showEvent;
    property showSubmenuMode: TJSObject read FshowSubmenuMode write Set_showSubmenuMode;
    property target: JSValue read Ftarget write Set_target;
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
    property submenuDirection: TdxContextSubmenuDirection read FsubmenuDirection write Set_submenuDirection default csdAuto;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onHidden: TdxEventHandler read FonHidden write Set_onHidden;
    property onHiding: TdxEventHandler read FonHiding write Set_onHiding;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onItemClick: TdxEventHandler read FonItemClick write Set_onItemClick;
    property onItemContextMenu: TdxEventHandler read FonItemContextMenu write Set_onItemContextMenu;
    property onItemDeleted: TdxEventHandler read FonItemDeleted write Set_onItemDeleted;
    property onItemDeleting: TdxEventHandler read FonItemDeleting write Set_onItemDeleting;
    property onItemHold: TdxEventHandler read FonItemHold write Set_onItemHold;
    property onItemRendered: TdxEventHandler read FonItemRendered write Set_onItemRendered;
    property onItemReordered: TdxEventHandler read FonItemReordered write Set_onItemReordered;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onPositioning: TdxEventHandler read FonPositioning write Set_onPositioning;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
    property onShowing: TdxEventHandler read FonShowing write Set_onShowing;
    property onShown: TdxEventHandler read FonShown write Set_onShown;
  end;

implementation


constructor TjdxContextMenu.Create(aOwner: TComponent);
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
  FhideOnOutsideClick := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FitemHoldAction := nil;
  FitemHoldTimeout := 0;
  Fitems := TJSArray.new;
  FitemsExpr := nil;
  FitemTemplate := nil;
  FkeyExpr := nil;
  FloopItemFocus := false;
  FnoDataText := '';
  FparentIdExpr := nil;
  Fposition := nil;
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
  FshowEvent := TJSObject.new;
  FshowSubmenuMode := TJSObject.new;
  FsubmenuDirection := csdAuto;
  FtabIndex := 0;
  Ftarget := nil;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonHidden := nil;
  FonHiding := nil;
  FonInitialized := nil;
  FonItemClick := nil;
  FonItemContextMenu := nil;
  FonItemDeleted := nil;
  FonItemDeleting := nil;
  FonItemHold := nil;
  FonItemRendered := nil;
  FonItemReordered := nil;
  FonOptionChanged := nil;
  FonPositioning := nil;
  FonSelectionChanged := nil;
  FonShowing := nil;
  FonShown := nil;
end;

procedure TjdxContextMenu.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxContextMenu.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxContextMenu.Set_animation(const Value: TJSObject);
begin
  Fanimation := Value;
end;

procedure TjdxContextMenu.Set_cssClass(const Value: string);
begin
  FcssClass := Value;
end;

procedure TjdxContextMenu.Set_dataSource(const Value: JSValue);
begin
  FdataSource := Value;
end;

procedure TjdxContextMenu.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxContextMenu.Set_disabledExpr(const Value: JSValue);
begin
  FdisabledExpr := Value;
end;

procedure TjdxContextMenu.Set_displayExpr(const Value: JSValue);
begin
  FdisplayExpr := Value;
end;

procedure TjdxContextMenu.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxContextMenu.Set_expandedExpr(const Value: JSValue);
begin
  FexpandedExpr := Value;
end;

procedure TjdxContextMenu.Set_focusedElement(const Value: TJSElement);
begin
  FfocusedElement := Value;
end;

procedure TjdxContextMenu.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxContextMenu.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxContextMenu.Set_hideOnOutsideClick(const Value: JSValue);
begin
  FhideOnOutsideClick := Value;
end;

procedure TjdxContextMenu.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxContextMenu.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxContextMenu.Set_itemHoldAction(const Value: JSValue);
begin
  FitemHoldAction := Value;
end;

procedure TjdxContextMenu.Set_itemHoldTimeout(const Value: integer);
begin
  FitemHoldTimeout := Value;
end;

procedure TjdxContextMenu.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
end;

procedure TjdxContextMenu.Set_itemsExpr(const Value: JSValue);
begin
  FitemsExpr := Value;
end;

procedure TjdxContextMenu.Set_itemTemplate(const Value: JSValue);
begin
  FitemTemplate := Value;
end;

procedure TjdxContextMenu.Set_keyExpr(const Value: JSValue);
begin
  FkeyExpr := Value;
end;

procedure TjdxContextMenu.Set_loopItemFocus(const Value: boolean);
begin
  FloopItemFocus := Value;
end;

procedure TjdxContextMenu.Set_noDataText(const Value: string);
begin
  FnoDataText := Value;
end;

procedure TjdxContextMenu.Set_parentIdExpr(const Value: JSValue);
begin
  FparentIdExpr := Value;
end;

procedure TjdxContextMenu.Set_position(const Value: JSValue);
begin
  Fposition := Value;
end;

procedure TjdxContextMenu.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxContextMenu.Set_selectByClick(const Value: boolean);
begin
  FselectByClick := Value;
end;

procedure TjdxContextMenu.Set_selectedExpr(const Value: JSValue);
begin
  FselectedExpr := Value;
end;

procedure TjdxContextMenu.Set_selectedIndex(const Value: integer);
begin
  FselectedIndex := Value;
end;

procedure TjdxContextMenu.Set_selectedItem(const Value: JSValue);
begin
  FselectedItem := Value;
end;

procedure TjdxContextMenu.Set_selectedItemKeys(const Value: TJSArray);
begin
  FselectedItemKeys := Value;
end;

procedure TjdxContextMenu.Set_selectedItems(const Value: TJSArray);
begin
  FselectedItems := Value;
end;

procedure TjdxContextMenu.Set_selectionByClick(const Value: boolean);
begin
  FselectionByClick := Value;
end;

procedure TjdxContextMenu.Set_selectionMode(const Value: TCollectionWidgetSelectionMode);
begin
  FselectionMode := Value;
end;

procedure TjdxContextMenu.Set_selectionRequired(const Value: boolean);
begin
  FselectionRequired := Value;
end;

procedure TjdxContextMenu.Set_selectOnFocus(const Value: boolean);
begin
  FselectOnFocus := Value;
end;

procedure TjdxContextMenu.Set_showEvent(const Value: TJSObject);
begin
  FshowEvent := Value;
end;

procedure TjdxContextMenu.Set_showSubmenuMode(const Value: TJSObject);
begin
  FshowSubmenuMode := Value;
end;

procedure TjdxContextMenu.Set_submenuDirection(const Value: TdxContextSubmenuDirection);
begin
  FsubmenuDirection := Value;
end;

procedure TjdxContextMenu.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxContextMenu.Set_target(const Value: JSValue);
begin
  Ftarget := Value;
end;

procedure TjdxContextMenu.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxContextMenu.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxContextMenu.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxContextMenu.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxContextMenu.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxContextMenu.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxContextMenu.Set_onHidden(const Value: TdxEventHandler);
begin
  FonHidden := Value;
end;

procedure TjdxContextMenu.Set_onHiding(const Value: TdxEventHandler);
begin
  FonHiding := Value;
end;

procedure TjdxContextMenu.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxContextMenu.Set_onItemClick(const Value: TdxEventHandler);
begin
  FonItemClick := Value;
end;

procedure TjdxContextMenu.Set_onItemContextMenu(const Value: TdxEventHandler);
begin
  FonItemContextMenu := Value;
end;

procedure TjdxContextMenu.Set_onItemDeleted(const Value: TdxEventHandler);
begin
  FonItemDeleted := Value;
end;

procedure TjdxContextMenu.Set_onItemDeleting(const Value: TdxEventHandler);
begin
  FonItemDeleting := Value;
end;

procedure TjdxContextMenu.Set_onItemHold(const Value: TdxEventHandler);
begin
  FonItemHold := Value;
end;

procedure TjdxContextMenu.Set_onItemRendered(const Value: TdxEventHandler);
begin
  FonItemRendered := Value;
end;

procedure TjdxContextMenu.Set_onItemReordered(const Value: TdxEventHandler);
begin
  FonItemReordered := Value;
end;

procedure TjdxContextMenu.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxContextMenu.Set_onPositioning(const Value: TdxEventHandler);
begin
  FonPositioning := Value;
end;

procedure TjdxContextMenu.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
end;

procedure TjdxContextMenu.Set_onShowing(const Value: TdxEventHandler);
begin
  FonShowing := Value;
end;

procedure TjdxContextMenu.Set_onShown(const Value: TdxEventHandler);
begin
  FonShown := Value;
end;

end.
