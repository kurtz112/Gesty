unit DevExtreme.FileUploader.Custom;

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
  DevExtreme.FileUploader.JS,
  DevExtreme.Types;

type
  TjdxCustomFileUploader = class(TjdxCustomControl)
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
  protected
    procedure InitJQuery; override;
    procedure UpdateElement; override;
  public
    procedure CreateInitialize; override;
    function getInstance(element: TJSObject): TdxFileUploader; assembler;
    function instance: TdxFileUploader; assembler;
  public
    procedure abortUpload_(file_: JSValue); assembler; overload;
    procedure abortUpload_(); assembler; overload;
    procedure abortUpload_(fileIndex: integer); assembler; overload;
    procedure beginUpdate(); assembler;
    procedure ctor(element: JSValue; options: JSValue); assembler; overload;
    procedure ctor(options: JSValue); assembler; overload;
    procedure defaultOptions(rule: TJSObject); assembler;
    procedure dispose(); assembler;
    function element(): TJSElement; assembler;
    procedure endUpdate(); assembler;
    procedure focus(); assembler;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function off(eventName: string): TJSElement; assembler; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; assembler; overload;
    function on(events: TJSObject): TJSElement; assembler; overload;
    function option(optionName: string): JSValue; assembler; overload;
    function option(): TJSObject; assembler; overload;
    procedure option(options: TJSObject); assembler; overload;
    procedure option(optionName: string; optionValue: JSValue); assembler; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); assembler;
    procedure removeFile(file_: JSValue); assembler; overload;
    procedure removeFile(fileIndex: integer); assembler; overload;
    procedure repaint(); assembler;
    procedure reset(); assembler;
    procedure resetOption(optionName: string); assembler;
    procedure upload(fileIndex: integer); assembler; overload;
    procedure upload(file_: JSValue); assembler; overload;
    procedure upload(); assembler; overload;
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


procedure TjdxCustomFileUploader.CreateInitialize;
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
procedure TjdxCustomFileUploader.InitJQuery;
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
      $(id).dxFileUploader(options);
    end;

    FIsLoaded := instance <> nil;

    UpdateElement;
  end;
end;

function TjdxCustomFileUploader.getInstance(element: TJSObject): TdxFileUploader;
asm
  return DevExpress.viz.dxFileUploader.getInstance(element);
end;

function TjdxCustomFileUploader.instance: TdxFileUploader;
asm
  return $(this.GetJQID()).dxFileUploader("instance");
