unit baseMeta;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  JS,
  DevExtreme.Utils,
  DevExtreme.Types;

procedure ShowMeta(Options: TJSObject; OkProc: TdxEventHandlerFunc; CancelProc: TProc = nil);

implementation

uses
  Web,
  libjquery,
  DevExtreme.dataGrid,
  DevExtreme.dataGrid.JS,
  DevExtreme.Form,
  DevExtreme.Form.JS,
  DevExtreme.Popup,
  DevExtreme.Popup.JS,
  DevExtreme.TreeList.JS,
  DevExtreme.TabPanel.JS,
  DevExtreme.Button.JS,
  DevExtreme.validation,
  DevExtreme.themes,
  DevExtreme.images,
  DevExtreme.Base,
  zz.Web.JS,
  zz.Web.html,
  DevExtreme.factory,
  DevExtreme.Options,
  zz.Web.json;

type
  TMetaPopup = record
  private
    treeDettagli: TdxTreeList;
    frmProprieta: TdxForm;
    aceJSON: JSValue;
    TabPanel: TdxTabPanel;
    widgetOptions: TJSObject;
    isDataGrid: boolean;
    procedure Init;
  private
    function toolbarButton(const hint, icon, location: string; onClick: TdxEventHandlerFunc): TJSObject;
    function action(const text, icon: string; onClick: TdxEventHandlerFunc): TJSObject;
    function field(const name: string; editorType: string): TJSObject;
    function column(const name: string; dataType: string; const readOnly: boolean = false): TJSObject;
  private
    function DettagliOptions: TJSObject;
    function treeSelectColumn(const name: string; dataType: string; items: TJSArray; const readOnly: boolean): TJSObject;
    function treeDataGridColumns: TJSArray;
    function treeFormItems: TJSArray;
    procedure treeImpostaVisibilita(visibile: boolean);

    function CoalesceColumnValues(columns: TJSArray): TJSArray;
    function CoalesceFormItemValues(items: TJSArray): TJSArray;
  private
    function frmProprietaOptions: TJSObject;
    function frmProprietaItems(data: TJSObject): TJSArray;
  private
    function EditorJsonOptions: TJSObject;
    procedure SetAceInstance(editor: JSValue);
  private type
    TPageKind = (pkDettagli, pkProprieta, pkJSON);
  private
    PrevPage: TPageKind;
    function CurrentPage: TPageKind;
  private
    function EditorID(PageKind: TPageKind): string;
  private
    procedure LoadValues;
    procedure PostValues;

    procedure FixCSS;
  public
    procedure ShowMeta(Options: TJSObject; OkProc: TdxEventHandlerFunc; CancelProc: TProc = nil);
  end;

var
  MetaPopup: TMetaPopup;

function TMetaPopup.toolbarButton(const hint, icon, location: string; onClick: TdxEventHandlerFunc): TJSObject;
var
  Options: TJSObject;
begin
  Options := TJSObject.new;
  Options['icon'] := icon;
  Options['hint'] := hint;
  Options['onClick'] := onClick;
  Options['width'] := 25;

  Result := TJSObject.new;
  Result['location'] := location;
  Result['widget'] := 'dxButton';
  Result['options'] := Options;
end;

function TMetaPopup.action(const text, icon: string; onClick: TdxEventHandlerFunc): TJSObject;
begin
  Result := TJSObject.new;
  Result['text'] := text;
  Result['icon'] := icon;
  Result['onClick'] := onClick;
end;

function TMetaPopup.field(const name: string; editorType: string): TJSObject;
begin
  Result := TJSObject.new;
  Result['name'] := name;
  Result['dataField'] := name;
  Result['label'] := name;
  Result['editorType'] := editorType;
end;

function TMetaPopup.column(const name: string; dataType: string; const readOnly: boolean = false): TJSObject;
begin
  Result := TJSObject.new;
  Result['name'] := name;
  Result['dataField'] := name;
  Result['caption'] := name;
  Result['dataType'] := dataType;
  Result['allowEditing'] := not readOnly;
end;

function TMetaPopup.treeDataGridColumns: TJSArray;
var
  col: TJSObject;
