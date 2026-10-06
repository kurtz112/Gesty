unit dmQuestionari;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Dialogs,
  Data.DB,
  dxShellDialogs,
  dxSpreadSheet,
  Base_DataModule,
  dbMaster,
  zFbDataSet,
   zProgressBox,
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
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl;

type
  TQuestionari = class(TBaseDataModule)
    SalvaLinkDlg: TdxSaveFileDialog;
    ProgressBox: TProgressBox;
    lkProgetti: TzFbDataSet;
    lkProgettiSrc: TDataSource;
    lkCorsi: TzFbDataSet;
    lkCorsiSrc: TDataSource;
    lkDocenti: TzFbDataSet;
    lkDocentiSrc: TDataSource;
    SalvaQuestionarioDlg: TdxSaveFileDialog;
    lkQuestionari: TzFbDataSet;
    lkQuestionariSrc: TDataSource;
    lkRaggruppamenti: TzFbDataSet;
    lkRaggruppamentiSrc: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
    procedure lkCorsiBeforeOpen(DataSet: TDataSet);
    procedure lkProgettiAfterOpen(DataSet: TDataSet);
    procedure lkProgettiBeforeOpen(DataSet: TDataSet);
  private
    FFiltroAnnoFormativoProgetto: string;
    FFiltroAnnoFormativoCorso: string;
    FFiltroAreaRiferimento: string;
    FFiltroCorso: integer;
    FFiltroDocente: integer;
    FFiltroEnte: integer;
    FFiltroProgetto: integer;
    FFiltroQuestionario: integer;
    FFiltroRaggruppamento: string;
    procedure TestIndirizzo(const Indirizzo: string);
    function GetLinks: string;
  private
    procedure SetFiltroAnnoFormativoCorso(const Value: string);
    procedure SetFiltroAnnoFormativoProgetto(const Value: string);
    procedure SetFiltroAreaRiferimento(const Value: string);
    procedure SetFiltroCorso(const Value: integer);
    procedure SetFiltroDocente(const Value: integer);
    procedure SetFiltroEnte(const Value: integer);
    procedure SetFiltroProgetto(const Value: integer);
    procedure SetFiltroQuestionario(const Value: integer);
    procedure SetFiltroRaggruppamento(const Value: string);
  protected
    procedure DatasetAnalisiBeforeOpen(DataSet: TDataSet);
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    procedure GeneraQuestionari;
    procedure CopiaLinkSuClipboard;
    procedure SalvaLinkSuFile;

    procedure DuplicaQuestionario;
    procedure TestQuestionario;
    procedure TestProgetto;
  public
    function TemplateFolder(const ReportGroup: string): string;

    procedure GeneraReport(const TemplateFileName: string);
  public
    function IsDatasetAnalisi(const DataSetName: string): boolean;
    procedure AggiornaDatasetAnalisi;

    property FiltroQuestionario: integer read FFiltroQuestionario write SetFiltroQuestionario;
    property FiltroEnte: integer read FFiltroEnte write SetFiltroEnte;
    property FiltroRaggruppamento: string read FFiltroRaggruppamento write SetFiltroRaggruppamento;
    property FiltroAnnoFormativoProgetto: string read FFiltroAnnoFormativoProgetto write SetFiltroAnnoFormativoProgetto;
    property FiltroAnnoFormativoCorso: string read FFiltroAnnoFormativoCorso write SetFiltroAnnoFormativoCorso;
    property FiltroAreaRiferimento: string read FFiltroAreaRiferimento write SetFiltroAreaRiferimento;
    property FiltroProgetto: integer read FFiltroProgetto write SetFiltroProgetto;
    property FiltroCorso: integer read FFiltroCorso write SetFiltroCorso;
    property FiltroDocente: integer read FFiltroDocente write SetFiltroDocente;
  end;

var
  Questionari: TQuestionari;

implementation

