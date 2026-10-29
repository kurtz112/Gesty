unit zStorage;

interface

uses
  SysUtils,
  Classes,
  Controls,
  ExtCtrls,
  Forms,
  cxSplitter;

type
  TzStorage = class
  private
    class function FindSplittedControl(Splitter: TcxSplitter): TControl;
  public
    class procedure SaveControlToIni(const IniFileName: string; Ctrl: TWinControl);
    class procedure LoadControlFromIni(const IniFileName: string; Ctrl: TWinControl; const MaxWidth, MaxHeight: integer);
  end;

implementation

uses
  Types,
  IniFiles,
  Math;

// Disposizione adattiva 2026-10-29: riporta il rettangolo salvato dentro l'area
// utile del monitor piu' vicino (esclusa la barra delle applicazioni): prima lo
// stringe se e' piu' grande, poi lo sposta se sborda. Stessa regola di
// LoadFormPosition di zBaseLib, che non la esporta.
function RettangoloNellAreaUtile(const Rettangolo: TRect): TRect;
var
  Monitor: TMonitor;
  AreaUtile: TRect;
  Larghezza, Altezza: integer;
begin
  Result := Rettangolo;

  Monitor := Screen.MonitorFromRect(Rettangolo, mdNearest);
  if not Assigned(Monitor) then
    Monitor := Screen.PrimaryMonitor;
  if not Assigned(Monitor) then
    Exit;

  AreaUtile := Monitor.WorkareaRect;

  Larghezza := Min(Rettangolo.Width, AreaUtile.Width);
  Altezza := Min(Rettangolo.Height, AreaUtile.Height);

  Result.Left := Rettangolo.Left;
  if Result.Left + Larghezza > AreaUtile.Right then
    Result.Left := AreaUtile.Right - Larghezza;
  if Result.Left < AreaUtile.Left then
    Result.Left := AreaUtile.Left;

  Result.Top := Rettangolo.Top;
  if Result.Top + Altezza > AreaUtile.Bottom then
    Result.Top := AreaUtile.Bottom - Altezza;
  if Result.Top < AreaUtile.Top then
    Result.Top := AreaUtile.Top;

  Result.Right := Result.Left + Larghezza;
  Result.Bottom := Result.Top + Altezza;
end;

class function TzStorage.FindSplittedControl(Splitter: TcxSplitter): TControl;
var
  P: TPoint;
  I: integer;
  R: TRect;
begin
  Result := nil;

  if not Assigned(Splitter) then
    Exit;

  if Assigned(Splitter.Control) then
  begin
    Result := Splitter.Control;
    Exit;
  end;

  P := Point(Splitter.Left, Splitter.Top);
  case Splitter.AlignSplitter of
    sAlLeft:
      Dec(P.X);
    sAlRight:
      Inc(P.X, Splitter.Width);
    sAlTop:
      Dec(P.Y);
    sAlBottom:
      Inc(P.Y, Splitter.Height);
  else
    Exit;
  end;

  for I := 0 to Splitter.Parent.ControlCount - 1 do
  begin
    Result := Splitter.Parent.Controls[I];

    if Result.Visible and Result.Enabled and (Result.Align <> alClient) then
    begin
      R := Result.BoundsRect;

      if (R.Right - R.Left) = 0 then
        if Splitter.AlignSplitter in [sAlTop, sAlLeft] then
          Dec(R.Left)
        else
          Inc(R.Right);

      if (R.Bottom - R.Top) = 0 then
        if Splitter.AlignSplitter in [sAlTop, sAlLeft] then
          Dec(R.Top)
        else
          Inc(R.Bottom);

      if Result.AlignWithMargins then
      begin
        Dec(R.Top, Result.Margins.Top);
        Dec(R.Left, Result.Margins.Left);
        Inc(R.Right, Result.Margins.Right);
        Inc(R.Bottom, Result.Margins.Bottom);
      end;

      if PtInRect(R, P) then
        Exit;
    end;
  end;
  Result := nil;
end;

