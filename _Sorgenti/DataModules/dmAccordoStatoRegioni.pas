unit dmAccordoStatoRegioni;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Base_DataModule,
  zFbDataSet,
  dbMaster,
  zDbViewDlg,
  QImport3,
  QImport3XMLBased,
  QImport3Xlsx,
  QImport3XLS,
  cxMemo,
  dmGefosCooperazioneApplicativa;

type
  TAccordoStatoRegioni = class(TBaseDataModule)
    ImportStudentiDlg: TzDbViewDlg;
    QImport3Xlsx: TQImport3Xlsx;
    ImportNoteDlg: TzDbViewDlg;
    ImportAnagrafeDlg: TzDbViewDlg;
    procedure QImport3XlsxUserDefinedImport(Sender: TObject; Row: TQImportRow);
  private
    ImportLines: TStrings;
    // Corso per cui la generazione e' stata rimandata dopo il commit; corsi per cui l'operatore
    // ha rifiutato la proposta in questa sessione, per non richiederla a ogni salvataggio
    IdGiornateInAttesa: Int64;
    ProposteRifiutate: TList<Int64>;
    function CleanImportString(const s: string): string;
    procedure PrepareImportMapXLSX;
    function AreaRiferimentoProgetto(const IdProgetto: Variant): Variant;
    // GEFOS: numero della riga ASR corrente, 0 se non si puo' procedere
    function CorsoGefosCorrente: Int64;
    procedure AggiornaDatiGefos;
    // Crea il ponte, esegue l'operazione e lo libera; i dati mancanti segnalati dal
    // ponte (EGefosErrore) diventano un avviso, non un errore da assistenza
    procedure EseguiGefos(const Operazione: TProc<TGefosCooperazioneApplicativa>);
    // Corso ASR salvato: se GEFOS e' attivo per l'ente e il corso ha le date ma non le giornate,
    // le genera (corso di un giorno) o le propone (piu' giorni)
    procedure GeneraGiornateAlSalvataggio(const IdProgettoAsr: Int64);
    // AfterPost del corso: il commit dell'autocommit lo fa il dataset subito dopo l'evento, quindi
    // la generazione parte dopo, dal ciclo dei messaggi
    procedure ProgettiAsrSicurezzaAfterPost(DataSet: TDataSet);
    procedure GeneraGiornateInAttesa;
  protected
    procedure AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    function Commit(const Verbose: Boolean = True): Boolean; override;

    procedure NuovoIncarico;
    procedure ImportaFileIscrizioni(const FileName: string);
    procedure ImportaStudenti;
    procedure ImportaAnagrafe;

    procedure ImportNote(const LookupDataSet: string; memo: TcxMemo);

    // Comandi GEFOS della schermata: il lavoro lo fa TGefosCooperazioneApplicativa
    procedure GefosDatiCorso;
    procedure GefosGeneraGiornate;
    procedure GefosControllaCorso;
    procedure GefosComunicaAvvio;
    procedure GefosComunicaEsiti;
    procedure GefosConfermaConclusione;
    procedure GefosAggiornaTipologie;
  end;

var
  AccordoStatoRegioni: TAccordoStatoRegioni;

implementation

uses
  WizInserimentoIncaricoFrm,
  ConfigModule,
  Gesty_StoredProcs,
  zBaseLib,
  QImport3Common,
  zSystem,
  Gesty_Filters,
  zMsg,
  zMemoDialog,
  Gefos.Types;

{$R *.dfm}

constructor TAccordoStatoRegioni.Create(aOwner: TComponent);
begin
  inherited;
  ImportLines := TStringList.Create;
  ProposteRifiutate := TList<Int64>.Create;
end;

destructor TAccordoStatoRegioni.Destroy;
begin
  // Una generazione rimandata non deve partire su un modulo gia' distrutto
  TThread.RemoveQueuedEvents(nil, GeneraGiornateInAttesa);
  FreeAndNil(ProposteRifiutate);
  FreeAndNil(ImportLines);
  inherited;
end;

procedure TAccordoStatoRegioni.AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;
  if SameText(DataSetName, 'Progetti_Asr_Sicurezza') then
    DataSet.AfterPost := ProgettiAsrSicurezzaAfterPost;
end;

