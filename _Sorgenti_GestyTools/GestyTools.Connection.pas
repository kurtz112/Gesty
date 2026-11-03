unit GestyTools.Connection;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  Data.DB,
  FireDAC.Phys.FBDef,
  FireDAC.UI.Intf,
  FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.UI,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.IBWrapper,
  System.Net.URLClient,
  System.Net.HttpClient,
  System.Net.HttpClientComponent,
  QImport3,
  QImport3XMLBased,
  QImport3Xlsx;

type
  TConnection = class(TDataModule)
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDConnection: TFDConnection;
    FDIBBackup: TFDIBBackup;
    FDIBRestore: TFDIBRestore;
    FDStoredProc: TFDStoredProc;
    procShutdown: TFDStoredProc;
    UtentiAttivi: TFDQuery;
    procLogin: TFDStoredProc;
    procedure FDIBBackupError(ASender, AInitiator: TObject; var AException: Exception);
    procedure FDIBBackupProgress(ASender: TFDPhysDriverService; const AMessage: string);
    procedure FDIBRestoreError(ASender, AInitiator: TObject; var AException: Exception);
    procedure FDIBRestoreProgress(ASender: TFDPhysDriverService; const AMessage: string);
  private
    // connessione dedicata alla COPIA da anonimizzare, creata a runtime.
    // Non punta mai a Config.DB: e' l'unico canale da cui passa
    // ANONYMIZER_GESTY.ESEGUI_ANONIMIZZAZIONE, e le tre verifiche di
    // VerificaCopiaNonDiProduzione stanno fra la richiesta e l'apertura.
    FConnessioneCopia: TFDConnection;
    FQueryCopia: TFDQuery;
    // percorsi dei database creati da Restore durante QUESTA esecuzione:
    // sono gli unici che l'anonimizzazione accetta di lavorare
    FCopieRipristinate: TStringList;
    function GetEsistonoUtentiCollegati: boolean;
    function GetUtentiAttiviActive: boolean;
    procedure SetUtentiAttiviActive(const Value: boolean);
  private
    function PercorsoNormalizzato(const Percorso: string): string;
    function PercorsoDatabaseRisolto(DataBaseConnection: TFDConnection): string;
    function PercorsoProduzioneRisolto(out Percorso: string): boolean;
    procedure VerificaCopiaNonDiProduzione(const DatabaseCopia: string);
    procedure ConnettiCopia(const DatabaseCopia: string);
    procedure DisconnettiCopia;
    procedure RegistraEsitoPassi;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function ComputerName: string;
    procedure Connect;
    procedure Disconnect;
    procedure Shutdown;
    procedure LoadConfig;
  public
    procedure Backup(const BackupFilename: string);
    procedure Restore(const BackupFilename, DatabaseFilename: string);
  public
    // Tutti i collegamenti al database diversi da quello di GestyTools, una
    // riga per collegamento (processo, utente, indirizzo). A differenza di
    // EsistonoUtentiCollegati conta anche IBExpert, GestyScript e le
    // utilita' pianificate: ognuno tiene aperto il file del database.
    function AltriCollegamenti(Elenco: TStrings): Integer;
    // Chiude lato server tutti i collegamenti diversi da quello di
    // GestyTools (DELETE FROM MON$ATTACHMENTS), anche quelli che lo shutdown
    // non raggiunge: programmi con l'exe in memoria che non ascoltano
    // l'evento, collegamenti senza sessione di Gesty, sessioni rimaste
    // appese. Restituisce quanti ne ha chiusi.
    function DisconnettiAltriCollegamenti: Integer;
  public
    procedure ExecStoredProc(Params: Variant);
  public
    // Configurazione del motore, UNA VOLTA SOLA e in PRODUZIONE: scrive
    // l'impronta della parola d'ordine e approva la configurazione delle
    // colonne, che da li viaggia dentro i backup. Non anonimizza niente.
    function AnonimizzaInizializza: string;
    // Il ciclo notturno, SOLO sulla copia appena ripristinata.
    procedure AnonimizzaCopia(const DatabaseCopia: string);
    // Il rientro a casa, SOLO sulla copia: le stesse operazioni che USR_LOGIN
    // farebbe al primo accesso dalla macchina di sviluppo, fatte prima e in
    // un momento scelto.
    procedure HomecomingCopia(const DatabaseCopia: string);
  public
    property EsistonoUtentiCollegati: boolean read GetEsistonoUtentiCollegati;
    property UtentiAttiviActive: boolean read GetUtentiAttiviActive write SetUtentiAttiviActive;
  public
    procedure Login;
  end;