class procedure TzStorage.SaveControlToIni(const IniFileName: string; Ctrl: TWinControl);
  procedure SaveControls(IniFile: TIniFile; Section: string; parentCtrl: TWinControl);
  var
    I: integer;
    Ctrl: TControl;
    AName: string;
    Idx: integer;
  begin
    for I := 0 to parentCtrl.ControlCount - 1 do
    begin
      Ctrl := nil;

      if parentCtrl.Controls[I] is TcxSplitter then
        Ctrl := FindSplittedControl(parentCtrl.Controls[I] as TcxSplitter);

      if Assigned(Ctrl) then
        if Ctrl.Align <> alClient then
        begin
          AName := Ctrl.Name;
          case Ctrl.Align of
            AlNone:
              begin
              end;
            AlTop:
              begin
                IniFile.WriteInteger(Section, Ctrl.Name + '_Height', Ctrl.Height);
              end;
            AlBottom:
              begin
                IniFile.WriteInteger(Section, Ctrl.Name + '_Height', Ctrl.Height);
              end;
            AlLeft:
              begin
                IniFile.WriteInteger(Section, Ctrl.Name + '_Width', Ctrl.Width);
              end;
            AlRight:
              begin
                IniFile.WriteInteger(Section, Ctrl.Name + '_Width', Ctrl.Width);
              end;
            alClient:
              begin
              end;
            AlCustom:
              begin
              end;
          end;
        end; // Saved

      if parentCtrl.Controls[I] is TWinControl then
        SaveControls(IniFile, Section, parentCtrl.Controls[I] as TWinControl);
    end;
  end;

var
  IniFile: TIniFile;
  Section: string;
  ws: TWindowState;
begin
  if IniFileName = '' then
    Exit;

  if not Assigned(Ctrl) then
    Exit;

  Section := Ctrl.Name;
  if Section = '' then
    Exit;

  IniFile := TIniFile.Create(IniFileName);
  try
    if Ctrl is TForm then
    begin
      ws := TForm(Ctrl).WindowState;
      IniFile.WriteInteger(Section, 'State', integer(ws));
    end
    else
      ws := wsNormal;

    /// ////////////////////
    if ws = wsNormal then
    begin
      IniFile.WriteInteger(Section, 'Top', Ctrl.Top);
      IniFile.WriteInteger(Section, 'Left', Ctrl.Left);
      IniFile.WriteInteger(Section, 'Height', Ctrl.Height);
      IniFile.WriteInteger(Section, 'Width', Ctrl.Width);
    end;
    SaveControls(IniFile, Section, Ctrl);
  finally
    FreeAndNil(IniFile);
  end;
end;

class procedure TzStorage.LoadControlFromIni(const IniFileName: string; Ctrl: TWinControl; const MaxWidth, MaxHeight: integer);
const
  MinWidth = 100;
  MinHeight = 100;

  function CalcMaxWidth(Ctrl: TControl): integer;
  var
    Parent: TControl;
  begin
    Result := MaxWidth;

    Parent := Ctrl.Parent;

    while Assigned(Parent) do
    begin

      if Result > Parent.ClientWidth then
        Result := Parent.ClientWidth;

      Parent := Parent.Parent;
    end;
  end;

  function CalcMaxHeight(Ctrl: TControl): integer;
  var
    Parent: TControl;
  begin
    Result := MaxHeight;

    Parent := Ctrl.Parent;

    while Assigned(Parent) do
    begin

      if Result > Parent.ClientHeight then
        Result := Parent.ClientHeight;

      Parent := Parent.Parent;
    end;
  end;

  procedure SetCtrlHeight(Ctrl: TControl; h: integer);
  var
    tmp: integer;
  begin
    // min
    tmp := min(h, CalcMaxHeight(Ctrl) - MinHeight);

    // che si veda un minimo..
    tmp := max(tmp, MinHeight);

    Ctrl.Height := tmp;
  end;

  procedure SetCtrlWidth(Ctrl: TControl; w: integer);
  var
    tmp: integer;
  begin
    tmp := min(w, CalcMaxWidth(Ctrl) - MinWidth);

    // che si veda un minimo..
    tmp := max(tmp, MinWidth);

    Ctrl.Width := tmp;
  end;

  procedure LoadControls(IniFile: TIniFile; Section: string; aControl: TWinControl);
  var
    I: integer;
    Ctrl: TControl;
    AName: string;
    Idx: integer;
    Splitter: TcxSplitter;
  begin
    for I := 0 to aControl.ControlCount - 1 do
    begin
      Ctrl := nil;

      if aControl.Controls[I] is TcxSplitter then
        Ctrl := FindSplittedControl(aControl.Controls[I] as TcxSplitter);

      if Assigned(Ctrl) then
        if Ctrl.Align <> alClient then
        begin // Saving
          AName := Ctrl.Name; // FullComponentName(Ctrl);
          case Ctrl.Align of
            AlNone:
              begin
              end;
            AlTop:
              begin
                SetCtrlHeight(Ctrl, IniFile.ReadInteger(Section, Ctrl.Name + '_Height', Ctrl.Height));
              end;
            AlBottom:
              begin
                SetCtrlHeight(Ctrl, IniFile.ReadInteger(Section, Ctrl.Name + '_Height', Ctrl.Height));
              end;
            AlLeft:
              begin
                SetCtrlWidth(Ctrl, IniFile.ReadInteger(Section, Ctrl.Name + '_Width', Ctrl.Width));
              end;
            AlRight:
              begin
                SetCtrlWidth(Ctrl, IniFile.ReadInteger(Section, Ctrl.Name + '_Width', Ctrl.Width));
              end;
            alClient:
              begin
              end;
            AlCustom:
              begin
              end;
          end;
        end; // Saved

      if aControl.Controls[I] is TWinControl then
        LoadControls(IniFile, Section, aControl.Controls[I] as TWinControl);
    end;
  end;

