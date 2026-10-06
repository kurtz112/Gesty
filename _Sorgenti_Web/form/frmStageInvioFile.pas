unit frmStageInvioFile;

interface

uses
  System.SysUtils,
  System.Classes,
  JS,
  Web,
  WEBLib.Graphics,
  WEBLib.Controls,
  WEBLib.Forms,
  WEBLib.Dialogs,
  Vcl.StdCtrls,
  WEBLib.StdCtrls,
  Vcl.Controls,
  WEBLib.WebCtrls,
  DevExtreme.Data,
  DevExtreme.CustomControl,
  DevExtreme.Scheduler.JS,
  DevExtreme.Toolbar.JS,
  DevExtreme.DateBox.JS,
  DevExtreme.Form.JS,
  DevExtreme.Popup.JS,
  DevExtreme.FileUploader,
  DevExtreme.FileUploader.JS,
  zz.Web.DataRequest,
  zz.Web.JSClasses,
  BaseWebFrm;

type
  TFormStageInvioFile = class(TBaseWebForm)
    Stages: TjdxDataSource;
  private
    Toolbar: TdxToolbar;
    FileUploader: TdxFileUploader;

    currentStage: integer;
    ElencoStage: TJSArray;
  private
    procedure CreateToolbar;
    procedure CreateFileUploader;
  private
    procedure SelectStage(Stage: TJSObject); overload;
    procedure SelectStage(idTirocinio: integer); overload;
    function ToolbarItems: TJSArray;
  public
    [async]
    procedure AfterCreate(const id: integer = -1); override;
  end;

var
  FormStageInvioFile: TFormStageInvioFile;

implementation

uses
  System.DateUtils,
  libjquery,
  DevExtreme.utils,
  DevExtreme.Types,
  DevExtreme.factory,
  DevExtreme.Options,
  DevExtreme.base,
  zz.Web.user,
  zz.Web.JS,
  zz.Web.fetch,
  zz.Web.url;

{$R *.dfm}

procedure TFormStageInvioFile.CreateToolbar;
var
  Options: TJSObject;
begin
  Options := dxOptions.Toolbar('schedulerToolbar');
  Options['multiline'] := true;
  Options['items'] := ToolbarItems;

  Options['onContentReady'] := function(e: TJSObject): JSValue
    begin
      Toolbar := TdxToolbar(e['component']);
    end;

  dxFactory.Toolbar('#schedulerToolbar', Options);
end;

function TFormStageInvioFile.ToolbarItems: TJSArray;

  function toolButton(const caption, hint, icon, id: string; onClick: TdxEventHandlerFunc): TJSObject;
  var
    Options: TJSObject;
    elementAttr: TJSObject;
  begin
    Options := TJSObject.new;
    Options['icon'] := icon;
    Options['hint'] := hint;
    Options['onClick'] := onClick;

    if caption.IsEmpty then
      Options['width'] := 25
    else
    begin
      Options['text'] := caption;
      Options['width'] := 'auto';
    end;

    if not id.IsEmpty then
    begin
      elementAttr := TJSObject.new;
      elementAttr['id'] := id;
      Options['elementAttr'] := elementAttr;
    end;

    result := TJSObject.new;
    result['location'] := 'before';
    result['locateInMenu'] := 'never';
    result['widget'] := 'dxButton';
    result['options'] := Options;
  end;

  function ComboStage(): TJSObject;
  var
    editorOptions: TJSObject;
    inputAttr: TJSObject;
  begin
    editorOptions := TJSObject.new;
    editorOptions['width'] := '100%';
    editorOptions['acceptCustomValue'] := true;
    editorOptions['openOnFieldClick'] := true;
    editorOptions['showDropDownButton'] := true;
    editorOptions['searchEnabled'] := true;
    editorOptions['items'] := ElencoStage;
    editorOptions['displayExpr'] := 'NOMINATIVO';
    editorOptions['valueExpr'] := 'ID_TIROCINIO';
    editorOptions['value'] := currentStage;
    editorOptions['width'] := 300;
    editorOptions['onValueChanged'] := function(e: TJSObject): JSValue

      var
        id: integer;
      begin
        id := JS.toInteger(e['value']);
        SelectStage(id);
        // showMessage('Selezionato', 'Selezionato: ' + id.ToString);
      end;

    result := TJSObject.new;
    result['location'] := 'before';
    result['locateInMenu'] := 'never';
    result['widget'] := 'dxSelectBox';
    result['options'] := editorOptions;
  end;

