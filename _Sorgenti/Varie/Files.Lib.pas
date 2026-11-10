unit Files.Lib;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Dialogs,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Data.DB,
  zFbDataSet,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

procedure CopiaFilePdf(const SrcFileName, DstFileName: string);
function FilePdfExists(const FileName: string): Boolean;

function GetOID(DataSet: TDataSet; const FieldName: string = ''): integer;
function ImportObjFile(OID: integer; DataSet: TDataSet; const FileName: string; WriteTransaction: TzFbTransaction = nil; const doCommit: Boolean = True; const silent: Boolean = false; const TipologiaDocumentale: string = ''): integer;

function ExtractTextFromPDF(const FileName: string): string;

// Template
function GetTemplate(const Folder: string): string;

function CreateFolder(const Folder: string; const raiseException: Boolean): Boolean;

implementation

uses
  Winapi.Windows,
  Winapi.ShlObj,
  System.IOUtils,
  System.Hash,
  zBaseLib,
  Gesty_StoredProcs,
  zMsg,
  Files.ImportErrors,
  zz.Files,
  zOffice.Ocr,
  zOffice.Pdf.Utils,
  zOffice.types;

function GetFileSHA256(const AFileName: string): string;
begin
  // Controlla prima se il file esiste per evitare eccezioni di IO
  if TFile.Exists(AFileName) then
    Result := THashSHA2.GetHashStringFromFile(AFileName, THashSHA2.TSHA2Version.SHA256)
  else
    raise EFileNotFoundException.CreateFmt('File non trovato: %s', [AFileName]);
end;

procedure CopiaFilePdf(const SrcFileName, DstFileName: string);
begin
  // il file da copiare
  if not FileExists(SrcFileName) then
    raise zException.Create('File sorgente non trovato: ' + SrcFileName);

  if DstFileName = '' then
    raise zException.Create('File destinazione non specificato. (Campo nome file)');

  //
  CreateFolder(ExtractFilePath(DstFileName), True);

  TFile.Copy(SrcFileName, DstFileName, True);

  // verifica
  if not TFile.Exists(DstFileName) then
    raise zException.Create('Errore nella copia fisica del file ' + DstFileName);
end;

function FilePdfExists(const FileName: string): Boolean;
begin
  if FileName = '' then
    Result := false
  else
    Result := TFile.Exists(FileName);
end;

function GetTemplate(const Folder: string): string;
var
  Templates: TzFiles;
  Files: TStringList;
  s: String;
begin
  Result := '';

  Templates := TzFiles.Create('PDFTemplates');
  try
    Templates.AddFolder(Folder, '*.pdf');

    Files := TStringList.Create;
    try
      Templates.GetFileNames(Files, True);

      s := '';
      if not InputCombo('Template', 'Template', s, Files) then
        Exit;
    finally
      FreeAndNil(Files);
    end;

    Result := Templates.GetFullFileName(s);
  finally
    FreeAndNil(Templates);
  end;
end;

// Estrazione del testo di un PDF: prima il livello di testo, poi - se il file e'
// una scansione - l'OCR. Entrambi i passi sono in zOffice.Ocr, che rende le
// pagine con il motore PDF DevExpress e non usa piu' la libreria Envision
// (EnImgScr / EnOcrEng / EnConsoleOcr).
function ExtractTextFromPDF(const FileName: string): string;
begin
  siMain.EnterMethod('ExtractTextFromPDF');
  siMain.LogString('FileName', FileName);

  Result := '';

  if not TFile.Exists(FileName) then
  begin
    siMain.LogVerbose('File non trovato: ' + FileName);
    Result := 'File non trovato: ' + FileName;
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    Result := TzOcr.EstraiTestoDaPdf(FileName);
  finally
    Screen.Cursor := crDefault;
  end;

  siMain.LogString('Result', Result);
  siMain.LeaveMethod('ExtractTextFromPDF');
end;

function CreateFolder(const Folder: string; const raiseException: Boolean): Boolean;
const
  // Mantis #88 - 2026-09-04: numero di ripetizioni e attesa fra un tentativo
  // e l'altro in caso di cartella di rete non ancora raggiungibile
  NUMERO_TENTATIVI_VERIFICA = 3;
  ATTESA_FRA_TENTATIVI_MS = 300;
var
  msg: string;
  ResultCode: HRESULT;
  psa: SECURITY_ATTRIBUTES;
  Tentativo: integer;
  CartellaRaggiungibile: Boolean;
