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
    function DescriviFileScaricato(const FileName, TipoContenuto: string): string;
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
  System.Zip,
  QImport3Common,
  GestyTools.Log,
  GestyTools.Config,
  GestyTools.Connection,
  GestyTools.Mail;

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

const
  // Tempi e tentativi dello scaricamento di file e allegati delle candidature.
  // Fissi nel codice e non nella configurazione .lz_cfg: servono a reggere un
  // server lento, non a essere regolati cliente per cliente
  TempoMassimoConnessione = 30000;
  TempoMassimoRisposta = 180000;
  TentativiScaricamento = 3;
  PausaFraTentativi = 5000;

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
  Risposta: IHTTPResponse;
  Tentativo: integer;
  FileTemporaneo: string;
begin
  // il predefinito di 60 secondi sulla risposta non bastava: un server lento
  // fermava tutto l'import con "Error receiving data: (12002)"
  NetHTTPClient.ConnectionTimeout := TempoMassimoConnessione;
  NetHTTPClient.ResponseTimeout := TempoMassimoRisposta;

  // Mantis #245 - 2026-10-15: si scarica in un file accanto alla destinazione e la si
  // sostituisce solo a scaricamento riuscito. Prima fmCreate svuotava la destinazione
  // prima ancora della risposta, e un errore del sito distruggeva la copia gia' in archivio
  FileTemporaneo := DestFileName + '.scaricamento';
  try
    Risposta := nil;
    for Tentativo := 1 to TentativiScaricamento do
    begin
      Log.ToScreen(Format('Scaricamento di %s (tentativo %d di %d)', [url, Tentativo, TentativiScaricamento]));
      try
        FileStream := TFileStream.Create(FileTemporaneo, fmCreate);
        try
          Risposta := NetHTTPClient.Get(url, FileStream);
        finally
          FreeAndNil(FileStream);
        end;
        Break;
      except
        // errori di rete (tempo scaduto, connessione rifiutata o interrotta):
        // possono essere passeggeri, si riprova. Gli altri errori salgono subito
        on E: ENetException do
        begin
          Log.ToScreen(Format('Scaricamento di %s non riuscito: %s: %s', [url, E.ClassName, E.Message]));

          if Tentativo = TentativiScaricamento then
            Exception.RaiseOuterException(Exception.CreateFmt('Scaricamento di %s non riuscito dopo %d tentativi (tempo massimo di risposta %d secondi)',
              [url, TentativiScaricamento, TempoMassimoRisposta div 1000]));

          Sleep(PausaFraTentativi);
        end;
      end;
    end;

    // prima una risposta di errore (pagina di accesso, 403, 404) veniva salvata
    // come se fosse il file, e l'import si fermava piu' avanti con un errore
    // che non diceva cosa era arrivato ("Error reading zip file")
    if (Risposta.StatusCode < 200) or (Risposta.StatusCode > 299) then
      raise Exception.CreateFmt('Scaricamento di %s: il server ha risposto %d %s. %s', [url, Risposta.StatusCode, Risposta.StatusText,
        DescriviFileScaricato(FileTemporaneo, Risposta.MimeType)]);

    Log.ToScreen(Format('Scaricato %s: %s', [url, DescriviFileScaricato(FileTemporaneo, Risposta.MimeType)]));

    if TFile.Exists(DestFileName) then
      TFile.Delete(DestFileName);
    TFile.Move(FileTemporaneo, DestFileName);
  finally
    // resta solo se lo scaricamento non e' riuscito: non deve passare per un allegato
    if TFile.Exists(FileTemporaneo) then
      try
        TFile.Delete(FileTemporaneo);
      except
        on E: Exception do
          Log.ToScreen(Format('File temporaneo %s non cancellato: %s', [FileTemporaneo, E.Message]));
      end;
  end;

  result := True;
end;

function TImportCandidature.DescriviFileScaricato(const FileName, TipoContenuto: string): string;
const
  CaratteriMostrati = 200;
var
  FileStream: TFileStream;
  Contenuto: TBytes;
  Inizio: string;
  Dimensione: Int64;
  Indice: integer;
