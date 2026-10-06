// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-07-23
// ---------------------------------------------------------------------------
unit dmDocumentazioneConservazione;

// Registro conservazione a norma - DataModule (Gesty: TBaseDataModule).
// SCHELETRO: i dataset li aggiunge l'utente. Le SELECT gia' pronte (master
// "Pacchetti" + dettaglio "Documenti del pacchetto") sono nel commento di
// frmDocumentazioneConservazione.FormCreate.
// Le azioni operative delegano al ponte Common.ConservazioneBridge
// (Documentazione.Bridge.Conservazione).
// NB: finche' l'ente non configura un conservatore reale, il fornitore attivo
// e' vuoto: le azioni di versamento sollevano "Nessun conservatore configurato".
// Coppia con frmDocumentazioneConservazione (la griglia / vista unica).

interface

uses
  System.SysUtils,
  System.Classes,
  Base_DataModule,
  dbMaster;

type
  TDocumentazioneConservazione = class(TBaseDataModule)
    procedure DataModuleCreate(Sender: TObject);
  public
    // versa il pacchetto indicato (INS/RIF -> GEN -> INV)
    procedure VersaPacchetto(IdPacchetto: Int64);
    // porta avanti tutti i pacchetti del tenant ancora in attesa di esito ('INV')
    procedure VerificaPendenti;
  end;

var
  DocumentazioneConservazione: TDocumentazioneConservazione;

implementation

uses
  dmCommon; // Common.ConservazioneBridge

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TDocumentazioneConservazione.DataModuleCreate(Sender: TObject);
begin
  // Qui vanno i TzFbDataSet: master "Pacchetti" (filtro ID_TENANT =
  // Common.EnteDefault) + dettaglio "Documenti del pacchetto" (master/detail su
  // ID_CONSERVAZIONE_PACCHETTO). Le SELECT complete sono in
  // frmDocumentazioneConservazione.FormCreate.
end;

procedure TDocumentazioneConservazione.VersaPacchetto(IdPacchetto: Int64);
begin
  if IdPacchetto = 0 then
    exit;
  Common.ConservazioneBridge.VersaPacchetto(IdPacchetto);
  // dopo il versamento ricaricare il dataset master (una volta creato)
end;

procedure TDocumentazioneConservazione.VerificaPendenti;
begin
  Common.ConservazioneBridge.VerificaPendenti;
  // poi ricaricare il dataset master (una volta creato)
end;

end.
