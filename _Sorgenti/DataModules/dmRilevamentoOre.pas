unit dmRilevamentoOre;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  dbMaster,
  Base_DataModule,
  zFbDataSet,
  zFormController,
  SmartInspect.VCL.SiAuto,
  SmartInspect.VCL;

type
  TRilevamentoOre = class(TBaseDataModule)
    SetColorsSrc: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure SetColorsSrcDataChange(Sender: TObject; Field: TField);
  private
    procedure RilevamentoOreAfterCreateFields(DataSet: TDataSet);
    procedure RilevamentoOreAfterPost(DataSet: TDataSet);
    procedure RilevamentoOreNewRecord(DataSet: TDataSet);
    procedure RilevamentoOreCalcFields(DataSet: TDataSet);
    procedure RilevamentoFieldChanged(Sender: TField);

    procedure NumeroOreChanged(Sender: TField);
    procedure DataChanged(Sender: TField);
  private
    DisableRilevamentoFieldChanged: boolean;
    LastProgetto: integer;
    LastData: TDate;
    LastOraFine: TTime;
    function NumeroOre(OraInizio, OraFine: TTime): double;
  protected
    procedure GetDettagliPresenza;
    procedure AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Aggiungi;
    function CloseQuery: boolean; override;
    function GeneraRilevamentoDaOraLibera: boolean;
    function IdRisorsaSelezionata: integer;
    procedure RegistraMeseRilevazione;
  end;

var
  RilevamentoOre: TRilevamentoOre;

implementation

uses
  System.DateUtils,
  System.Threading,
  VCL.Dialogs,
  Gesty_StoredProcs,
  zOffice.Reports,
   
  zMsg,
  zDX,
  cxImageComboBox,
  dmCommon,
  System.Variants;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

constructor TRilevamentoOre.Create(aOwner: TComponent);
begin
  inherited;

  ReportsManager.AddVariablesProc := procedure(ReportsManager: TzReportsManager)
    begin
      common.AssegnaVariabiliTimeReport(ReportsManager, IdRisorsaSelezionata, -1, nil);
    end;
end;

procedure TRilevamentoOre.DataModuleCreate(Sender: TObject);
begin
  inherited;
  DisableRilevamentoFieldChanged := False;
  LastProgetto := -1;
  LastData := Date; // il test viene fatto su idProgetto
  LastOraFine := Time; // il test viene fatto su idProgetto
end;

destructor TRilevamentoOre.Destroy;
begin
  SiMain.EnterMethod('TRilevamentoOre.Destroy');
  SetColorsSrc.OnDataChange := nil;
  inherited;
  SiMain.LeaveMethod('TRilevamentoOre.Destroy');
end;

procedure TRilevamentoOre.AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if sameText(DataSetName, 'Personale_Rilevamento_Ore') then
  begin
    SetColorsSrc.DataSet := DataSet;

    DataSet.OnAfterCreateFields := RilevamentoOreAfterCreateFields;
    DataSet.OnNewRecord := RilevamentoOreNewRecord;
    DataSet.AfterPost := RilevamentoOreAfterPost;
    DataSet.OnCalcFields := RilevamentoOreCalcFields;
  end;
end;

procedure TRilevamentoOre.RilevamentoOreAfterCreateFields(DataSet: TDataSet);
var
  Field: TField;
begin
  DataSet.CreateCalculatedField(TBooleanField, 'RILEVAMENTO_ORE_EXTRA_REGISTRO');

  Field := DataSet.FindField('ID_RISORSA');
  if Assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;

  Field := DataSet.FindField('ID_PROGETTO');
  if Assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;

  Field := DataSet.FindField('DATA');
  if Assigned(Field) then
    Field.OnChange := DataChanged;

  Field := DataSet.FindField('ORA_INIZIO');
  if Assigned(Field) then
    Field.OnChange := NumeroOreChanged;

  Field := DataSet.FindField('ORA_FINE');
  if Assigned(Field) then
    Field.OnChange := NumeroOreChanged;

  Field := DataSet.FindField('TIPO_INCARICO');
  if Assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;

  Field := DataSet.FindField('ID_PIANO_PERSONALIZZATO');
  if Assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;

  Field := DataSet.FindField('SERVIZIO_EROGATO');
  if Assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;

  Field := DataSet.FindField('MATERIA');
  if Assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;

  Field := DataSet.FindField('ID_INCARICO');
  if Assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;
