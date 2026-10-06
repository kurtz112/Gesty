unit DevExtreme.Map.JS;

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
  TdxMap = class external name 'dxMap' (TJSObject)
  public
    function addMarker(markerOptions: JSValue): TJSPromise;
    function addRoute(options: JSValue): TJSPromise;
    procedure beginUpdate();
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure focus();
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    function option(optionName: string): JSValue; overload;
    function option(): TJSObject; overload;
    procedure option(options: TJSObject); overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction);
    function removeMarker(marker: JSValue): TJSPromise;
    function removeRoute(route: JSValue): TJSPromise;
    procedure repaint();
    procedure resetOption(optionName: string);
  end;

implementation


end.
