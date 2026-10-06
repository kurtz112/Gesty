unit lib.JsonRest; { TODO : Rinominare }

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  System.JSON,
  web.HTTPApp,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  lib.DataRequest,
  lib.datasetProps,
  lib.widgetOptions;

const
  DefaultLimit = 100;

type
  TJSONFieldType = (jftUnknown, jftString, jftInteger, jftLargeInt, jftBoolean, jftFloat, jftDate, jftTime, jftDateTime, jftAutoInc, jftBlob, jftMemo, jftFixedChar, jftVariant, jftDataset);

  TJson2DataSetOption = (j2doDateISO, j2doMetadata, j2doDetailDatasets);
  TJson2DataSetOptions = set of TJson2DataSetOption;

  TJsonEngine = class
  public const
    ident_Result = 'result';
    ident_Metadata = 'meta';
    ident_DataRoot = 'data';
    ident_RecordCount = 'recordCount'; // 'RecordCount del pacchetto';
    ident_TotalProperty = 'total'; // 'RecordCount';
    ident_SuccessProperty = 'success';
    ident_Error = 'error';
    ident_ExceptionMsg = 'exceptionMsg';
    ident_ErrorCode = 'errorCode';
  private
    class function GetJSONFieldType(Const FieldType: TFieldType): TJSONFieldType;
    class function dxType(Const FieldType: TFieldType): string;
  private
    // class function RemoveCR(const s: string): string;
    // class function Quote(const s: string; const SkipQuotationMarks: boolean = True): string;
    // class function DeQuote(const s: string): string;
    //
  public
    class function BoolToJSON(Value: boolean): TJSONValue;

    class function DateToJSON(Value: TDate; ISO: boolean): TJSONValue;
    class function TimeToJSON(Value: TTime; ISO: boolean): TJSONValue;
    class function DateTimeToJSON(Value: TDateTime; ISO: boolean): TJSONValue;

    class function Result(ResultOk: boolean; ResultObj: TJSONValue): TJsonObject;
    class function Error(const ErrorMsg: string; const ErrorCode: integer = -1; const ExceptionMsg: string = ''): TJsonObject;
    /// /////////////////

    class function FieldToJSON(Field: TField; Options: TJson2DataSetOptions): TJSONValue;
    class function FieldMetaDataToJSON(Field: TField; const PrepareDisplayLabel: boolean = false): TJsonObject;
    class function ParamToJSON(Param: TFDParam; Options: TJson2DataSetOptions): TJSONValue;

    class function RecordToJSON(DataSet: TDataSet; Options: TJson2DataSetOptions = []): TJsonObject;
    class function MetadataToJSON(DataSet: TDataSet; const PrepareDisplayLabel: boolean = false): TJsonArray;

    class function DataSetToJSON(DataSet: TDataSet; Options: TJson2DataSetOptions = []; Meta: TJsonObject = nil; TotalRecordCount: integer = -1): TJsonObject;

    class function StoredProcToJSON(StoredProc: TFDStoredproc; Options: TJson2DataSetOptions = []): TJsonObject;
    class function CommandToJSON(Command: TFDCommand; Options: TJson2DataSetOptions = []): TJsonObject;
  end;

  TWebRequestHelper = class helper for TWebRequest
  public const
    identDataRequest = 'DataRequest';
    // identOptionsRequest = 'WidgetProps';
    identOptionsRequest = 'OptionsRequest';
    identSqlRequest = 'SqlRequest';
    identDatasetRequest = 'DatasetRequest';
    identFieldsRequest = 'FieldsRequest';
    identParamEncoded = '__Base64';
  public
    procedure AddParam(const ParamName: String; ParamValue: string);
    function ParamCount: integer;
    function ParamExists(const ParamName: String): boolean;
    function ParamByName(const ParamName: String): string;
    function ParamByIndex(const idx: integer): string;

    function ReadStream(const Decompress: boolean = false; const Decode: boolean = false): TMemoryStream; overload;
    function ReadStream(const FileName: String; const Decompress: boolean = false; const Decode: boolean = false): TFileStream; overload;

    function ReadDataSet(FDMemTable: TFDMemTable): boolean;

    function DataRequest: TDataRequest;

    function datasetProps: TDatasetProps;
    function fieldsProps: TFieldsProps;

    function widgetOptions: TWidgetOptions;

    // eliminare)
    function SqlRequest: TSqlRequest;
    function WidgetProps: TWidgetProps;
  end;

  TWebResponseHelper = class helper for TWebResponse
  private
    function GetContentType(FileName: String): string;

    procedure SetCorsHeader;
    procedure SetXFrameHeader;
    procedure SetNoSniffHeader;
    procedure SetCacheHeader;

    procedure SetDefaultHeaders;

    procedure LogResponse;
  public
    procedure Render(Result: boolean; JSONValue: TJSONValue); overload;
    procedure Render(Stream: TStream; aContentType: string); overload;
    procedure Render(const FileName: string; const ViewInBrowser: boolean = false; BrowserFileName: string = ''); overload;

    procedure Render(DataSet: TDataSet; Options: TJson2DataSetOptions = []; Meta: TJsonObject = nil; TotalRecordCount: integer = -1); overload;
    procedure Render(StoredProc: TFDStoredproc); overload;
    procedure Render(Command: TFDCommand); overload;

    procedure Render(JSONValue: TJSONValue); overload;

    procedure RenderError(const ErrorMsg: string; const ErrorCode: integer = -1; const ExceptionMsg: string = '');
    procedure RenderException(e: exception; const ErrorCode: integer = -1);

    procedure SetContentURL(const url: string);
    procedure SetContentHTML(const html: string);
  public
    procedure Render200;
    procedure RenderOk;
    procedure RenderNotFound;
  end;

implementation