end;

procedure TRilevamentoOre.RilevamentoOreAfterPost(DataSet: TDataSet);
begin
  LastProgetto := DataSet.FieldByName('ID_PROGETTO').AsInteger;
  LastData := DateOf(DataSet.FieldByName('DATA').AsDateTime);
  LastOraFine := TimeOf(DataSet.FieldByName('ORA_FINE').AsDateTime);

  if HourOf(LastOraFine) >= 23 then
    LastOraFine := EncodeTime(07, 00, 00, 00);
end;

procedure TRilevamentoOre.RilevamentoOreNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('RILEVAMENTO_ORE_EXTRA_REGISTRO').asBoolean := False;

  if LastProgetto <> -1 then
  begin
    DisableRilevamentoFieldChanged := true;
    try
      DataSet.FieldByName('ID_PROGETTO').AsInteger := LastProgetto;
      DataSet.FieldByName('DATA').AsDateTime := LastData;
      DataSet.FieldByName('ORA_INIZIO').AsDateTime := LastOraFine;
    finally
      DisableRilevamentoFieldChanged := False;
    end;
  end;

  common.FocusField(DataSet.FieldByName('ID_RISORSA'));
end;

procedure TRilevamentoOre.RilevamentoOreCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('RILEVAMENTO_ORE_EXTRA_REGISTRO').asBoolean := False;
end;

procedure TRilevamentoOre.Aggiungi;
var
  DataSet: TzFbDataSet;
begin
  DataSet := getDataSet('Personale_Rilevamento_Ore');
  DataSet.Insert;
end;

procedure TRilevamentoOre.RilevamentoFieldChanged(Sender: TField);
begin
  if DisableRilevamentoFieldChanged then
    exit;

  DisableRilevamentoFieldChanged := true;
  try
    if sameText(Sender.FieldName, 'ID_PROGETTO') then
    begin
      Sender.DataSet.FieldByName('TIPO_INCARICO').Clear;
      Sender.DataSet.FieldByName('ID_INCARICO').Clear;
    end
    else
      if sameText(Sender.FieldName, 'TIPO_INCARICO') then
      begin
        Sender.DataSet.FieldByName('ID_INCARICO').Clear;
      end;

    GetDettagliPresenza;
  finally
    DisableRilevamentoFieldChanged := False;
  end;
end;

procedure TRilevamentoOre.NumeroOreChanged(Sender: TField);
var
  OraInizio, OraFine, Ore: TField;
  m: integer;
begin
  OraInizio := Sender.DataSet.FindField('ORA_INIZIO');
  OraFine := Sender.DataSet.FindField('ORA_FINE');
  Ore := Sender.DataSet.FindField('ORE');

  /// ////////////////////
  if Assigned(OraInizio) then
    if Sender = OraInizio then
      if (OraInizio.IsNull) or (OraInizio.Value = EncodeTime(0, 1, 0, 0)) then
        OraInizio.Value := EncodeTime(0, 0, 0, 0);
  //
  if Assigned(OraFine) then
    if Sender = OraFine then
      if (OraFine.IsNull) or (OraFine.Value = EncodeTime(0, 0, 0, 0)) then
        OraFine.Value := EncodeTime(23, 59, 0, 0);
  /// ////////////////////

  if Assigned(OraInizio) then
    if Assigned(OraFine) then
      if Assigned(Ore) then
      begin
        if not(OraInizio.IsNull or OraFine.IsNull) then
          if OraInizio.Value >= OraFine.Value then
            if OraFine.Value <> EncodeTime(0, 0, 0, 0) then
              raise exception.Create('Intevallo orario non valido.');

        if OraInizio.IsNull or OraFine.IsNull then
          Ore.Clear
        else
        begin
          // if OraFine.value <> EncodeTime(0, 0, 0, 0) then
          // m := MinutesBetween(OraInizio.AsDateTime, OraFine.AsDateTime)
          // else
          // m := 1 + MinutesBetween(OraInizio.AsDateTime, EncodeTime(23, 59, 0, 0));
          Ore.Value := NumeroOre(OraInizio.AsDateTime, OraFine.AsDateTime);
        end;
      end;

  GetDettagliPresenza;
