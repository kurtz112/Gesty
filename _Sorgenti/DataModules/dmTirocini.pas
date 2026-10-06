unit dmTirocini;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Actions,
  Vcl.Dialogs,
  Vcl.ActnList,
  Data.DB,
  dxRichEdit.Control,
  QExport4,
  QExport4Xlsx,
  dbMaster,
  Base_DataModule,
  zFbDataSet,
  zDbViewDlg,
  zDbCardDlg,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

type
  TTirocini = class(TBaseDataModule)
    ActionList: TActionList;
    actNuovaAziendaOspitante: TAction;
    dlgPeriodi: TzDbViewDlg;
    QExport4Xlsx: TQExport4Xlsx;
    cardOrario: TzDbCardDlg;
    procedure DataModuleCreate(Sender: TObject);
    procedure actNuovaAziendaOspitanteExecute(Sender: TObject);
    procedure dlgPeriodiInitDialog(Dialog: TzDbViewForm);
    procedure QExport4XlsxBeforeExportRow(Sender: TObject; Row: TQExportRow; var Accept: Boolean);
  private const
    ReportTemplateRegistroStage_NON_UTILIZZATO = 'Registro Stage';
    ReportTemplateRegistroStage = 'Registro Stage';
    ReportRiepilogoIndennita = 'Riepilogo Indennità Tirocinio';
  private
    FAnno_Indennita: integer;
    FMese_Indennita: integer;
    procedure SetAnno_Indennita(const Value: integer);
    procedure SetMese_Indennita(const Value: integer);
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
    procedure AziendeConvenzioinNewRecord(DataSet: TDataSet);
    procedure CalendarioSettimanaleBeforeOpen(DataSet: TDataSet);
    procedure PeriodiRefreshTirocinio(DataSet: TDataSet);
    procedure RendicontazionePresenzeBeforeEdit(DataSet: TDataSet);
    procedure IndennitaMeseBeforeOpen(DataSet: TDataSet);
    procedure lkPeriodiNewRecord(DataSet: TDataSet);
    function GetAziendaOspitante: integer;
    function IdTirocinioSelezionato: integer;
  public
    procedure ConvenzioniNewRecord(DataSet: TDataSet);
    procedure SediOperativeNewRecord(DataSet: TDataSet);
    procedure ContattiNewRecord(DataSet: TDataSet);
  public
    procedure Print(ReportGroup: string; SelectedDataSetName: string); override;
  public
    function NuovaAziendaOspitante: integer;
    function NuovaAziendaOspitantePerProgettoFormativo: integer;
    procedure ModificaPeriodi;
  public
    procedure ApriIndennitaMese;
    procedure ElaboraIndennitaMese;
    procedure EsportaIndennitaMese(const FileName: String);
  public
    property Anno_Indennita: integer read FAnno_Indennita write SetAnno_Indennita;
    property Mese_Indennita: integer read FMese_Indennita write SetMese_Indennita;
  private
    procedure doStampaRegistroStage(FileName: String; dxRichEditControl: TdxRichEditControl);
    procedure doStampaRegistroStageRegione(FileName: String; dxRichEditControl: TdxRichEditControl);
  public type
    TRendicontazioneParams = record
    private
      FDataInizio: TDateTime;
      FOnChanged: TNotifyEvent;
      procedure SetDataInizio(const Value: TDateTime);
    public
      procedure Init(OnChanged: TNotifyEvent);
      procedure Incrementa;
      procedure Decrementa;
      procedure Changed;
      function GetDataFine: TDateTime;
    public
      property DataInizio: TDateTime read FDataInizio write SetDataInizio;
      property OnChanged: TNotifyEvent read FOnChanged;
    end;
  public
    RendicontazioneParams: TRendicontazioneParams;
  private
    procedure AggiornaCalendarioRendicontazione(Sender: TObject);
  public
    procedure GeneraCalendarioStage;
    procedure ApriRendicontazioneTirocinio;
    procedure GeneraPresenze;
    procedure SelezionaPrimoGiornoNonRendicontato;
  public
    procedure CreaUtenteSistemaStudente;
    procedure CreaUtenteSistemaTutor;
  end;

var
  Tirocini: TTirocini;

implementation

uses
  System.Generics.Collections,
  System.DateUtils,
  Vcl.Controls,
  dxRichEdit.NativeApi,
  dxCharacters,
  dxSpreadSheet,
  QExport4Types,
  zOffice.Word.Utils,
  zOffice.Reports,
  WizNuovaAziendaOspitanteFrm,
   
  zBaseLib,
  frmRegistraPresenzeTirocini,
  frmGeneraCalendarioStage,
  Gesty_StoredProcs,
  Gesty.Types,
  zOffice.Excel.Utils,
  dmCommon,
  zMsg,
  zFileSystem,
  ConfigModule;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TTirocini.DataModuleCreate(Sender: TObject);
