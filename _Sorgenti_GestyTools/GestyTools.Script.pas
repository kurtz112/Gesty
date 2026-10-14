unit GestyTools.Script;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  System.Net.URLClient,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  Data.DB,
  fs_iinirtti,
  fs_iclassesrtti,
  fs_ipascal,
  fs_iinterpreter,
  cxClasses,
  dxCloudStorage,
  SmartInspect.VCL.SiAuto,
  SmartInspect.VCL;

type
  TScriptModule = class(TDataModule)
    fsScript: TfsScript;
    fsPascal: TfsPascal;
    fsClassesRTTI: TfsClassesRTTI;
    fsIniRTTI: TfsIniRTTI;
    procedure FDConnectionBeforeConnect(Sender: TObject);
  private
    FdxCloudStorageFileProgressCallback: TdxCloudStorageFileProgressCallback;
  private
    function ComputerName: string;
  private
    procedure EmptyFolder(const Folder: string);
    procedure DeleteFile(const FileName: string);
    procedure CopyFile(const SrcFileName, DestFileName: string);
  private
    procedure Compress(const FileName, ZipFileName: string);
    procedure CompressFolder(const Folder, ZipFileName: string);
  private
  private
    procedure GDriveDownload(const AFileName, DestFileName: string);
    procedure GDriveUpload(const ATargetPath, AFileName: string; AOverwriteIfExists: boolean = True);
  private
    function CallMethod(Instance: TObject; ClassType: TClass; const MethodName: String; var Params: Variant): Variant;
  private
    // Stato dell'esecuzione da RunFromFile, per la mail di errore.
    // FPosizioneInEsecuzione e' l'ultima istruzione avviata ('riga:colonna'),
    // presa da OnRunLine: ErrorPos di FastScript, quando l'errore nasce dentro
    // una procedura dello script, indica la chiamata nel programma principale
    // e non la riga che ha sbagliato. FChiamataInCorso e' la funzione di
    // GestyScript (ImportFileCandidature, dbBackup...) con i suoi parametri,
    // svuotata quando la funzione finisce bene.
    FScriptFileName: string;
    FUnitInEsecuzione: string;
    FPosizioneInEsecuzione: string;
    FChiamataInCorso: string;
    procedure ScriptRunLine(Sender: TfsScript; const UnitName, SourcePos: String);
    function DescriviChiamata(const MethodName: String; const Params: Variant): string;
    function ContestoErrore: string;
    procedure SegnalaErrore(e: exception);
  public
    constructor Create(aOwner: TComponent); override;

    procedure Init;
    procedure LoadFromFile(const FileName: string);

    procedure RunFromFile(const FileName: String);

    function CompileScript(const Script: string): boolean;
    procedure ExecuteScript(const Script: string); overload;
    procedure ExecuteScript; overload;
    function Evaluate(const variable: string): string;

    procedure TestConnessione;

    property dxCloudStorageFileProgressCallback: TdxCloudStorageFileProgressCallback read FdxCloudStorageFileProgressCallback write FdxCloudStorageFileProgressCallback;
  end;

var
  ScriptModule: TScriptModule;

implementation

uses
  System.IOUtils,
  System.Zip,
  System.StrUtils,
  System.Variants,
  System.DateUtils,
  GestyTools.Log,
  GestyTools.Config,
  GestyTools.Connection,
  GestyTools.GDrive,
  GestyTools.Mail,
  GestyTools.Candidature,
  GestyTools.FTP;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TBackupModule }

constructor TScriptModule.Create(aOwner: TComponent);
begin
  inherited;
  FdxCloudStorageFileProgressCallback := nil;
end;

