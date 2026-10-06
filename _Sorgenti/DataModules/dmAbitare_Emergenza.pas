unit dmAbitare_Emergenza;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  CalcoloAbitare.Lib,
  Base_DataModule,
  dbMaster,
  zFbDataSet,
  zDbViewDlg;

type
  TAbitareEmergenza = class(TBaseDataModule)
    dlgCoperture: TzDbViewDlg;
  protected
    procedure AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet); override;
  private
    procedure Abitare_Emergenza_Pronto_Intervento_ElencoBeforePost(DataSet: TDataSet);
    procedure Abitare_Emergenza_Pronto_Intervento_ElencoAfterPost(DataSet: TDataSet);
  private
    procedure Abitare_Emergenza_Progetti_ElencoBeforePost(DataSet: TDataSet);
    procedure Abitare_Emergenza_Progetti_ElencoAfterPost(DataSet: TDataSet);
  private
    function ValoriProntoIntervento(DataSet: TDataSet; const Previsto: Boolean): TValoriProntoIntervento;
    function ValoriProgetto(DataSet: TDataSet; const Previsto: Boolean): TValoriProgetto;
    procedure VerificaImportoForzato(DataSet: TDataSet; const CampoForzato, Descrizione: string; const ValoreCalcolato: Currency;
      const Fonti: array of string);
    procedure ImpostaBloccoImporti(const DataSetName, CampoChiave: string; const Blocca: Boolean);
  private
    procedure Abitare_Emergenza_CopertureNewRecord(DataSet: TDataSet);
    procedure Abitare_Emergenza_CopertureAfterPost(DataSet: TDataSet);
    procedure Abitare_Emergenza_CopertureAfterDelete(DataSet: TDataSet);
    //
    procedure Abitare_Emergenza_FattureNewRecord(DataSet: TDataSet);
    procedure Abitare_Emergenza_FattureAfterPost(DataSet: TDataSet);
    procedure Abitare_Emergenza_FattureAfterDelete(DataSet: TDataSet);
  private
    procedure Abitare_Emergenza_Progetti_FattureNewRecord(DataSet: TDataSet);
    procedure Abitare_Emergenza_Progetti_FattureAfterPost(DataSet: TDataSet);
    procedure Abitare_Emergenza_Progetti_FattureAfterDelete(DataSet: TDataSet);
  private
    procedure Abitare_Emergenza_Progetti_CopertureNewRecord(DataSet: TDataSet);
    procedure Abitare_Emergenza_Progetti_CopertureAfterPost(DataSet: TDataSet);
    procedure Abitare_Emergenza_Progetti_CopertureAfterDelete(DataSet: TDataSet);
  public
    function DuplicaProntoIntervento: Boolean;
    procedure ProntoInterventoCoperture;
    // Voci della barra strumenti, agganciate nel dizionario LZ
    procedure BloccaImportiProntoIntervento;
    procedure SbloccaImportiProntoIntervento;
  public
    function DuplicaProgetto: Boolean;
    procedure ProgettoCoperture;
    procedure BloccaImportiProgetto;
    procedure SbloccaImportiProgetto;
  public
    procedure ProntoInterventoImpostaFiltroFatturato(const Data: TDateTime);
    procedure ProgettiImpostaFiltroFatturato(const Data: TDateTime);
  end;

var
  AbitareEmergenza: TAbitareEmergenza;

implementation

uses
  Gesty_StoredProcs,
  zMsg,
  zBaseLib;

{$R *.dfm}
{ TAbitareEmergenza }

