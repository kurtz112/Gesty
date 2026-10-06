unit MetaDlg;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  JS,
  Web,
  libjquery,
  WEBLib.Graphics,
  WEBLib.Controls,
  WEBLib.Forms,
  WEBLib.Dialogs,
  BaseWebFrm,
  BaseWebModalFrm,
  DevExtreme,
  DevExtreme.Types;

type
  TMetaDialog = class(TBaseWebModalForm)
  private
    tabPanelDIV: TJSHTMLElement;
    tabPanel: TdxTabPanel;
    tree: TdxTreeList;
    form: TdxForm;
    isDataGrid: boolean;
  private
    function action(const text, icon: string; onClick: TdxEventHandler): TJSObject;
    function toolbarButton(const hint, icon, location: string; onClick: TdxEventHandler): TJSObject;
    function column(const name: string; dataType: string; const readOnly: boolean = false): TJSObject;
    function field(const name: string; editorType: string): TJSObject;
  private
    procedure CreateTabPanel(isDataGrid: boolean);

    function defaultTreeOptions(const isDataGrid: boolean): TJSObject;
    function defaultFormOptions: TJSObject;
    function defaultFormItems(data: TJSObject): TJSArray;
  private
    function CoalesceColumnValues(columns: TJSArray): TJSArray;
    function CoalesceFormItemValues(items: TJSArray): TJSArray;
  private
    function dataGridColumns: TJSArray;
    function dataGridProps: TJSArray;

    function formItems: TJSArray;
    function formProps: TJSArray;
  private
    procedure createTreeDataGrid;
    procedure createTreeForm;

    procedure createFormDataGrid;
    procedure createFormForm;
  private
    procedure TreeImpostaVisibilita(visibile: boolean);
    function TreeSelezionaTutto(e: TJSObject): boolean;
    function TreeDeSeleziona(e: TJSObject): boolean;
    function TreeMostraColonne(e: TJSObject): boolean;
    function TreeNascondiColonne(e: TJSObject): boolean;

    function AppendFormItemClick(e: TJSObject): boolean;
    function DeleteFormItemClick(e: TJSObject): boolean;
  protected
    function DefaultWidth: integer; override;
    function DefaultHeight: integer; override;
    procedure Resized; override;
  public
    procedure AfterCreate(const id: integer; data: TJSObject; OkProc: TProc); override;
  end;

var
  MetaDialog: TMetaDialog;

procedure EditMeta(options: TJSObject; OkProc: TProc);

implementation

uses
  System.Math,
  zz.Web.JS,
  zz.Web.html,
  DevExtreme.Types,
  DevExtreme.form,
  DevExtreme.Datagrid,
  DevExtreme.images,
  AppController,
  InspectorDlg,
  images;

{$R *.dfm}
{ TMetaDialog }

function TMetaDialog.action(const text, icon: string; onClick: TdxEventHandler): TJSObject;
begin
  Result := TJSObject.new;
  Result['text'] := text;
  Result['icon'] := icon;
  Result['onClick'] := onClick;
end;

procedure TMetaDialog.AfterCreate(const id: integer; data: TJSObject; OkProc: TProc);
var
  options: TJSObject;
  cards: TJSArray;
  columns: TJSArray;
  metaName: string;
begin
  inherited;
  // HeaderImage := imageGeraScadenze;

  metaName := JS.ToString(data['_dm']) + '.' + JS.ToString(data['_dataset']);
  isDataGrid := data.hasOwnProperty('columns');

  if isDataGrid then
    CreateHEADER('dxDataGrid: ' + metaName)
  else
    CreateHEADER('dxForm: ' + metaName);

  Moveable := true;

  /// ///

  OkProc := OkProc;

  options := TJSObject.new;
  options['scrollingEnabled'] := true;
  options['onItemRendered'] := function(e: TJSObject): boolean
    var
      id: string;
      itemIndex: integer;
      options: TJSObject;
    begin
      itemIndex := JS.ToInteger(e['itemIndex']);

      if itemIndex = 0 then
      begin

        if not assigned(tree) then
        begin
          if isDataGrid then
            createTreeDataGrid
          else
            createTreeForm;
        end;
      end
      else
        if itemIndex = 1 then
        begin

          if not assigned(form) then
          begin
            if isDataGrid then
              createFormDataGrid
            else
              createFormForm;
          end;
        end
    end;

  CreateTabPanel(isDataGrid);
  tabPanel := dx.factory.tabPanel('#TabPanel', options);

  CreateOkCancel('Ok', 'Annulla');

  // ////////////////////////////////////////////
  tabPanelDIV.style.setProperty('width', '100%');
  tabPanelDIV.style.setProperty('top', JQuery(HeaderDIV).outerHeight(true).ToString + 'px');
  tabPanelDIV.style.setProperty('bottom', JQuery(OkCancelDIV).outerHeight(true).ToString + 'px');
  //
