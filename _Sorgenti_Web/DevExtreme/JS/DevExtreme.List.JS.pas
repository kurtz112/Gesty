unit DevExtreme.List.JS;

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
  TdxList = class external name 'dxList' (TJSObject)
  public
    procedure beginUpdate();
    function clientHeight(): integer;
    function collapseGroup(groupIndex: integer): TJSPromise;
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    function deleteItem(itemIndex: JSValue): TJSPromise; overload;
    function deleteItem(itemElement: TJSElement): TJSPromise; overload;
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    function expandGroup(groupIndex: integer): TJSPromise;
    procedure focus();
    function getDataSource(): TJSObject;
    function getFlatIndexByItemElement(itemElement: TJSElement): TJSObject;
    function getFocusedItemId(): string;
    function getItemByIndex(index: integer): TJSObject;
    function getItemElementByFlatIndex(flatIndex: integer): TJSElement;
    function isItemSelected(itemIndex: JSValue): boolean; overload;
    function isItemSelected(itemElement: TJSElement): boolean; overload;
    function itemElements(): TJSArray;
    function itemsContainer(): TJSElement;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    function option(optionName: string): JSValue; overload;
    function option(): TJSObject; overload;
    procedure option(options: TJSObject); overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction);
    procedure reload();
    function reorderItem(itemElement: TJSElement; toItemElement: TJSElement): TJSPromise; overload;
    function reorderItem(itemIndex: JSValue; toItemIndex: JSValue): TJSPromise; overload;
    procedure repaint();
    procedure resetOption(optionName: string);
    procedure scrollBy(distance: integer);
    function scrollHeight(): integer;
    procedure scrollTo(location: integer);
    procedure scrollToItem(itemElement: TJSElement); overload;
    procedure scrollToItem(itemIndex: JSValue); overload;
    function scrollTop(): integer;
    procedure selectAll();
    procedure selectItem(itemIndex: JSValue); overload;
    procedure selectItem(itemElement: TJSElement); overload;
    procedure unselectAll();
    procedure unselectItem(itemIndex: JSValue); overload;
    procedure unselectItem(itemElement: TJSElement); overload;
    function updateDimensions(): TJSPromise;
  end;

implementation


end.