procedure TAbitareEmergenza.AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'Abitare_Emergenza_Pronto_Intervento_Elenco') then
  begin
    DataSet.BeforePost := Abitare_Emergenza_Pronto_Intervento_ElencoBeforePost;
    DataSet.AfterPost := Abitare_Emergenza_Pronto_Intervento_ElencoAfterPost;
  end
  else
    if SameText(DataSetName, 'Abitare_Emergenza_Pronto_Intervento_Coperture') then
    begin
      DataSet.OnNewRecord := Abitare_Emergenza_CopertureNewRecord;
      DataSet.AfterPost := Abitare_Emergenza_CopertureAfterPost;
      DataSet.AfterDelete := Abitare_Emergenza_CopertureAfterDelete;
    end
    else
      if SameText(DataSetName, 'Abitare_Emergenza_Fatture') then
      begin
        DataSet.OnNewRecord := Abitare_Emergenza_FattureNewRecord;
        DataSet.AfterPost := Abitare_Emergenza_FattureAfterPost;
        DataSet.AfterDelete := Abitare_Emergenza_FattureAfterDelete;
      end
      else
        if SameText(DataSetName, 'Abitare_Emergenza_Progetti_Elenco') then
        begin
          DataSet.BeforePost := Abitare_Emergenza_Progetti_ElencoBeforePost;
          DataSet.AfterPost := Abitare_Emergenza_Progetti_ElencoAfterPost;
        end
        else
          if SameText(DataSetName, 'Abitare_Emergenza_Progetti_Fatture') then
          begin
            DataSet.OnNewRecord := Abitare_Emergenza_Progetti_FattureNewRecord;
            DataSet.AfterPost := Abitare_Emergenza_Progetti_FattureAfterPost;
            DataSet.AfterDelete := Abitare_Emergenza_Progetti_FattureAfterDelete;
          end
          else
            if SameText(DataSetName, 'Abitare_Emergenza_Progetti_Coperture') then
            begin
              DataSet.OnNewRecord := Abitare_Emergenza_Progetti_CopertureNewRecord;
              DataSet.AfterPost := Abitare_Emergenza_Progetti_CopertureAfterPost;
              DataSet.AfterDelete := Abitare_Emergenza_Progetti_CopertureAfterDelete;
            end
end;

procedure TAbitareEmergenza.ProntoInterventoCoperture;
var
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet('Abitare_Emergenza_Pronto_Intervento_Coperture');

  dlgCoperture.DataSet := DataSet;
  try
    dlgCoperture.Execute();
  finally
    dlgCoperture.DataSet := nil;
  end;

  RefreshRecord('Abitare_Emergenza_Pronto_Intervento_Elenco', false);
end;

procedure TAbitareEmergenza.Abitare_Emergenza_CopertureNewRecord(DataSet: TDataSet);
var
  Intervento, Coperture: TzFbDataSet;
begin
  Intervento := GetDataSet('Abitare_Emergenza_Pronto_Intervento_Elenco');
  Coperture := GetDataSet('Abitare_Emergenza_Pronto_Intervento_Coperture');

  Coperture.FieldByName('ID_INTERVENTO_OBJ').Value := Intervento.FieldByName('ID_PRONTO_INTERVENTO').Value;
  Coperture.FieldByName('TIPOLOGIA_INTERVENTO').Value := Intervento.FieldByName('TIPOLOGIA_INTERVENTO').Value;
  Coperture.FieldByName('IMPORTO_COPERTURA').Value := Intervento.FieldByName('RESIDUO_DA_COPRIRE').Value;
end;

procedure TAbitareEmergenza.Abitare_Emergenza_CopertureAfterPost(DataSet: TDataSet);
begin
  RefreshRecord('Abitare_Emergenza_Pronto_Intervento_Elenco', false);
end;

procedure TAbitareEmergenza.Abitare_Emergenza_CopertureAfterDelete(DataSet: TDataSet);
begin
  RefreshRecord('Abitare_Emergenza_Pronto_Intervento_Elenco', false);
end;

procedure TAbitareEmergenza.Abitare_Emergenza_FattureNewRecord(DataSet: TDataSet);
var
  fatture, Intervento: TzFbDataSet;
begin
  Intervento := GetDataSet('Abitare_Emergenza_Pronto_Intervento_Elenco');
  fatture := TzFbDataSet(DataSet);
  fatture.FieldByName('ID_INTERVENTO_OBJ').Value := Intervento.FieldByName('ID_PRONTO_INTERVENTO').Value;
  fatture.FieldByName('TIPOLOGIA_INTERVENTO').Value := Intervento.FieldByName('TIPOLOGIA_INTERVENTO').Value;
  fatture.FieldByName('ID_FORNITORE_OBJ').Value := Intervento.FieldByName('ID_STRUTTURA_RICETTIVA').Value;
  // readonly
  fatture.SetFieldValue('DESC_FORNITORE', Intervento.FieldByName('DESC_STRUTTURA_RICETTIVA').Value);
