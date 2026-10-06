unit DevExtreme.Form;

interface

uses
  System.SysUtils,
  System.Classes,
  Types,
  WEBLib.Controls,
  jsdelphisystem,
  JS,
  Web,
  libjquery,
  DevExtreme.CustomControl,
  DevExtreme.Form.Custom,
  DevExtreme.Form.JS,
  DevExtreme.Data,
  DevExtreme.Data.JS,
  DevExtreme.Base,
  DevExtreme.Types;

type
  TdxFormInitParams = class;

  TjdxForm = class(TjdxCustomForm)
  public
    // varie
    class function item(const dataField: string; const labelText: String; const required: boolean; LabelOptions: TLabelOptions = DefaultLabelOptions): TJSObject; overload;
    class function item(const editorType: string; const dataField: string; const labelText: String; const required: boolean; LabelOptions: TLabelOptions = DefaultLabelOptions): TJSObject; overload;

    class function ItemType(item: TJSObject): TdxFormItemType;
    class function ItemOptions(FormOptions: TJSObject; const dataField: string): TJSObject; overload;
    class procedure ItemOptions(FormOptions: TJSObject; const dataField: string; ItemOptions: TJSObject); overload;

    class function Group(items: array of TJSObject; colCount: integer = 1): TJSObject; overload;
    class function Group(items: TJSArray; colCount: integer = 1): TJSObject; overload;

    class function EditorOptions(item: TJSObject; const CanCreate: boolean = false): TJSObject; overload;
    class procedure EditorOptions(item: TJSObject; EditorOptions: TJSObject); overload;

    class function editorType(item: TJSObject): TdxFormItemComponent;

    class function ReadOnly(item: TJSObject): boolean; overload;
    class function ReadOnly(item: TJSObject; const ReadOnly: boolean): boolean; overload;

    class function ColCountByScreen(const lg, md, sm, xs: integer): TJSObject;
  public
    class function ItemEmpty: TJSObject;
    class function Label_(const text: String; const Bold: boolean; const visible: boolean): TJSObject;
    class function PlaceHolder(const text: String): TJSObject;
  public
    class function Password(const dataField: string; const labelText: String; const required: boolean; LabelOptions: TLabelOptions = DefaultLabelOptions): TJSObject;
    class function CheckBox(const dataField: string; const labelText: String; const required: boolean; LabelOptions: TLabelOptions = DefaultLabelOptions): TJSObject;
    class function Email(const dataField: string; const labelText: String; const required: boolean; LabelOptions: TLabelOptions = DefaultLabelOptions): TJSObject;
    class function Slider(const dataField: string; const labelText: String; const required: boolean; LabelOptions: TLabelOptions = DefaultLabelOptions): TJSObject;
    class function Button(const name: string; btnText: string; icon: string; btnType: TdxButtonType; btnStyle: TdxButtonStyle; HorizontalAlignment: TdxHorizontalAlignment;
      onClick: TdxEventHandlerFunc): TJSObject;
  end;

  TdxFormHelper = class helper for TdxForm
  private
    function GetItems: TJSArray;
    function GetData: TJSObject;
    procedure SetData(const Value: TJSObject);
  public // button
    function getButtonOptions(btnName: string): TJSObject; assembler;
    function getButtonOption(btnName: string; optionName: string): JSValue; assembler;
    procedure setButtonOption(btnName: string; optionName: string; optionValue: JSValue); assembler;
    procedure ButtonEnabled(btnName: string; const enabled: boolean);
  public // editor
    function getEditorValue(dataField: string): JSValue; assembler;
    procedure Placeholders(const enabled: boolean);
  public // item
    function ItemReadOnly(item: TJSObject): boolean; overload;
    function ItemReadOnly(const dataField: string): boolean; overload;

    function ItemDisabled(item: TJSObject): boolean; overload;
    function ItemDisabled(const dataField: string): boolean; overload;

    function ItemByName(const dataField: string): TJSObject;
  public // focus
    function NextItem(const dataField: string): string;
    procedure FocusNextItem(const itemName: string);
    procedure FocusEditor(const dataField: string);
    procedure FocusButton(const name: string);
    function Focused: string;
  private
    procedure EnumItems(aCallBack: TJSArrayCallBack);
    procedure RegisterFocusEvents;
  public // size
    function ScrollWidth: integer; assembler;
    function ScrollHeight: integer; assembler;
    procedure ScrollBarVisible(const visible: boolean);
    procedure ScrollBarDirection(const direction: string);
  public
    procedure UpdateLookupParams(dataSource: TdxDataSource; Params: TJSArray; out paramsChanged: boolean);
    procedure UpdateLookupsParams(const dataField: string);

    procedure ClearDependentFields(const dataField: string);
  public
    procedure EnumLoolups(aCallBack: TJSArrayCallBack);
    procedure CopyLookupFields(fieldsToCopy: TJSArray; selectedItem: TJSObject);
    procedure FieldChanged(const dataField: string; Value: JSValue);

    procedure DisableFieldChanged;
    procedure EnableFieldChanged;
    function FieldChangedDisabled: boolean;
  public
    procedure ResetModified;
    function isModified: boolean;
  public
    property items: TJSArray read GetItems;
    property FormData: TJSObject read GetData write SetData;
  private
    procedure InitItems;
    procedure InitLookup(item: TJSObject);
  public
    procedure AfterContentReady(const ElementID: string);
  private
    class procedure ApplyOptions(Form: TdxForm; o: TJSObject); static;
  public
    class procedure CreateConfigPopupMenu(const id: string; Form: TdxForm); static;

    class function ParseFields(Fields: TJSArray): TJSArray; static;
  end;

  // TdxInitFormProc = Reference toProcedure(Form: TjdxForm);
  TdxCustomFieldChangedProc = Reference to Procedure(dxForm: TdxForm; const dataField: string; Value: JSValue);

  TdxFormInitParams = class(TJSObject)
  private
    FCustomFieldChanged: TdxCustomFieldChangedProc;
    FInitFormOptions: TdxInitOptionsProc;
    FFormData: TJSObject;
    FMeta: TJSObject;
    FParams: TJSObject;
    procedure SetParams(const Value: TJSObject);
  public
    constructor New;

    class procedure AddParam(InitParams: TdxFormInitParams; key: string; Value: JSValue);

    property Params: TJSObject read FParams write SetParams;

    property InitFormOptions: TdxInitOptionsProc read FInitFormOptions write FInitFormOptions;
    property CustomFieldChanged: TdxCustomFieldChangedProc read FCustomFieldChanged write FCustomFieldChanged;
    property FormData: TJSObject read FFormData write FFormData;
    property Meta: TJSObject read FMeta write FMeta;
  end;