procedure TScriptModule.Init;
begin
  fsScript.Parent := fsGlobalUnit;

  fsScript.AddMethod('procedure Writeln(s:string)', CallMethod);
  fsScript.AddMethod('procedure Log(s:string)', CallMethod);
  fsScript.AddMethod('function ExtractFileDir(const FileName: string): string', CallMethod);
  fsScript.AddMethod('function ExtractFileName(const FileName: string): string', CallMethod);
  fsScript.AddMethod('function ChangeFileExt(const FileName, Extension: string): string', CallMethod);
  fsScript.AddMethod('function IncludeTrailingBackslash(const path:string) :string', CallMethod);
  fsScript.AddMethod('procedure EmptyFolder(Folder: string)', CallMethod);
  fsScript.AddMethod('function ForceDirectories(const Dir: string): boolean', CallMethod);
  fsScript.AddMethod('procedure DeleteFile(const FileName: string)', CallMethod);
  fsScript.AddMethod('procedure CopyFile(const SrcFileName, DestFileName: string)', CallMethod);
  fsScript.AddMethod('procedure Compress(const FileName, ZipFileName: string)', CallMethod);
  fsScript.AddMethod('procedure CompressFolder(const Folder, ZipFileName: string)', CallMethod);

  fsScript.AddMethod('procedure dbConnect;', CallMethod);
  fsScript.AddMethod('procedure dbDisconnect;', CallMethod);
  fsScript.AddMethod('procedure dbBackup(const FilenameFbk: string)', CallMethod);
  fsScript.AddMethod('procedure dbRestore(const FilenameFbk, FileNameFdb: string)', CallMethod);

  fsScript.AddMethod('function LoadFile(const FileName: string): string', CallMethod);

  fsScript.AddMethod
    ('procedure SP(StoredProcName: string; param0:string=''; param1:string=''; param2:string=''; param3: string = ''; param4: string = ''; param5: string = ''; param6: string = ''; param7: string = ''; param8: string = ''; param9: string = '')',
    CallMethod);

  fsScript.AddMethod
    ('procedure ExecSP(StoredProcName: string; param0:string=''; param1:string=''; param2:string=''; param3: string = ''; param4: string = ''; param5: string = ''; param6: string = ''; param7: string = ''; param8: string = ''; param9: string = '')',
    CallMethod);

  fsScript.AddMethod('procedure GDriveDownload(const AFileName, DestFileName: string);', CallMethod);
  fsScript.AddMethod('procedure GDriveUpload(const ATargetPath, AFileName: string; AOverwriteIfExists: boolean = True);', CallMethod);
  fsScript.AddMethod('procedure TestConnessione;', CallMethod);

  // AddEnum('TFontPitch', 'fpDefault, fpFixed, fpVariable')
  fsScript.AddEnum('TImportCandidatureType', 'icCSV, icXlsx');
  fsScript.AddMethod('procedure ImportFileCandidature(const url: string; ImportType: TImportCandidatureType; const MapFileName: string = '');', CallMethod);

  fsScript.AddMethod('procedure FtpConnect;', CallMethod);
  fsScript.AddMethod('procedure FtpDisconnect;', CallMethod);
  fsScript.AddMethod('function FtpRemoteFileExists(const FileName: string): boolean;', CallMethod);
  fsScript.AddMethod('procedure FtpChangeDir(folder: string);', CallMethod);
  fsScript.AddMethod('procedure FtpListFiles(Files: TStrings);', CallMethod);
  fsScript.AddMethod('procedure FtpDownload(const SrcFileName, DestFileName: string);', CallMethod);
  fsScript.AddMethod('procedure FtpUpload(const SrcFileName, DestFileName: string);', CallMethod);
end;

procedure TScriptModule.RunFromFile(const FileName: String);
begin
  FScriptFileName := FileName;
  FUnitInEsecuzione := '';
  FPosizioneInEsecuzione := '';
  FChiamataInCorso := '';

  try
    LoadFromFile(FileName);

    // solo qui e non in Init: l'editor degli script usa OnRunLine per
    // l'esecuzione passo passo e lo imposta da se'
    fsScript.OnRunLine := ScriptRunLine;

    if fsScript.Compile then
      fsScript.Execute
    else if fsScript.ErrorUnit = '' then
      raise exception.Create('Compilazione dello script non riuscita, posizione ' + fsScript.ErrorPos + ': ' + fsScript.ErrorMsg)
    else
      raise exception.Create('Compilazione dello script non riuscita, ' + fsScript.ErrorUnit + ' posizione ' + fsScript.ErrorPos + ': ' + fsScript.ErrorMsg);
  except
    on e: exception do
    begin
      SegnalaErrore(e);
      raise;
    end;
  end;
end;

procedure TScriptModule.SegnalaErrore(e: exception);
begin
  // un errore nell'invio della mail (SMTP irraggiungibile, TLS) non deve
  // prendere il posto di quello dello script: prima sostituiva l'errore vero
  // anche nel .log di GestyScript
  try
    Mail.SegnalaEccezione(e, ContestoErrore);
  except
    on ErroreMail: exception do
    begin
      Log.ToScreen('Invio della mail di errore non riuscito: ' + ErroreMail.ClassName + ': ' + ErroreMail.Message);
      Log.ToFile('Invio della mail di errore non riuscito: ' + ErroreMail.ClassName + ': ' + ErroreMail.Message);
    end;
  end;
end;

procedure TScriptModule.ScriptRunLine(Sender: TfsScript; const UnitName, SourcePos: String);
begin
  FUnitInEsecuzione := UnitName;
  FPosizioneInEsecuzione := SourcePos;
end;

function TScriptModule.DescriviChiamata(const MethodName: String; const Params: Variant): string;
var
  Indice: integer;
