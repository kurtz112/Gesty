unit zChatSlidingPanel;

// Pannello laterale generico che si apre e chiude scorrendo dal bordo
// destro (effetto "Copilot" delle app Office / WinUI). Nessuna dipendenza
// dal contenuto: chi lo usa decide cosa metterci dentro.
//
// Deriva da TcxGroupBox in modalita' pannello (PanelStyle.Active) cosi'
// aspetto e sfondo seguono skin e look&feel DevExpress.
//
// Il pannello nasce con Align = alRight e larghezza zero: durante
// l'animazione il contenuto alClient del form si restringe fluidamente.
// A pannello aperto compare una maniglia (TcxSplitter) sul bordo sinistro
// per il ridimensionamento; la larghezza scelta viene ricordata.
//
// I discendenti possono intercettare il cambio di stato ridefinendo
// StateChanged (chiamato all'avvio di ogni animazione con lo stato
// di destinazione).

interface

uses
  System.Classes, System.SysUtils, System.Math,
  Winapi.Windows,
  Vcl.Controls, Vcl.ExtCtrls,
  cxGroupBox, cxSplitter;

type
  TzChatSlidingPanel = class(TcxGroupBox)
  private
    FAnimationTimer: TTimer;
    FSplitter: TcxSplitter;
    FExpandedWidth: Integer;
    FMinimumWidth: Integer;
    FAnimationDuration: Integer;
    FStartWidth: Integer;
    FTargetWidth: Integer;
    FStartTick: Cardinal;
    FOnOpened: TNotifyEvent;
    FOnClosed: TNotifyEvent;
    procedure AnimationStep(Sender: TObject);
    procedure StartAnimation(ATargetWidth: Integer);
    procedure EnsureSplitter;
    procedure ShowSplitter;
    procedure HideSplitter;
    procedure SplitterMoved(Sender: TObject);
    function GetIsOpen: Boolean;
  protected
    { Chiamato all'avvio di ogni animazione con lo stato di destinazione:
      i discendenti lo usano per sincronizzare action/bottoni collegati. }
    procedure StateChanged(AOpen: Boolean); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Open;
    procedure Close;
    procedure Toggle;
    // Vero se il pannello e' aperto o in corso di apertura
    property IsOpen: Boolean read GetIsOpen;
  published
    property ExpandedWidth: Integer
      read FExpandedWidth write FExpandedWidth default 380;
    // Larghezza minima consentita quando l'utente ridimensiona col mouse
    property MinimumWidth: Integer
      read FMinimumWidth write FMinimumWidth default 240;
    // Durata dell'animazione in millisecondi
    property AnimationDuration: Integer
      read FAnimationDuration write FAnimationDuration default 220;
    // Scattano a fine animazione (utili ad es. per lazy-load del contenuto)
    property OnOpened: TNotifyEvent read FOnOpened write FOnOpened;
    property OnClosed: TNotifyEvent read FOnClosed write FOnClosed;
  end;

implementation

constructor TzChatSlidingPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FExpandedWidth := 380;
  FMinimumWidth := 240;
  FAnimationDuration := 220;

  // Aspetto: pannello piatto skinnato, senza caption di group box
  PanelStyle.Active := True;
  Caption := '';

  // Stato iniziale: chiuso, agganciato al bordo destro
  Align := alRight;
  Width := 0;
  Visible := False;
  DoubleBuffered := True;

  FAnimationTimer := TTimer.Create(Self);
  FAnimationTimer.Enabled := False;
  FAnimationTimer.Interval := 10;
  FAnimationTimer.OnTimer := AnimationStep;
end;

function TzChatSlidingPanel.GetIsOpen: Boolean;
begin
  // Durante l'animazione fa fede la destinazione, non la larghezza corrente
  if FAnimationTimer.Enabled then
    Result := FTargetWidth > 0
  else
    Result := Visible and (Width > 0);
end;

procedure TzChatSlidingPanel.StateChanged(AOpen: Boolean);
begin
  // Nessuna azione nella classe base
end;

procedure TzChatSlidingPanel.Open;
begin
  if not IsOpen then
    StartAnimation(FExpandedWidth);
end;

procedure TzChatSlidingPanel.Close;
begin
  if IsOpen then
    StartAnimation(0);
end;

procedure TzChatSlidingPanel.Toggle;
begin
  if IsOpen then
    StartAnimation(0)
  else
    StartAnimation(FExpandedWidth);
end;

procedure TzChatSlidingPanel.StartAnimation(ATargetWidth: Integer);
begin
  // Riparte dalla larghezza corrente: un comando durante l'animazione
  // inverte la corsa senza scatti
  FStartWidth := Width;
  FTargetWidth := ATargetWidth;
  FStartTick := GetTickCount;
  // Lo splitter resta nascosto durante l'animazione: la larghezza e'
  // governata dal timer, non dal mouse
  HideSplitter;
  Visible := True;
  FAnimationTimer.Enabled := True;
  StateChanged(ATargetWidth > 0);
end;

procedure TzChatSlidingPanel.EnsureSplitter;
begin
  if (FSplitter <> nil) or (Parent = nil) then
    Exit;
  FSplitter := TcxSplitter.Create(Self);
  FSplitter.Parent := Parent;
  FSplitter.AlignSplitter := salRight;
  FSplitter.Control := Self;   // binding esplicito: ridimensiona il pannello
  FSplitter.Width := 5;
  FSplitter.AutoSnap := False;
  FSplitter.ResizeUpdate := True;
  FSplitter.Visible := False;
  FSplitter.OnMoved := SplitterMoved;
end;

procedure TzChatSlidingPanel.ShowSplitter;
begin
  EnsureSplitter;
  if FSplitter = nil then
    Exit;
  FSplitter.MinSize := FMinimumWidth;
  FSplitter.Visible := True;
  // Lo splitter deve stare subito a sinistra del pannello
  FSplitter.Left := Left - FSplitter.Width;
end;

procedure TzChatSlidingPanel.HideSplitter;
begin
  if FSplitter <> nil then
    FSplitter.Visible := False;
end;

procedure TzChatSlidingPanel.SplitterMoved(Sender: TObject);
begin
  // Ricorda la larghezza scelta dall'utente per le prossime aperture
  FExpandedWidth := Width;
end;

procedure TzChatSlidingPanel.AnimationStep(Sender: TObject);
var
  Elapsed: Cardinal;
  Progress: Double;
  EasingFactor: Double;
begin
  Elapsed := GetTickCount - FStartTick;

  if Elapsed >= Cardinal(FAnimationDuration) then
  begin
    FAnimationTimer.Enabled := False;
    Width := FTargetWidth;
    if FTargetWidth = 0 then
    begin
      Visible := False;
      if Assigned(FOnClosed) then
        FOnClosed(Self);
    end
    else
    begin
      // A pannello aperto compare la maniglia di ridimensionamento
      ShowSplitter;
      if Assigned(FOnOpened) then
        FOnOpened(Self);
    end;
    Exit;
  end;

  Progress := Elapsed / FAnimationDuration;
  // Easing ease-out cubico: parte rapido e decelera verso fine corsa
  EasingFactor := 1 - Power(1 - Progress, 3);
  Width := FStartWidth + Round((FTargetWidth - FStartWidth) * EasingFactor);
end;

end.
