unit dmRegistroStudenti;

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
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  QExport4,
  QExport4Types,
  QExport4Dialog,
  QExport4Xlsx,
  zBaseLib,
  Base_DataModule,
  dbMaster,
  zFbDataSet,
  zDbCard,
  zDbCardDlg,
  zDbViewDlg,
  RegistroStudentiCollettiva.Classes,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

type
  TRegistroStudenti = class(TBaseDataModule)
    lkProgetti: TzFbDataSet;
    lkProgettiSrc: TDataSource;
    cardOrario: TzDbCardDlg;
    Orario: TzFbDataSet;
    lkCorsi: TzFbDataSet;
    lkCorsiSrc: TDataSource;
    lkEnti: TzFbDataSet;
    lkEntiSrc: TDataSource;
    lkProgettiCodReg: TzFbDataSet;
    lkProgettiCodRegSrc: TDataSource;
    procedure FiltroEnteBeforeOpen(DataSet: TDataSet);
    procedure QExport4XlsxBeforeExportRow(Sender: TObject; Row: TQExportRow; var Accept: Boolean);
    procedure QExport4XlsxCustomFormat(Sender: TObject; Field: TField; var Value: WideString);
  private type
    TRegistroCollettivoParams = record
      IdProgetto: integer;
      IdCorso: integer;
      DataLezione: TDateTime;
      procedure Init;
      function IsValid: Boolean;
    end;
  private
    FFiltroEnte: integer;
    FRegistroCollettivo: TRegistroCollettivo;
    RegistroCollettivoParams: TRegistroCollettivoParams;
    RegistroIndividualeDisabilitaFieldChanged: Boolean;
  private
    procedure RegistroIndividualeNewRecord(DataSet: TDataSet);
    procedure RegistroIndividualeAfterCreateFields(DataSet: TDataSet);
    procedure RegistroIndividualeCalcolaOraFine(Sender: TField);
    procedure RegistroIndividualeDataChanged(Sender: TField);
    procedure RegistroIndividualeRicalcolaIncarico(Sender: TField);
    procedure PresenzeTirociniAfterCreateFields(DataSet: TDataSet);
    procedure PresenzeTirociniCalcolaOraFine(Sender: TField);
    procedure PresenzeTirociniDataChanged(Sender: TField);
    procedure RegistroIndividualeCalcolaIncarico;
    procedure SetFiltroEnte(const Value: integer);
  protected
    function GetModified: Boolean; override;
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    function CloseQuery: Boolean; override;
    function Commit(const Verbose: Boolean = True): Boolean; override;
    procedure Rollback(const ReopenDataSets: Boolean; const Verbose: Boolean = True); override;

    procedure ApriCorsi(const IdProgetto: integer);
    procedure CaricaRegistroCollettivo(const IdProgetto, IdCorso: integer; DataLezione: TDate);
    procedure SalvaRegistroCollettivo(const IdProgetto, IdCorso: integer; DataLezione: TDate);
    procedure FirmaRegistroCollettivo(const IdProgetto, IdCorso: integer; DataLezione: TDate);
    // Mantis #47 - 2026-07-28: comando di blocco/sblocco delle presenze studenti
    // della giornata, autorizzato con Registro.BloccaStudenti/SbloccaStudenti
    // (controllo dentro STUDENTI_PRESENZE_COLL_BLOCCA). Indipendente dalla firma
    // dei docenti: non tocca BloccaDocenti.
    procedure BloccaPresenzeCollettivo(const IdProgetto, IdCorso: integer; DataLezione: TDate; const Blocca: Boolean);

    procedure SalvaStudente(const IdProgetto: integer; DataLezione: TDate; Studente: TStudente);
    procedure SalvaStudenti(const IdProgetto: integer; DataLezione: TDate);
    procedure ForzaTipologiaFormazione(const IdProgetto, IdCorso: integer; const DataLezione: TDateTime; const TipologiaFormazione: string);

    function ModificaOrario(IdOrario: integer): Boolean;

    property RegistroCollettivo: TRegistroCollettivo read FRegistroCollettivo write FRegistroCollettivo;
  public
    callbackCloseQuery: TProc<Boolean>;
    function CurrentData: TDateTime;
    function CurrentProgetto: integer;
    function CurrentCorso: integer;

    property FiltroEnte: integer read FFiltroEnte write SetFiltroEnte;
  end;

