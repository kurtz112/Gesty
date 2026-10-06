unit DevExtreme.TreeView.JS;

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
  TdxTreeView = class external name 'dxTreeView' (TJSObject)
  public
    procedure beginUpdate();
    procedure collapseAll();
    function collapseItem(key: JSValue): TJSPromise; overload;
    function collapseItem(itemElement: TJSElement): TJSPromise; overload;
    procedure ctor(options: JSValue); overload;
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    function deleteItem(itemElement: TJSElement): TJSPromise;
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure expandAll();
    function expandItem(itemElement: TJSElement): TJSPromise; overload;
    function expandItem(itemData: JSValue): TJSPromise; overload;
    procedure focus();
    function getDataSource(): TJSObject;
    function getFocusedItemId(): string;
    function getNodes(): TJSArray;
    function getScrollable(): JSValue;
    function getSelectedNodeKeys(): TJSArray;
    function getSelectedNodes(): TJSArray;
    function isItemSelected(itemElement: TJSElement): boolean;
    function itemElements(): TJSArray;
    function itemsContainer(): TJSElement;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    procedure option(options: TJSObject); overload;
    function option(): TJSObject; overload;
    function option(optionName: string): JSValue; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction);
    function reorderItem(itemElement: TJSElement; toItemElement: TJSElement): TJSPromise;
    procedure repaint();
    procedure resetOption(optionName: string);
    function scrollToItem(itemData: JSValue): TJSPromise; overload;
    function scrollToItem(itemElement: TJSElement): TJSPromise; overload;
    procedure selectAll();
    function selectItem(itemElement: TJSElement): boolean; overload;
    function selectItem(key: JSValue): boolean; overload;
    procedure unselectAll();
    function unselectItem(itemElement: TJSElement): boolean; overload;
    function unselectItem(key: JSValue): boolean; overload;
    function updateDimensions(): TJSPromise;
  end;

implementation


end.
