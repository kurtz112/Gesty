unit dmPersonaleScheda;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
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
  cxClasses,
  Base_DataModule,
  dbMaster,
  zFbDataSet,
  zDbCardDlg,
  Gesty.Types,
  zDbViewDlg,
  dxSpreadSheet,
  SmartInspect.VCL.SiAuto,
  SmartInspect.VCL,
  frCoreClasses,
  frxClass,
  frxDBSet;

type
  TPersonaleScheda = class(TBaseDataModule)
    SetColorsSrc: TDataSource;
    dlgProgettiColonne: TzDbViewDlg;
    lkProgettiColonne: TzFbDataSet;
    procedure SetColorsSrcDataChange(Sender: TObject; Field: TField);
  private
    LastData: TDate;
    LastOraFine: TTime;
    DisableRilevamentoFieldChanged: Boolean;
    // Timesheet: progetti scelti alla stampa da affiancare al principale ("id,id,id", massimo otto)
    ElencoProgettiColonne: string;
    // Field
    procedure RilevamentoDataChanged(Sender: TField);
    procedure RilevamentoNumeroOreChanged(Sender: TField);
    procedure RilevamentoFieldChanged(Sender: TField);
    // DataSet
    procedure RilevamentiOreAfterCreateFields(DataSet: TDataSet);
    procedure RilevamentiNewRecord(DataSet: TDataSet);
    procedure RilevamentiOreCalcFields(DataSet: TDataSet);

    procedure PersonaleRilevamentoOreAfterPost(DataSet: TDataSet);

    procedure Ore_Rilevate_ElencoAggiornaIncarico(DataSet: TDataSet);
    function Presenze_AnnoSelezionato: string;
    function Presenze_MeseSelezionato: integer;
    procedure GetDettagliPresenza(DataSet: TDataSet);

    procedure TimeSheetProgettiAfterOpen(DataSet: TDataSet);
    procedure TimeSheetDetailsBeforeOpen(DataSet: TDataSet);
    // Timesheet: modelli Excel della scheda personale
    function TimesheetNomeModello(const ReportName: string): string;
    function TimesheetModelloConColonneProgetto(const NomeModello: string): Boolean;
    function TimesheetScegliProgettiColonne(out Elenco: string): Boolean;
    procedure TimesheetImpostaElencoProgetti(const NomeModello, Elenco: string);
    procedure TimesheetNascondiColonne(const NomeModello: string; dxSpreadSheet: TdxSpreadSheet);

    procedure PersonaleBeforeOpen(DataSet: TDataSet);
  protected
    procedure AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    constructor Create(aOwner: TComponent); override;

    function GeneraRilevamentoDaOraLibera: Boolean;
    function GeneraRilevamentiMultipli(presenze: TList<integer>): Boolean;
  private
    FIsDebug: Boolean;
    function IdRisorsa: integer;
  private
    procedure SetIsDebug(const Value: Boolean);
  public
    property IsDebug: Boolean read FIsDebug write SetIsDebug;
  end;

var
  PersonaleScheda: TPersonaleScheda;

implementation

uses
  System.Threading,
  System.DateUtils,
  System.UITypes,
  VCL.Dialogs,
  Gesty_StoredProcs,
  zOffice.Reports,
   
  dmCommon,
  zFrmParams,
  zMsg,
  zBaseLib,
  System.Variants,
  dxSpreadSheetCore;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

