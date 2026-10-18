// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-16
// ---------------------------------------------------------------------------
unit GestyTools.Sql.Pagina;

// Interfaccia della pagina Aggiornamento DB di GestyTools, portata da
// zFbScript (zFbScript.Scheda e zFbScript.Principale): le stesse regole di
// esecuzione di GestyTools.Sql.Esecutore, con gli strumenti per leggere cosa
// e' successo senza dover rileggere il registro riga per riga.
//
//   +---------------------------------------------+
//   | barra comandi: Apri, Salva, Esegui, ...     |
//   | opzioni: prosegui, solo prova, conferma DDL |
//   | fascia del file: script >> database         |
//   | editor SQL di zPack (Frame_Editor_SQL)      |
//   +=============== divisore ====================+
//   | fascia d'esito: in corso, completato, fermato|
//   | [Messaggi] [Riga 12 (3)] [Riga 20 (1)] ...  |
//   |  griglia dei messaggi / zGrid per le SELECT |
//   +---------------------------------------------+
//
// I controlli nascono da codice e non dal .dfm di MainFrm: un frame zPack
// messo inline in un .dfm l'IDE lo riappiattisce, e le modifiche a mano al
// .dfm di una form di quelle dimensioni sono fragili.
//
// Icone: PNG della libreria DevExpress (GestyTools.Sql.Icone), non SVG.
//
// Cosa cambia rispetto al registro testuale di prima:
//  - esecuzione di una selezione (come in zFbScript) oltre che dello script
//    intero;
//  - opzioni "Prosegui dopo un errore", "Solo prova" e "Conferma dopo ogni
//    DDL", che l'esecutore gia' supportava ma l'interfaccia non esponeva;
//  - interruzione prima dell'istruzione successiva (Ctrl+F2);
//  - messaggi in una griglia con colori per errori e avvisi, doppio clic per
//    andare alla riga dell'editor;
//  - risultati delle SELECT in una griglia ciascuno (esportabile in Excel,
//    CSV, HTML);
//  - Copia errori negli appunti, con script, database ed esito in testa;
//  - Apri, Salva e Salva con nome, e lettura dei file in qualunque
//    codifica (UTF-8, UTF-16, Windows-1252).
//
// Le scorciatoie dell'editor stanno nell'ActionList del frame e la form le
// cerca in tutte le ActionList dei frame che contiene, anche in una pagina
// nascosta: F9 premuto su un'altra pagina del wizard farebbe eseguire lo
// script. Per questo Esegui controlla che la pagina sia visibile.
//
// Metadati: l'editor riceve una raccolta vuota tutta sua. Senza, il
// completamento automatico dopo "NOME." va in access violation, perche' il
// frame cerca la tabella senza controllare che la raccolta esista.

interface

uses
  System.SysUtils,
  System.Classes,
  System.Actions,
  System.Generics.Collections,
  Vcl.Controls,
  Vcl.Graphics,
  Vcl.ExtCtrls,
  Vcl.ActnList,
  Vcl.Dialogs,
  Data.DB,
  FireDAC.Comp.Client,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxClasses,
  cxImageList,
  cxPC,
  cxSplitter,
  cxGrid,
  cxGridTableView,
  cxGridCustomTableView,
  cxGridCustomView,
  cxStyles,
  cxLabel,
  cxBarEditItem,
  cxCheckBox,
  dxBar,
  dxBarExtItems,
  SynFunc,
  Frame_Editor_SQL,
  zMetadata,
  zGrid,
  GestyTools.Sql.Icone,
  GestyTools.Sql.Esecutore;