implementation

uses
  System.StrUtils,
  zz.Web.JS,
  zz.Web.user,
  zz.Web.html,
  DevExtreme.Button.JS,
  DevExtreme.ContextMenu.JS,
  DevExtreme.utils,
  DevExtreme.validation,
  DevExtreme.options,
  DevExtreme.images,
  DevExtreme.Lookup,
  DevExtreme.DataGrid.JS,
  DevExtreme.DataGrid,
  DevExtreme.factory;

/// /////////////////////////////////////////

constructor TdxFormInitParams.New;
begin
end;

class procedure TdxFormInitParams.AddParam(InitParams: TdxFormInitParams; key: string; Value: JSValue);
begin
  if not assigned(InitParams.FParams) then
    InitParams.FParams := TJSObject.New;

  InitParams.Params[key] := Value;
end;

procedure TdxFormInitParams.SetParams(const Value: TJSObject);
begin

  if assigned(Value) then
  begin
    if not assigned(FParams) then
      FParams := TJSObject.New;

    Params := TJSObject.Assign(Params, Value)
  end
  else
    FreeAndNil(FParams); // verificare
end;

/// /////////////////////////////////////////

procedure enum_(items: TJSArray; aCallBack: TJSArrayCallBack);
begin

  if assigned(items) then
    items.forEach(
      function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
      var
        item: TJSObject;
      begin
        item := JS.ToObject(element);

        if assigned(aCallBack) then
          aCallBack(element, index, anArray);

        if item['items'] <> null then
          if JS.IsArray(item['items']) then
            enum_(JS.ToArray(item['items']), aCallBack);
      end);
end;

/// /////////////////////////////////////////

function dxFormItemButton: TJSObject;
begin
  Result := TJSObject.New;
  Result['itemType'] := 'button';
  // altra funzione buttonOprions generica
end;

function TdxFormHelper.getButtonOptions(btnName: string): TJSObject; assembler;
asm
  var btn = this.getButton(btnName);
  if (btn)
  return btn.option();
end;

function TdxFormHelper.getButtonOption(btnName: string; optionName: string): JSValue; assembler;
asm
  var btn = this.getButton(btnName);
  if (btn)
  return btn.option(optionName);
end;

procedure TdxFormHelper.setButtonOption(btnName: string; optionName: string; optionValue: JSValue); assembler;
asm
  var btn = this.getButton(btnName);
  if (btn)
  btn.option(optionName, optionValue);
