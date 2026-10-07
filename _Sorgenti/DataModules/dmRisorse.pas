unit dmRisorse;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Vcl.Dialogs,
  Vcl.Controls,
  Vcl.Forms,
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
  dbMaster,
   zProgressBox,
  zFbDataSet,
  zDbViewDlg,
  zDbCardDlg;

type
  TRisorse = class(TBaseDataModule)
    RettificaDlg: TzDbCardDlg;
    dlgProgetti: TzDbViewDlg;
    lkProgetti: TzFbDataSet;
    ProgressBox: TProgressBox;
    lkProgettiSrc: TDataSource;
    Inquadramento: TzFbDataSet;
    cardInquadramento: TzDbCardDlg;
    FilesDaCopiare: TzFbDataSet;
    RisorsaDlg: TzDbCardDlg;
    dlgSupplenti: TzDbViewDlg;
    cardProtocollo: TzDbCardDlg;
    lkEntiSrc: TDataSource;
    lkAutPagProgetti: TzFbDataSet;
    lkAutPagProgettiSrc: TDataSource;
  private
    FGetSelectedDataSetNameFunc: TFunc<string>;
    procedure RilevamentiControlloPeriodicoBeforeOpen(DataSet: TDataSet);
    procedure AziendeConvenzioniNewRecord(DataSet: TDataSet);
    procedure Incarichi_Di_MassimaNewRecord(DataSet: TDataSet);
  private
    procedure ContrattiNewRecord(DataSet: TDataSet);
    procedure ContrattiAfterCreateFields(DataSet: TDataSet);
    procedure ContrattoAnnoFormativoChange(Field: TField);
  private
    // Mantis #107 - 2026-10-07: coerenza fra e-mail e flag firma elettronica sulla scheda persona
    FControlloFirmaInCorso: Boolean;
    procedure RisorseAfterCreateFields(DataSet: TDataSet);
    procedure RisorseEMailChange(Field: TField);
    procedure RisorseFirmaElettronicaChange(Field: TField);
    function EMailUtilizzabilePerFirma(const EMail: string): Boolean;
    function HaIncarichiInCorso(const IdRisorsa: Integer): Boolean;
    procedure AvvisaEMailNonUtilizzabilePerFirma(const EMail: string);
  protected
    procedure GetInquadramento(const idRisorsa: integer; const Data: TDateTime; out IdInquadramento: integer; out TipoContratto: string);
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
    procedure RisorseCampiReadOnly(DataSet: TDataSet);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  public type
    TCP1 = record
      Anno: integer;
      Mese: integer;
      IdProgetto: integer;
      DescProgetto: string;
      procedure Init;
      function MeseStr: string;
    end;
  public
    CP1: TCP1;
    RettificaIndirizzo: Boolean;
    procedure AggiornaControlloPeriodico;
    procedure InviaMail;
    //
    procedure RicalcolaTotaliOreAttribuite;
    //
    procedure RicalcolaOreRecupero;

    function EditaRisorsaCorrente(Inserting: Boolean): integer;
    function RettificaIndirizzoRisorsa: Boolean;

    procedure RettificaIncarico;
    procedure RettificaProtocollo;

    procedure GeneraCollegato;

    procedure GeneraRilevamentiOre(orari: TList<integer>);

    function InserimentoIncarico: Boolean;
    function InserimentoIncaricoDaOrario: Boolean;
    function DuplicaIncarico: Boolean;
    procedure ForzaEliminazioneIncarico;

    procedure CreaUtente;
    procedure CreaUtenteTutor;
    procedure CreaUtenteDominio;

    function IdRisorsaSelezionata: integer;
    function IdIncaricoSelezionato: integer;
    procedure ValidaRilevamentiOre(Ore: TList<integer>; const Validata: Boolean; const DataSetName: String);
    procedure RilevamentiOreSetFatturata(Ore: TList<integer>; const Fatturata: Boolean);

    function LookupProgetto(out IdProgetto: integer; out Descrizione: string): Boolean;
  public
    procedure GeneraIncarichiMancantiDaRilevamenti;
  public
    function PersonaleImportFile(const FileName: string): integer;
    procedure PersonaleElaboraImport;

    function AziendeImportFile(const FileName: string): integer;
    procedure AziendeElaboraImport;
    procedure SpostaAltroProgetto;

    procedure GeneraIncaricoSupplenza;
    procedure AnnullaAttivazioneIncarico;
  public
    procedure CopiaAllegatiDaRichiestaAttivazioneInRisorsa(const idRichiesta: integer);
  public
    function GetRisorsaFromIncarico(const idIncarico: integer): integer;
  public
    procedure Integrazione;
  public
    property GetSelectedDataSetNameFunc: TFunc<string> read FGetSelectedDataSetNameFunc write FGetSelectedDataSetNameFunc;
  public
    RisorseIncarichiSelezionati: TList<integer>;
    procedure RisorseIncarichiFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    procedure AutPagEnteEditValueChanged(Sender: TObject);
    function GeneraAutorizzazioneSelezionaPeriodo(const idRisorsa: integer; var IdEnte, AnnoDal, MeseDal, AnnoAl, MeseAl, IdProgetto: integer;
      var Raggruppamento: string): Boolean;
  public
    function GeneraAutorizzazionePagamentoXRisorsa: Boolean;
  end;

var
  Risorse: TRisorse;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  Winapi.ShellAPI, System.IOUtils, System.DateUtils, dxRichEdit.Control,
  cxImageComboBox, Gesty_StoredProcs, ConfigModule, zCodiceFiscale, zMemoDialog,
  zDX, zMsg, zOffice.Reports, zBaseLib, WizInserimentoIncaricoFrm,
  SmartInspect.VCL.SiAuto, SmartInspect.VCL, zOffice, zOffice.types,
  zOffice.Mail.Utils, zFrmParams, dmCommon, Gesty.Authorizations,
  System.Variants, Gesty.types, Files.Lib, Vcl.Clipbrd, frmSelezionaDate,
  cxDBExtLookupComboBox, zExceptions;

{$R *.dfm}

procedure TRisorse.TCP1.Init;
begin
  Anno := YearOf(Date);
  Mese := MonthOf(Date);
  IdProgetto := -1;
  DescProgetto := '';
end;

function TRisorse.TCP1.MeseStr: string;
begin
  Result := FormatSettings.LongMonthNames[Mese];
end;

constructor TRisorse.Create(aOwner: TComponent);
begin
  inherited;
  FGetSelectedDataSetNameFunc := nil;
  RettificaIndirizzo := False;

  RisorseIncarichiSelezionati := TList<integer>.Create;

  RisorsaDlg.zSystem := Config.zSystem;

  /// //////////////////////////////////

  CP1.Init;

  ReportsManager.AddVariablesProc := procedure(ReportsManager: TzReportsManager)
    begin
      ReportsManager.AddVariable('ControlloPeriodico_CP1_Anno', CP1.Anno);
      ReportsManager.AddVariable('ControlloPeriodico_CP1_Mese', CP1.Mese);
      ReportsManager.AddVariable('ControlloPeriodico_CP1_MeseStr', CP1.MeseStr);
      ReportsManager.AddVariable('ControlloPeriodico_CP1_IdProgetto', CP1.IdProgetto);
      // zOffice.Reports.AddVariable('ControlloPeriodico_CP1_DescProgetto', StringReplace(CP1.DescProgetto, #39, #96, [rfReplaceAll]));
      ReportsManager.AddVariable('ControlloPeriodico_CP1_DescProgetto', CP1.DescProgetto);

      common.AssegnaVariabiliTimeReport(ReportsManager, IdRisorsaSelezionata, IdIncaricoSelezionato, GetDataSet('Risorse_Incarichi'));
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
          if sameText(ReportsManager.SelectedDataSet.Name, 'Risorse_Incarichi') then
          begin
            DataSet := GetDataSet('Risorse_Incarichi');
            ReportsManager.SetFastReportDataSet(DataSet);

            DataSet.OnFilterRecord := RisorseIncarichiFilterRecord;
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
        DataSet := GetDataSet('Risorse_Incarichi');
        DataSet.Filtered := False;
        DataSet.OnFilterRecord := nil;
      end;
    end;

  common.FirmaElettronica_InitReportsManager(ReportsManager);
