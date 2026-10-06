// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-02
// ---------------------------------------------------------------------------
unit dmOrientamento;

// Modulo Orientamento (allegato tecnico all'offerta n. 7 del 30.07.2026).
// Griglie, schede e dataset nascono dai metadati LZ del DataModule 'Orientamento'
// (vedi "LZ - Metadati da inserire.md"): qui sta solo la logica che i metadati non esprimono.
//
// Dataset LZ attesi (nome esatto):
//   Orientamento_Contatti                  -> ORIENTAMENTO_CONTATTI_ELENCO (vista aggiornabile)
//   Orientamento_Contatti_Richieste        -> ORIENTAMENTO_CONTATTI_RICHIESTE
//   Orientamento_Contatti_Interazioni      -> ORIENTAMENTO_CONTATTI_INTERAZIONI
//   Orientamento_Contatti_Bes              -> ORIENTAMENTO_CONTATTI_BES (sezione riservata)
//   Anagrafe_Carriera_Alias                -> ANAGRAFE_CARRIERA_ALIAS (sezione riservata)
//   Orientamento_Scadenze                  -> SCADENZE con OID = contatto
//   Orientamento_Attivita                  -> ORIENTAMENTO_ATTIVITA, conteggi in join da ORIENTAMENTO_ATTIVITA_ELENCO
//   Orientamento_Attivita_Partecipanti     -> ORIENTAMENTO_ATTIVITA_PARTECIPANTI, nominativi in join dalla vista _ELENCO
//   Orientamento_Scadenze_Elenco           -> ORIENTAMENTO_SCADENZE_ELENCO
//   Comunicazioni_Modelli                  -> COMUNICAZIONI_MODELLI
//   Orientamento_Comunicazioni_Destinatari -> procedura ORIENTAMENTO_COMUNICAZIONI_DESTINATARI
//   Ente                                   -> ENTI (denominazione per il segnaposto {{ENTE}})
//   Alumni_Elenco                          -> ALUMNI_ELENCO (diplomati, sola lettura)

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  System.Classes,
  System.UITypes,
  System.Generics.Collections,
  Data.DB,
  Vcl.Controls,
  Vcl.Dialogs,
  Base_DataModule,
  zFbDataSet,
  dbMaster,
  zDbCardDlg,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl,
  Comunicazioni.Modelli;

type
  TOrientamento = class(TBaseDataModule)
    dlgInterazione: TzDbCardDlg;
  private
    FIdAttivitaDestinatari: Int64;
    FDescrizioneDestinatari: string;
    procedure Orientamento_ContattiNewRecord(DataSet: TDataSet);
    procedure Orientamento_Contatti_RichiesteNewRecord(DataSet: TDataSet);
    procedure Orientamento_Contatti_InterazioniNewRecord(DataSet: TDataSet);
    procedure Orientamento_AttivitaNewRecord(DataSet: TDataSet);
    procedure Orientamento_ScadenzeNewRecord(DataSet: TDataSet);
    procedure SezioneBesAfterOpen(DataSet: TDataSet);
    procedure SezioneAliasAfterOpen(DataSet: TDataSet);
    procedure RegistraConsultazione(const Oid: Int64; const Sezione: string);
    procedure PreparaDestinatari(const Stato, TipoRichiesta: string; const IdProgetto, IdAttivita: Int64;
      const SoloScadenzeNonRispettate, Promozionale: boolean; const Descrizione: string);
    function ValoriSegnaposto(Destinatari: TzFbDataSet): TComunicazioneValori;
    procedure RegistraEsitoInvio(const IdMessaggio: Int64; const Riuscito: boolean; const MessageId, Errore: string);
    function NomeComputer: string;
  protected
    procedure AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    // azioni della form
    procedure RegistraInterazione;
    procedure ConvertiInStudente;
    procedure DestinatariAttivitaSelezionata;
    procedure DestinatariScadenzeNonRispettate;
    procedure DestinatariStessoStato;
    procedure InviaComunicazioni;
    procedure AttivaPlacement;

    property DescrizioneDestinatari: string read FDescrizioneDestinatari;
  end;

var
  Orientamento: TOrientamento;

implementation

uses
  zOffice,
  zOffice.types,
  zOffice.Mail.Utils,
  Gesty_StoredProcs,
  dmCommon;

{$R *.dfm}