constructor TPersonaleScheda.Create(aOwner: TComponent);
begin
  inherited;
  FIsDebug := false;
  DisableRilevamentoFieldChanged := false;
  LastData := 0; // il test viene fatto su idProgetto
  LastOraFine := 0; // il test viene fatto su idProgetto

  ReportsManager.AddVariablesProc := procedure(ReportsManager: TzReportsManager)
    var
      Master: TDataSet;
      idPersonale: integer;
    begin
      Master := getDataSet('Personale');
      idPersonale := Master.FieldByName('ID_PERSONALE').AsInteger;

      common.AssegnaVariabiliTimeReport(ReportsManager, idPersonale, -1, nil);

      ReportsManager.AddVariable('Presenze_Id_Personale', idPersonale);
      ReportsManager.AddVariable('Presenze_Anno', Presenze_AnnoSelezionato);
      ReportsManager.AddVariable('Presenze_Mese', Presenze_MeseSelezionato);
    end;

  // Timesheet: prima della stampa di un modello Timesheet_* si stabilisce l'elenco dei progetti
  // da affiancare al principale (solo per i modelli che hanno colonne o righe per progetto).
  // Il dataset e la testata giusti per il modello sono gia' stati aperti dal gestore stampe
  // (nodo "datasets" del JSON affiancato, applicato in BeforePrint prima di questo callback):
  // qui si riapre SOLO cio' che serve al modello in stampa, mai gli altri cinque dataset del
  // timesheet, altrimenti ogni anteprima ricalcolerebbe anche le due procedure piu' pesanti
  // (TIMESHEET_GIORNI e TIMESHEET_ATTIVITA_X_GIORNO) senza che il modello le usi.
  // Un annullamento della scelta progetti ferma la stampa.
  ReportsManager.BeforePrintProc := function(ReportName: string): Boolean
    var
      NomeModello: string;
      Elenco: string;
    begin
      result := True;

      NomeModello := TimesheetNomeModello(ReportName);
      if not NomeModello.StartsWith('Timesheet_', True) then
        exit;

      Elenco := '';
      if TimesheetModelloConColonneProgetto(NomeModello) then
        if not TimesheetScegliProgettiColonne(Elenco) then
          exit(False);

      TimesheetImpostaElencoProgetti(NomeModello, Elenco);
    end;

  // Timesheet: a foglio costruito si nascondono le colonne che il mese o la scelta dei progetti
  // non usano (i modelli hanno colonne fisse: otto per i progetti, trentuno per i giorni)
  ReportsManager.ExcelAfterBuild := procedure(FileName: string; dxSpreadSheet: TdxSpreadSheet)
    begin
      TimesheetNascondiColonne(TimesheetNomeModello(FileName), dxSpreadSheet);
    end;
end;

procedure TPersonaleScheda.AfterCreateDataSet(const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'Personale') then
  begin
    DataSet.BeforeOpen := PersonaleBeforeOpen;
  end
  else
    if SameText(DataSetName, 'Personale_Rilevamento_Ore') then
    begin
      SetColorsSrc.DataSet := DataSet;

      DataSet.OnAfterCreateFields := RilevamentiOreAfterCreateFields;
      DataSet.OnNewRecord := RilevamentiNewRecord;
      DataSet.OnCalcFields := RilevamentiOreCalcFields;
      DataSet.AfterPost := PersonaleRilevamentoOreAfterPost;
    end
    else
      if SameText(DataSetName, 'Ore_Rilevate_Elenco') then
      begin
        DataSet.OnAfterCreateFields := RilevamentiOreAfterCreateFields;
        DataSet.OnNewRecord := RilevamentiNewRecord;
        DataSet.OnCalcFields := RilevamentiOreCalcFields;

        DataSet.AfterPost := Ore_Rilevate_ElencoAggiornaIncarico;
        DataSet.AfterDelete := Ore_Rilevate_ElencoAggiornaIncarico;
      end
      else
        if SameText(DataSetName, 'Timesheet_Elenco_Progetti_X_Risorsa') then
          DataSet.AfterOpen := TimeSheetProgettiAfterOpen
        else
          // dettagli del timesheet: ricevono risorsa, anno, mese ed elenco progetti in BeforeOpen
          if SameText(DataSetName, 'Timesheet_Intestazione') or
             SameText(DataSetName, 'Timesheet_Giorni') or
             SameText(DataSetName, 'Timesheet_Giorni_Lavorati') or
             SameText(DataSetName, 'Timesheet_Attivita_X_Giorno') or
             SameText(DataSetName, 'Timesheet_Riepilogo_Annuale') or
             SameText(DataSetName, 'Timesheet_Rilevamenti') then
            DataSet.BeforeOpen := TimeSheetDetailsBeforeOpen;
end;

procedure TPersonaleScheda.RilevamentiOreAfterCreateFields(DataSet: TDataSet);
var
  Field: TField;
