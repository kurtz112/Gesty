unit DevExtreme.Diagram.JS;

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
  TdxDiagram = class external name 'dxDiagram' (TJSObject)
  public
    procedure beginUpdate();
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    function export(): string;
    procedure exportTo(format: JSValue; callback: TJSFunction);
    procedure fitToContent();
    procedure fitToWidth();
    procedure focus();
    function getEdgeDataSource(): TJSObject;
    function getItemById(id: string): JSValue;
    function getItemByKey(key: TJSObject): JSValue;
    function getItems(): TJSArray;
    function getNodeDataSource(): TJSObject;
    function getSelectedItems(): TJSArray;
    procedure import(data: string; updateExistingItemsOnly: boolean);
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function option(optionName: string): JSValue; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    procedure option(options: TJSObject); overload;
    function option(): TJSObject; overload;
    procedure registerKeyHandler(); overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); overload;
    procedure repaint();
    procedure resetOption(optionName: string);
    procedure scrollToItem(item: JSValue);
    procedure setSelectedItems(items: TJSArray);
    procedure updateToolbox();
  end;

implementation


end.
