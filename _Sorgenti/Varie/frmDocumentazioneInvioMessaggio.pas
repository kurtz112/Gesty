unit frmDocumentazioneInvioMessaggio;

// Dialogo di composizione per l'azione documentale "Invia PEC" (Gesty).
// Alimenta la callback OnRichiediInvioPec del controller: raccoglie oggetto,
// corpo e destinatari e li restituisce al ponte Documentazione.Messaggi.
// Destinatari come indirizzi liberi, uno per riga: il primo riquadro sono i
// destinatari principali (TO), il secondo le copie conoscenza (CC).
// La funzione globale RichiediInvioMessaggio si assegna direttamente a
// ActionsController.OnRichiediInvioPec (stessa firma di TzRichiediInvioPecFunc).

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxControls,
  cxContainer,
  cxEdit,
  cxTextEdit,
  cxMemo,
  cxButtons,
  zOffice.Reports.types,
  zDocumentale.Messaggi.types,
  Vcl.Menus,
  zOffice.Reports.Controller;

type
  TFormDocumentazioneInvioMessaggio = class(TForm)
    PanelBottoni: TPanel;
    btnOk: TcxButton;
    btnAnnulla: TcxButton;
    LabelDestinatari: TLabel;
    LabelCopie: TLabel;
    LabelOggetto: TLabel;
    LabelCorpo: TLabel;
    edOggetto: TcxTextEdit;
    meDestinatari: TcxMemo;
    meCopie: TcxMemo;
    meCorpo: TcxMemo;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    procedure LeggiDestinatari(out Destinatari: TArray<TzMessaggioDestinatario>);
  public
    function Componi(const Contesto: TzDocumentoContesto; out Oggetto, Corpo: string; out Destinatari: TArray<TzMessaggioDestinatario>): Boolean;
  end;

  // da assegnare a ActionsController.OnRichiediInvioPec (firma TzRichiediInvioPecFunc)
function RichiediInvioMessaggio(const Contesto: TzDocumentoContesto; out Oggetto, Corpo: string; out Destinatari: TArray<TzMessaggioDestinatario>): Boolean;

implementation

uses
  zMsg;

{$R *.dfm}

procedure AggiungiDestinatari(const Testo: string; Tipo: TzMessaggioTipoDestinatario; var Destinatari: TArray<TzMessaggioDestinatario>);
var
  righe: TStringList;
  i: Integer;
  indirizzo: string;
  destinatario: TzMessaggioDestinatario;
begin
  righe := TStringList.Create;
  try
    righe.Text := Testo;
    for i := 0 to righe.Count - 1 do
    begin
      indirizzo := righe[i].Trim;
      if indirizzo.IsEmpty then
        continue;
      destinatario.Clear;
      destinatario.indirizzo := indirizzo;
      destinatario.Tipo := Tipo;
      Destinatari := Destinatari + [destinatario];
    end;
  finally
    FreeAndNil(righe);
  end;
end;

function RichiediInvioMessaggio(const Contesto: TzDocumentoContesto; out Oggetto, Corpo: string; out Destinatari: TArray<TzMessaggioDestinatario>): Boolean;
var
  frm: TFormDocumentazioneInvioMessaggio;
begin
  Application.CreateForm(TFormDocumentazioneInvioMessaggio, frm);
  try
    result := frm.Componi(Contesto, Oggetto, Corpo, Destinatari);
  finally
    FreeAndNil(frm);
  end;
end;

procedure TFormDocumentazioneInvioMessaggio.LeggiDestinatari(out Destinatari: TArray<TzMessaggioDestinatario>);
begin
  Destinatari := nil;
  AggiungiDestinatari(meDestinatari.Text, pdDestinatario, Destinatari);
  AggiungiDestinatari(meCopie.Text, pdCopiaConoscenza, Destinatari);
end;

function TFormDocumentazioneInvioMessaggio.Componi(const Contesto: TzDocumentoContesto; out Oggetto, Corpo: string; out Destinatari: TArray<TzMessaggioDestinatario>): Boolean;
begin
  Oggetto := '';
  Corpo := '';
  Destinatari := nil;

  edOggetto.Text := '';
  meCorpo.Clear;
  meDestinatari.Clear;
  meCopie.Clear;

  ActiveControl := meDestinatari;
  result := ShowModal = mrOk;
  if result then
  begin
    Oggetto := Trim(edOggetto.Text);
    Corpo := meCorpo.Text;
    LeggiDestinatari(Destinatari);
  end;
end;

procedure TFormDocumentazioneInvioMessaggio.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  Destinatari: TArray<TzMessaggioDestinatario>;
begin

  if ModalResult <> mrOk then
    exit;

  if Trim(edOggetto.Text).IsEmpty then
  begin
    CanClose := False;
    ConfirmOk('Indicare l''oggetto del messaggio');
    exit;
  end;

  LeggiDestinatari(Destinatari);

  if Length(Destinatari) = 0 then
  begin
    CanClose := False;
    ConfirmOk('Indicare almeno un destinatario');
  end;
end;

end.
