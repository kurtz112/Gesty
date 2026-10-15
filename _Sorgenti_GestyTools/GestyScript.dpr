// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program GestyScript;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  System.IoUtils,
  System.DateUtils,
  System.StrUtils,
  System.Hash,
  zNet.Tls,
  zNet.Tls.OpenSsl,
  zNet.Tls.SChannel,
  GestyTools.Config in 'GestyTools.Config.pas',
  GestyTools.Connection in 'GestyTools.Connection.pas',
  GestyTools.FTP in 'GestyTools.FTP.pas' {FTP: TDataModule} ,
  GestyTools.Script in 'GestyTools.Script.pas' {ScriptModule: TDataModule} ,
  GestyTools.Log in 'GestyTools.Log.pas',
  GestyTools.Mail in 'GestyTools.Mail.pas' {TMail: TDataModule} ,
  GestyTools.Candidature in 'GestyTools.Candidature.pas' {ImportCandidature: TDataModule} ,
  Mantis.Client in 'Mantis.Client.pas',
  GestyTools.Mantis in 'GestyTools.Mantis.pas';

const
  // codici di uscita: l'utilita' pianificata e chi controlla le esecuzioni
  // distinguono uno script sbagliato da una notte sfortunata
  UscitaRiuscita = 0;
  UscitaErrore = 1;
  UscitaCompilazione = 2;
  UscitaParametri = 3;
  UscitaGiaInEsecuzione = 4;

type
  EGiaInEsecuzione = class(Exception);
  EConfigurazione = class(Exception);

var
  FileName: string;
  ParametriScript: TArray<string>;
  RichiestaAiuto: boolean;
  SoloVerifica: boolean;
  LogFileName: string;
  Messaggio: string;
  Causa: Exception;
  Inizio: TDateTime;
  Blocco: THandle;

procedure LeggiParametri;
var
  Indice: integer;
  Parametro: string;
begin
  FileName := '';
  ParametriScript := nil;
  RichiestaAiuto := false;
  SoloVerifica := false;

  for Indice := 1 to ParamCount do
  begin
    Parametro := ParamStr(Indice);

    if MatchText(Parametro, ['/help', '/?', '-h', '-?', '--help', '/aiuto']) then
      RichiestaAiuto := True
    else if MatchText(Parametro, ['/verifica', '--verifica']) then
      SoloVerifica := True
    else if SameText(ExtractFileExt(Parametro), '.lz_cfg') then
      // configurazione alternativa: la legge GestyTools.Config
    else if FileName.IsEmpty then
      FileName := ExpandFileName(Parametro)
    else
      ParametriScript := ParametriScript + [Parametro];
  end;
end;

procedure MostraAiuto;
var
  Modulo: TScriptModule;
begin
  Writeln('GestyScript - esegue uno script FastScript (sintassi Pascal) per GestyTools');
  Writeln('');
  Writeln('Utilizzo:');
  Writeln('  GestyScript.exe [opzioni] Script.pas [Configurazione.lz_cfg] [parametri dello script...]');
  Writeln('');
  Writeln('Opzioni:');
  Writeln('  /help, /?     questo testo, con l''elenco delle funzioni disponibili');
  Writeln('  /verifica     compila lo script senza eseguirlo ed esce');
  Writeln('');
  Writeln('Configurazione: GestyTools.lz_cfg accanto all''eseguibile, oppure il file');
  Writeln('.lz_cfg indicato sulla riga di comando.');
  Writeln('I parametri dopo lo script si leggono con ParametroScript(1), ParametroScript(2)...');
  Writeln('');
  Writeln('Registri: GestyScript.log (errori ed esito di ogni esecuzione) e');
  Writeln('Registri\<script>-<data ora>.log (racconto completo, conservato 60 giorni).');
  Writeln('In caso di errore: mail all''assistenza e ticket su Mantis, se configurati.');
  Writeln('');
  Writeln('Codici di uscita:');
  Writeln('  0 riuscito, 1 errore in esecuzione, 2 errore di compilazione,');
  Writeln('  3 parametri o configurazione, 4 lo stesso script e'' gia'' in esecuzione');
  Writeln('');
  Writeln('Funzioni disponibili negli script, oltre a quelle di FastScript:');

  Modulo := TScriptModule.Create(nil);
  try
    Modulo.NonPresidiato := True;
    Modulo.Init;
    Writeln(Modulo.ElencoFunzioni);
  finally
    FreeAndNil(Modulo);
  end;
end;

// Errori nati fuori dallo script (configurazione, TLS, secondo avvio): lo
// script non e' partito, e senza segnalazione la notte sembrerebbe solo vuota
procedure SegnalaFuoriScript(e: Exception);
begin
  if Assigned(Mail) then
    try
      Mail.SegnalaEccezione(e, 'Script: ' + FileName);
    except
      on ErroreMail: Exception do
        Log.ToFile('Invio della mail di errore non riuscito: ' + ErroreMail.ClassName + ': ' + ErroreMail.Message);
    end;

  try
    SegnalaEccezioneSuMantis(e, 'Script: ' + FileName, FileName);
  except
    on ErroreMantis: Exception do
      Log.ToFile('Apertura del ticket Mantis non riuscita: ' + ErroreMantis.ClassName + ': ' + ErroreMantis.Message);
  end;
end;

