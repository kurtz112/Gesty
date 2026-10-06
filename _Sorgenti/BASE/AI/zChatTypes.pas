// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-13
// ---------------------------------------------------------------------------

unit zChatTypes;

{ Tipi base del componente TzChat.
  Architettura modellata sui componenti chat DevExpress (DevExtreme dxChat /
  WinForms AIChatControl):
    - TzChatUser        ~ dxChat User    (id, nome, avatar)
    - TzChatMessage     ~ dxChat Message (autore, timestamp, testo)
    - il lato locale/remoto di una bolla NON e' una proprieta' del
      partecipante: deriva dal confronto autore = utente corrente del
      controllo (come in dxChat, message.author.id = chat.user.id).
  Convenzioni: identificatori inglesi, commenti italiani, gerarchia a
  oggetti tipizzata (niente closure per measure/draw). }

interface

uses
  System.SysUtils, System.Classes, System.Types,
  Vcl.Graphics, cxGraphics, dxGDIPlusClasses;

type
  TzChatMessageStatus = (msSent, msDelivered, msRead, msError);

  { Colori della chat, ricavati dalla skin attiva.

    Nasce da un difetto: i colori erano scritti nel codice (bolla bianca,
    testo nero, sfondo clWindow). Un colore di sistema come clWindow NON
    segue le skin DevExpress, che dipingono per conto proprio senza toccare
    i colori di Windows: con una skin scura la chat restava un rettangolo
    bianco in mezzo a un programma nero.

    La tavolozza si chiede al pittore della skin ATTIVA nel momento in cui
    serve, non una volta per tutte alla costruzione: e' l'unico modo perche'
    un cambio di skin in esecuzione si veda. }
  TzChatPalette = record
    Sfondo: TColor;        // fondo del pannello, dietro le bolle
    BollaPropria: TColor;  // bolla dei messaggi dell'utente corrente
    BollaAltrui: TColor;   // bolla degli altri partecipanti
    TestoProprio: TColor;
    TestoAltrui: TColor;
    Orario: TColor;        // l'ora sotto al testo, in tono minore
    Selezione: TColor;
    Bordo: TColor;         // separatori e riquadri
    SfondoCodice: TColor;  // sfondo per blocchi di codice
    BordoCodice: TColor;   // bordo per blocchi di codice
    SfondoErrore: TColor;  // sfondo per messaggi di errore
    BordoErrore: TColor;   // bordo per messaggi di errore
    TestoErrore: TColor;   // testo dei messaggi di errore
    class function Corrente: TzChatPalette; static;
  end;

  { Un allegato di un messaggio. Se e' un'immagine, Preview contiene
    la thumbnail caricata; altrimenti resta vuota e si mostra nome+icona. }
  TzChatAttachment = class(TCollectionItem)
  private
    FFilePath: string;
    FFileName: string;
    FIsImage: Boolean;
    FPreview: TdxSmartImage;
    procedure SetFilePath(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property Preview: TdxSmartImage read FPreview;
  published
    { Impostare FilePath carica nome, tipo e (se immagine) l'anteprima. }
    property FilePath: string read FFilePath write SetFilePath;
    property FileName: string read FFileName;
    property IsImage: Boolean read FIsImage;
  end;

  TzChatAttachmentList = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TzChatAttachment;
  public
    function Add(const AFilePath: string): TzChatAttachment;
    property Items[Index: Integer]: TzChatAttachment read GetItem; default;
  end;

  { Partecipante alla conversazione (equivalente dello User di dxChat).
    Color = clNone lascia al renderer la palette predefinita. }
  TzChatUser = class(TCollectionItem)
  private
    FId: string;
    FName: string;
    FAvatar: TdxSmartImage;
    FColor: TColor;
    procedure SetAvatar(const Value: TdxSmartImage);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Id: string read FId write FId;
    property Name: string read FName write FName;
    property Avatar: TdxSmartImage read FAvatar write SetAvatar;
    property Color: TColor read FColor write FColor default clNone;
  end;

  TzChatUsers = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TzChatUser;
  public
    function Add(const AId, AName: string;
      AColor: TColor = clNone): TzChatUser;
    function FindById(const AId: string): TzChatUser;
    property Items[Index: Integer]: TzChatUser read GetItem; default;
  end;

  TzChatMessage = class;

  { Contratto di misura/disegno di una singola bolla.
    IsOwn indica se il messaggio appartiene all'utente corrente
    (bolla a destra): lo stabilisce il chiamante, non il messaggio. }
  IzChatMessageRenderer = interface
    ['{2F1B6A40-3C9E-4D77-9A21-5E0C4B8A9C11}']
    procedure DrawBubble(Canvas: TcxCanvas; const BubbleRect: TRect;
      Item: TzChatMessage; IsOwn: Boolean);
    function MeasureBubble(Canvas: TcxCanvas; MaxWidth: Integer;
      Item: TzChatMessage): TSize;
  end;

  { Messaggio della conversazione (equivalente del Message di dxChat:
    author + timestamp + text, piu' stato e allegati). }
  TzChatMessage = class(TCollectionItem)
  private
    FText: string;
    FAuthor: TzChatUser;
    FTimestamp: TDateTime;
    FStatus: TzChatMessageStatus;
    FRenderer: IzChatMessageRenderer;
    FCachedHeight: Integer;   // -1 = da ricalcolare
    FAttachments: TzChatAttachmentList;
    procedure SetText(const Value: string);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure InvalidateMeasure;
    property Renderer: IzChatMessageRenderer read FRenderer write FRenderer;
    property CachedHeight: Integer read FCachedHeight write FCachedHeight;
  published
    property Text: string read FText write SetText;
    property Author: TzChatUser read FAuthor write FAuthor;
    property Timestamp: TDateTime read FTimestamp write FTimestamp;
    property Status: TzChatMessageStatus
      read FStatus write FStatus default msSent;
    property Attachments: TzChatAttachmentList read FAttachments;
  end;

  TzChatMessageCollection = class(TOwnedCollection)
  private
    function GetItem(Index: Integer): TzChatMessage;
    procedure SetItem(Index: Integer; const Value: TzChatMessage);
  public
    function Add: TzChatMessage;
    procedure InvalidateMeasures;
    property Items[Index: Integer]: TzChatMessage
      read GetItem write SetItem; default;
  end;

{ Mescola due colori: Percent e' la quota del primo. Serve alle tinte
  intermedie (bolla propria, orario, evidenziazione della selezione), che
  devono restare leggibili su qualunque skin. }
function zChatBlendColors(Foreground, Background: TColor; Percent: Byte): TColor;

{ Colore nella forma '#rrggbb': serve alle icone SVG, che il colore se lo
  portano scritto dentro. }
function zChatColorToHtml(AColor: TColor): string;

implementation

uses
  Winapi.Windows,
  cxLookAndFeels,
  cxLookAndFeelPainters;

const
  IMAGE_EXTENSIONS = '.png.jpg.jpeg.gif.bmp.webp';

  // quote di mescolamento, in percentuale
  TINTA_BOLLA_PROPRIA = 22;   // selezione stemperata sul fondo della bolla
  TINTA_ORARIO = 55;          // testo attenuato
  TINTA_BORDO = 30;

function zChatBlendColors(Foreground, Background: TColor; Percent: Byte): TColor;
var
  ForeRGB, BackRGB: Longint;
begin
  ForeRGB := ColorToRGB(Foreground);
  BackRGB := ColorToRGB(Background);
  Result := RGB(
    (GetRValue(ForeRGB) * Percent + GetRValue(BackRGB) * (100 - Percent)) div 100,
    (GetGValue(ForeRGB) * Percent + GetGValue(BackRGB) * (100 - Percent)) div 100,
    (GetBValue(ForeRGB) * Percent + GetBValue(BackRGB) * (100 - Percent)) div 100);
end;

function zChatColorToHtml(AColor: TColor): string;
var
  Valore: Longint;
begin
  Valore := ColorToRGB(AColor);
  Result := Format('#%.2x%.2x%.2x',
    [GetRValue(Valore), GetGValue(Valore), GetBValue(Valore)]);
end;

{ TzChatPalette }

class function TzChatPalette.Corrente: TzChatPalette;
var
  Painter: TcxCustomLookAndFeelPainter;
begin
  { Il pittore della skin attiva adesso. Non si fa una copia dei colori da
    qualche parte: la si richiede a ogni cambio di skin. }
  Painter := RootLookAndFeel.Painter;

  { La bolla altrui e' un'area di contenuto (come lo sfondo di un editor),
    il fondo del pannello e' un'area di controllo: sono due gradini diversi
    in tutte le skin, ed e' quel salto che stacca le bolle dal fondo. }
  Result.BollaAltrui := Painter.DefaultEditorBackgroundColor(False);
  Result.TestoAltrui := Painter.DefaultEditorTextColor(False);
  Result.TestoProprio := Result.TestoAltrui;
  Result.Sfondo := Painter.DefaultControlColor;
  Result.Selezione := Painter.DefaultSelectionColor;

  { La bolla dell'utente corrente non ha un colore proprio nelle skin: si
    ricava dalla selezione, stemperata sul fondo della bolla. Cosi' resta
    riconoscibile e leggibile sia in chiaro sia in scuro. }
  Result.BollaPropria := zChatBlendColors(Result.Selezione, Result.BollaAltrui, TINTA_BOLLA_PROPRIA);
  Result.Orario := zChatBlendColors(Result.TestoAltrui, Result.BollaAltrui, TINTA_ORARIO);
  Result.Bordo := zChatBlendColors(Result.TestoAltrui, Result.Sfondo, TINTA_BORDO);

  { Colori per codice ed errori, derivati in modo armonico dalla skin }
  Result.SfondoCodice := zChatBlendColors(Result.Sfondo, Result.BollaAltrui, 45);
  Result.BordoCodice := Result.Bordo;
  Result.SfondoErrore := zChatBlendColors(clRed, Result.BollaAltrui, 12);
  Result.BordoErrore := zChatBlendColors(clRed, Result.BollaAltrui, 45);

  { Il testo dell'errore parte dal rosso ma resta leggibile sul fondo che ha
    davvero, che su skin scura e' scuro: un clWebFirebrick fisso li' sopra
    non si legge. Si mescola col colore del testo normale, che la skin ha gia'
    scelto in contrasto col fondo. }
  Result.TestoErrore := zChatBlendColors(clRed, Result.TestoAltrui, 55);
end;

{ TzChatAttachment }

constructor TzChatAttachment.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FPreview := TdxSmartImage.Create;
end;

destructor TzChatAttachment.Destroy;
begin
  FPreview.Free;
  inherited Destroy;
end;

procedure TzChatAttachment.SetFilePath(const Value: string);
var
  Extension: string;
begin
  FFilePath := Value;
  FFileName := ExtractFileName(Value);
  Extension := LowerCase(ExtractFileExt(Value));
  FIsImage := (Extension <> '') and (Pos(Extension, IMAGE_EXTENSIONS) > 0);
  { Se e' un'immagine, carica l'anteprima; errori di caricamento sono
    tollerati (resta un'anteprima vuota, si mostra nome+icona). }
  if FIsImage and FileExists(Value) then
    try
      FPreview.LoadFromFile(Value);
    except
      FIsImage := False;
    end;
end;

{ TzChatAttachmentList }

function TzChatAttachmentList.Add(const AFilePath: string): TzChatAttachment;
begin
  Result := TzChatAttachment(inherited Add);
  Result.FilePath := AFilePath;
end;

function TzChatAttachmentList.GetItem(Index: Integer): TzChatAttachment;
begin
  Result := TzChatAttachment(inherited Items[Index]);
end;

{ TzChatUser }

constructor TzChatUser.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FAvatar := TdxSmartImage.Create;
  FColor := clNone;
end;

destructor TzChatUser.Destroy;
begin
  FAvatar.Free;
  inherited Destroy;
end;

procedure TzChatUser.SetAvatar(const Value: TdxSmartImage);
begin
  FAvatar.Assign(Value);
end;

procedure TzChatUser.Assign(Source: TPersistent);
begin
  if Source is TzChatUser then
  begin
    FId := TzChatUser(Source).FId;
    FName := TzChatUser(Source).FName;
    FColor := TzChatUser(Source).FColor;
    FAvatar.Assign(TzChatUser(Source).FAvatar);
  end
  else
    inherited Assign(Source);
end;

{ TzChatUsers }

function TzChatUsers.GetItem(Index: Integer): TzChatUser;
begin
  Result := TzChatUser(inherited Items[Index]);
end;

function TzChatUsers.Add(const AId, AName: string;
  AColor: TColor): TzChatUser;
begin
  Result := TzChatUser(inherited Add);
  Result.Id := AId;
  Result.Name := AName;
  Result.Color := AColor;
end;

function TzChatUsers.FindById(const AId: string): TzChatUser;
var
  Index: Integer;
begin
  for Index := 0 to Count - 1 do
    if SameText(Items[Index].Id, AId) then
      Exit(Items[Index]);
  Result := nil;
end;

{ TzChatMessage }

constructor TzChatMessage.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FStatus := msSent;
  FTimestamp := Now;
  FCachedHeight := -1;
  FAttachments := TzChatAttachmentList.Create(Self, TzChatAttachment);
end;

destructor TzChatMessage.Destroy;
begin
  FAttachments.Free;
  inherited Destroy;
end;

procedure TzChatMessage.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    InvalidateMeasure;
  end;
end;

procedure TzChatMessage.InvalidateMeasure;
begin
  FCachedHeight := -1;
end;

procedure TzChatMessage.Assign(Source: TPersistent);
begin
  if Source is TzChatMessage then
  begin
    FText := TzChatMessage(Source).FText;
    FAuthor := TzChatMessage(Source).FAuthor;
    FTimestamp := TzChatMessage(Source).FTimestamp;
    FStatus := TzChatMessage(Source).FStatus;
    FRenderer := TzChatMessage(Source).FRenderer;
    InvalidateMeasure;
  end
  else
    inherited Assign(Source);
end;

{ TzChatMessageCollection }

function TzChatMessageCollection.Add: TzChatMessage;
begin
  Result := TzChatMessage(inherited Add);
end;

function TzChatMessageCollection.GetItem(Index: Integer): TzChatMessage;
begin
  Result := TzChatMessage(inherited Items[Index]);
end;

procedure TzChatMessageCollection.SetItem(Index: Integer;
  const Value: TzChatMessage);
begin
  inherited Items[Index] := Value;
end;

procedure TzChatMessageCollection.InvalidateMeasures;
var
  Index: Integer;
begin
  for Index := 0 to Count - 1 do
    Items[Index].InvalidateMeasure;
end;

end.
