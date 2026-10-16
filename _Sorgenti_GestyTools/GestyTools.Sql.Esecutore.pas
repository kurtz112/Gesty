// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-16
// ---------------------------------------------------------------------------
unit GestyTools.Sql.Esecutore;

// COPIA ADATTATA di zToolsAI\zFbScript\_src\zFbScript.Esecutore.pas
// (2026-10-03): stesse regole di esecuzione, ma sulla connessione che
// GestyTools ha gia' aperto invece che su un alias di databases.ini.
// Differenze dall'originale:
//  - il costruttore riceve la TFDConnection; l'esecutore non la apre con
//    parametri propri e non la chiude, usa una TFDTransaction sua senza
//    toccare la transazione predefinita della connessione;
//  - SET NAMES, SET SQL DIALECT e SET CLIENTLIB si ignorano sempre con un
//    avviso: la connessione e' quella di GestyTools, gia' aperta;
//  - lettura tollerante dei file di INPUT e percorsi relativi copiati qui
//    da zFbScript.Testi;
//  - CartellaPredefinita: da dove si risolvono gli INPUT di un testo mai
//    salvato.
// Le correzioni al motore vanno fatte anche in zFbScript finche' non passa
// in una sottocartella di zPack.
//
// Non mostra niente da se': messaggi ed errori escono come eventi. Fra
// un'istruzione e l'altra chiama OnAvanzamento, dove l'interfaccia si
// ridisegna e puo' chiedere l'interruzione (Interrompi).
//
// Transazioni:
//  - ogni esecuzione (EseguiTesto) e' un'unita' di lavoro: le istruzioni
//    girano in una transazione READ COMMITTED aperta alla prima istruzione e
//    confermata alla fine, come uno script in IBEScript;
//  - AUTODDL (attivo di norma, come in isql e IBExpert): dopo ogni
//    istruzione DDL riuscita la transazione si conferma, cosi' le istruzioni
//    successive vedono gli oggetti appena creati. Conferma anche le DML
//    eseguite prima, come fa isql;
//  - COMMIT, ROLLBACK (anche WORK e RETAIN) dello script agiscono sulla
//    transazione; ROLLBACK TO SAVEPOINT e SAVEPOINT vanno al server;
//  - al primo errore si annulla la transazione e ci si ferma, a meno di
//    Continua (o SET BAIL OFF nello script): allora si prosegue e alla
//    fine si conferma quello che e' riuscito. L'interruzione chiesta
//    dall'utente annulla come un errore;
//  - con Prova tutto resta in una transazione, AUTODDL spento e COMMIT
//    ignorati, e alla fine si annulla. Uno script che usa un oggetto creato
//    da se' stesso fallisce in prova anche se nella realta' funzionerebbe:
//    senza conferma Firebird non rende disponibile l'oggetto ("Table
//    unknown", verificato su Firebird 5.0.3).
//
// Comandi gestiti qui e non dal server: SET TERM (nel divisore), SET
// AUTODDL, SET BAIL, COMMIT, ROLLBACK, INPUT, EXIT, QUIT; i comandi di sola
// visualizzazione di isql (SET ECHO, SET LIST, SET STATS...) e SET NAMES,
// SET SQL DIALECT, SET CLIENTLIB si ignorano con un avviso. CONNECT e
// CREATE DATABASE si rifiutano: lo script gira sul database configurato in
// GestyTools e non deve poter andare altrove.

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  FireDAC.Comp.Client,
  GestyTools.Sql.Divisore;

