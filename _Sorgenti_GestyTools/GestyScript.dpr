// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program GestyScript;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  System.Classes,
  System.IoUtils,
  System.DateUtils,
  zNet.Tls,
  zNet.Tls.OpenSsl,
  zNet.Tls.SChannel,
  GestyTools.Config in 'GestyTools.Config.pas',
  GestyTools.Connection in 'GestyTools.Connection.pas',
  GestyTools.GDrive in 'GestyTools.GDrive.pas' {GDrive: TDataModule} ,
  GestyTools.FTP in 'GestyTools.FTP.pas' {FTP: TDataModule} ,
  GestyTools.Script in 'GestyTools.Script.pas' {ScriptModule: TDataModule} ,
  GestyTools.Log in 'GestyTools.Log.pas',
  GestyTools.Mail in 'GestyTools.Mail.pas' {TMail: TDataModule} ,
  GestyTools.Candidature in 'GestyTools.Candidature.pas' {ImportCandidature: TDataModule};

var
  FileName: string;
  LogFileName: string;
  Messaggio: string;
  Causa: Exception;

begin

  if paramCount < 1 then
  begin
    Writeln('Utilizzo: GestyScript.exe ScriptFileName');
    exit;
  end;

  FileName := ParamStr(1);

  if not TFile.Exists(FileName) then
  begin
    Writeln('File non trovato: ' + FileName);
    exit;
  end;

  __WriteLog := Procedure(s: string)
    begin
      Writeln(now.toString + ' - ' + s);
    end;

  /// //////////////////////////////////////////////////////////////////////////

  Config.load;

  try
    // Motore TLS per posta e FTP, scelto dalla configurazione (GestyTools.lz)
    // come in GestyTools.dpr. Dentro il try: un codice errato finisce nel
    // .log con ExitCode 1 invece di chiudere il processo senza traccia.
    zNet.Tls.SelezionaProviderTls(Config.TlsProvider);
    Writeln('Motore TLS: ' + zNet.Tls.ProviderTlsSelezionatoDescrizione);

    Mail := TMail.Create(nil);
    try
      Connection := TConnection.Create(nil);
      try
        ImportCandidature := TImportCandidature.Create(nil);
        try
          GDrive := TGDrive.Create(nil);
          try
            FTP := TFTP.Create(nil);
            try
              ScriptModule := TScriptModule.Create(nil);
              try
                ScriptModule.RunFromFile(FileName);
              finally
                FreeAndNil(ScriptModule);
              end;
            finally
              FreeAndNil(FTP);
            end;
          finally
            FreeAndNil(GDrive);
          end;
        finally
          FreeAndNil(ImportCandidature);
        end;
      finally
        FreeAndNil(Connection);
      end;
    finally
      FreeAndNil(Mail);
    end;

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

      // Senza questo, l'utilita' pianificata vede uscire 0 anche quando il
      // backup non e' partito o l'anonimizzazione e' stata rifiutata, e
      // considera riuscita una notte fallita. Vale per tutti gli script, non
      // solo per quelli che anonimizzano.
      ExitCode := 1;
    end;
  end;

  //
  if DebugHook <> 0 then
    ReadLn;

end.


zNet.Tls.SChannel
