// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-15
// ---------------------------------------------------------------------------
unit GestyTools.Mantis;

// Ponte fra GestyTools e Mantis.Client: un ticket per ogni errore di uno
// script, con il registro dell'esecuzione e lo script allegati.
//
// Un ticket per errore, non una nota su un ticket gia' aperto: una nota non
// compare fra i ticket nuovi e non si vede subito. Il ticket e' privato (lo
// vede chi ha accesso ai privati, non gli utenti del cliente sul progetto) e
// assegnato a MantisAssegnatario, se indicato, cosi' parte la notifica.

interface

uses
  System.SysUtils;

// Non fa niente se MantisToken e' vuoto. Solleva se Mantis rifiuta o non
// risponde: chi chiama decide cosa farne (GestyTools.Script lo scrive nel
// .log e prosegue con la mail).
procedure SegnalaEccezioneSuMantis(e: Exception; const Contesto, NomeScript: string);

implementation

uses
  System.Classes,
  System.IOUtils,
  Mantis.Client,
  GestyTools.Config,
  GestyTools.Log,
  GestyTools.Mail;

const
  // Mantis ha un tetto di caricamento (di solito 2 MB): oltre, si allegano
  // solo le ultime righe
  DimensioneMassimaAllegato = 1024 * 1024;

function LeggiPerAllegato(const FileName: string): TBytes;
var
  Contenuto: TBytes;
begin
  Contenuto := TFile.ReadAllBytes(FileName);

  if Length(Contenuto) <= DimensioneMassimaAllegato then
    Exit(Contenuto);

  // la coda e' la parte che racconta l'errore
  result := Copy(Contenuto, Length(Contenuto) - DimensioneMassimaAllegato, DimensioneMassimaAllegato);
end;

procedure AggiungiAllegato(var Allegati: TArray<TMantisAllegato>; const FileName: string);
var
  Allegato: TMantisAllegato;
begin
  if FileName.IsEmpty or not TFile.Exists(FileName) then
    Exit;

  // un file non leggibile non deve impedire l'apertura del ticket
  try
    Allegato.Nome := ExtractFileName(FileName);
    Allegato.Contenuto := LeggiPerAllegato(FileName);
    Allegati := Allegati + [Allegato];
  except
    on Errore: Exception do
      Log.ToFile('Mantis: allegato non leggibile ' + FileName + ': ' + Errore.Message);
  end;
end;

procedure SegnalaEccezioneSuMantis(e: Exception; const Contesto, NomeScript: string);
var
  Client: TMantisClient;
  Ticket: TMantisTicket;
  IdTicket: integer;
  Allegati: TArray<TMantisAllegato>;
  PrimaRiga: string;
begin
  if Config.MantisToken.Trim.IsEmpty then
    Exit;

  Ticket.Progetto := Config.MantisProgetto;
  if Ticket.Progetto.IsEmpty then
    Ticket.Progetto := Config.Ente;

  if Ticket.Progetto.IsEmpty then
    raise Exception.Create('Mantis: ne'' MantisProgetto ne'' Ente sono valorizzati nella configurazione.');

  PrimaRiga := e.Message.Trim;
  if Pos(#13, PrimaRiga) > 0 then
    PrimaRiga := Copy(PrimaRiga, 1, Pos(#13, PrimaRiga) - 1);
  if Pos(#10, PrimaRiga) > 0 then
    PrimaRiga := Copy(PrimaRiga, 1, Pos(#10, PrimaRiga) - 1);

  Ticket.Categoria := Config.MantisCategoria;
  Ticket.Oggetto := '[GestyScript] ' + Config.Ente + ' - ' + ExtractFileName(NomeScript) + ': ' + PrimaRiga;
  Ticket.Descrizione := TMail.DescriviEccezione(e, Contesto);
  Ticket.InformazioniAggiuntive := 'Registro dell''esecuzione: ' + Log.FileRegistroEsecuzione;
  Ticket.Assegnatario := Config.MantisAssegnatario;
  Ticket.Gravita := 'major';
  Ticket.Privato := True;

  Client := TMantisClient.Create(Config.MantisUrl, Config.MantisToken);
  try
    IdTicket := Client.ApriTicket(Ticket);
    Log.ToFile('Errore segnalato su Mantis, ticket ' + IdTicket.ToString);

    // il ticket c'e' gia': se gli allegati non passano lo si dice nel
    // registro, senza sollevare
    AggiungiAllegato(Allegati, Log.FileRegistroEsecuzione);
    AggiungiAllegato(Allegati, NomeScript);
    try
      Client.AllegaFile(IdTicket, Allegati);
    except
      on Errore: Exception do
        Log.ToFile('Mantis: allegati non caricati sul ticket ' + IdTicket.ToString + ': ' + Errore.Message);
    end;
  finally
    FreeAndNil(Client);
  end;
end;

end.
