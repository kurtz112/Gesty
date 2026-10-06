unit dmSIUF_CooperazioneApplicativa;

{
  Patch proposta al file di produzione:
  Gesty\_Sorgenti\DataModules\dmSIUF_CooperazioneApplicativa.pas

  Obiettivo: poter usare i parametri di configurazione forniti da SIUF per
  l'ambiente di test ("Ente Sperimentazione 3", vedi
  CooperazioneApplicativa\Informazioni Ente Test III GRS sez 2503.txt) SENZA
  scrivere quei valori nella tabella SIUF_COOPERAZIONE_APPLICATIVA_CONFIG del
  database del cliente.

  Come funziona: LoadConfig, invece di interrogare SEMPRE
  SIUF_COOPERAZIONE_APPLICATIVA_CONFIG_GET, controlla PRIMA se esiste un file
  SIUF_CooperazioneApplicativa.Test.ini accanto all'eseguibile. Se il file
  c'e', i parametri (URL, credenziali, ambiente, codice fiscale utente) vengono
  letti da li' e il database non viene toccato: ne' letto ne' scritto. Se il
  file non c'e', il comportamento e' quello attuale (invariato).

  Per tornare al comportamento normale basta cancellare/rinominare il file ini:
  nessuna riga da eliminare in nessuna tabella.

  Uso: vedi SIUF_CooperazioneApplicativa.Test.ini (stessa cartella di questo
  file) per un esempio compilato con i dati ufficiali dell'ambiente di test
  SIUF. Copiarlo accanto a Gesty.exe per attivare l'override.

  Tutte le righe modificate/aggiunte rispetto all'originale sono segnalate con
  il commento "// [TEST-CONFIG]".

  Mantis #100 - 2026-09-18: aggiunto ResolveCanaleSiuf e l'aggancio del
  resolver in Esporta, per attivare il canale ordinamentale IeFP/IFTS/ITS
  (finora compilato ma spento). Le righe sono segnalate con "// [CANALE-SIUF]".

  Mantis #186 - 2026-09-25: aggiunto ResolveItsIfts e l'aggancio del secondo
  resolver in Esporta, che porta su ogni presenza il flag PROGETTI.ITS_IFTS.
  Dal 2026-09-28 il formato delle ore è unico per tutti i corsi e non dipende
  più dal flag, che resta per le regole proprie dei corsi ITS/IFTS. Le righe
  sono segnalate con "// [ITS-IFTS]".
}

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  System.Net.HttpClient,
  System.Net.URLClient,
  System.IniFiles, // [TEST-CONFIG]
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  SIUF.CooperazioneApplicativa.Types,
  SIUF.CooperazioneApplicativa.Builder,
  SIUF.CooperazioneApplicativa.Client,
  SIUF.CooperazioneApplicativa.Validator,
  Base_DataModule,
  dbMaster,
  zFbDataSet,
   zProgressBox;

