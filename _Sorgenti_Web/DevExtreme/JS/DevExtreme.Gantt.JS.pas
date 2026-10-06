unit DevExtreme.Gantt.JS;

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
  TdxGantt = class external name 'dxGantt' (TJSObject)
  public
    procedure assignResourceToTask(resourceKey: TJSObject; taskKey: TJSObject);
    procedure beginUpdate();
    procedure collapseAll();
    procedure collapseTask(key: TJSObject);
    procedure ctor(options: JSValue); overload;
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    procedure deleteDependency(key: TJSObject);
    procedure deleteResource(key: TJSObject);
    procedure deleteTask(key: TJSObject);
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure expandAll();
    procedure expandAllToLevel(level: integer);
    procedure expandTask(key: TJSObject);
    procedure expandToTask(key: TJSObject);
    procedure focus();
    function getDependencyData(key: TJSObject): TJSObject;
    function getResourceAssignmentData(key: TJSObject): TJSObject;
    function getResourceData(key: TJSObject): TJSObject;
    function getTaskData(key: TJSObject): TJSObject;
    function getTaskResources(key: TJSObject): TJSArray;
    function getVisibleDependencyKeys(): TJSArray;
    function getVisibleResourceAssignmentKeys(): TJSArray;
    function getVisibleResourceKeys(): TJSArray;
    function getVisibleTaskKeys(): TJSArray;
    procedure insertDependency(data: TJSObject);
    procedure insertResource(data: TJSObject; taskKeys: TJSArray);
    procedure insertTask(data: TJSObject);
    function off(eventName: string): TJSElement; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function option(optionName: string): JSValue; overload;
    procedure option(options: TJSObject); overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    function option(): TJSObject; overload;
    function refresh(): TJSPromise;
    procedure registerKeyHandler(key: string; handler: TJSFunction);
    procedure repaint();
    procedure resetOption(optionName: string);
    procedure scrollToDate(date: JSValue);
    procedure showDependencies(value: boolean);
    procedure showResourceManagerDialog();
    procedure showResources(value: boolean);
    procedure showTaskDetailsDialog(taskKey: TJSObject);
    procedure unassignAllResourcesFromTask(taskKey: TJSObject);
    procedure unassignResourceFromTask(resourceKey: TJSObject; taskKey: TJSObject);
    procedure updateDimensions();
    procedure updateTask(key: TJSObject; data: TJSObject);
    procedure zoomIn();
    procedure zoomOut();
  end;

implementation


end.
