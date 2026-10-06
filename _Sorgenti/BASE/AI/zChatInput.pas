// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-15
// ---------------------------------------------------------------------------

unit zChatInput;

{ Pannello di input per TzChat: memo multiriga + pulsante invio/interrompi,
  pulsante allegato con barra delle anteprime rimovibili e combo per la scelta
  del modello AI.

  Gestione tasti:
    - Invio            -> invia il messaggio
    - Shift+Invio      -> a capo nel memo

  Eventi tipizzati (procedure of object, niente closure):
    - OnSend(Sender; Text; Attachments)  al momento dell'invio
    - OnCancel(Sender)                   al momento dell'interruzione
    - OnModelChanged(Sender)             quando cambia il modello scelto
    - OnRefreshModels(Sender)             quando si preme il pulsante di
                                           aggiornamento dentro il combo modello

  Gli allegati scelti prima dell'invio restano in una lista "pendente" e vengono
  mostrati come tasselli rimovibili sopra l'area di testo. }

interface

uses
  System.SysUtils, System.Classes, System.Types,
  Winapi.Windows, Winapi.Messages,
  Vcl.Controls, Vcl.Graphics, Vcl.Dialogs, Vcl.Forms,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMemo, cxButtons,
  cxDropDownEdit, dxShellDialogs,
  zChatTypes;

const
  { Rimozione di un allegato rimandata a gestore concluso: vedi
    AttachmentChipClick. Dichiarata qui (interface) perche' un metodo
    "message" deve conoscerla in fase di dichiarazione della classe, non
    solo alla sua implementazione. }
  CM_RIMUOVI_ALLEGATO = WM_USER + 137;

type
  { L'invio porta il testo e la lista di percorsi file allegati. }
  TzChatSendEvent = procedure(Sender: TObject; const Text: string;
    Attachments: TStrings) of object;

  TzChatInputPanel = class(TcxControl)
  private
    FPalette: TzChatPalette;   // colori della skin attiva
    FMemo: TcxMemo;
    FSendButton: TcxButton;
    FAttachButton: TcxButton;
    FModelCombo: TcxComboBox;
    FPendingAttachments: TStringList;
    FAttachmentsBar: TScrollBox;
    FOpenDialog: TdxOpenFileDialog;
    FProcessing: Boolean;
    { Altezza che il pannello si e' preso da se' per fare posto alla barra
      degli allegati: serve a restituirla quando la barra sparisce, senza
      toccare quella che l'utente ha scelto col divisore. }
    FAltezzaAggiunta: Integer;
    FOnSend: TzChatSendEvent;
    FOnCancel: TNotifyEvent;
    FOnModelChanged: TNotifyEvent;
    FOnRefreshModels: TNotifyEvent;
    procedure MemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SendButtonClick(Sender: TObject);
    procedure AttachButtonClick(Sender: TObject);
    procedure AttachmentChipClick(Sender: TObject);
    procedure ModelComboChange(Sender: TObject);
    procedure ModelComboButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure DoSend;
    procedure DoCancel;
    procedure SetProcessing(const Value: Boolean);
    procedure RefreshAttachmentsBar;
    procedure AdattaAltezza;
    procedure RimuoviAllegato(var Message: TMessage); message CM_RIMUOVI_ALLEGATO;
    function GetCurrentModel: string;
    procedure SetModels(const Value: TStrings);
    function GetModels: TStrings;
  protected
    procedure Paint; override;
  public
    { Rinfresca lo sfondo dalla skin attiva. La chiama TzChat, che e' iscritto
      alle notifiche di cambio skin. }
    procedure AggiornaPalette;
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    function CurrentText: string;
    property OnSend: TzChatSendEvent read FOnSend write FOnSend;
    property OnCancel: TNotifyEvent read FOnCancel write FOnCancel;
    property OnModelChanged: TNotifyEvent
      read FOnModelChanged write FOnModelChanged;
    property OnRefreshModels: TNotifyEvent
      read FOnRefreshModels write FOnRefreshModels;
    property Memo: TcxMemo read FMemo;
    { Indica se una generazione e' in corso: commuta il pulsante in Interrompi }
    property Processing: Boolean read FProcessing write SetProcessing;
    { Elenco dei modelli selezionabili (riempito dal contenitore). }
    property Models: TStrings read GetModels write SetModels;
    property CurrentModel: string read GetCurrentModel;
  end;

implementation

uses
  System.UITypes;

const
  MIN_HEIGHT = 76;
  ATTACHMENTS_BAR_HEIGHT = 28;
  SEND_BUTTON_WIDTH = 88;
  ATTACH_BUTTON_WIDTH = 56;
  COMBO_WIDTH = 160;
  ROW_HEIGHT = 26;
  MARGIN = 4;

{ TzChatInputPanel }

constructor TzChatInputPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Height := MIN_HEIGHT;
  FProcessing := False;
  FAltezzaAggiunta := 0;
  AggiornaPalette;

  FPendingAttachments := TStringList.Create;

  { Dialogo file DevExpress: skinnabile, API compatibile con TOpenDialog. }
  FOpenDialog := TdxOpenFileDialog.Create(Self);
  FOpenDialog.Options := FOpenDialog.Options + [ofAllowMultiSelect];
  FOpenDialog.Filter :=
    'Tutti i file|*.*|Documenti|*.pdf;*.docx;*.xlsx;*.txt|Immagini|*.png;*.jpg;*.jpeg;*.gif;*.bmp';

  { Barra orizzontale scorrevole per gli allegati pendenti }
  FAttachmentsBar := TScrollBox.Create(Self);
  FAttachmentsBar.Parent := Self;
  FAttachmentsBar.BorderStyle := bsNone;
  FAttachmentsBar.Height := ATTACHMENTS_BAR_HEIGHT;
  FAttachmentsBar.Visible := False;
  FAttachmentsBar.Color := FPalette.Sfondo;

  FMemo := TcxMemo.Create(Self);
  FMemo.Parent := Self;
  FMemo.Properties.WantReturns := True;   // Shift+Invio inserisce a capo
  FMemo.Properties.ScrollBars := TScrollStyle.ssVertical;
  FMemo.OnKeyDown := MemoKeyDown;

  { Pulsante allegato: apre il dialogo file. }
  FAttachButton := TcxButton.Create(Self);
  FAttachButton.Parent := Self;
  FAttachButton.Caption := 'Allega';
  FAttachButton.OnClick := AttachButtonClick;

  { Combo modello: lista fissa, accanto all'input. }
  FModelCombo := TcxComboBox.Create(Self);
  FModelCombo.Parent := Self;
  FModelCombo.Properties.DropDownListStyle := lsFixedList;
  FModelCombo.Properties.OnChange := ModelComboChange;

  { Pulsante di aggiornamento DENTRO il combo stesso: TcxComboBoxProperties
    eredita da TcxCustomEditProperties la collezione Buttons (quella che
    disegna gia' la freccia di apertura), quindi basta aggiungerne uno
    invece di un pulsante fisico accanto. }
  with FModelCombo.Properties.Buttons.Add do
  begin
    Kind := bkText;
    { Carattere di codice, non il glifo scritto direttamente nel sorgente: il
      file e' salvato in ANSI/CP1252, che non contiene la freccia circolare
      (U+21BB) usata come icona di aggiornamento. }
    Caption := #$21BB;
    Hint := 'Aggiorna l''elenco dei modelli dal fornitore AI';
  end;
  FModelCombo.Properties.OnButtonClick := ModelComboButtonClick;

  FSendButton := TcxButton.Create(Self);
  FSendButton.Parent := Self;
  FSendButton.Caption := 'Invia';
  FSendButton.OnClick := SendButtonClick;
end;

destructor TzChatInputPanel.Destroy;
begin
  FPendingAttachments.Free;
  inherited Destroy;
end;

procedure TzChatInputPanel.AggiornaPalette;
begin
  FPalette := TzChatPalette.Corrente;

  if HandleAllocated then
  begin
    Color := FPalette.Sfondo;
    if FAttachmentsBar <> nil then
      FAttachmentsBar.Color := FPalette.Sfondo;
    Invalidate;
  end;
end;

procedure TzChatInputPanel.Paint;
begin
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := FPalette.Sfondo;
  Canvas.FillRect(ClientRect);
end;

procedure TzChatInputPanel.Resize;
var
  TopRowY, BarY, MemoY, MemoWidth: Integer;
begin
  inherited Resize;
  if FMemo = nil then
    Exit;

  TopRowY := MARGIN;
  FModelCombo.SetBounds(MARGIN, TopRowY, COMBO_WIDTH, ROW_HEIGHT);
  FAttachButton.SetBounds(MARGIN * 2 + COMBO_WIDTH, TopRowY, ATTACH_BUTTON_WIDTH, ROW_HEIGHT);

  if FAttachmentsBar.Visible then
  begin
    BarY := TopRowY + ROW_HEIGHT + MARGIN;
    FAttachmentsBar.SetBounds(MARGIN, BarY, ClientWidth - 2 * MARGIN, ATTACHMENTS_BAR_HEIGHT);
    MemoY := BarY + ATTACHMENTS_BAR_HEIGHT + MARGIN;
  end
  else
    MemoY := TopRowY + ROW_HEIGHT + MARGIN;

  MemoWidth := ClientWidth - SEND_BUTTON_WIDTH - 3 * MARGIN;
  if MemoWidth < 40 then
    MemoWidth := 40;

  FMemo.SetBounds(MARGIN, MemoY, MemoWidth, ClientHeight - MemoY - MARGIN);
  FSendButton.SetBounds(ClientWidth - SEND_BUTTON_WIDTH - MARGIN,
    MemoY, SEND_BUTTON_WIDTH, ClientHeight - MemoY - MARGIN);
end;

procedure TzChatInputPanel.RefreshAttachmentsBar;
var
  Index, PosX: Integer;
  Chip: TcxButton;
  FileName: string;
begin
  // Rimuove i vecchi chip
  while FAttachmentsBar.ControlCount > 0 do
    FAttachmentsBar.Controls[0].Free;

  if FPendingAttachments.Count = 0 then
  begin
    FAttachmentsBar.Visible := False;
    AdattaAltezza;
    Resize;
    Exit;
  end;

  FAttachmentsBar.Visible := True;
  PosX := 0;

  for Index := 0 to FPendingAttachments.Count - 1 do
  begin
    FileName := ExtractFileName(FPendingAttachments[Index]);
    Chip := TcxButton.Create(FAttachmentsBar);
    Chip.Parent := FAttachmentsBar;
    Chip.Caption := FileName + '  x';
    Chip.Hint := FPendingAttachments[Index] + sLineBreak + 'Clicca per rimuovere';
    Chip.ShowHint := True;
    Chip.SpeedButtonOptions.Flat := True;
    Chip.Tag := Index;
    Chip.Height := ATTACHMENTS_BAR_HEIGHT - 4;
    { La larghezza si misura col carattere del tassello, non con quello del
      pannello: sono due font diversi e la differenza si vede. }
    Canvas.Font.Assign(Chip.Font);
    Chip.Width := Canvas.TextWidth(Chip.Caption) + 24;
    Chip.Left := PosX;
    Chip.Top := 2;
    Chip.OnClick := AttachmentChipClick;
    Inc(PosX, Chip.Width + 4);
  end;

  AdattaAltezza;
  Resize;
end;

{ La barra degli allegati ruba spazio al riquadro di scrittura: con l'altezza
  minima (76) il memo scenderebbe a 6 pixel, cioe' sparirebbe. Il pannello si
  prende l'altezza che serve e la restituisce quando la barra non c'e' piu',
  lasciando intatto l'eventuale allargamento fatto col divisore. }
procedure TzChatInputPanel.AdattaAltezza;
var
  Aggiunta: Integer;
begin

  if FAttachmentsBar.Visible then
    Aggiunta := ATTACHMENTS_BAR_HEIGHT + MARGIN
  else
    Aggiunta := 0;

  if Aggiunta = FAltezzaAggiunta then
    Exit;

  Height := Height + (Aggiunta - FAltezzaAggiunta);
  FAltezzaAggiunta := Aggiunta;
end;

procedure TzChatInputPanel.AttachmentChipClick(Sender: TObject);
begin

  if not (Sender is TComponent) then
    Exit;

  { NON si libera qui il pulsante che ha appena generato il clic: quando
    questo gestore finisce il VCL torna dentro il pulsante e ne tocca lo
    stato, su un oggetto che nel frattempo non esisterebbe piu'. La rimozione
    si rimanda a un messaggio, che arriva a gestore concluso.
    Senza handle non si puo' rimandare: caso che non capita (la barra e'
    visibile, quindi la finestra c'e'), ma tanto vale non lasciarlo aperto. }
  if HandleAllocated then
    PostMessage(Handle, CM_RIMUOVI_ALLEGATO, TComponent(Sender).Tag, 0);
end;

procedure TzChatInputPanel.RimuoviAllegato(var Message: TMessage);
var
  Indice: Integer;
begin
  Indice := Message.WParam;

  if (Indice >= 0) and (Indice < FPendingAttachments.Count) then
  begin
    FPendingAttachments.Delete(Indice);
    RefreshAttachmentsBar;
  end;
end;

procedure TzChatInputPanel.SetProcessing(const Value: Boolean);
begin
  if FProcessing <> Value then
  begin
    FProcessing := Value;
    if FProcessing then
    begin
      FSendButton.Caption := 'Interrompi';
      FSendButton.Colors.Normal := clWebFirebrick;
      FSendButton.Colors.NormalText := clWhite;
    end
    else
    begin
      FSendButton.Caption := 'Invia';
      FSendButton.Colors.Normal := clDefault;
      FSendButton.Colors.NormalText := clDefault;
    end;
  end;
end;

procedure TzChatInputPanel.MemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and not (ssShift in Shift) then
  begin
    Key := 0;   // consuma il tasto: niente a capo
    if FProcessing then
      DoCancel
    else
      DoSend;
  end;
end;

procedure TzChatInputPanel.SendButtonClick(Sender: TObject);
begin
  if FProcessing then
    DoCancel
  else
    DoSend;
end;

procedure TzChatInputPanel.DoCancel;
begin
  if Assigned(FOnCancel) then
    FOnCancel(Self);
end;

procedure TzChatInputPanel.AttachButtonClick(Sender: TObject);
begin
  if FOpenDialog.Execute then
  begin
    FPendingAttachments.AddStrings(FOpenDialog.Files);
    RefreshAttachmentsBar;
  end;
end;

procedure TzChatInputPanel.ModelComboChange(Sender: TObject);
begin
  if Assigned(FOnModelChanged) then
    FOnModelChanged(Self);
end;

{ L'unico pulsante aggiunto e' sempre l'ultimo della collezione: la freccia
  di apertura del combo resta quella predefinita all'indice 0 e non va
  confusa con questo. }
procedure TzChatInputPanel.ModelComboButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  if (AButtonIndex = FModelCombo.Properties.Buttons.Count - 1)
    and Assigned(FOnRefreshModels) then
    FOnRefreshModels(Self);
end;

procedure TzChatInputPanel.DoSend;
var
  Text: string;
begin
  Text := CurrentText;
  if (Trim(Text) = '') and (FPendingAttachments.Count = 0) then
    Exit;

  if Assigned(FOnSend) then
    FOnSend(Self, Text, FPendingAttachments);

  FPendingAttachments.Clear;
  RefreshAttachmentsBar;
  Clear;
  FMemo.SetFocus;
end;

function TzChatInputPanel.CurrentText: string;
begin
  Result := FMemo.Text;
end;

procedure TzChatInputPanel.Clear;
begin
  FMemo.Text := '';
end;

function TzChatInputPanel.GetCurrentModel: string;
begin
  Result := FModelCombo.Text;
end;

procedure TzChatInputPanel.SetModels(const Value: TStrings);
begin
  FModelCombo.Properties.Items.Assign(Value);
  if (FModelCombo.Properties.Items.Count > 0)
    and (FModelCombo.ItemIndex < 0) then
    FModelCombo.ItemIndex := 0;
end;

function TzChatInputPanel.GetModels: TStrings;
begin
  Result := FModelCombo.Properties.Items;
end;

end.