procedure TAccordoStatoRegioni.ProgettiAsrSicurezzaAfterPost(DataSet: TDataSet);
begin
  IdGiornateInAttesa := DataSet.FieldByName('ID_PROGETTO_ASR').AsLargeInt;
  if IdGiornateInAttesa <> 0 then
    TThread.ForceQueue(nil, GeneraGiornateInAttesa);
end;

procedure TAccordoStatoRegioni.GeneraGiornateInAttesa;
var
  IdProgettoAsr: Int64;
begin
  IdProgettoAsr := IdGiornateInAttesa;
  IdGiornateInAttesa := 0;
  if IdProgettoAsr <> 0 then
    GeneraGiornateAlSalvataggio(IdProgettoAsr);
end;

function TAccordoStatoRegioni.Commit(const Verbose: Boolean): Boolean;
var
  progetto: TzFbDataSet;
begin
  Result := inherited Commit(Verbose);
  // Con l'autocommit spento il salvataggio passa da qui: la riga e' ormai confermata
  if Result and DataSetExists('Progetti_Asr_Sicurezza') then
  begin
    progetto := getDataSet('Progetti_Asr_Sicurezza');
    if progetto.Active and not progetto.IsEmpty then
      GeneraGiornateAlSalvataggio(progetto.FieldByName('ID_PROGETTO_ASR').AsLargeInt);
  end;
end;

{ TAccordoStatoRegioni }

procedure TAccordoStatoRegioni.NuovoIncarico;
var
  dataset: TzFbDataSet;
  IdProgetto: integer;
  IdCorso: integer;
  TotaleOreAttribuite: double;
begin
  dataset := getDataSet('Progetti_Asr_Sicurezza');

  if dataset.isempty then
    exit;

  IdProgetto := dataset.fieldByName('ID_PROGETTO').asInteger;

  if dataset.fieldByName('ID_CORSO').isNull then
    IdCorso := -1
  else
    IdCorso := dataset.fieldByName('ID_CORSO').asInteger;

  TotaleOreAttribuite := dataset.fieldByName('ORE_TOTALI').AsFloat;

  if ApriInserimentoASR(IdProgetto, IdCorso, TotaleOreAttribuite) <> -1 then
  begin
    RefreshDataSet('Progetti_Asr_Sicurezza');
    ReopenDataSet('Progetti_Asr_Sicurezza_Incarichi_Elenco');
  end;
end;

procedure TAccordoStatoRegioni.ImportaFileIscrizioni(const FileName: string);
var
  progetto: TzFbDataSet;
  sp: TSP_PROGETTI_ASR_SICUREZZA_PARTECIPANTI_ISCRIVI_PARTECIPANTI;
begin
  progetto := getDataSet('Progetti_Asr_Sicurezza');

  if progetto.isempty then
    exit;

  ImportLines.Clear;
  PrepareImportMapXLSX;
  QImport3Xlsx.FileName := FileName;
  if not QImport3Xlsx.Execute then
    exit;

  StartWait('Attendere...', true);
  try
    sp := getsp<TSP_PROGETTI_ASR_SICUREZZA_PARTECIPANTI_ISCRIVI_PARTECIPANTI>;
    try
      sp.Id_Progetto_Asr := progetto.fieldByName('ID_PROGETTO_ASR').value;
      sp.File_Csv.Assign(ImportLines);
      sp.ExecuteAndCommit;

    finally
      FreeAndNil(sp);
    end;
    ReopenDataSet('Partecipanti');
  finally
    StopWait;
  end;
end;

procedure TAccordoStatoRegioni.ImportaStudenti;
var
  progetto, lkStudenti: TzFbDataSet;
  sp: TSP_PROGETTI_ASR_SICUREZZA_PARTECIPANTI_ISCRIVI_STUDENTE;
