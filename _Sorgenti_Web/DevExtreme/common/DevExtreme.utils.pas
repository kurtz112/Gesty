unit DevExtreme.utils;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  WEBLib.JSON,
  js,
  web;

type
  /// //////////////////////////
  TdxScreenKind = (skPhone, skTablet, skDesktop);

  TdxScreenKindHelper = record helper for TdxScreenKind
  public
    function ToString: string;
  end;

  TdxScreenSize = (ssExtraSmall, ssSmall, ssMedium, ssLarge);

  TdxOrientation = (soPortrait, soLandscape);

  TdxOrientationHelper = record helper for TdxOrientation
  public
    function ToString: string;
  end;

  TdxUtils = record
  public
    //
    class function ExtractValue(e: TJSObject; const FieldName: string; out value: JSValue): boolean; overload; static;
    class function ExtractValue(e: TJSObject; const FieldName: string; out value: integer): boolean; overload; static;
    class function ExtractValue(e: TJSObject; const FieldName: string; out value: string): boolean; overload; static;
    class function ExtractValue(e: TJSObject; const FieldName: string; out value: boolean): boolean; overload; static;
    //
    class procedure Notify(const msg: string); assembler; static;
    class function Alert(const title, msg: string): TJSPromise; assembler; static;
    class function Confirm(const title, msg: string): TJSPromise; assembler; overload; static;
    class procedure Confirm(const title, msg: string; OkProc, CancelProc: TProc); overload; static;
    class function Custom(options: TJSObject): TJSObject; assembler; static;
    // js
    class function Platform: string; assembler; static;
    class function PlatformVersion: JSValue; assembler; static;
    class function DeviceType: string; assembler; static;
    class function DeviceGrade: string; assembler; static;
    class function Screen: TdxScreenKind; static;

    class function ScreenSize: TdxScreenSize; static;
    class function ScreenWidth: integer; static;
    class function ScreenHeight: integer; static;

    class function Orientation: TdxOrientation; static;
    class function isPhone: boolean; assembler; static;
    class function isTablet: boolean; assembler; static;
    class function isDesktop: boolean; static;
    class function isMobile: boolean; static;
    class function isLowHeight: boolean; static;
    //
    class procedure SetLocale(const locale: string); assembler; static;
    class procedure SetCurrency(const currency: string); assembler; static;
    //
    class function MetaGetPK(meta: TJSObject): string; static;
  end;

function dxGetObjectProperty(item: TJSObject; const optionName: string): TJSObject;

function dxDateValue(data: TJSObject; dataField: string): TDateTime;

function dxAction(Caption: string; icon: string; ClickEventHandler: THTMLClickEventHandler): TJSObject;
function dxSeparator(): TJSObject;

function dxColumnVisible(col: TJSObject): boolean;
function dxColumnWidth(col: TJSObject): integer;

procedure dxShowError(const error: string);

implementation

uses
  libjquery,
  zz.web.js;

function TdxScreenKindHelper.ToString: string;
begin
  case self of
    skPhone:
      result := 'Phone';
    skTablet:
      result := 'Tablet';
    skDesktop:
      result := 'Desktop';
  end;
end;

{ TdxOrientationHelper }

function TdxOrientationHelper.ToString: string;
begin
  case self of
    soPortrait:
      result := 'portait';
    soLandscape:
      result := 'landscape';
  end;
end;

{ TdxUtils }

class procedure TdxUtils.Notify(const msg: string);
asm
  DevExpress.ui.notify(msg);
end;

class function TdxUtils.Alert(const title, msg: string): TJSPromise;
asm
  return DevExpress.ui.dialog.alert(msg, title);
end;

class function TdxUtils.Confirm(const title, msg: string): TJSPromise;
asm
  return DevExpress.ui.dialog.confirm(msg, title);
end;

class function TdxUtils.ScreenSize: TdxScreenSize;
var
  width: integer;
begin
  width := ScreenWidth;

  if width < 640 then
    result := ssExtraSmall
  else
    if width < 1280 then
      result := ssSmall
    else
      if width < 1920 then
        result := ssMedium
      else
        result := ssLarge;
end;

class function TdxUtils.ScreenWidth: integer;
begin
  result := window.innerWidth;
end;

class procedure TdxUtils.Confirm(const title, msg: string; OkProc, CancelProc: TProc);
var
  Promise: TJSPromise;
begin
  Promise := Confirm(title, msg);
  Promise._then(
    function(value: JSValue): JSValue
    var
      proc: TProc;
    begin
      if js.ToBoolean(value) then
        proc := OkProc
      else
        proc := CancelProc;

      if assigned(proc) then
        proc;
    end);
end;

class function TdxUtils.Custom(options: TJSObject): TJSObject;
asm
  return DevExpress.ui.dialog.custom(options);
end;

class function TdxUtils.Orientation: TdxOrientation;
begin
  if window.innerWidth > window.innerHeight then
    result := soLandscape
  else
    result := soPortrait;
end;

class function TdxUtils.Platform: string;
asm
  var device = DevExpress.devices.real();
  return device.platform;
