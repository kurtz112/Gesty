unit dmFrontOffice;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Generics.Collections,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.CheckLst,
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
    // Mantis #252 - 2026-10-16: i dati copiati dall'anagrafe restano in sola lettura finche' l'operatore non li sblocca
    FDatiAnagrafeSbloccati: Boolean;
    FUltimoContatto: Int64;

    procedure Front_Office_ContattiNewRecord(DataSet: TDataSet);
    procedure Front_Office_ContattiAggiornaBlocco(DataSet: TDataSet);
    procedure Front_Office_Ambiti_Int_RisorseAfterPost(DataSet: TDataSet);

    procedure AggiornaBloccoCampi(DataSet: TDataSet);
    procedure ElencoDestinatariAperti(Ticket: TzFbDataSet; Destinatari: TList<Int64>);
  protected
    procedure AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet); override;
  public
    function NuovaQuery(const Sql: string): TzFbDataSet;

    procedure AssegnaTicket;
    procedure InoltraComunicazione;
    procedure ModificaTicket;

    procedure SetRichiedeRisposta(Checked: boolean);
    procedure UpdateRichiedeRisposta(out Checked, Visible: boolean);

    procedure SbloccaDatiAnagrafe;
    procedure UpdateSbloccaDatiAnagrafe(out Visible: boolean);
  end;

var
  FrontOffice: TFrontOffice;

implementation

uses
  zOffice,
  zOffice.types,
  Gesty_StoredProcs,
  ConfigModule,
  dmCommon;

{$R *.dfm}
{ TFrontOffice }

const
  STATO_RISPOSTA_ATTESA = 'A';
  STATO_RISPOSTA_NON_RICHIESTA = 'N';

  // campi del contatto copiati dall'anagrafe quando si sceglie un nominativo
  CAMPI_COPIATI_DA_ANAGRAFE: array [0 .. 2] of string = ('NOMINATIVO_CONTATTO', 'TELEFONO', 'E_MAIL');

type
  // Mantis #252 - 2026-10-16: finestra di assegnazione del ticket. Si sceglie l'ambito di interesse
  // e, insieme, uno o piu' destinatari. Nasce in codice (nessun DFM) perche' ha pochi controlli
  // e non dipende dal dizionario LZ.
  TFormAssegnazioneTicket = class(TForm)
  private
    FDataModulo: TFrontOffice;
    FAmbitoAttuale: string;
    FGiaAssegnati: TList<Int64>;
    FIdOperatori: TList<Int64>;
    FComboAmbito: TComboBox;
    FCasellaTuttiGliOperatori: TCheckBox;
    FElenco: TCheckListBox;
    FNote: TMemo;
    procedure CaricaAmbiti;
    procedure CaricaOperatori;
    procedure AmbitoCambiato(Sender: TObject);
    procedure TuttiGliOperatoriCambiato(Sender: TObject);
    procedure ControllaChiusura(Sender: TObject; var CanClose: Boolean);
    function AmbitoScelto: string;
    function AmbitoValido: Boolean;
  public
    constructor CreateAssegnazione(DataModulo: TFrontOffice; const AmbitoAttuale: string; GiaAssegnati: TList<Int64>);
    destructor Destroy; override;
    function Ambito: string;
    function Note: string;
    procedure ElencoDestinatariScelti(Destinatari: TList<Int64>);
  end;

{ TFormAssegnazioneTicket }

constructor TFormAssegnazioneTicket.CreateAssegnazione(DataModulo: TFrontOffice; const AmbitoAttuale: string; GiaAssegnati: TList<Int64>);
var
  Etichetta: TLabel;
  PulsanteOk: TButton;
  PulsanteAnnulla: TButton;
