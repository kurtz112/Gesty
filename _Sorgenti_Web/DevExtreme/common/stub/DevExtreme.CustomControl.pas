unit DevExtreme.CustomControl;

interface

uses
  System.SysUtils,
  System.Classes,
  WEBLib.Controls,
  Types,
  Web,
  JS,
  libjquery,
  jsdelphisystem;

type
  TGetIdEvent = procedure(Sender: TObject; out dm, id: string) of object;
  TGetDataSetIdEvent = procedure(Sender: TObject; out dm, dataset: string) of object;

  TjdxCustomControl = class(TjQueryCustomControl)
  private
    FDM: string;
    FId: string;
    FOnGetIdEvent: TGetIdEvent;
    FOnGetDataSetIdEvent: TGetDataSetIdEvent;
  private
    FElementClassName: TElementClassName;
    FElementClassName1: TElementClassName;
    FElementID: TElementID;
    FElementPosition: TElementPosition;
  protected
    procedure Paint; override;
  public
    constructor Create(aOwner: TComponent); override;
  published
    property ElementClassName: TElementClassName read FElementClassName write FElementClassName;
    property ElementID: TElementID read FElementID write FElementID;
    property ElementPosition: TElementPosition read FElementPosition write FElementPosition default epAbsolute;
  published
    property _id: string read FId write FId;
    property _dm: string read FDM write FDM;
  published
    property OnGetIdEvent: TGetIdEvent read FOnGetIdEvent write FOnGetIdEvent;
    property OnGetDataSetIdEvent: TGetDataSetIdEvent read FOnGetDataSetIdEvent write FOnGetDataSetIdEvent;
  end;

implementation

uses
  Winapi.Windows,
  Vcl.Graphics;

constructor TjdxCustomControl.Create(aOwner: TComponent);
begin
  inherited;
  FDM := '';
  FId := '';
  FOnGetIdEvent := nil;
  FOnGetDataSetIdEvent := nil;
  FElementID := '';
  ElementClassName := '';
  FElementPosition := epAbsolute;
end;

procedure TjdxCustomControl.Paint;
var
  lRect: TRect;
  lBuffer: string;
  x, y: integer;
  s: String;
begin
  Canvas.Brush.Color := Color;
  Canvas.Brush.Style := bsSolid;
  Canvas.Pen.Color := clBlack;
  Canvas.Pen.Style := psSolid;
  lRect := ClientRect;
  Canvas.Rectangle(lRect);

  if Name <> '' then
  begin
    s := 'dx - ' + Name;

    lBuffer := '';
    DrawText(Canvas.Handle, PChar(lBuffer), Length(lBuffer), lRect, DT_SINGLELINE or DT_END_ELLIPSIS or DT_CENTER or DT_VCENTER);

    x := Trunc((lRect.Width - Canvas.TextWidth(s)) / 2);
    y := Trunc((lRect.Height - Canvas.TextHeight(s)) / 2);

    Canvas.TextOut(x, y, s);
  end;
end;

end.
