object FormParametriProtocolloIncarico: TFormParametriProtocolloIncarico
  AlignWithMargins = True
  Left = 200
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Autorizzazione Incarico'
  ClientHeight = 309
  ClientWidth = 555
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 13
  object dxLayoutControl: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 555
    Height = 279
    Align = alClient
    TabOrder = 0
    object memoRiepilogo: TcxMemo
      Left = 11
      Top = 30
      Lines.Strings = (
        'memoRiepilogo')
      Style.HotTrack = False
      TabOrder = 0
      Height = 160
      Width = 533
    end
    object edDataProtocollo: TcxDateEdit
      Left = 138
      Top = 231
      Style.HotTrack = False
      TabOrder = 2
      Width = 121
    end
    object edNumeroProtocollo: TcxTextEdit
      Left = 265
      Top = 231
      Style.HotTrack = False
      TabOrder = 3
      Text = 'edNumeroProtocollo'
      Width = 132
    end
    object edDataAutorizzazione: TcxDateEdit
      Left = 11
      Top = 231
      Style.HotTrack = False
      TabOrder = 1
      Width = 121
    end
    object edParametroRicavoSpecifico: TcxSpinEdit
      Left = 403
      Top = 231
      AutoSize = False
      Properties.ValueType = vtFloat
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 4
      Height = 21
      Width = 141
    end
    object dxLayoutControlGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      ItemIndex = 1
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemRiepilogo: TdxLayoutItem
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'Riepilogo Incarico:'
      CaptionOptions.Layout = clTop
      Control = memoRiepilogo
      ControlOptions.OriginalHeight = 89
      ControlOptions.OriginalWidth = 185
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemDataProtocollo: TdxLayoutItem
      Parent = dxLayoutGroup
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = 'Data Protocollo:'
      CaptionOptions.Layout = clTop
      Control = edDataProtocollo
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemNumeroProtocollo: TdxLayoutItem
      Parent = dxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'Numero Protocollo:'
      CaptionOptions.Layout = clTop
      Control = edNumeroProtocollo
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutGroup: TdxLayoutGroup
      Parent = dxLayoutControlGroup_Root
      AlignHorz = ahClient
      AlignVert = avBottom
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      ItemIndex = 3
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem
      Parent = dxLayoutControlGroup_Root
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 3
    end
    object dxLayoutEmptySpaceItem2: TdxLayoutEmptySpaceItem
      Parent = dxLayoutControlGroup_Root
      AlignVert = avBottom
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 2
    end
    object dxLayoutItemDataAutorizzazione: TdxLayoutItem
      Parent = dxLayoutGroup
      CaptionOptions.Text = 'Data Autorizzazione:'
      CaptionOptions.Layout = clTop
      Control = edDataAutorizzazione
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemParametroRicavo: TdxLayoutItem
      Parent = dxLayoutGroup
      AlignVert = avClient
      CaptionOptions.Text = 'Parametro Ricavo Specifico:'
      CaptionOptions.Layout = clTop
      Control = edParametroRicavoSpecifico
      ControlOptions.OriginalHeight = 21
      ControlOptions.OriginalWidth = 141
      ControlOptions.ShowBorder = False
      Index = 3
    end
  end
  object OkCancel: TOkCancel
    Left = 0
    Top = 279
    Width = 555
    Height = 30
    Align = alBottom
    TabOrder = 1
    DefaultOk = False
    DefaultCancel = False
  end
end