var
  Connection: TConnection;

implementation

uses
  System.DateUtils,
  System.IOUtils,
  System.Variants,
  GestyTools.Log,
  GestyTools.Config,
  GestyTools.Mail,
  QImport3Common;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

constructor TConnection.Create(aOwner: TComponent);
begin
  inherited;

  // connessione alla copia: creata a runtime, senza parametri. Li riceve solo
  // in ConnettiCopia, dopo le verifiche, e non eredita niente da FDConnection
  FConnessioneCopia := TFDConnection.Create(Self);
  FConnessioneCopia.LoginPrompt := false;
  FConnessioneCopia.ConnectedStoredUsage := [];

  FQueryCopia := TFDQuery.Create(Self);
  FQueryCopia.Connection := FConnessioneCopia;

  FCopieRipristinate := TStringList.Create;
  FCopieRipristinate.Duplicates := dupIgnore;
  FCopieRipristinate.Sorted := True;

  LoadConfig;
end;

destructor TConnection.Destroy;
begin
  FreeAndNil(FCopieRipristinate);

  inherited;
end;

procedure TConnection.LoadConfig;
begin
  FDPhysFBDriverLink.VendorLib := Config.VendorLib;
  FDPhysFBDriverLink.Embedded := Config.Embedded;

  FDConnection.Params.Clear;
  FDConnection.Params.Add('DriverID=FB');

  if Config.Embedded then
  begin
    TFDPhysFBConnectionDefParams(FDConnection.Params).Protocol := ipLocal
  end
  else
  begin
    TFDPhysFBConnectionDefParams(FDConnection.Params).Protocol := ipTCPIP;
    FDConnection.Params.Add('Server=' + Config.Server);
    FDConnection.Params.Add('Port=' + Config.Port.ToString);
  end;

  FDConnection.Params.Add('Database=' + Config.DB);
  FDConnection.Params.Add('User_Name=' + Config.dbUserName);
  FDConnection.Params.Add('Password=' + Config.dbPassword);
  FDConnection.Params.Add('CharacterSet=UTF8');
end;

procedure TConnection.Connect;
begin
  FDConnection.Connected := True;
end;

procedure TConnection.Disconnect;
begin
  FDConnection.Connected := False;
end;

procedure TConnection.Backup(const BackupFilename: string);
begin
  FDIBBackup.userName := Config.dbUserName;
  FDIBBackup.Password := Config.dbPassword;

  if Config.Embedded then
    FDIBBackup.Protocol := ipLocal
  else
  begin
    FDIBBackup.Host := Config.Server;
    FDIBBackup.Port := Config.Port;
    FDIBBackup.Protocol := ipTCPIP;
  end;

  FDIBBackup.Database := Config.DB;
  FDIBBackup.BackupFiles.Clear; // se chiamato più volte
  FDIBBackup.BackupFiles.Add(BackupFilename);
  FDIBBackup.Options := FDIBBackup.Options + [boNoTriggers];

  try
    FDIBBackup.Backup;
  finally
    Log.ChiudiAvanzamento;
  end;
end;

procedure TConnection.FDIBBackupError(ASender, AInitiator: TObject; var AException: Exception);
begin
  Log.ToScreen('Backup Error: ' + AException.Message);
end;

procedure TConnection.FDIBBackupProgress(ASender: TFDPhysDriverService; const AMessage: string);
begin
  Log.Avanzamento('Backup: ' + AMessage);
end;

procedure TConnection.FDIBRestoreError(ASender, AInitiator: TObject; var AException: Exception);
begin
  Log.ToScreen('Restore Error: ' + AException.Message);
end;

procedure TConnection.FDIBRestoreProgress(ASender: TFDPhysDriverService; const AMessage: string);
begin
  Log.Avanzamento('Restore: ' + AMessage);
end;

