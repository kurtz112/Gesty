inherited FormBudget: TFormBudget
  Caption = 'FormBudget'
  ClientHeight = 496
  ClientWidth = 790
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 806
  ExplicitHeight = 535
  TextHeight = 15
  object layoutCercaPerProgetto: TdxLayoutControl [1]
    Left = 150
    Top = 150
    Width = 500
    Height = 49
    TabOrder = 5
    object edProgettoPerProgetto: TcxTextEdit
      Left = 67
      Top = 12
      TabOrder = 0
      Width = 300
    end
    object btnCercaPerProgetto: TcxButton
      Left = 374
      Top = 12
      Width = 75
      Height = 25
      Action = CercaPerProgetto
      TabOrder = 1
    end
    object layoutCercaPerProgettoGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemProgetto: TdxLayoutItem
      Parent = dxLayoutGroup2
      CaptionOptions.Text = 'Progetto:'
      Control = edProgettoPerProgetto
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 300
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemBtnCercaPerProgetto: TdxLayoutItem
      Parent = dxLayoutGroup2
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = btnCercaPerProgetto
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGroup2: TdxLayoutGroup
      Parent = layoutCercaPerProgettoGroup_Root
      CaptionOptions.Text = 'New Group'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
  end
  object edMese: TcxComboBox [2]
    Left = 0
    Top = 22
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
    TabOrder = 6
    Width = 120
  end
  object edAnno: TcxSpinEdit [3]
    Left = 0
    Top = 44
    ParentFont = False
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -13
    Style.Font.Name = 'Segoe UI'
    Style.Font.Style = []
    Style.HotTrack = False
    Style.IsFontAssigned = True
    TabOrder = 7
    Value = 2000
    Width = 60
  end
  object layoutCercaPerEsercizio: TdxLayoutControl [4]
    Left = 150
    Top = 230
    Width = 500
    Height = 49
    TabOrder = 8
    object edProgettoPerEsercizio: TcxTextEdit
      Left = 67
      Top = 12
      TabOrder = 0
      Width = 300
    end
    object btnCercaPerEsercizio: TcxButton
      Left = 374
      Top = 12
      Width = 75
      Height = 25
      Action = CercaPerEsercizio
      TabOrder = 1
    end
    object dxLayoutGroup1: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemProgettoPerEsercizio: TdxLayoutItem
      Parent = dxLayoutGroup3
      CaptionOptions.Text = 'Progetto:'
      Control = edProgettoPerEsercizio
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 300
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemCercaPerEsercizio: TdxLayoutItem
      Parent = dxLayoutGroup3
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = btnCercaPerEsercizio
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGroup3: TdxLayoutGroup
      Parent = dxLayoutGroup1
      CaptionOptions.Text = 'New Group'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
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
      DockedLeft = 193
    end
    object dxBarButton1: TdxBarButton
      Action = ElaboraCostiRicavi
      Category = 0
    end
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = zDmImages.ImageList16
    Left = 208
    Top = 56
    object ElaboraCostiRicavi: TAction
      Caption = 'Elabora Costi/Ricavi'
      ImageIndex = 269
      OnExecute = ElaboraCostiRicaviExecute
    end
    object CercaPerProgetto: TAction
      Caption = 'Cerca'
      ImageIndex = 32
      OnExecute = CercaPerProgettoExecute
    end
    object CercaPerEsercizio: TAction
      Caption = 'Cerca'
      ImageIndex = 32
      OnExecute = CercaPerEsercizioExecute
    end
  end
end
