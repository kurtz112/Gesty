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
  public
    class procedure ToFile(const msg: string); static;
    class procedure ToScreen(const msg: string); static;

    // ultime righe passate da ToFile e ToScreen, dalla piu' vecchia alla piu'
    // recente: la mail di errore le riporta per dire quale passo dello script
    // era in corso, senza dover chiedere al cliente il registro
    class function UltimeRighe: string; static;
  end;

var
  Log: TLog;

  __WriteLog: TProc<string> = nil;

implementation

uses
  System.IOUtils,
  Vcl.Forms;

const
  NumeroRigheRicordate = 30;

var
  RigheRecenti: TStringList = nil;

class function TLog.FileName: String;
begin
  result := ChangeFileExt(Application.ExeName, '.log');
end;

class procedure TLog.ToFile(const msg: string);
begin
  Ricorda(msg);

  // senza il ritorno a capo le righe del .log finivano attaccate l'una
  // all'altra
  TFile.AppendAllText(TLog.FileName, TLog.FormatMessageLog(msg) + sLineBreak);
end;

class procedure TLog.ToScreen(const msg: string);
begin
  Ricorda(msg);

  if assigned(__WriteLog) then
    __WriteLog(TLog.FormatMessageLog(msg));
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