procedure TConnection.Restore(const BackupFilename, DatabaseFilename: string);
begin

  // Un ripristino sopra il database di produzione lo distruggerebbe comunque,
  // anonimizzazione o no: il controllo sta qui e non solo nell'anonimizzazione
  // perche' il danno e' gia' completo prima che il ciclo parta.
  if SameText(PercorsoNormalizzato(DatabaseFilename), PercorsoNormalizzato(Config.DB)) then
    raise Exception.Create('Restore rifiutato: il percorso di destinazione e'' il database di produzione (' + Config.DB + ').');

  FDIBRestore.userName := Config.dbUserName;
  FDIBRestore.Password := Config.dbPassword;

  if Config.Embedded then
    FDIBRestore.Protocol := ipLocal
  else
  begin
    FDIBRestore.Host := Config.Server;
    FDIBRestore.Port := Config.Port;
    FDIBRestore.Protocol := ipTCPIP;
  end;

  FDIBRestore.Database := DatabaseFilename;
  FDIBRestore.BackupFiles.Clear; // se chiamato più volte
  FDIBRestore.BackupFiles.Add(BackupFilename);

  try
    FDIBRestore.Restore;
  finally
    Log.ChiudiAvanzamento;
  end;

  // Da qui in poi questo percorso e' un database nato da un ripristino fatto
  // adesso, da questo processo: e' la condizione che l'anonimizzazione
  // pretende, e l'elenco muore con il processo.
  FCopieRipristinate.Add(PercorsoNormalizzato(DatabaseFilename));
end;

function TConnection.AltriCollegamenti(Elenco: TStrings): Integer;
var
  Query: TFDQuery;
begin
  Elenco.Clear;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDConnection;
    // MON$SYSTEM_FLAG = 1: thread interni del server (garbage collector,
    // cache writer), che non sono collegamenti di un programma
    Query.SQL.Text := 'SELECT MON$ATTACHMENTS.MON$REMOTE_PROCESS, MON$ATTACHMENTS.MON$USER, MON$ATTACHMENTS.MON$REMOTE_ADDRESS ' +
      'FROM MON$ATTACHMENTS ' + 'WHERE MON$ATTACHMENTS.MON$SYSTEM_FLAG <> 1 AND MON$ATTACHMENTS.MON$ATTACHMENT_ID <> CURRENT_CONNECTION ' +
      'ORDER BY MON$ATTACHMENTS.MON$REMOTE_PROCESS';
    Query.Open;

    while not Query.Eof do
    begin
      Elenco.Add(Format('%s - utente %s, indirizzo %s', [ExtractFileName(Trim(Query.FieldByName('MON$REMOTE_PROCESS').AsString)),
          Trim(Query.FieldByName('MON$USER').AsString), Trim(Query.FieldByName('MON$REMOTE_ADDRESS').AsString)]));
      Query.Next;
    end;

    Query.Close;
  finally
    FreeAndNil(Query);
  end;

  Result := Elenco.Count;
end;

function TConnection.DisconnettiAltriCollegamenti: Integer;
var
  Query: TFDQuery;
begin
  Log.ToFile('DisconnettiAltriCollegamenti');

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDConnection;
    // stesso criterio di AltriCollegamenti: fuori i thread interni del
    // server e il collegamento di GestyTools stesso
    Query.SQL.Text := 'DELETE FROM MON$ATTACHMENTS ' + 'WHERE MON$ATTACHMENTS.MON$SYSTEM_FLAG <> 1 AND MON$ATTACHMENTS.MON$ATTACHMENT_ID <> CURRENT_CONNECTION';
    Query.ExecSQL;
    Result := Query.RowsAffected;
  finally
    FreeAndNil(Query);
  end;

  Log.ToFile('DisconnettiAltriCollegamenti: chiusi ' + Result.ToString);
end;

procedure TConnection.ExecStoredProc(Params: Variant);
var
  I, idx: integer;
  NomeProcedura: string;
