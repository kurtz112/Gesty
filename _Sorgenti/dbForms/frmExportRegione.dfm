inherited FormExportRegione: TFormExportRegione
  Caption = 'FormExportRegione'
  ClientWidth = 925
  OnCreate = FormCreate
  ExplicitWidth = 941
  PixelsPerInch = 96
  TextHeight = 15
  object LayoutExportRegione: TdxLayoutControl [1]
    Left = 124
    Top = 184
    Width = 721
    Height = 60
    TabOrder = 5
    object edDalGiorno: TcxDateEdit
      Left = 77
      Top = 24
      ParentFont = False
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
      Properties.OnEditValueChanged = edDalGiornoPropertiesEditValueChanged
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
      TabOrder = 0
      Width = 150
    end
    object edAlGiorno: TcxDateEdit
      Left = 293
      Top = 24
      ParentFont = False
      Properties.ImmediatePost = True
      Properties.SaveTime = False
      Properties.ShowTime = False
      Properties.WeekNumbers = True
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
      TabOrder = 1
      Width = 150
    end
    object btnApriExport: TcxButton
      Left = 450
      Top = 13
      Width = 120
      Height = 35
      Action = Apri
      TabOrder = 2
    end
    object btnExportRegione: TcxButton
      Left = 577
      Top = 13
      Width = 120
      Height = 35
      Action = Esporta
      TabOrder = 3
    end
    object LayoutExportRegioneGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemDalGiorno: TdxLayoutItem
      Parent = LayoutExportRegioneGroup_Root
      AlignVert = avBottom
      CaptionOptions.Text = 'Dal Giorno:'
      Control = edDalGiorno
      ControlOptions.OriginalHeight = 24
      ControlOptions.OriginalWidth = 150
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemAlGiorno: TdxLayoutItem
      Parent = LayoutExportRegioneGroup_Root
      AlignVert = avBottom
      CaptionOptions.Text = 'Al Giorno:'
      Control = edAlGiorno
      ControlOptions.OriginalHeight = 24
      ControlOptions.OriginalWidth = 150
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemApriExport: TdxLayoutItem
      Parent = LayoutExportRegioneGroup_Root
      AlignVert = avBottom
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnApriExport
      ControlOptions.OriginalHeight = 35
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemExportRegione: TdxLayoutItem
      Parent = LayoutExportRegioneGroup_Root
      AlignVert = avBottom
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnExportRegione
      ControlOptions.OriginalHeight = 35
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 3
    end
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 224
    Top = 88
    object Apri: TAction
      Caption = 'Apri'
      ImageIndex = 34
      OnExecute = ApriExecute
    end
    object Esporta: TdxFileSaveAs
      Caption = 'Export Regione'
      Dialog.DefaultExt = '*.xlsx'
      Dialog.Filter = 'File Excel|*.xlsx|Tutti|*.*'
      Dialog.Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
      ImageIndex = 1637
      OnAccept = EsportaAccept
    end
  end
end