begin
  inherited;

  FAnno_Indennita := YearOf(Date);
  FMese_Indennita := MonthOf(Date) - 1;
  RendicontazioneParams.Init(AggiornaCalendarioRendicontazione);

  ReportsManager.WordBeforeShow := Procedure(FileName: String; dxRichEditControl: TdxRichEditControl)
    begin
      { TODO : ReportID }
      // if SameText(ReportsManager.ReportId, 'registro_stage_standard') then
      if SameText(FileNameNoExt(FileName), ReportTemplateRegistroStage_NON_UTILIZZATO) then
        doStampaRegistroStage(FileName, dxRichEditControl)
      else
        { TODO : ReportID }
        // if SameText(ReportsManager.ReportId, 'Registro Stage') then
        if FileNameNoExt(FileName).StartsWith(ReportTemplateRegistroStage, true) then
          doStampaRegistroStageRegione(FileName, dxRichEditControl);
    end;

  ReportsManager.ExcelOnGetDataSource := Function(DataSourceName: string): TDataSource
    var
      comp: TComponent;
    begin
      result := nil;

      comp := FindComponent(DataSourceName);
      if assigned(comp) then
        if comp is TDataSource then
          result := comp as TDataSource;
    end;

  ReportsManager.ExcelAfterBuild := Procedure(FileName: String; dxSpreadSheet: TdxSpreadSheet)
    var
      DataSet: TzFbDataSet;
      Titolo: String;
      Params: TExcelExportDataSetParams;
    begin
      { TODO : ReportID }
      // if SameText(ReportsManager.ReportId, 'riepilogo_indennita') then
      if SameText(FileNameNoExt(FileName), ReportRiepilogoIndennita) then
      begin
        // tools.AddFiltroFonteFinanziamento(view, Tirocini.GetDataSet(DataSetName));
        // tools.AddFiltroAnnoSolare(view, Tirocini.GetDataSet(DataSetName));

        DataSet := GetDataSet('RiepilogoIndennita');
        dxSpreadSheet.ClearActiveSheet;

        Params.Init;
        Params.Caption := 'Riepilogo Indennità';
        Params.startRow := 2;
        Params.startCol := 0;
        dxSpreadSheet.ExportDataSet(Params, DataSet);
        // lo fa exportDataset dxSpreadSheet.ApplyBestFit;

        Titolo := '';
        if DataSet.ParamExists('FONTE_FINANZIAMENTO') then
          Titolo := DataSet.ParamByName('FONTE_FINANZIAMENTO').AsString;

        if DataSet.ParamExists('ANNO') then
        begin
          if not Titolo.IsEmpty then
            Titolo := Titolo + ' ';

          Titolo := Titolo + 'Anno ' + DataSet.ParamByName('ANNO').AsString;
        end;

        dxSpreadSheet.SetText(1, 3, Titolo, false);
      end;
    end;
end;

function TTirocini.NuovaAziendaOspitante: integer;
var
  DataSet: TzFbDataSet;
begin
  result := -1;

  result := InserisciNuovaAziendaOspitante;

  // refresh
  if result <> -1 then
  begin
    DataSet := GetDataSet('AziendeOspitanti');
    DataSet.Reopen;

    DataSet := GetDataSet('Progetti_Formativi_Aziende');
    DataSet.Reopen;
  end;
end;

function TTirocini.NuovaAziendaOspitantePerProgettoFormativo: integer;
var
  DataSet: TzFbDataSet;
begin
  result := -1;

  result := InserisciNuovaAziendaOspitante;

  if result <> -1 then
  begin
    DataSet := GetDataSet('AziendeOspitanti');
    DataSet.Reopen;
  end;
end;

procedure TTirocini.actNuovaAziendaOspitanteExecute(Sender: TObject);
begin
  inherited;

  InserisciNuovaAziendaOspitante;
end;

procedure TTirocini.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'Aziende_Convenzioni') then
    DataSet.OnNewRecord := AziendeConvenzioinNewRecord
  else
    if SameText(DataSetName, 'Studenti_Tirocini_Periodi') then
    begin
      DataSet.AfterPost := PeriodiRefreshTirocinio;
      DataSet.AfterDelete := PeriodiRefreshTirocinio;
    end
    else
      if SameText(DataSetName, 'IndennitaMese') then
        DataSet.BeforeOpen := IndennitaMeseBeforeOpen
      else
        if SameText(DataSetName, 'RendicontazioneSettimanale') then
        begin
          DataSet.BeforeOpen := CalendarioSettimanaleBeforeOpen;
          DataSet.BeforeEdit := RendicontazionePresenzeBeforeEdit;
        end;
end;

procedure TTirocini.AziendeConvenzioinNewRecord(DataSet: TDataSet);
var
  Aziende: TzFbDataSet;
begin
  inherited;
  DataSet.FieldByName('ID_ENTE').Value := Common.EnteDefault;

  Aziende := GetDataSet('AziendeOspitanti');
  DataSet.FieldByName('ID_DELEGATO_FIRMA').Value := Aziende.FieldByName('ID_LEGALE_RAPPRESENTANTE').Value;

  if not DataSet.FieldByName('ID_DELEGATO_FIRMA').IsNull then
    DataSet.FieldByName('DELEGATO_FIRMA_QUALIFICA').Value := 'Titolare';
end;

procedure TTirocini.ModificaPeriodi;
var
  Tirocini: TzFbDataSet;
  lkPeriodi: TzFbDataSet;
  ElencoPeriodi: string;
  sp: TSP_STUDENTI_TIROCINI_PERIOD_DETAIL;
