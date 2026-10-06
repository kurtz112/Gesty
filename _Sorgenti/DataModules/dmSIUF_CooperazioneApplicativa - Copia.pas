unit dmSIUF_CooperazioneApplicativa;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  System.NetEncoding,
  System.Net.HttpClient,
  System.Net.URLClient,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  FireDAC.Comp.Client,
  SIUF.CooperazioneApplicativa.Types,
  SIUF.CooperazioneApplicativa.Builder,
  SIUF.CooperazioneApplicativa.Client,
  SIUF.CooperazioneApplicativa.Validator,
  Base_DataModule,
  dbMaster,
  zFbDataSet;

type
  TSIUF_CooperazioneApplicativa = class(TBaseDataModule)
  private
    ctx: TSiufExportContext;
    procedure LoadConfig(idEnte: integer; AmbienteTest: boolean);

    // --- Utilità dump su disco ---
    function TempFilename(const APrefix, ASezione, ATimestamp: string): string;
    procedure ScriviFile(const FileName, Content: string);

    // --- SP di log (SIUF_COOPERAZIONE_APPLICATIVA_INVII_ADD) ---
    // Registra l'invio, sposta i file temp nelle destinazioni restituite dalla SP
    // e valorizza ADestPayload/ADestResponse con le full path finali.
    // Restituisce ID_SIUF_COOPERAZIONE_APPLICATIVA_INVIO.
    function RegistraInvio(APayload: TSiufPayload; const AEsito: TSiufEsito;
      const ATempPayload, ATempResponse: string;
      out ADestPayload, ADestResponse: string): integer;

    // --- Sposta un file in una destinazione (full path) ---
    procedure SpostaFile(const ASource, ADest: string);

    // --- Elabora un singolo chunk ---
    function InviaChunk(APayload: TSiufPayload): TSiufExportEsitoDettaglio;

    // ---
    function Esporta(Dataset: TzFbDataSet): TSiufExportEsito;

    /// Mostra il riepilogo all'utente (da personalizzare)
    procedure MostraRiepilogo(const AEsito: TSiufExportEsito);
  public
    constructor Create(aOwner: TComponent); override;

    function Invia(Dataset: TzFbDataSet; AmbienteTest: boolean): boolean;
  end;

var
  SIUF_CooperazioneApplicativa: TSIUF_CooperazioneApplicativa;

implementation

uses
  System.StrUtils,
  System.IOUtils,
  System.DateUtils,
  Gesty_StoredProcs,
  Files.Lib;

{$R *.dfm}

constructor TSIUF_CooperazioneApplicativa.Create(aOwner: TComponent);
begin
  inherited;

end;

procedure TSIUF_CooperazioneApplicativa.LoadConfig(idEnte: integer; AmbienteTest: boolean);
var
  sp: TSP_SIUF_COOPERAZIONE_APPLICATIVA_CONFIG_GET;
begin
  sp := GetSP<TSP_SIUF_COOPERAZIONE_APPLICATIVA_CONFIG_GET>;
  try
    sp.Id_Ente := idEnte;
    sp.Ambiente_Test := AmbienteTest;
    sp.ExecuteAndCommit;
    //
    ctx.ClientConfig.Url := sp.Url;
    ctx.ClientConfig.IdentificativoEnte := sp.Identificativo_Ente;
    ctx.ClientConfig.Username := sp.Username;
    ctx.ClientConfig.Code := sp.Code;
    ctx.ClientConfig.AmbienteTest := AmbienteTest;
    //
    ctx.idEnte := IdEnte;
    ctx.Ente := sp.Ente;
    //
    ctx.CodiceFiscaleUser := sp.Codice_Fiscale_User;
    ctx.NominativoUser := sp.Nominativo_User;
    ctx.UserId := sp.User_Id;
  finally
    FreeAndNil(sp);
  end;

  if ctx.TempDir.IsEmpty then
    ctx.TempDir := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'SIUF_CooperazioneApplicativa_Log');

  ForceDirectories(ctx.TempDir);
end;

