unit DevExtreme.themes;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Types,
  WEBLib.JSON,
  WEBLib.forms,
  js,
  web;

type

  TdxThemes = record
  public
    //
    class procedure Current(const themeName: string); overload; static; assembler;
    class function Current: string; overload; static; assembler;
    class function themes: TJSArray; static;
    class function dark: boolean; static;

    class function ColorScheme: TApplicationColorScheme; static;

    class procedure SetThemeLight; static;
    class procedure SetThemeDark; static;
    class procedure ToggleDarkLight; static;
  end;

implementation

uses
  libjquery;

{ TdxThemes }

class procedure TdxThemes.Current(const themeName: string);
asm
  DevExpress.ui.themes.current(themeName);
end;

class function TdxThemes.Current: string;
asm
  return   DevExpress.ui.themes.current();
end;

class function TdxThemes.dark: boolean;
begin
  result := Current.Contains('dark'); // 'material.gesty.dark';
end;

class function TdxThemes.themes: TJSArray;
  function add(desc, tema: string): TJSObject;
  begin
    result := TJSObject.new;
    result['id'] := tema;
    result['text'] := desc;
  end;

begin
  result := TJSArray.new;
  // result.push(add('Gesty (chiaro)', 'material.gesty'));
  // result.push(add('Gesty (scuro)', 'material.gesty.dark'));
  // result.push(add('Tema Chiaro', 'generic.light.compact'));
  // result.push(add('Tema Scuro', 'generic.dark.compact'));
  // result.push(add('Carmine', 'generic.carmine.compact'));
  // result.push(add('Soft Nlue', 'generic.softblue.compact'));
  // result.push(add('Dark Moon', 'generic.darkmoon.compact'));
  // result.push(add('Dark Violet', 'generic.darkviolet.compact'));
  // result.push(add('Freen Mist', 'generic.greenmist.compact'));
  // result.push(add('Contrasto', 'generic.contrast.compact'));

  result.push(add('Blue (chiaro)', 'material.blue.light.compact'));
  result.push(add('Blue (scuro)', 'material.blue.dark.compact'));
  result.push(add('Lime (chiaro)', 'material.lime.light.compact'));
  result.push(add('Lime (scuro)', 'material.lime.dark.compact'));
  result.push(add('Orange (chiaro)', 'material.orange.light.compact'));
  result.push(add('Orange (scuro)', 'material.orange.dark.compact'));
  result.push(add('Purple (chiaro)', 'material.purple.light.compact'));
  result.push(add('Purple (scuro)', 'material.purple.dark.compact'));
  result.push(add('Teal (chiaro)', 'material.teal.light.compact'));
  result.push(add('Teal (scuro)', 'material.teal.dark.compact'));
end;

class function TdxThemes.ColorScheme: TApplicationColorScheme;
begin
  result := csLight; // csNoScheme;

  if dark then
    result := csDark
  else
    result := csLight;
end;

class procedure TdxThemes.ToggleDarkLight;
begin

  if TdxThemes.dark then
    TdxThemes.SetThemeLight
  else
    TdxThemes.SetThemeDark;
end;

class procedure TdxThemes.SetThemeDark;
begin
  TdxThemes.Current('generic.dark');
end;

class procedure TdxThemes.SetThemeLight;
begin
  TdxThemes.Current('generic.light');
end;

end.
