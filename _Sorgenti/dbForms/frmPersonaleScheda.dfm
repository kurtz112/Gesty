inherited FormPersonaleScheda: TFormPersonaleScheda
  Caption = 'FormPersonaleScheda'
  ClientHeight = 664
  ClientWidth = 912
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 928
  ExplicitHeight = 703
  TextHeight = 15
  inherited dxBarManager: TdxBarManager [1]
    PixelsPerInch = 96
    inherited barFree: TdxBar
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end>
    end
    inherited barSistema: TdxBar
      DockedLeft = 219
    end
    object dxBarButton1: TdxBarButton
      Action = RilevamentoOre
      Category = 0
    end
  end
  inherited BaseActions: TActionList [2]
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList24
    Left = 224
    Top = 56
    object RilevamentoOre: TAction
      Caption = 'Rilevamento Ore'
      ImageIndex = 125
      OnExecute = RilevamentoOreExecute
    end
    object GeneraRilevamento: TAction
      Caption = 'Genera Rilevamento'
      ImageIndex = 125
      OnExecute = GeneraRilevamentoExecute
    end
    object IsDebug: TAction
      AutoCheck = True
      Caption = 'Risorsa Per Debug'
      ImageIndex = 440
      OnExecute = IsDebugExecute
      OnUpdate = IsDebugUpdate
    end
  end
end
