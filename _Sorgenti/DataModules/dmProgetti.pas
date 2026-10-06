unit dmProgetti;

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
  Base_DataModule,
  zFbDataSet,
  dbMaster,
  zBaseLib,
  zProgressBox,
  zDbViewDlg,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl,
  cxClasses,
  cxShellBrowserDialog;

type
  TProgetti = class(TBaseDataModule)
    ProgressBox: TProgressBox;
    dlgEstensori: TzDbViewDlg;
    lkEstensori: TzFbDataSet;
    dlgProgetti: TzDbViewDlg;
    lkProgetti: TzFbDataSet;
    dlgStudenti: TzDbViewDlg;
    lkStudenti: TzFbDataSet;
    dlgStudentiStage: TzDbViewDlg;
    lkStudentiStage: TzFbDataSet;
    dlgRigheBudget: TzDbViewDlg;
    lkRigheBudget: TzFbDataSet;
    sbdSelectFolderDialog: TcxShellBrowserDialog;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure ProgettiAfterOpen(DataSet: TDataSet);
    procedure ProgettiNewRecord(DataSet: TDataSet);
    // Mantis #100 - 2026-09-18: anteprima live del canale SIUF - vedi il
    // commento sull'implementazione per i dettagli.
    procedure ProgettiAreaRiferimentoChange(Sender: TField);
    procedure Piani_Personalizzati_ServiziNewRecord(DataSet: TDataSet);
    function DataStampaBandoDocenti: TDateTime;
    procedure TimeReportGetParametri(out idRisorsa, idIncarico: integer);
    procedure TimesheetAnnualeBeforeOpen(DataSet: TDataSet);
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;

  public
    function IdIncaricoSelezionato: integer;
    function IdProgettoSelezionato: integer;
    procedure Verificato(Incarichi: TList<integer>);
    procedure AutorizzaIncarico;
    procedure ModificaEstensore;
    procedure IncongruitaVerificata;
    procedure CopiaMaterie;
    procedure NuovoPianoPersonale;
    procedure IscrizioneStudenti;
    procedure NumerazioneRegistro;
    procedure AggiungiStudentiStage;
    function NuovaAziendaOspitante: integer;
    procedure MaterieGeneraIncarico;

    procedure BudgetCopiaDaAltroProgetto;
    procedure BudgetAggiungiRighe;

    function GetLezioniDaRendicontare(out Data: TDateTime; out IdProgetto: integer): boolean;

    procedure EsportaPDFFirmatiDigitalmente;
  public
    DocentiIncarichiSelezionati: TList<integer>;
    procedure DocentiIncarichiFilterRecord(DataSet: TDataSet; var Accept: boolean);
  end;

var
  Progetti: TProgetti;

implementation

uses
  WinApi.ShellAPI,
  System.IOUtils,
  System.DateUtils,
  dxRichEdit.Control,
  Gesty_StoredProcs,
  ConfigModule,
  frmParametriProtocolloIncarico,
  WizInserimentoPianiPersonalizzatiFrm,
  WizNuovaAziendaOspitanteFrm,

  WizInserimentoIncaricoFrm,
  zMsg,
  dmCommon,
  Gesty.Types,
  Files.Lib,
  zOffice.Reports;

{$R *.dfm}

