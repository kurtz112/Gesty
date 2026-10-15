unit GestyTools.Script;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Data.DB,
  fs_iinirtti,
  fs_iclassesrtti,
  fs_ipascal,
  fs_iinterpreter;

type
  // compilazione dello script non riuscita: GestyScript esce con un codice
  // diverso da quello di un errore in esecuzione
  EScriptCompilazione = class(Exception);

  TGestoreFunzione = reference to function(var Params: Variant): Variant;
  TGestoreProcedura = reference to procedure(var Params: Variant);

  TScriptModule = class(TDataModule)
    fsScript: TfsScript;
    fsPascal: TfsPascal;
    fsClassesRTTI: TfsClassesRTTI;
    fsIniRTTI: TfsIniRTTI;
  private
    // Registro delle funzioni esposte agli script: dichiarazione e gestore
    // stanno nella stessa chiamata a Registra, e CallMethod cerca il gestore
    // per nome. Prima il collegamento passava per la posizione in un array e
    // un case numerico: una voce inserita nel posto sbagliato spostava tutte
    // le successive e faceva chiamare la funzione sbagliata senza errori di
    // compilazione. Chiave in maiuscolo: FastScript passa MethodName cosi'.
    FGestori: TDictionary<string, TGestoreFunzione>;
    FDichiarazioni: TStringList;
    FNonPresidiato: boolean;
    FParametriScript: TArray<string>;
    procedure RegistraFunzione(const Dichiarazione: string; Gestore: TGestoreFunzione);
    procedure RegistraProcedura(const Dichiarazione: string; Gestore: TGestoreProcedura);
    procedure RegistraFunzioni;
  private
    procedure EmptyFolder(const Folder: string);
    procedure DeleteFile(const FileName: string);
    procedure CopyFile(const SrcFileName, DestFileName: string; Sovrascrivi: boolean);
    procedure Compress(const FileName, ZipFileName: string);
    procedure CompressFolder(const Folder, ZipFileName: string);
    function ConfigValore(const Nome: string): string;
    procedure EliminaPiuVecchiDi(const Cartella, Maschera: string; Giorni: integer);
    procedure ConservaUltimi(const Cartella, Maschera: string; Numero: integer);
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
    destructor Destroy; override;

    procedure Init;
    procedure LoadFromFile(const FileName: string);

    procedure RunFromFile(const FileName: String);

    // compila senza eseguire: vuoto se lo script e' corretto, altrimenti
    // posizione e messaggio dell'errore (GestyScript /verifica)
    function VerificaFile(const FileName: string): string;

    function CompileScript(const Script: string): boolean;
    procedure ExecuteScript(const Script: string); overload;
    procedure ExecuteScript; overload;
    function Evaluate(const variable: string): string;

    procedure TestConnessione;

    // dichiarazioni delle funzioni esposte, una per riga (GestyScript /help)
    function ElencoFunzioni: string;

    // True quando lo script gira senza nessuno davanti (GestyScript, utilita'
    // pianificate): ShowMessage scrive nel registro invece di aprire una
    // finestra che resterebbe in attesa di un clic per sempre. L'editor degli
    // script lo lascia False e ShowMessage resta quella di FastScript.
    property NonPresidiato: boolean read FNonPresidiato write FNonPresidiato;

    // parametri passati a GestyScript dopo il nome dello script
    property ParametriScript: TArray<string> read FParametriScript write FParametriScript;
  end;

var
  ScriptModule: TScriptModule;

  // True quando l'errore e' gia' stato segnalato (mail e Mantis) da
  // RunFromFile: GestyScript.dpr non lo segnala una seconda volta
  ErroreScriptSegnalato: boolean = false;

implementation

uses
  System.IOUtils,
  System.Zip,
  System.StrUtils,
  System.Variants,
  System.DateUtils,
  System.TypInfo,
  System.Generics.Defaults,
  GestyTools.Log,
  GestyTools.Config,
  GestyTools.Connection,
  GestyTools.Mail,
  GestyTools.Mantis,
  GestyTools.Candidature,
  GestyTools.FTP;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