begin
  Result := TJSArray.new;
  Result.push(column('dataField', 'string', true));
  Result.push(column('caption', 'string'));
  Result.push(column('dataType', 'string', true));
  Result.push(column('hidingPriority', 'number'));
  Result.push(column('visible', 'boolean'));

  // alignment
  // allowEditing
  // allowExporting
  // allowFiltering
  // allowFixing
  // allowGrouping
  // allowHeaderFiltering
  // allowHiding
  // allowReordering
  // allowResizing
  // allowSearch
  // allowSorting
  // autoExpandGroup
  // buttons[]
  // calculateCellValue
  // calculateDisplayValue
  // calculateFilterExpression
  // calculateGroupValue
  // calculateSortValue
  // caption
  // cellComponent
  // cellRender
  // cellTemplate
  // columns
  // cssClass
  // customizeText
  // dataField
  // dataType
  // editCellComponent
  // editCellRender
  // editCellTemplate
  // editorOptions
  // encodeHtml
  // falseText
  // filterOperations
  // filterType
  // filterValue
  // filterValues
  // fixed
  // fixedPosition
  // format
  // formItem
  // groupCellComponent
  // groupCellRender
  // groupCellTemplate
  // groupIndex
  // headerCellComponent
  // headerCellRender
  // headerCellTemplate
  // headerFilter
  // hidingPriority
  // isBand
  // lookup
  // minWidth
  // name
  // ownerBand
  // renderAsync
  // selectedFilterOperation
  // setCellValue
  // showEditorAlways
  // showInColumnChooser
  // showWhenGrouped
  // sortIndex
  // sortingMethod
  // sortOrder
  // trueText
  // type
  // validationRules
  // visible
  // visibleIndex
  // width
end;

function TMetaPopup.CoalesceColumnValues(columns: TJSArray): TJSArray;
var
  i: integer;
  col: TJSObject;
begin

  for i := 0 to columns.length - 1 do
  begin

    if JS.isObject(columns[i]) then
    begin

      col := JS.ToObject(columns[i]);

      if assigned(col) then
        if not col.hasOwnProperty('visible') then
          col['visible'] := true;
    end
    else
      if JS.isString(columns[i]) then
      begin
        // arrivata come array di stringhe, si trasformano in oggetti
        col := new([]);
        col['dataField'] := JS.ToString(columns[i]);
        col['caption'] := JS.ToString(columns[i]);
        col['dataType'] := 'string';
        col['hidingPriority'] := 0;
        col['visible'] := true;
        columns[i] := col;
      end;

    // deve eliminare le colonne Buttons
    Result := columns.filter(
      function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
      var
       o:TJSObject;
      begin
       o :=js.toObject(element);

       result := o.hasOwnProperty('dataField');
      end);
  end;
end;

function TMetaPopup.CoalesceFormItemValues(items: TJSArray): TJSArray;
var
  i: integer;
  item: TJSObject;
  j: JSValue;
begin

  for i := 0 to items.length - 1 do
  begin
    item := JS.ToObject(items[i]);

    j := item['visible'];
    if not assigned(j) then
      item['visible'] := true;

    j := item['IsRequired'];
    if not assigned(j) then
      item['IsRequired'] := false;

    j := item['ReadOnly'];
    if not assigned(j) then
      item['ReadOnly'] := false;
  end;

  Result := items;
end;

function TMetaPopup.treeSelectColumn(const name: string; dataType: string; items: TJSArray; const readOnly: boolean = false): TJSObject;
var
  editorOptions, dropDownOptions: TJSObject;
begin
  Result := TJSObject.new;
  Result['name'] := name;
  Result['dataField'] := name;
  Result['caption'] := name;
  Result['dataType'] := dataType;
  Result['allowEditing'] := not readOnly;
  Result['editorType'] := 'dxSelectBox';

  editorOptions := TjdxForm.editorOptions(Result);
  editorOptions['dataSource'] := items;
  { TODO : keyExpr }
  editorOptions['displayExpr'] := 'text';
  editorOptions['valueExpr'] := 'text';
  editorOptions['searchEnabled'] := true;
  editorOptions['popupHeight'] := 'auto';

  dropDownOptions := TJSObject.new;
  // dropDownOptions['container'] := container;

  editorOptions['dropDownOptions'] := dropDownOptions;
  Result['editorOptions'] := editorOptions;