type
  /// Thread monouso: esegue UNA sola Client.Invia in background, così il main
  /// thread può girare in ProcessMessages e tenere viva la UI / la ProgressBox.
  /// Tutto il resto (validazione, dump, SP di log, file) resta sul main thread.
  TSiufInviaThread = class(TThread)
  private
    FClient: TSiufCoopClient;
    FPayload: TSiufPayload;
    FEsito: TSiufEsito;
    FErrore: string; // <> '' se Invia ha sollevato
  protected
    procedure Execute; override;
  public
    constructor Create(AClient: TSiufCoopClient; APayload: TSiufPayload);
    property Esito: TSiufEsito read FEsito;
    property Errore: string read FErrore;
  end;

  TSIUF_CooperazioneApplicativa = class(TBaseDataModule)
    ProgressBox: TProgressBox;
  private
    ctx: TSiufExportContext;
    FDateFmt: TFormatSettings; // formato date header SIUF (YYYY-MM-DD)
    FUsingTestConfigFile: Boolean; // [TEST-CONFIG] True se ctx e' stato caricato dal file ini di test, non dal db
    procedure LoadConfig(idEnte: integer);
    function TestConfigFileName: string; // [TEST-CONFIG] percorso del file ini di override, accanto all'exe
    procedure LoadConfigFromFile(const AFileName: string; idEnte: integer); // [TEST-CONFIG]

    // [CANALE-SIUF] Mantis #100 - 2026-09-18: legge PROGETTI.CANALE_SIUF per
    // un progetto. Passato come TSiufCanaleResolver a BuildChunks (vedi
    // Esporta). LoadDataSet in Builder.pas lo invoca una sola volta per ogni
    // ID_PROGETTO distinto nel dataset, non per riga.
    function ResolveCanaleSiuf(AIdProgetto: Integer): TSiufCanale;

    // [ITS-IFTS] Mantis #186 - 2026-09-25: legge PROGETTI.ITS_IFTS per un
    // progetto. Passato come TSiufItsIftsResolver a BuildChunks (vedi
    // Esporta): indipendente da ResolveCanaleSiuf, arriva su ogni presenza
    // come TSiufPresenza.ItsIfts.
    function ResolveItsIfts(AIdProgetto: Integer): Boolean;

    // --- Utilità dump su disco ---
    function TempFilename(const APrefix, ASezione, ATimestamp: string): string;
    procedure ScriviFile(const FileName, Content: string);

    // Parsing date header SIUF ("YYYY-MM-DD") con FormatSettings dedicato.
    function ParseDataHeader(const S: string): TDate;

    // --- SP di log (SIUF_COOPERAZIONE_APPLICATIVA_INVII_ADD) ---
    // Registra l'invio, sposta i file temp nelle destinazioni restituite dalla SP
    // e valorizza ADestPayload/ADestResponse con le full path finali.
    // Restituisce ID_SIUF_COOPERAZIONE_APPLICATIVA_INVIO.
    function RegistraInvio(APayload: TSiufPayload; const AEsito: TSiufEsito; const ATempPayload, ATempResponse: string; out ADestPayload, ADestResponse: string): integer;

    // --- Sposta un file in una destinazione (full path) ---
    procedure SpostaFile(const ASource, ADest: string);

    // Invia un payload nel thread secondario, tenendo viva la UI col message
    // loop. Solleva l'eventuale eccezione di trasporto come farebbe Client.Invia.
    // Imposta AAnnullato=True se l'utente ha premuto Annulla durante l'attesa.
    function InviaConUI(AClient: TSiufCoopClient; APayload: TSiufPayload; out AAnnullato: Boolean): TSiufEsito;

    // --- Elabora un singolo chunk ---
    function InviaChunk(APayload: TSiufPayload; out AAnnullato: Boolean): TSiufExportEsitoDettaglio;

    // ---
    function Esporta(Dataset: TzFbDataSet): TSiufExportEsito;

    /// Mostra il riepilogo all'utente (da personalizzare)
    procedure MostraRiepilogo(const AEsito: TSiufExportEsito);
  public
    constructor Create(aOwner: TComponent); override;

    function Invia(Dataset: TzFbDataSet): Boolean;
  end;

var
  SIUF_CooperazioneApplicativa: TSIUF_CooperazioneApplicativa;

implementation

uses
  System.StrUtils,
  System.IOUtils,
  System.DateUtils,
  Gesty_StoredProcs,
  Files.Lib,
  zMsg,
  zMemoDialog, ConfigModule;

{$R *.dfm}

constructor TSIUF_CooperazioneApplicativa.Create(aOwner: TComponent);
begin
  inherited;
  FDateFmt := TFormatSettings.Create;
  FDateFmt.DateSeparator := '-';
  FDateFmt.ShortDateFormat := 'yyyy-mm-dd';
end;

{ TSiufInviaThread }

constructor TSiufInviaThread.Create(AClient: TSiufCoopClient; APayload: TSiufPayload);
begin
  inherited Create(True); // sospeso: il chiamante fa Start
  FreeOnTerminate := False; // lo libera il chiamante dopo aver letto Esito/Errore
  FClient := AClient;
  FPayload := APayload;
end;

procedure TSiufInviaThread.Execute;
begin
  // Unica cosa che gira fuori dal main thread: la POST HTTP.
  try
    FEsito := FClient.Invia(FPayload);
  except
    on E: Exception do
      FErrore := E.Message;
  end;