end;

procedure TdxFormHelper.ButtonEnabled(btnName: string; const enabled: boolean);
begin
  setButtonOption(btnName, 'disabled', not enabled);
end;

function TdxFormHelper.getEditorValue(dataField: string): JSValue;
asm
  return this.getEditor(dataField).option('value');
end;

function TdxFormHelper.Focused: string;
begin
  Result := JS.ToString(self['focusedField']);
end;

procedure TdxFormHelper.FocusEditor(const dataField: string);
var
  editor: JSValue;
begin
  editor := getEditor(dataField);

  if assigned(editor) then
    asm
      editor.focus();
    end;
end;

procedure TdxFormHelper.FocusButton(const name: string);
var
  btn: TdxButton;
begin
  btn := TdxButton(getButton(name));

  if assigned(btn) then
    btn.focus();
end;

function TdxFormHelper.ItemReadOnly(item: TJSObject): boolean;
var
  EditorOptions: TJSObject;
begin
  Result := false;

  EditorOptions := TjdxForm.EditorOptions(item);
  Result := not(EditorOptions['readOnly'] = true);
end;

function TdxFormHelper.ItemReadOnly(const dataField: string): boolean;
var
  item: TJSObject;
begin
  Result := false;

  item := ItemByName(dataField);

  if assigned(item) then
    Result := ItemReadOnly(item);
end;

function TdxFormHelper.ItemDisabled(item: TJSObject): boolean;
var
  EditorOptions: TJSObject;
begin
  Result := false;

  EditorOptions := TjdxForm.EditorOptions(item);
  Result := not(EditorOptions['disabled'] = true);
end;

function TdxFormHelper.ItemDisabled(const dataField: string): boolean;
var
  item: TJSObject;
begin
  Result := false;

  item := ItemByName(dataField);

  if assigned(item) then
    Result := ItemDisabled(item);
end;

procedure TdxFormHelper.InitItems;
begin
  RegisterFocusEvents;

  EnumItems(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      item: TJSObject;
      dataField: String;
      EditorOptions: TJSObject;
    begin
      item := JS.ToObject(element);

      if TjdxForm.ItemType(item) = fitSimple then
      begin
        EditorOptions := TjdxForm.EditorOptions(item);
        dataField := JS.ToString(item['dataField']);

        case TjdxForm.editorType(item) of
          ficDxAutocomplete:
            ;
          ficDxCalendar:
            ;
          ficDxCheckBox:
            ;
          ficDxColorBox:
            ;
          ficDxDateBox:
            begin

            end;
          ficDxDropDownBox:
            ;
          ficDxHtmlEditor:
            ;
          ficDxLookup:
            begin
              InitLookup(item);
            end;
          ficDxNumberBox:
            ;
          ficDxRadioGroup:
            ;
          ficDxRangeSlider:
            ;
          ficDxSelectBox:
            ;
          ficDxSlider:
            ;
          ficDxSwitch:
            ;
          ficDxTagBox:
            ;
          ficDxTextArea:
            ;
          ficDxTextBox:
            ;
        end;
      end;
    end);
end;

function TdxFormHelper.isModified: boolean;
begin
  Result := CompareObjects(JS.ToObject(self['oldValues']), JS.ToObject(self['formData']));
end;

procedure TdxFormHelper.ResetModified;
begin
  self['oldValues'] := self['formData'];
end;

function TdxFormHelper.ItemByName(const dataField: string): TJSObject;
var
  itemResult: TJSObject;
begin
  itemResult := nil;

  EnumItems(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      item: TJSObject;
    begin
      if not assigned(itemResult) then
      begin
        item := JS.ToObject(element);

        if sameText(JS.ToString(TJSObject(item)['dataField']), dataField) then
          itemResult := item;
      end;
    end);

  Result := itemResult;
end;

function TdxFormHelper.NextItem(const dataField: string): string;
var
  idx: integer;
  item: TJSObject;

  function enum(items: TJSArray; const startIndex: integer): string;
  var
    i: integer;
    item: TJSObject;
    subItems: TJSArray;
  begin
    for i := startIndex to items.length - 1 do
    begin
      item := JS.ToObject(items[i]);

      case TjdxForm.ItemType(item) of
        fitSimple:
          begin
            if not TjdxForm.ReadOnly(item) then
            begin
              Result := JS.ToString(item['dataField']);
              exit;
            end;
          end;
        fitGroup:
          begin

            if item.hasOwnProperty('items') then
            begin
              subItems := TJSArray(item['items']);

              Result := enum(subItems, 0);
              if not Result.isEmpty then
                exit;
            end;
          end;
        fitTabbed:
          begin
          end;
        fitButton:
          begin

            if not ItemDisabled(item) then
            begin
              Result := JS.ToString(item['name']);
              exit;
            end;
          end;
        fitEmpty:
          begin
          end;
      end;
    end;
  end;

