// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-22
// ---------------------------------------------------------------------------
unit Gesty.Outlook;

// Sincronizzazione dell'agenda personale (tabella AGENDA) dell'utente collegato
// con il suo calendario Outlook, via Microsoft Graph con permessi delegati.
//
// - Configurazione: CONFIG.OUTLOOK_TENANT_ID e CONFIG.OUTLOOK_CLIENT_ID, dalla
//   registrazione dell'applicazione fatta dal CED. Vuoti = funzione spenta.
// - Collegamento: USR_UTENTI_OUTLOOK, una riga per utente. Il refresh token e'
//   protetto con la protezione dati di Windows (DPAPI) dell'utente: su un altro
//   PC o profilo non si decifra e si rifa' l'accesso.
// - Ognuno sincronizza solo la propria agenda: la persona e' CURRENT_ID_RISORSA(),
//   come nell'agenda (SCHEDA_PERSONALE).
//
// Ordine di una sincronizzazione:
// 1. Outlook -> Gesty: eventi cambiati dall'ultima volta (lettura delta);
// 2. eventi cancellati in Gesty (AGENDA_OUTLOOK_ELIMINAZIONI) -> cancellati in Outlook;
// 3. Gesty -> Outlook: eventi nuovi o modificati in Gesty (OUTLOOK_DA_INVIARE).
// Le scritture su AGENDA impostano SINCRONIZZAZIONE_OUTLOOK nel contesto della
// transazione, cosi' i trigger non le scambiano per modifiche dell'utente.
//
// Limiti voluti:
// - AGENDA ha un giorno solo: gli eventi Outlook su piu' giorni non si importano;
//   quelli di giornata intera diventano 00:00-23:59;
// - il testo dell'evento va a Outlook solo alla creazione: Gesty conserva solo
//   l'anteprima (255 caratteri) e aggiornarlo cancellerebbe il testo completo.

interface

uses
  System.SysUtils;

type
  TSincronizzazioneOutlook = class
  public
    // CONFIG ha ID tenant e ID applicazione: la funzione e' accesa
    class function Disponibile: Boolean;
    // l'utente collegato ha gia' fatto l'accesso a Outlook
    class function Collegato: Boolean;
    // Interattiva = False non apre mai il browser: se l'accesso va rifatto si ferma.
    // Esito: testo per l'utente, anche in caso di errore
    class function Sincronizza(const Interattiva: Boolean; out Esito: string): Boolean;
    // toglie il collegamento e l'aggancio degli eventi agli eventi Outlook
    class procedure Scollega;
  end;

implementation

uses
  Winapi.Windows,
  System.Classes,
  System.Variants,
  System.DateUtils,
  System.NetEncoding,
  System.Generics.Collections,
  Data.DB,
  FireDAC.Stan.Param,
  FireDAC.Comp.Client,
  ConfigModule,
  MicrosoftGraph.Autorizzazione,
  MicrosoftGraph.Calendario,
  SmartInspect.Vcl.SiAuto;

const
  GIORNI_INDIETRO = 30;
  GIORNI_AVANTI = 365;
  // oltre questa eta' la finestra della lettura delta e' troppo vecchia: si riparte
  GIORNI_VALIDITA_DELTA = 60;

type
  DATA_BLOB = record
    cbData: DWORD;
    pbData: PByte;
  end;
  PDATA_BLOB = ^DATA_BLOB;

function CryptProtectData(pDataIn: PDATA_BLOB; szDataDescr: PWideChar; pOptionalEntropy: PDATA_BLOB; pvReserved: Pointer; pPromptStruct: Pointer; dwFlags: DWORD; pDataOut: PDATA_BLOB): BOOL; stdcall; external 'crypt32.dll';
function CryptUnprotectData(pDataIn: PDATA_BLOB; ppszDataDescr: PPWideChar; pOptionalEntropy: PDATA_BLOB; pvReserved: Pointer; pPromptStruct: Pointer; dwFlags: DWORD; pDataOut: PDATA_BLOB): BOOL; stdcall; external 'crypt32.dll';

const
  CRYPTPROTECT_UI_FORBIDDEN = $1;

