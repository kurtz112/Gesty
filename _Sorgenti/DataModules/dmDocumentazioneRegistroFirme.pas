// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-07-24
// ---------------------------------------------------------------------------
unit dmDocumentazioneRegistroFirme;

// Registro firme (Gesty) - DataModule.
// Elenco delle registrazioni di firma (OBJ_FILES_FIRMA_REGISTRAZIONI) del tenant.
// SCHELETRO: il dataset master lo aggiunge l'utente (SELECT in
// frmDocumentazioneRegistroFirme.FormCreate).
// Coppia con frmDocumentazioneRegistroFirme.

interface

uses
  System.SysUtils,
  System.Classes,
  Base_DataModule,
  dbMaster;

type
  TDocumentazioneRegistroFirme = class(TBaseDataModule)
    procedure DataModuleCreate(Sender: TObject);
  public
    // polling di una registrazione (busta) ancora in firma ('D')
    procedure AggiornaStato(IdFirmaRegistrazione: Int64);
  end;

var
  DocumentazioneRegistroFirme: TDocumentazioneRegistroFirme;

implementation

uses
  dmCommon,                    // Common.EnteDefault
  Documentazione.Bridge.Firma; // ponte firma

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TDocumentazioneRegistroFirme.DataModuleCreate(Sender: TObject);
begin
  // Qui va il TzFbDataSet master sulle registrazioni firma, filtrato
  // ID_TENANT = Common.EnteDefault (SELECT completa in
  // frmDocumentazioneRegistroFirme.FormCreate).
end;

procedure TDocumentazioneRegistroFirme.AggiornaStato(IdFirmaRegistrazione: Int64);
var
  ponte: TDocumentazioneBridgeFirma;
begin
  if IdFirmaRegistrazione = 0 then
    exit;
  // in Gesty la firma non ha un accessore in dmCommon: creo il ponte al volo
  ponte := TDocumentazioneBridgeFirma.Create(nil);
  try
    ponte.IdTenant := Common.EnteDefault;
    ponte.AggiornaStatoRegistrazione(IdFirmaRegistrazione);
  finally
    FreeAndNil(ponte);
  end;
  // poi ricaricare il dataset master (una volta creato)
end;

end.
