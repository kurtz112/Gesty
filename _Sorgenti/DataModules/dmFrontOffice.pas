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
  Vcl.ComCtrls,
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

    procedure CercaAnagrafica;
    procedure UpdateCercaAnagrafica(out Visible: boolean);
  end;

var
  FrontOffice: TFrontOffice;

implementation

uses
  System.Character,
  FireDAC.Comp.Client,
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

type
  // Mantis #252 - 2026-10-17: anagrafica scelta o creata nella finestra di ricerca
  TAnagraficaScelta = record
    IdAnagrafica: Int64;
    Nominativo: string;
    Telefono: string;
    Mail: string;
  end;

  // Mantis #252 - 2026-10-17: ricerca dell'anagrafica da collegare al contatto. Cerca per nominativo
  // (tutte le parole, in qualunque ordine), telefono (solo le cifre), e-mail e codice fiscale, e collega
  // per identificativo: il lookup sul nominativo sceglie sempre il primo degli omonimi. Se la persona
  // non c'e', la crea con i dati della telefonata, cosi' chi si iscrive dopo trova gia' il collegamento.
  // Nasce in codice come la finestra di assegnazione.
  TFormRicercaAnagrafica = class(TForm)
  private
    FDataModulo: TFrontOffice;
    FCasellaRicerca: TEdit;
    FEsito: TLabel;
    FRisultati: TListView;
    FIdRisultati: TList<Int64>;
    FCognome: TEdit;
    FNome: TEdit;
    FTelefono: TEdit;
    FMail: TEdit;
    FCodiceFiscale: TEdit;
    FScelta: TAnagraficaScelta;
    function CreaCasella(Contenitore: TWinControl; const Didascalia: string; Sinistra, Alto, Larghezza: Integer): TEdit;
    function CreaPulsante(Contenitore: TWinControl; const Didascalia: string; Sinistra, Alto, Larghezza: Integer): TButton;
    procedure Cerca(const Testi: array of string);
    function CreaAnagrafica: Boolean;
    procedure CercaClick(Sender: TObject);
    procedure CollegaClick(Sender: TObject);
    procedure CreaClick(Sender: TObject);
  public
    constructor CreateRicerca(DataModulo: TFrontOffice; const Nominativo, Telefono, Mail: string);
    destructor Destroy; override;
    property Scelta: TAnagraficaScelta read FScelta;
  end;

const
  MASSIMO_RISULTATI = 100;

// le sole cifre di un numero di telefono, senza il prefisso internazionale italiano
function CifreTelefono(const Testo: string): string;
var
  Carattere: Char;
begin
  Result := '';
  for Carattere in Testo do
    if CharInSet(Carattere, ['0' .. '9']) then
      Result := Result + Carattere;

  if Result.StartsWith('0039') then
    Result := Result.Substring(4)
  else
    if Result.StartsWith('39') and (Result.Length > 10) then
      Result := Result.Substring(2);
end;

