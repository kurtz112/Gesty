unit dmRiunioni;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  Base_DataModule,
  dbMaster,
  zFbDataSet,
  zDbViewDlg,
  Gesty.Types;

type
  TRiunioni = class(TBaseDataModule)
    dlgPartecipanti: TzDbViewDlg;
    dlgProgrammazione: TzDbViewDlg;
  private
    procedure SalvaRiunione;
    function GetStatoRiunioneCorrente: TStatoRiunione;
    function IdRiunioneSelezionata: integer;
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
    procedure RiunioniNewRecord(DataSet: TDataSet);
    procedure RiunioniAfterCreateFields(DataSet: TDataSet);
    procedure CalcolaDurataEffettiva(Field: TField);
  private
  public
    procedure InviaMail;
    procedure AggiungiPartecipanti;
    procedure Print(ReportGroup: string; SelectedDataSetName: string); override;

    procedure ProgrammaRiunione;
    procedure Verbalizza;
    procedure Contabilizza;
    procedure AnnullaRiunione;
    procedure RipristinaRiunione;

    property StatoRiunioneCorrente: TStatoRiunione read GetStatoRiunioneCorrente;
  end;

var
  Riunioni: TRiunioni;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses
  System.DateUtils, System.Variants, System.UITypes, Vcl.Dialogs,  
  zDm_Images, zOffice, zOffice.types, Gesty_StoredProcs, zBaseLib, dmCommon,
  zMsg;

procedure TRiunioni.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
var
  Field: TField;
begin
  inherited;
  if SameText(DataSetName, 'Riunioni') then
  begin
    DataSet.OnNewRecord := RiunioniNewRecord;
    DataSet.OnAfterCreateFields := RiunioniAfterCreateFields;
  end;
end;

procedure TRiunioni.InviaMail;
var
  sp: TSP_GET_MAIL_RIUNIONE;
  Mail: TMail;
  SMTPServerParams: TSMTPServerParams;
  IdRiunione: integer;
begin
  inherited;
  SalvaRiunione;

  IdRiunione := IdRiunioneSelezionata;

  SMTPServerParams.Init;
  Mail.Init;

  sp := TSP_GET_MAIL_RIUNIONE.Create(WriteTrans);
  try
    sp.ID_RIUNIONE := IdRiunione;
    sp.ExecuteWithoutCommit;

    Mail.CC := sp.CC.Value;
    Mail.oggetto := sp.oggetto;
    Mail.CorpoTxt := sp.CORPO_TXT.Text;

    SMTPServerParams.From := sp.FROM_RISORSA;
    SMTPServerParams.FromAddress := sp.EMAIL_FROM_ADDRESS;
    SMTPServerParams.ReplyTo := sp.EMAIL_REPLAY_TO;
    SMTPServerParams.ReceiptRecipient := sp.EMAIL_CONFERMA_LETTURA;
    SMTPServerParams.Host := sp.Smtp_Host;
    SMTPServerParams.Port := sp.Smtp_Port;
    SMTPServerParams.UserName := sp.Smtp_UserName;
    SMTPServerParams.Password := sp.Smtp_Password;
    SMTPServerParams.AuthenticationType := sp.Authentication_Type;
    SMTPServerParams.ssl := sp.ssl;
    SMTPServerParams.ssl_ver := sp.ssl_ver;
  finally
    FreeAndNil(sp);
  end;

  /// !!!!!!!!!!!!!!!!!!!!!!!
  if not SMTPServerParams.IsValid then
  begin
    ConfirmOk('Parametri SMTP non configurati.');
    exit;
  end;

  WriteMail(Mail, SMTPServerParams, Common.GetMailRisorse); //
end;

procedure TRiunioni.SalvaRiunione;
var
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet('Riunioni');
  DataSet.CheckBrowseMode;
end;

procedure TRiunioni.AggiungiPartecipanti;
var
  IdRiunione: integer;
  Partecipanti, lkDocenti: TzFbDataSet;
