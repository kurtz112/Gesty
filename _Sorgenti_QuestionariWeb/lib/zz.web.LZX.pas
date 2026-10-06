unit zz.web.LZX;

interface

uses
  SysUtils,
  Classes,
  db,
  js,
  WEBLib.JSON;

Type
  TjsFieldType = (jftUnknown, jftString, jftInteger, jftLargeInt, jftBoolean, jftFloat, jftDate, jftTime, jftDateTime, jftAutoInc, jftBlob, jftMemo, jftFixedChar, jftVariant, jftDataset);

  TWidgetType = (wtText, wtPassword);

  TColumnDataType = (cdtString, cdtNumber, cdtDate, cdtBoolean);

Type
  TlzxCollectionItem = class(TCollectionItem)
  public
    procedure Decode(o: TJSObject); virtual;
    function Encode: TJSObject; virtual;
  end;

  TlzxCollection = class(TCollection)
  public
    procedure Decode(const JSObject: TJSObject; const PropertyName: string); overload; virtual;
    procedure Decode(const JSArray: TJSArray); overload; virtual;
    function Encode: TJSArray; virtual;
  end;

  /// ///////////////////////////////////////////////////////////////////
  // Fields
  TlzxField = class(TlzxCollectionItem)
  private
    FDisplayLabel: String;
    FFieldName: string;
    FFieldType: TFieldType;
    FExist: boolean;
    FRequired: boolean;
    FSize: integer;
    FFieldTypeJS: TjsFieldType;
    FReadOnly: boolean;
    FVisible: boolean;
    procedure SetFieldType(const Value: TFieldType);
  protected
    property Exist: boolean read FExist write FExist;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property FieldName: string read FFieldName write FFieldName;
    property DisplayLabel: String read FDisplayLabel write FDisplayLabel;
    property FieldType: TFieldType read FFieldType write SetFieldType;
    // Todo
    // property FieldTypeJS: TjsFieldType read FFieldTypeJS write FFieldTypeJS;
    property Size: integer read FSize write FSize;
    property ReadOnly: boolean read FReadOnly write FReadOnly;
    property Required: boolean read FRequired write FRequired;
    property Visible: boolean read FVisible write FVisible;
  end;

  TlzxFields = class(TlzxCollection)
  public
    procedure LoadFields(Fields: TFields);
  end;

  /// ///////////////////////////////////////////////////////////////////
  // Control
  TlzxControl = class(TlzxCollectionItem)
  private
    FExist: boolean;
    FFieldName: string;
    FLabelBold: boolean;
    FLabelText: string;
    FReadOnly: boolean;
    FRequired: boolean;
    FVisible: boolean;
    FWidgetType: TWidgetType;
    FWidth: integer;
  protected
    property Exist: boolean read FExist write FExist;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property FieldName: string read FFieldName write FFieldName;
    property LabelText: string read FLabelText write FLabelText;
    property LabelBold: boolean read FLabelBold write FLabelBold;
    property WidgetType: TWidgetType read FWidgetType write FWidgetType;
    property ReadOnly: boolean read FReadOnly write FReadOnly;
    property Required: boolean read FRequired write FRequired;
    property Visible: boolean read FVisible write FVisible;
    property Width: integer read FWidth write FWidth;
  end;

  TlzxControls = class(TlzxCollection)
  public
    procedure LoadFields(Fields: TlzxFields);
  end;

  /// ///////////////////////////////////////////////////////////////////
  // Column
  TlzxColumn = class(TlzxCollectionItem)
  private
    FExist: boolean;
    FColumnDataType: TColumnDataType;
    FFieldName: string;
    FFormat: string;
    FHeaderText: string;
    FVisible: boolean;
    FWidth: integer;
  protected
    property Exist: boolean read FExist write FExist;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property FieldName: string read FFieldName write FFieldName;
    property HeaderText: string read FHeaderText write FHeaderText;
    property ColumnDataType: TColumnDataType read FColumnDataType write FColumnDataType;
    property Format: string read FFormat write FFormat;
    property Visible: boolean read FVisible write FVisible;
    property Width: integer read FWidth write FWidth;
  end;

  TlzxColumns = class(TlzxCollection)
  public
    procedure LoadFields(Fields: TlzxFields);
  end;

  /// ///////////////////////////////////////////////////////////////////
  // Card
  TlzxCard = class(TlzxCollectionItem)
  private
    FCaption: string;
    FCardID: string;
    FControls: TlzxControls;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property CardID: string read FCardID write FCardID;
    property Caption: string read FCaption write FCaption;
    property Controls: TlzxControls read FControls write FControls;
  end;

  TlzxCards = class(TlzxCollection)
  public
    function AddCard(const Caption: string; Fields: TlzxFields): TlzxCard;
    function Get(CardID: string): TlzxCard;
    procedure LoadFields(Fields: TlzxFields);
  end;

  /// ///////////////////////////////////////////////////////////////////
  // Grid
  TlzxGrid = class(TlzxCollectionItem)
  private
    FCaption: string;
    FGridID: string;
    FColumns: TlzxColumns;
    FExport: boolean;
    FFocusedRow: boolean;
    FMultiSelect: boolean;
    FSearchPanel: boolean;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property GridID: string read FGridID write FGridID;
    property Caption: string read FCaption write FCaption;
    property Columns: TlzxColumns read FColumns write FColumns;
    property FocusedRow: boolean read FFocusedRow write FFocusedRow;
    property MultiSelect: boolean read FMultiSelect write FMultiSelect;
    property Export: boolean read FExport write FExport;
    property SearchPanel: boolean read FSearchPanel write FSearchPanel;
  end;

  TlzxGrids = class(TlzxCollection)
  public
    function AddGrid(const Caption: string; Fields: TlzxFields): TlzxGrid;
    function Get(GridID: string): TlzxGrid;
    procedure LoadFields(Fields: TlzxFields);
  end;

  /// ///////////////////////////////////////////////////////////////////
  // Dataset
  TlzxDataObject = class(TPersistent)
  private
    FFields: TlzxFields;
    FCards: TlzxCards;
    FDataSetName: string;
    FGrids: TlzxGrids;
    FTableName: string;
    FSQL_Delete: TStrings;
    FSQL_Update: TStrings;
    FSQL_Select: TStrings;
    FSQL_Insert: TStrings;
    FPrimaryKeyFields: string;
    procedure SetSQL_Delete(const Value: TStrings);
    procedure SetSQL_Insert(const Value: TStrings);
    procedure SetSQL_Select(const Value: TStrings);
    procedure SetSQL_Update(const Value: TStrings);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear;

    class function Decode(const JSON: string): TlzxDataObject; overload;
    class function Decode(const JSON: TJSObject): TlzxDataObject; overload;
    function Encode(DataSet: TlzxDataObject; IncludeSQL: boolean = True): TJSObject;

    function AddCard: TlzxCard;
    function AddGrid: TlzxGrid;

    procedure LoadDataSet(DataSet: TDataset);

    function Meta: TJSObject;
  published
    property DataSetName: string read FDataSetName write FDataSetName;
    property SQL_Select: TStrings read FSQL_Select write SetSQL_Select;
    property SQL_Insert: TStrings read FSQL_Insert write SetSQL_Insert;
    property SQL_Update: TStrings read FSQL_Update write SetSQL_Update;
    property SQL_Delete: TStrings read FSQL_Delete write SetSQL_Delete;
    property TableName: string read FTableName write FTableName;
    property PrimaryKeyFields: string read FPrimaryKeyFields write FPrimaryKeyFields;
  published
    property Fields: TlzxFields read FFields write FFields;
    property Cards: TlzxCards read FCards write FCards;
    property Grids: TlzxGrids read FGrids write FGrids;
  end;

