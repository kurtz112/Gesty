unit GestyTools.Log;

interface

uses
  System.SysUtils,
  System.Classes;

type
  TLog = record
  private
    class function FormatMessageLog(const msg: string): string; static;
    class function FileName: String; static;
    class procedure Ricorda(const msg: string); static;
    class procedure ScriviRegistroEsecuzione(const msg: string; SvuotaSubito: Boolean); static;
  public
    class procedure ToFile(const msg: string); static;
    class procedure ToScreen(const msg: string); static;

    // Riga di avanzamento di un servizio che ne manda a centinaia di migliaia
    // (backup e ripristino con Verbose): finisce per intero nel registro
    // dell'esecuzione, ma sullo schermo compare al massimo una volta ogni due
    // secondi. ToScreen su ognuna rallentava il backup: una Writeln su console
    // per riga, piu' l'attesa del server a ogni riga.
    class procedure Avanzamento(const msg: string); static;

    // Da chiamare quando il servizio finisce: scrive quante righe di
    // avanzamento sono arrivate, cosi' chi guarda lo schermo sa che non ne ha
    // viste altre
    class procedure ChiudiAvanzamento; static;

    // ultime righe passate da ToFile e ToScreen, dalla piu' vecchia alla piu'
    // recente: la mail di errore le riporta per dire quale passo dello script
    // era in corso, senza dover chiedere al cliente il registro
    class function UltimeRighe: string; static;

    // Registro della singola esecuzione di GestyScript: da qui in poi ToFile
    // e ToScreen scrivono anche in Registri\<script>-<data ora>.log accanto
    // all'eseguibile. Il .log cumulativo resta per gli errori e per la riga
    // di esito; questo contiene tutto il racconto dello script, ed e' il file
    // che si allega al ticket Mantis. I registri piu' vecchi di
    // GiorniConservati vengono cancellati qui.
    class procedure AvviaRegistroEsecuzione(const NomeScript: string; GiorniConservati: integer = 60); static;
    class function FileRegistroEsecuzione: string; static;
  end;

var
  Log: TLog;

  __WriteLog: TProc<string> = nil;

implementation

uses
  Winapi.Windows,
  System.IOUtils,
  System.DateUtils,
  Vcl.Forms;

const
  NumeroRigheRicordate = 30;

  // il registro dell'esecuzione resta aperto per tutta l'esecuzione: riaprirlo
  // a ogni riga (AppendAllText) costava apertura, scrittura e chiusura del file
  // per ognuna delle centinaia di migliaia di righe di un backup
  DimensioneBufferRegistro = 65536;
  IntervalloSvuotamentoMs = 1000;
  IntervalloSchermoMs = 2000;

var
  RigheRecenti: TStringList = nil;
  RegistroEsecuzione: string = '';
  ScrittoreRegistro: TStreamWriter = nil;
  UltimoSvuotamento: UInt64 = 0;
  UltimoAvanzamentoSchermo: UInt64 = 0;
  AvanzamentiTotali: Integer = 0;

procedure SvuotaRegistro;
begin
  if ScrittoreRegistro = nil then
    Exit;

  ScrittoreRegistro.Flush;
  UltimoSvuotamento := GetTickCount64;
end;

procedure ChiudiRegistro;
begin
  // il Free svuota il buffer: se il disco e' pieno proprio qui, nessuno puo'
  // piu' farci niente
  try
    FreeAndNil(ScrittoreRegistro);
  except
    ScrittoreRegistro := nil;
  end;
end;

class function TLog.FileName: String;
begin
  result := ChangeFileExt(Application.ExeName, '.log');
end;

class procedure TLog.ToFile(const msg: string);
begin
  Ricorda(msg);
  // errori ed esiti vanno su disco subito, senza aspettare il buffer
  ScriviRegistroEsecuzione(msg, True);

  // senza il ritorno a capo le righe del .log finivano attaccate l'una
  // all'altra
  TFile.AppendAllText(TLog.FileName, TLog.FormatMessageLog(msg) + sLineBreak);
end;

class procedure TLog.ToScreen(const msg: string);
begin
  Ricorda(msg);
  ScriviRegistroEsecuzione(msg, False);

  if assigned(__WriteLog) then
    __WriteLog(TLog.FormatMessageLog(msg));
end;

class procedure TLog.Avanzamento(const msg: string);
var
  Adesso: UInt64;