end;

procedure TAbitareEmergenza.Abitare_Emergenza_FattureAfterPost(DataSet: TDataSet);
begin
  RefreshRecord('Abitare_Emergenza_Pronto_Intervento_Coperture', false);
end;

procedure TAbitareEmergenza.Abitare_Emergenza_FattureAfterDelete(DataSet: TDataSet);
begin
  RefreshRecord('Abitare_Emergenza_Pronto_Intervento_Coperture', false);
end;

procedure TAbitareEmergenza.Abitare_Emergenza_Progetti_FattureNewRecord(DataSet: TDataSet);
var
  fatture, Intervento: TzFbDataSet;
begin
  Intervento := GetDataSet('Abitare_Emergenza_Progetti_Elenco');
  fatture := TzFbDataSet(DataSet);
  fatture.FieldByName('ID_INTERVENTO_OBJ').Value := Intervento.FieldByName('ID_PROGETTO').Value;
  fatture.FieldByName('TIPOLOGIA_INTERVENTO').Value := Intervento.FieldByName('TIPOLOGIA_INTERVENTO').Value;

  // fatture.FieldByName('ID_STRUTTURA_RICETTIVA').Value := Intervento.FieldByName('ID_STRUTTURA_RICETTIVA').Value;
  // readonly
  // fatture.SetFieldValue('DESC_STRUTTURA_RICETTIVA', Intervento.FieldByName('DESC_STRUTTURA_RICETTIVA').Value);
end;

procedure TAbitareEmergenza.Abitare_Emergenza_Progetti_FattureAfterDelete(DataSet: TDataSet);
begin
  RefreshRecord('Abitare_Emergenza_Progetti_Coperture', false);
end;

procedure TAbitareEmergenza.Abitare_Emergenza_Progetti_FattureAfterPost(DataSet: TDataSet);
begin
  RefreshRecord('Abitare_Emergenza_Progetti_Coperture', false);
end;

procedure TAbitareEmergenza.Abitare_Emergenza_Progetti_CopertureNewRecord(DataSet: TDataSet);
var
  Intervento, Coperture: TzFbDataSet;

  function totaleCostiAlloggio: currency;
  begin
    result := Intervento.FieldByName('TOTALE_COSTI_ALLOGGIO_EFFETTIVO').Value;

    if result = 0 then
      result := Intervento.FieldByName('TOTALE_COSTI_ALLOGGIO_PREVISTO').Value;
  end;

begin
  Intervento := GetDataSet('Abitare_Emergenza_Progetti_Elenco');
  Coperture := GetDataSet('Abitare_Emergenza_Progetti_Coperture');

  Coperture.FieldByName('ID_INTERVENTO_OBJ').Value := Intervento.FieldByName('ID_PROGETTO').Value;
  Coperture.FieldByName('TIPOLOGIA_INTERVENTO').Value := Intervento.FieldByName('TIPOLOGIA_INTERVENTO').Value;

  // Note Manuela 05.03.2025: i progetti vengono coperti generalmente da due fondi.
  // Uno per l'alloggio, un altro per l'educativa.
  if Intervento.FieldByName('IMPORTO_COPERTURA').Value = 0 then // primo fondo per l'alloggio
    Coperture.FieldByName('IMPORTO_COPERTURA').Value := totaleCostiAlloggio
  else // i successivi per l'educativa+altro
    Coperture.FieldByName('IMPORTO_COPERTURA').Value := Intervento.FieldByName('RESIDUO_DA_COPRIRE').Value;
end;

procedure TAbitareEmergenza.Abitare_Emergenza_Progetti_CopertureAfterDelete(DataSet: TDataSet);
begin
  RefreshRecord('Abitare_Emergenza_Progetti_Elenco', false);
end;

procedure TAbitareEmergenza.Abitare_Emergenza_Progetti_CopertureAfterPost(DataSet: TDataSet);
begin
  RefreshRecord('Abitare_Emergenza_Progetti_Elenco', false);
