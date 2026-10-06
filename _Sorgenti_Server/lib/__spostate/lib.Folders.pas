unit lib.Folders;

interface

type
  TFolders = class
  private
    class var _WorkingFolder: string;
    class function SecFileName: string; static;
  public
    class function ModuleName: string;
    class function ModuleFolder: string;
    class function WorkingFolder: string;
    class function WorkingSubFolder(const SubFolder: string): string;

    class function SubFolder(const Root, SubFolder: string): string;
    //
    class function GetFileName(const Ext: string): string;
    class function IniFileName: string;
    class function LogFileName: string;
  end;

implementation

uses
  Winapi.Windows,
  System.SysUtils,
  System.StrUtils;

{ TFolders }

class function TFolders.ModuleName: string;
var
  szFileName: array [0 .. MAX_PATH] of char;
begin
  FillChar(szFileName, SizeOf(szFileName), #0);
  GetModuleFileName(hInstance, szFileName, MAX_PATH);
  Result := szFileName;
end;

class function TFolders.ModuleFolder: string;
begin
  Result := IncludeTrailingPathDelimiter(ExtractFilePath(ModuleName));
end;

class function TFolders.WorkingSubFolder(const SubFolder: string): string;
begin
  Result := IncludeTrailingPathDelimiter(WorkingFolder + SubFolder)
end;

class function TFolders.WorkingFolder: string;
begin
  if _WorkingFolder = '' then
  begin

    if (not ModuleIsLib) And (ParamCount >= 1) and (not StartsText('/', ParamStr(1))) then
      _WorkingFolder := IncludeTrailingPathDelimiter(Trim(ParamStr(1)))
    else
      _WorkingFolder := ModuleFolder;
  end;

  Result := _WorkingFolder;
end;

class function TFolders.GetFileName(const Ext: string): string;
begin
  Result := WorkingFolder + ExtractFileName(ChangeFileExt(ModuleName, Ext));
end;

class function TFolders.IniFileName: string;
begin
  Result := GetFileName('.ini');
end;

class function TFolders.LogFileName: string;
begin
  Result := GetFileName('.log');
end;

class function TFolders.SecFileName: string;
begin
  Result := WorkingFolder + ExtractFileName(ChangeFileExt(ModuleName, '.zSec'));
end;

class function TFolders.SubFolder(const Root, SubFolder: string): string;
begin
  Result := IncludeTrailingPathDelimiter(Root) + IncludeTrailingPathDelimiter(SubFolder);
end;

end.
