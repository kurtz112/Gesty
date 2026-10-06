unit DevExtreme.FilterBuilder;

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
  [ComponentPlatforms(TMSWebPlatform)]
  TjdxFilterBuilder = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FallowHierarchicalFields: boolean;
    FcustomOperations: TJSArray;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    Ffields: TJSArray;
    FfilterOperationDescriptions: TJSObject;
    FfocusStateEnabled: boolean;
    FgroupOperationDescriptions: TJSObject;
    FgroupOperations: TJSArray;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    FmaxGroupLevel: integer;
    FrtlEnabled: boolean;
    FtabIndex: integer;
    Fvalue: JSValue;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonEditorPrepared: TdxEventHandler;
    FonEditorPreparing: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
    FonValueChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_allowHierarchicalFields(const value: boolean);
    procedure Set_customOperations(const value: TJSArray);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_fields(const value: TJSArray);
    procedure Set_filterOperationDescriptions(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_groupOperationDescriptions(const value: TJSObject);
    procedure Set_groupOperations(const value: TJSArray);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_maxGroupLevel(const value: integer);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_value(const value: JSValue);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onEditorPrepared(const value: TdxEventHandler);
    procedure Set_onEditorPreparing(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
    procedure Set_onValueChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property customOperations: TJSArray read FcustomOperations write Set_customOperations;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property fields: TJSArray read Ffields write Set_fields;
    property filterOperationDescriptions: TJSObject read FfilterOperationDescriptions write Set_filterOperationDescriptions;
    property groupOperationDescriptions: TJSObject read FgroupOperationDescriptions write Set_groupOperationDescriptions;
    property groupOperations: TJSArray read FgroupOperations write Set_groupOperations;
    property height_: JSValue read Fheight_ write Set_height_;
    property value: JSValue read Fvalue write Set_value;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property allowHierarchicalFields: boolean read FallowHierarchicalFields write Set_allowHierarchicalFields default false;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property maxGroupLevel: integer read FmaxGroupLevel write Set_maxGroupLevel;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onEditorPrepared: TdxEventHandler read FonEditorPrepared write Set_onEditorPrepared;
    property onEditorPreparing: TdxEventHandler read FonEditorPreparing write Set_onEditorPreparing;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
    property onValueChanged: TdxEventHandler read FonValueChanged write Set_onValueChanged;
  end;

implementation


constructor TjdxFilterBuilder.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FallowHierarchicalFields := false;
  FcustomOperations := TJSArray.new;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  Ffields := TJSArray.new;
  FfilterOperationDescriptions := TJSObject.new;
  FfocusStateEnabled := false;
  FgroupOperationDescriptions := TJSObject.new;
  FgroupOperations := TJSArray.new;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  FmaxGroupLevel := 0;
  FrtlEnabled := false;
  FtabIndex := 0;
  Fvalue := nil;
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonEditorPrepared := nil;
  FonEditorPreparing := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
  FonValueChanged := nil;
end;

procedure TjdxFilterBuilder.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxFilterBuilder.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxFilterBuilder.Set_allowHierarchicalFields(const Value: boolean);
begin
  FallowHierarchicalFields := Value;
end;

procedure TjdxFilterBuilder.Set_customOperations(const Value: TJSArray);
begin
  FcustomOperations := Value;
end;

procedure TjdxFilterBuilder.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxFilterBuilder.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxFilterBuilder.Set_fields(const Value: TJSArray);
begin
  Ffields := Value;
end;

procedure TjdxFilterBuilder.Set_filterOperationDescriptions(const Value: TJSObject);
begin
  FfilterOperationDescriptions := Value;
end;

procedure TjdxFilterBuilder.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxFilterBuilder.Set_groupOperationDescriptions(const Value: TJSObject);
begin
  FgroupOperationDescriptions := Value;
end;

procedure TjdxFilterBuilder.Set_groupOperations(const Value: TJSArray);
begin
  FgroupOperations := Value;
end;

procedure TjdxFilterBuilder.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxFilterBuilder.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxFilterBuilder.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxFilterBuilder.Set_maxGroupLevel(const Value: integer);
begin
  FmaxGroupLevel := Value;
end;

procedure TjdxFilterBuilder.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxFilterBuilder.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxFilterBuilder.Set_value(const Value: JSValue);
begin
  Fvalue := Value;
end;

procedure TjdxFilterBuilder.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxFilterBuilder.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxFilterBuilder.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxFilterBuilder.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxFilterBuilder.Set_onEditorPrepared(const Value: TdxEventHandler);
begin
  FonEditorPrepared := Value;
end;

procedure TjdxFilterBuilder.Set_onEditorPreparing(const Value: TdxEventHandler);
begin
  FonEditorPreparing := Value;
end;

procedure TjdxFilterBuilder.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxFilterBuilder.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxFilterBuilder.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxFilterBuilder.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

procedure TjdxFilterBuilder.Set_onValueChanged(const Value: TdxEventHandler);
begin
  FonValueChanged := Value;
end;

end.