end;

procedure TRisorse.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if sameText(DataSetName, 'Risorse') then
  begin
    DataSet.AfterEdit := RisorseCampiReadOnly;
    DataSet.AfterInsert := RisorseCampiReadOnly;
    DataSet.AfterPost := RisorseCampiReadOnly;
    DataSet.AfterCancel := RisorseCampiReadOnly;
    DataSet.OnAfterCreateFields := RisorseAfterCreateFields;
  end
  else
    if sameText(DataSetName, 'RilevamentiControlloPeriodico') then
      DataSet.BeforeOpen := RilevamentiControlloPeriodicoBeforeOpen
    else
      if sameText(DataSetName, 'Aziende_Convenzioni') then
        DataSet.OnNewRecord := AziendeConvenzioniNewRecord
      else
        if sameText(DataSetName, 'Incarichi_Di_Massima') then
          DataSet.OnNewRecord := Incarichi_Di_MassimaNewRecord
        else
          if sameText(DataSetName, 'Contratti') then
          begin
            DataSet.OnNewRecord := ContrattiNewRecord;
            DataSet.OnAfterCreateFields := ContrattiAfterCreateFields;
          end
          else
            if sameText(DataSetName, 'Contratti_Elenco') then
            begin
              DataSet.OnNewRecord := ContrattiNewRecord;
              DataSet.OnAfterCreateFields := ContrattiAfterCreateFields;
            end;
end;

function TRisorse.IdRisorsaSelezionata: integer;
var
  DataSet: TzFbDataSet;
begin
  Result := -1;

  DataSet := GetDataSet('Risorse');

  if not DataSet.IsEmpty then
    Result := DataSet.FieldByName('ID_RISORSA').AsInteger;
end;

function TRisorse.IdIncaricoSelezionato(): integer;
var
  DataSet: TzFbDataSet;
begin
  Result := -1;

  DataSet := GetDataSet('Risorse_Incarichi');
  if assigned(DataSet) then
    if not DataSet.IsEmpty then
      Result := DataSet.FieldByName('ID_INCARICO').AsInteger;
end;

function TRisorse.LookupProgetto(out IdProgetto: integer; out Descrizione: string): Boolean;
begin
  Result := False;

  lkProgettiSrc.Enabled := False; // altrimenti edProgetto riassegna il valore
  try
    lkProgetti.RevertSQL(true);
    try
      Result := dlgProgetti.Execute;

      if Result then
      begin
        IdProgetto := lkProgetti.FieldByName('ID_PROGETTO').AsInteger;
        Descrizione := lkProgetti.FieldByName('DENOMINAZIONE_PROGETTO').asString;
      end;
    finally
      lkProgetti.Active := False;
    end;
  finally
    lkProgettiSrc.Enabled := true;
  end;
end;

procedure TRisorse.ValidaRilevamentiOre(Ore: TList<integer>; const Validata: Boolean; const DataSetName: String);
var
  id: integer;
  sp: TSP_ore_Rilevate_Set_Validazione;
  msg: string;
  Errori: TStringBuilder;
  Elaborati: integer;
  Scartati: integer;
  Annullata: Boolean;
  Esito: string;
begin
  if Ore.Count = 0 then
    Exit;

  if Validata then
    msg := 'Convalidare tutti rilevamenti selezionati?'
  else
    msg := 'Annullare la validizione per i rilevamenti selezionati?';

  if not ConfirmYesNo(msg) then
    Exit;

  Elaborati := 0;
  Scartati := 0;
  Annullata := False;

  Errori := TStringBuilder.Create;
  try
    ProgressBox.show(Ore.Count, 'Validazione Ore', 'Validazione Ore', 'Attendere...');
    try
      sp := TSP_ore_Rilevate_Set_Validazione.Create(WriteTrans);
      try
        for id in Ore do
        begin
          ProgressBox.IncProgress;
          if ProgressBox.Cancelled then
          begin
            Annullata := true;
            Break;
          end;

          sp.Id_Rilevamento_Ore := id;
          sp.Validata := Validata;

          // Ogni rilevamento ha il suo commit: uno scarto non deve fermare gli altri.
          // InternalExecute ha gia' eseguito il rollback della riga fallita.
          try
            sp.ExecuteAndCommit;
            Inc(Elaborati);
          except
            on E: Exception do
            begin
              Inc(Scartati);
              SiMain.LogException(E);
              Errori.AppendLine(Format('Rilevamento %d', [id]));
              Errori.AppendLine(GetErrorMessage(E).Trim);
              Errori.AppendLine('');
            end;
          end;
        end;
      finally
        FreeAndNil(sp);
      end;
    finally
      ProgressBox.Close;
    end;

    // Sempre, anche dopo errori o annullamento: la griglia deve rispecchiare
    // le righe effettivamente validate.
    RefreshDataSet(DataSetName);

    if (Scartati = 0) and (not Annullata) then
      Exit;

    Esito := Format('Rilevamenti selezionati: %d', [Ore.Count]) + sLineBreak + Format('Elaborati: %d', [Elaborati]) + sLineBreak + Format('Scartati: %d', [Scartati]) + sLineBreak;

    if Annullata then
      Esito := Esito + 'Elaborazione interrotta dall''utente.' + sLineBreak;

    if Scartati > 0 then
      Esito := Esito + sLineBreak + Errori.ToString;

    zExecuteMemoDialog(Esito, 'Validazione Ore: esito');
  finally
    FreeAndNil(Errori);
  end;
end;

procedure TRisorse.RilevamentiControlloPeriodicoBeforeOpen(DataSet: TDataSet);
var
  ControlloPeriodico: TzFbDataSet;
begin
  ControlloPeriodico := GetDataSet('RilevamentiControlloPeriodico');

  ControlloPeriodico.ParamByName('MESE').AsInteger := CP1.Mese;
  ControlloPeriodico.ParamByName('ANNO').AsInteger := CP1.Anno;
  ControlloPeriodico.ParamByName('ID_PROGETTO').AsInteger := CP1.IdProgetto;
end;

procedure TRisorse.AggiornaControlloPeriodico;
var
  ControlloPeriodico: TzFbDataSet;
begin
  ControlloPeriodico := GetDataSet('RilevamentiControlloPeriodico');
  ControlloPeriodico.ReOpen(true);
end;

procedure TRisorse.InviaMail;
var
  DataSet: TzFbDataSet;
  Mail: TMail;
begin
  DataSet := GetDataSet('Risorse');

  if DataSet.IsEmpty then
    Exit;

  CheckSMTPServerParams;

  Mail.Init;
  Mail.A := DataSet.FieldByName('E_MAIL_ENTE').asString;

  if Mail.A.IsEmpty then
    Mail.A := DataSet.FieldByName('E_MAIL').asString;

  WriteMail(Mail, SMTPServerParams, common.GetMailRisorse);
end;

procedure TRisorse.RicalcolaTotaliOreAttribuite;
var
  sp: TSP_risorse_Totali_Ore_Ricalcola;
  DataSet: TzFbDataSet;
begin

  if not ConfirmYesNo('Si desidera ricalcolare i totali ore assegnate?', mtWarning) then
    Exit;

  StartWait('Attendere...', true);
  try
    sp := TSP_risorse_Totali_Ore_Ricalcola.Create(WriteTrans);
    try
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    ///
    DataSet := FindDataSet('Risorse_Totali_Ore');
    if assigned(DataSet) then
      DataSet.ReOpen(False);

    DataSet := FindDataSet('Risorse_Totali_Ore_Elenco');
    if assigned(DataSet) then
      DataSet.ReOpen(False);
    ///
  finally
    StopWait;
  end;
end;

procedure TRisorse.RicalcolaOreRecupero;
var
  sp: TSP_personale_Ore_Recupero_Calcola;
  DataSet: TzFbDataSet;