end;

function TRilevamentoOre.NumeroOre(OraInizio, OraFine: TTime): double;
var
  Minuti: integer;
begin
  result := 0;

  Minuti := MinutesBetween(OraInizio, OraFine);

  if OraInizio = EncodeTime(0, 1, 0, 0) then
    inc(Minuti);

  if OraFine = EncodeTime(23, 59, 0, 0) then
    inc(Minuti);

  result := trunc((Minuti / 60) * 100) / 100;
end;

procedure TRilevamentoOre.DataChanged(Sender: TField);
  function GetGiornoStr(giorno: integer): string;
  begin
    case giorno of
      0:
        result := 'Domenica';
      1:
        result := 'Lunedì';
      2:
        result := 'Martedì';
      3:
        result := 'Mercoledì';
      4:
        result := 'Giovedì';
      5:
        result := 'Venerdì';
      6:
        result := 'Sabato';
    end;
  end;

var
  giorno, GiornoStr: TField;
begin
  if DateOf(Sender.AsDateTime) > Date then
    raise exception.Create('Data non valida.');

  giorno := Sender.DataSet.FindField('GIORNO');
  if Assigned(giorno) then
    giorno.Value := DayOfWeek(Sender.AsDateTime) - 1;

  GiornoStr := Sender.DataSet.FindField('GIORNO_STR');
  if Assigned(GiornoStr) then
    GiornoStr.Value := GetGiornoStr(DayOfWeek(Sender.AsDateTime) - 1);

  GetDettagliPresenza;
end;

procedure TRilevamentoOre.GetDettagliPresenza;
var
  sp: TSP_INCARICHI_GET_PRESENZE;
  Personale_Rilevamento_Ore: TzFbDataSet;
  IdRisorsa, idProgetto, idCorso, Tipo_Incarico, IdStudente, ServizioErogato, Materia, IdIncarico, Data, OraInizio, OraFine: TField;
begin
  Personale_Rilevamento_Ore := getDataSet('Personale_Rilevamento_Ore');

  IdRisorsa := Personale_Rilevamento_Ore.FindField('ID_RISORSA'); // l'originale incaricato
  idProgetto := Personale_Rilevamento_Ore.FindField('ID_PROGETTO');
  idCorso := Personale_Rilevamento_Ore.FindField('ID_CORSO');
  Tipo_Incarico := Personale_Rilevamento_Ore.FindField('TIPO_INCARICO');
  IdStudente := Personale_Rilevamento_Ore.FindField('ID_PIANO_PERSONALIZZATO');
  ServizioErogato := Personale_Rilevamento_Ore.FindField('SERVIZIO_EROGATO');
  Materia := Personale_Rilevamento_Ore.FindField('MATERIA');
  IdIncarico := Personale_Rilevamento_Ore.FindField('ID_INCARICO');
  Data := Personale_Rilevamento_Ore.FindField('DATA');
  OraInizio := Personale_Rilevamento_Ore.FindField('ORA_INIZIO');
  OraFine := Personale_Rilevamento_Ore.FindField('ORA_FINE');

  if not IdRisorsa.IsNull then
    if not idProgetto.IsNull then
      if not Tipo_Incarico.IsNull then
        if not Data.IsNull then
          if not OraInizio.IsNull then
            if not OraFine.IsNull then
            begin

              sp := TSP_INCARICHI_GET_PRESENZE.Create(WriteTrans);
              try
                sp.Id_Personale := IdRisorsa.Value;
                sp.Id_Progetto := idProgetto.Value;

                if idCorso.IsNull then
                  sp.Id_Corso.Clear
                else
                  sp.Id_Corso := idCorso.Value;

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
                  sp.Id_Incarico_Current := IdIncarico.AsInteger;

                sp.Data := Data.Value;
                sp.Ora_Inizio := OraInizio.Value;
                sp.Ora_Fine := OraFine.Value;
                sp.ExecuteAndCommit;

                Personale_Rilevamento_Ore.CheckEditMode;
                Personale_Rilevamento_Ore.FieldByName('ID_PRESENZA_PERSONALE').Value := sp.Id_Presenza_Personale;
                Personale_Rilevamento_Ore.FieldByName('DATA_PRESENZA').Value := sp.Data_Presenza;
                Personale_Rilevamento_Ore.FieldByName('ORA_ENTRATA').Value := sp.Ora_Entrata;
                Personale_Rilevamento_Ore.FieldByName('ORA_USCITA').Value := sp.Ora_Uscita;
                Personale_Rilevamento_Ore.FieldByName('TIPO_RILEVAMENTO').Value := sp.Tipo_Rilevamento;
                Personale_Rilevamento_Ore.FieldByName('ID_INCARICO').Value := sp.Id_Incarico;
                Personale_Rilevamento_Ore.FieldByName('TOTALE_ORE_ATTRIBUITE').Value := sp.Totale_Ore_Attribuite;
                Personale_Rilevamento_Ore.FieldByName('TOTALE_ORE_RESIDUE').Value := sp.Totale_Ore_Residue;
                Personale_Rilevamento_Ore.FieldByName('DATA_INIZIO_INCARICO').Value := sp.Data_Inizio_Incarico;
                Personale_Rilevamento_Ore.FieldByName('DATA_FINE_INCARICO').Value := sp.Data_Fine_Incarico;
              finally
                FreeAndNil(sp);
              end;
            end;