procedure TProgetti.DataModuleCreate(Sender: TObject);
begin
  inherited;

  DocentiIncarichiSelezionati := TList<integer>.create;

  ReportsManager.BeforePrintProc := function(ReportName: string): boolean
    const
      dataStampaIdent = 'BandoDocenti_DataStampa';
    var
      dataStampa: TDateTime;
    begin
      result := true;

      { TODO : ReportID }
      // if sameText(ReportsManager.ReportId, 'Bando Docenti') then
      if sameText(ReportName, 'Bando Docenti') then
      begin
        ReportsManager.SelectedDataSet := GetDataSet('Progetti');

        if not ReportsManager.variableExists(dataStampaIdent) then
        begin
          /// ////
          dataStampa := DataStampaBandoDocenti;

          if InputDate('Data Stampa', 'Data Stampa', dataStampa) then
            ReportsManager.AddVariable(dataStampaIdent, dataStampa)
          else
            result := false;
        end;
      end;
    end;

  ReportsManager.AddVariablesProc := procedure(ReportsManager: TzReportsManager)
    var
      idRisorsa, idIncarico: integer;
    begin
      TimeReportGetParametri(idRisorsa, idIncarico);
      common.AssegnaVariabiliTimeReport(ReportsManager, idRisorsa, idIncarico, GetDataSet('Progetti'));
    end;

  ReportsManager.ReportLoadedProc := procedure(ReportName: string)
    var
      DataSet: TzFbDataSet;
    begin

      // Stampa multipla degli incarichi
      { TODO : ReportID }
      // if sameText(ReportsManager.ReportId, 'stampa_incarico') then
      if sameText(ReportName, 'Incarico') then
        if assigned(ReportsManager.SelectedDataSet) then
          if sameText(ReportsManager.SelectedDataSet.Name, 'Docenti_Incarichi') then
          begin
            DataSet := GetDataSet('Docenti_Incarichi');
            ReportsManager.SetFastReportDataSet(DataSet);
            DataSet.OnFilterRecord := DocentiIncarichiFilterRecord;
            DataSet.Filtered := true;
          end;
    end;

  ReportsManager.AfterPrintProc := procedure(ReportName: string)
    var
      DataSet: TzFbDataSet;
    begin
      { TODO : ReportID }
      // if sameText(ReportsManager.ReportId, 'stampa_incarico') then
      if sameText(ReportName, 'Incarico') then
      begin
        ReportsManager.SetFastReportDataSet(nil);
        DataSet := GetDataSet('Docenti_Incarichi');
        DataSet.Filtered := false;
        DataSet.OnFilterRecord := nil;
      end;
    end;

  common.FirmaElettronica_InitReportsManager(ReportsManager);
end;

procedure TProgetti.DataModuleDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(DocentiIncarichiSelezionati);
end;

procedure TProgetti.Verificato(Incarichi: TList<integer>);
var
  id: integer;
  sp: TSP_incarico_Verificato;
begin
  Assert(assigned(Incarichi));
  if Incarichi.Count = 0 then
    exit;

  if not ConfirmYesNo('Segnare come verificati gli incarichi selezionati?') then
    exit;

  ProgressBox.Show(Incarichi.Count, 'Incarichi Verificati', 'Incarichi Verificati', 'Attendere...');
  try
    sp := TSP_incarico_Verificato.create(WriteTrans);
    try
      for id in Incarichi do
      begin
        sp.Id_Incarico := id;
        sp.ExecuteAndCommit;
      end;
    finally
      FreeAndNil(sp);
    end;

    RefreshDataSets;
  finally
    ProgressBox.Close;
  end;
end;

procedure TProgetti.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
var
  Field: TField;
begin
  inherited;

  if sameText(DataSetName, 'Progetti') then
  begin
    DataSet.AfterOpen := ProgettiAfterOpen;
    DataSet.OnNewRecord := ProgettiNewRecord;
    // Mantis #100 - 2026-09-18: anteprima live del canale SIUF proposto.
    DataSet.FieldByName('AREA_RIFERIMENTO').OnChange := ProgettiAreaRiferimentoChange;
  end
  else
    if sameText(DataSetName, 'Piani_Personalizzati_Servizi') then
      DataSet.OnNewRecord := Piani_Personalizzati_ServiziNewRecord
    else
      if sameText(DataSetName, 'Docenti_Incarichi') then
      begin
      end
      else
        // riepilogo annuale delle risorse (Allegato 2): l'anno lo sceglie l'utente nella vista,
        // la testata lo eredita
        if sameText(DataSetName, 'Timesheet_Intestazione') or
           sameText(DataSetName, 'Timesheet_Riepilogo_Annuale') then
          DataSet.BeforeOpen := TimesheetAnnualeBeforeOpen;
end;

function TProgetti.IdIncaricoSelezionato: integer;
var
  DataSet: TzFbDataSet;
begin
  result := -1;

  DataSet := GetDataSet('Docenti_Incarichi');

  if assigned(DataSet) then
    result := DataSet.FieldByName('ID_INCARICO').AsInteger;
end;

procedure TProgetti.ProgettiNewRecord(DataSet: TDataSet);
var
  Ente, Sede: integer;
  Raggruppamento: string;
