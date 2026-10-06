unit DevExtreme.Sankey.JS;

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
  TdxSankey = class external name 'dxSankey' (TJSObject)
  public
    procedure beginUpdate();
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject); overload;
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure exportTo(fileName: string; format: string);
    function getAllLinks(): TJSArray;
    function getAllNodes(): TJSArray;
    function getDataSource(): TJSObject;
    function getSize(): JSValue;
    procedure hideLoadingIndicator();
    procedure hideTooltip();
    function off(eventName: string): TJSElement; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function option(optionName: string): JSValue; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    function option(): TJSObject; overload;
    procedure option(options: TJSObject); overload;
    procedure print();
    procedure render();
    procedure resetOption(optionName: string);
    procedure showLoadingIndicator();
    function svg(): string;
  end;

implementation


end.
