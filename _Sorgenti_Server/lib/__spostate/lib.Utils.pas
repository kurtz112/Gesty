unit lib.Utils;

interface

uses
  System.Classes,
  System.SysUtils,
  Web.HTTPApp;

function StartingWith(const s: string; const SubStr: string): Boolean;

function RemoveStrings(const s: string; Strings2Remove: array of string): string;

implementation

uses
  zz.Folders;

function RemoveStrings(const s: string; Strings2Remove: array of string): string;
var
  tmp: string;
begin
  Result := s;
  for tmp in Strings2Remove do
    Result := StringReplace(Result, tmp, '', [rfReplaceAll, rfIgnoreCase]);
end;

function StartingWith(const s: string; const SubStr: string): Boolean;
var
  Token: string;
begin
  Token := System.copy(s, 0, length(SubStr));
  Result := SameText(SubStr, Token);
end;

end.
