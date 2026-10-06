unit DevExtreme.Gallery.JS;

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
  TdxGallery = class external name 'dxGallery' (TJSObject)
  public
    procedure beginUpdate();
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    function deleteItem(itemElement: TJSElement): TJSPromise;
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure focus();
    function getDataSource(): TJSObject;
    function getFocusedItemId(): string;
    function goToItem(itemIndex: integer; animation: boolean): TJSPromise;
    function isItemSelected(itemElement: TJSElement): boolean;
    function itemElements(): TJSArray;
    function itemsContainer(): TJSElement;
    function nextItem(animation: boolean): TJSPromise;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function option(optionName: string): JSValue; overload;
    function option(): TJSObject; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    procedure option(options: TJSObject); overload;
    function prevItem(animation: boolean): TJSPromise;
    procedure registerKeyHandler(key: string; handler: TJSFunction);
    function reorderItem(itemElement: TJSElement; toItemElement: TJSElement): TJSPromise;
    procedure repaint();
    procedure resetOption(optionName: string);
    procedure selectItem(itemElement: TJSElement);
    procedure unselectItem(itemElement: TJSElement);
  end;

implementation


end.
