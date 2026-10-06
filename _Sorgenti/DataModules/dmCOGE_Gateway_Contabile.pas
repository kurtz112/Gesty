unit dmCOGE_Gateway_Contabile;

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
  dbMaster,
  zFbDataSet,
  EsportazioneContabile.Types,
  EsportazioneContabile.Base,
  EsportazioneContabile.Registry;


// Ponte applicativo fra il nucleo contabile COGE di Gesty e il motore di
// esportazione multi-gestionale (EsportazioneContabile.*, progettato in
// D:\AI\OUT\20260731-integrazione-gestionali-commerciali).
//
// Gemello di WT.EsportazioneContabile.Bridge: stesso contratto, tabelle
// diverse. Qui e SOLO qui vivono database, transazioni e Config; il motore e
// gli esportatori (Mexal, Ad Hoc, Gestionale 1) non toccano mai il database.
//
// Gesty non ha un concetto di azienda di lavoro corrente (a differenza di
// WT.Globals.AziendaDiLavoro): l'ente e' un parametro esplicito, passato dal
// chiamante (il wizard di esportazione) a GestionaleAttivo e a
// EsportaPrimaNota. CodiceEsterno e Parametro, che il motore richiama tramite
// IzCorrispondenzeContabili, presuppongono che uno dei due metodi sia gia'
// stato chiamato nella stessa istanza.
//
// Corrispondenza fra i due mondi:
// WT                                        Gesty
// ESPORTAZIONI_CONTABILI_CONFIGURAZIONE  -> COGE_INTERSCAMBIO_CONFIGURAZIONE
// ESPORTAZIONI_CONTABILI_CONFIG_PARAMETRI-> COGE_INTERSCAMBIO_CONFIG_PARAMETRI
// ESPORTAZIONI_CONTABILI_CORRISPONDENZE  -> COGE_INTERSCAMBIO_MAPPATURE
// (vista _MOTORE per i tipi lunghi)
// ESPORTAZIONI_CONTABILI_REGISTRAZIONI   -> COGE_INTERSCAMBIO_LOTTI
// ..._REGISTRAZIONI_FILES                -> COGE_INTERSCAMBIO_LOTTI_FILES
// ..._REGISTRAZIONI_DOCUMENTI            -> COGE_INTERSCAMBIO_LOTTI_RIGHE
// ID_AZIENDA                             -> ID_TENANT (ENTI, passato come ID_Ente)
//
// Flusso di una esportazione:
// 1. CaricaConfigurazione   gestionale attivo e cartella per l'ente
// 2. LottoApri              riga in COGE_INTERSCAMBIO_LOTTI, stato APE
// 3. CaricaMovimenti        COGE_INTERSCAMBIO_PRIMA_NOTA_DA_ESPORTARE
// 4. esportatore.EsportaPrimaNota, piu' l'analitica se il gestionale la
// prevede e il parametro ESPORTA_ANALITICA vale S
// 5. LottoRegistraFile      un record per file prodotto, lotto in PRO
// 6. LottoRegistraRighe     le registrazioni incluse, per l'anti-doppione
// 7. l'operatore importa i file nel gestionale e conferma: LottoConsegna
//
// Se una corrispondenza manca l'esportazione si ferma: un codice non mappato
// non deve mai finire silenziosamente nel file.