end;

procedure TAbitareEmergenza.Abitare_Emergenza_Pronto_Intervento_ElencoAfterPost(DataSet: TDataSet);
begin
  ReopenDataSet('Abitare_Emergenza_Pronto_Intervento_Coperture');
end;

procedure TAbitareEmergenza.Abitare_Emergenza_Progetti_ElencoAfterPost(DataSet: TDataSet);
begin
  ReopenDataSet('Abitare_Emergenza_Progetti_Coperture');
end;

procedure TAbitareEmergenza.ProgettoCoperture;
var
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet('Abitare_Emergenza_Progetti_Coperture');

  dlgCoperture.DataSet := DataSet;
  try
    dlgCoperture.Execute();
  finally
    dlgCoperture.DataSet := nil;
  end;

  RefreshRecord('Abitare_Emergenza_Progetti_Elenco', false);
end;

function TAbitareEmergenza.DuplicaProntoIntervento: Boolean;
var
  DataSet: TzFbDataSet;
  Fields2Exclude: String;
begin
  result := false;
  DataSet := GetDataSet('Abitare_Emergenza_Pronto_Intervento_Elenco');

  Fields2Exclude := 'ID_PRONTO_INTERVENTO,NUMERO_PROGRESSIVO,INFORMAZIONI,DATA_INIZIO_PROGETTO,DATA_FINE_PROGETTO_PREVISTA,DATA_FINE_PROGETTO_EFFETTIVA,DATA_FINE_COPERTURA_ECONOMICA,CIG,NUMERO_ORDINE';

  // Gli importi forzati e il blocco appartengono all'intervento di partenza: la
  // copia ha date sue e deve ricalcolare. Copiandoli, il nuovo intervento nasceva
  // con la previsione e il totale dell'originale, senza nessuna domanda al
  // salvataggio perche' su un record nuovo BeforePost non ha nulla da confrontare.
  Fields2Exclude := Fields2Exclude + ',PREVISIONE_DI_SPESA_FORZATA,TOTALE_SPESA_EFFETTIVA_FORZATA,DATA_BLOCCO_IMPORTI,USR_BLOCCO_IMPORTI';

  DataSet.DuplicateRecord(false, Fields2Exclude);

  result := True;
end;

function TAbitareEmergenza.DuplicaProgetto: Boolean;
var
  DataSet: TzFbDataSet;
  Fields2Exclude: String;
begin
  result := false;
  DataSet := GetDataSet('Abitare_Emergenza_Progetti_Elenco');

  Fields2Exclude := 'ID_PROGETTO,ID_INTERVENTO,NUMERO_PROGRESSIVO,INFORMAZIONI,DATA_INIZIO_PROGETTO,DATA_FINE_PROGETTO_PREVISTA,DATA_FINE_PROGETTO_EFFETTIVA,DATA_FINE_COPERTURA_ECONOMICA,CIG,NUMERO_ORDINE';

  // Come per il pronto intervento: i totali forzati e il blocco non si ereditano
  Fields2Exclude := Fields2Exclude + ',TOTALE_COSTI_INTERVENTO_PREVISTI_FORZATO,TOTALE_COSTI_INTERVENTO_EFFETTIVI_FORZATO,DATA_BLOCCO_IMPORTI,USR_BLOCCO_IMPORTI';

  DataSet.DuplicateRecord(false, Fields2Exclude);

  result := True;
end;

procedure TAbitareEmergenza.ProntoInterventoImpostaFiltroFatturato(const Data: TDateTime);
var
  sp: TSP_TMP_ABITARE_EMERGENZA_PRONTO_INTERVENTO_SET_DATA_LIMITE_FATT;
begin
  StartWait('Attendere...', True);
  try
    sp := getsp<TSP_TMP_ABITARE_EMERGENZA_PRONTO_INTERVENTO_SET_DATA_LIMITE_FATT>;
    try
      sp.DATA_LIMITE_FATTURATO := Data;
      sp.ExecuteAndCommit;

      RefreshDataSet('Abitare_Emergenza_Pronto_Intervento_Elenco');
    finally
      FreeAndNil(sp);
    end;
  finally
    StopWait;
  end;
