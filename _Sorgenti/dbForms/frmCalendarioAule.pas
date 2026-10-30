unit frmCalendarioAule;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnList,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  dxBarExtItems,
  cxClasses,
  cxLabel,
  dxLayoutContainer,
  dxLayoutControl,
  BaseFrm,
  Base_Frame,
  Frame_CalendarioAule;

type
  TFormCalendarioAule = class(TBaseForm)
    FrameCalendarioAule: TFrameCalendarioAule;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    procedure Stampa; override;
  end;

var
  FormCalendarioAule: TFormCalendarioAule;

implementation

uses
  System.DateUtils,
  zDx,
  dmCalendarioAule;

{$R *.dfm}
{ TFormCalendarioDocenti }

procedure TFormCalendarioAule.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Calendario Aule';
  ReportGroup := 'Calendario Aule';
end;

procedure TFormCalendarioAule.CreateDataModule;
begin
  inherited;
  CreateDM(TCalendarioAule, CalendarioAule);
end;

procedure TFormCalendarioAule.DestroyDataModule;
begin
  inherited;
  FreeAndNil(CalendarioAule);
end;

procedure TFormCalendarioAule.FormShow(Sender: TObject);
begin
  inherited;
  FrameCalendarioAule.Show;
end;

procedure TFormCalendarioAule.Stampa;
begin
  // inherited;
  FrameCalendarioAule.Stampa;
end;

end.
