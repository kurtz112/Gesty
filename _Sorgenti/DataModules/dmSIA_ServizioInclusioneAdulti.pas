unit dmSIA_ServizioInclusioneAdulti;

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
  Base_DataModule,
  dbMaster,
  zFbDataSet,
  zDbViewDlg,
  zDbCardDlg;

type
  TSIA_ServizioInclusioneAdulti = class(TBaseDataModule)
    dlgCoperture: TzDbViewDlg;
    dlgRettificaAnagrafica: TzDbCardDlg;
  private
    // Cache dei campi dell'intervento usati dal calcolo di date e ore
    interventoDATA_INIZIO_INTERVENTO: TField;
    interventoDATA_FINE_INTERVENTO: TField;
    interventoTIPO_PERIODO: TField;
    interventoPIANO_UTILIZZO_ORE_MENSILI: TField;
    interventoPIANO_UTILIZZO_ORE_SETTIMANA: TField;
    interventoNUMERO_MESI: TField;
    interventoNUMERO_SETTIMANE: TField;
    interventoNUMERO_ORE_TOTALI: TField;
    procedure Sia_InterventiDateChanged(Sender: TField);
  private
    procedure Sia_InterventiAfterCreateFields(DataSet: TDataSet);
    procedure Sia_InterventiBeforePost(DataSet: TDataSet);
    procedure Sia_InterventiAfterPost(DataSet: TDataSet);
  private
    procedure Sia_CopertureNewRecord(DataSet: TDataSet);
    procedure Sia_CopertureAfterPost(DataSet: TDataSet);
    procedure Sia_CopertureAfterDelete(DataSet: TDataSet);
  private
    // Fatture (gia' "Rendicontazioni", allineate a SIA_FATTURE)
    procedure Sia_Interventi_FattureNewRecord(DataSet: TDataSet);
    procedure Sia_Interventi_FattureAfterPost(DataSet: TDataSet);
    procedure Sia_Interventi_FattureAfterDelete(DataSet: TDataSet);
  private
    // Destinatari delle fatture (gia' "Rendicontazioni_Destinatari", allineati a SIA_FATTURE_DESTINATARI)
    procedure Sia_Fatture_DestinatariNewRecord(DataSet: TDataSet);
    procedure Sia_Fatture_DestinatariAfterPost(DataSet: TDataSet);
    procedure Sia_Fatture_DestinatariAfterDelete(DataSet: TDataSet);
  private
    procedure Sia_Interventi_Destinatari_EffettiviNewRecord(DataSet: TDataSet);
  private
    procedure InternalAggiornaIntervento;
  protected
    procedure AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    procedure AggiungiDestinatarioEffettivo;
    procedure InterventiCoperture;
    procedure RettificaAnagrafica;
  end;

var
  SIA_ServizioInclusioneAdulti: TSIA_ServizioInclusioneAdulti;

implementation

uses
  System.DateUtils,
  zBaseLib,
  Gesty_StoredProcs,
  zFrmParams,
  zMsg;

{$R *.dfm}

const
  // 365,25 / 12: durata media di un mese nel calendario gregoriano, la stessa
  // costante su cui si basa MonthsBetween di System.DateUtils.
  GiorniPerMeseMedio = 30.4375;

// ============================================================================
// AfterCreateDataSet - registrazione dei gestori per ogni dataset
// ============================================================================

procedure TSIA_ServizioInclusioneAdulti.AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'Sia_Interventi') then
  begin
    DataSet.OnAfterCreateFields := Sia_InterventiAfterCreateFields;
    DataSet.BeforePost := Sia_InterventiBeforePost;
    DataSet.AfterPost := Sia_InterventiAfterPost;
  end
  else
    if SameText(DataSetName, 'Sia_Coperture') then
    begin
      DataSet.OnNewRecord := Sia_CopertureNewRecord;
      DataSet.AfterPost := Sia_CopertureAfterPost;
      DataSet.AfterDelete := Sia_CopertureAfterDelete;
    end
    else
      if SameText(DataSetName, 'Sia_Interventi_Fatture') then
      begin
        DataSet.OnNewRecord := Sia_Interventi_FattureNewRecord;
        DataSet.AfterPost := Sia_Interventi_FattureAfterPost;
        DataSet.AfterDelete := Sia_Interventi_FattureAfterDelete;
      end
      else
        if SameText(DataSetName, 'Sia_Fatture_Destinatari') then
        begin
          DataSet.OnNewRecord := Sia_Fatture_DestinatariNewRecord;
          DataSet.AfterPost := Sia_Fatture_DestinatariAfterPost;
          DataSet.AfterDelete := Sia_Fatture_DestinatariAfterDelete;
        end
        else
          if SameText(DataSetName, 'Sia_Interventi_Destinatari_Effettivi') then
          begin
            DataSet.OnNewRecord := Sia_Interventi_Destinatari_EffettiviNewRecord;
          end;
