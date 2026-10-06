inherited FormStudentiRilevamentoPresenzeAssenze: TFormStudentiRilevamentoPresenzeAssenze
  Caption = 'Rilevamento Presenze/Assenze'
  ClientHeight = 690
  ClientWidth = 1140
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 1156
  ExplicitHeight = 729
  TextHeight = 15
  object layoutControlli: TdxLayoutControl [1]
    Left = 0
    Top = 32
    Width = 1140
    Height = 658
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    object edProgetto: TcxExtLookupComboBox
      Left = 85
      Top = 16
      Properties.ImmediateDropDownWhenActivated = True
      Properties.ImmediatePost = True
      Properties.OnEditValueChanged = edProgettoPropertiesEditValueChanged
      EditValue = 0
      TabOrder = 0
      Width = 481
    end
    object viewPresenti: TzDbView
      Left = 16
      Top = 53
      Width = 394
      Height = 354
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
      TabOrder = 4
      ToolActions = <
        item
          Name = 'RegistraAssenze'
          Action = RegistraAssenze
          ShowCaption = True
        end
        item
          Name = 'RegistraAttivitaIndividuali'
          Action = RegistraAttivitaIndividuali
          ShowCaption = True
        end>
      ToolFilters = <>
    end
    object viewAssenti: TzDbView
      Left = 730
      Top = 53
      Width = 394
      Height = 589
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
      TabOrder = 12
      ToolActions = <>
      ToolFilters = <>
    end
    object cxDateNavigator: TcxDateNavigator
      Left = 419
      Top = 53
      Width = 302
      Height = 233
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = []
      TabOrder = 6
      OnClick = cxDateNavigatorClick
    end
    object edOreSvolte: TcxDBTextEdit
      Left = 581
      Top = 376
      DataBinding.DataField = 'ORE_LEZIONE'
      DataBinding.DataSource = OreLezioneSrc
      Properties.Alignment.Horz = taRightJustify
      Properties.ReadOnly = True
      Style.HotTrack = False
      TabOrder = 9
      Width = 140
    end
    object edOrePreviste: TcxDBTextEdit
      Left = 419
      Top = 376
      DataBinding.DataField = 'ORE_PREVISTE'
      DataBinding.DataSource = OreLezioneSrc
      Properties.Alignment.Horz = taRightJustify
      Properties.ReadOnly = True
      Style.HotTrack = False
      TabOrder = 8
      Width = 153
    end
    object btnAnnullaFrequenza: TcxButton
      Left = 419
      Top = 447
      Width = 302
      Height = 25
      Action = AnnullaFrequenza
      TabOrder = 11
    end
    object btnAssegnaFrequenza: TcxButton
      Left = 419
      Top = 413
      Width = 302
      Height = 25
      Action = AssegnaFrequenza
      TabOrder = 10
    end
    object labelData: TcxLabel
      Left = 419
      Top = 295
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -19
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Properties.Alignment.Horz = taCenter
      TabOrder = 7
      Transparent = True
      AnchorX = 570
    end
    object edDataInizioCorso: TcxDBTextEdit
      Left = 662
      Top = 16
      DataBinding.DataField = 'DATA_INIZIO_PROGETTO'
      DataBinding.DataSource = OreLezioneSrc
      Properties.Alignment.Horz = taLeftJustify
      Properties.ReadOnly = True
      Style.HotTrack = False
      TabOrder = 1
      Width = 120
    end
    object edDataFineCorso: TcxDBTextEdit
      Left = 869
      Top = 16
      DataBinding.DataField = 'DATA_FINE_PROGETTO'
      DataBinding.DataSource = OreLezioneSrc
      Properties.Alignment.Horz = taLeftJustify
      Properties.ReadOnly = True
      Style.HotTrack = False
      TabOrder = 2
      Width = 120
    end
    object edNumeroStudenti: TcxDBTextEdit
      Left = 1064
      Top = 16
      DataBinding.DataField = 'NUMERO_STUDENTI'
      DataBinding.DataSource = OreLezioneSrc
      Properties.Alignment.Horz = taRightJustify
      Properties.ReadOnly = True
      Style.HotTrack = False
      TabOrder = 3
      Width = 60
    end
    object viewIndividuali: TzDbView
      Left = 16
      Top = 427
      Width = 394
      Height = 215
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
      TabOrder = 5
      ToolActions = <>
      ToolFilters = <>
    end
    object layoutControlliGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      ItemIndex = 1
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemProgetto: TdxLayoutItem
      Parent = dxLayoutGroupTop
      AlignHorz = ahClient
      AlignVert = avCenter
      SizeOptions.AssignedValues = [sovSizableHorz]
      SizeOptions.SizableHorz = False
      CaptionOptions.Text = 'Progetto:'
      Control = edProgetto
      ControlOptions.OriginalHeight = 28
      ControlOptions.OriginalWidth = 450
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupTop: TdxLayoutGroup
      Parent = layoutControlliGroup_Root
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      ItemIndex = 3
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutItemPresenti: TdxLayoutItem
      Parent = dxLayoutGroup1
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = viewPresenti
      ControlOptions.OriginalHeight = 329
      ControlOptions.OriginalWidth = 509
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemNavigator: TdxLayoutItem
      Parent = dxLayoutGroupNavigator
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = cxDateNavigator
      ControlOptions.OriginalHeight = 233
      ControlOptions.OriginalWidth = 147
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemAssenti: TdxLayoutItem
      Parent = dxLayoutGroupMain
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = viewAssenti
      ControlOptions.OriginalHeight = 329
      ControlOptions.OriginalWidth = 509
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutGroupMain: TdxLayoutGroup
      Parent = layoutControlliGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOreSvolte: TdxLayoutItem
      Parent = dxLayoutGroupOre
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Ore di lezione svolte:'
      CaptionOptions.Layout = clTop
      Control = edOreSvolte
      ControlOptions.OriginalHeight = 28
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOrePreviste: TdxLayoutItem
      Parent = dxLayoutGroupOre
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Ore di lezione previste:'
      CaptionOptions.Layout = clTop
      Control = edOrePreviste
      ControlOptions.OriginalHeight = 28
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemAnnullaFrequenza: TdxLayoutItem
      Parent = dxLayoutGroupNavigator
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = btnAnnullaFrequenza
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 5
    end
    object dxLayoutItemAssegnaFrequenza: TdxLayoutItem
      Parent = dxLayoutGroupNavigator
      CaptionOptions.Text = 'cxButton2'
      CaptionOptions.Visible = False
      Control = btnAssegnaFrequenza
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutGroupNavigator: TdxLayoutGroup
      Parent = dxLayoutGroupMain
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      ItemIndex = 6
      ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupOre: TdxLayoutGroup
      Parent = dxLayoutGroupNavigator
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      ItemIndex = 1
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 3
    end
    object dxLayoutItemData: TdxLayoutItem
      Parent = dxLayoutGroupNavigator
      AlignHorz = ahClient
      CaptionOptions.Text = 'Data:'
      CaptionOptions.Visible = False
      Control = labelData
      ControlOptions.OriginalHeight = 29
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutSeparatorItem1: TdxLayoutSeparatorItem
      Parent = dxLayoutGroupNavigator
      CaptionOptions.Text = 'Separator'
      Index = 2
    end
    object dxLayoutItemDataInizio: TdxLayoutItem
      Parent = dxLayoutGroupTop
      AlignHorz = ahRight
      CaptionOptions.Text = 'Inizio corso:'
      Control = edDataInizioCorso
      ControlOptions.OriginalHeight = 28
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemDataFine: TdxLayoutItem
      Parent = dxLayoutGroupTop
      AlignHorz = ahRight
      CaptionOptions.Text = 'Fine corso:'
      Control = edDataFineCorso
      ControlOptions.OriginalHeight = 28
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemNumeroStudenti: TdxLayoutItem
      Parent = dxLayoutGroupTop
      AlignHorz = ahRight
      CaptionOptions.Text = 'Studenti:'
      Control = edNumeroStudenti
      ControlOptions.OriginalHeight = 28
      ControlOptions.OriginalWidth = 60
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupNavigator
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 6
    end
    object dxLayoutItemIndividuali: TdxLayoutItem
      Parent = dxLayoutGroup1
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Visible = False
      Control = viewIndividuali
      ControlOptions.OriginalHeight = 200
      ControlOptions.OriginalWidth = 509
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutGroup1: TdxLayoutGroup
      Parent = dxLayoutGroupMain
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      ItemIndex = 2
      ShowBorder = False
      Index = 0
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
  inherited dxBarManager: TdxBarManager
    Top = 48
    PixelsPerInch = 96
    inherited barSistema: TdxBar
      DockedLeft = 133
    end
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList24
    Left = 320
    Top = 384
    object AssegnaFrequenza: TAction
      Caption = 'Assegna Frequenza Giornaliera'
      OnExecute = AssegnaFrequenzaExecute
    end
    object AnnullaFrequenza: TAction
      Caption = 'Annulla Frequenza Giornaliera'
      OnExecute = AnnullaFrequenzaExecute
    end
    object RegistraAssenze: TAction
      Caption = 'Registra Assenze'
      ImageIndex = 446
      OnExecute = RegistraAssenzeExecute
    end
    object RegistraAttivitaIndividuali: TAction
      Caption = 'Registra Attivit'#224' Individuali'
      ImageIndex = 164
      OnExecute = RegistraAttivitaIndividualiExecute
    end
  end
  object OreLezioneSrc: TDataSource
    Left = 192
    Top = 160
  end
end
