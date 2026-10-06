// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-07-24
// ---------------------------------------------------------------------------
unit frmDocumentazioneRegistroProtocollo;

// Registro protocollo in uscita (Gesty). Vista unica delle registrazioni
// (OBJ_FILES_PROTOCOLLO_REGISTRAZIONI). SCHELETRO: griglia e dataset li
// aggiunge l'utente. Coppia con dmDocumentazioneRegistroProtocollo.

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
  TFormDocumentazioneRegistroProtocollo = class(TBaseForm)
    ActionList: TActionList;
    VerificaPendenti: TAction;
    procedure FormCreate(Sender: TObject);
    procedure VerificaPendentiExecute(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  end;

implementation

uses
  dmDocumentazioneRegistroProtocollo,
  zDm_Images;

{$R *.dfm}

procedure TFormDocumentazioneRegistroProtocollo.CreateDataModule;
begin
  inherited;
  CreateDM(TDocumentazioneRegistroProtocollo, DocumentazioneRegistroProtocollo);
end;

procedure TFormDocumentazioneRegistroProtocollo.DestroyDataModule;
begin
  inherited;
  FreeAndNil(DocumentazioneRegistroProtocollo);
end;

procedure TFormDocumentazioneRegistroProtocollo.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Registro protocollo';
  ReportGroup := 'RegistroProtocollo';
end;

procedure TFormDocumentazioneRegistroProtocollo.VerificaPendentiExecute(Sender: TObject);
begin
  inherited;
  { TODO : Implementare: DocumentazioneRegistroProtocollo.VerificaPendenti; }
  DocumentazioneRegistroProtocollo.VerificaPendenti;
  Refresh;
end;

end.