end;

// ============================================================================
// Sia_Interventi - AfterCreateFields + calcolo di date e ore + AfterPost
// ============================================================================

procedure TSIA_ServizioInclusioneAdulti.Sia_InterventiAfterCreateFields(DataSet: TDataSet);
begin
  // Riferimenti ai TField tenuti in cache
  interventoDATA_INIZIO_INTERVENTO := DataSet.FieldByName('DATA_INIZIO_INTERVENTO');
  interventoDATA_FINE_INTERVENTO := DataSet.FieldByName('DATA_FINE_INTERVENTO');

  interventoTIPO_PERIODO := DataSet.FieldByName('TIPO_PERIODO');
  interventoPIANO_UTILIZZO_ORE_MENSILI := DataSet.FieldByName('PIANO_UTILIZZO_ORE_MENSILI');
  interventoPIANO_UTILIZZO_ORE_SETTIMANA := DataSet.FieldByName('PIANO_UTILIZZO_ORE_SETTIMANA');
  interventoNUMERO_MESI := DataSet.FieldByName('NUMERO_MESI');
  interventoNUMERO_SETTIMANE := DataSet.FieldByName('NUMERO_SETTIMANE');
  interventoNUMERO_ORE_TOTALI := DataSet.FieldByName('NUMERO_ORE_TOTALI');

  // Aggancio di OnChange per il ricalcolo automatico
  interventoDATA_INIZIO_INTERVENTO.OnChange := Sia_InterventiDateChanged;
  interventoDATA_FINE_INTERVENTO.OnChange := Sia_InterventiDateChanged;
  interventoTIPO_PERIODO.OnChange := Sia_InterventiDateChanged;
  interventoPIANO_UTILIZZO_ORE_SETTIMANA.OnChange := Sia_InterventiDateChanged;
  interventoPIANO_UTILIZZO_ORE_MENSILI.OnChange := Sia_InterventiDateChanged;
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_InterventiDateChanged(Sender: TField);

  // Arrotondamento al valore piu' vicino, con la mezza unita' verso l'alto.
  // Round di Delphi segue lo standard IEEE 754 e a meta' strada arrotonda al pari
  // (Round(2.5) restituisce 2): su un conteggio di settimane darebbe risultati
  // che nessuno saprebbe spiegare all'utente.
  function ArrotondaAlPiuVicino(const Valore: Double): Integer;
  begin
    Result := Trunc(Valore + 0.5);
  end;

var
  Giorni: Integer;
  Settimane: Integer;
  Mesi: Integer;
  OrePianoSettimana: Integer;
  OrePianoMese: Integer;
  DataInizio: TDateTime;
  DataFine: TDateTime;
