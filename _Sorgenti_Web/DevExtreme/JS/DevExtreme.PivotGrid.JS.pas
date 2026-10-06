unit DevExtreme.PivotGrid.JS;

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
  TdxPivotGrid = class external name 'dxPivotGrid' (TJSObject)
  public
    procedure beginUpdate();
    function bindChart(chart: JSValue; integrationOptions: TJSObject): JSValue;
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure focus();
    function getDataSource(): JSValue;
    function getFieldChooserPopup(): JSValue;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    function option(): TJSObject; overload;
    function option(optionName: string): JSValue; overload;
    procedure option(options: TJSObject); overload;
    procedure registerKeyHandler(); overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); overload;
    procedure repaint();
    procedure resetOption(optionName: string);
    procedure updateDimensions();
  end;

implementation


end.
