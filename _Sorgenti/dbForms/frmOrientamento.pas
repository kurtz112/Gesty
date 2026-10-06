// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-10-02
// ---------------------------------------------------------------------------
unit frmOrientamento;

// Form del modulo Orientamento: come tutte le form documentali di Gesty non contiene componenti,
// griglie e schede nascono dai metadati LZ del DataModule 'Orientamento'. Qui stanno solo le azioni.

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  zDbView,
  BaseFrm,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxBar,
  System.Actions,
  Vcl.ActnList,
  dxBarExtItems,
  cxClasses,
  cxLabel;

type
  TFormOrientamento = class(TBaseForm)
    ActionList: TActionList;
    RegistraInterazione: TAction;
    ConvertiInStudente: TAction;
    DestinatariAttivita: TAction;
    DestinatariScadenze: TAction;
    DestinatariStato: TAction;
    InviaComunicazioni: TAction;
    AttivaPlacement: TAction;
    procedure RegistraInterazioneExecute(Sender: TObject);
    procedure ConvertiInStudenteExecute(Sender: TObject);
    procedure DestinatariAttivitaExecute(Sender: TObject);
    procedure DestinatariScadenzeExecute(Sender: TObject);
    procedure DestinatariStatoExecute(Sender: TObject);
    procedure InviaComunicazioniExecute(Sender: TObject);
    procedure AttivaPlacementExecute(Sender: TObject);
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormOrientamento: TFormOrientamento;

implementation

uses
  zDm_Images,
  dmOrientamento;

{$R *.dfm}

procedure TFormOrientamento.CreateDataModule;
begin
  inherited;
  CreateDM(TOrientamento, Orientamento);
end;

procedure TFormOrientamento.DestroyDataModule;
begin
  inherited;
  FreeAndNil(Orientamento);
end;

constructor TFormOrientamento.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'Orientamento';
  Caption := 'Orientamento';
end;

procedure TFormOrientamento.RegistraInterazioneExecute(Sender: TObject);
begin
  inherited;
  Orientamento.RegistraInterazione;
end;

procedure TFormOrientamento.ConvertiInStudenteExecute(Sender: TObject);
begin
  inherited;
  Orientamento.ConvertiInStudente;
end;

procedure TFormOrientamento.DestinatariAttivitaExecute(Sender: TObject);
begin
  inherited;
  Orientamento.DestinatariAttivitaSelezionata;
end;

procedure TFormOrientamento.DestinatariScadenzeExecute(Sender: TObject);
begin
  inherited;
  Orientamento.DestinatariScadenzeNonRispettate;
end;

procedure TFormOrientamento.DestinatariStatoExecute(Sender: TObject);
begin
  inherited;
  Orientamento.DestinatariStessoStato;
end;

procedure TFormOrientamento.InviaComunicazioniExecute(Sender: TObject);
begin
  inherited;
  Orientamento.InviaComunicazioni;
end;

procedure TFormOrientamento.AttivaPlacementExecute(Sender: TObject);
begin
  inherited;
  Orientamento.AttivaPlacement;
end;

end.