end;

procedure TMetaPopup.treeImpostaVisibilita(visibile: boolean);
var
  selected: TJSArray;
  data: TJSArray;
begin
  data := JS.ToArray(treeDettagli.option['dataSource']);
  selected := treeDettagli.getSelectedRowsData;

  selected.forEach(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      dataIdx: integer;
      o: TJSObject;
    begin
      { TODO : ridefinire }
      dataIdx := data.indexOf(element);

      if dataIdx <> -1 then
      begin
        o := JS.ToObject(data[dataIdx]);

        if o.hasOwnProperty('visible') then
          o['visible'] := visibile
      end;
    end);

  data := JS.ToArray(treeDettagli.option['dataSource']);
  treeDettagli.option('dataSource', data);
end;

function TMetaPopup.treeFormItems: TJSArray;
var
  col: TJSObject;

  function EditorTypes: TJSArray;
    function Add(text: String): TJSObject;
    begin
      Result := TJSObject.new;
      Result['text'] := text;
    end;

  begin
    Result := TJSArray.new;
    Result.push(Add('dxAutocomplete'));
    Result.push(Add('dxCalendar'));
    Result.push(Add('dxCheckBox'));
    Result.push(Add('dxColorBox'));
    Result.push(Add('dxDateBox'));
    Result.push(Add('dxDropDownBox'));
    Result.push(Add('dxHtmlEditor'));
    Result.push(Add('dxLookup'));
    Result.push(Add('dxNumberBox'));
    Result.push(Add('dxRadioGroup'));
    Result.push(Add('dxRangeSlider'));
    Result.push(Add('dxSelectBox'));
    Result.push(Add('dxSlider'));
    Result.push(Add('dxSwitch'));
    Result.push(Add('dxTagBox'));
    Result.push(Add('dxTextArea'));
    Result.push(Add('dxTextBox'));
  end;

begin
  Result := TJSArray.new;
  Result.push(column('itemType', 'string', true));
  Result.push(column('name', 'string'));
  Result.push(treeSelectColumn('editorType', 'number', EditorTypes, false));
  Result.push(column('dataField', 'string'));
  Result.push(column('caption', 'string'));
  Result.push(column('colSpan', 'number'));
  Result.push(column('IsRequired', 'boolean'));
  Result.push(column('ReadOnly', 'boolean'));
  Result.push(column('visible', 'boolean'));
end;

