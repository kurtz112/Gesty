// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-22
// ---------------------------------------------------------------------------
unit Gesty.CalendarioEsterno;

// Sincronizzazione dell'agenda personale (tabella AGENDA) dell'utente collegato
// con il suo calendario esterno: Outlook (Microsoft 365) oppure Google Calendar.
// Ha preso il posto di Gesty.Outlook: le regole sono le stesse, il fornitore
// si raggiunge solo attraverso ICalendarioEsterno.
//
// - Configurazione in CONFIG, dalla registrazione fatta dal CED del cliente:
//   Microsoft = OUTLOOK_TENANT_ID e OUTLOOK_CLIENT_ID; Google = GOOGLE_CLIENT_ID e
//   GOOGLE_CLIENT_SECRET. Un fornitore con i campi vuoti e' spento.
// - Collegamento: USR_UTENTI_CALENDARI_ESTERNI, una riga per utente, un solo
//   calendario esterno per utente (FORNITORE). Il refresh token e' protetto con la
//   protezione dati di Windows (DPAPI) dell'utente: su un altro PC o profilo non
//   si decifra e si rifa' l'accesso.
// - Ognuno sincronizza solo la propria agenda: la persona e' CURRENT_ID_RISORSA(),
//   come nell'agenda (SCHEDA_PERSONALE).
//
// Ordine di una sincronizzazione:
// 1. calendario esterno -> Gesty: eventi cambiati dall'ultima volta;
// 2. eventi cancellati in Gesty (AGENDA_CALENDARI_ESTERNI_ELIMINAZIONI) -> cancellati fuori;
// 3. Gesty -> calendario esterno: eventi nuovi o modificati (CALENDARIO_ESTERNO_DA_INVIARE).
// Le scritture su AGENDA impostano SINCRONIZZAZIONE_CALENDARIO_ESTERNO nel contesto
// della transazione, cosi' i trigger non le scambiano per modifiche dell'utente.
//
// Limiti voluti:
// - AGENDA ha un giorno solo: gli eventi esterni su piu' giorni non si importano;
//   quelli di giornata intera diventano 00:00-23:59;
// - il testo dell'evento va fuori solo alla creazione: Gesty conserva solo
//   l'anteprima (255 caratteri) e aggiornarlo cancellerebbe il testo completo.

interface

uses
  System.SysUtils;

type
  TFornitoreCalendario = (FornitoreNessuno, FornitoreMicrosoft, FornitoreGoogle);
  TFornitoriCalendario = set of TFornitoreCalendario;

  TSincronizzazioneCalendario = class
  public
    // fornitori con la configurazione completa in CONFIG
    class function FornitoriDisponibili: TFornitoriCalendario;
    // almeno un fornitore configurato: la funzione e' accesa
    class function Disponibile: Boolean;
    // fornitore che l'utente collegato ha gia' collegato (FornitoreNessuno se nessuno)
    class function FornitoreCollegato: TFornitoreCalendario;
    // nome per l'utente: "Outlook", "Google Calendar"
    class function NomeServizio(const Fornitore: TFornitoreCalendario): string;
    // Interattiva = False non apre mai il browser: se l'accesso va rifatto si ferma.
    // Esito: testo per l'utente, anche in caso di errore
    class function Sincronizza(const Fornitore: TFornitoreCalendario; const Interattiva: Boolean; out Esito: string): Boolean;
    // toglie il collegamento e l'aggancio degli eventi agli eventi esterni
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
  CalendarioEsterno.Types,
  CalendarioEsterno.Microsoft,
  CalendarioEsterno.Google,
  SmartInspect.Vcl.SiAuto;