uses
  System.StrUtils,
  System.Rtti,
  System.NetEncoding,
  System.IOUtils,
  FireDAC.Stan.Intf,
  REST.JSON,
  zz.FirebirdErrors,
  zz.Stream,
  lib.DateISO,
  lib.Config,
  fib.SqlTxtRtns,
  SmartInspect.Core.SiAuto,
  SmartInspect.Core,
  System.UITypes;

{ TWebRequestHelper }

procedure TWebRequestHelper.AddParam(const ParamName: String; ParamValue: string);
begin
  if MethodType = mtPost then
    ContentFields.AddPair(ParamName, ParamValue)
  else
    QueryFields.AddPair(ParamName, ParamValue);
end;

function TWebRequestHelper.DataRequest: TDataRequest;
var
  s: string;
begin
  Result := nil;

  s := ParamByName(identDataRequest);

  if s <> '' then
  begin
    try
      Result := TDataRequest.Decode(s);
    except
      on e: exception do
      begin
        siMain.LogString('DataRequest errata', s);
        raise exception.Create('Struttura DataRequest non valida.');
        // raise;
      end;
    end;
  end
  else
  begin
    siMain.LogError('DataRequest non specificata.');
    raise exception.Create('Struttura DataRequest non specificata.');
  end;
end;

function TWebRequestHelper.WidgetProps: TWidgetProps;
var
  s: string;
begin
  Result := nil;

  s := ParamByName(identOptionsRequest);

  if s <> '' then
  begin
    try
      Result := TWidgetProps.Decode(s);
    except
      on e: exception do
      begin
        siMain.LogString('WidgetProps errata', s);
        raise exception.Create('Struttura WidgetProps non valida.');
        // raise;
      end;
    end;
  end
  else
  begin
    siMain.LogError('WidgetProps non specificata.');
    raise exception.Create('Struttura WidgetProps non specificata.');
  end;
end;

function TWebRequestHelper.ParamByIndex(const idx: integer): string;
begin
  Result := '';

  if MethodType = mtPost then
  begin

    if idx < ContentFields.Count then
      Result := ContentFields.ValueFromIndex[idx]
    else
      Result := QueryFields.ValueFromIndex[idx - ContentFields.Count];

    // solo su post
    if ContentFields.Names[idx].EndsWith(identParamEncoded) then
      Result := TNetEncoding.Base64.Decode(Result);
  end
  else
  begin

    if idx < QueryFields.Count then
      Result := QueryFields.ValueFromIndex[idx]
    else
      Result := ContentFields.ValueFromIndex[idx - QueryFields.Count];
  end;
end;

function TWebRequestHelper.ParamByName(const ParamName: String): string;
begin
  Result := '';

  if MethodType = mtPost then
  begin
    Result := ContentFields.Values[ParamName];

    if Result = '' then
      Result := QueryFields.Values[ParamName];

    // 27.08.2020: Gesenu passa file dei conferimenti nel body
    if Result = '' then
    begin
      Result := ContentFields.Values[ParamName + identParamEncoded];
      Result := TNetEncoding.Base64.Decode(Result);
    end;
  end
  else
  begin
    Result := QueryFields.Values[ParamName];

    if Result = '' then
      Result := ContentFields.Values[ParamName];
  end;
end;

function TWebRequestHelper.ParamCount: integer;
begin
  Result := QueryFields.Count + ContentFields.Count;
end;

function TWebRequestHelper.ParamExists(const ParamName: String): boolean;
begin
  Result := false;

  if MethodType = mtPost then
  begin
    Result := ContentFields.IndexOfName(ParamName) >= 0;

    if not Result then
      Result := QueryFields.IndexOfName(ParamName) >= 0;

    if not Result then // solo su post
      Result := ContentFields.IndexOfName(ParamName + identParamEncoded) >= 0;
  end
  else
  begin
    Result := QueryFields.IndexOfName(ParamName) >= 0;

    if not Result then
      Result := ContentFields.IndexOfName(ParamName) >= 0;
  end;
end;

function TWebRequestHelper.ReadDataSet(FDMemTable: TFDMemTable): boolean;
var
  Stream: TStream;
  FileName: string;
begin
  // se serve per dbug
  // FileName := TPath.GetTempFileName;
  // try
  // Stream := ReadStream(FileName, True, True);

  Stream := ReadStream(True, True);
  try
    Stream.Position := 0;
    if Stream.Size > 0 then
      FDMemTable.LoadFromStream(Stream, sfJSON);
  finally
    Stream.Free;
  end;

  // FDMemTable.LoadFromFile(FileName, sfJSON);
  // finally
  // TFile.Delete(FileName);
  // end;
end;

function TWebRequestHelper.ReadStream(const Decompress: boolean = false; const Decode: boolean = false): TMemoryStream;
begin
  Result := TMemoryStream.Create;
  DecompressAndDecode(Self, Result, Decompress, Decode);
end;

function TWebRequestHelper.ReadStream(const FileName: String; const Decompress: boolean = false; const Decode: boolean = false): TFileStream;
begin
  Result := TFileStream.Create(FileName, fmCreate);
  DecompressAndDecode(Self, Result, Decompress, Decode);
end;

function TWebRequestHelper.SqlRequest: TSqlRequest;
var
  s: string;
begin
  Result := nil;

  s := ParamByName(identSqlRequest);

  if s <> '' then
  begin
    try
      Result := TSqlRequest.Decode(s);
    except
      on e: exception do
      begin
        siMain.LogString('SqlRequest errata', s);
        raise exception.Create('Struttura SqlRequest non valida.');
        // raise;
      end;
    end;
  end
  else
  begin
    siMain.LogError('SqlRequest non specificata.');
    raise exception.Create('Struttura SqlRequest non specificata.');
  end;
end;

