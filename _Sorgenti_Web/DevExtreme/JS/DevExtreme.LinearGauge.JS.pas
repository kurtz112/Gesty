unit DevExtreme.LinearGauge.JS;

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
  TdxLinearGauge = class external name 'dxLinearGauge' (TJSObject)
  public
    procedure beginUpdate();
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject); overload;
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure exportTo(fileName: string; format: string);
    function getSize(): JSValue;
    procedure hideLoadingIndicator();
    function off(eventName: string): TJSElement; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    function option(optionName: string): JSValue; overload;
    procedure option(options: TJSObject); overload;
    function option(): TJSObject; overload;
    procedure print();
    procedure render();
    procedure resetOption(optionName: string);
    procedure showLoadingIndicator();
    procedure subvalues(subvalues: TJSArray); overload;
    function subvalues(): TJSArray; overload;
    function svg(): string;
    procedure value(value: integer); overload;
    function value(): integer; overload;
  end;

implementation


end.
