// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-07-24
// ---------------------------------------------------------------------------
unit frmDocumentazioneRegistroFirme;

// Registro firme (Gesty). Vista unica delle registrazioni di firma
// (OBJ_FILES_FIRMA_REGISTRAZIONI). SCHELETRO: griglia e dataset li aggiunge
// l'utente (vedi FormCreate). Coppia con dmDocumentazioneRegistroFirme.

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
  TFormDocumentazioneRegistroFirme = class(TBaseForm)
    ActionList: TActionList;
    AggiornaStato: TAction;
    procedure FormCreate(Sender: TObject);
    procedure AggiornaStatoExecute(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  end;

implementation

uses
  dmDocumentazioneRegistroFirme;

{$R *.dfm}

procedure TFormDocumentazioneRegistroFirme.CreateDataModule;
begin
  inherited;
  CreateDM(TDocumentazioneRegistroFirme, DocumentazioneRegistroFirme);
end;

procedure TFormDocumentazioneRegistroFirme.DestroyDataModule;
begin
  inherited;
  FreeAndNil(DocumentazioneRegistroFirme);
end;

procedure TFormDocumentazioneRegistroFirme.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Registro firme';
  ReportGroup := 'RegistroFirme';
end;

procedure TFormDocumentazioneRegistroFirme.AggiornaStatoExecute(Sender: TObject);
begin
  inherited;
  { TODO : Implementare: DocumentazioneRegistroFirme.AggiornaStato }
  // DocumentazioneRegistroFirme.AggiornaStato(<ID_FIRMA_REGISTRAZIONE selezionato>);
  // poi Aggiorna.Execute per ricaricare la griglia
end;

end.
