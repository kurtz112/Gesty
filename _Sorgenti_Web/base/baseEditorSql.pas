unit baseEditorSql;

interface

uses
  System.SysUtils,
  System.Classes,
  types,
  JS,
  web,
  DevExtreme.types;

procedure EditSQL(const DataSetId, TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: string; ReturnProc: TEditSqlReturnProc);

implementation

uses
  libjquery,
  zz.web.JS,
  zz.web.html,
  DevExtreme.popup,
  DevExtreme.popup.JS,
  DevExtreme.TabPanel,
  DevExtreme.TabPanel.JS,
  DevExtreme.Form,
  DevExtreme.Form.JS,
  DevExtreme.themes,
  DevExtreme.factory,
  DevExtreme.Options;

type
  TSqlParams = record
    fields: string;
    SelectSql: string;
    InsertSql: string;
    UpdateSql: string;
    DeleteSql: string;
    CountSql: string;

    procedure Save(const aFields, aSelectSql, aInsertSql, aUpdateSql, aDeleteSql, aCountSql: string);
    procedure Load(out aFields, aSelectSql, aInsertSql, aUpdateSql, aDeleteSql, aCountSql: string);
  end;

  TEditorSqlPopup = record
  private
    SqlParams: TSqlParams;
    TabPanel: TdxTabPanel;

    function tabPanelOptions(const fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: string): TJSObject;
  private
    topForm: TdxForm;
    function topFormOptions(const DataSetId, TableName, Pk: string): TJSObject;
  private type
    TPageKind = (pkSelect, pkInsert, pkUpdate, pkDelete, pkCount, pkFields);
  private
    PrevPage: TPageKind;
    function CurrentPage: TPageKind;
  private
    aceSelect, aceInsert, aceUpdate, aceDelete, aceCount, aceFields: JSValue;

    function EditorID(PageKind: TPageKind): string;
    procedure GetEditorValue(PageKind: TPageKind; var Sql: string);
    procedure SetAceInstance(PageKind: TPageKind; editor: JSValue);
  private
    procedure FixCSS;
  public
    procedure ShowSQL(const DataSetId, TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: string; ReturnProc: TEditSqlReturnProc);
  end;

var
  EditorSqlPopup: TEditorSqlPopup;

  { TSqlParams }

procedure TSqlParams.Save(const aFields, aSelectSql, aInsertSql, aUpdateSql, aDeleteSql, aCountSql: string);
begin
  fields := aFields;
  SelectSql := aSelectSql;
  InsertSql := aInsertSql;
  UpdateSql := aUpdateSql;
  DeleteSql := aDeleteSql;
  CountSql := aCountSql;
end;

procedure TSqlParams.Load(out aFields, aSelectSql, aInsertSql, aUpdateSql, aDeleteSql, aCountSql: string);
begin
  aFields := fields;
  aSelectSql := SelectSql;
  aInsertSql := InsertSql;
  aUpdateSql := UpdateSql;
  aDeleteSql := DeleteSql;
  aCountSql := CountSql;
end;
//
// procedure aEditSQL(const title: string; const TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: string; ReturnProc: TEditSqlReturnProc);
//
// procedure doCancel(closeProc: TProc);
// begin
// if assigned(closeProc) then
// closeProc;
// end;
//
// var
// popOptions: TJSObject;
// popContentId: string;
// begin
// popOptions := dxOptions.popup(title, true); // not TdxThemes.dark);
// popOptions['width'] := '80%';
// popOptions['height'] := '80%';
// popContentId := TjdxPopup.ContentId(popOptions);
//
// popOptions['onShowing'] := function(e: TJSObject): JSValue
// var
// w, h: integer;
// tabTitolo: string;
// el, div_: TJSHTMLElement;
// j: JSValue;
// begin
// div_ := TJSHTMLElement(document.getElementById(popContentId));
// el := _DIV(div_, 'editor');
// el.style.setProperty('width', '100%');
// el.style.setProperty('height', '100%');
//
// asm
// var editor = ace.edit("editor");
// editor.setTheme("ace/theme/tomorrow_night_blue");
// editor.session.setMode("ace/mode/sql");
// editor.setValue(SelectSql);
// end;
// end;
//
// popOptions['onShown'] := function(e: TJSObject): JSValue
// begin
// asm
// e.component.content().find('input').first().focus();
// end;
// end;
//
// TjdxPopup.ShowPopupModal(popOptions,
// procedure(callBack: TProc)
// var
// TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: String;
// begin
// asm
// var editor = ace.edit("editor");
// SelectSql = editor.getValue();
// end;
//
// ReturnProc(TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql, callBack);
// end, @doCancel);
// end;

{ TEditorSqlPopup }