const
  GIORNI_INDIETRO = 30;
  GIORNI_AVANTI = 365;
  // oltre questa eta' la finestra della lettura delle modifiche e' troppo vecchia: si riparte
  GIORNI_VALIDITA_LETTURA = 60;

  CODICI_FORNITORE: array[TFornitoreCalendario] of string = ('', 'MICROSOFT', 'GOOGLE');

  IMPOSTA_CONTESTO = 'SELECT RDB$SET_CONTEXT(''USER_TRANSACTION'', ''SINCRONIZZAZIONE_CALENDARIO_ESTERNO'', ''1'') FROM RDB$DATABASE';

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
    IdEventoEsterno: string;
  end;

  // Una sincronizzazione: vive il tempo di Sincronizza
  TSessioneCalendario = class
  strict private
    FTransazione: TFDTransaction;
    FQuery: TFDQuery;
    FFornitore: TFornitoreCalendario;
    FCalendario: ICalendarioEsterno;
    FUserId: Int64;
    FIdRisorsa: Int64;
    FStatoLettura: string;
    FStatoLetturaDal: TDate;
    FRicevuti: Integer;
    FInviati: Integer;
    FEliminati: Integer;
    FIgnorati: Integer;
    procedure Inizia;
    procedure Conferma;
    procedure Annulla;
    procedure ImpostaContesto;
    function CreaCalendario(const IdCalendario: string; out Esito: string): Boolean;
    function ControllaAccount(out Account: string; out Esito: string): Boolean;
    procedure SalvaCollegamento(const Account: string);
    procedure SalvaEsito(const Esito: string);
    procedure RiceviDalCalendario;
    procedure ApplicaEvento(const Evento: TEventoEsterno);
    procedure InviaEliminazioni;
    procedure InviaAlCalendario;
  public
    constructor Create(const Fornitore: TFornitoreCalendario);
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
  if not CryptProtectData(@Ingresso, 'Gesty calendario esterno', nil, nil, nil, CRYPTPROTECT_UI_FORBIDDEN, @Uscita) then
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

function LeggiConfig(const Campo: string): string;
begin
  Result := ValoreTesto(Config.Database.ExecSQLScalar('SELECT CONFIG.' + Campo + ' FROM CONFIG')).Trim;
end;

function FornitoreDaCodice(const Codice: string): TFornitoreCalendario;
var
  Fornitore: TFornitoreCalendario;
begin
  Result := FornitoreNessuno;
  for Fornitore := Succ(FornitoreNessuno) to High(TFornitoreCalendario) do
    if SameText(CODICI_FORNITORE[Fornitore], Codice) then
      Exit(Fornitore);
end;

{ TSincronizzazioneCalendario }

class function TSincronizzazioneCalendario.FornitoriDisponibili: TFornitoriCalendario;
begin
  Result := [];
  try
    if (LeggiConfig('OUTLOOK_TENANT_ID') <> '') and (LeggiConfig('OUTLOOK_CLIENT_ID') <> '') then
      Include(Result, FornitoreMicrosoft);
    if (LeggiConfig('GOOGLE_CLIENT_ID') <> '') and (LeggiConfig('GOOGLE_CLIENT_SECRET') <> '') then
      Include(Result, FornitoreGoogle);
  except
    on E: Exception do
    begin
      // database senza lo script della sincronizzazione: la funzione resta spenta
      SiMain.LogError('Sincronizzazione del calendario non disponibile: ' + E.Message);
      Result := [];
    end;
  end;
end;

class function TSincronizzazioneCalendario.Disponibile: Boolean;
begin
  Result := FornitoriDisponibili <> [];
end;

class function TSincronizzazioneCalendario.FornitoreCollegato: TFornitoreCalendario;
begin
  Result := FornitoreDaCodice(ValoreTesto(Config.Database.ExecSQLScalar(
    'SELECT USR_UTENTI_CALENDARI_ESTERNI.FORNITORE FROM USR_UTENTI_CALENDARI_ESTERNI ' +
    'WHERE USR_UTENTI_CALENDARI_ESTERNI.USER_ID = CURRENT_USER_ID() AND USR_UTENTI_CALENDARI_ESTERNI.ATTIVO = TRUE')));
end;

class function TSincronizzazioneCalendario.NomeServizio(const Fornitore: TFornitoreCalendario): string;
begin
  case Fornitore of
    FornitoreMicrosoft:
      Result := 'Outlook';
    FornitoreGoogle:
      Result := 'Google Calendar';
  else
    Result := 'calendario esterno';
  end;