end;

// ---------------------------------------------------------------------------
function TSIUF_CooperazioneApplicativa.InviaConUI(AClient: TSiufCoopClient; APayload: TSiufPayload; out AAnnullato: Boolean): TSiufEsito;
var
  T: TSiufInviaThread;
begin
  AAnnullato := False;

  T := TSiufInviaThread.Create(AClient, APayload);
  try
    T.Start;

    // Il main thread resta reattivo: la ProgressBox si ridisegna e il pulsante
    // Annulla risponde. L'annullamento è "morbido": non interrompe la POST in
    // corso (prosegue fino a risposta/timeout), ma viene segnalato al chiamante.
    //
    // ProcessMessages è protetto: un'eccezione sollevata da un ALTRO handler di
    // messaggio non deve interrompere l'attesa del nostro thread, altrimenti
    // perderemmo il suo esito/errore (è la causa del "prosegue come nulla fosse"
    // sul timeout). Aspettiamo SEMPRE che il thread finisca.
    while not T.Finished do
    begin
      try
        Application.ProcessMessages;
      except
        // ignora: non è l'esito del nostro invio
      end;

      if ProgressBox.Cancelled then
        AAnnullato := True;

      Sleep(10); // evita un busy-loop al 100% di CPU
    end;

    // Il thread ha finito: o ha un errore (timeout/trasporto) o un esito valido.
    if T.Errore <> '' then
      raise Exception.Create(T.Errore); // stessa semantica di Client.Invia

    Result := T.Esito;
  finally
    T.Free;
  end;
end;

function TSIUF_CooperazioneApplicativa.ParseDataHeader(const S: string): TDate;
var
  D: TDateTime;
begin
  // Tollerante: nel percorso di log non deve mai sollevare (una data malformata
  // non deve impedire la registrazione dell'invio). Ritorna 0 se non parsabile.
  if TryStrToDate(S, D, FDateFmt) then
    Result := D
  else
    Result := 0;
end;

// [TEST-CONFIG] Percorso fisso, accanto all'eseguibile: nessuna riga di
// configurazione da passare, basta copiare/cancellare il file.
function TSIUF_CooperazioneApplicativa.TestConfigFileName: string;
begin
  Result := TPath.Combine(ExtractFilePath(Application.ExeName), 'SIUF_CooperazioneApplicativa.Test.ini');
end;

// [TEST-CONFIG] Sostituisce la lettura da SIUF_COOPERAZIONE_APPLICATIVA_CONFIG:
// nessuna query, nessuna scrittura sul database del cliente.
procedure TSIUF_CooperazioneApplicativa.LoadConfigFromFile(const AFileName: string; idEnte: integer);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(AFileName);
  try
    ctx.ClientConfig.Url := Ini.ReadString('SIUF', 'Url', '');
    ctx.ClientConfig.IdentificativoEnte := Ini.ReadString('SIUF', 'IdentificativoEnte', '');
    ctx.ClientConfig.Username := Ini.ReadString('SIUF', 'Username', '');
    ctx.ClientConfig.Code := Ini.ReadString('SIUF', 'Code', '');
    ctx.ClientConfig.AmbienteTest := Ini.ReadBool('SIUF', 'AmbienteTest', True);

    ctx.idEnte := idEnte;
    ctx.Ente := Ini.ReadString('SIUF', 'Ente', '(configurazione di test da file locale)');

    // Il CF inviato come "codiceFiscaleUser" deve essere un utente CENSITO sul
    // lato SIUF per l'ente di test: non e' il CF dell'utente Gesty che ha
    // lanciato l'invio (a differenza del percorso normale via db), ma quello
    // fornito da SIUF nella documentazione dell'ambiente di sperimentazione.
    ctx.CodiceFiscaleUser := Ini.ReadString('SIUF', 'CodiceFiscaleUser', '');
    ctx.NominativoUser := Ini.ReadString('SIUF', 'NominativoUser', '');
  finally
    Ini.Free;
  end;

  // ctx.UserId NON va letto dal file di test: SIUF_COOPERAZIONE_APPLICATIVA_INVII
  // ha una FK verso USR_UTENTI (FK_SIUF_COOPERAZIONE_APPLICATIVA_INVII_USR_UTENTI)
  // e serve solo per il log locale ("chi ha lanciato l'invio da Gesty"), non e'
  // un dato che SIUF vede: deve restare SEMPRE l'utente Gesty realmente
  // loggato, altrimenti l'insert del log fallisce per violazione di FK (come
  // successo con lo 0 di segnaposto usato nella prima versione di questo file).
  ctx.UserId := 11; //Config.zSystem.UserID;

  if ctx.ClientConfig.Url.IsEmpty then
    raise Exception.CreateFmt('File di configurazione di test "%s" incompleto: manca Url.', [AFileName]);
