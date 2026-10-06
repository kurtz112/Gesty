unit frmCalendarioDocenti;

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
  Frame_CalendarioDocenti;

type
  TFormCalendarioDocenti = class(TBaseForm)
    FrameCalendarioDocenti: TFrameCalendarioDocenti;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    procedure Stampa; override;
  end;

var
  FormCalendarioDocenti: TFormCalendarioDocenti;

implementation

uses
  System.DateUtils,
  zDx,
  dmCalendarioDocenti, zDm_Images;

{$R *.dfm}
{ TFormCalendarioDocenti }

procedure TFormCalendarioDocenti.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Calendario Docenti';
  ReportGroup := 'Calendario Docenti';
end;

procedure TFormCalendarioDocenti.CreateDataModule;
begin
  inherited;
  CreateDM(TCalendarioDocenti, CalendarioDocenti);
end;

procedure TFormCalendarioDocenti.DestroyDataModule;
begin
  inherited;
  FreeAndNil(CalendarioDocenti);
end;

procedure TFormCalendarioDocenti.FormShow(Sender: TObject);
begin
  inherited;
  FrameCalendarioDocenti.Show;
end;

procedure TFormCalendarioDocenti.Stampa;
begin
  // inherited;
  FrameCalendarioDocenti.Stampa;
end;

end.