// Un solo avvio per volta dello stesso script: un backup lento che si
// sovrappone al successivo lavora sulle stesse cartelle e le rovina a
// entrambi. Il nome deriva dal percorso dello script, quindi script diversi
// girano insieme senza problemi.
function BloccaEsecuzione: THandle;
begin
  result := CreateMutex(nil, false, PChar('GestyScript-' + THashMD5.GetHashString(UpperCase(FileName))));

  if (result <> 0) and (GetLastError = ERROR_ALREADY_EXISTS) then
  begin
    CloseHandle(result);
    raise EGiaInEsecuzione.Create('Lo script e'' gia'' in esecuzione (un avvio precedente non e'' terminato): ' + FileName);
  end;
end;

begin
  LeggiParametri;

  __WriteLog := Procedure(s: string)
    begin
      Writeln(now.toString + ' - ' + s);
    end;

  if RichiestaAiuto then
  begin
    MostraAiuto;
    exit;
  end;

  if FileName.IsEmpty then
  begin
    MostraAiuto;
    ExitCode := UscitaParametri;
    exit;
  end;

  if not TFile.Exists(FileName) then
  begin
    Writeln('File non trovato: ' + FileName);
    ExitCode := UscitaParametri;
    exit;
  end;

  if SoloVerifica then
  begin
    ScriptModule := TScriptModule.Create(nil);
    try
      ScriptModule.NonPresidiato := True;
      Messaggio := ScriptModule.VerificaFile(FileName);
    finally
      FreeAndNil(ScriptModule);
    end;

    if Messaggio.IsEmpty then
      Writeln('Script corretto: ' + FileName)
    else
    begin
      Writeln('Errore di compilazione: ' + Messaggio);
      ExitCode := UscitaCompilazione;
    end;
    exit;
  end;

  /// //////////////////////////////////////////////////////////////////////////

  Inizio := Now;
  Blocco := 0;
  Log.AvviaRegistroEsecuzione(FileName);
  Log.ToScreen('Avvio ' + FileName);

  try
    Mail := TMail.Create(nil);
    try
      // dentro il try: un file di configurazione illeggibile o un motore TLS
      // sconosciuto finiscono nel .log con il loro codice di uscita invece di
      // chiudere il processo senza traccia
      try
        Config.load;
      except
        on ErroreConfigurazione: Exception do
          raise EConfigurazione.Create('Configurazione non leggibile: ' + ErroreConfigurazione.Message);
      end;

      Blocco := BloccaEsecuzione;

      // Motore TLS per posta e FTP, scelto dalla configurazione (GestyTools.lz)
      // come in GestyTools.dpr
      zNet.Tls.SelezionaProviderTls(Config.TlsProvider);
      Log.ToScreen('Motore TLS: ' + zNet.Tls.ProviderTlsSelezionatoDescrizione);

      if Config.SmtpUtente.IsEmpty or Config.SmtpPassword.IsEmpty then
        Log.ToFile('Attenzione: SMTP non configurato, le mail di errore non partiranno.');
      if Config.MantisToken.IsEmpty then
        Log.ToScreen('Mantis non configurato: gli errori non apriranno ticket.');

      Connection := TConnection.Create(nil);
      try
        ImportCandidature := TImportCandidature.Create(nil);
        try
          FTP := TFTP.Create(nil);
          try
            ScriptModule := TScriptModule.Create(nil);
            try
              ScriptModule.NonPresidiato := True;
              ScriptModule.ParametriScript := ParametriScript;
              ScriptModule.RunFromFile(FileName);
            finally
              FreeAndNil(ScriptModule);
            end;
          finally
            FreeAndNil(FTP);
          end;
        finally
          FreeAndNil(ImportCandidature);
        end;
      finally
        FreeAndNil(Connection);
      end;

      Log.ToFile('ESITO OK ' + FileName + ' durata ' + FormatDateTime('hh:nn:ss', Now - Inizio));
    except
      on E: Exception do
      begin
        // Indy avvolge l'errore vero in un'eccezione generica (per il TLS
        // "SSL negotiation failed"): la causa del motore sta nelle eccezioni
        // interne, e senza questa catena nel registro non resta traccia.
        Messaggio := E.ClassName + ': ' + E.Message;
        Causa := E.InnerException;
        while Assigned(Causa) do
        begin
          Messaggio := Messaggio + sLineBreak + '  causa: ' + Causa.ClassName + ': ' + Causa.Message;
          Causa := Causa.InnerException;
        end;

        Writeln(Messaggio);

        LogFileName := ChangeFileExt(ParamStr(0), '.log');
        TFile.AppendAllText(LogFileName, DateTimeToStr(now) + ' - ' + zNet.Tls.ProviderTlsSelezionato + ' - ' + Messaggio + sLineBreak);

        if not ErroreScriptSegnalato then
          SegnalaFuoriScript(E);

        // Senza un codice diverso da 0, l'utilita' pianificata considera
        // riuscita una notte fallita. Vale per tutti gli script, non solo per
        // quelli che anonimizzano.
        if E is EScriptCompilazione then
          ExitCode := UscitaCompilazione
        else if E is EGiaInEsecuzione then
          ExitCode := UscitaGiaInEsecuzione
        else if E is EConfigurazione then
          ExitCode := UscitaParametri
        else
          ExitCode := UscitaErrore;

        Log.ToFile('ESITO ERRORE ' + FileName + ' codice ' + ExitCode.ToString + ' durata ' + FormatDateTime('hh:nn:ss', Now - Inizio));
      end;
    end;
  finally
    if Blocco <> 0 then
      CloseHandle(Blocco);
    FreeAndNil(Mail);
  end;

  //
  if DebugHook <> 0 then
    ReadLn;

end.
