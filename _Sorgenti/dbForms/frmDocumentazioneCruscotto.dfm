inherited FormDocumentazioneCruscotto: TFormDocumentazioneCruscotto
  Left = 0
  Top = 0
  Caption = 'Cruscotto documentale'
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
    object VerificaPendenti: TAction
      Caption = 'Verifica Pendenti'
      ImageIndex = 46
      OnExecute = VerificaPendentiExecute
    end
  end
end