end;

procedure TAbitareEmergenza.ProgettiImpostaFiltroFatturato(const Data: TDateTime);
var
  sp: TSP_TMP_ABITARE_EMERGENZA_PROGETTI_SET_DATA_LIMITE_FATTURATO;
begin
  StartWait('Attendere...', True);
  try
    sp := getsp<TSP_TMP_ABITARE_EMERGENZA_PROGETTI_SET_DATA_LIMITE_FATTURATO>;
    try
      sp.DATA_LIMITE_FATTURATO := Data;
      sp.ExecuteAndCommit;

      RefreshDataSet('Abitare_Emergenza_Progetti_Elenco');
    finally
      FreeAndNil(sp);
    end;
  finally
    StopWait;
  end;
end;

// ============================================================================
// Importi scritti a mano: la domanda quando cambiano le fonti
//
// Un importo e' scritto a mano quando la sua colonna di forzatura e'
// valorizzata: nessuna deduzione. Se in questa modifica l'operatore ha toccato
// uno dei campi da cui l'importo dipende, si ricalcola con CalcoloAbitare.Lib e,
// se il conto non torna piu', si chiede cosa fare prima che il record parta.
// ============================================================================

function CampoModificato(Campo: TField): Boolean;
var
  Precedente: Variant;
begin
  // OldValue e' un Variant e resta vuoto sui record nuovi, dove non c'e' un
  // passato da leggere.
  Precedente := Campo.OldValue;

  if VarIsNull(Precedente) or VarIsEmpty(Precedente) then
    Result := not Campo.IsNull
  else
    if Campo.IsNull then
      Result := true
    else
      Result := not VarSameValue(Precedente, Campo.Value);
end;

procedure TAbitareEmergenza.VerificaImportoForzato(DataSet: TDataSet; const CampoForzato, Descrizione: string;
  const ValoreCalcolato: Currency; const Fonti: array of string);
var
  Forzato: TField;
  Fonte: string;
  FontiToccate: Boolean;
begin
  Forzato := DataSet.FindField(CampoForzato);

  // La colonna di forzatura non c'e' ancora, oppure l'importo non e' stato
  // scritto a mano: non c'e' nessuna decisione da difendere.
  if not Assigned(Forzato) then
    Exit;

  if Forzato.IsNull then
    Exit;

  FontiToccate := false;

  for Fonte in Fonti do
    if CampoModificato(DataSet.FieldByName(Fonte)) then
    begin
      FontiToccate := true;
      Break;
    end;

  // Nessuna delle fonti e' stata toccata in questa modifica: se l'importo e'
  // disallineato lo era gia' prima, ed e' il segnale permanente della scheda a
  // dirlo. Chiedere qui vorrebbe dire ripetere la domanda a ogni salvataggio.
  if not FontiToccate then
    Exit;

  if Abs(Forzato.AsCurrency - ValoreCalcolato) <= 0.005 then
    Exit;

  if ConfirmYesNo(Format('%s era stato impostato a mano: %m.' + sLineBreak +
                         'Con i dati appena modificati il calcolo da'' %m.' + sLineBreak + sLineBreak +
                         'Si desidera aggiornare l''importo?', [Descrizione, Forzato.AsCurrency, ValoreCalcolato])) then
    Forzato.Clear;
end;

