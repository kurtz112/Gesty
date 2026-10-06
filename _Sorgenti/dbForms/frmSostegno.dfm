inherited FormSostegno: TFormSostegno
  ClientWidth = 885
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 901
  TextHeight = 15
  object dxLayoutControl: TdxLayoutControl [1]
    Left = 0
    Top = 32
    Width = 885
    Height = 145
    Align = alTop
    TabOrder = 5
    AutoSize = True
    object edProgetto: TcxExtLookupComboBox
      Left = 76
      Top = 29
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.OnEditValueChanged = edProgettoPropertiesEditValueChanged
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 446
    end
    object edCorso: TcxExtLookupComboBox
      Left = 578
      Top = 29
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.OnEditValueChanged = edCorsoPropertiesEditValueChanged
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      TabOrder = 1
      Width = 278
    end
    object dxBarDockControl: TdxBarDockControl
      Left = 12
      Top = 91
      Width = 844
      Height = 36
      Align = dalNone
      BarManager = dxBarManager
    end
    object edDocente: TcxExtLookupComboBox
      Left = 76
      Top = 60
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
      TabOrder = 2
      Width = 780
    end
    object dxLayoutControlGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avTop
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemProgetto: TdxLayoutItem
      Parent = dxLayoutGroupProgetto
      AlignHorz = ahClient
      AlignVert = avCenter
      SizeOptions.AssignedValues = [sovSizableHorz]
      SizeOptions.SizableHorz = True
      CaptionOptions.Text = 'Progetto:'
      Control = edProgetto
      ControlOptions.OriginalHeight = 24
      ControlOptions.OriginalWidth = 145
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutGrouptoolbar: TdxLayoutGroup
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      ItemIndex = 4
      ShowBorder = False
      Index = 0
    end
    object dxLayoutItemCorso: TdxLayoutItem
      Parent = dxLayoutGroupProgetto
      AlignHorz = ahClient
      AlignVert = avCenter
      SizeOptions.AssignedValues = [sovSizableHorz]
      SizeOptions.SizableHorz = True
      CaptionOptions.Text = 'Corso:'
      Control = edCorso
      ControlOptions.OriginalHeight = 24
      ControlOptions.OriginalWidth = 90
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutGroupProgetto: TdxLayoutGroup
      Parent = dxLayoutGrouptoolbar
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutSplitterItem1: TdxLayoutSplitterItem
      Parent = dxLayoutGroupProgetto
      AlignVert = avCenter
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      CaptionOptions.Text = 'Splitter'
      Index = 1
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
      Index = 3
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
      ControlOptions.OriginalHeight = 24
      ControlOptions.OriginalWidth = 460
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGrouptoolbar
      SizeOptions.Height = 5
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 4
    end
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
    inherited barSistema: TdxBar
      DockedLeft = 182
    end
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
    Images = zDmImages.ImageList24
    Left = 145
    Top = 168
    object Precedente: TAction
      Caption = 'Precedente'
      Hint = 'settimana precedente'
      ImageIndex = 531
      OnExecute = PrecedenteExecute
    end
    object Successiva: TAction
      Caption = 'Successiva'
      Hint = 'settimana successiva'
      ImageIndex = 532
      OnExecute = SuccessivaExecute
    end
    object Oggi: TAction
      Caption = 'Oggi'
      ImageIndex = 533
      OnExecute = OggiExecute
    end
    object VaiAlGiorno: TAction
      Caption = 'VaiAlGiorno'
      ImageIndex = 534
      OnExecute = VaiAlGiornoExecute
    end
    object AggiungiStudenti: TAction
      Caption = 'Aggiungi Studenti'
      ImageIndex = 251
      OnExecute = AggiungiStudentiExecute
    end
    object GeneraIncarico: TAction
      Caption = 'Genera Incarico'
      ImageIndex = 246
      OnExecute = GeneraIncaricoExecute
    end
    object GeneraRilevamento: TAction
      Caption = 'Genera Rilevamento'
      ImageIndex = 125
      OnExecute = GeneraRilevamentoExecute
    end
    object Salva: TAction
      Caption = 'Salva'
      ImageIndex = 6
      Visible = False
    end
    object Firma: TAction
      Caption = 'Firma'
      ImageIndex = 384
      Visible = False
    end
  end
end