implementation

uses
  TypInfo,
  WEBLib.Dialogs;

function GetFieldTypeJS(Const FieldType: TFieldType): TjsFieldType;
var
  s: string;
begin
  Result := jftUnknown;

  case FieldType of
    ftUnknown:
      Result := jftUnknown;
    ftString:
      Result := jftString;
    // ftSmallint:
    // Result := jftInteger;
    ftInteger:
      Result := jftInteger;
    // ftWord:
    // Result := jftInteger;
    ftBoolean:
      Result := jftBoolean;
    ftFloat:
      Result := jftFloat;
    // ftCurrency:
    // Result := jftFloat;
    // ftBCD:
    // Result := jftFloat;
    ftDate:
      Result := jftDate;
    ftTime:
      Result := jftTime;
    ftDateTime:
      Result := jftDateTime;
    // ftBytes:
    // Result := jftBlob;
    // ftVarBytes:
    // Result := jftBlob;
    ftAutoInc:
      Result := jftAutoInc;
    ftBlob:
      Result := jftBlob;
    ftMemo:
      Result := jftMemo;
    // ftGraphic:
    // Result := jftBlob;
    // ftFmtMemo:
    // Result := jftMemo;
    // ftParadoxOle:
    // Result := jftUnknown;
    // ftDBaseOle:
    // Result := jftUnknown;
    // ftTypedBinary:
    // Result := jftUnknown;
    // ftCursor:
    // Result := jftUnknown;
    ftFixedChar:
      Result := jftString;
    // ftWideString:
    // Result := jftString;
    ftLargeInt:
      Result := jftLargeInt;
    // ftADT:
    // Result := jftUnknown;
    // ftArray:
    // Result := jftUnknown;
    // ftReference:
    // Result := jftUnknown;
    // ftDataSet:
    // Result := jftUnknown;
    // ftOraBlob:
    // Result := jftUnknown;
    // ftOraClob:
    // Result := jftUnknown;
    ftVariant:
      Result := jftVariant;
    // ftInterface:
    // Result := jftUnknown;
    // ftIDispatch:
    // Result := jftUnknown;
    // ftGuid:
    // Result := jftUnknown;
    // ftTimeStamp:
    // Result := jftDateTime;
    // ftFMTBcd:
    // Result := jftFloat;
    // ftFixedWideChar:
    // Result := jftString;
    // ftWideMemo:
    // Result := jftMemo;
    // ftOraTimeStamp:
    // Result := jftUnknown;
    // ftOraInterval:
    // Result := jftUnknown;
    // ftLongWord:
    // Result := jftUnknown;
    // ftShortint:
    // Result := jftInteger;
    // ftByte:
    // Result := jftBlob;
    // TFieldType.ftExtended:
    // Result := jftFloat;
    // ftConnection:
    // Result := jftUnknown;
    // ftParams:
    // Result := jftUnknown;
    // ftStream:
    // Result := jftUnknown;
    // ftTimeStampOffset:
    // Result := jftUnknown;
    // ftObject:
    // Result := jftUnknown;
    // TFieldType.ftSingle:
    // Result := jftInteger;
  else
    begin
      s := GetEnumName(TypeInfo(TFieldType), Ord(FieldType));
      raise Exception.Create('LZX.GetFieldTypeJS: Formato non supportato: ' + s);
    end;
  end;