begin
  try
    // i primi caratteri dicono subito cosa e' arrivato: "<!DOCTYPE html" e'
    // una pagina web, "PK" e' uno zip (xlsx), il resto di solito testo.
    // Letti dal flusso e non con ReadAllBytes: gli allegati possono pesare
    FileStream := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    try
      Dimensione := FileStream.Size;
      if Dimensione > CaratteriMostrati then
        SetLength(Contenuto, CaratteriMostrati)
      else
        SetLength(Contenuto, Dimensione);
      if Length(Contenuto) > 0 then
        FileStream.ReadBuffer(Contenuto, Length(Contenuto));
    finally
      FreeAndNil(FileStream);
    end;

    Inizio := TEncoding.ANSI.GetString(Contenuto);
    for Indice := 1 to Length(Inizio) do
      if Inizio[Indice] < ' ' then
        Inizio[Indice] := ' ';

    result := Format('%d byte, inizio: %s', [Dimensione, Inizio.Trim]);
  except
    on E: Exception do
      result := Format('File non leggibile (%s)', [E.Message]);
  end;

  if not TipoContenuto.IsEmpty then
    result := Format('Tipo di contenuto "%s", %s', [TipoContenuto, result]);
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
      // un xlsx e' un archivio zip: se non lo e', l'import di EMS si ferma con
      // "Error reading zip file" senza dire cosa ha ricevuto
      if not TZipFile.IsValid(tmpFileName) then
        raise Exception.CreateFmt('Il file delle candidature %s non e'' un xlsx valido. %s', [url, DescriviFileScaricato(tmpFileName, '')]);

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
    // Mantis #245 - 2026-10-15: se lo scaricamento non riesce il file non c'e' piu'
    // (DownloadFile scrive in un temporaneo suo)
    if TFile.Exists(tmpFileName) then
      TFile.Delete(tmpFileName);
  end;
end;

procedure TImportCandidature.SpostaAllegati(const IdFileCandidature: integer);

  // un file vuoto e' un allegato mai arrivato: le versioni precedenti salvavano
  // come allegato anche la risposta vuota di un errore del sito
  function AllegatoPresente(const FileName: string): boolean;
  begin
    result := TFile.Exists(FileName) and (TFile.GetSize(FileName) > 0);
  end;

var
  FilesNonTrovati: TStringList;
  src, dest, folder: string;
  MotivoMancato: string;
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
        idCandidatura := CandidatureAllegatiID_CANDIDATURA.AsInteger;
        src := CandidatureAllegatiFILE_NAME_DA_IMPORT.AsString;
        dest := CandidatureAllegatiFULL_FILE_NAME.AsString;

        // Mantis #245 - 2026-10-15: si scarica solo l'allegato che manca. Prima a ogni
        // import si riscaricavano tutti gli allegati delle candidature presenti nel file
        // (circa 600 ogni notte), e un documento che il sito non serviva piu' andava perso
        // anche se era gia' in archivio. Un documento nuovo portato da una nuova
        // registrazione e' una versione nuova dell'allegato, con un file suo che qui non
        // esiste ancora
        if not AllegatoPresente(dest) then
        begin
          folder := TPath.GetDirectoryName(dest);
          if not TDirectory.Exists(folder) then
            TDirectory.CreateDirectory(folder);

          MotivoMancato := '';
          if src.StartsWith('http', True) or src.StartsWith('www', True) then
          begin
            // Un allegato che non si scarica, anche dopo i tentativi, finisce
            // nell'elenco dei file non copiati invece di fermare l'import: le
            // candidature sono gia' registrate da CANDIDATURE_IMPORT, e
            // fermarsi qui lasciava senza allegati anche tutte le successive.
            // DownloadFile non tocca la destinazione se lo scaricamento non riesce
            try
              DownloadFile(src, dest);
            except
              on E: Exception do
              begin
                MotivoMancato := E.Message;
                Log.ToScreen('Allegato della candidatura ' + idCandidatura.ToString + ' non scaricato: ' + E.Message);
              end;
            end;
          end
          else
            // la destinazione manca o e' vuota: si sovrascrive
            TFile.Copy(src, dest, True);

          if not AllegatoPresente(dest) then
          begin
            if MotivoMancato.IsEmpty then
              FilesNonTrovati.AddPair('Candidatura ' + idCandidatura.ToString, src)
            else
              FilesNonTrovati.AddPair('Candidatura ' + idCandidatura.ToString, src + ' - ' + MotivoMancato);
          end;
        end;

        CandidatureAllegati.Next;
      end;

    finally
      CandidatureAllegati.Active := False;
    end;

    if FilesNonTrovati.Count > 0 then
    begin
      FilesNonTrovati.Insert(0, 'I seguenti file non sono stati copiati: ');
      FilesNonTrovati.Insert(1, '');
      // Mantis #245 - 2026-10-15: il numero e' quello dell'import; prima era l'allegato
      // letto per ultimo nel ciclo, che non serviva a ritrovare niente
      FilesNonTrovati.SaveToFile(Config.FolderUpdate + 'Errori Import Candidature File ' + IdFileCandidature.ToString + '.txt');

      Mail.InviaMail(Config.Ente + ' - Errori Import Candidature File ' + IdFileCandidature.ToString, FilesNonTrovati.text);
    end;
  finally
    FreeAndNil(FilesNonTrovati);
  end;
end;

end.
