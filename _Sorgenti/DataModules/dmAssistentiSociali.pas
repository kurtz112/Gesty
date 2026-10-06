// ---------------------------------------------------------------------------
// Copyright (c) 2026 Luca Zebro - Tutti i diritti riservati.
// Uso, copia e distribuzione non autorizzati sono vietati.
//
// Ultima modifica: 2026-09-27
// ---------------------------------------------------------------------------
unit dmAssistentiSociali;

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
  Base_DataModule;

type
  TAssistentiSociali= class(TBaseDataModule)
  end;

var
  AssistentiSociali: TAssistentiSociali;

implementation

{$R *.dfm}

end.
