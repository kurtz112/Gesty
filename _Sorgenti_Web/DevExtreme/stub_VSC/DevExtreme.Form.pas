unit DevExtreme.Form;

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
  TjdxForm = class(TjdxCustomControl)
  private
    FaccessKey: string;
    FactiveStateEnabled: boolean;
    FalignItemLabels: boolean;
    FalignItemLabelsInAllGroups: boolean;
    FcolCount: JSValue;
    FcolCountByScreen: TJSObject;
    FcustomizeItem: TJSFunction;
    Fdisabled: boolean;
    FelementAttr: TJSObject;
    FfocusStateEnabled: boolean;
    FformData: JSValue;
    Fheight_: JSValue;
    Fhint: string;
    FhoverStateEnabled: boolean;
    Fitems: TJSArray;
    FlabelLocation: TdxLabelLocation;
    FlabelMode: TdxFormLabelMode;
    FminColWidth: integer;
    FoptionalMark: string;
    FreadOnly: boolean;
    FrequiredMark: string;
    FrequiredMessage: string;
    FrtlEnabled: boolean;
    FscreenByWidth: TJSFunction;
    FscrollingEnabled: boolean;
    FshowColonAfterLabel: boolean;
    FshowOptionalMark: boolean;
    FshowRequiredMark: boolean;
    FshowValidationSummary: boolean;
    FtabIndex: integer;
    FvalidationGroup: string;
    Fvisible: boolean;
    Fwidth_: JSValue;
  private
    FonContentReady: TdxEventHandler;
    FonDisposing: TdxEventHandler;
    FonEditorEnterKey: TdxEventHandler;
    FonFieldDataChanged: TdxEventHandler;
    FonFocusIn: TdxEventHandler;
    FonFocusOut: TdxEventHandler;
    FonInitialized: TdxEventHandler;
    FonOptionChanged: TdxEventHandler;
  private
    procedure Set_accessKey(const value: string);
    procedure Set_activeStateEnabled(const value: boolean);
    procedure Set_alignItemLabels(const value: boolean);
    procedure Set_alignItemLabelsInAllGroups(const value: boolean);
    procedure Set_colCount(const value: JSValue);
    procedure Set_colCountByScreen(const value: TJSObject);
    procedure Set_customizeItem(const value: TJSFunction);
    procedure Set_disabled(const value: boolean);
    procedure Set_elementAttr(const value: TJSObject);
    procedure Set_focusStateEnabled(const value: boolean);
    procedure Set_formData(const value: JSValue);
    procedure Set_height_(const value: JSValue);
    procedure Set_hint(const value: string);
    procedure Set_hoverStateEnabled(const value: boolean);
    procedure Set_items(const value: TJSArray);
    procedure Set_labelLocation(const value: TdxLabelLocation);
    procedure Set_labelMode(const value: TdxFormLabelMode);
    procedure Set_minColWidth(const value: integer);
    procedure Set_optionalMark(const value: string);
    procedure Set_readOnly(const value: boolean);
    procedure Set_requiredMark(const value: string);
    procedure Set_requiredMessage(const value: string);
    procedure Set_rtlEnabled(const value: boolean);
    procedure Set_screenByWidth(const value: TJSFunction);
    procedure Set_scrollingEnabled(const value: boolean);
    procedure Set_showColonAfterLabel(const value: boolean);
    procedure Set_showOptionalMark(const value: boolean);
    procedure Set_showRequiredMark(const value: boolean);
    procedure Set_showValidationSummary(const value: boolean);
    procedure Set_tabIndex(const value: integer);
    procedure Set_validationGroup(const value: string);
    procedure Set_visible(const value: boolean);
    procedure Set_width_(const value: JSValue);
  private
    procedure Set_onContentReady(const value: TdxEventHandler);
    procedure Set_onDisposing(const value: TdxEventHandler);
    procedure Set_onEditorEnterKey(const value: TdxEventHandler);
    procedure Set_onFieldDataChanged(const value: TdxEventHandler);
    procedure Set_onFocusIn(const value: TdxEventHandler);
    procedure Set_onFocusOut(const value: TdxEventHandler);
    procedure Set_onInitialized(const value: TdxEventHandler);
    procedure Set_onOptionChanged(const value: TdxEventHandler);
  public
    constructor Create(aOwner: TComponent); override;
  public
    property colCount: JSValue read FcolCount write Set_colCount;
    property colCountByScreen: TJSObject read FcolCountByScreen write Set_colCountByScreen;
    property customizeItem: TJSFunction read FcustomizeItem write Set_customizeItem;
    property elementAttr: TJSObject read FelementAttr write Set_elementAttr;
    property formData: JSValue read FformData write Set_formData;
    property height_: JSValue read Fheight_ write Set_height_;
    property items: TJSArray read Fitems write Set_items;
    property screenByWidth: TJSFunction read FscreenByWidth write Set_screenByWidth;
    property width_: JSValue read Fwidth_ write Set_width_;
  published
    property accessKey: string read FaccessKey write Set_accessKey;
    property activeStateEnabled: boolean read FactiveStateEnabled write Set_activeStateEnabled default false;
    property alignItemLabels: boolean read FalignItemLabels write Set_alignItemLabels default true;
    property alignItemLabelsInAllGroups: boolean read FalignItemLabelsInAllGroups write Set_alignItemLabelsInAllGroups default true;
    property disabled: boolean read Fdisabled write Set_disabled default false;
    property focusStateEnabled: boolean read FfocusStateEnabled write Set_focusStateEnabled default false;
    property hint: string read Fhint write Set_hint;
    property hoverStateEnabled: boolean read FhoverStateEnabled write Set_hoverStateEnabled default false;
    property labelLocation: TdxLabelLocation read FlabelLocation write Set_labelLocation default llLeft;
    property labelMode: TdxFormLabelMode read FlabelMode write Set_labelMode default flmOutside;
    property minColWidth: integer read FminColWidth write Set_minColWidth;
    property optionalMark: string read FoptionalMark write Set_optionalMark;
    property readOnly: boolean read FreadOnly write Set_readOnly default false;
    property requiredMark: string read FrequiredMark write Set_requiredMark;
    property requiredMessage: string read FrequiredMessage write Set_requiredMessage;
    property rtlEnabled: boolean read FrtlEnabled write Set_rtlEnabled default false;
    property scrollingEnabled: boolean read FscrollingEnabled write Set_scrollingEnabled default false;
    property showColonAfterLabel: boolean read FshowColonAfterLabel write Set_showColonAfterLabel;
    property showOptionalMark: boolean read FshowOptionalMark write Set_showOptionalMark default false;
    property showRequiredMark: boolean read FshowRequiredMark write Set_showRequiredMark default true;
    property showValidationSummary: boolean read FshowValidationSummary write Set_showValidationSummary default false;
    property tabIndex: integer read FtabIndex write Set_tabIndex;
    property validationGroup: string read FvalidationGroup write Set_validationGroup;
    property visible: boolean read Fvisible write Set_visible default true;
  published
    property onContentReady: TdxEventHandler read FonContentReady write Set_onContentReady;
    property onDisposing: TdxEventHandler read FonDisposing write Set_onDisposing;
    property onEditorEnterKey: TdxEventHandler read FonEditorEnterKey write Set_onEditorEnterKey;
    property onFieldDataChanged: TdxEventHandler read FonFieldDataChanged write Set_onFieldDataChanged;
    property onFocusIn: TdxEventHandler read FonFocusIn write Set_onFocusIn;
    property onFocusOut: TdxEventHandler read FonFocusOut write Set_onFocusOut;
    property onInitialized: TdxEventHandler read FonInitialized write Set_onInitialized;
    property onOptionChanged: TdxEventHandler read FonOptionChanged write Set_onOptionChanged;
  end;