end;

class function TSincronizzazioneCalendario.Sincronizza(const Fornitore: TFornitoreCalendario; const Interattiva: Boolean; out Esito: string): Boolean;
var
  Sessione: TSessioneCalendario;
begin
  Sessione := TSessioneCalendario.Create(Fornitore);
  try
    Result := Sessione.Esegui(Interattiva, Esito);
  finally
    Sessione.Free;
  end;
end;

class procedure TSincronizzazioneCalendario.Scollega;
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
      Query.Open(IMPOSTA_CONTESTO);
      Query.Close;

      // un collegamento successivo, anche con un altro account o servizio, ricrea gli eventi fuori
      Query.ExecSQL(
        'UPDATE AGENDA SET ' +
        '  AGENDA.CALENDARIO_ESTERNO_ID_EVENTO = NULL, ' +
        '  AGENDA.CALENDARIO_ESTERNO_VERSIONE = NULL, ' +
        '  AGENDA.CALENDARIO_ESTERNO_DATA_MODIFICA = NULL, ' +
        '  AGENDA.CALENDARIO_ESTERNO_DA_INVIARE = FALSE ' +
        'WHERE AGENDA.ID_RISORSA = CURRENT_ID_RISORSA() AND AGENDA.CALENDARIO_ESTERNO_ID_EVENTO IS NOT NULL');
      Query.ExecSQL(
        'DELETE FROM AGENDA_CALENDARI_ESTERNI_ELIMINAZIONI ' +
        'WHERE AGENDA_CALENDARI_ESTERNI_ELIMINAZIONI.ID_RISORSA = CURRENT_ID_RISORSA()');
      Query.ExecSQL(
        'DELETE FROM USR_UTENTI_CALENDARI_ESTERNI ' +
        'WHERE USR_UTENTI_CALENDARI_ESTERNI.USER_ID = CURRENT_USER_ID()');

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

{ TSessioneCalendario }

constructor TSessioneCalendario.Create(const Fornitore: TFornitoreCalendario);
begin
  inherited Create;
  FFornitore := Fornitore;

  FTransazione := TFDTransaction.Create(nil);
  FTransazione.Connection := Config.Database;

  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := Config.Database;
  FQuery.Transaction := FTransazione;
  FQuery.UpdateTransaction := FTransazione;
end;

destructor TSessioneCalendario.Destroy;
begin
  if FTransazione.Active then
    FTransazione.Rollback;
  FCalendario := nil;
  FreeAndNil(FQuery);
  FreeAndNil(FTransazione);
  inherited Destroy;
end;

procedure TSessioneCalendario.Inizia;
begin
  FTransazione.StartTransaction;
end;

procedure TSessioneCalendario.Conferma;
begin
  FTransazione.Commit;
end;

procedure TSessioneCalendario.Annulla;
begin
  if FTransazione.Active then
    FTransazione.Rollback;
end;

procedure TSessioneCalendario.ImpostaContesto;
begin
  FQuery.Open(IMPOSTA_CONTESTO);
  FQuery.Close;
end;

function TSessioneCalendario.CreaCalendario(const IdCalendario: string; out Esito: string): Boolean;
var
  Primo: string;
  Secondo: string;
begin
  Result := False;
  Esito := '';

  case FFornitore of
    FornitoreMicrosoft:
      begin
        Primo := LeggiConfig('OUTLOOK_TENANT_ID');
        Secondo := LeggiConfig('OUTLOOK_CLIENT_ID');
        if (Primo = '') or (Secondo = '') then
          Esito := 'Sincronizzazione con Outlook non configurata: mancano ID tenant e ID applicazione nei parametri di Gesty.'
        else
          FCalendario := TCalendarioEsternoMicrosoft.Create(Primo, Secondo, IdCalendario);
      end;
    FornitoreGoogle:
      begin
        Primo := LeggiConfig('GOOGLE_CLIENT_ID');
        Secondo := LeggiConfig('GOOGLE_CLIENT_SECRET');
        if (Primo = '') or (Secondo = '') then
          Esito := 'Sincronizzazione con Google Calendar non configurata: mancano ID client e client secret nei parametri di Gesty.'
        else
          FCalendario := TCalendarioEsternoGoogle.Create(Primo, Secondo, IdCalendario);
      end;
  else
    Esito := 'Nessun calendario esterno scelto.';
  end;

  Result := Assigned(FCalendario);