var
  RegistroStudenti: TRegistroStudenti;

implementation

uses
  WinApi.ShellAPI,
  System.DateUtils,
  Gesty_StoredProcs,
  zMsg,
  Gesty.Types;

{$R *.dfm}
{ TRegistroStudenti }

constructor TRegistroStudenti.Create(aOwner: TComponent);
begin
  inherited;
  FFiltroEnte := -1;
  callbackCloseQuery := nil;
  RegistroIndividualeDisabilitaFieldChanged := False;
  RegistroCollettivoParams.Init;

  // FIdProgetto := 20164; // -1
  // FDataLezione := EncodeDateTime(2020, 4, 27, 0, 0, 0, 0);
  FRegistroCollettivo := TRegistroCollettivo.Create;
end;

destructor TRegistroStudenti.Destroy;
begin
  FreeAndNil(FRegistroCollettivo);
  inherited;
end;

procedure TRegistroStudenti.ApriCorsi(const IdProgetto: integer);
begin
  lkCorsi.RevertSql(False);
  lkCorsi.ParamByName('ID_PROGETTO').Value := IdProgetto;
  lkCorsi.Active := True;
end;

procedure TRegistroStudenti.CaricaRegistroCollettivo(const IdProgetto, IdCorso: integer; DataLezione: TDate);
var
  sp: TSP_studenti_Presenze_Coll_Tmp_Prep;
  RegistroCollettivoTmp: TzFbDataSet;
begin
  sp := TSP_studenti_Presenze_Coll_Tmp_Prep.Create(WriteTrans);
  try
    sp.Id_Progetto := IdProgetto;
    sp.Id_Corso := IdCorso;
    sp.Data_Lezione := DataLezione;
    sp.ExecuteAndCommit;
    RegistroCollettivo.NuovePresenzeDaSalvare := sp.Modificato;
    RegistroCollettivo.BloccaDocenti := sp.Blocca_Rilevamenti_Docenti;
    // Mantis #47 - 2026-07-28: vero quando almeno un'ora della giornata e'
    // congelata (STUDENTI_PRESENZE_COLL_TMP_PREP, EXISTS al posto di FIRST 1)
    RegistroCollettivo.BloccaStudenti := sp.Blocca_Presenze_Studenti;
  finally
    FreeAndNil(sp);
  end;

  /// /////
  RegistroCollettivoTmp := GetDataSet('RegistroCollettivo');
  RegistroCollettivoTmp.ReOpen;
  try
    RegistroCollettivo.LoadFromDataSet(RegistroCollettivoTmp);
  finally
    RegistroCollettivoTmp.Active := False;
  end;

  // Se tutto ok salva i parametri per closeQuery
  RegistroCollettivoParams.IdProgetto := IdProgetto;
  RegistroCollettivoParams.IdCorso := IdCorso;
  RegistroCollettivoParams.DataLezione := DataLezione;
end;

procedure TRegistroStudenti.SalvaRegistroCollettivo(const IdProgetto, IdCorso: integer; DataLezione: TDate);
var
  sp: TSP_studenti_Presenze_Coll_Tmp_Save;
begin
  sp := TSP_studenti_Presenze_Coll_Tmp_Save.Create(WriteTrans);
  try
    sp.Id_Progetto := IdProgetto;
    sp.Id_Corso := IdCorso;
    sp.Data_Lezione := DataLezione;
    sp.ExecuteAndCommit;
    RegistroCollettivo.Salvato;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TRegistroStudenti.BloccaPresenzeCollettivo(const IdProgetto, IdCorso: integer; DataLezione: TDate; const Blocca: Boolean);
