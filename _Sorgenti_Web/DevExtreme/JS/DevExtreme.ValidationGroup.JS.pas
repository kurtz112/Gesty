unit DevExtreme.ValidationGroup.JS;

{$MODE objfpc}
{$MODESWITCH externalclass}

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
  TdxValidationGroup = class external name 'dxValidationGroup' (TJSObject)
  public
    procedure beginUpdate(); overload;
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(); overload;
    procedure defaultOptions(rule: TJSObject); overload;
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate(); overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function option(optionName: string): JSValue; overload;
    function option(): TJSObject; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    procedure option(options: TJSObject); overload;
    procedure reset();
    procedure resetOption(optionName: string);
    function validate(): JSValue;
  end;

implementation


end.