type
  // Connessione al database fallita: non e' un errore dello script.
  EErroreConnessione = class(Exception);

  TTipoMessaggio = (tmIstruzione, tmEsito, tmAvviso, tmErrore, tmRiepilogo);

  TImpostazioniEsecuzione = record
    Continua: Boolean;
    Prova: Boolean;
    AutoDdl: Boolean;
    // righe lette per ogni SELECT; 0 = tutte
    RigheMassime: Integer;
  end;

  TEsitoEsecuzione = record
    Eseguite: Integer;
    Errori: Integer;
    // fermata da un errore, da EXIT/QUIT o dall'utente
    Fermata: Boolean;
    Interrotta: Boolean;
    // la transazione e' stata annullata (errore, QUIT, interruzione, prova):
    // quello che non era gia' confermato non e' nel database
    Annullata: Boolean;
    // risultati restituiti (SELECT, EXECUTE BLOCK con SUSPEND, procedure con
    // valori di uscita)
    Risultati: Integer;
    // primo errore: file (vuoto = il testo eseguito) e riga
    FileErrore: string;
    RigaErrore: Integer;
    Millisecondi: Int64;
  end;

  // NomeFile vuoto = il testo passato a EseguiTesto; Riga = 0 per i
  // messaggi che non riguardano un'istruzione.
  TEventoMessaggio = procedure(Sender: TObject; Tipo: TTipoMessaggio; const NomeFile: string; Riga: Integer; const Testo: string) of object;

  // DataSet e' aperto e contiene le righe lette (al massimo RigheMassime);
  // va copiato durante l'evento, subito dopo si chiude.
  TEventoRisultato = procedure(Sender: TObject; const NomeFile: string; Riga: Integer; const TestoIstruzione: string; DataSet: TDataSet; Tagliato: Boolean;
    Millisecondi: Int64) of object;

  TEsecutore = class
  private
    FImpostazioni: TImpostazioniEsecuzione;
    // connessione di GestyTools: non e' dell'esecutore, non si libera
    FDatabase: TFDConnection;
    FTransazione: TFDTransaction;
    FQuery: TFDQuery;
    FAutoDdl: Boolean;
    FContinua: Boolean;
    FProfondita: Integer;
    FEsito: TEsitoEsecuzione;
    // file dell'istruzione corrente: vuoto per il testo di EseguiTesto
    FScriptCorrente: string;
    // cartella da cui si risolvono gli INPUT del testo principale
    FCartellaBase: string;
    FCartellaPredefinita: string;
    FFermato: Boolean;
    FInterrompi: Boolean;
    FInEsecuzione: Boolean;
    // vero dopo il primo DDL eseguito in prova: spiega gli errori "Table
    // unknown" che ne seguono
    FDdlInProva: Boolean;

    FOnMessaggio: TEventoMessaggio;
    FOnRisultato: TEventoRisultato;
    FOnAvanzamento: TNotifyEvent;

    procedure IniziaTransazione;
    procedure Conferma(const Motivo: string);
    procedure Annulla(const Motivo: string);

    procedure EseguiIstruzioni(const Testo: string; RigaIniziale: Integer);
    procedure EseguiIstruzione(const Istruzione: TIstruzione);
    procedure EseguiSulServer(const Istruzione: TIstruzione; const Parole: TArray<string>);
    function GestisciSet(const Istruzione: TIstruzione; const Parole: TArray<string>): Boolean;
    procedure GestisciFineTransazione(const Istruzione: TIstruzione; const Parole: TArray<string>);
    procedure GestisciInput(const Istruzione: TIstruzione);
    procedure FermaSeNonContinua(const Motivo: string);

    procedure Messaggio(Tipo: TTipoMessaggio; Riga: Integer; const Testo: string);
    procedure Esito(const Istruzione: TIstruzione; const Testo: string);
    procedure Avviso(const Istruzione: TIstruzione; const Testo: string);
    procedure Errore(const Istruzione: TIstruzione; const Testo: string);
  public
    constructor Create(Database: TFDConnection);
    destructor Destroy; override;

    // Apre la connessione se non lo e' gia' e prepara transazione e query.
    // Solleva EErroreConnessione.
    procedure Connetti;
    // Libera transazione e query; la connessione resta com'e'.
    procedure Disconnetti;

    // Esegue un testo come unita' di lavoro. NomeFile serve agli INPUT
    // relativi (vuoto per un testo mai salvato); RigaIniziale e' la riga
    // del testo nell'editor (per la selezione).
    function EseguiTesto(const Testo, NomeFile: string; RigaIniziale: Integer; const Impostazioni: TImpostazioniEsecuzione): TEsitoEsecuzione;

    // Chiesta da OnAvanzamento o da un pulsante: l'esecuzione si ferma
    // prima dell'istruzione successiva e la transazione si annulla.
    procedure Interrompi;

    property Database: TFDConnection read FDatabase;
    property InEsecuzione: Boolean read FInEsecuzione;
    // cartella degli INPUT relativi quando EseguiTesto riceve NomeFile
    // vuoto; vuota = cartella corrente
    property CartellaPredefinita: string read FCartellaPredefinita write FCartellaPredefinita;

    property OnMessaggio: TEventoMessaggio read FOnMessaggio write FOnMessaggio;
    property OnRisultato: TEventoRisultato read FOnRisultato write FOnRisultato;
    property OnAvanzamento: TNotifyEvent read FOnAvanzamento write FOnAvanzamento;
  end;