function TEditorSqlPopup.EditorID(PageKind: TPageKind): string;
begin
  case PageKind of
    pkSelect:
      result := 'edSelect';
    pkInsert:
      result := 'edInsert';
    pkUpdate:
      result := 'edUpdate';
    pkDelete:
      result := 'edDelete';
    pkCount:
      result := 'edCount';
    pkFields:
      result := 'edFields';
  end;
end;

function TEditorSqlPopup.CurrentPage: TPageKind;
var
  j: JSValue;
  idx: integer;
begin
  j := TabPanel.option('selectedIndex');
  idx := JS.ToInteger(j);

  case idx of
    0:
      result := pkSelect;
    1:
      result := pkInsert;
    2:
      result := pkUpdate;
    3:
      result := pkDelete;
    4:
      result := pkCount;
    5:
      result := pkFields;
  end;
end;

procedure TEditorSqlPopup.FixCSS;
var
  q: TJQuery;
  el: TJSHTMLElement;

  procedure setProperty(el: TJSHTMLElement; const aProperty: string; const aValue: string);
  begin
    if assigned(el) then
      if assigned(el.style) then
        el.style.setProperty(aProperty, aValue);
  end;

begin
  // altrimenti i tabs occupano tutto lo spazio
  el := document.querySelector('#tabPanel > div.dx-tabpanel-tabs > div') as TJSHTMLElement;
  setProperty(el, 'height', 'auto');

  // altrimenti il content finisce sotto ok/cancel
  el := document.querySelector('#tabPanel > div.dx-tabpanel-container') as TJSHTMLElement;
  setProperty(el, 'margin-top', '0px');
  setProperty(el, 'padding-top', '0px');

  // evita la sovrapposizione del tabPanel con l'ok/cancel
  el := document.querySelector('body > div.dx-overlay-wrapper.dx-popup-wrapper.dx-overlay-shader > div > div.dx-popup-content') as TJSHTMLElement;
  setProperty(el, 'max-height', 'inherit');

  el := document.querySelector('#tabPanel > div.dx-tabpanel-container') as TJSHTMLElement;
  setProperty(el, 'max-height', 'inherit');

  el := document.querySelector('#tabPanel > div.dx-tabpanel-container > div') as TJSHTMLElement;
  setProperty(el, 'max-height', 'inherit');

  el := document.querySelector('#tabPanel') as TJSHTMLElement;
  setProperty(el, 'max-height', 'inherit');
end;

procedure TEditorSqlPopup.SetAceInstance(PageKind: TPageKind; editor: JSValue);
begin
  case PageKind of
    pkSelect:
      aceSelect := editor;
    pkInsert:
      aceInsert := editor;
    pkUpdate:
      aceUpdate := editor;
    pkDelete:
      aceDelete := editor;
    pkCount:
      aceCount := editor;
    pkFields:
      aceFields := editor;
  end;
end;

procedure TEditorSqlPopup.GetEditorValue(PageKind: TPageKind; var Sql: string);
var
  id: string;
  el: TJSElement;
begin
  id := EditorID(PageKind);

  el := document.getElementById(id);

  if not assigned(el) then
    exit; // non è stato creato l'editor (non si è cambiata pagina), esce con il valore di default

  asm
    var editor = ace.edit(id);
    Sql = editor.getValue();
  end;
end;

function TEditorSqlPopup.tabPanelOptions(const fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: string): TJSObject;

  function CreatePage(const title: string; template: JSValue): TJSObject;
  begin
    result := new([]);
    result['title'] := title;

    if template <> nil then
      result['template'] := template;
  end;

  function templateFunc(PageKind: TPageKind; value: string): JSValue;
  begin
    result := function(): JSValue
      var
        Options: TJSObject;
        res: JSValue;
        s: string;
        editor: JSValue;
        id: string;
        containedID: string;
      begin // @Editor Json
        id := EditorID(PageKind);
        containedID := id + 'Container';

        Options := new([]);
        Options['theme'] := 'ace/theme/tomorrow_night_blue';
        Options['mode'] := 'ace/mode/sql';
        Options['value'] := value;

        asm
          res = $("<div id=containedID></div>").css('width', '100%').css('height', '100%');
          var divJSON = $('<div>').attr('id', id).css('width', '100%').css('height', '100%').appendTo(res);
          editor = ace.edit(divJSON.get(0), Options);
        end;

        SetAceInstance(PageKind, editor);
        result := res;
      end;
  end;

var
  pages: TJSArray;