type
  TCOGE_Gateway_Contabile = class(TBaseDataModule, IzCorrispondenzeContabili)
  private
    FIdTenant: Int64;
    FGestionaleAttivo: string;
    FCartellaDestinazione: string;
    FConfigurazioneCaricata: Boolean;

    procedure CaricaConfigurazione(IdEnte: Int64);
    function NuovaQuery(const Sql: string): TzFbDataSet;
    function CaricaMovimenti(DataDa, DataA: TDate; AggregaPerConto: Boolean): TObjectList<TzMovimentoContabile>;

    function LottoApri(DataDa, DataA: TDate): Int64;
    procedure LottoRegistraFile(IdLotto: Int64; const FileProdotto: TzFileEsportato);
    procedure LottoRegistraRighe(IdLotto: Int64; Movimenti: TObjectList<TzMovimentoContabile>);
  public
    // IzCorrispondenzeContabili: la firma e' fissata dall'interfaccia, quindi
    // non puo' ricevere ID_Ente. Presuppongono CaricaConfigurazione gia'
    // eseguita da GestionaleAttivo o EsportaPrimaNota.
    function CodiceEsterno(Tipo: TzTipoCorrispondenza; const CodiceInterno: string): string;
    function Parametro(const Chiave, ValorePredefinito: string): string;
  public
    // Gestionale configurato per l'ente ('' = interscambio non configurato:
    // il comando di esportazione non compare)
    function GestionaleAttivo(IdEnte: Int64): string;

    // Esporta la prima nota del periodo e restituisce l'identificativo del
    // lotto. I file restano da consegnare: la consegna e' un atto
    // dell'operatore, che la conferma con LottoConsegna.
    function EsportaPrimaNota(IdEnte: Int64; DataDa, DataA: TDate): Int64;

    procedure LottoConsegna(IdLotto: Int64; const Messaggio: string);
    procedure LottoAnnulla(IdLotto: Int64; const Messaggio: string);
  public
    // Da agganciare a OnExecute delle TAction della form: chiedono conferma
    // con le Confirm di zMsg. IdLotto e StatoLotto li recuperano da soli dal
    // record corrente di Coge_Interscambio_Lotti (la griglia gia' in vista).
    // IdEnte, DataDa, DataA per l'esportazione arrivano dalla form perche' non
    // sono legati a nessun dataset del DM.
    procedure AzioneEsportaPrimaNota;
    procedure AzioneLottoConsegna;
    procedure AzioneLottoAnnulla;

    property CartellaDestinazione: string read FCartellaDestinazione;
  end;

var
  COGE_Gateway_Contabile: TCOGE_Gateway_Contabile;

implementation

{$R *.dfm}

uses
  System.IOUtils,
  System.StrUtils,
  ConfigModule,
  zMsg,
  EsportazioneContabile.Mexal.Analitica,
  frmSelezionaDate,
  System.DateUtils;

const
  // Tipi di corrispondenza come li conosce il motore: la vista
  // COGE_INTERSCAMBIO_CORRISPONDENZE_MOTORE traduce i codici a tre lettere
  // del dominio COGE in queste parole, cosi' il ponte non le deve sapere.
  CodiciTipoCorrispondenza: array [TzTipoCorrispondenza] of string = ('CONTO', 'CAUSALE', 'CODICE_IVA', 'PAGAMENTO', 'REGISTRO_IVA');

  ParametroEsportaAnalitica = 'ESPORTA_ANALITICA';
  ParametroAggregaPerConto = 'AGGREGA_PER_CONTO';

function TCOGE_Gateway_Contabile.NuovaQuery(const Sql: string): TzFbDataSet;
begin
  Result := TzFbDataSet.Create(Self);
  Result.Connection := Config.Database;
  Result.Transaction := ReadTrans;
  Result.UpdateTransaction := WriteTrans;
  Result.Sql.Text := Sql;
end;

procedure TCOGE_Gateway_Contabile.CaricaConfigurazione(IdEnte: Int64);
var
  dataset: TzFbDataSet;
begin
  // ricarica anche se gia' fatto, ma per un ente diverso: il dm puo' essere
  // riusato per piu' enti nella stessa sessione
  if FConfigurazioneCaricata and (FIdTenant = IdEnte) then
    Exit;

  FIdTenant := IdEnte;
  FGestionaleAttivo := '';
  FCartellaDestinazione := '';

  dataset := GetDataSet('lkConfig');
  try
    dataset.ParamByName('ID_TENANT').AsLargeInt := FIdTenant;
    dataset.Open;

    if not dataset.IsEmpty then
    begin
      FGestionaleAttivo := dataset.FieldByName('FORNITORE').AsString;
      FCartellaDestinazione := dataset.FieldByName('CARTELLA_USCITA').AsString;
    end;

    FConfigurazioneCaricata := True;
  finally
    dataset.Close;
  end;
end;

function TCOGE_Gateway_Contabile.GestionaleAttivo(IdEnte: Int64): string;
begin
  CaricaConfigurazione(IdEnte);
  Result := FGestionaleAttivo;
end;

function TCOGE_Gateway_Contabile.CodiceEsterno(Tipo: TzTipoCorrispondenza; const CodiceInterno: string): string;
var
  dataset: TzFbDataSet;