begin
  progetto := getDataSet('Progetti_Asr_Sicurezza');
  lkStudenti := getDataSet('lkStudenti');

  if progetto.isempty then
    exit;

  lkStudenti.RevertSQL(False);
  lkStudenti.ParamByName('ID_PROGETTO_ASR').value := progetto.fieldByName('ID_PROGETTO_ASR').value;
  lkStudenti.Active := true;
  try
    sp := getsp<TSP_PROGETTI_ASR_SICUREZZA_PARTECIPANTI_ISCRIVI_STUDENTE>;
    try
      sp.Id_Progetto_Asr := progetto.fieldByName('ID_PROGETTO_ASR').value;

      ImportStudentiDlg.dataset := lkStudenti;
      ImportStudentiDlg.Execute(
        procedure
        begin
          sp.Id_Studente_Progetto := lkStudenti.fieldByName('ID_STUDENTE_PROGETTO').value;
          sp.ExecuteAndCommit;
        end);
    finally
      FreeAndNil(sp);
    end;

    ReopenDataSet('Partecipanti');
  finally
    lkStudenti.Active := False;
  end;
end;

procedure TAccordoStatoRegioni.QImport3XlsxUserDefinedImport(Sender: TObject; Row: TQImportRow);
var
  s: String;
  i: integer;
begin
  s := '';

  for i := 0 to Row.Count - 1 do
    s := s + CleanImportString(Row.Items[i].value) + ';';

  ImportLines.Add(s);
end;

function TAccordoStatoRegioni.CleanImportString(const s: string): string;

  function StripChars(const text: string; const NonValidChars: System.SysUtils.TSysCharSet): string;
  var
    i, j, zbsAdj: integer;
  begin
    SetLength(result, Length(text)); // Preallocate result maximum length
    j := 0; // Resulting string length counter
    zbsAdj := 1 - Low(String); // Handles zero based string offset
    for i := Low(text) to High(text) do
    begin
      if not CharInSet(text[i], NonValidChars) then
      begin
        Inc(j);
        result[j - zbsAdj] := text[i];
      end;
    end;
    SetLength(result, j); // Set result actual length
  end;

