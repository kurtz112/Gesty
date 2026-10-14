inherited FrameRiepilogoGiornalieroAule: TFrameRiepilogoGiornalieroAule
  Width = 716
  Height = 417
  ExplicitWidth = 716
  ExplicitHeight = 417
  object dxLayoutControl: TdxLayoutControl [0]
    Left = 0
    Top = 0
    Width = 716
    Height = 417
    Align = alClient
    TabOrder = 0
    AutoSize = True
    object tree: TcxTreeList
      Left = 12
      Top = 46
      Width = 692
      Height = 359
      Bands = <
        item
          Caption.AlignHorz = taCenter
        end
        item
        end>
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
      OptionsView.ShowRoot = False
      OptionsView.TreeLineStyle = tllsSolid
      ScrollbarAnnotations.CustomAnnotations = <>
      Styles.OnGetContentStyle = treeStylesGetContentStyle
      Styles.UseOddEvenStyles = bTrue
      TabOrder = 3
      OnDblClick = treeDblClick
    end
    object edDalGiorno: TcxDateEdit
      Left = 365
      Top = 13
      ParentFont = False
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.OnEditValueChanged = edDalGiornoPropertiesEditValueChanged
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 125
    end
    object btnPrecedente: TcxButton
      Left = 497
      Top = 12
      Width = 100
      Height = 27
      Action = Precedente
      TabOrder = 1
    end
    object btnSuccessiva: TcxButton
      Left = 604
      Top = 12
      Width = 100
      Height = 27
      Action = Successiva
      TabOrder = 2
    end
    object dxLayoutControlGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemTree: TdxLayoutItem
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'tree'
      CaptionOptions.Visible = False
      Control = tree
      ControlOptions.OriginalHeight = 452
      ControlOptions.OriginalWidth = 640
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemDalGiorno: TdxLayoutItem
      Parent = dxLayoutGroupTop
      AlignHorz = ahRight
      AlignVert = avCenter
      CaptionOptions.Text = 'Dal Giorno:'
      Control = edDalGiorno
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 125
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupTop: TdxLayoutGroup
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutItemPrecedente: TdxLayoutItem
      Parent = dxLayoutGroupTop
      AlignHorz = ahRight
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnPrecedente
      ControlOptions.OriginalHeight = 27
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemSuccessiva: TdxLayoutItem
      Parent = dxLayoutGroupTop
      AlignHorz = ahRight
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnSuccessiva
      ControlOptions.OriginalHeight = 27
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 2
    end
  end
  inherited dxBarManager: TdxBarManager
    OnBarVisibleChange = nil
    Left = 200
    Top = 224
    PixelsPerInch = 96
    object dxBarButton1: TdxBarButton [0]
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
  end
  inherited BaseActions: TActionList
    inherited actPermessiAzione: TAction
      OnExecute = nil
    end
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
      Dialog.DefaultExt = '*.xslx'
      Dialog.Filter = 'Excel|*.xslx|Tutti|*.*'
      Dialog.Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
      ImageIndex = 221
      OnAccept = actEsportaAccept
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
  end
  object dxComponentPrinter: TdxComponentPrinter
    CurrentLink = dxComponentPrinterLink
    Options = [cpoAutoRebuildBeforePreview, cpoGenerateReportProgressEvent, cpoShowHourGlass, cpoDropStorageModeAfterPreview]
    PreviewOptions.Caption = 'Anteprima'
    PreviewOptions.WindowState = wsMaximized
    PreviewOptions.PreviewBoundsRect = {00000000000000000004000020030000}
    PrintTitle = 'Calendario Docenti'
    Version = 0
    Left = 200
    Top = 296
    PixelsPerInch = 96
    object dxComponentPrinterLink: TcxTreeListReportLink
      Component = tree
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
      ReportDocument.Caption = 'CalendarioDocenti'
      ReportDocument.CreationDate = 44724.533767361110000000
      ReportDocument.Creator = 'Gesty'
      SupportedCustomDraw = True
      OnInitializeCell = dxComponentPrinterLinkInitializeCell
      PixelsPerInch = 96
      BuiltInReportLink = True
    end
  end
  object ColorRepository: TcxStyleRepository
    Left = 472
    Top = 160
    PixelsPerInch = 96
  end
end
