unit DevExtreme.Accordion.JS;

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
  TdxAccordion = class external name 'dxAccordion' (TJSObject)
  public
    procedure beginUpdate();
    function collapseItem(index: integer): TJSPromise;
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    function deleteItem(itemElement: TJSElement): TJSPromise;
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    function expandItem(index: integer): TJSPromise;
    procedure focus();
    function getDataSource(): TJSObject;
    function getFocusedItemId(): string;
    function isItemSelected(itemElement: TJSElement): boolean;
    function itemElements(): TJSArray;
    function itemsContainer(): TJSElement;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function option(): TJSObject; overload;
    function option(optionName: string): JSValue; overload;
    procedure option(options: TJSObject); overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction);
    function reorderItem(itemElement: TJSElement; toItemElement: TJSElement): TJSPromise;
    procedure repaint();
    procedure resetOption(optionName: string);
    procedure selectItem(itemElement: TJSElement);
    procedure unselectItem(itemElement: TJSElement);
    function updateDimensions(): TJSPromise;
  end;

implementation


end.
