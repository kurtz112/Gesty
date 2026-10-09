// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
// JCL_DEBUG_EXPERT_INSERTJDBG OFF
// JCL_DEBUG_EXPERT_DELETEMAPFILE OFF
program GestyTests;

// Runner console DUnitX dei test di Gesty. Le unit sotto test si raggiungono
// coi percorsi relativi qui sotto (..\..\_Sorgenti), le loro dipendenze di
// zPack (zz.GenericCollection) dal library path. Nessuna connessione
// Firebird, nessuna form e nessuna rete in esecuzione: i protocolli AI e il
// client SIUF costruiscono e leggono JSON senza spedirlo.
//
// Opzioni utili da riga di comando (DUnitX):
//   --exit:Continue           nessuna pausa a fine esecuzione (catena di zBuilder)
//   --xmlfile:<file>          esito in formato NUnit (relativo alla cartella corrente)

{$APPTYPE CONSOLE}
{$STRONGLINKTYPES ON}
{$R *.res}

uses
  System.SysUtils,
  // Il TClientDataSet dei test del Builder SIUF senza midas.dll accanto all'exe
  MidasLib,
  DUnitX.TestFramework,
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  // tipi applicativi
  Test.Gesty.Types in 'Test.Gesty.Types.pas',
  Test.ValutazioniPrestazioni.Types in 'Test.ValutazioniPrestazioni.Types.pas',
  // BASE\AI: strumenti, protocolli dei fornitori, configurazione
  Test.zAI.Tools in 'Test.zAI.Tools.pas',
  Test.zAI.Protocol in 'Test.zAI.Protocol.pas',
  Test.zAI.Configuration in 'Test.zAI.Configuration.pas',
  // cooperazione applicativa SIUF
  Test.SIUF.Types in 'Test.SIUF.Types.pas',
  Test.SIUF.Validator in 'Test.SIUF.Validator.pas',
  Test.SIUF.Builder in 'Test.SIUF.Builder.pas',
  Test.SIUF.Client in 'Test.SIUF.Client.pas',
  // unit sotto test
  Gesty.Types in '..\..\_Sorgenti\Varie\Gesty.Types.pas',
  ValutazioniPrestazioni.types in '..\..\_Sorgenti\Varie\ValutazioniPrestazioni.types.pas',
  zAI.Tools in '..\..\_Sorgenti\BASE\AI\zAI.Tools.pas',
  zAI.Protocol in '..\..\_Sorgenti\BASE\AI\zAI.Protocol.pas',
  zAI.Protocol.OpenAI in '..\..\_Sorgenti\BASE\AI\zAI.Protocol.OpenAI.pas',
  zAI.Protocol.Ollama in '..\..\_Sorgenti\BASE\AI\zAI.Protocol.Ollama.pas',
  zAI.Protocol.Gemini in '..\..\_Sorgenti\BASE\AI\zAI.Protocol.Gemini.pas',
  zAI.Protocol.Claude in '..\..\_Sorgenti\BASE\AI\zAI.Protocol.Claude.pas',
  zAI.Configuration in '..\..\_Sorgenti\BASE\AI\zAI.Configuration.pas',
  SIUF.CooperazioneApplicativa.Types in '..\..\_Sorgenti\API\CooperazioneApplicativa\SIUF.CooperazioneApplicativa.Types.pas',
  SIUF.CooperazioneApplicativa.Validator in '..\..\_Sorgenti\API\CooperazioneApplicativa\SIUF.CooperazioneApplicativa.Validator.pas',
  SIUF.CooperazioneApplicativa.Builder in '..\..\_Sorgenti\API\CooperazioneApplicativa\SIUF.CooperazioneApplicativa.Builder.pas',
  SIUF.CooperazioneApplicativa.Client in '..\..\_Sorgenti\API\CooperazioneApplicativa\SIUF.CooperazioneApplicativa.Client.pas';

var
  Runner: ITestRunner;
  Results: IRunResults;
begin
  try
    TDUnitX.CheckCommandLine;
    Runner := TDUnitX.CreateRunner;
    Runner.UseRTTI := True;
    Runner.FailsOnNoAsserts := True;

    Runner.AddLogger(TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet));
    // Percorso reso assoluto: con un nome senza cartella (--xmlfile:esito.xml)
    // TDUnitXXMLNUnitFileLogger chiama ForceDirectories('') e solleva
    // EInOutError "Unable to create directory" prima di eseguire i test
    if TDUnitX.Options.XMLOutputFile <> '' then
      Runner.AddLogger(TDUnitXXMLNUnitFileLogger.Create(ExpandFileName(TDUnitX.Options.XMLOutputFile)));

    Results := Runner.Execute;
    if not Results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Premere INVIO per uscire.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
    begin
      System.Writeln(E.ClassName, ': ', E.Message);
      System.ExitCode := EXIT_ERRORS;
    end;
  end;
end.
