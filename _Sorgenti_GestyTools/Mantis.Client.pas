// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-15
// ---------------------------------------------------------------------------
unit Mantis.Client;

// Client minimo della REST API di MantisBT (https://<host>/api/rest): apre un
// ticket e gli allega dei file. Non dipende da nessuna unit applicativa: e'
// pronto per essere spostato in zPack (per esempio zPack\Net\, accanto a
// zNet.Tls) e usato anche da WT e dagli strumenti.
//
// Usa THTTPClient di System.Net, che passa per WinHTTP e quindi per il TLS di
// Windows: non dipende da OpenSSL ne' dal motore scelto in zNet.Tls.

interface

uses
  System.SysUtils,
  System.Classes;

type
  TMantisAllegato = record
    Nome: string;
    Contenuto: TBytes;
  end;

  TMantisTicket = record
    // nome del progetto Mantis (per Gesty, uno per cliente)
    Progetto: string;
    // la categoria deve esistere nel progetto, altrimenti Mantis rifiuta
    Categoria: string;
    // al massimo 128 caratteri: Mantis rifiuta i titoli piu' lunghi
    Oggetto: string;
    Descrizione: string;
    InformazioniAggiuntive: string;
    // nome utente Mantis; vuoto = nessuno
    Assegnatario: string;
    // nome della gravita' di Mantis (minor, major, crash...); vuoto = predefinita
    Gravita: string;
    Privato: boolean;
  end;

  TMantisClient = class
  private
    FUrl: string;
    FToken: string;
    FTempoMassimo: integer;
    function Invia(const Percorso, Corpo: string): string;
  public
    // TempoMassimo in millisecondi, per la connessione e per la risposta
    constructor Create(const Url, Token: string; TempoMassimo: integer = 15000);

    // restituisce il numero del ticket
    function ApriTicket(const Ticket: TMantisTicket): integer;

    // POST /issues/{id}/files con il contenuto in base64 dentro il JSON:
    // l'endpoint di Mantis non accetta multipart/form-data (verificato con
    // zMCP_Mantis)
    procedure AllegaFile(IdTicket: integer; const Allegati: TArray<TMantisAllegato>);
  end;

implementation

uses
  System.JSON,
  System.NetEncoding,
  System.Net.URLClient,
  System.Net.HttpClient;

constructor TMantisClient.Create(const Url, Token: string; TempoMassimo: integer);
begin
  inherited Create;

  if Url.Trim.IsEmpty then
    raise Exception.Create('Mantis: indirizzo non indicato.');

  if Token.Trim.IsEmpty then
    raise Exception.Create('Mantis: token non indicato.');

  FUrl := Url.Trim.TrimRight(['/']);
  FToken := Token.Trim;
  FTempoMassimo := TempoMassimo;
end;

function TMantisClient.Invia(const Percorso, Corpo: string): string;
var
  Client: THTTPClient;
  Sorgente: TStringStream;
  Risposta: IHTTPResponse;
begin
  Client := THTTPClient.Create;
  try
    Client.ConnectionTimeout := FTempoMassimo;
    Client.ResponseTimeout := FTempoMassimo;
    Client.ContentType := 'application/json';
    Client.CustomHeaders['Authorization'] := FToken;

    Sorgente := TStringStream.Create(Corpo, TEncoding.UTF8);
    try
      Risposta := Client.Post(FUrl + '/api/rest' + Percorso, Sorgente);
    finally
      FreeAndNil(Sorgente);
    end;

    result := Risposta.ContentAsString(TEncoding.UTF8);

    if (Risposta.StatusCode < 200) or (Risposta.StatusCode > 299) then
      raise Exception.CreateFmt('Mantis HTTP %d su POST %s: %s', [Risposta.StatusCode, Percorso, Copy(result, 1, 500)]);
  finally
    FreeAndNil(Client);
  end;
end;

function TMantisClient.ApriTicket(const Ticket: TMantisTicket): integer;

  function Nominato(const Nome: string): TJSONObject;
  begin
    result := TJSONObject.Create;
    result.AddPair('name', Nome);
  end;

var
  Corpo: TJSONObject;
  Risposta: TJSONValue;
  Testo: string;
begin
  Corpo := TJSONObject.Create;
  try
    Corpo.AddPair('summary', Copy(Ticket.Oggetto, 1, 128));
    Corpo.AddPair('description', Ticket.Descrizione);

    if not Ticket.InformazioniAggiuntive.IsEmpty then
      Corpo.AddPair('additional_information', Ticket.InformazioniAggiuntive);

    Corpo.AddPair('project', Nominato(Ticket.Progetto));
    Corpo.AddPair('category', Nominato(Ticket.Categoria));

    if Ticket.Privato then
      Corpo.AddPair('view_state', Nominato('private'))
    else
      Corpo.AddPair('view_state', Nominato('public'));

    if not Ticket.Assegnatario.IsEmpty then
      Corpo.AddPair('handler', Nominato(Ticket.Assegnatario));

    if not Ticket.Gravita.IsEmpty then
      Corpo.AddPair('severity', Nominato(Ticket.Gravita));

    Testo := Invia('/issues', Corpo.ToJSON);
  finally
    FreeAndNil(Corpo);
  end;

  Risposta := TJSONObject.ParseJSONValue(Testo);
  try
    if not Assigned(Risposta) or not Risposta.TryGetValue<integer>('issue.id', result) then
      raise Exception.Create('Mantis: risposta senza numero del ticket: ' + Copy(Testo, 1, 500));
  finally
    FreeAndNil(Risposta);
  end;
end;

procedure TMantisClient.AllegaFile(IdTicket: integer; const Allegati: TArray<TMantisAllegato>);
var
  Corpo: TJSONObject;
  Elenco: TJSONArray;
  Voce: TJSONObject;
  Allegato: TMantisAllegato;
  Codifica: TBase64Encoding;
begin
  if Length(Allegati) = 0 then
    Exit;

  // senza a capo: TNetEncoding.Base64 ne inserisce uno ogni 76 caratteri,
  // e dentro una stringa JSON non servono
  Codifica := TBase64Encoding.Create(0);
  Corpo := TJSONObject.Create;
  try
    Elenco := TJSONArray.Create;
    Corpo.AddPair('files', Elenco);

    for Allegato in Allegati do
    begin
      Voce := TJSONObject.Create;
      Voce.AddPair('name', Allegato.Nome);
      Voce.AddPair('content', Codifica.EncodeBytesToString(Allegato.Contenuto));
      Elenco.AddElement(Voce);
    end;

    Invia(Format('/issues/%d/files', [IdTicket]), Corpo.ToJSON);
  finally
    FreeAndNil(Corpo);
    FreeAndNil(Codifica);
  end;
end;

end.
