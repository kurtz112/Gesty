unit GestyTools.Candidature;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Net.URLClient,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  QImport3,
  QImport3XMLBased,
  QImport3Xlsx;

type
  TImportCandidatureType = (icCSV, icXlsx);

  TImportCandidature = class(TDataModule)
    CandidatureAllegati: TFDQuery;
    CandidatureAllegatiID_CANDIDATURA: TLargeintField;
    CandidatureAllegatiTIPO_ALLEGATO: TWideStringField;
    CandidatureAllegatiFILE_NAME_DA_IMPORT: TWideStringField;
    CandidatureAllegatiID_OBJECT_FILE: TLargeintField;
    CandidatureAllegatiFULL_FILE_NAME: TWideStringField;
    procCandidatureImport: TFDStoredProc;
    NetHTTPClient: TNetHTTPClient;
    procCandidatureLogin: TFDStoredProc;
    QImport3Xlsx: TQImport3Xlsx;
    procedure QImport3XlsxUserDefinedImport(Sender: TObject; Row: TQImportRow);
  private
    CandidatureLines: TStringList;

    function DownloadFile(const url: string; const DestFileName: String): boolean;
    procedure SpostaAllegati(const IdFileCandidature: integer);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure ImportFile(const url: string; ImportType: TImportCandidatureType; const MapFileName: string = '');
  end;

var
  ImportCandidature: TImportCandidature;

implementation

uses
  System.DateUtils,
  System.IOUtils,
  QImport3Common,
  GestyTools.Log,
  GestyTools.Config,
  GestyTools.Connection,
  GestyTools.Mail;

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

constructor TImportCandidature.Create(aOwner: TComponent);
begin
  inherited;
  CandidatureLines := TStringList.Create;
  procCandidatureLogin.Connection := Connection.FDConnection;
  procCandidatureImport.Connection := Connection.FDConnection;
  CandidatureAllegati.Connection := Connection.FDConnection;
end;

destructor TImportCandidature.Destroy;
begin
  FreeAndNil(CandidatureLines);
  inherited;
end;

function TImportCandidature.DownloadFile(const url, DestFileName: String): boolean;
var
  FileStream: TStream;
begin
  FileStream := TFileStream.Create(DestFileName, fmCreate);
  try
    NetHTTPClient.Get(url, FileStream);
  finally
    FreeAndNil(FileStream);
  end;
end;

