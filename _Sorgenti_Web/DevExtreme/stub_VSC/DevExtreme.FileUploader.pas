unit DevExtreme.FileUploader;

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
  TjdxFileUploader = class(TjdxCustomControl)
  private
    FabortUpload: TJSFunction;
    Faccept: string;
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FallowCanceling: boolean;
    FallowedFileExtensions: TJSArray;
    FchunkSize: integer;
    FdialogTrigger: JSValue;
    Fdisabled: boolean;
    FdropZone: JSValue;
    FelementAttr: TJSObject;
    FextendSelection: boolean;
    FfocusStateEnabled: boolean;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FinputAttr: JSValue;
    FinvalidFileExtensionMessage: string;
    FinvalidMaxFileSizeMessage: string;
    FinvalidMinFileSizeMessage: string;
    FisValid: boolean;
    FlabelText: string;
    FmaxFileSize: integer;
    FminFileSize: integer;
    Fmultiple: boolean;
    Fname_: string;
    Fprogress: integer;
    FreadOnly: boolean;
    FreadyToUploadMessage: string;
    FrtlEnabled: boolean;
    FselectButtonText: string;
    FshowFileList: boolean;
    FstylingMode: TdxEditorStyle;
    FtabIndex: integer;
    FuploadAbortedMessage: string;
    FuploadButtonText: string;
    FuploadChunk: TJSFunction;
    FuploadCustomData: JSValue;
    FuploadedMessage: string;
    FuploadFailedMessage: string;
    FuploadFile: TJSFunction;
    FuploadHeaders: JSValue;
    FuploadMethod: TdxUploadHttpMethod;
    FuploadMode: TdxFileUploadMode;
    FuploadUrl: string;
    FvalidationError: JSValue;
    FvalidationErrors: TJSArray;
    FvalidationMessageMode: TdxValidationMessageMode;
    FvalidationMessagePosition: TdxPosition;
    FvalidationStatus: TdxValidationStatus;
    Fvalue: JSValue;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonBeforeSend: TdxEventHandler;
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonDropZoneEnter: TdxEventHandler;
    FonDropZoneLeave: TdxEventHandler;
    FonFilesUploaded: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonProgress: TdxEventHandler;
    FonUploadAborted: TdxEventHandler;
    FonUploaded: TdxEventHandler;
    FonUploadError: TdxEventHandler;
    FonUploadStarted: TdxEventHandler;
    FonValueChanged: TdxEventHandler;
  private
    procedure Set_abortUpload(const value: TJSFunction);
    procedure Set_accept(const value: string);
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_allowCanceling(const value: boolean);
    procedure Set_allowedFileExtensions(const value: TJSArray);
    procedure Set_chunkSize(const value: integer);
    procedure Set_dialogTrigger(const value: JSValue);
    procedure Set_disabled(const value: boolean);
    procedure Set_dropZone(const value: JSValue);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_extendSelection(const value: boolean);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_inputAttr(const value: JSValue);
    procedure Set_invalidFileExtensionMessage(const value: string);
    procedure Set_invalidMaxFileSizeMessage(const value: string);
    procedure Set_invalidMinFileSizeMessage(const value: string);
    procedure Set_isValid(const value: boolean);
    procedure Set_labelText(const value: string);
    procedure Set_maxFileSize(const value: integer);
    procedure Set_minFileSize(const value: integer);
    procedure Set_multiple(const value: boolean);
    procedure Set_name_(const value: string);
    procedure Set_progress(const value: integer);
    procedure Set_readOnly(const value: boolean);
    procedure Set_readyToUploadMessage(const value: string);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_selectButtonText(const value: string);
    procedure Set_showFileList(const value: boolean);
    procedure Set_stylingMode(const value: TdxEditorStyle);
    procedure Set_tabIndex(const value: integer);
    procedure Set_uploadAbortedMessage(const value: string);
    procedure Set_uploadButtonText(const value: string);
    procedure Set_uploadChunk(const value: TJSFunction);
    procedure Set_uploadCustomData(const value: JSValue);
    procedure Set_uploadedMessage(const value: string);
    procedure Set_uploadFailedMessage(const value: string);
    procedure Set_uploadFile(const value: TJSFunction);
    procedure Set_uploadHeaders(const value: JSValue);
    procedure Set_uploadMethod(const value: TdxUploadHttpMethod);
    procedure Set_uploadMode(const value: TdxFileUploadMode);
    procedure Set_uploadUrl(const value: string);
    procedure Set_validationError(const value: JSValue);
    procedure Set_validationErrors(const value: TJSArray);
    procedure Set_validationMessageMode(const value: TdxValidationMessageMode);
    procedure Set_validationMessagePosition(const value: TdxPosition);
    procedure Set_validationStatus(const value: TdxValidationStatus);
    procedure Set_value(const value: JSValue);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onBeforeSend(const value: TdxEventHandler);
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onDropZoneEnter(const value: TdxEventHandler);
    procedure Set_onDropZoneLeave(const value: TdxEventHandler);
    procedure Set_onFilesUploaded(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onProgress(const value: TdxEventHandler);
    procedure Set_onUploadAborted(const value: TdxEventHandler);
    procedure Set_onUploaded(const value: TdxEventHandler);
    procedure Set_onUploadError(const value: TdxEventHandler);
    procedure Set_onUploadStarted(const value: TdxEventHandler);
    procedure Set_onValueChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property abortUpload: TJSFunction read FabortUpload write Set_abortUpload;
    property allowedFileExtensions: TJSArray read FallowedFileExtensions write Set_allowedFileExtensions;
    property dialogTrigger: JSValue read FdialogTrigger write Set_dialogTrigger;
    property dropZone: JSValue read FdropZone write Set_dropZone;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property height_: JSValue read Fheight_ write Set_height_;
    property inputAttr: JSValue read FinputAttr write Set_inputAttr;
    property uploadChunk: TJSFunction read FuploadChunk write Set_uploadChunk;
    property uploadCustomData: JSValue read FuploadCustomData write Set_uploadCustomData;
    property uploadFile: TJSFunction read FuploadFile write Set_uploadFile;
    property uploadHeaders: JSValue read FuploadHeaders write Set_uploadHeaders;
    property validationError: JSValue read FvalidationError write Set_validationError;
    property validationErrors: TJSArray read FvalidationErrors write Set_validationErrors;
    property value: JSValue read Fvalue write Set_value;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accept: string read Faccept write Set_accept;
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property allowCanceling: boolean read FallowCanceling write Set_allowCanceling default true;
    property chunkSize: integer read FchunkSize write Set_chunkSize;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property extendSelection: boolean read FextendSelection write Set_extendSelection default true;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property invalidFileExtensionMessage: string read FinvalidFileExtensionMessage write Set_invalidFileExtensionMessage;
    property invalidMaxFileSizeMessage: string read FinvalidMaxFileSizeMessage write Set_invalidMaxFileSizeMessage;
    property invalidMinFileSizeMessage: string read FinvalidMinFileSizeMessage write Set_invalidMinFileSizeMessage;
    property isValid: boolean read FisValid write Set_isValid default true;
    property labelText: string read FlabelText write Set_labelText;
    property maxFileSize: integer read FmaxFileSize write Set_maxFileSize;
    property minFileSize: integer read FminFileSize write Set_minFileSize;
    property multiple: boolean read Fmultiple write Set_multiple default false;
    property name_: string read Fname_ write Set_name_;
    property progress: integer read Fprogress write Set_progress;
    property readOnly: boolean read FreadOnly write Set_readOnly default false;
    property readyToUploadMessage: string read FreadyToUploadMessage write Set_readyToUploadMessage;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property selectButtonText: string read FselectButtonText write Set_selectButtonText;
    property showFileList: boolean read FshowFileList write Set_showFileList default true;
    property stylingMode: TdxEditorStyle read FstylingMode write Set_stylingMode default esOutlined;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property uploadAbortedMessage: string read FuploadAbortedMessage write Set_uploadAbortedMessage;
    property uploadButtonText: string read FuploadButtonText write Set_uploadButtonText;
    property uploadedMessage: string read FuploadedMessage write Set_uploadedMessage;
    property uploadFailedMessage: string read FuploadFailedMessage write Set_uploadFailedMessage;
    property uploadMethod: TdxUploadHttpMethod read FuploadMethod write Set_uploadMethod default uhmPOST;
    property uploadMode: TdxFileUploadMode read FuploadMode write Set_uploadMode default fumInstantly;
    property uploadUrl: string read FuploadUrl write Set_uploadUrl;
    property validationMessageMode: TdxValidationMessageMode read FvalidationMessageMode write Set_validationMessageMode default vmmAuto;
    property validationMessagePosition: TdxPosition read FvalidationMessagePosition write Set_validationMessagePosition default pBottom;
    property validationStatus: TdxValidationStatus read FvalidationStatus write Set_validationStatus default vsValid;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onBeforeSend: TdxEventHandler read FonBeforeSend write Set_onBeforeSend;
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onDropZoneEnter: TdxEventHandler read FonDropZoneEnter write Set_onDropZoneEnter;
    property onDropZoneLeave: TdxEventHandler read FonDropZoneLeave write Set_onDropZoneLeave;
    property onFilesUploaded: TdxEventHandler read FonFilesUploaded write Set_onFilesUploaded;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onProgress: TdxEventHandler read FonProgress write Set_onProgress;
    property onUploadAborted: TdxEventHandler read FonUploadAborted write Set_onUploadAborted;
    property onUploaded: TdxEventHandler read FonUploaded write Set_onUploaded;
    property onUploadError: TdxEventHandler read FonUploadError write Set_onUploadError;
    property onUploadStarted: TdxEventHandler read FonUploadStarted write Set_onUploadStarted;
    property onValueChanged: TdxEventHandler read FonValueChanged write Set_onValueChanged;
  end;

implementation


constructor TjdxFileUploader.Create(aOwner: TComponent);
begin
  inherited;
  FabortUpload := nil;
  Faccept := '';
  FaccessKey := '';
  FactiveStateEnabled := false;
  FallowCanceling := true;
  FallowedFileExtensions := TJSArray.new;
  FchunkSize := 0;
  FdialogTrigger := nil;
  Fdisabled := false;
  FdropZone := nil;
  FelementAttr := TJSObject.new;
  FextendSelection := true;
  FfocusStateEnabled := false;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FinputAttr := nil;
  FinvalidFileExtensionMessage := '';
  FinvalidMaxFileSizeMessage := '';
  FinvalidMinFileSizeMessage := '';
  FisValid := true;
  FlabelText := '';
  FmaxFileSize := 0;
  FminFileSize := 0;
  Fmultiple := false;
  Fname_ := '';
  Fprogress := 0;
  FreadOnly := false;
  FreadyToUploadMessage := '';
  FrtlEnabled := false;
  FselectButtonText := '';
  FshowFileList := true;
  FstylingMode := esOutlined;
  FtabIndex := 0;
  FuploadAbortedMessage := '';
  FuploadButtonText := '';
  FuploadChunk := nil;
  FuploadCustomData := nil;
  FuploadedMessage := '';
  FuploadFailedMessage := '';
  FuploadFile := nil;
  FuploadHeaders := nil;
  FuploadMethod := uhmPOST;
  FuploadMode := fumInstantly;
  FuploadUrl := '';
  FvalidationError := nil;
  FvalidationErrors := TJSArray.new;
  FvalidationMessageMode := vmmAuto;
  FvalidationMessagePosition := pBottom;
  FvalidationStatus := vsValid;
  Fvalue := nil;
  Fvisible := true;
  Fwidth_ := nil;

  FonBeforeSend := nil;
  FonContentReady := nil;
  FonDisposing := nil;
  FonDropZoneEnter := nil;
  FonDropZoneLeave := nil;
  FonFilesUploaded := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonProgress := nil;
  FonUploadAborted := nil;
  FonUploaded := nil;
  FonUploadError := nil;
  FonUploadStarted := nil;
  FonValueChanged := nil;
end;

procedure TjdxFileUploader.Set_abortUpload(const Value: TJSFunction);
begin
  FabortUpload := Value;
end;

procedure TjdxFileUploader.Set_accept(const Value: string);
begin
  Faccept := Value;
end;

procedure TjdxFileUploader.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxFileUploader.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxFileUploader.Set_allowCanceling(const Value: boolean);
begin
  FallowCanceling := Value;
end;

procedure TjdxFileUploader.Set_allowedFileExtensions(const Value: TJSArray);
begin
  FallowedFileExtensions := Value;
end;

procedure TjdxFileUploader.Set_chunkSize(const Value: integer);
begin
  FchunkSize := Value;
end;

procedure TjdxFileUploader.Set_dialogTrigger(const Value: JSValue);
begin
  FdialogTrigger := Value;
end;

procedure TjdxFileUploader.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxFileUploader.Set_dropZone(const Value: JSValue);
begin
  FdropZone := Value;
end;

procedure TjdxFileUploader.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxFileUploader.Set_extendSelection(const Value: boolean);
begin
  FextendSelection := Value;
end;

procedure TjdxFileUploader.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxFileUploader.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxFileUploader.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxFileUploader.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxFileUploader.Set_inputAttr(const Value: JSValue);
begin
  FinputAttr := Value;
end;

procedure TjdxFileUploader.Set_invalidFileExtensionMessage(const Value: string);
begin
  FinvalidFileExtensionMessage := Value;
end;

procedure TjdxFileUploader.Set_invalidMaxFileSizeMessage(const Value: string);
begin
  FinvalidMaxFileSizeMessage := Value;
end;

procedure TjdxFileUploader.Set_invalidMinFileSizeMessage(const Value: string);
begin
  FinvalidMinFileSizeMessage := Value;
end;

procedure TjdxFileUploader.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
end;

procedure TjdxFileUploader.Set_labelText(const Value: string);
begin
  FlabelText := Value;
end;

procedure TjdxFileUploader.Set_maxFileSize(const Value: integer);
begin
  FmaxFileSize := Value;
end;

procedure TjdxFileUploader.Set_minFileSize(const Value: integer);
begin
  FminFileSize := Value;
end;

procedure TjdxFileUploader.Set_multiple(const Value: boolean);
begin
  Fmultiple := Value;
end;

procedure TjdxFileUploader.Set_name_(const Value: string);
begin
  Fname_ := Value;
end;

procedure TjdxFileUploader.Set_progress(const Value: integer);
begin
  Fprogress := Value;
end;

procedure TjdxFileUploader.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
end;

procedure TjdxFileUploader.Set_readyToUploadMessage(const Value: string);
begin
  FreadyToUploadMessage := Value;
end;

procedure TjdxFileUploader.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxFileUploader.Set_selectButtonText(const Value: string);
begin
  FselectButtonText := Value;
end;

procedure TjdxFileUploader.Set_showFileList(const Value: boolean);
begin
  FshowFileList := Value;
end;

procedure TjdxFileUploader.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
end;

procedure TjdxFileUploader.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxFileUploader.Set_uploadAbortedMessage(const Value: string);
begin
  FuploadAbortedMessage := Value;
end;

procedure TjdxFileUploader.Set_uploadButtonText(const Value: string);
begin
  FuploadButtonText := Value;
end;

procedure TjdxFileUploader.Set_uploadChunk(const Value: TJSFunction);
begin
  FuploadChunk := Value;
end;

procedure TjdxFileUploader.Set_uploadCustomData(const Value: JSValue);
begin
  FuploadCustomData := Value;
end;

procedure TjdxFileUploader.Set_uploadedMessage(const Value: string);
begin
  FuploadedMessage := Value;
end;

procedure TjdxFileUploader.Set_uploadFailedMessage(const Value: string);
begin
  FuploadFailedMessage := Value;
end;

procedure TjdxFileUploader.Set_uploadFile(const Value: TJSFunction);
begin
  FuploadFile := Value;
end;

procedure TjdxFileUploader.Set_uploadHeaders(const Value: JSValue);
begin
  FuploadHeaders := Value;
end;

procedure TjdxFileUploader.Set_uploadMethod(const Value: TdxUploadHttpMethod);
begin
  FuploadMethod := Value;
end;

procedure TjdxFileUploader.Set_uploadMode(const Value: TdxFileUploadMode);
begin
  FuploadMode := Value;
end;

procedure TjdxFileUploader.Set_uploadUrl(const Value: string);
begin
  FuploadUrl := Value;
end;

procedure TjdxFileUploader.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
end;

procedure TjdxFileUploader.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
end;

procedure TjdxFileUploader.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
end;

procedure TjdxFileUploader.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
end;

procedure TjdxFileUploader.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
end;

procedure TjdxFileUploader.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
end;

procedure TjdxFileUploader.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxFileUploader.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxFileUploader.Set_onBeforeSend(const Value: TdxEventHandler);
begin
  FonBeforeSend := Value;
end;

procedure TjdxFileUploader.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxFileUploader.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxFileUploader.Set_onDropZoneEnter(const Value: TdxEventHandler);
begin
  FonDropZoneEnter := Value;
end;

procedure TjdxFileUploader.Set_onDropZoneLeave(const Value: TdxEventHandler);
begin
  FonDropZoneLeave := Value;
end;

procedure TjdxFileUploader.Set_onFilesUploaded(const Value: TdxEventHandler);
begin
  FonFilesUploaded := Value;
end;

procedure TjdxFileUploader.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxFileUploader.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxFileUploader.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxFileUploader.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxFileUploader.Set_onProgress(const Value: TdxEventHandler);
begin
  FonProgress := Value;
end;

procedure TjdxFileUploader.Set_onUploadAborted(const Value: TdxEventHandler);
begin
  FonUploadAborted := Value;
end;

procedure TjdxFileUploader.Set_onUploaded(const Value: TdxEventHandler);
begin
  FonUploaded := Value;
end;

procedure TjdxFileUploader.Set_onUploadError(const Value: TdxEventHandler);
begin
  FonUploadError := Value;
end;

procedure TjdxFileUploader.Set_onUploadStarted(const Value: TdxEventHandler);
begin
  FonUploadStarted := Value;
end;

procedure TjdxFileUploader.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
end;

end.