var
  sp: TSP_studenti_Presenze_Coll_Blocca;
  msg: string;
begin
  // Mantis #47 - 2026-07-28: il nome del wrapper e le proprieta' seguono la
  // convenzione delle altre TSP_studenti_Presenze_Coll_*, ma la classe non
  // esiste finche' Gesty_StoredProcs.pas non viene rigenerato dopo lo script
  // 05 (STUDENTI_PRESENZE_COLL_BLOCCA). Verificare i nomi esatti sul file
  // generato prima di compilare.
  if Blocca then
    msg := 'Si desidera bloccare nuovamente le presenze di questa giornata?'
  else
    msg := 'Si desidera sbloccare le presenze di questa giornata?' + sLineBreak + 'Sar�''possibile modificarle fino al blocco successivo.';

  if not ConfirmYesNo(msg) then
    exit;

  StartWait('Attendere...', True);
  try
    sp := TSP_studenti_Presenze_Coll_Blocca.Create(WriteTrans);
    try
      sp.Id_Progetto := IdProgetto;
      sp.Id_Corso := IdCorso;
      sp.Data_Lezione := DataLezione;
      sp.Blocca_Presenze_Studenti := Blocca;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;
  finally
    StopWait;
  end;
end;

procedure TRegistroStudenti.SalvaStudenti(const IdProgetto: integer; DataLezione: TDate);
var
  Studente: TStudente;
begin
  for Studente in RegistroCollettivo.Studenti do
    SalvaStudente(IdProgetto, DataLezione, Studente);
end;

procedure TRegistroStudenti.SalvaStudente(const IdProgetto: integer; DataLezione: TDate; Studente: TStudente);
var
  Materia: TMateria;
  Presenza: TPresenza;
  sp: TSP_studenti_Presenze_Coll_Tmp_Upd;
begin
  sp := TSP_studenti_Presenze_Coll_Tmp_Upd.Create(WriteTrans);
  try
    for Presenza in Studente.OrePresenza do
    begin
      // Mantis #47 - 2026-07-28: le ore congelate si saltano qui invece di
      // uscire dall'intero metodo com'era prima (if BloccaStudenti then exit):
      // cosi' le altre ore non bloccate della stessa giornata restano
      // modificabili. Il controllo per errore umano resta comunque a valle,
      // in STUDENTI_PRESENZE_COLL_TMP_SAVE, che non tocca mai le ore bloccate.
      Materia := RegistroCollettivo.Materie.GetMateria(Presenza.Ora);
      if Assigned(Materia) then
        if Materia.PresenzeBloccate then
          Continue;

      sp.Id_Presenza_Collettiva := Presenza.IdPresenzaCollettiva;
      sp.Stato_Presenza := Presenza.StatoPresenza.ToString;
      sp.Override_Tipologia_Formazione := Presenza.OverrideTipologiaFormazione;
      sp.Minuti_Assenza := Presenza.MinutiAssenza;
      sp.ExecuteAndCommit;
      RegistroCollettivo.Modificato;
    end;
  finally
    FreeAndNil(sp);
  end;
end;

function TRegistroStudenti.ModificaOrario(IdOrario: integer): Boolean;
begin
  Orario.RevertSql(False);
  Orario.ParamByName('ID_ORARIO').asInteger := IdOrario;
  Orario.Active := True;
  try
    cardOrario.CreateForm;

    if RegistroCollettivo.BloccaDocenti then
      cardOrario.zDbCardForm.zDbCard.ReadOnly := crForceReadOnly
    else
      cardOrario.zDbCardForm.zDbCard.ReadOnly := crUseLoadedProps;

    result := cardOrario.Execute;
  finally
    Orario.Active := False;
  end;
end;

procedure TRegistroStudenti.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;
  if SameText(DataSetName, 'PresenzeTirocini') then
    DataSet.OnAfterCreateFields := PresenzeTirociniAfterCreateFields
  else
    if SameText(DataSetName, 'RegistroIndividuale') then
    begin
      DataSet.OnAfterCreateFields := RegistroIndividualeAfterCreateFields;
      DataSet.OnNewRecord := RegistroIndividualeNewRecord;
    end;
