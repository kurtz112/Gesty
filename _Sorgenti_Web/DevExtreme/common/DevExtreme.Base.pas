unit DevExtreme.Base;

interface

uses
  System.SysUtils,
  System.Classes,
  Types,
  JS,
  web,
  DevExtreme.Types;

type
  // TdxCallback = reference to procedure;
  // TdxCallback<T> = reference to procedure(Arg1: T);
  // TdxCallback<T1, T2> = reference to procedure(Arg1: T1; Arg2: T2);
  // TdxCallback<T1, T2, T3> = reference to procedure(Arg1: T1; Arg2: T2; Arg3: T3);
  // TdxCallback<T1, T2, T3, T4> = reference to procedure(Arg1: T1; Arg2: T2; Arg3: T3; Arg4: T4);

  IdxBaseInterface = interface
    ['{40F1232A-C4F3-4AFA-8F7D-2928BE53260B}']
  public
    [async]
    function fields(const dm, name: string): TJSPromise; overload;
  public
    function byKey(const dm, name, Pk: string; KeyValues: JSValue; params: TJSObject): TJSPromise;
    function select(const dm, name: string; params: TJSObject; loadOptions: TJSObject = nil): TJSPromise;
    function insert(const dm, name: string; values: TJSObject): TJSPromise;
    function update(const dm, name: string; values: TJSObject): TJSPromise;
    function delete(const dm, name, Pk: string; KeyValues: JSValue): TJSPromise;
    function count(const dm, name: string; params: TJSObject; loadOptions: TJSObject = nil): TJSPromise;
    function sp(const dm, name: string; params: TJSObject; loadOptions: TJSObject = nil): TJSPromise;
  public
    [async]
    function DownloadOptions(const dm, name, className: string): TJSPromise; overload;
    function UploadOptions(const dm, name, className: string; Options: TJSObject): boolean;
  public
    function Onnipotente: boolean;
    procedure Inspect(title: string; obj: TJSObject; OkProc: TdxOkCancelProc; CancelProc: TdxOkCancelProc = nil);
    procedure EditOptions(Options: TJSObject; OkProc: TdxEventHandlerFunc; CancelProc: TProc = nil);
    procedure EditJSObject(const title: string; Options: TJSObject; ReturnProc: TEditOptionsReturnProc);
    [async]
    procedure EditSQL(const dm, dataset: string; callback: TProc);
  end;

var
  Base: IdxBaseInterface = nil;

implementation

end.
