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
    class procedure ScriviRegistroEsecuzione(const msg: string); static;
  public
    class procedure ToFile(const msg: string); static;
    class procedure ToScreen(const msg: string); static;

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
  System.IOUtils,
  System.DateUtils,
  Vcl.Forms;

const
  NumeroRigheRicordate = 30;

var
  RigheRecenti: TStringList = nil;
  RegistroEsecuzione: string = '';

class function TLog.FileName: String;
begin
  result := ChangeFileExt(Application.ExeName, '.log');
end;

class procedure TLog.ToFile(const msg: string);
begin
  Ricorda(msg);
  ScriviRegistroEsecuzione(msg);

  // senza il ritorno a capo le righe del .log finivano attaccate l'una
  // all'altra
  TFile.AppendAllText(TLog.FileName, TLog.FormatMessageLog(msg) + sLineBreak);
end;

class procedure TLog.ToScreen(const msg: string);
begin
  Ricorda(msg);
  ScriviRegistroEsecuzione(msg);

  if assigned(__WriteLog) then
    __WriteLog(TLog.FormatMessageLog(msg));
end;

class procedure TLog.ScriviRegistroEsecuzione(const msg: string);
begin
  if RegistroEsecuzione.IsEmpty then
    Exit;

  // il registro dell'esecuzione serve a capire un errore: se non si riesce a
  // scriverlo (disco pieno, cartella in sola lettura) lo script prosegue
  try
    TFile.AppendAllText(RegistroEsecuzione, FormatDateTime('yyyy-mm-dd hh:nn:ss', now) + ' ' + msg + sLineBreak, TEncoding.UTF8);
  except
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

    RegistroEsecuzione := Cartella + Prefisso + '-' + FormatDateTime('yyyymmdd-hhnnss', now) + '.log';
  except
    // senza registro dell'esecuzione lo script parte lo stesso: resta il .log
    RegistroEsecuzione := '';
  end;
end;

class function TLog.FileRegistroEsecuzione: string;
begin
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

FreeAndNil(RigheRecenti);

end.