end;

function GetColumnDataType(Field: TField): TColumnDataType; overload;
begin
  Result := cdtString;

  if Field is TNumericField then
    Result := cdtNumber
  else
    if Field is TDateField then
      Result := cdtDate
    else
      if Field is TDateTimeField then
        Result := cdtDate
      else
        if Field is TBooleanField then
          Result := cdtBoolean;
end;

function GetColumnDataType(DataType: TFieldType): TColumnDataType; overload;

// funzioni private in data.DBCommon
  function IsNumeric(DataType: TFieldType): boolean;
  begin
    // Result := DataType in [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD, ftAutoInc, ftLargeint, ftFMTBcd,
    // ftShortint, ftByte, ftSingle, ftLongWord, ftExtended];
    Result := DataType in [ftInteger, ftLargeInt, ftFloat, ftAutoInc];
  end;

  function IsTemporal(DataType: TFieldType): boolean;
  begin
    Result := DataType in [ftDate, ftTime, ftDateTime]; // , ftTimeStamp, ftTimeStampOffset];
  end;

begin
  Result := cdtString;

  if IsNumeric(DataType) then
    Result := cdtNumber
  else
    if IsTemporal(DataType) then
      Result := cdtDate
    else
      if DataType = ftBoolean then
        Result := cdtBoolean;
end;

function CapFirst(Value: string): string;
var
  i: integer;
  s: string;
begin
  Result := '';

  if trim(Value) = '' then
    Exit;

  s := uppercase(Value[1]);
  for i := 2 to length(Value) do
  begin
    if (Ord(Value[i - 1]) < 33) then
      s := s + uppercase(Value[i])
    else
      s := s + lowercase(Value[i]);
  end;

  Result := StringReplace(s, '_', ' ', [rfReplaceAll]);
end;

