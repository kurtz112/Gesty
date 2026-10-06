inherited FrameRegistroCollettivo: TFrameRegistroCollettivo
  Width = 1195
  Height = 611
  ParentFont = False
  ExplicitWidth = 1195
  ExplicitHeight = 611
  object dxLayoutControl: TdxLayoutControl [0]
    Left = 0
    Top = 0
    Width = 1195
    Height = 611
    Align = alClient
    TabOrder = 0
    object treeRegistro: TcxTreeList
      AlignWithMargins = True
      Left = 12
      Top = 183
      Width = 1171
      Height = 389
      Margins.Left = 7
      Margins.Top = 7
      Margins.Right = 7
      Margins.Bottom = 7
      BorderStyle = cxcbsNone
      Bands = <
        item
        end>
      LookAndFeel.Kind = lfFlat
      OptionsBehavior.AlwaysShowEditor = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.GoToNextCellOnTab = True
      OptionsBehavior.ChangeDelay = 1000
      OptionsBehavior.ExpandOnIncSearch = True
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = treeRegistroColStudente
      OptionsBehavior.MultiSort = False
      OptionsBehavior.Sorting = False
      OptionsCustomizing.BandCustomizing = False
      OptionsCustomizing.BandHorzSizing = False
      OptionsCustomizing.BandMoving = False
      OptionsCustomizing.BandVertSizing = False
      OptionsCustomizing.ColumnCustomizing = False
      OptionsCustomizing.ColumnMoving = False
      OptionsCustomizing.ColumnVertSizing = False
      OptionsCustomizing.DynamicSizing = True
      OptionsCustomizing.NestedBands = False
      OptionsCustomizing.StackedColumns = False
      OptionsData.CaseInsensitive = True
      OptionsData.Deleting = False
      OptionsData.ImmediatePost = True
      OptionsData.MultiThreadedSorting = bFalse
      OptionsView.ScrollBars = ssVertical
      OptionsView.DropNodeIndicator = True
      OptionsView.FixedSeparatorColor = clNone
      OptionsView.FixedSeparatorWidth = 0
      OptionsView.GridLineColor = clInactiveBorder
      OptionsView.GridLines = tlglBoth
      OptionsView.HeaderAutoHeight = True
      OptionsView.PaintStyle = tlpsCategorized
      OptionsView.ShowRoot = False
      PopupMenus.ColumnHeaderMenu.UseBuiltInMenu = True
      PopupMenus.FooterMenu.UseBuiltInMenu = True
      PopupMenus.GroupFooterMenu.UseBuiltInMenu = True
      ScrollbarAnnotations.CustomAnnotations = <>
      Styles.UseOddEvenStyles = bTrue
      TabOrder = 6
      OnClick = treeRegistroClick
      OnColumnSizeChanged = treeRegistroColumnSizeChanged
      OnCustomDrawDataCell = treeRegistroCustomDrawDataCell
      OnInitEdit = treeRegistroInitEdit
      OnLeftPosChanged = treeRegistroLeftPosChanged
      object treeRegistroColStudente: TcxTreeListColumn
        Caption.Text = 'Studente'
        MinWidth = 250
        Options.Editing = False
        Width = 250
        Position.ColIndex = 0
        Position.RowIndex = 0
        Position.BandIndex = 0
      end
      object treeRegistroColStatoPresenza: TcxTreeListColumn
        PropertiesClassName = 'TcxCheckBoxProperties'
        RepositoryItem = cxEditRepositoryStatoPresenza
        Caption.Text = 'Presente'
        MinWidth = 150
        Options.Sizing = False
        Width = 150
        Position.ColIndex = 1
        Position.RowIndex = 0
        Position.BandIndex = 0
      end
      object treeRegistroColFAD: TcxTreeListColumn
        RepositoryItem = cxEditRepositoryFAD
        BestFitMaxWidth = 35
        Caption.Text = 'FAD'
        MinWidth = 35
        Options.Sizing = False
        Width = 35
        Position.ColIndex = 2
        Position.RowIndex = 0
        Position.BandIndex = 0
      end
      object treeRegistroColOrePresenza: TcxTreeListColumn
        RepositoryItem = cxEditRepositoryTotaleOre
        Caption.Text = 'N'#176' Ore'
        DataBinding.ValueType = 'Smallint'
        MinWidth = 50
        Options.Editing = False
        Width = 50
        Position.ColIndex = 3
        Position.RowIndex = 0
        Position.BandIndex = 0
      end
    end
    object treeMaterie: TcxTreeList
      AlignWithMargins = True
      Left = 12
      Top = 102
      Width = 1171
      Height = 65
      Margins.Left = 7
      Margins.Top = 7
      Margins.Right = 7
      Margins.Bottom = 7
      BorderStyle = cxcbsNone
      Bands = <
        item
          Caption.Text = 'Studente'
          Width = 395
        end
        item
          Caption.Text = 'Ora 1'
          Width = 150
        end>
      LookAndFeel.Kind = lfFlat
      OptionsBehavior.AlwaysShowEditor = True
      OptionsBehavior.CellHints = True
      OptionsBehavior.GoToNextCellOnEnter = True
      OptionsBehavior.GoToNextCellOnTab = True
      OptionsBehavior.ChangeDelay = 1000
      OptionsBehavior.CopyCaptionsToClipboard = False
      OptionsBehavior.ExpandOnIncSearch = True
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = treeMaterieOraInizio1
      OptionsBehavior.MultiSort = False
      OptionsBehavior.Sorting = False
      OptionsCustomizing.BandCustomizing = False
      OptionsCustomizing.BandHorzSizing = False
      OptionsCustomizing.BandMoving = False
      OptionsCustomizing.BandVertSizing = False
      OptionsCustomizing.ColumnCustomizing = False
      OptionsCustomizing.ColumnHorzSizing = False
      OptionsCustomizing.ColumnMoving = False
      OptionsCustomizing.ColumnVertSizing = False
      OptionsCustomizing.NestedBands = False
      OptionsCustomizing.StackedColumns = False
      OptionsData.CaseInsensitive = True
      OptionsData.Deleting = False
      OptionsData.MultiThreadedSorting = bFalse
      OptionsSelection.InvertSelect = False
      OptionsView.ScrollBars = ssNone
      OptionsView.DropNodeIndicator = True
      OptionsView.FixedSeparatorColor = clNone
      OptionsView.FixedSeparatorWidth = 0
      OptionsView.GridLineColor = clInactiveBorder
      OptionsView.GridLines = tlglBoth
      OptionsView.HeaderAutoHeight = True
      OptionsView.Headers = False
      OptionsView.PaintStyle = tlpsCategorized
      OptionsView.ShowRoot = False
      PopupMenus.ColumnHeaderMenu.UseBuiltInMenu = True
      PopupMenus.FooterMenu.UseBuiltInMenu = True
      PopupMenus.GroupFooterMenu.UseBuiltInMenu = True
      ScrollbarAnnotations.CustomAnnotations = <>
      TabOrder = 5
      OnDblClick = treeMaterieDblClick
      OnGetCellHint = treeMaterieGetCellHint
      OnLeftPosChanged = treeMaterieLeftPosChanged
      Data = {
        00000500090100000F00000044617461436F6E74726F6C6C6572310700000012
        000000546378537472696E6756616C7565547970651200000054637853747269
        6E6756616C75655479706512000000546378537472696E6756616C7565547970
        6512000000546378537472696E6756616C756554797065120000005463785374
        72696E6756616C75655479706512000000546378537472696E6756616C756554
        79706512000000546378537472696E6756616C75655479706502000000445855
        464D5401445855464D5401020000000000000008080000000000000000FFFFFF
        FFFFFFFFFFFFFFFFFF0100000008080000000000000000FFFFFFFFFFFFFFFFFF
        FFFFFF1A0802000000}
      object treeMaterieColonnaVuota: TcxTreeListColumn
        Options.Editing = False
        Width = 135
        Position.ColIndex = 0
        Position.RowIndex = 0
        Position.BandIndex = 0
      end
      object treeMaterieMateria1: TcxTreeListColumn
        RepositoryItem = cxEditRepositoryMateria
        Caption.Text = 'Materia'
        Width = 100
        Position.ColIndex = 0
        Position.RowIndex = 0
        Position.BandIndex = 1
      end
      object treeMaterieDocente1: TcxTreeListColumn
        Caption.Text = 'Docente'
        Width = 100
        Position.ColIndex = 0
        Position.RowIndex = 1
        Position.BandIndex = 1
      end
      object treeMaterieOraInizio1: TcxTreeListColumn
        RepositoryItem = cxEditRepositoryOra
        Caption.Text = 'Ora Inizio'
        MinWidth = 50
        Width = 50
        Position.ColIndex = 0
        Position.RowIndex = 2
        Position.BandIndex = 1
      end
      object treeMaterieOraFine1: TcxTreeListColumn
        RepositoryItem = cxEditRepositoryOra
        Caption.Text = 'Ora Fine'
        MinWidth = 50
        Width = 50
        Position.ColIndex = 1
        Position.RowIndex = 2
        Position.BandIndex = 1
      end
      object treeMaterieOraBuca1: TcxTreeListColumn
        RepositoryItem = cxEditRepositoryCheckBox
        Caption.Text = 'Ora Buca'
        MinWidth = 50
        Width = 50
        Position.ColIndex = 2
        Position.RowIndex = 2
        Position.BandIndex = 1
      end
      object treeMaterieIncarichiMancanti1: TcxTreeListColumn
        RepositoryItem = cxEditRepositoryCheckBox
        Position.ColIndex = 3
        Position.RowIndex = 2
        Position.BandIndex = 1
      end
    end
    object cxScrollBar: TcxScrollBar
      Left = 12
      Top = 579
      Width = 1171
      Height = 20
      Ctl3D = True
      PageSize = 0
      ParentCtl3D = False
      OnChange = cxScrollBarChange
    end
    object edProgetto: TcxExtLookupComboBox
      Left = 291
      Top = 29
      ParentFont = False
      Properties.OnEditValueChanged = edProgettoPropertiesEditValueChanged
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      TabOrder = 1
      Width = 393
    end
    object edCorso: TcxExtLookupComboBox
      Left = 906
      Top = 29
      ParentFont = False
      Properties.OnEditValueChanged = edCorsoPropertiesEditValueChanged
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      TabOrder = 3
      Width = 267
    end
    object dxBarDockControl: TdxBarDockControl
      Left = 12
      Top = 61
      Width = 1171
      Height = 34
      Align = dalNone
      BarManager = dxBarManager
    end
    object edEnte: TcxExtLookupComboBox
      Left = 54
      Top = 29
      ParentFont = False
      Properties.OnEditValueChanged = edFiltroEntePropertiesEditValueChanged
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 175
    end
    object edProgettoCodReg: TcxExtLookupComboBox
      Left = 700
      Top = 29
      ParentFont = False
      Properties.OnEditValueChanged = edProgettoCodRegPropertiesEditValueChanged
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      TabOrder = 2
      Width = 150
    end
    object dxLayoutControlGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemRegistro: TdxLayoutItem
      Parent = dxLayoutGroupCollettiva
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'Registro'
      CaptionOptions.Visible = False
      Control = treeRegistro
      ControlOptions.OriginalHeight = 266
      ControlOptions.OriginalWidth = 1167
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemMaterie: TdxLayoutItem
      Parent = dxLayoutGroupCollettiva
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = treeMaterie
      ControlOptions.OriginalHeight = 65
      ControlOptions.OriginalWidth = 1164
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemScrollbar: TdxLayoutItem
      Parent = dxLayoutGroupCollettiva
      AlignHorz = ahClient
      AlignVert = avBottom
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = cxScrollBar
      ControlOptions.OriginalHeight = 20
      ControlOptions.OriginalWidth = 1167
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutGroupCollettiva: TdxLayoutGroup
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.ImageIndex = 165
      CaptionOptions.Text = 'Formazione Collettiva'
      CaptionOptions.Visible = False
      ShowBorder = False
      Index = 1
    end
    object dxLayoutItemProgetto: TdxLayoutItem
      Parent = dxLayoutGroup2
      AlignHorz = ahClient
      AlignVert = avCenter
      SizeOptions.AssignedValues = [sovSizableHorz]
      SizeOptions.SizableHorz = True
      CaptionOptions.Text = 'Progetto:'
      Control = edProgetto
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 145
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGrouptoolbar: TdxLayoutGroup
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      ItemIndex = 1
      ShowBorder = False
      Index = 0
    end
    object dxLayoutItemCorso: TdxLayoutItem
      Parent = dxLayoutGroup1
      AlignHorz = ahClient
      AlignVert = avCenter
      SizeOptions.AssignedValues = [sovSizableHorz]
      SizeOptions.SizableHorz = True
      CaptionOptions.Text = 'Corso:'
      Control = edCorso
      ControlOptions.OriginalHeight = 25
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
      ItemIndex = 3
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
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
    object dxLayoutSplitterItem2: TdxLayoutSplitterItem
      Parent = dxLayoutGroupCollettiva
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      CaptionOptions.Text = 'Splitter'
      Index = 1
    end
    object dxLayoutItemEnte: TdxLayoutItem
      Parent = dxLayoutGroup2
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Ente:'
      Control = edEnte
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 175
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemProgettoCodReg: TdxLayoutItem
      Parent = dxLayoutGroup1
      AlignHorz = ahLeft
      CaptionOptions.Text = 'Id Progetto:'
      CaptionOptions.Visible = False
      Control = edProgettoCodReg
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 150
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutSplitterItem3: TdxLayoutSplitterItem
      Parent = dxLayoutGroupProgetto
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      CaptionOptions.Text = 'Splitter'
      Index = 2
    end
    object dxLayoutGroup1: TdxLayoutGroup
      Parent = dxLayoutGroupProgetto
      AlignHorz = ahClient
      CaptionOptions.Text = 'New Group'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 3
    end
    object dxLayoutGroup2: TdxLayoutGroup
      Parent = dxLayoutGroupProgetto
      AlignHorz = ahClient
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupProgetto
      SizeOptions.Height = 10
      SizeOptions.Width = 3
      CaptionOptions.Text = 'Empty Space Item'
      Index = 0
    end
    object dxLayoutEmptySpaceItem3: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupProgetto
      SizeOptions.Height = 10
      SizeOptions.Width = 3
      CaptionOptions.Text = 'Empty Space Item'
      Index = 4
    end
    object dxLayoutSplitterItem1: TdxLayoutSplitterItem
      Parent = dxLayoutGroup1
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      CaptionOptions.Text = 'Splitter'
      Index = 1
    end
  end
  object pnlSeparatoreUno: TPanel [1]
    Left = 560
    Top = 270
    Width = 50
    Height = 19
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
  end
  object pnlSeparatoreDue: TPanel [2]
    Left = -8
    Top = 8
    Width = 50
    Height = 19
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
  end
  inherited dxBarManager: TdxBarManager
    OnBarVisibleChange = nil
    Left = 384
    Top = 312
    PixelsPerInch = 96
    object dxBarManagerBar: TdxBar [0]
      Caption = 'Registro'
      CaptionButtons = <>
      DockControl = dxBarDockControl
      DockedDockControl = dxBarDockControl
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1069
      FloatTop = 8
      FloatClientWidth = 78
      FloatClientHeight = 216
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
          Visible = True
          ItemName = 'dxBarControlContainerItem'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButtonForzaTipologiaFormazione'
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
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButtonBloccaPresenze'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarControlContainerItem1'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton1'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object btnMinuti0: TdxBarButton
      Caption = '0 minuti'
      Category = 0
      Hint = '0 minuti'
      Visible = ivAlways
      ButtonStyle = bsChecked
      GroupIndex = 1
      OnClick = btnMinutiAssenzaClick
    end
    object btnMinuti15: TdxBarButton
      Tag = 15
      Caption = '15 minuti '
      Category = 0
      Hint = '15 minuti '
      Visible = ivAlways
      ButtonStyle = bsChecked
      GroupIndex = 1
      OnClick = btnMinutiAssenzaClick
    end
    object btnMinuti30: TdxBarButton
      Tag = 30
      Caption = '30 minuti '
      Category = 0
      Hint = '30 minuti '
      Visible = ivAlways
      ButtonStyle = bsChecked
      GroupIndex = 1
      OnClick = btnMinutiAssenzaClick
    end
    object btnMinuti45: TdxBarButton
      Tag = 45
      Caption = '45 minuti '
      Category = 0
      Hint = '45 minuti '
      Visible = ivAlways
      ButtonStyle = bsChecked
      GroupIndex = 1
      OnClick = btnMinutiAssenzaClick
    end
    object btnMinuti60: TdxBarButton
      Tag = 60
      Caption = '60 minuti '
      Category = 0
      Hint = '60 minuti '
      Visible = ivAlways
      ButtonStyle = bsChecked
      GroupIndex = 1
      OnClick = btnMinutiAssenzaClick
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
    object dxBarControlContainerItem: TdxBarControlContainerItem
      Category = 0
      Enabled = False
      Visible = ivAlways
      Control = pnlSeparatoreUno
    end
    object dxBarButtonForzaTipologiaFormazione: TdxBarButton
      Action = ForzaTipologiaFormazione
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
    object btnMinuti5: TdxBarButton
      Tag = 5
      Caption = '5 minuti'
      Category = 0
      Hint = '5 minuti'
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = btnMinutiAssenzaClick
    end
    object btnMinuti10: TdxBarButton
      Tag = 10
      Caption = '10 minuti'
      Category = 0
      Hint = '10 minuti'
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = btnMinutiAssenzaClick
    end
    object btnMinuti20: TdxBarButton
      Tag = 20
      Caption = '20 minuti'
      Category = 0
      Hint = '20 minuti'
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = btnMinutiAssenzaClick
    end
    object btnMinuti25: TdxBarButton
      Tag = 25
      Caption = '25 minuti'
      Category = 0
      Hint = '25 minuti'
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = btnMinutiAssenzaClick
    end
    object btnMinuti35: TdxBarButton
      Tag = 35
      Caption = '35 minuti'
      Category = 0
      Hint = '35 minuti'
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = btnMinutiAssenzaClick
    end
    object btnMinuti40: TdxBarButton
      Tag = 40
      Caption = '40 minuti'
      Category = 0
      Hint = '40 minuti'
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = btnMinutiAssenzaClick
    end
    object btnMinuti50: TdxBarButton
      Tag = 50
      Caption = '50 minuti'
      Category = 0
      Hint = '50 minuti'
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = btnMinutiAssenzaClick
    end
    object btnMinuti55: TdxBarButton
      Tag = 55
      Caption = '55 minuti'
      Category = 0
      Hint = '55 minuti'
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = btnMinutiAssenzaClick
    end
    object dxBarButton1: TdxBarButton
      Action = CalendarioCorsi
      Category = 0
    end
    object dxBarContainerItem1: TdxBarContainerItem
      Caption = 'New Item'
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object dxBarControlContainerItem1: TdxBarControlContainerItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      Control = pnlSeparatoreDue
    end
    object dxBarButtonBloccaPresenze: TdxBarButton
      Action = BloccaPresenze
      Category = 0
    end
  end
  inherited BaseActions: TActionList
    Left = 44
    Top = 92
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object Actions: TActionList
    Images = zDmImages.ImageList24
    Left = 217
    Top = 208
    object Firma: TAction
      Caption = 'Firma'
      ImageIndex = 384
      OnExecute = FirmaExecute
      OnUpdate = FirmaUpdate
    end
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
    object ForzaTipologiaFormazione: TAction
      Caption = 'Forza Tipologia'
      ImageIndex = 126
      OnExecute = ForzaTipologiaFormazioneExecute
    end
    object Salva: TAction
      Caption = 'Salva'
      ImageIndex = 6
      OnExecute = SalvaExecute
      OnUpdate = SalvaUpdate
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
    object CalendarioCorsi: TAction
      Caption = 'Calendario Corsi'
      ImageIndex = 272
      OnExecute = CalendarioCorsiExecute
    end
    object BloccaPresenze: TAction
      Caption = 'Blocca Presenze'
      ImageIndex = 129
      OnExecute = BloccaPresenzeExecute
      OnUpdate = BloccaPresenzeUpdate
    end
  end
  object cxEditRepository: TcxEditRepository
    Left = 217
    Top = 266
    PixelsPerInch = 96
    object cxEditRepositoryTipologiaFormazione: TcxEditRepositoryImageComboBoxItem
      Properties.Items = <
        item
          Description = 'Collettiva'
          ImageIndex = 0
          Value = '1'
        end
        item
          Description = 'Tirocinio'
          Value = '2'
        end
        item
          Description = 'Evento'
          Value = '3'
        end
        item
          Description = 'Formazione Interna'
          Value = '4'
        end
        item
          Description = 'Formazione Esterna'
          Value = '5'
        end
        item
          Description = 'Project Work'
          Value = '6'
        end
        item
          Description = 'Form. Assetto Lavorativo'
          Value = '7'
        end
        item
          Description = 'F.A.L. Extra Monte Ore'
          Value = '8'
        end
        item
          Description = 'FAD'
        end>
    end
    object cxEditRepositoryTotaleOre: TcxEditRepositoryLabel
      Properties.LabelEffect = cxleExtrude
    end
    object cxEditRepositoryStatoPresenza: TcxEditRepositoryImageComboBoxItem
      Properties.ImmediateDropDownWhenKeyPressed = False
      Properties.ImmediatePost = True
      Properties.ImmediateUpdateText = True
      Properties.Items = <
        item
          Description = 'Presente'
          ImageIndex = 282
        end>
      Properties.Revertable = True
      Properties.OnEditValueChanged = cxEditRepositoryStatoPresenzaPropertiesEditValueChanged
      Properties.OnPopup = cxEditRepositoryPresenzaPropertiesPopup
    end
    object cxEditRepositoryOra: TcxEditRepositoryTimeItem
      Properties.TimeFormat = tfHourMin
    end
    object cxEditRepositoryMateria: TcxEditRepositoryComboBoxItem
      Properties.Items.Strings = (
        'MATERIA'
        'Matematica'
        'Informatica'
        'Capacita'#39' personali'
        'Italiano'
        'Inglese'
        'Scienze'
        'Storia e Geografia'
        'Diritto ed Economia'
        'IRC/Etica e Morale'
        'Lab.cucina'
        'Lab. pasticceria'
        'Lab. sala'
        'Lab. bar'
        'Lab. elettronica'
        'Lab. motori'
        'Metodi di ricerca'
        'Lab. officina'
        'Elettronica'
        'Assistenza Clienti'
        'Igiene degli alimenti'
        'Scienza dell'#39'Alimentazione'
        'Scienze e Tecnologia alimentare'
        'Sicurezza/Qualit'#224
        'Tecniche di decorazione'
        'Orientamento/accompagnamento al lavoro'
        'Cultura del lavoro'
        'Lab. scienze/ambiente'
        'Comunicazione professionale'
        'Calcolo professionale'
        'Attivit'#224' Motorie'
        'Teoria di Laboratorio'
        'Sicurezza'
        'Lab. panetteria'
        'Teoria Professionale'
        'Diritto e Tecniche Amministrative'
        'Informatica specialistica'
        'Francese specialistico'
        'Lab. cittadinanza attiva'
        'Elementi e gestione d'#39'impresa'
        'Educazione espressiva'
        'Teoria motori'
        'Lab. Utensili'
        'Ambiente'
        'Comunicazione'
        'Qualita'#39
        'Lab. orologeria'
        'Orientamento'
        'Primo soccorso e salvataggio'
        'Teoria rischio, ancoraggi, DPI'
        'Lab. Meccanica'
        'Pratica utilizzo DPI e metodologia operativa'
        'Teoria elettronica'
        'Laboratorio autodiagnosi'
        'Elettronica applicata'
        'Carrozzeria dei veicoli storici'
        'Impianto elettrico dei veicoli storici'
        'Meccanica dei veicoli storici'
        'Tappezzeria dei veicoli storici'
        'teoria di laboratorio bar'
        'Teoria di lab. sala'
        'teoria di lab past.'
        'teoria di lab. pan'
        'Territorio e Ambiente'
        'HACCP'
        'STRUMENTI D'#39'IMPRESA'
        'Economia'
        'Francese'
        'Cittadinanza'
        'Musica'
        'Lab scienze e di gestione')
    end
    object cxEditRepositoryCheckBox: TcxEditRepositoryCheckBoxItem
      Properties.UseAlignmentWhenInplace = True
    end
    object cxEditRepositoryDocente: TcxEditRepositoryComboBoxItem
      Properties.Items.Strings = (
        'ALIVERTI ELENA'
        'ARIAZZI PIERLUIGI'
        'BAGNOLI ANDREA'
        'BARERA ANNAROSA'
        'BARERA MARIA CLEMENS'
        'BERTO THOMAS FRANCESCO'
        'BIGONI ALDO'
        'CARDAMONE ALESSANDRA'
        'FARINA MAURA'
        'FERA RAFFAELA'
        'FERRONI MARGHERITA'
        'FIORITO GIOVANNA'
        'FITTIPALDI GIUSEPPINA'
        'FOSSATI ANDREA'
        'LOSA IVAN'
        'MENAGGIA GIORGIO'
        'NOMINATIVO'
        'POCHETTINO ANNA RITA'
        'POULI LELENG LUCIO'
        'SALDARINI EMANUELA MARIA'
        'VALLONE ROBERTO')
      Properties.Sorted = True
    end
    object cxEditRepositoryFAD: TcxEditRepositoryCheckBoxItem
      Properties.OnEditValueChanged = cxEditRepositoryFADPropertiesEditValueChanged
    end
    object cxEditRepositoryMinutiAssenza: TcxEditRepositoryComboBoxItem
      Properties.Alignment.Horz = taRightJustify
      Properties.ImmediateDropDownWhenKeyPressed = False
      Properties.ImmediatePost = True
      Properties.ImmediateUpdateText = True
      Properties.IncrementalFiltering = True
      Properties.Items.Strings = (
        '0'
        '5'
        '10'
        '15'
        '20'
        '25'
        '30'
        '35'
        '40'
        '45'
        '50'
        '55'
        '60')
      Properties.PostPopupValueOnTab = True
      Properties.Revertable = True
      Properties.OnEditValueChanged = cxEditRepositoryMinutiAssenzaPropertiesEditValueChanged
    end
  end
  object lkProgettiSrc: TDataSource
    Left = 216
    Top = 160
  end
  object imageTreeMaterie: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 10486112
    ImageInfo = <
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000000F744558745469746C6500437573746F6D65723B9CDDD5
          E20000029D49444154785E85925D48936D1CC6AFC73DFB72AEB9CD70E94C74B9
          9A980D6D7D9989481EF442111DF479641D7954E6C14B07155447BD2F88072F74
          A051067D1C56D04141A8514190CD2C319B36755FBAB977DFEE79EEE7BE7B16A2
          4B885D7073FFEF3FF7F5830B2E8E31867C75DA0D10447A8C10A94714699348A8
          5F7E5FFB12971E3359D8A0226C9028D01D6A25FFA8BEAEEA90CB692BD9555F65
          57F28A070E3D7FDD56CC6F2A0820947697990C1A2249F83A3587F1491F9A1AEC
          4594B0AB9C44AF14061066E5E46D304AD179E21CEE0CF5E1ECE94ECEA4538689
          C41A0A0204228D7B7E2CB187AF46D1FB7717EC5606AD268D169B5EC580484180
          374E062BCB8D22CFF310E31E24A3CB9084154822418CA2BF202092A589C6BA8A
          CF0B13EF918E46118B84119899C75252FC1E6308FE1170F4F849701CC703D0CF
          C7C9F4E4E8737C9B0C6166621A9E895978338A9CB954FEA3AEA9DD8635E5F540
          6D349977EE3DD0F6B6E3F0113670B397FDD7D5C1FE3D7590DDBE789E399B5C6C
          6B758D5BA552B701D001C875682D025F6ED952EF6CDEF3BAA5B57D7F7BE75F38
          73F90696DF05B0F02180EE5BFDA8AE75A0D1E96AB454543C9321FB0028F323E8
          2AADD53D36DB7673D9660BBC733E8C8CBC81B579372A1D0E0C0F8FC0E70F62C6
          EB47B1CEA0D768B5970018F3017AA54AD56A349761DEEF472018C2BDFB43E014
          0AC442210C0CDE45269DC14A3A8544220D0E9C0B40693E4053C47116391F1665
          432A99C0D82737BCE36E447D3E7C1C1B432A9540762503420828A32600C500C0
          AF3790209BCD20125946269984A6C48C7FA6DCA04482596B8690498310118C51
          302A3100241FF07F38BC38F4F2C5D30B4424108980DC5D6A30E44C32300C8990
          5FB344250882F004C0D26F8059CFF415007D0034AB3B2E77D6E67509008258AD
          F54F3A813CA25B8B3C460000000049454E44AE426082}
      end
      item
        ImageClass = 'TdxPNGImage'
        Image.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          610000001974455874536F6674776172650041646F626520496D616765526561
          647971C9653C0000000B744558745469746C65005461736B3BD380CA7C000002
          0249444154785E9D914F6B534114C58F347FDAD445ED2266AB2520342EB208AF
          7519057551A16627D8859F2156175D772514311FC0168CDA45105D34096D37A5
          942AC58DD8E09F45160AD56015ED9BBC99B977E44D1E8F96F740F0C0708799B9
          87DF3D9330C6E0B86AB51ABCBE07D9972F8527668414F0847C25847B434A85E5
          E5C738AE0402DD7DD4DE20E632D179301863F235A6A61DB8AE8B76AB3D237357
          0C11E3D6BD2720E2CDE70F6E5F3E61E0375F9ABE808F1B4F218480333568768F
          5C148B456C6DBD80521A859B55BC7BD32947089808E3E3A7E1380ED6D65A6835
          DB10D285140A527A504AA152A9E0EB8F2F20A6E80844068A0DAE96CBC866B3E8
          743A48269376A55229A4D3699CDDDFC7E7912C581FC6183041E98173A150B00D
          DD6ED7AFD6E0A8D1002626F02733164FC03E81E6F0229FCF2393C9A0D7EBE1E7
          EA2ADCDD5DE41717E1D5F7C0C451034D04A90617EF979670B0BD8D8BF3F3D0EB
          EBF8B6B28252BD8E534343F0144133C71348A5C340BFEFEC60737616BECECDCD
          21572AD9BD5404134740C4F0028242B51A928CE472282E2C20313C1C1830884D
          1C0159BC40A1C999C949244647C373A9C9D2C666D01F8C10310914BE63139B01
          C3931AFF92D28CF80C98D13B38C4FD677B76144F920D4C06BFA388A0C9A0FFEB
          37D82096A0F9E9ED876BCC6C69C85613EC8DC536FE191B7F3523068D8777AEE3
          3FF4174D5C4C9E43C2773A0000000049454E44AE426082}
      end>
  end
  object dxBarPopupMenu: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'btnMinuti0'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'btnMinuti5'
      end
      item
        Visible = True
        ItemName = 'btnMinuti10'
      end
      item
        Visible = True
        ItemName = 'btnMinuti15'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'btnMinuti20'
      end
      item
        Visible = True
        ItemName = 'btnMinuti25'
      end
      item
        Visible = True
        ItemName = 'btnMinuti30'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'btnMinuti35'
      end
      item
        Visible = True
        ItemName = 'btnMinuti40'
      end
      item
        Visible = True
        ItemName = 'btnMinuti45'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'btnMinuti50'
      end
      item
        Visible = True
        ItemName = 'btnMinuti55'
      end
      item
        Visible = True
        ItemName = 'btnMinuti60'
      end>
    UseOwnFont = False
    OnPopup = dxBarPopupMenuPopup
    Left = 384
    Top = 368
    PixelsPerInch = 96
  end
end