end;

procedure TSIUF_CooperazioneApplicativa.LoadConfig(idEnte: integer);
var
  sp: TSP_SIUF_COOPERAZIONE_APPLICATIVA_CONFIG_GET;
  TestFile: string;
begin
  // [TEST-CONFIG] Se il file di override esiste, usa quello e NON tocca il
  // database (ne' in lettura ne' in scrittura): e' l'unico ramo attivato.
  TestFile := TestConfigFileName;
  FUsingTestConfigFile := TFile.Exists(TestFile);

  if FUsingTestConfigFile then
    LoadConfigFromFile(TestFile, idEnte)
  else
  begin
    sp := GetSP<TSP_SIUF_COOPERAZIONE_APPLICATIVA_CONFIG_GET>;
    try
      sp.Id_Ente := idEnte;
      sp.ExecuteAndCommit;
      //
      ctx.ClientConfig.Url := sp.Url;
      ctx.ClientConfig.IdentificativoEnte := sp.Identificativo_Ente;
      ctx.ClientConfig.Username := sp.Username;
      ctx.ClientConfig.Code := sp.Code;
      ctx.ClientConfig.AmbienteTest := sp.Ambiente_Test;
      //
      ctx.idEnte := idEnte;
      ctx.Ente := sp.Ente;
      //
      ctx.CodiceFiscaleUser := sp.Codice_Fiscale_User;
      ctx.NominativoUser := sp.Nominativo_User;
      ctx.UserId := sp.User_Id;
    finally
      FreeAndNil(sp);
    end;
  end;

  if ctx.TempDir.IsEmpty then
    ctx.TempDir := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'SIUF_CooperazioneApplicativa_Log');

  ForceDirectories(ctx.TempDir);
end;

// [CANALE-SIUF] Mantis #100 - 2026-09-18 ------------------------------------
function TSIUF_CooperazioneApplicativa.ResolveCanaleSiuf(AIdProgetto: Integer): TSiufCanale;
var
  sp: TSP_PROGETTI_GET_CANALE_SIUF;
begin
  sp := GetSP<TSP_PROGETTI_GET_CANALE_SIUF>;
  try
    sp.Id_Progetto := AIdProgetto;
    sp.ExecuteAndCommit;

    if sp.Canale_Siuf = 'ORD' then
      Result := scOrdinamentale
    else
      Result := scExtraObbligo; // include 'EOB' e il caso NULL (progetto senza
                                 // GRS attivo, o non ancora allineato dal
                                 // backfill): comportamento storico, invariato
                                 // rispetto a prima di questa modifica.
  finally
    FreeAndNil(sp);
  end;
end;

// [ITS-IFTS] Mantis #186 - 2026-09-25 ----------------------------------------
// PROGETTI_GET_CANALE_SIUF restituisce ora anche ITS_IFTS (vedi script SQL
// allegato a questa consegna): un'unica chiamata basta per entrambi i
// resolver, ognuno la fa per conto proprio perché BuildChunks li invoca
// separatamente (uno per il canale, uno per il flag ITS/IFTS) e li mette
// comunque in cache per progetto in LoadDataSet (Builder.pas), quindi il
// costo resta lo stesso di oggi: una query per ID_PROGETTO distinto.
function TSIUF_CooperazioneApplicativa.ResolveItsIfts(AIdProgetto: Integer): Boolean;
var
  sp: TSP_PROGETTI_GET_CANALE_SIUF;