begin
  Tirocini := GetDataSet('Tirocini');

  if Tirocini.IsEmpty then
    Exit;

  lkPeriodi := GetDataSet('lkPeriodi');
  lkPeriodi.OnNewRecord := lkPeriodiNewRecord;

  lkPeriodi.RevertSQL(false);
  lkPeriodi.ParamByName('ID_TIROCINIO').AsInteger := Tirocini.FieldByName('ID_TIROCINIO').AsInteger;
  lkPeriodi.Active := true;
  try
    dlgPeriodi.DataSet := lkPeriodi;
    dlgPeriodi.Execute;
  finally
    lkPeriodi.Active := false;
  end;

  sp := TSP_STUDENTI_TIROCINI_PERIOD_DETAIL.Create(WriteTrans);
  try
    sp.id_Tirocinio := Tirocini.FieldByName('ID_TIROCINIO').AsInteger;
    sp.ExecuteWithoutCommit;
    ElencoPeriodi := sp.elenco_periodi;
  finally
    FreeAndNil(sp);
  end;

  Tirocini.CheckEditMode;
  Tirocini.FieldByName('ELENCO_PERIODI').AsString := ElencoPeriodi;
end;

procedure TTirocini.dlgPeriodiInitDialog(Dialog: TzDbViewForm);
begin
  inherited;
  Dialog.OkCancel.OkBtn.Visible := false;
  Dialog.OkCancel.CancelBtn.Caption := 'Chiudi';
end;

procedure TTirocini.QExport4XlsxBeforeExportRow(Sender: TObject; Row: TQExportRow; var Accept: Boolean);
var
  i: integer;
begin
  inherited;

  for i := 0 to Row.Columns.Count - 1 do
    Row.Columns[i].ColType := ectString;
end;

procedure TTirocini.ElaboraIndennitaMese;
var
  sp: TSP_studenti_Tirocini_Inden_Elabora;
begin
  StartWait('Attendere...', true);
  try
    sp := TSP_studenti_Tirocini_Inden_Elabora.Create(WriteTrans);
    try
      sp.Id_Ente := -1;
      sp.Anno := Anno_Indennita;
      sp.Mese := Mese_Indennita;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;
  finally
    StopWait;
  end;

  ApriIndennitaMese;
end;

procedure TTirocini.EsportaIndennitaMese(const FileName: String);
var
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet('IndennitaMese');

  QExport4Xlsx.DataSet := DataSet;
  QExport4Xlsx.FileName := FileName;

  // QExport4Xlsx.ExportedFields.Clear;
  // QExport4Xlsx.ExportedFields.Add('CODICE_FISCALE');

  //
  StartWait('Attendere...', true);
  try
    QExport4Xlsx.Execute;
  finally
    StopWait;
  end;
end;

procedure TTirocini.ApriIndennitaMese;
var
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet('IndennitaMese');

  StartWait('Attendere...', true);
  try
    DataSet.Reopen;
  finally
    StopWait;
  end;
end;

procedure TTirocini.IndennitaMeseBeforeOpen(DataSet: TDataSet);
var
  Indennita: TzFbDataSet;
begin
  Indennita := GetDataSet('IndennitaMese');
  Indennita.ParamByName('ANNO').AsInteger := Anno_Indennita;
  Indennita.ParamByName('MESE').AsInteger := Mese_Indennita;
end;

procedure TTirocini.SetAnno_Indennita(const Value: integer);
begin
  if FAnno_Indennita <> Value then
  begin
    FAnno_Indennita := Value;
    ApriIndennitaMese;
  end;
end;

procedure TTirocini.SetMese_Indennita(const Value: integer);
begin
  if FMese_Indennita <> Value then
  begin
    FMese_Indennita := Value;
    ApriIndennitaMese;
  end;
end;

procedure TTirocini.lkPeriodiNewRecord(DataSet: TDataSet);
var
  Tirocini: TzFbDataSet;
  lkPeriodi: TzFbDataSet;
begin
  // Tirocini Periodi: default data inizio = data fine tirocinio
  Tirocini := GetDataSet('Tirocini');
  lkPeriodi := GetDataSet('lkPeriodi');

  if not Tirocini.FieldByName('DATA_FINE_TIROCINIO').IsNull then
    lkPeriodi.FieldByName('DATA_INIZIO').Value := IncDay(Tirocini.FieldByName('DATA_FINE_TIROCINIO').Value, 1);
end;

procedure TTirocini.PeriodiRefreshTirocinio(DataSet: TDataSet);
var
  Tirocini: TzFbDataSet;
begin
  Tirocini := GetDataSet('Tirocini');
  Tirocini.RefreshRecord(false);
end;

procedure TTirocini.Print(ReportGroup: string; SelectedDataSetName: string);

  function GetExcludeFolders(TipoTirocinio: string): TExcludeFolders;
  var
    idx: integer;
    s: string;
  begin

    idx := 0;

    for s in ['CURRICULARE', 'EXTRACURRICULARE', 'INCLUSIONE', 'FORMAZIONE INTERNA', 'ALTRO'] do
      if not SameText(s, TipoTirocinio) then
      begin
        SetLength(result, idx + 1);
        result[idx] := s;
        Inc(idx);
      end;
  end;

const
  DataSetName = 'Tirocini';

var
  Tirocini: TzFbDataSet;
  TipoTirocinio: string;
begin
  Tirocini := GetDataSet(DataSetName);

  ReportsManager.ExcludeFolders := [];

  if not Tirocini.IsEmpty then
  begin
    TipoTirocinio := TTipoTirocinio.FromString(Tirocini.FieldByName('TIPO_TIROCINIO').AsString).Description;
    ReportsManager.ExcludeFolders := GetExcludeFolders(TipoTirocinio);
  end;

  inherited Print(ReportGroup, DataSetName);
end;

procedure TTirocini.ContattiNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('ID_AZIENDA').AsInteger := GetAziendaOspitante;
end;