end;

function TSessioneCalendario.ControllaAccount(out Account: string; out Esito: string): Boolean;
var
  Profilo: TProfiloEsterno;
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
    Esito := Format('L''account usato per %s (%s) non corrisponde alla mail del tuo utente di Gesty (%s): ' +
      'rifai l''accesso con il tuo account.', [FCalendario.NomeServizio, Account, MailUtente]);
end;

procedure TSessioneCalendario.SalvaCollegamento(const Account: string);
begin
  Inizia;
  try
    FQuery.SQL.Text :=
      'UPDATE OR INSERT INTO USR_UTENTI_CALENDARI_ESTERNI ' +
      '  (USER_ID, FORNITORE, ACCOUNT, REFRESH_TOKEN_CIFRATO, ATTIVO) ' +
      'VALUES ' +
      '  (:USER_ID, :FORNITORE, :ACCOUNT, :REFRESH_TOKEN_CIFRATO, TRUE) ' +
      'MATCHING (USER_ID)';
    FQuery.ParamByName('USER_ID').AsLargeInt := FUserId;
    FQuery.ParamByName('FORNITORE').AsString := CODICI_FORNITORE[FFornitore];
    FQuery.ParamByName('ACCOUNT').AsString := Account;
    FQuery.ParamByName('REFRESH_TOKEN_CIFRATO').AsWideMemo := Proteggi(FCalendario.RefreshToken);
    FQuery.ExecSQL;
    Conferma;
  except
    Annulla;
    raise;
  end;
end;

procedure TSessioneCalendario.SalvaEsito(const Esito: string);
begin
  Inizia;
  try
    FQuery.SQL.Text :=
      'UPDATE USR_UTENTI_CALENDARI_ESTERNI SET ' +
      '  USR_UTENTI_CALENDARI_ESTERNI.DATA_ULTIMA_SINCRONIZZAZIONE = CURRENT_TIMESTAMP, ' +
      '  USR_UTENTI_CALENDARI_ESTERNI.ESITO_ULTIMA_SINCRONIZZAZIONE = :ESITO ' +
      'WHERE USR_UTENTI_CALENDARI_ESTERNI.USER_ID = :USER_ID';
    FQuery.ParamByName('ESITO').AsString := Copy(Esito, 1, 500);
    FQuery.ParamByName('USER_ID').AsLargeInt := FUserId;
    FQuery.ExecSQL;

    // il refresh token puo' cambiare a ogni rinnovo: si salva l'ultimo
    if Assigned(FCalendario) and (FCalendario.RefreshToken <> '') then
    begin
      FQuery.SQL.Text :=
        'UPDATE USR_UTENTI_CALENDARI_ESTERNI SET ' +
        '  USR_UTENTI_CALENDARI_ESTERNI.REFRESH_TOKEN_CIFRATO = :REFRESH_TOKEN_CIFRATO ' +
        'WHERE USR_UTENTI_CALENDARI_ESTERNI.USER_ID = :USER_ID';
      FQuery.ParamByName('REFRESH_TOKEN_CIFRATO').AsWideMemo := Proteggi(FCalendario.RefreshToken);
      FQuery.ParamByName('USER_ID').AsLargeInt := FUserId;
      FQuery.ExecSQL;
    end;

    Conferma;
  except
    Annulla;
    raise;
  end;
end;

procedure TSessioneCalendario.ApplicaEvento(const Evento: TEventoEsterno);
var
  IdAgenda: Int64;
  Versione: string;
  DaInviare: Boolean;
  ModificaGesty: TDateTime;
  Giorno: TDate;
  OraInizio: TTime;
  OraFine: TTime;
  Fine: TDateTime;