begin
  // codice IVA e pagamento possono essere legittimamente vuoti in ingresso
  if CodiceInterno = '' then
    Exit('');

  Assert(FConfigurazioneCaricata, 'CodiceEsterno chiamato prima di GestionaleAttivo/EsportaPrimaNota');

  dataset := GetDataSet('lkCodiceEsterno');
  try
    dataset.ParamByName('ID_TENANT').AsLargeInt := FIdTenant;
    dataset.ParamByName('GESTIONALE').AsString := FGestionaleAttivo;
    dataset.ParamByName('TIPO').AsString := CodiciTipoCorrispondenza[Tipo];
    dataset.ParamByName('CODICE_INTERNO').AsString := CodiceInterno;
    dataset.Open;

    if dataset.IsEmpty then
      raise EzEsportazioneContabile.CreateFmt('Corrispondenza mancante: %s "%s" non ha un codice per %s ' + '(tabella COGE_INTERSCAMBIO_MAPPATURE)', [CodiciTipoCorrispondenza[Tipo], CodiceInterno, FGestionaleAttivo]);

    Result := dataset.FieldByName('CODICE_ESTERNO').AsString;
  finally
    dataset.Close;
  end;
end;

function TCOGE_Gateway_Contabile.Parametro(const Chiave, ValorePredefinito: string): string;
var
  dataset: TzFbDataSet;
begin
  Assert(FConfigurazioneCaricata, 'Parametro chiamato prima di GestionaleAttivo/EsportaPrimaNota');

  Result := ValorePredefinito;

  dataset := GetDataSet('lkParametri');
  try
    dataset.ParamByName('ID_TENANT').AsLargeInt := FIdTenant;
    dataset.ParamByName('FORNITORE').AsString := FGestionaleAttivo;
    dataset.ParamByName('CHIAVE').AsString := Chiave;
    dataset.Open;

    if not dataset.IsEmpty and not dataset.FieldByName('VALORE').IsNull then
      Result := dataset.FieldByName('VALORE').AsString;
  finally
    dataset.Close;
  end;
end;

function TCOGE_Gateway_Contabile.CaricaMovimenti(DataDa, DataA: TDate; AggregaPerConto: Boolean): TObjectList<TzMovimentoContabile>;
var
  dataset: TzFbDataSet;
  Movimento: TzMovimentoContabile;
  Riga: TzRigaContabile;
  IdRegistrazioneCorrente: Int64;
begin
  Result := TObjectList<TzMovimentoContabile>.Create(True);
  try
    Movimento := nil;
    IdRegistrazioneCorrente := -1;

    dataset := GetDataSet('lkCaricaMovimenti');
    try
      dataset.ParamByName('ID_ENTE').AsLargeInt := FIdTenant;
      dataset.ParamByName('FORNITORE').AsString := FGestionaleAttivo;
      dataset.ParamByName('DATA_DA').AsDate := DataDa;
      dataset.ParamByName('DATA_A').AsDate := DataA;
      dataset.ParamByName('AGGREGA').AsBoolean := AggregaPerConto;
      dataset.Open;

      while not dataset.Eof do
      begin
        // la procedura restituisce la testata ripetuta su ogni movimento:
        // il cambio di ID_REGISTRAZIONE apre una nuova registrazione
        if dataset.FieldByName('ID_REGISTRAZIONE').AsLargeInt <> IdRegistrazioneCorrente then
        begin
          IdRegistrazioneCorrente := dataset.FieldByName('ID_REGISTRAZIONE').AsLargeInt;

          Movimento := TzMovimentoContabile.Create;
          Result.Add(Movimento);

          Movimento.DataRegistrazione := dataset.FieldByName('DATA_REGISTRAZIONE').AsDateTime;
          Movimento.CodiceCausale := dataset.FieldByName('CODICE_CAUSALE').AsString;
          Movimento.DescrizioneTestata := dataset.FieldByName('DESCRIZIONE_TESTATA').AsString;
          Movimento.NumeroDocumento := dataset.FieldByName('NUMERO_DOCUMENTO').AsString;
          Movimento.DataDocumento := dataset.FieldByName('DATA_DOCUMENTO').AsDateTime;
          Movimento.CodiceClienteFornitore := dataset.FieldByName('CODICE_SOGGETTO').AsString;
          Movimento.TotaleDocumento := dataset.FieldByName('TOTALE_DOCUMENTO').AsCurrency;
          Movimento.OidOrigine := dataset.FieldByName('OID_ORIGINE').AsString;
          Movimento.IdDocumentoOrigine := IdRegistrazioneCorrente;
        end;

        Riga := Movimento.AggiungiRiga;

        if dataset.FieldByName('TIPO_CONTO').AsString = 'C' then
          Riga.TipoConto := tcCliente
        else
          if dataset.FieldByName('TIPO_CONTO').AsString = 'F' then
            Riga.TipoConto := tcFornitore
          else
            Riga.TipoConto := tcGenerico;

        Riga.CodiceConto := dataset.FieldByName('CODICE_CONTO').AsString;
        Riga.ImportoDare := dataset.FieldByName('IMPORTO_DARE').AsCurrency;
        Riga.ImportoAvere := dataset.FieldByName('IMPORTO_AVERE').AsCurrency;
        Riga.DescrizioneRiga := dataset.FieldByName('DESCRIZIONE_RIGA').AsString;
        Riga.CodiceIva := dataset.FieldByName('CODICE_IVA').AsString;
        Riga.Imponibile := dataset.FieldByName('IMPONIBILE').AsCurrency;

        // campi aggiunti a TzRigaContabile per la contabilita analitica
        Riga.CodiceCommessa := dataset.FieldByName('CODICE_PROGETTO').AsString;
        Riga.CodiceCentroDiCosto := dataset.FieldByName('CENTRO_DI_COSTO').AsString;

        dataset.Next;
      end;
    finally
      dataset.Close;
    end;
  except
    Result.Free;
    raise;
  end;
