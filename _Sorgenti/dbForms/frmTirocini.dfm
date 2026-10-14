inherited FormTirocini: TFormTirocini
  Caption = 'FormTirocini'
  ClientHeight = 464
  ClientWidth = 797
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 813
  ExplicitHeight = 503
  TextHeight = 15
  object layoutPagamentiMese: TdxLayoutControl [1]
    Left = 20
    Top = 168
    Width = 613
    Height = 70
    TabOrder = 5
    object edMese: TcxComboBox
      Left = 49
      Top = 24
      ParentFont = False
      Properties.DropDownListStyle = lsEditFixedList
      Properties.DropDownRows = 12
      Properties.ImmediateDropDownWhenActivated = True
      Properties.ImmediatePost = True
      Properties.Revertable = True
      Properties.OnEditValueChanged = edMesePropertiesEditValueChanged
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
    object edAnno: TcxSpinEdit
      Left = 214
      Top = 24
      ParentFont = False
      Properties.ImmediatePost = True
      Properties.OnEditValueChanged = edAnnoPropertiesEditValueChanged
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
    object btnElaboraIndennitaMese: TcxButton
      Left = 281
      Top = 24
      Width = 90
      Height = 25
      Action = ElaboraIndennitaMese
      TabOrder = 2
    end
    object btnEsportaIndennitaMese: TcxButton
      Left = 378
      Top = 24
      Width = 90
      Height = 25
      Action = EsportaIndennitaMese
      TabOrder = 3
    end
    object layoutPagamentiMeseGroup_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Hidden = True
      ItemIndex = 1
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItemMese: TdxLayoutItem
      Parent = dxLayoutGroup1
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = 'Mese:'
      Control = edMese
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 120
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItemAnno: TdxLayoutItem
      Parent = dxLayoutGroup1
      CaptionOptions.Text = 'Anno:'
      Control = edAnno
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 60
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItemElaboraIndennitaMese: TdxLayoutItem
      Parent = dxLayoutGroup1
      CaptionOptions.Text = 'cxButton1'
      CaptionOptions.Visible = False
      Control = btnElaboraIndennitaMese
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 90
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItemEsportaIndennitaMese: TdxLayoutItem
      Parent = dxLayoutGroup1
      CaptionOptions.Text = 'New Item'
      CaptionOptions.Visible = False
      Control = btnEsportaIndennitaMese
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 90
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutEmptySpaceItem1: TdxLayoutEmptySpaceItem
      Parent = layoutPagamentiMeseGroup_Root
      SizeOptions.Height = 5
      CaptionOptions.Text = 'Empty Space Item'
      Index = 0
    end
    object dxLayoutGroup1: TdxLayoutGroup
      Parent = layoutPagamentiMeseGroup_Root
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'New Group'
      CaptionOptions.Visible = False
      LayoutDirection = ldHorizontal
      ShowBorder = False
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
    Images = dx.Immagini
    Left = 216
    Top = 88
    object NuovaAziendaOspitante: TAction
      Caption = 'Nuova Azienda Ospitante'
      ImageIndex = 1913
      OnExecute = NuovaAziendaOspitanteExecute
    end
    object GeneraTutorAziendale: TAction
      Caption = 'Genera Tutor Aziendale'
      ImageIndex = 1666
    end
    object ElaboraIndennitaMese: TAction
      Caption = 'Elabora'
      ImageIndex = 165
      OnExecute = ElaboraIndennitaMeseExecute
    end
    object EsportaIndennitaMese: TFileSaveAs
      Caption = 'Esporta'
      Dialog.DefaultExt = '*.xlsx'
      Dialog.Filter = 'Excel|*.xlsx|Tutti|*.*'
      ImageIndex = 221
      BeforeExecute = EsportaIndennitaMeseBeforeExecute
      OnAccept = EsportaIndennitaMeseAccept
    end
    object GeneraCalendarioStage: TAction
      Caption = 'Genera Calendario'
      ImageIndex = 1253
      OnExecute = GeneraCalendarioStageExecute
    end
    object SettimanaPrecedente: TAction
      Caption = 'Precedente'
      ImageIndex = 171
    end
    object SettimanaSuccessiva: TAction
      Caption = 'Successiva'
      ImageIndex = 163
    end
    object ApriRendicontazione: TAction
      Caption = 'Apri Rendicontazione'
      ImageIndex = 1358
      OnExecute = ApriRendicontazioneExecute
    end
    object CreaUtenteSistemaStudente: TAction
      Caption = 'Crea Utente Sistema'
      ImageIndex = 1827
      OnExecute = CreaUtenteSistemaStudenteExecute
    end
    object CreaUtenteSistemaTutor: TAction
      Caption = 'Crea Utente Sistema'
      ImageIndex = 1827
      OnExecute = CreaUtenteSistemaTutorExecute
    end
  end
end