end;
procedure TjdxCustomFileUploader.UpdateElement;
begin
  inherited;

  if not isLoaded then
    exit;

  beginUpdate;
  try
    SetOption('abortUpload', abortUpload);
    SetOption('accept', accept);
    SetOption('accessKey', accessKey);
    SetOption('activeStateEnabled', activeStateEnabled);
    SetOption('allowCanceling', allowCanceling);
    SetOption('allowedFileExtensions', allowedFileExtensions);
    SetOption('chunkSize', chunkSize);
    SetOption('dialogTrigger', dialogTrigger);
    SetOption('disabled', disabled);
    SetOption('dropZone', dropZone);
    SetOption('elementAttr', elementAttr);
    SetOption('extendSelection', extendSelection);
    SetOption('focusStateEnabled', focusStateEnabled);
    SetOption('height', height_);
    SetOption('hint', hint);
    SetOption('hoverStateEnabled', hoverStateEnabled);
    SetOption('inputAttr', inputAttr);
    SetOption('invalidFileExtensionMessage', invalidFileExtensionMessage);
    SetOption('invalidMaxFileSizeMessage', invalidMaxFileSizeMessage);
    SetOption('invalidMinFileSizeMessage', invalidMinFileSizeMessage);
    SetOption('isValid', isValid);
    SetOption('labelText', labelText);
    SetOption('maxFileSize', maxFileSize);
    SetOption('minFileSize', minFileSize);
    SetOption('multiple', multiple);
    SetOption('name', name_);
    SetOption('progress', progress);
    SetOption('readOnly', readOnly);
    SetOption('readyToUploadMessage', readyToUploadMessage);
    SetOption('rtlEnabled', rtlEnabled);
    SetOption('selectButtonText', selectButtonText);
    SetOption('showFileList', showFileList);
    SetOption('stylingMode', stylingMode.ToString());
    SetOption('tabIndex', tabIndex);
    SetOption('uploadAbortedMessage', uploadAbortedMessage);
    SetOption('uploadButtonText', uploadButtonText);
    SetOption('uploadChunk', uploadChunk);
    SetOption('uploadCustomData', uploadCustomData);
    SetOption('uploadedMessage', uploadedMessage);
    SetOption('uploadFailedMessage', uploadFailedMessage);
    SetOption('uploadFile', uploadFile);
    SetOption('uploadHeaders', uploadHeaders);
    SetOption('uploadMethod', uploadMethod.ToString());
    SetOption('uploadMode', uploadMode.ToString());
    SetOption('uploadUrl', uploadUrl);
    SetOption('validationError', validationError);
    SetOption('validationErrors', validationErrors);
    SetOption('validationMessageMode', validationMessageMode.ToString());
    SetOption('validationMessagePosition', validationMessagePosition.ToString());
    SetOption('validationStatus', validationStatus.ToString());
    SetOption('value', value);
    SetOption('visible', visible);
    SetOption('width', width_);

    SetEvent('beforeSend', onBeforeSend);
    SetEvent('contentReady', onContentReady);
    SetEvent('disposing', onDisposing);
    SetEvent('dropZoneEnter', onDropZoneEnter);
    SetEvent('dropZoneLeave', onDropZoneLeave);
    SetEvent('filesUploaded', onFilesUploaded);
    SetEvent('focusIn', onFocusIn);
    SetEvent('focusOut', onFocusOut);
    SetEvent('initialized', onInitialized);
    SetEvent('optionChanged', onOptionChanged);
    SetEvent('progress', onProgress);
    SetEvent('uploadAborted', onUploadAborted);
    SetEvent('uploaded', onUploaded);
    SetEvent('uploadError', onUploadError);
    SetEvent('uploadStarted', onUploadStarted);
    SetEvent('valueChanged', onValueChanged);
  finally
    EndUpdate;
  end;
end;

procedure TjdxCustomFileUploader.Set_abortUpload(const Value: TJSFunction);
begin
  FabortUpload := Value;
  SetOption('abortUpload', abortUpload);
end;

procedure TjdxCustomFileUploader.Set_accept(const Value: string);
begin
  Faccept := Value;
  SetOption('accept', accept);
end;

procedure TjdxCustomFileUploader.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
  SetOption('accessKey', accessKey);
end;

procedure TjdxCustomFileUploader.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
  SetOption('activeStateEnabled', activeStateEnabled);
end;

procedure TjdxCustomFileUploader.Set_allowCanceling(const Value: boolean);
begin
  FallowCanceling := Value;
  SetOption('allowCanceling', allowCanceling);
end;

procedure TjdxCustomFileUploader.Set_allowedFileExtensions(const Value: TJSArray);
begin
  FallowedFileExtensions := Value;
  SetOption('allowedFileExtensions', allowedFileExtensions);
end;

procedure TjdxCustomFileUploader.Set_chunkSize(const Value: integer);
begin
  FchunkSize := Value;
  SetOption('chunkSize', chunkSize);
end;

procedure TjdxCustomFileUploader.Set_dialogTrigger(const Value: JSValue);
begin
  FdialogTrigger := Value;
  SetOption('dialogTrigger', dialogTrigger);
end;

procedure TjdxCustomFileUploader.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
  SetOption('disabled', disabled);
end;

procedure TjdxCustomFileUploader.Set_dropZone(const Value: JSValue);
begin
  FdropZone := Value;
  SetOption('dropZone', dropZone);
end;

procedure TjdxCustomFileUploader.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
  SetOption('elementAttr', elementAttr);
end;

procedure TjdxCustomFileUploader.Set_extendSelection(const Value: boolean);
begin
  FextendSelection := Value;
  SetOption('extendSelection', extendSelection);
end;

procedure TjdxCustomFileUploader.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
  SetOption('focusStateEnabled', focusStateEnabled);
end;

procedure TjdxCustomFileUploader.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
  SetOption('height', height_);