begin

  if not ConfirmYesNo('Si desidera ricalcolare le ore di recupero?', mtWarning) then
    Exit;

  StartWait('Attendere...', true);
  try
    sp := TSP_personale_Ore_Recupero_Calcola.Create(WriteTrans);
    try
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    ///
    DataSet := FindDataSet('Personale_Ore_Recupero');
    if assigned(DataSet) then
      DataSet.ReOpen(False);

    DataSet := FindDataSet('Personale_Ore_Recupero _Elenco');
    if assigned(DataSet) then
      DataSet.ReOpen(False);
    ///
  finally
    StopWait;
  end;
end;

procedure TRisorse.RettificaIncarico;
const
  DataSetName = 'Risorse_Incarichi';
var
  id: integer;
  DataSet: TzFbDataSet;
begin
  inherited;

  DataSet := GetDataSet(DataSetName);

  if DataSet.IsEmpty then
    Exit;

  id := DataSet.FieldByName('ID_INCARICO').AsInteger;
  if ApriRettificaIncarico(id) <> -1 then
    DataSet.ReOpen(true);
end;

function TRisorse.EditaRisorsaCorrente(Inserting: Boolean): integer;

  procedure PrepareDialog(isAzienda: Boolean; Inserting: Boolean);
  begin

    if isAzienda then
    begin
      if Inserting then
        RisorsaDlg.Caption := 'Inserimento Azienda'
      else
        RisorsaDlg.Caption := 'Scheda Azienda';
      RisorsaDlg.CardID := '__shared.Azienda'
    end
    else
    begin

      if Inserting then
        RisorsaDlg.Caption := 'Inserimento Persona'
      else
        RisorsaDlg.Caption := 'Scheda Persona';

      RisorsaDlg.CardID := '__shared.Personale';
    end;
  end;

var
  Risorse: TzFbDataSet;
  dlg: TzDbCardDlg;
  isAzienda: Boolean;
  ok: Boolean;
  TipoRisorsa: string;
begin
  Result := -1;

  Risorse := GetDataSet('Risorse');

  RisorsaDlg.DestroyControls;

  if Inserting then
  begin
    // isAzienda

    if not InputCombo('Tipo Risorsa', 'Tipo Risorsa', TipoRisorsa, nil, nil, true, true,
      procedure(dlg: TInputDialog)
      begin
        dx.InitPickList((dlg.cxCustomEdit as TcxImageComboBox).Properties, 'TIPO_RISORSA');
      end) then
      Exit;

    isAzienda := TipoRisorsa = 'A';

    if isAzienda then
    begin
      Risorse.Append;
      Risorse.FieldByName('TIPO_RISORSA').asString := 'A';
      Risorse.FieldByName('DATA_ATTIVAZIONE').AsDateTime := Date;
      Risorse.FieldByName('DATA_DISATTIVAZIONE').AsDateTime := EncodeDate(9999, 12, 31);
      Risorse.FieldByName('AUTORIZZAZIONE_USO_IMMAGINE').asBoolean := true;
      Risorse.FieldByName('AUTORIZZAZIONE_IMM_DAL_GIORNO').AsDateTime := Date;
      Risorse.FieldByName('AUTORIZZAZIONE_IMM_AL_GIORNO').AsDateTime := EncodeDate(9999, 12, 31);
      Risorse.FieldByName('INFORMATIVA_PRIVACY_FIRMATA').asBoolean := False;
      Risorse.FieldByName('DIPENDENTE_PUBBLICO').asBoolean := False;
    end
    else
    begin
      Risorse.Append;
      Risorse.FieldByName('TIPO_RISORSA').asString := 'P';
      // Mantis #107 - 2026-10-07: la persona nasce senza firma elettronica e il flag si attiva
      // da solo quando l'operatore compila un'e-mail valida per la firma
      FControlloFirmaInCorso := True;
      try
        Risorse.FieldByName('FIRMA_ELETTRONICA').AsBoolean := False;
      finally
        FControlloFirmaInCorso := False;
      end;
      Risorse.FieldByName('DATA_ATTIVAZIONE').AsDateTime := Date;
      Risorse.FieldByName('DATA_DISATTIVAZIONE').AsDateTime := EncodeDate(9999, 12, 31);
      Risorse.FieldByName('AUTORIZZAZIONE_USO_IMMAGINE').asBoolean := true;
      Risorse.FieldByName('AUTORIZZAZIONE_IMM_DAL_GIORNO').AsDateTime := Date;
      Risorse.FieldByName('AUTORIZZAZIONE_IMM_AL_GIORNO').AsDateTime := EncodeDate(9999, 12, 31);
      Risorse.FieldByName('INFORMATIVA_PRIVACY_FIRMATA').asBoolean := False;
      Risorse.FieldByName('DIPENDENTE_PUBBLICO').asBoolean := False;
    end;
  end
  else
  begin
    if Risorse.IsEmpty then
      Exit;

    isAzienda := Risorse.FieldByName('TIPO_RISORSA').asString = 'A';
  end;

  PrepareDialog(isAzienda, Inserting);

  RisorsaDlg.DataSet := Risorse;

  if RisorsaDlg.Execute then
    Result := Risorse.FieldByName('ID_RISORSA').Value;

  RisorsaDlg.DestroyControls;
end;

procedure TRisorse.GeneraCollegato;
const
  DataSetName = 'Risorse_Incarichi';
var
  IdProgetto: integer;
  idIncaricoMaster: integer;
  DataSet: TzFbDataSet;
  DescProgetto: string;
  sp: TSP_incarico_Genera_Collegato;
begin
  inherited;

  DataSet := GetDataSet(DataSetName);

  if DataSet.IsEmpty then
    Exit;

  idIncaricoMaster := DataSet.FieldByName('ID_INCARICO').AsInteger;

  if not LookupProgetto(IdProgetto, DescProgetto) then
    Exit;

  /// ////////////////////////////////////////////////

  StartWait('Attendere...', true);
  try
    sp := TSP_incarico_Genera_Collegato.Create(WriteTrans);
    try
      sp.Id_Progetto := IdProgetto;
      sp.Id_Incarico_Master := idIncaricoMaster;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    DataSet.ReOpen(true);
  finally
    StopWait;
  end;
end;

function TRisorse.InserimentoIncarico: Boolean;
var
  id: integer;
begin
  id := IdRisorsaSelezionata;
  Result := ApriInserimentoIncarico(id) <> -1;

  if Result then
    ReopenDataSet('Risorse_Incarichi');
end;

function TRisorse.InserimentoIncaricoDaOrario: Boolean;
var
  DataSet: TzFbDataSet;
  idOrario: integer;
  sp: TSP_ORARIO_GENERA_RILEVAMENTO;
begin
  DataSet := GetDataSet('RegistroSenzaIncarichi');

  if DataSet.IsEmpty then
    Exit;

  idOrario := DataSet.FieldByName('ID_ORARIO').AsInteger;

  if ApriInserimentoIncaricoDaOrario(idOrario) = -1 then
    Exit;

  StartWait('Attendere...', true);
  try
    sp := TSP_ORARIO_GENERA_RILEVAMENTO.Create(WriteTrans);
    try
      sp.Id_Orario := idOrario;
      sp.Raise_Error := true;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    DataSet.ReOpen(true)
  finally
    StopWait;
  end;
end;

destructor TRisorse.Destroy;
begin
  FreeAndNil(RisorseIncarichiSelezionati);
  inherited;
end;

function TRisorse.DuplicaIncarico: Boolean;
var
  id: integer;
begin
  inherited;

  Result := False;
  id := IdIncaricoSelezionato;

  if id <> -1 then
    Result := ApriDuplicaIncarico(id) <> -1;

  if Result then
    ReopenDataSet('Risorse_Incarichi');
end;

procedure TRisorse.GeneraRilevamentiOre(orari: TList<integer>);
var
  id: integer;
  sp: TSP_ORARIO_GENERA_RILEVAMENTO;
