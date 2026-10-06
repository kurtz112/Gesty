// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-07-24
// ---------------------------------------------------------------------------
unit dmDocumentazioneProtocolloImport;

// Import protocollo in entrata (Gesty) - DataModule (TBaseDataModule).
// PREDISPOSIZIONE / SCHELETRO INERTE: in Gesty il protocollo non ha ancora un
// fornitore attivo (solo NESSUNO), quindi qui NON ci sono ancora i metodi di
// import operativi (a differenza di WinTarif, dove il ponte Maggioli espone
// ImportaPer{Soggetto,Intestatario,Periodo} / ImportaInGeDo).
//
// Quando Gesty avra' un fornitore di protocollo con capacita' di import, si
// aggiungeranno: i metodi sul ponte Documentazione.Bridge.Protocollo, le
// tabelle OBJ_FILES_PROTOCOLLO_IMPORT* (come in WT) e i metodi qui che vi
// delegano. Per ora la unit esiste solo come aggancio futuro.

interface

uses
  System.SysUtils,
  System.Classes,
  Base_DataModule;

type
  TDocumentazioneProtocolloImport = class(TBaseDataModule)
    procedure DataModuleCreate(Sender: TObject);
  public
    // disponibile solo quando esistera' un fornitore protocollo con import
    function ImportDisponibile: Boolean;
  end;

var
  DocumentazioneProtocolloImport: TDocumentazioneProtocolloImport;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TDocumentazioneProtocolloImport.DataModuleCreate(Sender: TObject);
begin
  // Nulla per ora: predisposizione. Quando ci sara' l'import, qui andranno
  // i TzFbDataSet su OBJ_FILES_PROTOCOLLO_IMPORT* (da creare come in WT).
end;

function TDocumentazioneProtocolloImport.ImportDisponibile: Boolean;
begin
  // in Gesty nessun fornitore protocollo con import: sempre False finche' non
  // se ne configura uno (allora si aggancera' a Documentazione.Bridge.Protocollo)
  result := False;
end;

end.
