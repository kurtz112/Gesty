unit DevExtreme.FileManager.JS;

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
  TdxFileManager = class external name 'dxFileManager' (TJSObject)
  public
    procedure beginUpdate();
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure focus();
    function getCurrentDirectory(): TJSObject;
    function getSelectedItems(): TJSArray;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function option(): TJSObject; overload;
    function option(optionName: string): JSValue; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    procedure option(options: TJSObject); overload;
    function refresh(): TJSPromise;
    procedure registerKeyHandler(key: string; handler: TJSFunction);
    procedure repaint();
    procedure resetOption(optionName: string);
  end;

implementation


end.