begin
  DataSet.CreateCalculatedField(TBooleanField, 'RILEVAMENTO_ORE_EXTRA_REGISTRO');

  Field := DataSet.FindField('ID_PROGETTO');
  if assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;

  Field := DataSet.FindField('DATA');
  if assigned(Field) then
    Field.OnChange := RilevamentoDataChanged;

  Field := DataSet.FindField('ORA_INIZIO');
  if assigned(Field) then
    Field.OnChange := RilevamentoNumeroOreChanged;

  Field := DataSet.FindField('ORA_FINE');
  if assigned(Field) then
    Field.OnChange := RilevamentoNumeroOreChanged;

  Field := DataSet.FindField('TIPO_INCARICO');
  if assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;

  Field := DataSet.FindField('ID_PIANO_PERSONALIZZATO');
  if assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;

  Field := DataSet.FindField('SERVIZIO_EROGATO');
  if assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;

  Field := DataSet.FindField('MATERIA');
  if assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;

  Field := DataSet.FindField('ID_INCARICO');
  if assigned(Field) then
    Field.OnChange := RilevamentoFieldChanged;
end;

procedure TPersonaleScheda.PersonaleRilevamentoOreAfterPost(DataSet: TDataSet);
begin
  LastData := DateOf(DataSet.FieldByName('DATA').AsDateTime);
  LastOraFine := TimeOf(DataSet.FieldByName('ORA_FINE').AsDateTime);

  if HourOf(LastOraFine) >= 23 then
    LastOraFine := EncodeTime(07, 00, 00, 00);
end;

procedure TPersonaleScheda.RilevamentoDataChanged(Sender: TField);
begin
  if DateOf(Sender.AsDateTime) > Date then
    raise exception.Create('Data non valida.');

  GetDettagliPresenza(Sender.DataSet);
end;

procedure TPersonaleScheda.GetDettagliPresenza(DataSet: TDataSet);
var
  sp: TSP_INCARICHI_GET_PRESENZE;
  // DataSet: TzFbDataSet;
  idPersonale, idProgetto, idCorso, Tipo_Incarico, idPianoPersonalizzato, ServizioErogato, Materia, IdIncarico, Data, OraInizio, OraFine: TField;
begin
  // Personale_Rilevamento_Ore := getDataSet('Personale_Rilevamento_Ore');

  idPersonale := DataSet.FindField('ID_RISORSA'); // l'originale incaricato
  idProgetto := DataSet.FindField('ID_PROGETTO');
  idCorso := DataSet.FindField('ID_CORSO');
  Tipo_Incarico := DataSet.FindField('TIPO_INCARICO');
  idPianoPersonalizzato := DataSet.FindField('ID_PIANO_PERSONALIZZATO');
  ServizioErogato := DataSet.FindField('SERVIZIO_EROGATO');
  Materia := DataSet.FindField('MATERIA');
  IdIncarico := DataSet.FindField('ID_INCARICO');
  Data := DataSet.FindField('DATA');
  OraInizio := DataSet.FindField('ORA_INIZIO');
  OraFine := DataSet.FindField('ORA_FINE');

  if not idPersonale.IsNull then
    if not idProgetto.IsNull then
      if not Tipo_Incarico.IsNull then
        if not Data.IsNull then
          if not OraInizio.IsNull then
            if not OraFine.IsNull then
            begin

              sp := TSP_INCARICHI_GET_PRESENZE.Create(WriteTrans);
              try
                sp.Id_Personale := idPersonale.Value;
                sp.Id_Progetto := idProgetto.Value;
                sp.Tipo_Incarico := Tipo_Incarico.Value;

                if idCorso.IsNull then
                  sp.Id_Corso.Clear
                else
                  sp.Id_Corso := idCorso.Value;

                if idPianoPersonalizzato.IsNull then
                  sp.Id_Piano_Personalizzato.Clear
                else
                  sp.Id_Piano_Personalizzato := idPianoPersonalizzato.Value;

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

                TzFbDataSet(DataSet).CheckEditMode;
                DataSet.FieldByName('ID_PRESENZA_PERSONALE').Value := sp.Id_Presenza_Personale;
                DataSet.FieldByName('DATA_PRESENZA').Value := sp.Data_Presenza;
                DataSet.FieldByName('ORA_ENTRATA').Value := sp.Ora_Entrata;
                DataSet.FieldByName('ORA_USCITA').Value := sp.Ora_Uscita;
                DataSet.FieldByName('TIPO_RILEVAMENTO').Value := sp.Tipo_Rilevamento;
                DataSet.FieldByName('ID_INCARICO').Value := sp.Id_Incarico;
                DataSet.FieldByName('TOTALE_ORE_ATTRIBUITE').Value := sp.Totale_Ore_Attribuite;
                DataSet.FieldByName('TOTALE_ORE_RESIDUE').Value := sp.Totale_Ore_Residue;
                DataSet.FieldByName('DATA_INIZIO_INCARICO').Value := sp.Data_Inizio_Incarico;
                DataSet.FieldByName('DATA_FINE_INCARICO').Value := sp.Data_Fine_Incarico;
              finally
                FreeAndNil(sp);
              end;
            end;
