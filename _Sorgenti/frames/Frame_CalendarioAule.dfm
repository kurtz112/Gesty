inherited FrameCalendarioAule: TFrameCalendarioAule
  Width = 833
  Height = 595
  ExplicitWidth = 833
  ExplicitHeight = 595
  object dxLayoutControl: TdxLayoutControl [0]
    Left = 0
    Top = 0
    Width = 833
    Height = 595
    Align = alClient
    TabOrder = 0
    AutoSize = True
    object tree: TcxTreeList
      Left = 25
      Top = 84
      Width = 783
      Height = 486
      Bands = <
        item
          Caption.AlignHorz = taCenter
          FixedKind = tlbfLeft
        end
        item
        end>
      FindPanel.Behavior = fcbFilter
      FindPanel.DisplayMode = fpdmAlways
      FindPanel.InfoText = 'Inserire l'#39'aula da cercare...'
      FindPanel.Layout = fplCompact
      FindPanel.ShowCloseButton = False
      OptionsBehavior.IncSearch = True
      OptionsCustomizing.BandCustomizing = False
      OptionsCustomizing.BandHorzSizing = False
      OptionsCustomizing.BandMoving = False
      OptionsCustomizing.BandsQuickCustomizationShowCommands = False
      OptionsCustomizing.BandVertSizing = False
      OptionsCustomizing.ColumnCustomizing = False
      OptionsCustomizing.ColumnHorzSizing = False
      OptionsCustomizing.ColumnMoving = False
      OptionsCustomizing.ColumnsQuickCustomizationShowCommands = False
      OptionsCustomizing.ColumnVertSizing = False
      OptionsData.CancelOnExit = False
      OptionsData.Editing = False
      OptionsData.Deleting = False
      OptionsSelection.HideSelection = True
      OptionsSelection.InvertSelect = False
      OptionsView.Bands = True
      OptionsView.FocusRect = False
      OptionsView.GridLines = tlglBoth
      OptionsView.HeaderAutoHeight = True
      OptionsView.ShowRoot = False
      OptionsView.TreeLineStyle = tllsSolid
      ScrollbarAnnotations.CustomAnnotations = <>
      Styles.OnGetContentStyle = treeStylesGetContentStyle
      Styles.UseOddEvenStyles = bTrue
      TabOrder = 1
      OnDblClick = treeDblClick
    end
    object Scheduler: TcxScheduler
      Left = 10000
      Top = 10000
      Width = 1008
      Height = 484
      DateNavigator.ShowDatesContainingHolidaysInColor = True
      DateNavigator.Visible = False
      ViewAgenda.ShowTimeAsClock = True
      ViewDay.Active = True
      ViewDay.AlwaysShowEventTime = True
      ViewDay.DayHeaderModernStyleDisplayMode = hdmDayAndDate
      ViewDay.WorkTimeOnly = True
      ViewWeek.CompressWeekEnd = False
      ViewWeek.DaysLayout = wdlOneColumn
      BorderStyle = cxcbsNone
      ContentPopupMenu.UseBuiltInPopupMenu = False
      ContentPopupMenu.Items = [cpmiNewEvent, cpmiToday, cpmiGoToDate, cpmiGoToThisDay]
      ControlBox.Visible = False
      EventOperations.DialogShowing = False
      EventOperations.Intersection = False
      EventOperations.ReadOnly = True
      EventOperations.Recurrence = False
      EventPopupMenu.UseBuiltInPopupMenu = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      LookAndFeel.Kind = lfStandard
      LookAndFeel.NativeStyle = False
      LookAndFeel.SkinName = 'UserSkin'
      OptionsBehavior.SelectOnRightClick = True
      OptionsView.ResourceHeaders.MultilineCaptions = True
      OptionsView.ShowEventsWithoutResource = True
      OptionsView.ShowHints = False
      OptionsView.ShowNavigationButtons = False
      OptionsView.WorkDays = [dSunday, dMonday, dTuesday, dWednesday, dThursday, dFriday, dSaturday]
      OptionsView.WorkStart = 0.291666666666666700
      OptionsView.WorkFinish = 0.999305555555555600
      ResourceNavigator.Visibility = snvNever
      Storage = CalendarioDocenti.cxSchedulerStorage
      TabOrder = 4
      Visible = False
      OnDblClick = SchedulerDblClick
      Splitters = {
        500200007F0000006E03000084000000EB02000002000000F0020000C0010000}
      StoredClientBounds = {0000000000000000F0030000E4010000}
    end
    object labelAula: TcxLabel
      Left = 10000
      Top = 10000
      Caption = 'Docente: '
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -16
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      TabOrder = 3
      Visible = False
    end
    object btnElenco: TcxButton
      Left = 10000
      Top = 10000
      Width = 200
      Height = 25
      Action = Elenco
      TabOrder = 2
      Visible = False
    end
    object dxBarDockControl: TdxBarDockControl
      Left = 12
      Top = 12
      Width = 809
      Height = 30
      Align = dalNone
      BarManager = dxBarManager
    end
    object dxLayoutControlGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      ItemIndex = 1
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemTree: TdxLayoutItem
      Parent = dxLayoutGroupTab
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'tree'
      CaptionOptions.Visible = False
      Control = tree
      ControlOptions.OriginalHeight = 452
      ControlOptions.OriginalWidth = 640
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemScheduler: TdxLayoutItem
      Parent = dxLayoutGroupScheduler
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'scheduler'
      CaptionOptions.Visible = False
      Control = Scheduler
      ControlOptions.OriginalHeight = 450
      ControlOptions.OriginalWidth = 350
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutGroupTab: TdxLayoutGroup
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      LayoutDirection = ldTabbed
      ShowBorder = False
      Index = 1
    end
    object dxLayoutItemLabelDocente: TdxLayoutItem
      Parent = dxLayoutGroupDocente
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = labelAula
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 69
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupScheduler: TdxLayoutGroup
      Parent = dxLayoutGroupTab
      CaptionOptions.Text = 'scheduler'
      CaptionOptions.Visible = False
      ItemIndex = 1
      ShowBorder = False
      Index = 1
    end
    object dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupScheduler
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 2
    end
    object dxLayoutEmptySpaceItem3: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupScheduler
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 0
    end
    object dxLayoutItemElencoDocenti: TdxLayoutItem
      Parent = dxLayoutGroupDocente
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnElenco
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 200
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupDocente: TdxLayoutGroup
      Parent = dxLayoutGroupScheduler
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutItemBar: TdxLayoutItem
      Parent = dxLayoutControlGroup_Root
      Control = dxBarDockControl
      ControlOptions.OriginalHeight = 30
      ControlOptions.OriginalWidth = 1041
      ControlOptions.ShowBorder = False
      Index = 0
    end
  end
  inherited dxBarManager: TdxBarManager
    OnBarVisibleChange = nil
    Left = 200
    Top = 224
    PixelsPerInch = 96
    object dxBarManagerBar: TdxBar [0]
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl
      DockedDockControl = dxBarDockControl
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 1074
      FloatTop = 0
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton7'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton8'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
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
          ItemName = 'dxBarButton4'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton5'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'dxBarButton6'
        end>
      OneOnRow = True
      Row = 0
      SizeGrip = False
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object dxBarButton1: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
    object dxBarButton2: TdxBarButton
      Action = Precedente
      Category = 0
    end
    object dxBarButton3: TdxBarButton
      Action = Successiva
      Category = 0
    end
    object dxBarButton4: TdxBarButton
      Action = Giorno
      Category = 0
      ButtonStyle = bsChecked
    end
    object dxBarButton5: TdxBarButton
      Action = Settimana
      Category = 0
      ButtonStyle = bsChecked
    end
    object dxBarButton6: TdxBarButton
      Action = actEsporta
      Category = 0
    end
    object dxBarButton7: TdxBarButton
      Action = Oggi
      Category = 0
    end
    object dxBarButton8: TdxBarButton
      Action = VaiAlGiorno
      Category = 0
    end
  end
  inherited BaseActions: TActionList
    Left = 116
    Top = 148
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 200
    Top = 160
    object actEsporta: TdxFileSaveAs
      Caption = 'Esporta'
      Dialog.DefaultExt = '*.xlsx'
      Dialog.Filter = 'Excel|*.xlsx|Tutti|*.*'
      Dialog.Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
      ImageIndex = 221
      OnAccept = actEsportaAccept
    end
    object Oggi: TAction
      Caption = 'Oggi'
      ImageIndex = 483
      OnExecute = OggiExecute
    end
    object VaiAlGiorno: TAction
      Caption = 'Seleziona Giorno'
      ImageIndex = 952
      OnExecute = VaiAlGiornoExecute
    end
    object Precedente: TAction
      Caption = 'Precedente'
      ImageIndex = 171
      OnExecute = PrecedenteExecute
    end
    object Successiva: TAction
      Caption = 'Successiva'
      ImageIndex = 163
      OnExecute = SuccessivaExecute
    end
    object Giorno: TAction
      AutoCheck = True
      Caption = 'Giorno'
      Checked = True
      GroupIndex = 1
      ImageIndex = 477
      OnExecute = GiornoExecute
    end
    object Settimana: TAction
      AutoCheck = True
      Caption = 'Settimana'
      GroupIndex = 1
      ImageIndex = 484
      OnExecute = SettimanaExecute
    end
    object Elenco: TAction
      Caption = 'Torna all'#39'elenco aule'
      ImageIndex = 991
      OnExecute = ElencoExecute
    end
  end
  object dxComponentPrinter: TdxComponentPrinter
    CurrentLink = dxComponentPrinterLinkTree
    Options = [cpoAutoRebuildBeforePreview, cpoGenerateReportProgressEvent, cpoShowHourGlass, cpoDropStorageModeAfterPreview]
    PreviewOptions.Caption = 'Anteprima'
    PreviewOptions.WindowState = wsMaximized
    PreviewOptions.PreviewBoundsRect = {00000000000000000004000020030000}
    PrintTitle = 'Calendario Docenti'
    Version = 0
    Left = 200
    Top = 296
    PixelsPerInch = 96
    object dxComponentPrinterLinkTree: TcxTreeListReportLink
      Active = True
      Component = tree
      PageNumberFormat = pnfNumeral
      PrinterPage.CenterOnPageH = True
      PrinterPage.CenterOnPageV = True
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 350
      PrinterPage.Margins.Bottom = 2700
      PrinterPage.Margins.Left = 2700
      PrinterPage.Margins.Right = 2700
      PrinterPage.Margins.Top = 2700
      PrinterPage.Orientation = poLandscape
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.Caption = 'Calendario Aule'
      ReportDocument.CreationDate = 45582.370911747680000000
      ReportDocument.Creator = 'Gesty'
      ReportTitle.Text = 'ReportTitleText'
      TimeFormat = 0
      OptionsFormatting.GridLineColor = clBlack
      OptionsFormatting.UseNativeStyles = True
      OptionsSize.AutoWidth = True
      OptionsView.BandHeaders = False
      SupportedCustomDraw = True
      OnInitializeCell = dxComponentPrinterLinkTreeInitializeCell
      PixelsPerInch = 96
      BuiltInReportLink = True
    end
    object dxComponentPrinterLinkScheduler: TcxSchedulerReportLink
      Component = Scheduler
      PageNumberFormat = pnfNumeral
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.GrayShading = True
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.Caption = 'Calendario Docente'
      ReportDocument.Creator = 'Gesty'
      ReportTitle.Text = 'ReportTitle aaaaaaaaa'
      TimeFormat = 0
      PrintRange.TimePrintFrom = 0.291666666666666700
      PrintRange.TimePrintTo = 0.999305555555555600
      PrintStyles.Weekly.DaysLayout = wdlOneColumn
      PixelsPerInch = 96
      BuiltInReportLink = True
    end
  end
  object ColorRepository: TcxStyleRepository
    Left = 208
    Top = 416
    PixelsPerInch = 96
  end
  object PrintStyleRepository: TcxStyleRepository
    Left = 201
    Top = 352
    PixelsPerInch = 96
    object PrintTreeStyle: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
  end
end