type
  TEventoAgenda = record
    IdAgenda: Int64;
    DataEvento: TDate;
    OraInizio: TTime;
    OraFine: TTime;
    Oggetto: string;
    Note: string;
    OutlookIdEvento: string;
  end;

  // Una sincronizzazione: vive il tempo di Sincronizza
  TSessioneOutlook = class
  strict private
    FTransazione: TFDTransaction;
    FQuery: TFDQuery;
    FAutorizzazione: TMicrosoftGraphAutorizzazione;
    FCalendario: TMicrosoftGraphCalendario;
    FUserId: Int64;
    FIdRisorsa: Int64;
    FIdCalendario: string;
    FDeltaLink: string;
    FDeltaDal: TDate;
    FRicevuti: Integer;
    FInviati: Integer;
    FEliminati: Integer;
    FIgnorati: Integer;
    function LeggiToken: string;
    procedure Inizia;
    procedure Conferma;
    procedure Annulla;
    procedure ImpostaContesto;
    function Accedi(const Interattiva: Boolean; const RefreshTokenCifrato: string; out Esito: string): Boolean;
    function ControllaAccount(out Account: string; out Esito: string): Boolean;
    procedure SalvaCollegamento(const Account: string);
    procedure SalvaEsito(const Esito: string);
    procedure RiceviDaOutlook;
    procedure ApplicaEvento(const Evento: TMicrosoftGraphEvento);
    procedure InviaEliminazioni;
    procedure InviaAOutlook;
  public
    constructor Create;
    destructor Destroy; override;
    function Esegui(const Interattiva: Boolean; out Esito: string): Boolean;
  end;

function Proteggi(const Testo: string): string;
var
  Dati: TBytes;
  Ingresso: DATA_BLOB;
  Uscita: DATA_BLOB;
  Risultato: TBytes;
  Codifica: TBase64Encoding;
begin
  Dati := TEncoding.UTF8.GetBytes(Testo);
  Ingresso.cbData := Length(Dati);
  Ingresso.pbData := @Dati[0];
  if not CryptProtectData(@Ingresso, 'Gesty Outlook', nil, nil, nil, CRYPTPROTECT_UI_FORBIDDEN, @Uscita) then
    RaiseLastOSError;
  try
    SetLength(Risultato, Uscita.cbData);
    Move(Uscita.pbData^, Risultato[0], Uscita.cbData);
  finally
    LocalFree(HLOCAL(Uscita.pbData));
  end;

  Codifica := TBase64Encoding.Create(0);
  try
    Result := Codifica.EncodeBytesToString(Risultato);
  finally
    Codifica.Free;
  end;
end;

function Sblocca(const TestoProtetto: string; out Testo: string): Boolean;
var
  Dati: TBytes;
  Ingresso: DATA_BLOB;
  Uscita: DATA_BLOB;
  Risultato: TBytes;
  Codifica: TBase64Encoding;
begin
  // falso se il testo e' stato protetto da un altro utente Windows o su un altro PC
  Testo := '';
  if TestoProtetto = '' then
    Exit(False);

  Codifica := TBase64Encoding.Create(0);
  try
    Dati := Codifica.DecodeStringToBytes(TestoProtetto);
  finally
    Codifica.Free;
  end;
  if Length(Dati) = 0 then
    Exit(False);

  Ingresso.cbData := Length(Dati);
  Ingresso.pbData := @Dati[0];
  if not CryptUnprotectData(@Ingresso, nil, nil, nil, nil, CRYPTPROTECT_UI_FORBIDDEN, @Uscita) then
    Exit(False);
  try
    SetLength(Risultato, Uscita.cbData);
    Move(Uscita.pbData^, Risultato[0], Uscita.cbData);
  finally
    LocalFree(HLOCAL(Uscita.pbData));
  end;

  Testo := TEncoding.UTF8.GetString(Risultato);
  Result := Testo <> '';
end;

function ValoreTesto(const Valore: Variant): string;
begin
  if VarIsNull(Valore) or VarIsEmpty(Valore) then
    Result := ''
  else
    Result := VarToStr(Valore);
end;

{ TSincronizzazioneOutlook }

class function TSincronizzazioneOutlook.Disponibile: Boolean;
var
  TenantId: string;
  ClientId: string;
begin
  try
    TenantId := ValoreTesto(Config.Database.ExecSQLScalar('SELECT CONFIG.OUTLOOK_TENANT_ID FROM CONFIG'));
    ClientId := ValoreTesto(Config.Database.ExecSQLScalar('SELECT CONFIG.OUTLOOK_CLIENT_ID FROM CONFIG'));
    Result := (TenantId.Trim <> '') and (ClientId.Trim <> '');
  except
    on E: Exception do
    begin
      // database senza lo script della sincronizzazione: la funzione resta spenta
      SiMain.LogError('Sincronizzazione con Outlook non disponibile: ' + E.Message);
      Result := False;
    end;
  end;
end;

class function TSincronizzazioneOutlook.Collegato: Boolean;
begin
  Result := not VarIsNull(Config.Database.ExecSQLScalar(
    'SELECT USR_UTENTI_OUTLOOK.USER_ID FROM USR_UTENTI_OUTLOOK ' +
    'WHERE USR_UTENTI_OUTLOOK.USER_ID = CURRENT_USER_ID() AND USR_UTENTI_OUTLOOK.ATTIVO = TRUE'));
end;

class function TSincronizzazioneOutlook.Sincronizza(const Interattiva: Boolean; out Esito: string): Boolean;
var
  Sessione: TSessioneOutlook;