end;

procedure TPersonaleScheda.RilevamentoNumeroOreChanged(Sender: TField);
var
  OraInizio, OraFine, Ore: TField;
  m: integer;
begin
  OraInizio := Sender.DataSet.FindField('ORA_INIZIO');
  OraFine := Sender.DataSet.FindField('ORA_FINE');
  Ore := Sender.DataSet.FindField('ORE');

  if assigned(OraInizio) then
    if assigned(OraFine) then
      if assigned(Ore) then
      begin
        if not(OraInizio.IsNull or OraFine.IsNull) then
          if OraInizio.Value >= OraFine.Value then
            raise exception.Create('Intevallo orario non valido.');

        if OraInizio.IsNull or OraFine.IsNull then
          Ore.Clear
        else
        begin
          m := MinutesBetween(OraInizio.AsDateTime, OraFine.AsDateTime);
          Ore.Value := trunc((m / 60) * 100) / 100;
        end;
      end;

  GetDettagliPresenza(Sender.DataSet);
end;

procedure TPersonaleScheda.RilevamentoFieldChanged(Sender: TField);
begin
  if DisableRilevamentoFieldChanged then
    exit;

  DisableRilevamentoFieldChanged := true;
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

    GetDettagliPresenza(Sender.DataSet);
  finally
    DisableRilevamentoFieldChanged := false;
  end;
end;

procedure TPersonaleScheda.RilevamentiOreCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('RILEVAMENTO_ORE_EXTRA_REGISTRO').Value := true;
end;

procedure TPersonaleScheda.RilevamentiNewRecord(DataSet: TDataSet);
var
  Master: TDataSet;
begin
  Master := getDataSet('Personale');

  DataSet.FieldByName('ID_RISORSA').AsInteger := Master.FieldByName('ID_PERSONALE').AsInteger;
  DataSet.FieldByName('ID_RILEVATORE').AsInteger := Master.FieldByName('ID_PERSONALE').AsInteger;

  if LastData <> 0 then
  begin
    DataSet.FieldByName('DATA').AsDateTime := LastData;
    DataSet.FieldByName('ORA_INIZIO').AsDateTime := LastOraFine;
  end;

  common.FocusField(DataSet.FieldByName('DATA'));
end;

function TPersonaleScheda.GeneraRilevamentoDaOraLibera: Boolean;
var
  Master, Incarichi, OreLibere, Rilevamenti: TzFbDataSet;