end;

function TRilevamentoOre.CloseQuery: boolean;
var
  Personale_Rilevamento_Ore: TzFbDataSet;
begin
  Personale_Rilevamento_Ore := getDataSet('Personale_Rilevamento_Ore');

  try
    if Personale_Rilevamento_Ore.State in dsEditModes then
      Personale_Rilevamento_Ore.UpdateRecord;

    if Personale_Rilevamento_Ore.State = dsInsert then
      if not Personale_Rilevamento_Ore.Modified then
        Personale_Rilevamento_Ore.Cancel;
  except
  end;

  result := inherited CloseQuery;

  if not result then
    if Personale_Rilevamento_Ore.State = dsBrowse then
      Personale_Rilevamento_Ore.Insert;
end;

function TRilevamentoOre.GeneraRilevamentoDaOraLibera: boolean;
var
  Master, Incarichi, OreLibere, Rilevamenti: TzFbDataSet;
begin
  result := False;

  Incarichi := getDataSet('Incarichi');
  Rilevamenti := getDataSet('Incarichi_Ore_Rilevate');
  OreLibere := getDataSet('Personale_Presenze_Libere');

  if OreLibere.IsEmpty then
    exit;

  Rilevamenti.Append;
  Rilevamenti.FieldByName('DATA').AsDateTime := OreLibere.FieldByName('DATA_PRESENZA').AsDateTime;
  Rilevamenti.FieldByName('ORA_INIZIO').AsDateTime := OreLibere.FieldByName('DALLE_ORE').AsDateTime;
  Rilevamenti.FieldByName('ORA_FINE').AsDateTime := OreLibere.FieldByName('ALLE_ORE').AsDateTime;
  Rilevamenti.FieldByName('ORE').AsFloat := OreLibere.FieldByName('ORE_LIBERE').AsFloat;
  Rilevamenti.FieldByName('ID_PROGETTO').AsInteger := Incarichi.FieldByName('ID_PROGETTO').AsInteger;
  // Rilevamenti.FieldByName('ID_CORSO').Value := Incarichi.FieldByName('ID_CORSO').Value;
  Rilevamenti.FieldByName('TIPO_INCARICO').asString := Incarichi.FieldByName('TIPO_INCARICO').asString;
  Rilevamenti.FieldByName('MATERIA').Value := Incarichi.FieldByName('MATERIA').Value;
  Rilevamenti.FieldByName('ID_INCARICO').AsInteger := Incarichi.FieldByName('ID_INCARICO').AsInteger;
  Rilevamenti.FieldByName('TOTALE_ORE_ATTRIBUITE').AsFloat := Incarichi.FieldByName('TOTALE_ORE_ATTRIBUITE').AsFloat;
  Rilevamenti.FieldByName('DATA_INIZIO_INCARICO').AsDateTime := Incarichi.FieldByName('DATA_INIZIO_INCARICO').AsDateTime;
  Rilevamenti.FieldByName('DATA_FINE_INCARICO').AsDateTime := Incarichi.FieldByName('DATA_FINE_INCARICO').AsDateTime;
  Rilevamenti.FieldByName('PIANI_PERSONALIZZATI').asBoolean := Incarichi.FieldByName('PIANI_PERSONALIZZATI').asBoolean;
  // Presenza
  Rilevamenti.FieldByName('ID_PRESENZA_PERSONALE').AsInteger := OreLibere.FieldByName('ID_PRESENZA_PERSONALE').AsInteger;
  Rilevamenti.FieldByName('DATA_PRESENZA').AsDateTime := OreLibere.FieldByName('DATA_PRESENZA').AsDateTime;
  Rilevamenti.FieldByName('ORA_ENTRATA').AsDateTime := OreLibere.FieldByName('ORA_ENTRATA').AsDateTime;
  Rilevamenti.FieldByName('ORA_USCITA').AsDateTime := OreLibere.FieldByName('ORA_USCITA').AsDateTime;
  //
  // il post lo farà la card

  result := true;