// ---------------------------------------------------------------------------
function TSIUF_CooperazioneApplicativa.TempFilename(const APrefix, ASezione, ATimestamp: string): string;
begin
  // Es.: C:\Temp\SIUF_payload_9675_20251022_143012.json
  Result := TPath.Combine(ctx.TempDir, Format('%s_%s_%s.json', [APrefix, ASezione, ATimestamp]));
end;

procedure TSIUF_CooperazioneApplicativa.ScriviFile(const FileName, Content: string);
var
  SL: TStringList;
begin
  SL := TStringList.Create;
  try
    SL.Text := Content;
    SL.SaveToFile(FileName, TEncoding.UTF8);
  finally
    SL.Free;
  end;
end;

// ---------------------------------------------------------------------------
function TSIUF_CooperazioneApplicativa.RegistraInvio(APayload: TSiufPayload; const AEsito: TSiufEsito;
  const ATempPayload, ATempResponse: string;
  out ADestPayload, ADestResponse: string): integer;
var
  sp: TSP_SIUF_COOPERAZIONE_APPLICATIVA_INVII_ADD;
  Det: TSiufDettaglioErrore;
  FormatSettings: TFormatSettings;
begin
  Result := -1;
  ADestPayload := '';
  ADestResponse := '';
  Det := AEsito.DettaglioErrore;

  FormatSettings := TFormatSettings.Create;
  FormatSettings.DateSeparator := '-';
  FormatSettings.ShortDateFormat := 'yyyy-mm-dd';

  sp := GetSP<TSP_SIUF_COOPERAZIONE_APPLICATIVA_INVII_ADD>;
  try
    sp.Id_Ente := ctx.idEnte;
    sp.User_Id := ctx.UserId;
    sp.Codice_Fiscale_User := ctx.CodiceFiscaleUser;
    sp.ID_SEZIONE := IntToStr(APayload.IdSezione);
    sp.DATA_INIZIO := StrToDate(APayload.DataInizio, FormatSettings);
    sp.DATA_FINE := StrToDate(APayload.DataFine, FormatSettings);
    sp.NUMERO_STUDENTI := APayload.NumeroStudenti;
    sp.ESITO_CARICAMENTO := AEsito.EsitoCaricamento;
    sp.HTTP_STATUS := AEsito.HttpStatus;
    sp.TIPO_ERRORE := AEsito.Tipo.ToString;
    sp.MESSAGGIO.Text := AEsito.MESSAGGIO;
    // Dettaglio errore – campi SIUF_COOPERAZIONE_APPLICATIVA_SOGGETTO / TEXT
    sp.ERR_STUDENTE := Det.Studente;
    sp.ERR_SEZIONE := Det.Sezione;
    sp.ERR_DOCENTE := Det.DocenteCoDocente;
    sp.ERR_CORSO_LEZIONE := Det.CorsoLezione;
    sp.ERR_DATA := Det.Data;
    // Nomi-file (solo nome): la SP ricostruisce le full path di destinazione
    if ATempPayload <> '' then
      sp.REQUEST_FILE_NAME := TPath.GetFileName(ATempPayload);
    if ATempResponse <> '' then
      sp.RESPONSE_FILE_NAME := TPath.GetFileName(ATempResponse);

    sp.ExecuteWithoutCommit;

    Result := sp.ID_SIUF_COOPERAZIONE_APPLICATIVA_INVIO;

    // Destinazioni calcolate dalla SP
    ADestPayload := sp.REQUEST_FULL_FILE_NAME;
    ADestResponse := sp.RESPONSE_FULL_FILE_NAME;
  finally
    sp.Free;
  end;

  // Spostamento file nelle destinazioni restituite dalla SP.
  // Non deve bloccare il flusso di log: eventuali errori risalgono al chiamante.
  SpostaFile(ATempPayload, ADestPayload);
  SpostaFile(ATempResponse, ADestResponse);
end;

