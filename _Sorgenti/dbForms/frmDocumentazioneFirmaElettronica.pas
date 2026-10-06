// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-07-24
// ---------------------------------------------------------------------------
unit frmDocumentazioneFirmaElettronica;

// Firma documenti in uscita (Gesty). Griglia dei documenti firmabili + azione
// "Firma". SCHELETRO: griglia e dataset li aggiunge l'utente.
// Coppia con dmDocumentazioneFirmaElettronica.

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
  TFormDocumentazioneFirmaElettronica = class(TBaseForm)
    ActionList: TActionList;
    Firma: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FirmaExecute(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  end;

implementation

uses
  dmDocumentazioneFirmaElettronica,
  zDm_Images;

{$R *.dfm}

procedure TFormDocumentazioneFirmaElettronica.CreateDataModule;
begin
  inherited;
  CreateDM(TDocumentazioneFirmaElettronica, DocumentazioneFirmaElettronica);
end;

procedure TFormDocumentazioneFirmaElettronica.DestroyDataModule;
begin
  inherited;
  FreeAndNil(DocumentazioneFirmaElettronica);
end;

procedure TFormDocumentazioneFirmaElettronica.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Firma documenti';
  ReportGroup := 'FirmaDocumenti';
end;

procedure TFormDocumentazioneFirmaElettronica.FirmaExecute(Sender: TObject);
begin
  inherited;
  { TODO : Implementare: DocumentazioneFirmaElettronica.FirmaDocumento }
  // DocumentazioneFirmaElettronica.FirmaDocumento(<Oid>, <IdObjectFile>, <TipoDocumento> della riga selezionata);
  // poi Aggiorna.Execute per ricaricare la griglia
end;

end.


