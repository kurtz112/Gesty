unit DevExtreme.FileManager;

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
  TjdxFileManager = class(TjdxCustomControl)
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
  public
    constructor Create(aOwner: TComponent); override;
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


constructor TjdxFileManager.Create(aOwner: TComponent);
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

procedure TjdxFileManager.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxFileManager.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxFileManager.Set_allowedFileExtensions(const Value: TJSArray);
begin
  FallowedFileExtensions := Value;
end;

procedure TjdxFileManager.Set_contextMenu(const Value: TJSObject);
begin
  FcontextMenu := Value;
end;

procedure TjdxFileManager.Set_currentPath(const Value: string);
begin
  FcurrentPath := Value;
end;

procedure TjdxFileManager.Set_currentPathKeys(const Value: TJSArray);
begin
  FcurrentPathKeys := Value;
end;

procedure TjdxFileManager.Set_customizeDetailColumns(const Value: TJSFunction);
begin
  FcustomizeDetailColumns := Value;
end;

procedure TjdxFileManager.Set_customizeThumbnail(const Value: TJSFunction);
begin
  FcustomizeThumbnail := Value;
end;

procedure TjdxFileManager.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxFileManager.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxFileManager.Set_fileSystemProvider(const Value: JSValue);
begin
  FfileSystemProvider := Value;
end;

procedure TjdxFileManager.Set_focusedItemKey(const Value: string);
begin
  FfocusedItemKey := Value;
end;

procedure TjdxFileManager.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxFileManager.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxFileManager.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxFileManager.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxFileManager.Set_itemView(const Value: TJSObject);
begin
  FitemView := Value;
end;

procedure TjdxFileManager.Set_notifications(const Value: TJSObject);
begin
  Fnotifications := Value;
end;

procedure TjdxFileManager.Set_permissions(const Value: TJSObject);
begin
  Fpermissions := Value;
end;

procedure TjdxFileManager.Set_rootFolderName(const Value: string);
begin
  FrootFolderName := Value;
end;

procedure TjdxFileManager.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxFileManager.Set_selectedItemKeys(const Value: TJSArray);
begin
  FselectedItemKeys := Value;
end;

procedure TjdxFileManager.Set_selectionMode(const Value: TdxSingleOrMultiple);
begin
  FselectionMode := Value;
end;

procedure TjdxFileManager.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxFileManager.Set_toolbar(const Value: TJSObject);
begin
  Ftoolbar := Value;
end;

procedure TjdxFileManager.Set_upload(const Value: TJSObject);
begin
  Fupload := Value;
end;

procedure TjdxFileManager.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxFileManager.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxFileManager.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxFileManager.Set_onContextMenuItemClick(const Value: TdxEventHandler);
begin
  FonContextMenuItemClick := Value;
end;

procedure TjdxFileManager.Set_onContextMenuShowing(const Value: TdxEventHandler);
begin
  FonContextMenuShowing := Value;
end;

procedure TjdxFileManager.Set_onCurrentDirectoryChanged(const Value: TdxEventHandler);
begin
  FonCurrentDirectoryChanged := Value;
end;

procedure TjdxFileManager.Set_onDirectoryCreated(const Value: TdxEventHandler);
begin
  FonDirectoryCreated := Value;
end;

procedure TjdxFileManager.Set_onDirectoryCreating(const Value: TdxEventHandler);
begin
  FonDirectoryCreating := Value;
end;

procedure TjdxFileManager.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxFileManager.Set_onErrorOccurred(const Value: TdxEventHandler);
begin
  FonErrorOccurred := Value;
end;

procedure TjdxFileManager.Set_onFileUploaded(const Value: TdxEventHandler);
begin
  FonFileUploaded := Value;
end;

procedure TjdxFileManager.Set_onFileUploading(const Value: TdxEventHandler);
begin
  FonFileUploading := Value;
end;

procedure TjdxFileManager.Set_onFocusedItemChanged(const Value: TdxEventHandler);
begin
  FonFocusedItemChanged := Value;
end;

procedure TjdxFileManager.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxFileManager.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxFileManager.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxFileManager.Set_onItemCopied(const Value: TdxEventHandler);
begin
  FonItemCopied := Value;
end;

procedure TjdxFileManager.Set_onItemCopying(const Value: TdxEventHandler);
begin
  FonItemCopying := Value;
end;

procedure TjdxFileManager.Set_onItemDeleted(const Value: TdxEventHandler);
begin
  FonItemDeleted := Value;
end;

procedure TjdxFileManager.Set_onItemDeleting(const Value: TdxEventHandler);
begin
  FonItemDeleting := Value;
end;

procedure TjdxFileManager.Set_onItemDownloading(const Value: TdxEventHandler);
begin
  FonItemDownloading := Value;
end;

procedure TjdxFileManager.Set_onItemMoved(const Value: TdxEventHandler);
begin
  FonItemMoved := Value;
end;

procedure TjdxFileManager.Set_onItemMoving(const Value: TdxEventHandler);
begin
  FonItemMoving := Value;
end;

procedure TjdxFileManager.Set_onItemRenamed(const Value: TdxEventHandler);
begin
  FonItemRenamed := Value;
end;

procedure TjdxFileManager.Set_onItemRenaming(const Value: TdxEventHandler);
begin
  FonItemRenaming := Value;
end;

procedure TjdxFileManager.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxFileManager.Set_onSelectedFileOpened(const Value: TdxEventHandler);
begin
  FonSelectedFileOpened := Value;
end;

procedure TjdxFileManager.Set_onSelectionChanged(const Value: TdxEventHandler);
begin
  FonSelectionChanged := Value;
end;

procedure TjdxFileManager.Set_onToolbarItemClick(const Value: TdxEventHandler);
begin
  FonToolbarItemClick := Value;
end;

end.