begin
  Sessione := TSessioneOutlook.Create;
  try
    Result := Sessione.Esegui(Interattiva, Esito);
  finally
    Sessione.Free;
  end;
end;

class procedure TSincronizzazioneOutlook.Scollega;
var
  Transazione: TFDTransaction;
  Query: TFDQuery;
begin
  Transazione := TFDTransaction.Create(nil);
  Query := TFDQuery.Create(nil);
  try
    Transazione.Connection := Config.Database;
    Query.Connection := Config.Database;
    Query.Transaction := Transazione;
    Query.UpdateTransaction := Transazione;

    Transazione.StartTransaction;
    try
      // senza contesto i trigger segnerebbero gli eventi come da inviare
      Query.Open('SELECT RDB$SET_CONTEXT(''USER_TRANSACTION'', ''SINCRONIZZAZIONE_OUTLOOK'', ''1'') FROM RDB$DATABASE');
      Query.Close;

      // un collegamento successivo, anche con un altro account, ricrea gli eventi in Outlook
      Query.ExecSQL(
        'UPDATE AGENDA SET ' +
        '  AGENDA.OUTLOOK_ID_EVENTO = NULL, ' +
        '  AGENDA.OUTLOOK_CHANGE_KEY = NULL, ' +
        '  AGENDA.OUTLOOK_DATA_MODIFICA = NULL, ' +
        '  AGENDA.OUTLOOK_DA_INVIARE = FALSE ' +
        'WHERE AGENDA.ID_RISORSA = CURRENT_ID_RISORSA() AND AGENDA.OUTLOOK_ID_EVENTO IS NOT NULL');
      Query.ExecSQL('DELETE FROM AGENDA_OUTLOOK_ELIMINAZIONI WHERE AGENDA_OUTLOOK_ELIMINAZIONI.ID_RISORSA = CURRENT_ID_RISORSA()');
      Query.ExecSQL('DELETE FROM USR_UTENTI_OUTLOOK WHERE USR_UTENTI_OUTLOOK.USER_ID = CURRENT_USER_ID()');

      Transazione.Commit;
    except
      Transazione.Rollback;
      raise;
    end;
  finally
    Query.Free;
    Transazione.Free;
  end;
end;

{ TSessioneOutlook }

constructor TSessioneOutlook.Create;
begin
  inherited Create;
  FTransazione := TFDTransaction.Create(nil);
  FTransazione.Connection := Config.Database;

  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := Config.Database;
  FQuery.Transaction := FTransazione;
  FQuery.UpdateTransaction := FTransazione;

  FAutorizzazione := TMicrosoftGraphAutorizzazione.Create(nil);
  FCalendario := TMicrosoftGraphCalendario.Create(LeggiToken);
end;

destructor TSessioneOutlook.Destroy;
begin
  if FTransazione.Active then
    FTransazione.Rollback;
  FreeAndNil(FCalendario);
  FreeAndNil(FAutorizzazione);
  FreeAndNil(FQuery);
  FreeAndNil(FTransazione);
  inherited Destroy;
end;

function TSessioneOutlook.LeggiToken: string;
begin
  // rinnova il token se e' scaduto (dura circa un'ora)
  FAutorizzazione.ValidateAccessToken;
  if FAutorizzazione.AccessToken = '' then
    raise EMicrosoftGraph.Create('Accesso a Microsoft 365 scaduto: rifai la sincronizzazione dall''agenda');
  Result := FAutorizzazione.AccessToken;
end;

procedure TSessioneOutlook.Inizia;
begin
  FTransazione.StartTransaction;
end;

procedure TSessioneOutlook.Conferma;
begin
  FTransazione.Commit;
end;

procedure TSessioneOutlook.Annulla;
begin
  if FTransazione.Active then
    FTransazione.Rollback;
end;

procedure TSessioneOutlook.ImpostaContesto;
begin
  FQuery.Open('SELECT RDB$SET_CONTEXT(''USER_TRANSACTION'', ''SINCRONIZZAZIONE_OUTLOOK'', ''1'') FROM RDB$DATABASE');
  FQuery.Close;
end;

function TSessioneOutlook.Accedi(const Interattiva: Boolean; const RefreshTokenCifrato: string; out Esito: string): Boolean;
var
  RefreshToken: string;
begin
  Result := False;
  Esito := '';

  // prima il refresh token salvato: niente browser se e' ancora valido
  if Sblocca(RefreshTokenCifrato, RefreshToken) then
  begin
    FAutorizzazione.Load('', RefreshToken, 'Bearer');
    if FAutorizzazione.RefreshAccessToken then
    begin
      FAutorizzazione.StartAuthorization;
      if FAutorizzazione.IsAuthorized then
        Exit(True);
    end;
  end;

  if not Interattiva then
  begin
    Esito := 'L''accesso a Outlook va rinnovato: usa "Sincronizza con Outlook" nell''agenda.';
    Exit;
  end;

  FAutorizzazione.FinishAuthorization;
  FAutorizzazione.StartAuthorization;
  Result := FAutorizzazione.IsAuthorized;

  if not Result then
  begin
    if FAutorizzazione.UltimoErrore <> '' then
      Esito := 'Accesso a Microsoft 365 non riuscito: ' + FAutorizzazione.UltimoErrore
    else
      Esito := 'Accesso a Microsoft 365 non completato.';
  end;