// Il messaggio del server senza i prefissi "[FireDAC][Phys][FB]".
function TestoErrore(E: Exception): string;

// Legge un file di testo in qualunque codifica usata dagli script: UTF-16 con
// BOM, UTF-8 con o senza BOM, altrimenti Windows-1252. Serve anche all'editor
// della pagina Aggiornamento DB, che deve mostrare lo stesso testo che
// l'esecutore leggerebbe con INPUT.
function LeggiTestoTollerante(const NomeFile: string): string;

implementation

uses
  System.IOUtils,
  System.StrUtils,
  System.Diagnostics,
  System.RegularExpressions,
  System.Generics.Collections,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DApt;

const
  ProfonditaMassima = 16;

  // Comandi di isql che cambiano solo come si mostrano i risultati: non
  // hanno senso qui e non devono arrivare al server, che li rifiuterebbe.
  ComandiSetVisualizzazione: array [0 .. 16] of string = ('ECHO', 'LIST', 'COUNT', 'STATS', 'PLAN', 'PLANONLY', 'BLOBDISPLAY', 'BLOB',
    'WARNINGS', 'WNG', 'HEADING', 'ROWCOUNT', 'TIME', 'PER_TABLE_STATS', 'EXPLAIN', 'MAXROWS', 'KEEP_TRAN_PARAMS');

  // Comandi interattivi di isql: non sono SQL e non si possono emulare.
  ComandiIsql: array [0 .. 6] of string = ('SHOW', 'HELP', 'OUTPUT', 'SHELL', 'EDIT', 'BLOBDUMP', 'BLOBVIEW');

  ComandiDdl: array [0 .. 7] of string = ('CREATE', 'ALTER', 'DROP', 'RECREATE', 'DECLARE', 'COMMENT', 'GRANT', 'REVOKE');

// ---------------------------------------------------------------------------
// Lettura dei file di INPUT (da zFbScript.Testi): UTF-16 se c'e' il BOM,
// UTF-8 (con o senza BOM) se i byte sono validi, altrimenti Windows-1252.
// Gli script arrivano da IBExpert, da zBuilder o scritti a mano in codifiche
// diverse.
// ---------------------------------------------------------------------------

// Vero se i byte da Inizio in poi formano UTF-8 valido (ASCII compreso).
// Controllo in Pascal puro: TEncoding.UTF8 solleva sui byte non validi e
// non ha una variante tollerante.
function Utf8Valido(const Dati: TBytes; Inizio: Integer): Boolean;
var
  Posizione, Seguenti, Indice: Integer;
  Carattere: Byte;
begin
  Posizione := Inizio;

  while Posizione < Length(Dati) do
  begin
    Carattere := Dati[Posizione];

    if Carattere < $80 then
    begin
      Inc(Posizione);
      Continue;
    end;

    if (Carattere = $C0) or (Carattere = $C1) or (Carattere > $F4) then
      Exit(False);

    if (Carattere and $E0) = $C0 then
      Seguenti := 1
    else if (Carattere and $F0) = $E0 then
      Seguenti := 2
    else if (Carattere and $F8) = $F0 then
      Seguenti := 3
    else
      Exit(False);

    if Posizione + Seguenti > High(Dati) then
      Exit(False);

    for Indice := Posizione + 1 to Posizione + Seguenti do
      if (Dati[Indice] and $C0) <> $80 then
        Exit(False);

    Inc(Posizione, Seguenti + 1);
  end;

  Result := True;
end;

function LeggiTestoTollerante(const NomeFile: string): string;
var
  Dati: TBytes;
  Inizio: Integer;
  Codifica1252: TEncoding;
begin
  Dati := TFile.ReadAllBytes(NomeFile);

  if (Length(Dati) >= 2) and (Dati[0] = $FF) and (Dati[1] = $FE) then
    Exit(TEncoding.Unicode.GetString(Dati, 2, Length(Dati) - 2));

  if (Length(Dati) >= 2) and (Dati[0] = $FE) and (Dati[1] = $FF) then
    Exit(TEncoding.BigEndianUnicode.GetString(Dati, 2, Length(Dati) - 2));

  Inizio := 0;

  if (Length(Dati) >= 3) and (Dati[0] = $EF) and (Dati[1] = $BB) and (Dati[2] = $BF) then
    Inizio := 3;

  if Utf8Valido(Dati, Inizio) then
    Exit(TEncoding.UTF8.GetString(Dati, Inizio, Length(Dati) - Inizio));

  Codifica1252 := TEncoding.GetEncoding(1252);
  try
    Result := Codifica1252.GetString(Dati, Inizio, Length(Dati) - Inizio);
  finally
    Codifica1252.Free;
  end;