end;

function TCOGE_Gateway_Contabile.EsportaPrimaNota(IdEnte: Int64; DataDa, DataA: TDate): Int64;
var
  Esportatore: IzEsportatoreContabile;
  Analitica: IzEsportatoreContabile;
  Movimenti: TObjectList<TzMovimentoContabile>;
  FileProdotti: TArray<TzFileEsportato>;
  FileAnalitica: TArray<TzFileEsportato>;
  FileProdotto: TzFileEsportato;
  AggregaPerConto: Boolean;
begin
  CaricaConfigurazione(IdEnte);

  if FGestionaleAttivo = '' then
    raise EzEsportazioneContabile.Create('Interscambio contabile non configurato per l''ente indicato ' + '(tabella COGE_INTERSCAMBIO_CONFIGURAZIONE)');

  if not TDirectory.Exists(FCartellaDestinazione) then
    raise EzEsportazioneContabile.CreateFmt('La cartella di uscita "%s" non esiste', [FCartellaDestinazione]);

  // Ad Hoc salda in una riga sola i conti ripetuti su righe consecutive:
  // meglio aggregare qui, consapevolmente, che scoprirlo dopo l'import.
  // Verso Mexal l'aggregazione va lasciata spenta, altrimenti si perde il
  // dettaglio per progetto che alimenta il file della contabilita analitica.
  AggregaPerConto := SameText(Parametro(ParametroAggregaPerConto, IfThen(SameText(FGestionaleAttivo, 'ADHOC'), 'S', 'N')), 'S');

  Esportatore := TzEsportatoriContabili.Crea(FGestionaleAttivo, Self);

  Movimenti := CaricaMovimenti(DataDa, DataA, AggregaPerConto);
  try
    if Movimenti.Count = 0 then
      raise EzEsportazioneContabile.Create('Nessuna registrazione da esportare nel periodo indicato');

    Result := LottoApri(DataDa, DataA);

    FileProdotti := Esportatore.EsportaPrimaNota(Movimenti, FCartellaDestinazione);

    for FileProdotto in FileProdotti do
      LottoRegistraFile(Result, FileProdotto);

    // quarto file di Mexal: le righe di contabilita analitica
    if SameText(FGestionaleAttivo, 'MEXAL') and SameText(Parametro(ParametroEsportaAnalitica, 'S'), 'S') then
    begin
      Analitica := TzEsportatoreAnaliticaMexal.Create(Self);
      FileAnalitica := Analitica.EsportaPrimaNota(Movimenti, FCartellaDestinazione);

      for FileProdotto in FileAnalitica do
        LottoRegistraFile(Result, FileProdotto);
    end;

    LottoRegistraRighe(Result, Movimenti);

    Commit;
  finally
    Movimenti.Free;
  end;
