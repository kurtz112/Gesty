// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-07-24
// ---------------------------------------------------------------------------
unit dmDocumentazioneRegistroProtocollo;

// Registro protocollo in uscita (Gesty) - DataModule.
// Elenco delle registrazioni di protocollo (OBJ_FILES_PROTOCOLLO_REGISTRAZIONI).
// SCHELETRO: il dataset master lo aggiunge l'utente (SELECT in
// frmDocumentazioneRegistroProtocollo.FormCreate).
// NB: in Gesty il protocollo e' solo predisposto (fornitore NESSUNO): il
// registro puo' risultare vuoto finche' non si configura un fornitore.
// Coppia con frmDocumentazioneRegistroProtocollo.

interface

uses
  System.SysUtils,
  System.Classes,
  Base_DataModule,
  dbMaster;

type
  TDocumentazioneRegistroProtocollo = class(TBaseDataModule)
    procedure DataModuleCreate(Sender: TObject);
  public
    // porta avanti le registrazioni in attesa di numero ('A' -> 'K')
    procedure VerificaPendenti;
  end;

var
  DocumentazioneRegistroProtocollo: TDocumentazioneRegistroProtocollo;

implementation

uses
  dmCommon;   // Common.ProtocolloBridge

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TDocumentazioneRegistroProtocollo.DataModuleCreate(Sender: TObject);
begin
  // Qui va il TzFbDataSet master sulle registrazioni protocollo, filtrato
  // ID_TENANT = Common.EnteDefault (SELECT completa in
  // frmDocumentazioneRegistroProtocollo.FormCreate).
end;

procedure TDocumentazioneRegistroProtocollo.VerificaPendenti;
begin
  Common.ProtocolloBridge.VerificaPendenti;
  // poi ricaricare il dataset master (una volta creato)
end;

end.
