unit DevExtreme.FileUploader.JS;

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
  TdxFileUploader = class external name 'dxFileUploader' (TJSObject)
  public
    procedure abortUpload(file_: JSValue); overload;
    procedure abortUpload(); overload;
    procedure abortUpload(fileIndex: integer); overload;
    procedure beginUpdate();
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure focus();
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function off(eventName: string): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function option(optionName: string): JSValue; overload;
    function option(): TJSObject; overload;
    procedure option(options: TJSObject); overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction);
    procedure removeFile(file_: JSValue); overload;
    procedure removeFile(fileIndex: integer); overload;
    procedure repaint();
    procedure reset();
    procedure resetOption(optionName: string);
    procedure upload(fileIndex: integer); overload;
    procedure upload(file_: JSValue); overload;
    procedure upload(); overload;
  end;

implementation


end.