begin
  Settimane := 0;
  Mesi := 0;

  // Date presenti e coerenti. La data unica e' ammessa: un intervento di un solo
  // giorno esiste, e prima veniva valorizzato con zero settimane e zero ore.
  if (not interventoDATA_INIZIO_INTERVENTO.IsNull) and (not interventoDATA_FINE_INTERVENTO.IsNull) and (interventoDATA_FINE_INTERVENTO.AsDateTime >= interventoDATA_INIZIO_INTERVENTO.AsDateTime) then
  begin
    DataInizio := DateOf(interventoDATA_INIZIO_INTERVENTO.AsDateTime);
    DataFine := DateOf(interventoDATA_FINE_INTERVENTO.AsDateTime);

    // Durata in giorni con gli estremi inclusi: dal 1 gennaio al 30 giugno
    // l'intervento copre 181 giorni, non 180. WeeksBetween e MonthsBetween
    // misuravano invece la distanza fra le due date e troncavano il resto,
    // quindi un semestre valeva 25 settimane e 5 mesi e un anno intero 11 mesi:
    // le ore mancanti finivano nell'importo nominale del voucher.
    Giorni := DaysBetween(DataInizio, IncDay(DataFine));

    Settimane := ArrotondaAlPiuVicino(Giorni / 7);
    Mesi := ArrotondaAlPiuVicino(Giorni / GiorniPerMeseMedio);

    // Un periodo piu' corto della propria unita' di misura vale comunque una
    // unita': l'alternativa e' un monte ore a zero su un intervento reale.
    if Settimane = 0 then
      Settimane := 1;

    if Mesi = 0 then
      Mesi := 1;
  end;

  OrePianoSettimana := interventoPIANO_UTILIZZO_ORE_SETTIMANA.AsInteger;
  OrePianoMese := interventoPIANO_UTILIZZO_ORE_MENSILI.AsInteger;

  // Scrittura dei periodi calcolati
  interventoNUMERO_MESI.Value := Mesi;
  interventoNUMERO_SETTIMANE.Value := Settimane;

  // Monte ore totale secondo il tipo di periodo scelto (settimanale o mensile)
  if interventoTIPO_PERIODO.AsString = 'M' then
    interventoNUMERO_ORE_TOTALI.Value := Mesi * OrePianoMese
  else
    interventoNUMERO_ORE_TOTALI.Value := Settimane * OrePianoSettimana;
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_InterventiBeforePost(DataSet: TDataSet);

  // Il valore che il campo aveva prima della modifica in corso. OldValue e' un
  // Variant e resta vuoto sui record nuovi, dove non c'e' un passato da leggere.
  function ValorePrecedente(Campo: TField): Integer;
  var
    Valore: Variant;
  begin
    Result := 0;
    Valore := Campo.OldValue;

    if not VarIsNull(Valore) then
      Result := Valore;
  end;

var
  OreOriginali: Integer;
  PeriodiOriginali: Integer;
  PianoOriginale: Integer;
begin
  // Su un intervento nuovo non c'e' nessuna decisione precedente da difendere
  if DataSet.State <> dsEdit then
    Exit;

  OreOriginali := ValorePrecedente(interventoNUMERO_ORE_TOTALI);

  // Il monte ore non e' stato toccato: niente da chiedere
  if OreOriginali = interventoNUMERO_ORE_TOTALI.AsInteger then
    Exit;

  if VarToStr(interventoTIPO_PERIODO.OldValue) = 'M' then
  begin
    PeriodiOriginali := ValorePrecedente(interventoNUMERO_MESI);
    PianoOriginale := ValorePrecedente(interventoPIANO_UTILIZZO_ORE_MENSILI);
  end
  else
  begin
    PeriodiOriginali := ValorePrecedente(interventoNUMERO_SETTIMANE);
    PianoOriginale := ValorePrecedente(interventoPIANO_UTILIZZO_ORE_SETTIMANA);
  end;

  // Il monte ore precedente era il prodotto del periodo per il piano orario:
  // lo aveva scritto il programma, quindi si aggiorna senza disturbare nessuno.
  if OreOriginali = PeriodiOriginali * PianoOriginale then
    Exit;

  // Qui invece il valore precedente non corrisponde a nessun calcolo: lo ha
  // deciso una persona, spesso perche' il piano orario non e' compilato e le ore
  // sono state concordate con la cooperativa. Sostituirlo in silenzio farebbe
  // sparire quella decisione, e con essa cambierebbero il valore del voucher e
  // l'equilibrio delle coperture gia' inserite.
  if not ConfirmYesNo(Format('Il monte ore di questo intervento era stato impostato a mano: %d ore.' + sLineBreak +
                             'Il periodo appena indicato ne prevede %d.' + sLineBreak + sLineBreak +
                             'Si desidera sostituire il monte ore?', [OreOriginali, interventoNUMERO_ORE_TOTALI.AsInteger])) then
    interventoNUMERO_ORE_TOTALI.Value := OreOriginali;
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_InterventiAfterPost(DataSet: TDataSet);
begin
  ReopenDataSet('Sia_Coperture');
end;

// ============================================================================
// Sia_Coperture
// ============================================================================

procedure TSIA_ServizioInclusioneAdulti.Sia_CopertureNewRecord(DataSet: TDataSet);
var
  Intervento, Coperture: TzFbDataSet;
  ResiduoDaCoprire: Currency;
