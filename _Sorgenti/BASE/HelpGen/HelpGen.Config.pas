unit HelpGen.Config;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TzHelpConfig = record
  private
    FTemplateFileName: string;
    FHelpFolder: string;
    FHelpGenWorkingFolder: string;
    FTemplateFolder: string;
    procedure SetHelpFolder(const Value: string);
    procedure SetHelpGenWorkingFolder(const Value: string);
    procedure SetTemplateFolder(const Value: string);
  public
    property HelpFolder: string read FHelpFolder write SetHelpFolder;
    property HelpGenWorkingFolder: string read FHelpGenWorkingFolder write SetHelpGenWorkingFolder;
    property TemplateFolder: string read FTemplateFolder write SetTemplateFolder;
    property TemplateFileName: string read FTemplateFileName write FTemplateFileName;
  end;

var
  zHelpConfig: TzHelpConfig;

implementation

procedure TzHelpConfig.SetHelpFolder(const Value: string);
begin
  FHelpFolder := IncludeTrailingPathDelimiter(Value);
end;

procedure TzHelpConfig.SetHelpGenWorkingFolder(const Value: string);
begin
  FHelpGenWorkingFolder := IncludeTrailingPathDelimiter(Value);
end;

procedure TzHelpConfig.SetTemplateFolder(const Value: string);
begin
  FTemplateFolder := IncludeTrailingPathDelimiter(Value);
end;

end.
