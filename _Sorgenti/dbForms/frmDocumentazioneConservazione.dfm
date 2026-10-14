inherited FormDocumentazioneConservazione: TFormDocumentazioneConservazione
  Left = 0
  Top = 0
  Caption = 'Registro conservazione'
  ClientHeight = 316
  ClientWidth = 425
  ParentFont = False
  Font.Charset = ANSI_CHARSET
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 441
  ExplicitHeight = 355
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
    inherited barFree: TdxBar
      DockedLeft = 43
    end
    inherited barSistema: TdxBar
      DockedLeft = 74
    end
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 288
    Top = 64
    object VersaPacchetto: TAction
      Caption = 'Versa Pacchetto'
      ImageIndex = 1735
      OnExecute = VersaPacchettoExecute
    end
    object VerificaPendenti: TAction
      Caption = 'Verifica Pendenti'
      ImageIndex = 1734
      OnExecute = VerificaPendentiExecute
    end
  end
end