begin
  Intervento := GetDataSet('Sia_Interventi');
  Coperture := GetDataSet('Sia_Coperture');

  Coperture.FieldByName('ID_INTERVENTO_SIA').Value := Intervento.FieldByName('ID_INTERVENTO_SIA').Value;

  // Mantis #57 - 2026-09-13: propone l'importo copertura con il residuo del voucher.
  // Sulla prima copertura il residuo coincide con l'intero importo nominale, dalla seconda
  // in poi resta quanto manca: e' il comportamento di Abitare Emergenza citato nella
  // segnalazione. Il campo resta modificabile, la proposta non blocca nulla.
  //
  // Il residuo diventa negativo quando le coperture gia' inserite superano il voucher, ma
  // SIA_COPERTURE.IMPORTO_COPERTURA e' di dominio VALUTA_2_POSITIVA: scriverlo negativo
  // farebbe fallire il salvataggio a scheda gia' compilata.
  ResiduoDaCoprire := Intervento.FieldByName('RESIDUO_DA_COPRIRE').AsCurrency;

  if ResiduoDaCoprire < 0 then
    ResiduoDaCoprire := 0;

  Coperture.FieldByName('IMPORTO_COPERTURA').Value := ResiduoDaCoprire;
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_CopertureAfterPost(DataSet: TDataSet);
begin
  RefreshRecord('Sia_Interventi', false);
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_CopertureAfterDelete(DataSet: TDataSet);
begin
  RefreshRecord('Sia_Interventi', false);
end;

// ============================================================================
// Sia_Interventi_Fatture (gia' Sia_Interventi_Rendicontazioni)
// Stesso schema di AbitareEmergenza: dalle fatture si aggiornano intervento e coperture
// ============================================================================

procedure TSIA_ServizioInclusioneAdulti.Sia_Interventi_FattureNewRecord(DataSet: TDataSet);
var
  Fatture, Intervento: TzFbDataSet;
begin
  Intervento := GetDataSet('Sia_Interventi');
  Fatture := TzFbDataSet(DataSet);

  Fatture.FieldByName('ID_INTERVENTO_SIA').Value := Intervento.FieldByName('ID_INTERVENTO_SIA').Value;
  Fatture.FieldByName('ID_COOPERATIVA_SIA').Value := Intervento.FieldByName('ID_COOPERATIVA_SIA').Value;
  Fatture.FieldByName('DATA_FATTURA').Value := Date;
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_Interventi_FattureAfterPost(DataSet: TDataSet);
begin
  InternalAggiornaIntervento;
  RefreshRecord('Sia_Coperture', false);
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_Interventi_FattureAfterDelete(DataSet: TDataSet);
begin
  InternalAggiornaIntervento;
  RefreshRecord('Sia_Coperture', false);
end;

// ============================================================================
// Sia_Fatture_Destinatari (gia' Sia_Rendicontazioni_Destinatari)
// ============================================================================

procedure TSIA_ServizioInclusioneAdulti.Sia_Fatture_DestinatariNewRecord(DataSet: TDataSet);
var
  Fatture: TzFbDataSet;
  Destinatari: TzFbDataSet;
begin
  Fatture := GetDataSet('Sia_Interventi_Fatture');
  Destinatari := TzFbDataSet(DataSet);

  Destinatari.FieldByName('ID_FATTURA_SIA').Value := Fatture.FieldByName('ID_FATTURA_SIA').Value;
  Destinatari.FieldByName('ID_INTERVENTO_SIA').Value := Fatture.FieldByName('ID_INTERVENTO_SIA').Value;
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_Fatture_DestinatariAfterPost(DataSet: TDataSet);
begin
  RefreshRecord('Sia_Interventi_Fatture');
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_Fatture_DestinatariAfterDelete(DataSet: TDataSet);
begin
  RefreshRecord('Sia_Interventi_Fatture');
end;

// ============================================================================
// Metodi pubblici
// ============================================================================

procedure TSIA_ServizioInclusioneAdulti.InternalAggiornaIntervento;
begin
  RefreshRecord('Sia_Interventi');
end;

procedure TSIA_ServizioInclusioneAdulti.AggiungiDestinatarioEffettivo;
var
  Destinatari, Interventi: TzFbDataSet;
  sp: TSP_SIA_INTERVENTI_DESTINATARI_EFFETTIVI_ADD_INTESTATARIO_VOUCHER;