uses
  WinApi.Windows,
  WinApi.ShellAPI,
  System.IOUtils,
  System.UITypes,
  System.StrUtils,
  Vcl.Clipbrd,
  cxControls,
  zOffice.Reports,
  zBaseLib,
  Gesty_StoredProcs,
  ConfigModule,
  zz.Vcl,
   
  zOffice.Excel.Utils,
  Questionari.Report,
  dmCommon,
  zMsg;

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TQuestionari }

procedure TQuestionari.DataModuleCreate(Sender: TObject);
begin
  inherited;
  FFiltroQuestionario := Common.QuestionarioDefault;
  FFiltroEnte := Common.EnteDefault;
  FFiltroRaggruppamento := '';
  FFiltroAnnoFormativoProgetto := Common.AnnoFormativoCorrente;
  FiltroAnnoFormativoCorso := '';
  FFiltroAreaRiferimento := '';
  FFiltroProgetto := -1;
  FFiltroCorso := -1;
  FFiltroDocente := -1;

  // FFiltroAnnoFormativo := '2021/2022'; // aaaaaaaaaaaaaaa
  // FFiltroProgetto := 42816; //46850;

  SalvaLinkDlg.InitialDir := Config.CartellaPersonaleUtenteCorrente;
  SalvaQuestionarioDlg.InitialDir := Config.CartellaPersonaleUtenteCorrente;

  // eliminare
  ReportsManager.ExcelAllowBuildReport := function(FileName: String): boolean
    begin
      result := true;
      { TODO : ReportID }
      // Passare a gestione su file Json
      if SameText(FileNameNoExt(FileName), 'Template Questionario') then
        result := false;
    end;

  ReportsManager.ExcelBeforeShow := Procedure(FileName: String; dxSpreadSheet: TdxSpreadSheet)

      procedure ExportDataSet(const DataSetName, Caption: string);
    var
      DataSet: TzFbDataSet;
      Params: TExcelExportDataSetParams;
      CampiFileName: string;
      Campi: TStringList;
    begin
      if ProgressBox.Cancelled then
        Exit;

      ProgressBox.IncProgress(Caption);

      DataSet := GetDataSet(DataSetName);
      DataSet.Active := true;
      Params.Init;
      Params.Caption := Caption;
      Params.DeleteAllCells := true;
      Campi := TStringList.Create;
      try
        CampiFileName := Path + 'Questionari_Campi\Questionari_Campi_Per_' + Caption + '.txt';
        if fileExists(CampiFileName) then
          Campi.LoadFromFile(CampiFileName);

        dxSpreadSheet.ExportDataSet(Params, DataSet, Campi);
      finally
        FreeAndNil(Campi);
      end;
    end;

  begin

    { TODO : ReportID }
    // if not SameText(ReportsManager.ReportId, 'grafici_questionario') then
    if not SameText(FileNameNoExt(FileName), 'Template Questionario') then
      Exit;

    dxSpreadSheet.BeginUpdate(lsimPending);
    try
      dxSpreadSheet.OptionsBehavior.AutomaticCalculation := false;
      dxSpreadSheet.LoadFromFile(FileName);

      ProgressBox.Show(10, 'Export Excel', 'Dataset:', 'Attendere...');
      try
        ExportDataSet('Questionari_Analisi_Campione_Settore', 'Campione_Settore');
        ExportDataSet('Questionari_Analisi_Risposte_Genere', 'Genere');
        ExportDataSet('Questionari_Analisi_Risposte_Eta', 'Eta');
        ExportDataSet('Questionari_Analisi_Risposte_Frequenza_Formazione', 'Frequenza_Formazione');
        ExportDataSet('Questionari_Analisi_Risposte_Modalita_Conoscenza_Corso', 'Conoscenza_Corso');
        ExportDataSet('Questionari_Analisi_Risposte_Finanziamento', 'Finanziamento');
        ExportDataSet('Questionari_Analisi_Risposte_Valutazione_Corso', 'Valutazione_Corso');
        ExportDataSet('Questionari_Analisi_Risposte_Valutazione_Docenti', 'Valutazione_Docenti');
        ExportDataSet('Questionari_Analisi_Risposte_Altri_Interessi', 'Altri_Interessi');
        ExportDataSet('Questionari_Risp_Elenco_Suggerimenti', 'Suggerimenti');

        // dxSpreadSheet.OptionsBehavior.AutomaticCalculation := true;
      finally
        ProgressBox.Close;
      end;
    finally
      dxSpreadSheet.EndUpdate;
    end;
  end;