// ---------------------------------------------------------------------------
procedure TSIUF_CooperazioneApplicativa.SpostaFile(const ASource, ADest: string);
begin
  if (ASource = '') or (ADest = '') or (not TFile.Exists(ASource)) then
    Exit;

  ForceDirectories(TPath.GetDirectoryName(ADest));
  TFile.Move(ASource, ADest);
end;

// ---------------------------------------------------------------------------
function TSIUF_CooperazioneApplicativa.InviaChunk(APayload: TSiufPayload): TSiufExportEsitoDettaglio;
var
  Client: TSiufCoopClient;
  Violazioni: TList<TSiufViolazione>;
  Ts, SezStr, FilePayloadTemp, FileResponseTemp: string;
  Esito: TSiufEsito;
  InnerJson, OuterJson: string;

  // Logga un KO: valorizza l'esito e registra nella SP senza propagare errori di log.
  procedure RegistraKO(ATipo: TSiufErroreTipo; const AMsg: string);
  var
    LDestP, LDestR: string;
  begin
    Result.ErroreLocale := AMsg;
    Result.Esito.EsitoCaricamento := false;
    Result.Esito.Tipo := ATipo;
    Result.Esito.MESSAGGIO := AMsg;
    try
      RegistraInvio(APayload, Result.Esito, FilePayloadTemp, FileResponseTemp, LDestP, LDestR);
    except
      // ignora errori di log
    end;
  end;

  // Step 6: registra l'esito OK e sposta i file; un fallimento spostamento non blocca.
  procedure RegistraOK;
  begin
    try
      Result.IdInvio := RegistraInvio(APayload, Esito, FilePayloadTemp, FileResponseTemp,
        Result.FilePayload, Result.FileResponse);
    except
      on E: Exception do
        Result.ErroreLocale := 'Registrazione/spostamento file fallito: ' + E.Message;
    end;
    Result.Esito := Esito;
  end;

begin
  Result := Default (TSiufExportEsitoDettaglio);
  Result.IdProgetto := APayload.IdProgetto;
  Result.IdSezione := APayload.IdSezione;
  Result.DataInizio := APayload.DataInizio;
  Result.DataFine := APayload.DataFine;
  Result.NumeroStudenti := APayload.NumeroStudenti;

  Ts := FormatDateTime('yyyymmdd_hhnnss', Now);

  SezStr := IntToStr(APayload.IdSezione);
  try
    // ---- 1. Validazione client-side ----------------------------------------
    if not TSiufValidator.EValido(APayload, Violazioni) then
    begin
      try
        // Non blocchiamo su violazioni blandi (avvisi): solleviamo solo se
        // ci sono errori che il server rifiuterebbe comunque.
        // Qui solleviamo per mantenere la semantica originale del Validator.
        raise ESiufValidazione.CreateFromList(Violazioni);
      finally
        Violazioni.Free;
      end;
    end;
    Violazioni.Free;

    Client := TSiufCoopClient.Create(ctx.ClientConfig);
    try
      // ---- 2. Serializza (payload JSON leggibile + wrapper Base64) -----------
      // Usiamo BuildBody per avere il wrapper pronto all'invio;
      // per il dump su disco salviamo il JSON interno (più leggibile).
      // Accediamo al metodo tramite il wrapper pubblico.
      OuterJson := Client.BuildBody(APayload); // {"payload":"<base64>"}

      // Per il dump leggibile decodifichiamo il base64 (opzionale ma comodo):
      // decodifica il campo "payload" per ottenere il JSON chiaro
      InnerJson := TEncoding.UTF8.GetString(TNetEncoding.Base64.DecodeStringToBytes(
        // estrai il valore del campo payload dalla stringa outer JSON
        // (il valore è delimitato da ":"" e ""}  )
        Copy(OuterJson, Pos('"payload":"', OuterJson) + Length('"payload":"'), Length(OuterJson) - Pos('"payload":"', OuterJson) - Length('"payload":"') - 2)));

      // ---- 3. Dump payload su disco -----------------------------------------
      FilePayloadTemp := TempFilename('SIUF_payload', SezStr, Ts);

      ScriviFile(FilePayloadTemp, InnerJson);

      // ---- 4. Invio HTTP ----------------------------------------------------
      Esito := Client.Invia(APayload);
    finally
      Client.Free;
    end;

    // ---- 5. Dump response su disco -----------------------------------------
    FileResponseTemp := TempFilename('SIUF_response', SezStr, Ts);
    ScriviFile(FileResponseTemp, Esito.RawResponse);

    // ---- 6. Registra esito nella SP + sposta i file nell'archivio ----------
    RegistraOK;

  except
    on E: ESiufValidazione do
      RegistraKO(setValidationError, E.Message);
    on E: Exception do
      RegistraKO(setErroreTrasporto, E.Message);
  end;