begin
  FQuery.SQL.Text :=
    'SELECT AGENDA.ID_AGENDA, AGENDA.CALENDARIO_ESTERNO_VERSIONE, AGENDA.CALENDARIO_ESTERNO_DA_INVIARE, AGENDA.USR_DATA_MDF ' +
    'FROM AGENDA ' +
    'WHERE AGENDA.CALENDARIO_ESTERNO_ID_EVENTO = :CALENDARIO_ESTERNO_ID_EVENTO AND AGENDA.ID_RISORSA = :ID_RISORSA';
  FQuery.ParamByName('CALENDARIO_ESTERNO_ID_EVENTO').AsString := Evento.Id;
  FQuery.ParamByName('ID_RISORSA').AsLargeInt := FIdRisorsa;
  FQuery.Open;
  try
    IdAgenda := 0;
    Versione := '';
    DaInviare := False;
    ModificaGesty := 0;
    if not FQuery.IsEmpty then
    begin
      IdAgenda := FQuery.FieldByName('ID_AGENDA').AsLargeInt;
      Versione := FQuery.FieldByName('CALENDARIO_ESTERNO_VERSIONE').AsString;
      DaInviare := FQuery.FieldByName('CALENDARIO_ESTERNO_DA_INVIARE').AsBoolean;
      ModificaGesty := FQuery.FieldByName('USR_DATA_MDF').AsDateTime;
    end;
  finally
    FQuery.Close;
  end;

  // cancellato o annullato fuori: si toglie anche da Gesty
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
  if (IdAgenda <> 0) and (Versione = Evento.Versione) then
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
      '  AGENDA.CALENDARIO_ESTERNO_VERSIONE = :CALENDARIO_ESTERNO_VERSIONE, ' +
      '  AGENDA.CALENDARIO_ESTERNO_DATA_MODIFICA = :CALENDARIO_ESTERNO_DATA_MODIFICA, ' +
      '  AGENDA.CALENDARIO_ESTERNO_DA_INVIARE = FALSE ' +
      'WHERE AGENDA.ID_AGENDA = :ID_AGENDA';
    FQuery.ParamByName('ID_AGENDA').AsLargeInt := IdAgenda;
  end
  else
  begin
    FQuery.SQL.Text :=
      'INSERT INTO AGENDA ' +
      '  (ID_RISORSA, DATA_EVENTO, ORA_INIZIO, ORA_FINE, OGGETTO, NOTE_EVENTO, ' +
      '   CALENDARIO_ESTERNO_ID_EVENTO, CALENDARIO_ESTERNO_VERSIONE, CALENDARIO_ESTERNO_DATA_MODIFICA, CALENDARIO_ESTERNO_DA_INVIARE) ' +
      'VALUES ' +
      '  (:ID_RISORSA, :DATA_EVENTO, :ORA_INIZIO, :ORA_FINE, :OGGETTO, :NOTE_EVENTO, ' +
      '   :CALENDARIO_ESTERNO_ID_EVENTO, :CALENDARIO_ESTERNO_VERSIONE, :CALENDARIO_ESTERNO_DATA_MODIFICA, FALSE)';
    FQuery.ParamByName('ID_RISORSA').AsLargeInt := FIdRisorsa;
    FQuery.ParamByName('CALENDARIO_ESTERNO_ID_EVENTO').AsString := Evento.Id;
  end;

  FQuery.ParamByName('DATA_EVENTO').AsDate := Giorno;
  FQuery.ParamByName('ORA_INIZIO').AsTime := OraInizio;
  FQuery.ParamByName('ORA_FINE').AsTime := OraFine;
  FQuery.ParamByName('OGGETTO').AsString := Copy(Evento.Oggetto, 1, 255);
  FQuery.ParamByName('NOTE_EVENTO').AsString := Copy(Evento.Note, 1, 255);
  FQuery.ParamByName('CALENDARIO_ESTERNO_VERSIONE').AsString := Evento.Versione;
  FQuery.ParamByName('CALENDARIO_ESTERNO_DATA_MODIFICA').AsDateTime := Evento.UltimaModifica;
  FQuery.ExecSQL;

  Inc(FRicevuti);
