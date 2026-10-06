unit DevExtreme.TreeMap.JS;

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
  TdxTreeMap = class external name 'dxTreeMap' (TJSObject)
  public
    procedure beginUpdate();
    procedure clearSelection();
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject); overload;
    procedure dispose();
    procedure drillUp();
    function element(): TJSElement;
    procedure endUpdate();
    procedure exportTo(fileName: string; format: string);
    function getCurrentNode(): JSValue;
    function getDataSource(): TJSObject;
    function getRootNode(): JSValue;
    function getSize(): JSValue;
    procedure hideLoadingIndicator();
    procedure hideTooltip();
    function off(eventName: string): TJSElement; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    procedure option(options: TJSObject); overload;
    function option(): TJSObject; overload;
    function option(optionName: string): JSValue; overload;
    procedure print();
    procedure render();
    procedure resetDrillDown();
    procedure resetOption(optionName: string);
    procedure showLoadingIndicator();
    function svg(): string;
  end;

implementation


end.