end;

function TRegistroStudenti.CloseQuery: Boolean;
begin
  result := inherited CloseQuery;

  if result then
    if assigned(callbackCloseQuery) then
      callbackCloseQuery(result);
end;

function TRegistroStudenti.Commit(const Verbose: Boolean = True): Boolean;
begin

  if RegistroCollettivoParams.IsValid then
    SalvaRegistroCollettivo(RegistroCollettivoParams.IdProgetto, RegistroCollettivoParams.IdCorso, RegistroCollettivoParams.DataLezione);

  result := inherited Commit(Verbose);
end;

function TRegistroStudenti.CurrentCorso: integer;
begin
  result := RegistroCollettivoParams.IdCorso;
end;

function TRegistroStudenti.CurrentData: TDateTime;
begin
  result := RegistroCollettivoParams.DataLezione;
end;

function TRegistroStudenti.CurrentProgetto: integer;
begin
  result := RegistroCollettivoParams.IdProgetto;
end;

procedure TRegistroStudenti.Rollback(const ReopenDataSets: Boolean; const Verbose: Boolean = True);
begin
  inherited;

  if RegistroCollettivoParams.IsValid then
    CaricaRegistroCollettivo(RegistroCollettivoParams.IdProgetto, RegistroCollettivoParams.IdCorso, RegistroCollettivoParams.DataLezione);

  RegistroCollettivo.Salvato;
end;

procedure TRegistroStudenti.PresenzeTirociniAfterCreateFields(DataSet: TDataSet);
begin
  // Tirocini
  DataSet.FieldByName('DATA_LEZIONE').OnChange := PresenzeTirociniDataChanged;
  DataSet.FieldByName('ORA_INIZIO').OnChange := PresenzeTirociniCalcolaOraFine;
  DataSet.FieldByName('DURATA').OnChange := PresenzeTirociniCalcolaOraFine;
end;

procedure TRegistroStudenti.PresenzeTirociniCalcolaOraFine(Sender: TField);
var
  DataSet: TzFbDataSet;
  Inizio, Fine, Durata: TField;
begin
  // Tirocini
  DataSet := GetDataSet('PresenzeTirocini');

  Inizio := DataSet.FieldByName('ORA_INIZIO');
  Durata := DataSet.FieldByName('DURATA');
  Fine := DataSet.FieldByName('ORA_FINE');

  if (Inizio.IsNull or Durata.IsNull) then
    Fine.Clear
  else
    Fine.Value := IncMinute(Inizio.asDateTime, Durata.asInteger);
end;

procedure TRegistroStudenti.PresenzeTirociniDataChanged(Sender: TField);
begin
  // esiste anche un constraint
  if DateOf(Sender.asDateTime) > Date then
    raise exception.Create('Data non valida.');
end;

procedure TRegistroStudenti.RegistroIndividualeAfterCreateFields(DataSet: TDataSet);
var
  Field: TField;
begin
  // PIP
  Field := DataSet.FindField('ID_RISORSA');
  if assigned(Field) then
    Field.OnChange := RegistroIndividualeRicalcolaIncarico;

  Field := DataSet.FindField('ID_PROGETTO');
  if assigned(Field) then
    Field.OnChange := RegistroIndividualeRicalcolaIncarico;
  Field := DataSet.FindField('TIPO_INCARICO');
  if assigned(Field) then
    Field.OnChange := RegistroIndividualeRicalcolaIncarico;

  Field := DataSet.FindField('ID_PIANO_PERSONALIZZATO');
  if assigned(Field) then
    Field.OnChange := RegistroIndividualeRicalcolaIncarico;

  Field := DataSet.FindField('SERVIZIO_EROGATO');
  if assigned(Field) then
    Field.OnChange := RegistroIndividualeRicalcolaIncarico;

  Field := DataSet.FindField('MATERIA');
  if assigned(Field) then
    Field.OnChange := RegistroIndividualeRicalcolaIncarico;

  Field := DataSet.FindField('ID_INCARICO');
  if assigned(Field) then
    Field.OnChange := RegistroIndividualeRicalcolaIncarico;

  Field := DataSet.FindField('DATA_LEZIONE');
  if assigned(Field) then
    Field.OnChange := RegistroIndividualeDataChanged;

  // calcolo ora fine
  Field := DataSet.FindField('ORA_INIZIO');
  if assigned(Field) then
    Field.OnChange := RegistroIndividualeCalcolaOraFine;

  Field := DataSet.FindField('DURATA');
  if assigned(Field) then
    Field.OnChange := RegistroIndividualeCalcolaOraFine;