function TWebResponseHelper.GetContentType(FileName: String): string;
var
  mime: TStringList;
begin
  mime := TStringList.Create;
  try
    mime.Add('.bmp=image/bmp');
    mime.Add('.gif=image/gif');
    mime.Add('.ico=image/x-icon');
    mime.Add('.jpg=image/jpeg');
    mime.Add('.jpeg=image/jpeg');
    mime.Add('.jpe=image/jpeg');
    mime.Add('.png=image/png');
    mime.Add('.txt=text/plain');
    mime.Add('.avi=video/x-msvideo');
    mime.Add('.mp3=video/mpeg');
    mime.Add('.mp4=video/mpeg');
    mime.Add('.mpeg=video/x-mpeg2a');
    mime.Add('.7z=application/x-7z-compressed');
    mime.Add('.gzip=application/x-gzip');
    mime.Add('.gz=application/x-gzip');
    mime.Add('.iso=application/x-iso9660-image');
    mime.Add('.pdf=application/pdf');
    mime.Add('.zip=application/x-zip-compressed');
    mime.Add('.css=text/css');
    mime.Add('.js=text/javascript');
    mime.Add('.htm=text/html');
    mime.Add('.html=text/html');
    mime.Add('.xhtml=application/xhtml+xml');
    mime.Add('.xht=application/xhtml+xml');
    mime.Add('.rdf=application/rdf+xml');
    mime.Add('.rss=application/rss+xml');
    mime.Add('.xml=text/xml');

    Result := mime.Values[LowerCase(ExtractFileExt(FileName))];
  finally
    FreeAndNil(mime);
  end;

  if Result = '' then
    Result := 'application/octet-stream';
end;

procedure TWebResponseHelper.SetDefaultHeaders;
begin
  SetCorsHeader;
  SetXFrameHeader;
  SetNoSniffHeader;
  SetCacheHeader;
end;

procedure TWebResponseHelper.SetXFrameHeader;
begin
  SetCustomHeader('X-Frame-Options', 'DENY');
end;

procedure TWebResponseHelper.SetNoSniffHeader;
begin
  SetCustomHeader('X-Content-Type-Options', 'nosniff');
end;

procedure TWebResponseHelper.SetCacheHeader;
begin
  SetCustomHeader('Cache-Control', 'no-cache, no-store, must-revalidate'); // HTTP 1.1.
  SetCustomHeader('Pragma', 'no-cache'); // HTTP 1.0.
  SetCustomHeader('Expires', '0'); // Proxies.
end;

procedure TWebResponseHelper.SetCorsHeader;
var
  AllowHeaders: string;
begin

  if ConfigProps.Cors.IsEmpty then
    Exit;

  AllowHeaders := HTTPRequest.GetFieldByName('Access-Control-Request-Headers');
  if AllowHeaders.IsEmpty then
    AllowHeaders := 'X-Requested-With,Content-Type,Authorization';

  SetCustomHeader('Access-Control-Allow-Origin', ConfigProps.Cors);
  SetCustomHeader('Access-Control-Allow-Methods', ConfigProps.AllowedMethods);
  SetCustomHeader('Access-Control-Allow-Headers', AllowHeaders);
end;

procedure TWebResponseHelper.Render(Result: boolean; JSONValue: TJSONValue);
var
  o: TJsonObject;
begin
  o := TJsonEngine.Result(Result, JSONValue);
  try
    Render(o);
  except
    on e: exception do
    begin
      FreeAndNil(o);
      raise;
    end;
  end;
end;

procedure TWebResponseHelper.RenderOk;
begin
  Render(True, nil);
end;

procedure TWebResponseHelper.Render(Stream: TStream; aContentType: string);
begin
  SetDefaultHeaders;
  StatusCode := 200;
  ContentType := aContentType;
  ContentStream := Stream;
  FreeContentStream := True;
  LogResponse;
end;

procedure TWebResponseHelper.SetContentHTML(const html: string);
begin
  SetDefaultHeaders;
  StatusCode := 200;
  ContentType := 'text/html';
  ContentEncoding := 'utf-8';
  Content := html;
end;

procedure TWebResponseHelper.SetContentURL(const url: string);
begin
  SetDefaultHeaders;
  StatusCode := 200;
  ContentType := 'text/html';
  ContentEncoding := 'utf-8';
  Content := url;
end;

procedure TWebResponseHelper.RenderError(const ErrorMsg: string; const ErrorCode: integer = -1; const ExceptionMsg: string = '');
var
  o: TJsonObject;
begin
  SetDefaultHeaders;
  StatusCode := 400;
  ContentType := 'application/json';
  ContentEncoding := 'utf-8';

  o := TJsonEngine.Error(ErrorMsg, ErrorCode, ExceptionMsg);
  try
    Content := o.ToJSON;
  finally
    FreeAndNil(o);
  end;
  LogResponse;
end;

procedure TWebResponseHelper.RenderException(e: exception; const ErrorCode: integer = -1);
begin
  RenderError(ExtractFirebirdError(e), ErrorCode, e.Message);
end;

procedure TWebResponseHelper.Render(const FileName: string; const ViewInBrowser: boolean = false; BrowserFileName: string = '');
var
  FileStream: TFileStream;
  MemStream: TMemoryStream;
begin
  FileStream := TFileStream.Create(FileName, fmOpenRead);
  try
    MemStream := TMemoryStream.Create; // distrutto da Response
    MemStream.CopyFrom(FileStream, 0);
    MemStream.Position := 0;
  finally
    FreeAndNil(FileStream);
  end;

  if ViewInBrowser then
    CustomHeaders.Values['content-disposition'] := 'inline'
  else
  begin
    if BrowserFileName <> '' then
      CustomHeaders.Values['content-disposition'] := 'attachment;filename="' + ExtractFileName(BrowserFileName) + '"'
    else
      CustomHeaders.Values['content-disposition'] := 'attachment;filename="' + ExtractFileName(FileName) + '"';

    CustomHeaders.Values['Content-Length'] := MemStream.Size.ToString;
  end;

  Render(MemStream, GetContentType(FileName));
