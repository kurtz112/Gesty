unit DevExtreme.lookup;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  WEBLib.db,
  WEBLib.JSON,
  WEBLib.REST,
  js,
  libjquery,
  web,
  DevExtreme.Types,
  DevExtreme;

// type
// TdxLookup = class
// public
//
// end;

function dxLookupDataSource(const dataset: string; meta: TJSObject): TdxDataSource;

procedure dxFormGenerateLookups(dxForm: TdxForm);

procedure dxFormUpdateLookupsParams(dxForm: TdxForm; const dataField: string);
procedure dxFormUpdateLookupParams(dataSource: TdxDataSource; Params: TJSArray; FormData: TJSObject; out paramsChanged: boolean);

// passare una maxwidth del popup
function dxLookupEditorOptions(dxForm: TdxForm; Options: TJSObject; const displayExpr, valueExpr: string; fieldsToCopy: TJSArray; meta: TJSObject): TJSObject;

function dxLookupOptions(dxForm: TdxForm; const displayExpr, valueExpr: string; fieldsToCopy: TJSArray; meta: TJSObject): TJSObject; overload;
function dxLookupOptions(dxForm: TdxForm; const dataset, labelText, displayExpr, valueExpr: string; fieldsToCopy: TJSArray; meta: TJSObject): TJSObject; overload;

const
  dmLookup: string = '';

implementation

uses
  System.StrUtils,
  zz.web.js,
  zz.web.user,
  DevExtreme.data,
  DevExtreme.form,
  DevExtreme.editors,
  DevExtreme.utils,
  DevExtreme.validation,
  DevExtreme.images,
  zz.web.html;

function dxLookupOptions(dxForm: TdxForm; const displayExpr, valueExpr: string; fieldsToCopy: TJSArray; meta: TJSObject): TJSObject;
begin
  result := TJSObject.new;
  result := dxLookupEditorOptions(dxForm, result, displayExpr, valueExpr, fieldsToCopy, meta);
end;

function dxLookupOptions(dxForm: TdxForm; const dataset, labelText, displayExpr, valueExpr: string; fieldsToCopy: TJSArray; meta: TJSObject): TJSObject;
begin
  result := dxLookupOptions(dxForm, displayExpr, valueExpr, fieldsToCopy, meta);

  result['dataSource'] := dxLookupDataSource(dataset, meta);

  result['label'] := labelText;
  result['labelMode'] := 'floating';
end;

function dxLookupDataSource(const dataset: string; meta: TJSObject): TdxDataSource;
var
  dataSource: TdxDataSource;
  pk: string;
  grid: TJSObject;
  columns: TJSArray;
begin
  pk := dxMetaGetPK(meta);

  dataSource := dxDataSource(dmLookup, dataset, pk,
    procedure(Options: TJSObject)
    begin

      Options['postProcess'] := function(data: TJSArray): JSValue
        var
          h: JSValue;
          HeaderAggiunti: boolean;
          header: TJSObject;
        begin
          /// //////////////////////////////////////////////////////////
          // in pratica: se arriva il campo DISABLED lo rende lowercase
          if data.length > 1 then
            if js.ToObject(data[1]).hasOwnProperty('DISABLED') then
              data.forEach(
                function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
                var
                  item: TJSObject;
                begin

                  if index > 0 then
                  begin
                    item := js.ToObject(element);
                    item['disabled'] := item['DISABLED'];
                  end;
                end);

          /// //////////////////////////////////////////////////////////
          /// Header delle colonne
          HeaderAggiunti := js.ToBoolean(dataSource['headerAggiunti']);
          dataSource['headerAggiunti'] := true;

          if not HeaderAggiunti then // header non aggiunti
          begin
            header := TJSObject.new;

            grid := TJSObject(TJSArray(meta['Views'])[0]);
            columns := js.ToArray(grid['columns']);

            columns.forEach(
              function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
              var
                col: TJSObject;
              begin
                col := js.ToObject(element);

                if dxColumnVisible(col) then
                  header[js.ToString(col['dataField'])] := js.ToString(col['caption']);
              end);

            // data.unshift({ orderID: "OrderID", customerName: "CustomerName", shipCountry: "ShipCountry", shipCity: "ShipCity", disabled: true });

            header['disabled'] := true;
            data.unshift(header);
          end;

          result := data;
        end;
    end, nil);

  dataSource['dataset'] := dataset;
  result := dataSource;
end;

procedure dxFormGenerateLookups(dxForm: TdxForm);
var
  items: TJSArray;