end;

function TSessioneOutlook.ControllaAccount(out Account: string; out Esito: string): Boolean;
var
  Profilo: TMicrosoftGraphProfilo;
  MailUtente: string;
begin
  Esito := '';
  Profilo := FCalendario.Profilo;

  Account := Profilo.NomeAccesso;
  if Account = '' then
    Account := Profilo.Mail;

  MailUtente := ValoreTesto(Config.Database.ExecSQLScalar(
    'SELECT USR_UTENTI.E_MAIL FROM USR_UTENTI WHERE USR_UTENTI.USER_ID = CURRENT_USER_ID()')).Trim;

  // ognuno collega il proprio calendario: l'account deve essere quello dell'utente di Gesty
  Result := (MailUtente = '') or SameText(MailUtente, Profilo.Mail) or SameText(MailUtente, Profilo.NomeAccesso);

  if not Result then
    Esito := Format('L''account Microsoft usato (%s) non corrisponde alla mail del tuo utente di Gesty (%s): ' +
      'rifai l''accesso con il tuo account.', [Account, MailUtente]);
end;

procedure TSessioneOutlook.SalvaCollegamento(const Account: string);
begin
  Inizia;
  try
    FQuery.SQL.Text :=
      'UPDATE OR INSERT INTO USR_UTENTI_OUTLOOK ' +
      '  (USER_ID, ACCOUNT_MICROSOFT, REFRESH_TOKEN_CIFRATO, ATTIVO) ' +
      'VALUES ' +
      '  (:USER_ID, :ACCOUNT_MICROSOFT, :REFRESH_TOKEN_CIFRATO, TRUE) ' +
      'MATCHING (USER_ID)';
    FQuery.ParamByName('USER_ID').AsLargeInt := FUserId;
    FQuery.ParamByName('ACCOUNT_MICROSOFT').AsString := Account;
    FQuery.ParamByName('REFRESH_TOKEN_CIFRATO').AsWideMemo := Proteggi(FAutorizzazione.RefreshToken);
    FQuery.ExecSQL;
    Conferma;
  except
    Annulla;
    raise;
  end;
end;

procedure TSessioneOutlook.SalvaEsito(const Esito: string);
begin
  Inizia;
  try
    FQuery.SQL.Text :=
      'UPDATE USR_UTENTI_OUTLOOK SET ' +
      '  USR_UTENTI_OUTLOOK.DATA_ULTIMA_SINCRONIZZAZIONE = CURRENT_TIMESTAMP, ' +
      '  USR_UTENTI_OUTLOOK.ESITO_ULTIMA_SINCRONIZZAZIONE = :ESITO ' +
      'WHERE USR_UTENTI_OUTLOOK.USER_ID = :USER_ID';
    FQuery.ParamByName('ESITO').AsString := Copy(Esito, 1, 500);
    FQuery.ParamByName('USER_ID').AsLargeInt := FUserId;
    FQuery.ExecSQL;

    // il refresh token cambia a ogni rinnovo: si salva l'ultimo
    if FAutorizzazione.RefreshToken <> '' then
    begin
      FQuery.SQL.Text :=
        'UPDATE USR_UTENTI_OUTLOOK SET ' +
        '  USR_UTENTI_OUTLOOK.REFRESH_TOKEN_CIFRATO = :REFRESH_TOKEN_CIFRATO ' +
        'WHERE USR_UTENTI_OUTLOOK.USER_ID = :USER_ID';
      FQuery.ParamByName('REFRESH_TOKEN_CIFRATO').AsWideMemo := Proteggi(FAutorizzazione.RefreshToken);
      FQuery.ParamByName('USER_ID').AsLargeInt := FUserId;
      FQuery.ExecSQL;
    end;

    Conferma;
  except
    Annulla;
    raise;
  end;
end;

procedure TSessioneOutlook.ApplicaEvento(const Evento: TMicrosoftGraphEvento);
var
  IdAgenda: Int64;
  ChangeKey: string;
  DaInviare: Boolean;
  ModificaGesty: TDateTime;
  Giorno: TDate;
  OraInizio: TTime;
  OraFine: TTime;
  Fine: TDateTime;