procedure TImportCandidature.QImport3XlsxUserDefinedImport(Sender: TObject; Row: TQImportRow);

  function CleanImportString(const s: string): string;

    function StripChars(const text: string; const NonValidChars: System.SysUtils.TSysCharSet): string;
    var
      I, j, zbsAdj: integer;
    begin
      SetLength(Result, Length(text)); // Preallocate result maximum length
      j := 0; // Resulting string length counter
      zbsAdj := 1 - Low(String); // Handles zero based string offset
      for I := Low(text) to High(text) do
      begin
        if not CharInSet(text[I], NonValidChars) then
        begin
          inc(j);
          Result[j - zbsAdj] := text[I];
        end;
      end;
      SetLength(Result, j); // Set result actual length
    end;

  begin
    Result := s;
    Result := Result.Replace(';', ',', [rfReplaceAll]);
    Result := Result.Replace(sLineBreak, ' ', [rfReplaceAll]);
    Result := Result.Replace(#160, ' ', [rfReplaceAll]);
    Result := StripChars(Result, [#0 .. #31]);
    Result := Result.trim;
  end;

var
  s: String;
  I: integer;
begin
  s := '';

  for I := 0 to Row.Count - 1 do
    s := s + CleanImportString(Row.Items[I].Value) + ';';

  CandidatureLines.Add(s);
end;

procedure TImportCandidature.ImportFile(const url: string; ImportType: TImportCandidatureType; const MapFileName: string = '');
var
  tmpFileName: string;
  idFile: integer;
begin
  procCandidatureLogin.Prepare;
  procCandidatureLogin.ParamByName('COMPUTER_NAME').Value := Connection.ComputerName;
  procCandidatureLogin.ExecProc;

  tmpFileName := TPath.GetTempFileName;
  try
    TFile.Delete(tmpFileName);

    if url.StartsWith('http', True) or url.StartsWith('www', True) then
      DownloadFile(url, tmpFileName)
    else
      TFile.Copy(url, tmpFileName);

    /// ///////////////////////////////////////////////////////////////////

    CandidatureLines.Clear;

    if ImportType = icXlsx then
    begin
      QImport3Xlsx.ImportDestination := qidUserDefined;
      QImport3Xlsx.SkipFirstRows := 0;
      QImport3Xlsx.SheetName := '';
      QImport3Xlsx.Map.LoadFromFile(MapFileName);
      QImport3Xlsx.FileName := tmpFileName;
      QImport3Xlsx.Execute;

      if DebugHook <> 0 then
      begin
        TFile.Copy(tmpFileName, 'X:\Gesty\_bin_GestyTools\download.xlsx', True);
        CandidatureLines.SaveToFile('X:\Gesty\_bin_GestyTools\download.csv');
      end;
    end
    else
      CandidatureLines.LoadFromFile(tmpFileName);

    /// ///////////////////////////////////////////////////////////////////

    /// ///////////////////////////////////////////////////////////////////

    procCandidatureImport.Prepare;
    procCandidatureImport.ParamByName('Nome_File').Value := 'Import del ' + now.ToString;
    procCandidatureImport.ParamByName('File_Originale').AsString := CandidatureLines.text;
    procCandidatureImport.ExecProc;
    idFile := procCandidatureImport.ParamByName('ID_FILE_CANDIDATURE').Value;

    SpostaAllegati(idFile);
  finally
    TFile.Delete(tmpFileName);
  end;
end;

procedure TImportCandidature.SpostaAllegati(const IdFileCandidature: integer);
var
  FilesNonTrovati: TStringList;
  src, dest, folder: string;
  idObjectFile: integer;
  idCandidatura: integer;
begin
  FilesNonTrovati := TStringList.Create;
  try
    CandidatureAllegati.Active := False;
    CandidatureAllegati.ParamByName('ID_FILE_CANDIDATURE').AsInteger := IdFileCandidature;
    CandidatureAllegati.Active := True;
    try
      CandidatureAllegati.First;
      while not CandidatureAllegati.Eof do
      begin
        idObjectFile := CandidatureAllegatiID_OBJECT_FILE.AsInteger;
        idCandidatura := CandidatureAllegatiID_CANDIDATURA.AsInteger;
        src := CandidatureAllegatiFILE_NAME_DA_IMPORT.AsString;
        dest := CandidatureAllegatiFULL_FILE_NAME.AsString;

        folder := TPath.GetDirectoryName(dest);
        if not TDirectory.Exists(folder) then
          TDirectory.CreateDirectory(folder);

        if src.StartsWith('http', True) or src.StartsWith('www', True) then
          DownloadFile(src, dest)
        else
          TFile.Copy(src, dest);

        if not TFile.Exists(dest) then
          FilesNonTrovati.AddPair('Candidatura ' + idCandidatura.ToString, src);

        CandidatureAllegati.Next;
      end;

    finally
      CandidatureAllegati.Active := False;
    end;

    if FilesNonTrovati.Count > 0 then
    begin
      FilesNonTrovati.Insert(0, 'I seguenti file non sono stati copiati: ');
      FilesNonTrovati.Insert(1, '');
      FilesNonTrovati.SaveToFile(Config.FolderUpdate + 'Errori Import Candidature File ' + idObjectFile.ToString + '.txt');

      Mail.InviaMail(Config.Ente + ' - Errori Import Candidature File ' + idObjectFile.ToString, FilesNonTrovati.text);
    end;
  finally
    FreeAndNil(FilesNonTrovati);
  end;
end;

end.