const
  STATO_NUOVO_CONTATTO = 'NUO';
  STATO_IMMATRICOLATO = 'IMM';
  SEZIONE_BES = 'BES';
  SEZIONE_CARRIERA_ALIAS = 'CARRIERA_ALIAS';
  // sportello di Servizi al Lavoro dei diplomati ITS (creato dallo script 04; la procedura lo crea se manca)
  SPORTELLO_PLACEMENT_ITS = 'Placement ITS';

{ TOrientamento }

procedure TOrientamento.AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'Orientamento_Contatti') then
    DataSet.OnNewRecord := Orientamento_ContattiNewRecord
  else
  if SameText(DataSetName, 'Orientamento_Contatti_Richieste') then
    DataSet.OnNewRecord := Orientamento_Contatti_RichiesteNewRecord
  else
  if SameText(DataSetName, 'Orientamento_Contatti_Interazioni') then
    DataSet.OnNewRecord := Orientamento_Contatti_InterazioniNewRecord
  else
  if SameText(DataSetName, 'Orientamento_Attivita') then
    DataSet.OnNewRecord := Orientamento_AttivitaNewRecord
  else
  if SameText(DataSetName, 'Orientamento_Scadenze') then
    DataSet.OnNewRecord := Orientamento_ScadenzeNewRecord
  else
  if SameText(DataSetName, 'Orientamento_Contatti_Bes') then
    DataSet.AfterOpen := SezioneBesAfterOpen
  else
  if SameText(DataSetName, 'Anagrafe_Carriera_Alias') then
    DataSet.AfterOpen := SezioneAliasAfterOpen
  else
  if SameText(DataSetName, 'Ente') then
    DataSet.ParamByName('ID_ENTE').AsInteger := Common.EnteDefault
  else
  if SameText(DataSetName, 'Orientamento_Comunicazioni_Destinatari') then
  begin
    // all'apertura l'elenco e' vuoto: lo riempiono le azioni "Destinatari..." con i filtri scelti dall'operatore
    DataSet.ParamByName('ID_ENTE').AsInteger := Common.EnteDefault;
    DataSet.ParamByName('STATO').Clear;
    DataSet.ParamByName('TIPO_RICHIESTA').Clear;
    DataSet.ParamByName('ID_PROGETTO').Clear;
    DataSet.ParamByName('ID_ATTIVITA_ORIENTAMENTO').AsLargeInt := -1;
    DataSet.ParamByName('SOLO_SCADENZE_NON_RISPETTATE').AsBoolean := False;
    DataSet.ParamByName('PROMOZIONALE').AsBoolean := False;
  end;
end;

// --- valori di partenza -----------------------------------------------------------------------------------------------

procedure TOrientamento.Orientamento_ContattiNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('ID_ENTE').AsInteger := Common.EnteDefault;
  DataSet.FieldByName('ID_OPERATORE_RIFERIMENTO').AsInteger := Common.CurrentIdRisorsa;
  DataSet.FieldByName('DATA_PRIMO_CONTATTO').AsDateTime := Date;
  DataSet.FieldByName('STATO').AsString := STATO_NUOVO_CONTATTO;
  DataSet.FieldByName('TIPOLOGIA_CONTATTO').AsString := 'STU';
  DataSet.FieldByName('CANALE_PRIMO_CONTATTO').AsString := 'TEL';
  DataSet.FieldByName('CONSENSO_PROMOZIONALE').AsBoolean := False;
end;

procedure TOrientamento.Orientamento_Contatti_RichiesteNewRecord(DataSet: TDataSet);
var
  Contatti: TzFbDataSet;
begin
  DataSet.FieldByName('DATA_RICHIESTA').AsDateTime := Date;
  DataSet.FieldByName('STATO_RICHIESTA').AsString := 'APE';

  // il corso di interesse del contatto e' la proposta di partenza per la richiesta
  Contatti := GetDataSet('Orientamento_Contatti');
  if Assigned(Contatti) and not Contatti.IsEmpty and not Contatti.FieldByName('ID_PROGETTO_INTERESSE').IsNull then
    DataSet.FieldByName('ID_PROGETTO').Value := Contatti.FieldByName('ID_PROGETTO_INTERESSE').Value;
end;