end;

procedure TRegistroStudenti.RegistroIndividualeCalcolaOraFine(Sender: TField);
var
  DataSet: TzFbDataSet;
  Inizio, Fine, Durata: TField;
begin
  // PIP
  DataSet := GetDataSet('RegistroIndividuale');

  Inizio := DataSet.FieldByName('ORA_INIZIO');
  Durata := DataSet.FieldByName('DURATA');
  Fine := DataSet.FieldByName('ORA_FINE');

  if (Inizio.IsNull or Durata.IsNull) then
    Fine.Clear
  else
    Fine.Value := IncMinute(Inizio.asDateTime, Durata.asInteger);
end;

procedure TRegistroStudenti.RegistroIndividualeDataChanged(Sender: TField);
begin
  // esiste anche un constraint
  if DateOf(Sender.asDateTime) > Date then
    raise exception.Create('Data non valida.');

  RegistroIndividualeCalcolaIncarico;
end;

procedure TRegistroStudenti.RegistroIndividualeNewRecord(DataSet: TDataSet);
var
  Piani_Personalizzati: TzFbDataSet;
  RegistroIndividuale: TzFbDataSet;
begin
  Piani_Personalizzati := GetDataSet('Progetti_Piani_Personalizzati');
  RegistroIndividuale := GetDataSet('RegistroIndividuale');

  RegistroIndividuale.FieldByName('ID_STUDENTE').asInteger := Piani_Personalizzati.FieldByName('ID_STUDENTE').asInteger;
end;

procedure TRegistroStudenti.RegistroIndividualeRicalcolaIncarico(Sender: TField);
begin

  if RegistroIndividualeDisabilitaFieldChanged then
    exit;

  RegistroIndividualeDisabilitaFieldChanged := True;
  try
    if SameText(Sender.FieldName, 'ID_PROGETTO') then
    begin
      Sender.DataSet.FieldByName('TIPO_INCARICO').Clear;
      Sender.DataSet.FieldByName('ID_INCARICO').Clear;
    end
    else
      if SameText(Sender.FieldName, 'TIPO_INCARICO') then
      begin
        Sender.DataSet.FieldByName('ID_INCARICO').Clear;
      end;

    RegistroIndividualeCalcolaIncarico;
  finally
    RegistroIndividualeDisabilitaFieldChanged := False;
  end;
end;

procedure TRegistroStudenti.RegistroIndividualeCalcolaIncarico;
var
  sp: TSP_INCARICHI_GET_PRESENZE;
  RegistroIndividuale: TzFbDataSet;
  IdRisorsa, IdProgetto, Tipo_Incarico, IdStudente, ServizioErogato, Materia, IdIncarico, Data, OraInizio, OraFine: TField;