type
  TRisultatoPagina = class
  public
    Foglio: TcxTabSheet;
    Griglia: TzGrid;
    Dati: TFDMemTable;
    destructor Destroy; override;
  end;

  TPaginaSql = class(TComponent)
  private
    FContenitore: TWinControl;
    FEditor: TFrameEditor_Sql;
    FEsecutore: TEsecutore;
    FMetadatiVuoti: TzMetadata;
    FNomeFile: string;
    FDatabase: string;
    FCartellaPredefinita: string;
    FRigheMassime: Integer;
    FRigaErrore: Integer;
    FInEsecuzione: Boolean;
    FDescrizioneEsecuzione: string;
    // testo e colore della fascia d'esito dell'ultima esecuzione: la fascia
    // puo' mostrare per un momento altro (Copia errori), ma la copia negli
    // appunti riporta sempre l'esito vero
    FTestoEsito: string;
    FColoreEsito: TColor;

    // barra comandi
    FIcone: TcxImageList;
    FAzioni: TActionList;
    FManager: TdxBarManager;
    FDock: TdxBarDockControl;
    FBarraComandi: TdxBar;
    FBarraOpzioni: TdxBar;
    actApri: TAction;
    actSalva: TAction;
    actSalvaCome: TAction;
    actEsegui: TAction;
    actInterrompi: TAction;
    actCopiaErrori: TAction;
    chkContinua: TcxBarEditItem;
    chkProva: TcxBarEditItem;
    chkAutoDdl: TcxBarEditItem;
    FDialogoApri: TOpenDialog;
    FDialogoSalva: TSaveDialog;
    FFasciaScript: TcxLabel;

    // parte bassa
    FParteBassa: TPanel;
    FDivisore: TcxSplitter;
    FFasciaEsito: TcxLabel;
    FPagine: TcxPageControl;
    FFoglioMessaggi: TcxTabSheet;
    FGrigliaMessaggi: TcxGrid;
    FVistaMessaggi: TcxGridTableView;
    FColonnaRiga: TcxGridColumn;
    FColonnaTipo: TcxGridColumn;
    FColonnaTesto: TcxGridColumn;
    FColonnaFile: TcxGridColumn;
    FStili: TcxStyleRepository;
    FStileErrore: TcxStyle;
    FStileAvviso: TcxStyle;
    FStileRiepilogo: TcxStyle;
    FRisultati: TObjectList<TRisultatoPagina>;

    procedure CreaBarraComandi;
    procedure CreaParteBassa;
    function NuovaAzione(const Didascalia, Suggerimento: string; Icona: TIconaSql; Evento: TNotifyEvent; Scorciatoia: TShortCut = 0): TAction;
    function AggiungiPulsante(Barra: TdxBar; Azione: TAction; Icona: TIconaSql; IniziaGruppo: Boolean): TdxBarLargeButton;
    function NuovaOpzione(Barra: TdxBar; const Didascalia, Suggerimento: string; Valore: Boolean): TcxBarEditItem;
    function Opzione(Voce: TcxBarEditItem): Boolean;

    procedure AzioneApri(Sender: TObject);
    procedure AzioneSalva(Sender: TObject);
    procedure AzioneSalvaCome(Sender: TObject);
    procedure AzioneEsegui(Sender: TObject);
    procedure AzioneInterrompi(Sender: TObject);
    procedure AzioneCopiaErrori(Sender: TObject);
    procedure AzioniAggiorna(Action: TBasicAction; var Handled: Boolean);
    procedure OpzioneCambiata(Sender: TObject);
    procedure EditorCambiato(Sender: TObject);
    procedure ColoraRiga(Sender: TObject; Line: TSynNativeInt; var Special: Boolean; var FG, BG: TColor);
    procedure StileMessaggio(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure MessaggioDoppioClic(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);

    procedure EsecutoreMessaggio(Sender: TObject; Tipo: TTipoMessaggio; const NomeFile: string; Riga: Integer; const Testo: string);
    procedure EsecutoreRisultato(Sender: TObject; const NomeFile: string; Riga: Integer; const TestoIstruzione: string; DataSet: TDataSet;
      Tagliato: Boolean; Millisecondi: Int64);
    procedure EsecutoreAvanzamento(Sender: TObject);

    function PaginaVisibile: Boolean;
    function GetModificato: Boolean;
    function SalvaScript(ChiediNome: Boolean): Boolean;
    function TestoDaEseguire(out RigaIniziale: Integer; out SoloSelezione: Boolean): string;
    procedure AggiornaIntestazione;
    procedure Fascia(const Testo: string; Colore: TColor);
    procedure PreparaEsecuzione(const Descrizione: string);
    procedure MostraEsito(const Esito: TEsitoEsecuzione; Prova: Boolean);
    procedure MostraFallimento(const Motivo: string);
    procedure AggiungiMessaggio(Tipo: TTipoMessaggio; const NomeFile: string; Riga: Integer; const Testo: string);
    procedure AggiungiRisultato(Riga: Integer; const TestoIstruzione: string; DataSet: TDataSet; Tagliato: Boolean);
    procedure VaiARiga(Riga: Integer);
    function HaMessaggi: Boolean;
    function TestoPerCopia(out Numero: Integer): string;
    procedure EsitoFinale(const Esito: TEsitoEsecuzione; Prova: Boolean);
  public
    // Contenitore e' la pagina del wizard che ospita tutto; Editor e' il
    // frame gia' presente nella pagina, che diventa la parte alta.
    constructor Create(aOwner: TComponent; Contenitore: TWinControl; Editor: TFrameEditor_Sql; Esecutore: TEsecutore); reintroduce;
    destructor Destroy; override;

    // Il testo dell'editor e' vuoto
    function Vuota: Boolean;
    // Carica un file nell'editor. Con ConPreavviso, se il testo attuale e'
    // stato modificato e non salvato chiede se sostituirlo; False se l'utente
    // rinuncia.
    function Carica(const NomeFile: string; ConPreavviso: Boolean): Boolean;

    property InEsecuzione: Boolean read FInEsecuzione;
    property Modificato: Boolean read GetModificato;
    property NomeFile: string read FNomeFile;
    // Il database su cui gira lo script, per la fascia sopra l'editor
    property Database: string read FDatabase write FDatabase;
    // Da dove si risolvono gli INPUT di un testo mai salvato e dove si
    // aprono i file
    property CartellaPredefinita: string read FCartellaPredefinita write FCartellaPredefinita;
    // Righe lette per ogni SELECT; 0 = tutte
    property RigheMassime: Integer read FRigheMassime write FRigheMassime;
  end;

implementation

uses
  Winapi.Windows,
  System.IOUtils,
  System.StrUtils,
  System.Variants,
  Vcl.Clipbrd,
  Vcl.Forms,
  Vcl.Menus,
  FireDAC.Comp.DataSet,
  cxCustomData,
  cxDataStorage,
  zMsg;

const
  // fascia d'esito, sempre con testo bianco ($00BBGGRR)
  ColoreFasciaNeutra = $00606060;
  ColoreFasciaInCorso = $00A06A3C;
  ColoreFasciaRiuscito = $00309030;
  ColoreFasciaErrore = $002020C0;
  ColoreFasciaAvviso = $000070D0;
  ColoreFasciaProva = $00BF3F7B;

  // nella griglia dei messaggi
  IndiceRiga = 0;
  IndiceTipo = 1;
  IndiceTesto = 2;
  IndiceFile = 3;

  NomiTipo: array [TTipoMessaggio] of string = ('', 'esito', 'avviso', 'ERRORE', 'fine');

  FiltroScript = 'Script SQL (*.sql)|*.sql|Tutti i file (*.*)|*.*';

function Conteggio(Numero: Integer; const Singolare, Plurale: string): string;
begin
  if Numero = 1 then
    Result := '1 ' + Singolare
  else
    Result := Format('%d %s', [Numero, Plurale]);
end;

{ TRisultatoPagina }

destructor TRisultatoPagina.Destroy;
begin
  // prima la griglia, che guarda i dati
  if Assigned(Griglia) then
    Griglia.Detach;

  Foglio.Free;
  Dati.Free;

  inherited;
end;

{ TPaginaSql }

constructor TPaginaSql.Create(aOwner: TComponent; Contenitore: TWinControl; Editor: TFrameEditor_Sql; Esecutore: TEsecutore);
begin
  inherited Create(aOwner);

  FContenitore := Contenitore;
  FEditor := Editor;
  FEsecutore := Esecutore;
  FRigheMassime := 100;
  FRisultati := TObjectList<TRisultatoPagina>.Create(True);

  // creata prima dell'editor che la usa, cosi' la pagina la libera dopo di
  // lui: il frame la guarda ma non la possiede
  FMetadatiVuoti := TzMetadata.Create(Self);
  FEditor.Metadata := FMetadatiVuoti;
  FEditor.OnChange := EditorCambiato;
  FEditor.OnExecute := AzioneEsegui;
  FEditor.Editor.OnSpecialLineColors := ColoraRiga;

  // Aprire e salvare li fa la pagina, che sa a quale file corrisponde il
  // testo: quelli del frame caricherebbero un file nell'editor lasciando il
  // nome di prima. Via anche la barra del frame, che li ripeteva (restano
  // nel menu contestuale con le altre voci di modifica)
  FEditor.CaricaDalFile.ShortCut := 0;
  FEditor.SalvaSuFile.ShortCut := 0;
  FEditor.CaricadaFile1.Visible := ivNever;
  FEditor.SalvasuFile1.Visible := ivNever;
  FEditor.dxBarManagerBar1.Visible := False;

  FDialogoApri := TOpenDialog.Create(Self);
  FDialogoApri.Filter := FiltroScript;
  FDialogoApri.Options := FDialogoApri.Options + [ofFileMustExist, ofPathMustExist];
  FDialogoSalva := TSaveDialog.Create(Self);
  FDialogoSalva.Filter := FiltroScript;
  FDialogoSalva.DefaultExt := 'sql';
  FDialogoSalva.Options := FDialogoSalva.Options + [ofOverwritePrompt];

  CreaParteBassa;
  CreaBarraComandi;
  AggiornaIntestazione;
end;

destructor TPaginaSql.Destroy;
begin
  // i risultati prima di tutto il resto: le loro linguette stanno nella
  // pagina dei risultati, che la pagina distrugge subito dopo. MainForm
  // libera la pagina da FormDestroy, a controlli ancora vivi: lasciata alla
  // distruzione della form, i fogli sparirebbero con i loro contenitori e
  // qui verrebbero liberati una seconda volta
  FreeAndNil(FRisultati);

  inherited;
end;

// ---------------------------------------------------------------------------
// Barra comandi
// ---------------------------------------------------------------------------

function TPaginaSql.NuovaAzione(const Didascalia, Suggerimento: string; Icona: TIconaSql; Evento: TNotifyEvent; Scorciatoia: TShortCut): TAction;
begin
  Result := TAction.Create(Self);
  Result.ActionList := FAzioni;
  Result.Caption := Didascalia;
  Result.Hint := Suggerimento;
  Result.ImageIndex := Ord(Icona);
  Result.ShortCut := Scorciatoia;
  Result.OnExecute := Evento;
end;

function TPaginaSql.AggiungiPulsante(Barra: TdxBar; Azione: TAction; Icona: TIconaSql; IniziaGruppo: Boolean): TdxBarLargeButton;
var
  Collegamento: TdxBarItemLink;
begin
  Result := TdxBarLargeButton(FManager.AddItem(TdxBarLargeButton));
  Result.Action := Azione;
  Result.LargeImageIndex := Ord(Icona);
  Result.AutoGrayScale := False;

  Collegamento := Barra.ItemLinks.Add;
  Collegamento.Item := Result;
  Collegamento.BeginGroup := IniziaGruppo;
  Collegamento.UserDefine := [udPaintStyle];
  Collegamento.UserPaintStyle := psCaptionGlyph;
end;

function TPaginaSql.NuovaOpzione(Barra: TdxBar; const Didascalia, Suggerimento: string; Valore: Boolean): TcxBarEditItem;
begin
  Result := TcxBarEditItem(FManager.AddItem(TcxBarEditItem));
  Result.PropertiesClass := TcxCheckBoxProperties;
  TcxCheckBoxProperties(Result.Properties).ImmediatePost := True;
  TcxCheckBoxProperties(Result.Properties).NullStyle := nssUnchecked;
  Result.Caption := Didascalia;
  Result.Hint := Suggerimento;
  Result.ShowCaption := True;
  Result.Width := 20;
  Result.EditValue := Valore;
  Result.OnChange := OpzioneCambiata;

  Barra.ItemLinks.Add.Item := Result;
end;

function TPaginaSql.Opzione(Voce: TcxBarEditItem): Boolean;
begin
  Result := not VarIsNull(Voce.EditValue) and not VarIsEmpty(Voce.EditValue) and Boolean(Voce.EditValue);
end;

procedure TPaginaSql.CreaBarraComandi;
var
  Etichetta: TdxBarStatic;
begin
  FIcone := TcxImageList.Create(Self);
  CaricaIconeSql(FIcone);

  FAzioni := TActionList.Create(Self);
  FAzioni.Images := FIcone;
  FAzioni.OnUpdate := AzioniAggiorna;

  actApri := NuovaAzione('Apri script', 'Carica uno script SQL da file nell''editor', isApri, AzioneApri);
  actSalva := NuovaAzione('Salva', 'Salva lo script (UTF-8 con BOM)', isSalva, AzioneSalva);
  actSalvaCome := NuovaAzione('Salva con nome', 'Salva lo script in un altro file', isSalvaConNome, AzioneSalvaCome);
  // F9 e' gia' del frame dell'editor (Esegui nel menu contestuale): qui solo
  // il pulsante, che chiama la stessa routine
  actEsegui := NuovaAzione('Esegui', 'Esegue la selezione se c''e'', altrimenti tutto lo script (F9)', isEsegui, AzioneEsegui);
  actInterrompi := NuovaAzione('Interrompi', 'Ferma lo script prima dell''istruzione successiva e annulla la transazione (Ctrl+F2)', isInterrompi,
    AzioneInterrompi, ShortCut(VK_F2, [ssCtrl]));
  actCopiaErrori := NuovaAzione('Copia errori', 'Copia negli appunti gli errori dell''ultima esecuzione, o tutti i messaggi se non ce ne sono', isCopia,
    AzioneCopiaErrori);

  // TdxBarManager vuole come proprietario un TWinControl: la pagina e' un
  // TComponent, quindi si usa il suo proprietario (la form principale), che
  // ha la stessa durata
  FManager := TdxBarManager.Create(Owner);
  FManager.Categories.Add('Sql');
  FManager.ImageOptions.LargeImages := FIcone;
  FManager.ImageOptions.LargeIcons := True;
  FManager.ImageOptions.UseLargeImagesForLargeIcons := True;
  FManager.CanCustomize := False;
  FManager.AllowReset := False;
  FManager.UseSystemFont := True;
  FManager.NotDocking := [dsNone];

  FDock := TdxBarDockControl.Create(Self);
  FDock.Parent := FContenitore;
  FDock.Align := dalTop;
  FDock.BarManager := FManager;

  // prima riga: comandi
  FBarraComandi := FManager.Bars.Add;
  FBarraComandi.Caption := 'Script SQL';
  FBarraComandi.DockControl := FDock;
  FBarraComandi.UseOwnFont := False;

  AggiungiPulsante(FBarraComandi, actApri, isApri, False);
  AggiungiPulsante(FBarraComandi, actSalva, isSalva, False);
  AggiungiPulsante(FBarraComandi, actSalvaCome, isSalvaConNome, False);
  AggiungiPulsante(FBarraComandi, actEsegui, isEsegui, True);
  AggiungiPulsante(FBarraComandi, actInterrompi, isInterrompi, False);
  AggiungiPulsante(FBarraComandi, actCopiaErrori, isCopia, True);

  // seconda riga: opzioni. Caselle di spunta e non pulsanti, perche' non
  // eseguono niente e valgono per la prossima esecuzione
  FBarraOpzioni := FManager.Bars.Add;
  FBarraOpzioni.Caption := 'Opzioni di esecuzione';
  FBarraOpzioni.DockControl := FDock;
  FBarraOpzioni.UseOwnFont := False;

  Etichetta := TdxBarStatic(FManager.AddItem(TdxBarStatic));
  Etichetta.Caption := 'Opzioni di esecuzione:';
  Etichetta.Hint := 'Valgono per il prossimo Esegui: non eseguono niente da sole';
  FBarraOpzioni.ItemLinks.Add.Item := Etichetta;

  chkContinua := NuovaOpzione(FBarraOpzioni, 'Prosegui dopo un errore',
    'Spenta: al primo errore si annulla tutto e ci si ferma. Accesa: si va avanti, e alla fine si conferma quello che e'' riuscito', False);
  chkProva := NuovaOpzione(FBarraOpzioni, 'Solo prova',
    'Esegue tutto in una transazione e alla fine la annulla: si vedono errori e risultati, ma il database non cambia', False);
  chkAutoDdl := NuovaOpzione(FBarraOpzioni, 'Conferma dopo ogni DDL',
    'AUTODDL, come isql e IBExpert: dopo ogni CREATE, ALTER, DROP riuscito si conferma, cosi'' le istruzioni dopo vedono gli oggetti nuovi', True);

  // Comune a tutte le barre di GestyTools (vedi MainForm.FormCreate)
  FBarraComandi.AllowClose := False;
  FBarraComandi.AllowCustomizing := False;
  FBarraComandi.AllowQuickCustomizing := False;
  FBarraComandi.AllowReset := False;
  FBarraComandi.OneOnRow := True;
  FBarraComandi.ShowMark := False;
  FBarraComandi.UseRestSpace := True;
  FBarraComandi.WholeRow := True;
  FBarraOpzioni.AllowClose := False;
  FBarraOpzioni.AllowCustomizing := False;
  FBarraOpzioni.AllowQuickCustomizing := False;
  FBarraOpzioni.AllowReset := False;
  FBarraOpzioni.OneOnRow := True;
  FBarraOpzioni.ShowMark := False;
  FBarraOpzioni.UseRestSpace := True;
  FBarraOpzioni.WholeRow := True;

  // quale script e' aperto, su quale database, in che stato
  FFasciaScript := TcxLabel.Create(Self);
  FFasciaScript.Parent := FContenitore;
  FFasciaScript.Align := alTop;
  // dopo la barra: l'allineamento in alto segue la posizione
  FFasciaScript.Top := 10000;
  FFasciaScript.AutoSize := False;
  FFasciaScript.Height := MulDiv(28, FContenitore.CurrentPPI, 96);
  FFasciaScript.Properties.Alignment.Vert := taVCenter;
  FFasciaScript.Style.Font.Style := [fsBold];
  FFasciaScript.Transparent := False;
  FFasciaScript.Style.Color := ColoreFasciaNeutra;
  FFasciaScript.Style.TextColor := clWhite;
end;

procedure TPaginaSql.CreaParteBassa;
begin
  // i risultati stanno sotto con un'altezza propria, l'editor prende il
  // resto: con un'altezza fissa dell'editor, su un monitor ad alta
  // risoluzione lo script restava schiacciato in poche righe
  FParteBassa := TPanel.Create(Self);
  FParteBassa.Parent := FContenitore;
  FParteBassa.Align := alBottom;
  FParteBassa.BevelOuter := bvNone;
  FParteBassa.Height := FContenitore.ClientHeight * 35 div 100;

  // La fascia d'esito sta sopra le linguette e resta visibile anche quando
  // e' aperto un risultato: senza, con una SELECT a meta' script non si
  // capiva se l'esecuzione era finita o si era fermata li'
  FFasciaEsito := TcxLabel.Create(Self);
  FFasciaEsito.Parent := FParteBassa;
  FFasciaEsito.Align := alTop;
  FFasciaEsito.AutoSize := False;
  FFasciaEsito.Height := MulDiv(26, FParteBassa.CurrentPPI, 96);
  FFasciaEsito.Properties.Alignment.Vert := taVCenter;
  FFasciaEsito.Style.Font.Style := [fsBold];
  FFasciaEsito.Transparent := False;
  FFasciaEsito.Visible := False;

  FPagine := TcxPageControl.Create(Self);
  FPagine.Parent := FParteBassa;
  FPagine.Align := alClient;

  FDivisore := TcxSplitter.Create(Self);
  FDivisore.Parent := FContenitore;
  FDivisore.AlignSplitter := salBottom;
  FDivisore.Control := FParteBassa;
  FDivisore.Top := FParteBassa.Top - 1;

  // messaggi: una griglia senza dataset, una riga per messaggio
  FStili := TcxStyleRepository.Create(Self);
  FStileErrore := FStili.CreateItem(TcxStyle) as TcxStyle;
  FStileErrore.TextColor := clRed;
  FStileAvviso := FStili.CreateItem(TcxStyle) as TcxStyle;
  FStileAvviso.TextColor := $00007FBF;
  FStileRiepilogo := FStili.CreateItem(TcxStyle) as TcxStyle;
  FStileRiepilogo.Font.Style := [fsBold];
  // qualificato: anche cxEdit dichiara un svFont, di un altro tipo
  FStileRiepilogo.AssignedValues := FStileRiepilogo.AssignedValues + [cxStyles.svFont];

  FFoglioMessaggi := TcxTabSheet.Create(Self);
  FFoglioMessaggi.PageControl := FPagine;
  FFoglioMessaggi.Caption := 'Messaggi';

  FGrigliaMessaggi := TcxGrid.Create(Self);
  FGrigliaMessaggi.Parent := FFoglioMessaggi;
  FGrigliaMessaggi.Align := alClient;

  FVistaMessaggi := FGrigliaMessaggi.CreateView(TcxGridTableView) as TcxGridTableView;
  FGrigliaMessaggi.Levels.Add.GridView := FVistaMessaggi;
  FVistaMessaggi.OptionsView.GroupByBox := False;
  FVistaMessaggi.OptionsView.ColumnAutoWidth := True;
  FVistaMessaggi.OptionsView.Indicator := False;
  FVistaMessaggi.OptionsData.Editing := False;
  FVistaMessaggi.OptionsData.Inserting := False;
  FVistaMessaggi.OptionsData.Deleting := False;
  FVistaMessaggi.OptionsSelection.CellSelect := False;
  // piu' righe con Maiusc/Ctrl e Ctrl+C: copia quelle scelte
  FVistaMessaggi.OptionsSelection.MultiSelect := True;
  FVistaMessaggi.OptionsBehavior.CellHints := True;
  FVistaMessaggi.Styles.OnGetContentStyle := StileMessaggio;
  FVistaMessaggi.OnCellDblClick := MessaggioDoppioClic;

  // larghezze in pixel a 96 DPI, scalate a quelli del monitor: senza, a
  // risoluzioni alte Riga ed Esito restavano tagliati
  FColonnaRiga := FVistaMessaggi.CreateColumn;
  FColonnaRiga.Caption := 'Riga';
  FColonnaRiga.DataBinding.ValueType := 'Integer';
  FColonnaRiga.Width := MulDiv(55, FGrigliaMessaggi.CurrentPPI, 96);

  FColonnaTipo := FVistaMessaggi.CreateColumn;
  FColonnaTipo.Caption := 'Esito';
  FColonnaTipo.DataBinding.ValueType := 'String';
  FColonnaTipo.Width := MulDiv(70, FGrigliaMessaggi.CurrentPPI, 96);

  FColonnaTesto := FVistaMessaggi.CreateColumn;
  FColonnaTesto.Caption := 'Messaggio';
  FColonnaTesto.DataBinding.ValueType := 'String';
  FColonnaTesto.Width := MulDiv(600, FGrigliaMessaggi.CurrentPPI, 96);

  FColonnaFile := FVistaMessaggi.CreateColumn;
  FColonnaFile.Caption := 'Script incluso';
  FColonnaFile.DataBinding.ValueType := 'String';
  FColonnaFile.Width := MulDiv(140, FGrigliaMessaggi.CurrentPPI, 96);
end;

// ---------------------------------------------------------------------------
// Stato dei comandi e intestazione
// ---------------------------------------------------------------------------

function TPaginaSql.PaginaVisibile: Boolean;
begin
  Result := FContenitore.Showing;
end;

procedure TPaginaSql.AzioniAggiorna(Action: TBasicAction; var Handled: Boolean);
var
  Libera: Boolean;
begin
  Libera := not FInEsecuzione;

  actApri.Enabled := Libera;
  actSalva.Enabled := Libera;
  actSalvaCome.Enabled := Libera;
  actEsegui.Enabled := Libera and not FEditor.Empty;

  // solo se cambia: assegnare la stessa didascalia ridisegna il pulsante
  if FEditor.Editor.SelAvail and (actEsegui.Caption <> 'Esegui selezione') then
    actEsegui.Caption := 'Esegui selezione'
  else if not FEditor.Editor.SelAvail and (actEsegui.Caption <> 'Esegui') then
    actEsegui.Caption := 'Esegui';

  actInterrompi.Enabled := not Libera;
  actCopiaErrori.Enabled := HaMessaggi;

  chkContinua.Enabled := Libera;
  chkProva.Enabled := Libera;
  chkAutoDdl.Enabled := Libera and not Opzione(chkProva);

  Handled := True;
end;

procedure TPaginaSql.OpzioneCambiata(Sender: TObject);
begin
  AggiornaIntestazione;
end;

procedure TPaginaSql.AggiornaIntestazione;
var
  Testo: string;
begin
  if not Assigned(FFasciaScript) then
    Exit;

  if FNomeFile <> '' then
    Testo := FNomeFile
  else
    Testo := '(script non salvato)';

  if GetModificato then
    Testo := Testo + ' *';

  if FDatabase <> '' then
    Testo := Testo + '   >>   ' + FDatabase;

  if Opzione(chkProva) then
    Testo := Testo + '   [SOLO PROVA: niente viene salvato]';

  FFasciaScript.Caption := '  ' + Testo;

  if Opzione(chkProva) then
    FFasciaScript.Style.Color := ColoreFasciaProva
  else
    FFasciaScript.Style.Color := ColoreFasciaNeutra;
end;

function TPaginaSql.GetModificato: Boolean;
begin
  Result := Assigned(FEditor) and FEditor.Editor.Modified;
end;

procedure TPaginaSql.EditorCambiato(Sender: TObject);
begin
  // un testo cambiato non e' piu' quello che ha dato l'errore
  if FRigaErrore > 0 then
  begin
    FRigaErrore := 0;
    FEditor.Editor.Invalidate;
  end;

  AggiornaIntestazione;
end;

procedure TPaginaSql.ColoraRiga(Sender: TObject; Line: TSynNativeInt; var Special: Boolean; var FG, BG: TColor);
begin
  if (FRigaErrore > 0) and (Line = FRigaErrore) then
  begin
    Special := True;
    FG := clWhite;
    BG := clRed;
  end;
end;

// ---------------------------------------------------------------------------
// File
// ---------------------------------------------------------------------------

function TPaginaSql.Vuota: Boolean;
begin
  Result := FEditor.Empty;
end;

function TPaginaSql.Carica(const NomeFile: string; ConPreavviso: Boolean): Boolean;
begin
  Result := False;

  if FInEsecuzione then
    Exit;

  // un testo modificato e non salvato si perde: si chiede prima
  if ConPreavviso and GetModificato and not FEditor.Empty then
    if not ConfirmOkCancel('Lo script nell''editor e'' stato modificato e non salvato.' + sLineBreak + 'Sostituirlo con ' +
      ExtractFileName(NomeFile) + '?', mtWarning) then
      Exit;

  // stessa lettura dell'esecutore: UTF-8 con o senza BOM, UTF-16, ANSI
  FEditor.SQL := LeggiTestoTollerante(NomeFile);
  FEditor.Editor.Modified := False;
  FNomeFile := NomeFile;
  FRigaErrore := 0;
  FEditor.Editor.Invalidate;
  AggiornaIntestazione;

  Result := True;
end;

procedure TPaginaSql.AzioneApri(Sender: TObject);
begin
  if FNomeFile <> '' then
    FDialogoApri.InitialDir := ExtractFilePath(FNomeFile)
  else
    FDialogoApri.InitialDir := FCartellaPredefinita;

  if FDialogoApri.Execute then
    Carica(FDialogoApri.FileName, True);
end;

function TPaginaSql.SalvaScript(ChiediNome: Boolean): Boolean;
var
  Destinazione: string;
begin
  Destinazione := FNomeFile;

  if ChiediNome or (Destinazione = '') then
  begin
    FDialogoSalva.FileName := ExtractFileName(Destinazione);

    if Destinazione <> '' then
      FDialogoSalva.InitialDir := ExtractFilePath(Destinazione)
    else
      FDialogoSalva.InitialDir := FCartellaPredefinita;

    if not FDialogoSalva.Execute then
      Exit(False);

    Destinazione := FDialogoSalva.FileName;
  end;

  // UTF-8 con BOM, come le regole di casa vogliono per gli script SQL
  TFile.WriteAllText(Destinazione, FEditor.SQL, TEncoding.UTF8);
  FEditor.Editor.Modified := False;
  FNomeFile := Destinazione;
  AggiornaIntestazione;
  Result := True;
end;

procedure TPaginaSql.AzioneSalva(Sender: TObject);
begin
  SalvaScript(False);
end;

procedure TPaginaSql.AzioneSalvaCome(Sender: TObject);
begin
  SalvaScript(True);
end;

// ---------------------------------------------------------------------------
// Esecuzione
// ---------------------------------------------------------------------------

function TPaginaSql.TestoDaEseguire(out RigaIniziale: Integer; out SoloSelezione: Boolean): string;
begin
  SoloSelezione := FEditor.Editor.SelAvail;

  if SoloSelezione then
  begin
    Result := FEditor.Editor.SelText;
    RigaIniziale := FEditor.Editor.BlockBegin.Line;
  end
  else
  begin
    Result := FEditor.SQL;
    RigaIniziale := 1;
  end;
end;

procedure TPaginaSql.AzioneInterrompi(Sender: TObject);
begin
  if FInEsecuzione and PaginaVisibile then
  begin
    FEsecutore.Interrompi;
    Fascia('Interruzione richiesta: si ferma prima dell''istruzione successiva...', ColoreFasciaAvviso);
  end;
end;

procedure TPaginaSql.AzioneEsegui(Sender: TObject);
var
  Impostazioni: TImpostazioniEsecuzione;
  Esito: TEsitoEsecuzione;
  Testo, Descrizione, Domanda: string;
  RigaIniziale: Integer;
  SoloSelezione: Boolean;
begin
  // F9 del frame arriva anche quando la pagina e' nascosta (vedi in testa)
  if FInEsecuzione or not PaginaVisibile then
    Exit;

  Testo := TestoDaEseguire(RigaIniziale, SoloSelezione);

  if Trim(Testo) = '' then
    Exit;

  Impostazioni := Default (TImpostazioniEsecuzione);
  Impostazioni.Continua := Opzione(chkContinua);
  Impostazioni.Prova := Opzione(chkProva);
  Impostazioni.AutoDdl := Opzione(chkAutoDdl);
  Impostazioni.RigheMassime := FRigheMassime;

  // una prova non cambia il database: niente conferma
  if not Impostazioni.Prova then
  begin
    if SoloSelezione then
      Domanda := Format('Eseguire sul database la selezione (dalla riga %d)?', [RigaIniziale])
    else
      Domanda := 'Eseguire lo script di aggiornamento sul database?';

    if not ConfirmOkCancel(Domanda) then
      Exit;
  end;

  if SoloSelezione then
    Descrizione := Format('Selezione dalla riga %d', [RigaIniziale])
  else
    Descrizione := 'Tutto lo script';

  if Impostazioni.Prova then
    Descrizione := Descrizione + ' (SOLO PROVA)';

  // un testo mai salvato risolve gli INPUT relativi dalla cartella aggiornamenti
  FEsecutore.CartellaPredefinita := FCartellaPredefinita;

  PreparaEsecuzione(Descrizione);

  FInEsecuzione := True;
  FEsecutore.OnMessaggio := EsecutoreMessaggio;
  FEsecutore.OnRisultato := EsecutoreRisultato;
  FEsecutore.OnAvanzamento := EsecutoreAvanzamento;
  Screen.Cursor := crAppStart;
  try
    try
      Esito := FEsecutore.EseguiTesto(Testo, FNomeFile, RigaIniziale, Impostazioni);
    except
      on E: Exception do
      begin
        // connessione caduta o rifiutata: la prossima esecuzione riparte da
        // una connessione nuova
        FEsecutore.Disconnetti;
        AggiungiMessaggio(tmErrore, '', 0, E.Message);
        MostraFallimento(E.Message);
        ConfirmOk('Script non eseguito: ' + E.Message, mtError);
        Exit;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
    FEsecutore.OnMessaggio := nil;
    FEsecutore.OnRisultato := nil;
    FEsecutore.OnAvanzamento := nil;
    FInEsecuzione := False;
  end;

  MostraEsito(Esito, Impostazioni.Prova);

  // la riga si segna solo se l'errore e' nel testo dell'editor, non in un
  // file richiamato con INPUT
  if (Esito.RigaErrore > 0) and Esito.FileErrore.IsEmpty then
  begin
    FRigaErrore := Esito.RigaErrore;
    VaiARiga(FRigaErrore);
  end;

  EsitoFinale(Esito, Impostazioni.Prova);
end;

procedure TPaginaSql.EsitoFinale(const Esito: TEsitoEsecuzione; Prova: Boolean);
var
  Testo: string;
begin
  if (Esito.Errori = 0) and not Esito.Annullata and not Esito.Interrotta then
  begin
    ConfirmOk('Script di aggiornamento eseguito e confermato.');
    Exit;
  end;

  if Prova and (Esito.Errori = 0) and not Esito.Interrotta then
  begin
    ConfirmOk('Prova terminata senza errori: tutto annullato, il database non e'' cambiato.');
    Exit;
  end;

  if Esito.Interrotta then
    Testo := 'Script interrotto.'
  else if Esito.Errori = 0 then
    Testo := 'Script terminato da QUIT: transazione annullata.'
  else if Esito.FileErrore.IsEmpty then
    Testo := Format('Script fermato da un errore alla riga %d.', [Esito.RigaErrore])
  else
    Testo := Format('Script fermato da un errore alla riga %d di %s.', [Esito.RigaErrore, Esito.FileErrore]);

  // con autoddl ogni DDL riuscito e' gia' confermato: l'annullamento
  // riguarda solo il lavoro successivo all'ultima conferma
  if Esito.Annullata and not Prova then
    Testo := Testo + sLineBreak + 'Le istruzioni dopo l''ultima conferma (COMMIT o DDL con autoddl) sono state annullate; ' +
      'quelle confermate prima restano nel database.';

  ConfirmOk(Testo + sLineBreak + 'Dettaglio nei messaggi sotto l''editor.', mtError);
end;

procedure TPaginaSql.EsecutoreMessaggio(Sender: TObject; Tipo: TTipoMessaggio; const NomeFile: string; Riga: Integer; const Testo: string);
begin
  AggiungiMessaggio(Tipo, NomeFile, Riga, Testo);
end;

procedure TPaginaSql.EsecutoreRisultato(Sender: TObject; const NomeFile: string; Riga: Integer; const TestoIstruzione: string; DataSet: TDataSet;
  Tagliato: Boolean; Millisecondi: Int64);
begin
  // le SELECT di uno script incluso con INPUT hanno righe che non sono
  // dell'editor: il foglio le riporta lo stesso, con la riga del loro file
  AggiungiRisultato(Riga, TestoIstruzione, DataSet, Tagliato);
end;

procedure TPaginaSql.EsecutoreAvanzamento(Sender: TObject);
begin
  // la pagina si ridisegna e Interrompi puo' arrivare: e' l'unico punto in
  // cui l'esecuzione cede il passo
  Application.ProcessMessages;
end;

// ---------------------------------------------------------------------------
// Esito e messaggi
// ---------------------------------------------------------------------------

procedure TPaginaSql.Fascia(const Testo: string; Colore: TColor);
begin
  FFasciaEsito.Caption := '  ' + Testo;
  FFasciaEsito.Style.Color := Colore;
  FFasciaEsito.Style.TextColor := clWhite;
  FFasciaEsito.Visible := True;
  FFasciaEsito.Update;
end;

procedure TPaginaSql.PreparaEsecuzione(const Descrizione: string);
begin
  FRigaErrore := 0;
  FEditor.Editor.Invalidate;

  FPagine.ActivePage := FFoglioMessaggi;
  FRisultati.Clear;

  FVistaMessaggi.DataController.RecordCount := 0;

  FDescrizioneEsecuzione := Descrizione;
  Fascia(Descrizione + '...', ColoreFasciaInCorso);
end;

procedure TPaginaSql.MostraFallimento(const Motivo: string);
begin
  FTestoEsito := 'NON ESEGUITO: ' + Motivo.Replace(sLineBreak, ' ');
  FColoreEsito := ColoreFasciaErrore;
  Fascia(FTestoEsito, FColoreEsito);
  FPagine.ActivePage := FFoglioMessaggi;
end;

procedure TPaginaSql.MostraEsito(const Esito: TEsitoEsecuzione; Prova: Boolean);
var
  Testo, Risultati: string;
  Colore: TColor;
begin
  if Esito.Risultati = 1 then
    Risultati := ', 1 risultato'
  else if Esito.Risultati > 1 then
    Risultati := Format(', %d risultati', [Esito.Risultati])
  else
    Risultati := '';

  // Un testo per caso, che dice in una riga se e' finito e cosa e' rimasto
  // nel database: e' la domanda che ci si fa guardando i risultati
  if Esito.Interrotta then
  begin
    Testo := Format('INTERROTTO dopo %d istruzioni: transazione annullata', [Esito.Eseguite]);
    Colore := ColoreFasciaAvviso;
  end
  else if Esito.Errori > 0 then
  begin
    if Esito.Fermata then
      Testo := Format('FERMATO ALL''ERRORE della riga %d: transazione annullata, le istruzioni successive non sono ' +
        'state eseguite', [Esito.RigaErrore])
    else
      Testo := Format('FINITO CON %s (proseguito dopo gli errori): confermato quello che e'' riuscito',
        [IfThen(Esito.Errori = 1, '1 ERRORE', Format('%d ERRORI', [Esito.Errori]))]);
    Colore := ColoreFasciaErrore;
  end
  else if Prova then
  begin
    Testo := Format('PROVA FINITA: %d istruzioni eseguite%s, tutto annullato: il database non e'' cambiato', [Esito.Eseguite, Risultati]);
    Colore := ColoreFasciaProva;
  end
  else if Esito.Annullata then
  begin
    Testo := Format('FINITO con QUIT: %d istruzioni eseguite%s, transazione annullata', [Esito.Eseguite, Risultati]);
    Colore := ColoreFasciaAvviso;
  end
  else
  begin
    Testo := Format('COMPLETATO: %d istruzioni eseguite%s, tutto confermato', [Esito.Eseguite, Risultati]);
    Colore := ColoreFasciaRiuscito;
  end;

  FTestoEsito := Format('%s  -  %s, %d ms', [Testo, FDescrizioneEsecuzione, Esito.Millisecondi]);
  FColoreEsito := Colore;
  Fascia(FTestoEsito, FColoreEsito);

  // la linguetta si sceglie a fine esecuzione: l'errore nei messaggi, se
  // tutto e' andato il primo risultato
  if (Esito.Errori = 0) and not Esito.Interrotta and (FRisultati.Count > 0) then
    FPagine.ActivePage := FRisultati[0].Foglio
  else
    FPagine.ActivePage := FFoglioMessaggi;
end;

procedure TPaginaSql.AggiungiMessaggio(Tipo: TTipoMessaggio; const NomeFile: string; Riga: Integer; const Testo: string);
var
  Indice: Integer;
begin
  // l'istruzione e il suo esito stanno sulla stessa riga della griglia:
  // l'esito completa quella dell'istruzione appena aggiunta
  Indice := FVistaMessaggi.DataController.RecordCount - 1;

  if (Tipo in [tmEsito, tmErrore, tmAvviso]) and (Indice >= 0) and (FVistaMessaggi.DataController.Values[Indice, IndiceTipo] = '') and
    (FVistaMessaggi.DataController.Values[Indice, IndiceRiga] = Riga) then
  begin
    FVistaMessaggi.DataController.Values[Indice, IndiceTipo] := NomiTipo[Tipo];
    FVistaMessaggi.DataController.Values[Indice, IndiceTesto] := FVistaMessaggi.DataController.Values[Indice, IndiceTesto] + '  ->  ' +
      Testo.Replace(sLineBreak, ' | ');
  end
  else
  begin
    Indice := FVistaMessaggi.DataController.AppendRecord;

    if Riga > 0 then
      FVistaMessaggi.DataController.Values[Indice, IndiceRiga] := Riga;

    FVistaMessaggi.DataController.Values[Indice, IndiceTipo] := NomiTipo[Tipo];
    FVistaMessaggi.DataController.Values[Indice, IndiceTesto] := Testo.Replace(sLineBreak, ' | ');
    FVistaMessaggi.DataController.Values[Indice, IndiceFile] := ExtractFileName(NomeFile);
  end;

  FVistaMessaggi.DataController.FocusedRecordIndex := Indice;

  if FInEsecuzione and (Tipo = tmIstruzione) and (Riga > 0) then
    Fascia(Format('%s: riga %d...', [FDescrizioneEsecuzione, Riga]), ColoreFasciaInCorso);
end;

procedure TPaginaSql.AggiungiRisultato(Riga: Integer; const TestoIstruzione: string; DataSet: TDataSet; Tagliato: Boolean);
var
  Risultato: TRisultatoPagina;
  Campo: TField;
begin
  Risultato := TRisultatoPagina.Create;
  FRisultati.Add(Risultato);

  // le righe lette dal cursore passano in memoria: il cursore si chiude
  // subito dopo, la griglia resta consultabile finche' non si riesegue
  Risultato.Dati := TFDMemTable.Create(nil);
  Risultato.Dati.Data := (DataSet as TFDDataSet).Data;
  Risultato.Dati.ResourceOptions.SilentMode := True;

  // la riga in piu' letta per sapere che ce n'erano altre
  if Tagliato then
  begin
    Risultato.Dati.Last;
    Risultato.Dati.Delete;
  end;

  // NUMERIC e DECIMAL con tutti i decimali della scala: un importo si
  // legge 1.234,50, non 1234,5
  for Campo in Risultato.Dati.Fields do
    if (Campo is TFMTBCDField) and (TFMTBCDField(Campo).Size > 0) then
      TFMTBCDField(Campo).DisplayFormat := '#,##0.' + StringOfChar('0', TFMTBCDField(Campo).Size)
    else if (Campo is TBCDField) and (TBCDField(Campo).Size > 0) then
      TBCDField(Campo).DisplayFormat := '#,##0.' + StringOfChar('0', TBCDField(Campo).Size);

  Risultato.Dati.First;

  Risultato.Foglio := TcxTabSheet.Create(nil);
  Risultato.Foglio.PageControl := FPagine;
  Risultato.Foglio.Caption := Format('Riga %d (%d%s)', [Riga, Risultato.Dati.RecordCount, IfThen(Tagliato, '+', '')]);
  Risultato.Foglio.Hint := TestoIstruzione;

  Risultato.Griglia := TzGrid.Create(nil);
  Risultato.Griglia.Name := '';
  Risultato.Griglia.Parent := Risultato.Foglio;
  Risultato.Griglia.Align := alClient;
  Risultato.Griglia.Attach(Risultato.Dati);
  Risultato.Griglia.SetEditing(False, False, False);

  // la linguetta da mostrare la sceglie MostraEsito a fine esecuzione:
  // passare a un risultato a meta' script faceva pensare che fosse finito
end;

procedure TPaginaSql.VaiARiga(Riga: Integer);
begin
  if (Riga < 1) or (Riga > FEditor.Editor.Lines.Count) then
    Exit;

  FEditor.Editor.GotoLineAndCenter(Riga);
  FEditor.Editor.Invalidate;

  if FEditor.Editor.CanFocus then
    FEditor.Editor.SetFocus;
end;

procedure TPaginaSql.StileMessaggio(Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  Tipo: Variant;
begin
  if not Assigned(ARecord) then
    Exit;

  Tipo := ARecord.Values[IndiceTipo];

  if Tipo = NomiTipo[tmErrore] then
    AStyle := FStileErrore
  else if Tipo = NomiTipo[tmAvviso] then
    AStyle := FStileAvviso
  else if Tipo = NomiTipo[tmRiepilogo] then
    AStyle := FStileRiepilogo;
end;

procedure TPaginaSql.MessaggioDoppioClic(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
var
  Riga: Variant;
  FileIncluso: Variant;
begin
  Riga := ACellViewInfo.GridRecord.Values[IndiceRiga];
  FileIncluso := ACellViewInfo.GridRecord.Values[IndiceFile];

  // le righe degli script inclusi con INPUT non sono righe di questo
  // editor
  if VarIsNull(Riga) or ((not VarIsNull(FileIncluso)) and (FileIncluso <> '')) then
    Exit;

  VaiARiga(Riga);
  AHandled := True;
end;

function TPaginaSql.HaMessaggi: Boolean;
begin
  Result := FVistaMessaggi.DataController.RecordCount > 0;
end;

function TPaginaSql.TestoPerCopia(out Numero: Integer): string;
var
  Indice: Integer;
  Riga, Tipo, Messaggio, Elenco, Intestazione: string;
  Tutti: Boolean;
begin
  Numero := 0;
  Result := '';

  if not HaMessaggi then
    Exit;

  // prima si contano gli errori: se non ce ne sono si copia tutto
  for Indice := 0 to FVistaMessaggi.DataController.RecordCount - 1 do
    if SameText(VarToStr(FVistaMessaggi.DataController.Values[Indice, IndiceTipo]), NomiTipo[tmErrore]) then
      Inc(Numero);

  Tutti := Numero = 0;
  Elenco := '';

  for Indice := 0 to FVistaMessaggi.DataController.RecordCount - 1 do
  begin
    Tipo := VarToStr(FVistaMessaggi.DataController.Values[Indice, IndiceTipo]);

    if not Tutti and not SameText(Tipo, NomiTipo[tmErrore]) then
      Continue;

    Riga := VarToStr(FVistaMessaggi.DataController.Values[Indice, IndiceRiga]);
    Messaggio := VarToStr(FVistaMessaggi.DataController.Values[Indice, IndiceTesto]);

    if Riga <> '' then
      Elenco := Elenco + 'Riga ' + Riga + ': ';

    if Tipo <> '' then
      Elenco := Elenco + Tipo + ' - ';

    Elenco := Elenco + Messaggio;

    if VarToStr(FVistaMessaggi.DataController.Values[Indice, IndiceFile]) <> '' then
      Elenco := Elenco + ' (' + VarToStr(FVistaMessaggi.DataController.Values[Indice, IndiceFile]) + ')';

    Elenco := Elenco + sLineBreak;
  end;

  Intestazione := 'Script: ' + IfThen(FNomeFile <> '', FNomeFile, '(non salvato)') + sLineBreak + 'Database: ' +
    IfThen(FDatabase <> '', FDatabase, '(non indicato)') + sLineBreak;

  if FTestoEsito <> '' then
    Intestazione := Intestazione + 'Esito: ' + FTestoEsito + sLineBreak;

  Result := Intestazione + sLineBreak + Elenco;
end;

procedure TPaginaSql.AzioneCopiaErrori(Sender: TObject);
var
  Numero: Integer;
  Testo: string;
begin
  Testo := TestoPerCopia(Numero);

  if Testo = '' then
    Exit;

  Clipboard.AsText := Testo;

  // la fascia dice cosa e' stato copiato senza perdere l'esito
  if Numero > 0 then
    Fascia(Format('%s  [copiat%s negli appunti: %s]', [FTestoEsito, IfThen(Numero = 1, 'o', 'i'), Conteggio(Numero, 'errore', 'errori')]),
      FColoreEsito)
  else
    Fascia(FTestoEsito + '  [nessun errore: copiati negli appunti tutti i messaggi]', FColoreEsito);
end;

end.
