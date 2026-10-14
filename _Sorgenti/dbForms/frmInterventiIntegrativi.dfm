inherited FormInterventiIntegrativi: TFormInterventiIntegrativi
  Caption = 'FormInterventiIntegrativi'
  ClientWidth = 992
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 1008
  TextHeight = 15
  object dxLayoutControl: TdxLayoutControl [1]
    Left = 0
    Top = 30
    Width = 992
    Height = 90
    Align = alTop
    TabOrder = 5
    object dxBarDockControl: TdxBarDockControl
      Left = 12
      Top = 61
      Width = 951
      Height = 34
      Align = dalNone
      BarManager = dxBarManager
    end
    object edDocente: TcxExtLookupComboBox
      Left = 76
      Top = 29
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.OnEditValueChanged = edDocentePropertiesEditValueChanged
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 887
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
      ControlOptions.OriginalHeight = 34
      ControlOptions.OriginalWidth = 809
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGrouptoolbar
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 0
    end
    object dxLayoutItemFormatore: TdxLayoutItem
      Parent = dxLayoutGrouptoolbar
      AlignHorz = ahClient
      CaptionOptions.Text = 'Formatore:'
      Control = edDocente
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 460
      ControlOptions.ShowBorder = False
      Index = 1
    end
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
    object dxBarManagerBar: TdxBar [3]
      Caption = 'Bar'
      CaptionButtons = <>
      DockControl = dxBarDockControl
      DockedDockControl = dxBarDockControl
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1274
      FloatTop = 283
      FloatClientWidth = 155
      FloatClientHeight = 207
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButtonOggi'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButtonVaiAlGiorno'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButtonPrecedente'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButtonSuccessiva'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButtonSalva'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButtonFirma'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object dxBarButtonPermessiAzione: TdxBarButton
      Action = actPermessiAzione
      Category = 0
    end
    object dxBarButtonOggi: TdxBarButton
      Action = Oggi
      Category = 0
    end
    object dxBarButtonVaiAlGiorno: TdxBarButton
      Action = VaiAlGiorno
      Category = 0
    end
    object dxBarButtonPrecedente: TdxBarButton
      Action = Precedente
      Category = 0
    end
    object dxBarButtonSuccessiva: TdxBarButton
      Action = Successiva
      Category = 0
    end
    object dxBarButtonSalva: TdxBarButton
      Action = Salva
      Category = 0
    end
    object dxBarButtonFirma: TdxBarButton
      Action = Firma
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
    object AggiungiStudenti: TAction
      Caption = 'Aggiungi Studenti'
      ImageIndex = 1345
      OnExecute = AggiungiStudentiExecute
    end
    object GeneraIncarico: TAction
      Caption = 'Genera Incarico'
      ImageIndex = 1498
      OnExecute = GeneraIncaricoExecute
    end
    object GeneraRilevamento: TAction
      Caption = 'Genera Rilevamento'
      ImageIndex = 1606
      OnExecute = GeneraRilevamentoExecute
    end
    object Salva: TAction
      Caption = 'Salva'
      ImageIndex = 92
      Visible = False
    end
    object Firma: TAction
      Caption = 'Firma'
      ImageIndex = 985
      Visible = False
    end
  end
end