function TAbitareEmergenza.ValoriProntoIntervento(DataSet: TDataSet; const Previsto: Boolean): TValoriProntoIntervento;
begin
  Result := Default (TValoriProntoIntervento);

  Result.DataInizio := DataSet.FieldByName('DATA_INIZIO_PROGETTO').AsDateTime;

  if Previsto then
  begin
    Result.DataFine := DataSet.FieldByName('DATA_FINE_PROGETTO_PREVISTA').AsDateTime;
    Result.ImportoGiornaliero := DataSet.FieldByName('IMPORTO_GIORNALIERO_PREVISTO').AsCurrency;
    Result.SpesePuliziaMensili := DataSet.FieldByName('SPESE_PULIZIA_MENSILI_PREVISTE').AsCurrency;
    Result.AltreSpesePulizia := DataSet.FieldByName('ALTRE_SPESE_PULIZIA_PREVISTE').AsCurrency;
    Result.TassaSoggiorno := DataSet.FieldByName('TASSA_SOGGIORNO_PREVISTA').AsCurrency;
    Result.AltriImporti := DataSet.FieldByName('ALTRI_IMPORTI_PREVISTI').AsCurrency;
  end
  else
  begin
    Result.DataFine := DataSet.FieldByName('DATA_FINE_PROGETTO_EFFETTIVA').AsDateTime;
    Result.ImportoGiornaliero := DataSet.FieldByName('IMPORTO_GIORNALIERO_EFFETTIVO').AsCurrency;
    Result.SpesePuliziaMensili := DataSet.FieldByName('SPESE_PULIZIA_MENSILI_EFFETTIVE').AsCurrency;
    Result.AltreSpesePulizia := DataSet.FieldByName('ALTRE_SPESE_PULIZIA_EFFETTIVE').AsCurrency;
    Result.TassaSoggiorno := DataSet.FieldByName('TASSA_SOGGIORNO_EFFETTIVA').AsCurrency;
    Result.AltriImporti := DataSet.FieldByName('ALTRI_IMPORTI_EFFETTIVI').AsCurrency;
  end;
end;

function TAbitareEmergenza.ValoriProgetto(DataSet: TDataSet; const Previsto: Boolean): TValoriProgetto;

  function Valore(const NomePrevisto, NomeEffettivo: string): TField;
  begin
    if Previsto then
      Result := DataSet.FieldByName(NomePrevisto)
    else
      Result := DataSet.FieldByName(NomeEffettivo);
  end;

begin
  Result := Default (TValoriProgetto);

  Result.DataInizio := DataSet.FieldByName('DATA_INIZIO_PROGETTO').AsDateTime;

  if Previsto then
    Result.DataFine := DataSet.FieldByName('DATA_FINE_PROGETTO_PREVISTA').AsDateTime
  else
    Result.DataFine := DataSet.FieldByName('DATA_FINE_PROGETTO_EFFETTIVA').AsDateTime;

  Result.ImportoMensileAlloggio := Valore('IMPORTO_MENSILE_ALLOGGIO_PREVISTO', 'IMPORTO_MENSILE_ALLOGGIO_EFFETTIVO').AsCurrency;
  Result.AltriImportiAlloggio := Valore('ALTRI_IMPORTI_ALLOGGIO_PREVISTI', 'ALTRI_IMPORTI_ALLOGGIO_EFFETTIVI').AsCurrency;
  Result.OreEducativeMensili := Valore('ORE_EDUCATIVE_MENSILI_DA_PROGETTO_PREVISTE', 'ORE_EDUCATIVE_MENSILI_DA_PROGETTO_EFFETTIVE').AsFloat;
  Result.CostoOrarioOreEducative := Valore('COSTO_ORARIO_ORE_EDUCATIVE_PREVISTE', 'COSTO_ORARIO_ORE_EDUCATIVE_EFFETTIVE').AsCurrency;
  Result.PacchettoOreMediazione := Valore('PACCHETTO_ORE_MEDIAZIONE_PREVISTO', 'PACCHETTO_ORE_MEDIAZIONE_EFFETTIVO').AsFloat;
  Result.CostoOrarioMediazione := Valore('COSTO_ORARIO_MEDIAZIONE_PREVISTO', 'COSTO_ORARIO_MEDIAZIONE_EFFETTIVO').AsCurrency;
  Result.PacchettoOreEducatoreFinanziario := Valore('PACCHETTO_ORE_EDUCATORE_FINANZIARIO_PREVISTO',
    'PACCHETTO_ORE_EDUCATORE_FINANZIARIO_EFFETTIVO').AsFloat;
  Result.CostoOrarioEducatoreFinanziario := Valore('COSTO_ORARIO_EDUCATORE_FINANZIARIO_PREVISTO',
    'COSTO_ORARIO_EDUCATORE_FINANZIARIO_EFFETTIVO').AsCurrency;
  Result.CostiVari := Valore('COSTI_VARI_PREVISTI', 'COSTI_VARI_EFFETTIVI').AsCurrency;
