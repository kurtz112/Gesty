unit dmFrontOffice;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  Base_DataModule,
  zFbDataSet,
  dbMaster,
  zDbCardDlg,
  SmartInspect.Vcl.SiAuto,
  SmartInspect.Vcl,
  Vcl.ActnList;

type
  TFrontOffice = class(TBaseDataModule)
    dlgAssegnaTicket: TzDbCardDlg;
  private
    procedure Front_Office_ContattiNewRecord(DataSet: TDataSet);
    procedure Front_Office_Ambiti_Int_RisorseAfterPost(DataSet: TDataSet);
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    procedure AssegnaTicket;
    procedure InoltraComunicazione;
    procedure ModificaTicket;

    procedure SetRichiedeRisposta(Checked: boolean);
    procedure UpdateRichiedeRisposta(out Checked, Visible: boolean);
  end;

var
  FrontOffice: TFrontOffice;

implementation

uses
  zOffice,
  zOffice.types,
  Gesty_StoredProcs,
  dmCommon;

{$R *.dfm}
{ TFrontOffice }

const
  STATO_RISPOSTA_ATTESA = 'A';
  STATO_RISPOSTA_NON_RICHIESTA = 'N';

procedure TFrontOffice.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'Front_Office_Contatti') then
    DataSet.OnNewRecord := Front_Office_ContattiNewRecord
  else
    if SameText(DataSetName, 'Front_Office_Ambiti_Int_Risorse') then
      DataSet.AfterPost := Front_Office_Ambiti_Int_RisorseAfterPost;
end;

procedure TFrontOffice.Front_Office_ContattiNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('ID_OPERATORE_FRONT_OFFICE').asInteger := Common.CurrentIdRisorsa;
  DataSet.FieldByName('STATO_RISPOSTA').AsString := 'N';
end;

procedure TFrontOffice.Front_Office_Ambiti_Int_RisorseAfterPost(DataSet: TDataSet);
begin
  TzFbDataSet(DataSet).ReOpen();
end;

procedure TFrontOffice.AssegnaTicket;
var
  Front_Office_Contatti: TzFbDataSet;
  Front_Office_Contatti_Ticket: TzFbDataSet;
  idContatto: integer;
begin
  Front_Office_Contatti := GetDataSet('Front_Office_Contatti');

  if Front_Office_Contatti.IsEmpty then
    exit;

  idContatto := Front_Office_Contatti.FieldByName('ID_CONTATTO_FRONT_OFFICE').asInteger;

  Front_Office_Contatti_Ticket := GetDataSet('Front_Office_Contatti_Ticket');
  Front_Office_Contatti_Ticket.Append;
  Front_Office_Contatti_Ticket.FieldByName('ID_CONTATTO_FRONT_OFFICE').Value := idContatto;
  Front_Office_Contatti_Ticket.FieldByName('ID_OPERATORE_SEGNALATORE').Value := Common.CurrentIdRisorsa;
  Front_Office_Contatti_Ticket.FieldByName('DATA_ORA_ASSEGNAZIONE').AsDateTime := Now;
  Front_Office_Contatti_Ticket.FieldByName('STATO_RISPOSTA').Value := Front_Office_Contatti.FieldByName('STATO_RISPOSTA').Value;

  dlgAssegnaTicket.DataSet := Front_Office_Contatti_Ticket;

  if dlgAssegnaTicket.Execute then
  begin
    RefreshRecord('Front_Office_Contatti', false);
    ReopenDataSet('Front_Office_Contatti_Ticket');
  end;
end;

procedure TFrontOffice.InoltraComunicazione;
var
  DataSet: TzFbDataSet;
  Mail: TMail;
  ElencoMail: string;
  Corpo: TStringList;
  sp: TSP_FRONT_OFFICE_CONTATTI_GET_MAIL;
