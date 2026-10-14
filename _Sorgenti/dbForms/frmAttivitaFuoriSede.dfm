inherited FormAttivitaFuoriSede: TFormAttivitaFuoriSede
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  TextHeight = 15
  object dxLayoutControl: TdxLayoutControl [1]
    Left = 0
    Top = 32
    Width = 629
    Height = 73
    Align = alTop
    TabOrder = 5
    AutoSize = True
    object dxBarDockControl: TdxBarDockControl
      Left = 12
      Top = 24
      Width = 605
      Height = 36
      Align = dalNone
      BarManager = dxBarManager
    end
    object dxLayoutControlGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avTop
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutGrouptoolbar: TdxLayoutGroup
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 0
    end
    object dxLayoutItemBar: TdxLayoutItem
      Parent = dxLayoutGrouptoolbar
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = dxBarDockControl
      ControlOptions.OriginalHeight = 36
      ControlOptions.OriginalWidth = 809
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGrouptoolbar
      SizeOptions.Height = 5
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 0
    end
  end
  inherited dxBarManager: TdxBarManager
    Left = 212
    Top = 200
    PixelsPerInch = 96
    object dxBarManagerBar: TdxBar [3]
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl
      DockedDockControl = dxBarDockControl
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 657
      FloatTop = 2
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton5'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Action = Oggi
      Category = 0
    end
    object dxBarButton3: TdxBarButton
      Action = VaiAlGiorno
      Category = 0
    end
    object dxBarButton4: TdxBarButton
      Action = Precedente
      Category = 0
    end
    object dxBarButton5: TdxBarButton
      Action = Successiva
      Category = 0
    end
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object Actions: TActionList
    Images = dx.Immagini
    Left = 145
    Top = 168
    object Precedente: TAction
      Caption = 'Precedente'
      Hint = 'settimana precedente'
      ImageIndex = 171
      OnExecute = PrecedenteExecute
    end
    object Successiva: TAction
      Caption = 'Successiva'
      Hint = 'settimana successiva'
      ImageIndex = 163
      OnExecute = SuccessivaExecute
    end
    object Oggi: TAction
      Caption = 'Oggi'
      ImageIndex = 483
      OnExecute = OggiExecute
    end
    object VaiAlGiorno: TAction
      Caption = 'VaiAlGiorno'
      ImageIndex = 475
      OnExecute = VaiAlGiornoExecute
    end
  end
end
