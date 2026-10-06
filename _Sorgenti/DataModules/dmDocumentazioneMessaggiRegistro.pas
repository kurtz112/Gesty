unit dmDocumentazioneMessaggiRegistro;





// Registro invii (Messaggi PEC / mail) - DataModule.
// SCHELETRO: i dataset li aggiunge l'utente (vedi commento in DataModuleCreate).
// Coppia con frmDocumentazioneMessaggiRegistro (la griglia / vista unica).

interface

uses
  System.SysUtils,
  System.Classes,
  Base_DataModule,
  dbMaster;

type
  TDocumentazioneMessaggiRegistro = class(TBaseDataModule)
  protected
  public
    procedure VerificaRicevute;
  end;

var
  DocumentazioneMessaggiRegistro: TDocumentazioneMessaggiRegistro;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  dmCommon;
{$R *.dfm}

procedure TDocumentazioneMessaggiRegistro.VerificaRicevute;
begin
  // Polling on-demand: aggiorna stato/ricevute delle spedizioni ancora in attesa
  Common.PecBridge.VerificaRicevutePendenti;
end;

end.