end;

procedure TMetaDialog.CreateTabPanel(isDataGrid: boolean);
var
  e: TJSHTMLElement;
  titolo: string;
begin
  // <div style="margin-top: 14px;">
  // <div id="TabPanel">
  //
  // <div data-options="dxItem: { title: 'DataGrid' }">
  // <div id="treeDataGrid"></div>
  // </div>
  //
  // <div data-options="dxItem: { title: 'Form' }">
  // <div id="treeForm"></div>
  // </div>
  //
  // <div data-options="dxItem: { title: 'DataSet' }">
  // <div id="DataSet"></div>
  // </div>
  //
  // </div>
  // </div>

  VSpace(15);
  e := CreateDIV('');

  tabPanelDIV := _DIV(e, 'TabPanel');

  if isDataGrid then
    titolo := 'Colonne'
  else
    titolo := 'Campi';

  // Dettagli
  e := _DIV(tabPanelDIV, 'tabDettagli');
  e.setAttribute('data-options', 'dxItem: { title: ''' + titolo + ''' }');
  e := _DIV(e, 'treeDettagli');

  // Proprietà
  e := _DIV(tabPanelDIV, 'Proprieta');
  e.setAttribute('data-options', 'dxItem: { title: ''Proprietà'' }');
  e := _DIV(e, 'formProprieta');
end;

function TMetaDialog.DefaultWidth: integer;
begin
  Result := Min(Trunc(window.InnerWidth * 0.8), 600);
end;

function TMetaDialog.DefaultHeight: integer;
begin
  Result := Min(Trunc(window.InnerHeight * 0.8), 600);
end;

function TMetaDialog.CoalesceColumnValues(columns: TJSArray): TJSArray;
var
  i: integer;
  col: TJSObject;
  j: JSValue;
begin

  for i := 0 to columns.length - 1 do
  begin
    col := JS.ToObject(columns[i]);
    j := col['visible'];

    if not assigned(j) then
      col['visible'] := true;
  end;

  Result := columns;
end;

function TMetaDialog.CoalesceFormItemValues(items: TJSArray): TJSArray;
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

function TMetaDialog.defaultFormItems(data: TJSObject): TJSArray;
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
                  InspectObject(propName, o,
                    procedure
                    begin
                    end);
                end;

              btn := TJSObject.new;
              btn['name'] := propName;
              btn['itemType'] := 'button';
              btn['buttonOptions'] := btnOptions;
              btn['propName'] := propName;

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

function TMetaDialog.defaultFormOptions: TJSObject;
begin
  Result := dxFormOptions;
  Result['height'] := '100%'; // attiva lo scroll verticale!;
  Result['colCount'] := 1;
end;

function TMetaDialog.defaultTreeOptions(const isDataGrid: boolean): TJSObject;
var
  editing, scrolling, selection: TJSObject;
begin
  Result := TJSObject.new;
  // result['dataStructure'] := 'tree';
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
  // |||||||||||||||||||||||||||||||||||||||||
  Result['focusedRowEnabled'] := true; // |||||||||||||||||||||||||||||||||||||||||
  Result['height'] := '100%'; // |||||||||||||||||||||||||||||||||||||||||

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

function TMetaDialog.field(const name: string; editorType: string): TJSObject;
begin
  Result := TJSObject.new;
  Result['name'] := name;
  Result['dataField'] := name;
  Result['label'] := name;
  Result['editorType'] := editorType;
end;

function TMetaDialog.column(const name: string; dataType: string; const readOnly: boolean = false): TJSObject;
begin
  Result := TJSObject.new;
  Result['name'] := name;
  Result['dataField'] := name;
  Result['caption'] := name;
  Result['dataType'] := dataType;
  Result['allowEditing'] := not readOnly;
end;

function TMetaDialog.dataGridColumns: TJSArray;
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

function TMetaDialog.dataGridProps: TJSArray;
begin
  Result := defaultFormItems(data);
end;

function TMetaDialog.formItems: TJSArray;
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

  function SelectColumn(const name: string; dataType: string; items: TJSArray; const readOnly: boolean = false): TJSObject;
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

    editorOptions := dxGetEditorOptions(Result);
    editorOptions['dataSource'] := items;
    editorOptions['displayExpr'] := 'text';
    editorOptions['valueExpr'] := 'text';
    editorOptions['searchEnabled'] := true;
    editorOptions['popupHeight'] := 'auto';

    dropDownOptions := TJSObject.new;
    // dropDownOptions['container'] := container;

    editorOptions['dropDownOptions'] := dropDownOptions;
    Result['editorOptions'] := editorOptions;
  end;

begin
  Result := TJSArray.new;
  Result.push(column('itemType', 'string', true));
  Result.push(column('name', 'string'));
  Result.push(SelectColumn('editorType', 'number', EditorTypes, false));
  Result.push(column('dataField', 'string'));
  Result.push(column('caption', 'string'));
  Result.push(column('colSpan', 'number'));
  Result.push(column('IsRequired', 'boolean'));
  Result.push(column('ReadOnly', 'boolean'));
  Result.push(column('visible', 'boolean'));
end;

function TMetaDialog.formProps: TJSArray;
begin
  Result := defaultFormItems(data);
end;

procedure TMetaDialog.Resized;
var
  h: integer;
begin
  inherited;

  h := FormHeight;
  h := h - 14;
  h := h - JQuery(HeaderDIV).outerHeight(true);
  h := h - JQuery(OkCancelDIV).outerHeight(true);

  tabPanelDIV.style.setProperty('height', h.ToString + 'px');
end;

function TMetaDialog.toolbarButton(const hint, icon, location: string; onClick: TdxEventHandler): TJSObject;
var
  options: TJSObject;
begin
  options := TJSObject.new;
  options['icon'] := icon;
  options['hint'] := hint;
  options['onClick'] := onClick;
  options['width'] := 25;

  Result := TJSObject.new;
  Result['location'] := location;
  Result['widget'] := 'dxButton';
  Result['options'] := options;
end;

function TMetaDialog.TreeMostraColonne(e: TJSObject): boolean;
begin
  TreeImpostaVisibilita(true);
end;

function TMetaDialog.TreeNascondiColonne(e: TJSObject): boolean;
begin
  TreeImpostaVisibilita(false);
end;

function TMetaDialog.TreeDeSeleziona(e: TJSObject): boolean;
begin
  tree.deselectAll;
end;

function TMetaDialog.TreeSelezionaTutto(e: TJSObject): boolean;
begin
  tree.selectAll;
end;

procedure TMetaDialog.TreeImpostaVisibilita(visibile: boolean);
var
  selected: TJSArray;
  data: TJSArray;
begin
  data := JS.ToArray(tree.option['dataSource']);
  selected := tree.getSelectedRowsData;

  selected.forEach(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      dataIdx: integer;
      o: TJSObject;
    begin
      dataIdx := data.indexOf(element);

      if dataIdx <> -1 then
      begin
        o := JS.ToObject(data[dataIdx]);

        if o.hasOwnProperty('visible') then
          o['visible'] := visibile
      end;
    end);

  data := JS.ToArray(tree.option['dataSource']);
  tree.option('dataSource', data);
end;

procedure TMetaDialog.createTreeDataGrid;
var
  options: TJSObject;
  rowDragging: TJSObject;
begin
  options := defaultTreeOptions(true);
  options['columns'] := dataGridColumns;
  options['dataSource'] := CoalesceColumnValues(JS.ToArray(data['columns']));

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
      data := JS.ToArray(tree.option('dataSource'));
      itemData := JS.ToObject(e['itemData']);
      eToIndex := JS.ToInteger(e['toIndex']);

      visibleRows := tree.getVisibleRows();
      visibleRow := JS.ToObject(visibleRows[eToIndex]);
      visibleRowData := JS.ToObject(visibleRow['data']);
      toIndex := data.indexOf(visibleRowData);
      fromIndex := data.indexOf(itemData);

      data.splice(fromIndex, 1);
      data.splice(toIndex, 0, itemData);
      tree.refresh();
    end;
  options['rowDragging'] := rowDragging;

  tree := dx.factory.TreeList('#treeDettagli', options);
end;

procedure TMetaDialog.createTreeForm;
var
  options: TJSObject;
  rowDragging: TJSObject;
begin
  options := defaultTreeOptions(false);
  options['columns'] := formItems;
  options['dataSource'] := CoalesceFormItemValues(JS.ToArray(data['items']));
  options['dataStructure'] := 'tree';
  options['itemsExpr'] := 'items';

  rowDragging := TJSObject.new;
  rowDragging['allowReordering'] := true;
  rowDragging['allowDropInsideItem'] := not isDataGrid;

  // rowDragging['onAdd'] := function(e: TJSObject): JSValue
  // rowDragging['onRemove'] := function(e: TJSObject): JSValue
  // https: // js.devexpress.com/Demos/WidgetsGallery/Demo/TreeView/DragAndDropHierarchicalDataStructure/jQuery/Light/

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
      data := JS.ToArray(tree.option('dataSource'));
      itemData := JS.ToObject(e['itemData']);
      eToIndex := JS.ToInteger(e['toIndex']);

      visibleRows := tree.getVisibleRows();
      visibleRow := JS.ToObject(visibleRows[eToIndex]);
      visibleRowData := JS.ToObject(visibleRow['data']);
      toIndex := data.indexOf(visibleRowData);
      fromIndex := data.indexOf(itemData);

      data.splice(fromIndex, 1);
      data.splice(toIndex, 0, itemData);
      tree.refresh();
    end;
  options['rowDragging'] := rowDragging;

  tree := dx.factory.TreeList('#treeDettagli', options);
end;

function TMetaDialog.DeleteFormItemClick(e: TJSObject): boolean;
begin
  dx.utils.confirm('Elimina righe', 'Si desidera eliminare le righe selezionate?',
    procedure
    var
      selected: TJSArray;
      data: TJSArray;
    begin
      data := JS.ToArray(tree.option['dataSource']);
      selected := tree.getSelectedRowsData;

      selected.forEach(
        function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
        var
          dataIdx: integer;
        begin
          dataIdx := data.indexOf(element);

          if dataIdx <> -1 then
            data.splice(dataIdx, 1);
        end);

      data := JS.ToArray(tree.option['dataSource']);
      tree.option('dataSource', data);
    end, nil);
end;

function TMetaDialog.AppendFormItemClick(e: TJSObject): boolean;
var
  data: TJSArray;
  item: TJSObject;
begin
  tree.addRow; { TODO : Specificare il parent }
  { TODO : Consentire il cambio dell'itemType }
  exit;

  data := JS.ToArray(tree.option['dataSource']);
  item := TJSObject.new;
  item['name'] := 'nuovo';
  data.push(item);
  tree.option('dataSource', data);
  tree.navigateToRow('nuovo');
end;

procedure TMetaDialog.createFormDataGrid;
var
  options: TJSObject;
begin
  options := defaultFormOptions;
  options['items'] := dataGridProps;

  options['formData'] := data;
  form := dxForm('#formProprieta', options);
end;

procedure TMetaDialog.createFormForm;
var
  options: TJSObject;
begin
  options := defaultFormOptions;
  options['items'] := formProps;

  options['formData'] := data;
  form := dxForm('#formProprieta', options);
end;

procedure EditMeta(options: TJSObject; OkProc: TProc);
begin
  Controller.utils.Meta(options, OkProc);
end;

initialization

dxDataGridEditOptions := EditMeta;
dxFormEditOptions := EditMeta;

end.
