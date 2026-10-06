unit DevExtreme.Toolbar;

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
  DevExtreme.Toolbar.Custom,
  DevExtreme.Toolbar.JS,
  DevExtreme.Types;

type
  TjdxToolbar = class(TjdxCustomToolbar)
  end;

  TdxToolbarHelper = class helper for TdxToolbar
  public

//    result := TJSObject.new;
//    result['location'] := 'before';
//    result['locateInMenu'] := 'never';
//    result['widget'] := 'dxDateBox';
//    result['options'] := Options;

    class function Separator: TJSObject; static;
  end;

implementation

{ TdxToolbarHelper }

class function TdxToolbarHelper.Separator: TJSObject;
begin
  result := TJSObject.new;
  result['locateInMenu'] := 'auto';
  result['location'] := 'before';
  result['template'] := function(Data: TJSObject; index: integer; element: TJSElement): JSValue
    var
      jq: TJQuery;
    begin
      asm
        $('<div>')
        // .addClass('toolbar-separator')
        .appendTo(element);
      end;
    end;

  result['menuItemTemplate'] := function(Data: TJSObject; index: integer; element: TJSElement): JSValue
    begin
      asm $('<div>')
        // .addClass('toolbar-menu-separator')
        .appendTo(element);
      end;
    end;
end;

end.