end;

procedure TWebResponseHelper.Render(DataSet: TDataSet; Options: TJson2DataSetOptions = []; Meta: TJsonObject = nil; TotalRecordCount: integer = -1);
begin
  Render(True, TJsonEngine.DataSetToJSON(DataSet, Options, Meta, TotalRecordCount));
end;

procedure TWebResponseHelper.Render(StoredProc: TFDStoredproc);
begin
  Render(True, TJsonEngine.StoredProcToJSON(StoredProc));
end;

procedure TWebResponseHelper.Render(Command: TFDCommand);
begin
  Render(True, TJsonEngine.CommandToJSON(Command));
end;

procedure TWebResponseHelper.Render200;
begin
  // SetDefaultHeaders;
  StatusCode := 200;
  LogResponse;
end;

procedure TWebResponseHelper.RenderNotFound;
begin
  RenderError('Not Found');
end;

{ TJsonEngine }

// class function TJsonEngine.RemoveCR(const s: string): string;
// begin
// Result := StringReplace(AdjustLineBreaks(s), #13#10, ' ', [rfReplaceAll]);
// end;

// class function TJsonEngine.Quote(const s: string; const SkipQuotationMarks: boolean): string;
// var
// c: char;
// begin
// Result := '';
//
// // Result := TEncoding.UTF8.GetString(TEncoding.ASCII.GetBytes(s));
// //
// // Exit;
//
// for c in s do
// case c of
// '\':
// Result := Result + '\\';
// '/':
// Result := Result + '\/';
// '"':
// if SkipQuotationMarks then
// Result := Result + c
// else
// Result := Result + '\"';
// #8:
// Result := Result + '\b';
// #9:
// Result := Result + '\t';
// #10:
// Result := Result + '\n';
// #13:
// Result := Result + '\r';
// #12:
// Result := Result + '\f';
// else
// if ord(c) < 32 then
// Result := Result + '\u' + IntToHex(ord(c), 4)
// else
// if ord(c) > 127 then
// Result := Result + '\u' + IntToHex(ord(c), 4)
// else
// Result := Result + c;
// end;
// end;
//
// class function TJsonEngine.DeQuote(const s: string): string;
// var
// o: TJsonObject;
// tmp: string;
// begin
// Result := '';
//
// tmp := '{"value":"' + s + '"}';
//
// o := TJsonObject.ParseJSONValue(TEncoding.ASCII.GetBytes(tmp), 0) as TJsonObject;
// try
// if Assigned(o) then
// Result := TJSONString(o.get('value').JSONValue).Value;
// finally
// FreeAndNil(o);
// end;
// end;

class function TJsonEngine.DateToJSON(Value: TDate; ISO: boolean): TJSONValue;
begin
  if ISO then
    Result := DateISO.DateToJSON(Value)
  else
    Result := TJSONString.Create(FormatDateTime('dd/mm/yyyy', Value));
end;

class function TJsonEngine.dxType(const FieldType: TFieldType): string;
begin
  // string' | 'number' | 'date' | 'boolean' | 'object' | 'datetime

  Result := 'string';

  case GetJSONFieldType(FieldType) of
    jftUnknown:
      Result := 'string';
    jftString:
      Result := 'string';
    jftFixedChar:
      Result := 'string';
    jftBoolean:
      Result := 'boolean';
    jftInteger:
      Result := 'number';
    jftLargeInt:
      Result := 'number';
    jftAutoInc:
      Result := 'number';
    jftFloat:
      Result := 'number';
    jftDate:
      Result := 'date';
    jftTime:
      Result := 'datetime';
    jftDateTime:
      Result := 'datetime';
    jftBlob:
      Result := 'object';
    jftMemo:
      Result := 'object';
    jftVariant:
      Result := 'object';
    jftDataset:
      Result := 'object';
  end;
end;

class function TJsonEngine.TimeToJSON(Value: TTime; ISO: boolean): TJSONValue;
begin
  if ISO then
    Result := DateISO.TimeToJSON(Value)
  else
    Result := TJSONString.Create(FormatDateTime('hh.nn.ss', Value));
end;

class function TJsonEngine.DateTimeToJSON(Value: TDateTime; ISO: boolean): TJSONValue;
begin
  if ISO then
    Result := DateISO.DateTimeToJSON(Value)
  else
    Result := TJSONString.Create(FormatDateTime('dd/mm/yyyy hh.nn.ss', Value));
end;

class function TJsonEngine.BoolToJSON(Value: boolean): TJSONValue;
begin
  if Value then
    Result := TJSONTrue.Create
  else
    Result := TJSONFalse.Create;
end;

class function TJsonEngine.Result(ResultOk: boolean; ResultObj: TJSONValue): TJsonObject;
begin
  Result := TJsonObject.Create;
  Result.AddPair(TJSONPair.Create(ident_SuccessProperty, BoolToJSON(ResultOk)));

  if Assigned(ResultObj) then
    Result.AddPair(TJSONPair.Create(ident_Result, ResultObj));
end;