begin
  if orari.Count = 0 then
    Exit;

  if not ConfirmYesNo('Si desidera generare i rilevamenti orari per le voci di registro selezionate?') then
    Exit;

  ProgressBox.show(orari.Count, 'Generazione Rilevamenti Orari', 'Generazione Rilevamenti Orari', 'Attendere...');
  try
    sp := TSP_ORARIO_GENERA_RILEVAMENTO.Create(WriteTrans);
    try
      for id in orari do
      begin
        ProgressBox.IncProgress;
        if ProgressBox.Cancelled then
          Exit;

        sp.Id_Orario := id;
        sp.Raise_Error := true;
        sp.ExecuteAndCommit;
      end;
    finally
      FreeAndNil(sp);
    end;
  finally
    ProgressBox.Close;
  end
end;

function TRisorse.RettificaIndirizzoRisorsa: Boolean;
var
  Risorse: TzFbDataSet;
  isAzienda: Boolean;
begin
  Result := False;

  Risorse := GetDataSet('Risorse');

  if Risorse.IsEmpty then
    Exit;

  RettificaDlg.DestroyControls;

  isAzienda := Risorse.FieldByName('TIPO_RISORSA').asString = 'A';

  if isAzienda then
  begin
    RettificaDlg.Caption := 'Indirizzo Azienda';
    RettificaDlg.CardID := 'Aziende_RettificaIndirizzo';
  end
  else
  begin
    RettificaDlg.Caption := 'Indirizzo Risorsa';
    RettificaDlg.CardID := 'Personale_RettificaIndirizzo';
  end;

  RettificaDlg.zSystem := Config.zSystem;
  RettificaDlg.DataSet := Risorse;

  RettificaIndirizzo := true;
  try
    Risorse.CheckEditMode;
    Result := RettificaDlg.Execute;
    RettificaDlg.DestroyControls;
  finally
    RettificaIndirizzo := False;
  end;
end;

procedure TRisorse.RisorseAfterCreateFields(DataSet: TDataSet);
begin
  // Mantis #107 - 2026-10-07
  DataSet.FieldByName('E_MAIL').OnChange := RisorseEMailChange;
  DataSet.FieldByName('FIRMA_ELETTRONICA').OnChange := RisorseFirmaElettronicaChange;
end;

function TRisorse.EMailUtilizzabilePerFirma(const EMail: string): Boolean;
var
  Esito: Variant;
begin
  // Mantis #107 - 2026-10-07: stessa regola della funzione E_MAIL_VALIDA del database (formato
  // accettato da Namirial eSignAnyWhere), applicata al testo sanificato come fa l'invio della
  // busta: i due controlli devono dare lo stesso esito
  if Trim(EMail) = '' then
    Exit(False);

  Esito := Config.Database.ExecSQLScalar('SELECT E_MAIL_VALIDA(SANIFICATION.SANIFICA_TESTO(:EMAIL)) FROM RDB$DATABASE', [EMail]);
  Result := (not VarIsNull(Esito)) and (Esito = True);
end;

function TRisorse.HaIncarichiInCorso(const IdRisorsa: Integer): Boolean;
begin
  // Mantis #107 - 2026-10-07: con un incarico in corso o futuro, un flag spento significa che i
  // contratti cartacei sono gia' stati stampati
  Result := Config.Database.ExecSQLScalar('SELECT IIF(EXISTS(SELECT 1 FROM INCARICHI WHERE INCARICHI.ID_RISORSA = :ID_RISORSA AND INCARICHI.DATA_FINE_INCARICO >= CURRENT_DATE), 1, 0) FROM RDB$DATABASE', [IdRisorsa]) = 1;
end;

procedure TRisorse.AvvisaEMailNonUtilizzabilePerFirma(const EMail: string);
begin
  if Trim(EMail) = '' then
    ConfirmOk('Senza un indirizzo e-mail la persona non potrà essere usata per le firme elettroniche. Il flag firma elettronica è stato disattivato.', mtWarning)
  else
    ConfirmOk('L''indirizzo e-mail non è valido per la firma elettronica (formato richiesto dal fornitore di firma): la persona non potrà essere usata per le firme elettroniche. Il flag firma elettronica è stato disattivato.', mtWarning);
end;

procedure TRisorse.RisorseEMailChange(Field: TField);
var
  DataSet: TDataSet;
  FirmaElettronica: TField;
begin
  // Mantis #107 - 2026-10-07: e-mail valida = il flag si attiva subito dopo il campo; non valida =
  // avviso e flag spento. Vale per le sole persone: per le aziende l'e-mail di firma e' un'altra
  if FControlloFirmaInCorso then
    Exit;

  DataSet := Field.DataSet;
  if DataSet.FieldByName('TIPO_RISORSA').AsString <> 'P' then
    Exit;

  FirmaElettronica := DataSet.FieldByName('FIRMA_ELETTRONICA');

  FControlloFirmaInCorso := True;
  try
    if EMailUtilizzabilePerFirma(Field.AsString) then
    begin
      if (not FirmaElettronica.AsBoolean) and
         ((DataSet.State = dsInsert) or (not HaIncarichiInCorso(DataSet.FieldByName('ID_RISORSA').AsInteger))) then
        FirmaElettronica.AsBoolean := True;
    end
    else
    begin
      if FirmaElettronica.AsBoolean or (Trim(Field.AsString) <> '') then
        AvvisaEMailNonUtilizzabilePerFirma(Field.AsString);

      if FirmaElettronica.AsBoolean then
        FirmaElettronica.AsBoolean := False;
    end;
  finally
    FControlloFirmaInCorso := False;
  end;
end;

procedure TRisorse.RisorseFirmaElettronicaChange(Field: TField);
var
  DataSet: TDataSet;
begin
  // Mantis #107 - 2026-10-07: un flag acceso a mano senza e-mail valida viene respinto con un avviso
  if FControlloFirmaInCorso then
    Exit;

  DataSet := Field.DataSet;
  if (not Field.AsBoolean) or (DataSet.FieldByName('TIPO_RISORSA').AsString <> 'P') then
    Exit;

  if EMailUtilizzabilePerFirma(DataSet.FieldByName('E_MAIL').AsString) then
    Exit;

  FControlloFirmaInCorso := True;
  try
    AvvisaEMailNonUtilizzabilePerFirma(DataSet.FieldByName('E_MAIL').AsString);
    Field.AsBoolean := False;
  finally
    FControlloFirmaInCorso := False;
  end;
end;

procedure TRisorse.RisorseCampiReadOnly(DataSet: TDataSet);
var
  Modificabile: Boolean;
begin
  Modificabile := (DataSet.state = dsInsert) or (RettificaIndirizzo);

  DataSet.DisableControls;
  try
    DataSet.FieldByName('RESIDENZA_INDIRIZZO').ReadOnly := not Modificabile;
    DataSet.FieldByName('RESIDENZA_NUMERO_CIVICO').ReadOnly := not Modificabile;
    DataSet.FieldByName('RESIDENZA_CAP').ReadOnly := not Modificabile;
    DataSet.FieldByName('RESIDENZA_CITTA').ReadOnly := not Modificabile;
    DataSet.FieldByName('RESIDENZA_PROVINCIA').ReadOnly := true;
    DataSet.FieldByName('RESIDENZA_LOCALITA').ReadOnly := not Modificabile;
    DataSet.FieldByName('RESIDENZA_SIGLA_STATO').ReadOnly := not Modificabile;
    DataSet.FieldByName('DOMICILIO_INDIRIZZO').ReadOnly := not Modificabile;
    DataSet.FieldByName('DOMICILIO_NUMERO_CIVICO').ReadOnly := not Modificabile;
    DataSet.FieldByName('DOMICILIO_CAP').ReadOnly := not Modificabile;
    DataSet.FieldByName('DOMICILIO_CITTA').ReadOnly := not Modificabile;
    DataSet.FieldByName('DOMICILIO_PROVINCIA').ReadOnly := true;
    DataSet.FieldByName('DOMICILIO_LOCALITA').ReadOnly := not Modificabile;
    DataSet.FieldByName('DOMICILIO_SIGLA_STATO').ReadOnly := not Modificabile;
    DataSet.FieldByName('PERMESSO_DI_SOGGIORNO_NUMERO').ReadOnly := not Modificabile;
    DataSet.FieldByName('PERMESSO_DI_SOGGIORNO_SCADENZA').ReadOnly := not Modificabile;

    DataSet.FieldByName('SEDE_LEGALE_INDIRIZZO').ReadOnly := not Modificabile;
    DataSet.FieldByName('SEDE_LEGALE_NUMERO_CIVICO').ReadOnly := not Modificabile;
    DataSet.FieldByName('SEDE_LEGALE_CITTA').ReadOnly := not Modificabile;
    DataSet.FieldByName('SEDE_LEGALE_PROVINCIA').ReadOnly := true;
    DataSet.FieldByName('SEDE_LEGALE_CAP').ReadOnly := not Modificabile;
    DataSet.FieldByName('SEDE_LEGALE_SIGLA_STATO').ReadOnly := not Modificabile;
  finally
    DataSet.EnableControls;
  end;

  if assigned(RisorsaDlg.zDbCardForm) then
    if assigned(RisorsaDlg.zDbCardForm.zDbCard) then
      RisorsaDlg.zDbCardForm.zDbCard.UpdateColors;

  if assigned(RettificaDlg.zDbCardForm) then
    if assigned(RettificaDlg.zDbCardForm.zDbCard) then
      RettificaDlg.zDbCardForm.zDbCard.UpdateColors;
