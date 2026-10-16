inherited FormOrario: TFormOrario
  Caption = 'Calendario Corsi'
  ClientHeight = 617
  ClientWidth = 1104
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 1120
  ExplicitHeight = 656
  TextHeight = 15
  inherited lblTitolo: TcxLabel
    TabOrder = 1
  end
  object edProgetto: TcxExtLookupComboBox [1]
    Left = 171
    Top = 91
    ParentFont = False
    Properties.DropDownAutoSize = True
    Properties.DropDownRows = 12
    Properties.DropDownSizeable = True
    Properties.ImmediateDropDownWhenActivated = True
    Properties.ImmediatePost = True
    Properties.OnEditValueChanged = edProgettoPropertiesEditValueChanged
    EditValue = 0
    Style.BorderColor = clWindowFrame
    Style.BorderStyle = ebs3D
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -13
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.ButtonStyle = bts3D
    Style.PopupBorderStyle = epbsFrame3D
    Style.IsFontAssigned = True
    TabOrder = 5
    OnClick = AutoDropDown
    OnEnter = AutoDropDown
    Width = 300
  end
  object edCorso: TcxExtLookupComboBox [2]
    Left = 477
    Top = 91
    ParentFont = False
    Properties.DropDownAutoSize = True
    Properties.DropDownRows = 12
    Properties.DropDownSizeable = True
    Properties.ImmediateDropDownWhenActivated = True
    Properties.ImmediatePost = True
    Properties.OnEditValueChanged = edCorsoPropertiesEditValueChanged
    EditValue = 0
    Style.BorderColor = clWindowFrame
    Style.BorderStyle = ebs3D
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -13
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.HotTrack = False
    Style.TransparentBorder = False
    Style.ButtonStyle = bts3D
    Style.PopupBorderStyle = epbsFrame3D
    Style.IsFontAssigned = True
    TabOrder = 6
    OnClick = AutoDropDown
    OnEnter = AutoDropDown
    Width = 300
  end
  object layoutControlViews: TdxLayoutControl [3]
    Left = 620
    Top = 250
    Width = 286
    Height = 279
    TabOrder = 0
    object viewMaterie: TzDbView
      Left = 12
      Top = 12
      Width = 262
      Height = 62
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
    object viewDocenti: TzDbView
      Left = 12
      Top = 90
      Width = 262
      Height = 80
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
    object viewAule: TzDbView
      Left = 12
      Top = 186
      Width = 262
      Height = 81
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
      TabOrder = 2
      ToolActions = <>
      ToolFilters = <>
    end
    object layoutControlViewsGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemMaterie: TdxLayoutItem
      Parent = layoutControlViewsGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = viewMaterie
      ControlOptions.OriginalHeight = 329
      ControlOptions.OriginalWidth = 509
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemDocenti: TdxLayoutItem
      Parent = layoutControlViewsGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = viewDocenti
      ControlOptions.OriginalHeight = 431
      ControlOptions.OriginalWidth = 266
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemAule: TdxLayoutItem
      Parent = layoutControlViewsGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = viewAule
      ControlOptions.OriginalHeight = 431
      ControlOptions.OriginalWidth = 266
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object layoutControlViewsSplitterItem1: TdxLayoutSplitterItem
      Parent = layoutControlViewsGroup_Root
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      CaptionOptions.Text = 'Splitter'
      Index = 1
    end
    object layoutControlViewsSplitterItem2: TdxLayoutSplitterItem
      Parent = layoutControlViewsGroup_Root
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      CaptionOptions.Text = 'Splitter'
      Index = 3
    end
  end
  object FrameScheduler: TzDbScheduler [4]
    Left = 101
    Top = 250
    Width = 500
    Height = 300
    TabOrder = 8
    ToolActions = <>
    ToolFilters = <>
  end
  object layoutGenerazione: TdxLayoutControl [5]
    Left = 100
    Top = 150
    Width = 806
    Height = 106
    TabOrder = 9
    AutoSize = True
    object edDalGiorno: TcxDateEdit
      Left = 43
      Top = 67
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.AssignedValues.DisplayFormat = True
      Properties.AssignedValues.EditFormat = True
      Properties.DateButtons = [btnClear, btnToday]
      Properties.ReadOnly = False
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Properties.OnEditValueChanged = edDalGiornoPropertiesEditValueChanged
      TabOrder = 0
      Width = 130
    end
    object edAlGiorno: TcxDateEdit
      Left = 180
      Top = 67
      ParentFont = False
      Properties.Alignment.Horz = taLeftJustify
      Properties.AssignedValues.DisplayFormat = True
      Properties.AssignedValues.EditFormat = True
      Properties.DateButtons = [btnClear, btnToday]
      Properties.ReadOnly = False
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.ValidationErrorIconAlignment = taRightJustify
      Properties.ValidationOptions = [evoShowErrorIcon, evoAllowLoseFocus]
      Properties.OnEditValueChanged = edAlGiornoPropertiesEditValueChanged
      TabOrder = 1
      Width = 130
    end
    object tnOk: TcxButton
      Left = 682
      Top = 33
      Width = 75
      Height = 25
      Action = GeneraCalendario
      ModalResult = 1
      TabOrder = 9
    end
    object checkLunedi: TcxCheckBox
      Left = 334
      Top = 45
      Caption = 'Luned'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Properties.OnEditValueChanged = edGeneraCalendarioEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 2
      Transparent = True
    end
    object checkMartedi: TcxCheckBox
      Left = 334
      Top = 71
      Caption = 'Marted'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 3
      Transparent = True
    end
    object checkMercoledi: TcxCheckBox
      Left = 421
      Top = 45
      Caption = 'Mercoled'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 4
      Transparent = True
    end
    object checkGiovedi: TcxCheckBox
      Left = 421
      Top = 71
      Caption = 'Gioved'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 5
      Transparent = True
    end
    object checkVenerdi: TcxCheckBox
      Left = 508
      Top = 45
      Caption = 'Venerd'#236
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 6
      Transparent = True
    end
    object checkSabato: TcxCheckBox
      Left = 508
      Top = 71
      Caption = 'Sabato'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 7
      Transparent = True
    end
    object checkDomenica: TcxCheckBox
      Left = 595
      Top = 71
      Caption = 'Domenica'
      Properties.Alignment = taLeftJustify
      Properties.ImmediatePost = True
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 8
      Transparent = True
    end
    object btnEliminaCalendario: TcxButton
      Left = 682
      Top = 65
      Width = 75
      Height = 25
      Action = EliminaCalendario
      ModalResult = 1
      TabOrder = 10
    end
    object layoutGenerazioneGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avTop
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemDataInizio: TdxLayoutItem
      Parent = dxLayoutGroupGenerazione
      AlignVert = avBottom
      CaptionOptions.Text = 'Dal Giorno:'
      CaptionOptions.Layout = clTop
      Control = edDalGiorno
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 130
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemDataFine: TdxLayoutItem
      Parent = dxLayoutGroupGenerazione
      AlignVert = avBottom
      CaptionOptions.Text = 'Al Giorno:'
      CaptionOptions.Layout = clTop
      Control = edAlGiorno
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 130
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemLabelLunedi: TdxLayoutItem
      Parent = layoutGenerazioneGroup1
      AlignVert = avBottom
      SizeOptions.Width = 80
      CaptionOptions.Text = 'Giorno:'
      CaptionOptions.Visible = False
      CaptionOptions.WordWrap = True
      CaptionOptions.Layout = clTop
      Control = checkLunedi
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 54
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemLabelMartedi: TdxLayoutItem
      Parent = layoutGenerazioneGroup1
      AlignVert = avBottom
      SizeOptions.Width = 80
      CaptionOptions.Text = 'Giorno:'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = checkMartedi
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 59
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemLabelMercoledi: TdxLayoutItem
      Parent = layoutGenerazioneGroup2
      AlignVert = avBottom
      SizeOptions.Width = 80
      CaptionOptions.Text = 'checkMercoledi'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = checkMercoledi
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 71
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemLabelDomenica: TdxLayoutItem
      Parent = layoutGenerazioneGroup4
      AlignVert = avBottom
      SizeOptions.Width = 80
      CaptionOptions.Text = 'checkDomenica'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = checkDomenica
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 72
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemLabelSabato: TdxLayoutItem
      Parent = layoutGenerazioneGroup3
      AlignVert = avBottom
      SizeOptions.Width = 80
      CaptionOptions.Text = 'checkSabato'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = checkSabato
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 54
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemLabelVenerdi: TdxLayoutItem
      Parent = layoutGenerazioneGroup3
      AlignVert = avBottom
      SizeOptions.Width = 80
      CaptionOptions.Text = 'checkVenerdi'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = checkVenerdi
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 57
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemLabelGiovedi: TdxLayoutItem
      Parent = layoutGenerazioneGroup2
      AlignVert = avBottom
      SizeOptions.Width = 80
      CaptionOptions.Text = 'checkGiovedi'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = checkGiovedi
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 58
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemOk: TdxLayoutItem
      Parent = dxLayoutGenerazionePulsanti
      SizeOptions.Width = 75
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = tnOk
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object layoutGenerazioneEmptySpaceItem2: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupGenerazione
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Elemento di spazio vuoto'
      Index = 3
    end
    object layoutGenerazioneGroup1: TdxLayoutGroup
      Parent = dxLayoutGroupGenerazione
      CaptionOptions.Text = 'Nuovo gruppo'
      ShowBorder = False
      Index = 4
    end
    object layoutGenerazioneGroup2: TdxLayoutGroup
      Parent = dxLayoutGroupGenerazione
      CaptionOptions.Text = 'Nuovo gruppo'
      ShowBorder = False
      Index = 5
    end
    object layoutGenerazioneGroup3: TdxLayoutGroup
      Parent = dxLayoutGroupGenerazione
      CaptionOptions.Text = 'Nuovo gruppo'
      ShowBorder = False
      Index = 6
    end
    object layoutGenerazioneGroup4: TdxLayoutGroup
      Parent = dxLayoutGroupGenerazione
      CaptionOptions.Text = 'Nuovo gruppo'
      ShowBorder = False
      Index = 7
    end
    object layoutGenerazioneEmptySpaceItem1: TdxLayoutEmptySpaceItem
      Parent = dxLayoutGroupGenerazione
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Elemento di spazio vuoto'
      Index = 0
    end
    object dxLayoutGroupGenerazione: TdxLayoutGroup
      Parent = layoutGenerazioneGroup_Root
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Generazione Calendario'
      LayoutDirection = ldHorizontal
      Index = 0
    end
    object dxLayoutItemEliminaCalendario: TdxLayoutItem
      Parent = dxLayoutGenerazionePulsanti
      CaptionOptions.Text = 'Nuovo oggetto'
      CaptionOptions.Visible = False
      CaptionOptions.Layout = clTop
      Control = btnEliminaCalendario
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGenerazionePulsanti: TdxLayoutGroup
      Parent = dxLayoutGroupGenerazione
      CaptionOptions.Text = 'Nuovo gruppo'
      ShowBorder = False
      Index = 8
    end
    object dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem
      Parent = layoutGenerazioneGroup4
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Elemento di spazio vuoto'
      Index = 0
    end
  end
  object edEnte: TcxExtLookupComboBox [6]
    Left = 171
    Top = 53
    ParentFont = False
    Properties.OnEditValueChanged = edEntePropertiesEditValueChanged
    Style.BorderColor = clWindowFrame
    Style.BorderStyle = ebs3D
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -13
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.HotTrack = False
    Style.TransparentBorder = False
    Style.ButtonStyle = bts3D
    Style.PopupBorderStyle = epbsFrame3D
    Style.IsFontAssigned = True
    TabOrder = 10
    OnClick = AutoDropDown
    OnEnter = AutoDropDown
    Width = 175
  end
  object edProgettoCodReg: TcxExtLookupComboBox [7]
    Left = 352
    Top = 53
    ParentFont = False
    Properties.OnEditValueChanged = edProgettoCodRegPropertiesEditValueChanged
    Style.BorderColor = clWindowFrame
    Style.BorderStyle = ebs3D
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -13
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.HotTrack = False
    Style.TransparentBorder = False
    Style.ButtonStyle = bts3D
    Style.PopupBorderStyle = epbsFrame3D
    Style.IsFontAssigned = True
    TabOrder = 11
    OnClick = AutoDropDown
    OnEnter = AutoDropDown
    Width = 150
  end
  inherited dxBarManager: TdxBarManager
    Left = 120
    PixelsPerInch = 96
    inherited barSistema: TdxBar
      DockedLeft = 410
    end
    object dxBarManagerBarAgenda: TdxBar [3]
      Caption = 'Agenda'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsNone
      FloatLeft = 1069
      FloatTop = 8
      FloatClientWidth = 78
      FloatClientHeight = 216
      ItemLinks = <>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = False
      WholeRow = False
    end
    object dxBarButton11: TdxBarButton
      Caption = 'Risorse'
      Category = 0
      Visible = ivAlways
    end
    object dxBarButton12: TdxBarButton
      Caption = 'Esporta'
      Category = 0
      Visible = ivAlways
      ImageIndex = 2184
    end
    object dxBarLargeButton6: TdxBarLargeButton
      Caption = 'Docenti'
      Category = 0
      Visible = ivAlways
      LargeImageIndex = 1344
    end
    object dxBarButton1: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
    object dxBarButton8: TdxBarButton
      Caption = 'Incolla'
      Category = 0
      Visible = ivAlways
      ImageIndex = 85
    end
    object dxBarButton3: TdxBarButton
      Caption = 'Copia Settimana'
      Category = 0
      Visible = ivAlways
    end
    object dxBarButton4: TdxBarButton
      Caption = 'Elimina'
      Category = 0
      Visible = ivAlways
      ImageIndex = 2185
    end
    object dxBarButton5: TdxBarButton
      Caption = 'Copia'
      Category = 0
      Visible = ivAlways
      ImageIndex = 1425
    end
    object dxBarButton6: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Visible = ivAlways
      ImageIndex = 2187
    end
    object dxBarButton7: TdxBarButton
      Caption = 'Copia Giorno'
      Category = 0
      Visible = ivAlways
    end
    object dxBarButton9: TdxBarButton
      Caption = 'Taglia'
      Category = 0
      Visible = ivAlways
      ImageIndex = 65
    end
    object dxBarButton10: TdxBarButton
      Caption = 'Solo Orario Lavorativo'
      Category = 0
      Hint = 'solo orario lavorativo'
      Visible = ivAlways
      ImageIndex = 1004
    end
    object dxBarButton13: TdxBarButton
      Caption = 'Esporta'
      Category = 0
      Visible = ivNever
      ImageIndex = 2184
    end
    object dxBarButton14: TdxBarButton
      Caption = 'Anteprima'
      Category = 0
      Hint = 'anteprima di stampa'
      Visible = ivAlways
      ImageIndex = 169
    end
    object dxBarButtonNewEvent: TdxBarButton
      Caption = 'Nuovo'
      Category = 1
      Hint = 'nuovo'
      Visible = ivAlways
      ImageIndex = 1423
      LargeImageIndex = 1423
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'Scala'
      Category = 5
      Visible = ivAlways
      ImageIndex = 480
      LargeImageIndex = 480
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton60Minutes'
        end
        item
          Visible = True
          ItemName = 'dxBarButton30Minutes'
        end
        item
          Visible = True
          ItemName = 'dxBarButton15Minutes'
        end
        item
          Visible = True
          ItemName = 'dxBarButton10Minutes'
        end
        item
          Visible = True
          ItemName = 'dxBarButton6Minutes'
        end
        item
          Visible = True
          ItemName = 'dxBarButton5Minutes'
        end>
    end
    object dxBarButton60Minutes: TdxBarButton
      Caption = '60 Minuti'
      Category = 5
      Hint = '60 minuti'
      Visible = ivAlways
      ButtonStyle = bsChecked
    end
    object dxBarButton30Minutes: TdxBarButton
      Caption = '30 Minuti'
      Category = 5
      Hint = '30 minuti'
      Visible = ivAlways
      ButtonStyle = bsChecked
    end
    object dxBarButton15Minutes: TdxBarButton
      Caption = '15 Minuti'
      Category = 5
      Hint = '15 minuti'
      Visible = ivAlways
      ButtonStyle = bsChecked
    end
    object dxBarButton10Minutes: TdxBarButton
      Caption = '10 Minuti'
      Category = 5
      Hint = '10 minuti'
      Visible = ivAlways
      ButtonStyle = bsChecked
    end
    object dxBarButton6Minutes: TdxBarButton
      Caption = '6 Minuti'
      Category = 5
      Hint = '6 minuti'
      Visible = ivAlways
      ButtonStyle = bsChecked
    end
    object dxBarButton5Minutes: TdxBarButton
      Caption = '5 Minuti'
      Category = 5
      Hint = '5 minuti'
      Visible = ivAlways
      ButtonStyle = bsChecked
    end
  end
  inherited BaseActions: TActionList
    Top = 56
  end
  inherited popActions: TdxBarPopupMenu
    Top = 128
    PixelsPerInch = 96
  end
  object Actions: TActionList
    Images = dx.Immagini
    Left = 201
    Top = 56
    object ImportaFileUntis: TdxFileOpen
      Caption = 'Importa File Untis'
      Dialog.DefaultExt = '*.txt'
      Dialog.Filter = 'Testo|*.txt|Tutti|*.*'
      Dialog.Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
      ImageIndex = 1744
      OnAccept = ImportaFileUntisAccept
    end
    object ImportaFileStandard: TdxFileOpen
      Caption = 'Importa'
      Dialog.DefaultExt = '*.csv'
      Dialog.Filter = 'CSV|*.csv|Tutti|*.*'
      ImageIndex = 2183
      OnAccept = ImportaFileStandardAccept
    end
    object ElaboraFileUntis: TAction
      Caption = 'Elabora File'
      ImageIndex = 1754
      OnExecute = ElaboraFileUntisExecute
    end
    object ApriGeneraCalendario: TAction
      AutoCheck = True
      Caption = 'Generazione Calendario'
      ImageIndex = 1253
      OnExecute = ApriGeneraCalendarioExecute
    end
    object GeneraCalendario: TAction
      Caption = 'Genera'
      ImageIndex = 1794
      OnExecute = GeneraCalendarioExecute
    end
    object AzzeraTmpOrario: TAction
      Caption = 'Azzera'
      ImageIndex = 1792
      OnExecute = AzzeraTmpOrarioExecute
    end
    object RegistroStudenti: TAction
      Caption = 'Registro Studenti'
      ImageIndex = 1347
      OnExecute = RegistroStudentiExecute
    end
    object EliminaCalendario: TAction
      Caption = 'Elimina'
      ImageIndex = 2185
      OnExecute = EliminaCalendarioExecute
    end
  end
end
