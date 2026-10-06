// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-07-24
// ---------------------------------------------------------------------------
unit frmDocumentazioneCruscotto;

// Cruscotto documentale (Gesty). Vista unica dei pendenti sui 4 motori.
// SCHELETRO: i pannelli/griglie di riepilogo li aggiunge l'utente.
// Coppia con dmDocumentazioneCruscotto.

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
  TFormDocumentazioneCruscotto = class(TBaseForm)
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
  dmDocumentazioneCruscotto,
  zDm_Images;

{$R *.dfm}

procedure TFormDocumentazioneCruscotto.CreateDataModule;
begin
  inherited;
  CreateDM(TDocumentazioneCruscotto, DocumentazioneCruscotto);
end;

procedure TFormDocumentazioneCruscotto.DestroyDataModule;
begin
  inherited;
  FreeAndNil(DocumentazioneCruscotto);
end;

procedure TFormDocumentazioneCruscotto.FormCreate(Sender: TObject);
begin
  inherited;
  Caption := 'Cruscotto documentale';
  ReportGroup := 'CruscottoDocumentale';
end;

procedure TFormDocumentazioneCruscotto.VerificaPendentiExecute(Sender: TObject);
begin
  inherited;
  DocumentazioneCruscotto.VerificaPendenti;
  Refresh;
end;

end.