end;

procedure TRisorse.AziendeConvenzioniNewRecord(DataSet: TDataSet);
var
  Risorse: TzFbDataSet;
begin
  inherited;
  DataSet.FieldByName('ID_ENTE').Value := common.EnteDefault;

  Risorse := GetDataSet('Risorse');
  DataSet.FieldByName('ID_DELEGATO_FIRMA').Value := Risorse.FieldByName('ID_LEGALE_RAPPRESENTANTE').Value;

  if not DataSet.FieldByName('ID_DELEGATO_FIRMA').IsNull then
    DataSet.FieldByName('DELEGATO_FIRMA_QUALIFICA').Value := 'Titolare';
end;

procedure TRisorse.Incarichi_Di_MassimaNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('ID_ENTE').AsInteger := common.EnteDefault;
  DataSet.FieldByName('ANNO_FORMATIVO').asString := common.AnnoFormativoCorrente;
  DataSet.FieldByName('ID_ESTENSORE_RICHIESTA').AsInteger := common.CurrentIdRisorsa;
end;

procedure TRisorse.GeneraIncarichiMancantiDaRilevamenti;
var
  DataSet: TzFbDataSet;
  idDocente: integer;
  IdProgetto: integer;
  TipoIncarico: string;
  Materia: string;
  PIP: Boolean;
  DataInizio, DataFine: TDateTime;
  sp: TSP_INCARICHI_RILEVATI_DA_GENEARE;
  TotaleOreAttribuite: double;
begin
  DataSet := GetDataSet('RilevamentiSenzaIncarico');

  if DataSet.IsEmpty then
    Exit;

  idDocente := -1;
  IdProgetto := -1;
  TipoIncarico := '';;
  Materia := '';
  PIP := False;

  DataInizio := 0;
  DataFine := 0;
  TotaleOreAttribuite := 0;

  idDocente := DataSet.FieldByName('ID_RISORSA').AsInteger;
  IdProgetto := DataSet.FieldByName('ID_PROGETTO').AsInteger;
  TipoIncarico := DataSet.FieldByName('TIPO_INCARICO').asString;
  Materia := DataSet.FieldByName('MATERIA').asString;
  PIP := not DataSet.FieldByName('ID_PIANO_PERSONALIZZATO').IsNull;

  StartWait('Attendere...', true);
  try
    sp := TSP_INCARICHI_RILEVATI_DA_GENEARE.Create(WriteTrans);
    try
      sp.Id_Risorsa := idDocente;
      sp.Id_Progetto := IdProgetto;
      sp.TIPO_INCARICO := TipoIncarico;
      sp.Materia := Materia;
      sp.PIP := PIP;
      sp.ExecuteAndCommit;
      DataInizio := sp.DATA_INIZIO;
      DataFine := sp.DATA_FINE;
      TotaleOreAttribuite := sp.TOTALE_ORE_RILEVATE;
    finally
      FreeAndNil(sp);
    end;
  finally
    StopWait;
  end;

  if ApriInserimentoIncarico(idDocente, IdProgetto, DataInizio, DataFine, TipoIncarico, Materia, TotaleOreAttribuite) <> -1 then
    GetDataSet('RilevamentiSenzaIncarico').ReOpen();
end;

function TRisorse.PersonaleImportFile(const FileName: string): integer;
var
  sp: TSP_PERSONALE_IMPORT_FILES_ADD;
begin
  Result := -1;

  StartWait('Attendere...', true);
  try
    sp := TSP_PERSONALE_IMPORT_FILES_ADD.Create(WriteTrans);
    try
      sp.Nome_File := ExtractFileName(FileName);
      sp.File_Originale.LoadFromFile(FileName);
      sp.ExecuteAndCommit;
      Result := sp.ID_PERSONALE_IMPORT_FILE;
    finally
      FreeAndNil(sp);
    end;
  finally
    StopWait;
  end;
end;

procedure TRisorse.PersonaleElaboraImport;
var
  DataSet: TzFbDataSet;
  id: integer;
  sp: TSP_PERSONALE_IMPORT_FILES_ELABORA;
begin
  DataSet := GetDataSet('Personale_Import_Files');

  if DataSet.IsEmpty then
    Exit;

  id := DataSet.FieldByName('ID_PERSONALE_IMPORT_FILE').AsInteger;

  StartWait('Attendere...', true);
  try
    sp := TSP_PERSONALE_IMPORT_FILES_ELABORA.Create(WriteTrans);
    try
      sp.ID_PERSONALE_IMPORT_FILE := id;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    DataSet.RefreshRecord(False);
  finally
    StopWait;
  end;
end;

function TRisorse.AziendeImportFile(const FileName: string): integer;
var
  sp: TSP_AZIENDE_IMPORT_FILES_ADD;
begin
  Result := -1;

  StartWait('Attendere...', true);
  try
    sp := TSP_AZIENDE_IMPORT_FILES_ADD.Create(WriteTrans);
    try
      sp.Nome_File := ExtractFileName(FileName);
      sp.File_Originale.LoadFromFile(FileName);
      sp.ExecuteAndCommit;
      Result := sp.ID_AZIENDE_IMPORT_FILE;
    finally
      FreeAndNil(sp);
    end;
  finally
    StopWait;
  end;
end;

procedure TRisorse.AziendeElaboraImport;
var
  DataSet: TzFbDataSet;
  id: integer;
  sp: TSP_AZIENDE_IMPORT_FILES_ELABORA;
begin
  DataSet := GetDataSet('Aziende_Import_Files');

  if DataSet.IsEmpty then
    Exit;

  id := DataSet.FieldByName('ID_AZIENDE_IMPORT_FILE').AsInteger;

  StartWait('Attendere...', true);
  try
    sp := TSP_AZIENDE_IMPORT_FILES_ELABORA.Create(WriteTrans);
    try
      sp.ID_AZIENDE_IMPORT_FILE := id;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    DataSet.RefreshRecord(False);
  finally
    StopWait;
  end;
end;

procedure TRisorse.SpostaAltroProgetto;
const
  DataSetName = 'Risorse_Incarichi';
var
  IdProgetto: integer;
  idIncarico: integer;
  DescProgetto: string;
  DataSet: TzFbDataSet;

  sp: TSP_INCARICHI_SPOSTA_PROGETTO;
begin
  inherited;

  DataSet := GetDataSet(DataSetName);

  if DataSet.IsEmpty then
    Exit;

  idIncarico := DataSet.FieldByName('ID_INCARICO').AsInteger;

  if not LookupProgetto(IdProgetto, DescProgetto) then
    Exit;

  /// ////////////////////////////////////////////////

  StartWait('Attendere...', true);
  try
    sp := TSP_INCARICHI_SPOSTA_PROGETTO.Create(WriteTrans);
    try
      sp.Id_Incarico := idIncarico;
      sp.Id_Progetto := IdProgetto;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    DataSet.ReOpen(true);
  finally
    StopWait;
  end;