procedure TTirocini.SediOperativeNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('ID_AZIENDA').AsInteger := GetAziendaOspitante;
end;

procedure TTirocini.ConvenzioniNewRecord(DataSet: TDataSet);

  function GetLegaleRappresentante(const IdAzienda: integer): integer;
  var
    sp: TSP_AZIENDE_GET_LEGALE_RAPPRESENT;
  begin
    if IdAzienda = -1 then
    begin
      result := -1;
      Exit;
    end;

    sp := TSP_AZIENDE_GET_LEGALE_RAPPRESENT.Create(WriteTrans);
    try
      sp.id_Azienda := IdAzienda;
      sp.ExecuteAndCommit;
      result := sp.id_Legale_Rappresentante;
    finally
      FreeAndNil(sp);
    end;
  end;

var
  idLegaleRappresentante: integer;
begin
  inherited;

  DataSet.FieldByName('ID_AZIENDA').AsInteger := GetAziendaOspitante;
  DataSet.FieldByName('ID_ENTE').Value := Common.EnteDefault;

  idLegaleRappresentante := GetLegaleRappresentante(GetAziendaOspitante);

  if idLegaleRappresentante <> -1 then
  begin
    DataSet.FieldByName('ID_DELEGATO_FIRMA').AsInteger := idLegaleRappresentante;

    if not DataSet.FieldByName('ID_DELEGATO_FIRMA').IsNull then
      DataSet.FieldByName('DELEGATO_FIRMA_QUALIFICA').Value := 'Titolare';
  end;
end;

function TTirocini.GetAziendaOspitante: integer;
const
  DataSetName = 'Tirocini';
var
  Tirocini: TzFbDataSet;
begin
  result := -1;

  Tirocini := GetDataSet(DataSetName);

  if not Tirocini.IsEmpty then
    if not Tirocini.FieldByName('ID_AZIENDA_OSPITANTE').IsNull then
      result := Tirocini.FieldByName('ID_AZIENDA_OSPITANTE').AsInteger;
end;

procedure TTirocini.GeneraCalendarioStage;
var
  Tirocini: TzFbDataSet;
  Params: TGeneraCalendarioStageParams;
  sp: TSP_STUDENTI_TIROCINI_GENERA_CALEND;
  generaDatasetFunc: TFunc<TComponent, TzFbDataSet>;
