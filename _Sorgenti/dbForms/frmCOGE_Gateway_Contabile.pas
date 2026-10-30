unit frmCOGE_Gateway_Contabile;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  zDbView,
  BaseFrm,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  System.Actions,
  Vcl.ActnList,
  dxBarExtItems,
  cxClasses,
  cxLabel;

type
  TFormCOGE_Gateway_Contabile = class(TBaseForm)
    ActionList: TActionList;
    actEsportaPrimaNota: TAction;
    actLottoConsegna: TAction;
    actLottoAnnulla: TAction;
    procedure actEsportaPrimaNotaExecute(Sender: TObject);
    procedure actLottoAnnullaExecute(Sender: TObject);
    procedure actLottoConsegnaExecute(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormCOGE_Gateway_Contabile: TFormCOGE_Gateway_Contabile;

implementation

uses
  dmCOGE_Gateway_Contabile;

{$R *.dfm}

procedure TFormCOGE_Gateway_Contabile.CreateDataModule;
begin
  inherited;
  CreateDM(TCOGE_Gateway_Contabile, COGE_Gateway_Contabile);
end;

procedure TFormCOGE_Gateway_Contabile.DestroyDataModule;
begin
  inherited;
  FreeAndNil(COGE_Gateway_Contabile);
end;

constructor TFormCOGE_Gateway_Contabile.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'COGE_Gateway_Contabile';
  Caption := 'COGE_Gateway_Contabile';
end;

procedure TFormCOGE_Gateway_Contabile.actEsportaPrimaNotaExecute(Sender: TObject);
begin
  inherited;
  COGE_Gateway_Contabile.AzioneEsportaPrimaNota;
end;

procedure TFormCOGE_Gateway_Contabile.actLottoConsegnaExecute(Sender: TObject);
begin
  inherited;
  COGE_Gateway_Contabile.AzioneLottoConsegna;
end;

procedure TFormCOGE_Gateway_Contabile.actLottoAnnullaExecute(Sender: TObject);
begin
  inherited;
  COGE_Gateway_Contabile.AzioneLottoAnnulla;
end;

end.