begin
  result := MethodName + '(';
  try
    if VarIsArray(Params) then
      for Indice := VarArrayLowBound(Params, 1) to VarArrayHighBound(Params, 1) do
      begin
        if Indice > VarArrayLowBound(Params, 1) then
          result := result + ', ';
        result := result + QuotedStr(VarToStrDef(Params[Indice], ''));
      end;
  except
    // solo descrittivo: un parametro non convertibile non deve fermare lo script
    result := result + '...';
  end;
  result := result + ')';
end;

function TScriptModule.ContestoErrore: string;
var
  Righe: TStringList;
  NumeroRiga: integer;
begin
  Righe := TStringList.Create;
  try
    Righe.Add('Script: ' + FScriptFileName);

    if not FPosizioneInEsecuzione.IsEmpty then
    begin
      if FUnitInEsecuzione.IsEmpty then
        Righe.Add('Ultima istruzione avviata: posizione ' + FPosizioneInEsecuzione)
      else
        Righe.Add('Ultima istruzione avviata: ' + FUnitInEsecuzione + ' posizione ' + FPosizioneInEsecuzione);

      // il testo della riga si ha solo per il sorgente principale: per le unit
      // incluse FastScript non espone il sorgente
      NumeroRiga := StrToIntDef(Copy(FPosizioneInEsecuzione, 1, Pos(':', FPosizioneInEsecuzione) - 1), 0);
      if FUnitInEsecuzione.IsEmpty and (NumeroRiga > 0) and (NumeroRiga <= fsScript.Lines.Count) then
        Righe.Add('Testo della riga: ' + fsScript.Lines[NumeroRiga - 1].Trim);
    end;

    if not FChiamataInCorso.IsEmpty then
      Righe.Add('Funzione in corso: ' + FChiamataInCorso);

    result := Righe.Text;
  finally
    FreeAndNil(Righe);
  end;
end;

procedure TScriptModule.TestConnessione;
begin
  Log.ToScreen('TestConnessione');
  Connection.Connect;
  Log.ToScreen('Connesso');
  Connection.Disconnect;
  Log.ToScreen('Disconnesso');
end;

function TScriptModule.CallMethod(Instance: TObject; ClassType: TClass; const MethodName: String; var Params: Variant): Variant;

  function IndexStr(const AText: string; const AValues: array of string): integer;
  var
    I: integer;
  begin
    result := -1;
    for I := Low(AValues) to High(AValues) do
      if SameText(AText, AValues[I]) then
      begin
        result := I;
        Break;
      end;
  end;

const
  Methods: TArray<String> = ['EmptyFolder', 'DeleteFile', 'CopyFile', 'Compress', 'CompressFolder', 'dbBackup', 'dbRestore', 'IncludeTrailingBackslash', 'ChangeFileExt', 'ExtractFileDir',
    'ExtractFileName', 'Writeln', 'SP', 'ExecSP', 'LoadFile', 'dbConnect', 'dbDisconnect', 'ImportFileCandidature', 'GDriveDownload', 'GDriveUpload', 'Log', 'TestConnessione', 'FtpConnect',
    'FtpDisconnect', 'FtpRemoteFileExists', 'FtpChangeDir', 'FtpListFiles', 'FtpDownload', 'FtpUpload', 'ForceDirectories'];
begin

  // Writeln e Log sono chiamate innocue e frequentissime: non coprono la
  // funzione che stava davvero lavorando
  if IndexStr(MethodName, ['Writeln', 'Log']) < 0 then
    FChiamataInCorso := DescriviChiamata(MethodName, Params);

  case IndexStr(MethodName, Methods) of
    0:
      EmptyFolder(Params[0]);
    1:
      DeleteFile(Params[0]);
    2:
      CopyFile(Params[0], Params[1]);
    3:
      Compress(Params[0], Params[1]);
    4:
      CompressFolder(Params[0], Params[1]);
    5:
      Connection.Backup(Params[0]);
    6:
      Connection.Restore(Params[0], Params[1]);
    7:
      result := IncludeTrailingBackslash(Params[0]);
    8:
      result := ChangeFileExt(Params[0], Params[1]);
    9:
      result := ExtractFileDir(Params[0]);
    10:
      result := ExtractFileName(Params[0]);
    11:
      Log.ToScreen(Params[0]);
    12:
      Connection.ExecStoredProc(Params);
    13:
      Connection.ExecStoredProc(Params);
    14:
      result := TFile.ReadAllText(Params[0]);
    15:
      Connection.Connect;
    16:
      Connection.Disconnect;
    17:
      ImportCandidature.ImportFile(Params[0], Params[1], Params[2]);
    18:
      GDriveDownload(Params[0], Params[1]);
    19:
      GDriveUpload(Params[0], Params[1], Params[2]);
    20:
      Log.ToScreen(Params[0]);
    21:
      TestConnessione;
    22:
      FTP.Connect;
    23:
      FTP.Disconnect;
    24:
      result := FTP.RemoteFileExists(Params[0]);
    25:
      FTP.ChangeDir(Params[0]);
    26:
      ; // FTP.ListFiles(Params[0]);
    27:
      FTP.Download(Params[0], Params[1]);
    28:
      FTP.Upload(Params[0], Params[1]);
    29:
      // crea la cartella e le intermedie mancanti; True anche se esisteva gia'
      result := ForceDirectories(Params[0]);
  end;

  // finita bene: se l'errore viene dopo, non e' colpa di questa funzione
  FChiamataInCorso := '';
