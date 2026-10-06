unit zz.web.helper;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  JS,
  web,
  libjquery;

type
  TJSObjectHelper = class helper for TJSObject
  public
    function owns(const propertyName: String): boolean;
    function has(const propertyName: String): boolean;
    function isNumber(const propertyName: string): boolean;
    function isString(const propertyName: string): boolean;
    function isBoolean(const propertyName: string): boolean;
    function isInteger(const propertyName: string): boolean;
    function isObject(const propertyName: string): boolean;
    function isArray(const propertyName: string): boolean;

    function toNumber(const propertyName: string): Double;
    function toString(const propertyName: string): string;
    function toBoolean(const propertyName: string): boolean; // If Value is not a Boolean, returns False
    function toInteger(const propertyName: string): NativeInt; // if v is not an integer, returns 0
    function toObject(const propertyName: string): TJSObject; // If Value is not a Javascript object, returns Nil
    function toArray(const propertyName: string): TJSArray; // If Value is not a Javascript array, returns Nil
  end;

  // TJSArray

implementation

function TJSObjectHelper.has(const propertyName: String): boolean;
begin
  result := owns(propertyName);
end;

function TJSObjectHelper.owns(const propertyName: String): boolean;
begin
  result := hasOwnProperty(propertyName);
end;

function TJSObjectHelper.isArray(const propertyName: string): boolean;
begin
  result := JS.isArray(self[propertyName]);
end;

function TJSObjectHelper.isBoolean(const propertyName: string): boolean;
begin
  result := JS.isBoolean(self[propertyName]);
end;

function TJSObjectHelper.isInteger(const propertyName: string): boolean;
begin
  result := JS.isInteger(self[propertyName]);
end;

function TJSObjectHelper.isNumber(const propertyName: string): boolean;
begin
  result := JS.isNumber(self[propertyName]);
end;

function TJSObjectHelper.isObject(const propertyName: string): boolean;
begin
  result := JS.isObject(self[propertyName]);
end;

function TJSObjectHelper.isString(const propertyName: string): boolean;
begin
  result := JS.isString(self[propertyName]);
end;

function TJSObjectHelper.toArray(const propertyName: string): TJSArray;
begin
  result := JS.toArray(self[propertyName]);
end;

function TJSObjectHelper.toBoolean(const propertyName: string): boolean;
begin
  result := JS.toBoolean(self[propertyName]);
end;

function TJSObjectHelper.toInteger(const propertyName: string): NativeInt;
begin
  result := JS.toInteger(self[propertyName]);
end;

function TJSObjectHelper.toNumber(const propertyName: string): Double;
begin
  result := JS.toNumber(self[propertyName]);
end;

function TJSObjectHelper.toObject(const propertyName: string): TJSObject;
begin
  result := JS.toObject(self[propertyName]);
end;

function TJSObjectHelper.toString(const propertyName: string): string;
begin
  result := JS.toString(self[propertyName]);
end;

end.