implementation


constructor TjdxForm.Create(aOwner: TComponent);
begin
  inherited;
  FaccessKey := '';
  FactiveStateEnabled := false;
  FalignItemLabels := true;
  FalignItemLabelsInAllGroups := true;
  FcolCount := nil;
  FcolCountByScreen := TJSObject.new;
  FcustomizeItem := nil;
  Fdisabled := false;
  FelementAttr := TJSObject.new;
  FfocusStateEnabled := false;
  FformData := nil;
  Fheight_ := nil;
  Fhint := '';
  FhoverStateEnabled := false;
  Fitems := TJSArray.new;
  FlabelLocation := llLeft;
  FlabelMode := flmOutside;
  FminColWidth := 0;
  FoptionalMark := '';
  FreadOnly := false;
  FrequiredMark := '';
  FrequiredMessage := '';
  FrtlEnabled := false;
  FscreenByWidth := nil;
  FscrollingEnabled := false;
  FshowColonAfterLabel := false;
  FshowOptionalMark := false;
  FshowRequiredMark := true;
  FshowValidationSummary := false;
  FtabIndex := 0;
  FvalidationGroup := '';
  Fvisible := true;
  Fwidth_ := nil;

  FonContentReady := nil;
  FonDisposing := nil;
  FonEditorEnterKey := nil;
  FonFieldDataChanged := nil;
  FonFocusIn := nil;
  FonFocusOut := nil;
  FonInitialized := nil;
  FonOptionChanged := nil;
end;

procedure TjdxForm.Set_accessKey(const Value: string);
begin
  FaccessKey := Value;
end;

procedure TjdxForm.Set_activeStateEnabled(const Value: boolean);
begin
  FactiveStateEnabled := Value;
end;

