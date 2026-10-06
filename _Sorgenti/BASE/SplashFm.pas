unit SplashFm;

interface

uses
  Windows,
  Sysutils,
  Forms,
  Classes,
  Controls,
  StdCtrls,
  ExtCtrls,
  Graphics,
  ComCtrls,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxSVGImage,
  cxImage,
  dxGDIPlusClasses,
  dxSplashForms,
  zSystem;

type
  // Form della vecchia schermata di avvio: non viene piu' creata. Resta qui,
  // con il suo .dfm, solo perche' Gesty.dpr la elenca ancora fra le form del
  // progetto (riga 44, "SplashFm in 'BASE\SplashFm.PAS' {Splash}"). Togliendo
  // la classe l'IDE segnalerebbe una form mancante all'apertura del progetto.
  TSplash = class(TForm, IdxSkinSupport2)
    Image: TImage;
  private
    function IsSkinnable: Boolean;
  public
    Constructor Create(aOwner: TComponent); override;
  end;

// Mostra la schermata di avvio di DevExpress, quella definita in
// Gesty_dxSplashResource.res. La prima chiamata e' nel .dpr, subito dopo
// Application.Initialize; le altre sono quelle attorno alla finestra di
// accesso. Chiamarla quando la schermata e' gia' a video non fa danni.
procedure ShowSplash;

// Nasconde la schermata. Il nome resta quello storico perche' MainForm la
// chiama a fine inizializzazione, ma qui non si distrugge niente: la stessa
// schermata puo' tornare a video con ShowSplash.
procedure CloseSplash;

// Cambia la riga di stato della schermata, se e' a video. Se la voce "Stato"
// non esiste piu' nella definizione, non fa niente.
procedure StatoSplash(const Messaggio: string);

// Segna su quale monitor sta la finestra principale, perche' il prossimo
// avvio ci metta la schermata. La chiama MainForm quando si chiude: e'
// l'unica informazione che sopravvive alla chiusura, e al prossimo avvio non
// c'e' ancora nessuna finestra a cui chiederlo.
procedure RicordaPosizioneDiLavoro(AForm: TCustomForm);

implementation

uses
  IniFiles;

{$R *.DFM}

const
  // Stessa sezione (nome del computer) e stesso file .login in cui zPack
  // tiene utente, connessione e skin dell'ultima sessione: la posizione e'
  // per postazione come lo skin, e il file viene gia' letto a quest'ora.
  VocePosizioneDiLavoro = 'SchermoDiLavoro';

function FileUltimaSessione: string;
begin
  result := ChangeFileExt(Application.ExeName, zExtension_LastUserAndConnections);
end;

procedure RicordaPosizioneDiLavoro(AForm: TCustomForm);
var
  Ini: TIniFile;
begin
  if not assigned(AForm) then
    Exit;

  // Ridotta a icona Left e Top valgono -32000: non dicono niente.
  if AForm.WindowState = wsMinimized then
    Exit;

  Ini := TIniFile.Create(FileUltimaSessione);
  try
    // Il centro, non l'angolo: una finestra massimizzata ha l'angolo sul
    // bordo del monitor, e con i monitor affiancati il bordo appartiene gia'
    // a quello accanto.
    Ini.WriteString(ComputerName, VocePosizioneDiLavoro,
      Format('%d,%d', [AForm.Left + AForm.Width div 2, AForm.Top + AForm.Height div 2]));
  finally
    FreeAndNil(Ini);
  end;
end;

// Monitor dell'ultima sessione, se e' stato segnato e se quel punto esiste
// ancora: un monitor staccato fa cadere il punto nel vuoto, e allora non si
// usa. Nil se non si sa.
function MonitorDellaVoltaScorsa: TMonitor;
var
  Ini: TIniFile;
  Salvato: string;
  Pezzi: TArray<string>;
  Punto: TPoint;
begin
  result := nil;

  Ini := TIniFile.Create(FileUltimaSessione);
  try
    Salvato := Ini.ReadString(ComputerName, VocePosizioneDiLavoro, '');
  finally
    FreeAndNil(Ini);
  end;

  Pezzi := Salvato.Split([',']);
  if Length(Pezzi) < 2 then
    Exit;

  Punto.X := StrToIntDef(Pezzi[0], MaxInt);
  Punto.Y := StrToIntDef(Pezzi[1], MaxInt);
  if (Punto.X = MaxInt) or (Punto.Y = MaxInt) then
    Exit;

  // mdNull: se il punto non cade su nessun monitor si torna nil, senza
  // ripiegare sul piu' vicino, che potrebbe essere sbagliato.
  result := Screen.MonitorFromPoint(Punto, mdNull);
end;