end;

procedure TjdxCustomFileUploader.Set_hint(const Value: string);
begin
  Fhint := Value;
  SetOption('hint', hint);
end;

procedure TjdxCustomFileUploader.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
  SetOption('hoverStateEnabled', hoverStateEnabled);
end;

procedure TjdxCustomFileUploader.Set_inputAttr(const Value: JSValue);
begin
  FinputAttr := Value;
  SetOption('inputAttr', inputAttr);
end;

procedure TjdxCustomFileUploader.Set_invalidFileExtensionMessage(const Value: string);
begin
  FinvalidFileExtensionMessage := Value;
  SetOption('invalidFileExtensionMessage', invalidFileExtensionMessage);
end;

procedure TjdxCustomFileUploader.Set_invalidMaxFileSizeMessage(const Value: string);
begin
  FinvalidMaxFileSizeMessage := Value;
  SetOption('invalidMaxFileSizeMessage', invalidMaxFileSizeMessage);
end;

procedure TjdxCustomFileUploader.Set_invalidMinFileSizeMessage(const Value: string);
begin
  FinvalidMinFileSizeMessage := Value;
  SetOption('invalidMinFileSizeMessage', invalidMinFileSizeMessage);
end;

procedure TjdxCustomFileUploader.Set_isValid(const Value: boolean);
begin
  FisValid := Value;
  SetOption('isValid', isValid);
end;

procedure TjdxCustomFileUploader.Set_labelText(const Value: string);
begin
  FlabelText := Value;
  SetOption('labelText', labelText);
end;

procedure TjdxCustomFileUploader.Set_maxFileSize(const Value: integer);
begin
  FmaxFileSize := Value;
  SetOption('maxFileSize', maxFileSize);
end;

procedure TjdxCustomFileUploader.Set_minFileSize(const Value: integer);
begin
  FminFileSize := Value;
  SetOption('minFileSize', minFileSize);
end;

procedure TjdxCustomFileUploader.Set_multiple(const Value: boolean);
begin
  Fmultiple := Value;
  SetOption('multiple', multiple);
end;

procedure TjdxCustomFileUploader.Set_name_(const Value: string);
begin
  Fname_ := Value;
  SetOption('name', name_);
end;

procedure TjdxCustomFileUploader.Set_progress(const Value: integer);
begin
  Fprogress := Value;
  SetOption('progress', progress);
end;

procedure TjdxCustomFileUploader.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
  SetOption('readOnly', readOnly);
end;

procedure TjdxCustomFileUploader.Set_readyToUploadMessage(const Value: string);
begin
  FreadyToUploadMessage := Value;
  SetOption('readyToUploadMessage', readyToUploadMessage);
end;

procedure TjdxCustomFileUploader.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
  SetOption('rtlEnabled', rtlEnabled);
end;

procedure TjdxCustomFileUploader.Set_selectButtonText(const Value: string);
begin
  FselectButtonText := Value;
  SetOption('selectButtonText', selectButtonText);
end;

procedure TjdxCustomFileUploader.Set_showFileList(const Value: boolean);
begin
  FshowFileList := Value;
  SetOption('showFileList', showFileList);
end;

procedure TjdxCustomFileUploader.Set_stylingMode(const Value: TdxEditorStyle);
begin
  FstylingMode := Value;
  SetOption('stylingMode', stylingMode.ToString());
end;

procedure TjdxCustomFileUploader.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
  SetOption('tabIndex', tabIndex);
end;

procedure TjdxCustomFileUploader.Set_uploadAbortedMessage(const Value: string);
begin
  FuploadAbortedMessage := Value;
  SetOption('uploadAbortedMessage', uploadAbortedMessage);
end;

procedure TjdxCustomFileUploader.Set_uploadButtonText(const Value: string);
begin
  FuploadButtonText := Value;
  SetOption('uploadButtonText', uploadButtonText);
end;

procedure TjdxCustomFileUploader.Set_uploadChunk(const Value: TJSFunction);
begin
  FuploadChunk := Value;
  SetOption('uploadChunk', uploadChunk);
end;

procedure TjdxCustomFileUploader.Set_uploadCustomData(const Value: JSValue);
begin
  FuploadCustomData := Value;
  SetOption('uploadCustomData', uploadCustomData);