const
  // Proprieta' di Config che uno script puo' leggere con ConfigValore. Elenco
  // chiuso di proposito: lo script e' un file in chiaro sul server del
  // cliente, e password, token e chiavi di anonimizzazione non devono poter
  // finire in un Writeln o in una mail.
  ConfigLeggibili: array [0 .. 14] of string = ('Ente', 'Server', 'Port', 'DB', 'DBFolder', 'DBFileName', 'FolderBin', 'FolderUpdate', 'FolderBackupDB',
    'FolderBackupExe', 'FtpHost', 'FtpPort', 'FtpDefaultFolder', 'Remote_BackupFolder', 'Remote_UpdateZip');

constructor TScriptModule.Create(aOwner: TComponent);
begin
  inherited;
  FGestori := TDictionary<string, TGestoreFunzione>.Create;
  FDichiarazioni := TStringList.Create;
  FNonPresidiato := false;
end;

destructor TScriptModule.Destroy;
begin
  FreeAndNil(FGestori);
  FreeAndNil(FDichiarazioni);
  inherited;
end;

procedure TScriptModule.RegistraFunzione(const Dichiarazione: string; Gestore: TGestoreFunzione);
var
  Nome: string;
  Inizio: integer;
  Fine: integer;
begin
  // nome = la parola dopo procedure/function, fino a '(' ':' ';' o spazio
  Inizio := Pos(' ', Dichiarazione) + 1;
  Fine := Inizio;
  while (Fine <= Length(Dichiarazione)) and not CharInSet(Dichiarazione[Fine], ['(', ':', ';', ' ']) do
    Inc(Fine);
  Nome := UpperCase(Copy(Dichiarazione, Inizio, Fine - Inizio));

  // due voci con lo stesso nome: FastScript le accetterebbe entrambe e ne
  // userebbe una a caso
  if FGestori.ContainsKey(Nome) then
    raise Exception.Create('GestyScript: funzione registrata due volte: ' + Nome);

  FGestori.Add(Nome, Gestore);
  FDichiarazioni.Add(Dichiarazione.TrimRight([';']));
  fsScript.AddMethod(Dichiarazione, CallMethod);
end;

procedure TScriptModule.RegistraProcedura(const Dichiarazione: string; Gestore: TGestoreProcedura);
begin
  RegistraFunzione(Dichiarazione,
    function(var Params: Variant): Variant
    begin
      Gestore(Params);
      result := Null;
    end);
end;

procedure TScriptModule.Init;
begin
  fsScript.Parent := fsGlobalUnit;

  FGestori.Clear;
  FDichiarazioni.Clear;

  RegistraFunzioni;
end;