begin
  items := dxForm.items;

  items.forEach(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      item: TJSObject;
      lookupOptions: TJSObject;
      editorOptions: TJSObject;
      dataset: string;
    begin
      item := js.ToObject(element);
      editorOptions := TdxFormUtils.EditorOptions(item, true);

      if TdxFormUtils.ItemType(item) = itSimple then
        if TdxFormUtils.EditorType(item) = TdxEditorType.dxLookup then
          if editorOptions['dataSource'] = null then
          begin
            lookupOptions := js.ToObject(item['lookupOptions']);
            dataset := js.ToString(lookupOptions['dataset']);

            dxMeta(dmLookup, dataset,
              procedure(meta: TJSObject)
              var
                editorOptions: TJSObject;
                lookupOptions: TJSObject;
                dataSource: TdxDataSource;
                displayExpr, valueExpr: string;
                dataField: string;
                Params: TJSArray;
                paramsChanged: boolean;
                fieldsToCopy: TJSArray;
              begin
                dataField := js.ToString(item['dataField']);
                lookupOptions := js.ToObject(item['lookupOptions']);
                displayExpr := js.ToString(lookupOptions['displayExpr']);
                valueExpr := js.ToString(lookupOptions['valueExpr']);
                fieldsToCopy := js.ToArray(lookupOptions['fieldsToCopy']);
                Params := js.ToArray(lookupOptions['params']);

                editorOptions := TdxFormUtils.EditorOptions(item, true);
                // !pk e view per le colonne
                dataSource := dxLookupDataSource(dataset, meta);
                // ! aggiunge parametri a dataSource
                dxFormUpdateLookupParams(dataSource, Params, dxForm.FormData, paramsChanged);

                editorOptions := dxLookupEditorOptions(dxForm, editorOptions, displayExpr, valueExpr, fieldsToCopy, meta); // itemTemplate; popupWidth
                editorOptions['dataSource'] := dataSource;

                DebugString('GenerateLookup: ' + dataField);
                dxForm.itemOption(dataField, 'editorOptions', editorOptions);
              end);
          end;
    end);
end;

procedure dxFormUpdateLookupsParams(dxForm: TdxForm; const dataField: string);
begin
  dxForm.EnumLoolups(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      item, lookupOptions, editorOptions: TJSObject;
      dataSource: TdxDataSource;
      Params: TJSArray;
      paramsChanged: boolean;
    begin
      item := js.ToObject(element);

      // il campo appena variato non deve essere resettato
      if sameText(dataField, js.ToString(item['dataField'])) then
        exit;

      lookupOptions := js.ToObject(item['lookupOptions']);
      Params := js.ToArray(lookupOptions['params']);
      editorOptions := TdxFormUtils.EditorOptions(item, true);
      dataSource := TdxDataSource(editorOptions['dataSource']);

      dxFormUpdateLookupParams(dataSource, Params, dxForm.FormData, paramsChanged);

      if paramsChanged then
      begin
        dataSource['headerAggiunti'] := false;
        dataSource.pageIndex(0); // altrimenti non riapre i combo
        dataSource.reload;
      end;
    end);
end;

procedure dxFormUpdateLookupParams(dataSource: TdxDataSource; Params: TJSArray; FormData: TJSObject; out paramsChanged: boolean);
begin

  paramsChanged := false;
  Params.forEach(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      s, src, dest: string;
      idx: integer;
      Value: JSValue;
    begin
      s := js.ToString(element);

      idx := s.IndexOf('=');
      if idx >= 0 then
      begin
        src := s.Substring(0, idx);
        dest := s.Substring(idx + 1);
      end
      else
      begin
        src := s;
        dest := s;
      end;

      Value := FormData[dest];

      if js.IsDate(Value) then
      begin
        Value := JSDateToStringISO(TJSDate(Value));
      end;

      // paramsChanged
      if dataSource.GetParam(src) <> Value then
      begin
        dataSource.AddParam(src, Value);
        paramsChanged := true;
        // DebugString('paramsChanged [' + js.ToString(dataSource['name']) + ']: ' + src);
      end;
    end);
end;

function dxLookupEditorOptions(dxForm: TdxForm; Options: TJSObject; const displayExpr, valueExpr: string; fieldsToCopy: TJSArray; meta: TJSObject): TJSObject;
var
  grid: TJSObject;
  columns: TJSArray;
  dropDownOptions: TJSObject;
  popupWidth: integer;
  numeroColonneVisibili: integer;
const
  SeparatorW = 7;