end;

procedure TRisorse.GeneraIncaricoSupplenza;
var
  idIncaricoOrigine: integer;
  IdSupplente: integer;
  idIncaricoSupplenza: integer;
  sp: TSP_INCARICO_GENERA_SUPPLENZA;

  function SelezionaSupplente: integer;
  var
    Supplenti: TzFbDataSet;
  begin
    Result := -1;

    Supplenti := GetDataSet('Supplenti');

    Supplenti.RevertSQL(true);
    try
      dlgSupplenti.DataSet := Supplenti;
      if dlgSupplenti.Execute() then
        Result := Supplenti.FieldByName('ID_DOCENTE').AsInteger;
    finally
      Supplenti.Active := False;
    end;
  end;

begin
  inherited;
  // proc per generare
  // rettifica

  idIncaricoOrigine := IdIncaricoSelezionato;

  if idIncaricoOrigine = -1 then
    Exit;

  IdSupplente := SelezionaSupplente;

  if IdSupplente = -1 then
    Exit;

  StartWait('Attendere...', true);
  try
    sp := TSP_INCARICO_GENERA_SUPPLENZA.Create(WriteTrans);
    try
      sp.ID_INCARICO_DA_SOSTITUIRE := idIncaricoOrigine;
      sp.ID_DOCENTE_SUPPLENTE := IdSupplente;
      sp.TOTALE_ORE_ATTRIBUITE := 1;
      sp.ExecuteAndCommit;
      idIncaricoSupplenza := sp.ID_INCARICO_SUPPLENZA;
    finally
      FreeAndNil(sp);
    end;
  finally
    StopWait;
  end;

  ApriRettificaIncarico(idIncaricoSupplenza);
  RefreshDataSet('Risorse_Incarichi');
end;

procedure TRisorse.CopiaAllegatiDaRichiestaAttivazioneInRisorsa(const idRichiesta: integer);
var
  src: string;
  Dest: string;
begin
  ProgressBox.show(1, 'Copia Allegati', 'Copia allegati', 'Attendere...');
  try
    FilesDaCopiare.RevertSQL(False);
    FilesDaCopiare.ParamByName('ID_RICHIESTA_ATTIVAZIONE').AsInteger := idRichiesta;
    FilesDaCopiare.Active := true;
    try
      ProgressBox.MaxValue := FilesDaCopiare.RecordCountFromServer();
      FilesDaCopiare.First;
      while not FilesDaCopiare.Eof do
      begin
        src := FilesDaCopiare.FieldByName('SRC_FILE_NAME').asString;
        Dest := FilesDaCopiare.FieldByName('DEST_FILE_NAME').asString;
        SiMain.LogString('FileSorgente', src);
        SiMain.LogString('FileDestinazione', Dest);

        ProgressBox.IncProgress('Copia di ' + src, 'Destinazione ' + Dest);

        if TFile.Exists(src) then
        begin

          try
            ForceDirectories(ExtractFilePath(Dest));
          except
            on E: Exception do
            begin
              ConfirmOk('Impossibile creare la cartella: ' + ExtractFilePath(Dest));
              raise;
            end;
          end;

          if not TFile.Exists(Dest) then
            TFile.Copy(src, Dest);
        end;

        FilesDaCopiare.next;
      end;
    finally
      FilesDaCopiare.Active := False;
    end;

  finally
    ProgressBox.Close;
  end;
end;

procedure TRisorse.CreaUtente;
var
  Risorse: TzFbDataSet;
  idRisorsa: integer;
  UserName: String;
begin
  Risorse := GetDataSet('Risorse');

  if not assigned(Risorse) then
    Exit;

  if not Risorse.FieldByName('USER_ID').IsNull then
  begin
    ConfirmOk('Utente già generato per la risorsa selezionata.');
    Exit;
  end;

  idRisorsa := Risorse.FieldByName('ID_RISORSA').AsInteger;

  if Risorse.FieldByName('TIPO_RISORSA').asString = 'P' then
    UserName := common.CalcUserName(Risorse.FieldByName('COGNOME').asString, Risorse.FieldByName('NOME').asString)
  else
  begin
    // UserName := Risorse.FieldByName('RAGIONE_SOCIALE').asString;

    ConfirmOk('La risorsa selezionata è un''azienda: generare l''utente per il contatto.');
    Exit;
  end;

  if common.CreaUtenteSistema(UserName, idRisorsa) then
  begin
    Risorse.RefreshRecord();
    ConfirmOk('Utente di sistema generato.');
  end;
end;

procedure TRisorse.CreaUtenteTutor;
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
  UserName := common.CalcUserName(Contatti.FieldByName('COGNOME').asString, Contatti.FieldByName('NOME').asString);

  if common.CreaUtenteSistema(UserName, idContatto) then
  begin
    Contatti.RefreshRecord();
    ConfirmOk('Utente di sistema generato.');
  end;
end;

procedure TRisorse.ForzaEliminazioneIncarico;
var
  id: integer;
  DataSet: TzFbDataSet;
  sp: TSP_INCARICHI_ELIMINA;
begin
  DataSet := GetDataSet('Risorse_Incarichi');

  if assigned(DataSet) then
    if not DataSet.IsEmpty then
      if ConfirmYesNo('Si desidera eliminare l''incarico selezionato?') then
      begin
        id := DataSet.FieldByName('ID_INCARICO').AsInteger;

        StartWait('Attendere...', true);
        try
          sp := TSP_INCARICHI_ELIMINA.Create(WriteTrans);
          try
            sp.Id_Incarico := id;
            sp.ExecuteAndCommit;
          finally
            FreeAndNil(sp);
          end;

          DataSet.ReOpen();
        finally
          StopWait;
        end;
      end;
end;

procedure TRisorse.GetInquadramento(const idRisorsa: integer; const Data: TDateTime; out IdInquadramento: integer; out TipoContratto: string);
var
  sp: TSP_risorse_Get_Inquadramento;
begin
  IdInquadramento := -1;
  TipoContratto := '';

  if idRisorsa = -1 then
    Exit;

  sp := TSP_risorse_Get_Inquadramento.Create(WriteTrans);
  try
    sp.Id_Risorsa := idRisorsa;
    sp.Data_Inizio_Incarico := Data;

    sp.ExecuteWithoutCommit;

    if not sp.Id_Inquadramento.IsNull then
    begin
      IdInquadramento := sp.Id_Inquadramento;
      TipoContratto := sp.Tipo_Contratto;
    end;
  finally
    FreeAndNil(sp);
  end;
end;

function TRisorse.GetRisorsaFromIncarico(const idIncarico: integer): integer;
var
  sp: TSP_INCARICHI_GET_RISORSA;
begin
  Result := -1;

  sp := TSP_INCARICHI_GET_RISORSA.Create(WriteTrans);
  try
    sp.Id_Incarico := idIncarico;

    sp.ExecuteAndCommit;

    if not sp.Id_Risorsa.IsNull then
      Result := sp.Id_Risorsa;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TRisorse.ContrattiAfterCreateFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('ANNO_FORMATIVO').OnChange := ContrattoAnnoFormativoChange;
end;

procedure TRisorse.ContrattiNewRecord(DataSet: TDataSet);
var
  IdInquadramento: integer;
  TipoContratto: string;
begin
  DataSet.FieldByName('ID_ENTE').AsInteger := common.EnteDefault;
  DataSet.FieldByName('ANNO_FORMATIVO').asString := common.AnnoFormativoCorrente;
  DataSet.FieldByName('ID_ESTENSORE_RICHIESTA').AsInteger := common.CurrentIdRisorsa;

  if not DataSet.FieldByName('ID_RISORSA').IsNull then
  begin
    // la data inizio è stata impostata da ContrattoAnnoFormativoChange
    GetInquadramento(DataSet.FieldByName('ID_RISORSA').AsInteger, DataSet.FieldByName('DATA_INIZIO_CONTRATTO').AsDateTime, IdInquadramento, TipoContratto);

    if IdInquadramento <> -1 then
    begin
      DataSet.FieldByName('ID_INQUADRAMENTO').AsInteger := IdInquadramento;
      DataSet.FieldByName('TIPO_CONTRATTO').asString := TipoContratto;
    end;
  end;
