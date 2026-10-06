object BaseForm: TBaseForm
  Left = 777
  Top = 379
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  Caption = 'Titolo'
  ClientHeight = 463
  ClientWidth = 629
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  Position = poMainFormCenter
  Visible = True
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 15
  object lblTitolo: TcxLabel
    Left = 8
    Top = 4
    Caption = 'Titolo'
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -16
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.IsFontAssigned = True
    TabOrder = 0
    OnDblClick = lblTitoloDblClick
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
    OnBarVisibleChange = dxBarManagerBarVisibleChange
    Left = 36
    Top = 56
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      30
      0)
    object barTitolo: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      BorderStyle = bbsNone
      Caption = 'Titolo'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 0
      FloatTop = 0
      FloatClientWidth = 51
      FloatClientHeight = 38
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarControlContainerTitolo'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object barFree: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      BorderStyle = bbsNone
      Caption = 'Free'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 52
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 669
      FloatTop = 8
      FloatClientWidth = 51
      FloatClientHeight = 38
      ItemLinks = <>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object barSistema: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      BorderStyle = bbsNone
      Caption = 'Sistema'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 107
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 586
      FloatTop = 237
      FloatClientWidth = 79
      FloatClientHeight = 162
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'btnStampa'
        end
        item
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'btnAggiorna'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItemSistema'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItemGuide'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          UserPaintStyle = psCaptionGlyph
          Visible = True
          ItemName = 'btnEsci'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarControlContainerTitolo: TdxBarControlContainerItem
      Caption = 'Titolo'
      Category = 0
      Visible = ivAlways
      Control = lblTitolo
    end
    object dxBarLargeButtonStampa: TdxBarLargeButton
      Action = actStampa
      Category = 0
    end
    object dxBarLargeButtonEsci: TdxBarLargeButton
      Action = actEsci
      Category = 0
    end
    object dxBarLargeButtonAggiorna: TdxBarLargeButton
      Action = actAggiorna
      Category = 0
    end
    object dxBarButtonSistema: TdxBarButton
      Action = actSistema
      Category = 0
    end
    object dxBarSubItemSistema: TdxBarSubItem
      Caption = 'Sistema'
      Category = 0
      Visible = ivAlways
      ImageIndex = 61
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButtonSistema'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItemPoliticheAccessi'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItemController'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonAI'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'btnScreenshot'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonNovita'
        end>
      ItemOptions.Size = misNormal
    end
    object dxBarButtonRicaricaPolitiche: TdxBarButton
      Action = actRicaricaPolitiche
      Category = 0
    end
    object dxBarButtonPoliticheAccessi: TdxBarButton
      Action = actPoliticheAccessi
      Category = 0
    end
    object dxBarSubItemController: TdxBarSubItem
      Caption = 'Controller'
      Category = 0
      Visible = ivAlways
      ImageIndex = 98
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButtonControllerEditDatamodule'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonControllerEditLayout'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonControllerMostraDimensioni'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonControllerResetDimensioni'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonControllerBuildGui'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButtonControllerResetToDefault'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonControllerLoadFromIni'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonControllerSaveToIni'
        end>
    end
    object dxBarButtonControllerBuildGui: TdxBarButton
      Action = ControllerBuildGui
      Category = 0
    end
    object dxBarButtonControllerEditDatamodule: TdxBarButton
      Action = ControllerEditDatamodule
      Category = 0
    end
    object dxBarButtonControllerResetToDefault: TdxBarButton
      Action = ControllerResetToDefault
      Category = 0
    end
    object dxBarButtonControllerEditLayout: TdxBarButton
      Action = ControllerEditLayout
      Category = 0
    end
    object dxBarButtonControllerSaveToIni: TdxBarButton
      Action = ControllerSaveToIni
      Category = 0
    end
    object dxBarButtonControllerLoadFromIni: TdxBarButton
      Action = ControllerLoadFromIni
      Category = 0
    end
    object dxBarSubItemPoliticheAccessi: TdxBarSubItem
      Caption = 'Politiche Accessi'
      Category = 0
      Visible = ivAlways
      ImageIndex = 184
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButtonPoliticheAccessi'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonRicaricaPolitiche'
        end
        item
          Visible = True
          ItemName = 'dxBarButtonSalvaComponenti'
        end>
    end
    object btnStampa: TdxBarButton
      Action = actStampa
      Category = 0
    end
    object btnAggiorna: TdxBarButton
      Action = actAggiorna
      Category = 0
    end
    object btnEsci: TdxBarButton
      Action = actEsci
      Category = 0
    end
    object dxBarButtonControllerMostraDimensioni: TdxBarButton
      Action = ControllerMostraDimensioni
      Category = 0
    end
    object dxBarButtonControllerResetDimensioni: TdxBarButton
      Action = ControllerResetDimensioni
      Category = 0
    end
    object btnHelp: TdxBarButton
      Action = Help
      Category = 0
    end
    object dxBarButton2: TdxBarButton
      Action = Help
      Category = 0
    end
    object btnScreenshot: TdxBarButton
      Action = actScreenshot
      Category = 0
    end
    object barBtnPermessiAzione: TdxBarButton
      Action = actPermessiAzione
      Category = 0
    end
    object dxBarButtonProprietaAzione: TdxBarButton
      Action = actProprietaAzione
      Category = 0
    end
    object dxBarButtonNovita: TdxBarButton
      Caption = 'Novit'#224
      Category = 0
      Visible = ivAlways
      ImageIndex = 425
    end
    object dxBarButtonSalvaComponenti: TdxBarButton
      Action = actSalvaComponenti
      Category = 0
    end
    object dxBarSubItemGuide: TdxBarButton
      Action = Guide
      Category = 0
    end
    object dxBarButtonAI: TdxBarButton
      Action = AI
      Category = 0
    end
  end
  object BaseActions: TActionList
    Images = zDmImages.ImageList16
    OnUpdate = BaseActionsUpdate
    Left = 36
    Top = 116
    object actAggiorna: TAction
      Category = 'File'
      Caption = 'Aggiorna'
      ImageIndex = 45
      OnExecute = actAggiornaExecute
    end
    object actStampa: TAction
      Category = 'File'
      Caption = 'Stampa'
      ImageIndex = 10
      ShortCut = 16468
      OnExecute = actStampaExecute
    end
    object actVisualizzaGuida: TAction
      Category = 'File'
      Caption = 'Visualizza Guida'
      ImageIndex = 183
    end
    object actEsci: TAction
      Category = 'File'
      Caption = 'Chiudi'
      ImageIndex = 12
      OnExecute = actEsciExecute
    end
    object actSistema: TAction
      Category = 'Sistema'
      Caption = 'Sistema'
      ImageIndex = 61
      OnExecute = actSistemaExecute
    end
    object actPoliticheAccessi: TAction
      Category = 'Sistema'
      Caption = 'Politiche Accessi'
      ImageIndex = 184
      OnExecute = actPoliticheAccessiExecute
    end
    object actRicaricaPolitiche: TAction
      Category = 'Sistema'
      Caption = 'Ricarica Politiche'
      ImageIndex = 76
      OnExecute = actRicaricaPoliticheExecute
    end
    object Guide: TAction
      Category = 'File'
      Caption = 'Guide'
      ImageIndex = 584
      OnExecute = GuideExecute
    end
    object ControllerEditDatamodule: TAction
      Category = 'Controller'
      Caption = 'Edit Datamodule'
      ImageIndex = 148
      OnExecute = ControllerEditDatamoduleExecute
    end
    object ControllerEditLayout: TAction
      Category = 'Controller'
      Caption = 'Edit Layout'
      ImageIndex = 98
      OnExecute = ControllerEditLayoutExecute
    end
    object ControllerResetToDefault: TAction
      Category = 'Controller'
      Caption = 'Reset Default'
      ImageIndex = 76
      OnExecute = ControllerResetToDefaultExecute
    end
    object ControllerLoadFromIni: TAction
      Category = 'Controller'
      Caption = 'Load From Ini'
      ImageIndex = 55
      OnExecute = ControllerLoadFromIniExecute
    end
    object ControllerSaveToIni: TAction
      Category = 'Controller'
      Caption = 'Save To Ini'
      ImageIndex = 56
      OnExecute = ControllerSaveToIniExecute
    end
    object ControllerBuildGui: TAction
      Category = 'Controller'
      Caption = 'Build Gui'
      ImageIndex = 288
      OnExecute = ControllerBuildGuiExecute
    end
    object ControllerMostraDimensioni: TAction
      Category = 'Controller'
      Caption = 'Mostra Dimensioni'
      ImageIndex = 288
      OnExecute = ControllerMostraDimensioniExecute
    end
    object ControllerResetDimensioni: TAction
      Category = 'Controller'
      Caption = 'Reset Dimensioni'
      ImageIndex = 11
      OnExecute = ControllerResetDimensioniExecute
    end
    object Help: TAction
      Category = 'File'
      Caption = 'Help'
      ImageIndex = 7
      ShortCut = 112
      OnExecute = HelpExecute
    end
    object actScreenshot: TAction
      Category = 'Sistema'
      Caption = 'Screenshot'
      ImageIndex = 254
      OnExecute = actScreenshotExecute
    end
    object actPermessiAzione: TAction
      Category = 'Sistema'
      Caption = 'Permessi'
      ImageIndex = 184
      OnExecute = actPermessiAzioneExecute
    end
    object actProprietaAzione: TAction
      Category = 'Sistema'
      Caption = 'Propriet'#224
      ImageIndex = 568
      OnExecute = actProprietaAzioneExecute
    end
    object actSalvaComponenti: TAction
      Category = 'Sistema'
      Caption = 'Salva Componenti'
      ImageIndex = 55
      OnExecute = actSalvaComponentiExecute
    end
    object AI: TAction
      Category = 'Sistema'
      Caption = 'AI'
      ImageIndex = 588
      OnExecute = AIExecute
    end
  end
  object popActions: TdxBarPopupMenu
    BarManager = dxBarManager
    ItemLinks = <
      item
        Visible = True
        ItemName = 'barBtnPermessiAzione'
      end
      item
        BeginGroup = True
        Visible = True
        ItemName = 'dxBarButtonProprietaAzione'
      end>
    UseOwnFont = False
    OnPopup = popActionsPopup
    Left = 36
    Top = 176
    PixelsPerInch = 96
  end
end