end;

procedure TAbitareEmergenza.Abitare_Emergenza_Pronto_Intervento_ElencoBeforePost(DataSet: TDataSet);
begin
  // Su un intervento nuovo non c'e' nessun valore precedente da difendere
  if DataSet.State <> dsEdit then
    Exit;

  // Gli importi bloccati sono forzati di proposito: non si discutono
  if not DataSet.FieldByName('DATA_BLOCCO_IMPORTI').IsNull then
    Exit;

  VerificaImportoForzato(DataSet, 'PREVISIONE_DI_SPESA_FORZATA', 'La previsione di spesa',
    TCalcoloAbitare.PrevisioneDiSpesa(ValoriProntoIntervento(DataSet, true)),
    ['DATA_INIZIO_PROGETTO', 'DATA_FINE_PROGETTO_PREVISTA', 'IMPORTO_GIORNALIERO_PREVISTO', 'SPESE_PULIZIA_MENSILI_PREVISTE',
     'ALTRE_SPESE_PULIZIA_PREVISTE', 'TASSA_SOGGIORNO_PREVISTA', 'ALTRI_IMPORTI_PREVISTI']);

  VerificaImportoForzato(DataSet, 'TOTALE_SPESA_EFFETTIVA_FORZATA', 'Il totale della spesa effettiva',
    TCalcoloAbitare.TotaleSpesaEffettiva(ValoriProntoIntervento(DataSet, false)),
    ['DATA_INIZIO_PROGETTO', 'DATA_FINE_PROGETTO_EFFETTIVA', 'IMPORTO_GIORNALIERO_EFFETTIVO', 'SPESE_PULIZIA_MENSILI_EFFETTIVE',
     'ALTRE_SPESE_PULIZIA_EFFETTIVE', 'TASSA_SOGGIORNO_EFFETTIVA', 'ALTRI_IMPORTI_EFFETTIVI']);
end;

procedure TAbitareEmergenza.Abitare_Emergenza_Progetti_ElencoBeforePost(DataSet: TDataSet);
begin
  if DataSet.State <> dsEdit then
    Exit;

  if not DataSet.FieldByName('DATA_BLOCCO_IMPORTI').IsNull then
    Exit;

  VerificaImportoForzato(DataSet, 'TOTALE_COSTI_INTERVENTO_PREVISTI_FORZATO', 'Il totale dei costi previsti',
    TCalcoloAbitare.TotaleCostiIntervento(ValoriProgetto(DataSet, true)),
    ['DATA_INIZIO_PROGETTO', 'DATA_FINE_PROGETTO_PREVISTA', 'IMPORTO_MENSILE_ALLOGGIO_PREVISTO', 'ALTRI_IMPORTI_ALLOGGIO_PREVISTI',
     'ORE_EDUCATIVE_MENSILI_DA_PROGETTO_PREVISTE', 'COSTO_ORARIO_ORE_EDUCATIVE_PREVISTE', 'PACCHETTO_ORE_MEDIAZIONE_PREVISTO',
     'COSTO_ORARIO_MEDIAZIONE_PREVISTO', 'PACCHETTO_ORE_EDUCATORE_FINANZIARIO_PREVISTO', 'COSTO_ORARIO_EDUCATORE_FINANZIARIO_PREVISTO',
     'COSTI_VARI_PREVISTI']);

  VerificaImportoForzato(DataSet, 'TOTALE_COSTI_INTERVENTO_EFFETTIVI_FORZATO', 'Il totale dei costi effettivi',
    TCalcoloAbitare.TotaleCostiIntervento(ValoriProgetto(DataSet, false)),
    ['DATA_INIZIO_PROGETTO', 'DATA_FINE_PROGETTO_EFFETTIVA', 'IMPORTO_MENSILE_ALLOGGIO_EFFETTIVO', 'ALTRI_IMPORTI_ALLOGGIO_EFFETTIVI',
     'ORE_EDUCATIVE_MENSILI_DA_PROGETTO_EFFETTIVE', 'COSTO_ORARIO_ORE_EDUCATIVE_EFFETTIVE', 'PACCHETTO_ORE_MEDIAZIONE_EFFETTIVO',
     'COSTO_ORARIO_MEDIAZIONE_EFFETTIVO', 'PACCHETTO_ORE_EDUCATORE_FINANZIARIO_EFFETTIVO', 'COSTO_ORARIO_EDUCATORE_FINANZIARIO_EFFETTIVO',
     'COSTI_VARI_EFFETTIVI']);
