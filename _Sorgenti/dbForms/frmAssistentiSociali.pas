// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-27
// ---------------------------------------------------------------------------
unit frmAssistentiSociali;

interface

uses
  WinApi.Windows,
  WinApi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Data.DB,
  zDbView,
  BaseFrm, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxBar, System.Actions, Vcl.ActnList, dxBarExtItems,
  cxClasses, cxLabel;

type
  TFormAssistentiSociali= class(TBaseForm)
  protected
    procedure CreateDataModule; override;
    procedure DestroyDataModule; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

var
  FormAssistentiSociali: TFormAssistentiSociali;

implementation

uses
  zDm_Images,
  dmAssistentiSociali;

{$R *.dfm}

procedure TFormAssistentiSociali.CreateDataModule;
begin
  inherited;
  CreateDM(TAssistentiSociali, AssistentiSociali);
end;

procedure TFormAssistentiSociali.DestroyDataModule;
begin
  inherited;
  FreeAndNil(AssistentiSociali);
end;

constructor TFormAssistentiSociali.Create(aOwner: TComponent);
begin
  inherited;
  ReportGroup := 'AssistentiSociali';
  Caption := 'Assistenti Sociali';
end;

end.