begin
  RegistroIndividuale := GetDataSet('RegistroIndividuale');

  IdRisorsa := RegistroIndividuale.FindField('ID_RISORSA'); // l'originale incaricato
  IdProgetto := RegistroIndividuale.FindField('ID_PROGETTO');
  Tipo_Incarico := RegistroIndividuale.FindField('TIPO_INCARICO');
  IdStudente := RegistroIndividuale.FindField('ID_PIANO_PERSONALIZZATO');
  ServizioErogato := RegistroIndividuale.FindField('SERVIZIO_EROGATO');
  Materia := RegistroIndividuale.FindField('MATERIA');
  IdIncarico := RegistroIndividuale.FindField('ID_INCARICO');
  Data := RegistroIndividuale.FindField('DATA_LEZIONE');
  OraInizio := RegistroIndividuale.FindField('ORA_INIZIO');
  OraFine := RegistroIndividuale.FindField('ORA_FINE');

  if not IdRisorsa.IsNull then
    if not IdProgetto.IsNull then
      if not Tipo_Incarico.IsNull then
        if not Data.IsNull then
          if not OraInizio.IsNull then
            if not OraFine.IsNull then
            begin
              sp := TSP_INCARICHI_GET_PRESENZE.Create(WriteTrans);
              try
                sp.Id_Personale := IdRisorsa.Value;
                sp.Id_Progetto := IdProgetto.Value;
                sp.Tipo_Incarico := Tipo_Incarico.Value;

                if IdStudente.IsNull then
                  sp.Id_Piano_Personalizzato.Clear
                else
                  sp.Id_Piano_Personalizzato := IdStudente.Value;

                if ServizioErogato.IsNull then
                  sp.Servizio_Erogato.Clear
                else
                  sp.Servizio_Erogato := ServizioErogato.Value;

                if Materia.IsNull then
                  sp.Materia.Clear
                else
                  sp.Materia := Materia.Value;

                if IdIncarico.IsNull then
                  sp.Id_Incarico_Current.Clear
                else
                  sp.Id_Incarico_Current := IdIncarico.asInteger;

                sp.Data := Data.Value;
                sp.Ora_Inizio := OraInizio.Value;
                sp.Ora_Fine := OraFine.Value;
                sp.ExecuteAndCommit;

                RegistroIndividuale.CheckEditMode;
                // RegistroIndividuale.FieldByName('ID_PRESENZA_PERSONALE').Value := sp.Id_Presenza_Personale;
                // RegistroIndividuale.FieldByName('DATA_PRESENZA').Value := sp.Data_Presenza;
                // RegistroIndividuale.FieldByName('ORA_ENTRATA').Value := sp.Ora_Entrata;
                // RegistroIndividuale.FieldByName('ORA_USCITA').Value := sp.Ora_Uscita;
                // RegistroIndividuale.FieldByName('TIPO_PRESENZA').Value := sp.Tipo_Presenza;
                RegistroIndividuale.FieldByName('ID_INCARICO').Value := sp.Id_Incarico;
                // RegistroIndividuale.FieldByName('TOTALE_ORE_ATTRIBUITE').Value := sp.Totale_Ore_Attribuite;
                // RegistroIndividuale.FieldByName('DATA_INIZIO_INCARICO').Value := sp.Data_Inizio_Incarico;
                // RegistroIndividuale.FieldByName('DATA_FINE_INCARICO').Value := sp.Data_Fine_Incarico;
              finally
                FreeAndNil(sp);
              end;
            end;
end;

procedure TRegistroStudenti.FirmaRegistroCollettivo(const IdProgetto, IdCorso: integer; DataLezione: TDate);
var
  sp: TSP_studenti_Presenze_Coll_Tmp_Firm;
  msg: string;
