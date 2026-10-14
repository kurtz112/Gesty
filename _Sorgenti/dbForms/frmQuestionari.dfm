inherited FormQuestionari: TFormQuestionari
  Caption = 'Questionari'
  ClientHeight = 464
  ClientWidth = 1132
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 1148
  ExplicitHeight = 503
  TextHeight = 15
  object layoutFiltri: TdxLayoutControl [1]
    Left = 152
    Top = 72
    Width = 857
    Height = 145
    TabOrder = 5
    AutoSize = True
    object edFiltroEnte: TcxImageComboBox
      Left = 133
      Top = 12
      Properties.Items = <>
      Properties.OnEditValueChanged = edFiltroEntePropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 0
      Width = 179
    end
    object edFiltroAnnoFormativoProgetto: TcxImageComboBox
      Left = 133
      Top = 42
      Properties.Items = <>
      Properties.OnEditValueChanged = edFiltroAnnoFromativoPropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 3
      Width = 179
    end
    object edFiltroProgetto: TcxExtLookupComboBox
      Left = 396
      Top = 42
      Properties.ImmediatePost = True
      Properties.OnEditValueChanged = edFiltroProgettoPropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 4
      Width = 432
    end
    object edFiltroCorso: TcxExtLookupComboBox
      Left = 396
      Top = 72
      Properties.ImmediatePost = True
      Properties.OnEditValueChanged = edFiltroCorsoPropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 6
      Width = 432
    end
    object edFiltroAreaRiferimento: TcxImageComboBox
      Left = 648
      Top = 12
      Properties.ImmediatePost = True
      Properties.Items = <>
      Properties.OnEditValueChanged = edFiltroAreaRiferimentoPropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 2
      Width = 180
    end
    object edFiltroDocente: TcxExtLookupComboBox
      Left = 396
      Top = 104
      Properties.ImmediatePost = True
      Properties.OnEditValueChanged = edFiltroDocentePropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 8
      Width = 275
    end
    object edFiltroQuestionario: TcxExtLookupComboBox
      Left = 396
      Top = 12
      Properties.OnEditValueChanged = edFiltroQuestionarioPropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 1
      Width = 147
    end
    object btnGeneraReportCustom: TcxButton
      Left = 678
      Top = 102
      Width = 150
      Height = 25
      Action = GeneraReport
      TabOrder = 9
    end
    object edFiltroRaggruppamento: TcxExtLookupComboBox
      Left = 133
      Top = 104
      Properties.OnEditValueChanged = edFiltroRaggruppamentoPropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 7
      Width = 179
    end
    object edFiltroAnnoFormativoCorso: TcxImageComboBox
      Left = 133
      Top = 72
      Properties.Items = <>
      Properties.OnEditValueChanged = edFiltroAnnoFormativoCorsoPropertiesEditValueChanged
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 5
      Width = 179
    end
    object layoutFiltriGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avTop
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemEnte: TdxLayoutItem
      Parent = dxLayoutGroupTop
      AlignHorz = ahLeft
      AlignVert = avBottom
      SizeOptions.Width = 300
      CaptionOptions.Text = 'Ente:'
      Control = edFiltroEnte
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 179
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemAnnoFormativoProgetto: TdxLayoutItem
      Parent = dxLayoutGroupProgetto
      AlignHorz = ahLeft
      AlignVert = avBottom
      SizeOptions.Width = 300
      CaptionOptions.Text = 'Anno Form. Progetto:'
      Control = edFiltroAnnoFormativoProgetto
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 179
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemProgetto: TdxLayoutItem
      Parent = dxLayoutGroupProgetto
      AlignHorz = ahClient
      AlignVert = avBottom
      CaptionOptions.Text = 'Progetto:'
      Control = edFiltroProgetto
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 145
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemCorso: TdxLayoutItem
      Parent = dxLayoutGroupCorso
      AlignHorz = ahClient
      AlignVert = avBottom
      CaptionOptions.Text = 'Corso:'
      Control = edFiltroCorso
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 145
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemAreaRiferimento: TdxLayoutItem
      Parent = dxLayoutGroupTop
      AlignHorz = ahRight
      AlignVert = avBottom
      CaptionOptions.Text = 'Area Riferimento:'
      Control = edFiltroAreaRiferimento
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 180
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemDocente: TdxLayoutItem
      Parent = dxLayoutGroupBottom
      AlignHorz = ahClient
      AlignVert = avBottom
      SizeOptions.Width = 300
      CaptionOptions.Text = 'Docente:'
      Control = edFiltroDocente
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 180
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupTop: TdxLayoutGroup
      Parent = dxLayoutGroupMain
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupBottom: TdxLayoutGroup
      Parent = dxLayoutGroupMain
      AlignHorz = ahClient
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 3
    end
    object dxLayoutItemQuestionario: TdxLayoutItem
      Parent = dxLayoutGroupTop
      AlignHorz = ahClient
      AlignVert = avBottom
      CaptionOptions.Text = 'Questionario:'
      Control = edFiltroQuestionario
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 180
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutGroupProgetto: TdxLayoutGroup
      Parent = dxLayoutGroupMain
      CaptionOptions.Text = 'New Group'
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object dxLayoutItemGeneraReportCustom: TdxLayoutItem
      Parent = dxLayoutGroupBottom
      AlignHorz = ahRight
      AlignVert = avBottom
      CaptionOptions.AlignVert = tavTop
      CaptionOptions.Text = 'Nuovo oggetto'
      CaptionOptions.Visible = False
      Control = btnGeneraReportCustom
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 150
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemRaggruppamento: TdxLayoutItem
      Parent = dxLayoutGroupBottom
      AlignHorz = ahLeft
      AlignVert = avBottom
      SizeOptions.Width = 300
      CaptionOptions.Text = 'Raggruppamento:'
      Control = edFiltroRaggruppamento
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 179
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupCorso: TdxLayoutGroup
      Parent = dxLayoutGroupMain
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 2
    end
    object dxLayoutItemAnnoFormativoCorso: TdxLayoutItem
      Parent = dxLayoutGroupCorso
      AlignVert = avBottom
      SizeOptions.Width = 300
      CaptionOptions.Text = 'Anno Form. Corso:'
      Control = edFiltroAnnoFormativoCorso
      ControlOptions.OriginalHeight = 23
      ControlOptions.OriginalWidth = 179
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutGroupMain: TdxLayoutGroup
      Parent = layoutFiltriGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      ShowBorder = False
      Index = 0
    end
    object dxLayoutEmptySpaceItem: TdxLayoutEmptySpaceItem
      Parent = layoutFiltriGroup_Root
      SizeOptions.Height = 10
      SizeOptions.Width = 10
      CaptionOptions.Text = 'Empty Space Item'
      Index = 1
    end
  end
  inherited dxBarManager: TdxBarManager
    PixelsPerInch = 96
    inherited barSistema: TdxBar
      DockedLeft = 120
    end
    object dxBarLargeButton1: TdxBarLargeButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
  end
  inherited popActions: TdxBarPopupMenu
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = dx.Immagini
    Left = 336
    Top = 176
    object GeneraQuestionari: TAction
      Caption = 'Genera Questionari'
      ImageIndex = 1573
      OnExecute = GeneraQuestionariExecute
    end
    object CopiaLinkSuClipboard: TAction
      Caption = 'Copia Link Nella Clipboard'
      ImageIndex = 1271
      OnExecute = CopiaLinkSuClipboardExecute
    end
    object SalvaLinkSuFile: TAction
      Caption = 'Salva Link Su File'
      ImageIndex = 1756
      OnExecute = SalvaLinkSuFileExecute
    end
    object DuplicaQuestionario: TAction
      Caption = 'Duplica Questionario'
      ImageIndex = 1572
      OnExecute = DuplicaQuestionarioExecute
    end
    object Test_Questionario: TAction
      Caption = 'Test_Questionario'
      ImageIndex = 1571
      OnExecute = Test_QuestionarioExecute
    end
    object Test_Progetto: TAction
      Caption = 'Test'
      ImageIndex = 40
      OnExecute = Test_ProgettoExecute
    end
    object GeneraReport: TdxFileOpen
      Caption = 'Genera Report'
      Dialog.DefaultExt = '*.xlsx'
      Dialog.Filter = 'Excel |*.xlsx|Tutti|*.*'
      ImageIndex = 1903
      BeforeExecute = GeneraReportBeforeExecute
      OnAccept = GeneraReportAccept
    end
  end
  object ProgressBox: TProgressBox
    MaxValue = 0
    Progress = 0
    CancelEnabled = True
    Left = 39
    Top = 240
  end
end
