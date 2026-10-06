unit DevExtreme.Scheduler.JS;

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
  TdxScheduler = class external name 'dxScheduler' (TJSObject)
  public
    procedure addAppointment(appointment: JSValue);
    procedure beginUpdate();
    procedure ctor(element: JSValue; options: JSValue); overload;
    procedure ctor(options: JSValue); overload;
    procedure defaultOptions(rule: TJSObject);
    procedure deleteAppointment(appointment: JSValue);
    procedure deleteRecurrence(appointmentData: JSValue; date: JSValue; recurrenceEditMode: JSValue);
    procedure dispose();
    function element(): TJSElement;
    procedure endUpdate();
    procedure focus();
    function getDataSource(): TJSObject;
    function getEndViewDate(): TJSDate;
    function getStartViewDate(): TJSDate;
    procedure hideAppointmentPopup(saveChanges: JSValue);
    procedure hideAppointmentTooltip();
    function off(eventName: string): TJSElement; overload;
    function off(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    function on(events: TJSObject): TJSElement; overload;
    function on(eventName: string; eventHandler: TJSFunction): TJSElement; overload;
    procedure option(options: TJSObject); overload;
    function option(optionName: string): JSValue; overload;
    procedure option(optionName: string; optionValue: JSValue); overload;
    function option(): TJSObject; overload;
    procedure registerKeyHandler(key: string; handler: TJSFunction); overload;
    procedure registerKeyHandler(); overload;
    procedure repaint();
    procedure resetOption(optionName: string);
    procedure scrollTo(date: TDateTime; group: JSValue; allDay: JSValue);
    procedure scrollToTime(hours: integer; minutes: integer; date: JSValue);
    procedure showAppointmentPopup(appointmentData: JSValue; createNewAppointment: JSValue; currentAppointmentData: JSValue);
    procedure showAppointmentTooltip(appointmentData: JSValue; target: JSValue; currentAppointmentData: JSValue);
    procedure updateAppointment(target: JSValue; appointment: JSValue);
  end;

implementation


end.
