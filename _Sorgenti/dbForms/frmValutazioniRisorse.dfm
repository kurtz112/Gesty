inherited FormValutazioniRisorse: TFormValutazioniRisorse
  Caption = 'FormValutazioniRisorse'
  OnCreate = FormCreate
  ExplicitWidth = 657
  ExplicitHeight = 505
  TextHeight = 15
  object tree: TcxTreeList [1]
    AlignWithMargins = True
    Left = 7
    Top = 37
    Width = 631
    Height = 423
    Margins.Left = 7
    Margins.Top = 7
    Margins.Right = 7
    Margins.Bottom = 7
    BorderStyle = cxcbsNone
    Align = alClient
    Bands = <
      item
        Caption.AlignHorz = taCenter
        Caption.Text = 'Fornitori'
      end
      item
        Caption.AlignHorz = taCenter
        Caption.Text = 'Valutazioni'
      end
      item
        Caption.AlignHorz = taCenter
        Caption.Text = 'Stato'
      end>
    FilterBox.Visible = fvAlways
    FindPanel.DisplayMode = fpdmAlways
    FindPanel.InfoText = 'ricerca per nominativo'
    FindPanel.ShowClearButton = False
    FindPanel.ShowCloseButton = False
    LookAndFeel.Kind = lfFlat
    Navigator.Buttons.CustomButtons = <>
    OptionsBehavior.AlwaysShowEditor = True
    OptionsBehavior.GoToNextCellOnEnter = True
    OptionsBehavior.GoToNextCellOnTab = True
    OptionsBehavior.ChangeDelay = 1000
    OptionsBehavior.ExpandOnIncSearch = True
    OptionsBehavior.IncSearch = True
    OptionsBehavior.IncSearchItem = treeColNominativo
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
    OptionsData.Editing = False
    OptionsData.CaseInsensitive = True
    OptionsData.Deleting = False
    OptionsData.ImmediatePost = True
    OptionsData.MultiThreadedSorting = bFalse
    OptionsView.ScrollBars = ssNone
    OptionsView.Bands = True
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
    TabOrder = 5
    ExplicitWidth = 639
    ExplicitHeight = 425
    object treeColNominativo: TcxTreeListColumn
      RepositoryItem = cxEditRepositoryNominativo
      Caption.Text = 'Fornitore'
      Width = 100
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object treeColIdRisorsa: TcxTreeListColumn
      RepositoryItem = cxEditRepositoryIdRisorsa
      Caption.Text = 'Codice'
      Width = 100
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object treeColTipoRisorsa: TcxTreeListColumn
      RepositoryItem = cxEditRepositoryTipoRisorsa
      Visible = False
      Caption.Text = 'Tipo Risorsa'
      Width = 100
      Position.ColIndex = 2
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object treeColTipologiaFornitore: TcxTreeListColumn
      RepositoryItem = cxEditRepositoryTipologiaFornitore
      Visible = False
      Caption.Text = 'Tipologia Fornitore'
      Width = 100
      Position.ColIndex = 3
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object treeColDescTipologiaFornitore: TcxTreeListColumn
      Caption.Text = 'Tipologia Fornitore'
      Width = 100
      Position.ColIndex = 11
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object treeColDataAttivazione: TcxTreeListColumn
      RepositoryItem = cxEditRepositoryData
      Caption.Text = 'Data Attivazione'
      Width = 100
      Position.ColIndex = 4
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object treeColDataDisattivazione: TcxTreeListColumn
      RepositoryItem = cxEditRepositoryData
      Visible = False
      Caption.Text = 'Data Disattivazione'
      Width = 100
      Position.ColIndex = 5
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object treeColDataInizioValiditaInquadramento: TcxTreeListColumn
      RepositoryItem = cxEditRepositoryData
      Visible = False
      Caption.Text = 'Inizio Validit'#224' Inquadramento'
      Width = 100
      Position.ColIndex = 6
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object treeColDataFineValiditaInquadramento: TcxTreeListColumn
      RepositoryItem = cxEditRepositoryData
      Visible = False
      Caption.Text = 'Fine Validit'#224' Inquadramento'
      Width = 100
      Position.ColIndex = 7
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object treeColTipoInquadramento: TcxTreeListColumn
      RepositoryItem = cxEditRepositoryTipoInquadramento
      Visible = False
      Caption.Text = 'Tipo Inquadramento'
      Width = 100
      Position.ColIndex = 8
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object treeColTipoContratto: TcxTreeListColumn
      RepositoryItem = cxEditRepositoryTipoContratto
      Visible = False
      Caption.Text = 'Tipo Contratto'
      Width = 100
      Position.ColIndex = 9
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object treeColBloccaIncarichi: TcxTreeListColumn
      RepositoryItem = cxEditRepositoryBoolean
      Visible = False
      Caption.Text = 'Blocca Incarichi'
      Width = 100
      Position.ColIndex = 10
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object treeColStatoRisorsa: TcxTreeListColumn
      RepositoryItem = cxEditRepositoryStatoRisorsa
      Visible = False
      Caption.Text = 'Stato'
      Width = 100
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 2
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object treeColDescStatoRisorsa: TcxTreeListColumn
      RepositoryItem = cxEditRepositoryDescStatoRisorsa
      Caption.Text = 'Desc Stato Risorsa'
      Width = 100
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 2
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
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
      DockedLeft = 124
    end
    object dxBarButton1: TdxBarButton
      Action = Esporta
      Category = 0
    end
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 32
    Top = 168
    object Esporta: TdxFileSaveAs
      Caption = 'Esporta'
      ImageIndex = 221
      OnAccept = EsportaAccept
    end
  end
  object cxEditRepository: TcxEditRepository
    Left = 240
    Top = 144
    PixelsPerInch = 96
    object cxEditRepositoryTipoRisorsa: TcxEditRepositoryImageComboBoxItem
      Properties.Items = <>
    end
    object cxEditRepositoryNominativo: TcxEditRepositoryLabel
    end
    object cxEditRepositoryTipologiaFornitore: TcxEditRepositoryImageComboBoxItem
      Properties.Items = <>
    end
    object cxEditRepositoryData: TcxEditRepositoryDateItem
    end
    object cxEditRepositoryTipoInquadramento: TcxEditRepositoryLabel
    end
    object cxEditRepositoryTipoContratto: TcxEditRepositoryImageComboBoxItem
      Properties.Items = <>
    end
    object cxEditRepositoryBoolean: TcxEditRepositoryCheckBoxItem
    end
    object cxEditRepositoryStatoRisorsa: TcxEditRepositoryImageComboBoxItem
      Properties.Items = <>
    end
    object cxEditRepositoryDescStatoRisorsa: TcxEditRepositoryLabel
    end
    object cxEditRepositoryIdValutazione: TcxEditRepositoryLabel
      Properties.Alignment.Horz = taRightJustify
    end
    object cxEditRepositoryAnnoValutazione: TcxEditRepositoryLabel
      Properties.Alignment.Horz = taRightJustify
    end
    object cxEditRepositoryValutazione: TcxEditRepositoryLabel
    end
    object cxEditRepositoryDescValutazione: TcxEditRepositoryLabel
    end
    object cxEditRepositoryIdRisorsa: TcxEditRepositoryHyperLinkItem
      Properties.Prefix = ''
    end
  end
  object dxComponentPrinter: TdxComponentPrinter
    CurrentLink = dxComponentPrinterLink
    PrintTitle = 'Elenco Valutazioni'
    Version = 0
    Left = 240
    Top = 208
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
      ReportDocument.Caption = 'Elenco Valutazioni'
      PixelsPerInch = 96
      BuiltInReportLink = True
    end
  end
end
