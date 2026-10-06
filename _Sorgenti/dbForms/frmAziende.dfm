inherited FormAziende: TFormAziende
  ClientHeight = 476
  ClientWidth = 1209
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 1225
  ExplicitHeight = 515
  TextHeight = 15
  object layoutFiltri: TdxLayoutControl [1]
    Left = 104
    Top = 160
    Width = 1101
    Height = 90
    TabOrder = 5
    AutoSize = True
    OnContextPopup = layoutFiltriContextPopup
    object edFiltroSettori: TcxCheckComboBox
      Left = 72
      Top = 25
      Properties.Items = <>
      Properties.OnEditValueChanged = edFiltroSettorePropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 0
      Width = 141
    end
    object edFiltroCAP: TcxTextEdit
      Left = 478
      Top = 25
      Properties.OnEditValueChanged = edFiltroCAPPropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 2
      Text = 'edFiltroCAP'
      Width = 26
    end
    object edFiltroRagioneSociale: TcxTextEdit
      Left = 658
      Top = 25
      Properties.OnEditValueChanged = edFiltroRagioneSocialePropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 4
      Text = 'cxTextEdit1'
      Width = 71
    end
    object edFiltroPIvaCodFisc: TcxTextEdit
      Left = 883
      Top = 25
      Properties.CharCase = ecUpperCase
      Properties.OnEditValueChanged = edFiltroPIvaCodFiscPropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 5
      Text = 'EDFILTROPIVACODFISC'
      Width = 58
    end
    object edFiltroEnte: TcxExtLookupComboBox
      Left = 986
      Top = 25
      Properties.OnEditValueChanged = edFiltroEntePropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 6
      Width = 103
    end
    object btnMappa: TcxButton
      Left = 511
      Top = 24
      Width = 25
      Height = 25
      Action = MostraSuMappa
      PaintStyle = bpsGlyph
      SpeedButtonOptions.Flat = True
      SpeedButtonOptions.Transparent = True
      TabOrder = 3
    end
    object edFiltroDisponibilita: TcxCheckComboBox
      Left = 301
      Top = 25
      Properties.Items = <>
      Properties.OnEditValueChanged = edFiltroDisponibilitaPropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 1
      Width = 129
    end
    object layoutFiltriGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avTop
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemFiltroSettore: TdxLayoutItem
      Parent = dxLayoutGroupRicercaFiltri
      AlignHorz = ahClient
      AlignVert = avCenter
      CaptionOptions.Text = 'Settore'
      Control = edFiltroSettori
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 200
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemFiltroCAP: TdxLayoutItem
      Parent = dxLayoutGroupCAP
      AlignHorz = ahClient
      AlignVert = avCenter
      CaptionOptions.Text = 'CAP:'
      Control = edFiltroCAP
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 60
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemRagioneSociale: TdxLayoutItem
      Parent = dxLayoutGroupRicercaFiltri
      AlignHorz = ahClient
      AlignVert = avCenter
      CaptionOptions.Text = 'Ragione Sociale'
      Control = edFiltroRagioneSociale
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 7
    end
    object dxLayoutItemFiltroPIvaCodFisc: TdxLayoutItem
      Parent = dxLayoutGroupRicercaFiltri
      AlignHorz = ahClient
      AlignVert = avCenter
      CaptionOptions.Text = 'Partita Iva/Codice Fiscale'
      Control = edFiltroPIvaCodFisc
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 9
    end
    object dxLayoutItemFiltroEnte: TdxLayoutItem
      Parent = dxLayoutGroupRicercaFiltri
      AlignHorz = ahClient
      AlignVert = avCenter
      CaptionOptions.Text = 'Ente'
      Control = edFiltroEnte
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 145
      ControlOptions.ShowBorder = False
      Index = 11
    end
    object dxLayoutGroupRicercaFiltri: TdxLayoutGroup
      Parent = layoutFiltriGroup_Root
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Ricerca/Filtri'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutEmptySpaceItemTop: TdxLayoutEmptySpaceItem
      Parent = layoutFiltriGroup_Root
      SizeOptions.Height = 5
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Elemento di spazio vuoto'
      Index = 0
    end
    object dxLayoutLabeledItemRicercaFiltro: TdxLayoutLabeledItem
      AlignHorz = ahRight
      AlignVert = avCenter
      CaptionOptions.AlignHorz = taRightJustify
      CaptionOptions.Glyph.SourceDPI = 96
      CaptionOptions.Glyph.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        6100000026744558745469746C650046696E643B426172733B526962626F6E3B
        5374616E646172643B536561726368BB659C08000002D149444154785EAD936D
        48936B18C7FF7B369FB5E3CB3C6AEACC66E66C94980AF6C1B74A462FE743E087
        2526299812C519A20B03C98A3AC9D2E8E518519F52222A2789ACF99264C58AD0
        322A848E9BBA6992D95496BACD3DDBF43EF7C62AE9ABFDE1C77D735DF7F5E7BA
        EEFB79788410FC2EF128020A4B09A230AB733FF8454CEDE54EFF7AF8EFC6CD6A
        4DFBA39A069DBDF282565F507A2AD96758A369939EB9D6ABAB6BEA75D55EE9D2
        A9EAEE487D466A4D07FC525FF46F84AAF3DA572F07C7C8F0E814B9DD6A20AA73
        5A0E40485D538F6BE0C3383159BE929B779F90AAFA760300BEEA6CDBCF2E9465
        F5F9FF5CEF21D3338BC43060240DD75BC9D1DA7B04C0969397F464F2CB376234
        5B49F3FD3EA23A7D8F9454DFC8FA3E0E43091286FD59BE4D168B2597070E9717
        939356184DA3D8B1F784D16432C3C97941C0032B12C2EB716085B01500F87E83
        2D698AE820365429A70636BB0B8B4E17161C2E78380F122591F0B8396ABA0CEF
        0A8150148C20FE0ABCCB284ECB514600E031F2F4FDF58A6CB9302E468CD4E418
        A46FDD88785FA1D78D71CB3838B71B3C1E81242A1407F2535176682FC0D9D689
        C2132E0010308C4054989F2547F7D31114553DC4DB8F56ECCE4D839B165A67A6
        C0D1B1A2C422E8FB465158A9C390D981A2821CDAA1BBC46FC0B9BCFCF03021BA
        0CA38854E4A17BC08CED294960593EC6FFD3FF151B17075FBEF38505EBF765A3
        67F013D25393E97D39F900186689B34F8E4DCC4091BB09F3AFFBB13B538A11F3
        17D817E626000C3916178C96092BF6E44961EB7F83FCCC784C4DCF8273DA2D00
        0833373D72B5B9F53912625834AA7642124CD0F2E031E667276E02B0DBAC9F2F
        B5689F214922C0BFD53990867970ABB9034EFBAC06808702B12C43A94EC93B36
        BC2DEF389165161B6365BB6A0044049E6A5D4A56E991949C8A77F2AC32929871
        F0BD44AE2807205AFD2DFC4189A66CA0C450820371040EB18198981242610371
        ACF96F64B046FD0FE22625E3DA6A63E80000000049454E44AE426082}
      CaptionOptions.Text = 'Ricerca/Filtri'
      Index = -1
    end
    object dxLayoutEmptySpaceItemLeft: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupRicercaFiltri
      AlignVert = avCenter
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Elemento di spazio vuoto'
      Index = 0
    end
    object dxLayoutItemMappa: TdxLayoutItem
      Parent = dxLayoutGroupCAP
      AlignHorz = ahRight
      CaptionOptions.Text = 'Nuovo oggetto'
      CaptionOptions.Visible = False
      Control = btnMappa
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 25
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutEmptySpaceItemCAP: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupCAP
      AlignHorz = ahRight
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Elemento di spazio vuoto'
      Index = 2
    end
    object dxLayoutGroupCAP: TdxLayoutGroup
      Parent = dxLayoutGroupRicercaFiltri
      AlignHorz = ahClient
      CaptionOptions.Text = 'New Group'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 5
    end
    object dxLayoutSplitterItemSettore: TdxLayoutSplitterItem
      Parent = dxLayoutGroupRicercaFiltri
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      CaptionOptions.Text = 'Splitter'
      Index = 2
    end
    object dxLayoutSplitterItemPIVACodFisc: TdxLayoutSplitterItem
      Parent = dxLayoutGroupRicercaFiltri
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      CaptionOptions.Text = 'Splitter'
      Index = 8
    end
    object dxLayoutSplitterItemEnte: TdxLayoutSplitterItem
      Parent = dxLayoutGroupRicercaFiltri
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      CaptionOptions.Text = 'Splitter'
      Index = 10
    end
    object dxLayoutSplitterItemRagioneSociale: TdxLayoutSplitterItem
      Parent = dxLayoutGroupRicercaFiltri
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      CaptionOptions.Text = 'Splitter'
      Index = 6
    end
    object dxLayoutItemDisponibilita: TdxLayoutItem
      Parent = dxLayoutGroupRicercaFiltri
      AlignHorz = ahClient
      AlignVert = avCenter
      CaptionOptions.Text = 'Disponibilit'#224
      Control = edFiltroDisponibilita
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 193
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutSplitterItemDisponibilita: TdxLayoutSplitterItem
      Parent = dxLayoutGroupRicercaFiltri
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      CaptionOptions.Text = 'Splitter'
      Index = 4
    end
  end
  object zMap: TzMap [2]
    Left = 104
    Top = 240
    Width = 322
    Height = 153
    TabOrder = 6
    Console = False
    ToolActions = <>
    OnMapInitialized = zMapMapInitialized
    OnMarkerClick = zMapMarkerClick
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList16
    Left = 208
    Top = 64
    object MostraSuMappa: TAction
      Caption = 'Mostra Su Mappa'
      ImageIndex = 192
      OnExecute = MostraSuMappaExecute
    end
  end
  object dxLayoutLookAndFeelList: TdxLayoutLookAndFeelList
    Left = 336
    Top = 64
  end
end