begin
  inherited;
  common.GetEnteAndSedeDefault(Ente, Sede, Raggruppamento);
  DataSet.FieldByName('ID_ENTE').value := Ente;
  DataSet.FieldByName('ID_SEDE').value := Sede;
  DataSet.FieldByName('QUESTIONARI_RAGGRUPPAMENTI').value := Raggruppamento;
  DataSet.FieldByName('ANNO_FORMATIVO').value := common.AnnoFormativoCorrente;
end;

// Mantis #100 - 2026-09-18: anteprima live del canale SIUF (EOB/ORD) mentre
// si compila il form, prima del salvataggio. Stessa mappatura Area
// Riferimento -> canale del trigger PROGETTI_BIU0: il trigger resta l'unica
// fonte autorevole (viene rivalutata comunque a ogni INSERT/UPDATE), questa
// è solo un'anteprima per l'operatore. Se le due mappature dovessero mai
// disallinearsi vince sempre il server, al salvataggio.
procedure TProgetti.ProgettiAreaRiferimentoChange(Sender: TField);
var
  DataSet: TDataSet;
  CanaleField: TField;
  Ordinamentale: boolean;
begin
  DataSet := Sender.DataSet;

  if not (DataSet.State in [dsEdit, dsInsert]) then
    exit; // non ricalcolare mentre si scorrono record già salvati

  if Sender.IsNull then
    exit; // area non ancora scelta: nessuna anteprima da proporre

  CanaleField := DataSet.FieldByName('CANALE_SIUF');

  if not CanaleField.IsNull then
    exit; // non sovrascrive mai un valore già impostato, manuale o precedente

  if not DataSet.FieldByName('GRS').AsBoolean then
    exit; // sui progetti senza GRS il campo resta vuoto, come fa il trigger

  Ordinamentale := (Sender.AsString = 'IeFP 2° ciclo') or
                   (Sender.AsString = 'Superiore') or
                   (Sender.AsString = 'Apprendistato');

  if Ordinamentale then
    CanaleField.AsString := 'ORD'
  else
    CanaleField.AsString := 'EOB';
end;

procedure TProgetti.TimeReportGetParametri(out idRisorsa, idIncarico: integer);
var
  DataSet: TzFbDataSet;
begin
  idRisorsa := -1;
  idIncarico := -1;

  // DataSet := FindDataSet('Riepilogo_Ore');
  DataSet := FindDataSet('Docenti_Incarichi');

  if assigned(DataSet) then
    if not DataSet.IsEmpty then
    begin
      idRisorsa := DataSet.FieldByName('ID_RISORSA').AsInteger;
      idIncarico := DataSet.FieldByName('ID_INCARICO').AsInteger;
    end;
end;

procedure TProgetti.MaterieGeneraIncarico;
var
  DataSet: TzFbDataSet;
  idDocente: integer;
  IdProgetto: integer;
  Materia: string;
  DataInizio, DataFine: TDateTime;
  TotaleOreAttribuite: double;
begin
  DataSet := GetDataSet('Progetti_Materie');

  if DataSet.IsEmpty then
    exit;

  idDocente := -1;
  IdProgetto := -1;
  Materia := '';
  DataInizio := 0;
  DataFine := 0;
  TotaleOreAttribuite := 0;

  if not DataSet.FieldByName('ID_DOCENTE').IsNull then
    idDocente := DataSet.FieldByName('ID_DOCENTE').AsInteger;

  if not DataSet.FieldByName('ID_PROGETTO').IsNull then
    IdProgetto := DataSet.FieldByName('ID_PROGETTO').AsInteger;

  if not DataSet.FieldByName('Materia').IsNull then
    Materia := DataSet.FieldByName('Materia').AsString;

  if not DataSet.FieldByName('ORE_DA_ATTRIBUIRE').IsNull then
    TotaleOreAttribuite := DataSet.FieldByName('ORE_DA_ATTRIBUIRE').value;

  DataSet := GetDataSet('Progetti');
  DataInizio := DataSet.FieldByName('DATA_INIZIO_PROGETTO').AsDateTime;
  DataFine := DataSet.FieldByName('DATA_FINE_PROGETTO').AsDateTime;

  if ApriInserimentoIncarico(idDocente, IdProgetto, DataInizio, DataFine, '', Materia, TotaleOreAttribuite) <> -1 then
    GetDataSet('Progetti_Materie_Incarichi').Reopen();
