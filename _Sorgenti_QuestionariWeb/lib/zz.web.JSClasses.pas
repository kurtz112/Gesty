{$MODE objfpc}
{$MODESWITCH externalclass}
unit zz.web.JSClasses;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  WEBLib.Forms,
  JS,
  web,
  libjquery;

type
  TDeferred = class
    external name 'jQuery.Deferred'(TJSObject)public

    function promise(): TJSPromise;
    procedure resolve(value: JSValue);
    procedure resolve(value: JSValue; aJQXHR: TJQXHR);
    procedure reject(value: JSValue);
  end;

  TResizeObserver = class
    external name 'ResizeObserver'(TJSObject)public constructor new(proc: TProc);
    procedure observe(e: TJSElement);
    procedure unobserve(e: TJSElement);
    procedure disconnect;
  end;

function deferred(): TDeferred; assembler;

implementation

function deferred(): TDeferred; assembler;
asm
 return new $.Deferred();
end;

end.