// Monitor su cui sta davvero lavorando l'utente, nell'ordine:
//
// 1. dove stava la finestra principale l'ultima volta (file .login);
// 2. la finestra principale, se esiste gia' (le comparse dopo l'accesso);
// 3. la finestra attiva;
// 4. il puntatore del mouse;
// 5. il monitor primario.
//
// Al primo avvio non esiste nessuna finestra: la libreria DevExpress centra la
// schermata sul monitor di GetForegroundWindow, che a quel punto e' la shell,
// e con handle zero la VCL ricade sul primario. Il puntatore del mouse non
// aiuta: chi lancia il programma da un'icona sul primo schermo e poi lavora
// sul quarto ha il mouse sul primo. L'unica risposta giusta e' quella
// ricordata dalla sessione precedente.
function MonitorDiLavoro: TMonitor;
begin
  result := MonitorDellaVoltaScorsa;

  if not assigned(result) and assigned(Application.MainForm) and Application.MainForm.HandleAllocated then
    result := Screen.MonitorFromWindow(Application.MainForm.Handle);

  if not assigned(result) and assigned(Screen.ActiveCustomForm) and Screen.ActiveCustomForm.HandleAllocated then
    result := Screen.MonitorFromWindow(Screen.ActiveCustomForm.Handle);

  if not assigned(result) then
    result := Screen.MonitorFromPoint(Mouse.CursorPos);

  if not assigned(result) then
    result := Screen.PrimaryMonitor;
end;

function TrovaTesto(Splash: TdxSplashFormBase; const Nome: string): TdxSplashFormBase.TText;
var
  Indice: Integer;
  Voce: TdxSplashFormBase.TContentItem;
begin
  result := nil;

  for Indice := 0 to Splash.Content.Items.Count - 1 do
  begin
    Voce := Splash.Content.Items[Indice];

    if SameText(Voce.Name, Nome) and (Voce is TdxSplashFormBase.TText) then
      Exit(TdxSplashFormBase.TText(Voce));
  end;
end;

var
  SkinAnticipato: boolean = false;

// Applica lo skin dell'ultima sessione. Serve per due motivi, tutti e due
// legati al momento in cui la schermata compare:
//
// 1. zPack carica lo skin dentro TzSecurity.LoadLastUserAndConnection, cioe'
//    quando si apre la finestra di accesso: molto dopo.
// 2. Gesty.dxSettings.pas, dentro InitProc, chiama LoadAppearance, che mette
//    UseSkins a False e SkinName a stringa vuota. Uno skin caricato prima -
//    per esempio da una sezione initialization - verrebbe azzerato proprio un
//    attimo prima che la schermata compaia.
//
// Da qui la regola: si chiama dal .dpr, dopo Application.Initialize, e non da
// una sezione initialization. Agisce una volta sola.
procedure AnticipaSkin;
begin
  if SkinAnticipato then
    Exit;

  SkinAnticipato := true;

  TzSecurity.LoadSkinFromIni;
end;

// Monitor scelto alla prima comparsa e poi mantenuto: la schermata non deve
// saltare da un monitor all'altro fra una comparsa e l'altra dello stesso
// avvio.
var
  MonitorScelto: TMonitor = nil;

procedure PosizionaSplash;
var
  Splash: TdxSplashFormBase;
  Centro: TPoint;
begin
  Splash := TdxSplashFormManager.SplashForm;

  if not(Splash is TdxSplashForm) then
    Exit;

  if not assigned(MonitorScelto) then
    MonitorScelto := MonitorDiLavoro;

  // La posizione non e' salvata nella definizione: TdxSplashForm.LoadFromXml
  // legge solo FadeIn e FadeOut, quindi Position resta sul valore predefinito,
  // che centra la schermata sul monitor della finestra in primo piano. Alla
  // seconda comparsa - quella dopo la finestra di accesso - in primo piano puo'
  // esserci un'altra applicazione, e la schermata salta sul suo monitor. Con
  // Custom la posizione la decidiamo qui, e resta la stessa per tutto l'avvio.
  TdxSplashForm(Splash).Position := TdxSplashFormPosition.Custom;

  Centro := MonitorScelto.WorkareaRect.CenterPoint;

  // Le dimensioni si leggono dal contenuto: Splash.Width e Splash.Height sono
  // ancora zero finche' la schermata non e' comparsa almeno una volta.
  Splash.Left := Centro.X - Splash.Content.Width div 2;
  Splash.Top := Centro.Y - Splash.Content.Height div 2;
end;

procedure ShowSplash;
begin
  // L'ordine conta: fondo e testi sono lasciati sul valore Default della
  // definizione, quindi li decide il painter attivo nel momento in cui la
  // definizione viene caricata. PosizionaSplash e' gia' un accesso alla
  // definizione, quindi lo skin va applicato prima.
  AnticipaSkin;
  PosizionaSplash;

  TdxSplashFormManager.SplashForm.Show;
end;

procedure CloseSplash;
begin
  TdxSplashFormManager.SplashForm.Hide;
end;

procedure StatoSplash(const Messaggio: string);
var
  Splash: TdxSplashFormBase;
  Riga: TdxSplashFormBase.TText;
begin
  Splash := TdxSplashFormManager.SplashForm;

  if not Splash.Visible then
    Exit;

  Riga := TrovaTesto(Splash, 'Stato');

  if not assigned(Riga) then
    Exit;

  Splash.BeginUpdate;
  try
    Riga.Text := Messaggio;
  finally
    Splash.EndUpdate;
  end;
end;

{ TSplash }

constructor TSplash.Create(aOwner: TComponent);
var
  Painter: TcxCustomLookAndFeelPainter;
begin
  inherited;
  begin

    Painter := RootLookAndFeel.SkinPainter;

    if not assigned(Painter) then
      Painter := RootLookAndFeel.Painter;

    Color := Painter.DefaultControlColor;
    TransparentColorValue := Color; // Painter.DefaultControlColor;
  end;
end;

function TSplash.IsSkinnable: Boolean;
begin
  result := false;
end;

end.