function TMetaPopup.DettagliOptions: TJSObject;
var
  divTree: TJSHTMLElement;
  el: TJSHTMLElement;
  Options: TJSObject;
  rowDragging: TJSObject;

  function defaultTreeOptions(): TJSObject;

    function TreeSelezionaTutto(e: TJSObject): JSValue;
    begin
      treeDettagli.selectAll;
    end;

    function TreeDeSeleziona(e: TJSObject): JSValue;
    begin
      treeDettagli.deselectAll;
    end;

    function TreeMostraColonne(e: TJSObject): JSValue;
    begin
      treeImpostaVisibilita(true);
    end;

    function TreeNascondiColonne(e: TJSObject): JSValue;
    begin
      treeImpostaVisibilita(false);
    end;

    function AppendFormItemClick(e: TJSObject): JSValue;
    var
      data: TJSArray;
      item: TJSObject;
    begin
      treeDettagli.addRow; { TODO : Specificare il parent }
      { TODO : Consentire il cambio dell'itemType }
      exit;

      data := JS.ToArray(treeDettagli.option['dataSource']);
      item := TJSObject.new;
      item['name'] := 'nuovo';
      data.push(item);
      treeDettagli.option('dataSource', data);
      treeDettagli.navigateToRow('nuovo');
    end;

    function DeleteFormItemClick(e: TJSObject): JSValue;
    begin

      TdxUtils.confirm('Elimina righe', 'Si desidera eliminare le righe selezionate?',
        procedure
        var
          selected: TJSArray;
          data: TJSArray;
        begin
          data := JS.ToArray(treeDettagli.option['dataSource']);
          selected := treeDettagli.getSelectedRowsData;

          selected.forEach(
            function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
            var
              dataIdx: integer;
            begin
              dataIdx := data.indexOf(element);

              if dataIdx <> -1 then
                data.splice(dataIdx, 1);
            end);

          data := JS.ToArray(treeDettagli.option['dataSource']);
          treeDettagli.option('dataSource', data);
        end, nil);
    end;

  var
    editing, scrolling, selection: TJSObject;
  begin
    Result := TJSObject.new;
    Result['dataStructure'] := 'plain';
    Result['keyExpr'] := 'name';
    Result['allowColumnReordering'] := true;
    Result['allowColumnResizing'] := true;
    Result['autoExpandAll'] := true;
    Result['autoNavigateToFocusedRow'] := true;
    Result['columnAutoWidth'] := true;
    Result['columnChooser'] := JSOptions('enabled', true);
    Result['columnFixing'] := true;
    Result['columnHidingEnabled'] := false;
    Result['focusedRowEnabled'] := true;
    Result['height'] := '100%';
    Result['searchPanel'] := JSOptions('visible', true);
    Result['headerFilter'] := JSOptions('visible', true);

    editing := TJSObject.new;
    editing['allowUpdating'] := true;
    editing['allowAdding'] := false;
    editing['allowDeleting'] := false;
    // editing['mode'] := 'popup';
    editing['mode'] := 'cell';
    Result['editing'] := editing;

    selection := TJSObject.new;
    selection['allowSelectAll'] := true;
    selection['mode'] := 'multiple';

    Result['selection'] := selection;

    scrolling := TJSObject.new;
    scrolling['mode'] := 'standard';
    // scrolling['showScrollbar'] := 'always';
    scrolling['showScrollbar'] := 'onHover';
    Result['scrolling'] := scrolling;

    Result['onToolbarPreparing'] := function(e: TJSObject): boolean
      var
        tree: TdxTreeList;
        toolbarOptions: TJSObject;
        items: TJSArray;
      begin
        tree := TdxTreeList(e['component']);
        toolbarOptions := JS.ToObject(e['toolbarOptions']);
        items := JS.ToArray(toolbarOptions['items']);

        items.push(toolbarButton('Seleziona Tutto', imageSelect, 'before', @TreeSelezionaTutto));
        items.push(toolbarButton('Deseleziona', imageUnselect, 'before', @TreeDeSeleziona));
        items.push(toolbarButton('Mostra', imageShow, 'before', @TreeMostraColonne));
        items.push(toolbarButton('Nascondi', imageHide, 'before', @TreeNascondiColonne));

        if not isDataGrid then
        begin
          items.push(toolbarButton('Aggiungi', imageAdd, 'before', @AppendFormItemClick));
          items.push(toolbarButton('Elimina', imageRemove, 'before', @DeleteFormItemClick));
        end;
      end;

    Result['onContextMenuPreparing'] := function(e: TJSObject): JSValue
      var
        items: TJSArray;
      begin
        if e.hasOwnProperty('items') then
        begin
          items := JS.ToArray(e['items']);

          if not assigned(items) then
          begin
            items := TJSArray.new;
            e['items'] := items;
          end;

          items.push(action('Seleziona Tutto', imageSelect, @TreeSelezionaTutto));
          items.push(action('Deseleziona', imageUnselect, @TreeDeSeleziona));
          items.push(action('Mostra', imageShow, @TreeMostraColonne));
          items.push(action('Nascondi', imageHide, @TreeNascondiColonne));

          if not isDataGrid then
          begin
            items.push(action('Aggiungi', imageAdd, @AppendFormItemClick));
            items.push(action('Elimina', imageRemove, @DeleteFormItemClick));
          end;
        end;
      end;
  end;

begin
  Options := defaultTreeOptions();

  if isDataGrid then
  begin
    Options['columns'] := treeDataGridColumns;
    Options['keyExpr'] := 'dataField';
    Options['dataSource'] := CoalesceColumnValues(JS.ToArray(widgetOptions['columns']));
  end
  else
  begin
    Options['columns'] := treeFormItems;
    Options['keyExpr '] := 'name';
    Options['dataSource'] := CoalesceFormItemValues(JS.ToArray(widgetOptions['items']));
    Options['dataStructure'] := 'tree';
    Options['itemsExpr'] := 'items';
  end;

  rowDragging := TJSObject.new;
  rowDragging['allowReordering'] := true;
  rowDragging['allowDropInsideItem'] := not isDataGrid;

  rowDragging['onReorder'] := function(e: TJSObject): JSValue
    var
      tree: TdxTreeList;
      data: TJSArray;
      visibleRows: TJSArray;
      itemData: TJSObject;
      fromIndex: integer;
      toIndex: integer;
      eToIndex: integer;
      visibleRow: TJSObject;
      visibleRowData: TJSObject;
    begin
      tree := TdxTreeList(e['component']);
      data := JS.ToArray(treeDettagli.option('dataSource'));
      { TODO : keyExpr }
      itemData := JS.ToObject(e['itemData']);
      eToIndex := JS.ToInteger(e['toIndex']);

      visibleRows := treeDettagli.getVisibleRows();
      visibleRow := JS.ToObject(visibleRows[eToIndex]);
      visibleRowData := JS.ToObject(visibleRow['data']);
      toIndex := data.indexOf(visibleRowData);
      fromIndex := data.indexOf(itemData);

      data.splice(fromIndex, 1);
      data.splice(toIndex, 0, itemData);
      treeDettagli.refresh();
    end;

  Options['onInitialized'] := function(e: TJSObject): JSValue
    begin
      treeDettagli := TdxTreeList(e['component']);
    end;
  //

  Options['rowDragging'] := rowDragging;

  Result := Options;
end;

function TMetaPopup.frmProprietaItems(data: TJSObject): TJSArray;
var
  propName: string;
  typeOf: string;
  o: TJSObject;
  btn: TJSObject;
  btnOptions: TJSObject;
begin
  Result := TJSArray.new;

  for propName in TJSObject.keys(data) do
  begin
    typeOf := jsTypeOf(data[propName]);

    if typeOf = 'string' then
      Result.push(field(propName, 'dxTextBox'))
    else
      if typeOf = 'number' then
        Result.push(field(propName, 'dxNumberBox'))
      else
        if typeOf = 'bigint' then
          Result.push(field(propName, 'dxNumberBox'))
        else
          if typeOf = 'boolean' then
            Result.push(field(propName, 'dxCheckBox'))
          else
            if typeOf = 'object' then
            begin
              btnOptions := TJSObject.new;
              btnOptions['text'] := propName;
              // btnOptions['type'] := 'default';
              btnOptions['onClick'] := function(e: TJSObject): JSValue
                var
                  btn: TdxButton;
                  propName: string;
                begin
                  btn := TdxButton(e['component']);
                  propName := JS.ToString(btn.option('text'));

                  o := JS.ToObject(data[propName]);

                  Base.Inspect(propName, o, nil, nil);
                end;

              btn := TJSObject.new;
              btn['name'] := propName;
              btn['itemType'] := 'button';
              btn['buttonOptions'] := btnOptions;
              btn['propName'] := propName;
              btn['horizontalAlignment'] := 'left';

              if JS.isNull(data[propName]) then
                btn['disabled'] := true;

              Result.push(btn);
            end;
  end;

  Result.sort(
    function(a, b: JSValue): NativeInt
    var
      sa, sb: string;
    begin
      sa := JS.ToString(JS.ToObject(a)['name']);
      sb := JS.ToString(JS.ToObject(b)['name']);

      if sa = sb then
        Result := 0
      else
        if sa > sb then
          Result := 1
        else
          if sa < sb then
            Result := -1;
    end);
end;

function TMetaPopup.frmProprietaOptions: TJSObject;
begin
  Result := dxOptions.Form('');
  Result['height'] := '100%'; // attiva lo scroll verticale!;
  Result['colCount'] := 1;
  Result['labelMode'] := 'outside';
  Result['items'] := frmProprietaItems(widgetOptions);
  Result['formData'] := widgetOptions;
  Result['onInitialized'] := function(e: TJSObject): JSValue
    begin
      frmProprieta := TdxForm(e['component']);
    end;
end;

function TMetaPopup.EditorJsonOptions: TJSObject;
var
  s: string;
begin
  s := Stringify(widgetOptions, true);

  Result := new([]);
  Result['mode'] := 'ace/mode/json';
  Result['value'] := s;

  if TdxThemes.dark then
    Result['theme'] := 'ace/theme/tomorrow_night_blue'
  else
    Result['theme'] := 'ace/theme/tomorrow';
end;

procedure TMetaPopup.ShowMeta(Options: TJSObject; OkProc: TdxEventHandlerFunc; CancelProc: TProc = nil);

  procedure doOk(closeProc: TProc);
  begin
    PostValues;

    if assigned(OkProc) then
      OkProc(widgetOptions);

    closeProc;
  end;

  procedure doCancel(closeProc: TProc);
  begin
    if assigned(CancelProc) then
      CancelProc;

    closeProc;
  end;

/// ///////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////

/// ///////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////
/// ///////////////////////////////////////////////////////////////////////////
var
  title: string;
  popOptions: TJSObject;
  popContentId: string;
  tabPanelOptions: TJSObject;

  items: TJSArray;
  item: TJSObject;
  s: String;
begin
  Init;

  // s := Stringify(Options, true);
  // widgetOptions := parse(s);
  widgetOptions := Options;

  isDataGrid := widgetOptions.hasOwnProperty('columns');

  title := JS.ToString(widgetOptions['_dm']) + '.' + JS.ToString(widgetOptions['_dataset']);

  if isDataGrid then
    title := 'dxDataGrid: ' + title
  else
    title := 'dxForm: ' + title;

  /// /////////////////////////////////////////////////

  tabPanelOptions := TJSObject.new;
  tabPanelOptions['scrollingEnabled'] := true;

  /// /////////////////////////////////////////////////

  items := TJSArray.new;
  // ---------------------------
  // pagina Dettagli
  item := new([]);
  item['title'] := 'Dettagli';
  item['template'] := function(): JSValue
    var
      Options: TJSObject;
      res: JSValue;
      id: string;
    begin // @CreaDettagli

      id := EditorID(pkDettagli);
      Options := DettagliOptions();

      asm
        var containedID=id+'Container';
        res = $("<div id=containedID></div>");
        var treeDettagli = $('<div>').attr('id', id).css('margin-top', '7px').appendTo(res);
        treeDettagli.dxTreeList(Options);
      end;

      Result := res;
    end;
  items.push(item);
  // ---------------------------
  // pagina Proprietà
  item := new([]);
  item['title'] := 'Proprietà';
  item['template'] := function(): JSValue
    var
      id: string;
      Options: TJSObject;
      res: JSValue;
    begin // @Crea Proprietà
      id := EditorID(pkProprieta);
      Options := frmProprietaOptions;

      asm
        var containedID=id+'Container';
        res = $("<div id=containedID></div>").css('height', '100%');
        var divProprieta = $('<div>').attr('id', id).css('margin', '7px').appendTo(res);
        divProprieta.dxForm(Options);
      end;

      Result := res;
    end;
  items.push(item);
  // ---------------------------
  // pagina JSON
  item := new([]);
  item['title'] := 'Json';
  item['template'] := function(): JSValue
    var
      id: string;
      Options: TJSObject;
      res: JSValue;
      s: string;
      editor: JSValue;
    begin // @Editor Json
      id := EditorID(pkJSON);
      Options := EditorJsonOptions;

      asm
        var containedID=id+'Container';
        res = $("<div id=containedID></div>").css('width', '100%').css('height', '100%');
        var divJSON = $('<div>').attr('id', id).css('width', '100%').css('height', '100%').appendTo(res);
        editor = ace.edit(divJSON.get(0), Options);
      end;

      SetAceInstance(editor);
      Result := res;
    end;
  items.push(item);
  // ---------------------------

  tabPanelOptions['items'] := items;
  tabPanelOptions['selectedIndex'] := 0;

  tabPanelOptions['onSelectionChanged'] := function(e: TJSObject): boolean
    begin
      PostValues;
      LoadValues;
      PrevPage := CurrentPage;
    end;

  /// /////////////////////////////////////////////////

  popOptions := dxOptions.Popup(title, not TdxThemes.dark);
  popContentId := TjdxPopup.ContentId(popOptions);

  popOptions['onShown'] := function(e: TJSObject): JSValue
    var
      popDiv, tabPanelDIV: TJSHTMLElement;
    begin
      // popup
      popDiv := TJSHTMLElement(document.getElementById(popContentId));

      // tabPanel
      tabPanelDIV := _div(popDiv, 'tabPanel');
      tabPanelDIV.style.setProperty('width', '100%');
      tabPanelDIV.style.setProperty('height', '100%');
      tabPanelDIV.style.setProperty('max-height', '100%');

      TabPanel := dxFactory.TabPanel('#tabPanel', tabPanelOptions);

      FixCSS;
    end;

  popOptions['width'] := '80%';
  popOptions['height'] := '80%';

  TjdxPopup.ShowPopupModal(popOptions, @doOk, @doCancel);
end;

procedure TMetaPopup.FixCSS;
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

procedure TMetaPopup.Init;
begin
  PrevPage := pkDettagli;
  treeDettagli := nil;
  frmProprieta := nil;
  aceJSON := nil;
  TabPanel := nil;

  widgetOptions := nil;
  isDataGrid := false;
end;

procedure TMetaPopup.SetAceInstance(editor: JSValue);
begin
  aceJSON := editor;
end;

function TMetaPopup.EditorID(PageKind: TPageKind): string;
begin
  case PageKind of
    pkDettagli:
      Result := 'treeDettagli';
    pkProprieta:
      Result := 'formProprieta';
    pkJSON:
      Result := 'editorJSON';
  end;
end;

function TMetaPopup.CurrentPage: TPageKind;
var
  j: JSValue;
  idx: integer;
begin
  j := TabPanel.option('selectedIndex');
  idx := JS.ToInteger(j);

  case idx of
    0:
      Result := pkDettagli;
    1:
      Result := pkProprieta;
    2:
      Result := pkJSON;
  end;
end;

procedure TMetaPopup.LoadValues;
var
  page: TPageKind;
  s: String;
begin
  // chiamata da onSelectionChanged

  page := CurrentPage;

  if page = pkDettagli then
  begin

    if treeDettagli <> nil then
    begin
      if isDataGrid then
        treeDettagli.option('dataSource', CoalesceColumnValues(JS.ToArray(widgetOptions['columns'])))
      else
        treeDettagli.option('dataSource', CoalesceFormItemValues(JS.ToArray(widgetOptions['items'])));
    end;

  end
  else
    if page = pkProprieta then
    begin

      if frmProprieta <> nil then
      begin
        frmProprieta.option('formData', widgetOptions);
      end;
    end
    else
      if page = pkJSON then
      begin

        if aceJSON <> nil then
        begin
          s := Stringify(widgetOptions, true);

          asm
            this.aceJSON.setValue(s);
          end;
        end;
      end;
end;

procedure TMetaPopup.PostValues;
var
  page: TPageKind;
  s: string;
  o: TJSObject;
begin
  // chiamata da titleClick e in chiusura

  page := PrevPage;

  if page = pkDettagli then
  begin

    if treeDettagli <> nil then
    begin

      if treeDettagli.hasEditData then
        treeDettagli.saveEditData();

      if isDataGrid then
        widgetOptions['columns'] := treeDettagli.option('dataSource')
      else
        widgetOptions['items'] := treeDettagli.option('dataSource');
    end;
  end
  else
    if page = pkProprieta then
    begin

      if frmProprieta <> nil then
      begin
        // frmProprieta.option('formData', widgetOptions);
      end;
    end
    else
      if page = pkJSON then
      begin
        if aceJSON <> nil then
        begin
          asm
            s = this.aceJSON.getValue();
          end;

          o := parse(s);
          widgetOptions := o;
        end;
      end;
end;

procedure ShowMeta(Options: TJSObject; OkProc: TdxEventHandlerFunc; CancelProc: TProc = nil);
begin
  MetaPopup.ShowMeta(Options, OkProc, CancelProc);
end;

end.
