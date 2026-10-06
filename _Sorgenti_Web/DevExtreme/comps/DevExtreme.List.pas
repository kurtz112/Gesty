unit DevExtreme.List;

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
  DevExtreme.List.Custom,
  DevExtreme.Types;

type
  TjdxList = class(TjdxCustomList)
  end;

implementation


end.


class function TdxFactory.List(const id: string; options: TJSObject): TdxListJS; assembler;
asm
  return $(id).dxList(options).dxList("instance");
end;