begin
  inherited CreateNew(Application);

  FDataModulo := DataModulo;
  FAmbitoAttuale := AmbitoAttuale;
  FGiaAssegnati := GiaAssegnati;
  FIdOperatori := TList<Int64>.Create;

  Caption := 'Assegna ticket';
  BorderStyle := bsDialog;
  Position := poOwnerFormCenter;
  ClientWidth := 540;
  ClientHeight := 468;
  OnCloseQuery := ControllaChiusura;

  Etichetta := TLabel.Create(Self);
  Etichetta.Parent := Self;
  Etichetta.SetBounds(12, 12, 300, 15);
  Etichetta.Caption := 'Ambito di interesse (cambiandolo, i ticket del vecchio ambito vengono chiusi)';

  FComboAmbito := TComboBox.Create(Self);
  FComboAmbito.Parent := Self;
  FComboAmbito.SetBounds(12, 32, 516, 23);
  FComboAmbito.Style := csDropDown;
  FComboAmbito.AutoComplete := True;
  FComboAmbito.AutoDropDown := True;
  FComboAmbito.OnChange := AmbitoCambiato;

  Etichetta := TLabel.Create(Self);
  Etichetta.Parent := Self;
  Etichetta.SetBounds(12, 68, 200, 15);
  Etichetta.Caption := 'Destinatari';

  FCasellaTuttiGliOperatori := TCheckBox.Create(Self);
  FCasellaTuttiGliOperatori.Parent := Self;
  FCasellaTuttiGliOperatori.SetBounds(300, 66, 228, 19);
  FCasellaTuttiGliOperatori.Caption := 'Mostra tutti gli operatori';
  FCasellaTuttiGliOperatori.OnClick := TuttiGliOperatoriCambiato;

  FElenco := TCheckListBox.Create(Self);
  FElenco.Parent := Self;
  FElenco.SetBounds(12, 88, 516, 230);

  Etichetta := TLabel.Create(Self);
  Etichetta.Parent := Self;
  Etichetta.SetBounds(12, 328, 300, 15);
  Etichetta.Caption := 'Note per i destinatari';

  FNote := TMemo.Create(Self);
  FNote.Parent := Self;
  FNote.SetBounds(12, 348, 516, 72);
  FNote.ScrollBars := ssVertical;

  PulsanteOk := TButton.Create(Self);
  PulsanteOk.Parent := Self;
  PulsanteOk.SetBounds(360, 430, 80, 26);
  PulsanteOk.Caption := 'OK';
  PulsanteOk.ModalResult := mrOk;
  PulsanteOk.Default := True;

  PulsanteAnnulla := TButton.Create(Self);
  PulsanteAnnulla.Parent := Self;
  PulsanteAnnulla.SetBounds(448, 430, 80, 26);
  PulsanteAnnulla.Caption := 'Annulla';
  PulsanteAnnulla.ModalResult := mrCancel;
  PulsanteAnnulla.Cancel := True;

  CaricaAmbiti;
  FComboAmbito.Text := AmbitoAttuale;
  CaricaOperatori;
end;

destructor TFormAssegnazioneTicket.Destroy;
begin
  FreeAndNil(FIdOperatori);
  inherited;
end;

procedure TFormAssegnazioneTicket.CaricaAmbiti;
var
  Query: TzFbDataSet;
begin
  Query := FDataModulo.NuovaQuery('SELECT FRONT_OFFICE_AMBITI_INTERESSE.AMBITO_INTERESSE ' +
    'FROM FRONT_OFFICE_AMBITI_INTERESSE ' +
    'ORDER BY FRONT_OFFICE_AMBITI_INTERESSE.AMBITO_INTERESSE');
  try
    Query.Open;
    while not Query.Eof do
    begin
      FComboAmbito.Items.Add(Query.FieldByName('AMBITO_INTERESSE').AsString);
      Query.Next;
    end;
  finally
    FreeAndNil(Query);
  end;
end;

procedure TFormAssegnazioneTicket.CaricaOperatori;
var
  Query: TzFbDataSet;
  Nominativo: string;
  Indice: Integer;
  IdOperatore: Int64;