begin
  FQuery.SQL.Text :=
    'SELECT AGENDA.ID_AGENDA, AGENDA.OUTLOOK_CHANGE_KEY, AGENDA.OUTLOOK_DA_INVIARE, AGENDA.USR_DATA_MDF ' +
    'FROM AGENDA ' +
    'WHERE AGENDA.OUTLOOK_ID_EVENTO = :OUTLOOK_ID_EVENTO AND AGENDA.ID_RISORSA = :ID_RISORSA';
  FQuery.ParamByName('OUTLOOK_ID_EVENTO').AsString := Evento.Id;
  FQuery.ParamByName('ID_RISORSA').AsLargeInt := FIdRisorsa;
  FQuery.Open;
  try
    IdAgenda := 0;
    ChangeKey := '';
    DaInviare := False;
    ModificaGesty := 0;
    if not FQuery.IsEmpty then
    begin
      IdAgenda := FQuery.FieldByName('ID_AGENDA').AsLargeInt;
      ChangeKey := FQuery.FieldByName('OUTLOOK_CHANGE_KEY').AsString;
      DaInviare := FQuery.FieldByName('OUTLOOK_DA_INVIARE').AsBoolean;
      ModificaGesty := FQuery.FieldByName('USR_DATA_MDF').AsDateTime;
    end;
  finally
    FQuery.Close;
  end;

  // cancellato o annullato in Outlook: si toglie anche da Gesty
  if Evento.Rimosso or Evento.Annullato then
  begin
    if IdAgenda <> 0 then
    begin
      FQuery.SQL.Text := 'DELETE FROM AGENDA WHERE AGENDA.ID_AGENDA = :ID_AGENDA';
      FQuery.ParamByName('ID_AGENDA').AsLargeInt := IdAgenda;
      FQuery.ExecSQL;
      Inc(FRicevuti);
    end;
    Exit;
  end;

  // e' la versione che Gesty ha gia' (di solito l'eco di un invio di Gesty)
  if (IdAgenda <> 0) and (ChangeKey = Evento.ChangeKey) then
    Exit;

  // cambiato da tutte e due le parti: vince la modifica piu' recente
  if (IdAgenda <> 0) and DaInviare and (ModificaGesty > Evento.UltimaModifica) then
    Exit;

  // AGENDA ha un giorno solo: giornata intera = 00:00-23:59, un evento che
  // finisce a mezzanotte finisce alle 23:59, piu' giorni non si importano
  Fine := Evento.Fine;
  if (TimeOf(Fine) = 0) and (DateOf(Fine) = IncDay(DateOf(Evento.Inizio))) then
    Fine := DateOf(Evento.Inizio) + EncodeTime(23, 59, 0, 0);

  if DateOf(Fine) <> DateOf(Evento.Inizio) then
  begin
    Inc(FIgnorati);
    Exit;
  end;

  Giorno := DateOf(Evento.Inizio);
  if Evento.GiornataIntera then
  begin
    OraInizio := 0;
    OraFine := EncodeTime(23, 59, 0, 0);
  end
  else
  begin
    OraInizio := TimeOf(Evento.Inizio);
    OraFine := TimeOf(Fine);
  end;

  if IdAgenda <> 0 then
  begin
    FQuery.SQL.Text :=
      'UPDATE AGENDA SET ' +
      '  AGENDA.DATA_EVENTO = :DATA_EVENTO, ' +
      '  AGENDA.ORA_INIZIO = :ORA_INIZIO, ' +
      '  AGENDA.ORA_FINE = :ORA_FINE, ' +
      '  AGENDA.OGGETTO = :OGGETTO, ' +
      '  AGENDA.NOTE_EVENTO = :NOTE_EVENTO, ' +
      '  AGENDA.OUTLOOK_CHANGE_KEY = :OUTLOOK_CHANGE_KEY, ' +
      '  AGENDA.OUTLOOK_DATA_MODIFICA = :OUTLOOK_DATA_MODIFICA, ' +
      '  AGENDA.OUTLOOK_DA_INVIARE = FALSE ' +
      'WHERE AGENDA.ID_AGENDA = :ID_AGENDA';
    FQuery.ParamByName('ID_AGENDA').AsLargeInt := IdAgenda;
  end
  else
  begin
    FQuery.SQL.Text :=
      'INSERT INTO AGENDA ' +
      '  (ID_RISORSA, DATA_EVENTO, ORA_INIZIO, ORA_FINE, OGGETTO, NOTE_EVENTO, ' +
      '   OUTLOOK_ID_EVENTO, OUTLOOK_CHANGE_KEY, OUTLOOK_DATA_MODIFICA, OUTLOOK_DA_INVIARE) ' +
      'VALUES ' +
      '  (:ID_RISORSA, :DATA_EVENTO, :ORA_INIZIO, :ORA_FINE, :OGGETTO, :NOTE_EVENTO, ' +
      '   :OUTLOOK_ID_EVENTO, :OUTLOOK_CHANGE_KEY, :OUTLOOK_DATA_MODIFICA, FALSE)';
    FQuery.ParamByName('ID_RISORSA').AsLargeInt := FIdRisorsa;
    FQuery.ParamByName('OUTLOOK_ID_EVENTO').AsString := Evento.Id;
  end;

  FQuery.ParamByName('DATA_EVENTO').AsDate := Giorno;
  FQuery.ParamByName('ORA_INIZIO').AsTime := OraInizio;
  FQuery.ParamByName('ORA_FINE').AsTime := OraFine;
  FQuery.ParamByName('OGGETTO').AsString := Copy(Evento.Oggetto, 1, 255);
  FQuery.ParamByName('NOTE_EVENTO').AsString := Copy(Evento.Note, 1, 255);
  FQuery.ParamByName('OUTLOOK_CHANGE_KEY').AsString := Evento.ChangeKey;
  FQuery.ParamByName('OUTLOOK_DATA_MODIFICA').AsDateTime := Evento.UltimaModifica;
  FQuery.ExecSQL;

  Inc(FRicevuti);