end;

function TCOGE_Gateway_Contabile.LottoApri(DataDa, DataA: TDate): Int64;
var
  dataset: TzFbDataSet;
begin
  dataset := GetDataSet('lkLottoApri');
  try
    dataset.ParamByName('ID_ENTE').AsLargeInt := FIdTenant;
    dataset.ParamByName('FORNITORE').AsString := FGestionaleAttivo;
    dataset.ParamByName('TIPO_FLUSSO').AsString := 'PNT';
    dataset.ParamByName('DIREZIONE').AsString := 'USC';
    dataset.ParamByName('CANALE').AsString := 'TRC';
    dataset.ParamByName('DATA_DA').AsDate := DataDa;
    dataset.ParamByName('DATA_A').AsDate := DataA;
    dataset.Open;

    Result := dataset.FieldByName('ID_LOTTO').AsLargeInt;
  finally
    dataset.Close;
  end;
end;

procedure TCOGE_Gateway_Contabile.LottoRegistraFile(IdLotto: Int64; const FileProdotto: TzFileEsportato);
var
  dataset: TzFbDataSet;
  Dimensione: Int64;
begin
  Dimensione := 0;
  if TFile.Exists(FileProdotto.NomeFile) then
    Dimensione := TFile.GetSize(FileProdotto.NomeFile);

  dataset := GetDataSet('lkLottoRegistraFile');
  try
    dataset.ParamByName('ID_LOTTO').AsLargeInt := IdLotto;
    dataset.ParamByName('RUOLO_FILE').AsString := FileProdotto.Ruolo;
    dataset.ParamByName('NOME_FILE').AsString := FileProdotto.NomeFile;
    dataset.ParamByName('DIMENSIONE_FILE').AsLargeInt := Dimensione;
    dataset.ParamByName('NUMERO_RIGHE').AsInteger := 0;
    dataset.Open;
  finally
    dataset.Close;
  end;
end;

procedure TCOGE_Gateway_Contabile.LottoRegistraRighe(IdLotto: Int64; Movimenti: TObjectList<TzMovimentoContabile>);
var
  dataset: TzFbDataSet;
  Movimento: TzMovimentoContabile;
begin
  dataset := GetDataSet('lkLottoRegistraRighe');
  try
    for Movimento in Movimenti do
    begin
      dataset.Close;
      dataset.ParamByName('ID_LOTTO').AsLargeInt := IdLotto;
      dataset.ParamByName('OID_INTERNO').AsLargeInt := Movimento.IdDocumentoOrigine;
      dataset.ParamByName('TIPO_OGGETTO').AsString := 'COGE_REGISTRAZIONI';
      dataset.ParamByName('RIFERIMENTO_INTERNO').AsString := Movimento.NumeroDocumento;
      dataset.ParamByName('IMPORTO').AsCurrency := Movimento.TotaleDocumento;
      dataset.Open;
    end;
  finally
    dataset.Close;
  end;
end;

procedure TCOGE_Gateway_Contabile.LottoConsegna(IdLotto: Int64; const Messaggio: string);
var
  Query: TzFbDataSet;
begin

  Query := NuovaQuery('EXECUTE PROCEDURE COGE_INTERSCAMBIO_LOTTO_CONSEGNA(:ID_LOTTO, :MESSAGGIO)');
  try
    Query.ParamByName('ID_LOTTO').AsLargeInt := IdLotto;
    Query.ParamByName('MESSAGGIO').AsString := Messaggio;
    Query.ExecSQL;

    Commit;
  finally
    Query.Free;
  end;
end;

procedure TCOGE_Gateway_Contabile.LottoAnnulla(IdLotto: Int64; const Messaggio: string);
var
  Query: TzFbDataSet;
begin
  Query := NuovaQuery('EXECUTE PROCEDURE COGE_INTERSCAMBIO_LOTTO_ANNULLA(:ID_LOTTO, :MESSAGGIO)');
  try
    Query.ParamByName('ID_LOTTO').AsLargeInt := IdLotto;
    Query.ParamByName('MESSAGGIO').AsString := Messaggio;
    Query.ExecSQL;

    Commit;
  finally
    Query.Free;
  end;
end;