procedure TlzxCollectionItem.Decode(o: TJSObject);

  procedure SetProperty(PropertyName: string; TypeKind: TTypeKind; Value: JSValue);
  var
    s: string;
  begin
    // X:\Druido\Lib\TMS\TMS WEB Core RSXE12\Core Source\RTL\typinfo.pas
    case TypeKind of
      // tkUnknown,  // 0
      tkInteger:
        SetJSValueProp(Self, PropertyName, Value);
      tkChar:
        SetJSValueProp(Self, PropertyName, Value);
      tkString:
        SetJSValueProp(Self, PropertyName, Value);
      tkEnumeration:
        begin
          // SetJSValueProp(Self, PropertyName, Value);
          s := js.toString(Value);
          SetEnumProp(Self, PropertyName, s);
        end;
      tkSet:
        SetJSValueProp(Self, PropertyName, Value);
      tkDouble:
        SetJSValueProp(Self, PropertyName, Value);
      tkBool:
        SetJSValueProp(Self, PropertyName, Value);
      // tkProcVar
      // tkMethod
      // tkArray
      // tkDynArray
      // tkRecord
      // tkClass
      // tkClassRef
      // tkPointer
      tkJSValue:
        SetJSValueProp(Self, PropertyName, Value);
      // tkRefToProcVar
      // tkInterface
      // tkObject,
      // tkSString,tkLString,tkAString,tkWString,
      // tkVariant,
      // tkWChar,
      // tkInt64,
      // tkQWord,
      // tkInterfaceRaw,
      // tkUString,tkUChar,
      // tkHelper
      // tkFile,
    end;
  end;

  procedure SetObject(o: TJSObject; obj: TObject);
  Var
    subObj: TObject;
    prop: TTypeMemberProperty;
    props: TTypeMemberPropertyDynArray;
    TypeKind: TTypeKind;
    v: JSValue;
  begin

    props := GetPropList(obj);
    for prop in props do
      if IsPublishedProp(Self, prop.Name) then
      begin
        TypeKind := PropType(Self, prop.Name);

        if TypeKind <> tkClass then
        begin
          v := o.Properties[prop.Name];
          SetProperty(prop.Name, TypeKind, v);
        end
        else
        begin
          subObj := GetObjectProp(Self, prop.Name);

          if Assigned(subObj) then
            if subObj.InheritsFrom(TlzxCollection) then
            begin
              if js.isArray(v) then
                TlzxCollection(subObj).Decode(js.toArray(v));
            end
            else
              SetObject(o, subObj)
        end;
      end;
  end;

begin
  SetObject(o, Self)

  // TTypeKind = (
  // tkUnknown,  // 0
  // tkInteger,  // 1
  // tkChar,     // 2 in Delphi/FPC tkWChar, tkUChar
  // tkString,   // 3 in Delphi/FPC tkSString, tkWString or tkUString
  // tkEnumeration, // 4
  // tkSet,      // 5
  // tkDouble,   // 6
  // tkBool,     // 7
  // tkProcVar,  // 8
  // tkMethod,   // 9  proc var of object
  // tkArray,    // 10 static array
  // tkDynArray, // 11
  // tkRecord,   // 12
  // tkClass,    // 13
  // tkClassRef, // 14
  // tkPointer,  // 15
  // tkJSValue,  // 16
  // tkRefToProcVar, // 17
  // tkInterface, // 18
  // //tkObject,
  // //tkSString,tkLString,tkAString,tkWString,
  // //tkVariant,
  // //tkWChar,
  // //tkInt64,
  // //tkQWord,
  // //tkInterfaceRaw,
  // //tkUString,tkUChar,
  // tkHelper    // 19
  // //tkFile,
  // );

  // props := GetPropList(Self);
  // for prop in props do
  // if IsPublishedProp(Self, prop.Name) then
  // begin
  // v := o.Properties[prop.Name];
  //
  // // se arriva come set va in palla.
  // // Definire metodo per settare il valore
  // // SetOrdProp
  // // SetEnumProp
  // // SetStringProp
  //
  // if PropType(Self, prop.Name) <> tkClass then
  // SetJSValueProp(Self, prop.Name, v)
  // else
  // begin
  // obj := GetObjectProp(Self, prop.Name);
  //
  // if Assigned(obj) then
  // if obj.InheritsFrom(TlzxCollection) then
  // begin
  // if js.isArray(v) then
  // TlzxCollection(obj).Decode(js.toArray(v));
  // end
  // else
  // SetJSValueProp(Self, prop.Name, v)
  // end;
  // end;
end;

function TlzxCollectionItem.Encode: TJSObject;
Var
  obj: TObject;
  prop: TTypeMemberProperty;
  props: TTypeMemberPropertyDynArray;
  v: JSValue;
begin
  Result := TJSObject.New;

  props := GetPropList(Self);
  for prop in props do
    if IsPublishedProp(Self, prop.Name) then
      if prop.Setter <> '' then
      begin

        if PropType(Self, prop.Name) <> tkClass then
          v := GetJSValueProp(Self, prop.Name)
        else
        begin
          obj := GetObjectProp(Self, prop.Name);

          if Assigned(obj) then
            if obj.InheritsFrom(TlzxCollection) then
              v := TlzxCollection(obj).Encode
            else
              v := GetJSValueProp(Self, prop.Name)
        end;

        Result.Properties[prop.Name] := v;
      end;
end;

{ TlzxCollection }
procedure TlzxCollection.Decode(const JSObject: TJSObject; const PropertyName: string);
var
  v: JSValue;
