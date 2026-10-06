object FormConfig: TFormConfig
  Left = 0
  Top = 0
  Caption = 'Configurazione'
  ClientHeight = 498
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object dxLayoutControl: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 489
    Height = 498
    Align = alClient
    TabOrder = 0
    LayoutLookAndFeel = dxLayoutSkinLookAndFeel
    ExplicitWidth = 485
    ExplicitHeight = 497
    object cxRTTIInspector: TcxRTTIInspector
      Left = 12
      Top = 12
      Width = 465
      Height = 442
      LookAndFeel.NativeStyle = False
      OptionsView.RowHeaderWidth = 200
      OptionsView.Sorted = False
      TabOrder = 0
      Version = 1
    end
    object btnOk: TcxButton
      Left = 320
      Top = 461
      Width = 75
      Height = 25
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 1
    end
    object btnCancel: TcxButton
      Left = 402
      Top = 461
      Width = 75
      Height = 25
      Caption = 'Annulla'
      ModalResult = 2
      TabOrder = 2
    end
    object dxLayoutControlGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItem1: TdxLayoutItem
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'cxRTTIInspector1'
      CaptionOptions.Visible = False
      Control = cxRTTIInspector
      ControlOptions.OriginalHeight = 200
      ControlOptions.OriginalWidth = 150
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItem2: TdxLayoutItem
      Parent = dxLayoutGroup1
      AlignHorz = ahRight
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = btnOk
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItem3: TdxLayoutItem
      Parent = dxLayoutGroup1
      AlignHorz = ahRight
      CaptionOptions.Text = 'cxButton2'
      CaptionOptions.Visible = False
      Control = btnCancel
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGroup1: TdxLayoutGroup
      Parent = dxLayoutControlGroup_Root
      CaptionOptions.Text = 'New Group'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
  end
  object dxLayoutLookAndFeelList: TdxLayoutLookAndFeelList
    Left = 96
    Top = 72
    object dxLayoutSkinLookAndFeel: TdxLayoutSkinLookAndFeel
      PixelsPerInch = 96
    end
  end
end
