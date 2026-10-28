unit dmCandidature;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Base_DataModule,
  dbMaster,
  zFbDataSet,
   zProgressBox,
  System.Net.HttpClient;

type
  TCandidature = class(TBaseDataModule)
    ProgressBox: TProgressBox;
  private
    procedure SpostaAllegatiAfterImport;
    procedure CopiaAllegato(srcFile, destFile: string);
  public
    //
    function ImportaFile(const FileName: string): integer;
    procedure GeneraRisorsa;
  end;

var
  Candidature: TCandidature;

implementation

uses
  System.IOUtils,
  SmartInspect.Vcl.SiAuto,
  Gesty_StoredProcs,
  zBaseLib,
  zMsg;

{$R *.dfm}
{ TCandidature }

procedure TCandidature.GeneraRisorsa;
var
  Candidature: TzFbDataSet;
  sp: TSP_CANDIDATURE_GENERA_RISORSA;
  idCandidatura: integer;
  IdRisorsa: integer;

  SRC_ALLEGATO_CURRICULUM_VITAE: string;
  DEST_ALLEGATO_CURRICULUM_VITAE: string;
  SRC_ALLEGATO_CV_ANONIMO: string;
  DEST_ALLEGATO_CV_ANONIMO: string;
  SRC_ALLEGATO_CARTA_IDENTITA: string;
  DEST_ALLEGATO_CARTA_IDENTITA: string;
  SRC_ALLEGATO_CODICE_FISCALE: string;
  DEST_ALLEGATO_CODICE_FISCALE: string;
begin
  Candidature := GetDataSet('Candidature');

  if Candidature.IsEmpty then
    exit;

  if not Candidature.FieldByName('ID_PERSONALE').IsNull then
  begin
    ConfirmOk('Risorsa già generata per la candidatura.');
    exit;
  end;

  idCandidatura := Candidature.FieldByName('ID_CANDIDATURA').AsInteger;

  if not ConfirmYesNo('Si desidera generare la scheda risorsa per la candidatura selezionata?', mtWarning) then
    exit;

  StartWait('Attendere...', True);
  try
    sp := TSP_CANDIDATURE_GENERA_RISORSA.Create(WriteTrans);
    try
      sp.id_Candidatura := idCandidatura;
      sp.ExecuteAndCommit;
      SRC_ALLEGATO_CURRICULUM_VITAE := sp.SRC_ALLEGATO_CURRICULUM_VITAE;
      DEST_ALLEGATO_CURRICULUM_VITAE := sp.DEST_ALLEGATO_CURRICULUM_VITAE;
      SRC_ALLEGATO_CV_ANONIMO := sp.SRC_ALLEGATO_CV_ANONIMO;
      DEST_ALLEGATO_CV_ANONIMO := sp.DEST_ALLEGATO_CV_ANONIMO;
      SRC_ALLEGATO_CARTA_IDENTITA := sp.SRC_ALLEGATO_CARTA_IDENTITA;
      DEST_ALLEGATO_CARTA_IDENTITA := sp.DEST_ALLEGATO_CARTA_IDENTITA;
      SRC_ALLEGATO_CODICE_FISCALE := sp.SRC_ALLEGATO_CODICE_FISCALE;
      DEST_ALLEGATO_CODICE_FISCALE := sp.DEST_ALLEGATO_CODICE_FISCALE;
    finally
      FreeAndNil(sp);
    end;

    CopiaAllegato(SRC_ALLEGATO_CURRICULUM_VITAE, DEST_ALLEGATO_CURRICULUM_VITAE);
    CopiaAllegato(SRC_ALLEGATO_CV_ANONIMO, DEST_ALLEGATO_CV_ANONIMO);
    CopiaAllegato(SRC_ALLEGATO_CARTA_IDENTITA, DEST_ALLEGATO_CARTA_IDENTITA);
    CopiaAllegato(SRC_ALLEGATO_CODICE_FISCALE, DEST_ALLEGATO_CODICE_FISCALE);

    Candidature.RefreshRecord(false);
  finally
    StopWait;
  end;
end;

procedure TCandidature.CopiaAllegato(srcFile, destFile: string);
begin

  if not srcFile.IsEmpty then
    if not destFile.IsEmpty then
    begin
      ForceDirectories(ExtractFilePath(destFile));
      TFile.Copy(srcFile, destFile);
    end;
