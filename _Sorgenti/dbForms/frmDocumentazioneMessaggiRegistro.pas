unit frmDocumentazioneMessaggiRegistro;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  Forms,
  ExtCtrls,
  cxGraphics,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxControls,
  BaseFrm,
  cxContainer,
  cxEdit,
  dxBar,
  System.Actions,
  Vcl.ActnList,
  dxBarExtItems,
  cxClasses,
  cxLabel;

type
  TFormDocumentazioneMessaggiRegistro = class(TBaseForm)
    ActionList: TActionList;
    VerificaRicevute: TAction;
    procedure FormCreate(Sender: TObject);
    procedure VerificaRicevuteExecute(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public

  end;

implementation

uses
  dmDocumentazioneMessaggiRegistro;

{$R *.dfm}

procedure TFormDocumentazioneMessaggiRegistro.CreateDataModule;
begin
  inherited;
  CreateDM(TDocumentazioneMessaggiRegistro, DocumentazioneMessaggiRegistro);
end;

procedure TFormDocumentazioneMessaggiRegistro.DestroyDataModule;
begin
  inherited;
  FreeAndNil(DocumentazioneMessaggiRegistro);
end;

procedure TFormDocumentazioneMessaggiRegistro.FormCreate(Sender: TObject);
begin
  Caption := 'MessaggiRegistro';
  ReportGroup := 'MessaggiRegistro';
end;

procedure TFormDocumentazioneMessaggiRegistro.VerificaRicevuteExecute(Sender: TObject);
begin
  inherited;
  DocumentazioneMessaggiRegistro.VerificaRicevute;
end;

end.