begin
  sp := GetSP<TSP_PROGETTI_GET_CANALE_SIUF>;
  try
    sp.Id_Progetto := AIdProgetto;
    sp.ExecuteAndCommit;

    // Mantis #186 - 2026-09-28: GetValueOrDefault, non .Value: se ID_PROGETTO
    // non trova riga il parametro d'uscita resta NULL e .Value solleverebbe
    // EInvalidOperation, bloccando l'intero invio per un solo progetto.
    // False è coerente con ResolveCanaleSiuf, che nello stesso caso ricade
    // sul comportamento storico.
    Result := sp.Its_Ifts.GetValueOrDefault(False);
  finally
    FreeAndNil(sp);
  end;
end;

// ---------------------------------------------------------------------------
function TSIUF_CooperazioneApplicativa.TempFilename(const APrefix, ASezione, ATimestamp: string): string;
begin
  // Es.: C:\Temp\SIUF_payload_9675_20251022_143012.json
  Result := TPath.Combine(ctx.TempDir, Format('%s %s %s.json', [APrefix, ASezione, ATimestamp]));
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
function TSIUF_CooperazioneApplicativa.RegistraInvio(APayload: TSiufPayload; const AEsito: TSiufEsito; const ATempPayload, ATempResponse: string; out ADestPayload, ADestResponse: string): integer;
var
  sp: TSP_SIUF_COOPERAZIONE_APPLICATIVA_INVII_ADD;
  Det: TSiufDettaglioErrore;
begin
  Result := -1;
  ADestPayload := '';
  ADestResponse := '';
  Det := AEsito.DettaglioErrore;

  sp := GetSP<TSP_SIUF_COOPERAZIONE_APPLICATIVA_INVII_ADD>;
  try
    sp.Id_Ente := ctx.idEnte;
    sp.User_Id := ctx.UserId;
    sp.Codice_Fiscale_User := ctx.CodiceFiscaleUser;
    sp.ID_SEZIONE := IntToStr(APayload.IdSezione);
    sp.DATA_INIZIO := ParseDataHeader(APayload.DataInizio);
    sp.DATA_FINE := ParseDataHeader(APayload.DataFine);
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

    sp.ExecuteAndCommit;

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
  TFile.Copy(ASource, ADest);
end;

// ---------------------------------------------------------------------------
function TSIUF_CooperazioneApplicativa.InviaChunk(APayload: TSiufPayload; out AAnnullato: Boolean): TSiufExportEsitoDettaglio;
var
  Client: TSiufCoopClient;
  Ts, SezStr, FilePayloadTemp, FileResponseTemp: string;
  Esito: TSiufEsito;

  // Logga un KO: valorizza l'esito e registra nella SP senza propagare errori di log.
  procedure RegistraKO(ATipo: TSiufErroreTipo; const AMsg: string);
  var
    LDestP, LDestR: string;
  begin
    Result.ErroreLocale := AMsg;
    Result.Esito.EsitoCaricamento := False;
    Result.Esito.Tipo := ATipo;
    Result.Esito.MESSAGGIO := AMsg;
    try
      RegistraInvio(APayload, Result.Esito, FilePayloadTemp, FileResponseTemp, LDestP, LDestR);
    except
      on E: Exception do
        // Il log non deve propagare, ma non lo nascondiamo: lo annotiamo
        // nell'esito così è diagnosticabile (prima veniva perso del tutto).
        Result.ErroreLocale := AMsg + ' | [LOG FALLITO: ' + E.Message + ']';
    end;
  end;

// Step 6: registra l'esito OK e sposta i file; un fallimento spostamento non blocca.
  procedure RegistraOK;
  begin
    try
      Result.IdInvio := RegistraInvio(APayload, Esito, FilePayloadTemp, FileResponseTemp, Result.FilePayload, Result.FileResponse);
    except
      on E: Exception do
        Result.ErroreLocale := 'Registrazione/spostamento file fallito: ' + E.Message;
    end;
    Result.Esito := Esito;
  end;

