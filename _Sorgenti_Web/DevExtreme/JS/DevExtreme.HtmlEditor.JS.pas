unit DevExtreme.HtmlEditor.JS;

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
  TdxHtmlEditor = class external name 'dxHtmlEditor' (TJSObject)
  public
    procedure beginUpdate();
    procedure blur();
    procedure clearHistory();
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    procedure delete(index: integer; length: integer);
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure focus(); overload;
    procedure format(formatName: JSValue; formatValue: JSValue);
    procedure formatLine(index: integer; length: integer; formats: TJSObject); overload;
    procedure formatLine(index: integer; length: integer; formatName: JSValue; formatValue: JSValue); overload;
    procedure formatText(index: integer; length: integer; formats: TJSObject); overload;
    procedure formatText(index: integer; length: integer; formatName: JSValue; formatValue: JSValue); overload;
    function get(componentPath: string): TJSObject;
    function getBounds(index: integer; length: integer): TJSObject;
    function getFormat(): TJSObject; overload;
    function getFormat(index: integer; length: integer): TJSObject; overload;
    function getLength(): integer;
    function getModule(moduleName: string): TJSObject;
    function getQuillInstance(): TJSObject;
    function getSelection(focus: JSValue): TJSObject;
    function getText(index: integer; length: integer): string;
    procedure insertEmbed(index: integer; type_: string; config: JSValue);
    procedure insertText(index: integer; text: string; formats: TJSObject); overload;
    procedure insertText(index: integer; text: string; formatName: JSValue; formatValue: JSValue); overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function option(optionName: string): JSValue; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    procedure option(options: TJSObject); overload;
    function option(): TJSObject; overload;
    procedure redo();
    procedure register(modules: TJSObject);
    procedure registerKeyHandler(key: string; handler: TJSFunction);
    procedure removeFormat(index: integer; length: integer);
    procedure repaint();
    procedure reset();
    procedure resetOption(optionName: string);
    procedure setSelection(index: integer; length: integer);
    procedure undo();
  end;

implementation


end.
