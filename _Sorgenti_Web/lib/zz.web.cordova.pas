unit zz.web.cordova;

interface

procedure InitCordova;

function IsCordova: boolean;

implementation

uses
  js,
  web,
  DevExtreme.Utils;

function onBackKeyDown(Event: TEventListenerEvent): boolean;
begin
  Event.preventDefault();

  TdxUtils.confirm('Termine applicazione', 'Si desidera terminare l''applicazione?',
    procedure
    begin
      asm
       navigator.app.exitApp();
      end;
    end, nil);
end;

function onDeviceReady(Event: TEventListenerEvent): boolean;
begin
  document.addEventListener('backbutton', @onBackKeyDown);
end;

procedure InitCordova;
begin

  if not IsCordova then
    Exit;

  document.addEventListener('deviceready', @onDeviceReady);
end;

function IsCordova: boolean;
begin
  Result := window.hasOwnProperty('cordova');
end;

end.
