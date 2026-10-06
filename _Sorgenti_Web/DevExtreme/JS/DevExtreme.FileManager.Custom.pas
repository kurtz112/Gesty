unit DevExtreme.FileManager.Custom;

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
  DevExtreme.FileManager.JS,
  DevExtreme.Types;

type
  TjdxCustomFileManager = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FallowedFileExtensions: TJSArray;
    FcontextMenu: TJSObject;
    FcurrentPath: string;
    FcurrentPathKeys: TJSArray;
    FcustomizeDetailColumns: TJSFunction;
    FcustomizeThumbnail: TJSFunction;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfileSystemProvider: JSValue;
    FfocusedItemKey: string;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FitemView: TJSObject;
    Fnotifications: TJSObject;
    Fpermissions: TJSObject;
    FrootFolderName: string;
    FrtlEnabled: boolean;
    FselectedItemKeys: TJSArray;
    FselectionMode: TdxSingleOrMultiple;
    FtabIndex: integer;
    Ftoolbar: TJSObject;
    Fupload: TJSObject;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonContextMenuItemClick: TdxEventHandler;
    FonContextMenuShowing: TdxEventHandler;
    FonCurrentDirectoryChanged: TdxEventHandler;
    FonDirectoryCreated: TdxEventHandler;
    FonDirectoryCreating: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonErrorOccurred: TdxEventHandler;
    FonFileUploaded: TdxEventHandler;
    FonFileUploading: TdxEventHandler;
    FonFocusedItemChanged: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonItemCopied: TdxEventHandler;
    FonItemCopying: TdxEventHandler;
    FonItemDeleted: TdxEventHandler;
    FonItemDeleting: TdxEventHandler;
    FonItemDownloading: TdxEventHandler;
    FonItemMoved: TdxEventHandler;
    FonItemMoving: TdxEventHandler;
    FonItemRenamed: TdxEventHandler;
    FonItemRenaming: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonSelectedFileOpened: TdxEventHandler;
    FonSelectionChanged: TdxEventHandler;
    FonToolbarItemClick: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_allowedFileExtensions(const value: TJSArray);
    procedure Set_contextMenu(const value: TJSObject);
    procedure Set_currentPath(const value: string);
    procedure Set_currentPathKeys(const value: TJSArray);
    procedure Set_customizeDetailColumns(const value: TJSFunction);
    procedure Set_customizeThumbnail(const value: TJSFunction);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_fileSystemProvider(const value: JSValue);
    procedure Set_focusedItemKey(const value: string);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_itemView(const value: TJSObject);
    procedure Set_notifications(const value: TJSObject);
    procedure Set_permissions(const value: TJSObject);
    procedure Set_rootFolderName(const value: string);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_selectedItemKeys(const value: TJSArray);
    procedure Set_selectionMode(const value: TdxSingleOrMultiple);
    procedure Set_tabIndex(const value: integer);
    procedure Set_toolbar(const value: TJSObject);
    procedure Set_upload(const value: TJSObject);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onContextMenuItemClick(const value: TdxEventHandler);
    procedure Set_onContextMenuShowing(const value: TdxEventHandler);
    procedure Set_onCurrentDirectoryChanged(const value: TdxEventHandler);
    procedure Set_onDirectoryCreated(const value: TdxEventHandler);
    procedure Set_onDirectoryCreating(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onErrorOccurred(const value: TdxEventHandler);
    procedure Set_onFileUploaded(const value: TdxEventHandler);
    procedure Set_onFileUploading(const value: TdxEventHandler);
    procedure Set_onFocusedItemChanged(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onItemCopied(const value: TdxEventHandler);
    procedure Set_onItemCopying(const value: TdxEventHandler);
    procedure Set_onItemDeleted(const value: TdxEventHandler);
    procedure Set_onItemDeleting(const value: TdxEventHandler);
    procedure Set_onItemDownloading(const value: TdxEventHandler);
    procedure Set_onItemMoved(const value: TdxEventHandler);
    procedure Set_onItemMoving(const value: TdxEventHandler);
    procedure Set_onItemRenamed(const value: TdxEventHandler);
    procedure Set_onItemRenaming(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onSelectedFileOpened(const value: TdxEventHandler);
    procedure Set_onSelectionChanged(const value: TdxEventHandler);
    procedure Set_onToolbarItemClick(const value: TdxEventHandler);
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxFileManager; assembler;
    function instance: TdxFileManager; assembler;
  public
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler;
    function getCurrentDirectory(): TJSObject; assembler;
    function getSelectedItems(): TJSArray; assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function option(): TJSObject; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    function refresh(): TJSPromise; assembler;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure repaint(); assembler;
    procedure resetOption(optionName: string); assembler;
  public
    property allowedFileExtensions: TJSArray read FallowedFileExtensions write Set_allowedFileExtensions;
    property contextMenu: TJSObject read FcontextMenu write Set_contextMenu;
    property currentPathKeys: TJSArray read FcurrentPathKeys write Set_currentPathKeys;
    property customizeDetailColumns: TJSFunction read FcustomizeDetailColumns write Set_customizeDetailColumns;
    property customizeThumbnail: TJSFunction read FcustomizeThumbnail write Set_customizeThumbnail;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property fileSystemProvider: JSValue read FfileSystemProvider write Set_fileSystemProvider;
    property height_: JSValue read Fheight_ write Set_height_;
    property itemView: TJSObject read FitemView write Set_itemView;
    property notifications: TJSObject read Fnotifications write Set_notifications;
    property permissions: TJSObject read Fpermissions write Set_permissions;
    property selectedItemKeys: TJSArray read FselectedItemKeys write Set_selectedItemKeys;
    property toolbar: TJSObject read Ftoolbar write Set_toolbar;
    property upload: TJSObject read Fupload write Set_upload;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property currentPath: string read FcurrentPath write Set_currentPath;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusedItemKey: string read FfocusedItemKey write Set_focusedItemKey;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property rootFolderName: string read FrootFolderName write Set_rootFolderName;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property selectionMode: TdxSingleOrMultiple read FselectionMode write Set_selectionMode default somMultiple;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onContextMenuItemClick: TdxEventHandler read FonContextMenuItemClick write Set_onContextMenuItemClick;
    property onContextMenuShowing: TdxEventHandler read FonContextMenuShowing write Set_onContextMenuShowing;
    property onCurrentDirectoryChanged: TdxEventHandler read FonCurrentDirectoryChanged write Set_onCurrentDirectoryChanged;
    property onDirectoryCreated: TdxEventHandler read FonDirectoryCreated write Set_onDirectoryCreated;
    property onDirectoryCreating: TdxEventHandler read FonDirectoryCreating write Set_onDirectoryCreating;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onErrorOccurred: TdxEventHandler read FonErrorOccurred write Set_onErrorOccurred;
    property onFileUploaded: TdxEventHandler read FonFileUploaded write Set_onFileUploaded;
    property onFileUploading: TdxEventHandler read FonFileUploading write Set_onFileUploading;
    property onFocusedItemChanged: TdxEventHandler read FonFocusedItemChanged write Set_onFocusedItemChanged;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onItemCopied: TdxEventHandler read FonItemCopied write Set_onItemCopied;
    property onItemCopying: TdxEventHandler read FonItemCopying write Set_onItemCopying;
    property onItemDeleted: TdxEventHandler read FonItemDeleted write Set_onItemDeleted;
    property onItemDeleting: TdxEventHandler read FonItemDeleting write Set_onItemDeleting;
    property onItemDownloading: TdxEventHandler read FonItemDownloading write Set_onItemDownloading;
    property onItemMoved: TdxEventHandler read FonItemMoved write Set_onItemMoved;
    property onItemMoving: TdxEventHandler read FonItemMoving write Set_onItemMoving;
    property onItemRenamed: TdxEventHandler read FonItemRenamed write Set_onItemRenamed;
    property onItemRenaming: TdxEventHandler read FonItemRenaming write Set_onItemRenaming;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onSelectedFileOpened: TdxEventHandler read FonSelectedFileOpened write Set_onSelectedFileOpened;
    property onSelectionChanged: TdxEventHandler read FonSelectionChanged write Set_onSelectionChanged;
    property onToolbarItemClick: TdxEventHandler read FonToolbarItemClick write Set_onToolbarItemClick;
  end;

implementation


procedure TjdxCustomFileManager.CreateInitialize;
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FallowedFileExtensions := TJSArray.new;
  FcontextMenu := TJSObject.new;
  FcurrentPath := '';
  FcurrentPathKeys := TJSArray.new;
  FcustomizeDetailColumns := nil;
  FcustomizeThumbnail := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfileSystemProvider := nil;
  FfocusedItemKey := '';
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FitemView := TJSObject.new;
  Fnotifications := TJSObject.new;
  Fpermissions := TJSObject.new;
  FrootFolderName := '';
  FrtlEnabled := false;
  FselectedItemKeys := TJSArray.new;
  FselectionMode := somMultiple;
  FtabIndex := 0;
  Ftoolbar := TJSObject.new;
  Fupload := TJSObject.new;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonContextMenuItemClick := nil;
  FonContextMenuShowing := nil;
  FonCurrentDirectoryChanged := nil;
  FonDirectoryCreated := nil;
  FonDirectoryCreating := nil;
  FonDisposing := nil;
  FonErrorOccurred := nil;
  FonFileUploaded := nil;
  FonFileUploading := nil;
  FonFocusedItemChanged := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonItemCopied := nil;
  FonItemCopying := nil;
  FonItemDeleted := nil;
  FonItemDeleting := nil;
  FonItemDownloading := nil;
  FonItemMoved := nil;
  FonItemMoving := nil;
  FonItemRenamed := nil;
  FonItemRenaming := nil;
  FonOptionChanged := nil;
  FonSelectedFileOpened := nil;
  FonSelectionChanged := nil;
  FonToolbarItemClick := nil;
end;
procedure TjdxCustomFileManager.InitJQuery;
var
  id: string;
  options: TJSObject;
begin
  inherited;

  if Assigned(ElementHandle) then
  begin
    id := GetJQID;
    options := TJSObject.new;

    asm
      $(id).dxFileManager(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomFileManager.getInstance(element: TJSObject): TdxFileManager;
asm
  return DevExpress.viz.dxFileManager.getInstance(element);
end;

function TjdxCustomFileManager.instance: TdxFileManager;
asm
  return $(this.GetJQID()).dxFileManager("instance");
end;
procedure TjdxCustomFileManager.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('allowedFileExtensions', allowedFileExtensions);
    SetOption('contextMenu', contextMenu);
    SetOption('currentPath', currentPath);
    SetOption('currentPathKeys', currentPathKeys);
    SetOption('customizeDetailColumns', customizeDetailColumns);
    SetOption('customizeThumbnail', customizeThumbnail);
    SetOption('disabled', disabled);
    SetOption('elementAttr', elementAttr);
    SetOption('fileSystemProvider', fileSystemProvider);
    SetOption('focusedItemKey', focusedItemKey);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('itemView', itemView);
    SetOption('notifications', notifications);
    SetOption('permissions', permissions);
    SetOption('rootFolderName', rootFolderName);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('selectedItemKeys', selectedItemKeys);
    SetOption('selectionMode', selectionMode.ToString());
    SetOption('tabIndex', tabIndex);
    SetOption('toolbar', toolbar);
    SetOption('upload', upload);
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('contentReady', onContentReady);
    SetEvent('contextMenuItemClick', onContextMenuItemClick);
    SetEvent('contextMenuShowing', onContextMenuShowing);
    SetEvent('currentDirectoryChanged', onCurrentDirectoryChanged);
    SetEvent('directoryCreated', onDirectoryCreated);
    SetEvent('directoryCreating', onDirectoryCreating);
    SetEvent('disposing', onDisposing);
    SetEvent('errorOccurred', onErrorOccurred);
    SetEvent('fileUploaded', onFileUploaded);
    SetEvent('fileUploading', onFileUploading);
    SetEvent('focusedItemChanged', onFocusedItemChanged);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('itemCopied', onItemCopied);
    SetEvent('itemCopying', onItemCopying);
    SetEvent('itemDeleted', onItemDeleted);
    SetEvent('itemDeleting', onItemDeleting);
    SetEvent('itemDownloading', onItemDownloading);
    SetEvent('itemMoved', onItemMoved);
    SetEvent('itemMoving', onItemMoving);
    SetEvent('itemRenamed', onItemRenamed);
    SetEvent('itemRenaming', onItemRenaming);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('selectedFileOpened', onSelectedFileOpened);
    SetEvent('selectionChanged', onSelectionChanged);
    SetEvent('toolbarItemClick', onToolbarItemClick);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomFileManager.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomFileManager.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomFileManager.Set_allowedFileExtensions(const Value: TJSArray);
begin
  FallowedFileExtensions := Value;
  SetOption('allowedFileExtensions', allowedFileExtensions);
end;

procedure TjdxCustomFileManager.Set_contextMenu(const Value: TJSObject);
begin
  FcontextMenu := Value;
  SetOption('contextMenu', contextMenu);
end;

procedure TjdxCustomFileManager.Set_currentPath(const Value: string);
begin
  FcurrentPath := Value;
  SetOption('currentPath', currentPath);
end;

procedure TjdxCustomFileManager.Set_currentPathKeys(const Value: TJSArray);
begin
  FcurrentPathKeys := Value;
  SetOption('currentPathKeys', currentPathKeys);
end;

procedure TjdxCustomFileManager.Set_customizeDetailColumns(const Value: TJSFunction);
begin
  FcustomizeDetailColumns := Value;
  SetOption('customizeDetailColumns', customizeDetailColumns);
end;

procedure TjdxCustomFileManager.Set_customizeThumbnail(const Value: TJSFunction);
begin
  FcustomizeThumbnail := Value;
  SetOption('customizeThumbnail', customizeThumbnail);
end;

procedure TjdxCustomFileManager.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomFileManager.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomFileManager.Set_fileSystemProvider(const Value: JSValue);
begin
  FfileSystemProvider := Value;
  SetOption('fileSystemProvider', fileSystemProvider);
end;

procedure TjdxCustomFileManager.Set_focusedItemKey(const Value: string);
begin
  FfocusedItemKey := Value;
  SetOption('focusedItemKey', focusedItemKey);
end;

procedure TjdxCustomFileManager.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomFileManager.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomFileManager.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomFileManager.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomFileManager.Set_itemView(const Value: TJSObject);
begin
  FitemView := Value;
  SetOption('itemView', itemView);
end;

procedure TjdxCustomFileManager.Set_notifications(const Value: TJSObject);
begin
  Fnotifications := Value;
  SetOption('notifications', notifications);
end;

procedure TjdxCustomFileManager.Set_permissions(const Value: TJSObject);
begin
  Fpermissions := Value;
  SetOption('permissions', permissions);
end;

procedure TjdxCustomFileManager.Set_rootFolderName(const Value: string);
begin
  FrootFolderName := Value;
  SetOption('rootFolderName', rootFolderName);
end;

procedure TjdxCustomFileManager.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomFileManager.Set_selectedItemKeys(const Value: TJSArray);
begin
  FselectedItemKeys := Value;
  SetOption('selectedItemKeys', selectedItemKeys);
end;

procedure TjdxCustomFileManager.Set_selectionMode(const Value: TdxSingleOrMultiple);
begin
  FselectionMode := Value;
  SetOption('selectionMode', selectionMode.ToString());
end;

procedure TjdxCustomFileManager.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomFileManager.Set_toolbar(const Value: TJSObject);
begin
  Ftoolbar := Value;
  SetOption('toolbar', toolbar);
end;

procedure TjdxCustomFileManager.Set_upload(const Value: TJSObject);
begin
  Fupload := Value;
  SetOption('upload', upload);
end;

procedure TjdxCustomFileManager.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomFileManager.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomFileManager.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomFileManager.Set_onContextMenuItemClick(const Value: TdxEventHandler);
begin
  FonContextMenuItemClick := Value;
  SetEvent('contextMenuItemClick', onContextMenuItemClick);
end;

procedure TjdxCustomFileManager.Set_onContextMenuShowing(const Value: TdxEventHandler);
begin
  FonContextMenuShowing := Value;
  SetEvent('contextMenuShowing', onContextMenuShowing);
end;

procedure TjdxCustomFileManager.Set_onCurrentDirectoryChanged(const Value: TdxEventHandler);
begin
  FonCurrentDirectoryChanged := Value;
  SetEvent('currentDirectoryChanged', onCurrentDirectoryChanged);
end;

procedure TjdxCustomFileManager.Set_onDirectoryCreated(const Value: TdxEventHandler);
begin
  FonDirectoryCreated := Value;
  SetEvent('directoryCreated', onDirectoryCreated);
end;

procedure TjdxCustomFileManager.Set_onDirectoryCreating(const Value: TdxEventHandler);
begin
  FonDirectoryCreating := Value;
  SetEvent('directoryCreating', onDirectoryCreating);
end;

procedure TjdxCustomFileManager.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomFileManager.Set_onErrorOccurred(const Value: TdxEventHandler);
begin
  FonErrorOccurred := Value;
  SetEvent('errorOccurred', onErrorOccurred);
end;

procedure TjdxCustomFileManager.Set_onFileUploaded(const Value: TdxEventHandler);
begin
  FonFileUploaded := Value;
  SetEvent('fileUploaded', onFileUploaded);
end;

procedure TjdxCustomFileManager.Set_onFileUploading(const Value: TdxEventHandler);
begin
  FonFileUploading := Value;
  SetEvent('fileUploading', onFileUploading);
end;

procedure TjdxCustomFileManager.Set_onFocusedItemChanged(const Value: TdxEventHandler);
begin
  FonFocusedItemChanged := Value;
  SetEvent('focusedItemChanged', onFocusedItemChanged);
end;

procedure TjdxCustomFileManager.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomFileManager.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomFileManager.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomFileManager.Set_onItemCopied(const Value: TdxEventHandler);
begin
  FonItemCopied := Value;
  SetEvent('itemCopied', onItemCopied);
end;

procedure TjdxCustomFileManager.Set_onItemCopying(const Value: TdxEventHandler);
begin
  FonItemCopying := Value;
  SetEvent('itemCopying', onItemCopying);
end;

procedure TjdxCustomFileManager.Set_onItemDeleted(const Value: TdxEventHandler);
begin
  FonItemDeleted := Value;
  SetEvent('itemDeleted', onItemDeleted);
end;

procedure TjdxCustomFileManager.Set_onItemDeleting(const Value: TdxEventHandler);
begin
  FonItemDeleting := Value;
  SetEvent('itemDeleting', onItemDeleting);
end;

procedure TjdxCustomFileManager.Set_onItemDownloading(const Value: TdxEventHandler);
begin
  FonItemDownloading := Value;
  SetEvent('itemDownloading', onItemDownloading);
end;

procedure TjdxCustomFileManager.Set_onItemMoved(const Value: TdxEventHandler);
begin
  FonItemMoved := Value;
  SetEvent('itemMoved', onItemMoved);
end;

procedure TjdxCustomFileManager.Set_onItemMoving(const Value: TdxEventHandler);
begin
  FonItemMoving := Value;
  SetEvent('itemMoving', onItemMoving);
end;

procedure TjdxCustomFileManager.Set_onItemRenamed(const Value: TdxEventHandler);
begin
  FonItemRenamed := Value;
  SetEvent('itemRenamed', onItemRenamed);
end;

procedure TjdxCustomFileManager.Set_onItemRenaming(const Value: TdxEventHandler);
begin
  FonItemRenaming := Value;
  SetEvent('itemRenaming', onItemRenaming);
end;

procedure TjdxCustomFileManager.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomFileManager.Set_onSelectedFileOpened(const Value: TdxEventHandler);
begin
  FonSelectedFileOpened := Value;
  SetEvent('selectedFileOpened', onSelectedFileOpened);
end;

procedure TjdxCustomFileManager.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
  SetEvent('selectionChanged', onSelectionChanged);
end;

procedure TjdxCustomFileManager.Set_onToolbarItemClick(const Value: TdxEventHandler);
begin
  FonToolbarItemClick := Value;
  SetEvent('toolbarItemClick', onToolbarItemClick);
end;

procedure TjdxCustomFileManager.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomFileManager.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomFileManager.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomFileManager.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomFileManager.dispose();
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  _instance.dispose();
end;

function TjdxCustomFileManager.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  return _instance.element();
end;

procedure TjdxCustomFileManager.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomFileManager.focus();
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  _instance.focus();
end;

function TjdxCustomFileManager.getCurrentDirectory(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  return _instance.getCurrentDirectory();
end;

function TjdxCustomFileManager.getSelectedItems(): TJSArray;
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  return _instance.getSelectedItems();
end;

function TjdxCustomFileManager.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomFileManager.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  return _instance.off(eventName);
end;

function TjdxCustomFileManager.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomFileManager.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  return _instance.on(events);
end;

function TjdxCustomFileManager.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  return _instance.option();
end;

function TjdxCustomFileManager.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  return _instance.option(optionName);
end;

procedure TjdxCustomFileManager.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomFileManager.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  _instance.option(options);
end;

function TjdxCustomFileManager.refresh(): TJSPromise;
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  return _instance.refresh();
end;

procedure TjdxCustomFileManager.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomFileManager.repaint();
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  _instance.repaint();
end;

procedure TjdxCustomFileManager.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxFileManager("instance");
  _instance.resetOption(optionName);
end;

end.