// espressione SQL che toglie da un campo telefono spazi e separatori, per confrontarne le sole cifre
function SqlCifreTelefono(const Campo: string): string;
begin
  Result := 'REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(COALESCE(' + Campo + ', ''''), ' +
    ''' '', ''''), ''.'', ''''), ''-'', ''''), ''/'', ''''), ''('', ''''), '')'', ''''), ''+'', '''')';
end;

// 16 caratteri fra lettere e cifre, con almeno una cifra: una parola di 16 lettere e' un cognome, non un codice
function CodiceFiscalePlausibile(const Testo: string): Boolean;
var
  Carattere: Char;
  ContieneCifre: Boolean;
begin
  if Testo.Length <> 16 then
    Exit(False);

  ContieneCifre := False;

  for Carattere in Testo do
    if CharInSet(Carattere, ['0' .. '9']) then
      ContieneCifre := True
    else
      if not CharInSet(Carattere, ['A' .. 'Z', 'a' .. 'z']) then
        Exit(False);

  Result := ContieneCifre;
end;

function ContieneLettere(const Testo: string): Boolean;
var
  Carattere: Char;
begin
  Result := False;

  for Carattere in Testo do
    if Carattere.IsLetter then
      Exit(True);
end;

// TFormRicercaAnagrafica

constructor TFormRicercaAnagrafica.CreateRicerca(DataModulo: TFrontOffice; const Nominativo, Telefono, Mail: string);
var
  Etichetta: TLabel;
  Gruppo: TGroupBox;
  Pulsante: TButton;
  Colonna: TListColumn;
  NominativoPulito: string;
  Spazio: Integer;
begin
  inherited CreateNew(Application);

  FDataModulo := DataModulo;
  FIdRisultati := TList<Int64>.Create;

  Caption := 'Cerca anagrafica';
  BorderStyle := bsDialog;
  Position := poOwnerFormCenter;
  ClientWidth := 760;
  ClientHeight := 566;

  Etichetta := TLabel.Create(Self);
  Etichetta.Parent := Self;
  Etichetta.SetBounds(12, 12, 500, 15);
  Etichetta.Caption := 'Cerca per nominativo, telefono, e-mail o codice fiscale';

  FCasellaRicerca := TEdit.Create(Self);
  FCasellaRicerca.Parent := Self;
  FCasellaRicerca.SetBounds(12, 32, 620, 23);

  // Invio nella casella di ricerca avvia la ricerca
  Pulsante := CreaPulsante(Self, 'Cerca', 640, 31, 108);
  Pulsante.Default := True;
  Pulsante.OnClick := CercaClick;

  FRisultati := TListView.Create(Self);
  FRisultati.Parent := Self;
  FRisultati.SetBounds(12, 64, 736, 250);
  FRisultati.ViewStyle := vsReport;
  FRisultati.RowSelect := True;
  FRisultati.ReadOnly := True;
  FRisultati.HideSelection := False;
  FRisultati.GridLines := True;
  FRisultati.OnDblClick := CollegaClick;

  Colonna := FRisultati.Columns.Add;
  Colonna.Caption := 'Nominativo';
  Colonna.Width := 200;
  Colonna := FRisultati.Columns.Add;
  Colonna.Caption := 'Codice fiscale';
  Colonna.Width := 130;
  Colonna := FRisultati.Columns.Add;
  Colonna.Caption := 'Nato il';
  Colonna.Width := 75;
  Colonna := FRisultati.Columns.Add;
  Colonna.Caption := 'Telefono';
  Colonna.Width := 105;
  Colonna := FRisultati.Columns.Add;
  Colonna.Caption := 'E-mail';
  Colonna.Width := 135;
  Colonna := FRisultati.Columns.Add;
  Colonna.Caption := 'Residenza';
  Colonna.Width := 80;

  FEsito := TLabel.Create(Self);
  FEsito.Parent := Self;
  FEsito.SetBounds(12, 322, 500, 15);

  Pulsante := CreaPulsante(Self, 'Collega l''anagrafica selezionata', 528, 318, 220);
  Pulsante.OnClick := CollegaClick;

  Gruppo := TGroupBox.Create(Self);
  Gruppo.Parent := Self;
  Gruppo.SetBounds(12, 356, 736, 166);
  Gruppo.Caption := ' Nuova anagrafica, se la persona non e'' nell''elenco ';

  FCognome := CreaCasella(Gruppo, 'Cognome', 12, 22, 230);
  FNome := CreaCasella(Gruppo, 'Nome', 254, 22, 230);
  FCodiceFiscale := CreaCasella(Gruppo, 'Codice fiscale (facoltativo)', 496, 22, 228);
  FCodiceFiscale.CharCase := ecUpperCase;
  FCodiceFiscale.MaxLength := 16;
  FTelefono := CreaCasella(Gruppo, 'Telefono', 12, 76, 230);
  FMail := CreaCasella(Gruppo, 'E-mail', 254, 76, 230);

  Pulsante := CreaPulsante(Gruppo, 'Crea e collega', 496, 94, 228);
  Pulsante.OnClick := CreaClick;

  Pulsante := CreaPulsante(Self, 'Annulla', 668, 532, 80);
  Pulsante.ModalResult := mrCancel;
  Pulsante.Cancel := True;

  // i dati della telefonata propongono la nuova anagrafica: il nominativo si divide al primo spazio
  // (cognome, poi nome), l'operatore lo corregge per i cognomi composti
  NominativoPulito := Trim(Nominativo);
  Spazio := Pos(' ', NominativoPulito);

  if Spazio > 0 then
  begin
    FCognome.Text := Copy(NominativoPulito, 1, Spazio - 1);
    FNome.Text := Trim(Copy(NominativoPulito, Spazio + 1, MaxInt));
  end
  else
    FCognome.Text := NominativoPulito;

  FTelefono.Text := Trim(Telefono);
  FMail.Text := Trim(Mail);

  if Trim(Telefono) <> '' then
    FCasellaRicerca.Text := Trim(Telefono)
  else
    if Trim(Mail) <> '' then
      FCasellaRicerca.Text := Trim(Mail)
    else
      FCasellaRicerca.Text := NominativoPulito;

  Cerca([Nominativo, Telefono, Mail]);
end;

destructor TFormRicercaAnagrafica.Destroy;
begin
  FreeAndNil(FIdRisultati);
  inherited;
end;

function TFormRicercaAnagrafica.CreaCasella(Contenitore: TWinControl; const Didascalia: string; Sinistra, Alto, Larghezza: Integer): TEdit;
var
  Etichetta: TLabel;
begin
  Etichetta := TLabel.Create(Self);
  Etichetta.Parent := Contenitore;
  Etichetta.SetBounds(Sinistra, Alto, Larghezza, 15);
  Etichetta.Caption := Didascalia;

  Result := TEdit.Create(Self);
  Result.Parent := Contenitore;
  Result.SetBounds(Sinistra, Alto + 18, Larghezza, 23);
end;

function TFormRicercaAnagrafica.CreaPulsante(Contenitore: TWinControl; const Didascalia: string; Sinistra, Alto, Larghezza: Integer): TButton;
begin
  Result := TButton.Create(Self);
  Result.Parent := Contenitore;
  Result.SetBounds(Sinistra, Alto, Larghezza, 26);
  Result.Caption := Didascalia;
end;

procedure TFormRicercaAnagrafica.Cerca(const Testi: array of string);
var
  Valori: TList<string>;
  Condizioni: string;
  CondizioneNominativo: string;
  Testo: string;
  Parola: string;
  Cifre: string;
  Query: TzFbDataSet;
  Indice: Integer;
  Elemento: TListItem;
  AltriRisultati: Boolean;

  function Parametro(const Valore: string): string;
  begin
    Result := ':P' + IntToStr(Valori.Count);
    Valori.Add(Valore);
  end;

  procedure AggiungiCondizione(const Condizione: string);
  begin
    if Condizioni <> '' then
      Condizioni := Condizioni + ' OR ';
    Condizioni := Condizioni + Condizione;
  end;

begin
  Valori := TList<string>.Create;
  FRisultati.Items.BeginUpdate;
  try
    FRisultati.Items.Clear;
    FIdRisultati.Clear;
    Condizioni := '';

    for Indice := Low(Testi) to High(Testi) do
    begin
      Testo := Trim(Testi[Indice]);

      if Testo = '' then
        Continue;

      if Testo.Contains('@') then
      begin
        AggiungiCondizione('(ANAGRAFE.E_MAIL = ' + Parametro(Testo) + ' OR ANAGRAFE.E_MAIL_ENTE = ' + Parametro(Testo) + ')');
        Continue;
      end;

      if CodiceFiscalePlausibile(Testo) then
      begin
        AggiungiCondizione('(ANAGRAFE.CODICE_FISCALE = ' + Parametro(UpperCase(Testo)) + ')');
        Continue;
      end;

      // un numero si confronta sulle sole cifre: in anagrafe i telefoni sono scritti in molti modi
      Cifre := CifreTelefono(Testo);
      if Cifre.Length >= 6 then
        AggiungiCondizione('(' + SqlCifreTelefono('ANAGRAFE.TELEFONO_1') + ' CONTAINING ' + Parametro(Cifre) +
          ' OR ' + SqlCifreTelefono('ANAGRAFE.TELEFONO_2') + ' CONTAINING ' + Parametro(Cifre) + ')');

      // ogni parola deve comparire nel nominativo, in qualunque ordine ("Mario Rossi" trova "Rossi Mario")
      if ContieneLettere(Testo) then
      begin
        CondizioneNominativo := '';

        for Parola in Testo.Split([' '], TStringSplitOptions.ExcludeEmpty) do
        begin
          if CondizioneNominativo <> '' then
            CondizioneNominativo := CondizioneNominativo + ' AND ';
          CondizioneNominativo := CondizioneNominativo + 'ANAGRAFE.NOMINATIVO CONTAINING ' + Parametro(Parola);
        end;

        AggiungiCondizione('(' + CondizioneNominativo + ')');
      end;
    end;

    if Condizioni = '' then
    begin
      FEsito.Caption := 'Scrivere un nominativo, un telefono (almeno 6 cifre), una e-mail o un codice fiscale.';
      exit;
    end;

    Query := FDataModulo.NuovaQuery('SELECT FIRST ' + IntToStr(MASSIMO_RISULTATI + 1) + ' ' +
      'ANAGRAFE.ID_ANAGRAFICA, ANAGRAFE.NOMINATIVO, ANAGRAFE.CODICE_FISCALE, ANAGRAFE.DATA_NASCITA, ' +
      'COALESCE(ANAGRAFE.TELEFONO_1, ANAGRAFE.TELEFONO_2) AS TELEFONO, ' +
      'COALESCE(ANAGRAFE.E_MAIL, ANAGRAFE.E_MAIL_ENTE) AS E_MAIL, ' +
      'ANAGRAFE.RESIDENZA_CITTA ' +
      'FROM ANAGRAFE ' +
      'WHERE ' + Condizioni + ' ' +
      'ORDER BY ANAGRAFE.COGNOME, ANAGRAFE.NOME, ANAGRAFE.DATA_NASCITA');
    try
      for Indice := 0 to Valori.Count - 1 do
        Query.ParamByName('P' + IntToStr(Indice)).AsString := Valori[Indice];

      Query.Open;

      while (not Query.Eof) and (FIdRisultati.Count < MASSIMO_RISULTATI) do
      begin
        Elemento := FRisultati.Items.Add;
        Elemento.Caption := Query.FieldByName('NOMINATIVO').AsString;
        Elemento.SubItems.Add(Query.FieldByName('CODICE_FISCALE').AsString);

        if Query.FieldByName('DATA_NASCITA').IsNull then
          Elemento.SubItems.Add('')
        else
          Elemento.SubItems.Add(DateToStr(Query.FieldByName('DATA_NASCITA').AsDateTime));

        Elemento.SubItems.Add(Query.FieldByName('TELEFONO').AsString);
        Elemento.SubItems.Add(Query.FieldByName('E_MAIL').AsString);
        Elemento.SubItems.Add(Query.FieldByName('RESIDENZA_CITTA').AsString);

        FIdRisultati.Add(Query.FieldByName('ID_ANAGRAFICA').AsLargeInt);
        Query.Next;
      end;

      AltriRisultati := not Query.Eof;
    finally
      FreeAndNil(Query);
    end;

    if FIdRisultati.Count = 0 then
      FEsito.Caption := 'Nessuna anagrafica trovata.'
    else
      if AltriRisultati then
        FEsito.Caption := Format('Mostrate le prime %d anagrafiche: precisare la ricerca.', [MASSIMO_RISULTATI])
      else
        FEsito.Caption := Format('%d anagrafiche trovate.', [FIdRisultati.Count]);
  finally
    FRisultati.Items.EndUpdate;
    FreeAndNil(Valori);
  end;
end;

procedure TFormRicercaAnagrafica.CercaClick(Sender: TObject);
begin
  Cerca([FCasellaRicerca.Text]);
end;

procedure TFormRicercaAnagrafica.CollegaClick(Sender: TObject);
var
  Elemento: TListItem;
begin
  Elemento := FRisultati.Selected;

  if not Assigned(Elemento) then
  begin
    MessageDlg('Selezionare un''anagrafica dall''elenco.', mtInformation, [mbOK], 0);
    exit;
  end;

  FScelta.IdAnagrafica := FIdRisultati[Elemento.Index];
  FScelta.Nominativo := Elemento.Caption;
  FScelta.Telefono := Elemento.SubItems[2];
  FScelta.Mail := Elemento.SubItems[3];

  ModalResult := mrOk;
end;

procedure TFormRicercaAnagrafica.CreaClick(Sender: TObject);
var
  CodiceFiscale: string;
begin
  if (Trim(FCognome.Text) = '') or (Trim(FNome.Text) = '') then
  begin
    MessageDlg('Cognome e nome sono obbligatori per creare l''anagrafica.', mtWarning, [mbOK], 0);
    exit;
  end;

  CodiceFiscale := UpperCase(Trim(FCodiceFiscale.Text));

  if (CodiceFiscale <> '') and not CodiceFiscalePlausibile(CodiceFiscale) then
  begin
    MessageDlg('Il codice fiscale deve avere 16 caratteri fra lettere e cifre. Se non lo si conosce, lasciarlo vuoto.', mtWarning, [mbOK], 0);
    exit;
  end;

  // prima di creare si mostrano le anagrafiche che somigliano: un doppione in anagrafe e' peggio
  // di un contatto non collegato, perche' l'iscrizione successiva potrebbe agganciare l'altra
  Cerca([Trim(FCognome.Text) + ' ' + Trim(FNome.Text), FTelefono.Text, FMail.Text, CodiceFiscale]);

  if FIdRisultati.Count > 0 then
    if MessageDlg(Format('Ci sono %d anagrafiche simili, elencate sopra. Se la persona e'' fra queste, ' +
      'selezionarla e premere "Collega l''anagrafica selezionata".' + sLineBreak + sLineBreak +
      'Creare comunque una nuova anagrafica?', [FIdRisultati.Count]), mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      exit;

  if CreaAnagrafica then
    ModalResult := mrOk;
end;

function TFormRicercaAnagrafica.CreaAnagrafica: Boolean;
var
  Transazione: TFDTransaction;
  Query: TFDQuery;

  procedure ImpostaTesto(const NomeParametro, Valore: string);
  begin
    Query.ParamByName(NomeParametro).DataType := ftString;

    if Trim(Valore) = '' then
      Query.ParamByName(NomeParametro).Clear
    else
      Query.ParamByName(NomeParametro).AsString := Trim(Valore);
  end;

begin
  Result := False;

  // transazione propria: il Commit del modulo dati salverebbe anche il contatto ancora in modifica
  Transazione := TFDTransaction.Create(nil);
  Query := TFDQuery.Create(nil);
  try
    Transazione.Connection := Config.Database;
    Query.Connection := Config.Database;
    Query.Transaction := Transazione;

    // con RETURNING FireDAC apre l'istruzione come un cursore di una riga
    Query.SQL.Text := 'INSERT INTO ANAGRAFE (COGNOME, NOME, TELEFONO_1, E_MAIL, CODICE_FISCALE) ' +
      'VALUES (:COGNOME, :NOME, :TELEFONO_1, :E_MAIL, :CODICE_FISCALE) ' +
      'RETURNING ID_ANAGRAFICA, NOMINATIVO';

    ImpostaTesto('COGNOME', FCognome.Text);
    ImpostaTesto('NOME', FNome.Text);
    ImpostaTesto('TELEFONO_1', FTelefono.Text);
    ImpostaTesto('E_MAIL', FMail.Text);
    ImpostaTesto('CODICE_FISCALE', UpperCase(FCodiceFiscale.Text));

    Transazione.StartTransaction;
    try
      Query.Open;
      FScelta.IdAnagrafica := Query.FieldByName('ID_ANAGRAFICA').AsLargeInt;
      FScelta.Nominativo := Query.FieldByName('NOMINATIVO').AsString;
      Query.Close;

      Transazione.Commit;
    except
      if Transazione.Active then
        Transazione.Rollback;
      raise;
    end;

    FScelta.Telefono := Trim(FTelefono.Text);
    FScelta.Mail := Trim(FMail.Text);
    Result := True;
  finally
    FreeAndNil(Query);
    FreeAndNil(Transazione);
  end;
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

// Mantis #252 - 2026-10-17: collegamento del contatto all'anagrafica, scelta per identificativo o creata
procedure TFrontOffice.CercaAnagrafica;
var
  DataSet: TzFbDataSet;
  Finestra: TFormRicercaAnagrafica;
  Confermato: Boolean;
  Scelta: TAnagraficaScelta;
  TelefonoContatto: string;
  MailContatto: string;
  NomeCampo: string;
  Campo: TField;
  CampoId: TField;
  IdEraInSolaLettura: Boolean;
begin
  DataSet := GetDataSet('Front_Office_Contatti');

  if not Assigned(DataSet) or (DataSet.IsEmpty and (DataSet.State <> dsInsert)) then
    exit;

  // il telefono e la mail della telefonata valgono piu' di quelli dell'anagrafe: si conservano
  TelefonoContatto := Trim(DataSet.FieldByName('TELEFONO').AsString);
  MailContatto := Trim(DataSet.FieldByName('E_MAIL').AsString);

  Finestra := TFormRicercaAnagrafica.CreateRicerca(Self, DataSet.FieldByName('NOMINATIVO_CONTATTO').AsString,
    TelefonoContatto, MailContatto);
  try
    Confermato := Finestra.ShowModal = mrOk;

    if Confermato then
      Scelta := Finestra.Scelta;
  finally
    FreeAndNil(Finestra);
  end;

  if not Confermato then
    exit;

  if DataSet.State = dsBrowse then
    DataSet.Edit;

  // i campi copiati dall'anagrafe sono in sola lettura se il contatto era gia' collegato:
  // si scrivono qui e AggiornaBloccoCampi li riblocca
  for NomeCampo in CAMPI_COPIATI_DA_ANAGRAFE do
  begin
    Campo := DataSet.FindField(NomeCampo);
    if Assigned(Campo) then
      Campo.ReadOnly := False;
  end;

  CampoId := DataSet.FieldByName('ID_ANAGRAFICA_CONTATTO');
  IdEraInSolaLettura := CampoId.ReadOnly;
  CampoId.ReadOnly := False;
  try
    // prima il nominativo: il dizionario, quando cambia, svuota collegamento, telefono e mail
    DataSet.FieldByName('NOMINATIVO_CONTATTO').AsString := Scelta.Nominativo;
    CampoId.AsLargeInt := Scelta.IdAnagrafica;

    if TelefonoContatto <> '' then
      DataSet.FieldByName('TELEFONO').AsString := TelefonoContatto
    else
      DataSet.FieldByName('TELEFONO').AsString := Scelta.Telefono;

    if MailContatto <> '' then
      DataSet.FieldByName('E_MAIL').AsString := MailContatto
    else
      DataSet.FieldByName('E_MAIL').AsString := Scelta.Mail;
  finally
    CampoId.ReadOnly := IdEraInSolaLettura;
    AggiornaBloccoCampi(DataSet);
  end;
end;

procedure TFrontOffice.UpdateCercaAnagrafica(out Visible: boolean);
var
  DataSet: TzFbDataSet;
begin
  DataSet := GetDataSet('Front_Office_Contatti');

  Visible := Assigned(DataSet) and ((not DataSet.IsEmpty) or (DataSet.State = dsInsert));
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
