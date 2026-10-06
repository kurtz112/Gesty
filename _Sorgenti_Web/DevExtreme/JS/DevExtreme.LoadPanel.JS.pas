unit DevExtreme.LoadPanel.JS;

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
  TdxLoadPanel = class external name 'dxLoadPanel' (TJSObject)
  public
    procedure beginUpdate();
    function content(): TJSElement;
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure focus(); overload;
    function hide(): TJSPromise;
    function off(eventName: string): TJSElement; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function option(): TJSObject; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    procedure option(options: TJSObject); overload;
    function option(optionName: string): JSValue; overload;
    procedure registerKeyHandler(); overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); overload;
    procedure repaint(); overload;
    procedure resetOption(optionName: string);
    procedure show(); overload;
    procedure toggle(); overload;
    function toggle(showing: boolean): TJSPromise; overload;
  end;

implementation


end.