end;

procedure TQuestionari.GeneraQuestionari;
var
  idProgetto: integer;
  progetti: TzFbDataSet;
  sp: TSP_QUESTIONARI_LINK_GENERA;
begin
  progetti := GetDataSet('Progetti');

  if progetti.isEmpty then
    Exit;

  idProgetto := progetti.FieldByName('ID_PROGETTO').asInteger;

  if not ConfirmYesNo('Si desidera generare i questionari per il progetto selezionato?') then
    Exit;

  StartWait('Attendere...', true);
  try
    sp := TSP_QUESTIONARI_LINK_GENERA.Create(WriteTrans);
    try
      sp.id_Progetto := idProgetto;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    RefreshDataSets;
  finally
    StopWait;
  end;
end;

function TQuestionari.GetLinks: string;
var
  links: TStringList;
  Studenti: TzFbDataSet;
begin
  result := '';

  Studenti := GetDataSet('Studenti_Progetti');

  links := TStringList.Create;
  try
    Studenti.First;
    while not Studenti.Eof do
    begin

      if not Studenti.FieldByName('URL_QUESTIONARIO').IsNull then
        links.AddPair(Studenti.FieldByName('NOMINATIVO_STUDENTE').asString, Studenti.FieldByName('URL_QUESTIONARIO').asString);

      Studenti.Next;
    end;

    result := links.Text;
  finally
    FreeAndNil(links);
  end;
end;

procedure TQuestionari.SalvaLinkSuFile;
var
  links: string;
begin
  links := GetLinks;

  if links.isEmpty then
  begin
    ConfirmOk('Nessun questionario generato.');
    Exit;
  end;

  if SalvaLinkDlg.Execute then
    TFile.WriteAllText(SalvaLinkDlg.FileName, links);
end;

procedure TQuestionari.CopiaLinkSuClipboard;
var
  links: string;
begin
  links := GetLinks;

  if links.isEmpty then
  begin
    ConfirmOk('Nessun questionario generato.');
    Exit;
  end;

  Clipboard.AsText := links;
  ConfirmOk('Link copiati nella clipboard.');
end;

procedure TQuestionari.DuplicaQuestionario;
var
  idQuestionario: integer;
  Questionari: TzFbDataSet;
  sp: TSP_QUESTIONARI_DUPLICA;
begin
  Questionari := GetDataSet('Questionari');

  if Questionari.isEmpty then
    Exit;

  idQuestionario := Questionari.FieldByName('ID_QUESTIONARIO').asInteger;

  if not ConfirmYesNo('Si desidera duplicare il questionario selezionato?') then
    Exit;

  StartWait('Attendere...', true);
  try
    sp := TSP_QUESTIONARI_DUPLICA.Create(WriteTrans);
    try
      sp.id_Questionario_Src := idQuestionario;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    RefreshDataSets;
  finally
    StopWait;
  end;
end;

procedure TQuestionari.TestProgetto;
var
  IndirizzoTest: string;
  progetti: TzFbDataSet;
begin
  progetti := GetDataSet('Progetti');

  if progetti.isEmpty then
    Exit;

  IndirizzoTest := progetti.FieldByName('QUESTIONARI_INDIRIZZO').asString;

  TestIndirizzo(IndirizzoTest);
end;

procedure TQuestionari.TestQuestionario;
var
  IndirizzoTest: string;
  Questionari: TzFbDataSet;