begin
  FElenco.Items.BeginUpdate;
  try
    FElenco.Items.Clear;
    FIdOperatori.Clear;

    if FCasellaTuttiGliOperatori.Checked then
      Query := FDataModulo.NuovaQuery('SELECT FRONT_OFFICE_OPERATORI_ELENCO.ID_OPERATORE_FRONT_OFFICE AS ID_OPERATORE, ' +
        'FRONT_OFFICE_OPERATORI_ELENCO.NOMINATIVO_OPERATORE AS NOMINATIVO_OPERATORE ' +
        'FROM FRONT_OFFICE_OPERATORI_ELENCO ' +
        'WHERE FRONT_OFFICE_OPERATORI_ELENCO.TIPO_OPERATORE = ''P'' ' +
        'ORDER BY FRONT_OFFICE_OPERATORI_ELENCO.NOMINATIVO_OPERATORE')
    else
    begin
      Query := FDataModulo.NuovaQuery('SELECT FRONT_OFFICE_AMBITI_INTERESSE_PERSONALE.ID_PERSONALE AS ID_OPERATORE, ' +
        'ANAGRAFE.NOMINATIVO AS NOMINATIVO_OPERATORE ' +
        'FROM FRONT_OFFICE_AMBITI_INTERESSE_PERSONALE ' +
        'INNER JOIN ANAGRAFE ON ANAGRAFE.ID_ANAGRAFICA = FRONT_OFFICE_AMBITI_INTERESSE_PERSONALE.ID_PERSONALE ' +
        'WHERE FRONT_OFFICE_AMBITI_INTERESSE_PERSONALE.AMBITO_INTERESSE = :AMBITO_INTERESSE ' +
        'ORDER BY ANAGRAFE.NOMINATIVO');
      Query.ParamByName('AMBITO_INTERESSE').AsString := AmbitoScelto;
    end;

    try
      Query.Open;
      while not Query.Eof do
      begin
        IdOperatore := Query.FieldByName('ID_OPERATORE').AsLargeInt;
        Nominativo := Query.FieldByName('NOMINATIVO_OPERATORE').AsString;

        FIdOperatori.Add(IdOperatore);
        Indice := FElenco.Items.Add(Nominativo);

        // chi ha gia' un ticket aperto su questo contatto non si assegna due volte
        if FGiaAssegnati.Contains(IdOperatore) then
        begin
          FElenco.Items[Indice] := Nominativo + ' (gia'' assegnato)';
          FElenco.ItemEnabled[Indice] := False;
        end;

        Query.Next;
      end;
    finally
      FreeAndNil(Query);
    end;
  finally
    FElenco.Items.EndUpdate;
  end;
end;

function TFormAssegnazioneTicket.AmbitoScelto: string;
begin
  Result := Trim(FComboAmbito.Text);
end;

function TFormAssegnazioneTicket.AmbitoValido: Boolean;
begin
  Result := FComboAmbito.Items.IndexOf(AmbitoScelto) >= 0;
end;

procedure TFormAssegnazioneTicket.AmbitoCambiato(Sender: TObject);
begin
  // l'elenco dei destinatari segue l'ambito, ma solo quando il testo coincide con un ambito esistente
  if (not FCasellaTuttiGliOperatori.Checked) and AmbitoValido then
    CaricaOperatori;
end;

procedure TFormAssegnazioneTicket.TuttiGliOperatoriCambiato(Sender: TObject);
begin
  CaricaOperatori;
end;

procedure TFormAssegnazioneTicket.ControllaChiusura(Sender: TObject; var CanClose: Boolean);
var
  Destinatari: TList<Int64>;
  Selezionati: Integer;
begin
  if ModalResult <> mrOk then
    exit;

  if not AmbitoValido then
  begin
    MessageDlg('Scegliere un ambito di interesse dall''elenco.', mtWarning, [mbOK], 0);
    CanClose := False;
    exit;
  end;

  Destinatari := TList<Int64>.Create;
  try
    ElencoDestinatariScelti(Destinatari);
    Selezionati := Destinatari.Count;
  finally
    FreeAndNil(Destinatari);
  end;

  // cambiando ambito senza scegliere nessuno, i ticket li crea il database per il personale del nuovo ambito
  if (Selezionati = 0) and SameText(AmbitoScelto, FAmbitoAttuale) then
  begin
    MessageDlg('Selezionare almeno un destinatario.', mtWarning, [mbOK], 0);
    CanClose := False;
  end;
end;

function TFormAssegnazioneTicket.Ambito: string;
begin
  Result := AmbitoScelto;
end;

function TFormAssegnazioneTicket.Note: string;
begin
  Result := Trim(FNote.Text);
end;

procedure TFormAssegnazioneTicket.ElencoDestinatariScelti(Destinatari: TList<Int64>);
var
  Indice: Integer;
begin
  for Indice := 0 to FElenco.Items.Count - 1 do
    if FElenco.Checked[Indice] and FElenco.ItemEnabled[Indice] then
      Destinatari.Add(FIdOperatori[Indice]);
end;

{ TFrontOffice }

function TFrontOffice.NuovaQuery(const Sql: string): TzFbDataSet;
begin
  Result := TzFbDataSet.Create(Self);
  Result.Connection := Config.Database;
  Result.Transaction := ReadTrans;
  Result.SQL.Text := Sql;
end;

