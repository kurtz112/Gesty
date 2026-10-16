inherited FormAgenda: TFormAgenda
  Caption = 'Agenda'
  ClientHeight = 569
  ClientWidth = 1045
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 1061
  ExplicitHeight = 608
  TextHeight = 15
  object FrameScheduler: TzDbScheduler [1]
    Left = 200
    Top = 69
    Width = 500
    Height = 500
    TabOrder = 5
    ToolActions = <>
    ToolFilters = <>
  end
  inherited dxBarManager: TdxBarManager [2]
    Left = 60
    Top = 72
    PixelsPerInch = 96
    inherited barSistema: TdxBar
      DockedLeft = 410
    end
    object dxBarManagerBarAgenda: TdxBar [3]
      Caption = 'Agenda'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsNone
      FloatLeft = 1069
      FloatTop = 8
      FloatClientWidth = 78
      FloatClientHeight = 216
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarLargeButton5'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton7'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton9'
        end
        item
          Visible = True
          ItemName = 'dxBarLargeButton8'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = False
      WholeRow = False
    end
    object dxBarButton7: TdxBarButton
      Caption = 'Giornaliera'
      Category = 0
      Hint = 'visualizza agenda giornaliera'
      Visible = ivAlways
    end
    object dxBarButton8: TdxBarButton
      Caption = 'Mensile'
      Category = 0
      Hint = 'visualizza agenda mensile'
      Visible = ivAlways
    end
    object dxBarButton9: TdxBarButton
      Caption = 'Lavorativa'
      Category = 0
      Hint = 'visualizza settimana lavorativa'
      Visible = ivAlways
    end
    object dxBarButton10: TdxBarButton
      Caption = 'Settimanale'
      Category = 0
      Hint = 'visualizza agenda settimanale'
      Visible = ivAlways
    end
    object dxBarButton11: TdxBarButton
      Caption = 'Risorse'
      Category = 0
      Visible = ivAlways
    end
    object dxBarButton12: TdxBarButton
      Caption = 'Esporta'
      Category = 0
      Visible = ivAlways
      ImageIndex = 2155
    end
    object dxBarLargeButton2: TdxBarLargeButton
      Caption = 'Lavorativa'
      Category = 0
      Hint = 'visualizza settimana lavorativa'
      Visible = ivAlways
    end
    object dxBarLargeButton3: TdxBarLargeButton
      Caption = 'Settimanale'
      Category = 0
      Hint = 'visualizza agenda settimanale'
      Visible = ivAlways
    end
    object dxBarLargeButton4: TdxBarLargeButton
      Caption = 'Mensile'
      Category = 0
      Hint = 'visualizza agenda mensile'
      Visible = ivAlways
    end
    object dxBarLargeButton5: TdxBarLargeButton
      Caption = 'Giornaliera'
      Category = 0
      Hint = 'visualizza agenda giornaliera'
      Visible = ivAlways
      LargeImageIndex = 1078
    end
    object dxBarLargeButton6: TdxBarLargeButton
      Caption = 'Docenti'
      Category = 0
      Visible = ivAlways
      LargeImageIndex = 1344
    end
    object dxBarLargeButton7: TdxBarLargeButton
      Caption = 'Lavorativa'
      Category = 0
      Hint = 'visualizza settimana lavorativa'
      Visible = ivAlways
      LargeImageIndex = 485
    end
    object dxBarLargeButton8: TdxBarLargeButton
      Caption = 'Mensile'
      Category = 0
      Hint = 'visualizza agenda mensile'
      Visible = ivAlways
      LargeImageIndex = 478
    end
    object dxBarLargeButton9: TdxBarLargeButton
      Caption = 'Settimanale'
      Category = 0
      Hint = 'visualizza agenda settimanale'
      Visible = ivAlways
      LargeImageIndex = 484
    end
  end
  inherited BaseActions: TActionList [3]
    Left = 60
    Top = 136
  end
  inherited popActions: TdxBarPopupMenu
    Left = 60
    Top = 200
    PixelsPerInch = 96
  end
  object flagActions: TActionList
    Left = 56
    Top = 296
    object MostraLezioni: TAction
      AutoCheck = True
      Caption = 'Lezioni'
      Hint = 'mostra lezioni'
      ImageIndex = 1004
      OnExecute = MostraLezioniExecute
      OnUpdate = MostraLezioniUpdate
    end
    object MostraRilevamenti: TAction
      AutoCheck = True
      Caption = 'Rilevamenti'
      Hint = 'mostra rilevamenti'
      ImageIndex = 1030
      OnExecute = MostraRilevamentiExecute
      OnUpdate = MostraRilevamentiUpdate
    end
    object MostraRiunioni: TAction
      AutoCheck = True
      Caption = 'MostraRiunioni'
      ImageIndex = 2283
      OnExecute = MostraRiunioniExecute
      OnUpdate = MostraRiunioniUpdate
    end
    object MostraAgendaPersonale: TAction
      AutoCheck = True
      Caption = 'MostraAgendaPersonale'
      ImageIndex = 2161
      OnExecute = MostraAgendaPersonaleExecute
      OnUpdate = MostraAgendaPersonaleUpdate
    end
    object MostraPrenotazioniAule: TAction
      AutoCheck = True
      Caption = 'MostraPrenotazioniAule'
      ImageIndex = 2324
      OnExecute = MostraPrenotazioniAuleExecute
      OnUpdate = MostraPrenotazioniAuleUpdate
    end
    object MostraChiusureSedi: TAction
      AutoCheck = True
      Caption = 'MostraChiusureSedi'
      ImageIndex = 2318
      OnExecute = MostraChiusureSediExecute
      OnUpdate = MostraChiusureSediUpdate
    end
    object MostraInagibilitaAule: TAction
      AutoCheck = True
      Caption = 'MostraInagibilitaAule'
      ImageIndex = 2273
      OnExecute = MostraInagibilitaAuleExecute
      OnUpdate = MostraInagibilitaAuleUpdate
    end
    object MostraPresenzePersonale: TAction
      AutoCheck = True
      Caption = 'MostraPresenzePersonale'
      ImageIndex = 2293
      OnExecute = MostraPresenzePersonaleExecute
      OnUpdate = MostraPresenzePersonaleUpdate
    end
    object MostraScadenze: TAction
      AutoCheck = True
      Caption = 'MostraScadenze'
      ImageIndex = 2243
      OnExecute = MostraScadenzeExecute
      OnUpdate = MostraScadenzeUpdate
    end
    object MostraFuoriSede: TAction
      AutoCheck = True
      Caption = 'MostraFuoriSede'
      ImageIndex = 2329
      OnExecute = MostraFuoriSedeExecute
      OnUpdate = MostraFuoriSedeUpdate
    end
    object MostraAssenze: TAction
      AutoCheck = True
      Caption = 'MostraAssenze'
      OnExecute = MostraAssenzeExecute
      OnUpdate = MostraAssenzeUpdate
    end
  end
end