procedure TOrientamento.Orientamento_Contatti_InterazioniNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('DATA_ORA_INTERAZIONE').AsDateTime := Now;
  DataSet.FieldByName('ID_OPERATORE').AsInteger := Common.CurrentIdRisorsa;
  DataSet.FieldByName('CANALE').AsString := 'TEL';
  DataSet.FieldByName('DIREZIONE').AsString := 'E';
end;

procedure TOrientamento.Orientamento_AttivitaNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('ID_ENTE').AsInteger := Common.EnteDefault;
  DataSet.FieldByName('ID_RESPONSABILE').AsInteger := Common.CurrentIdRisorsa;
  DataSet.FieldByName('GIORNI_PREAVVISO_PROMEMORIA').AsInteger := 3;
  DataSet.FieldByName('POSTI_DISPONIBILI').AsInteger := 0;
end;

procedure TOrientamento.Orientamento_ScadenzeNewRecord(DataSet: TDataSet);
var
  Contatti: TzFbDataSet;
begin
  // SCADENZE e' la tabella generica di Gesty: OID e' il contatto, ID_RISORSA l'operatore che la segue
  Contatti := GetDataSet('Orientamento_Contatti');
  if Assigned(Contatti) and not Contatti.IsEmpty then
    DataSet.FieldByName('OID').AsLargeInt := Contatti.FieldByName('ID_CONTATTO_ORIENTAMENTO').AsLargeInt;

  DataSet.FieldByName('ID_RISORSA').AsInteger := Common.CurrentIdRisorsa;
  DataSet.FieldByName('DATA_SCADENZA').AsDateTime := Date;
end;

// --- registro delle consultazioni delle sezioni riservate -------------------------------------------------------------

procedure TOrientamento.SezioneBesAfterOpen(DataSet: TDataSet);
var
  Contatti: TzFbDataSet;
begin
  Contatti := GetDataSet('Orientamento_Contatti');
  if Assigned(Contatti) and not Contatti.IsEmpty then
    RegistraConsultazione(Contatti.FieldByName('ID_CONTATTO_ORIENTAMENTO').AsLargeInt, SEZIONE_BES);
end;

procedure TOrientamento.SezioneAliasAfterOpen(DataSet: TDataSet);
var
  Contatti: TzFbDataSet;
begin
  Contatti := GetDataSet('Orientamento_Contatti');
  if Assigned(Contatti) and not Contatti.IsEmpty then
    RegistraConsultazione(Contatti.FieldByName('ID_ANAGRAFICA').AsLargeInt, SEZIONE_CARRIERA_ALIAS);
end;

function TOrientamento.NomeComputer: string;
begin
  Result := GetEnvironmentVariable('COMPUTERNAME');
end;

procedure TOrientamento.RegistraConsultazione(const Oid: Int64; const Sezione: string);
var
  sp: TSP_USR_UTENTI_CONSULTAZIONI_ADD;
begin
  // la procedura ignora le ripetizioni entro dieci minuti: qui non serve nessun filtro
  sp := TSP_USR_UTENTI_CONSULTAZIONI_ADD.Create(WriteTrans);
  try
    sp.OID := Oid;
    sp.SEZIONE := Sezione;
    sp.COMPUTER := NomeComputer;
    try
      sp.ExecuteAndCommit;
    except
      on E: Exception do
        // la consultazione non deve mai bloccare l'operatore: si annota l'errore e si prosegue
        siMain.LogException(E);
    end;
  finally
    FreeAndNil(sp);
  end;
end;

// --- azioni --------------------------------------------------------------------------------------------------------------

procedure TOrientamento.RegistraInterazione;
var
  Interazioni: TzFbDataSet;
begin
  Interazioni := GetDataSet('Orientamento_Contatti_Interazioni');

  if GetDataSet('Orientamento_Contatti').IsEmpty then
    exit;

  Interazioni.Append;
  dlgInterazione.DataSet := Interazioni;

  if dlgInterazione.Execute then
    RefreshRecord('Orientamento_Contatti', False)
  else
    Interazioni.Cancel;
end;

procedure TOrientamento.ConvertiInStudente;
var
  Contatti: TzFbDataSet;
  sp: TSP_ORIENTAMENTO_CONTATTO_CONVERTI_STUDENTE;
  IdStudenteProgetto: Int64;
