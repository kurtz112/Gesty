unit frmBandi;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  BaseFrm,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  System.Actions,
  Vcl.ActnList,
  dxBar,
  dxBarExtItems,
  cxClasses,
  cxLabel;

type
  TFormBandi = class(TBaseForm)
    ActionList: TActionList;
    ParereFavorevole: TAction;
    ParereContrario: TAction;
    RiapriValutazione: TAction;
    procedure FormCreate(Sender: TObject);
    procedure ParereContrarioExecute(Sender: TObject);
    procedure ParereFavorevoleExecute(Sender: TObject);
    procedure RiapriValutazioneExecute(Sender: TObject);
  private
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
  end;

var
  FormBandi: TFormBandi;

implementation

uses
  dmBandi,
  zDbView;

{$R *.dfm}

procedure TFormBandi.CreateDataModule;
begin
  inherited;
  CreateDM(TBandi, Bandi);
end;

procedure TFormBandi.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Bandi);
end;

procedure TFormBandi.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Bandi';
  ReportGroup := 'Bandi';
end;

// I comandi compaiono sulle viste tramite le ToolActions del dizionario LZ

procedure TFormBandi.ParereFavorevoleExecute(Sender: TObject);
begin
  inherited;
  Bandi.ParereFavorevole;
end;

procedure TFormBandi.ParereContrarioExecute(Sender: TObject);
begin
  inherited;
  Bandi.ParereContrario;
end;

procedure TFormBandi.RiapriValutazioneExecute(Sender: TObject);
begin
  inherited;
  Bandi.RiapriValutazione;
end;

end.
