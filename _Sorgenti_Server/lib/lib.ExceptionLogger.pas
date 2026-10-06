unit lib.ExceptionLogger;

interface

uses
  System.SysUtils,
  System.Classes,
  Web.HTTPApp;

procedure SaveExceptionLog(E: Exception; Request: TWebRequest);

implementation

uses
  zz.Folders;

procedure SaveExceptionLog(E: Exception; Request: TWebRequest);
var
  LogDir: string;
  LogFileName: string;
  LogPath: string;
  LogContent: TStringList;
  Index: Integer;
begin
  if not Assigned(E) then
    Exit;

  try
    LogDir := TFolders.ModuleFolder + 'log';
    ForceDirectories(LogDir);
    
    // Generate base filename
    LogFileName := 'GestyServer_' + FormatDateTime('yyyyMMdd_HHnnss', Now) + '.log';
    LogPath := LogDir + PathDelim + LogFileName;
    
    // Deconflict name
    if FileExists(LogPath) then
    begin
      Index := 1;
      repeat
        LogFileName := 'GestyServer_' + FormatDateTime('yyyyMMdd_HHnnss', Now) + '_' + IntToStr(Index) + '.log';
        LogPath := LogDir + PathDelim + LogFileName;
        Inc(Index);
      until not FileExists(LogPath);
    end;

    LogContent := TStringList.Create;
    try
      LogContent.Add('================================================================================');
      LogContent.Add('=== GESTY SERVER EXCEPTION LOG ===');
      LogContent.Add('================================================================================');
      LogContent.Add('Timestamp:         ' + FormatDateTime('yyyy-mm-dd HH:nn:ss.zzz', Now));
      LogContent.Add('Exception Class:   ' + E.ClassName);
      LogContent.Add('Exception Message: ' + E.Message);
      LogContent.Add('');
      
      if Assigned(Request) then
      begin
        LogContent.Add('================================================================================');
        LogContent.Add('=== REQUEST DETAILS ===');
        LogContent.Add('================================================================================');
        LogContent.Add('Method:            ' + Request.Method);
        LogContent.Add('URL:               ' + Request.URL);
        LogContent.Add('PathInfo:          ' + Request.PathInfo);
        LogContent.Add('QueryString:       ' + Request.Query);
        LogContent.Add('Remote Address:    ' + Request.RemoteAddr);
        LogContent.Add('Remote IP:         ' + Request.RemoteIP);
        LogContent.Add('Authorization:     ' + Request.Authorization);
        LogContent.Add('Content Type:      ' + Request.ContentType);
        LogContent.Add('Content Length:    ' + IntToStr(Request.ContentLength));
        LogContent.Add('User Agent:        ' + Request.UserAgent);
        LogContent.Add('Cookie:            ' + Request.Cookie);
        LogContent.Add('Accept:            ' + Request.Accept);
        LogContent.Add('');
        
        LogContent.Add('--- Query Fields (GET parameters) ---');
        if Request.QueryFields.Count > 0 then
          LogContent.Add(Request.QueryFields.Text)
        else
          LogContent.Add('(No query fields)');
        LogContent.Add('');
        
        LogContent.Add('--- Content Fields (POST/Form parameters) ---');
        if Request.ContentFields.Count > 0 then
          LogContent.Add(Request.ContentFields.Text)
        else
          LogContent.Add('(No content fields)');
        LogContent.Add('');
        
        LogContent.Add('--- Raw Body Content ---');
        if Request.ContentLength > 0 then
        begin
          try
            LogContent.Add(TEncoding.UTF8.GetString(Request.RawContent));
          except
            on RawEx: Exception do
              LogContent.Add('[Error reading raw content as UTF8: ' + RawEx.Message + ']');
          end;
        end
        else
          LogContent.Add('(No body content)');
      end
      else
      begin
        LogContent.Add('================================================================================');
        LogContent.Add('=== NO HTTP REQUEST CONTEXT AVAILABLE ===');
        LogContent.Add('================================================================================');
      end;
      
      LogContent.Add('================================================================================');
      LogContent.SaveToFile(LogPath, TEncoding.UTF8);
    finally
      LogContent.Free;
    end;
  except
    // Silent catch to prevent exception logging itself from crashing the server
  end;
end;

end.