end;

procedure TProgetti.ModificaEstensore;
var
  DataSet: TzFbDataSet;
  idEstensore: integer;
  IdIncaricoSelezionato: integer;
  sp: TSP_incarico_Set_Estensore;
begin
  DataSet := GetDataSet('IncarichiDaAutorizzare');

  if DataSet.IsEmpty then
    exit;

  IdIncaricoSelezionato := DataSet.FieldByName('ID_INCARICO').AsInteger;

  idEstensore := -1;

  lkEstensori.RevertSQL(true);
  try
    if dlgEstensori.Execute then
      idEstensore := lkEstensori.FieldByName('ID_PERSONALE').AsInteger
    else
      exit;
  finally
    lkEstensori.Active := false;
  end;

  sp := TSP_incarico_Set_Estensore.create(WriteTrans);
  try
    sp.Id_Incarico := IdIncaricoSelezionato;
    sp.Id_Estensore := idEstensore;

    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  DataSet.Reopen(true);
end;

procedure TProgetti.IncongruitaVerificata;
var
  DataSet: TzFbDataSet;
  idEstensore: integer;
  IdIncaricoSelezionato: integer;
  sp: TSP_incarico_Set_Congruo;
begin
  DataSet := GetDataSet('IncarichiNonCongrui');

  if DataSet.IsEmpty then
    exit;

  IdIncaricoSelezionato := DataSet.FieldByName('ID_INCARICO').AsInteger;

  if not ConfirmYesNo('Si desidera considerare l''incarico ' + IdIncaricoSelezionato.ToString + ' congruo?') then
    exit;

  sp := TSP_incarico_Set_Congruo.create(WriteTrans);
  try
    sp.Id_Incarico := IdIncaricoSelezionato;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  DataSet.Reopen(true);
end;

procedure TProgetti.CopiaMaterie;

  function getIdProgettoSrc: integer;
  var
    DataSet: TzFbDataSet;
  begin
    result := -1;

    lkProgetti.RevertSQL(true);
    try
      if dlgProgetti.Execute then
        result := lkProgetti.FieldByName('ID_PROGETTO').AsInteger;
    finally
      lkProgetti.Active := false;
    end;
  end;

  function getIdProgettoDest: integer;
  var
    DataSet: TzFbDataSet;
  begin
    result := -1;

    DataSet := GetDataSet('Progetti');

    if assigned(DataSet) then
      result := DataSet.FieldByName('ID_PROGETTO').AsInteger;
  end;

var
  idProgettoSrc, idProgettoDest: integer;
  Materie: TzFbDataSet;
  sp: TSP_Progetti_Materie_Import;
begin

  idProgettoDest := getIdProgettoDest;
  if idProgettoDest = -1 then
    exit;

  idProgettoSrc := getIdProgettoSrc;
  if idProgettoSrc = -1 then
    exit;

  sp := TSP_Progetti_Materie_Import.create(WriteTrans);
  try
    sp.Id_Progetto_Src := idProgettoSrc;
    sp.Id_Progetto_Dest := idProgettoDest;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  Materie := GetDataSet('Progetti_Materie');
  Materie.Reopen(true);
end;

function TProgetti.IdProgettoSelezionato: integer;
var
  DataSet: TzFbDataSet;
begin
  result := -1;

  DataSet := GetDataSet('Progetti');

  if DataSet.IsEmpty then
    exit;

  result := DataSet.FieldByName('ID_PROGETTO').AsInteger;
end;

procedure TProgetti.NuovoPianoPersonale;
var
  DataSet: TzFbDataSet;
  IdProgetto: integer;
  DataInizioProgetto: TDateTime;
begin
  DataSet := GetDataSet('Progetti');

  if DataSet.IsEmpty then
    exit;

  IdProgetto := DataSet.FieldByName('ID_PROGETTO').AsInteger;
  DataInizioProgetto := DataSet.FieldByName('DATA_INIZIO_PROGETTO').AsDateTime;

  if IdProgetto = -1 then
    exit;

  if ApriInserimentoPianoPersonalizzato(IdProgetto, DataInizioProgetto) then
    ReopenDataSet('Progetti_Piani_Personalizzati');
