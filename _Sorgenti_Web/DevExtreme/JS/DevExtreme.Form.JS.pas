unit DevExtreme.Form.JS;

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
  TdxForm = class external name 'dxForm' (TJSObject)
  public
    procedure beginUpdate();
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure focus();
    function getButton(name_: string): JSValue;
    function getEditor(dataField: string): JSValue;
    procedure itemOption(id: string; options: TJSObject); overload;
    procedure itemOption(id: string; option: string; value: JSValue); overload;
    function itemOption(id: string): JSValue; overload;
    function off(eventName: string): TJSElement; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    function option(optionName: string): JSValue; overload;
    procedure option(options: TJSObject); overload;
    function option(): TJSObject; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction);
    procedure repaint();
    procedure resetOption(optionName: string);
    procedure resetValues();
    procedure updateData(dataField: string; value: TJSObject); overload;
    procedure updateData(data: TJSObject); overload;
    function updateDimensions(): TJSPromise;
    function validate(): JSValue;
  end;

implementation


end.