begin
  psa.nLength := 0;
  psa.lpSecurityDescriptor := nil;
  psa.bInheritHandle := false;

  ResultCode := SHCreateDirectoryExW(0, PChar(Folder), psa);

  Result := ResultCode in [ERROR_SUCCESS, ERROR_FILE_EXISTS, ERROR_ALREADY_EXISTS];

  // Mantis #88 - 2026-09-04: su un percorso di rete UNC, SHCreateDirectoryExW puo'
  // restituire esito positivo senza che la cartella sia davvero raggiungibile un
  // istante dopo (condizione SMB transitoria). Si verifica con DirectoryExists e,
  // se non ancora visibile, si ripete la creazione prima di arrendersi: senza
  // questo controllo l'errore emerge piu' avanti, nella TFile.Copy successiva,
  // con un messaggio generico che non indica la vera causa.
  if Result then
  begin
    CartellaRaggiungibile := DirectoryExists(Folder);

    Tentativo := 0;
    while (not CartellaRaggiungibile) and (Tentativo < NUMERO_TENTATIVI_VERIFICA) do
    begin
      Inc(Tentativo);
      Sleep(ATTESA_FRA_TENTATIVI_MS);
      SHCreateDirectoryExW(0, PChar(Folder), psa);
      CartellaRaggiungibile := DirectoryExists(Folder);
    end;

    Result := CartellaRaggiungibile;
  end;

  if not Result then
    if raiseException then
    begin
      case ResultCode of
        ERROR_ACCESS_DENIED:
          msg := 'Accesso negato.';
        ERROR_BAD_PATHNAME:
          msg := 'Impossibile usare un percorso relativo.';
        ERROR_FILENAME_EXCED_RANGE:
          msg := 'Percorso troppo lungo.';
        ERROR_CANCELLED:
          msg := 'L''utente ha annullato l''operazione,';
        ERROR_INVALID_NAME:
          msg := 'Nome percorso non valido.';
        ERROR_BAD_NET_NAME:
          msg := 'Percorso di rete non valido.';
      else
        if ResultCode in [ERROR_SUCCESS, ERROR_FILE_EXISTS, ERROR_ALREADY_EXISTS] then
          // Mantis #88 - 2026-09-04: creazione segnalata come riuscita ma cartella
          // di rete non raggiungibile dopo i tentativi di verifica
          msg := 'La cartella risulta creata ma non e'' raggiungibile sulla rete (percorso non stabile).'
        else
          msg := 'Errore generico (' + IntToStr(ResultCode) + ')';
      end;
      raise Exception.Create('Errore crezione cartella:' + sLineBreak + sLineBreak + Folder + sLineBreak + sLineBreak + msg);
    end;
end;

function GetOID(DataSet: TDataSet; const FieldName: string = ''): integer;
var
  field: TField;
  Master: TDataSet;
  zFbDataSet: TzFbDataSet;
begin
  Result := -1;

  if Assigned(DataSet) then
    if Assigned(DataSet.DataSource) then
      if Assigned(DataSet.DataSource.DataSet) then
      begin
        Master := DataSet.DataSource.DataSet;

        if Master.State = dsInsert then
        begin
          Master.Post;
          Master.Edit;

          if DataSet is TzFbDataSet then
            TzFbDataSet(DataSet).LoadParamsFromMaster;
        end;

        if Master.IsEmpty then
          raise Exception.Create('E''necessario compilare prima la tabella ' + Master.Name + '.');

        if FieldName <> '' then
        begin
          field := Master.FindField(FieldName);
          if Assigned(field) then
            if not field.IsNull then
            begin
              Result := field.AsInteger;
              Exit;
            end;
        end;
      end;

  /// ////////////////////////////////////////////////////////
  /// tramite FieldName su dataset
  if FieldName <> '' then
    if Assigned(DataSet) then
    begin

      field := DataSet.FindField(FieldName);
      if Assigned(field) then
        if not field.IsNull then
        begin
          Result := field.AsInteger;
          Exit;
        end;
    end;

  /// ////////////////////////////////////////////////////////
  /// tramite Params
  if DataSet is TzFbDataSet then
  begin
    zFbDataSet := TzFbDataSet(DataSet);

    if zFbDataSet.Params.Count > 0 then
    begin
      Result := zFbDataSet.Params[0].AsInteger;
      Exit;
    end;
  end;
end;

