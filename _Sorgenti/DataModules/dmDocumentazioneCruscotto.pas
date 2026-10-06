// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-07-24
// ---------------------------------------------------------------------------
unit dmDocumentazioneCruscotto;

// Cruscotto documentale (Gesty) - DataModule (TBaseDataModule).
// Vista d'insieme dei documenti in lavorazione sui 4 motori: firme in corso,
// PEC in attesa di ricevute, protocolli in attesa di numero, pacchetti di
// conservazione da versare / in attesa di esito.
// SCHELETRO: i dataset di conteggio/elenco li aggiunge l'utente (SELECT in
// frmDocumentazioneCruscotto.FormCreate). L'azione VerificaPendenti fa girare
// il polling di tutti i motori. Coppia con frmDocumentazioneCruscotto.

interface

uses
  System.SysUtils,
  System.Classes,
  Base_DataModule, dbMaster;

type
  TDocumentazioneCruscotto = class(TBaseDataModule)
    procedure DataModuleCreate(Sender: TObject);
  public
    // porta avanti tutti i pendenti dei motori asincroni del tenant
    procedure VerificaPendenti;
  end;

var
  DocumentazioneCruscotto: TDocumentazioneCruscotto;

implementation

uses
  dmCommon;   // Common.PecBridge / ProtocolloBridge / ConservazioneBridge

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TDocumentazioneCruscotto.DataModuleCreate(Sender: TObject);
begin
  // Qui vanno i dataset di riepilogo (conteggi/elenchi) per l'ente
  // Common.EnteDefault. SELECT suggerite nel commento di
  // frmDocumentazioneCruscotto.FormCreate.
end;

procedure TDocumentazioneCruscotto.VerificaPendenti;
begin
  // firma: polling per busta (nessun verifica-tutti globale); qui i motori
  // asincroni con verifica massiva:
  Common.PecBridge.VerificaRicevutePendenti;
  Common.ProtocolloBridge.VerificaPendenti;
  Common.ConservazioneBridge.VerificaPendenti;
  // poi ricaricare i dataset di riepilogo (una volta creati)
end;

end.