end;

procedure TRisorse.ContrattoAnnoFormativoChange(Field: TField);
var
  sp: TSP_ZZ_PERIODO_ANNO_SCOLASTICO;
  annostr: string;
  Data: TDateTime;
begin

  if Field.DataSet.state = dsInsert then
  begin
    sp := TSP_ZZ_PERIODO_ANNO_SCOLASTICO.Create(WriteTrans);
    try
      sp.ANNO_FORMATIVO := Field.DataSet.FieldByName('ANNO_FORMATIVO').asString;
      sp.ExecuteAndCommit;
      Field.DataSet.FieldByName('DATA_INIZIO_CONTRATTO').AsDateTime := sp.DATA_INIZIO_ANNO_SCOLASTICO;
      Field.DataSet.FieldByName('DATA_FINE_CONTRATTO').AsDateTime := sp.DATA_FINE_ANNO_SCOLASTICO;
    finally
      FreeAndNil(sp);
    end;
  end;
end;

procedure TRisorse.Integrazione;
var
  sp: TSP_INCARICHI_INTEGRAZIONI_ADD;
  Incarichi: TzFbDataSet;
  id: integer;
begin
  Incarichi := GetDataSet('Risorse_Incarichi');

  if Incarichi.IsEmpty then
    Exit;

  sp := TSP_INCARICHI_INTEGRAZIONI_ADD.Create(WriteTrans);
  try
    sp.Id_Incarico := Incarichi.FieldByName('ID_INCARICO').AsInteger;
    sp.Data_Integrazione := Date;
    sp.TOTALE_ORE_ATTRIBUITE := Incarichi.FieldByName('TOTALE_ORE_ATTRIBUITE').AsFloat;
    sp.Data_Inizio_Incarico := Incarichi.FieldByName('DATA_INIZIO_INCARICO').AsDateTime;
    sp.Data_Fine_Incarico := Incarichi.FieldByName('DATA_FINE_INCARICO').AsDateTime;

    if not ShowParams('Incarico_Integrazione', sp, 'Integrazione', False,
      procedure(zParamDialog: TzParamDialog)
      begin
        zParamDialog.zDialog.width := 400; // vedere
      end, False, 'ID_INCARICO') then
      Exit;

    StartWait('Attendere...', true);
    try
      sp.ExecuteAndCommit;

      // id := Incarichi.FieldByName('ID_INCARICO').AsInteger;
      Incarichi.RefreshRecord(False);
      // Incarichi.Locate('ID_INCARICO', id, []);
      ReopenDataSet('Incarichi_Integrazioni');
    finally
      StopWait;
    end;
  finally
    FreeAndNil(sp);
  end;
end;

procedure TRisorse.RettificaProtocollo;
var
  DataSet: TzFbDataSet;
begin
  inherited;

  DataSet := GetDataSet('Risorse_Incarichi');

  if DataSet.IsEmpty then
    Exit;

  cardProtocollo.DataSet := DataSet;
  cardProtocollo.Execute;
end;

// Mantis #183 - 2026-10-06: era AnnullaAutorizzazioneIncarico (procedura
// INCARICO_ANNULLA_AUTORIZZAZIONE, ora INCARICO_ANNULLA_ATTIVAZIONE)
procedure TRisorse.AnnullaAttivazioneIncarico;
var
  sp: TSP_incarico_Annulla_Attivazione;
  id: integer;
begin
  id := IdIncaricoSelezionato;

  if id = -1 then
    Exit;

  if not ConfirmYesNo(PChar('Attenzione: si desidera annullare l''attivazione dell''incarico selezionato?'), mtWarning) then
    Exit;

  StartWait('Attendere...', true);
  try

    sp := GetSP<TSP_incarico_Annulla_Attivazione>;
    try
      sp.Id_Incarico := id;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    RefreshDataSet('Risorse_Incarichi');
  finally
    StopWait;
  end;
end;

procedure TRisorse.CreaUtenteDominio;
var
  Risorse: TzFbDataSet;
  idRisorsa: integer;
  UserName: String;
begin
  Risorse := GetDataSet('Risorse');

  if not assigned(Risorse) then
    Exit;

  idRisorsa := Risorse.FieldByName('ID_RISORSA').AsInteger;

  if Risorse.FieldByName('TIPO_RISORSA').asString = 'P' then
    UserName := common.CalcUserName(Risorse.FieldByName('COGNOME').asString, Risorse.FieldByName('NOME').asString)
  else
  begin

    ConfirmOk('La risorsa selezionata è un''azienda.');
    Exit;
  end;

  common.CreaUtenteDominio(UserName, idRisorsa, true);
end;

procedure TRisorse.RilevamentiOreSetFatturata(Ore: TList<integer>; const Fatturata: Boolean);
var
  id: integer;
  sp: TSP_ore_Rilevate_Set_Fatturata;
  msg: string;
begin

  if Fatturata then
    msg := 'Impostare il flag Fatturata per tutti i rilevamenti selezionati?'
  else
    msg := 'Annullare il flag Fatturata per i rilevamenti selezionati?';

  if not ConfirmYesNo(msg) then
    Exit;

  ProgressBox.show(Ore.Count, 'Ore Fatturate', 'Ore Fatturate', 'Attendere...');
  try
    sp := TSP_ore_Rilevate_Set_Fatturata.Create(WriteTrans);
    try

      for id in Ore do
      begin
        ProgressBox.IncProgress;
        if ProgressBox.Cancelled then
          Exit;

        sp.Id_Rilevamento_Ore := id;
        sp.Fatturata := Fatturata;
        sp.ExecuteAndCommit;
      end;
    finally
      FreeAndNil(sp);
    end;

    RefreshDataSet('OreFatturate');
  finally
    ProgressBox.Close;
  end;
end;

procedure TRisorse.RisorseIncarichiFilterRecord(DataSet: TDataSet; var Accept: Boolean);
var
  id: integer;
begin
  inherited;
  // Per la stampa multipla degli incarichi
  id := DataSet.FieldByName('ID_INCARICO').AsInteger;
  Accept := RisorseIncarichiSelezionati.Contains(id);
end;

function TRisorse.GeneraAutorizzazionePagamentoXRisorsa: Boolean;
var
  sp: TSP_AUTORIZZAZIONI_PAGAMENTO_GENERA;
  DataSet: TzFbDataSet;
  idRisorsa: integer;
  IdEnte: integer;
  AnnoDal, MeseDal, AnnoAl, MeseAl: integer;
  IdProgetto: integer;
  Raggruppamento: string;
  dataMesePrecedente: TDateTime;
begin
  Result := False;

  DataSet := GetDataSet('Risorse');
  if DataSet.IsEmpty then
    Exit;

  idRisorsa := DataSet.FieldByName('ID_RISORSA').Value;

  dataMesePrecedente := IncMonth(Date, -1);
  AnnoDal := YearOf(dataMesePrecedente);
  MeseDal := MonthOf(dataMesePrecedente);
  AnnoAl := AnnoDal;
  MeseAl := MeseDal;
  IdEnte := -1;
  IdProgetto := -1;
  // Mantis #172 - 2026-09-25: proposto come la generazione di sempre
  Raggruppamento := 'STD';

  Result := GeneraAutorizzazioneSelezionaPeriodo(idRisorsa, IdEnte, AnnoDal, MeseDal, AnnoAl, MeseAl, IdProgetto, Raggruppamento);

  if not Result then
    Exit;

  StartWait('Attendere...', true);
  try
    sp := GetSP<TSP_AUTORIZZAZIONI_PAGAMENTO_GENERA>;
    try
      sp.Id_Risorsa := idRisorsa;
      sp.Id_Ente := IdEnte;
      sp.Inizio_Anno_Competenza := AnnoDal;
      sp.Inizio_Mese_Competenza := MeseDal;
      sp.Fine_Anno_Competenza := AnnoAl;
      sp.Fine_Mese_Competenza := MeseAl;
      if IdProgetto = -1 then
        sp.Id_Progetto := nil
      else
        sp.Id_Progetto := IdProgetto;

      // Mantis #172 - 2026-09-25: parametro in coda della procedura, dopo ID_PROGETTO
      sp.Raggruppamento := Raggruppamento;

      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    ReopenDataSet('Risorse_Autorizzazioni_Pagamento');
  finally
    StopWait;
  end;