begin
  Tirocini := GetDataSet('Tirocini');

  if Tirocini.IsEmpty then
  begin
    ConfirmOk('Nessun tirocinio selezionato.');
    Exit;
  end;

  generaDatasetFunc := function(owner: TComponent): TzFbDataSet
    var
      template: TzFbDataSet;
    begin
      template := GetDataSet('lkContenuti_Template');
      result := CreateFbDataSet(owner, Config.Database, ReadTrans, WriteTrans);
      result.SQL_Select.Text := template.SQL_Select.Text;
      result.Prepare;
      result.ParamByName('ID_TIROCINIO').Value := Tirocini.FieldByName('ID_TIROCINIO').Value;
    end;

  Params.Init;
  Params.DalGiorno := Tirocini.FieldByName('DATA_INIZIO_TIROCINIO').AsDateTime;
  Params.AlGiorno := Tirocini.FieldByName('DATA_FINE_TIROCINIO').AsDateTime;

  if not GeneraDateCalendarioStage(Params, generaDatasetFunc) then
    Exit;

  StartWait('Attendere...');
  try
    sp := TSP_STUDENTI_TIROCINI_GENERA_CALEND.Create(WriteTrans);
    try
      sp.id_Tirocinio := Tirocini.FieldByName('ID_TIROCINIO').AsInteger;
      sp.DAL_GIORNO := Params.DalGiorno;
      sp.AL_GIORNO := Params.AlGiorno;
      sp.LUNEDI := Params.LUNEDI;
      sp.MARTEDI := Params.MARTEDI;
      sp.MERCOLEDI := Params.MERCOLEDI;
      sp.GIOVEDI := Params.GIOVEDI;
      sp.VENERDI := Params.VENERDI;
      sp.SABATO := Params.SABATO;
      sp.DOMENICA := Params.DOMENICA;
      sp.GENERA_ORARIO := Params.Orario;

      sp.ORA_INIZIO_1_LUNEDI := Params.OraInizio1_LUNEDI;
      sp.ORA_FINE_1_LUNEDI := Params.OraFine1_LUNEDI;
      sp.CONTENUTI_1_LUNEDI := Params.Contenuti1_LUNEDI;
      sp.ORA_INIZIO_2_LUNEDI := Params.OraInizio2_LUNEDI;
      sp.ORA_FINE_2_LUNEDI := Params.OraFine2_LUNEDI;
      sp.CONTENUTI_2_LUNEDI := Params.Contenuti2_LUNEDI;
      sp.ORA_INIZIO_3_LUNEDI := Params.OraInizio3_LUNEDI;
      sp.ORA_FINE_3_LUNEDI := Params.OraFine3_LUNEDI;
      sp.CONTENUTI_3_LUNEDI := Params.Contenuti3_LUNEDI;
      sp.ORA_INIZIO_1_MARTEDI := Params.OraInizio1_MARTEDI;
      sp.ORA_FINE_1_MARTEDI := Params.OraFine1_MARTEDI;
      sp.CONTENUTI_1_MARTEDI := Params.Contenuti1_MARTEDI;
      sp.ORA_INIZIO_2_MARTEDI := Params.OraInizio2_MARTEDI;
      sp.ORA_FINE_2_MARTEDI := Params.OraFine2_MARTEDI;
      sp.CONTENUTI_2_MARTEDI := Params.Contenuti2_MARTEDI;
      sp.ORA_INIZIO_3_MARTEDI := Params.OraInizio3_MARTEDI;
      sp.ORA_FINE_3_MARTEDI := Params.OraFine3_MARTEDI;
      sp.CONTENUTI_3_MARTEDI := Params.Contenuti3_MARTEDI;
      sp.ORA_INIZIO_1_MERCOLEDI := Params.OraInizio1_MERCOLEDI;
      sp.ORA_FINE_1_MERCOLEDI := Params.OraFine1_MERCOLEDI;
      sp.CONTENUTI_1_MERCOLEDI := Params.Contenuti1_MERCOLEDI;
      sp.ORA_INIZIO_2_MERCOLEDI := Params.OraInizio2_MERCOLEDI;
      sp.ORA_FINE_2_MERCOLEDI := Params.OraFine2_MERCOLEDI;
      sp.CONTENUTI_2_MERCOLEDI := Params.Contenuti2_MERCOLEDI;
      sp.ORA_INIZIO_3_MERCOLEDI := Params.OraInizio3_MERCOLEDI;
      sp.ORA_FINE_3_MERCOLEDI := Params.OraFine3_MERCOLEDI;
      sp.CONTENUTI_3_MERCOLEDI := Params.Contenuti3_MERCOLEDI;
      sp.ORA_INIZIO_1_GIOVEDI := Params.OraInizio1_GIOVEDI;
      sp.ORA_FINE_1_GIOVEDI := Params.OraFine1_GIOVEDI;
      sp.CONTENUTI_1_GIOVEDI := Params.Contenuti1_GIOVEDI;
      sp.ORA_INIZIO_2_GIOVEDI := Params.OraInizio2_GIOVEDI;
      sp.ORA_FINE_2_GIOVEDI := Params.OraFine2_GIOVEDI;
      sp.CONTENUTI_2_GIOVEDI := Params.Contenuti2_GIOVEDI;
      sp.ORA_INIZIO_3_GIOVEDI := Params.OraInizio3_GIOVEDI;
      sp.ORA_FINE_3_GIOVEDI := Params.OraFine3_GIOVEDI;
      sp.CONTENUTI_3_GIOVEDI := Params.Contenuti3_GIOVEDI;
      sp.ORA_INIZIO_1_VENERDI := Params.OraInizio1_VENERDI;
      sp.ORA_FINE_1_VENERDI := Params.OraFine1_VENERDI;
      sp.CONTENUTI_1_VENERDI := Params.Contenuti1_VENERDI;
      sp.ORA_INIZIO_2_VENERDI := Params.OraInizio2_VENERDI;
      sp.ORA_FINE_2_VENERDI := Params.OraFine2_VENERDI;
      sp.CONTENUTI_2_VENERDI := Params.Contenuti2_VENERDI;
      sp.ORA_INIZIO_3_VENERDI := Params.OraInizio3_VENERDI;
      sp.ORA_FINE_3_VENERDI := Params.OraFine3_VENERDI;
      sp.CONTENUTI_3_VENERDI := Params.Contenuti3_VENERDI;
      sp.ORA_INIZIO_1_SABATO := Params.OraInizio1_SABATO;
      sp.ORA_FINE_1_SABATO := Params.OraFine1_SABATO;
      sp.CONTENUTI_1_SABATO := Params.Contenuti1_SABATO;
      sp.ORA_INIZIO_2_SABATO := Params.OraInizio2_SABATO;
      sp.ORA_FINE_2_SABATO := Params.OraFine2_SABATO;
      sp.CONTENUTI_2_SABATO := Params.Contenuti2_SABATO;
      sp.ORA_INIZIO_3_SABATO := Params.OraInizio3_SABATO;
      sp.ORA_FINE_3_SABATO := Params.OraFine3_SABATO;
      sp.CONTENUTI_3_SABATO := Params.Contenuti3_SABATO;
      sp.ORA_INIZIO_1_DOMENICA := Params.OraInizio1_DOMENICA;
      sp.ORA_FINE_1_DOMENICA := Params.OraFine1_DOMENICA;
      sp.CONTENUTI_1_DOMENICA := Params.Contenuti1_DOMENICA;
      sp.ORA_INIZIO_2_DOMENICA := Params.OraInizio2_DOMENICA;
      sp.ORA_FINE_2_DOMENICA := Params.OraFine2_DOMENICA;
      sp.CONTENUTI_2_DOMENICA := Params.Contenuti2_DOMENICA;
      sp.ORA_INIZIO_3_DOMENICA := Params.OraInizio3_DOMENICA;
      sp.ORA_FINE_3_DOMENICA := Params.OraFine3_DOMENICA;
      sp.CONTENUTI_3_DOMENICA := Params.Contenuti3_DOMENICA;

      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    ReopenDataSet('Studenti_Tirocini_Calend_Stage');
  finally
    StopWait;
  end;
end;

procedure TTirocini.ApriRendicontazioneTirocinio;
begin
  ApriRegistraPresenzeTirocini;
  ReopenDataSet('Presenze');
end;

procedure TTirocini.CalendarioSettimanaleBeforeOpen(DataSet: TDataSet);
var
  Settimanale: TzFbDataSet;