end;

procedure TSessioneOutlook.RiceviDaOutlook;
var
  Eventi: TList<TMicrosoftGraphEvento>;
  Evento: TMicrosoftGraphEvento;
  Dal: TDate;
  Al: TDate;
begin
  Dal := IncDay(Date, -GIORNI_INDIETRO);
  Al := IncDay(Date, GIORNI_AVANTI);

  // finestra troppo vecchia o prima volta: lettura completa della finestra attuale
  if (FDeltaLink = '') or (FDeltaDal < IncDay(Date, -GIORNI_VALIDITA_DELTA)) then
  begin
    FDeltaLink := '';
    FDeltaDal := Dal;
  end;

  Eventi := TList<TMicrosoftGraphEvento>.Create;
  try
    try
      FCalendario.LeggiModifiche(FIdCalendario, FDeltaLink, FDeltaDal, Al, Eventi);
    except
      on EMicrosoftGraphDeltaScaduto do
      begin
        // Graph ha perso lo stato della lettura: si riparte da capo una volta
        Eventi.Clear;
        FDeltaLink := '';
        FDeltaDal := Dal;
        FCalendario.LeggiModifiche(FIdCalendario, FDeltaLink, FDeltaDal, Al, Eventi);
      end;
    end;

    Inizia;
    try
      ImpostaContesto;
      for Evento in Eventi do
        ApplicaEvento(Evento);

      // lo stato della lettura si salva con gli eventi: o tutto o niente
      FQuery.SQL.Text :=
        'UPDATE USR_UTENTI_OUTLOOK SET ' +
        '  USR_UTENTI_OUTLOOK.DELTA_LINK = :DELTA_LINK, ' +
        '  USR_UTENTI_OUTLOOK.DELTA_DAL_GIORNO = :DELTA_DAL_GIORNO ' +
        'WHERE USR_UTENTI_OUTLOOK.USER_ID = :USER_ID';
      FQuery.ParamByName('DELTA_LINK').AsWideMemo := FDeltaLink;
      FQuery.ParamByName('DELTA_DAL_GIORNO').AsDate := FDeltaDal;
      FQuery.ParamByName('USER_ID').AsLargeInt := FUserId;
      FQuery.ExecSQL;

      Conferma;
    except
      Annulla;
      raise;
    end;
  finally
    Eventi.Free;
  end;
end;

procedure TSessioneOutlook.InviaEliminazioni;
var
  Eliminazioni: TList<TPair<Int64, string>>;
  Eliminazione: TPair<Int64, string>;
begin
  Eliminazioni := TList<TPair<Int64, string>>.Create;
  try
    Inizia;
    try
      FQuery.SQL.Text :=
        'SELECT AGENDA_OUTLOOK_ELIMINAZIONI.ID_ELIMINAZIONE, AGENDA_OUTLOOK_ELIMINAZIONI.OUTLOOK_ID_EVENTO ' +
        'FROM AGENDA_OUTLOOK_ELIMINAZIONI ' +
        'WHERE AGENDA_OUTLOOK_ELIMINAZIONI.ID_RISORSA = :ID_RISORSA';
      FQuery.ParamByName('ID_RISORSA').AsLargeInt := FIdRisorsa;
      FQuery.Open;
      while not FQuery.Eof do
      begin
        Eliminazioni.Add(TPair<Int64, string>.Create(FQuery.FieldByName('ID_ELIMINAZIONE').AsLargeInt, FQuery.FieldByName('OUTLOOK_ID_EVENTO').AsString));
        FQuery.Next;
      end;
      FQuery.Close;
      Conferma;
    except
      Annulla;
      raise;
    end;

    for Eliminazione in Eliminazioni do
    begin
      // gia' sparito da Outlook: va bene lo stesso
      FCalendario.EliminaEvento(Eliminazione.Value);

      Inizia;
      try
        FQuery.SQL.Text := 'DELETE FROM AGENDA_OUTLOOK_ELIMINAZIONI WHERE AGENDA_OUTLOOK_ELIMINAZIONI.ID_ELIMINAZIONE = :ID_ELIMINAZIONE';
        FQuery.ParamByName('ID_ELIMINAZIONE').AsLargeInt := Eliminazione.Key;
        FQuery.ExecSQL;
        Conferma;
      except
        Annulla;
        raise;
      end;

      Inc(FEliminati);
    end;
  finally
    Eliminazioni.Free;
  end;
