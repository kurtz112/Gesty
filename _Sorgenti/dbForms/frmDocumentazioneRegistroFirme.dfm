inherited FormDocumentazioneRegistroFirme: TFormDocumentazioneRegistroFirme
  Left = 0
  Top = 0
  Caption = 'Registro firme'
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
    Images = zDmImages.ImageList24
    Left = 288
    Top = 64
    object AggiornaStato: TAction
      Caption = 'Aggiorna Stato'
      ImageIndex = 126
      OnExecute = AggiornaStatoExecute
    end
  end
end
