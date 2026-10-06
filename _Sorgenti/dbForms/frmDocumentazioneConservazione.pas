// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-07-23
// ---------------------------------------------------------------------------
unit frmDocumentazioneConservazione;

// Registro conservazione a norma - Gesty. Vista unica dei pacchetti di
// versamento (OBJ_FILES_CONSERVAZIONE_PACCHETTI) del tenant.
// SCHELETRO: griglia e dataset li aggiunge l'utente (vedi FormCreate).
// Coppia con dmDocumentazioneConservazione.

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
  TFormDocumentazioneConservazione = class(TBaseForm)
    ActionList: TActionList;
    VersaPacchetto: TAction;
    VerificaPendenti: TAction;
    procedure FormCreate(Sender: TObject);
    procedure VersaPacchettoExecute(Sender: TObject);
    procedure VerificaPendentiExecute(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public

  end;

implementation

uses
  dmDocumentazioneConservazione,
  zDm_Images;

{$R *.dfm}

procedure TFormDocumentazioneConservazione.CreateDataModule;
begin
  inherited;
  CreateDM(TDocumentazioneConservazione, DocumentazioneConservazione);
end;

procedure TFormDocumentazioneConservazione.DestroyDataModule;
begin
  inherited;
  FreeAndNil(DocumentazioneConservazione);
end;

procedure TFormDocumentazioneConservazione.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Registro conservazione';
  ReportGroup := 'Conservazione';
end;

procedure TFormDocumentazioneConservazione.VersaPacchettoExecute(Sender: TObject);
begin
  inherited;
  { TODO : Implementare: dmDocumentazioneConservazione.VersaPacchetto }
  // dmDocumentazioneConservazione.VersaPacchetto(<ID_CONSERVAZIONE_PACCHETTO selezionato>);
  // poi Aggiorna.Execute per ricaricare la griglia
end;

procedure TFormDocumentazioneConservazione.VerificaPendentiExecute(Sender: TObject);
begin
  inherited;
  DocumentazioneConservazione.VerificaPendenti;
  Refresh;
end;

end.