begin
  result := false;

  Incarichi := getDataSet('Personale_Incarichi');
  OreLibere := getDataSet('Personale_Presenze_Libere');
  Rilevamenti := getDataSet('Ore_Rilevate_Elenco');

  if OreLibere.IsEmpty then
    exit;

  Rilevamenti.Append;
  Rilevamenti.FieldByName('DATA').AsDateTime := OreLibere.FieldByName('DATA_PRESENZA').AsDateTime;
  Rilevamenti.FieldByName('ORA_INIZIO').AsDateTime := OreLibere.FieldByName('DALLE_ORE').AsDateTime;
  Rilevamenti.FieldByName('ORA_FINE').AsDateTime := OreLibere.FieldByName('ALLE_ORE').AsDateTime;

  Rilevamenti.FieldByName('ORE').ReadOnly := false;
  Rilevamenti.FieldByName('ORE').AsFloat := OreLibere.FieldByName('ORE_LIBERE').AsFloat;

  Rilevamenti.FieldByName('ID_PROGETTO').AsInteger := Incarichi.FieldByName('ID_PROGETTO').AsInteger;
  // Rilevamenti.FieldByName('ID_CORSO').Value := Incarichi.FieldByName('ID_CORSO').Value;
  Rilevamenti.FieldByName('TIPO_INCARICO').AsString := Incarichi.FieldByName('TIPO_INCARICO').AsString;
  Rilevamenti.FieldByName('MATERIA').Value := Incarichi.FieldByName('MATERIA').Value;
  Rilevamenti.FieldByName('ID_INCARICO').AsInteger := Incarichi.FieldByName('ID_INCARICO').AsInteger;
  Rilevamenti.FieldByName('TOTALE_ORE_ATTRIBUITE').AsFloat := Incarichi.FieldByName('TOTALE_ORE_ATTRIBUITE').AsFloat;
  Rilevamenti.FieldByName('DATA_INIZIO_INCARICO').AsDateTime := Incarichi.FieldByName('DATA_INIZIO_INCARICO').AsDateTime;
  Rilevamenti.FieldByName('DATA_FINE_INCARICO').AsDateTime := Incarichi.FieldByName('DATA_FINE_INCARICO').AsDateTime;
  Rilevamenti.FieldByName('PIANI_PERSONALIZZATI').AsBoolean := Incarichi.FieldByName('PIANI_PERSONALIZZATI').AsBoolean;
  // Presenza
  Rilevamenti.FieldByName('ID_PRESENZA_PERSONALE').AsInteger := OreLibere.FieldByName('ID_PRESENZA_PERSONALE').AsInteger;
  Rilevamenti.FieldByName('DATA_PRESENZA').AsDateTime := OreLibere.FieldByName('DATA_PRESENZA').AsDateTime;
  Rilevamenti.FieldByName('ORA_ENTRATA').AsDateTime := OreLibere.FieldByName('ORA_ENTRATA').AsDateTime;
  Rilevamenti.FieldByName('ORA_USCITA').AsDateTime := OreLibere.FieldByName('ORA_USCITA').AsDateTime;
  //
  // il post lo farà la card

  result := true;
end;

procedure TPersonaleScheda.Ore_Rilevate_ElencoAggiornaIncarico(DataSet: TDataSet);
var
  Incarichi: TzFbDataSet;
begin
  Incarichi := getDataSet('Personale_Incarichi');
  Incarichi.RefreshRecord(false);
  ReopenDataSet('Personale_Presenze_Libere');
end;

function TPersonaleScheda.Presenze_AnnoSelezionato: string;
var
  DataSet: TzFbDataSet;
begin
  result := '0000/0000';

  DataSet := getDataSet('Personale_Presenze');

  if not DataSet.ParamByName('ANNO').IsNull then
    result := DataSet.ParamByName('ANNO').AsString;
end;

function TPersonaleScheda.Presenze_MeseSelezionato: integer;
var
  DataSet: TzFbDataSet;
  mese: integer;
begin
  result := -1;

  DataSet := getDataSet('Personale_Presenze');

  if not DataSet.ParamByName('MESE').IsNull then
    result := DataSet.ParamByName('MESE').AsInteger;
end;

procedure TPersonaleScheda.SetColorsSrcDataChange(Sender: TObject; Field: TField);
var
  DataSet: TDataSet;
  Required: Boolean;
begin
  inherited;

  DataSet := getDataSet('Personale_Rilevamento_Ore');

  if assigned(DataSet) then
  begin
    Required := DataSet.FieldByName('PIANI_PERSONALIZZATI').AsBoolean AND DataSet.FieldByName('VERIFICA_PIP').AsBoolean;
    DataSet.FieldByName('ID_PIANO_PERSONALIZZATO').Required := Required;
    DataSet.FieldByName('SERVIZIO_EROGATO').Required := Required;

    Required := SameText(DataSet.FieldByName('TIPO_INCARICO').AsString, 'Docenza') and (DataSet.FieldByName('RENDICONTAZIONE_MATERIE').AsBoolean = true);
    DataSet.FieldByName('MATERIA').Required := Required;
  end;
end;

function TPersonaleScheda.IdRisorsa: integer;
var
  Master: TzFbDataSet;
begin
  Master := getDataSet('Personale');
  result := Master.FieldByName('ID_PERSONALE').AsInteger;
end;

procedure TPersonaleScheda.TimeSheetDetailsBeforeOpen(DataSet: TDataSet);
var
  Master, Detail: TzFbDataSet;

  procedure AssegnaParametro(const NomeParametro: string; const Valore: Variant);
  begin
    // ogni dataset del timesheet ha solo alcuni di questi parametri
    if Detail.Params.FindParam(NomeParametro) <> nil then
      Detail.ParamByName(NomeParametro).Value := Valore;
  end;