var
  IniFile: TIniFile;
  ws: TWindowState;
  Section: string;
  Rettangolo: TRect;
begin
  if IniFileName = '' then
    Exit;

  if not Assigned(Ctrl) then
    Exit;

  Section := Ctrl.Name;
  if Section = '' then
    Exit;

  IniFile := TIniFile.Create(IniFileName);
  try
    if not IniFile.SectionExists(Section) then
      Exit;

    if Ctrl is TForm then
      TForm(Ctrl).Position := poDesigned;

    Rettangolo := Rect(0, 0, 0, 0);
    Rettangolo.Left := IniFile.ReadInteger(Section, 'Left', Ctrl.Left);
    Rettangolo.Top := IniFile.ReadInteger(Section, 'Top', Ctrl.Top);
    Rettangolo.Width := IniFile.ReadInteger(Section, 'Width', Ctrl.Width);
    Rettangolo.Height := IniFile.ReadInteger(Section, 'Height', Ctrl.Height);

    // Disposizione adattiva 2026-10-29: prima i limiti salvati si applicavano
    // cosi' com'erano. Una form chiusa su un monitor che ora non c'e' (desktop
    // remoto da un portatile verso un fisso con piu' monitor) si riapriva fuori
    // dallo schermo: con un dialogo modale, come la Rettifica dell'incarico, il
    // programma sembrava bloccato senza consumare CPU. Ora per le form il
    // rettangolo si riporta nell'area utile del monitor piu' vicino.
    if Ctrl is TForm then
      Rettangolo := RettangoloNellAreaUtile(Rettangolo);

    Ctrl.SetBounds(Rettangolo.Left, Rettangolo.Top, Rettangolo.Width, Rettangolo.Height);

    if Ctrl is TForm then
    begin
      ws := TForm(Ctrl).WindowState;
      TForm(Ctrl).WindowState := wsNormal;

      if IniFile.ValueExists(Section, 'State') then
        ws := TWindowState(IniFile.ReadInteger(Section, 'State', integer(ws)))
      else
      begin
        // compatibilità con
        if IniFile.ValueExists(Section, 'ShowCmd') then
          if IniFile.ReadInteger(Section, 'ShowCmd', -1) = 3 then
            ws := wsMaximized;
      end;

      // if ws in [wsMaximized, wsMinimized] then
      if ws = wsMaximized then
        TForm(Ctrl).WindowState := wsMaximized
      else
        TForm(Ctrl).WindowState := wsNormal;
    end;

    LoadControls(IniFile, Section, Ctrl);
  finally
    FreeAndNil(IniFile);
  end;
end;

end.