begin
  NomeProcedura := VarToStr(Params[0]);

  // SP ed ExecSP lavorano sulla connessione di PRODUZIONE. Senza questo
  // controllo basterebbe SP('ANONYMIZER_GESTY.ESEGUI_ANONIMIZZAZIONE', ...)
  // per anonimizzare il database vero: le tre verifiche stanno tutte
  // sull'altro canale, e questa sarebbe la porta di servizio che le aggira.
  if UpperCase(Trim(NomeProcedura)).StartsWith('ANONYMIZER') then
    raise Exception.Create('SP/ExecSP: le routine ANONYMIZER non si chiamano da qui, perche'' questa e'' la connessione di produzione. ' +
        'Usare AnonimizzaInizializza (produzione) o AnonimizzaCopia (copia ripristinata).');

  // Stesso motivo: HOMECOMING azzera PWD_METODO_VERIFICA di tutti gli utenti
  // e riscrive USR_FOLDERS. Sulla produzione del cliente sarebbe un guasto.
  if SameText(Trim(NomeProcedura), 'HOMECOMING') then
    raise Exception.Create('SP/ExecSP: HOMECOMING non si chiama da qui, perche'' questa e'' la connessione di produzione. ' + 'Usare HomecomingCopia.');

  FDStoredProc.Unprepare;
  FDStoredProc.Params.Clear;

  FDStoredProc.StoredProcName := NomeProcedura;
  FDStoredProc.Prepare;

  idx := 1;
  for I := 0 to FDStoredProc.ParamCount - 1 do
    if FDStoredProc.Params[I].ParamType in [ptInput, ptInputOutput] then
    begin
      FDStoredProc.Params[I].Value := Params[idx];
      inc(idx);
    end;

  FDStoredProc.ExecProc;

  FDStoredProc.Unprepare;
  FDStoredProc.Params.Clear;
end;

// ---------------------------------------------------------------------------
// Anonimizzazione
// ---------------------------------------------------------------------------