end;

// ============================================================================
// Blocco e sblocco degli importi
//
// Bloccare significa copiare i valori calcolati di questo momento nelle colonne
// di forzatura: da li' in avanti il database restituisce quelli e non ricalcola
// piu' niente per quella pratica. Sbloccare svuota le colonne.
// Il travaso lo fa il database, non il client, cosi' vale anche se un domani il
// comando arriva da altro.
// ============================================================================

procedure TAbitareEmergenza.ImpostaBloccoImporti(const DataSetName, CampoChiave: string; const Blocca: Boolean);
var
  DataSet: TzFbDataSet;
  spBlocca: TSP_ABITARE_EMERGENZA_BLOCCA_IMPORTI;
  spSblocca: TSP_ABITARE_EMERGENZA_SBLOCCA_IMPORTI;
begin
  DataSet := GetDataSet(DataSetName);

  if DataSet.IsEmpty then
    Exit;

  if Blocca then
  begin
    if not ConfirmYesNo('Gli importi di questo intervento verranno congelati ai valori attuali.' + sLineBreak +
                        'Da quel momento non verranno piu'' aggiornati, qualunque cosa cambi nelle date o negli importi unitari.' +
                        sLineBreak + sLineBreak + 'Si desidera bloccare gli importi?') then
      Exit;
  end
  else
    if not ConfirmYesNo('Gli importi torneranno a essere calcolati dai dati della scheda,' + sLineBreak +
                        'e i valori congelati andranno persi.' + sLineBreak + sLineBreak + 'Si desidera sbloccare gli importi?') then
      Exit;

  StartWait('Attendere...', True);
  try
    if Blocca then
    begin
      spBlocca := getsp<TSP_ABITARE_EMERGENZA_BLOCCA_IMPORTI>;
      try
        spBlocca.ID_INTERVENTO_OBJ := DataSet.FieldByName(CampoChiave).AsInteger;
        spBlocca.TIPOLOGIA_INTERVENTO := DataSet.FieldByName('TIPOLOGIA_INTERVENTO').AsString;
        spBlocca.ExecuteAndCommit;
      finally
        FreeAndNil(spBlocca);
      end;
    end
    else
    begin
      spSblocca := getsp<TSP_ABITARE_EMERGENZA_SBLOCCA_IMPORTI>;
      try
        spSblocca.ID_INTERVENTO_OBJ := DataSet.FieldByName(CampoChiave).AsInteger;
        spSblocca.TIPOLOGIA_INTERVENTO := DataSet.FieldByName('TIPOLOGIA_INTERVENTO').AsString;
        spSblocca.ExecuteAndCommit;
      finally
        FreeAndNil(spSblocca);
      end;
    end;

    RefreshRecord(DataSetName, false);
  finally
    StopWait;
  end;
end;

procedure TAbitareEmergenza.BloccaImportiProntoIntervento;
begin
  ImpostaBloccoImporti('Abitare_Emergenza_Pronto_Intervento_Elenco', 'ID_PRONTO_INTERVENTO', true);
end;

procedure TAbitareEmergenza.SbloccaImportiProntoIntervento;
begin
  ImpostaBloccoImporti('Abitare_Emergenza_Pronto_Intervento_Elenco', 'ID_PRONTO_INTERVENTO', false);
end;

procedure TAbitareEmergenza.BloccaImportiProgetto;
begin
  ImpostaBloccoImporti('Abitare_Emergenza_Progetti_Elenco', 'ID_PROGETTO', true);
end;

procedure TAbitareEmergenza.SbloccaImportiProgetto;
begin
  ImpostaBloccoImporti('Abitare_Emergenza_Progetti_Elenco', 'ID_PROGETTO', false);
end;

end.