end;

procedure TSessioneOutlook.InviaAOutlook;
var
  Eventi: TList<TEventoAgenda>;
  EventoAgenda: TEventoAgenda;
  Evento: TMicrosoftGraphEvento;
  Risposta: TMicrosoftGraphEvento;
  Creato: Boolean;
begin
  Eventi := TList<TEventoAgenda>.Create;
  try
    Inizia;
    try
      // mai inviati, oppure modificati in Gesty dopo l'ultima sincronizzazione
      FQuery.SQL.Text :=
        'SELECT AGENDA.ID_AGENDA, AGENDA.DATA_EVENTO, AGENDA.ORA_INIZIO, AGENDA.ORA_FINE, ' +
        '       AGENDA.OGGETTO, AGENDA.NOTE_EVENTO, AGENDA.OUTLOOK_ID_EVENTO ' +
        'FROM AGENDA ' +
        'WHERE AGENDA.ID_RISORSA = :ID_RISORSA AND ' +
        '      AGENDA.DATA_EVENTO BETWEEN :DAL AND :AL AND ' +
        '      (AGENDA.OUTLOOK_ID_EVENTO IS NULL OR AGENDA.OUTLOOK_DA_INVIARE = TRUE)';
      FQuery.ParamByName('ID_RISORSA').AsLargeInt := FIdRisorsa;
      FQuery.ParamByName('DAL').AsDate := IncDay(Date, -GIORNI_INDIETRO);
      FQuery.ParamByName('AL').AsDate := IncDay(Date, GIORNI_AVANTI);
      FQuery.Open;
      while not FQuery.Eof do
      begin
        EventoAgenda.IdAgenda := FQuery.FieldByName('ID_AGENDA').AsLargeInt;
        EventoAgenda.DataEvento := FQuery.FieldByName('DATA_EVENTO').AsDateTime;
        EventoAgenda.OraInizio := TimeOf(FQuery.FieldByName('ORA_INIZIO').AsDateTime);
        EventoAgenda.OraFine := TimeOf(FQuery.FieldByName('ORA_FINE').AsDateTime);
        EventoAgenda.Oggetto := FQuery.FieldByName('OGGETTO').AsString;
        EventoAgenda.Note := FQuery.FieldByName('NOTE_EVENTO').AsString;
        EventoAgenda.OutlookIdEvento := FQuery.FieldByName('OUTLOOK_ID_EVENTO').AsString;
        Eventi.Add(EventoAgenda);
        FQuery.Next;
      end;
      FQuery.Close;
      Conferma;
    except
      Annulla;
      raise;
    end;

    for EventoAgenda in Eventi do
    begin
      Evento := Default(TMicrosoftGraphEvento);
      Evento.Id := EventoAgenda.OutlookIdEvento;
      Evento.Oggetto := EventoAgenda.Oggetto;
      Evento.Note := EventoAgenda.Note;
      Evento.Inizio := DateOf(EventoAgenda.DataEvento) + EventoAgenda.OraInizio;
      Evento.Fine := DateOf(EventoAgenda.DataEvento) + EventoAgenda.OraFine;

      Creato := Evento.Id = '';
      if Creato then
        Risposta := FCalendario.CreaEvento(FIdCalendario, Evento)
      else
        try
          Risposta := FCalendario.AggiornaEvento(Evento, False);
        except
          on E: EMicrosoftGraph do
            // cancellato in Outlook dopo l'ultima lettura: si ricrea
            if E.StatoHttp = 404 then
              Risposta := FCalendario.CreaEvento(FIdCalendario, Evento)
            else
              raise;
        end;

      Inizia;
      try
        ImpostaContesto;
        FQuery.SQL.Text :=
          'UPDATE AGENDA SET ' +
          '  AGENDA.OUTLOOK_ID_EVENTO = :OUTLOOK_ID_EVENTO, ' +
          '  AGENDA.OUTLOOK_CHANGE_KEY = :OUTLOOK_CHANGE_KEY, ' +
          '  AGENDA.OUTLOOK_DATA_MODIFICA = :OUTLOOK_DATA_MODIFICA, ' +
          '  AGENDA.OUTLOOK_DA_INVIARE = FALSE ' +
          'WHERE AGENDA.ID_AGENDA = :ID_AGENDA';
        FQuery.ParamByName('OUTLOOK_ID_EVENTO').AsString := Risposta.Id;
        FQuery.ParamByName('OUTLOOK_CHANGE_KEY').AsString := Risposta.ChangeKey;
        FQuery.ParamByName('OUTLOOK_DATA_MODIFICA').AsDateTime := Risposta.UltimaModifica;
        FQuery.ParamByName('ID_AGENDA').AsLargeInt := EventoAgenda.IdAgenda;
        FQuery.ExecSQL;
        Conferma;
      except
        Annulla;
        raise;
      end;

      Inc(FInviati);
    end;
  finally
    Eventi.Free;
  end;
