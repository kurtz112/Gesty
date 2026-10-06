unit DevExtreme.types;

interface

uses
  System.SysUtils,
  System.Classes,
  js,
  web;

type
  TdxEventHandler = Reference to function(e: TJSObject): JSValue;
  TdxInitOptionsProc = Reference to Procedure(options: TJSObject);

  TdxHorizontalAlignment = (haLeft, haCenter, haRight);

  TdxHorizontalAlignmentHelper = record helper for TdxHorizontalAlignment
  public
    function ToString: string;
  end;

  TdxButtonType = (btBack, btDanger, btDefault, btNormal, btSuccess);

  TdxButtonTypeHelper = record helper for TdxButtonType
  public
    function ToString: string;
  end;

  TdxButtonStylingMode = (smText, smOutlined, smContained);

  TdxButtonStylingModeHelper = record helper for TdxButtonStylingMode
  public
    function ToString: string;
  end;

  TdxItemType = (itSimple, itGroup, itTabbed, itButton, itEmpty);

  TdxItemTypeHelper = record helper for TdxItemType
  public
    function ToString: string;
    class function FromString(const value: string): TdxItemType; static;
  end;

  TdxEditorType = (dxAutocomplete, dxCalendar, dxCheckBox, dxColorBox, dxDateBox, dxDropDownBox, dxHtmlEditor, dxLookup, dxNumberBox, dxRadioGroup, dxRangeSlider, dxSelectBox, dxSlider, dxSwitch,
    dxTagBox, dxTextArea, dxTextBox);

  TdxEditorTypeHelper = record helper for TdxEditorType
  public
    function ToString: string;
    class function FromString(const value: string): TdxEditorType; static;
  end;

  TLabelOption = (loLabelBold, loPlaceholder, loFloating);
  TLabelOptions = set of TLabelOption;

const
  DefaultLabelOptions = [loFloating];

implementation

uses
  rtti;

{ TdxHorizontalAlignmentHelper }

function TdxHorizontalAlignmentHelper.ToString: string;
begin
  case self of
    haLeft:
      Result := 'left';
    haCenter:
      Result := 'center';
    haRight:
      Result := 'right';
  end;

end;

{ TdxButtonTypeHelper }

function TdxButtonTypeHelper.ToString: string;
begin
  case self of
    btBack:
      Result := 'back';
    btDanger:
      Result := 'danger';
    btDefault:
      Result := 'default';
    btNormal:
      Result := 'normal';
    btSuccess:
      Result := 'success';
  end;
end;

{ TdxButtonStylingModeHelper }

function TdxButtonStylingModeHelper.ToString: string;
begin
  case self of
    smText:
      Result := 'text';
    smOutlined:
      Result := 'outlined';
    smContained:
      Result := 'contained';
  end;
end;

/// /////////////////////////////////////////

{ TdxItemTypeHelper }

class function TdxItemTypeHelper.FromString(const value: string): TdxItemType;
var
  s: String;
begin
  Result := itSimple;

  if value.isEmpty then
    exit;

  s := 'it' + value.Substring(0, 1).ToUpper() + value.Substring(1);
  Result := TRttiEnumerationType.GetValue<TdxItemType>(s);
end;

function TdxItemTypeHelper.ToString: string;
begin
  Result := TRttiEnumerationType.GetName<TdxItemType>(self);
end;

/// /////////////////////////////////////////

{ TdxEditorTypeHelper }

class function TdxEditorTypeHelper.FromString(const value: string): TdxEditorType;
begin

  if value.isEmpty then
    Result := dxTextBox
  else
    Result := TRttiEnumerationType.GetValue<TdxEditorType>(value);
end;

function TdxEditorTypeHelper.ToString: string;
begin
  Result := TRttiEnumerationType.GetName<TdxEditorType>(self);
end;

end.
