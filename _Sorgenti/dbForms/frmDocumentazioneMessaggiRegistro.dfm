inherited FormDocumentazioneMessaggiRegistro: TFormDocumentazioneMessaggiRegistro
  Left = 0
  Top = 0
  Caption = 'Registro invii (PEC / mail)'
  ClientHeight = 500
  ClientWidth = 800
  ParentFont = False
  Font.Charset = ANSI_CHARSET
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 816
  ExplicitHeight = 539
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 392
    Top = 256
    object VerificaRicevute: TAction
      Caption = 'Verifica Ricevute'
      ImageIndex = 1554
      OnExecute = VerificaRicevuteExecute
    end
  end
end