end;

procedure TScriptModule.CopyFile(const SrcFileName, DestFileName: string);
begin

  if not TFile.Exists(SrcFileName) then
    raise exception.Create('CopyFile: file sorgente non trovato: ' + SrcFileName)
  else
    TFile.Copy(SrcFileName, DestFileName);
end;

procedure TScriptModule.DeleteFile(const FileName: string);
begin
  if not TFile.Exists(FileName) then
    raise exception.Create('DeleteFile: file sorgente non trovato: ' + FileName)
  else
    TFile.Delete(FileName);
end;

procedure TScriptModule.EmptyFolder(const Folder: string);
var
  FileName: string;
begin

  for FileName in TDirectory.GetFiles(Folder, '*.*') do
    TFile.Delete(FileName);
end;

procedure TScriptModule.Compress(const FileName, ZipFileName: string);
var
  Zip: TZipFile;
begin
  Zip := TZipFile.Create;
  try
    Zip.Open(ZipFileName, zmWrite);

    Zip.Add(FileName, ExtractFileName(FileName), zcDeflate);
  finally
    FreeAndNil(Zip);
  end;
end;

procedure TScriptModule.CompressFolder(const Folder, ZipFileName: string);
var
  Zip: TZipFile;
  FileName: string;
begin

  TZipFile.ZipDirectoryContents(ZipFileName, Folder);

  Exit;

  Zip := TZipFile.Create;
  try
    Zip.Open(ZipFileName, zmWrite);

    for FileName in TDirectory.GetFiles(Folder, '*.*') do
      Zip.Add(FileName, FileName, zcDeflate);
    // Zip.Add(FileName, ExtractFileName(FileName), zcDeflate);
  finally
    FreeAndNil(Zip);
  end;
end;

function TScriptModule.ComputerName: string;
var
  cresult: string;
  pw: Pchar;
  pwSize: cardinal;
begin
  GetMem(pw, 300);
  pwSize := 300;
  try
    if GetComputerName(Pchar(pw), pwSize) then
    begin
      cresult := StrPas(pw);
    end;
  finally
    FreeMem(pw, 300);
  end;
  result := uppercase(cresult);
end;

procedure TScriptModule.GDriveDownload(const AFileName, DestFileName: string);
begin
  GDrive.DownloadFile(AFileName, DestFileName, dxCloudStorageFileProgressCallback);
end;

procedure TScriptModule.GDriveUpload(const ATargetPath, AFileName: string; AOverwriteIfExists: boolean);
begin
  GDrive.UploadFile(ATargetPath, AFileName, dxCloudStorageFileProgressCallback, AOverwriteIfExists);
end;

procedure TScriptModule.LoadFromFile(const FileName: string);
begin
  fsScript.Clear;
  fsScript.Lines.LoadFromFile(FileName);
  Init;
end;

function TScriptModule.CompileScript(const Script: string): boolean;
begin
  fsScript.Clear;
  fsScript.Lines.Text := Script;
  Init;
  result := fsScript.Compile;
end;

procedure TScriptModule.ExecuteScript(const Script: string);
begin

  if CompileScript(Script) then
    ExecuteScript;
end;

procedure TScriptModule.ExecuteScript;
begin
  // da editor
  fsScript.Execute;
end;

function TScriptModule.Evaluate(const variable: string): string;
var
  v: Variant;
begin
  result := '';

  v := fsScript.Evaluate(variable);

  if not VarIsNull(v) then
    if not VarIsEmpty(v) then
      result := VarToStr(v);
end;

procedure TScriptModule.FDConnectionBeforeConnect(Sender: TObject);
begin
  SiMain.EnterMethod(Self, 'FDConnectionBeforeConnect');

  SiMain.LogVerbose('test');

  SiMain.LeaveMethod(Self, 'FDConnectionBeforeConnect');
end;

end.
