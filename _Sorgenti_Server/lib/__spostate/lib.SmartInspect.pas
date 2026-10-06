unit lib.SmartInspect;

interface

uses
  System.SysUtils,
  System.classes,
  System.UITypes;

type
  TLogger = record
    procedure EnterMethod(const AMethodName: UnicodeString); overload;
    procedure EnterMethod(const AInstance: TObject; const AMethodName: UnicodeString); overload;

    procedure LeaveMethod(const AMethodName: UnicodeString); overload;
    procedure LeaveMethod(AInstance: TObject; const AMethodName: UnicodeString); overload;

    procedure LogWarning(const ATitle: UnicodeString);
    procedure LogVerbose(const ATitle: UnicodeString);
    procedure LogException(const AException: Exception; const ATitle: UnicodeString = '');
    procedure LogColored(const AColor: TColor; const ATitle: UnicodeString);
    procedure LogSeparator;

    procedure LogString(const AName: UnicodeString; const AValue: String);
    procedure LogBoolean(const AName: UnicodeString; const AValue: Boolean);
    procedure LogInteger(const AName: UnicodeString; const AValue: Integer);
    procedure LogDateTime(const AName: UnicodeString; const AValue: TDateTime);
    procedure LogStringList(const ATitle: UnicodeString; const AStrings: TStrings);
    procedure LogObject(const ATitle: UnicodeString; const AInstance: TObject);
  end;

var
  SiMain: TLogger;

implementation

uses
{$IFNDEF LINUX}
  siAuto,
  SmartInspect,
{$ENDIF}
  lib.Folders;

procedure InitSmartInspect;
var
  FileName: string;
begin
{$IFNDEF LINUX}
  FileName := TFolders.GetFileName('.sic');

  if FileExists(FileName) then
    si.LoadConfiguration(FileName)
  else
    si.Enabled := True;
{$ENDIF}
end;

procedure TLogger.EnterMethod(const AMethodName: UnicodeString);
begin
{$IFNDEF LINUX}
  siAuto.SiMain.EnterMethod(AMethodName);
{$ENDIF}
end;

procedure TLogger.EnterMethod(const AInstance: TObject; const AMethodName: UnicodeString);
begin
{$IFNDEF LINUX}
  siAuto.SiMain.EnterMethod(AInstance, AMethodName);
{$ENDIF}
end;

procedure TLogger.LeaveMethod(const AMethodName: UnicodeString);
begin
{$IFNDEF LINUX}
  siAuto.SiMain.LeaveMethod(AMethodName);
{$ENDIF}
end;

procedure TLogger.LeaveMethod(AInstance: TObject; const AMethodName: UnicodeString);
begin
{$IFNDEF LINUX}
  siAuto.SiMain.LeaveMethod(AInstance, AMethodName);
{$ENDIF}
end;

procedure TLogger.LogWarning(const ATitle: UnicodeString);
begin
{$IFNDEF LINUX}
  siAuto.SiMain.LogWarning(ATitle);
{$ENDIF}
end;

procedure TLogger.LogVerbose(const ATitle: UnicodeString);
begin
{$IFNDEF LINUX}
  siAuto.SiMain.LogVerbose(ATitle);
{$ENDIF}
end;

procedure TLogger.LogException(const AException: Exception; const ATitle: UnicodeString = '');
begin
{$IFNDEF LINUX}
  siAuto.SiMain.LogException(AException, ATitle);
{$ENDIF}
end;

procedure TLogger.LogColored(const AColor: TColor; const ATitle: UnicodeString);
begin
{$IFNDEF LINUX}
  siAuto.SiMain.LogColored(AColor, ATitle);
{$ENDIF}
end;

procedure TLogger.LogSeparator;
begin
{$IFNDEF LINUX}
  siAuto.SiMain.LogSeparator;
{$ENDIF}
end;

procedure TLogger.LogString(const AName: UnicodeString; const AValue: String);
begin
{$IFNDEF LINUX}
  siAuto.SiMain.LogString(AName, AValue);
{$ENDIF}
end;

procedure TLogger.LogBoolean(const AName: UnicodeString; const AValue: Boolean);
begin
{$IFNDEF LINUX}
  siAuto.SiMain.LogBoolean(AName, AValue);
{$ENDIF}
end;

procedure TLogger.LogDateTime(const AName: UnicodeString; const AValue: TDateTime);
begin
{$IFNDEF LINUX}
  siAuto.SiMain.LogDateTime(AName, AValue);
{$ENDIF}
end;

procedure TLogger.LogInteger(const AName: UnicodeString; const AValue: Integer);
begin
{$IFNDEF LINUX}
  siAuto.SiMain.LogInteger(AName, AValue);
{$ENDIF}
end;

procedure TLogger.LogStringList(const ATitle: UnicodeString; const AStrings: TStrings);
begin
{$IFNDEF LINUX}
  siAuto.SiMain.LogStringList(ATitle, AStrings);
{$ENDIF}
end;

procedure TLogger.LogObject(const ATitle: UnicodeString; const AInstance: TObject);
begin
{$IFNDEF LINUX}
  siAuto.SiMain.LogObject(ATitle, AInstance);
{$ENDIF}
end;

initialization

InitSmartInspect;

end.
