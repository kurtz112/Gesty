unit DevExtreme.VectorMap.JS;

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
  TdxVectorMap = class external name 'dxVectorMap' (TJSObject)
  public
    procedure beginUpdate();
    procedure center(centerCoordinates: TJSArray); overload;
    function center(): TJSArray; overload;
    procedure clearSelection();
    function convertCoordinates(x: integer; y: integer): TJSArray;
    function convertToGeo(x: integer; y: integer): TJSArray;
    function convertToXY(longitude: integer; latitude: integer): TJSArray;
    procedure ctor(options: JSValue); overload;
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject); overload;
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure exportTo(fileName: string; format: string);
    function getLayerByIndex(index: integer): JSValue;
    function getLayerByName(name_: string): JSValue;
    function getLayers(): TJSArray;
    function getSize(): JSValue;
    procedure hideLoadingIndicator();
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function option(optionName: string): JSValue; overload;
    function option(): TJSObject; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    procedure option(options: TJSObject); overload;
    procedure print();
    procedure render();
    procedure resetOption(optionName: string);
    procedure showLoadingIndicator();
    function svg(): string;
    procedure viewport(viewportCoordinates: TJSArray); overload;
    function viewport(): TJSArray; overload;
    procedure zoomFactor(zoomFactor: integer); overload;
    function zoomFactor(): integer; overload;
  end;

implementation


end.
