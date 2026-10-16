inherited FormPrenotazioniAule: TFormPrenotazioniAule
  Caption = 'Prenotazioni Aule'
  ClientHeight = 712
  ClientWidth = 1248
  StyleElements = [seFont, seClient, seBorder]
  ExplicitWidth = 1264
  ExplicitHeight = 751
  TextHeight = 15
  object FrameScheduler: TzDbScheduler [1]
    Left = 56
    Top = 168
    Width = 817
    Height = 473
    TabOrder = 5
    ToolActions = <>
    ToolFilters = <>
  end
  object layout: TdxLayoutControl [2]
    Left = 776
    Top = 88
    Width = 449
    Height = 457
    TabOrder = 6
    object viewSlotLiberi: TzDbView
      Left = 10000
      Top = 10000
      Width = 424
      Height = 244
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
      TabOrder = 10
      Visible = False
      OnDblClick = viewSlotLiberiDblClick
      ToolActions = <
        item
          Name = 'PrenotaAula'
          Action = PrenotaAula
          ShowCaption = True
        end>
      ToolFilters = <>
    end
    object edDalGiorno: TcxDateEdit
      Left = 10000
      Top = 10000
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 1
      Visible = False
      Width = 124
    end
    object edAlGiorno: TcxDateEdit
      Left = 10000
      Top = 10000
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 2
      Visible = False
      Width = 123
    end
    object edDurata: TcxSpinEdit
      Left = 10000
      Top = 10000
      Properties.ImmediatePost = True
      Properties.Increment = 30.000000000000000000
      Properties.LargeIncrement = 60.000000000000000000
      Properties.MinValue = 15.000000000000000000
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 7
      Value = 60
      Visible = False
      Width = 70
    end
    object edMinutiIncremento: TcxSpinEdit
      Left = 10000
      Top = 10000
      Properties.ImmediatePost = True
      Properties.Increment = 15.000000000000000000
      Properties.LargeIncrement = 60.000000000000000000
      Properties.MinValue = 15.000000000000000000
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 8
      Value = 60
      Visible = False
      Width = 70
    end
    object edDalleOre: TcxTimeEdit
      Left = 10000
      Top = 10000
      Properties.ImmediatePost = True
      Properties.TimeFormat = tfHourMin
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 3
      Visible = False
      Width = 124
    end
    object edAlleOre: TcxTimeEdit
      Left = 10000
      Top = 10000
      Properties.ImmediatePost = True
      Properties.TimeFormat = tfHourMin
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 4
      Visible = False
      Width = 123
    end
    object btnGiorniLiberi: TcxButton
      Left = 10000
      Top = 10000
      Width = 100
      Height = 25
      Action = CercaSlotLiberi
      TabOrder = 9
      Visible = False
    end
    object edAula: TcxExtLookupComboBox
      Left = 10000
      Top = 10000
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      TabOrder = 5
      Visible = False
      OnKeyUp = edAulaKeyUp
      Width = 124
    end
    object viewSelezionaAule: TzDbView
      Left = 25
      Top = 47
      Width = 424
      Height = 368
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
      OnSelectionChanged = viewSelezionaAuleSelectionChanged
      ToolActions = <>
      ToolFilters = <>
    end
    object viewRiepilogoOccupazioni: TzDbView
      Left = 10000
      Top = 10000
      Width = 424
      Height = 368
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
      TabOrder = 11
      Visible = False
      ToolActions = <>
      ToolFilters = <>
    end
    object edSede: TcxExtLookupComboBox
      Left = 10000
      Top = 10000
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.TransparentBorder = False
      Style.IsFontAssigned = True
      TabOrder = 6
      Visible = False
      OnKeyUp = edSedeKeyUp
      Width = 123
    end
    object layoutGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      LayoutDirection = ldTabbed
      ShowBorder = False
      Index = -1
    end
    object dxLayoutGroupGiorniLiberiPerAulaTab: TdxLayoutGroup
      Parent = layoutGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'Ricerca Aule Libere'
      CaptionOptions.Visible = False
      ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupFiltriGiorniLiberiPerAula: TdxLayoutGroup
      Parent = dxLayoutGroupGiorniLiberiPerAulaTab
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      ShowBorder = False
      Index = 0
    end
    object dxLayoutItemGiorniLiberiPerAula: TdxLayoutItem
      Parent = dxLayoutGroupGiorniLiberiPerAulaTab
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'Date libere per aula'
      CaptionOptions.Visible = False
      Control = viewSlotLiberi
      ControlOptions.OriginalHeight = 100
      ControlOptions.OriginalWidth = 200
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemDalGiorno: TdxLayoutItem
      Parent = dxLayoutGroupFiltriGiorniLiberiPerAulaDate
      AlignHorz = ahClient
      CaptionOptions.Text = 'Dal giorno:'
      CaptionOptions.Width = 80
      Control = edDalGiorno
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemAlGiorno: TdxLayoutItem
      Parent = dxLayoutGroupFiltriGiorniLiberiPerAulaDate
      AlignHorz = ahClient
      CaptionOptions.Text = 'Al giorno:'
      CaptionOptions.Width = 80
      Control = edAlGiorno
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemDalleOre: TdxLayoutItem
      Parent = dxLayoutGroupFiltriGiorniLiberiPerAulaOre
      AlignHorz = ahClient
      CaptionOptions.Text = 'Dalle ore:'
      CaptionOptions.Width = 80
      Control = edDalleOre
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemAlleOre: TdxLayoutItem
      Parent = dxLayoutGroupFiltriGiorniLiberiPerAulaOre
      AlignHorz = ahClient
      CaptionOptions.Text = 'Alle ore:'
      CaptionOptions.Width = 80
      Control = edAlleOre
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemDurata: TdxLayoutItem
      Parent = dxLayoutGroupFiltriGiorniLiberiPerAulaCerca
      CaptionOptions.Text = 'Durata evento:'
      CaptionOptions.Width = 80
      Control = edDurata
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemMinutiIncremento: TdxLayoutItem
      Parent = dxLayoutGroupFiltriGiorniLiberiPerAulaCerca
      Visible = False
      CaptionOptions.Text = 'Granularit'#224':'
      CaptionOptions.Width = 80
      Control = edMinutiIncremento
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemBtnCerca: TdxLayoutItem
      Parent = dxLayoutGroupFiltriGiorniLiberiPerAulaCerca
      AlignHorz = ahRight
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnGiorniLiberi
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutGroupFiltriGiorniLiberiPerAulaDate: TdxLayoutGroup
      Parent = dxLayoutGroupFiltriGiorniLiberiPerAula
      CaptionOptions.Text = 'New Group'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupFiltriGiorniLiberiPerAulaOre: TdxLayoutGroup
      Parent = dxLayoutGroupFiltriGiorniLiberiPerAula
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupFiltriGiorniLiberiPerAulaCerca: TdxLayoutGroup
      Parent = dxLayoutGroupFiltriGiorniLiberiPerAula
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 3
    end
    object dxLayoutItemAula: TdxLayoutItem
      Parent = dxLayoutGroupAula
      AlignHorz = ahClient
      CaptionOptions.Text = 'Aula:'
      CaptionOptions.Width = 80
      Control = edAula
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupAula: TdxLayoutGroup
      Parent = dxLayoutGroupFiltriGiorniLiberiPerAula
      CaptionOptions.Text = 'New Group'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 2
    end
    object dxLayoutItemSelezionaAule: TdxLayoutItem
      Parent = layoutGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'Seleziona Aule'
      CaptionOptions.Visible = False
      Control = viewSelezionaAule
      ControlOptions.OriginalHeight = 329
      ControlOptions.OriginalWidth = 509
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemRiepilogoOccupazioni: TdxLayoutItem
      Parent = layoutGroup_Root
      AlignVert = avClient
      CaptionOptions.Text = 'Riepilogo Occupazioni'
      CaptionOptions.Visible = False
      Control = viewRiepilogoOccupazioni
      ControlOptions.OriginalHeight = 329
      ControlOptions.OriginalWidth = 509
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemSede: TdxLayoutItem
      Parent = dxLayoutGroupAula
      AlignHorz = ahClient
      CaptionOptions.Text = 'Sede:'
      CaptionOptions.Width = 80
      Control = edSede
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 1
    end
  end
  inherited dxBarManager: TdxBarManager [3]
    Left = 64
    PixelsPerInch = 96
    inherited barSistema: TdxBar
      DockedLeft = 687
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
      ImageIndex = 2296
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
      ImageIndex = 2298
    end
    object dxBarButton5: TdxBarButton
      Caption = 'Copia'
      Category = 0
      Visible = ivAlways
      ImageIndex = 2297
    end
    object dxBarButton6: TdxBarButton
      Caption = 'Modifica'
      Category = 0
      Visible = ivAlways
      ImageIndex = 2300
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
      Visible = ivAlways
      ImageIndex = 2296
    end
    object dxBarButton14: TdxBarButton
      Caption = 'Anteprima'
      Category = 0
      Hint = 'anteprima di stampa'
      Visible = ivAlways
      ImageIndex = 169
    end
    object dxBarButton17: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
    object dxBarButton18: TdxBarButton
      Caption = 'Nessun Raggruppamento'
      Category = 0
      Hint = 'nessun raggruppamentoGroup By None'
      Visible = ivAlways
      ImageIndex = 1807
    end
    object dxBarButton19: TdxBarButton
      Caption = 'Raggruppa Per Data'
      Category = 0
      Hint = 'raggruppa per data'
      Visible = ivAlways
      ImageIndex = 1397
    end
    object dxBarButton20: TdxBarButton
      Caption = 'Raggruppa Per Risorsa'
      Category = 0
      Hint = 'raggruppa per risorsa'
      Visible = ivAlways
      ImageIndex = 1025
    end
    object dxBarButton21: TdxBarButton
      Caption = 'Seleziona Aule'
      Category = 0
      Hint = 'layout risorse'
      Visible = ivAlways
      ImageIndex = 952
    end
    object dxBarButton26: TdxBarButton
      Caption = 'Giorno'
      Category = 0
      Visible = ivAlways
      ButtonStyle = bsChecked
      Down = True
      ImageIndex = 477
    end
    object dxBarButton27: TdxBarButton
      Caption = 'Settimana'
      Category = 0
      Visible = ivAlways
      ButtonStyle = bsChecked
      ImageIndex = 484
    end
    object dxBarButton28: TdxBarButton
      Caption = 'Mese'
      Category = 0
      Visible = ivAlways
      ButtonStyle = bsChecked
      ImageIndex = 478
    end
    object dxBarButton29: TdxBarButton
      Caption = 'Seleziona Aule'
      Category = 0
      Hint = 'layout risorse'
      Visible = ivAlways
      ImageIndex = 952
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
    object dxBarButton30: TdxBarButton
      Caption = 'Solo Prenotazioni'
      Category = 0
      Visible = ivAlways
      ButtonStyle = bsChecked
      ImageIndex = 1020
    end
    object dxBarButtonNewEvent: TdxBarButton
      Caption = 'Nuovo'
      Category = 1
      Hint = 'nuovo'
      Visible = ivAlways
      ImageIndex = 2295
      LargeImageIndex = 2295
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
  inherited BaseActions: TActionList [4]
    Left = 148
    Top = 56
  end
  inherited popActions: TdxBarPopupMenu
    Left = 52
    Top = 120
    PixelsPerInch = 96
  end
  object Actions: TActionList
    Images = dx.Immagini
    Left = 213
    Top = 56
    object CercaSlotLiberi: TAction
      Caption = 'Cerca'
      ImageIndex = 2299
      OnExecute = CercaSlotLiberiExecute
    end
    object PrenotaAula: TAction
      Caption = 'Prenota'
      ImageIndex = 1020
      OnExecute = PrenotaAulaExecute
    end
    object PrenotazionePeriodo: TAction
      Caption = 'Prenota'
      ImageIndex = 1020
      OnExecute = PrenotazionePeriodoExecute
    end
  end
  object TimerSelezione: TTimer
    Enabled = False
    Interval = 300
    OnTimer = TimerSelezioneTimer
    Left = 56
    Top = 208
  end
end
