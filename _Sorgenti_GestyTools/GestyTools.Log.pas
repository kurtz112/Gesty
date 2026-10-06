unit GestyTools.Log;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TLog = record
  private
    class function FormatMessageLog(const msg: string): string; static;
    class function FileName: String; static;
  public
    class procedure ToFile(const msg: string); static;
    class procedure ToScreen(const msg: string); static;
  end;

var
  Log: TLog;

  __WriteLog: TProc<string> = nil;

implementation

uses
  System.IOUtils,
  Vcl.Forms;

class function TLog.FileName: String;
begin
  result := ChangeFileExt(Application.ExeName, '.log');
end;

class procedure TLog.ToFile(const msg: string);
begin
  TFile.AppendAllText(TLog.FileName, TLog.FormatMessageLog(msg));
end;

class procedure TLog.ToScreen(const msg: string);
begin
  if assigned(__WriteLog) then
    __WriteLog(TLog.FormatMessageLog(msg));
end;

class function TLog.FormatMessageLog(const msg: string): string;
begin
  result := FormatDateTime('yyyymmdd hh nn - ', now) + ' - ' + msg;
end;

end.