procedure TCOGE_Gateway_Contabile.AzioneEsportaPrimaNota;
var
  IdLotto: Int64;
  IdEnte: Int64;
  DataDa, DataA: TDateTime;
begin
  IdEnte := GetDataSet('Coge_Interscambio_Lotti').ParamByName('ID_ENTE').AsLargeInt;

  DataDa := StartOfTheMonth(IncMonth(Date, -1));
  DataA := EndOfTheMonth(DataDa);

  if not SelezionaDate(DataDa, DataA) then
    Exit;

  if DataDa > DataA then
  begin
    ConfirmOk('Il periodo non e'' valido: la data iniziale e'' successiva alla data finale.', mtWarning);
    Exit;
  end;

  if GestionaleAttivo(IdEnte) = '' then
  begin
    ConfirmOk('Interscambio contabile non configurato per l''ente indicato.', mtWarning);
    Exit;
  end;

  if not ConfirmYesNo(Format('Confermi l''esportazione della prima nota dal %s al %s verso %s?', [DateToStr(DataDa), DateToStr(DataA), FGestionaleAttivo]), mtConfirmation) then
    Exit;

  try
    IdLotto := EsportaPrimaNota(IdEnte, DataDa, DataA);
  except
    on E: EzEsportazioneContabile do
    begin
      ConfirmOk(E.Message, mtError);
      Exit;
    end;
  end;

  RefreshDataSet('Coge_Interscambio_Lotti');
  ConfirmOk(Format('Esportazione completata: lotto %d prodotto.', [IdLotto]), mtInformation);
end;

procedure TCOGE_Gateway_Contabile.AzioneLottoConsegna;
var
  dataset: TzFbDataSet;
  IdLotto: Int64;
  Messaggio: string;
begin
  dataset := GetDataSet('Coge_Interscambio_Lotti');

  if not dataset.Active or dataset.IsEmpty then
  begin
    ConfirmOk('Seleziona il lotto da consegnare.', mtWarning);
    Exit;
  end;

  if dataset.FieldByName('STATO_LOTTO').AsString <> 'PRO' then
  begin
    ConfirmOk('Il lotto selezionato non e'' in stato "Prodotto": non puo'' essere consegnato.', mtWarning);
    Exit;
  end;

  IdLotto := dataset.FieldByName('ID_LOTTO').AsLargeInt;

  Messaggio := '';
  if not InputQuery('Consegna lotto', 'Note per la consegna (facoltative):', Messaggio) then
    Exit;

  if not ConfirmYesNo(Format('Confermi la consegna del lotto %d? ' + 'Da questo momento le registrazioni incluse non tornano piu'' fra quelle da esportare.', [IdLotto]), mtConfirmation) then
    Exit;

  LottoConsegna(IdLotto, Messaggio);

  RefreshDataSet('Coge_Interscambio_Lotti');
end;

procedure TCOGE_Gateway_Contabile.AzioneLottoAnnulla;
var
  dataset: TzFbDataSet;
  IdLotto: Int64;
  Messaggio: string;
begin
  dataset := GetDataSet('Coge_Interscambio_Lotti');

  if not dataset.Active or dataset.IsEmpty then
  begin
    ConfirmOk('Seleziona il lotto da annullare.', mtWarning);
    Exit;
  end;

  if not MatchText(dataset.FieldByName('STATO_LOTTO').AsString, ['APE', 'PRO']) then
  begin
    ConfirmOk('Il lotto selezionato e'' gia'' consegnato o chiuso: non puo'' essere annullato.', mtWarning);
    Exit;
  end;

  IdLotto := dataset.FieldByName('ID_LOTTO').AsLargeInt;

  Messaggio := '';
  if not InputQuery('Annulla lotto', 'Motivo dell''annullamento:', Messaggio) then
    Exit;

  if Trim(Messaggio) = '' then
  begin
    ConfirmOk('Indica il motivo dell''annullamento.', mtWarning);
    Exit;
  end;

  if not ConfirmYesNo(Format('Confermi l''annullamento del lotto %d? ' + 'Le registrazioni incluse tornano disponibili per una nuova esportazione.', [IdLotto]), mtConfirmation) then
    Exit;

  LottoAnnulla(IdLotto, Messaggio);

  RefreshDataSet('Coge_Interscambio_Lotti');
end;

end.