begin
  Result := '';

  { TODO : rivedere con EnumItems }
  idx := items.findIndex(
    function(item: JSValue; index: NativeInt; a: TJSArray): boolean
    begin
      Result := sameText(JS.ToString(TJSObject(item)['dataField']), dataField);
    end);

  idx := idx + 1;

  /// //////////////////////////////////////////////////////

  Result := enum(items, idx);
  if Result.isEmpty then // se è arrivato alla fine ricomincia da capo, partendo da zero
    Result := enum(items, 0);

  /// //////////////////////////////////////////////////////
end;

procedure TdxFormHelper.FocusNextItem(const itemName: string);
var
  s: String;
  item: TJSObject;
  ItemType: TdxFormItemType;
begin
  s := NextItem(itemName);

  item := ItemByName(itemName);
  ItemType := TjdxForm.ItemType(item);

  case ItemType of
    fitSimple:
      FocusEditor(s);
    fitGroup:
      ;
    fitTabbed:
      ;
    fitButton:
      FocusButton(s);
    fitEmpty:
      ;
  end;
end;

function TdxFormHelper.GetData: TJSObject;
begin
  Result := TJSObject(option('formData'));
end;

procedure TdxFormHelper.SetData(const Value: TJSObject);
begin
  option('formData', Value);
end;

function TdxFormHelper.GetItems: TJSArray;
begin
  Result := TJSArray(option('items'));
end;

procedure TdxFormHelper.Placeholders(const enabled: boolean);
begin;

  EnumItems(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      item: TJSObject;
      i: integer;
      dataField: string;
      labelText: string;
      LabelOptions: TJSObject;
      EditorOptions: TJSObject;
    begin
      item := TJSObject(element);

      dataField := JS.ToString(item['dataField']);
      EditorOptions := dxGetObjectProperty(item, 'editorOptions');

      LabelOptions := dxGetObjectProperty(item, 'label');
      if assigned(LabelOptions) then
      begin
        labelText := JS.ToString(LabelOptions['text']);

        // label
        LabelOptions['visible'] := not enabled;
        itemOption(dataField, 'label', LabelOptions);
      end;

      // placeholder
      if enabled then
        EditorOptions['placeholder'] := labelText
      else
        EditorOptions['placeholder'] := null;

      itemOption(dataField, 'editorOptions', EditorOptions);
    end);
end;

procedure TdxFormHelper.RegisterFocusEvents;
begin
  EnumItems(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      item: TJSObject;
      dataField: String;
      EditorOptions: TJSObject;
    begin
      item := JS.ToObject(element);

      if TjdxForm.ItemType(item) = fitSimple then
      begin
        EditorOptions := TjdxForm.EditorOptions(item);

        dataField := JS.ToString(item['dataField']);
        EditorOptions['dataField'] := dataField;
        EditorOptions['onFocusIn'] := function(e: TJSObject): JSValue
          var
            dataField: string;
          begin
            asm
              dataField = e.component.option("dataField");
            end;

            self['focusedField'] := dataField;
            // DebugString('FocusIn: ' + dataField);
          end;

        // l'apertura di un lookup chiama l'evento, azzerando la proprietà: nel fieldChange sarà quindi null
        // editorOptions['onFocusOut'] := function(e: TJSObject): JSValue
        // begin
        // self['focusedField'] := null;
        // end;
      end;
    end);
end;

function TdxFormHelper.ScrollHeight: integer; assembler;
asm
  if (this._scrollable) {
  return this._scrollable.scrollHeight();
   }
else
  {
  return -1;
   }
end;

function TdxFormHelper.ScrollWidth: integer; assembler;
asm
  if (this._scrollable) {
  return this._scrollable.scrollWidth();
   }
else
  {
  return -1;
   }
end;

procedure TdxFormHelper.ScrollBarVisible(const visible: boolean);
asm
  if (this._scrollable) {

  if (visible)
  this._scrollable.option("showScrollbar", "onHover");
  else
  this._scrollable.option("showScrollbar", "never");
   }
end;

/// ////////////////////////////////////////////////////////////////////////////

/// ////////////////////////////////////////////////////////////////////////////
/// Form

procedure TdxFormHelper.FieldChanged(const dataField: string; Value: JSValue);
var
  CustomFieldChanged: TdxCustomFieldChangedProc;