begin
  SalvaRiunione;

  IdRiunione := IdRiunioneSelezionata;
  if IdRiunione = -1 then
    exit;

  Partecipanti := GetDataSet('Riunioni_Partecipanti');
  lkDocenti := GetDataSet('lkPartecipanti');

  lkDocenti.RevertSQL(false);
  lkDocenti.ParamByName('ID_RIUNIONE').AsInteger := IdRiunione;
  lkDocenti.Active := true;
  try
    dlgPartecipanti.DataSet := lkDocenti;

    if dlgPartecipanti.Execute(
      procedure
      begin
        Partecipanti.Append;
        Partecipanti.FieldByName('ID_PERSONALE').AsInteger := lkDocenti.FieldByName('ID_PERSONALE').AsInteger;
        Partecipanti.Post;
      end) then
      Partecipanti.Reopen;
  finally
    lkDocenti.Active := false;
  end;
end;

procedure TRiunioni.RiunioniNewRecord(DataSet: TDataSet);
var
  Ente, Sede: integer;
  Raggruppamento: string;
begin
  inherited;
  Common.GetEnteAndSedeDefault(Ente, Sede, Raggruppamento);
  DataSet.FieldByName('STATO_RIUNIONE').Value := 'I';
  DataSet.FieldByName('ID_ENTE').Value := Ente;
  DataSet.FieldByName('ID_SEDE').Value := Sede;
  DataSet.FieldByName('ID_RESPONSABILE_RIUNIONE').Value := Common.CurrentIdRisorsa;
end;

procedure TRiunioni.RiunioniAfterCreateFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('ORA_INIZIO').OnChange := CalcolaDurataEffettiva;
  DataSet.FieldByName('ORA_FINE').OnChange := CalcolaDurataEffettiva;
end;

procedure TRiunioni.CalcolaDurataEffettiva(Field: TField);
var
  Riunioni: TDataSet;
  Inizio, Fine, Durata: TField;
  minuti: integer;
begin
  Riunioni := GetDataSet('Riunioni');
  Inizio := Riunioni.FieldByName('ORA_INIZIO');
  Fine := Riunioni.FieldByName('ORA_FINE');
  Durata := Riunioni.FieldByName('DURATA_EFFETTIVA');

  minuti := 0;

  if not Inizio.IsNull then
    if not Fine.IsNull then
      minuti := minutesBetween(Inizio.AsDateTime, Fine.AsDateTime);

  Durata.Value := minuti;
end;

procedure TRiunioni.ProgrammaRiunione;
var
  IdRiunione: integer;
  Riunioni, lkProgrammazione: TzFbDataSet;
begin
  SalvaRiunione;

  IdRiunione := IdRiunioneSelezionata;
  if IdRiunione = -1 then
    exit;

  Riunioni := GetDataSet('Riunioni');
  lkProgrammazione := GetDataSet('lkProgrammazione');

  lkProgrammazione.RevertSQL(false);
  lkProgrammazione.ParamByName('ID_RIUNIONE').AsInteger := IdRiunione;
  lkProgrammazione.Active := true;
  try
    dlgProgrammazione.DataSet := lkProgrammazione;

    if dlgProgrammazione.Execute then
    begin
      Riunioni.CheckEditMode;
      Riunioni.FieldByName('DATA_RIUNIONE').AsDateTime := lkProgrammazione.FieldByName('DATA_RIUNIONE').AsDateTime;
      Riunioni.FieldByName('ORA_INIZIO').AsDateTime := lkProgrammazione.FieldByName('ORA_INIZIO').AsDateTime;
      Riunioni.FieldByName('ORA_FINE').AsDateTime := lkProgrammazione.FieldByName('ORA_FINE').AsDateTime;
      // Riunioni.FieldByName('DURATA_EFFETTIVA').AsInteger := lkProgrammazione.FieldByName('DURATA').AsInteger;
      Riunioni.FieldByName('AULA').AsString := lkProgrammazione.FieldByName('AULA').AsString;
      Riunioni.FieldByName('DESC_AULA').AsString := lkProgrammazione.FieldByName('DESC_AULA').AsString;
      Riunioni.CheckBrowseMode;
      Riunioni.RefreshRecord();
    end;
  finally
    lkProgrammazione.Active := false;
  end;
end;