begin
  /// ////////////////////////

  pages := TJSArray.new;
  pages.push(CreatePage('Select', templateFunc(pkSelect, SelectSql)));
  pages.push(CreatePage('Insert', templateFunc(pkInsert, InsertSql)));
  pages.push(CreatePage('Update', templateFunc(pkUpdate, UpdateSql)));
  pages.push(CreatePage('Delete', templateFunc(pkDelete, DeleteSql)));
  pages.push(CreatePage('Count', templateFunc(pkCount, CountSql)));
  pages.push(CreatePage('Fields', templateFunc(pkFields, fields)));

  /// ////////////////////////

  result := new([]);
  result['scrollingEnabled'] := true;
  result['items'] := pages;
  result['selectedIndex'] := 0;

  // result['onSelectionChanged'] := function(e: TJSObject): boolean
  // begin
  // PostValues;
  // LoadValues;
  // PrevPage := CurrentPage;
  // end;

  result['onShown'] := function(e: TJSObject): JSValue
    begin
      asm
        aceSelect.focus();
      end;
    end;
end;

function TEditorSqlPopup.topFormOptions(const DataSetId, TableName, Pk: string): TJSObject;

  function formData(): TJSObject;
  begin
    result := new([]);
    result['DataSetId'] := DataSetId;
    result['TableName'] := TableName;
    result['Pk'] := Pk;
  end;

  function items(): TJSArray;
  begin
    result := TJSArray.new;
    result.push(TjdxForm.item('DataSetId', 'DataSetId', true, []));
    result.push(TjdxForm.item('TableName', 'TableName', true, []));
    result.push(TjdxForm.item('Pk', 'Pk', true, []));
  end;

begin
  result := dxOptions.Form('');
  result['labelMode'] := 'outside';
  result['formData'] := formData();
  result['items'] := items();
  result['scrollingEnabled'] := false;
end;

procedure TEditorSqlPopup.ShowSQL(const DataSetId, TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: string; ReturnProc: TEditSqlReturnProc);

  procedure doOk(closeProc: TProc);
  var

    formData: TJSObject;
    TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: string;
  begin

    if assigned(ReturnProc) then
    begin
      formData := JS.toObject(topForm.option('formData'));
      TableName := JS.ToString(formData['TableName']);
      Pk := JS.ToString(formData['Pk']);

      //
      SqlParams.Load(fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql);

      GetEditorValue(pkSelect, SelectSql);
      GetEditorValue(pkInsert, InsertSql);
      GetEditorValue(pkUpdate, UpdateSql);
      GetEditorValue(pkDelete, DeleteSql);
      GetEditorValue(pkCount, CountSql);
      GetEditorValue(pkFields, fields);

      ReturnProc(TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql, closeProc);
    end;

    closeProc;
  end;

  procedure doCancel(closeProc: TProc);
  begin
    closeProc;
  end;

var
  popDiv: TJSHTMLElement;
  popOptions: TJSObject;
  popContentId: string;
begin
  /// //////////////////////////////////////////////////////////////////////////
  SqlParams.Save(fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql);

  popOptions := dxOptions.popup(DataSetId, not TdxThemes.dark);
  popContentId := TjdxPopup.ContentId(popOptions);

  popOptions['onShown'] := function(e: TJSObject): JSValue
    var
      popDiv, tmpDIV, cardDiv, tabPanelDIV: TJSHTMLElement;
    begin
      // popup
      popDiv := TJSHTMLElement(document.getElementById(popContentId));
      /// ///////////////////////////////////////////////////////////////////
      // tableName, Pk
      cardDiv := _DIV(popDiv, 'topForm');
      cardDiv.style.setProperty('width', '100%');
      cardDiv.style.setProperty('height', 'fit-content');
      cardDiv.style.setProperty('padding-top', '5px');
      cardDiv.style.setProperty('padding-bottom', '5px');

      topForm := dxFactory.Form('#topForm', topFormOptions(DataSetId, TableName, Pk));

      /// ///////////////////////////////////////////////////////////////////
      // tabPanel
      tabPanelDIV := _DIV(popDiv, 'tabPanel');
      tabPanelDIV.style.setProperty('width', '100%');
      tabPanelDIV.style.setProperty('height', '100%');
      tabPanelDIV.style.setProperty('max-height', '100%');
      TabPanel := dxFactory.TabPanel('#tabPanel', tabPanelOptions(fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql));

      FixCSS;
    end;

  popOptions['width'] := '80%';
  popOptions['height'] := '80%';

  TjdxPopup.ShowPopupModal(popOptions, @doOk, @doCancel);
end;

procedure EditSQL(const DataSetId, TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql: string; ReturnProc: TEditSqlReturnProc);
begin
  EditorSqlPopup.ShowSQL(DataSetId, TableName, Pk, fields, SelectSql, InsertSql, UpdateSql, DeleteSql, CountSql, ReturnProc);
end;

end.
