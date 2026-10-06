unit DevExtreme.Overlay.JS;

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
  TdxOverlay = class external name 'dxOverlay' (TJSObject)
  public
    procedure beginUpdate();
    function content(): TJSElement;
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure focus();
    function hide(): TJSPromise;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    function option(optionName: string): JSValue; overload;
    function option(): TJSObject; overload;
    procedure option(options: TJSObject); overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction);
    procedure repaint(); overload;
    procedure resetOption(optionName: string);
    function show(): TJSPromise;
    function toggle(showing: boolean): TJSPromise;
  end;

implementation


end.
