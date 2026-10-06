unit DevExtreme.NumberBox.JS;

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
  TdxNumberBox = class external name 'dxNumberBox' (TJSObject)
  public
    procedure beginUpdate();
    procedure blur();
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure focus(); overload;
    function getButton(name_: string): JSValue;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function option(): TJSObject; overload;
    function option(optionName: string): JSValue; overload;
    procedure option(options: TJSObject); overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction);
    procedure repaint();
    procedure reset(); overload;
    procedure resetOption(optionName: string);
  end;

implementation


end.
