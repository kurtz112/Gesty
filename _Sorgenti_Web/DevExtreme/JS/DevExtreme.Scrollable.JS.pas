unit DevExtreme.Scrollable.JS;

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
  TdxScrollable = class external name 'dxScrollable' (TJSObject)
  public
    procedure beginUpdate();
    function clientHeight(): integer;
    function clientWidth(): integer;
    function content(): TJSElement;
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    function off(eventName: string): TJSElement; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function option(optionName: string): JSValue; overload;
    function option(): TJSObject; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    procedure option(options: TJSObject); overload;
    procedure resetOption(optionName: string);
    procedure scrollBy(distance: JSValue);
    function scrollHeight(): integer;
    function scrollLeft(): integer;
    function scrollOffset(): TJSObject;
    procedure scrollTo(targetLocation: JSValue);
    procedure scrollToElement(element: JSValue);
    function scrollTop(): integer;
    function scrollWidth(): integer;
    function update(): TJSPromise;
  end;

implementation


end.
