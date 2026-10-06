unit DevExtreme.Validation;

interface

uses
  System.SysUtils,
  System.Classes,
  WEBLib.JSON,
  jsdelphisystem,
  js,
  web;

// https://js.devexpress.com/Documentation/ApiReference/UI_Widgets/dxValidator/Validation_Rules/
// I valori di default sono presi dalla documentazione

type
  TdxValidation = record
  public
    class procedure AddRule(options: TJSObject; ValidationRule: TJSObject); static;
    class function GetRules(options: TJSObject): TJSArray; static;
    class function IsValid(j: JSValue): boolean; static;
    class function ErrorMessage(j: JSValue): string; static;
  public
    class function Compare(const msg: string; comparisonTarget: TJSFunction; comparisonType: string = '=='; const ignoreEmpty: boolean = false): TJSObject; static;
    class function Pattern(const msg: string; Pattern: string; const ignoreEmpty: boolean = true): TJSObject; static;
    class function Range(const msg: string; const min, max: TDateTime; const ignoreEmpty: boolean = true): TJSObject; overload; static;
    class function Range(const msg: string; const min, max: integer; const ignoreEmpty: boolean = true): TJSObject; overload; static;
    class function Range(const msg: string; const min, max: double; const ignoreEmpty: boolean = true): TJSObject; overload; static;
    class function Required(const fieldName: string; const trimValue: boolean = true): TJSObject; static;
    class function StringLength(const msg: string; const min, max: integer; const ignoreEmpty: boolean = false; const trimValue: boolean = true): TJSObject; static;
  public
    class function Email(const fieldName: string; const ignoreEmpty: boolean = true): TJSObject; static;
    class function Numeric(const fieldName: string; const ignoreEmpty: boolean = true): TJSObject; static;
  end;

implementation

class procedure TdxValidation.AddRule(options: TJSObject; ValidationRule: TJSObject);
var
  validationRules: TJSArray;
begin
  validationRules := GetRules(options);
  validationRules.push(ValidationRule);
end;

class function TdxValidation.Compare(const msg: string; comparisonTarget: TJSFunction; comparisonType: string = '=='; const ignoreEmpty: boolean = false): TJSObject;
begin
  result := TJSObject.new;
  result['type'] := 'compare';
  result['comparisonTarget'] := comparisonTarget;

  // Accepted Values: '!=' | '!==' | '<' | '<=' | '==' | '===' | '>' | '>='
  if comparisonType <> '==' then
    result['comparisonType'] := comparisonType;

  if ignoreEmpty then
    result['ignoreEmptyValue'] := ignoreEmpty;

  result['message'] := msg;
end;

class function TdxValidation.StringLength(const msg: string; const min, max: integer; const ignoreEmpty: boolean = false; const trimValue: boolean = true): TJSObject;
begin
  result := TJSObject.new;
  result['type'] := 'stringLength';

  if min > 0 then
    result['min'] := min;

  if max > 0 then
    result['max'] := max;

  if ignoreEmpty then
    result['ignoreEmptyValue'] := ignoreEmpty;

  if not trimValue then
    result['trim'] := trimValue;

  result['message'] := msg;
end;

class function TdxValidation.Range(const msg: string; const min, max: double; const ignoreEmpty: boolean = true): TJSObject;
begin
  result := TJSObject.new;
  result['type'] := 'range';

  result['min'] := min;
  result['max'] := max;

  if ignoreEmpty then
    result['ignoreEmptyValue'] := ignoreEmpty;

  result['message'] := msg;
end;

class function TdxValidation.Range(const msg: string; const min, max: integer; const ignoreEmpty: boolean = true): TJSObject;
begin
  result := TJSObject.new;
  result['type'] := 'range';

  result['min'] := min;
  result['max'] := max;

  if ignoreEmpty then
    result['ignoreEmptyValue'] := ignoreEmpty;

  result['message'] := msg;
end;

class function TdxValidation.Pattern(const msg: string; Pattern: string; const ignoreEmpty: boolean = true): TJSObject;
begin
  result := TJSObject.new;
  result['type'] := 'pattern';
  result['pattern'] := Pattern;

  if not ignoreEmpty then
    result['ignoreEmptyValue'] := ignoreEmpty;

  result['message'] := msg;
end;

class function TdxValidation.Range(const msg: string; const min, max: TDateTime; const ignoreEmpty: boolean = true): TJSObject;
begin
  result := TJSObject.new;
  result['type'] := 'range';

  result['min'] := min;
  result['max'] := max;

  if ignoreEmpty then
    result['ignoreEmptyValue'] := ignoreEmpty;

  result['message'] := msg;
end;

class function TdxValidation.Email(const fieldName: string; const ignoreEmpty: boolean = true): TJSObject;
begin
  result := TJSObject.new;
  result['type'] := 'email';

  if not ignoreEmpty then
    result['ignoreEmptyValue'] := ignoreEmpty;

  result['message'] := 'Il campo ' + fieldName + ' non contiene un valore email valido.';
end;

class function TdxValidation.Numeric(const fieldName: string; const ignoreEmpty: boolean = true): TJSObject;
begin
  result := TJSObject.new;
  result['type'] := 'numeric';

  if not ignoreEmpty then
    result['ignoreEmptyValue'] := ignoreEmpty;

  result['message'] := 'Il campo ' + fieldName + ' non contiene un valore numerico.';
end;

class function TdxValidation.Required(const fieldName: string; const trimValue: boolean = true): TJSObject;
begin
  result := TJSObject.new;
  result['type'] := 'required';

  if not trimValue then
    result['trim'] := trimValue;

  result['message'] := fieldName + ' è un campo obbligatorio';
end;

class function TdxValidation.GetRules(options: TJSObject): TJSArray;
begin
  result := nil;

  if not options.hasOwnProperty('validationRules') then
    options['validationRules'] := TJSArray.new;

  if isArray(options['validationRules']) then
    result := TJSArray(options['validationRules']);
end;

class function TdxValidation.IsValid(j: JSValue): boolean;
var
  o: TJSObject;
begin
  result := false;

  if isObject(j) then
  begin
    o := TJSObject(j);

    if isBoolean(o['isValid']) then
      result := ToBoolean(o['isValid'])
  end;
end;

class function TdxValidation.ErrorMessage(j: JSValue): string;
var
  o: TJSObject;
  a: TJSArray;
  i: integer;
  rule: TJSObject;
begin
  result := '';

  if isObject(j) then
  begin
    o := TJSObject(j);

    if isArray(o['brokenRules']) then
    begin
      a := toarray(o['brokenRules']);

      for i := 0 to a.Length - 1 do
      begin
        rule := TJSObject(a[i]);
        result := result + Tostring(rule['message']) + sLineBreak;
      end;
    end;
  end;
end;

end.