class function TJsonEngine.Error(const ErrorMsg: string; const ErrorCode: integer = -1; const ExceptionMsg: string = ''): TJsonObject;
begin
  Result := TJsonObject.Create;
  Result.AddPair(TJSONPair.Create(ident_SuccessProperty, TJSONFalse.Create));
  Result.AddPair(TJSONPair.Create(ident_Error, TJSONString.Create(StringReplace(ErrorMsg, #13#10, ' ', [rfReplaceAll]))));
  Result.AddPair(TJSONPair.Create(ident_ErrorCode, TJSONNumber.Create(ErrorCode)));
  Result.AddPair(TJSONPair.Create(ident_ExceptionMsg, TJSONString.Create(StringReplace(ExceptionMsg, #13#10, ' ', [rfReplaceAll]))));
end;

class function TJsonEngine.FieldToJSON(Field: TField; Options: TJson2DataSetOptions): TJSONValue;
begin

  if Field.IsNull then
    Result := TJSONNull.Create
  else
    case Field.DataType of
      ftUnknown:
        Result := TJSONNull.Create;
      ftString:
        Result := TJSONString.Create(Field.AsString);
      ftSmallint:
        Result := TJSONNumber.Create(Field.AsInteger);
      ftInteger:
        Result := TJSONNumber.Create(Field.AsInteger);
      ftWord:
        Result := TJSONNumber.Create(Field.AsInteger);
      ftBoolean:
        Result := BoolToJSON(Field.AsBoolean);
      ftFloat:
        Result := TJSONNumber.Create(Field.AsFloat);
      ftCurrency:
        Result := TJSONNumber.Create(Field.AsFloat);
      ftBCD:
        Result := TJSONNumber.Create(Field.AsFloat);
      ftDate:
        Result := DateToJSON(Field.AsDateTime, j2doDateISO in Options);
      ftTime:
        Result := TimeToJSON(Field.AsDateTime, j2doDateISO in Options);
      ftDateTime:
        Result := DateTimeToJSON(Field.AsDateTime, j2doDateISO in Options);
      ftBytes:
        Result := TJSONString.Create(Field.AsString);
      ftVarBytes:
        Result := TJSONString.Create(Field.AsString);
      ftAutoInc:
        Result := TJSONNumber.Create(Field.AsInteger);
      ftBlob:
        Result := TJSONNull.Create; // zBLOB TJSONString.Create(FieldToJSON.AsString);
      // ftMemo: result := TJSONNull.Create; //zBLOB TJSONString.Create(FieldToJSON.AsString);
      ftMemo:
        Result := TJSONString.Create(Field.AsString);
      ftGraphic:
        Result := TJSONNull.Create; // zBLOB TJSONString.Create(FieldToJSON.AsString);
      ftFmtMemo:
        Result := TJSONString.Create(Field.AsString);
      ftParadoxOle:
        Result := TJSONString.Create(Field.AsString);
      ftDBaseOle:
        Result := TJSONString.Create(Field.AsString);
      ftTypedBinary:
        Result := TJSONString.Create(Field.AsString);
      ftCursor:
        Result := TJSONString.Create(Field.AsString);
      ftFixedChar:
        Result := TJSONString.Create(Field.AsString);
      ftWideString:
        Result := TJSONString.Create(Field.AsString); // 19..24
      ftLargeint:
        Result := TJSONNumber.Create(Field.AsLargeInt);
      ftADT:
        Result := TJSONString.Create(Field.AsString);
      ftArray:
        Result := TJSONString.Create(Field.AsString);
      ftReference:
        Result := TJSONString.Create(Field.AsString);
      ftDataSet:
        Result := TJSONString.Create(Field.AsString);
      ftOraBlob:
        Result := TJSONString.Create(Field.AsString);
      ftOraClob:
        Result := TJSONString.Create(Field.AsString);
      ftVariant:
        Result := TJSONString.Create(Field.AsString);
      ftInterface:
        Result := TJSONString.Create(Field.AsString);
      ftIDispatch:
        Result := TJSONString.Create(Field.AsString);
      ftGuid:
        Result := TJSONNumber.Create(Field.AsInteger);
      ftTimeStamp:
        Result := DateTimeToJSON(Field.AsDateTime, j2doDateISO in Options);
      ftFMTBcd:
        Result := TJSONNumber.Create(Field.AsFloat);
      ftFixedWideChar:
        Result := TJSONString.Create(Field.AsString);
      ftWideMemo:
        Result := TJSONString.Create(Field.AsString);
      ftOraTimeStamp:
        Result := TJSONString.Create(Field.AsString);
      ftOraInterval:
        Result := TJSONString.Create(Field.AsString); // 38..41
      ftLongWord:
        Result := TJSONNumber.Create(Field.AsLargeInt);
      ftShortint:
        Result := TJSONNumber.Create(Field.AsInteger);
      ftByte:
        Result := TJSONNumber.Create(Field.AsInteger);
      ftExtended:
        Result := TJSONNumber.Create(Field.AsFloat);
      ftConnection:
        Result := TJSONString.Create(Field.AsString);
      ftParams:
        Result := TJSONString.Create(Field.AsString);
      ftStream:
        Result := TJSONString.Create(Field.AsString); // 42..48
      ftTimeStampOffset:
        Result := TJSONString.Create(Field.AsString);
      ftObject:
        Result := TJSONString.Create(Field.AsString);
      ftSingle:
        Result := TJSONNumber.Create(Field.AsInteger);
    end;
end;

class function TJsonEngine.FieldMetaDataToJSON(Field: TField; const PrepareDisplayLabel: boolean = false): TJsonObject;

  function zzCapFirst(Value: string): string;
  var
    i: integer;
    s: string;
  begin
    Result := '';

    if trim(Value) = '' then
      Exit;

    s := uppercase(Value[1]);

    for i := 2 to length(Value) do
    begin

      if (Value[i - 1] in [' ', '_']) then
        s := s + uppercase(Value[i])
      else
        s := s + LowerCase(Value[i]);
    end;

    s := StringReplace(s, '_', ' ', [rfReplaceAll]);
    Result := s;
  end;

begin

  Result := TJsonObject.Create;
  try
    // Result.AddPair('FieldName', Field.FieldName);
    //
    // if PrepareDisplayLabel then
    // Result.AddPair('DisplayLabel', zzCapFirst(Field.DisplayLabel))
    // else
    // Result.AddPair('DisplayLabel', Field.DisplayLabel);
    //
    // Result.AddPair('DataType', TRttiEnumerationType.GetName(Field.DataType));
    // Result.AddPair('FieldType', TJSONNumber.Create(ord(Field.DataType)));
    //
    // // Result.AddPair('JSONFieldType', TJSONNumber.Create(ord(GetJSONFieldType(Field.DataType))));
    // Result.AddPair('dxType', dxType(Field.DataType));
    //
    // Result.AddPair('Size', TJSONNumber.Create(Field.Size));
    // Result.AddPair('ReadOnly', TJSONBool.Create(Field.ReadOnly));
    // Result.AddPair('Required', TJSONBool.Create(Field.Required));
    // Result.AddPair('DisplayWidth', TJSONNumber.Create(Field.DisplayWidth));
    //
    // // taLeftJustify, taRightJustify, taCenter
    // Result.AddPair('Alignment', TRttiEnumerationType.GetName(Field.Alignment));

    Result.AddPair('dataField', Field.FieldName);
    Result.AddPair('caption', zzCapFirst(Field.DisplayLabel));
    Result.AddPair('readOnly', TJSONBool.Create(Field.ReadOnly));
    Result.AddPair('required', TJSONBool.Create(Field.Required));
    Result.AddPair('type', dxType(Field.DataType));
    Result.AddPair('size', TJSONNumber.Create(Field.Size));
    Result.AddPair('width', TJSONNumber.Create(Field.DisplayWidth));

    case Field.Alignment of
      taLeftJustify:
        Result.AddPair('align', 'left');
      taRightJustify:
        Result.AddPair('align', 'right');
      taCenter:
        Result.AddPair('align', 'center');
    end;
  except
    Result.Free;
    raise;
  end;
end;

class function TJsonEngine.MetadataToJSON(DataSet: TDataSet; const PrepareDisplayLabel: boolean = false): TJsonArray;
var
  Field: TField;
begin
  Assert(Assigned(DataSet));

  Result := TJsonArray.Create;
  try
    for Field in DataSet.Fields do
      if not(Field is TDataSetField) then
        Result.AddElement(FieldMetaDataToJSON(Field, PrepareDisplayLabel));
  except
    Result.Free;
    raise;
  end;
end;

class function TJsonEngine.ParamToJSON(Param: TFDParam; Options: TJson2DataSetOptions): TJSONValue;
begin

  if Param.IsNull then
    Result := TJSONNull.Create
  else
    case Param.DataType of
      ftUnknown:
        Result := TJSONNull.Create;
      ftString:
        Result := TJSONString.Create(Param.AsString);
      ftSmallint:
        Result := TJSONNumber.Create(Param.AsInteger);
      ftInteger:
        Result := TJSONNumber.Create(Param.AsInteger);
      ftWord:
        Result := TJSONNumber.Create(Param.AsInteger);
      ftBoolean:
        Result := BoolToJSON(Param.AsBoolean);
      ftFloat:
        Result := TJSONNumber.Create(Param.AsFloat);
      ftCurrency:
        Result := TJSONNumber.Create(Param.AsFloat);
      ftBCD:
        Result := TJSONNumber.Create(Param.AsFloat);
      ftDate:
        Result := DateToJSON(Param.AsDateTime, j2doDateISO in Options);
      ftTime:
        Result := TimeToJSON(Param.AsDateTime, j2doDateISO in Options);
      ftDateTime:
        Result := DateTimeToJSON(Param.AsDateTime, j2doDateISO in Options);
      ftBytes:
        Result := TJSONString.Create(Param.AsString);
      ftVarBytes:
        Result := TJSONString.Create(Param.AsString);
      ftAutoInc:
        Result := TJSONNumber.Create(Param.AsInteger);
      ftBlob:
        Result := TJSONNull.Create; // zBLOB TJSONString.Create(Field.AsString);
      // ftMemo: result := TJSONNull.Create; //zBLOB TJSONString.Create(Field.AsString);
      ftMemo:
        Result := TJSONString.Create(Param.AsString);
      ftGraphic:
        Result := TJSONNull.Create; // zBLOB TJSONString.Create(Field.AsString);
      ftFmtMemo:
        Result := TJSONString.Create(Param.AsString);
      ftParadoxOle:
        Result := TJSONString.Create(Param.AsString);
      ftDBaseOle:
        Result := TJSONString.Create(Param.AsString);
      ftTypedBinary:
        Result := TJSONString.Create(Param.AsString);
      ftCursor:
        Result := TJSONString.Create(Param.AsString);
      ftFixedChar:
        Result := TJSONString.Create(Param.AsString);
      ftWideString:
        Result := TJSONString.Create(Param.AsString); // 19..24
      ftLargeint:
        Result := TJSONNumber.Create(Param.AsLargeInt);
      ftADT:
        Result := TJSONString.Create(Param.AsString);
      ftArray:
        Result := TJSONString.Create(Param.AsString);
      ftReference:
        Result := TJSONString.Create(Param.AsString);
      ftDataSet:
        Result := TJSONString.Create(Param.AsString);
      ftOraBlob:
        Result := TJSONString.Create(Param.AsString);
      ftOraClob:
        Result := TJSONString.Create(Param.AsString);
      ftVariant:
        Result := TJSONString.Create(Param.AsString);
      ftInterface:
        Result := TJSONString.Create(Param.AsString);
      ftIDispatch:
        Result := TJSONString.Create(Param.AsString);
      ftGuid:
        Result := TJSONNumber.Create(Param.AsInteger);
      ftTimeStamp:
        Result := DateTimeToJSON(Param.AsDateTime, j2doDateISO in Options);
      ftFMTBcd:
        Result := TJSONNumber.Create(Param.AsFloat);
      ftFixedWideChar:
        Result := TJSONString.Create(Param.AsString);
      ftWideMemo:
        Result := TJSONString.Create(Param.AsString);
      ftOraTimeStamp:
        Result := TJSONString.Create(Param.AsString);
      ftOraInterval:
        Result := TJSONString.Create(Param.AsString); // 38..41
      ftLongWord:
        Result := TJSONNumber.Create(Param.AsLargeInt);
      ftShortint:
        Result := TJSONNumber.Create(Param.AsInteger);
      ftByte:
        Result := TJSONNumber.Create(Param.AsInteger);
      ftExtended:
        Result := TJSONNumber.Create(Param.AsFloat);
      ftConnection:
        Result := TJSONString.Create(Param.AsString);
      ftParams:
        Result := TJSONString.Create(Param.AsString);
      ftStream:
        Result := TJSONString.Create(Param.AsString); // 42..48
      ftTimeStampOffset:
        Result := TJSONString.Create(Param.AsString);
      ftObject:
        Result := TJSONString.Create(Param.AsString);
      ftSingle:
        Result := TJSONNumber.Create(Param.AsInteger);
    end;
end;

class function TJsonEngine.RecordToJSON(DataSet: TDataSet; Options: TJson2DataSetOptions = []): TJsonObject;

  function ExportDataSet(DataSet: TDataSet): TJsonArray;
  var
    DataSetList: TList<TDataSet>;
    Detail: TDataSet;
  var
    jRecord: TJsonObject;
  begin
    DataSetList := TList<TDataSet>.Create;
    try
      DataSet.GetDetailDataSets(DataSetList);

      Result := TJsonArray.Create;
      try
        DataSet.First;
        while not DataSet.Eof do
        begin
          jRecord := RecordToJSON(DataSet);
          Result.AddElement(jRecord);

          for Detail in DataSetList do
            jRecord.AddPair(Detail.Name, ExportDataSet(Detail));

          DataSet.Next;
        end;
      except
        FreeAndNil(Result);
        raise;
      end;
    finally
      FreeAndNil(DataSetList);
    end;
  end;

var
  Field: TField;
  DataSetList: TList<TDataSet>;
  Detail: TDataSet;
begin
  Assert(Assigned(DataSet));

  Result := TJsonObject.Create;
  try
    if not DataSet.IsEmpty then
    begin
      for Field in DataSet.Fields do
        if not(Field is TDataSetField) then
          Result.AddPair(TJSONPair.Create(Field.FieldName, FieldToJSON(Field, Options)));

      // es.: questionari
      if j2doDetailDatasets in Options then
      begin
        DataSetList := TList<TDataSet>.Create;
        try
          DataSet.GetDetailDataSets(DataSetList);

          for Detail in DataSetList do
            Result.AddPair(Detail.Name, ExportDataSet(Detail));
        finally
          FreeAndNil(DataSetList);
        end;
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

class function TJsonEngine.DataSetToJSON(DataSet: TDataSet; Options: TJson2DataSetOptions = []; Meta: TJsonObject = nil; TotalRecordCount: integer = -1): TJsonObject;
var
  Field: TField;
  RecordCount: integer;
  jRecord: TJsonObject;
  jDataSet: TJsonArray;
begin
  Assert(Assigned(DataSet));

  Result := nil;

  // dati
  jDataSet := TJsonArray.Create;
  try
    RecordCount := 0;

    DataSet.First;
    while not DataSet.Eof do
    begin
      jRecord := RecordToJSON(DataSet, Options);
      jDataSet.AddElement(jRecord);

      DataSet.Next;
      inc(RecordCount);

      { TODO : Caso lookup web: mostrare i primi X bloccherebbe i lookup }
      // if Limit > 0 then
      // if (RecordCount >= Limit) then
      // Break;
    end;
  except
    FreeAndNil(jDataSet);
    raise;
  end;

  Result := TJsonObject.Create;
  try
    Result.AddPair(TJSONPair.Create(ident_RecordCount, TJSONNumber.Create(RecordCount)));
    Result.AddPair(TJSONPair.Create(ident_TotalProperty, TJSONNumber.Create(TotalRecordCount)));

    if Assigned(Meta) then
      Result.AddPair(TJSONPair.Create(ident_Metadata, Meta))
    else
      if j2doMetadata in Options then
        Result.AddPair(TJSONPair.Create(ident_Metadata, MetadataToJSON(DataSet, True)));

    Result.AddPair(TJSONPair.Create(ident_DataRoot, jDataSet));
  except
    Result.Free;
    raise;
  end;
end;

class function TJsonEngine.GetJSONFieldType(Const FieldType: TFieldType): TJSONFieldType;
begin
  Result := jftUnknown;

  case FieldType of
    ftUnknown:
      Result := jftUnknown;
    ftString:
      Result := jftString;
    ftSmallint:
      Result := jftInteger;
    ftInteger:
      Result := jftInteger;
    ftWord:
      Result := jftInteger;
    ftBoolean:
      Result := jftBoolean;
    ftFloat:
      Result := jftFloat;
    ftCurrency:
      Result := jftFloat;
    ftBCD:
      Result := jftFloat;
    ftDate:
      Result := jftDate;
    ftTime:
      Result := jftTime;
    ftDateTime:
      Result := jftDateTime;
    ftBytes:
      Result := jftBlob;
    ftVarBytes:
      Result := jftBlob;
    ftAutoInc:
      Result := jftAutoInc;
    ftBlob:
      Result := jftBlob;
    ftMemo:
      Result := jftMemo;
    ftGraphic:
      Result := jftBlob;
    ftFmtMemo:
      Result := jftMemo;
    ftParadoxOle:
      Result := jftUnknown;
    ftDBaseOle:
      Result := jftUnknown;
    ftTypedBinary:
      Result := jftUnknown;
    ftCursor:
      Result := jftUnknown;
    ftFixedChar:
      Result := jftString;
    ftWideString:
      Result := jftString;
    ftLargeint:
      Result := jftLargeInt;
    ftADT:
      Result := jftUnknown;
    ftArray:
      Result := jftUnknown;
    ftReference:
      Result := jftUnknown;
    ftDataSet:
      Result := jftUnknown;
    ftOraBlob:
      Result := jftUnknown;
    ftOraClob:
      Result := jftUnknown;
    ftVariant:
      Result := jftVariant;
    ftInterface:
      Result := jftUnknown;
    ftIDispatch:
      Result := jftUnknown;
    ftGuid:
      Result := jftUnknown;
    ftTimeStamp:
      Result := jftDateTime;
    ftFMTBcd:
      Result := jftFloat;
    ftFixedWideChar:
      Result := jftString;
    ftWideMemo:
      Result := jftMemo;
    ftOraTimeStamp:
      Result := jftUnknown;
    ftOraInterval:
      Result := jftUnknown;
    ftLongWord:
      Result := jftUnknown;
    ftShortint:
      Result := jftInteger;
    ftByte:
      Result := jftBlob;
    ftExtended:
      Result := jftFloat;
    ftConnection:
      Result := jftUnknown;
    ftParams:
      Result := jftUnknown;
    ftStream:
      Result := jftUnknown;
    ftTimeStampOffset:
      Result := jftUnknown;
    ftObject:
      Result := jftUnknown;
    ftSingle:
      Result := jftInteger;
  end;
end;

class function TJsonEngine.StoredProcToJSON(StoredProc: TFDStoredproc; Options: TJson2DataSetOptions = []): TJsonObject;
var
  i: integer;
begin
  Assert(Assigned(StoredProc));

  Result := TJsonObject.Create;
  try
    for i := 0 to StoredProc.ParamCount - 1 do
      if StoredProc.Params[i].ParamType in [ptOutput, ptInputOutput] then
        Result.AddPair(StoredProc.Params[i].Name, ParamToJSON(StoredProc.Params[i], Options));
  except
    Result.Free;
    raise;
  end;
end;

class function TJsonEngine.CommandToJSON(Command: TFDCommand; Options: TJson2DataSetOptions = []): TJsonObject;
var
  i: integer;
begin
  Assert(Assigned(Command));

  Result := TJsonObject.Create;
  try
    for i := 0 to Command.Params.Count - 1 do
      if Command.Params[i].ParamType in [ptOutput, ptInputOutput] then
        Result.AddPair(Command.Params[i].Name, ParamToJSON(Command.Params[i], Options));
  except
    Result.Free;
    raise;
  end;
end;

procedure TWebResponseHelper.LogResponse;
begin
  Exit;
  siMain.LogSeparator;
  siMain.LogColored(TColors.Steelblue, 'LogResponse');
  siMain.LogString('Response for', HTTPRequest.url);
  siMain.LogInteger('StatusCode', StatusCode);
  siMain.LogString('Location', Location);
  siMain.LogString('Content', Content);
  siMain.LogInteger('ContentLength', ContentLength);
  siMain.LogString('ContentEncoding', ContentEncoding);
  siMain.LogString('ContentType', ContentType);
  siMain.LogStringList('CustomHeaders', CustomHeaders);
  siMain.LogColored(TColors.Steelblue, '\LogResponse');
  siMain.LogSeparator;
end;

function TWebRequestHelper.datasetProps: TDatasetProps;
var
  s: string;
begin
  Result := nil;

  s := ParamByName(identDatasetRequest);

  if s <> '' then
  begin
    try
      Result := TDatasetsProps.Decode(s);
    except
      on e: exception do
      begin
        siMain.LogString('DatasetRequest errata', s);
        raise exception.Create('Struttura DatasetRequest non valida.');
        // raise;
      end;
    end;
  end
  else
  begin
    siMain.LogError('DatasetRequest non specificata.');
    raise exception.Create('Struttura DatasetRequest non specificata.');
  end;
end;

function TWebRequestHelper.fieldsProps: TFieldsProps;
var
  s: string;
begin
  Result := nil;

  s := ParamByName(identFieldsRequest);

  if s <> '' then
  begin
    try
      Result := TFieldsProps.Decode(s);
    except
      on e: exception do
      begin
        siMain.LogString('FieldsRequest errata', s);
        raise exception.Create('Struttura FieldsRequest non valida.');
        // raise;
      end;
    end;
  end
  else
  begin
    siMain.LogError('FieldsRequest non specificata.');
    raise exception.Create('Struttura FieldsRequest non specificata.');
  end;
end;

function TWebRequestHelper.widgetOptions: TWidgetOptions;
var
  s: string;
begin
  Result := nil;

  s := ParamByName(identOptionsRequest);

  if s <> '' then
  begin
    try
      Result := TWidgetsOptions.Decode(s);
    except
      on e: exception do
      begin
        siMain.LogString('WidgetOptions errata', s);
        raise exception.Create('Struttura WidgetOptions non valida.');
        // raise;
      end;
    end;
  end
  else
  begin
    siMain.LogError('WidgetOptions non specificata.');
    raise exception.Create('Struttura WidgetOptions non specificata.');
  end;
end;

procedure TWebResponseHelper.Render(JSONValue: TJSONValue);
begin
  SetDefaultHeaders;
  StatusCode := 200;
  ContentType := 'application/json';
  ContentEncoding := 'utf-8';
  Content := JSONValue.ToJSON;
  JSONValue.Free;
  LogResponse;
end;

end.
