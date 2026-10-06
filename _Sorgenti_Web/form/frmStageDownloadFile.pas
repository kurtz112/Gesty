unit frmStageDownloadFile;

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
  DevExtreme.DataGrid,
  DevExtreme.DataGrid.JS,
  DevExtreme.DateBox.JS,
  DevExtreme.Form.JS,
  DevExtreme.Popup.JS,
  zz.Web.DataRequest,
  zz.Web.JSClasses,
  BaseWebFrm;

type
  TFormStageDownloadFile = class(TBaseWebForm)
    Stages: TjdxDataSource;
    Allegati: TjdxDataSource;
  private
    Toolbar: TdxToolbar;
    grid: TdxDataGrid;
    currentStage: integer;
    ElencoStage: TJSArray;

    procedure SelectStage(Stage: TJSObject); overload;
    procedure SelectStage(idTirocinio: integer); overload;

    procedure LoadAllegati;
    procedure ViewPdf(const idFile: integer);
    procedure ViewPdf__(const idFile: integer);
    procedure DownloadPdf(const idFile: integer);
  private
    procedure CreateToolbar;
    function ToolbarItems: TJSArray;
    function CommandColumns: TJSArray;
    procedure CreateGrid;
  public
    [async]
    procedure AfterCreate(const id: integer = -1); override;
  end;

var
  FormStageDownloadFile: TFormStageDownloadFile;

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

procedure TFormStageDownloadFile.SelectStage(Stage: TJSObject);
begin

  if assigned(Stage) then
    if Stage.HasOwnProperty('ID_TIROCINIO') then
      SelectStage(JS.toInteger(Stage['ID_TIROCINIO']));
end;

procedure TFormStageDownloadFile.SelectStage(idTirocinio: integer);
begin
  currentStage := idTirocinio;
  LoadAllegati();
end;

procedure TFormStageDownloadFile.AfterCreate(const id: integer = -1);
begin
  inherited;
  Toolbar := nil;

  user.TipoUser.Check([tuTutor, tuStudente]);

  Stages.load()._then(
    function(aValue: JSValue): JSValue
    var
      PrimoStage: TJSObject;
    begin
      ElencoStage := JS.toArray(aValue);
      PrimoStage := JS.toObject(ElencoStage[0]);
      SelectStage(PrimoStage);
      CreateToolbar;
      CreateGrid;
    end);
end;

procedure TFormStageDownloadFile.LoadAllegati;
begin
  Allegati.Params.AddPair('ID_TIROCINIO', currentStage.ToString);
  Allegati.reload();
end;

procedure TFormStageDownloadFile.CreateToolbar;
var
  Options: TJSObject;
begin
  Options := dxOptions.Toolbar('allegatiToolbar');
  Options['multiline'] := true;
  Options['items'] := ToolbarItems;

  Options['onContentReady'] := function(e: TJSObject): JSValue
    begin
      Toolbar := TdxToolbar(e['component']);
    end;

  dxFactory.Toolbar('#allegatiToolbar', Options);
end;

function TFormStageDownloadFile.ToolbarItems: TJSArray;

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
    // editorOptions['dataSource'] := ElencoStage;
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

  // result.push(toolButton('Conferma Presenze', 'conferma le presenze della settimana', 'check', 'btnConferma',
  // function(e: TJSObject): JSValue
  // begin
  //
  // Confirm('Conferma Presenze', 'Confermare le presenze della settimana?',
  // procedure
  // begin
  // // ConfermaPresenze(true);
  // end, nil);
  // end));

  // result.push(toolButton('', 'aggiorna', 'revert', 'btnRefresh',
  // function(e: TJSObject): JSValue
  // begin
  // // ReloadScheduler;
  // end));
end;

procedure TFormStageDownloadFile.CreateGrid;
begin

  dxFactory.DataGrid('#gridAllegati', Allegati, grid)._then(
    function(aValue: JSValue): JSValue
    var
      columns: TJSArray;
    begin
      grid.AllowAdding := false;
      grid.AllowUpdating := false;
      grid.AllowDeleting := false;
      grid.HideEditButton := true;

      columns := CommandColumns.concat(grid.columns);
      grid.columns := columns;
    end);