begin
  Result := Default (TSiufExportEsitoDettaglio);
  AAnnullato := False;
  Result.IdProgetto := APayload.IdProgetto;
  Result.IdSezione := APayload.IdSezione;
  Result.DataInizio := APayload.DataInizio;
  Result.DataFine := APayload.DataFine;
  Result.NumeroStudenti := APayload.NumeroStudenti;

  Ts := FormatDateTime('yyyy-mm-dd hh-nn-ss', Now);

  SezStr := IntToStr(APayload.IdSezione);
  try
    // ---- 1. Validazione client-side ----------------------------------------
    TSiufValidator.ValidaOErrore(APayload);

    Client := TSiufCoopClient.Create(ctx.ClientConfig);
    try
      // ---- 2+3. Dump payload leggibile su disco -----------------------------
      // Il JSON chiaro (non Base64) è quello che archiviamo; il wrapper Base64
      // lo costruisce internamente Client.Invia al momento del POST.
      FilePayloadTemp := TempFilename('SIUF_payload', SezStr, Ts);
      ScriviFile(FilePayloadTemp, Client.BuildReadableJson(APayload));

      // ---- 4. Invio HTTP (nel thread secondario, UI reattiva) ---------------
      Esito := InviaConUI(Client, APayload, AAnnullato);
    finally
      Client.Free;
    end;

    // ---- 5. Dump response su disco -----------------------------------------
    FileResponseTemp := TempFilename('SIUF_response', SezStr, Ts);
    ScriviFile(FileResponseTemp, Esito.RawResponse);
    // Il corpo è ora su file: non serve trascinarlo nell'esito aggregato.
    Esito.RawResponse := '';

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
  Annullato: Boolean;
  ErroreTrasporto: string; // <> '' se interrotto per errore di comunicazione
begin
  Result := Default (TSiufExportEsito);
  ErroreTrasporto := '';
  Dettagli := TList<TSiufExportEsitoDettaglio>.Create;
  try
    // 1. Costruisci i chunk
    // [CANALE-SIUF] Mantis #100 - 2026-09-18: prima il resolver non veniva
    // passato (default nil -> tutto trattato come Extra Obbligo). Da qui il
    // canale ordinamentale IeFP/IFTS/ITS è attivo per i progetti con
    // PROGETTI.CANALE_SIUF = 'ORD'.
    // [ITS-IFTS] Mantis #186 - 2026-09-25: aggiunto ResolveItsIfts, che porta
    // il flag PROGETTI.ITS_IFTS su ogni presenza.
    Chunks := TSiufPayloadBuilder.BuildChunks(Dataset, ctx.CodiceFiscaleUser, ResolveCanaleSiuf, ResolveItsIfts);
    try
      Result.TotaleChunk := Chunks.Count;
      // 2. Elabora ogni chunk
      ProgressBox.Show(Result.TotaleChunk, 'Invio a SIUF - Cooperazione Applicativa', 'Invio a SIUF - Cooperazione Applicativa', 'Attendere...');
      try
        for i := 0 to Chunks.Count - 1 do
        begin
          Payload := Chunks[i];

          ProgressBox.IncProgress('Id Sezione: ' + Payload.IdSezione.ToString, 'Numero Studenti: ' + Payload.NumeroStudenti.ToString);

          // Annullamento richiesto tra un chunk e l'altro: usciamo dal ciclo
          // (Break, non Exit: così sotto valorizziamo comunque Dettaglio).
          if ProgressBox.Cancelled then
            Break;

          ChunkEsito := InviaChunk(Payload, Annullato);

          Dettagli.Add(ChunkEsito);

          if ChunkEsito.Esito.EsitoCaricamento and (ChunkEsito.ErroreLocale = '') then
            Inc(Result.ChunkOK)
          else
            Inc(Result.ChunkKO);

          // Errore di comunicazione (timeout/trasporto): interrompiamo subito
          // l'intero invio. Il chunk è già stato loggato come KO; segnaliamo
          // dopo la chiusura della ProgressBox.
          if ChunkEsito.Esito.Tipo = setErroreTrasporto then
          begin
            ErroreTrasporto := ChunkEsito.Esito.MESSAGGIO;
            Break;
          end;

          // L'utente ha premuto Annulla DURANTE l'invio di questo chunk:
          // il chunk corrente è stato comunque completato e loggato, ma non
          // proseguiamo coi successivi.
          if Annullato then
            Break;
        end;
      finally
        ProgressBox.Close;
      end;
    finally
      Chunks.Free;
    end;

    Result.Dettaglio := Dettagli.ToArray;
  finally
    Dettagli.Free;
  end;

  if ErroreTrasporto <> '' then
    MessageDlg('Invio interrotto per un errore di comunicazione con SIUF:' + sLineBreak + sLineBreak + ErroreTrasporto, mtError, [mbOK], 0);