begin
  grid := TJSObject(TJSArray(meta['Views'])[0]);
  columns := js.ToArray(grid['columns']);

  // può settare EditorOptions oppure un dxLookup
  result := Options;
  result['valueExpr'] := valueExpr;
  result['displayExpr'] := displayExpr;
  result['searchExpr'] := displayExpr;

  result['searchEnabled'] := true;
  result['searchTimeout'] := 300;
  result['searchMode'] := 'startswith';
  result['showDataBeforeSearch'] := true;
  result['minSearchLength'] := 0;
  result['popupHeight'] := 'auto';
  result['showCancelButton'] := true;
  result['showClearButton'] := true;
  result['wrapItemText'] := false;

  /// ////////////////////////////////////////
  /// ////////////////////////////////////////
  /// ////////////////////////////////////////
  // larghezza del dropDown
  popupWidth := 0; // eliminare
  numeroColonneVisibili := 0;
  columns.forEach(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      col: TJSObject;
    begin
      col := js.ToObject(element);

      if dxColumnVisible(col) then
      begin
        inc(popupWidth, dxColumnWidth(col) + SeparatorW);
        inc(numeroColonneVisibili);
      end;
    end);

  /// ///////////////////////////////////////////

  dropDownOptions := js.ToObject(result['dropDownOptions']);
  if not assigned(dropDownOptions) then
    dropDownOptions := TJSObject.new;

  // dropDownOptions['container'] := dxForm.element;
  dropDownOptions['resizeEnabled'] := true;
  dropDownOptions['fullScreen'] := tdxutils.ScreenSize < ssMedium;
  // dropDownOptions['hideOnParentScroll'] := tdxutils.ScreenSize >= ssMedium;
  result['dropDownOptions'] := dropDownOptions;

  /// ///////////////////////////////////////////
  // CopyLookupFields
  if assigned(dxForm) then
  begin
    result['onValueChanged'] := function(e: TJSObject): JSValue
      var
        lookup: TdxLookup;
        selectedItem: TJSObject;
        dataField: string;
      begin
        lookup := TdxLookup(e['component']);
        selectedItem := js.ToObject(lookup.option('selectedItem'));
        dxForm.CopyLookupFields(fieldsToCopy, selectedItem);
        //

        dataField := js.ToString(lookup.option('dataField'));
        console.log('Lookup: ' + dataField, e);
      end;
  end;

  /// ///////////////////////////////////////////

  result['itemTemplate'] := function(data: TJSObject; index: integer; element: JSValue): TJSElement
    var
      row: TJQUery;

      procedure AppendToRow(jq: TJQUery);
      begin
        asm
          jq.appendTo(row);
        end;
      end;

      function CreateRow: TJQUery;
      begin
        result := JQuery('<DIV>');
        result := result.css('display', 'flex');
        result := result.css('flex-direction', 'row');
        result := result.css('flex-wrap', 'nowrap');
      end;

      procedure AddField(const Value: string; w: integer; const FirstField: boolean);
      var
        jq: TJQUery;
      begin
        jq := JQuery('<DIV>');

        if FirstField then
        begin
          jq := jq.css('width', '100%');

          if w > 0 then
            jq := jq.css('min-width', w.ToString + 'px');
        end
        else
          if w <= 0 then
            jq := jq.css('width', '100%')
          else
          begin
            jq := jq.css('width', w.ToString + 'px');
            jq := jq.css('max-width', w.ToString + 'px');
          end;

        jq := jq.css('overflow', 'hidden');
        jq := jq.css('white-space', 'nowrap');
        jq := jq.css('text-overflow', 'ellipsis');

        if not Value.isempty then
          jq := jq.text(Value)
        else
          jq := jq.css('height', '7px');

        AppendToRow(jq);
      end;

      procedure AddSeparator;
      var
        jq: TJQUery;
      begin
        jq := JQuery('<DIV>');
        jq := jq.css('width', SeparatorW.ToString + 'px');
        jq := jq.css('max-width', SeparatorW.ToString + 'px');
        jq := jq.css('height', SeparatorW.ToString + 'px');
        AppendToRow(jq);
      end;

    begin
      row := CreateRow;

      columns.forEach(
        function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
        var
          col: TJSObject;
          Value: string;
          jq: TJQUery;
          w: integer;
        begin
          col := js.ToObject(element);

          if dxColumnVisible(col) then
          begin
            Value := JSValueToString(data[js.ToString(col['dataField'])]);

            if numeroColonneVisibili > 1 then
            begin
              w := dxColumnWidth(col);
              AddField(Value, w, index = 0);
              AddSeparator;
            end
            else
              AddField(Value, -1, index = 0);
          end;
        end);
      asm
        element.append(row); // aggiunge al container
      end;
    end;
end;

end.