begin
  Clear;

  v := JSObject.Properties[PropertyName];
  if js.isArray(v) then
    Decode(js.toArray(v));
end;

procedure TlzxCollection.Decode(const JSArray: TJSArray);
var
  i: integer;
  item: TlzxCollectionItem;
  o: TJSObject;
begin
  inherited;

  for i := 0 to JSArray.length - 1 do
  begin
    o := TJSObject(JSArray.Elements[i]);
    item := Add as TlzxCollectionItem;
    item.Decode(o);
  end;
end;

function TlzxCollection.Encode: TJSArray;
var
  i: integer;
  item: TlzxCollectionItem;
begin
  Result := TJSArray.New;

  for i := 0 to Count - 1 do
  begin
    item := items[i] as TlzxCollectionItem;
    Result.Push(item.Encode);
  end;
end;

{ TlzxControl }

constructor TlzxControl.Create(Collection: TCollection);
begin
  inherited;
  FExist := True;
  FFieldName := '';
  FLabelText := '';
  FLabelBold := false;
  FWidgetType := wtText;
  FReadOnly := false;
  FRequired := false;
  FVisible := True;
  FWidth := 100;
end;

destructor TlzxControl.Destroy;
begin
  inherited;
end;

procedure TlzxControl.Assign(Source: TPersistent);
var
  src: TlzxControl;
begin
  if Source.ClassType = Self.ClassType then
  begin
    src := TlzxControl(Source);

    FExist := src.Exist;
    FFieldName := src.FieldName;
    FLabelText := src.LabelText;
    FLabelBold := src.LabelBold;
    FWidgetType := src.WidgetType;
    FReadOnly := src.ReadOnly;
    FRequired := src.Required;
    FVisible := src.Visible;
    FWidth := src.Width;
  end
  else
    inherited;
end;

{ TlzxColumn }

constructor TlzxColumn.Create(Collection: TCollection);
begin
  inherited;
  FFieldName := '';
  FExist := True;
  FHeaderText := '';
  FColumnDataType := cdtString;
  FFormat := '';
  FVisible := True;
  FWidth := 100;
end;

destructor TlzxColumn.Destroy;
begin
  inherited;
end;

{ TlzxColumn }

procedure TlzxColumn.Assign(Source: TPersistent);
var
  src: TlzxColumn;
begin
  if Source.ClassType = Self.ClassType then
  begin
    src := TlzxColumn(Source);
    FExist := src.Exist;
    FFieldName := src.FieldName;
    FHeaderText := src.HeaderText;
    FColumnDataType := src.ColumnDataType;
    FFormat := src.Format;
    FVisible := src.Visible;
    FWidth := src.Width;
  end
  else
    inherited;
end;

{ TlzxCard }

constructor TlzxCard.Create(Collection: TCollection);
begin
  inherited;
  FCaption := '';
  FCardID := '';
  FControls := TlzxControls.Create(TlzxControl);
end;

destructor TlzxCard.Destroy;
begin
  FreeAndNil(FControls);
  inherited;
end;

procedure TlzxCard.Assign(Source: TPersistent);
var
  src: TlzxCard;
begin
  if Source.ClassType = Self.ClassType then
  begin
    src := TlzxCard(Source);
    FCardID := src.CardID;
    FCaption := src.Caption;
    FControls.Assign(src.Controls);
  end
  else
    inherited;
end;

{ TlzxGrid }

constructor TlzxGrid.Create(Collection: TCollection);
begin
  inherited;
  FCaption := '';
  FGridID := '';
  FExport := True;
  FFocusedRow := True;
  FMultiSelect := false;
  FSearchPanel := false;
  FColumns := TlzxColumns.Create(TlzxColumn);
end;

destructor TlzxGrid.Destroy;
begin
  FreeAndNil(FColumns);
  inherited;
end;

{ TlzxGrid }

procedure TlzxGrid.Assign(Source: TPersistent);
var
  src: TlzxGrid;
begin
  if Source.ClassType = Self.ClassType then
  begin
    src := TlzxGrid(Source);
    FCaption := src.Caption;
    FGridID := src.GridID;
    FExport := src.Export;
    FFocusedRow := src.FocusedRow;
    FMultiSelect := src.MultiSelect;
    FSearchPanel := src.SearchPanel;
    FColumns.Assign(src.Columns);
  end
  else
    inherited;
end;

{ TlzxField }

constructor TlzxField.Create(Collection: TCollection);
begin
  inherited;
  FFieldName := '';
  FExist := false;
  FFieldType := ftUnknown;
  FFieldTypeJS := jftUnknown;
  FSize := 0;
  FReadOnly := false;
  FRequired := false;
  FVisible := True;