begin
  Settimanale := GetDataSet('RendicontazioneSettimanale');
  Settimanale.ParamByName('ID_TIROCINIO').AsInteger := IdTirocinioSelezionato;
  Settimanale.ParamByName('DAL_GIORNO').AsDate := RendicontazioneParams.DataInizio;
  Settimanale.ParamByName('AL_GIORNO').AsDate := RendicontazioneParams.GetDataFine();
end;

procedure TTirocini.AggiornaCalendarioRendicontazione(Sender: TObject);
var
  Settimana: TzFbDataSet;
  Presenze: TzFbDataSet;
begin
  Settimana := GetDataSet('RendicontazioneSettimanale');
  Presenze := GetDataSet('RendicontazioneSettimanaleDettaglio');

  StartWait('Attendere...', true);
  try
    Settimana.Reopen();
    Presenze.Reopen();
  finally
    StopWait;
  end;
end;

{ TTirocini.TRendicontazioneParams }

procedure TTirocini.TRendicontazioneParams.Init(OnChanged: TNotifyEvent);
begin
  DataInizio := StartOfTheWeek(Date);
  FOnChanged := OnChanged;
end;

procedure TTirocini.TRendicontazioneParams.Changed;
begin
  if assigned(OnChanged) then
    OnChanged(nil);
end;

procedure TTirocini.TRendicontazioneParams.Decrementa;
begin
  FDataInizio := StartOfTheWeek(IncDay(DataInizio, -7));
  Changed;
end;

function TTirocini.TRendicontazioneParams.GetDataFine: TDateTime;
begin
  result := IncDay(DataInizio, +6);
end;

procedure TTirocini.TRendicontazioneParams.Incrementa;
begin
  FDataInizio := StartOfTheWeek(IncDay(DataInizio, +7));
  Changed;
end;

procedure TTirocini.TRendicontazioneParams.SetDataInizio(const Value: TDateTime);
begin
  FDataInizio := Value;
  Changed;
end;

procedure TTirocini.SelezionaPrimoGiornoNonRendicontato;
var
  sp: TSP_STUDENTI_TIROCINI_PRIMO_GG_SCAD;
  Tirocini: TzFbDataSet;
begin
  Tirocini := GetDataSet('Tirocini');
  if Tirocini.IsEmpty then
    Exit;

  sp := TSP_STUDENTI_TIROCINI_PRIMO_GG_SCAD.Create(WriteTrans);
  try
    sp.id_Tirocinio := Tirocini.FieldByName('ID_TIROCINIO').AsInteger;
    sp.ExecuteAndCommit;

    if sp.DATA_PRESENZA.IsNull then
      ConfirmOk('Non risultano date non rilevate per il tirocinio.')
    else
      RendicontazioneParams.DataInizio := sp.DATA_PRESENZA;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TTirocini.GeneraPresenze;
var
  Tirocini: TzFbDataSet;
  sp: TSP_STUDENTI_TIROCINI_GENERA_PRESEN;