begin
  Master := getDataSet('Timesheet_Elenco_Progetti_X_Risorsa');
  Detail := DataSet as TzFbDataSet;

  AssegnaParametro('ID_RISORSA', IdRisorsa);
  AssegnaParametro('ANNO', Master.ParamByName('ANNO').Value);
  AssegnaParametro('MESE', Master.ParamByName('MESE').Value);

  if ElencoProgettiColonne = '' then
    AssegnaParametro('ELENCO_PROGETTI', Null)
  else
    AssegnaParametro('ELENCO_PROGETTI', ElencoProgettiColonne);
end;

procedure TPersonaleScheda.TimeSheetProgettiAfterOpen(DataSet: TDataSet);
begin
  ReopenDataSet('Timesheet_Intestazione');
  ReopenDataSet('Timesheet_Giorni');
  ReopenDataSet('Timesheet_Giorni_Lavorati');
  ReopenDataSet('Timesheet_Attivita_X_Giorno');
  ReopenDataSet('Timesheet_Riepilogo_Annuale');
  ReopenDataSet('Timesheet_Rilevamenti');
end;

function TPersonaleScheda.TimesheetNomeModello(const ReportName: string): string;
begin
  // il gestore stampe passa a volte il nome del report, a volte il percorso completo del modello
  result := ChangeFileExt(ExtractFileName(ReportName), '');
end;

function TPersonaleScheda.TimesheetModelloConColonneProgetto(const NomeModello: string): Boolean;
begin
  // modelli che hanno una colonna (Network) o una riga (ministeriale) per ogni progetto scelto
  result := SameText(NomeModello, 'Timesheet_Giorni_Multiprogetto') or
            SameText(NomeModello, 'Timesheet_Attivita_X_Giorno');
end;

function TPersonaleScheda.TimesheetScegliProgettiColonne(out Elenco: string): Boolean;
const
  MassimoProgetti = 8; // colonne ORE_COL_01..08 delle procedure e dei modelli
var
  Master: TzFbDataSet;
  Conteggio: integer;
  ElencoScelto: string;
begin
  result := false;
  Elenco := '';

  Master := getDataSet('Timesheet_Elenco_Progetti_X_Risorsa');
  if Master.IsEmpty then
    exit;

  // progetti con ore rilevate nel mese dalla persona, escluso quello in stampa
  lkProgettiColonne.RevertSQL(false);
  lkProgettiColonne.ParamByName('ID_RISORSA').AsInteger := IdRisorsa;
  lkProgettiColonne.ParamByName('ID_PROGETTO').Value := Master.FieldByName('ID_PROGETTO').Value;
  lkProgettiColonne.ParamByName('ANNO').Value := Master.ParamByName('ANNO').Value;
  lkProgettiColonne.ParamByName('MESE').Value := Master.ParamByName('MESE').Value;
  lkProgettiColonne.Active := True;
  try
    // nessun altro progetto con ore nel mese: niente da scegliere, si stampa il solo progetto principale
    if lkProgettiColonne.IsEmpty then
      exit(True);

    Conteggio := 0;
    ElencoScelto := '';

    result := dlgProgettiColonne.Execute(
      procedure
      begin
        // chiamata una volta per ogni riga selezionata, con il dataset posizionato sulla riga
        if Conteggio >= MassimoProgetti then
          exit;

        if ElencoScelto <> '' then
          ElencoScelto := ElencoScelto + ',';
        ElencoScelto := ElencoScelto + lkProgettiColonne.FieldByName('ID_PROGETTO').AsString;
        Inc(Conteggio);
      end);

    if result then
      Elenco := ElencoScelto;
  finally
    lkProgettiColonne.Active := false;
  end;
end;

procedure TPersonaleScheda.TimesheetImpostaElencoProgetti(const NomeModello, Elenco: string);
begin
  // stesso elenco di prima (tipico: entrambi vuoti, sui cinque modelli senza colonne
  // per progetto): niente da riaprire, la vista ha gia' i dataset del timesheet allineati
  // al mese corrente
  if ElencoProgettiColonne = Elenco then
    exit;

  ElencoProgettiColonne := Elenco;

  // solo il dataset che il modello in stampa usa davvero (letto in TimeSheetDetailsBeforeOpen);
  // gli altri quattro dataset del timesheet non dipendono dall'elenco progetti per i loro modelli
  if SameText(NomeModello, 'Timesheet_Giorni_Multiprogetto') then
  begin
    ReopenDataSet('Timesheet_Intestazione');
    ReopenDataSet('Timesheet_Giorni');
  end
  else
    if SameText(NomeModello, 'Timesheet_Attivita_X_Giorno') then
    begin
      ReopenDataSet('Timesheet_Intestazione');
      ReopenDataSet('Timesheet_Attivita_X_Giorno');
    end;