end;

procedure TRisorse.AutPagEnteEditValueChanged(Sender: TObject);
var
  IdEnte: integer;
  lk: TcxExtLookupComboBox;
begin
  lk := Sender as TcxExtLookupComboBox;

  if varIsNull(lk.EditingValue) then
    IdEnte := -1
  else
    IdEnte := lk.EditingValue;

  lkAutPagProgetti.Active := False;

  if IdEnte = -1 then
    lkAutPagProgetti.ParamByName('ID_ENTE').Clear
  else
    lkAutPagProgetti.ParamByName('ID_ENTE').Value := IdEnte;
  lkAutPagProgetti.Active := true;
end;

function TRisorse.GeneraAutorizzazioneSelezionaPeriodo(const idRisorsa: integer; var IdEnte, AnnoDal, MeseDal, AnnoAl, MeseAl, IdProgetto: integer;
  var Raggruppamento: string): Boolean;
var
  lkEnti: TzFbDataSet;

  Params: TParams;
  capturedMeseDal, capturedMeseAl: integer;
  capturedRaggruppamento: string;
begin
  Result := False;
  lkEnti := GetDataSet('lkEnti');
  lkEntiSrc.DataSet := lkEnti;

  // lkAutPagProgetti/lkAutPagProgettiSrc sono component permanenti della
  // TRisorse (non serve GetDataSet); ID_RISORSA è fisso per l'intero
  // dialogo, ID_ENTE parte vuoto e viene valorizzato da AutPagEnteChanged
  // al primo cambio della combo Ente (coerente con 'Ente' che parte
  // sempre vuoto, vedi Params.CreateParam/Clear sotto).
  lkAutPagProgetti.Active := False;
  lkAutPagProgetti.ParamByName('ID_RISORSA').Value := idRisorsa;
  lkAutPagProgetti.ParamByName('ID_ENTE').Clear;
  lkAutPagProgetti.Active := true;

  Params := TParams.Create(nil);
  try
    Params.CreateParam(ftInteger, 'Ente', ptInputOutput);
    Params.ParamByName('Ente').Clear;

    Params.CreateParam(ftInteger, 'Inizio_Anno_Competenza', ptInputOutput);
    Params.ParamByName('Inizio_Anno_Competenza').Value := AnnoDal;

    Params.CreateParam(ftInteger, 'Inizio_Mese_Competenza', ptInputOutput);
    Params.ParamByName('Inizio_Mese_Competenza').Value := MeseDal;

    Params.CreateParam(ftInteger, 'Fine_Anno_Competenza', ptInputOutput);
    Params.ParamByName('Fine_Anno_Competenza').Value := AnnoAl;

    Params.CreateParam(ftInteger, 'Fine_Mese_Competenza', ptInputOutput);
    Params.ParamByName('Fine_Mese_Competenza').Value := MeseAl;

    Params.CreateParam(ftInteger, 'Id_Progetto', ptInputOutput);
    Params.ParamByName('Id_Progetto').Clear;

    // Mantis #172 - 2026-09-25: come raggruppare le righe del documento
    // (STD per azione, PRT per protocollo, INC un incarico per riga); si cambia
    // anche dopo, dalla griglia, finche' l'autorizzazione non e' validata
    Params.CreateParam(ftString, 'Raggruppamento', ptInputOutput);
    Params.ParamByName('Raggruppamento').Value := Raggruppamento;

    capturedMeseDal := MeseDal;
    capturedMeseAl := MeseAl;
    capturedRaggruppamento := Raggruppamento;

    Result := ShowParams('TSP_AUTORIZZAZIONI_PAGAMENTO_GENERA', Params, 'Generazione Autorizzazione',
      procedure(zParamDialog: TzParamDialog)
      var
        lk: TcxExtLookupComboBox;
        comboDal, comboAl: TcxImageComboBox;
        comboRaggruppamento: TcxImageComboBox;
      begin
        zParamDialog.zDialog.width := 280;
        // Mantis #172 - 2026-09-25: una riga in piu' per il raggruppamento
        zParamDialog.zDialog.Height := 360;

        lk := zParamDialog.zDialog.zFormBuilder.ChangeControlType(ctLookupExt, 'Ente', 'Ente', '') as TcxExtLookupComboBox;
        dx.InitLookup('', lk, lkEnti, lkEntiSrc, 'ID_ENTE', 'ENTE');
        lkEnti.Active := true;

        // FAutPagLkEnte := lk;
        lk.Properties.OnEditValueChanged := AutPagEnteEditValueChanged;

        comboDal := zParamDialog.zDialog.zFormBuilder.ChangeControlType(ctPickList, 'Inizio_Mese_Competenza', 'Dal mese', capturedMeseDal) as TcxImageComboBox;
        dx.InitPickList(comboDal.ActiveProperties, 'MESI');
        comboDal.ActiveProperties.DropDownRows := 12;

        comboAl := zParamDialog.zDialog.zFormBuilder.ChangeControlType(ctPickList, 'Fine_Mese_Competenza', 'Al mese', capturedMeseAl) as TcxImageComboBox;
        dx.InitPickList(comboAl.ActiveProperties, 'MESI');
        comboAl.ActiveProperties.DropDownRows := 12;

        // Progetto opzionale (nessuna selezione = tutti i progetti dell'ente/periodo),
        // filtrato su lkAutPagProgetti (ID_ENTE + ID_RISORSA), aggiornato al
        // cambio Ente da AutPagEnteChanged.
        lk := zParamDialog.zDialog.zFormBuilder.ChangeControlType(ctLookupExt, 'Id_Progetto', 'Progetto (opzionale)', '') as TcxExtLookupComboBox;
        dx.InitLookup('', lk, lkAutPagProgetti, lkAutPagProgettiSrc, 'ID_PROGETTO', 'DESC_COMPLETA_PROGETTO');
        // FAutPagLkProgetto := lk;

        // Mantis #172 - 2026-09-25: voci dalla lista generata dal commento del dominio
        comboRaggruppamento := zParamDialog.zDialog.zFormBuilder.ChangeControlType(ctPickList, 'Raggruppamento', 'Raggruppamento righe',
          capturedRaggruppamento) as TcxImageComboBox;
        dx.InitPickList(comboRaggruppamento.ActiveProperties, 'AUTORIZZAZIONI_PAGAMENTO_RAGGRUPPAMENTO');
      end);

    if Result then
    begin
      IdEnte := Params.ParamByName('Ente').Value;
      AnnoDal := Params.ParamByName('Inizio_Anno_Competenza').Value;
      MeseDal := Params.ParamByName('Inizio_Mese_Competenza').Value;
      AnnoAl := Params.ParamByName('Fine_Anno_Competenza').Value;
      MeseAl := Params.ParamByName('Fine_Mese_Competenza').Value;
      if Params.ParamByName('Id_Progetto').IsNull or Params.ParamByName('Id_Progetto').asString.IsEmpty then
        IdProgetto := -1
      else
        IdProgetto := Params.ParamByName('Id_Progetto').Value;

      // Mantis #172 - 2026-09-25: campo svuotato = come la generazione di sempre
      Raggruppamento := Params.ParamByName('Raggruppamento').AsString;
      if Raggruppamento.IsEmpty then
        Raggruppamento := 'STD';
    end;
  finally
    FreeAndNil(Params);
  end;
end;

end.
