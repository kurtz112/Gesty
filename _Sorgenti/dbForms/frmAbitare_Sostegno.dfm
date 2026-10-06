inherited FormAbitareSostegno: TFormAbitareSostegno
  ClientHeight = 465
  ClientWidth = 621
  ExplicitWidth = 633
  TextHeight = 15
  inherited dxBarManager: TdxBarManager
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
      DockedLeft = 182
    end
    object dxBarButton1: TdxBarButton
      Action = DownloadAllegati
      Category = 0
      LargeImageIndex = 556
    end
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Left = 224
    Top = 80
    object DownloadAllegati: TAction
      Caption = 'Download Allegati'
      ImageIndex = 556
      OnExecute = DownloadAllegatiExecute
      OnUpdate = DownloadAllegatiUpdate
    end
  end
end