end;

procedure TjdxCustomFileUploader.Set_uploadedMessage(const Value: string);
begin
  FuploadedMessage := Value;
  SetOption('uploadedMessage', uploadedMessage);
end;

procedure TjdxCustomFileUploader.Set_uploadFailedMessage(const Value: string);
begin
  FuploadFailedMessage := Value;
  SetOption('uploadFailedMessage', uploadFailedMessage);
end;

procedure TjdxCustomFileUploader.Set_uploadFile(const Value: TJSFunction);
begin
  FuploadFile := Value;
  SetOption('uploadFile', uploadFile);
end;

procedure TjdxCustomFileUploader.Set_uploadHeaders(const Value: JSValue);
begin
  FuploadHeaders := Value;
  SetOption('uploadHeaders', uploadHeaders);
end;

procedure TjdxCustomFileUploader.Set_uploadMethod(const Value: TdxUploadHttpMethod);
begin
  FuploadMethod := Value;
  SetOption('uploadMethod', uploadMethod.ToString());
end;

procedure TjdxCustomFileUploader.Set_uploadMode(const Value: TdxFileUploadMode);
begin
  FuploadMode := Value;
  SetOption('uploadMode', uploadMode.ToString());
end;

procedure TjdxCustomFileUploader.Set_uploadUrl(const Value: string);
begin
  FuploadUrl := Value;
  SetOption('uploadUrl', uploadUrl);
end;

procedure TjdxCustomFileUploader.Set_validationError(const Value: JSValue);
begin
  FvalidationError := Value;
  SetOption('validationError', validationError);
end;

procedure TjdxCustomFileUploader.Set_validationErrors(const Value: TJSArray);
begin
  FvalidationErrors := Value;
  SetOption('validationErrors', validationErrors);
end;

procedure TjdxCustomFileUploader.Set_validationMessageMode(const Value: TdxValidationMessageMode);
begin
  FvalidationMessageMode := Value;
  SetOption('validationMessageMode', validationMessageMode.ToString());
end;

procedure TjdxCustomFileUploader.Set_validationMessagePosition(const Value: TdxPosition);
begin
  FvalidationMessagePosition := Value;
  SetOption('validationMessagePosition', validationMessagePosition.ToString());
end;

procedure TjdxCustomFileUploader.Set_validationStatus(const Value: TdxValidationStatus);
begin
  FvalidationStatus := Value;
  SetOption('validationStatus', validationStatus.ToString());
end;

procedure TjdxCustomFileUploader.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
  SetOption('value', value);
end;

procedure TjdxCustomFileUploader.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
  SetOption('visible', visible);
end;

procedure TjdxCustomFileUploader.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
  SetOption('width', width_);
end;

procedure TjdxCustomFileUploader.Set_onBeforeSend(const Value: TdxEventHandler);
begin
  FonBeforeSend := Value;
  SetEvent('beforeSend', onBeforeSend);
end;

procedure TjdxCustomFileUploader.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
  SetEvent('contentReady', onContentReady);
end;

procedure TjdxCustomFileUploader.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
  SetEvent('disposing', onDisposing);
end;

procedure TjdxCustomFileUploader.Set_onDropZoneEnter(const Value: TdxEventHandler);
begin
  FonDropZoneEnter := Value;
  SetEvent('dropZoneEnter', onDropZoneEnter);
end;

procedure TjdxCustomFileUploader.Set_onDropZoneLeave(const Value: TdxEventHandler);
begin
  FonDropZoneLeave := Value;
  SetEvent('dropZoneLeave', onDropZoneLeave);
end;

procedure TjdxCustomFileUploader.Set_onFilesUploaded(const Value: TdxEventHandler);
begin
  FonFilesUploaded := Value;
  SetEvent('filesUploaded', onFilesUploaded);
end;

procedure TjdxCustomFileUploader.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
  SetEvent('focusIn', onFocusIn);
end;

procedure TjdxCustomFileUploader.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
  SetEvent('focusOut', onFocusOut);
end;

procedure TjdxCustomFileUploader.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
  SetEvent('initialized', onInitialized);