begin
  // Front_Office_Contatti

  DataSet := GetDataSet('Front_Office_Contatti');
  // ID_CONTATTO_FRONT_OFFICE

  // Recuperare elenco mail destino  FRONT_OFFICE_CONTATTI_GET_MAIL
  // Form per i destinatari ove vedere le comunicazioni
  // (vedere per alert)

  if DataSet.IsEmpty then
    exit;

  CheckSMTPServerParams;

  sp := TSP_FRONT_OFFICE_CONTATTI_GET_MAIL.Create(WriteTrans);
  try
    sp.ID_CONTATTO_FRONT_OFFICE := DataSet.FieldByName('ID_CONTATTO_FRONT_OFFICE').asInteger;
    sp.executeAndCommit;
    ElencoMail := sp.ELENCO_MAIL;
  finally
    FreeAndNil(sp);
  end;

  Corpo := TStringList.Create;
  try
    Corpo.Add('Fonte: ' + DataSet.FieldByName('FONTE').AsString);
    Corpo.Add('Data contatto: ' + DataSet.FieldByName('DATA_CONTATTO').AsString);
    Corpo.Add('Ora contatto: ' + DataSet.FieldByName('ORA_CONTATTO').AsString);
    Corpo.Add('Nominativo: ' + DataSet.FieldByName('NOMINATIVO_CONTATTO').AsString);
    Corpo.Add('Azienda: ' + DataSet.FieldByName('AZIENDA_CONTATTO').AsString);
    Corpo.Add('Telefono: ' + DataSet.FieldByName('TELEFONO').AsString);
    Corpo.Add('Mail: ' + DataSet.FieldByName('E_MAIL').AsString);
    Corpo.Add('');
    Corpo.Add('Richiesta: ');
    Corpo.Add(DataSet.FieldByName('RICHIESTA').AsString);
    Corpo.Add('');
    Corpo.Add('Note: ');
    Corpo.Add(DataSet.FieldByName('NOTE').AsString);

    Mail.Init;
    Mail.A := ElencoMail;
    Mail.Oggetto := 'Comunicazione da Front Office';
    // CorpoHtml: string read FCorpoHtml write FCorpoHtml;
    Mail.CorpoTxt := Corpo.Text;
  finally
    FreeAndNil(Corpo);
  end;

  WriteMail(Mail, SMTPServerParams, Common.GetMailRisorse);
end;

procedure TFrontOffice.ModificaTicket;
var
  Front_Office_Contatti_Ticket: TzFbDataSet;
begin
  Front_Office_Contatti_Ticket := GetDataSet('Front_Office_Contatti_Ticket');

  if Front_Office_Contatti_Ticket.IsEmpty then
    exit; // nessun ticket attivo da modificare, eventualmente disabilitare l'action a monte

  Front_Office_Contatti_Ticket.Edit; // <-- differenza chiave rispetto ad AssegnaTicket: Edit, non Append

  dlgAssegnaTicket.DataSet := Front_Office_Contatti_Ticket;

  if dlgAssegnaTicket.Execute then
  begin
    RefreshRecord('Front_Office_Contatti', false);
    ReopenDataSet('Front_Office_Contatti_Ticket');
  end
  else
    Front_Office_Contatti_Ticket.Cancel;
end;

procedure TFrontOffice.SetRichiedeRisposta(Checked: boolean);
var
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet('Front_Office_Contatti');

  if not Assigned(DataSet) or DataSet.IsEmpty or (DataSet.State <> dsInsert) then
    exit;

  if Checked then
    DataSet.FieldByName('STATO_RISPOSTA').AsString := STATO_RISPOSTA_ATTESA
  else
    DataSet.FieldByName('STATO_RISPOSTA').AsString := STATO_RISPOSTA_NON_RICHIESTA;
end;

procedure TFrontOffice.UpdateRichiedeRisposta(out Checked, Visible: boolean);
var
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet('Front_Office_Contatti');

  Visible := Assigned(DataSet) and (not DataSet.IsEmpty) and (DataSet.State = dsInsert);

  if Visible then
    Checked := DataSet.FieldByName('STATO_RISPOSTA').AsString <> STATO_RISPOSTA_NON_RICHIESTA
  else
    Checked := false;
end;

end.