end;

procedure TProgetti.Piani_Personalizzati_ServiziNewRecord(DataSet: TDataSet);
var
  Servizi, Piani: TzFbDataSet;
begin
  inherited;

  Servizi := GetDataSet('Progetti_Piani_Personalizzati_Servizi');
  Piani := GetDataSet('Progetti_Piani_Personalizzati');

  Servizi.FieldByName('DATA_INIZIO').AsDateTime := Piani.FieldByName('DATA_INIZIO').AsDateTime;
  Servizi.FieldByName('DATA_FINE').AsDateTime := Piani.FieldByName('DATA_FINE').AsDateTime;
end;

procedure TProgetti.NumerazioneRegistro;
var
  IdProgetto: integer;
  Progetti: TzFbDataSet;
  sp: TSP_studenti_Ordina_Registro;
  Studenti: TzFbDataSet;
begin
  Progetti := GetDataSet('Progetti');

  if not assigned(Progetti) then
    exit;

  if Progetti.IsEmpty then
    exit;

  if not ConfirmYesNo('Si desidera attribuire il numero registro agli studenti?') then
    exit;

  IdProgetto := Progetti.FieldByName('ID_PROGETTO').AsInteger;

  sp := TSP_studenti_Ordina_Registro.create(WriteTrans);
  try
    sp.Id_Progetto := IdProgetto;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  Studenti := GetDataSet('Studenti_Progetti');
  if assigned(Studenti) then
    Studenti.Reopen(true);
end;

procedure TProgetti.IscrizioneStudenti;
var
  IdProgetto: integer;
  Progetti, Studenti: TzFbDataSet;

  sp: TSP_STUDENTI_PROGETTI_ADD;
begin
  Progetti := GetDataSet('Progetti');

  if not assigned(Progetti) then
    exit;

  if Progetti.IsEmpty then
    exit;

  IdProgetto := Progetti.FieldByName('ID_PROGETTO').AsInteger;

  sp := TSP_STUDENTI_PROGETTI_ADD.create(WriteTrans);
  try
    lkStudenti.RevertSQL(false);
    lkStudenti.ParamByName('ID_PROGETTO').AsInteger := IdProgetto;
    lkStudenti.Active := true;
    try
      dlgStudenti.Execute(
        procedure
        begin
          sp.Id_Progetto := IdProgetto;
          sp.Id_Studente := lkStudenti.FieldByName('ID_STUDENTE').AsInteger;
          sp.ExecuteAndCommit;
        end)
    finally
      lkStudenti.Active := false;
    end;

  finally
    FreeAndNil(sp);
  end;

  Studenti := GetDataSet('Studenti_Progetti');
  if assigned(Studenti) then
    Studenti.Reopen(true);
end;

procedure TProgetti.AggiungiStudentiStage;
var
  idProgettoFormativo: integer;
  Id_Azienda_Ospitante: integer;
  Progetti_Formativi, Aziende_Ospitanti, Studenti: TzFbDataSet;
  sp: TSP_PROGETTI_FORMATIVI_ADD_STUDENTE;
begin
  Progetti_Formativi := GetDataSet('Progetti_Formativi');
  Aziende_Ospitanti := GetDataSet('Progetti_Formativi_Aziende');

  if not assigned(Progetti_Formativi) or Progetti_Formativi.IsEmpty then
    exit;

  if not assigned(Aziende_Ospitanti) or Aziende_Ospitanti.IsEmpty then
    exit;

  idProgettoFormativo := Progetti_Formativi.FieldByName('ID_PROGETTO_FORMATIVO').AsInteger;
  Id_Azienda_Ospitante := Aziende_Ospitanti.FieldByName('ID_AZIENDA_OSPITANTE').AsInteger;

  sp := TSP_PROGETTI_FORMATIVI_ADD_STUDENTE.create(WriteTrans);
  try
    lkStudentiStage.RevertSQL(false);
    lkStudentiStage.ParamByName('ID_PROGETTO_FORMATIVO').AsInteger := idProgettoFormativo;
    lkStudentiStage.ParamByName('ID_AZIENDA_OSPITANTE').AsInteger := Id_Azienda_Ospitante;

    lkStudentiStage.Active := true;
    try
      dlgStudentiStage.Execute(
        procedure
        begin
          sp.Id_Progetto_Formativo := idProgettoFormativo;
          sp.Id_Azienda_Ospitante := Id_Azienda_Ospitante;
          sp.Id_Studente := lkStudentiStage.FieldByName('ID_STUDENTE').AsInteger;
          sp.ExecuteAndCommit;
        end)
    finally
      lkStudentiStage.Active := false;
    end;

  finally
    FreeAndNil(sp);
  end;

  Studenti := GetDataSet('Studenti_Stage');
  if assigned(Studenti) then
    Studenti.Reopen(true);