end;

procedure TSessioneCalendario.RiceviDalCalendario;
var
  Eventi: TList<TEventoEsterno>;
  Evento: TEventoEsterno;
  Dal: TDate;
  Al: TDate;
begin
  Dal := IncDay(Date, -GIORNI_INDIETRO);
  Al := IncDay(Date, GIORNI_AVANTI);

  // finestra troppo vecchia o prima volta: lettura completa della finestra attuale
  if (FStatoLettura = '') or (FStatoLetturaDal < IncDay(Date, -GIORNI_VALIDITA_LETTURA)) then
  begin
    FStatoLettura := '';
    FStatoLetturaDal := Dal;
  end;

  Eventi := TList<TEventoEsterno>.Create;
  try
    try
      FCalendario.LeggiModifiche(FStatoLettura, FStatoLetturaDal, Al, Eventi);
    except
      on ECalendarioEsternoLetturaScaduta do
      begin
        // il servizio ha perso lo stato della lettura: si riparte da capo una volta
        Eventi.Clear;
        FStatoLettura := '';
        FStatoLetturaDal := Dal;
        FCalendario.LeggiModifiche(FStatoLettura, FStatoLetturaDal, Al, Eventi);
      end;
    end;

    Inizia;
    try
      ImpostaContesto;
      for Evento in Eventi do
        ApplicaEvento(Evento);

      // lo stato della lettura si salva con gli eventi: o tutto o niente
      FQuery.SQL.Text :=
        'UPDATE USR_UTENTI_CALENDARI_ESTERNI SET ' +
        '  USR_UTENTI_CALENDARI_ESTERNI.STATO_LETTURA = :STATO_LETTURA, ' +
        '  USR_UTENTI_CALENDARI_ESTERNI.STATO_LETTURA_DAL_GIORNO = :STATO_LETTURA_DAL_GIORNO ' +
        'WHERE USR_UTENTI_CALENDARI_ESTERNI.USER_ID = :USER_ID';
      FQuery.ParamByName('STATO_LETTURA').AsWideMemo := FStatoLettura;
      FQuery.ParamByName('STATO_LETTURA_DAL_GIORNO').AsDate := FStatoLetturaDal;
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

procedure TSessioneCalendario.InviaEliminazioni;
var
  Eliminazioni: TList<TPair<Int64, string>>;
  Eliminazione: TPair<Int64, string>;
begin
  Eliminazioni := TList<TPair<Int64, string>>.Create;
  try
    Inizia;
    try
      FQuery.SQL.Text :=
        'SELECT AGENDA_CALENDARI_ESTERNI_ELIMINAZIONI.ID_ELIMINAZIONE, AGENDA_CALENDARI_ESTERNI_ELIMINAZIONI.CALENDARIO_ESTERNO_ID_EVENTO ' +
        'FROM AGENDA_CALENDARI_ESTERNI_ELIMINAZIONI ' +
        'WHERE AGENDA_CALENDARI_ESTERNI_ELIMINAZIONI.ID_RISORSA = :ID_RISORSA';
      FQuery.ParamByName('ID_RISORSA').AsLargeInt := FIdRisorsa;
      FQuery.Open;
      while not FQuery.Eof do
      begin
        Eliminazioni.Add(TPair<Int64, string>.Create(FQuery.FieldByName('ID_ELIMINAZIONE').AsLargeInt,
          FQuery.FieldByName('CALENDARIO_ESTERNO_ID_EVENTO').AsString));
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
      // gia' sparito fuori: va bene lo stesso
      FCalendario.EliminaEvento(Eliminazione.Value);

      Inizia;
      try
        FQuery.SQL.Text :=
          'DELETE FROM AGENDA_CALENDARI_ESTERNI_ELIMINAZIONI ' +
          'WHERE AGENDA_CALENDARI_ESTERNI_ELIMINAZIONI.ID_ELIMINAZIONE = :ID_ELIMINAZIONE';
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

procedure TSessioneCalendario.InviaAlCalendario;
var
  Eventi: TList<TEventoAgenda>;
  EventoAgenda: TEventoAgenda;
  Evento: TEventoEsterno;
  Risposta: TEventoEsterno;