begin
  Contatti := GetDataSet('Orientamento_Contatti');

  if Contatti.IsEmpty then
    exit;

  if Contatti.FieldByName('STATO').AsString = STATO_IMMATRICOLATO then
    raise Exception.Create('Il contatto risulta gia'' immatricolato.');

  if Contatti.FieldByName('ID_PROGETTO_INTERESSE').IsNull then
    raise Exception.Create('Indicare il percorso di interesse sulla scheda del contatto: e'' il percorso di immatricolazione.');

  if MessageDlg(Format('Immatricolare %s al percorso "%s"?', [Contatti.FieldByName('NOMINATIVO').AsString,
    Contatti.FieldByName('DENOMINAZIONE_PROGETTO').AsString]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    exit;

  sp := TSP_ORIENTAMENTO_CONTATTO_CONVERTI_STUDENTE.Create(WriteTrans);
  try
    sp.ID_CONTATTO_ORIENTAMENTO := Contatti.FieldByName('ID_CONTATTO_ORIENTAMENTO').AsLargeInt;
    sp.ID_PROGETTO := Contatti.FieldByName('ID_PROGETTO_INTERESSE').AsLargeInt;
    sp.DATA_ISCRIZIONE := Date;
    sp.ID_OPERATORE := Common.CurrentIdRisorsa;
    sp.ExecuteAndCommit;
    IdStudenteProgetto := sp.ID_STUDENTE_PROGETTO.Value;
  finally
    FreeAndNil(sp);
  end;

  RefreshRecord('Orientamento_Contatti', False);
  ReopenDataSet('Orientamento_Contatti_Interazioni');
  ReopenDataSet('Orientamento_Contatti_Richieste');

  ShowMessage(Format('Immatricolazione registrata (iscrizione n. %d). La scheda dello studente e'' ora disponibile in Studenti.', [IdStudenteProgetto]));
end;

procedure TOrientamento.PreparaDestinatari(const Stato, TipoRichiesta: string; const IdProgetto, IdAttivita: Int64;
  const SoloScadenzeNonRispettate, Promozionale: boolean; const Descrizione: string);
var
  Destinatari: TzFbDataSet;
begin
  Destinatari := GetDataSet('Orientamento_Comunicazioni_Destinatari');
  Destinatari.Close;

  Destinatari.ParamByName('ID_ENTE').AsInteger := Common.EnteDefault;

  if Stato = '' then
    Destinatari.ParamByName('STATO').Clear
  else
    Destinatari.ParamByName('STATO').AsString := Stato;

  if TipoRichiesta = '' then
    Destinatari.ParamByName('TIPO_RICHIESTA').Clear
  else
    Destinatari.ParamByName('TIPO_RICHIESTA').AsString := TipoRichiesta;

  if IdProgetto <= 0 then
    Destinatari.ParamByName('ID_PROGETTO').Clear
  else
    Destinatari.ParamByName('ID_PROGETTO').AsLargeInt := IdProgetto;

  if IdAttivita <= 0 then
    Destinatari.ParamByName('ID_ATTIVITA_ORIENTAMENTO').Clear
  else
    Destinatari.ParamByName('ID_ATTIVITA_ORIENTAMENTO').AsLargeInt := IdAttivita;

  Destinatari.ParamByName('SOLO_SCADENZE_NON_RISPETTATE').AsBoolean := SoloScadenzeNonRispettate;
  Destinatari.ParamByName('PROMOZIONALE').AsBoolean := Promozionale;

  FIdAttivitaDestinatari := IdAttivita;
  FDescrizioneDestinatari := Descrizione;

  Destinatari.Open;
end;

procedure TOrientamento.DestinatariAttivitaSelezionata;
var
  Attivita: TzFbDataSet;
begin
  Attivita := GetDataSet('Orientamento_Attivita');

  if Attivita.IsEmpty then
    raise Exception.Create('Selezionare un''attivita'' del calendario.');

  PreparaDestinatari('', '', -1, Attivita.FieldByName('ID_ATTIVITA_ORIENTAMENTO').AsLargeInt, False, False,
    'Partecipanti a: ' + Attivita.FieldByName('DESCRIZIONE').AsString);
end;

procedure TOrientamento.DestinatariScadenzeNonRispettate;
begin
  PreparaDestinatari('', '', -1, -1, True, False, 'Contatti con scadenze non rispettate');
end;

procedure TOrientamento.DestinatariStessoStato;
var
  Contatti: TzFbDataSet;
begin
  Contatti := GetDataSet('Orientamento_Contatti');

  if Contatti.IsEmpty then
    raise Exception.Create('Selezionare un contatto: l''elenco raccoglie tutti quelli nella sua stessa fase del percorso.');

  PreparaDestinatari(Contatti.FieldByName('STATO').AsString, '', -1, -1, False, False,
    'Contatti in stato ' + Contatti.FieldByName('STATO').AsString);
end;

function TOrientamento.ValoriSegnaposto(Destinatari: TzFbDataSet): TComunicazioneValori;
var
  Attivita: TzFbDataSet;
  Scadenze: TzFbDataSet;
  Ente: TzFbDataSet;
begin
  Result := TComunicazioneValori.Create;

  Result.Add(TComunicazioniSegnaposto.Nominativo, Destinatari.FieldByName('NOMINATIVO').AsString);
  Result.Add(TComunicazioniSegnaposto.Nome, Destinatari.FieldByName('NOME').AsString);
  Result.Add(TComunicazioniSegnaposto.Cognome, Destinatari.FieldByName('COGNOME').AsString);
  Result.Add(TComunicazioniSegnaposto.Corso, Destinatari.FieldByName('DENOMINAZIONE_PROGETTO').AsString);
  Result.Add(TComunicazioniSegnaposto.AnnoFormativo, Destinatari.FieldByName('ANNO_FORMATIVO').AsString);
  Result.Add(TComunicazioniSegnaposto.DataOggi, DateToStr(Date));
  Result.Add(TComunicazioniSegnaposto.Operatore, SMTPServerParams.From);

  Ente := FindDataSet('Ente');
  if Assigned(Ente) and Ente.Active and not Ente.IsEmpty then
    Result.Add(TComunicazioniSegnaposto.Ente, Ente.FieldByName('DENOMINAZIONE_ENTE').AsString);

  // attivita': solo se l'elenco e' stato costruito a partire da un'attivita' del calendario
  if FIdAttivitaDestinatari > 0 then
  begin
    Attivita := GetDataSet('Orientamento_Attivita');
    if not Attivita.IsEmpty and (Attivita.FieldByName('ID_ATTIVITA_ORIENTAMENTO').AsLargeInt = FIdAttivitaDestinatari) then
    begin
      Result.Add(TComunicazioniSegnaposto.Attivita, Attivita.FieldByName('DESCRIZIONE').AsString);
      Result.Add(TComunicazioniSegnaposto.DataAttivita, FormatDateTime('dd/mm/yyyy', Attivita.FieldByName('DATA_ORA_INIZIO').AsDateTime));
      Result.Add(TComunicazioniSegnaposto.OraAttivita, FormatDateTime('hh:nn', Attivita.FieldByName('DATA_ORA_INIZIO').AsDateTime));
      Result.Add(TComunicazioniSegnaposto.Luogo, Attivita.FieldByName('LUOGO').AsString);
    end;
  end;

  // scadenza: la prima non rispettata del contatto, letta dallo scadenzario
  Scadenze := FindDataSet('Orientamento_Scadenze_Elenco');
  if Assigned(Scadenze) and Scadenze.Active and
    Scadenze.Locate('ID_CONTATTO_ORIENTAMENTO;SCADUTA', VarArrayOf([Destinatari.FieldByName('ID_CONTATTO_ORIENTAMENTO').Value, True]), []) then
    Result.Add(TComunicazioniSegnaposto.Scadenza, Scadenze.FieldByName('SCADENZA').AsString);
end;

procedure TOrientamento.RegistraEsitoInvio(const IdMessaggio: Int64; const Riuscito: boolean; const MessageId, Errore: string);
var
  spInviato: TSP_OBJ_FILES_MAIL_E_MESSAGGI_INVIATO;
  spErrore: TSP_OBJ_FILES_MAIL_E_MESSAGGI_ERRORE;
begin
  if Riuscito then
  begin
    spInviato := TSP_OBJ_FILES_MAIL_E_MESSAGGI_INVIATO.Create(WriteTrans);
    try
      spInviato.ID_MESSAGGIO := IdMessaggio;
      spInviato.MESSAGE_ID := MessageId;
      spInviato.ExecuteAndCommit;
    finally
      FreeAndNil(spInviato);
    end;
  end
  else
  begin
    spErrore := TSP_OBJ_FILES_MAIL_E_MESSAGGI_ERRORE.Create(WriteTrans);
    try
      spErrore.ID_MESSAGGIO := IdMessaggio;
      spErrore.MESSAGGIO.Text := Errore;
      spErrore.ExecuteAndCommit;
    finally
      FreeAndNil(spErrore);
    end;
  end;
end;

procedure TOrientamento.InviaComunicazioni;
var
  Destinatari: TzFbDataSet;
  Modelli: TzFbDataSet;
  Modello: TComunicazioneModello;
  Valori: TComunicazioneValori;
  Writer: TzOfficeMailWriter;
  Mail: TMail;
  MessageId: string;
  spRegistra: TSP_ORIENTAMENTO_COMUNICAZIONE_REGISTRA;
  IdMessaggio: Int64;
  Oggetto: string;
  CorpoTesto: string;
  CorpoHtml: string;
  SegnapostoMancanti: string;
  Inviate: integer;
  Saltate: integer;
  Errori: integer;
  RispostaConferma: integer;
  Interrotto: boolean;
begin
  Destinatari := GetDataSet('Orientamento_Comunicazioni_Destinatari');
  Modelli := GetDataSet('Comunicazioni_Modelli');

  if not Destinatari.Active or Destinatari.IsEmpty then
    raise Exception.Create('L''elenco dei destinatari e'' vuoto: costruirlo con una delle azioni "Destinatari...".');

  Modello := TComunicazioneModello.DaDataSet(Modelli);

  CheckSMTPServerParams;

  // i segnaposto senza valore si vedono prima di spedire, non nella casella del destinatario
  Destinatari.First;
  Valori := ValoriSegnaposto(Destinatari);
  try
    SegnapostoMancanti := Modello.SegnapostoMancanti(Valori);
  finally
    FreeAndNil(Valori);
  end;

  if (SegnapostoMancanti <> '') and
    (MessageDlg(Format('Il modello "%s" usa segnaposto senza valore in questo elenco: %s.'#13#10 +
    'Verranno lasciati nel testo cosi'' come sono. Proseguire?', [Modello.Codice, SegnapostoMancanti]),
    mtWarning, [mbYes, mbNo], 0) <> mrYes) then
    exit;

  if MessageDlg(Format('Inviare il modello "%s" a %d destinatari (%s)?', [Modello.Descrizione, Destinatari.RecordCount,
    FDescrizioneDestinatari]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    exit;

  Inviate := 0;
  Saltate := 0;
  Errori := 0;
  Interrotto := False;

  Writer := TzOfficeMailWriter.Create(nil);
  try
    Destinatari.DisableControls;
    try
      Destinatari.First;
      while not Destinatari.Eof and not Interrotto do
      begin
        if not Destinatari.FieldByName('SPEDIBILE').AsBoolean then
        begin
          Inc(Saltate);
          Destinatari.Next;
          continue;
        end;

        Valori := ValoriSegnaposto(Destinatari);
        try
          Oggetto := Modello.OggettoRenderizzato(Valori);
          CorpoTesto := Modello.CorpoTestoRenderizzato(Valori);
          CorpoHtml := Modello.CorpoHtmlRenderizzato(Valori);
        finally
          FreeAndNil(Valori);
        end;

        // convocazioni alle prove di selezione: conferma esplicita su ciascun invio (allegato, cap. 2)
        if Modello.ConfermaSingoloInvio then
        begin
          RispostaConferma := MessageDlg(Format('Inviare a %s <%s>?'#13#10#13#10'Oggetto: %s'#13#10#13#10'%s',
            [Destinatari.FieldByName('NOMINATIVO').AsString, Destinatari.FieldByName('E_MAIL').AsString, Oggetto, CorpoTesto]),
            mtConfirmation, [mbYes, mbNo, mbCancel], 0);

          if RispostaConferma = mrCancel then
          begin
            Interrotto := True;
            break;
          end;

          if RispostaConferma <> mrYes then
          begin
            Inc(Saltate);
            Destinatari.Next;
            continue;
          end;
        end;

        // 1. registrazione (stato P) prima dell'invio: se il client cade a meta', il tentativo resta tracciato
        spRegistra := TSP_ORIENTAMENTO_COMUNICAZIONE_REGISTRA.Create(WriteTrans);
        try
          spRegistra.ID_CONTATTO_ORIENTAMENTO := Destinatari.FieldByName('ID_CONTATTO_ORIENTAMENTO').AsLargeInt;
          spRegistra.ID_ENTE := Common.EnteDefault;
          spRegistra.ID_OPERATORE := Common.CurrentIdRisorsa;
          spRegistra.OGGETTO := Oggetto;
          if CorpoHtml <> '' then
            spRegistra.CORPO.Text := CorpoHtml
          else
            spRegistra.CORPO.Text := CorpoTesto;
          spRegistra.INDIRIZZO := Destinatari.FieldByName('E_MAIL').AsString;
          spRegistra.INDIRIZZO_MITTENTE := SMTPServerParams.FromAddress;
          if FIdAttivitaDestinatari > 0 then
            spRegistra.ID_ATTIVITA_ORIENTAMENTO := FIdAttivitaDestinatari;
          spRegistra.ID_MODELLO_COMUNICAZIONE := Modello.IdModello;
          spRegistra.ExecuteAndCommit;
          IdMessaggio := spRegistra.ID_MESSAGGIO.Value;
        finally
          FreeAndNil(spRegistra);
        end;

        // 2. invio SMTP
        Mail.Init;
        Mail.A := Destinatari.FieldByName('E_MAIL').AsString;
        Mail.Oggetto := Oggetto;
        Mail.CorpoTxt := CorpoTesto;
        Mail.CorpoHtml := CorpoHtml;

        try
          if Writer.SendMail(Mail, SMTPServerParams, MessageId) then
          begin
            RegistraEsitoInvio(IdMessaggio, True, MessageId, '');
            Inc(Inviate);
          end
          else
          begin
            RegistraEsitoInvio(IdMessaggio, False, '', 'Invio rifiutato dal server SMTP');
            Inc(Errori);
          end;
        except
          on E: Exception do
          begin
            siMain.LogException(E);
            RegistraEsitoInvio(IdMessaggio, False, '', E.Message);
            Inc(Errori);
          end;
        end;

        Destinatari.Next;
      end;
    finally
      Destinatari.EnableControls;
    end;
  finally
    FreeAndNil(Writer);
  end;

  ReopenDataSet('Orientamento_Contatti_Interazioni');
  ReopenDataSet('Orientamento_Attivita_Partecipanti');
  ReopenDataSet('Orientamento_Scadenze_Elenco');

  ShowMessage(Format('Comunicazioni inviate: %d'#13#10'Saltate (non spedibili o non confermate): %d'#13#10'Errori di invio: %d%s',
    [Inviate, Saltate, Errori, IfThen(Interrotto, #13#10'Invio interrotto dall''operatore.', '')]));
end;

// --- placement dei diplomati ---------------------------------------------------------------------------------------------

procedure TOrientamento.AttivaPlacement;
var
  Diplomati: TzFbDataSet;
  sp: TSP_ALUMNI_ATTIVA_PLACEMENT;
begin
  Diplomati := GetDataSet('Alumni_Elenco');

  if Diplomati.IsEmpty then
    raise Exception.Create('Selezionare un diplomato nell''elenco dei diplomati.');

  if Diplomati.FieldByName('UTENTE_SAL').AsBoolean then
    raise Exception.Create(Format('%s e'' gia'' fra gli utenti di Servizi al Lavoro.', [Diplomati.FieldByName('NOMINATIVO').AsString]));

  if MessageDlg(Format('Iscrivere %s allo sportello "%s" di Servizi al Lavoro?', [Diplomati.FieldByName('NOMINATIVO').AsString,
    SPORTELLO_PLACEMENT_ITS]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    exit;

  // la procedura crea la riga SAL_UTENTI (stesso OID della persona) e lo sportello se manca; non duplica nulla
  sp := TSP_ALUMNI_ATTIVA_PLACEMENT.Create(WriteTrans);
  try
    sp.ID_STUDENTE_PROGETTO := Diplomati.FieldByName('ID_STUDENTE_PROGETTO').AsLargeInt;
    sp.SPORTELLO_SAL := SPORTELLO_PLACEMENT_ITS;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  ReopenDataSet('Alumni_Elenco');

  ShowMessage('Diplomato iscritto al placement: disponibilita'', candidature e colloqui si registrano in Servizi al Lavoro.');
end;

end.