end;

function TProgetti.NuovaAziendaOspitante: integer;
var
  DataSet: TzFbDataSet;
begin
  result := -1;

  DataSet := GetDataSet('Progetti_Formativi');
  if DataSet.IsEmpty then
  begin
    ConfirmOk('Nessun progetto formativo selezionato.');
    exit;
  end;

  result := InserisciNuovaAziendaOspitante;

  if result <> -1 then
  begin
    DataSet := GetDataSet('Progetti_Formativi_Aziende');
    DataSet.Append;
    DataSet.FieldByName('ID_AZIENDA_OSPITANTE').AsInteger := result;
  end;
end;

procedure TProgetti.BudgetCopiaDaAltroProgetto;

  function getIdProgettoSrc: integer;
  var
    DataSet: TzFbDataSet;
  begin
    result := -1;

    lkProgetti.RevertSQL(true);
    try
      if dlgProgetti.Execute then
        result := lkProgetti.FieldByName('ID_PROGETTO').AsInteger;
    finally
      lkProgetti.Active := false;
    end;
  end;

  function getIdProgettoDest: integer;
  var
    DataSet: TzFbDataSet;
  begin
    result := -1;

    DataSet := GetDataSet('Progetti');

    if assigned(DataSet) then
      result := DataSet.FieldByName('ID_PROGETTO').AsInteger;
  end;

var
  idProgettoSrc, idProgettoDest: integer;
  Budget: TzFbDataSet;
  sp: TSP_PROGETTI_TIPI_INCARICO_IMPORT;
begin

  idProgettoDest := getIdProgettoDest;
  if idProgettoDest = -1 then
    exit;

  idProgettoSrc := getIdProgettoSrc;
  if idProgettoSrc = -1 then
    exit;

  sp := TSP_PROGETTI_TIPI_INCARICO_IMPORT.create(WriteTrans);
  try
    sp.Id_Progetto_Src := idProgettoSrc;
    sp.Id_Progetto_Dest := idProgettoDest;
    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  Budget := GetDataSet('Progetti_Budget_Elenco');
  Budget.Reopen(true);
end;

procedure TProgetti.BudgetAggiungiRighe;
var
  Budget: TzFbDataSet;
  IdProgetto: integer;
begin
  IdProgetto := IdProgettoSelezionato;

  if IdProgetto = -1 then
    exit;

  Budget := GetDataSet('Progetti_Budget_Elenco');

  lkRigheBudget.RevertSQL(false);
  lkRigheBudget.ParamByName('ID_PROGETTO').AsInteger := IdProgetto;
  lkRigheBudget.Active := true;
  try
    dlgRigheBudget.Execute(
      procedure
      begin
        Budget.Append;
        Budget.FieldByName('ID_PROGETTO').AsInteger := IdProgetto;
        Budget.FieldByName('TIPO_INCARICO').AsString := lkRigheBudget.FieldByName('TIPO_INCARICO').AsString;
        Budget.FieldByName('IMPORTO_BUDGET').AsCurrency := lkRigheBudget.FieldByName('IMPORTO_BUDGET').AsCurrency;
        Budget.FieldByName('ORE_PREVISTE').AsFloat := lkRigheBudget.FieldByName('TOTALE_ORE_ATTRIBUITE').AsFloat;
        Budget.Post;
      end);
  finally
    lkRigheBudget.Active := false;
  end;
end;

procedure TProgetti.AutorizzaIncarico;
var
  RichiedeContratto: boolean;
  DataSet: TzFbDataSet;
  DataSetStampa: TzFbDataSet;

  IdIncaricoSelezionato: integer;
  DataAutorizzazione: TDateTime;
  DataProtocollo: TDateTime;
  DescIncaricoDaAutorizzare: string;
  NumeroProtocollo: string;
  Protocolla: boolean;
  ParametroRicavoSpecifico: double;
  StringList: TStringList;
  sp: TSP_incarico_Autorizza;
  oldRecNo: integer;