procedure TjdxForm.Set_alignItemLabels(const Value: boolean);
begin
  FalignItemLabels := Value;
end;

procedure TjdxForm.Set_alignItemLabelsInAllGroups(const Value: boolean);
begin
  FalignItemLabelsInAllGroups := Value;
end;

procedure TjdxForm.Set_colCount(const Value: JSValue);
begin
  FcolCount := Value;
end;

procedure TjdxForm.Set_colCountByScreen(const Value: TJSObject);
begin
  FcolCountByScreen := Value;
end;

procedure TjdxForm.Set_customizeItem(const Value: TJSFunction);
begin
  FcustomizeItem := Value;
end;

procedure TjdxForm.Set_disabled(const Value: boolean);
begin
  Fdisabled := Value;
end;

procedure TjdxForm.Set_elementAttr(const Value: TJSObject);
begin
  FelementAttr := Value;
end;

procedure TjdxForm.Set_focusStateEnabled(const Value: boolean);
begin
  FfocusStateEnabled := Value;
end;

procedure TjdxForm.Set_formData(const Value: JSValue);
begin
  FformData := Value;
end;

procedure TjdxForm.Set_height_(const Value: JSValue);
begin
  Fheight_ := Value;
end;

procedure TjdxForm.Set_hint(const Value: string);
begin
  Fhint := Value;
end;

procedure TjdxForm.Set_hoverStateEnabled(const Value: boolean);
begin
  FhoverStateEnabled := Value;
end;

procedure TjdxForm.Set_items(const Value: TJSArray);
begin
  Fitems := Value;
end;

procedure TjdxForm.Set_labelLocation(const Value: TdxLabelLocation);
begin
  FlabelLocation := Value;
end;

procedure TjdxForm.Set_labelMode(const Value: TdxFormLabelMode);
begin
  FlabelMode := Value;
end;

procedure TjdxForm.Set_minColWidth(const Value: integer);
begin
  FminColWidth := Value;
end;

procedure TjdxForm.Set_optionalMark(const Value: string);
begin
  FoptionalMark := Value;
end;

procedure TjdxForm.Set_readOnly(const Value: boolean);
begin
  FreadOnly := Value;
end;

procedure TjdxForm.Set_requiredMark(const Value: string);
begin
  FrequiredMark := Value;
end;

procedure TjdxForm.Set_requiredMessage(const Value: string);
begin
  FrequiredMessage := Value;
end;

procedure TjdxForm.Set_rtlEnabled(const Value: boolean);
begin
  FrtlEnabled := Value;
end;

procedure TjdxForm.Set_screenByWidth(const Value: TJSFunction);
begin
  FscreenByWidth := Value;
end;

procedure TjdxForm.Set_scrollingEnabled(const Value: boolean);
begin
  FscrollingEnabled := Value;
end;

procedure TjdxForm.Set_showColonAfterLabel(const Value: boolean);
begin
  FshowColonAfterLabel := Value;
end;

procedure TjdxForm.Set_showOptionalMark(const Value: boolean);
begin
  FshowOptionalMark := Value;
end;

procedure TjdxForm.Set_showRequiredMark(const Value: boolean);
begin
  FshowRequiredMark := Value;
end;

procedure TjdxForm.Set_showValidationSummary(const Value: boolean);
begin
  FshowValidationSummary := Value;
end;

procedure TjdxForm.Set_tabIndex(const Value: integer);
begin
  FtabIndex := Value;
end;

procedure TjdxForm.Set_validationGroup(const Value: string);
begin
  FvalidationGroup := Value;
end;

procedure TjdxForm.Set_visible(const Value: boolean);
begin
  Fvisible := Value;
end;

procedure TjdxForm.Set_width_(const Value: JSValue);
begin
  Fwidth_ := Value;
end;

procedure TjdxForm.Set_onContentReady(const Value: TdxEventHandler);
begin
  FonContentReady := Value;
end;

procedure TjdxForm.Set_onDisposing(const Value: TdxEventHandler);
begin
  FonDisposing := Value;
end;

procedure TjdxForm.Set_onEditorEnterKey(const Value: TdxEventHandler);
begin
  FonEditorEnterKey := Value;
end;

procedure TjdxForm.Set_onFieldDataChanged(const Value: TdxEventHandler);
begin
  FonFieldDataChanged := Value;
end;

procedure TjdxForm.Set_onFocusIn(const Value: TdxEventHandler);
begin
  FonFocusIn := Value;
end;

procedure TjdxForm.Set_onFocusOut(const Value: TdxEventHandler);
begin
  FonFocusOut := Value;
end;

procedure TjdxForm.Set_onInitialized(const Value: TdxEventHandler);
begin
  FonInitialized := Value;
end;

procedure TjdxForm.Set_onOptionChanged(const Value: TdxEventHandler);
begin
  FonOptionChanged := Value;
end;

end.
