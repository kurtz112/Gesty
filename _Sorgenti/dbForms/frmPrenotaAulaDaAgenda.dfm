object FormPrenotaAulaDaAgenda: TFormPrenotaAulaDaAgenda
  Left = 0
  Top = 0
  Caption = 'Prenota aula'
  ClientHeight = 521
  ClientWidth = 744
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
    Top = 0
    Width = 744
    Height = 521
    Align = alClient
    TabOrder = 0
    object edData: TcxDateEdit
      Left = 80
      Top = 44
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 0
      Width = 110
    end
    object edDalleOre: TcxTimeEdit
      Left = 260
      Top = 44
      Properties.ImmediatePost = True
      Properties.TimeFormat = tfHourMin
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 1
      Width = 80
    end
    object edAlleOre: TcxTimeEdit
      Left = 410
      Top = 44
      Properties.ImmediatePost = True
      Properties.TimeFormat = tfHourMin
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 2
      Width = 80
    end
    object btnCercaAuleLibere: TcxButton
      Left = 500
      Top = 43
      Width = 100
      Height = 25
      Action = CercaAuleLibere
      TabOrder = 3
    end
    object viewAuleLibere: TzDbView
      Left = 22
      Top = 80
      Width = 700
      Height = 380
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
      OnDblClick = viewRisultatiDblClick
      ToolActions = <>
      ToolFilters = <>
    end
    object edAula: TcxExtLookupComboBox
      Left = 10000
      Top = 10000
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 5
      Visible = False
      OnKeyUp = edAulaKeyUp
      Width = 250
    end
    object edDalGiorno: TcxDateEdit
      Left = 10000
      Top = 10000
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 6
      Visible = False
      Width = 110
    end
    object edAlGiorno: TcxDateEdit
      Left = 10000
      Top = 10000
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 7
      Visible = False
      Width = 110
    end
    object edDalleOreAula: TcxTimeEdit
      Left = 10000
      Top = 10000
      Properties.ImmediatePost = True
      Properties.TimeFormat = tfHourMin
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 8
      Visible = False
      Width = 80
    end
    object edAlleOreAula: TcxTimeEdit
      Left = 10000
      Top = 10000
      Properties.ImmediatePost = True
      Properties.TimeFormat = tfHourMin
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 9
      Visible = False
      Width = 80
    end
    object edDurata: TcxSpinEdit
      Left = 10000
      Top = 10000
      Properties.ImmediatePost = True
      Properties.Increment = 15.000000000000000000
      Properties.LargeIncrement = 60.000000000000000000
      Properties.MinValue = 15.000000000000000000
      Properties.MaxValue = 720.000000000000000000
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 10
      Value = 60
      Visible = False
      Width = 70
    end
    object edPasso: TcxSpinEdit
      Left = 10000
      Top = 10000
      Properties.ImmediatePost = True
      Properties.Increment = 15.000000000000000000
      Properties.LargeIncrement = 60.000000000000000000
      Properties.MinValue = 5.000000000000000000
      Properties.MaxValue = 240.000000000000000000
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 11
      Value = 30
      Visible = False
      Width = 70
    end
    object chkFineSettimana: TcxCheckBox
      Left = 10000
      Top = 10000
      Caption = 'Includi sabato e domenica'
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 12
      Visible = False
    end
    object btnCercaOrariAula: TcxButton
      Left = 10000
      Top = 10000
      Width = 100
      Height = 25
      Action = CercaOrariAula
      TabOrder = 13
      Visible = False
    end
    object viewSlotLiberiAula: TzDbView
      Left = 10000
      Top = 10000
      Width = 700
      Height = 300
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
      TabOrder = 14
      Visible = False
      OnDblClick = viewRisultatiDblClick
      ToolActions = <>
      ToolFilters = <>
    end
    object btnPrenota: TcxButton
      Left = 530
      Top = 484
      Width = 100
      Height = 25
      Action = Prenota
      TabOrder = 15
    end
    object btnChiudi: TcxButton
      Left = 636
      Top = 484
      Width = 100
      Height = 25
      Action = Chiudi
      TabOrder = 16
    end
    object dxLayoutControlGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutGroupModi: TdxLayoutGroup
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'Modi'
      CaptionOptions.Visible = False
      ItemIndex = 0
      LayoutDirection = ldTabbed
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupAuleLibere: TdxLayoutGroup
      Parent = dxLayoutGroupModi
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'Aule libere in questo orario'
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupFiltriAuleLibere: TdxLayoutGroup
      Parent = dxLayoutGroupAuleLibere
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Filtri'
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutItemData: TdxLayoutItem
      Parent = dxLayoutGroupFiltriAuleLibere
      CaptionOptions.Text = 'Giorno:'
      Control = edData
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 110
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemDalleOre: TdxLayoutItem
      Parent = dxLayoutGroupFiltriAuleLibere
      CaptionOptions.Text = 'Dalle ore:'
      Control = edDalleOre
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 80
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemAlleOre: TdxLayoutItem
      Parent = dxLayoutGroupFiltriAuleLibere
      CaptionOptions.Text = 'Alle ore:'
      Control = edAlleOre
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 80
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemCercaAuleLibere: TdxLayoutItem
      Parent = dxLayoutGroupFiltriAuleLibere
      CaptionOptions.Text = 'Cerca'
      CaptionOptions.Visible = False
      Control = btnCercaAuleLibere
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutItemAuleLibere: TdxLayoutItem
      Parent = dxLayoutGroupAuleLibere
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'Aule libere'
      CaptionOptions.Visible = False
      Control = viewAuleLibere
      ControlOptions.OriginalHeight = 380
      ControlOptions.OriginalWidth = 700
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupOrariAula: TdxLayoutGroup
      Parent = dxLayoutGroupModi
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'Quando '#232' libera un'#39'aula'
      ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupOrariAulaAula: TdxLayoutGroup
      Parent = dxLayoutGroupOrariAula
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Aula'
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutItemAula: TdxLayoutItem
      Parent = dxLayoutGroupOrariAulaAula
      CaptionOptions.Text = 'Aula:'
      CaptionOptions.Width = 70
      Control = edAula
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 250
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupOrariAulaPeriodo: TdxLayoutGroup
      Parent = dxLayoutGroupOrariAula
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Periodo'
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutItemDalGiorno: TdxLayoutItem
      Parent = dxLayoutGroupOrariAulaPeriodo
      CaptionOptions.Text = 'Dal giorno:'
      CaptionOptions.Width = 70
      Control = edDalGiorno
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 110
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemAlGiorno: TdxLayoutItem
      Parent = dxLayoutGroupOrariAulaPeriodo
      CaptionOptions.Text = 'Al giorno:'
      CaptionOptions.Width = 70
      Control = edAlGiorno
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 110
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupOrariAulaFascia: TdxLayoutGroup
      Parent = dxLayoutGroupOrariAula
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Fascia'
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 2
    end
    object dxLayoutItemDalleOreAula: TdxLayoutItem
      Parent = dxLayoutGroupOrariAulaFascia
      CaptionOptions.Text = 'Dalle ore:'
      CaptionOptions.Width = 70
      Control = edDalleOreAula
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 80
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemAlleOreAula: TdxLayoutItem
      Parent = dxLayoutGroupOrariAulaFascia
      CaptionOptions.Text = 'Alle ore:'
      CaptionOptions.Width = 70
      Control = edAlleOreAula
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 80
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupOrariAulaCerca: TdxLayoutGroup
      Parent = dxLayoutGroupOrariAula
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Cerca'
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 3
    end
    object dxLayoutItemDurata: TdxLayoutItem
      Parent = dxLayoutGroupOrariAulaCerca
      CaptionOptions.Text = 'Durata (minuti):'
      Control = edDurata
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemPasso: TdxLayoutItem
      Parent = dxLayoutGroupOrariAulaCerca
      CaptionOptions.Text = 'Ogni (minuti):'
      Control = edPasso
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 70
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemFineSettimana: TdxLayoutItem
      Parent = dxLayoutGroupOrariAulaCerca
      CaptionOptions.Text = 'Fine settimana'
      CaptionOptions.Visible = False
      Control = chkFineSettimana
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 170
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemCercaOrariAula: TdxLayoutItem
      Parent = dxLayoutGroupOrariAulaCerca
      AlignHorz = ahRight
      CaptionOptions.Text = 'Cerca'
      CaptionOptions.Visible = False
      Control = btnCercaOrariAula
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutItemSlotLiberiAula: TdxLayoutItem
      Parent = dxLayoutGroupOrariAula
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'Orari liberi'
      CaptionOptions.Visible = False
      Control = viewSlotLiberiAula
      ControlOptions.OriginalHeight = 300
      ControlOptions.OriginalWidth = 700
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutGroupPulsanti: TdxLayoutGroup
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahRight
      AlignVert = avBottom
      CaptionOptions.Text = 'Pulsanti'
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutItemPrenota: TdxLayoutItem
      Parent = dxLayoutGroupPulsanti
      CaptionOptions.Text = 'Prenota'
      CaptionOptions.Visible = False
      Control = btnPrenota
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemChiudi: TdxLayoutItem
      Parent = dxLayoutGroupPulsanti
      CaptionOptions.Text = 'Chiudi'
      CaptionOptions.Visible = False
      Control = btnChiudi
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 100
      ControlOptions.ShowBorder = False
      Index = 1
    end
  end
  object Actions: TActionList
    Left = 664
    Top = 16
    object CercaAuleLibere: TAction
      Caption = 'Cerca'
      Hint = 'Cerca le aule libere nell'#39'orario'
      OnExecute = CercaAuleLibereExecute
    end
    object CercaOrariAula: TAction
      Caption = 'Cerca'
      Hint = 'Cerca gli orari in cui sono liberi l'#39'aula e la persona'
      OnExecute = CercaOrariAulaExecute
    end
    object Prenota: TAction
      Caption = 'Prenota'
      Hint = 'Apre la prenotazione dell'#39'aula nell'#39'orario scelto'
      OnExecute = PrenotaExecute
      OnUpdate = PrenotaUpdate
    end
    object Chiudi: TAction
      Caption = 'Chiudi'
      OnExecute = ChiudiExecute
    end
  end
end
