unit zz.web.types;

interface

uses
  System.SysUtils,
  System.Classes,
  Types,
  js,
  web;

type
  TEventHandler = reference to function(e: TJSObject): JSValue;

  TFunc<TResult> = reference to function: TResult;

  TCallbackProc = reference to Procedure(callback: TProc);

implementation

end.