procedure TScriptModule.RegistraFunzioni;
begin
  // ---------------------------------------------------------------------
  // Registro e messaggi
  RegistraProcedura('procedure Writeln(s:string)',
    procedure(var Params: Variant)
    begin
      Log.ToScreen(Params[0]);
    end);

  RegistraProcedura('procedure Log(s:string)',
    procedure(var Params: Variant)
    begin
      Log.ToScreen(Params[0]);
    end);

  // sostituisce ShowMessage di FastScript solo senza nessuno davanti: la
  // ricerca di FastScript guarda prima lo script e poi fsGlobalUnit
  if FNonPresidiato then
    RegistraProcedura('procedure ShowMessage(Msg: Variant)',
      procedure(var Params: Variant)
      begin
        Log.ToScreen('ShowMessage: ' + VarToStr(Params[0]));
      end);

  RegistraProcedura('procedure Notifica(const Oggetto, Testo: string)',
    procedure(var Params: Variant)
    begin
      Mail.InviaMail(Config.Ente + ' - ' + VarToStr(Params[0]), VarToStr(Params[1]));
    end);

  // ---------------------------------------------------------------------
  // Percorsi
  RegistraFunzione('function ExtractFileDir(const FileName: string): string',
    function(var Params: Variant): Variant
    begin
      result := ExtractFileDir(Params[0]);
    end);

  RegistraFunzione('function ExtractFileName(const FileName: string): string',
    function(var Params: Variant): Variant
    begin
      result := ExtractFileName(Params[0]);
    end);

  RegistraFunzione('function ChangeFileExt(const FileName, Extension: string): string',
    function(var Params: Variant): Variant
    begin
      result := ChangeFileExt(Params[0], Params[1]);
    end);

  RegistraFunzione('function IncludeTrailingBackslash(const path:string) :string',
    function(var Params: Variant): Variant
    begin
      result := IncludeTrailingBackslash(Params[0]);
    end);

  // ---------------------------------------------------------------------
  // File e cartelle
  RegistraFunzione('function FileExists(const FileName: string): boolean',
    function(var Params: Variant): Variant
    begin
      result := TFile.Exists(Params[0]);
    end);

  RegistraFunzione('function DirectoryExists(const Dir: string): boolean',
    function(var Params: Variant): Variant
    begin
      result := TDirectory.Exists(Params[0]);
    end);

  RegistraFunzione('function FileSize(const FileName: string): Int64',
    function(var Params: Variant): Variant
    begin
      if not TFile.Exists(Params[0]) then
        raise Exception.Create('FileSize: file non trovato: ' + VarToStr(Params[0]));
      result := TFile.GetSize(Params[0]);
    end);

  RegistraFunzione('function FileDate(const FileName: string): TDateTime',
    function(var Params: Variant): Variant
    begin
      if not TFile.Exists(Params[0]) then
        raise Exception.Create('FileDate: file non trovato: ' + VarToStr(Params[0]));
      result := TFile.GetLastWriteTime(Params[0]);
    end);

  RegistraFunzione('function ForceDirectories(const Dir: string): boolean',
    function(var Params: Variant): Variant
    begin
      // crea la cartella e le intermedie mancanti; True anche se esisteva gia'
      result := ForceDirectories(Params[0]);
    end);

  RegistraProcedura('procedure EmptyFolder(Folder: string)',
    procedure(var Params: Variant)
    begin
      EmptyFolder(Params[0]);
    end);

  RegistraProcedura('procedure DeleteFile(const FileName: string)',
    procedure(var Params: Variant)
    begin
      DeleteFile(Params[0]);
    end);

  RegistraProcedura('procedure CopyFile(const SrcFileName, DestFileName: string; Sovrascrivi: boolean = False)',
    procedure(var Params: Variant)
    begin
      CopyFile(Params[0], Params[1], Params[2]);
    end);

  RegistraProcedura('procedure EliminaPiuVecchiDi(const Cartella, Maschera: string; Giorni: integer)',
    procedure(var Params: Variant)
    begin
      EliminaPiuVecchiDi(Params[0], Params[1], Params[2]);
    end);

  RegistraProcedura('procedure ConservaUltimi(const Cartella, Maschera: string; Numero: integer)',
    procedure(var Params: Variant)
    begin
      ConservaUltimi(Params[0], Params[1], Params[2]);
    end);

  RegistraFunzione('function LoadFile(const FileName: string): string',
    function(var Params: Variant): Variant
    begin
      result := TFile.ReadAllText(Params[0]);
    end);

  RegistraProcedura('procedure Compress(const FileName, ZipFileName: string)',
    procedure(var Params: Variant)
    begin
      Compress(Params[0], Params[1]);
    end);

  RegistraProcedura('procedure CompressFolder(const Folder, ZipFileName: string)',
    procedure(var Params: Variant)
    begin
      CompressFolder(Params[0], Params[1]);
    end);

  // ---------------------------------------------------------------------
  // Configurazione e parametri
  RegistraFunzione('function ConfigValore(const Nome: string): string',
    function(var Params: Variant): Variant
    begin
      result := ConfigValore(Params[0]);
    end);

  RegistraFunzione('function ParametroScript(Indice: integer): string',
    function(var Params: Variant): Variant
    var
      Indice: integer;
    begin
      // da 1, come ParamStr; fuori dall'intervallo restituisce ''
      Indice := Params[0];
      if (Indice >= 1) and (Indice <= Length(FParametriScript)) then
        result := FParametriScript[Indice - 1]
      else
        result := '';
    end);

  RegistraFunzione('function NumeroParametriScript: integer',
    function(var Params: Variant): Variant
    begin
      result := Length(FParametriScript);
    end);

  // ---------------------------------------------------------------------
  // Database di produzione
  RegistraProcedura('procedure dbConnect',
    procedure(var Params: Variant)
    begin
      Connection.Connect;
    end);

  RegistraProcedura('procedure dbDisconnect',
    procedure(var Params: Variant)
    begin
      Connection.Disconnect;
    end);

  RegistraProcedura('procedure dbBackup(const FilenameFbk: string)',
    procedure(var Params: Variant)
    begin
      Connection.Backup(Params[0]);
    end);

  RegistraProcedura('procedure dbRestore(const FilenameFbk, FileNameFdb: string)',
    procedure(var Params: Variant)
    begin
      Connection.Restore(Params[0], Params[1]);
    end);

  RegistraProcedura
    ('procedure SP(StoredProcName: string; param0:string=''''; param1:string=''''; param2:string=''''; param3: string = ''''; param4: string = ''''; param5: string = ''''; param6: string = ''''; param7: string = ''''; param8: string = ''''; param9: string = '''')',
    procedure(var Params: Variant)
    begin
      Connection.ExecStoredProc(Params);
    end);

  RegistraProcedura
    ('procedure ExecSP(StoredProcName: string; param0:string=''''; param1:string=''''; param2:string=''''; param3: string = ''''; param4: string = ''''; param5: string = ''''; param6: string = ''''; param7: string = ''''; param8: string = ''''; param9: string = '''')',
    procedure(var Params: Variant)
    begin
      Connection.ExecStoredProc(Params);
    end);

  RegistraProcedura('procedure TestConnessione',
    procedure(var Params: Variant)
    begin
      TestConnessione;
    end);

  // ---------------------------------------------------------------------
  // Anonimizzazione (sbarramenti in GestyTools.Connection): erano
  // implementate in TConnection ma non registrate qui, e SP rifiuta
  // ANONYMIZER rimandando proprio a queste voci
  RegistraFunzione('function AnonimizzaInizializza: string',
    function(var Params: Variant): Variant
    begin
      result := Connection.AnonimizzaInizializza;
    end);

  RegistraProcedura('procedure AnonimizzaCopia(const DatabaseCopia: string)',
    procedure(var Params: Variant)
    begin
      Connection.AnonimizzaCopia(Params[0]);
    end);

  RegistraProcedura('procedure HomecomingCopia(const DatabaseCopia: string)',
    procedure(var Params: Variant)
    begin
      Connection.HomecomingCopia(Params[0]);
    end);

  // ---------------------------------------------------------------------
  // Import candidature
  fsScript.AddEnum('TImportCandidatureType', 'icCSV, icXlsx');
  RegistraProcedura('procedure ImportFileCandidature(const url: string; ImportType: TImportCandidatureType; const MapFileName: string = '''')',
    procedure(var Params: Variant)
    begin
      ImportCandidature.ImportFile(Params[0], Params[1], Params[2]);
    end);

  // ---------------------------------------------------------------------
  // FTP
  RegistraProcedura('procedure FtpConnect',
    procedure(var Params: Variant)
    begin
      FTP.Connect;
    end);

  RegistraProcedura('procedure FtpDisconnect',
    procedure(var Params: Variant)
    begin
      FTP.Disconnect;
    end);

  RegistraFunzione('function FtpRemoteFileExists(const FileName: string): boolean',
    function(var Params: Variant): Variant
    begin
      result := FTP.RemoteFileExists(Params[0]);
    end);

  RegistraProcedura('procedure FtpChangeDir(folder: string)',
    procedure(var Params: Variant)
    begin
      FTP.ChangeDir(Params[0]);
    end);

  RegistraProcedura('procedure FtpListFiles(Files: TStrings)',
    procedure(var Params: Variant)
    begin
      // l'oggetto creato dallo script arriva come puntatore in un intero
      // (frInteger = NativeInt in FastScript). Prima il ramo era commentato
      // e lo script riceveva un elenco vuoto senza nessun errore
      FTP.ListFiles(TStrings(NativeInt(Params[0])));
    end);

  RegistraProcedura('procedure FtpDownload(const SrcFileName, DestFileName: string)',
    procedure(var Params: Variant)
    begin
      FTP.Download(Params[0], Params[1]);
    end);

  RegistraProcedura('procedure FtpUpload(const SrcFileName, DestFileName: string)',
    procedure(var Params: Variant)
    begin
      FTP.Upload(Params[0], Params[1]);
    end);

  RegistraProcedura('procedure FtpDelete(const FileName: string)',
    procedure(var Params: Variant)
    begin
      FTP.Delete(Params[0]);
    end);
end;

function TScriptModule.ElencoFunzioni: string;
begin
  result := FDichiarazioni.Text;
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
      raise EScriptCompilazione.Create('Compilazione dello script non riuscita, posizione ' + fsScript.ErrorPos + ': ' + fsScript.ErrorMsg)
    else
      raise EScriptCompilazione.Create('Compilazione dello script non riuscita, ' + fsScript.ErrorUnit + ' posizione ' + fsScript.ErrorPos + ': ' + fsScript.ErrorMsg);
  except
    on e: exception do
    begin
      SegnalaErrore(e);
      raise;
    end;
  end;
end;

function TScriptModule.VerificaFile(const FileName: string): string;
begin
  LoadFromFile(FileName);

  if fsScript.Compile then
    result := ''
  else if fsScript.ErrorUnit = '' then
    result := 'posizione ' + fsScript.ErrorPos + ': ' + fsScript.ErrorMsg
  else
    result := fsScript.ErrorUnit + ' posizione ' + fsScript.ErrorPos + ': ' + fsScript.ErrorMsg;
end;

procedure TScriptModule.SegnalaErrore(e: exception);
var
  Contesto: string;
begin
  Contesto := ContestoErrore;

  // Mail e Mantis indipendenti: un errore nell'invio di una delle due (SMTP
  // irraggiungibile, token scaduto) non deve impedire l'altra, ne' prendere
  // il posto dell'errore dello script nel .log di GestyScript
  try
    Mail.SegnalaEccezione(e, Contesto);
  except
    on ErroreMail: exception do
      Log.ToFile('Invio della mail di errore non riuscito: ' + ErroreMail.ClassName + ': ' + ErroreMail.Message);
  end;

  try
    SegnalaEccezioneSuMantis(e, Contesto, FScriptFileName);
  except
    on ErroreMantis: exception do
      Log.ToFile('Apertura del ticket Mantis non riuscita: ' + ErroreMantis.ClassName + ': ' + ErroreMantis.Message);
  end;

  ErroreScriptSegnalato := True;
end;

procedure TScriptModule.ScriptRunLine(Sender: TfsScript; const UnitName, SourcePos: String);
begin
  FUnitInEsecuzione := UnitName;
  FPosizioneInEsecuzione := SourcePos;
end;

function TScriptModule.DescriviChiamata(const MethodName: String; const Params: Variant): string;

  // un indirizzo con una query (ImportFileCandidature) puo' portare una
  // chiave di accesso: nella mail e nel ticket resta solo la parte prima
  // del '?'
  function Mascherato(const Valore: string): string;
  var
    Domanda: integer;
  begin
    result := Valore;
    Domanda := Pos('?', result);
    if (Pos('://', result) > 0) and (Domanda > 0) then
      result := Copy(result, 1, Domanda) + '...';
  end;

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
        result := result + QuotedStr(Mascherato(VarToStrDef(Params[Indice], '')));
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
var
  Nome: string;
  Gestore: TGestoreFunzione;
begin
  Nome := UpperCase(MethodName);

  if not FGestori.TryGetValue(Nome, Gestore) then
    raise Exception.Create('GestyScript: funzione senza gestore: ' + MethodName);

  // Writeln, Log e ShowMessage sono chiamate innocue e frequentissime: non
  // coprono la funzione che stava davvero lavorando
  if not MatchStr(Nome, ['WRITELN', 'LOG', 'SHOWMESSAGE']) then
    FChiamataInCorso := DescriviChiamata(MethodName, Params);

  result := Gestore(Params);

  // finita bene: se l'errore viene dopo, non e' colpa di questa funzione
  FChiamataInCorso := '';
end;

procedure TScriptModule.CopyFile(const SrcFileName, DestFileName: string; Sovrascrivi: boolean);
begin

  if not TFile.Exists(SrcFileName) then
    raise exception.Create('CopyFile: file sorgente non trovato: ' + SrcFileName);

  if TFile.Exists(DestFileName) and not Sovrascrivi then
    raise exception.Create('CopyFile: la destinazione esiste gia'' (usare Sovrascrivi = True): ' + DestFileName);

  TFile.Copy(SrcFileName, DestFileName, Sovrascrivi);
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

procedure TScriptModule.EliminaPiuVecchiDi(const Cartella, Maschera: string; Giorni: integer);
var
  FileName: string;
  Eliminati: integer;
begin
  // zero o meno cancellerebbe anche il backup appena fatto
  if Giorni < 1 then
    raise exception.Create('EliminaPiuVecchiDi: Giorni deve essere almeno 1.');

  if not TDirectory.Exists(Cartella) then
    raise exception.Create('EliminaPiuVecchiDi: cartella non trovata: ' + Cartella);

  Eliminati := 0;
  for FileName in TDirectory.GetFiles(Cartella, Maschera) do
    if Now - TFile.GetLastWriteTime(FileName) > Giorni then
    begin
      TFile.Delete(FileName);
      Inc(Eliminati);
    end;

  Log.ToScreen(Format('EliminaPiuVecchiDi: %d file eliminati da %s', [Eliminati, Cartella]));
end;

procedure TScriptModule.ConservaUltimi(const Cartella, Maschera: string; Numero: integer);
var
  Elenco: TArray<string>;
  Indice: integer;
begin
  // zero o meno cancellerebbe tutti i backup
  if Numero < 1 then
    raise exception.Create('ConservaUltimi: Numero deve essere almeno 1.');

  if not TDirectory.Exists(Cartella) then
    raise exception.Create('ConservaUltimi: cartella non trovata: ' + Cartella);

  Elenco := TDirectory.GetFiles(Cartella, Maschera);

  // dal piu' recente al piu' vecchio
  TArray.Sort<string>(Elenco, TComparer<string>.Construct(
    function(const Sinistro, Destro: string): integer
    begin
      result := CompareDateTime(TFile.GetLastWriteTime(Destro), TFile.GetLastWriteTime(Sinistro));
    end));

  for Indice := Numero to High(Elenco) do
    TFile.Delete(Elenco[Indice]);

  if Length(Elenco) > Numero then
    Log.ToScreen(Format('ConservaUltimi: %d file eliminati da %s', [Length(Elenco) - Numero, Cartella]));
end;

function TScriptModule.ConfigValore(const Nome: string): string;
var
  Voce: string;
begin
  for Voce in ConfigLeggibili do
    if SameText(Voce, Nome) then
      Exit(VarToStr(GetPropValue(Config, Voce)));

  raise exception.Create('ConfigValore: voce non leggibile dagli script: ' + Nome);
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
begin
  TZipFile.ZipDirectoryContents(ZipFileName, Folder);
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

end.