end;

procedure TSIUF_CooperazioneApplicativa.MostraRiepilogo(const AEsito: TSiufExportEsito);
var
  Sb: TStringBuilder;
  C: TSiufExportEsitoDettaglio;
  S: String;
begin
  Sb := TStringBuilder.Create;
  try
    Sb.AppendLine(Format('Esportazione completata: %d chunk inviati, %d OK, %d KO.', [AEsito.TotaleChunk, AEsito.ChunkOK, AEsito.ChunkKO]));

    for C in AEsito.Dettaglio do
    begin
      Sb.AppendLine('');
      Sb.AppendLine(Format('  Progetto %d / Sezione %d  [%s .. %s]  (%d studenti)', [C.IdProgetto, C.IdSezione, C.DataInizio, C.DataFine, C.NumeroStudenti]));

      if C.Esito.EsitoCaricamento then
        Sb.AppendLine('    OK - ' + C.Esito.MESSAGGIO) // [TEST-CONFIG] simbolo Unicode '✓' sostituito con testo puro: nel test e' arrivato a video corrotto ("âœ“")
      else
        Sb.AppendLine('    KO - ' + C.Esito.MESSAGGIO); // [TEST-CONFIG] idem per '✗'

      if C.ErroreLocale <> '' then
        Sb.AppendLine('    Errore locale: ' + C.ErroreLocale);

      if C.FilePayload <> '' then
        Sb.AppendLine('    Payload:  ' + C.FilePayload);

      if C.FileResponse <> '' then
        Sb.AppendLine('    Response: ' + C.FileResponse);
    end;

    //
    S := Sb.ToString;
    // Mantis #152 - 2026-09-21: il riquadro manda a capo da solo, cosi' si leggono
    // per intero anche i messaggi che arrivano da SIUF, che non possiamo riscrivere.
    zExecuteMemoDialog(S, 'Esito Invio', nil, nil, True);
  finally
    Sb.Free;
  end;
end;

function TSIUF_CooperazioneApplicativa.Invia(Dataset: TzFbDataSet): Boolean;
var
  idEnte: integer;
  Esito: TSiufExportEsito;
  msg: string;
begin
  assert(assigned(Dataset));

  Result := False;

  if (not Dataset.Active) or (Dataset.IsEmpty) then
  begin
    ConfirmOk('Nessuna presenza da inviare.');
    Exit;
  end;

  idEnte := Dataset.ParamByName('PARAM_ID_ENTE').AsInteger;

  LoadConfig(idEnte);

  /// ////////////////////

  msg := 'Inviare le presenze a SIUF - Ambiente ' + IfThen(ctx.ClientConfig.AmbienteTest, 'Test', 'Produzione') + ' ?';
  if FUsingTestConfigFile then // [TEST-CONFIG] mai un invio "silenzioso" con credenziali di test
    msg := msg + sLineBreak + sLineBreak + 'Configurazione caricata da file locale di test (' + TestConfigFileName + '), non dal database.';
  msg := msg + sLineBreak;
  msg := msg + sLineBreak + 'Ente: ' + ctx.Ente;
  msg := msg + sLineBreak + 'Periodo dal ' + Dataset.ParamByName('DAL_GIORNO').AsString + ' al ' + Dataset.ParamByName('AL_GIORNO').AsString;

  if not ConfirmYesNo(msg) then
    Exit;

  /// ////////////////////

  Esito := Esporta(Dataset);

  MostraRiepilogo(Esito);
end;

end.