begin

  if FieldChangedDisabled then
    exit;

  DisableFieldChanged;
  try
    // DebugString('FieldChanged in: ' + dataField);
    ClearDependentFields(dataField);

    CustomFieldChanged := TdxCustomFieldChangedProc(option('customFieldChanged'));

    if assigned(CustomFieldChanged) then
      CustomFieldChanged(self, dataField, Value);

    UpdateLookupsParams(dataField);
    // DebugString('FieldChanged out: ' + dataField);
  finally
    EnableFieldChanged;
  end;
end;

procedure TdxFormHelper.ClearDependentFields(const dataField: string);
var
  item: TJSObject;
  FieldsToClear: TJSArray;
begin
  item := ItemByName(dataField);

  if not assigned(item) then
    exit;

  FieldsToClear := JS.ToArray(item['fieldsToClear']);

  if assigned(FieldsToClear) then
  begin
    // DebugString('ClearDependentFields');

    FieldsToClear.forEach(
      function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
      var
        field: string;
        Value: TJSObject;
      begin
        field := JS.ToString(element);
        Value := nil;
        updateData(field, Value);
        // DebugString('Clear: ' + field);
      end);
  end;
end;

procedure TdxFormHelper.CopyLookupFields(fieldsToCopy: TJSArray; selectedItem: TJSObject);
begin

  if assigned(fieldsToCopy) then
    if assigned(selectedItem) then
    begin
      // DebugString('CopyLookupFields');

      DisableFieldChanged;
      try
        fieldsToCopy.forEach(
          function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
          var
            s, src, dest: string;
            idx: integer;
            lkvalue: JSValue;
          begin
            s := JS.ToString(element);

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

            lkvalue := selectedItem[src];

            if FormData['dest'] <> lkvalue then
            begin
              updateData(dest, TJSObject(lkvalue));
              // DebugString('CopyLk: ' + dest);
            end;
          end);
      finally
        EnableFieldChanged;
      end;
    end;
end;

procedure TdxFormHelper.DisableFieldChanged;
begin
  self['FieldChangedEnabled'] := false;
end;

procedure TdxFormHelper.EnableFieldChanged;
begin
  self['FieldChangedEnabled'] := true;
end;

function TdxFormHelper.FieldChangedDisabled: boolean;
begin
  Result := false;

  if JS.IsBoolean(self['FieldChangedEnabled']) then
    Result := not JS.ToBoolean(self['FieldChangedEnabled']);
end;

procedure TdxFormHelper.EnumItems(aCallBack: TJSArrayCallBack);
begin
  enum_(items, aCallBack);
end;

procedure TdxFormHelper.EnumLoolups(aCallBack: TJSArrayCallBack);
begin
  EnumItems(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      item: TJSObject;
    begin
      item := JS.ToObject(element);

      if TjdxForm.ItemType(item) = fitSimple then
        if TjdxForm.editorType(item) = TdxFormItemComponent.ficDxLookup then
          if assigned(aCallBack) then
            aCallBack(element, index, anArray);
    end);
end;

procedure TdxFormHelper.ScrollBarDirection(const direction: string);
begin
  asm
    if (this._scrollable) {
    this._scrollable.option("direction", direction);
     }
  end;
end;