begin
  Questionari := GetDataSet('Questionari');

  if Questionari.isEmpty then
    Exit;

  // recuperare l'indirizzo di test
  IndirizzoTest := Questionari.FieldByName('QUESTIONARI_INDIRIZZO_TEST').asString;

  TestIndirizzo(IndirizzoTest);
end;

procedure TQuestionari.TestIndirizzo(const Indirizzo: string);
begin
  if Indirizzo.isEmpty then
    ConfirmOk('URL di test non specificato.')
  else
    ShellExecute(0, PCHAR('open'), PCHAR(Indirizzo), nil, nil, SW_RESTORE);
end;

function TQuestionari.IsDatasetAnalisi(const DataSetName: string): boolean;
begin
  result := IndexText(DataSetName, ['Questionari_Risposte_Elenco', 'Questionari_Analisi_Campione', 'Questionari_Analisi_Campione_Settore', 'Questionari_Analisi_Risposte_Genere', 'Questionari_Analisi_Risposte_Eta',
    'Questionari_Analisi_Risposte_Frequenza_Formazione', 'Questionari_Analisi_Risposte_Modalita_Conoscenza_Corso', 'Questionari_Analisi_Risposte_Finanziamento', 'Questionari_Analisi_Risposte_Valutazione_Corso',
    'Questionari_Analisi_Risposte_Valutazione_Docenti', 'Questionari_Analisi_Risposte_Altri_Interessi', 'Questionari_Risp_Elenco_Suggerimenti', 'Questionari_Analisi_Risposte_ElencoDocenti', 'Questionari_Analisi_Risposte_ElencoCorsi']) <> -1;
end;

procedure TQuestionari.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if IsDatasetAnalisi(DataSetName) then
  begin
    DataSet.BeforeOpen := DatasetAnalisiBeforeOpen;
    // Mantis #168 - 2026-09-24: tutti i dataset di analisi leggono la stessa tabella
    // temporanea QUESTIONARI_ANALISI_RESULT_TMP, che ogni apertura svuota e riscrive.
    // Con il fetch a blocchi (50 righe) un dataset gia' aperto resta con un cursore
    // a meta': il piano "Refetch" rilegge le righe per DBKEY dopo l'ordinamento e le
    // trova cancellate da un'apertura successiva -> "no current record for fetch
    // operation". Scaricando tutto in apertura nessun cursore resta appeso alla
    // tabella condivisa.
    DataSet.FetchOptions.Mode := fmAll;
  end;
end;

procedure TQuestionari.SetFiltroAnnoFormativoProgetto(const Value: string);
begin
  if FFiltroAnnoFormativoProgetto <> Value then
  begin
    FFiltroAnnoFormativoProgetto := Value;

    FFiltroProgetto := -1;
    lkProgetti.ReOpen();
    AggiornaDatasetAnalisi;
  end;
end;

procedure TQuestionari.SetFiltroAnnoFormativoCorso(const Value: string);
begin

  if FFiltroAnnoFormativoCorso <> Value then
  begin
    FFiltroAnnoFormativoCorso := Value;

    FFiltroCorso := -1;
    lkCorsi.ReOpen();
    AggiornaDatasetAnalisi;
  end;
end;

procedure TQuestionari.SetFiltroEnte(const Value: integer);
begin
  if FFiltroEnte <> Value then
  begin
    FFiltroEnte := Value;

    FFiltroProgetto := -1;
    lkProgetti.ReOpen();
    AggiornaDatasetAnalisi;
  end;
end;

procedure TQuestionari.SetFiltroRaggruppamento(const Value: string);
begin

  if FFiltroRaggruppamento <> Value then
  begin
    FFiltroRaggruppamento := Value;
    AggiornaDatasetAnalisi;
  end;
end;

procedure TQuestionari.SetFiltroProgetto(const Value: integer);
begin
  if FFiltroProgetto <> Value then
  begin
    FFiltroProgetto := Value;

    FFiltroCorso := -1;
    lkCorsi.ReOpen();

    AggiornaDatasetAnalisi;
  end;
end;

