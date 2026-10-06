unit eSignAnyWhere.utils;

interface

uses
  System.SysUtils,
  eSignAnyWhere.params;

function JsonFolder: string;

procedure __JSONLog(const params: TeSignAnyWhereParams; const obj, JSON: string);

implementation

uses
  System.IOUtils,
  Vcl.Forms;

function JsonFolder: string;
begin
  Result := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'eSignAnyWhere_Log');
end;

procedure __JSONLog(const params: TeSignAnyWhereParams; const obj, JSON: string);
var
  FileName: string;
begin

  if not params.LogResponse then
    exit;

  FileName := JsonFolder + params.Ident + '_' + obj + '.json';

  TFile.WriteAllText(FileName, JSON);
end;

end.