begin
  Interventi := GetDataSet('Sia_Interventi');
  Destinatari := GetDataSet('Sia_Interventi_Destinatari_Effettivi');

  if not ConfirmYesNo('Si desidera inserire l''intestatario voucher dell''intervento come destinatario effettivo?') then
    Exit;

  if Interventi.IsEmpty then
    Exit;

  StartWait('Attendere...', True);
  try
    sp := getSP<TSP_SIA_INTERVENTI_DESTINATARI_EFFETTIVI_ADD_INTESTATARIO_VOUCHER>;
    try
      sp.ID_INTERVENTO_SIA := Interventi.FieldByName('ID_INTERVENTO_SIA').Value;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    Destinatari.ReOpen();
  finally
    StopWait;
  end;

  ConfirmOk('Intestatario voucher aggiunto come destinatario effettivo.');
end;

procedure TSIA_ServizioInclusioneAdulti.InterventiCoperture;
var
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet('Sia_Coperture');

  dlgCoperture.DataSet := DataSet;
  try
    dlgCoperture.Execute();
  finally
    dlgCoperture.DataSet := nil;
  end;

  RefreshRecord('Sia_Interventi', false);
end;

// Rettifica dei dati anagrafici dell'intestatario selezionato.
//
// La griglia degli intestatari legge una vista senza trigger e resta in sola
// lettura: la persona si corregge sulla sua riga di ANAGRAFE, attraverso il
// dataset nascosto Intestatario_Anagrafe (vista ANAGRAFE_ELENCO, con i trigger)
// e la scheda ridotta omonima del dizionario LZ. E' lo stesso dato che si
// modifica da Anagrafiche, che gli utenti SIA non vedono.
procedure TSIA_ServizioInclusioneAdulti.RettificaAnagrafica;
var
  Intestatari: TzFbDataSet;
  Anagrafica: TzFbDataSet;
  IdIntestatario: Variant;
begin
  Intestatari := GetDataSet('Intestatari_Voucher');

  if Intestatari.IsEmpty then
    Exit;

  IdIntestatario := Intestatari.FieldByName('ID_INTESTATARIO_VOUCHER').Value;

  // Chiuso prima di assegnare il parametro: su un dataset gia' aperto il nuovo
  // valore non rileggerebbe niente e la scheda mostrerebbe la persona precedente.
  Anagrafica := GetDataSet('Intestatario_Anagrafe');
  Anagrafica.Active := False;
  Anagrafica.RevertSQL(False);
  Anagrafica.ParamByName('ID_ANAGRAFICA').Value := IdIntestatario;
  Anagrafica.Active := True;
  try
    if Anagrafica.IsEmpty then
      Exit;

    // La scheda salva alla conferma e annulla all'uscita (TzDbCardForm.FormCloseQuery)
    dlgRettificaAnagrafica.DataSet := Anagrafica;
    try
      if not dlgRettificaAnagrafica.Execute then
        Exit;
    finally
      dlgRettificaAnagrafica.DataSet := nil;
    end;
  finally
    Anagrafica.Active := False;
  end;

  // La stessa persona compare su una riga per ogni intervento di cui e'
  // intestataria: RefreshRecord aggiornerebbe solo quella corrente. Si riapre
  // tutto e ci si riposiziona per chiave, non per numero di riga, perche'
  // l'elenco e' ordinato per cognome e nome e la correzione puo' spostare la riga.
  Intestatari.DisableControls;
  try
    Intestatari.ReOpen;
    Intestatari.Locate('ID_INTESTATARIO_VOUCHER', IdIntestatario, []);
  finally
    Intestatari.EnableControls;
  end;
end;

procedure TSIA_ServizioInclusioneAdulti.Sia_Interventi_Destinatari_EffettiviNewRecord(DataSet: TDataSet);
var
  field: TField;
begin
  // non deve copiare i valori del master.
  // essendo troppi da aggiungere all'lz (e variabili nel tempo)
  // meglio un evento diretto
  for field in DataSet.Fields do
    if not SameText(field.FieldName, 'ID_INTERVENTO_SIA') then
      if not SameText(field.FieldName, 'ID_DESTINATARIO_EFFETTIVO') then
        field.Clear;
end;

end.