procedure TFrontOffice.AfterCreateDataSet(Const DataSetName: string; DataSet: TzFbDataSet);
begin
  inherited;

  if SameText(DataSetName, 'Front_Office_Contatti') then
  begin
    DataSet.OnNewRecord := Front_Office_ContattiNewRecord;
    // Mantis #252 - 2026-10-16: blocco dei campi a ogni cambio di record o di stato
    DataSet.AfterScroll := Front_Office_ContattiAggiornaBlocco;
    DataSet.AfterPost := Front_Office_ContattiAggiornaBlocco;
    DataSet.AfterCancel := Front_Office_ContattiAggiornaBlocco;
  end
  else
    if SameText(DataSetName, 'Front_Office_Ambiti_Int_Risorse') then
      DataSet.AfterPost := Front_Office_Ambiti_Int_RisorseAfterPost;
end;

procedure TFrontOffice.Front_Office_ContattiNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('ID_OPERATORE_FRONT_OFFICE').asInteger := Common.CurrentIdRisorsa;
  DataSet.FieldByName('STATO_RISPOSTA').AsString := 'N';

  AggiornaBloccoCampi(DataSet);
end;

procedure TFrontOffice.Front_Office_ContattiAggiornaBlocco(DataSet: TDataSet);
begin
  // dopo un salvataggio o un annullamento i dati dell'anagrafe tornano bloccati
  if DataSet.State = dsBrowse then
    FDatiAnagrafeSbloccati := False;

  AggiornaBloccoCampi(DataSet);
end;

procedure TFrontOffice.AggiornaBloccoCampi(DataSet: TDataSet);
var
  Campo: TField;
  NomeCampo: string;
  Inserimento: Boolean;
  ContattoCollegato: Boolean;
  Contatto: Int64;
begin
  if DataSet.IsEmpty and (DataSet.State <> dsInsert) then
    exit;

  Inserimento := DataSet.State = dsInsert;

  // cambiato contatto: lo sblocco dei dati dell'anagrafe valeva per il precedente
  Contatto := DataSet.FieldByName('ID_CONTATTO_FRONT_OFFICE').AsLargeInt;
  if Contatto <> FUltimoContatto then
  begin
    FUltimoContatto := Contatto;
    FDatiAnagrafeSbloccati := False;
  end;

  ContattoCollegato := not DataSet.FieldByName('ID_ANAGRAFICA_CONTATTO').IsNull;

  // l'ambito di un contatto gia' registrato si cambia solo dalla finestra di assegnazione:
  // li' si sceglie insieme ai destinatari e il database chiude i ticket del vecchio ambito
  Campo := DataSet.FindField('AMBITO_INTERESSE');
  if Assigned(Campo) then
    Campo.ReadOnly := not Inserimento;

  for NomeCampo in CAMPI_COPIATI_DA_ANAGRAFE do
  begin
    Campo := DataSet.FindField(NomeCampo);
    if Assigned(Campo) then
      Campo.ReadOnly := (not Inserimento) and ContattoCollegato and (not FDatiAnagrafeSbloccati);
  end;
end;

procedure TFrontOffice.SbloccaDatiAnagrafe;
var
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet('Front_Office_Contatti');

  if not Assigned(DataSet) or DataSet.IsEmpty then
    exit;

  FDatiAnagrafeSbloccati := True;
  AggiornaBloccoCampi(DataSet);
end;

procedure TFrontOffice.UpdateSbloccaDatiAnagrafe(out Visible: boolean);
var
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet('Front_Office_Contatti');

  Visible := Assigned(DataSet) and (not DataSet.IsEmpty) and (DataSet.State <> dsInsert) and
    (not DataSet.FieldByName('ID_ANAGRAFICA_CONTATTO').IsNull) and (not FDatiAnagrafeSbloccati);
end;

procedure TFrontOffice.Front_Office_Ambiti_Int_RisorseAfterPost(DataSet: TDataSet);
begin
  TzFbDataSet(DataSet).ReOpen();
end;

procedure TFrontOffice.ElencoDestinatariAperti(Ticket: TzFbDataSet; Destinatari: TList<Int64>);
var
  Segnalibro: TBookmark;
begin
  Destinatari.Clear;

  if Ticket.IsEmpty then
    exit;

  Segnalibro := Ticket.GetBookmark;
  Ticket.DisableControls;
  try
    Ticket.First;
    while not Ticket.Eof do
    begin
      if Ticket.FieldByName('DATA_RISPOSTA').IsNull then
        Destinatari.Add(Ticket.FieldByName('ID_OPERATORE_ASSEGNATO').AsLargeInt);
      Ticket.Next;
    end;
  finally
    if Ticket.BookmarkValid(Segnalibro) then
      Ticket.GotoBookmark(Segnalibro);
    Ticket.FreeBookmark(Segnalibro);
    Ticket.EnableControls;
  end;
end;