end;

procedure TjdxCustomFileUploader.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
  SetEvent('optionChanged', onOptionChanged);
end;

procedure TjdxCustomFileUploader.Set_onProgress(const Value: TdxEventHandler);
begin
  FonProgress := Value;
  SetEvent('progress', onProgress);
end;

procedure TjdxCustomFileUploader.Set_onUploadAborted(const Value: TdxEventHandler);
begin
  FonUploadAborted := Value;
  SetEvent('uploadAborted', onUploadAborted);
end;

procedure TjdxCustomFileUploader.Set_onUploaded(const Value: TdxEventHandler);
begin
  FonUploaded := Value;
  SetEvent('uploaded', onUploaded);
end;

procedure TjdxCustomFileUploader.Set_onUploadError(const Value: TdxEventHandler);
begin
  FonUploadError := Value;
  SetEvent('uploadError', onUploadError);
end;

procedure TjdxCustomFileUploader.Set_onUploadStarted(const Value: TdxEventHandler);
begin
  FonUploadStarted := Value;
  SetEvent('uploadStarted', onUploadStarted);
end;

procedure TjdxCustomFileUploader.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
  SetEvent('valueChanged', onValueChanged);
end;

procedure TjdxCustomFileUploader.abortUpload_(file_: JSValue);
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.abortUpload(file_);
end;

procedure TjdxCustomFileUploader.abortUpload_();
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.abortUpload();
end;

procedure TjdxCustomFileUploader.abortUpload_(fileIndex: integer);
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.abortUpload(fileIndex);
end;

procedure TjdxCustomFileUploader.beginUpdate();
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.beginUpdate();
end;

procedure TjdxCustomFileUploader.ctor(element: JSValue; options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.ctor(element, options);
end;

procedure TjdxCustomFileUploader.ctor(options: JSValue);
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.ctor(options);
end;

procedure TjdxCustomFileUploader.defaultOptions(rule: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.defaultOptions(rule);
end;

procedure TjdxCustomFileUploader.dispose();
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.dispose();
end;

function TjdxCustomFileUploader.element(): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  return _instance.element();
end;

procedure TjdxCustomFileUploader.endUpdate();
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.endUpdate();
end;

procedure TjdxCustomFileUploader.focus();
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.focus();
end;

function TjdxCustomFileUploader.off(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  return _instance.off(eventName, eventHandler);
end;

function TjdxCustomFileUploader.off(eventName: string): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  return _instance.off(eventName);
end;

function TjdxCustomFileUploader.on(eventName: string; eventHandler: TJSFunction): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  return _instance.on(eventName, eventHandler);
end;

function TjdxCustomFileUploader.on(events: TJSObject): TJSElement;
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  return _instance.on(events);
end;

function TjdxCustomFileUploader.option(optionName: string): JSValue;
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  return _instance.option(optionName);
end;

function TjdxCustomFileUploader.option(): TJSObject;
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  return _instance.option();
end;

procedure TjdxCustomFileUploader.option(options: TJSObject);
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.option(options);
end;

procedure TjdxCustomFileUploader.option(optionName: string; optionValue: JSValue);
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.option(optionName, optionValue);
end;

procedure TjdxCustomFileUploader.registerKeyHandler(key: string; handler: TJSFunction);
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.registerKeyHandler(key, handler);
end;

procedure TjdxCustomFileUploader.removeFile(file_: JSValue);
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.removeFile(file_);
end;

procedure TjdxCustomFileUploader.removeFile(fileIndex: integer);
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.removeFile(fileIndex);
end;

procedure TjdxCustomFileUploader.repaint();
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.repaint();
end;

procedure TjdxCustomFileUploader.reset();
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.reset();
end;

procedure TjdxCustomFileUploader.resetOption(optionName: string);
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.resetOption(optionName);
end;

procedure TjdxCustomFileUploader.upload(fileIndex: integer);
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.upload(fileIndex);
end;

procedure TjdxCustomFileUploader.upload(file_: JSValue);
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.upload(file_);
end;

procedure TjdxCustomFileUploader.upload();
asm
  const _instance = $(this.GetJQID()).dxFileUploader("instance");
  _instance.upload();
end;

end.