procedure TQuestionari.SetFiltroCorso(const Value: integer);
begin
  if FFiltroCorso <> Value then
  begin
    FFiltroCorso := Value;
    AggiornaDatasetAnalisi;
  end;
end;

procedure TQuestionari.AggiornaDatasetAnalisi;
begin
  StartWait('Attendere...', true);
  try
    ForEach<TzFbDataSet>(
      procedure(DataSet: TzFbDataSet)
      begin

        if IsDatasetAnalisi(DataSet.name) then
          DataSet.ReOpen();
      end);
  finally
    StopWait;
  end;
end;

procedure TQuestionari.DatasetAnalisiBeforeOpen(DataSet: TDataSet);
var
  zFbDataSet: TzFbDataSet;
begin
  zFbDataSet := TzFbDataSet(DataSet);

  if zFbDataSet.ParamExists('ID_QUESTIONARIO') then
    zFbDataSet.ParamByName('ID_QUESTIONARIO').Value := FiltroQuestionario;

  if zFbDataSet.ParamExists('ID_ENTE') then
    zFbDataSet.ParamByName('ID_ENTE').Value := FiltroEnte;

  if zFbDataSet.ParamExists('RAGGRUPPAMENTO') then
  begin

    if FiltroRaggruppamento.Trim.isEmpty then
      zFbDataSet.ParamByName('RAGGRUPPAMENTO').clear
    else
      zFbDataSet.ParamByName('RAGGRUPPAMENTO').Value := FiltroRaggruppamento;
  end;

  if zFbDataSet.ParamExists('ANNO_FORMATIVO_PROGETTO') then
  begin

    if FiltroAnnoFormativoProgetto.isEmpty then
      zFbDataSet.ParamByName('ANNO_FORMATIVO_PROGETTO').clear
    else
      zFbDataSet.ParamByName('ANNO_FORMATIVO_PROGETTO').Value := FiltroAnnoFormativoProgetto;
  end;

  if zFbDataSet.ParamExists('ANNO_FORMATIVO_CORSO') then
  begin

    if FiltroAnnoFormativoCorso.isEmpty then
      zFbDataSet.ParamByName('ANNO_FORMATIVO_CORSO').clear
    else
      zFbDataSet.ParamByName('ANNO_FORMATIVO_CORSO').Value := FiltroAnnoFormativoCorso;
  end;

  if zFbDataSet.ParamExists('AREA_RIFERIMENTO') then
  begin

    if FiltroAreaRiferimento.isEmpty then
      zFbDataSet.ParamByName('AREA_RIFERIMENTO').clear
    else
      zFbDataSet.ParamByName('AREA_RIFERIMENTO').Value := FiltroAreaRiferimento;
  end;

  if zFbDataSet.ParamExists('ID_PROGETTO') then
    zFbDataSet.ParamByName('ID_PROGETTO').Value := FiltroProgetto;

  if zFbDataSet.ParamExists('ID_CORSO') then
    zFbDataSet.ParamByName('ID_CORSO').Value := FiltroCorso;

  if zFbDataSet.ParamExists('DOCENTE') then
  begin
    if FiltroDocente = -1 then
      zFbDataSet.ParamByName('DOCENTE').clear
    else
      zFbDataSet.ParamByName('DOCENTE').Value := FiltroDocente;
  end;
end;

procedure TQuestionari.lkProgettiAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if FiltroProgetto <> -1 then
    lkProgetti.Locate('ID_PROGETTO', FiltroProgetto, []);

  lkCorsi.ReOpen()
end;

procedure TQuestionari.lkProgettiBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  lkProgetti.ParamByName('ID_ENTE').Value := FiltroEnte;

  if FiltroAnnoFormativoProgetto.isEmpty then
    lkProgetti.ParamByName('ANNO_FORMATIVO').clear
  else
    lkProgetti.ParamByName('ANNO_FORMATIVO').Value := FiltroAnnoFormativoProgetto;
end;