procedure TRiunioni.Print(ReportGroup: string; SelectedDataSetName: string);
var
  s: String;
  DataSet: TzFbDataSet;
begin
  SalvaRiunione;

  s := SelectedDataSetName;

  if s.IsEmpty then
    s := 'Riunioni';

  // forza la creazione dei dataset
  DataSet := GetDataSet('Riunioni_Riepilogo_Partecipanti');
  DataSet.Active := false;
  DataSet.ParamByName('ID_RIUNIONE').Value := IdRiunioneSelezionata;
  DataSet.Active := true;

  inherited Print(ReportGroup, s);
end;

function TRiunioni.IdRiunioneSelezionata: integer;
var
  DataSet: TzFbDataSet;
begin
  Result := -1;

  DataSet := GetDataSet('Riunioni');

  if Assigned(DataSet) then
    Result := DataSet.FieldByName('ID_RIUNIONE').AsInteger;
end;

function TRiunioni.GetStatoRiunioneCorrente: TStatoRiunione;
var
  DataSet: TzFbDataSet;
begin
  Result := srInserita;

  DataSet := GetDataSet('Riunioni');

  if Assigned(DataSet) then
    Result := TStatoRiunione.FromString(DataSet.FieldByName('STATO_RIUNIONE').AsString);
end;

procedure TRiunioni.AnnullaRiunione;
var
  id: integer;
  sp: TSP_Riunioni_Annulla;
begin
  id := IdRiunioneSelezionata;

  if id = -1 then
    exit;

  if StatoRiunioneCorrente = srContabilizzata then
    exit;

  if not ConfirmYesNo('Si desidera annullare la riunione selezionata?') then
    exit;

  StartWait('Attendere...', true);
  try
    sp := TSP_Riunioni_Annulla.Create(WriteTrans);
    try
      sp.ID_RIUNIONE := id;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    RefreshDataSet('Riunioni')
  finally
    StopWait;
  end;
end;

procedure TRiunioni.RipristinaRiunione;
var
  id: integer;
  sp: TSP_Riunioni_Ripristina;
begin
  id := IdRiunioneSelezionata;

  if id = -1 then
    exit;

  if StatoRiunioneCorrente <> srAnnullata then
    exit;

  if not ConfirmYesNo('Si desidera ripristinare la riunione selezionata?') then
    exit;

  StartWait('Attendere...', true);
  try
    sp := TSP_Riunioni_Ripristina.Create(WriteTrans);
    try
      sp.ID_RIUNIONE := id;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    RefreshDataSet('Riunioni')
  finally
    StopWait;
  end;
end;

procedure TRiunioni.Verbalizza;
var
  id: integer;
  DataSet: TzFbDataSet;
  sp: TSP_Riunioni_Verbalizza;
begin
  SalvaRiunione;

  id := IdRiunioneSelezionata;

  if id = -1 then
    exit;

  if not(StatoRiunioneCorrente in [srProgrammata, srAnnullata]) then
    exit;

  if not ConfirmYesNo('Si desidera verbalizzare la riunione selezionata?') then
    exit;

  StartWait('Attendere...', true);
  try
    sp := TSP_Riunioni_Verbalizza.Create(WriteTrans);
    try
      sp.ID_RIUNIONE := id;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    RefreshRecord('Riunioni', false);
  finally
    StopWait;
  end;
end;

procedure TRiunioni.Contabilizza;
var
  id: integer;
  sp: TSP_Riunioni_Contabilizza;
begin
  SalvaRiunione;

  id := IdRiunioneSelezionata;

  if id = -1 then
    exit;

  if StatoRiunioneCorrente <> srVerbalizzata then
    exit;

  if not ConfirmYesNo('Si desidera contabilizzare la riunione selezionata?') then
    exit;

  StartWait('Attendere...', true);
  try
    sp := TSP_Riunioni_Contabilizza.Create(WriteTrans);
    try
      sp.ID_RIUNIONE := id;
      sp.ExecuteAndCommit;
    finally
      FreeAndNil(sp);
    end;

    RefreshDataSet('Riunioni')
  finally
    StopWait;
  end;
end;

end.
