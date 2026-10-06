unit lib.DateISO;

interface

uses
  System.JSON;

type
  // ISO8601ToDate
  // TryISO8601ToDate
  // DateToISO8601

  TDateISO = record
  public
    class function DateTimeToString(Value: TDateTime): string; static;
    class function DateToString(Value: TDate): string; static;
    class function TimeToString(Value: TTime): string; static;

    class function DateTimeToJSON(Value: TDateTime): TJSONValue; static;
    class function DateToJSON(Value: TDate): TJSONValue; static;
    class function TimeToJSON(Value: TTime): TJSONValue; static;

    class function StringToDateTime(Value: string): TDateTime; static;
    class function StringToDate(Value: string): TDate; static;
    class function StringToTime(Value: string): TTime; static;
  end;

var
  DateISO: TDateISO;

implementation

uses
  System.SysUtils,
  System.DateUtils;

class function TDateISO.DateTimeToString(Value: TDateTime): string;
begin
  result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', Value); // lasciare tra doppi apici
  // result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss"Z"', Value); // lasciare tra doppi apici
end;

class function TDateISO.DateToString(Value: TDate): string;
begin
  result := FormatDateTime('yyyy-mm-dd', Value);
end;

class function TDateISO.TimeToString(Value: TTime): string;
begin
  result := FormatDateTime('hh:nn:ss', Value);
end;

// To JSON

class function TDateISO.DateTimeToJSON(Value: TDateTime): TJSONValue;
begin
  result := TJSONString.Create(DateTimeToString(Value));
end;

class function TDateISO.DateToJSON(Value: TDate): TJSONValue;
begin
  result := TJSONString.Create(DateToString(Value));
end;

class function TDateISO.TimeToJSON(Value: TTime): TJSONValue;
begin
  result := TJSONString.Create(TimeToString(Value));
end;

// String To

class function TDateISO.StringToDateTime(Value: string): TDateTime;
var
  FormatSettings: TFormatSettings;
  dateTime: TDateTime;
  t: TDateTime;
  d: TDateTime;
  idx: integer;
  timeStr: string;
  dateStr: string;
begin
  FormatSettings := TFormatSettings.Create;

  FormatSettings.DateSeparator := '-';
  FormatSettings.ShortDateFormat := 'yyyy-mm-dd';
  FormatSettings.TimeSeparator := ':';
  FormatSettings.ShortTimeFormat := 'hh:mm:ss';

  idx := Value.IndexOf('T');

  if idx = -1 then
  begin
    dateStr := Value.Substring(0, 10);
    timeStr := '';
  end
  else
  begin
    dateStr := Value.Substring(0, idx);
    timeStr := Value.Substring(idx + 1, 8);
  end;

  if not TryStrToDate(dateStr, d, FormatSettings) then
    raise Exception.Create('Formato data UTC non valido: ' + Value);

  t := 0;
  if not timeStr.isEmpty then
    if not TryStrToTime(timeStr, t, FormatSettings) then
      raise Exception.Create('Formato data UTC non valido: ' + Value);

  result := trunc(d) + frac(t);
end;

class function TDateISO.StringToDate(Value: string): TDate;
begin
  result := DateOf(StringToDateTime(Value));
end;

class function TDateISO.StringToTime(Value: string): TTime;
begin
  result := TimeOf(StringToDateTime(Value));
end;

end.