end;

function TCandidature.ImportaFile(const FileName: string): integer;
var
  sp: TSP_CANDIDATURE_FILES_ADD;
  CandidatureFiles: TzFbDataSet;
begin
  result := -1;

  StartWait('Attendere...', True);
  try
    sp := TSP_CANDIDATURE_FILES_ADD.Create(WriteTrans);
    try
      sp.Nome_File := ExtractFileName(FileName);
      sp.File_Originale.loadFromFile(FileName);
      sp.ExecuteAndCommit;
      result := sp.ID_FILE_CANDIDATURE;
    finally
      FreeAndNil(sp);
    end;

    CandidatureFiles := GetDataSet('Candidature_Files');
    CandidatureFiles.ReOpen();
    CandidatureFiles.Locate('ID_FILE_CANDIDATURE', result, []);
    SpostaAllegatiAfterImport;
    ReopenDataSet('Candidature');
  finally
    StopWait;
  end;
end;

procedure TCandidature.SpostaAllegatiAfterImport;

  procedure download(src, dest: string);
  var
    FileStream: TStream;
    HttpClient: THTTPClient;
    Risposta: IHTTPResponse;
    FileTemporaneo: string;
  begin
    // Mantis #245 - 2026-10-28: si scarica in un file accanto alla destinazione e la si sostituisce
    // solo se il sito risponde 2xx. Prima il corpo della risposta andava direttamente sulla
    // destinazione, e una risposta di errore lasciava al posto del documento la pagina di errore.
    FileTemporaneo := dest + '.scaricamento';
    try
      FileStream := TFileStream.Create(FileTemporaneo, fmCreate);
      try
        HttpClient := THTTPClient.Create;
        try
          Risposta := HttpClient.Get(src, FileStream);
        finally
          FreeAndNil(HttpClient);
        end;
      finally
        FreeAndNil(FileStream);
      end;

      if (Risposta.StatusCode < 200) or (Risposta.StatusCode > 299) then
        raise Exception.CreateFmt('Errore HTTP %d nello scarico di %s', [Risposta.StatusCode, src]);

      TFile.Copy(FileTemporaneo, dest, True);
    finally
      if TFile.Exists(FileTemporaneo) then
        TFile.Delete(FileTemporaneo);
    end;
  end;

var
  Allegati: TzFbDataSet;
  FilesNonTrovati: TStringList;
  src, dest, folder: string;
  idFile: integer;
  idCandidatura: integer;
begin
  FilesNonTrovati := TStringList.Create;
  try
    Allegati := GetDataSet('Candidature_Files_Allegati');
    Allegati.DisableControls;
    try
      Allegati.ReOpen();
      Allegati.First;
      while not Allegati.Eof do
      begin
        idFile := Allegati.FieldByName('ID_OBJECT_FILE').AsInteger;
        idCandidatura := Allegati.FieldByName('ID_CANDIDATURA').AsInteger;

        src := Allegati.FieldByName('FILE_NAME_DA_IMPORT').AsString;
        dest := Allegati.FieldByName('FULL_FILE_NAME').AsString;

        folder := TPath.GetDirectoryName(dest);
        if not TDirectory.Exists(folder) then
          TDirectory.CreateDirectory(folder);

        if src.StartsWith('http', True) or src.StartsWith('www', True) then
          download(src, dest)
        else
          TFile.Copy(src, dest);

        if not TFile.Exists(dest) then
          FilesNonTrovati.AddPair('Candidatura ' + idCandidatura.ToString, src);

        Allegati.Next;
      end;

      Allegati.First;
    finally
      Allegati.EnableControls;
    end;

    if FilesNonTrovati.Count > 0 then
    begin
      FilesNonTrovati.Insert(0, 'I seguenti file non sono stati copiati: ');
      FilesNonTrovati.Insert(1, '');
      FilesNonTrovati.SaveToFile(path + 'Errori Import Candidature File ' + idFile.ToString + '.txt');
      ConfirmOk(FilesNonTrovati.Text);
    end;
  finally
    FreeAndNil(FilesNonTrovati);
  end;
end;

end.