begin
  Ricorda(msg);
  ScriviRegistroEsecuzione(msg, False);
  Inc(AvanzamentiTotali);

  Adesso := GetTickCount64;

  if (UltimoAvanzamentoSchermo <> 0) and (Adesso - UltimoAvanzamentoSchermo < IntervalloSchermoMs) then
    Exit;

  UltimoAvanzamentoSchermo := Adesso;

  if assigned(__WriteLog) then
    __WriteLog(TLog.FormatMessageLog(msg));
end;

class procedure TLog.ChiudiAvanzamento;
var
  Riepilogo: string;
begin
  if AvanzamentiTotali = 0 then
    Exit;

  Riepilogo := Format('Avanzamento: %d righe ricevute dal server, sullo schermo una ogni %d secondi', [AvanzamentiTotali, IntervalloSchermoMs div 1000]);

  if not RegistroEsecuzione.IsEmpty then
    Riepilogo := Riepilogo + '; tutte nel registro dell''esecuzione';

  AvanzamentiTotali := 0;
  UltimoAvanzamentoSchermo := 0;

  ToScreen(Riepilogo);
end;

class procedure TLog.ScriviRegistroEsecuzione(const msg: string; SvuotaSubito: Boolean);
begin
  if RegistroEsecuzione.IsEmpty then
    Exit;

  // il registro dell'esecuzione serve a capire un errore: se non si riesce a
  // scriverlo (disco pieno, cartella in sola lettura) lo script prosegue
  try
    // chiuso da FileRegistroEsecuzione per lasciarlo leggere: si riapre in coda
    if ScrittoreRegistro = nil then
      ScrittoreRegistro := TStreamWriter.Create(RegistroEsecuzione, True, TEncoding.UTF8, DimensioneBufferRegistro);

    ScrittoreRegistro.WriteLine(FormatDateTime('yyyy-mm-dd hh:nn:ss', now) + ' ' + msg);

    // il buffer va su disco subito per errori ed esiti, e comunque almeno una
    // volta al secondo: se il processo muore, si perde al massimo l'ultimo secondo
    if SvuotaSubito or (GetTickCount64 - UltimoSvuotamento >= IntervalloSvuotamentoMs) then
      SvuotaRegistro;
  except
    ChiudiRegistro;
    RegistroEsecuzione := '';
  end;
end;

class procedure TLog.AvviaRegistroEsecuzione(const NomeScript: string; GiorniConservati: integer);
var
  Cartella: string;
  Prefisso: string;
  Registro: string;
begin
  Cartella := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + 'Registri\';
  Prefisso := ChangeFileExt(ExtractFileName(NomeScript), '');

  try
    TDirectory.CreateDirectory(Cartella);

    for Registro in TDirectory.GetFiles(Cartella, '*.log') do
      if DaysBetween(Now, TFile.GetLastWriteTime(Registro)) > GiorniConservati then
        TFile.Delete(Registro);

    Registro := Cartella + Prefisso + '-' + FormatDateTime('yyyymmdd-hhnnss', now) + '.log';

    // il costruttore con il nome del file apre con fmShareDenyWrite: l'allegato
    // al ticket Mantis legge il file mentre e' ancora aperto
    ScrittoreRegistro := TStreamWriter.Create(Registro, False, TEncoding.UTF8, DimensioneBufferRegistro);
    UltimoSvuotamento := GetTickCount64;

    RegistroEsecuzione := Registro;
  except
    // senza registro dell'esecuzione lo script parte lo stesso: resta il .log
    ChiudiRegistro;
    RegistroEsecuzione := '';
  end;
end;

class function TLog.FileRegistroEsecuzione: string;
begin
  // chi chiede il percorso sta per leggere il file (allegato al ticket Mantis):
  // un file aperto in scrittura non si legge con TFile.ReadAllBytes, quindi si
  // chiude, svuotando il buffer; la riga successiva lo riapre in coda
  ChiudiRegistro;

  result := RegistroEsecuzione;
end;

class procedure TLog.Ricorda(const msg: string);
begin
  RigheRecenti.Add(FormatDateTime('hh:nn:ss', now) + ' ' + msg);

  while RigheRecenti.Count > NumeroRigheRicordate do
    RigheRecenti.Delete(0);
end;

class function TLog.UltimeRighe: string;
begin
  result := RigheRecenti.Text;
end;

class function TLog.FormatMessageLog(const msg: string): string;
begin
  result := FormatDateTime('yyyymmdd hh nn - ', now) + ' - ' + msg;
end;

initialization

RigheRecenti := TStringList.Create;

finalization

ChiudiRegistro;
FreeAndNil(RigheRecenti);

end.