function ImportObjFile(OID: integer; DataSet: TDataSet; const FileName: string; WriteTransaction: TzFbTransaction = nil; const doCommit: Boolean = True; const silent: Boolean = false; const TipologiaDocumentale: string = ''): integer;

  function RegistraFile(const OID: integer; WriteTrans: TzFbTransaction; out Full_File_Name: string): integer;
  var
    spAdd: TSP_obj_Files_Add;
  begin
    Result := -1;
    Full_File_Name := '';

    if not Assigned(WriteTrans) then
      raise Exception.Create('Transazione non assegnata (ImportaFile)');

    spAdd := TSP_obj_Files_Add.Create(WriteTrans);
    try
      spAdd.OID := OID;
      spAdd.Nome_File_Originale := ExtractFileName(FileName);

      if not TipologiaDocumentale.IsEmpty then
        spAdd.Tipologia_Documentale := TipologiaDocumentale;

      if SameText(ExtractFileExt(FileName), '.pdf') then
        spAdd.Testo.Text := ExtractTextFromPDF(FileName);

      spAdd.File_Type := TzFileType.FromFileName(FileName).AsString;
      spAdd.File_Size := TFile.GetSize(FileName);
      spAdd.SHA256 := GetFileSHA256(FileName);

      spAdd.ExecuteWithoutCommit;

      Full_File_Name := spAdd.Full_File_Name;
      Result := spAdd.Id_Object_File;
    finally
      FreeAndNil(spAdd);
    end;
  end;

var
  objFileName: string;
  WriteTrans: TzFbTransaction;
  OversizedFound: Boolean;
  OversizedPageIndex: integer;
  OversizedWidthIn, OversizedHeightIn: Double;
begin
  Result := -1;

  if OID = -1 then
    raise Exception.Create('Import file: OID non specificato.');

  // Protezione contro PDF con pagine dalle dimensioni fisiche anomale (vedi commento sulla
  // costante MaxSanePdfPageSizeInches e Mantis Gesty #26): si rifiuta l'importazione prima di
  // registrare l'allegato, invece di scoprire il problema solo alla successiva visualizzazione.
  if SameText(ExtractFileExt(FileName), '.pdf') then
  begin
    // Mantis #338 - 2026-11-10: distinto errore di apertura file da PDF non valido
    if not TFile.Exists(FileName) then
      raise Exception.Create(MessaggioFileNonRaggiungibile(FileName));

    try
      OversizedFound := FindOversizedPdfPage(FileName, OversizedPageIndex, OversizedWidthIn, OversizedHeightIn);
    except
      on e: Exception do
        raise Exception.Create(MessaggioErroreImportazionePdf(FileName, e));
    end;

    if OversizedFound then
      raise Exception.CreateFmt('Impossibile importare "%s": la pagina %d ha dimensioni anomale (%.0f x %.0f pollici), ' + 'probabilmente per un errore nella generazione del PDF (risoluzione non corretta di un''immagine incorporata). ' +
        'L''importazione e'' stata annullata.', [ExtractFileName(FileName), OversizedPageIndex + 1, OversizedWidthIn, OversizedHeightIn]);
  end;

  /// ///////////////////////////////////////////////////////////////
  WriteTrans := WriteTransaction;

  if not Assigned(WriteTrans) then
    if DataSet is TzFbDataSet then
    begin
      WriteTrans := TzFbDataSet(DataSet).UpdateTransaction as TzFbTransaction;

      if not Assigned(WriteTrans) then
        WriteTrans := TzFbDataSet(DataSet).Transaction as TzFbTransaction;
    end;

  if not Assigned(WriteTrans) then
    raise Exception.Create('Import file: transazione non assegnata.');

  /// ///////////////////

  if not silent then
    StartWait('Attendere...', True);
  try

    if doCommit and not WriteTrans.Active then
      WriteTrans.StartTransaction;
    try
      // Registra nel database senza effettuare il commit immediato
      Result := RegistraFile(OID, WriteTrans, objFileName);

      // Copia fisica del file nel file system
      CopiaFilePdf(FileName, objFileName);

      // Se la copia va a buon fine ed è richiesto il commit, lo effettua ora
      if doCommit then
        if Assigned(WriteTrans) and WriteTrans.Active then
          WriteTrans.Commit;

      if DataSet is TzFbDataSet then
        TzFbDataSet(DataSet).ReOpen(True);
    except
      on e: Exception do
      begin
        // Se si verifica un errore durante la copia o altrove e dovevamo fare il commit, esegue il rollback
        if doCommit then
          if Assigned(WriteTrans) and WriteTrans.Active then
            WriteTrans.Rollback;
        raise;
      end;
    end;
  finally
    if not silent then
      StopWait;
  end
end;

end.