end;

// Un percorso relativo si intende rispetto a Cartella.
function PercorsoAssoluto(const Percorso, Cartella: string): string;
begin
  Result := Trim(Percorso);

  if (Result <> '') and not TPath.IsPathRooted(Result) then
    Result := TPath.GetFullPath(TPath.Combine(Cartella, Result));
end;

function InElenco(const Parola: string; const Elenco: array of string): Boolean;
var
  Voce: string;
begin
  for Voce in Elenco do
    if Voce = Parola then
      Exit(True);

  Result := False;
end;

// Prime parole dell'istruzione, in maiuscolo, finche' sono parole separate
// da spazi: bastano a riconoscere il comando.
function PrimeParole(const Testo: string; Quante: Integer): TArray<string>;
var
  Elenco: TList<string>;
  Posizione, Inizio, Lunghezza: Integer;
begin
  Elenco := TList<string>.Create;
  try
    Lunghezza := Length(Testo);
    Posizione := 1;

    while (Elenco.Count < Quante) and (Posizione <= Lunghezza) do
    begin
      while (Posizione <= Lunghezza) and CharInSet(Testo[Posizione], [' ', #9, #10, #13]) do
        Inc(Posizione);

      Inizio := Posizione;

      while (Posizione <= Lunghezza) and CharInSet(Testo[Posizione], ['A' .. 'Z', 'a' .. 'z', '0' .. '9', '_', '$']) do
        Inc(Posizione);

      if Posizione = Inizio then
        Break;

      Elenco.Add(UpperCase(Copy(Testo, Inizio, Posizione - Inizio)));
    end;

    // le posizioni mancanti restano stringhe vuote: Parole[3] si legge
    // sempre senza controllare la lunghezza
    while Elenco.Count < Quante do
      Elenco.Add('');

    Result := Elenco.ToArray;
  finally
    Elenco.Free;
  end;
end;

function PrimaRiga(const Testo: string): string;
var
  Fine: Integer;
begin
  Fine := Testo.IndexOfAny([#13, #10]);

  if Fine >= 0 then
    Result := Testo.Substring(0, Fine).TrimRight + ' ...'
  else
    Result := Testo;
end;

function TestoErrore(E: Exception): string;
begin
  Result := TRegEx.Replace(E.Message, '^(\[[^\]]*\])+\s*', '').Trim;
end;

function DescrizioneRigheModificate(Righe: Integer): string;
begin
  if Righe = 1 then
    Result := '1 riga modificata'
  else
    Result := Format('%d righe modificate', [Righe]);
end;

// TEsecutore

constructor TEsecutore.Create(Database: TFDConnection);
begin
  inherited Create;

  FDatabase := Database;
end;

destructor TEsecutore.Destroy;
begin
  Disconnetti;

  inherited;
end;

procedure TEsecutore.Connetti;
begin
  try
    if not FDatabase.Connected then
      FDatabase.Connected := True;
  except
    on E: Exception do
      raise EErroreConnessione.Create('connessione al database non riuscita: ' + TestoErrore(E));
  end;

  if Assigned(FQuery) then
    Exit;

  // la transazione e' dell'esecutore: quella predefinita della connessione,
  // usata dal resto di GestyTools, resta com'e'
  FTransazione := TFDTransaction.Create(nil);
  FTransazione.Connection := FDatabase;
  FTransazione.Options.Isolation := xiReadCommitted;
  FTransazione.Options.AutoStart := True;
  FTransazione.Options.AutoStop := False;
  FTransazione.Options.ReadOnly := False;

  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FDatabase;
  FQuery.Transaction := FTransazione;
  FQuery.UpdateTransaction := FTransazione;

  // il testo va al server cosi' com'e': niente parametri ":nome" (i corpi
  // PSQL ne sono pieni), niente macro "!nome" e "&nome", niente sequenze
  // di escape "{fn ...}"
  FQuery.ResourceOptions.ParamCreate := False;
  FQuery.ResourceOptions.MacroCreate := False;
  FQuery.ResourceOptions.MacroExpand := False;
  FQuery.ResourceOptions.EscapeExpand := False;
  FQuery.ResourceOptions.DirectExecute := True;
  FQuery.ResourceOptions.CmdExecMode := amBlocking;

  // le righe si leggono tutte (fino al limite) all'apertura: chi riceve
  // OnRisultato le copia, poi il cursore si chiude
  FQuery.FetchOptions.Mode := fmAll;
  FQuery.FetchOptions.Unidirectional := False;
  FQuery.FetchOptions.Items := FQuery.FetchOptions.Items - [fiMeta];

  FQuery.UpdateOptions.ReadOnly := True;
  FQuery.UpdateOptions.RequestLive := False;
end;

procedure TEsecutore.Disconnetti;
begin
  FreeAndNil(FQuery);

  if Assigned(FTransazione) and FTransazione.Active then
    try
      FTransazione.Rollback;
    except
      // una connessione caduta non deve impedire di chiudere
    end;

  FreeAndNil(FTransazione);
end;

procedure TEsecutore.Interrompi;
begin
  if FInEsecuzione then
    FInterrompi := True;
end;

procedure TEsecutore.IniziaTransazione;
begin
  Connetti;

  if not FTransazione.Active then
    FTransazione.StartTransaction;
end;

procedure TEsecutore.Conferma(const Motivo: string);
begin
  if Assigned(FTransazione) and FTransazione.Active then
  begin
    FTransazione.Commit;

    if Motivo <> '' then
      Messaggio(tmRiepilogo, 0, Motivo);
  end;
end;

procedure TEsecutore.Annulla(const Motivo: string);
begin
  if Assigned(FTransazione) and FTransazione.Active then
  begin
    FTransazione.Rollback;
    FEsito.Annullata := True;

    if Motivo <> '' then
      Messaggio(tmRiepilogo, 0, Motivo);
  end;
end;

procedure TEsecutore.Messaggio(Tipo: TTipoMessaggio; Riga: Integer; const Testo: string);
begin
  if Assigned(FOnMessaggio) then
    FOnMessaggio(Self, Tipo, FScriptCorrente, Riga, Testo);
end;

procedure TEsecutore.Esito(const Istruzione: TIstruzione; const Testo: string);
begin
  Messaggio(tmEsito, Istruzione.Riga, Testo);
end;

procedure TEsecutore.Avviso(const Istruzione: TIstruzione; const Testo: string);
begin
  Messaggio(tmAvviso, Istruzione.Riga, Testo);
end;

procedure TEsecutore.Errore(const Istruzione: TIstruzione; const Testo: string);
begin
  Inc(FEsito.Errori);

  if FEsito.RigaErrore = 0 then
  begin
    FEsito.FileErrore := FScriptCorrente;
    FEsito.RigaErrore := Istruzione.Riga;
  end;

  Messaggio(tmErrore, Istruzione.Riga, Testo);
end;

procedure TEsecutore.FermaSeNonContinua(const Motivo: string);
begin
  if FContinua then
    Exit;

  Annulla(Motivo);
  FFermato := True;
end;

function TEsecutore.EseguiTesto(const Testo, NomeFile: string; RigaIniziale: Integer; const Impostazioni: TImpostazioniEsecuzione): TEsitoEsecuzione;
var
  Cronometro: TStopwatch;
begin
  if FInEsecuzione then
    raise Exception.Create('un''esecuzione e'' gia'' in corso su questa connessione');

  FImpostazioni := Impostazioni;
  FAutoDdl := Impostazioni.AutoDdl and not Impostazioni.Prova;
  FContinua := Impostazioni.Continua;
  FEsito := Default (TEsitoEsecuzione);
  FFermato := False;
  FInterrompi := False;
  FDdlInProva := False;
  FProfondita := 0;
  FScriptCorrente := '';

  if NomeFile <> '' then
    FCartellaBase := ExtractFilePath(NomeFile)
  else if FCartellaPredefinita <> '' then
    FCartellaBase := FCartellaPredefinita
  else
    FCartellaBase := GetCurrentDir;

  Cronometro := TStopwatch.StartNew;
  FInEsecuzione := True;
  try
    // la connessione si controlla qui e non alla prima istruzione: un
    // errore di connessione deve uscire subito, non come errore di riga
    Connetti;

    EseguiIstruzioni(Testo, RigaIniziale);

    if FInterrompi and not FFermato then
    begin
      FEsito.Interrotta := True;
      Annulla('interrotto: transazione annullata');
      FFermato := True;
    end;

    if not FFermato then
    begin
      if Impostazioni.Prova then
        Annulla('prova: transazione annullata, il database non e'' stato modificato')
      else if Assigned(FTransazione) and FTransazione.Active then
      begin
        FTransazione.Commit;

        if FEsito.Errori = 0 then
          Messaggio(tmRiepilogo, 0, 'confermato')
        else
          Messaggio(tmRiepilogo, 0, Format('confermato con %d %s (prosegui dopo un errore)', [FEsito.Errori,
            IfThen(FEsito.Errori = 1, 'errore', 'errori')]));
      end;
    end;
  finally
    FInEsecuzione := False;
    FEsito.Fermata := FFermato;
    FEsito.Millisecondi := Cronometro.ElapsedMilliseconds;
    Result := FEsito;
  end;
end;

procedure TEsecutore.EseguiIstruzioni(const Testo: string; RigaIniziale: Integer);
var
  Istruzioni: TIstruzioni;
  Istruzione: TIstruzione;
  Indice: Integer;
begin
  Istruzioni := DividiScript(Testo);

  for Indice := 0 to High(Istruzioni) do
  begin
    if FInterrompi then
      Break;

    // la riga si riporta a quella dell'editor: con una selezione il testo
    // eseguito non comincia dalla riga 1
    Istruzione := Istruzioni[Indice];
    Istruzione.Riga := Istruzione.Riga + RigaIniziale - 1;

    try
      EseguiIstruzione(Istruzione);
    except
      on E: EErroreConnessione do
        raise;
      on E: Exception do
      begin
        // imprevisto fuori dal server (file illeggibile, INPUT fallito,
        // conferma rifiutata): stessa regola degli errori del server
        Errore(Istruzione, TestoErrore(E));
        FermaSeNonContinua('transazione annullata');
      end;
    end;

    if FFermato then
      Break;

    if Assigned(FOnAvanzamento) then
      FOnAvanzamento(Self);
  end;
end;

procedure TEsecutore.EseguiIstruzione(const Istruzione: TIstruzione);
var
  Parole: TArray<string>;
begin
  Parole := PrimeParole(Istruzione.Testo, 4);

  Messaggio(tmIstruzione, Istruzione.Riga, PrimaRiga(Istruzione.Testo));

  if (Parole[0] = 'SET') and GestisciSet(Istruzione, Parole) then
    Exit;

  if ((Parole[0] = 'COMMIT') or (Parole[0] = 'ROLLBACK')) and not InElenco('TO', Parole) then
  begin
    GestisciFineTransazione(Istruzione, Parole);
    Exit;
  end;

  if Parole[0] = 'INPUT' then
  begin
    GestisciInput(Istruzione);
    Exit;
  end;

  if (Parole[0] = 'EXIT') or (Parole[0] = 'QUIT') then
  begin
    if (Parole[0] = 'EXIT') and not FImpostazioni.Prova then
      Conferma('EXIT: transazione confermata, esecuzione terminata')
    else
    begin
      Annulla('QUIT: transazione annullata, esecuzione terminata');
      // anche senza niente da annullare: lo script ha chiesto di non tenere
      FEsito.Annullata := True;
    end;

    FFermato := True;
    Exit;
  end;

  if (Parole[0] = 'CONNECT') or ((Parole[0] = 'CREATE') and ((Parole[1] = 'DATABASE') or (Parole[1] = 'SCHEMA'))) or
    ((Parole[0] = 'DROP') and (Parole[1] = 'DATABASE')) then
    Errore(Istruzione, Format('%s non ammesso: lo script gira sul database configurato in GestyTools', [Trim(Parole[0] + ' ' + Parole[1])]))
  else if InElenco(Parole[0], ComandiIsql) then
    Errore(Istruzione, Format('%s e'' un comando interattivo di isql, non SQL: GestyTools non lo esegue', [Parole[0]]))
  else if (Parole[0] = 'EXECUTE') and (Parole[1] = 'IBEBLOCK') then
    Errore(Istruzione, 'EXECUTE IBEBLOCK e'' un''estensione di IBExpert: serve IBEScript')
  else if (Parole[0] = 'SET') and (Parole[1] = 'TRANSACTION') then
    Errore(Istruzione, 'SET TRANSACTION non supportato: la transazione la apre GestyTools (READ COMMITTED)')
  else
  begin
    EseguiSulServer(Istruzione, Parole);
    Exit;
  end;

  // errori dei comandi rifiutati qui sopra: stessa regola di quelli del
  // server
  FermaSeNonContinua('transazione annullata');
end;

function TEsecutore.GestisciSet(const Istruzione: TIstruzione; const Parole: TArray<string>): Boolean;
begin
  Result := True;

  if (Parole[1] = 'AUTODDL') or (Parole[1] = 'AUTO') then
  begin
    if FImpostazioni.Prova then
      Esito(Istruzione, 'ignorato: in prova AUTODDL resta spento')
    else
    begin
      if Parole[2] = 'ON' then
        FAutoDdl := True
      else if Parole[2] = 'OFF' then
        FAutoDdl := False
      else
        // senza argomento isql lo inverte
        FAutoDdl := not FAutoDdl;

      if FAutoDdl then
        Esito(Istruzione, 'AUTODDL attivo')
      else
        Esito(Istruzione, 'AUTODDL spento');
    end;
  end
  else if (Parole[1] = 'NAMES') or ((Parole[1] = 'SQL') and (Parole[2] = 'DIALECT')) or (Parole[1] = 'CLIENTLIB') then
    // la connessione e' quella di GestyTools, aperta con la sua
    // configurazione prima dello script
    Avviso(Istruzione, Format('SET %s ignorato: vale la connessione di GestyTools, gia'' aperta', [Parole[1]]))
  else if Parole[1] = 'BAIL' then
  begin
    FContinua := Parole[2] = 'OFF';

    if FContinua then
      Esito(Istruzione, 'BAIL spento: dopo un errore si prosegue')
    else
      Esito(Istruzione, 'BAIL attivo: ci si ferma al primo errore');
  end
  else if InElenco(Parole[1], ComandiSetVisualizzazione) then
    Esito(Istruzione, 'ignorato: impostazione di visualizzazione di isql')
  else
    // SET GENERATOR, SET STATISTICS, SET DEFAULT, SET BIND, SET ROLE...:
    // SQL vero, va al server
    Result := False;
end;

procedure TEsecutore.GestisciFineTransazione(const Istruzione: TIstruzione; const Parole: TArray<string>);
var
  Mantieni: Boolean;
begin
  Mantieni := InElenco('RETAIN', Parole);

  // capita di solito dopo un DDL con AUTODDL, che ha gia' confermato
  if not Assigned(FTransazione) or not FTransazione.Active then
  begin
    if Parole[0] = 'COMMIT' then
      Esito(Istruzione, 'niente da confermare: gia'' confermato')
    else
      Esito(Istruzione, 'niente da annullare: nessuna modifica in sospeso');
    Exit;
  end;

  if Parole[0] = 'COMMIT' then
  begin
    if FImpostazioni.Prova then
      Esito(Istruzione, 'COMMIT non eseguito (prova)')
    else if Mantieni then
    begin
      FTransazione.CommitRetaining;
      Esito(Istruzione, 'confermato (RETAIN)');
    end
    else
    begin
      FTransazione.Commit;
      Esito(Istruzione, 'confermato');
    end;
  end
  else if Mantieni then
  begin
    FTransazione.RollbackRetaining;
    Esito(Istruzione, 'annullato (RETAIN)');
  end
  else
  begin
    FTransazione.Rollback;
    Esito(Istruzione, 'annullato');
  end;
end;

procedure TEsecutore.GestisciInput(const Istruzione: TIstruzione);
var
  Corrispondenza: TMatch;
  NomeFile, ScriptPrecedente, Cartella: string;
  Indice: Integer;
begin
  Corrispondenza := TRegEx.Match(Istruzione.Testo, '^INPUT\s+(?:''([^'']*)''|"([^"]*)"|(\S+))', [roIgnoreCase]);

  NomeFile := '';

  // Groups contiene solo fino all'ultimo gruppo catturato: con il nome fra
  // apici il gruppo 2 e il 3 non ci sono, e leggerli solleva
  if Corrispondenza.Success then
    for Indice := 1 to Corrispondenza.Groups.Count - 1 do
      NomeFile := NomeFile + Corrispondenza.Groups[Indice].Value;

  if NomeFile = '' then
  begin
    Errore(Istruzione, 'INPUT senza nome di file');
    FermaSeNonContinua('transazione annullata');
    Exit;
  end;

  // relativo alla cartella dello script che lo include, non alla cartella
  // corrente
  if FScriptCorrente <> '' then
    Cartella := ExtractFilePath(FScriptCorrente)
  else
    Cartella := FCartellaBase;

  NomeFile := PercorsoAssoluto(NomeFile, Cartella);

  if not TFile.Exists(NomeFile) then
  begin
    Errore(Istruzione, 'script non trovato: ' + NomeFile);
    FermaSeNonContinua('transazione annullata');
    Exit;
  end;

  if FProfondita >= ProfonditaMassima then
  begin
    Errore(Istruzione, Format('INPUT annidati oltre %d livelli: probabile ciclo (%s)', [ProfonditaMassima, NomeFile]));
    FermaSeNonContinua('transazione annullata');
    Exit;
  end;

  Esito(Istruzione, 'esegue ' + NomeFile);

  ScriptPrecedente := FScriptCorrente;
  FScriptCorrente := NomeFile;
  Inc(FProfondita);
  try
    EseguiIstruzioni(LeggiTestoTollerante(NomeFile), 1);
  finally
    Dec(FProfondita);
    FScriptCorrente := ScriptPrecedente;
  end;
end;

procedure TEsecutore.EseguiSulServer(const Istruzione: TIstruzione; const Parole: TArray<string>);
var
  Cronometro: TStopwatch;
  EseguiProcedura: Boolean;
  Ddl: Boolean;
  Tagliato: Boolean;
  Righe: Integer;
  Testo: string;
begin
  Ddl := InElenco(Parole[0], ComandiDdl) or ((Parole[0] = 'SET') and ((Parole[1] = 'GENERATOR') or (Parole[1] = 'STATISTICS')));
  EseguiProcedura := (Parole[0] = 'EXECUTE') and (Parole[1] = 'PROCEDURE');

  IniziaTransazione;

  try
    FQuery.Close;
    FQuery.Params.Clear;
    // solo per EXECUTE PROCEDURE: i valori restituiti arrivano dal driver
    // come una riga (verificato su Firebird 5), ma senza parametri creati
    // la preparazione li perderebbe
    FQuery.ResourceOptions.ParamCreate := EseguiProcedura;
    FQuery.SQL.Text := Istruzione.Testo;

    // una riga in piu' del limite: serve a sapere se ce n'erano altre
    if FImpostazioni.RigheMassime > 0 then
      FQuery.FetchOptions.RecsMax := FImpostazioni.RigheMassime + 1
    else
      FQuery.FetchOptions.RecsMax := -1;

    Cronometro := TStopwatch.StartNew;

    if FQuery.OpenOrExecute then
    begin
      Righe := FQuery.RecordCount;
      Tagliato := (FImpostazioni.RigheMassime > 0) and (Righe > FImpostazioni.RigheMassime);

      if Tagliato then
        Righe := FImpostazioni.RigheMassime;

      Inc(FEsito.Eseguite);
      Inc(FEsito.Risultati);

      if Assigned(FOnRisultato) then
        FOnRisultato(Self, FScriptCorrente, Istruzione.Riga, Istruzione.Testo, FQuery, Tagliato, Cronometro.ElapsedMilliseconds);

      FQuery.Close;

      if Tagliato then
        Esito(Istruzione, Format('prime %d righe, ce ne sono altre - %d ms', [Righe, Cronometro.ElapsedMilliseconds]))
      else if Righe = 1 then
        Esito(Istruzione, Format('1 riga - %d ms', [Cronometro.ElapsedMilliseconds]))
      else
        Esito(Istruzione, Format('%d righe - %d ms', [Righe, Cronometro.ElapsedMilliseconds]));
    end
    else
    begin
      Inc(FEsito.Eseguite);

      if InElenco(Parole[0], ['INSERT', 'UPDATE', 'DELETE', 'MERGE']) then
        Testo := DescrizioneRigheModificate(FQuery.RowsAffected)
      else
        Testo := 'ok';

      if Ddl and FAutoDdl then
      begin
        FTransazione.Commit;
        Testo := Testo + ', confermato (autoddl)';
      end
      else if Ddl and FImpostazioni.Prova then
        FDdlInProva := True;

      Esito(Istruzione, Format('%s - %d ms', [Testo, Cronometro.ElapsedMilliseconds]));
    end;
  except
    on E: Exception do
    begin
      try
        FQuery.Close;
      except
        // il cursore di un'istruzione fallita puo' non chiudersi: conta
        // l'errore originale
      end;

      Testo := TestoErrore(E);

      // verificato su Firebird 5: una tabella creata e non confermata non
      // si puo' usare nella stessa transazione ("Table unknown")
      if FImpostazioni.Prova and FDdlInProva then
        Testo := Testo + sLineBreak + 'NOTA: in prova il DDL non si conferma e Firebird non rende utilizzabili gli oggetti appena ' +
          'creati; per collaudare uno script che crea e poi usa oggetti serve una copia del database';

      Errore(Istruzione, Testo);
      FermaSeNonContinua('transazione annullata: resta nel database solo quello gia'' confermato (COMMIT, autoddl)');
    end;
  end;
end;

end.