begin
  DataSet := GetDataSet('IncarichiDaAutorizzare');

  if DataSet.IsEmpty then
    exit;

  IdIncaricoSelezionato := DataSet.FieldByName('ID_INCARICO').AsInteger;
  Protocolla := DataSet.FieldByName('RICHIEDE_PROTOCOLLO').AsBoolean;
  RichiedeContratto := DataSet.FieldByName('RICHIEDE_CONTRATTO').AsBoolean;
  DataAutorizzazione := Date;

  DataProtocollo := Date;
  NumeroProtocollo := '';
  ParametroRicavoSpecifico := 0;

  if not DataSet.FieldByName('DATA_PROTOCOLLO').IsNull then
    DataProtocollo := DataSet.FieldByName('DATA_PROTOCOLLO').AsDateTime;

  if not DataSet.FieldByName('NUMERO_PROTOCOLLO').IsNull then
    NumeroProtocollo := DataSet.FieldByName('NUMERO_PROTOCOLLO').AsString;

  StringList := TStringList.create;
  try
    StringList.add('Id Incarico: ' + DataSet.FieldByName('ID_INCARICO').AsString);
    StringList.add('Collaboratore: ' + DataSet.FieldByName('NOMINATIVO_O_RAGIONE_SOCIALE').AsString);
    StringList.add('Progetto: ' + DataSet.FieldByName('DENOMINAZIONE_PROGETTO').AsString);
    StringList.add('Tipo Incarico: ' + DataSet.FieldByName('TIPO_INCARICO').AsString);
    StringList.add('Tipo Incarico: ' + DataSet.FieldByName('TIPO_INCARICO').AsString);
    StringList.add('Finanziamento: ' + DataSet.FieldByName('FINANZIAMENTO').AsString);
    StringList.add('Tipo Finanziamento: ' + DataSet.FieldByName('TIPO_FINANZIAMENTO').AsString);
    DescIncaricoDaAutorizzare := StringList.Text;
  finally
    FreeAndNil(StringList);
  end;

  if not ChiediParametriProtocolloIncarico(Protocolla, DescIncaricoDaAutorizzare, DataAutorizzazione, DataProtocollo, NumeroProtocollo, ParametroRicavoSpecifico) then
    exit;

  sp := TSP_incarico_Autorizza.create(WriteTrans);
  try
    sp.Id_Incarico := IdIncaricoSelezionato;
    sp.Data_Autorizzazione := DataAutorizzazione;

    if Protocolla then
    begin
      sp.Data_Protocollo := DataProtocollo;
      sp.Numero_Protocollo := NumeroProtocollo;
      sp.Parametro_Ricavo_Specifico := ParametroRicavoSpecifico;
    end
    else
    begin
      sp.Data_Protocollo.Clear;
      sp.Numero_Protocollo.Clear;
    end;

    sp.ExecuteAndCommit;
  finally
    FreeAndNil(sp);
  end;

  /// ////////////////////
  /// ////////////////////
  /// ////////////////////
  ///

  /// ////////////////////

  if RichiedeContratto then
    if Config.ExecBooleanFunc('CURRENT_USER_STAMPA_AUTOMATICA_CONTRATTO') then
    begin
      DataSet.RefreshRecord(false); // <-- deve recuperare i valori di protocollo e della carta intestata [variati da data protocollo]
      ReportsManager.WithOid(IdIncaricoSelezionato).Preview('Contratto', DataSet);
    end;

  /// ////////////////////
  /// ////////////////////
  /// Con reopen elimina il record corrente, essendo escluso dal filtro.
  /// RecNo dovrebbe posizionare sul record successivo [richiesta di Paolo]

  StartWait('Attendere...', true);
  try
    DataSet.DisableControls;
    try
      oldRecNo := DataSet.RecNo;
      DataSet.Reopen(true); // <-------------------
      DataSet.RecNo := oldRecNo;
    finally
      DataSet.EnableControls;
    end;
  finally
    StopWait;
  end;
  /// ////////////////////
  /// ////////////////////
  /// ////////////////////
