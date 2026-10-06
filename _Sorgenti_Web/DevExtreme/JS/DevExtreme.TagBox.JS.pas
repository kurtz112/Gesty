unit DevExtreme.TagBox.JS;

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
  TdxTagBox = class external name 'dxTagBox' (TJSObject)
  public
    procedure beginUpdate();
    procedure blur();
    procedure close();
    function content(): TJSElement;
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    function field(): TJSElement;
    procedure focus(); overload;
    function getButton(name_: string): JSValue;
    function getDataSource(): TJSObject;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    procedure open();
    procedure option(optionName: string; optionValue: JSValue); overload;
    function option(): TJSObject; overload;
    function option(optionName: string): JSValue; overload;
    procedure option(options: TJSObject); overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction);
    procedure repaint();
    procedure reset();
    procedure resetOption(optionName: string);
  end;

implementation


end.