end;

destructor TlzxField.Destroy;
begin
  inherited;
end;

procedure TlzxField.Assign(Source: TPersistent);
var
  src: TlzxField;
begin
  if Source.ClassType = Self.ClassType then
  begin
    src := TlzxField(Source);
    FFieldName := src.FieldName;
    FDisplayLabel := src.DisplayLabel;
    FExist := src.Exist;
    FFieldType := src.FieldType;
    // Todo
    // FFieldTypeJS := src.FieldTypeJS;
    FSize := src.Size;
    FReadOnly := src.ReadOnly;
    FRequired := src.Required;
    FVisible := src.Visible;
  end
  else
    inherited;
end;

procedure TlzxField.SetFieldType(const Value: TFieldType);
begin
  FFieldType := Value;
  // Todo
  // FFieldTypeJS := GetFieldTypeJS(FFieldType);
end;

{ TlzxDataObject }

procedure TlzxDataObject.Clear;
begin
  DataSetName := '';
  TableName := '';
  PrimaryKeyFields := '';
  SQL_Select.Clear;
  SQL_Insert.Clear;
  SQL_Update.Clear;
  SQL_Delete.Clear;
  Fields.Clear;
  Cards.Clear;
  Grids.Clear;
end;

constructor TlzxDataObject.Create;
begin
  inherited;
  FDataSetName := '';
  FTableName := '';
  FPrimaryKeyFields := '';

  FSQL_Select := TStringList.Create;
  FSQL_Update := TStringList.Create;
  FSQL_Insert := TStringList.Create;
  FSQL_Delete := TStringList.Create;

  FFields := TlzxFields.Create(TlzxField);
  FCards := TlzxCards.Create(TlzxCard);
  FGrids := TlzxGrids.Create(TlzxGrid);
end;

destructor TlzxDataObject.Destroy;
begin
  FreeAndNil(FSQL_Select);
  FreeAndNil(FSQL_Update);
  FreeAndNil(FSQL_Insert);
  FreeAndNil(FSQL_Delete);
  FreeAndNil(FFields);
  FreeAndNil(FCards);
  FreeAndNil(FGrids);
  inherited;
end;

procedure TlzxDataObject.Assign(Source: TPersistent);
var
  src: TlzxDataObject;
begin
  if Source.ClassType = Self.ClassType then
  begin
    src := TlzxDataObject(Source);

    FSQL_Select.Assign(src.SQL_Select);
    FSQL_Insert.Assign(src.SQL_Insert);
    FSQL_Update.Assign(src.SQL_Update);
    FSQL_Delete.Assign(src.SQL_Delete);
    FTableName := src.TableName;
    FPrimaryKeyFields := src.PrimaryKeyFields;

    FFields.Assign(src.Fields);
    FCards.Assign(src.Cards);
    FGrids.Assign(src.Grids);
  end
  else
    inherited;
end;

class function TlzxDataObject.Decode(const JSON: string): TlzxDataObject;
var
  o: TJSObject;
begin
  o := TJSJSON.parseObject(JSON);
  Result := Decode(o);
end;

class function TlzxDataObject.Decode(const JSON: TJSObject): TlzxDataObject;
begin
  // TODO legge le prop dall'oggetto JSON
  /// //////////////////////////////////////////////////////////////////////////////////////////////
  /// //////////////////////////////////////////////////////////////////////////////////////////////
  /// //////////////////////////////////////////////////////////////////////////////////////////////

  Result := TlzxDataObject.Create;
  try
    Result.DataSetName := js.toString(JSON.Properties['DataSetName']);
    Result.TableName := js.toString(JSON.Properties['TableName']);
    Result.PrimaryKeyFields := js.toString(JSON.Properties['PrimaryKeyFields']);

    // LoadStringList(JSON, 'SQL_Select', Result.SQL_Select);
    // LoadStringList(JSON, 'SQL_Insert', Result.SQL_Insert);
    // LoadStringList(JSON, 'SQL_Update', Result.SQL_Update);
    // LoadStringList(JSON, 'SQL_Delete', Result.SQL_Delete);

    Result.Fields.Decode(JSON, 'Fields');
    Result.Cards.Decode(JSON, 'Cards');
    Result.Grids.Decode(JSON, 'Grids');
  except
    on e: Exception do
    begin
      Result.Free;
      raise;
    end;
  end;
end;

