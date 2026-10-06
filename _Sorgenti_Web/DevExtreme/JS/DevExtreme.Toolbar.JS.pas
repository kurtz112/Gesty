unit DevExtreme.Toolbar.JS;

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
  TdxToolbar = class external name 'dxToolbar' (TJSObject)
  public
    procedure beginUpdate();
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    function deleteItem(itemElement: TJSElement): TJSPromise;
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure focus(); overload;
    function getDataSource(): TJSObject;
    function getFocusedItemId(): string;
    function isItemSelected(itemElement: TJSElement): boolean;
    function itemElements(): TJSArray;
    function itemsContainer(): TJSElement;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function option(optionName: string): JSValue; overload;
    function option(): TJSObject; overload;
    procedure option(options: TJSObject); overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    procedure registerKeyHandler(); overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); overload;
    function reorderItem(itemElement: TJSElement; toItemElement: TJSElement): TJSPromise;
    procedure repaint();
    procedure resetOption(optionName: string);
    procedure selectItem(itemElement: TJSElement);
    procedure unselectItem(itemElement: TJSElement);
  end;

implementation


end.