end;

function TProgetti.GetLezioniDaRendicontare(out Data: TDateTime; out IdProgetto: integer): boolean;
var
  DataSet: TzFbDataSet;
begin
  result := false;

  DataSet := GetDataSet('LezioniDaRendicontare');

  result := not DataSet.IsEmpty;

  if not result then
    exit;

  Data := DataSet.FieldByName('DATA_LEZIONE').AsDateTime;
  IdProgetto := IdProgettoSelezionato;
end;

procedure TProgetti.EsportaPDFFirmatiDigitalmente;
var
  Contratti, Allegati: TzFbDataSet;
  folder: string;
  srcFileName: string;
  dstFileName: string;
begin

  if not sbdSelectFolderDialog.Execute then
    exit;

  folder := IncludeTrailingPathDelimiter(sbdSelectFolderDialog.Path);

  Contratti := GetDataSet('RiepilogoContrattiFirmatiDigitalmente');
  Allegati := GetDataSet('RiepilogoContrattiFirmatiDigitalmenteAllegati');

  ProgressBox.Show(Contratti.RecordCountFromServer(), 'Export Contratti', 'Export Contratti', 'Attendere...');
  try
    Contratti.First;
    while not Contratti.Eof do
    begin
      ProgressBox.IncProgress(Contratti.FieldByName('NOMINATIVO_O_RAGIONE_SOCIALE').AsString);

      if ProgressBox.Cancelled then
        exit;

      Allegati.First;
      while not Allegati.Eof do
      begin
        srcFileName := Allegati.FieldByName('FULL_FILE_NAME').AsString;
        dstFileName := folder + ExtractFileName(srcFileName);

        if TFile.Exists(srcFileName) then
          TFile.Copy(srcFileName, dstFileName, true);

        Allegati.Next;
      end;

      Contratti.Next;
    end;

    ShellExecute(0, PCHAR('open'), PCHAR(folder), nil, nil, SW_RESTORE);
  finally
    ProgressBox.Close;
  end;
end;

function TProgetti.DataStampaBandoDocenti: TDateTime;
var
  sp: TSP_BANDO_DOCENTI_GET_DATA_STAMPA;
  IdProgetto: integer;
begin
  result := Date;

  IdProgetto := IdProgettoSelezionato;

  if IdProgetto = -1 then
    exit;

  sp := getSp<TSP_BANDO_DOCENTI_GET_DATA_STAMPA>;
  try
    sp.Id_Progetto := IdProgetto;
    sp.ExecuteAndCommit;

    result := sp.Data_Stampa;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TProgetti.ProgettiAfterOpen(DataSet: TDataSet);
begin
  inherited;

  // codebri
  common.CustomizeDataSet('Progetti', GetDataSet('Progetti'));
end;

procedure TProgetti.TimesheetAnnualeBeforeOpen(DataSet: TDataSet);
var
  Dettaglio, Riepilogo: TzFbDataSet;
  Anno: Variant;
begin
  Dettaglio := DataSet as TzFbDataSet;
  if Dettaglio.Params.FindParam('ANNO') = nil then
    exit;

  Anno := Dettaglio.ParamByName('ANNO').Value;

  // la testata prende l'anno dal riepilogo, che e' il dataset su cui l'utente lo imposta
  Riepilogo := FindDataSet('Timesheet_Riepilogo_Annuale');
  if assigned(Riepilogo) and (Riepilogo <> Dettaglio) then
    if Riepilogo.Params.FindParam('ANNO') <> nil then
      if not Riepilogo.ParamByName('ANNO').IsNull then
        Anno := Riepilogo.ParamByName('ANNO').Value;

  if VarIsNull(Anno) then
    Anno := YearOf(Date);

  Dettaglio.ParamByName('ANNO').Value := Anno;
end;

procedure TProgetti.DocentiIncarichiFilterRecord(DataSet: TDataSet; var Accept: boolean);
var
  id: integer;
begin
  inherited;
  // Per la stampa multipla degli incarichi
  id := DataSet.FieldByName('ID_INCARICO').AsInteger;
  Accept := DocentiIncarichiSelezionati.Contains(id);
end;

end.

  zOffice.Word.form

  zSystem