end;

function TSessioneOutlook.Esegui(const Interattiva: Boolean; out Esito: string): Boolean;
var
  TenantId: string;
  ClientId: string;
  RefreshTokenCifrato: string;
  Account: string;
  Valore: Variant;
  Collegamento: Boolean;
begin
  Result := False;
  Esito := '';
  Collegamento := False;

  try
    TenantId := ValoreTesto(Config.Database.ExecSQLScalar('SELECT CONFIG.OUTLOOK_TENANT_ID FROM CONFIG')).Trim;
    ClientId := ValoreTesto(Config.Database.ExecSQLScalar('SELECT CONFIG.OUTLOOK_CLIENT_ID FROM CONFIG')).Trim;
    if (TenantId = '') or (ClientId = '') then
    begin
      Esito := 'Sincronizzazione con Outlook non configurata: mancano ID tenant e ID applicazione nei parametri di Gesty.';
      Exit;
    end;

    FUserId := Config.Database.ExecSQLScalar('SELECT CURRENT_USER_ID() FROM RDB$DATABASE');
    Valore := Config.Database.ExecSQLScalar('SELECT CURRENT_ID_RISORSA() FROM RDB$DATABASE');
    if VarIsNull(Valore) then
    begin
      Esito := 'Il tuo utente non ' + #232 + ' collegato a una scheda del personale: non ha un''agenda da sincronizzare.';
      Exit;
    end;
    FIdRisorsa := Valore;

    FAutorizzazione.TenantId := TenantId;
    FAutorizzazione.ClientID := ClientId;
    FAutorizzazione.AdditionalScopes.Text := 'User.Read' + sLineBreak + 'Calendars.ReadWrite';

    Inizia;
    try
      FQuery.SQL.Text :=
        'SELECT USR_UTENTI_OUTLOOK.ID_CALENDARIO, USR_UTENTI_OUTLOOK.REFRESH_TOKEN_CIFRATO, ' +
        '       USR_UTENTI_OUTLOOK.DELTA_LINK, USR_UTENTI_OUTLOOK.DELTA_DAL_GIORNO ' +
        'FROM USR_UTENTI_OUTLOOK ' +
        'WHERE USR_UTENTI_OUTLOOK.USER_ID = :USER_ID AND USR_UTENTI_OUTLOOK.ATTIVO = TRUE';
      FQuery.ParamByName('USER_ID').AsLargeInt := FUserId;
      FQuery.Open;
      Collegamento := not FQuery.IsEmpty;
      if Collegamento then
      begin
        FIdCalendario := FQuery.FieldByName('ID_CALENDARIO').AsString;
        RefreshTokenCifrato := FQuery.FieldByName('REFRESH_TOKEN_CIFRATO').AsString;
        FDeltaLink := FQuery.FieldByName('DELTA_LINK').AsString;
        if not FQuery.FieldByName('DELTA_DAL_GIORNO').IsNull then
          FDeltaDal := FQuery.FieldByName('DELTA_DAL_GIORNO').AsDateTime;
      end;
      FQuery.Close;
      Conferma;
    except
      Annulla;
      raise;
    end;

    if not Accedi(Interattiva, RefreshTokenCifrato, Esito) then
    begin
      if Collegamento then
        SalvaEsito(Esito);
      Exit;
    end;

    if not ControllaAccount(Account, Esito) then
      Exit;

    SalvaCollegamento(Account);
    Collegamento := True;

    RiceviDaOutlook;
    InviaEliminazioni;
    InviaAOutlook;

    Esito := Format('Sincronizzazione con Outlook completata: %d eventi ricevuti, %d inviati, %d cancellati in Outlook.',
      [FRicevuti, FInviati, FEliminati]);
    if FIgnorati > 0 then
      Esito := Esito + Format(' %d eventi di Outlook su pi' + #249 + ' giorni non sono stati importati.', [FIgnorati]);

    SalvaEsito(Esito);
    Result := True;
  except
    on E: Exception do
    begin
      SiMain.LogError('Sincronizzazione con Outlook: ' + E.Message);
      Esito := 'Sincronizzazione con Outlook non riuscita: ' + E.Message;
      if Collegamento then
        try
          SalvaEsito(Esito);
        except
          // l'errore originale conta di piu'
        end;
    end;
  end;
end;

end.