function TlzxDataObject.Encode(DataSet: TlzxDataObject; IncludeSQL: boolean = True): TJSObject;
// function StringsToJSArray(const data: TStrings): TJSArray;
// var
// i: integer;
// begin
// Result := TJSArray.Createw;
// for i := 0 to data.Count - 1 do
// Result.Add(data[i]);
// end;

begin

  Result := TJSObject.New;

  Result.Properties['DataSetName'] := DataSetName;
  Result.Properties['TableName'] := TableName;
  Result.Properties['PrimaryKeyFields'] := PrimaryKeyFields;

  // if IncludeSQL then
  // begin
  // Result.AddPair('SQL_Select', StringsToJSArray(Self.SQL_Select));
  // Result.AddPair('SQL_Insert', StringsToJSArray(SQL_Insert));
  // Result.AddPair('SQL_Update', StringsToJSArray(SQL_Update));
  // Result.AddPair('SQL_Delete', StringsToJSArray(SQL_Delete));
  // end;

  Result.Properties['Fields'] := Fields.Encode;
  Result.Properties['Cards'] := Cards.Encode;
  Result.Properties['Grids'] := Grids.Encode;
end;

function TlzxDataObject.AddCard: TlzxCard;
begin
  Result := Cards.AddCard(CapFirst(DataSetName), Fields);
end;

function TlzxDataObject.AddGrid: TlzxGrid;
begin
  Result := Grids.AddGrid(CapFirst(DataSetName), Fields);
end;

procedure TlzxDataObject.LoadDataSet(DataSet: TDataset);
begin
  Assert(Assigned(DataSet));

  if DataSetName = '' then
    DataSetName := DataSet.Name;

  Fields.LoadFields(DataSet.Fields);

  if Cards.Count = 0 then
    AddCard;

  Cards.LoadFields(Fields);

  if Grids.Count = 0 then
    AddGrid;

  Grids.LoadFields(Fields);
end;

procedure TlzxDataObject.SetSQL_Delete(const Value: TStrings);
begin
  FSQL_Delete.Assign(Value);
end;

procedure TlzxDataObject.SetSQL_Insert(const Value: TStrings);
begin
  FSQL_Insert.Assign(Value);
end;

procedure TlzxDataObject.SetSQL_Select(const Value: TStrings);
begin
  FSQL_Select.Assign(Value);
end;

procedure TlzxDataObject.SetSQL_Update(const Value: TStrings);
begin
  FSQL_Update.Assign(Value);
end;

procedure TlzxFields.LoadFields(Fields: TFields);
var
  dbField: TField;
  lzxField: TlzxField;
  i, x: integer;
begin
  Assert(Assigned(Fields));

  // inizializza
  for i := 0 to Self.Count - 1 do
    TlzxField(items[i]).Exist := false;
  //
  // /// /////////////////////////////////////////
  for dbField in Fields do
  begin

    lzxField := nil;
    for x := 0 to Self.Count - 1 do
      if TlzxField(items[i]).FieldName = dbField.FieldName then
      begin
        lzxField := TlzxField(items[i]);
        break;
      end;

    if Assigned(lzxField) then
    begin
      lzxField.Exist := True;
      lzxField.FieldType := dbField.DataType;
      lzxField.Size := dbField.Size;
      lzxField.ReadOnly := dbField.ReadOnly;
      lzxField.Required := dbField.Required;
      lzxField.Visible := dbField.Visible;
    end
    else
    begin
      lzxField := Self.Add as TlzxField;
      lzxField.Exist := True;
      lzxField.FieldName := dbField.FieldName;
      lzxField.DisplayLabel := CapFirst(dbField.DisplayLabel);
      lzxField.FieldType := dbField.DataType;
      lzxField.Size := dbField.Size;
      lzxField.ReadOnly := dbField.ReadOnly;
      lzxField.Required := dbField.Required;
      lzxField.Visible := dbField.Visible;
    end;
  end;
  /// /////////////////////////////////////////

  // rimuovi i campi inesistenti
  for i := Self.Count - 1 downto 0 do
  begin
    lzxField := TlzxField(items[i]);
    if not lzxField.Exist then
      lzxField.Free;
  end;
end;

{ TlzxControls }

procedure TlzxControls.LoadFields(Fields: TlzxFields);
var
  Field: TlzxField;
  ctrl: TlzxControl;
  i, x: integer;
