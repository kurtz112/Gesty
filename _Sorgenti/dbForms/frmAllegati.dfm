inherited FormAllegati: TFormAllegati
  Caption = 'FormAllegati'
  ClientWidth = 731
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 747
  TextHeight = 15
  object layoutCerca: TdxLayoutControl [1]
    Left = 128
    Top = 200
    Width = 441
    Height = 49
    TabOrder = 5
    object edCerca: TcxTextEdit
      Left = 51
      Top = 13
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 0
      Width = 281
    end
    object btnCerca: TcxButton
      Left = 339
      Top = 12
      Width = 90
      Height = 25
      Action = Cerca
      TabOrder = 1
    end
    object layoutCercaGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemBtnCerca: TdxLayoutItem
      Parent = layoutCercaGroup_Root
      AlignHorz = ahRight
      AlignVert = avCenter
      CaptionOptions.Visible = False
      Control = btnCerca
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 90
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemEdCerca: TdxLayoutItem
      Parent = layoutCercaGroup_Root
      AlignHorz = ahClient
      AlignVert = avCenter
      CaptionOptions.Text = 'Cerca:'
      Control = edCerca
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 250
      ControlOptions.ShowBorder = False
      Index = 0
    end
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 192
    Top = 64
    object Cerca: TAction
      Caption = 'Cerca'
      ImageIndex = 2309
      OnExecute = CercaExecute
    end
    object IndicizzaAllegatiSenzaTesto: TAction
      Caption = 'Indicizza Tutti'
      ImageIndex = 1890
      OnExecute = IndicizzaAllegatiSenzaTestoExecute
    end
    object IndicizzaAllegatoSelezionato: TAction
      Caption = 'Indicizza Selezionato'
      ImageIndex = 1889
      OnExecute = IndicizzaAllegatoSelezionatoExecute
    end
  end
end
