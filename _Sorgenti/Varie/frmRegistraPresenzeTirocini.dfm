object FormRegistraPresenzeTirocini: TFormRegistraPresenzeTirocini
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Presenze'
  ClientHeight = 652
  ClientWidth = 907
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object dxLayoutControl: TdxLayoutControl
    Left = 0
    Top = 34
    Width = 907
    Height = 598
    Align = alClient
    TabOrder = 4
    AutoSize = True
    object viewSettimanale: TzDbView
      Left = 12
      Top = 12
      Width = 883
      Height = 240
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      ToolActions = <>
      ToolFilters = <>
    end
    object cardRiepilogoOre: TzDbCard
      Left = 12
      Top = 496
      Width = 883
      Height = 90
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentDoubleBuffered = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      ToolActions = <>
      LookupsEnabled = True
    end
    object viewPresenze: TzDbView
      Left = 12
      Top = 268
      Width = 883
      Height = 212
      Color = clBtnFace
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      ToolActions = <>
      ToolFilters = <>
    end
    object dxLayoutControlGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      ItemIndex = 2
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemViewSettimanale: TdxLayoutItem
      Parent = dxLayoutGroupViste
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Settimanale'
      CaptionOptions.Visible = False
      Control = viewSettimanale
      ControlOptions.OriginalHeight = 240
      ControlOptions.OriginalWidth = 743
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemCard: TdxLayoutItem
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahClient
      AlignVert = avBottom
      CaptionOptions.Text = 'cardRiepilogoOre'
      CaptionOptions.Visible = False
      Control = cardRiepilogoOre
      ControlOptions.AutoColor = True
      ControlOptions.OriginalHeight = 90
      ControlOptions.OriginalWidth = 751
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutSplitterItem: TdxLayoutSplitterItem
      Parent = dxLayoutControlGroup_Root
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      CaptionOptions.Text = 'Splitter'
      Index = 1
    end
    object dxLayoutItemViewPresenze: TdxLayoutItem
      Parent = dxLayoutGroupViste
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'Giornaliera'
      CaptionOptions.Visible = False
      Control = viewPresenze
      ControlOptions.OriginalHeight = 284
      ControlOptions.OriginalWidth = 889
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutGroupViste: TdxLayoutGroup
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'Nuovo gruppo'
      ItemIndex = 2
      ShowBorder = False
      Index = 0
    end
    object dxLayoutSplitterItem1: TdxLayoutSplitterItem
      Parent = dxLayoutGroupViste
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      CaptionOptions.Text = 'Divisore'
      Index = 1
    end
  end
  object dxStatusBar: TdxStatusBar
    Left = 0
    Top = 632
    Width = 907
    Height = 20
    Panels = <>
    LookAndFeel.NativeStyle = False
  end
  object Actions: TActionList
    Images = zDmImages.ImageList24
    Left = 96
    Top = 160
    object PrimoGiornoDaRendicontare: TAction
      Caption = 'Inizio Rendicontazione'
      ImageIndex = 533
      OnExecute = PrimoGiornoDaRendicontareExecute
    end
    object SelezionaGiorno: TAction
      Caption = 'Seleziona Giorno'
      Hint = 'seleziona giorno'
      ImageIndex = 534
      OnExecute = SelezionaGiornoExecute
    end
    object Precedente: TAction
      Caption = 'Precedente'
      ImageIndex = 531
      ShortCut = 16421
      OnExecute = PrecedenteExecute
    end
    object Successivo: TAction
      Caption = 'Successivo'
      ImageIndex = 532
      ShortCut = 16423
      OnExecute = SuccessivoExecute
    end
    object GeneraPresenze: TAction
      Caption = 'Genera Presenze'
      ImageIndex = 557
      SecondaryShortCuts.Strings = (
        'F9')
      ShortCut = 16455
      OnExecute = GeneraPresenzeExecute
    end
    object Chiudi: TAction
      Caption = 'Chiudi'
      ImageIndex = 12
      OnExecute = ChiudiExecute
    end
    object Giornaliera: TAction
      AutoCheck = True
      Caption = 'Giornaliera'
      GroupIndex = 1
      ImageIndex = 536
    end
    object Settimanale: TAction
      AutoCheck = True
      Caption = 'Settimanale'
      Checked = True
      GroupIndex = 1
      ImageIndex = 538
    end
  end
  object dxBarManager: TdxBarManager
    AllowReset = False
    AutoDockColor = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    DockColor = clBtnFace
    ImageOptions.Images = zDmImages.ImageList16
    ImageOptions.LargeImages = zDmImages.ImageList24
    ImageOptions.LargeIcons = True
    ImageOptions.UseLargeImagesForLargeIcons = True
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 96
    Top = 96
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      34
      0)
    object dxBarManagerBar: TdxBar
      Caption = 'Agenda'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 945
      FloatTop = 248
      FloatClientWidth = 124
      FloatClientHeight = 244
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
          ItemName = 'dxBarButtonSuccessivo'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton2'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object cxBarEditItem1: TcxBarEditItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      ShowCaption = True
      Width = 0
      PropertiesClassName = 'TcxCheckBoxProperties'
      Properties.ImmediatePost = True
    end
    object dxBarButtonVaiAlGiorno: TdxBarButton
      Action = SelezionaGiorno
      Category = 0
    end
    object dxBarButtonPrecedente: TdxBarButton
      Action = Precedente
      Category = 0
    end
    object dxBarButtonSuccessivo: TdxBarButton
      Action = Successivo
      Category = 0
    end
    object dxBarButton2: TdxBarButton
      Action = Chiudi
      Align = iaRight
      Category = 0
    end
    object dxBarButton3: TdxBarButton
      Action = GeneraPresenze
      Category = 0
    end
    object dxBarButton1: TdxBarButton
      Action = PrimoGiornoDaRendicontare
      Category = 0
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Scala'
      Category = 5
      Visible = ivAlways
      ImageIndex = 547
      LargeImageIndex = 547
      ItemLinks = <>
    end
  end
  object RiepilogoSrc: TDataSource
    Left = 96
    Top = 232
  end
end