// Forma di confronto dei percorsi: non li espande, perche' il percorso e'
// quello che vede il SERVER Firebird e non la macchina che esegue lo script,
// e una ExpandFileName qui darebbe una risposta sbagliata con la faccia di
// una risposta giusta. Uniforma solo cio' che si puo' uniformare senza
// interpretare: spazi, separatori e maiuscole.
function TConnection.PercorsoNormalizzato(const Percorso: string): string;
begin
  Result := UpperCase(Trim(Percorso)).Replace('/', '\', [rfReplaceAll]);
end;

// Il percorso che il server ha davvero aperto per quella connessione. E'
// l'unico dato non opinabile: risolve gli alias di aliases.conf, i percorsi
// relativi e le differenze di forma fra due scritture dello stesso file.
function TConnection.PercorsoDatabaseRisolto(DataBaseConnection: TFDConnection): string;
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := DataBaseConnection;
    Query.SQL.Text := 'SELECT RDB$GET_CONTEXT(''SYSTEM'', ''DB_NAME'') AS DB_NAME FROM RDB$DATABASE';
    Query.Open;

    Result := PercorsoNormalizzato(Query.FieldByName('DB_NAME').AsString);

    Query.Close;
  finally
    FreeAndNil(Query);
  end;
end;

// Restituisce False, senza sollevare, se la produzione non e' raggiungibile:
// e' il caso della macchina che riceve solo un .fbk e non vede il database
// originale. La verifica decisiva salta, restano le altre due.
function TConnection.PercorsoProduzioneRisolto(out Percorso: string): boolean;
var
  EraCollegata: boolean;
begin
  Percorso := '';
  Result := false;

  EraCollegata := FDConnection.Connected;
  try
    if not EraCollegata then
      FDConnection.Connected := True;

    Percorso := PercorsoDatabaseRisolto(FDConnection);
    Result := not Percorso.IsEmpty;
  except
    on E: Exception do
      Log.ToScreen('Produzione non raggiungibile per il confronto dei percorsi: ' + E.Message);
  end;

  // lascia la connessione com'era: se l'ho aperta io per il confronto, la chiudo
  if not EraCollegata then
    FDConnection.Connected := false;
end;

// Le tre verifiche che stanno fra la richiesta di anonimizzare e l'apertura
// della connessione. La terza, quella che conta, e' dentro ConnettiCopia,
// perche' ha bisogno che la connessione sia gia' aperta.
procedure TConnection.VerificaCopiaNonDiProduzione(const DatabaseCopia: string);
begin

  if Trim(DatabaseCopia).IsEmpty then
    raise Exception.Create('Anonimizzazione rifiutata: percorso della copia non indicato.');

  // 1. il percorso non e' quello scritto nella configurazione
  if SameText(PercorsoNormalizzato(DatabaseCopia), PercorsoNormalizzato(Config.DB)) then
    raise Exception.Create('Anonimizzazione rifiutata: il percorso indicato e'' il database di produzione (' + Config.DB + ').');

  // 2. il file e' nato da un Restore fatto da questo processo poco fa. Blocca
  //    qualunque percorso scritto a mano nello script, compreso un secondo
  //    database di produzione che la configurazione non nomina.
  if FCopieRipristinate.IndexOf(PercorsoNormalizzato(DatabaseCopia)) < 0 then
    raise Exception.Create('Anonimizzazione rifiutata: ' + DatabaseCopia +
        ' non e'' stato creato da dbRestore in questa esecuzione. Si anonimizza solo una copia appena ripristinata.');
end;

procedure TConnection.ConnettiCopia(const DatabaseCopia: string);
var
  PercorsoCopia: string;
  PercorsoProduzione: string;
begin
  VerificaCopiaNonDiProduzione(DatabaseCopia);

  DisconnettiCopia;

  FConnessioneCopia.Params.Clear;
  FConnessioneCopia.Params.Add('DriverID=FB');

  // stesso server, stesse credenziali della produzione: il ripristino avviene
  // lato server, quindi la copia vive sul filesystem del server Firebird
  if Config.Embedded then
    TFDPhysFBConnectionDefParams(FConnessioneCopia.Params).Protocol := ipLocal
  else
  begin
    TFDPhysFBConnectionDefParams(FConnessioneCopia.Params).Protocol := ipTCPIP;
    FConnessioneCopia.Params.Add('Server=' + Config.Server);
    FConnessioneCopia.Params.Add('Port=' + Config.Port.ToString);
  end;

  FConnessioneCopia.Params.Add('Database=' + DatabaseCopia);
  FConnessioneCopia.Params.Add('User_Name=' + Config.dbUserName);
  FConnessioneCopia.Params.Add('Password=' + Config.dbPassword);
  FConnessioneCopia.Params.Add('CharacterSet=UTF8');

  FConnessioneCopia.Connected := True;

  // 3. la verifica che chiude il cerchio, fatta dal server e non dalle
  //    stringhe: il file aperto adesso non e' il file aperto dalla
  //    produzione. Smaschera l'alias, il percorso relativo e le due
  //    scritture diverse dello stesso file.
  try
    PercorsoCopia := PercorsoDatabaseRisolto(FConnessioneCopia);

    if SameText(PercorsoCopia, PercorsoNormalizzato(Config.DB)) then
      raise Exception.Create('Anonimizzazione rifiutata: il server ha aperto ' + PercorsoCopia +
          ', che e'' il database di produzione della configurazione.');

    if PercorsoProduzioneRisolto(PercorsoProduzione) then
    begin
      if SameText(PercorsoCopia, PercorsoProduzione) then
        raise Exception.Create('Anonimizzazione rifiutata: la copia e la produzione sono lo stesso file sul server (' + PercorsoCopia + ').');

      Log.ToScreen('Copia ' + PercorsoCopia + ' diversa dalla produzione ' + PercorsoProduzione + ': verifica superata.');
    end
    else
      Log.ToScreen('Confronto con la produzione non eseguito: valgono il percorso della configurazione e l''origine da dbRestore.');
  except
    // una copia che non ha superato la verifica non resta collegata
    DisconnettiCopia;
    raise;
  end;
end;

procedure TConnection.DisconnettiCopia;
begin

  if FQueryCopia.Active then
    FQueryCopia.Close;

  FConnessioneCopia.Connected := false;
end;

// L'esito passo per passo, letto dentro la copia. Va letto anche quando il
// ciclo fallisce: e' l'unico posto dove sta scritto quale passo si e' fermato
// e perche'. Non solleva mai: sostituirebbe la propria eccezione a quella
// vera del ciclo.
procedure TConnection.RegistraEsitoPassi;
begin

  try
    FQueryCopia.Close;
    FQueryCopia.SQL.Text := 'SELECT ANONYMIZER_CICLI_PASSI.PASSO, ANONYMIZER_CICLI_PASSI.DESCRIZIONE, ANONYMIZER_CICLI_PASSI.ESITO ' +
      'FROM ANONYMIZER_CICLI_PASSI ORDER BY ANONYMIZER_CICLI_PASSI.PASSO';
    FQueryCopia.Open;

    while not FQueryCopia.Eof do
    begin
      Log.ToScreen(Format('Passo %s - %s: %s', [FQueryCopia.FieldByName('PASSO').AsString, FQueryCopia.FieldByName('DESCRIZIONE').AsString,
          FQueryCopia.FieldByName('ESITO').AsString]));

      Log.ToFile(Format('Passo %s - %s: %s', [FQueryCopia.FieldByName('PASSO').AsString, FQueryCopia.FieldByName('DESCRIZIONE').AsString,
          FQueryCopia.FieldByName('ESITO').AsString]));

      FQueryCopia.Next;
    end;

    FQueryCopia.Close;
  except
    on E: Exception do
      Log.ToScreen('Esito dei passi non leggibile: ' + E.Message);
  end;
end;

function TConnection.AnonimizzaInizializza: string;
var
  Query: TFDQuery;
begin

  if Trim(Config.AnonimizzazioneParolaOrdine).IsEmpty then
    raise Exception.Create('AnonimizzaInizializza: AnonimizzazioneParolaOrdine non e'' valorizzata nella configurazione.');

  // Qui la produzione e' la destinazione giusta, ed e' l'unico caso: scrive
  // l'impronta della parola d'ordine e approva la configurazione delle
  // colonne, che da li viaggiano dentro i backup. Non tocca nessun dato.
  Log.ToScreen('ANONYMIZER_GESTY.INIZIALIZZA su ' + Config.DB);

  Connect;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FDConnection;
    Query.SQL.Text := 'SELECT CAMPI_CONFIGURATI, CAMPI_APPROVATI FROM ANONYMIZER_GESTY.INIZIALIZZA(:PAROLA_ORDINE)';
    Query.ParamByName('PAROLA_ORDINE').AsString := Config.AnonimizzazioneParolaOrdine;
    Query.Open;

    if Query.IsEmpty then
      raise Exception.Create('ANONYMIZER_GESTY.INIZIALIZZA non ha restituito righe.');

    Result := Format('Campi configurati: %s, campi approvati: %s', [Query.FieldByName('CAMPI_CONFIGURATI').AsString,
        Query.FieldByName('CAMPI_APPROVATI').AsString]);

    Query.Close;
  finally
    FreeAndNil(Query);
  end;

  Log.ToScreen(Result);
  Log.ToFile('ANONYMIZER_GESTY.INIZIALIZZA - ' + Result);
end;

procedure TConnection.AnonimizzaCopia(const DatabaseCopia: string);
begin

  if Trim(Config.AnonimizzazioneParolaOrdine).IsEmpty then
    raise Exception.Create('AnonimizzaCopia: AnonimizzazioneParolaOrdine non e'' valorizzata nella configurazione.');

  if Trim(Config.AnonimizzazioneChiaveDerivazione).IsEmpty then
    raise Exception.Create('AnonimizzaCopia: AnonimizzazioneChiaveDerivazione non e'' valorizzata nella configurazione.');

  ConnettiCopia(DatabaseCopia);
  try
    Log.ToScreen('ANONYMIZER_GESTY.ESEGUI_ANONIMIZZAZIONE su ' + DatabaseCopia);
    Log.ToFile('ANONYMIZER_GESTY.ESEGUI_ANONIMIZZAZIONE su ' + DatabaseCopia);

    try
      FQueryCopia.Close;
      FQueryCopia.SQL.Text := 'EXECUTE PROCEDURE ANONYMIZER_GESTY.ESEGUI_ANONIMIZZAZIONE(:PAROLA_ORDINE, :CHIAVE_DERIVAZIONE)';
      FQueryCopia.ParamByName('PAROLA_ORDINE').AsString := Config.AnonimizzazioneParolaOrdine;
      FQueryCopia.ParamByName('CHIAVE_DERIVAZIONE').AsString := Config.AnonimizzazioneChiaveDerivazione;
      FQueryCopia.ExecSQL;
    except
      on E: Exception do
      begin
        // prima di risollevare: l'elenco dei passi dice dove si e' fermato
        Log.ToFile('ANONYMIZER_GESTY.ESEGUI_ANONIMIZZAZIONE fallita: ' + E.Message);
        RegistraEsitoPassi;
        raise;
      end;
    end;

    RegistraEsitoPassi;
  finally
    DisconnettiCopia;
  end;
end;

// Le operazioni che USR_LOGIN fa gia' da sola al primo accesso dalla macchina
// di sviluppo, anticipate qui sulla copia: azzeramento del metodo di verifica
// della password di tutti gli utenti e riscrittura di USR_FOLDERS con i
// percorsi delle macchine di casa.
//
// Due cose da sapere, tutte e due imparate leggendo il sorgente di HOMECOMING:
//
// 1. La procedura esce subito se il parametro non e' HOME_COMPUTER_NAME().
//    Chiamata dal server del cliente con il nome del server del cliente non
//    farebbe assolutamente niente, in silenzio. Il nome lo chiede quindi al
//    database, che e' l'unico a saperlo, e non a Windows.
//
// 2. Fa UPDATE USR_UTENTI SET PWD_METODO_VERIFICA = 'N' su TUTTE le righe e
//    riscrive USR_FOLDERS. Sulla produzione toglierebbe al cliente
//    l'autenticazione di dominio e gli cambierebbe le cartelle di lavoro: e'
//    distruttiva quanto l'anonimizzazione, e passa dagli stessi sbarramenti.
procedure TConnection.HomecomingCopia(const DatabaseCopia: string);
var
  NomeMacchinaDiCasa: string;
begin
  ConnettiCopia(DatabaseCopia);
  try
    FQueryCopia.Close;
    FQueryCopia.SQL.Text := 'SELECT HOME_COMPUTER_NAME() AS NOME_MACCHINA FROM RDB$DATABASE';
    FQueryCopia.Open;

    NomeMacchinaDiCasa := FQueryCopia.FieldByName('NOME_MACCHINA').AsString;

    FQueryCopia.Close;

    if Trim(NomeMacchinaDiCasa).IsEmpty then
      raise Exception.Create('HomecomingCopia: HOME_COMPUTER_NAME() non restituisce niente. HOMECOMING non farebbe nulla.');

    Log.ToScreen('HOMECOMING su ' + DatabaseCopia + ' per la macchina ' + NomeMacchinaDiCasa);
    Log.ToFile('HOMECOMING su ' + DatabaseCopia + ' per la macchina ' + NomeMacchinaDiCasa);

    // Il nome viaggia come parametro e non dentro il testo: cosi' quello che
    // finisce nel registro e' esattamente quello che la procedura riceve.
    FQueryCopia.SQL.Text := 'EXECUTE PROCEDURE HOMECOMING(:COMPUTER_NAME)';
    FQueryCopia.ParamByName('COMPUTER_NAME').AsString := NomeMacchinaDiCasa;
    FQueryCopia.ExecSQL;

    Log.ToScreen('HOMECOMING: fatto.');
  finally
    DisconnettiCopia;
  end;
end;

procedure TConnection.Shutdown;
begin
  Log.ToFile('Shutdown');
  procShutdown.ExecProc;
end;

function TConnection.GetUtentiAttiviActive: boolean;
begin
  Result := UtentiAttivi.Active;
end;

procedure TConnection.SetUtentiAttiviActive(const Value: boolean);
begin
  UtentiAttivi.Active := Value;
end;

function TConnection.GetEsistonoUtentiCollegati: boolean;
begin
  UtentiAttiviActive := False;
  UtentiAttiviActive := True;

  Result := not UtentiAttivi.IsEmpty;
end;

procedure TConnection.Login;
begin
  procLogin.Prepare;
  procLogin.ParamByName('APP').Value := 'GESTY_TOOLS';
  procLogin.ParamByName('USER_NAME').Value := ComputerName;
  procLogin.ParamByName('PASSWORD_').Value := ComputerName;
  procLogin.ParamByName('COMPUTER_NAME').Value := ComputerName;
  procLogin.ExecProc;
end;

function TConnection.ComputerName: string;
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
  Result := uppercase(cresult);
end;

end.