end;

function TRilevamentoOre.IdRisorsaSelezionata: integer;
var
  DataSet: TzFbDataSet;
begin
  result := -1;

  DataSet := getDataSet('Personale_Rilevamento_Ore');
  if Assigned(DataSet) then
    if not DataSet.IsEmpty then
      result := DataSet.FieldByName('ID_RISORSA').AsInteger;
end;

procedure TRilevamentoOre.SetColorsSrcDataChange(Sender: TObject; Field: TField);
var
  DataSet: TDataSet;
  Required: boolean;
begin
  inherited;

  DataSet := getDataSet('Personale_Rilevamento_Ore');

  if Assigned(DataSet) then
  begin
    Required := DataSet.FieldByName('PIANI_PERSONALIZZATI').asBoolean AND DataSet.FieldByName('VERIFICA_PIP').asBoolean;
    DataSet.FieldByName('ID_PIANO_PERSONALIZZATO').Required := Required;
    DataSet.FieldByName('SERVIZIO_EROGATO').Required := Required;

    Required := sameText(DataSet.FieldByName('TIPO_INCARICO').asString, 'Docenza') and (DataSet.FieldByName('RENDICONTAZIONE_MATERIE').asBoolean = true);
    DataSet.FieldByName('MATERIA').Required := Required;
  end;
end;

procedure TRilevamentoOre.RegistraMeseRilevazione;
var
  DataSet: TzFbDataSet;
  sp: TSP_PROGETTI_SET_MESE_RILEVAZIONI;
  idProgetto: integer;
  Mese: integer;
  s: string;
begin
  /// ///////////////////////

  DataSet := getDataSet('Personale_Rilevamento_Ore');

  if DataSet.IsEmpty or DataSet.FieldByName('ID_PROGETTO').IsNull then
  begin
    ConfirmOk('Progetto non specificato.');
    exit;
  end;

  idProgetto := DataSet.FieldByName('ID_PROGETTO').AsInteger;

  /// ///////////////////////

  s := '';
  if not InputCombo('Mese', 'Mese', s, nil, nil, true, true,
    procedure(dlg: TInputDialog)
    begin
      dx.InitPickList((dlg.cxCustomEdit as TcxImageComboBox).Properties, 'MESI');
    end) then
    exit;

  Mese := s.ToInteger();

  /// ///////////////////////

  sp := TSP_PROGETTI_SET_MESE_RILEVAZIONI.Create(WriteTrans);
  try
    sp.Id_Progetto := idProgetto;
    sp.Mese := Mese;

    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  ConfirmOk('Mese rilevazione registrato.');
end;

end.

  TSP_get_Incarico_And_Presenza
  zsystem