begin
  Eventi := TList<TEventoAgenda>.Create;
  try
    Inizia;
    try
      // mai inviati, oppure modificati in Gesty dopo l'ultima sincronizzazione
      FQuery.SQL.Text :=
        'SELECT AGENDA.ID_AGENDA, AGENDA.DATA_EVENTO, AGENDA.ORA_INIZIO, AGENDA.ORA_FINE, ' +
        '       AGENDA.OGGETTO, AGENDA.NOTE_EVENTO, AGENDA.CALENDARIO_ESTERNO_ID_EVENTO ' +
        'FROM AGENDA ' +
        'WHERE AGENDA.ID_RISORSA = :ID_RISORSA AND ' +
        '      AGENDA.DATA_EVENTO BETWEEN :DAL AND :AL AND ' +
        '      (AGENDA.CALENDARIO_ESTERNO_ID_EVENTO IS NULL OR AGENDA.CALENDARIO_ESTERNO_DA_INVIARE = TRUE)';
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
        EventoAgenda.IdEventoEsterno := FQuery.FieldByName('CALENDARIO_ESTERNO_ID_EVENTO').AsString;
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
      Evento := Default(TEventoEsterno);
      Evento.Id := EventoAgenda.IdEventoEsterno;
      Evento.Oggetto := EventoAgenda.Oggetto;
      Evento.Note := EventoAgenda.Note;
      Evento.Inizio := DateOf(EventoAgenda.DataEvento) + EventoAgenda.OraInizio;
      Evento.Fine := DateOf(EventoAgenda.DataEvento) + EventoAgenda.OraFine;

      if Evento.Id = '' then
        Risposta := FCalendario.CreaEvento(Evento)
      else
      begin
        try
          Risposta := FCalendario.AggiornaEvento(Evento, False);
        except
          on E: ECalendarioEsterno do
            // cancellato fuori dopo l'ultima lettura: si ricrea
            if (E.StatoHttp = 404) or (E.StatoHttp = 410) then
              Risposta := FCalendario.CreaEvento(Evento)
            else
              raise;
        end;

        // Google aggiorna anche un evento gia' cancellato e lo restituisce come tale
        if Risposta.Rimosso then
          Risposta := FCalendario.CreaEvento(Evento);
      end;

      Inizia;
      try
        ImpostaContesto;
        FQuery.SQL.Text :=
          'UPDATE AGENDA SET ' +
          '  AGENDA.CALENDARIO_ESTERNO_ID_EVENTO = :CALENDARIO_ESTERNO_ID_EVENTO, ' +
          '  AGENDA.CALENDARIO_ESTERNO_VERSIONE = :CALENDARIO_ESTERNO_VERSIONE, ' +
          '  AGENDA.CALENDARIO_ESTERNO_DATA_MODIFICA = :CALENDARIO_ESTERNO_DATA_MODIFICA, ' +
          '  AGENDA.CALENDARIO_ESTERNO_DA_INVIARE = FALSE ' +
          'WHERE AGENDA.ID_AGENDA = :ID_AGENDA';
        FQuery.ParamByName('CALENDARIO_ESTERNO_ID_EVENTO').AsString := Risposta.Id;
        FQuery.ParamByName('CALENDARIO_ESTERNO_VERSIONE').AsString := Risposta.Versione;
        FQuery.ParamByName('CALENDARIO_ESTERNO_DATA_MODIFICA').AsDateTime := Risposta.UltimaModifica;
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

function TSessioneCalendario.Esegui(const Interattiva: Boolean; out Esito: string): Boolean;
var
  IdCalendario: string;
  RefreshTokenCifrato: string;
  RefreshToken: string;
  FornitoreSalvato: TFornitoreCalendario;
  Account: string;
  Valore: Variant;
  Collegamento: Boolean;
  Nome: string;