end;

class function TdxUtils.PlatformVersion: JSValue; assembler; static;
asm
  var device = DevExpress.devices.real();
  return device.version;
end;

class function TdxUtils.isDesktop: boolean;
begin
  // var device = DevExpress.devices.real();
  // return device.desktop;
  // return ((!device.tablet) && (window.innerWidth>768));
  result := not(isPhone or isTablet);
end;

class function TdxUtils.isMobile: boolean;
begin
  result := isPhone or isTablet;
end;

class function TdxUtils.DeviceType: string; static;
asm
  var device = DevExpress.devices.real();
  return device.deviceType;
end;

class function TdxUtils.DeviceGrade: string; static;
asm
  var device = DevExpress.devices.real();
  return device.grade;
end;

class function TdxUtils.isPhone: boolean;
asm
  var device = DevExpress.devices.real();
  return device.phone;
end;

class function TdxUtils.isTablet: boolean;
asm
  var device = DevExpress.devices.real();
  return device.tablet;
end;

class function TdxUtils.MetaGetPK(meta: TJSObject): string;
begin
  result := '';

  if meta.hasOwnProperty('PK') then
    result := js.ToString(meta['PK']);
end;

class procedure TdxUtils.SetCurrency(const currency: string);
asm
  DevExpress.config({ defaultCurrency: currency });
end;

class procedure TdxUtils.SetLocale(const locale: string);
asm
  DevExpress.localization.locale(locale);
end;

class function TdxUtils.ExtractValue(e: TJSObject; const FieldName: string; out value: JSValue): boolean;
var
  data: TJSObject;
begin
  result := false;

  if not e.hasOwnProperty('data') then
    exit;

  data := toObject(e.Properties['data']);

  if not assigned(data) then
    exit;

  if not data.hasOwnProperty(FieldName) then
    exit;

  value := data.Properties[FieldName];
  result := true;
end;

class function TdxUtils.ExtractValue(e: TJSObject; const FieldName: string; out value: string): boolean;
var
  j: JSValue;
begin
  result := ExtractValue(e, FieldName, j);

  if not isNull(j) then
  begin
    result := js.isString(j);

    if result then
      value := js.ToString(j);
  end;
end;

class function TdxUtils.ExtractValue(e: TJSObject; const FieldName: string; out value: integer): boolean;
var
  j: JSValue;
begin
  result := ExtractValue(e, FieldName, j);

  if not isNull(j) then
  begin
    result := js.isInteger(j);

    if result then
      value := toInteger(j);
  end;
end;

class function TdxUtils.ExtractValue(e: TJSObject; const FieldName: string; out value: boolean): boolean;
var
  j: JSValue;
begin
  result := ExtractValue(e, FieldName, j);

  if not isNull(j) then
  begin
    result := js.isInteger(j);

    if result then
      value := ToBoolean(j);
  end;
end;

class function TdxUtils.isLowHeight: boolean;
begin
  // phone oppure tablet in orizzontale
  result := isPhone or (isTablet and (Orientation = TdxOrientation.soLandscape));
end;

class function TdxUtils.Screen: TdxScreenKind;
begin
  if isPhone then
    result := skPhone
  else
    if isTablet then
      result := skTablet
    else
      if isDesktop then
        result := skDesktop;
end;

class function TdxUtils.ScreenHeight: integer;
begin
  result := window.innerHeight;
end;

function dxAction(Caption: string; icon: string; ClickEventHandler: THTMLClickEventHandler): TJSObject;
begin
  result := TJSObject.new;
  result['text'] := Caption;
  result['icon'] := icon;
  result['onClick'] := ClickEventHandler;
end;

function dxSeparator(): TJSObject;
begin
  result := dxAction('', '', nil);
end;

function dxColumnVisible(col: TJSObject): boolean;
begin
  result := true; // se omessa è true

  if col.hasOwnProperty('visible') then
    result := js.ToBoolean(col['visible']);
end;

function dxColumnWidth(col: TJSObject): integer;
begin
  result := 0;

  if col.hasOwnProperty('widthPX') then
    result := js.toInteger(col['widthPX']);
end;

function dxGetObjectProperty(item: TJSObject; const optionName: string): TJSObject;
begin
  if item.hasOwnProperty(optionName) then
    result := TJSObject(item[optionName])
  else
    result := TJSObject.new;
end;

function dxDateValue(data: TJSObject; dataField: string): TDateTime;
var
  value: JSValue;
begin
  value := data[dataField];

  if js.isDate(value) then
    result := JSDateToDateTime(TJSDate(value))
  else
    if js.isString(value) then
      result := JSDateToDateTime(ISOStrToDateTimeJS(js.ToString(value)));
end;

function dxIntValue(data: TJSObject; dataField: string): integer;
begin

end;

function dxFloatValue(data: TJSObject; dataField: string): double;
begin

end;

procedure dxShowError(const error: string);
begin
  TdxUtils.Alert('', error);
end;

initialization

asm
  // DevExpress.ui.dxOverlay.baseZIndex(20000);
end;

end.