end;

function TFormStageDownloadFile.CommandColumns: TJSArray;
var
  buttons: TJSArray;
  col: TJSObject;
  o: TJSObject;
begin
  buttons := TJSArray.new;

  /// //////////////////////

  col := TJSObject.new;
  col['text'] := 'Download';
  col['icon'] := 'download';
  col['hint'] := 'scarica il file selezionato';
  col['onClick'] := function(e: TJSObject): JSValue
    var
      idFile: integer;
    begin
      asm
        idFile = e['row']['data']['ID_FILE'];
      end;

      DownloadPdf(idFile);
    end;

  buttons.push(col);

  /// //////////////////////

  col := TJSObject.new;
  col['text'] := 'View';
  col['icon'] := 'pdffile';
  col['hint'] := 'visualizza il file selezionato';
  col['onClick'] := function(e: TJSObject): JSValue
    var
      idFile: integer;
    begin
      asm
        idFile = e['row']['data']['ID_FILE'];
      end;

      ViewPdf(idFile);
    end;

  buttons.push(col);

  /// //////////////////////
  o := TJSObject.new;
  // o['dataField'] := 'buttons';
  o['type'] := 'buttons';
  o['buttons'] := buttons;

  result := TJSArray.new;
  result.push(o);
end;

procedure TFormStageDownloadFile.DownloadPdf(const idFile: integer);
var
  url: string;
begin
  url := TUrl.DownloadFile + '?' + 'ID_FILE=' + idFile.ToString + '&__JWT=' + TUrl.JWT;
  Application.Navigate(url, TNavigationTarget.ntBlank);
end;

procedure TFormStageDownloadFile.ViewPdf__(const idFile: integer);
var
  url: String;
  w: TJSWindow;
begin
  url := TUrl.DownloadFile + '?' + 'ID_FILE=' + idFile.ToString; // + '&__JWT=' + TUrl.JWT;
  //
  //
  // w := window.open('web/viewer.html?file=');
  w := window.open('web/viewer.html');
  w.addEventListener('load',
    function(): JSValue // load
    var
      req: TJSRequest;
      o: TJSObject;
    begin
      o := RequestOptions(url, 'GET', 'application/pdf', nil, '', '');
      req := Request(url, o);

      fetch(req)._then(
        function(aValue: JSValue): JSValue // fetch
        begin

          TJSResponse(aValue).arrayBuffer()._then(
            function(aValue: JSValue): JSValue // arrayBuffer
            var
              arrayBuffer: TJSArrayBuffer;
              Uint8Array: TJSUint8Array;
            begin
              arrayBuffer := TJSArrayBuffer(aValue);
              Uint8Array := TJSUint8Array.new(arrayBuffer);

              asm
                let app = w.PDFViewerApplication;
                // w.PDFViewerApplication.open( Uint8Array,0 );
                const blob = new Blob([Uint8Array]);
                var url = URL.createObjectURL(blob);
                app.open(url, 0);
              end;
            end);
        end);
    end);
end;

procedure TFormStageDownloadFile.ViewPdf(const idFile: integer);
var
  req: TJSRequest;
  o: TJSObject;
  url: string;
begin
  url := TUrl.DownloadFile + '?' + 'ID_FILE=' + idFile.ToString; // + '&__JWT=' + TUrl.JWT;
  o := RequestOptions(url, 'GET', 'application/pdf', nil, '', '');
  req := Request(url, o);

  fetch(req)._then(
    function(aValue: JSValue): JSValue // fetch
    begin

      TJSPromise(TJSResponse(aValue).blob)._then(
        function(aValue: JSValue): JSValue
        var
          blob: TJSBlob;
          bloburl: string;
        begin
          blob := TJSBlob(aValue);
          bloburl := TJSURL.createObjectURL(blob);
          window.open('web/viewer.html?file=' + encodeURIComponent(bloburl));
        end);
    end);
end;

end.