procedure TQuestionari.lkCorsiBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  lkCorsi.ParamByName('ID_PROGETTO').Value := FiltroProgetto;

  if FiltroAnnoFormativoCorso.isEmpty then
    lkCorsi.ParamByName('ANNO_FORMATIVO').clear
  else
    lkCorsi.ParamByName('ANNO_FORMATIVO').Value := FiltroAnnoFormativoCorso;
end;

procedure TQuestionari.SetFiltroAreaRiferimento(const Value: string);
begin

  if FFiltroAreaRiferimento <> Value then
  begin
    FFiltroAreaRiferimento := Value;
    AggiornaDatasetAnalisi;
  end;
end;

procedure TQuestionari.SetFiltroDocente(const Value: integer);
begin

  if FFiltroDocente <> Value then
  begin
    FFiltroDocente := Value;
    AggiornaDatasetAnalisi;
  end;
end;

procedure TQuestionari.SetFiltroQuestionario(const Value: integer);
begin

  if FFiltroQuestionario <> Value then
  begin
    FFiltroQuestionario := Value;
    AggiornaDatasetAnalisi;
  end;
end;

function TQuestionari.TemplateFolder(const ReportGroup: string): string;
begin
  result := ReportsManager.GetFolder(ReportGroup);
  result := result + 'TemplateQuestionario';
end;

procedure TQuestionari.GeneraReport(const TemplateFileName: string);

  procedure ExportDataSet(const DataSetName, Caption: string);
  var
    DataSet: TzFbDataSet;
  begin
    if ProgressBox.Cancelled then
      Exit;

    ProgressBox.IncProgress(Caption);

    DataSet := GetDataSet(DataSetName);
    // Mantis #168 - 2026-09-24: Active := true non fa nulla su un dataset gia' aperto;
    // ReOpen lo rigenera sui filtri e sui dati correnti, come fa AggiornaDatasetAnalisi.
    DataSet.ReOpen();
    DataSet.Last;
    DataSet.First; // forza
    QuestionarioReport.ExportDataSet(DataSet, Caption);
  end;

begin

  if not fileExists(TemplateFileName) then
    raise Exception.Create('Template non trovato: ' + TemplateFileName);

  if not SalvaQuestionarioDlg.Execute then
    Exit;

  if TFile.Exists(SalvaQuestionarioDlg.FileName) then
    TFile.Delete(SalvaQuestionarioDlg.FileName);

  ProgressBox.Show(12, 'Export Excel', 'Dataset:', 'Attendere...');
  try
    QuestionarioReport.Init(TemplateFileName);

    ExportDataSet('Questionari_Analisi_Campione_Settore', 'Campione_Settore');
    ExportDataSet('Questionari_Analisi_Risposte_Genere', 'Genere');
    ExportDataSet('Questionari_Analisi_Risposte_Eta', 'Eta');
    ExportDataSet('Questionari_Analisi_Risposte_Frequenza_Formazione', 'Frequenza_Formazione');
    ExportDataSet('Questionari_Analisi_Risposte_Modalita_Conoscenza_Corso', 'Conoscenza_Corso');
    ExportDataSet('Questionari_Analisi_Risposte_Finanziamento', 'Finanziamento');
    ExportDataSet('Questionari_Analisi_Risposte_Valutazione_Corso', 'Valutazione_Corso');
    ExportDataSet('Questionari_Analisi_Risposte_Valutazione_Docenti', 'Valutazione_Docenti');
    //
    ExportDataSet('Questionari_Analisi_Risposte_ElencoDocenti', 'ElencoDocenti');
    ExportDataSet('Questionari_Analisi_Risposte_ElencoCorsi', 'ElencoCorsi');
    //
    ExportDataSet('Questionari_Analisi_Risposte_Altri_Interessi', 'Altri_Interessi');
    ExportDataSet('Questionari_Risp_Elenco_Suggerimenti', 'Suggerimenti');
    //
    QuestionarioReport.Save(SalvaQuestionarioDlg.FileName);
  finally
    ProgressBox.Close;
  end;
end;

end.
