unit DevExtreme.PolarChart.JS;

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
  TdxPolarChart = class external name 'dxPolarChart' (TJSObject)
  public
    procedure beginUpdate();
    procedure clearSelection();
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject); overload;
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure exportTo(fileName: string; format: string);
    function getAllSeries(): TJSArray;
    function getDataSource(): TJSObject;
    function getSeriesByName(seriesName: JSValue): JSValue;
    function getSeriesByPos(seriesIndex: integer): JSValue;
    function getSize(): JSValue;
    function getValueAxis(): JSValue;
    procedure hideLoadingIndicator();
    procedure hideTooltip();
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    procedure option(options: TJSObject); overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    function option(optionName: string): JSValue; overload;
    function option(): TJSObject; overload;
    procedure print();
    procedure refresh();
    procedure render(renderOptions: TJSObject); overload;
    procedure render(); overload;
    procedure resetOption(optionName: string);
    procedure resetVisualRange();
    procedure showLoadingIndicator();
    function svg(): string;
  end;

implementation


end.