begin
  result := TJSArray.new;

  result.push(ComboStage);
end;

procedure TFormStageInvioFile.SelectStage(Stage: TJSObject);
begin

  if assigned(Stage) then
    if Stage.HasOwnProperty('ID_TIROCINIO') then
      SelectStage(JS.toInteger(Stage['ID_TIROCINIO']));
end;

procedure TFormStageInvioFile.SelectStage(idTirocinio: integer);
begin
  currentStage := idTirocinio;
end;

procedure TFormStageInvioFile.AfterCreate(const id: integer = -1);
begin
  inherited;
  Toolbar := nil;

  user.TipoUser.Check(tuTutor);

  Stages.load()._then(
    function(aValue: JSValue): JSValue
    var
      PrimoStage: TJSObject;
    begin
      ElencoStage := JS.toArray(aValue);
      PrimoStage := JS.toObject(ElencoStage[0]);
      SelectStage(PrimoStage);

      CreateToolbar;
      CreateFileUploader;
    end);
end;

procedure TFormStageInvioFile.CreateFileUploader;
  function allowedFileExtensions: TJSArray;
  begin
    result := TJSArray.new;
    result.push('.pdf');
  end;

  function uploadHeaders: TJSObject;
  begin
    result := TJSObject.new;
    result['Authorization'] := 'Bearer ' + encodeURIComponent(TUrl.JWT);
    // result['Accept-Encoding'] := '*';
  end;

var
  Options: TJSObject;
begin
  Options := dxOptions.FileUploader('fileUploader');
  Options['name'] := 'allegato';

  Options['uploadMethod'] := 'POST';
  Options['uploadMode'] := 'useButtons'; // instantly
  // Options['uploadMode'] := 'instantly'; // useButtons
  Options['uploadUrl'] := TUrl.UploadFile;
  Options['uploadHeaders'] := uploadHeaders; // JWT

  Options['accept'] := 'application/pdf';
  Options['allowedFileExtensions'] := allowedFileExtensions;

  // Options['dialogTrigger'] := '#dropzone';
  // Options['dropZone'] := '#dropzone';

  Options['maxFileSize'] := 20000000;
  Options['minFileSize'] := 0;
  Options['multiple'] := false;

  Options['invalidFileExtensionMessage'] := 'Tipo di file non valido';
  Options['invalidMinFileSizeMessage'] := 'Dimensione minima del file non valida';
  Options['invalidMaxFileSizeMessage'] := 'Dimensione massima del file non valida';
  Options['readyToUploadMessage'] := 'Pronto per il caricamento';

  Options['selectButtonText'] := 'Seleziona file da inviare';
  Options['uploadAbortedMessage'] := 'Caricamento annullato';
  Options['uploadButtonText'] := 'Invia file';
  Options['uploadedMessage'] := 'File inviato';
  Options['labelText'] := 'Rilasciare qui i file da inviare';
  Options['showFileList'] := true;

  Options['onContentReady'] := function(e: TJSObject): JSValue
    begin
      FileUploader := TdxFileUploader(e['component']);
    end;

  Options['onBeforeSend'] := function(e: TJSObject): JSValue
    var
      req: TJSXMLHttpRequest;
      f: TJSObject;
      TipoAllegato: string;
    begin
      console.log('onBeforeSend');
      console.log(e);

      f := JS.toObject(e['file']);

      TipoAllegato := ''; { TODO : recuperare TipoAllegato }

      req := TJSXMLHttpRequest(e['request']);
      req.setRequestHeader('TIPO_ALLEGATO', TipoAllegato);
      req.setRequestHeader('NOME_FILE_ORIGINALE', JS.ToString(f['name']));
      req.setRequestHeader('OID', currentStage.ToString);
    end;

  Options['onUploaded'] := function(e: TJSObject): JSValue
    begin
      console.log('onUploaded');
      console.log(e);
    end;

  Options['onFilesUploaded'] := function(e: TJSObject): JSValue
    begin
      console.log('onFilesUploaded');
      console.log(e);
    end;

  Options['onUploadError'] := function(e: TJSObject): JSValue
    begin
      console.log('onUploadError');
      console.log(e);
      raise Exception.Create('upload Error Message');
    end;

  dxFactory.FileUploader('#fileUploader', Options);
end;

end.
