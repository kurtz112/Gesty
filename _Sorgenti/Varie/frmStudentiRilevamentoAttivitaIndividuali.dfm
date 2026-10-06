object FormStudentiRilevamentoAttivitaIndividuali: TFormStudentiRilevamentoAttivitaIndividuali
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Rilevamento Attivit'#224' Individuali'
  ClientHeight = 114
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 17
  object OkCancel: TOkCancel
    Left = 0
    Top = 84
    Width = 331
    Height = 30
    Align = alBottom
    TabOrder = 0
    DefaultOk = False
    DefaultCancel = False
  end
  object dxLayoutControl: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 331
    Height = 84
    Align = alClient
    TabOrder = 1
    object edOrePresenza: TcxSpinEdit
      Left = 100
      Top = 12
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 0
      Width = 219
    end
    object edMateria: TcxExtLookupComboBox
      Left = 100
      Top = 43
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 1
      Width = 219
    end
    object dxLayoutControlGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemOrePresenza: TdxLayoutItem
      Parent = dxLayoutControlGroup_Root
      CaptionOptions.Text = 'Ore presenza:'
      Control = edOrePresenza
      ControlOptions.OriginalHeight = 24
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemMateria: TdxLayoutItem
      Parent = dxLayoutControlGroup_Root
      CaptionOptions.Text = 'Materia:'
      Control = edMateria
      ControlOptions.OriginalHeight = 24
      ControlOptions.OriginalWidth = 145
      ControlOptions.ShowBorder = False
      Index = 1
    end
  end
end