procedure TdxFormHelper.UpdateLookupParams(dataSource: TdxDataSource; Params: TJSArray; out paramsChanged: boolean);
begin
  paramsChanged := false;
  Params.forEach(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      s, src, dest: string;
      idx: integer;
      Value: JSValue;
    begin
      s := JS.ToString(element);

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

      if JS.IsDate(Value) then
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

procedure TdxFormHelper.UpdateLookupsParams(const dataField: string);
begin
  EnumLoolups(
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      item, lookupOptions, EditorOptions: TJSObject;
      dataSource: TdxDataSource;
      Params: TJSArray;
      paramsChanged: boolean;
    begin
      item := JS.ToObject(element);

      // il campo appena variato non deve essere resettato
      if sameText(dataField, JS.ToString(item['dataField'])) then
        exit;

      lookupOptions := JS.ToObject(item['lookupOptions']);
      Params := JS.ToArray(lookupOptions['params']);
      EditorOptions := TjdxForm.EditorOptions(item, true);
      dataSource := TdxDataSource(EditorOptions['dataSource']);

      UpdateLookupParams(dataSource, Params, paramsChanged);

      if paramsChanged then
      begin
        dataSource['headerAggiunti'] := false;
        dataSource.pageIndex(0); // altrimenti non riapre i combo
        dataSource.reload;
      end;
    end);
end;

class function TjdxForm.item(const dataField: string; const labelText: String; const required: boolean; LabelOptions: TLabelOptions = DefaultLabelOptions): TJSObject;
var
  Bold, PlaceHolder, floating: boolean;
begin
  Result := TJSObject.New;
  Result['dataField'] := dataField;

  /// ///////////////

  Bold := loLabelBold in LabelOptions;

  PlaceHolder := loPlaceholder in LabelOptions;

  floating := loFloating in LabelOptions;

  if PlaceHolder then
  begin
    Result['label'] := TjdxForm.Label_(labelText, Bold, false);
    Result['editorOptions'] := TjdxForm.PlaceHolder(labelText);
  end
  else
    Result['label'] := TjdxForm.Label_(labelText, Bold, not floating);

  /// ///////////////

  if required then
    TdxValidation.AddRule(Result, TdxValidation.required(labelText));
end;

class function TjdxForm.item(const editorType: string; const dataField: string; const labelText: String; const required: boolean; LabelOptions: TLabelOptions = DefaultLabelOptions): TJSObject;
begin
  Result := TjdxForm.item(dataField, labelText, required, LabelOptions);
  Result['editorType'] := editorType;
end;

class function TjdxForm.ItemType(item: TJSObject): TdxFormItemType;
var
  s: String;
begin
  Result := fitSimple;

  if assigned(item) then
    if item.hasOwnProperty('itemType') then
    begin
      s := JS.ToString(item['itemType']);
      Result := TdxFormItemType.FromString(s);
    end;
end;

class function TjdxForm.ItemOptions(FormOptions: TJSObject; const dataField: string): TJSObject;
var
  items: TJSArray;
  itemResult: TJSObject;
begin
  itemResult := nil;
  items := JS.ToArray(FormOptions['items']);

  enum_(items,
    function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
    var
      item: TJSObject;
    begin
      if not assigned(itemResult) then
      begin
        item := JS.ToObject(element);

        if sameText(JS.ToString(TJSObject(item)['dataField']), dataField) then
          itemResult := item;
      end;
    end);

  Result := itemResult;
end;

class procedure TjdxForm.ItemOptions(FormOptions: TJSObject; const dataField: string; ItemOptions: TJSObject);
var
  items: TJSArray;
begin
  items := JS.ToArray(FormOptions['items']);

  if not assigned(items) then
  begin
    items := TJSArray.New;
    items.push(ItemOptions);
  end
  else
  begin
    enum_(items,
      function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
      var
        item: TJSObject;
      begin
        item := JS.ToObject(element);

        if sameText(JS.ToString(TJSObject(item)['dataField']), dataField) then
          items[index] := ItemOptions;
      end);
  end;
end;

class function TjdxForm.Group(items: array of TJSObject; colCount: integer = 1): TJSObject;
begin
  Result := TjdxForm.Group(JSArray(items), colCount);
end;

class function TjdxForm.Group(items: TJSArray; colCount: integer = 1): TJSObject;
begin
  Result := TJSObject.New;
  Result['itemType'] := 'group';
  Result['colCount'] := colCount;
  Result['items'] := items;
end;

class function TjdxForm.EditorOptions(item: TJSObject; const CanCreate: boolean = false): TJSObject;
begin
  Result := dxGetObjectProperty(item, 'editorOptions');

  if not assigned(Result) then
    if CanCreate then
      Result := TJSObject.New;
end;

class procedure TjdxForm.EditorOptions(item: TJSObject; EditorOptions: TJSObject);
begin
  item['editorOptions'] := EditorOptions;
end;

class function TjdxForm.editorType(item: TJSObject): TdxFormItemComponent;
var
  s: String;
begin
  Result := ficDxTextBox;

  if item.hasOwnProperty('editorType') then
  begin
    s := JS.ToString(item['editorType']);
    Result := TdxFormItemComponent.FromString(s);
  end;
end;

class function TjdxForm.ReadOnly(item: TJSObject): boolean;
var
  EditorOptions: TJSObject;
begin
  Result := false;

  EditorOptions := TjdxForm.EditorOptions(item);

  if EditorOptions.hasOwnProperty('readOnly') then
    Result := JS.ToBoolean(EditorOptions['readOnly']);
end;

class function TjdxForm.ReadOnly(item: TJSObject; const ReadOnly: boolean): boolean;
var
  EditorOptions: TJSObject;
begin
  EditorOptions := TjdxForm.EditorOptions(item);
  EditorOptions['readOnly'] := ReadOnly;
  TjdxForm.EditorOptions(item, EditorOptions);
end;

class function TjdxForm.ColCountByScreen(const lg, md, sm, xs: integer): TJSObject;
begin
  Result := TJSObject.New;
  Result['lg'] := lg;
  Result['md'] := md;
  Result['sm'] := sm;
  Result['xs'] := xs;
end;

class function TjdxForm.ItemEmpty: TJSObject;
begin
  Result := TJSObject.New;
  Result['itemType'] := 'empty';
end;

class function TjdxForm.Label_(const text: String; const Bold: boolean; const visible: boolean): TJSObject;
var
  elementAttr: TJSObject;
begin
  Result := TJSObject.New;

  Result['text'] := text;

  if Bold then
  begin
    elementAttr := TJSObject.New;
    Result['elementAttr'] := elementAttr;
    elementAttr['style'] := 'font-weight: bold;';
  end;

  if visible then
    Result['visible'] := true
  else
    Result['visible'] := false;
end;

class function TjdxForm.PlaceHolder(const text: String): TJSObject;
begin
  Result := TJSObject.New;
  Result['placeholder'] := text;
end;

class function TjdxForm.Password(const dataField: string; const labelText: String; const required: boolean; LabelOptions: TLabelOptions = DefaultLabelOptions): TJSObject;
var
  EditorOptions: TJSObject;
begin
  Result := TjdxForm.item(dataField, labelText, required, LabelOptions);
  Result['editorType'] := 'dxTextBox';

  EditorOptions := TjdxForm.EditorOptions(Result);
  EditorOptions['mode'] := 'password';
  Result['editorOptions'] := EditorOptions;
end;

class function TjdxForm.CheckBox(const dataField: string; const labelText: String; const required: boolean; LabelOptions: TLabelOptions = DefaultLabelOptions): TJSObject;
var
  EditorOptions: TJSObject;
begin
  Result := TjdxForm.item(dataField, labelText, required, LabelOptions);
  Result['editorType'] := 'dxCheckBox';

  EditorOptions := TjdxForm.EditorOptions(Result);
  EditorOptions['mode'] := 'password';
  Result['editorOptions'] := EditorOptions;
end;

class function TjdxForm.Email(const dataField: string; const labelText: String; const required: boolean; LabelOptions: TLabelOptions = DefaultLabelOptions): TJSObject;
var
  EditorOptions: TJSObject;
begin
  Result := TjdxForm.item(dataField, labelText, required, LabelOptions);
  Result['editorType'] := 'dxTextBox';

  EditorOptions := TjdxForm.EditorOptions(Result);
  EditorOptions['mode'] := 'email';
  Result['editorOptions'] := EditorOptions;
end;

class function TjdxForm.Slider(const dataField: string; const labelText: String; const required: boolean; LabelOptions: TLabelOptions = DefaultLabelOptions): TJSObject;
var
  EditorOptions: TJSObject;
begin
  Result := TjdxForm.item(dataField, labelText, required, LabelOptions);
  Result['editorType'] := 'dxSlider';

  EditorOptions := TjdxForm.EditorOptions(Result);
  Result['editorOptions'] := EditorOptions;
end;

class function TjdxForm.Button(const name: string; btnText: string; icon: string; btnType: TdxButtonType; btnStyle: TdxButtonStyle; HorizontalAlignment: TdxHorizontalAlignment;
onClick: TdxEventHandlerFunc): TJSObject;
var
  buttonOptions: TJSObject;
begin
  Result := TJSObject.New;
  Result['itemType'] := 'button';
  Result['name'] := name;
  Result['horizontalAlignment'] := HorizontalAlignment.ToString;

  buttonOptions := TdxOptions.Button(name, btnText, icon, btnType, btnStyle, onClick);
  Result['buttonOptions'] := buttonOptions;
end;

procedure TdxFormHelper.AfterContentReady(const ElementID: string);
begin
  InitItems;
  ScrollBarVisible(true);
  ScrollBarDirection('vertical');
  CreateConfigPopupMenu(ElementID, self);
end;

class procedure TdxFormHelper.CreateConfigPopupMenu(const id: string; Form: TdxForm);
var
  menuOptions: TJSObject;
  menuItems: TJSArray;
  menuItem: TJSObject;
  popupMenu: TdxContextMenu;
  popupId: string;
  divForm, divPopup: TJSElement;
  formId: string;
begin
  { TODO : Agganciare alla factory delle form }

  formId := id.Replace('#', '');

  if Base.Onnipotente then
  begin
    menuItems := TJSArray.New;

    menuItem := TJSObject.New;
    menuItem['text'] := 'Personalizza';
    menuItem['icon'] := imageProperties;
    menuItems.push(menuItem);

    menuItem := TJSObject.New;
    menuItem['text'] := 'Sql';
    menuItem['icon'] := imageSql;
    menuItems.push(menuItem);

    menuOptions := TJSObject.New;
    menuOptions['items'] := menuItems;
    menuOptions['target'] := '#' + formId;
    menuOptions['width'] := 200;

    menuOptions['onItemClick'] := function(e: TJSObject): JSValue
      var
        o: TJSObject;
        dm, dataset: string;
      begin
        o := Form.option;

        if JS.toInteger(e['itemIndex']) = 0 then
        begin
          // Base.EditJSObject('Opzioni Form', o,
          // procedure(Options: TJSObject; callback: TProc)
          // begin
          // Form.option(o);
          // /// //////////////
          // callback();
          // end);

          Base.EditOptions(o,
            function(e: TJSObject): JSValue
            var
              dm, dataset: string;
            begin
              o := JS.ToObject(e);

              Form.option(o);

              dm := JS.ToString(o['dm']);
              dataset := JS.ToString(o['dataset']);

              if not((dm.isEmpty) or (dataset.isEmpty)) then
                Base.UploadOptions(dm, dataset, 'TdxForm', o);
            end, nil);
        end
        else
        begin
          dm := JS.ToString(o['dm']);
          dataset := JS.ToString(o['dataset']);

          Base.EditSQL(dm, dataset,
            procedure
            begin
            end);
        end;
      end;

    popupId := formId + 'Popup';
    divForm := document.getElementById(formId);

    if assigned(divForm) then
    begin
      divPopup := document.CreateElement('DIV');
      divForm.appendChild(divPopup);
      divPopup.setAttribute('id', popupId);
      popupMenu := dxFactory.ContextMenu('#' + popupId, menuOptions);
    end;
  end;
end;

class procedure TdxFormHelper.ApplyOptions(Form: TdxForm; o: TJSObject);
var
  key: string;
begin
  Form.beginUpdate;
  try
    for key in TJSObject.keys(o) do
      Form.option(key, o[key]);
  finally
    Form.endUpdate;
  end;
end;

procedure TdxFormHelper.InitLookup(item: TJSObject);
var
  key: string;
  lookupOptions: TJSObject;
  EditorOptions: TJSObject;
  dm: string;
  dataset: string;
  dataSource: TdxDataSource;
  displayExpr, valueExpr: string;
  dataField: string;
  Params: TJSArray;
  paramsChanged: boolean;
  fieldsToCopy: TJSArray;
  grid: TdxDataGrid;
  columns: TJSArray;
  fieldMappings: string;
begin
  { TODO : Recuperare tramite base.DownloadOptions }
  EditorOptions := TjdxForm.EditorOptions(item, true);

  if EditorOptions['dataSource'] <> null then
    exit;

  dataField := JS.ToString(item['dataField']);

  lookupOptions := JS.ToObject(item['lookup']);

  dm := JS.ToString(lookupOptions['dm']);
  dataset := JS.ToString(lookupOptions['dataset']);
  key := JS.ToString(lookupOptions['key']);

  displayExpr := JS.ToString(lookupOptions['displayExpr']);
  valueExpr := JS.ToString(lookupOptions['valueExpr']);

  fieldMappings := JS.ToString(lookupOptions['fieldMappings']);
  Params := JS.ToArray(lookupOptions['params']);

  dataSource := dxLookupDataSource(dataset, key, nil, columns);
  // ! aggiunge parametri a dataSource
  UpdateLookupParams(dataSource, Params, paramsChanged);

  EditorOptions['dataSource'] := dataSource;
  itemOption(dataField, 'editorOptions', EditorOptions);
end;

class function TdxFormHelper.ParseFields(Fields: TJSArray): TJSArray;
begin
  Result := Fields;

  if assigned(Result) then
    Result.forEach(
      function(element: JSValue; index: NativeInt; anArray: TJSArray): boolean
      var
        item: TJSObject;
        LabelOptions: TJSObject;

      begin
        item := JS.ToObject(element);

        // caption
        if item.hasOwnProperty('caption') then
        begin

          if item.hasOwnProperty('label') then
            LabelOptions := JS.ToObject(item['label'])
          else
            LabelOptions := TJSObject.New;

          if assigned(LabelOptions) then
          begin
            LabelOptions['text'] := JS.ToString(item['caption']);
            // LabelOptions['visible'] := true;
            item['label'] := LabelOptions;
            jsDelete(item, 'caption');
          end;
        end; // \caption
      end);
end;

end.