procedure TFrontOffice.AssegnaTicket;
var
  Front_Office_Contatti: TzFbDataSet;
  Front_Office_Contatti_Ticket: TzFbDataSet;
  CampoAmbito: TField;
  idContatto: Int64;
  AmbitoAttuale: string;
  GiaAssegnati: TList<Int64>;
  DestinatariScelti: TList<Int64>;
  IdDestinatario: Int64;
  Finestra: TFormAssegnazioneTicket;
  Confermato: Boolean;
  AmbitoScelto: string;
  NoteAssegnazione: string;
begin
  Front_Office_Contatti := GetDataSet('Front_Office_Contatti');

  if Front_Office_Contatti.IsEmpty then
    exit;

  // il contatto deve essere salvato: i ticket si legano al suo identificativo
  if Front_Office_Contatti.State <> dsBrowse then
  begin
    MessageDlg('Salvare il contatto prima di assegnare il ticket.', mtInformation, [mbOK], 0);
    exit;
  end;

  idContatto := Front_Office_Contatti.FieldByName('ID_CONTATTO_FRONT_OFFICE').AsLargeInt;
  AmbitoAttuale := Front_Office_Contatti.FieldByName('AMBITO_INTERESSE').AsString;

  Front_Office_Contatti_Ticket := GetDataSet('Front_Office_Contatti_Ticket');

  GiaAssegnati := TList<Int64>.Create;
  DestinatariScelti := TList<Int64>.Create;
  try
    ElencoDestinatariAperti(Front_Office_Contatti_Ticket, GiaAssegnati);

    Finestra := TFormAssegnazioneTicket.CreateAssegnazione(Self, AmbitoAttuale, GiaAssegnati);
    try
      Confermato := Finestra.ShowModal = mrOk;

      if Confermato then
      begin
        AmbitoScelto := Finestra.Ambito;
        NoteAssegnazione := Finestra.Note;
        Finestra.ElencoDestinatariScelti(DestinatariScelti);
      end;
    finally
      FreeAndNil(Finestra);
    end;

    if not Confermato then
      exit;

    try
      if not SameText(AmbitoScelto, AmbitoAttuale) then
      begin
        // il trigger FRONT_OFFICE_CONTATTI_AIU0 chiude i ticket del vecchio ambito e crea quelli
        // del personale del nuovo ambito che ha TICKET = TRUE
        CampoAmbito := Front_Office_Contatti.FieldByName('AMBITO_INTERESSE');
        CampoAmbito.ReadOnly := False;
        Front_Office_Contatti.Edit;
        CampoAmbito.AsString := AmbitoScelto;
        Front_Office_Contatti.Post;

        // i ticket creati dal trigger fanno parte della stessa transazione: si rileggono per non duplicarli
        ReopenDataSet('Front_Office_Contatti_Ticket');
        Front_Office_Contatti_Ticket := GetDataSet('Front_Office_Contatti_Ticket');
        ElencoDestinatariAperti(Front_Office_Contatti_Ticket, GiaAssegnati);
      end;

      for IdDestinatario in DestinatariScelti do
      begin
        if GiaAssegnati.Contains(IdDestinatario) then
          Continue;

        Front_Office_Contatti_Ticket.Append;
        Front_Office_Contatti_Ticket.FieldByName('ID_CONTATTO_FRONT_OFFICE').Value := idContatto;
        Front_Office_Contatti_Ticket.FieldByName('ID_OPERATORE_SEGNALATORE').Value := Common.CurrentIdRisorsa;
        Front_Office_Contatti_Ticket.FieldByName('ID_OPERATORE_ASSEGNATO').Value := IdDestinatario;
        Front_Office_Contatti_Ticket.FieldByName('DATA_ORA_ASSEGNAZIONE').AsDateTime := Now;
        Front_Office_Contatti_Ticket.FieldByName('STATO_RISPOSTA').Value := Front_Office_Contatti.FieldByName('STATO_RISPOSTA').Value;

        if NoteAssegnazione <> '' then
          Front_Office_Contatti_Ticket.FieldByName('NOTE_ASSEGNAZIONE').AsString := NoteAssegnazione;

        Front_Office_Contatti_Ticket.Post;
        GiaAssegnati.Add(IdDestinatario);
      end;

      Commit;
    except
      Rollback(True);
      raise;
    end;

    RefreshRecord('Front_Office_Contatti', false);
    ReopenDataSet('Front_Office_Contatti_Ticket');
  finally
    FreeAndNil(DestinatariScelti);
    FreeAndNil(GiaAssegnati);
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