end;

// ---------------------------------------------------------------------------
function TSIUF_CooperazioneApplicativa.Esporta(Dataset: TzFbDataSet): TSiufExportEsito;
var
  Chunks: TObjectList<TSiufPayload>;
  Payload: TSiufPayload;
  ChunkEsito: TSiufExportEsitoDettaglio;
  Dettagli: TList<TSiufExportEsitoDettaglio>;
  i: integer;
begin
  Result := Default (TSiufExportEsito);
  Dettagli := TList<TSiufExportEsitoDettaglio>.Create;
  try
    // 1. Costruisci i chunk
    Chunks := TSiufPayloadBuilder.BuildChunks(Dataset, ctx.CodiceFiscaleUser);
    try
      Result.TotaleChunk := Chunks.Count;
      // 2. Elabora ogni chunk
      for i := 0 to Chunks.Count - 1 do
      begin
        Payload := Chunks[i];

        ChunkEsito := InviaChunk(Payload);

        Dettagli.Add(ChunkEsito);

        if ChunkEsito.Esito.EsitoCaricamento and (ChunkEsito.ErroreLocale = '') then
          Inc(Result.ChunkOK)
        else
          Inc(Result.ChunkKO);
      end;
    finally
      Chunks.Free;
    end;

    Result.Dettaglio := Dettagli.ToArray;
  finally
    Dettagli.Free;
  end;
end;

procedure TSIUF_CooperazioneApplicativa.MostraRiepilogo(const AEsito: TSiufExportEsito);
var
  Sb: TStringBuilder;
  C: TSiufExportEsitoDettaglio;
begin
  Sb := TStringBuilder.Create;
  try
    Sb.AppendLine(Format('Esportazione completata: %d chunk inviati, %d OK, %d KO.', [AEsito.TotaleChunk, AEsito.ChunkOK, AEsito.ChunkKO]));

    for C in AEsito.Dettaglio do
    begin
      Sb.AppendLine('');
      Sb.AppendLine(Format('  Progetto %d / Sezione %d  [%s .. %s]  (%d studenti)', [C.IdProgetto, C.IdSezione, C.DataInizio, C.DataFine, C.NumeroStudenti]));

      if C.Esito.EsitoCaricamento then
        Sb.AppendLine('    ✓ OK - ' + C.Esito.MESSAGGIO)
      else
        Sb.AppendLine('    ✗ KO - ' + C.Esito.MESSAGGIO);

      if C.ErroreLocale <> '' then
        Sb.AppendLine('    Errore locale: ' + C.ErroreLocale);

      if C.FilePayload <> '' then
        Sb.AppendLine('    Payload:  ' + C.FilePayload);

      if C.FileResponse <> '' then
        Sb.AppendLine('    Response: ' + C.FileResponse);
    end;
    ShowMessage(Sb.ToString);
  finally
    Sb.Free;
  end;
end;

function TSIUF_CooperazioneApplicativa.Invia(Dataset: TzFbDataSet; AmbienteTest: boolean): boolean;
var
  idEnte: integer;
  Esito: TSiufExportEsito;
begin
  assert(assigned(Dataset));

  Result := false;

  idEnte := Dataset.FieldByName('ID_ENTE').AsInteger;

  LoadConfig(idEnte, AmbienteTest);

  Esito := Esporta(Dataset);

  MostraRiepilogo(Esito);
end;

end.
