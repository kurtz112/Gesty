inherited FormRicercaProfili: TFormRicercaProfili
  Caption = 'Ricerca Profili'
  ClientHeight = 465
  ClientWidth = 980
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 996
  ExplicitHeight = 504
  TextHeight = 15
  object edEtaMin: TcxSpinEdit [1]
    Left = 416
    Top = 232
    TabOrder = 5
    Width = 121
  end
  object edEtaMax: TcxSpinEdit [2]
    Left = 416
    Top = 272
    TabOrder = 6
    Width = 121
  end
  object edCap: TcxSpinEdit [3]
    Left = 416
    Top = 352
    Properties.AssignedValues.MinValue = True
    TabOrder = 7
    Width = 121
  end
  object edSesso: TcxComboBox [4]
    Left = 424
    Top = 400
    TabOrder = 8
    Text = 'edSesso'
    Width = 121
  end
  object layoutFiltri: TdxLayoutControl [5]
    Left = 92
    Top = 72
    Width = 821
    Height = 105
    TabOrder = 9
    object edMese: TcxComboBox
      Left = 49
      Top = 12
      ParentFont = False
      Properties.DropDownListStyle = lsEditFixedList
      Properties.DropDownRows = 12
      Properties.ImmediateDropDownWhenActivated = True
      Properties.ImmediatePost = True
      Properties.Revertable = True
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 120
    end
    object edProgetto: TcxExtLookupComboBox
      Left = 336
      Top = 12
      Properties.ImmediateDropDownWhenActivated = True
      Properties.ImmediatePost = True
      EditValue = 0
      TabOrder = 2
      Width = 450
    end
    object edAnno: TcxSpinEdit
      Left = 214
      Top = 12
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -13
      Style.Font.Name = 'Segoe UI'
      Style.Font.Style = []
      Style.HotTrack = False
      Style.IsFontAssigned = True
      TabOrder = 1
      Value = 2000
      Width = 60
    end
    object layoutFiltriGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemMese: TdxLayoutItem
      Parent = layoutFiltriGroup_Root
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = 'Mese:'
      Control = edMese
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemProgetto: TdxLayoutItem
      Parent = layoutFiltriGroup_Root
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = 'Progetto:'
      Control = edProgetto
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 450
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemAnno: TdxLayoutItem
      Parent = layoutFiltriGroup_Root
      CaptionOptions.Text = 'Anno:'
      Control = edAnno
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 60
      ControlOptions.ShowBorder = False
      Index = 1
    end
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList24
    Left = 296
    Top = 160
  end
end