begin
  Result := False;
  Esito := '';
  Collegamento := False;
  Nome := TSincronizzazioneCalendario.NomeServizio(FFornitore);

  try
    FUserId := Config.Database.ExecSQLScalar('SELECT CURRENT_USER_ID() FROM RDB$DATABASE');
    Valore := Config.Database.ExecSQLScalar('SELECT CURRENT_ID_RISORSA() FROM RDB$DATABASE');
    if VarIsNull(Valore) then
    begin
      Esito := 'Il tuo utente non ' + #232 + ' collegato a una scheda del personale: non ha un''agenda da sincronizzare.';
      Exit;
    end;
    FIdRisorsa := Valore;

    FornitoreSalvato := FornitoreNessuno;
    Inizia;
    try
      FQuery.SQL.Text :=
        'SELECT USR_UTENTI_CALENDARI_ESTERNI.FORNITORE, USR_UTENTI_CALENDARI_ESTERNI.ID_CALENDARIO, ' +
        '       USR_UTENTI_CALENDARI_ESTERNI.REFRESH_TOKEN_CIFRATO, ' +
        '       USR_UTENTI_CALENDARI_ESTERNI.STATO_LETTURA, USR_UTENTI_CALENDARI_ESTERNI.STATO_LETTURA_DAL_GIORNO ' +
        'FROM USR_UTENTI_CALENDARI_ESTERNI ' +
        'WHERE USR_UTENTI_CALENDARI_ESTERNI.USER_ID = :USER_ID AND USR_UTENTI_CALENDARI_ESTERNI.ATTIVO = TRUE';
      FQuery.ParamByName('USER_ID').AsLargeInt := FUserId;
      FQuery.Open;
      if not FQuery.IsEmpty then
      begin
        FornitoreSalvato := FornitoreDaCodice(FQuery.FieldByName('FORNITORE').AsString);
        IdCalendario := FQuery.FieldByName('ID_CALENDARIO').AsString;
        RefreshTokenCifrato := FQuery.FieldByName('REFRESH_TOKEN_CIFRATO').AsString;
        FStatoLettura := FQuery.FieldByName('STATO_LETTURA').AsString;
        if not FQuery.FieldByName('STATO_LETTURA_DAL_GIORNO').IsNull then
          FStatoLetturaDal := FQuery.FieldByName('STATO_LETTURA_DAL_GIORNO').AsDateTime;
      end;
      FQuery.Close;
      Conferma;
    except
      Annulla;
      raise;
    end;

    // un solo calendario esterno per utente: per cambiarlo si scollega prima
    if (FornitoreSalvato <> FornitoreNessuno) and (FornitoreSalvato <> FFornitore) then
    begin
      Esito := Format('La tua agenda ' + #232 + ' gi' + #224 + ' collegata a %s: per passare a %s scollegala prima.',
        [TSincronizzazioneCalendario.NomeServizio(FornitoreSalvato), Nome]);
      Exit;
    end;
    Collegamento := FornitoreSalvato = FFornitore;

    if not CreaCalendario(IdCalendario, Esito) then
      Exit;

    Sblocca(RefreshTokenCifrato, RefreshToken);
    if not FCalendario.Accedi(RefreshToken, Interattiva, Esito) then
    begin
      if Collegamento then
        SalvaEsito(Esito);
      Exit;
    end;

    if not ControllaAccount(Account, Esito) then
      Exit;

    SalvaCollegamento(Account);
    Collegamento := True;

    RiceviDalCalendario;
    InviaEliminazioni;
    InviaAlCalendario;

    Esito := Format('Sincronizzazione con %s completata: %d eventi ricevuti, %d inviati, %d cancellati in %s.',
      [Nome, FRicevuti, FInviati, FEliminati, Nome]);
    if FIgnorati > 0 then
      Esito := Esito + Format(' %d eventi di %s su pi' + #249 + ' giorni non sono stati importati.', [FIgnorati, Nome]);

    SalvaEsito(Esito);
    Result := True;
  except
    on E: Exception do
    begin
      SiMain.LogError(Format('Sincronizzazione con %s: %s', [Nome, E.Message]));
      Esito := Format('Sincronizzazione con %s non riuscita: %s', [Nome, E.Message]);
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