begin
  Assert(Assigned(Fields));

  // inizializza
  for i := 0 to Self.Count - 1 do
    TlzxControl(items[i]).Exist := false;

  /// /////////////////////////////////////////
  for i := 0 to Fields.Count - 1 do
  begin
    Field := Fields.items[i] as TlzxField;

    ctrl := nil;
    for x := 0 to Self.Count - 1 do
      if TlzxControl(items[i]).FieldName = Field.FieldName then
      begin
        ctrl := TlzxControl(items[i]);
        break;
      end;

    if Assigned(ctrl) then
    begin
      ctrl.Exist := True;

      ctrl.ReadOnly := Field.ReadOnly;
      ctrl.Required := Field.Required;
    end
    else
    begin
      ctrl := Self.Add as TlzxControl;
      ctrl.Exist := True;
      ctrl.FieldName := Field.FieldName;

      // LabelBold:= boolean read FLabelBold write FLabelBold;
      ctrl.ReadOnly := Field.ReadOnly;
      ctrl.Required := Field.Required;
      // property Width: integer read FWidth write FWidth;
    end;
  end;
  /// /////////////////////////////////////////
  // rimuovi i campi inesistenti
  for i := Self.Count - 1 downto 0 do
  begin
    ctrl := TlzxControl(items[i]);
    if not ctrl.Exist then
      ctrl.Free;
  end;
end;

{ TlzxColumns }

procedure TlzxColumns.LoadFields(Fields: TlzxFields);
var
  Field: TlzxField;
  column: TlzxColumn;
  i: integer;
  x: integer;
begin
  Assert(Assigned(Fields));

  // inizializza
  for i := 0 to Self.Count - 1 do
    TlzxColumn(items[i]).Exist := false;

  /// /////////////////////////////////////////
  for i := 0 to Fields.Count - 1 do
  begin
    Field := Fields.items[i] as TlzxField;

    column := nil;
    for x := 0 to Self.Count - 1 do
      if TlzxColumn(items[i]).FieldName = Field.FieldName then
      begin
        column := TlzxColumn(items[i]);
        break;
      end;

    if Assigned(column) then
    begin
      column.Exist := True;

      // HeaderText
      column.ColumnDataType := GetColumnDataType(Field.FieldType);
      // Format
      // Visible
      // Width
    end
    else
    begin
      column := Self.Add as TlzxColumn;
      column.Exist := True;
      column.FieldName := Field.FieldName;
      column.ColumnDataType := GetColumnDataType(Field.FieldType);
    end;
  end;
  /// /////////////////////////////////////////
  // rimuovi i campi inesistenti
  for i := Self.Count - 1 downto 0 do
  begin
    column := TlzxColumn(items[i]);
    if not column.Exist then
      column.Free;
  end;
end;

function TlzxCards.AddCard(const Caption: string; Fields: TlzxFields): TlzxCard;
begin
  Result := Add as TlzxCard;
  Result.CardID := '';
  Result.Caption := Caption;
  Result.Controls.LoadFields(Fields);
end;

function TlzxCards.Get(CardID: string): TlzxCard;
var
  i: integer;
  tmp: TlzxCard;
begin
  Result := nil;

  if Count = 0 then
    Exit;

  if CardID = '' then
  begin
    Result := items[0] as TlzxCard;
    Exit;
  end
  else
    for i := 0 to Count - 1 do
    begin
      tmp := items[i] as TlzxCard;
      if SameText(tmp.CardID, CardID) then
      begin
        Result := tmp;
        Exit;
      end;
    end;
end;

procedure TlzxCards.LoadFields(Fields: TlzxFields);
var
  i: integer;
  card: TlzxCard;
begin
  for i := 0 to Count - 1 do
  begin
    card := items[i] as TlzxCard;
    card.Controls.LoadFields(Fields);
  end;
end;

function TlzxGrids.AddGrid(const Caption: string; Fields: TlzxFields): TlzxGrid;
begin
  Result := Add as TlzxGrid;
  Result.GridID := '';
  Result.Caption := Caption;
  Result.Columns.LoadFields(Fields);
end;

function TlzxGrids.Get(GridID: string): TlzxGrid;
var
  i: integer;
  tmp: TlzxGrid;
begin
  Result := nil;

  if Count = 0 then
    Exit;

  if GridID = '' then
  begin
    Result := items[0] as TlzxGrid;
    Exit;
  end
  else
    for i := 0 to Count - 1 do
    begin
      tmp := items[i] as TlzxGrid;
      if SameText(tmp.GridID, GridID) then
      begin
        Result := tmp;
        Exit;
      end;
    end;
end;

procedure TlzxGrids.LoadFields(Fields: TlzxFields);
var
  i: integer;
  grid: TlzxGrid;
begin
  for i := 0 to Count - 1 do
  begin
    grid := items[i] as TlzxGrid;
    grid.Columns.LoadFields(Fields);
  end;
end;

function TlzxDataObject.Meta: TJSObject;
begin
  Result := Encode(Self, false);
end;

end.
