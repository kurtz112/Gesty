unit DevExtreme.editors;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  WEBLib.db,
  WEBLib.JSON,
  WEBLib.REST,
  js,
  libjquery,
  web,
  DevExtreme.Types,
  DevExtreme;

function dxButtonOptions(const name: string; btnText: string; icon: string; btnType: TdxButtonType; btnStyle: TdxButtonStylingMode; onClick: TdxEventHandler): TJSObject;


implementation

uses
  System.StrUtils,
  // zz.web.http,
  zz.web.js,
  zz.web.user,
  zz.web.html,
  DevExtreme.data,
  DevExtreme.utils,
  DevExtreme.validation,
  DevExtreme.images;

function dxButtonOptions(const name: string; btnText: string; icon: string; btnType: TdxButtonType; btnStyle: TdxButtonStylingMode; onClick: TdxEventHandler): TJSObject;
var
  elementAttr: TJSObject;
begin
  Result := TJSObject.new;
  Result['name'] := name;
  Result['text'] := btnText;
  Result['icon'] := icon;
  Result['type'] := btnType.ToString; // 'default';
  Result['stylingMode'] := btnStyle.ToString; // 'filled';
  Result['onClick'] := onClick; // @Indietro;

  elementAttr := TJSObject.new; // utilizzato
  Result['elementAttr'] := elementAttr;
  // elementAttr['style'] := 'width:35%';
end;

end.