begin
  result := s;
  result := result.Replace(';', ',', [rfReplaceAll]);
  result := result.Replace(sLineBreak, ' ', [rfReplaceAll]);
  result := result.Replace(#160, ' ', [rfReplaceAll]);
  result := StripChars(result, [#0 .. #31]);
  result := result.trim;
end;

procedure TAccordoStatoRegioni.PrepareImportMapXLSX;
begin
  QImport3Xlsx.ImportDestination := qidUserDefined;
  QImport3Xlsx.SkipFirstRows := 1;
  QImport3Xlsx.SheetName := '';

  QImport3Xlsx.Map.Clear;
  QImport3Xlsx.Map.Add('AZIENDA=A');
  QImport3Xlsx.Map.Add('PIVA=B');
  QImport3Xlsx.Map.Add('COGNOME=C');
  QImport3Xlsx.Map.Add('NOME=D');
  QImport3Xlsx.Map.Add('CODICE FISCALE=E');
end;

function TAccordoStatoRegioni.AreaRiferimentoProgetto(const IdProgetto: Variant): Variant;
var
  Query: TzFbDataSet;
begin
  Result := Null;

  if VarIsNull(IdProgetto) or VarIsEmpty(IdProgetto) then
    Exit;

  Query := TzFbDataSet.Create(nil);
  try
    Query.Connection := Config.Database;
    Query.Transaction := ReadTrans;
    Query.SQL.Text :=
      'SELECT PROGETTI.AREA_RIFERIMENTO FROM PROGETTI WHERE PROGETTI.ID_PROGETTO = :ID_PROGETTO';
    Query.ParamByName('ID_PROGETTO').Value := IdProgetto;
    Query.Active := True;

    if not Query.IsEmpty then
      Result := Query.Fields[0].Value;
  finally
    Query.Free;
  end;
end;

procedure TAccordoStatoRegioni.ImportNote(const LookupDataSet: string; memo: TcxMemo);
var
  dataset, lookup: TzFbDataSet;
begin
  dataset := getDataSet('Progetti_Asr_Sicurezza');
  lookup := getDataSet(LookupDataSet);

  dataset.CheckEditMode;

  // Mantis #269 - 2026-10-21: testi filtrati per l'area del progetto; se l'area
  // non ne ha, o il progetto non e' ancora scelto, si mostrano tutti come prima
  lookup.RevertSQL(False);
  if lookup.ParamExists('AREA_RIFERIMENTO') then
  begin
    lookup.ParamByName('AREA_RIFERIMENTO').Value := AreaRiferimentoProgetto(dataset.FieldByName('ID_PROGETTO').Value);
    lookup.Active := true;

    if lookup.IsEmpty and not lookup.ParamByName('AREA_RIFERIMENTO').IsNull then
    begin
      lookup.Active := False;
      lookup.ParamByName('AREA_RIFERIMENTO').Clear;
    end;
  end;
  lookup.Active := true;
  try
    ImportNoteDlg.dataset := lookup;
    ImportNoteDlg.Execute(
      procedure
      begin
        memo.lines.Add(lookup.fieldByName('NOTA').AsString);
      end);
  finally
    lookup.Active := False;
  end;
end;

procedure TAccordoStatoRegioni.ImportaAnagrafe;
var
  progetto, lkAnagrafe: TzFbDataSet;
  sp: TSP_PROGETTI_ASR_SICUREZZA_PARTECIPANTI_ISCRIVI_ANAGRAFICA;
begin
  progetto := getDataSet('Progetti_Asr_Sicurezza');
  lkAnagrafe := getDataSet('lkAnagrafe');

  if progetto.isempty then
    exit;

  lkAnagrafe.RevertSQL(False);
  lkAnagrafe.ParamByName('ID_PROGETTO_ASR').value := progetto.fieldByName('ID_PROGETTO_ASR').value;
  lkAnagrafe.Active := true;
  try
    sp := getsp<TSP_PROGETTI_ASR_SICUREZZA_PARTECIPANTI_ISCRIVI_ANAGRAFICA>;
    try
      sp.Id_Progetto_Asr := progetto.fieldByName('ID_PROGETTO_ASR').value;

      ImportAnagrafeDlg.dataset := lkAnagrafe;
      ImportAnagrafeDlg.Execute(
        procedure
        begin
          sp.Id_Anagrafica := lkAnagrafe.fieldByName('ID_ANAGRAFICA').value;
          sp.Id_Azienda := -1;
          sp.ExecuteAndCommit;
        end);
    finally
      FreeAndNil(sp);
    end;

    ReopenDataSet('Partecipanti');
  finally
    lkAnagrafe.Active := False;
  end;
end;

{ GEFOS }

function TAccordoStatoRegioni.CorsoGefosCorrente: Int64;
var
  progetto: TzFbDataSet;
begin
  Result := 0;
  progetto := getDataSet('Progetti_Asr_Sicurezza');
  if progetto.IsEmpty then
    Exit;

  // Il ponte legge dal database: le modifiche ancora aperte nella schermata
  // (giornate, partecipanti, dati GEFOS) non le vedrebbe
  if Modified then
  begin
    ConfirmOk('Salvare le modifiche prima di comunicare con GEFOS.');
    Exit;
  end;

  Result := progetto.FieldByName('ID_PROGETTO_ASR').AsLargeInt;
end;

procedure TAccordoStatoRegioni.AggiornaDatiGefos;
begin
  ReopenDataSet('Dati_Gefos');
  ReopenDataSet('Edizioni_Gefos');
  ReopenDataSet('Giornate');
end;

procedure TAccordoStatoRegioni.EseguiGefos(const Operazione: TProc<TGefosCooperazioneApplicativa>);
var
  Gefos: TGefosCooperazioneApplicativa;
begin
  Application.CreateForm(TGefosCooperazioneApplicativa, Gefos);
  try
    try
      Operazione(Gefos);
    except
      on Errore: EGefosErrore do
        ConfirmOk(Errore.Message, mtWarning);
    end;
  finally
    FreeAndNil(Gefos);
  end;
end;

procedure TAccordoStatoRegioni.GeneraGiornateAlSalvataggio(const IdProgettoAsr: Int64);
var
  Query: TzFbDataSet;
  DataInizio, DataFine: TDateTime;
  OraMattina, OraPomeriggio: TTime;
  CorsoDiUnGiorno: Boolean;
begin
  // Una riga senza chiave letta indietro dopo l'inserimento: resta il comando Genera giornate
  if (IdProgettoAsr = 0) or ProposteRifiutate.Contains(IdProgettoAsr) then
    Exit;

  // Solo dove GEFOS e' attivo per l'ente del corso: negli altri enti le giornate si
  // continuano a inserire dal calendario corsi, senza righe create da sole
  Query := TzFbDataSet.Create(nil);
  try
    Query.Connection := Config.Database;
    Query.Transaction := ReadTrans;
    Query.SQL.Text :=
      'SELECT ' +
      '    PROGETTI_ASR_SICUREZZA.DATA_INIZIO_EFFETTIVA, ' +
      '    PROGETTI_ASR_SICUREZZA.DATA_FINE_EFFETTIVA ' +
      'FROM ' +
      '    PROGETTI_ASR_SICUREZZA ' +
      '        INNER JOIN PROGETTI ON PROGETTI.ID_PROGETTO = PROGETTI_ASR_SICUREZZA.ID_PROGETTO ' +
      'WHERE ' +
      '    PROGETTI_ASR_SICUREZZA.ID_PROGETTO_ASR = :ID_PROGETTO_ASR AND ' +
      '    PROGETTI_ASR_SICUREZZA.DATA_INIZIO_EFFETTIVA IS NOT NULL AND ' +
      '    PROGETTI_ASR_SICUREZZA.DATA_FINE_EFFETTIVA IS NOT NULL AND ' +
      '    COALESCE(PROGETTI_ASR_SICUREZZA.ORE_TOTALI, 0) > 0 AND ' +
      '    EXISTS(SELECT 1 FROM GEFOS_COOPERAZIONE_APPLICATIVA_CONFIG ' +
      '           WHERE GEFOS_COOPERAZIONE_APPLICATIVA_CONFIG.ID_ENTE = PROGETTI.ID_ENTE AND ' +
      '                 GEFOS_COOPERAZIONE_APPLICATIVA_CONFIG.ATTIVO = TRUE) AND ' +
      '    NOT EXISTS(SELECT 1 FROM ORARIO ' +
      '               WHERE ORARIO.ID_PROGETTO = PROGETTI_ASR_SICUREZZA.ID_PROGETTO AND ' +
      '                     ORARIO.ID_CORSO IS NOT DISTINCT FROM PROGETTI_ASR_SICUREZZA.ID_CORSO)';
    Query.ParamByName('ID_PROGETTO_ASR').Value := IdProgettoAsr;
    Query.Active := True;

    if Query.IsEmpty then
      Exit;

    DataInizio := Query.FieldByName('DATA_INIZIO_EFFETTIVA').AsDateTime;
    DataFine := Query.FieldByName('DATA_FINE_EFFETTIVA').AsDateTime;
  finally
    Query.Free;
  end;

  CorsoDiUnGiorno := DataInizio = DataFine;
  if not CorsoDiUnGiorno then
    if not ConfirmYesNo(Format('Il corso va dal %s al %s e non ha ancora le giornate.' + sLineBreak + sLineBreak +
      'Generarle ora? Mattina dalle 09:00, pomeriggio dalle 14:00; gli orari si possono correggere nella scheda Giornate.',
      [DateToStr(DataInizio), DateToStr(DataFine)])) then
    begin
      ProposteRifiutate.Add(IdProgettoAsr);
      Exit;
    end;

  OraMattina := EncodeTime(9, 0, 0, 0);
  OraPomeriggio := EncodeTime(14, 0, 0, 0);

  // Il corso e' gia' salvato: un errore della generazione non annulla niente, si avvisa e
  // l'operatore puo' riprovare con il comando Genera giornate
  EseguiGefos(
    procedure(Gefos: TGefosCooperazioneApplicativa)
    var
      Esito: string;
    begin
      try
        Esito := Gefos.GeneraGiornate(IdProgettoAsr, OraMattina, OraPomeriggio, 4);
        // Il corso di un giorno non interrompe l'operatore: la scheda mostra le giornate
        if not CorsoDiUnGiorno then
          ConfirmOk(Esito);
      except
        on Errore: Exception do
          ConfirmOk('Le giornate non sono state generate: ' + Errore.Message, mtWarning);
      end;
    end);
  AggiornaDatiGefos;
end;

procedure TAccordoStatoRegioni.GefosDatiCorso;
var
  IdProgettoAsr: Int64;
begin
  IdProgettoAsr := CorsoGefosCorrente;
  if IdProgettoAsr = 0 then
    Exit;

  EseguiGefos(
    procedure(Gefos: TGefosCooperazioneApplicativa)
    begin
      if Gefos.PreparaCorsoGefos(IdProgettoAsr) then
        ConfirmOk('Dati GEFOS del corso pronti: verificare tipologia, sede e collegamento nella scheda Dati GEFOS.');
    end);
  AggiornaDatiGefos;
end;

procedure TAccordoStatoRegioni.GefosGeneraGiornate;
var
  IdProgettoAsr: Int64;
  Orari: array of string;
  OraMattina, OraPomeriggio: TDateTime;
begin
  IdProgettoAsr := CorsoGefosCorrente;
  if IdProgettoAsr = 0 then
    Exit;

  SetLength(Orari, 2);
  Orari[0] := '09:00';
  Orari[1] := '14:00';
  if not InputQuery('Genera giornate', ['Inizio della mattina', 'Inizio del pomeriggio'], Orari) then
    Exit;
  if not TryStrToTime(Orari[0], OraMattina) or not TryStrToTime(Orari[1], OraPomeriggio) then
  begin
    ConfirmOk('Orari non validi: scriverli nella forma 09:00.', mtWarning);
    Exit;
  end;

  EseguiGefos(
    procedure(Gefos: TGefosCooperazioneApplicativa)
    begin
      ConfirmOk(Gefos.GeneraGiornate(IdProgettoAsr, OraMattina, OraPomeriggio, 4));
    end);
  AggiornaDatiGefos;
end;

procedure TAccordoStatoRegioni.GefosControllaCorso;
var
  IdProgettoAsr: Int64;
begin
  IdProgettoAsr := CorsoGefosCorrente;
  if IdProgettoAsr = 0 then
    Exit;

  EseguiGefos(
    procedure(Gefos: TGefosCooperazioneApplicativa)
    var
      Problemi: string;
    begin
      Problemi := Gefos.ControllaCorso(IdProgettoAsr);
      if Problemi = '' then
        ConfirmOk('Il corso e'' pronto per la comunicazione dell''avvio a GEFOS.')
      else
        zExecuteMemoDialog(Problemi, 'GEFOS - controlli del corso', nil, nil, True);
    end);
end;

procedure TAccordoStatoRegioni.GefosComunicaAvvio;
var
  IdProgettoAsr: Int64;
begin
  IdProgettoAsr := CorsoGefosCorrente;
  if IdProgettoAsr = 0 then
    Exit;

  EseguiGefos(
    procedure(Gefos: TGefosCooperazioneApplicativa)
    begin
      Gefos.ComunicaAvvio(IdProgettoAsr);
    end);
  AggiornaDatiGefos;
end;

procedure TAccordoStatoRegioni.GefosComunicaEsiti;
var
  IdProgettoAsr: Int64;
begin
  IdProgettoAsr := CorsoGefosCorrente;
  if IdProgettoAsr = 0 then
    Exit;

  EseguiGefos(
    procedure(Gefos: TGefosCooperazioneApplicativa)
    begin
      Gefos.ComunicaEsiti(IdProgettoAsr);
    end);
  AggiornaDatiGefos;
end;

procedure TAccordoStatoRegioni.GefosConfermaConclusione;
var
  IdProgettoAsr: Int64;
begin
  IdProgettoAsr := CorsoGefosCorrente;
  if IdProgettoAsr = 0 then
    Exit;

  EseguiGefos(
    procedure(Gefos: TGefosCooperazioneApplicativa)
    begin
      Gefos.ConfermaConclusione(IdProgettoAsr);
    end);
  AggiornaDatiGefos;
end;

procedure TAccordoStatoRegioni.GefosAggiornaTipologie;
var
  progetto: TzFbDataSet;
  IdEnte: Int64;
begin
  // Le tipologie sono dell'ente: si prende quello del corso selezionato
  progetto := getDataSet('Progetti_Asr_Sicurezza');
  if progetto.IsEmpty then
  begin
    ConfirmOk('Selezionare un corso dell''ente di cui leggere le tipologie GEFOS.');
    Exit;
  end;

  IdEnte := progetto.FieldByName('ID_ENTE').AsLargeInt;
  EseguiGefos(
    procedure(Gefos: TGefosCooperazioneApplicativa)
    begin
      Gefos.AggiornaTipologie(IdEnte);
    end);
end;

end.