end;

procedure TPersonaleScheda.TimesheetNascondiColonne(const NomeModello: string; dxSpreadSheet: TdxSpreadSheet);
const
  // indici di colonna (base zero) dei modelli generati: D = 3
  PrimaColonnaProgetto = 3;  // Timesheet_Giorni_Multiprogetto: colonne D..K
  UltimaColonnaProgetto = 10;
  PrimaColonnaGiorno = 3;    // Timesheet_Attivita_X_Giorno: colonne D..AH
  UltimaColonnaGiorno = 33;
var
  Intestazione: TzFbDataSet;
  Tabella: TdxSpreadSheetTableView;
  DaColonna, AColonna, Indice: integer;
begin
  Intestazione := FindDataSet('Timesheet_Intestazione');
  if not assigned(Intestazione) or not Intestazione.Active or Intestazione.IsEmpty then
    exit;

  if SameText(NomeModello, 'Timesheet_Giorni_Multiprogetto') then
  begin
    DaColonna := PrimaColonnaProgetto + Intestazione.FieldByName('NUMERO_COLONNE_PROGETTO').AsInteger;
    AColonna := UltimaColonnaProgetto;
  end
  else
    if SameText(NomeModello, 'Timesheet_Attivita_X_Giorno') then
    begin
      DaColonna := PrimaColonnaGiorno + Intestazione.FieldByName('GIORNI_NEL_MESE').AsInteger;
      AColonna := UltimaColonnaGiorno;
    end
    else
      exit;

  if DaColonna > AColonna then
    exit;

  Tabella := dxSpreadSheet.ActiveSheetAsTable;
  Tabella.BeginUpdate;
  try
    for Indice := DaColonna to AColonna do
    begin
      // la colonna esiste come oggetto solo se ha celle: va creata prima di nasconderla
      if Tabella.Columns[Indice] = nil then
        Tabella.Columns.CreateItem(Indice);
      Tabella.Columns[Indice].Visible := false;
    end;
  finally
    Tabella.EndUpdate;
  end;
end;

function TPersonaleScheda.GeneraRilevamentiMultipli(presenze: TList<integer>): Boolean;
var
  TipoIncarico: String;
  id: integer;
  OreLibere: TzFbDataSet;
  Rilevamenti: TzFbDataSet;
  oldUseSqlLocate: Boolean;
begin
  result := false;

  if presenze.count = 0 then
    exit;

  if not ConfirmYesNo('Si desidere generare i rilevamenti per le presenze selezionate?') then
    exit;

  OreLibere := getDataSet('Personale_Presenze_Libere');
  Rilevamenti := getDataSet('Ore_Rilevate_Elenco');

  StartWait('Attendere...', true);
  try
    oldUseSqlLocate := OreLibere.UseSqlLocate;
    OreLibere.UseSqlLocate := false;
    try

      for id in presenze do
      begin
        if OreLibere.Locate('ID_PRESENZA_LIBERA', id, []) then
        begin
          GeneraRilevamentoDaOraLibera;
          Rilevamenti.CheckBrowseMode;
        end;
      end;
    finally
      OreLibere.UseSqlLocate := oldUseSqlLocate;
      OreLibere.RevertSQL(true);
    end;
  Finally
    StopWait;
  end;
end;

procedure TPersonaleScheda.PersonaleBeforeOpen(DataSet: TDataSet);
begin
  TzFbDataSet(DataSet).ParamByName('IS_DEBUG').AsBoolean := FIsDebug;
end;

procedure TPersonaleScheda.SetIsDebug(const Value: Boolean);
begin
  FIsDebug := Value;
  ReopenDataSet('Personale');
end;

end.

// Caricare le presenze => Struttura
// in SchedulerCustomDrawContent settare ACanvas.Brush.Color := clRed; se presente