begin
  { TODO : Generare in base a params }
  Tirocini := GetDataSet('Tirocini');
  if Tirocini.IsEmpty then
    Exit;

  if not ConfirmYesNo('Si desidera generare le presenze settimanali?' + #13#10#13#10 + 'Attenzione: eventuali rilevamenti preesistenti verranno sovrascritti.') then
    Exit;

  sp := TSP_STUDENTI_TIROCINI_GENERA_PRESEN.Create(WriteTrans);
  try
    sp.id_Tirocinio := Tirocini.FieldByName('ID_TIROCINIO').AsInteger;
    sp.DAL_GIORNO := RendicontazioneParams.DataInizio;
    sp.AL_GIORNO := RendicontazioneParams.GetDataFine;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  ReopenDataSet('RendicontazioneSettimanale');
  ReopenDataSet('RendicontazioneSettimanaleDettaglio');
end;

function TTirocini.IdTirocinioSelezionato: integer;
var
  Tirocini: TzFbDataSet;
begin
  result := -1;

  Tirocini := GetDataSet('Tirocini');

  if not Tirocini.IsEmpty then
    result := Tirocini.FieldByName('ID_TIROCINIO').AsInteger;
end;

procedure TTirocini.RendicontazionePresenzeBeforeEdit(DataSet: TDataSet);
begin
  // se la data è al di fuori dal periodo del tirocinio
  if DataSet.FieldByName('ATTIVA').Value = false then
    abort;
end;

procedure TTirocini.CreaUtenteSistemaStudente;
var
  Tirocini: TzFbDataSet;
  idStudente: integer;
  UserName: String;
begin
  Tirocini := GetDataSet('Tirocini');

  if not assigned(Tirocini) then
    Exit;

  if Tirocini.FieldExists('USER_NAME') then
    if not Tirocini.FieldByName('USER_NAME').IsNull then
    begin
      ConfirmOk('Utente già generato per lo studente selezionato.');
      Exit;
    end;

  idStudente := Tirocini.FieldByName('ID_STUDENTE').AsInteger;
  UserName := Copy(Tirocini.FieldByName('STUDENTE_NOME').AsString, 1, 1) + Tirocini.FieldByName('STUDENTE_COGNOME').AsString;

  if Common.CreaUtenteSistema(UserName, idStudente) then
  begin
    Tirocini.RefreshRecord();
    ConfirmOk('Utente di sistema generato.');
  end;
end;

procedure TTirocini.CreaUtenteSistemaTutor;
var
  Contatti: TzFbDataSet;
  idContatto: integer;
  UserName: String;
begin
  Contatti := GetDataSet('Aziende_Contatti');

  if not assigned(Contatti) then
    Exit;

  if Contatti.FieldExists('USER_NAME') then
    if not Contatti.FieldByName('USER_NAME').IsNull then
    begin
      ConfirmOk('Utente già generato per il contatto selezionato.');
      Exit;
    end;

  idContatto := Contatti.FieldByName('ID_CONTATTO').AsInteger;
  UserName := Common.CalcUserName(Contatti.FieldByName('COGNOME').AsString, Contatti.FieldByName('NOME').AsString);

  if Common.CreaUtenteSistema(UserName, idContatto) then
  begin
    Contatti.RefreshRecord();
    ConfirmOk('Utente di sistema generato.');
  end;
end;

procedure TTirocini.doStampaRegistroStage(FileName: String; dxRichEditControl: TdxRichEditControl);

  function CreateTable(tableZero: IdxRichEditTable): IdxRichEditTable;
  const
    columnsCount = 9;
    rowHeader1 = 0;
    rowHeader2 = 1;
    rowSeparator = 9;
  begin
    result := dxRichEditControl.CreateTable(tableZero.rows.Count, columnsCount);

    dxRichEditControl.CopyTable(tableZero, result);

    result.MergeCells(result.Cell(rowHeader1, 1), result.Cell(rowHeader1, 2)); // Mattino
    result.MergeCells(result.Cell(rowHeader1, 2), result.Cell(rowHeader1, 3)); // Pomeriggio
    result.MergeCells(result.Cell(rowSeparator, 0), result.Cell(rowSeparator, columnsCount - 1)); // separatore

    dxRichEditControl.copyRow(tableZero.rows[rowHeader1], result.rows[rowHeader1]);
    dxRichEditControl.copyRow(tableZero.rows[rowHeader2], result.rows[rowHeader2]);
    dxRichEditControl.copyRow(tableZero.rows[rowSeparator], result.rows[rowSeparator]); // separatore
  end;

  procedure StampaGiornoDisattivo(table: IdxRichEditTable; const Row: integer; const StampaData: Boolean);
  begin

    // Mail Serena 17.09.2024: indicazioni da parte di Regione
    Exit;

    /// //////////////////////////////////////////////////////

    if StampaData then
      dxRichEditControl.SetCellText(table, Row, 0, ''.PadLeft(5, 'X'), false);

    dxRichEditControl.SetCellText(table, Row, 1, ''.PadLeft(3, 'X'), false);
    dxRichEditControl.SetCellText(table, Row, 2, ''.PadLeft(3, 'X'), false);
    dxRichEditControl.SetCellText(table, Row, 3, ''.PadLeft(3, 'X'), false);
    dxRichEditControl.SetCellText(table, Row, 4, ''.PadLeft(3, 'X'), false);
    dxRichEditControl.SetCellText(table, Row, 5, ''.PadLeft(15, 'X'), false);
    dxRichEditControl.SetCellText(table, Row, 6, ''.PadLeft(10, 'X'), false);
    dxRichEditControl.SetCellText(table, Row, 7, ''.PadLeft(10, 'X'), false);
    dxRichEditControl.SetCellText(table, Row, 8, ''.PadLeft(10, 'X'), false);
  end;

  function TimeStr(DateTime: TDateTime): string;
  begin
    result := FormatDateTime('hh:mm', DateTime);
  end;

var
  tableZero: IdxRichEditTable;
  table: IdxRichEditTable;
  DataSet: TzFbDataSet;
  RecNo: integer;
  Row: integer;
  RigheMancanti: integer;
  // Range: IdxRichEditDocumentRange;
  // Paragraph: IdxRichEditParagraph;
begin
  // ReportsManager.SelectedDataSet := GetDataSet('Tirocini');

  DataSet := GetDataSet('Studenti_Tirocini_Calend_Stage');
  DataSet.Active := true; // se viene chiamato da altri nodi

  // dxRichEditControl.LoadDocumentTemplate(FileName, TdxRicheditDocumentFormat.Undefined);

  if dxRichEditControl.Document.Tables.Count = 0 then
    Exit;

  // l'ultima
  table := dxRichEditControl.Document.Tables[dxRichEditControl.Document.Tables.Count - 1];
  tableZero := table;
  dxRichEditControl.Document.CaretPosition := table.Range.&End;

  RecNo := 0;
  Row := 2; // 0 è il titolo

  dxRichEditControl.Document.beginUpdate;
  try
    DataSet.DisableControls;
    try
      DataSet.First;
      while not DataSet.eof do
      begin
        Inc(RecNo);

        if (RecNo = 1) and (Row > 17) then // 14 celle + 2 header + separatore
        begin
          dxRichEditControl.Document.CaretPosition := table.Range.&End;

          // if table <> tableZero then
          dxRichEditControl.NewPage;

          table := CreateTable(tableZero);
          Row := 2;
        end
        else
          if RecNo = 8 then // Separatore tra le 2 settimane
            Inc(Row);

        dxRichEditControl.SetCellText(table, Row, 0, DataSet.FieldByName('DATA_PRESENZA').AsString, false);

        if not DataSet.FieldByName('ORA_INIZIO_1').IsNull then
        begin
          dxRichEditControl.SetCellText(table, Row, 1, TimeStr(DataSet.FieldByName('ORA_INIZIO_1').AsDateTime), false);
          dxRichEditControl.SetCellText(table, Row, 2, TimeStr(DataSet.FieldByName('ORA_FINE_1').AsDateTime), false);
        end;

        if not DataSet.FieldByName('ORA_INIZIO_2').IsNull then
        begin

          dxRichEditControl.SetCellText(table, Row, 3, TimeStr(DataSet.FieldByName('ORA_INIZIO_2').AsDateTime), false);
          dxRichEditControl.SetCellText(table, Row, 4, TimeStr(DataSet.FieldByName('ORA_FINE_2').AsDateTime), false);
        end;

        dxRichEditControl.SetCellText(table, Row, 5, DataSet.FieldByName('CONTENUTI_1').AsString, false);

        // dxRichEditControl.SetCellText(table, Row, 0, Row.ToString + ': rec ' + RecNo.ToString, false);

        if DataSet.FieldByName('ATTIVA').asBoolean = false then
          StampaGiornoDisattivo(table, Row, false);

        DataSet.next; // ------------------------

        if RecNo = 14 then // Nuova Pagina
        begin
          RecNo := 0;
          Inc(Row, 2); // TableHeader
        end;

        Inc(Row);
      end;
    finally
      DataSet.EnableControls;
    end;

    /// ////////////////////////////////////////
    /// riempie fino alla fine della tabella
    while RecNo < 14 do
    begin
      Inc(RecNo);

      if RecNo = 8 then // Separatore tra le 2 settimane
        Inc(Row);

      StampaGiornoDisattivo(table, Row, true);

      Inc(Row);
    end;
  finally
    dxRichEditControl.Document.EndUpdate;
  end;
end;

procedure TTirocini.doStampaRegistroStageRegione(FileName: String; dxRichEditControl: TdxRichEditControl);

  function TimeStr(DateTime: TDateTime): string;
  begin
    result := FormatDateTime('hh:mm', DateTime);
  end;

  procedure FillRow(DataSet: TDataSet; currTable: IdxRichEditTable; const Row: integer);
  var
    Data, OraInizio1, OraFine1, OraInizio2, OraFine2, TotaleOre, Contenuti: string;
  begin
    Data := DataSet.FieldByName('DATA_PRESENZA').AsString;
    OraInizio1 := '';
    OraFine1 := '';
    OraInizio2 := '';
    OraFine2 := '';
    TotaleOre := '';
    Contenuti := '';

    if DataSet.FieldByName('ATTIVA').asBoolean then
    begin

      if not DataSet.FieldByName('ORA_INIZIO_1').IsNull then
      begin
        OraInizio1 := TimeStr(DataSet.FieldByName('ORA_INIZIO_1').AsDateTime);
        OraFine1 := TimeStr(DataSet.FieldByName('ORA_FINE_1').AsDateTime);
      end;

      if not DataSet.FieldByName('ORA_INIZIO_2').IsNull then
      begin
        OraInizio2 := TimeStr(DataSet.FieldByName('ORA_INIZIO_2').AsDateTime);
        OraFine2 := TimeStr(DataSet.FieldByName('ORA_FINE_2').AsDateTime);
      end;

      TotaleOre := FormatFloat('#,##0.00', DataSet.FieldByName('TOTALE_NUMERO_ORE').AsFloat);

      Contenuti := DataSet.FieldByName('CONTENUTI_1').AsString;
      if Contenuti.IsEmpty then
        Contenuti := DataSet.FieldByName('CONTENUTI_2').AsString;
    end;

    /// ////////////////////////////////////////////////////////////////

    dxRichEditControl.SetCellText(currTable, Row, 0, Data, false);
    dxRichEditControl.SetCellText(currTable, Row, 1, OraInizio1, false);
    dxRichEditControl.SetCellText(currTable, Row, 2, OraFine1, false);
    dxRichEditControl.SetCellText(currTable, Row, 4, OraInizio2, false);
    dxRichEditControl.SetCellText(currTable, Row, 5, OraFine2, false);
    dxRichEditControl.SetCellText(currTable, Row, 6, TotaleOre, false);
    dxRichEditControl.SetCellText(currTable, Row, 7, Contenuti, false);
  end;

  procedure DuplicaRiga(table: IdxRichEditTable; const Row: integer);
  begin
    table.rows.InsertAfter(Row - 1);
    dxRichEditControl.copyRow(table.rows[Row - 1], table.rows[Row]);
  end;

var
  table: IdxRichEditTable;
  DataSet: TzFbDataSet;
  Paragraph: IdxRichEditParagraph;
  Row: integer;
begin
  // Pag. {PAGE  \* Arabic  \* MERGEFORMAT} di {NUMPAGES  \* Arabic  \* MERGEFORMAT}
  DataSet := GetDataSet('Studenti_Tirocini_Calend_Stage');
  DataSet.Active := true; // se viene chiamato da altri nodi

  table := dxRichEditControl.Document.Tables[1];
  Row := 2; // 0 è l'header

  dxRichEditControl.Document.beginUpdate;
  try
    DataSet.DisableControls;
    try
      DataSet.First;
      while not DataSet.eof do
      begin

        if not DataSet.Bof then
          DuplicaRiga(table, Row);

        FillRow(DataSet, table, Row);
        DataSet.next; // ------------------------

        Inc(Row);
      end;
    finally
      DataSet.EnableControls;
    end;
  finally
    dxRichEditControl.Document.EndUpdate;
  end;
end;

end.