begin

  if not RegistroStudenti.RegistroCollettivo.BloccaDocenti then
    msg := 'Si desidera firmare il registro?' + sLineBreak + 'Attenzione: saranno impedite ulteriori modifiche.'
  else
    msg := 'Si desidera annullare la firma del registro?';

  if not ConfirmYesNo(msg) then
    exit;

  StartWait('Attendere...', True);
  try
    // 25.10.23: mail Stefani+Cappelletti if RegistroCollettivo.PresenzeModificate then
    if not RegistroStudenti.RegistroCollettivo.BloccaDocenti then // se salvataggio
      SalvaRegistroCollettivo(IdProgetto, IdCorso, DataLezione);

    sp := TSP_studenti_Presenze_Coll_Tmp_Firm.Create(WriteTrans);
    try
      sp.Id_Progetto := IdProgetto;
      sp.Id_Corso := IdCorso;
      sp.Data_Lezione := DataLezione;
      sp.Blocca_Rilevamenti_Docenti := not RegistroStudenti.RegistroCollettivo.BloccaDocenti;
      // Mantis #47 - 2026-07-28: il congelamento delle presenze studenti non e'
      // piu' deciso da questo parametro, ma dalla procedura stessa
      // (STUDENTI_PRESENZE_COLL_TMP_FIRM lo imposta uguale al valore docenti e
      // lo lascia invariato quando la firma viene annullata). Il valore qui e'
      // solo indicativo, mantenuto per compatibilita' col wrapper generato:
      // va tolto insieme al parametro alla prossima rigenerazione.
      sp.Blocca_Presenze_Studenti := not RegistroStudenti.RegistroCollettivo.BloccaDocenti;
      sp.ExecuteAndCommit;
      RegistroCollettivo.BloccaDocenti := not RegistroStudenti.RegistroCollettivo.BloccaDocenti;
    finally
      FreeAndNil(sp);
    end;
  finally
    StopWait;
  end;
end;

procedure TRegistroStudenti.ForzaTipologiaFormazione(const IdProgetto, IdCorso: integer; const DataLezione: TDateTime; const TipologiaFormazione: string);
var
  sp: TSP_ORARIO_FORZA_TIPOLOGIA_FORMAZ;
begin

  if RegistroCollettivo.BloccaDocenti then
  begin
    ConfirmOk('Il registro risulta firmato.');
    exit;
  end;

  StartWait('Attendere...', True);
  try
    sp := TSP_ORARIO_FORZA_TIPOLOGIA_FORMAZ.Create(WriteTrans);
    try
      sp.Id_Progetto := IdProgetto;
      sp.Id_Corso := IdCorso;
      sp.Data := DataLezione;
      sp.Tipologia_Formazione := TipologiaFormazione;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    Orario.ReOpen()
  finally
    StopWait;
  end;
end;

procedure TRegistroStudenti.QExport4XlsxBeforeExportRow(Sender: TObject; Row: TQExportRow; var Accept: Boolean);
var
  i: integer;
begin
  inherited;

  for i := 0 to Row.Columns.Count - 1 do
    Row.Columns[i].ColType := ectString;
end;

procedure TRegistroStudenti.QExport4XlsxCustomFormat(Sender: TObject; Field: TField; var Value: WideString);
begin
  inherited;

  if SameText(Field.FieldName, 'ORE_PRESENZA') or SameText(Field.FieldName, 'ORE_ASSENZA') or SameText(Field.FieldName, 'ORE_ASSENZA_GIUSTIFICATA') then
  begin
    Value := HourOf(Field.asDateTime).ToString;

    if MinuteOf(Field.asDateTime) > 0 then
      Value := Value + '.' + MinuteOf(Field.asDateTime).ToString.PadLeft(2, '0');
  end;
end;

function TRegistroStudenti.GetModified: Boolean;
begin
  result := inherited;

  if not result then
    result := RegistroCollettivo.PresenzeModificate;
end;

procedure TRegistroStudenti.SetFiltroEnte(const Value: integer);
begin
  FFiltroEnte := Value;
  lkProgetti.ReOpen();
  lkProgettiCodReg.ReOpen();
end;

procedure TRegistroStudenti.FiltroEnteBeforeOpen(DataSet: TDataSet);
var
  zFbDataSet: TzFbDataSet;
begin
  inherited;
  zFbDataSet := TzFbDataSet(DataSet);

  if zFbDataSet.ParamExists('ID_ENTE') then
    zFbDataSet.ParamByName('ID_ENTE').asInteger := FiltroEnte;
end;

procedure TRegistroStudenti.TRegistroCollettivoParams.Init;
begin
  IdProgetto := -1;
  IdCorso := -1;
  DataLezione := 0;
end;

function TRegistroStudenti.TRegistroCollettivoParams.IsValid: Boolean;
begin
  result := (IdProgetto <> -1);
end;

end.
